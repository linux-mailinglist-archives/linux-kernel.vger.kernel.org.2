Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D991D4021AA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 02:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhIGAaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 20:30:22 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:48034
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229975AbhIGAaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 20:30:21 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2CBF640195
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 00:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630974555;
        bh=vwY0GyREwDxUyu6PmgoJJAbASD5dqYVwYvhZbAA80bQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=L6p/QLlYOOavPpe9akzgo06jGYjqUBMdBvzsP0/RMTu59+LG77cjJaPv5wHV2tAy9
         jgGOGgPL17LQsqAC4nfwTgtuGNt3Rj0DTrz0sqdjJvvq5acjzRFJkOsyiahMmWQwvC
         VR763VhLfFfhPOMFhJ68OyfICo7fa4zHRlFmpZfSsz55b2tk5C+3IKKnPHiutMoKki
         dWupeIpu4NwcRq7zWa7b8UzoaZc3qPyseUqX+XYV5hiPO/DIy2law22wz6dinOtLqw
         cT/tHerxKECQMOqCLLsLZpoLrRYPqo77IZAywlZ8/RgmQSHTaGw0adDXt/5qeamoyE
         PKB2gh5rLcixw==
Received: by mail-wm1-f72.google.com with SMTP id m22-20020a7bcb96000000b002f7b840d9dcso492335wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 17:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vwY0GyREwDxUyu6PmgoJJAbASD5dqYVwYvhZbAA80bQ=;
        b=gIEeKkxTcNKSCEaT0x3dTZ34jMq3yFk7vtqMr3ODWovoMAtQFlUT+YKotoka1IrCv8
         /8YqgD5rBgO74vfZoOSX4mFvO0ScPHnRx7EnE5jwd/dByDZuIusB0Ai7v/9CeEHKbpZO
         AbSfgrilSJoVewcsrBfmpy3WOQXZzFnuSDuE/jjJnjkc21UTMmBbO6u/dJBVSY5N3anP
         cFmPxfutRNWbtXE3lV5wOccStlpPnFRNfloz06vg62NR/RyzMuvcXkye2LRk/BTBg2fU
         OnvS2NDYP9dlkvmeV7uG3o2iTvmxS2vPZL5QkCApyY4jUy4R09M5qq6TcqSPy5GJ77Kp
         U+AQ==
X-Gm-Message-State: AOAM533B7FocdODtKvkUGAdj374Rg//yJEYvEpZuhOGvj9Et8tlP6ds5
        6q2tqwi/iaCC0/0WnBRKoUNtJnkC28j5pVFPMSo67e05aghA5kRC51AAZ5ExG43dVrML36ljXjD
        BAY1Kzh1fggBchLYvRGHmikfEWCgHt8ED4i9YCODHZQ==
X-Received: by 2002:a1c:7f83:: with SMTP id a125mr560905wmd.166.1630974554681;
        Mon, 06 Sep 2021 17:29:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxw5ZhSl97K++iKhqoc8ciIYj2y61O9Fo1Y5YxRxVUXw37B3lEDFeDmUZMsTDBbABmB+MmryA==
X-Received: by 2002:a1c:7f83:: with SMTP id a125mr560899wmd.166.1630974554402;
        Mon, 06 Sep 2021 17:29:14 -0700 (PDT)
Received: from localhost ([2a01:4b00:85fd:d700:3349:7876:92a0:e08a])
        by smtp.gmail.com with ESMTPSA id l16sm6878608wrh.44.2021.09.06.17.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 17:29:13 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     linux-riscv@lists.infradead.org
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: set default pm_power_off to NULL
Date:   Tue,  7 Sep 2021 01:28:47 +0100
Message-Id: <20210907002847.111633-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set pm_power_off to NULL like on all other architectures, check if it
is set in machine_halt() and machine_power_off() and fallback to
default_power_off if no other power driver got registered.

This brings riscv architecture inline with all other architectures,
and allows to reuse exiting power drivers unmodified.

Kernels without legacy SBI v0.1 extensions (CONFIG_RISCV_SBI_V01 is
not set), do not set pm_power_off to sbi_shutdown(). There is no
support for SBI v0.3 system reset extension either. This prevents
using gpio_poweroff on SiFive HiFive Unmatched.

Tested on SiFive HiFive unmatched, with a dtb specifying gpio-poweroff
node and kernel complied without CONFIG_RISCV_SBI_V01.

BugLink: https://bugs.launchpad.net/bugs/1942806
Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 arch/riscv/kernel/reset.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/reset.c b/arch/riscv/kernel/reset.c
index ee5878d968..9c842c4168 100644
--- a/arch/riscv/kernel/reset.c
+++ b/arch/riscv/kernel/reset.c
@@ -12,7 +12,7 @@ static void default_power_off(void)
 		wait_for_interrupt();
 }
 
-void (*pm_power_off)(void) = default_power_off;
+void (*pm_power_off)(void) = NULL;
 EXPORT_SYMBOL(pm_power_off);
 
 void machine_restart(char *cmd)
@@ -23,10 +23,16 @@ void machine_restart(char *cmd)
 
 void machine_halt(void)
 {
-	pm_power_off();
+	if (pm_power_off != NULL)
+		pm_power_off();
+	else
+		default_power_off();
 }
 
 void machine_power_off(void)
 {
-	pm_power_off();
+	if (pm_power_off != NULL)
+		pm_power_off();
+	else
+		default_power_off();
 }
-- 
2.30.2

