Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18A73EAFAC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 07:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbhHMFc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 01:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhHMFc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 01:32:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41466C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 22:32:30 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id w5so16201665ejq.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 22:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SjY0/FqpdDSUzmYDD6o6NUxD8vYkaJFdfIaMbxp4reQ=;
        b=Pom5kFB+D2EtF1yj0MgO35Ntwe7FczYHcIaX7Xgf/ypWo0eEV5SmBEpNDebM3FXl/b
         gLznHtg0E7u58vlgLjBSExfjkqGfMl80GAVfdoWRmC+7iRQ3XFNRKvgH+zfwKlRYr0ug
         5U+4t6lR4VZRtPkjPHxN16aIeXuowoF7AIyKNYAltWh91UoDQxVP5bZtu3y+I5Bb/tV2
         SK9hN16AGRpOHjDuAC/r5Yp2PBCyn10zO2N+7KNC6ACm6CBCcyJfw+NjBxfkMeaNHz0z
         FhdYvqivjRJp3rUeJu1anTWoBajQUaH8ZXH0OWB9WYYKnv63CjXQIu3osh6c2K0+04le
         5arA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SjY0/FqpdDSUzmYDD6o6NUxD8vYkaJFdfIaMbxp4reQ=;
        b=KInn4FQexxHye36GYkB62QjVSsHpfmTfspuY7e5dJHsv2r1JJ0qdeykrKuhZyxfnT9
         YNke+q2K9rjpEmriIQgeWnUl3WqLS7uQeDYsZykT5IpNOLdPrVIEBiyve5RhzYmcppXa
         WClejsqAFV6UxxuKYySKI7DBIn4C3u5exK/abGpqb/cLNZgKEulhE/tXT0l65EwisVvB
         GL/JxFVMuggUA82+yO0OZb0mAb/BGEO9f6XZh9p0BupWGsGvg0/hxw2lwqH/YoSzVvf+
         Eg0vOAO3b/px33tmAjK/aGXomTnKcSQs7qxdvFWEYqnq2PNBKPvU2OIwZfAwEeL9rKLK
         8HtQ==
X-Gm-Message-State: AOAM5316nGT+A6JDBvb+Gv90bVn3Udvg9WjUTO4dSWegMAvRtpInxUaZ
        CVGC6hW0dWw2BBbgxRO70SVssEudqyo7OwmYHVo=
X-Google-Smtp-Source: ABdhPJz3LzQVh4SrAjmPOjHK2w9471Nj+pCHrjHILeGY4/+wJN/F/TjnuN9g8j+Qc0WpEYuEfUHZ5ilLgNjWOKixwso=
X-Received: by 2002:a17:906:4ad8:: with SMTP id u24mr809791ejt.186.1628832748914;
 Thu, 12 Aug 2021 22:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210811163731.186125-1-masahiroy@kernel.org> <20210811163731.186125-4-masahiroy@kernel.org>
In-Reply-To: <20210811163731.186125-4-masahiroy@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 12 Aug 2021 22:32:17 -0700
Message-ID: <CAMo8BfJtpUY-FC-cwU5HXSqOSwUwn15kTYWOhx-tsgybPe8mpw@mail.gmail.com>
Subject: Re: [PATCH 4/4] xtensa: move core-y in arch/xtensa/Makefile to arch/xtensa/Kbuild
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 9:38 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Use obj-y to clean up Makefile.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/xtensa/Kbuild             | 1 +
>  arch/xtensa/Makefile           | 3 ---
>  arch/xtensa/platforms/Makefile | 4 ++++
>  3 files changed, 5 insertions(+), 3 deletions(-)
>  create mode 100644 arch/xtensa/platforms/Makefile
>
> diff --git a/arch/xtensa/Kbuild b/arch/xtensa/Kbuild
> index a4e40e534e6a..fd12f61745ba 100644
> --- a/arch/xtensa/Kbuild
> +++ b/arch/xtensa/Kbuild
> @@ -1 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +obj-y += kernel/ mm/ platforms/ boot/dts/
> diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
> index 093e87b889be..96714ef7c89e 100644
> --- a/arch/xtensa/Makefile
> +++ b/arch/xtensa/Makefile
> @@ -58,9 +58,6 @@ KBUILD_DEFCONFIG := iss_defconfig
>  LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
>
>  head-y         := arch/xtensa/kernel/head.o
> -core-y         += arch/xtensa/kernel/ arch/xtensa/mm/
> -core-y         += arch/xtensa/platforms/$(platform-y)/
> -core-y                 += arch/xtensa/boot/dts/
>
>  libs-y         += arch/xtensa/lib/ $(LIBGCC)
>
> diff --git a/arch/xtensa/platforms/Makefile b/arch/xtensa/platforms/Makefile
> new file mode 100644
> index 000000000000..e2e7e0726979
> --- /dev/null
> +++ b/arch/xtensa/platforms/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_XTENSA_PLATFORM_XT2000)   += xt2000/
> +obj-$(CONFIG_XTENSA_PLATFORM_ISS)      += iss/
> +obj-$(CONFIG_XTENSA_PLATFORM_XTFPGA)   += xtfpga/

With this change platform directory names are duplicated in two
makefiles. Can we move them to Kconfig with something like the
following (on top of this change)?

---8<---
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index b843902ad9fd..fe5ae5ec71c9 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -314,6 +314,12 @@ config PLATFORM_HAVE_XIP

menu "Platform options"

+config XTENSA_PLATFORM
+       string
+       default iss if XTENSA_PLATFORM_ISS
+       default xt2000 if XTENSA_PLATFORM_XT2000
+       default xtfpga if XTENSA_PLATFORM_XTFPGA
+
choice
       prompt "Xtensa System Type"
       default XTENSA_PLATFORM_ISS
diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
index 96714ef7c89e..6b104ecdd19e 100644
--- a/arch/xtensa/Makefile
+++ b/arch/xtensa/Makefile
@@ -26,12 +26,6 @@ ifneq ($(VARIANT),)
  endif
endif

-# Platform configuration
-
-platform-$(CONFIG_XTENSA_PLATFORM_XT2000)      := xt2000
-platform-$(CONFIG_XTENSA_PLATFORM_ISS)         := iss
-platform-$(CONFIG_XTENSA_PLATFORM_XTFPGA)      := xtfpga
-
# temporarily until string.h is fixed
KBUILD_CFLAGS += -ffreestanding -D__linux__
KBUILD_CFLAGS += -pipe -mlongcalls -mtext-section-literals
@@ -47,7 +41,7 @@ endif
CHECKFLAGS += -D$(if $(CONFIG_CPU_BIG_ENDIAN),__XTENSA_EB__,__XTENSA_EL__)

vardirs := $(patsubst %,arch/xtensa/variants/%/,$(variant-y))
-plfdirs := $(patsubst %,arch/xtensa/platforms/%/,$(platform-y))
+plfdirs := $(patsubst %,arch/xtensa/platforms/%/,$(CONFIG_XTENSA_PLATFORM))

KBUILD_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(vardirs) $(plfdirs))

diff --git a/arch/xtensa/platforms/Makefile b/arch/xtensa/platforms/Makefile
index e2e7e0726979..08d0e9053db6 100644
--- a/arch/xtensa/platforms/Makefile
+++ b/arch/xtensa/platforms/Makefile
@@ -1,4 +1,2 @@
# SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_XTENSA_PLATFORM_XT2000)   += xt2000/
-obj-$(CONFIG_XTENSA_PLATFORM_ISS)      += iss/
-obj-$(CONFIG_XTENSA_PLATFORM_XTFPGA)   += xtfpga/
+obj-y += $(CONFIG_XTENSA_PLATFORM)/

---8<---

-- 
Thanks.
-- Max
