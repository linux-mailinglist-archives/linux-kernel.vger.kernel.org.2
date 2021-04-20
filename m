Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C5A365436
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhDTIfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhDTIfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:35:01 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E861C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 01:34:30 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 82so42077706yby.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 01:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CIbDsjSlYNB39lAkXiBh+yh6lGzuFfE+K2GAXvRSiyI=;
        b=UagKz1Qmdu7Q2jsw/lr+lek9ORY3WucgUMgJTMbmlQ2U0hscD+E4At1sbrujKdRowD
         7X3trQLGkBQm2N1wrZnxzZvdp6NbB4Ox/984N8iDCwFYV1nL7ZjkMFT1GIPCoiQnzB2d
         uJk5/6mVWzJHMjDW72KFUaJ0B+ZoQFuIcJbfidbR1x9QqTe5AHXogeUhZ4Y+KG0OdU+K
         PhYQ7QqVcH6G8SfLM9vRvjUc/Q9X5cjuIf5xav//VhU1YzPGMMFOwOrIl02TZ786Kdqe
         QPPU3xBMhotzf7RhfN/AMqz1JwhJJ0SZmCcpo/GXj24abZ9gSRgcXiSp78h91/loFVjl
         Dpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CIbDsjSlYNB39lAkXiBh+yh6lGzuFfE+K2GAXvRSiyI=;
        b=ooD+iVH0drC3jQJErkphA4t9r6IAy+uFXkA9umIWWScCjebOqfR8Q6hnvzo0b647Gd
         QxIe7dBn7qtXos8RBo5YBh659/9mhO6B9zMFYryqYUOK9NALtEbkaKfdH/cVxor98gc3
         EVWiqoJJgSvjlpfQLuHbAH81T4ZzOFmi4VIu5y8oTFKncyXoEqpEYiomJ9q6TCMIDUzQ
         5nKQkRWb3aieAR1DJthjad6EgZo4ORyPSBt3oNEAWeSF23XjDCAoOwb0MFIJBxfiaLdc
         +++eGEivBCz19DQAemGI9ww8bwemM2A5gA+O/9THk399bHSbAMc/ll9eLsMFH5IyBl/s
         t4cg==
X-Gm-Message-State: AOAM531aZxElP0FpV29pMIgRPKADERHIC3gNTqfZ6WVqF+PpRuftg/OX
        gz+2TfPs1nGbwQSXoayhNQZBnm7xqNc2HFOsqWj11w==
X-Google-Smtp-Source: ABdhPJyfIpao9HMJFv/llAEFc3oqElsajPNf7GfYDz0tkJQWODL4BNlANI60ZRFNj43qwv4kk+DN8u5uVwrD70ZjjRg=
X-Received: by 2002:a25:7650:: with SMTP id r77mr24388590ybc.446.1618907669051;
 Tue, 20 Apr 2021 01:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210420075406.64105-1-acelan.kao@canonical.com>
In-Reply-To: <20210420075406.64105-1-acelan.kao@canonical.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 20 Apr 2021 10:34:17 +0200
Message-ID: <CANn89iJLSmtBNoDo8QJ6a0MzsHjdLB0Pf=cs9e4g8Y6-KuFiMQ@mail.gmail.com>
Subject: Re: [PATCH] net: called rtnl_unlock() before runpm resumes devices
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Wei Wang <weiwan@google.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Taehee Yoo <ap420073@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 9:54 AM AceLan Kao <acelan.kao@canonical.com> wrote:
>
> From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
>
> The rtnl_lock() has been called in rtnetlink_rcv_msg(), and then in
> __dev_open() it calls pm_runtime_resume() to resume devices, and in
> some devices' resume function(igb_resum,igc_resume) they calls rtnl_lock()
> again. That leads to a recursive lock.
>
> It should leave the devices' resume function to decide if they need to
> call rtnl_lock()/rtnl_unlock(), so call rtnl_unlock() before calling
> pm_runtime_resume() and then call rtnl_lock() after it in __dev_open().
>
>

Hi Acelan

When was the bugg added ?
Please add a Fixes: tag

By doing so, you give more chances for reviewers to understand why the
fix is not risky,
and help stable teams work.

Thanks.

> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> ---
>  net/core/dev.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1f79b9aa9a3f..427cbc80d1e5 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -1537,8 +1537,11 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
>
>         if (!netif_device_present(dev)) {
>                 /* may be detached because parent is runtime-suspended */
> -               if (dev->dev.parent)
> +               if (dev->dev.parent) {
> +                       rtnl_unlock();
>                         pm_runtime_resume(dev->dev.parent);
> +                       rtnl_lock();
> +               }
>                 if (!netif_device_present(dev))
>                         return -ENODEV;
>         }
> --
> 2.25.1
>
