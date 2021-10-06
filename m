Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C54542479B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 21:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbhJFUA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 16:00:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:46092 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229761AbhJFUA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 16:00:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="206903327"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="206903327"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 12:58:24 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="439247446"
Received: from nbasa-mobl2.amr.corp.intel.com (HELO [10.213.170.135]) ([10.213.170.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 12:58:21 -0700
Subject: Re: [PATCH 3/3] ASoC: Intel: sof_rt5682: use id_alt to enumerate
 rt5682s
To:     Curtis Malainey <cujomalainey@google.com>
Cc:     Brent Lu <brent.lu@intel.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rander Wang <rander.wang@intel.com>,
        Bard Liao <bard.liao@intel.com>,
        Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>,
        Libin Yang <libin.yang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Gongjun Song <gongjun.song@intel.com>
References: <20211006161805.938950-1-brent.lu@intel.com>
 <20211006161805.938950-4-brent.lu@intel.com>
 <CAOReqxjGX6fwqNjX0i31JiQJ+vRCMNTTFBhn7L=iPzYvVMk9mQ@mail.gmail.com>
 <0482534d-46c4-5cee-25bd-8739e80a00f0@linux.intel.com>
 <CAOReqxisH_9TuP_v77JzdQ+v+duPvvyHNHBxXzGJZ3dMoyMczQ@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <dfd23e78-b7c8-fa77-035e-19c9af595719@linux.intel.com>
Date:   Wed, 6 Oct 2021 14:58:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAOReqxisH_9TuP_v77JzdQ+v+duPvvyHNHBxXzGJZ3dMoyMczQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't see an issue with still using a struct since we are using the
> same list across multiple machines, but this makes me wonder if maybe
> we should refactor this into another layer, having the ids at a top
> structure and then the speaker matches a layer down. E.g.
> 
>  struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
>         {
>                 .drv_name = "adl_mx98373_rt5682",
>                 .machine_quirk = snd_soc_acpi_codec_list,
>                 .quirk_data = &adl_max98373_amp,
>         },
>         {
>                 .drv_name = "adl_mx98357_rt5682",
>                 .machine_quirk = snd_soc_acpi_codec_list,
>                 .quirk_data = &adl_max98357a_amp,
>         },
>         {
>                 .drv_name = "adl_mx98360_rt5682",
>                 .machine_quirk = snd_soc_acpi_codec_list,
>                 .quirk_data = &adl_max98360a_amp,
>         }
> }
> 
> struct machine_driver adl_rt5682_driver_match {
>   .id = { "10EC5682", "RTL5682" }
>   .instances = &adl_rt5682_machines
> }

We probably need to experiment various options, on one hand the proposal
removes duplication but in a lot of cases outside of Chromebooks/rt5640
there is none, so that table rework adds an indirection with no real
benefit.
