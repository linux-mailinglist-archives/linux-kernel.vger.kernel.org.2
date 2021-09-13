Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517C1409AB0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 19:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242588AbhIMRcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 13:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbhIMRcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 13:32:09 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C51C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 10:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y7Foc9Z7zhR5fwxXcBPgaj9Izqeozx1ChyyFKB+hvA4=; b=bQwzXOt1EPnT7L+7hZ3kSnk9Wg
        FYTLZZCR0UO04mpQTpd4K/2McQ92OoRmC4DRopgUlIiKSzy+F73bl1cNGyLAEX8IOccIlkO0oyXXm
        rCYjul66IPPR0utl334hShV5/BS/sAxs0iwDIyl/KejCrddfK883uf7BP7P7zr1ulFEnVu7eaMZZ9
        c9UdTl9l7qXdtxpA+fbLCwME2EbollArLPW0n+OyVnl8s+yoWKP3MF9yhos9cKVsGNU6RHCiDkY7j
        aXKGM3iTXUfx+ZYH/Nzv/AF+ord/D9n1Yo5yYaSUX6uSbsJ2B3uXW2cgkeS9Qmh4XOdIMkQAa4SCF
        EGh2E52g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPpn9-002hlb-9P; Mon, 13 Sep 2021 17:30:51 +0000
Date:   Mon, 13 Sep 2021 10:30:51 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: Re: [mcgrof-next:20210908-firmware-builtin-v4 2/11]
 drivers/base/firmware_loader/builtin/main.c:36:6: error: no previous
 prototype for function 'firmware_is_builtin'
Message-ID: <YT+Ky1+cXrqesI6G@bombadil.infradead.org>
References: <202109101524.pjY4q0Dy-lkp@intel.com>
 <YTv817Srt8hoySP5@bombadil.infradead.org>
 <YTwLw+frJLbntgCJ@archlinux-ax161>
 <YT90vvVi7oYH0xpb@bombadil.infradead.org>
 <993e03a8-b07c-a8d8-8c9f-75bfbab00f0e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <993e03a8-b07c-a8d8-8c9f-75bfbab00f0e@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 10:25:35AM -0700, Nathan Chancellor wrote:
> On 9/13/2021 8:56 AM, Luis Chamberlain wrote:
> > On Fri, Sep 10, 2021 at 06:52:03PM -0700, Nathan Chancellor wrote:
> > > On Fri, Sep 10, 2021 at 05:48:23PM -0700, Luis Chamberlain wrote:
> > > > On Fri, Sep 10, 2021 at 03:41:31PM +0800, kernel test robot wrote:
> > > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20210908-firmware-builtin-v4
> > > > > head:   1c69d6a17750179d68bcaf6b16f9a08d2e475989
> > > > > commit: 79e9fce20ee88ffe37542a66277628e6c53dde14 [2/11] firmware_loader: formalize built-in firmware API
> > > > > config: hexagon-buildonly-randconfig-r004-20210910 (attached as .config)
> > > > > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 261cbe98c38f8c1ee1a482fe76511110e790f58a)
> > > > > reproduce (this is a W=1 build):
> > > > >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > > >          chmod +x ~/bin/make.cross
> > > > >          # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=79e9fce20ee88ffe37542a66277628e6c53dde14
> > > > >          git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
> > > > >          git fetch --no-tags mcgrof-next 20210908-firmware-builtin-v4
> > > > >          git checkout 79e9fce20ee88ffe37542a66277628e6c53dde14
> > > > >          # save the attached .config to linux build tree
> > > > >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=hexagon
> > > > > 
> > > > > If you fix the issue, kindly add following tag as appropriate
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > 
> > > > > All errors (new ones prefixed by >>):
> > > > > 
> > > > > > > drivers/base/firmware_loader/builtin/main.c:36:6: error: no previous prototype for function 'firmware_is_builtin' [-Werror,-Wmissing-prototypes]
> > > > >     bool firmware_is_builtin(const struct firmware *fw)
> > > > 
> > > > This is a lie though its defined on drivers/base/firmware_loader/firmware.h
> > > 
> > > Unless I am missing something, you don't include the firmware_loader
> > > copy of firmware.h in builtin/main.c (only the linux one)? Isn't that
> > > the source of the warning?
> > 
> > You would think, but nope, its there:
> > 
> > #include "firmware.h"
> 
> I see that in drivers/base/firmware_loader/main.c but the warning is
> complaining about drivers/base/firmware_loader/builtin/main.c, where I only
> see
> 
> #include <linux/firmware.h>
> 
> Sorry for the issues with reproducing. For what it's worth, I can reproduce
> this locally and adding
> 
> #include "../firmware.h"
> 
> to drivers/base/firmware_loader/builtin/main.c fixes it for me.

Got it, thanks! I've ammended this change.

 Luis
