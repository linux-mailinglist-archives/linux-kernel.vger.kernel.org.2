Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5C73B9D19
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 09:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhGBHvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 03:51:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6934 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbhGBHve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 03:51:34 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1627lCdT031107;
        Fri, 2 Jul 2021 07:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=gFi8gQi/8WEsjevzCsa9CSkzQEahXs5lVkv1CngP5TU=;
 b=eeHPqlWtF06lvo6m6WWXuLSiZFHfTmKc5YkbQE8DyT18UvarEiFrJ1nGdL7+KhfajEYa
 8ZVmwJyRsPpnQZjE01Y1ErNfiY4ZzENe+3siyvG7UB8C7KeQ8H6njQDXPTHeae9JXCjM
 24njPxri9VKAP8CmeKBtc4LnBD5lk8aM2y96AOpKLorAcmxceeItLjOzc6v9RYcBIblx
 DQSa9pLkp3WjdHUsPThuMPylVzQdBcoMkrIE9EKKkgvAw2krSsKrqNHm6P/Fetndsw4R
 LIJsdBnBgHqxVq20BtmoplyagDpT6vJqPkP4jaJiJZR6jwXtYgQABVS+XeItD125qZp6 hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gy5w34dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 07:48:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1627a5Z4024823;
        Fri, 2 Jul 2021 07:48:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 39dv2c75rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 07:48:49 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1627mmGJ058211;
        Fri, 2 Jul 2021 07:48:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 39dv2c75re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 07:48:48 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.14.4) with ESMTP id 1627ml1C019320;
        Fri, 2 Jul 2021 07:48:47 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Jul 2021 00:48:47 -0700
Date:   Fri, 2 Jul 2021 10:48:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: Remove an unused variable and some
 lines of code
Message-ID: <20210702074840.GT2040@kadam>
References: <20210701144707.22820-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701144707.22820-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: M3sLE17F0XAuoreUmxUlCXhzOzB5Xqc2
X-Proofpoint-ORIG-GUID: M3sLE17F0XAuoreUmxUlCXhzOzB5Xqc2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 04:47:07PM +0200, Fabio M. De Francesco wrote:
> Remove set but unused iw_operation_mode[]. Remove all the lines of 
> code from the function rtw_wx_set_rate, except the "return 0;" line 
> to not break userland code that somewhat uses this IOCTL.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  .../staging/rtl8188eu/os_dep/ioctl_linux.c    | 72 -------------------
>  1 file changed, 72 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
> index b958a8d882b0..a66d8838c034 100644
> --- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
> @@ -46,11 +46,6 @@ static u32 rtw_rates[] = {1000000, 2000000, 5500000, 11000000,
>  	6000000, 9000000, 12000000, 18000000, 24000000, 36000000,
>  	48000000, 54000000};
>  
> -static const char * const iw_operation_mode[] = {
> -	"Auto", "Ad-Hoc", "Managed",  "Master", "Repeater",
> -	"Secondary", "Monitor"
> -};
> -
>  void indicate_wx_scan_complete_event(struct adapter *padapter)
>  {
>  	union iwreq_data wrqu;
> @@ -1266,73 +1261,6 @@ static int rtw_wx_set_rate(struct net_device *dev,
>  			   struct iw_request_info *a,
>  			   union iwreq_data *wrqu, char *extra)
>  {

Just delete this whole file.  It doesn't do anything now.

regards,
dan carpenter

