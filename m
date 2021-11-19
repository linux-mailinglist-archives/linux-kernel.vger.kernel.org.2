Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C7F457357
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbhKSQsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 11:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbhKSQsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:48:00 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492A4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:44:58 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id b4so9096532pgh.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=WImAJJVVV8ZgGF59Y6Sx47rmH1oD9rXqn7A8Z+idAIs=;
        b=wlYyLzgts1gwjmOaIa5kyKYhHq15ZIXkOGQsAjLIKlvBtlnvrAwHzTuQyksqdfQwNL
         aRlJ67mEDDghlu72xwYXPl/dhhlmKjB9kmaJydHAPyTT2celbRdIEAVMfekKPlwpsYr4
         pzk90gBJxvkEDcJGYKyPFe2llZ4U964sWAAH48R6hq+vw3I7YzRbCfNETFBw/yLfcT2+
         +MUGajcOcuZEwoVTLtmIskt9GboqyJJyJk4Ig+AJiJQIfmB/IZqLzy6+8jzDmWOqpLQQ
         F5sjy05+XE1+xXFiN/ktINtBXmDo5JyWADkGH9VHFPUdRFWkHjKx+oxFgsfJGOv6Lbs6
         Wm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=WImAJJVVV8ZgGF59Y6Sx47rmH1oD9rXqn7A8Z+idAIs=;
        b=2ReUh+S9YP23LP/VsuehcFJLUjG7XMGnVXC6TeDf83xFQPk4EQQW8MvKxIpmg07zvu
         nLZXKQ1MALhnE4DokxgBRTDq7hdxV8rwe+DBQu7KGXFZkAhhPJn/rJYyfJJMnzbiWZ7J
         rvN2d5J8jI9vOysYanIg3BV/r6UpUN92GypCmfU1pqLwPO1sTbhG8EZ45kat7YpTYYCf
         axpMAAH5DdeByAg85TwiDS7+7jGaenKnkLyt+NrtqyB3d4OvR1IUZJROwH9yG6jTkExT
         /tm0CnBGjfOKdpxo8LJcLhV8j839uqPGcF9I8aj35tid9bI5RbsDb4kmVvHSXsP6lojW
         +c8g==
X-Gm-Message-State: AOAM530SGt/WWz86k+D6iG5rrQmPu2swe5Iodw726q9P9EekusOoTF+h
        jzT7beloLmtM62NE0QMte2Ct/g==
X-Google-Smtp-Source: ABdhPJzt2WvKizh2kBYa7g3K+Fk3f7u7YeoZpgNqJX9bVrif3hlfLVR3zLqx59eLwQFyQFhFeWlYsA==
X-Received: by 2002:a05:6a00:99b:b0:49f:eab4:4e7e with SMTP id u27-20020a056a00099b00b0049feab44e7emr24191675pfg.63.1637340297859;
        Fri, 19 Nov 2021 08:44:57 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e10sm187273pfv.140.2021.11.19.08.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:44:57 -0800 (PST)
Subject: [PATCH 05/12] RISC-V: defconfigs: Sort CONFIG_SOC_POLARFIRE
Date:   Fri, 19 Nov 2021 08:44:06 -0800
Message-Id: <20211119164413.29052-6-palmer@rivosinc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211119164413.29052-1-palmer@rivosinc.com>
References: <20211119164413.29052-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        anup.patel@wdc.com, heinrich.schuchardt@canonical.com,
        atish.patra@wdc.com, bin.meng@windriver.com,
        sagar.kadam@sifive.com, damien.lemoal@wdc.com, axboe@kernel.dk,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

This should have no functional change, it just sorts
CONFIG_SOC_POLARFIRE the same way savedefconfig does.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 96c2a3615bcd..0f4fe5790fb5 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -15,9 +15,9 @@ CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_SYSFS_SYSCALL is not set
+CONFIG_SOC_MICROCHIP_POLARFIRE=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
-CONFIG_SOC_MICROCHIP_POLARFIRE=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
 CONFIG_VIRTUALIZATION=y
-- 
2.32.0

