Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F2A44BB74
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 06:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhKJFz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 00:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhKJFz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 00:55:58 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A26C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 21:53:11 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id g19so1652150pfb.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 21:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LyGojFN74Psdib99ofgTmmS3ryfTtC+JFhiog+TgrPk=;
        b=ThngYRDkGQt/7B2VOWG8P+A2jlEI7zl51h39SDQsT6VW+yMcRYnbiL497063uSki7E
         IcMFmXS1IyaMi2Pf0Twv0tjqsSkBoBz1eVnb41hgNTWJCpwSDR9hDeijlQMXC2PHqTb1
         vLtnCJecNBC7EWKLjBhvTo1Z8QQAhSOLHUTvZF73cQllzW2eSF6LG8qXPVv1nyqb1wOj
         XtjR8KzbTO5KaK2deiYnSVbmvvhs2TsTAdV9vlIzRolvHUqbhY6+3FrNjBhzTUghg0Te
         90nQp+Cqkwb4URA+nh1N6Gl2YdKOO/z84iiZ0QhNRVif6cBA5MkrGPxtYuUcqvgF5eht
         aDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LyGojFN74Psdib99ofgTmmS3ryfTtC+JFhiog+TgrPk=;
        b=4UQxjlfbqlFRn8IW6CXJdtClQdsMf1v2EF2Y9i/h4BsuGeg+HkL8G+rSNjxXD7xNzd
         yCKInUg/CeGj88s4ofx50xb67fPhs420eJtgofQ7WXfUKkJlMEkhD0KcU1e8lWGuw54q
         uYowtrDfywLyPtUfXHd6UZK6gb2pbDbKr+RWuiIwZ8U9xywsmIJDAD+oQ9T+KfY3rXAE
         H+81jHHZH6Y90c3IM2VA9WtHYWq+bFQMI7Zkw1qo4FE7eZqJ/et/FqXswVfY2oGoV/3y
         LTjnoA9nMKzZyWgRJ1dS9+/eGtR4OoMQy441oxgxXDERYbah8tPEXnoX0s/k8OXgCmM6
         C+gA==
X-Gm-Message-State: AOAM531PphcdwrViA2t8gjHnwur7B17VhZRlnrrNPpvkrprP0XHx5zEM
        /Rui82Gt4B9JwsvTJrBntyk=
X-Google-Smtp-Source: ABdhPJzzQYRnfFYf2r5U3knJCyJSBudSz80FotI/m9UuQMmpjvonKh1lzwKN3av2iyVBA0LUNF06Zw==
X-Received: by 2002:a63:f644:: with SMTP id u4mr10295033pgj.300.1636523590625;
        Tue, 09 Nov 2021 21:53:10 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e15sm20604742pfc.134.2021.11.09.21.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 21:53:10 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     evan.quan@amd.com
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        lijo.lazar@amd.com, luben.tuikov@amd.com, kenneth.feng@amd.com,
        andrey.grodzovsky@amd.com, Jack.Gui@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        ran jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/amdgpu: remove unneeded variable
Date:   Wed, 10 Nov 2021 05:53:03 +0000
Message-Id: <20211110055303.136782-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ran jianping <ran.jianping@zte.com.cn>

Fix the following coccicheck review:
./drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c:1174:14-18
:Unneeded variable

Remove unneeded variable used to store return value.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index a4108025fe29..b0bb389185d5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1171,7 +1171,7 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 				   enum smu_clk_type clk_type, uint32_t mask)
 {
 	struct amdgpu_device *adev = smu->adev;
-	int ret = 0, size = 0;
+	int ret = 0;
 	uint32_t soft_min_level = 0, soft_max_level = 0, min_freq = 0, max_freq = 0;
 
 	soft_min_level = mask ? (ffs(mask) - 1) : 0;
@@ -1216,7 +1216,7 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 	if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
 		amdgpu_gfx_off_ctrl(adev, true);
 
-	return size;
+	return 0;
 }
 
 static int sienna_cichlid_populate_umd_state_clk(struct smu_context *smu)
-- 
2.25.1

