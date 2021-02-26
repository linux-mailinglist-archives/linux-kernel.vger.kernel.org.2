Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C157D325D27
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 06:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhBZFZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 00:25:50 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13102 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhBZFZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 00:25:49 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603886340000>; Thu, 25 Feb 2021 21:25:08 -0800
Received: from [10.25.103.29] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 26 Feb
 2021 05:25:06 +0000
Subject: Re: [RFC PATCH 0/5] Flexible sysclk/pll configuration
To:     <broonie@kernel.org>, <robh@kernel.org>
CC:     <jonathanh@nvidia.com>, <kuninori.morimoto.gx@renesas.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1614276364-13655-1-git-send-email-spujar@nvidia.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <49dd60ad-dfb1-8847-2604-0cb4aebe83bd@nvidia.com>
Date:   Fri, 26 Feb 2021 10:54:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1614276364-13655-1-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614317108; bh=bZLn7mqkvbTFnvY90gnBrI9GdPGe2eHmP57y+B8irak=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=j2pUG0A47uvh8AwklgsEjdeoaCrIbszFcYadPmLRlbsQtmhuBz5Qn65nc+KQkniAz
         SfbeVQAoByc/CNn643BL0H0T8zCW2r4mDFEBuqARLjKZmI9kebvw+2qSSdE8Tutg+j
         wqkalDGRASB+BqHdonwQ6bed1ha8dmtVIsZVKo2NsJMHvVNceHOr/yr7uowyu3Wnd/
         3MHuz+4bb6ON+uNcRJTjBSEmQbKwpUVwq+bP9N3uFp/FzUSBW1nNZEPuF412t4JsJ7
         xQSQj9CTylYEynMw7dneErcpo72nI/pms1WMCcjrB3/Be7hfkXSBmuE9+tD5nv/FMa
         1UL+92QHwDDDw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/2021 11:35 PM, Sameer Pujar wrote:
> This series attempts to add flexible system clock (sysclk) and pll
> configuration for the DAI controller from simple card or audio graph
> card.
>
> Sysclk configuration
> ====================
>    Motivation:
>    -----------
>      The problem this tries to address is, some Codecs may have
>      multiple clocks and multiple sources for its sysclk. For example
>      sysclk may depend on MCLK provided by SoC or it may used an
>      internal pll. The simple card or audio graph card driver is
>      generic and can be used on multiple platforms. So if a platform
>      using this driver needs a generic configuration, then the Codec
>      specific stuff cannot be hardcoded in the driver. Hence it would
>      be better if the info is driven from DT, especially from a
>      Codec DAI or endpoint subnode.
>
>    Solution:
>    ---------
>      "system-clock-id" and "system-clock-source" DT properties can be
>      exposed for a flexible sysclk configuration. These properties
>      go into a Codec DAI or endpoint subnode.
>
>      Please note that other sysclk related properties like
>      "system-clock-frequency" and "system-clock-direction-out" are
>      already present.
>
>      Currently snd_soc_dai_set_sysclk() does not have an argument
>      for source. This series adds this additional field and updates
>      all the required drivers. This is needed because ideally sysclk
>      "clk_id" and "source" fields are different. Some drivers are
>      making use of "clk_id" field to program source information.
>      **May be this needs to be corrected going ahead**
>
>
> Pll configuration
> =================
>    Motivation:
>    -----------
>      Similar to sysclk configuration, pll configuration also needs
>      little more flexibility. If a Codec has internal pll and it
>      can be sourced from multiple clocks a specific configuration
>      may be required for a given platform.
>
>      Some of the cases are:
>        - MCLK (supplied by SoC) --> Codec pll -> Codec sysclk
>        - SoC I2S bit clock (BCLK) --> Codec pll -> Codec sysclk
>
>    Solution:
>    ---------
>      Approach is similar to what is done for extending sysclk
>      flexibility. Following DT properties are added to address the
>      same.
>
>        "pll-id"
>        "pll-source"
>        "pll-input-reference"
>        "pll-output-reference"
>        "pll-input-frequency"
>        "pll-output-frequency"
>
>      All these are optional properties. Simple card or audio graph
>      card drivers can use above info and call snd_soc_dai_set_pll()
>      for necessary configuration.
>
> Sameer Pujar (5):
>    ASoC: soc-component: Fix return value of snd_soc_component_set_pll()
>    ASoC: soc-dai: Add sysclk source to snd_soc_dai_set_sysclk()
>    ASoC: audio-graph-card: Add bindings for sysclk and pll
>    ASoC: simple-card-utils: Parse sysclk id and source
>    ASoC: simple-card-utils: Support pll configuration
>
>   .../bindings/sound/audio-graph-port.yaml           |  71 +++++++++
>   include/sound/simple_card_utils.h                  |  35 +++++
>   include/sound/soc-dai.h                            |   4 +-
>   sound/soc/amd/acp-da7219-max98357a.c               |   2 +-
>   sound/soc/amd/acp-rt5645.c                         |   2 +-
>   sound/soc/amd/acp3x-rt5682-max9836.c               |   4 +-
>   sound/soc/atmel/atmel_wm8904.c                     |   2 +-
>   sound/soc/atmel/mchp-i2s-mcc.c                     |   2 +-

[...]

>   sound/soc/ti/omap-mcbsp.c                          |   2 +-
>   sound/soc/ti/omap3pandora.c                        |   4 +-
>   sound/soc/ti/rx51.c                                |   2 +-
>   sound/soc/uniphier/aio-cpu.c                       |   4 +-
>   sound/soc/ux500/ux500_msp_dai.c                    |   2 +-
>   271 files changed, 639 insertions(+), 389 deletions(-)
>

Looks like I missed some files to update which make use of 
snd_soc_dai_set_sysclk(). I will try to fix that. Meanwhile please 
review if the idea is right here.

