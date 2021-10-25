Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEFF439269
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 11:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhJYJdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 05:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbhJYJc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:32:56 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D76C061767
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 02:30:35 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id l203so5452344pfd.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 02:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UuTXd1eBACFtZGNywiAwVwF2KiEgoy6E6ODkUK/N2+0=;
        b=fIlFgggLvTmAXopTzS5Wy5r1RM7RXAALLLpRlCSIxfHZJ1dkbi4ZFVOC0aHTKY5OUD
         EDIUaqn5mXgXEcK/Ipvo50Gk/AgKi3u3fwRwODCsl3l1Hgl4LHNjkHoAC2f5sh4AK3GZ
         wQJM2JZ+QF+cc1EI5SKR8IpkJcdJNzNy+6xhW7TZ/yF0zbZHCbZied1KWXfg5AC7oTEI
         1YKpVVZH+IU6Ov1VkbRqojnfSS7Vf71VhK/9RYjsCsXdOrg/BfKGTWZy1FOD6qOG0XUp
         3X5U4cAzVvCHDv4vHEgOyZNH44GFOj5iFn6hoUN0Ns6BUiq8bW7ErznRQcZzhlhR2jR2
         iprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UuTXd1eBACFtZGNywiAwVwF2KiEgoy6E6ODkUK/N2+0=;
        b=xL61+wqoy6ol5Ues3qwgb5957lSEt3apyJAfcRvYcdScXbtkCpukzhIeYVBaxIyOus
         3Wzkl9uGf1iudV96SmnGW3YjzFLKpEU6y63DfYYUJR+xTIJrm6WO4ID5rjHKDlal01xw
         TmjWITNVhXvdagEiKwNZfUervhnMqcBZjPBfWv6re1dcxe7oKALivqNUfTkA8xFCkQVr
         Zr2FOo23blOU3bpLIP6bAiuKvUr14Skb6Qf6S7b2X3OLmbm84iq4WUE2sR1LxJdfC3Nd
         TJsUeyNLWOwD+/TED6EPAmpIFsaXHg8yNuuzQ0gLsGe0s3O8cdJhL2HL+wxfryodeisr
         zV0w==
X-Gm-Message-State: AOAM5332+pDInGZSvClXaGus/1d957vfrWtOFCa1Kp1C2runoLQWlH/c
        ddvqV/nKrYFromLGAu8pT9fp8QAUQXMADLzZ79mf3g==
X-Google-Smtp-Source: ABdhPJyS6AljhqeNPYS5+aHkMvKvM/BB8UVGTXEd6XMRn3I0gLPXPEy4AbubRr72Hp/t1slqYtFqHXtj6B1OXfnKMQQ=
X-Received: by 2002:a63:b246:: with SMTP id t6mr12926023pgo.378.1635154234174;
 Mon, 25 Oct 2021 02:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211018090247.3779368-1-tzungbi@google.com> <CABXOdTfs4BPcx=A=Np--zVymJZ5g6S2P=Q5JE2T63zpJKUgJJA@mail.gmail.com>
 <CA+Px+wXrTjHVXYHENX0t2F0RHP-cLane9YLyMKRDNnkrki8BUw@mail.gmail.com>
In-Reply-To: <CA+Px+wXrTjHVXYHENX0t2F0RHP-cLane9YLyMKRDNnkrki8BUw@mail.gmail.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Mon, 25 Oct 2021 17:30:23 +0800
Message-ID: <CA+Px+wWjcySEn5i3=GMGtZ4+hT5Z9L+QLLyxbv1WB7Pi1nPu9A@mail.gmail.com>
Subject: Re: [RESEND PATCH] platform/chrome: cros_ec_debugfs: detach log
 reader wq from devm
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Tue, Oct 19, 2021 at 1:24 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Mon, Oct 18, 2021 at 4:59 PM Guenter Roeck <groeck@google.com> wrote:
> >
> > On Mon, Oct 18, 2021 at 2:03 AM Tzung-Bi Shih <tzungbi@google.com> wrote:
> > >
> > > Debugfs console_log uses devm memory (see struct cros_ec_debugfs in
> > > cros_ec_console_log fops).  However, lifecycles of device and debugfs
> > > are independent.  An use-after-free issue is observed if userland
> > > program operates the debugfs after the memory has been freed.
> > >
> >
> > It would help to see the backtrace. Without it, it is difficult to
> > determine where the UAF is observed. Also, most if not all of the
> > touched functions access struct cros_ec_debugfs all over the place,
> > not only for the wait queue, so I am not sure if moving the wait queue
> > out of the data structure is the correct fix. It might instead be
> > necessary to disconnect memory allocations from the ec device.
>
> A trimmed backtrace is in the commit message, but the more verbose one:
> [  426.174308] Call trace:
> [  426.174314]  dump_backtrace+0x0/0x3ec
> [  426.174318]  show_stack+0x20/0x2c
> [  426.174324]  dump_stack+0x11c/0x1ac
> [  426.174329]  print_address_description+0x7c/0x510
> [  426.174333]  kasan_report+0x134/0x174
> [  426.174337]  __asan_report_load4_noabort+0x44/0x50
> [  426.174341]  do_raw_spin_lock+0x214/0x308
> [  426.174345]  _raw_spin_lock_irqsave+0x68/0xf0
> [  426.174350]  remove_wait_queue+0x3c/0x10c
> [  426.174355]  ep_unregister_pollwait+0x120/0x170
> [  426.174358]  ep_remove+0x60/0x2a0
> [  426.174362]  do_epoll_ctl+0x590/0x7f4
>
> I guess only the wait queue in the struct cros_ec_debugfs has
> deep-coupled to console_log debugfs.  There are 2 more file operation
> scenarios appended after the "--".

Do you think the backtrace is sufficient to determine the UAF happens
on the wait queue?

How about we keep the fix as is since we have a constantly reproducing
step for the UAF.  And look forward to the approach "disconnect memory
allocations from the ec device" if we could discover more UAFs?
