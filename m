Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9374434AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 14:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhJTMHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 08:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhJTMHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 08:07:23 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B2EC06176F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 05:05:04 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id q19so2786671pfl.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 05:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=waYD8dsvUPs/3L1638bXCQkgi6UBgjkYBImUZ1krvko=;
        b=IPB6vWRptmpwaKLEJ2X1nkyazjjUtdTq5CkxdHOjuBZhT/HfwszGKGLZSkLoLYq0R5
         ztf2MLxBp40XOAYLBCWmO4AK+rH0/qqbhm4tJLLEASl582myoqUsTP0DfzoqHWybF3i/
         7j+Z09yo9qBg9ov5T9IFPSKwM5D7QkuuL7muY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=waYD8dsvUPs/3L1638bXCQkgi6UBgjkYBImUZ1krvko=;
        b=z7NL6HpNrCox4rksWGf+AjEbAYva7cQzZlQ1nPeqgisDgbFbNWxlqWZSYnkA+xoCs5
         ZZK36uSt6kqNQyMli5zhg0VTvPSXwcN4jlCjq0iygAsRIpXHIyOKL4UIACHv7jOKNk/G
         oemYM/IlFZE6yG97A7q9Jp25Ve7wn98qDVrvSgdUKt23crCAOtDH7K+mcPf/2S5M1qYN
         BwXbSuf0i1T91Ks4/k0DbkvWhRPK4ySWFG3ubePCMSwwhIQkNrS0XLEUHciB9KK2V2YK
         zN8drhIJ3ZBnzvVokwL0dOKEzGjSzOdst9p+6s+ar/iaj27nkseM9eK83fvnnQ2N4rBI
         lpLw==
X-Gm-Message-State: AOAM533p/bdzUybqqIN7HS7vwb1hG0eb4iL9NPTuVBd0N4+70aSjp4St
        wigJ4+yvqbDndjrjvbAW1zrzUW2boE+Wzg==
X-Google-Smtp-Source: ABdhPJyAa/wmxbz/aUVIPHp/LNEJI1zHjIqTNYybV06ibBEmD12XdN3Ms4lEYjUO9FXnD0ifkyqlBg==
X-Received: by 2002:a05:6a00:1916:b0:44d:b930:df4f with SMTP id y22-20020a056a00191600b0044db930df4fmr5921135pfi.39.1634731504152;
        Wed, 20 Oct 2021 05:05:04 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:e516:d575:e6f:a526])
        by smtp.gmail.com with UTF8SMTPSA id z11sm2424576pfk.204.2021.10.20.05.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 05:05:03 -0700 (PDT)
From:   Hikaru Nishida <hikalium@chromium.org>
To:     linux-kernel@vger.kernel.org, dme@dme.org, tglx@linutronix.de,
        mlevitsk@redhat.com, linux@roeck-us.net, pbonzini@redhat.com,
        vkuznets@redhat.com, maz@kernel.org, will@kernel.org
Cc:     suleiman@google.com, senozhatsky@google.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Hikaru Nishida <hikalium@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        x86@kernel.org
Subject: [RFC PATCH v3 2/5] kvm/x86: Include asm/pvclock.h in asm/kvmclock.h
Date:   Wed, 20 Oct 2021 21:04:27 +0900
Message-Id: <20211020120431.776494-2-hikalium@chromium.org>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
In-Reply-To: <20211020120431.776494-1-hikalium@chromium.org>
References: <20211020120431.776494-1-hikalium@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include asm/pvclock.h in asm/kvmclock.h to make
struct pvclock_vsyscall_time_info visible since kvmclock.h defines
this_cpu_pvti() that needs a definition of the struct.

Signed-off-by: Hikaru Nishida <hikalium@chromium.org>
---

Changes in v3:
- Added this patch.

 arch/x86/include/asm/kvmclock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/kvmclock.h b/arch/x86/include/asm/kvmclock.h
index 6c5765192102..9add14edc24d 100644
--- a/arch/x86/include/asm/kvmclock.h
+++ b/arch/x86/include/asm/kvmclock.h
@@ -4,6 +4,8 @@
 
 #include <linux/percpu.h>
 
+#include <asm/pvclock.h>
+
 extern struct clocksource kvm_clock;
 
 DECLARE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
-- 
2.33.0.1079.g6e70778dc9-goog

