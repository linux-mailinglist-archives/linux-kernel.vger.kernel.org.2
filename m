Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E959327E6F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbhCAMeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 07:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhCAMed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:34:33 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F404C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 04:33:51 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id z190so16226311qka.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 04:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kNu918oErMOK+ZGxgvFeLQGP1yknfMSewznhGUJQBFs=;
        b=VvGLOj9mEQ1BkXE2JPFemNS+xpSRwHHh8x9QEiIgNzXqqSa0B0wsrtIu/0bcNy7ZgN
         tpqvaJeLEPORXUeLhCqRnDPjEAvEWn7YxS8OCS6TmbMDLU6jBO6UojItP54hh4i5nluc
         3/RvShyesg2ZKeZ3qUQrhK414B9n4565NTQnf77zWtIiGk6T3alwSpN3z1+SsvXFITuP
         UrlCTks6uHIeux/hTV4M5V0v5VyJLE+yct/P7lMtS0sGCMcpnzP4SZ08wYe+cgjNhLer
         hqCEN2ygtyr6Hot/4yqng2nLDY4E48md5ZYM2lvJvBsqewrCUR02pIOeNg2XLnoH9Fy8
         EIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kNu918oErMOK+ZGxgvFeLQGP1yknfMSewznhGUJQBFs=;
        b=n+2gFeboDThg4Rkbr4icPz1bbWFVD7UHyJMQn5XJbtgmS7Zn1Q+y1cQCkAETdeUdZw
         mVgohYqDD3hTxrGF3jvRxQ6ea0YPjygdclIcrp4dHmZuxoyX9wJfY1pTOgkpb4B2UYtF
         T6Hg5Tvag9XXV/7y7BNiMlh8MFYnrxrYqThYQlVdphAll9VcRZ+OmxwcidFLBCzBxBaS
         d2ii6YT9H6+HgMAWdyn4VAD1ot9PxYcPV/7pbrYmlMapKQ5PHkcv7ndisV4th9KD4Hh2
         kE+Q/1vSnD85reieq2/rab9FSxAMTmWqv+L/BNWiMoCoYU2xpOD4qElgcSHz49EQRZsw
         CJRg==
X-Gm-Message-State: AOAM531lmpQ9MvHXU1u38D4yXnqLaE9Lk/HNbJp2bxrB8qe8GBMR7bBC
        gCIjo70PKlzc8tUDT9Tlj+kSL6Uq0V1zAA==
X-Google-Smtp-Source: ABdhPJyud7fvSZ6NFT9eJT7Fk5WNfoynHgfkW4z30YMik11aQWSL1aw8JZ21iaMV0VSZ/oT+DZV27w==
X-Received: by 2002:a37:9d53:: with SMTP id g80mr14401055qke.499.1614602030426;
        Mon, 01 Mar 2021 04:33:50 -0800 (PST)
Received: from localhost.localdomain ([138.199.13.198])
        by smtp.gmail.com with ESMTPSA id k4sm8091055qte.59.2021.03.01.04.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 04:33:49 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     akpm@linux-foundation.org, gustavo@embeddedor.com,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] lib: Fix a typo in the file bch.c
Date:   Mon,  1 Mar 2021 18:01:29 +0530
Message-Id: <20210301123129.18754-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/buid/build/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 lib/bch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bch.c b/lib/bch.c
index 7c031ee8b93b..c8095f30f254 100644
--- a/lib/bch.c
+++ b/lib/bch.c
@@ -584,7 +584,7 @@ static int find_affine4_roots(struct bch_control *bch, unsigned int a,
 	k = a_log(bch, a);
 	rows[0] = c;

-	/* buid linear system to solve X^4+aX^2+bX+c = 0 */
+	/* build linear system to solve X^4+aX^2+bX+c = 0 */
 	for (i = 0; i < m; i++) {
 		rows[i+1] = bch->a_pow_tab[4*i]^
 			(a ? bch->a_pow_tab[mod_s(bch, k)] : 0)^
--
2.26.2

