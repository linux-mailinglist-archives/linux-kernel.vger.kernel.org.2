Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F704293D2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 17:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbhJKPyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 11:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230417AbhJKPys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 11:54:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA0A360E74;
        Mon, 11 Oct 2021 15:52:46 +0000 (UTC)
Date:   Mon, 11 Oct 2021 11:52:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [rostedt-trace:ftrace/core 2/2] kernel/trace/pid_list.c:439:6:
 warning: Branch condition evaluates to a garbage value
 [clang-analyzer-core.uninitialized.Branch]
Message-ID: <20211011115243.211b4611@gandalf.local.home>
In-Reply-To: <aa487fb0-6e7a-451d-b534-9c8aca2ca39b@intel.com>
References: <202109300520.e7Cli09Z-lkp@intel.com>
        <aa487fb0-6e7a-451d-b534-9c8aca2ca39b@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Oct 2021 17:46:20 +0800
kernel test robot <yujie.liu@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git ftrace/core
> head:   c8d01c02b46e599b057d7d24d1342ae9fcf828c2
> commit: c8d01c02b46e599b057d7d24d1342ae9fcf828c2 [2/2] tracing: Create a sparse bitmask for pid filtering
> config: riscv-randconfig-c006-20210927 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dc6e8dfdfe7efecfda318d43a06fae18b40eb498)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install riscv cross compiling tool for clang build
>          # apt-get install binutils-riscv64-linux-gnu
>          # https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git/commit/?id=c8d01c02b46e599b057d7d24d1342ae9fcf828c2
>          git remote add rostedt-trace https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
>          git fetch --no-tags rostedt-trace ftrace/core
>          git checkout c8d01c02b46e599b057d7d24d1342ae9fcf828c2
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv clang-analyzer
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>


Thanks, this was already reported.

  https://lore.kernel.org/all/221bc7ba-a475-1cb9-1bbe-730bb9c2d448@canonical.com/

-- Steve

