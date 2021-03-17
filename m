Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D3833E6AF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 03:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhCQCR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 22:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhCQCRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 22:17:50 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3DCC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 19:17:50 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id a11so387985qto.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 19:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9lMncJGKZCfxnFvPgs+zTweoHwj9SGiXOdzwGN+/zuk=;
        b=pQKfhGKw+4yFsh3+hu+FgiQuoqWhLgRG9zTo+pVzNJ1zhByBAAD751i3EDDSOZi3uP
         kEnYkGdjRNy2v5wKQpR3LOjL1lzdKzQxpW3tkcGiDPH8CKQzqEP/XxTLbdy0ikR5Ef49
         9jU+kThv+NaHp7bzz1NnzcT4dZ4ljGvghlMaeiEink+UcBRiQBkQLUSbS2Zg/gf9S8iv
         ZhBKBm1hhASWfbpEIWrcJ54IImjiJOemCOCQiZ9/FxxGmKSd/MRVEj7cHvk3myWMpfK4
         nvbPZdpZeUjd4aUyd3T3uiD/FROxDGDp4g0hqzUXYSJRtXidzQrl13QEGegjTcfnGhMR
         Yqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9lMncJGKZCfxnFvPgs+zTweoHwj9SGiXOdzwGN+/zuk=;
        b=cxRCS8gRCEycjs+4raP94ZGIttPm0HqkSSieQkztsQDkTQX3kkd6JUlCWEqNj33+tk
         WdrKNcaj3i3oRuYj5psXuCjM29r4D3Awyuwa888wB7HwhgY31K9QfikgrRaq33mwCR9r
         Hnvr1+uK7ogYXgoALNwobddqAbbUpNLXyx3d3ywB60hNK17E/Kl/HkwQmW25RSPpEapv
         IUxtP1NE/g+ANpjOlwIlluzLoT/uy7nmuP5iv5w/5dXOglaYI+Ct6dtCHVzlECZLBhib
         K4E74GMkUXeFL2E5GaY+MWBZAV4GbkxqXomlQRNBpeMkoATZcYCbB1uwvInjjUeBannb
         QdUA==
X-Gm-Message-State: AOAM531lu8yu2Ov3jvE9sNgF93CuaZ3tdHRT/GMXdlCzflD1stb6OqXC
        lUtSSiHjYODahKN5T5PmjaC1yv9DrygKUsF8
X-Google-Smtp-Source: ABdhPJym66IIJzJE8Ms9AskB+Mu0+cnzeT5V0I477tmy3FgjkxC9y+ks/zkD1rPksBFhTryOrevzTA==
X-Received: by 2002:ac8:4718:: with SMTP id f24mr1858412qtp.270.1615947469414;
        Tue, 16 Mar 2021 19:17:49 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h16sm14406221qto.45.2021.03.16.19.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 19:17:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        kai.heng.feng@canonical.com
Subject: [PATCH][RESEND] Revert "PM: ACPI: reboot: Use S5 for reboot"
Date:   Tue, 16 Mar 2021 22:17:48 -0400
Message-Id: <b8db79e6857c41dab4ef08bdf826ea7c47e3bafc.1615947283.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d60cd06331a3566d3305b3c7b566e79edf4e2095.

This patch causes a panic when rebooting my Dell Poweredge r440.  I do
not have the full panic log as it's lost at that stage of the reboot and
I do not have a serial console.  Reverting this patch makes my system
able to reboot again.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
- apologies, I mistyped the lkml list email.

 kernel/reboot.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index eb1b15850761..a6ad5eb2fa73 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -244,8 +244,6 @@ void migrate_to_reboot_cpu(void)
 void kernel_restart(char *cmd)
 {
 	kernel_restart_prepare(cmd);
-	if (pm_power_off_prepare)
-		pm_power_off_prepare();
 	migrate_to_reboot_cpu();
 	syscore_shutdown();
 	if (!cmd)
-- 
2.26.2

