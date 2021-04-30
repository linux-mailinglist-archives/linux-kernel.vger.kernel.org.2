Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD1A370183
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhD3Txo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:53:44 -0400
Received: from server.lespinasse.org ([63.205.204.226]:44335 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhD3TxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:23 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=45X0hICb7YyLurpFubxOZ+gBL34g/MPyB7oW/aDWSiM=;
 b=5gnptII9qFi2vooFljqITSE4K6KmNZmsZmUPuqA2aMK3ARQMebMw8B1ZPqFQY3ds9B1t2
 IhTIiOxATX/AphyDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=45X0hICb7YyLurpFubxOZ+gBL34g/MPyB7oW/aDWSiM=;
 b=D3rIm98jspzMJBMzKScap9IiDti8fm4LvQR4SgfW7kvabLrgbhZrxbLJrAf5SMZcI3Sj5
 JNgjQhZfRHtA0ssRxK4rqcWQqNQYno/lv3EYRtp4IjbDAWCX6wkDXnYC+bQjKEzp4gTRRYn
 gfD/+gjMyeFu0OVJDY869fxTD7GebVa0YSAMoNtkKvifQ3Ero2ezc1mpuaBFMtJFzOYphYB
 G55SHqK9BMFKChPa/vhHCUs4RDHIs8uYd5tb4C88OxVErkXSgXU/aaSCE164Ky+YjPxltnc
 ey6wXUJ0vLUoy/ord59B2CZdz19w9q7g5Dci3Vyz1SaF8tlLzZ/hBvu3xwrg==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 2F30F160310;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 2107F19F523; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH 06/29] mm: introduce CONFIG_SPECULATIVE_PAGE_FAULT
Date:   Fri, 30 Apr 2021 12:52:07 -0700
Message-Id: <20210430195232.30491-7-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
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

