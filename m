Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA188391877
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 15:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbhEZNEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 09:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbhEZNCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 09:02:44 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9192DC061347
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:01:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x8so1026981wrq.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YbRRFg5q2VbYY8xpOifIVrVfW0BWBSAPTYk+9466Ez8=;
        b=bnjcSmFQOnzl2lNbk/am+nyD7cQvcvfgS+Sx/AaVCXefBJ113iOMCnRSumhjEoFxxi
         +vWmddFD5J+aSHc7dfIyjkTBP4PjK70itrF9GGHI0JDdtN9+C2ugDJZm3miTuc6UWKZu
         jkHa1oS6BKsQ6eoQ4opfRQIxo8Wi711cZ5QbinNBG9n2khSMFrUMml6K2NG4FTVJczp3
         a4Yjqa1Az8PhaQbyf+L+YBM6Tz/a7MeVVEmBk+2jFjrMiToDIEs5ic/UPvGBpBof3a1U
         PHz+4NilOwlYsfzu62F+TxpSNFVN6ZQ3oNSzmZd/wMZryi35H2pyCqLs5NICtIvCG/7N
         40mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YbRRFg5q2VbYY8xpOifIVrVfW0BWBSAPTYk+9466Ez8=;
        b=AxbWH8xBkLaSHeUWat/+uRTDhXeWs6XhFNu2sWm3ABkVvBK6aerX7bKEpXUzivs8GK
         rt6Wfv8Mk5nESGFDCnvhHRsGH1UrleeeN0J3gseIQGtpGvQxjFyOEleUKzd91a8UOqJ/
         Sxihv0Xf19LBYgqA1qHLkAz5F9nBSUa4+2NNLFBtNqyZwlpPkSSe+kmswp+meO8LWQY4
         jOqD+h7jNZkFcPKgKr4IurcaYGOeTRqrd3jtbE8f0oy4TYFf0pIyvly7LRmpgpY8NBDH
         3PijFQ90geycRBUGKsQ0w0D+SztaK3UgW44CrqdwanuT51Gyuhjusev736tgslS/pxGI
         JxxA==
X-Gm-Message-State: AOAM5305DCkreYiG6W6japMnsG6JcpUvGpH5B+vyLgpOOp4LGzy2zRG/
        B++z1WnuSRHPbdcBC4yXI+/0QA==
X-Google-Smtp-Source: ABdhPJxjGTAQRX1bQYEt7u4JMfRcGLIt2g6J4dYYbydSLTN12h1BHBxkjMTYYNNxQiB/jk6ztBT4Ag==
X-Received: by 2002:a5d:690b:: with SMTP id t11mr30464981wru.250.1622034069220;
        Wed, 26 May 2021 06:01:09 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id y14sm6430036wmj.37.2021.05.26.06.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 06:01:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 22/24] usb: host: xhci: Document xhci_get_endpoint_index()'s 'desc' param
Date:   Wed, 26 May 2021 14:00:35 +0100
Message-Id: <20210526130037.856068-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526130037.856068-1-lee.jones@linaro.org>
References: <20210526130037.856068-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/usb/host/xhci.c:1424: warning: Function parameter or member 'desc' not described in 'xhci_get_endpoint_index'

Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/host/xhci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 40ce4b4eb12ad..094b2bf1e2657 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1415,6 +1415,8 @@ static void xhci_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
  * HCDs.  Find the index for an endpoint given its descriptor.  Use the return
  * value to right shift 1 for the bitmask.
  *
+ * @desc: USB endpoint descriptor
+ *
  * Index  = (epnum * 2) + direction - 1,
  * where direction = 0 for OUT, 1 for IN.
  * For control endpoints, the IN index is used (OUT index is unused), so
-- 
2.31.1

