Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D593C32BDBE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573838AbhCCQ3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:29:47 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:46384 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352585AbhCCLzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:55:03 -0500
Received: by mail-ot1-f46.google.com with SMTP id u3so5059601otg.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 03:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ydOaHK4WbXFZR/Zhm4NkRAdn9Nr1Up0uaDVYzRfkDGE=;
        b=SAnAD/P5gACNIiBkZxCoafEyj0xOBiiIyi3snp+E03thNMK3YLPHF8vh7X6R7ANYTJ
         WuDN9qI1cFBDtzh3pCeg5PMNc1o7u5nI9pRifHAmj7YxyOa56EQXFVCKnv7pva7BrGQM
         EcRnY1tzJhyPjwAIUSDoKmMobTj6+nflCB40dyRVZ6/HYsxUHs4MSkhtQX9VzbdGoMe4
         MYmklLZ+3VyS40rC0ZubgcfvE0zHdeoGJBlTcbtNzktqxko42PBvdXWk+lknCYGauyBm
         nW/6BGNDswB5e6O5ADEgmfpyMdb9ibit7XbSF+QBZfHLIGHiFc6C0MXcypaAS1PaGyHG
         yiyA==
X-Gm-Message-State: AOAM530BZeMAQ5lVEmd7+CvTrrez0wDIvfVv5AezniNcQpH2uLAt6+bt
        dcdKVz2ePFZNk9FLppQKyeN6FK+tjeotJU2v2+B+L5CH0zA=
X-Google-Smtp-Source: ABdhPJzaBHZHREi7ROkq8YvrZ+Ssc2Ml84xVjWNSIn/gKs58tawMwSkFs87Ta0tB/Zd2sjc7iTk3HqGuYlzDdbvWUFk=
X-Received: by 2002:ab0:66c3:: with SMTP id d3mr14344471uaq.2.1614768301840;
 Wed, 03 Mar 2021 02:45:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611904394.git.viresh.kumar@linaro.org> <434ba2467dd0cd011565625aeb3450650afe0aae.1611904394.git.viresh.kumar@linaro.org>
 <CAMuHMdVp0vGMqoEoP9A7Y7-ph-DYUWdddtChdq_eZcROYTBMHg@mail.gmail.com>
 <20210205092507.fdxotdjlq5rjs2yh@vireshk-i7> <CAMuHMdWUMcMcJxnC+oML8P0+r72_+d6RWGY50dOWCUECdJGWPA@mail.gmail.com>
 <20210205095545.woevnkxg3ar7ctys@vireshk-i7> <CAMuHMdXKT3LD3ojMJEg-oHsEKO5TN5P1BTJMyf2fYkhnC8PU=Q@mail.gmail.com>
 <20210205210814.GA3707622@robh.at.kernel.org> <02728dac-5666-9c2b-bd46-9c2eabbb2ed8@gmail.com>
 <20210303052125.uh32ndnu5d6mem7c@vireshk-i7>
In-Reply-To: <20210303052125.uh32ndnu5d6mem7c@vireshk-i7>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 Mar 2021 11:44:50 +0100
Message-ID: <CAMuHMdVJYNf+QQNPSmBvt3njEECY1SJHA9jLAESrTnVuD0cfWA@mail.gmail.com>
Subject: Re: [PATCH V7 4/6] kbuild: Add support to build overlays (%.dtbo)
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anmar Oueja <anmar.oueja@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On Wed, Mar 3, 2021 at 6:21 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 24-02-21, 19:32, Frank Rowand wrote:
> > I overlooked this and mistakenly thought that the move to .dtbo also
> > involved changing to .dtso.  My bad.
> >
> > My favorite color here is to use .dtso for the source file that will
> > be compiled to create a .dtbo.
> >
> > Linus has already accepted patch 4/6 to 5.12-rc1, so changing to .dtso
> > will require another patch.
>
> Looks like this is what many people desire, lets do it and make it a
> standard even if it wasn't followed earlier.
>
> What about this ?

Thanks, looks good to me, and works for me, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -337,7 +337,7 @@ $(obj)/%.dtb.S: $(obj)/%.dtb FORCE
>
>  quiet_cmd_dtc = DTC     $@
>  cmd_dtc = $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
> -       $(DTC) -O $(patsubst .%,%,$(suffix $@)) -o $@ -b 0 \
> +       $(DTC) -I dts -O $(patsubst .%,%,$(suffix $@)) -o $@ -b 0 \
>                 $(addprefix -i,$(dir $<) $(DTC_INCLUDE)) $(DTC_FLAGS) \
>                 -d $(depfile).dtc.tmp $(dtc-tmp) ; \
>         cat $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
> @@ -348,6 +348,9 @@ $(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
>  $(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
>         $(call if_changed_dep,dtc)
>
> +$(obj)/%.dtbo: $(src)/%.dtso $(DTC) FORCE
> +       $(call if_changed_dep,dtc)
> +
>  overlay-y := $(addprefix $(obj)/, $(overlay-y))
>
>  quiet_cmd_fdtoverlay = DTOVL   $@
> @@ -373,6 +376,9 @@ endef
>  $(obj)/%.dt.yaml: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
>         $(call if_changed_rule,dtc,yaml)
>
> +$(obj)/%.dt.yaml: $(src)/%.dtso $(DTC) $(DT_TMP_SCHEMA) FORCE

I'm wondering if "dt.yaml" should be changed to "dto.yaml" (here and in
the existing rule earlier in Makefile.lib), to avoid issues if both foo.dts and
foo.dtso exist? Unlikely, but it might happen...

> I had to keep the original line as is:
>
>  $(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
>
> to support the unittest stuff as there are no dtso files there. There
> are few things we can do here:
>
> - Don't follow the dtso/dtbo convention for unittest, build files as
>   dtb only and everything will continue to work I suppose as
>   fdtoverlay won't complain.
>
> - Keep the above line in Makefile, this doesn't sound right, isn't it
>   ?
>
> - Make .dts links for unittest file, maybe from the Makefile itself.
>
> - Something else ?

Rename unittest .dts files to .dtso where applicable?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
