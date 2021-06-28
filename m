Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F303B570C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 03:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhF1B4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 21:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhF1B4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 21:56:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C13AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 18:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=oeHRyuymoOzE5/i9iWqenF4pTcyyyYMUWbRGL1RrOWM=; b=yg8bM7alBKZlmJDT34I1GTkUAk
        oFfVy+mxx1QlvFD9juk8XWWMOL/1TX7XTygCOkSBGXQC8/U9YQe+Qm7/1Ao6/sFDJFq8fm8L7wXjC
        9+/Y/XPidjfUKeCx1HCwaHbN7JS2Dd9hlkvlCDcN0iOn7ppcf979XI0nguu+BQ3SpbUouMB0REDtp
        NeHcrQJkrsNjBRvycze3bEoNA0kXYZQggf5av9tmdWQWhar3CJCKcTkPuOPnuhlT5/QtI0Bzx7Bdf
        2BlwkHLJTXaAjc6bbi1uyypL8KHImA+TgxqaB9cXLSLaohxvVfsYnFzLr1w5w6aU2yvSEhs299kBc
        N8omSwwQ==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxgTe-006WNv-QC; Mon, 28 Jun 2021 01:54:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH -next] regulator: machine.h: fix kernel-doc "bad line"
Date:   Sun, 27 Jun 2021 18:54:22 -0700
Message-Id: <20210628015422.8845-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning caused by a blank/empty line:

../include/linux/regulator/machine.h:115: warning: bad line: 

Fixes: 89a6a5e56c82 ("regulator: add property parsing and callbacks to set protection limits")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Mark Brown <broonie@kernel.org>
---
 include/linux/regulator/machine.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210625.orig/include/linux/regulator/machine.h
+++ linux-next-20210625/include/linux/regulator/machine.h
@@ -112,7 +112,7 @@ struct notification_limit {
  * @over_voltage_limits:	Limits for acting on over voltage.
  * @under_voltage_limits:	Limits for acting on under voltage.
  * @temp_limits:		Limits for acting on over temperature.
-
+ *
  * @max_spread: Max possible spread between coupled regulators
  * @max_uV_step: Max possible step change in voltage
  * @valid_modes_mask: Mask of modes which may be configured by consumers.
