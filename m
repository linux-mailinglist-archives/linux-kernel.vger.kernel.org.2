Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3707731280F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 00:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBGXJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 18:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhBGXJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 18:09:48 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51825C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 15:09:07 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id n14so13191478iog.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 15:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=HdyA0s+fwumsV+3fF0vgkzOEo2XgjwQltCnt0iHV92Y=;
        b=hZq1JKQQrCz/CA64I50/s7t/L5io+9H9QP/Wh7NVCTh43b98X9E0LaRnDzfAGE+gad
         oT6msJzUQLaWYgKb640FF6ameiLfOLplyM401ItPVImBdcCAkU0rGyxxZ0SSbf3VTUFs
         DJ9Ji6OJ+rhk0y3dM9MuA86k+t9Zj4XizvVvHbLcNvK95/XpgFRLQUeuOzycPh31QoHF
         VUUz8SP69vuoRkaMn4JT32/N/XSXAkOxGipi9kLJji86riF2Ky1dS6zL4Ga++NXZwZOq
         ihyoPdKHeT4zt53ezB7/syYA1a8CD6dFXPGDVrvv2qTicPDLeOgZl0ou15m8p2BEDgWC
         e6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=HdyA0s+fwumsV+3fF0vgkzOEo2XgjwQltCnt0iHV92Y=;
        b=DvKDiSMq213OmBb3p0Pm1p2HkePr35WsIgAddSu1UXLADSiTrrM+9IQD3gxD+WMQpk
         RHJULGCT4ORgV70NmRLNqrjbwjcFyvM+t2Rq5GmnBSzzKFoxrRimecvo2yl+t2NxEzkS
         Gc68KL+gJbqPaU8tVN9ioW4g0P9smjwmA64Ix0cRe9v/KrANFkV3miUahUeS7KSDIns2
         0KSopnxc5R+LrAEaJI/c5FGIuQpP8iwSAMXLv0L2nSnilSTk20H3Cho46YZ7nQ1UPVTd
         68MOFFUD4tUsMw9uikVJrlvDBtRzGTM4xpXLLbjcjqt3zNORaxMVqdSAqJNu21wMo8/l
         ndrw==
X-Gm-Message-State: AOAM530c0A7BCvPynsk/2w4BLTXseugIi2Xi4P9gE+LizCEoaM/Rbp5t
        vcpvtBPmR9lRZzhmMuoyZNpZ4+A/q5nmJ2KzSSAhnSwBpd8Bmg==
X-Google-Smtp-Source: ABdhPJz1Oiro9Aou4IJtzHivKc/eJepaQlYcIQQ/Ads5QZL8n/t1O4dbcx6IrqM+3bxEsdxuIX7HRSEKZKCyVVA9QUI=
X-Received: by 2002:a05:6602:150a:: with SMTP id g10mr13258458iow.75.1612739346639;
 Sun, 07 Feb 2021 15:09:06 -0800 (PST)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 8 Feb 2021 00:08:55 +0100
Message-ID: <CA+icZUUhzpmoD_XrHtnFUGSpXHrVOTnVG9Q_Tek8oA8isHZe=Q@mail.gmail.com>
Subject: [Linux v5.11-rc7] x86: entry: Leftover of _TIF_SINGLESTEP define?
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Kyle Huey <me@kylehuey.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

congrats to Linux v5.11-rc7.

after commit 6342adcaa683 ("entry: Ensure trap after single-step on
system call return"):

$ git grep '\_TIF_SINGLESTEP' arch/x86/
arch/x86/include/asm/thread_info.h:#define _TIF_SINGLESTEP
 (1 << TIF_SINGLESTEP)

Is this a leftover and can be removed (now)?

Thanks.

Regards,
- Sedat -

[1] https://marc.info/?l=linux-kernel&m=161273724611262&w=2
[2] https://git.kernel.org/linus/6342adcaa683
