Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13143357416
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 20:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355176AbhDGSUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 14:20:08 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24827 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355172AbhDGSUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 14:20:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617819596; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=v5hhCBxMu4t8ymRS5UeQli/Ao4wr7txEYWAKX3ZDl5M=;
 b=gv0hR+C/SLk4Oiqh/GBSbExPfkgE6bTZfykcO/oCfh7hSt1FdWAg4QlMGIF8WqkdZv7PoTGB
 ZawaOxjBW/GXL9lIbgyDlD6YyZ8Xc72WKrOjRgJVLWmddKtU/wvkQGc3GLPxWHq8E5H873J2
 k+tOgPD5Tw0k4JMh1KuKcU/CGXA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 606df7cbf34440a9d4711d3b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 07 Apr 2021 18:19:55
 GMT
Sender: abhinavk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8DFE8C433ED; Wed,  7 Apr 2021 18:19:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: abhinavk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E9852C43461;
        Wed,  7 Apr 2021 18:19:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 07 Apr 2021 11:19:53 -0700
From:   abhinavk@codeaurora.org
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, freedreno@lists.freedesktop.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Sean Paul <sean@poorly.run>
Subject: Re: [Freedreno] [PATCH 1/3] drm/msm/mdp5: Configure PP_SYNC_HEIGHT to
 double the vtotal
In-Reply-To: <20210406214726.131534-2-marijn.suijten@somainline.org>
References: <20210406214726.131534-1-marijn.suijten@somainline.org>
 <20210406214726.131534-2-marijn.suijten@somainline.org>
Message-ID: <6413863d04df9743e2d7e81beff5c3e8@codeaurora.org>
X-Sender: abhinavk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marijn

On 2021-04-06 14:47, Marijn Suijten wrote:
> Leaving this at a close-to-maximum register value 0xFFF0 means it takes
> very long for the MDSS to generate a software vsync interrupt when the
> hardware TE interrupt doesn't arrive.  Configuring this to double the
> vtotal (like some downstream kernels) leads to a frame to take at most
> twice before the vsync signal, until hardware TE comes up.
> 
> In this case the hardware interrupt responsible for providing this
> signal - "disp-te" gpio - is not hooked up to the mdp5 vsync/pp logic 
> at
> all.  This solves severe panel update issues observed on at least the
> Xperia Loire and Tone series, until said gpio is properly hooked up to
> an irq.

The reason the CONFIG_HEIGHT was at such a high value is to make sure 
that
we always get the TE only from the panel vsync and not false positives 
coming
from the tear check logic itself.

When you say that disp-te gpio is not hooked up, is it something 
incorrect with
the schematic OR panel is not generating the TE correctly?

> 
> Suggested-by: AngeloGioacchino Del Regno
> <angelogioacchino.delregno@somainline.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: AngeloGioacchino Del Regno
> <angelogioacchino.delregno@somainline.org>
> ---
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
> b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
> index ff2c1d583c79..2d5ac03dbc17 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
> @@ -51,7 +51,7 @@ static int pingpong_tearcheck_setup(struct
> drm_encoder *encoder,
> 
>  	mdp5_write(mdp5_kms, REG_MDP5_PP_SYNC_CONFIG_VSYNC(pp_id), cfg);
>  	mdp5_write(mdp5_kms,
> -		REG_MDP5_PP_SYNC_CONFIG_HEIGHT(pp_id), 0xfff0);
> +		REG_MDP5_PP_SYNC_CONFIG_HEIGHT(pp_id), (2 * mode->vtotal));
>  	mdp5_write(mdp5_kms,
>  		REG_MDP5_PP_VSYNC_INIT_VAL(pp_id), mode->vdisplay);
>  	mdp5_write(mdp5_kms, REG_MDP5_PP_RD_PTR_IRQ(pp_id), mode->vdisplay + 
> 1);
