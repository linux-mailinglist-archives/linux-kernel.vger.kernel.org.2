Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A655326F78
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 23:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhB0Wsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 17:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhB0Wsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 17:48:52 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DC2C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 14:48:12 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id n4so4069731qvl.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 14:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d6/qElfee7snrzWB+lR+ixXZDbPaoKETn/jyu2proSc=;
        b=lGdrG2Z1j6J0Q1L1R+R1beLd2f0kgx/spfBgEU+y9eNM1YG94C6C8crhvT2mpNdgrR
         z7rOplS4sTWnpV3AeNKkbP8IgfLtskrP6U6gg6AK/ja3IPKgEQvAnd41VjLtSGZxvmcf
         N2shdPl1YM1fW70Apy7waCHC/M9VHXYB7xUpUQRZoNfzIWHCXuX5SewxgY0XHpijm6Aa
         PT3bMciGPFkuIUGvIcK4i41lLA1x00CKBIeJLznVfCPR1uE4H0aFWepMumcLoDk06AZT
         p7X5HvspJ7dbbw4RHOUBoHxQSyQEyC/ZcFTr6p2OGLl+ghktxR+yygKRygIf2tHflMlx
         DKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d6/qElfee7snrzWB+lR+ixXZDbPaoKETn/jyu2proSc=;
        b=nLQNZ6ABQFbCGLEBafIeqrdu64wUekux4c49FwsVgekBxYYnal0W74F43DW4M9hsCx
         E3iNj+w9WlgGn/ogFKALDs9X1ZNXMmo/3Cz5i/SXvbAXSfs26fzhwyv4rgMUAELBVjQp
         h8AEM9kDkFTfmTea9l4fK4xTuV1b7NEEPNx+C6Zw1obDvyHUiSfvNCRyoQj2rWGqFZY6
         8TIufusNj835QFTo3mBAxgKm966z2IHg7nrF+cA+ePPV+5cjgwZ1T+hw15IjnwYAbx+t
         409Wf23LrN77j/aSv1WLtURavX1H6dg7vkIq2Bdgw7SSD4asJN+/1aotUt/e1xBq7GGu
         jQXg==
X-Gm-Message-State: AOAM531Fu1clTH8oFSztOeEosOEFatQvxHNczmJ/POAFFFK3fK/2qqXF
        Dn5MjN6cj3aEDZ7JdhyMjY6xbnmgmyAqmw==
X-Google-Smtp-Source: ABdhPJwxW/1jcHve2lmu7M5izDf0F4gFYVLPQOltLMoARLNLqUy9R90byk5fORh/U0/9jGdNSXjc7g==
X-Received: by 2002:a05:6214:1c47:: with SMTP id if7mr8940357qvb.50.1614466091328;
        Sat, 27 Feb 2021 14:48:11 -0800 (PST)
Received: from localhost.localdomain ([138.199.10.27])
        by smtp.gmail.com with ESMTPSA id x15sm9442310qka.53.2021.02.27.14.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 14:48:10 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     w@1wt.eu, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     rdunlap@infradead.org, colin.king@canonical.com,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] tools: include: nolibc: Fix a typo occured to occurred in the file nolibc.h
Date:   Sun, 28 Feb 2021 04:14:35 +0530
Message-Id: <20210227224435.21315-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/occured/occurred/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Stolen result from Colin's finding and share from the other places. :)

 tools/include/nolibc/nolibc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index e61d36cd4e50..fc998c359607 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -1054,7 +1054,7 @@ struct sys_stat_struct {
  *     scall32-o32.S in the kernel sources.
  *   - the system call is performed by calling "syscall"
  *   - syscall return comes in v0, and register a3 needs to be checked to know
- *     if an error occured, in which case errno is in v0.
+ *     if an error occurred, in which case errno is in v0.
  *   - the arguments are cast to long and assigned into the target registers
  *     which are then simply passed as registers to the asm code, so that we
  *     don't have to experience issues with register constraints.
--
2.26.2

