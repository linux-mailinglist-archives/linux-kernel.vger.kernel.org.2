Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D6B313599
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 15:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhBHOuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 09:50:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:47426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231742AbhBHOl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 09:41:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B1A764E87
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 14:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612795246;
        bh=uzVP/yUTZ26j2flqJpYpKjVHor/lpsoGXsqXFjLI8Ac=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qcMSda+hMlq6oiVFD7V7aK7jrnYayHkeWCwg6mSQSQC4KSe68pSYAhQ9MLQxRHhSp
         7cnuxD90DJ6ukwjMLeq16FJJ9bqf4suMkJipKYJo71DMqcRK1fX6o8PpiDIkgR4w8v
         hiZ68kFrY6oAMB/WH3Dk/mEfC4lsSrq5WjSZdmT6MKhhLzej/oHkShYc0zNah/IBmZ
         DtrS+HRpa2aPFbvOUepqfj/xU09Xz1zaO/u0jRTx99Swb5v87m8k3s2Pdlodof9dkV
         FWwwsyOr+bW0uxzNpongew++F50MbGErul6TGcEWMv3VRT/st9ZTAwG9GtnXD0WFin
         o6P/x1TELi3Wg==
Received: by mail-ot1-f45.google.com with SMTP id 63so14393516oty.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 06:40:45 -0800 (PST)
X-Gm-Message-State: AOAM532kferdlj5GW9NikMl4dRgRBJozgFVKSRbuMpRb1Z7y41JyEacN
        RDk8Uu1fuRv5XuK7aMTqZCZ3vODVCK2CcRMTiMc=
X-Google-Smtp-Source: ABdhPJwfnlQb1L3cCjYD7p80QTVblCNgqmsUFh18POCp3XEUcxiYvTt3HkWHqjqqd4APNtXMrcvFuIgfQrKN7vEYCsA=
X-Received: by 2002:a05:6830:13ce:: with SMTP id e14mr1791419otq.108.1612795245250;
 Mon, 08 Feb 2021 06:40:45 -0800 (PST)
MIME-Version: 1.0
References: <20210208095732.3267263-1-maz@kernel.org> <20210208143248.GA25934@willie-the-truck>
In-Reply-To: <20210208143248.GA25934@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 8 Feb 2021 15:40:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGu_CLPiJDSzTkvdVNiDcRpo4se_fR8zqVgxyfERtgoAw@mail.gmail.com>
Message-ID: <CAMj1kXGu_CLPiJDSzTkvdVNiDcRpo4se_fR8zqVgxyfERtgoAw@mail.gmail.com>
Subject: Re: [PATCH v7 00/23] arm64: Early CPU feature override, and
 applications to VHE, BTI and PAuth
To:     Will Deacon <will@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Hector Martin <marcan@marcan.st>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Feb 2021 at 15:32, Will Deacon <will@kernel.org> wrote:
>
> Hi Marc,
>
> On Mon, Feb 08, 2021 at 09:57:09AM +0000, Marc Zyngier wrote:
> > It recently came to light that there is a need to be able to override
> > some CPU features very early on, before the kernel is fully up and
> > running. The reasons for this range from specific feature support
> > (such as using Protected KVM on VHE HW, which is the main motivation
> > for this work) to errata workaround (a feature is broken on a CPU and
> > needs to be turned off, or rather not enabled).
> >
> > This series tries to offer a limited framework for this kind of
> > problems, by allowing a set of options to be passed on the
> > command-line and altering the feature set that the cpufeature
> > subsystem exposes to the rest of the kernel. Note that this doesn't
> > change anything for code that directly uses the CPU ID registers.
>
> I applied this locally, but I'm seeing consistent boot failure under QEMU when
> KASAN is enabled. I tried sprinkling some __no_sanitize_address annotations
> around (see below) but it didn't help. The culprit appears to be
> early_fdt_map(), but looking a bit more closely, I'm really nervous about the
> way we call into C functions from __primary_switched. Remember -- this code
> runs _twice_ when KASLR is active: before and after the randomization. This
> also means that any memory writes the first time around can be lost due to
> the D-cache invalidation when (re-)creating the kernel page-tables.
>

Not just cache invalidation - BSS gets wiped again as well.

-- 
Ard.
