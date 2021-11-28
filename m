Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00FA4607F6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 18:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358599AbhK1RW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 12:22:26 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:41839 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347400AbhK1RUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 12:20:25 -0500
Received: by mail-ot1-f43.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so22114378otl.8;
        Sun, 28 Nov 2021 09:17:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t3laM0uVi0oECBaViw73fSt0Mhg3t5tnipOH3QejzFE=;
        b=mZstU6t7dmgMF1czQZ6WA7O2HuNam6DuDt047lUmMfDEcrdzLYJ5Mlct/VgtYR98Sa
         AqjTEyz+PQt0GrCFXCqcBLE6N+6P5aRZAJCuUlOba7UPPqOLsb/XwX6ldewuO4Nf2hUV
         ZfY1U6IraMkC7kxAJS947P5sL1iTWD4uF/fS5tnNOEDFveYRUX7QcDQvrHpItW5eylXL
         /3Q+vDFT2lQv9btsH5mysxwTwfOOaYU5VEIz3CunyeheqZQ4j6ST5xri3NCUnjgEGJwg
         lh08DreP96fMlxVrSpnZZ9T3o+Qnb1Z2JghIsY9xeR25aLscRQKRsEevKOw50hmADgdl
         bdoA==
X-Gm-Message-State: AOAM531ggQc+a+8PbyOAqxnGCtlk/4O64MldHPh8pIJMyRIHeu/cGBE+
        NhJpCMiitxVruBDOACrR634t292bOg==
X-Google-Smtp-Source: ABdhPJzdtD8VnESA1+vmlOegt89CJJ9SKpm8umfsVNJjXsfREvZBMNOPJDRmlQbd8kgWFfyDuzKOpQ==
X-Received: by 2002:a9d:7f91:: with SMTP id t17mr39456096otp.197.1638119828643;
        Sun, 28 Nov 2021 09:17:08 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d6:afc8:f6e9:d57a:3e26:ee41])
        by smtp.gmail.com with ESMTPSA id f20sm2478101oiw.48.2021.11.28.09.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 09:17:08 -0800 (PST)
Received: (nullmailer pid 2749380 invoked by uid 1000);
        Sun, 28 Nov 2021 17:17:05 -0000
Date:   Sun, 28 Nov 2021 11:17:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     devicetree@vger.kernel.org, tharvey@gateworks.com,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH V4 3/9] dt-bindings: power: imx8mn: add defines for DISP
 blk-ctrl domains
Message-ID: <YaO5kccgK9rYy6G5@robh.at.kernel.org>
References: <20211128131853.15125-1-aford173@gmail.com>
 <20211128131853.15125-4-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211128131853.15125-4-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Nov 2021 07:18:46 -0600, Adam Ford wrote:
> This adds the defines for the power domains provided by the DISP
> blk-ctrl.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  include/dt-bindings/power/imx8mn-power.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

