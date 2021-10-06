Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A6942394F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237664AbhJFIDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237685AbhJFICe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:02:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4C5C06174E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 01:00:40 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k7so5955004wrd.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 01:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DgBhWLICPv7pMhjFtnPurEZqoS+TS0nmbrNFYc6tYO8=;
        b=opVJgEVsqMMtrebK6OYEi00O4gbEAqVqoNwUJlc3zGQ1v4VscpU2OH+YJcAO5apMmS
         dQiAJZqOGZcz1guEG9BxmS23pxhXi429RTDKy8+iQmlQtxCdQEQ2473IwmDGDaOkPDdR
         hbijKdUQrRDcYD46BK5Ks0nOaOCosDjLs8lkNkbRINjSTTC+FK5hlln9aMM+LW5l8CvF
         enwkBwCqtIXTDrHbGw49v+GebNGxzXNQdGnRd1us+TIoT3TSyPhhfdhNmiQu6KTVLw76
         OmXO0chwBq4GRbhSN23DDfoXM5LMCaVaGPGeV4Q7rWHBQiDLl3H4QhhdZGYT8vQIDpnS
         tloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DgBhWLICPv7pMhjFtnPurEZqoS+TS0nmbrNFYc6tYO8=;
        b=EKExCTKTwBPN0NMbJsKGSvcA+55xjMEGOPwHkogdcnmEVjXS/xzCv8EerFfWAj3wWm
         Ng6e3SIm5c2q/dYICn6bmVV9WeDJ2qUfehM5V0RNYZMNE1Mf2aP/shLFcg4P6Jg4SqTU
         RnfIUfCDalsoRqreZkjygqyZwmKYU+0SFWySLawIUpanzhkdX5BXMSqCAYZGn4LEBC/e
         GriHhObSrL4j3dF/VjWW5+7giNhuXTThIG5CrSdC14DVicX/kJwp1l1f7FgSM2fKsxQ0
         1gQuuGUkkRl8Dv3zDJVwD5Ybk06pxpLwux0Iwdy3FPlI4mLnS4GLhV0KOZ203uJS+haN
         0+2w==
X-Gm-Message-State: AOAM5302gnbLwkuqyX0GSu8dHCYDGHgqSaLJcCjxvE9Metez7EHX7urd
        L/HDCgE6tOy+bTwLhSdoYacAiA==
X-Google-Smtp-Source: ABdhPJxEuBQoPN9bsXR6MdCXoIERK92y9INjOmodZ+EhamGEhX0mQRx/MN6GHqngkDN8iA76J7ADwg==
X-Received: by 2002:a5d:500f:: with SMTP id e15mr12227550wrt.90.1633507239224;
        Wed, 06 Oct 2021 01:00:39 -0700 (PDT)
Received: from google.com ([95.148.6.175])
        by smtp.gmail.com with ESMTPSA id w11sm1125405wmc.44.2021.10.06.01.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 01:00:38 -0700 (PDT)
Date:   Wed, 6 Oct 2021 09:00:36 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
Message-ID: <YV1XpL7ibF1y4LbV@google.com>
References: <20210923064137.60722-1-zhang.lyra@gmail.com>
 <20210923064137.60722-3-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210923064137.60722-3-zhang.lyra@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021, Chunyan Zhang wrote:

> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Add bindings for Unisoc system global register which provide register map
> for clocks.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml

Unapplied v3 and applied this (v4) instead, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
