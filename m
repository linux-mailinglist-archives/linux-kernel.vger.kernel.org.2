Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2419932D7DF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237921AbhCDQd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:33:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43492 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237834AbhCDQdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614875508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p9IaoeJsCRUG1LLipzY/Smbk9hrubLxR/AALEDsivN8=;
        b=OAaN0JRv3sNwCuwEcT5UE+hb22Jxp6MRiaP18NVmkOA/149kCZbEqw+qX39gcKjiSQVQYK
        /oGZbo8dIU4RwotgDZP7VPzLAGBYOEuPLKHD1ZJow+gNFYn9UbKVc0y5Y4iPzLSuzDNYb2
        Z9kUprhTvJ1YfzhS2zNn6Myz0CglLnM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-INxaJifSORCbNgovrf4AjQ-1; Thu, 04 Mar 2021 11:31:46 -0500
X-MC-Unique: INxaJifSORCbNgovrf4AjQ-1
Received: by mail-qt1-f200.google.com with SMTP id t5so19347124qti.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 08:31:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p9IaoeJsCRUG1LLipzY/Smbk9hrubLxR/AALEDsivN8=;
        b=rH2aU2u/5Behh8XqeaBY8T3PS3n/xhnUXq5vlKY+E0zvPtR+Pyv54V/ABQZOV8Xcd2
         6a/6Q3ftDZ/Z7Oz6lPRlASW+vPrLps7aDWKsZdiyRBKVpPPoH1m6I2yxqB/pCDykTt2W
         BZEwFVDYyuRzsNwryxB3OZZcjqGP6kls/pS5f1Bnt+nz5/i2VYOSwcPJmzgtPnKKhkdn
         onTOPxHL6xYI1NvpZxR1hB6A/Q4alPQXEtCAiQjV+AnSklWuTPUeoKjwlOmyhLSBJoM5
         HrAy5URiLdNS09M+/civlTrJMUP090PN/uEmsePamwfe89Ck1SCxzif2wf5VT6pz7Zlt
         ziYg==
X-Gm-Message-State: AOAM531YlE0j560uWtBsdt5xAk71U/4hSgLnlvZXfQ0mjZbxQslc/bLH
        UDL0SQGC8DcLYY8AWtndV1LZTu5uiE1xRQtMhn1HAtbZreeBcdT0cL3l/GIXN48jhoqyG83FlEK
        tRTUOi8O6er1Cucyg165dAB5n
X-Received: by 2002:a0c:b9a2:: with SMTP id v34mr4525202qvf.17.1614875505657;
        Thu, 04 Mar 2021 08:31:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSsP+FFMDB/tnZzXdHZPnv+zAKYJ770BYZdyp3Xn0vfNLHMmlKp8dtkSsQcoMvksDc0fVEbA==
X-Received: by 2002:a0c:b9a2:: with SMTP id v34mr4525179qvf.17.1614875505427;
        Thu, 04 Mar 2021 08:31:45 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id r2sm51753qti.4.2021.03.04.08.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 08:31:44 -0800 (PST)
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
Subject: [PATCH v2 1/4] userfaultfd.2: Add UFFD_FEATURE_THREAD_ID docs
Date:   Thu,  4 Mar 2021 11:31:37 -0500
Message-Id: <20210304163140.543171-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210304163140.543171-1-peterx@redhat.com>
References: <20210304163140.543171-1-peterx@redhat.com>
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
index e7dc9f813..0cd426a8a 100644
--- a/man2/userfaultfd.2
+++ b/man2/userfaultfd.2
@@ -77,6 +77,13 @@ When the last file descriptor referring to a userfaultfd object is closed,
 all memory ranges that were registered with the object are unregistered
 and unread events are flushed.
 .\"
+.PP
+Since Linux 4.14, userfaultfd page fault message can selectively embed faulting
+thread ID information into the fault message.  One needs to enable this feature
+explicitly using the
+.BR UFFD_FEATURE_THREAD_ID
+feature bit when initializing the userfaultfd context.  By default, thread ID
+reporting is diabled.
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

