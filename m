Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCA1410138
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 00:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245556AbhIQW0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 18:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbhIQW0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 18:26:31 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9D5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 15:25:09 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id b15so11830598ils.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 15:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HEiuXk7HkKliOr+ibi8O2+f6q032THEBfR9Xzj70n0Y=;
        b=CqzQEPt/32deaT5IQGJKdhd0QOv+Wod37sD+PfFdQU8nBl2WlQjV21rMMI1w6qkKeJ
         kI0OlEOrPqtcmNNhWTi/0RLvOtN0XJCvPJReuv4dPpazZuRvfydn4IHgUFqMhdb2LgaM
         95Na2KuEuuBu/pbx1wjyuMFe6l6hqBXBDr7mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HEiuXk7HkKliOr+ibi8O2+f6q032THEBfR9Xzj70n0Y=;
        b=0z12/mT/Oay2u3E3rW1YUa1FmK2GJqjkGQ7AIfMlewkUNMI7hBn1FOLpeY9kpxA9h7
         Vnj1QzCMJhFe2hbNRVcAv62IR09xKXhe6eS61yMSc7LaphxKYKvhTUZtFPK8kEzJP0c+
         gJ1W7WIG2sGhqDm8K4w54Qvh32Lx0xcCWpf3t+RTtLrE58lkvPKgMd6+PBZpF+NA20WY
         igbpHR43Rdcu0zpPLLLCAVKxc2d1AfoJx42HHrwGh6XxvAVY8WzMnW7mc1eC0d8g6qP7
         qGtAj1wLqs9yQW8/mMQglB6IVhEtutMNF37UAvNLssg/4t+YgTC22RTm8eBtKSbEX8VS
         b3iQ==
X-Gm-Message-State: AOAM53171i7oHjifW+ON6+1Z6SYRrPOWiPrto60cgVxA0HPOJTjx+bS0
        7gmciVK95YvxsrYgZq2I8O+kGp1Hb8IRM8dXqmE=
X-Google-Smtp-Source: ABdhPJwOBcOAGQV9WUp/0uALD0z6VL8IUh6yCufWIN4jAcxNlTopJP0Z5wRx2NwVjPiKZ3JG0RSARw==
X-Received: by 2002:a92:d2d1:: with SMTP id w17mr9609952ilg.145.1631917508309;
        Fri, 17 Sep 2021 15:25:08 -0700 (PDT)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id c84sm1346519iof.5.2021.09.17.15.25.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 15:25:08 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id x2so11814573ila.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 15:25:07 -0700 (PDT)
X-Received: by 2002:a92:6a05:: with SMTP id f5mr9364986ilc.140.1631917507704;
 Fri, 17 Sep 2021 15:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <202109151423.43604.linux@zary.sk> <202109162227.17415.linux@zary.sk>
 <20210916210509.GG4323@worktop.programming.kicks-ass.net> <202109171011.31916.linux@zary.sk>
 <YURdxNpH8YNQZQT7@hirez.programming.kicks-ass.net> <CAHk-=wj_-bRjcJdXubdUUsTph+DH-5f77FmkbNCfFVYg=Td2zw@mail.gmail.com>
In-Reply-To: <CAHk-=wj_-bRjcJdXubdUUsTph+DH-5f77FmkbNCfFVYg=Td2zw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Sep 2021 15:24:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whsG4LfNJHjeprDn0iR=zRGBUBtSSgLep=MqbEb8yBuuA@mail.gmail.com>
Message-ID: <CAHk-=whsG4LfNJHjeprDn0iR=zRGBUBtSSgLep=MqbEb8yBuuA@mail.gmail.com>
Subject: Re: [PATCH] x86/iopl: Fake iopl(3) CLI/STI usage
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ondrej Zary <linux@zary.sk>, Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 3:23 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think the proper thing to do is perhaps something like

The alternative is to just ignore cs_abse entirely, and just use
"regs->ip", which makes this all even easier.

If somebody uses a code segment _and_ cli/sti, maybe they should just
get the SIGSEGV?

               Linus
