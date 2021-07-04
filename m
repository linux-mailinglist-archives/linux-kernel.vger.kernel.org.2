Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629E73BAF12
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 22:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhGDUq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 16:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhGDUq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 16:46:56 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BA9C061574
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 13:44:20 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id p24so21777410ljj.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 13:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kP0cbP2YJoKPktOWpMBVQPwBLrKZ9McZaYdUD/h15zQ=;
        b=MbL4wmviJb1hL9n5Li76WzutyWco3aAlQOSe4mKCYVEYQtyvbfFb/7DI7X8mpr49ZP
         5WxiBHEZiCTVhBRHY0tTDTXvkB2JiWjQaudMas64f1WFapJJHUYfvoAUrdsOlG2CcVww
         vCUIPLcQdgQDGfNF4zNSQNCZ8CPwPk6oUaLuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kP0cbP2YJoKPktOWpMBVQPwBLrKZ9McZaYdUD/h15zQ=;
        b=U8MDBUDk3qA4JTQDknuuhwU3NspIS+0HUiKH4C9NGPOXRZbzQ3oZWR1oVr5nu095rj
         7p+7uEPYtsGarrSuGaNbBc/qHVjDXkCFJW/JMNNeNSa3QQO9aLleUULGQeMC0xIdTlUq
         xQSLhpowUmMfczxHwpghwwRuaoqSj4JUovSKrJjEY5RQd+jwDGf9OX9Xeb4bpdZOxlq0
         dP/xAlZePeX/ULyYhtFEb4/DuX7YRrh9Y68t1PLQsvgp64Kz0A4Jmi4OLIXhlP0S8F34
         AHj4e+UDjhbDDqZIh8qVFBX8So3oXb8d9D+/R/cXWy3T76j5vgbBH5kt1R6dpSH0YIFp
         jVKg==
X-Gm-Message-State: AOAM530mme9N+2suqHbUEFGdZFd3HwQwtW3PD1v1lNM1+jmPghK3L69V
        yjwA7Nk5f6Pshpz0hu14zi+zfBuNDqmTVq0V
X-Google-Smtp-Source: ABdhPJxfYMwtrMkb5I5M8xHvTzifxapDdFLz6WD5QfR9aQA26dB8Dk5JQm8ZYk5tdG4W+3sX/oGVhg==
X-Received: by 2002:a2e:9c02:: with SMTP id s2mr8297536lji.299.1625431458768;
        Sun, 04 Jul 2021 13:44:18 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id y8sm877384lfe.112.2021.07.04.13.44.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 13:44:18 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id k21so21758904ljh.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 13:44:18 -0700 (PDT)
X-Received: by 2002:a2e:a276:: with SMTP id k22mr8258122ljm.465.1625431458046;
 Sun, 04 Jul 2021 13:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210704172440.GA2966393@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=whSGHOiuv1yARox+P3k2uTLtJ=F51aKoJYVi5UPgjitCQ@mail.gmail.com> <20210704203201.GT4397@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210704203201.GT4397@paulmck-ThinkPad-P17-Gen-1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Jul 2021 13:44:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=winZfYrRS-dbLT0RkRPJwwQuFDTwrbQiU=krRtsZ5qYGQ@mail.gmail.com>
Message-ID: <CAHk-=winZfYrRS-dbLT0RkRPJwwQuFDTwrbQiU=krRtsZ5qYGQ@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v5.14
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 4, 2021 at 1:32 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Once again, please accept my apologies, and thank you for the explanation.
> I should have sent something like the following, correct?

Correct.  That

> I have done an example merge here:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git merge-example-rcu

makes it trivial for me to just do that "git fetch" and compare what
you did with what I did.

Of course, now I've already pushed out my resolution, so it's too late
(and I've forgotten which files were involved, so I'm too lazy to go
back and check). But hopefully it matches anyway.

             Linus
