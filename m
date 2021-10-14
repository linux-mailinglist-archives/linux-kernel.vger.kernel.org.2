Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E640D42D110
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhJNDi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhJNDiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:38:20 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DCCC061749
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:36:16 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q19so4291758pfl.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SLvPDSjlXuC0odmXJ7mp0PxXfMTmsQLadPLQAXM53SE=;
        b=Bbzug2Y/04OxP9s7efsVgQ0s4SHZ//G8YD4L+wzsaFzHitnV+3+Vc0rf5mGmQegNZU
         8sOVDyhKxjTepklbrKIeyUbXmdVSsEMeG5t72BFXEIUxb1znjJ77lhcRyc0ZMwjbrIgV
         cHxy1m8G/eHvr7J1jgnp98RnYL7RvZ2tPNuEnjC7Tof+eT1EI7YGz995S1qLA8tEzHdv
         NP43g+/qJhIfBCaX3UJXynNeJc6g0KdefrN2RZ0BQXglYxj2y/Pc9n4n7Ga3UcxA5t7b
         RE7dZQbK3y3OM5mgeY/jENpQKW4TzKVoWArAQ1b1r04xbrqvHw8IS6GZPCLqWwJlRjQd
         xThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SLvPDSjlXuC0odmXJ7mp0PxXfMTmsQLadPLQAXM53SE=;
        b=ExF1fLBxfgUdh6TxRJJje5K/nMu6oX79JNPvDR2E3P4EvQPGuBgooTKiXKMqXkvm9j
         gk52SYeb/wU/rE6HnFz4nO2gwESdIPyJbq5qHcRoHOngPkqpiyDBlwmn23UyXCkNz6KA
         ndLP/xfGTAYYzwKjAnIYx1PRT83Tbn9qOeJojpg9eUIOklkkKtV77POcJEvXXzhs5UI7
         I5MocYXkYTT9G9+/pI+8g0VjPREfVCaAzyMMoi1YHuh17JxR1DNfOyPLRhJURjvx6Cxo
         Dhd7SgXHyfhqAwU1irzq8KI4WDaAJg6Jjgg0H2SdXi/lnHUtQ3Cx6GbNvYlIg7Xdsh9A
         kD0Q==
X-Gm-Message-State: AOAM5321tNFYs7fe5nhZcy0B4foaekmgSej7+330M+QL3T0N0Di3W8vu
        Z2PyFL1t5wcEnxtgiNXwQijgBo7C8L8=
X-Google-Smtp-Source: ABdhPJzSLQy1ryN4I73CWCdaffveE9nLOyOzIV+/MmOO/fyYKQtg/Aqbxt6xbUUtJOtTgDIw2d+W+w==
X-Received: by 2002:a05:6a00:1c42:b0:44d:2e14:74b7 with SMTP id s2-20020a056a001c4200b0044d2e1474b7mr3226118pfw.25.1634182575613;
        Wed, 13 Oct 2021 20:36:15 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id x7sm7307302pjg.5.2021.10.13.20.36.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:36:15 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 23/49] x86/entry: Convert SWAPGS to swapgs in error_entry()
Date:   Thu, 14 Oct 2021 11:33:46 +0800
Message-Id: <20211014033414.16321-18-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

XENPV doesn't use error_entry() anymore, so the pv-aware SWAPGS can be
changed to native swapgs.

It is prepared for later patch to convert error_entry() to C code, which
uses native_swapgs() directly.  Converting SWAPGS to swapgs in ASM
error_entry first to ensure the later patch has zero semantic change.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9bad620553c8..b97ce4204f6d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -996,7 +996,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * We entered from user mode or we're pretending to have entered
 	 * from user mode due to an IRET fault.
 	 */
-	SWAPGS
+	swapgs
 	FENCE_SWAPGS_USER_ENTRY
 	/* We have user CR3.  Change to kernel CR3. */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
@@ -1028,7 +1028,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * gsbase and proceed.  We'll fix up the exception and land in
 	 * .Lgs_change's error handler with kernel gsbase.
 	 */
-	SWAPGS
+	swapgs
 
 	/*
 	 * The above code has no serializing instruction.  So do an lfence
@@ -1050,7 +1050,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * We came from an IRET to user mode, so we have user
 	 * gsbase and CR3.  Switch to kernel gsbase and CR3:
 	 */
-	SWAPGS
+	swapgs
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 
-- 
2.19.1.6.gb485710b

