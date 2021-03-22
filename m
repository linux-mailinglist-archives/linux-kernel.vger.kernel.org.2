Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA84343FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCVLdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhCVLdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:33:08 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CC5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 04:33:07 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id o5so10063301qkb.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 04:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OPF2bQHgVyJLJFI/awpdMJ0h6oH5lb8a5QcmD+rn2sk=;
        b=g7W0bjQ4et0F3+fWqOnm1Td1YLTPIorlvSq2a0H9lebFXW5QCmEDb6S6TbXRd5v/M0
         rk4DvpFuDriJ5HYQCNZKf2DiYlCj6dDDqOKiV3wfaVbgvJbV9zEklYP4AYOGh8rnitK3
         3/8iufKDS355PXbipeFJrkxT2Mh6wdvwyspGjoWMM6PrVzxC3AT73e1VVzEPqXkwuVX6
         oE0OcRFFiSTlLHnx7k6SkjmNzTB2H3Hn3RFEx3wf0eiAQ0RUWsnI5QRMfkioDG9bI/u6
         zWTsHhbYPb/EDRMOPtLW96pmz/jaVIgzjQnVIvP8oHVS2R6OeqfP8gUT9jLP6JvNN6yH
         fYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OPF2bQHgVyJLJFI/awpdMJ0h6oH5lb8a5QcmD+rn2sk=;
        b=CB1mu7kuo64VZzvg46HNIYpcAb4DuOI5XVuYuOt6AKKHAvM5vDztoo3zP49KJNpGmX
         0BKXKlgy2sQN1iZXW4AI+/q9zfAgYejcxzJq7qZ+Y2USojX1VN5wjop/mmgk6gk0CI+b
         7aw9wZ5zqkCrxcu6Iz6l+UKYZ97EU+UHWCybGaBvHIi1qtc/f4krKJo6LLC7vrr6Ad0f
         tZtYuDyC0ocx0PtexMDUv/H1lf/krRUex80pXhd/urbvJMY5B7d1fHxFE4wwEtoURLFV
         3aLOKEewfDZhLLKrwHb5ftk6eTtmVVhJ2dSEuQUfJW1Uy5l4pS3twVbQlp1+I9CIfSMt
         D4Zg==
X-Gm-Message-State: AOAM531aF//alBbHVmuQvD+gMA9ruyzLoJBeopkhk6vn1V+tdg4c1oAr
        By2ZsaDBHs7bH0RuXCu7WhHn0g+gg2xOCdUV
X-Google-Smtp-Source: ABdhPJweKkhkRm201awkQPyNgwLXmDUlX+n8laSHEpcJvaNBnEckFy6A5g4SgZgi1/Ckfp0K2yHUzg==
X-Received: by 2002:a05:620a:3cb:: with SMTP id r11mr10411925qkm.148.1616412787096;
        Mon, 22 Mar 2021 04:33:07 -0700 (PDT)
Received: from localhost.localdomain ([143.244.44.200])
        by smtp.gmail.com with ESMTPSA id h7sm10227746qkk.41.2021.03.22.04.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:33:06 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        unixbhaskar@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] powerpc/asm: Fix a typo
Date:   Mon, 22 Mar 2021 17:02:54 +0530
Message-Id: <20210322113254.2081445-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/poiner/pointer/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/powerpc/include/asm/cpm2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/cpm2.h b/arch/powerpc/include/asm/cpm2.h
index 2211b934ecb4..bda45788cfcc 100644
--- a/arch/powerpc/include/asm/cpm2.h
+++ b/arch/powerpc/include/asm/cpm2.h
@@ -594,7 +594,7 @@ typedef struct fcc_enet {
 	uint	fen_p256c;	/* Total packets 256 < bytes <= 511 */
 	uint	fen_p512c;	/* Total packets 512 < bytes <= 1023 */
 	uint	fen_p1024c;	/* Total packets 1024 < bytes <= 1518 */
-	uint	fen_cambuf;	/* Internal CAM buffer poiner */
+	uint	fen_cambuf;	/* Internal CAM buffer pointer */
 	ushort	fen_rfthr;	/* Received frames threshold */
 	ushort	fen_rfcnt;	/* Received frames count */
 } fcc_enet_t;
--
2.31.0

