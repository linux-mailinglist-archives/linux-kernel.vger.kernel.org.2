Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E87F445270
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 12:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhKDLsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 07:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhKDLs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 07:48:26 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE004C06127A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 04:45:48 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id h16so3831028qtk.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 04:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/2WJqaVYhuq6wTw0tIcFjPg6e6m2r5+/w0N9M9mupaI=;
        b=JdCXqYNRVSxvo5xDVJ+/1P+Q9vaP8HpOvkzdIIKuOqbsOfyrrh+OEjXiU8PZRQ0geh
         DANIt6SVenHdLpCOvC2pYwvSRo8SMiXegQdsr8lg1likR/mMkQmUa/4mBG8jWt6cmo8y
         AdObaQC0m1Xp1SwOGySSjMKaLcAj1/vCO8cbMPD4Yi+YNr1eLow8tyv4rKVZS+GOWD3q
         b5HsFyUV2r0UldosUzkF0jK2bl+OpeAwcHf0YCJ0Ecxieyd+pxQAEWfALaCAyDbwFvvM
         Vui/1EOcAbo9V0ntgeq75DxizHM8Zh5XAT1jcURkN3U0VZuNJfv23ScKcPIadyeg5q1P
         ZVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/2WJqaVYhuq6wTw0tIcFjPg6e6m2r5+/w0N9M9mupaI=;
        b=fXdGZV0UDGPer+4KI4X2LpHBvxGimtkObR/Ly0y110QW4L38DUspUyB79I4QnzZVBf
         YVnJG5OUJ1GjxeFdCQiEgxDV6rtDvITV4QQ4KOy494tNpmuy8ejl5YrfqqqLuhiIAtx+
         WHZ+/6uJaEZ1H26lcLFyjJDrGZox8Hhcnhl6KSFsXDVAYSE26WKkSQKNfhW25ZEr97+E
         qWRnYJ3mVKvBdOEl4tZ7C4Cukj1LSt/zVsLK6NCHrpmJuZ+mjzRCBdjVXHW8WQsoDVcj
         yvh1EtzPnzZ4r7jr5Nz9ZE3j5kaK1i8wGoaRZ/xYVeQDh/5ra4aHDjTFGriIH9+MvBr4
         6Sww==
X-Gm-Message-State: AOAM531BWvCZwcqGisFEZjmzxUaR9mXaAHpQqWri7hTIyAZx+gxdb3Ki
        k+5CjGrIgEhJJeZxwbwo7C1ULNzw/ls=
X-Google-Smtp-Source: ABdhPJwUXrahK75+EIlSRy9G40v0/2iNzCNb3m9uwFNU9YeCDZXslCLFJxRPF0HuCpL03uAVxAULbA==
X-Received: by 2002:ac8:5bd3:: with SMTP id b19mr34832937qtb.153.1636026347920;
        Thu, 04 Nov 2021 04:45:47 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i67sm3263937qkd.90.2021.11.04.04.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 04:45:47 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yao.jing2@zte.com.cn
To:     johan@kernel.org
Cc:     cgel.zte@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, yao.jing2@zte.com.cn,
        zealci@zte.com.cn
Subject: [PATCH v2] most: replace snprintf in show functions with sysfs_emit
Date:   Thu,  4 Nov 2021 11:45:40 +0000
Message-Id: <20211104114540.30622-1-yao.jing2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YYJH/lYLQJdM2H1p@hovoldconsulting.com>
References: <YYJH/lYLQJdM2H1p@hovoldconsulting.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Yao <yao.jing2@zte.com.cn>

coccicheck complains about the use of snprintf() in sysfs show
functions:
WARNING use scnprintf or sprintf

Use sysfs_emit instead of scnprintf, snprintf or sprintf makes more
sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yao <yao.jing2@zte.com.cn>
---

Changes since v1:
 - Actually, the robot which is composed of lots of tools includes
   coccienlle.
 - Change the ignored snprintf().
 - Change the wrong Subject.

 drivers/most/most_usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/most/most_usb.c b/drivers/most/most_usb.c
index acabb7715b42..73258b24fea7 100644
--- a/drivers/most/most_usb.c
+++ b/drivers/most/most_usb.c
@@ -831,7 +831,7 @@ static ssize_t value_show(struct device *dev, struct device_attribute *attr,
 	int err;
 
 	if (sysfs_streq(name, "arb_address"))
-		return snprintf(buf, PAGE_SIZE, "%04x\n", dci_obj->reg_addr);
+		return sysfs_emit(buf, "%04x\n", dci_obj->reg_addr);
 
 	if (sysfs_streq(name, "arb_value"))
 		reg_addr = dci_obj->reg_addr;
@@ -843,7 +843,7 @@ static ssize_t value_show(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	return snprintf(buf, PAGE_SIZE, "%04x\n", val);
+	return sysfs_emit(buf, "%04x\n", val);
 }
 
 static ssize_t value_store(struct device *dev, struct device_attribute *attr,
-- 
2.25.1

