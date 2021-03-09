Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99B4332F31
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhCITmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:42:05 -0500
Received: from mga18.intel.com ([134.134.136.126]:18675 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhCITlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:41:55 -0500
IronPort-SDR: Vl/66cGzAq6EXYauokt8kZoepgEOccFHCgUzPJQuuo9eQRP4qUslfPO++GRcBRbZdiaPXQSBDP
 zSpbhpVV+QJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="175911862"
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="175911862"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 11:41:48 -0800
IronPort-SDR: CcuWziOV8r+3pfJrl+fnBlyvOCafqG+gqjr7zBk88xXNo6XphpN8KI+eY84qjypFt3sD7nuo+K
 ZsZ6YHLywf4g==
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="437748702"
Received: from ankitama-mobl1.amr.corp.intel.com (HELO [10.209.121.187]) ([10.209.121.187])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 11:41:47 -0800
Subject: Re: [PATCH V2] ASoC: soc-core: Prevent warning if no DMI table is
 present
To:     Jon Hunter <jonathanh@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>
References: <20210303115526.419458-1-jonathanh@nvidia.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <91480f92-a3f5-e71f-acdc-ea74488ab0a1@linux.intel.com>
Date:   Tue, 9 Mar 2021 13:41:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210303115526.419458-1-jonathanh@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/21 5:55 AM, Jon Hunter wrote:
> Many systems do not use ACPI and hence do not provide a DMI table. On
> non-ACPI systems a warning, such as the following, is printed on boot.
> 
>   WARNING KERN tegra-audio-graph-card sound: ASoC: no DMI vendor name!
> 
> The variable 'dmi_available' is not exported and so currently cannot be
> used by kernel modules without adding an accessor. However, it is
> possible to use the function is_acpi_device_node() to determine if the
> sound card is an ACPI device and hence indicate if we expect a DMI table
> to be present. Therefore, call is_acpi_device_node() to see if we are
> using ACPI and only parse the DMI table if we are booting with ACPI.

That change introduces a regression on all our tests: the names are not 
correctly set, which will prevent UCM from loading the relevant profiles 
based on the long name.

Before:
  0 [sofhdadsp      ]: sof-hda-dsp - sof-hda-dsp
                       AAEON-UP_WHL01-V1.0

After:
root@plb-UP-WHL01:/proc/asound# more cards
  0 [sofhdadsp      ]: sof-hda-dsp - sof-hda-dsp
                       sof-hda-dsp

The problem is that the cards are platform devices created by the parent 
(which itself may be a PCI or ACPI device) and have nothing to do with ACPI.

Could we flip the logic and instead explicitly detect OF devices? That 
restores functionality for us.

Jon, would this work for you?

Thanks!

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 16ba54eb8164..5c40b4548413 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1574,7 +1574,7 @@ int snd_soc_set_dmi_name(struct snd_soc_card 
*card, const char *flavour)
         if (card->long_name)
                 return 0; /* long name already set by driver or from DMI */

-       if (!is_acpi_device_node(card->dev->fwnode))
+       if (is_of_node(card->dev->fwnode))
                 return 0;

         /* make up dmi long name as: vendor-product-version-board */


> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> Changes since V1:
> - Use is_acpi_device_node() to determine if we expect the DMI table to
>    be present.
> 
>   sound/soc/soc-core.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index f6d4e99b590c..0cffc9527e28 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -31,6 +31,7 @@
>   #include <linux/of.h>
>   #include <linux/of_graph.h>
>   #include <linux/dmi.h>
> +#include <linux/acpi.h>
>   #include <sound/core.h>
>   #include <sound/pcm.h>
>   #include <sound/pcm_params.h>
> @@ -1573,6 +1574,9 @@ int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour)
>   	if (card->long_name)
>   		return 0; /* long name already set by driver or from DMI */
>   
> +	if (!is_acpi_device_node(card->dev->fwnode))
> +		return 0;
> +
>   	/* make up dmi long name as: vendor-product-version-board */
>   	vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
>   	if (!vendor || !is_dmi_valid(vendor)) {
> 
