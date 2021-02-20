Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91E83207B0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 00:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBTX34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 18:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhBTXXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 18:23:19 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D22C061797
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 15:22:32 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id j24so1362934pfi.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 15:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BIGRgbEs/t4RBf6ZeZc16x5LJucnukGEkzkgq8yfXMo=;
        b=C2WE8xLVMkRF+kneEi9k1K80ncYOrIMr+3EDzits/omeQaePCUtkW70nb+mMHiCzJJ
         pnMCfYUIOljYsU4TziUHOuDMusb4XQDTK0O1mQ6Vf9kJsEiVvtNutTg5vb0LV0s9yvYU
         n/FXNy+wqYW9Drm09vgfU8+47/7WG4QrqJAGNRjLpu1y6dtjzykJJPNKgvKapvXdBKsC
         2z89fVeC+cawkaW1QBxLxZ96/pd9F8ZSKMAyOOpQROvdEY1SQjfrzWYCWCgnhih2VZsG
         dQvLlxR7/6CTFSyW0qqCa0MELsGOOb47Zqjuwd/9UVqCS9Av6U1UJSm/ggOd9kVp8Eaj
         oZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BIGRgbEs/t4RBf6ZeZc16x5LJucnukGEkzkgq8yfXMo=;
        b=q6I/ghSSKvx8xXnst7ZIrRBtSxGjeB4hw9lxypNTElzFjrDfvShfD9rxzDkCnucsle
         0ENLSJO30zbsXcsiv8ReKSN7189XW0g94+Ms2gTWnsGOZq+QQuALjfJTaMqVGtveXlK5
         7PRRFvjlyHqDi1Llfr/KitII9WTOh9sgmM6xe3PaNZ34yi9WvaiMPKb97zaBsmWGYAfJ
         8zIeCXlPW5mKd9L0I+gmHaVYfM9EfCcR0argB4MvJRg+gTfK1ehdyVLlmWOML9nphRO5
         Cwe7l3CmCitSeVDqzvqYmrlUQAzJXONKqWycIGmi5E+A2QRonrcbZu98DbiG4+gYHRih
         /pNA==
X-Gm-Message-State: AOAM5333XeGQyN4WQzLhtUnhRjf+9Pkxx+zMHIxuSN9smumVkzFRa0BZ
        3pOtkTqTdBRZiA30u/P0jJPJsjKbK1sLZw==
X-Google-Smtp-Source: ABdhPJxDBsBdUY40gV8EEtqP1m72o80GQxnY9jF4K4a4fgPOTlwQawGeC6Sh/BklvHCfjESbQmMGeQ==
X-Received: by 2002:a05:6a00:1353:b029:1c5:8a8d:7ee6 with SMTP id k19-20020a056a001353b02901c58a8d7ee6mr15199578pfu.13.1613863351714;
        Sat, 20 Feb 2021 15:22:31 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 4sm13171538pjc.23.2021.02.20.15.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 15:22:31 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v6 7/9] cpumask: Mark functions as pure
Date:   Sat, 20 Feb 2021 15:17:10 -0800
Message-Id: <20210220231712.2475218-8-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210220231712.2475218-1-namit@vmware.com>
References: <20210220231712.2475218-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

cpumask_next_and() and cpumask_any_but() are pure, and marking them as
such seems to generate different and presumably better code for
native_flush_tlb_multi().

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 include/linux/cpumask.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 383684e30f12..c53364c4296d 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -235,7 +235,7 @@ static inline unsigned int cpumask_last(const struct cpumask *srcp)
 	return find_last_bit(cpumask_bits(srcp), nr_cpumask_bits);
 }
 
-unsigned int cpumask_next(int n, const struct cpumask *srcp);
+unsigned int __pure cpumask_next(int n, const struct cpumask *srcp);
 
 /**
  * cpumask_next_zero - get the next unset cpu in a cpumask
@@ -252,8 +252,8 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 	return find_next_zero_bit(cpumask_bits(srcp), nr_cpumask_bits, n+1);
 }
 
-int cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
-int cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
+int __pure cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
+int __pure cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
 unsigned int cpumask_local_spread(unsigned int i, int node);
 int cpumask_any_and_distribute(const struct cpumask *src1p,
 			       const struct cpumask *src2p);
-- 
2.25.1

