Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0B8419885
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbhI0QI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbhI0QI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:08:56 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873CDC06176E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:07:18 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u8so78629295lff.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v9YOxOqMuLc+F4aMhx8ncDQgU6zkNv5ONWwIowAktM8=;
        b=RWT0ekWC6Htbox7mj156mc+NheV3X1pX0x9qGJixO+cSbXgIns8Dw5R4v58Yi+cqSu
         Qupkcx5O4cKbxf27/lxApjB30zDrdIQRGl1BtvEoU5Grv3CvBgJ88kaEbpJ7ZGp6pAbC
         KSwki9mj5VCUYCPKJAnBQLLjz8Qszx/q2+mlsN4pj4uNVjIQHjkglycau7IqrKMGq9Nm
         wFVTsoLEymRaBu1IEvLeEN312f+3OzsmSzHJUp038zS0tS6X4LMAf+dTmJUaZNBQGjLj
         ngC/t2qsegd1WEdwvlw4oAoz1Yk1IOljEVjYG4XLAHfDVnJWiLsrw63qCT+GwvDbFhqP
         gLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v9YOxOqMuLc+F4aMhx8ncDQgU6zkNv5ONWwIowAktM8=;
        b=KI4o+QxZmBkpMXWpTxFcRJQZXgaZqp2mggO592B6vi+dscFASMlxcOGGVVYlbnt45D
         xzGWRiTTnfn2V00ztI/kMW45FJMF95ZU185o37CUGL7wWaF3KPZ4HdKnWEqD5rSxgEgs
         6khsisZDCiPWIqvAvkgzG8MMMXn505uw+Y9dl8BFtdvkT10zqFeO4+4dXN0r+CkXq8fX
         xMIDYfFpSEg2gWvLRjLR+Bw1Lmny/l08U16Euq2QqzF/bjvcAoljhYTz+oVju2MdYojK
         THVZAsUJ1i37xdqcxe/MyZyZzszVPMl5SZjImFGPnw1r57NG3QmwwisQJ9LoduypAhSd
         I0hA==
X-Gm-Message-State: AOAM5332PUdTMewTVHA6dFRwRBOMSq3/NspfMet8LwhD8tQgap7zodAW
        fo9ba04h//LqK0S0I1UmOGcqUOhVNiuoqX5Z
X-Google-Smtp-Source: ABdhPJwxAjNDuvwVhi+Tgto7o7+YxSo10UaS6vYWk7TYy1pGVQleT8uzYvxo86nnBNeF1HQVD3Oprg==
X-Received: by 2002:a19:911d:: with SMTP id t29mr513356lfd.407.1632758836302;
        Mon, 27 Sep 2021 09:07:16 -0700 (PDT)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id k20sm1639441lfe.271.2021.09.27.09.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:07:15 -0700 (PDT)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] staging: most: dim2: use if statements instead of ?: expressions
Date:   Mon, 27 Sep 2021 19:06:49 +0300
Message-Id: <20210927160649.29209-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <YVHoXyULqXsWktMN@kroah.com>
References: <YVHoXyULqXsWktMN@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better maintainability, replace conditional expressions with if
statements in the drivers' probe routine.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/staging/most/dim2/dim2.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
index 9300040ec84c..e8b03fa90e80 100644
--- a/drivers/staging/most/dim2/dim2.c
+++ b/drivers/staging/most/dim2/dim2.c
@@ -732,7 +732,8 @@ static int dim2_probe(struct platform_device *pdev)
 	struct dim2_hdm *dev;
 	struct resource *res;
 	int ret, i;
-	u8 dev_fcnt, hal_ret;
+	u8 hal_ret;
+	u8 dev_fcnt = fcnt;
 	int irq;
 
 	enum { MLB_INT_IDX, AHB0_INT_IDX };
@@ -765,16 +766,16 @@ static int dim2_probe(struct platform_device *pdev)
 
 	of_id = of_match_node(dim2_of_match, pdev->dev.of_node);
 	pdata = of_id->data;
-	ret = pdata && pdata->enable ? pdata->enable(pdev) : 0;
-	if (ret)
-		return ret;
-
-	dev->disable_platform = pdata ? pdata->disable : NULL;
-
-	if (pdata && pdata->fcnt)
-		dev_fcnt = pdata->fcnt;
-	else
-		dev_fcnt = fcnt;
+	if (pdata) {
+		if (pdata->enable) {
+			ret = pdata->enable(pdev);
+			if (ret)
+				return ret;
+		}
+		dev->disable_platform = pdata->disable;
+		if (pdata->fcnt)
+			dev_fcnt = pdata->fcnt;
+	}
 
 	dev_info(&pdev->dev, "sync: num of frames per sub-buffer: %u\n",
 		 dev_fcnt);
-- 
2.30.2

