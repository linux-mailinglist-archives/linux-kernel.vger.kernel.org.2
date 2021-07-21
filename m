Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CB03D0E43
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbhGULQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:16:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31246 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239809AbhGULHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 07:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626868059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1ITgdpbHrkG/PyamO/WTSqphxRqKor6geSRI8hUKktg=;
        b=RcEOeVnu4gPCGlDZBf5pCFdTcr4QCKDx/rxAZxBFZzQBiEkL0dCoAFIPjecTcUNq2Bv+cN
        R/Y7RT2dJqgcQ0VW+e2xZ1Ihlt4BPNfvDj1E5aOrcB9nKWTOZHulmCM++jeZuaA8jSBg7o
        ZNcBteGU5m05qZB/Hu9dXQKAv5raISQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-Ie5tPRBVMKyDZFvfEhZLZQ-1; Wed, 21 Jul 2021 07:47:38 -0400
X-MC-Unique: Ie5tPRBVMKyDZFvfEhZLZQ-1
Received: by mail-wr1-f70.google.com with SMTP id h15-20020adffd4f0000b0290137e68ed637so888813wrs.22
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 04:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ITgdpbHrkG/PyamO/WTSqphxRqKor6geSRI8hUKktg=;
        b=LfegSGvQs5+qrhFkkNLKWL4bn4d+MLgvF02xNkb6b8olHvLpciH+Nrcp5c7d8REOII
         kDj95qyPSnWidTW4ITB7YCgiarYghZvuQGx5pIyh1vf5iXaZb0rGlxids/eKXIQ+abqU
         KBWJtilxXWTw0bme6NfxB4bkSJk22vXqyUjC7mFlAj0TCrBhzAKqihzH12gxdvZ4jFf6
         gBrTD4w6NEpb73uUsh+0m2h2CVf6bmrBUbOyqrXW9i3oP+8Z9dJmZaXbNS4Im7osKVPp
         7RfEdubrep5IP4ROXlHph3smnGWXB247vqJ7HHFS/9EhjPgfyz2U8CC6kEM/X5whUHu1
         mVvg==
X-Gm-Message-State: AOAM532NRRJ0y/EsfNuSRKYnWXhFKi3D+4egBjfeQGPi0ozPIE+Xyet0
        yvE8kS/jI1YK9K8x9XMchAMmqQrF8IlPIwU4tutjwiIuCbUYVoxKXFRVVBTzet6A8g3oGDRauuQ
        sl1VOVPlNXh8ceM98J4v+ju2B
X-Received: by 2002:a5d:46d1:: with SMTP id g17mr42856184wrs.2.1626868056880;
        Wed, 21 Jul 2021 04:47:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJJTHhJT5SbgMJ3Y0QXm1zLjqie/kZGfgz0cBlpMwooT1VD7jk3zd3oSXFb1L3mlFd4Fj5eg==
X-Received: by 2002:a5d:46d1:: with SMTP id g17mr42856177wrs.2.1626868056704;
        Wed, 21 Jul 2021 04:47:36 -0700 (PDT)
Received: from vian.redhat.com ([79.116.5.179])
        by smtp.gmail.com with ESMTPSA id b16sm28142037wrs.51.2021.07.21.04.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 04:47:36 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH] ftrace: Avoid synchronize_rcu_tasks_rude() call when not necessary
Date:   Wed, 21 Jul 2021 13:47:26 +0200
Message-Id: <20210721114726.1545103-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

synchronize_rcu_tasks_rude() triggers IPIs and forces rescheduling on
all CPUs. It is a costly operation and, when targeting nohz_full CPUs,
very disrupting (hence the name). So avoid calling it when 'old_hash'
doesn't need to be freed.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 kernel/trace/ftrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index e6fb3e6e1ffc..4fbcf560dd03 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5985,7 +5985,8 @@ ftrace_graph_release(struct inode *inode, struct file *file)
 		 * infrastructure to do the synchronization, thus we must do it
 		 * ourselves.
 		 */
-		synchronize_rcu_tasks_rude();
+		if (old_hash != EMPTY_HASH)
+			synchronize_rcu_tasks_rude();
 
 		free_ftrace_hash(old_hash);
 	}
-- 
2.31.1

