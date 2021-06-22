Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F1D3AFA2A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 02:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhFVAbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 20:31:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:38895 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhFVAbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 20:31:53 -0400
IronPort-SDR: icKvtrK8KPKlKLEaybgw8Pax0Sdly32sfYlIs8wMK5u2V962GMtQi99kSRmzoav2eXi42BA23F
 xGwHFMXeQA+Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="194096362"
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; 
   d="scan'208";a="194096362"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 17:29:38 -0700
IronPort-SDR: ixlRKj5EQCmWh9/XbrGC9EC5OeLyQkTdFUCkfjxx/PTAKXQBAIVFYcf1DOboNSAYcC2byGiS4S
 ce27f8JNxRaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; 
   d="scan'208";a="486697906"
Received: from pl-dbox.sh.intel.com (HELO pl-dbox) ([10.239.159.39])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2021 17:29:37 -0700
Date:   Tue, 22 Jun 2021 08:22:09 +0800
From:   Philip Li <philip.li@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kernel test robot <lkp@intel.com>, x86-ml <x86@kernel.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [tip:smp/urgent] BUILD REGRESSION
 b22afcdf04c96ca58327784e280e10288cfd3303
Message-ID: <20210622002209.GA166922@pl-dbox>
References: <60d0fc8b.zYHClCDIx15i4OnT%lkp@intel.com>
 <875yy6g5fw.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yy6g5fw.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:32:03AM +0200, Thomas Gleixner wrote:
> On Tue, Jun 22 2021 at 04:54, kernel test robot wrote:
> 
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/urgent
> > branch HEAD: b22afcdf04c96ca58327784e280e10288cfd3303  cpu/hotplug: Cure the cpusets trainwreck
> >
> > Error/Warning in current branch:
> >
> > make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/crypto/cmac.ko', needed by '__modinst'.
> > make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/crypto/md5.ko', needed by '__modinst'.
> > make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/crypto/sha512_generic.ko', needed by '__modinst'.
> > make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/drivers/net/net_failover.ko', needed by '__modinst'.
> > make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/drivers/net/virtio_net.ko', needed by '__modinst'.
> > make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/fs/cifs/cifs.ko', needed by '__modinst'.
> > make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/fs/nfs/nfsv4.ko', needed by '__modinst'.
> > make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/lib/crypto/libarc4.ko', needed by '__modinst'.
> > make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/net/core/failover.ko', needed by '__modinst'.
> > make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/net/dns_resolver/dns_resolver.ko', needed by '__modinst'.
> > make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/net/sunrpc/auth_gss/auth_rpcgss.ko', needed by '__modinst'.
> 
> This is clearly unrelated to the commit in question.
Sorry Thomas, I think this is a bug in 0-day side, kindly ignore this broken report.
We had wrongly sent out 10+ such reports yesterday, and had fix the issue after
that. Sorry for the noise.

Thanks

> 
> I've observed the same issue when switching between kernel versions
> recently but did not have the time to dig into the root cause of this.
> 
> Thanks,
> 
>         tglx
