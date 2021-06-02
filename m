Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191B4399123
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 19:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFBRKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 13:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFBRKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 13:10:34 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC94C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 10:08:42 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id jz2-20020a17090b14c2b0290162cf0b5a35so3801731pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 10:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1fpvtBAtmErYvLDACvuUfVIpsBGzcl7q8rp7sWVVxQI=;
        b=uwo67Jy6GVEr6dJN01pD77SpUP+n8yrz+wtOGYaRaSCW0sFJw5uIYCoEE3xhDK4oh0
         +WpWGW2BPR5XQPOs9v85/pMQl7xzef8V8VZNkl9+Uklwcyg5f95ztRBMzC8x8FyoE5gG
         Y3jWnPmjzmlV5A2KxF8dSc4BTWT26hQGCkwDrVEJ90pt8nazzg6NZTjZiDTXLcmBHVI7
         JLi+zY2E+lGBT9ggAkmZpLN6B08OSXaWqyGy2+Yl5v0h2CG/aYfdzfcklGvqpKFol7Dv
         dT0NfAxLmSv6Q1h9QoQfqGyjyFwNki0S2m6a3l4MjkUXrm02S2PG5gtYx3BEyBT3ch1R
         Q1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1fpvtBAtmErYvLDACvuUfVIpsBGzcl7q8rp7sWVVxQI=;
        b=VcRhOo5Z9NVXRu9C7sgi40+r4EEM3BpeT5O0WAj5i1QIGuBYltrWCvzZrABUNOcagO
         Eat56ejDCuw43df5skK4byvIOmrG9ItSEU9m5dfeELmU4fUZRQ6hDJXEccV2UZV2UxYb
         +VyWv/cZzypyTNbmYPKo7eR8wM50qzZyP6xzmR91A8GZr1tMXekkuy0yN3ICzHCZQmUV
         +eTpJENAD+xkfDPnUQJp8Eje7Ws9LuLm+x42lNDhxBFFWj+X+6HIHviQzMTNqwgaoOIH
         CJIWpdvv+BVnycgDLIbmJBpF7CQXKB1QfVTVBmFEoSSlWIjTygO5Cro4Nh/fY0nCz0vJ
         Nfag==
X-Gm-Message-State: AOAM5339Ro3Il00HsgBNvhQeG/x7ATBj4LXW/NmIuRgDWZfCOcStHG+G
        iZXsH+kUy8X0D0PlPPvSSeE=
X-Google-Smtp-Source: ABdhPJzaHsZTF79sms600qdVSVbgNaIyoVj59py4thjERrVnAU1vfQ/zXtHh6Z0YKZjA9WSKKiJ05Q==
X-Received: by 2002:a17:90b:1bca:: with SMTP id oa10mr31315086pjb.100.1622653721974;
        Wed, 02 Jun 2021 10:08:41 -0700 (PDT)
Received: from [192.168.1.41] (096-040-190-174.res.spectrum.com. [96.40.190.174])
        by smtp.gmail.com with ESMTPSA id d3sm191598pfn.141.2021.06.02.10.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 10:08:41 -0700 (PDT)
Subject: Re: [syzbot] KASAN: use-after-free Read in fw_load_sysfs_fallback
To:     Luis Chamberlain <mcgrof@kernel.org>,
        syzbot <syzbot+9b91d635e2b51efd6371@syzkaller.appspotmail.com>,
        Martin Fuzzey <mfuzzey@parkeon.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, sunjunyong@xiaomi.com, sunjy516@gmail.com,
        syzkaller-bugs@googlegroups.com
References: <000000000000721b1305bf043595@google.com>
 <20210403013143.GV4332@42.do-not-panic.com>
From:   SyzScope <syzscope@gmail.com>
Message-ID: <07acfc7a-cfa4-5f14-b2ee-14790ff58363@gmail.com>
Date:   Wed, 2 Jun 2021 10:08:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210403013143.GV4332@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
We have analyzed this bug and realize that it is security-critical. 
Specifically, according to our investigation, it will lead to a 
use-after-free write (instead of the originally reported use-after-free 
read) and thus highly likely exploitable. More details can be found at:

https://sites.google.com/view/syzscope/kasan-use-after-free-read-in-fw_load_sysfs_fallback 
<https://sites.google.com/view/syzscope/kasan-use-after-free-read-in-fw_load_sysfs_fallback> 


We understand that creating a patch can be time-consuming and there is 
probably a long list of bugs pending fixes. We hope that our security 
analysis can enable an informed decision on which bugs to fix first 
(prioritization).

Since the bug has been on syzbot for over two months (first found on 
03-22-2020), it is best to have the bug fixed early enough to avoid it 
being weaponized.

On 4/2/2021 6:31 PM, Luis Chamberlain wrote:
> On Fri, Apr 02, 2021 at 02:41:20PM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    5ee96fa9 Merge tag 'irq-urgent-2021-03-21' of git://git.ke..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1028d621d00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c51293a9ca630f6d
>> dashboard link: https://syzkaller.appspot.com/bug?extid=9b91d635e2b51efd6371
>> compiler:       Debian clang version 11.0.1-2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1794dad6d00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f7afe6d00000
>>
>> The issue was bisected to:
>>
>> commit bcfbd3523f3c6eea51a74d217a8ebc5463bcb7f4
>> Author: Junyong Sun <sunjy516@gmail.com>
>> Date:   Tue Mar 3 02:36:08 2020 +0000
>>
>>      firmware: fix a double abort case with fw_load_sysfs_fallback
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17e4778ad00000
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1414778ad00000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1014778ad00000
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+9b91d635e2b51efd6371@syzkaller.appspotmail.com
>> Fixes: bcfbd3523f3c ("firmware: fix a double abort case with fw_load_sysfs_fallback")
>>
>> platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
>> platform regulatory.0: Falling back to sysfs fallback for: regulatory.db
>> ==================================================================
>> BUG: KASAN: use-after-free in __list_add_valid+0x36/0xc0 lib/list_debug.c:23
>> Read of size 8 at addr ffff888014188ac8 by task syz-executor310/9819
>>
>> CPU: 0 PID: 9819 Comm: syz-executor310 Not tainted 5.12.0-rc3-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Call Trace:
>>   __dump_stack lib/dump_stack.c:79 [inline]
>>   dump_stack+0x176/0x24e lib/dump_stack.c:120
>>   print_address_description+0x5f/0x3a0 mm/kasan/report.c:232
>>   __kasan_report mm/kasan/report.c:399 [inline]
>>   kasan_report+0x15c/0x200 mm/kasan/report.c:416
>>   __list_add_valid+0x36/0xc0 lib/list_debug.c:23
>>   __list_add include/linux/list.h:67 [inline]
>>   list_add include/linux/list.h:86 [inline]
>>   fw_load_sysfs_fallback+0x110/0x720 drivers/base/firmware_loader/fallback.c:516
>>   fw_load_from_user_helper+0x242/0x320 drivers/base/firmware_loader/fallback.c:581
>>   _request_firmware+0x2c5/0x4c0 drivers/base/firmware_loader/main.c:831
>>   request_firmware+0x35/0x50 drivers/base/firmware_loader/main.c:875
>>   reg_reload_regdb+0x3a/0x1b0 net/wireless/reg.c:1095
>>   genl_family_rcv_msg_doit net/netlink/genetlink.c:739 [inline]
>>   genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
>>   genl_rcv_msg+0xe4e/0x1280 net/netlink/genetlink.c:800
>>   netlink_rcv_skb+0x190/0x3a0 net/netlink/af_netlink.c:2502
>>   genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
>>   netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
>>   netlink_unicast+0x786/0x940 net/netlink/af_netlink.c:1338
>>   netlink_sendmsg+0x9ae/0xd50 net/netlink/af_netlink.c:1927
>>   sock_sendmsg_nosec net/socket.c:654 [inline]
>>   sock_sendmsg net/socket.c:674 [inline]
>>   ____sys_sendmsg+0x519/0x800 net/socket.c:2350
>>   ___sys_sendmsg net/socket.c:2404 [inline]
>>   __sys_sendmsg+0x2bf/0x370 net/socket.c:2433
>>   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>> RIP: 0033:0x44ab59
>> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 16 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007fa2b8ba9318 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>> RAX: ffffffffffffffda RBX: 00000000004d62a8 RCX: 000000000044ab59
>> RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000003
>> RBP: 00000000004d62a0 R08: 0000000000000099 R09: 0000000000000000
>> R10: 000000000000000c R11: 0000000000000246 R12: 0031313230386c6e
>> R13: 00007ffeeaba390f R14: 00007fa2b8ba9400 R15: 0000000000022000
>>
>> Allocated by task 9818:
>>   kasan_save_stack mm/kasan/common.c:38 [inline]
>>   kasan_set_track mm/kasan/common.c:46 [inline]
>>   set_alloc_info mm/kasan/common.c:427 [inline]
>>   ____kasan_kmalloc+0xc2/0xf0 mm/kasan/common.c:506
>>   kasan_kmalloc include/linux/kasan.h:233 [inline]
>>   kmem_cache_alloc_trace+0x21b/0x350 mm/slub.c:2934
>>   kmalloc include/linux/slab.h:554 [inline]
>>   kzalloc include/linux/slab.h:684 [inline]
>>   __allocate_fw_priv+0x98/0x340 drivers/base/firmware_loader/main.c:186
>>   alloc_lookup_fw_priv+0x1c3/0x380 drivers/base/firmware_loader/main.c:250
>>   _request_firmware_prepare+0x23c/0x5b0 drivers/base/firmware_loader/main.c:744
>>   _request_firmware+0xd9/0x4c0 drivers/base/firmware_loader/main.c:806
>>   request_firmware+0x35/0x50 drivers/base/firmware_loader/main.c:875
>>   reg_reload_regdb+0x3a/0x1b0 net/wireless/reg.c:1095
>>   genl_family_rcv_msg_doit net/netlink/genetlink.c:739 [inline]
>>   genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
>>   genl_rcv_msg+0xe4e/0x1280 net/netlink/genetlink.c:800
>>   netlink_rcv_skb+0x190/0x3a0 net/netlink/af_netlink.c:2502
>>   genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
>>   netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
>>   netlink_unicast+0x786/0x940 net/netlink/af_netlink.c:1338
>>   netlink_sendmsg+0x9ae/0xd50 net/netlink/af_netlink.c:1927
>>   sock_sendmsg_nosec net/socket.c:654 [inline]
>>   sock_sendmsg net/socket.c:674 [inline]
>>   ____sys_sendmsg+0x519/0x800 net/socket.c:2350
>>   ___sys_sendmsg net/socket.c:2404 [inline]
>>   __sys_sendmsg+0x2bf/0x370 net/socket.c:2433
>>   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> Freed by task 9815:
>>   kasan_save_stack mm/kasan/common.c:38 [inline]
>>   kasan_set_track+0x3d/0x70 mm/kasan/common.c:46
>>   kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:357
>>   ____kasan_slab_free+0x100/0x140 mm/kasan/common.c:360
>>   kasan_slab_free include/linux/kasan.h:199 [inline]
>>   slab_free_hook mm/slub.c:1562 [inline]
>>   slab_free_freelist_hook+0x171/0x270 mm/slub.c:1600
>>   slab_free mm/slub.c:3161 [inline]
>>   kfree+0xcf/0x2d0 mm/slub.c:4213
>>   kref_put include/linux/kref.h:65 [inline]
>>   free_fw_priv drivers/base/firmware_loader/main.c:289 [inline]
>>   firmware_free_data drivers/base/firmware_loader/main.c:584 [inline]
>>   release_firmware+0x139/0x1b0 drivers/base/firmware_loader/main.c:1053
>>   _request_firmware+0x3e1/0x4c0 drivers/base/firmware_loader/main.c:839
>>   request_firmware+0x35/0x50 drivers/base/firmware_loader/main.c:875
>>   reg_reload_regdb+0x3a/0x1b0 net/wireless/reg.c:1095
>>   genl_family_rcv_msg_doit net/netlink/genetlink.c:739 [inline]
>>   genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
>>   genl_rcv_msg+0xe4e/0x1280 net/netlink/genetlink.c:800
>>   netlink_rcv_skb+0x190/0x3a0 net/netlink/af_netlink.c:2502
>>   genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
>>   netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
>>   netlink_unicast+0x786/0x940 net/netlink/af_netlink.c:1338
>>   netlink_sendmsg+0x9ae/0xd50 net/netlink/af_netlink.c:1927
>>   sock_sendmsg_nosec net/socket.c:654 [inline]
>>   sock_sendmsg net/socket.c:674 [inline]
>>   ____sys_sendmsg+0x519/0x800 net/socket.c:2350
>>   ___sys_sendmsg net/socket.c:2404 [inline]
>>   __sys_sendmsg+0x2bf/0x370 net/socket.c:2433
>>   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> Last potentially related work creation:
>>   kasan_save_stack+0x27/0x50 mm/kasan/common.c:38
>>   kasan_record_aux_stack+0xee/0x120 mm/kasan/generic.c:345
>>   __call_rcu kernel/rcu/tree.c:3039 [inline]
>>   call_rcu+0x130/0x8e0 kernel/rcu/tree.c:3114
>>   fib6_info_release include/net/ip6_fib.h:337 [inline]
>>   ip6_route_info_create+0xf84/0x17f0 net/ipv6/route.c:3736
>>   ip6_route_add+0x22/0x120 net/ipv6/route.c:3746
>>   addrconf_prefix_route net/ipv6/addrconf.c:2415 [inline]
>>   inet6_addr_add+0x99e/0x11a0 net/ipv6/addrconf.c:2948
>>   inet6_rtm_newaddr+0x754/0x2890 net/ipv6/addrconf.c:4869
>>   rtnetlink_rcv_msg+0x895/0xd50 net/core/rtnetlink.c:5553
>>   netlink_rcv_skb+0x190/0x3a0 net/netlink/af_netlink.c:2502
>>   netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
>>   netlink_unicast+0x786/0x940 net/netlink/af_netlink.c:1338
>>   netlink_sendmsg+0x9ae/0xd50 net/netlink/af_netlink.c:1927
>>   sock_sendmsg_nosec net/socket.c:654 [inline]
>>   sock_sendmsg net/socket.c:674 [inline]
>>   __sys_sendto+0x438/0x5c0 net/socket.c:1977
>>   __do_sys_sendto net/socket.c:1989 [inline]
>>   __se_sys_sendto net/socket.c:1985 [inline]
>>   __x64_sys_sendto+0xda/0xf0 net/socket.c:1985
>>   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> The buggy address belongs to the object at ffff888014188a00
>>   which belongs to the cache kmalloc-256 of size 256
>> The buggy address is located 200 bytes inside of
>>   256-byte region [ffff888014188a00, ffff888014188b00)
>> The buggy address belongs to the page:
>> page:ffffea0000506200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x14188
>> head:ffffea0000506200 order:1 compound_mapcount:0
>> flags: 0xfff00000010200(slab|head)
>> raw: 00fff00000010200 0000000000000000 0000000100000001 ffff888010841b40
>> raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
>> page dumped because: kasan: bad access detected
>>
>> Memory state around the buggy address:
>>   ffff888014188980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>   ffff888014188a00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>> ffff888014188a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>                                                ^
>>   ffff888014188b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>   ffff888014188b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> ==================================================================
> Although the patch did introduce the issue, it is perhaps just easier
> to reproduce now, so I don't think it's still not possible without the
> patch.
>
> This code is a bit of a mess. Let's clean this up for good.
>
> The issue in the Use-after-free above seems to be the list
> is already cleared. And the commit which is referenced just
> did an optimization to avoide an abort if we don't need one in
> one situation.
>
> The error codes is something we should consider... the signal situation
> reported by Martin should not be forgotten. He wanted to ensure that
> userspace can tell that the *issue* they might have been debugging was
> caused due to a signal. In their case the android init process issued
> the store and got a SIGCHLD and erronously caused a wait for the
> firmware to never load. So we added commit 76098b36b5db1 ("firmware:
> send -EINTR on signal abort on fallback mechanism") for that.
>
> The race we are seeing now is userspace races to cancel earlier,
> and so we want to also detect that and just bail earlier, avoiding
> the UAF. That requires a new fix actually.
>
> Shua's commit 0542ad88fbdd81bb ("firmware loader: Fix
> _request_firmware_load() return val for fw load abort") also wanted to
> distinguish the timeout vs -ENOMEM, but for some reason in the timeout
> case -EAGAIN was being sent back to userspace. I am no longer sure if
> that is a good idea, but since we started doing that at some point I
> guess we want to keep that behaviour.
>
> So help me bikeshed / test, how about this, the optimization is kept
> by now just checking for abort on __fw_load_abort() so it can be
> re-entrant. The rest is just trying to document a bit more of the
> motivations for the error codes, as otherwise we'd loose this
> information easily.
>
> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> index 91899d185e31..0798f6351d02 100644
> --- a/drivers/base/firmware_loader/fallback.c
> +++ b/drivers/base/firmware_loader/fallback.c
> @@ -70,7 +70,32 @@ static inline bool fw_sysfs_loading(struct fw_priv *fw_priv)
>   
>   static inline int fw_sysfs_wait_timeout(struct fw_priv *fw_priv,  long timeout)
>   {
> -	return __fw_state_wait_common(fw_priv, timeout);
> +	int ret;
> +
> +	ret = __fw_state_wait_common(fw_priv, timeout);
> +
> +	/*
> +	 * A signal could be sent to abort a wait. Consider Android's init
> +	 * gettting a SIGCHLD, which in turn was the same process issuing the
> +	 * syfs store call for the fallback. In such cases we want to be able
> +	 * to tell apart in userspace when a signal caused a failure on the
> +	 * wait. In such cases we'd get -ERESTARTSYS.
> +	 *
> +	 * Likewise though another race can happen and abort the load earlier.
> +	 *
> +	 * In either case the situation is interrupted so we just inform
> +	 * userspace of that and we end things right away.
> +	 *
> +	 * When we really time out just tell userspace it should try again,
> +	 * perhaps later.
> +	 */
> +	if (retval == -ERESTARTSYS || fw_state_is_aborted(fw_priv))
> +		ret = -EINTR;
> +	else if (ret == -ETIMEDOUT)
> +		ret = -EAGAIN
> +	else if (fw_priv->is_paged_buf && !fw_priv->data)
> +		ret = -ENOMEM;
> +	return ret;
>   }
>   
>   struct fw_sysfs {
> @@ -91,7 +116,7 @@ static void __fw_load_abort(struct fw_priv *fw_priv)
>   	 * There is a small window in which user can write to 'loading'
>   	 * between loading done and disappearance of 'loading'
>   	 */
> -	if (fw_sysfs_done(fw_priv))
> +	if (fw_state_is_aborted(fw_priv) || fw_sysfs_done(fw_priv))
>   		return;
>   
>   	list_del_init(&fw_priv->pending_list);
> @@ -513,6 +538,11 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
>   	}
>   
>   	mutex_lock(&fw_lock);
> +	if (fw_state_aborted(fw_priv)) {
> +		retval = -EINTR;
> +		mutex_unlock(&fw_lock);
> +		goto out;
> +	}
>   	list_add(&fw_priv->pending_list, &pending_fw_head);
>   	mutex_unlock(&fw_lock);
>   
> @@ -526,20 +556,12 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
>   	}
>   
>   	retval = fw_sysfs_wait_timeout(fw_priv, timeout);
> -	if (retval < 0 && retval != -ENOENT) {
> +	if (retval < 0) {
>   		mutex_lock(&fw_lock);
>   		fw_load_abort(fw_sysfs);
>   		mutex_unlock(&fw_lock);
>   	}
> -
> -	if (fw_state_is_aborted(fw_priv)) {
> -		if (retval == -ERESTARTSYS)
> -			retval = -EINTR;
> -		else
> -			retval = -EAGAIN;
> -	} else if (fw_priv->is_paged_buf && !fw_priv->data)
> -		retval = -ENOMEM;
> -
> +out:
>   	device_del(f_dev);
>   err_put_dev:
>   	put_device(f_dev);
>
