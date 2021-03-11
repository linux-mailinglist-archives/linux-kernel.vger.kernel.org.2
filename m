Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5F7337AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCKRZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhCKRZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:25:38 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D07FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 09:25:38 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id cx5so2903098qvb.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 09:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tP/tKiRNygeIpzt+sV7itRbtILpJcSCyB6twSViOA+A=;
        b=R/ae6g94KiIc1VaUlUYIsfgPSfpNMge4KqOnAo7ay5Glz8UakGrRaXnUsvGrbkHLjF
         4O787Oga/UaaFlpFglyH0h1/L3Sqhd6YjA/4DrRerj8Tz8KynrNcE3Lgj0Zk24lbjwH8
         0r2L5Rxzn2GyCcJh4EEtblT9GGUbIXmz3/1mIElecJpcrzzkHPgbrSeSkOa57Lc1Yzv7
         EV/PBE4F5d7KF2SXqneJ1CBXxSGhWtPgkfpGGsMLLVMIPSrZKue+FEWRJWYC25vqSv9k
         22rs9IuWkYRqoOOliTM5K/F6CwAVzxaDufvC15hc9tBKq1ClT5wAhSmKfPzdqzLyW4NK
         jmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tP/tKiRNygeIpzt+sV7itRbtILpJcSCyB6twSViOA+A=;
        b=t5ZiocNfLvzOzJrMYu7mP9W1XIoQTq35XMzC5Qu/5KFegxKht/tJ6zrIG5uYz4s5Wf
         Xi9eHx08uDZjWKQhZETlChZWsvTo65rMQACE+51Svd7xJ9aJHzu/MQYLq5MVR0+xKChy
         +MnTwq79mtiFv7vsz34ReLgGTVb079lA8l9jdEbc6ydmy6YcQMRJ0Djnntfw9qkMlih4
         YuZ3J/P/f2bUHOnyfCfe1Hqvuz5sDPvbtnRosbXaPxqWO7jKVd6xx7oVWe/O8ts9eolZ
         q2BhD5csi3BRrkREZocbC4cuPa/AWpiqVO4PrscPvUvthG6DFYygB69uNgqK8BZR3sxF
         5xdQ==
X-Gm-Message-State: AOAM533UjY06d25kWs61NmOHG+RX3BQGt874pA110gDmLuCo32GbaKMK
        g34EwQGpDuWjE8HRF+sqCWKOnVFX0f7RsQayq2D5iA==
X-Google-Smtp-Source: ABdhPJzZYvLF863xU5IO1BcearQqPvN74V47caCVN6R8NwmwrDX9JnyA8PSsZPtPI2FX1hdLI1UHh0mrgSRr/Vqy4JM=
X-Received: by 2002:a05:6214:1870:: with SMTP id eh16mr8491532qvb.23.1615483537555;
 Thu, 11 Mar 2021 09:25:37 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com>
In-Reply-To: <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 11 Mar 2021 18:25:26 +0100
Message-ID: <CACT4Y+Z_Req6qLArMOH0FHR92cTPyv+PLM91CCjkSw4Ua_vWjw@mail.gmail.com>
Subject: Re: arm64 syzbot instances
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 2:30 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Mar 11, 2021 at 12:38 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > The instances found few arm64-specific issues that we have not
> > observed on other instances:
>
> I've had a brief look at these:
>
> > https://syzkaller.appspot.com/bug?id=1d22a2cc3521d5cf6b41bd6b825793c2015f861f
>
> This one  doesn't seem arm64 specific at all. While the KASAN report has shown
> up on arm64, the link to
> https://syzkaller.appspot.com/bug?id=aa8808729c0a3540e6a29f0d45394665caf79dca
> seems to be for x86 machines running into the same problem.

You are right. It's probably a consequence of some configs being enabled.
I think we need to enable CONFIG_FW_LOADER_USER_HELPER on x86_64
upstream instances as well.


> Looking deeper into the log, I see that fw_load_sysfs_fallback() finds
> an existing
> list entry on the global "pending_fw_head" list, which seems to have been freed
> earlier (the allocation listed here is not for a firmware load, so presumably it
> was recycled in the meantime). The log shows that this is the second time that
> loading the regulatory database failed in that run, so my guess is that it was
> the first failed load that left the freed firmware private data on the
> list, but I
> don't see how that happened.

Can it be as simple as: fw_load_sysfs_fallback adds fw to the pending
list, but then returns with an error w/o removing it from the list?
There are some errors checks after that:
https://elixir.bootlin.com/linux/v5.12-rc2/source/drivers/base/firmware_loader/fallback.c#L536
and it seems that the caller deletes fw in this case:
https://elixir.bootlin.com/linux/v5.12-rc2/source/drivers/base/firmware_loader/main.c#L839
