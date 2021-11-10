Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B01644C094
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhKJMDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbhKJMDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:03:02 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB15C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:00:14 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so1704999pjj.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WphTuTVslZby+oDEm50XCSesh2uHM5bzyfp9NXbgOWI=;
        b=Vz9U3uovhJgmX3sZ7s12i+rm25WA4ywu7yvm+Oro5n7V2BX10VPROsML4ztqa2wAen
         TAOp9lUuuWQGSRoeWXoBzVQuqNQ3jrAbKbHojqabrEQGVQS187+HZjAvliqf3zcuvj4L
         IJufd5apvB75HdeSzCfm5chcFz/aGrYlYLAnpHCqZQ1USnw1c2Nbz5BCJHXJ4pI9kxNz
         LipPMzv0eYNdQkBi3kEIWrexTvlM/4ATDWw/ECV2Ucf/hHzrdBWiYDW82sKUSa+pRRIO
         APZUbLa7OzMjCKAiJL619FVll9nHhVriZAjDXwwKUP7PFsjlLpYlhcsCR3ruy7GtX5oz
         Fdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WphTuTVslZby+oDEm50XCSesh2uHM5bzyfp9NXbgOWI=;
        b=yyVMUt+APDPJ22lV4Qm8ERiDcATx++OycF78PoszTiXWvV82yPbKBpIQGWWX6fesdm
         yyLPef/LapQzCI1geHVKGsjO6wvz0CtaAgapo8iiitWRZD3S6wxTD7iU/3q+GjGRFCWU
         VBwiznXtQ6eTcdZ1jhvBi1fEh8pD0ukWiybo97aBIQxq1yfpLhfAH6YXM4iizUcMwFKk
         PykEQbF8B0QltjASV3AibHOI//D7pDTuviuW6ATezw377znTV9zymEEkwIk53SgEaQM3
         lDgB0t7taNZY442AA7TJ8aloU6EUyYCgEmVVdoRqoRplkvw2YYrw8/+Ye/eUxiEdYejB
         /Ugw==
X-Gm-Message-State: AOAM532i56PGb5DUnlucVkn+b4lU99u3G1Ld5KBcD4/6AgFDvX2B4PTr
        f/qjGgp6mWYKMOqjMLlZpK7OOTQO7aA=
X-Google-Smtp-Source: ABdhPJyCe1GucWsQ6E89940iiCJKISvfUsohG3gy0QzrGTNUdTejT4BVPIBz8mL+wRvurKYEzYANWw==
X-Received: by 2002:a17:90a:f00e:: with SMTP id bt14mr16233365pjb.219.1636545613698;
        Wed, 10 Nov 2021 04:00:13 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id p15sm5587705pjh.1.2021.11.10.04.00.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:00:13 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 26/50] x86/entry: Convert SWAPGS to swapgs in entry_SYSENTER_compat()
Date:   Wed, 10 Nov 2021 19:57:12 +0800
Message-Id: <20211110115736.3776-27-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

XENPV has its own entry point for SYSENTER, it doesn't use
entry_SYSENTER_compat.  So the pv-awared SWAPGS can be changed to
swapgs.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64_compat.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index a4fcea0cab14..72e017c3941f 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -49,7 +49,7 @@
 SYM_CODE_START(entry_SYSENTER_compat)
 	UNWIND_HINT_EMPTY
 	/* Interrupts are off on entry. */
-	SWAPGS
+	swapgs
 
 	pushq	%rax
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
-- 
2.19.1.6.gb485710b

