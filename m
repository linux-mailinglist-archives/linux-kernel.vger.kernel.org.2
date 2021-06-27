Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EB63B5527
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 22:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhF0UnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 16:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhF0UnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 16:43:24 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FCDC061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 13:40:59 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id k21so1174767ljh.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 13:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2IjlgMeCFRdMCZlLI3QEJu0zVVwjdu1OKk2DAQ8qgU4=;
        b=BEUf41xx09ZOuuhWU57Ba+IyCOdlww3OYanF7tQ7YMOgqNeI0d1QINrF8JgB4gsI4q
         1w8zfOs16qu3nJ0LbO6967CWCazLir7VNab2e2VxvoHpF7Lwei4J6+XicYE3+v1xhok5
         vAalQMXX767aBqACcdQSsGBVBW5IAXfQIZCfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2IjlgMeCFRdMCZlLI3QEJu0zVVwjdu1OKk2DAQ8qgU4=;
        b=KA1UwErlgEB/9Dh0QpEN55Vy6B4vxuP5Vo5AIXbzD1Br92ELSeb3mkYH3Rudx4hyZa
         IFWS0rVOIu8sC7/VW7ftoiBknf+LWYIE9H40T73HBOCCooWgt3bj1b53a1q2ntIA/s+C
         v48xDu0F6VR0F7+Qh1EXd8uRpwnjMpo7W1UzWfnjc7OV17zH/L406Jz3hDnyvDFgrvXH
         Y/LLX+AA4rCJaegdPDZIrxakXzCS+giFu/ukX6rOgOIr1sWN6rJyJ6tiG7jbuXrD8/ky
         +Rd8pY2+YPPiuYeT4YdL2EJWqpiOaIq8A4PZS4KbwlWSd+z1rrqDOprjAUNCbQuFhq7m
         HwUw==
X-Gm-Message-State: AOAM532B+wDgtJurAvk3gcwNpAN9xDz6rZ+qLBLUjbz2MNfCM3ldhdOc
        0ZCA9/8XKBxpEevphuZTTr5bkZZU40TL5Mxp
X-Google-Smtp-Source: ABdhPJxqFpY9MgrluOQBUVfJ+ClYDDjvxj086Us9C6u0EUJk6AI7Os6F85czDOQdUEjwAswyMFXXzQ==
X-Received: by 2002:a2e:b553:: with SMTP id a19mr16975970ljn.507.1624826457569;
        Sun, 27 Jun 2021 13:40:57 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id a42sm1414130ljq.0.2021.06.27.13.40.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jun 2021 13:40:56 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id u13so28044719lfk.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 13:40:56 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr15883494lfs.377.1624826455765;
 Sun, 27 Jun 2021 13:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <YNQwgTR3n3mSO9+3@gmail.com> <CAHk-=wiebYt6ZG4Cp8fWqVnNqxMN4pybDZQ6gwsTWFc0XP=XPw@mail.gmail.com>
 <CAHk-=wgEyk9X5NefUL7gaqXOSDkdzCEDi6RafxGvG+Uq8rGrgA@mail.gmail.com>
In-Reply-To: <CAHk-=wgEyk9X5NefUL7gaqXOSDkdzCEDi6RafxGvG+Uq8rGrgA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Jun 2021 13:40:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJq0Ns7_AFRW+rvZcD_m+1t5cYgvQRO-Gbp8TEK1x1bQ@mail.gmail.com>
Message-ID: <CAHk-=wiJq0Ns7_AFRW+rvZcD_m+1t5cYgvQRO-Gbp8TEK1x1bQ@mail.gmail.com>
Subject: Re: [GIT PULL] sigqueue cache fix
To:     Ingo Molnar <mingo@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2021 at 11:52 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ok, I may have confused myself looking at all this, but it does all
> make me think this is dodgy.

I also couldn't convince myself that the memory ordering is correct
for the _contents_ of the sigqueue entry that had its pointer cached,
although I suspect that is purely a theoretical concern (certainly a
non-issue on x86).

So I've reverted the sigqueue cache code, in that I haven't heard
anything back and I'm not going to delay 5.13 over something small and
easily undone like this.

It could be that my worries about this code are all entirely wrong,
and I'm missing something, in which case you can call me names and we
can reinstate the code with my apologies.

Anyway, I tried to distill my thoughts about what is going on - and
what the solutions might be - in the revert commit b4b27b9eed8e.

Again, maybe it's just me that is confused. But reverting seemed to be
the safest thing to do considering the timing of this all.

           Linus
