Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B27404079
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 23:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350815AbhIHVSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 17:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhIHVSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 17:18:42 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAD9C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 14:17:33 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so4726664otq.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 14:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TPlAlW9m0l3/305TAZdOn8PajEjpurMWCxqwt3GbkS4=;
        b=k5Abv4lPU09XKV+T9DT6mwM4nvhzpbp8w1z70/OHtY75Ynul9pQ6hYn5bXFmBFeMrW
         O0+919A9pdjrK0y3dcJvzhZin3ZKvXoUiyDt23xQHj/SSnlPAAi9VRQzz8a1I4ubHeF0
         4nYBDLB8Lz6QbbDkoFiuCJHvyWUVUa3EzltHvqTW/L4+AUCf7EQWCKr68+2A7LB0C3ZB
         q4oXu0fljrYBN40kLy/hL1DYa7IAkakc0Yf4BDFQNlOFsl5vyYVrUyyUyf3OAkf0Gq/o
         aDrKuO+c9bQIEHnV0CzehyjBRrbMdQCVCf6U1wUNm2OTmqSD0tlRXzMVuymIfnAuoQV+
         izxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TPlAlW9m0l3/305TAZdOn8PajEjpurMWCxqwt3GbkS4=;
        b=cEMZdUstUlrJPRFqGjaAcplGE107cwP8SAC8nrZFK9CDIXwHwE3xxpfaR0UBEp4RQN
         gm4LtjGEqIdAulp+shl2SZCW3QO7mSXQJH6rIjQ9aKB8dAvCjEZX7Dzuv/IBto/8PLId
         /jDoFbXREG3k7VIAG8jE6VUGjm25HHD61454y86Jfj3wujB0wn6hJ30KO7Vwi5CEFw25
         R66Fsf2c6OpF8bG9GJeiG4toDdqRvq/en0AhvYbON8zNCx5SjcULtXRPP/eUGAJrqXP1
         ax2LPfLvg4MHSSV9xBUTXphHQM55iD3os22HSjWb8FIQAGySu9GMgEfk7Pfdcp9mbIIL
         eYWg==
X-Gm-Message-State: AOAM5330Wic2y+wSM95rsy1Z/cf/j5/Xs0ezQK13mXYNlf7h5RO7ngca
        U+v2QPE1oDoLFbg+xFZ2DG0=
X-Google-Smtp-Source: ABdhPJxkjqUmx0EXZUtOM51rkpogDdc1elqKgJf+LSadeuZxUOTgYN8HN8JPtJWeUSz2gihbxedmdg==
X-Received: by 2002:a9d:7f07:: with SMTP id j7mr181524otq.84.1631135853295;
        Wed, 08 Sep 2021 14:17:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j8sm39523ooc.21.2021.09.08.14.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 14:17:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain>
 <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
 <YTkjJPCdR1VGaaVm@archlinux-ax161>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <75a10e8b-9f11-64c4-460b-9f3ac09965e2@roeck-us.net>
Date:   Wed, 8 Sep 2021 14:16:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YTkjJPCdR1VGaaVm@archlinux-ax161>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/21 1:55 PM, Nathan Chancellor wrote:
> Hi Arnd,
> 
> On Tue, Sep 07, 2021 at 11:11:17AM +0200, Arnd Bergmann wrote:
>> On Tue, Sep 7, 2021 at 4:32 AM Nathan Chancellor <nathan@kernel.org> wrote:
>>>
>>> arm32-allmodconfig.log: crypto/wp512.c:782:13: error: stack frame size (1176) exceeds limit (1024) in function 'wp512_process_buffer' [-Werror,-Wframe-larger-than]
>>> arm32-allmodconfig.log: drivers/firmware/tegra/bpmp-debugfs.c:294:12: error: stack frame size (1256) exceeds limit (1024) in function 'bpmp_debug_show' [-Werror,-Wframe-larger-than]
>>> arm32-allmodconfig.log: drivers/firmware/tegra/bpmp-debugfs.c:357:16: error: stack frame size (1264) exceeds limit (1024) in function 'bpmp_debug_store' [-Werror,-Wframe-larger-than]
>>> arm32-allmodconfig.log: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3043:6: error: stack frame size (1384) exceeds limit (1024) in function 'bw_calcs' [-Werror,-Wframe-larger-than]
>>> arm32-allmodconfig.log: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:77:13: error: stack frame size (5560) exceeds limit (1024) in function 'calculate_bandwidth' [-Werror,-Wframe-larger-than]
>>> arm32-allmodconfig.log: drivers/mtd/chips/cfi_cmdset_0001.c:1872:12: error: stack frame size (1064) exceeds limit (1024) in function 'cfi_intelext_writev' [-Werror,-Wframe-larger-than]
>>> arm32-allmodconfig.log: drivers/ntb/hw/idt/ntb_hw_idt.c:1041:27: error: stack frame size (1032) exceeds limit (1024) in function 'idt_scan_mws' [-Werror,-Wframe-larger-than]
>>> arm32-allmodconfig.log: drivers/staging/fbtft/fbtft-core.c:902:12: error: stack frame size (1072) exceeds limit (1024) in function 'fbtft_init_display_from_property' [-Werror,-Wframe-larger-than]
>>> arm32-allmodconfig.log: drivers/staging/fbtft/fbtft-core.c:992:5: error: stack frame size (1064) exceeds limit (1024) in function 'fbtft_init_display' [-Werror,-Wframe-larger-than]
>>> arm32-allmodconfig.log: drivers/staging/rtl8723bs/core/rtw_security.c:1288:5: error: stack frame size (1040) exceeds limit (1024) in function 'rtw_aes_decrypt' [-Werror,-Wframe-larger-than]
>>> arm32-fedora.log: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3043:6: error: stack frame size (1376) exceeds limit (1024) in function 'bw_calcs' [-Werror,-Wframe-larger-than]
>>> arm32-fedora.log: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:77:13: error: stack frame size (5384) exceeds limit (1024) in function 'calculate_bandwidth' [-Werror,-Wframe-larger-than]
>>>
>>> Aside from the dce_calcs.c warnings, these do not seem too bad. I
>>> believe allmodconfig turns on UBSAN but it could also be aggressive
>>> inlining by clang. I intend to look at all -Wframe-large-than warnings
>>> closely later.
>>
>> I've had them close to zero in the past, but a couple of new ones came in.
>>
>> The amdgpu ones are probably not fixable unless they stop using 64-bit
>> floats in the kernel for
>> random calculations. The crypto/* ones tend to be compiler bugs, but hard to fix
> 
> I have started taking a look at these. Most of the allmodconfig ones
> appear to be related to CONFIG_KASAN, which is now supported for
> CONFIG_ARM.
> 

Would it make sense to make KASAN depend on !COMPILE_TEST ?
After all, the point of KASAN is runtime testing, not build testing.

Guenter
