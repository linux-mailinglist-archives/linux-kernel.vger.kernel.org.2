Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E4E446020
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 08:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhKEHfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 03:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhKEHfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 03:35:44 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183BEC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 00:33:05 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id s5so8191253pfg.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 00:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ILPfUPNM7ARSRqsqeKDzED+z7SvdoX2q4zRig2wDJzY=;
        b=ejONK/yl9uyxiHYN3bBPHGU0MGI9HlKKKqbPUY7w0X7QjtEp5wxcfYo7ZC8R7NMUMM
         j5QLeuEMV14mIx3v3X/ROIAiW+DocOBXROZp7C9uWK0nna7bFuHBGuc8mBhcNOmuMZ9k
         986ROV0oMblP2WlqKKEOOZTOxJBS6EPMzMut7LLvw4OXmc69dmtiT+Q3ByEJk7BHrlPZ
         GnEchP1Stkksra6suqzc619SCyvpk9Yu4/VVJ9sGzmXU6eZEho8CTQVm+ovK7fvgCxlW
         EUl7wVWS6zB4nzi4quyYowPR3hi8K9Sk9CWcqWvjanB7R/dmhNcfaYGUPaDPbS0jUZL0
         2n8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ILPfUPNM7ARSRqsqeKDzED+z7SvdoX2q4zRig2wDJzY=;
        b=FXD9jZGeDzzwtdauvV8G77r8HhgSZwcdqoG1PVLhYmUNG1QaNII7aWroqdjuT7lRdZ
         hlQ2Ekgb4nuItzobnhgAHE9sj1r8CGrj5HKAPsfW67TW24MYipNxWpKroqCCqhfqIeO1
         99AtvVL+W54wFjA4tuJWV1mnH+mwGtcyvAsd2ygp+QLXMMB4VbcnetGPRkTiXjpZ0sIu
         +9I/7K6WtoXq0S0xVGvoYknqgFTgmYOvFgyf1QODwxJCEmxVWqRIYYGh7UAFbKvMtmeo
         wRK/9pB12xz3AGPNGAcb/IEekE/8UcXrseUMumtcAArA0k0BtADKMNir8jnyZIkSGQ3z
         8/2Q==
X-Gm-Message-State: AOAM530uifJoI4KxcX7vCJNv4p5IzjjxdLy59AdXjf1maaW2EPaf9zVi
        ml2ZaFpI/HK+c4tQIhAfs1o=
X-Google-Smtp-Source: ABdhPJx+y+OOYGt/FYjauC80Z3957xc53+A6rSMV4CgMStt+pMYzxp5WbobRRmirOvyTSu3CtqhNwg==
X-Received: by 2002:a63:5664:: with SMTP id g36mr32365872pgm.243.1636097584651;
        Fri, 05 Nov 2021 00:33:04 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id p4sm6699159pfo.73.2021.11.05.00.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 00:33:04 -0700 (PDT)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     dan.carpenter@oracle.com
Cc:     davidcomponentone@gmail.com, gregkh@linuxfoundation.org,
        ivan.zaentsev@wirenboard.ru, linux-kernel@vger.kernel.org,
        unixbhaskar@gmail.com, yang.guang5@zte.com.cn,
        yangyingliang@huawei.com, zbr@ioremap.net, zealci@zte.com.cn
Subject: [PATCH v2] w1: w1_therm: use swap() to make code cleaner
Date:   Fri,  5 Nov 2021 15:32:44 +0800
Message-Id: <d687b56df7dc93497bc78e5c337fc05711b5d98a.1636097083.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211104110900.GB3164@kadam>
References: <20211104110900.GB3164@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 drivers/w1/slaves/w1_therm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index ca70c5f03206..565578002d79 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1785,7 +1785,7 @@ static ssize_t alarms_store(struct device *device,
 	u8 new_config_register[3];	/* array of data to be written */
 	int temp, ret;
 	char *token = NULL;
-	s8 tl, th, tt;	/* 1 byte per value + temp ring order */
+	s8 tl, th;	/* 1 byte per value + temp ring order */
 	char *p_args, *orig;
 
 	p_args = orig = kmalloc(size, GFP_KERNEL);
@@ -1836,9 +1836,8 @@ static ssize_t alarms_store(struct device *device,
 	th = int_to_short(temp);
 
 	/* Reorder if required th and tl */
-	if (tl > th) {
-		tt = tl; tl = th; th = tt;
-	}
+	if (tl > th)
+		swap(tl, th);
 
 	/*
 	 * Read the scratchpad to change only the required bits
-- 
2.30.2

