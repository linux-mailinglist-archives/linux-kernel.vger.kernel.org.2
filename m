Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9829B44D436
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbhKKJmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbhKKJmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:42:50 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1533C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 01:40:01 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id z2-20020a9d71c2000000b0055c6a7d08b8so8107454otj.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 01:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6/bKopAPmkHa57hfJnxgSr31+HwEgFYE/Py/TQAdG68=;
        b=gkiWiOX8zlm9XT8Og6moU9xIJyu8+w/wkXHcSyju6P6MfcJ+1eMp46rl/6GcYATuSD
         2lPIpohCRFh7xvqOYiub6Ne4RHSEdGx9iFmYpyAsiq3v8QkHfNUJorlkCpu59ecFoyDX
         5cQ+gXFtQLFy6nzBtySiGlpS4F3A0n+VJS6gxzp6HcokIb00BTd0Hc6kjoNNwCCC2c/w
         ZdaDUyw/oqZOrPVWQ0w/HvLeXtkQbp1Qk8FLjaPH5u8mH1zES5uW7Hh7l8usP8LoHwFM
         rbM/lILsGVEEwAsxpEXLBi0WLmXQFnRPjUj7OPMUk81PvcRFPIE0OTrfSX25AJlr9m4G
         0XHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/bKopAPmkHa57hfJnxgSr31+HwEgFYE/Py/TQAdG68=;
        b=Iy3U6rxQjM/zWDSZmoAR1Y+yoP3AAo/CjqulR5pXqRhepYQBB+90lYpS4+V8XzTdys
         +KjVQmYrUX6oDsVuOJveK+y+iGPciXIQgaXk/bASRsbv7YcOyaT0WQp5xXTZrnHsik+P
         6Fo5kjyhdhIF9XHY2hRTPGILCEjVQBcuKS5LZJMGFVrX/+B2KdvUrcYjghQnqECNtwal
         BhMlETuUEhZa6HcEvfcjXIl6FPx9WqH0ggNlL7cUIqb05jmU/N/wo4QDwNVjfZZJ6cij
         ITrbLgwUNHBy9+KEW/QVJjD1oM3VPFZIQbOACnvN+j/yTeNguBx+W6OdxwNmqSMskyIO
         F3OA==
X-Gm-Message-State: AOAM530mz9uMa1BWq9PybCtOqknXaHLK7oK2nybpLih4rSFEu9Q/XjrZ
        o6zk+ARjgq/8Cw/6Cn2V9U9glYcgF1D342IE/lLCEg==
X-Google-Smtp-Source: ABdhPJwHNib4Izwq5VRvwx+F+i/iw/cbi3VPdxj/5KCILWR5ZipAgx6octOLOllqAzJpni78t8/MutpmCyKpGH1Zi1I=
X-Received: by 2002:a9d:77d1:: with SMTP id w17mr4805850otl.329.1636623600901;
 Thu, 11 Nov 2021 01:40:00 -0800 (PST)
MIME-Version: 1.0
References: <20211110202448.4054153-1-valentin.schneider@arm.com>
 <20211110202448.4054153-5-valentin.schneider@arm.com> <YYzeOQNFmuieCk3T@elver.google.com>
In-Reply-To: <YYzeOQNFmuieCk3T@elver.google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 11 Nov 2021 10:39:49 +0100
Message-ID: <CANpmjNPvYZSSLnsg_BGfzb=Yu4bTvCp+N14FHcJfUDjDgzrywg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] kscan: Use preemption model accessors
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linuxppc-dev@lists.ozlabs.org, linux-kbuild@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Nov 2021 at 10:11, Marco Elver <elver@google.com> wrote:
>
> Subject s/kscan/kcsan/
>
> On Wed, Nov 10, 2021 at 08:24PM +0000, Valentin Schneider wrote:
> > Per PREEMPT_DYNAMIC, checking CONFIG_PREEMPT doesn't tell you the actual
> > preemption model of the live kernel. Use the newly-introduced accessors
> > instead.
> >
> > Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>
> Reviewed-by: Marco Elver <elver@google.com>
>
> Though it currently doesn't compile as a module due to missing
> EXPORT_SYMBOL of is_preempt*().
>
> > ---
> >  kernel/kcsan/kcsan_test.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> > index dc55fd5a36fc..14d811eb9a21 100644
> > --- a/kernel/kcsan/kcsan_test.c
> > +++ b/kernel/kcsan/kcsan_test.c
> > @@ -1005,13 +1005,13 @@ static const void *nthreads_gen_params(const void *prev, char *desc)
> >       else
> >               nthreads *= 2;
> >
> > -     if (!IS_ENABLED(CONFIG_PREEMPT) || !IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER)) {
> > +     if (!is_preempt_full() || !IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER)) {

In case you introduce the 5th helper I suggested
(is_preempt_full_or_rt() or whatever you'll call it), this one can be
switched, because this check really does want to know if "at least
full preemption" and not "precisely full preemption".

Thanks,
-- Marco
