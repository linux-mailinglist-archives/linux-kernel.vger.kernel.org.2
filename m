Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0A83F5C03
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbhHXKZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236094AbhHXKZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:25:19 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A84C061764
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 03:24:35 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g14so17933509pfm.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 03:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0qA56lHF3PwgnWhkGOpQMcKDSscYjYL3TjQAdBAX2/E=;
        b=OYnUiU/nZmeU0kxrvNOScIJXtl6UXKmEuHbCq+uUf/AaRlVOFYyPn8ZpWBlbAk03qf
         AWQn/KhHq2S+LPMjBjduQ23fXGF+EJkPXMcFA+fxywJvS5cbQxrWE5fscdRhAqXBMn0/
         5k89WPs/NQ1MQqNFO0ugGgczcAtrlsYl43MjFYBa/YNGtrNSd49sRavTBW4DroLx/vaq
         9DuqBb+VvkH002neoLOckr6Uj2DfKJVpLztKc6dp9sGD6NJx8xIDil+Fk3ygymcD7SZO
         OADRVjJy1WqyoiN6+hF6CZDJpCXW+apXn/ASYJt/UpN/Y8hMNX66Dc7T+IGB7WoKdQVA
         zvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0qA56lHF3PwgnWhkGOpQMcKDSscYjYL3TjQAdBAX2/E=;
        b=dx5dFFEiqPe2RxhhFVMYXBauwhl9IIOAQk+eue3NCrLkFQngl0pslun3061Z7XnNBE
         fww4S29ce8uXiDwVkep4Jk0Rr31FPrOJ59FXiSAsE0q5fRtZrbm59pidfDYClpaL6vCs
         qTEH0H4dBVffLaJFv0IeS3m99rSnrasv+YPzmBN80vdCcCgkSA8vJq5rEo/uiiKLA2wp
         VqrUMd/9JHydBR8IoXvSiKx3Q1v6HA2sxWYWK1MgaV7UVTBAKNM8GbnMt9fJkaf6Zimt
         WUHdLTb0SXW3K3FeKUK5pRMzQL85ZA01ViXwAmIx8gKcp8WEFih7TndnjwjPRjczZs//
         dDfA==
X-Gm-Message-State: AOAM532aduAPbv+ZVIknBxEtr4JWPN+qns2tXBEeNG+21K9qG7GSJpuG
        LRHx1J0vyfKoOzN0hC0G9iv0Hg==
X-Google-Smtp-Source: ABdhPJx0BkDDUlgCq7OTq0mI4s8vnsDq/uQELrkK4Koz1nMo01Uh/2XJzFlKLwlaBNIVBif110OJWA==
X-Received: by 2002:a63:e70f:: with SMTP id b15mr36824531pgi.182.1629800674814;
        Tue, 24 Aug 2021 03:24:34 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:4a93:46f4:da9a:4371])
        by smtp.gmail.com with ESMTPSA id r78sm19381040pfc.206.2021.08.24.03.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 03:24:34 -0700 (PDT)
Date:   Tue, 24 Aug 2021 18:24:29 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, Yong Wu <yong.wu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Fritz Koenig <frkoenig@chromium.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 5/9] media: mtk-vcodec: Rewrite venc clock interface
Message-ID: <YSTI3QjTnGZEgwOM@google.com>
References: <20210816105934.28265-1-irui.wang@mediatek.com>
 <20210816105934.28265-6-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816105934.28265-6-irui.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 06:59:30PM +0800, Irui Wang wrote:
> -void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)
> +void mtk_vcodec_enc_clock_on(struct mtk_vcodec_dev *dev, int core_id)
>  {
> -	struct mtk_vcodec_clk *enc_clk = &pm->venc_clk;
> -	int ret, i = 0;
> +	struct mtk_venc_comp_dev *venc;
> +	struct mtk_vcodec_pm *enc_pm;
> +	struct mtk_vcodec_clk *enc_clk;
> +	struct clk		*clk;
To be neat, remove the extra spaces.

> -	ret = mtk_smi_larb_get(pm->larbvenc);
> -	if (ret) {
> -		mtk_v4l2_err("mtk_smi_larb_get larb3 fail %d", ret);
> -		goto clkerr;
I may miss the context but why does it remove mtk_smi_larb_get()?

> -void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm)
> +void mtk_vcodec_enc_clock_off(struct mtk_vcodec_dev *dev, int core_id)
>  {
> -	struct mtk_vcodec_clk *enc_clk = &pm->venc_clk;
> -	int i = 0;
> +	struct mtk_venc_comp_dev *venc;
> +	struct mtk_vcodec_pm *enc_pm;
> +	struct mtk_vcodec_clk *enc_clk;
> +	int i;
>  
> -	mtk_smi_larb_put(pm->larbvenc);
Same here.  Why does it remove mtk_smi_larb_put()?

>  int mtk_venc_enable_comp_hw(struct mtk_vcodec_dev *dev)
>  {
>  	int i, ret;
>  	struct mtk_venc_comp_dev *venc_comp;
> +	struct mtk_vcodec_clk *enc_clk;
> +	int j = 0;
It doesn't need to be initialized.  Can inline to "int i, ret;".
