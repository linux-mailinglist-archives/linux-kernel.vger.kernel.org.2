Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D9E3A3E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhFKIhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:37:08 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:43538 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhFKIg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:36:58 -0400
Received: by mail-wr1-f52.google.com with SMTP id r9so5098564wrz.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gzvh2m9S9pj7XwIIPdU21NyMW1ruzueaF0VglYYhMsQ=;
        b=lgh2+oH7FaJwwRBiJ8A4mfwmPp4WOizOJf8xqUJk3mqictsCeQZLIOn4xWybDx+evw
         RvjTekLgzyXJkZTf+yHeaGctAoURuaXQcr+dHvJJwMCVAW2umjmejKG7a6NytItbJV+w
         h5pn+UH3jwIiwma85aYWcAjgEn4GFklEs6Y5CD3U/io9Vfiyccy/CrSEaR/gbfbLilL6
         YDt6E6sRxl3bbkXDs5Z05kfwhxvYbn08sljzHwfIDatMsAKWdFMLY04+oW9U95GeY4m5
         TF7sEmNOdL+Coojsm/YN3acmyeiMKSCV/qTdwkpMKSiiTQAMtyApwI8avQOYVryx7xbf
         ISmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gzvh2m9S9pj7XwIIPdU21NyMW1ruzueaF0VglYYhMsQ=;
        b=am7CMQyZulbALdUsTN5Q5EpzV92W2LaqK5oa+7xcHFSVnfdV6LPQAGYR2tbQRNiJG5
         k8ZybjQg483wjPuIvlYqlc2pmUdcvcslDKBpFjXF+JCu6x2cwCVAkK2WtGbXw0u0J5Sz
         IpMIE60hr31szsGrNxc0r4i1BcG3FI2cFxoTrJvGaZAkXOlN0yKNKkgYqPzmZo5fSICY
         hUOhzKvnO5fo4Q1AMaNsqCGC75cdTFDPsKjxoXWwWXlsTj/ie44R0CpX5RGbcpqi+Ppy
         N8nuEvIUO2L3NdRAbN+JdVD4LLpXySxh3cR+NRQsebam4wOm2qjQdDTax7vVNgYFt5VW
         /MmA==
X-Gm-Message-State: AOAM533AqIQj2uLsUc3R7BAHCJEf64SUhkOtlTpQ9JbIoBKFIomYuZ5C
        VS3r0EM+C2zW6lYt7Fdykod/mz7mjfBPUg==
X-Google-Smtp-Source: ABdhPJwPupzAzedPWxAa7LGYpun4HWNqbRn/ZimCXRy24cLLVmHRdbb1X61qdwTtGkqyjrcuuqiaJw==
X-Received: by 2002:a05:6000:1b8d:: with SMTP id r13mr2671373wru.207.1623400440678;
        Fri, 11 Jun 2021 01:34:00 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n42sm11547428wms.29.2021.06.11.01.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 01:34:00 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 8/9] nvmem: core: constify nvmem_cell_read_variable_common() return value
Date:   Fri, 11 Jun 2021 09:33:47 +0100
Message-Id: <20210611083348.20170-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
References: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

The caller doesn't modify the memory pointed to by the pointer so it
can be const.

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f9c9c9859919..4868aa876e1b 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1609,9 +1609,9 @@ int nvmem_cell_read_u64(struct device *dev, const char *cell_id, u64 *val)
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_read_u64);
 
-static void *nvmem_cell_read_variable_common(struct device *dev,
-					     const char *cell_id,
-					     size_t max_len, size_t *len)
+static const void *nvmem_cell_read_variable_common(struct device *dev,
+						   const char *cell_id,
+						   size_t max_len, size_t *len)
 {
 	struct nvmem_cell *cell;
 	int nbits;
@@ -1655,7 +1655,7 @@ int nvmem_cell_read_variable_le_u32(struct device *dev, const char *cell_id,
 				    u32 *val)
 {
 	size_t len;
-	u8 *buf;
+	const u8 *buf;
 	int i;
 
 	buf = nvmem_cell_read_variable_common(dev, cell_id, sizeof(*val), &len);
@@ -1686,7 +1686,7 @@ int nvmem_cell_read_variable_le_u64(struct device *dev, const char *cell_id,
 				    u64 *val)
 {
 	size_t len;
-	u8 *buf;
+	const u8 *buf;
 	int i;
 
 	buf = nvmem_cell_read_variable_common(dev, cell_id, sizeof(*val), &len);
-- 
2.21.0

