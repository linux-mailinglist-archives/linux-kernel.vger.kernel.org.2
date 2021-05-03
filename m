Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E792372387
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 01:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhECXUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 19:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhECXUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 19:20:47 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F37C061574
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 16:19:53 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x20so10554766lfu.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 16:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0FtWWY4fmD6WRB9NPPZH54mCyUXdEKHNKiJkPNTthSs=;
        b=YTSJyNPsF4SuX8si33iysNtNVQ17vvy6CH1XN0+xVLJ4Am0L24sPQWs+u7O32+eW4b
         KVy+tXKv0wu0UENmRhWTAUxvGV37YYlqLH2LJm6MeIC6OE4qJYMWgCFuZCaXe5EE0R8F
         e90GPaqDfOXzM2vnc3ipJnsj/C4n713z4wWiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0FtWWY4fmD6WRB9NPPZH54mCyUXdEKHNKiJkPNTthSs=;
        b=CWf5vUD5ApfYkYMxFowu0XmXkSX0sOKNuWPMPedv+UUgFzVG6qkEb4Tjahnqt+xYjv
         f3C6VdOxenfpfGCIbeKjCGF2a3+neZoET8YfDNJO1J5NEHPya+fBq5++g2dGiPVumkbL
         hwcR8DUFUaCTzFQY+gQf8WEbxd1naPteDwkmvo2ja5s7k66lwmYG4nt6Eyt0Iy8RbhYh
         MjEkrqMJfKH6xExLmiDfIkZjqPsFL6LKbfJo9ezkYzfNV9LO6Y4JhRstIfKMSRVDvl0b
         ve7I9QZ5zh8o1Dg0vBByVvOdmOGILyo7yWBMZ1SFUbJCFiJW6HUWQaOWGsWjuhDlgxnT
         oNMQ==
X-Gm-Message-State: AOAM533mVtIAW7x9rLW9rOig4/7WSMEwU1kKivJ3mtGuw1PfVY1pbL8s
        RA/ptlKYY8PLwo+5yz8yP5xf2YzstikzlPXT
X-Google-Smtp-Source: ABdhPJzQnVrh87WJnzscn8M9ktA789+P+jcSR6civKJJZE4I5Wi7fcaXeOfvaGeD3Jikb28RK5Dq+Q==
X-Received: by 2002:a19:c104:: with SMTP id r4mr5157854lff.555.1620083992219;
        Mon, 03 May 2021 16:19:52 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id a20sm1404829ljd.105.2021.05.03.16.19.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 16:19:51 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 124so10559756lff.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 16:19:51 -0700 (PDT)
X-Received: by 2002:ac2:5f92:: with SMTP id r18mr15048326lfe.253.1620083991473;
 Mon, 03 May 2021 16:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <8735v3ex3h.ffs@nanos.tec.linutronix.de> <3C41339D-29A2-4AB1-958F-19DB0A92D8D7@amacapital.net>
 <CAHk-=wh0KoEZXPYMGkfkeVEerSCEF1AiCZSvz9TRrx=Kj74D+Q@mail.gmail.com>
 <CALCETrV9bCenqzzaW6Ra18tCvNP-my09decTjmLDVZZAQxR6VA@mail.gmail.com>
 <CAHk-=wgo6XEz3VQ9ntqzWLR3-hm1YXrXUz4_heDs4wcLe9NYvA@mail.gmail.com>
 <d26e3a82-8a2c-7354-d36b-cac945c208c7@kernel.dk> <CALCETrWmhquicE2C=G2Hmwfj4VNypXVxY-K3CWOkyMe9Edv88A@mail.gmail.com>
 <CAHk-=wgqK0qUskrzeWXmChErEm32UiOaUmynWdyrjAwNzkDKaw@mail.gmail.com>
 <8735v3jujv.ffs@nanos.tec.linutronix.de> <CAHk-=wi4Dyg_Z70J_hJbtFLPQDG+Zx3dP2jB5QrOdZC6W6j4Gw@mail.gmail.com>
In-Reply-To: <CAHk-=wi4Dyg_Z70J_hJbtFLPQDG+Zx3dP2jB5QrOdZC6W6j4Gw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 May 2021 16:19:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+njBWpgFqueHMVk1U8-APxZsgRsrOvhybcBEjspzGSg@mail.gmail.com>
Message-ID: <CAHk-=wj+njBWpgFqueHMVk1U8-APxZsgRsrOvhybcBEjspzGSg@mail.gmail.com>
Subject: Re: [PATCH] io_thread/x86: don't reset 'cs', 'ss', 'ds' and 'es'
 registers for io_threads
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Stefan Metzmacher <metze@samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 3, 2021 at 4:16 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> These days they really are fully regular user threads, they just don't
> return to user space because they continue to do the IO work that they
> were created for.

IOW, you should think of them as "io_uring does an interface clone()
to generate an async thread, it does the work and then exits".

Now, that's the conceptual thing - in reality one thread can do
multiple async things - but it's the mental image you should have.

Don't think of them as kernel threads. Yes, that's how it started, but
that really ended up being very very painful indeed.

            Linus
