Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B057E3F6FAE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 08:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbhHYGlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 02:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238560AbhHYGlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:41:10 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60834C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 23:40:25 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id t32so3705227qtc.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 23:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s+1Pm6GoIhQceWNhCI9LO3NE+Toba8IeAI2BMLaHxuM=;
        b=Us1MInW98oKxOH8bV11xiVyMZ4T5ZHvMN5m+8Zh8oopFSAYQ6y0r5TQeG+jEc2yZH+
         b+QfTF0uU7qjBBDTz7LH5LxGWMP2GcOB/q6JyLhP2KUsH3KpyNd9K1+PIELMYSE3H/Ee
         M3W4xAS7QAJGCVgGALmqzkTCP7FCtOgnMaWWuKRy2KSm70/hxmL+3V0loYblhu43CBHA
         64vLm1tKnKkNRWqtx5Kn+QYCTPVNcPB8Tl4vlak5nDsAgy2ce8n2LoNoAFbXRtgZVmRI
         ZITZ70A7KEF1kSLQXKF8dRR8eqSugjW6+ogIf0x5548circRImMA5lgVdwCqSFk4Pn27
         yblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s+1Pm6GoIhQceWNhCI9LO3NE+Toba8IeAI2BMLaHxuM=;
        b=hjMxwv1RUPbLKOJB+gO7doD33u6ETZaj2r/zXzkNu92FRkppUv7WDqsUbg7e615B7K
         80IEeslXmh0S5oO1R9VyoUPYrAqpauLnOnCbhCz1Asbpq9BQhyLjYv7iclDkyvxnfuPR
         b30coecPNiMsiLrmZAjS+20b+RC/fBI6iSpmjjNc66KKcoOTfHJQpLyH/0cXE0lsMQlv
         YU/Tg43u2Q63ZG1fYKjwhDJUl0ty5RYxg7a34aA+oYofdhcd+F1XSZtr14IhAUaqFQmB
         DCbqndKrNmPPPeqkqbEjFPMF9IZ5tsh9cVhNnOtV4+4x+Xju+j6hOABZdegijjSyBHGP
         9rAA==
X-Gm-Message-State: AOAM530Rd9XJ1XSK1J+nRhb6D1ZGe1h4VHze8St52t2aUvyrqpO0uy2W
        ez8y2cxKt5DzBUgW53n2Htw=
X-Google-Smtp-Source: ABdhPJwCb2xXlpRzi1OcVV6/ti9aKo3w6uzHD/CgjJZO1QX99pr6gXQK280IzDJOxppHrSpDAGEl+Q==
X-Received: by 2002:ac8:5dd1:: with SMTP id e17mr38737440qtx.270.1629873624650;
        Tue, 24 Aug 2021 23:40:24 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x21sm12248728qkf.76.2021.08.24.23.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 23:40:24 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <deng.changcheng@zte.com.cn>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Li Huafei <lihuafei1@huawei.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] powerpc:security: replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
Date:   Tue, 24 Aug 2021 23:40:16 -0700
Message-Id: <20210825064016.70421-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Yangyang <jing.yangyang@zte.com.cn>

Fix the following coccicheck warning:
./arch/powerpc/kernel/security.c:807:0-23: WARNING:
 fops_entry_flush should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/powerpc/kernel/security.c:781:0-23:WARNING:
fops_rfi_flush should be defined with DEFINE_DEBUGFS_ATTRIBUTE
./arch/powerpc/kernel/security.c:833:0-23:WARNING:
fops_uaccess_flush should be defined with DEFINE_DEBUGFS_ATTRIBUTE

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>
---
 arch/powerpc/kernel/security.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 1a99849..cf8ce24 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -778,7 +778,7 @@ static int rfi_flush_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_rfi_flush, rfi_flush_get, rfi_flush_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_rfi_flush, rfi_flush_get, rfi_flush_set, "%llu\n");
 
 static int entry_flush_set(void *data, u64 val)
 {
@@ -804,7 +804,7 @@ static int entry_flush_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_entry_flush, entry_flush_get, entry_flush_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_entry_flush, entry_flush_get, entry_flush_set, "%llu\n");
 
 static int uaccess_flush_set(void *data, u64 val)
 {
@@ -830,7 +830,7 @@ static int uaccess_flush_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_uaccess_flush, uaccess_flush_get, uaccess_flush_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_uaccess_flush, uaccess_flush_get, uaccess_flush_set, "%llu\n");
 
 static __init int rfi_flush_debugfs_init(void)
 {
-- 
1.8.3.1


