Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DA3359290
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhDIDJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbhDIDJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:09:20 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C54C061762;
        Thu,  8 Apr 2021 20:09:07 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id o5so4599504qkb.0;
        Thu, 08 Apr 2021 20:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=54Nec5iwCSagU+D8h6pLpuy7QchFo0Lir6iLHH9sio0=;
        b=fdd6V/dfeP545vuI02y8LH3aY6xDltfD2K42Z4aNIKb7AsPwkYcJtC3Un3551NTd70
         TrI78vrR733+kWVFlkJ1lq6HBWLYOX/ekpdunlwIr5M46DzBTdoD6VSv/5Kz9KFA3abc
         2NbLnUdUQU4lfn2PpYQVKBMDsB24Xo0eF59y/LLwNnGwWOmyt74gKlkbhCEqu76zfzF2
         vngPXWAJrGPeWJpVHv9d5L+CjkpnFccVcko+rjMTys1kMZneps9HuVK8dYZ50GTSgeaN
         m93DmACRwOvMxD+vLs5fIIwMsNVs+sBqASRziz9UPWttq9dVa5H0rH5gKHXg+lAqVdo8
         /rvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=54Nec5iwCSagU+D8h6pLpuy7QchFo0Lir6iLHH9sio0=;
        b=iFGYXzyOgXNOsw81DpbwEA/empX6cJVa/9Elkg/yD94hnmikp2LSwx5vCIW3lIkgDJ
         P3GZOAhy66qptjUW33yBoWng8P/ws9GDxeQxJeaYA8c7RCXZJ7vnQEd7GeSEDnRPNWWX
         PHobQ6sTxSXIAwgLj1LBRNkhjOZKVrGT96bRhsSkZ7mOyYOTNG7J4Ga0d2pqGSYnalTJ
         +JN84CgxDh9cOpwmw0XflYiXRRzYZ3aeD1cHsaH5V/aSBOZ6yuywqjo4OiTrQFiqtB2W
         xN0MnAwJb0xa8244zVL4VGOKyln3Kf7DRdCrMEP4xg5EbQ7OQFs/zbA8k0oLnk3ojY5+
         9bhg==
X-Gm-Message-State: AOAM531lRjA3A9yGnVT7Bs4VoQxIxJTUdCxlnI8e0QdqzjoXnhTipXtY
        ivkFvAzNtZ2U07kW8GSBuWM=
X-Google-Smtp-Source: ABdhPJxmrSMJxpTFjayXag0LrLCp85BfG+K2gNm0b8dwEhEeRB9h1lJYAD2LquUmmfH6NDU3eWk6sg==
X-Received: by 2002:a05:620a:1645:: with SMTP id c5mr11589778qko.63.1617937746616;
        Thu, 08 Apr 2021 20:09:06 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5c21:af45:3b27:576c:7dde:37f1])
        by smtp.gmail.com with ESMTPSA id c5sm925408qkl.21.2021.04.08.20.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 20:09:06 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v5 4/6] w1: ds2438: fixing bug that would always get page0
Date:   Fri,  9 Apr 2021 00:09:40 -0300
Message-Id: <20210409030942.441830-5-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210409030942.441830-1-sampaio.ime@gmail.com>
References: <20210405105009.420924-1-sampaio.ime@gmail.com>
 <20210409030942.441830-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of the w1_ds2438_get_page function is to get the register
values at the page passed as the pageno parameter. However, the page0 was
hardcoded, such that the function always returned the page0 contents. Fixed
so that the function can retrieve any page.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index ccb06b8c2d78..ef6217ecb1cb 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -62,13 +62,13 @@ static int w1_ds2438_get_page(struct w1_slave *sl, int pageno, u8 *buf)
 		if (w1_reset_select_slave(sl))
 			continue;
 		w1_buf[0] = W1_DS2438_RECALL_MEMORY;
-		w1_buf[1] = 0x00;
+		w1_buf[1] = (u8)pageno;
 		w1_write_block(sl->master, w1_buf, 2);
 
 		if (w1_reset_select_slave(sl))
 			continue;
 		w1_buf[0] = W1_DS2438_READ_SCRATCH;
-		w1_buf[1] = 0x00;
+		w1_buf[1] = (u8)pageno;
 		w1_write_block(sl->master, w1_buf, 2);
 
 		count = w1_read_block(sl->master, buf, DS2438_PAGE_SIZE + 1);
-- 
2.30.1

