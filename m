Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF9139D1EF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 00:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhFFWld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 18:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhFFWlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 18:41:32 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A174C061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 15:39:30 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id e20so455801pgg.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 15:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9bYFOydettRZiZfUc0/NYg9V0FKj/gOB4eMwxzHPpNU=;
        b=UmXfhwOeXRsHrSOMBwxjLBqfP4AE/FtPfopT8EUYOfZX13udQvAGQR02dmS7XvQsgW
         XGgmXvdU73JxG5CSDZ15Hj2m97zdmvqJNo9Qo/UpVXymXpYF26WHXcRxVbftIiENr2ZO
         zU1ayrNqKRmd6RuZrWkjpl5a+gF8Z2WG7n3gLP8G9PTTKeFZJU0TGIaQPOMHxU3soNKI
         R1NmY+s2o1J7HF+DouL8s50EmA19o+gFIPBtWn5t4wSwDtI7VAuT6aN6NFyDV3/lqycF
         nVHW1TPILQswfRouXwIkMS+BWC+Vczx9ZLbMd7zjpbJsOzs5iP5Czygwzm4dpMjpBUcp
         WLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9bYFOydettRZiZfUc0/NYg9V0FKj/gOB4eMwxzHPpNU=;
        b=s4mdh9rLDDUIP8JUx/1CCnskiwQ7UDZzh0OgmlRjVCF+e8OgUXrY49l1pQGUrn/zLC
         cVVWGgKeTSd8GPI2mmhwyhYRPrDV97O6J91MEtDDXdNxdMc2yEvBrGeTO+CmVcnB3Oin
         75eBD+jGbkSIkQYNMYF61JEtYJDVJ16oDwskiIczMPdn6xTMR1bBZNegBA2rOwn4OgOa
         3AwBYXHqgNXcRYgdu5Evi9TAXy0ixqlFdGX7ovDT968+BySuiKmR1iS6MujFd4sYpNNg
         457mFTHh+J+Bm0O8gt8z4/se2+k4xY0yM8CnJTCCkg0SjkhZpJxEEtaC+RdkYrACXJoR
         g5VA==
X-Gm-Message-State: AOAM5308JjxCw12G0ZIL9QZpu+BdbvnpHZDfftz/8UlE3Cogs9kHGrEH
        Hwz8cr2xV8a9eeGLBO009/I=
X-Google-Smtp-Source: ABdhPJwh55IEPLh3pEAlMyXeUxM6YvAw+3mAVFyQ7rAmGY+0iUDzu0pBaKKlo6Fh5e3Mu2Cb19u2vA==
X-Received: by 2002:a05:6a00:1794:b029:2ee:c59c:56bf with SMTP id s20-20020a056a001794b02902eec59c56bfmr4762081pfg.2.1623019169679;
        Sun, 06 Jun 2021 15:39:29 -0700 (PDT)
Received: from Crosshair-VIII-Hero.lan (066-188-147-045.res.spectrum.com. [66.188.147.45])
        by smtp.gmail.com with ESMTPSA id f3sm6245272pfd.21.2021.06.06.15.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 15:39:29 -0700 (PDT)
From:   riptide_wave <chrisrblake93@gmail.com>
To:     ptyser@xes-inc.com, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     riptide_wave <chrisrblake93@gmail.com>
Subject: [PATCH] mfd: lpc_ich: Enable GPIO driver for DH89xxCC
Date:   Sun,  6 Jun 2021 17:39:19 -0500
Message-Id: <20210606223919.24015-1-chrisrblake93@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the Intel Datasheet for the DH89xxCC PCH, the GPIO driver
is the same as ICH_v5_GPIO, minus the fact the DH89xxCC also has
blink support. However, blink support isn't supported by the GPIO
driver so we should use ICH_v5_GPIO. Tested and working on a Meraki
MX100-HW.

Signed-off-by: Chris Blake <chrisrblake93@gmail.com>
---
 drivers/mfd/lpc_ich.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
index 3bbb29a7e7a5..f10e53187f67 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -489,6 +489,7 @@ static struct lpc_ich_info lpc_chipset_info[] = {
 	[LPC_DH89XXCC] = {
 		.name = "DH89xxCC",
 		.iTCO_version = 2,
+		.gpio_version = ICH_V5_GPIO,
 	},
 	[LPC_PPT] = {
 		.name = "Panther Point",
-- 
2.25.1

