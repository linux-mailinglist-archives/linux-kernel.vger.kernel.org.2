Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E9B402740
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 12:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245648AbhIGKfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 06:35:43 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:3282 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233710AbhIGKfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 06:35:42 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1875W66e006859;
        Tue, 7 Sep 2021 05:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=wi8C/OOR4jGamE5VgR4Kcd0QgpnltJi1HMdgo3MAAfg=;
 b=mPohdchvfLIlFRumeHKZ8NdHxyozC/TUk3ZzsJ3PScOG9Kq3TmvfEk0jQfWroonImZ9h
 g3iGT483HL2C9jaXxlxPdbgMHkamMuolkffQ3D3moTmmlY0rC/vEcf1purIQoRsY91gq
 kg9utZv0+cmUoQaDuTCwfNHpap7WKZSljvbg6ehh+9cHwxJQSmngW6ou/CX8bc6W1qCo
 +dmWTQC9RwMxQKHL+Cxnuch7PUF5DqqhRo+0OIjeU794nEFJfmVtmyv8ATVgq5y0476D
 jMu8RqRdxcldgiO3y0cQ838nDFy2FQT0iskyj5SPteS+6JSB3qlKVtGnvf9kjc9R28oz cg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3awp5ugru3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 Sep 2021 05:33:39 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 7 Sep
 2021 11:33:38 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 7 Sep 2021 11:33:38 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E9ADDB15;
        Tue,  7 Sep 2021 10:33:37 +0000 (UTC)
Date:   Tue, 7 Sep 2021 10:33:37 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm8960: Fix clock configuration on slave mode
Message-ID: <20210907103337.GO9223@ediswmail.ad.cirrus.com>
References: <1631005869-7308-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1631005869-7308-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: bgrLMdxn9w4gSw_U3QOadr0epMkMEDux
X-Proofpoint-ORIG-GUID: bgrLMdxn9w4gSw_U3QOadr0epMkMEDux
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 05:11:09PM +0800, Shengjiu Wang wrote:
> There is a noise issue for 8kHz sample rate on slave mode.
> Compared with master mode, the difference is the DACDIV
> setting, after correcting the DACDIV, the noise is gone.
> 
> There is no noise issue for 48kHz sample rate, because
> the default value of DACDIV is correct for 48kHz.
> 
> So wm8960_configure_clocking() should be functional for
> ADC and DAC function even if it is slave mode.
> 
> In order to be compatible for old use case, just add
> condition for checking that sysclk is zero with
> slave mode.
> 
> Fixes: 0e50b51aa22f ("ASoC: wm8960: Let wm8960 driver configure its bit clock and frame clock")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/codecs/wm8960.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
> index 9e621a254392..9c6af76a60fd 100644
> --- a/sound/soc/codecs/wm8960.c
> +++ b/sound/soc/codecs/wm8960.c
> @@ -742,7 +742,7 @@ static int wm8960_configure_clocking(struct snd_soc_component *component)
>  	int i, j, k;
>  	int ret;
>  
> -	if (!(iface1 & (1<<6))) {
> +	if (!(iface1 & (1 << 6)) && !wm8960->sysclk) {
>  		dev_dbg(component->dev,
>  			"Codec is slave mode, no need to configure clock\n");

Looking through the datasheet it just looks like this if
statement has always been non-sense, it looks pretty clear the
clocking should still be configured in slave mode (apart from
BCLKDIV which is presumably ignored in slave mode).

I would be slightly inclined to suggest it would be better
to just fixup any systems not setting sysclk for slave mode,
but I am assuming you are talking primarily about out of tree
systems. So I think we need to at least update the message here
as well, it should probably change to a warning and state that
the we are proceeding with no clock configuration, rather than
erroneously saying it doesn't need one.

Thanks,
Charles
