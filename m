Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C220407481
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 03:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbhIKBxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 21:53:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231864AbhIKBxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 21:53:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 383DD6120A;
        Sat, 11 Sep 2021 01:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631325127;
        bh=mdHTwi3bPAgwigVkTbRKEkcrsC0tJKyvT6eXvTAILXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lYdwZIQxWGjp4AFrIR8NjQuCzyky7E3OsVxlq1+gXJ94R9+U6Tgy6wPrD9fmaKcRg
         QNk2dY8MzWDetP9aFwSAwpjez/h4bg9V4ArNlZiSKvwLM04vYKlJAWIM2E+JkbRvI5
         x3qo0zTnaBPjYJyBE0TRBqDy3IpqKV1BDitN2zy3lMGPZ/TvacUg3taRm9cQzSxJLW
         5MAFbqFam32IBZWSKJNfm8PuFJ5P/yLD/IEeTBmimTKxpjxpv3XkONtMLj1npc6YoJ
         8QVXFJZ9n2Lwd0lJaxEJKEklZHifn32ioIwzX+KqRcs+/DHoPzwxMNu/Lb5COBJLuw
         yXK025PRjhBzA==
Date:   Fri, 10 Sep 2021 18:52:03 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: Re: [mcgrof-next:20210908-firmware-builtin-v4 2/11]
 drivers/base/firmware_loader/builtin/main.c:36:6: error: no previous
 prototype for function 'firmware_is_builtin'
Message-ID: <YTwLw+frJLbntgCJ@archlinux-ax161>
References: <202109101524.pjY4q0Dy-lkp@intel.com>
 <YTv817Srt8hoySP5@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTv817Srt8hoySP5@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 05:48:23PM -0700, Luis Chamberlain wrote:
> On Fri, Sep 10, 2021 at 03:41:31PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20210908-firmware-builtin-v4
> > head:   1c69d6a17750179d68bcaf6b16f9a08d2e475989
> > commit: 79e9fce20ee88ffe37542a66277628e6c53dde14 [2/11] firmware_loader: formalize built-in firmware API
> > config: hexagon-buildonly-randconfig-r004-20210910 (attached as .config)
> > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 261cbe98c38f8c1ee1a482fe76511110e790f58a)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=79e9fce20ee88ffe37542a66277628e6c53dde14
> >         git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
> >         git fetch --no-tags mcgrof-next 20210908-firmware-builtin-v4
> >         git checkout 79e9fce20ee88ffe37542a66277628e6c53dde14
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=hexagon 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> drivers/base/firmware_loader/builtin/main.c:36:6: error: no previous prototype for function 'firmware_is_builtin' [-Werror,-Wmissing-prototypes]
> >    bool firmware_is_builtin(const struct firmware *fw)
> 
> This is a lie though its defined on drivers/base/firmware_loader/firmware.h

Unless I am missing something, you don't include the firmware_loader
copy of firmware.h in builtin/main.c (only the linux one)? Isn't that
the source of the warning?

Cheers,
Nathan
