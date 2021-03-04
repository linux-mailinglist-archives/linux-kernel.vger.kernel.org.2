Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058CC32CA46
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 03:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhCDCBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 21:01:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42159 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231846AbhCDCBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 21:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614823194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6giwxHagLNhvH9wjwPVXr4QfIvTV/E45XOSinFMpOUo=;
        b=UCQZ98ARbO4TbjJKyiKjbOvBVgpf1V8E0ujcu9wZUb6puwbsBuo9tuEKd746F/fQnRSPWl
        x+Q7GtLIQjwOWxw2e3NigCJibyKY/u5QqmSkVvOpxhLnN/wlBn6KIgfXtKk1m3A1PcPv0O
        HjsWnLVmEwhVjxocnKuisfH7dCO01W0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-ROHXCaEDNTu7cSqTSa0NaA-1; Wed, 03 Mar 2021 20:59:52 -0500
X-MC-Unique: ROHXCaEDNTu7cSqTSa0NaA-1
Received: by mail-qt1-f197.google.com with SMTP id b21so9557048qtr.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 17:59:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6giwxHagLNhvH9wjwPVXr4QfIvTV/E45XOSinFMpOUo=;
        b=fJ90i4ArGCdlt3SG3/H9NkmZyAOjSATA3/5Y2mns7blijYSX7H+X2aqDPKmKOn1rYr
         oBfofN2tpsKKiMNRX3L5KzA6Lo+ZkV8D6w8f5Ema/lRof3/emU9a3bW+qAGONWRoFa1K
         lTKK3ALpnFgmP4iCOyQAvxyfj0OqmRIzFyNaY4tIBazk/odWWmCkSkJBJEsN0tcoK2pz
         Stce48GwcOW59RxQcpRjbiSCLggRLyHsUBmuNzQg4/p8Vqh0C0NsLFPbfUeupYU4LuBA
         tk3XO/hK0ggqeK3bgg/qGU4idQw3C1sqMvvJbRneGF7q0rNaMtR2p/gghSJKtH5QSX4d
         l3wA==
X-Gm-Message-State: AOAM530PjcJCULLPG0xRbWyCPWKW/QR+ycivcj160KviNJKXXw3qN+Dd
        syCyNels8cxwZVBMO9pt/fiKJBPjakjJ+BgZU6sRylruVCjVMjzpzqLWyqhUTd2DtAXQAYSxzBe
        L3PFQKa68Ad4AWTO7T+HWoC8v
X-Received: by 2002:a05:620a:24cd:: with SMTP id m13mr1993422qkn.273.1614823191991;
        Wed, 03 Mar 2021 17:59:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/DQSt2aYncHjoOHQu9QXhn+5x7svfSyAdU8G4L8+vCm+0Im6H1cwOMa3oUcIA8WCFio/AWA==
X-Received: by 2002:a05:620a:24cd:: with SMTP id m13mr1993408qkn.273.1614823191779;
        Wed, 03 Mar 2021 17:59:51 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id b7sm18610766qkj.115.2021.03.03.17.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 17:59:50 -0800 (PST)
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
Subject: [PATCH 1/4] userfaultfd.2: Add UFFD_FEATURE_THREAD_ID docs
Date:   Wed,  3 Mar 2021 20:59:44 -0500
Message-Id: <20210304015947.517713-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210304015947.517713-1-peterx@redhat.com>
References: <20210304015947.517713-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFFD_FEATURE_THREAD_ID is supported since Linux 4.14.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 man2/userfaultfd.2 | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
index e7dc9f813..2d14effc6 100644
--- a/man2/userfaultfd.2
+++ b/man2/userfaultfd.2
@@ -77,6 +77,12 @@ When the last file descriptor referring to a userfaultfd object is closed,
 all memory ranges that were registered with the object are unregistered
 and unread events are flushed.
 .\"
+.PP
+Since Linux 4.14, userfaultfd page fault message can selectively embed fault
+thread ID information into the fault message.  One needs to enable this feature
+explicitly using the
+.BR UFFD_FEATURE_THREAD_ID
+feature bit when initializing the userfaultfd context, otherwise disabled.
 .SS Usage
 The userfaultfd mechanism is designed to allow a thread in a multithreaded
 program to perform user-space paging for the other threads in the process.
@@ -229,6 +235,9 @@ struct uffd_msg {
         struct {
             __u64 flags;    /* Flags describing fault */
             __u64 address;  /* Faulting address */
+            union {
+                __u32 ptid; /* Thread ID of the fault */
+            } feat;
         } pagefault;
 
         struct {            /* Since Linux 4.11 */
@@ -358,6 +367,9 @@ otherwise it is a read fault.
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

