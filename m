Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79690444CEA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 02:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhKDBPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 21:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhKDBPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 21:15:34 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2494DC061714;
        Wed,  3 Nov 2021 18:12:57 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id n23so3920233pgh.8;
        Wed, 03 Nov 2021 18:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IVu0tbLLxmk7blwPwfUFDP5GkHVSYjXtlbgYnA2bsOA=;
        b=kyji4rZQQADxOmhEb/NYzXkRuj+xN6yzzcHW8IqPqczD0FPTBRgU8SG+GGnHQNpIZX
         vGDncRATWYrOTz/q4yPTxiWqwGgZrFzdS39ROtx7UlI4fnHIw/v+9rkLiIawyo/eZhPA
         IxI1AgV11AND/RGEPfA0QCT8T2oiVicGFiUpM+4X5a6SL2t2Dyg7n/eoe4tpi8IzpIsR
         FzgSVHXIEfPB2O9qgadhvWYhZoaFjQAF7LlFWbKz1HlzCRkYR+SM2DdZhIKQFY/a0zVK
         Asq9q460hrCdePNxu+4YkEr/HiJFvHj0c2qikdd4ElZY7SBt6xIOImSO5ELc+0Tdcexe
         YAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IVu0tbLLxmk7blwPwfUFDP5GkHVSYjXtlbgYnA2bsOA=;
        b=u90V3tgLyzSav5PFM9kIwqKIfBZsnEEUuCoC0ZlSJXbCPnPwFf5yCura1umfQvc4cp
         YxrL9SlDGbzFLuutZ1urceiRo1MS2pUtZCZyb7yRtPxkoJE/Q3y7yOdDSodLuY9XSYdE
         0eODz1mmk6jqmd88z+On5RCMI7RZCF2e8XYFpP9kgEJvnFjUiC+NrYa48T2Mg6PpJ+Ds
         CBx2npvojyhMwO9g+2C1Ra5oOxdi8swvQFwPSsJL8vdSYTGGTodVKQu25TQ1blLn2XF1
         Creb5vttc2IvzCvnsAu0pzZGVi2HoHmnuKyzv64tf3Z+bWf/9MZQh5O6jJLb2yLM7s7b
         Qt7A==
X-Gm-Message-State: AOAM5307ql9+fqLW2qtHepo7Fjdh05U/Gx642MNz6TZvIj1SRCxsOMgI
        7igvzjcunLlSQEX2oGUpt0M=
X-Google-Smtp-Source: ABdhPJyuN48WEj2SI6wfK8T+uxAc0TWupez2Upq76eHaZ7CSmgNwZSxNj4C32sCf/NNK2mUVvTzfqA==
X-Received: by 2002:a05:6a00:1489:b0:481:2a68:b7cf with SMTP id v9-20020a056a00148900b004812a68b7cfmr14555325pfu.66.1635988376749;
        Wed, 03 Nov 2021 18:12:56 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id k2sm3844768pfu.112.2021.11.03.18.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 18:12:56 -0700 (PDT)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     balbi@kernel.org
Cc:     davidcomponentone@gmail.com, gregkh@linuxfoundation.org,
        colin.king@canonical.com, stern@rowland.harvard.edu,
        yang.guang5@zte.com.cn, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] USB: UDC: use swap() to make code cleaner
Date:   Thu,  4 Nov 2021 09:12:45 +0800
Message-Id: <20211104011245.1027675-1-yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 drivers/usb/gadget/udc/net2280.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
index 16e7d2db6411..71e02bcebecd 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -933,16 +933,13 @@ static inline void
 queue_dma(struct net2280_ep *ep, struct net2280_request *req, int valid)
 {
 	struct net2280_dma	*end;
-	dma_addr_t		tmp;
 
 	/* swap new dummy for old, link; fill and maybe activate */
 	end = ep->dummy;
 	ep->dummy = req->td;
 	req->td = end;
 
-	tmp = ep->td_dma;
-	ep->td_dma = req->td_dma;
-	req->td_dma = tmp;
+	swap(ep->td_dma, req->td_dma);
 
 	end->dmadesc = cpu_to_le32 (ep->td_dma);
 
-- 
2.30.2

