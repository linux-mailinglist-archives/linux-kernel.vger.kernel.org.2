Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359914246A3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 21:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239353AbhJFTX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 15:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhJFTX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 15:23:57 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCFFC061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 12:22:04 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id w14so3684924qkf.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 12:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FnP39XDqwUDKj+L29KvHYvVj6TkVRcAAokzYN+iUggs=;
        b=gZfxWS+jqL9gtoJjT6lfE5zR038UOUAf7kNBsMgig+N+zJ/tqvsCUPzzEuYUyT5leG
         7VfGasx6WcAwyTAQrYWTLFpR+W5mp2bBf0+oWBcKUOgMdLS+2V/McWT0dEb7rndA3Hjr
         hUSseCiGIan9Zstcrha2TUnSkEskjxA/3IijYfmn8Wt2PlAZpiDmGzdhR0eiIRVHYgIi
         LVWj/qvuJWDhn0fvcWwIoqC1in5qkrVSovl5x9RLMMPa54bWO4W9ytOJXQwOe8mK2IE1
         hg2bgQcARtfGrWkvXCD9Vk09nfIdKC2QifQZMhF/10hxluVhaa3Yo0TXsBHPa93pHqMf
         mupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FnP39XDqwUDKj+L29KvHYvVj6TkVRcAAokzYN+iUggs=;
        b=zOOlHtyx7QD+AQl4VmGTDQmtC4j/OteJrGOiEphaNVzrE15FujkNrKgnl/53hRwc3X
         e4lNgull7drmF6ulMNx7pTq500X0bJjkC8rx/NRFnhGTHABmnaxTscnF3UoIXcLetO4m
         6uNeM4ZdQFQWnpQ8KGkp+5scHGXdQh6JvcaN5E9MubviI3fFcy275/zDuu+JuvilasXl
         ZkovaPg3/ZlLW7ErmmPuavUsCqVNXG7qy0pHFUdHNtywlS0ySsDVkW5CU+CwcHGCKzsE
         M4IjZrkSTaooGiNjWZDLZkGM29wWqakZF0BFOf/JqvXK0HsLTj44TgYoiniUxzY4k/BC
         6CYA==
X-Gm-Message-State: AOAM531E+czjp9EHp9cdJGE3AOvrhD86abhmK3EYmuyEJwoBJA991omZ
        ZpRDeRCUO8VJgA1C8kssgRpTCPEE3sKomycJZ14MzQ==
X-Google-Smtp-Source: ABdhPJyIgUgRYybHDmpu2/QLxzAOSr3kKCKcfPSAgIULu5tkrjY78F21WLqcRrlUu2pol//2JXPt/SjKtfFowD6vejM=
X-Received: by 2002:a37:43d6:: with SMTP id q205mr474410qka.4.1633548122106;
 Wed, 06 Oct 2021 12:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211006161805.938950-1-brent.lu@intel.com> <20211006161805.938950-4-brent.lu@intel.com>
 <CAOReqxjGX6fwqNjX0i31JiQJ+vRCMNTTFBhn7L=iPzYvVMk9mQ@mail.gmail.com> <0482534d-46c4-5cee-25bd-8739e80a00f0@linux.intel.com>
In-Reply-To: <0482534d-46c4-5cee-25bd-8739e80a00f0@linux.intel.com>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Wed, 6 Oct 2021 12:21:51 -0700
Message-ID: <CAOReqxisH_9TuP_v77JzdQ+v+duPvvyHNHBxXzGJZ3dMoyMczQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ASoC: Intel: sof_rt5682: use id_alt to enumerate rt5682s
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 11:43 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 10/6/21 1:34 PM, Curtis Malainey wrote:
> >>  };
> >>
> >> +static struct snd_soc_acpi_codecs adl_rt5682s_hp = {
> >> +       .num_codecs = 1,
> >> +       .codecs = {"RTL5682"}
> >> +};
> >> +
> >>  struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
> >>         {
> >>                 .id = "10EC5682",
> >> +               .id_alt = &adl_rt5682s_hp,
> >>                 .drv_name = "adl_mx98373_rt5682",
> >>                 .machine_quirk = snd_soc_acpi_codec_list,
> >>                 .quirk_data = &adl_max98373_amp,
> >> @@ -296,6 +302,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
> >>         },
> >>         {
> >>                 .id = "10EC5682",
> >> +               .id_alt = &adl_rt5682s_hp,
> >>                 .drv_name = "adl_mx98357_rt5682",
> >>                 .machine_quirk = snd_soc_acpi_codec_list,
> >>                 .quirk_data = &adl_max98357a_amp,
> >> @@ -304,6 +311,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
> >>         },
> >>         {
> >>                 .id = "10EC5682",
> >> +               .id_alt = &adl_rt5682s_hp,
> >>                 .drv_name = "adl_mx98360_rt5682",
> >>                 .machine_quirk = snd_soc_acpi_codec_list,
> >>                 .quirk_data = &adl_max98360a_amp,
> >
> > Is there any way we can collapse this and the primary id into a single
> > list to avoid having 2 locations to track for the IDs?
>
> I was thinking about that too, but in that case we would want to have a
> list of strings, rather than the address of a structure which adds one
> layer of indirection.
>
> Something like
>
> .id = { "10EC5682", "RTL5682" }
>
> and the .num_codecs removed and some termination added.
>

I don't see an issue with still using a struct since we are using the
same list across multiple machines, but this makes me wonder if maybe
we should refactor this into another layer, having the ids at a top
structure and then the speaker matches a layer down. E.g.

 struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
        {
                .drv_name = "adl_mx98373_rt5682",
                .machine_quirk = snd_soc_acpi_codec_list,
                .quirk_data = &adl_max98373_amp,
        },
        {
                .drv_name = "adl_mx98357_rt5682",
                .machine_quirk = snd_soc_acpi_codec_list,
                .quirk_data = &adl_max98357a_amp,
        },
        {
                .drv_name = "adl_mx98360_rt5682",
                .machine_quirk = snd_soc_acpi_codec_list,
                .quirk_data = &adl_max98360a_amp,
        }
}

struct machine_driver adl_rt5682_driver_match {
  .id = { "10EC5682", "RTL5682" }
  .instances = &adl_rt5682_machines
}
