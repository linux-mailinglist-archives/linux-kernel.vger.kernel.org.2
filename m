Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFC7345246
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 23:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhCVWJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 18:09:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31833 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230259AbhCVWJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 18:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616450940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kl3kFp9hTUBjJOfw0aybm+GM5kudzpR7W9bPcAyBKfY=;
        b=Xo5qtFOj8gyu6+4rLkIWqF4pE0pFc62vK0d2iwpseqq0hifZbsz+aZIbnBRw8b2fVHuzio
        k5Oo2yJ5dkCTXN6YuveY50ozBHxzjkk6W7UPedCsx+4+7SUvEQcqTz9NOj4NSTE9zt6Mfz
        ev+cnpGiQK2ZZn0vdPNCuraRktxM5cI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-qhbTUsDTPGGgzpLaeJTJsQ-1; Mon, 22 Mar 2021 18:08:58 -0400
X-MC-Unique: qhbTUsDTPGGgzpLaeJTJsQ-1
Received: by mail-qv1-f70.google.com with SMTP id da16so386101qvb.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 15:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kl3kFp9hTUBjJOfw0aybm+GM5kudzpR7W9bPcAyBKfY=;
        b=ozTFopHtSXvAegjal2Ls0mqoR4RjT0Fr3tX8IEoxoDF/mVFXzetWeozubHvOkip8OC
         s/49dvhdiStRXUheGkVvLUfvHsFG3u8dgjOinryxkAClTYGx/DvlFJDFr9PT1qMHUkBt
         Pdso86RXvlHa0/DlvgznxlvH6B25ygYhI+okzbkGgQOReg2tGxPTvoZjt8r5Jl2i0Btt
         dkmldiLBk8/FaPJ39uWfOWs+hG6UGDZ+hrkcVIpcavdy1625JRziNkdBtskQ3EctNJVS
         qOLsdDpth7Hsx+enRVEajjP6o4XaLSdXJDcYCyTKsxe3xGr1ldlxGOs6E20/Fxj6hzaV
         XPsw==
X-Gm-Message-State: AOAM532ZyC78V7Y2rAm9KAlXX6zBthUW4VHni55fdeL37SsteWJFOSYf
        J2Q/6vFV1qyjL52az5qld6CICmE35R3I4i8Zkmg/q3Sd2imKCBlFo4SpKVOXor25PgCzHEzBfK8
        oMzqvekc0DX6UXvTl74JFQbd3
X-Received: by 2002:a05:620a:218e:: with SMTP id g14mr2318824qka.111.1616450937655;
        Mon, 22 Mar 2021 15:08:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXQkjDlpEzfKxL2gVD4fm1+ph4tlOJXa1UzW5utW+yxjYVJwWLncDAwiuahCmShRLGbvdPJw==
X-Received: by 2002:a05:620a:218e:: with SMTP id g14mr2318803qka.111.1616450937365;
        Mon, 22 Mar 2021 15:08:57 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id x1sm9627850qtr.97.2021.03.22.15.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 15:08:56 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alejandro Colomar <alx.manpages@gmail.com>, peterx@redhat.com,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 4/4] ioctl_userfaultfd.2: Add write-protect mode docs
Date:   Mon, 22 Mar 2021 18:08:48 -0400
Message-Id: <20210322220848.52162-5-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210322220848.52162-1-peterx@redhat.com>
References: <20210322220848.52162-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userfaultfd write-protect mode is supported starting from Linux 5.7.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 man2/ioctl_userfaultfd.2 | 84 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 3 deletions(-)

diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
index d4a8375b8..5419687a6 100644
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
@@ -443,6 +445,16 @@ operation:
 .TP
 .B UFFDIO_COPY_MODE_DONTWAKE
 Do not wake up the thread that waits for page-fault resolution
+.TP
+.B UFFDIO_COPY_MODE_WP
+Copy the page with read-only permission.
+This allows the user to trap the next write to the page,
+which will block and generate another write-protect userfault message.
+This is only used when both
+.B UFFDIO_REGISTER_MODE_MISSING
+and
+.B UFFDIO_REGISTER_MODE_WP
+modes are enabled for the registered range.
 .PP
 The
 .I copy
@@ -654,6 +666,72 @@ field of the
 structure was not a multiple of the system page size; or
 .I len
 was zero; or the specified range was otherwise invalid.
+.SS UFFDIO_WRITEPROTECT (Since Linux 5.7)
+Write-protect or write-unprotect an userfaultfd registered memory range
+registered with mode
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
+There're two mode bits that are supported in this structure:
+.TP
+.B UFFDIO_WRITEPROTECT_MODE_WP
+When this mode bit is set, the ioctl will be a write-protect operation upon the
+memory range specified by
+.IR range .
+Otherwise it'll be a write-unprotect operation upon the specified range,
+which can be used to resolve an userfaultfd write-protect page fault.
+.TP
+.B UFFDIO_WRITEPROTECT_MODE_DONTWAKE
+When this mode bit is set,
+do not wake up any thread that waits for page-fault resolution after the operation.
+This could only be specified if
+.B UFFDIO_WRITEPROTECT_MODE_WP
+is not specified.
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
+is not valid.
+For example, the virtual address does not exist,
+or not registered with userfaultfd write-protect mode.
+.TP
+.B EFAULT
+Encountered a generic fault during processing.
 .SH RETURN VALUE
 See descriptions of the individual operations, above.
 .SH ERRORS
-- 
2.26.2

