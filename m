Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF973CED82
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385021AbhGSSn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 14:43:28 -0400
Received: from mta-out1.inet.fi ([62.71.2.226]:55302 "EHLO julia1.inet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1384183AbhGSSY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:24:58 -0400
X-Greylist: delayed 417 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jul 2021 14:24:57 EDT
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvtddrfedtgdduvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuuffpveftnecuuegrihhlohhuthemuceftddtnecunecujfgurhepvffhuffkffgfgggtgfesthekredttdefjeenucfhrhhomhepkfhlkhhkrgcurfhruhhsihcuoehilhhkkhgrrdhprhhushhisehpphdrihhnvghtrdhfiheqnecuggftrfgrthhtvghrnhephfeigfehueefteduuefguefgveffhffgueeiieffffejvdeijedtuefhieduvedtnecukfhppeekgedrvdehuddrudelgedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrkeegngdpihhnvghtpeekgedrvdehuddrudelgedrudeigedpmhgrihhlfhhrohhmpeeophhruhhsihhlqddusehmsghogidrihhnvghtrdhfihequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
Received: from [192.168.1.84] (84.251.194.164) by julia1.inet.fi (9.0.019.26-1) (authenticated as prusil-1)
        id 60F143C2000D38C7 for linux-kernel@vger.kernel.org; Mon, 19 Jul 2021 21:58:15 +0300
To:     linux-kernel@vger.kernel.org
From:   Ilkka Prusi <ilkka.prusi@pp.inet.fi>
Subject: RCU splat in 5.13.3: kernel/rcu/tree_plugin.h:359
 rcu_note_context_switch
Message-ID: <cdc494ae-2aec-836a-5883-c54e99db2075@pp.inet.fi>
Date:   Mon, 19 Jul 2021 21:58:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've encountered this splat for a second time, previously with 5.13.2 
and now with 5.13.3.

Closing the browser seemed to trigger this (I was following with dmesg -w).

Splat with decode_stacktrace below. I'm not on the list so cc me if 
additional info is needed.

  - Ilkka

[16370.451116] ------------[ cut here ]------------
[16370.451122] WARNING: CPU: 15 PID: 6417 at 
kernel/rcu/tree_plugin.h:359 rcu_note_context_switch 
(kernel/rcu/tree_plugin.h:359)
[16370.451129] Modules linked in: snd_seq_dummy(E) snd_seq(E) uinput(E) 
nfnetlink(E) binfmt_misc(E) nls_ascii(E) nls_cp850(E) vfat(E) fat(E) 
amdgpu(E) intel_rapl_msr(E) intel_rapl_common(E) iosf_mbi(E) 
edac_mce_amd(E) kvm_amd(E) snd_hda_codec_realtek(E) kvm(E) 
snd_usb_audio(E) snd_hda_codec_generic(E) gpu_sched(E) igb(E) 
snd_usbmidi_lib(E) snd_hda_codec_hdmi(E) snd_rawmidi(E) ledtrig_audio(E) 
snd_hda_intel(E) irqbypass(E) drm_ttm_helper(E) snd_seq_device(E) 
snd_intel_dspcfg(E) hid_sony(E) ttm(E) mc(E) drm_kms_helper(E) 
snd_hda_codec(E) syscopyarea(E) sysfillrect(E) ff_memless(E) 
snd_hda_core(E) sysimgblt(E) snd_hwdep(E) crct10dif_pclmul(E) 
crc32_pclmul(E) snd_pcm(E) ghash_clmulni_intel(E) dca(E) ccp(E) 
fb_sys_fops(E) snd_timer(E) aesni_intel(E) cec(E) i2c_algo_bit(E) 
rng_core(E) snd(E) soundcore(E) sg(E) wmi_bmof(E) i2c_piix4(E) 
crypto_simd(E) k10temp(E) cryptd(E) acpi_cpufreq(E) rapl(E) wmi(E) 
efi_pstore(E) button(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E)
[16370.451166]  sunrpc(E) drm(E) msr(E) agpgart(E) fuse(E) configfs(E) 
efivarfs(E) ip_tables(E) x_tables(E) ipv6(E) autofs4(E) efivars(E) 
raid10(E) raid456(E) libcrc32c(E) async_raid6_recov(E) async_memcpy(E) 
async_pq(E) async_xor(E) xor(E) async_tx(E) raid6_pq(E) raid1(E) 
raid0(E) multipath(E) linear(E) md_mod(E) input_leds(E) evdev(E) 
joydev(E) hid_generic(E) usbhid(E) hid(E) xhci_pci(E) xhci_hcd(E) 
crc32c_intel(E) usbcore(E) sd_mod(E) t10_pi(E) thermal(E)
[16370.451190] CPU: 15 PID: 6417 Comm: Chrome_ChildIOT Tainted: 
G            E     5.13.3 #61
[16370.451194] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS 
ELITE/X570 AORUS ELITE, BIOS F21 08/20/2020
[16370.451196] RIP: 0010:rcu_note_context_switch 
(kernel/rcu/tree_plugin.h:359)
[16370.451200] Code: 25 c0 6c 01 00 41 54 55 89 fd 53 48 c7 c3 40 1b 02 
00 65 48 03 1d b0 57 f5 7e 40 84 ff 75 0d 41 8b 95 0c 03 00 00 85 d2 7e 
02 <0f> 0b 65 48 8b 04 25 c0 6c 01 00 8b 80 0c 03 00 00 85 c0 7e 0a 41
All code
========
    0:    25 c0 6c 01 00           and    $0x16cc0,%eax
    5:    41 54                    push   %r12
    7:    55                       push   %rbp
    8:    89 fd                    mov    %edi,%ebp
    a:    53                       push   %rbx
    b:    48 c7 c3 40 1b 02 00     mov    $0x21b40,%rbx
   12:    65 48 03 1d b0 57 f5     add %gs:0x7ef557b0(%rip),%rbx        
# 0x7ef557ca
   19:    7e
   1a:    40 84 ff                 test   %dil,%dil
   1d:    75 0d                    jne    0x2c
   1f:    41 8b 95 0c 03 00 00     mov    0x30c(%r13),%edx
   26:    85 d2                    test   %edx,%edx
   28:    7e 02                    jle    0x2c
   2a:*    0f 0b                    ud2            <-- trapping instruction
   2c:    65 48 8b 04 25 c0 6c     mov    %gs:0x16cc0,%rax
   33:    01 00
   35:    8b 80 0c 03 00 00        mov    0x30c(%rax),%eax
   3b:    85 c0                    test   %eax,%eax
   3d:    7e 0a                    jle    0x49
   3f:    41                       rex.B

Code starting with the faulting instruction
===========================================
    0:    0f 0b                    ud2
    2:    65 48 8b 04 25 c0 6c     mov    %gs:0x16cc0,%rax
    9:    01 00
    b:    8b 80 0c 03 00 00        mov    0x30c(%rax),%eax
   11:    85 c0                    test   %eax,%eax
   13:    7e 0a                    jle    0x1f
   15:    41                       rex.B
[16370.451202] RSP: 0000:ffffc90002fa3af0 EFLAGS: 00010002
[16370.451205] RAX: 0000000000000001 RBX: ffff88842ebe1b40 RCX: 
0000000000000000
[16370.451206] RDX: 0000000000000001 RSI: ffffea000e152ac0 RDI: 
0000000000000000
[16370.451208] RBP: 0000000000000000 R08: 0000000000000000 R09: 
0000000000000010
[16370.451209] R10: ffffffffffffffe9 R11: 0000000000000002 R12: 
0000000000000000
[16370.451211] R13: ffff88812c330000 R14: ffffea000e152ac0 R15: 
ffff88842ebe0e80
[16370.451212] FS:  00007fec7df73700(0000) GS:ffff88842ebc0000(0000) 
knlGS:0000000000000000
[16370.451214] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[16370.451216] CR2: 00007fec7af55000 CR3: 0000000105dc4000 CR4: 
00000000001506e0
[16370.451217] Call Trace:
[16370.451221] __schedule (kernel/sched/sched.h:1334 
kernel/sched/core.c:5065)
[16370.451225] schedule (./arch/x86/include/asm/preempt.h:85 
(discriminator 1) kernel/sched/core.c:5231 (discriminator 1))
[16370.451228] io_schedule (kernel/sched/core.c:7193 
kernel/sched/core.c:7219)
[16370.451230] wait_on_page_bit_common (mm/filemap.c:1293)
[16370.451234] ? __filemap_set_wb_err (./include/linux/pagemap.h:593 
mm/filemap.c:1080)
[16370.451237] shmem_swapin_page (./include/linux/pagemap.h:626 
mm/shmem.c:1732)
[16370.451240] ? xas_load (./include/linux/xarray.h:169 
./include/linux/xarray.h:1226 lib/xarray.c:235)
[16370.451243] ? pagecache_get_page (mm/filemap.c:1841)
[16370.451246] shmem_getpage_gfp (mm/shmem.c:1838)
[16370.451249] shmem_fault (mm/shmem.c:2130)
[16370.451252] __do_fault (mm/memory.c:3728)
[16370.451254] __handle_mm_fault (mm/memory.c:4032 mm/memory.c:4160 
mm/memory.c:4419 mm/memory.c:4554)
[16370.451257] handle_mm_fault (mm/memory.c:4652)
[16370.451259] exc_page_fault (./include/linux/sched/signal.h:404 
arch/x86/mm/fault.c:1392 arch/x86/mm/fault.c:1475 arch/x86/mm/fault.c:1531)
[16370.451262] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:568)
[16370.451264] asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:568)
[16370.451266] RIP: 0033:0x55e50d28b456
[16370.451268] Code: e8 3f f4 ff ff eb 48 41 8b 42 24 89 c1 83 c9 02 45 
31 f6 f0 41 0f b1 4a 24 74 34 89 c1 83 c9 02 f0 41 0f b1 4a 24 75 f3 eb 
25 <41> 83 3b 00 75 17 41 83 7b 04 00 75 10 41 8b 43 08 85 c0 75 08 41
All code
========
    0:    e8 3f f4 ff ff           callq  0xfffffffffffff444
    5:    eb 48                    jmp    0x4f
    7:    41 8b 42 24              mov    0x24(%r10),%eax
    b:    89 c1                    mov    %eax,%ecx
    d:    83 c9 02                 or     $0x2,%ecx
   10:    45 31 f6                 xor    %r14d,%r14d
   13:    f0 41 0f b1 4a 24        lock cmpxchg %ecx,0x24(%r10)
   19:    74 34                    je     0x4f
   1b:    89 c1                    mov    %eax,%ecx
   1d:    83 c9 02                 or     $0x2,%ecx
   20:    f0 41 0f b1 4a 24        lock cmpxchg %ecx,0x24(%r10)
   26:    75 f3                    jne    0x1b
   28:    eb 25                    jmp    0x4f
   2a:*    41 83 3b 00              cmpl   $0x0,(%r11) <-- trapping 
instruction
   2e:    75 17                    jne    0x47
   30:    41 83 7b 04 00           cmpl   $0x0,0x4(%r11)
   35:    75 10                    jne    0x47
   37:    41 8b 43 08              mov    0x8(%r11),%eax
   3b:    85 c0                    test   %eax,%eax
   3d:    75 08                    jne    0x47
   3f:    41                       rex.B

Code starting with the faulting instruction
===========================================
    0:    41 83 3b 00              cmpl   $0x0,(%r11)
    4:    75 17                    jne    0x1d
    6:    41 83 7b 04 00           cmpl   $0x0,0x4(%r11)
    b:    75 10                    jne    0x1d
    d:    41 8b 43 08              mov    0x8(%r11),%eax
   11:    85 c0                    test   %eax,%eax
   13:    75 08                    jne    0x1d
   15:    41                       rex.B
[16370.451270] RSP: 002b:00007fec7df71520 EFLAGS: 00010246
[16370.451272] RAX: 0000000000027000 RBX: 0000000000019000 RCX: 
0000000000040000
[16370.451273] RDX: 00000000000270a0 RSI: 00000000000000a0 RDI: 
00001f03e4c26b00
[16370.451275] RBP: 00007fec7df71530 R08: 00000000f1645913 R09: 
0000000000027000
[16370.451276] R10: 00007fec7af2e000 R11: 00007fec7af55000 R12: 
0000000000000001
[16370.451277] R13: 00001f03e4c28500 R14: 0000000000000000 R15: 
000000000000008d
[16370.451280] ---[ end trace 1077aeee7e77856f ]---

