Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6798E3CC254
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 11:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhGQKBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 06:01:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232871AbhGQKBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 06:01:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7EF1613E7;
        Sat, 17 Jul 2021 09:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626515903;
        bh=pCvPAQUvZF6DwFzjcFxZOIYV0jUdMVA/6gwY2ZgoD2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PuthTdT94cZqn0nENHPQkNJslyaDxr5mS7nqDvIxLvUY5uZyzzncPdvpI7041Hd3M
         cVX9oAcOm2/TgSS5ufXRv7LpbFpJdqYFs1Gy/pa94rzeDDmUG/2Q7wiXbhGCOMkKkv
         kFnSQ34iyxYMr1iHZYuG3pm6noQ9D5HhwtK4rpbWvjci1v6bP9gz5WX83LYHVv23p0
         CaAIZhmszmIBEEudAkZ9nvw5Uhc+Ve8GXWDN4gAkARtmZxN0PgHIfBp0U0exM7uWaV
         eXVL81UOZFswaxr4ZkhXGoQInjLm/tgHjS+Fnd/L/y9kVMmMOa5rIw/MsxjDARrYzC
         Vt/GugmYATI2w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m4h5R-0007K8-T3; Sat, 17 Jul 2021 11:58:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v14 3/9] staging: hi6421-spmi-pmic:  add a missing dot at copyright
Date:   Sat, 17 Jul 2021 11:58:14 +0200
Message-Id: <8e280ebe4e577e6c2d919346868f0d27f98ebd49.1626515862.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626515862.git.mchehab+huawei@kernel.org>
References: <cover.1626515862.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Huawei's copyright is missing a dot	at the end. Add	it,
in order to make it similar to the other two copyrights.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 61cbd2e62f68..0ffd8b7fecf5 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -4,7 +4,7 @@
  *
  * Copyright (c) 2013 Linaro Ltd.
  * Copyright (c) 2011 Hisilicon.
- * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd
+ * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd.
  */
 
 #include <linux/bitops.h>
-- 
2.31.1

