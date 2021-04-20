Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33225365718
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 13:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhDTLFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 07:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39722 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231651AbhDTLFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 07:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618916711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=KcwEdf3gqqyZ10A+jRWTee+F35Bc/kdvXATF0VWI+LM=;
        b=PZfZy+fRZqQFI6vfb129zEpZWwgu0moYHHuKvdKd0GRkQMhZ2qoNadh62zwVbPg9s2fp5k
        Plkx5HXcQfl9MdT7IBcZVEJ9OQ4B2miiM4K2RCBTzPM8R77NFoSwmuXREt2cD3lUWjxD2U
        bYDR5VEQykvS7xo72kXtYQcTlVLcbaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-njGxkePnPBqUAbu4vsEm1Q-1; Tue, 20 Apr 2021 07:05:03 -0400
X-MC-Unique: njGxkePnPBqUAbu4vsEm1Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC8AA1922960;
        Tue, 20 Apr 2021 11:05:02 +0000 (UTC)
Received: from [10.40.193.247] (unknown [10.40.193.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90F041000358;
        Tue, 20 Apr 2021 11:05:01 +0000 (UTC)
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>, John.C.Harrison@Intel.com,
        ville.syrjala@linux.intel.com
From:   Zdenek Kabelac <zkabelac@redhat.com>
Subject: Kernel freeze with Xorg on 5.12-rcX kernel bisected to
 0175969e489aaa0522e52c7d0ac06f2cab0c1ca7
Organization: Red Hat
Message-ID: <533f5105-49a9-a1c1-83d7-89c9d6396e0d@redhat.com>
Date:   Tue, 20 Apr 2021 13:05:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------68491A05CE87678256DDF62C"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------68491A05CE87678256DDF62C
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hi


My laptop (T61 c2d) can't use 5.12-rcX kernels as this commit:

--
0175969e489aaa0522e52c7d0ac06f2cab0c1ca7

Author: Chris Wilson <chris@chris-wilson.co.uk>
Date:   Tue Jan 19 21:43:34 2021 +0000

drm/i915/gem: Use shrinkable status for unknown swizzle quirks
--

Seems to be causing very early machine deadlock after 'startx'
(even Sysrq+B no longer works and 5s power-off need to be used).

I've opened issue here - but seems has got no traction:
https://gitlab.freedesktop.org/drm/intel/-/issues/3293

So I've played bisect game with above end result.

I'd to apply https://lkml.org/lkml/2021/1/23/75 to be able to compile
bisected kernels on my Rawhide's gcc)

Cause of kernel bug is list corruption i.e.:

----

kernel BUG at lib/list_debug.c:54!
invalid opcode: 0000 [#1] SMP NOPTI
CPU: 0 PID: 1606 Comm: Xorg Tainted: G     U  --------- --- 
5.12.0-0.rc4.175.fc35.x86_64 #1
Hardware name: LENOVO 6464CTO/6464CTO, BIOS 7LETC9WW (2.29 ) 03/18/2011
RIP: 0010:__list_del_entry_valid.cold+0x1d/0x47
Code: c7 c7 d8 29 61 84 e8 f4 2e fe ff 0f 0b 48 89 fe 48 c7 c7 68 2a 61 84 e8 
e3 2e fe ff 0f 0b 48 c7 c7 18 2b 61 84 e8 d5 2e fe ff <0f> 0b 48 89 f2 48 89 
fe 48 c7 c7 d8 2a 61 84 e8 c1 2e fe ff 0f 0b
RSP: 0018:ffffa4f800a3bd88 EFLAGS: 00010082
RAX: 0000000000000054 RBX: ffffa4f800a3be58 RCX: 0000000000000000
RDX: ffff9823b7826720 RSI: ffff9823b78185c0 RDI: ffff9823b78185c0
RBP: ffff9823ad542a40 R08: 0000000000000000 R09: ffffa4f800a3bbc0
R10: ffffa4f800a3bbb8 R11: ffff9823bbefcfe8 R12: ffff982389305b28
R13: 0000000000000000 R14: ffff9823ad542c30 R15: ffff982389305b20
FS:  00007f837ababa80(0000) GS:ffff9823b7800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f836fac99f0 CR3: 00000001234ee000 CR4: 00000000000006f0
Call Trace:
  i915_gem_madvise_ioctl+0x1fc/0x2b0 [i915]
  ? i915_gem_pwrite_ioctl+0x480/0x480 [i915]
  drm_ioctl_kernel+0x8e/0xe0 [drm]
  drm_ioctl+0x21e/0x3b0 [drm]
  ? i915_gem_pwrite_ioctl+0x480/0x480 [i915]
  __x64_sys_ioctl+0x82/0xb0
  do_syscall_64+0x33/0x40
  entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f837b3f52ab
Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 
1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 
01 c3 48 8b 0d 95 bb 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffe12d62cb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f8379dcd360 RCX: 00007f837b3f52ab
RDX: 00007ffe12d62d00 RSI: 00000000c00c6466 RDI: 000000000000000d
RBP: 000000000000000d R08: 000055dee119e9c0 R09: 00000000605c6199
R10: 00007ffe12d7d080 R11: 0000000000000246 R12: 000055dee1884ed0
R13: 00000000c00c6466 R14: 00007f8379dcd000 R15: 00007ffe12d62d00
Modules linked in: rfcomm ccm xt_CHECKSUM xt_MASQUERADE xt_conntrack 
ipt_REJECT nf_reject_ipv4 ip6table_mangle ip6table_nat ip6table_filter 
ip6_tables iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 
nf_defrag_ipv4 iptable_filter bridge stp llc cmac bnep btusb btrtl btbcm 
btintel bluetooth ecdh_generic ecc coretemp snd_hda_codec_analog 
snd_hda_codec_generic kvm_intel kvm iTCO_wdt intel_pmc_bxt iTCO_vendor_support 
iwl3945 iwlegacy snd_hda_intel irqbypass snd_intel_dspcfg snd_intel_sdw_acpi 
mac80211 snd_hda_codec snd_hda_core pcspkr snd_hwdep snd_seq snd_seq_device 
snd_pcm cfg80211 joydev i2c_i801 wmi_bmof i2c_smbus thinkpad_acpi e1000e r592 
snd_timer lpc_ich memstick platform_profile
ledtrig_audio libarc4 snd soundcore rfkill acpi_cpufreq binfmt_misc nfsd 
auth_rpcgss fuse nfs_acl lockd grace sunrpc nfs_ssc ip_tables i915 
i2c_algo_bit drm_kms_helper cec drm sdhci_pci cqhci sdhci serio_raw mmc_core 
ata_generic wmi yenta_socket pata_acpi video

----

Interesting to note could be also that my 5.11 kernel takes quite some time
to show xfce desktop once after 'startx' command is executed - for many 
seconds there is just black screen.

While doing bisect it seems it starts with commit:

41a9c75d0acf23f33f012d3f9535de9e9b631051

the preceding commit in my bisection 'game' seemed to be starting much faster:

30d2bfd093839cf6eef93f9c2cbdc347c7bf8b20

Anyway - the head of this message is more important to resolve.

Regards

Zdenek

--------------68491A05CE87678256DDF62C
Content-Type: text/x-vcard;
 name="zkabelac.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="zkabelac.vcf"

bnVsbA==
--------------68491A05CE87678256DDF62C--

