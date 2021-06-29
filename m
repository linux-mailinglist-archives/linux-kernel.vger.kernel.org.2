Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307383B796A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 22:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbhF2Ug2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 16:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbhF2Ug1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 16:36:27 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A12C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 13:33:58 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id n14so613869lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 13:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fhJdI23bnQTsJQkSv7/yJhByjF9cS8kb5VpeCaNIpgY=;
        b=EPJAHNutQ9iqxU3YC3gGirOdY6LcOSsoptGbcsa3ezTIi/byqkNjxmeo7mQf9v7aml
         gFoXNIXI4TVJUQnPhtOPQEiBWEyU4c0yEbh0cO7fouErX6C0a7lJ+uzQJhA54Er7WR/R
         NVf94tbIri27NQIuLHPMB7ppxiMo5jePufcuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fhJdI23bnQTsJQkSv7/yJhByjF9cS8kb5VpeCaNIpgY=;
        b=SwoaUKz/pDftEhar6CyHnUUzo6U+CobCqG9eBFzCTn0PqnRHMSjMcGQ4WLq9Toz9E/
         0xzFmy5nEe9Dg1yEevRXEbJrBXOsRyEfN69ASIxU2mrFi6UCCPRQcWsfO8ioOx3zIBcr
         Y7VhOsi7CoKhqM6t4WSu3BQkLHoH83bmwhQelRLN5m3Y3ad4Jqle7CmQaxqEMxxpseXy
         07iH11L8w7ZlgjR5FtHS0ANT81d0aKvI8cPdrHk3wwf1arkwwwf7k9oQ1z2XxX0MAsfR
         8AS9bnpupMNMug6hYtRq78Hw5DAy8xf3LhXZTl3IajlGFv8Zbg2EUcJi6LF7Kgv/26pW
         l5QQ==
X-Gm-Message-State: AOAM530w+1YB3ilVR5pcgQG8FWVU1d2ppzp0XwMHMh7ZxE0NaSHxlcOq
        4JD7mYrFI4Y4UlGTjHl6kFgKM8pD/PizSFfvlZo=
X-Google-Smtp-Source: ABdhPJwHSYuZRPYxhD54zkRdiLRdKnvuqs3UGWxUjL9Ylc6qZCkFDSJepncOqOXcPEVB89KzLjcqlA==
X-Received: by 2002:a05:6512:3a2:: with SMTP id v2mr23955834lfp.651.1624998836322;
        Tue, 29 Jun 2021 13:33:56 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id u8sm2147261lje.99.2021.06.29.13.33.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 13:33:55 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id q16so650178lfr.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 13:33:55 -0700 (PDT)
X-Received: by 2002:ac2:42d6:: with SMTP id n22mr24286252lfl.41.1624998835628;
 Tue, 29 Jun 2021 13:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <87fsx1vcr9.fsf@disp2133> <CAHk-=wj1z-NKxedgZvSS37iH=EKE47PkL=+BYccAUtsuB1sySQ@mail.gmail.com>
 <20210629171757.shyr222zjpm6ev5t@example.org> <CAHk-=wgcpK3XdFKJ98b_YucXbQMJMgJssAk=sQ-XUo-tyiMjVg@mail.gmail.com>
 <20210629202028.gduluywejae75icj@example.org>
In-Reply-To: <20210629202028.gduluywejae75icj@example.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Jun 2021 13:33:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjQks3o_3=WewaXw++h+a318B3LTLSFER9Ee4n1pLCZLw@mail.gmail.com>
Message-ID: <CAHk-=wjQks3o_3=WewaXw++h+a318B3LTLSFER9Ee4n1pLCZLw@mail.gmail.com>
Subject: Re: [GIT PULL] ucounts: Count rlimits in each user namespace
To:     Alexey Gladkov <legion@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 1:20 PM Alexey Gladkov <legion@kernel.org> wrote:
>
> Waaaait. task_ucounts() is a different thing. This function only gets a
> field from the task structure without any reference counting. But the
> get_ucounts() is more like get_user_ns() or get_uid(), but does not ignore
> counter overflow.

Alexey, that code cannot be right.

Look here:

        rcu_read_lock();
        ucounts = task_ucounts(t);
        sigpending = inc_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING, 1);
        if (sigpending == 1)
                ucounts = get_ucounts(ucounts);
        rcu_read_unlock();

so now we've done that inc_rlimit_ucounts() unconditionally on that
task_ucounts() thing.

And then if the allocation fails (or the limit is hit) the code does

        if (ucounts && dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING, 1))
                put_ucounts(ucounts);

ie now it does the dec_rlimit_ucounts _conditionally_.

See what I'm complaining about? This is not logical, AND IT CANNOT
POSSIBLY BE RIGHT.

My argument is that

 (a) the dec_rlimit_ucounts() has to pair up with
inc_rlimit_ucounts(), or you're leaking counts

 (b) get_ucounts() has to pair up with put_ucounts().

Note that (a) has to be REGARDLESS of whether get_ucounts() was
successful or not.

> Earlier I tried to use refcount_t which never returns errors [1]. We
> talked and you said that ignoring counter overflow errors is bad
> design for this case.

You can't ignore counter overflow errors, no. But that's exactly what
that code is doing.

If get_ucount() fails due to overflow, you don't return an error. You
just miscount the end result!

So yeah, its' "testing" the overflow condition, but that's not an
argument, when it then DOES EXPLICITLY THE WRONG THING.

At that point, the test is actively harmful and wrong. See?

             Linus
