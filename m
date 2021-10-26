Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8424E43B442
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbhJZOgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:36:39 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:52656
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234211AbhJZOgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:36:38 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4BB673F172
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 14:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635258853;
        bh=eDxSkDWuV2Brl7cNvyAavjHeovH27qcvC2ratC3kbv8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=P1L7QojtR3MKwvXvPP2OAz83YqtC3rS09Rs1W3MJjFr7LbxjzGY69bmkcCtmiRrcN
         XozqnLsoakyM7Qs5B31Uhi+A6iUnJ2DYLV89fPhT39DNiUf6fbfXgpKj8ntVUOfJW6
         fmJ6zw/gyzpGTAO/FGaHKBxsQKdz7xmb1iM5IhbN+BzryCcHzXnx9ETpS1qmreHC9p
         8JYyNZHRpCjuI6L6R8dXZkAwYWw78ItzXzYkxemW+jpTkpOxV86t+/dmlArvW/lmzU
         KK4TkTeGj8mf0VmubSaHt7unxAOOjPAmRp9CPga58+qhb++0Byy62ySYviZ6sfv7Hz
         Ri9GFDEda8b8A==
Received: by mail-wm1-f71.google.com with SMTP id y12-20020a1c7d0c000000b0032ccaad73d0so738927wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eDxSkDWuV2Brl7cNvyAavjHeovH27qcvC2ratC3kbv8=;
        b=DZ5GzIN5JlidHU2l/aGvmV/v2n4yw1VOPfr+HLh+74o72x+qXC7j/s1Ia/Zqh/Qw3e
         dSLRDRR2Udez7jPoGIztGRYWSHUiJyMCFtGzJII1h25NMCnRMUTvzZxcAS7Wfmr2pkCo
         fZEyBFEBTCImopYs1gdRREYbvKOMRefjVayIo3jibMJFO6GHkii2T9Yto/GDf4nhGsZB
         QkvL7SPXRQwU54Uv7lnT6sNP4IYHKUKErpNCGc8UkqdW67gTtY9NeBWYuW3BGLoxlDU/
         L0ljF9idtGCMY7K1mCtAyRl0s9BEjLlObgnE8dYweygQKuLWw5kX26N0mYGQDvC5Uz6Z
         sP5A==
X-Gm-Message-State: AOAM533eK2W263QBIPHxAawdJl/nc0iI5rLhjhng2Qyt2+xWbRoXqOcy
        aEgptoZBYE9GMkg1xF/BX8+F4QXXpqYWxXnGRuzsfjnRFe3LOWyHBURr4YtR1Hn0+W6j6+1M4OH
        PqbJ5Qu0jyHocnuNaymQZASPNyplvHwutHOq+Td1+sw==
X-Received: by 2002:a5d:58ec:: with SMTP id f12mr32833780wrd.24.1635258852983;
        Tue, 26 Oct 2021 07:34:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEiliuRm8Od3p070aft+0SzvwyEHzdS3NpXZbNSe6M5MRDCzikoxxtwZ2bnpDR86tzT0wrFA==
X-Received: by 2002:a5d:58ec:: with SMTP id f12mr32833741wrd.24.1635258852720;
        Tue, 26 Oct 2021 07:34:12 -0700 (PDT)
Received: from arighi-desktop.homenet.telecomitalia.it ([151.57.120.224])
        by smtp.gmail.com with ESMTPSA id p1sm800266wmq.23.2021.10.26.07.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 07:34:12 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: fix fclose/pclose mismatch
Date:   Tue, 26 Oct 2021 16:34:09 +0200
Message-Id: <20211026143409.42666-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to use pclose() to properly close the pipe opened by popen().

Fixes: 81f77fd0deeb ("bpf: add selftest for stackmap with BPF_F_STACK_BUILD_ID")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/testing/selftests/bpf/test_progs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index cc1cd240445d..e3fea6f281e4 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -370,7 +370,7 @@ int extract_build_id(char *build_id, size_t size)
 
 	if (getline(&line, &len, fp) == -1)
 		goto err;
-	fclose(fp);
+	pclose(fp);
 
 	if (len > size)
 		len = size;
@@ -379,7 +379,7 @@ int extract_build_id(char *build_id, size_t size)
 	free(line);
 	return 0;
 err:
-	fclose(fp);
+	pclose(fp);
 	return -1;
 }
 
-- 
2.32.0

