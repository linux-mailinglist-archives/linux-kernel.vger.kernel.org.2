Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676B03F76A5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 15:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240568AbhHYNz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 09:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbhHYNz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 09:55:27 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69AEC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 06:54:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id e21so35849815ejz.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 06:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=5+s+meoD5uho5yB0A7k7fSU47hE+UBxdi3NbE38bmIM=;
        b=Nqowdj2jZlWVjTCX78DMGuIORIpFcG0rDohwJamCh8hIIQavdSF0wq+FkAoBBMXxWp
         p0agbdFCZ7QgXCi8x1eB+btPudW+bcy1B3lfO+hHUHh3RBSIs/pjo/JT0/AHnxeo22Jh
         y10fM8smUmDXJkboiTk+m5NA+OUejyOIIkx/J7j/8rnL7QfBmsbClyD8aXzQN+546ZUC
         KdmcHYXJCUocFQ6wod6D27hISNedMfQsrjQ6EPH2rJKtTdG7Hm4kXW2v0QPOW+lwLPQC
         kjHFciyCOhHby7huC0a1zQjwPdsycK8pqAwJiYeWcqhqVSti6XouLn0kULaJ+nEvLOta
         YwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=5+s+meoD5uho5yB0A7k7fSU47hE+UBxdi3NbE38bmIM=;
        b=H5isO+R8hH4cXUWpOnGFmti9ciWVeY/7tQTwGv9FSBurhb/yrvXwZRCsuy2DrNuMGX
         6bk3PJl7tdS9O9YK+lC166XVCVnjNV/+0tuM4BNELzmBP5xEJh/87/7Vh6uHTTCcjn8g
         JYX3pqHubVFNnbrm4CArYD1cO4QfnnXYmEtgdxg+bEPr4JZAqw7NIWCwdFwbmAgueuHp
         3oS2pz0Hg7jupVDltkjez709jzj1nEHNFaoc9RGDcsL7tPeih3iFUasnmqkrmHVJrZUH
         onDRkQcR8QAezFdwkkxFEdae3eyTs25KJU+IWqM9dvhkfe2aVvCjpxm1AIG4IWKsORRV
         aZ/w==
X-Gm-Message-State: AOAM530ZwSfwkWKfhil+M1Bn5i8BdV0MGtVTGsQbC6syW88mSlr8idHh
        bF8EaLmmdAngJLxkcfeSI00=
X-Google-Smtp-Source: ABdhPJzrCnFkwe8+fUJnWh2T5iV3MMf00SUUHknT7eppa7OdkYkoRyHpt2cyzmhtKJ4wNSYaQOYzlA==
X-Received: by 2002:a17:907:aa4:: with SMTP id bz4mr21035485ejc.97.1629899680408;
        Wed, 25 Aug 2021 06:54:40 -0700 (PDT)
Received: from skbuf ([82.78.148.104])
        by smtp.gmail.com with ESMTPSA id y10sm24986eda.47.2021.08.25.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 06:54:40 -0700 (PDT)
Date:   Wed, 25 Aug 2021 16:54:38 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: "BUG: Invalid wait context" in ls_extirq_set_type
Message-ID: <20210825135438.ubcuxm5vctt6ne2q@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Apologies for my novice level of understanding. I see a stack trace on
my system and would like to understand what is the correct way to get
rid of it.

I have a consumer of the drivers/irqchip/irq-ls-extirq.c driver which
calls request_threaded_irq.

struct irq_desc has a lock which is a raw spinlock.
The __setup_irq function takes this desc->lock raw spinlock, then calls
__irq_set_trigger. Finally this calls chip->irq_set_type which is
implemented by ls_extirq_set_type.

The problem is that ls_extirq_set_type uses regmap_update_bits, which
ends up taking a non-raw spin lock, the kind that becomes sleepable on RT
(this system is not RT, but still).
So that's kind of bad, and this is what the stack trace below is saying:

[    7.530319] =============================
[    7.534316] [ BUG: Invalid wait context ]
[    7.538313] 5.14.0-rc6-07010-ga9b9500ffaac-dirty #603 Not tainted
[    7.544394] -----------------------------
[    7.548391] swapper/0/1 is trying to lock:
[    7.552475] ffff15fa400ef018 (syscon:110:(&syscon_config)->lock){....}-{3:3}, at: regmap_lock_spinlock+0x18/0x30
[    7.562652] other info that might help us debug this:
[    7.567690] context-{5:5}
[    7.570299] 4 locks held by swapper/0/1:
[    7.574209]  #0: ffff15fa4188e9b0 (&dev->mutex){....}-{4:4}, at: __driver_attach+0xf8/0x1a0
[    7.582558]  #1: ffff15fa449431b0 (&dev->mutex){....}-{4:4}, at: __device_attach+0x3c/0x180
[    7.590903]  #2: ffff15fa4491f688 (&desc->request_mutex){+.+.}-{4:4}, at: __setup_irq+0xb8/0x790
[    7.599683]  #3: ffff15fa4491f4f8 (&irq_desc_lock_class){-...}-{2:2}, at: __setup_irq+0xdc/0x790
[    7.608462] stack backtrace:
[    7.611331] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.14.0-rc6-07010-ga9b9500ffaac-dirty #603
[    7.625837] Call trace:
[    7.642190]  __lock_acquire+0x91c/0x1cfc
[    7.646103]  lock_acquire.part.0+0xe4/0x220
[    7.650275]  lock_acquire+0x68/0x8c
[    7.653753]  _raw_spin_lock_irqsave+0x88/0x144
[    7.658185]  regmap_lock_spinlock+0x18/0x30
[    7.662358]  regmap_update_bits_base+0x44/0xa0
[    7.666791]  ls_extirq_set_type+0x7c/0xbc
[    7.670791]  __irq_set_trigger+0x60/0x18c
[    7.674789]  __setup_irq+0x2b0/0x790
[    7.678352]  request_threaded_irq+0xec/0x1b0
[    7.682611]  devm_request_threaded_irq+0x80/0xfc
[    7.687219]  pcf2127_probe.constprop.0+0x2e8/0x470
[    7.691999]  pcf2127_i2c_probe+0x90/0xdc
[    7.695910]  i2c_device_probe+0x320/0x360

Now, the complication is that the regmap_config for the ls-extirq driver
is not even managed by itself, it is provided by syscon_node_to_regmap().

In __regmap_init, I see the various locking options are:
- Disable locking. Again, with the regmap_config provided by the generic
  syscon driver, I think making this change would be rather overreaching.
- Use a spinlock. This is what we have now, but cannot be used from a
  context that holds a raw spinlock.
- Use a mutex. Doesn't help.
- Use a hwspinlock. Never used one, don't know what it's about?!

Either way, there seems to be no option to use a raw spinlock. "Disable
locking" sounds like the best bet, but regmap offers regmap_bulk_read()
and regmap_bulk_write() and those would be broken without locking taken
at the syscon driver level, I think?

I did google for fixes for this kind of issues that were sent in the
past, but in my limited search I did not find any other driver which
uses regmap while under a raw spinlock.

What to do?
