Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0579F3558C0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 18:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346176AbhDFQEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 12:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238586AbhDFQEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:04:47 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE85C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 09:04:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id o19so17245911edc.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 09:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y9UWeHSBoySzTHkOgKQzF5RiGebYchxO96+3Wf+rxXc=;
        b=Xa3fFCTQCoUijqu6po9q3HjZRjXP27V6wL5ACYsFzPZbcSqjqqMU1RIM6ZZ7fDYhUg
         inNmTU5i2JKGLgCVpqGzf5vmZ/SiLojWM338IOj+7vCfJ+o2ibNViO+2xg+rTQaCXNW6
         n7jmS0tPAe4YlLmXaDge4BF8Tkua+GP0ZnJGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y9UWeHSBoySzTHkOgKQzF5RiGebYchxO96+3Wf+rxXc=;
        b=BnNsgovvpm6iU8IKAFcP/R2mCdyAaRm43yy6f/Hz4OyqT7ARba9zgwE6z/DBa5OOZL
         eStsUobrWzEbsiA065o/ReA884Uv5ELBgiDPxzJ06jGOrz2BnvRWOxF1VnYDEP2zU/eE
         WJYYBOUxUo9MGtu209M1uPg9EtfH/7Ozm0ZIir4Zmy4SpYj3/cxQWrBVxM0EiP9XRiv2
         M1VjV5ZNmJ9cVQvw3ovbb03LkDLNry4Iy0GE5QnxABIvjp1n7Hmghf+FmC00pJXjOi+z
         +3bQtk1RGxAbJJrW3myxIagUbRgd32j62Oa+Wnrl5GheHWLgO9F2wZjLlCF3t87hvE77
         kS1A==
X-Gm-Message-State: AOAM533iiOLgLOOj8/YnpdrLxdhM7knDVQn0kajatIVbema0/lDgArGt
        8IUOe3xbkrdvdGQVLeFN8lRFUw==
X-Google-Smtp-Source: ABdhPJyP6fqRB9nYYchphWa0F5/357LF8RkkaedmGdLVe2OQDDAEKML5Y1zJxywfpsUsfk80MJzHpA==
X-Received: by 2002:a05:6402:c:: with SMTP id d12mr38059165edu.100.1617725078058;
        Tue, 06 Apr 2021 09:04:38 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id hz24sm6411140ejc.119.2021.04.06.09.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 09:04:37 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
Subject: [PATCH RESEND] lib/scatterlist: Fix NULL pointer deference
Date:   Tue,  6 Apr 2021 18:04:35 +0200
Message-Id: <20210406160435.206115-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sg_alloc_table_from_pages is called with n_pages = 0, we write in a
non-allocated page. Fix it by checking early the error condition.

[    7.666801] BUG: kernel NULL pointer dereference, address: 0000000000000010
[    7.667487] #PF: supervisor read access in kernel mode
[    7.667970] #PF: error_code(0x0000) - not-present page
[    7.668448] PGD 0 P4D 0
[    7.668690] Oops: 0000 [#1] SMP NOPTI
[    7.669037] CPU: 0 PID: 184 Comm: modprobe Not tainted 5.11.0+ #2
[    7.669606] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
[    7.670378] RIP: 0010:__sg_alloc_table_from_pages+0x2c5/0x4a0
[    7.670924] Code: c9 01 48 c7 40 08 00 00 00 00 48 89 08 8b 47 0c 41 8d 44 00 ff 89 47 0c 48 81 fa 00 f0 ff ff 0f 87 d4 01 00 00 49 8b 16 89 d8 <4a> 8b 74 fd 00 4c 89 d1 44 29 f8 c1 e0 0c 44 29 d8 4c 39 d0 48 0f
[    7.672643] RSP: 0018:ffffba1e8028fb30 EFLAGS: 00010287
[    7.673133] RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000002
[    7.673791] RDX: 0000000000000002 RSI: ffffffffada6d0ba RDI: ffff9afe01fff820
[    7.674448] RBP: 0000000000000010 R08: 0000000000000001 R09: 0000000000000001
[    7.675100] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[    7.675754] R13: 00000000fffff000 R14: ffff9afe01fff800 R15: 0000000000000000
[    7.676409] FS:  00007fb0f448f540(0000) GS:ffff9afe07a00000(0000) knlGS:0000000000000000
[    7.677151] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.677681] CR2: 0000000000000010 CR3: 0000000002184001 CR4: 0000000000370ef0
[    7.678342] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    7.679019] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    7.680349] Call Trace:
[    7.680605]  ? device_add+0x146/0x810
[    7.681021]  sg_alloc_table_from_pages+0x11/0x30
[    7.681511]  vb2_dma_sg_alloc+0x162/0x280 [videobuf2_dma_sg]

Cc: stable@vger.kernel.org
Fixes: efc42bc98058 ("scatterlist: add sg_alloc_table_from_pages function")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 lib/scatterlist.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index a59778946404..1e83b6a3d930 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -435,6 +435,9 @@ struct scatterlist *__sg_alloc_table_from_pages(struct sg_table *sgt,
 	unsigned int added_nents = 0;
 	struct scatterlist *s = prv;
 
+	if (n_pages == 0)
+		return ERR_PTR(-EINVAL);
+
 	/*
 	 * The algorithm below requires max_segment to be aligned to PAGE_SIZE
 	 * otherwise it can overshoot.
-- 
2.31.0.208.g409f899ff0-goog

