Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EB73DDCFA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbhHBP6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbhHBP6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:58:33 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66D4C0613D5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 08:58:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g21so5885270edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1p33HmH3Rqzb0j02d5EXcRKxYG7aRHOch7Hn00zmgEM=;
        b=Fw9S3Q1mgoh8IYe3h4YdyOjG6cQIs8GICy9Jrb6DTxnswN9Ujnl8jtfZQXjhiBW+Om
         ZNh84SiDpJQqj/KeuLALSGTh0w/NsgFS6yOR5Wr/h9v9+InNO1gEMOdc5adET/DqOnpj
         xppBnAHB0Zgo5hespKNovBAX10Qw3VJo5AjwB3Op6NDQ83vJrXeEd2ECjD/2AEfFMeRs
         5CkxOouJX8S2LxbYfDQuiHv0aprvhb9lkv5XFeziT3iyFM+H7ECFhwgc8TfoVs1PXHjN
         Syj223ofCY/8RZLqX21IVFUuQuv3pJErc+nNQ/ThqDAMe1cWP3fm4W4W+gPHHaPCCyo/
         GthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1p33HmH3Rqzb0j02d5EXcRKxYG7aRHOch7Hn00zmgEM=;
        b=nZ/gNfGcH0SW4A9uczPXgnI0SyKL1/yxZ0c77jf5NV58d8pUgLKrK3RIUNzdE4k5Nn
         BHeRUoHfWo4XlsbDSxLkmcjF77bKVnbP5/hxku4RccuRPV364WqunWJvl7RnyQErhHCR
         GcTQQ4IQ+qCtj8rdWR2U5jeEnLzrAzO9MrIerUgk9QuB1TCc/jIpQPWwHGWNBPY30Y+X
         8Ru/hHkg7FRcBLI6dBMqWGtjLQzbZvxWrITMkOq/xT8phKi+g2Pn4K/+CXiHgVt68L7z
         J1yK5WnrHirvWgmnxVDdtoBLeW5Ja3gsJYHxjdtLHKtzwb4/lN8EojhAaNMPDlPP6OH8
         hIrA==
X-Gm-Message-State: AOAM532MzOkv8/VraKqTcPW6oz7JaaE6dkbGatAwO0O8+dmItLuUuVKT
        WS2NNQ9T7Q2EQDY6/CsgX6o=
X-Google-Smtp-Source: ABdhPJzUN/sG7SRSGjB/NaBW8o07Ix3uQ28IDC0ybg4f9j7rEjoYA3FgAnihWsSZCkgJdPpg9y82ew==
X-Received: by 2002:a05:6402:1cb3:: with SMTP id cz19mr5256187edb.206.1627919901581;
        Mon, 02 Aug 2021 08:58:21 -0700 (PDT)
Received: from localhost.localdomain (host-82-51-42-96.retail.telecomitalia.it. [82.51.42.96])
        by smtp.gmail.com with ESMTPSA id f15sm4815590ejb.125.2021.08.02.08.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 08:58:21 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: r8188eu: core: Change the length of an array
Date:   Mon,  2 Aug 2021 17:58:17 +0200
Message-Id: <20210802155817.8179-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPX_NODE_LEN == 6, while addr.f1 should only have 4 elements.
Replace IPX_NODE_LEN with 4. In the while, remove the excess spaces
before the fields of the union.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 8f434768dd15..c585224080c6 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -137,9 +137,9 @@ static inline void __nat25_generate_ipx_network_addr_with_node(unsigned char *ne
 				__be32 *ipxNetAddr, unsigned char *ipxNodeAddr)
 {
 	union {
-                unsigned int f0;
-                unsigned char f1[IPX_NODE_LEN];
-        } addr;
+		unsigned int f0;
+		unsigned char f1[4];
+	} addr;
 
 	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
 
-- 
2.32.0

