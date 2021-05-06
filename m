Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E22375BE2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbhEFTnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235629AbhEFTnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:43:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB749C061763
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 12:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=g7dkO9TuF0cTYNXw+BtCh7Y6t0+pMDvcBKxQshzeElw=; b=gkcMZnkEun9Iq6ezaA0tbIN3CC
        ee85uuCcUhUR/ZYERHgW6O3p5kKIYx6xRLVMnicv4u3Keee+GU3ItsuccWZ7vTtiPDkiYqgYWlIoM
        LXFqN9gqnffwV/CNN6llGzYE8g9GR7DRNKjTb16xqJaKCdQyAq3JuOJ/HTVGlSxndnmUPLCRDyXnt
        vq1YQkfEttnrqs+1sS3S4GrilSrbHGarPkMK2XZT5p1RTj0TFfgPn8y+aZnMCW/6qbioaSLHuYijy
        mrhKYJHH4ObgfhdkeejcX73q8bbRJ8/tO/MvanCkuJ8AZK76yqrzsMCqSiYM/CyRZLjnXccxCE6SC
        fsjBpitA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lejtQ-005BLM-6a; Thu, 06 May 2021 19:42:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B97F230034A;
        Thu,  6 May 2021 21:42:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A1FDC20B96F84; Thu,  6 May 2021 21:42:38 +0200 (CEST)
Message-ID: <20210506194157.516200011@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 06 May 2021 21:33:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 02/13] x86,objtool: Dont exclude arch/x86/realmode/
References: <20210506193352.719596001@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specifically, init.c uses jump_labels.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/realmode/Makefile |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/x86/realmode/Makefile
+++ b/arch/x86/realmode/Makefile
@@ -10,7 +10,6 @@
 # Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
 KCSAN_SANITIZE			:= n
-OBJECT_FILES_NON_STANDARD	:= y
 
 subdir- := rm
 


