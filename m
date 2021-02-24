Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8493243C6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 19:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbhBXSbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 13:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhBXSbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 13:31:13 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAD9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:30:33 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id l12so2848570wry.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HNg21NrFFSzG03akl4ik4jz1Jh6GwsesirJ9uxFbwiU=;
        b=mu++/MQTLxhrxBnIq7qWduUGmbOCTgcpg/K1MUKyzsPEvgWoczFajqUT2PUn1tyqty
         88/iOpznl4DdlFoWt5bbEW8G+TWi2W2NaODfzFYFIqW7wlB0o7S7FkdXU7RmYJziWvWE
         uw7ZQspVgYGALyjNfRDxE8mA0MlnlQhKUBiWjdJ/FtGugpdAsUCdeuv7ljurlnMUDO1q
         XlAqJTQn42+dFtqhRvpwy98i2REuaJKoi0J64R4ekhZVivfZ83dVbg6n5WMzxX1aaQG6
         cV1EaqPusecLBLtdTmM++T2xseC5nGB9Qww8/N/9PCQOZY0Y0gfzzncNSImga6iY6Hvs
         zGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HNg21NrFFSzG03akl4ik4jz1Jh6GwsesirJ9uxFbwiU=;
        b=DNsSg9ZI2ATsOS98riY1P8vs6YADwU68uNLMMtNK9MbbAVpORASFZCNoIBBjcNHkrD
         WeMzIDxfuo51tKtCjQhYgmQ/ZetbOplMb9SfPKl927KWCul0xUe08bq9KzAT0bHzp/Wa
         3KXaWpfiy49XQyBIv8gU/0C5Y5LPlasrxWZSWGYJILJrPUKD4jhURY4a/lcMfopIwcVh
         GG0acMoKPhdE3DABOfgXw8PkaB+wizNmbbtpLBaXYsYvZRJZ9VdCQlQ8YOBEhQFmKOfG
         PT7IOsfx+vYAeWmOTd90lUxH20JU4D5OiGAxzjaR51/vwHoymB64zwr2KM0cuv0d/fCe
         s5ng==
X-Gm-Message-State: AOAM530cBbnQqPVmROSg6J3Kfp+rhHmwaBoXYC8Q6gsXmQjuAnau6zUT
        ET3B2dxOpGHBWRuzw2ND2MJprg==
X-Google-Smtp-Source: ABdhPJzJy+BLK7QYhJw1l12NeERtA6m/kc2WzhAzLxQEKBKKAcv85+3becrDuG5cYXWTx+aCViGE3g==
X-Received: by 2002:adf:8151:: with SMTP id 75mr3926866wrm.152.1614191431901;
        Wed, 24 Feb 2021 10:30:31 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-157-252.adsl.proxad.net. [82.252.157.252])
        by smtp.gmail.com with ESMTPSA id c12sm5105987wru.71.2021.02.24.10.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 10:30:31 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 1/2] powercap/drivers/dtpm: Fix root node initialization
Date:   Wed, 24 Feb 2021 19:30:21 +0100
Message-Id: <20210224183022.11846-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The root node is not set to NULL when the dtpm root node is
removed. Consequently, it is not possible to create a new root as it
is already set.

Set the root node to NULL when the last node is removed.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index 5a51cd34a7e8..c2185ec5f887 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -207,6 +207,9 @@ int dtpm_release_zone(struct powercap_zone *pcz)
 	if (dtpm->ops)
 		dtpm->ops->release(dtpm);
 
+	if (root == dtpm)
+		root = NULL;
+
 	kfree(dtpm);
 
 	return 0;
-- 
2.17.1

