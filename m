Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6484635329C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 06:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbhDCErv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 00:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbhDCErt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 00:47:49 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C09FC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 21:47:47 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c3so6936445qkc.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 21:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZzL8vdXPjQmOyUpH6g9C5hBoe1rKYLajXq92s91Qu6U=;
        b=PevSn4UW2G/xpdzEIfOjLd8MwzUwZ27JCLgHFD5X0cHlei3bN6oeCJgravzp+oBPmb
         tgJzvF71YYVfqmnqN0/4+0XsPdW0mEB2G1IMkI7mHVAzihmfhx0Kr94GQ3WxSW97VvSP
         2Ug6L5siFTlABcVF1oN093sXb9BQpeY9wTd/6uXfkJqlSGpx9xMoRMglbISBfNzQRofH
         Pqp89xpy1+MHWTdqPT0Xf7EL/fSJljDlrmhs2gG+IzbfLm61dTqbfgUiL6mMotRe+ZOX
         hpvsSfTb/MuOpXcGsZXJrniKBk0+v47UxFg+qG6PFGk8Lejk8g+AHRvW+uR8TOGz+lwG
         OwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZzL8vdXPjQmOyUpH6g9C5hBoe1rKYLajXq92s91Qu6U=;
        b=nbfxYp+yoi6JzDBFsLJV84ehxOzDeQ9okPsPWGAYwDqraEKTBwBFPDj+QA9ruZsHAt
         6CdEb4pqjTLxzgePpXNH8lUgAea5jdMM7Hy0h6z+OkfF9vekvpPSCX+udV9StDm0HpjC
         sMWYINwKFlko7hMTlDF4HBxSuAUvkZ4xVoMdHGI5EDbepZ2X1VyyxdIzLUpfqrcef66m
         LIRbOCn6ykrRzffABnwvLLyfGwOmMfFAVtMP3cQD5Uulueerfn451mx8+cq3U00wjQ+e
         7LoZACp5qrWxmuJHX6MRX3SYOm92mse18KlnTxVgWNU2AnRAExJ0VkYewyYsSnh+9s+Q
         GU2w==
X-Gm-Message-State: AOAM532SEu3Grx4j/F0lamUMIDTaH6UgODMvZXL9jhpe8MUgMZrZ8T10
        7Nverg/FsjeXHR/m8sF588s=
X-Google-Smtp-Source: ABdhPJwQ4UjlST28eGqXPxvZr5Er3ouKGtPlDVThic5HBYnuSeCa6Tw6cdCBJ9Jqv2rkDNT1K59B5w==
X-Received: by 2002:ae9:ee07:: with SMTP id i7mr15642214qkg.233.1617425266468;
        Fri, 02 Apr 2021 21:47:46 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5cd3:8f4f:bad9:1dc4:19d9:7ce3])
        by smtp.gmail.com with ESMTPSA id k126sm8800598qkb.4.2021.04.02.21.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 21:47:46 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v3 5/9] w1: ds2438: fixed a coding style issue
Date:   Sat,  3 Apr 2021 01:48:17 -0300
Message-Id: <20210403044821.390485-5-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210403044821.390485-1-sampaio.ime@gmail.com>
References: <20210403044547.390226-1-sampaio.ime@gmail.com>
 <20210403044821.390485-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there is only one statement inside the if clause, no brackets
are required.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index eeb593294fbd..56e53a748059 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -380,9 +380,9 @@ static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
 	if (!buf)
 		return -EINVAL;
 
-	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VDD, &voltage) == 0) {
+	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VDD, &voltage) == 0)
 		ret = snprintf(buf, count, "%u\n", voltage);
-	} else
+	else
 		ret = -EIO;
 
 	return ret;
-- 
2.30.1

