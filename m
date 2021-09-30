Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F31B41E3A2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 00:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345714AbhI3WI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 18:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245172AbhI3WI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 18:08:26 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9AAC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 15:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=iBviWjWtcIrXPMzfxdaBL9mBeizH0R3Lv9Hqu58Rx54=; b=fl6EocV5mA63nYT/svWLWFdLlI
        FeqE8K23tl1zSgn5K0ijoRIrOnaa2tZ2BoRGs/zdY17xUKHGcQhDS8x1omuraOAayvaW0JH+ALvqw
        NmRQrov3tf/CqL4eJQJoS4yaU8sFxo985SOHprAn3oIxYJEJOyNjmyGTQ/YBy9KmCj8YOymPrsGsG
        nhyiSJcdWM7wwgxfD1GZLYWlmkk3CFOdjGHje0PELOFNbuScNODHruJk2RHmS0pdWYZPJwY3DX+lo
        xSe667M2Dt5+XE0wDK+KJlOK8eMCks6PJecibvN1Qujosee6ICnZ4f9swXEQwdHlElmzi8+VnFTZJ
        HP8ulJcw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mW4CP-00G5CU-Mf; Thu, 30 Sep 2021 22:06:41 +0000
Subject: Re: [PATCH 2/8] ASoC: amd: acp: Add I2S support on Renoir platform
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20210930132418.14077-1-AjitKumar.Pandey@amd.com>
 <20210930132418.14077-3-AjitKumar.Pandey@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <81883f80-cc67-d216-f62c-e55d33724f5f@infradead.org>
Date:   Thu, 30 Sep 2021 15:06:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210930132418.14077-3-AjitKumar.Pandey@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/21 6:24 AM, Ajit Kumar Pandey wrote:
> diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
> index 1ca815df6f23..a11182861f49 100644
> --- a/sound/soc/amd/acp/Kconfig
> +++ b/sound/soc/amd/acp/Kconfig
> @@ -16,3 +16,11 @@ config SND_SOC_AMD_ACP_I2S
>   
>   config SND_SOC_AMD_ACP_PCM
>   	tristate
> +
> +config SND_AMD_ASOC_RENOIR
> +	tristate "AMD ACP ASOC Renoir Support"
> +	select SND_SOC_AMD_ACP_PCM
> +	select SND_SOC_AMD_ACP_I2S
> +	depends on X86 && PCI
> +	help
> +	 This option enables Renoir I2S support on AMD platform

Please follow coding-style for Kconfig files:

(from Documentation/process/coding-style.rst, section 10):

For all of the Kconfig* configuration files throughout the source tree,
the indentation is somewhat different.  Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.

Also end the help sentence with a period (full stop) ('.').

thanks.

-- 
~Randy
