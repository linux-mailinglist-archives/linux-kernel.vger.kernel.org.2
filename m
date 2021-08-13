Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B806D3EB11D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbhHMHK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:10:57 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:44741 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239237AbhHMHKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:10:55 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 17D7A4Z5030786
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 16:10:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 17D7A4Z5030786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1628838605;
        bh=3RQVqX9hojCXwYi8JdzHZc+gfqYrslawCNt+i18wKDk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HGlsEVh2aoPiKKHE7WqzzNoUZdEovhDgVKGDGpmxcm4eaRzonNMRKplsUdI3/DRPK
         LVPxGMz633jaumQYLGkwIOpWh8eIvWe2MwnFpWwRfA0OtnNROsStczV2d6DdgNwKm8
         YBxTEAZnpoh5VB/cYbnQtEtDBL78SgsIff1st55hW/rTRTmOoU1E2N3W8pve38GJX3
         sDo+a8qiRWF8kpeCU1ZeIOXHNzsJWhXElP2864d5kL2KTeYL92e63g5S+oHHfk0h+R
         ZHQ14/4523vGP0pZS9/BH0lMMEbItV23FU+GXFaBYmyh0WifK2cE4u3JmM8xrrnbVY
         pdbvC8aeeOsRw==
X-Nifty-SrcIP: [209.85.214.179]
Received: by mail-pl1-f179.google.com with SMTP id n12so10027483plf.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:10:05 -0700 (PDT)
X-Gm-Message-State: AOAM5334u65p/M7q6H/UUtdOKC4Tmn6A7aCz9ftZggH8zjEmy2kggyzx
        msxZ0P4XNEH3ru8KATYwrINe2eRDW2bisZGdWLk=
X-Google-Smtp-Source: ABdhPJxktsfYp0wvs+V6KmSLjhSOLo/nXiRC2OiR/JqCYLI8wXP4KaPyUR1ASSegdiuPJUHwBelXOHYmtVrgbRyz6Ak=
X-Received: by 2002:a17:902:bc41:b029:12d:3f9b:401e with SMTP id
 t1-20020a170902bc41b029012d3f9b401emr1034227plz.47.1628838604564; Fri, 13 Aug
 2021 00:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210811163731.186125-1-masahiroy@kernel.org> <20210811163731.186125-4-masahiroy@kernel.org>
 <CAMo8BfJtpUY-FC-cwU5HXSqOSwUwn15kTYWOhx-tsgybPe8mpw@mail.gmail.com>
In-Reply-To: <CAMo8BfJtpUY-FC-cwU5HXSqOSwUwn15kTYWOhx-tsgybPe8mpw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 13 Aug 2021 16:09:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNATERCrQc1gDfJTqGNvFPpS3Xyzk9VErQyaj0kvc10oDeA@mail.gmail.com>
Message-ID: <CAK7LNATERCrQc1gDfJTqGNvFPpS3Xyzk9VErQyaj0kvc10oDeA@mail.gmail.com>
Subject: Re: [PATCH 4/4] xtensa: move core-y in arch/xtensa/Makefile to arch/xtensa/Kbuild
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 2:32 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Wed, Aug 11, 2021 at 9:38 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Use obj-y to clean up Makefile.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  arch/xtensa/Kbuild             | 1 +
> >  arch/xtensa/Makefile           | 3 ---
> >  arch/xtensa/platforms/Makefile | 4 ++++
> >  3 files changed, 5 insertions(+), 3 deletions(-)
> >  create mode 100644 arch/xtensa/platforms/Makefile
> >
> > diff --git a/arch/xtensa/Kbuild b/arch/xtensa/Kbuild
> > index a4e40e534e6a..fd12f61745ba 100644
> > --- a/arch/xtensa/Kbuild
> > +++ b/arch/xtensa/Kbuild
> > @@ -1 +1,2 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > +obj-y += kernel/ mm/ platforms/ boot/dts/
> > diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
> > index 093e87b889be..96714ef7c89e 100644
> > --- a/arch/xtensa/Makefile
> > +++ b/arch/xtensa/Makefile
> > @@ -58,9 +58,6 @@ KBUILD_DEFCONFIG := iss_defconfig
> >  LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
> >
> >  head-y         := arch/xtensa/kernel/head.o
> > -core-y         += arch/xtensa/kernel/ arch/xtensa/mm/
> > -core-y         += arch/xtensa/platforms/$(platform-y)/
> > -core-y                 += arch/xtensa/boot/dts/
> >
> >  libs-y         += arch/xtensa/lib/ $(LIBGCC)
> >
> > diff --git a/arch/xtensa/platforms/Makefile b/arch/xtensa/platforms/Makefile
> > new file mode 100644
> > index 000000000000..e2e7e0726979
> > --- /dev/null
> > +++ b/arch/xtensa/platforms/Makefile
> > @@ -0,0 +1,4 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +obj-$(CONFIG_XTENSA_PLATFORM_XT2000)   += xt2000/
> > +obj-$(CONFIG_XTENSA_PLATFORM_ISS)      += iss/
> > +obj-$(CONFIG_XTENSA_PLATFORM_XTFPGA)   += xtfpga/
>
> With this change platform directory names are duplicated in two
> makefiles. Can we move them to Kconfig with something like the
> following (on top of this change)?



I do not like the idea much for the following reasons.



 - The string value in Kconfig is enclosed by double-quotes.

   In the .config file,

      CONFIG_XTENSA_PLATFORM="iss"


   So, you are doing

        obj-y  += "iss"/

   instead of

        obj-y  += iss/


   Still, it seems working because the shell will eventually
   get rid of double quotes, but that is not correct
   from the Kbuild perspective.

   You need to write like this:

       obj-y += $(patsubst "%",%,$(CONFIG_XTENSA_PLATFORM))


- 'make clean' does not include any CONFIG option.

   So,

   obj-y += $(CONFIG_XTENSA_PLATFORM)/

      will expand into:

   obj-y += /


   Luckily, Kbuild will ignore it.
   Kbuild will not try to clean the root directory, but this code
      scares me.

 - Kbuild cannot know the sub-directories of arch/xtensa/platforms/.
   So, you need to list the subdirectories anyway so 'make clean'
   can visit all the sub-directories.

   arch/xtensa/platforms/Makefile

      # for 'make clean'
      obj-  += iss/ xt2000/ xtfpga/






> ---8<---
> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> index b843902ad9fd..fe5ae5ec71c9 100644
> --- a/arch/xtensa/Kconfig
> +++ b/arch/xtensa/Kconfig
> @@ -314,6 +314,12 @@ config PLATFORM_HAVE_XIP
>
> menu "Platform options"
>
> +config XTENSA_PLATFORM
> +       string
> +       default iss if XTENSA_PLATFORM_ISS
> +       default xt2000 if XTENSA_PLATFORM_XT2000
> +       default xtfpga if XTENSA_PLATFORM_XTFPGA
> +
> choice
>        prompt "Xtensa System Type"
>        default XTENSA_PLATFORM_ISS
> diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
> index 96714ef7c89e..6b104ecdd19e 100644
> --- a/arch/xtensa/Makefile
> +++ b/arch/xtensa/Makefile
> @@ -26,12 +26,6 @@ ifneq ($(VARIANT),)
>   endif
> endif
>
> -# Platform configuration
> -
> -platform-$(CONFIG_XTENSA_PLATFORM_XT2000)      := xt2000
> -platform-$(CONFIG_XTENSA_PLATFORM_ISS)         := iss
> -platform-$(CONFIG_XTENSA_PLATFORM_XTFPGA)      := xtfpga
> -
> # temporarily until string.h is fixed
> KBUILD_CFLAGS += -ffreestanding -D__linux__
> KBUILD_CFLAGS += -pipe -mlongcalls -mtext-section-literals
> @@ -47,7 +41,7 @@ endif
> CHECKFLAGS += -D$(if $(CONFIG_CPU_BIG_ENDIAN),__XTENSA_EB__,__XTENSA_EL__)
>
> vardirs := $(patsubst %,arch/xtensa/variants/%/,$(variant-y))
> -plfdirs := $(patsubst %,arch/xtensa/platforms/%/,$(platform-y))
> +plfdirs := $(patsubst %,arch/xtensa/platforms/%/,$(CONFIG_XTENSA_PLATFORM))
>
> KBUILD_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(vardirs) $(plfdirs))
>
> diff --git a/arch/xtensa/platforms/Makefile b/arch/xtensa/platforms/Makefile
> index e2e7e0726979..08d0e9053db6 100644
> --- a/arch/xtensa/platforms/Makefile
> +++ b/arch/xtensa/platforms/Makefile
> @@ -1,4 +1,2 @@
> # SPDX-License-Identifier: GPL-2.0-only
> -obj-$(CONFIG_XTENSA_PLATFORM_XT2000)   += xt2000/
> -obj-$(CONFIG_XTENSA_PLATFORM_ISS)      += iss/
> -obj-$(CONFIG_XTENSA_PLATFORM_XTFPGA)   += xtfpga/
> +obj-y += $(CONFIG_XTENSA_PLATFORM)/
>
> ---8<---
>
> --
> Thanks.
> -- Max



-- 
Best Regards
Masahiro Yamada
