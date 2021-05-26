Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0522239186E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 15:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbhEZNDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 09:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbhEZNCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 09:02:35 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B1CC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:01:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z17so1041278wrq.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0dnTAwnA+o8Rl6Vjmau/iU73tQSrbIJc4+Gm/DwQ8N8=;
        b=yzpRHfuAFiJ4nJRki9oj+LQQzpcpbJb2uP+be+5hC7r2Qt8OnrD6+KrKWDKnNuUj/c
         X55UMs7SbQnBOpSImIrawe7/2dcQyISDH40JFA60Z2tBxOvtul2Spxr5vriAA/ZJaPt9
         pdLTcjZIn65Y6qKc8dR9fSpEVO1Oq/m93HkkpCBlbiHBXct9w0gPMycwJ3HU8gxS8BxO
         KVZawzDCIphzcPs8olEFN2poev3L9YOHeEd29m/AJ3aFRFszSD7Xyd9PedF5TtQhttbB
         SbGbINnZMNlzcGX2BiDBqMSfcC+j8rlZNjDgJjaxrDO2S9OJZ9zBHKvuFts9EvndA0q3
         cbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0dnTAwnA+o8Rl6Vjmau/iU73tQSrbIJc4+Gm/DwQ8N8=;
        b=s0BxrsMLnT2EKRygFF/vLMBAI02DIjKP9qY74Y1Mh8bZkQMfUArtn2jjZR+KFeep5A
         rbB3B1KX2279fb6AbizlOqwwxIJJAE9voHM+trVxt07g08BreimCwaLEXqc9wQb3r/1e
         lZUvJ2TO1CM0vxnmTOs/XxlKkHHntVyTjRIo6In8nmqPSc3R8BrV9L21YDXswnDKdfaT
         uevwCLeP9Sd4fney0EUOWo7no2conf1qnmJwdIcuCHR5k+A4K/XLNecI8qSwnd7gHAmp
         gP8x2zoEDl+21eLWCgOsBX1F8QjM6NUyB2LyRmqV4koYWOWzKbGqRwz0VSx2i9g8cHSv
         k8KQ==
X-Gm-Message-State: AOAM530SQnUJbaYyjLOser3SkNcSN5Y0F3KdgQfP03ZA/JwnG0fk37yT
        2lQ27DM7z0jQpaD6/WdavYA5SQ==
X-Google-Smtp-Source: ABdhPJxb1ylryAcKdKx8sQgn4UqK0bwJM+U0craSVOZlcd77UaWqPnLsLAiePr+lGIqjKdwYVdmOtQ==
X-Received: by 2002:adf:efc7:: with SMTP id i7mr25188723wrp.421.1622034061209;
        Wed, 26 May 2021 06:01:01 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id y14sm6430036wmj.37.2021.05.26.06.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 06:01:00 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 14/24] usb: chipidea: otg: Fix formatting and missing documentation issues
Date:   Wed, 26 May 2021 14:00:27 +0100
Message-Id: <20210526130037.856068-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526130037.856068-1-lee.jones@linaro.org>
References: <20210526130037.856068-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/usb/chipidea/otg.c:25: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/usb/chipidea/otg.c:78: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/usb/chipidea/otg.c:143: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Peter Chen <peter.chen@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/chipidea/otg.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c
index d3aada3ce7ec2..8dd59282827b0 100644
--- a/drivers/usb/chipidea/otg.c
+++ b/drivers/usb/chipidea/otg.c
@@ -22,7 +22,7 @@
 #include "otg_fsm.h"
 
 /**
- * hw_read_otgsc returns otgsc register bits value.
+ * hw_read_otgsc - returns otgsc register bits value.
  * @ci: the controller
  * @mask: bitfield mask
  */
@@ -75,7 +75,7 @@ u32 hw_read_otgsc(struct ci_hdrc *ci, u32 mask)
 }
 
 /**
- * hw_write_otgsc updates target bits of OTGSC register.
+ * hw_write_otgsc - updates target bits of OTGSC register.
  * @ci: the controller
  * @mask: bitfield mask
  * @data: to be written
@@ -140,8 +140,9 @@ void ci_handle_vbus_change(struct ci_hdrc *ci)
 }
 
 /**
- * When we switch to device mode, the vbus value should be lower
- * than OTGSC_BSV before connecting to host.
+ * hw_wait_vbus_lower_bsv - When we switch to device mode, the vbus value
+ *                          should be lower than OTGSC_BSV before connecting
+ *                          to host.
  *
  * @ci: the controller
  *
-- 
2.31.1

