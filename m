Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E0B3B4419
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 15:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhFYNM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 09:12:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231305AbhFYNMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 09:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624626601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vvZL1fz2dwOb7Upqb55JPmmwYtiHqp1yiqdJ6Cauu30=;
        b=iqzecFy2DKuHSWLo+Kq2F0j1mvrE634KN95PcAn7ghoEMVlcGYMMSMkon01HQQqFtX8f/V
        UBlH4lWEvQ1TlU9AvDtZ+xOJm4ZOZttZbcNZStTCn5VBJmpKKO19Uis5Ze8nZvZJeVCq6S
        VxKHjJVsQyvFiZL281Y6vaSdWm8YNM8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-9GpwBW2_P0qEkxW-Y4rsOw-1; Fri, 25 Jun 2021 09:10:00 -0400
X-MC-Unique: 9GpwBW2_P0qEkxW-Y4rsOw-1
Received: by mail-wm1-f71.google.com with SMTP id v25-20020a1cf7190000b0290197a4be97b7so2688772wmh.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 06:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vvZL1fz2dwOb7Upqb55JPmmwYtiHqp1yiqdJ6Cauu30=;
        b=MJeHsmXCSfSotR8YSi1OHPQrVO9LMHc+JrNTXkoSn88xcQrIjUK7RazBRQCoaLE3gP
         D5ACv8VtOhuo1RBtagROhQAiFZIsGY6+G0mTLiSsnwuTbF3mJ1UIYaPfrbdW8p0oqwZ5
         H5VnJ+QjVrbNpPrxM2jSCC06rPFpzIB/jCFwZ7JE46aV9nBv/b7EeMNBrkOQOUaHi68F
         ydO4nW+zbP+nRLHQG/ekPosXhL0WQpmOHD0kINsFu3RfU3DzZv2hWopd/w5EVqqadhbm
         vX7PBor2zYkqRD5FrB7CagyLDKIuNhtaElMFoEos6jMUbQT0ecg++p99hb9n0OzvNB2H
         gBPA==
X-Gm-Message-State: AOAM530XbhQaIYu4DBFUtnTNulAYZm5Sedm2kvw9y3XBIalCFv8Zn2cK
        bHW1jRchq/L2AnLPt9B+bWTRQQNZalUZcDYvVdyP+QxxhvVzng8+LC0ybD/fh3MABN4K+sCFZwl
        nYrC796DCR3YaJMG1/7Z8vm8WKh4HsJc/BUd9RBftAwcCP/i30dH0muy1xH2egWlReSBNagfcQv
        Y=
X-Received: by 2002:a5d:4b88:: with SMTP id b8mr10869862wrt.95.1624626599192;
        Fri, 25 Jun 2021 06:09:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxac5aAuPdj78okqR8e93aZVHiRH/QUWQDePxg/s70gh/LhsMF19zX80NB6m3SpVsyLwyMfkA==
X-Received: by 2002:a5d:4b88:: with SMTP id b8mr10869804wrt.95.1624626598911;
        Fri, 25 Jun 2021 06:09:58 -0700 (PDT)
Received: from minerva.redhat.com ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id x7sm5995864wre.8.2021.06.25.06.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 06:09:58 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, Borislav Petkov <bp@suse.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Robinson <pbrobinson@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v3 0/2] allow simple{fb,drm} drivers to be used on non-x86 EFI platforms
Date:   Fri, 25 Jun 2021 15:09:45 +0200
Message-Id: <20210625130947.1803678-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simplefb and simpledrm drivers match against a "simple-framebuffer"
device, but for aarch64 this is only registered when using Device Trees
and there's a node with a "simple-framebuffer" compatible string.

There is no code to register a "simple-framebuffer" platform device when
using EFI instead. In fact, the only platform device that's registered in
this case is an "efi-framebuffer", which means that the efifb driver is
the only driver supported to have an early console with EFI on aarch64.

The x86 architecture platform has a Generic System Framebuffers (sysfb)
support, that register a system frambuffer platform device. It either
registers a "simple-framebuffer" for the simple{fb,drm} drivers or legacy
VGA/EFI FB devices for the vgafb/efifb drivers.

The sysfb is generic enough to be reused by other architectures and can be
moved out of the arch/x86 directory to drivers/firmware, allowing the EFI
logic used by non-x86 architectures to be folded into sysfb as well.

Patch #1 in this series do the former while patch #2 do the latter. It has
been tested on x86_64 and aarch64 machines using the efifb, simplefb and
simpledrm drivers. But more testing will be highly appreciated, to make
sure that no regressions are being introduced by these changes.

The series touches different subystems and will need coordination between
maintainers but the patches have already been acked by the x86 folks. Ard
Biesheuvel said that these could be merged through the EFI tree if needed.

Best regards,
Javier

Changes in v3:
- Add Borislav and Greg Acked-by tags.
- Also update the SYSFB_SIMPLEFB symbol name in drivers/gpu/drm/tiny/Kconfig.
- We have a a max 100 char limit now, use it to avoid multi-line statements.
- Figure out the platform device name before allocating the platform device.

Changes in v2:
- Use default y and depends on X86 instead doing a select in arch/x86/Kconfig.
- Also enable the SYSFB Kconfig option when COMPILE_TEST.
- Improve commit message to explain why is useful for other arches to use this.
- Use "depends on" for the supported architectures instead of selecting it.
- Improve commit message to explain the benefits of reusing sysfb for !X86.

Javier Martinez Canillas (2):
  drivers/firmware: move x86 Generic System Framebuffers support
  drivers/firmware: consolidate EFI framebuffer setup for all arches

 arch/arm/include/asm/efi.h                    |  5 +-
 arch/arm64/include/asm/efi.h                  |  5 +-
 arch/riscv/include/asm/efi.h                  |  5 +-
 arch/x86/Kconfig                              | 26 ------
 arch/x86/kernel/Makefile                      |  3 -
 drivers/firmware/Kconfig                      | 32 +++++++
 drivers/firmware/Makefile                     |  2 +
 drivers/firmware/efi/Makefile                 |  2 +
 drivers/firmware/efi/efi-init.c               | 90 -------------------
 .../firmware/efi}/sysfb_efi.c                 | 78 +++++++++++++++-
 {arch/x86/kernel => drivers/firmware}/sysfb.c | 37 +++++---
 .../firmware}/sysfb_simplefb.c                | 33 ++++---
 drivers/gpu/drm/tiny/Kconfig                  |  4 +-
 .../x86/include/asm => include/linux}/sysfb.h | 32 +++----
 14 files changed, 180 insertions(+), 174 deletions(-)
 rename {arch/x86/kernel => drivers/firmware/efi}/sysfb_efi.c (84%)
 rename {arch/x86/kernel => drivers/firmware}/sysfb.c (75%)
 rename {arch/x86/kernel => drivers/firmware}/sysfb_simplefb.c (81%)
 rename {arch/x86/include/asm => include/linux}/sysfb.h (70%)

-- 
2.31.1

