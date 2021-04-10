Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1249D35AB39
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 07:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhDJFzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 01:55:05 -0400
Received: from ivanoab7.miniserver.com ([37.128.132.42]:55636 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhDJFzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 01:55:04 -0400
X-Greylist: delayed 1541 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Apr 2021 01:55:03 EDT
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1lV6Am-00027U-LZ; Sat, 10 Apr 2021 05:28:47 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
        by jain.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1lV6Ak-00015E-5i; Sat, 10 Apr 2021 06:28:44 +0100
Subject: Re: [PATCH] um: add 2 missing libs to fix various build errors
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Brendan Jackman <jackmanb@google.com>,
        Alexei Starovoitov <ast@kernel.org>, kbuild-all@lists.01.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Johannes Berg <johannes.berg@intel.com>
References: <20210404182044.9918-1-rdunlap@infradead.org>
 <9f7eeb70-8ddc-fb04-a378-5f1e80d485e6@infradead.org>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
Message-ID: <74a0ba94-9a22-b7a4-3c1b-596ddbaa856e@cambridgegreys.com>
Date:   Sat, 10 Apr 2021 06:28:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <9f7eeb70-8ddc-fb04-a378-5f1e80d485e6@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2021 05:13, Randy Dunlap wrote:
> On 4/4/21 11:20 AM, Randy Dunlap wrote:
>> Fix many build errors (at least 18 build error reports) for uml on i386
>> by adding 2 more library object files. All missing symbols are
>> either cmpxchg8b_emu or atomic*386.
>>
>> Here are a few examples of the build errors that are eliminated:
>>
>>     /usr/bin/ld: core.c:(.text+0xd83): undefined reference to `cmpxchg8b_emu'
>>     /usr/bin/ld: core.c:(.text+0x2bb2): undefined reference to `atomic64_add_386'
>>     /usr/bin/ld: core.c:(.text+0x2c5d): undefined reference to `atomic64_xchg_386'
>>     syscall.c:(.text+0x2f49): undefined reference to `atomic64_set_386'
>>     /usr/bin/ld: syscall.c:(.text+0x2f54): undefined reference to `atomic64_set_386'
>>     syscall.c:(.text+0x33a4): undefined reference to `atomic64_inc_386'
>>     /usr/bin/ld: syscall.c:(.text+0x33ac): undefined reference to `atomic64_inc_386'
>>     /usr/bin/ld: net/ipv4/inet_timewait_sock.o: in function `inet_twsk_alloc':
>>     inet_timewait_sock.c:(.text+0x3d1): undefined reference to `atomic64_read_386'
>>     /usr/bin/ld: inet_timewait_sock.c:(.text+0x3dd): undefined reference to `atomic64_set_386'
>>     /usr/bin/ld: net/ipv4/inet_connection_sock.o: in function `inet_csk_clone_lock':
>>     inet_connection_sock.c:(.text+0x1d74): undefined reference to `atomic64_read_386'
>>     /usr/bin/ld: inet_connection_sock.c:(.text+0x1d80): undefined reference to `atomic64_set_386'
>>     /usr/bin/ld: net/ipv4/tcp_input.o: in function `inet_reqsk_alloc':
>>     tcp_input.c:(.text+0xa345): undefined reference to `atomic64_set_386'
>>     /usr/bin/ld: net/mac80211/wpa.o: in function `ieee80211_crypto_tkip_encrypt':
>>     wpa.c:(.text+0x739): undefined reference to `atomic64_inc_return_386'
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Cc: Brendan Jackman <jackmanb@google.com>
>> Cc: Alexei Starovoitov <ast@kernel.org>
>> Cc: kbuild-all@lists.01.org
>> Cc: Jeff Dike <jdike@addtoit.com>
>> Cc: Richard Weinberger <richard@nod.at>
>> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>> Cc: linux-um@lists.infradead.org
>> Cc: Johannes Berg <johannes@sipsolutions.net>
>> Cc: Johannes Berg <johannes.berg@intel.com>
>> ---
>> My UML on i386 build environment is br0ken so this is not tested other
>> than to see that the .o files are built as expected.
>> If someone can test/verify it, please respond. Thanks.
> 
> Hi,
> Instead of trying to build this on x86_64, I powered up my 32-bit x86
> laptop and verified that this patch fixes the build errors of
> undefined references to cmpxchg8b_emu() and atomic64_*_386() functions.
> 
> There are still some build errors in 2 object files:
> 
> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x8): undefined reference to `X86_FEATURE_XMM2'
> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x15): undefined reference to `X86_FEATURE_XMM2'
> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x22): undefined reference to `X86_FEATURE_XMM'
> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x2f): undefined reference to `X86_FEATURE_XMM'
> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x3c): undefined reference to `X86_FEATURE_XMM'
> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x49): undefined reference to `X86_FEATURE_XMM'
> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x56): undefined reference to `X86_FEATURE_XMM'
> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x63): more undefined references to `X86_FEATURE_XMM' follow
> 
> and
> 
> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x8): undefined reference to `X86_FEATURE_XMM2'
> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x15): undefined reference to `X86_FEATURE_XMM2'
> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x22): undefined reference to `X86_FEATURE_XMM'
> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x2f): undefined reference to `X86_FEATURE_XMM'
> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x3c): undefined reference to `X86_FEATURE_XMM'
> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x49): undefined reference to `X86_FEATURE_XMM'
> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x56): undefined reference to `X86_FEATURE_XMM'
> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x63): undefined reference to `X86_FEATURE_XMM2'
> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x70): undefined reference to `X86_FEATURE_XMM2'
> 
> I don't know what to do about these or what is causing them (other than
> "alternatives").

I have a patch in the queue which should fix these - it "steals" the 
bug/feature definitions from the x86 tree.

A

> 
> 
> 
>>   arch/x86/um/Makefile |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> --- lnx-512-rc5.orig/arch/x86/um/Makefile
>> +++ lnx-512-rc5/arch/x86/um/Makefile
>> @@ -21,6 +21,7 @@ obj-y += checksum_32.o syscalls_32.o
>>   obj-$(CONFIG_ELF_CORE) += elfcore.o
>>   
>>   subarch-y = ../lib/string_32.o ../lib/atomic64_32.o ../lib/atomic64_cx8_32.o
>> +subarch-y += ../lib/cmpxchg8b_emu.o ../lib/atomic64_386_32.o
>>   subarch-y += ../kernel/sys_ia32.o
>>   
>>   else
>>
> 
> 


-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
