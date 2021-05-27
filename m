Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9E73927DF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 08:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbhE0GmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 02:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbhE0Glw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 02:41:52 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FCCC061763
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 23:40:19 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id q6so2089590qvb.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 23:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vP440vYa1wc9MKc+WMZDRHr+yrlQHbEiI619hnjxxZQ=;
        b=EAaAZ4YvFiNDNE+XJFFs5kzX+wY5pAEr/xuZriEyZS4DrCBlsYe/kvt/cwt2GxSd2v
         YOx1h1ow0zjYC+NF3qCgFdqb5NBBnkhXbXCC6IoIV4YFgkMyRqOApfHvEyCCHv19xvDH
         yB3tDkn0iqcohsmIP5iAwgHt+RU7/d5jxIEsTQ1kU3CUcz6Mg58B08BfD21IaDeGr6oM
         w5tuldP8/ItOWKxJVMAfrgep5O4Avcy1dql52WqLgm8lSC0TDneuW02JQ1UJX6HeBaQz
         GJbyFTWSXWJFMhI6s+ko5aQ2bj+NnCUj1yKaUoumESj63E/kGci+cNQ0fpHYHAfZiZGa
         GvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vP440vYa1wc9MKc+WMZDRHr+yrlQHbEiI619hnjxxZQ=;
        b=Wo2sk5LRzjSQ1YATYfM2m9V8FeRRsJ1eIu6KlTw2ITSNqmbQSk+iFHp5hxODK4wjtS
         HS0/fANqxwTjx29xhxp9m4rEO2ADa86NVHSxne+ClDkjRagWLbQiPMHNFQGiHYUG4XPA
         sD4tUrpi3KChhQ7UR236Q7tmBqwQdjoqjHf7pqjXDXSv2456f12x5KByU5LV0woASU1C
         I8sb86JtDPVpjJdTeVKhc4Sryp+hKr+EfkDNVtDgOQomly4sYj46PRMN4kL7saA0pOEQ
         +lSRXJ5NPFo+9eKyteS6mZYtrhUajmZPqFYPuJRVWk6gO8Xmz5JgMy6x451eGS8YSLDv
         AbTw==
X-Gm-Message-State: AOAM531QbsDHfdQBK7nqBLzLFc0hUEczfnU6qSfDn+iOS4qVu58zosqx
        /Hqp5wAW5dVAQk/ZRGeuQn4dBypFrzsQnHb0qn84Zw==
X-Google-Smtp-Source: ABdhPJwMgb9NEWfwAH3S14ffx8RXdI0lk/BLbYTjDU8zmd3KpsmzVd8mhCTHxjXLAiUWRj482YQ6N2JYl3LZmXIYuZA=
X-Received: by 2002:a0c:ab88:: with SMTP id j8mr2122194qvb.23.1622097618232;
 Wed, 26 May 2021 23:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b808c705c345b35d@google.com> <0000000000009dfd7c05c3463b32@google.com>
In-Reply-To: <0000000000009dfd7c05c3463b32@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 27 May 2021 08:40:06 +0200
Message-ID: <CACT4Y+ZkGw8GDs9vYzs5t7iBba+5ZRKmTnp3zXAnkOsmyWp6Rw@mail.gmail.com>
Subject: Re: [syzbot] unexpected kernel reboot (5)
To:     syzbot <syzbot+6fb8ff5211d3e821398f@syzkaller.appspotmail.com>,
        Joey Jiao <joey.jiaojg@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 4:08 AM syzbot
<syzbot+6fb8ff5211d3e821398f@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    7ac3a1c1 Merge tag 'mtd/fixes-for-5.13-rc4' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=174ba76fd00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=266cda122a0b56c
> dashboard link: https://syzkaller.appspot.com/bug?extid=6fb8ff5211d3e821398f
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10772527d00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1072f98dd00000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6fb8ff5211d3e821398f@syzkaller.appspotmail.com
>
> output_len: 0x000000000e7f5b68
> kernel_total_size: 0x000000000fc26000
> needed_size: 0x000000000fe00000
> trampoline_32bit: 0x000000000009d000
> Decompressing Linux... Parsing ELF... done.
> Booting the kernel.


The reproducer writes into /sys/power/state. I assume this is an
intentional way to reboot a machine and we can't let the fuzzer mess
with all sysfs files with:

openat$sysfs(fd const[AT_FDCWD], dir ptr[in, glob["/sys/**/*"]], flags
flags[open_flags], mode flags[open_mode]) fd

+Joey, how do you deal with this?
