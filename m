Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00863F4871
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 12:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbhHWKRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 06:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbhHWKRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 06:17:35 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB63C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 03:16:53 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id j187so14916697pfg.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 03:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9sK/RO+vAHWLBWoM3ZyA29r4bWb/1hcnS47SNH5khGc=;
        b=wQBC/gwt1+LStQC2ASYvn+IHLUg1RkDC7LLqbN852KwAQDHhT7TvSognZ5nzBxFR8Y
         f0+WCGa4TsHPsSI+esH7OPVRGqU+gOqsgyi1cGgx7DgMOZEfpQFzmsCpo9clJte0DI0J
         D46kyX45RpcOK6WNk0hwAQht6Z5+xpZ3dti1KfOfkQMdru5v7J7VFz16cmeTisU8/xXQ
         QtE0Wp0V3ZTjmQjs8NosQQrxYcGkKaCBgniW6eKWE5bHk5T0uKP6qpVX2QKuNtHzjWmz
         800yWoY4Rb0KzL6mX1yGLo0lMU7DQKPDGylyPd84FsF1ar8fBlPeeeF5JHq039hw5qtJ
         BXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9sK/RO+vAHWLBWoM3ZyA29r4bWb/1hcnS47SNH5khGc=;
        b=cDyikVjZmCHjoKASSJjwVrrJnyVkTQWUnsw9JDFCRUYN1xWapQwTvCW7n7xyQbUz+/
         rAw956v1a/R3iIAl0L8HNelcZNMUjhuwtUj6HORUPiIm4j/X2t6VLsIR/OaRk+xG8A60
         lnvl1SIeQ0gIzPSchYYIc2835jiSNw5Ou/N3bDx6ZEQ+0ukKoyJqGN0HNXScMVCQQcKG
         xEcaSyssYXXhJy7K9IdfoBGGZoWvNH8CQI+vyZPa99KGvdQ3JfHJgOnI2P2oFQ+FH3NO
         vvzDJMKPGqBFB8/XSHyWYcxGiT3FXHlE0nfyBBGMQp+eBoQZbZ8/iTXLnskbE7QGV93/
         UwrQ==
X-Gm-Message-State: AOAM533hxvxYzaGXS6J/mSUR/Yn5D1GAV7F2Mm70sGvuPJWT/Edb6T7V
        8uYdCSVWXZRQ9PRmfY1VbMUFpA==
X-Google-Smtp-Source: ABdhPJyRWj7JJ3uSCqHFjtFJri25dJ4A+gm2UzaZ6kNWYFkB1lyGxchigxCWWxBH8xmZnrvu7go3+g==
X-Received: by 2002:a63:5f88:: with SMTP id t130mr31596784pgb.6.1629713812275;
        Mon, 23 Aug 2021 03:16:52 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:bc5a:af6a:3f08:a084])
        by smtp.gmail.com with ESMTPSA id x42sm15258542pfh.205.2021.08.23.03.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 03:16:51 -0700 (PDT)
Date:   Mon, 23 Aug 2021 18:16:47 +0800
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
Subject: Re: [PATCH 3/9] media: mtk-vcodec: Rewrite venc power manage
 interface
Message-ID: <YSN1j7o5+Tzk0HlH@google.com>
References: <20210816105934.28265-1-irui.wang@mediatek.com>
 <20210816105934.28265-4-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816105934.28265-4-irui.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 06:59:28PM +0800, Irui Wang wrote:
> @@ -105,6 +106,14 @@ static int mtk_venc_comp_probe(struct platform_device *pdev)
>  
>  	comp_dev->plat_dev = pdev;
>  
> +	ret = mtk_vcodec_init_enc_pm(pdev, &comp_dev->pm);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to get venc component clock source!");
> +		return ret;
> +	}
> +
> +	pm_runtime_enable(&pdev->dev);
mtk_vcodec_init_enc_pm() and mtk_vcodec_release_enc_pm() is more like a pair.  Does it make more sense to call pm_runtime_enable() in mtk_vcodec_init_enc_pm()?
