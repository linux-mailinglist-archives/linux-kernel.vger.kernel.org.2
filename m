Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2E642C3C7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbhJMOqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:46:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233744AbhJMOqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:46:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0233961175;
        Wed, 13 Oct 2021 14:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634136247;
        bh=PaK8b/iVZhhp63CVJWb182OaH/dJzGPnyoxduqo2dTg=;
        h=From:To:Cc:Subject:Date:From;
        b=RhvKs5mANZF7aEX8Lsxz/CNKKgdcn53ujFBbN/Mg3jQ5EfqDYUV2akY9LuJB3B0AK
         Ve3jlJZaM28/e8FpwkPU8HoR1gYZRE+v/L7Dk2CKhRzlfsauUtLFH07ZOEk2bgHBNK
         rsIc2t2+pokbpTt0L9Gk/bFskln02sR/9nR5ef6Gsb6/j1eomSTMvrLxLiDpi3tbi1
         sucQFjJn7gr8kCYNCYmmA5hPupEqHY3G5XO+/TTeWoW1M0Grf9fCf3HBtVPkTfAk/p
         4zYelashnljwRu9wSFC8ekvbK1EBEYxzGEAbPfAsrLL5FjdKzUDRbE/zNZF1az7WRP
         +LeoD/urBBBfA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thor Thayer <thor.thayer@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: altera-a10sr: include linux/module.h
Date:   Wed, 13 Oct 2021 16:43:55 +0200
Message-Id: <20211013144402.2292128-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Without the header, the MODULE_DEVICE_TABLE() declaration fails:

drivers/mfd/altera-a10sr.c:153:1: error: data definition has no type or storage class [-Werror]
  153 | MODULE_DEVICE_TABLE(of, altr_a10sr_spi_of_match);

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/altera-a10sr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/altera-a10sr.c b/drivers/mfd/altera-a10sr.c
index 6d04fdd09ca2..34ef526f4aee 100644
--- a/drivers/mfd/altera-a10sr.c
+++ b/drivers/mfd/altera-a10sr.c
@@ -14,6 +14,7 @@
 #include <linux/mfd/altera-a10sr.h>
 #include <linux/mfd/core.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/spi/spi.h>
 
-- 
2.29.2

