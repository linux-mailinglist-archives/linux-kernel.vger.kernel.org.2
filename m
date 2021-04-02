Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05932352E63
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbhDBRbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235882AbhDBRay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:30:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAEEC061793
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:30:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id d191so2804337wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wv9UQx8pFx9EKn1LAk5Wrb1T9ZM1NP2AqUIoiI8Ejp0=;
        b=hVQo0ISj4yCSQQtRv1KZJR3kDYHkEm9yu/V1uGelkH/U5+bQu60+38gwsq88R83NCB
         XtD1847j23hanWDdp8o32tuUyhabC69hgu7cCvu6mytOWoc6iy25WknCga0D7OWT6bw/
         c8vMIg9MPfROcZPBSK72UFaRyyZtft1Qxi4ZnqasSIdAzLkajrplCa6THRjlfi50vcgl
         2z9l/j24e7CZOVNWBqpfOG5kC1bsUqufM8HGIwPccJ4sFmYu2h9EZkYAO98H/LknDeu1
         CW8tSnV4f40ep6OHJxWhIzpHcWj0lj0D05dEmQtFSXTzQZcJqfq0ccqDNY/Tt+mWoHog
         N5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wv9UQx8pFx9EKn1LAk5Wrb1T9ZM1NP2AqUIoiI8Ejp0=;
        b=W4JAlWqhyyJtDpVW0MCNnKT3q1etTGHRlRkEzYd4czeiGA+SyAsDUqFFPsFxEoFLS5
         JTj6e6rVe0vIC4Aac5YRu/2vOKzN12ONk7nB2Sk7Kk207r/frlVAslJBWT/bIWnnKgiH
         U+VzpYZKv2gt8h+7ofX/uqkYAEpr7wmfa4qOQMwmlbyvZtm76ug8TG8vJvntPo8h8ybG
         GWjYMZtF1UfDyMA0iaDJp8Sf3DmzhugPuKYmpEdQlPb2tydXdDu1GH0gqxaWgKORKlKx
         EoCWmqCrPWkuWeUsNQ8RHLWPqCt+fgzj/mzpgjGpljdxqFHksgzrf28IF+e55M4LL/dC
         PEKg==
X-Gm-Message-State: AOAM532y2ERi/miWkxe+ka0n1sbOz8k8VTGCzKGLwwEalyJN+KeN16aQ
        CuPXqZXWejxugjHJVeF4JxVK8ZnwxcCYbg==
X-Google-Smtp-Source: ABdhPJyoPkbwxsOKVJ3jnjdBsbR3q0G3y3V9sAnRzRw3aox9pvnlyxFntawi++drvKlqNMxCSHyELQ==
X-Received: by 2002:a1c:a958:: with SMTP id s85mr13352615wme.138.1617384651505;
        Fri, 02 Apr 2021 10:30:51 -0700 (PDT)
Received: from agape ([5.171.81.4])
        by smtp.gmail.com with ESMTPSA id c11sm15832908wrm.67.2021.04.02.10.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:30:51 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 21/30] staging: rtl8723bs: split long line
Date:   Fri,  2 Apr 2021 19:30:03 +0200
Message-Id: <273f9c3f1cc7ac8bc77cad7c929ff6cc3fd8fc0a.1617384172.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617384172.git.fabioaiuto83@gmail.com>
References: <cover.1617384172.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix post-commit hook checkpatch issue:

WARNING: line length of 113 exceeds 100 columns
110: FILE: drivers/staging/rtl8723bs/core/rtw_recv.c:381:
+				if ((psecuritypriv->bcheck_grpkey
	 == false) && (IS_MCAST(prxattrib->ra) == true))

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 953351f896c3..c8a13d733c98 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -378,7 +378,8 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 
 			} else {
 				/* mic checked ok */
-				if ((psecuritypriv->bcheck_grpkey == false) && (IS_MCAST(prxattrib->ra) == true))
+				if ((psecuritypriv->bcheck_grpkey == false) &&
+				    (IS_MCAST(prxattrib->ra) == true))
 					psecuritypriv->bcheck_grpkey = true;
 			}
 		}
-- 
2.20.1

