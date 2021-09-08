Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39D04034B0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347987AbhIHHCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:02:49 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35840
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346092AbhIHHCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:02:46 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8D94B3F335
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 07:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631084497;
        bh=7OsT0XPB+KLnwypcRQ26qkCgD4akJ8q/u9rPuGRcl6M=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Qw+NdwZRVNVRT5UI/DEvYtfCw2eqwT8ZkDg+2IWACaCthxWKo5tiupE9FHxyagDeL
         N4hKCXp4mfgcKYSqL/FEY/w1IvDVWa7HPcVzgfZslomB3Zv/BGIFuMjYmDSppYStWY
         QE9ztbs7eKY+8PXbK2XgfYMS/J4H/lZbNl0qk/NMY0OiLw/jQWkKUmQdKC4UZyxqxc
         CCVr3fVlAzu2jc2oNY/7uJbmYYqm/qLra+XRASMLMF3ZAgy3xCGTRKJJk+dt5iiHkp
         urtCo/U2yVtZLSfH8Fz2WRWry+VhszcxCaxyYC+TRtOGACdmmyl3lu7GObl7dherTJ
         HNSYPOl/KOn7w==
Received: by mail-wr1-f69.google.com with SMTP id p10-20020adfce0a000000b001572d05c970so201482wrn.21
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 00:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7OsT0XPB+KLnwypcRQ26qkCgD4akJ8q/u9rPuGRcl6M=;
        b=mVlFju2JSBIzWbJKhgUGBa5mwD3/4tRIbUY/vRdU/YCtKB/1nSaN5GnV28Hz+yIB25
         nXoLl2XdwYl4oFTtSBEgo0kyaG7Uze1baaMK4OcZ73cKABN/8RjqmJZ0J3/CXwufESz5
         BCJ1gRBZWva4Ty6VxMprJnPrBeOplNydKWkdxZCbMMuJjB51WIT8zPVtzmVBgYq6n2rU
         OtPV31ZuSxA506/PGbPv/NjAsXYA/AxGTrmWGAKulPGKpHgA5fohNZpNXptQBruMzIRJ
         ujLX7VaX+cjnaBXAivE3bjI/JXz1w4Ax8TR8VXS8SjGs9hFgA8rz51yZNNUduKnDGbWR
         x5Kw==
X-Gm-Message-State: AOAM533AzFOK56/pYEjBFk4VRElZPJvmSh9NbY4F+ceBBegchWd0zUMq
        ceTo+UrpbUQbZpntlDlrszqUE+mXZMlhBfolxkYEdUQOJBP1isXHyudD5C2DvwQIbc8Muiv9OMM
        74OJNv8ERWw11MfeQsiyYRNu+mWf2TUJLhFgSp9wqqw==
X-Received: by 2002:a05:6000:1010:: with SMTP id a16mr2165630wrx.70.1631084486184;
        Wed, 08 Sep 2021 00:01:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAmJ4+SOX1o+v7aucWstLZvxDjC7dz0hHMt68cmrHjjVhjdJdEeWBblBfkce0XG8SHHwAphg==
X-Received: by 2002:a05:6000:1010:: with SMTP id a16mr2165600wrx.70.1631084485973;
        Wed, 08 Sep 2021 00:01:25 -0700 (PDT)
Received: from [192.168.3.211] ([79.98.113.74])
        by smtp.gmail.com with ESMTPSA id o14sm1164596wrg.91.2021.09.08.00.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 00:01:25 -0700 (PDT)
Subject: Re: [PATCH 0/7] ARM: support THREAD_INFO_IN_TASK (v3)
To:     Keith Packard <keithpac@amazon.com>, linux-kernel@vger.kernel.org
Cc:     Abbott Liu <liuwenliang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jens Axboe <axboe@kernel.dk>, Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
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
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        YiFei Zhu <yifeifz2@illinois.edu>
References: <20210904060908.1310204-1-keithp@keithp.com>
 <20210907220038.91021-1-keithpac@amazon.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <2d5e3f95-77ce-cd26-9020-3c1a8a65e799@canonical.com>
Date:   Wed, 8 Sep 2021 09:01:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907220038.91021-1-keithpac@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2021 00:00, Keith Packard wrote:
> Placing thread_info in the kernel stack leaves it vulnerable to stack
> overflow attacks. This short series addresses that by using the
> existing THREAD_INFO_IN_TASK infrastructure.
> 
> This is the third version of this series, in this version the changes
> are restricted to hardware which provides the TPIDRPRW register. This
> register is repurposed from holding the per_cpu_offset value to
> holding the 'current' value as that allows fetching this value
> atomically so that it can be used in a preemptable context.
> 
> The series is broken into seven pieces:
> 
>  1) Change the secondary_start_kernel API to receive the cpu
>     number. This avoids needing to be able to find this value independently in
>     future patches.
> 
>  2) Change the secondary_start_kernel API to also receive the 'task'
>     value. Passing the value to this function also avoids needing to
>     be able to discover it independently.
> 
>  3) A cleanup which avoids assuming that THREAD_INFO_IN_TASK is not set.
> 
>  4) A hack, borrowed from the powerpc arch, which allows locating the 'cpu'
>     field in either thread_info or task_struct, without requiring linux/sched.h
>     to be included in asm/smp.h
> 
>  5) Disable the optimization storing per_cpu_offset in TPIDRPRW. This leaves
>     the register free to hold 'current' instead.
> 
>  6) Use TPIDRPRW for 'current'. This is enabled for either CPU_V6K or CPU_V7,
>     but not if CPU_V6 is also enabled.
> 
>  7) Enable THREAD_INFO_IN_TASK whenever TPIDRPRW is used to hold 'current'.

Hi,

Thanks for your patches. This seems to be a v3 but the patches are not
marked with it. Use "-v3" in format-patch to get it right.

The email here also lacks diffstat which is useful, for example to check
whether any maintainer's relevant files are touched here. You can get it
with "--cover-letter".

In total the command should look like:
    git format-patch --cover-letter -v3 -7 HEAD

Of course you can use any other tools to achieve the same result but as
of now - result is not the same.

Best regards,
Krzysztof
