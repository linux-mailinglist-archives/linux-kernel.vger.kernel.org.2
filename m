Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92ACF44D8F4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 16:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhKKPQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 10:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbhKKPQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 10:16:42 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF76C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 07:13:53 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id n8so6014896plf.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 07:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Y/jSvyVYVriDEnf2onEJfnbE/ebPIHDOCGnwKst4W8=;
        b=EIhXZaOvRjWi1qNzyHj+V8EDoHe4FqqMr3C+y1PSzIaNsPNyc0QkdJf5NJhHo7xtWR
         fofgmHM3DnDKEUwS/aeSrAk+949QK9VjZs2CDs+3Tn7tSKg2UbLFiv+FFMu8k1JfnerQ
         2MoSic5RUQ8wMwFeHeaHR/GU40BcBSJEed/usLVWHt0RNzmN2YR5kIfvWW0VQKv14aWA
         3G8maw5c3UrtQ1coVBLofWrFYv57VZcvD4PclrVIdRHppBdeVxIynkr2PF8a5/GALg5T
         RIkElaau4UcdGKASlh1winW7m3S8SohYVc5SbLtOe3UKBa31WI7RrwCwVXQkHO25OoIi
         E51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Y/jSvyVYVriDEnf2onEJfnbE/ebPIHDOCGnwKst4W8=;
        b=ebhi+XQdO51JJeosOzeC+ihUOkaLe/1DBqX32xXeIbUcd8Pd1hiwzLlGslvv+MjhSq
         NexgVWqly1ExcIKP/syRA0gqq92bsAwml500yG3V7OWZbmnY7kpOasjjw2M+Virqrm5X
         PRgAJio3tu793Z8r+IzgY3Qh0QYZaJvrahhoLw2t8TbTPpVe7wTUeWxPPLEEZv6jIk8p
         GL/VSic7J35tCcbqIBbpgvjir95qdPgOyBqyEyu2nLNxd+DtC6Bdz974IZe27Nl+LPFI
         OedGX7AZ1y4SE9+tRhcsNzL8laNpCApOG2wxydhmrtRruuS2mefB/nnl2wWKImoKrmT8
         8h3A==
X-Gm-Message-State: AOAM530zpkCLHcdjQ7B5LdLHFwP2cKjBcBxA7T133B3nMWI8povT7Unp
        Sdx2DnTHGXKA7Z9Ei8L9LAo=
X-Google-Smtp-Source: ABdhPJyedd5YHjhjtghc2EvgyqxJ1PVX/VL+fOaqZHyRh+wlCtGJsltPsajKjq0vSiUG2s1w+9WWnw==
X-Received: by 2002:a17:90b:4f4c:: with SMTP id pj12mr27190737pjb.217.1636643632840;
        Thu, 11 Nov 2021 07:13:52 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a12sm8511522pjq.16.2021.11.11.07.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 07:13:52 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: luo.penghao@zte.com.cn
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] x86/unwind: Remove the initialization of mid
Date:   Thu, 11 Nov 2021 15:13:47 +0000
Message-Id: <20211111151347.2741-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: luo penghao <luo.penghao@zte.com.cn>

In the execution of the function, only the while loop will use this
variable. And the value of mid will be overwritten at the beginning

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 arch/x86/kernel/unwind_orc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index a120253..02556e0 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -35,7 +35,7 @@ static struct orc_entry *__orc_find(int *ip_table, struct orc_entry *u_table,
 {
 	int *first = ip_table;
 	int *last = ip_table + num_entries - 1;
-	int *mid = first, *found = first;
+	int *mid, *found = first;
 
 	if (!num_entries)
 		return NULL;
-- 
2.15.2


