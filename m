Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2662E3B660D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbhF1Put (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbhF1Pui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:50:38 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461FBC0763A7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 08:22:46 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so13136381pjs.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 08:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jmsXrQ0WMFUOjfSaSqjTHvp41i7ydFz3EWx9LYdOZfc=;
        b=NW4/3amg0ZRvKo+SF981NcJlVQQB4mFSwlUKCPOGAySdm3uOIAEw2TL7DwScMVkC8Z
         5+PY3Ig+6Xe8PzpyXUzklUZ/wJH05xZqE7EL/4QUq1l4bs9XtP0rVlDGD+wr1o62ENS1
         hQOb42avrhohRh/52F47tqVZb8NmzBjd+wQZ/Ts3DAeg74kPW78E3XAiwqXhzPyhUTXy
         +Hktnh8XvXk+xOxsvJbXtW+ir/9Kp9R0AJtu6+ZBnsRBsebswCXYLy2Cb3Djtd+km4me
         4oVPtLRuCYEy1m5qE9CxTM5KhnH3fg459H2iQ6NWOKY7sSPwkRXvBq6cjW/8KGE12gRV
         y1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jmsXrQ0WMFUOjfSaSqjTHvp41i7ydFz3EWx9LYdOZfc=;
        b=tUwI7O0QPeyFSOFZIWEtqYOKQg7R4R5msmBcQkrRRk3rW3lzvv+JcfXUF2/umsR8JZ
         m+aD6hbBv2Y+sr5Noa8a8lpe1b54E2cD1ORNC9Rh6X/57ejkx/p2enX7GoGFVGbsCstK
         he8RXtFnGzSI83VGEIViORS65unOHRSrkhYRlKy1hed+/9JQJ6NyjlymmEtNxe4rq4e5
         Agyl8EyZi4+ERAPcrjhZV+HsLS3jDOa95BBAfyWtqQgs2KM9+7HZhmAb+VEZGdAkmM7a
         D4FKP72efmuVSGWZ9xaWRR0jDgMIzs/N2oFqm5bqh7XzVNKWnb+kVkHv+1i7+N0cAt6j
         dfWg==
X-Gm-Message-State: AOAM533289pQMIY71PorgmNEV4TFNy5Qkb42ge2v5B1Hf5e6+i3j2JcV
        4D6WGKo5i7rvLGixgEMlvTknyM3DLsqRa0X2TQGNrA==
X-Google-Smtp-Source: ABdhPJy0QoJdRNi49a6OBOJ0bydiMRyzMa7tvWU0X0+DGJdOgdCdI8VkwGG5iiar16SXHxcm930YUw==
X-Received: by 2002:a17:90a:5202:: with SMTP id v2mr22129959pjh.169.1624893765882;
        Mon, 28 Jun 2021 08:22:45 -0700 (PDT)
Received: from localhost ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id h9sm15323713pgn.57.2021.06.28.08.22.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jun 2021 08:22:45 -0700 (PDT)
From:   Xiangyang Zhang <xyz.sun.ok@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        fabioaiuto83@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, xyz.sun.ok@gmail.com
Subject: [PATCH] staging: rtl8723bs: Fix a resource leak in sd_int_dpc
Date:   Mon, 28 Jun 2021 23:22:39 +0800
Message-Id: <20210628152239.5475-1-xyz.sun.ok@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "c2h_evt" variable is not freed when function call
"c2h_evt_read_88xx" failed

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Signed-off-by: Xiangyang Zhang <xyz.sun.ok@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index 2dd251ce177e..a545832a468e 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -909,6 +909,8 @@ void sd_int_dpc(struct adapter *adapter)
 				} else {
 					rtw_c2h_wk_cmd(adapter, (u8 *)c2h_evt);
 				}
+			} else {
+				kfree(c2h_evt);
 			}
 		} else {
 			/* Error handling for malloc fail */
-- 
2.19.1

