Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D540C424622
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 20:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhJFSg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 14:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhJFSg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 14:36:57 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42F0C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 11:35:04 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id x12so3506135qkf.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 11:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pEruuwb7cFwr8Ofs6shqqJVVofNEKWYdi6q9NkQEo5U=;
        b=V0jNzxJMeyddmMFs1uAHg88DuwmoRlW6I1WULYxGh5c4yht9k8VM5GWrRah9BKjsJ8
         eF+yfgWFZZ3zV9wSH2fOqwmZ5ti4skmxpJJ8U18MAx6+18/sVEfZKu5tyM2hyACUJ3h1
         Kgp1GwTX5s7IOTaaBKFKmk3dcC2kQtnV7gWT3N1Qo8f3+2Z0Ky5KU5YgItZb5bvDzV48
         ehn0TiDRTGVn23f7lg9QktVnm7MbpLqX8CiZvcIkW9yazLT6x5Tn3D4otRgBJJAR94O2
         v3SgtlnmBDnhbWZi3oFoyjSpUcQJ2g7rovgKEQidM0wrf80ASJtjoe9f/KejepSxbxrE
         0QNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pEruuwb7cFwr8Ofs6shqqJVVofNEKWYdi6q9NkQEo5U=;
        b=pVhHaEYxadQ6Es/f8BTbB3stXiNFwNqtC6ZvpuVvNWJ2erC26QlMs/IYK478R7T836
         +iqu+l3rsltopAD6723eP0s12yNepYOt4yEVgpZZw+M9Z9k7h+oOlIdHdfH/FmdjmbnA
         Au1AXym7nb9tEcc8atiUckVcJTtIXt33S/F+V7pPnsk5TYlZz/QeKFDXl9nSkz1L0Ly9
         JkVlthhKyRwrfXy88gxCDYRJMLZgYUNlvcFdTt078gi4AilvTDBu+RZJRuW11JmlQrGh
         rPdk7rBwWWTMDS2/FU1dzXYb/5EW/EhyifQPGbYmoy5hDPzCYlj02QDggpTkFGbK0O1j
         ZXVw==
X-Gm-Message-State: AOAM531CU9omHVPBf4fHQRU45JbyXtVbcO8eFhGzvj25hJxXouOy62q1
        xRSV0r5Ydoji0Q5t3xRZX9nv7n+/YmO6+VbwyTniYw==
X-Google-Smtp-Source: ABdhPJy3jjCRVqXoNRtJJpwgI9yhI0CVPdM/QofbR3SvmvtTbaf6ap4RgHTiernJVUxL284FMGOVtXzT9EWW+OHkdSs=
X-Received: by 2002:a37:b142:: with SMTP id a63mr209095qkf.393.1633545302972;
 Wed, 06 Oct 2021 11:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211006161805.938950-1-brent.lu@intel.com> <20211006161805.938950-4-brent.lu@intel.com>
In-Reply-To: <20211006161805.938950-4-brent.lu@intel.com>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Wed, 6 Oct 2021 11:34:52 -0700
Message-ID: <CAOReqxjGX6fwqNjX0i31JiQJ+vRCMNTTFBhn7L=iPzYvVMk9mQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ASoC: Intel: sof_rt5682: use id_alt to enumerate rt5682s
To:     Brent Lu <brent.lu@intel.com>
Cc:     ALSA development <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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

>  };
>
> +static struct snd_soc_acpi_codecs adl_rt5682s_hp = {
> +       .num_codecs = 1,
> +       .codecs = {"RTL5682"}
> +};
> +
>  struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
>         {
>                 .id = "10EC5682",
> +               .id_alt = &adl_rt5682s_hp,
>                 .drv_name = "adl_mx98373_rt5682",
>                 .machine_quirk = snd_soc_acpi_codec_list,
>                 .quirk_data = &adl_max98373_amp,
> @@ -296,6 +302,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
>         },
>         {
>                 .id = "10EC5682",
> +               .id_alt = &adl_rt5682s_hp,
>                 .drv_name = "adl_mx98357_rt5682",
>                 .machine_quirk = snd_soc_acpi_codec_list,
>                 .quirk_data = &adl_max98357a_amp,
> @@ -304,6 +311,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
>         },
>         {
>                 .id = "10EC5682",
> +               .id_alt = &adl_rt5682s_hp,
>                 .drv_name = "adl_mx98360_rt5682",
>                 .machine_quirk = snd_soc_acpi_codec_list,
>                 .quirk_data = &adl_max98360a_amp,

Is there any way we can collapse this and the primary id into a single
list to avoid having 2 locations to track for the IDs?
