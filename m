Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C4542882E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 09:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbhJKH5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 03:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbhJKH5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 03:57:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C750DC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 00:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=7aFBilyQzv3eGjfhC1Mgx1dqBHvelIzNlMAAN5gT0Ac=; b=V9gwkBI9pbATcC/40PsmeMBlNw
        6uNUwP20UUN4B51LnX2b/bLhkHldWu02eXKf+JX8B4Gy116HRsBAXj+DSQYF/45dB4Lv0cxDJOnqy
        3XmcDypGwNbJf0ZnCRnLcQtWokdAILmj/CFmsfQQ4CYXKW1ElF97UHRrjGJ+VvxzkHCGwzHcL69yf
        euSlh5KrqNejYPeV1U+lQsVw170ykc/iH1euV2bhzTUE3IC3Ab1HL1BlSQ5LcGYjqSA3vclwtLSy9
        fmpyGPnNDNffGm+o0tokHY8ycR47OE81VtkYnkubQgMBsmXFUBjFjGdW7/T8oPg8x8zxBZ+gvMHg2
        mL7+Da4Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZq9f-008CaO-EB; Mon, 11 Oct 2021 07:55:27 +0000
Subject: Re: [PATCH 13/13] ASoC: amd: enable yc machine driver build
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Alexander.Deucher@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mario.Limonciello@amd.com,
        Richard.Gong@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20211011055621.13240-1-Vijendar.Mukunda@amd.com>
 <20211011055621.13240-14-Vijendar.Mukunda@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7d58fea8-cd45-c25d-300f-1e7438079c94@infradead.org>
Date:   Mon, 11 Oct 2021 00:55:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211011055621.13240-14-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/21 10:56 PM, Vijendar Mukunda wrote:
> Enable YC platform dmic machine driver build.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>   sound/soc/amd/Kconfig     | 7 +++++++
>   sound/soc/amd/yc/Makefile | 2 ++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
> index 42825e8ad2ad..864d80f14421 100644
> --- a/sound/soc/amd/Kconfig
> +++ b/sound/soc/amd/Kconfig
> @@ -67,3 +67,10 @@ config SND_SOC_AMD_ACP6x
>   	depends on X86 && PCI
>   	help
>   	 This option enables ACP v6.x DMIC support on AMD platform
> +

For the help text above here and the one below:

a. End the sentence with a period ('.').

b. Pay attention to the documented/accepted kernel style:

(from Documentation/process/coding-style.rst, section 10):

For all of the Kconfig* configuration files throughout the source tree,
the indentation is somewhat different.  Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.

> +config SND_SOC_AMD_YC_MACH
> +        tristate "AMD YC support for DMIC"
> +        select SND_SOC_DMIC
> +        depends on SND_SOC_AMD_ACP6x
> +        help
> +         This option enables machine driver for DMIC endpoint


thanks.
-- 
~Randy
