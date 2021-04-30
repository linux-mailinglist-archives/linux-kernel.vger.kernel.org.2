Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A481370186
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbhD3Txu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:53:50 -0400
Received: from server.lespinasse.org ([63.205.204.226]:59681 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbhD3TxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:24 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=52xfj//MRWSrbPuyYyafld4PYpnTwPxqkOlVrkxjHfQ=;
 b=TpC4loRIPK/cBkY+s+mjCdbTT494398fFNDLLdCWbY8EjH0I7Q6xyMRMBhAMkCrGIlfJb
 WLj8GxiP95c6LU6Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=52xfj//MRWSrbPuyYyafld4PYpnTwPxqkOlVrkxjHfQ=;
 b=Rcaa6wo5In854wslLI8fHcjWWfxBAKiir/rzHwUBRFIEnuVBPxCeFwAG02rsrjXM7Bq0Q
 VbrQJ58H7fljGUwNJiymWqrH99zWjGRobxOBG9yeQ19O42RornJsrL5dYksqq7Nnv5+v/l4
 R4Z6gk0nTJMTPzhQ0jKX1jf/6k91/HazkacrdXkZupbgQ2NikLzFcxlAEMVMbKoc1y0ZTfh
 H2E6I24Yo4YWFnBohNLUIfbP5zt1E/C4reBuh9X3iD3aMEP901bBgjHrLdjRxSohz1fPXIM
 1wXb4ixDcUSAyq6ywFADgJIDN0/q+GIkFpghPd0QHf4p2YkLcNXNEObrTppg==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 3DAB9160312;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 2F05F19F524; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
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
Subject: [PATCH 08/29] mm: add FAULT_FLAG_SPECULATIVE flag
Date:   Fri, 30 Apr 2021 12:52:09 -0700
Message-Id: <20210430195232.30491-9-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the new FAULT_FLAG_SPECULATIVE flag, which indicates when we are
attempting speculative fault handling (without holding the mmap lock).

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 include/linux/mm.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8ba434287387..021fdab5b721 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -434,6 +434,7 @@ extern pgprot_t protection_map[16];
  * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
  * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
  * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
+ * @FAULT_FLAG_SPECULATIVE: The fault is handled without holding the mmap_sem.
  *
  * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
  * whether we would allow page faults to retry by specifying these two
@@ -464,6 +465,7 @@ extern pgprot_t protection_map[16];
 #define FAULT_FLAG_REMOTE			0x80
 #define FAULT_FLAG_INSTRUCTION  		0x100
 #define FAULT_FLAG_INTERRUPTIBLE		0x200
+#define FAULT_FLAG_SPECULATIVE			0x400
 
 /*
  * The default fault flags that should be used by most of the
@@ -501,7 +503,8 @@ static inline bool fault_flag_allow_retry_first(unsigned int flags)
 	{ FAULT_FLAG_USER,		"USER" }, \
 	{ FAULT_FLAG_REMOTE,		"REMOTE" }, \
 	{ FAULT_FLAG_INSTRUCTION,	"INSTRUCTION" }, \
-	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }
+	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }, \
+	{ FAULT_FLAG_SPECULATIVE,	"SPECULATIVE" }
 
 /*
  * vm_fault is filled by the pagefault handler and passed to the vma's
-- 
2.20.1

