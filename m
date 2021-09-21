Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D714E412F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhIUHgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhIUHf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:35:57 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5B8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:34:29 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t4so12824504plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UY4VFQeyB2IpV07haYw/yiFQ+tUqvcpG/fKqf0ei+vk=;
        b=JzWSiBPd+x449jkuMR0fvq/jrxS4+NJC/6Yv85lVPg0vdiJTYqO3fEKd8e94PNXUvG
         xARvGniE0GiyOBJolQrFQ0aZHdWtmx0/hV/UHB2wiihZUmrRiHVEZNyQXlST8M3YJZN8
         RUm8auIzIfPBkDmBKaLpqTu6BkfgLulu2lwUgY0S+ABrCXqZh72vnAWtxFjWoWX8WJXI
         cpgye1nd0+qNn/BVx6UwbOLifDqGgAJqBeWB8ibOBFKMYrKeoxE2l7vlVmAyYEKqz3Pb
         A5vE4yyrhtxFZjGGikQX2SL8bVeOTO8qnqZRz2wCN65nfXjGtIhsqCYR4aaJQzlOLjqr
         aBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UY4VFQeyB2IpV07haYw/yiFQ+tUqvcpG/fKqf0ei+vk=;
        b=W2XZRRp1/DmrVB+VdtgNuswZXi4VWxgDzxCLzU/Hufd4JipmEln6mKFGiB4QrKdohu
         f0ZMZwEMz8Ffj8KkWD0vhxvl5vau9+wZNqKkcq8PaBH2WhAqE4T+R5alMAAe3o+8n2u7
         dt02cNxjPBFnJjHEE0ShzWYlLN+pjCeRUQbOQ7PgYWGrmnEvVDZxSv8Uuhs/XBgo5L8r
         uHEPblHt1dnsxMy4FR+rVztG2xeE3TNomLmZzQKgzlwsdNQNjIlm5tcqjnBoWjB2XQBL
         ExAe+KpKP43aP2vMMTOGeFJx6bWZSZGpgVjkJPItlSesKZoWM1cM5c33uy6MnoZlwV4f
         X1Cg==
X-Gm-Message-State: AOAM532DWT9jyxlfnIBvhD3BIJJ03yfz+tLf+30oDqxHSnb9Irq9AiR6
        j0zc8ijKh9niWLhOEAgdrMA=
X-Google-Smtp-Source: ABdhPJxUdxWgwHsIoZOak4+VzsRQ25LfxNYvjXvHVojtOqFe1aBFQo4isip2KroCBut9//Z5W7oqFw==
X-Received: by 2002:a17:90a:c485:: with SMTP id j5mr3691311pjt.109.1632209669471;
        Tue, 21 Sep 2021 00:34:29 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:2130:198:9b25:1cfb:9ff3:2a8f])
        by smtp.gmail.com with ESMTPSA id x8sm16565957pfq.131.2021.09.21.00.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 00:34:29 -0700 (PDT)
From:   Benjamin Philip <benjamin.philip495@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benjamin Philip <benjamin.philip495@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] staging: rts5208: remove unnecessary parentheses in rtsx.c
Date:   Tue, 21 Sep 2021 13:03:43 +0530
Message-Id: <c06496fefb33677765cae2b9af50cbc185cdcb99.1632209460.git.benjamin.philip495@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632209460.git.benjamin.philip495@gmail.com>
References: <cover.1632209460.git.benjamin.philip495@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes unnecessary parentheses that have been flagged
by checkpatch.pl in rtsx.c

Signed-off-by: Benjamin Philip <benjamin.philip495@gmail.com>
---
 drivers/staging/rts5208/rtsx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index 898add4d1fc8..41d13becec5c 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -558,7 +558,7 @@ static irqreturn_t rtsx_interrupt(int irq, void *dev_id)
 				complete(dev->done);
 		} else if (status & DATA_DONE_INT) {
 			dev->trans_result = TRANS_NOT_READY;
-			if (dev->done && (dev->trans_state == STATE_TRANS_SG))
+			if (dev->done && dev->trans_state == STATE_TRANS_SG)
 				complete(dev->done);
 		}
 	}
-- 
2.31.1

