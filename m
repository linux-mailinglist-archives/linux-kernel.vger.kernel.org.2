Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168F6319186
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhBKRuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhBKROI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:14:08 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95459C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:13:27 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id n10so4332401pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qi5dlJeXBoemX5iO7YEWhEfhi78OE210fte5mk4LWgs=;
        b=hQjUZfAnudGNb+BBb3iyUWOIwEB34dY+8ZBLqnWLIDL/WOh5x5HS6wmp0ebDwZbOkv
         SGvMobMG2mwRVY8qpoYpTD1eb/u+3YF5pg2oZ9SfVKsvDPbNyUcxzODxfZujRWm52GhX
         4xGJH80DprzV7j12Urs0SAPvw7Szi6uE97R4sCe+Jl4x5H4c58jbMXPSVTfTd/Bew2nF
         iuvJwsI2omFzQIQOvAH9lZQ/wtCklaJZjMSSndTUKFXH2TchcjNk+fGXHZLF7k0433HS
         QyJp7THzPnsCXXoB5DVb4JxogwEdX9fX6Um1gG9guynHAqMTlkiy6daRlVaLz5AUXGkH
         /3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qi5dlJeXBoemX5iO7YEWhEfhi78OE210fte5mk4LWgs=;
        b=fyx1CB0cGZpjVYcN7jqUTWGVZNnX+YngbaNt7UOhYUXfTd4Uv6Ewz7Ctz5Bhzqfh4F
         xbC4irq+u4Ixywqz2zTsBrqd6W2zTv0gjGubIapfRXobpT9tTQLkAFjjHmvHdRBjv54A
         f+TvZ7H0j40EiVtJ95E05SU9C3k9lQn3ptGjlDSellIfSJqOsPaBPz1KAqMwxLz4lBvP
         N9JRtNwLLJ8mJHc8871W4CeRKF3Yk8KYRMHSp3kAJtdbHOWbaa1pxn9jb/SQUJe62zpo
         gc7ISKCkTlhjHv0MsSCIwg7KeC6ZQHWjmD3MovRPOk6IbTedkdnD+6/OpcEulLX/aEu+
         XZig==
X-Gm-Message-State: AOAM530ox1qBQRVkiCYkJBCaENUjeGffB6gCuiPIHDIibhDaRk7HixFE
        Ob5DORJfzvYfiR0zZwRTB/wnV5XNjk3S1Q==
X-Google-Smtp-Source: ABdhPJzRZ5kdFtTkawVkGfjcCsq4xlZFWD9oinm4Ggbnyak1VrXiQ7AkpIlrC5JEC7U+fdtDQGu8qw==
X-Received: by 2002:a62:2702:0:b029:1d1:b92a:ef2a with SMTP id n2-20020a6227020000b02901d1b92aef2amr8599546pfn.5.1613063606913;
        Thu, 11 Feb 2021 09:13:26 -0800 (PST)
Received: from localhost.localdomain ([27.5.41.215])
        by smtp.gmail.com with ESMTPSA id 73sm6249494pfa.27.2021.02.11.09.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 09:13:26 -0800 (PST)
From:   Hemansh Agnihotri <hemanshagnihotri27@gmail.com>
To:     gregkh@linuxfoundation.org, lee.jones@linaro.org,
        johannes@sipsolutions.net, kuba@kernel.org, arnd@arndb.de,
        mail@anirudhrb.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wimax: Fix some coding style problems
Date:   Thu, 11 Feb 2021 22:43:20 +0530
Message-Id: <20210211171320.141928-1-hemanshagnihotri27@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes checkpatch errors :- "else should follow close brace '}'",
"space required before the open parenthesis '('" and "spaces required
around that '?' (ctx:VxW)" in drivers/staging/wimax/i2400m/rx.c file.

Signed-off-by: Hemansh Agnihotri <hemanshagnihotri27@gmail.com>
---
 drivers/staging/wimax/i2400m/rx.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/wimax/i2400m/rx.c b/drivers/staging/wimax/i2400m/rx.c
index 5b3a85035f6a..8ea0bd039ed7 100644
--- a/drivers/staging/wimax/i2400m/rx.c
+++ b/drivers/staging/wimax/i2400m/rx.c
@@ -485,8 +485,7 @@ struct i2400m_roq_data {
  * store the sequence number (sn) and the cs (packet type) coming from
  * the RX payload header from the device.
  */
-struct i2400m_roq
-{
+struct i2400m_roq {
 	unsigned ws;
 	struct sk_buff_head queue;
 	struct i2400m_roq_log *log;
@@ -556,7 +555,7 @@ void i2400m_roq_log_entry_print(struct i2400m *i2400m, unsigned index,
 {
 	struct device *dev = i2400m_dev(i2400m);
 
-	switch(e->type) {
+	switch (e->type) {
 	case I2400M_RO_TYPE_RESET:
 		dev_err(dev, "q#%d reset           ws %u cnt %u sn %u/%u"
 			" - new nws %u\n",
@@ -1046,7 +1045,7 @@ void i2400m_rx_edata(struct i2400m *i2400m, struct sk_buff *skb_rx,
 			 ro_type, ro_cin, roq->ws, ro_sn,
 			 __i2400m_roq_nsn(roq, ro_sn), size);
 		d_dump(2, dev, payload, size);
-		switch(ro_type) {
+		switch (ro_type) {
 		case I2400M_RO_TYPE_RESET:
 			i2400m_roq_reset(i2400m, roq);
 			kfree_skb(skb);	/* no data here */
@@ -1346,7 +1345,7 @@ int i2400m_rx_setup(struct i2400m *i2400m)
 {
 	int result = 0;
 
-	i2400m->rx_reorder = i2400m_rx_reorder_disabled? 0 : 1;
+	i2400m->rx_reorder = i2400m_rx_reorder_disabled ? 0 : 1;
 	if (i2400m->rx_reorder) {
 		unsigned itr;
 		struct i2400m_roq_log *rd;
@@ -1365,7 +1364,7 @@ int i2400m_rx_setup(struct i2400m *i2400m)
 			goto error_roq_log_alloc;
 		}
 
-		for(itr = 0; itr < I2400M_RO_CIN + 1; itr++) {
+		for (itr = 0; itr < I2400M_RO_CIN + 1; itr++) {
 			__i2400m_roq_init(&i2400m->rx_roq[itr]);
 			i2400m->rx_roq[itr].log = &rd[itr];
 		}
-- 
2.30.0

