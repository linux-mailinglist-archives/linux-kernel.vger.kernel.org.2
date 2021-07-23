Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB43B3D4225
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 23:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhGWUne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 16:43:34 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:45586 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhGWUnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 16:43:33 -0400
Received: by mail-pl1-f176.google.com with SMTP id k1so4460334plt.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 14:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wQEW1Zu14b+R7FeuiGiNcVClEU9cUjB1xm2SO1PApJ0=;
        b=bE5kHy6pCpkbEMCDun6XIJFWVJXw1g3eRI7yWw9DDNpEjGMaFPHsk+xOwNQEeCHEL+
         6B+5u4eUo+THOc+nJ68Bs0MPV6K5/R6T/v60t5BgC9ALZiveIdBO4aodn1A1KIgEBAjM
         l77lCH/BBimBLRHYreSmH+4uJ86k4QPZ866NAbVQJ3buqaXxF1D3ARrqbyyF1NnA7VDR
         MDe5XrgCO1Om9f+ztTnYVGUHEzD2NQF4jeyKbRDZdtkeuB4NKhivUdb6WhDjZOQ0vOr7
         A8EZLO22+uLV2QZTckJNoo9oxj+P6U0yKdrZkzCr2Bj8ujFCnX+pUsU1aRrZP11G7ktM
         sqIQ==
X-Gm-Message-State: AOAM5327EH3LfpmZm4T3YkFLCrGd05TMtJGEdZmQSQMl7OK6CfPuv6BU
        mBFF498r8+4KzbFz4js5a8k=
X-Google-Smtp-Source: ABdhPJxQ7to+PMwM4SGvbgIrMFZQJSm4cLGLk2S1xuURErYUjrUtQoNZUrA7uPT69qKUHSw4UDR8Bw==
X-Received: by 2002:a62:e90f:0:b029:307:8154:9ff7 with SMTP id j15-20020a62e90f0000b029030781549ff7mr6170833pfh.79.1627075445743;
        Fri, 23 Jul 2021 14:24:05 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:db72:85bb:463f:5c41])
        by smtp.gmail.com with ESMTPSA id w16sm39854011pgi.41.2021.07.23.14.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 14:24:05 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 2/4] configfs: Fix writing at a non-zero offset
Date:   Fri, 23 Jul 2021 14:23:51 -0700
Message-Id: <20210723212353.896343-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
In-Reply-To: <20210723212353.896343-1-bvanassche@acm.org>
References: <20210723212353.896343-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store data at the right offset when writing with a non-zero offset. I think
this patch fixes behavior introduced in the initial configfs commit. From a
source code comment in the initial configfs commit: "There is no easy way
for us to know if userspace is only doing a partial write, so we don't
support them."

Cc: Bodo Stroesser <bostroesser@gmail.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Yanko Kaneti <yaneti@declera.com>
Cc: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/configfs/file.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/configfs/file.c b/fs/configfs/file.c
index 8121bb1b2121..3b2ddc2e5d42 100644
--- a/fs/configfs/file.c
+++ b/fs/configfs/file.c
@@ -226,14 +226,16 @@ static ssize_t configfs_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct configfs_buffer *buffer = file->private_data;
-	ssize_t len;
+	int len, written = 0;
 
 	mutex_lock(&buffer->mutex);
 	len = fill_write_buffer(buffer, iocb->ki_pos, from);
 	if (len > 0)
-		len = flush_write_buffer(file, buffer, len);
-	if (len > 0)
-		iocb->ki_pos += len;
+		written = flush_write_buffer(file, buffer, iocb->ki_pos + len);
+	if (written > 0) {
+		len = max_t(int, 0, written - iocb->ki_pos);
+		iocb->ki_pos = written;
+	}
 	mutex_unlock(&buffer->mutex);
 	return len;
 }
