Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60032319FDF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 14:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhBLN3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 08:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhBLN3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 08:29:05 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDC2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 05:28:25 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id a22so11493822ljp.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 05:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IAMhs+oC68l6RpTLnw9lEMqE4kcuffpa29tr0TompTM=;
        b=tgOywxxdXhlQikCbiZHJ9O8XRVSTU0pEKqWMesVQtIRfgYwGF42bP3KEXKJp4fGYce
         Q/1R229H2yFctP2MZ8m07Kh94eqOetUKXHZc5x0iY3rB+i0rv0dkgINbCPcxfgAUPGKQ
         4J0VO45ep5S38U9HV6E0pRufhZLA6HCjYqLJ9yfpkcpkQ2NdcxjGwMCCoQIsZU5IIHsA
         ixRx/OL1+R5awRVwjWRsnePFQF5woQIjkdx1qW+vaqJKwV/Fb97e0Gz2AHyslxWJwuaq
         MAefkJuGglylLZNyrRvaErypXj8KZvCX9AaTh226WAzU6soBGya6XR4svnXwbJKYY35H
         4+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IAMhs+oC68l6RpTLnw9lEMqE4kcuffpa29tr0TompTM=;
        b=NL9CkmlZyDhFIUP1UWS7lPfF8vp7LLAvnbKA2va39bqM277v5VRdia1bK+YAc/4/js
         mI8NTu6/csCPapVlh7W90afi0P6FnS/FmkaQoULmpzVccRwthBRHPXgxpeK99iWr4SX9
         Ucf8j8NIocgpcogDIhW+qKdeOFRCZh0DW8fGSHCWhXsc4KlLY9jCg0gEgmQHEW4qzk8l
         jIqMN7FEf2C8rYfvdZjLWng4SWrAIKSIS4tvSqMoilOPAwZrJiwZnbXEK9UJ3uMohqnv
         Ky7WvLqN0zWFcUULCPs07uLFg6N5KXrhyU8XAzuZ/ZCX+hdcewtr2ztKr/ZnFlSCA3/N
         U+uA==
X-Gm-Message-State: AOAM530H2wNLLs5p7idD9zaFg3qgsYuagL0DtjLFnJfOMhZUZ1j/ztGG
        6L0eoM579qU5dkObJGUrhJ5SmxKg8YWDuVaZvg4=
X-Google-Smtp-Source: ABdhPJx2ynS5rnwM6ORUzVJrJM2zPXH5F+7+Ux/vkptOjC5+EcWht2eAV9Pov8vWpNR5eh1BmpUYYIJNRfbjNCugfjU=
X-Received: by 2002:a2e:960d:: with SMTP id v13mr1695108ljh.370.1613136503426;
 Fri, 12 Feb 2021 05:28:23 -0800 (PST)
MIME-Version: 1.0
References: <20210126082834.2020-1-hdanton@sina.com>
In-Reply-To: <20210126082834.2020-1-hdanton@sina.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Fri, 12 Feb 2021 18:28:12 +0500
Message-ID: <CABXGCsNN+u2SqOvmw2JojTnESSLgxKgfJLQuB3Ne1fcNA47UZw@mail.gmail.com>
Subject: Re: BUG: KASAN: use-after-free in __list_add_valid+0x81/0xa0 (5.11-rc4)
To:     Hillf Danton <hdanton@sina.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021 at 13:28, Hillf Danton <hdanton@sina.com> wrote:
>
>
> BTW better run the reproducer again with KASAN enabled.
>

It happened today again with kernel 5.11 rc7 (e0756cfc7d7c)
Why not try your patch?

list_del corruption, ffffdef70143e848->next is LIST_POISON1 (dead000000000100)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:45!
invalid opcode: 0000 [#1] SMP NOPTI
CPU: 13 PID: 263 Comm: kswapd0 Tainted: G        W        ---------
---  5.11.0-0.rc7.20210210gite0756cfc7d7c.150.fc35.x86_64 #1
Hardware name: System manufacturer System Product Name/ROG STRIX
X570-I GAMING, BIOS 3402 01/13/2021
RIP: 0010:__list_del_entry_valid.cold+0xf/0x47
Code: fe ff 0f 0b 48 89 d1 4c 89 c6 4c 89 ca 48 c7 c7 e0 26 64 9e e8
1b 12 fe ff 0f 0b 48 89 fe 48 c7 c7 70 27 64 9e e8 0a 12 fe ff <0f> 0b
48 c7 c7 20 28 64 9e e8 fc 11 fe ff 0f 0b 48 89 f2 48 89 fe
RSP: 0018:ffff9f2180863908 EFLAGS: 00010286
RAX: 000000000000004e RBX: ffff8f74d0fa1000 RCX: 0000000000000000
RDX: ffff8f7c885e9f60 RSI: ffff8f7c885db2a0 RDI: ffff8f7c885db2a0
RBP: ffff8f74d0fa1000 R08: 0000000000000000 R09: ffff9f2180863748
R10: ffff9f2180863740 R11: 0000000000000000 R12: ffff8f758edd8e00
R13: 0000000000012800 R14: ffffdef70143e840 R15: ffff8f758edd8e08
FS:  0000000000000000(0000) GS:ffff8f7c88400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000037203acb1000 CR3: 00000001d5c28000 CR4: 0000000000350ee0
Call Trace:
 z3fold_zpool_malloc+0x3e3/0x780
 ? _raw_spin_unlock+0x1f/0x30
 zswap_frontswap_store+0x43e/0x890
 __frontswap_store+0xc8/0x170
 swap_writepage+0x39/0x70
 pageout+0x125/0x540
 shrink_page_list+0x1329/0x1bc0
 shrink_inactive_list+0x12a/0x440
 shrink_lruvec+0x4a9/0x6d0
 ? super_cache_count+0x79/0xf0
 shrink_node+0x2d1/0x700
 balance_pgdat+0x2f5/0x650
 kswapd+0x21d/0x4d0
 ? do_wait_intr_irq+0xd0/0xd0
 ? balance_pgdat+0x650/0x650
 kthread+0x13a/0x150
 ? __kthread_bind_mask+0x60/0x60
 ret_from_fork+0x22/0x30
Modules linked in: tun snd_seq_dummy snd_hrtimer uinput rfcomm
nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
nf_reject_ipv6 nft_reject nft_ct nft_chain_nat ip6table_nat
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw
iptable_security ip_set nf_tables nfnetlink ip6table_filter ip6_tables
iptable_filter cmac bnep zstd sunrpc vfat fat hid_logitech_hidpp
hid_logitech_dj snd_hda_codec_realtek snd_hda_codec_generic
ledtrig_audio snd_hda_codec_hdmi snd_hda_intel mt76x2u
snd_intel_dspcfg soundwire_intel mt76x2_common mt76x02_usb
soundwire_generic_allocation mt76_usb intel_rapl_msr iwlmvm
snd_soc_core snd_usb_audio intel_rapl_common mt76x02_lib mt76
snd_compress snd_pcm_dmaengine snd_usbmidi_lib soundwire_cadence
snd_rawmidi mac80211 snd_hda_codec joydev snd_hda_core uvcvideo
ac97_bus snd_hwdep btusb snd_seq
 videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 snd_seq_device
btrtl edac_mce_amd btbcm iwlwifi snd_pcm videobuf2_common btintel
kvm_amd eeepc_wmi snd_timer bluetooth kvm videodev asus_wmi snd
ecdh_generic sparse_keymap irqbypass xpad mc libarc4 sp5100_tco rapl
ff_memless cfg80211 wmi_bmof ecc video pcspkr soundcore k10temp
i2c_piix4 rfkill acpi_cpufreq binfmt_misc ip_tables amdgpu
drm_ttm_helper ttm iommu_v2 gpu_sched drm_kms_helper crct10dif_pclmul
crc32_pclmul crc32c_intel cec drm ghash_clmulni_intel igb ccp nvme dca
nvme_core i2c_algo_bit wmi pinctrl_amd fuse
---[ end trace a0c35e2a81af0791 ]---
RIP: 0010:__list_del_entry_valid.cold+0xf/0x47
Code: fe ff 0f 0b 48 89 d1 4c 89 c6 4c 89 ca 48 c7 c7 e0 26 64 9e e8
1b 12 fe ff 0f 0b 48 89 fe 48 c7 c7 70 27 64 9e e8 0a 12 fe ff <0f> 0b
48 c7 c7 20 28 64 9e e8 fc 11 fe ff 0f 0b 48 89 f2 48 89 fe
RSP: 0018:ffff9f2180863908 EFLAGS: 00010286
RAX: 000000000000004e RBX: ffff8f74d0fa1000 RCX: 0000000000000000
RDX: ffff8f7c885e9f60 RSI: ffff8f7c885db2a0 RDI: ffff8f7c885db2a0
RBP: ffff8f74d0fa1000 R08: 0000000000000000 R09: ffff9f2180863748
R10: ffff9f2180863740 R11: 0000000000000000 R12: ffff8f758edd8e00
R13: 0000000000012800 R14: ffffdef70143e840 R15: ffff8f758edd8e08
FS:  0000000000000000(0000) GS:ffff8f7c88400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000037203acb1000 CR3: 00000001d5c28000 CR4: 0000000000350ee0
note: kswapd0[263] exited with preempt_count 2


full kernel log: https://pastebin.com/FL1fZLJ0

-- 
Best Regards,
Mike Gavrilov.
