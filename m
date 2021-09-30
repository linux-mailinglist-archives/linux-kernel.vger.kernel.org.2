Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220E941DAD1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350857AbhI3NTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350866AbhI3NTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:19:19 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBA9C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:17:37 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id rm6-20020a17090b3ec600b0019ece2bdd20so4772382pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+fGUHUny1dnqCh4cK/3bY76s0DaNu1CCpvmKY7qLA9w=;
        b=KYl65inEHkVzQxgTDgLFF4qybr2aei25/bK+XCw+F+bwkBOp2BIzmZ0JaLesk6BZgY
         kAWZaMVqgQawvoJF9/q/OF9Wg6d1mUqYCo9TOTt1J8uj9pWbgrweD9VgLX6PhlKi7A31
         k1GHr4vHgaZ2FuDTLb4uV53S3vZpbkD0756hjLSQQ5/43kJMuH64/sfhwEDzi5N75DS7
         UgmkrR4HW4JW3D6G4q+EkSS0fLuP3OjW/QGACC9RMbCv1snLqso/3udC9xMeUCk7HHpy
         nadNQ5YBOqw8tmROhm7+N6AZC+EPEAFvVkxZebpiC7wCIxRIUk0Upe6I5dLhhSguXYs0
         /BRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+fGUHUny1dnqCh4cK/3bY76s0DaNu1CCpvmKY7qLA9w=;
        b=PrV9/6SYtHCGAk56QOvtia1bTmbjUy0VljtOIaZqUpdlUWM3zMXykm8fkfXcRgGGe6
         S/3C5vkjIDq8Jh0ChiuSoAFV6zEVpF3OOm3kCI0jTfRUOohZIjddIjc4ZGeAyzkBFnug
         JYlPKdHO8gx2j7GTlHvZYG2etiyxEpclVDSA1oXke4EHHs7/G+spjj0FnEME1H7sayVy
         v+36aCWfFnJWC2WkotOeDflZxADnZBWC6lU/3yDOMMVTCRhjpItFkJO4YfIEqwqGpr/g
         TO6zH4pHoyVM6TI3v+MeGei0WDHfVwLM6EJfBxwAzqqEXH+S6c69mPzbihvatUgqe5vD
         bgkQ==
X-Gm-Message-State: AOAM530V43WccNt0R8W5o0MUse57qdmA9/qXko+pTfOc7xZfnmvAVYFU
        I6U9v42sSLoyqa96pvkpFg==
X-Google-Smtp-Source: ABdhPJyX00G5w4leTEyLGDW9uTa8J4BNfFDvDwvL1ndiv78iXZ1MsJKVXB//68Zv7JN1nH6qLLXLwA==
X-Received: by 2002:a17:902:7297:b0:13e:6650:a4ca with SMTP id d23-20020a170902729700b0013e6650a4camr4154634pll.37.1633007855676;
        Thu, 30 Sep 2021 06:17:35 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q3sm3083167pgf.18.2021.09.30.06.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:17:35 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCHv3 0/3] arm64/irqentry: remove duplicate housekeeping of rcu
Date:   Thu, 30 Sep 2021 21:17:05 +0800
Message-Id: <20210930131708.35328-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an IRQ is taken, some accounting needs to be performed to enter and
exit IRQ context around the IRQ handler. Historically arch code would
leave this to the irqchip or core IRQ code, but these days we want this
to happen in exception entry code, and architectures such as arm64 do
this.

Currently handle_domain_irq() performs this entry/exit accounting, and
if used on an architecture where the entry code also does this, the
entry/exit accounting will be performed twice per IRQ. This is
problematic as core RCU code such as rcu_is_cpu_rrupt_from_idle()
depends on this happening once per IRQ, and will not detect quescent
periods correctly, leading to stall warnings.

As irqchip drivers which use handle_domain_irq() need to work on
architectures with or without their own entry/exit accounting, this
patch makes handle_domain_irq() conditionally perform the entry
accounting depending on a new HAVE_ARCH_IRQENTRY Kconfig symbol that
architectures can select if they perform this entry accounting
themselves.

V2 -> V3:
  Drop other patches and concentrate on the purpose of [3-4/5] of V2.
  And lift the level, where to add {irq_enter,exit}_rcu(), from the
  interrupt controler to exception entry  

History:
V1: https://lore.kernel.org/linux-arm-kernel/1607912752-12481-1-git-send-email-kernelfans@gmail.com
V2: https://lore.kernel.org/linux-arm-kernel/20210924132837.45994-1-kernelfans@gmail.com


Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org


Mark Rutland (1):
  arm64: entry: refactor EL1 interrupt entry logic

Pingfan Liu (2):
  kernel/irq: make irq_{enter,exit}() in handle_domain_irq() arch
    optional
  arm64/entry-common: supplement irq accounting

 arch/arm64/Kconfig               |  1 +
 arch/arm64/kernel/entry-common.c | 48 +++++++++++++++++---------------
 kernel/irq/Kconfig               |  3 ++
 kernel/irq/irqdesc.c             |  4 +++
 4 files changed, 34 insertions(+), 22 deletions(-)

-- 
2.31.1

