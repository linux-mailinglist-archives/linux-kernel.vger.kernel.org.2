Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63468306325
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 19:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbhA0SWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 13:22:25 -0500
Received: from smtprelay0180.hostedemail.com ([216.40.44.180]:50424 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235711AbhA0SWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 13:22:18 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id EC021100E7B4B;
        Wed, 27 Jan 2021 18:21:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3865:3866:3867:3871:3872:3874:4321:4823:5007:6742:7652:7903:10004:10400:10848:11232:11658:11914:12297:12555:12663:12760:12986:13069:13311:13357:13439:14093:14097:14181:14659:14721:21080:21221:21433:21451:21627:21740:21939:30054:30083,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: wire77_23102f827599
X-Filterd-Recvd-Size: 2760
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Wed, 27 Jan 2021 18:21:31 +0000 (UTC)
Message-ID: <2efe84eefdfd21da68d323a6e32b4ad84bc0fa6b.camel@perches.com>
Subject: Re: [PATCH v10] staging: fbtft: add tearing signal detect
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     carlis <zhangxuezhi3@gmail.com>,
        Andy Whitcroft <apw@canonical.com>, devel@driverdev.osuosl.org,
        linux-fbdev@vger.kernel.org, mh12gx2825@gmail.com,
        oliver.graute@kococonnector.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, sbrivio@redhat.com,
        colin.king@canonical.com, zhangxuezhi1@yulong.com
Date:   Wed, 27 Jan 2021 10:21:30 -0800
In-Reply-To: <20210127144946.GF2696@kadam>
References: <1611754972-151016-1-git-send-email-zhangxuezhi3@gmail.com>
         <YBFv+12xfsoxacDb@kroah.com> <20210127220809.000026fb@gmail.com>
         <YBF08Xf7qaZx3YZ1@kroah.com> <20210127221708.00002568@gmail.com>
         <YBF30EEUkhEMY5ti@kroah.com> <20210127144946.GF2696@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Comments are the exception to the "no spaces at the start of a line"
> rule.  I was expecting that the kbuild-bot would send a Smatch warning
> for inconsistent indenting, but comments are not counted there either.
> 
> I'm sort of surprised that we don't have checkpatch rule about the
> missing space characters.  It should be: "/* Tearing Effect Line On */".

Maybe this but the "preceded by a tab" test is pretty noisy.

---
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4f8494527139..72347e82d384 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3720,6 +3720,22 @@ sub process {
 				    s/(\(\s*$Type\s*\))[ \t]+/$1/;
 			}
 		}
+
+# Comment styles
+# Initial comment only lines that have a leading space
+		if ($rawline =~ m{^\+([ \t]+)(?:/\*|//)} && $1 =~ / /) {
+			WARN("COMMENT_STYLE",
+			     "Initial comment lines should be indented only with tabs\n" . $herecurr);
+# comments not aligned on tabs
+		} elsif ($rawline !~ m{^\+(?:/\*|//)} &&
+			 $rawline =~ m{^\+.*[^\t](?:/\*|//)}) {
+			CHK("COMMENT_STYLE",
+			    "Comments should generally be preceded by a tab\n" . $herecurr);
+		}
+
+# comment initiators should generally be followed by a space if using words
+		if ($rawline =~ m{^\+.*(?:/\*|//)\w}) {
+			WARN("COMMENT_STYLE",
+			     "Comment text should use a space after the comment initiator\n" . $herecurr);
+		}
 
 # Block comment styles
 # Networking with an initial /*


