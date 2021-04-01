Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2BE3511EC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbhDAJWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbhDAJVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:21:52 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ABFC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:21:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id jy13so1862695ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XZ/WaUQjAmY8KmnixOjdV9SPezviiC6YLCxzwBrmxos=;
        b=mihdA6KGXgxejzuR7cuTDHmcAlNctRHHXCmAVbxWp7nd9m9x4GHKj7HdAtp2YXkKUc
         lM8GnLgjjgokSXmyCTGFEaPd44q19OvdF9LY7WvFzNOZIzAiuMpvSBv1vslRpmp00pYc
         +kcww02Vjeg1I7vu+oV55TynlyTANHmijzJChcKfVWk5QGy+jvG1VMya9FM++Q23gBPH
         6eCarEJJYXePENNj2CN3XFlZJv74TX7+56AAcgpx4JT1YnvgI1dXLcYGiFMsiYPgSJr0
         gnhHAXGptf6YVcTMcRX7vxQ1S/T+VkpxTrV0yiDz2Z6MtCZDa9r+FfLVv/OHoRD/U0U2
         M0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZ/WaUQjAmY8KmnixOjdV9SPezviiC6YLCxzwBrmxos=;
        b=Z93pUekg8KQdF0Vpio5FOwCugEIt+l6M8R1IFNiQdbnBadyja4+sTCJFRq0Hlq5QFr
         eMd+mZ7FuRa2ukAsGeT889VPWPdsmP/AP7W1yPsn4zL4wDDozcL9m2zLEuKA6sqaTV1g
         dJdLxalcT1wq4RFxela772B0UnEjncY0jsAPaP2aHyRUHomW/zY15nq17dvNx2kyuiH/
         Ut3I0AEPMFiwVJjzXeFQs1nNkokU972IARxVqZn3V9bud2ctn5NYSv99pPXZD9KKCgg0
         twQBzzi/81S1Do47jnjPMXjXiEE6TpFfRhNruHGhBMyrqSiENF9wz0DSzS5qA9oQ38w0
         3ZYA==
X-Gm-Message-State: AOAM532kjBSH4I6AlpISBQGFETXDVDtlogC40kveemMPXZNwts9oTiyK
        BCRJqPaLkHcnnpQoSLEDVy8=
X-Google-Smtp-Source: ABdhPJwfYyd01GZ+9c/2GChvVL0cWDtlVPNd+vRSZ/UuUPSqkX9LhyNllrsTlJeAQ9bHtyreixy6qg==
X-Received: by 2002:a17:907:766f:: with SMTP id kk15mr8203810ejc.24.1617268911020;
        Thu, 01 Apr 2021 02:21:51 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id e16sm3088001edu.94.2021.04.01.02.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:21:50 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 17/49] staging: rtl8723bs: remove empty if-block in core/rtw_recv.c
Date:   Thu,  1 Apr 2021 11:20:47 +0200
Message-Id: <2cb9acb430ea2c37b067f8dbab1509c827a8e200.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty if-block

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 5eb9914c48fc..fdba5cb74452 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -535,9 +535,6 @@ static union recv_frame *portctrl(struct adapter *adapter, union recv_frame *pre
 			/* allowed */
 			/* check decryption status, and decrypt the frame if needed */
 
-			if (pattrib->bdecrypted == 0)
-				;
-
 			prtnframe = precv_frame;
 			/* check is the EAPOL frame or not (Rekey) */
 			/* if (ether_type == eapol_type) { */
-- 
2.20.1

