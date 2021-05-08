Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29253377031
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 08:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhEHG4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 02:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhEHG4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 02:56:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3948BC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 23:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=bBKZ1WN909KkRnPJdDDH6FvaFvB9P+aBMkPLcohry6o=; b=juUy8eBDTt/P8+x5q3hcG69qNE
        0eZUw+189+AmLqD2gpmQprp/RRekolmg33KKDPGPvGxLZZXMFXr6NeDGGl/7KuCU0Jy6RuOm+7vZQ
        Ry8FUYAsgIEiAMZfSmwQrZknHibdGcXgvY1CYRwvGbAcNXwSgx6YppxXsYq7FALebLUX0YQuo0HSd
        Im466Ehe67iqVWOnN0poOaBICiYh2lxv6Kg4o6Pd4nirgz9E84+FcqxCI9TcmHhJ0Q2ju2bzizcXy
        /MLCqWK/85T3EHIu4yRoRxm08ptxXI4Yxg4lruoqspAp4r8Eer0AmDEZqoI3vJECL0DFHF2SX0vby
        UNGv3/sw==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lfGsN-007PSU-2O; Sat, 08 May 2021 06:55:48 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2] platform_data: cros_ec_commands.h: drop a duplicated word
Date:   Fri,  7 May 2021 23:55:46 -0700
Message-Id: <20210508065546.22169-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "using" in a comment (change to "using the").

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tzung-Bi Shih <tzungbi@google.com>
Cc: Mark Brown <broonie@kernel.org>
---
v2: change to "using the" instead of just dropping one "using"

 include/linux/platform_data/cros_ec_commands.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210507.orig/include/linux/platform_data/cros_ec_commands.h
+++ linux-next-20210507/include/linux/platform_data/cros_ec_commands.h
@@ -783,7 +783,7 @@ struct ec_host_response {
  *
  * Packets always start with a request or response header.  They are followed
  * by data_len bytes of data.  If the data_crc_present flag is set, the data
- * bytes are followed by a CRC-8 of that data, using using x^8 + x^2 + x + 1
+ * bytes are followed by a CRC-8 of that data, using the x^8 + x^2 + x + 1
  * polynomial.
  *
  * Host algorithm when sending a request q:
