Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481AA355FA4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 01:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242682AbhDFXlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 19:41:37 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:45476 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbhDFXld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 19:41:33 -0400
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Apr 2021 19:41:33 EDT
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4FFP5l538lz9vYw0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 23:35:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bw8rtIorPqW6 for <linux-kernel@vger.kernel.org>;
        Tue,  6 Apr 2021 18:35:23 -0500 (CDT)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4FFP5l3SL8z9vYvp
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 18:35:23 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4FFP5l3SL8z9vYvp
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4FFP5l3SL8z9vYvp
Received: by mail-il1-f197.google.com with SMTP id m8so1366462ilh.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 16:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JFBsXOVlHHjdSzZeWJyJvvBdMued/K0xOEkGtWU402Q=;
        b=jw0JK6OAT3hKXrthWczTi8kJcQy2JrposNHUiEHoienPromNuX/6FDiFYTdHNKtFwO
         IuZ1sVYvgK7ysivr4tQcIvOpxT7R2k45lK8OCc1Kq8CiYi2aqfag7FK2nQ/TATZkvFuB
         TyRJms8yqv928MC35tBPy00HM3O8AbwScP0OAiPv3R/yaKb9ExXiFxZRlvTb7qEVsNgq
         2vo9FwBN7/Osc73xCQYo+aMRBo5xhEvh/pyaCrGz/Iyslz5Gg+mo4bdedc6aC536kvr6
         XoZ8Wb1OkX+FJVOAWs1phd/Tj0byJiuyLKvd8rdWz1RRJpcMfhM9BZsYZjXbsdD8EPx2
         eHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JFBsXOVlHHjdSzZeWJyJvvBdMued/K0xOEkGtWU402Q=;
        b=fBfDAgBtw1qMc4Eo9tHEZ4sWERDK7MYaTixXSyXZVirWX6cv3QgRvvZP4mpNhhU1Gg
         FpbOu0qu51qi0Je5KYoX8TnQZ3l86crlOcPdtfPQnZSfxi1xxY48EePF1Ow+lqiaEO1h
         bln4+8qN6hu9DihmrmEB7RUTqvjwOQ/wxNV5cAp7L/3bv5U++KM8ei4oWSxHg+K8Cj6C
         6bQtuwQ/+/lBweTJpyNqs0EGdI2V9hLAUZFRrx7/AxvI2dp3eA0Cuav3xoI+RUo66EQq
         Gu7mBs99Pr755Evm5p6DdzOiiW+OmbG2Vh5bQ+XG3CNY5h9kygdYCxt8BtPw3f8lvCHL
         6h8Q==
X-Gm-Message-State: AOAM5339bCRjAMxObjZg6uW9oqRR8euMzJrHvJCRpwA4aAtV8ge6k7t7
        ejOUHdXyphJESm3MoXeaVjk+yDT4dVh5kb/0pFpfbJ3k4QmxYT8fAsfJK71Ca5MDycd0UKRuv+f
        BoTbH+RSvaitcVMSL8jnfYXlZjyyp
X-Received: by 2002:a05:6e02:1a24:: with SMTP id g4mr541653ile.56.1617752123129;
        Tue, 06 Apr 2021 16:35:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaO3ytfZodkyajwuLbl1Y4fWouzIS2WVmGek9UP7t+cDJ+s7ZY5VtwQFZ3Q8QArUTuCz1zEw==
X-Received: by 2002:a05:6e02:1a24:: with SMTP id g4mr541645ile.56.1617752122966;
        Tue, 06 Apr 2021 16:35:22 -0700 (PDT)
Received: from syssec1.cs.umn.edu ([2607:ea00:101:3c74:6ecd:6512:5d03:eeb6])
        by smtp.googlemail.com with ESMTPSA id h128sm14399373ioa.32.2021.04.06.16.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 16:35:22 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: sm501fb:  Fix deallocation of buffers order
Date:   Tue,  6 Apr 2021 18:35:17 -0500
Message-Id: <20210406233519.2205389-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resource release in sm501fb_remove() is not in the inverse order of
sm501fb_probe(), for the buffers. Release the info object after
deallocating the buffers.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/video/fbdev/sm501fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index 6a52eba64559..4c32c9e88850 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -2060,11 +2060,11 @@ static int sm501fb_remove(struct platform_device *pdev)
 		unregister_framebuffer(fbinfo_pnl);
 
 	sm501fb_stop(info);
-	kfree(info);
 
 	framebuffer_release(fbinfo_pnl);
 	framebuffer_release(fbinfo_crt);
 
+	kfree(info);
 	return 0;
 }
 
-- 
2.25.1

