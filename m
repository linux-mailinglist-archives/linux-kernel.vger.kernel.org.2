Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAD336311C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 18:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbhDQQJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 12:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbhDQQJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 12:09:07 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6234C061574
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 09:08:39 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id l22so27067377ljc.9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 09:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CpXLVFKBuxGedOXr5UF0J1u8IEqvpoojnAx1dnjinuU=;
        b=NDpiaqC8RQdgppn7RNtRTkdfZ7vU2zRrl/NWu5MRi+0Muy5p1Nyk1Kv5xMHM8PCNrV
         zQspn/Tus7HsyElEKxWtCdWeZnlqfi8ydsPONU595KFuVxBcqt66os6d0+t2hsjecdq/
         JBuJ2zmacJRO4WfO5OKwAKJeg6vrEkaEDjHbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CpXLVFKBuxGedOXr5UF0J1u8IEqvpoojnAx1dnjinuU=;
        b=ZZFBaRfBwiWdtG+WRZDVii6zuCrfu6N8l2LNX+8lr4kPAF9iGeQtV6w+tPhcO06Q6C
         OunKPuMBHixPUM/H04FgF/EFOYTzqmOeZYYc6Pgqz0SsYhkxC4plVoWN5uSgbBPLH4Kb
         KzO/ZBU3Dy324X39763UxyOxyLeY/rqfMIYcT2QaXpuq80gu2591ucm1jpdQ0rloKwV6
         lZduRrQ7Hav2G4Rmg+q0oTcSsdzfkQg+/fr7ECjAfE6igMQoyNCIS03UOt5mMGQwdWff
         zXHdYJEt+z+rnuMdiqcScGkAsHCASsSQhI/AESsXftn+njjTJwdgudgdqkQdAGWZ6wdW
         Ftbw==
X-Gm-Message-State: AOAM531Mq+kqkiPLT3xM4UqlMHQRFToXoFL9caf+e5k7X3Kt4KZfF3Yt
        ABp5YnclLSvMcpBZ41QqpdnMAWF01TTRZgo2
X-Google-Smtp-Source: ABdhPJzZLmMpzwZSU1bgoUlWljOv23gso8PsJX6CKkxoZCm1mp2rBny9WnlwSt1hyzczdtJBtOkflQ==
X-Received: by 2002:a2e:8704:: with SMTP id m4mr5928595lji.390.1618675718096;
        Sat, 17 Apr 2021 09:08:38 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id c5sm1325405lfk.141.2021.04.17.09.08.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Apr 2021 09:08:37 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id n138so49518303lfa.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 09:08:37 -0700 (PDT)
X-Received: by 2002:a05:6512:33d3:: with SMTP id d19mr5533163lfg.40.1618675717267;
 Sat, 17 Apr 2021 09:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210416192413.1514419-1-eric.dumazet@gmail.com> <CAHk-=wjbvzCAhAtvG0d81W5o0-KT5PPTHhfJ5ieDFq+bGtgOYg@mail.gmail.com>
In-Reply-To: <CAHk-=wjbvzCAhAtvG0d81W5o0-KT5PPTHhfJ5ieDFq+bGtgOYg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 17 Apr 2021 09:08:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdyusj4Sz6zVOGvD8pNiYmPik3t4-o0TXB9cTUgz_0uw@mail.gmail.com>
Message-ID: <CAHk-=wgdyusj4Sz6zVOGvD8pNiYmPik3t4-o0TXB9cTUgz_0uw@mail.gmail.com>
Subject: Re: [PATCH] x86/uaccess: small optimization in unsafe_copy_to_user()
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 9:03 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Really. The "unsafe" user accesses are named that way very explicitly,
> and for a very very good reason: the safety needs to be guaranteed and
> obvious within the context of those accesses. Not within some "oh,
> nobody will ever call this with a negative argument" garbage bullshit.

Side note: I'm, looking at the readdir cases that I wrote, and I have
to just say that is broken too. So "stones and glass houses" etc, and
I'll have to fix that too.

             Linus
