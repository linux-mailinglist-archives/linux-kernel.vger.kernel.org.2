Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6137543D3A5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 23:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244242AbhJ0VQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 17:16:56 -0400
Received: from mail-oo1-f46.google.com ([209.85.161.46]:33425 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240846AbhJ0VQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 17:16:55 -0400
Received: by mail-oo1-f46.google.com with SMTP id q39-20020a4a962a000000b002b8bb100791so1417858ooi.0;
        Wed, 27 Oct 2021 14:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CJSIZaeEBhe5YMBx9tmH/R7HcOfMOJ6hwZcBR6+Xj2g=;
        b=eb3WQF8cTCDcTf3ByjK0ipypYlyX6BjZbd0hj+2yGUR3gUnQUZNt3vdT0DLZJfyu4k
         TI/rnMtHMewLYw3haeZ/Ee/KV/D59qwAAn98DCaZsWLSowiFI2fgFpaKB1Ypk9jtY8/K
         bux/IKZQGD1mHHVDHwf9YwJDeo+XZ7vV4siVHe1wn4QA7v+sg4aR/I4MFY9ZTVOHeJUh
         7UyxOyQzIDLxCYtQv2mjCdpHTwSWnQyL1sAskRswr8Ykh4p5tsybyRARjz0pjYEkk83W
         /ju2cMaZzpWBMc3rCUzmWm7UK9lCaGDroVmHjICOjPI9urHK1O10UmotIAXA0Otxgmdi
         C2NQ==
X-Gm-Message-State: AOAM532+PuIBhaDCvD+ZlsP46taLJXYw+hkNXseF1E9quGBsEaKwrsdv
        aC3n0vFqrDXb5Ew7117nSw==
X-Google-Smtp-Source: ABdhPJwxt86SP+IAUjo+Patg6hI1/tUjFFwhYzxbtIQW22LLv8M06Hz8oOwlh8gsDUvnimO4DGP2Eg==
X-Received: by 2002:a4a:b307:: with SMTP id m7mr57837ooo.83.1635369268810;
        Wed, 27 Oct 2021 14:14:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h17sm372432otm.69.2021.10.27.14.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:14:28 -0700 (PDT)
Received: (nullmailer pid 2173293 invoked by uid 1000);
        Wed, 27 Oct 2021 21:14:27 -0000
Date:   Wed, 27 Oct 2021 16:14:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Flora Fu <flora.fu@mediatek.com>
Cc:     Ikjoon Jang <ikjn@chromium.org>, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 4/7] dt-bindings: soc: mediatek: apusys: Add new
 document for APU power domain
Message-ID: <YXnBM0XaTU2iPChN@robh.at.kernel.org>
References: <20211023101334.27686-1-flora.fu@mediatek.com>
 <20211023101334.27686-5-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211023101334.27686-5-flora.fu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2021 18:13:31 +0800, Flora Fu wrote:
> Document the bindings for APU power domain on MediaTek SoC.
> 
> Signed-off-by: Flora Fu <flora.fu@mediatek.com>
> ---
>  .../soc/mediatek/mediatek,apu-pm.yaml         | 144 ++++++++++++++++++
>  1 file changed, 144 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
