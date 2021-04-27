Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1DC36CB83
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 21:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbhD0TOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 15:14:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:8751 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhD0TO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 15:14:29 -0400
IronPort-SDR: cV1K1I54DsI4oiyibkpbXgUSW2tGpYaSu9jDrp/9RgJ1VuesNqVtroKLSyuR8aa+NrjvY8V/V4
 iFV3COVKUVlg==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="217288757"
X-IronPort-AV: E=Sophos;i="5.82,255,1613462400"; 
   d="scan'208";a="217288757"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 12:13:42 -0700
IronPort-SDR: +rOSHwtLe8CEYYVmyPnlHC5j9E/FP9srmO0txOhRNV0IkwGLgyM/mDHNBL1w06oGeUgKRA70Hb
 qY9z8QiVHApg==
X-IronPort-AV: E=Sophos;i="5.82,255,1613462400"; 
   d="scan'208";a="457801829"
Received: from aimam2-mobl1.amr.corp.intel.com (HELO [10.212.7.187]) ([10.212.7.187])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 12:13:41 -0700
Subject: Re: sound/soc/sof/intel/byt.c:1057: undefined reference to
 `sof_acpi_probe'
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Bard Liao <bard.liao@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
References: <202104271905.1C7oj9q3-lkp@intel.com>
 <1d9958ea-aaae-0e45-7009-f12e4a4ae325@linux.intel.com>
 <CAK8P3a0k2rk=eN1v1JcpeXOm6kU+MJDKESyyC2AQ7CJVfREFFw@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fddb59dd-8bf2-7f2c-7388-fab0475482e4@linux.intel.com>
Date:   Tue, 27 Apr 2021 14:13:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0k2rk=eN1v1JcpeXOm6kU+MJDKESyyC2AQ7CJVfREFFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>>      ld: sound/soc/sof/intel/byt.o: in function `sof_baytrail_probe':
>>>>> sound/soc/sof/intel/byt.c:1057: undefined reference to `sof_acpi_probe'
>>>>> ld: sound/soc/sof/intel/byt.o:(.data+0x44): undefined reference to `sof_acpi_remove'
>>>>> ld: sound/soc/sof/intel/byt.o:(.data+0x94): undefined reference to `sof_acpi_pm'
>>
>> Ack, this is again the partition between Baytrail and Merrifield that's
>> problematic in the corner case where ACPI is compiled as module and PCI
>> as built-in. It's a bit academic since the PCI probe wouldn't work, but
>> still it's not well partitioned.
>>
>> I've been wanting to change this for a while, and split the common atom
>> parts from the ACPI/PCI parts. I guess it's time to fix this for good.
> 
> I wonder why I never see these in randconfig builds here. I can reproduce it
> with the .config from the link above though, and I see these relevant config
> lines:
> 
> CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL=y
> CONFIG_SND_SOC_SOF_INTEL_ATOM_HIFI_EP=y
> CONFIG_SND_SOC_SOF_MERRIFIELD=y
> CONFIG_SND_SOC_SOF_ACPI=m
> CONFIG_SND_SOC_SOF_ACPI_DEV=m
> CONFIG_SND_SOC_SOF_BAYTRAIL=m

yes, we end-up with a bad configuration with BAYTRAIL as m and 
Merrifield as y. That's broken since they share the same file.

> An easy workaround would be to move the first 500 or so lines of
> sound/soc/sof/intel/byt.c into a separate file and #include that from
> distinct baytrail and merrifield modules, at the cost of a bit of
> object code duplication and a somewhat dirty hack.

I have a fix being tested here:
https://github.com/thesofproject/linux/pull/2874

The idea is what you suggested, move the common parts to a new file but 
I used an 'atom' module instead #include to avoid duplication. The 
exported functions are namespaced to avoid polluting the global symbol map.

The only other change needed is in the Makefile, We already have 
CONFIG_SND_SOC_SOF_INTEL_ATOM_HIFI_EP in the Kconfig and that can be 
used for this module.

> Another option would be a Kconfig hack to prevent the broken
> configuration, such as
> 
> diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
> index eebe784ff652..b2039b4af9cf 100644
> --- a/sound/soc/sof/intel/Kconfig
> +++ b/sound/soc/sof/intel/Kconfig
> @@ -85,6 +85,8 @@ config SND_SOC_SOF_MERRIFIELD
>          tristate "SOF support for Tangier/Merrifield"
>          default SND_SOC_SOF_PCI
>          select SND_SOC_SOF_INTEL_ATOM_HIFI_EP
> +       # Merrifield can't be built-in if snd-sof-acpi-intel-byt.ko is a module
> +       depends on SND_SOC_SOF_BAYTRAIL || !SND_SOC_SOF_BAYTRAIL
>          help
>            This adds support for Sound Open Firmware for Intel(R) platforms
>            using the Tangier/Merrifield processors.

It'd rather do this the right way with a proper code partitioning, I was 
tempted to do it multiple times and I've had it with this code.
