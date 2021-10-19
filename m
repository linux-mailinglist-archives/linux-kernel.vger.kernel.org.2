Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BC8432B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 03:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhJSA6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 20:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhJSA6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:58:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B961610E7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 00:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634604954;
        bh=cIGQRuB5/4x08XlxRDA3Ao4AUXcOHw77Zhri+XpaAOo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MK5K42cHFpsLhdENsE2bQgGFWcnMCoqtAdg+L386ST0mMkmkhSWDz+s2wjDXLMU/2
         UwNTddFOo85pr0yyS+C1K6GGGC7BsPvr8jZf29E15SknIHrZPdmnLbgVMb07VbqCJO
         Wc/tR0i6SQcMxoL2kxeAx0+LS3M5XkcWkcFsZa0PCsiUJF5tJhv1ycvQakl4rCBzrD
         d2MHE0Wu56KXTSvHDxihBfwq1f2rDPmFvehCJgAD5nrv7/VGyBHjeIciilz/0AE3WW
         uctcPWL2Nr+AIx9hrvO3w78XQRrkE2tuWpHWtzWmk6Zdb461yRVOSQLeQatQRWRG+I
         HyVBEqkVd6ZfA==
Received: by mail-ua1-f41.google.com with SMTP id r22so6985022uat.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 17:55:53 -0700 (PDT)
X-Gm-Message-State: AOAM532U9JbZI8vSPGaq2JKeK/hfo/BIp8G7QZhwLfyn0AdrC+9erfob
        6tNtIjJOUcmxMbg2toifGWiNWr/2z9tceDIrGSg=
X-Google-Smtp-Source: ABdhPJzwkEEBSQVzjjrkD+0CHBWKBCiLyhGhSpmTY1ODlPUy6auanc2+wSEfbPXmOII4D1ThZB9ekmQ6lgfucHgqXls=
X-Received: by 2002:a67:d78c:: with SMTP id q12mr32242550vsj.28.1634604953132;
 Mon, 18 Oct 2021 17:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211016032200.2869998-1-guoren@kernel.org> <20211016032200.2869998-3-guoren@kernel.org>
 <CAL_Jsq+NM=jvYfvyNVsJCrizHzqaDMPe05hkBhnOWHc+JwBNig@mail.gmail.com>
In-Reply-To: <CAL_Jsq+NM=jvYfvyNVsJCrizHzqaDMPe05hkBhnOWHc+JwBNig@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 19 Oct 2021 08:55:42 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRdowd_jicA+iWQ9sg5xSZA_O8KZ7q45A3CS+i0iKYicg@mail.gmail.com>
Message-ID: <CAJF2gTRdowd_jicA+iWQ9sg5xSZA_O8KZ7q45A3CS+i0iKYicg@mail.gmail.com>
Subject: Re: [PATCH V4 2/3] dt-bindings: update riscv plic compatible string
To:     Rob Herring <robh@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 8:02 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Oct 15, 2021 at 10:22 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Add the compatible string "thead,c900-plic" to the riscv plic
> > bindings to support allwinner d1 SOC which contains c906 core.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > Cc: Anup Patel <anup@brainfault.org>
> > Cc: Atish Patra <atish.patra@wdc.com>
>
> Please send to the DT list so that checks run and it's in my review
> queue (IOW, use get_maintainers.pl). And run 'make dt_binding_check'
> so reviewers don't have to find your typos and other errors for you.
Thx for the tip, I would follow that in next version.

>
> Rob



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
