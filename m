Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC0B43A5F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 23:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbhJYViG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 17:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhJYViA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 17:38:00 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DD7C061767
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:35:38 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id r25-20020a63a019000000b002a20656994dso4311620pge.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TKRBjHsCjPIxlOUEzR0Pb/eiKAPe4iD4OTxtg9Qg2Kk=;
        b=gW0LmKm+u4QbAACyTrJHmOYLnfYNWriZsR/wK2+bqguI3qJ/PBaVOk+MKVpyE5OQHL
         3D+mq+0xwDGGryFNTSu9kjwrMZ+jZxTjlO1mGlHt4buLbs++7/Iz8MwYiKPlIinFBp78
         BrvGlHHRsmjI2EX60hcP5GX9l9J2VmI7CKcT70rglqqDC+fRhqs1h6b+dewxMI5YVx3A
         D4Vq9fYTbvDmDgnyjgEm05ywPWoIcALKJHdwrlgfxFVhZC3of8vulCcgjIEAJ7Zg8suA
         /dxG02tAT+Vzs2UXveta6nqOq50Yv/3e6gl/cFHF9IL7QxgML/XHaxV18HLOFrWJS8xB
         fh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TKRBjHsCjPIxlOUEzR0Pb/eiKAPe4iD4OTxtg9Qg2Kk=;
        b=LgrsPsLLXOZb32uTLkEp0yJ6tnnEvpFyFvteHFKRIjs8Mr3jZIHnW/zYHDckQifN4a
         s+mnw4q2CjnNqiovnZMiPLf3/oRzfILlbGi/5IfmnqBo8jJUAPcQb6SFDh2WlYsjKse+
         ZEfV5ZDqlmEb7no4D691oqEWMdlION5WLu2tCPXH0HkbtHbOROTR7Nu9a8be+P6MPocV
         +KB4U1+ZaK485KTmVVuImuN6+hs7DysCkT5/k+z0vf3R36bBMN5B0sDoYCRy/VIwqv60
         rXxmX+LBbIOPDK1k90tIJrVre8rMQ03vqP5GNq37eOC6ubHvEXsju7r9JoU7O4fwaZzO
         0BAw==
X-Gm-Message-State: AOAM531YEXD02/asCtPDRrwZO4F0M5s09WnGhm95SxZtl7A4Z9A4Pscy
        Quc7j9wq1hAsn0ZaVSTvC3T+F6hUr8QR
X-Google-Smtp-Source: ABdhPJxylj23bhbDXfOwywyglJGgQuaQVa+8V8I4Mo4MBJZH7vWobZ4mPT6W37GoD3U/xaqpW8+LVjazfcWn
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:5478:3d15:6893:1074])
 (user=rajatja job=sendgmr) by 2002:a17:90b:3793:: with SMTP id
 mz19mr579625pjb.6.1635197737743; Mon, 25 Oct 2021 14:35:37 -0700 (PDT)
Date:   Mon, 25 Oct 2021 14:35:29 -0700
In-Reply-To: <20211025213532.2349161-1-rajatja@google.com>
Message-Id: <20211025213532.2349161-2-rajatja@google.com>
Mime-Version: 1.0
References: <20211025213532.2349161-1-rajatja@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 1/3] i2c: designware: Enable async suspend / resume of
 designware devices
From:   Rajat Jain <rajatja@google.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dtor@google.com
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com,
        dbasehore@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark the designware devices for asynchronous suspend. With this, the
resume for designware devices does not get stuck behind other unrelated
devices (e.g. intel_backlight that takes hundreds of ms to resume,
waiting for its parent devices).

Signed-off-by: Rajat Jain <rajatja@google.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
v2: Add Jarkko's ack / tested by

 drivers/i2c/busses/i2c-designware-platdrv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 21113665ddea..2bd81abc86f6 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -293,6 +293,8 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 					DPM_FLAG_MAY_SKIP_RESUME);
 	}
 
+	device_enable_async_suspend(&pdev->dev);
+
 	/* The code below assumes runtime PM to be disabled. */
 	WARN_ON(pm_runtime_enabled(&pdev->dev));
 
-- 
2.33.0.1079.g6e70778dc9-goog

