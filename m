Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9706307FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 21:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhA1Uwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 15:52:51 -0500
Received: from smtprelay0047.hostedemail.com ([216.40.44.47]:35202 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231215AbhA1UwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 15:52:23 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id E9245182CF665;
        Thu, 28 Jan 2021 20:51:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:968:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2895:2933:2937:2939:2942:2945:2947:2951:2954:3000:3022:3138:3139:3140:3141:3142:3351:3622:3865:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:7576:7652:7809:9025:10004:10400:10848:11232:11657:11658:11914:12043:12048:12297:12555:12740:12895:13069:13255:13311:13357:13439:13894:14181:14659:14721:21080:21451:21627:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:152,LUA_SUMMARY:none
X-HE-Tag: store90_330d584275a2
X-Filterd-Recvd-Size: 1703
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Jan 2021 20:51:36 +0000 (UTC)
Message-ID: <4feb2701856a0a05ce22f27adf1ade679695cfe5.camel@perches.com>
Subject: Re: [PATCH] staging: net: wimax: i2400m: fw: remove redundant
 initialization of variable result
From:   Joe Perches <joe@perches.com>
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 28 Jan 2021 12:51:35 -0800
In-Reply-To: <20210128173703.645328-1-colin.king@canonical.com>
References: <20210128173703.645328-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-01-28 at 17:37 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable result is being initialized with a value that is never
> read and it is being updated later with a new value.  The initialization
> is redundant and can be removed.

Isn't WIMAX dead?  Shouldn't it be marked ORPHAN in MAINTAINERS?
---
diff --git a/MAINTAINERS b/MAINTAINERS
index caac09a3c5c9..922afd393cb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19201,6 +19201,10 @@ S:     Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/wil6210
 F:	drivers/net/wireless/ath/wil6210/
 
+WIMAX
+S:	Orphan
+F:	drivers/staging/wimax/
+
 WINBOND CIR DRIVER
 M:	David Härdeman <david@hardeman.nu>
 S:	Maintained


