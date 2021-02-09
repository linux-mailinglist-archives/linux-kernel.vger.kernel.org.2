Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE69314BB1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhBIJe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhBIJbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:31:51 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC23BC061793
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 01:31:06 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id r23so19526101ljh.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 01:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YGfx+ZbDu86vZQD75mCzB5kXeonKILSK69FKueYFxNY=;
        b=G3mEgdQ0cCDxm3nT8KZdSnjzWUDikid3d2LaHa2YnKgQjp5gTt5fTXGMk0zKAlglWd
         C8hE6GEq3CXOIppwyVkYStj1PiaCiqaOujxGDicrfTKf2umDLOfJ+T4sDpZcVjcefNCc
         2VRbdImDhA3YlBWmEAzSSm6hbtmcaImT3OqVZib9bKkzLQn+s1+pXK4/cHxMLhdDI10O
         fMwsw58vUehaH6c5Lx51KVdUi+kczlHMkUAT3B1W29WMYY9gNWsw/dmFzZ5fZh6Cuax9
         Cz5XcnX11C7X3uC4InAwEkm3omhoN2KPoEAVFebHzNzLKi4hQOaYSkqG1GecpY0O7xrv
         8t0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YGfx+ZbDu86vZQD75mCzB5kXeonKILSK69FKueYFxNY=;
        b=fMR0UanXt7itydDjjJ8uO4OvkbDjs9+o38orSoUVJGhPYRuDkh4gWw50c1DpMUZV6q
         00yVCExrx9MNv3kTe7Uckct5yV3B2urwg0fEpjgtj0vrx0CQmFCOIVn/QBfe0K9SzZ2e
         WuKXjYZpXQ3p2kwiwYp/PZHao7oXzUtmq5jSNIWJe5R8sMyiDWDFIaoh5x+1gNhP8Dmo
         YTnjvsXS1sggzwDBOryWvHAQoBwd21r4Hg2UFjOZM0IweGEqsDS444ChjIJgtYpanTYb
         fH+l4+vWSqY7KVeBq5C2OdIX2xnYiMlhRta4jF2BJMRqyqIzxeVHKHdlNvAWZ0YX+9oO
         Orpw==
X-Gm-Message-State: AOAM530QHu7A5Znbm6pdOh64hn3YInqm1rZjRm3huKQm5et7m0NhVnC9
        kIxS0vKor+jvsi5idqLgB2O1bGwiUnC0+NOC
X-Google-Smtp-Source: ABdhPJy56HyeG4ESdIL1QSwpxxZcNmxJxbHhAxKh61PMNNuMuQRN8NnTeAcqQ9SDVvxdjw7HydYseQ==
X-Received: by 2002:a2e:9d84:: with SMTP id c4mr13437060ljj.247.1612863065471;
        Tue, 09 Feb 2021 01:31:05 -0800 (PST)
Received: from localhost.localdomain ([146.158.65.228])
        by smtp.googlemail.com with ESMTPSA id r76sm982859lff.207.2021.02.09.01.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 01:31:04 -0800 (PST)
From:   Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     alex.dewar90@gmail.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, snovitoll@gmail.com,
        syzbot+15ec7391f3d6a1a7cc7d@syzkaller.appspotmail.com
Subject: [PATCH v2] drivers/misc/vmw_vmci: restrict too big queue size in
Date:   Tue,  9 Feb 2021 15:31:01 +0600
Message-Id: <20210209093101.2097627-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YCJKIVhNS4N4glUa@kroah.com>
References: <YCJKIVhNS4N4glUa@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot found WARNING in qp_broker_alloc[1] in qp_host_alloc_queue()
when num_pages is 0x100001, giving queue_size + queue_page_size
bigger than KMALLOC_MAX_SIZE for kzalloc(), resulting order >= MAX_ORDER
condition.

queue_size + queue_page_size=0x8000d8, where KMALLOC_MAX_SIZE=0x400000.

Reported-by: syzbot+15ec7391f3d6a1a7cc7d@syzkaller.appspotmail.com
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
>As this is controllable by userspace, you just provided a way to flood
>the kernel logs.
>
>Please make this a dev_dbg() call instead, if you really want to see it.
>Otherwise just return NULL, no need to report anything, right?

Thanks, removed pr_warn().

v2: Removed pr_warn() to avoid flood from user-space
---
 drivers/misc/vmw_vmci/vmci_queue_pair.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
index f6af406fda80..ea16df73cde0 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -538,9 +538,7 @@ static struct vmci_queue *qp_host_alloc_queue(u64 size)
 	queue_page_size = num_pages * sizeof(*queue->kernel_if->u.h.page);
 
 	if (queue_size + queue_page_size > KMALLOC_MAX_SIZE) {
-		pr_warn("too big queue to allocate\n");
 		return NULL;
-	}
 
 	queue = kzalloc(queue_size + queue_page_size, GFP_KERNEL);
 	if (queue) {
-- 
2.25.1

