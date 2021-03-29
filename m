Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B309634D257
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhC2O0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 10:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhC2O0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:26:18 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11625C061574;
        Mon, 29 Mar 2021 07:26:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id h20so4475349plr.4;
        Mon, 29 Mar 2021 07:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=m9ZlEf9Kme4mbiO6IFR/gcxIg4Oa3HNlqB5nKLE2L8M=;
        b=dXh0pE9ejqskpD303Y1mDRnLk7vI6Qrmn8vnLQmo3iktYK//4gKuXsu519xhB6vrt+
         FcldxO2/JmAFjmEvO6BHDEMnsMPfGuqx3TULWCWkZeNirZOFgq0ycvJOX3vFfetdnK+G
         AmM25a4jqMhNOlYySGUkKfN0P5Ua0JBhlizTjgd801Ca92jjxj1MRlEDy/2gTzM1rzcv
         IPNJ83xVdf2Ae3e6cIRn80CaQsKjqGbS022Ve0T2wvkZJXds4hL7dsUob+0yx2nbK8b6
         rTDt+XKSdvkfuzohF9vioVpZQkH+CK+zyh0rreTGX4ExWjwIXYQLSmCiaYjRRwMgu6XF
         dBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m9ZlEf9Kme4mbiO6IFR/gcxIg4Oa3HNlqB5nKLE2L8M=;
        b=qAy8ThzjM+0KQYa7IjvE50VzTw/U/BDkDh8hQUZTmRKONK04oTZaSiwAqutDDeYL5X
         83Susx585u+r3Qflff/W+E9qZza82mHINNjLOIRo5AQSk5tgMlsS4H8VbbSH0Gcjb9Ld
         tVnxVlRzJ6ImF9619creLLC8odbCTE8pNY0UzQZJAGTcdfmSGvAY/6F4and88aoOgOb2
         MAyl03/GUQ9NdjDGDElyzj15bbKpSU+EDeYbyKZ0B2Qk8SJuoZh53pYDkJy1VcJN3H8V
         Xgrx+L4J+ybv3Dpqagmw3vp7ckIlB9RWOu/RE1MxDzZGk4h3TW7a2mP6ZJGjLXLii+Hp
         dpLA==
X-Gm-Message-State: AOAM530R5RWQO9gdEAx6db9XE63BmZd2dUbgugdqKycoxVxNJzgN3Nv+
        P1DAXHhihecG6hUxJ27Q1qQ=
X-Google-Smtp-Source: ABdhPJxiyW8fdmbzHiJw0DVGGzwsumamMCVvqh9OAV5jj6j1DU2bfOuMpz8NnNKqu111rrzl/ViQiQ==
X-Received: by 2002:a17:903:228d:b029:e7:1f01:bab0 with SMTP id b13-20020a170903228db02900e71f01bab0mr16660231plh.80.1617027977531;
        Mon, 29 Mar 2021 07:26:17 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a089:4ed:8f53:adc7:b574])
        by smtp.googlemail.com with ESMTPSA id f65sm9641341pgc.19.2021.03.29.07.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 07:26:17 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     balbi@kernel.org
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        gregkh@linuxfoundation.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, rdunlap@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: imx8mp: fix incorrect kernel-doc comment syntax
Date:   Mon, 29 Mar 2021 19:56:04 +0530
Message-Id: <20210329142604.28737-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark '/**' is used for highlighting the beginning of
kernel-doc comments.
The header for drivers/usb/dwc3/dwc3-imx8mp.c follows this syntax, but the
content inside does not comply with kernel-doc.

This line was probably not meant for kernel-doc parsing, but is parsed
due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
causes unexpected warning from kernel-doc:
"warning: expecting prototype for dwc3(). Prototype was for USB_WAKEUP_CTRL() instead"

Provide a simple fix by replacing this occurrence with general comment
format, i.e. '/*', to prevent kernel-doc from parsing it.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
* Applies perfectly on next-20210326

 drivers/usb/dwc3/dwc3-imx8mp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index 75f0042b998b..b13cfab89d53 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * dwc3-imx8mp.c - NXP imx8mp Specific Glue layer
  *
  * Copyright (c) 2020 NXP.
-- 
2.17.1

