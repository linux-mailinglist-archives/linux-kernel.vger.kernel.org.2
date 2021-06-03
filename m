Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5CD39ABB5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 22:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhFCUXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 16:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCUXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 16:23:17 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4490C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 13:21:19 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y15so5773767pfl.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 13:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=22cHXWv9iZQXx/sdhYmRqkO8JAZp4DKO+xohWwIb59Y=;
        b=CwYWBjmP9s0p7+KjLehn2GHvcj0PUMS4cjGX5d+Cg0kCMk7Uwohb2YymU4yuOMAgEV
         h6hvR0PTu8QHfDAJI2I+hg6f5F3FgdBtLxkdRN+q50qtFyT8i5o3Cm9kFrWcwDht0OC6
         QMZ8vIX8uLZZ3NcrOnJFut1DnVhvsjJa9WEjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=22cHXWv9iZQXx/sdhYmRqkO8JAZp4DKO+xohWwIb59Y=;
        b=UP4Drv9I0JwbKj77R520i3vwrRg1K6LjRewme+xy40qzmWYJj1Mk8Ad/hEL+dQ9jRo
         E99pYyKjG2znc9d8mkvC6oR4La6xQ8qHPgZjGk5euF2AlhJF498GrVtOnnfAGwtqfLBX
         lGU5PXlUgt5qBaTFz4jaxBDdHvJ/blRJMurNQmLJJ6U6LRIgzFStXLfWY2rOh42rUxAR
         kIwuFR024FZ9HQ/c6/SKiy1wjRtr1Lf1GzFTDpv6IlvR8lwrnIybjV5krIYaMQFftpiZ
         sQao0teiPKie7fKkd6Rn/wXVrQCncrUZ26MZeKX3Q2AT+Z4WlJ3e/vDY8FK2HBOV8JCq
         Rh/g==
X-Gm-Message-State: AOAM533MH7RupG6GOyShd+oZLvtgTWArKtTjnk8G08Y/yeX1mactDwXj
        1uj841auHS5obs88EY59+OInCIcnF+Ikkg==
X-Google-Smtp-Source: ABdhPJzSqKrU1aeFkW97aOCihszyvcSTKgLaKNTofS40qreZjNJCOuYucO8oUkGoOQGdIopF5oiK4g==
X-Received: by 2002:a63:4b43:: with SMTP id k3mr1218443pgl.450.1622751677743;
        Thu, 03 Jun 2021 13:21:17 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:f64:a52d:f801:58d1])
        by smtp.gmail.com with ESMTPSA id c62sm2999511pfa.12.2021.06.03.13.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 13:21:17 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v2] driver core: Make cycle dev_info() message dev_dbg()
Date:   Thu,  3 Jun 2021 13:21:16 -0700
Message-Id: <20210603202116.1841261-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to mostly print debug information about device link stuff at
boot. It doesn't seem very useful outside of debugging so move it to
dev_dbg().

Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1 (https://lore.kernel.org/r/20210603064849.1376107-1-swboyd@chromium.org)
 * Dropped second hunk and rebased to -rc4

 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 54ba506e5a89..378bb894869a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1736,7 +1736,7 @@ static int fw_devlink_create_devlink(struct device *con,
 		 */
 		if (!device_link_add(con, sup_dev, flags) &&
 		    !(flags & DL_FLAG_SYNC_STATE_ONLY)) {
-			dev_info(con, "Fixing up cyclic dependency with %s\n",
+			dev_dbg(con, "Fixing up cyclic dependency with %s\n",
 				 dev_name(sup_dev));
 			device_links_write_lock();
 			fw_devlink_relax_cycle(con, sup_dev);

base-commit: 8124c8a6b35386f73523d27eacb71b5364a68c4c
-- 
https://chromeos.dev

