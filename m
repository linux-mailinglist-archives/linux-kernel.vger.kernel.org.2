Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB066321C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 17:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhBVQLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 11:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhBVQJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 11:09:03 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFEFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 08:08:21 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id k13so28423877ejs.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 08:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=TyEqjaEftvJKe5NhA72gotX3XSovzTBWWQb9G6YQcso=;
        b=mcHi7L8OQMByAnG4k4kByfqfoq+k0J+WdDqz0lJdbf1OoGGSEaUHecb3DJA85TYzIR
         SPRsH+07l+Qo2eQfthA3NlILNsP14w3xFHg6q+STJNYInPgcsHgOiyzPrwX3IHOHSF3u
         7DtAWBQwIS3DH9Bou8Gw/IchJeTRDgunloFmWbMkBJEjewlnPl3EPmfLLtqAesBomZjd
         1BNbq74BxD8ROKHV3u8G7lyt4jQ6NldGCkEpkS6wzGcQ5kE52Y0Ta4N26/mVJpSrO8h8
         DonVtuxCeAKMz30LVYoNwJqs59olI2mQrptdcvgjx8egktKxVfmY0Pkj2slmmT3yxcmw
         D2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=TyEqjaEftvJKe5NhA72gotX3XSovzTBWWQb9G6YQcso=;
        b=byrwSZ8MZ6EbrcCTwKDl83gQIhkGccVrKqpRJc8gf0W4ozEHpHD/c2bJ7Ab8NeABKE
         JEDR8BjYzvbc6Ez1V9Ac5+BLX5+fP2fHT7CBfm5AFqORKeGM7dIkY5Z8MwcnDmjKRjUw
         HOkmHwl3iwpmCmeMJmUuPHwYCbQTGovW4aTBwJSO1BnZ7ZcMD18XQQI5v5ys3pMaBGvs
         T0HpceTFRO2SmoUrdgY4IHgouHqjaeTY5OkMfz5Q2dIKTU6cNRG6P/rePwAwoQwlRCn/
         xyDm7TxWXDeju2Ht0fvn6KEwem15lqaTRE8TpTxDLlRPb1lnZ1wszNneumY8WotNr1a3
         0pSw==
X-Gm-Message-State: AOAM5313/785lwcapIRgMlYJoDRXYF0Bz19HME7K2qMctXtn3YURGaKl
        xgqzuRO7xPzlWN5bOxNsdW0NCUx+3e/xaZ+4u5BhCQ==
X-Google-Smtp-Source: ABdhPJzHDufFOg32CQ9qB+iWsbPkpMVmcHO+VclHeHiooTy3zmYJ6ykbddQWmVooA07uMgLHjV+WkHYwrlr1R5wy3hA=
X-Received: by 2002:a17:906:4c85:: with SMTP id q5mr21293694eju.375.1614010099619;
 Mon, 22 Feb 2021 08:08:19 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 22 Feb 2021 21:38:08 +0530
Message-ID: <CA+G9fYtNOZ-G_RTq_Uedy-7wkFog2q+OWNbWd--eL+i2-OQ7NA@mail.gmail.com>
Subject: clang-12: i386: Unsupported relocation type: R_386_PLT32 (4)
To:     clang-built-linux <clang-built-linux@googlegroups.com>,
        open list <linux-kernel@vger.kernel.org>,
        x86-ml <x86@kernel.org>, lkft-triage@lists.linaro.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While building i386 configs on stable-rc 5.10, stable-rc 5.11 branch
and mainline
with clang-12 these following warnings and errors were noticed.

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=i386
CROSS_COMPILE=i686-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
clang'

drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:2586:9: warning: shift
count >= width of type [-Wshift-count-overflow]

        return hweight64(VDBOX_MASK(&i915->gt));
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/asm-generic/bitops/const_hweight.h:29:49: note: expanded from
macro 'hweight64'
#define hweight64(w) (__builtin_constant_p(w) ? __const_hweight64(w) :
__arch_hweight64(w))
                                                ^~~~~~~~~~~~~~~~~~~~
include/asm-generic/bitops/const_hweight.h:21:76: note: expanded from
macro '__const_hweight64'
#define __const_hweight64(w) (__const_hweight32(w) +
__const_hweight32((w) >> 32))
                                                                           ^  ~~
include/asm-generic/bitops/const_hweight.h:20:49: note: expanded from
macro '__const_hweight32'
#define __const_hweight32(w) (__const_hweight16(w) +
__const_hweight16((w) >> 16))
                                                ^
include/asm-generic/bitops/const_hweight.h:19:48: note: expanded from
macro '__const_hweight16'
#define __const_hweight16(w) (__const_hweight8(w)  +
__const_hweight8((w)  >> 8 ))
                                               ^
include/asm-generic/bitops/const_hweight.h:10:9: note: expanded from
macro '__const_hweight8'
         ((!!((w) & (1ULL << 0))) +     \
               ^
drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:2586:9: warning: shift
count >= width of type [-Wshift-count-overflow]
        return hweight64(VDBOX_MASK(&i915->gt));
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<trim>

32 warnings generated.
Unsupported relocation type: R_386_PLT32 (4)
make[3]: *** [arch/x86/boot/compressed/Makefile:116:
arch/x86/boot/compressed/vmlinux.relocs] Error 1
make[3]: *** Deleting file 'arch/x86/boot/compressed/vmlinux.relocs'
make[3]: Target 'arch/x86/boot/compressed/vmlinux' not remade because of errors.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Steps to reproduce:
---------------------------
# TuxMake is a command line tool and Python library that provides
# portable and repeatable Linux kernel builds across a variety of
# architectures, toolchains, kernel configurations, and make targets.
#
# TuxMake supports the concept of runtimes.
# See https://docs.tuxmake.org/runtimes/, for that to work it requires
# that you install podman or docker on your system.
#
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.

tuxmake --runtime podman --target-arch i386 --toolchain clang-12
--kconfig defconfig  --kconfig-add
https://builds.tuxbuild.com/1opxSKxZuRowPsiOsSJ0IoUOXOt/config

-- 
Linaro LKFT
https://lkft.linaro.org
