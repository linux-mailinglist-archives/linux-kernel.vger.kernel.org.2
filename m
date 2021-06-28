Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F013B5994
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhF1HSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbhF1HSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:18:49 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07338C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:16:23 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w17so8768352edd.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HE4kAf9v/HVTvl+fCz/1PFgMPjpruylsj/5H2BJsWMY=;
        b=Ld42qfWBcAE+jW4tyt5mdalHT9Byh+JWv9S5pGBYoGNiq0hdcfHVKK7hhWJfCBh/6D
         +ujx/N7t8eSGgraJURWqDsaV+52yyBe/JqjOz7Jeiii94mcYDt4VbBfWNSOOMo1L0Ys0
         4d2aTyzN0vOm8/j3mKtG2RgDi8xLw++Rg/nkm0Ak8ZnBD5MI6FAeTScPt0TQtkTYB4UK
         o/vFYZx4Uj5mddAfrTxMNI9ZiSdR6DN0tlxYoMaDXYgcwomixqUPGLkKN/wYcDU/Tz+p
         pyC6WNb0yTPvIa05RawIVYlwdHN1+/BRZq8AH+/zo8Lm9Y38vqe0mdxoeU+pfZ2pl0PG
         lkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=HE4kAf9v/HVTvl+fCz/1PFgMPjpruylsj/5H2BJsWMY=;
        b=rS74PPiktyK6moFjyzy9auILMqhdONw0hja/RC0Dl2Yuic/HaQXXJxroJhpsY6Snmv
         WxT6mHo/ST/ew5ERswA4x80sRmGvLLVk/ctT5LHrNxX91b1dRLD06NuzoLvNH2N538WT
         2byPOvQyhAwAvraHTIAxRz25MX+YoI/HuY2aS3SFXlQGX/rCTes+kQ45SDv4H5hfIEVI
         zSxqYFrkDIbqj+q8k+ihL8lduFG41kMocQCQqE1+4rNZT+8iS2C7ORMXs7DVWGianLnh
         dGpeFt/J0am1/AmkptHRsuFiNx/6CkB4jpKA+kHVDNLYnQfH5jdrXum2yBFNt2mAvRy+
         i32Q==
X-Gm-Message-State: AOAM532hgRHLzUGMaeBRCrmECdjVtu8seagNeCyBTkNnOTsS1Mmp1Fw9
        cgH/FnCFwwyw8p7oyC2LCBE=
X-Google-Smtp-Source: ABdhPJx0KmII7rVzJnv8+VHieX0RQSVYa2ob1/xBuhl5IGygs4D0ApMPYiWm5shcpeCaPBwkqXFvig==
X-Received: by 2002:aa7:c644:: with SMTP id z4mr30549281edr.204.1624864581682;
        Mon, 28 Jun 2021 00:16:21 -0700 (PDT)
Received: from gmail.com (94-21-131-96.pool.digikabel.hu. [94.21.131.96])
        by smtp.gmail.com with ESMTPSA id em20sm6470773ejc.70.2021.06.28.00.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 00:16:21 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Jun 2021 09:16:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/apic changes for v5.14
Message-ID: <YNl3QyBaWSwC9X/H@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/apic git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2021-06-28

   # HEAD: 1dcc917a0eed934c522d93bb05a9a7bb3c54f96c x86/idt: Rework IDT setup for boot CPU

CPU setup code changes:

 - Clean up & simplify AP exception handling setup.

 - Consolidate the disjoint IDT setup code living in
   idt_setup_traps() and idt_setup_ist_traps() into
   a single idt_setup_traps() initialization function
   and call it before cpu_init().

 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      x86/cpu: Init AP exception handling from cpu_init_secondary()

Thomas Gleixner (1):
      x86/idt: Rework IDT setup for boot CPU


 arch/x86/include/asm/desc.h      |  2 --
 arch/x86/include/asm/processor.h |  1 +
 arch/x86/kernel/cpu/common.c     | 28 +++++++++++++++-------------
 arch/x86/kernel/idt.c            | 40 ++++++++++++----------------------------
 arch/x86/kernel/smpboot.c        |  3 +--
 arch/x86/kernel/traps.c          |  9 +++------
 6 files changed, 32 insertions(+), 51 deletions(-)
