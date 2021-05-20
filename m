Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381C438B67F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbhETTCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbhETTCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:02:33 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC19C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:01:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so5829160wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uDuZrk4UNMKTd6gnOhV3WWQzrwgx7DTKW4HaKm1ez8s=;
        b=OxzNzvSl5dKEJkHxeZLPOEiYfu84JT2ULxT0aBFA+R1FLe0OI0tceeEhC572Hl1bFf
         XPfA0V5ZcH8hRr9YWsLuduCFexwc0DXbXm3BODq+bTHOtYrmhjLRdeQ7pgRlfTp1rrX9
         vdow26GL+HV+vGUAtRovh7H/dJafI3fUZ7TutM6GQFQh9yX2JcByXnH8OzsWL6ihLGhW
         aVm51sDbseOXXwmRdEjfUDUXaCI3EQVRFbUA4LOcb3301ZfmaNEH8T6CeaWl/vXXHtOh
         1iBXdY3K1ck6dxFYTulP63PEAYfvtZU4pnKSj53DkQs4ES3NLdS1z6EoJjL1Mz6L4aGl
         eRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uDuZrk4UNMKTd6gnOhV3WWQzrwgx7DTKW4HaKm1ez8s=;
        b=lrS9NtMB3y5gei0POw5aNcYvStBYAXlq8rp3pXWTzYF6x3kh7a1F3xASe/feyA/OlF
         8dvD32tYRV7cKiNmTvtNVNXkvr2WXgDR+Qda86S9Ys3M70j6Ceafg/yH4B6b1W9VdDHy
         N1qo9yZrMqwzl/oce/onuj4QgzT9q3kZt26DY8JAiCQXh7BF5tqDqnUOMsAe6pH1LgxV
         3OhWWcK/2fJNedej4Fol96MR79YnxWMSpJNwr46qJObkINMcxkEiSLcgIufbOWrPP4q+
         Ed8BBbzeAOwARraFKkmXlVjP9Ytr03pxI6hZvD7BMdcNvO8v7bxOdiM2qE4gJcQVNe1X
         dOjw==
X-Gm-Message-State: AOAM532+7S+VYtEP4mD1JzAmlH18zydqEcwroxZYWLYtiyrJKxyD2jjZ
        22IZBlYORD6VluhuEFiVlopXlw==
X-Google-Smtp-Source: ABdhPJxkYe9slV0umxG1OOeypjcUJw/is/y1omVhYmkam/q2HJPQdvADPp/hCtt/a5wsfMW8yYA5Lw==
X-Received: by 2002:a7b:c14f:: with SMTP id z15mr5500694wmi.149.1621537270416;
        Thu, 20 May 2021 12:01:10 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id p20sm9011899wmq.10.2021.05.20.12.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 12:01:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
        Sachin Verma <sachin.verma@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Subject: [PATCH 01/16] i2c: busses: i2c-nomadik: Fix formatting issue pertaining to 'timeout'
Date:   Thu, 20 May 2021 20:00:50 +0100
Message-Id: <20210520190105.3772683-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520190105.3772683-1-lee.jones@linaro.org>
References: <20210520190105.3772683-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/i2c/busses/i2c-nomadik.c:184: warning: Function parameter or member 'timeout' not described in 'nmk_i2c_dev'

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Sachin Verma <sachin.verma@st.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-i2c@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/i2c/busses/i2c-nomadik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index dc77e1c4e80f9..a2d12a5b1c34c 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -159,7 +159,7 @@ struct i2c_nmk_client {
  * @clk_freq: clock frequency for the operation mode
  * @tft: Tx FIFO Threshold in bytes
  * @rft: Rx FIFO Threshold in bytes
- * @timeout Slave response timeout (ms)
+ * @timeout: Slave response timeout (ms)
  * @sm: speed mode
  * @stop: stop condition.
  * @xfer_complete: acknowledge completion for a I2C message.
-- 
2.31.1

