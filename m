Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06844216C5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 20:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238839AbhJDSpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 14:45:23 -0400
Received: from mail-oo1-f44.google.com ([209.85.161.44]:36811 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbhJDSpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:45:22 -0400
Received: by mail-oo1-f44.google.com with SMTP id e19-20020a4a7353000000b002b5a2c0d2b8so5684024oof.3;
        Mon, 04 Oct 2021 11:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Sw1yCcNjlcEZahirJYZlRkQErG1heT9ucgcVXSUfTss=;
        b=NgxgWOtv6Cz4U38dbVo8mFfDLYiRtQXXnyKZw+XhCCCxtKv1KTydPbixOh20FOAD4h
         nTJZ1O+sqiLAkstt68qPQiCIyIPWRqK2JnWG9DtLotAmACVyparL1BFC3Kcox1g4hPnA
         Tbei4wmxl+xXvHU/xpTNWjb5nb7vJchDQ1A0j7UMLzM7q8oL9a9xjTNsOHe5Jlwgq9nk
         A4hyS3aNjHeVIrOnlDj1VMm3N8ZutoYNFVPAK4Quu2AWTK8jiyynJXk9gflLhMvalCdL
         8KgV2Zz5zsoElsdt9xPtZBiyjyuTWl0irdRSRoo+Rp145ztuJBMdYVw9U222WbZFjZoF
         uFIg==
X-Gm-Message-State: AOAM533caRZ86lwEkKLMSQO50MzedeiiPV3Va1y6R6230VKnMQzFHuCC
        QPREF/bo8/9I1BoY9paA9w==
X-Google-Smtp-Source: ABdhPJzav+dvMDR6RhuiAO24LG3wPQ6o/vp3rOg0hiT+Z9mNaM6aOWmiPugSRJJ96McZ4bWc5oRCZA==
X-Received: by 2002:a4a:a9ce:: with SMTP id h14mr10132095oon.89.1633373013061;
        Mon, 04 Oct 2021 11:43:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u12sm3074893otq.20.2021.10.04.11.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:43:32 -0700 (PDT)
Received: (nullmailer pid 1636276 invoked by uid 1000);
        Mon, 04 Oct 2021 18:43:31 -0000
Date:   Mon, 4 Oct 2021 13:43:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>
Cc:     Sinthu Raja <sinthu.raja@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, devicetree@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V3 1/4] dt-bindings: arm: ti: Add compatible for J721E SK
Message-ID: <YVtLU1S6vp8oOqNP@robh.at.kernel.org>
References: <20210929081333.26454-1-sinthu.raja@ti.com>
 <20210929081333.26454-2-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210929081333.26454-2-sinthu.raja@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2021 13:43:30 +0530, Sinthu Raja wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> J721E Starter Kit (SK)[1] is a low cost, small form factor board
> designed for TI’s J721E SoC. Add j721e-sk into compatible enum.
> 
> [1]https://www.ti.com/tool/SK-TDA4VM
> 
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> ---
> 
> Changes in V3:
> * Addressed review comments.
> * Added Board URL to the commit description.
> 
> V2: https://lore.kernel.org/all/20210607093314.23909-2-sinthu.raja@ti.com/
> V1: https://lore.kernel.org/all/20210602182237.12632-2-sinthu.raja@ti.com/
> 
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
