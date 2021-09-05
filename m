Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E0440119B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 22:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238163AbhIEUxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 16:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbhIEUxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 16:53:23 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C2CC061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 13:52:20 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id c8so9365474lfi.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 13:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8dWkUEjNkAWUFS7smY/S53tLlwVSBp7wKC32dkhYG8Q=;
        b=ls+6vNBRkX8hng0+3ffuWcI7eC/K2BuXvKgh7c14rmgf8ZkyGka/cdzNL8MKg82I+a
         EuKclFfG0DL/90ANVrLDfK5jLFd52GAacfQaAF64QotFUdS/jUi/4AyK+ZLWwty7qzqO
         /+kcrk2xN2A9zeZvMF5lcQ107VdeFsC5C5pNL0oOVkPVvZCCwYQapGqHDtAE8YiBI96G
         v0KwCe2xT9O698Y7pKi08gPwL/uTPrVePifrzdPjjhYHKqIdZ9tuMLE+mOGQimJtgfFD
         qNgyRThHIHmUUj8Fk8zH4ZbDJOGjJM72cOKQ5nhJocTzeDxgT/upQ5q4tfUvymfOKlpp
         UmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8dWkUEjNkAWUFS7smY/S53tLlwVSBp7wKC32dkhYG8Q=;
        b=q/W+l8Ne4FePZLm8eq/Q7E5kShOV7lNMySKixic/HgV5z3903chbh8OdLS/+MtFXEN
         uK1Mn1bJiGYp1e/hB4y0bK5/3zLDdBLpsxG65+XkJiG5WmQ0/uHIKZjgLq1Nw+GNDEQr
         t8RJvqMKtgRrOIkC6jyv8dLBCbw7jWxrxJgiT944LAPYhlQRbc9ifVrf49y9Xgy00dvl
         Ba0tWyT0nEI9qRUNLeuq6Xh3gTzKrW2yqATh+9UxSxah/1Wb/H63fLV+B3g61nOgS7bH
         ViFOIaR/d13D15/RZWc9opXc5+v/NpROGhjrNbbhX3mFYLSE7ajE/Sev+IidZ04TbqYZ
         7jaQ==
X-Gm-Message-State: AOAM530qIfdYxh00yZoAGEem6ikQJ2VQ4oA6tTliBldNF5mdMnM6GoKC
        fIQ9VgQdQdRbWwNWqJrWvpY=
X-Google-Smtp-Source: ABdhPJx/CscenNT1ExkPo7OuH35JOivO8iq9aisapt+v7XWY9tfzA1FcSYNfekhrI6nxkmY8aHw7RQ==
X-Received: by 2002:a05:6512:398b:: with SMTP id j11mr7173902lfu.194.1630875138503;
        Sun, 05 Sep 2021 13:52:18 -0700 (PDT)
Received: from localhost.localdomain ([46.235.67.70])
        by smtp.gmail.com with ESMTPSA id o10sm558817lfb.173.2021.09.05.13.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 13:52:18 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH] staging: r8188eu: fix type mismacth
Date:   Sun,  5 Sep 2021 23:52:16 +0300
Message-Id: <20210905205216.24831-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch says:
rtw_cmd.c:1165 rtw_setassocsta_cmd() warn: struct type mismatch 'set_stakey_rsp vs set_assocsta_rsp'

Since psetassocsta_rsp has struct set_stakey_rsp * type, it looks like
copy-paste failure. This error didn't cause any bugs, because
sizeof(struct set_assocsta_parm) > sizeof(struct set_stakey_rsp), but
there is no reason for allocation extra unused memory

Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index fee4208dacba..afe6c7fa594d 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1162,7 +1162,7 @@ u8 rtw_setassocsta_cmd(struct adapter  *padapter, u8 *mac_addr)
 		goto exit;
 	}
 
-	psetassocsta_rsp = kzalloc(sizeof(struct set_assocsta_rsp), GFP_ATOMIC);
+	psetassocsta_rsp = kzalloc(sizeof(struct set_stakey_rsp), GFP_ATOMIC);
 	if (!psetassocsta_rsp) {
 		kfree(ph2c);
 		kfree(psetassocsta_para);
-- 
2.33.0

