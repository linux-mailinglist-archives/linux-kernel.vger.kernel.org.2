Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2B7399417
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhFBT6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:58:47 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:37405 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhFBT6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:58:45 -0400
Received: by mail-pf1-f171.google.com with SMTP id y15so3049175pfl.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 12:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lKbsKx/CwwAJJJ3AtTHNwIW7e/uQT1ru3Qvh7qWozN4=;
        b=C36W36k/YR2ljUGOFpoAKJFu5nQRxby9kwvSxtfLb/imsjGhqUGlv3F7O+9oJ1ptCn
         qp96ZY07ns1fQnEsEV2LkXkYfcb7fBVAZaySltRccEhLmzqDFQ2Sia+DJX697iwh685q
         XSqIR3hZ7Vl4SEUNGZlCvM0oRpLKSGJYyzqWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lKbsKx/CwwAJJJ3AtTHNwIW7e/uQT1ru3Qvh7qWozN4=;
        b=F3Jwk71/uziVSFzmXMUgUt3AFSpBwfbbQjh306M1veELZq3TGyypQWQzXPFar9A+KT
         t230WDI93+MCrTnvUJaf6E/tXAl5W5XeuFaA22gQQqtVnx3ePmflDx2IeHXVyAvYvl1v
         GJlxjmDQAoaFfScp+L2JGv6F/TMJ44NOdpB7/XnO2jCZoCf7tyS9EqfhAB65xg1ZxXu/
         9TdKcU7QJBQfGxNQH3pPIxH/QiJU2Ar9k7qSPWH3ZZbwOOBB6dtUZDVhfx0QQtApz9L5
         jBuWyyrbYIJ8Op72/txEEjkqa3UvlM+1tcaCVCxexpalQ8jDiVl47cTE5Xi7ninkU6P6
         TUOQ==
X-Gm-Message-State: AOAM531gTssR6V69NXnh4wPzH5AoSq/vj7zu5qInrzzJibPNaHjyEDmV
        NMnr+BHnu8cP21FdA0+zLRqRZQ==
X-Google-Smtp-Source: ABdhPJzIPKjT1TLLgSWyjmNLfEFggACWHy09QcHyBfeSTF7lHho5w9YuPL/W/+D2tvDivWu+TScb3Q==
X-Received: by 2002:a05:6a00:d41:b029:2db:1549:219e with SMTP id n1-20020a056a000d41b02902db1549219emr28795898pfv.71.1622663745490;
        Wed, 02 Jun 2021 12:55:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r135sm355480pfc.184.2021.06.02.12.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:55:44 -0700 (PDT)
Date:   Wed, 2 Jun 2021 12:55:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][venus-for-next-v5.14] media: venus: hfi_cmds: Fix packet
 size calculation
Message-ID: <202106021254.39A1561075@keescook>
References: <20210601184616.GA23488@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601184616.GA23488@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 01:46:16PM -0500, Gustavo A. R. Silva wrote:
> Now that a one-element array was replaced with a flexible-array member
> in struct hfi_sys_set_property_pkt, use the struct_size() helper to
> correctly calculate the packet size.
> 
> Fixes: 701e10b3fd9f ("media: venus: hfi_cmds.h: Replace one-element array with flexible-array member")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> BTW... it seems that a similar problem is present in
> https://lore.kernel.org/linux-hardening/20210211001044.GA69612@embeddedor/ 
> and that is what is causing the regression. I will send v2 of that
> patch, shortly. Thanks.
> 
>  drivers/media/platform/qcom/venus/hfi_cmds.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
> index 11a8347e5f5c..c86279e5d6e8 100644
> --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
> @@ -27,7 +27,7 @@ void pkt_sys_idle_indicator(struct hfi_sys_set_property_pkt *pkt, u32 enable)
>  {
>  	struct hfi_enable *hfi = (struct hfi_enable *)&pkt->data[1];
>  
> -	pkt->hdr.size = sizeof(*pkt) + sizeof(*hfi) + sizeof(u32);
> +	pkt->hdr.size = struct_size(pkt, data, 2) + sizeof(*hfi);

I think this should be "1" not "2".

(i.e. there is a single "data" item, followed by an entire *hfi (which
starts immediate after data[0]).

>  	pkt->hdr.pkt_type = HFI_CMD_SYS_SET_PROPERTY;
>  	pkt->num_properties = 1;
>  	pkt->data[0] = HFI_PROPERTY_SYS_IDLE_INDICATOR;
> @@ -39,7 +39,7 @@ void pkt_sys_debug_config(struct hfi_sys_set_property_pkt *pkt, u32 mode,
>  {
>  	struct hfi_debug_config *hfi;
>  
> -	pkt->hdr.size = sizeof(*pkt) + sizeof(*hfi) + sizeof(u32);
> +	pkt->hdr.size = struct_size(pkt, data, 2) + sizeof(*hfi);

Same here.

>  	pkt->hdr.pkt_type = HFI_CMD_SYS_SET_PROPERTY;
>  	pkt->num_properties = 1;
>  	pkt->data[0] = HFI_PROPERTY_SYS_DEBUG_CONFIG;
> @@ -50,7 +50,7 @@ void pkt_sys_debug_config(struct hfi_sys_set_property_pkt *pkt, u32 mode,
>  
>  void pkt_sys_coverage_config(struct hfi_sys_set_property_pkt *pkt, u32 mode)
>  {
> -	pkt->hdr.size = sizeof(*pkt) + sizeof(u32);
> +	pkt->hdr.size = struct_size(pkt, data, 2);

This looks correct.

>  	pkt->hdr.pkt_type = HFI_CMD_SYS_SET_PROPERTY;
>  	pkt->num_properties = 1;
>  	pkt->data[0] = HFI_PROPERTY_SYS_CONFIG_COVERAGE;
> @@ -116,7 +116,7 @@ void pkt_sys_power_control(struct hfi_sys_set_property_pkt *pkt, u32 enable)
>  {
>  	struct hfi_enable *hfi = (struct hfi_enable *)&pkt->data[1];
>  
> -	pkt->hdr.size = sizeof(*pkt) + sizeof(*hfi) + sizeof(u32);
> +	pkt->hdr.size = struct_size(pkt, data, 2) + sizeof(*hfi);

Also 1.

>  	pkt->hdr.pkt_type = HFI_CMD_SYS_SET_PROPERTY;
>  	pkt->num_properties = 1;
>  	pkt->data[0] = HFI_PROPERTY_SYS_CODEC_POWER_PLANE_CTRL;
> -- 
> 2.27.0
> 

-- 
Kees Cook
