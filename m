Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5273E35AAB0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 06:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhDJEPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 00:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhDJEPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 00:15:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672B1C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 21:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=3bB+m0fbtX3OhtdFNOgtTWp1ZNIwh6ik4e61/uqX+1Q=; b=uVOMEBzYkT6VmFOA9oLuTssCmk
        8N3JkFlt2shGL9sds12Bge87VDKeD1GPZAQWgAX1/WS6HjvUOk0NSqDZgxB206JGHt0QkjtXDdI5a
        NF1ViY4S+pZs48hVjdP6rPvbgZZ8mpymEtRdH9L+bcZ8GqSYbycUObkDiFG0O6n0klZC5Rhe+ros/
        Kovj8MGjiJi/vg7/vReZPGktDUv7e2sucNenwJlDLMS+sdRURXGUbQIBcJyF/EW31ZzrsT4T50r4o
        kQxXkEGbdbDoXwdnuY8RnZRQ3pDFQAcBy6AgkJnGl9UIAszQ7kwxHpEY6min+JCOtTCh5n2mMDR2m
        lYMsKKUA==;
Received: from [2601:1c0:6280:3f0::e0e1]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lV50G-001Ixr-LS; Sat, 10 Apr 2021 04:13:58 +0000
Subject: Re: [PATCH] um: add 2 missing libs to fix various build errors
To:     linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Brendan Jackman <jackmanb@google.com>,
        Alexei Starovoitov <ast@kernel.org>, kbuild-all@lists.01.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Johannes Berg <johannes.berg@intel.com>
References: <20210404182044.9918-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9f7eeb70-8ddc-fb04-a378-5f1e80d485e6@infradead.org>
Date:   Fri, 9 Apr 2021 21:13:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210404182044.9918-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/21 11:20 AM, Randy Dunlap wrote:
> Fix many build errors (at least 18 build error reports) for uml on i386
> by adding 2 more library object files. All missing symbols are
> either cmpxchg8b_emu or atomic*386.
> 
> Here are a few examples of the build errors that are eliminated:
> 
>    /usr/bin/ld: core.c:(.text+0xd83): undefined reference to `cmpxchg8b_emu'
>    /usr/bin/ld: core.c:(.text+0x2bb2): undefined reference to `atomic64_add_386'
>    /usr/bin/ld: core.c:(.text+0x2c5d): undefined reference to `atomic64_xchg_386'
>    syscall.c:(.text+0x2f49): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: syscall.c:(.text+0x2f54): undefined reference to `atomic64_set_386'
>    syscall.c:(.text+0x33a4): undefined reference to `atomic64_inc_386'
>    /usr/bin/ld: syscall.c:(.text+0x33ac): undefined reference to `atomic64_inc_386'
>    /usr/bin/ld: net/ipv4/inet_timewait_sock.o: in function `inet_twsk_alloc':
>    inet_timewait_sock.c:(.text+0x3d1): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: inet_timewait_sock.c:(.text+0x3dd): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: net/ipv4/inet_connection_sock.o: in function `inet_csk_clone_lock':
>    inet_connection_sock.c:(.text+0x1d74): undefined reference to `atomic64_read_386'
>    /usr/bin/ld: inet_connection_sock.c:(.text+0x1d80): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: net/ipv4/tcp_input.o: in function `inet_reqsk_alloc':
>    tcp_input.c:(.text+0xa345): undefined reference to `atomic64_set_386'
>    /usr/bin/ld: net/mac80211/wpa.o: in function `ieee80211_crypto_tkip_encrypt':
>    wpa.c:(.text+0x739): undefined reference to `atomic64_inc_return_386'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Brendan Jackman <jackmanb@google.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: kbuild-all@lists.01.org
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: linux-um@lists.infradead.org
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Johannes Berg <johannes.berg@intel.com>
> ---
> My UML on i386 build environment is br0ken so this is not tested other
> than to see that the .o files are built as expected.
> If someone can test/verify it, please respond. Thanks.

Hi,
Instead of trying to build this on x86_64, I powered up my 32-bit x86
laptop and verified that this patch fixes the build errors of
undefined references to cmpxchg8b_emu() and atomic64_*_386() functions.

There are still some build errors in 2 object files:

/usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x8): undefined reference to `X86_FEATURE_XMM2'
/usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x15): undefined reference to `X86_FEATURE_XMM2'
/usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x22): undefined reference to `X86_FEATURE_XMM'
/usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x2f): undefined reference to `X86_FEATURE_XMM'
/usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x3c): undefined reference to `X86_FEATURE_XMM'
/usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x49): undefined reference to `X86_FEATURE_XMM'
/usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x56): undefined reference to `X86_FEATURE_XMM'
/usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x63): more undefined references to `X86_FEATURE_XMM' follow

and

/usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x8): undefined reference to `X86_FEATURE_XMM2'
/usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x15): undefined reference to `X86_FEATURE_XMM2'
/usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x22): undefined reference to `X86_FEATURE_XMM'
/usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x2f): undefined reference to `X86_FEATURE_XMM'
/usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x3c): undefined reference to `X86_FEATURE_XMM'
/usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x49): undefined reference to `X86_FEATURE_XMM'
/usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x56): undefined reference to `X86_FEATURE_XMM'
/usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x63): undefined reference to `X86_FEATURE_XMM2'
/usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x70): undefined reference to `X86_FEATURE_XMM2'

I don't know what to do about these or what is causing them (other than
"alternatives").



>  arch/x86/um/Makefile |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- lnx-512-rc5.orig/arch/x86/um/Makefile
> +++ lnx-512-rc5/arch/x86/um/Makefile
> @@ -21,6 +21,7 @@ obj-y += checksum_32.o syscalls_32.o
>  obj-$(CONFIG_ELF_CORE) += elfcore.o
>  
>  subarch-y = ../lib/string_32.o ../lib/atomic64_32.o ../lib/atomic64_cx8_32.o
> +subarch-y += ../lib/cmpxchg8b_emu.o ../lib/atomic64_386_32.o
>  subarch-y += ../kernel/sys_ia32.o
>  
>  else
> 


-- 
~Randy
