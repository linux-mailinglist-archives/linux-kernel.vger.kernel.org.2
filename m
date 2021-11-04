Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB1D444DA4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 04:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhKDDSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 23:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhKDDSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 23:18:35 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB5CC061714;
        Wed,  3 Nov 2021 20:15:57 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id c185-20020a4a4fc2000000b002bce4df242cso1484769oob.10;
        Wed, 03 Nov 2021 20:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=IQiSfMABY2BmcOaT3K2js31u9lHbxR0SNOCD5CqZ2pM=;
        b=eMS3ZJT3B2T0nGYYNjaqmEZbIn/PIYHNIe/YZkN6tbNtC3izSuaTTm4bZk4qyx1jAM
         JUfVXmSpMNVJZonYCIqXBv1VtNl9lZIXq8MhqT1qCmbMqqXO8cQpn58aDzU0pzsm177L
         mfLdb8T0zUA8rdhRJO9rdRQSS04ft4Wcs/sSz25atXye3dgvvNwNDMWD8BLA3GRp2iPv
         Iq0gOznJ5gEe/OZr0o5hRMTc9+wLKUQ2epG66Osgmfu7LoiQKwfNzKYUvehXUNbABpN4
         x25nsZ5Ohg+4RNXDUmpCSK2hqzJ7qJuOqrBHbmgZo73sRzUptF9vffeOFG35Hl+N/nj8
         MKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=IQiSfMABY2BmcOaT3K2js31u9lHbxR0SNOCD5CqZ2pM=;
        b=CtCxQGjsKwxZPUYN9H+Xk7uaMepitppn7PIME4Fv+6fBRHpe8UreLDETzFvScXZ5FT
         GV3ZAj1FnSJPmn89lCFfD5zT00pGrGxdr0qkmrCLaDNRrkYY2Rh4ZHjBcpV2UU8B5sem
         Bjgn6LZzBJrUa68bASS7BOmQ6Rj4A9ntRZ5Q2KicipRUgX8nwQC7rDK3XaFjln4M//B7
         ZyukmVxiUFQ83p8Rk7iRq2eFbTr8SpKsaWCWLyOnbqe7rk4h5z1Brzd2lRoVn9/FJIMc
         iJIcwe37aXaE25ecrzS/k4POs23RdZyZywrAdxIdlgbncXyJ1l2z/uc8ONLx26d9iOtR
         wnpQ==
X-Gm-Message-State: AOAM533N3TRzyTWu1cv+AukkDp2PPAWYi9GpciMyA8kd5hqmCBcwUphX
        7k++LtFrFOhwVRf2L5HWxWkTmXC6rdQ=
X-Google-Smtp-Source: ABdhPJzEDock9bIQGDZrobXq/mOMFZaARJzpRfCc1YTVQx9Ori4hhqkDQ0hPIKSFYGxFk+ZVCqd9sw==
X-Received: by 2002:a4a:6f59:: with SMTP id i25mr1795614oof.78.1635995756901;
        Wed, 03 Nov 2021 20:15:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h7sm1075291otn.11.2021.11.03.20.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 20:15:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 3 Nov 2021 20:15:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>, Helge Deller <deller@gmx.de>,
        linux-parisc@vger.kernel.org
Subject: parisc build failures in mainline kernel
Message-ID: <20211104031554.GA34798@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the mainline kernel fails to build almost all 'parisc' images.

The first build error is

In file included from <command-line>:
include/linux/sched.h: In function 'task_cpu':
include/linux/sched.h:2129:45: error: 'const struct thread_info' has no member named 'cpu'
 2129 |         return READ_ONCE(task_thread_info(p)->cpu);
      |                                             ^~

with many follow-up errors.

bisect points to commit (merge) 01463374c50e ("Merge tag
'cpu-to-thread_info-v5.16-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux" as the culprit,
and reverting that merge does indeed fix the problem.

Guenter

---
bisect log:

# bad: [79ef0c00142519bc34e1341447f3797436cc48bf] Merge tag 'trace-v5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
# good: [8bb7eca972ad531c9b149c0a51ab43a417385813] Linux 5.15
git bisect start '79ef0c001425' '8bb7eca972ad'
# good: [8cb1ae19bfae92def42c985417cd6e894ddaa047] Merge tag 'x86-fpu-2021-11-01' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 8cb1ae19bfae92def42c985417cd6e894ddaa047
# bad: [73d21a3579818aa0e39de207474a39ca35c7d8cb] Merge tag 'media/v5.16-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect bad 73d21a3579818aa0e39de207474a39ca35c7d8cb
# good: [c2c88a07d679839ddf236db55b258aaedff819ad] media: Add ADV7610 support for adv7604 driver.
git bisect good c2c88a07d679839ddf236db55b258aaedff819ad
# good: [46f876322820c189ab525cfcba2519a17dbc0a6f] Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect good 46f876322820c189ab525cfcba2519a17dbc0a6f
# bad: [2dc26d98cfdf756e390013fafaba959b052b0867] Merge tag 'overflow-v5.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
git bisect bad 2dc26d98cfdf756e390013fafaba959b052b0867
# good: [03feb7c55c470158ece9afb317c395cd65bd14ac] Merge tag 'm68k-for-v5.16-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k
git bisect good 03feb7c55c470158ece9afb317c395cd65bd14ac
# good: [caf283d040f53bc4fd81ce3d2a1a364b069cfd7d] xfrm: Use memset_after() to clear padding
git bisect good caf283d040f53bc4fd81ce3d2a1a364b069cfd7d
# bad: [01463374c50e4fe75abec927fa231f8f5d701852] Merge tag 'cpu-to-thread_info-v5.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
git bisect bad 01463374c50e4fe75abec927fa231f8f5d701852
# good: [227d735d889e0403f1659df6e2dece7633f380bc] powerpc: add CPU field to struct thread_info
git bisect good 227d735d889e0403f1659df6e2dece7633f380bc
# good: [336868afbaae2d153fc20268a21747c31e5071b8] powerpc: smp: remove hack to obtain offset of task_struct::cpu
git bisect good 336868afbaae2d153fc20268a21747c31e5071b8
# good: [d9f2a53f64a6fcae994457e64a7124d2a3efd323] Merge tag 'pr-move-task-cpu-to-ti' of git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
git bisect good d9f2a53f64a6fcae994457e64a7124d2a3efd323
# first bad commit: [01463374c50e4fe75abec927fa231f8f5d701852] Merge tag 'cpu-to-thread_info-v5.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
