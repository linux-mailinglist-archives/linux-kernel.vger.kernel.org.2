Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDFEE33CCC6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 05:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbhCPExm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 00:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhCPExP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 00:53:15 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93105C06174A;
        Mon, 15 Mar 2021 21:53:15 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id x9so10836749qto.8;
        Mon, 15 Mar 2021 21:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tWCz78Br3XjDvSQE5SGwwRcGJZtd27Y7fPdYPkBcYmI=;
        b=VJqhEBEm56scaLGC4aTRSGHZAQBrgYgfMwjkf52R6GnLyFfW6IbWKP6SGldIIY6bLM
         tqlNYgDq/DcrD/5Hom3nZW+09i1Cxle6/za3JAExDKuQSW6SNvHRhOZD0dSn5SphVkWo
         gpyPr+MrcDhNChSVa42Y2mz8VwckxmUhG2O+j9WVT5zLZqBMMisafynu3mDPW4v0yuxH
         iw5Z6f6bdGw51D9KdvdSQmkUL9eOd3zYwsbsjNFCsfyEIxcIthcrJBxuchp597gCKS/D
         iseHetTikGu19vLPn1nVNoLllAuhiyxMtSvzAteQseQndcT+2Fj21RT5S76AsMw7RuP6
         iz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tWCz78Br3XjDvSQE5SGwwRcGJZtd27Y7fPdYPkBcYmI=;
        b=eOFqBPzpY5t6QJsnRGUlqItBkt7jlG7iEbWSXlPOokb1ZmdySeWA8gY/CSITS2YgDL
         O+VNRXh/M4v66KxHk1X0nTpAREnUocEtC/cQHjXNdoC6t7q+SnTyoen8KAUTt7/njd/N
         EDGw2ODqf/2Ou8peklt3KglzBhBleKjuh7ZL2jZY5uWk9GR1nWoaooQzXAnNBasQwtKJ
         LebDRCcpydAgwvs7XkC60+3ufTurWZ3q8Nk+ssL/zbWci0bFYruMKJvFbSm1NQkRpYoe
         mFxe99tuHIn8h+BoEmITGi9IZc6UMRqGlsEYNkLcJxwNyrZlLBz3UPkKwYc6i0i89jLo
         86Qg==
X-Gm-Message-State: AOAM533PpTej9IkrKU1DgvXXBvOvK2gZQ83E0RCZJFsdRa3pMAg0Injx
        wnqtVZ6pPr4He2QrgK5ES18=
X-Google-Smtp-Source: ABdhPJzOYIrw83wgON+3omliAZuPsyFLHJMtuRc2OQs2dO7K06VVYKk5Viv0/OvH2q9cPNBDLCSSxg==
X-Received: by 2002:ac8:4412:: with SMTP id j18mr24255871qtn.387.1615870394914;
        Mon, 15 Mar 2021 21:53:14 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.45])
        by smtp.gmail.com with ESMTPSA id t5sm10762104qkt.66.2021.03.15.21.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 21:53:14 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     gregkh@linuxfoundation.org, unixbhaskar@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] usb: host: Mundane spello fix in the file sl811_cs.c
Date:   Tue, 16 Mar 2021 10:22:43 +0530
Message-Id: <20210316045243.3500228-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/seting/setting/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/usb/host/sl811_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/sl811_cs.c b/drivers/usb/host/sl811_cs.c
index 72136373ffab..16d157013018 100644
--- a/drivers/usb/host/sl811_cs.c
+++ b/drivers/usb/host/sl811_cs.c
@@ -94,7 +94,7 @@ static int sl811_hc_init(struct device *parent, resource_size_t base_addr,
 		return -EBUSY;
 	platform_dev.dev.parent = parent;

-	/* finish seting up the platform device */
+	/* finish setting up the platform device */
 	resources[0].start = irq;

 	resources[1].start = base_addr;
--
2.30.2

