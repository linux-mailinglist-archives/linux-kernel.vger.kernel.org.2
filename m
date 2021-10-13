Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37B342CA75
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 21:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhJMT4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 15:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhJMT4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 15:56:33 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CCDC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:54:29 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x27so16567156lfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kv1AJJc4apgDHEZekSLA616qsDySaGD6xxGVlfrlDzs=;
        b=AGWEJ4iVprTucBh+QbMUdUslVJq727rx03gij5ctzZp9RXsw2bB4M1uFmoT/L3CfSV
         /LIsooQyWud7zXzrVaSEF4YQuyL+VOIe4N0f1bZGuV34hyoERvSU2rjyMeU5IyHSIia5
         AN55Q0dRdjk9N2RHCtpC6edPOSz1+2c3p7kqr7M+J9cUwhb9fMyQXw6wklSPhbIHHOWZ
         ZSq5CcES/0o242QHUCLvhT0QDbKj5HUWDCaBQ6S6K1FpoDFoFwuRdOQroPsSLFFMDtQX
         JXxURsAaIeI0bwRJPZ4zqmNoiAuNHggNTX1B/1QLAzTMr6jnyH0m1z9bPL1YpvcGFxWC
         T2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kv1AJJc4apgDHEZekSLA616qsDySaGD6xxGVlfrlDzs=;
        b=Md0XbbcFSjZQpiy5sp3xdM/+s7zIQdIwNm899PiGFfXESx+0/J3nen/IFTxypG3d4T
         qV0+pHMGr22f2qz+++3lVYsjEefxVvJsu37Jq66WvQ7rf74uqXt/twgQ7FHBCvsLP7OX
         EUvapwajSEcDMoPxC049Y3co0uWKkiKH+Rq+RpZFSK5Lag1YrEdDu11S+1O/Du2+fzbh
         S7dPyxLIej+78MG408BSotPmNOeOPjYm9fxRrGafM2VtHmzAo0swoIf5rQcyNsHkDPsu
         wB9gyp2shYb23UPL8hnX7SrS/rC3gT6KkU8pSQYnSL3g+PX8Ffa8T5nJJf1NuRBEtqba
         RycQ==
X-Gm-Message-State: AOAM533uOCK7aCuNu6ooQ9333LVAgmp7m973PwtrXFzrcjm0+Fhgkmdv
        E6EccDjG1lfv4yU3/KH96fxyuHand61vDnxBXljybQ==
X-Google-Smtp-Source: ABdhPJz6kQDWkM0JV4Rx++gZpdlLIYyrAycIprj6NRQujF6dKkQoPvlEk05ygnXxzKntKEB8T27Sz9TOjwga+9c562I=
X-Received: by 2002:a2e:534e:: with SMTP id t14mr1432085ljd.526.1634154867806;
 Wed, 13 Oct 2021 12:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <163369609308.636038.15295764725220907794.stgit@devnote2>
 <163369614818.636038.5019945597127474028.stgit@devnote2> <CAKwvOdkdPHN0Y5GwTPUeaZyjtBttWrfoeLvQJFaJrfOHAtxkHg@mail.gmail.com>
 <20211012231835.522ac7ba366e5019192c1a5a@kernel.org>
In-Reply-To: <20211012231835.522ac7ba366e5019192c1a5a@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 13 Oct 2021 12:54:16 -0700
Message-ID: <CAKwvOdmSX7JcHduY2jF9K80+sFhDNgX0O2DhXCWXYsSNBqPKfA@mail.gmail.com>
Subject: Re: [PATCH 6/8] ARM: clang: Do not relay on lr register for stacktrace
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 7:18 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Nick,
>
> On Mon, 11 Oct 2021 11:45:22 -0700
> Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> >
> > If I change from CONFIG_UNWINDER_ARM=y to
> > CONFIG_UNWINDER_FRAME_POINTER=y, before:
> >
> > # cat /proc/self/stack
> > [<0>] stack_trace_save_tsk+0x50/0x6c
> > [<0>] proc_pid_stack+0xa0/0xf8
> > [<0>] proc_single_show+0x50/0xbc
> > [<0>] seq_read_iter+0x178/0x4ec
> > [<0>] seq_read+0x138/0x15c
> > [<0>] vfs_read+0xd0/0x304
> > [<0>] ksys_read+0x78/0xd4
> > [<0>] sys_read+0xc/0x10
> >
> > after:
> > # cat /proc/self/stack
> > [<0>] proc_pid_stack+0xa0/0xf8
> > [<0>] proc_single_show+0x50/0xbc
> > [<0>] seq_read_iter+0x178/0x4ec
> > [<0>] seq_read+0x138/0x15c
> > [<0>] vfs_read+0xd0/0x304
> > [<0>] ksys_read+0x78/0xd4
> > [<0>] sys_read+0xc/0x10
> > [<0>] __entry_text_start+0x14/0x14
> > [<0>] 0xffffffff
> >
> > So I guess this helps the CONFIG_UNWINDER_FRAME_POINTER=y case? (That
> > final frame address looks wrong, but is potentially yet another bug;
> > perhaps for clang we need to manually store the previous frame's pc at
> > a different offset before jumping to __entry_text_start).
>
> Ah, yes. I didn't touch the UNWINDER_ARM. As you may know the
> unwind_frame()@arch/arm/kernel/stacktrace.c is compiled only
> CONFIG_UNWINDER_FRAME_POINTER=y.

Ah, right, thanks for pointing that out.

> > so likely this fixes/improves CONFIG_UNWINDER_FRAME_POINTER=y? Is that correct?
>
> Yes, that is correct.

In that case, additionally:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
