Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27912374E2B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 06:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhEFECF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 00:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhEFEBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 00:01:30 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA12C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 21:00:31 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z14so3639984ioc.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 21:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i67flTFoB4QRwON/dyqZZcWquPhCyAP0huOpQ7dHxI8=;
        b=gwj7f6qXH6FVVsTH3Jju8EUJ9kKLNkYzt54CsIPvBNU3zpr+Eopap6jlRyCvCZ9Wjr
         CdTCZ50ERDgSoYredSxOKnEcdH/r92pIxNsNVTFLNqMv62rOuUOMT0Mg6TNrAdSCMQas
         pGYosb9ev5HDyvQNHm0vBa6qZcdmPnHlNaY8B1AkNDQeeKH5YHX2OkMSXRCxy56gQbFI
         8ZxShLQZbq2q5TAfDn1EvlHud+KpGEdjxWCcUrxAofb2zgbHBqjBqb1viNQT9sWzOBQB
         pvlixHUWIcCxsBWXpE7WqtdcaSVJb655/PsYxmGlmVCIFurvoDJ+oRCcRfaHZG72l3h/
         g7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i67flTFoB4QRwON/dyqZZcWquPhCyAP0huOpQ7dHxI8=;
        b=BgTmeMEfWwwsggba7QQLnMGy1m43uHw6DAlfqQlDFYUYJpZ3C/5VS+blnh9IDjT40P
         G1jC28ktbk8ON9xASHuRGpeSnLNUi+gmEi/ZcJ0dLabB45SjzlPCaSdBTea94TaC5aYW
         nwW7uVT5GxOqYMHGQRM0lPTaGHIu/lM5vtbTUS4EjlDIULORMu7EFjjsy4PNCUNMP+x2
         YaSDoJqeC81RFFTzoq98BCrNfQxcA1vX1ye9Dv85bfTpxCIxHi4EAWEKG4uZgh1rRMwB
         IxnpqrdZI243zC4uKKbKiXfJQJGIizAM3ZbAS84jkEujStZP10j0FQrNrQ71Rnp1Hw6X
         46iQ==
X-Gm-Message-State: AOAM531gi0XSid96Yi020wTjI48wrGaBOUP18Hxt8fKDmJ4hHBLT9++X
        AEiGbxm8WSlARlFDdIjT8Nxew7/wWTDdOw==
X-Google-Smtp-Source: ABdhPJxoy3yS6foA1dQKDN/Wai2LUfWNm/KBSEyWdXU5xYN/ACoPGNqPkD72KJukxRJu+a7QjbNSjg==
X-Received: by 2002:a6b:be06:: with SMTP id o6mr1519019iof.193.1620273630937;
        Wed, 05 May 2021 21:00:30 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id v2sm536918ioe.22.2021.05.05.21.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 21:00:30 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 1/4] module: add modname being loaded to pr_debugs
Date:   Wed,  5 May 2021 22:00:16 -0600
Message-Id: <20210506040019.1322778-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210506040019.1322778-1-jim.cromie@gmail.com>
References: <20210506040019.1322778-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enabled, pr_debugs in layout_sections() and move_module() write
~50 messages for each module loaded.  Add module name into the header
lines in that output.

no functional changes

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 kernel/module.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 30479355ab85..af2641b28d73 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2421,7 +2421,7 @@ static void layout_sections(struct module *mod, struct load_info *info)
 	for (i = 0; i < info->hdr->e_shnum; i++)
 		info->sechdrs[i].sh_entsize = ~0UL;
 
-	pr_debug("Core section allocation order:\n");
+	pr_debug("Core section allocation order for %s:\n", mod->name);
 	for (m = 0; m < ARRAY_SIZE(masks); ++m) {
 		for (i = 0; i < info->hdr->e_shnum; ++i) {
 			Elf_Shdr *s = &info->sechdrs[i];
@@ -2454,7 +2454,7 @@ static void layout_sections(struct module *mod, struct load_info *info)
 		}
 	}
 
-	pr_debug("Init section allocation order:\n");
+	pr_debug("Init section allocation order for %s:\n", mod->name);
 	for (m = 0; m < ARRAY_SIZE(masks); ++m) {
 		for (i = 0; i < info->hdr->e_shnum; ++i) {
 			Elf_Shdr *s = &info->sechdrs[i];
@@ -3375,7 +3375,7 @@ static int move_module(struct module *mod, struct load_info *info)
 		mod->init_layout.base = NULL;
 
 	/* Transfer each section which specifies SHF_ALLOC */
-	pr_debug("final section addresses:\n");
+	pr_debug("Final section addresses for %s:\n", mod->name);
 	for (i = 0; i < info->hdr->e_shnum; i++) {
 		void *dest;
 		Elf_Shdr *shdr = &info->sechdrs[i];
-- 
2.30.2

