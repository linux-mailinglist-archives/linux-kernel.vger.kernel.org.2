Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C85938994F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 00:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhESWbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 18:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhESWa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 18:30:59 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146D8C061574;
        Wed, 19 May 2021 15:29:38 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id w9so7651906qvi.13;
        Wed, 19 May 2021 15:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=et03yqOqpGISagTVprudhL8f3OBi+8uNy9K7WISaF/Y=;
        b=eQ0LLHVS2iqUAS55C0Px09pwDqv5GGxEeF0CjYIacd8LmrlYAJ5qblbwCI+n1GuVfB
         PGGEKdu7PpLzUp6nQyYMedahroHR0wD4fdWgqBEC8vqjqt0rRCF3QGEoBCvuiY3/hwl1
         p65Cu+Mf4+CxhjXnx1noO+E0ky4iRNNxljW61Ro4Nk+trVde/75aD/ocPzTR0OAte5hB
         xLx83g8ElGigR18Jam+Gd0icUtPP+pMMFPiA+ayv0U9PJ55aSpo211Ug1cdEZ7mdTtyc
         a9sHCXTKUpaPalE9y9aKl2Ht0PVgdW2ESpUVsBWHuO5rZuequF9d5rZW6uKUWlFnk+Of
         7Lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=et03yqOqpGISagTVprudhL8f3OBi+8uNy9K7WISaF/Y=;
        b=YOzMmEgONliW8K/A3ozOmOOnEQ1p4CKnsej3O/yXLlkcldRnVsTDdxKfZcUWKXFJEA
         K6ua9lo8q0UObCpdzlHxvZFmhs0g2JsCH4RT8wt1xdOxdwmaqbaCeFq7asUPgGr7Avwt
         VpJmmp4wDOYQrQ7MTx1Ap3BGNL8qjl7fw/QnRqk/8GFn8k51EKQTynmzEQ/hqjH7/HfF
         XXwvVRhlDMVgNwAayuWh9xr2v4fxHKXG1SwmTnpRkQC097klvka1xrO8ZwIodOefAVPo
         vOq0xtHThl/lY/nXUkL74cFdHtPtzZAtOs0dtgz7s5/V6ijojQah0QF1zTFL9POXfJRb
         dRhw==
X-Gm-Message-State: AOAM530bCkRv7G2K+ccfnUr17o2PRRSaZOfWbtL2IXI5reA9awqErudX
        /MYlpf+cqCtn1J/5WT4Wwyg=
X-Google-Smtp-Source: ABdhPJyYgop2L9XXJtM3xRPTZJ8tQa3aD7YxBqAp8WcZwd8S8SZF6L4YCWEZm/XS5nF3ARpEntqACQ==
X-Received: by 2002:ad4:5fc6:: with SMTP id jq6mr2100635qvb.43.1621463377227;
        Wed, 19 May 2021 15:29:37 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:214:8175:da27:c352:bf96:2102:fa64])
        by smtp.gmail.com with ESMTPSA id d18sm823716qkc.28.2021.05.19.15.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 15:29:37 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v8 1/6] w1: ds2438: fixed a coding style issue
Date:   Wed, 19 May 2021 19:30:41 -0300
Message-Id: <20210519223046.13798-2-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210519223046.13798-1-sampaio.ime@gmail.com>
References: <20210409031533.442123-1-sampaio.ime@gmail.com>
 <20210519223046.13798-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an if statement and, if the function goes into it, it returns. So,
the next else is not required.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index 5cfb0ae23e91..148921fb9702 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -154,11 +154,11 @@ static int w1_ds2438_change_config_bit(struct w1_slave *sl, u8 mask, u8 value)
 
 		if ((status & mask) == value)
 			return 0;	/* already set as requested */
-		else {
-			/* changing bit */
-			status ^= mask;
-			perform_write = 1;
-		}
+
+		/* changing bit */
+		status ^= mask;
+		perform_write = 1;
+
 		break;
 	}
 
-- 
2.30.1

