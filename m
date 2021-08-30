Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7F93FBE3E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 23:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238857AbhH3V2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 17:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238490AbhH3V1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:27:25 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C708C0617AF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 14:26:31 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x27so34109722lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 14:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Y6EPDndojcjz/F26/NpOm5F5o+CGdPxLvcZoTavjOM=;
        b=JI4/oJJ+VEagwaGQmmy7kKw3QOfjEpmmGMyhY4DE5y+ophvkGNyNrG0trDeYhEEVaC
         5PpGpmQuu9ARSbJVlU8DTcBYuJ3d/mV9tizFSW7P722gIrW3Qq1Repgqt5mz73paJoMD
         5xS2lWLSnAfVT59If62XHFdkFYYzIwblhvbNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Y6EPDndojcjz/F26/NpOm5F5o+CGdPxLvcZoTavjOM=;
        b=iiKgOtP0/G3ufq6RX8Uj82nBkuFvbWVy5if1kQVnflH00Z6WGn5knTlnHyqmHcrWDE
         0dF+a9dUy3OGDX8LRhmUC+nONkaebm9B1qCN9e7IMJd1xxxNck4gmrhNTvXOCO+xX1rO
         ZkgkQDxnLYCV5o09BTkbuvUeib4GxAn2hv4I69HyRk9SKlgTA+9hzwN0L+iyk1IYiO4t
         TrCT/ALHtvI3APg9M4g/RuY/B0K+pGhGoK7YRdw91RmQUgmW1zhi8uTtvSk7DmTJIzdn
         c2FV5ItHWacIsqBHM9O5LStddXOeJs06DEHNXL/TOudzokMUvsHavZ7ZNVnKtnuqz1mf
         TDRw==
X-Gm-Message-State: AOAM5334V79hqXoTk9NpKWQlcwZPqv5eF9NoGtIJAc/GeRIDZU+HMmtJ
        GRjPNNPce2PtOPEQ/N9wxJ4MOEH+/1Cn0rtMGgQ=
X-Google-Smtp-Source: ABdhPJy5jC/9gD+Rrpr8+81qmiKNPp+m9wDpqeyP8ZCl1RT6/Yf8OtDT8XE9rsvpfpxDJ/QKe+XL9g==
X-Received: by 2002:a05:6512:118a:: with SMTP id g10mr7662462lfr.362.1630358789251;
        Mon, 30 Aug 2021 14:26:29 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id p3sm1504557lfa.228.2021.08.30.14.26.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 14:26:28 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id j4so34038393lfg.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 14:26:28 -0700 (PDT)
X-Received: by 2002:a05:6512:230b:: with SMTP id o11mr10524952lfu.377.1630358787987;
 Mon, 30 Aug 2021 14:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210830154702.247681585@linutronix.de> <20210830162545.374070793@linutronix.de>
 <YS0ylo9nTHD9NiAp@zn.tnic> <87zgsyg0eg.ffs@tglx> <YS1HXyQu2mvMzbL/@zeniv-ca.linux.org.uk>
In-Reply-To: <YS1HXyQu2mvMzbL/@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Aug 2021 14:26:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgbeNyFV3pKh+hvh-ZON3UqQfkCWnfLYAXXA9cX2iqsyg@mail.gmail.com>
Message-ID: <CAHk-=wgbeNyFV3pKh+hvh-ZON3UqQfkCWnfLYAXXA9cX2iqsyg@mail.gmail.com>
Subject: Re: [patch 01/10] x86/fpu/signal: Clarify exception handling in restore_fpregs_from_user()
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 2:07 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Incidentally, why do we bother with negation in those?  Why not have
> user_insn(), XSTATE_OP() and kernel_insn_err() return 0 or trap number...

I really wish we didn't have that odd _ASM_EXTABLE_FAULT/
ex_handler_fault() special case at all.

It's *very* confusing, and it actually seems to be mis-used. It looks
like the "copy_mc_fragile" code uses it by mistake, and doesn't
actually want that "modify %%rax" behavior of that exception handler
AT ALL.

If I read that code correctly, it almost by mistake doesn't actually
care, and will overwrite %%rax with the right result, but it doesn't
look like the "fault code in %eax" was ever *intentional*. There's no
mention of it.

Maybe I'm misreading that code, but I look at it and just go "Whaa?"

The code in user_insn() clearly *does* use that fault number (and, as
you say, inverts it for some reason), but I wonder how much it really
cares? Could we get rid of it, and just set a fixed error code?

I only checked one user, but that one didn't actually care which fault
it was, it only cared about fault-vs-no-fault.

                Linus

             Linus
