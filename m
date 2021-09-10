Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B943407167
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 20:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbhIJSqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 14:46:06 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33210
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234187AbhIJSpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 14:45:36 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 25F444025E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 18:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631299458;
        bh=nEPszmF8/zXe3qLQaYBaJlARsp+rY7T/kVvjiAAAUv0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=ZIZaUm/D8QGgJv2u0iIzucqWSUI3EaCTPZPfj/LwTF6fb7jJC2enrF+klf3W6kpDm
         t1GqM4d1lyEGfH/HpQywTy4/XoJJgEip5YPwTIzfAjOzpf3hWfavEI2CT3l78xVFC8
         AJkr/Nkt2jziZezWYG0iPtPUbhMcpAQa6c8RXkdqAEJoF3kI1y7tjQ/qzlC8QAIf7r
         2AQXTTthb5paymD9CroH5RRWGyYncU5CgLpfMMdlHY+l7T5Zfqh597YzX0WeTW8qX9
         P9sgT4xTOXK5jB7LSCfx0EtHax7fD80iK+Yys5QaR9pzxo+M09RpDMskINqBMV6soU
         +kt+gMgeVroAA==
Received: by mail-pf1-f197.google.com with SMTP id r206-20020a6276d7000000b004365c6064fbso1543755pfc.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 11:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nEPszmF8/zXe3qLQaYBaJlARsp+rY7T/kVvjiAAAUv0=;
        b=z0wRLZyx04xSLuo8yMT4QjnjSIoR7yww8zPJFSIjiwMfQnE9II378jcJDwOcpPbHX6
         n8JRwsDWOH8QX14bq3JMlbPVTihlpys2XfHOMThJomC5QW2rOIe+MjUrtoRlyB74aF80
         ayg4XnygQwTwdcePl743ezCqk14oTqnZVw2JYEC5WK2NHP4tqm4bhrqGuBCW0wPNrfYo
         Rh393a7483kUwSoE9tUkh3KQeqg8BYUfXwn8VkAUoFmz3CHI+FLLQ1LPN0kBeRZXbIvV
         Tb7KaXJ2uzRYUa/D326sCkZKIHRUhD6miny4HqVOMlHZqWQnl5VN4+bTo4Wgcbzqk1pM
         P8Ag==
X-Gm-Message-State: AOAM5328ds6JzhM3PIZ+XNEbbTzPp92AVw0iU+QDUxZwL5tdhE4aGPb1
        LT9NeokFI1HYFG/fiaT0J/xNgyTmvvey0d1tLkfJPzw2VW7ReRLaj0NCb5gL0qDTLEzgt6AAJ3a
        AX+DKXkGEtk5crw330Y5iPm4ssUntPWnOnSCX+eXohA==
X-Received: by 2002:a63:5413:: with SMTP id i19mr8424327pgb.297.1631299455509;
        Fri, 10 Sep 2021 11:44:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXjj3Yk32lc4YcAVf/xRrgaUwwzlhuAeY6FGYPYZ0U0NH1J6Yk5syropXrQifRah2xDEqUrA==
X-Received: by 2002:a63:5413:: with SMTP id i19mr8424312pgb.297.1631299455191;
        Fri, 10 Sep 2021 11:44:15 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id l1sm5438825pju.15.2021.09.10.11.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 11:44:14 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     x86@kernel.org
Cc:     tim.gardner@canonical.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Balbir Singh <sblbir@amazon.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/smp: Unused value freq_scale
Date:   Fri, 10 Sep 2021 12:44:05 -0600
Message-Id: <20210910184405.24422-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coverity warns of an unused value in arch_scale_freq_tick().

CID 100778 (#1 of 1): Unused value (UNUSED_VALUE)
assigned_value: Assigning value 1024ULL to freq_scale here, but that stored
value is overwritten before it can be used.

e2b0d619b400a ("x86, sched: check for counters overflow in frequency invariant
accounting") introduced this warning.

Fix this by removing the variable initializer.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Nathan Fontenot <nathan.fontenot@amd.com>
Cc: Balbir Singh <sblbir@amazon.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 arch/x86/kernel/smpboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 85f6e242b6b4..c453b825a57f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -2166,7 +2166,7 @@ DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
 
 void arch_scale_freq_tick(void)
 {
-	u64 freq_scale = SCHED_CAPACITY_SCALE;
+	u64 freq_scale;
 	u64 aperf, mperf;
 	u64 acnt, mcnt;
 
-- 
2.33.0

