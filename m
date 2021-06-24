Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1153B37D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 22:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbhFXUcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 16:32:06 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:36445 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhFXUcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 16:32:04 -0400
Received: by mail-io1-f51.google.com with SMTP id s19so9869744ioc.3;
        Thu, 24 Jun 2021 13:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XnibS50Q0CBOvEMl46nwSYw4OcAKBfEOQazrskVjqjY=;
        b=NYFRDr0Do5uzmDGFur1V3odPenjaiUAVJp7fk+nAJmbCWkb7u1Xois7NTibk5UvNKl
         HchKbETrTssvN+tnGhYBK98+XE0WMGGrTcfo/0uxQnOIJgQmtI236hTc9+NO41xUR4XK
         xj2alTj/ppLNgXsMswU3pevV5Qb960zj6IVZLKB/yAvyO3iaaTV3acOtXSM1gmphjgzr
         PMeBXa965yd9FEAhnxMtRQWj1qDFpe9X/D5j8a6FmTbvoe7+LYgm3ALrBDVQ0FV47cig
         LT37QbuaCkcRSHTBjjhi+nqxb0i+1EeOJdiJXJJjJPcHMu88dhzl2NMcJ57wsbwchbqY
         OQgQ==
X-Gm-Message-State: AOAM530kfmIuGx+FFEOmHSu2O6qUsmQaKlUovnbm0NuFv+8/TWPZ1RbW
        yt5U98OIE484JdaL7AjKEw==
X-Google-Smtp-Source: ABdhPJxSAKYnzPEeTZsNmHL4KajVliP6DlriQJmZLFMV8u3yLHsbqwQz8hp6LBg8Bft5Jxc+K2vjpQ==
X-Received: by 2002:a6b:fd12:: with SMTP id c18mr5713673ioi.182.1624566584246;
        Thu, 24 Jun 2021 13:29:44 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c19sm2464332ili.62.2021.06.24.13.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 13:29:42 -0700 (PDT)
Received: (nullmailer pid 1937094 invoked by uid 1000);
        Thu, 24 Jun 2021 20:29:40 -0000
Date:   Thu, 24 Jun 2021 14:29:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>, monstr@monstr.eu,
        git@xilinx.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Walle <michael@walle.cc>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 30/33] arm64: zynqmp: Add support for zcu102-rev1.1
 board
Message-ID: <20210624202940.GA1937058@robh.at.kernel.org>
References: <cover.1623684253.git.michal.simek@xilinx.com>
 <38bbbeb885f4d9ba466c43ab9b4d25190a3552fb.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38bbbeb885f4d9ba466c43ab9b4d25190a3552fb.1623684253.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jun 2021 17:25:38 +0200, Michal Simek wrote:
> zcu102 rev1.1 compare to rev1.0 is using by default different DDR memory
> which requires different configuration. The reason for adding this file to
> Linux kernel is that U-Boot fdtfile variable is composed based on board
> revision (in eeprom) and dtb file should exist in standard distibutions for
> passing it to Linux kernel.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/arm/xilinx.yaml |  1 +
>  arch/arm64/boot/dts/xilinx/Makefile               |  1 +
>  .../boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts      | 15 +++++++++++++++
>  3 files changed, 17 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts
> 

Reviewed-by: Rob Herring <robh@kernel.org>
