Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7894175E0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346308AbhIXNeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346546AbhIXNe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:34:28 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E821C08E8A8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:28:54 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 145so8868213pfz.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bp1QhDTRs5+iIrkEymnf+wtmNaVnCHkCBBZigTiyxqc=;
        b=DjZI8Pwzt3OkpHorB5kvWv1DXeyXMYWUeeLxJvzd8WvJrGtWMX6Y0HAisoL8YjwC7e
         13DBSmsAg4r7wJlUkJD68+Pb+1Do3sirrcn1fP19PLRNUfPfXTXu2Gd+Sl2k5NVnPG8o
         cOjByLZK9sIZ6XgFGuVxSB4grcruSsHmjXSInYwqwV8XZmKmh3gXZvDKT3it/1ucDXE5
         CMkNH7DoR0Gz6JrLlgZgd7wkk2k7dBqN94orz0MDp67GWF1J2SXTeAb+PFcFZPcFrgmj
         6Gp3RfXz5Zg+KaAoJFYNNX3++ga0JEbxajTDVOjK6ue5wsezL84mgKpZedjRBtu/tLKt
         ed2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bp1QhDTRs5+iIrkEymnf+wtmNaVnCHkCBBZigTiyxqc=;
        b=I6pu1Xvx5Q+RmY8xbGexwkTBT7kL5uCFVyD1Og9ZTsx2mwp+XbLCRBM5nc9c4SpGPb
         naMArvJhq18SAC60Ie92ZG60FFwyc+hp4SveiM3P4sDff0ygwJ/r9S0LTbP+5x0fZ+1s
         IfUg3Vz7OjcZQKI8WNBnLRnNB4dZH/QYDfxJAERR9vQUkXwlR2pwBeUhOCuouhWiAOQt
         1tEVuQiTFwsAfju771+zTessbW3iaQMowOQEzAAoBz1t5FHYsN3ZR3c0xxBMud3n5nNY
         3mjHUOB2mz4DmODiltuWj6pOOoZSkoiC86DmJeWTML/GwP2CHbr5F21ZECeLMZ/AJQaP
         lnrQ==
X-Gm-Message-State: AOAM5327mKp3XIpSYt3FQvfOSGGuL0w/+8ufoVMdc6ZDPj19xqhB1BZ3
        rdkiFPEZHWNxTT210NrM2A==
X-Google-Smtp-Source: ABdhPJyEtAq+e5WMvP9Nyi+DR0/To34+31ApTR0KVDKgfaJeXLAi6DKATboOAWu95m16Gi4O6bvBZA==
X-Received: by 2002:a63:f050:: with SMTP id s16mr3793900pgj.258.1632490133628;
        Fri, 24 Sep 2021 06:28:53 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 26sm11756573pgx.72.2021.09.24.06.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:28:53 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCHv2 0/5] arm64/irqentry: remove duplicate housekeeping of
Date:   Fri, 24 Sep 2021 21:28:32 +0800
Message-Id: <20210924132837.45994-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After introducing arm64/kernel/entry_common.c which is akin to
kernel/entry/common.c , the housekeeping of rcu/trace are done twice as
the following:
    enter_from_kernel_mode()->rcu_irq_enter().
And
    gic_handle_irq()->...->handle_domain_irq()->irq_enter()->rcu_irq_enter()

Besides redundance, based on code analysis, the redundance also raise
some mistake, e.g.  rcu_data->dynticks_nmi_nesting inc 2, which causes
rcu_is_cpu_rrupt_from_idle() unexpected.

Nmi also faces duplicate accounts. This series aims to address these
duplicate issues.
[1-2/5]: address nmi account duplicate
[3-4/5]: address rcu housekeeping duplicate in irq
[5/5]: as a natural result of [3-4/5], address a history issue. [1]


History:
v1 -> v2:
    change the subject as the motivation varies.
    add the fix for nmi account duplicate

The subject of v1 is "[PATCH 1/3] kernel/irq: __handle_domain_irq()
makes irq_enter/exit arch optional". [2] It is brought up to fix [1].

There have been some tries to enable crash-stop-NMI on arm64, one by me,
the other by Yuichi's [4].  I hope after this series, they can advance,
as Marc said in [3] "No additional NMI patches will make it until we
have resolved the issues"

[1] https://lore.kernel.org/linux-arm-kernel/87lfewnmdz.fsf@nanos.tec.linutronix.de/
[2] https://lore.kernel.org/linux-arm-kernel/1607912752-12481-1-git-send-email-kernelfans@gmail.com
[3] https://lore.kernel.org/linux-arm-kernel/afd82be798cb55fd2f96940db7be78c0@kernel.org
[4] https://lore.kernel.org/linux-arm-kernel/20201104080539.3205889-1-ito-yuichi@fujitsu.com

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


Pingfan Liu (5):
  arm64/entry-common: push the judgement of nmi ahead
  irqchip/GICv3: expose handle_nmi() directly
  kernel/irq: make irq_{enter,exit}() in handle_domain_irq() arch
    optional
  irqchip/GICv3: let gic_handle_irq() utilize irqentry on arm64
  irqchip/GICv3: make reschedule-ipi light weight

 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/irq.h     |  7 ++++
 arch/arm64/kernel/entry-common.c | 45 +++++++++++++++-------
 arch/arm64/kernel/irq.c          | 29 ++++++++++++++
 drivers/irqchip/irq-gic-v3.c     | 66 ++++++++++++++++++++------------
 kernel/irq/Kconfig               |  3 ++
 kernel/irq/irqdesc.c             |  4 ++
 7 files changed, 116 insertions(+), 39 deletions(-)

-- 
2.31.1

