Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8615734474B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhCVOc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhCVOc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:32:27 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0A8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:32:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r12so21647801ejr.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8GZqqzXcPg3L3CgG7FuoqmOVUMjqsIVs1/BV+o/Qvck=;
        b=AeqP5Yd5RBdhxqWl0EV+LzgwtmZsQu1cz50n6Ypo4QEDEcLVbXdf/QgY4SQPKnOhNQ
         Dv3Aa4Xs0I8+FplXTyBuS/IXJ5ZegXQW3TGQJmslg14yJmDceksggVvRZHN/GszlYjD0
         AR/FQdZeN6ZLcSMgtws3GMVY0qpoUj4CiqfTWqDSLR4ocOjfGdTjKQsyQQ/PRxOv8tca
         RGMmWyBMVNRzyECy3NjDeroJQFlKvJ+ZIQ54s14LCcaDYGHV1yXEXsX76BHWqBwTbjpg
         /H5L8Fvu7rLZYSO3d0tzTuXYXCFXNb2vnf+VataobO9EowaYRt4v5g5zmUVI7OM/nwDe
         aBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8GZqqzXcPg3L3CgG7FuoqmOVUMjqsIVs1/BV+o/Qvck=;
        b=Zc3DCWbk/9Khl1JcQyBCYKxfIJKuWNuSv0Jc8WsChdiSgSltXec71Mn9mndhB6RkhK
         lEqRN24cybg79+wbPYpal/s69m3V/r8VWQGZ4Q7gyBfjMF26LMXDiavn5J+QxIZnR/az
         Gpo8Vj0dzgXjx+Q/g+3x/d7B2xyijTZmQzKqC+KNw8mxajeyIX3gKfj3hEHmCvTsFsEz
         O7exB3yKdajwwud4dyGEnQJwSf36txoRBYR4viLDDIW1n8SNpfQAkKZil/GAHx/gN0ek
         oM/RWrwHBT1p0aTx4cwvOnEVm1USggM7s1YMkryr4DtLsFbyxia4QdFs3PUG1yqpdiC9
         iA7w==
X-Gm-Message-State: AOAM533/4T96AeG7vBE52BOTYzKvkkcXGfcrhMI/sFAbKw+fkDRgKA88
        wHOZGM1QR3YZitr0L6VKloE=
X-Google-Smtp-Source: ABdhPJxECZtWl29aG8aEIRw0IcVueeekaMMQB0xv4Xwc9HWGrw1ISHiMb3LUdEB+jF2xpsB2e5UMbg==
X-Received: by 2002:a17:906:7150:: with SMTP id z16mr17667ejj.103.1616423545331;
        Mon, 22 Mar 2021 07:32:25 -0700 (PDT)
Received: from agape ([151.57.176.11])
        by smtp.gmail.com with ESMTPSA id f9sm11534700eds.41.2021.03.22.07.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:32:25 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 06/11] staging: rtl8723bs: move function prototype out of core/rtw_recv.c
Date:   Mon, 22 Mar 2021 15:31:44 +0100
Message-Id: <570305618da6d5560b97ce06d585d70f4906b4e2.1616422773.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616422773.git.fabioaiuto83@gmail.com>
References: <cover.1616422773.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move function prototype in include/rtw_recv.h

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c    | 1 -
 drivers/staging/rtl8723bs/include/rtw_recv.h | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index e2a6afed723c..99dede774b7a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -1983,7 +1983,6 @@ int enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl, union rec
 
 }
 
-u64 recv_indicatepkts_pkt_loss_cnt(u64 prev_seq, u64 current_seq);
 u64 recv_indicatepkts_pkt_loss_cnt(u64 prev_seq, u64 current_seq)
 {
 	if (current_seq < prev_seq)
diff --git a/drivers/staging/rtl8723bs/include/rtw_recv.h b/drivers/staging/rtl8723bs/include/rtw_recv.h
index 248e098726fd..1dca18040b98 100644
--- a/drivers/staging/rtl8723bs/include/rtw_recv.h
+++ b/drivers/staging/rtl8723bs/include/rtw_recv.h
@@ -553,6 +553,8 @@ int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_num);
 
 int enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl, union recv_frame *prframe);
 
+u64 recv_indicatepkts_pkt_loss_cnt(u64 prev_seq, u64 current_seq);
+
 int recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reorder_ctrl *preorder_ctrl,
 			       int bforced);
 
-- 
2.20.1

