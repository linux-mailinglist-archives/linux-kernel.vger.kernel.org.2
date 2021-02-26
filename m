Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857D83268BC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 21:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhBZU2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 15:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhBZUTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 15:19:04 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0452C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 12:18:21 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id jx13so3165411pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 12:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=9E+CJGi9vbnEQTKM+ByNuYS5mQQ+2hX085/dBrdX5hI=;
        b=eF0N998zDZscF98K/U6KhV/DH/lPR6SR4RV0yhiLLSA1L1B+bsfUSASoBRA24ZBPxi
         9YHsHI7STyER7wx8VXHr+pXZiDyeyEFexER1GjWJpW9+RkC9gc0NEKN9c/TxELvKKb6q
         N0eUIE3mxU66D/6Z+Qg+Usy0C3OfxqxCusn3UEvtAEEsHMPC9CENxdyNzpLUs/DE1tGL
         TxwO3xig1gv3gSpLs7K6ZF8XThlVlazBd9QNYEEGElv8KDhjDhNKm22QONS1pJx2MXG3
         Ri+tY+LYl1sH8hLOR2txXP0Wvn+8UpgIfTUZIFteH5z1pKqgxRJmdEk3VSS0RJ3Hx1Fy
         8dFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=9E+CJGi9vbnEQTKM+ByNuYS5mQQ+2hX085/dBrdX5hI=;
        b=bSskFpZkMg93RDvv9jVSN87vR0pxILP1aZ6lv6g4bmOGC2sDLjO5H72+sUAaWvKYpx
         NaHEdfmeDScVCrnhkY2DuXdSROG/JxiMvHkiwjCr4yQabhMTiRg5rh7NxNJ0jAAWxwB6
         0d6w6jJn/1r/hBTmT1LX3DoBZw8QGhwEnvceF5XGlBr+qEE8bINeNXuKtl8VHTgD2Zpa
         6NTItWsuGWqLDfLFKwobaBixSxnplIsirdge/kumStW6e8e2IosYhYocWg0O/3psGUXe
         SuAsYnKybfckkNPiH1lLmsS02wTCXvW/WarqRpa07UFvHiGgHrdgrx0IbizoqdPNeWzU
         caQA==
X-Gm-Message-State: AOAM531D6vDB30Do1FtG+8IzLQjunq++k2hROMHenkZfRVUDUDRwUuNH
        aZpAubgIauK5pbYuMko4I4F3Bg==
X-Google-Smtp-Source: ABdhPJyMDe4rbtveTYgncBcjGF3qz45nqxfrUYyHXvTYLo0tBDml/VM1sEKxYwUxRH3SrFB4qZpRcw==
X-Received: by 2002:a17:90b:1213:: with SMTP id gl19mr5026942pjb.107.1614370701536;
        Fri, 26 Feb 2021 12:18:21 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e24sm9202856pjr.13.2021.02.26.12.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 12:18:21 -0800 (PST)
Subject: [PATCH 2/2] topology: Guard node_reclaim_distance with CONFIFG_NUMA
Date:   Fri, 26 Feb 2021 12:17:21 -0800
Message-Id: <20210226201721.510177-2-palmer@dabbelt.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210226201721.510177-1-palmer@dabbelt.com>
References: <20210226201721.510177-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     peterz@infradead.org, srikar@linux.vnet.ibm.com,
        valentin.schneider@arm.com, vbabka@suse.cz, mpe@ellerman.id.au,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     akpm@linux-foundation.org, atishp@atishpatra.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

This is only defined (and useful) for CONFIG_NUMA, but isn't
conditionally declared.  This makes users a bit more of a headache to
track down.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 include/linux/topology.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/topology.h b/include/linux/topology.h
index 7634cd737061..15f02281bdf0 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -73,7 +73,9 @@ int arch_update_cpu_topology(void);
  * *improves* if allowed to reclaim memory and load balance tasks
  * between NUMA nodes 2-hops apart.
  */
+#ifdef CONFIG_NUMA
 extern int __read_mostly node_reclaim_distance;
+#endif
 
 #ifndef PENALTY_FOR_NODE_WITH_CPUS
 #define PENALTY_FOR_NODE_WITH_CPUS	(1)
-- 
2.30.1.766.gb4fecdf3b7-goog

