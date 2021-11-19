Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C43456E64
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 12:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhKSLks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 06:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbhKSLkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 06:40:22 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096F2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:21 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d5so17692088wrc.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cCB+CGh5oYNxi5u1BhTtFZ4z5CoOHOZ98bUz9Fk12NE=;
        b=hmVdzv/nVnYfGx3Q13MWJNT+DSZvQUqHYg9hOA1eAgFAZBR9/K4K912SY97UTlC2cP
         CQN60mj+B7Klp6GJkOVnCxqqsNy8PpS3Liebws7IBXd/fY4BFTrIvnPDC0gswPZPHQmI
         EzhS9Zxq2YXqhH5EhlGkOkr+rmP+znEtYYp8SpZeb+pg2RDzqOwJao9QEncsM8d7WDOO
         lkq0m4AXFAQeKV4RMbtp7VTLCiTJyaDm9YXlg4z/1GsuapfF55xDV5Yoo+KA1FPcqWQU
         FJ7c5FlBO+rvdQxXw88lX6Gqywz+428FG4DGZVhRYAs0HaRcAzpzBDJnl7TOJmR0x+Pu
         o0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cCB+CGh5oYNxi5u1BhTtFZ4z5CoOHOZ98bUz9Fk12NE=;
        b=FuxB4qu5Lup01oKirJNH0Qlf6rtdUQLQdAc22HQ58TaL8nJdqibfi7R9EgsDEXkNma
         vS4tnODyGTc6w8zGPdhTx8tx7sAolNkad7XScL1mtwgLu/uJ77/qH2/+dw3zMhoFC0q8
         IP1w5fSoxfu53RLx7qUfuB9wbsbQb2PxomnBchn0hGyAAnmCbv0Fcv0z0IgTJpQzqvNG
         wmAZuFiY6kM0Id7a9wjyfR1yhe1XIfDOwTPFLqgJ4LlQ6pezHDWMs1CVWR7oWZpMjutZ
         LdVN+VdjTAJUaYkprcoGuxaGhq/qsovG25YksmlKfE70Vx3cx7WJyA1OfdgzFlJT3UO7
         scmQ==
X-Gm-Message-State: AOAM532JNnHi6jL4uEd8Iai59xK5HSW4u7e0o0nPe5AmP/hlaYdY8Oz7
        Xf2PXE6aTg4/TnzZwcMDamCkqJJ9qO3ObA==
X-Google-Smtp-Source: ABdhPJzV5zW8iBWQ5JVZmFRYiAZkIkZJy3tm6yxMoCWzzwv63EV+neWmiWYvIDoVBGUsuAxA5+QReg==
X-Received: by 2002:adf:e8c1:: with SMTP id k1mr6441764wrn.257.1637321839603;
        Fri, 19 Nov 2021 03:37:19 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id f15sm3361260wmg.30.2021.11.19.03.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 03:37:19 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>
Subject: [PATCH 11/17] linux/container_of.h: Cosmetic
Date:   Fri, 19 Nov 2021 12:36:39 +0100
Message-Id: <20211119113644.1600-12-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119113644.1600-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Place braces more similar to where a function would have them.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/linux/container_of.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index addd3993fa60..2100adb9d109 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -15,12 +15,16 @@
  * @member:	the name of the member within the struct.
  *
  */
-#define container_of(ptr, type, member) ({				\
+#define container_of(ptr, type, member)  (				\
+{									\
 	void *__mptr = (void *)(ptr);					\
+									\
 	static_assert(__same_type(*(ptr), memberof(type, member)) ||	\
 		      __same_type(*(ptr), void),			\
 		      "pointer type mismatch in container_of()");	\
-	((type *)(__mptr - offsetof(type, member))); })
+	((type *)(__mptr - offsetof(type, member)));			\
+}									\
+)
 
 /**
  * container_of_safe - cast a member of a structure out to the containing structure
-- 
2.33.1

