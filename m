Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4CB436FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 04:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhJVCb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbhJVCbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:31:23 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543C5C061766
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:29:07 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id n15-20020a170902e54f00b0013ed08c1bacso1014992plf.20
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ijVYb03qsUXHo6CKgq/jFRZoGv36pg7G0FzeLowQevM=;
        b=GFmmGhXFGiiG4aBOIbuik6hEaw76jr99tzyjl7v7t3Gfmzc0u3UPmHbGBa+WAwzn0k
         WxWnCK1oml3wfu8uS3NvmvMI3Kd5Y/JFIZ4Q1voLaAc6RaqgTB7T8nPrBVutWnraZTYq
         CyIs5CrcQiESRIFHLm44RiTwzMOuJ4nRyVyMPk9AYShAoV8qWvjP+prQ607aP+K2E5M9
         U90FgLVS/4T+uSac3ZMiOfveSMgeAk0r2vW2syM756aOPIS3TeVfCEwJofjEXAV1tbgL
         UUMkQvo0JxfMUTr0tpj9h6IccSNykU7q4ZrqNdKWTvrNed0M9+sOr3h/TpcjcNuLKR49
         V+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ijVYb03qsUXHo6CKgq/jFRZoGv36pg7G0FzeLowQevM=;
        b=evA48yBypFIQ/pGFvdZbbfRWmwCl0S4zHcjZ10mYa/zO+z9f96zyqjiCP+nhxElx20
         rkEkGel38IwoHlQC9RLt/2Xf1KfM/8kyS48G1sQkjOWUU4oB8skymtcQJbLNrx0ydImV
         4xVDHyKQaAwRyV9SCKRMRHCOUMyX2X4aD1MqJNnwf+PK6SirLHgMLhmOBrAs2zRiGyV+
         H36xSAcVNedgiwhvrbPgUQPIn/oMvOUh6NLGs6GnElyfid+M1nTsNLbtYD8N1N3odDsg
         bHNZaDKlNuQHpVRuXgmazoXFsoKTdZt+LHAX6ekH6Tlw+y74Tf3vny3JcnfNm6O8Dm6p
         /Zgw==
X-Gm-Message-State: AOAM531tpVPBGBuvVNWmHuivCG5J78a9ZaED6vQygsCfcl2JuW6CpZpj
        24m55siaVFp0pzZW87bW2a5as1hQgEMF
X-Google-Smtp-Source: ABdhPJxk2OnWe6ziiCaTwDnvay3U5Dq4gzwUl08eYp9OFoMcwi1QgNd/aLIbB6QCrVNIqVy6bPPtz7uwbAOn
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:cc25:d9a3:4b5:37b9])
 (user=rajatja job=sendgmr) by 2002:a17:90b:4f84:: with SMTP id
 qe4mr11246662pjb.209.1634869746745; Thu, 21 Oct 2021 19:29:06 -0700 (PDT)
Date:   Thu, 21 Oct 2021 19:28:57 -0700
In-Reply-To: <20211022022859.1888836-1-rajatja@google.com>
Message-Id: <20211022022859.1888836-2-rajatja@google.com>
Mime-Version: 1.0
References: <20211022022859.1888836-1-rajatja@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH 1/3] i2c: designware: Enable async suspend / resume of
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
---
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

