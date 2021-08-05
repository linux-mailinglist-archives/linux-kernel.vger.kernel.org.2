Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42EF3E14B2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241349AbhHEM1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 08:27:47 -0400
Received: from smtprelay0078.hostedemail.com ([216.40.44.78]:33292 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232651AbhHEM1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:27:45 -0400
Received: from omf15.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 63CA8182CED34;
        Thu,  5 Aug 2021 12:27:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 41D76C4198;
        Thu,  5 Aug 2021 12:27:29 +0000 (UTC)
Message-ID: <117021b44dc9ba570a0f48736d14a267a8701d0a.camel@perches.com>
Subject: Re: [PATCH] checkpatch: prefer = {} initializations to = {0}
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Thu, 05 Aug 2021 05:27:27 -0700
In-Reply-To: <20210805104353.GD26417@kili>
References: <20210805104353.GD26417@kili>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 41D76C4198
X-Spam-Status: No, score=1.60
X-Stat-Signature: 19jra4oyxb396bdarmmie9t11pmu9bat
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/VnOD3R1k9CkP2tisGCaPwq765oheBGSk=
X-HE-Tag: 1628166449-838849
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-08-05 at 13:43 +0300, Dan Carpenter wrote:
> The "= {};" style empty struct initializer is preferred over = {0}.
> It avoids the situation where the first struct member is a pointer and
> that generates a Sparse warning about assigning using zero instead of
> NULL.  Also it's just nicer to look at.
> 
> Some people complain that {} is less portable but the kernel has
> different portability requirements from userspace so this is not a
> issue that we care about.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -4029,6 +4029,12 @@ sub process {
>  			     "Using $1 is unnecessary\n" . $herecurr);
>  		}
> 
> +# prefer = {}; to = {0};
> +		if ($line =~ /= \{ *0 *\}/) {

Have you done a grep and looked at this pattern's actual use in the kernel?
I rather doubt it.

> +			WARN("ZERO_INITIALIZER",
> +			     "= {} is preferred over = {0}\n" . $herecurr);
> +		}
> +

To be much more specific to the actual desired match as stated in
the possible commit log, this should probably be something like:

	if (defined($stat) &&
	    $stat =~ /^\+\s+$Declare\s*$Ident\s*=\s*\{\s*0\s*\}\s*;/) {

and maybe it should be a --strict CHK and not WARN.

And I generally avoid using "we" in a commit message.

Maybe something like:
---
 scripts/checkpatch.pl | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 461d4221e4a4a..e3d4aa5f86c46 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6911,6 +6911,21 @@ sub process {
 			     "externs should be avoided in .c files\n" .  $herecurr);
 		}
 
+# check for non-global single initializers with '= {0};', prefer '= {};'
+# there is already a GLOBAL_INITIALIZERS test so avoid those too with /^\+\s+/
+		if (defined($stat) &&
+		    $stat =~ /^\+\s+$Declare\s*$Ident\s*(=\s*\{\s*0\s*\}\s*);/) {
+			my $match = $1;
+			my $cnt = statement_rawlines($stat);
+			my $herectx = get_stat_here($linenr, $cnt, $here);
+			if (WARN("ZERO_INITIALIZER",
+				 "Prefer '= {}' over '$match'\n" . $herectx) &&
+			    $fix &&
+			    $cnt == 1) {	# can only --fix single line statements
+				$fixed[$fixlinenr] =~ s/\s*=\s*\{\s*0\s*\}\s*;/ = {};/;
+			}
+		}
+
 # check for function declarations that have arguments without identifier names
 		if (defined $stat &&
 		    $stat =~ /^.\s*(?:extern\s+)?$Type\s*(?:$Ident|\(\s*\*\s*$Ident\s*\))\s*\(\s*([^{]+)\s*\)\s*;/s &&

