Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BFE39CFBF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 17:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhFFP02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 11:26:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhFFP0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 11:26:24 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E1F76124C;
        Sun,  6 Jun 2021 15:24:35 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1lpudd-005mGx-Fz; Sun, 06 Jun 2021 16:24:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 06 Jun 2021 16:24:33 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     irqchip-bot for Marc Zyngier <tip-bot2@linutronix.de>,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        tglx@linutronix.de
Subject: Re: [irqchip: irq/irqchip-next] powerpc: Drop dependency between
 asm/irq.h and linux/irqdomain.h
In-Reply-To: <202106062241.NcVGcvw3-lkp@intel.com>
References: <162298343129.29796.10381692252026350764.tip-bot2@tip-bot2>
 <202106062241.NcVGcvw3-lkp@intel.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <0daef13c3e27002d10bedb7f9719d633@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lkp@intel.com, tip-bot2@linutronix.de, linux-kernel@vger.kernel.org, kbuild-all@lists.01.org, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-06 16:00, kernel test robot wrote:
> Hi irqchip-bot,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on linux/master linus/master v5.13-rc4 
> next-20210604]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:
> https://github.com/0day-ci/linux/commits/irqchip-bot-for-Marc-Zyngier/powerpc-Drop-dependency-between-asm-irq-h-and-linux-irqdomain-h/20210606-205106
> base:   
> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-sbc8548_defconfig (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         #
> https://github.com/0day-ci/linux/commit/72415db4cc9ec9987380123553c3222a3568f37f
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review
> irqchip-bot-for-Marc-Zyngier/powerpc-Drop-dependency-between-asm-irq-h-and-linux-irqdomain-h/20210606-205106
>         git checkout 72415db4cc9ec9987380123553c3222a3568f37f

I got curious, and fetched this tree. This patch is isolated,
out of context in the series, and makes absolutely zero sense
on its own. No wonder you detect all sort of compilation issues.

If you are going to test things, please pick the whole branch,
and not random patches. This is a waste of everybody's time.

         M.
-- 
Jazz is not dead. It just smells funny...
