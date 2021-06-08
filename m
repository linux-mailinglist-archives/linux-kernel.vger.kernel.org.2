Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B02339EF6B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhFHHW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 03:22:26 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:54732 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhFHHWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 03:22:24 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1587GqkW005202;
        Tue, 8 Jun 2021 07:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=WRL1v/ToqKxbQyo4pcYidm8H/w+snYDc4+FjD14fytA=;
 b=ld8wcqB7rvuBbiX+cudkN53rXiuKVVQ4s8dnxGsIFhynfKolc9V5qJhFvrmyQg6ocKOs
 gZlPCeBwKRDH47aY8Ms8HRl82HjxDg2kdZCH7mbJDFCw2i63adf7TiH7Yn8CFpEqgQQk
 0QA0OmAg9Lu2KfhN828PkmzldxNVkf8s4Be2lGlMoIlDUG/MeVk1hjm1pIxWPl9LUbel
 4qzQPAa85Lo7RcNq8oNfOh4M3YcWGolTM4k3z51oBqzNfwDiLCR6HWGUSSKp5owDs0yk
 8rlEkfq6ab0l9atCHLMdyHVIb3kKUnbHszzUldy8qrQPox8f1nNx5HhEl2bY5X6Fmxj9 OQ== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3917pwgj0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 07:20:24 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 1587KNS2107283;
        Tue, 8 Jun 2021 07:20:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38yyaap2x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 07:20:23 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1587Jc8u104940;
        Tue, 8 Jun 2021 07:20:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 38yyaap2x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 07:20:23 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1587KLDH024584;
        Tue, 8 Jun 2021 07:20:21 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Jun 2021 00:20:21 -0700
Date:   Tue, 8 Jun 2021 10:20:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wenli Looi <wlooi@ucalgary.ca>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arend van Spriel <aspriel@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] staging: rtl8723bs: Fix uninitialized variables
Message-ID: <20210608072014.GZ1955@kadam>
References: <20210607083316.GO1955@kadam>
 <20210608064620.74059-1-wlooi@ucalgary.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608064620.74059-1-wlooi@ucalgary.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: kwR05mTtRSn-MWsi7_Lp1M7zgFqnHmwr
X-Proofpoint-GUID: kwR05mTtRSn-MWsi7_Lp1M7zgFqnHmwr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you run get_maintainer.pl on the patch then adds the developers from
the Fixes tags so they can review the patch.  I've added them but it's
harder for them to review when they can't apply the patch...

Anyway, it looks good.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

On Mon, Jun 07, 2021 at 11:46:20PM -0700, Wenli Looi wrote:
> The sinfo.pertid and sinfo.generation variables are not initialized and
> it causes a crash when we use this as a wireless access point.
> 
> [  456.873025] ------------[ cut here ]------------
> [  456.878198] kernel BUG at mm/slub.c:3968!
> [  456.882680] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> 
>   [ snip ]
> 
> [  457.271004] Backtrace:
> [  457.273733] [<c02b7ee4>] (kfree) from [<c0e2a470>] (nl80211_send_station+0x954/0xfc4)
> [  457.282481]  r9:eccca0c0 r8:e8edfec0 r7:00000000 r6:00000011 r5:e80a9480 r4:e8edfe00
> [  457.291132] [<c0e29b1c>] (nl80211_send_station) from [<c0e2b18c>] (cfg80211_new_sta+0x90/0x1cc)
> [  457.300850]  r10:e80a9480 r9:e8edfe00 r8:ea678cca r7:00000a20 r6:00000000 r5:ec46d000
> [  457.309586]  r4:ec46d9e0
> [  457.312433] [<c0e2b0fc>] (cfg80211_new_sta) from [<bf086684>] (rtw_cfg80211_indicate_sta_assoc+0x80/0x9c [r8723bs])
> [  457.324095]  r10:00009930 r9:e85b9d80 r8:bf091050 r7:00000000 r6:00000000 r5:0000001c
> [  457.332831]  r4:c1606788
> [  457.335692] [<bf086604>] (rtw_cfg80211_indicate_sta_assoc [r8723bs]) from [<bf03df38>] (rtw_stassoc_event_callback+0x1c8/0x1d4 [r8723bs])
> [  457.349489]  r7:ea678cc0 r6:000000a1 r5:f1225f84 r4:f086b000
> [  457.355845] [<bf03dd70>] (rtw_stassoc_event_callback [r8723bs]) from [<bf048e4c>] (mlme_evt_hdl+0x8c/0xb4 [r8723bs])
> [  457.367601]  r7:c1604900 r6:f086c4b8 r5:00000000 r4:f086c000
> [  457.373959] [<bf048dc0>] (mlme_evt_hdl [r8723bs]) from [<bf03693c>] (rtw_cmd_thread+0x198/0x3d8 [r8723bs])
> [  457.384744]  r5:f086e000 r4:f086c000
> [  457.388754] [<bf0367a4>] (rtw_cmd_thread [r8723bs]) from [<c014a214>] (kthread+0x170/0x174)
> [  457.398083]  r10:ed7a57e8 r9:bf0367a4 r8:f086b000 r7:e8ede000 r6:00000000 r5:e9975200
> [  457.406828]  r4:e8369900
> [  457.409653] [<c014a0a4>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
> [  457.417718] Exception stack(0xe8edffb0 to 0xe8edfff8)
> [  457.423356] ffa0:                                     00000000 00000000 00000000 00000000
> [  457.432492] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [  457.441618] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [  457.449006]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c014a0a4
> [  457.457750]  r4:e9975200
> [  457.460574] Code: 1a000003 e5953004 e3130001 1a000000 (e7f001f2)
> [  457.467381] ---[ end trace 4acbc8c15e9e6aa7 ]---
> 
> Link: https://forum.armbian.com/topic/14727-wifi-ap-kernel-bug-in-kernel-5444/
> Fixes: 8689c051a201 ("cfg80211: dynamically allocate per-tid stats for station info")
> Fixes: f5ea9120be2e ("nl80211: add generation number to all dumps")
> Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> index 9a6e47877..2b45df79c 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> @@ -2084,7 +2084,7 @@ void rtw_cfg80211_indicate_sta_assoc(struct adapter *padapter, u8 *pmgmt_frame,
>  	struct net_device *ndev = padapter->pnetdev;
>  
>  	{
> -		struct station_info sinfo;
> +		struct station_info sinfo = {};
>  		u8 ie_offset;
>  		if (GetFrameSubType(pmgmt_frame) == WIFI_ASSOCREQ)
>  			ie_offset = _ASOCREQ_IE_OFFSET_;
> -- 
> 2.25.1
> 
