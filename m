Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F5935FA8A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352024AbhDNSOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352361AbhDNSM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3173AC061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:06 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id mh2so11253678ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4LkuDSuZCeRTIGtCAkcVXWu4VDc+ULV5uOosc47/Tmg=;
        b=P15fGSnXNckSkKIyVxo0g/sPSsVvevF6yBw+ylRQtj0dmHNTjlGgdT9TtLQMftYYvy
         fwImnBnWj5iUI2JXTPqFcGw8b507ucuKJPDVOePeQp9asCSO4yTZk7hajkYQ+tBjl8om
         GLIvCs1NngWjH+2ZcACVJV0YzlnjW+KwccTfXm0EGSxd/jBzcMDyOd+j/XP0f6qCsL5q
         OcoaMqo0jpZIuUlT17CiDU+gkVbacFmrsTV9KV+5MYxfBqah1rpF5eMjxUWDpLtVLYN4
         dThDdoskOKXZPOOhOtSD1qzxhXb1/rmkATesbyKfhpNO7A1+ZM4srQ9sdmqOjgikKs56
         wW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4LkuDSuZCeRTIGtCAkcVXWu4VDc+ULV5uOosc47/Tmg=;
        b=I/3mxEdbuHHEtKzmfv8d5SYnd74w5W+Z6dbRUki2JF79gZg9VZfUFKJkAH6U4i4X72
         dkVlYnuOv5MmJcalZQoE6vYO4kPqDWFK3oqxDwWkE3WYqI5Rc40b7xlbHhoP7sN6fb8H
         pXxW2SzH5wHD+eqZ13NzuTugxJ/VTSrwWLsESaustmjTwhr0G+Fr7GVFBkSZXlHH5wau
         C6XkRBQ3fIbUAuCO1LdcXBXWAnun2z1SpXzP66Yh3bIBa2+3buNwNMgPaHoWE2KeIKxl
         O/czqq6absO16leMBdaZEnGqGuu0mIK3wVP5OxrBgdIAarVXMV4xSNFIMFzTlTHsfWCU
         sYMw==
X-Gm-Message-State: AOAM530WyWbeMIf7L743QpL85i4JAw8WjijeaLrZqFFpcnDO9nWQ6K9K
        OToUTYQoUl7G8tXMcPVS3jIv7Q==
X-Google-Smtp-Source: ABdhPJz3zAHUsIygjWtMfwxzjJMJogfor4zxk9C8GBAOPdRP5Ej1iWOH19gLeDM8n1i02RwNZprgbg==
X-Received: by 2002:a17:906:11d8:: with SMTP id o24mr155215eja.386.1618423924927;
        Wed, 14 Apr 2021 11:12:04 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>,
        Andrey Shvetsov <andrey.shvetsov@k2l.de>,
        linux-staging@lists.linux.dev
Subject: [PATCH 29/57] staging: most: dim2: Provide missing descriptions and fix doc-rot
Date:   Wed, 14 Apr 2021 19:11:01 +0100
Message-Id: <20210414181129.1628598-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also demote merely half-complete header.

Fixes the following W=1 kernel build warning(s):

 drivers/staging/most/dim2/dim2.c:69: warning: Function parameter or member 'name' not described in 'hdm_channel'
 drivers/staging/most/dim2/dim2.c:69: warning: Function parameter or member 'reset_dbr_size' not described in 'hdm_channel'
 drivers/staging/most/dim2/dim2.c:104: warning: Function parameter or member 'dev' not described in 'dim2_hdm'
 drivers/staging/most/dim2/dim2.c:104: warning: Function parameter or member 'name' not described in 'dim2_hdm'
 drivers/staging/most/dim2/dim2.c:104: warning: Function parameter or member 'clk_speed' not described in 'dim2_hdm'
 drivers/staging/most/dim2/dim2.c:104: warning: Function parameter or member 'clk' not described in 'dim2_hdm'
 drivers/staging/most/dim2/dim2.c:104: warning: Function parameter or member 'clk_pll' not described in 'dim2_hdm'
 drivers/staging/most/dim2/dim2.c:104: warning: Function parameter or member 'bus' not described in 'dim2_hdm'
 drivers/staging/most/dim2/dim2.c:104: warning: Function parameter or member 'on_netinfo' not described in 'dim2_hdm'
 drivers/staging/most/dim2/dim2.c:104: warning: Function parameter or member 'disable_platform' not described in 'dim2_hdm'
 drivers/staging/most/dim2/dim2.c:440: warning: Function parameter or member 'most_iface' not described in 'configure_channel'
 drivers/staging/most/dim2/dim2.c:440: warning: Function parameter or member 'ch_idx' not described in 'configure_channel'
 drivers/staging/most/dim2/dim2.c:440: warning: Function parameter or member 'ccfg' not described in 'configure_channel'
 drivers/staging/most/dim2/dim2.c:440: warning: Excess function parameter 'iface' description in 'configure_channel'
 drivers/staging/most/dim2/dim2.c:440: warning: Excess function parameter 'channel' description in 'configure_channel'
 drivers/staging/most/dim2/dim2.c:440: warning: Excess function parameter 'channel_config' description in 'configure_channel'
 drivers/staging/most/dim2/dim2.c:558: warning: Function parameter or member 'most_iface' not described in 'enqueue'
 drivers/staging/most/dim2/dim2.c:558: warning: Function parameter or member 'ch_idx' not described in 'enqueue'
 drivers/staging/most/dim2/dim2.c:558: warning: Excess function parameter 'iface' description in 'enqueue'
 drivers/staging/most/dim2/dim2.c:558: warning: Excess function parameter 'channel' description in 'enqueue'
 drivers/staging/most/dim2/dim2.c:591: warning: Function parameter or member 'most_iface' not described in 'request_netinfo'
 drivers/staging/most/dim2/dim2.c:591: warning: Function parameter or member 'ch_idx' not described in 'request_netinfo'
 drivers/staging/most/dim2/dim2.c:591: warning: Function parameter or member 'on_netinfo' not described in 'request_netinfo'
 drivers/staging/most/dim2/dim2.c:591: warning: Excess function parameter 'iface' description in 'request_netinfo'
 drivers/staging/most/dim2/dim2.c:591: warning: Excess function parameter 'channel_id' description in 'request_netinfo'
 drivers/staging/most/dim2/dim2.c:631: warning: Function parameter or member 'most_iface' not described in 'poison_channel'
 drivers/staging/most/dim2/dim2.c:631: warning: Function parameter or member 'ch_idx' not described in 'poison_channel'
 drivers/staging/most/dim2/dim2.c:631: warning: Excess function parameter 'iface' description in 'poison_channel'
 drivers/staging/most/dim2/dim2.c:631: warning: Excess function parameter 'channel_id' description in 'poison_channel'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Nícolas F. R. A. Prado" <nfraprado@protonmail.com>
Cc: Andrey Shvetsov <andrey.shvetsov@k2l.de>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/most/dim2/dim2.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
index b34e3c130f53f..093ef9a2b2919 100644
--- a/drivers/staging/most/dim2/dim2.c
+++ b/drivers/staging/most/dim2/dim2.c
@@ -50,8 +50,10 @@ static DECLARE_TASKLET_OLD(dim2_tasklet, dim2_tasklet_fn);
 
 /**
  * struct hdm_channel - private structure to keep channel specific data
+ * @name: channel name
  * @is_initialized: identifier to know whether the channel is initialized
  * @ch: HAL specific channel data
+ * @reset_dbr_size: reset DBR data buffer size
  * @pending_list: list to keep MBO's before starting transfer
  * @started_list: list to keep MBO's after starting transfer
  * @direction: channel direction (TX or RX)
@@ -68,7 +70,7 @@ struct hdm_channel {
 	enum most_channel_data_type data_type;
 };
 
-/**
+/*
  * struct dim2_hdm - private structure to keep interface specific data
  * @hch: an array of channel specific data
  * @most_iface: most interface structure
@@ -428,9 +430,9 @@ static void complete_all_mbos(struct list_head *head)
 
 /**
  * configure_channel - initialize a channel
- * @iface: interface the channel belongs to
- * @channel: channel to be configured
- * @channel_config: structure that holds the configuration information
+ * @most_iface: interface the channel belongs to
+ * @ch_idx: channel index to be configured
+ * @ccfg: structure that holds the configuration information
  *
  * Receives configuration information from mostcore and initialize
  * the corresponding channel. Return 0 on success, negative on failure.
@@ -546,8 +548,8 @@ static int configure_channel(struct most_interface *most_iface, int ch_idx,
 
 /**
  * enqueue - enqueue a buffer for data transfer
- * @iface: intended interface
- * @channel: ID of the channel the buffer is intended for
+ * @most_iface: intended interface
+ * @ch_idx: ID of the channel the buffer is intended for
  * @mbo: pointer to the buffer object
  *
  * Push the buffer into pending_list and try to transfer one buffer from
@@ -579,8 +581,9 @@ static int enqueue(struct most_interface *most_iface, int ch_idx,
 
 /**
  * request_netinfo - triggers retrieving of network info
- * @iface: pointer to the interface
- * @channel_id: corresponding channel ID
+ * @most_iface: pointer to the interface
+ * @ch_idx: corresponding channel ID
+ * @on_netinfo: call-back used to deliver network status to mostcore
  *
  * Send a command to INIC which triggers retrieving of network info by means of
  * "Message exchange over MDP/MEP". Return 0 on success, negative on failure.
@@ -621,8 +624,8 @@ static void request_netinfo(struct most_interface *most_iface, int ch_idx,
 
 /**
  * poison_channel - poison buffers of a channel
- * @iface: pointer to the interface the channel to be poisoned belongs to
- * @channel_id: corresponding channel ID
+ * @most_iface: pointer to the interface the channel to be poisoned belongs to
+ * @ch_idx: corresponding channel ID
  *
  * Destroy a channel and complete all the buffers in both started_list &
  * pending_list. Return 0 on success, negative on failure.
-- 
2.27.0

