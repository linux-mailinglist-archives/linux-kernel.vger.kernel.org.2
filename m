Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E54042E138
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 20:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhJNS3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 14:29:25 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:44826 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhJNS3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:29:23 -0400
Received: by mail-ot1-f50.google.com with SMTP id d21-20020a9d4f15000000b0054e677e0ac5so9393227otl.11;
        Thu, 14 Oct 2021 11:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jGWC+lR+wYDbVMT1L1ZZC3h5YgJZrg1Y2aF9+H5HLgM=;
        b=MHEjVLzoZDjEGmv21Bwc0sQdMLiVJwcSX802TBXwCsNuvuBLg0CPMU72riKt1YPW6v
         h66KbYJohtTlO1ihbMvE0R+efUzyqML31rX5wreb5AxJ7huVjtB0Fsd+rFBvKuDaEDY6
         L1IdntOfznq6bLufHQ6hDCa5HQ1tVyUcEh0WkMYsrSfkDbOdKwxfkG7xGgXDYCyrGldH
         OETpBu99HMDycSrWiizMKrHiiUwI88iW7oAzwIOdqYjzLIQdY/00kkFfvNayIhZAV2EY
         qxcDqOGUpRqHHShWsIc+xpEQrielNCRHwxooOsaUwo1PQfulCt5kF5Vp8rVwSGinVFtD
         JDPg==
X-Gm-Message-State: AOAM532xLySqTQLdX3MZ0l0L0lx7y1QB4oHDcKULmCW7vIUejRyF38nx
        V2Mt8IPxePFKUS1+UD7tMw==
X-Google-Smtp-Source: ABdhPJxq1tjfJ4eSnrpN3v3d8W+/LguMMn1W0plg0+QEbNeXwX6LOWFGzG6Lh/sveYBHYh+4NFca3w==
X-Received: by 2002:a05:6830:58:: with SMTP id d24mr3993873otp.22.1634236038219;
        Thu, 14 Oct 2021 11:27:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v13sm765599otn.41.2021.10.14.11.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 11:27:17 -0700 (PDT)
Received: (nullmailer pid 3680304 invoked by uid 1000);
        Thu, 14 Oct 2021 18:27:16 -0000
Date:   Thu, 14 Oct 2021 13:27:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        john@phrozen.org, sboyd@kernel.org, neil@brown.name
Subject: Re: [PATCH v2 2/4] dt-bindings: clock: mediatek,mt7621-sysc: add
 '#reset-cells' property
Message-ID: <YWh2hMwNMxwNWeBu@robh.at.kernel.org>
References: <20211006112306.4691-1-sergio.paracuellos@gmail.com>
 <20211006112306.4691-3-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006112306.4691-3-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Oct 2021 13:23:04 +0200, Sergio Paracuellos wrote:
> Make system controller a reset provider for all the peripherals in the
> MT7621 SoC adding '#reset-cells' property.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  .../bindings/clock/mediatek,mt7621-sysc.yaml         | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
