Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCBD31FD89
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 18:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhBSRCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 12:02:24 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:48549 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhBSRCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 12:02:21 -0500
X-Originating-IP: 2.7.49.219
Received: from [192.168.1.12] (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id DCFC42000A;
        Fri, 19 Feb 2021 17:01:31 +0000 (UTC)
Subject: Re: riscv+KASAN does not boot
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Bjorn Topel <bjorn.topel@gmail.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        LKML <linux-kernel@vger.kernel.org>, nylon7@andestech.com,
        syzkaller <syzkaller@googlegroups.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-riscv <linux-riscv@lists.infradead.org>
References: <CACT4Y+bDqMiC+ou5ghb=XB3Oyjw3p-GTDvNw4NkkQqQthw1yuQ@mail.gmail.com>
 <CACT4Y+aC19DaNOm87EO3cER2=MEmO9pmtUxzVmRtg9YhZKuMVA@mail.gmail.com>
 <20210118145310.crnqnh6kax5jqicj@distanz.ch>
 <CACT4Y+bFV6m1LCYb1nO7ioKJK99916D76sJ+H-LgBjWx6biF5w@mail.gmail.com>
 <CACT4Y+bmDKNnykeTP9yKjje3XZjbXY3De+_e3fMFOMoe0dnARw@mail.gmail.com>
 <6e9ee3a1-0e16-b1fc-a690-f1ca8e9823a5@ghiti.fr>
 <CACT4Y+adSjve7bXRPh5UybCQx6ubOUu5RbwuT620wdcxHzVYJg@mail.gmail.com>
 <CACT4Y+ZNJBnkKHXUf=tm_yuowvZvHwN=0rmJ=7J+xFd+9r_6pQ@mail.gmail.com>
 <CACT4Y+awHrJfFo+g33AiAnCj3vq6t6PqbL-3=Qbciy6dAJfVWg@mail.gmail.com>
 <24857bfc-c557-f141-8ae7-2e3da24f67f5@ghiti.fr>
 <CACT4Y+bmuhR=2u=1bGK+W8ttOn+=bkKrqCRM8_SiDSW1iAX60A@mail.gmail.com>
 <957f09fb-84f4-2e0a-13ab-f7e4831ee7d0@ghiti.fr>
 <CACT4Y+ZmuOpyf_0vHTT4t3wkmJuW8Ezvcg7v6yDVd8YOViS=GA@mail.gmail.com>
 <c8f072b8-0b8c-fa78-da6c-cac8b6711603@ghiti.fr>
 <CACT4Y+agHHFsq1fA5dwESf+oZerC3NBM+2kFAFxyHVd+Xu6crQ@mail.gmail.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <31dfbbbf-79ff-1204-2e9d-dc62630acd36@ghiti.fr>
Date:   Fri, 19 Feb 2021 12:01:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+agHHFsq1fA5dwESf+oZerC3NBM+2kFAFxyHVd+Xu6crQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Le 2/18/21 à 6:36 AM, Dmitry Vyukov a écrit :
> On Thu, Feb 18, 2021 at 8:54 AM Alex Ghiti <alex@ghiti.fr> wrote:
>>
>> Hi Dmitry,
>>
>>> On Wed, Feb 17, 2021 at 5:36 PM Alex Ghiti <alex@ghiti.fr> wrote:
>>>>
>>>> Le 2/16/21 à 11:42 PM, Dmitry Vyukov a écrit :
>>>>> On Tue, Feb 16, 2021 at 9:42 PM Alex Ghiti <alex@ghiti.fr> wrote:
>>>>>>
>>>>>> Hi Dmitry,
>>>>>>
>>>>>> Le 2/16/21 à 6:25 AM, Dmitry Vyukov a écrit :
>>>>>>> On Tue, Feb 16, 2021 at 12:17 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>>>>>>>>
>>>>>>>> On Fri, Jan 29, 2021 at 9:11 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>>>>>>>>>> I was fixing KASAN support for my sv48 patchset so I took a look at your
>>>>>>>>>> issue: I built a kernel on top of the branch riscv/fixes using
>>>>>>>>>> https://github.com/google/syzkaller/blob/269d24e857a757d09a898086a2fa6fa5d827c3e1/dashboard/config/linux/upstream-riscv64-kasan.config
>>>>>>>>>> and Buildroot 2020.11. I have the warnings regarding the use of
>>>>>>>>>> __virt_to_phys on wrong addresses (but that's normal since this function
>>>>>>>>>> is used in virt_addr_valid) but not the segfaults you describe.
>>>>>>>>>
>>>>>>>>> Hi Alex,
>>>>>>>>>
>>>>>>>>> Let me try to rebuild buildroot image. Maybe there was something wrong
>>>>>>>>> with my build, though, I did 'make clean' before doing. But at the
>>>>>>>>> same time it worked back in June...
>>>>>>>>>
>>>>>>>>> Re WARNINGs, they indicate kernel bugs. I am working on setting up a
>>>>>>>>> syzbot instance on riscv. If there a WARNING during boot then the
>>>>>>>>> kernel will be marked as broken. No further testing will happen.
>>>>>>>>> Is it a mis-use of WARN_ON? If so, could anybody please remove it or
>>>>>>>>> replace it with pr_err.
>>>>>>>>
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> I've localized one issue with riscv/KASAN:
>>>>>>>> KASAN breaks VDSO and that's I think the root cause of weird faults I
>>>>>>>> saw earlier. The following patch fixes it.
>>>>>>>> Could somebody please upstream this fix? I don't know how to add/run
>>>>>>>> tests for this.
>>>>>>>> Thanks
>>>>>>>>
>>>>>>>> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
>>>>>>>> index 0cfd6da784f84..cf3a383c1799d 100644
>>>>>>>> --- a/arch/riscv/kernel/vdso/Makefile
>>>>>>>> +++ b/arch/riscv/kernel/vdso/Makefile
>>>>>>>> @@ -35,6 +35,7 @@ CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
>>>>>>>>      # Disable gcov profiling for VDSO code
>>>>>>>>      GCOV_PROFILE := n
>>>>>>>>      KCOV_INSTRUMENT := n
>>>>>>>> +KASAN_SANITIZE := n
>>>>>>>>
>>>>>>>>      # Force dependency
>>>>>>>>      $(obj)/vdso.o: $(obj)/vdso.so
>>>>>>
>>>>>> What's weird is that I don't have any issue without this patch with the
>>>>>> following config whereas it indeed seems required for KASAN. But when
>>>>>> looking at the segfaults you got earlier, the segfault address is 0xbb0
>>>>>> and the cause is an instruction page fault: this address is the PLT base
>>>>>> address in vdso.so and an instruction page fault would mean that someone
>>>>>> tried to jump at this address, which is weird. At first sight, that does
>>>>>> not seem related to your patch above, but clearly I may be wrong.
>>>>>>
>>>>>> Tobias, did you observe the same segfaults as Dmitry ?
>>>>>
>>>>>
>>>>> I noticed that not all buildroot images use VDSO, it seems to be
>>>>> dependent on libc settings (at least I think I changed it in the
>>>>> past).
>>>>
>>>> Ok, I used uClibc but then when using glibc, I have the same segfaults,
>>>> only when KASAN is enabled. And your patch fixes the problem. I will try
>>>> to take a look later to better understand the problem.
>>>>
>>>>> I also booted an image completely successfully including dhcpd/sshd
>>>>> start, but then my executable crashed in clock_gettime. The executable
>>>>> was build on linux/amd64 host with "riscv64-linux-gnu-gcc -static"
>>>>> (10.2.1).
>>>>>
>>>>>
>>>>>>> Second issue I am seeing seems to be related to text segment size.
>>>>>>> I check out v5.11 and use this config:
>>>>>>> https://gist.github.com/dvyukov/6af25474d455437577a84213b0cc9178
>>>>>>
>>>>>> This config gave my laptop a hard time ! Finally I was able to boot
>>>>>> correctly to userspace, but I realized I used my sv48 branch...Either I
>>>>>> fixed your issue along the way or I can't reproduce it, I'll give it a
>>>>>> try tomorrow.
>>>>>
>>>>> Where is your branch? I could also test in my setup on your branch.
>>>>>
>>>>
>>>> You can find my branch int/alex/riscv_kernel_end_of_address_space_v2
>>>> here: https://github.com/AlexGhiti/riscv-linux.git
>>>
>>> No, it does not work for me.
>>>
>>> Source is on b61ab6c98de021398cd7734ea5fc3655e51e70f2 (HEAD,
>>> int/alex/riscv_kernel_end_of_address_space_v2)
>>> Config is https://gist.githubusercontent.com/dvyukov/6af25474d455437577a84213b0cc9178/raw/55b116522c14a8a98a7626d76df740d54f648ce5/gistfile1.txt
>>>
>>> riscv64-linux-gnu-gcc -v
>>> gcc version 10.2.1 20210110 (Debian 10.2.1-6+build1)
>>>
>>> qemu-system-riscv64 --version
>>> QEMU emulator version 5.2.0 (Debian 1:5.2+dfsg-3)
>>>
>>> qemu-system-riscv64 \
>>> -machine virt -smp 2 -m 2G \
>>> -device virtio-blk-device,drive=hd0 \
>>> -drive file=image-riscv64,if=none,format=raw,id=hd0 \
>>> -kernel arch/riscv/boot/Image \
>>> -nographic \
>>> -device virtio-rng-device,rng=rng0 -object
>>> rng-random,filename=/dev/urandom,id=rng0 \
>>> -netdev user,id=net0,host=10.0.2.10,hostfwd=tcp::10022-:22 -device
>>> virtio-net-device,netdev=net0 \
>>> -append "root=/dev/vda earlyprintk=serial console=ttyS0 oops=panic
>>> panic_on_warn=1 panic=86400 earlycon"
>>
>> It still works for me but I had to disable CONFIG_DEBUG_INFO_BTF (I
>> don't think that changes anything at runtime). But your above command
>> line does not work for me as it appears you do not load any firmware, if
>> I add -bios images/fw_jump.elf, it works. But then I don't know where
>> your opensbi output below comes from...
>>
>> And regarding your issue with calling clock_gettime 'directly' compared
>> to using the syscall, I have the same consistent output from both calls.
>>
>> I have an older gcc (9.3.0) and the same qemu. I think what is missing
>> here is your buildroot config, so that we have the exact same
>> environment: could you post your buildroot config as well ?
> 
> I don't think the image is relevant because I don't even get to kernel
> code. If the kernel will complain about no init later, that's fine.
> Re bios, this version of qemu already has OpenSBI bios builtin, you
> can pass -bios default, but that's, well, the default :)
> Here are more reproducible repro instructions that capture gcc and
> qemu. I think gcc version may be potentially relevant as I suspect
> code size.
> 
> 
> curl https://gist.githubusercontent.com/dvyukov/6af25474d455437577a84213b0cc9178/raw/55b116522c14a8a98a7626d76df740d54f648ce5/gistfile1.txt
>> $KERNEL_SRC/.config
> docker pull gcr.io/syzkaller/syzbot
> docker run -it -v $KERNEL_SRC:/kernel gcr.io/syzkaller/syzbot
> cd /kernel
> make -j72 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- olddefconfig
> make -j72 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-
> qemu-system-riscv64 -machine virt -smp 2 -m 4G -kernel
> arch/riscv/boot/Image -nographic -append "earlycon earlyprintk=serial
> console=ttyS0"
> [this does not, only OpenSBI output]
> 

Indeed the issue was code size, please find the fix below. I will send a 
proper patch once I made sure the fix is the right one, but I'm pretty 
confident, there's no reason to limit the mapping size to 128MB whereas 
we have a whole pgdir.

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 9b0592b11a9f..ff2495707edb 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -287,7 +287,7 @@ pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
  pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
  pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;

-#define MAX_EARLY_MAPPING_SIZE SZ_128M
+#define MAX_EARLY_MAPPING_SIZE PGDIR_SIZE

  pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);

-- 
2.20.1

Thanks,

Alex

> scripts/config -d KASAN_INLINE -e KASAN_OUTLINE -d
> CC_OPTIMIZE_FOR_PERFORMANCE -e CC_OPTIMIZE_FOR_SIZE
> make -j72 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-
> qemu-system-riscv64 -machine virt -smp 2 -m 4G -kernel
> arch/riscv/boot/Image -nographic -append "earlycon earlyprintk=serial
> console=ttyS0"
> [this boots fine, at least at to starting init process]
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
