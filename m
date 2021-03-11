Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD92336EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhCKJQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:16:00 -0500
Received: from smtprelay0208.hostedemail.com ([216.40.44.208]:37850 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231882AbhCKJPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:15:38 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 7851E1806ECE7;
        Thu, 11 Mar 2021 09:15:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:3868:3873:4250:4321:5007:7652:10004:10400:10848:11232:11658:11914:12297:12555:12740:12760:12895:12986:13069:13311:13357:13439:14181:14659:14721:21080:21221:21451:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: cause26_620e79827709
X-Filterd-Recvd-Size: 1972
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu, 11 Mar 2021 09:15:36 +0000 (UTC)
Message-ID: <379d4b58d82be1f871924c89e0db7bab367564fb.camel@perches.com>
Subject: Re: [PATCH] staging: rtl8723bs: align comments
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 11 Mar 2021 01:15:34 -0800
In-Reply-To: <20210310174830.GM2087@kadam>
References: <20210310153717.GA5741@agape.jhs> <20210310174830.GM2087@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-03-10 at 20:48 +0300, Dan Carpenter wrote:
> You need to have a space character after the '*'.

Perhaps YA checkpatch test...
---
 scripts/checkpatch.pl | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f42e5ba16d9b..0de553d52605 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3876,6 +3876,21 @@ sub process {
 			}
 		}
 
+# Independent comment lines should have a space after the comment initiator
+		if ($line =~ /^\+[ \t]*($;+)/) {		#leading comment
+			my $comment = trim(substr($rawline, $-[1], $+[1] - $-[1]));
+			if ($comment =~ m{^(/\*|\*/|\*|//)(.*)}) {
+				my $init = $1;
+				my $rest = $2;
+				if ($init =~ m{^(?:/\*|\*|//)$} &&
+				    $rest ne '' &&
+				    $rest !~ /^[\s\*=\-]/) {
+					WARN("COMMENT_STYLE",
+					     "Comments generally use whitespace after the comment initiator\n" . $herecurr);
+				}
+			}
+		}
+
 # check for missing blank lines after struct/union declarations
 # with exceptions for various attributes and macros
 		if ($prevline =~ /^[\+ ]};?\s*$/ &&

