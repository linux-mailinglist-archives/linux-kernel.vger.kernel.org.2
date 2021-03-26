Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC9234AE5C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 19:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhCZSOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 14:14:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230026AbhCZSOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 14:14:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B97B61A32
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 18:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616782474;
        bh=VKbDlg8i3gjxkH3Bz+k8hWQFbbVPsGGXG3YFhuEbeBs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y7HCVEnI2IKlsg+zehxZYEgNCWiGs+PUQA5RwNww5dhrlUhNwtEbaz0EBrD6+W2FB
         H7PfO8eEhgNvr8se/3gAfBoN79EU1gZna0hDWRkSavXkF4z5HjwrJy5qquTJiDHbU8
         byAv3lJidmUNqbAs4iBVB2QK2rbljiTX+iIoRiLyMlwrvnj42Xd/1776oTMUiQZ92v
         dWTsDMp5q+GauJnQQEI0D28yCs0NCy+vZ3Fz0DNq9EBgoQMt1uVo8RMi6q6+4Zyy00
         vDIrwhqzOErN7znpdIu+LXaVQjwyYhPagd/rHenm7w/BG+4KbJ+oFuxV26G6qxryVl
         G1+5ksK9xP/gg==
Received: by mail-ej1-f44.google.com with SMTP id jy13so9786453ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 11:14:34 -0700 (PDT)
X-Gm-Message-State: AOAM530tpcZkGhF8WzpwMPm6ktO5Y43oUNw9kp6B7nX0SU6ptH24uoPu
        i41mhFWAZpIJHQVt4k/VtHOgGPPRRDTOSZ/SR52Zwg==
X-Google-Smtp-Source: ABdhPJyJCflIcyJ6CTRBLwKEJtOJbW7mfulADexCa805/UNEh4Uc6PRhW7bd/QOLyLNijSC/sP6ioRk6AfoBrPmvBqg=
X-Received: by 2002:a17:907:3d01:: with SMTP id gm1mr16976998ejc.214.1616782472997;
 Fri, 26 Mar 2021 11:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrURmk4ZijJVUtJwouj=_0NPiUvUFr9XMvdniRRFqeU+fg@mail.gmail.com>
 <87a6qqi064.fsf@mid.deneb.enyo.de>
In-Reply-To: <87a6qqi064.fsf@mid.deneb.enyo.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 26 Mar 2021 11:14:22 -0700
X-Gmail-Original-Message-ID: <CALCETrUM1=Db3vmQAhPkt=SktL7+dtUrt5Ef6BP3T1Q6HY3Bmw@mail.gmail.com>
Message-ID: <CALCETrUM1=Db3vmQAhPkt=SktL7+dtUrt5Ef6BP3T1Q6HY3Bmw@mail.gmail.com>
Subject: Re: Why does glibc use AVX-512?
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>,
        libc-alpha <libc-alpha@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 5:12 AM Florian Weimer <fw@deneb.enyo.de> wrote:
>
> * Andy Lutomirski-alpha:
>
> > glibc appears to use AVX512F for memcpy by default.  (Unless
> > Prefer_ERMS is default-on, but I genuinely can't tell if this is the
> > case.  I did some searching.)  The commit adding it refers to a 2016
> > email saying that it's 30% on KNL.
>
> As far as I know, glibc only does that on KNL, and there it is
> actually beneficial.  The relevant code is:
>
>       /* Since AVX512ER is unique to Xeon Phi, set Prefer_No_VZEROUPPER
>          if AVX512ER is available.  Don't use AVX512 to avoid lower CPU
>          frequency if AVX512ER isn't available.  */
>       if (CPU_FEATURES_CPU_P (cpu_features, AVX512ER))
>         cpu_features->preferred[index_arch_Prefer_No_VZEROUPPER]
>           |= bit_arch_Prefer_No_VZEROUPPER;
>       else
>         cpu_features->preferred[index_arch_Prefer_No_AVX512]
>           |= bit_arch_Prefer_No_AVX512;
>
> So it's not just about Prefer_ERMS.

Phew.

>
> > AVX-512 cleared, and programs need to explicitly request enablement.
> > This would allow programs to opt into not saving/restoring across
> > signals or to save/restore in buffers supplied when the feature is
> > enabled.
>
> Isn't XSAVEOPT already able to handle that?
>

Yes, but we need a place to put the data, and we need to acknowledge
that, with the current save-everything-on-signal model, the amount of
time and memory used is essentially unbounded.  This isn't great.

>
> There is a discussion about using the higher (AVX-512-only) %ymm
> registers, to avoid the %xmm transition penalty without the need for
> VZEROUPPER.  (VZEROUPPER is incompatible with RTM from a performance
> point of view.)  That would perhaps negatively impact XSAVEOPT.
>
> Assuming you can make XSAVEOPT work for you on the kernel side, my
> instincts tell me that we should have markup for RTM, not for AVX-512.
> This way, we could avoid use of the AVX-512 registers and keep using
> VZEROUPPER, without run-time transaction checks, and deal with other
> idiosyncrasies needed for transaction support that users might
> encounter once this feature sees more use.  But the VZEROUPPER vs RTM
> issues is currently stuck in some internal process issue on my end (or
> two, come to think of it), which I hope to untangle next month.

Can you elaborate on the issue?
