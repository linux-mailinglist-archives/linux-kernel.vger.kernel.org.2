Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D516343058
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 00:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhCTXer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 19:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTXeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 19:34:08 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70110C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 16:34:08 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id y2so7294847qtw.13
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 16:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iAVHXH6jL1fkBPlad1jd23Lyy4LoDMkIooUY4r5Rvg4=;
        b=jYmBX3oTnmTKZZg6ZWTQW0xviAnFHaNxc3BLVoXRZLkd+z0CMUJvrl8n8tek8C1+ZS
         dF7BGU0MBwPTYCRil2zmL1iLD9Db2zYvnemEgDoGuMGMCKdlqaaeeX6YmW/Nif+Gyerb
         S43X718JhNBm08AGsimHZIyyMmT8y1vp0+jEJ6gh8wl1YIq8wyEAVkYt96scqMgtUzmT
         3k3dMsnkOFm24N4zr2YyedynrBDjrsZhCm9va3uLFpoYCEkwyUohWnK8c9HqfHfY35r4
         CnkOYDEbwYjzXrnLBYwabTfkkUmLO7a/CLwAz309f2Y9QQ+rddofoV98s/YMt0Y25c50
         bAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=iAVHXH6jL1fkBPlad1jd23Lyy4LoDMkIooUY4r5Rvg4=;
        b=Zzkg88Pw0xmNxUntHGaxjCF/+qQoyOPBoaAkmNnM7xfkiTm2yFNmGMlGt8CqBmQ6Sy
         ltrdWuh/ftBUK0FGOq16+etzzaThrULwhdun3kDV8i7CXaplnM8QfvJm8BnP7OhsV5kD
         IRBWRCn1/oWaVX38XDEIEQoB03N7Pr9T9LqN+8VWB9+knQ0Hfe3PSYjrl14y+g1jXxl3
         Ecpx7OJsyrx24Gu+7qnoZjcYdzCZD3jPDb+C1QRK6FZ0c+RKS2q2Nqy72Zr77PvPMuDH
         7sF2j7nQoG/McaIYzhKfdZIWfhWuLKJJZa757PRaurVhnnzrLToSeGhuGMSSl0IwaYcr
         Bhwg==
X-Gm-Message-State: AOAM531dbbZUbjIIW1AEol9NG7Vg7gPfWWgQke5ROkK6NF1Ncpd5MWU3
        ALzp/n5O6cG1Uwgiie4bVLzeMJwDKcgACg==
X-Google-Smtp-Source: ABdhPJzZRc756SPdxz8sgm7G+qdG+WTurc5XfKrPIhm9cBruIv9X1iYlkyBtqeOGeyDncotkusTjtg==
X-Received: by 2002:ac8:4558:: with SMTP id z24mr4503665qtn.66.1616283247239;
        Sat, 20 Mar 2021 16:34:07 -0700 (PDT)
Received: from kde-neon-desktop.orld.fl.wtsky.net ([208.64.158.251])
        by smtp.gmail.com with ESMTPSA id 75sm7424727qkj.134.2021.03.20.16.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 16:34:06 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     chris@zankel.net
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org
Subject: [PATCH] arch: xtensa: fix kconfig dependency on FUTEX
Date:   Sat, 20 Mar 2021 19:33:53 -0400
Message-Id: <20210320233353.88493-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When HAVE_FUTEX_CMPXCHG is enabled, and FUTEX is disabled,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for HAVE_FUTEX_CMPXCHG
  Depends on [n]: FUTEX [=n]
  Selected by [y]:
  - XTENSA [=y] && !MMU [=n]

This is because XTENSA selects HAVE_FUTEX_CMPXCHG,
without selecting or depending on FUTEX, despite
HAVE_FUTEX_CMPXCHG depending on FUTEX.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 arch/xtensa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 9ad6b7b82707..a0d5f065d6b1 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -29,6 +29,7 @@ config XTENSA
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_EXIT_THREAD
 	select HAVE_FUNCTION_TRACER
+	select FUTEX if !MMU
 	select HAVE_FUTEX_CMPXCHG if !MMU
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IRQ_TIME_ACCOUNTING
-- 
2.25.1

