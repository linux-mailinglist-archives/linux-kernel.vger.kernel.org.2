Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C508444EDC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 07:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhKDG3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 02:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhKDG3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 02:29:30 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0E9C06127A;
        Wed,  3 Nov 2021 23:26:53 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u11so5618286plf.3;
        Wed, 03 Nov 2021 23:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KY/GBnk19u3Mg/COUdvMRNbYa4GSQudlZpKtuS9a1i8=;
        b=D82mpwHxjeuwov1wekSpQDQRPsJcfzR+YPH9rpwUXC7/3qEeP5b6BW3nzXI0Y1Lt2e
         Xd0oBEpnjftXIkAlFIoMyGZuHTDz5q6N/wkzL/7tW2UlZ4WWeintlF5qJVavGThvNByG
         txyP/PWqreRDmnPyD5GaVa/xslbQZXel9SKf85yB3FKYeoN0l2ITRg8WC5ASR06KKHla
         JzUOew662xyL52lp2wBum2Sp7HGaQYBGEY1iZBcbTT0oosuNee4UGBc3BP5kZ2ibb3jX
         QfbGIppH72hCxfygUL6/35v+YQUkEcPoi/SalM1h+pYRrXpfRif0M1/CzgblsJhS3zRo
         h8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KY/GBnk19u3Mg/COUdvMRNbYa4GSQudlZpKtuS9a1i8=;
        b=v4rotc+1HVRwLGMNZTH5jYgcUc2QiK/uUe/3hPYAah9XesBI36W7udnQj2yBZBSfgh
         T0SXaEztO7SVr/M+Rp2oTGjfpMWRpyThb+CEf8X+EQ9HX5i70dPZXqlVMais7Wwio/TB
         UTlkiJ9TvG67GObkTPafAkrw7oWhn8F+DDoEuDXCZc45/i2PMsy9d1RJ2IyEImrc7ED7
         5u9Aj5ZvlVsSr7F1pZYgkZfn26+cjCcYSKu14xgPLpO12Jlq6Dpx06iV18rj6G0VippC
         IrgQmVRvz8YRgX+wfOkayEAYoAjZfTmZuLMHl6xVFyX1bb/iZjyuPF/liGKi4eMtqBtw
         8qLw==
X-Gm-Message-State: AOAM530tcRzGrh8SFtonfebzlZ923KxYGCNOimtVNXaBiifWm7NHQlmO
        1eiiVeqsZ/xzps6O4ivAN/I=
X-Google-Smtp-Source: ABdhPJwvHdKSnudgzsotbuXFk2QuG9moMXT/Fspix3ojz630qsrv9IsTgv4BWlY0XsqM8Ou+rnJbbg==
X-Received: by 2002:a17:90b:390f:: with SMTP id ob15mr15581023pjb.82.1636007213112;
        Wed, 03 Nov 2021 23:26:53 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id c19sm2619027pgc.55.2021.11.03.23.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 23:26:52 -0700 (PDT)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     slyfox@gentoo.org
Cc:     davidcomponentone@gmail.com, akpm@linux-foundation.org,
        yang.guang5@zte.com.cn, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ia64: module: use swap() to make code cleaner
Date:   Thu,  4 Nov 2021 14:26:42 +0800
Message-Id: <20211104062642.1506539-1-yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
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
2.30.2

