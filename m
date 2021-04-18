Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B6736370C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 19:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhDRRr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 13:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbhDRRr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 13:47:57 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A23C06174A;
        Sun, 18 Apr 2021 10:47:28 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t22so22679941pgu.0;
        Sun, 18 Apr 2021 10:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=kgmX5S/cb+60O8Jbhs1MGl8kBtzRSfl9xkwj3Xa3Gs0=;
        b=J3/Vut00S0kgqBJ9WCOumvr8O9zbWwW29oA3oHwDN69Pm6h9mxMHPsYeWTqbF87Ewl
         AEdiSkqiGLgyC9Se5YbUIaQ8CYvkZ+avj1tvfOwwJZj6ykm0uSiFlTgqIHiCvXYo8eEP
         s/5AWmB9jPKBA4+VKHQaxdZUOOw+8ULwd/x5jeF13mVWgbmau55YqXX0uYrWIKVBddto
         c0O1flLS94UPMvJtAuJD7e683VtJG5fzE8hSfNLG13UpmejrFTlG9FAuNYjVp8D5UIaj
         VK9G0RL5Lus+Z2Jt2eJPWqlK8fvu95pfm079l+fgq79kGZKVN3jUsrxuBdJthb9XTnp/
         vi+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=kgmX5S/cb+60O8Jbhs1MGl8kBtzRSfl9xkwj3Xa3Gs0=;
        b=Ospmea3ZpTvGVZk3Ts5rEFKW6dbNtRfatqM0Hx9kaA6BYFywLDUPHRDhR6vHkUKQhE
         FQEbcWe56nLbL/eUj14xZM40jJ13uWXEFWZfD3u4arni7PAZgs9IZVdUC2toUxmoK9KW
         0O9lYQVzoH8UAIcTYvo5HAjrkoAarB3E/I+DzjiQd678NZ74+3yniwSTJ6F8vc//BKPD
         Ps+5XiGCkcxfndDyTQYwUvhE0Bwsbgzkp3vRul8NRm286/YDkiQbQZ7SRdSe+gzPalwR
         LdaZRDqLIqlb3ycBvk7rO7mCP3mbRX/r4sz71xl9HrIgBVDZJ+g5HQdkqswumMl1q8ow
         SSbA==
X-Gm-Message-State: AOAM530NrJLBVVlMgiF6ug4p6hxreryU2EfZmjmafCgjRBcMoVtbtANQ
        5xqn+Rzk5lqNlaCC+2rWT7QGo5AS32T7mg==
X-Google-Smtp-Source: ABdhPJxkh5Wi6xYdwlb2kTtCIXBgcZU9oVoKwVpWbVK/W8rWlRxUQApY6xvT36vzYJw+JLQrEFjk6g==
X-Received: by 2002:a63:f506:: with SMTP id w6mr8006408pgh.367.1618768047467;
        Sun, 18 Apr 2021 10:47:27 -0700 (PDT)
Received: from user ([2001:4490:4409:d07c:b4ac:39e7:e05c:f39b])
        by smtp.gmail.com with ESMTPSA id x2sm10189889pfx.41.2021.04.18.10.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 10:47:27 -0700 (PDT)
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
X-Google-Original-From: Saurav Girepunje <saurav.girepunje@google.com>
Date:   Sun, 18 Apr 2021 23:17:20 +0530
To:     b-liu@ti.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] usb: musb: musb_core: Add space after that  ','
Message-ID: <20210418174720.GA59520@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Error reported by checkpatch.pl

ERROR: space required after that ',' (ctx:VxV)
+#define	can_bulk_split(musb,type) \
        	                   ^

ERROR: space required after that ',' (ctx:VxV)
+#define	can_bulk_combine(musb,type) \
        	                     ^

Signed-off-by: Saurav Girepunje <saurav.girepunje@google.com>
---
 drivers/usb/musb/musb_core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index dbe5623db1e0..a8a65effe68b 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -375,11 +375,11 @@ struct musb {
 	unsigned		dyn_fifo:1;	/* dynamic FIFO supported? */
 
 	unsigned		bulk_split:1;
-#define	can_bulk_split(musb,type) \
+#define	can_bulk_split(musb, type) \
 	(((type) == USB_ENDPOINT_XFER_BULK) && (musb)->bulk_split)
 
 	unsigned		bulk_combine:1;
-#define	can_bulk_combine(musb,type) \
+#define	can_bulk_combine(musb, type) \
 	(((type) == USB_ENDPOINT_XFER_BULK) && (musb)->bulk_combine)
 
 	/* is_suspended means USB B_PERIPHERAL suspend */
-- 
2.25.1

