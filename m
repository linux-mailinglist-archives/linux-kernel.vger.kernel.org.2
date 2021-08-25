Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9063F7090
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 09:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbhHYHmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 03:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238357AbhHYHmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 03:42:11 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C94C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 00:41:25 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id mf2so31075309ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 00:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rGNuELwobwe6Q9P0rjpd5AahVZOV8f/nV1gzCjuC59s=;
        b=XY+/qvXeyZ3mugrH2M/Sv50uz/QRC4KwiRXM8YKES85Ry+EACA8u9bpmV/wVxORCVb
         /UJj23E99WiqHiBYgJ477l52PRBJIJjzRG+J9PiYfNccBf/LbXFgwQA0cfG7T2qyy0ZP
         aPYO8BPGgo2HKiRwbl0MPp9I4xWtwgr6vRHdy3n5jamS9KIrmEwOmWtmZgWCMvSuTlsj
         10INGmwgOtBFCSwm/RNMKHKJ1Ie7qGTeAg7YpCaom9nqXNIW0H9DU+yjIFsoP9Op4K4h
         bD+GNuAS49204coa48ao0Jq0T3P1dg0zeMbJ8/CmN5le1CDWkSDUiTu56dJjJBlqla+z
         a5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=rGNuELwobwe6Q9P0rjpd5AahVZOV8f/nV1gzCjuC59s=;
        b=SJ0BxkrQ571PsD3DzcsaVtB+tTogKc0Dz2k97B23BuuV1hSF0+scaLxZ6uwQDA+elF
         5sfMn4h8gtiw29mkZF/fuxlf6HPniAHNrqk37LdBEz0GJN4mIuzh7yk1tCwS5tKEv9yw
         Lj6IZLX/rxUR23HbRvWK6qbfwTrF0ihHakI+KL6Nv+CDV6CRBniKj/CdkC6dd4mM1e1h
         YnZMVIRjzlDBZa/gdyno9SmS9eSXNW9wXKilyVJ0rXZoy7n6RIydVMkwGavBIEXZYmaZ
         adSBJt4JgvP6gbT+t9lvtKIJyziN73zVhSPzkgEGhnTJU9JPD0RO2GAIhKwf5QxBD62M
         jeWA==
X-Gm-Message-State: AOAM531KQBTgrusCfg6Ai8hPUVUzO0iAWcetM/P128D7s7GjT+v4tu4Y
        DppYvGxgbWpXn2DN6V73l6glui3aUw/wWZTo
X-Google-Smtp-Source: ABdhPJxlmusMiKHs4knjmKtN+EIwNswsRRBXUTRMjY65PTEKIvrN8ODG0vGHbmTIF2iTFNVe+N3lQw==
X-Received: by 2002:a17:906:4c8c:: with SMTP id q12mr45331461eju.254.1629877284271;
        Wed, 25 Aug 2021 00:41:24 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::e05])
        by smtp.gmail.com with ESMTPSA id h30sm1641287edz.40.2021.08.25.00.41.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Aug 2021 00:41:23 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Subject: [PATCH] pinctrl: core: Remove duplicated world from devm_pinctrl_unregister()
Date:   Wed, 25 Aug 2021 09:41:22 +0200
Message-Id: <8b75e5dfd9363f35ebdd7812e119757379678f97.1629877281.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated "which" from devm_pinctrl_unregister() kernel doc
description.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/pinctrl/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index a4ac87c8b4f8..5082102d7d0d 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -2306,7 +2306,7 @@ EXPORT_SYMBOL_GPL(devm_pinctrl_register_and_init);
 
 /**
  * devm_pinctrl_unregister() - Resource managed version of pinctrl_unregister().
- * @dev: device for which which resource was allocated
+ * @dev: device for which resource was allocated
  * @pctldev: the pinctrl device to unregister.
  */
 void devm_pinctrl_unregister(struct device *dev, struct pinctrl_dev *pctldev)
-- 
2.33.0

