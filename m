Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEDE43C65C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 11:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhJ0JYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 05:24:20 -0400
Received: from smtprelay0194.hostedemail.com ([216.40.44.194]:47284 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229699AbhJ0JYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 05:24:18 -0400
Received: from omf12.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id ED9CD182CCFC9;
        Wed, 27 Oct 2021 09:21:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id E7717240239;
        Wed, 27 Oct 2021 09:21:51 +0000 (UTC)
Message-ID: <83b27d29bc19f146f7fdfede24786ef01076fcd3.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Remove cvs keyword check
From:   Joe Perches <joe@perches.com>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     apw@canonical.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev
Date:   Wed, 27 Oct 2021 02:21:50 -0700
In-Reply-To: <20211027073542.qxbu236cg2wic25n@kari-VirtualBox>
References: <20211026231637.3750-1-kari.argillander@gmail.com>
         <868c29d45172a151b6a751de4ba32165cbf7a4cc.camel@perches.com>
         <20211027073542.qxbu236cg2wic25n@kari-VirtualBox>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: E7717240239
X-Spam-Status: No, score=-1.18
X-Stat-Signature: kwgr96gmjyk6a5n3b8o5ac3aezwtitp3
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18yOmW2Nqoj78JaWFX5tq/fBLk6mdVaKk0=
X-HE-Tag: 1635326511-284707
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-10-27 at 10:35 +0300, Kari Argillander wrote:
> On Tue, Oct 26, 2021 at 05:26:21PM -0700, Joe Perches wrote:
> > On Wed, 2021-10-27 at 02:16 +0300, Kari Argillander wrote:
> > > Time has pass and we do not need these anymore as almost all people are
> > > using git now days. Those who use cvs for kernel development probably
> > > will handle cvs pretty well already so this check is not needed anymore.
> > 
> > I think it's a relatively harmless thing to keep.
> > 
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -4017,12 +4017,6 @@ sub process {
> > >  			}
> > >  		}
> > >  
> > > -# check for RCS/CVS revision markers
> > > -		if ($rawline =~ /^\+.*\$(Revision|Log|Id)(?:\$|)/) {
> > 
> > Looks like this would be better using
> > 
> > 		if ($rawline =~ /^\+.*\b\$(?:Revision|Log|Id)\$?\b/) {
> As I say before I do not know much about cvs or perl regex, but I do not
> get any match with your suggestion

Meh.  The regex doesn't like the \b before and after the $

This seems better:
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1784921c645da..40552da610019 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4063,7 +4063,7 @@ sub process {
 		}
 
 # check for RCS/CVS revision markers
-		if ($rawline =~ /^\+.*\$(Revision|Log|Id)(?:\$|)/) {
+		if ($rawline =~ /^\+.*\$(?:Revision|Log|Id)(?::.*)?\$/) {
 			WARN("CVS_KEYWORD",
 			     "CVS style keyword markers, these will _not_ be updated\n". $herecurr);
 		}


