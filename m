Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC2E422473
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 13:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbhJELDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 07:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbhJELDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 07:03:17 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE8BC061769
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 04:00:29 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id f11-20020adfc98b000000b0015fedc2a8d4so5623658wrh.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 04:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DahfAT1Q5cTf5jxzmYjgaD95bFaAqh3xNJSBaROtoZ0=;
        b=lZfIqlUUqz7u5X/s/XmXxONKoH9HGZb4q0bpmoH4oihbA1XE3i5nHsIkL+hhCtJY3V
         gvIsY4OWMufkNrB7mXwRc/5nRf82JskqH8iyqHsmDzenzSo5P9uZ25rWIHXuKezfeurA
         B74KPFJzmNJFKW7vg3RQDckzc/MhOSxFUgw2zBgmiDHU3+6zwQIJVSxRK/TWkrJ4haeu
         ywrJxCJ3JEFT5zH9aUCCBMUsDT3e7OW0ae9Urmv2YygyzamAKu3iAJNUfU2O0AIeIRRr
         7x7Gtk3YUtwPTPnoUXRcFSZRNAMXe8e7SjzOqwOs9ulzJpZAGRgyV4tIO2+HucspCIGw
         JA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DahfAT1Q5cTf5jxzmYjgaD95bFaAqh3xNJSBaROtoZ0=;
        b=XALVTchOGBoJ+0SPUnR/vKx5AgoAfv2WpCF2r8+sI8yBgzgoyt+Utx+nBWHheIR4QD
         Gezdb1yy/ltgh3UuXBV5ddCmviMKhpm8mMPJozRm20KKof4aZczmISlMfRZCVhxVE3Eu
         Lj9XC0g/Pj07AvvMf7/gQVgn6zfhX3lrd1iWG7aK7bJKSnQPviCBYl4sr4x4zbpsIgMU
         1WCH8UelU83LxUWqzhtLlQ220CpmSei251HUXFlB5p4ySK1u1j5VEENale5XalHIPZPy
         uMr3EmqySAXiq1AJF8y3Tnj0lK6vGYpJzaodGVa8jk0yAUVpL1IochfVdtKiLWBz1SQ7
         l24Q==
X-Gm-Message-State: AOAM531cRDEB+IwNFhyRx/UkTQsPJTDPqoKW7yNapcAfDn5oqG8+/wk+
        bnmCg17xJU7XikJA7efRNH2+6wkLjg==
X-Google-Smtp-Source: ABdhPJxJAoPskpWSnMop/lTO76OUSxjnhmwBrh54jf8LKDoRw6BSA+ERe7cvgmB0awg4h7LA7Ty/9GLR1g==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e44f:5054:55f8:fcb8])
 (user=elver job=sendgmr) by 2002:a1c:ed0a:: with SMTP id l10mr2762058wmh.140.1633431627680;
 Tue, 05 Oct 2021 04:00:27 -0700 (PDT)
Date:   Tue,  5 Oct 2021 12:59:01 +0200
In-Reply-To: <20211005105905.1994700-1-elver@google.com>
Message-Id: <20211005105905.1994700-20-elver@google.com>
Mime-Version: 1.0
References: <20211005105905.1994700-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH -rcu/kcsan 19/23] x86/qspinlock, kcsan: Instrument barrier of pv_queued_spin_unlock()
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E . McKenney" <paulmck@kernel.org>
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
2.33.0.800.g4c38ced690-goog

