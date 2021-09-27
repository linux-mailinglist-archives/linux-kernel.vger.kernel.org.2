Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2883041965B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbhI0O3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbhI0O3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:29:21 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882B9C061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 07:27:43 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id y201so25840842oie.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 07:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BJaeBZR1ukPhFab40rWKUHXJrPsphnS82O6jrdz2Xw0=;
        b=iHznPaFlNIO7bGrsW9wrrPUIy5ABWvAV5PFkNjSxvpEDGoGZ7AIBUnkK1NcgW+z4nz
         KfQnqQ9CYAy2GI8+KN1/NfMC31F2APA/pQSjitkmReIxTDwp+B5jaQQV0iEVWi+5ay8E
         THKpXEEeApH8ddipCKtIp0gUaDmsgVtkO2IEzfsjAA5uTWSFTzZHzEmE4pocFWW5+Byu
         BZ/FqsT9bPAKX02s6slaiWfGZ+7LJeWY3+5vOHgfimx5ci5pkISbaLY9v+1m7hFn+fyr
         3qJaJR6QrgnXsvxsnl/w+0tzYpcAV6f/rDY0gEwq9XxEBX+Jw7tpOpzKZfFmLQiHaYfM
         X9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJaeBZR1ukPhFab40rWKUHXJrPsphnS82O6jrdz2Xw0=;
        b=J7WhtJ2LmLSFOsReR1stIBIWHcYV1zeCY7o/8uuD6op9F3gf7J24XbONVA8ONvpZgA
         aLdS0xDN2WBqov26B3E0/cl3nJxdgc99dN2qrsUyOpQr4wJ4n/o1OX5vdmespSGR2Bor
         GKdGhKIrufa/w7yWZSZ2eILlN2RV2hr5t4wLzSG3x2AC3Ly451GCPJ90cbIxJ8g6cuLu
         KMG/pZ4N6+EeFMMZku74EDaW9KVGIFio2+c1dXujydGtanCDxDTLjYFRSM78gZYDnVTB
         DvgGuqWHTFclO6mlgsGhhrrWnTP1owinNCQ+Ks0iW3yqVekBw7HhmWZfHinx7VrDqU1I
         10CQ==
X-Gm-Message-State: AOAM531/A/Pu5B/qf0nFbXGW9/jXlNsHCObqco5s9UmTee+tv8Wq9CdX
        vP9kfYI8N7mmnojoPViQKRVnngTXXgoTDBupFqaScw==
X-Google-Smtp-Source: ABdhPJz9/NRsaWFDA/horHjweSEQQrL4X2rQGDnxj9r6kHkjyuWKJ67Bwsly4sQS+7L//cItDmxrLNdvKOzuEAXUVWQ=
X-Received: by 2002:aca:f189:: with SMTP id p131mr12164711oih.128.1632752862007;
 Mon, 27 Sep 2021 07:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a3cf8605cb2a1ec0@google.com> <CACT4Y+aS6w1gFuMVY1fnAG0Yp0XckQTM+=tUHkOuxHUy2mkxrg@mail.gmail.com>
 <20210921165134.GE35846@C02TD0UTHF1T.local>
In-Reply-To: <20210921165134.GE35846@C02TD0UTHF1T.local>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 27 Sep 2021 16:27:30 +0200
Message-ID: <CACT4Y+ZjRgb57EV6mvC-bVK0uT0aPXUjtZJabuWasYcshKNcgw@mail.gmail.com>
Subject: Re: [syzbot] upstream test error: KASAN: invalid-access Read in __entry_tramp_text_end
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     syzbot <syzbot+488ddf8087564d6de6e2@syzkaller.appspotmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sept 2021 at 18:51, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Dmitry,
>
> The good news is that the bad unwind is a known issue, the bad news is
> that we don't currently have a way to fix it (and I'm planning to talk
> about this at the LPC "objtool on arm64" talk this Friday).
>
> More info below: the gist is we can produce spurious entries at an
> exception boundary, but shouldn't miss a legitimate value, and there's a
> plan to make it easier to spot when entries are not legitimate.
>
> On Fri, Sep 17, 2021 at 05:03:48PM +0200, Dmitry Vyukov wrote:
> > > Call trace:
> > >  dump_backtrace+0x0/0x1ac arch/arm64/kernel/stacktrace.c:76
> > >  show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:215
> > >  __dump_stack lib/dump_stack.c:88 [inline]
> > >  dump_stack_lvl+0x68/0x84 lib/dump_stack.c:105
> > >  print_address_description+0x7c/0x2b4 mm/kasan/report.c:256
> > >  __kasan_report mm/kasan/report.c:442 [inline]
> > >  kasan_report+0x134/0x380 mm/kasan/report.c:459
> > >  __do_kernel_fault+0x128/0x1bc arch/arm64/mm/fault.c:317
> > >  do_bad_area arch/arm64/mm/fault.c:466 [inline]
> > >  do_tag_check_fault+0x74/0x90 arch/arm64/mm/fault.c:737
> > >  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
> > >  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
> > >  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
> > >  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
> > >  __entry_tramp_text_end+0xdfc/0x3000
> >
> > /\/\/\/\/\/\/\
> >
> > This is broken unwind on arm64. d_lookup statically calls __d_lookup,
> > not __entry_tramp_text_end (which is not even a function).
> > See the following thread for some debugging details:
> > https://lore.kernel.org/lkml/CACT4Y+ZByJ71QfYHTByWaeCqZFxYfp8W8oyrK0baNaSJMDzoUw@mail.gmail.com/
>
> The problem here is that our calling convention (AAPCS64) only allows us
> to reliably unwind at function call boundaries, where the state of both
> the Link Register (LR/x30) and Frame Pointer (FP/x29) are well-defined.
> Within a function, we don't know whether to start unwinding from the LR
> or FP, and we currently start from the LR, which can produce spurious
> entries (but ensures we don't miss anything legitimte).
>
> In the short term, I have a plan to make the unwinder indicate when an
> entry might not be legitimate, with the usual stackdump code printing an
> indicator like '?' on x86.
>
> In the longer term, we might be doing things with objtool or asking for
> some toolchain help such that we can do better in these cases.

Hi Mark,

Any updates after the LPC session?

If the dumper adds " ? ", then syzkaller will strip these frames
(required for x86).
However, I am worried that we can remove the true top frame then and
attribute crashes to wrong frames again?

Some naive questions:
1. Shouldn't the top frame for synchronous faults be in the PC/IP
register (I would assume LR/FP contains the caller of the current
frame)?
2. How __entry_tramp_text_end, which is not a function, even ended up
in LR? shouldn't it always contain some code pointer (even if stale)?
3. Isn't there already something in the debug info to solve this
problem? Userspace programs don't use objtool, but I assume that can
print crash stacks somehow (?).
