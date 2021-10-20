Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAFB434CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 15:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhJTN4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 09:56:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:28165 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhJTN4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 09:56:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="226243673"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="xz'?scan'208";a="226243673"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 06:53:55 -0700
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="xz'?scan'208";a="494631129"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 06:53:52 -0700
Date:   Wed, 20 Oct 2021 22:13:41 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [mm] 6128b3af2a: UBSAN:shift-out-of-bounds_in(null)
Message-ID: <20211020141341.GA22721@xsang-OptiPlex-9020>
References: <20211019031407.GB7910@xsang-OptiPlex-9020>
 <87wnm9ovz2.fsf@disp2133>
 <99b496b7-c465-eac3-d7ad-18a615fe94a7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <99b496b7-c465-eac3-d7ad-18a615fe94a7@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, David, Hi, Eric,

On Wed, Oct 20, 2021 at 09:22:52AM +0200, David Hildenbrand wrote:
> On 19.10.21 17:49, Eric W. Biederman wrote:
> > kernel test robot <oliver.sang@intel.com> writes:
> > 
> >> Greeting,
> >>
> >> FYI, we noticed the following commit (built with clang-14):
> >>
> >> commit: 6128b3af2a5e42386aa7faf37609b57f39fb7d00 ("mm: ignore MAP_DENYWRITE in ksys_mmap_pgoff()")
> >> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > I believe this failure is misattributed.  Perhaps your reproducer
> > only intermittently reproduces the problem?

yes, we only reproduce the problem intermittently, those 9 instances are
out of 115 runs.
8d0920bde5eb8ec7 6128b3af2a5e42386aa7faf3760
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :115          8%           9:115   dmesg.UBSAN:shift-out-of-bounds_in(null)    <--


> > 
> > The change in question only contains
> > 
> > 	flags &= ~MAP_DENYWRITE
> > 
> > After all of the other users of MAP_DENYWRITE had been removed from the
> > kernel.  So I don't see how it could possibly be responsible for the
> > reported shift out of bounds problem.
> > 
> > Eric
> 
> Thanks for looking into this Eric while I spent the last couple of days
> in bed feeling miserable. :)
> 
> 
> So we get 9 new instances of "UBSAN:shift-out-of-bounds_in(null)" (NULL
> pointer dereference) on 6128b3af2a compared to 6128b3af2a^ (8d0920bde5),
> apparently inside ksys_mmap_pgoff() on 32bit.
> 
> As we're dealing with a fuzzer, is there any reproducer as sometimes
> provided by syzkaller? The report itself is not very helpful when
> judging if that patch is actually responsible for what we're seeing.
> 
> I agree with Eric that it's rather unlikely that when we stop masking
> off a bit that's ignored throughout the kernel, that we suddenly trigger
> a NULL pointer de-reference. But I learned that everything is possible ;)


now we run parent 200 more times, the "UBSAN:shift-out-of-bounds_in(null)" (1)
still cannot be reproduced on parent:
8d0920bde5eb8ec7 6128b3af2a5e42386aa7faf3760
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
            |             |             |
         45:315        -11%           9:115   dmesg.BUG:kernel_NULL_pointer_dereference,address
           :315          3%           8:115   dmesg.BUG:unable_to_handle_page_fault_for_address
         45:315         -9%          17:115   dmesg.EIP:__ubsan_handle_shift_out_of_bounds <--(2)
         45:315         -9%          17:115   dmesg.Kernel_panic-not_syncing:Fatal_exception
         45:315         -9%          17:115   dmesg.Oops:#[##]
           :315          3%           9:115   dmesg.UBSAN:shift-out-of-bounds_in(null)  <--(1)
         45:315         -9%          17:115   dmesg.boot_failures


however, from above (2), we found parent dmesg (attached) has similar
Call Trace, which just does't have "UBSAN:shift-out-of-bounds_in(null)"
things:
[  272.487295][ T7295] BUG: kernel NULL pointer dereference, address: 0000000c
[  272.488078][ T7295] #PF: supervisor read access in kernel mode
[  272.488673][ T7295] #PF: error_code(0x0000) - not-present page
[  272.489266][ T7295] *pde = 00000000
[  272.489751][ T7295] Oops: 0000 [#1] SMP
[  272.490165][ T7295] CPU: 1 PID: 7295 Comm: trinity-c2 Not tainted 5.14.0-00005-g8d0920bde5eb #1
[  272.491122][ T7295] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[  272.492067][ T7295] EIP: __ubsan_handle_shift_out_of_bounds+0xe/0x350
[  272.492760][ T7295] Code: 05 90 a6 c2 00 68 2a 54 00 68 2a 54 bd 4e 00 8d bd 4e 00 8d 00 00 66 90 00 00 66 90 57 56 83 ec 57 56 83 ec 89 c7 8b 48 89 c7 <8b> 48 8d\
 b4 26 00 8d b4 26 00 75 b4 64 8b 75 b4 64 8b ca 83 bb 1c
[  272.494890][ T7295] EAX: 00000000 EBX: c5d6cf38 ECX: 00000031 EDX: 00000000
[  272.495686][ T7295] ESI: f138eb71 EDI: 00000000 EBP: f5a23f3c ESP: f5a23ec8
[  272.496532][ T7295] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010292
[  272.497383][ T7295] CR0: 80050033 CR2: 0000000c CR3: 3528d000 CR4: 000406d0
[  272.498152][ T7295] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  272.498897][ T7295] DR6: fffe0ff0 DR7: 00000400
[  272.499411][ T7295] Call Trace:
[  272.499827][ T7295]  ? __lock_acquire+0x955/0xb80
[  272.500361][ T7295]  ? rcu_lock_acquire+0x30/0x30
[  272.500875][ T7295]  ? rcu_read_lock_sched_held+0x31/0x70
[  272.501500][ T7295]  ksys_mmap_pgoff+0x1fd/0x290
[  272.501990][ T7295]  __ia32_sys_mmap_pgoff+0x1c/0x30
[  272.502512][ T7295]  do_int80_syscall_32+0x39/0x80
[  272.503101][ T7295]  entry_INT80_32+0x10d/0x10d
[  272.503624][ T7295] EIP: 0xb7f71a02
[  272.504029][ T7295] Code: 95 01 00 05 25 36 02 00 83 ec 14 8d 80 e8 99 ff ff 50 6a 02 e8 1f ff 00 00 c7 04 24 7f 00 00 00 e8 7e 87 01 00 66 90 90 cd 80 <c3> 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 1c 24 c3 8d b6 00 00
[  272.506044][ T7295] EAX: ffffffda EBX: 00000000 ECX: 00000000 EDX: f138eb71
[  272.506825][ T7295] ESI: c5d6cf38 EDI: ffffffff EBP: 00000000 ESP: bfca54d8
[  272.507592][ T7295] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[  272.508417][ T7295] Modules linked in: aesni_intel crypto_simd qemu_fw_cfg autofs4
[  272.509201][ T7295] CR2: 000000000000000c
[  272.509704][ T7295] ---[ end trace 97b48cc676da14f9 ]---
[  272.510293][ T7295] EIP: __ubsan_handle_shift_out_of_bounds+0xe/0x350
[  272.511023][ T7295] Code: 05 90 a6 c2 00 68 2a 54 00 68 2a 54 bd 4e 00 8d bd 4e 00 8d 00 00 66 90 00 00 66 90 57 56 83 ec 57 56 83 ec 89 c7 8b 48 89 c7 <8b> 48 8d b4 26 00 8d b4 26 00 75 b4 64 8b 75 b4 64 8b ca 83 bb 1c
[  272.513169][ T7295] EAX: 00000000 EBX: c5d6cf38 ECX: 00000031 EDX: 00000000
[  272.513979][ T7295] ESI: f138eb71 EDI: 00000000 EBP: f5a23f3c ESP: f5a23ec8
[  272.514800][ T7295] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010292
[  272.515974][ T7295] CR0: 80050033 CR2: 0000000c CR3: 3528d000 CR4: 000406d0
[  272.516787][ T7295] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  272.517619][ T7295] DR6: fffe0ff0 DR7: 00000400
[  272.518105][ T7295] Kernel panic - not syncing: Fatal exception
[  272.519566][ T7295] Kernel Offset: disabled


as contrast, in fbc:
[  126.758570][ T3293] ================================================================================
[  126.758949][ T3293] UBSAN: shift-out-of-bounds in (null):0:0
[  126.759174][ T3293] BUG: kernel NULL pointer dereference, address: 00000000
[  126.759447][ T3293] #PF: supervisor read access in kernel mode
[  126.759676][ T3293] #PF: error_code(0x0000) - not-present page
[  126.759905][ T3293] *pde = 00000000
[  126.760047][ T3293] Oops: 0000 [#1] SMP
[  126.760205][ T3293] CPU: 1 PID: 3293 Comm: trinity-c4 Not tainted 5.14.0-00006-g6128b3af2a5e #1
[  126.760541][ T3293] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[  126.760890][ T3293] EIP: __ubsan_handle_shift_out_of_bounds+0x88/0x350
[  126.761147][ T3293] Code: 00 83 c4 04 7f 23 47 04 7f 23 47 04 ff 37 68 ef ff 37 68 ef e3 77 d0 d7 e3 77 d0 d7 00 8b 45 f0 00 8b 45 f0 c4 14 66 83 c4 14 <66> 83 66
83 3f 00 66 83 3f 00 00 00 66 83 00 00 66 83 b9 01 00 00
[  126.761889][ T3293] EAX: 00000000 EBX: f345b500 ECX: 00000027 EDX: eba9ce40
[  126.762159][ T3293] ESI: 00000046 EDI: 00000000 EBP: f3575f40 ESP: f3575ecc
[  126.762428][ T3293] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010286
[  126.762718][ T3293] CR0: 80050033 CR2: 00000000 CR3: 33464000 CR4: 000406d0
[  126.762989][ T3293] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  126.763259][ T3293] DR6: fffe0ff0 DR7: 00000400
[  126.763436][ T3293] Call Trace:
[  126.763562][ T3293]  ? rcu_lock_acquire+0x30/0x30
[  126.763749][ T3293]  ? rcu_read_lock_sched_held+0x31/0x70
[  126.763960][ T3293]  ksys_mmap_pgoff+0x1fc/0x290
[  126.764146][ T3293]  __ia32_sys_mmap_pgoff+0x1c/0x30
[  126.764343][ T3293]  do_int80_syscall_32+0x39/0x80
[  126.764532][ T3293]  entry_INT80_32+0x10d/0x10d
[  126.764709][ T3293] EIP: 0xb7fbda02
[  126.764848][ T3293] Code: 95 01 00 05 25 36 02 00 83 ec 14 8d 80 e8 99 ff ff 50 6a 02 e8 1f ff 00 00 c7 04 24 7f 00 00 00 e8 7e 87 01 00 66 90 90 cd 80 <c3> 8d b6
00 00 00 00 8d bc 27 00 00 00 00 8b 1c 24 c3 8d b6 00 00
[  126.765591][ T3293] EAX: ffffffda EBX: 00000000 ECX: 00001000 EDX: 55dd7eb6
[  126.765859][ T3293] ESI: f0bd6374 EDI: ffffffff EBP: 00000000 ESP: bf9964d8
[  126.766129][ T3293] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[  126.766419][ T3293] Modules linked in: aesni_intel crypto_simd qemu_fw_cfg autofs4
[  126.766715][ T3293] CR2: 0000000000000000
[  126.766894][ T3293] ---[ end trace e6000e119f0dc7f3 ]---
[  126.767105][ T3293] EIP: __ubsan_handle_shift_out_of_bounds+0x88/0x350
[  126.767361][ T3293] Code: 00 83 c4 04 7f 23 47 04 7f 23 47 04 ff 37 68 ef ff 37 68 ef e3 77 d0 d7 e3 77 d0 d7 00 8b 45 f0 00 8b 45 f0 c4 14 66 83 c4 14 <66> 83 66
+83 3f 00 66 83 3f 00 00 00 66 83 00 00 66 83 b9 01 00 00
[  126.768112][ T3293] EAX: 00000000 EBX: f345b500 ECX: 00000027 EDX: eba9ce40
[  126.768384][ T3293] ESI: 00000046 EDI: 00000000 EBP: f3575f40 ESP: f3575ecc
[  126.768657][ T3293] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010286
[  126.768947][ T3293] CR0: 80050033 CR2: 00000000 CR3: 33464000 CR4: 000406d0
[  126.769223][ T3293] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  126.769496][ T3293] DR6: fffe0ff0 DR7: 00000400
[  126.769680][ T3293] Kernel panic - not syncing: Fatal exception
[  126.769946][ T3293] Kernel Offset: disabled


basically, we just based on the diff to report out, but maybe need your education
if this "UBSAN:shift-out-of-bounds_in(null)" diff really matter in this case.


> 
> -- 
> Thanks,
> 
> David / dhildenb
> 

--ibTvN161/egqYuK8
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg-parent.xz"
Content-Transfer-Encoding: base64

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

--ibTvN161/egqYuK8--
