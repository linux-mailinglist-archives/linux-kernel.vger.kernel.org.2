Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E8937340C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 05:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhEEDzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 23:55:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36174 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231508AbhEEDzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 23:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620186897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Qv9322Ly+FYXUR3q0hY09kc7Ko7kX6mN8/7VNeBtEc=;
        b=Ya1XSilGagzeukZrDXoy0n59NjLJk/4A32dsnE9fgIDQLVaIly0AznHrQa/nv7djJuObw2
        sB0ulqt9D2YU2F8kuiSWcqe+DPLL3BMvOONOgoETmZepR9b+SfcgAQIyg979P5kuaCfEtz
        BOh1cGyadGrTEmj/2B3EoI/DJPWRsYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347--hSfZWRzNS2kt7EzuuTpAw-1; Tue, 04 May 2021 23:54:55 -0400
X-MC-Unique: -hSfZWRzNS2kt7EzuuTpAw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8EF810066E6;
        Wed,  5 May 2021 03:54:53 +0000 (UTC)
Received: from treble.redhat.com (ovpn-115-93.rdu2.redhat.com [10.10.115.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E54D71002D71;
        Wed,  5 May 2021 03:54:51 +0000 (UTC)
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
Subject: [PATCH v4 4/4] x86/nospec: Remove barrier_nospec()
Date:   Tue,  4 May 2021 22:54:32 -0500
Message-Id: <3ea39399a7f5272c2f89fd7ad1386c7abdf31eb5.1620186182.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1620186182.git.jpoimboe@redhat.com>
References: <cover.1620186182.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The barrier_nospec() macro is no longer used.  Its uses have been
replaced with address and array index masking.  Remove it.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/barrier.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 4819d5e5a335..88f692d4f4ec 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -48,9 +48,6 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 /* Override the default implementation from linux/nospec.h. */
 #define array_index_mask_nospec array_index_mask_nospec
 
-/* Prevent speculative execution past this barrier. */
-#define barrier_nospec() alternative("", "lfence", X86_FEATURE_LFENCE_RDTSC)
-
 #define dma_rmb()	barrier()
 #define dma_wmb()	barrier()
 
-- 
2.31.1

