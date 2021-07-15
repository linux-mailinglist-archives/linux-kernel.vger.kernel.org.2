Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D093CA8EF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 21:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243689AbhGOTEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 15:04:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240890AbhGOSzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 14:55:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49D97610C7;
        Thu, 15 Jul 2021 18:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626375155;
        bh=bQ6o2NIi3EfTjmaHCOFG+RzRJtr0dJpoXEu17KBfHcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aUjQ9BUtVm3+QdCfDzVi4wsg6NqV4DrhEoekwjgXaXb+WNXMQomPEq28Ny/nIP8GP
         /SktuF9TCsH2IoGIhdGMzPtgkCyiJep1ikgAj3g+LDa9F2Y1zCVP8g8m0o1gLYcdGn
         swwgXnaeLl0g5j2eh2sWsRnGCpiS/RZ6LinUjN/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 5.10 182/215] power: supply: ab8500: Fix an old bug
Date:   Thu, 15 Jul 2021 20:39:14 +0200
Message-Id: <20210715182631.491366860@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210715182558.381078833@linuxfoundation.org>
References: <20210715182558.381078833@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

commit f1c74a6c07e76fcb31a4bcc1f437c4361a2674ce upstream.

Trying to get the AB8500 charging driver working I ran into a bit
of bitrot: we haven't used the driver for a while so errors in
refactorings won't be noticed.

This one is pretty self evident: use argument to the macro or we
end up with a random pointer to something else.

Cc: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marcus Cooper <codekipper@gmail.com>
Fixes: 297d716f6260 ("power_supply: Change ownership from driver to core")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mfd/abx500/ux500_chargalg.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/mfd/abx500/ux500_chargalg.h
+++ b/include/linux/mfd/abx500/ux500_chargalg.h
@@ -15,7 +15,7 @@
  * - POWER_SUPPLY_TYPE_USB,
  * because only them store as drv_data pointer to struct ux500_charger.
  */
-#define psy_to_ux500_charger(x) power_supply_get_drvdata(psy)
+#define psy_to_ux500_charger(x) power_supply_get_drvdata(x)
 
 /* Forward declaration */
 struct ux500_charger;


