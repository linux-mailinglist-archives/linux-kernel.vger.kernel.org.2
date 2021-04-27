Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC5B36CB3E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbhD0SnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:43:23 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43239 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhD0SnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:43:21 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MpDa5-1lFKrb3VxH-00qhV8 for <linux-kernel@vger.kernel.org>; Tue, 27 Apr
 2021 20:42:36 +0200
Received: by mail-wm1-f41.google.com with SMTP id 26-20020a05600c22dab029013efd7879b8so5819291wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 11:42:36 -0700 (PDT)
X-Gm-Message-State: AOAM530dFC+Fl2V6fFHnRl9axsqwu9J+hcnCX34ppJEuBJVwFyQStbyt
        g62YrXqgRkdlH2WqSOWhVn235VbN/YCVFJRhgMA=
X-Google-Smtp-Source: ABdhPJxpsxThHwsKRUNHVItTo982cwRkdv/yYmwiCwemV59ELDimALz7YuGUt7E/lseT7pdBOG8kXkpxf1UVJu9YIj0=
X-Received: by 2002:a7b:c4da:: with SMTP id g26mr1877643wmk.43.1619548956521;
 Tue, 27 Apr 2021 11:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <202104271905.1C7oj9q3-lkp@intel.com> <1d9958ea-aaae-0e45-7009-f12e4a4ae325@linux.intel.com>
In-Reply-To: <1d9958ea-aaae-0e45-7009-f12e4a4ae325@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 27 Apr 2021 20:42:04 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0k2rk=eN1v1JcpeXOm6kU+MJDKESyyC2AQ7CJVfREFFw@mail.gmail.com>
Message-ID: <CAK8P3a0k2rk=eN1v1JcpeXOm6kU+MJDKESyyC2AQ7CJVfREFFw@mail.gmail.com>
Subject: Re: sound/soc/sof/intel/byt.c:1057: undefined reference to `sof_acpi_probe'
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Bard Liao <bard.liao@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:TeYbLDFDKgiPL9dgqcAY0v0y1AXlkATvlLuAaIFbOg3nh8AbgZt
 cyQC79p0rE7IwJjCtP5BnJNKy/1o57QtFrRAENsXU187NZhQPAHWu4p9U7wePlq9wXSnaO/
 KRZijpRPJfBXz5eCE3BdYp0FCTaIDtnEGALbQXAlTN5Em6iRTnk3nTRKo61wzgXXdu/sM1C
 RdyQwrCaGMGjj7+9ZWSLw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4O8sRk6X15o=:79f2Ks+H+jtD42LK0Lgcr9
 p//jOUkxHskkGEat8N7SuObw2D/35ugSwfVVq8uEiRxrqZtt6v8s2ll3i1Lnk+Jvh6FHA7HVU
 jx+k61pWQdUdjn7peDMRlbF//ZtXIQo4CNhJ0zFnkmEsLsA+R1MLnqQFT6UtzP6Ugtv9m4EzQ
 X/P8jetEPyY95nn3KutlQDTSE4EENOnBjn951Y7SWslOq1C7QjuW/+EawBK4Hts5m6z49Do88
 PNiuyvAcEY/tMm/SxvLBSJgM882mYiIXL5JKgOnYt7lra4Cm6lOMsVq5VrtYAC1si1IjChafr
 EwZJPUSnWCQAkGCVNzcuYAT/A2TVvEtImDnYPtTZlUr+VQb0Q5EN6eSfFHiloLp/xvnEi8dwa
 6MOU7/GDuiooHnr2Npv+Ddu9WzHUNJi+wwgR2+xpg8av5u5UcnsMlS+lClYKra5FEMYMC1WD0
 kEm55wC5mlVPW848RQXACsRpuTsUNCMzw/5NwomZsXGE3G6zmGHUlTqzjIpcC/YUN4fDu1cjU
 g8SiWyZg4E2hh87a+svVqs=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 6:07 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 4/27/21 6:10 AM, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   4a0225c3d208cfa6e4550f2210ffd9114a952a81
> > commit: 8d4ba1be3d2257606e04aff412829d8972670750 ASoC: SOF: pci: split PCI into different drivers
> > date:   8 weeks ago
> > config: i386-randconfig-r024-20210426 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > reproduce (this is a W=1 build):
> >          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8d4ba1be3d2257606e04aff412829d8972670750
> >          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >          git fetch --no-tags linus master
> >          git checkout 8d4ba1be3d2257606e04aff412829d8972670750
> >          # save the attached .config to linux build tree
> >          make W=1 W=1 ARCH=i386
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >     ld: sound/soc/sof/intel/byt.o: in function `sof_baytrail_probe':
> >>> sound/soc/sof/intel/byt.c:1057: undefined reference to `sof_acpi_probe'
> >>> ld: sound/soc/sof/intel/byt.o:(.data+0x44): undefined reference to `sof_acpi_remove'
> >>> ld: sound/soc/sof/intel/byt.o:(.data+0x94): undefined reference to `sof_acpi_pm'
>
> Ack, this is again the partition between Baytrail and Merrifield that's
> problematic in the corner case where ACPI is compiled as module and PCI
> as built-in. It's a bit academic since the PCI probe wouldn't work, but
> still it's not well partitioned.
>
> I've been wanting to change this for a while, and split the common atom
> parts from the ACPI/PCI parts. I guess it's time to fix this for good.

I wonder why I never see these in randconfig builds here. I can reproduce it
with the .config from the link above though, and I see these relevant config
lines:

CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL=y
CONFIG_SND_SOC_SOF_INTEL_ATOM_HIFI_EP=y
CONFIG_SND_SOC_SOF_MERRIFIELD=y
CONFIG_SND_SOC_SOF_ACPI=m
CONFIG_SND_SOC_SOF_ACPI_DEV=m
CONFIG_SND_SOC_SOF_BAYTRAIL=m

An easy workaround would be to move the first 500 or so lines of
sound/soc/sof/intel/byt.c into a separate file and #include that from
distinct baytrail and merrifield modules, at the cost of a bit of
object code duplication and a somewhat dirty hack.

Another option would be a Kconfig hack to prevent the broken
configuration, such as

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index eebe784ff652..b2039b4af9cf 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -85,6 +85,8 @@ config SND_SOC_SOF_MERRIFIELD
        tristate "SOF support for Tangier/Merrifield"
        default SND_SOC_SOF_PCI
        select SND_SOC_SOF_INTEL_ATOM_HIFI_EP
+       # Merrifield can't be built-in if snd-sof-acpi-intel-byt.ko is a module
+       depends on SND_SOC_SOF_BAYTRAIL || !SND_SOC_SOF_BAYTRAIL
        help
          This adds support for Sound Open Firmware for Intel(R) platforms
          using the Tangier/Merrifield processors.

        Arnd
