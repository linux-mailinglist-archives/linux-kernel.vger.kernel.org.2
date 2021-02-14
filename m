Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F0531B03C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 12:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhBNLhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 06:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhBNLhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 06:37:22 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFAFC061574;
        Sun, 14 Feb 2021 03:36:42 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id t2so2215644pjq.2;
        Sun, 14 Feb 2021 03:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pH8rOENFzpoMYerchhc3cHy+5zJmbz3tm65XTTAtcH8=;
        b=WXgJRKoEqq/d94xfHBtc3/zEyareNNDedovrrNX1/NuWm1moDErEc2W/U2GaeJDkQy
         woTHTwTjL0Cjcuzp/aJqmSgm2NvOtrFsqsESK0lx5p/shfto253Nx8F+ffLtAGYKav2y
         xRsduOEcVizOzxcKfaC2g8OTnCd0omhFWtb234u/pklSYSdqyURBih24dFDmiBcZ5eqL
         24DfIAERaL9rj3NWrcd9tuhCG7K0CCuQbE+WRGDM718lYickDG9UDuEAEhQ9XebmR98K
         GUoLGhKwEQpVdz1snpSz21PHWjh3NHIZ2tkWicuuHt7RCN72mlBeGfz+Dths+Iw+l7Zo
         /JZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pH8rOENFzpoMYerchhc3cHy+5zJmbz3tm65XTTAtcH8=;
        b=Tp0ka4fuZql6GGfXd+DXTzvBdnQ+t8TvpM31lB4V9/Vl4F2H2BaTre2sz7jW8lY32f
         0yzeZpCA1HmEMHwGwRj9iB6S4a1yaSBYl8E6L1XGhB+9x3GrdNnTe8aPlionOI8Cn8xt
         2pOtSEVEhOhvQuRnVYyjD8hiMeUhz7UPsFB3ZQ7pR8va9C2QSezOgerKKkmou/MMgAqi
         +LyVou3R62t8t61ivmlJ7RFC27X46pa212kTH8Wf4zL5g4aopr2rMMF1VkC/u6tg7E0z
         e4xrY1BONauwB1bCoQ2sOBAimjuVyUIBu1kAXpUGZijPKd7kDdq+JQ9cVSfkZfE9FuYp
         wUUg==
X-Gm-Message-State: AOAM533+8NqPkkG6hN4Bjh9AVkRF2dSb7nbbgX2dI7LcHib8L9rQp5tR
        LqGEz1HUnqek3a+D4kDODVxMr0LpC26arXIT
X-Google-Smtp-Source: ABdhPJwf2IHb0iRHPF9jotF/8ptVOT2Yg1E7vG9JT7don/BJqquzlEW9/CHniwTjPF5B9v8IE6oDTQ==
X-Received: by 2002:a17:90a:ab8b:: with SMTP id n11mr3346682pjq.85.1613302601975;
        Sun, 14 Feb 2021 03:36:41 -0800 (PST)
Received: from localhost.localdomain (125-230-72-42.dynamic-ip.hinet.net. [125.230.72.42])
        by smtp.gmail.com with ESMTPSA id p8sm15518496pgh.0.2021.02.14.03.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 03:36:41 -0800 (PST)
From:   AristoChen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        AristoChen <jj251510319013@gmail.com>
Subject: [PATCH] usb: gadget: function: fix typo in f_printer.c
Date:   Sun, 14 Feb 2021 19:35:25 +0800
Message-Id: <20210214113525.9279-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In line 824, it is trying to enable `out_ep`, so I
believe that in line 826, it should print `out_ep`
instead of `in_ep`.

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

