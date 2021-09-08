Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1444035B1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351371AbhIHHuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:50:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351120AbhIHHs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:48:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8569F61166
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 07:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631087268;
        bh=g+KPm8DVe7Iqx7fs4fJUSuXyAmNC6ljwYldCl8uZcPY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J0ah/Gbc6BEStYii3MQu7/yiQ+zrxiYuTepLreOq5Sbmtp1p2kc5fGlT2ni2SJPg9
         LLEupvji7CZ95xmDVR2tkCxqDV4f4hOVvlcoTXWL5C798wqE3JurN6Q2Z4XGmGtY7X
         1sXay84RqOToCvPCw3rjpilYZyc0sIiOg0SRyGcTHEccFJXn2GkfJyo1HWkmSacRiz
         mEc+wnCDo8I7FZZApUkc7a2ZjXCtbFinHbPhxuPEAKFdRx1JlaAUKjFzpj8rxgEIcJ
         13gru/HpGhRf1NU6pWNs43WQVIjQa1SIwygAva87ggeu2Zkoe2WioiVHbIU5fpUeHi
         sR7VC3EKkxh3Q==
Received: by mail-oi1-f182.google.com with SMTP id q39so2002093oiw.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 00:47:48 -0700 (PDT)
X-Gm-Message-State: AOAM53085Rt2DWcnQVmGhVcCjKmefGKyJXTY4v8QGRiQUn7F9vsljGsv
        haf+fASJ//hfYDklFjQIQCQNIRaEVzNjKarNYsU=
X-Google-Smtp-Source: ABdhPJyS9VA1EqDPnto6QI61xcnEBBARNumEGt1UOSEs+dAjZ4s2lGUjjMxxKPshi0co05+lSMvEZgfDiEASfHERUHY=
X-Received: by 2002:a54:418e:: with SMTP id 14mr1463170oiy.174.1631087267929;
 Wed, 08 Sep 2021 00:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210904060908.1310204-1-keithp@keithp.com> <20210907220038.91021-1-keithpac@amazon.com>
 <2d5e3f95-77ce-cd26-9020-3c1a8a65e799@canonical.com>
In-Reply-To: <2d5e3f95-77ce-cd26-9020-3c1a8a65e799@canonical.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 8 Sep 2021 09:47:36 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF8X0j7Be_+3Z4uHcq0ZHKxsB5hW-7PEVb4dB54HFJgOg@mail.gmail.com>
Message-ID: <CAMj1kXF8X0j7Be_+3Z4uHcq0ZHKxsB5hW-7PEVb4dB54HFJgOg@mail.gmail.com>
Subject: Re: [PATCH 0/7] ARM: support THREAD_INFO_IN_TASK (v3)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Keith Packard <keithpac@amazon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abbott Liu <liuwenliang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jens Axboe <axboe@kernel.dk>, Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Russell King <linux@armlinux.org.uk>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        YiFei Zhu <yifeifz2@illinois.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sept 2021 at 09:01, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 08/09/2021 00:00, Keith Packard wrote:
> > Placing thread_info in the kernel stack leaves it vulnerable to stack
> > overflow attacks. This short series addresses that by using the
> > existing THREAD_INFO_IN_TASK infrastructure.
> >
> > This is the third version of this series, in this version the changes
> > are restricted to hardware which provides the TPIDRPRW register. This
> > register is repurposed from holding the per_cpu_offset value to
> > holding the 'current' value as that allows fetching this value
> > atomically so that it can be used in a preemptable context.
> >
> > The series is broken into seven pieces:
> >
> >  1) Change the secondary_start_kernel API to receive the cpu
> >     number. This avoids needing to be able to find this value independently in
> >     future patches.
> >
> >  2) Change the secondary_start_kernel API to also receive the 'task'
> >     value. Passing the value to this function also avoids needing to
> >     be able to discover it independently.
> >
> >  3) A cleanup which avoids assuming that THREAD_INFO_IN_TASK is not set.
> >
> >  4) A hack, borrowed from the powerpc arch, which allows locating the 'cpu'
> >     field in either thread_info or task_struct, without requiring linux/sched.h
> >     to be included in asm/smp.h
> >
> >  5) Disable the optimization storing per_cpu_offset in TPIDRPRW. This leaves
> >     the register free to hold 'current' instead.
> >
> >  6) Use TPIDRPRW for 'current'. This is enabled for either CPU_V6K or CPU_V7,
> >     but not if CPU_V6 is also enabled.
> >
> >  7) Enable THREAD_INFO_IN_TASK whenever TPIDRPRW is used to hold 'current'.
>
> Hi,
>
> Thanks for your patches. This seems to be a v3 but the patches are not
> marked with it. Use "-v3" in format-patch to get it right.
>
> The email here also lacks diffstat which is useful, for example to check
> whether any maintainer's relevant files are touched here. You can get it
> with "--cover-letter".
>
> In total the command should look like:
>     git format-patch --cover-letter -v3 -7 HEAD
>
> Of course you can use any other tools to achieve the same result but as
> of now - result is not the same.
>

Also, this ended up in my GMail spam folder, likely due to some
antispam ID header being set incorrectly?
