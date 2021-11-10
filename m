Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BD944BE70
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhKJKUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhKJKTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:19:15 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF92C0613F5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=GdsP8nCoiSMO77whYuB4S6aiqgkONHkLoEBnDo4iUg8=; b=qNkwFpO54pLvApXhJFypP7hJKc
        20NNzJCbj+ymYtVoJQZkmTFoEwiLuR6bc+MR68okOgb0xHybYhjAXJrnRoGpE9Rajc3zleGD8IgDq
        qNYNOUvHUXCLZQ3EKcx0C6y7bIvajPmdOeJPau/06pxHISbFG67s9BY0E/IBQ0b72sQ7wKbL8Kmbs
        Ac+TEBW98OL5Wa9QjWSNqqaFemBIa4SZXXexMCjkRyzUd/d0A8XrB1UeqWqeP/kZ8sbxd3U2AnMGe
        2P2qIr1aB/5zISI9S3iIk06nnxPdrObwpwrm/En/q+paQgxbkWCwqO4Xb1M+X0eG/N7dtCqbqJrM7
        0spIJooA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkkeG-00FFpb-99; Wed, 10 Nov 2021 10:16:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76EB1300366;
        Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5D0F1202F85CB; Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Message-ID: <20211110101324.950210584@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Nov 2021 11:01:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz,
        kuba@kernel.org
Subject: [PATCH v2 01/23] bitfield.h: Fix "type of reg too small for mask" test
References: <20211110100102.250793167@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test: 'mask > (typeof(_reg))~0ull' only works correctly when both
sides are unsigned, consider:

 - 0xff000000 vs (int)~0ull
 - 0x000000ff vs (int)~0ull

Cc: kuba@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/bitfield.h |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -41,6 +41,22 @@
 
 #define __bf_shf(x) (__builtin_ffsll(x) - 1)
 
+#define __scalar_type_to_unsigned_cases(type)				\
+		unsigned type:	(unsigned type)0,			\
+		signed type:	(unsigned type)0
+
+#define __unsigned_scalar_typeof(x) typeof(				\
+		_Generic((x),						\
+			char:	(unsigned char)0,			\
+			__scalar_type_to_unsigned_cases(char),		\
+			__scalar_type_to_unsigned_cases(short),		\
+			__scalar_type_to_unsigned_cases(int),		\
+			__scalar_type_to_unsigned_cases(long),		\
+			__scalar_type_to_unsigned_cases(long long),	\
+			default: (x)))
+
+#define __bf_cast_unsigned(type, x)	((__unsigned_scalar_typeof(type))(x))
+
 #define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)			\
 	({								\
 		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
@@ -49,7 +65,8 @@
 		BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
 				 ~((_mask) >> __bf_shf(_mask)) & (_val) : 0, \
 				 _pfx "value too large for the field"); \
-		BUILD_BUG_ON_MSG((_mask) > (typeof(_reg))~0ull,		\
+		BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >	\
+				 __bf_cast_unsigned(_reg, ~0ull),	\
 				 _pfx "type of reg too small for mask"); \
 		__BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +			\
 					      (1ULL << __bf_shf(_mask))); \


