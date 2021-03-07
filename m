Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79CC330365
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 18:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhCGRgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 12:36:42 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:49026 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230165AbhCGRgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 12:36:11 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 127HUVRR030768;
        Sun, 7 Mar 2021 11:35:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=4IcP482WivrPpW8qzTq8Vh0u+FmYVTZmwQGRKPQ/uWY=;
 b=kEtZ2lF3/BzuBisoKfbsC3Ztan8jYG2af21/rcObe0Rl+2YzhJGCZN7KVzB9kO+77FxM
 a5D8uIgZP17bJL7btJK2vvLUXR6lrM31ONg06bcXA2uBcpM/8Wt1GutnegM9YXhus8FJ
 RFG523+3YS47k5diRlVPhQ5pydsu7B0LYw2g3YjVFBvUy0rYu8O7i4FdK2chNJLz3XYB
 v/6yog+9BGqwHgZbxygX6w7J8akCH03cVZfg66tpimITD4U9ag0CgQbcLRTuJb1qeKHh
 4SgxRoyHcVUrlpYuUTnCyZqBGUSSC3T2nnewU6eSCBniFbzH7m6KNez2khBItKxygDUo Cg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 37481993yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 07 Mar 2021 11:35:08 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sun, 7 Mar 2021
 17:05:02 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Sun, 7 Mar 2021 17:05:02 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0ECB611D6;
        Sun,  7 Mar 2021 17:05:02 +0000 (UTC)
Date:   Sun, 7 Mar 2021 17:05:02 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>,
        <gustavoars@kernel.org>, <peter.ujfalusi@ti.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <rdunlap@infradead.org>
Subject: Re: [PATCH] sound: soc: codecs: Fix a spello in the file wm8955.c
Message-ID: <20210307170502.GE106851@ediswmail.ad.cirrus.com>
References: <20210306115151.31759-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210306115151.31759-1-unixbhaskar@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103070096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06, 2021 at 05:21:51PM +0530, Bhaskar Chowdhury wrote:
> 
> s/sortd/sorted/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  sound/soc/codecs/wm8955.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
> index 513df47bd87d..538bb8b0db39 100644
> --- a/sound/soc/codecs/wm8955.c
> +++ b/sound/soc/codecs/wm8955.c
> @@ -151,7 +151,7 @@ static int wm8955_pll_factors(struct device *dev,
>  	/* The oscilator should run at should be 90-100MHz, and
>  	 * there's a divide by 4 plus an optional divide by 2 in the
>  	 * output path to generate the system clock.  The clock table
> -	 * is sortd so we should always generate a suitable target. */
> +	 * is sorted so we should always generate a suitable target. */
>  	target = Fout * 4;
>  	if (target < 90000000) {
>  		pll->outdiv = 1;
> --
> 2.26.2
> 

Content of the patch looks good, the commit message might need a
little work. The subject line needs to be appropriate for the
subsystem. Would be better to start with "ASoC: wm8955: " and
typo is a more standard term than spello :-)

Thanks,
Charles
