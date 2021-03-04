Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9E632D7E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237955AbhCDQd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:33:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24953 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237837AbhCDQdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614875511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L+ETSEf1ZAFUSggoPbuwMmKsXjA8FmosFmIyKB/HpBM=;
        b=imRIUmetSzXFWRWo+AvHzeskhoH5oMcqGZ8eXqMoaadmV0N9JW7RcJK7bYvsk4hCZaHs3l
        J05ohUBIBVvi1jqYg9dzmb4fTRGjzHZlQFiXmlXtG9W9maSzoZlopYqO2yvcHCxEfKJCeb
        rQ4SVFL+77bB4f6SVmNDdYS+r+65qDY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-m8yrXV9YOZaLaYa10TOeSA-1; Thu, 04 Mar 2021 11:31:49 -0500
X-MC-Unique: m8yrXV9YOZaLaYa10TOeSA-1
Received: by mail-qv1-f72.google.com with SMTP id i1so10423360qvu.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 08:31:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L+ETSEf1ZAFUSggoPbuwMmKsXjA8FmosFmIyKB/HpBM=;
        b=erHgmnT9dJGKwbV7Efbwi8qc3iiXnlTVUeFLjMw9NLbwcTRBfxe3vlCchTEUc68pWG
         yFzFKVKc13aVJ06Fb5WPzFayWqFg1ByPs+F3omqWKrYuRwZyn32VszFIFejzA4qJh5GJ
         aJduFEModPzIaSBSTAVvsQEWJpYSGG9UyMEBJ51Zv/E58hC1fT/uRwWQQ5fGNJTxnaC3
         aP46vhPXnM0YlZnmz4kbhq5kIny6RkT79AG/8tir21rdTfSMc7r8FWT4b0BNtUvcREK4
         2jzdYjt8/60OCXpTrgERT0UC1IzAEjXh0bhmJhJbzp+MTdlqXD+lwHIJ8mVkdMIUHrvJ
         vtVQ==
X-Gm-Message-State: AOAM533sX5B+UlYnW+R9RUeEIuH3Z8ZJ4e6lGpfV33AF6gj5fsAoyJ5B
        WYnZ2AnigQjl4LUyEm/LmcN/x/ZJdq7TvuStPbNAOqIfgSSprwAjZIZYTw9szto8gGQTlL2oMLo
        ow5lxGNJuQjDlbc3NZHmk5Yrq
X-Received: by 2002:a05:6214:1424:: with SMTP id o4mr4686692qvx.34.1614875509282;
        Thu, 04 Mar 2021 08:31:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZVGrykbdTHTsJvMYciYnspUzYH+GMDJvtLzn0b2/AnSBx/ccJd5RUBv4+cALIgTK9I6Wcag==
X-Received: by 2002:a05:6214:1424:: with SMTP id o4mr4686678qvx.34.1614875509092;
        Thu, 04 Mar 2021 08:31:49 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id r2sm51753qti.4.2021.03.04.08.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 08:31:48 -0800 (PST)
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
Subject: [PATCH v2 3/4] ioctl_userfaultfd.2: Add UFFD_FEATURE_THREAD_ID docs
Date:   Thu,  4 Mar 2021 11:31:39 -0500
Message-Id: <20210304163140.543171-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210304163140.543171-1-peterx@redhat.com>
References: <20210304163140.543171-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFFD_FEATURE_THREAD_ID is supported in Linux 4.14.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 man2/ioctl_userfaultfd.2 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
index 47ae5f473..b58983fe7 100644
--- a/man2/ioctl_userfaultfd.2
+++ b/man2/ioctl_userfaultfd.2
@@ -208,6 +208,11 @@ signal will be sent to the faulting process.
 Applications using this
 feature will not require the use of a userfaultfd monitor for processing
 memory accesses to the regions registered with userfaultfd.
+.TP
+.BR UFFD_FEATURE_THREAD_ID " (since Linux 4.14)"
+If this feature bit is set,
+.I uffd_msg.pagefault.feat.ptid
+Will be set to the faulted thread ID for each page fault message.
 .PP
 The returned
 .I ioctls
-- 
2.26.2

