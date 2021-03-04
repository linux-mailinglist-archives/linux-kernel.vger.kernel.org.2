Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB7E32CBA9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 05:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbhCDEvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 23:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbhCDEub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 23:50:31 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E110C061574
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 20:49:51 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id b21so18094654pgk.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 20:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z9XcVy6AJTokIzTljF0EFRLCvXqasp1w3tskzqtsRk4=;
        b=LJzlu1eACs+yu7D22SxzqAvbQTTf4LAtrRt/ALmphbrNE41CSxb/XjQevN0zaJ0KTl
         NAcSuPj5r2p/jrgVJiGZsAGkjm6KzzCu11Do9yXIiJc5fB/vQDTQGIMHTgBy4MWb3n7U
         m5+350HJtNS0VhfaMtfdotbbHebO0ufp8TojtSfe5MkegdsD/GW6pPMtvKBEC0GFZvJl
         EMqmKMb6FPIMrJ57B+Uq3jqPDCWtYL//V/yyZqXl95SqnkIZo451kB2KoS/ij45QU6QW
         iCcJk70vXHAH96B4hRlzq6DHYF15szNy+8y5I3y2EuZxSPzA0r3eDcsxc65T9NH5n4Tb
         Gqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z9XcVy6AJTokIzTljF0EFRLCvXqasp1w3tskzqtsRk4=;
        b=NKV+oSONwvGLDnH2RZFdgXAXMIYAYVVTmFOHxuYQ5qucCrnJp/mNMCcWcMcbK/RbUd
         UgXffrOFRvycPIf0AvCpyxclEn+JAWWjQF9EBo0aFXToYXYg4qqW1lCQvnl/K1wzm6OQ
         7v78FJuk0v/EbTSuJf3P+JKEgyGdx1oDmFygjyzUqeZ4IzLpnWeJ65UAOdEbjArtai0i
         DDq0KMj9e5wyxHfKO0db2HXpsFXwjOhL596Nkt4hLBBMIIPrz6RAjrb4r7n6Miw7koqH
         +Pom8VyInuuaOD4VASjehfmRs8kBJy/7mtNj3YFA5Vt4GHdkn9uHtZkluB0XsK3Nygha
         raQA==
X-Gm-Message-State: AOAM532zHxYU87xUhfYKAhb51X7ETjjRw2plgKp9dxFfiqO/4qyQLZ0T
        CcRr3hxH/HLQCJds+pnVE+o=
X-Google-Smtp-Source: ABdhPJzzlPflua+YuDG5NPzQvi4HwYJUunChRht3+FWKm6EVAa8quJ9p90kR3WPEmIw0jqWWIInq2Q==
X-Received: by 2002:a63:1648:: with SMTP id 8mr2177585pgw.392.1614833391144;
        Wed, 03 Mar 2021 20:49:51 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id a2sm25736950pfi.64.2021.03.03.20.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 20:49:50 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     npiggin@gmail.com
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@csgroup.eu, alistair@popple.id.au,
        jniethe5@gmail.com, gregkh@linuxfoundation.org,
        peterz@infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>
Subject: [PATCH] arch:powerpc:kernel: remove duplicate include in traps.c
Date:   Wed,  3 Mar 2021 20:49:43 -0800
Message-Id: <20210304044943.190613-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'asm/tm.h' included in 'traps.c' is duplicated.
It is also included in the 62th line.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 arch/powerpc/kernel/traps.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 1583fd1c6010..dcdb93588828 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -53,7 +53,6 @@
 #ifdef CONFIG_PPC64
 #include <asm/firmware.h>
 #include <asm/processor.h>
-#include <asm/tm.h>
 #endif
 #include <asm/kexec.h>
 #include <asm/ppc-opcode.h>
-- 
2.25.1

