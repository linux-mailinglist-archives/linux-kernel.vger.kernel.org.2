Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BB532015B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 23:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBSW0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 17:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhBSW0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 17:26:51 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2975BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 14:26:11 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id o63so5965785pgo.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 14:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=xXMCjR4qc+hZHcRfNvatBV5AxcztKz30JljE3qZjG8g=;
        b=i/yhfRQbu3LhFovmMrZSlEEDe+gZH+9i0CKbsRWlAlZ2qNpTWsxo4mt83KVGG79Bo6
         ++tl75k2rvW8/P5Q/LxzhIa6PJ1yx5Lk9E6F9tH7fA2rp8IuaiYLEfQbeiqxEpZUWnHj
         N9UCtGAITyDcYSmcxNFDKHreGpWG9jxCgpFvIWXwUCutxF3bX1bkaFVUGaapmX9DWcEI
         GZ+UnGs7mJJGZYES2U8kkcjhUXAsV3B7LAce/hCgSsIfGVmPQTJh64Wh1L7Z+8f0GV6T
         5HK5YiXGJTBwN9hFH5abMkFp9y7aktk51/mhv3uaBZMDPgeNwgCdAYfrqct9sQDjRcbT
         ZZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=xXMCjR4qc+hZHcRfNvatBV5AxcztKz30JljE3qZjG8g=;
        b=Xbw9mQJCDsdpuHKAO2CDJHsuV20hYSrQpss8Pd8BpAik1WcUuXXqsNbQ7UvoLe9nXK
         e4Y9vMJ8Y2zdiayz9UA/5dtEwPRTFjEWzeJyvEKGNv5idUIuzVvMDy9kG6JN7UCXUfuq
         dpMgrsmnGV3Yn2F0RVJ9Cxp4LSA2pgkCEX0Tn+r+H2PiF5MMq1QDWo+7RMRAeQkwAgan
         Fywiy9gNTpW512+g0+UA8QRDZ9ycBjgp5gaRxnyFgdjKltZ8uFbxL0pFiPjotyhf+Cid
         esLO3pv0BlhoUzdrNb+otNuvPiZwe6bMHWJKedFk6a0iehsEcOt0O0repG0Tv8WGObGW
         Vrug==
X-Gm-Message-State: AOAM532amvVXLtPqlNtOWj5F/A7rYjQx79CpC6cXU8DHjXj2qAqbV3dt
        +LwQnoLJ5LUNNH9K3ivx8v7ZYw==
X-Google-Smtp-Source: ABdhPJwUtajwA6bte90OA52l7vXwvq8zTpA++THQ1J+OhWJ5NQS8yUstgmpCzjW6wZ3TXMYW0TvD7g==
X-Received: by 2002:a63:c84f:: with SMTP id l15mr10386110pgi.170.1613773570143;
        Fri, 19 Feb 2021 14:26:10 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w196sm10879397pfd.23.2021.02.19.14.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 14:26:09 -0800 (PST)
Date:   Fri, 19 Feb 2021 14:26:09 -0800 (PST)
X-Google-Original-Date: Fri, 19 Feb 2021 14:25:47 PST (-0800)
Subject:     Re: riscv+KASAN does not boot
In-Reply-To: <CACT4Y+bNzJtwwrHsOa7Ftnaj7B+TPd35=QRLKDE-UuaPJoaDkw@mail.gmail.com>
CC:     alex@ghiti.fr, aou@eecs.berkeley.edu,
        Bjorn Topel <bjorn.topel@gmail.com>,
        linux-kernel@vger.kernel.org, nylon7@andestech.com,
        syzkaller@googlegroups.com, schwab@linux-m68k.org,
        Paul Walmsley <paul.walmsley@sifive.com>, tklauser@distanz.ch,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     dvyukov@google.com
Message-ID: <mhng-4c96338e-14e4-4583-8b9d-a99aa6c03eaf@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Feb 2021 10:53:43 PST (-0800), dvyukov@google.com wrote:
> On Fri, Feb 19, 2021 at 6:01 PM Alex Ghiti <alex@ghiti.fr> wrote:
>>
>> Hi Dmitry,
>>
>> Le 2/18/21 à 6:36 AM, Dmitry Vyukov a écrit :
>> > On Thu, Feb 18, 2021 at 8:54 AM Alex Ghiti <alex@ghiti.fr> wrote:
>> >>
>> >> Hi Dmitry,
>> >>
>> >>> On Wed, Feb 17, 2021 at 5:36 PM Alex Ghiti <alex@ghiti.fr> wrote:
>> >>>>
>> >>>> Le 2/16/21 à 11:42 PM, Dmitry Vyukov a écrit :
>> >>>>> On Tue, Feb 16, 2021 at 9:42 PM Alex Ghiti <alex@ghiti.fr> wrote:
>> >>>>>>
>> >>>>>> Hi Dmitry,
>> >>>>>>
>> >>>>>> Le 2/16/21 à 6:25 AM, Dmitry Vyukov a écrit :
>> >>>>>>> On Tue, Feb 16, 2021 at 12:17 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>> >>>>>>>>
>> >>>>>>>> On Fri, Jan 29, 2021 at 9:11 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>> >>>>>>>>>> I was fixing KASAN support for my sv48 patchset so I took a look at your
>> >>>>>>>>>> issue: I built a kernel on top of the branch riscv/fixes using
>> >>>>>>>>>> https://github.com/google/syzkaller/blob/269d24e857a757d09a898086a2fa6fa5d827c3e1/dashboard/config/linux/upstream-riscv64-kasan.config
>> >>>>>>>>>> and Buildroot 2020.11. I have the warnings regarding the use of
>> >>>>>>>>>> __virt_to_phys on wrong addresses (but that's normal since this function
>> >>>>>>>>>> is used in virt_addr_valid) but not the segfaults you describe.
>> >>>>>>>>>
>> >>>>>>>>> Hi Alex,
>> >>>>>>>>>
>> >>>>>>>>> Let me try to rebuild buildroot image. Maybe there was something wrong
>> >>>>>>>>> with my build, though, I did 'make clean' before doing. But at the
>> >>>>>>>>> same time it worked back in June...
>> >>>>>>>>>
>> >>>>>>>>> Re WARNINGs, they indicate kernel bugs. I am working on setting up a
>> >>>>>>>>> syzbot instance on riscv. If there a WARNING during boot then the
>> >>>>>>>>> kernel will be marked as broken. No further testing will happen.
>> >>>>>>>>> Is it a mis-use of WARN_ON? If so, could anybody please remove it or
>> >>>>>>>>> replace it with pr_err.
>> >>>>>>>>
>> >>>>>>>>
>> >>>>>>>> Hi,
>> >>>>>>>>
>> >>>>>>>> I've localized one issue with riscv/KASAN:
>> >>>>>>>> KASAN breaks VDSO and that's I think the root cause of weird faults I
>> >>>>>>>> saw earlier. The following patch fixes it.
>> >>>>>>>> Could somebody please upstream this fix? I don't know how to add/run
>> >>>>>>>> tests for this.
>> >>>>>>>> Thanks
>> >>>>>>>>
>> >>>>>>>> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
>> >>>>>>>> index 0cfd6da784f84..cf3a383c1799d 100644
>> >>>>>>>> --- a/arch/riscv/kernel/vdso/Makefile
>> >>>>>>>> +++ b/arch/riscv/kernel/vdso/Makefile
>> >>>>>>>> @@ -35,6 +35,7 @@ CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
>> >>>>>>>>      # Disable gcov profiling for VDSO code
>> >>>>>>>>      GCOV_PROFILE := n
>> >>>>>>>>      KCOV_INSTRUMENT := n
>> >>>>>>>> +KASAN_SANITIZE := n
>> >>>>>>>>
>> >>>>>>>>      # Force dependency
>> >>>>>>>>      $(obj)/vdso.o: $(obj)/vdso.so
>> >>>>>>
>> >>>>>> What's weird is that I don't have any issue without this patch with the
>> >>>>>> following config whereas it indeed seems required for KASAN. But when
>> >>>>>> looking at the segfaults you got earlier, the segfault address is 0xbb0
>> >>>>>> and the cause is an instruction page fault: this address is the PLT base
>> >>>>>> address in vdso.so and an instruction page fault would mean that someone
>> >>>>>> tried to jump at this address, which is weird. At first sight, that does
>> >>>>>> not seem related to your patch above, but clearly I may be wrong.
>> >>>>>>
>> >>>>>> Tobias, did you observe the same segfaults as Dmitry ?
>> >>>>>
>> >>>>>
>> >>>>> I noticed that not all buildroot images use VDSO, it seems to be
>> >>>>> dependent on libc settings (at least I think I changed it in the
>> >>>>> past).
>> >>>>
>> >>>> Ok, I used uClibc but then when using glibc, I have the same segfaults,
>> >>>> only when KASAN is enabled. And your patch fixes the problem. I will try
>> >>>> to take a look later to better understand the problem.
>> >>>>
>> >>>>> I also booted an image completely successfully including dhcpd/sshd
>> >>>>> start, but then my executable crashed in clock_gettime. The executable
>> >>>>> was build on linux/amd64 host with "riscv64-linux-gnu-gcc -static"
>> >>>>> (10.2.1).
>> >>>>>
>> >>>>>
>> >>>>>>> Second issue I am seeing seems to be related to text segment size.
>> >>>>>>> I check out v5.11 and use this config:
>> >>>>>>> https://gist.github.com/dvyukov/6af25474d455437577a84213b0cc9178
>> >>>>>>
>> >>>>>> This config gave my laptop a hard time ! Finally I was able to boot
>> >>>>>> correctly to userspace, but I realized I used my sv48 branch...Either I
>> >>>>>> fixed your issue along the way or I can't reproduce it, I'll give it a
>> >>>>>> try tomorrow.
>> >>>>>
>> >>>>> Where is your branch? I could also test in my setup on your branch.
>> >>>>>
>> >>>>
>> >>>> You can find my branch int/alex/riscv_kernel_end_of_address_space_v2
>> >>>> here: https://github.com/AlexGhiti/riscv-linux.git
>> >>>
>> >>> No, it does not work for me.
>> >>>
>> >>> Source is on b61ab6c98de021398cd7734ea5fc3655e51e70f2 (HEAD,
>> >>> int/alex/riscv_kernel_end_of_address_space_v2)
>> >>> Config is https://gist.githubusercontent.com/dvyukov/6af25474d455437577a84213b0cc9178/raw/55b116522c14a8a98a7626d76df740d54f648ce5/gistfile1.txt
>> >>>
>> >>> riscv64-linux-gnu-gcc -v
>> >>> gcc version 10.2.1 20210110 (Debian 10.2.1-6+build1)
>> >>>
>> >>> qemu-system-riscv64 --version
>> >>> QEMU emulator version 5.2.0 (Debian 1:5.2+dfsg-3)
>> >>>
>> >>> qemu-system-riscv64 \
>> >>> -machine virt -smp 2 -m 2G \
>> >>> -device virtio-blk-device,drive=hd0 \
>> >>> -drive file=image-riscv64,if=none,format=raw,id=hd0 \
>> >>> -kernel arch/riscv/boot/Image \
>> >>> -nographic \
>> >>> -device virtio-rng-device,rng=rng0 -object
>> >>> rng-random,filename=/dev/urandom,id=rng0 \
>> >>> -netdev user,id=net0,host=10.0.2.10,hostfwd=tcp::10022-:22 -device
>> >>> virtio-net-device,netdev=net0 \
>> >>> -append "root=/dev/vda earlyprintk=serial console=ttyS0 oops=panic
>> >>> panic_on_warn=1 panic=86400 earlycon"
>> >>
>> >> It still works for me but I had to disable CONFIG_DEBUG_INFO_BTF (I
>> >> don't think that changes anything at runtime). But your above command
>> >> line does not work for me as it appears you do not load any firmware, if
>> >> I add -bios images/fw_jump.elf, it works. But then I don't know where
>> >> your opensbi output below comes from...
>> >>
>> >> And regarding your issue with calling clock_gettime 'directly' compared
>> >> to using the syscall, I have the same consistent output from both calls.
>> >>
>> >> I have an older gcc (9.3.0) and the same qemu. I think what is missing
>> >> here is your buildroot config, so that we have the exact same
>> >> environment: could you post your buildroot config as well ?
>> >
>> > I don't think the image is relevant because I don't even get to kernel
>> > code. If the kernel will complain about no init later, that's fine.
>> > Re bios, this version of qemu already has OpenSBI bios builtin, you
>> > can pass -bios default, but that's, well, the default :)
>> > Here are more reproducible repro instructions that capture gcc and
>> > qemu. I think gcc version may be potentially relevant as I suspect
>> > code size.
>> >
>> >
>> > curl https://gist.githubusercontent.com/dvyukov/6af25474d455437577a84213b0cc9178/raw/55b116522c14a8a98a7626d76df740d54f648ce5/gistfile1.txt
>> >> $KERNEL_SRC/.config
>> > docker pull gcr.io/syzkaller/syzbot
>> > docker run -it -v $KERNEL_SRC:/kernel gcr.io/syzkaller/syzbot
>> > cd /kernel
>> > make -j72 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- olddefconfig
>> > make -j72 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-
>> > qemu-system-riscv64 -machine virt -smp 2 -m 4G -kernel
>> > arch/riscv/boot/Image -nographic -append "earlycon earlyprintk=serial
>> > console=ttyS0"
>> > [this does not, only OpenSBI output]
>> >
>>
>> Indeed the issue was code size, please find the fix below. I will send a
>> proper patch once I made sure the fix is the right one, but I'm pretty
>> confident, there's no reason to limit the mapping size to 128MB whereas
>> we have a whole pgdir.
>
> Great you get to the bottom of this!
> Riscv kernels are going to be YUGE!

IIRC I tried that a while ago and it didn't work.  It's possible I was just
running into some other bug, but I'm just build testing allyesconfig as opposed
to boot testing it.

If you've got a setup that does boot I'm happy to take a patch, though.  It'll
at least be one step forward.

>
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 9b0592b11a9f..ff2495707edb 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -287,7 +287,7 @@ pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>>   pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>>   pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
>>
>> -#define MAX_EARLY_MAPPING_SIZE SZ_128M
>> +#define MAX_EARLY_MAPPING_SIZE PGDIR_SIZE
>>
>>   pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>>
>> --
>> 2.20.1
>>
>> Thanks,
>>
>> Alex
>>
>> > scripts/config -d KASAN_INLINE -e KASAN_OUTLINE -d
>> > CC_OPTIMIZE_FOR_PERFORMANCE -e CC_OPTIMIZE_FOR_SIZE
>> > make -j72 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-
>> > qemu-system-riscv64 -machine virt -smp 2 -m 4G -kernel
>> > arch/riscv/boot/Image -nographic -append "earlycon earlyprintk=serial
>> > console=ttyS0"
>> > [this boots fine, at least at to starting init process]
>> >
>> > _______________________________________________
>> > linux-riscv mailing list
>> > linux-riscv@lists.infradead.org
>> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>> >
