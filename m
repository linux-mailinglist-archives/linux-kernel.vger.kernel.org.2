Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62288345243
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 23:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhCVWJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 18:09:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57526 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230245AbhCVWIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 18:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616450934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xTi7eK4FhauapOMog+x2j3yLdISM1j6yYqbUEE/lj8k=;
        b=hC6FQNUvBx5npVwanmIW+Np5ZkkYqhhwQw1b7HO5e3MkdVxdsb2Pqmcc5RAY5xWPSSzROA
        U+Q5i3OsEICf769XouzyS2qotldXszfZWgAX2gkaolOWAg1JcQGFtWsiWKERnYBWCQFV7j
        SHdFFt3OoC4gnhS7sF8PHlzUkxLT5Lk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-2ocsdILFN_-rAm7h4hoW1Q-1; Mon, 22 Mar 2021 18:08:53 -0400
X-MC-Unique: 2ocsdILFN_-rAm7h4hoW1Q-1
Received: by mail-qk1-f199.google.com with SMTP id c1so563216qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 15:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xTi7eK4FhauapOMog+x2j3yLdISM1j6yYqbUEE/lj8k=;
        b=XyA60KZ/XdxARu8PG2XJlw87uBhBQPSpvE4NYSW5xoTIPd/o9CfoubnOKx6+wbKSm8
         IBoEYFhM1HW41+Ql5pggehN27TI4wFYScMeWc5nUQ7UI4aEKLDpaYSE1mlYQFqn6oOqP
         8tTGHe2tHBfVorygn3HZ1+qKuZxW3TrfKpDDPPgqcRfoFv25leU0mvPjJ3c35wP85xUf
         KcaRoD6cKRs9NqtBL/V9XLk/fJX2ZgD72YDNF1ks8SY1sUTcGIx1OpU6P+NBEqQOVLlZ
         kMjWX68i5v87IEuGpkaRgqMccmAvR2dKAf/laD2jPvJOWkjNsnGDmdnh2cKee2wJTbOx
         cHgQ==
X-Gm-Message-State: AOAM5305S99nSzpz5oiG7L2NLX0VOk57SJTClJANOc9j/LCU0nFcpqrd
        hqeUm2lt9lIin5g8jkx5m9tymMl4XVx/KUbZr4DiuOXDnk07Qx+a/Vvlq32LfCMG/pPgKArhbGa
        iiK3g+Sy3eSO0zhMg507wdQ4S
X-Received: by 2002:a37:a54f:: with SMTP id o76mr2394699qke.95.1616450932649;
        Mon, 22 Mar 2021 15:08:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvR5mojOQvg8OR/JFwX8IuACjNMK6k85LHvXAJT/PWMYtQY/hEXAcDMJRURNBcqov9dxUd3g==
X-Received: by 2002:a37:a54f:: with SMTP id o76mr2394675qke.95.1616450932419;
        Mon, 22 Mar 2021 15:08:52 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id x1sm9627850qtr.97.2021.03.22.15.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 15:08:51 -0700 (PDT)
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
Subject: [PATCH v4 1/4] userfaultfd.2: Add UFFD_FEATURE_THREAD_ID docs
Date:   Mon, 22 Mar 2021 18:08:45 -0400
Message-Id: <20210322220848.52162-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210322220848.52162-1-peterx@redhat.com>
References: <20210322220848.52162-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFFD_FEATURE_THREAD_ID is supported since Linux 4.14.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 man2/userfaultfd.2 | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
index e7dc9f813..555e37409 100644
--- a/man2/userfaultfd.2
+++ b/man2/userfaultfd.2
@@ -77,6 +77,13 @@ When the last file descriptor referring to a userfaultfd object is closed,
 all memory ranges that were registered with the object are unregistered
 and unread events are flushed.
 .\"
+.PP
+Since Linux 4.14, userfaultfd page fault message can selectively embed faulting
+thread ID information into the fault message.
+One needs to enable this feature explicitly using the
+.BR UFFD_FEATURE_THREAD_ID
+feature bit when initializing the userfaultfd context.
+By default, thread ID reporting is diabled.
 .SS Usage
 The userfaultfd mechanism is designed to allow a thread in a multithreaded
 program to perform user-space paging for the other threads in the process.
@@ -229,6 +236,9 @@ struct uffd_msg {
         struct {
             __u64 flags;    /* Flags describing fault */
             __u64 address;  /* Faulting address */
+            union {
+                __u32 ptid; /* Thread ID of the fault */
+            } feat;
         } pagefault;
 
         struct {            /* Since Linux 4.11 */
@@ -358,6 +368,9 @@ otherwise it is a read fault.
 .\" UFFD_PAGEFAULT_FLAG_WP is not yet supported.
 .RE
 .TP
+.I pagefault.feat.pid
+The thread ID that triggered the page fault.
+.TP
 .I fork.ufd
 The file descriptor associated with the userfault object
 created for the child created by
-- 
2.26.2

