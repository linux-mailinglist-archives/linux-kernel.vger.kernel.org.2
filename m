Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A4E34364D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 02:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhCVBcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 21:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhCVBci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 21:32:38 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD6BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 18:32:37 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id a11so11269457qto.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 18:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MusoT+WZJheUpwgoiy/CmTBtw71iPdI3X741K/rLyjI=;
        b=KgLSfWgFucrr0E2uyecttHhDSaWKVki3NFyii38K2eUVaAMtJp+4XzzKdjCjirjTaw
         c5Nrmru6hTKkhe+T3Ep/ARa2OWT8i4ZmqqO5qnQHNPYY4wI41OAHgLmnp/M+plQRxx7w
         9TWtIPnxe7SxbztUY/t6Lnoq+1dWE7QVABuukvr5xnla/4N0oZjD1hIwudIMQSm8f3C3
         pmofjfitRvL3MIDh6n2Y/BuYfjBSBuMgJxBq3SaCIGBi61Yo74awxt4bGNn4YaeD1Can
         2gVTjCJ9s8kdVZq5qG1Y3OimBfC3BhrG85PFQn1QEk6Vpnz/EFXzjlzaFWELn0/iU6Bz
         YJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MusoT+WZJheUpwgoiy/CmTBtw71iPdI3X741K/rLyjI=;
        b=Fy00ZUiV+nDGZK2sdJdwxWe0lLRVqKGQjbkmmoMgxBp6Vzidt9RPYmRJTrhe5vuSE5
         Gu+at/E3q3UxtxD5iSIZZ5CUwqQ0cBq50aTFQ8Zg4VFwG4g2YnwFKODXawy9jRrQO16o
         nUjbDEG4W1HQ1B66byQ2uFzB+l/EWTH+8AUIcMfg1fTFkpQM5zCJh11xCHiYq+IoelpC
         7DcSzD/ZwlFs2Y5/nrbc7bQQQ5dJ+gVzp89EeviDxJ2Rs+pflpohquKpaeyjM6aFcdaY
         UI82qmrndnWkN8JD1r/jOSB6T0P4EeShum0K6iR9fRBos/G6CW/USh7/uLU9/R4+81Ds
         UIXw==
X-Gm-Message-State: AOAM533TR6HVUSqn62cMM+sh9krIdztZMzQvMXnu7YLbnA5eiCtSHOnj
        Qhr36EsJa7/Xfvw2MB4wNGw=
X-Google-Smtp-Source: ABdhPJwld9nR1hlEZLrHqQXDlqjrPPWNVRiEXwsGE3BM6SpW0C4M70PPG4tee3XHNHSVX9dNEc04LQ==
X-Received: by 2002:ac8:109a:: with SMTP id a26mr7724497qtj.156.1616376756909;
        Sun, 21 Mar 2021 18:32:36 -0700 (PDT)
Received: from localhost.localdomain ([156.146.54.190])
        by smtp.gmail.com with ESMTPSA id n140sm9837724qka.124.2021.03.21.18.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 18:32:36 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     akpm@linux-foundation.org, liao.pingfang@zte.com.cn,
        daniel.m.jordan@oracle.com, vbabka@suse.cz, gustavoars@kernel.org,
        yanaijie@huawei.com, walken@google.com, unixbhaskar@gmail.com,
        0x7f454c46@gmail.com, adobriyan@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] ipc/shm.c: Fix a typo
Date:   Mon, 22 Mar 2021 07:02:23 +0530
Message-Id: <20210322013223.1930159-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/exit\'ed/exited/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 ipc/shm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index febd88daba8c..07fb04c20d8c 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -357,7 +357,7 @@ static int shm_try_destroy_orphaned(int id, void *p, void *data)

 	/*
 	 * We want to destroy segments without users and with already
-	 * exit'ed originating process.
+	 * exited originating process.
 	 *
 	 * As shp->* are changed under rwsem, it's safe to skip shp locking.
 	 */
--
2.31.0

