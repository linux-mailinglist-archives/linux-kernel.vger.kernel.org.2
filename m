Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91CF41B24D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 16:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241387AbhI1OqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 10:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241295AbhI1OqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 10:46:02 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36FCC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:44:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id i6-20020a1c3b06000000b0030d05169e9bso306064wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TrLAUwrfZydcABJFcjBv4tGcG5sEz91K/jBljcklsAc=;
        b=UfileZT6VmIcod7N6O9fk2FNKlrMl9laobT1u64Q3AisEo3gFxRtkvyHWu6/NPUgl4
         GwI51NR2AYBTYWRWXSTPTevE6tvd8ArA7Zx3hrSnG8jw1mwgawJLuPMwHAprtJ7NBxKF
         R6KFp1H+ZAB0tVfZi9TgMG/TxpMNpUFzc13h0lgVebH7i6PMXpcw/5ykB2GUQ9z3FcbK
         Bl8DVS0v9afL5UhPBCkrzwGg48sge+mc40grnDUwHGMoS15A29DHb1BEMlMyOw8eahbV
         rYd6HlOLSU5JRpivARjRpARpUaT5pU5lm6bUoiYHDA1f9pDh9Jp1IFrccCyZ4txB9XeO
         8Q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TrLAUwrfZydcABJFcjBv4tGcG5sEz91K/jBljcklsAc=;
        b=AtoVLC2+zsdYpoxybFAuuHjHXZmca189MFpRYbic0CZFYUzujqoNLKlFUJ0cyqAwk1
         YaQcSJ4QlSsUv/KzPVZWGqbIj0m9MwxQ5pkVoP5zcvsJ6aphTNoarMWHT+weRcl15xqp
         hLrEs/ruJak+ZAbIkhWAXDxer9S+am/iomXKghqxA/IPo5c1T/1JQLTien29qIWWvbfX
         bufbZxVqCxR82MpR4hL4ZJHXktD3TktJ2337EYDRTN2Ee4NievChe91C+26PmDnQYdym
         EDvdbbtEg/Vh/4KK95LT3aPjX/OvRkx8Gc9w2G4SY5iKcFjbddAFl/An2FT1O6STN7mT
         1J1w==
X-Gm-Message-State: AOAM532TgSlWn8NPDmXYFiAhQqOhgaQ0ipXrWSXS7IZqKkZZOPxGjKRS
        LdFc4JSuhcAlrQH7udcn5GmWgwjEyWA0PA==
X-Google-Smtp-Source: ABdhPJyCzpqOtMBCC1LyDZ8lpsNKxlm5+8ChFU8yojs3ZwwqE3MyLYWdMGSwSaUIS6X1GlodnxtVfA==
X-Received: by 2002:a05:600c:41d6:: with SMTP id t22mr5146675wmh.59.1632840261191;
        Tue, 28 Sep 2021 07:44:21 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id w18sm4604555wrt.79.2021.09.28.07.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 07:44:20 -0700 (PDT)
Subject: Re: [PATCH V2 0/6] nvmem: add "cell-type" property to support
 mac-address
To:     Joakim Zhang <qiangqing.zhang@nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, a.fatoum@pengutronix.de
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
References: <20210923110109.29785-1-qiangqing.zhang@nxp.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2194172f-a362-a328-993b-45ebec539f9d@linaro.org>
Date:   Tue, 28 Sep 2021 15:44:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210923110109.29785-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joakim,


I pushed some WIP changes to 
https://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git/log/?h=topic/post-processing
with Rob's feedback,

Do you think you could try it out and see if this works for you?

--srini

On 23/09/2021 12:01, Joakim Zhang wrote:
> This patch set adds "cell-type" property to parse mac address, take i.MX
> as an example, which need reverse byte for mac address.
> 
> ChangeLogs:
> V1->V2:
> 	* correct comments: @cell_read_callback -> @cell_post_process
> 	* s/imx8mm/imx8m/ in commit message title
> 	* add reviewed-by tags
> 
> Joakim Zhang (2):
>    arm64: dts: imx8m: add "cell-type" property for mac-address
>    arm64: dts: imx8m: remove unused "nvmem_macaddr_swap" property for FEC
> 
> Srinivas Kandagatla (4):
>    dt-bindings: nvmem: add cell-type to nvmem cells
>    nvmem: core: parse nvmem cell-type from device tree
>    nvmem: core: add nvmem cell post processing callback
>    nvmem: imx-ocotp: add support for post porcessing.
> 
>   .../devicetree/bindings/nvmem/nvmem.yaml      | 11 +++++++
>   arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  3 +-
>   arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  3 +-
>   arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 10 ++++++-
>   arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  3 +-
>   drivers/nvmem/core.c                          | 12 ++++++++
>   drivers/nvmem/imx-ocotp.c                     | 30 +++++++++++++++++++
>   include/dt-bindings/nvmem/nvmem.h             |  8 +++++
>   include/linux/nvmem-provider.h                |  5 ++++
>   9 files changed, 81 insertions(+), 4 deletions(-)
>   create mode 100644 include/dt-bindings/nvmem/nvmem.h
> 
