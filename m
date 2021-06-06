Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709B739CFB5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 17:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhFFPRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 11:17:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230088AbhFFPRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 11:17:02 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FDCC61358;
        Sun,  6 Jun 2021 15:15:02 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1lpuUO-005mFA-EV; Sun, 06 Jun 2021 16:15:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 06 Jun 2021 16:15:00 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     irqchip-bot for Marc Zyngier <tip-bot2@linutronix.de>,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        tglx@linutronix.de
Subject: Re: [irqchip: irq/irqchip-next] irqdomain: Kill
 irq_domain_add_legacy_isa
In-Reply-To: <202106062321.3Z0IkIka-lkp@intel.com>
References: <162298343087.29796.2303741743539407585.tip-bot2@tip-bot2>
 <202106062321.3Z0IkIka-lkp@intel.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <bebfd30fc7ba6ffb20ab0b4d4afec7ec@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lkp@intel.com, tip-bot2@linutronix.de, linux-kernel@vger.kernel.org, kbuild-all@lists.01.org, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-06 16:06, kernel test robot wrote:
> Hi irqchip-bot,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on tip/irq/core]
> [also build test WARNING on linux/master linus/master v5.13-rc4 
> next-20210604]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:
> https://github.com/0day-ci/linux/commits/irqchip-bot-for-Marc-Zyngier/irqdomain-Kill-irq_domain_add_legacy_isa/20210606-204659
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> 006ae1970a8cde1d3e92da69b324d12880133a13
> config: powerpc-allyesconfig (attached as .config)
> compiler: powerpc64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         #
> https://github.com/0day-ci/linux/commit/7d6d9b0177b4ae53ccae4fb2c5cd387460def6ac
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review
> irqchip-bot-for-Marc-Zyngier/irqdomain-Kill-irq_domain_add_legacy_isa/20210606-204659
>         git checkout 7d6d9b0177b4ae53ccae4fb2c5cd387460def6ac
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross
> ARCH=powerpc
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    arch/powerpc/sysdev/i8259.c: In function 'i8259_init':
>    arch/powerpc/sysdev/i8259.c:263:15: error: implicit declaration of
> function 'irq_domain_add_legacy_isa'; did you mean
> 'irq_domain_add_legacy'? [-Werror=implicit-function-declaration]
>      263 |  i8259_host = irq_domain_add_legacy_isa(node, 
> &i8259_host_ops, NULL);
>          |               ^~~~~~~~~~~~~~~~~~~~~~~~~
>          |               irq_domain_add_legacy
>>> arch/powerpc/sysdev/i8259.c:263:13: warning: assignment to 'struct 
>>> irq_domain *' from 'int' makes pointer from integer without a cast 
>>> [-Wint-conversion]
>      263 |  i8259_host = irq_domain_add_legacy_isa(node, 
> &i8259_host_ops, NULL);
>          |             ^
>    cc1: some warnings being treated as errors

This makes zero sense. At the point where this patch is applied in
the series, all instances of irq_domain_add_legacy_isa() have been
removed, except for one in the Chinese translation of the documentation:

<quote>
maz@hot-poop:~/arm-platforms$ git checkout 
bf541b2ef87c162c8129333c55d2357bab122d8e
HEAD is now at bf541b2ef87c irqdomain: Kill irq_domain_add_legacy_isa
maz@hot-poop:~/arm-platforms$ git grep irq_domain_add_legacy_isa
Documentation/translations/zh_CN/core-api/irq/irq-domain.rst:   
irq_domain_add_legacy_isa()
</quote>

Are you applying the patches out of order, by any chance?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
