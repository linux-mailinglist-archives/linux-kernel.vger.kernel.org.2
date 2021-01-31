Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9C4309CDA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhAaOZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 09:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbhAaNhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 08:37:46 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07782C061756
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 05:36:57 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id p21so19035590lfu.11
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 05:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=owYPAXP97fE79exrcBFQ4vpgDGZ1Hehp9yHvgr4NMpo=;
        b=kRyg2ugodei/QSihlzZi6Kgi1BBV/FDcZw3mO32Mf3QELz6elUAtiM1jFNtxDW0SxC
         mMHQ3KkccHy1Lt+1Dqh/cFfPEhCz/wjXwcY1sMwAHl19+2di0hIC72qmkAaTqL8zBWsJ
         ZuRxzjdnlOGzJK/AzwJgoeluB+Eq5B0Icp+XGiFsiorSfuNOibo1YPzarm2A0N2Xl3WX
         y0/bVYoJBK3t3u9DOV3lvGpegQqHKL9V5beSPWZFsO+npEddCQM8yT+4/v0B/CjGkyps
         KBC90SwL9RllQS2/ob9+4hJsptJweQAG92ZZ6yLPmSErSfHA+EVK3BzUz644RB9S25Ku
         4UHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=owYPAXP97fE79exrcBFQ4vpgDGZ1Hehp9yHvgr4NMpo=;
        b=c//zg5/X6mCdP4eJ9zvP8GETV1l7gajpqh5DC9jbqstwziP3KxmwwTIUdBgj6A8YdG
         HbtX8Ac7YOdiZDty4V3vEjeQbDW96Eiw6rREsdODggeGVBR78eYCti6eHCcpFlRfz99Q
         fleQw2MeBU1lDL4BNR76DtjybXxGNvME16EJrbIbFLecORRccYEUwBucO/g0R+hZePmR
         UIqCHbuHZwtnPC9W50YyYRT7ylnJj/xyLU6kE3oWBweHRDxcFLXsSBq6Cji3QQydHAJM
         kfn5aDpyB+A0SKOzTHC26PR3q1dYWBwGOBN29ax1bfH9P1lGRm5EFTH8lZIdGtS/4Tty
         9lTw==
X-Gm-Message-State: AOAM531umc2W7r0mtwFjMZLnLNvYd17noNygsPT8gNGV4LseO2e3IftL
        wag3vhgT+gicqEiFj/hSzXg=
X-Google-Smtp-Source: ABdhPJwzKPNeVuiwUQ8dNBNDVy6N9yVozUmadXXq4V1UWq2+0y3PJEwVOBH6PY4DcM/DXQ0Ap7t/kA==
X-Received: by 2002:ac2:4a8b:: with SMTP id l11mr6411508lfp.569.1612100215598;
        Sun, 31 Jan 2021 05:36:55 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se. [158.174.22.164])
        by smtp.gmail.com with ESMTPSA id m8sm3391216ljb.32.2021.01.31.05.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 05:36:55 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Robert Jones <rjones@gateworks.com>,
        Tim Harvey <tharvey@gateworks.com>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 1/3] mfd: gateworks-gsc: Constify static struct attribute_group
Date:   Sun, 31 Jan 2021 14:36:42 +0100
Message-Id: <20210131133644.8834-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210131133644.8834-1-rikard.falkeborn@gmail.com>
References: <20210131133644.8834-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of attr_group is to pass its address to
sysfs_create_group() and sysfs_remove_group(), both which takes pointers
to const attribute_group structs. Make it const to allow the compiler to
put it in read-only memory.

Done with the help of coccinelle.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/mfd/gateworks-gsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/gateworks-gsc.c b/drivers/mfd/gateworks-gsc.c
index d87876747b91..8745f9d8c26f 100644
--- a/drivers/mfd/gateworks-gsc.c
+++ b/drivers/mfd/gateworks-gsc.c
@@ -150,7 +150,7 @@ static struct attribute *gsc_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group attr_group = {
+static const struct attribute_group attr_group = {
 	.attrs = gsc_attrs,
 };
 
-- 
2.30.0

