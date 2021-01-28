Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFC73070C9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhA1IMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbhA1ILR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:11:17 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA18C061756
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:10:37 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id p19so2738461plr.22
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=xhIblnQywgPtk5qspOVbwKaKHkL1LTY2VsAgL+AtKig=;
        b=WD4xeJoZEqF+M2h7aJjMeqxKWYZDd3ZzA8vpPZ/nQ5raVj+jW/NcK2EOCZm0TJN0J6
         nb7ZLRk80KPfbyV6TEXgcvfq7cRM70rIxCq6IBDjYMf5ETE8rVZy32o+7I2Gi0FeOzjg
         bCdQWB0dYErnjOm0e23y8AKJZrfgicf91l2aafJypL3ooEf/C1sbKUkVwKsW2YOrHJpZ
         x5aoZzQnppNqH7uEOkfz+A2676gKMRpUh4p593ukKefShxR9gE68Y6XEQxoelLjaBEMH
         XnQTGV4FL7VyTekQXDAAreNis0FN9USQ6SVPoj8lpri7LEzocEuQGRnQFy56poQzzjaI
         o6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=xhIblnQywgPtk5qspOVbwKaKHkL1LTY2VsAgL+AtKig=;
        b=IZy/zV79rE8HYcWoYMjhfgc0DMmJwBQT9+SOxfktuy3dksaQ4mawonSw1F9xq04yyR
         ggHE1p8P/S4kodkzfMEiFvIvc/6hi+CQ0s/kvZMlsIQVRQiJLw6Q03m3Cd5XoW613gFO
         TRUptef9iTLDruHLijybjbpUg8iTm350oo5c/Rnh4W6Zo6c1HJuTiqKhTBpx9haeOIsy
         gdZPMjWbWjV7KNoHq0hUfzCgjRuZtQSeQ7qT1xSDFnET9IbvjQUNuwwR/pUEOf15B7jk
         rd1QI73Q68zy2gDWRn9H3qxnAgklW2jupWUdcjA7roJmp4VkI0XxhB6atlTnwUlzDtyx
         5l9g==
X-Gm-Message-State: AOAM533JT/95Lq/DRyZPHWKCew78VV2UoOnNSPkQ/DubzHvL+TfB7syr
        TbIE/yzrZoC/eu4kATYmuhCjN2iZxwE5yMbS
X-Google-Smtp-Source: ABdhPJzDwTg6d2cAWZ7kopJTIwvW6zLAym6qfOu4YcGv/besy02NWJjE6AYhUCMMEilIeWqmnPDxCCozT3k3dgYx
Sender: "hsiufangho via sendgmr" 
        <hsiufangho@hsiufangho-gl.tnn.corp.google.com>
X-Received: from hsiufangho-gl.tnn.corp.google.com ([2401:fa00:f1:200:d092:5885:655f:10cd])
 (user=hsiufangho job=sendgmr) by 2002:a17:902:758b:b029:df:d1f6:9af9 with
 SMTP id j11-20020a170902758bb02900dfd1f69af9mr15249314pll.21.1611821436757;
 Thu, 28 Jan 2021 00:10:36 -0800 (PST)
Date:   Thu, 28 Jan 2021 16:10:30 +0800
Message-Id: <20210128081030.2345998-1-hsiufangho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH] eeprom: at24: Add permission to write_timeout
From:   Jenny Ho <hsiufangho@google.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jenny Ho <hsiufangho@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need to change timeout time for different use
cases to prevent I2C error cases. Open the api
and allow Read/Write permission to write_timeout

Signed-off-by: Jenny Ho <hsiufangho@google.com>
---
 drivers/misc/eeprom/at24.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 926408b41270..39caead4058c 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -117,7 +117,7 @@ MODULE_PARM_DESC(at24_io_limit, "Maximum bytes per I/O (default 128)");
  * it's important to recover from write timeouts.
  */
 static unsigned int at24_write_timeout = 25;
-module_param_named(write_timeout, at24_write_timeout, uint, 0);
+module_param_named(write_timeout, at24_write_timeout, uint, 0600);
 MODULE_PARM_DESC(at24_write_timeout, "Time (in ms) to try writes (default 25)");
 
 struct at24_chip_data {
-- 
2.30.0.280.ga3ce27912f-goog

