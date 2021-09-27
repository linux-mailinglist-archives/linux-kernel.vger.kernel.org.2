Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F4A41A0ED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 23:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbhI0VBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 17:01:40 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:39612 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhI0VBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:01:39 -0400
Received: by mail-ot1-f43.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so26211789ota.6;
        Mon, 27 Sep 2021 14:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hfxAWgi9IMrylht0jZi+Ig2uHEKFPTa9u+u7zjuCrqg=;
        b=LDcCQUhqJEuGNn2T+btTWFSJ63Dh8AvYflOohev7cbMYXtYrhbMhN0PoGHm493NeDq
         nwnAdZV8oSA7SZNQLVclYliOP1KIQSw6fW1sr/6pnO5ZUhdWjKKrDn3Q6Z9Sz001Kg4+
         9XxpJgLEpxOFCTXF2vFqGPG6m8Cnez3qYO42xSF3Y2fp3s9qJH702bd+U3p8+t8giowd
         WbLF/klOS2BsZJmRZJYXoYemVrrOIldbYZnXb60VvNl8HtXdcRzNuGCNfzSdYXCPJf9v
         7pfmVzQF1mI4xq6Nil+2OKOXq9FW6ELOx0vUwo12cYASYFsMdQpzxvs/mKdtYLdccjVk
         hQeQ==
X-Gm-Message-State: AOAM5329IQAwXhT9zbBgJswTipdupNK5oC1JGw9d16Zi8qkbhwGFz5ym
        PG+C5w0h1QMs7GbdC2qv2w==
X-Google-Smtp-Source: ABdhPJzJDxoA1sPhYLp9QFMrH/V+8MB+O8p7EXLsBwQzCZwL3dxpxDjcpK8itOQsQUJ6kwxuFOgEWg==
X-Received: by 2002:a05:6830:214c:: with SMTP id r12mr1874891otd.200.1632776400371;
        Mon, 27 Sep 2021 14:00:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u2sm2501724otg.51.2021.09.27.13.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 13:59:59 -0700 (PDT)
Received: (nullmailer pid 3864707 invoked by uid 1000);
        Mon, 27 Sep 2021 20:59:58 -0000
Date:   Mon, 27 Sep 2021 15:59:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>,
        Daniel Palmer <daniel@0x0f.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/3] ARM: dts: mstar: Add the Wireless Tag
 IDO-SBC2D06-V1B-22W
Message-ID: <YVIwzqjYXzqIxl0a@robh.at.kernel.org>
References: <20210923170747.5786-1-romain.perier@gmail.com>
 <20210923170747.5786-4-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923170747.5786-4-romain.perier@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 19:07:47 +0200, Romain Perier wrote:
> The Wireless Tag IDO-SBC2D06-V1B-22W[1] is an SBC powered by SSD202D
> with a dual Ethernet and a connector for a 4-inch and 7-inch display.
> It embeds a System-On-Module IDO-SOM2D01[2] with an Mstar SSD202 SoC
> dual-core Cortex-A7 CPU @ 1.2Ghz , 2D GPU, 128 MB DDR3 (on-chip) and
> a 256MB SPI NAND flash. This commit adds basic definition for this
> board.
> 
> 1. http://linux-chenxing.org/infinity2/ido-sbc2d06
> 2. http://www.wireless-tag.com/portfolio/ido-som2d01
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  .../devicetree/bindings/arm/mstar/mstar.yaml  |  2 ++
>  arch/arm/boot/dts/Makefile                    |  1 +
>  .../dts/mstar-infinity2m-ssd201-som2d01.dtsi  | 20 +++++++++++++
>  ...sd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts | 23 +++++++++++++++
>  ...ity2m-ssd202d-wirelesstag-ido-som2d01.dtsi | 28 +++++++++++++++++++
>  5 files changed, 74 insertions(+)
>  create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd201-som2d01.dtsi
>  create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts
>  create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi
> 

Reviewed-by: Rob Herring <robh@kernel.org>
