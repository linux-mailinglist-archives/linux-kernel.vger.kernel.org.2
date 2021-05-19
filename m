Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0BE1389953
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 00:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhESWbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 18:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhESWbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 18:31:04 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AD1C061760;
        Wed, 19 May 2021 15:29:43 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id k19so11435315qta.2;
        Wed, 19 May 2021 15:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fx2Tmd2WyLpe6PfeJpCMpI9taGaAaW4B0t4BrmsvIRQ=;
        b=ga9FZ+azHDVcO5zIwRRKW3V101vykcHsKPJkEcGvysFIDvAYqs8FFag/spHw3MDBXa
         pS1fyZhYnt45zbNbDHJxbIw5e7Y/IfyuWL3X4981+Dq2UAvJhNU3F+sBM092wY1qHpKm
         LEQsgNk4LbpZxbuJOQXUMCsM9zBzV83qU5kwkc7dbEkIKcbb9EBbUcYhXiW57XnMn7p8
         0oEDuxsFd6JL39q4k31H6y5N9nQp2GsQtrFsNpbKzaRLtcdjEfXsAnCKVVacmEh5C2pc
         YtUebUK0FNLIXTIVHVikr9bVvbykQnNSG4120+CToKVfSWNFYbpcQgx765qidGUul9M3
         RGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fx2Tmd2WyLpe6PfeJpCMpI9taGaAaW4B0t4BrmsvIRQ=;
        b=gOz4cKecGTUvtEmYlAbfBhnpP9k+YLjafruhKN6NjKXHoQyQTYhSszV8nKVZ87SJrd
         wwjeXgwTbK739qXFEpkqjKHsFLYeaYA+GCcIRifPGEGKJipQpXcSf93jJ82Wy9Z6z2iC
         c3YEFY1bIVfHUvxTTVof+ujMbG5xc3lBQ6/awvNGy5SgT+V0lo3whJ+5vQ69nRR+viMh
         9vr8uxjNvuPR34VnAqGmPTmhubWvDb0lKboUsgjkgBrNM1NLNh9FA+zHxO/fkp/ZD/gB
         JmzJO9UFCXVBo9t3KY1Kw1VTCkp6csGUllTSPIQr/Gw2wnxXdLFCbJanGIMgXaV+fgr/
         IayQ==
X-Gm-Message-State: AOAM533RTuh5t2bjmYQWXcQPaFA7Tesyp3Q1knuHt92Vo+Pusrg6SFIq
        VLYeBv8pjb008xcNyeJfc00=
X-Google-Smtp-Source: ABdhPJxq345SOP4tDTrz8TYeQGLmc49Q9aefy7SwuD2lS9uBhB7B9hu31QL8IfDGVsg5Gez+CvflIQ==
X-Received: by 2002:ac8:57c5:: with SMTP id w5mr1878521qta.166.1621463383036;
        Wed, 19 May 2021 15:29:43 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:214:8175:da27:c352:bf96:2102:fa64])
        by smtp.gmail.com with ESMTPSA id d18sm823716qkc.28.2021.05.19.15.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 15:29:42 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v8 3/6] w1: ds2438: changed sysfs macro for rw file
Date:   Wed, 19 May 2021 19:30:43 -0300
Message-Id: <20210519223046.13798-4-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210519223046.13798-1-sampaio.ime@gmail.com>
References: <20210409031533.442123-1-sampaio.ime@gmail.com>
 <20210519223046.13798-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iad sysfs file has permissions for read and write. Changed to the
recommended macro BIN_ATTR_RW.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index 56e53a748059..910e25163898 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -388,7 +388,7 @@ static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
 	return ret;
 }
 
-static BIN_ATTR(iad, S_IRUGO | S_IWUSR | S_IWGRP, iad_read, iad_write, 0);
+static BIN_ATTR_RW(iad, 0);
 static BIN_ATTR_RO(page0, DS2438_PAGE_SIZE);
 static BIN_ATTR_RO(temperature, 0/* real length varies */);
 static BIN_ATTR_RO(vad, 0/* real length varies */);
-- 
2.30.1

