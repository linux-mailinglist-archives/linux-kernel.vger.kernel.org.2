Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE9345CC15
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243617AbhKXSdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242028AbhKXSdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:33:53 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB4AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:30:43 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x15so14504707edv.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rk+AlpGcWXOn0jJy7gXmJFRPJ9LtcDgb5+HdVybtfio=;
        b=WDrUmjayExupIlc4LKgLeFnha+BDgXG30EdWp/nPVL+6oAGLev2vpCCxYTTLrhCtjh
         y/8/zun/OyvzaOxxceZWgsCQUtMxiQNbXCR1Dp7ZSRmRGtgJ5V17STaplBe3sGNPaMT6
         TRqVR7o9UvXUasy4PqyfY8sbKuQ4UdopP8pZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rk+AlpGcWXOn0jJy7gXmJFRPJ9LtcDgb5+HdVybtfio=;
        b=k+Hu35HyEBtZzn51Uslc0FvtI0i6HuGYAQiqwPPGP5qvc8PohwmfriXXPfxDdEw8oo
         FZE6ch8ETrGxe5O20hCVTJTPnOQ6fDrF+HgnuL8FTfEDn/jcIdfq59zMptcAaWadnWV5
         0kTKO6THeM1wXIlDuFrRnfxfzI8M5E8lmj+7vfYswP69ZmrADAkT8i0F0QcMq3uufouR
         6Q4hKjQ5L5xr6HsA8ZryBItiG6OrMde5dQqtU2J+gDNuiv1JwdLCKen3jKCU0WTxsZqi
         3hzR4B5bbZxVaQD/rmFa50I3eZfYcXeZol5HOEychd8CgjTBgG0OYgZokVjR3zece/Mi
         iatQ==
X-Gm-Message-State: AOAM532JHsMB6lO7aOExxlFtao0xPmoK1ExZfObUTcxhWKVySwJl8wGR
        IqqQRjRdYkk053mQN2294D+xfwAuO4AyNBXR
X-Google-Smtp-Source: ABdhPJy0dry0nNWqF5ylcQppYgK65yUfb83R0qGHS1Ia97dOUG3AcLspWxi766U/okkO+5mJH+4LoA==
X-Received: by 2002:a05:6402:1d50:: with SMTP id dz16mr28288782edb.385.1637778641072;
        Wed, 24 Nov 2021 10:30:41 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id q7sm444604edr.9.2021.11.24.10.30.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 10:30:40 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so6254839wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:30:40 -0800 (PST)
X-Received: by 2002:a05:600c:4e07:: with SMTP id b7mr18319493wmq.8.1637778640102;
 Wed, 24 Nov 2021 10:30:40 -0800 (PST)
MIME-Version: 1.0
References: <20211124100956.6905a198@gandalf.local.home> <CAHk-=wjakjw6-rDzDDBsuMoDCqd+9ogifR_EE1F0K-jYek1CdA@mail.gmail.com>
In-Reply-To: <CAHk-=wjakjw6-rDzDDBsuMoDCqd+9ogifR_EE1F0K-jYek1CdA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Nov 2021 10:30:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=whYWvdKrFY3-xcRFqyxAMnhMGsmU=0gYWYWuRrR7mFV-A@mail.gmail.com>
Message-ID: <CAHk-=whYWvdKrFY3-xcRFqyxAMnhMGsmU=0gYWYWuRrR7mFV-A@mail.gmail.com>
Subject: Re: [GIT PULL] tracing/uprobe: Fix uprobe_perf_open probes iteration
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 10:27 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Instead, you should do something like
>
>         list_for_each_entry(pu, trace_probe_probe_list(tp), tp.list) {

That 'pu' is a typo, it should be 'tu'.

The patch itself got it right, I think.

HOWEVER. Despite the patch itself getting it right, I want to point
out that that was mostly by luck than anything else.

The patch is ENTIRELY UNTESTED.

Because that's how I roll, as you should all know by now.

                  Linus
