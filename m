Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D2C354144
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 12:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbhDEKtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 06:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbhDEKth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 06:49:37 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEEFC061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 03:49:31 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id c6so8166191qtc.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 03:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TekMjkgaWQi0sIeSwp8iDKdyw1q0V3gj1ztNBm6VfsI=;
        b=VAttzkH4DMhESaE1sTVcfjqCJowcaFGn4TRkZ1yxr7lU5nNA1E3dU+YYBElJmemwpV
         AVfhnC0/zOuX2e+46VXSlwotq7fPiC2uuIIt8GWfzOZV++k5cqD6s/ATfb3mnB8PKogb
         FErKJT0mOyuHpWV3mBWySAljw/RwFHvxUraC5wWpvkTiJXL7M+t6GUyVs5gPxfJLKOkH
         bIKW/wvrim/t+mV8Jw+rPYGx+mlKOETUG7Vwt6LEJusjScKUya6HxRkyq7ohue4wvemG
         R1aAgqwiEkNMFrq3K+sjp9he5LUb5H0oDxD9AoYIjO7xEUHfonUOPIj5ihNXup35oBn9
         aKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TekMjkgaWQi0sIeSwp8iDKdyw1q0V3gj1ztNBm6VfsI=;
        b=kVQ0RQJwgi3nf8xjXfOYjW9ANY80FWkJ7wXNFiIUzk+K90vAngINPVysOskK4H1HKv
         2AmW+92yLWYJzk8Zuicn8trqHXXjUv8/T60fiZSwvIuvGb/QVti9DjE2E9aSYW245G3f
         KBh6sl7Ecbl+PMC7bhUSnhODNK/FkknGGZt+uwvra5rcuC6TvgG3B/fpgIpg0CsvLDri
         ZxxOpZUCs1KXQoYeaoXIbHjOpqS9xGu+umqoxME18w4zbqXQSmvec6i/ciLDCpFPeob9
         neqfbRrPqeGV6f5wZCf1A0mHj8GLqTQ+Cu5MX8dAbRDdlX1rY9DZAVg0R1yhzLY1whcx
         RmIw==
X-Gm-Message-State: AOAM533snS8z4DFcwg4/pnWfP1FPIp++QBPyQnibtgtAvAnzHIUggwde
        szQaYFzDqKwcvQb+/VyCyrs=
X-Google-Smtp-Source: ABdhPJygTPf+SipFc9H3rbIkJmUYoaesZFREbZnWd/NhH7arYiG1/Cg5ZdoSrZlWNQ7jlnxnKF9Q9Q==
X-Received: by 2002:aed:306c:: with SMTP id 99mr21350188qte.352.1617619771195;
        Mon, 05 Apr 2021 03:49:31 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:214:8290:6b95:72bd:5607:9b84:56df])
        by smtp.gmail.com with ESMTPSA id p66sm13349634qka.108.2021.04.05.03.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 03:49:31 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v4 3/9] w1: ds2438: fixed a coding style issue in temperature_read
Date:   Mon,  5 Apr 2021 07:50:03 -0300
Message-Id: <20210405105009.420924-4-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210405105009.420924-1-sampaio.ime@gmail.com>
References: <20210403044821.390485-1-sampaio.ime@gmail.com>
 <20210405105009.420924-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there is only one statement inside the if clause, no brackets
are required.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index a5bb53042c93..eca50cec304f 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -338,9 +338,9 @@ static ssize_t temperature_read(struct file *filp, struct kobject *kobj,
 	if (!buf)
 		return -EINVAL;
 
-	if (w1_ds2438_get_temperature(sl, &temp) == 0) {
+	if (w1_ds2438_get_temperature(sl, &temp) == 0)
 		ret = snprintf(buf, count, "%i\n", temp);
-	} else
+	else
 		ret = -EIO;
 
 	return ret;
-- 
2.30.1

