Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4577E37F068
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 02:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbhEMAhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 20:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243737AbhEMAel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 20:34:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4422B613EE;
        Thu, 13 May 2021 00:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620866013;
        bh=j1TT0ANIkRMFsZn/IbX3nZaVo3XI7UKE1sCWQW0d0hA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cxJwWeyyvxzjigHt8FlbGBoPE5WrIeuZAYjOXa5ZNPvSLWWKYQFFmzaIiTFt2VRgX
         iN1RnvFiyJqqKPSmTj/iOgw0AYlJiW+nHsoYcKaAwZ+ZelrNExHRX+DKeiw4AXiSds
         tCOwBFFesOVcLtLE3+mqUzwLtI6YOS14UWdpvl2sOUbLYGaim++kZ0/ChzeOdF3MqG
         Nhu1Qkg0UJVbK2rVQQwwgq8kpPkTXnSXg3M8KRdtooOYotUT16i/yIdLaLOUm+HzcP
         p8/utyVZrfJn3/eWoYW8A6vN6T2P/KPutXP/A1Lq1ZjiE8tUPNdJpnIYoTMxBlLQOe
         67OcKLht/VxQw==
Date:   Thu, 13 May 2021 09:33:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 1/2] kprobes: Allow architectures to override optinsn
 page allocation
Message-Id: <20210513093328.2e4c6da04bd285e0ac688a5d@kernel.org>
In-Reply-To: <202105130218.8xHlehr7-lkp@intel.com>
References: <472c597cc8cc8f74f037acf971f7799fb381a647.1620829724.git.christophe.leroy@csgroup.eu>
        <202105130218.8xHlehr7-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2021 03:04:51 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Christophe,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on powerpc/next]
> [also build test WARNING on linus/master v5.13-rc1 next-20210512]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Christophe-Leroy/kprobes-Allow-architectures-to-override-optinsn-page-allocation/20210512-223121
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: i386-randconfig-r012-20210512 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/0day-ci/linux/commit/2a1f135a9ce3c4d86d3bdefed561aa17760f430f
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Christophe-Leroy/kprobes-Allow-architectures-to-override-optinsn-page-allocation/20210512-223121
>         git checkout 2a1f135a9ce3c4d86d3bdefed561aa17760f430f
>         # save the attached .config to linux build tree
>         make W=1 W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> kernel/kprobes.c:324:14: warning: no previous prototype for 'alloc_optinsn_page' [-Wmissing-prototypes]
>      324 | void __weak *alloc_optinsn_page(void)
>          |              ^~~~~~~~~~~~~~~~~~
> >> kernel/kprobes.c:329:13: warning: no previous prototype for 'free_optinsn_page' [-Wmissing-prototypes]
>      329 | void __weak free_optinsn_page(void *page)
>          |             ^~~~~~~~~~~~~~~~~

Ah, we need a prototype for those in include/linux/kprobes.h
as same as alloc_insn_page() and free_insn_page().

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
