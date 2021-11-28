Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B234602A0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 01:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356749AbhK1Asi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 19:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356690AbhK1Aqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 19:46:37 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D597AC061574
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 16:43:21 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id i9so13045689ilu.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 16:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=1SEnnhSDtFX7zCcC2R4UoBpLdS3gZaSbU/hF2We3+T4=;
        b=oiJkbRrQaHKLTeb3XKhg12M7kQkruz2LtXDw5iUOHQfN9LbDBYUDmyPHgG8nYVEvjE
         20L58M51mMDHrV+MzS9fLIsHeSCVtCtcjnavndPGiI/XmEWmIadJvXdnSANtIYYBBTdX
         qOxQ0uK6r3gPt5oT1giecxQacuUcyfHalp/UrOB0CGemSq4uSb4XDp+FfnO7QZzccXqg
         RuEN6YZQ+H4XsvppiH+EFTVlNUUluJrByr7We4JgJcuOFsKAMcai46NDASTrlfFnhWOv
         tq/FxOm5gIBoWVd2fcTYW1h4b7vMFvO+YuMM0ptgtiUDyMQ5hit80nvCdfqFAY9XEC2p
         s3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1SEnnhSDtFX7zCcC2R4UoBpLdS3gZaSbU/hF2We3+T4=;
        b=A/yffC9ORZOvLJzXCqFV0TYiTrLYkovZ8FsFMXQE4WhQPP2hRG/7HqLxvJhTgHBKiJ
         uU78cgNlXnQ4Gr5OZTG5tFm3okc6mUGTrt7NmF/KMb0dmvaaBi9YEf6/+nYiyh2BPwuw
         mxcW9PsnOzxVFydJaaEHvPDV1eho9PUsfcyD5kZNAsGiz1wHj/mUZ9GpMkvBLiwHLMau
         Hm5nvYWDYN917ZeV4LxvMExeUSJsPFfC4BHnYlK8LW1QgdINO5CObBQsuwjla2R5QVTp
         K5xAlndihHub5Q4QgWmWLrLHsvksbmKuAT/oE+/vSa11MfiXT0MHzQIAnwVGX9U6doIe
         rFAg==
X-Gm-Message-State: AOAM533NyulRLmbUk34kLPq2qtuv3QDnoDRi0dzVIoRHIZ4dKaGG01Yu
        3/nKa0FzU7Kbzv0HSGV5D6FjK+jNjWqX69JNexc=
X-Google-Smtp-Source: ABdhPJyxrN5rdjT/ej4awloInJwi98+D+OdXLG+Coy/pNeOcPTCgfrvZRVlolzg1Dqa9zV/nChTHdKIp10yENb8LK98=
X-Received: by 2002:a92:da0f:: with SMTP id z15mr44768055ilm.151.1638060200327;
 Sat, 27 Nov 2021 16:43:20 -0800 (PST)
MIME-Version: 1.0
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 28 Nov 2021 01:43:09 +0100
Message-ID: <CANiq72kGS0JzFkuUS9oN2_HU9f_stm1gA8v79o2pUCb7bNSe0A@mail.gmail.com>
Subject: KASAN Arm: global-out-of-bounds in load_module
To:     kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi KASAN / Arm folks,

I noticed in our CI that inserting and removing a module, and then
inserting it again, e.g.:

    insmod bcm2835_thermal.ko
    rmmod bcm2835_thermal.ko
    insmod bcm2835_thermal.ko

deterministically triggers the report below in v5.16-rc2. I also tried
it on v5.12 to see if it was a recent thing, but same story.

I could find this other report from May, which may be related:
https://lore.kernel.org/lkml/20210510202653.gjvqsxacw3hcxfvr@pengutronix.de/

Cheers,
Miguel

BUG: KASAN: global-out-of-bounds in load_module+0x1b98/0x33b0
Write of size 16384 at addr bf000000 by task busybox/17

CPU: 0 PID: 17 Comm: busybox Not tainted 5.15.0 #7
Hardware name: Generic DT based system
[<c010f968>] (unwind_backtrace) from [<c010c6f8>] (show_stack+0x10/0x14)
[<c010c6f8>] (show_stack) from [<c0210734>]
(print_address_description+0x58/0x384)
[<c0210734>] (print_address_description) from [<c0210cc8>]
(kasan_report+0x168/0x1fc)
[<c0210cc8>] (kasan_report) from [<c0211230>] (kasan_check_range+0x260/0x2a8)
[<c0211230>] (kasan_check_range) from [<c0211c68>] (memset+0x20/0x44)
[<c0211c68>] (memset) from [<c019d21c>] (load_module+0x1b98/0x33b0)
[<c019d21c>] (load_module) from [<c0199f88>] (sys_init_module+0x198/0x1ac)
[<c0199f88>] (sys_init_module) from [<c0100060>] (ret_fast_syscall+0x0/0x48)
Exception stack(0xc113ffa8 to 0xc113fff0)
ffa0:                   00000000 00002a98 00098038 00002a98 00081483 00093f88
ffc0: 00000000 00002a98 00000000 00000080 00000001 b66ffef0 00081483 000815c7
ffe0: b66ffbd8 b66ffbc8 000207f5 00011cc2


Memory state around the buggy address:
 bf001200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 bf001280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>bf001300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f9 f9
                                                     ^
 bf001380: 00 00 07 f9 f9 f9 f9 f9 00 00 00 00 00 00 00 00
 bf001400: 00 00 f9 f9 f9 f9 f9 f9 00 00 04 f9 f9 f9 f9 f9
