Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6543A4607F9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 18:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352962AbhK1RYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 12:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347340AbhK1RWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 12:22:13 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73701C0613B1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:15:29 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id t5so62081322edd.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dwc1AHgXzxNTTrWQH1gu6AEq/ANKgg8V+EyYVYA8eEs=;
        b=gvdLLP9Zgg7DXkD/ZUtGjyk0BpQmYIqNBW+yAbHweZxXPjlDyZcqIHCqwAnX6jT6Qw
         s9xT596hdUWjwe57T887qx8WbzMmf7IFe7BPg2A9Milb04UoSHT4WQqN1x8PZRpMd4gN
         tcFkgTfoProiCTG3LoT+U0Zgu62LCWDnutVVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dwc1AHgXzxNTTrWQH1gu6AEq/ANKgg8V+EyYVYA8eEs=;
        b=0AblndoWOzM94plM3MiDX9SC272vuljJeReKflE4diK/yO9mu9cWqd2nR2QhkEpcwt
         /QzduDV/NkiZJpEIjE+PfGkR8uPNlSyLpSCqum7COfROyx/ze6Xxnw/Lc5bOGBm7zFom
         6DCrvBwzKW9fWB3Ubk77yQ0rBW7hSs+SPIgj3TAaiO5MVrKz/Hyh4keHqsvtrb+z67PR
         kag0LkzqEbdbdrrGEXa1wsbygZZHDc+z8Lh3UM1GdK/q7+1mT9DAsIDeTVzEYjT0yrDc
         NKobji/p/BJIPcI1EcJ+AHNjaNGkt9hE4Ca9YPtolR+o4Krg/jHuMbztC0TfnXQk9Mco
         i9sw==
X-Gm-Message-State: AOAM532wRjHAQ3c6alSFBaBjB/2rIs3PjbDMALup3F8BlUaEBl0vOMPH
        xafW1TNXvsN2OjDBOPCyss3M7sy6/WCiRGd4
X-Google-Smtp-Source: ABdhPJxsB5Cv5zoInbUrHdXXeLHnZ0NgziZDdgr+Yf6MLhz+eZ83YN/7kkOXVzJbXAq3cYSF/FYFTQ==
X-Received: by 2002:a17:907:629b:: with SMTP id nd27mr53990358ejc.24.1638119727604;
        Sun, 28 Nov 2021 09:15:27 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id aq6sm6219906ejc.41.2021.11.28.09.15.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Nov 2021 09:15:26 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id a9so31408449wrr.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:15:26 -0800 (PST)
X-Received: by 2002:adf:9d88:: with SMTP id p8mr28975004wre.140.1638119726586;
 Sun, 28 Nov 2021 09:15:26 -0800 (PST)
MIME-Version: 1.0
References: <163811728418.767205.14544746031342483043.tglx@xen13>
In-Reply-To: <163811728418.767205.14544746031342483043.tglx@xen13>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Nov 2021 09:15:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh1AZLCtx6Uk1JKpknaHgoLi_DM7221LoRpU6Y_3im03A@mail.gmail.com>
Message-ID: <CAHk-=wh1AZLCtx6Uk1JKpknaHgoLi_DM7221LoRpU6Y_3im03A@mail.gmail.com>
Subject: Re: [GIT pull] locking/urgent for v5.16-rc3
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 8:35 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>  - down_read_trylock() is suboptimal when the lock is contended and
>    multiple readers trylock concurrently. That's due to the initial value
>    being read non-atomically which results in at least two compare exchange
>    loops. Making the initial readout atomic reduces this significantly.
>    Whith 40 readers by 11% in a benchmark which enforces contention on
>    mmap_sem.

This was an intentional optimization to avoid unnecessary cache
protocol cycles for when the lock isn't contended - first getting a
cacheline for read ownership, only to then get it for write.

But I guess we don't have any good benchmarks for non-contention, so ...

I also hope that maybe modern hardware is smart enough to see "I will
write to it later" and avoid the "get line for shared access only to
get it for exclusive access immediately afterwards" issue.

             Linus

             Linus
