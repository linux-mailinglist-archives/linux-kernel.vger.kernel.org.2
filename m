Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FFB43837E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 13:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhJWLrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 07:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhJWLrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 07:47:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945FAC061764;
        Sat, 23 Oct 2021 04:45:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d3so5345678wrh.8;
        Sat, 23 Oct 2021 04:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8NbVhy/18KdPyyuiO5A3kcqrXSmZbFqQmCBwS7YiJMI=;
        b=jyBw11KT5wfH8KJ3LtWt0wpRZR5B1weSusDqeMUhL5GR7zWCsFyMhqH1C2lrfEaUNa
         AWkWO1trhxA6/WbqIKchLudTL5jtDDOaTDaIgdCM0ZXtHBPZYx8ERPMGqbdam1Zw5VpL
         INrPIYoBq5S6gKLciK+acbNbYlAwB8HnKJtpdBEcZDgP5zakCGHPsmzkQIa+Y/NO/CyJ
         qMi/84HlJwuwN0SmpH10WI280WBk4Vq1tI/1kG7o5zQlkjcC7jT4Mm2HJKqlMhRbMiCE
         C4UOkprijN8iZvS2WHI4eoGFASTtSpQ/8TI+XxMf3BynU6zjbrH+VDly2h1r9Q66I8hi
         p1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8NbVhy/18KdPyyuiO5A3kcqrXSmZbFqQmCBwS7YiJMI=;
        b=qNIXsUpf1ZlDoC1T5x9KuNj8A1BPKZcV1KrmOxDp5vqPsB6K8CMikeo3Ky+LfjN8mt
         clcy/oO728QUeE8zqp00eW4r9PoiX7buMB02WikCT0gB2/FALTUlBa3mScq2X9MP2pcO
         db6isRsGHWmEFtNAsl0NFDLDd0h66xZ7yWby2t1Z4bcVGCQWk6qDegf3fNuItXvJvkZh
         /roXCeG3CQjRrJxp+pFfTgO87ke9OT9/eMXVRHurxpUTx1rHEPf/7Zb7iKHoMW/xHY0H
         f7uR+zNy9KXF5WbqA/0cyTvyAaGSuVCWonIykYDgLwrRgDRrkkcEONRQ6p3z995gXvtq
         7Leg==
X-Gm-Message-State: AOAM5334j7tBbh2HL4blYMEO8rZa3ojvDkATxwcKVQWKQ9fEG2/1G6uH
        F8P7UbOljwFIHA==
X-Google-Smtp-Source: ABdhPJwu99HGkqbc5xQqT1RXKDkmPFr5MlmJVc2BR0UfWAO7GRDA1X4Rl7Wxknm/AAOGh7Goz9hNmg==
X-Received: by 2002:a5d:508a:: with SMTP id a10mr7473269wrt.126.1634989519243;
        Sat, 23 Oct 2021 04:45:19 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id s18sm8257265wrb.95.2021.10.23.04.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 04:45:18 -0700 (PDT)
From:   Colin King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin King <colin.king@canonical.com>
To:     "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Colin Ian King <colin.i.king@gmail.com>,
        linux-parisc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] parisc: Fix spelling mistake "Plase" -> "Please"
Date:   Sat, 23 Oct 2021 12:45:18 +0100
Message-Id: <20211023114518.18600-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.i.king@gmail.com>

There is a spelling mistake in a pr_warning message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/parisc/kernel/sys_parisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
index d11834377676..2b34294517a1 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -413,7 +413,7 @@ static int FIX_O_NONBLOCK(int flags)
 			!test_thread_flag(TIF_NONBLOCK_WARNING)) {
 		set_thread_flag(TIF_NONBLOCK_WARNING);
 		pr_warn("%s(%d) uses a deprecated O_NONBLOCK value."
-			" Plase recompile with newer glibc.\n",
+			" Please recompile with newer glibc.\n",
 			current->comm, current->pid);
 	}
 	return flags & ~O_NONBLOCK_MASK_OUT;
-- 
2.32.0

