Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85422340737
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhCRNwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhCRNvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:51:48 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2C8C061762
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 06:51:47 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id r193so2334827ior.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 06:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tgS5ltmiWGNMsspoO1AnEwMssicL8HewQ7d9cJWh3nA=;
        b=RegqCtE9l+qF8hHEQiKjFiNj3ds0hWgPzriu2/xoauj2HttWU/Vq4Y0HzZrSXnwPlR
         VjE2dTLhtEDBbOP880FHtWJ2KQLgEf1vbudVRLYLRsvunGPAOH3rmqu3+nJD3fUl49u2
         bvLxVSEz/ctkVtkQLWboiDLS9SsBkMsI0Q9O38hY5nk44UrFY/867gzLKhDu4ba8VFbS
         0cav0YTwbZCYIjmPtnKBSdM9vhMJXZg+QNHnYgkHH4JM3HUZ9Yp0p9yfAOzeqk0ZmkGP
         GtSBYZvFkRxZkvP5Ibt2LMhGkzWzmo8f5btZI9vu5IXrsYy+ZN4+py3cyhQ8j8iPOGWm
         61IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tgS5ltmiWGNMsspoO1AnEwMssicL8HewQ7d9cJWh3nA=;
        b=p7lNgXuPdCNtToCKZboiW67xa+82HCrP5xD2OUolcE3XzhRjNsWQVtI3zjmptKUSkd
         sXGzHu2j7bVNtWDJoEjOdVDCwFvQ93fIgfyFTRcRJrViCkxGUMbvdUxUVrP0Lc379//O
         /vEFMr84MjpKtt6pgVv2gCuqh9/iK6fo+FfyaObrzCfmxwvutBqLkq/9t3Gb5V7zMWIX
         7+L5Wdt1lgz8TP8D9JY4vVjycTfdunS3jqnm6X7TltAC0kpDPd2ZgOUdMZQ6ZYYzlU88
         HDURnFSB+1S6cn/Y4TbjyBA0T7itZAfc9M0crhwj8Ufm6dVNTvNfxve1G62XwCIs7U4I
         f+MA==
X-Gm-Message-State: AOAM531Dk942RWTEPugHSk2mzUoY0shpIUVtJWVNphEigODMqZl3raNp
        eDTsLOCBz6nDSwaAljZM8KXXNw==
X-Google-Smtp-Source: ABdhPJyb9Lm+vAUHAjqHC+rMx11KWjbAZQj4vJfMFr8A5LBkRuQBa/ggACtEKhFseP92/2ShmJ6vJQ==
X-Received: by 2002:a5e:a519:: with SMTP id 25mr9825772iog.3.1616075506941;
        Thu, 18 Mar 2021 06:51:46 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id j20sm1139377ilo.78.2021.03.18.06.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 06:51:46 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     f.fainelli@gmail.com, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/4] net: ipa: use upper_32_bits()
Date:   Thu, 18 Mar 2021 08:51:39 -0500
Message-Id: <20210318135141.583977-3-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318135141.583977-1-elder@linaro.org>
References: <20210318135141.583977-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use upper_32_bits() to extract the high-order 32 bits of a DMA
address.  This avoids doing a 32-position shift on a DMA address
if it happens not to be 64 bits wide.

Suggested-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Alex Elder <elder@linaro.org>
---
v2: - Switched to use the existing function, as suggested by Florian.

 drivers/net/ipa/gsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 2119367b93ea9..82c5a0d431ee5 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -711,7 +711,7 @@ static void gsi_evt_ring_program(struct gsi *gsi, u32 evt_ring_id)
 	val = evt_ring->ring.addr & GENMASK(31, 0);
 	iowrite32(val, gsi->virt + GSI_EV_CH_E_CNTXT_2_OFFSET(evt_ring_id));
 
-	val = evt_ring->ring.addr >> 32;
+	val = upper_32_bits(evt_ring->ring.addr);
 	iowrite32(val, gsi->virt + GSI_EV_CH_E_CNTXT_3_OFFSET(evt_ring_id));
 
 	/* Enable interrupt moderation by setting the moderation delay */
@@ -819,7 +819,7 @@ static void gsi_channel_program(struct gsi_channel *channel, bool doorbell)
 	val = channel->tre_ring.addr & GENMASK(31, 0);
 	iowrite32(val, gsi->virt + GSI_CH_C_CNTXT_2_OFFSET(channel_id));
 
-	val = channel->tre_ring.addr >> 32;
+	val = upper_32_bits(channel->tre_ring.addr);
 	iowrite32(val, gsi->virt + GSI_CH_C_CNTXT_3_OFFSET(channel_id));
 
 	/* Command channel gets low weighted round-robin priority */
-- 
2.27.0

