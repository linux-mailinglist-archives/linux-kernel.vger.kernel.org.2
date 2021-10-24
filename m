Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A350A4389B5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 17:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhJXPPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 11:15:34 -0400
Received: from smtp-32-i2.italiaonline.it ([213.209.12.32]:49698 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230358AbhJXPPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 11:15:33 -0400
Received: from passgat-Modern-14-A10M.homenet.telecomitalia.it
 ([213.45.67.127])
        by smtp-32.iol.local with ESMTPA
        id eeyWmj6mkdfuoeeycmWXxK; Sun, 24 Oct 2021 16:59:59 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1635087599; bh=m3UvBZ8+qL36bLX0JtjawwQHEKdpycPeKZGKfj6CR8U=;
        h=From;
        b=PxWguzd95AwLruHslb1IXkXbO+9/u+Ujg5iMXObypQW0/V8OfJa1TPJNhT8225wm4
         9s/UmkdCmm4wNQGIXGCpvfyI50WyeY3EVLin7Kmwa1okTzsv3icPS0dUC6/C6L/zcU
         Uhy5Xv/0cSpjFnPIbSXL8epJt+GaRP9qo+OOFjTt+FSz0uY/fkcEzoDEHgtMrHm4JI
         WErZbJRZSkMeCj9HzK0eLQPWf83qwhGT/kj66Gs6MWPHyT0dr4vPGH6rvr81YSFzAU
         Ue8fcw3hbOVAp1tBL4fnZzGj63N2C1o8NMACBo+M+YM8ZNJEILUON1HJ1vmPlOfBPS
         V18XXhfWZXwGQ==
X-CNFS-Analysis: v=2.4 cv=IrzbzJzg c=1 sm=1 tr=0 ts=617574ef cx=a_exe
 a=Vk63IOK+/LoQucGDvce7tA==:117 a=Vk63IOK+/LoQucGDvce7tA==:17
 a=BhtjshvPcAAyVhBn9nwA:9
From:   Dario Binacchi <dariobin@libero.it>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dariobin@libero.it>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 6/6] mfd: ti_am335x_tscadc: drop the CNTRLREG_8WIRE macro
Date:   Sun, 24 Oct 2021 16:59:30 +0200
Message-Id: <20211024145931.1916-7-dariobin@libero.it>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211024145931.1916-1-dariobin@libero.it>
References: <20211024145931.1916-1-dariobin@libero.it>
X-CMAE-Envelope: MS4xfN13BdAho0Prp32B5vjdm/2O+lDvRU8CXJL116ndsYOOd3BPrD7y5dzyFFkNTgVDxEQCLRqf+OLggzW8idQybxkmEr8wmXm20HxJ8SUw6S76VnPl95hj
 NMzZCZiZdWGAjT0dBCykx+llUzEqPFAjUsK7scV4UQjjsCW9nvpKokNTwa8Ay7mNKaUcWyHL4Je6xOZ9oJmUhgsVx2oY7fUeoSiAdIkYt2VjNANjWRB2hQDZ
 4LND9ldt/O8PhwpY+Tpv3PKGnF4kudTC7j4cpDmpZi1euHeRMzbZsw+XxHvHgLhgiw1DIYZ+9WchtNP6JlF4tw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In TI's reference manual description for the `AFE_Pen_Ctrl' bit-field
of the TSC's CTRL register, there is no mention of 8-wire touchscreens.
Even commit f0933a60d190 ("mfd: ti_am335x_tscadc: Update logic in CTRL
register for 5-wire TS") says that the value of this bit-field must be
the same for 4-wire and 8-wire touchscreens. So let's remove the
CNTRLREG_8WIRE macro to avoid misunderstandings.

Signed-off-by: Dario Binacchi <dariobin@libero.it>

---

 include/linux/mfd/ti_am335x_tscadc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index ffc091b77633..155b2ab13bf8 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -126,7 +126,6 @@
 #define CNTRLREG_AFE_CTRL(val)	((val) << 5)
 #define CNTRLREG_4WIRE		CNTRLREG_AFE_CTRL(1)
 #define CNTRLREG_5WIRE		CNTRLREG_AFE_CTRL(2)
-#define CNTRLREG_8WIRE		CNTRLREG_AFE_CTRL(3)
 #define CNTRLREG_TSCENB		BIT(7)
 
 /* FIFO READ Register */
-- 
2.17.1

