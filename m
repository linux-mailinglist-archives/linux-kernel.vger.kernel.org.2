Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9517F45EE3E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 13:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377625AbhKZMpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 07:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377489AbhKZMne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 07:43:34 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D60C0613F7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 04:07:05 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 81E1A1F424B2
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637928424; bh=lX6ppMZjO0025K7runl0mEgfYiZFx0hIVDwtqr+JnAM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gocUK+GrWnXl6OKH/AevijAI24+YPu7y7cG7JpNfIzKaaOkO5YIcm+g4VX7go3Dw4
         Mrykzt9/N1hZRWFb5eYsZtcb1ZeoLjslBbS8V9Do4CMXkSbQJYYSSa0IK9qTK1TdEq
         ZtlMt6ACjwLpRObtq51WBWwn9ip4QoybLUpo0juifxmEHvwmEXSb5cQBOTLvaWfBcb
         MTAjUT44oNLDAgQmyXgmkEi5HY6NeRPn+eKehA2pPPFRbzCkGJlcGoDJPJo6GgyBuo
         xgI50lPS+knlc0AlgfZxJ6jWL3paAKjCkqSdCF5dddU8BYcnTIztLkeL+ar8Po3C7c
         fQrOkqgKMp5zw==
Subject: Re: [PATCH v2 7/8] ASoC: SOF: mediatek: Add mt8195 dsp clock support
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        daniel.baluta@nxp.com, daniel.baluta@gmail.com,
        linux-kernel@vger.kernel.org, yc.hung@mediatek.com,
        linux-mediatek@lists.infradead.org
References: <20211118100749.54628-1-daniel.baluta@oss.nxp.com>
 <20211118100749.54628-8-daniel.baluta@oss.nxp.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <111881ca-bc8e-3c41-fe58-20f01b623031@collabora.com>
Date:   Fri, 26 Nov 2021 13:07:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211118100749.54628-8-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/11/21 11:07, Daniel Baluta ha scritto:
> From: YC Hung <yc.hung@mediatek.com>
> 
> Add adsp clock on/off support on mt8195 platform.
> 
> Signed-off-by: YC Hung <yc.hung@mediatek.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>   sound/soc/sof/mediatek/adsp_helper.h       |   2 +-
>   sound/soc/sof/mediatek/mt8195/Makefile     |   2 +-
>   sound/soc/sof/mediatek/mt8195/mt8195-clk.c | 158 +++++++++++++++++++++
>   sound/soc/sof/mediatek/mt8195/mt8195-clk.h |  28 ++++
>   sound/soc/sof/mediatek/mt8195/mt8195.c     |  22 ++-
>   5 files changed, 208 insertions(+), 4 deletions(-)
>   create mode 100644 sound/soc/sof/mediatek/mt8195/mt8195-clk.c
>   create mode 100644 sound/soc/sof/mediatek/mt8195/mt8195-clk.h
> 

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


