Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D112340DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhCRTAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbhCRS7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 14:59:36 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12661C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 11:59:36 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id r193so3436452ior.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 11:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LESQ/UHK2DxeHH4F7kd7aYV3wdpZXRjKVIKWvAV+aQ0=;
        b=XYqBvsJTLZZsfEyJQ2kEE7krLvXIAksD9JN6nB7MmqxpviA515SBB+16uvcsgRRuU2
         lDQGNmuuAi/J7vOfbyIw3xFhakX6N8eeva/wV/+hAjqmqS7v1AMJtMsC4WR0MEoarif6
         m9iKJNMAHVkQylc4sfaeoFbThJgNbgSBExfBn/s9sy6Zv6WvHnZav8lutLw7x6FBloO3
         xJNw8wDjBb+fWARzzd7LTRMyqCCDfuIhVjRH7AxCw93X+5WJca6g/vz/zVyP+VprK0PM
         NvFIjXUz/8Xmc2/NnpJ0QFtLE+4KG0csOSS25+Ai3Ri2w8B4Ly2IoJmesSIW5ED3WlsQ
         bUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LESQ/UHK2DxeHH4F7kd7aYV3wdpZXRjKVIKWvAV+aQ0=;
        b=FiHJRZYm1RxJPHwPbtf/+OYXgTb5APwUyZdJw9ZONNLJhNj2RtKfxa6JjNRUuDnn8q
         l8IeAx7CbqwvBfxk2ntvfxCfnaKKbnGbmTOJcAi/rmBgXzLZan2e73gplSfMLEwCeys3
         2qAE0l6y/EXJoUmn3MozQgrRFeVnhGX8xGQurPyr6AR9b9ofE9R2uE0nOtmb81vl8E3U
         yfav27BbnbwRrXH7hXom2H1ju+gGe0ZTcRqq3uVEB5XpqINL+XtVO0koSEFUlH2XxlfS
         Vngaivk1bFk7E4xkJxYgkdGUQX4jPsyzVVWcSOJjV7aRB9iiFRN8W0g0UnBQt+LXtGIR
         eYMQ==
X-Gm-Message-State: AOAM530JJFZycJaFMKk/cejBPhWzt53ZnEdbMBQ5haD5eIbvkwXU8flV
        SFA5n00tKTW6dPyNsujJl4VBr4LJKzry3pNz
X-Google-Smtp-Source: ABdhPJw4HSAS87UrUOg/E7iQACH57qIBL/O2nhBwWX9htgDyCWAB1K5EGOEHXBhfNX3DCjz2VWhBRA==
X-Received: by 2002:a05:6602:179c:: with SMTP id y28mr2291iox.151.1616093975515;
        Thu, 18 Mar 2021 11:59:35 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id k7sm770359ils.35.2021.03.18.11.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 11:59:35 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     f.fainelli@gmail.com, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/4] net: ipa: use upper_32_bits()
Date:   Thu, 18 Mar 2021 13:59:28 -0500
Message-Id: <20210318185930.891260-3-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318185930.891260-1-elder@linaro.org>
References: <20210318185930.891260-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use upper_32_bits() to extract the high-order 32 bits of a DMA
address.  This avoids doing a 32-position shift on a DMA address
if it happens not to be 64 bits wide.  Use lower_32_bits() to
extract the low-order 32 bits (because that's what it's for).

Suggested-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Alex Elder <elder@linaro.org>
---
v3: - Use upper_32_bits() where appropriate, and lower_32_bits() too.
v2: - Switched to use the upper_32_bits(), as suggested by Florian.

 drivers/net/ipa/gsi.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 2119367b93ea9..7f3e338ca7a72 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -351,7 +351,7 @@ void *gsi_ring_virt(struct gsi_ring *ring, u32 index)
 /* Return the 32-bit DMA address associated with a ring index */
 static u32 gsi_ring_addr(struct gsi_ring *ring, u32 index)
 {
-	return (ring->addr & GENMASK(31, 0)) + index * GSI_RING_ELEMENT_SIZE;
+	return lower_32_bits(ring->addr) + index * GSI_RING_ELEMENT_SIZE;
 }
 
 /* Return the ring index of a 32-bit ring offset */
@@ -708,10 +708,9 @@ static void gsi_evt_ring_program(struct gsi *gsi, u32 evt_ring_id)
 	 * high-order 32 bits of the address of the event ring,
 	 * respectively.
 	 */
-	val = evt_ring->ring.addr & GENMASK(31, 0);
+	val = lower_32_bits(evt_ring->ring.addr);
 	iowrite32(val, gsi->virt + GSI_EV_CH_E_CNTXT_2_OFFSET(evt_ring_id));
-
-	val = evt_ring->ring.addr >> 32;
+	val = upper_32_bits(evt_ring->ring.addr);
 	iowrite32(val, gsi->virt + GSI_EV_CH_E_CNTXT_3_OFFSET(evt_ring_id));
 
 	/* Enable interrupt moderation by setting the moderation delay */
@@ -816,10 +815,9 @@ static void gsi_channel_program(struct gsi_channel *channel, bool doorbell)
 	 * high-order 32 bits of the address of the channel ring,
 	 * respectively.
 	 */
-	val = channel->tre_ring.addr & GENMASK(31, 0);
+	val = lower_32_bits(channel->tre_ring.addr);
 	iowrite32(val, gsi->virt + GSI_CH_C_CNTXT_2_OFFSET(channel_id));
-
-	val = channel->tre_ring.addr >> 32;
+	val = upper_32_bits(channel->tre_ring.addr);
 	iowrite32(val, gsi->virt + GSI_CH_C_CNTXT_3_OFFSET(channel_id));
 
 	/* Command channel gets low weighted round-robin priority */
@@ -1365,7 +1363,7 @@ static struct gsi_trans *gsi_event_trans(struct gsi_channel *channel,
 	u32 tre_index;
 
 	/* Event xfer_ptr records the TRE it's associated with */
-	tre_offset = le64_to_cpu(event->xfer_ptr) & GENMASK(31, 0);
+	tre_offset = lower_32_bits(le64_to_cpu(event->xfer_ptr));
 	tre_index = gsi_ring_index(&channel->tre_ring, tre_offset);
 
 	return gsi_channel_trans_mapped(channel, tre_index);
-- 
2.27.0

