Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA0F44736B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 16:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbhKGPGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 10:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbhKGPF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 10:05:56 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F1BC061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 07:03:13 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id x10so11215946qta.6
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 07:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZdSkp/wjCjH5O8nJQPBwfhqtOJTZO7qRybqidn7xqBA=;
        b=OFQu6UKAT8zNIkDXt6usQzrm9MZ5u4HFFiXimPLU1FnWAtnYJNUfqnDtLqtp/bNXLt
         Cru/9gLN3BVKJi9n/CSXMF6yS0sypDc9Scqn8LF4cz+DFq7eGPkSivD51LMeoX5uFWk3
         om+TEbJuJx3FYYsiTnSjA/4JsUR9UKGdrkbXyk51fexKW/EL7oqX9Cd+qMfVOFK/YDKU
         Q88nn4uWBLcHxkeYEMlvcKKTFba4vEjXL3g+IJ4R5rXZcVXUeAK2wIlvJQyiBLJOThvb
         lv5HlmgrnF/mh2nSSEupz5L2ypGX/hwb1RYv4KWkU81ykl4mXfkyu/S8oZx/Ju/qoRpB
         8FlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZdSkp/wjCjH5O8nJQPBwfhqtOJTZO7qRybqidn7xqBA=;
        b=rHuHMurea6+WtZMuBJrx4iFVc6TkhoYk8sC/qLz1TV7TNBjt2xVt/jg/XZRDQ6f9Ff
         iqp1VQxy7eo0GqVWQOddWD5RLF9nGaaxCS0RTP/0oEWu7M4JMDutWxRYB7+GRBHnXWg5
         DNwi5u3+QopP6oCJ2v6xYr+Ikx8XuY2tJ17h4RtQN3FAjrvBCwPjWHpDcWLW+Rwyh8/E
         UuT5hbEwsJr4DQt9QfStXaV+yY2ghCrfc+w2CLglutql/9IxMv77nS/B4sKEHacJNz0N
         XYOaHXClavG0qPxYwc3v70Iw2JMCQp3dULlG/jorJumLXQ/YXSoBz0HiHSX9AzwxTcsO
         gL4Q==
X-Gm-Message-State: AOAM532kBOj7d3tfjBmMRliq8Kt6eU0JOKfyh+mBVr2WC8XXwLXep5U+
        mXCkPbGhOEI539mvFynWLvZJj9qgy8Hz1yG0
X-Google-Smtp-Source: ABdhPJzenFbJJb0owKyIhCV+xlXslz167FOS0s9KT08aOA46dyUxREKX+4LNF+6Kd5MF7atyNmm6Sg==
X-Received: by 2002:ac8:5c08:: with SMTP id i8mr77507150qti.181.1636297392982;
        Sun, 07 Nov 2021 07:03:12 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5c21:92d0:fc01:11b0:47fa:d730])
        by smtp.gmail.com with ESMTPSA id x11sm9554883qta.90.2021.11.07.07.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 07:03:12 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     ojeda@kernel.org
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH 2/2] auxdisplay: charlcd: checking for pointer reference before dereferencing
Date:   Sun,  7 Nov 2021 12:03:04 -0300
Message-Id: <20211107150304.3253-3-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211107150304.3253-1-sampaio.ime@gmail.com>
References: <20211107150304.3253-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if the pointer lcd->ops->init_display exists before dereferencing it.
If a driver called charlcd_init() without defining the ops, this would
return segmentation fault, as happened to me when implementing a charlcd
driver.  Checking the pointer before dereferencing protects from
segmentation fault.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/auxdisplay/charlcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index cca3b600c0ba..47363fb2fe94 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -578,6 +578,9 @@ static int charlcd_init(struct charlcd *lcd)
 	 * Since charlcd_init_display() needs to write data, we have to
 	 * enable mark the LCD initialized just before.
 	 */
+	if (!lcd->ops->init_display)
+		return -EFAULT;
+
 	ret = lcd->ops->init_display(lcd);
 	if (ret)
 		return ret;
-- 
2.33.1

