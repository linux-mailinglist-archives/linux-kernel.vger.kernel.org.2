Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1382C3100BE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 00:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhBDXao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 18:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhBDXa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 18:30:28 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2F2C0617A9
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 15:30:13 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id 70so4156448qkh.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 15:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=+DMZQSm/uaEUXJw9EFN7NIYygzQ6mIPslbKoTBQUvsQ=;
        b=WiPF6RbkD/Zm7dcNkPvnl02p57tzN9cu7c9cNHJG1mmc9lGt7Z0/nB7zndD/gk4np6
         K7Knd7DIOUPQQKVSo9sQT1kQ1Ggydy/VBFeXlwnNaJHBtZCBXhaxCn6ealEFq/igVY0e
         mVLER0rjGQAI9zK3qxTZJc5fv57Y9+vjW+ARS+hfIuFhBgTxQUezL7XmkIJxjWBMUKav
         E1jdUPerE/x4HE1ZuHvkOzho9FTcCj5dK3y8OwL3yR6WyZRLcwRUrWTwLIu/qP4ha47n
         +PlyqcV1VXzedm4o4MT5Ss2bGyDATHCeszcD7hdlBC5vzDHxIPBbNrCayImbF5uwe1r4
         QWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=+DMZQSm/uaEUXJw9EFN7NIYygzQ6mIPslbKoTBQUvsQ=;
        b=Qc70NchfDJliHUhp63KlxlVS6uDw5z+l1gSNIOCJFhWZXHOkhsIwWu1v1UwHyx2XbN
         DbqBu0YXChyy/1R76pKRs8l/xZfc6MttwB7xNXLzCmpTxFeKvWlWHKhwzLb9/C9hBYbn
         A7FnOuJ3Nu+m93AVS3/k0xKE27/FymSR3ZeWLScx5pVqo+Ssr1chll8NnL3++T6M8wlt
         7o9FKWwPe7zziW66qLK6iZ8rYRTMcEewAH8XVbCO13GO9W1AgzPnC0q/RHgfdkLiOOPV
         Yx6AziRqVnV1XeBIADG6kzoPUnNrjyiG9YFI7oVamvShmD91Pn65PwH+Vm0lpKT5EkWn
         E2lw==
X-Gm-Message-State: AOAM531OCnV8jg9c9APU8DBotk0Xa8QzM9sSI6UQGbmu2nP5ynsGEvMT
        fKoXgNevJ804VNIUeNg/5eiubU9AjTj1jwyV8A==
X-Google-Smtp-Source: ABdhPJx3kg9I/fA5bBDYRFvfPdVTeyCfD6xE3qxRlCYQfUGKmYYfcWiSsJ3nZEdsX8iZC/R5fjsrlL6fZPjSx22Y7g==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:ad4:5be9:: with SMTP id
 k9mr1715632qvc.18.1612481412377; Thu, 04 Feb 2021 15:30:12 -0800 (PST)
Date:   Thu,  4 Feb 2021 23:28:50 +0000
In-Reply-To: <20210204232854.451676-1-kaleshsingh@google.com>
Message-Id: <20210204232854.451676-2-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20210204232854.451676-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 2/2] dmabuf: Add dmabuf inode number to /proc/*/fdinfo
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     jannh@google.com, jeffv@google.com, keescook@chromium.org,
        surenb@google.com, minchan@kernel.org, hridya@google.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a FD refers to a DMA buffer add the DMA buffer inode number to
/proc/<pid>/fdinfo/<FD> and /proc/<pid>/task/<tid>/fdindo/<FD>.

The dmabuf inode number allows userspace to uniquely identify the buffer
and avoids a dependency on /proc/<pid>/fd/* when accounting per-process
DMA buffer sizes.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v2: 
  - Update patch desciption

 drivers/dma-buf/dma-buf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 9ad6397aaa97..d869099ede83 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -414,6 +414,7 @@ static void dma_buf_show_fdinfo(struct seq_file *m, struct file *file)
 {
 	struct dma_buf *dmabuf = file->private_data;
 
+	seq_printf(m, "dmabuf_inode_no:\t%lu\n", file_inode(file)->i_ino);
 	seq_printf(m, "size:\t%zu\n", dmabuf->size);
 	/* Don't count the temporary reference taken inside procfs seq_show */
 	seq_printf(m, "count:\t%ld\n", file_count(dmabuf->file) - 1);
-- 
2.30.0.365.g02bc693789-goog

