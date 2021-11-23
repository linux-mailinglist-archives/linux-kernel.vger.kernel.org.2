Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07771459FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbhKWKT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbhKWKT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:19:29 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A0EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 02:16:21 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j3so302574wrp.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 02:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DZJ0pxIjHebOIgHJhAjt85uASRoyNqvHRW8sK2dJsck=;
        b=bzqyFoJbju0H64NRMsrmMZPfpjr6ROaZo8mf5XCxAiGcJuX4YJOG31hfSbdILuooPS
         U5geXhNTfP1fwUpGVfOXKvLgtt/l1Y66uautoDjwxrwLgfzzvcHrWVoAZQe49anNSmnf
         aPulz+ANJc60ImWLf+pXusZJMViYjzYeKiaoNTk0u2Vyq+aaqa0Ce4RKxOEENp6AD6nx
         ZeKT4bu959EfWnu+GcqjslmsECg72A//xZht1ScKMhUO0ymw1o+KwFbGPGC4jnNkPH19
         gjUCFMkBdkgKu63HsoY/Xa9udovlA/QqAm4m0fbaCk/KdvMrzhGymh7F8L+Ty6Ts+SZa
         krEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DZJ0pxIjHebOIgHJhAjt85uASRoyNqvHRW8sK2dJsck=;
        b=r/4aa5cFyB4DWoBxFLboWl4Fa7cvFd9fqQUZfnyhQjy4YEpPWuUABIfWgPtRhyNVNC
         mkToQyMfONdO7+9TN6XXfg/WANASB1AaJN5/3i2KqL+Sn/3hoRQ5xVUgyP05vWp6J5C8
         RERliwVsUsNIKoLnUhILG67rNTXqP2CkopQJxX7YcdJDTNsKKvh7oGS9Q9yhhIRnImOZ
         bda8njgoukcewRgWsh6Czd4TVTSMLaWiXQ3EbVncNeBnbAkygf+ZrYm4z8jGOkUmBpjQ
         nZzhZNRf00UR70ff4D++jI2MTaP0/WB21AxyVPAtitV7ASiTn1CUdiVz7EV0O7oWVUND
         jgtA==
X-Gm-Message-State: AOAM53395FTtkEDBqH5xXX1QdEoK3/+mdQqD1OfBsQtW2ti/5+cbTi6X
        WB9NaqJcnaLqqLqkx2iKXV06bwj3Gq3igA==
X-Google-Smtp-Source: ABdhPJzqtQ0HmeHz2vTPiJcVo06FjcO174hKk/G8QqiqKsfPzWuVOiWRWIKAxLuj0ZtHtYrjs5mPGQ==
X-Received: by 2002:adf:fed0:: with SMTP id q16mr6033330wrs.276.1637662579661;
        Tue, 23 Nov 2021 02:16:19 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:3c04:dd20:bbdc:7a85])
        by smtp.gmail.com with ESMTPSA id v8sm11492662wrd.84.2021.11.23.02.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 02:16:19 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Subject: [PATCH 1/2] powercap/drivers/dtpm: Remove unused function definition
Date:   Tue, 23 Nov 2021 11:16:00 +0100
Message-Id: <20211123101601.2433340-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dtpm.h header file is exporting a function which is not
implemented neither needed. Remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/dtpm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index 2890f6370eb9..d37e5d06a357 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -70,6 +70,4 @@ void dtpm_unregister(struct dtpm *dtpm);
 
 int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent);
 
-int dtpm_register_cpu(struct dtpm *parent);
-
 #endif
-- 
2.25.1

