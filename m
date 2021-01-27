Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C703306263
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344041AbhA0RoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:44:19 -0500
Received: from smtprelay0120.hostedemail.com ([216.40.44.120]:34958 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1344142AbhA0Rnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:43:43 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 5D03B181D3026;
        Wed, 27 Jan 2021 17:43:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:967:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4823:5007:6742:7514:7652:9025:10004:10400:10848:11232:11658:11783:11914:12043:12297:12555:12663:12740:12895:12986:13069:13311:13357:13439:13846:13894:14181:14659:14721:14777:21080:21433:21627:21819:30054:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: crowd66_500673e27598
X-Filterd-Recvd-Size: 2238
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 27 Jan 2021 17:42:57 +0000 (UTC)
Message-ID: <3f7b25d21c10a4dc7da5d507d6d6a6a5bc93447b.camel@perches.com>
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
Date:   Wed, 27 Jan 2021 09:42:56 -0800
In-Reply-To: <20210127144946.GF2696@kadam>
References: <1611754972-151016-1-git-send-email-zhangxuezhi3@gmail.com>
         <YBFv+12xfsoxacDb@kroah.com> <20210127220809.000026fb@gmail.com>
         <YBF08Xf7qaZx3YZ1@kroah.com> <20210127221708.00002568@gmail.com>
         <YBF30EEUkhEMY5ti@kroah.com> <20210127144946.GF2696@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-01-27 at 17:49 +0300, Dan Carpenter wrote:
> On Wed, Jan 27, 2021 at 03:25:20PM +0100, Greg KH wrote:

> > Andy and Joe, there's something wrong here that is missing the fact that
> > a line is being indented with spaces and not tabs in the patch
> > at https://lore.kernel.org/r/1611754972-151016-1-git-send-email-zhangxuezhi3@gmail.com
> > 
> > Any ideas what broke?
> 
>     /*Tearing Effect Line On*/
> 
> Comments are the exception to the "no spaces at the start of a line"
> rule.  I was expecting that the kbuild-bot would send a Smatch warning
> for inconsistent indenting, but comments are not counted there either.
> 
> I'm sort of surprised that we don't have checkpatch rule about the
> missing space characters.  It should be: "/* Tearing Effect Line On */".

You could always write your own rule...

checkpatch doesn't care if a comment looks like

    /********************/
or
    /*foobarfoobarfoobar*/


