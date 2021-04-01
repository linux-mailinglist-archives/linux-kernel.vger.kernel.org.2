Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4890351D05
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbhDASX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237160AbhDASDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:03:38 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1041C02FEB3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 09:25:16 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id r20so2896205ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 09:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zqCMOBypWMQrFbhLJ32mebAruTX9rIeMsT/rUeGN8s4=;
        b=MJa57M9nPQRBm1aVYcjskVj7GsuwnBIkQ2OKLCY1TaQbheJTjtHLCiiLXpyBtHdYnG
         GYn1R3QF5JvAJ5heSIw+Xkj46s7bdiCDIIabYjiWbgc3bwnaKSuzjz32xAyKWQwckGQR
         o+BzYcd/n0S6QJ/6MepO2U9OBI0Wt1MFV7qT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zqCMOBypWMQrFbhLJ32mebAruTX9rIeMsT/rUeGN8s4=;
        b=rpFQ8+nIvBFqPI5sklYRtWJpbjfCoQ7fKDEsKgAujElyLeSqV8dwsvLXVGrhzhHEyv
         wAbR+0vDU3UThHQaCsEsAOG6IC+M1x3xcrVWhCzGMdUKL4klFlol31SHkLYwM9YVnv0d
         KTdH8HqThRDaVvPyt2Z6ZP4S1zAboAN/TFgz13cX6hSH+3JIRpGepvCOSirKJbUFC0Sz
         5Ufd0S/yYiUyGkhFkVy3qefobdonfRsV6dgg9mOoJdRi8aY3CXLhhvpD64YA1UPCLUM7
         i/OCZ7t9rxICPHvZCmf0zP8Y6atvK4Y1VEx4aXMoCCNpz8+yytRg++6ScSJqrH9W92Xl
         4CdQ==
X-Gm-Message-State: AOAM531uKlJ7KbUVIwOoRsGHxK9/HDtKaOJZZsgzoRoGAMfuXLs8JYvH
        iRl4hjUaXtTb/8UeH9D2uawxDi5nwUW/rikK
X-Google-Smtp-Source: ABdhPJw5FB+oBwzmRuXBBltr+o2UxN+vgTIoVjxd/1K8n8atrPCwocGaiHlxs1N72TkPoqvNouHDhw==
X-Received: by 2002:a2e:3010:: with SMTP id w16mr5736861ljw.118.1617294313994;
        Thu, 01 Apr 2021 09:25:13 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id v80sm586273lfa.229.2021.04.01.09.25.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 09:25:13 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id n138so3721083lfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 09:25:13 -0700 (PDT)
X-Received: by 2002:a05:6512:3ba9:: with SMTP id g41mr5782359lfv.421.1617294313081;
 Thu, 01 Apr 2021 09:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210326003928.978750-1-axboe@kernel.dk> <e6de934a-a794-f173-088d-a140d0645188@samba.org>
 <f2c93b75-a18b-fc2c-7941-9208c19869c1@kernel.dk> <8efd9977-003b-be65-8ae2-4b04d8dd1224@samba.org>
 <358c5225-c23f-de08-65cb-ca3349793c0e@samba.org> <5bb47c3a-2990-e4c4-69c6-1b5d1749a241@samba.org>
 <CAHk-=whEObPkZBe4766DmR46-=5QTUiatWbSOaD468eTgYc1tg@mail.gmail.com> <2d8a73ef-2f18-6872-bad1-a34deb20f641@samba.org>
In-Reply-To: <2d8a73ef-2f18-6872-bad1-a34deb20f641@samba.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Apr 2021 09:24:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-VE=4puZ+r-Mo0GcAUou3aKrvnNsU3JxjnMXNcJOoug@mail.gmail.com>
Message-ID: <CAHk-=wh-VE=4puZ+r-Mo0GcAUou3aKrvnNsU3JxjnMXNcJOoug@mail.gmail.com>
Subject: Re: [PATCH 0/6] Allow signals for IO threads
To:     Stefan Metzmacher <metze@samba.org>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring <io-uring@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 1, 2021 at 9:00 AM Stefan Metzmacher <metze@samba.org> wrote:
>
> I haven't tried it, but it seems gdb tries to use PTRACE_PEEKUSR
> against the last thread tid listed under /proc/<pid>/tasks/ in order to
> get the architecture for the userspace application

Christ, what an odd hack. Why wouldn't it just do it on the initial
thread you actually attached to?

Are you sure it's not simply because your test-case was to attach to
the io_uring thread? Because the io_uring thread might as well be
considered to be 64-bit.

> so my naive assumption
> would be that it wouldn't allow the detection of a 32-bit application
> using a 64-bit kernel.

I'm not entirely convinced we want to care about a confused gdb
implementation and somebody debugging a case that I don't believe
happens in practice.

32-bit user space is legacy. And legacy isn't io_uring. If somebody
insists on doing odd things, they can live with the odd results.

                  Linus
