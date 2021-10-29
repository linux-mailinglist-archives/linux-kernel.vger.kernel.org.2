Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447E244041F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 22:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhJ2Udp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 16:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhJ2Udl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 16:33:41 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A28C061766
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 13:31:12 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id u25so7165286qve.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 13:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oOz/QW39X2u1dyKTn5aFuheScvAepxDUeUy96qyRoLg=;
        b=m4/quTXPx2h8fJLut1EE+FY7AlkEZ1db/lxc+YZFwK4t5PSr2dBTCN7Oq7iSSBRW9Q
         cC+/DieAVxvUKhye4nbOuXCny0B9L+DF8fTz7UJY63v0KsYO5SnHvRMJwLkl07nQoJE5
         S2p2glACSw3KbGLoGK0+R8hGeEu8gd25iCeoH+y5E6C7cmKmo/J4rjNuWtwhPnF7aPVu
         w/Nq2pdYiwNjHTLAckItaU6m26E4kF6ebbC54uKqCPwiH/yhEvP5pIG85EowRh3gi59k
         b7v2ogiECGUOFkXk7ywtp1Ll/rZYiguanhepVIHBt0KCj1vpb5g/m5mYuvEQ4wb2h7mf
         1jtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=oOz/QW39X2u1dyKTn5aFuheScvAepxDUeUy96qyRoLg=;
        b=Had/du0D4PbbGjumzx/RvSSpJnLBNSauLJMOQfsop0WFY12VTMpSTKZGjoISzi09S0
         dkTLGmdTMGQs9Mixzyro9rajbptCrYmB1N3A+l2aNhj9iL6BIdOu579s4hOiS+kltwuJ
         WIwupxiOJbtvb46D0M4DV+jHFDVfMehp4zv6XFGNm2gUz1ZBQwazPborK4EeY7p8nrcl
         OEIVjpLjYOxRjJMJBMFqeIoJlufmojFn4pnAP3qli27Jy9avJg0RISHJean4VHhEbI6E
         4i4JFmTpMAcwF3UA7tTwBhQQXeJkGkrGJE5vChM/x1YYgffcZlLzWiu3LgjyagiLlY84
         csCQ==
X-Gm-Message-State: AOAM532bMHqFT5fybeAHlGIyu8VlXhKg7FGv/9ggWK8HNLG4lFLfuwoZ
        hLzmJeJV/TL5YipV6mDZgGA=
X-Google-Smtp-Source: ABdhPJy6YCO3iqrdlMk55p0ushMNaePImfzdeadXzq1AhryvefzMzRd92fcclrZz0BYrDWckUMsmxA==
X-Received: by 2002:a05:6214:1089:: with SMTP id o9mr2704242qvr.62.1635539471359;
        Fri, 29 Oct 2021 13:31:11 -0700 (PDT)
Received: from ubuntu-mate-laptop.eecs.ucf.edu ([132.170.15.255])
        by smtp.gmail.com with ESMTPSA id s14sm5460510qtc.32.2021.10.29.13.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 13:31:11 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     linux@armlinux.org.uk, arnd@arndb.de, linus.walleij@linaro.org,
        geert+renesas@glider.be, mark.rutland@arm.com,
        akpm@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fazilyildiran@gmail.com
Subject: [PATCH] ARM: fix unmet dependency on BITREVERSE for HAVE_ARCH_BITREVERSE
Date:   Fri, 29 Oct 2021 16:31:10 -0400
Message-Id: <20211029203110.8343-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ARM is enabled, and BITREVERSE is disabled,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for HAVE_ARCH_BITREVERSE
  Depends on [n]: BITREVERSE [=n]
  Selected by [y]:
  - ARM [=y] && (CPU_32v7M [=n] || CPU_32v7 [=y]) && !CPU_32v6 [=n]

This is because ARM selects HAVE_ARCH_BITREVERSE
without selecting BITREVERSE, despite
HAVE_ARCH_BITREVERSE depending on BITREVERSE.

This unmet dependency bug was found by Kismet,
a static analysis tool for Kconfig. Please advise if this
is not the appropriate solution.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f0f9e8bec83a..bf029623603e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -67,6 +67,7 @@ config ARM
 	select GENERIC_SMP_IDLE_THREAD
 	select HARDIRQS_SW_RESEND
 	select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
+	select BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
-- 
2.30.2

