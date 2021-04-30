Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCFC36F68C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhD3Hpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhD3HpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B708C061348
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:27 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gx5so11747315ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rmk90qSfuSLmAzINt8x7JaHcuQoCwpmT2qAtZaxL5BQ=;
        b=rERfYBX0hrL5IfMOb1PqTc4berZCqBq9x2tO4CjX2DLnEKmr5828UkVPfDgwpt1sBK
         xIAyupBn265KdGbI8pM5cyXEpKSMfD6ZWTuXeS72nnGpaqdALaxZMIQ4kcCgu4gGU098
         wJ5o7bLXSmMv8gk6DsqP2waisYavIv+BuNaOv+1gu+6DDHz0CNlJ9L7NUGz4Ce8LeWJs
         Ler3RRN2Js80nGfg5jOQlmR480Px7Mv7FhyaXZz5o6i5u366pUmUZSNhfa5rbKuREn+1
         +eRMLJZvRS85zKZcSg+tNmmDZ6CHQKuG348wTJWLjsVe7jdv53608v3RSt6J79A+hiI7
         VtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rmk90qSfuSLmAzINt8x7JaHcuQoCwpmT2qAtZaxL5BQ=;
        b=nZo6SuI7ay05/j6rkBMbSneVCdlesPBAtoywYSgdqDBX8nNFGFX96Lfggy+XGU7ue5
         wqFYtuBXkhNL+k6FuoGC182F6PNTSDoJKpnb3vAo7CM+oNC3l91xOeC89RQlKAiRDVUu
         oKh2YdR/qF/AWVhb2i6mx93uPaR5w3Zm8e0TfQpZNoqV+ou/SiMeP17JByw9Dil7/tsw
         LGqmbN2UK/bTrBbrksR5drb6YbCekKnunwL0L6TlMGCsFu/wnfAkUe4QyaU0xNylpful
         HJlbzhjrJjxuWS8HOTxaIKfoI3Jl7aqzkVJfd7MU3isYgwz4b6w8XJKnlmrKTmQtGmuA
         HXNA==
X-Gm-Message-State: AOAM530FClEkPM6CSkw/rJ/uH5IpaA9efZbhgFdyBCGyosBqs6r6WI1V
        G0CibzSTI5+SV1gZKGJ4NnHIR2KWKF+myQ==
X-Google-Smtp-Source: ABdhPJzTHYO6dnSb5+l2Z4aG/VGkbhCHMo4Vtd/qGVQ9j1JemydFsAVwZV5Re+/cNahUWjuH6fxxgw==
X-Received: by 2002:a17:906:2616:: with SMTP id h22mr2905494ejc.126.1619768666139;
        Fri, 30 Apr 2021 00:44:26 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id w13sm633778edc.81.2021.04.30.00.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:25 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 13/43] staging: rtl8723bs: remove unused ODM_dbg_enter
Date:   Fri, 30 Apr 2021 09:43:31 +0200
Message-Id: <9f31d5685462f7f5d69956fdafb3611727a3f9a2.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused ODM_dbg_enter macro definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index cd68c583699a..7c9a87fb8e51 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -97,7 +97,6 @@
 
 #if DBG
 #else
-#define ODM_dbg_enter()					do {} while (0)
 #define ODM_dbg_exit()					do {} while (0)
 #endif
 
-- 
2.20.1

