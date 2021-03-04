Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F31E32D7E3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbhCDQdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:33:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30974 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237841AbhCDQdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614875513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0tDcn9g219xehBx47za8NiyX09EPm0l6AhkPUkOSCPU=;
        b=A898zDCLqOknDBTPozVDFlkI/XztdoRb4w7iYfEQl6FwMvcPo96qhVe6mdCc527qaJ24H/
        5XBKDFOKpB/GqdHf3mpeRGpC8gFZymyX9jSFiuKDmueTmfD8OlJ/rgdBZcr3FITRFE9o8W
        dSpkcdt9o4VwGzNcM7Uo4uxJyXVBhKU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-LMvORoBkPBuR9woDVQ7LRw-1; Thu, 04 Mar 2021 11:31:51 -0500
X-MC-Unique: LMvORoBkPBuR9woDVQ7LRw-1
Received: by mail-qt1-f200.google.com with SMTP id p32so13186824qtd.14
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 08:31:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0tDcn9g219xehBx47za8NiyX09EPm0l6AhkPUkOSCPU=;
        b=YIYxXEKw+nU96YfBclgDdPPASW5JePrYxzE3jx8vYhajLEAOyAuKSCZZanSh5wYqJ7
         NwMHiLuv1uy/24GSu1OxE/XupxwM1MDcCm+jcRuvGP5QwFuGctLWHz5U2dhUCqHVb5nd
         qOVNZ/3y25RwhUgWst4YbO6fHFd+272rm6bbiDPta3Rx8U0zMI1Kyxs0LCRE9PYoEbo8
         ks3XRYxuB1vzAYAc39edqdOtJQ/Z8MN/s5k4JAiSfEp/6UhJqVm0Zqq7mNilTPJonGSa
         iKCpEDHLI39EQzncddXB4DgdDCzxfgReMY51N73hvfCDGtlTgxtfrOl7Kn4b2SMOnYiD
         CEiw==
X-Gm-Message-State: AOAM533EgcCFv0/JP4M0OJEa482BtZohAHgR/ZvM6O57wASmS3QIjZpL
        iWnS+o1p+fo3+5ieas3CZqfi+U3YMqI7aQbYO8basj3IeStO7B1qN1FbL2zqPvk8tfKmjCgWrFI
        Tw6RnQMBvXT54Zhb1nTNeXewM
X-Received: by 2002:a05:620a:41:: with SMTP id t1mr4784536qkt.322.1614875510981;
        Thu, 04 Mar 2021 08:31:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJylcR7zmiWNLEc9g5jLwnpRiC+4J5ac8vg6ZjMtKy4mC8DnZ8ugihiQl52PJ+chfQRujlICyQ==
X-Received: by 2002:a05:620a:41:: with SMTP id t1mr4784503qkt.322.1614875510658;
        Thu, 04 Mar 2021 08:31:50 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id r2sm51753qti.4.2021.03.04.08.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 08:31:49 -0800 (PST)
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
Subject: [PATCH v2 4/4] ioctl_userfaultfd.2: Add write-protect mode docs
Date:   Thu,  4 Mar 2021 11:31:40 -0500
Message-Id: <20210304163140.543171-5-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210304163140.543171-1-peterx@redhat.com>
References: <20210304163140.543171-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userfaultfd write-protect mode is supported starting from Linux 5.7.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 man2/ioctl_userfaultfd.2 | 76 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
index b58983fe7..7497e63c4 100644
--- a/man2/ioctl_userfaultfd.2
+++ b/man2/ioctl_userfaultfd.2
@@ -234,6 +234,11 @@ operation is supported.
 The
 .B UFFDIO_UNREGISTER
 operation is supported.
+.TP
+.B 1 << _UFFDIO_WRITEPROTECT
+The
+.B UFFDIO_WRITEPROTECT
+operation is supported.
 .PP
 This
 .BR ioctl (2)
@@ -322,9 +327,6 @@ Track page faults on missing pages.
 .B UFFDIO_REGISTER_MODE_WP
 Track page faults on write-protected pages.
 .PP
-Currently, the only supported mode is
-.BR UFFDIO_REGISTER_MODE_MISSING .
-.PP
 If the operation is successful, the kernel modifies the
 .I ioctls
 bit-mask field to indicate which
@@ -443,6 +445,11 @@ operation:
 .TP
 .B UFFDIO_COPY_MODE_DONTWAKE
 Do not wake up the thread that waits for page-fault resolution
+.TP
+.B UFFDIO_COPY_MODE_WP
+Do not set write permission when copying the page.  The next write to the page
+will trigger a write fault.  This can be used in conjunction with write-protect
+mode so that there will be another message generated when the page is written again.
 .PP
 The
 .I copy
@@ -654,6 +661,69 @@ field of the
 structure was not a multiple of the system page size; or
 .I len
 was zero; or the specified range was otherwise invalid.
+.SS UFFDIO_WRITEPROTECT
+(Since Linux 5.7) Do write-protect or write-unprotect for an userfaultfd
+registered memory range with mode
+.BR UFFDIO_REGISTER_MODE_WP .
+.PP
+The
+.I argp
+argument is a pointer to a
+.I uffdio_range
+structure as shown below:
+.PP
+.in +4n
+.EX
+struct uffdio_writeprotect {
+    struct uffdio_range range;  /* Range to change write permission */
+    __u64 mode;                 /* Mode to change write permission */
+};
+.EE
+.in
+There're two modes that are supported in this structure:
+.TP
+.B UFFDIO_WRITEPROTECT_MODE_WP
+When this mode bit is set, the ioctl will be a write-protect operation upon the
+memory range specified by
+.IR range .
+Otherwise it'll be a write-unprotect operation upon the specified range.
+.TP
+.B UFFDIO_WRITEPROTECT_MODE_DONTWAKE
+Do not wake up the thread that waits for page-fault resolution after the
+operation.  This could only be specified if
+.B UFFDIO_WRITEPROTECT_MODE_WP
+is not specified (in a resolving stage, not protecting stage).
+.PP
+This
+.BR ioctl (2)
+operation returns 0 on success.
+On error, \-1 is returned and
+.I errno
+is set to indicate the error.
+Possible errors include:
+.TP
+.B EINVAL
+The
+.I start
+or the
+.I len
+field of the
+.I ufdio_range
+structure was not a multiple of the system page size; or
+.I len
+was zero; or the specified range was otherwise invalid.
+.TP
+.B EAGAIN
+The process was interrupted and need to retry.
+.TP
+.B ENOENT
+The range specified in
+.I range
+is not valid.  E.g., the virtual address does not exist, or not registered with
+userfaultfd write-protect mode.
+.TP
+.B EFAULT
+Encountered a generic fault during processing.
 .SH RETURN VALUE
 See descriptions of the individual operations, above.
 .SH ERRORS
-- 
2.26.2

