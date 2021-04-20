Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659AB3650B4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 05:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhDTDPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 23:15:53 -0400
Received: from mail-oo1-f42.google.com ([209.85.161.42]:34575 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhDTDPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 23:15:46 -0400
Received: by mail-oo1-f42.google.com with SMTP id m25-20020a4abc990000b02901ed4500e31dso1216480oop.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 20:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=atv698prrzRKobGKWx+VS0Z9kUa/dGuy8qNtepCjWQk=;
        b=egU/dpHKRh360XltovufluZhevt6vI1XphRrC2Ht52rj6kkak/kx5hkcikduP2qlYn
         XgyCKyIMVAoodfjF4QBIP43jX+fkXZyQl8musIkxLrwCMEiAEIfpfNtbe2PdhdNQ0N3W
         uTV9rZ/kdKGw16ufwG8ZDT4FUEo+ZrTGFrMqko9pWpLj9pTj4zrC2rDFqgGwjuO2EZjX
         S0dwXVhQe8v8ZL5eGp33ClwsV5syFJO269TmvkZHsf556ry8nCXNvHntH7tLR8LoH0tS
         BZJunORR53H61i4IP8Ucs31Ep0b065ryth33K3/z80Ib47edUVUrSCHh3qsfA0WsZXkf
         kPdA==
X-Gm-Message-State: AOAM530vs9HdAIkcKl9n/1c5oOxT7SuVRbqeBG4zDXENeAcmOJAW1ydn
        LYDf/ZdXCLUMqKCBopqzAw==
X-Google-Smtp-Source: ABdhPJxPsn5ty5wJnfRDFyFSuBfPSklEyWGXQ6m5lEUWAlmHo9u5vYIOYHMgboaKIHzAS8DxPyk+Xg==
X-Received: by 2002:a4a:8e18:: with SMTP id q24mr7680291ook.66.1618888515838;
        Mon, 19 Apr 2021 20:15:15 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id g16sm2347896oof.43.2021.04.19.20.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 20:15:14 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/9] arm64: Restrict undef hook for cpufeature registers
Date:   Mon, 19 Apr 2021 22:15:03 -0500
Message-Id: <20210420031511.2348977-2-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210420031511.2348977-1-robh@kernel.org>
References: <20210420031511.2348977-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

This commit modifies the mask of the mrs_hook declared in
arch/arm64/kernel/cpufeatures.c which emulates only feature register
access. This is necessary because this hook's mask was too large and
thus masking any mrs instruction, even if not related to the emulated
registers which made the pmu emulation inefficient.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v7:
 - Split off from Raphael's original undef hook patch as this change stands
   on its own.
---
 arch/arm64/kernel/cpufeature.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 066030717a4c..aa0777690ab1 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2888,8 +2888,8 @@ static int emulate_mrs(struct pt_regs *regs, u32 insn)
 }

 static struct undef_hook mrs_hook = {
-	.instr_mask = 0xfff00000,
-	.instr_val  = 0xd5300000,
+	.instr_mask = 0xffff0000,
+	.instr_val  = 0xd5380000,
 	.pstate_mask = PSR_AA32_MODE_MASK,
 	.pstate_val = PSR_MODE_EL0t,
 	.fn = emulate_mrs,
--
2.27.0
