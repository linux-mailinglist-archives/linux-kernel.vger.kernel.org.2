Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB233511E0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbhDAJWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbhDAJVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:21:31 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA15DC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:21:30 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w18so1199154edc.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HJqQJvrsu2AgEydH+oU+Yu3fjSul6JhGXyuC5jgh4hc=;
        b=MogSFjQB68ZvISvsXroExN4si7+tZ1EaEuqlXoEEh7UxWVM4GrUCaycBhWP3SaoVuj
         iD622bpJC2BGycQ3PpHomATvnNRKj3J/d0J7cRaSadqzkQcRQnfgXQyf3G07JxNvH3kn
         GZHTGidltB6edZnhbD2I0vT9KDetVJZVHJmHbg0jCX3juTCVBEBUfQznh+FiZEryeXhy
         la5m6mQa+CO0L7GI+MwF9rnkgWnVZW4grYTSAATRLF0KI5/kFAL1fJOg53ow0sTky7dS
         U2EAO8Bd4trHx8FpHcE9HRDfu4ByreGG0k2YHfAgkxrnJdWSfA8z99a4yVn5LdDHU3TK
         lhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HJqQJvrsu2AgEydH+oU+Yu3fjSul6JhGXyuC5jgh4hc=;
        b=SUMU+vZDqOGMgRT7xl3b39Ur8T8lDWAl0KnjJZWZq9XMJSYHCdd8Nev2keGLqv1fAb
         x5H91jUJHJ6/bSISQoAVd3idvBg0AqiwLicqu+hmpaeM4HjYxdQOwWFC6ZjeZG+rBA4C
         1XHqhe32ZV9VSK5JMijN3fuuMM5iOFtoFputMibj++40+bcFQEzcT+0UwGcn/z9stDGK
         DAavpynu0y4ZfNwGVKqkwYjyxdYvuaDof8Se27aZ4EFAp648pXiudDHRIsujtHtxth7i
         h0Su6Uh2+WAzz1W8JMj7LX3MjKVMKW8rJRq7mnZYZogVGoL8yPd35rg7JcN/KN1eoTL2
         Ai8w==
X-Gm-Message-State: AOAM532EmMXh7nRUR6rbKwwEANAGBVTbLz5NYEY7RkClaSMUvXj4ihVj
        sSrNf2a9z4QsXPSdLtjlsjw=
X-Google-Smtp-Source: ABdhPJz7y4HkkFaSkXhoT8ePVtZrgs70neuhX4x01f2k+C9e4/Ynwue1N99H1zuhZ5YkVyaEjuvRjg==
X-Received: by 2002:a05:6402:5203:: with SMTP id s3mr8858612edd.79.1617268889571;
        Thu, 01 Apr 2021 02:21:29 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id z17sm2581223eju.27.2021.04.01.02.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:21:29 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 04/49] staging: rtl8723bs: remove empty if block in core/rtw_security.c
Date:   Thu,  1 Apr 2021 11:20:34 +0200
Message-Id: <31c2087e7876143b5da76891b19ac0b3ef8ac731.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove an empty if block

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index c91a1eef40b3..acef6aa0b393 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -236,8 +236,6 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 		/* calculate icv and compare the icv */
 		*((u32 *)crc) = le32_to_cpu(getcrc32(payload, length-4));
 
-		if (crc[3] != payload[length-1] || crc[2] != payload[length-2] || crc[1] != payload[length-3] || crc[0] != payload[length-4]) {
-		}
 	}
 }
 
-- 
2.20.1

