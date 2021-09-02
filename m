Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A693FEEF7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 15:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345283AbhIBNuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 09:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbhIBNuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 09:50:20 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFE5C061760
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 06:49:21 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id g135so1325807wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 06:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xRJTxe9GCh77SaDlbDB+FZbUegUlnF22LpoVaorZJQg=;
        b=ON6FYE6MBGgnZsLeTynL84+Wj2xJPLchEu1olpR+97ROZ9Rb4TA0BI7xFmGKdefn/z
         fivNNCVH19nHn1+ta7RiF8hYUB+zVOpaEV/aqSzUpM/7zLDYM733GLkgc13+XcbZInRU
         6pgCIHuAebI9Ez2uuOkfktlaM48gXtSIn5lb4bKznV9o94yn88ac491KcBVIUPFVUrDe
         jOKFwK5zTI9e127t4pNIyEzYHvoqZkH1t9WbVSFhk6Jph+mPjEL4c4U4kY1BVAvchyrU
         fXFg5eChpNlhdyOUxnocAuYEei3velVVClYOo3zA1krjCBodrEmTyY+LlaxFagDmw6ny
         evlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xRJTxe9GCh77SaDlbDB+FZbUegUlnF22LpoVaorZJQg=;
        b=j6dVSvlxoxhN6d8wFq1ufSEhUM+AIaXVRQhh3LObFxGG6e2RMm5Cko4mr/IkNBwEcT
         puxSWuNLbLQDmpr9tsVTWgMYLfxCqtHvRv9DHQK729EWykXTwheE/IkeSwlCgUIxBIvC
         J+qpGTQU63AWiMYqdnYKSm2NSLP/EIVENQfUHbsyINkiiOi2dQ22wWs0LO6mAnNkRecS
         7GaaDClcyMp9QG259xqb3KK3w+8qub9ESDEleMnx0DDur6ZwNhOfq3OG3dZdonJbf/AQ
         b4d89/kh25vn5eywBjoG8ymg8HftM9ZEGPor7q87a6fg0NXXCipKwh6tB+0hzmLXDwSD
         Ze0Q==
X-Gm-Message-State: AOAM530+OLQLPO7tjpEbMjT+NOcqIU+wgoEBEZ+/ADTUBIoNxs9UYPn0
        C5Z77Aq6f0Dxhurztoudar24/w==
X-Google-Smtp-Source: ABdhPJzf5O7l8jUYGeFWytspijFJtS612FyDJIWxp2MEZBk4cIvPg6hkWZTsI1xLbe9vUrTrpWN5tA==
X-Received: by 2002:a1c:3587:: with SMTP id c129mr3236020wma.57.1630590560220;
        Thu, 02 Sep 2021 06:49:20 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:98:6312:3c8:6531])
        by smtp.gmail.com with ESMTPSA id z5sm1710162wmp.26.2021.09.02.06.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:49:19 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     maz@kernel.org, tglx@linutronix.de, jbrunet@baylibre.com
Cc:     khilman@baylibre.com, lee.jones@linaro.org, saravanak@google.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/2] irq-meson-gpio: make it possible to build as a module
Date:   Thu,  2 Sep 2021 15:49:12 +0200
Message-Id: <20210902134914.176986-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=741; h=from:subject; bh=BJ0wKgM/sh8qVeWw6Ci5X3TYYqzyBgAeXkMIaAo3sXE=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBhMNYSLQmqINVZJsypWOhkIEXc27P7zUuNOY19OoG4 ywFgk3OJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYTDWEgAKCRB33NvayMhJ0TzPEA Czhm88XDsKBhKVWoSM6QDNAFAe8mHAM+qjLKIwZhe/JNTfuqiHEXd3sM4aYtO6otxUqXNVvJnr/pNl 65kYbgZ0kdmD7jNfzt0LXd329sFTDxI/FSBLV/X6sqrMzXnsvZNlRW2wQqNvoxzr2wA6LvVjHEidDD BLBe99IFGyQuYNNx0SaoSKlzON/6hGeak6qeQN//44rwxFEz5vh54co6N1tDZ41XHdjs/FE4KI5c12 Hm3IMvFFc4YZX3kdhP4qpmy3avxICZA2jKUIj8tOjDhewCyzu98q5s7ClIr23WF973bizrGz/JYYYv nprgc1tnoXiNU1GQ292NRDxCgcNSWzrSR/hGkfKutdKaNdm7asnS/+8WEZr7i4Ez+5MTP+5ezKQFQU /BZgS+UuMmdjfMADlceIqekVRIUDdWSJepaXAu28miAviPzpxO7Yo8JA635xAnzWLVRMPkks+uC/3n urX5YPI86E4TPJ03oN6HFjbk5pc+IDq+qkJaH7f1Gd2z5PaUZlu92G5pgOyI+UNRjDylIFWV3ZQDb2 nW4FOYOGMNuKEjHz0lmtUASfClAxSbcmXXuDmPbryCerI+1eniQ+vOSe4cbMT1v7+qwOreZvZRNMgo mqojFCXcVd1OhM9IzgiOs7CruZbM9sYDCLfb52VpPC+Waq82WiNl6nR+bKkw==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to reduce the kernel Image size on multi-platform distributions,
make it possible to build the Amlogic GPIO IRQ controller as a module
by switching it to a platform driver.

The second patch removes MESON_IRQ_GPIO selection from ARCH_MESON to allow
building the driver as module.

Changes since v1:
- makes usage of IRQCHIP_PLATFORM_DRIVER_BEGIN/MATCH/PLATFORM_DRIVER_END

Neil Armstrong (2):
  irqchip: irq-meson-gpio: make it possible to build as a module
  arm64: meson: remove MESON_IRQ_GPIO selection

 arch/arm64/Kconfig.platforms     |  1 -
 drivers/irqchip/Kconfig          |  5 +++--
 drivers/irqchip/irq-meson-gpio.c | 15 +++++++++------
 3 files changed, 12 insertions(+), 9 deletions(-)

-- 
2.25.1

