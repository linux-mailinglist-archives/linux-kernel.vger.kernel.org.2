Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15067409857
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343641AbhIMQHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344265AbhIMQHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:07:16 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D4FC061762
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:06:00 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id s24so7035531wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hye9+0ESN978kse1JBERjk4/GeLt0FiDWoDbiZyi6yc=;
        b=G+pHPkfP/QQN7qOvJ0aerpXpD+U/5j+A0CaeF9tdtQtxzzlEabGGj96ZotkV1LzzVk
         76wvqQyOFlKIYGgtbdo3b7zCOUC1J9ALzsRO+pSvXHolXVU4IY2BVAv08fwiaHfdKdvG
         GLYfjI1B3z83PeWMrUziWshsSMW5SFIB+epp6BcwFsrR3AAi9JLpMzbWNWF7pR162dTO
         OVxdauZdtCrJaI+08khUtsZfT9ehk0A0hA1RUU/JbOKTOEVyVbwlHaniG0Crrc3+FX0B
         8EASBk3Q0JlS8BKXFXrxki3/88A4VGkSvDRnkqRWy3cArCkm8BdvTKIyUKGA5V0g2fv+
         NpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hye9+0ESN978kse1JBERjk4/GeLt0FiDWoDbiZyi6yc=;
        b=KW1+PXKFfKxJIF3ewIcJ3ztU3B+Niee8XjELhj2skpxQc5k3m4QVHah1f8xwMwndTb
         LT2Ss6LCGGzXT5a4ROrMaHt/MhySq0RIkGRJgkXz/uiKgtT9ycuN1pTfsUFxx4pQjmfD
         jS31r3Wam5Ee8KIX1gYsFQYzs/fHb7at1+DMZK+6cP8nvukmkKXZi/CUSZkzKjiJZ26h
         dysUZ07iZuASTOUdGpuQ8d+qxeJT2uQXor+43WGbQsCK9yEjWCVZ8z17rmHnSnZGJvcb
         rpojLAnvpMyw+GaSSlFM28T7QxLx53rxd1TXDJWY5yLjhed8RLcGqKhkjWW7fNVdgY+I
         dJtQ==
X-Gm-Message-State: AOAM532Mnfe7NiorMtz3TTwXZmJotXCwaVF52A/yDBW0K3u9gsozvfKv
        RuYZ5AQ/qz9Cpi9Ex1L4yQ5Q1w==
X-Google-Smtp-Source: ABdhPJziJy/20fXZdsJGKmYVR9iQeLeF8mynPUeGFcrp1pxEJ6RO4qixOyEHg7abj3B3kyEjktzMdg==
X-Received: by 2002:a05:600c:5123:: with SMTP id o35mr12281847wms.153.1631549158766;
        Mon, 13 Sep 2021 09:05:58 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id o17sm7771771wrj.96.2021.09.13.09.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 09:05:58 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] nvmem: core: Add stubs for nvmem_cell_read_variable_le_u32/64 if !CONFIG_NVMEM
Date:   Mon, 13 Sep 2021 17:05:51 +0100
Message-Id: <20210913160551.12907-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

When I added nvmem_cell_read_variable_le_u32() and
nvmem_cell_read_variable_le_u64() I forgot to add the "static inline"
stub functions for when CONFIG_NVMEM wasn't defined. Add them
now. This was causing problems with randconfig builds that compiled
`drivers/soc/qcom/cpr.c`.

Fixes: 6feba6a62c57 ("PM: AVS: qcom-cpr: Use nvmem_cell_read_variable_le_u32()")
Fixes: a28e824fb827 ("nvmem: core: Add functions to make number reading easy")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Hi Greg,

Could you pick this up for next possible rc.

Thanks,
--srini

 include/linux/nvmem-consumer.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 923dada24eb4..c0c0cefc3b92 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -150,6 +150,20 @@ static inline int nvmem_cell_read_u64(struct device *dev,
 	return -EOPNOTSUPP;
 }
 
+static inline int nvmem_cell_read_variable_le_u32(struct device *dev,
+						 const char *cell_id,
+						 u32 *val)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int nvmem_cell_read_variable_le_u64(struct device *dev,
+						  const char *cell_id,
+						  u64 *val)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct nvmem_device *nvmem_device_get(struct device *dev,
 						    const char *name)
 {
-- 
2.21.0

