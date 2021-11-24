Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6E945C903
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 16:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242046AbhKXPpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 10:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344184AbhKXPpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 10:45:30 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579FDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:42:20 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id v1so12394488edx.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jT8/yelHGFwd2Lw6VKG0z3IRlE5vjO9avWv+uYPPcww=;
        b=FQ6xxxgKYmBVLacy2DFfPH+JSOLhRBzDeoAPgLsajEQ8ipqK093Kb7IMRB/YK/p49B
         2UQdlG3cYvgv9TXOjMLljUAuGeuCp1W404zwgNo7rLqET8NrAj0+hMVLJNoGIbqVozVX
         wKqMzactuWtwg7esPPS9xJuZKpKn75dIE5yxJOcsoIf9o6dnPpn0lxL1egys/cQqvJI6
         PoKUSfrNCokkWgIyeMOsoPOlpwrpWqBrhGBsmYvO4a7UXmaMWAWHV6tUnyxCzNSxWkGS
         +DqY7PNW8TAB1Pkp5uhE35oF4a1AS4gVXwWI4qEDQNIv2YErwbWOJena2HxmOWuLl+jo
         9ADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jT8/yelHGFwd2Lw6VKG0z3IRlE5vjO9avWv+uYPPcww=;
        b=yebalL3oN7uIgdB5jCR4EBObfxiLXASSlwl54vVKC5Tccx/kLBnd4rt/WIqmN4UHJ2
         WeGz5aOPlvq4QlnUtHR8rYPvuCXL8Nn89EjL+6NJ4/7PknkGcVm+uf8nmHaz12325kpm
         vK6mI24m7Vi5LqEAPbierN8m2gOoc26ujfeBi8D8oq7waudON/VKmUKNM9DGhIfc0ZTF
         ueysFq8lRbdv3YEC5qCmJrVpXftjoe5mr9/Ksoi0KuGiuquVAbTGP7mjxB+drvoW+itA
         tnSGHXyFSeeZp1+RtLw2wTykMBxAbHsqJ7iRmycQgTFeuuTHneAZGBf38ByiiroFq34H
         a28g==
X-Gm-Message-State: AOAM533nH2DPY/kfM1UnCbnrdHihOXrO7ZeBuvNSgxhbTFQ2Oom2WWpD
        xUDvMTCqIzqhNvWpbElMgZIEEFORtBCg/ope4zml/jZm3A==
X-Google-Smtp-Source: ABdhPJyLY1HZ0vawQLmBdMN1N3oDlIvFKNQsc4Gch3xXwhFbu6QljSU4BaeCX+TOryZsnkD/f2m0RkpRedDiyy1g+Iw=
X-Received: by 2002:a05:6402:11d2:: with SMTP id j18mr26066574edw.318.1637768538666;
 Wed, 24 Nov 2021 07:42:18 -0800 (PST)
MIME-Version: 1.0
References: <20211123075001.3676-1-zhaozixuan2@huawei.com>
In-Reply-To: <20211123075001.3676-1-zhaozixuan2@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 24 Nov 2021 10:42:07 -0500
Message-ID: <CAHC9VhS-pPDWBRX-6q7aj1Fj5oU0M2vgJC0ipTStczYGkFVvwg@mail.gmail.com>
Subject: Re: [PATCH] audit: accelerate audit rule filter
To:     Zixuan Zhao <zhaozixuan2@huawei.com>
Cc:     eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 2:50 AM Zixuan Zhao <zhaozixuan2@huawei.com> wrote:
> We used lat_syscall of lmbench3 to test the performance impact of this
>  patch. We changed the number of rules and run lat_syscall with 1000
>  repetitions at each test. Syscalls measured by lat_syscall are not
>  monitored by rules.
>
> Before this optimization:
>
>              null     read    write     stat    fstat      open
>   0 rules  1.87ms   2.74ms   2.56ms   26.31ms  4.13ms   69.66ms
>  10 rules  2.15ms   3.13ms   3.32ms   26.99ms  4.16ms   74.70ms
>  20 rules  2.45ms   3.97ms   3.82ms   27.05ms  4.60ms   76.35ms
>  30 rules  2.64ms   4.52ms   3.95ms   30.30ms  4.94ms   78.94ms
>  40 rules  2.83ms   4.97ms   4.23ms   32.16ms  5.40ms   81.88ms
>  50 rules  3.00ms   5.30ms   4.84ms   33.49ms  5.79ms   83.20ms
> 100 rules  4.24ms   9.75ms   7.42ms   37.68ms  6.55ms   93.70ms
> 160 rules  5.50ms   16.89ms  12.18ms  51.53ms  17.45ms  155.40ms
>
> After this optimization:
>
>              null     read    write     stat    fstat      open
>   0 rules  1.81ms   2.84ms   2.42ms  27.70ms   4.15ms   69.10ms
>  10 rules  1.97ms   2.83ms   2.69ms  27.70ms   4.15ms   69.30ms
>  20 rules  1.72ms   2.91ms   2.41ms  26.49ms   3.91ms   71.19ms
>  30 rules  1.85ms   2.94ms   2.48ms  26.27ms   3.97ms   71.43ms
>  40 rules  1.88ms   2.94ms   2.78ms  26.85ms   4.08ms   69.79ms
>  50 rules  1.86ms   3.17ms   3.08ms  26.25ms   4.03ms   72.32ms
> 100 rules  1.84ms   3.00ms   2.81ms  26.25ms   3.98ms   70.25ms
> 160 rules  1.92ms   3.32ms   3.06ms  26.81ms   4.57ms   71.41ms
>
> As the result shown above, the syscall latencies increase as  the number
>  of rules increases, while with the patch the latencies remain stable.
>  This could help when a user adds many audit rules for purposes (such as
>  attack tracing or process behavior recording) but suffers from low
>  performance.

I have general concerns about trading memory and complexity for
performance gains, but beyond that the numbers you posted above don't
yet make sense to me.

Why are the latency increases due to rule count not similar across the
different syscalls? For example, I would think that if the increase in
syscall latency was directly attributed to the audit rule processing
then the increase on the "open" syscall should be similar to that of
the "null" syscall.  In other phrasing, if we can process 160 rules in
~4ms in the "null" case, why does it take us ~86ms in the "open" case?

--
paul moore
www.paul-moore.com
