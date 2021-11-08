Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BB0449C05
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 19:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbhKHS4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 13:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236233AbhKHS43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 13:56:29 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A96C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 10:53:44 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 207so13187052ljf.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 10:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ChbQr5dmryeBqZbjzLYHzYVaRx/29ISxTF05QE1qZTA=;
        b=ecYtcpuTXEo93YuV6xgTpilVQgGCInTceXwxEaPYwn2jxSV2O3ap48L/1ESonyya60
         fpRdYAnTqArP9m+XRjSBBuGiR0lLdJ8RQwus4bnS0SHc/QqmWmhg8EvUClscQbftHNj0
         e+7GGx1Osd0Sx+zJH9ylzuqdB68HAWxXII8gN0y1fwYEfPkzSAXGEczewG63YcqZXY6z
         1H5aUUP5lZDSBLBFDYCttIqf8BuXCTOZMx6LKo+dCm7fd2XOilV4oSsJA4dIPlf5fS6U
         mzM57Bzgjs0pJe5qYHagkPxK2VIhXPZH9v61CzYXA1tk9omTmCjxtOmar8lVoCD9M+EH
         fuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ChbQr5dmryeBqZbjzLYHzYVaRx/29ISxTF05QE1qZTA=;
        b=sUCBZK/bkeLyx2GFmckbS13moQQNG6HKx1MwX0+KpR2dOC5FjPvq9Tua8t3Tg5c4yP
         vFDS2ADEZUhK4SbaqLKPllrFQ061Lev7UCepT/XtKF3KZ999vl2z71BGtRpV1y3Do6N7
         mHh6f0lyhOZG9Nl4DIIAOftCmMc3iwMVbcJG2zhTF0K4EE+1LDv5a2ykp/eYqvpdNEmA
         +X7D8Wocpbvh4JTJFvezlRFBlsR16G1yLfG1q7+f5uGIS2nMUx5VHQcQyTsxjqcjhgf+
         WS6OKNjFX/n3YTlqmFc5+MqQLLKAYTcq0LAc9X7mcO2K8rdLDMVqLNODEfCYQo5Jjn4z
         bxxQ==
X-Gm-Message-State: AOAM530XYXWGMvU7jAu+cID1LrzmSYNLk7hfNu33fWeuJsg/1xKnCGdP
        SGxoAaaI49yoGUCHb8+MgqS6YqeVVko1lLKOjJ8dEQhIDavwYA==
X-Google-Smtp-Source: ABdhPJyJ3q66yAAhlqNGOl7hpVH8Z6xvpeVsO2wRyNVME2kXeftFS3hdQu1yQ+mUc3vIohqTZGirJrt3NwvEk3vWkog=
X-Received: by 2002:a05:651c:889:: with SMTP id d9mr1230796ljq.198.1636397622550;
 Mon, 08 Nov 2021 10:53:42 -0800 (PST)
MIME-Version: 1.0
References: <20211105171023.989862879@infradead.org> <20211105171821.654356149@infradead.org>
 <20211108164711.mr2cqdcvedin2lvx@treble> <YYlshkTmf5zdvf1Q@hirez.programming.kicks-ass.net>
In-Reply-To: <YYlshkTmf5zdvf1Q@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 8 Nov 2021 10:53:31 -0800
Message-ID: <CAKwvOdkFZ4PSN0GGmKMmoCrcp7_VVNjau_b0sNRm3MuqVi8yow@mail.gmail.com>
Subject: Re: [PATCH 20/22] x86,word-at-a-time: Remove .fixup usage
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 8, 2021 at 10:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 08, 2021 at 08:47:11AM -0800, Josh Poimboeuf wrote:
> > On Fri, Nov 05, 2021 at 06:10:43PM +0100, Peter Zijlstra wrote:
> > > +static inline unsigned long load_unaligned_zeropad(const void *addr)
> > > +{
> > > +   unsigned long offset, data;
> > > +   unsigned long ret;
> > > +
> > > +   asm_volatile_goto(
> > > +           "1:     mov %[mem], %[ret]\n"
> > > +
> > > +           _ASM_EXTABLE(1b, %l[do_exception])
> > > +
> > > +           : [ret] "=&r" (ret)
> > > +           : [mem] "m" (*(unsigned long *)addr)
> > > +           : : do_exception);
> > > +
> > > +out:
> > > +   return ret;
> > > +
> > > +do_exception: __cold;
> >
> > Clang doesn't approve of this label annotation:
> >
> > In file included from fs/dcache.c:186:
> > ./arch/x86/include/asm/word-at-a-time.h:99:15: warning: '__cold__' attribute only applies to functions [-Wignored-attributes]
> > do_exception: __cold;
>
> /me mutters something best left unsaid these days...
>
> Nick, how come?

Looks like https://bugs.llvm.org/show_bug.cgi?id=47487.
-- 
Thanks,
~Nick Desaulniers
