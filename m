Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6467242BA0E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 10:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbhJMITr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 04:19:47 -0400
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:41246 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238885AbhJMITo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 04:19:44 -0400
Received: from omf13.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id B860E100E7B55;
        Wed, 13 Oct 2021 08:17:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 20B1A1124F6;
        Wed, 13 Oct 2021 08:17:32 +0000 (UTC)
Message-ID: <3c060010a6100aec264f7ad984d2c6920e628a42.camel@perches.com>
Subject: Re: Use of '%#02x' is almost always wrong
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Date:   Wed, 13 Oct 2021 01:17:30 -0700
In-Reply-To: <20211013061547.GG8429@kadam>
References: <b04a10ea9682c51764053c1be73d4b3be59d1e7f.camel@perches.com>
         <20211013061547.GG8429@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 20B1A1124F6
X-Spam-Status: No, score=0.10
X-Stat-Signature: m1y7herwymfyqngs6xfkd4uu5791ye86
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+Zb3hrSvPg4j5uiwukw2qSeLjEWS9ZoJ8=
X-HE-Tag: 1634113052-11164
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-10-13 at 09:15 +0300, Dan Carpenter wrote:
> On Sun, Oct 10, 2021 at 09:45:30AM -0700, Joe Perches wrote:
> > Perhaps too many developers do not know that using '%#<width>x'
> > in printf output _includes_ the 0x prefix in the output width.
> > 
> 
> This is a good point.  Presumably you're going to add it to checkpatch.pl?

Yeah.  Something like the below:

> I looked at '%#04x' and you would think those would all be printing char
> types but some are printing shorts.  :/  It's harder to deal with that
> because 50% are correct from the tiny sample I looked at.

That'd be difficult as checkpatch doesn't know format argument types.
---
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c27d2312cfc30..97deae9dafcdc 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6703,7 +6703,7 @@ sub process {
 			}
 		}
 
-# check for vsprintf extension %p<foo> misuses
+# check for vsprintf format and extension %p<foo> misuses
 		if ($perl_version_ok &&
 		    defined $stat &&
 		    $stat =~ /^\+(?![^\{]*\{\s*).*\b(\w+)\s*\(.*$String\s*,/s &&
@@ -6720,6 +6720,18 @@ sub process {
 				my $fmt = get_quoted_string($lines[$count - 1], raw_line($count, 0));
 				$fmt =~ s/%%//g;
 
+				# check for %# (0x prefixed) width too small
+				while ($fmt =~ /(%#0?([123])([xX]))/g) {
+					my $hex = $1;
+					my $width = $2;
+					my $case = $3;
+					if (!defined($stat_real)) {
+						$stat_real = get_stat_real($linenr, $lc);
+					}
+					WARN("VSPRINTF_HEX_WIDTH",
+					     "hex specifier '$hex' - output width '$width' does not include the '0$case' prefix, width should be probably be increased\n" . "$here\n$stat_real");
+				}
+				pos($fmt) = 0;
 				while ($fmt =~ /(\%[\*\d\.]*p(\w)(\w*))/g) {
 					$specifier = $1;
 					$extension = $2;


