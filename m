Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9583692FE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 15:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhDWNZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 09:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWNZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:25:10 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F62C061574;
        Fri, 23 Apr 2021 06:24:30 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m6-20020a17090a8586b02901507e1acf0fso1255963pjn.3;
        Fri, 23 Apr 2021 06:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wicbX1JgvhArdJhR+hyR7jupbo+4izdh0id2xxwTkCM=;
        b=hjw81NRhqRugQl2cfN12iBG1nJFp5NZV3e2Dz4vDVBjftb2lDIMV/38BIPh/69MqyP
         j/h3ANwzhnZ/lWVcPqLAWfm+ZeAkrIeAOE34QjKvTGuwerDC9rKgye/ua+fbnF69sYzR
         lho27abTjt5IpiYhBB5rbDXDa6KV3/or0OfAyn3CKPqOyrqg+4f0FwTG9aGBsq4kNno3
         YrfMxvzKqmdlkNDDe35i0PMMOwBRt3WCAqSN5QZB2A1Yodq3LIwgMOTxDiwzcnhOR+eQ
         PTDNfVDHaf1EGuqIIAT9bCdCY2WNVEIhzlXoJErehMJEPzekLa1zbwlg4ylQLkTO6j3o
         kIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wicbX1JgvhArdJhR+hyR7jupbo+4izdh0id2xxwTkCM=;
        b=RIvWqm0CNYJi+76e1HIK6Jt7j4CTj37G3eOB84oIvs27LImDa16Ea6l3AoV+fYRFmo
         RAlzypCWVAm4ZxwkChFa4StlCn8PuBauok3bouMK9ssnIjRHL3H5nj/3j8o9ZUjsTC4m
         Nz2Yb88aalur68d7OVMCPOQyKsyTxAOoXzJcgv72pqy19FgMhBujGPeGs4nz4U0rw7zO
         mLgpCsgJ8TFPmzI/kCWgfDWdGfhX8s6qpAIdohGH/qrcnS0DtOSKZR65GzN+JRPbwCLE
         yD7vXF6vj+uEtXP8rC1RSSXtPhep6Sh6S7fcSFhBtO51wwMd7HLs0b6jwPnSm/DZ+NqM
         i5yw==
X-Gm-Message-State: AOAM532MHN7N++/+c5aXN2F0m9uePOKpmyL/xoe18H1UQWrnmeHFtey+
        Tbbx6gk+At8K5wRBZHAE6rjDROjLpS5xhspbb1A=
X-Google-Smtp-Source: ABdhPJyq5d4UiJ6syt8c/ck9U703nGEJa9zcEdL/HPP1h99ITbxFZVJoIvPy21EfrZ3i8vJuPfBARA==
X-Received: by 2002:a17:90a:4b8c:: with SMTP id i12mr5796811pjh.66.1619184269789;
        Fri, 23 Apr 2021 06:24:29 -0700 (PDT)
Received: from localhost.localdomain (host-219-71-67-82.dynamic.kbtelecom.net. [219.71.67.82])
        by smtp.gmail.com with ESMTPSA id g16sm5092880pfu.45.2021.04.23.06.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 06:24:29 -0700 (PDT)
From:   Wei Ming Chen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH] usb: gadget: function: fix typo in f_hid.c
Date:   Fri, 23 Apr 2021 21:24:17 +0800
Message-Id: <20210423132417.4385-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace `me` with `be`

Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
---
 drivers/usb/gadget/function/f_hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 1125f4715830..0c964be58406 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1117,7 +1117,7 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	hidg->func.setup   = hidg_setup;
 	hidg->func.free_func = hidg_free;
 
-	/* this could me made configurable at some point */
+	/* this could be made configurable at some point */
 	hidg->qlen	   = 4;
 
 	return &hidg->func;
-- 
2.25.1

