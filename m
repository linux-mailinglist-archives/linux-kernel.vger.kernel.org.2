Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4186C43568E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 01:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhJTXoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 19:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTXoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 19:44:00 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBF81C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 16:41:45 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 0A49292009C; Thu, 21 Oct 2021 01:41:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 031B392009B;
        Thu, 21 Oct 2021 01:41:44 +0200 (CEST)
Date:   Thu, 21 Oct 2021 01:41:44 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     kernel test robot <lkp@intel.com>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: {standard input}:533: Error: opcode not supported on this
 processor: mips3 (mips3) `dins $8,$11,32,32'
In-Reply-To: <202012281036.28Bl0gVy-lkp@intel.com>
Message-ID: <alpine.DEB.2.21.2110210138270.31442@angie.orcam.me.uk>
References: <202012281036.28Bl0gVy-lkp@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Dec 2020, kernel test robot wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5c8fe583cce542aa0b84adc939ce85293de36e5e
> commit: c7e2d71dda7ac4731bae54a25c49cd81fe7b9046 MIPS: Fix set_pte() for Netlogic XLR using cmpxchg64()
> date:   1 year, 11 months ago
> config: mips-randconfig-c004-20201228 (attached as .config)
> compiler: mipsel-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7e2d71dda7ac4731bae54a25c49cd81fe7b9046
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout c7e2d71dda7ac4731bae54a25c49cd81fe7b9046
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    {standard input}: Assembler messages:
> >> {standard input}:533: Error: opcode not supported on this processor: mips3 (mips3) `dins $8,$11,32,32'

 Good catch! :)  Fix posted:

<https://patchwork.kernel.org/project/linux-mips/patch/alpine.DEB.2.21.2110210054080.31442@angie.orcam.me.uk/>

  Maciej
