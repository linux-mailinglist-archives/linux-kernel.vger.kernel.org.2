Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE12D32A11D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377434AbhCBEtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:49:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:59106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1445193AbhCBC5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 21:57:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95F2F61601
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 02:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614653335;
        bh=Kk6vIAK5e/P2WALpRl5lbSaKaT/Qk60wrNd/8s1Kt94=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GAHsMlhVr37H5IUoz3jqQrE+Wg0Vjc6JPPWocyHKrAEUTcXUT3ilMNm13qPqzC8zE
         xaMsTPxP08wCb6ncizFWcjISGepOgyGVWoEZUg3xeSaE1AovoZhnuU03Bluql6n/64
         fThRO50hlKMqQJbB+CHAghAGAQZCfPiWp9rwNm/w3s/lyBYDzRgBTa4BAJMe1fLx1n
         ntfN6rFLKeE9VKqQVlh7Y0Li9la7LY2qa9GAedOHPCRDXiIiGOEjLOiitMvDTjks/g
         ZPcOX06lds++S0ijxoEKMqUPm75cMPZYbyszMBISP0SWJVH997pUryNGtMwPZ3b9LM
         p9QschkA345PA==
Received: by mail-ed1-f46.google.com with SMTP id b13so14233536edx.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 18:48:55 -0800 (PST)
X-Gm-Message-State: AOAM533kitAyBgYbXQFWDH1ZZsgpsFZeFwEZXs+bqgja7wf/CmzJfXJE
        7dl2CBiEpeilAdDZ8w4ksSAYerirgP4PfqmEuXDDZg==
X-Google-Smtp-Source: ABdhPJz8FqkrZ6NoNfv1lQmfoDLpSqBPDjBPNMrAcRdXIKExgnes+rdpoIxMPg1bEy7iQ52DEakyj6xehCiGXM8yY6A=
X-Received: by 2002:a05:6402:27cd:: with SMTP id c13mr18775065ede.263.1614653334168;
 Mon, 01 Mar 2021 18:48:54 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXzXv-V3A3SpN_Pdj_PNG8Gw0AVsZD7+VO-q_xCAu2T2A@mail.gmail.com>
 <20210301165130.GA5351@redhat.com> <20210302112224.6b3568434be490fbfbdec790@kernel.org>
In-Reply-To: <20210302112224.6b3568434be490fbfbdec790@kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 1 Mar 2021 18:48:43 -0800
X-Gmail-Original-Message-ID: <CALCETrWRVhKksmF0nuk_aT2JJazbk4jQtMeH5LmaHdePnJLarw@mail.gmail.com>
Message-ID: <CALCETrWRVhKksmF0nuk_aT2JJazbk4jQtMeH5LmaHdePnJLarw@mail.gmail.com>
Subject: Re: Why do kprobes and uprobes singlestep?
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 6:22 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Oleg and Andy,
>
> On Mon, 1 Mar 2021 17:51:31 +0100
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > Hi Andy,
> >
> > sorry for delay.
> >
> > On 02/23, Andy Lutomirski wrote:
> > >
> > > A while back, I let myself be convinced that kprobes genuinely need to
> > > single-step the kernel on occasion, and I decided that this sucked but
> > > I could live with it.  it would, however, be Really Really Nice (tm)
> > > if we could have a rule that anyone running x86 Linux who single-steps
> > > the kernel (e.g. kgdb and nothing else) gets to keep all the pieces
> > > when the system falls apart around them.  Specifically, if we don't
> > > allow kernel single-stepping and if we suitably limit kernel
> > > instruction breakpoints (the latter isn't actually a major problem),
> > > then we don't really really need to use IRET to return to the kernel,
> > > and that means we can avoid some massive NMI nastiness.
> >
> > Not sure I understand you correctly, I know almost nothing about low-level
> > x86  magic.
>
> x86 has normal interrupt and NMI. When an NMI occurs the CPU masks NMI
> (the mask itself is hidden status) and IRET releases the mask. The problem
> is that if an INT3 is hit in the NMI handler and does a single-stepping,
> it has to use IRET for atomically setting TF and return.
>
> >
> > But I guess this has nothing to do with uprobes, they do not single-step
> > in kernel mode, right?
>
> Agreed, if the problematic case is IRET from NMI handler, uprobes doesn't
> hit because it only invoked from user-space.
> Andy, what would you think?

Indeed, this isn't a problem for uprobes.  The problem for uprobes is
that all the notifiers from #DB are kind of messy, and I would like to
get rid of them if possible.
