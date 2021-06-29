Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1A23B7419
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 16:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbhF2OTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbhF2OTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:19:17 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BC1C061767
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 07:16:49 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u11so26469690oiv.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 07:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9vOTfIKKRoeshH3laf5NPh/ELv4U3+RKlX8LJi8SAoc=;
        b=pBdJnVKWFV/QAohqySZRcMAr9QXePrkOUB8EJs6KFlbqdqBp3ZNJz/m9ibibqlbFZc
         xSm1JZOuHySUDnEFr4+YjQ+F2M/LkoayOi5mMGWFyQiekVv3e/QFJgpAVp7kV5heQ8WE
         xjTzN3PWDIvbPDBpwtbttwsmOzIHb8hB68dA0LVGXO4swgp6f+skIKc33YF9W3Ghnrbk
         UnaP0MabjEbsZgD4D4bH8CFpb18wjPzhGKn+NppoJoRyu5mXa+pN9pH1Ayuq6m8VI14c
         5DLTJ/mr9bb0VhfgMxTlcGdXUKxKGGwbHVP6MDpCj0QD26Y7mTuw0nKRJkMuNobZseTP
         i5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9vOTfIKKRoeshH3laf5NPh/ELv4U3+RKlX8LJi8SAoc=;
        b=sjVBUo6Xa/3M6TI+LU+T4kL2gkimWTjhDCJH4fBUJyB3G7nJDU2+QjJfidSA5IQin8
         I3eUB+bQN/yXCd2N39jufnlZmJ6wLmut9xD2u2JiPUDZtVL5pblpF/Wsy10eXVOiJWyi
         kvnMlDMnnHI+PQvulG+0k7Ak+vLT/S7RL/1LqzwctCTaYR9b43ZJYLTvBoSxhLepoWh2
         BEh/4RoM1GMDwRlWmXMNSPYr0Ulgu5q+JeU0szLfn2NRpTE0oI4WJTKSUt953Kgz63Ce
         Xix4fsfFl8DZnp34PMtJIsPTVdbi3HS1j0ehH9DW1ExBdwAX+dovXqhFElXh4oDPzXR+
         yzjQ==
X-Gm-Message-State: AOAM533opx7cnLafM0SFZ00j+1E2GsAheuvsuJC4hUbDbQLDcmZOt21/
        GYKByvGKiFVEU9P4VN501vM=
X-Google-Smtp-Source: ABdhPJzJuMQtZ3VmJpYY4fS3uLq1lP/t+UR+IP4G6G+hBbs9w4whKvXgMcR0y0x5PPynLEYJ++aAqQ==
X-Received: by 2002:aca:4716:: with SMTP id u22mr6969176oia.65.1624976208506;
        Tue, 29 Jun 2021 07:16:48 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-aaa9-75eb-6e0f-9f85.res6.spectrum.com. [2603:8081:140c:1a00:aaa9:75eb:6e0f:9f85])
        by smtp.gmail.com with ESMTPSA id k84sm3858590oia.8.2021.06.29.07.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 07:16:48 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-kernel@vger.kernel.org,
        leon@kernel.org, galpress@amazon.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH resending 1/2] Update kernel headers
Date:   Tue, 29 Jun 2021 09:16:42 -0500
Message-Id: <20210629141643.14763-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210629141643.14763-1-rpearsonhpe@gmail.com>
References: <20210629141643.14763-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To commit ?? ("RDMA/rxe: Convert kernel UD post send to use ah_num").

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 kernel-headers/rdma/rdma_user_rxe.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel-headers/rdma/rdma_user_rxe.h b/kernel-headers/rdma/rdma_user_rxe.h
index e283c222..e544832e 100644
--- a/kernel-headers/rdma/rdma_user_rxe.h
+++ b/kernel-headers/rdma/rdma_user_rxe.h
@@ -98,6 +98,8 @@ struct rxe_send_wr {
 			__u32	remote_qpn;
 			__u32	remote_qkey;
 			__u16	pkey_index;
+			__u16	reserved;
+			__u32	ah_num;
 		} ud;
 		struct {
 			__aligned_u64	addr;
@@ -148,7 +150,12 @@ struct rxe_dma_info {
 
 struct rxe_send_wqe {
 	struct rxe_send_wr	wr;
-	struct rxe_av		av;
+	union {
+		struct rxe_av av;
+		struct {
+			__u32		reserved[0];
+		} ex;
+	};
 	__u32			status;
 	__u32			state;
 	__aligned_u64		iova;
@@ -168,6 +175,11 @@ struct rxe_recv_wqe {
 	struct rxe_dma_info	dma;
 };
 
+struct rxe_create_ah_resp {
+	__u32 ah_num;
+	__u32 reserved;
+};
+
 struct rxe_create_cq_resp {
 	struct mminfo mi;
 };
-- 
2.30.2

