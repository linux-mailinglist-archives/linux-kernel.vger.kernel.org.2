Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8033255A9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbhBYShs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:37:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:33688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233158AbhBYSfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:35:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C13F64F25;
        Thu, 25 Feb 2021 18:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614278080;
        bh=D+o2eGuxk/96TykauSFPUt++BF/ZEYWd6AdWAF7lWnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iYswuWlR9ns7uatgoMx+SnWVyeJJwej3QpXCRAOfhxQoNvtykdbAm+8gbNrLi8FEQ
         Qtmve/Mjwf+xOXayAV4V6cO8teMH/nIKxvaqbosZbAds1LC5y8blKLCenXjMuz4zrf
         itIW9lchhtnUy8smBKroglsmC4iGmYbK9O7Q3zXPvaIV4I0aW8XufxY8lC7zrRvXsY
         nnnuYwyrB5W9ovdgJNQna+KPf49nmRXXsRDioWpuZWd1alOLe8jUVyN04Z6+Dr/Wvz
         j+U6Ya2iZIzryK3icEXbWHCa9bDwwk02L4Qtc+/jWRzpfNKRo13MH1wZAtJ2L7Yk20
         mddu6MscP4hgg==
Date:   Thu, 25 Feb 2021 11:34:36 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [kbuild-all] Re: WARNING: modpost: vmlinux.o(.text+0x1a8edb8):
 Section mismatch in reference from the function stop_machine() to the
 function .init.text:intel_rng_hw_init()
Message-ID: <20210225183436.GA1349@MSI.localdomain>
References: <202102242224.Cpiog92Y-lkp@intel.com>
 <83ab58cb-581f-135f-21fd-05c15860cafa@suse.com>
 <a7013b23-af0b-e1dd-324c-904a536d9f01@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7013b23-af0b-e1dd-324c-904a536d9f01@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 04:17:21PM +0800, Rong Chen wrote:
> 
> 
> On 2/24/21 10:26 PM, Jürgen Groß wrote:
> > On 24.02.21 15:20, kernel test robot wrote:
> > > tree:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > master
> > > head:   c03c21ba6f4e95e406a1a7b4c34ef334b977c194
> > > commit: ab234a260b1f625b26cbefa93ca365b0ae66df33 x86/pv: Rework
> > > arch_local_irq_restore() to not use popf
> > > date:   2 weeks ago
> > > config: x86_64-randconfig-a005-20210223 (attached as .config)
> > > compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project
> > > f14a14dd2564703db02f80c00db8ae492b594f77)
> > > reproduce (this is a W=1 build):
> > >          wget
> > > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > > -O ~/bin/make.cross
> > >          chmod +x ~/bin/make.cross
> > >          # install x86_64 cross compiling tool for clang build
> > >          # apt-get install binutils-x86-64-linux-gnu
> > >          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ab234a260b1f625b26cbefa93ca365b0ae66df33
> > >          git remote add linus
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >          git fetch --no-tags linus master
> > >          git checkout ab234a260b1f625b26cbefa93ca365b0ae66df33
> > >          # save the attached .config to linux build tree
> > >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross
> > > ARCH=x86_64
> > > 
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > > 
> > > > > WARNING: modpost: vmlinux.o(.text+0x1a8edb8): Section
> > > > > mismatch in reference from the function stop_machine() to
> > > > > the function .init.text:intel_rng_hw_init()
> > > The function stop_machine() references
> > > the function __init intel_rng_hw_init().
> > > This is often because stop_machine lacks a __init
> > > annotation or the annotation of intel_rng_hw_init is wrong.
> > 
> > I'd be very interested to know how the identified patch would be able to
> > have this effect.
> 
> Hi Clang Team,
> 
> The problem is found by the latest clang, and I can't reproduce it with
> clang-11,
> could you take a look?
> 
> Best Regards,
> Rong Chen

Hi Rong,

Known issue. LLVM 13 cut over to the new pass manager (NPM) which has
changed some of the inlining heuristics. I would probably recommend
cutting over to the "release/12.x" branch for now, which should be more
up to date but also stable.

Additionally, Arnd sent a fix for this particular warning here:
https://lore.kernel.org/lkml/20210225130153.1956990-1-arnd@kernel.org/

Cheers,
Nathan
