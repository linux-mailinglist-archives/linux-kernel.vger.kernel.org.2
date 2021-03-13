Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56EB339D98
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 11:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhCMKfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 05:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbhCMKf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 05:35:28 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790FEC061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 02:35:28 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id c16so13110145ply.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 02:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5alkhG7madVT5CO6sGwFZx6RfbdRHXlvC4SZwRdQrmc=;
        b=nbfvvfvoKIXgMLp/lRtsLVACQqnTqpKXddy0DU+sRi0MqxR6z/7KTsvkTmqQiO1vtZ
         FMCrxdxfV9R7fvAm2pCUJLGi8GXDIpcADubBkuUWre6nfCPnWMm7AdV8ObmakQFsBNQo
         BPtmY4jsSlZ5owMOnaDAyRZ3sSO0kILcfzn2NhfVf0IrDJLYm3+We17yxL6v+VuUi5G6
         o+K3twlqDb77Y1N0oYZUqoxNWRu7rXXIu2V7m0INBaS7oF7vdpkOh5EtIO5tGwt2qhqA
         uL9eM+/wwmQ5K1vEAJI+qBLmX/Bb0NkCxvFYQwbOrrx4Fg2PsFk47xZJmGILRhQ/ovmI
         KxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5alkhG7madVT5CO6sGwFZx6RfbdRHXlvC4SZwRdQrmc=;
        b=e9lZIxLxlDSRIPxEgpvERNaURB+ZgEa4Be5dY/QTrQuASl5GHCBKLB32XY4vRGPrOv
         AvPFfXbtumcNKW3JKhs3/22gnyWf7xgHLbSOKGJFAdxc+nswmJzF/aAmgfTFslgdDns5
         T9noAgJTB1CIjmHfGN5SmlAxkAshB7RpmtYeoccaOCCbaukFzjRcsamQZOGdwW6mph11
         7f0WRDC9vDyfNKLeTQy001lHmnLB5BJd1QsryV3Mf0uG1FoRNTOMqxw8A3u31RMn7m/0
         Ahed36r/Dekhiw/Im1IfQZ9CGAGk50GnlhBIOTrXhsfhvZVbsjmjgJl8uEWpNFknocKS
         5aqA==
X-Gm-Message-State: AOAM532KsZx42lMeko+BC174eQkjMRT4RNAq50exs8ViQTUjZunW90eg
        KHxPgGgkP64KaI6molLe/14=
X-Google-Smtp-Source: ABdhPJxAHABUpXWXFt092ShImwcpkF+h/pd6VfNL7IYaUOd9BWpDl3NxeJnKvPi5nlGibxaXs9xr/Q==
X-Received: by 2002:a17:90a:c909:: with SMTP id v9mr3056541pjt.218.1615631727769;
        Sat, 13 Mar 2021 02:35:27 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id x11sm14096555pjh.0.2021.03.13.02.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 02:35:27 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     dyoung@redhat.com
Cc:     bhe@redhat.com, vgoyal@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>
Subject: [PATCH] crash_dump: remove duplicate include in crash_dump.h
Date:   Sat, 13 Mar 2021 02:35:21 -0800
Message-Id: <20210313103521.364854-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'linux/pgtable.h' included in 'crash_dump.h' is duplicated.
It is also included in the 8th line.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 include/linux/crash_dump.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index a5192b718dbe..6bd8a33cb740 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -8,8 +8,6 @@
 #include <linux/pgtable.h>
 #include <uapi/linux/vmcore.h>
 
-#include <linux/pgtable.h> /* for pgprot_t */
-
 #ifdef CONFIG_CRASH_DUMP
 #define ELFCORE_ADDR_MAX	(-1ULL)
 #define ELFCORE_ADDR_ERR	(-2ULL)
-- 
2.25.1

