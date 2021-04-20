Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48365366208
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 00:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbhDTWJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 18:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbhDTWJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 18:09:02 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA52CC061349
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 15:08:27 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 7-20020ac857070000b02901ba5c36e1b2so2690193qtw.21
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 15:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+mbkINT23NQwVcWMsgi99GnmaMWJZnHq8mB1mAGG8Zs=;
        b=po9ArG7ZdtzYVDcv5vyMGKJeuPtnghxwSIn+gUjtsSZPemrE/klwSLC5Hm14ZzmVBr
         J4fsL1TqZkclrXJQjUYboxz/RZII5pyYDh6HnkqPk414pWLjG4kpolNiR9s75do6g2Pr
         DpY3NvwNL7a+rT74p+SLBJs1f45c6PET88l3inft/kpGjTYvvhQIjy7gAGRUbiwr4Fv2
         2Q7p3yMlGf9aUzi7Tio8EON2fR6Vu88aq+LcqtbIUmOgkVbX/B3Am1bivGu/zj7wXnBW
         aW6henJINq/oy28fXQsFp37HYoat5FM6j15ZtXY1rxjN5oKqtEd6dQFDNqVQnNPT/ZSQ
         kwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+mbkINT23NQwVcWMsgi99GnmaMWJZnHq8mB1mAGG8Zs=;
        b=dedqJwERgQs9CfMidnL9xVDn8KtcX8bESUFSbZvjCBGX5WqYcuo0VbnUNMw3+eQyEI
         lqNDtJcvJuM1qZ1r23eg1p+Kq6uOVk28ulj1GXmnxPHJKxtakE/Cj0rOvT7EjhFcl2x7
         aLnPU8wbkQrVGx6mZWrPhuJ7yb+ZYHQKY9/OS8gnlO48i054Fks6MGLbvw0PEj0lhvM3
         6uJBQ6EuEO4GEtCMBTWGShAyZgypx1vmSlYKCKq2CDz8OICXSKzLicmTHIb/aI/W7KmB
         YcOM08y3WzmOKpKupOmto5RHWYAbmbfpZ9WWtLdvx/PspRAaA7aJ40Yfp2PusIRwZYke
         rVzA==
X-Gm-Message-State: AOAM533Qn81tFNhWvvts0LY25/RepRD67jjS0BMofr0SF1K+cY1/0F2C
        IWMabcpl6G0Np3lY3u60vL+9gyTCYc1Si06IjcCy
X-Google-Smtp-Source: ABdhPJzDCW1ZTwiCo7QhfK6grPFLercdg6lvY5/FYqbdhC5uCIc0YWN0hcRTy+dnp5ILgkSMhBf0eQ1k/vGiUVro3wEN
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:c40e:ee2c:2ab8:257a])
 (user=axelrasmussen job=sendgmr) by 2002:ad4:4944:: with SMTP id
 o4mr29064929qvy.18.1618956506891; Tue, 20 Apr 2021 15:08:26 -0700 (PDT)
Date:   Tue, 20 Apr 2021 15:08:04 -0700
In-Reply-To: <20210420220804.486803-1-axelrasmussen@google.com>
Message-Id: <20210420220804.486803-11-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210420220804.486803-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v4 10/10] userfaultfd: update documentation to mention shmem
 minor faults
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generally, the documentation we wrote for hugetlbfs-based minor faults
still all applies. The only missing piece is to mention the new feature
flag which indicates that the kernel supports this for shmem as well.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 Documentation/admin-guide/mm/userfaultfd.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 3aa38e8b8361..6528036093e1 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -77,7 +77,8 @@ events, except page fault notifications, may be generated:
 
 - ``UFFD_FEATURE_MINOR_HUGETLBFS`` indicates that the kernel supports
   ``UFFDIO_REGISTER_MODE_MINOR`` registration for hugetlbfs virtual memory
-  areas.
+  areas. ``UFFD_FEATURE_MINOR_SHMEM`` is the analogous feature indicating
+  support for shmem virtual memory areas.
 
 The userland application should set the feature flags it intends to use
 when invoking the ``UFFDIO_API`` ioctl, to request that those features be
-- 
2.31.1.368.gbe11c130af-goog

