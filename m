Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D3937B4BB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 05:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhELDx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 23:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhELDxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 23:53:55 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807EDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 20:52:47 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 69so7232191plc.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 20:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kLri06/PsvUYTrFMMBEaqXVTzgJ4ixwFqo6hvHf1gdo=;
        b=zQYt8vmLxc4EUHyZ8moH+yj8OYC+z2rQ4gn0BRyl6DT/viyW0wO94EtxSIxCstUGRc
         0uW4PCPhfph4XjbqqSqoAVDf8Vcjh2R1TGQ1Guh/lXj8DxhEurVCghHhyGiJVvNaVcWs
         UFsaP+uLAm49vA76ZS9lqysDL6SHsTcjsLFC47ovXi+UER3hhmA77L+1gZ1HdZLtlu1i
         hqz0oKuTt4QkLCzM+DgYuBRPXi7/0BxxZ0gxvTLenMgR+YObBYayeR9nLA1S5pd2dhgy
         bCUVBpxGiOV1dCfn3RBRsvT1N5LC4GLSuW+WL/tYcyGcQpwTMHklY9N8HlYbxG0zZJn/
         m9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kLri06/PsvUYTrFMMBEaqXVTzgJ4ixwFqo6hvHf1gdo=;
        b=fPv7zyHogcgM8xs564D+ffuiYIH7bUgsFCrxpr2MpQU/9qThrbNF1NvGIX6/FDKAN9
         tVWyR1nGvCh1/vqm7tpO5U5naXA++1XC4NV7D21s/xqv/UccWTjYRlYKyzs4zlOp1U6f
         JvxBglLlcw4+D0SN4no2Zqb7cB92Wx+1ZKYZcAvlKrznOhoY9sXhlRA6/8TzZlfEt2gl
         njZoH4W5K8gNfAu79y7XV24etM5UOQqDYAxiH7z1fukhpIqf6jJxoM8ncAeH/WCQaBPb
         8nzDvlmn+dT7LLqiSp1RdOk1TkhR3doI/k8j4WkEIfexsbk0G/dyRr+MqPUcm1WjvLNZ
         uNbw==
X-Gm-Message-State: AOAM530ZTVZM8A+BBaYS/RbwwpAAfZwjnVZ5XyOZ210lR3YRWkKhiY3x
        8pFJC3Pd8aSREBfzLbFUIHU3Zw==
X-Google-Smtp-Source: ABdhPJy4L0Jl9SVrbA3JDGJ4wx7AHQyih5iN9xmtcgDnhJEIwn147LaXX8q4AYVUzwhJgfoHUu+NyQ==
X-Received: by 2002:a17:902:e00e:b029:ef:5f1c:18a8 with SMTP id o14-20020a170902e00eb02900ef5f1c18a8mr6440716plo.38.1620791567073;
        Tue, 11 May 2021 20:52:47 -0700 (PDT)
Received: from localhost (110-175-254-242.static.tpgi.com.au. [110.175.254.242])
        by smtp.gmail.com with UTF8SMTPSA id d8sm13938636pfl.156.2021.05.11.20.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 20:52:46 -0700 (PDT)
Message-ID: <1024e788-f5f0-9990-a049-94133d3a0921@ozlabs.ru>
Date:   Wed, 12 May 2021 13:52:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:88.0) Gecko/20100101
 Thunderbird/88.0
Subject: Re: [PATCH kernel v2] powerpc/makefile: Do not redefine $(CPP) for
 preprocessor
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210511044812.267965-1-aik@ozlabs.ru>
 <3579aa0d-0470-9a6b-e35b-48f997a5b48b@kernel.org>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <3579aa0d-0470-9a6b-e35b-48f997a5b48b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/21 05:18, Nathan Chancellor wrote:
> On 5/10/2021 9:48 PM, Alexey Kardashevskiy wrote:
>> The $(CPP) (do only preprocessing) macro is already defined in Makefile.
>> However POWERPC redefines it and adds $(KBUILD_CFLAGS) which results
>> in flags duplication. Which is not a big deal by itself except for
>> the flags which depend on other flags and the compiler checks them
>> as it parses the command line.
>>
>> Specifically, scripts/Makefile.build:304 generates ksyms for .S files.
>> If clang+llvm+sanitizer are enabled, this results in
>>
>> -emit-llvm-bc -fno-lto -flto -fvisibility=hidden \
>>   -fsanitize=cfi-mfcall -fno-lto  ...
>>
>> in the clang command line and triggers error:
>>
>> clang-13: error: invalid argument '-fsanitize=cfi-mfcall' only allowed 
>> with '-flto'
>>
>> This removes unnecessary CPP redefinition. Which works fine as in most
>> place KBUILD_CFLAGS is passed to $CPP except
>> arch/powerpc/kernel/vdso64/vdso(32|64).lds (and probably some others,
>> not yet detected). To fix vdso, we do:
>> 1. explicitly add -m(big|little)-endian to $CPP
>> 2. (for clang) add $CLANG_FLAGS to $KBUILD_CPPFLAGS as otherwise clang
>> silently ignores -m(big|little)-endian if the building platform does not
>> support big endian (such as x86) so --prefix= is required.
>>
>> While at this, remove some duplication from CPPFLAGS_vdso(32|64)
>> as cmd_cpp_lds_S has them anyway. It still puzzles me why we need -C
>> (preserve comments in the preprocessor output) flag here.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> Changes:
>> v2:
>> * fix KBUILD_CPPFLAGS
>> * add CLANG_FLAGS to CPPFLAGS
>> ---
>>   Makefile                            | 1 +
>>   arch/powerpc/Makefile               | 3 ++-
>>   arch/powerpc/kernel/vdso32/Makefile | 2 +-
>>   arch/powerpc/kernel/vdso64/Makefile | 2 +-
>>   4 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 72af8e423f11..13acd2183d55 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -591,6 +591,7 @@ CLANG_FLAGS    += 
>> --prefix=$(GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE))
>>   endif
>>   CLANG_FLAGS    += -Werror=unknown-warning-option
>>   KBUILD_CFLAGS    += $(CLANG_FLAGS)
>> +KBUILD_CPPFLAGS    += $(CLANG_FLAGS)
> 
> This is going to cause flag duplication, which would be nice to avoid. I 
> do not know if we can get away with just adding $(CLANG_FLAGS) to 
> KBUILD_CPPFLAGS instead of KBUILD_CFLAGS though. It seems like this 
> assignment might be better in arch/powerpc/Makefile with the 
> KBUILD_CPPFLAGS additions there.


It is a fair point about the duplication (which is woooow, I often see 
-mbig-endian 3 - three - times) and I think I only need --prefix= there 
but this is still exactly the place to do such thing as it potentially 
affects all archs supporting both endianness (not many though, yeah). 
Thanks,




> 
> Cheers,
> Nathan
> 
>>   KBUILD_AFLAGS    += $(CLANG_FLAGS)
>>   export CLANG_FLAGS
>>   endif
>> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
>> index 3212d076ac6a..306bfd2797ad 100644
>> --- a/arch/powerpc/Makefile
>> +++ b/arch/powerpc/Makefile
>> @@ -76,6 +76,7 @@ endif
>>   ifdef CONFIG_CPU_LITTLE_ENDIAN
>>   KBUILD_CFLAGS    += -mlittle-endian
>> +KBUILD_CPPFLAGS    += -mlittle-endian
>>   KBUILD_LDFLAGS    += -EL
>>   LDEMULATION    := lppc
>>   GNUTARGET    := powerpcle
>> @@ -83,6 +84,7 @@ MULTIPLEWORD    := -mno-multiple
>>   KBUILD_CFLAGS_MODULE += $(call cc-option,-mno-save-toc-indirect)
>>   else
>>   KBUILD_CFLAGS += $(call cc-option,-mbig-endian)
>> +KBUILD_CPPFLAGS += $(call cc-option,-mbig-endian)
>>   KBUILD_LDFLAGS    += -EB
>>   LDEMULATION    := ppc
>>   GNUTARGET    := powerpc
>> @@ -208,7 +210,6 @@ KBUILD_CPPFLAGS    += -I $(srctree)/arch/$(ARCH) 
>> $(asinstr)
>>   KBUILD_AFLAGS    += $(AFLAGS-y)
>>   KBUILD_CFLAGS    += $(call cc-option,-msoft-float)
>>   KBUILD_CFLAGS    += -pipe $(CFLAGS-y)
>> -CPP        = $(CC) -E $(KBUILD_CFLAGS)
>>   CHECKFLAGS    += -m$(BITS) -D__powerpc__ -D__powerpc$(BITS)__
>>   ifdef CONFIG_CPU_BIG_ENDIAN
>> diff --git a/arch/powerpc/kernel/vdso32/Makefile 
>> b/arch/powerpc/kernel/vdso32/Makefile
>> index 7d9a6fee0e3d..ea001c6df1fa 100644
>> --- a/arch/powerpc/kernel/vdso32/Makefile
>> +++ b/arch/powerpc/kernel/vdso32/Makefile
>> @@ -44,7 +44,7 @@ asflags-y := -D__VDSO32__ -s
>>   obj-y += vdso32_wrapper.o
>>   targets += vdso32.lds
>> -CPPFLAGS_vdso32.lds += -P -C -Upowerpc
>> +CPPFLAGS_vdso32.lds += -C
>>   # link rule for the .so file, .lds has to be first
>>   $(obj)/vdso32.so.dbg: $(src)/vdso32.lds $(obj-vdso32) 
>> $(obj)/vgettimeofday.o FORCE
>> diff --git a/arch/powerpc/kernel/vdso64/Makefile 
>> b/arch/powerpc/kernel/vdso64/Makefile
>> index 2813e3f98db6..07eadba48c7a 100644
>> --- a/arch/powerpc/kernel/vdso64/Makefile
>> +++ b/arch/powerpc/kernel/vdso64/Makefile
>> @@ -30,7 +30,7 @@ ccflags-y := -shared -fno-common -fno-builtin 
>> -nostdlib \
>>   asflags-y := -D__VDSO64__ -s
>>   targets += vdso64.lds
>> -CPPFLAGS_vdso64.lds += -P -C -U$(ARCH)
>> +CPPFLAGS_vdso64.lds += -C
>>   # link rule for the .so file, .lds has to be first
>>   $(obj)/vdso64.so.dbg: $(src)/vdso64.lds $(obj-vdso64) 
>> $(obj)/vgettimeofday.o FORCE
>>
> 

-- 
Alexey
