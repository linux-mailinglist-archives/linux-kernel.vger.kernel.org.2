Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39C043F784
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 08:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhJ2Gzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 02:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhJ2Gzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 02:55:46 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64573C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 23:53:18 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q2-20020a17090a2e0200b001a0fd4efd49so6816436pjd.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 23:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=rtm9O188bYJTXAJCaUyfIBjj0pjGNgOqheOvrJrI9tk=;
        b=C1sU3wn5eHWYLoc1q1vDIkBRL7y3Xcx/gNSUHK3EYtVCYKjfEy2Io6XSXGY76yOXC6
         ap4po4iaTCjRCYJza1aaba/W4tGhu/xgiSz+BveolvP5Jnh9arw0lzrDgs4Zn4i63DaJ
         ZqB55O0piX/btBKFlyCh1LqGrPqbQlD8IXwqgmAI+ymsp+necODdKxva/SOv0TmqJMcA
         uKy5xubaznuGb8qKKDlkf5z44OaA36XCjP0AtDu3Pq6D0VHMpsRFRfm5w75gnohyo+PY
         p6I6uLg/ZA1TvHrFemFna/d1x8POZVXdrqF79qThjNYvSkPM3GSalKN9UT48TiOoEZ+j
         UwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rtm9O188bYJTXAJCaUyfIBjj0pjGNgOqheOvrJrI9tk=;
        b=lMdhI8WtiI2ILmBeWsjPtragqFnur+Gpe1EnmqQOloGKsmtAWHoPVp81KYHRoQvooU
         7zE2GF0DN5REOU8MxS3YmY1v5APl9jY9CTKaN+6islV1dfWa5HabMFmcjfQ/hOQPjeFS
         Ap2f8UOVxsvsl4p9UxomLTJqb1K92ByNo2v3I49ZpmpG+y69gzL8vfdbfw8YrIRa1IzZ
         BfSAVz4OVZ/W/UUmtCpTqXON4//qKhoVQz8MhW1M5pmzzYx/iZYfniR6I3W4IbFUbPdJ
         dIfSjdcAh1nquHwPzG8kKPLAYuuFRBkQHDO4xZqMd96AftTVPHIQJBoT6PXGR5z45z5p
         +BfA==
X-Gm-Message-State: AOAM531Uyf1lBuamFU+h84H0BT4HywQ6V5VhHMuBsAYF+6PvNbyLodSq
        /FTXf/HUIo14S/WLrfw24Tc=
X-Google-Smtp-Source: ABdhPJyIwmap+6HqIvfxIU6Y7NG0Z04RG/sw8hSZBG6huGco+a3p2+wc3Dv6ISn2sbkQNJLE4cK8AA==
X-Received: by 2002:a17:90b:4a45:: with SMTP id lb5mr17802631pjb.94.1635490397951;
        Thu, 28 Oct 2021 23:53:17 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id gn1sm4729741pjb.34.2021.10.28.23.53.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Oct 2021 23:53:17 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     nianfu.bai@unisoc.com, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] pstore/zone: Remove redundant check for total size
Date:   Fri, 29 Oct 2021 14:51:18 +0800
Message-Id: <1635490280-8798-1-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>

The macro check_size contains 4096 size check for total size.

check_size(total_size, 4096)

Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
---
 fs/pstore/zone.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 7c8f8fe..93a770c 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -1295,10 +1295,6 @@ int register_pstore_zone(struct pstore_zone_info *info)
 	int err = -EINVAL;
 	struct psz_context *cxt = &pstore_zone_cxt;
 
-	if (info->total_size < 4096) {
-		pr_warn("total_size must be >= 4096\n");
-		return -EINVAL;
-	}
 	if (info->total_size > SZ_128M) {
 		pr_warn("capping size to 128MiB\n");
 		info->total_size = SZ_128M;
-- 
1.9.1

