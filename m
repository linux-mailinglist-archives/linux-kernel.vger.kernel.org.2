Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4503238E018
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 06:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhEXEPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 00:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhEXEPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 00:15:45 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F150DC061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 21:14:16 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v12so13959044plo.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 21:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8x11PVwoAMtSt9XSLxkYTJlPWfccQwkVNeZrZFz64Gk=;
        b=Urj37+0py0TRojDy/1ohfYfi7RCbT5Q9mB1/KSM+vvA1lBF/HwUTUa8hTZKjP7i2+T
         dC1Cz5l8bxKytgHn8S0mJ2gm7gSxF8jq86z0Q80Gszwzo0jixvH59PBW2QkYp2cUrWqb
         FUAUfQ5c2y/Ju/LvjdRCGNsjoy95PVfOHBm16T3SDcpN9H91qTzYQOQgtvwxHc1kyuXj
         vGkcVuzXo1qEZZam61Bg3v7SlqpNZ5Jn1hCoKlJ0doKcTogVW6vCsSiAMSgAy0i/6q1M
         2NdsakBAbYNe15/mWFOSj5C1/T5l/IVV5bQC8+BH9RPAHyPbwla4B6prMLdIOKkY51ZH
         QbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8x11PVwoAMtSt9XSLxkYTJlPWfccQwkVNeZrZFz64Gk=;
        b=RgZF0rGB+skzPGgpWAQelrAfqYhIOs1j+giAYrcJhtCcnbYBG0rGaXgdHft18bc3y6
         MpMYoXdsV5MzBLntUD9r9zTj7YpRsWMprM3iDaAgkk8YRmGMWprM1NCKKq5i52b0I3tP
         PL+5NIM6AEZTuB6sqzSEb/M0amdGy0NWTZGpYelbp3Fnj/o13tSiTPyQbNxv85YwhgGV
         QuwoKjrPPMYGjpuKYRVlOgAH8qjNBuTBGuGLqLQ6dPTV3fnXt51iA28wQTqAPrKohL42
         AdTAViJOHC+YOEBhtZYqg9b8l4sE9ucQK7IkICMPXbN0ReyVLiPwv+CuM7v8PFNMLOLh
         Kt+A==
X-Gm-Message-State: AOAM530SD3gEQRiSzRFvpW9+eh1i0ALdhAq2x0Acf/KvxfWwHkxT91OL
        uEt4dIUjMJ00dSaIcbLwcCo=
X-Google-Smtp-Source: ABdhPJzKByikscpfD6GuCx/lWEk0NV3mLatOLKKWXQs/zC61RdDFs46FzNEFyFA+ibw1YO2fNE6ISw==
X-Received: by 2002:a17:90b:30cb:: with SMTP id hi11mr22671921pjb.204.1621829656532;
        Sun, 23 May 2021 21:14:16 -0700 (PDT)
Received: from localhost ([52.175.62.71])
        by smtp.gmail.com with ESMTPSA id c195sm10190232pfb.144.2021.05.23.21.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 21:14:16 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] uprobes: Update uprobe_write_opcode() kernel-doc comment
Date:   Mon, 24 May 2021 04:14:11 +0000
Message-Id: <20210524041411.157027-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 6d43743e9079 ("Uprobe: Additional argument arch_uprobe to
uprobe_write_opcode()") added the parameter @auprobe.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 kernel/events/uprobes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6addc9780319..a481ef696143 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -453,6 +453,7 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
  * that have fixed length instructions.
  *
  * uprobe_write_opcode - write the opcode at a given virtual address.
+ * @auprobe: arch specific probepoint information.
  * @mm: the probed process address space.
  * @vaddr: the virtual address to store the opcode.
  * @opcode: opcode to be written at @vaddr.
-- 
2.25.1

