Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D197F315D10
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbhBJCRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbhBJBSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 20:18:38 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B93C061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 17:17:51 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 6so619042ybq.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 17:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=4sl8hCVYIIQXoKXiaYQxzYCkEmKowx44CLAZnUGYVQs=;
        b=YkvoF37IrAacD5AjBdQZFGuE+sqb+HPbZ0qhtTS0gmDv1XP1r2Hv/AcFIZDnnN5WJd
         26pLWViCA7wdm7H4/QmSnpJlDhz2I44y8JE0eaKfu7gI3P+eGMGr7oiNnfkKbH0CBDMA
         o8xzlyXdUNogp1VR6BudLfgdj2bSrtGM1eh6/PUUu3zcKNCwguYUP+b3dWUxIwSPMPDg
         Qp1hJzmmVjnqYPcCevN7qAa3kub9UbdJxV9tlDtIqppBtIfB+tZNbUimxnqX2LzCkq3W
         5feHA8oRk/rKWYPS+nXzyb2btxspxoTY/a6QjiwFd1oTC9C1q3D7gMrhZNMg98fLyBO6
         DsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:message-id:mime-version
         :subject:from:to:cc;
        bh=4sl8hCVYIIQXoKXiaYQxzYCkEmKowx44CLAZnUGYVQs=;
        b=ChZp7S6p+DBpGwZPqflQFBt2v2+9C8HjUb2TzFN2l+eAODs6CHgPz6VPFuRwZPy+Rr
         EJ1N+NoaagIuGP4CweBkkmFdwyxgXTPLVkSquq1upNxhOqdxTL1zeaA2bAUPHQjFyjTP
         aKZ4SlPEEyCWogUD7ZjyzrRtHFkkH+uagwMSWJXviz+hVY9EfmgXWCQRDyNaPqxgqnTm
         EAzPRrlOCraJRO/lYA2iif8oa0g5xGw3dClrEna6Xs4AzpRtxrP3O5ngnJTx2clDGQTM
         o5Wd0OJA/78RKPTlQhzpxjByV7/TBQMKDYlUt5UAHzJPpFjge9I58OOgOfmFVHgofW3Z
         nOUA==
X-Gm-Message-State: AOAM533IrunCOLTD51ZXuofLSFBY0LMNbm9QjEbEeuz4sR9tOva0iFcs
        JvSxlHvaPhmFXkVEskn22rGOmJrxSF0=
X-Google-Smtp-Source: ABdhPJzPRKyyxJdYxkBjVQkd0UxE8M40kpQxENvRuhzY8gYI83CdYVh2q9wUF/UDyg08fHP70sxnxbDTjcM=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1513:9e6:21c3:30d3])
 (user=seanjc job=sendgmr) by 2002:a25:e787:: with SMTP id e129mr889657ybh.478.1612919870827;
 Tue, 09 Feb 2021 17:17:50 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  9 Feb 2021 17:17:47 -0800
Message-Id: <20210210011747.240913-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH] KVM: selftests: Add missing header file needed by xAPIC IPI tests
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Jones <drjones@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Shier <pshier@google.com>

Fixes: 678e90a349a4 ("KVM: selftests: Test IPI to halted vCPU in xAPIC while backing page moves")
Cc: Andrew Jones <drjones@redhat.com>
Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Peter Shier <pshier@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

Delta patch taken verbatim from Peter's original submission.  Applying the
original patch directly is mildly annoying due to conflicts with kvm/next
in other files.

 tools/testing/selftests/kvm/include/numaif.h | 55 ++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/numaif.h

diff --git a/tools/testing/selftests/kvm/include/numaif.h b/tools/testing/selftests/kvm/include/numaif.h
new file mode 100644
index 000000000000..b020547403fd
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/numaif.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * tools/testing/selftests/kvm/include/numaif.h
+ *
+ * Copyright (C) 2020, Google LLC.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ *
+ * Header file that provides access to NUMA API functions not explicitly
+ * exported to user space.
+ */
+
+#ifndef SELFTEST_KVM_NUMAIF_H
+#define SELFTEST_KVM_NUMAIF_H
+
+#define __NR_get_mempolicy 239
+#define __NR_migrate_pages 256
+
+/* System calls */
+long get_mempolicy(int *policy, const unsigned long *nmask,
+		   unsigned long maxnode, void *addr, int flags)
+{
+	return syscall(__NR_get_mempolicy, policy, nmask,
+		       maxnode, addr, flags);
+}
+
+long migrate_pages(int pid, unsigned long maxnode,
+		   const unsigned long *frommask,
+		   const unsigned long *tomask)
+{
+	return syscall(__NR_migrate_pages, pid, maxnode, frommask, tomask);
+}
+
+/* Policies */
+#define MPOL_DEFAULT	 0
+#define MPOL_PREFERRED	 1
+#define MPOL_BIND	 2
+#define MPOL_INTERLEAVE	 3
+
+#define MPOL_MAX MPOL_INTERLEAVE
+
+/* Flags for get_mem_policy */
+#define MPOL_F_NODE	    (1<<0)  /* return next il node or node of address */
+				    /* Warning: MPOL_F_NODE is unsupported and
+				     * subject to change. Don't use.
+				     */
+#define MPOL_F_ADDR	    (1<<1)  /* look up vma using address */
+#define MPOL_F_MEMS_ALLOWED (1<<2)  /* query nodes allowed in cpuset */
+
+/* Flags for mbind */
+#define MPOL_MF_STRICT	     (1<<0) /* Verify existing pages in the mapping */
+#define MPOL_MF_MOVE	     (1<<1) /* Move pages owned by this process to conform to mapping */
+#define MPOL_MF_MOVE_ALL     (1<<2) /* Move every page to conform to mapping */
+
+#endif /* SELFTEST_KVM_NUMAIF_H */
-- 
2.30.0.478.g8a0d178c01-goog

