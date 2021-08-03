Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7989F3DE8F7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbhHCIxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:53:50 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:60106
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234801AbhHCIxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:53:49 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 68F453F078;
        Tue,  3 Aug 2021 08:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627980812;
        bh=8XxfmR52YWgm9mlm2XB+jFuLFwmXc/j21UUJtwcYb5A=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=kkOI1EiHEngqBSL+lPXYooVbQ6r7B5/FluVZc9PS21LcswL+0P5JpBKLZLc6mRaCN
         11flYL19nNhlSYFbtSUKPe5c6/rqLLw2wYAzLP0e0yWHZhbA9qLmXSk7P70FPs3Txq
         sVTGVxz/1GhLXeiDrCIYabp4hRzF4Y1LUPIRC1TmbApvS+OhK8XAW4z1uva6eXP+as
         FAbe25mRfWYoti8StBGvSbfhfR1NwaZiYK5ky9YyDuJp0BPUfHHkxlyvBse+ocC3xj
         bgZMN2/s3m/QoT1UJAaUxBKpyG5r7n1J8mAmvkapVjMF9/DtB/NLxd1HXV1mr+Dp9l
         z80p8Ln3YcNsg==
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: r8188eu: Fix spelling mistake "Cancle" -> "Cancel"
Date:   Tue,  3 Aug 2021 09:53:31 +0100
Message-Id: <20210803085331.320859-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in a RT_TRACE message and a comment. Fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index a6d62074289f..a2c1e03e874f 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1243,11 +1243,10 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 					RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("adhoc mode, fw_state:%x", get_fwstate(pmlmepriv)));
 				}
 
-			/* s5. Cancle assoc_timer */
+			/* s5. Cancel assoc_timer */
 			_cancel_timer(&pmlmepriv->assoc_timer, &timer_cancelled);
 
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("Cancle assoc_timer\n"));
-
+			RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("cancel assoc_timer\n"));
 		} else {
 			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_joinbss_event_callback err: fw_state:%x", get_fwstate(pmlmepriv)));
 			spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
-- 
2.31.1

