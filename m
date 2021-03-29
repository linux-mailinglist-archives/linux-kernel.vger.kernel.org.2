Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC71134C4B9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhC2HR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhC2HRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:17:45 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E044EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 00:17:44 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f17so3960459plr.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 00:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qdeB1DebFOmTbF+ti3VSGS7v5ONmS4cJGUgOsP/gdjA=;
        b=EnbPpclGbqr4Hc9lGUFEyziTKgJz2w7fvZXNbwcF/Pp4gt3Hcrks5FKB9iMpS4ZlxI
         howTT/y1k7mwB488x4Rv/IJ2hr5bnPQHpi24wFiq53aVzclEjW3l9ZXLG0DtkCMtHbbV
         4tL9WSfR9wgZ1EgH8Ja8DBZIqDrQLEM7NJQxs/0IPKPKTNrmZSQNwrBp9lpQtPAVG/nK
         4XYmJOmBgpoUnsIXvmS4X3EJA6BoHuosr3dDrkeVRUMvwS9TpCPpA21eX0juErFIDvpm
         U3E20xaYV2dQP8iPzF9j8R7UFIX2aRndPBhCEjG/H3Ul59CB+Bty9sO+mAR5xH6rp/JE
         BEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=qdeB1DebFOmTbF+ti3VSGS7v5ONmS4cJGUgOsP/gdjA=;
        b=WQGWk2+JEuHtqr34W0N8Srx1snPndX/FwLf6qQZE/3ZlFkIqAW2VwCgwhCin4x7BdK
         Lxn9UAM4S5cUl/d9vHsjrlmY1E0aD29+7I5p4tUDw3dNNS5ww7HVCZiSDBV5YOSrOvn4
         C2vz4iaIfKVgL+tJdCgEBu9QcPOUDmxzP1+D6rB0tbzVT5K0ugeSdfz/iyxyq89DPovw
         f4xdxpVINLUlRATVsCGrxmmH90H7uV0TABjDEGecH2zn+ZrQnL0byfj9YJz+/rOH3OIi
         YEESSgUxkJ8KaHTvLAmBuCu2bH9AOKg+TVnfZ6Zq2+kDXtbIJFoYL4e2m6erer+TnXVB
         eg1w==
X-Gm-Message-State: AOAM531erfOjBowdxAtnc5aEH/tUEOpYi2uY4zAWJawKVwV2qkmu0m73
        NXbzNi0yLJSooufF6FIdH6E=
X-Google-Smtp-Source: ABdhPJx/W/HjhM/a4N9svXc2YgAccr1N6UNtTUoDxhEpDeSRKnk2nDGczja/ipyxeEehv5Y5Svxmqg==
X-Received: by 2002:a17:903:2309:b029:e7:1063:e6aa with SMTP id d9-20020a1709032309b02900e71063e6aamr26422893plh.52.1617002264382;
        Mon, 29 Mar 2021 00:17:44 -0700 (PDT)
Received: from vostro (173-228-88-28.dsl.dynamic.fusionbroadband.com. [173.228.88.28])
        by smtp.gmail.com with ESMTPSA id e3sm4092727pfm.43.2021.03.29.00.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 00:17:43 -0700 (PDT)
Sender: Nikitas Angelinas <nikitasangelinas@gmail.com>
Date:   Mon, 29 Mar 2021 00:15:16 -0700
From:   Nikitas Angelinas <nikitas.angelinas@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nikitas Angelinas <nikitas.angelinas@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] locking/mutex: initialize osq lock in __MUTEX_INITIALIZER()
Message-ID: <YGF+hDytO8r9Iv2o@vostro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since __MUTEX_INITIALIZER() is used on memory that is initialized to 0
anyway this change should not have an effect, but it seems better to
initialize osq explicitly for completeness, as done in other macros and
functions that initialize mutex and rwsem.

Signed-off-by: Nikitas Angelinas <nikitas.angelinas@gmail.com>
---
 include/linux/mutex.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 515cff7..bff47f8 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -129,10 +129,18 @@ do {									\
 # define __DEP_MAP_MUTEX_INITIALIZER(lockname)
 #endif
 
+#ifdef CONFIG_MUTEX_SPIN_ON_OWNER
+# define __OSQ_MUTEX_INITIALIZER(lockname)			\
+		, .osq = OSQ_LOCK_UNLOCKED
+#else
+# define __OSQ_MUTEX_INITIALIZER(lockname)
+#endif
+
 #define __MUTEX_INITIALIZER(lockname) \
 		{ .owner = ATOMIC_LONG_INIT(0) \
 		, .wait_lock = __SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
 		, .wait_list = LIST_HEAD_INIT(lockname.wait_list) \
+		__OSQ_MUTEX_INITIALIZER(lockname) \
 		__DEBUG_MUTEX_INITIALIZER(lockname) \
 		__DEP_MAP_MUTEX_INITIALIZER(lockname) }
 
-- 
2.10.0

