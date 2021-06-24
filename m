Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB033B37A2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 22:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhFXUOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 16:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbhFXUOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 16:14:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B6AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 13:11:42 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h17so10278660edw.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 13:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dpe9lEwhUIwO0xWlospxCxEaXe3xRtOW0AcnGSWOsWM=;
        b=V94FyFfUNYCwwe5Eb2/5kXStEjd/SAXTGvq9l3G716GpB3crhuLMAj4BaMF1jfEK7l
         hV9Mh/oX2jaBezpijTHMrktNaoBzZ2MLDXYRj+Z1Tsy6ssSFue4MMET/K4ItVOa7I6ly
         u5rW/mU/nBnbe/kLYL8ohoz+2IaV4nvB4PYLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dpe9lEwhUIwO0xWlospxCxEaXe3xRtOW0AcnGSWOsWM=;
        b=L/0A2h5cMXCCHvSF/sBEpkJvLkczQSgWlzUU1wD29PJF1i9ct0wZlE8JYZY+O11hu0
         ySHywxnDaWDpZqSxot2NlupdUEhPf6AC+DbR6Pz9Mid6/EaPpfjQO3ZqSFhgyUuxtIuL
         eBaKwohPeKunagr75Sfk125oSoFUIEkNkeXOQHco3BuJSYBdHQL5U48Lpir9ok+TrMnL
         nb89vym5VGpm+peh2gEdJ6B0vCNo9QP0owNPPvglaYrFFsOXa3RA7IQWYZB/b3lQWsFP
         epZfeketh65tqqWHJhJdqFNh6mhNi7TOVbXvYjcMs8rhj2AlAc7veq3dpvLcZoDYeYyn
         pNag==
X-Gm-Message-State: AOAM5321QhyiEJEKrzYC/4OYnPtipFoGf/Pccg0KaZW0t+cae5nsVyRo
        uEJ7gKtGbyF338jjp+yxhtUNWZ9RCocl0siDgL4=
X-Google-Smtp-Source: ABdhPJwK457s1su5i06Vm32k1rB4v2C+S8Fcn3hpdVvzXMWnOW8jFC18YjonYj7R4ou0+jfTdQGZog==
X-Received: by 2002:a05:6402:1581:: with SMTP id c1mr9643991edv.213.1624565501099;
        Thu, 24 Jun 2021 13:11:41 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id b27sm1632156ejl.10.2021.06.24.13.11.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 13:11:40 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id gn32so11445159ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 13:11:38 -0700 (PDT)
X-Received: by 2002:a2e:850e:: with SMTP id j14mr3525901lji.251.1624565080001;
 Thu, 24 Jun 2021 13:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
 <87sg1lwhvm.fsf@disp2133> <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
 <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com> <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
 <87eed4v2dc.fsf@disp2133> <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133> <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
 <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk> <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
 <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
 <87a6njf0ia.fsf@disp2133> <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
 <87tulpbp19.fsf@disp2133> <CAHk-=wi_kQAff1yx2ufGRo2zApkvqU8VGn7kgPT-Kv71FTs=AA@mail.gmail.com>
 <87zgvgabw1.fsf@disp2133> <875yy3850g.fsf_-_@disp2133> <87czsb6q9r.fsf_-_@disp2133>
In-Reply-To: <87czsb6q9r.fsf_-_@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Jun 2021 13:04:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2OpVrBD38A5Re4=rSSWnjwg3GcmsxtAPeHVSmQZy1VA@mail.gmail.com>
Message-ID: <CAHk-=wi2OpVrBD38A5Re4=rSSWnjwg3GcmsxtAPeHVSmQZy1VA@mail.gmail.com>
Subject: Re: [PATCH 4/9] signal: Factor start_group_exit out of complete_signal
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't really mind the patch, but this patch doesn't actually do what
it says it does.

It factors out start_group_exit_locked() - which all looks good.

But then it also creates that new start_group_exit() function and
makes the declaration for it, and nothing actually uses it. Yet.

I'd do that second part later when you actually introduce the use in
the next patch (5/9).

Hmm?

           Linus
