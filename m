Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A9B309CDB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhAaOZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 09:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbhAaNhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 08:37:46 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE71C0613D6
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 05:36:58 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id q12so19023083lfo.12
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 05:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vSJI0IOHzsGzSkBfYpvuI7DBq1BUhDkkQNGGTHa2wRw=;
        b=cNymH++HnezbAzgCERt2fpuTRKTteTbt8qdj6DTgW1Fqd7I7/6rU5jvOkJ232DbYV3
         9ytG1hBry0r4+yuWjCPEz3xoe0Ghr+Bn28HE4Ci0M5tN/jkcRC1ZyyRodbI77Xeh3mF7
         YsUMx/ucd+FlquH+Uzl0JLcy5S4DwRlbPxreDspQd+K8ePFFAvRKbHYuSLjzPWuLXpkc
         TAc0KkEME6LAWmW4clQO7WjbxMNHORbbmAWNUYEVNt7SE5xynJfN9g7+msYarOdF8AHd
         Yd6lmcarkfMJ9/rHzFOSuwFzZ9tf18BPbH8elLd2IcUXPQ1LrxyUeg+QureDThm5W12Q
         5log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vSJI0IOHzsGzSkBfYpvuI7DBq1BUhDkkQNGGTHa2wRw=;
        b=U+7mc2wphu86J6ykkmTQ8l0IGYmT/16A6gGoOMCxICrjjvX4+IWDB8TYhAMDDltMo2
         njtEcI1nc7B0X+d6Ru97C4tElL3lVKbNiPHP1RtnsGQeGZbK39PtE2BUreZaFWa1fnl1
         pVA5+/fwLNFqOEtUB+n8DPcCz6iZFQX9pMSwsXUmXMmyOIgrOfcqPh++5sk632nrgVSy
         cABjdtdneP/KgGn9GVW6tAa1JMDCwM1m/2ZVNfl9jE9CzomxgqNZx2xgOzJcvuK+b64H
         HBgCOYuhm5ttw19RV8LO0EhBfryO8yVrkk23NuJqxz/pVE5DFHwKJrZhdJJgui0XlEjD
         eL7A==
X-Gm-Message-State: AOAM530cCyWV/MybXcifs9+BFYgLBRzxu3tfisxb/iHc3qQGX/hLMBOD
        13STMJ6+4k63VGxQe/wJ5WY=
X-Google-Smtp-Source: ABdhPJxRj8o8JbQj1Qfo0Fq6YeL/IMeJhdH2t/Opb9XPl9hb/L9xnYvlKCCfRfBri0BM7iDVwfTS0Q==
X-Received: by 2002:ac2:494b:: with SMTP id o11mr6609142lfi.256.1612100216634;
        Sun, 31 Jan 2021 05:36:56 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se. [158.174.22.164])
        by smtp.gmail.com with ESMTPSA id m8sm3391216ljb.32.2021.01.31.05.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 05:36:56 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
        Robert Jones <rjones@gateworks.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 2/3] mfd: lm3533: Constify static struct attribute_group
Date:   Sun, 31 Jan 2021 14:36:43 +0100
Message-Id: <20210131133644.8834-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210131133644.8834-1-rikard.falkeborn@gmail.com>
References: <20210131133644.8834-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of lm3533_attribute_group is to pass its address to
sysfs_create_group() and sysfs_remove_group(), both which takes pointers
to const attribute_group structs. Make it const to allow the compiler to
put it in read-only memory.

Done with the help of coccinelle.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/mfd/lm3533-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 22fdffd564f7..523dcf05db78 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -373,7 +373,7 @@ static umode_t lm3533_attr_is_visible(struct kobject *kobj,
 	return mode;
 };
 
-static struct attribute_group lm3533_attribute_group = {
+static const struct attribute_group lm3533_attribute_group = {
 	.is_visible	= lm3533_attr_is_visible,
 	.attrs		= lm3533_attributes
 };
-- 
2.30.0

