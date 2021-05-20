Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBBA38AF4C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243440AbhETMzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243514AbhETMyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:54:43 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3DBC068D91
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:19:13 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i17so17423192wrq.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dkaItMM+j0nzZYMXwgyNRLwFzj6nPa5IeKho6Y3fEMg=;
        b=IreVh6DIJJYmEhZTaGqLSqsLyYNyAKnjO+OfjK9n2qnqFoi2FnJIlm71bvE++XA8uO
         St00Y4L5vBgNFUzmeSYBNIAeUnKCAoHFfzwH3roK7yQHjDIdFC3sMMZ7fvwoxoW3lAuf
         ge4GCiL598g7aT6O5AlmRzTUjqkTAfkAw9l/7VOz1qLNkc8UBvtUizZoYKS5OYPgGIG8
         jNCNXPmwmNEzQ5P+mLuGd5PUp7u4gN7T+QritZSBM1pIZsKGJhrycydf+KnXaLeFwyNi
         JrR5wNsmlcP5Jo1BvEefuQKrScdHFRTWPhUSEFCLMjm7/lDLNxsJCxKAwEZ+gmNHbW4K
         WX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dkaItMM+j0nzZYMXwgyNRLwFzj6nPa5IeKho6Y3fEMg=;
        b=L1WV8oDRKce8UUaJby+sSAMkoK/drADsBTiGKatqOMUheAPxSwvOfcC9do7OFaeCBY
         YII33O1A+D3Evm/fkAxglYx8QiY30P6OFMRpHGaHY+E5/bc4HDnVAnU3Qu/ACgNLa/ta
         PRm/s4lQmwdjTOhI0nTOqAh7DSh1/sq5DiwlcvxpHRtG+DQ9JkFZwvF3c7JrNwsXGGMz
         1N5Ok9C7n+YeqIYE0O799kBYtEGtMGDhhOCn9+Hb12JwcQN3DN0WrcpPTCv9fOP+MrBQ
         fWQXJwpGcU5L47IBVfAZA1XKuFxPBHC5fchdC2sQ0QO2xZLe5ykj4KU/qfRgmviY3UZW
         qh2g==
X-Gm-Message-State: AOAM531sue9D3ih1hNoS35uxPh+bjweSiyFgb3WpFfydrR/2HHmD6Mrm
        54uJCuNBc8ZBwbnph1ipTVSYup2fyUtEkQ==
X-Google-Smtp-Source: ABdhPJxVgp4v4qca1g2+/hrYrllgMDPcDpwPol9iGIVOfOxCLP2Dzfy35NSOe8M7OX5FaMvb1Tc/Kg==
X-Received: by 2002:adf:a4c1:: with SMTP id h1mr3928652wrb.7.1621513151614;
        Thu, 20 May 2021 05:19:11 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id f16sm3061161wrm.47.2021.05.20.05.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:19:11 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH 02/11] tty: serdev: core: Fix misspelled function name __serdev_device_driver_register()
Date:   Thu, 20 May 2021 13:18:57 +0100
Message-Id: <20210520121906.3468725-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121906.3468725-1-lee.jones@linaro.org>
References: <20210520121906.3468725-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/serdev/core.c:809: warning: expecting prototype for serdev_driver_register(). Prototype was for __serdev_device_driver_register() instead

Cc: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serdev/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index aead0c0c97966..9cdfcfe07e87c 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -798,7 +798,7 @@ void serdev_controller_remove(struct serdev_controller *ctrl)
 EXPORT_SYMBOL_GPL(serdev_controller_remove);
 
 /**
- * serdev_driver_register() - Register client driver with serdev core
+ * __serdev_device_driver_register() - Register client driver with serdev core
  * @sdrv:	client driver to be associated with client-device.
  * @owner:	client driver owner to set.
  *
-- 
2.31.1

