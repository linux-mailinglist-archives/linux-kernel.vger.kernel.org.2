Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C60424349
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhJFQtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239233AbhJFQtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:49:17 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8267C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 09:47:24 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id dj4so12232241edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 09:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cokz5/aCsU+6IISL087/xdQjeJJNdXltlIJFHh9WDIY=;
        b=p3qZXdpk4WQccufsvK4m6KyFOU8memXMUyYFo+6dgqN/7w5vd1mJOPqpQd5hVoAmJW
         mo3UEMujCeB28FTLtFjvOsRV3CwDnd84QaN9X+KYYIYzJC7HZHmwcdhrs0XVFyZ4I889
         RjDpF+2JfBMiVQcRDfhBkL9b8ephHuCo5Pt2BuCpF0qqNhEXJkn1tjE+wnyRuhAcFAAc
         cb8UinmC2gFZyS5PxVQnHqeK96xv00CP8qjrqswmeTd8Sxr/Qsszw1irQnGHhqXwCOOg
         uVvDcatwfhkeolZvGnzylYwqvBiU5iEIYMtxg+es717pKCmcniqQfzSLxAokJ+Sa+iDz
         gx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cokz5/aCsU+6IISL087/xdQjeJJNdXltlIJFHh9WDIY=;
        b=1AmK2/QvOhHNZJLNQt2BPZ0+4h/cE/Zsn3W46o7/ythJpPe4ticTTSRP8nc2MxZjj2
         YYTrXuqw0W6wIoZGooC0GeE2DZoRSF7KOzIctE2SOoYDJus9sQ8Xw6+4qiKU44AzoGpb
         7smPrxVAbIt8cDOMWcRuI1rRfKYfOU8OYsehTL0gd6sk75F6Ouvn/UFmvRUhWQC71t6f
         N0yycTc0pWZ600krTGMgGRUY0bcQCcu0DG/1YOy+I9nPREW/l5/gE/8BxAU3xLkIawuN
         HK3Y1dYLqojf3WIlbwopr1Ta32unqJw/lkmOpu8W/McqWEHlwcRXL5cI+s9diYfRasdc
         02hg==
X-Gm-Message-State: AOAM532+W0pLpbEZUrWmkxPqEHj/yvUOYybFcvGEi9elRMolVSxc1cq8
        HMxzm6zoFoIuZDkz3AjvH4EiLj+jijOfotRi4Kgn2X3bYgQ=
X-Google-Smtp-Source: ABdhPJw29j4D9bZHuEI9lrPKZesgz4NvAhcdBJSs1TuAV5KtEWAPPnDmALdoHcnOBJ5iVVZTlIoFdWNWh6/0/YAL2lo=
X-Received: by 2002:a17:906:2887:: with SMTP id o7mr32800370ejd.425.1633538843226;
 Wed, 06 Oct 2021 09:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211006161805.938950-1-brent.lu@intel.com> <20211006161805.938950-4-brent.lu@intel.com>
In-Reply-To: <20211006161805.938950-4-brent.lu@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 6 Oct 2021 19:46:47 +0300
Message-ID: <CAHp75Vd7A4yjA+BN_4PwCNNSyy=JbGTDh7U6FdacRYLYPJaYCQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ASoC: Intel: sof_rt5682: use id_alt to enumerate rt5682s
To:     Brent Lu <brent.lu@intel.com>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
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

On Wed, Oct 6, 2021 at 7:23 PM Brent Lu <brent.lu@intel.com> wrote:
>
> Use the id_alt field to enumerate rt5682s headphone codec and remove
> redundant entries in tables.

...

> +static struct snd_soc_acpi_codecs adl_rt5682s_hp = {
> +       .num_codecs = 1,
> +       .codecs = {"RTL5682"}

Keeping commas in non-terminator entries is always good to avoid churn
in the future.

> +};

...

> +static struct snd_soc_acpi_codecs rt5682s_hp = {
> +       .num_codecs = 1,
> +       .codecs = {"RTL5682"}

Ditto.

> +};

...

> +static struct snd_soc_acpi_codecs rt5682s_hp = {
> +       .num_codecs = 1,
> +       .codecs = {"RTL5682"}

Ditto.

> +};

...

> +static struct snd_soc_acpi_codecs rt5682s_hp = {
> +       .num_codecs = 1,
> +       .codecs = {"RTL5682"}

Ditto.

> +};

...

> +static struct snd_soc_acpi_codecs rt5682s_hp = {
> +       .num_codecs = 1,
> +       .codecs = {"RTL5682"}

Ditto.

> +};

...and so on.

-- 
With Best Regards,
Andy Shevchenko
