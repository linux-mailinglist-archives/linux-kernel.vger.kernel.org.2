Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB89B36E1E1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 01:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240172AbhD1WwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 18:52:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240068AbhD1WwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 18:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619650282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aG6Es1lhsdq1W+SfyrFpv9ZTWYnqP0BhVj1uRKdeKnk=;
        b=Ykga9GXdIISdhjb8wHuvZtfjsUfUYmzCUqKsmFXkWFZOcqBo+o5QNdLesQNS13IxjJnMZf
        FzMUpm90Z6jkhaUvlwhygSx3dpN4yw6XLIVWFIVW3vKc86DDgDC0JI3wJirVAygxfUpWHG
        h9/yzMzUDxvOpOuAopJTljtKbVuPyNU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-CXjKKI_uNiG3ORmo_sJAWA-1; Wed, 28 Apr 2021 18:51:21 -0400
X-MC-Unique: CXjKKI_uNiG3ORmo_sJAWA-1
Received: by mail-qk1-f198.google.com with SMTP id h190-20020a3785c70000b02902e022511825so26466631qkd.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 15:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aG6Es1lhsdq1W+SfyrFpv9ZTWYnqP0BhVj1uRKdeKnk=;
        b=sJTps2XLKEvjrQgYHtA3w6yxtX68S2DsULYPCeuBun9Xj0vSmklu/4uFoAPaVbMLbc
         hohbcNMpMDq2Mpb1WFjdsa/g3es2qzZlOjQFmvhF7By0WiN2VikS6sEDwYJB4tDNG7iw
         CtkLSmeWYDARqw6jr2tonEHMgssgGnszrUtg/wraStfMHONq0ToEWngA9gIb73T6X3lS
         wSAyzYWREM23JJuuP3cF1KYpdfI52zut9JNQJlDj6nKGDhVy8nZ2/ySd0Yw03IIQkkOj
         44CThsvY2cQcNriNqQaNieVVvE+NpuCM/pJL/dtPFgT8UXVoY3SrFAawrp7RBhvt0XiW
         z6GA==
X-Gm-Message-State: AOAM531CMxxKhTdtzduKuGYthJABEHxY/IThj4Ax1R4Sez9v7b2xj6nn
        2zJB5kBFXz8eFaYlg691ZC1Badrj2p7a3kCc4Vev+FTg07Emeq9Z8U8XFuEFMlEFQjAfKVnZb4F
        U9I8ypN251XQxC2Esbj4L8xNj
X-Received: by 2002:a0c:9ae9:: with SMTP id k41mr24204946qvf.40.1619650280326;
        Wed, 28 Apr 2021 15:51:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzi0KqzO23V+VDmbdXTP1koTP2GA72Z0kaCSBKAzMlcmEcNe5JkFaEp7X/r2ioxQbKVKn1aRQ==
X-Received: by 2002:a0c:9ae9:: with SMTP id k41mr24204929qvf.40.1619650280118;
        Wed, 28 Apr 2021 15:51:20 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id 191sm897459qkk.31.2021.04.28.15.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 15:51:19 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>
Subject: [PATCH 4/6] mm/userfaultfd: Fail uffd-wp registeration if not supported
Date:   Wed, 28 Apr 2021 18:50:28 -0400
Message-Id: <20210428225030.9708-5-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210428225030.9708-1-peterx@redhat.com>
References: <20210428225030.9708-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should fail uffd-wp registration immediately if the arch does not even have
CONFIG_HAVE_ARCH_USERFAULTFD_WP defined.  That'll block also relevant ioctls on
e.g. UFFDIO_WRITEPROTECT because that'll check against VM_UFFD_WP, which can
only be applied with a success registration.

Remove the WP feature bit too for those archs when handling UFFDIO_API ioctl.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 14f92285d04f8..5dd78238cc156 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1304,8 +1304,12 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	vm_flags = 0;
 	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_MISSING)
 		vm_flags |= VM_UFFD_MISSING;
-	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_WP)
+	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_WP) {
+#ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
+		goto out;
+#endif
 		vm_flags |= VM_UFFD_WP;
+	}
 	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_MINOR) {
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 		goto out;
@@ -1942,6 +1946,9 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	uffdio_api.features = UFFD_API_FEATURES;
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 	uffdio_api.features &= ~UFFD_FEATURE_MINOR_HUGETLBFS;
+#endif
+#ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
+	uffdio_api.features &= ~UFFD_FEATURE_PAGEFAULT_FLAG_WP;
 #endif
 	uffdio_api.ioctls = UFFD_API_IOCTLS;
 	ret = -EFAULT;
-- 
2.26.2

