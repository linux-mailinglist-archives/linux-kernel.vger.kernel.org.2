Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E302424254
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbhJFQPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:15:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:10617 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231998AbhJFQPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:15:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="249310189"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="249310189"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 09:09:02 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="439169436"
Received: from nbasa-mobl2.amr.corp.intel.com (HELO [10.213.170.135]) ([10.213.170.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 09:09:01 -0700
Subject: Re: [PATCH v1 1/4] ASoC: Intel: bytcht_es8316: Get platform data via
 dev_get_platdata()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20211006150428.16434-1-andriy.shevchenko@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c8b85524-6b9f-8fd3-3978-1d26b92660fd@linux.intel.com>
Date:   Wed, 6 Oct 2021 10:52:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211006150428.16434-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/21 10:04 AM, Andy Shevchenko wrote:
> Access to platform data via dev_get_platdata() getter to make code cleaner.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

For the series

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.com>

FWIW Marc likes a cover letter that's kept in the merge logs.

> ---
>  sound/soc/intel/boards/bytcht_es8316.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
> index 1bb9b8e7bcc7..4360519fbb0c 100644
> --- a/sound/soc/intel/boards/bytcht_es8316.c
> +++ b/sound/soc/intel/boards/bytcht_es8316.c
> @@ -456,12 +456,12 @@ static const struct dmi_system_id byt_cht_es8316_quirk_table[] = {
>  
>  static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
>  	static const char * const mic_name[] = { "in1", "in2" };
> +	struct snd_soc_acpi_mach *mach = dev_get_platdata(dev);
>  	struct property_entry props[MAX_NO_PROPS] = {};
>  	struct byt_cht_es8316_private *priv;
>  	const struct dmi_system_id *dmi_id;
> -	struct device *dev = &pdev->dev;
> -	struct snd_soc_acpi_mach *mach;
>  	struct fwnode_handle *fwnode;
>  	const char *platform_name;
>  	struct acpi_device *adev;
> @@ -476,7 +476,6 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	mach = dev->platform_data;
>  	/* fix index of codec dai */
>  	for (i = 0; i < ARRAY_SIZE(byt_cht_es8316_dais); i++) {
>  		if (!strcmp(byt_cht_es8316_dais[i].codecs->name,
> 
