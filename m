Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC62E3A0F87
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 11:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbhFIJXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 05:23:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58542 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231300AbhFIJXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 05:23:45 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1599DNKL007209;
        Wed, 9 Jun 2021 09:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Jri6PWef05tc37+Wiamp7GQU5ME1z+y9zPz4Zt68mBQ=;
 b=RzRpmmXrvpqv/ch/6wiQwRWB2TjeigKdV+0K5Bv0Eu/wvKql1zi7FysMIASJkOOJ4Deh
 BN4dpaqELjrGN1H6unGAL1v7RYqY2WzOVEBTQIihPq0/9TxhCRS1JU3G30wiTWddNHz+
 Zz9QpRp6FHIrNYqiqlqK/0c0Y32KW44LDzDGmateJlo4tO6A/+GC39n9sNOv0a61dZGg
 1OzBRikvHaugqQvoICPXOuUqXaWbc3GrL+JPnqPo1d/fqFt0qNARFsmRsxB68DQp7CYS
 pNvzn+RlCNRcWPswbg0ZOgojUMMbY2IeS2tnYMajN8rhBL/SQySaJdL5zybGtFFhsuLY YA== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 392ptc83fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 09:21:22 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 1599HQwQ002264;
        Wed, 9 Jun 2021 09:21:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3922wudxnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 09:21:21 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1599H1ef196034;
        Wed, 9 Jun 2021 09:21:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3922wudxky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 09:21:20 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1599LEYD026453;
        Wed, 9 Jun 2021 09:21:14 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Jun 2021 09:21:14 +0000
Date:   Wed, 9 Jun 2021 12:21:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, kaixuxia@tencent.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: replace two ODM_RT_TRACE calls in
 hal/phy.c
Message-ID: <20210609092106.GE1955@kadam>
References: <20210608235609.6726-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608235609.6726-1-phil@philpotter.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: fcT4VuWVbIj0mp_NzNz5-I3ECA40S2qj
X-Proofpoint-GUID: fcT4VuWVbIj0mp_NzNz5-I3ECA40S2qj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 12:56:09AM +0100, Phillip Potter wrote:
> Within rtl88eu_dm_txpower_track_adjust function, retrieve the struct
> net_device pointer, and replace both calls to the ODM_RT_TRACE macro
> with equivalent netdev_dbg calls, as well as modifying layout, wording
> and spacing slightly. The purpose of this, and patches like it, is to
> eventually remove the need for include/odm_debug.h, which is an overly
> complex way of printing debug/tracing information about the driver.
> 

In the original code DebugComponents is always zero so the ODM_RT_TRACE()
stuff was dead code and could never be printed.  I would prefer we just
delete it all instead of fixing it.

regards,
dan carpenter

