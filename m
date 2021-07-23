Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9238F3D4224
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 23:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhGWUnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 16:43:33 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:42961 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWUnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 16:43:32 -0400
Received: by mail-pj1-f48.google.com with SMTP id hg12-20020a17090b300cb02901736d9d2218so5503312pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 14:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D8hQBeaoequ2VeZt1HMpI/iwIuKHizt998L9/9iuhBk=;
        b=fIL6p0SaGA7k4EqnXlw2CTNdqmmnDJQhf7mhbHvfnpCXvX6HLiVJckLLCP4pqwx+Bl
         d5rJZWVRE4cZsyo3wXv0oq1e1LpL7B/daEJTiTTfqnsaCL838Bz5hzuBZ2s2P4orFS7A
         xHxDHW9QuACMj1d/K7D5F0vSR4PIxliSky/c7g1oPpulDgNaufd6b9t/JUywvwOs6HOG
         ELXOaafgNyt2sxFS57Hil3AhSKR01oNJZZJZloHpFBlVTvMe99nC0+QMBTqW4qdsh/bl
         4jHzxltho02DIVGPTwSK2rhMX6GU04bIefN9xBca39g1h3oE0ZtdIqy+eKiI4VQqtbu+
         co9A==
X-Gm-Message-State: AOAM532X7MZ7VD5wdrmtI+ef2wr23vyMJK2UrCmDXcAqlbAPBSEp1cYj
        UKPYiKdWmGGfSxGLDULJa8A=
X-Google-Smtp-Source: ABdhPJzK7cl/8KTDmb81BDEMtYJQmgxyxmx1xVfuTxXUA2kMq5sbIE5qcKB2POtpnykZu5eyxoznsw==
X-Received: by 2002:a63:5652:: with SMTP id g18mr6634626pgm.178.1627075444293;
        Fri, 23 Jul 2021 14:24:04 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:db72:85bb:463f:5c41])
        by smtp.gmail.com with ESMTPSA id w16sm39854011pgi.41.2021.07.23.14.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 14:24:03 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/4] configfs: Rework the overflow check in fill_write_buffer()
Date:   Fri, 23 Jul 2021 14:23:50 -0700
Message-Id: <20210723212353.896343-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
In-Reply-To: <20210723212353.896343-1-bvanassche@acm.org>
References: <20210723212353.896343-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 'if (SIMPLE_ATTR_SIZE - 1 - pos <= 0)' into
'if (pos >= SIMPLE_ATTR_SIZE - 1)'. Change the data type of 'to_copy'
from long long (loff_t) into int. Do not check whether pos < 0 since
rw_verify_area() checks this for us. As one can see on
https://lore.kernel.org/lkml/CAHk-=wjuDBQdUvaO=XaptgmvE_qeg_EuZjsUZf2vVoXPUMgAvg@mail.gmail.com/
these changes have been requested by Linus Torvalds.

Cc: Bodo Stroesser <bostroesser@gmail.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Yanko Kaneti <yaneti@declera.com>
Cc: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/configfs/file.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/configfs/file.c b/fs/configfs/file.c
index 5a0be9985bae..8121bb1b2121 100644
--- a/fs/configfs/file.c
+++ b/fs/configfs/file.c
@@ -181,8 +181,7 @@ static ssize_t configfs_bin_read_iter(struct kiocb *iocb, struct iov_iter *to)
 static int fill_write_buffer(struct configfs_buffer *buffer, loff_t pos,
 			     struct iov_iter *from)
 {
-	loff_t to_copy;
-	int copied;
+	int to_copy, copied;
 	u8 *to;
 
 	if (!buffer->page)
@@ -190,9 +189,9 @@ static int fill_write_buffer(struct configfs_buffer *buffer, loff_t pos,
 	if (!buffer->page)
 		return -ENOMEM;
 
-	to_copy = SIMPLE_ATTR_SIZE - 1 - pos;
-	if (to_copy <= 0)
+	if (pos >= SIMPLE_ATTR_SIZE - 1)
 		return 0;
+	to_copy = SIMPLE_ATTR_SIZE - 1 - pos;
 	to = buffer->page + pos;
 	copied = copy_from_iter(to, to_copy, from);
 	buffer->needs_read_fill = 1;
