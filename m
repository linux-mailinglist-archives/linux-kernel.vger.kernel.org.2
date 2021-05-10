Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564AB378EF1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242610AbhEJNZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349636AbhEJNUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 09:20:49 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908CAC061760
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 06:19:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d4so16592614wru.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 06:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z3j46dkNfpVyHXhEKxl5rI2FMjVZa1cAXULGLqC+Kpo=;
        b=bFTFNdPfvc9aGzbn6rnAzcveg/LTqRbIHFhriG9LoQ516Y5lOk2v0gqTeHvI7ECoVK
         NAa5C/A8LYkG/hDXPKoK8NfVincvDxGrVXieQULMa5Qqi5G5HiEzGgdzcxWSZtR0mYEp
         dlgtxYTn7+SfuNxaluwFS6g7YomZVD4Qvl1uVTzqa9IoS15bLZS/iDYXpChQP3Hnbsjk
         Q79j4hngLst8CSG/6VUgRKEbK1PFJh9KsWIHLHoSlU+Ixs9ErcVy84xPcdvV4uoXv7x4
         ifrAdiUeJTVVl7aAs//hCjKH2bVkx93nb5MN7O/ChbBud5hx+CA8r50sVWyj3pcZzyYD
         MSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z3j46dkNfpVyHXhEKxl5rI2FMjVZa1cAXULGLqC+Kpo=;
        b=nqD8MR4uwW3TCJCdN0sk9YpRBfJGKENWXn5vc2xNGP4iSfZVvTbzhsb+YEzpVS3/sE
         EhSNU0kRq0Jte+hVCU8S8i7bKmnCNCvdT69O3N1d+9FeWaSN3xTkkVwt/ZIBc9JFS26X
         4KEIVkmjWxlmgjca6iFXuWPo9pBbmS0tuoAYDcVaYSjf91LZ1tF40f+d/3vrGoyOKXCY
         a0N10UiWoiEnwsWvMF8u6IEm9qYipe4I3UID1Xf/V+QonZ2he8EgxSefell5D55r0LLv
         Rqe6JomTtYT9MiIAjYPvzaS5hBs5OILEZQl2DNhq0ZmQD5lkHcdDc35woMw38m5Xi6rA
         qj0Q==
X-Gm-Message-State: AOAM5307RpCndh5qN4qSfhgWGY6+lLo7stCTOSEIlHChhyYIw6L0K2n7
        c3GvscEneZtFtx2EISajzSjPRkZfIyXyjg==
X-Google-Smtp-Source: ABdhPJytFRrADQ4Il0+7UdW5CITzX7+le5CnVpbqQKsQYSgs7Hro1gib+feGHL8mDDOeMj3s9oHH+Q==
X-Received: by 2002:adf:ab1d:: with SMTP id q29mr30052832wrc.208.1620652779345;
        Mon, 10 May 2021 06:19:39 -0700 (PDT)
Received: from agape ([5.171.73.3])
        by smtp.gmail.com with ESMTPSA id h15sm1751427wmq.4.2021.05.10.06.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 06:19:39 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] staging: rtl8723bs: remove unneeded comments to silence 'line too long' warning
Date:   Mon, 10 May 2021 15:19:33 +0200
Message-Id: <bb479715e3603ab78863576783dbbf49c5f6f703.1620652505.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1620652505.git.fabioaiuto83@gmail.com>
References: <cover.1620652505.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unneeded comments to fix the following post commit hook
checkpatch warnings:

WARNING: line length of 110 exceeds 100 columns
115: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:510:
+					*((__le32 *)crc)
 = ~crc32_le(~0, payload, length);/* modified by Amy*/

WARNING: line length of 110 exceeds 100 columns
124: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:518:
+					*((__le32 *)crc)
 = ~crc32_le(~0, payload, length);/* modified by Amy*/

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index bee1b2e2504e..5ff8926c1865 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -507,7 +507,7 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 				if ((curfragnum+1) == pattrib->nr_frags) {	/* 4 the last fragment */
 					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-					*((__le32 *)crc) = ~crc32_le(~0, payload, length);/* modified by Amy*/
+					*((__le32 *)crc) = ~crc32_le(~0, payload, length);
 
 					arc4_setkey(&mycontext, rc4key, 16);
 					arc4_crypt(&mycontext, payload, payload, length);
@@ -515,7 +515,8 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 				} else {
 					length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-					*((__le32 *)crc) = ~crc32_le(~0, payload, length);/* modified by Amy*/
+					*((__le32 *)crc) = ~crc32_le(~0, payload, length);
+
 					arc4_setkey(&mycontext, rc4key, 16);
 					arc4_crypt(&mycontext, payload, payload, length);
 					arc4_crypt(&mycontext, payload + length, crc, 4);
-- 
2.20.1

