Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1076B3A3F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhFKJmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFKJmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:42:19 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D868C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 02:40:06 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso5675013pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 02:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DG/MZpO/hjtRvZGvdauW0MMB98XC9pxZIIemqr9D2mA=;
        b=K6l4dDzXLv2kRPUWY+K+kCWFOxlkADsmtqAMwlZC8uBxi/kMiKxvPWGvDZuQyOPmEj
         U0M+oAk6szrx/Hjyua7kTrCnQjbm9jT9OrD6OTFpcA3hP9GOZhnTLh32K/bb/s0HUEHN
         QDKYMwkjMCj9Znapr6ItdpAjCpc72EKiQTrcvigX8TJ45XRNRwfHw2tjNNrnGnwWuHcR
         NSwXrONKzknwFGiQjvo3zKuTnFbnjCtNVnNWg+erbFCYZlSKrOLx+NrFhe7Ri9Y5TpJP
         p5E3Gkp18DeYOuDqHU1NeZXSF1rvZGsC4l4dSdYe3bi1ZA52sx9PxyVk7CcsoK3Tv3q8
         Qp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DG/MZpO/hjtRvZGvdauW0MMB98XC9pxZIIemqr9D2mA=;
        b=AxySLFJA4DS9EdyYe1pJd3I8NDJWQ24HMUpThCs8tMiY877bWW335JKp6lODptMu0t
         VSaYByFvnWgycaxkZSAty1M6rvHswe5OzCuYlHt6cj+CKz3BVcAucyon8S2QzSkBDNVH
         1+4BzOqcd5599Sy5v0gT4/bZ3Xnip5hN0YOc7+QBi/vNDZgOW9PGth4GKW11AE96OzyD
         dA7G2brqlEW9eDwu+6EFx2UQibEWZuWca8kgWVarSBPJ+ax8QhWp7sUPWOUhceDjYwBa
         pWRrTrCd28ZceAUplQsqV3EzzXdpdHsllbDUTTcRSAHRjXbK4tY7lqM8EM6XU82Qy0SJ
         WYqg==
X-Gm-Message-State: AOAM53161OuNCUBRo2ERUFIvMwOUiYx5+/6EE8XYmhKWZKo4HC5svqVG
        eU7Tt82VENYouTlvWt3cH60=
X-Google-Smtp-Source: ABdhPJyEwqk0A+dK/0pGaDhp/W57VGpZrx4ClsHT1p6EcCGweSbpc4HRj2nQw5wGt7SiWKInHbF0aw==
X-Received: by 2002:a17:902:7c92:b029:111:2ca8:3d8e with SMTP id y18-20020a1709027c92b02901112ca83d8emr3093148pll.77.1623404406142;
        Fri, 11 Jun 2021 02:40:06 -0700 (PDT)
Received: from bobo.ibm.com (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id o139sm4981655pfd.96.2021.06.11.02.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 02:40:05 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>
Subject: [PATCH v4 0/2] powerpc/64: Option to use ELF V2 ABI for big-endian
Date:   Fri, 11 Jun 2021 19:39:57 +1000
Message-Id: <20210611093959.821525-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since v3 I added Michael's module check for ELF ABI level. This requires
a change to core module code. If Jessica is happy with it it could go
via the powerpc tree.

Thanks,
Nick

Nicholas Piggin (2):
  module: add elf_check_module_arch for module specific elf arch checks
  powerpc/64: Option to use ELF V2 ABI for big-endian kernels

 arch/powerpc/Kconfig                | 22 ++++++++++++++++++++++
 arch/powerpc/Makefile               | 18 ++++++++++++------
 arch/powerpc/boot/Makefile          |  4 +++-
 arch/powerpc/include/asm/module.h   | 24 ++++++++++++++++++++++++
 arch/powerpc/kernel/vdso64/Makefile | 13 +++++++++++++
 drivers/crypto/vmx/Makefile         |  8 ++++++--
 drivers/crypto/vmx/ppc-xlate.pl     | 10 ++++++----
 include/linux/moduleloader.h        |  5 +++++
 kernel/module.c                     |  2 +-
 9 files changed, 92 insertions(+), 14 deletions(-)

-- 
2.23.0

