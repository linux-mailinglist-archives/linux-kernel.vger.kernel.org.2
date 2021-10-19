Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C25C432D14
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 07:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbhJSFT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 01:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbhJSFTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:19:52 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ABCC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:17:40 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d9so9399507pfl.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E97yT8hy4yQjsz2siz81ZUOBpPmnI0CI1OEE09TeSxw=;
        b=pSTuv1nBD7aA6HBo4K3ES1BRFTFzfoV4odvOZ3VAyeWD11GEpz46koZHh0LaOShJrr
         TEzhJO3Ai1dA7Cz/mZPKYIychasyBupTwZRjFzeh1qF/wjksr8nJkiUApyZNKe19Tfw5
         9Dry3bRTTrhuCyxJ7torA8ow/Q8berMLr7FkwZCavJk6wjh0I+WJDtqSCnNxXOaV/63C
         7cRQmJZqFp97UE0AmsA2IhW3QCIEwWLngVN29L0q3fU+Vg3u/6edKk7jKOSR1gOgwl69
         kgLylwyNCWAqUUnuj5QOc3ILZyo8ugrWiHNTOVOvRTdPZ0j9dFrzkw0aK5SbAPAIY0vk
         B6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E97yT8hy4yQjsz2siz81ZUOBpPmnI0CI1OEE09TeSxw=;
        b=crWwcXd/t1X3KWr11K18AD4uF0OVSod58OdBjCoZkwqthFe7gfPtCkBQXXOBBlWmqa
         /aUjeJKoM9GuZDw2gVPehUz6Rl7U4ZY0vdxogegMnrey0m7SQ5JkiY1FmZTJyHcCK7cB
         1WANWFQuhGhcklbCI/IiSMFzPg/bgiTmS5Mvf7k9+39Unue+r5by3EUsFBcZBbsy8zof
         2h5HWGHiWQScOdp1IFhkk0b7enkm/O51Q0wL0XeSdM420OxWelyl9x++ya3vd6a/Qkm3
         4KK7L/ARgltzIobmimpqUwlctqa4bBQ9aobfR7EJ2IZMP3NBtHVVJRbH7/jr7H8TC/hN
         /1dw==
X-Gm-Message-State: AOAM530xNhfSOFRMvf1baP5YJW0PF4LfTfklP6qFLh3ii2vhh93B0hq1
        Mae7pgDRGTgPx5+B1YI1ZR0ZxVM1aTE=
X-Google-Smtp-Source: ABdhPJye9KzM3Lpwia8jWssfE/3vVkbWwswo5w8mSSvPcsjfr59h3BD9MkeDz5YlJ9qIc4TqY9dywQ==
X-Received: by 2002:a05:6a00:2181:b0:44c:f4bc:2f74 with SMTP id h1-20020a056a00218100b0044cf4bc2f74mr33061725pfi.68.1634620659820;
        Mon, 18 Oct 2021 22:17:39 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:4171:83c2:8384:24c5])
        by smtp.gmail.com with ESMTPSA id me12sm1168844pjb.27.2021.10.18.22.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 22:17:39 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 04/10] xtensa: don't use a12 in __xtensa_copy_user in call0 ABI
Date:   Mon, 18 Oct 2021 22:17:10 -0700
Message-Id: <20211019051716.4173-5-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211019051716.4173-1-jcmvbkbc@gmail.com>
References: <20211019051716.4173-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

a12 is callee-saved register in xtensa call0 ABI, so a function must not
change it. The main unaligned copy loop of __xtensa_copy_user uses all
low-numbered registers, so a register must be spilled to avoid using a12
as a loop counter.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/lib/usercopy.S | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/xtensa/lib/usercopy.S b/arch/xtensa/lib/usercopy.S
index a0aa4047f94a..16128c094c62 100644
--- a/arch/xtensa/lib/usercopy.S
+++ b/arch/xtensa/lib/usercopy.S
@@ -60,7 +60,12 @@
 	.text
 ENTRY(__xtensa_copy_user)
 
-	abi_entry_default
+#if !XCHAL_HAVE_LOOPS && defined(__XTENSA_CALL0_ABI__)
+#define STACK_SIZE 4
+#else
+#define STACK_SIZE 0
+#endif
+	abi_entry(STACK_SIZE)
 	# a2/ dst, a3/ src, a4/ len
 	mov	a5, a2		# copy dst so that a2 is return value
 	mov	a11, a4		# preserve original len for error case
@@ -75,7 +80,7 @@ ENTRY(__xtensa_copy_user)
 	__ssa8	a3		# set shift amount from byte offset
 	bnez	a4, .Lsrcunaligned
 	movi	a2, 0		# return success for len==0
-	abi_ret_default
+	abi_ret(STACK_SIZE)
 
 /*
  * Destination is unaligned
@@ -127,7 +132,7 @@ EX(10f)	s8i	a6, a5, 0
 #endif /* !XCHAL_HAVE_LOOPS */
 .Lbytecopydone:
 	movi	a2, 0		# return success for len bytes copied
-	abi_ret_default
+	abi_ret(STACK_SIZE)
 
 /*
  * Destination and source are word-aligned.
@@ -187,7 +192,7 @@ EX(10f)	l8ui	a6, a3,  0
 EX(10f)	s8i	a6, a5,  0
 .L5:
 	movi	a2, 0		# return success for len bytes copied
-	abi_ret_default
+	abi_ret(STACK_SIZE)
 
 /*
  * Destination is aligned, Source is unaligned
@@ -205,8 +210,14 @@ EX(10f)	l32i	a6, a3, 0	# load first word
 	loopnez	a7, .Loop2done
 #else /* !XCHAL_HAVE_LOOPS */
 	beqz	a7, .Loop2done
+#if defined(__XTENSA_CALL0_ABI__)
+	s32i	a10, a1, 0
+	slli	a10, a7, 4
+	add	a10, a10, a3	# a10 = end of last 16B source chunk
+#else
 	slli	a12, a7, 4
 	add	a12, a12, a3	# a12 = end of last 16B source chunk
+#endif
 #endif /* !XCHAL_HAVE_LOOPS */
 .Loop2:
 EX(10f)	l32i	a7, a3,  4
@@ -224,7 +235,12 @@ EX(10f)	s32i	a8, a5,  8
 EX(10f)	s32i	a9, a5, 12
 	addi	a5, a5, 16
 #if !XCHAL_HAVE_LOOPS
+#if defined(__XTENSA_CALL0_ABI__)
+	blt	a3, a10, .Loop2
+	l32i	a10, a1, 0
+#else
 	blt	a3, a12, .Loop2
+#endif
 #endif /* !XCHAL_HAVE_LOOPS */
 .Loop2done:
 	bbci.l	a4, 3, .L12
@@ -264,7 +280,7 @@ EX(10f)	l8ui	a6, a3,  0
 EX(10f)	s8i	a6, a5,  0
 .L15:
 	movi	a2, 0		# return success for len bytes copied
-	abi_ret_default
+	abi_ret(STACK_SIZE)
 
 ENDPROC(__xtensa_copy_user)
 
@@ -281,4 +297,4 @@ ENDPROC(__xtensa_copy_user)
 10:
 	sub	a2, a5, a2	/* a2 <-- bytes copied */
 	sub	a2, a11, a2	/* a2 <-- bytes not copied */
-	abi_ret_default
+	abi_ret(STACK_SIZE)
-- 
2.20.1

