Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52561356211
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 05:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348374AbhDGDpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 23:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344439AbhDGDpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 23:45:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C468AC061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 20:45:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 125so19601734ybd.17
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 20:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iAoCwns4tGDUg+Uupy+j5nADfE99sMComaQjSmba07U=;
        b=RiWn/u2mZTBsRW/4i84DxQpGr9bI9wMIqSGA26L4TryZfHh2/SzOuISYwZZCiyTDCC
         N+cS/VK4cdvRl+f/QSKveQLdCa4g672T+pazc0IkCR31ZLwrRbZzlx2/4K/oMahavy2u
         53O6fQYl9RTexvci0kG2f4c80VB5atBISmioOHhVi+KSYLj6XOjXC8jjxYUfiv/OzVeU
         uytuu5ytliEKP3WVGToSTDFyKxH/iTJR3RMjcPQGaNjXbpXpjeZKcEFdnl2SEf/2l8df
         ICGaAJngl6pC0VFmnnIPg0asiNDFH203XevwFGtHIe1Jl9O1NdoFgWzQaBtS6arZkJEo
         0oJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iAoCwns4tGDUg+Uupy+j5nADfE99sMComaQjSmba07U=;
        b=DPPi+RVLBaZnU8ssBeyqTigPfqd1vzKUROKohJAaMDpgKT+IiaDl66XPMtiJEogetm
         VFrQymMmMUrcjdlQTs8ehP1D86sl8acNY98GoJfE6e7bjWdgo06tybvc2ZM3idfBA+yu
         3Mwd2NLTCVE40sxkh5j4GYXnGqhjRQdUPcIgGcxWtMeFOGx+6BQhTVdfAl0fbi9KowVs
         4JMMVSqV9a2NOvEsKC/DfWzU4X7yEOLQYKhd5I7oYcMk9JXfgL4XLUj932izjTT7N6xj
         9WQQYV8voQDeMitIGT83KNyqaJtaEmYOkwgt6lYxcecNm4sk6zp6aB/B69q+8cGpda4G
         BNeg==
X-Gm-Message-State: AOAM530EJqjqHBF2U+G6ERGY8IpCvDMw+4My8DNqLXobLYsjrUbnCcb+
        aTQCfjRpMxF97PsoYrU33UIkP+b/lT3Ja4s=
X-Google-Smtp-Source: ABdhPJwjxk8SfBcyekuL2Zau91IWhPYkx+vU5RoutnJcGE1efAe3lRJyXGsBWK6DT6+gSEVhKXawXWMaGdQcSvg=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:2dae:f92:7d76:4244])
 (user=saravanak job=sendgmr) by 2002:a25:ab2f:: with SMTP id
 u44mr1756605ybi.158.1617767101994; Tue, 06 Apr 2021 20:45:01 -0700 (PDT)
Date:   Tue,  6 Apr 2021 20:44:54 -0700
In-Reply-To: <20210407034456.516204-1-saravanak@google.com>
Message-Id: <20210407034456.516204-2-saravanak@google.com>
Mime-Version: 1.0
References: <20210407034456.516204-1-saravanak@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v1 1/2] driver core: Add dev_set_drv_sync_state()
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can be used by frameworks to set the sync_state() helper functions
for drivers that don't already have them set.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 include/linux/device.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index ba660731bd25..35e8833ca16b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -778,6 +778,18 @@ static inline bool dev_has_sync_state(struct device *dev)
 	return false;
 }
 
+static inline int dev_set_drv_sync_state(struct device *dev,
+					 void (*fn)(struct device *dev))
+{
+	if (!dev || !dev->driver)
+		return 0;
+	if (dev->driver->sync_state && dev->driver->sync_state != fn)
+		return -EBUSY;
+	if (!dev->driver->sync_state)
+		dev->driver->sync_state = fn;
+	return 0;
+}
+
 /*
  * High level routines for use by the bus drivers
  */
-- 
2.31.1.295.g9ea45b61b8-goog

