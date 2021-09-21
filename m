Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B99413324
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 14:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbhIUMIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 08:08:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230160AbhIUMIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 08:08:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E0A66126A;
        Tue, 21 Sep 2021 12:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632225996;
        bh=qnWTodEwspkSMdWf5XON5Ep7daBqF5kbGbudj8UJ3BM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AqKDYakbUVbx323nFcNrRgWy01h3JK7NhWkadTqGI2CjV4jpJ1GWL97jA4orZZzAH
         XUIZuG5H+2+GtcxT5b2qT+uCdJa7SEBUN2LigkTvwpHm7xnqlCzrWXVM4zyiq3d/fy
         pD1nF0rp8CyvUG8OxbFloC/QGB8iJDTbLHhlyh1yg4dno4mfgMgHOPm0GhTCh9IqnV
         9tqnYqbdFGteLVIQUlEGX6b9nEcp+XzfpWgphtvwG4SzxpsYDwDvkga0iA1YGPeLBf
         GAK6jZeK0iVdleRljCp+OCFHp6MUXO3a9TxpP/52YLnqnnecas2EICZcztf8Kn6jUT
         2qHogEKNYd3qQ==
Received: by mail-oi1-f172.google.com with SMTP id s69so21824002oie.13;
        Tue, 21 Sep 2021 05:06:36 -0700 (PDT)
X-Gm-Message-State: AOAM532QWmGJ1HlvITAHiOoLhkNvjLJmlCuTLB6UpRKl+LeD1yTgJgm0
        uydPRnPnJsZlE9aD6TqmOiK1gEexDmXcUm3T+GI=
X-Google-Smtp-Source: ABdhPJx1x7wQ2+Ve4iSZCDQmmYVEepXxo/5KRhWVQj/N//ixUTMX6irYoXDtuXoK84SNkd7MjELWyQDwt9BfbsPbMro=
X-Received: by 2002:a05:6808:1148:: with SMTP id u8mr1242229oiu.33.1632225995730;
 Tue, 21 Sep 2021 05:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210914121036.3975026-1-ardb@kernel.org> <20210914135527.GC30247@C02TD0UTHF1T.local>
In-Reply-To: <20210914135527.GC30247@C02TD0UTHF1T.local>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 21 Sep 2021 14:06:24 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGPcHwdSjy-doB09LBLvrXtqYT4dyxE5hU=D=2m8Fg8zg@mail.gmail.com>
Message-ID: <CAMj1kXGPcHwdSjy-doB09LBLvrXtqYT4dyxE5hU=D=2m8Fg8zg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] Move task_struct::cpu back into thread_info
To:     Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:S390" <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sept 2021 at 15:55, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Sep 14, 2021 at 02:10:28PM +0200, Ard Biesheuvel wrote:
> > Commit c65eacbe290b ("sched/core: Allow putting thread_info into
> > task_struct") mentions that, along with moving thread_info into
> > task_struct, the cpu field is moved out of the former into the latter,
> > but does not explain why.
>
> From what I recall of talking to Andy around that time, when converting
> arm64 over, the theory was that over time we'd move more and more out of
> thread_info and into task_struct or thread_struct, until task_struct
> supplanted thread_info entirely, and that all became generic.
>
> I think the key gain there was making things more *generic*, and there
> are other ways we could do that in future without moving more into
> task_struct (e.g. with a geenric thread_info and arch_thread_info inside
> that).
>
> With that in mind, and given the diffstat, I think this is worthwhile.
>
> FWIW, for the series:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>

Thanks.

Any comments on this from the various arch maintainers? Especially
power, as Christophe seems happy with this but there are 3 different
patches affecting power that need a maintainer ack.
