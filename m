Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8394043D76B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 01:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhJ0XUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 19:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhJ0XUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 19:20:35 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D2EC061745
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 16:18:09 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id gt5-20020a17090af2c500b001a218bb02b0so4472258pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 16:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UqOACvA/GAkBlx6nI88hGu6zlyCJ7sQcYLTjddCacic=;
        b=qIJBnjiVYU+VbQ9QVyiZwIzZ4VV1R58qP7+8LI2fJOCdwSO6LQdnY2JohZX+a56DQV
         Uj0jTqY+BagZiJoclE3pFYBTvkiaU008xsdPlruovpG0WDRKldh5SXu6TpFCJXxzj4c0
         iTZcH3PqZsOSAYgJEVT5GTrwL2Ey+DIFNPDSdahqmJ5U2dWcQn3Oe2YPhriazosUi/uT
         IkQo+m7VieGPdrUFJ4q3sS8LwhtB6WE6w+iyt5Okd29h/BOrbS0zoUmtmGRaC7xbHka2
         tUYZT+mcAO7JhUjijw5DVp3W8rOryaw2Sh7P2/Pa4g64hjrYtkN7iczxtHUM2hLQrmvE
         AKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UqOACvA/GAkBlx6nI88hGu6zlyCJ7sQcYLTjddCacic=;
        b=kwVa2eEPOP1jamXg5o0OHRsx+/meXBbxQtfsI1xImajvdPbeIGD/Ki6S5myFrESJ+t
         KnMwI+TTUjoHBvuKK6wNGDC+5CfbvgJyumDxIUpLsjG5bzzbokC8/98bcmzjczhqGazR
         yRoW65XZ9WEvtt0fy+nbUW5NNK+8zxuLNoViG7IHBvD+2QU+6A7SKqrpmedI3cZBge5F
         5QRIbSFB43GVJg9WktgWJU8Ixvf0ot2qS56eePIqoaE6tOyaW/2SosJFzmhXB+cBNHJs
         JP9a/Vjcl6oEnZa/xZvJZKrclIQIJECxxKmrtgdgdtwYFq6Ztki4y58pqFQDS87w2z/c
         yByQ==
X-Gm-Message-State: AOAM530u3iSA8yZLHtI8AJDv5leq1Oo2t+l+wR2HkC6ur/401+rSWBZx
        mGs4sCzekV3zEEnDGJZJrc8J7w9qokfCAQ==
X-Google-Smtp-Source: ABdhPJw4QylC3Ps+oNmTML3fbSxd7m/TYjApDzns2/MnfhSbCUkBSzqeFl1LTdfMByzlviPIFnV7n72HrjbqQA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:b1])
 (user=cmllamas job=sendgmr) by 2002:a62:3808:0:b0:47b:d1da:e734 with SMTP id
 f8-20020a623808000000b0047bd1dae734mr686437pfa.2.1635376689115; Wed, 27 Oct
 2021 16:18:09 -0700 (PDT)
Date:   Wed, 27 Oct 2021 23:18:02 +0000
Message-Id: <20211027231802.2844313-1-cmllamas@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH net] ptp: fix code indentation issues
From:   Carlos Llamas <cmllamas@google.com>
To:     Richard Cochran <richardcochran@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Yang Yingliang <yangyingliang@huawei.com>, netdev@vger.kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following checkpatch.pl errors:

ERROR: code indent should use tabs where possible
+^I        if (ptp->pps_source)$

ERROR: code indent should use tabs where possible
+^I                pps_unregister_source(ptp->pps_source);$

ERROR: code indent should use tabs where possible
+^I                kthread_destroy_worker(ptp->kworker);$

Fixes: 4225fea1cb28 ("ptp: Fix possible memory leak in ptp_clock_register()")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/ptp/ptp_clock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index f9b2d66b0443..0e4bc8b9329d 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -284,11 +284,11 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	/* Create a posix clock and link it to the device. */
 	err = posix_clock_register(&ptp->clock, &ptp->dev);
 	if (err) {
-	        if (ptp->pps_source)
-	                pps_unregister_source(ptp->pps_source);
+		if (ptp->pps_source)
+			pps_unregister_source(ptp->pps_source);
 
 		if (ptp->kworker)
-	                kthread_destroy_worker(ptp->kworker);
+			kthread_destroy_worker(ptp->kworker);
 
 		put_device(&ptp->dev);
 
-- 
2.33.0.1079.g6e70778dc9-goog

