Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928D2337183
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 12:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhCKLio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 06:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbhCKLid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 06:38:33 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBF7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 03:38:33 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id f12so853157qtq.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 03:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=klNWu6gBaGXzGnBi2pV+YTDaSk9JFDAdIUfV2yU4ess=;
        b=mpNouDGWx8His0FtJZ5lsEKFWe2UcwYPvV4sMnBol427wGCSJa4atRW5r58HsePeqH
         Ga2R+fGHW7rqpNg0IwCZD0DtcPhqEtA5ILLB+BcL9+5e4dvH2EwMSLnNSN/sDGMjQ/Mh
         wMz4ebhqE6PodmlYoww8hA/tKSJjUOAMqROMiW66FnnSUhogvp2NuNLE/OkYP+u5LyJd
         BsIAQXXBmruj6lQrKa3PG35deeppvx0Hx9RIGfrDoXuqHvoefNxRVuXLAQirxOd4l/U9
         gam977mySaD1l4BGlRI4unHRWtQT9MUHmbUD8xyJAuczHqUw64nBjB10Y8diL+9Ln4ND
         hHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=klNWu6gBaGXzGnBi2pV+YTDaSk9JFDAdIUfV2yU4ess=;
        b=LWlqATBeGmzqgTlIz4wXlWCwtomnUMq03GlSBTlJOwbkcvXG/k6fT3fjYi2baUIRBN
         MryPU1MlYr+Oi8TMfCZGOp9RiruyuDV3KXAuK8QzE9QzpF60OSLeQ2nHNq+sYPgN6//q
         HnalaI7F5Y68SnClXNNJuoS+sRzBQTA47v110RAsDxXo5zq2glyQqx3CyanFgqy19WUq
         R3EcXOjMAhO7zfdwAghGLfGF+64plrXUCI39JU5tVt6eD/lqAnEsLEAwCds6nOWRsJft
         x6ef8ysOY1A8rUoqy/CSf/HHVG/w1Q+FtJHJWQDGuOT/2wtWrH0K11OdatMAuj78f0i3
         V1/g==
X-Gm-Message-State: AOAM5302nM+4jgu3A2Sijr/+CU4MsaYIIoxdNUa+XVz9gYsFMwb6Qf4g
        Tu9m5unMCppqAYp6+8hM2GLRrYap0shklZp/+Qopaz5ywNUZEg==
X-Google-Smtp-Source: ABdhPJx5uGSGGv5hHX1g9mlcQ2UdIQXa4pveQ8CsbQwLjMUqAAf42Q6pnbj5F30tQ9i7VVu0J93TSNS1VAPWcsqVhTA=
X-Received: by 2002:ac8:7318:: with SMTP id x24mr6850646qto.67.1615462712219;
 Thu, 11 Mar 2021 03:38:32 -0800 (PST)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 11 Mar 2021 12:38:21 +0100
Message-ID: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
Subject: arm64 syzbot instances
To:     Mark Rutland <mark.rutland@arm.com>, maz@kernel.org,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi arm64 maintainers,

We now have some syzbot instances testing arm64 (woohoo!) using qemu
emulation. I wanted to write up the current status.

There are 3 instances, first uses KASAN:
https://syzkaller.appspot.com/upstream?manager=ci-qemu2-arm64
second KASAN and 32-bit userspace test load (compat):
https://syzkaller.appspot.com/upstream?manager=ci-qemu2-arm64-compat
third uses MTE/KASAN_HWTAGS:
https://syzkaller.appspot.com/upstream?manager=ci-qemu2-arm64-mte

Kernel configs:
https://github.com/google/syzkaller/blob/master/dashboard/config/linux/upstream-arm64-kasan.config
https://github.com/google/syzkaller/blob/master/dashboard/config/linux/upstream-arm64-mte.config

The instances have KCOV disabled because it slows down execution too
much (KASAN in qemu emulation is already extremely slow), so no
coverage guidance and coverage reports for now :(

The instances found few arm64-specific issues that we have not
observed on other instances:
https://syzkaller.appspot.com/bug?id=1d22a2cc3521d5cf6b41bd6b825793c2015f861f
https://syzkaller.appspot.com/bug?id=bb2c16b0e13b4de4bbf22cf6a4b9b16fb0c20eea
https://syzkaller.appspot.com/bug?id=b75386f45318ec181b7f49260d619fac9877d456
https://syzkaller.appspot.com/bug?id=5a1bc29bca656159f95c7c8bb30e3776ca860332
but mostly re-discovering known bugs we already found on x86.

The instances use qemu emulation and lots of debug configs, so they
are quite slow and it makes sense to target them at arm64-specific
parts of the kernel as much as possible (rather
than stress generic subsystems that are already stressed on x86).
So the question is: what arm64-specific parts are there that we can reach
in qemu?
Can you think of any qemu flags (cpu features, device emulation, etc)?
Any kernel subsystems with heavy arm-specific parts that we may be missing?
Testing some of the arm64 drivers that qemu can emulate may be the
most profitable thing.
Currently the instances use the following flags:
-machine virt,virtualization=on,graphics=on,usb=on -cpu cortex-a57
-machine virt,virtualization=on,mte=on,graphics=on,usb=on -cpu max

mte=on + virtualization=on is broken in the kernel on in the qemu:
https://lore.kernel.org/lkml/CAAeHK+wDz8aSLyjq1b=q3+HG9aJXxwYR6+gN_fTttMN5osM5gg@mail.gmail.com/
