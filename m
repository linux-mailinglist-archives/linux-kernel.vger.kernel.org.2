Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7806A33035A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 18:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhCGRbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 12:31:19 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:38412 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229637AbhCGRbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 12:31:03 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 127HTsxA023819;
        Sun, 7 Mar 2021 11:29:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=qFwuaB9XRWNdbWaM1kjbKcvQcMGq7hMqEHja3kG8szw=;
 b=Q3TKGNs6jVIvV3XvCmrApgK/BIpd/eWKtee5dvRWRrLf19B6pzkFvRD++5D0Ox/OsDRH
 esp8o8nd8gX4e99EtjIERCTYCJ2Oqavx++GhVTf2HtLYbdLlBXKEFa5Ms/QjGqX/aarx
 DV5OgBlrCa6vnO7Dl+kaX0gn7cHipNMeMybN8qoh5eKe3iEh3Aeo+tjqfKt2pTx0UyKU
 EJCnzmWSRj3Qtt3hKqfqYw+r/X4vvwHDhVJ/JwtW9lHGtDOAmQJ4OfTGSIcXCrGVf2m2
 0Ei4X0NQ4URm7HdzWCh49YfPHMGaT76pZhW5LbxCdz5t4NAnEfsUsB2w5Tbqc6erDno6 Rg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 37471vs4kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 07 Mar 2021 11:29:54 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sun, 7 Mar 2021
 17:29:52 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Sun, 7 Mar 2021 17:29:52 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D480B11CB;
        Sun,  7 Mar 2021 17:29:52 +0000 (UTC)
Date:   Sun, 7 Mar 2021 17:29:52 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>,
        <peter.ujfalusi@ti.com>, <gustavoars@kernel.org>,
        <pierre-louis.bossart@linux.intel.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm8962: Relax bit clock divider searching
Message-ID: <20210307172952.GG106851@ediswmail.ad.cirrus.com>
References: <1614770488-12861-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1614770488-12861-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103070096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 07:21:28PM +0800, Shengjiu Wang wrote:
> With S20_3LE format case, the sysclk = rate * 384,
> the bclk = rate * 20 * 2, there is no proper bclk divider
> for 384 / 40, because current condition needs exact match.
> So driver fails to configure the clocking:
> 
> wm8962 3-001a: Unsupported BCLK ratio 9
> 
> Fix this by relaxing bitclk divider searching, so that when
> no exact value can be derived from sysclk pick the closest
> value greater than expected bitclk.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/codecs/wm8962.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
> index ce4666a74793..f5cd22450190 100644
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -2403,6 +2403,7 @@ static const int sysclk_rates[] = {
>  static void wm8962_configure_bclk(struct snd_soc_component *component)
>  {
>  	struct wm8962_priv *wm8962 = snd_soc_component_get_drvdata(component);
> +	int best, min_diff, diff;
>  	int dspclk, i;
>  	int clocking2 = 0;
>  	int clocking4 = 0;
> @@ -2473,23 +2474,23 @@ static void wm8962_configure_bclk(struct snd_soc_component *component)
>  
>  	dev_dbg(component->dev, "DSPCLK is %dHz, BCLK %d\n", dspclk, wm8962->bclk);
>  

Very minor nit but it would probably be nice to have some
equivalent debug statement that prints out the actual BCLK we end
up with. There are a couple of statements printing the requested
speed, but nothing that will output what the driver actually
applies after this change.

Otherwise I think the change looks good.

Thanks,
Charles
