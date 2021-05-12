Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C43D37B7D2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 10:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhELIZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 04:25:22 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:16566 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230129AbhELIZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 04:25:20 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14C8GxTo019727;
        Wed, 12 May 2021 03:24:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=wG06jQsuxXmpyimFW25Di30SFAygGPupxoCDyLNhcwM=;
 b=beETCuRYrXrA3GVdgcPhpdwYtmDsB405/VaNYvJghaNT2P3Q95bJkx3mT10yjxhsvd3E
 70ERBtS+K8OyZb25wUrCa6int9YAnhBfgIuLGbP8Z+27JEaPJv3WRj1yETCiUpTF8GOm
 68iJ8itrDANQun4xMba9i2Djj7BF/xv0fN5yXnuLCmT+4N+gJiif7tcv841Spk0BYDWr
 fT2C9dR2q3PHR23aIGCoitjnShND1CwxNZ1PNG1v7Zw9upH3hmH2CvoCm5VTt4S3jlcS
 9ltcAZ4vQBisvIhE3+LAktOe03yG3jkAWhiJaQ4Sk6TttfvJiTyEcVYVuRodE3/+fALw kg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 38f4x1ata5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 12 May 2021 03:24:06 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 12 May
 2021 09:24:04 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 12 May 2021 09:24:04 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6757611CD;
        Wed, 12 May 2021 08:24:04 +0000 (UTC)
Date:   Wed, 12 May 2021 08:24:04 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Simon Trimmer <simont@opensource.cirrus.com>
CC:     <broonie@kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm_adsp: mark more data structures with the const
 qualifier
Message-ID: <20210512082404.GF64205@ediswmail.ad.cirrus.com>
References: <20210511171459.270169-1-simont@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210511171459.270169-1-simont@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: wn-E5DoFsPPEs0soT1eJRsZdpd7wZ-aW
X-Proofpoint-ORIG-GUID: wn-E5DoFsPPEs0soT1eJRsZdpd7wZ-aW
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 clxscore=1011 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105120060
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 06:14:59PM +0100, Simon Trimmer wrote:
> The callback structures and memory region type table can be marked as
> const as they will not change during use.
> 
> Fix checkpatch warning against wm_adsp_find_region function by moving
> const keyword to form the 'static const struct' pattern.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
