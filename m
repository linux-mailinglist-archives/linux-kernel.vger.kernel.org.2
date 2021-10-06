Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FBC424334
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhJFQqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbhJFQqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:46:44 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3951C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 09:44:51 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id f4so7083587edr.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 09:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FFQMXs1FWPKk+z75/Ibi8RBzSAlftzRuPEJSYjyeDu4=;
        b=FDOKYzBHp2YLiUnq0WZzabgTe9i5xIyf6ubwzBz+kgq6TEeU/qqgr7WWwWkUWQ3X81
         evQweXnGrt7ioSV+PwoHEZSn1abm7RRYY6w/vTOIbpXtYQljeG3A9IQ7dAhWF4eIjoi8
         q4wL8D8uxzXG6yttYcpJRL4/N3DLaPrSjqHrNZi76LEYbwNt59gYKJtfJvtDKLgmT0eC
         HDrPuCW29bg6bz9ZjZje5rBor7i3iuvfMcHMaNWzBOCaDEPKqa2xLzlfokayRt+/e8Oy
         c7pPNY8MKrMZKNwHGYpog3vygs3H1YV2J8+INV4sksZVVM4Uw2CVf1CO4Su5Abv+P3BL
         dGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFQMXs1FWPKk+z75/Ibi8RBzSAlftzRuPEJSYjyeDu4=;
        b=t2tejIFwZmJWjWJ5Tdozo9TtNEeg7CR//ywkKENdtFnAuAyPEfydicMPPORN5LUI1Z
         t3p5L2JoXdVkHwy7fkQIyviBSZD7zG137faLHmb3rfeP3e5DLoJT8sxyPGiKqjXL3lGU
         4mxmMlNwzd8hGfxsIfZ2wqQWdj0mFxPORufKw/iTJPnQEJgjuWe5dhjI6tF74kz9Tg/h
         N6Sut+Koa3h6Qc2OzftkrVusGpJh+O/UFre9X5ZhyrPfHjDCyJgX8996lkBfM3L0qXqf
         8C0EH9dAeHuJkoUxyNQczW4jBWSVXW49GKPEEsHgwMF4fhxAo+8Iy1HWhEo38l0U47zQ
         bRQg==
X-Gm-Message-State: AOAM531siUfnY2JRuzOa2sVxXZ2kfmPP8uDg16Kp0C1Bgr1dol6x8FFO
        iXC20g8x7rSuCbXhCZJIdNaYrOyeTCXkFBvsU2BpO3Pl1UUnVw==
X-Google-Smtp-Source: ABdhPJwD4HF5So+87RVcKvG1inKX9QQaCQjFQsCnXZmNoednB3t49TlMcWePXYfJvAkmQSFWY0ZPHz2JwQG3BQiPOfo=
X-Received: by 2002:a05:6402:143b:: with SMTP id c27mr36480125edx.224.1633538690336;
 Wed, 06 Oct 2021 09:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211006161805.938950-1-brent.lu@intel.com> <20211006161805.938950-2-brent.lu@intel.com>
In-Reply-To: <20211006161805.938950-2-brent.lu@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 6 Oct 2021 19:44:13 +0300
Message-ID: <CAHp75Vf5xtqpJV6LZZDLwz0LRQVShyPrfsj9kSDrgh_0k_qMcA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ASoC: soc-acpi: add alternative id field for machine
 driver matching
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

On Wed, Oct 6, 2021 at 7:21 PM Brent Lu <brent.lu@intel.com> wrote:
>
> Current design to support second headphone driver in the same machine
> driver is to duplicate the entries in snd_soc_acpi_mach array and
> board configs in machine driver. We can avoid this by adding an id_alt
> field in snd_soc_acpi_mach structure to specify alternative ACPI HIDs
> for machine driver enumeration and leave the codec type detection to
> machine driver if necessary.

...

> +static bool snd_soc_acpi_id_present(struct snd_soc_acpi_mach *machine)
> +{
> +       struct snd_soc_acpi_codecs *id_alt = machine->id_alt;
> +       int i;
> +
> +       if (acpi_dev_present(machine->id, NULL, -1))
> +               return true;
> +
> +       if (id_alt == NULL)
> +               return false;
> +
> +       for (i = 0; i < id_alt->num_codecs; i++) {
> +               if (acpi_dev_present(id_alt->codecs[i], NULL, -1))
> +                       return true;
> +       }
> +
> +       return false;
> +}

Wondering if you may modify data structure in a way that makes it
possible to use for_each_acpi_dev_match().

...

> +               if (snd_soc_acpi_id_present(mach) != false) {

' != fase' is redundant.



-- 
With Best Regards,
Andy Shevchenko
