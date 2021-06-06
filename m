Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4157039CFC5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 17:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhFFP36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 11:29:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhFFP34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 11:29:56 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3800061377;
        Sun,  6 Jun 2021 15:28:07 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1lpuh3-005mIs-8Y; Sun, 06 Jun 2021 16:28:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 06 Jun 2021 16:28:05 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     irqchip-bot for Marc Zyngier <tip-bot2@linutronix.de>,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        tglx@linutronix.de
Subject: Re: [irqchip: irq/irqchip-next] genirq: Use irq_resolve_mapping() to
 implement __handle_domain_irq() and co
In-Reply-To: <202106062255.MSPpLhpo-lkp@intel.com>
References: <162298342683.29796.7142738277768084602.tip-bot2@tip-bot2>
 <202106062255.MSPpLhpo-lkp@intel.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <09413d2ec08ea7c41ce84f448cb577d0@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lkp@intel.com, tip-bot2@linutronix.de, linux-kernel@vger.kernel.org, kbuild-all@lists.01.org, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-06 15:19, kernel test robot wrote:
> Hi irqchip-bot,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on linux/master]
> [also build test WARNING on tip/irq/core linus/master v5.13-rc4 
> next-20210604]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:
> https://github.com/0day-ci/linux/commits/irqchip-bot-for-Marc-Zyngier/genirq-Use-irq_resolve_mapping-to-implement-__handle_domain_irq-and-co/20210606-204819
> base:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> dd860052c99b1e088352bdd4fb7aef46f8d2ef47
> config: riscv-nommu_k210_defconfig (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         #
> https://github.com/0day-ci/linux/commit/e684b127b014b361df0088dca184273cdd73d79e
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review
> irqchip-bot-for-Marc-Zyngier/genirq-Use-irq_resolve_mapping-to-implement-__handle_domain_irq-and-co/20210606-204819
>         git checkout e684b127b014b361df0088dca184273cdd73d79e

Same thing. Patch randomly picked without context, broken
test system. From now on. these reports will be sent to /dev/null
until the test infrastructure is fixed.

         M.
-- 
Jazz is not dead. It just smells funny...
