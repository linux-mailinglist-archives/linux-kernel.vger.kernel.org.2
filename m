Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE1D43E9F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 23:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhJ1VIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 17:08:24 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:40770 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhJ1VIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 17:08:22 -0400
Received: by mail-oi1-f173.google.com with SMTP id n63so10186570oif.7;
        Thu, 28 Oct 2021 14:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KsAfghJdqjIsPHLQlzuUpGuE0n+L1OQuzADVtlfj3pk=;
        b=LyPtN0frxLcnqybkd82fmv0mvbw9+uFWJMvqf9iB83nDFsFOzN4KnNiusrgykf7hM0
         9Ct+tY3GyQLe3AfMWNfmFAvdya+RcDbQPeiHFCniZu6Czrvxw06ZHmMBZG7zQH1hE7+W
         ekEWIcfvuZ+hZwAtlQTSboQMPRUIeh60+qv+oz/reoseB7ywKmMH7yVDRo7NB9AD2D7R
         Ogka6jPvkhunKGLKOf29bdKzw/v04wzbuyN+u7dIYzn5JAWARs6kAR/taHgEtHH+G4k+
         5TNPmRHIwnOs8E8zJ4MYCq2aqQN+eZNBbSPx/2r4XVIQc3FGhy40B0YrzGL2kfsHvvjG
         ozyg==
X-Gm-Message-State: AOAM532+dNMUwPe5PryeTSVPn3YbtqjePX9yRkUr7IZ6BvQjoFfipmap
        ctZ+eNx53Qz3dNaLEspu6A==
X-Google-Smtp-Source: ABdhPJyXfSMCrvaZuAL3QVu4UZRxA2FWr9gEj9Sdd37w46MDzYEx/5qYwTMWrcMCMZyeNYcURj88cg==
X-Received: by 2002:a05:6808:2cc:: with SMTP id a12mr3449048oid.124.1635455154938;
        Thu, 28 Oct 2021 14:05:54 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 64sm1230495otm.37.2021.10.28.14.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 14:05:54 -0700 (PDT)
Received: (nullmailer pid 585145 invoked by uid 1000);
        Thu, 28 Oct 2021 21:05:53 -0000
Date:   Thu, 28 Oct 2021 16:05:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: phy: uniphier-usb3: Add bindings for
 NX1 SoC
Message-ID: <YXsQsZjDq/Jo7Jup@robh.at.kernel.org>
References: <1634687888-23900-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1634687888-23900-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634687888-23900-2-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 08:58:01 +0900, Kunihiko Hayashi wrote:
> Update USB3-PHY binding document for UniPhier NX1 SoC. Add SS-PHY and
> HS-PHY compatible strings for the SoC to the document.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml | 1 +
>  Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml | 1 +
>  2 files changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
