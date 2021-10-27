Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B3843D7AB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 01:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhJ0Xp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 19:45:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhJ0Xpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 19:45:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 529886109F;
        Wed, 27 Oct 2021 23:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1635378209;
        bh=SmEanuRRB0bx6DIoW/6iADHtn3rqkhQApApaycpsgHc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1hT0V5Adu3T6WLmu3CVMsKW0ou8JJnykS7sDtekR+r6zUEIsjEeejWgRKTBZQyERb
         LcPGhtW1MVrUrGphBPB1ndK50oNaeXb9Gjy0p9Ucj7hjJxS8ZDISZfD25JayDFcvFK
         9a3rpZVk8WoZAV7107+ge5RGalTKcIhANgiV84vE=
Date:   Wed, 27 Oct 2021 16:43:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v1 1/1] delay: Replace kernel.h with the necessary
 inclusions
Message-Id: <20211027164324.d07b36541a41ada7f2917e5c@linux-foundation.org>
In-Reply-To: <202110280737.hD5HfYcX-lkp@intel.com>
References: <20211027150324.79827-1-andriy.shevchenko@linux.intel.com>
        <202110280737.hD5HfYcX-lkp@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021 07:15:13 +0800 kernel test robot <lkp@intel.com> wrote:

> Hi Andy,
> 
> I love your patch! Yet something to improve:

Thanks.

> [auto build test ERROR on linux/master]
> [also build test ERROR on hnaz-mm/master linus/master v5.15-rc7 next-20211027]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/delay-Replace-kernel-h-with-the-necessary-inclusions/20211027-230458
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2f111a6fd5b5297b4e92f53798ca086f7c7d33a4
> config: m68k-allmodconfig (attached as .config)
> compiler: m68k-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/fd321f3d5b18ccab48b82ee4099ae79961067fdc
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Andy-Shevchenko/delay-Replace-kernel-h-with-the-necessary-inclusions/20211027-230458
>         git checkout fd321f3d5b18ccab48b82ee4099ae79961067fdc
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=m68k 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/media/dvb-frontends/cxd2880/cxd2880_common.c: In function 'cxd2880_convert2s_complement':
> >> drivers/media/dvb-frontends/cxd2880/cxd2880_common.c:18:30: error: implicit declaration of function 'GENMASK' [-Werror=implicit-function-declaration]
>       18 |                 return (int)(GENMASK(31, bitlen) | value);
>          |                              ^~~~~~~

--- a/drivers/media/dvb-frontends/cxd2880/cxd2880_common.h~delay-replace-kernelh-with-the-necessary-inclusions-fix
+++ a/drivers/media/dvb-frontends/cxd2880/cxd2880_common.h
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
+#include <linux/bits.h>
 #include <linux/string.h>
 
 int cxd2880_convert2s_complement(u32 value, u32 bitlen);
_

