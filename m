Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E81537AED3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhEKSxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbhEKSxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:53:03 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246F7C06134F
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:52 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id j12so18079384ils.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9hgZRYHg+xD/GTpqGrDIeQXKedd/7xSgbcQRecHsrro=;
        b=Pz4zotfvTBAwUyssz0mfWcsn95ijYGiouDZ0Ib9SBZY8YjkPG+bQjS40T0D9AvOi3z
         W98YFcMcagS1D4VxIYm8UbzOtxX276ULVpVCMW4adwelIYyQyVglUnbJPUFx9sckGoT7
         8yBA8ZJY06fC8W6oB7WhTErVMMv5OMpLgRxss5cBqCaT3dPjQLXdf98WF4kkZjsVVsEB
         s6vBHAFd6IlklDeEMF/dnYfWJZEP3Hw9KUf2/vnR7RHl0jZW8yT1BpKmNwtt8NFf3ZWJ
         3+8PuQKbT0qJy3tGRmEkzn8Gq57AEsfpe2eGPcXwbaufSeHKlmgo/kCXI4gdrunH4n9K
         d1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9hgZRYHg+xD/GTpqGrDIeQXKedd/7xSgbcQRecHsrro=;
        b=nBKWTeHTv5A/y7JoKSPXdARRC+9nAvRlXmm/4ZKOKlg8SAxM4lhHq8UGatHR1jxpcd
         MYq/8x9hMMNHyfkPwxsv9o6W91oPlRSXj8kHyxyDFWy6QFxfKCNVwOP1MggKT34ZaTDM
         twZq75IeAw4RqCvagkdbdrMK2WyGRz9bPfij0RWXfoT3a2Lk4HO8BCQjBH8hCx9vEsJF
         5F2mo6mkPi+8rBFkBXsEP4KrT4QQTdKITaCXMeEvhyVeKqdSm+BrQsllHPZQeNNkiKCZ
         l0KQqxUSg2GAsB13yX9YuCIimmd3xdVzRy43yXye/04xUTq7LHEVe1LTVAUsOrq5gJs0
         MvRQ==
X-Gm-Message-State: AOAM530pBuSLoyArd06H/Gnk5HvF+JAN9cxPH4ed7pigLwyJutkOndBT
        9kYofFklJlSbZ7+Z/nl8tgU=
X-Google-Smtp-Source: ABdhPJwFe7BCCynBSquUHZ7yLVDDI9YazdXVtAghAHfST2PIv7+SQJcdFDrM5oDltgToXxTjNxVm5w==
X-Received: by 2002:a05:6e02:12b3:: with SMTP id f19mr28258870ilr.219.1620759111600;
        Tue, 11 May 2021 11:51:51 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:51 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 23/28] dyndbg: dont show header records in control
Date:   Tue, 11 May 2021 12:50:52 -0600
Message-Id: <20210511185057.3815777-24-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

header record pairs are special in that the filename member no longer
points at string data, but back at the data structure.

Theres no reason to expose this in control file, and no reason to even
print a line for the header, since its not part of the interface.

Printing a "# header" line is a decent alternative, but separate.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index d0477450ec0c..b83187e72ee0 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -995,7 +995,9 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 
 	dc = ddebug_site_get(dp);
 
-	if (dc) {
+	if (dc && is_dyndbg_header_pair(dp, dc)) {
+		/* skip output on header */
+	} else if (dc) {
 		seq_printf(m, "%s:%u [%s]%s =%s \"",
 			   trim_prefix(dc->filename), dp->lineno,
 			   iter->table->mod_name, dc->function,
-- 
2.31.1

