Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB6944F31A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 13:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbhKMMoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 07:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbhKMMoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 07:44:17 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BF8C061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 04:41:25 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id z2-20020a9d71c2000000b0055c6a7d08b8so18311857otj.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 04:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/PgY4qujDAFSBh6iQoM3wC1Nu5lLrukTseSggTlKAq0=;
        b=Nfey1b3fofuF6n4I0c948wLgvpoyKe80yDDLY39CBgD/VKey6sFzW19OaRlIcemRBS
         8dx0EsLHwCojObYFbTeFATA7HvN5jUOTA+fjanbCkS6Xx77B6tU4y8oSotOHk8IMrlMF
         Krq+3Z9nv7mwjcQmCfy6QN0HQa0QNHV/of5scKprE8M0pByPVRZ09XqIzlwDbcYuzJJr
         MEXu5UUPq9NkiaKci+3MlvZ93OA/c8K5mtIb8bLrLMcY6QGKA5Jfnkb1upnN+YxgH4ZZ
         mxGb1Lkd2Os03IHBnZaCk9Aj05gAqbEzTRX88VIqEyz6XMrhfSYNzLauPG7fAYR2+Zsa
         x3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/PgY4qujDAFSBh6iQoM3wC1Nu5lLrukTseSggTlKAq0=;
        b=kG9LXySrDz3MUOIrSikItv1BN324Ukuaym496tG98mYEZ7p+hMC+GrQBct1VjPnVBQ
         5QkAmn+72EPdTRSwhwJf+Mlz19xyNzNfnYeVLQDPavoD7Eo9MvcgqSPCy5SuNj1HqBG0
         NY1rdpaIRd3c1DhsQOfFzllL17qrg4ftES2b0o4rm045DSimv4Q5BZUegM5X1yRePFiY
         oJsBlUGCJmn3GCZZdN1KO6bPYj+u3r4gy/akoz7ldydBkh3j38eG8jOUFHsWMsemia9A
         Z3PMQeISmt2FxHEmEIAA+ak5SvjVKsrBYxBIz8uBzx7obZUguSq14ot+cPfVvIpQ7Xvg
         Nw9Q==
X-Gm-Message-State: AOAM5310SS/6mc6HZQ6/hIf5v5H2N9Q+o/jymuVKtJ08fBEu+yrKYDL5
        L82Vz/Ds4wBkv2hmuRqUjqQ2hqmKFQ==
X-Google-Smtp-Source: ABdhPJxFY7AIre1DLAjbF1Ngfn84+6fKtXx6+vqd0DBfwFzsXYgkTT1Ak5cMPmIR6u3DoD/2g8l4GQ==
X-Received: by 2002:a05:6830:1688:: with SMTP id k8mr18323586otr.238.1636807284711;
        Sat, 13 Nov 2021 04:41:24 -0800 (PST)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id x8sm1796675otg.31.2021.11.13.04.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 04:41:24 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 0/3] x86-64: Stack protector and percpu improvements
Date:   Sat, 13 Nov 2021 07:40:32 -0500
Message-Id: <20211113124035.9180-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, x86-64 uses an unusual per-cpu layout, where the percpu section
is linked at absolute address 0.  The reason behind this is that older GCC
versions placed the stack protector (if enabled) at a fixed offset from the
GS segment base.  Since the GS segement is also used for percpu variables,
this forced the current layout.

GCC since version 8.1 supports a configurable location for the stack
protector value, which allows removal of the restriction on where the percpu
data is linked.  Compatibility with older compilers is maintained until
the minimum compiler version is raised.

Brian Gerst (3):
  x86-64: Use per-cpu stack canary if supported by compiler
  x86/relocs: Make absolute percpu relocations conditional
  x86_64: Use relative per-cpu offsets

 arch/x86/Kconfig                      |  9 +++++++++
 arch/x86/Makefile                     | 21 ++++++++++++++-------
 arch/x86/boot/compressed/Makefile     |  3 ++-
 arch/x86/entry/entry_64.S             |  6 +++++-
 arch/x86/include/asm/percpu.h         |  4 ++--
 arch/x86/include/asm/processor.h      | 14 +++++++++++---
 arch/x86/include/asm/stackprotector.h | 17 ++++++-----------
 arch/x86/kernel/asm-offsets_64.c      |  2 +-
 arch/x86/kernel/cpu/common.c          | 14 ++++++++------
 arch/x86/kernel/head_64.S             | 12 ++++++++----
 arch/x86/kernel/setup_percpu.c        |  2 +-
 arch/x86/kernel/vmlinux.lds.S         | 16 +++++++---------
 arch/x86/tools/relocs.c               |  4 ++--
 arch/x86/tools/relocs.h               |  4 ++--
 arch/x86/tools/relocs_common.c        | 11 ++++++++---
 arch/x86/xen/xen-head.S               | 10 ++++------
 init/Kconfig                          |  1 -
 17 files changed, 90 insertions(+), 60 deletions(-)

-- 
2.31.1

