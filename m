Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284334098D9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbhIMQXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbhIMQWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:22:53 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BA2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uW4i1svhg8YjGMTBnNqrqhLORoqiX7VnOzTOfuBW32k=; b=AiBDvG2gqdhCk1U1W15Y5XQ9gt
        DVyHoe728FFvtJASMMD/yvPD3yuegS2hS73KGiLfvk3Qu75y3DpKL/NO4grS7LDPBR7uwzs2FNCYS
        yl8Nbl2LoJdz6sjz7iUzU9BTPX0wV1Hh8BZOlF5xc6K9vHs+PTkL0xNmmmp1BtzNwJa5SlpS4PoGZ
        ITuTckPbVAN9zqE+Jbcl1Y/t5BEhkF+iT3OJmO62WSIvvx5HMCZK5kCcBlkJ8sMaHws9I+jepw3mx
        bvZTTz8s9XvanIQ0SlIUPUFOG0b+hoTZicKiMioQfBNpqMI1Lnm9hilEuss4w8yKEVT4Yc3pJlcaN
        jvdEmFug==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPoi5-002MLD-Te; Mon, 13 Sep 2021 16:21:33 +0000
Date:   Mon, 13 Sep 2021 09:21:33 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Philip Li <philip.li@intel.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: Re: [kbuild-all] Re: [mcgrof-next:20210908-firmware-builtin-v4 2/11]
 drivers/base/firmware_loader/builtin/main.c:36:6: error: no previous
 prototype for function 'firmware_is_builtin'
Message-ID: <YT96jYtYsWVjag8w@bombadil.infradead.org>
References: <202109101524.pjY4q0Dy-lkp@intel.com>
 <YTv817Srt8hoySP5@bombadil.infradead.org>
 <20210911012853.GA834679@pl-dbox>
 <YT91dprXpGy+ywBu@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YT91dprXpGy+ywBu@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 08:59:50AM -0700, Luis Chamberlain wrote:
> On Sat, Sep 11, 2021 at 09:28:53AM +0800, Philip Li wrote:
> > On Fri, Sep 10, 2021 at 05:48:23PM -0700, Luis Chamberlain wrote:
> > > On Fri, Sep 10, 2021 at 03:41:31PM +0800, kernel test robot wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20210908-firmware-builtin-v4
> > > > head:   1c69d6a17750179d68bcaf6b16f9a08d2e475989
> > > > commit: 79e9fce20ee88ffe37542a66277628e6c53dde14 [2/11] firmware_loader: formalize built-in firmware API
> > > > config: hexagon-buildonly-randconfig-r004-20210910 (attached as .config)
> > > > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 261cbe98c38f8c1ee1a482fe76511110e790f58a)
> > > > reproduce (this is a W=1 build):
> > > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=79e9fce20ee88ffe37542a66277628e6c53dde14
> > > >         git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
> > > >         git fetch --no-tags mcgrof-next 20210908-firmware-builtin-v4
> > > >         git checkout 79e9fce20ee88ffe37542a66277628e6c53dde14
> > > >         # save the attached .config to linux build tree
> > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=hexagon 
> > > > 
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > 
> > > > All errors (new ones prefixed by >>):
> > > > 
> > > > >> drivers/base/firmware_loader/builtin/main.c:36:6: error: no previous prototype for function 'firmware_is_builtin' [-Werror,-Wmissing-prototypes]
> > > >    bool firmware_is_builtin(const struct firmware *fw)
> > > 
> > > This is a lie though its defined on drivers/base/firmware_loader/firmware.h
> > > 
> > > >         ^
> > > >    drivers/base/firmware_loader/builtin/main.c:36:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> > > >    bool firmware_is_builtin(const struct firmware *fw)
> > > >    ^
> > > >    static 
> > > >    1 error generated.
> > > 
> > > I get these odd errors:
> > > 
> > > Compiler will be installed in /home/mcgrof/0day
> > hi Luis, would you mind to download the make.cross tool again to give a try, it
> > was updated recently to use latest clang instead of this 12.0.0?
> 
> I had clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl and this was
> used already. Is there a more recent one? Just in case I rm -rf'd it
> and tried again with the latest make.cross.

I rm -rf ~/0day and tried again but the failure I get is:

  CALL    scripts/checksyscalls.sh
  <stdin>:1515:2: warning: syscall clone3 not implemented [-W#warnings]
  #warning syscall clone3 not implemented

Even if I disable CONFIG_WERROR and COMPILE_TEST this still fails here
and so I can't even test compile the code in question.

  Luis
