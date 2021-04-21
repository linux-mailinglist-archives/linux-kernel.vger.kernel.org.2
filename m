Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA512366C63
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242822AbhDUNQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:16:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242278AbhDUNKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:10:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6978661456;
        Wed, 21 Apr 2021 13:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010567;
        bh=EmGsPNsRskw4dFK64O5hGqzo5olILsfiaS/ti4KQGpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EcF8VhNS4yk2KoBc94tlSQ68hwTmmLrm3xVByPm7WQK+05EL4g31N25HepjzgDb8v
         J3d8J9Jwd2C3HgRL950XkjtGyN7Rav1R+CLFBFTCkgaW0p8Ua0JhTV4qTg7kpv4imc
         N5YrmOPDEMARFOWh43W8SBcDtGdT64CMwh55hWEo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 147/190] Revert "media: dvb: add return value check on Write16"
Date:   Wed, 21 Apr 2021 15:00:22 +0200
Message-Id: <20210421130105.1226686-148-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 0f787c12ee7b2b41a74594ed158a0112736f4e4e.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Aditya Pakki <pakki001@umn.edu>
Cc: Sean Young <sean@mess.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-frontends/drxd_hard.c | 30 +++++++++----------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/media/dvb-frontends/drxd_hard.c b/drivers/media/dvb-frontends/drxd_hard.c
index a7eb81df88c2..3e3de6badc86 100644
--- a/drivers/media/dvb-frontends/drxd_hard.c
+++ b/drivers/media/dvb-frontends/drxd_hard.c
@@ -1132,8 +1132,6 @@ static int EnableAndResetMB(struct drxd_state *state)
 
 static int InitCC(struct drxd_state *state)
 {
-	int status = 0;
-
 	if (state->osc_clock_freq == 0 ||
 	    state->osc_clock_freq > 20000 ||
 	    (state->osc_clock_freq % 4000) != 0) {
@@ -1141,17 +1139,14 @@ static int InitCC(struct drxd_state *state)
 		return -1;
 	}
 
-	status |= Write16(state, CC_REG_OSC_MODE__A, CC_REG_OSC_MODE_M20, 0);
-	status |= Write16(state, CC_REG_PLL_MODE__A,
-				CC_REG_PLL_MODE_BYPASS_PLL |
-				CC_REG_PLL_MODE_PUMP_CUR_12, 0);
-	status |= Write16(state, CC_REG_REF_DIVIDE__A,
-				state->osc_clock_freq / 4000, 0);
-	status |= Write16(state, CC_REG_PWD_MODE__A, CC_REG_PWD_MODE_DOWN_PLL,
-				0);
-	status |= Write16(state, CC_REG_UPDATE__A, CC_REG_UPDATE_KEY, 0);
+	Write16(state, CC_REG_OSC_MODE__A, CC_REG_OSC_MODE_M20, 0);
+	Write16(state, CC_REG_PLL_MODE__A, CC_REG_PLL_MODE_BYPASS_PLL |
+		CC_REG_PLL_MODE_PUMP_CUR_12, 0);
+	Write16(state, CC_REG_REF_DIVIDE__A, state->osc_clock_freq / 4000, 0);
+	Write16(state, CC_REG_PWD_MODE__A, CC_REG_PWD_MODE_DOWN_PLL, 0);
+	Write16(state, CC_REG_UPDATE__A, CC_REG_UPDATE_KEY, 0);
 
-	return status;
+	return 0;
 }
 
 static int ResetECOD(struct drxd_state *state)
@@ -1305,10 +1300,7 @@ static int SC_SendCommand(struct drxd_state *state, u16 cmd)
 	int status = 0, ret;
 	u16 errCode;
 
-	status = Write16(state, SC_RA_RAM_CMD__A, cmd, 0);
-	if (status < 0)
-		return status;
-
+	Write16(state, SC_RA_RAM_CMD__A, cmd, 0);
 	SC_WaitForReady(state);
 
 	ret = Read16(state, SC_RA_RAM_CMD_ADDR__A, &errCode, 0);
@@ -1335,9 +1327,9 @@ static int SC_ProcStartCommand(struct drxd_state *state,
 			break;
 		}
 		SC_WaitForReady(state);
-		status |= Write16(state, SC_RA_RAM_CMD_ADDR__A, subCmd, 0);
-		status |= Write16(state, SC_RA_RAM_PARAM1__A, param1, 0);
-		status |= Write16(state, SC_RA_RAM_PARAM0__A, param0, 0);
+		Write16(state, SC_RA_RAM_CMD_ADDR__A, subCmd, 0);
+		Write16(state, SC_RA_RAM_PARAM1__A, param1, 0);
+		Write16(state, SC_RA_RAM_PARAM0__A, param0, 0);
 
 		SC_SendCommand(state, SC_RA_RAM_CMD_PROC_START);
 	} while (0);
-- 
2.31.1

