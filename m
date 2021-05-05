Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAD837340B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 05:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhEEDzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 23:55:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42694 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231435AbhEEDzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 23:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620186892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uUzxGHvyPHFNdznBqh/TL7dRBqJ6RanpupJOpSSJakw=;
        b=NEXZBLJlx/FxoZlpnMtC6Cn1+ojRd7nOZfKHys6jUpq0YqOeJNd5H8pZoZ54Xn4nZz675y
        3ONrvOcAOVcGhRTn/h1zqufqCMnBbSLZnsMho7h5FZ3j5e9mYpaUMXowQAMsFX1BVCW91T
        6BbSRJZsfYiTBfztbDCuDYkzvtEQqio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-tCjB_KYfMCuq8D0X0Suayw-1; Tue, 04 May 2021 23:54:51 -0400
X-MC-Unique: tCjB_KYfMCuq8D0X0Suayw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F008107ACCA;
        Wed,  5 May 2021 03:54:49 +0000 (UTC)
Received: from treble.redhat.com (ovpn-115-93.rdu2.redhat.com [10.10.115.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D3EE10190A7;
        Wed,  5 May 2021 03:54:47 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH v4 2/4] uaccess: Fix __user annotations for copy_mc_to_user()
Date:   Tue,  4 May 2021 22:54:30 -0500
Message-Id: <5edbdb1ae63b0e3771fdf1a46ce1cb517f091b1a.1620186182.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1620186182.git.jpoimboe@redhat.com>
References: <cover.1620186182.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'dst' field is a user pointer, so annotate it as such.  This is
consistent with what powerpc is already doing for this interface.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/uaccess.h | 2 +-
 arch/x86/lib/copy_mc.c         | 8 ++++----
 lib/iov_iter.c                 | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index c9fa7be3df82..fb75657b5e56 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -445,7 +445,7 @@ copy_mc_to_kernel(void *to, const void *from, unsigned len);
 #define copy_mc_to_kernel copy_mc_to_kernel
 
 unsigned long __must_check
-copy_mc_to_user(void *to, const void *from, unsigned len);
+copy_mc_to_user(void __user *to, const void *from, unsigned len);
 #endif
 
 /*
diff --git a/arch/x86/lib/copy_mc.c b/arch/x86/lib/copy_mc.c
index 80efd45a7761..6e8b7e600def 100644
--- a/arch/x86/lib/copy_mc.c
+++ b/arch/x86/lib/copy_mc.c
@@ -70,23 +70,23 @@ unsigned long __must_check copy_mc_to_kernel(void *dst, const void *src, unsigne
 }
 EXPORT_SYMBOL_GPL(copy_mc_to_kernel);
 
-unsigned long __must_check copy_mc_to_user(void *dst, const void *src, unsigned len)
+unsigned long __must_check copy_mc_to_user(void __user *dst, const void *src, unsigned len)
 {
 	unsigned long ret;
 
 	if (copy_mc_fragile_enabled) {
 		__uaccess_begin();
-		ret = copy_mc_fragile(dst, src, len);
+		ret = copy_mc_fragile((__force void *)dst, src, len);
 		__uaccess_end();
 		return ret;
 	}
 
 	if (static_cpu_has(X86_FEATURE_ERMS)) {
 		__uaccess_begin();
-		ret = copy_mc_enhanced_fast_string(dst, src, len);
+		ret = copy_mc_enhanced_fast_string((__force void *)dst, src, len);
 		__uaccess_end();
 		return ret;
 	}
 
-	return copy_user_generic(dst, src, len);
+	return copy_user_generic((__force void *)dst, src, len);
 }
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 61228a6c69f8..26f87115133f 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -679,7 +679,7 @@ static int copyout_mc(void __user *to, const void *from, size_t n)
 {
 	if (access_ok(to, n)) {
 		instrument_copy_to_user(to, from, n);
-		n = copy_mc_to_user((__force void *) to, from, n);
+		n = copy_mc_to_user(to, from, n);
 	}
 	return n;
 }
-- 
2.31.1

