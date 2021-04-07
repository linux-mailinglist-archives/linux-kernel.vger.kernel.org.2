Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289A53560F9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347909AbhDGBwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347820AbhDGBvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:50 -0400
Received: from server.lespinasse.org (unknown [IPv6:2602:303:fcdc:ce10::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD68C061761
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 18:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759902; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=45X0hICb7YyLurpFubxOZ+gBL34g/MPyB7oW/aDWSiM=;
 b=Ezxxe9KDQsCFhUHAu9I8tXq3tzT+ETWkukiiTwYTUJy0+mEiULNUYHD1E3OGsCJ2WVgK+
 6sVgt4/DR/scN5rDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759902; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=45X0hICb7YyLurpFubxOZ+gBL34g/MPyB7oW/aDWSiM=;
 b=OIBfjJ1bYm37SwxCxTZxWBm6/JHot+77xHwF5V/8sYbQYkkLwxhE3KbqcmCsOgfilCuOe
 kPpyZrn7Wf5hzU3ilIC1gXGABhNrY4ctFg9vLpbXQhB1MQ3fIfDvSVlFjbQDpnshhEhCE2W
 jSgP0RqvYexT8jbDex/isE6RL/ElD3hYo1qqrkUe4YxlrI17K1OC3DDgjSOe4QxyDePMiNS
 ByZf0vq9GK578fKtRJ3Q9uSgRs1RMCV7tyWz+2ukebX+vT6OkKeM3iUxIQtur5QmxepoA+U
 J97XdXAFSjABk9diVgwmNmv0b2H4KQq+SRvewPy4ziSva9rDbfiYKXbB6KLw==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 850A616023A;
        Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 773DB19F31D; Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [RFC PATCH 05/37] mm: introduce CONFIG_SPECULATIVE_PAGE_FAULT
Date:   Tue,  6 Apr 2021 18:44:30 -0700
Message-Id: <20210407014502.24091-6-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This configuration variable will be used to build the code needed to
handle speculative page fault.

This is enabled by default on supported architectures with SMP and MMU set.

The architecture support is needed since the speculative page fault handler
is called from the architecture's page faulting code, and some code has to
be added there to try speculative fault handling first.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/Kconfig | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 24c045b24b95..322bda319dea 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -872,4 +872,26 @@ config MAPPING_DIRTY_HELPERS
 config KMAP_LOCAL
 	bool
 
+config ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
+       def_bool n
+
+config SPECULATIVE_PAGE_FAULT
+	bool "Speculative page faults"
+	default y
+	depends on ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT && MMU && SMP
+	help
+	  Try to handle user space page faults without holding the mmap lock.
+
+	  Instead of blocking writers through the use of mmap lock,
+	  the page fault handler merely verifies, at the end of the page
+	  fault, that no writers have been running concurrently with it.
+
+	  In high concurrency situations, the speculative fault handler
+	  gains a throughput advantage by avoiding having to update the
+	  mmap lock reader count.
+
+	  If the check fails due to a concurrent writer, or due to hitting
+	  an unsupported case, the fault handler falls back to classical
+	  processing using the mmap read lock.
+
 endmenu
-- 
2.20.1

