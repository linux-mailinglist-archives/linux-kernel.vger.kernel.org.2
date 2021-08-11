Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C0D3E8F2D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237239AbhHKK5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:57:18 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:7458 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237265AbhHKK5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:57:09 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17B9h5dZ011878;
        Wed, 11 Aug 2021 05:56:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=YS0en2nvtImSykNobFR0zlreAx5eXIqh0Mq5Jty9FJ0=;
 b=Ps056BEO0fECxG5FoU7iGZ6a0VBBchOQ7ScbnQP4hWfInQLzv3dfHvea8c/svFkq53Wi
 WkGSKfVLAQeC8aYaqAL/pveP0ujyg+L47OY2KZ0p+DNmOpArRSr7E1MZn78fM13kmz6X
 UqF6qAwP5LyZ+rS7hAqXhNjLDIRvzty5xcdHSn+2c5IhChIXi5+td/YYohQG1Oh7FPmJ
 3eGy5QGDiiQ5FrNya+n5tpOakrFPUq4Misiidy8RgTn9dKc5ADkSqT3OHs3gmX/vw31M
 RmfuzFQKj3TRHiq3YsTCRh/rbT5qQGLV5/QRPyNdTuRxYCOm5UsBw6oiV8gZchRnqKH9 1Q== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3acc5ng2pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Aug 2021 05:56:36 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 11:56:34 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 11 Aug 2021 11:56:34 +0100
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.221])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 929342A9;
        Wed, 11 Aug 2021 10:56:34 +0000 (UTC)
Subject: Re: [PATCH 04/12] ASoC: cs42l42: Don't reconfigure the PLL while it
 is running
To:     Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
References: <20210810153759.24333-1-rf@opensource.cirrus.com>
 <20210810153759.24333-5-rf@opensource.cirrus.com>
 <20210810154959.GD4704@sirena.org.uk>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <b244d737-ae0d-2566-d909-c2264a2668ec@opensource.cirrus.com>
Date:   Wed, 11 Aug 2021 11:56:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210810154959.GD4704@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: uGPj_o87FZzFDBmyNqNdAnk0NPSKz_i7
X-Proofpoint-GUID: uGPj_o87FZzFDBmyNqNdAnk0NPSKz_i7
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=876 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108110072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2021 16:49, Mark Brown wrote:
> On Tue, Aug 10, 2021 at 04:37:51PM +0100, Richard Fitzgerald wrote:
>> cs42l42_pcm_hw_params() must only configure the PLL if this is the first
>> stream to become active, otherwise it will be overwriting the registers
>> while the PLL is running.
> 
> Shouldn't the PLL code be noticing problematic attempts to reconfigure
> the PLL while it's active rather than the individual callers?
> 

I'll push a new version with cs42l42_pll_config() doing the check.
