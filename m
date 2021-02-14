Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5784D31B050
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 13:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhBNMUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 07:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhBNMU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 07:20:29 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7AFC061574;
        Sun, 14 Feb 2021 04:19:49 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id c11so2509124pfp.10;
        Sun, 14 Feb 2021 04:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jtpRxbNI4kaa7kXHosP8XsaVZDYRyeijyzXgX1YcYu0=;
        b=BhERIfzCbxoo/DEp0ND4Gw5jgslcYCctQVPEOYFf3JY+bAsVSkhYzERTdpqj6xlXvi
         KvJwmylf689vRAUl1+9ywkVHZ7ip1qDWxVCW7RUwih5xpyvYVwrDjwGOmSNkO1o9Euy0
         34LZLSazhbrhn8D1huF1ZbnhCH3tQ6rLKq2yh4XrQ7P3u1UGgCMWMI8SsJQhP5Fv4REZ
         YJnNuqRRtcCIPq2RrZVfziT/1Orcma8Uit1OhOFxAr4i2pJi9OKR4mnhTnPR7Mnt3hoL
         nOmGT44YExX6X5tiXk/JFYLUo/0PgXaxkpxgoNcyFAn+WRUwOliMJwAgZRBJgPloyHUh
         u4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jtpRxbNI4kaa7kXHosP8XsaVZDYRyeijyzXgX1YcYu0=;
        b=cnSaYsqCmux4OnvPEDdZrQBX9AWh+x4YL7WLJmPUeCU1sPxG4aplqN+nSDZsruyH37
         os0KSStKr4NOGdLpnH5a7D+KSuspLu9JqYXKuO6wnYoubmxm3Cnrs/gnOv+2is+3vPAE
         nPauC6buqvg2rdgYdPMiS9Ygy8GVLT8tuJtd8Iytvi4PwD1Q9KR0sZHXMOlZqJzl+D/r
         SghAdWeiIn8kPqAafCAqpm5r+QgtPY6Wd1whoDQXny7AQ337he97lO4FHnXiaqc8RYZo
         +NnYBgiwYwxO4KubrufgNPrUsHQMELOlc4XiQLW+mTao6MifebyWnxouQAzEeS9TIzzv
         /b8A==
X-Gm-Message-State: AOAM533VYNCW0k01uQbWV4oDBRplzhvPDnGhlgWM0G1P4c6IP6qy5EfM
        dBZjupwJ8uc/WAKYBaR9yKof3kgfUkhzQig5
X-Google-Smtp-Source: ABdhPJyh/7P9bmtqrToY9llqCiWhtSTF6/Okj0RWPEpORqcAm0OgZRWUsDeF8dafqBR2RF66V/qjnA==
X-Received: by 2002:a62:7dc4:0:b029:1ba:765:3af with SMTP id y187-20020a627dc40000b02901ba076503afmr11138733pfc.78.1613305188610;
        Sun, 14 Feb 2021 04:19:48 -0800 (PST)
Received: from localhost.localdomain (125-230-72-42.dynamic-ip.hinet.net. [125.230.72.42])
        by smtp.gmail.com with ESMTPSA id q43sm11179085pjq.25.2021.02.14.04.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 04:19:48 -0800 (PST)
From:   Wei Ming Chen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH] usb: gadget: function: fix typo in f_printer.c
Date:   Sun, 14 Feb 2021 20:19:29 +0800
Message-Id: <20210214121929.9750-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In line 824, it is trying to enable `out_ep`, so I
believe that in line 826, it should print `out_ep`
instead of `in_ep`.

Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
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

