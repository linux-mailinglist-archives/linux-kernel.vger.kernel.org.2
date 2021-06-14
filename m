Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0901F3A6DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 19:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbhFNSBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbhFNSBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:01:16 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3DAC0617AF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 10:59:13 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id 69so6997432plc.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 10:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9eYVDaVHYr+Ta9Md8XT/8eZjugfQKObmCTnUfOcer/Y=;
        b=GCtIlChOWoBbjJ/2yOkYALvlVjU+KxqrqCs0BWuqHB8ai1/8JsSvwpvekPJuHrofDo
         XdeZ8A+kK1NsP24zuk03cyQK4TuuShldjDlHH4iHMBHWbLuOjXbl1j4+8ybVAFU8orDB
         zipbuVybVQN2vloxTfXsa/tgbq/QtuQF8lOBYNmAbkpowIqHDmc4RPVhzfiDih64SmhH
         kdvOXNJZlwimPMf0noHqxZ0S5JunZuGmXDSCsjCwQw8xBLN8QsS5KUzJD5MwugO7UyPr
         /fODf8JjLECGf3DT6QZQZCCQn8dEJYS3c9AA4sfLAMcAfjUIK3GwALWUDLmmjp26dSKT
         l9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9eYVDaVHYr+Ta9Md8XT/8eZjugfQKObmCTnUfOcer/Y=;
        b=kaWY725v5D8rdW7IjI8W9P8CtMGWRVVuckLCBfSygm0MfQK27QqTc8+f310zIbo9t1
         CAmq4mOjP4CTlbJ5vc1SCxLB5rdrTKr2zbcTkmfAnXrciSDTs2o+PdqTPumEQRYsK40k
         KsJkCbTyxMmXYMUrs7y+w8OPjqbyBGRfs1Z0D2qWRjqMD/vfkFU6yrwGogwi3hKsbAZz
         J7C9zVjI2HIlJrDu7jjzehlgf1RybsrNkPgSRrLZNxTj7Ia7wCg93lHhGvJ9vtevRpEj
         9btON/FeoAWgkpsLmCQtB6uh5HEyMJzxtxPlfZzbcYlH2rTxktHv1ULW4VbqeXkfzILz
         KI6A==
X-Gm-Message-State: AOAM530zktUpnIwf7ktj2GJATnFjM2ul5QBsaTtddf5NTcxUQkIKEAzd
        V0JIXIJOUpqrz0CXWSXdYvTzwQ==
X-Google-Smtp-Source: ABdhPJwZ2MGOf++hgMEBvIo+Qtqd7Lw+Thyr4vk30C4XHf/ksoTZ9RTXTEilGqS82Oyf5ufZ6YAsLQ==
X-Received: by 2002:a17:90a:8a0c:: with SMTP id w12mr351959pjn.130.1623693552674;
        Mon, 14 Jun 2021 10:59:12 -0700 (PDT)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id z17sm13553246pfq.218.2021.06.14.10.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:59:11 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] coresight: Propagate symlink failure
Date:   Mon, 14 Jun 2021 11:59:01 -0600
Message-Id: <20210614175901.532683-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614175901.532683-1-mathieu.poirier@linaro.org>
References: <20210614175901.532683-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Linton <jeremy.linton@arm.com>

If the symlink is unable to be created, the driver goes
ahead and continues device creation. Instead lets propagate
the failure, and fail the probe.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Link: https://lore.kernel.org/r/20210526204042.2681700-1-jeremy.linton@arm.com
Fixes: 8a7365c2d418 ("coresight: Expose device connections via sysfs")
Cc: stable@vger.kernel.org
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 3cb8680c5828..1002605db8ba 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1391,7 +1391,7 @@ static int coresight_fixup_device_conns(struct coresight_device *csdev)
 		}
 	}
 
-	return 0;
+	return ret;
 }
 
 static int coresight_remove_match(struct device *dev, void *data)
-- 
2.25.1

