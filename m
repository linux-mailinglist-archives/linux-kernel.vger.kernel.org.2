Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A3635D3F3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 01:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344124AbhDLX2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 19:28:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41691 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237531AbhDLX2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 19:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618270078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8RGMu5U4C672ZFkUHV1HUutAzRw00/5hGpU2qjqaw+g=;
        b=ik+iRlrxh7hPPnvos0zGnriJrBvCGHLz7LS/hXsW0VlqT/44lnwqPkVLIZdMhvqyIY2vL7
        P45Cac3nxhfzzu9w8Nz6nesUDiil+uokWPMrYKM5/Fky4ZkMuM03emRjKSpCzapKpeYDa9
        2YhK6x7SSgx0bgyRYSwClvu97yLoqFE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-bZTjzXCXPzukV_petnkBmQ-1; Mon, 12 Apr 2021 19:27:57 -0400
X-MC-Unique: bZTjzXCXPzukV_petnkBmQ-1
Received: by mail-qv1-f69.google.com with SMTP id p2so8977670qvi.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 16:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8RGMu5U4C672ZFkUHV1HUutAzRw00/5hGpU2qjqaw+g=;
        b=TvJ7f+Ev7WvYoyG8TYXn4I1/9WkIM2IYCIeGOrrAkt5VMXfrVj1cHe+GVS5ODtScW6
         2uk+zI30TUgynOHeNSjYgJ8Fwf+GcVYaiVMLQfB3q3G9Ak+JkZUKSj+HcS9Y/tBW6nPe
         8eoNJytq9fIcCnsDw/MUS7WfdwsMCIAS+bYIbMXgweMfqfGjtGFxE4uQ9ZlIwZFMkfYp
         wyUZ2/cx9xNHVxrQujXjcgGWIpwOtk+DeZXAL/8gdAQJ9T7JP6/wJHcXz54IKjlZnDO0
         iCg0H0Tz40xLhqOi5EM0lmvHR6PWjULZ5oSNclpUzUMzbXDSkDx2zR6LfM+OA7k4ZkvL
         3N+A==
X-Gm-Message-State: AOAM5337JYuBwu5OfKCpbjzSiXS5DpP4LB2V3HUGv1Mw+QMQ2MwrV9Gz
        3Fo0B5vt6r1x4w5f0TZcsysfxBC6a2gp/N6Q0JugZmDwb/ZY8KitjSR7eDXl5VHXe4BwzsXBZ3F
        ODSJXlYbP7jOoDTC87QOJkVGK
X-Received: by 2002:ac8:6d09:: with SMTP id o9mr3892032qtt.382.1618270076826;
        Mon, 12 Apr 2021 16:27:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxn5W/tQj+R3pMmXzP0Ur8Z8NUkCG0N6aVa54TjdIDXDmk9C1P06JrNCv3t9AkIZY1b6K3Tow==
X-Received: by 2002:ac8:6d09:: with SMTP id o9mr3892019qtt.382.1618270076645;
        Mon, 12 Apr 2021 16:27:56 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id y29sm8958925qtm.13.2021.04.12.16.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 16:27:56 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v2 1/5] userfaultfd/selftests: Use user mode only
Date:   Mon, 12 Apr 2021 19:27:49 -0400
Message-Id: <20210412232753.1012412-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210412232753.1012412-1-peterx@redhat.com>
References: <20210412232753.1012412-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userfaultfd selftest does not need to handle kernel initiated fault.  Set user
mode so it can be run even if unprivileged_userfaultfd=0 (which is the default).

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index f5ab5e0312e7..ce23db8eec26 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -831,7 +831,7 @@ static int userfaultfd_open_ext(uint64_t *features)
 {
 	struct uffdio_api uffdio_api;
 
-	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
 	if (uffd < 0) {
 		fprintf(stderr,
 			"userfaultfd syscall not available in this kernel\n");
-- 
2.26.2

