Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F1734A015
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 04:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhCZDKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 23:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhCZDK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 23:10:29 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01164C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 20:10:28 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id y18so3968313qky.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 20:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZfYQVAc0q48o/sshvlJlwtPc1xdx6AiCD/XN05XutAA=;
        b=Adx5EnlMPuX43gT4oGB4D4kuU4jQlgpM9m4gQvxHmXJ3LcG/ppIIUmbARdHPuZZjoD
         UYUOh24K6pawsR4Izw8NyiVecYC8f7UVqN4VEnyzgwwt7AkEa4W7gPWkiPhXJ8qO8TjX
         jF6R3PPTTKeqhs8sspeuCZik5123zJrKAEDMvL0ViOMZPSmBD16EDBqNEFd4sIX1hKA0
         OW9YGqtkYh+8jneS2w5kY3hOmxMBopwR34vyxgfzIdcERPgmu3gbTQmW9iK8Ob/M12Y1
         NSABRkl9eKrpDqFa9D6xS2BHk5uhdS/Ap/nSHKctsB/yM4gQHsjC6cUXuqnbRmQCdSo0
         oN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZfYQVAc0q48o/sshvlJlwtPc1xdx6AiCD/XN05XutAA=;
        b=HEeskl6lAzHhL6BBgj42CxiQ4lilMbT/Z2tqjqp5yfSZDDSrePIQbugOAY4uCkACgK
         q9ITp1reHt320pD4vGyM2lZvqnhgHZQxLJhFlfbrnGP++C6Wi4mJcBTGDmU5fORIhJky
         TpiweHnCfx1wic7CeCbK1V88RmgtWfCAvvq+X4TXBrCOWOxP1lwFw3/pnceSkOZ5xvQX
         5UePquAyWdCmGydZ1r1Ga6GhkFkmSSvgvgL23LXMcU/4T7of3RDOovyzACDXkMTKXxCb
         1dIq9mIFKb0rRLigUA5I1V+W9VL+87SBFsaQO8ZTHpO0T3lo77oZ3Ggk3+cIzhG/mFO+
         GkTA==
X-Gm-Message-State: AOAM532GBTrVWRDuKDOhr5DCtyNd0ysiMXsoBdjcqOSr/eDrD2HCZMBi
        QC632Y4GK4UGvtAmIVZPqac=
X-Google-Smtp-Source: ABdhPJwQF6kxtOdHkZZY5zH00GVqN+VUZnj/h5bj0QHmtTFdKAJjAoyDBvzsIqqukyqUCunWw/4Wkw==
X-Received: by 2002:a05:620a:806:: with SMTP id s6mr10562636qks.50.1616728227497;
        Thu, 25 Mar 2021 20:10:27 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.107])
        by smtp.gmail.com with ESMTPSA id i8sm4955240qtj.16.2021.03.25.20.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 20:10:26 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     gustavoars@kernel.org, ndesaulniers@google.com,
        unixbhaskar@gmail.com, nathan@kernel.org, colyli@suse.de,
        grandmaster@al2klimov.de, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] lib: xz/xz_dec_lzma2.c: Mundane typo fixes
Date:   Fri, 26 Mar 2021 08:38:11 +0530
Message-Id: <20210326030811.6992-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/dervied/derived/ ......two different sentences.
s/nore/more/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 lib/xz/xz_dec_lzma2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/xz/xz_dec_lzma2.c b/lib/xz/xz_dec_lzma2.c
index ca2603abee08..dca8c5c83ae8 100644
--- a/lib/xz/xz_dec_lzma2.c
+++ b/lib/xz/xz_dec_lzma2.c
@@ -147,8 +147,8 @@ struct lzma_dec {

 	/*
 	 * LZMA properties or related bit masks (number of literal
-	 * context bits, a mask dervied from the number of literal
-	 * position bits, and a mask dervied from the number
+	 * context bits, a mask derived from the number of literal
+	 * position bits, and a mask derived from the number
 	 * position bits)
 	 */
 	uint32_t lc;
@@ -761,7 +761,7 @@ static bool lzma_main(struct xz_dec_lzma2 *s)
 }

 /*
- * Reset the LZMA decoder and range decoder state. Dictionary is nore reset
+ * Reset the LZMA decoder and range decoder state. Dictionary is more reset
  * here, because LZMA state may be reset without resetting the dictionary.
  */
 static void lzma_reset(struct xz_dec_lzma2 *s)
--
2.26.2

