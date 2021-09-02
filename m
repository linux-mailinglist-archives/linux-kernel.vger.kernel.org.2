Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA9F3FF22C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346560AbhIBRUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242982AbhIBRUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:20:17 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E421C061757;
        Thu,  2 Sep 2021 10:19:19 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id a1so2583842ilj.6;
        Thu, 02 Sep 2021 10:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cRSdJMrEAQZ3ln6whQqTjQVnLVFP0/+gTx++A3ONYf4=;
        b=nt2b2vGMZNqBZgiRnEaDloVqz+kQhT0EpQVxuan/SRY1CmuPrNg+yCi7SLZZOSmhBY
         NefD/jKRoTZuj+iqPY30sdMG7iaAkONX1x/IgleMHLy9fM7+0G87gozuepvZNvYhxd55
         tkd0XvsX2nrfCcWloTAP10OswAP7PBIR16QZAafZAKJWvcpPipgp33oZSU/UxRwrRKVm
         +jjGzJ3c7yyzS8FY7lTxBbtfn8LrX8zjzMqV/50CDsrNpLDmGK8qkMaJZtJ/QXMTO7Gc
         X++BYzJSBDoLEyQucMqiB0eX87kXC7FjlB3T9DvK2kIRnTfZeE+9MAHuGlkCLVh5qsUG
         4AYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cRSdJMrEAQZ3ln6whQqTjQVnLVFP0/+gTx++A3ONYf4=;
        b=ecGJEKYgmMMttWY993rb9qnsiiOlYMf1IJQV2vUGjikMG4i+Y37ZIFGGCYMqojwEOC
         uthwuS4CMMj6ftq+YFhAO/N0mzHWClk0MrgjvF72x965GxLem5b7oQRiXAp5+kbEFZaJ
         EHulrIKazbykYs/DLdMVU7XemzByQNl4UmRqTfSL+TlzxDUzyF8Mj4tM6CX6BGEBguqE
         UVLQ5xYkchIBWHTNJumpKcvow3JWygP6WFagSxp1smImnmBPUUFz5IC6JWXkEkN0bWSq
         M//6bURMYKFaoZfpGA//d7WC7CwjamoKQamPLvPY5mnATG9m56OPMj3lqcyq40ThOQbP
         nMaA==
X-Gm-Message-State: AOAM533ah2s63nS+SlQ2OdFaTxog2WkE4QYrOaUbufrm5rdTOxg+FT69
        HxUeVtLu5Z9lu2thvP0cw5/mQpvfSVVU/sRakJ4=
X-Google-Smtp-Source: ABdhPJyeP3QsIvNivGbvX7tcO0HFKR0dkXvTELpcBQizz6jPmEzyclTVDOkWs0dKuDSrQ/D+h+XybqyBsV0Wn+KQPgg=
X-Received: by 2002:a05:6e02:2183:: with SMTP id j3mr3131941ila.149.1630603158758;
 Thu, 02 Sep 2021 10:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-3-jiangshanlai@gmail.com> <YTCGov+vvAMvso7q@suse.de>
 <1f327579-e62a-df65-0763-e88243829db3@linux.alibaba.com> <YTCsWpSmPYvXa1xz@hirez.programming.kicks-ass.net>
 <4c589fef-8c98-a6fc-693f-b205a7710e42@linux.alibaba.com> <YTC+FTo4uLLdyBxA@hirez.programming.kicks-ass.net>
 <YTDS/p/bnsTFzNES@hirez.programming.kicks-ass.net> <CAKwvOdmhUzR0QfAU+nVRtSPu11vg9yvyJ09Pb8q1X6CEfez=8w@mail.gmail.com>
In-Reply-To: <CAKwvOdmhUzR0QfAU+nVRtSPu11vg9yvyJ09Pb8q1X6CEfez=8w@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 2 Sep 2021 19:19:07 +0200
Message-ID: <CANiq72=OH0FYLnRfiVt5kjC39bZZsmjsMLCAAfh9iN1KQyzBaw@mail.gmail.com>
Subject: Re: [PATCH 02/24] x86/traps: Move arch/x86/kernel/traps.c to arch/x86/entry/
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Joerg Roedel <jroedel@suse.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Chester Lin <clin@suse.com>, Juergen Gross <jgross@suse.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 7:05 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> The above 2 hunks should go in include/linux/compiler_attributes.h,
> but yes.  I'd been meaning to send such a patch; it's nice to have

Note that `compiler_attributes.h` does not keep attributes that depend
on config options.

On one hand, I feel we should put them there. On the other hand, I
want to avoid making a mess again since the purpose of the file is to
keep things clean for the majority of attributes.

Perhaps we should do a middle-ground, and only allow those that depend
on a single config option, i.e. no nesting `#if`s or complex
conditions.

Cheers,
Miguel
