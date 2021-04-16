Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FAB3619CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 08:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbhDPGT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 02:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbhDPGT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 02:19:56 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023D4C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 23:19:29 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p16so9457920plf.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 23:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=0ULK0xvK0AaFlmfdN+zJSVpnvXjW9mKLMCPfk6y9Zqk=;
        b=L2OY2xrZoPg+ieFLphuZXE6ah4Tib0x7joZuFxOKOvs9qtSslCdV+QMWs13wJwQ1FG
         Oji259pHpJ2SWk4UC73GJMvYuGN2d0C5fOXxia/Ip7UPm15DOCNwFS2Ju8Wph7l1Ay2c
         UI8P80yqJr9tq5DwToPtYo3557gcpbOAuRMQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=0ULK0xvK0AaFlmfdN+zJSVpnvXjW9mKLMCPfk6y9Zqk=;
        b=mL9Ga0uCHtt88NRQ/QjwffLOCakkOdhjSuGw2zpRwKC2jC/ynUT5Ivsl+qsJ/iZzYC
         Nr2PF11v8PW3tckK/sCvw0KKB0A6vrOZQkpE25IQwQZEt1Od+Wwa4KtfPRG3zOGAfiJ/
         cRxVTLjMd2i5Aydmi6TRDf3dTlNm4B1pnEP9HkI9IPsNT0UxPZgnewjXb65q/1dKbAf1
         wMi1F+DvzQOQ11uweT/plUPqNUkrUpU9Lbb5JHZlMlmhqPXlm2R5fYSQzCP/AT+YimDE
         cicD7uceYcYVcGSvdYHtQwr0lIDJkY0RSVcKrLYEFIIueIGn3mtD/kH9VxDXcEYotKYS
         iyJQ==
X-Gm-Message-State: AOAM531QWNLnYBm+5vjZgcSuJ0NpVAvELt8bKBPLQMnRLdtSFAIbhkLi
        TveY5SeSovpiyrZP6Ob6zPdn2oqgnFEUCZ9i
X-Google-Smtp-Source: ABdhPJx5xwIuXgveR7HKXPlcXFYOIud0Fw77KSQASP6cWHg5E48ghJHxORI0F4LCfP4cdBQhfMU14Q==
X-Received: by 2002:a17:902:d2c9:b029:e9:67f7:9844 with SMTP id n9-20020a170902d2c9b02900e967f79844mr7778864plc.66.1618553969299;
        Thu, 15 Apr 2021 23:19:29 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-09c3-a49e-2955-78c6.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:9c3:a49e:2955:78c6])
        by smtp.gmail.com with ESMTPSA id l3sm4151589pju.44.2021.04.15.23.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 23:19:28 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     =?utf-8?B?6Z+p5aSn6bmPKEhhbiBEYXBlbmcp?= <handapeng@oppo.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86\@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Mike Rapoport <rppt@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arseny Solokha <asolokha@kb.kras.ru>,
        =?utf-8?B?6Z+p5aSn6bmPKEhhbiBEYXBlbmcp?= <handapeng@oppo.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Kees Cook <keescook@chromium.org>,
        Joerg Roedel <jroedel@suse.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390\@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kbuild\@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Cc:     =?utf-8?B?6ZmI5a6J5bqGKEFucWluZyk=?= <chenanqing@oppo.com>
Subject: Re: [PATCH] symbol : Make the size of the compile-related array fixed
In-Reply-To: <TY2PR02MB3709103991CF81E89C8F1E37CB4C9@TY2PR02MB3709.apcprd02.prod.outlook.com>
References: <TY2PR02MB3709103991CF81E89C8F1E37CB4C9@TY2PR02MB3709.apcprd02.prod.outlook.com>
Date:   Fri, 16 Apr 2021 16:19:24 +1000
Message-ID: <87h7k6g39v.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your contribution to the kernel!

I notice that your patch is sumbitted as an attachment. In future,
please could you submit your patch inline, rather than as an attachment?
See https://www.kernel.org/doc/html/v4.15/process/5.Posting.html
I'd recommend you use git send-email if possible: see e.g.
https://www.kernel.org/doc/html/v4.15/process/email-clients.html

> Subject: [PATCH] symbol : Make the size of the compile-related array fixed
>
> For the same code, the machine's user name, hostname, or compilation time
> may cause the kernel symbol address to be inconsistent, which is not
> friendly to some symbol-dependent software, such as Crash.

If I understand correctly, this patch makes it easier to recompile the
kernel from the same source but at a different time or on a different
machine or with a different user, but still get the same symbols.
Is that right?

I wonder if there are other reproducible build techniques that might be
simpler to apply? There is a kernel documentation page at
https://www.kernel.org/doc/html/latest/kbuild/reproducible-builds.html
which gives exisiting techniques to override the date, user and host.
Would they be sufficient to address your use case?

Kind regards,
Daniel

>
> Signed-off-by: Han Dapeng <handapeng@oppo.com>
> ---
>  arch/powerpc/mm/nohash/kaslr_booke.c | 2 +-
>  arch/s390/boot/version.c             | 2 +-
>  arch/x86/boot/compressed/kaslr.c     | 2 +-
>  arch/x86/boot/version.c              | 2 +-
>  init/version.c                       | 4 ++--
>  scripts/mkcompile_h                  | 2 ++
>  6 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/mm/nohash/kaslr_booke.c b/arch/powerpc/mm/nohash/kaslr_booke.c
> index 4c74e8a5482b..494ef408e60c 100644
> --- a/arch/powerpc/mm/nohash/kaslr_booke.c
> +++ b/arch/powerpc/mm/nohash/kaslr_booke.c
> @@ -37,7 +37,7 @@ struct regions {
>  };
>  
>  /* Simplified build-specific string for starting entropy. */
> -static const char build_str[] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"
> +static const char build_str[COMPILE_STR_MAX] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"
>  		LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION;
>  
>  struct regions __initdata regions;
> diff --git a/arch/s390/boot/version.c b/arch/s390/boot/version.c
> index d32e58bdda6a..627416a27d74 100644
> --- a/arch/s390/boot/version.c
> +++ b/arch/s390/boot/version.c
> @@ -3,5 +3,5 @@
>  #include <generated/compile.h>
>  #include "boot.h"
>  
> -const char kernel_version[] = UTS_RELEASE
> +const char kernel_version[COMPILE_STR_MAX] = UTS_RELEASE
>  	" (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ") " UTS_VERSION;
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index b92fffbe761f..7b72b518a4c8 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -43,7 +43,7 @@
>  extern unsigned long get_cmd_line_ptr(void);
>  
>  /* Simplified build-specific string for starting entropy. */
> -static const char build_str[] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"
> +static const char build_str[COMPILE_STR_MAX] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"
>  		LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION;
>  
>  static unsigned long rotate_xor(unsigned long hash, const void *area,
> diff --git a/arch/x86/boot/version.c b/arch/x86/boot/version.c
> index a1aaaf6c06a6..08feaa2d7a10 100644
> --- a/arch/x86/boot/version.c
> +++ b/arch/x86/boot/version.c
> @@ -14,6 +14,6 @@
>  #include <generated/utsrelease.h>
>  #include <generated/compile.h>
>  
> -const char kernel_version[] =
> +const char kernel_version[COMPILE_STR_MAX] =
>  	UTS_RELEASE " (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ") "
>  	UTS_VERSION;
> diff --git a/init/version.c b/init/version.c
> index 92afc782b043..adfc9e91b56b 100644
> --- a/init/version.c
> +++ b/init/version.c
> @@ -35,11 +35,11 @@ struct uts_namespace init_uts_ns = {
>  EXPORT_SYMBOL_GPL(init_uts_ns);
>  
>  /* FIXED STRINGS! Don't touch! */
> -const char linux_banner[] =
> +const char linux_banner[COMPILE_STR_MAX] =
>  	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
>  	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
>  
> -const char linux_proc_banner[] =
> +const char linux_proc_banner[COMPILE_STR_MAX] =
>  	"%s version %s"
>  	" (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ")"
>  	" (" LINUX_COMPILER ") %s\n";
> diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
> index 4ae735039daf..02b9d9d54da9 100755
> --- a/scripts/mkcompile_h
> +++ b/scripts/mkcompile_h
> @@ -65,6 +65,8 @@ UTS_VERSION="$(echo $UTS_VERSION $CONFIG_FLAGS $TIMESTAMP | cut -b -$UTS_LEN)"
>    LD_VERSION=$($LD -v | head -n1 | sed 's/(compatible with [^)]*)//' \
>  		      | sed 's/[[:space:]]*$//')
>    printf '#define LINUX_COMPILER "%s"\n' "$CC_VERSION, $LD_VERSION"
> +
> +  echo \#define COMPILE_STR_MAX 512
>  } > .tmpcompile
>  
>  # Only replace the real compile.h if the new one is different,
> -- 
> 2.27.0
