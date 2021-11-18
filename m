Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D134C4554B6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 07:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243324AbhKRGXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 01:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242003AbhKRGXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 01:23:06 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E08C061570;
        Wed, 17 Nov 2021 22:20:07 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so7304762pjb.5;
        Wed, 17 Nov 2021 22:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RoYCEa35yWQpbsRMiUsNjWpekgd7QWGvSSthS44F8g0=;
        b=bBfb5oEgu6F/76M8eDrzPh/ZwVHkNC/ssyC77zAP2YKASSwTkW1bHBtYtCFfAut8wO
         fJfV3OYGX2a9lDcjSerpc5RFiZM4GbZxHQC66XfRBCZeKwmcs0HNOyBf4pznwtHXuHYq
         pfCvL4X4G/yG3hW7BDciwGBrLEi+w8auXUqzK7SyU0Ntgo7DAvM5fIiRnbN85jCEtIUi
         O2yb0/t0b4JTGdAE1WxlYfRxT7HOZu/cmMVgSpleovrc4yVRWSlGulE7avwNQHhspB2o
         vlyweuG+ZLmO1UJIsL7EV4DQ+AB8j1c47Wb44o/eaV3oAl5616UgMURLZJ8PUS1T2k45
         aWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RoYCEa35yWQpbsRMiUsNjWpekgd7QWGvSSthS44F8g0=;
        b=Ssn7tehNTYUnsgUKabZZcLrs5YFa0Gmi0+/D6Fai3cY89CXY5/GEUxrRJVUcEbrgth
         Q+OwSlHHEtr+LDxPdWa60P8dNdMLDmDYy1RBYAJMBLt206Rf0kbOzx8XpnZld5nf8Hg8
         fdbayekS+CX0RO0+9lZBL5UQ8ebtx+kQdaH7VfS/t7wsgu49y6SCe1sIKKbOk3VUrhNI
         /DAhgK4ZYNhlQm9o6cn1KJLn85JwqGiGUsd+nNxhexcn2cT6N0Jeq5QkYVMUJDUh75XY
         JVPuH7fsZqhSq5uGBxfr1gn2xHPfOa23Za+1ZrcMbE3VqkPT9n5uNGsAzr8DTgSX23nj
         Ptmg==
X-Gm-Message-State: AOAM531yG9ck2xleZiLPMYyTqxkF9cDxlvdZIttSESfRD9UqQr1FhiXj
        InptuqhzrfGzdjxJzBjfAKFMQo6e0Zk=
X-Google-Smtp-Source: ABdhPJx6AF0hwNYuyvmlEPbV8cFcj+fzECG7PPqxTbNCGseWSbtzXpO5zQZuDMr9xbzM4/tHmwGt9Q==
X-Received: by 2002:a17:90b:4d86:: with SMTP id oj6mr7547264pjb.101.1637216406930;
        Wed, 17 Nov 2021 22:20:06 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j22sm1745329pfj.130.2021.11.17.22.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 22:20:06 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: yao.jing2@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     slyfox@gentoo.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yao Jing <yao.jing2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ia64: module: use swap() to make code cleaner
Date:   Thu, 18 Nov 2021 06:20:02 +0000
Message-Id: <20211118062002.164121-1-yao.jing2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yao Jing <yao.jing2@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yao Jing <yao.jing2@zte.com.cn>
---
 arch/ia64/kernel/module.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/ia64/kernel/module.c b/arch/ia64/kernel/module.c
index 2cba53c1da82..360f36b0eb3f 100644
--- a/arch/ia64/kernel/module.c
+++ b/arch/ia64/kernel/module.c
@@ -848,7 +848,7 @@ register_unwind_table (struct module *mod)
 {
 	struct unw_table_entry *start = (void *) mod->arch.unwind->sh_addr;
 	struct unw_table_entry *end = start + mod->arch.unwind->sh_size / sizeof (*start);
-	struct unw_table_entry tmp, *e1, *e2, *core, *init;
+	struct unw_table_entry *e1, *e2, *core, *init;
 	unsigned long num_init = 0, num_core = 0;
 
 	/* First, count how many init and core unwind-table entries there are.  */
@@ -865,9 +865,7 @@ register_unwind_table (struct module *mod)
 	for (e1 = start; e1 < end; ++e1) {
 		for (e2 = e1 + 1; e2 < end; ++e2) {
 			if (e2->start_offset < e1->start_offset) {
-				tmp = *e1;
-				*e1 = *e2;
-				*e2 = tmp;
+				swap(*e1, *e2);
 			}
 		}
 	}
-- 
2.25.1

