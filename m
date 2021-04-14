Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AD135FA8E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352919AbhDNSOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352383AbhDNSMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:34 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9CBC06138E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:10 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l4so32778441ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x6swCV8MABma/kvfA/z+/vs0favPyInYA12FLnpeb1k=;
        b=WhRVGsNUs16A4SHOiwGJH3+VhlkVON+SOgYg3cYg0syXzQCGucwewKfv1PGEXfKKEO
         w4InHL525QL6qZVBwNmGhKvPnxh9VH4oB53Hhbxy+8t/r9iucwiudvAfQ3ybkVOex5Iv
         bLaEz1R0/fBJmh9IsFGrcMbuEyWlRBirdIDKdexFar7xYJO7QVDpcBKuhooHecpO8/+P
         arrEBUdyE29OBxlR74ZYiAS83nJudtCX/vCLUf5DlBPW0rYyP14EFOUVhlpImcRsVvNA
         iWb444J07PyZf+bZN/uJRW2QAD8iktXDanTOamYzJpvTWGcyZKmkjgGUYnqH8EKWad17
         AeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x6swCV8MABma/kvfA/z+/vs0favPyInYA12FLnpeb1k=;
        b=WC7vYvfN2mcuVDeLVZxAhpmh2jPqr1hYSFEd71qNysnCOca+//ShN7Ihw1OalwJsd+
         3+5ERwJ/+hNSlN2s3wYvBIoC/HUx1wZc9XjNeVCMo+yfEqzIg0mXhYS6nzPYJ3uGpxDF
         vjLtTHARmmo6MCTMyfLHnc9Au4h0ITN+4V7EfzU8Zrgo0rZDbzAuOg7XpV3/IlNv8BUo
         OeaenLXSwN2muQH5hFUjuDD5QCtGym6sGk5pvTQK0qNjx3wu1LGpAAM9GjHRBghXN61M
         ImEXGMWODnhqQq0fYSnIja/mI7Oe38Jb/E3f3+IUXmmtWNnpv6oFd9wLGMbmfcAQmSCr
         MUNw==
X-Gm-Message-State: AOAM530mDlA/EUFqxedG9aWGV+egu/NdYjcFcaNiN7Bif6rOsstCSlXI
        rTBOVZwsx+hIoUsTcCXwGATTZSK1gpcPLw==
X-Google-Smtp-Source: ABdhPJw1exYvLBm56CUU8hswEMeLLroWnY2pN9quMUAksqZb74fNwYQ0mHj77DYzXWeKUuwYY/WCFg==
X-Received: by 2002:a17:907:2d94:: with SMTP id gt20mr150708ejc.552.1618423929013;
        Wed, 14 Apr 2021 11:12:09 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrey Shvetsov <andrey.shvetsov@k2l.de>,
        linux-staging@lists.linux.dev
Subject: [PATCH 33/57] staging: most: i2c: Fix a little doc-rot
Date:   Wed, 14 Apr 2021 19:11:05 +0100
Message-Id: <20210414181129.1628598-34-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/most/i2c/i2c.c:66: warning: Function parameter or member 'most_iface' not described in 'configure_channel'
 drivers/staging/most/i2c/i2c.c:66: warning: Function parameter or member 'ch_idx' not described in 'configure_channel'
 drivers/staging/most/i2c/i2c.c:66: warning: Excess function parameter 'iface' description in 'configure_channel'
 drivers/staging/most/i2c/i2c.c:66: warning: Excess function parameter 'channel' description in 'configure_channel'
 drivers/staging/most/i2c/i2c.c:121: warning: Function parameter or member 'most_iface' not described in 'enqueue'
 drivers/staging/most/i2c/i2c.c:121: warning: Function parameter or member 'ch_idx' not described in 'enqueue'
 drivers/staging/most/i2c/i2c.c:121: warning: Excess function parameter 'iface' description in 'enqueue'
 drivers/staging/most/i2c/i2c.c:121: warning: Excess function parameter 'channel' description in 'enqueue'
 drivers/staging/most/i2c/i2c.c:166: warning: Function parameter or member 'most_iface' not described in 'poison_channel'
 drivers/staging/most/i2c/i2c.c:166: warning: Function parameter or member 'ch_idx' not described in 'poison_channel'
 drivers/staging/most/i2c/i2c.c:166: warning: Excess function parameter 'iface' description in 'poison_channel'
 drivers/staging/most/i2c/i2c.c:166: warning: Excess function parameter 'channel_id' description in 'poison_channel'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrey Shvetsov <andrey.shvetsov@k2l.de>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/most/i2c/i2c.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/most/i2c/i2c.c b/drivers/staging/most/i2c/i2c.c
index 893a8babdb2f7..7042f10887bb6 100644
--- a/drivers/staging/most/i2c/i2c.c
+++ b/drivers/staging/most/i2c/i2c.c
@@ -51,8 +51,8 @@ static void pending_rx_work(struct work_struct *);
 
 /**
  * configure_channel - called from MOST core to configure a channel
- * @iface: interface the channel belongs to
- * @channel: channel to be configured
+ * @most_iface: interface the channel belongs to
+ * @ch_idx: channel to be configured
  * @channel_config: structure that holds the configuration information
  *
  * Return 0 on success, negative on failure.
@@ -107,8 +107,8 @@ static int configure_channel(struct most_interface *most_iface,
 
 /**
  * enqueue - called from MOST core to enqueue a buffer for data transfer
- * @iface: intended interface
- * @channel: ID of the channel the buffer is intended for
+ * @most_iface: intended interface
+ * @ch_idx: ID of the channel the buffer is intended for
  * @mbo: pointer to the buffer object
  *
  * Return 0 on success, negative on failure.
@@ -153,8 +153,8 @@ static int enqueue(struct most_interface *most_iface,
 
 /**
  * poison_channel - called from MOST core to poison buffers of a channel
- * @iface: pointer to the interface the channel to be poisoned belongs to
- * @channel_id: corresponding channel ID
+ * @most_iface: pointer to the interface the channel to be poisoned belongs to
+ * @ch_idx: corresponding channel ID
  *
  * Return 0 on success, negative on failure.
  *
-- 
2.27.0

