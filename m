Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE97D342C8F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhCTLyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhCTLxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:53:48 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFC2C061762
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 04:53:47 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id 61so11745588wrm.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 04:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HpQiKE3viHQSmvStiXLE6V0egAkgaoLKibEIaY1h13E=;
        b=okHpkw/X0VJ4lMjNB9cAJGz2PjVaXC+MPbUkivZ9fGCWs3nY9LQL5Lz26wz2cNZpZz
         cuOH/uSjyh+kd8Ha2Gw7sgM5jCe8ubar6oVmHwg96pZ22FeulDANrmjC1kD5IXKjecE9
         7Q11bCt/vZCj52UV/MP9P5UyGZU4dlwf/gfSkf78MBWiWOVnyA7HithvIsny4f53ZkzT
         92uO8YtfZ70InSes/RPS3HectFyRJuEvDGg+MW/qQkrvg6tr4dg6lQ8BNmibtvhqgt7n
         /cROngbJMfkr5bNjNT2NfPrrXgEYbc0rYh/oyN1VbYDJuzPxsJXRxiQXJAI4bjzPDWet
         OEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HpQiKE3viHQSmvStiXLE6V0egAkgaoLKibEIaY1h13E=;
        b=sc7ZY5y31/l/UQFsNpsVg0eLferTi+QtzvbSehpjhSxeeZE+3jPEnOwcuv96rfyzoD
         Ave+M+8qJfwzdYhlQrm8h2cACqSMf5jDqm7+AGNJecD+wMdCnDt8gcgtkyyq3gKJkBwc
         AIHQ5Z5AJzJeR5kHeg33r2OwgV9AXm1jNTBrV5AFrVhKhRu2jehi5gTXQnzRgjHDfmMT
         GZEMpmofI4KzBLzynZ/MV7zYtuRkSWts+fktJCIEn2WHBquwfQj2xVDAuNBYt0s+S+eY
         RujhOpoCrl1FFO37IoALH3oU1si8hm6xj2WDdZqBch9ioe9o1Tt4fwTNodnLvNm0DmvX
         ne9Q==
X-Gm-Message-State: AOAM5338VLPrkUk9X9yQDgNP2kD45zuvnVblgc4HoL/Y3UmGvb9tlrux
        fruwjRj6h81PegeF/EKW6WalFA==
X-Google-Smtp-Source: ABdhPJwJ+Nxbe35r4gLdYKYJiqjTHuD0dox6anBfnURf73Y/XDFwRC/J09HLdInfhvtmhFBWwDq79g==
X-Received: by 2002:a5d:518c:: with SMTP id k12mr9134434wrv.15.1616241226623;
        Sat, 20 Mar 2021 04:53:46 -0700 (PDT)
Received: from [192.168.1.9] (hst-208-211.medicom.bg. [84.238.208.211])
        by smtp.googlemail.com with ESMTPSA id m14sm8907193wmi.27.2021.03.20.04.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Mar 2021 04:53:46 -0700 (PDT)
Subject: Re: [PATCH] v4l2-ctrls: Fix h264 hierarchical coding type menu ctrl
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>
References: <20210302224206.3680649-1-stanimir.varbanov@linaro.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <c8d448f1-bbe2-eb21-987a-877251d7aead@linaro.org>
Date:   Sat, 20 Mar 2021 13:53:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210302224206.3680649-1-stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kindly ping for review.

On 3/3/21 12:42 AM, Stanimir Varbanov wrote:
> Add a name of the menu and fill control type.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/v4l2-core/v4l2-ctrls.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
> index 016cf6204cbb..5d99e2294335 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
> @@ -421,6 +421,11 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
>  		"Annex B Start Code",
>  		NULL,
>  	};
> +	static const char * const h264_hierarchical_coding_type[] = {
> +		"Hier Coding B",
> +		"Hier Coding P",
> +		NULL,
> +	};
>  	static const char * const mpeg_mpeg2_level[] = {
>  		"Low",
>  		"Main",
> @@ -697,6 +702,8 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
>  		return h264_decode_mode;
>  	case V4L2_CID_STATELESS_H264_START_CODE:
>  		return h264_start_code;
> +	case V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_TYPE:
> +		return h264_hierarchical_coding_type;
>  	case V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL:
>  		return mpeg_mpeg2_level;
>  	case V4L2_CID_MPEG_VIDEO_MPEG2_PROFILE:
> @@ -1326,6 +1333,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>  	case V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_IDC:
>  	case V4L2_CID_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE:
>  	case V4L2_CID_MPEG_VIDEO_H264_FMO_MAP_TYPE:
> +	case V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_TYPE:
>  	case V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL:
>  	case V4L2_CID_MPEG_VIDEO_MPEG2_PROFILE:
>  	case V4L2_CID_MPEG_VIDEO_MPEG4_LEVEL:
> 

-- 
regards,
Stan
