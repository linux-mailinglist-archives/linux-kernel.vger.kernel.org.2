Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB533459399
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 18:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbhKVRHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 12:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbhKVRHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 12:07:10 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CD9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 09:04:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l28-20020a25b31c000000b005c27dd4987bso28712823ybj.18
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 09:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bdcfOEwSPQXWr0XJgX0JKzljFfsdQQuWPoxIgeWgGLA=;
        b=pywOUcGrj9jYy2ox4jZkiwwgOJ7cfhN1KYhBOelMmiCjdYG9p/EaBms1yRBXuRPN3l
         Pohj6yQqnJNW2wVv/ncHJZ1tamwJ623BXW0ZqW3VLTRteRiRQiyATqZdvj3/giutiPXM
         TtSzx7bCnh3aO0cnPI9DaI8ln+uKGIkyK4DDwINAaNWXs6m8GgosRmZtwo0XBwBRZXUw
         /BU339oVzd/gOBu142kxRHS+d6K4w3J7+OoF5qGn7DqrIzebwlDdXB27Pd7k46Bm4sCF
         L59zCfSaD5DKv8YcpsJUqOdqpMWhqzTzyCede6g0E2c5IUN5BsQYBobY/qbVHWagRcYg
         //Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bdcfOEwSPQXWr0XJgX0JKzljFfsdQQuWPoxIgeWgGLA=;
        b=hFTJ5kxSWkTfikbcMclYcGcKSeJgrSapLaBDHIgxp53j8agL6K9QZTC66PAx9cxHpn
         r69Q9uzPfCYfLbU/T3/xVUb0eiKsyf8gVDh+xUHQqVpxn2eBdvt7U1ylfvFWlapxLRo5
         zxjTAx5fAffkVVTDMacecMJNvGS7Dco/S8a59KSV//aDR9ImCNJvgDZpZM6cSvxqX4SL
         edbrssv5ea1Y7HndkezVXusUgbvPGMiHu78Xu+GfOM8yNCfPFHjoJLloQZ3/pLzwhs6u
         +obmPj+zQQss19B/TryUcb3sBPsheh3W5F/Cpw8FzwBRBPGF8S6kPgF5ELCf6K1OEvCX
         t6Fg==
X-Gm-Message-State: AOAM530ZK2jULMGfzMQo28VDbDxgCFQ1f600OQkbg27PMPaZwTG9ZZQQ
        7ZZ9rUnSPWuYS2YMhqrKgC0wRG2USg==
X-Google-Smtp-Source: ABdhPJw/9zwTqnuQL2LKzyAS8YiZDr6ZSxFI9PQxI9zwi+BGycgwtd5rJwRza8OOymkCpuKcZeMHYJxtPg==
X-Received: from zoebm1.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:e29])
 (user=zoebm job=sendgmr) by 2002:a25:ac42:: with SMTP id r2mr64254480ybd.126.1637600643085;
 Mon, 22 Nov 2021 09:04:03 -0800 (PST)
Date:   Mon, 22 Nov 2021 17:03:35 +0000
In-Reply-To: <20211122103931.GA6514@kadam>
Message-Id: <20211122170335.1468730-1-zoebm@google.com>
Mime-Version: 1.0
References: <20211122103931.GA6514@kadam>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 3/3] Staging: rtl8712: Fixes a camel case variable name
 style issue
From:   Zoeb Mithaiwala <zoebm@google.com>
To:     dan.carpenter@oracle.com
Cc:     greg@kroah.com, trivial@kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, Zoeb Mithaiwala <zoebm@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes the names of variables in rtl871x_security from camel case to
snake case to match coding style.

Signed-off-by: Zoeb Mithaiwala <zoebm@google.com>
---
Changes in v3:
  - Fixes commit messages for patch.
  - Uses the same variable names in header file as implementation files.
Changes in v2:
  - Changes the variable name from nBytesInM to bytes_in_m.
  - Removes changes to other variables in the file.
---
 drivers/staging/rtl8712/rtl871x_security.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_security.h b/drivers/staging/rtl8712/rtl871x_security.h
index 1de662940417..81262e68bee1 100644
--- a/drivers/staging/rtl8712/rtl871x_security.h
+++ b/drivers/staging/rtl8712/rtl871x_security.h
@@ -200,11 +200,11 @@ void seccalctkipmic(
 	u8  *header,
 	u8  *data,
 	u32  data_len,
-	u8  *Miccode,
+	u8  *mic_code,
 	u8   priority);
 
 void r8712_secmicsetkey(struct mic_data *pmicdata, u8 *key);
-void r8712_secmicappend(struct mic_data *pmicdata, u8 *src, u32 nBytes);
+void r8712_secmicappend(struct mic_data *pmicdata, u8 *src, u32 nbytes);
 void r8712_secgetmic(struct mic_data *pmicdata, u8 *dst);
 u32 r8712_aes_encrypt(struct _adapter *padapter, u8 *pxmitframe);
 u32 r8712_tkip_encrypt(struct _adapter *padapter, u8 *pxmitframe);
-- 
2.20.1

