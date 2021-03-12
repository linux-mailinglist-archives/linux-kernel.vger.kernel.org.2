Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEB9338AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbhCLLDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbhCLLCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:02:48 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDEAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:02:47 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id z2so1533719wrl.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IX0MAEBIjbQAkeNRoSiaCaQ3IMaUVvK6h3tlvyXhUWo=;
        b=Q+8aqUMTh2qjLcspdVBXiwl7rVR/1lPcWPi14BjciE9pIM4n946WyZOasLKbyHElww
         Vr0AHNiC2O2WtYPNoGiBOfrTzKFH8ZWSolrSSGG0tg9Rsv03FTePUDyKO/rPSyZCESFD
         /b4CCP4RDFK9L9rp61IoXuytY8RUKGmhnYNHwGWucCEIkzWfJ9t4Wb5h5n9W6OQWio5f
         NuJDn0b/1MJGZh4MAifvA9l932ti9wZ4iXBCcn7PNMrVOXqg+e63DCGPs0+38vYu6ya2
         vqadb6t1A3iL/Hm/4SjWlSbWeQPF1p/1aOWKnNM7dYtYxcTQNPPXGg0DD2XxYh2CxMKa
         iHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IX0MAEBIjbQAkeNRoSiaCaQ3IMaUVvK6h3tlvyXhUWo=;
        b=oRxfinxnlVQb8/X0FBDNcJOfetMwt8mh7QaD9Zrx3u185Jh0ws6bJGFesboWCfBE49
         +xatc4iVkVxfMB+MrRW7jCN3vwR5Vj8/I6Pn7u7m74tLSTw+MVR62iWtl1tXEJYukOl2
         fPYOqQVb0BW5wJ8FwadFCkMFxgc6lJ6hquFmJfGeGRIa/ptrTlWRMPsncQSg3PyOe3c4
         kNYLP8QhTHLOaJCne8XyZT8/l/gDGho5WV5lsnFbtHiW4pJ1JPtbp9sp37a0cHocvinY
         7AZxlYL/ne6AwnyjCUX5qRIbKri9f7DV9WPquqwNlVs1wHVtpWtDVpPqFNox19+T/+ft
         9LfA==
X-Gm-Message-State: AOAM532FXWF0D4XLQNbP+vNIsJnBTox14ahZF97VetUco/cNzba9UlcE
        pGyi3Ih3cxtxH9X3y0YJ89ni7w==
X-Google-Smtp-Source: ABdhPJxWuEn3WjO3NK8WbHECtN5GLPLgaw1BAL95FQpAI4vCx+jLGOMUcipuCgKAzr0vA9PEYphWBA==
X-Received: by 2002:adf:f8cd:: with SMTP id f13mr12973746wrq.27.1615546965871;
        Fri, 12 Mar 2021 03:02:45 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id w131sm1761318wmb.8.2021.03.12.03.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:02:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        dahinds@users.sourceforge.net
Subject: [PATCH 4/6] pcmcia: ds: Fix function name disparity in header
Date:   Fri, 12 Mar 2021 11:02:37 +0000
Message-Id: <20210312110239.2220197-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312110239.2220197-1-lee.jones@linaro.org>
References: <20210312110239.2220197-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/pcmcia/ds.c:96: warning: expecting prototype for pcmcia_store_new_id(). Prototype was for new_id_store() instead

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: dahinds@users.sourceforge.net
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pcmcia/ds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index 72114907c0e4d..c944eb91fdced 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -83,7 +83,7 @@ struct pcmcia_dynid {
 };
 
 /**
- * pcmcia_store_new_id - add a new PCMCIA device ID to this driver and re-probe devices
+ * new_id_store() - add a new PCMCIA device ID to this driver and re-probe devices
  * @driver: target device driver
  * @buf: buffer for scanning device ID data
  * @count: input size
-- 
2.27.0

