Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818E032BCB5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445226AbhCCObx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842985AbhCCKXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:23:25 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45993C08ECB2
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 01:58:08 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id w33so6530011qte.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 01:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=TSFbiHk2wopoWX9vUZpzk37wo66kS5QquU8TlUFLvVA=;
        b=hofwvEuISaHVnfbjMGuHJ9z12jtJGJ3Qy9uq05ohrB0MDYJXYafKi++1Qxyxw9tnUK
         T0w6CvVIxYCR/JnYnB8TG1CFQ8H/dgeA99w2Rl3VgEbRR3skZh6TM6nM/Ouz2IqpL+db
         YjhUjEnIratoU1YqSvxjY0g4y2fsPNVbY639UNLr6L0wVCWMtlBT2C5G6sPEjl0mPd1z
         tX+eRyddDHFQ/E+63L6shixo/RVUzPmMxYVT3mHORVtjd0Dg5OpL3n87f2SfyTcrhZMx
         lgW8i4RMvFPDaeEOyzMHSmgg2c14etouW3WigfUhGa0tGM7OeeNOwhUhRw5gRv7PzoSy
         Jcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=TSFbiHk2wopoWX9vUZpzk37wo66kS5QquU8TlUFLvVA=;
        b=DkMBCejRPMvj3Nk0uqcl9kNlp+LxJfUMCWFkUc0zxeEY8gFxNsanUJpPY2eyv2Qk0d
         MCluFLyJ6N98LA8PRPuy1OIHFOe2ZrvBQIMLwxw20VaR0CuUR/QR3Xd/r854vPa9TOH6
         3ckZ62V47NigN4XTj8CJ5h/YTUrRIlKCVxxwFv1hbLR66f29WnMLcG4cgEUTFOU9MIts
         LHrVLHAp5tR3mdIdnXZE1viP8u3UaVJ5cTcoy5G8VL06Ya8b44ssA6QTH+tdOfGn+n8X
         DnlgJ9NU7KpmABxGAltrQRf7QfwTBoZtP+MtrFr3OdLjlZAhxgQVRhIi6ADHa4zGY0ds
         oByA==
X-Gm-Message-State: AOAM530u8/TmIbAAFxWSW52cHAlwCwU2+wwfhKBKamMo49wyFmIWua4A
        jAM3cFLIkjJImtyx/J1/i6js/8/iqWI=
X-Google-Smtp-Source: ABdhPJwQ/JiIgEDiPOARa1Nh5v97jWzDrd/L0iXI4ma6Im+lmhmIb9PjN2A2XnITINs7yMYi/Pvw8OA21pY=
Sender: "raychi via sendgmr" <raychi@raychi.tao.corp.google.com>
X-Received: from raychi.tao.corp.google.com ([2401:fa00:fc:202:d0b:ce1b:8f7e:f53a])
 (user=raychi job=sendgmr) by 2002:a0c:e788:: with SMTP id x8mr7735388qvn.48.1614765487321;
 Wed, 03 Mar 2021 01:58:07 -0800 (PST)
Date:   Wed,  3 Mar 2021 17:58:02 +0800
Message-Id: <20210303095802.2801733-1-raychi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [Patch v3] usb: dwc3: document usb_psy in struct dwc3
From:   Ray Chi <raychi@google.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kyletso@google.com, Ray Chi <raychi@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new struct member was added to struct dwc3, but
a documentation was missing:

drivers/usb/dwc3/core.h:1273: warning: Function parameter or member 'usb_psy' not described in 'dwc3'

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Ray Chi <raychi@google.com>
---
Changelog since v2:
- move Signed-off-by to the bottom

Changelog since v1:
(reported-by Stephen Rothwell <sfr@canb.auug.org.au>)
- added Reported-by line.

 drivers/usb/dwc3/core.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 6708fdf358b3..ce6bd84e2b39 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -988,6 +988,7 @@ struct dwc3_scratchpad_array {
  * @role_sw: usb_role_switch handle
  * @role_switch_default_mode: default operation mode of controller while
  *			usb role is USB_ROLE_NONE.
+ * @usb_psy: pointer to power supply interface.
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
-- 
2.30.1.766.gb4fecdf3b7-goog

