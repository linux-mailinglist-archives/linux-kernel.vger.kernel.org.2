Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E8332A427
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379928AbhCBKM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348416AbhCBKAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:00:45 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05333C061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 02:00:04 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id p21so30305455lfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 02:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RAANZPu6Vv8jCX2UvvYw3XNjCCQMOVZINFzh1fIaOPQ=;
        b=SbrLxqjwmiVHCuxR0AsUtnPqLuB+jhzxC4z0CiGOkzxc4tpL6wXe52IJyjN4vYX1Ma
         Wtp2mNcPjvEp/70mC2lunXhY4uusYA1qd9CmEhW2SfGi6MP7XXlvuemmLKgYcE1ayP5q
         XZK1WEfrU+y+3QXAnkE4FS/xmh9X/lYP/6Ov+9TRxuMeNPYOu2HRP13l4xgZFC7JVUnt
         TaIpLAJuNrZgUPwD/BBjbgyRUp9q74yx4Hffwy+zrQh5Uq1apsOI2P1vL1PBxw7JxmWG
         xOWmB9JzbZvr7ESnT/zMgfszSibL9/Z9OLAxvt1pce/e9scwDRWWXvZBKfRswp9zKmZQ
         bewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RAANZPu6Vv8jCX2UvvYw3XNjCCQMOVZINFzh1fIaOPQ=;
        b=Y7dwHQLLjVsPBRGvqSxLmHaot+7r1xw4HUQe0XPR21hC5cvd0Cz+JJC+ojaO8ldSXJ
         D6WI+5VZPVMMLZFcrBj9JFGvIUFWLeKxVZBMCAXc+094w1FkHnbEkkmp8Amy7p5Ogi2u
         48sLLAjqb804zNvzET+PVGOFgX8W+bxqyRks8JG7tqA9gI/mcB6bi7ubWfdPHQmr7JQW
         KY3GPA9NTV0YYhLjAHCV5q9kYi4GMsX6H6w7f2Tqyss8O5fri50zzaDrlL8fKufKs7oG
         eZuG+9QJjMsOtwFzSgLavjh+N2gGlPnsp6Wtm7G9nSoXeNWlkfStwsvKShEzWLWvT2aq
         P9Ag==
X-Gm-Message-State: AOAM532n5YcqpyBer28I//evN+PM7rfSIvYcHHGvJuicay6xkWqn0Vw2
        kdf69hGqdy2+LSWvUq9QrUbVC5KXOGc=
X-Google-Smtp-Source: ABdhPJxgV49l4Hy/fcHwj3tmpc7LEwtoT7M58tmQuZi0LxURiTVexncjUcEIISzbbMJFWaK84B9pNA==
X-Received: by 2002:a05:6512:39c5:: with SMTP id k5mr11723834lfu.478.1614679203143;
        Tue, 02 Mar 2021 02:00:03 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id m3sm2772720ljg.25.2021.03.02.02.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 02:00:02 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v1] pstore/ram: Rate-limit "uncorrectable error in header" message
Date:   Tue,  2 Mar 2021 12:58:50 +0300
Message-Id: <20210302095850.30894-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a quite huge "uncorrectable error in header" flood in KMSG
on a clean system boot since there is no pstore buffer saved in RAM.
Let's silence the redundant noisy messages by rate-limiting the printk
message. Now there are maximum 10 messages printed repeatedly instead
of 35+.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 fs/pstore/ram_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index aa8e0b65ff1a..fff363bfd484 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -246,7 +246,7 @@ static int persistent_ram_init_ecc(struct persistent_ram_zone *prz,
 		pr_info("error in header, %d\n", numerr);
 		prz->corrected_bytes += numerr;
 	} else if (numerr < 0) {
-		pr_info("uncorrectable error in header\n");
+		pr_info_ratelimited("uncorrectable error in header\n");
 		prz->bad_blocks++;
 	}
 
-- 
2.29.2

