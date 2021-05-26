Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B86139186B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 15:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbhEZNDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 09:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbhEZNCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 09:02:33 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518D2C061761
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:01:00 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g17so816199wrs.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qOQPZ7P2+d7bQl1bhkEaXoufFGWie1gF+nljkJu9wC0=;
        b=sKCa9Z5UGvS37C92I4u+KIUCl0wzXAzjIP7bBogERl5FuUyOPPKclkJJw06G1h822n
         Qmfo5qvZZPCgUB5+vngf8BRnUzXFdWmoekhArA15G2QU7E0Gny0aj1kTcgvkrB22tCsb
         6LCpj/Epfo+c1p3HHg7gpXf/W3FTVaYwyMomjJyZKeyODiTncWS/i3PGUR/qCXtnLFdo
         tx6btx+Ul9mYh2MxVuI+7AewtWlwl1XrrL2P/z/HiDtodvogUfsdFhf8zC2FrfdgiJ4s
         ERiGPcmn8FSG3YdQfVAVfbLXUDW/XupGyx26HrxD6pf1oWhAsIoOoz2+6bERIeaWrV1s
         uZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qOQPZ7P2+d7bQl1bhkEaXoufFGWie1gF+nljkJu9wC0=;
        b=nWh+HpADGi+Owfx5rleP35ZFXNOw43Riez7ClDyY1JfNnOXeqj5yTq8aQ/8Sro5s7n
         z7FB/2+JBtup5wsgDTT4/uVc6k8fo/PXngSeeKfQpK97n3Jj6P5TXLwcWa6TTowJqMTH
         UZuxPJMP1Xs8JdWXUJySuXl9UsX6yeWeutsRdTS1s5arBPeRBuHDtDXNhlv/49Dp2R52
         YJZSKsZbIKPAGe+bRq5Y72yRkTiWG3MFtA1iDnRGNUsAltLswtHQ3HFZ7Tn27KgW8ECS
         RX0Masi+TS84H7MgYEYR2YpwTBsccSeVc74G7w7zQPEjBAxR6iuuWnCEU/dJY+KWUEKS
         maDw==
X-Gm-Message-State: AOAM533B/ZZTIgjORNpn+qfp9ba3yHzmfOhA2+ZNFoleRNQmjhAeUzg8
        MBHXmGFfrX0i4ftfuS4f9D4ycA==
X-Google-Smtp-Source: ABdhPJxU9uTEqIWW9yn8i9bsD/tIXZXZwWSIhy2p/Ss0S2v8A+QUQiF+aS1Ux0gOmb1wMwf5cEidAA==
X-Received: by 2002:adf:ea8e:: with SMTP id s14mr14015140wrm.135.1622034058258;
        Wed, 26 May 2021 06:00:58 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id y14sm6430036wmj.37.2021.05.26.06.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 06:00:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 11/24] usb: dwc2: hcd_queue: Fix typeo in function name 'dwc2_hs_pmap_unschedule()'
Date:   Wed, 26 May 2021 14:00:24 +0100
Message-Id: <20210526130037.856068-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526130037.856068-1-lee.jones@linaro.org>
References: <20210526130037.856068-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/usb/dwc2/hcd_queue.c:686: warning: expecting prototype for dwc2_ls_pmap_unschedule(). Prototype was for dwc2_hs_pmap_unschedule() instead

Cc: Minas Harutyunyan <hminas@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/dwc2/hcd_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/hcd_queue.c b/drivers/usb/dwc2/hcd_queue.c
index 621a4846bd05a..89a788326c562 100644
--- a/drivers/usb/dwc2/hcd_queue.c
+++ b/drivers/usb/dwc2/hcd_queue.c
@@ -675,7 +675,7 @@ static int dwc2_hs_pmap_schedule(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh,
 }
 
 /**
- * dwc2_ls_pmap_unschedule() - Undo work done by dwc2_hs_pmap_schedule()
+ * dwc2_hs_pmap_unschedule() - Undo work done by dwc2_hs_pmap_schedule()
  *
  * @hsotg:       The HCD state structure for the DWC OTG controller.
  * @qh:          QH for the periodic transfer.
-- 
2.31.1

