Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5018B3D8602
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 05:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbhG1DH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 23:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbhG1DH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 23:07:56 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A06AC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 20:07:55 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so2183645pjh.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 20:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QG2m1gtXY7TMdc9NGShpRIhlKkKy4n4CWGd+SWSn1rY=;
        b=bUlL+TSOVIir8eOAIsDVIAAJOevMUwl3Kt0/z/18yhcgF6WsY5kTYUTCznVZvklUvl
         nyZ+Z2CWZn57/1iX7/AhGnGKlGuNoA1iv8coqooDLkAZXl55dxnoRK2o64A1V0/tKw99
         GoQGUgltZQCgUeDxPYNABuDhBqgLeDony45iEVV74BfXw1s+8HjMl/OeaVfoqG3KNktO
         Sk/tqeGcXr3ZPZ2X0RxCW1apZ73anbsxCIbhEWla7q7Cr0kipDMcbiIDyR1x0YHJMck/
         nWFI0KEOTSA5du2IZ1fmwQz9aymAOJi1O3VQP/iFTp9dKwG1MLH8xI76zZE3xNqFXF0a
         Wcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QG2m1gtXY7TMdc9NGShpRIhlKkKy4n4CWGd+SWSn1rY=;
        b=aNNjhhcgZMCiyCZo6atzdinyfWWVBtLdgC2CVQ25PX8Uo4JZQ9Hz3JCX7SsfyhpYil
         I4/U3SbA+W0uGqwe99XxalXe2133saLwluLLKsIy4/R5NzpQdWuDpB5ZpPen3i/39gQU
         i8ZU5t4luNbAazr++OCTGQ34UpJTbw5xDnA5WazO9AwTVMzt5LdMkv6pLiBgc5OMfKVx
         NDvcj2CL5vlN924Y6xmHTzEJzw30yrDU8/rhhFV42G8k0F49U+3KfyxK5EaGn/wq3R08
         ukretqbxOVMSKs0Sxy8CZDIyufWrcKhplHfpSpenn0Lt3rYvcwYJEaB1YVC7ohFy6Y/l
         zzDA==
X-Gm-Message-State: AOAM530lNPLsW4k3jPMlaNDXjwHEAoNJnl5W7iDvYEew5tKjKDT4nGaX
        mpnEOEAs0tkNIne34ZKtxmc=
X-Google-Smtp-Source: ABdhPJy4SX6C1x3v6zH62iE03ckM4Usrn7ATdzN/Lgf5JgncaWqzuzCcK2YUI5MVdE6GNC69SfGpCg==
X-Received: by 2002:a17:90b:250f:: with SMTP id ns15mr7255935pjb.26.1627441675172;
        Tue, 27 Jul 2021 20:07:55 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t3sm5345303pfd.153.2021.07.27.20.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 20:07:54 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     akpm@linux-foundation.org, rdunlap@infradead.org
Cc:     sh_def@163.com, yang.yang29@zte.com.cn,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] acct: Use dedicated helper to access rlimit values
Date:   Tue, 27 Jul 2021 20:08:23 -0700
Message-Id: <20210728030822.524789-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

Use rlimit() helper instead of manually writing whole chain from
task to rlimit value. See patch "posix-cpu-timers: Use dedicated
helper to access rlimit values".

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 kernel/acct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index a64102be2bb0..23a7ab8e6cbc 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -478,7 +478,7 @@ static void do_acct_process(struct bsd_acct_struct *acct)
 	/*
 	 * Accounting records are not subject to resource limits.
 	 */
-	flim = current->signal->rlim[RLIMIT_FSIZE].rlim_cur;
+	flim = rlimit(RLIMIT_FSIZE);
 	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
 	/* Perform file operations on behalf of whoever enabled accounting */
 	orig_cred = override_creds(file->f_cred);
-- 
2.25.1

