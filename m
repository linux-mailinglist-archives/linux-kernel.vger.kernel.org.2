Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4898734BBAD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 10:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhC1IRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 04:17:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhC1IQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 04:16:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5636C61981;
        Sun, 28 Mar 2021 08:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616919396;
        bh=4CuJQ8EA3X0dLjfVJb0qayzZWmk2CnAh0upi7tGjfZQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dvEgRHFDzql1yoMRxwyQIBY7hwZKlwCvrvRWMifQZAJzxFP51wUYl1wwRFkChRwqa
         nAJWpvHyohovK2yCZT7Zd9Vb2FJ3eCkxz7WjngQYLKXvFUPrwgZtRgNLKmTeyoj5bZ
         eYuu9y1xyfCLLLQpexty6dsCVr5PZDV3i54hiQHflRXdTcUCkM01vU/xyHUXHhjeC0
         /0qC1Kkzid4pX2wjKHX3Wk1ryxdrN/rKfCzQe2MsH35T13YTEq/zzES4bknuGeaIP5
         S2XvGX3h76e+dZWUJjjp5GTGcSSO5LDH+QriY1qp16oWptychlYdEO+XsTDOTqg37K
         6yJo+zUEY18WQ==
Received: by mail-oi1-f181.google.com with SMTP id k25so10228165oic.4;
        Sun, 28 Mar 2021 01:16:36 -0700 (PDT)
X-Gm-Message-State: AOAM532Q7lW2w41fTzpfKDTVbGCa1jgumNesXp8nY47NaDkoeKDnJYzQ
        zM7oZ24rQn+ap0Z3IJQ1KCWy64KqjbYS4HVxiEg=
X-Google-Smtp-Source: ABdhPJxYtGzJlX1YL6gQiKAp0fD5CeNsvzjXj5b3i+Gzrj0uoEQbigl2nkQkiN29+h9mnMgNHLPZDMPKdVXYW7Gmydc=
X-Received: by 2002:aca:5945:: with SMTP id n66mr14779649oib.11.1616919395634;
 Sun, 28 Mar 2021 01:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210328074009.95932-1-sven@svenpeter.dev> <20210328074009.95932-3-sven@svenpeter.dev>
In-Reply-To: <20210328074009.95932-3-sven@svenpeter.dev>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 28 Mar 2021 10:16:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3a1k9SyrRLammX8dGF3GjojUVUEZ4cMfb2+g6CXkBNCA@mail.gmail.com>
Message-ID: <CAK8P3a3a1k9SyrRLammX8dGF3GjojUVUEZ4cMfb2+g6CXkBNCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: iommu: add DART iommu bindings
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 9:40 AM Sven Peter <sven@svenpeter.dev> wrote:

I noticed only one detail here:

> +  - |+
> +    dart2a: dart2a@82f00000 {
> +      compatible = "apple,t8103-dart";
> +      reg = <0x82f00000 0x4000>;
> +      interrupts = <1 781 4>;
> +      #iommu-cells = <1>;
> +    };

The name of the iommu should be iommu@82f00000, not dart2a@82f00000.

       Arnd
