Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D14E3F1AED
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 15:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240246AbhHSNw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 09:52:27 -0400
Received: from mta-out1.inet.fi ([62.71.2.202]:38188 "EHLO julia1.inet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238498AbhHSNw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 09:52:26 -0400
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvtddrleejgdeikecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfupfevtfenuceurghilhhouhhtmecufedttdenucenucfjughrpefvhffukffffgggtgfgsehtkeertddtfeejnecuhfhrohhmpefklhhkkhgrucfrrhhushhiuceoihhlkhhkrgdrphhruhhsihesphhprdhinhgvthdrfhhiqeenucggtffrrghtthgvrhhnpefhiefgheeufeetudeugfeugfevfffhgfeuieeiffffjedvieejtdeuhfeiudevtdenucfkphepkeegrddvhedurdduleegrdduieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutddvngdpihhnvghtpeekgedrvdehuddrudelgedrudeigedpmhgrihhlfhhrohhmpeeophhruhhsihhlqddusehmsghogidrihhnvghtrdhfihequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
Received: from [192.168.1.102] (84.251.194.164) by julia1.inet.fi (9.0.019.26-1) (authenticated as prusil-1)
        id 611D1CEC0006FE56 for linux-kernel@vger.kernel.org; Thu, 19 Aug 2021 16:51:44 +0300
To:     linux-kernel@vger.kernel.org
From:   Ilkka Prusi <ilkka.prusi@pp.inet.fi>
Subject: Splat in 5.13.12: WARNING at drivers/gpu/drm/drm_syncobj.c:400
 drm_syncobj_find_fence
Message-ID: <1f29998e-5fc8-d419-c4c8-5274c4ea5a73@pp.inet.fi>
Date:   Thu, 19 Aug 2021 16:51:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

New splat in 5.13.12 when starting a game under Proton (Cyberpunk 2077).

Running it through decode_stacktrace.sh gives following:

[83637.013059] WARNING: CPU: 1 PID: 66899 at 
drivers/gpu/drm/drm_syncobj.c:400 drm_syncobj_find_fence 
(drivers/gpu/drm/drm_syncobj.c:400) drm
[83637.013109] Modules linked in: uinput(E) nfnetlink(E) binfmt_misc(E) 
nls_ascii(E) nls_cp850(E) vfat(E) fat(E) amdgpu(E) intel_rapl_msr(E) 
intel_rapl_common(E) iosf_mbi(E) edac_mce_amd(E) 
snd_hda_codec_realtek(E) snd_hda_codec_generic(E) kvm_amd(E) 
ledtrig_audio(E) gpu_sched(E) snd_hda_codec_hdmi(E) drm_ttm_helper(E) 
hid_sony(E) ff_memless(E) kvm(E) ttm(E) snd_hda_intel(E) 
snd_intel_dspcfg(E) snd_usb_audio(E) drm_kms_helper(E) snd_hda_codec(E) 
snd_usbmidi_lib(E) snd_hda_core(E) snd_rawmidi(E) snd_hwdep(E) igb(E) 
snd_seq_device(E) mc(E) irqbypass(E) syscopyarea(E) snd_pcm(E) 
sysfillrect(E) crct10dif_pclmul(E) crc32_pclmul(E) sysimgblt(E) 
fb_sys_fops(E) snd_timer(E) ghash_clmulni_intel(E) snd(E) aesni_intel(E) 
ccp(E) soundcore(E) dca(E) cec(E) i2c_algo_bit(E) crypto_simd(E) 
cryptd(E) k10temp(E) i2c_piix4(E) rng_core(E) button(E) wmi_bmof(E) 
sg(E) rapl(E) acpi_cpufreq(E) efi_pstore(E) wmi(E) nfsd(E) 
auth_rpcgss(E) drm(E) nfs_acl(E) lockd(E) msr(E) grace(E) agpgart(E)
[83637.013159]  sunrpc(E) fuse(E) configfs(E) efivarfs(E) ip_tables(E) 
x_tables(E) ipv6(E) autofs4(E) efivars(E) raid10(E) raid456(E) 
libcrc32c(E) async_raid6_recov(E) async_memcpy(E) async_pq(E) 
async_xor(E) xor(E) async_tx(E) raid6_pq(E) raid1(E) raid0(E) 
multipath(E) linear(E) md_mod(E) input_leds(E) joydev(E) evdev(E) 
hid_generic(E) usbhid(E) hid(E) xhci_pci(E) xhci_hcd(E) crc32c_intel(E) 
sd_mod(E) t10_pi(E) usbcore(E) thermal(E)
[83637.013193] CPU: 1 PID: 66899 Comm: GameThread Tainted: G            
E     5.13.12 #75
[83637.013197] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS 
ELITE/X570 AORUS ELITE, BIOS F21 08/20/2020
[83637.013202] RIP: 0010:drm_syncobj_find_fence 
(drivers/gpu/drm/drm_syncobj.c:400) drm
[83637.013225] Code: 66 66 48 31 c0 8b 0d 9b 10 d2 e1 85 c9 0f 84 81 fd 
ff ff 65 48 8b 04 25 80 6e 01 00 8b 90 60 08 00 00 85 d2 0f 84 6a fd ff 
ff <0f> 0b e9 63 fd ff ff be 03 00 00 00 48 89 ef e8 3c 42 01 e1 e9 6b
All code
========
    0:    66 66 48 31 c0           data16 data16 xor %rax,%rax
    5:    8b 0d 9b 10 d2 e1        mov -0x1e2def65(%rip),%ecx        # 
0xffffffffe1d210a6
    b:    85 c9                    test   %ecx,%ecx
    d:    0f 84 81 fd ff ff        je     0xfffffffffffffd94
   13:    65 48 8b 04 25 80 6e     mov    %gs:0x16e80,%rax
   1a:    01 00
   1c:    8b 90 60 08 00 00        mov    0x860(%rax),%edx
   22:    85 d2                    test   %edx,%edx
   24:    0f 84 6a fd ff ff        je     0xfffffffffffffd94
   2a:*    0f 0b                    ud2            <-- trapping instruction
   2c:    e9 63 fd ff ff           jmpq   0xfffffffffffffd94
   31:    be 03 00 00 00           mov    $0x3,%esi
   36:    48 89 ef                 mov    %rbp,%rdi
   39:    e8 3c 42 01 e1           callq  0xffffffffe101427a
   3e:    e9                       .byte 0xe9
   3f:    6b                       .byte 0x6b

Code starting with the faulting instruction
===========================================
    0:    0f 0b                    ud2
    2:    e9 63 fd ff ff           jmpq   0xfffffffffffffd6a
    7:    be 03 00 00 00           mov    $0x3,%esi
    c:    48 89 ef                 mov    %rbp,%rdi
    f:    e8 3c 42 01 e1           callq  0xffffffffe1014250
   14:    e9                       .byte 0xe9
   15:    6b                       .byte 0x6b
[83637.013228] RSP: 0018:ffffc90003947ae0 EFLAGS: 00010202
[83637.013231] RAX: ffff8881078aaf80 RBX: ffffc90003947c00 RCX: 
0000000000000001
[83637.013233] RDX: 0000000000000001 RSI: ffff88826faa4d40 RDI: 
000000012a05f200
[83637.013236] RBP: ffff8883c15aff80 R08: 0000000000000000 R09: 
0000000000000001
[83637.013238] R10: 0000000000000000 R11: 0000000000000000 R12: 
00000000000004e2
[83637.013239] R13: 0000000000000002 R14: ffffc90003947b70 R15: 
0000000000000001
[83637.013241] FS:  000000007ba23700(0000) GS:ffff88842e840000(0000) 
knlGS:000000013fe10000
[83637.013244] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[83637.013246] CR2: 00007f2ad002b048 CR3: 00000001862a0000 CR4: 
00000000001506e0
[83637.013248] Call Trace:
[83637.013255] ? find_held_lock (kernel/locking/lockdep.c:5121)
[83637.013264] ? amdgpu_ctx_wait_prev_fence 
(drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c:550) amdgpu
[83637.013485] ? lock_release (kernel/locking/lockdep.c:5306 
kernel/locking/lockdep.c:5648)
[83637.013490] amdgpu_syncobj_lookup_and_add_to_sync 
(drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:1010) amdgpu
[83637.013602] amdgpu_cs_ioctl 
(drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:1058 
drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:1173 
drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:1316) amdgpu
[83637.013730] ? amdgpu_cs_find_mapping 
(drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:1289) amdgpu
[83637.013827] drm_ioctl_kernel (drivers/gpu/drm/drm_ioctl.c:794) drm
[83637.013849] drm_ioctl (./include/linux/thread_info.h:184 
./include/linux/thread_info.h:217 ./include/linux/uaccess.h:199 
drivers/gpu/drm/drm_ioctl.c:892) drm
[83637.013869] ? amdgpu_cs_find_mapping 
(drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:1289) amdgpu
[83637.013966] ? __pm_runtime_resume (drivers/base/power/runtime.c:1114)
[83637.013970] ? lock_release (kernel/locking/lockdep.c:5306 
kernel/locking/lockdep.c:5648)
[83637.013974] ? _raw_spin_unlock_irqrestore 
(./arch/x86/include/asm/irqflags.h:139 
./include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:191)
[83637.013979] amdgpu_drm_ioctl 
(drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:1657) amdgpu
[83637.014087] __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:1069 
fs/ioctl.c:1055 fs/ioctl.c:1055)
[83637.014092] do_syscall_64 (arch/x86/entry/common.c:47)
[83637.014097] entry_SYSCALL_64_after_hwframe 
(arch/x86/entry/entry_64.S:112)
[83637.014100] RIP: 0033:0x7f2b34be3cc7
[83637.014102] Code: 00 00 00 48 8b 05 c9 91 0c 00 64 c7 00 26 00 00 00 
48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 99 91 0c 00 f7 d8 64 89 01 48
All code
========
    0:    00 00                    add    %al,(%rax)
    2:    00 48 8b                 add    %cl,-0x75(%rax)
    5:    05 c9 91 0c 00           add    $0xc91c9,%eax
    a:    64 c7 00 26 00 00 00     movl   $0x26,%fs:(%rax)
   11:    48 c7 c0 ff ff ff ff     mov $0xffffffffffffffff,%rax
   18:    c3                       retq
   19:    66 2e 0f 1f 84 00 00     nopw   %cs:0x0(%rax,%rax,1)
   20:    00 00 00
   23:    b8 10 00 00 00           mov    $0x10,%eax
   28:    0f 05                    syscall
   2a:*    48 3d 01 f0 ff ff        cmp $0xfffffffffffff001,%rax        
<-- trapping instruction
   30:    73 01                    jae    0x33
   32:    c3                       retq
   33:    48 8b 0d 99 91 0c 00     mov 0xc9199(%rip),%rcx        # 0xc91d3
   3a:    f7 d8                    neg    %eax
   3c:    64 89 01                 mov    %eax,%fs:(%rcx)
   3f:    48                       rex.W

Code starting with the faulting instruction
===========================================
    0:    48 3d 01 f0 ff ff        cmp $0xfffffffffffff001,%rax
    6:    73 01                    jae    0x9
    8:    c3                       retq
    9:    48 8b 0d 99 91 0c 00     mov 0xc9199(%rip),%rcx        # 0xc91a9
   10:    f7 d8                    neg    %eax
   12:    64 89 01                 mov    %eax,%fs:(%rcx)
   15:    48                       rex.W
[83637.014105] RSP: 002b:000000007ba1f338 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[83637.014108] RAX: ffffffffffffffda RBX: 000000007ba1f3b0 RCX: 
00007f2b34be3cc7
[83637.014110] RDX: 000000007ba1f3b0 RSI: 00000000c0186444 RDI: 
0000000000000050
[83637.014111] RBP: 00000000c0186444 R08: 00007f2ad002afc0 R09: 
000000007ba1f588
[83637.014113] R10: 000000007f575130 R11: 0000000000000246 R12: 
00007f2ad002af80
[83637.014114] R13: 0000000000000050 R14: 0000000000000000 R15: 
00007f2ad002b050
[83637.014118] ---[ end trace 7f72697a74b7383e ]---

Using:

Linux version 5.13.12 (..) (gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU 
ld (GNU Binutils for Debian) 2.35.2) #75 SMP PREEMPT Wed Aug 18 13:04:15 
EEST 2021

09:00.0 VGA compatible controller: Advanced Micro Devices, Inc. 
[AMD/ATI] Vega 10 XL/XT [Radeon RX Vega 56/64] (rev c3)

--

  - Ilkka



