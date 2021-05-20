Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB5F38B6A0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbhETTDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236820AbhETTC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:02:59 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F646C06134E
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:01:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id f19-20020a05600c1553b02901794fafcfefso5400051wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HIrBOeC01necSSZBh3WJb8n11gnvVfu7DpmNSO/Nbdk=;
        b=S3VMEbyBQOtP5mk7L4Z0kvrmwSyAW1Az4ghiLWeUSLmnTheeBe4hplHB1pAfjXxk2J
         1pdySSLkVm+SbFZQqIcOqNLzRgLxn5Dw8p9ITAHRa62sw6sXKC6e3D6blDS/NwyJkHmi
         d3YGCv/Oe/75D6LdEeM5qVHnwKZ4YneLFby22O/hAjtfCWD9jHkAsQsSLXOOUZv43R7p
         K266NV2hzw1ZXt6YkStFZL72OD5a52ptCEgGG/wVx0q9yxogfUa45qb5iXZEET2V8Sph
         AKOpN+Ip03iiVjRhufVncdAvwW+Bax1bJL3KOBBSpvpNgYooC3uFDExasyMCr1gkLq2b
         hE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HIrBOeC01necSSZBh3WJb8n11gnvVfu7DpmNSO/Nbdk=;
        b=n9X+jz4FN6oGre5Mva00tJaEgs8PzquPRHnZOlF8tqR4uxEpnmBTDMn5khM0R2A5BK
         EcNGKcy6hAssh246Rth17176sVGP2rtYuIZ59RK24Z+7IVTbkh2CbLVzh1QN571V55cH
         pB1leiExaxXIkIWqAR0VFH0f5w6u6oFD4U3brfVgLtgg9gVedUixl5Q2vm21wSu6MXLp
         7zXB3c3wOUDE/pYGXRwiOMltVvwewwm+1hFCXrplIH6NTqUEsHT6AXf6zKFkSZej8on9
         TmLVovo4H4dcl9KwM2k2QyNLazTNrbyby9wnjEU1s/HYUMZlZ6SxSFkmiFELtTWi6AWf
         MayQ==
X-Gm-Message-State: AOAM532o/qylE/sZYpxHxeoSTPgQopj6yjYPW6H/VZeZLFmEAUztFn8B
        Ry/rJvLxrFjYqWqJLBAU8hDd3w==
X-Google-Smtp-Source: ABdhPJy8x+5IqIuAaGa3Pu0VZAqeQTQc8GGW/aqUrprIq9Qhf0ZRha2icrPTKw33qAJIeBV/l2AHhA==
X-Received: by 2002:a05:600c:2cd2:: with SMTP id l18mr4974579wmc.142.1621537287095;
        Thu, 20 May 2021 12:01:27 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id p20sm9011899wmq.10.2021.05.20.12.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 12:01:26 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <maxime.coquelin@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Subject: [PATCH 16/16] i2c: busses: i2c-st: trivial: Fix spelling issue 'enmpty => empty'
Date:   Thu, 20 May 2021 20:01:05 +0100
Message-Id: <20210520190105.3772683-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520190105.3772683-1-lee.jones@linaro.org>
References: <20210520190105.3772683-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Maxime Coquelin <maxime.coquelin@st.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-i2c@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/i2c/busses/i2c-st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
index 30089b38044b5..88482316d22a0 100644
--- a/drivers/i2c/busses/i2c-st.c
+++ b/drivers/i2c/busses/i2c-st.c
@@ -524,7 +524,7 @@ static void st_i2c_handle_write(struct st_i2c_dev *i2c_dev)
 }
 
 /**
- * st_i2c_handle_read() - Handle FIFO enmpty interrupt in case of read
+ * st_i2c_handle_read() - Handle FIFO empty interrupt in case of read
  * @i2c_dev: Controller's private data
  */
 static void st_i2c_handle_read(struct st_i2c_dev *i2c_dev)
-- 
2.31.1

