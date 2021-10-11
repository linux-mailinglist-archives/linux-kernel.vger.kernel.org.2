Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C081429806
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 22:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbhJKUSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 16:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbhJKUSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 16:18:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C209C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 13:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=TSceSFstAJbjHmDbs5vrAYSm5th2+WEa7Fev24Zvqj8=; b=exgVyxRQBnFIK7xTgvWhs3Hnss
        zBvrOsJ7wzVwGj3ryDqugEhU7QyvRrvyaceUm9KVlGFJE0c2VAT55SKE7tkTEAJmHOua1xAd0YnDA
        +qrbuVPMzhZ3vEXBFQ6IOk//kI7I5Rw3d9vedk1gknPto+WE3LB61PdfjMozxSqUjo4p58WS4ji/J
        XTkuaZpjWbA6GN770WshsLuXQ+oJxRVuxUD5opsg3lGN8gpcGLqXkpjcSh0nhwz7Mb8BTVlNiv6m3
        k7wwjkQUj2UB7Brp2uSj+G1Ta5OcyIqqWRPhzCcqRG+DoouBydTOC6ei43INCjP4bcE6zy+4Vhma/
        ZbEVWsoA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ma1ir-00AaCX-Ka; Mon, 11 Oct 2021 20:16:33 +0000
Subject: Re: [PATCH v2 1/8] ASoC: amd: Add common framework to support I2S on
 ACP SOC
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20211011154452.76849-1-AjitKumar.Pandey@amd.com>
 <20211011154452.76849-2-AjitKumar.Pandey@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8f025871-fe7b-6224-cb54-26dd6d3def11@infradead.org>
Date:   Mon, 11 Oct 2021 13:16:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211011154452.76849-2-AjitKumar.Pandey@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/21 8:44 AM, Ajit Kumar Pandey wrote:
> We are using legacy way of exposing dais and DMA configuration that
> requires separate driver modules for various ACP SOC with almost
> similar hw configuration. Moreover the legacy approach requires
> separate I2S and DMA module platform devices registration and need
> machine specific quirk to control various I2S endpoints. Add generic
> dai driver and platform driver for I2S controller on ACP hw block.
> This common framework can be used by various ACP platform devices
> that shares common specs.
> 
> Signed-off-by: Ajit Kumar Pandey<AjitKumar.Pandey@amd.com>
> ---

> diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
> new file mode 100644
> index 000000000000..6b993074e2c4
> --- /dev/null
> +++ b/sound/soc/amd/acp/Kconfig
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +# This file is provided under a dual BSD/GPLv2 license. When using or
> +# redistributing this file, you may do so under either license.
> +#
> +# Copyright(c) 2021 Advanced Micro Devices, Inc. All rights reserved.
> +#
> +
> +config SND_SOC_AMD_ACP_COMMON
> +	tristate "AMD Audio ACP Common support"
> +	select SND_AMD_ACP_CONFIG
> +	help
> +	  This option enables ACP support on AMD platform.
> +
> +config SND_SOC_AMD_ACP_I2S
> +	tristate
> +
> +config SND_SOC_AMD_ACP_PCM
> +	tristate

Hi,
I don't see anything that tells us what "ACP" is.
Please add that somewhere -- either in the Kconfig file or
at least in the commit description.

thanks.

-- 
~Randy
