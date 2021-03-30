Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8951734E634
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhC3LOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhC3LNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:13:46 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395FAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:13:46 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id hq27so24198570ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C30ItJrm4o8C/5G2fGbSpn0vn8FcJHz2ObwGKCIapvc=;
        b=WmLsrtrHh4hw4fsS1UCKj1jrPCJQrIWeI6pwEYRgQJRM5qsz2vS2b4mheybWEdaVuz
         9Wyfs449m2vWBvbfnETnbbDeAwXbqww8kxuWfNCb001l9Gjr8Wg2EcTUka6D+7mncouZ
         opv98ba1OaCrcksYvylnZMSeh11ySQb35fiE3RTyFKao5XF2BJTRRMrXohXQ2pdEMgbz
         3fGFaP/kW7LJngf7iJ97daGoG46+MRXvku8gNbWE1ohkp3wVjxbU+gNA0XPfaOs+6HUj
         BxPSrV9otpO0aLb1os+sVigoQBbEqSAPpFFPg/GEaK6WMtQ2g+wXwLYZFaR8NY/6wIQF
         bdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C30ItJrm4o8C/5G2fGbSpn0vn8FcJHz2ObwGKCIapvc=;
        b=bnaiTxjlWKotwD1MEwMN9jn4DnZitIdHAGIOUG9F4IkDPyfCYQdVh6D3HhDbYvn7x8
         HtGLxnA2VX9o/eyIO4Ji032nlTMcTp8de88MvdotrQTHpU7m5i+wGIDrNRLsb6D9EYT5
         F2ULj79ZJSrupmCO5GJ5Q5hG9iw259x5mqzECXU1D0ccnUKIQET5War2EOIvt/Du/Bis
         UwKZaMhkXJVSbN7B+0cB/Qnh2Ywz+gzz1nhgRDWx7iEzcrRUSfDbyjEoXOXvoS3gNEw3
         39Bjlk9pXhrL75RoPPNeRRkD6GSizmlgxk6ILabaPpBZu718s3y3yUmQAEOkL0bXDEKl
         CPPg==
X-Gm-Message-State: AOAM532Wkac7a6W5Z7x9InqI7kyC0RuGybH5QswOe4Slgjxd14ikgmO1
        OzRdA2Tk9ZwBD/5x6jr+gGqalg==
X-Google-Smtp-Source: ABdhPJyOv5WvrIjY6XnV50BdyPMVZ7OdCsPlwzXNoCaKgG4ZZUGRXuGGS0j7oIN6v62I/kbKnPOLoQ==
X-Received: by 2002:a17:906:58d6:: with SMTP id e22mr32128120ejs.112.1617102824947;
        Tue, 30 Mar 2021 04:13:44 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id r19sm10961308edp.52.2021.03.30.04.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 04:13:44 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Douglas Anderson <dianders@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 07/10] nvmem: core: Fix unintentional sign extension issue
Date:   Tue, 30 Mar 2021 12:12:38 +0100
Message-Id: <20210330111241.19401-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210330111241.19401-1-srinivas.kandagatla@linaro.org>
References: <20210330111241.19401-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The shifting of the u8 integer buf[3] by 24 bits to the left will
be promoted to a 32 bit signed int and then sign-extended to a
u64. In the event that the top bit of buf[3] is set then all
then all the upper 32 bits of the u64 end up as also being set
because of the sign-extension. Fix this by casting buf[i] to
a u64 before the shift.

Addresses-Coverity: ("Unintended sign extension")
Fixes: 097eb1136ebb ("nvmem: core: Add functions to make number reading easy")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 635e3131eb5f..bca671ff4e54 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1693,7 +1693,7 @@ int nvmem_cell_read_variable_le_u64(struct device *dev, const char *cell_id,
 	/* Copy w/ implicit endian conversion */
 	*val = 0;
 	for (i = 0; i < len; i++)
-		*val |= buf[i] << (8 * i);
+		*val |= (uint64_t)buf[i] << (8 * i);
 
 	kfree(buf);
 
-- 
2.21.0

