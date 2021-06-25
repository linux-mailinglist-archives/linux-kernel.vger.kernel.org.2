Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455513B3DEA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFYHsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:48:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229671AbhFYHsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:48:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47E0B6141C;
        Fri, 25 Jun 2021 07:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624607172;
        bh=Z7clAz4iJbT7z/W2XZ8uk8GPACguI/8XqnWeaDjkd20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BOaCEIUhTwM2+Lziv8DUdSFhpR7ALklZi2bzr3rMdDSGdAvUBzs79yv2PsR+kwJuh
         KXkKZymHpUZ1rHY4zpupbKTIYX95R8W1nElf5GVECe17LbrSHjNC66wX+aix9a546c
         0gTaxWGjVvZVS8BhyUlm1uWgTSTO9yNnGunqEDjRHwxYv6zHM5XCz+KABH0IQfyYFZ
         7zftaEp3SX6j1gbU06YNbrPqFNSjeDhF7vqKr90bq+E2p8VJ6+9Oy5b21VjQLdVX9C
         ihh8SSOQJ8KzlpAIrAmKZOm9ICVM3WQH1UddRPGX5LTD5SnHvPn4z9CST6H7dnnNYO
         QN3fZgzLa4vdw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lwgXS-004aeU-Gh; Fri, 25 Jun 2021 09:46:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Lee Jones" <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v8 07/12] staging: hi6421-spmi-pmic: change a return code
Date:   Fri, 25 Jun 2021 09:45:59 +0200
Message-Id: <e978eabd99c0d3c471026659a2c585deb706e2c4.1624606660.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624606660.git.mchehab+huawei@kernel.org>
References: <cover.1624606660.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

return -ENODEV if irq_create_mapping() fails at probing
time.

Suggested-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index be049a5abbcd..3f4bfeaaf05e 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -245,7 +245,7 @@ static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
 		virq = irq_create_mapping(ddata->domain, i);
 		if (!virq) {
 			dev_err(dev, "Failed to map H/W IRQ\n");
-			return -ENOSPC;
+			return -ENODEV;
 		}
 		ddata->irqs[i] = virq;
 	}
-- 
2.31.1

