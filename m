Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FB4373372
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 03:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhEEBI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 21:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhEEBI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 21:08:58 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77631C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 18:08:02 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id i22so367484ila.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 18:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bEpWeb/menIvMES77K2iFUdQ+HrLc5q00Hmk4Fn+RAg=;
        b=fQ3eb2fr9u/AH7jr/8/eMnkYayGhWr/co1TtboOVnlKvzxXKBJVPDDUSwWRmSIKmS9
         aqppkGmqm6apAnwWl+oSgoYA75QLtTmd4ysbxQ+BzT0OIQU3E8V7od3ljDGBvActrGDr
         Qa0SAQ1q8UBf5a30ZFlcc+JPLYA8k4TYb+/Ad/GPEq1FsGFAxY6x+EqZ11qZTZI6BdP5
         5X6j3UzE9YgDkgXTpF5zpTQF7LIP5azhk4JL+HAVHUV5WGkZU7PHid9eHgyGCH25xA8r
         5/ZPjyIa5p9GP/xVUKpCfynS912Z4ild0f9hH7AAsYqJfOwz8dOUFWU3coXwY6RRO8I+
         Un3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bEpWeb/menIvMES77K2iFUdQ+HrLc5q00Hmk4Fn+RAg=;
        b=gJ0J1lWnSexI0OPDHO0kYIwrPLGntgVNUOODjRjQcdhBJQNJiXDVSpM9gpyaVhi1IK
         dxoTCuSgI9euutkMH+NrymfiH01A4XgwvZaxh9OQ45hSLywRqxicZhJDdCl1BuTJmzvj
         GDvlcUDyt5tabwZE6s66dQshnBHTNeo+6AiCdjKtv3C5o27AiwiJYdKOx+dsZ4UA3CNo
         L1CuR64oh0ETTIK87A9fER1lrs6kiX7SL68+DVVQCfwIzfFw2nKkvamZ3ZRdmPmk5wW+
         V6hU6GMpwQixb7N9YdBeju48MWuQK0lxM9CcHzxON2WpBd6ALwX9nT4pAGYOUOCKoDiK
         pI/Q==
X-Gm-Message-State: AOAM532R7eyodiDl7dLVhdjpLWIB/tNZkiae4KCZHjE86e4jsLPKyz27
        NpwU7JrlTUNMtJ0BbCRs1F7ihCfLyBZkT4t6jBY=
X-Google-Smtp-Source: ABdhPJzf0aInrdri5qwsIQG23R9Qxdy5608iGKzcSnGhJ5/rKPFbSAfk2opkW3sARNSiIpu9pcJBUaJ/198notiwsK0=
X-Received: by 2002:a05:6e02:1063:: with SMTP id q3mr23196316ilj.52.1620176882000;
 Tue, 04 May 2021 18:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <YJG6ztbGjtuctec4@google.com> <38B9D60F-F24F-4910-B2DF-2A57F1060452@amacapital.net>
In-Reply-To: <38B9D60F-F24F-4910-B2DF-2A57F1060452@amacapital.net>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 5 May 2021 09:07:50 +0800
Message-ID: <CAJhGHyDsTVyDX9fkYAyVkVQFWqkyTAVCY4enJqdG4bzOuOSn+w@mail.gmail.com>
Subject: Re: [PATCH] KVM/VMX: Invoke NMI non-IST entry instead of IST entry
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Juergen Gross <JGross@suse.com>,
        Joerg Roedel <jroedel@suse.de>, Jian Cai <caij2003@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 5:23 AM Andy Lutomirski <luto@amacapital.net> wrote:
>
>
> > On May 4, 2021, at 2:21 PM, Sean Christopherson <seanjc@google.com> wro=
te:
> >
> > =EF=BB=BFOn Tue, May 04, 2021, Paolo Bonzini wrote:
> >>> On 04/05/21 23:05, Maxim Levitsky wrote:
> >>> Does this mean that we still rely on hardware NMI masking to be activ=
ated?
> >>
> >> No, the NMI code already handles reentrancy at both the assembly and C
> >> levels.
> >>
> >>> Or in other words, that is we still can't have an IRET between VM exi=
t and
> >>> the entry to the NMI handler?
> >>
> >> No, because NMIs are not masked on VM exit.  This in fact makes things
> >> potentially messy; unlike with AMD's CLGI/STGI, only MSRs and other th=
ings
> >> that Intel thought can be restored atomically with the VM exit.
> >
> > FWIW, NMIs are masked if the VM-Exit was due to an NMI.
>
> Then this whole change is busted, since nothing will unmask NMIs. Revert =
it?

There is some instructable code between VMEXIT and
handle_exception_nmi_irqoff().

The possible #DB #BP can happen in this gap and the IRET
of the handler of #DB #BP will unmask NMI.

Another way to fix is to change the VMX code to call the NMI handler
immediately after VMEXIT before leaving "nostr" section.

Reverting it can't fix the problem.
