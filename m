Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94063173E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 00:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbhBJXFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 18:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbhBJXFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 18:05:24 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819F4C06174A;
        Wed, 10 Feb 2021 15:04:22 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id t5so4953580eds.12;
        Wed, 10 Feb 2021 15:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=91MESKnC1MhIt/jwzEzebE9493kbhWyUvwXaIA3Mid4=;
        b=K/aiZvABimqe7FbqOGdmVgewChkSrWbAATd8jWlR9fCwgE77r/9/mhoSpgKS3RwDM7
         bGcQ6P57XYC8phugX5DG83vLKQj0vXk/iHD6wqQzUPIestGB2fMQUQ07QI+CwvKJLsU2
         In0WNJR9YU+jXhvZ1EqLIrP28PDrqD7obsmWkcCUSlioIAZhOon/4D4eF3+QLs4wHkHk
         qXBuzlGiUJZq2NTJzwtW6fpjWkGWz9d2OfTGkh5CO74JJJ9Qkk4lMa/R+qKaREOSnTOC
         mEiUXYjb9oUq2K0TgiUi1MIuFC0k/SScO/zJ7xJ7IqIW+5v4jszM3qdnQ10WQ8iMClLF
         nBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=91MESKnC1MhIt/jwzEzebE9493kbhWyUvwXaIA3Mid4=;
        b=Ku1utY2i9RtUkt9I29fZ7FFfgRbvhFjDGBc6ODFA9hJ/O9d1vLJb5L5T67xtShOPql
         3xKJp+zzz4903RmA2NtQlYZLZQuia6OchkNuZY4iw2g3GuJvaKnfpLG3X6GqNBcmKJ+P
         F7Q6Xl2nL6B0q8Jy1Di2zQ6MGzWAfLWzctHDqJQnvrqXYmDkshg+gcNu6O7LBh1zwoKR
         UXnyzM9oa+TMOfdaD5nMF2ZUIjULuu13Q16yrAQt0b2DS6drvmntv75j8mZ3wbT75DRC
         OCssodpIp3/7nZqDPSuUPHa0IXLJ0obhDrcM1Chq9vJ82rUdiMhWRg63pxZ3jx+fpDVz
         p+UA==
X-Gm-Message-State: AOAM532ILiJ7AlELyTruo7clvWPtxDpYPIzZUkznbhKCoLZ6t7xJEI+0
        /6RH8cQxoRlVNQFKGKoB/NlnY/0PlqjF9w==
X-Google-Smtp-Source: ABdhPJytJAmoiunnhrtxBB3WYKIWjNOhpnL7Utd2JYAMyRIGFkFIKq3mHqcHKzS49+qQRa7I6pmFng==
X-Received: by 2002:a05:6402:149:: with SMTP id s9mr5426679edu.247.1612998261281;
        Wed, 10 Feb 2021 15:04:21 -0800 (PST)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id y20sm2062192edc.84.2021.02.10.15.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:04:20 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-test-robot <lkp@intel.com>
Subject: [PATCH] platform/surface: aggregator: Fix access of unaligned value
Date:   Thu, 11 Feb 2021 00:04:11 +0100
Message-Id: <20210210230411.1938660-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The raw message frame length is unaligned and explicitly marked as
little endian. It should not be accessed without the appropriatte
accessor functions. Fix this.

Reported-by: kernel-test-robot <lkp@intel.com>
Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/aggregator/ssh_packet_layer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
index 583315db8b02..9a78188d8d1c 100644
--- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
@@ -1774,7 +1774,8 @@ static size_t ssh_ptl_rx_eval(struct ssh_ptl *ptl, struct ssam_span *source)
 		break;
 	}
 
-	return aligned.ptr - source->ptr + SSH_MESSAGE_LENGTH(frame->len);
+	return aligned.ptr - source->ptr
+		+ SSH_MESSAGE_LENGTH(get_unaligned_le16(&frame->len));
 }
 
 static int ssh_ptl_rx_threadfn(void *data)
-- 
2.30.0

