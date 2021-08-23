Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509653F4EE1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhHWRBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhHWRBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:01:38 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CE8C061764
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:00:55 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id q17so5343920edv.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/qg8qpnRJ2gnKGXR4jQSIOwX6UI8f5uDF9GA6xG5tCY=;
        b=JoTyfJi4J3CuVXJ+atWqubfCbKEcc+MzVVaHI51WJdv5F/7FEXQtUUubpuCkbHrssk
         DyXVDLazzXXnGiOs+DyejUb1ZFgwrKMFyKi+rfVJY6+4V0aglwhcPNFTUKxcZeaTqodT
         T8O1vZT0vjB4mk7oywXtgH3gnR/9LXtQRPuZNnMHZO8iRugPoy8CKRD2RIRCrloik2UW
         o7QBw1BAUqsOe+A9UCjyCcL+ZYQkHFppQFuED1cXgh9+anG38SAbbd5f9BXZHKkl+jvy
         GcydrFv3IphoPOPajOXWXqG8fAJiWXfS64Gm0lrzItydJqby+L03ERD3Up/bnWbVFUfm
         fSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/qg8qpnRJ2gnKGXR4jQSIOwX6UI8f5uDF9GA6xG5tCY=;
        b=PBChFoceaBXXzW8Fx+VRAA5IavxL9sA4srJmXNwIRT5Q+mv2QovRKD/VF132Y719G8
         E/tsF66ZXox9Wj7+o2ruq7Q5MngpHDXG4jr07ALx93Uqhgjt2PgbJ1Jg46Hv15MG7CTJ
         cOoY8hhOykjpAkBm/g9mtqaoQ4FBSuoIaEJpJSGAiYXaZ/YUV4QaFvVxenco+rI0aDpq
         BLn2gishZkNkiu0GQ719qkKWVp/pNtKODHj7//CpVuFiuw0HoweI4oXYT/mo62IRXpFs
         nUawnK5CWAQKhUluJGuFAEKTks3A5Djr4Evb5C2dagJdVSqKpDA1VR28ShbXJLM1b1yY
         O9Wg==
X-Gm-Message-State: AOAM531z0CSE3ulHhH0CdFII5ncAmJvcdU4wAPs60Nnor4Ca0Jwac3lR
        LQBAWKTvsSnH/qSiXmxvor8=
X-Google-Smtp-Source: ABdhPJwgUSmjOM/vBcLZTcjto01IsVJi2DsK+gt0z9DNKER6g4/FCcTp90BfqLFWo3eRFCTgfXK+OA==
X-Received: by 2002:a05:6402:520f:: with SMTP id s15mr31874245edd.139.1629738054337;
        Mon, 23 Aug 2021 10:00:54 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id b18sm1633188ejl.90.2021.08.23.10.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 10:00:53 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] staging: r8188eu: restricted __be16 degrades to int
Date:   Mon, 23 Aug 2021 22:30:29 +0530
Message-Id: <464cbdb48b238d6b3aca435ef4f0bd05d48e01c6.1629563318.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629563318.git.aakashhemadri123@gmail.com>
References: <cover.1629563318.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:
> rtw_br_ext.c:839:70: warning: restricted __be16 degrades to integer
> rtw_br_ext.c:845:70: warning: invalid assignment: |=
> rtw_br_ext.c:845:70:    left side has type unsigned short
> rtw_br_ext.c:845:70:    right side has type restricted __be16

dhcp->flag is be16. Change htons() to cpu_to_be16() for clarity.

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---

Incorrectly removed htons() to satisfy sparse warning. Instead changed to
appropriate type and changed htons to cpu_to_be16 for clarity.

 drivers/staging/r8188eu/core/rtw_br_ext.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 26606093a3c3..83a4594a4214 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -641,7 +641,7 @@ struct dhcpMessage {
 	u_int8_t hops;
 	u_int32_t xid;
 	u_int16_t secs;
-	u_int16_t flags;
+	__be16 flags;
 	u_int32_t ciaddr;
 	u_int32_t yiaddr;
 	u_int32_t siaddr;
@@ -674,13 +674,13 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
 					u32 cookie = be32_to_cpu(dhcph->cookie);
 
 					if (cookie == DHCP_MAGIC) { /*  match magic word */
-						if (!(dhcph->flags & htons(BROADCAST_FLAG))) {
+						if (!(dhcph->flags & cpu_to_be16(BROADCAST_FLAG))) {
 							/*  if not broadcast */
 							register int sum = 0;
 
 							DEBUG_INFO("DHCP: change flag of DHCP request to broadcast.\n");
 							/*  or BROADCAST flag */
-							dhcph->flags |= htons(BROADCAST_FLAG);
+							dhcph->flags |= cpu_to_be16(BROADCAST_FLAG);
 							/*  recalculate checksum */
 							sum = ~(udph->check) & 0xffff;
 							sum += be16_to_cpu(dhcph->flags);
-- 
2.32.0

