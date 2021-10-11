Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92ABD42980D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 22:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbhJKUUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 16:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbhJKUUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 16:20:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E11AC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 13:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=6BfPWdxhcFBaDDiqb/ocng4a5UziACoHk6Kt3bc/Ucs=; b=Mx+UIY8Ae1UxIFrrPnDylXYQ+x
        FAia0x7Uo+IMLcLAywfKlbBvmNrfZ6GlEISlRNiryrXFcluXOOICS7leMouGEqiz+gmcrDe75W6w2
        Eg807Pi78UdLS6byK37MYl+Dp+kBDbUDtOAr6p5onCY9g3bf0ISgRdnwk6QClWb5nU8DFHObEQzSZ
        SNtwcgszHmmyBgelkgRLcme2w05lp8z1XJ2H6FRJ3A6NP7LCM/PA19YrSr1zb/Bz6uu7STLCd5opk
        b4R0segMo8Mb5nhBLQrBecw2mzOF95oVXSayxRtK2Xf/Bb85Snngg4i7dmPRBo+3X74NBq7Eb/GTg
        Fyh/DqRA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ma1kL-00AaLK-Ir; Mon, 11 Oct 2021 20:18:05 +0000
Subject: Re: [PATCH v2 5/8] ASoC: amd: acp: Add legacy sound card support for
 Chrome audio
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20211011154452.76849-1-AjitKumar.Pandey@amd.com>
 <20211011154452.76849-6-AjitKumar.Pandey@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c3a93858-65ee-d68e-d805-4248850e8553@infradead.org>
Date:   Mon, 11 Oct 2021 13:18:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211011154452.76849-6-AjitKumar.Pandey@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/21 8:44 AM, Ajit Kumar Pandey wrote:
> diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
> index 5cb7115662d2..2b9440372346 100644
> --- a/sound/soc/amd/acp/Kconfig
> +++ b/sound/soc/amd/acp/Kconfig
> @@ -34,3 +34,9 @@ config SND_SOC_AMD_MACH_COMMON
>   	depends on X86 && PCI && I2C
>   	help
>   	  This option enables common Machine driver module for ACP.
> +
> +config SND_SOC_AMD_LEGACY_MACH
> +	tristate "AMD Legacy Machine Driver Support"
> +	select SND_SOC_AMD_MACH_COMMON
> +	help
> +	 This option enables legacy sound card support for ACP audio.

Add one more space just before "This" to conform to kernel Kconfig
style, please.

-- 
~Randy
