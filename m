Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B061A35329D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 06:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbhDCErx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 00:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbhDCErv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 00:47:51 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61470C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 21:47:49 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id y5so6906699qkl.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 21:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vYyE3mZbTCDzxA81uU/nO8mDAdIU/E4f/sVrNUxsbdg=;
        b=Az+/FoHw9EQhIzLcQmuhI9NHSk86lbj2esWSz1avJsrYb3Vc8HeGgF54YHkzROAsx3
         bI1RTgdP+OOZ99d4FY6/vo6kWAevnWAIYIy3jgOWwmTLvLMWtRQa9/rMEVxxLcmMJUv9
         dQYmhFs4mZrJZzeBne8Z4fycS6MmpT5bibK3z0uHPrBrpmrVNavgBwb1bgrT/Wp3eD07
         B4C6UlXmzBwYdMQLINcbkaNWUQ+yHiFy5JKNgqGi5CVJhyuTWmgjF0x/DP6lQ9ji/yf4
         mm8ScJhuPJbEdbmMU8urnn9qq7PnbCRlLLf+06CyZPCDGGs4JDYUiW/CNcJ8MguvsXhN
         vmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vYyE3mZbTCDzxA81uU/nO8mDAdIU/E4f/sVrNUxsbdg=;
        b=hYqZ5EY3VcU7eYivzV2TDj4j2RusuWMc2B90b1ejkK4SODKcbGq+GAjoZgDkmZ9MzV
         4oPorlizv8PMJ6bfKQQEpR6OdjtQ0yczHmQP4vj+VvPW5UcoUCdLjPDtGRbXwJLl1Oon
         K49J5fAm8Kquf/N3AnNWvRtKKYSe91XMy2uacfMGs+m75vmuElB9hN8ASLS5q30KpOdC
         cQCE6X76kbIrMVGoCzNabdThTTGFoGYyGAD01cP8c4hM9TGXRd07jrLFd2is9PZ3AtZY
         l4ejfstP0CPy9qKKvsCq0N0lPakaVegjsBg83n1FBe34HgsCw6cDOn1XfH0E2JBhu3/+
         DK0A==
X-Gm-Message-State: AOAM531bZCveUYzdpauy5cDSPAujAPW0EA3h1CIwLNJG8cz1TPH1XIKa
        RGeP631VJE3eQaVt0W3prIg=
X-Google-Smtp-Source: ABdhPJyoTDn2DLNq2APS2cwRLNP1fMg8ERUsDg576eKKpxoVRnwrLAeHbDRNkosyY8nnSVbF5cEl5Q==
X-Received: by 2002:a37:ef17:: with SMTP id j23mr15358251qkk.209.1617425268637;
        Fri, 02 Apr 2021 21:47:48 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5cd3:8f4f:bad9:1dc4:19d9:7ce3])
        by smtp.gmail.com with ESMTPSA id k126sm8800598qkb.4.2021.04.02.21.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 21:47:48 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v3 6/9] w1: ds2438: fixed a coding style issue
Date:   Sat,  3 Apr 2021 01:48:18 -0300
Message-Id: <20210403044821.390485-6-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210403044821.390485-1-sampaio.ime@gmail.com>
References: <20210403044547.390226-1-sampaio.ime@gmail.com>
 <20210403044821.390485-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed the permissions to preferred octal style.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index 56e53a748059..ccb06b8c2d78 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -388,7 +388,7 @@ static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
 	return ret;
 }
 
-static BIN_ATTR(iad, S_IRUGO | S_IWUSR | S_IWGRP, iad_read, iad_write, 0);
+static BIN_ATTR(iad, 0664, iad_read, iad_write, 0);
 static BIN_ATTR_RO(page0, DS2438_PAGE_SIZE);
 static BIN_ATTR_RO(temperature, 0/* real length varies */);
 static BIN_ATTR_RO(vad, 0/* real length varies */);
-- 
2.30.1

