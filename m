Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30951432D13
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 07:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbhJSFTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 01:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbhJSFTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:19:51 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA19C061745
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:17:39 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ez7-20020a17090ae14700b001a132a1679bso1135275pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iTWeQO2Mdg6bDDkAU7yT+BrO4BSg+e1FR9ssbbVUoBA=;
        b=pZJlJoxn4e85Q4ATiX77se+8J/cyT9t1+A1D90IJI2YmZ49Nn2AhAJ+gL8E5hZa6LA
         EY/mVj+YQ+n5NjSTaFNReBrToV0uS3mOEW8DxLtWHxoCQpCgdg0PiRlxUraGbMSwP9+3
         /crvv+evNKZZTkc8Fu9yj0CoF04Mmk5A58pLwKEThRKtG8CbjeL4/QLwRYNi5CfI5HtT
         LFuRc893rRfN2GKTtsy3w8FyiJtUlJhbrDm0Y+UeJV3wjzfq9XuB+kqo8wKIpenfR9Sz
         axlbKhMbmN30x/LXIycXieIyzK9X374lCwSNJ+aIkKOLjhP4a+cXUbO+FX5SLpghe5Ff
         3u0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iTWeQO2Mdg6bDDkAU7yT+BrO4BSg+e1FR9ssbbVUoBA=;
        b=O8Vcdt+jVN02kA45gnzNTxPHUpbEdtCVcVUG6rCijA/LcDutRQq54VEF800Au/Akln
         GmVJMhUbb3KsAahekiSY44A+hVpm/NvIRXViSN2syNnGRG0/JWNfHOA0s/G/HSbw8bQE
         oZdNdrgKWtDA4oxLHIhdi/MMbw/T/0M0eOUjjZsdhxhpO5N6CZtgukTBSwb3nCeZWs2+
         c3h2amxkc6SbBzgcq5aMTWBO2ekkQbWo4IUKFsJ6HCfOUINjkJfLyHc6NTAy90mlAMce
         mp9x+uaTUiima+xBGi1kWKRSPMOx3jAT3kr69B7shAYxzUO3W3X+Xd0BY1LloByHg2Q6
         ZTiQ==
X-Gm-Message-State: AOAM531zsh+7o8u1IfrPaNibF4ohQwG5cFKeSPCrbnOAGYTQGh7AsF0C
        mmp97ghePiP5c1m6/GHrp3LF46mllm0=
X-Google-Smtp-Source: ABdhPJww0j/UyodiSmkqcRrADEa+MCk6ersmucimEp143SVSGxEQOzfFjikvcGVwQ+NIPXgCa3K/sw==
X-Received: by 2002:a17:90a:9297:: with SMTP id n23mr4016635pjo.199.1634620658694;
        Mon, 18 Oct 2021 22:17:38 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:4171:83c2:8384:24c5])
        by smtp.gmail.com with ESMTPSA id me12sm1168844pjb.27.2021.10.18.22.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 22:17:38 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 03/10] xtensa: don't use a12 in strncpy_user
Date:   Mon, 18 Oct 2021 22:17:09 -0700
Message-Id: <20211019051716.4173-4-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211019051716.4173-1-jcmvbkbc@gmail.com>
References: <20211019051716.4173-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

a12 is callee-saved register in xtensa call0 ABI, so a function must not
change it. a10 is not used in this function at all, use it instead of
a12 to avoid saving/restoring it.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/lib/strncpy_user.S | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/xtensa/lib/strncpy_user.S b/arch/xtensa/lib/strncpy_user.S
index 4faf46fe3f38..0731912227d3 100644
--- a/arch/xtensa/lib/strncpy_user.S
+++ b/arch/xtensa/lib/strncpy_user.S
@@ -45,7 +45,6 @@
 #   a9/ tmp
 #   a10/ tmp
 #   a11/ dst
-#   a12/ tmp
 
 .text
 ENTRY(__strncpy_user)
@@ -61,7 +60,7 @@ ENTRY(__strncpy_user)
 	bbsi.l	a3, 0, .Lsrc1mod2 # if only  8-bit aligned
 	bbsi.l	a3, 1, .Lsrc2mod4 # if only 16-bit aligned
 .Lsrcaligned:	# return here when src is word-aligned
-	srli	a12, a4, 2	# number of loop iterations with 4B per loop
+	srli	a10, a4, 2	# number of loop iterations with 4B per loop
 	movi	a9, 3
 	bnone	a11, a9, .Laligned
 	j	.Ldstunaligned
@@ -102,11 +101,11 @@ EX(10f)	s8i	a9, a11, 0		# store byte 0
 	.byte	0		# (0 mod 4 alignment for LBEG)
 .Laligned:
 #if XCHAL_HAVE_LOOPS
-	loopnez	a12, .Loop1done
+	loopnez	a10, .Loop1done
 #else
-	beqz	a12, .Loop1done
-	slli	a12, a12, 2
-	add	a12, a12, a11	# a12 = end of last 4B chunck
+	beqz	a10, .Loop1done
+	slli	a10, a10, 2
+	add	a10, a10, a11	# a10 = end of last 4B chunck
 #endif
 .Loop1:
 EX(11f)	l32i	a9, a3, 0		# get word from src
@@ -118,7 +117,7 @@ EX(10f)	s32i	a9, a11, 0		# store word to dst
 	bnone	a9, a8, .Lz3		# if byte 3 is zero
 	addi	a11, a11, 4		# advance dst pointer
 #if !XCHAL_HAVE_LOOPS
-	blt	a11, a12, .Loop1
+	blt	a11, a10, .Loop1
 #endif
 
 .Loop1done:
@@ -185,7 +184,7 @@ EX(10f)	s8i	a9, a11, 2
 	loopnez	a4, .Lunalignedend
 #else
 	beqz	a4, .Lunalignedend
-	add	a12, a11, a4		# a12 = ending address
+	add	a10, a11, a4		# a10 = ending address
 #endif /* XCHAL_HAVE_LOOPS */
 .Lnextbyte:
 EX(11f)	l8ui	a9, a3, 0
@@ -194,7 +193,7 @@ EX(10f)	s8i	a9, a11, 0
 	beqz	a9, .Lunalignedend
 	addi	a11, a11, 1
 #if !XCHAL_HAVE_LOOPS
-	blt	a11, a12, .Lnextbyte
+	blt	a11, a10, .Lnextbyte
 #endif
 
 .Lunalignedend:
-- 
2.20.1

