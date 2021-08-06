Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61943E23D7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 09:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243572AbhHFHSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 03:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhHFHSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 03:18:54 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C647FC061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 00:18:38 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id i13so7822885ilm.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 00:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AfXhjKpSCetGLLmH2wYSMbPYpbDKNCyV0HNRYyDMQeA=;
        b=HIqw9q6X5vyWEvkesEX5PjXRQM7ZTPej9g4yoakHyG9UUz9ZBim9nm2/15AqQwjYbp
         FtLwFHfS7IuNoFwdgnAIGGIyI8drUyaEYoJ0wwedxxz4/wsxqNrAD+2RiKbI1AXYgzTz
         HU7n7gdfF8E0WkfKempmVH+MvIVnLNUdDDeiDt8CyoVaWyTAzI43z8wxQw532biv1uEP
         tMg8757wAA1hzr8cexj2ijuu8Jk9dxtGyhDmzDIEoxOMDFSGp8ZbKm2aGx90wawj3Gsa
         hvjhMUYXqgsXgMX7Lc3AHP243i/srho+LQddDkpdGGOEgyNM6Mj8eBcvTjfieCNG97xY
         GlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AfXhjKpSCetGLLmH2wYSMbPYpbDKNCyV0HNRYyDMQeA=;
        b=TO/LDKgSd4d7eNDGvt9xlQ6FdOeZ/ZY2TWRpUwIHTJh6fppxLZzOlG6ZbQXBG4RwSt
         wn1YBF9TnrueYtCjua4wP2+6CzGVJZ57+k+MYey6lAOcfQe5/zu99Kg8zBa3VFlfGUKY
         tJcWXN/KzBtjtXd6LcbGyGO3iYlgxoraOY2h9dsNyFKH8Z9ubpinQBHGCQml0/xfL/dL
         4VYT7UoO0aKUAcM6hjxiVWrlYTn7v8VM26s28lSh9LZaKXctnmFAHCSC3ft+QqGDYR+z
         YZbwquzguUxXJ7EwhN6KqUBL4ufEV4UWVJWbXEQ8kn8KsVFH6CU/8mzynki4BoPqIq7U
         0DSg==
X-Gm-Message-State: AOAM531Cw3fJmi0hkOfZOQVDz2NpD80J2UYsQkiZsiHnQBGiTO35zqMB
        r/IuFkjbf9WWoPqoENFvbONqrvpKmpkARKG5+Ra1nw==
X-Google-Smtp-Source: ABdhPJzDCVLK5V7LZPwSnnK3Ot1kGmgymxUIyCMxFioYlPkMkJkf6Zof5u9E1YTx97xz6BpltLo57X22iVIcj1sQcu0=
X-Received: by 2002:a92:d3d2:: with SMTP id c18mr360857ilh.192.1628234317999;
 Fri, 06 Aug 2021 00:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <2c40741c-8c8f-a105-1846-aa1ed15a6c7e@gnuweeb.org>
 <20210804085651.2452-1-hdanton@sina.com> <80e24ed7-a34a-7fac-c709-06ccad6d2612@gnuweeb.org>
In-Reply-To: <80e24ed7-a34a-7fac-c709-06ccad6d2612@gnuweeb.org>
From:   "Anand K. Mistry" <amistry@google.com>
Date:   Fri, 6 Aug 2021 17:18:25 +1000
Message-ID: <CAATStaMjeyzU3Gj7D-Q1zGMdioC5ENoXbf4QB9Rmw8TCWRiagg@mail.gmail.com>
Subject: Re: WARNING: possible circular locking dependency detected (hci_sock_dev_event+0x17d/0x1f0)
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Hillf Danton <hdanton@sina.com>, Lin Ma <linma@zju.edu.cn>,
        Marcel Holtmann <marcel@holtmann.org>,
        Ammar Faizi <ammarfaizi2@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2021 at 21:43, Ammar Faizi <ammarfaizi2@gnuweeb.org> wrote:
>
> See the original report here:
> https://lore.kernel.org/lkml/2c40741c-8c8f-a105-1846-aa1ed15a6c7e@gnuweeb.org/
>
> On 8/4/21 3:56 PM, Hillf Danton wrote:
> > On Mon, 2 Aug 2021 20:17:02 +0700 Ammar Faizi wrote:
> >> Hi everyone,
> >>
> >> I found a potential deadlock at hci_sock_dev_event.
> >
> > Thanks for your report.
> >
> > Can you try and see if reverting e305509e678b3a4af2b3cfd410f409f7cdaabb52
> > ("Bluetooth: use correct lock to prevent UAF of hdev object") is a cure.
> >
>
> Hi Hillf,
>
> Thank you for your response.
>
> Here is what I have tried:
> 1. Reverted e305509e678b3a4af2b3cfd410f409f7cdaabb52.
> 2. Compile and install reverted version.
> 3. Rebooted 5.14.0-rc3 (c7d102232649, before revert) and try to
> reproduce again. At this point I am able to reproduce it.
> 4. Booted 5.14.0-rc3 (the reverted version). The deadlock warning is
> gone after reverting it. No more deadlock warning.

Can you try patching in
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=58ce6d5b271ab25fb2056f84a8e5546945eb5fc9
and see if that fixes it.

>
> ------------------------------------------------------------
> [ 51207ee38ab65db86554655300a912e8c661525e is my local revert. ]
> Revert diff:
> ammarfaizi2@integral:~/project/now/linux$ git diff
> c7d102232649226a69dddd58a4942cf13cff4f7c
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index b04a5a02ecf3..590467345c5f 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -762,7 +762,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event)
>                 /* Detach sockets from device */
>                 read_lock(&hci_sk_list.lock);
>                 sk_for_each(sk, &hci_sk_list.head) {
> -                       lock_sock(sk);
> +                       bh_lock_sock_nested(sk);
>                         if (hci_pi(sk)->hdev == hdev) {
>                                 hci_pi(sk)->hdev = NULL;
>                                 sk->sk_err = EPIPE;
> @@ -771,7 +771,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event)
>
>                                 hci_dev_put(hdev);
>                         }
> -                       release_sock(sk);
> +                       bh_unlock_sock(sk);
>                 }
>                 read_unlock(&hci_sk_list.lock);
>         }
> ammarfaizi2@integral:~/project/now/linux$
> ------------------------------------------------------------
>
> Summary:
> Reverting e305509e678b3a4af2b3cfd410f409f7cdaabb52 is a cure.
>
> Although it fixes the deadlock, there is probably something still goes
> wrong regarding "prevent UAF" as the commit message says.
>
> Will anyone create a patch for this?
> I want to be the tester, I am new at kernel development and want to
> start contributing, so please guide me :)
>
> I also attached dmesg log before and after revert if you want to see the
> full log.
>
> Adding Lin as the author of e305509e678b3a4af2b3cfd410f409f7cdaabb52 to
> CC list...
>
>
> --
> Ammar
>


-- 
Anand K. Mistry
Software Engineer
Google Australia
