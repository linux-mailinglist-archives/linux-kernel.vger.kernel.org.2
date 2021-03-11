Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A511336EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhCKJgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:36:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:56036 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231960AbhCKJgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:36:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4BBF4AB8C;
        Thu, 11 Mar 2021 09:36:05 +0000 (UTC)
Date:   Thu, 11 Mar 2021 10:36:03 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
        linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ASoC: soc-core: fix DMI handling
Message-ID: <20210311103603.0bc952b6@endymion>
In-Reply-To: <20210310193928.108850-1-pierre-louis.bossart@linux.intel.com>
References: <20210310193928.108850-1-pierre-louis.bossart@linux.intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021 13:39:27 -0600, Pierre-Louis Bossart wrote:
> When DMI information is not present, trying to assign the card long
> name results in the following warning.
> 
> WARNING KERN tegra-audio-graph-card sound: ASoC: no DMI vendor name!
> 
> The initial solution suggested was to test if the card device is an
> ACPI one. This causes a regression visible to userspace on all Intel
> platforms, with UCM unable to load card profiles based on DMI
> information: the card devices are not necessarily ACPI ones, e.g. when
> the parent creates platform devices on Intel devices.
> 
> To fix this problem, this patch exports the existing dmi_available
> variable and tests it in the ASoC core.
> 
> Fixes: c014170408bc ("ASoC: soc-core: Prevent warning if no DMI table is present")
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/firmware/dmi_scan.c | 1 +
>  sound/soc/soc-core.c        | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> index d51ca0428bb8..f191a1f901ac 100644
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -166,6 +166,7 @@ static int __init dmi_checksum(const u8 *buf, u8 len)
>  static const char *dmi_ident[DMI_STRING_MAX];
>  static LIST_HEAD(dmi_devices);
>  int dmi_available;
> +EXPORT_SYMBOL_GPL(dmi_available);
>  
>  /*
>   *	Save a DMI string
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 16ba54eb8164..c7e4600b2dd4 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1574,7 +1574,7 @@ int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour)
>  	if (card->long_name)
>  		return 0; /* long name already set by driver or from DMI */
>  
> -	if (!is_acpi_device_node(card->dev->fwnode))
> +	if (!dmi_available)
>  		return 0;
>  
>  	/* make up dmi long name as: vendor-product-version-board */

Fine with me.

Acked-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
