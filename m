Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA6A435A25
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 07:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhJUFGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 01:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhJUFGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 01:06:13 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FE1C06161C;
        Wed, 20 Oct 2021 22:03:58 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so10873408otq.12;
        Wed, 20 Oct 2021 22:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tvUL8TPJTDaM74AwlVSRvnYkJx2SLMOV0WGLC72Br1s=;
        b=basY/V1sffAQysSxXhmvJ2UrAshUpRJpI1eQShiX/8jqbn3jz1MAU5cvmJeFWd2WuH
         QSLFbAyle4vyPd2hGXGV6hp/vQ2Kt1JF2V0JAegmE85+PKemVojonMkE5KCeRBdoUrUH
         oHlaByqH135NldC+53SCb5j2hL559mRgUcXKyWmBc+qhHtwusFgHhr6EK3mYU3bpYkF3
         Epi+tvqkqhlHj4wFtdDA8RxLWg5ymCpdEY5nxz/ufysgivsPXXx6R5PuzOsw4TC5I3e1
         30jU+xEZyQ+IGdv/2vaOur6YfgSXI4wFQzV+t7ljiTbgBH+gb/W7uIAISawD0Z1dTB+U
         Z7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tvUL8TPJTDaM74AwlVSRvnYkJx2SLMOV0WGLC72Br1s=;
        b=c8/1JjD3KbswopcTtwS7sT3j/lQwyEtRamTQVBIU8txkFJb1XutxJnFVeZKXn5tlFG
         3Zw4vMmkAU0NGxPQ1uMPX0z5nWUDJ3vLekNgfhoqbqNdaEnXmRh2Wt2rrtDWOricKLzB
         I6g6ssNM3X7b1FSuks8S6iwmAA0R9hqZhjLDgM127udnREzVuUR6pmkdJs6Bdp4jRRZe
         LjpFwSczXHJN5qi6ZBqnqViiAZwHJUL/0O+ZjNPH6WyVg9vIKiTgTfKC7eCJ+J/e1dxS
         aF+iKNFpNbCIY9coxQwVAy2sU3RdbfNJ5DjbH/1rzbQN4zNXq8lZjt5TN0nCyaqyIkgT
         Z5rA==
X-Gm-Message-State: AOAM530t5u0JMA06xUfuASMbdZzOyp1OqN9MHTvUe2O1AOGFUAv3Im4w
        GpAAGNljwlochWpHSVKBpvzQdwOy3uBACwmdTUs=
X-Google-Smtp-Source: ABdhPJxGc0HzHzU5XzsdcutGSbvc5T4KsuYx6Ener3ICyb4ae7Uh/Z3SSrkNIUf5KrAMDzxBeLth8IE8TIYrH1oa1yQ=
X-Received: by 2002:a05:6830:43a5:: with SMTP id s37mr2915654otv.246.1634792638013;
 Wed, 20 Oct 2021 22:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211020120726.4022086-1-pizhenwei@bytedance.com>
 <CANRm+CxAVA-L0wjm72eohXXWvh9fS7wVFzfKHuEjrsiRFuk9fg@mail.gmail.com>
 <YXB4FHfzh99707EH@google.com> <08757159-1673-5c7b-3efc-e5b54e82d6c3@bytedance.com>
In-Reply-To: <08757159-1673-5c7b-3efc-e5b54e82d6c3@bytedance.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Thu, 21 Oct 2021 13:03:46 +0800
Message-ID: <CANRm+CzcTUWYJeaj3eWKH84YZYgeMZz3kbpn13c8i97iYGGHFQ@mail.gmail.com>
Subject: Re: Re: [PATCH] x86/kvm: Introduce boot parameter no-kvm-pvipi
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Wanpeng Li <wanpengli@tencent.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 at 11:05, zhenwei pi <pizhenwei@bytedance.com> wrote:
>
>
> On 10/21/21 4:12 AM, Sean Christopherson wrote:
> > On Wed, Oct 20, 2021, Wanpeng Li wrote:
> >> On Wed, 20 Oct 2021 at 20:08, zhenwei pi <pizhenwei@bytedance.com> wrote:
> >>>
> >>> Although host side exposes KVM PV SEND IPI feature to guest side,
> >>> guest should still have a chance to disable it.
> >>>
> >>> A typicall case of this parameter:
> >>> If the host AMD server enables AVIC feature, the flat mode of APIC
> >>> get better performance in the guest.
> >>
> >> Hmm, I didn't find enough valuable information in your posting. We
> >> observe AMD a lot before.
> >> https://lore.kernel.org/all/CANRm+Cx597FNRUCyVz1D=B6Vs2GX3Sw57X7Muk+yMpi_hb+v1w@mail.gmail.com/T/#u
> >
> > I too would like to see numbers.  I suspect the answer is going to be that
> > AVIC performs poorly in CPU overcommit scenarios because of the cost of managing
> > the tables and handling "failed delivery" exits, but that AVIC does quite well
> > when vCPUs are pinned 1:1 and IPIs rarely require an exit to the host.
> >
>
> Test env:
> CPU: AMD EPYC 7642 48-Core Processor
>
> Kmod args(enable avic and disable nested):
> modprobe kvm-amd nested=0 avic=1 npt=1
>
> QEMU args(disable x2apic):
> ... -cpu host,x2apic=off ...
>
> Benchmark tool:
> https://github.com/bytedance/kvm-utils/tree/master/microbenchmark/apic-ipi
>
> ~# insmod apic_ipi.ko options=5 && dmesg -c
>
>   apic_ipi: 1 NUMA node(s)
>   apic_ipi: apic [flat]
>   apic_ipi: apic->send_IPI[default_send_IPI_single+0x0/0x40]
>   apic_ipi: apic->send_IPI_mask[kvm_send_ipi_mask+0x0/0x10]
>   apic_ipi:     IPI[kvm_send_ipi_mask] from CPU[0] to CPU[1]
>   apic_ipi:             total cycles 375671259, avg 3756
>   apic_ipi:     IPI[flat_send_IPI_mask] from CPU[0] to CPU[1]
>   apic_ipi:             total cycles 221961822, avg 2219
>
>
> apic->send_IPI_mask[kvm_send_ipi_mask+0x0/0x10]
>    -> This line show current send_IPI_mask is kvm_send_ipi_mask(because
> of PV SEND IPI FEATURE)
>
> apic_ipi:       IPI[kvm_send_ipi_mask] from CPU[0] to CPU[1]
> apic_ipi:               total cycles 375671259, avg 3756
>    -->These lines show the average cycles of each kvm_send_ipi_mask: 3756
>
> apic_ipi:       IPI[flat_send_IPI_mask] from CPU[0] to CPU[1]
> apic_ipi:               total cycles 221961822, avg 2219
>    -->These lines show the average cycles of each flat_send_IPI_mask: 2219

Just single target IPI is not eough.

    Wanpeng
