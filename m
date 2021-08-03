Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0483DF7FE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 00:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbhHCWhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 18:37:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233796AbhHCWhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 18:37:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B829E60EBB;
        Tue,  3 Aug 2021 22:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628030214;
        bh=XqGUnp6HhB5XCqxFjh9U8lbifuggEtKCWvOnpHJsWdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kxfn2O7iui9wxfFfavOHOI5qLm89L9mVA0HpEfcbq0NKuEm0ri8MLAXMnu/KlhZwb
         ZSwlQ7gSykW56NnN1U/4I1KPiGPstQVy1/ak0BzSlm9WV7PsnOltncJLLBYT7POufu
         hkoCPaesSuGQqAd1aPuB5dMq3sC8MF23w5IOI0o0Kyaso0jbzGNRg334BSKi5RvNPI
         4F/1wt4S7dm9rcd0Ol+G/UK2k+uVtM/vXimcIkzsvfMHBffinQEYwDXALHDwU97o8o
         zImJtHBE0vTQM9pL3u6wjmGDy4uTGMn6Sb0Btk5gg45eTkdpDQJbv16M1hKirdcs6I
         srEg09bU6YyhQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 3/4] staging: r8188eu: Remove self assignment in get_rx_power_val_by_reg()
Date:   Tue,  3 Aug 2021 15:36:08 -0700
Message-Id: <20210803223609.1627280-4-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.rc0
In-Reply-To: <20210803223609.1627280-1-nathan@kernel.org>
References: <20210803223609.1627280-1-nathan@kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/staging/r8188eu/hal/rtl8188e_rf6052.c:344:13: warning:
explicitly assigning value of variable of type 'u32' (aka 'unsigned
int') to itself [-Wself-assign]
                        writeVal = writeVal;
                        ~~~~~~~~ ^ ~~~~~~~~
1 warning generated.

Remove this branch as it is useless.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index 335b120ce603..77889dc05858 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -340,8 +340,6 @@ static void get_rx_power_val_by_reg(struct adapter *Adapter, u8 Channel,
 		/*  This mechanism is only applied when Driver-Highpower-Mechanism is OFF. */
 		if (pdmpriv->DynamicTxHighPowerLvl == TxHighPwrLevel_BT1)
 			writeVal = writeVal - 0x06060606;
-		else if (pdmpriv->DynamicTxHighPowerLvl == TxHighPwrLevel_BT2)
-			writeVal = writeVal;
 		*(pOutWriteVal+rf) = writeVal;
 	}
 }
-- 
2.33.0.rc0

