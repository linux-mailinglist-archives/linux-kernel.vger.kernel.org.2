Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6AC33328F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 01:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhCJApe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 19:45:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20251 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231304AbhCJApR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 19:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615337116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DIKqEnVKGNcLQtEUyRYn0WMFjt909MFugpYoUyiruog=;
        b=AzVXRauGDEJwtWevQI7aOe90moXpVLkynfmh7nAUVsrvDg5rSZBm8jLk/z6YApxXL/Xdwh
        NO0SHlFvjeOPSuncWb8yLGKPVJ4O/D+pSF70GNfPNwljTIoyhiCJGLOT31C1gHnJePTOt2
        JKI0zApptdpfDZKoh0hIdc2tuG/+kwM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-FONuWheNOjm3kRmFUGseKw-1; Tue, 09 Mar 2021 19:45:14 -0500
X-MC-Unique: FONuWheNOjm3kRmFUGseKw-1
Received: by mail-qv1-f71.google.com with SMTP id u17so11516917qvq.23
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 16:45:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DIKqEnVKGNcLQtEUyRYn0WMFjt909MFugpYoUyiruog=;
        b=lFyqWbFJe9jbVJq2tOmznIFmxtd/bsMnfaQjg9N7B1+xc33STDam9SpNfUbbCxi3pe
         4makTGdYwgK8mdJxj94se3kkbWD9zV6rNdHrJe+M9st4bHpJI8Sq1P+fsyGHTdtXpREY
         8sYyev1rO4DkN6UFTvLZCcvZIM0sFJcSJhRBcpBKGAzq+aFiq3YniWgz9+X0ZI0bGWo2
         XuAhymFEfUDMgkAuCxXVE5sXwMOt2Z9G0FL/quIZtghE6ZooThhKvGo2hBwlYz32am9x
         KDkjSAG/0e36hD+KJs6rNYJ5VDu7xP7Fp+2Hpa5IEiOKAt3AT8n5K55fQiZxQYksvLJ2
         K+0Q==
X-Gm-Message-State: AOAM530DBGmPoIsmSWEiBPEgKvlmjmcd4M3AMDM+UUc+k2KFxOV68YBZ
        P4XGWqM30fK77BrvqjCXTiJNHeTvC3WGi9ee0/2gxjT643YY8q+K0lk14lVfm9aAN/Ewp5wlgEB
        5Qrg/eXGCB/78eZSCLzaADr+Y
X-Received: by 2002:a05:620a:142b:: with SMTP id k11mr403974qkj.46.1615337114380;
        Tue, 09 Mar 2021 16:45:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTC9hbLM/m7Kg8/pWXWJFOEAIOs735VU1B7Iv6yPZNnqF1n9Z/Dvdr7fwVIgy27JbpOXBgqg==
X-Received: by 2002:a05:620a:142b:: with SMTP id k11mr403956qkj.46.1615337114167;
        Tue, 09 Mar 2021 16:45:14 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id b27sm11418173qkl.102.2021.03.09.16.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 16:45:13 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 1/5] userfaultfd/selftests: Use user mode only
Date:   Tue,  9 Mar 2021 19:45:07 -0500
Message-Id: <20210310004511.51996-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210310004511.51996-1-peterx@redhat.com>
References: <20210310004511.51996-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userfaultfd selftest does not need to handle kernel initiated fault.  Set user
mode so it can be run even if unprivileged_userfaultfd=0 (which is the default).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index f31e9a4edc55..6dab8ef034a0 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -381,7 +381,7 @@ static int userfaultfd_open(uint64_t *features)
 {
 	struct uffdio_api uffdio_api;
 
-	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
 	if (uffd < 0) {
 		fprintf(stderr,
 			"userfaultfd syscall not available in this kernel\n");
-- 
2.26.2

