Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EEB3AF5B9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhFUS7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229887AbhFUS71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:59:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 328A660FD8;
        Mon, 21 Jun 2021 18:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624301833;
        bh=lrJ17/MH7b8ugVfwgmUtFvEv2k5HUdeVJM3WvbL5QVk=;
        h=From:To:Cc:Subject:Date:From;
        b=BHt813KOyCGvKpnDMnw6vkE4oYv7xjlVboBOPJqz8kM+XtcylgclvhdneW78VEavH
         w3vIuetjtB2wV2DLzRLyoZs85UPlYnj9XuuEBv6MR4RUPMs1R2ScEH/ai48XFG/ciC
         1dYzj8J/VVhOD3Oq7NZQjqKFdtL1AfkZg0W373ZG3aF4qwIKvYLnbpOHQ2ZuxKyGFW
         r5rmZQexTl/Q3ULa1miPPEqLaEE/wJ385jTh+/qleuPhbaBMB4XLp/0HR8W/McD6FF
         QQubcCOtnxfb44u40Wxj8CG8nRpskQJe8hgluFqZUWsbmYFqf9Z7wr4tu2OKmrAOfk
         1E1fwu2a51I5A==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>, Peng Fan <peng.fan@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] mailbox: imx: Avoid using val uninitialized in imx_mu_isr()
Date:   Mon, 21 Jun 2021 11:56:45 -0700
Message-Id: <20210621185645.2373845-1-nathan@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/mailbox/imx-mailbox.c:284:2: warning: variable 'val' is used
uninitialized whenever switch default is taken
[-Wsometimes-uninitialized]
        default:
        ^~~~~~~
drivers/mailbox/imx-mailbox.c:288:7: note: uninitialized use occurs here
        if (!val)
             ^~~
drivers/mailbox/imx-mailbox.c:263:9: note: initialize the variable 'val'
to silence this warning
        u32 val, ctrl;
               ^
                = 0
1 warning generated.

Prior to commit 91c8c1fbe498 ("mailbox: imx: add xSR/xCR register
array"), val was always initialized in imx_mu_isr() but now, it is not
initialized in the default case. Return IRQ_NONE like the statement
below does and add a message that there is an unhandled type for this
switch statement so that it can be updated.

Fixes: 91c8c1fbe498 ("mailbox: imx: add xSR/xCR register array")
Link: https://github.com/ClangBuiltLinux/linux/issues/1404
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/mailbox/imx-mailbox.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index bc51bd3c1999..0ce75c6b36b6 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -282,7 +282,9 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
 			(ctrl & IMX_MU_xCR_GIEn(priv->dcfg->type, cp->idx));
 		break;
 	default:
-		break;
+		dev_warn_ratelimited(priv->dev, "Unhandled channel type %d\n",
+				     cp->type);
+		return IRQ_NONE;
 	}
 
 	if (!val)

base-commit: 6393989e2a31914bdc50211ff350dade6c729ea7
-- 
2.32.0.93.g670b81a890

