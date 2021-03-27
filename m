Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063E634B8E3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 19:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhC0S3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 14:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhC0S2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 14:28:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D43C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 11:28:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v124so14065566ybc.15
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 11:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kBTrnovsJTjktUY0EImjz441nnzZDwHzrqZdw8K7lUM=;
        b=XaG99HhlymUYSpLhoY7iG8qg2FQ0jWc0UK5CKWTx0hIZet6OPWvbgtuUNlDy+i70AJ
         gq1uVoe7TKh3OBsDaxkVoywnT5E7+DDhVBd7at9QSICSiwcPusEVQ3rcpKNc4XrAPH+d
         o0VofgDVdy84fWjTlsSOgGv5IEGi/+Xmoun00YI5XL5gzv1Fg36wJzjZWO+RtCr6outo
         sPAQMF9kbMr89kwrz3S7ELtspDEHEk/Ya0TnlQDMKiYGDm1ne5oULbuhRik5Z7KatDNX
         KEr7eVzwrqnuJPNy0fgX8PQX5XBUeESZjsnrOEfYVdq098bugJ1e/hL66GlILClVsFO1
         5P+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kBTrnovsJTjktUY0EImjz441nnzZDwHzrqZdw8K7lUM=;
        b=iK9gtJ6OjAdJAmEzD1DODMA5JuWRm54K2e+dKZVshpNC4pzndo2nSotDcIgV5AlLlL
         y/ygf3pSdtbsVRZVVhcTFEWk7ZtnBpqRNo85aC1ZGouENdCvI6bMeH9JqTPauvZ36DBJ
         dGDqxtoXzcCLlj5LJGDHFMP0RfmE0YKA4GA6PxENQ8VVOURf3GOTG9jyLKz0R8ZYfHuy
         4I2KGzTM+vGIsd66K9Old0Pfex4J3+VlrDa/qKyfqhgyuyfkD8GtibjE4xpCzoSufpYQ
         o3M+whtyomk+OMaw62U70KweOyTBxze9zIXw9b19wyuqNe4v5zciJ2YGYTVwp20DVj+U
         20sQ==
X-Gm-Message-State: AOAM530i1FWrnScl6exIXv8I4GbA67dzPD2Tdp4H89b3W2SQZ31L49Ry
        UrYCIunXMHVeV6GgGfugaPo2wwV2eCo=
X-Google-Smtp-Source: ABdhPJxkzoGreeV6D3MgL0kgP9jcvFhWrOamEkI1ZLXO0cqd5vQrF7cEJIx92FU+4DZkCxIPCMUJBD+6Hw0=
X-Received: from raychi.tao.corp.google.com ([2401:fa00:fc:202:493c:e5b:69c:54cb])
 (user=raychi job=sendgmr) by 2002:a25:6fc6:: with SMTP id k189mr26162957ybc.171.1616869701634;
 Sat, 27 Mar 2021 11:28:21 -0700 (PDT)
Date:   Sun, 28 Mar 2021 02:28:08 +0800
In-Reply-To: <20210327182809.1814480-1-raychi@google.com>
Message-Id: <20210327182809.1814480-2-raychi@google.com>
Mime-Version: 1.0
References: <20210327182809.1814480-1-raychi@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH 1/2] usb: dwc3: gadget: modify the scale in vbus_draw callback
From:   Ray Chi <raychi@google.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kyletso@google.com, badhri@google.com, Ray Chi <raychi@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, vbus_draw callback used wrong scale for power_supply.
The unit of power supply should be uA.
Therefore, this patch will fix this problem.

Fixes: 99288de36020 ("usb: dwc3: add an alternate path in vbus_draw callback")
Reported-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Ray Chi <raychi@google.com>
---
 drivers/usb/dwc3/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index e1442fc763e1..8a361f07e045 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2536,7 +2536,7 @@ static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
 	if (!dwc->usb_psy)
 		return -EOPNOTSUPP;
 
-	val.intval = mA;
+	val.intval = 1000 * mA;
 	ret = power_supply_set_property(dwc->usb_psy, POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT, &val);
 
 	return ret;
-- 
2.31.0.291.g576ba9dcdaf-goog

