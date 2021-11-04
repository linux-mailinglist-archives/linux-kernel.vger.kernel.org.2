Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4124457D2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhKDREG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhKDRDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:03:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75ADC06120D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=cl0tTr1i6LZXCZBiY8SLlEZQZtEI/Rbt0jdSb7NTDn8=; b=Yr7ItxAMPtol6yjMHYAPqO1QYn
        3I1yzoTJLiuagHD7lpMpxziZ0QTWVz/kwztnSwTERW682C8ReoEj1RKenIOUsZJnDABOLO+aLg75d
        u4nW5bnHTSQsP6VJdhgO8PbH7+SC44ihDMGw+WaXvI5GVlWAvJYpt/5E86jECCCT+vQ87p2BPVNy/
        17dVDZOjvAlQT9RgdvAGOIsLDEYRS25i7L515ZifEWzzxq5T7RxgnxBCKKq5jEeGtoB6+NS0Spj+i
        4UNpJRNT2vBlxDgswuVo9YnlyHfjgp9qszn1UFDxZ0nbHejyehSj4V+JtC8aVch15WARi+S4LtOA6
        EPKxMlbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mig2V-0060FG-LQ; Thu, 04 Nov 2021 16:57:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 30984300385;
        Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 104A42DD49FB2; Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Message-ID: <20211104165524.565017880@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Nov 2021 17:47:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [RFC][PATCH 01/22] bitfield.h: Fix "type of reg too small for mask" test
References: <20211104164729.226550532@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test: 'mask > (typeof(_reg))~0ull' only works correctly when both
sides are unsigned, consider:

 - 0xff000000 vs (int)~0ull
 - 0x000000ff vs (int)~0ull

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


