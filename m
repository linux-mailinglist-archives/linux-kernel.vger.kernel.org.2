Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F59E39D77E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhFGIhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:37:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16306 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229545AbhFGIhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:37:47 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1578RJVp026781;
        Mon, 7 Jun 2021 08:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=6ZTcKTv3Yj72FnfPMYNuvaGy/891xXLCn+KYZZpuozQ=;
 b=Q2Fm5/6xl/rGkF+QAyfqlsgUpiGjQc4xHBjtQEtlXwrundHzazzoHz2LU1vR/msHG3x+
 yohA9mGkZG2o8eUsaAHfDHWatDm3Wo6HRv97vYrXapR962dsSW2FuRr6tXp1huzCglAG
 w7DZojeVd4CfIZCrzhUXKbn+g2z76COnzVlo4D4qX7755BE9t4dR4E5cs6IzAPshuWFB
 gWM6vbNshbsnwpiSfyEVY37tyQ2kYg9SNickKZrCj6EE+mra+4r+NEWHp2ZKxO8pl5Ks
 gSmEqoa6yOWZdmOXx8G9TiInN5g0KHvLSWu1PdEqgPWzTHP7BWUWz+kCZ0ovT1pg4uB6 6w== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3901ts8n20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 08:35:52 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 1578UmVW069313;
        Mon, 7 Jun 2021 08:35:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38yxctphw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 08:35:51 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1578ZoxB076497;
        Mon, 7 Jun 2021 08:35:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 38yxctphvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 08:35:50 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1578ZnoK023620;
        Mon, 7 Jun 2021 08:35:49 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Jun 2021 08:35:48 +0000
Date:   Mon, 7 Jun 2021 11:35:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wenli Looi <wlooi@ucalgary.ca>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH v2] staging: rtl8723bs: Fix uninitialized variable
Message-ID: <20210607083542.GP1955@kadam>
References: <7256195.zb9d8qvCYo@linux.local>
 <20210606184638.13650-1-wlooi@ucalgary.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606184638.13650-1-wlooi@ucalgary.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: u3VTU-lBdpLmrzlKUOrtAW8cCklGFaCP
X-Proofpoint-ORIG-GUID: u3VTU-lBdpLmrzlKUOrtAW8cCklGFaCP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2021 at 11:46:38AM -0700, Wenli Looi wrote:
> Uninitialized struct with invalid pointer causes BUG and prevents access
> point from working. Access point works once I apply this patch.
> 
> This problem seems to have been present from the time the driver was
> added to staging. Most users probably do not use access point so they
> will not encounter this bug.
> 
> https://forum.armbian.com/topic/14727-wifi-ap-kernel-bug-in-kernel-5444/
> has more details.
> 
> kzalloc() seems to be what other drivers are doing in the same situation
> of creating struct station_info and calling cfg80211_new_sta.  In
> particular, other drivers like ath6kl and mwifiex will silently return
> when kzalloc fails, so this seems like the right behavior. (mwifiex
> returns -ENOMEM from the place kzalloc is called, but if you follow the
> chain of calls, the return value is ultimately ignored)
> 
> Links to same situation in other drivers:
> https://github.com/torvalds/linux/blob/f5b6eb1e018203913dfefcf6fa988649ad11ad6e/drivers/net/wireless/ath/ath6kl/main.c#L488
> https://github.com/torvalds/linux/blob/f5b6eb1e018203913dfefcf6fa988649ad11ad6e/drivers/net/wireless/marvell/mwifiex/uap_event.c#L120
> 
> Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
> ---
> 
> v1 -> v2: Switched from large stack variable to kzalloc


Nah, v1 was better, it just needs an updated commit message.  See my
other email for more details.

regards,
dan carpenter

