Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4223C41E3A7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 00:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346129AbhI3WKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 18:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhI3WKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 18:10:13 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CE1C06176D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 15:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=7NdS6+teQK03rYflLZeIrWr135Yc2zIWK5XSmPMC1G4=; b=vlZfDKu189SubPvbmY8TZfv1FJ
        6vs2aDjYFjP2bi9gxinALr0dLDBk9TvLivAckOfVKc/M1lWoghDf+A4HNDB1ggzThlsSUNcVlVZUm
        T/QmUaTvpPNijeKXbU73GnfEnbxHg6v1PbMrdETxydTE9ste5VV0COwHatO+xGZ1diSquIzBnJ89F
        dDiANb0E4wHK4pbca/VwVtnqRmHv7gpkJyLVdI6JEIcsRPbUndTJV0BQTfNmyOk2uIwlqUZ8SGiSO
        OFvu1OEealYRDKv4Gi8O+DOvJqsFybbVDzARYxArxj2vf2vXWz8Zee8DsOjeunL4qsXNsomRZmx3Q
        VePfNzOw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mW4E9-00G5FH-HR; Thu, 30 Sep 2021 22:08:29 +0000
Subject: Re: [PATCH 4/8] ASoC: amd: acp: Add generic machine driver support
 for ACP cards
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20210930132418.14077-1-AjitKumar.Pandey@amd.com>
 <20210930132418.14077-5-AjitKumar.Pandey@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e5d067d7-b9de-da47-87ba-47653812907b@infradead.org>
Date:   Thu, 30 Sep 2021 15:08:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210930132418.14077-5-AjitKumar.Pandey@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/21 6:24 AM, Ajit Kumar Pandey wrote:
> diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
> index a11182861f49..1ad811707a68 100644
> --- a/sound/soc/amd/acp/Kconfig
> +++ b/sound/soc/amd/acp/Kconfig
> @@ -24,3 +24,12 @@ config SND_AMD_ASOC_RENOIR
>   	depends on X86 && PCI
>   	help
>   	 This option enables Renoir I2S support on AMD platform
> +
> +config SND_SOC_AMD_MACH_COMMON
> +	tristate
> +	select SND_SOC_RT5682_I2C
> +	select SND_SOC_DMIC
> +	select SND_SOC_RT1019
> +	depends on X86 && PCI && I2C
> +	help
> +	 This option enables common Machine driver module for ACP

Same comments for patch 4, 5, and 6 as given for patch 2.

thanks.
-- 
~Randy
