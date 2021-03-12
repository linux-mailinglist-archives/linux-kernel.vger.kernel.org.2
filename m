Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C617333934E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhCLQZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbhCLQZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:25:15 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596CCC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:25:15 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id w8so5383858pjf.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iXhTHlq228l+0iB04Y1r45kd4DhCxMw3571PP4zILAA=;
        b=VEmmh5X9fa7g3DiKuaT8KWl1POaMjOAm+T7VEA/s9HtE3LAT5keAH5jFQKyhSL/xMS
         9uJBXewfM5+b2Q2pTgzWrVmV+u5Zklkra+XF6ZoMjwzwl3nDrYS25Sca4ZwK34BjwuaT
         fKdOhGmGki2L5vZnbr5jVEN6XKD47xT2oYXdqvo0L1b8XCgR1uYJZdPlUcn/aXTAgURg
         I89r80V6WlTTOdGZi7HbkMFBU4jDHk1ojvazPOfgEmHUj9IT73xhKzFO6Wf7Ptw2JyoU
         U0VILhPzwdvcAg87OIl0CFSYeewaobSPcU6c2uZ3UFeD0/cPDtw51Z4qZKVRZebEgqPA
         pFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iXhTHlq228l+0iB04Y1r45kd4DhCxMw3571PP4zILAA=;
        b=IwB2+E1a3wrBY3zKDfmBPWtK3ryedi2R7L/zbjaw4I7K8lVAi8XI2CCDhUn8DCQEaS
         hPZ2jEuFdDXq80bGhwJTgHKcjJ94ud+/Kv9mqxo0ekgYvMdnP7/5pL1ZOzgYlz8sR6cq
         4fsvnaINjWW+Hr3acvA5U5vpYQ+huOEVFA//dWdywaqZlnwvlC3e7jxzi6cKIFCqPvQD
         pXtVicHYwj2X+CtUVOiLGowdjBD5w24FArGviEEPuoPI6n6C/L7hsqRbMUanMwUN1I+A
         HKCm6UfNKInyNbs6OhAhK7fupkwAirxuV1e3vL/ZbbccHTOQOrnaYmoPagy5aE/a7fJ7
         LyCw==
X-Gm-Message-State: AOAM532gXO8dzd+dBo++DYaI507CVOqPJr+tL4nhTqGfHZ6rswmbLdfB
        8DFjVoJPwMlgeuz4707erlQtlA==
X-Google-Smtp-Source: ABdhPJy+d0zi50bylh7i8kcjhGz8ezrVQ0JqGrqHc3fNPEHAakRBEC7HmvAmHSP7MeuNaCrxFhnHAg==
X-Received: by 2002:a17:90a:a618:: with SMTP id c24mr15091131pjq.108.1615566314572;
        Fri, 12 Mar 2021 08:25:14 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e8sm5899599pgb.35.2021.03.12.08.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 08:25:14 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 17/17] remoteproc: Refactor function rproc_cdev_release()
Date:   Fri, 12 Mar 2021 09:24:53 -0700
Message-Id: <20210312162453.1234145-18-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
References: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor function rproc_cdev_release() to take into account the
current state of the remote processor when choosing the state to
transition to.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_cdev.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_cdev.c b/drivers/remoteproc/remoteproc_cdev.c
index 2db494816d5f..0b8a84c04f76 100644
--- a/drivers/remoteproc/remoteproc_cdev.c
+++ b/drivers/remoteproc/remoteproc_cdev.c
@@ -86,11 +86,17 @@ static long rproc_device_ioctl(struct file *filp, unsigned int ioctl, unsigned l
 static int rproc_cdev_release(struct inode *inode, struct file *filp)
 {
 	struct rproc *rproc = container_of(inode->i_cdev, struct rproc, cdev);
+	int ret = 0;
+
+	if (!rproc->cdev_put_on_release)
+		return 0;
 
-	if (rproc->cdev_put_on_release && rproc->state == RPROC_RUNNING)
+	if (rproc->state == RPROC_RUNNING)
 		rproc_shutdown(rproc);
+	else if (rproc->state == RPROC_ATTACHED)
+		ret = rproc_detach(rproc);
 
-	return 0;
+	return ret;
 }
 
 static const struct file_operations rproc_fops = {
-- 
2.25.1

