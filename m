Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D42835FA94
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350233AbhDNSOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352454AbhDNSMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:41 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A55FC061342
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:13 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r9so32818899ejj.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jhAmTYohLIIwvjjuLrxG/y5RSYAwROp3z5v67OAGzeI=;
        b=RZXN6lPKVmVcgtHOpYhI1GFhq7QnuhWtdq06qY9XyxjfT3WfDhpdISSKJRi+FV4eat
         bVXyygPyJt7eZgBQ34C71ltnVfzxsYrUfvOE4PDNfGZ+k782tIagtwWH68+IHdyxjW9j
         X9xTfPymyOdLVrBlTvQ4EdsaBmYvn5Pr5ZRIt47+vK4U0j8om7ygdLMjSBkwddF0YfWl
         crwCLdRyHUhc6o7ng2n6bh32OOGLud0VyNpjcSkxLke5t/2s1GpUNm0UQ2F6t3Uib39T
         jbayZ7LZ9bIy81Mkt5oF8Y6Ql+7Xke6qt4T0MzAKmJAoCF2R11+FrZ3E3G0wXqAr8Eya
         QfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jhAmTYohLIIwvjjuLrxG/y5RSYAwROp3z5v67OAGzeI=;
        b=ETz7E7qRm9JywgxBixHhFPkX32dVj6e1DF3/XjVSlD3wGFbhfUTxIZX9r0c2PuxChR
         ivnp+Bi2BB9kHiD+suX9bY3QQVCWOmBbBTi4Z0Hhjg+AO7nA3ovGjB5t7ULEovhi8SOO
         ffXv7/XWBeuI+EJ/XEjYGO2F0Mg8r3njTxSHwuVKqLefK2JYpe4FeAktw9MGczB989wb
         is1xLcavIRLzAE76Ea9jROtyUTI0P/FQHdf8qd5LfJk/W+otujuMLTmhcT6r/Gtp1/f9
         xYXy+yv6Rq7XrK3VYYSwpzGYAJhGNExlyZjV6ODapb//IaTlWGei5S8EUoEuplgq/P18
         3c/Q==
X-Gm-Message-State: AOAM5315TKz56/O1/GWlwqFJUqtAi48cv0ijZJDhihKWxpsX4Y2pTl9y
        h+tEGpBGrKZK3nxgI5BKVb2msg==
X-Google-Smtp-Source: ABdhPJxpeqrUArfM0i/J5bnh2etd5dkZm628UYOpISh+SyvynWas5VnTO5MoNwIJZk9CcWSccs+qnw==
X-Received: by 2002:a17:906:3190:: with SMTP id 16mr129670ejy.355.1618423932007;
        Wed, 14 Apr 2021 11:12:12 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:11 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Jacob Feder <jacobsfeder@gmail.com>,
        linux-staging@lists.linux.dev
Subject: [PATCH 36/57] staging: axis-fifo: axis-fifo: Fix some formatting issues
Date:   Wed, 14 Apr 2021 19:11:08 +0100
Message-Id: <20210414181129.1628598-37-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/axis-fifo/axis-fifo.c:356: warning: Function parameter or member 'f' not described in 'axis_fifo_read'
 drivers/staging/axis-fifo/axis-fifo.c:356: warning: Function parameter or member 'buf' not described in 'axis_fifo_read'
 drivers/staging/axis-fifo/axis-fifo.c:356: warning: Function parameter or member 'len' not described in 'axis_fifo_read'
 drivers/staging/axis-fifo/axis-fifo.c:356: warning: Function parameter or member 'off' not described in 'axis_fifo_read'
 drivers/staging/axis-fifo/axis-fifo.c:356: warning: expecting prototype for axis_fifo_write(). Prototype was for axis_fifo_read() instead
 drivers/staging/axis-fifo/axis-fifo.c:478: warning: Function parameter or member 'f' not described in 'axis_fifo_write'
 drivers/staging/axis-fifo/axis-fifo.c:478: warning: Function parameter or member 'buf' not described in 'axis_fifo_write'
 drivers/staging/axis-fifo/axis-fifo.c:478: warning: Function parameter or member 'len' not described in 'axis_fifo_write'
 drivers/staging/axis-fifo/axis-fifo.c:478: warning: Function parameter or member 'off' not described in 'axis_fifo_write'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "John B. Wyatt IV" <jbwyatt4@gmail.com>
Cc: Jacob Feder <jacobsfeder@gmail.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/axis-fifo/axis-fifo.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index ed92810897389..8eee17dc77ab9 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -338,10 +338,10 @@ static void reset_ip_core(struct axis_fifo *fifo)
 
 /**
  * axis_fifo_write() - Read a packet from AXIS-FIFO character device.
- * @f Open file.
- * @buf User space buffer to read to.
- * @len User space buffer length.
- * @off Buffer offset.
+ * @f: Open file.
+ * @buf: User space buffer to read to.
+ * @len: User space buffer length.
+ * @off: Buffer offset.
  *
  * As defined by the device's documentation, we need to check the device's
  * occupancy before reading the length register and then the data. All these
@@ -460,10 +460,10 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 
 /**
  * axis_fifo_write() - Write buffer to AXIS-FIFO character device.
- * @f Open file.
- * @buf User space buffer to write to the device.
- * @len User space buffer length.
- * @off Buffer offset.
+ * @f: Open file.
+ * @buf: User space buffer to write to the device.
+ * @len: User space buffer length.
+ * @off: Buffer offset.
  *
  * As defined by the device's documentation, we need to write to the device's
  * data buffer then to the device's packet length register atomically. Also,
-- 
2.27.0

