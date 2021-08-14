Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405193EC4CD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 21:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhHNTsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 15:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhHNTsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 15:48:08 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4053EC061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 12:47:40 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so16213252oth.7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 12:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=R5W1avi0Vu7q22jVMIZ1+XIxbrfaXvfKDwBKLBanzQM=;
        b=JHu7tpUel4PZhJCkpUlmwqp4aKb+ze46BdOpmv6q4LcfY5Rm/2U4R5yGel/AE+AVTK
         DuxTjM3CSXVZn3C3fBw6tFoXEAoJnhwD4D0WJT8rV1EZYmyq67gU40hDIoATSsRDAwNQ
         mSMe6ibbm11JJLhRHDmaBh/2dYpzOQLYcYmHlz+qnJgUKBg/usEPi5zE5Qp2RqC/BZCk
         F7daq5gKxwWFtj+V5Ad4HpKev4JJFdP88t7fKY/92jP+fZyRLOstq2LdFAxpCgByAbb3
         leOBJVjlrjB9dXZO9Rc1KuLcMOvbhPwC4vgyGZEaq4jdm86HevNtR1OYJN20OaVPY5DK
         odng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=R5W1avi0Vu7q22jVMIZ1+XIxbrfaXvfKDwBKLBanzQM=;
        b=TA/E0/IE+1Rg+pca5FI/giItlMPoelxCqcgfHzSI92bLvvgzx2wjQwicd2zCEzly81
         cdNonRXzGUq+j3KAVpenlvRhsPb243jIjGHPbGRkxE9mOyXCFZFZ7LGf5tIQo96ixjY/
         +MvNUvNroFZ76LvBefqm2puB+CxB07MsoJfA+lXo7jGngg3YXp9d+pvHfIqORvJAI2gK
         1pm/76kAYyK1NRSg5k+RoSbsZYTx3EcKEw+N3Td5Xfi8z6HNwWkEJer7GTYEpnDljuSY
         N48Lz7IVKEeDI8rt94MyNAO7kxxCNAFTcY+PspGqsO906hugo1JgIBI+nCixhPZWMAf2
         SRuQ==
X-Gm-Message-State: AOAM530aS1UuKNlLNuQagD7jGHhtq0xQ1w2UheIfgS0QoA+rHrt0YC8i
        Vwq1e44zsDoPbduej5w4sPM=
X-Google-Smtp-Source: ABdhPJw37PQFMM/6xvzWJGYi40dXqiRbrRdP6TFpLr66jswbJ4oNems1vE2S4hydYPLV6+05F6nfTQ==
X-Received: by 2002:a9d:6306:: with SMTP id q6mr6980839otk.290.1628970459637;
        Sat, 14 Aug 2021 12:47:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f5sm1157135oij.6.2021.08.14.12.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 12:47:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 14 Aug 2021 12:47:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] irqchip/gic: Convert to handle_strict_flow_irq()
Message-ID: <20210814194737.GA3951530@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 01:50:09PM +0100, Valentin Schneider wrote:
> Now that the proper infrastructure is in place, convert the irq-gic chip to
> use handle_strict_flow_irq() along with IRQCHIP_AUTOMASKS_FLOW.
> 
> For EOImode=1, the Priority Drop is moved from gic_handle_irq() into
> chip->irq_ack(). This effectively pushes the EOI write down into
> ->handle_irq(), but doesn't change its ordering wrt the irqaction
> handling.
> 
> The EOImode=1 irqchip also gains IRQCHIP_EOI_THREADED, which allows the
> ->irq_eoi() call to be deferred to the tail of ONESHOT IRQ threads. This
> means a threaded ONESHOT IRQ can now be handled entirely without a single
> chip->irq_mask() call.
> 
> EOImode=0 handling remains unchanged.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20210629125010.458872-13-valentin.schneider@arm.com
> ---

This patch results in a variety of crashes in -next.

Example:

[    0.025729] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    0.025811] pgd = (ptrval)
[    0.026029] [00000000] *pgd=00000000
[    0.027301] Internal error: Oops: 80000005 [#1] SMP ARM
[    0.027650] Modules linked in:
[    0.027986] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.14.0-rc5-next-20210813 #1
[    0.028162] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[    0.028311] PC is at 0x0
[    0.028485] LR is at handle_strict_flow_irq+0xc8/0x2b8
[    0.028538] pc : [<00000000>]    lr : [<c01a59c4>]    psr: 400001d3
[    0.028566] sp : c1701e60  ip : c17097cc  fp : 00000050
[    0.028594] r10: c1700000  r9 : 00000057  r8 : c2012400
[    0.028641] r7 : 00000000  r6 : c1711268  r5 : c2083c6c  r4 : c2083c00
[    0.028674] r3 : 00000000  r2 : 00000000  r1 : 0a728000  r0 : c2083c18
[    0.028766] Flags: nZcv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment none
[    0.028821] Control: 10c5387d  Table: 8000406a  DAC: 00000051
[    0.028881] Register r0 information: slab kmalloc-512 start c2083c00 pointer offset 24 size 512
[    0.029482] Register r1 information: non-paged memory
[    0.029649] Register r2 information: NULL pointer
[    0.029672] Register r3 information: NULL pointer
[    0.029692] Register r4 information: slab kmalloc-512 start c2083c00 pointer offset 0 size 512
[    0.029752] Register r5 information: slab kmalloc-512 start c2083c00 pointer offset 108 size 512
[    0.029809] Register r6 information: non-slab/vmalloc memory
[    0.029876] Register r7 information: NULL pointer
[    0.029897] Register r8 information: slab kmalloc-1k start c2012400 pointer offset 0 size 1024
[    0.029958] Register r9 information: non-paged memory
[    0.029980] Register r10 information: non-slab/vmalloc memory
[    0.030002] Register r11 information: non-paged memory
[    0.030023] Register r12 information: non-slab/vmalloc memory
[    0.030064] Process swapper/0 (pid: 0, stack limit = 0x(ptrval))
[    0.030167] Stack: (0xc1701e60 to 0xc1702000)
[    0.030562] 1e60: c168fcd8 c1700000 c17097cc c019fa2c c1709a44 d080c00c c168fcfc c1700000
[    0.030754] 1e80: c17097cc c1701eb8 c1700000 c076fe04 c1700000 600000d3 c0824188 80000053
[    0.030924] 1ea0: ffffffff c1701eec 00000000 c1700000 c1700000 c0100b70 c2013400 c20a0000
[    0.031096] 1ec0: 00000050 00000000 c20a00a0 c07c0ad4 00000910 c2013400 00000000 c20a0000
[    0.031267] 1ee0: c1700000 00000050 00000000 c1701f08 c0824188 c0824188 80000053 ffffffff
[    0.031439] 1f00: 00000051 00000000 00000000 c168f31c c17097cc c2013400 c2013708 3123ccba
[    0.031614] 1f20: 00000001 c2013400 00000960 c20a0000 c1422958 c1709380 c16804d8 c1646020
[    0.031790] 1f40: c14d1eec c082626c c1f6f4e0 c2013400 00000000 c1422958 c1709380 c16461d4
[    0.031961] 1f60: 00000000 00000000 00000000 c0f7d3a4 c186fdcc c1700000 c17093cc c16804d8
[    0.032155] 1f80: c18f8e20 c160fe80 c1903000 c1663a80 00000012 c1700000 c1709380 00000000
[    0.032327] 1fa0: c170caf0 c1600e50 ffffffff ffffffff 00000000 c1600588 00000000 c1700000
[    0.032500] 1fc0: 00000000 c1663a80 3126c2ba 00000000 00000000 c1600330 00000051 10c0387d
[    0.032671] 1fe0: ffffffff 8833b000 410fc075 10c5387d 00000000 00000000 00000000 00000000
[    0.032889] [<c01a59c4>] (handle_strict_flow_irq) from [<c019fa2c>] (handle_domain_irq+0x64/0xa4)
[    0.033027] [<c019fa2c>] (handle_domain_irq) from [<c076fe04>] (gic_handle_irq+0x84/0xbc)
[    0.033076] [<c076fe04>] (gic_handle_irq) from [<c0100b70>] (__irq_svc+0x70/0x98)
[    0.033140] Exception stack(0xc1701eb8 to 0xc1701f00)
[    0.033204] 1ea0:                                                       c2013400 c20a0000
[    0.033377] 1ec0: 00000050 00000000 c20a00a0 c07c0ad4 00000910 c2013400 00000000 c20a0000
[    0.033551] 1ee0: c1700000 00000050 00000000 c1701f08 c0824188 c0824188 80000053 ffffffff
[    0.033596] [<c0100b70>] (__irq_svc) from [<c0824188>] (do_update_region+0x108/0x19c)
[    0.033652] [<c0824188>] (do_update_region) from [<c082626c>] (csi_J+0xf0/0x290)
[    0.033685] [<c082626c>] (csi_J) from [<c16461d4>] (con_init+0x1b4/0x248)
[    0.033726] [<c16461d4>] (con_init) from [<c160fe80>] (console_init+0x21c/0x330)
[    0.033760] [<c160fe80>] (console_init) from [<c1600e50>] (start_kernel+0x508/0x6d4)
[    0.033797] [<c1600e50>] (start_kernel) from [<00000000>] (0x0)
[    0.034079] Code: bad PC value
[    0.034726] ---[ end trace c1324fc4facef313 ]---
[    0.035004] Kernel panic - not syncing: Fatal exception in interrupt

https://kerneltests.org/builders/qemu-arm-v7-next/builds/66 provides
a more detailed log.

Reverting this patch fixes the problem.

Guenter

---
bisect log:

# bad: [4b358aabb93a2c654cd1dcab1a25a589f6e2b153] Add linux-next specific files for 20210813
# good: [36a21d51725af2ce0700c6ebcb6b9594aac658a6] Linux 5.14-rc5
git bisect start 'HEAD' 'v5.14-rc5'
# good: [204808b2ca750e27cbad3455f7cb4368c4f5b260] Merge remote-tracking branch 'crypto/master'
git bisect good 204808b2ca750e27cbad3455f7cb4368c4f5b260
# good: [2201162fca73b487152bcff2ebb0f85c1dde8479] Merge remote-tracking branch 'tip/auto-latest'
git bisect good 2201162fca73b487152bcff2ebb0f85c1dde8479
# bad: [41f97b6df1c8fd9fa828967a687693454c4ce888] Merge remote-tracking branch 'staging/staging-next'
git bisect bad 41f97b6df1c8fd9fa828967a687693454c4ce888
# bad: [3fb5aca2a980d2e7ceb937f600aed0860b20e30b] Merge remote-tracking branch 'usb-chipidea-next/for-usb-next'
git bisect bad 3fb5aca2a980d2e7ceb937f600aed0860b20e30b
# bad: [5d2cf356a3e7986675551aa757c2c53ef82c4ccd] Merge remote-tracking branch 'rcu/rcu/next'
git bisect bad 5d2cf356a3e7986675551aa757c2c53ef82c4ccd
# good: [eedbbd1bbdc8b91431810a17ae1698c41b534809] Merge branch 'lkmm-dev.2021.07.20a' into HEAD
git bisect good eedbbd1bbdc8b91431810a17ae1698c41b534809
# bad: [4a835b19a0cb21c3fdf91eb5e82ffed5ea5d6575] Merge remote-tracking branch 'irqchip/irq/irqchip-next'
git bisect bad 4a835b19a0cb21c3fdf91eb5e82ffed5ea5d6575
# good: [9b24dab9937d57f6d1d1b0bfd1994fb77657469c] Merge branch irq/generic_handle_domain_irq into irq/irqchip-next
git bisect good 9b24dab9937d57f6d1d1b0bfd1994fb77657469c
# bad: [3359fcab48b0467497883863e2e5538605c51c4a] irqchip/gic-v3: Convert to handle_strict_flow_irq()
git bisect bad 3359fcab48b0467497883863e2e5538605c51c4a
# good: [32797fe1c8ee8b9ccbefa14ae5540d4f020a3387] genirq: Don't mask IRQ within flow handler if IRQ is flow-masked
git bisect good 32797fe1c8ee8b9ccbefa14ae5540d4f020a3387
# good: [5a06c146b3af41e54add239cfda57e7d20f83026] irqchip/gic: Rely on MSI default .irq_eoi()
git bisect good 5a06c146b3af41e54add239cfda57e7d20f83026
# good: [ff41d1016e84102a4363f9e85945a7404cf11cb7] irqchip/gic: Add .irq_ack() to GIC-based irqchips
git bisect good ff41d1016e84102a4363f9e85945a7404cf11cb7
# bad: [5bd8e3224b617caa4b628d6c7a06ba8f72174064] irqchip/gic: Convert to handle_strict_flow_irq()
git bisect bad 5bd8e3224b617caa4b628d6c7a06ba8f72174064
# first bad commit: [5bd8e3224b617caa4b628d6c7a06ba8f72174064] irqchip/gic: Convert to handle_strict_flow_irq()
