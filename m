Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22706326A53
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 00:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBZXFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 18:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhBZXFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 18:05:39 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F291C06174A;
        Fri, 26 Feb 2021 15:04:59 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id t9so6859148pjl.5;
        Fri, 26 Feb 2021 15:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2RxeM0yijnoNlTINwzzd+KCKF/DAIhG1UdTOfwx8N/o=;
        b=HuNZ4Jqry98TyKjAmSVE74O3H+y6KGzp/6YG+3Y7qYO+THQJCLWQq9yqFkABEjhYTe
         8O8BmI3b5fdbkMQ7Ym759pnW6/koHWsgR0P33jMTNofE/1EGUcugSgDuHmRRXwAayrwk
         vNwp2eYvHVfCJwmhHgocz4zqS6FjX/Flgox2SOkwSZmNnw9qAOjZpJNulhDfYYQdHSZn
         YD7T5Nym2FhuIvyaZSUxhKVBz4dIbD3W9JlXkVHnOBjz7Uf3v9h8NnqMfHd7aw8rLYZz
         RSOqM6c3Q160yNYTorVHwJZy0v0LPIwv6bx74+yDz5lQrHU0ZbM2WCYd6opakxtfQWiJ
         txWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2RxeM0yijnoNlTINwzzd+KCKF/DAIhG1UdTOfwx8N/o=;
        b=njpNPy5X7tm0Xs0XdPWjJKUWwIBGc9uA4GEWu1CzqUL0HgZVF4dATenvxi2eBbFco7
         1bEIXNmvgjJb5vwhl8a6BMZbJTCczMk74XvcrSasV+E9zMaApenezdTx3geeOSgLxIYC
         tC1P5e9UnUZpMj5RdIuIBS4CRfpvr2v+yVdeIVuPFzYDA03TcqqOJkHyw4qk++4Pt7nJ
         P5wq52sGkCG3HafYLUcdqavUKaG0w6xEahJMfp4vDVz1M+nhFEP4Yq7ba5HY1RO2hHpA
         bSYM8PS9KoUoN3D8llK1rZUjViNZHZnEv8qZCSCkHujM7VA8ww+9OhnO7B+pELFxN/CY
         VgOA==
X-Gm-Message-State: AOAM531xvKaiBXZYk3QOXtdMod9RzABrYpeaZHpPAxhon+Pa84hqTXHE
        pYPgY7U3jv/xuocBbVh6rgWQ1HH23BFkhg==
X-Google-Smtp-Source: ABdhPJzBRm5p29RXoLWL0ErdVU0iNimtD+CgQGAsC5BoJpPKdEJ3LrZigx+C19G7U1i8GcFXgthXRg==
X-Received: by 2002:a17:902:b7cb:b029:e4:55cd:ddf0 with SMTP id v11-20020a170902b7cbb02900e455cdddf0mr5229301plz.45.1614380698483;
        Fri, 26 Feb 2021 15:04:58 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id ie12sm9668602pjb.52.2021.02.26.15.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 15:04:57 -0800 (PST)
Subject: Re: [RFC 00/19] Rework support for i.MX8MQ interconnect with devfreq
To:     Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <djakov@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Martin Kepplinger <martink@posteo.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>
References: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <def4e2dd-5e9c-5878-a116-754f9bfe735e@gmail.com>
Date:   Sat, 27 Feb 2021 08:04:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You missed sending the patches to linux-pm mailing list.
On next version, please send it linux-pm.

Thanks,
Chanwoo Choi

On 21. 2. 20. 오전 12:59, Abel Vesa wrote:
> This has been on my queue for quite some time now. It is more of a
> proof-of-concept.
> 
> This rework is done with the compatibility of future i.MX platforms in
> mind. For example, the i.MX8MP platform has multiple NoCs. This
> patchsets prepares the imx interconnect and imx devfreq for that too.
> 
> As of now, none of the drivers involved are being used and there is no
> icc consumer on any off the i.MX platforms.
> 
> Basically, the steps taken here are the following:
> 
> 1. Make the dram_apb clock "reparantable" from kernel.
> This is needed in order to keep track of the actual parent of the
> dram_apb clock in the kernel clock hierarchy. Note that the actual
> switch is done EL3 (TF-A).
> 
> 2. Rework the imx-bus so the actual link between the icc and the
> NoCs or the pl301s is not tightly coupled. This allows us to have
> as many NoCs as necessary but also allows as to use the same driver
> for the pl301s. The pl301s have their own clocks too, so we need to
> reduce their rates too.
> 
> 3. Rework the imx8m-ddrc driver. Remove the support for dts defined
> OPPs. The EL3 provides those. So instead of havingi to keep the OPP table in
> both EL3 and kernel in sync, we rely on what the EL3 gives us.
> Also, when the platform suspends, the bus needs to be running at highest
> rate, otherwise there is a chance it might not resume anymore.
> By adding the late system sleep PM ops we can handle that easily.
> 
> 4. Rework the imx interconnect driver to use the fsl,icc-id instead
> of the robust imx_icc_node_adj_desc for linking with the target node.
> By adding the fsl,icc-id property to all the NoC and pl301 dts nodes,
> we can link each icc node to their corresponding NoC, pl301 or dram.
> Basically, when the imx interconnect platform specific driver probes,
> it will take each node defined for that platform and look-up the
> corresponding dts node based on the id and add that as the qos device.
> 
> 5. Added the fec and usdhc as icc consumers. This is just as an example.
> All the other consumers can be added later. Basically, each consumer
> will add a path to their device node and in the driver will have to
> handle that icc path accordingly.
> 
> Abel Vesa (19):
>    clk: imx8mq: Replace critical with ignore_unused flag for dram_apb
>      clock
>    dt-bindings: interconnect: imx8mq: Add missing pl301 and SAI ids
>    devfreq: imx-bus: Switch governor to powersave
>    devfreq: imx-bus: Decouple imx-bus from icc made
>    devfreq: imx8m-ddrc: Change governor to powersave
>    devfreq: imx8m-ddrc: Use the opps acquired from EL3
>    devfreq: imx8m-ddrc: Add late system sleep PM ops
>    interconnect: imx: Switch from imx_icc_node_adj_desc to fsl,icc-id
>      node assignment
>    interconnect: imx8: Remove the imx_icc_node_adj_desc
>    interconnect: imx8mq: Add the pl301_per_m and pl301_wakeup nodes and
>      subnodes
>    interconnect: imx8mq: Add of_match_table
>    interconnect: imx: Add imx_icc_get_bw and imx_icc_aggregate functions
>    arm64: dts: imx8mq: Add fsl,icc-id property to ddrc node
>    arm64: dts: imx8mq: Add fsl,icc-id to noc node
>    arm64: dts: imx8mq: Add all pl301 nodes
>    arm64: dts: imx8mq: Add the interconnect node
>    arm64: dts: imx8mq: Add interconnect properties to icc consumer nodes
>    net: ethernet: fec_main: Add interconnect support
>    mmc: sdhci-esdhc-imx: Add interconnect support
> 
>   arch/arm64/boot/dts/freescale/imx8mq.dtsi | 200 +++++++++++++++++++++-
>   drivers/clk/imx/clk-imx8mq.c              |   2 +-
>   drivers/devfreq/imx-bus.c                 |  42 +----
>   drivers/devfreq/imx8m-ddrc.c              |  75 +++-----
>   drivers/interconnect/imx/imx.c            |  92 +++++-----
>   drivers/interconnect/imx/imx.h            |  19 +-
>   drivers/interconnect/imx/imx8mm.c         |  32 ++--
>   drivers/interconnect/imx/imx8mn.c         |  28 +--
>   drivers/interconnect/imx/imx8mq.c         |  59 ++++---
>   drivers/mmc/host/sdhci-esdhc-imx.c        |  26 +++
>   drivers/net/ethernet/freescale/fec.h      |   3 +
>   drivers/net/ethernet/freescale/fec_main.c |  19 ++
>   include/dt-bindings/interconnect/imx8mq.h |   9 +
>   scripts/dtc/fdtoverlay                    | Bin 0 -> 61280 bytes
>   14 files changed, 393 insertions(+), 213 deletions(-)
>   create mode 100755 scripts/dtc/fdtoverlay
> 
