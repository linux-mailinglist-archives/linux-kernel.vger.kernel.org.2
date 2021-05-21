Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A961B38CE2D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 21:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239063AbhEUTbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 15:31:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20616 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233915AbhEUTbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 15:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621625387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W/zi/LtHS0XDym1cIKLNS5P4Tl2hUYuQ3Q4oc605Ruc=;
        b=WbWoRry5olkobyvisfXDrjy1jOgWBoap15a3NtexQoqSsp1a+QLRw77NcxUVvVtYglVzqE
        LJVM0wGKlVj+7+k1Ohidy4hdtWXsX+iflDDnbgAuDNip7agZSdOFDdJHopBlhyD1g7s6Ji
        mdA5zxA3wfWjKdaUW5zb3BUS6c5ghT8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-5VEm9NYgOBGg1vfzK35oyg-1; Fri, 21 May 2021 15:29:46 -0400
X-MC-Unique: 5VEm9NYgOBGg1vfzK35oyg-1
Received: by mail-wr1-f69.google.com with SMTP id q15-20020adfc50f0000b0290111f48b865cso6379305wrf.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 12:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W/zi/LtHS0XDym1cIKLNS5P4Tl2hUYuQ3Q4oc605Ruc=;
        b=iUZrFegN0lzCnnl2ABZEhAAYiispVYn3A/1yyEWUFpznqXGweDGI1u3C1pgayA+CiN
         xXHdodXy7BMqovmwm0MZHn1w+gTwVpJ3A0LVCSkGI3xCZEEEBf7EiUtHe5ub56g2mTp9
         k7P2EFCL/rDikVKobMLJcPRtL1aaonD2bI5ct4jtWy4gOo5jvpPbeBWGyyfiDlrNN04H
         skj5O7hwgc6jBwe2ttm77LaSHrp2A6FGQ9COfncWpQdd6NcuB4YlHM9z4vaZ5dGzq/6h
         MmMi0XWmk9pPcpnc1MTONCIFdaOzoEK2TFYf6QniEYGkDxd4BuHoRUJOreZfrllOU6kj
         96DA==
X-Gm-Message-State: AOAM530Y8vk6OvwaYa9JwJ0LYyeDC2Pqjv20qaJA0Z1FJy2rBgBfpyHg
        +HTcs86O7fCa/xPp9q76Ksu9kKeoFAWz9SmsVIXZGMcFgjQHXClMmsmZTfspN/0YpOQdaV5PJ7y
        YfL3KdcLNpil+DAPTxhZdKHlFVimN8/N2FK1p+XAGq4Oiphj8ZA3LyjEgg0xJRbMX1oILHwWqiJ
        A=
X-Received: by 2002:a05:600c:4b92:: with SMTP id e18mr10110502wmp.71.1621625384808;
        Fri, 21 May 2021 12:29:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/OyYpeLIFQQtA9P7euza3ZHBvS4POGpr3Wcj1AR1IOx4wP4WYkmEu/V4dSruhwNMjfWVl2Q==
X-Received: by 2002:a05:600c:4b92:: with SMTP id e18mr10110469wmp.71.1621625384534;
        Fri, 21 May 2021 12:29:44 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id s7sm434402wmh.35.2021.05.21.12.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 12:29:43 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Peter Robinson <pbrobinson@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
Subject: [PATCH 0/2] allow the sysfb support to be used in non-x86 arches
Date:   Fri, 21 May 2021 21:29:04 +0200
Message-Id: <20210521192907.3040644-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The x86 architecture platform has a Generic System Framebuffers (sysfb)
support, that register a system frambuffer platform devices. It either
registers a "simple-framebuffer" for the simple{fb,drm} drivers or legacy
VGA/EFI FB devices for the vgafb/efifb drivers.

Besides this, the EFI initialization code used by other architectures such
as aarch64 and riscv, has similar logic but only register an EFI FB device.

The sysfb is generic enough to be reused by other architectures and can be
moved out of the arch/x86 directory to drivers/firmware, allowing the EFI
logic used by non-x86 architectures to be folded into sysfb as well.

Patch #1 in this series do the former while patch #2 the latter. This has
been tested on x86_64 and aarch64 machines using the efifb, simplefb and
simpledrm drivers. But more testing will be highly appreciated, to make
sure that no regressions are being introduced by these changes.

Since this touches both arch/{x86,arm,arm64,riscv} and drivers/firmware, I
don't know how it should be merged. But I didn't find a way to split these.

Best regards,
Javier


Javier Martinez Canillas (2):
  drivers/firmware: move x86 Generic System Framebuffers support
  drivers/firmware: consolidate EFI framebuffer setup for all arches

 arch/arm/Kconfig                              |  1 +
 arch/arm/include/asm/efi.h                    |  5 +-
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/include/asm/efi.h                  |  5 +-
 arch/riscv/Kconfig                            |  1 +
 arch/riscv/include/asm/efi.h                  |  5 +-
 arch/x86/Kconfig                              | 27 +-----
 arch/x86/kernel/Makefile                      |  3 -
 drivers/firmware/Kconfig                      | 30 +++++++
 drivers/firmware/Makefile                     |  2 +
 drivers/firmware/efi/Makefile                 |  2 +
 drivers/firmware/efi/efi-init.c               | 90 -------------------
 .../firmware/efi}/sysfb_efi.c                 | 79 +++++++++++++++-
 {arch/x86/kernel => drivers/firmware}/sysfb.c | 42 +++++----
 .../firmware}/sysfb_simplefb.c                | 31 ++++---
 .../x86/include/asm => include/linux}/sysfb.h | 34 +++----
 16 files changed, 182 insertions(+), 176 deletions(-)
 rename {arch/x86/kernel => drivers/firmware/efi}/sysfb_efi.c (84%)
 rename {arch/x86/kernel => drivers/firmware}/sysfb.c (70%)
 rename {arch/x86/kernel => drivers/firmware}/sysfb_simplefb.c (82%)
 rename {arch/x86/include/asm => include/linux}/sysfb.h (68%)

-- 
2.31.1

