Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07AF3CED4F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383109AbhGSRwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:52:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:33819 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234863AbhGSRny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 13:43:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="232883855"
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="232883855"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 11:24:32 -0700
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="414430038"
Received: from rraymond-mobl1.amr.corp.intel.com (HELO [10.209.130.70]) ([10.209.130.70])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 11:24:30 -0700
Subject: Re: [PATCH V3 04/12] ASoC: amd: create acp5x platform devices
To:     Vijendar Mukunda <vijendar.mukunda@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Alexander.Deucher@amd.com,
        krisman@collabora.com
References: <20210719165140.16143-1-vijendar.mukunda@amd.com>
 <20210719165140.16143-5-vijendar.mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <035b3dbe-bbe0-bf0b-3893-d176418658f7@linux.intel.com>
Date:   Mon, 19 Jul 2021 13:07:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210719165140.16143-5-vijendar.mukunda@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/21 11:51 AM, Vijendar Mukunda wrote:
> ACP5.x IP has multiple I2S controllers and DMA controller.
> Create platform devices for I2S HS controller instance, I2S SP controller
> instance and DMA contrller.

typo: controller

> Pass PCI resources like MMIO, irq to these platform devices.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  sound/soc/amd/vangogh/acp5x.h     | 10 ++++
>  sound/soc/amd/vangogh/pci-acp5x.c | 95 ++++++++++++++++++++++++++++++-
>  2 files changed, 102 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/amd/vangogh/acp5x.h b/sound/soc/amd/vangogh/acp5x.h
> index 708586109315..bbf29fd2b12f 100644
> --- a/sound/soc/amd/vangogh/acp5x.h
> +++ b/sound/soc/amd/vangogh/acp5x.h
> @@ -22,6 +22,16 @@
>  #define ACP_ERR_INTR_MASK	0x20000000
>  #define ACP_EXT_INTR_STAT_CLEAR_MASK 0xFFFFFFFF
>  
> +#define ACP5x_DEVS 0x03

3?

> +#define	ACP5x_REG_START	0x1240000
> +#define	ACP5x_REG_END	0x1250200
> +#define ACP5x_I2STDM_REG_START	0x1242400
> +#define ACP5x_I2STDM_REG_END	0x1242410
> +#define ACP5x_HS_TDM_REG_START	0x1242814
> +#define ACP5x_HS_TDM_REG_END	0x1242824
> +#define I2S_MODE 0x00
> +#define ACP5x_I2S_MODE 0x00
> +
>  /* common header file uses exact offset rather than relative
>   * offset which requires substraction logic from base_addr

typo: subtraction

>   * for accessing ACP5x MMIO space registers
> diff --git a/sound/soc/amd/vangogh/pci-acp5x.c b/sound/soc/amd/vangogh/pci-acp5x.c
> index 523b962fe35e..3cc15a15b745 100644
> --- a/sound/soc/amd/vangogh/pci-acp5x.c
> +++ b/sound/soc/amd/vangogh/pci-acp5x.c
> @@ -8,11 +8,16 @@
>  #include <linux/module.h>
>  #include <linux/io.h>
>  #include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
>  
>  #include "acp5x.h"
>  
>  struct acp5x_dev_data {
>  	void __iomem *acp5x_base;
> +	bool acp5x_audio_mode;
> +	struct resource *res;
> +	struct platform_device *pdev[3];

pdev[ACP5x_DEVS] ?

>  };
>  
>  static int acp5x_power_on(void __iomem *acp5x_base)
> @@ -114,9 +119,12 @@ static int snd_acp5x_probe(struct pci_dev *pci,
>  			   const struct pci_device_id *pci_id)
>  {
>  	struct acp5x_dev_data *adata;
> -	int ret;
> -	u32 addr;
> +	struct platform_device_info pdevinfo[3];
> +	unsigned int irqflags;
> +	int ret, i;
> +	u32 addr, val;
>  
> +	irqflags = IRQF_SHARED;
>  	if (pci->revision != 0x50)
>  		return -ENODEV;
>  
> @@ -150,6 +158,83 @@ static int snd_acp5x_probe(struct pci_dev *pci,
>  	if (ret)
>  		goto release_regions;
>  
> +	val = acp_readl(adata->acp5x_base + ACP_PIN_CONFIG);
> +	switch (val) {
> +	case I2S_MODE:
> +		adata->res = devm_kzalloc(&pci->dev,
> +					  sizeof(struct resource) * 4,

what is this 4 value?

> +					  GFP_KERNEL);
> +		if (!adata->res) {
> +			ret = -ENOMEM;
> +			goto de_init;
> +		}
> +
> +		adata->res[0].name = "acp5x_i2s_iomem";
> +		adata->res[0].flags = IORESOURCE_MEM;
> +		adata->res[0].start = addr;
> +		adata->res[0].end = addr + (ACP5x_REG_END - ACP5x_REG_START);
> +
> +		adata->res[1].name = "acp5x_i2s_sp";
> +		adata->res[1].flags = IORESOURCE_MEM;
> +		adata->res[1].start = addr + ACP5x_I2STDM_REG_START;
> +		adata->res[1].end = addr + ACP5x_I2STDM_REG_END;
> +
> +		adata->res[2].name = "acp5x_i2s_hs";
> +		adata->res[2].flags = IORESOURCE_MEM;
> +		adata->res[2].start = addr + ACP5x_HS_TDM_REG_START;
> +		adata->res[2].end = addr + ACP5x_HS_TDM_REG_END;
> +
> +		adata->res[3].name = "acp5x_i2s_irq";
> +		adata->res[3].flags = IORESOURCE_IRQ;
> +		adata->res[3].start = pci->irq;
> +		adata->res[3].end = adata->res[3].start;
> +
> +		adata->acp5x_audio_mode = ACP5x_I2S_MODE;
> +
> +		memset(&pdevinfo, 0, sizeof(pdevinfo));
> +		pdevinfo[0].name = "acp5x_i2s_dma";
> +		pdevinfo[0].id = 0;
> +		pdevinfo[0].parent = &pci->dev;
> +		pdevinfo[0].num_res = 4;
> +		pdevinfo[0].res = &adata->res[0];
> +		pdevinfo[0].data = &irqflags;
> +		pdevinfo[0].size_data = sizeof(irqflags);
> +
> +		pdevinfo[1].name = "acp5x_i2s_playcap";
> +		pdevinfo[1].id = 0;
> +		pdevinfo[1].parent = &pci->dev;
> +		pdevinfo[1].num_res = 1;
> +		pdevinfo[1].res = &adata->res[1];
> +
> +		pdevinfo[2].name = "acp5x_i2s_playcap";
> +		pdevinfo[2].id = 1;
> +		pdevinfo[2].parent = &pci->dev;
> +		pdevinfo[2].num_res = 1;
> +		pdevinfo[2].res = &adata->res[2];
> +
> +		for (i = 0; i < ACP5x_DEVS; i++) {
> +			adata->pdev[i] =
> +				platform_device_register_full(&pdevinfo[i]);
> +			if (IS_ERR(adata->pdev[i])) {
> +				dev_err(&pci->dev, "cannot register %s device\n",
> +					pdevinfo[i].name);
> +				ret = PTR_ERR(adata->pdev[i]);
> +				goto unregister_devs;
> +			}
> +		}
> +		break;
> +	default:
> +		dev_info(&pci->dev, "ACP audio mode : %d\n", val);
> +	}
> +	return 0;
> +
> +unregister_devs:
> +	if (val == I2S_MODE)

nit-pick: you can't reach this point outside of the I2S_MODE, so this test is not useful


> +		for (i = 0; i < ACP5x_DEVS; i++)
> +			platform_device_unregister(adata->pdev[i]);

only unregister what you registered?

for (--i; i > 0; i--)

> +de_init:
> +	if (acp5x_deinit(adata->acp5x_base))
> +		dev_err(&pci->dev, "ACP de-init failed\n");
>  release_regions:
>  	pci_release_regions(pci);
>  disable_pci:
> @@ -161,9 +246,13 @@ static int snd_acp5x_probe(struct pci_dev *pci,
>  static void snd_acp5x_remove(struct pci_dev *pci)
>  {
>  	struct acp5x_dev_data *adata;
> -	int ret;
> +	int i, ret;
>  
>  	adata = pci_get_drvdata(pci);
> +	if (adata->acp5x_audio_mode == ACP5x_I2S_MODE) {
> +		for (i = 0; i < ACP5x_DEVS; i++)
> +			platform_device_unregister(adata->pdev[i]);
> +	}
>  	ret = acp5x_deinit(adata->acp5x_base);
>  	if (ret)
>  		dev_err(&pci->dev, "ACP de-init failed\n");
> 
