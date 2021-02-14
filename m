Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7258131AF8D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 07:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhBNGyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 01:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhBNGyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 01:54:47 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E06AC061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 22:54:07 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id z6so2280646pfq.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 22:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xwgG9p72mhZkKtVpILBhmkVsNqvMEwMYTp1+ce8LMzo=;
        b=cJIhVJXmKxKkJKHikKXvdwgR4UA5TK0ev9YOEcK5+UnloL4M6PKAxShEbyBN/0xzUb
         qR4yqQujmYGipMd1mS1i5ZhAld0/5HuQuyz/MDWTymlCwYA/9FJ7Q/y5TE5SVrTghy9s
         041CR/8pHgWJINZHifWe2z0UtV2oRRwyNgV8watOaC+Q0lIDZNyJSH9CRqZo9pE7ZZ0K
         MOoORvfKlQxu+6aVaGXxVdRdTosP2PQZ/aUUFnldLGxKY7Ae6vmQi98uBqrT0qeg2b6X
         xe/7VmyB1C1BaJO/CJb1WOYyf+fbzWS87REa5E7DIC3+mykCRNwVZEVjgmLO5L9GBCGD
         elfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xwgG9p72mhZkKtVpILBhmkVsNqvMEwMYTp1+ce8LMzo=;
        b=gpL7BOrEVHXC1aHjKC0Mi/oBTUFnNAAEmPmX/a6RsQ9CuYeNJpVqkPfHO03FNGQwHf
         aCwAa2e8EInQVVJo0gjKmwCT4N+KpeFRBZ5LOyo6Os+TZLHa6MFdwLQfLx3uEcc94FDx
         ra8o3N+z67QGA1tHfYC6UAyMB7rufSFb2BSFzPAVcBMT9dZfYN9tcjkIAW71yCtsu0ju
         BhdD91cub8wOqhtpFxmnriGpfQ7pK/yfHT3d8W4uEwsTzQjtPx9wamOavRATYjo70o51
         DUo2g9D7Lr8bi44O4BCEYAOvRp+ahPmgUOlD6PsKM7a36xKTCr1ZW1ToNGDP7/lcKM8P
         pfdA==
X-Gm-Message-State: AOAM530ct6zb6wE9MC+HlrIsbLspphbFu1oT9VLrXo85L1OvkptVTYZg
        M0cA7JkdKBuktSH71iGEXOfq+AFyI16plA==
X-Google-Smtp-Source: ABdhPJzp7JG1kwANXpeD/qBxlEDsKgWlYznua2V7Ocp7ook+cGzStV3G4DdZxFPmHYc/sJuUVwlHVA==
X-Received: by 2002:a65:4906:: with SMTP id p6mr10262401pgs.419.1613285646955;
        Sat, 13 Feb 2021 22:54:06 -0800 (PST)
Received: from localhost.localdomain (125-230-72-42.dynamic-ip.hinet.net. [125.230.72.42])
        by smtp.gmail.com with ESMTPSA id c188sm13652158pfa.98.2021.02.13.22.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 22:54:06 -0800 (PST)
From:   AristoChen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     AristoChen <jj251510319013@gmail.com>
Subject: [PATCH] Fix typo in f_printer.c
Date:   Sun, 14 Feb 2021 14:53:54 +0800
Message-Id: <20210214065354.5490-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In line 824, it is trying to open `out_ep`, so
I believe in line 826, it should print `out_ep`
instead of `in_ep`

Signed-off-by: AristoChen <jj251510319013@gmail.com>
---
 drivers/usb/gadget/function/f_printer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index 2f1eb2e81d30..a3b17ec00bf0 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -823,7 +823,7 @@ set_printer_interface(struct printer_dev *dev)
 
 	result = usb_ep_enable(dev->out_ep);
 	if (result != 0) {
-		DBG(dev, "enable %s --> %d\n", dev->in_ep->name, result);
+		DBG(dev, "enable %s --> %d\n", dev->out_ep->name, result);
 		goto done;
 	}
 
-- 
2.25.1

