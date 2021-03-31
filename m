Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4935F34A92E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhCZOAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhCZN7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 09:59:54 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910A9C0613AA;
        Fri, 26 Mar 2021 06:59:54 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id i9so5259413qka.2;
        Fri, 26 Mar 2021 06:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x0s7LJER70w2bSiwwTpjAxpJj5S5Wt0DwDx2zogXdYE=;
        b=n+foT8+06n779+ymsgAN7XHmY9phYxAQcmR3n3IAmvnwuV9WCvK4h382O7+6r8KxWl
         TMr6pRDl+InbWTMRl/KabrbFXlxnt4we7WbvI0EgROP3EJtHWcB5kiJbRj+cNhxZSIiF
         PBS6oOS92b1i2xCrsQSGHxriv2UqLAP6jZihwMOacl6bdXRPJGh8/BheL/nl53J4ghr1
         MJnDJiEDH13PZ4hFu1dypVI4989oyJQKRJUnrzz+PjsMzoVN2NP+na3OMAOlwfjJj9pB
         xj1LeYuCyRvKX+Y7CqiVMmbiOBGh0NaMfQkPhtKap71LOqEYh4wxB3Rj7j4d93RfORC/
         lxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x0s7LJER70w2bSiwwTpjAxpJj5S5Wt0DwDx2zogXdYE=;
        b=m2iwreK9I0xJO24SA17uoEVgaC512JJa3gS2Qh7Su6bqIlb/m3zg/vFZo/fxqJOdIa
         WT1CbCaAf+EnZqzcabN04z0d70fQ4Wjn4BHO7bJxHjVqXFOZBEGmk3824YuzLkbGU8hz
         lJCFcqxan1o6iGEQsjPZR43jc7dKy4zU+4mVSiNZcCUdKA5dxq7kGwsNxRTVMGaSWFrF
         obUif0aItfljE3hvNMz7PcuuKdATLCm2tMR6xwzTnkzUOTusI/Qnzh+l7jvXkWUCx7Ib
         T03ci/SWJ4+di+FACh8ECzUdej5V/fOh8dYqLPNmZllbyoRMeNwxXSZsx/DuJUqNZEjC
         GIqA==
X-Gm-Message-State: AOAM531xUrrYg9NKW0R8sT1NXnyMt6XaUhqCBZVzzwmo7oTvbskcQBOQ
        8vOSQ7sIsubJTIk0N63QqC2Qjf6TFfCyHBWY
X-Google-Smtp-Source: ABdhPJwxui/7YiRZ9ijL0SMcy1jYD4hzFKZCNA4A413XhqNgHJNr+nKi0NPriqxWfstAt+DZ01jbQQ==
X-Received: by 2002:ae9:f312:: with SMTP id p18mr11538849qkg.162.1616767193781;
        Fri, 26 Mar 2021 06:59:53 -0700 (PDT)
Received: from localhost.localdomain ([156.146.55.149])
        by smtp.gmail.com with ESMTPSA id q125sm6644710qkf.68.2021.03.26.06.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 06:59:52 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] blk-settings: Fix a typo
Date:   Fri, 26 Mar 2021 19:27:15 +0530
Message-Id: <20210326135715.28434-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/idential/identical/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 block/blk-settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index b4aa2f37fab6..63168b529360 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -749,7 +749,7 @@ void blk_queue_virt_boundary(struct request_queue *q, unsigned long mask)
 	/*
 	 * Devices that require a virtual boundary do not support scatter/gather
 	 * I/O natively, but instead require a descriptor list entry for each
-	 * page (which might not be idential to the Linux PAGE_SIZE).  Because
+	 * page (which might not be identical to the Linux PAGE_SIZE).  Because
 	 * of that they are not limited by our notion of "segment size".
 	 */
 	if (mask)
--
2.26.2

