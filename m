Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6882D4556CA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 09:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244421AbhKRISi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 03:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244468AbhKRIRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 03:17:15 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085CBC07978B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 00:11:46 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id p3-20020a056000018300b00186b195d4ddso868510wrx.15
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 00:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TQFyZU0v42DaaTkISoD0OFzde9Hlzhfr9CYPS/61CiQ=;
        b=MK2Vd4YjbDEaS4uhhlqIaoDY1M9QXC49+u0npJjk0pQSVRSj0R2jfpTqwJGYkXnYSg
         ZMtPSof/yRprWktVdqMYdgvpsVx6ZQUJJlLswELGAWRPazAPzMqcizSADthjnvISCsuN
         /n1yMdNWCSSQe2mO5WLugpNZDLHdOT6248Xx5n1W5CcPt4s0I0N5GiS0akJuVV/JlMwC
         vzeF/+kKiT40V3zbMU+Jhl/QbcW9Gh/U1jQOICERskGk3AtIhxav51zndyo0kpWy7FEb
         Dj7/2yy2mXXUxZaZEH0RM4+WkS7peFjxGJKnqohDrxd/HtH85/+daZm98XnnlX/gUBIf
         7yAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TQFyZU0v42DaaTkISoD0OFzde9Hlzhfr9CYPS/61CiQ=;
        b=sEscVZLAFN0c3AQp1V1xqOg3csN7IgJy7zO4f/x8yZcHDEtdwFCDY7Y20ccc14pqpY
         R5mj5TNoex0KZJxFXUXflACLl3PSR2jEx1xDUCBMBCFw16L0RqRr4pxBnth7WhAweDIQ
         Ly7vAKqMrvmIzpZ/xV8ImtwBo+rMnIvgBXQLG2/AZo4VQpLxOtTAmJLM0gxvz7dLgUSY
         Sv6ITKsQFFkkaE8R70HF5inIcjSwYDZdGmglkYNCLUdrB9NGit6DcQryHs9DBTv30O5M
         dSIhpsmX2nu4q60AlicwuMIPCJI1yMeX70eDzs3k8KPZa75P/aB4q9+W0smp9iYho9st
         brmg==
X-Gm-Message-State: AOAM532nCtMEjkjOykYe/QyTkQ4X3lPSzWJDjFhwE6UG2ffMs971rwYQ
        JF1W9WTxk5KiTxQNIT21RyVOyPgrJQ==
X-Google-Smtp-Source: ABdhPJyYeDMuiGGrUuyFw2pju3cXA4aPKZm0z0EkkEKVPp8TQ9/6cOOcc4ejq3nzYH027uUD8CjFPxhEPw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:7155:1b7:fca5:3926])
 (user=elver job=sendgmr) by 2002:a05:600c:1990:: with SMTP id
 t16mr7680724wmq.48.1637223104386; Thu, 18 Nov 2021 00:11:44 -0800 (PST)
Date:   Thu, 18 Nov 2021 09:10:23 +0100
In-Reply-To: <20211118081027.3175699-1-elver@google.com>
Message-Id: <20211118081027.3175699-20-elver@google.com>
Mime-Version: 1.0
References: <20211118081027.3175699-1-elver@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 19/23] x86/qspinlock, kcsan: Instrument barrier of pv_queued_spin_unlock()
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PARAVIRT_SPINLOCKS=y, queued_spin_unlock() is implemented
using pv_queued_spin_unlock() which is entirely inline asm based. As
such, we do not receive any KCSAN barrier instrumentation via regular
atomic operations.

Add the missing KCSAN barrier instrumentation for the
CONFIG_PARAVIRT_SPINLOCKS case.

Signed-off-by: Marco Elver <elver@google.com>
---
 arch/x86/include/asm/qspinlock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index d86ab942219c..d87451df480b 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -53,6 +53,7 @@ static inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 
 static inline void queued_spin_unlock(struct qspinlock *lock)
 {
+	kcsan_release();
 	pv_queued_spin_unlock(lock);
 }
 
-- 
2.34.0.rc2.393.gf8c9666880-goog

