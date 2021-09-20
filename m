Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251644111E6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 11:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhITJ2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 05:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbhITJ2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 05:28:17 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463CFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 02:26:51 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso22666335otv.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 02:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ztJqpqKIFJVTKg15+ChKCf+OE4ZJoAKdKeksq77RwyY=;
        b=JsmIateb4DTvE8XNBNMhWVh85UcXgHNatyLnt9VA/cZgEn8IeS1tTzp4Vxb/L8lHSU
         8jvgefJ6SIPmxzzFHLXxRpl7EJAd6mOvke75Tuhi6PWqYDE43L91g5Q/Ok8sqg0j4dD9
         xh3lI4QieBaLHW1L2tSBYuMYrHWhLXx8IGHMF+ICl9oaIj75wWsmiEuM+vbKs4Ee76ac
         KjT5z4oOK+Kge8YAfA6D1gv5UcX2umzfDsb8WCErjjeuSv7pJjdLMxlgia4r7gZxqVVP
         w5nIrR5dS2i52ao/KkK74AUVfXoBwDnswYRnQU4BZD/ZvK77VDSw2I3fMiof5oTlD3MV
         ZpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ztJqpqKIFJVTKg15+ChKCf+OE4ZJoAKdKeksq77RwyY=;
        b=JJHAFiuhxb1Xsfn2ch9bYHKtzj+017dWgoqC82nkwdQO22R5jtsTtyqeAygcftEsNI
         Gc0ygTqpXsGKHkx/yc5huMHi5sJi0q3KlFOWDyE+PXNByScyBDLN9O+pHp08yyuZ+7zN
         U5ifHyh8aDcC0Dau3eWceJ6jUpoYrXcTOue+aov3AU96vloPZQ4fGNDFTB2JOoSkRZrx
         XCeWN/92e5ikH0+eT4pTnmCHfnfWMWIF+3tTGZhq0auYH6qZ5kaUtyBjDGECjScOM2Ch
         jpYrJH0UoZBU1W3gnu+HnABIcon6bwl0TeoBuahTipeko+/xPu9qDLtDgJGhYfWO5ssS
         wXVw==
X-Gm-Message-State: AOAM532yF2S8Cd7Ck7inw7ZULUePIuNAHBDfMl5KBvLL5GeszJC7TJUe
        j62oeM42MFWU9nw6w/mDsmiJUfeR0KhUf83kSp/xoA==
X-Google-Smtp-Source: ABdhPJzYtiUc9KRJfcV886Q9SwNV/Dt1mfE4wK0NnTaDC4Vs1HEr2fSNzq6Bbb2LI5oQqYCEvgcHKDMn0yUaJrQwI+g=
X-Received: by 2002:a9d:20aa:: with SMTP id x39mr1794305ota.292.1632130010114;
 Mon, 20 Sep 2021 02:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210830172627.267989-1-bigeasy@linutronix.de>
 <CANpmjNPZMVkr5BpywHTY_m+ndLTeWrMLTog=yGG=VLg_miqUvQ@mail.gmail.com> <20210906162824.3s7tmdqah5i7jnou@linutronix.de>
In-Reply-To: <20210906162824.3s7tmdqah5i7jnou@linutronix.de>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Sep 2021 11:26:38 +0200
Message-ID: <CANpmjNPn5rS7MyoDtzJNbs9Gxo=26H_z7CX4UDQcwLRtJfZa6A@mail.gmail.com>
Subject: Re: [PATCH 0/5] kcov: PREEMPT_RT fixup + misc
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Clark Williams <williams@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Sept 2021 at 18:28, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2021-09-06 18:13:11 [+0200], Marco Elver wrote:
> > Thanks for sorting this out. Given syzkaller is exercising all of
> > KCOV's feature, I let syzkaller run for a few hours with PROVE_LOCKING
> > (and PROVE_RAW_LOCK_NESTING) on, and looks fine:
> >
> >     Acked-by: Marco Elver <elver@google.com>
> >     Tested-by: Marco Elver <elver@google.com>
>
> awesome.
>
> > > One thing I noticed and have no idea if this is right or not:
> > > The code seems to mix long and uint64_t for the reported instruction
> > > pointer / position in the buffer. For instance
> > > __sanitizer_cov_trace_pc() refers to a 64bit pointer (in the comment)
> > > while the area pointer itself is (long *). The problematic part is that
> > > a 32bit application on a 64bit pointer will expect a four byte pointer
> > > while kernel uses an eight byte pointer.
> >
> > I think the code is consistent in using 'unsigned long' for writing
> > regular pos/IP (except write_comp_data(), which has a comment about
> > it). The mentions of 64-bit in comments might be inaccurate though.
> > But I think it's working as expected:
> >
> > - on 64-bit kernels, pos/IP can be up to 64-bit;
> > - on 32-bit kernels, pos/IP can only be up to 32-bit.
> >
> > User space necessarily has to know about the bit-ness of its kernel,
> > because the coverage information is entirely dependent on the kernel
> > image. I think the examples in documentation weren't exhaustive in
> > this regard. At least that's my take -- Dmitry or Andrey would know
> > for sure (Dmitry is currently on vacation, but hopefully can clarify
> > next week).

Just for reference, this is what syzkaller does which confirms the above:
https://github.com/google/syzkaller/blob/3d9c9a2ac29573a117cde8ace07d0749eeda991b/executor/executor_linux.h#L84

> okay.

I saw Dmitry responded with Acks/comment. Did you have a tree in mind
to take it through? Usually KCOV changes go through the -mm tree, in
which case please Cc Andrew in the rest of the series.

Thanks,
-- Marco
