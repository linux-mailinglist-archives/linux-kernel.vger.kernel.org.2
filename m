Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B07422B76
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbhJEOuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbhJEOuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:50:17 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DC5C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 07:48:27 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id v10so2331956oic.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 07:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fP85uqPvsPSl2MUwxPDDeDYwMbz9jeEPyhfkUL7Uxk8=;
        b=Lhcbo43r147Wu0u8Wpp+9wVGM//0MYXGTdRlFyuSbAdh5ABUTCucDCjgyRL/4SnoX7
         bMioEsUENxhYa6S6Q2HQJFs9grfOcOzpZcmnOPjAFtZJLiQIrQ9M+gSNwsgq3qD8M+KZ
         tdiK4aSKR3Qw9+gkvCSl+IjUyGEFroTIx9wgF2WlpQ8fCmjUzoJdRQafIthSTAN4KBPi
         FQW3Vgar126Ayw2smtcCzwmHorrIgmeDmfX5HHR24bF7TaFs9iXO8tN1M7YeLF+Mj9/L
         8HyM59eeQDQfZKhagPaUa5MeBbcqIImrpjmp6VbQkdxjV7BuWMIa8ILg6CJrhuOEZVyU
         6PNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fP85uqPvsPSl2MUwxPDDeDYwMbz9jeEPyhfkUL7Uxk8=;
        b=SLsUhCSNOLnPO+qmELjDg6oJCgzDQ0Au5QONHeERajk9YRyFhz/FkLe52sBfDvgEG1
         P4qTl1I7XCVzA1++HVa1hxxq2TVrgb8LEnlQxR2qOgL3lfk3OGTR/teDqrUaPDKvKsHv
         W6S1rkZpfl1c5ok/+JdPcwWp+GAMBmvxrgQiDdleDLDoDjDsSQ3x+7r74Lb0/fsPz3Op
         JrhCW+kuI2apUbMPRvznsEUt3M5XMLRc9OWNeACns1PMb2cwuXv39qsICMg2GaMVvof4
         630DRzAU6tMPm3hLFsNyCJYFqeyOoxGJ66svbxfEA+rMbAWH75ab7dJiERRl1SBwoU5M
         g2Uw==
X-Gm-Message-State: AOAM532zD5CeSNF15KQ8gcgz+JQMZbny0XiF9nmrj9lJS3BwQ0FyvAx9
        6v8WloMz/nGH6AjKSeYxBMrWwJ5K1NDUdKiUu9w=
X-Google-Smtp-Source: ABdhPJz9dZiqVvIsst2xFd1wbDlv+vS4x96AHQf0IhY9TJqV+48wGcgEMHwUM41/xBLgGgcIpZ7Gd4s+1oQ2H7ETcVc=
X-Received: by 2002:aca:ab4d:: with SMTP id u74mr2828586oie.120.1633445306493;
 Tue, 05 Oct 2021 07:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
In-Reply-To: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 5 Oct 2021 10:48:15 -0400
Message-ID: <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 5, 2021 at 10:29 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Tom, dear Linux folks,
>
>
> Selecting the symbol `AMD_MEM_ENCRYPT` =E2=80=93 as done in Debian 5.13.9=
-1~exp1
> [1] =E2=80=93 also selects `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT`, as it def=
aults
> to yes, causing boot failures on AMD Raven systems. On the MSI B350M
> MORTAR with AMD Ryzen 3 2200G, Linux logs and the AMDGPU graphics
> driver, despite being loaded, does not work, and the framebuffer driver
> is used instead.
>
>      [   19.679824] amdgpu 0000:26:00.0: amdgpu: SME is not compatible
> with RAVEN
>
> It even causes black screens on other systems as reported to the Debian
> bug tracking system *Black screen on AMD Ryzen based systems (AMDGPU
> related when AMD Secure Memory Encryption not disabled --
> mem_encrypt=3Doff)* [2].

It's not incompatible per se, but SEM requires the IOMMU be enabled
because the C bit used for encryption is beyond the dma_mask of most
devices.  If the C bit is not set, the en/decryption for DMA doesn't
occur.  So you need IOMMU to be enabled in remapping mode to use SME
with most devices.  Raven has further requirements in that it requires
IOMMUv2 functionality to support some features which currently uses a
direct mapping in the IOMMU and hence the C bit is not properly
handled.

Alex

>
> Should the default be changed?
>
>
> Kind regards,
>
> Paul
>
>
> [1]:
> https://salsa.debian.org/kernel-team/linux/-/blob/master/debian/changelog=
#L1138
> [2]: https://bugs.debian.org/994453
