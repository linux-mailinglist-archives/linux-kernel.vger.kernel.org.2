Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2883FCFA2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 00:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbhHaWqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 18:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhHaWqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 18:46:12 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BE8C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 15:45:17 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id u19-20020a05620a121300b0042665527c3bso1187680qkj.14
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 15:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VBr5TgxCC8MLVwjMjWQQXTK7iMmgeHcn6Adehu6ScSM=;
        b=NWgyKMGLYOnT5x9MYNZZtLsYsSIszTOkLOJtO5JTeXkNOtfkw0Lu1p7kl+NwDUsEmW
         upmmOaRYg1r7vn97qb3AQzbv/u/FzWC1R3DYeNK9mBbsJapwb7fBOTd1nxcfowCPmhT9
         xy9y1PGqQpAXKczq/nZZNNHGIx/KXTCHmU4w5qbvzm5gRGjkTOGu61bCaPmkTPQcY7jK
         u5XmA3fncqtL++pN60J3ui1H/pCtyh9UQal2F9q6yvVbZNHDpM8b/Q0UDbUs5ZL+8BLs
         o0p3JJHyS6LLKwrjAaVN8MPAF1cViuTUSVmNyqT5+3p71dA+VJ8Zl49CyW2QxIAInKnr
         wt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VBr5TgxCC8MLVwjMjWQQXTK7iMmgeHcn6Adehu6ScSM=;
        b=n9ZXJBv8iyXuBjQ59LX/QZbBDUoKzESyavDHDE5OccBjRW25TiJluV94fiIpoP/mDL
         w069XiHGCbrc0Fb7UKgxY2BuOvvdIXLvUOVhZXSofmExMfns6KQfLVJoJorlbP8lypJ8
         JzAfNJTrtSShkmIcrbyPIcnbvxJyDXNx5dzptjSUVIu7XVS3lYoTxJpCHnTe4d4+ZeaY
         O47Y7vYQWuLMCnFarhtx9xPGT1a6aiTa37Mb5fU5Ignjf3As5FS2/0XtynSIKZ9uvhV9
         2c6amaCrea+pu1iOUkAU7FjNAIAgRQ+xh+1hhvQNF/kB2sFH76GEDVyQydwND4lKk4a5
         b3HA==
X-Gm-Message-State: AOAM531G4JsYoLsLXJ8i8xY0LMngwprhkd8F7TjYW1sBey4wZZSMyiKZ
        BmVbdK0S5rdQHgxvLaZvn+nt1CO23Jw9Rxc=
X-Google-Smtp-Source: ABdhPJx/hQupCkCBnkliVvrBY2j07/Clpx8SKHzBGOHk/Wo7wwcCIhAe0sHvlrRCQFtGQQiT/+/dQ7cktnyK8Q4=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:c653:ae7e:a926:286a])
 (user=saravanak job=sendgmr) by 2002:a05:6214:23c6:: with SMTP id
 hr6mr30999430qvb.22.1630449916314; Tue, 31 Aug 2021 15:45:16 -0700 (PDT)
Date:   Tue, 31 Aug 2021 15:45:10 -0700
Message-Id: <20210831224510.703253-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH v1] driver core: fw_devlink: Don't create device links for
 devices not on a bus
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devices that are not on a bus will never have a driver bound to it. So,
fw_devlink should not create device links for it as it can cause probe
issues[1] or sync_state() call back issues[2].

[1] - https://lore.kernel.org/lkml/CAGETcx_xJCqOWtwZ9Ee2+0sPGNLM5=F=djtbdYENkAYZa0ynqQ@mail.gmail.com/
[2] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
Fixes: f9aa460672c9 ("driver core: Refactor fw_devlink feature")
Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index f6360490a4a3..304a06314656 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1719,8 +1719,24 @@ static int fw_devlink_create_devlink(struct device *con,
 	struct device *sup_dev;
 	int ret = 0;
 
+	/*
+	 * If a consumer device is not on a bus (i.e. a driver will never bind
+	 * to it), it doesn't make sense for fw_devlink to create device links
+	 * for it.
+	 */
+	if (con->bus == NULL)
+		return -EINVAL;
+
 	sup_dev = get_dev_from_fwnode(sup_handle);
 	if (sup_dev) {
+		/*
+		 * If a supplier device is not on a bus (i.e. a driver will
+		 * never bind to it), it doesn't make sense for fw_devlink to
+		 * create device links for it.
+		 */
+		if (sup_dev->bus == NULL)
+			return -EINVAL;
+
 		/*
 		 * If it's one of those drivers that don't actually bind to
 		 * their device using driver core, then don't wait on this
-- 
2.33.0.259.gc128427fd7-goog

