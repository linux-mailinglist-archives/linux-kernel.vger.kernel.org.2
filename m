Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A563268C9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 21:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhBZUca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 15:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhBZU1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 15:27:10 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587A4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 12:26:30 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u11so5879427plg.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 12:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=guVHHoMFBPvp3OxDd+0aUouYbsfZ7/NT4oJJzvE5m3I=;
        b=tmsnCi2SAI9vkwFeBe40zYshNyCWCZE7X8sGuYNqxij1IEt1YnWoTUFFUkj/c/g32i
         8V4XS2Guu5UkPjW8hCSjPKVihbVlPM5WjHZI0QBO3VLpli+WVIf0ype0AOd2Ta1U5rud
         OndTiVmTBNUyTSNDmfRJPC3d8wcbesqtyKTda15dGJ+be6pwN0/pnixlyBoc2tKO6y1A
         zDTgfTJYPQdw9Cj6KbV4HidpmXkyygLejbILc9+TElN5Si8xUGFBn4affgQjxMrCOZe/
         o+Zz3YgTO5UtDG+/oKZKACWaYgee+zd3QmSr0lMuPNSnlXuMhaRSn1alAeLMP2RCqF/c
         xm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=guVHHoMFBPvp3OxDd+0aUouYbsfZ7/NT4oJJzvE5m3I=;
        b=WgmTY2NglQ7xYM0zFLA143pLfozkGEYJmYYLcGRH5BEuFQPwydEDOF7M2g6Fe/7EHT
         /d+wAelNDfnScnL+H7N7sHR5nwQ/UTqbxm3/p80TK1xl6k2uv00Bkc0z4PgEYt2p5x14
         MZ9Yfc891ScE/8EqXaaNnkt7oOp3Is+u8mEjog2sCXqR+yFeGqSMqtoTToTfjp5SYFeh
         IUEQ0rCrusSIIcX3O8yZAny7riwhTYXNj4jNw27fKeqYt5CYn+oe0FK959TZ4tCfp/tE
         tHwN7kTvC/hswOibMOKj4nM7KNpob4yVXqU5l77eUVvxdwTHCwCSiTVZVM0agKquemRc
         lhyw==
X-Gm-Message-State: AOAM533fngcsYkn+e/R8ZbF5pgqRt36kyaA8/TTfes248vbki0dlrdXB
        +UGbsQjShOJmyRAipEKd1NBqzw==
X-Google-Smtp-Source: ABdhPJx6qgv10L36CmoL36zIpvtjDdnUKZd9v2cpy5GzwjbwW1kOzDHzIgLTxXrHfFTL+LqSOnBx5w==
X-Received: by 2002:a17:902:e781:b029:e4:3bd3:3b00 with SMTP id cp1-20020a170902e781b02900e43bd33b00mr4850293plb.70.1614371189701;
        Fri, 26 Feb 2021 12:26:29 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a15sm95297pju.34.2021.02.26.12.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 12:26:29 -0800 (PST)
Subject: [PATCH] RISC-V: Make NUMA depend on SMP
Date:   Fri, 26 Feb 2021 12:25:51 -0800
Message-Id: <20210226202550.512012-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     akpm@linux-foundation.org, atishp@atishpatra.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

In theory these are orthogonal, but in practice all NUMA systems are
SMP.  NUMA && !SMP doesn't build, everyone else is coupling them, and I
don't really see any value in supporting that configuration.

Fixes: 4f0e8eef772e ("riscv: Add numa support for riscv64 platform")
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Suggested-by: Atish Patra <atishp@atishpatra.org>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
This is on fixes.
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a998babc1237..85d626b8ce5e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -314,6 +314,7 @@ endchoice
 # Common NUMA Features
 config NUMA
 	bool "NUMA Memory Allocation and Scheduler Support"
+	depends on SMP
 	select GENERIC_ARCH_NUMA
 	select OF_NUMA
 	select ARCH_SUPPORTS_NUMA_BALANCING
-- 
2.30.1.766.gb4fecdf3b7-goog

