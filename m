Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C105408A03
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbhIMLVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239479AbhIMLVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:21:44 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF366C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:20:26 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso6204471pjq.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yLjr+ON7k0bwQgm5TdMvQnLT7Btp738r3GnFnWQAfuc=;
        b=cZ8lEfRdEpXS7gjJQd8xampwtoq03dUQUeniIUOe9cENQG1e5TRxsOUjxFokQXyX1Y
         K9HyyWhTo7MVFrQKMXf1/3d9HMiRaBYf0nrX4wscKEpV6aJnG5nzVhXEQJvWBF6ge+9v
         jLMLIb5+Ee6q+lpnBVOzfzXBDrRQ2YxGXib98tIuVQYbYQGUHJ2Z4gPrq+a4eX4ZrU09
         xc8DP5DTLjDFSVc7lftmhcJp6TJWrqyNAZTmJYPCH8Lgpi7/z82T5cDz/i0VkHtEsLq9
         gzgOo++caroFWo68txHxHmjoUia4xq62n7MteqxfofIrSNPGdHbCJOpF2od6wPmqcr/V
         tfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yLjr+ON7k0bwQgm5TdMvQnLT7Btp738r3GnFnWQAfuc=;
        b=XXaWVxZVA0zbA11Lx386Kg7r49TVTF9vbiRp5lcq3TNSuBiDidigcGY/Cq9Q18AHFv
         paLGEQHDT0uzvM2PBkyvfuWd/OAFJQP8APP6+phWhUiWFfn8e3T4WcclG5WRJHpnCYVd
         QOFkgTnDpC0OHR2BgK4cjL5fj1N4FF3u9Vb4X1nbh/OMknAVbQV8sDVBJb4JEDUVDOH3
         tr6Z3sHwnjiSDspEvc1zBLzgVOOb+2Wnfht/PDMbSSUn+ZBgQJtN088mXKseuu5IxvaQ
         OXIpuIH5lAuXBB0POuakowYMdz3rOCZ/Wu47thXtQ8MpwAfaKl8ULnDi5A92SdKkXTLb
         V6+A==
X-Gm-Message-State: AOAM533tOkPoKi8yo+L3Y4FpwJ9YBWiJS/5pez8ZWeWzy9t7HV3MmfUO
        DZH/EQIn8dYH0ioL/1pZBsZR
X-Google-Smtp-Source: ABdhPJz/Loi9cSCUl6C0Ef1+euUAbXj01k2QPiOb4FmVndB7/grfYcjsH6Hrv1QQmicoBd+qXAs5Rw==
X-Received: by 2002:a17:902:bd42:b0:138:d3ca:c387 with SMTP id b2-20020a170902bd4200b00138d3cac387mr10047479plx.51.1631532026231;
        Mon, 13 Sep 2021 04:20:26 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id x10sm1758671pjv.57.2021.09.13.04.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 04:20:25 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     bcrl@kvack.org, viro@zeniv.linux.org.uk, tglx@linutronix.de,
        axboe@kernel.dk
Cc:     linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] aio: Fix incorrect usage of eventfd_signal_allowed()
Date:   Mon, 13 Sep 2021 19:19:28 +0800
Message-Id: <20210913111928.98-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should defer eventfd_signal() to the workqueue when
eventfd_signal_allowed() return false rather than return
true.

Fixes: b542e383d8c0 ("eventfd: Make signal recursion protection a task bit")
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 fs/aio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index 51b08ab01dff..8822e3ed4566 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1695,7 +1695,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		list_del(&iocb->ki_list);
 		iocb->ki_res.res = mangle_poll(mask);
 		req->done = true;
-		if (iocb->ki_eventfd && eventfd_signal_allowed()) {
+		if (iocb->ki_eventfd && !eventfd_signal_allowed()) {
 			iocb = NULL;
 			INIT_WORK(&req->work, aio_poll_put_work);
 			schedule_work(&req->work);
-- 
2.11.0

