Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBBF32A073
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381081AbhCBEUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbhCBADT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 19:03:19 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D6AC0617AB
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 16:01:44 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v196so20663379ybv.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 16:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ga+3+HU/1O4PWNGcBy73JW1dDRIoBKvdkJlksQhtYJk=;
        b=uZhxFptRedsgKaKz9OLDGSC/FW+v3PDlF/1VW4uc6WxsSJPdzbOnoaHonj62Tpf2Rp
         9djnZP2FZSRaquC1Z35N7BlgMdnQY+YTOj3lSji670HF0XsnEilodOWgZ3y0Yvz7azqc
         eIHFdcTK0ubG29dgJPKjYXW95boO5NDDIZNy3ZMda6PAMjQisn6LfG1k0JI/gvy0ieab
         aMZ7kckpt2US41i92QXtYfdDShOJJt9G65y9cAbQsCU72ljS2chnl690UVfwkIad3wzM
         G3ENscyoG3eNGlEckLNaECjJMKHGCwPlGDY56IqtzEaKnYAi//P0StXf2J3gu3PcFcnW
         /S7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ga+3+HU/1O4PWNGcBy73JW1dDRIoBKvdkJlksQhtYJk=;
        b=rWwo03AeYlxueIijvnIAtuBZd7PtV/E5B9wTtixUhmk57pt6R1MsB88K//lKDYyFuE
         Rf2Y7zXHcy5LdI6aFTuAIwDS1v2SsC6AAP7zlOx0+oWZ0N4hzPkXzFdcslHwhxksJx3Q
         XvS0CSlIeZCHFu2cUUmrpfJWGTHoOkBHHiFv4Oc5Bcea/SZnOoE+BW6YPNPRfgkT0g2U
         F0+Cus1Vpi04Ym+6bRUfnKSiWLjkWpv0TRmy9fGhcO71zAbJatIDUG5TuxiQWXVXgjTz
         jbotg2RuxZ9zsB4daLeuGigYYJHx3KU1uX/2aDxNCxf4oCOBILPXsKx1wdGVEPiE4u9n
         7yIA==
X-Gm-Message-State: AOAM5321xpswDFO8p6fNlsCUWvYVMo363x8RJqtOPKQEBEbSU6M/L+yg
        G6sIZq41FY5kUJiahqCAFXU0ZyE9zudh9FdD5sZa
X-Google-Smtp-Source: ABdhPJy2fJwEaq8pxSZCQdXMcW7Yms/ycMK7J/aYvRmsWqsh5YosxRt/wHxAvNdhN8dxc4qvYBp3ldGNeoeAhoFzj5wb
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:1998:8165:ca50:ab8d])
 (user=axelrasmussen job=sendgmr) by 2002:a25:aae2:: with SMTP id
 t89mr29309195ybi.63.1614643303192; Mon, 01 Mar 2021 16:01:43 -0800 (PST)
Date:   Mon,  1 Mar 2021 16:01:31 -0800
In-Reply-To: <20210302000133.272579-1-axelrasmussen@google.com>
Message-Id: <20210302000133.272579-4-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210302000133.272579-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v2 3/5] userfaultfd/selftests: create alias mappings in the
 shmem test
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>, Wang Qing <wangqing@vivo.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, we just allocated two shm areas: area_src and area_dst. With
this commit, change this so we also allocate area_src_alias, and
area_dst_alias.

area_*_alias and area_* (respectively) point to the same underlying
physical pages, but are different VMAs. In a future commit in this
series, we'll leverage this setup to exercise minor fault handling
support for shmem, just like we do in the hugetlb_shared test.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 29 +++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 859398efb4fe..4a18590fe0f8 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -298,8 +298,9 @@ static int shmem_release_pages(char *rel_area)
 
 static void shmem_allocate_area(void **alloc_area)
 {
-	unsigned long offset =
-		alloc_area == (void **)&area_src ? 0 : nr_pages * page_size;
+	void *area_alias = NULL;
+	bool is_src = alloc_area == (void **)&area_src;
+	unsigned long offset = is_src ? 0 : nr_pages * page_size;
 
 	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
 			   MAP_SHARED, shm_fd, offset);
@@ -308,12 +309,34 @@ static void shmem_allocate_area(void **alloc_area)
 		goto fail;
 	}
 
+	area_alias = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
+			  MAP_SHARED, shm_fd, offset);
+	if (area_alias == MAP_FAILED) {
+		perror("mmap of memfd alias failed");
+		goto fail_munmap;
+	}
+
+	if (is_src)
+		area_src_alias = area_alias;
+	else
+		area_dst_alias = area_alias;
+
 	return;
 
+fail_munmap:
+	if (munmap(*alloc_area, nr_pages * page_size) < 0) {
+		perror("munmap of memfd failed\n");
+		exit(1);
+	}
 fail:
 	*alloc_area = NULL;
 }
 
+static void shmem_alias_mapping(__u64 *start, size_t len, unsigned long offset)
+{
+	*start = (unsigned long)area_dst_alias + offset;
+}
+
 struct uffd_test_ops {
 	unsigned long expected_ioctls;
 	void (*allocate_area)(void **alloc_area);
@@ -341,7 +364,7 @@ static struct uffd_test_ops shmem_uffd_test_ops = {
 	.expected_ioctls = SHMEM_EXPECTED_IOCTLS,
 	.allocate_area	= shmem_allocate_area,
 	.release_pages	= shmem_release_pages,
-	.alias_mapping = noop_alias_mapping,
+	.alias_mapping = shmem_alias_mapping,
 };
 
 static struct uffd_test_ops hugetlb_uffd_test_ops = {
-- 
2.30.1.766.gb4fecdf3b7-goog

