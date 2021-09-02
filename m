Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491673FE708
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 03:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbhIBBMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 21:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhIBBMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 21:12:31 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F262C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 18:11:33 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id c17so253480pgc.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 18:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m3voo91uzOxXIcUs3YqHapqLBsaBb1w98Fw4+HjYy7k=;
        b=FZlcsVMoLCFzTcJQJaIGzmQF7rFEGFND+MjdAitHH87hvTp5ZO+fdT8bi22uBIFndT
         FU6buFUwCcNkfZFx8MKGujovwXBHDzeT2IQ4d6ANZ2ip38BDM2THY2j3RUvnPX6lbBe8
         ITcWc6U4/195g27SaN4ehU6N/2xAhM7MEt4Ho7xcVgb0kNwJW8PmnYi6eN0nNHyYIa4E
         UQbOG0tyHFiny8lOJtE3QuzDvHGAY5Sye6vZWxq9+lCoYrIFFIj36LVsRKTSCnJgBHqJ
         GDiReH1fleKQtdsFAZ0QLYEdlDCbSDAjmfhKvSJUQ/hYFmihhE0WKy0gPvym83DdgUq7
         5m0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m3voo91uzOxXIcUs3YqHapqLBsaBb1w98Fw4+HjYy7k=;
        b=Pr3KtxL70Xif2+duIzMA+H2lumu7Kbx8v33OyR2OvobGBbjYqRFH1EUWLdmFyzMewn
         v519/Vxu+TyxwDFDoHLOv57rJ89um6DEQNr30YFMqwdDv3mUb2hl0aZYIsnK3k3s5p6W
         9VKKbB+g/UoxJqop7m+erfLsdraTehuANlSwgtQleo6ZlIvBJmKq9Cn5RpqUUUpDXk9g
         FZPgW0fOCJJhSRapHBzE1kbwZ2pPeplOLgiFCKGpXQ7HOANYxjpxgaCikoQ/PeNSqkd1
         GSOCImFUEBLfkFRSHM1+YK1lBNZJpHmHuyJgWJvjTJp+RmoQdMaMZo5M2hXQ4SSYc0Hm
         /GYA==
X-Gm-Message-State: AOAM530Ew3J84ovEgNJL1JiCpUUdpYJHHCCRVA4dQ0v4xKjGLt1BBxWZ
        xl5R/OMnQGStLFdEVGdsEyqwUTjvSlI=
X-Google-Smtp-Source: ABdhPJxiNuk1mugjNkOgnG2h+gHEa7x+6WNTEhKPHy8acyDVnPAK9cqX09SNc8bVBqOOAPkAaPzynA==
X-Received: by 2002:a05:6a00:22ca:b0:3f1:d51d:d14d with SMTP id f10-20020a056a0022ca00b003f1d51dd14dmr784121pfj.10.1630545093002;
        Wed, 01 Sep 2021 18:11:33 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e3sm169221pfi.189.2021.09.01.18.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 18:11:32 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     catalin.marinas@arm.com
Cc:     will@kernel.org, mark.rutland@arm.com, pcc@google.com,
        maz@kernel.org, peterz@infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] arm64/kernel: remove duplicate include in process.c
Date:   Wed,  1 Sep 2021 18:11:26 -0700
Message-Id: <20210902011126.29828-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

Remove all but the first include of linux/sched.h from process.c

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 arch/arm64/kernel/process.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 19100fe8f7e4..1a1213cca173 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -18,7 +18,6 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/nospec.h>
-#include <linux/sched.h>
 #include <linux/stddef.h>
 #include <linux/sysctl.h>
 #include <linux/unistd.h>
-- 
2.25.1

