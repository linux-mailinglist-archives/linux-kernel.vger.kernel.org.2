Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5AF30B3C1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 01:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhBAX64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 18:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhBAX6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 18:58:55 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF0DC0613ED
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 15:58:15 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id q7so5488996iob.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 15:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a0KwK7+kKnZ6aCt3YGJBN/dqDT4bQUU0HrueyV16eos=;
        b=V3hH147pvef9wbe/VyEpCGT5lRj5ADwn+YRlx8F4+VMM/rmHRaQ5MGoJDFRjDSHi8g
         l7OmFGWDASKvbd76JB1ydNPMP3XyBpHRqmnP79+vys7khHydifPpN82sbFUnsc6MnLUO
         E+BUgRDVEHOj/5hhZnMDnkGnnyYzRwa6I91Rdbarow4aNM3O9f2AgWUG3/E/V30vjU/O
         bvO1Nfe4dHrrqr23ElV2P3c/jZOgY6miLLhpW4dBBcjnSo+D1mUddFzlF+FYLrm0DU1S
         QNh7fEiVniyhwVx3LHbCHSqRh6ZhrD6CVk3xiN8+MUrCKcuehzfWZAL5ORfht/ZGIM30
         oZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a0KwK7+kKnZ6aCt3YGJBN/dqDT4bQUU0HrueyV16eos=;
        b=fqRaUtfklKWUspzIk4500tmV3JaseeaGr9yQ26Ks82FDaFkjNuuFaMQ9SoHffXwJDs
         irt9BLiWZ4zDvZjcDZHFs+yGL2LKh6r4IVU2ofM3/kYaSYROw+Ygpy3hXVEsCGNuPrW3
         ryGzRgrP3G+la8KQl0YYYs07xgA3m5G/WR++09p38CKkRb7JXdLpeidYu1QgPkVV7C7R
         bJ8nLW8Cbkdh77vqJtwKIXRjwYHjFZtTqSKVpiVq4+wlaHgRAkSX+2wZXzabPBbwFOJv
         LNveeiFUVRHAWw/Gw1SWzZlFlozan8Opzf/sbbPJIOeg3GEnYwmAuuMZFVpdsDs/Z73n
         cClQ==
X-Gm-Message-State: AOAM533wh2mCqkW8pdre5kRkkQZecZyIbZyWqDmAsx7uVC6yzNiS3oto
        E+hJvyKPdaN0TGdvY3mqeN/KbZlG/bRcBiGL
X-Google-Smtp-Source: ABdhPJyPcHaS6bn6DxuDIY9UP8O6YzY+RVIzHya2Wm+aKcohYZXNpavteml9YaFPZV21FT/qugKgkw==
X-Received: by 2002:a5d:9588:: with SMTP id a8mr14240939ioo.34.1612223894545;
        Mon, 01 Feb 2021 15:58:14 -0800 (PST)
Received: from localhost.localdomain (tunnel525895-pt.tunnel.tserv15.lax1.ipv6.he.net. [2001:470:c:1200::2])
        by smtp.googlemail.com with ESMTPSA id g126sm5284813iof.39.2021.02.01.15.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 15:58:13 -0800 (PST)
From:   Tianling Shen <cnsztl@gmail.com>
Cc:     Sumit Gupta <sumitg@nvidia.com>, Tianling Shen <cnsztl@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESENT PATCH] arm64: cpuinfo: Add "model name" in /proc/cpuinfo for 64bit tasks also
Date:   Tue,  2 Feb 2021 07:58:09 +0800
Message-Id: <20210201235809.401-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sumit Gupta <sumitg@nvidia.com>

Removed restriction of displaying model name for 32 bit tasks only.
This can be used for 64 bit tasks as well, and it's useful for some
tools that already parse this, such as coreutils `uname -p`, Ubuntu
model name display etc.

It should be like this:
```
$ cat '/proc/cpuinfo' | grep 'model name' | head -n 1
model name : ARMv8 Processor rev X (v8l)
```

Link: https://lore.kernel.org/lkml/1472461345-28219-1-git-send-email-sumitg@nvidia.com/

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm64/kernel/cpuinfo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 77605aec25fe..d69b4e486098 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -148,8 +148,7 @@ static int c_show(struct seq_file *m, void *v)
 		 * "processor".  Give glibc what it expects.
 		 */
 		seq_printf(m, "processor\t: %d\n", i);
-		if (compat)
-			seq_printf(m, "model name\t: ARMv8 Processor rev %d (%s)\n",
+		seq_printf(m, "model name\t: ARMv8 Processor rev %d (%s)\n",
 				   MIDR_REVISION(midr), COMPAT_ELF_PLATFORM);
 
 		seq_printf(m, "BogoMIPS\t: %lu.%02lu\n",
-- 
2.17.1

