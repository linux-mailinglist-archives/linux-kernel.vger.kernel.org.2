Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C449532F8AB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 07:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhCFG4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 01:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhCFG4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 01:56:19 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146FCC06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 22:56:19 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id j12so3586627pfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 22:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lZisZDKteCh5G3B7t8OLLY7x2jhoRGCWNFjhpB3MDSw=;
        b=DJzBDR6VoEeuqNPBc6tEoCfhex6INs6PiQPu92TFS9NP9iw0xWS2IDe2+96HpMkcEV
         LdJ9z4cgVFchHV5zM+Mrul6bDgzaeZdc2K5i5BpfuvMvmz4onyRmQA681iIRQcJw6wJZ
         wF8hh4iV3PHUuJrlvwEm6HLxeRfjtwm/i+gh2lCovNt7ZQj+tGtdWybpQp5Dw2wvBRYS
         zkTlTxo7U7bczpcc+/5iCQw0pn+QIcyBNmd3cLxdNemzbGUIdCneL8jvoLBdAO3DzFH2
         jYbtyIoyo40RSw1nFUohsby9XxYu5d+SjdDaC4csHpRL5rLnFnRK16SSbD/w68LtjR18
         X33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lZisZDKteCh5G3B7t8OLLY7x2jhoRGCWNFjhpB3MDSw=;
        b=DBfrI00/7t0TBFN9pzlIDmoYBM051eCcIq53ZKmrIKOmUJ+bG4DUXeylDVf0DYiNPc
         akaNgsJdQgxHNWsS6t8qIuR7empTI4Ln3VWpU7Fg5PeCKB/uro85uj3h7oxWb6DlXapN
         fKGNMlLAboglgp4bOYcsQQVTVTJlp4acymGZTvfoZl36WfnjZgJx+6l2Fh7IOfDe5d9X
         sgyAiT3yKJ4aJgdniKyuS9OW+FgxEWBLh03j/NRzv5F9GtZRLyq7axwzkd7vVXzbcob0
         8bmqVsuBlrgqstB+4ExdviDznS+awpYxjcqR9+i9YsRWxQ3KKc8617eC7setnQ9Fr0M1
         vQZA==
X-Gm-Message-State: AOAM531b2gNZX1npV2Uo9QLaSnm/dBVZWO7Kb/S3iNtQXTXrakD2frwC
        FUvQOKZBDWKJYr4uyewX2sQ=
X-Google-Smtp-Source: ABdhPJxK8kTymHDDcmeR4RVP1FVqVSLDkweOvTtGBtTYG2ta/sVg5XRB8ByK9t/gg4SStADf5nGy7Q==
X-Received: by 2002:a63:2948:: with SMTP id p69mr11848801pgp.15.1615013778530;
        Fri, 05 Mar 2021 22:56:18 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id y15sm5086153pgi.31.2021.03.05.22.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 22:56:18 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, ggherdovich@suse.cz,
        rafael.j.wysocki@intel.com, rppt@kernel.org,
        nathan.fontenot@amd.com, ashok.raj@intel.com, brgerst@gmail.com,
        linux-kernel@vger.kernel.org,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>
Subject: [PATCH] x86/smpboot: remove duplicate include in smpboot.c
Date:   Fri,  5 Mar 2021 22:56:10 -0800
Message-Id: <20210306065610.211901-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'cpu_device_id.h' and 'intel_family.h' included in 'smpboot.c'
is duplicated. It is also included in the 80th line.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 arch/x86/kernel/smpboot.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 02813a7f3a7c..ec4bf691fe28 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1865,9 +1865,6 @@ static bool slv_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 	return true;
 }
 
-#include <asm/cpu_device_id.h>
-#include <asm/intel-family.h>
-
 #define X86_MATCH(model)					\
 	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,		\
 		INTEL_FAM6_##model, X86_FEATURE_APERFMPERF, NULL)
-- 
2.25.1

