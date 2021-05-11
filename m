Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4CD37AECF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhEKSx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbhEKSw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:52:57 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27818C06138D
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:49 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id z1so10202390ils.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ThM6By1VCxDqq9nGwswf9Jqgl1+dbifqaaknL7P7lpY=;
        b=tmaq8Wa2JK6IEvHF8XRUM5s61waWyaSvVWZzIdfvo7JSId8OtSFh7Ma1C6qgIwn2oS
         WwYEhbYuFKlSpjVld89fGZI1Rtg2+gGE8hjJYTAq4DDLyBJHf0PEKrHa+dpkar72I6N0
         qdER3KQymMB3se6FRgiR7LCmE2OnmLLORRfsGXmg5CotrKrXAdzRPmBNbr4U0EkzVU/E
         Zz+D4lv/qj9UG9tqySAfp/iBjgiCtcaglA70HGaj+Rw+hHQ6CFoE619dGRTnzvRNoaPH
         SAxprK/47ugoZJkXusyIFnYZ7xhjh39kO8OquPLLxgoDAlUcJsS8R8ewIGwkVyIBSz59
         0MbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ThM6By1VCxDqq9nGwswf9Jqgl1+dbifqaaknL7P7lpY=;
        b=KW+LonM8+ioE8tM1i5r4SDx+OmO5y9wt+1UkuAUofMd5c//lu5Bsgfet0C04NMzsrW
         5itY2RL+4S+1sTvfduS9R9myBE/21qbxTA0clp/FpUhUIfuJf4s/3CXUXFD57g9M/c+j
         YwaXdvTSJ9B/l2XTkAufnYkfw/Hy39BSgFfWcNa723+hZzfTw+oA+4Uywcpl/HVlYVyo
         9/K92fz0C3Bt0Ur8oPC/rj5Hr0LUHd1uKZkIGJ3D9Q/wAG69B4IPTc56PDcDusAlSelP
         yzAfTdOhJ6Q6CpRRi0/sFdJ9bOL5exoHiEMkDyRyh2duPckKt0FocgIZVMIb5clo5j38
         VS1Q==
X-Gm-Message-State: AOAM533GwbYeNJXwSCiLY5CIefxUOTCQjO+QSNLmauOwrWkQdW3DR4cY
        guOS5nCu+jzx5l3a32/1jCFUXFIoVQC9NeFP
X-Google-Smtp-Source: ABdhPJwLOoKc8zNucxqD6z3quQIcC5LprrzPcsiI+wTrvE/y1VeX8/ej/ZjJJPcQ87ByMgfGvcqmRg==
X-Received: by 2002:a05:6e02:ee1:: with SMTP id j1mr14293787ilk.105.1620759108668;
        Tue, 11 May 2021 11:51:48 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:48 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 20/28] dyndbg: ddebug_add_module() handle headers.
Date:   Tue, 11 May 2021 12:50:49 -0600
Message-Id: <20210511185057.3815777-21-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that header records are in the __dyndbg* sections,
ddebug_add_module() sees them when they're present (when adding
loadable modules and the 1st builtin, but not 2nd..Nth).  Teach
ddebug_add_module() to recognize and account for them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 9d9cb36f40a6..462d364fc788 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1036,7 +1036,18 @@ static int __ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
 	int i;
 
 	v3pr_info("add-module: %s.%d sites\n", modname, numdbgs);
-	if (!numdbgs) {
+
+	if (numdbgs && is_dyndbg_header_pair(tab, sites)) {
+
+		v3pr_info(" header: %d %s.%s.%d\n", tab[0]._index, modname,
+			  tab[0].site->function, tab[0].lineno);
+		WARN_ON(tab[0].site != &sites[0]);
+		if (numdbgs <= 1) {
+			v3pr_info(" skip header %s\n", modname);
+			return 0;
+		}
+
+	} else if (!numdbgs) {
 		v3pr_info(" skip %s\n", modname);
 		return 0;
 	}
-- 
2.31.1

