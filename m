Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442A038F2CE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 20:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhEXSSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 14:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbhEXSSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 14:18:52 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACDEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 11:17:23 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id o21so28770723iow.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 11:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5HossqTUHmTLMkJQAdkTAPvwRi9BZRobsSMf/x24NEA=;
        b=qnbdl9mSK0gRlIyIBpQAw55vd2BobvfzzLbsIrDshp7kMH0KTt5JOF//LumDgRstAX
         Dr4p/zLm+4i2ecE00kZF27T5/0Z1zEUMln2bXDLbmDnLXL42fhPgWH+q673fX6SD1loW
         vzFNoBllhf796n03uVw5hodkzYtZfofu+FDQg8mhViT6E/YNaXY43kcxydZ3SEIlrddg
         iK5m3Jfe/fQVYT5wa+rPaV8QLT8Y1G5+ADy7fsEYXWA0iX2Iva9ocdssDkwgZfatdC4y
         MRHjgxMCYkJAJDswVZd43v3xVdLeiu2RvGSSefWPBC9bbVtYNb73gAOPRe71MXEooByl
         ZE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5HossqTUHmTLMkJQAdkTAPvwRi9BZRobsSMf/x24NEA=;
        b=efeHhDsULVpJVNfYxW3GbZSx1ZFMvfX0DTlzmiHgCJa3P6MInFVqA+Ak9o30IzvDD+
         YD2cp4FSdUNDmwC8IF985pYAz/fKzVR9E3yREzZAmbrgEr59q4swES8gB+0lDFTZeZhg
         58T7dvzeiQICNwVyaMvIHzmn2m4qJ9HxPy9ia4B5zKzNMlTAmhpPXnEj5j81jFm46DsD
         Ihg9QRmw+y3CoTXagL2/muGLRywUj13s+E/9tVm83EYNVlGB0mfM+9uq/eUkVtjJqwrX
         y50OKuEl5P4sEYwWL5b8/3spUJvembVIytnrzEpqvhVmtEGtgTSjbfJflS4mNxwloK+S
         8QWg==
X-Gm-Message-State: AOAM533RHXTv89judJogX58UpuymuiYGQOZ1cZBcQ/f3lF+FxW5E1pe8
        ioMWHD16dcYqypfe4jB3HavtrkaQTA==
X-Google-Smtp-Source: ABdhPJxvm3BcBsx990yIqBZ5x15t+LdQlezIkKdq8uMdZXa8ITvovCYjy8gu9n0BupFItOsqX64E+g==
X-Received: by 2002:a6b:3b4c:: with SMTP id i73mr16793107ioa.149.1621880242595;
        Mon, 24 May 2021 11:17:22 -0700 (PDT)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id p5sm11863673ilg.33.2021.05.24.11.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 11:17:21 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 0/3] x86: Syscall table cleanups
Date:   Mon, 24 May 2021 14:17:04 -0400
Message-Id: <20210524181707.132844-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a few patches following up to the syscall table generation
patches that are now in the -tip tree.

Brian Gerst (3):
  x86/uml/syscalls: Remove array index from syscall initializers
  x86/syscalls: Remove -Wno-override-init for syscall tables
  x86/syscalls: Don't sdjust CFLAGS for syscall tables

 arch/x86/entry/Makefile         | 10 ----------
 arch/x86/um/sys_call_table_32.c |  2 +-
 arch/x86/um/sys_call_table_64.c |  2 +-
 3 files changed, 2 insertions(+), 12 deletions(-)

-- 
2.31.1

