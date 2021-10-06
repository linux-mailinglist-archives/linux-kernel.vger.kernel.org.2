Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA19423E54
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 15:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238447AbhJFNCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 09:02:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:42207 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhJFNCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 09:02:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="212925146"
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="212925146"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 06:00:21 -0700
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="439108427"
Received: from nbasa-mobl2.amr.corp.intel.com (HELO [10.213.170.135]) ([10.213.170.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 06:00:20 -0700
Subject: Re: [PATCH] ASoC: soc-acpi: add alternative id field for machine
 driver matching
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
References: <20211006084351.438510-1-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <da650858-6523-4813-6433-438e974d060a@linux.intel.com>
Date:   Wed, 6 Oct 2021 07:17:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211006084351.438510-1-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/21 3:43 AM, Brent Lu wrote:
> Current design to support second headphone driver in the same machine
> driver is to duplicate the entries in snd_soc_acpi_mach array and
> board configs in machine driver. We can avoid this by adding an id_alt
> field in snd_soc_acpi_mach structure to specify alternative ACPI HIDs
> for machine driver enumeration and leave the codec type detection to
> machine driver if necessary.

I am not following your suggestion. The machine drivers for I2S/TDM
platforms are typically based on specific headphone codecs, and they we
add possible swaps for amplifiers. The key to find a machine is
typically the headphone HID. Exhibit A for this in your own contribution
in the recent weeks with the sof_cs42l42.c machine driver.

Are you suggesting we unify e.g. sof_rt5682.c and sof_cs42l42.c?

The other problem is that today we have one main HID along with
'quirk_data' for amplifiers. If we have alternate HIDs, what would be
the rule for quirk_data? Can the quirks apply to all possible alternate
HIDs? Only one of them?

Without an example where this new alternate ID is used it's hard to see
what the ask and directions might be.

Care to elaborate?
Thanks!

> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---
>  include/sound/soc-acpi.h |  2 ++
>  sound/soc/soc-acpi.c     | 21 ++++++++++++++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
> index 2f3fa385c092..fcf6bae9f9d7 100644
> --- a/include/sound/soc-acpi.h
> +++ b/include/sound/soc-acpi.h
> @@ -129,6 +129,7 @@ struct snd_soc_acpi_link_adr {
>   * all firmware/topology related fields.
>   *
>   * @id: ACPI ID (usually the codec's) used to find a matching machine driver.
> + * @id_alt: array of ACPI IDs used as an alternative of id field.
>   * @link_mask: describes required board layout, e.g. for SoundWire.
>   * @links: array of link _ADR descriptors, null terminated.
>   * @drv_name: machine driver name
> @@ -146,6 +147,7 @@ struct snd_soc_acpi_link_adr {
>  /* Descriptor for SST ASoC machine driver */
>  struct snd_soc_acpi_mach {
>  	const u8 id[ACPI_ID_LEN];
> +	struct snd_soc_acpi_codecs *id_alt;
>  	const u32 link_mask;
>  	const struct snd_soc_acpi_link_adr *links;
>  	const char *drv_name;
> diff --git a/sound/soc/soc-acpi.c b/sound/soc/soc-acpi.c
> index 395229bf5c51..ab67d640c20f 100644
> --- a/sound/soc/soc-acpi.c
> +++ b/sound/soc/soc-acpi.c
> @@ -8,6 +8,25 @@
>  #include <linux/module.h>
>  #include <sound/soc-acpi.h>
>  
> +static bool snd_soc_acpi_id_present(struct snd_soc_acpi_mach *machine)
> +{
> +	struct snd_soc_acpi_codecs *id_alt = machine->id_alt;
> +	int i;
> +
> +	if (acpi_dev_present(machine->id, NULL, -1))
> +		return true;
> +
> +	if (id_alt == NULL)
> +		return false;
> +
> +	for (i = 0; i < id_alt->num_codecs; i++) {
> +		if (acpi_dev_present(id_alt->codecs[i], NULL, -1))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  struct snd_soc_acpi_mach *
>  snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
>  {
> @@ -15,7 +34,7 @@ snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
>  	struct snd_soc_acpi_mach *mach_alt;
>  
>  	for (mach = machines; mach->id[0]; mach++) {
> -		if (acpi_dev_present(mach->id, NULL, -1)) {
> +		if (snd_soc_acpi_id_present(mach) != false) {
>  			if (mach->machine_quirk) {
>  				mach_alt = mach->machine_quirk(mach);
>  				if (!mach_alt)
> 
