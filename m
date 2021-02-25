Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB09E324B51
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 08:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhBYHez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 02:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbhBYHeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:34:15 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF25C061756
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 23:33:49 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id p21so3206048pgl.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 23:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zgKO3MnWtgg50f4xin0lRAlnzGDn6IFUU+LS1IwPjiI=;
        b=W/Hk+wWyxzLK85Yspxk1j9kKCNb2H/TE8Nr3Gsd4yYPhFoQqeFYulVz1ESEv9Xuyuy
         RhNtM6Hwq7cRgFjCtqGqXH7Iue9w/00NIlLkAeKmW5eCHN17S92vu71m/qLWNUua1ZWj
         FNsUtTlmdX+nONjru1+lUpNNeuvBTw+cJrb0fzST/1ux/1h1Zf/pA+ka4vtqCmriGpAl
         3cXsbLbzA+B0VKEYW2J9LQqIkd5v16cHVUPeZzrBkRZcLlpA8kDNqk7A6dSmOS1oZ84L
         ngFdFH4gKzdcvg4IPh7w74oNyMY8vDSCc91N2A5IfH2YVvLJDAPd30cPIBoXLCu23wxW
         nSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zgKO3MnWtgg50f4xin0lRAlnzGDn6IFUU+LS1IwPjiI=;
        b=mNWz07AwU+oIE3BvcMUj3HIj7sfMuc7AqLEIhW9/M5loSXAmUEEb5AyxSeUICeAqxv
         B0w6qYRuoO6PZUO74He7p6KvKAN/hiMq++yHKUzn+bEHFb3xFVtNowBorj/6w1uVkl+9
         SJwuF5IfYXAfphwcEIC8oMN+1c+Hjz6tjEbmXHJc7WpoGEdBlVfWe8x9oLXbAuBwp059
         J4cEhVqAMMsg93GhpUzB5rQbS+5yJ8G5FbzzwsF0K1fpje6VkP2dBYL6nCfT/AzaUhHJ
         5LNA0bE4jAH9qTeLIifAMJl7RhqhpTvWM62Y6WKTqgIJRfHeT3pC/Ul9TteUcRoUhjlm
         /j9A==
X-Gm-Message-State: AOAM532ZD80AVXjxikBvNlv91OQpUa/a/SwkAUdwHq2XQbxoXSpfbcn3
        yAspN53NJF0x0OarDVhQffQ=
X-Google-Smtp-Source: ABdhPJxSLsgCDlJ2iNA9exMeg5JU1gPQkYTFM9O+DtIiU0GZ0RewqOlVs2JHJeIXT5peHT7BfkCfag==
X-Received: by 2002:a05:6a00:1a4b:b029:1d2:8522:75e7 with SMTP id h11-20020a056a001a4bb02901d2852275e7mr2037326pfv.80.1614238429290;
        Wed, 24 Feb 2021 23:33:49 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id w3sm4917561pjt.24.2021.02.24.23.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 23:33:48 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Nadav Amit <namit@vmware.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
Subject: [RFC 1/6] vdso/extable: fix calculation of base
Date:   Wed, 24 Feb 2021 23:29:05 -0800
Message-Id: <20210225072910.2811795-2-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225072910.2811795-1-namit@vmware.com>
References: <20210225072910.2811795-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Apparently, the assembly considers __ex_table as the location when the
pushsection directive was issued. Therefore when there is more than a
single entry in the vDSO exception table, the calculations of the base
and fixup are wrong.

Fix the calculations of the expected fault IP and new IP by adjusting
the base after each entry.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/entry/vdso/extable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/extable.c b/arch/x86/entry/vdso/extable.c
index afcf5b65beef..c81e78636220 100644
--- a/arch/x86/entry/vdso/extable.c
+++ b/arch/x86/entry/vdso/extable.c
@@ -32,7 +32,7 @@ bool fixup_vdso_exception(struct pt_regs *regs, int trapnr,
 	nr_entries = image->extable_len / (sizeof(*extable));
 	extable = image->extable;
 
-	for (i = 0; i < nr_entries; i++) {
+	for (i = 0; i < nr_entries; i++, base += sizeof(*extable)) {
 		if (regs->ip == base + extable[i].insn) {
 			regs->ip = base + extable[i].fixup;
 			regs->di = trapnr;
-- 
2.25.1

