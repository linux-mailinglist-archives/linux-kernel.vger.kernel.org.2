Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07C734F493
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 00:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbhC3Wq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 18:46:59 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:41681 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbhC3Wqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 18:46:40 -0400
Received: by mail-ot1-f49.google.com with SMTP id l12-20020a9d6a8c0000b0290238e0f9f0d8so17137323otq.8;
        Tue, 30 Mar 2021 15:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aGzeEH5mBTJMAUFMUyumPvxqBcopNYVaqYyCfVRg1PE=;
        b=nJNP9OtAGz2AQR0J7+O7DyCp4tdhwqpwCu9WWVctyKS+LZhQ8bgKDlCPy9X2de1bAd
         CPAblagR3wmzs0viuop8s6KTln8Gu2/25SdR6S0qsdgsomXxh4zoonPfaKNjBOr5Q3Sx
         vUqsc2BbZ3/e61gZ3vQ7TXjwyWJhabjr2hZlPcqFbuG9HO1wsZQt/3NkWMt5ammtxwV5
         eLRjrG+0hSQzaj49ARjJs1tdQDn35Xb5oNAuhv+XxWzgaez3hVLupLVfrwmzOgd2OZmZ
         dK2HCZyWaX0o1KkGXMX0fRzM+C/C5mBsDkaN1VMRwPcVbfGrG16i7+vQVRf59KLdod0F
         6Nww==
X-Gm-Message-State: AOAM532vVTCn4fSKLu9WjSZTyUTf4PKpSGLgb+9h4ZcpjufFFhreQ8c2
        a+VjC/LaHXBTLB0F2GSmPA==
X-Google-Smtp-Source: ABdhPJzcaM6kUVKoGLiXQ246HIWyIy+Xp/TRzyneLWkFrzP2NKiKBct6ibzozzNzngKcnVWjng9qdw==
X-Received: by 2002:a9d:65cf:: with SMTP id z15mr150593oth.310.1617144400277;
        Tue, 30 Mar 2021 15:46:40 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p3sm80707oif.53.2021.03.30.15.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 15:46:39 -0700 (PDT)
Received: (nullmailer pid 852063 invoked by uid 1000);
        Tue, 30 Mar 2021 22:46:38 -0000
Date:   Tue, 30 Mar 2021 17:46:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, broonie@kernel.org, perex@perex.cz,
        devicetree@vger.kernel.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: ak5558: Add compatible string for
 ak5552
Message-ID: <20210330224638.GA852033@robh.at.kernel.org>
References: <1617085972-6094-1-git-send-email-shengjiu.wang@nxp.com>
 <1617085972-6094-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617085972-6094-2-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 14:32:52 +0800, Shengjiu Wang wrote:
> Add compatible string "asahi-kasei,ak5552" for ak5552
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/ak5558.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
