Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED4A317320
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 23:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhBJWQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 17:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbhBJWPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 17:15:48 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57366C06178C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 14:14:57 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id l12so4899991edt.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 14:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rqc/GNzS3OhAYcsjBHiaYbzkuH2zCrmHds0Gceno4C4=;
        b=QY0/hsZvZE7CrklzWb3YGjinfA/mjhKQj4IV6arHMFhP/6YgIQzR08XgCTm/8YdVer
         dLAhJ6EhowREU2pZQqsd0PX+rjs7C7xuLfCq7djXvg6L59iwpDoM42IKMEGg+/ZMHjod
         1WyGENSbiKcS51IQBE0iNs95e14ds1mg5kEp7+lU1DeMr9L5+X3dspllWwuA+yLRMfOl
         zocBeH6CjJnZ6lLCE/ZuAB4Y5JE9ThLrLoly6uFB2lQgLtd5Ez2G1EIo9ksbiT7T0dix
         iAUPCEORmQFyN8K9XnMiE0GwuKPF5a0h0ddK2xyLVerMxTZBIH9cfCwjPl48tjhJr3R7
         Huwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rqc/GNzS3OhAYcsjBHiaYbzkuH2zCrmHds0Gceno4C4=;
        b=h+VPtbkHZR1GJprpl3X+CCdJQfHtZCgb1w5VzT5F1nq/24r8L9bJuQC9o8k5rdMe1e
         hkmex9C51wWWeI9WxxzSqYth67T2DrOegJ+Xbb2isMG+9vpd9qWRGGDcrb1Q+EfQ14Ai
         +HGb6pGmIdzCCs2UYx85o/rA/Hsj1/T2IEOy0xWlVguEfMnsHCgWuR8sqKtT0BBMBd2x
         vwKuQoXo3Sfzn5c/8PTuaYDQmoy8/RXB9wiZAZbZpMMQl9Ty5auMdIZjXxnSwDiRbY/s
         DzB9aqfQWhbZF3+lgVTXvdpHVPI+uHbXma0EdWlZtMX0OziGDS5Ieuwqv6jbkXcUGkAM
         u0yg==
X-Gm-Message-State: AOAM533mrMehBOM7T1d2iOLLWX664TLr+w9+KxKszAbaLVnIJdRCRkpG
        HQk64uVKMZJoVSozBKQam6c=
X-Google-Smtp-Source: ABdhPJwuC4q7QPIxZVE9dlElpGqJ1xYm+4iq1/sN4CEJTcgXM8gpWe6TrvOGrsyMsZUAV+V4+mVu4g==
X-Received: by 2002:a05:6402:1589:: with SMTP id c9mr5441722edv.282.1612995296012;
        Wed, 10 Feb 2021 14:14:56 -0800 (PST)
Received: from TRWS9215.usr.ingenico.loc ([78.190.146.52])
        by smtp.gmail.com with ESMTPSA id b3sm2130578edw.14.2021.02.10.14.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 14:14:55 -0800 (PST)
From:   Fatih YILDIRIM <yildirim.fatih@gmail.com>
To:     pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, yildirim.fatih@gmail.com
Subject: [PATCH 1/1] Macros with multiple statements should be enclosed in a do - while loop.
Date:   Thu, 11 Feb 2021 01:14:39 +0300
Message-Id: <20210210221439.3489-2-yildirim.fatih@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210210221439.3489-1-yildirim.fatih@gmail.com>
References: <20210210221439.3489-1-yildirim.fatih@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Fatih YILDIRIM <yildirim.fatih@gmail.com>
---
 drivers/staging/greybus/loopback.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
index 2471448ba42a..c88ef3e894fa 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -162,10 +162,12 @@ static ssize_t name##_avg_show(struct device *dev,		\
 }									\
 static DEVICE_ATTR_RO(name##_avg)
 
-#define gb_loopback_stats_attrs(field)				\
-	gb_loopback_ro_stats_attr(field, min, u);		\
-	gb_loopback_ro_stats_attr(field, max, u);		\
-	gb_loopback_ro_avg_attr(field)
+#define gb_loopback_stats_attrs(field)					\
+	do {								\
+		gb_loopback_ro_stats_attr(field, min, u);		\
+		gb_loopback_ro_stats_attr(field, max, u);		\
+		gb_loopback_ro_avg_attr(field);				\
+	} while (0)
 
 #define gb_loopback_attr(field, type)					\
 static ssize_t field##_show(struct device *dev,				\
-- 
2.20.1

