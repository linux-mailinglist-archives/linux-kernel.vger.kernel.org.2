Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046613E1BE5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242037AbhHES66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:58:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241727AbhHES65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:58:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 750F460F42;
        Thu,  5 Aug 2021 18:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628189923;
        bh=gOZlffGUr2e48j1pwi3Riunv2adJDJXK/fbCwjsuipw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ao+LtVb+/IULGN8TUo13q3iLIOHKMAE//59ktRtaCajNQWxM2uhVFiYi8M3+8FqgP
         Zar2gQhxICw3Tcr15tpTiB2xCyvCS5o4hT9yUCTXCTIMbFOnKYSb022f/F+gu0ALuK
         M7kHQukc6uf5gn0qUb/dfvs5FGNuZzcwbFb2zjraqgraZi6CE8NDa6QNoIw+kzNxsE
         6sYXb13OM3Nshrd2snNCAB0UV4KYNetmfyAfIyX8OSwK3OtNczXhG+CDDzvFHCBcPm
         wdFP3gLliauHm0wvcrVRrxUVa9cOBTSyIr4Y+vIR2ItC5J/Bf/LgQoII6zQzk30Vau
         6y2XSY8ghhYjA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 2/3] staging: r8188eu: Remove self assignment in get_rx_power_val_by_reg()
Date:   Thu,  5 Aug 2021 11:58:06 -0700
Message-Id: <20210805185807.3296077-3-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.rc0
In-Reply-To: <20210805185807.3296077-1-nathan@kernel.org>
References: <20210803223609.1627280-1-nathan@kernel.org>
 <20210805185807.3296077-1-nathan@kernel.org>
MIME-Version: 1.0
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
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
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

