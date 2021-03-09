Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C250332F4E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhCITtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:49:39 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:52797 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhCITtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:49:06 -0500
X-Originating-IP: 2.7.49.219
Received: from [192.168.1.100] (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 86F8140005;
        Tue,  9 Mar 2021 19:49:00 +0000 (UTC)
Subject: Re: riscv+KASAN does not boot
To:     Dmitry Vyukov <dvyukov@google.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Bjorn Topel <bjorn.topel@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, nylon7@andestech.com,
        syzkaller <syzkaller@googlegroups.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-riscv <linux-riscv@lists.infradead.org>
References: <CACT4Y+bNzJtwwrHsOa7Ftnaj7B+TPd35=QRLKDE-UuaPJoaDkw@mail.gmail.com>
 <mhng-4c96338e-14e4-4583-8b9d-a99aa6c03eaf@palmerdabbelt-glaptop>
 <CACT4Y+Z+8hUWaBp7h5YGiGFBJ2Lm3Py_tG=CrdKuUfJfEdPBCw@mail.gmail.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <a0a949aa-457e-73a8-1ece-9b8e0573d664@ghiti.fr>
Date:   Tue, 9 Mar 2021 14:49:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Z+8hUWaBp7h5YGiGFBJ2Lm3Py_tG=CrdKuUfJfEdPBCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 3/9/21 à 12:11 PM, Dmitry Vyukov a écrit :
> On Fri, Feb 19, 2021 at 11:26 PM 'Palmer Dabbelt' via syzkaller
> <syzkaller@googlegroups.com> wrote:
>>
>> On Fri, 19 Feb 2021 10:53:43 PST (-0800), dvyukov@google.com wrote:
>>> On Fri, Feb 19, 2021 at 6:01 PM Alex Ghiti <alex@ghiti.fr> wrote:
>>>>
>>>> Hi Dmitry,
>>>>
>>>> Le 2/18/21 à 6:36 AM, Dmitry Vyukov a écrit :
>>>>> On Thu, Feb 18, 2021 at 8:54 AM Alex Ghiti <alex@ghiti.fr> wrote:
>>>>>>
>>>>>> Hi Dmitry,
>>>>>>
>>>>>>> On Wed, Feb 17, 2021 at 5:36 PM Alex Ghiti <alex@ghiti.fr> wrote:
>>>>>>>>
>>>>>>>> Le 2/16/21 à 11:42 PM, Dmitry Vyukov a écrit :
>>>>>>>>> On Tue, Feb 16, 2021 at 9:42 PM Alex Ghiti <alex@ghiti.fr> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi Dmitry,
>>>>>>>>>>
>>>>>>>>>> Le 2/16/21 à 6:25 AM, Dmitry Vyukov a écrit :
>>>>>>>>>>> On Tue, Feb 16, 2021 at 12:17 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On Fri, Jan 29, 2021 at 9:11 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>>>>>>>>>>>>>> I was fixing KASAN support for my sv48 patchset so I took a look at your
>>>>>>>>>>>>>> issue: I built a kernel on top of the branch riscv/fixes using
>>>>>>>>>>>>>> https://github.com/google/syzkaller/blob/269d24e857a757d09a898086a2fa6fa5d827c3e1/dashboard/config/linux/upstream-riscv64-kasan.config
>>>>>>>>>>>>>> and Buildroot 2020.11. I have the warnings regarding the use of
>>>>>>>>>>>>>> __virt_to_phys on wrong addresses (but that's normal since this function
>>>>>>>>>>>>>> is used in virt_addr_valid) but not the segfaults you describe.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Hi Alex,
>>>>>>>>>>>>>
>>>>>>>>>>>>> Let me try to rebuild buildroot image. Maybe there was something wrong
>>>>>>>>>>>>> with my build, though, I did 'make clean' before doing. But at the
>>>>>>>>>>>>> same time it worked back in June...
>>>>>>>>>>>>>
>>>>>>>>>>>>> Re WARNINGs, they indicate kernel bugs. I am working on setting up a
>>>>>>>>>>>>> syzbot instance on riscv. If there a WARNING during boot then the
>>>>>>>>>>>>> kernel will be marked as broken. No further testing will happen.
>>>>>>>>>>>>> Is it a mis-use of WARN_ON? If so, could anybody please remove it or
>>>>>>>>>>>>> replace it with pr_err.
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Hi,
>>>>>>>>>>>>
>>>>>>>>>>>> I've localized one issue with riscv/KASAN:
>>>>>>>>>>>> KASAN breaks VDSO and that's I think the root cause of weird faults I
>>>>>>>>>>>> saw earlier. The following patch fixes it.
>>>>>>>>>>>> Could somebody please upstream this fix? I don't know how to add/run
>>>>>>>>>>>> tests for this.
>>>>>>>>>>>> Thanks
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
>>>>>>>>>>>> index 0cfd6da784f84..cf3a383c1799d 100644
>>>>>>>>>>>> --- a/arch/riscv/kernel/vdso/Makefile
>>>>>>>>>>>> +++ b/arch/riscv/kernel/vdso/Makefile
>>>>>>>>>>>> @@ -35,6 +35,7 @@ CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
>>>>>>>>>>>>       # Disable gcov profiling for VDSO code
>>>>>>>>>>>>       GCOV_PROFILE := n
>>>>>>>>>>>>       KCOV_INSTRUMENT := n
>>>>>>>>>>>> +KASAN_SANITIZE := n
>>>>>>>>>>>>
>>>>>>>>>>>>       # Force dependency
>>>>>>>>>>>>       $(obj)/vdso.o: $(obj)/vdso.so
>>>>>>>>>>
>>>>>>>>>> What's weird is that I don't have any issue without this patch with the
>>>>>>>>>> following config whereas it indeed seems required for KASAN. But when
>>>>>>>>>> looking at the segfaults you got earlier, the segfault address is 0xbb0
>>>>>>>>>> and the cause is an instruction page fault: this address is the PLT base
>>>>>>>>>> address in vdso.so and an instruction page fault would mean that someone
>>>>>>>>>> tried to jump at this address, which is weird. At first sight, that does
>>>>>>>>>> not seem related to your patch above, but clearly I may be wrong.
>>>>>>>>>>
>>>>>>>>>> Tobias, did you observe the same segfaults as Dmitry ?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I noticed that not all buildroot images use VDSO, it seems to be
>>>>>>>>> dependent on libc settings (at least I think I changed it in the
>>>>>>>>> past).
>>>>>>>>
>>>>>>>> Ok, I used uClibc but then when using glibc, I have the same segfaults,
>>>>>>>> only when KASAN is enabled. And your patch fixes the problem. I will try
>>>>>>>> to take a look later to better understand the problem.
>>>>>>>>
>>>>>>>>> I also booted an image completely successfully including dhcpd/sshd
>>>>>>>>> start, but then my executable crashed in clock_gettime. The executable
>>>>>>>>> was build on linux/amd64 host with "riscv64-linux-gnu-gcc -static"
>>>>>>>>> (10.2.1).
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>> Second issue I am seeing seems to be related to text segment size.
>>>>>>>>>>> I check out v5.11 and use this config:
>>>>>>>>>>> https://gist.github.com/dvyukov/6af25474d455437577a84213b0cc9178
>>>>>>>>>>
>>>>>>>>>> This config gave my laptop a hard time ! Finally I was able to boot
>>>>>>>>>> correctly to userspace, but I realized I used my sv48 branch...Either I
>>>>>>>>>> fixed your issue along the way or I can't reproduce it, I'll give it a
>>>>>>>>>> try tomorrow.
>>>>>>>>>
>>>>>>>>> Where is your branch? I could also test in my setup on your branch.
>>>>>>>>>
>>>>>>>>
>>>>>>>> You can find my branch int/alex/riscv_kernel_end_of_address_space_v2
>>>>>>>> here: https://github.com/AlexGhiti/riscv-linux.git
>>>>>>>
>>>>>>> No, it does not work for me.
>>>>>>>
>>>>>>> Source is on b61ab6c98de021398cd7734ea5fc3655e51e70f2 (HEAD,
>>>>>>> int/alex/riscv_kernel_end_of_address_space_v2)
>>>>>>> Config is https://gist.githubusercontent.com/dvyukov/6af25474d455437577a84213b0cc9178/raw/55b116522c14a8a98a7626d76df740d54f648ce5/gistfile1.txt
>>>>>>>
>>>>>>> riscv64-linux-gnu-gcc -v
>>>>>>> gcc version 10.2.1 20210110 (Debian 10.2.1-6+build1)
>>>>>>>
>>>>>>> qemu-system-riscv64 --version
>>>>>>> QEMU emulator version 5.2.0 (Debian 1:5.2+dfsg-3)
>>>>>>>
>>>>>>> qemu-system-riscv64 \
>>>>>>> -machine virt -smp 2 -m 2G \
>>>>>>> -device virtio-blk-device,drive=hd0 \
>>>>>>> -drive file=image-riscv64,if=none,format=raw,id=hd0 \
>>>>>>> -kernel arch/riscv/boot/Image \
>>>>>>> -nographic \
>>>>>>> -device virtio-rng-device,rng=rng0 -object
>>>>>>> rng-random,filename=/dev/urandom,id=rng0 \
>>>>>>> -netdev user,id=net0,host=10.0.2.10,hostfwd=tcp::10022-:22 -device
>>>>>>> virtio-net-device,netdev=net0 \
>>>>>>> -append "root=/dev/vda earlyprintk=serial console=ttyS0 oops=panic
>>>>>>> panic_on_warn=1 panic=86400 earlycon"
>>>>>>
>>>>>> It still works for me but I had to disable CONFIG_DEBUG_INFO_BTF (I
>>>>>> don't think that changes anything at runtime). But your above command
>>>>>> line does not work for me as it appears you do not load any firmware, if
>>>>>> I add -bios images/fw_jump.elf, it works. But then I don't know where
>>>>>> your opensbi output below comes from...
>>>>>>
>>>>>> And regarding your issue with calling clock_gettime 'directly' compared
>>>>>> to using the syscall, I have the same consistent output from both calls.
>>>>>>
>>>>>> I have an older gcc (9.3.0) and the same qemu. I think what is missing
>>>>>> here is your buildroot config, so that we have the exact same
>>>>>> environment: could you post your buildroot config as well ?
>>>>>
>>>>> I don't think the image is relevant because I don't even get to kernel
>>>>> code. If the kernel will complain about no init later, that's fine.
>>>>> Re bios, this version of qemu already has OpenSBI bios builtin, you
>>>>> can pass -bios default, but that's, well, the default :)
>>>>> Here are more reproducible repro instructions that capture gcc and
>>>>> qemu. I think gcc version may be potentially relevant as I suspect
>>>>> code size.
>>>>>
>>>>>
>>>>> curl https://gist.githubusercontent.com/dvyukov/6af25474d455437577a84213b0cc9178/raw/55b116522c14a8a98a7626d76df740d54f648ce5/gistfile1.txt
>>>>>> $KERNEL_SRC/.config
>>>>> docker pull gcr.io/syzkaller/syzbot
>>>>> docker run -it -v $KERNEL_SRC:/kernel gcr.io/syzkaller/syzbot
>>>>> cd /kernel
>>>>> make -j72 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- olddefconfig
>>>>> make -j72 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-
>>>>> qemu-system-riscv64 -machine virt -smp 2 -m 4G -kernel
>>>>> arch/riscv/boot/Image -nographic -append "earlycon earlyprintk=serial
>>>>> console=ttyS0"
>>>>> [this does not, only OpenSBI output]
>>>>>
>>>>
>>>> Indeed the issue was code size, please find the fix below. I will send a
>>>> proper patch once I made sure the fix is the right one, but I'm pretty
>>>> confident, there's no reason to limit the mapping size to 128MB whereas
>>>> we have a whole pgdir.
>>>
>>> Great you get to the bottom of this!
>>> Riscv kernels are going to be YUGE!
>>
>> IIRC I tried that a while ago and it didn't work.  It's possible I was just
>> running into some other bug, but I'm just build testing allyesconfig as opposed
>> to boot testing it.
>>
>> If you've got a setup that does boot I'm happy to take a patch, though.  It'll
>> at least be one step forward.
> 
> 
> 
> OK, it's getting better.

Nice :)

> The next issue is called "512 bytes should be enough for everyone!" :)
> https://elixir.bootlin.com/linux/v5.12-rc2/source/include/uapi/asm-generic/setup.h#L5
> Most other arches redefine it to something bigger:
> https://elixir.bootlin.com/linux/v5.12-rc2/source/arch/s390/include/uapi/asm/setup.h#L10
> even arm32 redefines it.
> I am not sure the default is even reasonable anymore. 

Some archs override this value to 256, but git blame shows this is 
(very) old. I agree that 512 as default seems low.

> Failure mode is
> also not nice (silent truncation).

Agreed, maybe we could still have the default value and checks the 
terminating null character is somewhere and bugs if not, I'll take a look.

> We are trying to pass this:
> 
> earlyprintk=serial oops=panic nmi_watchdog=panic panic=86400
> net.ifnames=0 sysctl.kernel.hung_task_all_cpu_backtrace=1
> ima_policy=tcb kvm-intel.nested=1 nf-conntrack-ftp.ports=20000
> nf-conntrack-tftp.ports=20000 nf-conntrack-sip.ports=20000
> nf-conntrack-irc.ports=20000 nf-conntrack-sane.ports=20000
> vivid.n_devs=16 vivid.multiplanar=1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2
> netrom.nr_ndevs=16 rose.rose_ndevs=16 spec_store_bypass_disable=prctl
> numa=fake=2 nopcid dummy_hcd.num=8 binder.debug_mask=0
> rcupdate.rcu_expedited=1 watchdog_thresh=165
> workqueue.watchdog_thresh=420 panic_on_warn=1
> 
> The last part gets truncated and we are getting false workqueue watchdog stalls.
> 
> Could you please increase it?

I will propose a patchset that increases the default value and cleans 
archs up accordingly too.

Thanks again,

Alex

> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
