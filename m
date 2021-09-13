Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56078409823
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 17:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245206AbhIMP6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 11:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343907AbhIMP6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 11:58:08 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874C7C061766
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 08:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hkOXi5xr4aXoqhdGU7WryuhpzwY8D8TDudCJdLImCV0=; b=210NTgaIKAXb1FhiRk6o/LMiLc
        IJKzhy3SH7P4lYTYX5vJSR4KZT1T7DTF0c2FVBKG3t5sSqBHmzcy7xJLoGQ94IbpbQ2lEmScPOQqd
        NJSk2+Pnbqy9Z+WTNq/jjkVl0bidijL4gGCSALLpOWIU7z6QAxzZ8cZg2TuYy6KgZAidHeSp3UxUs
        J369m2lG91y3VFGMc5i5PWPLfuydWXr+8DYL/eMsarc8OT5oW4S6P/25d1nMFk1XBKUSSqjipEoiU
        h4GD6jLgUnRPQRAMzjsOdgIr1r/dqfX/yNKGaCNpYkkLSEazymePOrupb0a6razJ98kNx6hVK5Nd+
        8T4q5A1Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPoK6-002G1j-A4; Mon, 13 Sep 2021 15:56:46 +0000
Date:   Mon, 13 Sep 2021 08:56:46 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: Re: [mcgrof-next:20210908-firmware-builtin-v4 2/11]
 drivers/base/firmware_loader/builtin/main.c:36:6: error: no previous
 prototype for function 'firmware_is_builtin'
Message-ID: <YT90vvVi7oYH0xpb@bombadil.infradead.org>
References: <202109101524.pjY4q0Dy-lkp@intel.com>
 <YTv817Srt8hoySP5@bombadil.infradead.org>
 <YTwLw+frJLbntgCJ@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTwLw+frJLbntgCJ@archlinux-ax161>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 06:52:03PM -0700, Nathan Chancellor wrote:
> On Fri, Sep 10, 2021 at 05:48:23PM -0700, Luis Chamberlain wrote:
> > On Fri, Sep 10, 2021 at 03:41:31PM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20210908-firmware-builtin-v4
> > > head:   1c69d6a17750179d68bcaf6b16f9a08d2e475989
> > > commit: 79e9fce20ee88ffe37542a66277628e6c53dde14 [2/11] firmware_loader: formalize built-in firmware API
> > > config: hexagon-buildonly-randconfig-r004-20210910 (attached as .config)
> > > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 261cbe98c38f8c1ee1a482fe76511110e790f58a)
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=79e9fce20ee88ffe37542a66277628e6c53dde14
> > >         git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
> > >         git fetch --no-tags mcgrof-next 20210908-firmware-builtin-v4
> > >         git checkout 79e9fce20ee88ffe37542a66277628e6c53dde14
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=hexagon 
> > > 
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > > >> drivers/base/firmware_loader/builtin/main.c:36:6: error: no previous prototype for function 'firmware_is_builtin' [-Werror,-Wmissing-prototypes]
> > >    bool firmware_is_builtin(const struct firmware *fw)
> > 
> > This is a lie though its defined on drivers/base/firmware_loader/firmware.h
> 
> Unless I am missing something, you don't include the firmware_loader
> copy of firmware.h in builtin/main.c (only the linux one)? Isn't that
> the source of the warning?

You would think, but nope, its there:

#include "firmware.h"

  Luis
