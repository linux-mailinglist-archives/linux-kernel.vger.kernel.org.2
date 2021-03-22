Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A898344746
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhCVOdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhCVOcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:32:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD0DC061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:32:23 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u21so3677309ejo.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vl2FsywndoDnCnLH3CW1FLc/KJ2b1bAQO/tsFwQMyPo=;
        b=axF+ER92RNJmNtZBC+An9lXZbIXMIiHZhz8Ro6Ngm8Gi8OpYxlN8UJMiR2WAdF5PoT
         JGZxpwrywx02tEwbFabSoFLWUORZ04uiqhWCjX//HVc84sp2XlRjsOAteY724etntnlJ
         THu8JQ9k4dTIZ65ruxylB0+fZ7dJYnBc+ASjmts81p7ii6YdogQE+EPo75YBtEwllFky
         uTXd6pHyrHJeUIjH2OjfRtxV8w6IYXsu5rPa15FKBo7PkOTvS4+0UkHxlh42oOi6RQ5C
         cpRNRgU008Q0VPm6o5vZ2rRH37B57bgx0L7OOYjBLPod1MuglebwCD+bylaoKXDzGG49
         620A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vl2FsywndoDnCnLH3CW1FLc/KJ2b1bAQO/tsFwQMyPo=;
        b=VZrlOWkraDW0/x4ZEQEyDcdysHogE53Bi+NSTp2zkYmFMB5n+QTdyHlGa6aO3pOUVb
         Se0tz5HaPfLjoe2TiomD2K/VnqYBxQO9+3PmeggyYZEFqfLcauNrHcTWHrcbacwxVmyI
         e81WoHiT2SjXaCsJ7KjAa1aFEGQzNtgTevh/k1H5shoDW+qyIYB7zjzEW9Y1k2mX8vMC
         KlSQ+j7ftjdHPLzpls5Z3/1hdO7idy8qLtAvzDYnbXx74LplsYVDiP/AJKlPwz++G/1h
         xRs/dSpxEfmN2hbHDEPHkc9djL3a7L7f26+E7W70q4b3iGmH+GcJ880e+r2kXg6Enad3
         zC5Q==
X-Gm-Message-State: AOAM530LcxCCq5ykRmHtxbLzj2E2tpEUMNe3ueO+f1gNgaznkjv1cfzR
        J10kEbTV30PYVwl0pVB5XrQ=
X-Google-Smtp-Source: ABdhPJwyeFrrYH9ApBmKlRX9XQb2UiUm/ygyF8KOcpWcfpUiKs7yEjBDIIVE444K70c5UctR/J7Syg==
X-Received: by 2002:a17:906:8447:: with SMTP id e7mr20017497ejy.523.1616423542801;
        Mon, 22 Mar 2021 07:32:22 -0700 (PDT)
Received: from agape ([151.57.176.11])
        by smtp.gmail.com with ESMTPSA id l18sm9793114ejk.86.2021.03.22.07.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:32:22 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 05/11] staging: rtl8723bs: remove argument in recv_indicatepkts_pkt_loss_cnt
Date:   Mon, 22 Mar 2021 15:31:43 +0100
Message-Id: <fb3d6e0ae858738e3213b60d87e70c2f1697f051.1616422773.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616422773.git.fabioaiuto83@gmail.com>
References: <cover.1616422773.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug_priv argument so function prototype can be
easily moved away

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 9ef2408ded57..e2a6afed723c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -1983,13 +1983,13 @@ int enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl, union rec
 
 }
 
-void recv_indicatepkts_pkt_loss_cnt(struct debug_priv *pdbgpriv, u64 prev_seq, u64 current_seq);
-void recv_indicatepkts_pkt_loss_cnt(struct debug_priv *pdbgpriv, u64 prev_seq, u64 current_seq)
+u64 recv_indicatepkts_pkt_loss_cnt(u64 prev_seq, u64 current_seq);
+u64 recv_indicatepkts_pkt_loss_cnt(u64 prev_seq, u64 current_seq)
 {
 	if (current_seq < prev_seq)
-		pdbgpriv->dbg_rx_ampdu_loss_count += (4096 + current_seq - prev_seq);
+		return 4096 + current_seq - prev_seq;
 	else
-		pdbgpriv->dbg_rx_ampdu_loss_count += (current_seq - prev_seq);
+		return current_seq - prev_seq;
 
 }
 
@@ -2029,7 +2029,8 @@ int recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reorder_ctr
 		DBG_871X("DBG_RX_SEQ %s:%d IndicateSeq: %d, NewSeq: %d\n", __func__, __LINE__,
 			preorder_ctrl->indicate_seq, pattrib->seq_num);
 		#endif
-		recv_indicatepkts_pkt_loss_cnt(pdbgpriv, preorder_ctrl->indicate_seq, pattrib->seq_num);
+		pdbgpriv->dbg_rx_ampdu_loss_count += recv_indicatepkts_pkt_loss_cnt(
+				preorder_ctrl->indicate_seq, pattrib->seq_num);
 		preorder_ctrl->indicate_seq = pattrib->seq_num;
 
 	}
-- 
2.20.1

