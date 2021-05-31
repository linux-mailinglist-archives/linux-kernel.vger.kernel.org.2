Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC2D3958F6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 12:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhEaKe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 06:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbhEaKeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 06:34:23 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08BEC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 03:32:42 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id g204so2733585wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 03:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cWWmu24DcI6+LxTaWh70NPaWRoUZ7MO3IMlEue/FVZA=;
        b=E3ThoyhlIPMxXwWUDLm6t+clN2naDQPjv4zJHwNgZaDEewyyuEPiSY7QzdCEztPYQF
         XMXb6phaOMpvw1EoXt3C9vb/fAjEbkgS041Vt3BOvaNykF95ep0zekBHbG2iOJJA6HNs
         LRhOLz8nqaXHYKeDvVOVH89UKKer3v6nD5oThOJuuMH88agpVuuZRmvdLo6wLiYzmHhU
         hZEZn7MHs4tZtLCD0QErlzDY1XXZyoQnGpqA4EPd3tysy4BpdQH/fhtG1oXtfzSpFvCz
         As63y9bZyIGRvVP2EhLpi0xwXcz46xCTAUgW/Hpc2tPwmrhejalr8QhTdYFzTmRaMedE
         EPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cWWmu24DcI6+LxTaWh70NPaWRoUZ7MO3IMlEue/FVZA=;
        b=sqoMK8JiZDQSbx6j06qDQ8vbSK0tEIN0eIA2eTjZAtg/ezD7+vJ21gjymi3dCA7F/2
         8QplJXke/SoewaszWppvLVNAgakhZ0j6sgVdBUOzJGoRFj1EeJRQhuJ7aqGosRcGx/TL
         kVgaSetu+9SQ7aKe/7zCj0WU9nxqkiySdcnH70taDyis47WbRTxr61/msG1EDPv+6I0f
         jQJjY49cUai7Z0XcWvT6by04nCLFV7xFS8jRsKJS/yXyT8HKdy9sqwhkh0bEeJVcBNXe
         t/yq7WKQ1OJPs8aA6R57fFSNERo5wXuHOkUHuZ2uD3y70TBcE1VRDD1w2V3Wy3KvhWku
         sGPg==
X-Gm-Message-State: AOAM533K/BWdwGAj6nCVaD8hCE+z7V1QGbSiqKizt8+ZxhFUa0XTZBwb
        22h7yRCEBjZ4Elgzb3Nw/VCCoZE0FySoC3FK
X-Google-Smtp-Source: ABdhPJz4UvlPrI9eDd5ZIGlvRHY+p+kPB+/Nje+MbHgp30dF+y32DbsnFSqzHCU5tEckYqc5Jf8TFw==
X-Received: by 2002:a7b:c761:: with SMTP id x1mr9892260wmk.118.1622457161431;
        Mon, 31 May 2021 03:32:41 -0700 (PDT)
Received: from [192.168.1.28] (hst-221-34.medicom.bg. [84.238.221.34])
        by smtp.googlemail.com with ESMTPSA id y20sm25122822wmi.0.2021.05.31.03.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 03:32:41 -0700 (PDT)
Subject: Re: [PATCH 5/7] venus: vdec: set work route to fw
To:     Dikshita Agarwal <dikshita@codeaurora.org>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vgarodia@codeaurora.org
References: <1621417008-6117-1-git-send-email-dikshita@codeaurora.org>
 <1621417008-6117-6-git-send-email-dikshita@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <6a17e585-2714-6ed2-2526-56b4e0bf61b8@linaro.org>
Date:   Mon, 31 May 2021 13:32:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1621417008-6117-6-git-send-email-dikshita@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/21 12:36 PM, Dikshita Agarwal wrote:
> Set work route to FW based on num of vpp pipes.
> 
> Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/hfi_cmds.c   |  7 +++++++
>  drivers/media/platform/qcom/venus/hfi_helper.h |  5 +++++
>  drivers/media/platform/qcom/venus/vdec.c       | 21 +++++++++++++++++++++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
> index 11a8347..837fb80 100644
> --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
> @@ -1290,6 +1290,13 @@ pkt_session_set_property_6xx(struct hfi_session_set_property_pkt *pkt,
>  		pkt->shdr.hdr.size += sizeof(u32) + sizeof(*color);
>  		break;
>  	}
> +	case HFI_PROPERTY_PARAM_WORK_ROUTE: {
> +		struct hfi_video_work_route *in = pdata, *wr = prop_data;
> +
> +		wr->video_work_route = in->video_work_route;
> +		pkt->shdr.hdr.size += sizeof(u32) + sizeof(*wr);
> +		break;
> +	}
>  	default:
>  		return pkt_session_set_property_4xx(pkt, cookie, ptype, pdata);
>  	}
> diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
> index 63cd347..185c302 100644
> --- a/drivers/media/platform/qcom/venus/hfi_helper.h
> +++ b/drivers/media/platform/qcom/venus/hfi_helper.h
> @@ -451,6 +451,7 @@
>  #define HFI_PROPERTY_PARAM_MVC_BUFFER_LAYOUT			0x100f
>  #define HFI_PROPERTY_PARAM_MAX_SESSIONS_SUPPORTED		0x1010
>  #define HFI_PROPERTY_PARAM_WORK_MODE				0x1015
> +#define HFI_PROPERTY_PARAM_WORK_ROUTE				0x1017
>  
>  /*
>   * HFI_PROPERTY_CONFIG_COMMON_START
> @@ -864,6 +865,10 @@ struct hfi_video_work_mode {
>  	u32 video_work_mode;
>  };
>  
> +struct hfi_video_work_route {
> +	u32 video_work_route;
> +};
> +
>  struct hfi_h264_vui_timing_info {
>  	u32 enable;
>  	u32 fixed_framerate;
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index ddb7cd3..a674281 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -653,6 +653,21 @@ static int vdec_set_properties(struct venus_inst *inst)
>  	return 0;
>  }
>  
> +static int vdec_set_work_route(struct venus_inst *inst)
> +{
> +	struct hfi_video_work_route wr;
> +	u32 ptype;
> +	int ret;
> +
> +	wr.video_work_route = inst->core->res->num_vpp_pipes;
> +
> +	ptype = HFI_PROPERTY_PARAM_WORK_ROUTE;
> +	ret = hfi_session_set_property(inst, ptype, &wr);
> +	if (ret)
> +		return ret;
> +	return 0;
> +}
> +
>  #define is_ubwc_fmt(fmt) (!!((fmt) & HFI_COLOR_FORMAT_UBWC_BASE))
>  
>  static int vdec_output_conf(struct venus_inst *inst)
> @@ -1039,6 +1054,12 @@ static int vdec_start_output(struct venus_inst *inst)
>  	if (ret)
>  		return ret;
>  
> +	if (IS_V6(inst->core)) {

Please move this IS_V6 check in vdec_set_work_route().

> +		ret = vdec_set_work_route(inst);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = vdec_output_conf(inst);
>  	if (ret)
>  		return ret;
> 

-- 
regards,
Stan
