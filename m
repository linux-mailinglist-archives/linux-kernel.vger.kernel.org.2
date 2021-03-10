Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C03334B84
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhCJWXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:23:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54681 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232087AbhCJWXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:23:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615414990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BRu817/U099Z69O52DlP7850OjT0QzngDMzivy9vMy0=;
        b=ibuTy9AHpOKKN38E4w/p/xJukQnqjAAnblFI2gv+BS2LWi03AwVI089W35lLOf1BUPCaK8
        X9qlpaUXypze1ggvSpGTYRk7mH6JyR5fVkDv1U8+bcu0onbQI5A9qQain+jLPdeVzRbDIM
        Oc2sQBSftUvm+DToSuzk+/0FMza6yC4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-UVYYa-DrPTG0kTqiDJdv-A-1; Wed, 10 Mar 2021 17:23:06 -0500
X-MC-Unique: UVYYa-DrPTG0kTqiDJdv-A-1
Received: by mail-qk1-f198.google.com with SMTP id x11so10739932qki.22
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BRu817/U099Z69O52DlP7850OjT0QzngDMzivy9vMy0=;
        b=DP2DGgXTNlTXSJYzVB152B6RUbbmvOKC/wIiaG6xOI8J+DBJ9nUkCMGfMtLf1waLR3
         wh/1owQAsc32SO3Z3C7n+fzqCKBvqlt3FQJmQTImR0yhm3lahG1IXrh0PVBkAML+aY3E
         qVrX4z/m83RUOWucie/Ivwd5axcxlqR+i/w/INdPsTJo7xcuk29ul8kN2bjA5OMOQQBF
         AVPqciSFit5C4DvHOSbGMBjOsn8AvKMq1DAZHGlmv1psV+ywzufgsaXdi4tcmL54JBjD
         BuuW4IxYos0yi1jXxk9D1GTdq6qDv7hkgL+N96/wvmcayZd712KYFc8IOMkku8Iz4WH9
         Vh/w==
X-Gm-Message-State: AOAM530ngaug9omko1NTP3wo1ioBVZ7o5srb1MkmyBXqg+NJz3lfaBcT
        lMh1dEJwhw8NMHD+30dxU+0VgBxAhFGHI7wNU5vizfrwYFIaQBMvtGS7AKnSGcjlOA0iW2u5jV0
        6UfwDTucnWMTk6tEtDdZ8k7hz
X-Received: by 2002:a05:620a:4152:: with SMTP id k18mr4904295qko.446.1615414985965;
        Wed, 10 Mar 2021 14:23:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxxuNaJloek+uHlF7/E1VLGZKWPpzK7JbQICS1D+PzN2odRmmYut602LIp0SFoC6bEVdMPnNg==
X-Received: by 2002:a05:620a:4152:: with SMTP id k18mr4904283qko.446.1615414985770;
        Wed, 10 Mar 2021 14:23:05 -0800 (PST)
Received: from xz-x1.redhat.com ([142.126.89.138])
        by smtp.gmail.com with ESMTPSA id e18sm451364qtr.52.2021.03.10.14.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:23:05 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-man@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v3 3/4] ioctl_userfaultfd.2: Add UFFD_FEATURE_THREAD_ID docs
Date:   Wed, 10 Mar 2021 17:22:59 -0500
Message-Id: <20210310222300.200054-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210310222300.200054-1-peterx@redhat.com>
References: <20210310222300.200054-1-peterx@redhat.com>
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
index 47ae5f473..d4a8375b8 100644
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
+will be set to the faulted thread ID for each page fault message.
 .PP
 The returned
 .I ioctls
-- 
2.26.2

