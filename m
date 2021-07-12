Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2223C5410
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344133AbhGLH4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245234AbhGLHT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:19:27 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5520AC0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 00:08:41 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id i11so4150237qvv.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 00:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jonmasters-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xsKy2MEvRih1s1FWBewjGAjD5nRKNW1X0A5UBhutlc0=;
        b=M/J/ghFoq8wgoyP88KmDvCIfGCmv/IQeWy0pyRcnf7mMXD8PjME6oRUyFYShSTvfJI
         RhS5s9VVYT/2M6sxnect5hfrx3DmbdgkDLndJsBXy3Ho49b5c+YxMndiiGlA+GRIq5wB
         V9kQDXE1dTmrmOsSD2vRJN4jgby1AI5qI9nB28SrapSekfCCvyG1ayIEb28D7wkjvAzA
         FfaDaUbFGIDo/pOvbLUj1TxENdUTZ/AklByV8i1Zdqlpc4Dax5sXQ8L6XVWozUO3X1qL
         iYg7IshrA5COPtIZml1zj2MrsAPhl+1NW1Ct+3ppYxGJup+/0DvrdgRZhmy/2011vm7R
         q+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xsKy2MEvRih1s1FWBewjGAjD5nRKNW1X0A5UBhutlc0=;
        b=jjVvP693ExGxet4JHxNVj2OvmAhl91MHspbfIrJO+wMjGUB+eK9gO0ap9LjE5sQ3wW
         wK5rwgIG77gNw02XCOwkc33Y2MMj6SXGdHsiQFjYtLM3e857UNLsT9H9aQx3CNCRfQKx
         qS9bRTWl46xea2hm5F0SZGN5hs1gcXuXYJ/CHB6R1F6pyXf7p477kOuawjCxWaxyAo8m
         3qwIVaUw3G56609eNydfeusCI1rBmkq1huUG0+WYAdFZO47G0RW+rtRI7/qUrF69R4Cl
         OUjYMaCXbvYX+D3VeZ7eSk9Rf+zx46y9524OqVtD2VCrjjLnZ3H16nWB01+z9wjO+E0y
         LfHA==
X-Gm-Message-State: AOAM530pt5tZlLSuIdBu9Lzabmkm+yXgeoHEKT0MBU5ZKAro7k+BiLE+
        SRqsD+pkTPpwGqrebm0T/pbrX70b5uhhA3Zb
X-Google-Smtp-Source: ABdhPJw1JEWvJIWVWMeujvI3k8zfoULVFSdC9lyGddeGItLHnxLr2rTjp3qtWWxKJkIYxdtUPGQyAg==
X-Received: by 2002:a05:6214:27e7:: with SMTP id jt7mr1009181qvb.28.1626073720302;
        Mon, 12 Jul 2021 00:08:40 -0700 (PDT)
Received: from independence.bos.jonmasters.org (Boston.jonmasters.org. [50.195.43.97])
        by smtp.gmail.com with ESMTPSA id o123sm6230515qkd.6.2021.07.12.00.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 00:08:39 -0700 (PDT)
Subject: Re: Linux 5.14-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wjB5XBk4obhMPfrU3mnOakV9VgHAYOo-ZGJnB2X0DnBWA@mail.gmail.com>
From:   Jon Masters <jcm@jonmasters.org>
Organization: World Organi{s,z}ation of Broken Dreams
Message-ID: <a9473821-1d53-0037-7590-aeaf8e85e72a@jonmasters.org>
Date:   Mon, 12 Jul 2021 03:08:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjB5XBk4obhMPfrU3mnOakV9VgHAYOo-ZGJnB2X0DnBWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/21 6:49 PM, Linus Torvalds wrote:
> You all know the drill by now. It's been the usual two weeks of merge
> window, and not it's closed, and 5.14-rc1 is out there.

I happened to be installing a Fedora 34 (x86) VM for something and did a 
test kernel compile that hung on boot. Setting up a serial console I get 
the below backtrace from ttm but I have not had chance to look at it.

Fedora 34 (Server Edition)
Kernel 5.14.0-rc1 on an x86_64 (ttyS0)

Web console: https://fedora:9090/ or https://192.168.1.91:9090/

fedora login: [   11.263539] BUG: kernel NULL pointer dereference, 
address: 0000000000000010
[   11.266355] #PF: supervisor read access in kernel mode
[   11.268409] #PF: error_code(0x0000) - not-present page
[   11.270456] PGD 0 P4D 0
[   11.271506] Oops: 0000 [#1] SMP PTI
[   11.272903] CPU: 1 PID: 41 Comm: kworker/1:1 Not tainted 5.14.0-rc1 #1
[   11.275488] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
0.0.0 02/06/2015
[   11.278274] Workqueue: events ttm_device_delayed_workqueue [ttm]
[   11.279865] RIP: 0010:qxl_bo_delete_mem_notify+0x19/0x40 [qxl]
[   11.281404] Code: 89 e7 45 31 e4 e8 67 bf f6 dc eb ea 0f 1f 44 00 00 
0f 1f 44 00 00 55 48 89 fd e8 a2 02 00 00 84 c0 74 0d 48 8b 85 68 01 00 
00 <83> 78 10 03 74 02 5d c3 8b 85 64 02 00 00 85 c0 74 f4 48 8b 7d 08
[   11.286271] RSP: 0018:ffffb7a24017fdd0 EFLAGS: 00010202
[   11.287616] RAX: 0000000000000000 RBX: ffff9da7c08e8670 RCX: 
ffff9da7c0b30000
[   11.288978] RDX: ffff9da7c27f7990 RSI: ffff9da7c27f7990 RDI: 
ffff9da7c27f7800
[   11.290332] RBP: ffff9da7c27f7800 R08: ffff9da7c27f7990 R09: 
0000000000000000
[   11.291690] R10: ffff9da7c991ec00 R11: 0000000000000000 R12: 
ffff9da7c27f7990
[   11.293021] R13: ffff9da7c27f7800 R14: ffff9da7c27f7960 R15: 
ffff9da7c27f7990
[   11.294349] FS:  0000000000000000(0000) GS:ffff9da937c80000(0000) 
knlGS:0000000000000000
[   11.295853] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.296935] CR2: 0000000000000010 CR3: 000000010c178004 CR4: 
0000000000370ee0
[   11.298111] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   11.299120] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   11.300130] Call Trace:
[   11.300489]  ttm_bo_cleanup_memtype_use+0x22/0x60 [ttm]
[   11.301256]  ttm_bo_release+0x1a1/0x300 [ttm]
[   11.301879]  ttm_bo_delayed_delete+0x1be/0x220 [ttm]
[   11.302587]  ttm_device_delayed_workqueue+0x18/0x40 [ttm]
[   11.303358]  process_one_work+0x1ec/0x390
[   11.303941]  worker_thread+0x53/0x3e0
[   11.304464]  ? process_one_work+0x390/0x390
[   11.305066]  kthread+0x127/0x150
[   11.305535]  ? set_kthread_struct+0x40/0x40
[   11.306188]  ret_from_fork+0x22/0x30
[   11.306749] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 
nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct 
nft_chain_nat ip6table_nat ip6table_mangle ip6table_raw 
ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 
nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ip_set 
nf_tables rfkill nfnetlink ip6table_filter ip6_tables iptable_filter 
sunrpc vfat fat snd_hda_codec_generic intel_rapl_msr snd_hda_intel 
intel_rapl_common snd_intel_dspcfg snd_hda_codec isst_if_common 
snd_hwdep snd_hda_core iTCO_wdt intel_pmc_bxt iTCO_vendor_support 
kvm_intel snd_seq snd_seq_device snd_pcm kvm joydev irqbypass i2c_i801 
rapl i2c_smbus snd_timer snd virtio_balloon lpc_ich soundcore fuse zram 
ip_tables xfs qxl drm_ttm_helper ttm drm_kms_helper crct10dif_pclmul 
crc32_pclmul crc32c_intel cec drm ghash_clmulni_intel serio_raw 
virtio_blk qemu_fw_cfg virtio_net virtio_console net_failover failover 
pkcs8_key_parser
[   11.318215] CR2: 0000000000000010
[   11.318670] ---[ end trace 20fb2a3e9bc19a76 ]---
[   11.319300] RIP: 0010:qxl_bo_delete_mem_notify+0x19/0x40 [qxl]
[   11.320090] Code: 89 e7 45 31 e4 e8 67 bf f6 dc eb ea 0f 1f 44 00 00 
0f 1f 44 00 00 55 48 89 fd e8 a2 02 00 00 84 c0 74 0d 48 8b 85 68 01 00 
00 <83> 78 10 03 74 02 5d c3 8b 85 64 02 00 00 85 c0 74 f4 48 8b 7d 08
[   11.322574] RSP: 0018:ffffb7a24017fdd0 EFLAGS: 00010202
[   11.323271] RAX: 0000000000000000 RBX: ffff9da7c08e8670 RCX: 
ffff9da7c0b30000
[   11.324226] RDX: ffff9da7c27f7990 RSI: ffff9da7c27f7990 RDI: 
ffff9da7c27f7800
[   11.325186] RBP: ffff9da7c27f7800 R08: ffff9da7c27f7990 R09: 
0000000000000000
[   11.326145] R10: ffff9da7c991ec00 R11: 0000000000000000 R12: 
ffff9da7c27f7990
[   11.327092] R13: ffff9da7c27f7800 R14: ffff9da7c27f7960 R15: 
ffff9da7c27f7990
[   11.328032] FS:  0000000000000000(0000) GS:ffff9da937c80000(0000) 
knlGS:0000000000000000
[   11.329086] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.329848] CR2: 0000000000000010 CR3: 000000010c178004 CR4: 
0000000000370ee0
[   11.330810] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   11.331746] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400


-- 
Computer Architect
