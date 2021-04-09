Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B614635928D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbhDIDJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbhDIDJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:09:14 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8947CC061760;
        Thu,  8 Apr 2021 20:09:02 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id x9so3194844qto.8;
        Thu, 08 Apr 2021 20:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MZVVGzNYcMxmtISNSUfUMnz2s444oX5WOS+3c0FDAUg=;
        b=UiMW0s8WIoO/etdVaMIyqrgNbL6xL+o6I+edoWKa6Fdpg8DKUT0M1WPAkyJacFXn0u
         yeWXEBYJAt9zN76H03nRzRAC/N4pTb0XkznWH9/I9oIalbaJoOoQxTuXNhWd0RvnDBkm
         8OSw/O1BPm8OuiD4lJue+eOwXIGLOmYtPdFpyyDdo2aBf83nIdA3sopI1aPRD7zcBr01
         edFDNSFreEhZxqsBKycioVelLq6nLeZ1P7++1uP16rVmlaJtqW6NLGyalLE8JsmG1swQ
         s6t2bRn0vga09ikY+fSEQOZ2yuYbo0ZTpR/D8q0hgpWsTgrnhW1NdF8doleyTTqCNNEZ
         Fwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MZVVGzNYcMxmtISNSUfUMnz2s444oX5WOS+3c0FDAUg=;
        b=JTHgXuEdzsOvnxuPh00b+fbZq+FBLmILPwHFsWl3VNtwDtAMez15xVX9Onm/onsjKA
         xjoxPgPbEQOdfnCXUX7bHhxjO8MHiAvcZhNvQW5zXQiXzXDygbjOWG9BdM0bEt2NsgLe
         XTvkq4pxvIbSSe52hdmIcNKD1zhGNmK0t2N413MeGuC0PS5exnGPvihRoxDYErHwaAGx
         VW2hgf5MfCRJFD5JLhoP2hsUdsXBESw6CYwZDLtwqJsjdS8nvEq2qjJ19nmJZw7AIbB9
         0L1HP5hYipCzyCSzf0hnaRyeX0czZmQMRSsX7Y6ZKGtqr/6Cm5E1UX6vP8bbbY/TxE+l
         oORg==
X-Gm-Message-State: AOAM533xk+5UIXhO9DM2HHiVTkEkrpTN1njkkHYMbOiCKcF5Y3TN4AXh
        0zpkiNFW+eQYKCk+JOd1MNkVIIQCVchtFj0z
X-Google-Smtp-Source: ABdhPJzXqOw8qp/onBWru3sj/bDI1BDK1iL+xy9mHaOsqXvi3BazExDLc0XdkriCWVfYkqoZCf9d/Q==
X-Received: by 2002:ac8:7641:: with SMTP id i1mr3921292qtr.19.1617937741861;
        Thu, 08 Apr 2021 20:09:01 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5c21:af45:3b27:576c:7dde:37f1])
        by smtp.gmail.com with ESMTPSA id c5sm925408qkl.21.2021.04.08.20.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 20:09:01 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v5 2/6] w1: ds2438: fixed if brackets coding style issue
Date:   Fri,  9 Apr 2021 00:09:38 -0300
Message-Id: <20210409030942.441830-3-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210409030942.441830-1-sampaio.ime@gmail.com>
References: <20210405105009.420924-1-sampaio.ime@gmail.com>
 <20210409030942.441830-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there is only one statement inside the if clause, no brackets are
required.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index 148921fb9702..56e53a748059 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -287,9 +287,9 @@ static ssize_t iad_read(struct file *filp, struct kobject *kobj,
 	if (!buf)
 		return -EINVAL;
 
-	if (w1_ds2438_get_current(sl, &voltage) == 0) {
+	if (w1_ds2438_get_current(sl, &voltage) == 0)
 		ret = snprintf(buf, count, "%i\n", voltage);
-	} else
+	else
 		ret = -EIO;
 
 	return ret;
@@ -338,9 +338,9 @@ static ssize_t temperature_read(struct file *filp, struct kobject *kobj,
 	if (!buf)
 		return -EINVAL;
 
-	if (w1_ds2438_get_temperature(sl, &temp) == 0) {
+	if (w1_ds2438_get_temperature(sl, &temp) == 0)
 		ret = snprintf(buf, count, "%i\n", temp);
-	} else
+	else
 		ret = -EIO;
 
 	return ret;
@@ -359,9 +359,9 @@ static ssize_t vad_read(struct file *filp, struct kobject *kobj,
 	if (!buf)
 		return -EINVAL;
 
-	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VAD, &voltage) == 0) {
+	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VAD, &voltage) == 0)
 		ret = snprintf(buf, count, "%u\n", voltage);
-	} else
+	else
 		ret = -EIO;
 
 	return ret;
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

