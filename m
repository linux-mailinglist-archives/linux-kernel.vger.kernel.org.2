Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E843B9D0A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 09:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhGBHkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 03:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230108AbhGBHkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 03:40:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D395B6141D;
        Fri,  2 Jul 2021 07:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625211449;
        bh=vC56OD9+LGae3ybVwsqwlfuMPddvxoGwX69Inb95DCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sI8+mSXQLC2F573cau8Q3fgyQ36yGxv9ogneAjY5NBeF/3KxaAVC/QRq5uYk1Tqv6
         qlBkCSfsU93EF7N4MlGc42VkuMweDXi0TUmzbshZ16idUffRkPft3/PVKVkYaRTvki
         E5BHHKOl33DKHoobmpRSpLrRZrzwd1IZ74Cm0Q6DtJnZncGfVWlHcQUyeuamosK8gT
         IcY+yof7d2EVfV9mN0pnrlferoE0cP+ZA5e38R/1vl5IiqLLnj/4SCjYmCNG/9YdzT
         SrKydlgjO0JQSbo00FV0g7cZ+pPm3HncYjrM+1KjcD025N6b6Gd8mD2wO6ppJ6ERsh
         yAjFdppjBJ5Vg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lzDjo-000gZj-Ne; Fri, 02 Jul 2021 09:37:24 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Axel Lin" <axel.lin@ingics.com>,
        "Lee Jones" <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v11 1/8] staging: hi6421-spmi-pmic:  add a missing dot at copyright
Date:   Fri,  2 Jul 2021 09:37:16 +0200
Message-Id: <48016aa84165e396468f587a8fae657b01704b65.1625211021.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625211021.git.mchehab+huawei@kernel.org>
References: <cover.1625211021.git.mchehab+huawei@kernel.org>
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
index 35ef3d4c760b..9b3c13186709 100644
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

