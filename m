Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FBE36C912
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbhD0QKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:10:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:23756 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237348AbhD0QKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:10:08 -0400
IronPort-SDR: vrr7cCXOxYT0S3kOvDreJqIurMRM+mpOn0xjTmjmg7QS8K/QDRDl8yBvBy9JaTQTzz8E/dHoe3
 slC4vwIRB8KA==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="196094128"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="196094128"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 09:07:46 -0700
IronPort-SDR: 3wcT/Byeu1MUJsZ776C9zShn2ZqWjTq98GQ4fc63QMx0DeXzdokEAqOLdVkHIiX0q3XtEIEHYm
 Q/IRl+QFJDHQ==
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="387373390"
Received: from snekkala-mobl2.amr.corp.intel.com (HELO [10.209.154.74]) ([10.209.154.74])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 09:07:43 -0700
Subject: Re: sound/soc/sof/intel/byt.c:1057: undefined reference to
 `sof_acpi_probe'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Bard Liao <bard.liao@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
References: <202104271905.1C7oj9q3-lkp@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1d9958ea-aaae-0e45-7009-f12e4a4ae325@linux.intel.com>
Date:   Tue, 27 Apr 2021 11:07:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <202104271905.1C7oj9q3-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/21 6:10 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   4a0225c3d208cfa6e4550f2210ffd9114a952a81
> commit: 8d4ba1be3d2257606e04aff412829d8972670750 ASoC: SOF: pci: split PCI into different drivers
> date:   8 weeks ago
> config: i386-randconfig-r024-20210426 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8d4ba1be3d2257606e04aff412829d8972670750
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout 8d4ba1be3d2257606e04aff412829d8972670750
>          # save the attached .config to linux build tree
>          make W=1 W=1 ARCH=i386
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     ld: sound/soc/sof/intel/byt.o: in function `sof_baytrail_probe':
>>> sound/soc/sof/intel/byt.c:1057: undefined reference to `sof_acpi_probe'
>>> ld: sound/soc/sof/intel/byt.o:(.data+0x44): undefined reference to `sof_acpi_remove'
>>> ld: sound/soc/sof/intel/byt.o:(.data+0x94): undefined reference to `sof_acpi_pm'

Ack, this is again the partition between Baytrail and Merrifield that's 
problematic in the corner case where ACPI is compiled as module and PCI 
as built-in. It's a bit academic since the PCI probe wouldn't work, but 
still it's not well partitioned.

I've been wanting to change this for a while, and split the common atom 
parts from the ACPI/PCI parts. I guess it's time to fix this for good.

> vim +1057 sound/soc/sof/intel/byt.c
> 
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1032
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1033  static int sof_baytrail_probe(struct platform_device *pdev)
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1034  {
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1035  	struct device *dev = &pdev->dev;
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1036  	const struct sof_dev_desc *desc;
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1037  	const struct acpi_device_id *id;
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1038  	int ret;
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1039
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1040  	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1041  	if (!id)
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1042  		return -ENODEV;
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1043
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1044  	ret = snd_intel_acpi_dsp_driver_probe(dev, id->id);
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1045  	if (ret != SND_INTEL_DSP_DRIVER_ANY && ret != SND_INTEL_DSP_DRIVER_SOF) {
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1046  		dev_dbg(dev, "SOF ACPI driver not selected, aborting probe\n");
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1047  		return -ENODEV;
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1048  	}
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1049
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1050  	desc = device_get_match_data(&pdev->dev);
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1051  	if (!desc)
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1052  		return -ENODEV;
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1053
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1054  	if (desc == &sof_acpi_baytrail_desc && soc_intel_is_byt_cr(pdev))
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1055  		desc = &sof_acpi_baytrailcr_desc;
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1056
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01 @1057  	return sof_acpi_probe(pdev, desc);
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1058  }
> 8a49cd11e68ed0 Arnd Bergmann 2021-03-01  1059
> 
> :::::: The code at line 1057 was first introduced by commit
> :::::: 8a49cd11e68ed0e6a687de04d25c06553bf96b0c ASoC: SOF: ACPI: avoid reverse module dependency
> 
> :::::: TO: Arnd Bergmann <arnd@arndb.de>
> :::::: CC: Takashi Iwai <tiwai@suse.de>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
