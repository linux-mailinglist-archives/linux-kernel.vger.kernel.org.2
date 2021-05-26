Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F121339185F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 15:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhEZNCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 09:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbhEZNC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 09:02:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A531EC06138B
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:00:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l18-20020a1c79120000b0290181c444b2d0so454699wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nWQ+dGkib5DQMg+R+hA7frJhGrDbcK33rjn0/4gfMZI=;
        b=Zk3CukMJf/dJMXBbHW21xznSD8Wt3+CcmCDgEXWwSXPbziin9IQq1qnnJoJLF5445P
         42g5b78lDteSF+PWLHKzvgkedj6w5zW2U+GUSZvEOUh9U6Uaxj4DejZfD7YLaIxhbLzd
         F613wQnC3fEeoP5b4a1yWGWlRSP/Gw2YnLg5TjftNs6lSCRuu7OqnNpDIX8w4jleUA+e
         Ff3T6xiQX8gjdyEdBqq56XLGQR8yn+w0wu3qjj21oSRY2rEAkRNfcA6khy/G1SmRsbdy
         VRV9vbQ5v1LTK9gCjstDvsQuaXHlFyIC1W0YrmLsC9KEN5DdIFYbvQ40FZEyF8nLZhF/
         Gh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nWQ+dGkib5DQMg+R+hA7frJhGrDbcK33rjn0/4gfMZI=;
        b=XsZIGFsu835mL1l9u6Y84Uy+SBQDUuD0awub/tHq77IOq/y10KMef/xz1px2MhwPd5
         6bRtLGNEnjf+dduO+5IXglfWxerWk8TO99MQhn/UZ/yGYtgdulk+gyjqVIsvW5IiwM6m
         eLyIzf5cI/CMi3552cf87bf51dYP6LIDAr7mKEFlJw/CFF6IOmbmlSa6AUs+lL2ePLUi
         vASRwV620VAfi26AFwTPYwulwXHi3P6RK0Isz6uWm9gOSgsVdOU1NL0KsfUn6rDyJyqr
         Kmwxc7/uAh21JYrdpYqSZdqm6TkdccJLs8+KqBZa7U5kZzsrSHO1+kaIPqb9q9wggxs2
         zdXg==
X-Gm-Message-State: AOAM531I/XvT0PE9/zxCy5xPmfO8oZwr5RU+pMZuMjzTeM0l/9t0lxxN
        /bLM9kh+FtScb/f+mytTXUhRcw==
X-Google-Smtp-Source: ABdhPJwWmb/Kkxx3XwJGZhwQ5XxgRJr6DaOzbZh41z2m8M29MMCXDoZt4sxszuuSYpMZvBgCB9iCdA==
X-Received: by 2002:a7b:c185:: with SMTP id y5mr28347837wmi.63.1622034052316;
        Wed, 26 May 2021 06:00:52 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id y14sm6430036wmj.37.2021.05.26.06.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 06:00:51 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH 06/24] usb: isp1760: isp1760-udc: Provide missing description for 'udc' param
Date:   Wed, 26 May 2021 14:00:19 +0100
Message-Id: <20210526130037.856068-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526130037.856068-1-lee.jones@linaro.org>
References: <20210526130037.856068-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/usb/isp1760/isp1760-udc.c:150: warning: Function parameter or member 'udc' not described in 'isp1760_udc_select_ep'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rui Miguel Silva <rui.silva@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/isp1760/isp1760-udc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/isp1760/isp1760-udc.c b/drivers/usb/isp1760/isp1760-udc.c
index 3e05e36054357..a78da59d6417b 100644
--- a/drivers/usb/isp1760/isp1760-udc.c
+++ b/drivers/usb/isp1760/isp1760-udc.c
@@ -137,6 +137,7 @@ static void __isp1760_udc_select_ep(struct isp1760_udc *udc,
 /**
  * isp1760_udc_select_ep - Select an endpoint for register access
  * @ep: The endpoint
+ * @udc: Reference to the device controller
  *
  * The ISP1761 endpoint registers are banked. This function selects the target
  * endpoint for banked register access. The selection remains valid until the
-- 
2.31.1

