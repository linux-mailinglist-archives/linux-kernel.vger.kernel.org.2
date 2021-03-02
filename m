Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AB032AE11
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360474AbhCBWUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383569AbhCBVQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 16:16:11 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65957C0611C2
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 13:05:37 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id d3so33506284lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 13:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lpo94fit2Cm7Uz3s805DcvYGifzWRch+vK5DR9wkU2M=;
        b=HyYFruGu5nGGu2hw1mlBY4Nqw5ZE7GC9Y7iVCHFftoc17f0ROxicL/ek0/gmSbpA/h
         ZtLsyfyPBI+1PHuJHPQPYg65aW5Mnz6Uw+pO7PGyBdcRDxAoV+K8XhUM+1SNBV4z3jul
         +k5N2SCEkbA1c+pnSWnNuz9fNFgvVZFdHlQ6ROrFWJiN3/buwYDFS3YCQoh8wR+51eg3
         8Fd/i4Xc004/YAY5qx1oZOXDV37eC9LlneppZho9AOxDr4jorQtHubmUH8R0YwscN6OO
         c3U3Y5mpO4UHqgKeENPuZE/tArDsypwNFm2mT2RYZbPAcPDYDhAUgUL+gztywz0ZC2f+
         ed4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lpo94fit2Cm7Uz3s805DcvYGifzWRch+vK5DR9wkU2M=;
        b=ewOXV63NYzqWNt3IDYBjc9gcnkDp52HSUWnh2sj6zr8+7ReShMdS4Ez6W8ZP3Oxmqp
         aIdXMhKc3lz3zrSItjNwBOnJGVz3ALbp5IbiPOFYfxd/GaG2HlF+jn/39c1WaCYt0JYI
         hIrVHyP+xBjid88FIo4cp5mlDQKgCrKSkf8FKfqkIQ6J+KK6qMMQ8PS18YUcPmuSc99c
         zUHnqAYmOAmGobTHHfgVnKlVGoVTV4lR7BN2BUGvs6UJfBwoBlTh+oV4N6pE9Ajy6T8B
         yTx9Lvud/9PRBY7LFZFXlF0yLkPW8I9PRZxU47j6s09ahaEN7foyoCA9Wk6bwpgxCndw
         sUCA==
X-Gm-Message-State: AOAM532VUgqtGhvmVn+g4gqu/v/xzsf2UjIJpBnD+/BGeArViP8PqUyt
        LCaoy/DqPG+A7BjQtCrTtEY=
X-Google-Smtp-Source: ABdhPJwO7RNKR8c6XzQNxUUjbs5w4t6VfEw86WvhdMw/wmF74xiZ1mEI3Q+Vb5pCNBlGwfAfIfQPFw==
X-Received: by 2002:a19:8c13:: with SMTP id o19mr12773937lfd.225.1614719135990;
        Tue, 02 Mar 2021 13:05:35 -0800 (PST)
Received: from localhost.localdomain (h-98-128-229-129.NA.cust.bahnhof.se. [98.128.229.129])
        by smtp.gmail.com with ESMTPSA id k6sm1619796ljb.110.2021.03.02.13.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 13:05:35 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
        Robert Jones <rjones@gateworks.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [RESEND PATCH 2/3] mfd: lm3533: Constify static struct attribute_group
Date:   Tue,  2 Mar 2021 22:05:27 +0100
Message-Id: <20210302210528.70945-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302210528.70945-1-rikard.falkeborn@gmail.com>
References: <20210302210528.70945-1-rikard.falkeborn@gmail.com>
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
2.30.1

