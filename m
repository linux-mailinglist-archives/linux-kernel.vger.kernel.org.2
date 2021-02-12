Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE714319848
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 03:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhBLCRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 21:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhBLCRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 21:17:43 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BCCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 18:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=r/OPg+xFtQLytfbJexyr61HkOhaw2sjKTK38fefNnfE=; b=OPW9YqjBVhPVeUZH3chQEPv3Ib
        Y/elI26oipgFEX+VklHy3/9ag1InJFsdpusv4B/xvtjyiICcPKovCxsqkKq4qHYJBvB741EQ7KB0u
        BkllX7ub6JPcyhUolkd7bXq51v7Lq7ZGZ2RX9GAydgMaM1M4AxlgDc0Wrruh2c7QHaUllKjMVffCj
        h9KaazBXQcHnRT6aX4mVxPb7DnM6SPq+H5UUg4wFqr3lHLPt/paYrZVha/PXf6SHmncPZ8XrMm5Y8
        kDXWTU3GjHPew+17zvXxwFfG0XZKxC4dKyfuIOu1ywPtmh39HwWwSzBm9VQBpcnQEOkLqkmr/1Kkw
        UxAXA8ng==;
Received: from [2601:1c0:6280:3f0::cf3b] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lAO0t-00020D-5k; Fri, 12 Feb 2021 02:16:55 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        uclinux-h8-devel@lists.sourceforge.jp,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] h8300: fix PREEMPTION build, TI_PRE_COUNT undefined
Date:   Thu, 11 Feb 2021 18:16:50 -0800
Message-Id: <20210212021650.22740-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a build error for undefined 'TI_PRE_COUNT' by adding it to
asm-offsets.c.

h8300-linux-ld: arch/h8300/kernel/entry.o: in function `resume_kernel':
(.text+0x29a): undefined reference to `TI_PRE_COUNT'

Fixes: df2078b8daa7 ("h8300: Low level entry")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: uclinux-h8-devel@lists.sourceforge.jp
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
Possibly due to some Kconfig changes related to PREEMPTION?
I suppose that CONFIG_PREEMPTION hasn't been used much on H8/300.

 arch/h8300/kernel/asm-offsets.c |    3 +++
 1 file changed, 3 insertions(+)

--- lnx-511-rc7.orig/arch/h8300/kernel/asm-offsets.c
+++ lnx-511-rc7/arch/h8300/kernel/asm-offsets.c
@@ -63,6 +63,9 @@ int main(void)
 	OFFSET(TI_FLAGS, thread_info, flags);
 	OFFSET(TI_CPU, thread_info, cpu);
 	OFFSET(TI_PRE, thread_info, preempt_count);
+#ifdef CONFIG_PREEMPTION
+	DEFINE(TI_PRE_COUNT, offsetof(struct thread_info, preempt_count));
+#endif
 
 	return 0;
 }
