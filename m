Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9603A8A19
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 22:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhFOUXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 16:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhFOUXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 16:23:15 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35024C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 13:21:10 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id h1so9077076plt.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 13:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kZeChoY0M+FmLlvHm2F3nX0q4hTu4XNf09lurX0ghS0=;
        b=FC6USpLMoXeZv2Q6R6vRzYkseNz7ln7nvHa5+3mDHaMyHTaenqx/7bUQdaTeVYTh2r
         IHKCRcEuqTlgxIJNEkf4qeoaLZUwP0xJwnIwjbUYt9dFglzzhL+kzTzcrpCOrYtcBmSJ
         FW5IsQ0UuN2voagEJ8Ew7puKqzKI/wSaawx3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kZeChoY0M+FmLlvHm2F3nX0q4hTu4XNf09lurX0ghS0=;
        b=GgeI7FSTREA738BiBE6tZR7pxtPNCVWlLnGmTv2hpBYj4XBHq/KuLu5rHbsjL8TXry
         gcWHhResZ+9Y7lGqmI27aeSYhVOECnKhn5thyVKkhiOmU487jd0Llh6c5BCvo8moTrhx
         5pH10AoAgZKcor5oxGqaYtUcDGBy0xVC//QR2+BR4HzuiroQpXFR/WbZw2YDmEauRK3O
         cgh4ouvUhipOe+vRdD46GQJ4JW+5ZOgZB3L1OxoaTu/sfikSMpn2Jgg1cGK3wdwfHhn5
         A7qwdBLW8zjnv2Ax7ZmOmSHYFfqwhBjuoMwmNvjZYFETp6iqKxMeVhp2xjb+/glohbHh
         N+MQ==
X-Gm-Message-State: AOAM532I7VGmWLkd3EtdMcLm9SIqMH1j5rHgM7E7iShQ09e6u2UZ2ZGJ
        8+PHHFTKGrdvnxAuRlpz46nK+A==
X-Google-Smtp-Source: ABdhPJx0g6HBVroxMGjzCcRC1WZCEfnmwbN1Nnfx4UC0m679EM8coJJaa3ztSONc1bvyc7hSswBqvQ==
X-Received: by 2002:a17:902:ee8c:b029:fe:dc5f:564 with SMTP id a12-20020a170902ee8cb02900fedc5f0564mr5672137pld.71.1623788469782;
        Tue, 15 Jun 2021 13:21:09 -0700 (PDT)
Received: from pc98bx3.roam.corp.google.com (c-73-222-23-249.hsd1.ca.comcast.net. [73.222.23.249])
        by smtp.gmail.com with ESMTPSA id i1sm23145pfc.206.2021.06.15.13.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 13:21:09 -0700 (PDT)
From:   Daisuke Nojiri <dnojiri@chromium.org>
Cc:     vpalatin@chromium.org, Daisuke Nojiri <dnojiri@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] mfd: cros_ec: Add peripheral device charger
Date:   Tue, 15 Jun 2021 13:20:46 -0700
Message-Id: <20210615202051.1411878-2-dnojiri@chromium.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210615202051.1411878-1-dnojiri@chromium.org>
References: <20210615202051.1411878-1-dnojiri@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a cell entry for PCHG (Peripheral CHarGer). PCHG is a
framework managing power supplies for peripheral devices.

Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
v2
* None
v3
* None
v4
* None
V5
* None
V6
* None
---
 drivers/mfd/cros_ec_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 6135321592b76c..f3bc1cb6891ba5 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -116,6 +116,7 @@ static const struct mfd_cell cros_ec_platform_cells[] = {
 	{ .name = "cros-ec-pd-sysfs" },
 	{ .name = "cros-ec-sysfs", },
 	{ .name = "cros-ec-pd-update", },
+	{ .name = "cros-ec-pchg", },
 };
 
 static const struct mfd_cell cros_ec_vbc_cells[] = {
-- 
2.31.0

