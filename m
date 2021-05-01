Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780D337089F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 21:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhEATA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 15:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhEATA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 15:00:56 -0400
X-Greylist: delayed 338 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 01 May 2021 12:00:05 PDT
Received: from magratgarlick.emantor.de (magratgarlick.emantor.de [IPv6:2a01:4f8:c17:c88::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD685C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 12:00:05 -0700 (PDT)
Received: by magratgarlick.emantor.de (Postfix, from userid 114)
        id B75E1120F49; Sat,  1 May 2021 20:54:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=czerwinskis.de;
        s=mail; t=1619895262;
        bh=e7rCh90rZZgFeh4gn5fNCjabN3K7lSFpJBuAcnBXwxE=;
        h=From:To:Cc:Subject:Date:From;
        b=KIVVP/W6wqAA5f8nu7lQkSKx6ZXZ9tvXJuwaoXSy4KX/vkcrDBVu8rpMl1fbru8yb
         +Xb+epNkUcVUIHLrXswg4/bMX7VHwMudvv6h0fE3zJ83UsVRQPuYdJhkKtfR8DQcrm
         3K9nBuhkYTFV0Wv05QlTkIg0eoaY2PiGHpniefgU=
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        magratgarlick.emantor.de
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from localhost (unknown [IPv6:2001:9e8:7b:7102:c0d3:dbff:fefe:ff70])
        by magratgarlick.emantor.de (Postfix) with ESMTPSA id 659FE120F46;
        Sat,  1 May 2021 20:54:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=czerwinskis.de;
        s=mail; t=1619895259;
        bh=e7rCh90rZZgFeh4gn5fNCjabN3K7lSFpJBuAcnBXwxE=;
        h=From:To:Cc:Subject:Date:From;
        b=WZX3eEW73571WxDiJLWDZwCw+fe11/NmWMmXfwLv637dJ0LIidE67rvc/+2kvnNQ4
         r6+XugjIlilc9TlY482wJbvxcHuKhOZg3ykgDu8nFv0/+tf+I+0lp+9Y5StMuHwmLw
         LtB+GeTpFq0amdzteJD5HuBepmIpzQG4+gUy4MKM=
From:   Rouven Czerwinski <rouven@czerwinskis.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     kernel@pengutronix.de, Rouven Czerwinski <rouven@czerwinskis.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: remove unused handle_exception symbol
Date:   Sat,  1 May 2021 20:53:58 +0200
Message-Id: <20210501185359.64043-1-rouven@czerwinskis.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 79b1feba5455 ("RISC-V: Setup exception vector early")
exception vectors are setup early and the handle_exception symbol from
the asm files is no longer referenced in traps.c. Remove it.

Signed-off-by: Rouven Czerwinski <rouven@czerwinskis.de>
---
 arch/riscv/kernel/traps.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 1357abf79570..6810fc9c775d 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -25,8 +25,6 @@
 
 int show_unhandled_signals = 1;
 
-extern asmlinkage void handle_exception(void);
-
 static DEFINE_SPINLOCK(die_lock);
 
 void die(struct pt_regs *regs, const char *str)
-- 
2.31.1

