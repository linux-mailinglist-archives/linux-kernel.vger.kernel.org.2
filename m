Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EC332F8AF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 08:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCFHIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 02:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhCFHIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 02:08:24 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FF1C06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 23:08:24 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id t9so432390pjl.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 23:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vRX5BcDbO1qsCwks07rusX+ECpIqXv8UgJqy+IwhWaI=;
        b=Rq6s+83liy0OLaDZrHtTJdCCphjalsyx4bRE3/8hwuOeU+GmAvWd7GUP2XQULCN1jV
         kIDabykbZaA3+xVKZrRLc6nfgaCkcMKtmQwolsnD3WHErBC4YzCug20WI+2vlIlw8yew
         hK42LWQcVKrQrTcaIXcGYk8syWJN2kZLHoNPPiRc1zP3Nxc09ghMaeLi4nUddqJueYcR
         IBr62cEnV+LpcmHpkToqFriEIGboEpLnV5+uH8eC94jDQIw0D/heeLn7qQTaS6/mhjyv
         A/0kj1F93JXcCaBMe0mp3EsxKQZR3KWql4+/oHAz0GPgmuuXIO/zSbba3nxzdj2mtJjM
         r9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vRX5BcDbO1qsCwks07rusX+ECpIqXv8UgJqy+IwhWaI=;
        b=cQMP6kKGj0Z32EIcPAImnq+R6ODN+fBNT2daDkTBySAcFamE4xI6qJAiNwUm6yA7Bp
         xyIWfkYj0dHOyeeUQI2oZn3yk6qKHN5MVA/oqHSbk7g7H6jcuPScH7+oQsUbydqwtQ70
         aykrENBLO+s7NYhOMCOX8UMdrQ376LNbqHRuN9U5wPZYLSpeEt3WECoHcbyVP0Ch5du1
         xY9n9OxUd3ofM52VXCEpUWBoD9dRrPgqJEJe62lEaYNyiT7JzEujGh/+C/7sDCqWn2/1
         tj2vmyPpVYdEcF4br22u3ud1iZWJviXY2+CZBJFGCeuTybI2T7t6v89UPL9EleNUlmAC
         Ir3Q==
X-Gm-Message-State: AOAM532ZSA5dsUKiQcKUHu2j8jmGStfZPafN3hUT7lsWGMBx0pR2/RLQ
        jCvnmFzLwhDkuBdcK917na0=
X-Google-Smtp-Source: ABdhPJyt/HVPXADQI4enScrZjB8VtCJwaRUKHetDoTK1deVowT4fUUW7Go3sSoQRzD8ucbkL2NRfAw==
X-Received: by 2002:a17:90b:508:: with SMTP id r8mr14488265pjz.83.1615014503800;
        Fri, 05 Mar 2021 23:08:23 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id w4sm4208610pjk.55.2021.03.05.23.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 23:08:23 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     mingo@redhat.com
Cc:     tglx@linutronix.de, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, luto@kernel.org,
        alexandre.chartre@oracle.com, jroedel@suse.de,
        linux-kernel@vger.kernel.org,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>
Subject: [PATCH] x86/traps: remove duplicate include in traps.c
Date:   Fri,  5 Mar 2021 23:08:16 -0800
Message-Id: <20210306070816.212276-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'proto.h' included in 'traps.c' is duplicated.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 arch/x86/kernel/traps.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 7f5aec758f0e..cb9b675dc003 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -61,14 +61,13 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/vdso.h>
+#include <asm/proto.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
-#include <asm/proto.h>
 #else
 #include <asm/processor-flags.h>
 #include <asm/setup.h>
-#include <asm/proto.h>
 #endif
 
 DECLARE_BITMAP(system_vectors, NR_VECTORS);
-- 
2.25.1

