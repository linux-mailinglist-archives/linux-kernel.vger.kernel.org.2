Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51023C91FB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbhGNUX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 16:23:58 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44186 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhGNUX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:23:57 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9678020B800A;
        Wed, 14 Jul 2021 13:21:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9678020B800A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1626294065;
        bh=XhcON44UQDGT9gF4sP+JV1ze0ek45T8MNOR/TLFHRmg=;
        h=From:To:Subject:Date:From;
        b=LV5iaMaOJsL6/OaUOovQqGhOBcioWphxMkZjwch+FG1kVkjysSxd4lxmOOimk1XbO
         wee9tbvmo8gL/QZ3R9L4z2BLvjhGUEJO/d8RjbiYRy2D/2aAIqRasm8oCyhEUqPHW/
         VICHbUxV1Qu7PBVhpZKZ/7yJ7pxWZXnnetylZmak=
From:   Sonia Sharma <sosha@linux.microsoft.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, wei.liu@kernel.org,
        Dexuan Cui <decui@microsoft.com>, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hyperv: Remove unused inline functions in hyperv.h
Date:   Wed, 14 Jul 2021 13:20:34 -0700
Message-Id: <1626294034-6061-1-git-send-email-sosha@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some unused inline functions in hyperv.h file.
Removing those unused functions.

Signed-off-by: Sonia Sharma <sonia.sharma@microsoft.com>
---
 include/linux/hyperv.h | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index b3e2436..1f1f0f8 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -481,12 +481,6 @@ struct vmbus_channel_rescind_offer {
 	u32 child_relid;
 } __packed;
 
-static inline u32
-hv_ringbuffer_pending_size(const struct hv_ring_buffer_info *rbi)
-{
-	return rbi->ring_buffer->pending_send_sz;
-}
-
 /*
  * Request Offer -- no parameters, SynIC message contains the partition ID
  * Set Snoop -- no parameters, SynIC message contains the partition ID
@@ -913,12 +907,6 @@ static inline bool is_hvsock_channel(const struct vmbus_channel *c)
 		  VMBUS_CHANNEL_TLNPI_PROVIDER_OFFER);
 }
 
-static inline void set_channel_affinity_state(struct vmbus_channel *c,
-					      enum hv_numa_policy policy)
-{
-	c->affinity_policy = policy;
-}
-
 static inline void set_channel_read_mode(struct vmbus_channel *c,
 					enum hv_callback_mode mode)
 {
@@ -941,16 +929,6 @@ static inline void set_channel_pending_send_size(struct vmbus_channel *c,
 	c->outbound.ring_buffer->pending_send_sz = size;
 }
 
-static inline void set_low_latency_mode(struct vmbus_channel *c)
-{
-	c->low_latency = true;
-}
-
-static inline void clear_low_latency_mode(struct vmbus_channel *c)
-{
-	c->low_latency = false;
-}
-
 void vmbus_onmessage(void *context);
 
 int vmbus_request_offers(void);
-- 
1.8.3.1

