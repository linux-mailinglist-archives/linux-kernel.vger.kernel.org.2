Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9A732D7E1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237975AbhCDQda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:33:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48311 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237838AbhCDQdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614875511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZyOpGEITNqQDEfKjmjcv27JyIGMyq+vfMvCfDr9TWdA=;
        b=brMkAzOkUZwROih22Nrf7QiNpErzMnYeeDzu2SGfqvUzXBHVRCjrSSmcAVo5MbrgLGhJH7
        gCS23Jxesa4bOHOr+7T4sPfkMbJTC/45N2QXSrf/qeIn+ZPOgZIEARd5gt7SIoagkF3yXf
        URwSSpwxM7+aenGh3TNLDDetJWcNrkA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-FUQCvVr-OGijuRMKGL01kA-1; Thu, 04 Mar 2021 11:31:49 -0500
X-MC-Unique: FUQCvVr-OGijuRMKGL01kA-1
Received: by mail-qk1-f199.google.com with SMTP id y79so23522452qka.23
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 08:31:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZyOpGEITNqQDEfKjmjcv27JyIGMyq+vfMvCfDr9TWdA=;
        b=R0LRzBaNFUn2gnkPLF2Mys7zc834rwK8s2W5h/1yL/yFbJn9TZ/9JAizJDy4CqRaDH
         lNhnNtR/GIAJAM0GMNwclylqbaKDQ3gz5NLEUEwHj9KtYVSw/ExNcq9+jU5jsFFRXumZ
         evDutJ/HowsML7d4MXtmmToekDjIb6nV/tqtZL6ztvBn4xPSGGQUK5RMdvLH4pyGpPDe
         uItNjCpXRmQzTK0Jghf2giyFmMhnUVjlLkE6iMAl+pLZMRPqPuEN0rY0pCmFix1ckI1q
         jJwTnIgfBkG2YvxzMIaibTiaceFjyDwLA1WHcU09PefRudvzUaOzFv02keLFdCHJNNR5
         PcMA==
X-Gm-Message-State: AOAM53344Mp9vb4kjdT/e4PsyXeRVJiXFANezxECfIalW/v52GihHqAC
        KAv83xuGzFGVxbogYTD2sF39QJeemUrhotHICdV8E76SINEm6elnPH/4Na2zvCj5BLFJtbcTDwr
        +MCV7dM1YUh9Qw4KgTFGT9bY+
X-Received: by 2002:ac8:6f53:: with SMTP id n19mr4705850qtv.179.1614875508059;
        Thu, 04 Mar 2021 08:31:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxzgwyOHBLorA9J+eec8/2ydUNPZ5sjcWOkeq5wdSnZvKOKIVu115dffGwg3GqEHPXi9C5SdA==
X-Received: by 2002:ac8:6f53:: with SMTP id n19mr4705816qtv.179.1614875507692;
        Thu, 04 Mar 2021 08:31:47 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id r2sm51753qti.4.2021.03.04.08.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 08:31:47 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-kernel@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        peterx@redhat.com
Subject: [PATCH v2 2/4] userfaultfd.2: Add write-protect mode
Date:   Thu,  4 Mar 2021 11:31:38 -0500
Message-Id: <20210304163140.543171-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210304163140.543171-1-peterx@redhat.com>
References: <20210304163140.543171-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Write-protect mode is supported starting from Linux 5.7.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 man2/userfaultfd.2 | 98 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 2 deletions(-)

diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
index 0cd426a8a..426307bcf 100644
--- a/man2/userfaultfd.2
+++ b/man2/userfaultfd.2
@@ -78,6 +78,30 @@ all memory ranges that were registered with the object are unregistered
 and unread events are flushed.
 .\"
 .PP
+Currently, userfaultfd supports two modes of registration:
+.TP
+.B UFFDIO_REGISTER_MODE_MISSING
+When registered with
+.B UFFDIO_REGISTER_MODE_MISSING
+mode, the userspace will receive a page fault message when a missing page is
+accessed.  The faulted thread will be stopped from execution until the page
+fault is resolved from the userspace by either an
+.B UFFDIO_COPY
+or an
+.B UFFDIO_ZEROPAGE
+ioctl.
+.TP
+.B UFFDIO_REGISTER_MODE_WP
+When registered with
+.B UFFDIO_REGISTER_MODE_WP
+mode, the userspace will receive a page fault message when a write-protected
+page is written.  The faulted thread will be stopped from execution until the
+userspace un-write-protect the page using an
+.B UFFDIO_WRITEPROTECT
+ioctl.
+.PP
+Multiple modes can be enabled at the same time for the same memory range.
+.PP
 Since Linux 4.14, userfaultfd page fault message can selectively embed faulting
 thread ID information into the fault message.  One needs to enable this feature
 explicitly using the
@@ -144,6 +168,16 @@ single threaded non-cooperative userfaultfd manager implementations.
 .\" and limitations remaining in 4.11
 .\" Maybe it's worth adding a dedicated sub-section...
 .\"
+.PP
+Starting from Linux 5.7, userfaultfd is able to do synchronous page dirty
+tracking using the new write-protection register mode.  One should check
+against the feature bit
+.B UFFD_FEATURE_PAGEFAULT_FLAG_WP
+before using this feature.  Similar to the original userfaultfd missing mode,
+the write-protect mode will generate an userfaultfd message when the protected
+page is written.  The user needs to resolve the page fault by unprotecting the
+faulted page and kick the faulted thread to continue.  For more information,
+please read the "Userfaultfd write-protect mode" section below.
 .SS Userfaultfd operation
 After the userfaultfd object is created with
 .BR userfaultfd (),
@@ -219,6 +253,62 @@ userfaultfd can be used only with anonymous private memory mappings.
 Since Linux 4.11,
 userfaultfd can be also used with hugetlbfs and shared memory mappings.
 .\"
+.SS Userfaultfd write-protect mode
+Since Linux 5.7, userfaultfd supports write-protect mode.  The user needs to
+first check availability of this feature using
+.B UFFDIO_API
+ioctl against the feature bit
+.BR UFFD_FEATURE_PAGEFAULT_FLAG_WP .
+.PP
+To register with userfaultfd write-protect mode, the user needs to initiate the
+.B UFFDIO_REGISTER
+ioctl with mode
+.B UFFDIO_REGISTER_MODE_WP
+set.  Note that it's legal to monitor the same memory range with multiple
+modes.  For example, the user can do
+.B UFFDIO_REGISTER
+with the mode set to
+.BR UFFDIO_REGISTER_MODE_MISSING\ |\ UFFDIO_REGISTER_MODE_WP .
+When there is only
+.B UFFDIO_REGISTER_MODE_WP
+registered, the userspace will
+.I not
+receive any message when a missing page is written.  Instead, the userspace
+will only receive a write-protect page fault message when an existing but
+write-protected page got written.
+.PP
+After the
+.B UFFDIO_REGISTER
+ioctl completed with
+.B UFFDIO_REGISTER_MODE_WP
+mode set, the user can write-protect any existing memory within the range using
+the ioctl
+.B UFFDIO_WRITEPROTECT
+where
+.I uffdio_writeprotect.mode
+should be set to
+.BR UFFDIO_WRITEPROTECT_MODE_WP .
+.PP
+When a write-protect event happens, the userspace will receive a page fault
+message whose
+.I uffd_msg.pagefault.flags
+will be with
+.B UFFD_PAGEFAULT_FLAG_WP
+flag set.  Note: since only writes can trigger such kind of fault,
+write-protect messages will always be with
+.B UFFD_PAGEFAULT_FLAG_WRITE
+bit set too along with
+.BR UFFD_PAGEFAULT_FLAG_WP .
+.PP
+To resolve a write-protection page fault, the user should initiate another
+.B UFFDIO_WRITEPROTECT
+ioctl whose
+.I uffd_msg.pagefault.flags
+should have the flag
+.BR UFFDIO_WRITEPROTECT_MODE_WP
+cleared upon the faulted page or range.
+.PP
+Currently, write-protect mode only supports private anonymous memory.
 .SS Reading from the userfaultfd structure
 Each
 .BR read (2)
@@ -364,8 +454,12 @@ flag (see
 .BR ioctl_userfaultfd (2))
 and this flag is set, this a write fault;
 otherwise it is a read fault.
-.\"
-.\" UFFD_PAGEFAULT_FLAG_WP is not yet supported.
+.TP
+.B UFFD_PAGEFAULT_FLAG_WP
+If the address is in a range that was registered with the
+.B UFFDIO_REGISTER_MODE_WP
+flag, when this bit is set it means it's a write-protect fault.  Otherwise it's
+a page missing fault.
 .RE
 .TP
 .I pagefault.feat.pid
-- 
2.26.2

