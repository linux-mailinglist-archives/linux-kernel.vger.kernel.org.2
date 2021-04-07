Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEFC35676A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349789AbhDGI7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:59:49 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:16140 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1349782AbhDGI7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:59:48 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1378lTeo007605;
        Wed, 7 Apr 2021 03:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=MYjQxKqbd3eBBgmsM9QUSNcq2htdoJkr2o++yxL5dB4=;
 b=Ayv9cLgqSJvQaugsepvhhtXN0KLDooVrrlLH65SejsnEeFjK8xwWrLAoMeB/Nscdn+6I
 S9mFZ1qJn21U4ZCRvOp5WbOei0HPLHSoasV5FLkO9EjhumIoxxKWk+TWdeigfI5CjBMZ
 OUwoGPAFXOXnSBNJUiPKgpyhn+/ibt23HjW+UOViYNsGIp9EpsDf1O9SyG55qy6OHJGM
 ZseOeJjX7M3jaW7zH4Pb3kbyMex5kB39o45sFJMIOhEWNal0HQyQkl2txhFHGexNBoD0
 xxjrTICmv6pAZJUhIOAKiKLzxfHWbqlfuiJTk9o8bnXXuz6CywwBEOqUMVPtsaKfSuvw Xw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 37rvc397m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 07 Apr 2021 03:49:53 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 7 Apr 2021
 09:49:51 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Wed, 7 Apr 2021 09:49:51 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E608211CF;
        Wed,  7 Apr 2021 08:49:50 +0000 (UTC)
Date:   Wed, 7 Apr 2021 08:49:50 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
CC:     <kjlu@umn.edu>, Lee Jones <lee.jones@linaro.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: arizona: Fix rumtime PM imbalance on error
Message-ID: <20210407084950.GU106851@ediswmail.ad.cirrus.com>
References: <20210407051149.31422-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210407051149.31422-1-dinghao.liu@zju.edu.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: _q2tjFOE23xLZj9UlZRC5npnnZ52mu67
X-Proofpoint-ORIG-GUID: _q2tjFOE23xLZj9UlZRC5npnnZ52mu67
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 mlxscore=0 adultscore=0 impostorscore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 01:11:49PM +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() will increase the rumtime PM counter
> even it returns an error. Thus a pairing decrement is needed
> to prevent refcount leak. Fix this by replacing this API with
> pm_runtime_resume_and_get(), which will not change the runtime
> PM counter on error.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Wow, did not realise that was how that worked. Thanks for fixing
up.

Thanks,
Charles
