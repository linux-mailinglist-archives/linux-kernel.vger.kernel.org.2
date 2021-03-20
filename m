Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF03B342963
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 01:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhCTAQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 20:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCTAPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 20:15:36 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8547C061760
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 17:15:35 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id i9so4792773qka.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 17:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yMoS29iTA682CqL5fMoldhYnScAFTc+8697an6z6GgU=;
        b=M+ICxMkbJW236SJSGga3tQq1zmIDGhoaMAkNfp11B3j8To9eFo4HwGdRNMPdnIJYWY
         Qkpb70leO8vfyONelNpvNujLDqVRXC5FMWxbY1IYaomTQaiD4FJfEDP/rkZJbvxnAtrp
         yEge65e6Wvvq2StTLpB75/OWZ2meFqXFYLiYevmdiB/90ObLM7RIagYhuSlYCsj/d7i1
         Zqp0pToJgWzZZRW3K/dd8Q8Kq8dtLgihDlAJgO0I/kMQylcr65ihQku5LqagvyD0oTEa
         72TqOFzxkULY9V24crr7mynDGcBXxpCe1Nnwzxas4zr+j+8WmhBhHtLYyADYkWlOlYua
         VrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=yMoS29iTA682CqL5fMoldhYnScAFTc+8697an6z6GgU=;
        b=uJNB6jEJB0Gz/CYkeMwrVf0g7YMxnR3RTRXY+S4e7IatGhJACF/nfv16VKkixkNFfm
         YAjBHK/th1J6xHg42YdUDdroqW2LPQfwP96GvbSTcq3rjeRfCwx458yguZU+Q/1GtE7M
         8F5H+SM8JbtoOfv65eZl/PTzm3gvvSocZGcsf8eXZmgcMZ2HjCLG0kHrgC5bVtLXn9Ee
         5QcJh3kkFY66Pb8sE7UQLkWoeyNB7byyzabbQajP+X+BZDN6b+iVjeZM8ksEUefj9Qe6
         AAbBp+vsL58w4plVi0TE53MXBwxvHq+IW16mpCCOrMXF1GOC6CsRszQz9h56uJl9ILZd
         bDhg==
X-Gm-Message-State: AOAM531CC1QGIN9SB+4wLcBKP/lU8WRfFxiRM7AlvUqSwxsoOLRxfrDh
        BZRWag6Swpuj0LN4pr08wGuXP59V/q4nQQ==
X-Google-Smtp-Source: ABdhPJxvQGxS2C/IsQCPHgUy1YfQKAwoQATBYrim6NsViYfYDlxwzZ2bwWhxl/k4rJE3dx2riW70CQ==
X-Received: by 2002:a05:620a:16d4:: with SMTP id a20mr1165223qkn.410.1616199335117;
        Fri, 19 Mar 2021 17:15:35 -0700 (PDT)
Received: from kde-neon-desktop.orld.fl.wtsky.net ([208.64.158.251])
        by smtp.gmail.com with ESMTPSA id n136sm5610324qke.123.2021.03.19.17.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 17:15:34 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTERS
Date:   Fri, 19 Mar 2021 20:15:18 -0400
Message-Id: <20210320001518.93149-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When LATENCYTOP is enabled and ARCH_WANT_FRAME_POINTERS
is disabled, Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for FRAME_POINTER
  Depends on [n]: DEBUG_KERNEL [=y] && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS [=n] || MCOUNT [=n]
  Selected by [y]:
  - LATENCYTOP [=y] && DEBUG_KERNEL [=y] && STACKTRACE_SUPPORT [=y] && PROC_FS [=y] && !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86

This is because LATENCYTOP selects FRAME_POINTER,
without selecting or depending on ARCH_WANT_FRAME_POINTERS,
despite FRAME_POINTER depending on ARCH_WANT_FRAME_POINTERS.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 lib/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5a698fc34d56..59e78f1b3821 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1675,6 +1675,7 @@ config LATENCYTOP
 	depends on DEBUG_KERNEL
 	depends on STACKTRACE_SUPPORT
 	depends on PROC_FS
+	select ARCH_WANT_FRAME_POINTERS if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
 	select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
 	select KALLSYMS
 	select KALLSYMS_ALL
-- 
2.25.1

