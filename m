Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C1532CA49
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 03:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhCDCB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 21:01:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57132 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231992AbhCDCBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 21:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614823195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=niUIy0c/0oGI63bArq9uLm/RRa5ZjXXO2YChidlOiJo=;
        b=e3C9+oqm7PzCPx71R419gbNQoGlxK3dt0EcLExZ/jBUSd3Qvfcm0ZDZzMF1nHb7CqsMB8F
        wtTt+Rl0v8KoDt+TXrmYJWmt3Mf12Q9YkOLQ5UAfJIQlD6m1K2IrARixKanvk75AEwN6te
        jhhS4fShxxPAc86KbPCnRt01wLI1Z80=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-hK_9uOoEO4K6B6buy4rb_g-1; Wed, 03 Mar 2021 20:59:54 -0500
X-MC-Unique: hK_9uOoEO4K6B6buy4rb_g-1
Received: by mail-qk1-f198.google.com with SMTP id y79so21749136qka.23
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 17:59:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=niUIy0c/0oGI63bArq9uLm/RRa5ZjXXO2YChidlOiJo=;
        b=SQdCngdCJuDi+y/CF4eBokOVLHm8zMAnBAjkLP7BuSgyH7zH3BwyOGGs7J9ZIVMN5a
         dpC7m+jDXxQ5iqTMaEbLBok8F14awL/8bvg76NT73OyUnwbeSoJuVll+7Ogr+a8ebFig
         xHPB4vmfuppq65sBtzkQOZk2eGrTxwnbN8Vy2zvaySkdB4VdG1EjH5BPMHlAai5cdl5j
         qzrVBke0ux2QISq9wuTC5w8aYLVayCwlI7gVxYeHcCreuyAT8iHZXj1MAm28sQFHLXPB
         KICj6fMATswl8Y1CgZPi6Kox6pnkAZHhy4dFuYM1luiG9z10CZ4jVd8/ESSMAhHKdV7h
         tkfA==
X-Gm-Message-State: AOAM531NKOH/McrP049t5I96WlL0y3Ti7XL7ufM0ROboix6HQxD5nZi0
        OfO/TapX8DvrTyh44f0rGTI5E5BqV+WWVKgo+w8RpvHlCHft7ZZqrNTWMsi4Gr099P4tV+onAJA
        v7Ul6U4f1EUfUqmc5gNezgjMD
X-Received: by 2002:a05:620a:1442:: with SMTP id i2mr1991185qkl.469.1614823193484;
        Wed, 03 Mar 2021 17:59:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFz8/KVOJPa1tGdZSbCyCB8BIU+7VVcA3wOtpUEiqLGkOezSBFeOaKOITweH1HIu7biYofAg==
X-Received: by 2002:a05:620a:1442:: with SMTP id i2mr1991167qkl.469.1614823193151;
        Wed, 03 Mar 2021 17:59:53 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id b7sm18610766qkj.115.2021.03.03.17.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 17:59:52 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-man@vger.kernel.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linux MM Mailing List <linux-mm@kvack.org>,
        peterx@redhat.com, Axel Rasmussen <axelrasmussen@google.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [PATCH 2/4] userfaultfd.2: Add write-protect mode
Date:   Wed,  3 Mar 2021 20:59:45 -0500
Message-Id: <20210304015947.517713-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210304015947.517713-1-peterx@redhat.com>
References: <20210304015947.517713-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Write-protect mode is supported starting from Linux 5.7.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 man2/userfaultfd.2 | 88 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 2 deletions(-)

diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
index 2d14effc6..8e1602d62 100644
--- a/man2/userfaultfd.2
+++ b/man2/userfaultfd.2
@@ -78,6 +78,28 @@ all memory ranges that were registered with the object are unregistered
 and unread events are flushed.
 .\"
 .PP
+Currently, userfaultfd supports two modes of registration:
+.TP
+.BR UFFDIO_REGISTER_MODE_MISSING
+When registered with
+.BR UFFDIO_REGISTER_MODE_MISSING
+mode, the userspace will receive a page fault message when a missing page is
+accessed.  The faulted thread will be stopped from execution until the page
+fault is resolved from the userspace by either an
+.BR UFFDIO_COPY
+or an
+.BR UFFDIO_ZEROPAGE
+ioctl.
+.TP
+.BR UFFDIO_REGISTER_MODE_WP
+When registered with
+.BR UFFDIO_REGISTER_MODE_WP
+mode, the userspace will receive a page fault message when a write-protected
+page is written.  The faulted thread will be stopped from execution until the
+userspace un-write-protect the page using an
+.BR UFFDIO_WRITEPROTECT
+ioctl.
+.PP
 Since Linux 4.14, userfaultfd page fault message can selectively embed fault
 thread ID information into the fault message.  One needs to enable this feature
 explicitly using the
@@ -143,6 +165,16 @@ single threaded non-cooperative userfaultfd manager implementations.
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
@@ -218,6 +250,54 @@ userfaultfd can be used only with anonymous private memory mappings.
 Since Linux 4.11,
 userfaultfd can be also used with hugetlbfs and shared memory mappings.
 .\"
+.SS Userfaultfd write-protect mode
+Since Linux 5.7, userfaultfd started to support write-protect mode.  The user
+needs to first check availability of this feature using
+.BR UFFDIO_API
+ioctl against the feature bit
+.BR UFFD_FEATURE_PAGEFAULT_FLAG_WP .
+.PP
+To register with userfaultfd write-protect mode, the user needs to send the
+.BR UFFDIO_REGISTER
+ioctl with mode
+.BR UFFDIO_REGISTER_MODE_WP
+set.  Note that it's legal to monitor the same memory range with multiple
+modes.  For example, the user can do
+.BR UFFDIO_REGISTER
+with the mode set to
+.BR UFFDIO_REGISTER_MODE_MISSING\ |\ UFFDIO_REGISTER_MODE_WP.
+When there is only
+.BR UFFDIO_REGISTER_MODE_WP
+registered, the userspace will
+.I not
+receive any message when a missing page is written.  Instead, the userspace
+will only receive a write-protect page fault message when an existing but
+write-protected page got written.
+.PP
+After the
+.BR UFFDIO_REGISTER
+ioctl completed with
+.BR UFFDIO_REGISTER_MODE_WP
+mode set, one can write-protect any existing memory within the range using the
+ioctl
+.BR UFFDIO_WRITEPROTECT
+where
+.I uffdio_writeprotect.mode
+should be set to
+.BR UFFDIO_WRITEPROTECT_MODE_WP .
+.PP
+When a write-protect event happens, the userspace will receive a page fault
+message whose
+.I uffd_msg.pagefault.flags
+will be with
+.BR UFFD_PAGEFAULT_FLAG_WP
+flag set.  Note: since only writes can trigger such kind of fault,
+write-protect messages will always be with
+.BR UFFD_PAGEFAULT_FLAG_WRITE
+bit set too along with
+.BR UFFD_PAGEFAULT_FLAG_WP .
+.PP
+Currently, write-protect mode only supports private anonymous memory.
 .SS Reading from the userfaultfd structure
 Each
 .BR read (2)
@@ -363,8 +443,12 @@ flag (see
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

