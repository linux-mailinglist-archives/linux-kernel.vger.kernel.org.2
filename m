Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8E53560FF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347951AbhDGBw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:52:26 -0400
Received: from server.lespinasse.org ([63.205.204.226]:36151 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347824AbhDGBvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:50 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759902; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=52xfj//MRWSrbPuyYyafld4PYpnTwPxqkOlVrkxjHfQ=;
 b=GvnGI3H89uTnazRHTDjnxLW+ccgB0I6UmagHwVWO7+HvJmu/Xz4zrBwhYVsgpQqJep04E
 /mSNP7hSXpYMwncBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759902; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=52xfj//MRWSrbPuyYyafld4PYpnTwPxqkOlVrkxjHfQ=;
 b=OPSlT2/JohSmnlkUlugEyrQWJGbWdvh3hCrR2zpCuBAkb0PqOs9L/8a1xMIkjUTPb6y/Y
 cqCd+Rc9KW52GcFFxiN8SD6vfmn3I1JFhCo5KiccQgfvcM6CJc3W8zaXuT5ThUVmeQhKxwF
 Vv3Tln3K/YyIUTnOCtq8l27Jcl2tKkKlNdHXJkUu60voSM8GWMYr/XoFYw5Fn5K+GWMGnRZ
 bjeI1gOPLQVsR1Dt87WfKPyDXGDlQTD2GsUHD0sXH2S2FGmhMwJAXew2nTK7G34kOVswtcU
 MBvREvEpTSbD6cIqxKwy6GYP58Sd0uTstf6uUtlS27n+sX9m3uunc/9bmcmA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 93B5816024D;
        Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 8550819F31E; Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
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
Subject: [RFC PATCH 07/37] mm: add FAULT_FLAG_SPECULATIVE flag
Date:   Tue,  6 Apr 2021 18:44:32 -0700
Message-Id: <20210407014502.24091-8-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
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

