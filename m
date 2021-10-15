Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02E342E4B5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 01:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhJNXUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 19:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhJNXU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 19:20:29 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDE3C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 16:18:24 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z11so32391924lfj.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 16:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JGQkp4PxF/8vYlSAKh+ljJVsL2FCke1j6AQ9DfdlzkI=;
        b=y145O79Y/PL+jw1VQVbJjjBO4EIdPLZCSnBp9uHGHS44Z3pUFNFhGRxDBvLM7brbnN
         aCdBZWicEP2muwDWkLzTuEYcN3AKoGDhq8jICptb+tJVv4xwV2XPWuvQizOiYANNp1ae
         fNUGQdGjwHJtDf+SF9JomTCoZ983ZtYlqg6BI/EGwEFRyucUQuPiwnoD1ATS2JoMlpqW
         FEngsBZBTqowfW/fbTonQ7JpDF4YS5Y1TcQajOcelj1ekjRl4Ew/uwSiGO0mN8vFgs/M
         CPigf8IQOOGAB/MJV4jy6EFwZegCBagTAOgBPo5YWIjlxrwCUZzExhubDhaPYcs3pcOW
         nLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JGQkp4PxF/8vYlSAKh+ljJVsL2FCke1j6AQ9DfdlzkI=;
        b=MdeXI8sYGF16/NJEqVpcrt+RDP/gqUMG7vIZnv3dFUFbbcgM+9Iuc2jDiZJCikhtj3
         r6mYcwh/JFJTf8heQiyT5r4mz3GOEwOtwmOUlQQ1t7RzT3xb8/c5jTWSLYaqvmrr/csX
         sExzWc48D1NCMx+/u7r5QTum1CRXmgt6g9fwA8n8s76YwRvDB5TOPcWTSUl3HZR7w3dy
         hm/Jr0vnd6XEfQ8E9Q1eB/mfFKeCTjGn1VJ9v8G+NplWSIYkh9aP5TVZNNJ1uTdhD88t
         B6b7r/0I2y0xdki7XOjRABp19OlIee77Td8lgmyFVO1BHIf3Xv1nGFv8wvV7BPZnmZyN
         au6A==
X-Gm-Message-State: AOAM530G4EBJzyj0bKzy8RCEMrCEQr31C1C6BoztFUlZ5kT+afRymLt9
        zG5TLE0GsnSCzhFzgRGO/i2Ntw==
X-Google-Smtp-Source: ABdhPJzpWHPBnyxosuCdd6mNa3JHx28jASCaq7F65McnJ81q4IGvP70BNOyJaZBTSDCPvrLcALWGhw==
X-Received: by 2002:a05:6512:3c88:: with SMTP id h8mr7629880lfv.128.1634253502397;
        Thu, 14 Oct 2021 16:18:22 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id i12sm341638lfb.234.2021.10.14.16.18.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 16:18:22 -0700 (PDT)
Subject: Re: [PATCH v2 10/11] drm/msm/dsi: Add support for DSC configuration
To:     Vinod Koul <vkoul@kernel.org>, Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <20211007070900.456044-1-vkoul@kernel.org>
 <20211007070900.456044-11-vkoul@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <785fe3bf-71fa-aabd-dadf-828b91396fba@linaro.org>
Date:   Fri, 15 Oct 2021 02:18:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211007070900.456044-11-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2021 10:08, Vinod Koul wrote:
> When DSC is enabled, we need to configure DSI registers accordingly and
> configure the respective stream compression registers.
> 
> Add support to calculate the register setting based on DSC params and
> timing information and configure these registers.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>   drivers/gpu/drm/msm/dsi/dsi.xml.h  |  10 +++
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 123 ++++++++++++++++++++++++++++-
>   2 files changed, 132 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.xml.h b/drivers/gpu/drm/msm/dsi/dsi.xml.h
> index 49b551ad1bff..c1c85df58c4b 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.xml.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi.xml.h
> @@ -706,4 +706,14 @@ static inline uint32_t DSI_VERSION_MAJOR(uint32_t val)
>   #define REG_DSI_CPHY_MODE_CTRL					0x000002d4
>   
>   
> +#define REG_DSI_VIDEO_COMPRESSION_MODE_CTRL			0x0000029c
> +
> +#define REG_DSI_VIDEO_COMPRESSION_MODE_CTRL2			0x000002a0
> +
> +#define REG_DSI_COMMAND_COMPRESSION_MODE_CTRL			0x000002a4
> +
> +#define REG_DSI_COMMAND_COMPRESSION_MODE_CTRL2			0x000002a8
> +
> +#define REG_DSI_COMMAND_COMPRESSION_MODE_CTRL3			0x000002ac
> +
>   #endif /* DSI_XML */
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index ba24458c2e38..86e36a3e97b6 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -946,6 +946,26 @@ static void dsi_ctrl_config(struct msm_dsi_host *msm_host, bool enable,
>   		dsi_write(msm_host, REG_DSI_CPHY_MODE_CTRL, BIT(0));
>   }
>   
> +static int dsi_dsc_update_pic_dim(struct msm_display_dsc_config *dsc,
> +				  int pic_width, int pic_height)
> +{
> +	if (!dsc || !pic_width || !pic_height) {
> +		pr_err("DSI: invalid input: pic_width: %d pic_height: %d\n", pic_width, pic_height);
> +		return -EINVAL;
> +	}
> +
> +	if ((pic_width % dsc->drm->slice_width) || (pic_height % dsc->drm->slice_height)) {
> +		pr_err("DSI: pic_dim %dx%d has to be multiple of slice %dx%d\n",
> +		       pic_width, pic_height, dsc->drm->slice_width, dsc->drm->slice_height);
> +		return -EINVAL;
> +	}

This should go to the mode_valid() callback for the dsi_bridge.

> +
> +	dsc->drm->pic_width = pic_width;
> +	dsc->drm->pic_height = pic_height;
> +
> +	return 0;
> +}
> +
>   static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>   {
>   	struct drm_display_mode *mode = msm_host->mode;
> @@ -978,7 +998,72 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>   		hdisplay /= 2;
>   	}
>   
> +	if (msm_host->dsc) {
> +		struct msm_display_dsc_config *dsc = msm_host->dsc;
> +
> +		/* update dsc params with timing params */
> +		dsi_dsc_update_pic_dim(dsc, mode->hdisplay, mode->vdisplay);
> +		DBG("Mode Width- %d x Height %d\n", dsc->drm->pic_width, dsc->drm->pic_height);
> +
> +		/* we do the calculations for dsc parameters here so that
> +		 * panel can use these parameters
> +		 */
> +		dsi_populate_dsc_params(dsc);
> +
> +		/* Divide the display by 3 but keep back/font porch and
> +		 * pulse width same
> +		 */
> +		h_total -= hdisplay;
> +		hdisplay /= 3;
> +		h_total += hdisplay;
> +		ha_end = ha_start + hdisplay;
> +	}
> +
>   	if (msm_host->mode_flags & MIPI_DSI_MODE_VIDEO) {
> +		if (msm_host->dsc) {
> +			struct msm_display_dsc_config *dsc = msm_host->dsc;
> +			u32 reg, intf_width, slice_per_intf;
> +			u32 total_bytes_per_intf;
> +
> +			/* first calculate dsc parameters and then program
> +			 * compress mode registers
> +			 */
> +			intf_width = hdisplay;
> +			slice_per_intf = DIV_ROUND_UP(intf_width, dsc->drm->slice_width);
> +
> +			/* If slice_count > slice_per_intf, then use 1
> +			 * This can happen during partial update
> +			 */
> +				dsc->drm->slice_count = 1;

Is the if() missing here? The indentpation and the comment seems unclear 
about that.

> +
> +			dsc->bytes_in_slice = DIV_ROUND_UP(dsc->drm->slice_width * 8, 8);
> +			total_bytes_per_intf = dsc->bytes_in_slice * slice_per_intf;
> +
> +			dsc->eol_byte_num = total_bytes_per_intf % 3;
> +			dsc->pclk_per_line =  DIV_ROUND_UP(total_bytes_per_intf, 3);
> +			dsc->bytes_per_pkt = dsc->bytes_in_slice * dsc->drm->slice_count;
> +			dsc->pkt_per_line = slice_per_intf / dsc->drm->slice_count;
> +
> +			reg = dsc->bytes_per_pkt << 16;
> +			reg |= (0x0b << 8);    /* dtype of compressed image */
> +
> +			/* pkt_per_line:
> +			 * 0 == 1 pkt
> +			 * 1 == 2 pkt
> +			 * 2 == 4 pkt
> +			 * 3 pkt is not supported
> +			 * above translates to ffs() - 1
> +			 */
> +			reg |= (ffs(dsc->pkt_per_line) - 1) << 6;
> +
> +			dsc->eol_byte_num = total_bytes_per_intf % 3;
> +			reg |= dsc->eol_byte_num << 4;
> +			reg |= 1;
> +
> +			dsi_write(msm_host,
> +				  REG_DSI_VIDEO_COMPRESSION_MODE_CTRL, reg);
> +		}
> +
>   		dsi_write(msm_host, REG_DSI_ACTIVE_H,
>   			DSI_ACTIVE_H_START(ha_start) |
>   			DSI_ACTIVE_H_END(ha_end));
> @@ -997,8 +1082,40 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>   			DSI_ACTIVE_VSYNC_VPOS_START(vs_start) |
>   			DSI_ACTIVE_VSYNC_VPOS_END(vs_end));
>   	} else {		/* command mode */
> +		if (msm_host->dsc) {
> +			struct msm_display_dsc_config *dsc = msm_host->dsc;
> +			u32 reg, reg_ctrl, reg_ctrl2;
> +			u32 slice_per_intf, bytes_in_slice, total_bytes_per_intf;
> +
> +			reg_ctrl = dsi_read(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL);
> +			reg_ctrl2 = dsi_read(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL2);
> +
> +			slice_per_intf = DIV_ROUND_UP(hdisplay, dsc->drm->slice_width);
> +			bytes_in_slice = DIV_ROUND_UP(dsc->drm->slice_width *
> +						      dsc->drm->bits_per_pixel, 8);
> +			dsc->drm->slice_chunk_size = bytes_in_slice;
> +			total_bytes_per_intf = dsc->bytes_in_slice * slice_per_intf;
> +			dsc->pkt_per_line = slice_per_intf / dsc->drm->slice_count;
> +
> +			reg = 0x39 << 8;
> +			reg |= ffs(dsc->pkt_per_line) << 6;
> +
> +			dsc->eol_byte_num = total_bytes_per_intf % 3;
> +			reg |= dsc->eol_byte_num << 4;
> +			reg |= 1;
> +
> +			reg_ctrl |= reg;
> +			reg_ctrl2 |= bytes_in_slice;
> +
> +			dsi_write(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL, reg);
> +			dsi_write(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL2, reg_ctrl2);
> +		}
> +
>   		/* image data and 1 byte write_memory_start cmd */
> -		wc = hdisplay * dsi_get_bpp(msm_host->format) / 8 + 1;
> +		if (!msm_host->dsc)
> +			wc = hdisplay * dsi_get_bpp(msm_host->format) / 8 + 1;
> +		else
> +			wc = mode->hdisplay / 2 + 1;
>   
>   		dsi_write(msm_host, REG_DSI_CMD_MDP_STREAM0_CTRL,
>   			DSI_CMD_MDP_STREAM0_CTRL_WORD_COUNT(wc) |
> @@ -2074,6 +2191,7 @@ int msm_dsi_host_modeset_init(struct mipi_dsi_host *host,
>   	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
>   	const struct msm_dsi_cfg_handler *cfg_hnd = msm_host->cfg_hnd;
>   	struct platform_device *pdev = msm_host->pdev;
> +	struct msm_drm_private *priv;
>   	int ret;
>   
>   	msm_host->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> @@ -2093,6 +2211,9 @@ int msm_dsi_host_modeset_init(struct mipi_dsi_host *host,
>   	}
>   
>   	msm_host->dev = dev;
> +	priv = dev->dev_private;
> +	priv->dsc = msm_host->dsc;
> +
>   	ret = cfg_hnd->ops->tx_buf_alloc(msm_host, SZ_4K);
>   	if (ret) {
>   		pr_err("%s: alloc tx gem obj failed, %d\n", __func__, ret);
> 


-- 
With best wishes
Dmitry
