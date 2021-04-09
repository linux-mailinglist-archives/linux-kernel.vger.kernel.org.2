Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C559B359BAA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbhDIKOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbhDIKFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:05:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285C6C0613B4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 03:02:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r9so7741491ejj.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 03:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JytH94vJbFCj7GF8XTLRPZJht9eld57OrRaG5ECiMQQ=;
        b=HA0frDEEl8tu4uCWwfdOa71uh2WD0uWeXL8s6LZ64BeJGsjy2ZHFTPJ3Dn/QJIYy5f
         bv5l/22hlVG5ydcJExLLTmZ+0fQXphesxhYA0zxQ41Jt8/vDvCNxJm1z0DyELXmGpRST
         O2R889XsBO0eSR4zteK1YkkmMKO+dotKAyOlSxdD9/NQ8/atRVMtVShk/nbiVWfZvlSO
         WVPvEjDw/a4uaKUi4IRANEWe1/Cm68kUq1TNiQTR9MzrbCLyluq4NZc9tol1hTn0zC9X
         kw5Qq3CBpSi0nQkPMWbplu4NWK7ELys74hSrcspbV6Vhi+tCMjbG/mNQdN1zEMOuNlGd
         lwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JytH94vJbFCj7GF8XTLRPZJht9eld57OrRaG5ECiMQQ=;
        b=EBimwj8tbzNa1Fv6mc4bIOAqMYvL59egkycpt2VWd8SoFI2WaHgaZI439uwJIUPXRn
         Q39wYoiFPTBQMyUh12pEhhZfQqBTNwN/1Ms2/eFvkvMFQOAI59FfXwRiA06UNJx4pezm
         YDkm966eGvgeZ6mRdYbWjz5GoUGpJV5mU53iDDI8wJmRCopbNExbLLwzD15qojC1f+nd
         UT21uzA2FqDCFTshblBkgDD1c6CDkoIA4rL17beoWOYZlc11C3kdK9Mjl0a/M77IItb3
         fltHp9A0g4h8wsCR5kEnNP41QVgVPE4jN3/Xr8KMJV4YDQlZlXSnhC1OzVdzsHQNX1WZ
         Xt6Q==
X-Gm-Message-State: AOAM531CkUrBNRE4otQ1FmeZqvXtT0KkSBYZDA9icAIFiL4p0TuQRcR2
        seyx+Zrky0brthjIAGUZG7euHxS+9Xw=
X-Google-Smtp-Source: ABdhPJwEt4KOxtI39dsUCn7FcQMHvZfIfa9co23ZLdx9gxo3Ha1HqveEuWc2UE+XRqwnvpWdIb4I/A==
X-Received: by 2002:a17:907:3a98:: with SMTP id fh24mr5486136ejc.371.1617962525933;
        Fri, 09 Apr 2021 03:02:05 -0700 (PDT)
Received: from agape ([5.171.72.173])
        by smtp.gmail.com with ESMTPSA id r13sm1158992edy.3.2021.04.09.03.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 03:02:05 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 11/11] staging: rtl8723bs: remove decl of unused static const variable in os_dep/ioctl_linux.c
Date:   Fri,  9 Apr 2021 12:01:39 +0200
Message-Id: <05cc97a114269ee55ac9a91c61493c885fcc0193.1617962215.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617962215.git.fabioaiuto83@gmail.com>
References: <cover.1617962215.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following kernel test robot warning:

   At top level:
   drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:36:27:
warning: 'iw_operation_mode' defined but not used
		[-Wunused-const-variable=]
      36 | static const char * const iw_operation_mode[] = {
         |                           ^~~~~~~~~~~~~~~~~

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 6f52b8fb0d6e..e5f0cdc9711e 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -33,10 +33,6 @@
 static u32 rtw_rates[] = {1000000, 2000000, 5500000, 11000000,
 	6000000, 9000000, 12000000, 18000000, 24000000, 36000000, 48000000, 54000000};
 
-static const char * const iw_operation_mode[] = {
-	"Auto", "Ad-Hoc", "Managed",  "Master", "Repeater", "Secondary", "Monitor"
-};
-
 void indicate_wx_scan_complete_event(struct adapter *padapter)
 {
 	union iwreq_data wrqu;
-- 
2.20.1

