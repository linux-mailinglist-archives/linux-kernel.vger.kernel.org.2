Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4135136CC0F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 22:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbhD0UCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 16:02:25 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:38349 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbhD0UCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 16:02:24 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MOz8O-1lwJe244cu-00PMG8 for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021
 22:01:39 +0200
Received: by mail-wm1-f48.google.com with SMTP id 26-20020a05600c22dab029013efd7879b8so5922170wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 13:01:38 -0700 (PDT)
X-Gm-Message-State: AOAM530R6FKitDVvX37Jv3+a/4ye/1ePPeayrZenl+8vhB1fkfwhMb9R
        70+6huZmWov45Fcw89NUUe6Vlw3oSpQyr98Rdmc=
X-Google-Smtp-Source: ABdhPJzoyqZPwdfvS0qcTCrVj7tYSuYjWyq3Sob/MEy/fzYtFKhcfPfD+UpWwAgXfSVlku9uAMSPfLT74SjvLdTKtng=
X-Received: by 2002:a7b:c846:: with SMTP id c6mr5885924wml.75.1619553698710;
 Tue, 27 Apr 2021 13:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <202104271905.1C7oj9q3-lkp@intel.com> <1d9958ea-aaae-0e45-7009-f12e4a4ae325@linux.intel.com>
 <CAK8P3a0k2rk=eN1v1JcpeXOm6kU+MJDKESyyC2AQ7CJVfREFFw@mail.gmail.com> <fddb59dd-8bf2-7f2c-7388-fab0475482e4@linux.intel.com>
In-Reply-To: <fddb59dd-8bf2-7f2c-7388-fab0475482e4@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 27 Apr 2021 22:01:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3mE9PR0cu6vpJ_1Yjq3oa1VUxvaM-7CFJnrmq6-RefQw@mail.gmail.com>
Message-ID: <CAK8P3a3mE9PR0cu6vpJ_1Yjq3oa1VUxvaM-7CFJnrmq6-RefQw@mail.gmail.com>
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
X-Provags-ID: V03:K1:sk/UyGNXzPJBZLo3lLgtTWseh5bI447cNVc5fMOiXqF/Z8b9rMU
 DeLuAiEr3LnavrRDeOys8c8flCO4o8o4uu7bxBjgtraiDszqhB1CZkcf1jrytkYVKIvJaGD
 8fRtjUzChs2mdCbVOwpglnnaYM1ib9Z01mqDuEq0xc7+SKIxFGF2FcY0Me141E1/RncKlsd
 A3r4/ZIQUwTahzqwKnPdQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MwftSasP+9I=:24MGCb5HLnhT/Rl7D6c5kz
 QdU7lgYyB0QpgMNGx49mgeCsOVU34GqDZCJg7wRET8bxz0hOHdC6Gua35wxNOZDt2ZKp98mp1
 YWpaZtZUyYNkuNdee7yTU/f0csRdY0LchWDgkZprLlWUe+GRO2/Fen9AY+X7W1AWQex2BVVey
 QqWe9RxK0JxUnMBHxKlkI+/5/7uJJ1ivMVd2CXbYUgHDgALW/WG96uMzDOd8mXmCE4TodtJCh
 RgdB5vagdFnIRFgST/0a3mi9PhnEwqQIOxyPQS+o2PnXgjScGyOuN/PxAo4EnsEVd7TPQlBBV
 /DmNPLb+6Y/eT+QQqAZVXkBG9cvZHnEBHJATbFx2J/f3QaRaKwG79rXRLeK8ikvA4eTW8DoFb
 PKiwCgtdbaATrSQ8jZUakj6K4I2JO7ROHIC0TufbsIxruSYf0dSaQJZ1bnNIjfItyJEJR9G4h
 zBHFPAyRqsue4yAxAF1ZWRhR6VWcnd/v1kfyjo1bHOteHIWAzJ9nw1J7PRS7yMjC1z8Jc7Ypv
 clqxUru/2GoLCc/lulhEVI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 9:13 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:

> > An easy workaround would be to move the first 500 or so lines of
> > sound/soc/sof/intel/byt.c into a separate file and #include that from
> > distinct baytrail and merrifield modules, at the cost of a bit of
> > object code duplication and a somewhat dirty hack.
>
> I have a fix being tested here:
> https://github.com/thesofproject/linux/pull/2874
>
> The idea is what you suggested, move the common parts to a new file but
> I used an 'atom' module instead #include to avoid duplication. The
> exported functions are namespaced to avoid polluting the global symbol map.
>
> The only other change needed is in the Makefile, We already have
> CONFIG_SND_SOC_SOF_INTEL_ATOM_HIFI_EP in the Kconfig and that can be
> used for this module.

Makes sense. I was slightly worried this would require exporting a ton
of symbols and possibly circular dependencies but looking at your patch,
it seems entirely fine.

      Arnd
