Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2064B30A479
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbhBAJho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbhBAJhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:37:42 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2B0C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 01:37:01 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id l9so23302995ejx.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 01:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YT9JKAAuOKGWEIOCiHYE2IzA63LGraoXCVqgI67QUBc=;
        b=F5ZO0PwaadZtH/DBe8bqjzWSZZlehKEdKil0gvQBYTUE4fQLoMCTOvlS5yS1/OLMTQ
         PHFZP8IS7Xu2bD0Bd3UCQWGon4LjzUKihYbZ8SGdUFijZ5ChxfpU3BFzSwOurGuZxKTS
         OsLfw7fZ7tyiNGLwVFaygFVASXC3+Z5BCCQBtY9zE9IQWqAoJjWgC20i+HhVGlAwJ5Sn
         nW6TMYRpgTVx2Co6iD5sP/KLstrmKzq+QLpauGpmj5UWLCG4dyIoVjUfufV0StjwWr11
         IgRDuYXipeLX7PinFClOlr8p02QmnUAGzdoCybkxvFSZDKYvBDcX3qIh2DOmeF7C4u0r
         5i4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YT9JKAAuOKGWEIOCiHYE2IzA63LGraoXCVqgI67QUBc=;
        b=SL47AZ3VXAdF0VXNWN6YYF8z2jOftYmk5nC3fjrc7BNu5zJqS8N3W2U01dgBhorWpG
         8EQE+dexIiUJakkjXHl9Q97guyGuJWvbC0v4Kp7RMknb5cnmIDW7jkhS2GYKI+Plyg7i
         2WbJEuWOA6VbSWDgGcX6ttpmjceLqg0pCdLhf16R3KHrem8Wl0DRJ7ADUqUlZdmyr8H3
         9IuQ0o2h3TCVoc2zXDA+c5h1+f5oTWAS85M/xJrUbx7LbLuKd5UKjUcyqRTaIJYofoCM
         Iy8HPx0Oyiy3JCZx8IBKQk6wzZsjPfOP6bkJEdgn6fcM+v7o5weEf+LfFNZT9Vq9uP0+
         5TpA==
X-Gm-Message-State: AOAM533i8UHq0KKzPPZ/sD9O2rpaN+WkLPKhsFCUAWpIYCx66SwWAzD/
        ZXwr8SetyWDqN0VXCdvLipmadA==
X-Google-Smtp-Source: ABdhPJxc0Q0oudsWY8kJ5VVa7d0cqEeqY+pUycva3H9CPTYUGYu2f8LQbUnPclmgkKHMqKU2RsYxAg==
X-Received: by 2002:a17:906:2755:: with SMTP id a21mr16994478ejd.374.1612172219963;
        Mon, 01 Feb 2021 01:36:59 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id g2sm7646132ejk.108.2021.02.01.01.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 01:36:59 -0800 (PST)
Subject: Re: [PATCH v2 00/12] arm64: dts: zynqmp: DT updates to match latest
 drivers
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, git@xilinx.com
Cc:     Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1611224800.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <adfb1adc-26c8-3d35-10ea-87da25674d36@monstr.eu>
Date:   Mon, 1 Feb 2021 10:36:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1611224800.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/21 11:26 AM, Michal Simek wrote:
> Hi,
> 
> I am sending this series to reflect the latest drivers which have been
> merged to mainline kernel. I have boot it on zcu102-rev1.0 and also
> zcu104-rev1.0. That's why I have also added DT for this newer revision.
> 
> The series is based on https://github.com/Xilinx/linux-xlnx/tree/zynqmp/dt.
> And mio-bank patch requires update in dt-binding which has been posted here
> https://lore.kernel.org/r/5fa17dfe4b42abefd84b4cbb7b8bcd4d31398f40.1606914986.git.michal.simek@xilinx.com
> 
> Thanks,
> Michal
> 
> Changes in v2:
> - Remove reset description for IPs from this patch. IPs will be enabled
>   separately with DT binding update.
> - Change patch subject
> 
> Michal Simek (12):
>   arm64: dts: zynqmp: Fix u48 si5382 chip on zcu111
>   arm64: dts: zynqmp: Add DT description for si5328 for zcu102/zcu106
>   arm64: dts: zynqmp: Enable si5341 driver for zcu102/106/111
>   arm64: dts: zynqmp: Enable reset controller driver
>   arm64: dts: zynqmp: Enable phy driver for Sata on zcu102/zcu104/zcu106
>   arm64: dts: zynqmp: Add label for zynqmp_ipi
>   arm64: dts: zynqmp: Add missing mio-bank properties to sdhcis
>   arm64: dts: zynqmp: Wire arasan nand controller
>   arm64: dts: zynqmp: Wire zynqmp qspi controller
>   arm64: dts: zynqmp: Add missing lpd watchdog node
>   arm64: dts: zynqmp: Add missing iommu IDs
>   arm64: dts: zynqmp: Add description for zcu104 revC
> 
>  arch/arm64/boot/dts/xilinx/Makefile           |   1 +
>  .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |  12 +
>  .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    |   2 +
>  .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    |  84 +++++-
>  .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    |  29 ++
>  .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    | 282 ++++++++++++++++++
>  .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    |  78 +++++
>  .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    |  59 +++-
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  94 +++++-
>  9 files changed, 637 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> 

Applied all.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

