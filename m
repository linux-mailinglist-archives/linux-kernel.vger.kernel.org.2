Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2276339056
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhCLOuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhCLOuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:50:25 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54728C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:50:25 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id t85so1990174pfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dWHnToSwExfied/vlTN3Sdg2BhGnFt56vTuAsL518GA=;
        b=dVgWbHwnB2V50cI/RbMVpAA8ArhidOR3CJ8bFHTz7jBdK2FZQH3zSRL6lbVbSAcPZh
         Gqt/PDugUzg0vely26mBsLvIIPK58NHYwKSocpGHnkMd4k/MxCa9hs+8AoBnJtpvtu2p
         KRBawlyzQWtFupeN+jIrxcIo+IF9ZC52o8/3mFHikFB5ZI5AyAYo60G79yix0zw/y49X
         ODVGyhh2+SS9MpMkNN8EM/tSwXPwbRYnyXNBYm9dRCcmVeLoumhdQwYIwdcZhoznasLH
         tr+6t2wSuDHmHhCVX4Lu/3cN1EvPpuPqiirECs18uh34Dzop0HmpibFNgY+8lpTFCsFO
         o0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dWHnToSwExfied/vlTN3Sdg2BhGnFt56vTuAsL518GA=;
        b=edCA7PDHKl+bwn29R8+0106wt/D/KgDCQF1reledbgTdU46X82xcBSQmOxJpEm6R4K
         lq7U9zbecAK9Bvp6UyLF53ND5IF6JIvWAdC6kKOjCK/f2dXoesoxMs/6H3rb1KLMiTo1
         iNIBw5g1F25eGB8eT597OnwVFX5Yv/2iM8A1TQcKlVI4ySlMGq5XueZpolfoXUmCm8Gx
         SHwlCXX7m87cHV5u25FEBG8vqhzq+aw0dN6DaWEBMAlpTrkLyRXY7t1/DVh6bEQr5yoN
         rxTDFQyLII8r387MrSltL9uqkeW/kgjXgEvaIjqcWRsV0N34QDs618WLxqTN6k7EZtAO
         PvNw==
X-Gm-Message-State: AOAM532USBle2sxDg9/fPxmR/GrA5LRsPMj+6fhrDAtSdCWs5GqpePqO
        nCMzkvASwjbFhaVkWZjsXzhaUOxSBOtDEFB11f2BBA==
X-Google-Smtp-Source: ABdhPJyVDSUJZpD/mmy4v4priYGxyMyZMQsGXICt3bXKEsgnPzu/tRRkbLEqnYOkthMVBYMTX9ofcu1fF4i/oR1VIhk=
X-Received: by 2002:a63:455d:: with SMTP id u29mr11898210pgk.286.1615560624740;
 Fri, 12 Mar 2021 06:50:24 -0800 (PST)
MIME-Version: 1.0
References: <20210312142210.21326-1-vincenzo.frascino@arm.com>
In-Reply-To: <20210312142210.21326-1-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 12 Mar 2021 15:50:13 +0100
Message-ID: <CAAeHK+wFT7Z5_Jg-8afdu8=mVqTwcnZY65Cgywxbd_0ui+1BEQ@mail.gmail.com>
Subject: Re: [PATCH v15 0/8] arm64: ARMv8.5-A: MTE: Add async mode support
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 3:22 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> This patchset implements the asynchronous mode support for ARMv8.5-A
> Memory Tagging Extension (MTE), which is a debugging feature that allows
> to detect with the help of the architecture the C and C++ programmatic
> memory errors like buffer overflow, use-after-free, use-after-return, etc.
>
> MTE is built on top of the AArch64 v8.0 virtual address tagging TBI
> (Top Byte Ignore) feature and allows a task to set a 4 bit tag on any
> subset of its address space that is multiple of a 16 bytes granule. MTE
> is based on a lock-key mechanism where the lock is the tag associated to
> the physical memory and the key is the tag associated to the virtual
> address.
> When MTE is enabled and tags are set for ranges of address space of a task,
> the PE will compare the tag related to the physical memory with the tag
> related to the virtual address (tag check operation). Access to the memory
> is granted only if the two tags match. In case of mismatch the PE will raise
> an exception.
>
> The exception can be handled synchronously or asynchronously. When the
> asynchronous mode is enabled:
>   - Upon fault the PE updates the TFSR_EL1 register.
>   - The kernel detects the change during one of the following:
>     - Context switching
>     - Return to user/EL0
>     - Kernel entry from EL1
>     - Kernel exit to EL1
>   - If the register has been updated by the PE the kernel clears it and
>     reports the error.
>
> The series is based on linux-next/akpm.
>
> To simplify the testing a tree with the new patches on top has been made
> available at [1].
>
> [1] https://git.gitlab.arm.com/linux-arm/linux-vf.git mte/v13.async.akpm

Acked-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>

for the series.

Thank you, Vincenzo!
