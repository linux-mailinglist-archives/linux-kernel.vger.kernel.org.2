Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D4F45E760
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 06:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352508AbhKZF3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 00:29:55 -0500
Received: from mx.socionext.com ([202.248.49.38]:60758 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345952AbhKZF1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 00:27:52 -0500
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 26 Nov 2021 14:24:38 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id CCEA7205C83D;
        Fri, 26 Nov 2021 14:24:38 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 26 Nov 2021 14:24:38 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 7DD7AB62E0;
        Fri, 26 Nov 2021 14:24:38 +0900 (JST)
Received: from [10.212.180.208] (unknown [10.212.180.208])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id C7F9010D17;
        Fri, 26 Nov 2021 14:24:37 +0900 (JST)
Subject: Re: [PATCH 1/2] ASoC: uniphier: drop selecting non-existing
 SND_SOC_UNIPHIER_AIO_DMA
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211125095158.8394-1-lukas.bulwahn@gmail.com>
 <20211125095158.8394-2-lukas.bulwahn@gmail.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <29c517c1-18d7-4b21-dff5-050d2e7ce992@socionext.com>
Date:   Fri, 26 Nov 2021 14:24:36 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211125095158.8394-2-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2021/11/25 18:51, Lukas Bulwahn wrote:
> Commit f37fe2f9987b ("ASoC: uniphier: add support for UniPhier AIO common
> driver") adds configs SND_SOC_UNIPHIER_{LD11,PXS2}, which select the
> non-existing config SND_SOC_UNIPHIER_AIO_DMA.
> 
> Hence, ./scripts/checkkconfigsymbols.py warns:
> 
>    SND_SOC_UNIPHIER_AIO_DMA
>    Referencing files: sound/soc/uniphier/Kconfig
> 
> Probably, there is actually no further config intended to be selected
> here. So, just drop selecting the non-existing config.

The feature corresponding to this config is inseparable in AIO driver.
Probably unused definition remains in Kconfig, so it's ok to drop this config.

Thank you,

---
Best Regards
Kunihiko Hayashi
