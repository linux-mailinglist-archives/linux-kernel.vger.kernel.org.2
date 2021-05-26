Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3248391879
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 15:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbhEZNDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 09:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbhEZNCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 09:02:43 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7395CC061353
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:01:07 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n2so1109818wrm.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SstsYYHlOJNFxJcFIIyoQziYm6AwfAPQpEUk2TCe0GU=;
        b=QF82RN242X5HtKAatNgT/qgGfUpO25QtmvdltzP3FsDkyUtjq2GV86LhSpzIPW2y4N
         Z9QP2HWF0uXip3AGH/WZfptwQAE/f1DSS7cs9jtV5xYofb9wXy/8iF9RfgFjIjxE8k8p
         Ug9kZLmO6QzFwFVh+50D7spVdYi9omwh0HympLkeNf2LU1Qf1dy3+TzL9GDfXESuYGGj
         UFAYZcQCZwVNNiSPHHY2b25aqxwk8RQQBVYxDnSCP0bFGumy9RfTPdAanPp/rEm/pn6d
         zo3DOTHllQEq94N40s3KVmw+WnOq2dbEL7Itx3OZbxrJ/4NV0PNQ4j3wnPGmsb5mg0xA
         gZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SstsYYHlOJNFxJcFIIyoQziYm6AwfAPQpEUk2TCe0GU=;
        b=FXtdVg4UQ1zRiXHvtLgNDJ3NXbr0Pu7Kjs24xTCus43+JJuZu+w8lT6GZecX/Vna4E
         PvX/RJAOs5QRtmhoLt2IaCDDG9gwYk07jNviRkbLABbFyd2tQzQyhmzE7VfqUrJAS848
         js0e77YcF+eexhp/nu6b8xXxR/SAyBcuaMu4eN0KXkvoUre0hHh8vJxsxLBiU80ew8Vy
         Ku+FVU+nPogMi6knZ8Z8ro8WSwO9/lb6JM4JZV+3YskkHn3Z4HZe2YsPxsuXBU8e02Uj
         xYGsE8wdJwzuz5EWEs/L0G4XROJqR2f1yRKrXEGtNyx1NxcIwplYw1M8zdRj7PxqRXOg
         oIlw==
X-Gm-Message-State: AOAM530RDeCF/BwrbI+P0lsDYzwnDydkRxPzjFMr5bS5rssdoEw8nOd5
        J3/mNn5onkloduAfbEuNCHzHlg==
X-Google-Smtp-Source: ABdhPJyRGUgs1PnvtyEBBRL+/zjH/5oq1XavlOMX2b9sgoXWYDfs4A+DlUKJpkwVVNV2rtfQlhD//g==
X-Received: by 2002:a5d:4b08:: with SMTP id v8mr33135582wrq.122.1622034066371;
        Wed, 26 May 2021 06:01:06 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id y14sm6430036wmj.37.2021.05.26.06.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 06:01:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 19/24] usb: gadget: udc: udc-xilinx: Place correct function names into the headers
Date:   Wed, 26 May 2021 14:00:32 +0100
Message-Id: <20210526130037.856068-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526130037.856068-1-lee.jones@linaro.org>
References: <20210526130037.856068-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/usb/gadget/udc/udc-xilinx.c:802: warning: expecting prototype for xudc_ep_enable(). Prototype was for __xudc_ep_enable() instead
 drivers/usb/gadget/udc/udc-xilinx.c:997: warning: expecting prototype for xudc_ep0_queue(). Prototype was for __xudc_ep0_queue() instead

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-usb@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/gadget/udc/udc-xilinx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index 72f2ea062d554..fb4ffedd6f0dd 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -791,7 +791,7 @@ static int xudc_ep_set_halt(struct usb_ep *_ep, int value)
 }
 
 /**
- * xudc_ep_enable - Enables the given endpoint.
+ * __xudc_ep_enable - Enables the given endpoint.
  * @ep: pointer to the xusb endpoint structure.
  * @desc: pointer to usb endpoint descriptor.
  *
@@ -987,7 +987,7 @@ static void xudc_free_request(struct usb_ep *_ep, struct usb_request *_req)
 }
 
 /**
- * xudc_ep0_queue - Adds the request to endpoint 0 queue.
+ * __xudc_ep0_queue - Adds the request to endpoint 0 queue.
  * @ep0: pointer to the xusb endpoint 0 structure.
  * @req: pointer to the xusb request structure.
  *
-- 
2.31.1

