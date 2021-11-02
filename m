Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E73442770
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhKBHIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhKBHIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:08:19 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABA3C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 00:05:45 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n8so3907019plf.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 00:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ww+iuNc4Aes8+PjyRrh9Ey0Ld9Q1orZV59Lg8GR2Wkw=;
        b=lGdaakqhlkfkTpJ4YMIa7O9DnRGA1nDALSAorvccSka8dp6X5Uf3mvcsVeCju5gF4j
         ikgDy0GlUmIseRt5cl1NgvNn3jqRScerEd94Ocdc8krztmBxO3ncqV4Q8JP4P0BLKWk2
         1fjGfA2hbDFN8Rfy8mdSElKDTLC0QNfpx4gfrQ+NXVFCCxWfgliUoEmthV+4Ge1JTKiK
         Ck7VJoi6JGF5xvsWaLKc5yRII/ORitmCycRGqCtqiie58+fHMHdHjdalb0BF2CIfaHbi
         aw8EYm+fzi9V0C/JgTn/sZL5NOdhd5CF10EMA0ANw79a0xAa1gE+S/3ivnEerP4v10XZ
         g7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ww+iuNc4Aes8+PjyRrh9Ey0Ld9Q1orZV59Lg8GR2Wkw=;
        b=4U+jUev1o17G8TT7y46oC6UPkj6w9vva8Z8rLSTOaeTBrBWnnp72ApU2I0Adb9AzQm
         lW7SQ4TNHD+qdnZlcJCUrL7pYFFjFD3nFT/LyOC2d8K+IqpU150oRPNO8x6Qlw032NZZ
         4oq9KQnjxrKXT18lSgd26VDH99ZQdptKe7NIpP9adEZkSJTbKtvuHneAy1zeqi7d0RnF
         VcxUpE2k7lE+zLUayYbEL6Q865wjo0oJviZGZHGU3GDeQYt1ymgdrDClwmvGlHJVzUon
         1v3mpc5nfPoVozvkVAwpRk0pI4zNiPnSEEa+eDyHTZ+chRUFbt3CgO/S1Wj0QubUXWxk
         zi5w==
X-Gm-Message-State: AOAM533WhvpuhlZQzAz6zTntaPXkyuqINwr7zQ8QRC+uqw0VEik4kzXp
        MXFsW9aVuN8/DRDeJ3UW08U=
X-Google-Smtp-Source: ABdhPJwitXBOwNjtN5JLj4q0mZXwZ/cm05yR8Wdhvpa5mvThS1kdxIoXLgpujYBr41yVatSM9QQDDg==
X-Received: by 2002:a17:90b:92:: with SMTP id bb18mr4417606pjb.133.1635836744559;
        Tue, 02 Nov 2021 00:05:44 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a15sm1064596pfv.90.2021.11.02.00.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 00:05:44 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.mingyu@zte.com.cn
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, chang.seok.bae@intel.com,
        len.brown@intel.com, oleg@redhat.com, linux-kernel@vger.kernel.org,
        Zhang Mingyu <zhang.mingyu@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] signal: remove duplicate include in signal.c
Date:   Tue,  2 Nov 2021 07:05:39 +0000
Message-Id: <20211102070539.4979-1-zhang.mingyu@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Mingyu <zhang.mingyu@zte.com.cn>

'asm/fpu/xstate.h' included in 'arch/x86/kernel/signal.c'
is duplicated.It is also included on the 45 line.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Zhang Mingyu <zhang.mingyu@zte.com.cn>
---
 arch/x86/kernel/signal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index ec71e06ae364..fad9c4adcda6 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -42,7 +42,6 @@
 #include <linux/compat.h>
 #include <asm/proto.h>
 #include <asm/ia32_unistd.h>
-#include <asm/fpu/xstate.h>
 #endif /* CONFIG_X86_64 */
 
 #include <asm/syscall.h>
-- 
2.25.1

