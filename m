Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C543D8B0D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbhG1Jqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:46:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39762 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbhG1Jqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:46:30 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B6F401FF72;
        Wed, 28 Jul 2021 09:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627465588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6SmJoWuNOkQrkuI0XRjJgWVMFSNTd3xQZMNXA2xgQOg=;
        b=VvDF0cxZX7AsT8ou8F59bz4Pk6T1XkMqJxGrMy83HhNmhmIPe4P1tLHIdu/Se8C3YjglHt
        SwyL9UaqgYQXgrrlqXA07sR9KebCfxlXG++AV6MIfD7S6slJsSV1s/lvqkIsOEjEooP671
        LNtWC1jm7v+MGk7Vuy4QycT2MIzAxGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627465588;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6SmJoWuNOkQrkuI0XRjJgWVMFSNTd3xQZMNXA2xgQOg=;
        b=nPf+908hZXDnZjJsdl7zegBYk2m5C/dSQ0JbDUi3TaEETjbIBDVwuhbePQf8S/z9QuI7aR
        dDzX9imCL5V94yCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 3DC1113D29;
        Wed, 28 Jul 2021 09:46:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id q/OAC3QnAWHzHAAAGKfGzw
        (envelope-from <lhenriques@suse.de>); Wed, 28 Jul 2021 09:46:28 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 8fe92907;
        Wed, 28 Jul 2021 09:46:27 +0000 (UTC)
Date:   Wed, 28 Jul 2021 10:46:27 +0100
From:   Luis Henriques <lhenriques@suse.de>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [linux-stable-rc:linux-4.9.y 9976/9999] fs/ceph/caps.o: warning:
 objtool: handle_cap_grant() falls through to next function
 ceph_add_cap.cold()
Message-ID: <YQEncwVkTGJZCJQu@suse.de>
References: <202107280522.y2scFsEy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202107280522.y2scFsEy-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 05:13:28AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> head:   8da69d43f5d3f7f8787117ee78cfc4060c4c0d29
> commit: 05700fe421866f60f63fbb3a02852425a9bd9447 [9976/9999] libceph: allow ceph_buffer_put() to receive a NULL ceph_buffer
> config: x86_64-randconfig-r021-20210725 (attached as .config)
> compiler: gcc-10 (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=05700fe421866f60f63fbb3a02852425a9bd9447
>         git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>         git fetch --no-tags linux-stable-rc linux-4.9.y
>         git checkout 05700fe421866f60f63fbb3a02852425a9bd9447
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash LDFLAGS=-z max-page-size=0x200000  arch/x86/xen/ fs/ceph/ net/batman-adv/ net/ceph/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/ceph/ceph_fs.h:15,
>                     from include/linux/ceph/types.h:10,
>                     from include/linux/ceph/libceph.h:18,
>                     from fs/ceph/super.h:18,
>                     from fs/ceph/caps.c:11:
>    include/linux/ceph/msgr.h:66:1: warning: alignment 1 of 'struct ceph_entity_addr' is less than 8 [-Wpacked-not-aligned]
>       66 | } __attribute__ ((packed));
>          | ^
>    fs/ceph/caps.c: In function '__send_cap':
>    fs/ceph/caps.c:1128:22: warning: variable 'dropping' set but not used [-Wunused-but-set-variable]
>     1128 |  int held, revoking, dropping, keep;
>          |                      ^~~~~~~~
>    fs/ceph/caps.c: In function 'ceph_handle_caps':
>    fs/ceph/caps.c:3571:7: warning: variable 'osd_epoch_barrier' set but not used [-Wunused-but-set-variable]
>     3571 |   u32 osd_epoch_barrier;
>          |       ^~~~~~~~~~~~~~~~~
>    fs/ceph/caps.c:3570:19: warning: variable 'caller_gid' set but not used [-Wunused-but-set-variable]
>     3570 |   u32 caller_uid, caller_gid;
>          |                   ^~~~~~~~~~
>    fs/ceph/caps.c:3570:7: warning: variable 'caller_uid' set but not used [-Wunused-but-set-variable]
>     3570 |   u32 caller_uid, caller_gid;
>          |       ^~~~~~~~~~
>    fs/ceph/caps.c:3569:7: warning: variable 'flush_tid' set but not used [-Wunused-but-set-variable]
>     3569 |   u64 flush_tid;
>          |       ^~~~~~~~~
>    fs/ceph/caps.o: warning: objtool: handle_cap_flushsnap_ack.constprop.0() falls through to next function __ceph_flush_snaps.cold()
> >> fs/ceph/caps.o: warning: objtool: handle_cap_grant() falls through to next function ceph_add_cap.cold()

I'll be honest: I've no idea why this is happening and x86 assembly isn't my
cup of tea.  I wonder, however, why this is showing up now because commit
5c498950f730 has been released in v4.9.192 already.

Cheers,
--
Luís

> --
>    In file included from include/linux/ceph/ceph_fs.h:15,
>                     from include/linux/ceph/types.h:10,
>                     from include/linux/ceph/libceph.h:18,
>                     from net/ceph/messenger.c:21:
>    include/linux/ceph/msgr.h:66:1: warning: alignment 1 of 'struct ceph_entity_addr' is less than 8 [-Wpacked-not-aligned]
>       66 | } __attribute__ ((packed));
>          | ^
>    net/ceph/messenger.c: In function 'write_partial_message_data':
>    net/ceph/messenger.c:1570:8: warning: variable 'need_crc' set but not used [-Wunused-but-set-variable]
>     1570 |   bool need_crc;
>          |        ^~~~~~~~
>    In file included from include/linux/kernel.h:13,
>                     from include/linux/list.h:8,
>                     from include/linux/wait.h:6,
>                     from include/linux/fs.h:5,
>                     from include/linux/highmem.h:4,
>                     from net/ceph/messenger.c:5:
>    net/ceph/messenger.c: In function 'ceph_sock_state_change':
>    include/linux/printk.h:123:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
>      123 |  0;      \
>          |  ^
>    include/linux/printk.h:315:2: note: in expansion of macro 'no_printk'
>      315 |  no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
>          |  ^~~~~~~~~
>    include/linux/ceph/ceph_debug.h:34:25: note: in expansion of macro 'pr_debug'
>       34 | # define dout(fmt, ...) pr_debug(" " fmt, ##__VA_ARGS__)
>          |                         ^~~~~~~~
>    net/ceph/messenger.c:431:3: note: in expansion of macro 'dout'
>      431 |   dout("%s TCP_CLOSE\n", __func__);
>          |   ^~~~
>    net/ceph/messenger.c:432:2: note: here
>      432 |  case TCP_CLOSE_WAIT:
>          |  ^~~~
>    arch/x86/include/asm/bitops.h: Assembler messages:
>    arch/x86/include/asm/bitops.h:206: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'
>    arch/x86/include/asm/bitops.h:252: Warning: no instruction mnemonic suffix given and no register operands; using default for `btr'
> >> net/ceph/messenger.o: warning: objtool: ceph_msg_release() falls through to next function ceph_msg_new.cold()
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

