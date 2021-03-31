Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470263502D8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 16:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbhCaO4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 10:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbhCaOz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:55:58 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC59C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 07:55:57 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id e186so2869340iof.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 07:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8D4VTrlFkEevlwQQ8KFcoUmnsF1BYz017hb8Bwo08u0=;
        b=gj3pK55NISnEUlOrHHIib9ZOXHWUI4skS0e739ETAFRp8s4rB3Wh48feGMbD81I3i4
         mmZvmMAJDUnM2rrhVoWbwZbYYaplQxTBEEszNGe8H/XvXBE9sw5K9sp9R4QQaPYGCju8
         DuTWO3UehVj9eys4qS7jV7kD3VwdGPPKOhapzoBJLrj6uM6P0GYfXGVSMBmBX8neWr+p
         3jblcQt+RsLz1XdV5/Yr87fMU9sW1TAvAVthbuGG1cItd2N3DCe5YTXhQiL2sToVv2vc
         Tp5aOjTXqzCF0C+77EF8TMH1pKZ4FTqkt4zTpXugTLmj1PVVc2mqv3u7fcBvqjE69KSC
         IqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8D4VTrlFkEevlwQQ8KFcoUmnsF1BYz017hb8Bwo08u0=;
        b=DGfxWfVhPViAtA/GOOXfF1UMyBT+Uy5gBT27mw/5SmU4qjFoOFOJ1V5HL8A60f8GKW
         OxQspoOn/6DmxTAKP1LGuXfx/3xgHa/EWF3wGRtcDMKMPRKzaGwAKiEU6vzR1P2CYUQI
         7WLxGh8bh4R7fAkbTx/KonjsEJe0FywpwqYlmBAi00ev+9xATGy/HUjDWkmRxGnFJEpU
         GYU9s5A3L08TFznZFbzYRERjBkFCduPxfPJLRkwnAXoutJRMLLADupf7yiO3QtC0swk+
         Ze4hRP+55rlpBaOZBgcksDUSX5gs3sTKIk1CG52l3aus4QPywj97sEUgUhGbolORT2av
         XMdw==
X-Gm-Message-State: AOAM533jIScneF6zotfq9YeHYLRKu6870GkwAzjRbaiVyR4kd0t0H/FT
        yV+8JfOrgqtgIEePGQXJZCMjdg==
X-Google-Smtp-Source: ABdhPJwP9FAAaHJqcUWIWqTV3iz4hLjXMLGOWMlcvcZlnJFSLf+j/umZf4mQTIcHAUncFfgGz0nTQQ==
X-Received: by 2002:a05:6638:2044:: with SMTP id t4mr3499757jaj.12.1617202556352;
        Wed, 31 Mar 2021 07:55:56 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o8sm1191501ilt.4.2021.03.31.07.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 07:55:56 -0700 (PDT)
Subject: Re: [block] 4c95131e3c: kernel_BUG_at_block/bio.c
To:     kernel test robot <oliver.sang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
References: <20210331081330.GB32402@xsang-OptiPlex-9020>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8540963a-a408-64e8-cebe-095e4835e7b8@kernel.dk>
Date:   Wed, 31 Mar 2021 08:55:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210331081330.GB32402@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/21 2:13 AM, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 4c95131e3cb8bbb08c3b370b4ae3611874b48be0 ("block: enable use of bio allocation cache")
> https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git io_uring-bio-cache
> 
> 
> in testcase: ocfs2test
> version: ocfs2test-x86_64-d802bf7-1_20210329
> with following parameters:
> 
> 	disk: 1HDD
> 	test: test-reserve_space
> 	ucode: 0x21
> 
> 
> 
> on test machine: 8 threads Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz with 16G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [   47.859997] kernel BUG at block/bio.c:628!
> [   47.860086] invalid opcode: 0000 [#1] SMP PTI
> [   47.860167] CPU: 5 PID: 5042 Comm: mkfs.ocfs2 Not tainted 5.12.0-rc5-00060-g4c95131e3cb8 #1
> [   47.860317] Hardware name:  /DZ77BH-55K, BIOS BHZ7710H.86A.0097.2012.1228.1346 12/28/2012
> [   47.860445] RIP: 0010:__bio_put (kbuild/src/consumer/block/bio.c:628 kbuild/src/consumer/block/bio.c:623) 
> [ 47.860514] Code: 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 f6 47 14 40 74 0f 8b 47 64 85 c0 74 0e f0 ff 4f 64 0f 94 c0 c3 b8 01 00 00 00 c3 <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00
> All code
> ========
>    0:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
>    7:	00 00 00 
>    a:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>    f:	f6 47 14 40          	testb  $0x40,0x14(%rdi)
>   13:	74 0f                	je     0x24
>   15:	8b 47 64             	mov    0x64(%rdi),%eax
>   18:	85 c0                	test   %eax,%eax
>   1a:	74 0e                	je     0x2a
>   1c:	f0 ff 4f 64          	lock decl 0x64(%rdi)
>   20:	0f 94 c0             	sete   %al
>   23:	c3                   	retq   
>   24:	b8 01 00 00 00       	mov    $0x1,%eax
>   29:	c3                   	retq   
>   2a:*	0f 0b                	ud2    		<-- trapping instruction
>   2c:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
>   33:	00 00 00 00 
>   37:	66                   	data16
>   38:	66                   	data16
>   39:	2e                   	cs
>   3a:	0f                   	.byte 0xf
>   3b:	1f                   	(bad)  
>   3c:	84 00                	test   %al,(%rax)
> 	...
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2    
>    2:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
>    9:	00 00 00 00 
>    d:	66                   	data16
>    e:	66                   	data16
>    f:	2e                   	cs
>   10:	0f                   	.byte 0xf
>   11:	1f                   	(bad)  
>   12:	84 00                	test   %al,(%rax)
> 	...
> [   47.860801] RSP: 0018:ffffc9000d42fc88 EFLAGS: 00010246
> [   47.860885] RAX: 0000000000000000 RBX: ffffc9000d42fe80 RCX: 0000000000000002
> [   47.860998] RDX: ffff88841a9a4f00 RSI: ffff88841a9a4f00 RDI: ffff88841b721318
> [   47.861109] RBP: ffff88841b721318 R08: ffff88841b721318 R09: 000000000002ab30
> [   47.861221] R10: 00000000000002c8 R11: ffff88841f36a144 R12: ffff88841b721318
> [   47.861352] R13: ffffffff81395875 R14: 00000000ffffffff R15: ffff88841a9a4f00
> [   47.861464] FS:  00007f5c66517280(0000) GS:ffff88841f340000(0000) knlGS:0000000000000000
> [   47.861590] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   47.861681] CR2: 000055d13280c000 CR3: 0000000414e82006 CR4: 00000000001706e0
> [   47.861793] Call Trace:
> [   47.861836] bio_put (kbuild/src/consumer/block/bio.c:646) 
> [   47.861888] __blkdev_direct_IO (kbuild/src/consumer/fs/block_dev.c:508) 
> [   47.861959] generic_file_direct_write (kbuild/src/consumer/mm/filemap.c:3473) 
> [   47.862037] __generic_file_write_iter (kbuild/src/consumer/mm/filemap.c:3661) 
> [   47.862113] blkdev_write_iter (kbuild/src/consumer/fs/block_dev.c:1719 kbuild/src/consumer/fs/block_dev.c:1693) 
> [   47.862181] new_sync_write (kbuild/src/consumer/fs/read_write.c:519 (discriminator 1)) 
> [   47.862265] vfs_write (kbuild/src/consumer/fs/read_write.c:605) 
> [   47.862322] ksys_pwrite64 (kbuild/src/consumer/include/linux/file.h:45 kbuild/src/consumer/fs/read_write.c:713) 
> [   47.862381] do_syscall_64 (kbuild/src/consumer/arch/x86/entry/common.c:46) 
> [   47.862443] entry_SYSCALL_64_after_hwframe (kbuild/src/consumer/arch/x86/entry/entry_64.S:112) 
> [   47.862526] RIP: 0033:0x7f5c66692a37
> [ 47.862586] Code: ff ff eb b6 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8d 05 c9 7c 0d 00 49 89 ca 8b 00 85 c0 75 10 b8 12 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 59 c3 41 55 49 89 cd 41 54 49 89 d4 55 48 89

Thanks for the report, I've fixed this up in the current branch and
pushed a new one out.

-- 
Jens Axboe

