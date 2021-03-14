Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DBF33A444
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 11:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbhCNKtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 06:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbhCNKsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 06:48:54 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DBEC061762
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 03:48:53 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id 30so9358641ple.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 03:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=26KkwIgjg/uTfsjc8TtIq14TTjHPyD1v2KRrAGEx6No=;
        b=L0YG7sqgOD82dycT3zb43+3bV+4KcOUWGTYw3FD9lPQ7CwC30nHoczsu3LpOj1TiBu
         JRmcoezM/701NrahsQsRaqrsxuSFdrmL6Eiuk0Jqg65EHojUFsVKZymhArhYONrem+oZ
         h3vO/08P/Pxvq8PtFewkf6W6qlgUO5uOQnLFHIsCWl7KVWvm22qluaPEDOOBONK+9QWx
         Gt6Xz6fULIqu4q2F+f7tmmaerwEmAXMR/dxZXKwsdoyDgasK8RlHNTwt9yk7GV0Cebaz
         ExU74N7DH2P+La4UvXp+kPrpOVl+Nmf8AFdK7qWKZisN2ugsI8caQzaQi91K6dk2tT8F
         1VaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=26KkwIgjg/uTfsjc8TtIq14TTjHPyD1v2KRrAGEx6No=;
        b=ogWK65X82BSXSBs7TApgaixQL3N/F6CgZIBVkMlrm+HK2ygR77BRZopTnagTvX9Z4o
         bnqpHRP9oY03ztw2XKGvv9wCTrhGJi7Xq63bvYuT5/G1edRUXhTA9RLMeO1EBmEPsTnO
         4tQst22JqxX/tH1zhMUkF9GW6xq8CjPKOb7UFci1J2cvT21Ospe5fgjDM01JezFwpBYK
         QShZn4Hmg4rc7Snf0/s/JeoF9aQn16vf3DhjJpVJIdlrs2n88Nnu83qVbpsmYi//F6Sp
         dx7xXn5+/Zm/yIxVCKJDnCFqVITWgbdkre2ivhOyoNTeYKqawdOh8YC4+L8QzVDn75Ip
         wpcg==
X-Gm-Message-State: AOAM532iryhP/CNn+pFV6NToPxB4EeD0wPlolX103kV/EuDC4qdGfX1t
        HzkrWMS21/iQyb6zWPpixL7vCDiV31aJiue8H2U=
X-Google-Smtp-Source: ABdhPJwcOKC0tTgmO4LyBTenkqIATxChoULkVUiJEBgBseTebqQ9KZw1DqjyWO76dd6R1sdnM0dc3bg0FXk5EzMMC0Y=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr6915981plq.17.1615718932920; Sun, 14 Mar
 2021 03:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210314074434.164868-1-nick.desaulniers@gmail.com> <20210314080613.190663-1-nick.desaulniers@gmail.com>
In-Reply-To: <20210314080613.190663-1-nick.desaulniers@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 14 Mar 2021 12:48:36 +0200
Message-ID: <CAHp75Vdy083+5K=4sViwg8uNJ1_6agECYbjMSFEGXX9VTO85WQ@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: Intel: Skylake: skl-topology: fix -frame-larger-than
To:     Nick Desaulniers <nick.desaulniers@gmail.com>
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        amadeuszx.slawinski@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        guennadi.liakhovetski@linux.intel.com,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mateusz.gorski@linux.intel.com, Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 10:08 AM Nick Desaulniers
<nick.desaulniers@gmail.com> wrote:
>
> Fixes:
> sound/soc/intel/skylake/skl-topology.c:3613:13: warning: stack frame
> size of 1304 bytes in function 'skl_tplg_complete'
> [-Wframe-larger-than=]
>
> struct snd_ctl_elem_value is 1224 bytes in my configuration.
>
> Heap allocate it, then free it within the current frame.
>
> Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> ---
> Changes V1 -> V2: rebased on mainline.
>
>  sound/soc/intel/skylake/skl-topology.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
> index b824086203b9..566d07b4b523 100644
> --- a/sound/soc/intel/skylake/skl-topology.c
> +++ b/sound/soc/intel/skylake/skl-topology.c
> @@ -3613,10 +3613,15 @@ static int skl_manifest_load(struct snd_soc_component *cmpnt, int index,
>  static void skl_tplg_complete(struct snd_soc_component *component)
>  {
>         struct snd_soc_dobj *dobj;
> -       struct snd_soc_acpi_mach *mach =
> -               dev_get_platdata(component->card->dev);
> +       struct snd_soc_acpi_mach *mach;
> +       struct snd_ctl_elem_value *val;
>         int i;
>
> +       val = kzalloc(sizeof(*val), GFP_KERNEL);
> +       if (!val)
> +               return;
> +
> +       mach = dev_get_platdata(component->card->dev);
>         list_for_each_entry(dobj, &component->dobj_list, list) {
>                 struct snd_kcontrol *kcontrol = dobj->control.kcontrol;
>                 struct soc_enum *se;
> @@ -3632,14 +3637,13 @@ static void skl_tplg_complete(struct snd_soc_component *component)
>                 sprintf(chan_text, "c%d", mach->mach_params.dmic_num);
>
>                 for (i = 0; i < se->items; i++) {
> -                       struct snd_ctl_elem_value val = {};


Shouldn't you use rather kmalloc() + memset(). Otherwise I don't see
how possible this won't be garbage on the second iteration of the
outer loop.

> -
>                         if (strstr(texts[i], chan_text)) {
> -                               val.value.enumerated.item[0] = i;
> -                               kcontrol->put(kcontrol, &val);
> +                               val->value.enumerated.item[0] = i;
> +                               kcontrol->put(kcontrol, val);
>                         }
>                 }
>         }
> +       kfree(val);
>  }
>
>  static struct snd_soc_tplg_ops skl_tplg_ops  = {
>
> base-commit: 88fe49249c99de14e543c632a46248d85411ab9e
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
