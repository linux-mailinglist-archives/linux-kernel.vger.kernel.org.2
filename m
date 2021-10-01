Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFF941EFDB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 16:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354604AbhJAOqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 10:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhJAOqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 10:46:07 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D49AC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 07:44:23 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id j4so4974371plx.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 07:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OrwI+1G/Gss3+VMz15ISVKMli2WYOzWcM/vEGb1Xumk=;
        b=ckejzGSZzH+3Bo4fswwZYcDFcARseZJdNbqbuwe8fPc3PD7RnJmK2+OEprjI/xubzo
         ZNbPQaojLdEeCA3VBK5x9Ky8B+w9lzocR5Lv75fn8EBvy7k4iUgR7cIhX0G8g0E2h9Nb
         bo3fqTHHQGCnd/j+5+TMTk/v7pf9U5QFdXWPVb4UYU1gnEHrfzHJPbNqgqZjJBTxOdIc
         efJXUXa6NvuilGCXjBN/qHgEDkePd2Jepj87bkGFAAeFWgd4aQVznN2AJ+V3riD7AKxj
         EnDcIuiGtS1iCMy5EiYJnRSFQL7Xv7LxV5UVQPfXerWYsMk9D+iX/uDkIKHASPVbNtYE
         3zNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OrwI+1G/Gss3+VMz15ISVKMli2WYOzWcM/vEGb1Xumk=;
        b=fDX4VPToA6W0V9LiqLcfWP+zg00itIg+3spmYnWi4ZWVPZwihBXkQAaRqU3DvmvW1S
         vS0n0iZ0yngc63Fl2FVS6ZvShNAyYrEwcQMQS4tnU9arWc/YkbDv9yPCrPeccyd5bi31
         qWeyJaWD1cT3jBRhSWOPwfR+4zlB2sGMsCWE3kDyO3Qqu8K7QbJV0MiDzTHIoz6AEUHc
         gXU6b5/ajlExg2raklEkcKA9EwjuZwhPVNXndO8zXS1hVdW3kqZ2rocr/zbG7e5YGhG+
         UdKv0j03gwBIYbpvFNVD3N5VxVeKpzXOtL+Gx6OrhvKCeiGI1yvrQNq2TFtdwq278fce
         7ABA==
X-Gm-Message-State: AOAM530jFQGGZCyt7UAITP/fWJb56mIxXIM5kvjvtUKqcxJyykbwXtfX
        a6CYJe5roD+vjJh7gwGr3Q==
X-Google-Smtp-Source: ABdhPJzDEJ19JcXUSL4AUXL4PYOgS4p63f9Mhnc+elBqRZXvUSmtwCcOxDZo6emhTGGhzQoTbmYVdQ==
X-Received: by 2002:a17:902:ab4b:b0:13e:932e:f65 with SMTP id ij11-20020a170902ab4b00b0013e932e0f65mr510659plb.58.1633099461514;
        Fri, 01 Oct 2021 07:44:21 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z12sm6766203pge.16.2021.10.01.07.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:44:21 -0700 (PDT)
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
Subject: [PATCHv4 0/3] arm64/irqentry: remove duplicate housekeeping of rcu
Date:   Fri,  1 Oct 2021 22:44:03 +0800
Message-Id: <20211001144406.7719-1-kernelfans@gmail.com>
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

V3 -> V4:
  address Signed-off-by in [2/3]
  improve commit log in [3/3]

V2 -> V3:
  Drop other patches and concentrate on the purpose of [3-4/5] of V2.
  And lift the level, where to add {irq_enter,exit}_rcu(), from the
  interrupt controler to exception entry  

History:
V1: https://lore.kernel.org/linux-arm-kernel/1607912752-12481-1-git-send-email-kernelfans@gmail.com
V2: https://lore.kernel.org/linux-arm-kernel/20210924132837.45994-1-kernelfans@gmail.com
V3: https://lore.kernel.org/linux-arm-kernel/20210930131708.35328-1-kernelfans@gmail.com


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
  arm64: entry: avoid double-accounting IRQ RCU entry

 arch/arm64/Kconfig               |  1 +
 arch/arm64/kernel/entry-common.c | 47 +++++++++++++++++---------------
 kernel/irq/Kconfig               |  3 ++
 kernel/irq/irqdesc.c             |  4 +++
 4 files changed, 33 insertions(+), 22 deletions(-)

-- 
2.31.1

