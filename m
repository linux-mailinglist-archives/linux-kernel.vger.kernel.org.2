Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DED534348E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhCUUO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhCUUN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:13:58 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E47C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 13:13:58 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id y2so8474199qtw.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 13:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/N1y2SFzBPD+h43NrGUpttwE2nIeHm6Yt2ZbRMwpYK0=;
        b=smia896r6523e2vIcke4nIr7Afj06Y8vbrMXrOte0roAY42uo2XJaHl1A5Eq5fn9hH
         ey1DJyjjGhx5NvaAomiV4JKSwt6iqqd8xjYSmQBN1pECYKpQGWzfvxvt+tbuQAp8oQJD
         bZEP7kzk5ASjF3WE4hp7HrrJqHNjLOERmsVRYmsOLUFFeNyGxhX5RuIaeoe4mnl0a7fN
         mzV+wqohDWyhz9vnhSr8uKOYV4PXoF4hyPozBfGw/oAQYH+SyFQoIoWDftWU3gvBVgVv
         Y0lUdaFEtHkkI/CCR8jpACB40bxg7flEDRyjg04oIcLT/Lld9gtlRT1qWX8W2kgdV4Qj
         G80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/N1y2SFzBPD+h43NrGUpttwE2nIeHm6Yt2ZbRMwpYK0=;
        b=bdVrHfIvexo2t99pJwr/YqdsqIARv/mdqLMj+r4mI94+Dc2B3ABimefR9pF6D/2DWQ
         u8aDpE9P+8vBEssE1TZWNmTUbzGHFAFHB9fGWJ4SIN2r0frJRuTo3soIRkdcr+wk67AZ
         y+1U9sMQMVrcFT1EAIeVrTPUCOmEpK0l/dlSAAp80obg2mQinHDKFAKzBeJUAh2qy04j
         BgJNZLp/yaIlzat6m84mzEf8wpQ3R+x3ZL3InsMEnxU/5F73VG9aP2zZvBRsC16p1aH5
         kzenkYb8myjS8gKq2qgpeK7fS7u/B4AnmeMNVdzkaDxqYtkHqowXOdKH7l5AJ2UN1RT8
         1t5g==
X-Gm-Message-State: AOAM5317/cOmbUDF5fDptUN0rcMOZb7BzKzWh7YPRTK7m4vxEOreTZMA
        ugSTuqyjg/T7nirdb+aCP6I=
X-Google-Smtp-Source: ABdhPJyFYk2fCUm5jx/Ryv2Gayx0BdIySe5qKK/+X6HeaQfSG5iEpc6U0FRrcPa/yz/3IeYEBaMy9Q==
X-Received: by 2002:ac8:7fc1:: with SMTP id b1mr7115973qtk.363.1616357637504;
        Sun, 21 Mar 2021 13:13:57 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.163])
        by smtp.gmail.com with ESMTPSA id o7sm9663740qkb.104.2021.03.21.13.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 13:13:56 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] x86/entry: Fix a typo
Date:   Mon, 22 Mar 2021 01:43:45 +0530
Message-Id: <20210321201345.994577-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/swishes/switch/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/x86/entry/entry_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 4554a27a2747..c1fe264900e9 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1107,7 +1107,7 @@ SYM_FUNC_END(entry_INT80_32)
  * Switch back for ESPFIX stack to the normal zerobased stack
  *
  * We can't call C functions using the ESPFIX stack. This code reads
- * the high word of the segment base from the GDT and swishes to the
+ * the high word of the segment base from the GDT and switch to the
  * normal stack and adjusts ESP with the matching offset.
  *
  * We might be on user CR3 here, so percpu data is not mapped and we can't
--
2.31.0

