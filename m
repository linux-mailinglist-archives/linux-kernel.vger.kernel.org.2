Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2669035CF85
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 19:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243479AbhDLReU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 13:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240002AbhDLReS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 13:34:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7A1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 10:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=N1UG+17kx8nRmWhp7BM7vE6GJxj6CSy9VslBp0WuuF0=; b=hrpIAT4Pnx3B6vf3S8wAaF5i3K
        GLxBMmYAOKRhObIV9/TS4+Uhdb9chkYS+6tBmvjg4kMlezbTCn8vBpbsJz6tzwQTuIH6q2MIGMauc
        CS8VFwAtwnEKxxPiw18bio+XPmJGUrxhTmOI4h2qVRZ83VTpBOxVX/p8bBj698yBtCjBB4sJ5DcRu
        Lb+aW+tLj7Zp5FHn3HilLJBQVBm7Rn8q29CjT5cSsviPFYi7SnYqeddfyBxVJYvyOjqSHA3YdalLH
        enbsH4ahefYr9iGtc9FkPPrvt/O0Zrq2TBV5E/Q5R+4aV+QFegBoWbWmEkT+UqWiUYpZP5BfN4by8
        U5AgNalQ==;
Received: from [2601:1c0:6280:3f0::e0e1]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lW0Rf-007MQp-UW; Mon, 12 Apr 2021 17:33:56 +0000
Subject: Re: /usr/bin/ld: atomic64_test.c:undefined reference to
 `atomic64_add_unless_386'
To:     kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
References: <202104130102.Z6N2SXRY-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <08c3ffc7-d2a8-24fa-2121-2d6280e3489f@infradead.org>
Date:   Mon, 12 Apr 2021 10:33:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <202104130102.Z6N2SXRY-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/21 10:30 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d434405aaab7d0ebc516b68a8fc4100922d7f5ef
> commit: 37f8173dd84936ea78000ed1cad24f8b18d48ebb locking/atomics: Flip fallbacks and instrumentation
> date:   10 months ago
> config: um-randconfig-r022-20210412 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=37f8173dd84936ea78000ed1cad24f8b18d48ebb
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 37f8173dd84936ea78000ed1cad24f8b18d48ebb
>         # save the attached .config to linux build tree
>         make W=1 ARCH=um 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x2a7b): undefined reference to `cmpxchg8b_emu'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x2aed): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x2b5b): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x2b81): undefined reference to `cmpxchg8b_emu'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x2bf3): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x2c61): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x2c87): undefined reference to `cmpxchg8b_emu'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x2cf9): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x2d67): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x2d8d): undefined reference to `cmpxchg8b_emu'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x2dff): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x2e6d): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x2e93): undefined reference to `cmpxchg8b_emu'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x2f05): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x2f73): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x2f99): undefined reference to `cmpxchg8b_emu'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x300b): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3079): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x309f): undefined reference to `cmpxchg8b_emu'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3111): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x317f): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x31a5): undefined reference to `cmpxchg8b_emu'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3217): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3285): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x32ab): undefined reference to `cmpxchg8b_emu'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x331d): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x338b): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x33b1): undefined reference to `cmpxchg8b_emu'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3423): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3491): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x34b7): undefined reference to `cmpxchg8b_emu'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3529): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3597): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x35b5): undefined reference to `cmpxchg8b_emu'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x362d): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x369b): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x36a0): undefined reference to `atomic64_inc_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x370f): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3714): undefined reference to `atomic64_dec_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3788): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x378d): undefined reference to `atomic64_inc_return_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x37f8): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x386e): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3873): undefined reference to `atomic64_inc_return_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x38de): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3954): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3959): undefined reference to `atomic64_inc_return_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x39c3): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3a38): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3a3d): undefined reference to `atomic64_inc_return_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3aa8): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3b1e): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3b23): undefined reference to `atomic64_dec_return_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3b8a): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3bfc): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3c01): undefined reference to `atomic64_dec_return_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3c6c): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3ce2): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3ce7): undefined reference to `atomic64_dec_return_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3d52): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3dc8): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3dcd): undefined reference to `atomic64_dec_return_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3e37): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3eae): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3ebd): undefined reference to `atomic64_xchg_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3f2c): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3fa1): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x3fac): undefined reference to `atomic64_xchg_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4013): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4085): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4094): undefined reference to `atomic64_xchg_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4103): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4176): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4181): undefined reference to `atomic64_xchg_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x41f0): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4263): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4278): undefined reference to `cmpxchg8b_emu'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x42e2): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4359): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x437c): undefined reference to `cmpxchg8b_emu'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x43eb): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x445e): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4473): undefined reference to `cmpxchg8b_emu'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x44da): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x454c): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4573): undefined reference to `cmpxchg8b_emu'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x45e2): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4655): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x466a): undefined reference to `cmpxchg8b_emu'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x46d1): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4744): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4759): undefined reference to `cmpxchg8b_emu'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x47c3): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4838): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4851): undefined reference to `cmpxchg8b_emu'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x48b8): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x492d): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4946): undefined reference to `cmpxchg8b_emu'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x49ad): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4a1f): undefined reference to `atomic64_set_386'
>>> /usr/bin/ld: atomic64_test.c:(.init.text+0x4a2f): undefined reference to `atomic64_add_unless_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4ada): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4af0): undefined reference to `atomic64_add_unless_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4ba3): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4ba8): undefined reference to `atomic64_dec_if_positive_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4c76): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4c7b): undefined reference to `atomic64_dec_if_positive_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4d1e): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4d23): undefined reference to `atomic64_dec_if_positive_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4dd0): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4dd5): undefined reference to `atomic64_inc_not_zero_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4e82): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4e87): undefined reference to `atomic64_inc_not_zero_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4f1a): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4f1f): undefined reference to `atomic64_inc_not_zero_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4faf): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: atomic64_test.c:(.init.text+0x4fb4): undefined reference to `atomic64_inc_not_zero_386'
>    /usr/bin/ld: drivers/md/raid1.o: in function `process_checks':
>    raid1.c:(.text+0x4ac8): undefined reference to `atomic64_add_386'
>    /usr/bin/ld: raid1.c:(.text+0x4bd2): undefined reference to `atomic64_add_386'
>    /usr/bin/ld: drivers/md/raid10.o: in function `sync_request_write':
>    raid10.c:(.text+0x342c): undefined reference to `atomic64_add_386'
>    /usr/bin/ld: drivers/md/raid5.o: in function `handle_parity_checks6.isra.0':
>    raid5.c:(.text+0x21fd): undefined reference to `atomic64_add_386'
>    /usr/bin/ld: drivers/md/raid5.o: in function `handle_stripe':
>    raid5.c:(.text+0x10202): undefined reference to `atomic64_add_386'
>    /usr/bin/ld: drivers/md/md.o: in function `mismatch_cnt_show':
>    md.c:(.text+0x9f1): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: drivers/md/md.o: in function `md_do_sync':
>    md.c:(.text+0xa430): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: drivers/md/md.o: in function `do_md_stop.cold':
>    md.c:(.text.unlikely+0x157f): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: drivers/md/dm-raid.o: in function `raid_status':
>    dm-raid.c:(.text+0x2bb9): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: drivers/md/dm-integrity.o: in function `dm_integrity_status':
>    dm-integrity.c:(.text+0x4fa): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: drivers/md/dm-integrity.o: in function `do_crypt':
>    dm-integrity.c:(.text+0x11ae): undefined reference to `atomic64_inc_386'
>    /usr/bin/ld: drivers/md/dm-integrity.o: in function `section_mac':
>    dm-integrity.c:(.text+0x13cc): undefined reference to `atomic64_inc_386'
>    /usr/bin/ld: dm-integrity.c:(.text+0x146e): undefined reference to `atomic64_inc_386'
>    /usr/bin/ld: dm-integrity.c:(.text+0x1539): undefined reference to `atomic64_inc_386'
>    /usr/bin/ld: drivers/md/dm-integrity.o: in function `integrity_sector_checksum':
>    dm-integrity.c:(.text+0x1c18): undefined reference to `atomic64_inc_386'
>    /usr/bin/ld: drivers/md/dm-integrity.o:dm-integrity.c:(.text+0x1c53): more undefined references to `atomic64_inc_386' follow
>    /usr/bin/ld: drivers/md/dm-integrity.o: in function `dm_integrity_ctr':
>    dm-integrity.c:(.text+0xbb50): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: kernel/sched/cputime.o: in function `account_user_time':
>    cputime.c:(.text+0x78): undefined reference to `atomic64_add_386'
>    /usr/bin/ld: kernel/sched/cputime.o: in function `account_guest_time':
>    cputime.c:(.text+0x1bb): undefined reference to `atomic64_add_386'
>    /usr/bin/ld: kernel/sched/cputime.o: in function `account_system_index_time':
>    cputime.c:(.text+0x29b): undefined reference to `atomic64_add_386'
>    /usr/bin/ld: kernel/sched/rt.o: in function `update_curr_rt':
>    rt.c:(.text+0x11d3): undefined reference to `atomic64_add_386'
>    /usr/bin/ld: kernel/sched/deadline.o: in function `update_curr_dl':
>    deadline.c:(.text+0x356e): undefined reference to `atomic64_add_386'
>    /usr/bin/ld: kernel/time/posix-cpu-timers.o: in function `cpu_clock_sample_group':
>    posix-cpu-timers.c:(.text+0x320): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: posix-cpu-timers.c:(.text+0x331): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: posix-cpu-timers.c:(.text+0x34a): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: posix-cpu-timers.c:(.text+0x35d): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: posix-cpu-timers.c:(.text+0x36c): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: posix-cpu-timers.c:(.text+0x417): undefined reference to `cmpxchg8b_emu'
>    /usr/bin/ld: posix-cpu-timers.c:(.text+0x430): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: posix-cpu-timers.c:(.text+0x45d): undefined reference to `cmpxchg8b_emu'
>    /usr/bin/ld: posix-cpu-timers.c:(.text+0x476): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: posix-cpu-timers.c:(.text+0x4a3): undefined reference to `cmpxchg8b_emu'
>    /usr/bin/ld: posix-cpu-timers.c:(.text+0x4bc): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: kernel/time/posix-cpu-timers.o: in function `thread_group_sample_cputime':
>    posix-cpu-timers.c:(.text+0x1ebd): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: posix-cpu-timers.c:(.text+0x1ecc): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: posix-cpu-timers.c:(.text+0x1edd): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: kernel/time/posix-cpu-timers.o: in function `run_posix_cpu_timers':
>    posix-cpu-timers.c:(.text+0x2387): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: kernel/time/posix-cpu-timers.o:posix-cpu-timers.c:(.text+0x239a): more undefined references to `atomic64_read_386' follow
>    /usr/bin/ld: kernel/trace/trace_clock.o: in function `trace_clock_counter':
>    trace_clock.c:(.text+0x102): undefined reference to `atomic64_add_return_386'
>    /usr/bin/ld: kernel/bpf/core.o: in function `___bpf_prog_run':
>    core.c:(.text+0x2691): undefined reference to `atomic64_add_386'
>    /usr/bin/ld: kernel/bpf/syscall.o: in function `__bpf_prog_get.constprop.0':
>    syscall.c:(.text+0x1028): undefined reference to `atomic64_inc_386'
>    /usr/bin/ld: kernel/bpf/syscall.o: in function `__bpf_prog_put.constprop.0':
>    syscall.c:(.text+0x108c): undefined reference to `atomic64_dec_return_386'
>    /usr/bin/ld: kernel/bpf/syscall.o: in function `__bpf_map_put.constprop.0':
>    syscall.c:(.text+0x55a9): undefined reference to `atomic64_dec_return_386'
>    /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_put_with_uref':
>    syscall.c:(.text+0x566e): undefined reference to `atomic64_dec_return_386'
>    /usr/bin/ld: kernel/bpf/syscall.o: in function `map_create':
>    syscall.c:(.text+0x59c6): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: syscall.c:(.text+0x59d1): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_prog_load':
>    syscall.c:(.text+0x65f6): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_inc':
>    syscall.c:(.text+0x6e47): undefined reference to `atomic64_inc_386'
>    /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_inc_with_uref':
>    syscall.c:(.text+0x6e61): undefined reference to `atomic64_inc_386'
>    /usr/bin/ld: syscall.c:(.text+0x6e69): undefined reference to `atomic64_inc_386'
>    /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_get':
>    syscall.c:(.text+0x6f1e): undefined reference to `atomic64_inc_386'
>    /usr/bin/ld: kernel/bpf/syscall.o: in function `bpf_map_get_with_uref':

This patch fixes it for me:

https://lore.kernel.org/lkml/9f7eeb70-8ddc-fb04-a378-5f1e80d485e6@infradead.org/



-- 
~Randy

