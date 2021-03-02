Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73FB32AD69
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835279AbhCBV5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:57:00 -0500
Received: from mout.gmx.net ([212.227.17.20]:47807 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1581461AbhCBS5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614711320;
        bh=o21JXmB9lXtGcmibRAcIQ94b/T+ffqRvkyleRGyfu7Y=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=etmNbVYPSASeANSmYEtdZjIe5wTCq4GHVyRW82MfdciciE5a15QXNH2J9UpM7acQL
         rjvzMl//zYG988VytQFqWLY8XCWb2CJcJwfiTLPomMYfkTFZMYhTq1vt6sOyFIK+Uk
         aXgx6E2E8zNNIhq3wo+bbjuhEteYgq8KCWbwpnrc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.180.203]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIdeX-1l3CDV1jAT-00Eaau; Tue, 02
 Mar 2021 19:55:20 +0100
Subject: Re: hppa64-linux-ld: kernel/sched/core.o(.init.text+0x90): cannot
 reach printk
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        John David Anglin <dave.anglin@bell.net>
References: <202103021826.7KKJWxQ2-lkp@intel.com>
 <CAKwvOdnCq7S68chEwSjFBPv5vsKDuzumOX19peOFDCSBCUm0jg@mail.gmail.com>
 <2e40a84f-15c6-2764-dcfd-9f5aa368b400@gmx.de>
 <CAKwvOdkXUAfYv415U9aE+ycLKT1rzujrBFfFHmvX47V5xHz1sA@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
Message-ID: <fc099004-dbb4-b9b3-b377-ad459219c7c5@gmx.de>
Date:   Tue, 2 Mar 2021 19:55:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdkXUAfYv415U9aE+ycLKT1rzujrBFfFHmvX47V5xHz1sA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YPLFUJs1fLptPwInwI+NDVhtncC4NmO4L0K0pO8lSFdh+6BAyJx
 Md+VlL4ceQ5CdnpBNSNndu1RP4E9v3NCEvhq3xupElys9zSzVyPimAXawPxUHyvs4npHXvM
 a0l/xg9IcWd4yZKFyQunutTv87GP5sfwDr9YUZHsez9VZZNkKz+/VBAu4MJ813qSs5xfnGl
 6pfQh2S/Jp+o+tyVAvUKA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cI1Fl0dU5+w=:43wp9v9GSmC2mnyusALnQt
 3l8qX159JM3h5evevM7O1X3vA0+nyO2+iXq8GXNsElZGkdDrpLEcvNw1VhekTkx4dUoOONY+u
 J1aJx3WmrOpMwDugblUXBxKJ/SpcdLFlLT9za3mzYaoi9u90QNF2LrBNL9ntFeVTDuBRb0T6P
 OmR5wJCqrvLdCY0pyJ6SKolGSUc3VCz4sBO85OYt4uCENQYx/gt3Ac5QHuiVoszFl/015vB6U
 XdSfu+wkqm8upgbQ0Bi+zE9/LnCJAOWdFLCOxMcPaPYKRfXHYs89SaQ/OEZa6kMMrTgweQ1+4
 WR9p3BYvT0YHdQAWEiLiO4jH4yysnOKd9yENjeyrwPtybyJoGxMdBOP14j0nA3u80101hbW3i
 xFi/50LZRUk4djyJEZYoxLiNzHEnTq3DFWLwSR30jFCm+QlcKOZSSByeoUQ7t1uTm7wK7NZLe
 2FeefBdv+XbsSDkReJjGvPcackBZzApL+AiXWXgJmSd7dY7Z8Vy16CWJ+7YrndulpoHdon0KX
 PhSHey5qaE0yZlXiOPhIX03dcvDUaoL5yPVewhXFqzpexMr/C4lPMg5a9+AeeygsJ6azK5SC2
 Apzt5EuK8B2fAfwyzAu/xfiJAVRw13LOldE+BsNpvjla8WALBoBSL4GMVMS7ZGBwe0YsSAJkv
 dHkxlFKpRLzgTIxKZVWFz+QZ3eBRUV2APt/qCMXaCAabK+j9oc4B8dMxnFm8LUBr40aL3qa3O
 gzRTDa8xzZZWEeus8ZP+I4ABOkpovidURGwkW3R6MZygMzyjKsWi9zN5IDk5wafvngyfyusqz
 fDKjPfW8Q6FOsAH03gPvbzUcDkVjk/IhMfAADsc9vRUBhXCqoogGc2N/MUW4g+GHzRw1Pz2MR
 8ml6MwOi4QunvW1ghEUQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/21 7:07 PM, Nick Desaulniers wrote:
> + Arnd
>
> On Tue, Mar 2, 2021 at 10:03 AM Helge Deller <deller@gmx.de> wrote:
>>
>> On 3/2/21 6:29 PM, Nick Desaulniers wrote:
>>> + pa-risc folks
>>
>> Thanks for looking into this, Nick!
>>
>>> On Tue, Mar 2, 2021 at 2:59 AM kernel test robot <lkp@intel.com> wrote=
:
>>>>
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git master
>>>> head:   7a7fd0de4a9804299793e564a555a49c1fc924cb
>>>> commit: eff8728fe69880d3f7983bec3fb6cea4c306261f vmlinux.lds.h: Add P=
GO and AutoFDO input sections
>>>
>>> This commit added sections explicitly to the kernel's linker script.
>>
>> Yes, but even when reverting this patch it does not prevent
>> the linking problems.
>>
>>
>>>> date:   6 months ago
>>>> config: parisc-randconfig-s031-20210228 (attached as .config)
>>>
>>> ^ randconfig (always find something curious)
>>
>> Yes :-)
>>
>>
>>>> compiler: hppa64-linux-gcc (GCC) 9.3.0
>>>> reproduce:
>>>>           wget https://raw.githubusercontent.com/intel/lkp-tests/mast=
er/sbin/make.cross -O ~/bin/make.cross
>>>>           chmod +x ~/bin/make.cross
>>>>           # apt-get install sparse
>>>>           # sparse version: v0.6.3-241-geaceeafa-dirty
>>>>           # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux.git/commit/?id=3Deff8728fe69880d3f7983bec3fb6cea4c306261f
>>>>           git remote add linus https://git.kernel.org/pub/scm/linux/k=
ernel/git/torvalds/linux.git
>>>>           git fetch --no-tags linus master
>>>>           git checkout eff8728fe69880d3f7983bec3fb6cea4c306261f
>>>>           # save the attached .config to linux build tree
>>>>           COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 mak=
e.cross C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=3Dparisc
>>>>
>>>> If you fix the issue, kindly add following tag as appropriate
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> All errors (new ones prefixed by >>):
>>>>
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x294): cannot reach pri=
ntk
>>>>      init/main.o: in function `do_early_param':
>>>>      (.init.text+0x294): relocation truncated to fit: R_PARISC_PCREL2=
2F against symbol `printk' defined in .text.unlikely section in kernel/pri=
ntk/printk.o
>>>
>>> ^ so we can't encode a jump to printk from do_early_param.
>>
>> Right.
>>
>>> If the linker is warning that printk is in the .text.unlikely
>>> section, I'm curious why printk is marked cold?
>>
>> printk is always marked cold, see include/linux/printk.h:
>> asmlinkage __printf(1, 2) __cold
>> int printk(const char *fmt, ...);
>>
>>> Likely the randconfig produces a large TEXT_MAIN;
>>
>> Yes.
>>
>>> I'm guessing that .init.text is on one side of TEXT_MAIN, and
>>> .text.unlikely is on the other.  Though there are many different
>>> instances below.
>> Yes. But even the large TEXT_MAIN by itself can become a problem.
>>
>>> I'm more familiar with ARM; it's common for the linker to insert
>>> trampolines/thunks to bridge jumps too large to encode in a given
>>> instruction.  I don't know if BFD has arch agnostic machinery for
>>> that, but might be seeing if there's anything reuseable there.
>>
>> Dave mentioned in another mail, that long branch stub support is
>> still missing in the 64-bit parisc linker.
>>
>> My question still remains:
>> Is there any possibility to detect that we build/configure a
>> 0-day kernel? If so, auto-enabling CONFIG_MLONGCALLS kernel option
>> would solve it (temporarily).
>
> Arnd, is this kind of case what CONFIG_COMPILE_TEST is usually used for?

Yes, I think that's the right knob!
CONFIG_COMPILE_TEST is enabled on all parisc configs for which 0-day
reported issues.
I've wired it up in Kconfig and it now works around the issue.

Helge


>> The better long-term solution is to add long branch stub support
>> to the linker.
>
> Agreed.
>
>>
>> Helge
>>
>>> The commit in question (eff8728fe69880d3f7983bec3fb6cea4c306261f)
>>> doesn't reorder existing sections, but does add .text.hot.* before
>>> TEXT_MAIN.  Existing sections could have been placed as "orphan
>>> sections."
>>>
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x56c): cannot reach pri=
ntk
>>>>      init/main.o: in function `unknown_bootoption':
>>>>      (.init.text+0x56c): relocation truncated to fit: R_PARISC_PCREL2=
2F against symbol `printk' defined in .text.unlikely section in kernel/pri=
ntk/printk.o
>>>>      hppa64-linux-ld: init/main.o(.init.text+0xa68): cannot reach pri=
ntk
>>>>      init/main.o: in function `xbc_make_cmdline':
>>>>      (.init.text+0xa68): relocation truncated to fit: R_PARISC_PCREL2=
2F against symbol `printk' defined in .text.unlikely section in kernel/pri=
ntk/printk.o
>>>>      hppa64-linux-ld: init/main.o(.init.text+0xaac): cannot reach pri=
ntk
>>>>      (.init.text+0xaac): relocation truncated to fit: R_PARISC_PCREL2=
2F against symbol `printk' defined in .text.unlikely section in kernel/pri=
ntk/printk.o
>>>>      hppa64-linux-ld: init/main.o(.init.text+0xb68): cannot reach pri=
ntk
>>>>      init/main.o: in function `initcall_blacklist':
>>>>      (.init.text+0xb68): relocation truncated to fit: R_PARISC_PCREL2=
2F against symbol `printk' defined in .text.unlikely section in kernel/pri=
ntk/printk.o
>>>>      hppa64-linux-ld: init/main.o(.init.text+0xbf8): cannot reach pan=
ic
>>>>      (.init.text+0xbf8): relocation truncated to fit: R_PARISC_PCREL2=
2F against symbol `panic' defined in .text.unlikely section in kernel/pani=
c.o
>>>>      hppa64-linux-ld: init/main.o(.init.text+0xda0): cannot reach res=
t_init
>>>>      init/main.o: in function `arch_call_rest_init':
>>>>      (.init.text+0xda0): relocation truncated to fit: R_PARISC_PCREL2=
2F against symbol `rest_init' defined in .ref.text section in init/main.o
>>>>      hppa64-linux-ld: init/main.o(.init.text+0xef4): cannot reach pri=
ntk
>>>>      init/main.o: in function `start_kernel':
>>>>      (.init.text+0xef4): relocation truncated to fit: R_PARISC_PCREL2=
2F against symbol `printk' defined in .text.unlikely section in kernel/pri=
ntk/printk.o
>>>>      hppa64-linux-ld: init/main.o(.init.text+0xf84): cannot reach pri=
ntk
>>>>      (.init.text+0xf84): relocation truncated to fit: R_PARISC_PCREL2=
2F against symbol `printk' defined in .text.unlikely section in kernel/pri=
ntk/printk.o
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x1068): cannot reach pr=
intk
>>>>      (.init.text+0x1068): relocation truncated to fit: R_PARISC_PCREL=
22F against symbol `printk' defined in .text.unlikely section in kernel/pr=
intk/printk.o
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x10c4): cannot reach pr=
intk
>>>>      (.init.text+0x10c4): additional relocation overflows omitted fro=
m the output
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x1138): cannot reach pr=
intk
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x1154): cannot reach pr=
intk
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x1174): cannot reach pr=
intk
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x12a4): cannot reach pa=
nic
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x13bc): cannot reach bu=
ild_all_zonelists
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x13e8): cannot reach pr=
intk
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x156c): cannot reach un=
known
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x159c): cannot reach pr=
intk
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x15ac): cannot reach un=
known
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x15c8): cannot reach pr=
intk
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x1648): cannot reach __=
warn_printk
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x1750): cannot reach pr=
ofile_init
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x1770): cannot reach __=
warn_printk
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x1818): cannot reach un=
known
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x1840): cannot reach un=
known
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x1878): cannot reach pr=
intk
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x1ab0): cannot reach pr=
intk
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x1b68): cannot reach wa=
it_for_completion
>>>>      hppa64-linux-ld: init/main.o(.init.text+0x1ce4): cannot reach pa=
nic
>>>>      hppa64-linux-ld: init/main.o(.ref.text+0x1c): cannot reach rcu_s=
cheduler_starting
>>>>      hppa64-linux-ld: init/main.o(.ref.text+0x17c): cannot reach unkn=
own
>>>>      hppa64-linux-ld: init/do_mounts.o(.init.text+0x128): cannot reac=
h printk
>>>>      hppa64-linux-ld: init/do_mounts.o(.init.text+0x2e0): cannot reac=
h unknown
>>>>      hppa64-linux-ld: init/do_mounts.o(.init.text+0x484): cannot reac=
h unknown
>>>>      hppa64-linux-ld: init/do_mounts.o(.init.text+0x57c): cannot reac=
h printk
>>>>      hppa64-linux-ld: init/do_mounts.o(.init.text+0x594): cannot reac=
h unknown
>>>>      hppa64-linux-ld: init/do_mounts.o(.init.text+0x5d4): cannot reac=
h unknown
>>>>      hppa64-linux-ld: init/do_mounts.o(.init.text+0x668): cannot reac=
h printk
>>>>      hppa64-linux-ld: init/do_mounts.o(.init.text+0x680): cannot reac=
h printk
>>>>      hppa64-linux-ld: init/do_mounts.o(.init.text+0x6d4): cannot reac=
h printk
>>>>      hppa64-linux-ld: init/do_mounts.o(.init.text+0x6fc): cannot reac=
h printk
>>>>      hppa64-linux-ld: init/do_mounts.o(.init.text+0x720): cannot reac=
h printk
>>>>      hppa64-linux-ld: init/do_mounts.o(.init.text+0x75c): cannot reac=
h printk
>>>>      hppa64-linux-ld: init/do_mounts.o(.init.text+0x774): cannot reac=
h panic
>>>>      hppa64-linux-ld: init/do_mounts.o(.init.text+0x810): cannot reac=
h printk
>>>>      hppa64-linux-ld: init/do_mounts.o(.init.text+0x890): cannot reac=
h printk
>>>>      hppa64-linux-ld: init/do_mounts.o(.init.text+0x9ec): cannot reac=
h printk
>>>>      hppa64-linux-ld: init/do_mounts.o(.init.text+0xa1c): cannot reac=
h driver_probe_done
>>>>      hppa64-linux-ld: init/initramfs.o(.init.text+0x830): cannot reac=
h panic
>>>>      hppa64-linux-ld: init/initramfs.o(.init.text+0xe50): cannot reac=
h panic
>>>>      hppa64-linux-ld: init/initramfs.o(.init.text+0x1660): cannot rea=
ch panic
>>>>      hppa64-linux-ld: init/initramfs.o(.init.text+0x183c): cannot rea=
ch panic
>>>>      hppa64-linux-ld: init/initramfs.o(.init.text+0x1868): cannot rea=
ch printk
>>>>      hppa64-linux-ld: init/initramfs.o(.init.text+0x18a4): cannot rea=
ch printk
>>>>      hppa64-linux-ld: arch/parisc/mm/init.o(.init.text+0x104): cannot=
 reach printk
>>>>      hppa64-linux-ld: arch/parisc/mm/init.o(.init.text+0x180): cannot=
 reach printk
>>>>      hppa64-linux-ld: arch/parisc/mm/init.o(.init.text+0x2d8): cannot=
 reach printk
>>>>      hppa64-linux-ld: arch/parisc/mm/init.o(.init.text+0x340): cannot=
 reach printk
>>>>      hppa64-linux-ld: arch/parisc/mm/init.o(.init.text+0x438): cannot=
 reach printk
>>>>      hppa64-linux-ld: arch/parisc/mm/init.o(.init.text+0x48c): cannot=
 reach printk
>>>>      hppa64-linux-ld: arch/parisc/mm/init.o(.init.text+0x7a0): cannot=
 reach panic
>>>>      hppa64-linux-ld: arch/parisc/mm/init.o(.init.text+0xaa8): cannot=
 reach printk
>>>>      hppa64-linux-ld: arch/parisc/mm/init.o(.init.text+0xb20): cannot=
 reach panic
>>>>      hppa64-linux-ld: arch/parisc/mm/init.o(.ref.text+0x78): cannot r=
each unknown
>>>>      hppa64-linux-ld: arch/parisc/mm/init.o(.ref.text+0xa0): cannot r=
each unknown
>>>>      hppa64-linux-ld: arch/parisc/mm/init.o(.ref.text+0xc4): cannot r=
each unknown
>>>>      hppa64-linux-ld: arch/parisc/kernel/setup.o(.init.text+0x19c): c=
annot reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/setup.o(.init.text+0x28c): c=
annot reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/setup.o(.init.text+0x404): c=
annot reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/setup.o(.init.text+0x420): c=
annot reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/setup.o(.init.text+0x440): c=
annot reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/setup.o(.init.text+0x458): c=
annot reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/setup.o(.init.text+0x488): c=
annot reach panic
>>>>      hppa64-linux-ld: arch/parisc/kernel/setup.o(.init.text+0x4b8): c=
annot reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/setup.o(.init.text+0x624): c=
annot reach panic
>>>>      hppa64-linux-ld: arch/parisc/kernel/hardware.o(.init.text+0x13c)=
: cannot reach panic
>>>>      hppa64-linux-ld: kernel/extable.o(.init.text+0x50): cannot reach=
 printk
>>>>>> hppa64-linux-ld: kernel/sched/core.o(.init.text+0x90): cannot reach=
 printk
>>>>      hppa64-linux-ld: kernel/printk/printk.o(.init.text+0xf0): cannot=
 reach printk
>>>>      hppa64-linux-ld: kernel/printk/printk.o(.init.text+0x254): canno=
t reach printk
>>>>      hppa64-linux-ld: kernel/printk/printk.o(.init.text+0x2a4): canno=
t reach printk
>>>>      hppa64-linux-ld: kernel/printk/printk.o(.init.text+0x5b0): canno=
t reach printk
>>>>      hppa64-linux-ld: kernel/printk/printk.o(.init.text+0x5c4): canno=
t reach unregister_console
>>>>      hppa64-linux-ld: kernel/printk/printk.o(.init.text+0x734): canno=
t reach printk
>>>>      hppa64-linux-ld: kernel/printk/printk.o(.init.text+0x768): canno=
t reach _raw_spin_lock
>>>>      hppa64-linux-ld: kernel/printk/printk.o(.init.text+0x7c4): canno=
t reach _raw_spin_unlock
>>>>      hppa64-linux-ld: kernel/printk/printk.o(.init.text+0x7f4): canno=
t reach printk
>>>>      hppa64-linux-ld: kernel/printk/printk.o(.init.text+0x818): canno=
t reach printk
>>>>      hppa64-linux-ld: kernel/crash_core.o(.init.text+0x408): cannot r=
each printk
>>>>      hppa64-linux-ld: kernel/crash_core.o(.init.text+0x44c): cannot r=
each printk
>>>>      hppa64-linux-ld: kernel/crash_core.o(.init.text+0x4a8): cannot r=
each printk
>>>>      hppa64-linux-ld: kernel/crash_core.o(.init.text+0x670): cannot r=
each printk
>>>>      hppa64-linux-ld: kernel/crash_core.o(.init.text+0x778): cannot r=
each printk
>>>>      hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x228): canno=
t reach mutex_lock
>>>>      hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x440): canno=
t reach mutex_unlock
>>>>      hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x5a8): canno=
t reach __warn_printk
>>>>      hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x5e0): canno=
t reach __warn_printk
>>>>      hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x7a0): canno=
t reach mutex_lock
>>>>      hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x878): canno=
t reach mutex_unlock
>>>>      hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x97c): canno=
t reach printk
>>>>      hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0x9b4): canno=
t reach printk
>>>>      hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0xad4): canno=
t reach mutex_lock
>>>>      hppa64-linux-ld: kernel/cgroup/cgroup.o(.init.text+0xafc): canno=
t reach mutex_unlock
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x524): cannot reach=
 printk
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x56c): cannot reach=
 __muldi3
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x590): cannot reach=
 __udivdi3
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x5c0): cannot reach=
 __muldi3
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x5e4): cannot reach=
 __udivdi3
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x658): cannot reach=
 __udivdi3
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x7d8): cannot reach=
 _raw_spin_lock
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x804): cannot reach=
 _raw_spin_unlock
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x820): cannot reach=
 unknown
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0xe34): cannot reach=
 printk
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x10cc): cannot reac=
h printk
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x1250): cannot reac=
h printk
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x1274): cannot reac=
h printk
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x12a8): cannot reac=
h printk
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x135c): cannot reac=
h printk
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x179c): cannot reac=
h printk
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x17e4): cannot reac=
h printk
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x180c): cannot reac=
h printk
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x1830): cannot reac=
h printk
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x1864): cannot reac=
h printk
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x1894): cannot reac=
h printk
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x18c8): cannot reac=
h printk
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x1940): cannot reac=
h printk
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x1aa8): cannot reac=
h printk
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x1d04): cannot reac=
h printk
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x1ecc): cannot reac=
h __muldi3
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x1eec): cannot reac=
h __udivdi3
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x1f38): cannot reac=
h __udivdi3
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x2088): cannot reac=
h panic
>>>>      hppa64-linux-ld: mm/page_alloc.o(.init.text+0x20e4): cannot reac=
h printk
>>>>      hppa64-linux-ld: mm/page_alloc.o(.ref.text+0x34): cannot reach u=
nknown
>>>>      hppa64-linux-ld: mm/memblock.o(.init.text+0x100): cannot reach _=
_warn_printk
>>>>      hppa64-linux-ld: mm/memblock.o(.init.text+0x118): cannot reach d=
ump_stack
>>>>      hppa64-linux-ld: mm/memblock.o(.init.text+0x228): cannot reach p=
rintk
>>>>      hppa64-linux-ld: mm/memblock.o(.init.text+0x488): cannot reach p=
rintk
>>>>      hppa64-linux-ld: mm/memblock.o(.init.text+0x550): cannot reach p=
rintk
>>>>      hppa64-linux-ld: mm/memblock.o(.init.text+0x618): cannot reach p=
rintk
>>>>      hppa64-linux-ld: mm/memblock.o(.init.text+0x700): cannot reach p=
rintk
>>>>      hppa64-linux-ld: mm/memblock.o(.init.text+0x73c): cannot reach u=
nknown
>>>>      hppa64-linux-ld: mm/memblock.o(.init.text+0xe00): cannot reach u=
nknown
>>>>      hppa64-linux-ld: mm/hugetlb.o(.init.text+0x248): cannot reach pr=
intk
>>>>      hppa64-linux-ld: mm/hugetlb.o(.init.text+0x26c): cannot reach pr=
intk
>>>>      hppa64-linux-ld: mm/hugetlb.o(.init.text+0x2b8): cannot reach _c=
ond_resched
>>>>      hppa64-linux-ld: mm/hugetlb.o(.init.text+0x38c): cannot reach pr=
intk
>>>>      hppa64-linux-ld: mm/hugetlb.o(.init.text+0x3ec): cannot reach pr=
intk
>>>>      hppa64-linux-ld: mm/hugetlb.o(.init.text+0x738): cannot reach pr=
intk
>>>>      hppa64-linux-ld: mm/hugetlb.o(.init.text+0x754): cannot reach pr=
intk
>>>>      hppa64-linux-ld: mm/hugetlb.o(.init.text+0x8b8): cannot reach _r=
aw_spin_lock
>>>>      hppa64-linux-ld: mm/hugetlb.o(.init.text+0x8e4): cannot reach _r=
aw_spin_unlock
>>>>      hppa64-linux-ld: mm/hugetlb.o(.init.text+0x94c): cannot reach _c=
ond_resched
>>>>      hppa64-linux-ld: mm/hugetlb.o(.init.text+0x9c4): cannot reach pr=
intk
>>>>      hppa64-linux-ld: mm/hugetlb.o(.init.text+0xb24): cannot reach pr=
intk
>>>>      hppa64-linux-ld: mm/hugetlb.o(.init.text+0xce0): cannot reach pr=
intk
>>>>      hppa64-linux-ld: mm/hugetlb.o(.init.text+0xd04): cannot reach un=
known
>>>>      hppa64-linux-ld: mm/hugetlb.o(.init.text+0xddc): cannot reach pr=
intk
>>>>      hppa64-linux-ld: mm/hugetlb.o(.init.text+0xdf4): cannot reach un=
known
>>>>>> hppa64-linux-ld: mm/slab.o(.init.text+0x1c8): cannot reach unknown
>>>>      hppa64-linux-ld: mm/slab.o(.init.text+0x1ec): cannot reach unkno=
wn
>>>>      hppa64-linux-ld: mm/slab.o(.init.text+0x20c): cannot reach unkno=
wn
>>>>      hppa64-linux-ld: mm/slab.o(.init.text+0x438): cannot reach mutex=
_lock
>>>>      hppa64-linux-ld: mm/slab.o(.init.text+0x490): cannot reach mutex=
_unlock
>>>>      hppa64-linux-ld: fs/namespace.o(.init.text+0x214): cannot reach =
printk
>>>>      hppa64-linux-ld: fs/namespace.o(.init.text+0x260): cannot reach =
printk
>>>>      hppa64-linux-ld: fs/namespace.o(.init.text+0x2cc): cannot reach =
panic
>>>>      hppa64-linux-ld: lib/dynamic_debug.o(.init.text+0x40): cannot re=
ach printk
>>>>      hppa64-linux-ld: lib/dynamic_debug.o(.init.text+0x1c4): cannot r=
each printk
>>>>      hppa64-linux-ld: lib/dynamic_debug.o(.init.text+0x2d0): cannot r=
each printk
>>>>      hppa64-linux-ld: lib/dynamic_debug.o(.init.text+0x2fc): cannot r=
each printk
>>>>      hppa64-linux-ld: lib/dynamic_debug.o(.init.text+0x338): cannot r=
each printk
>>>>      hppa64-linux-ld: lib/dynamic_debug.o(.init.text+0x354): cannot r=
each printk
>>>>      hppa64-linux-ld: lib/dynamic_debug.o(.init.text+0x3e4): cannot r=
each mutex_lock
>>>>      hppa64-linux-ld: lib/dynamic_debug.o(.init.text+0x454): cannot r=
each mutex_unlock
>>>>      hppa64-linux-ld: lib/bootconfig.o(.init.text+0xdc): cannot reach=
 unknown
>>>>      hppa64-linux-ld: lib/bootconfig.o(.init.text+0x2a0): cannot reac=
h unknown
>>>>      hppa64-linux-ld: lib/bootconfig.o(.init.text+0x1660): cannot rea=
ch unknown
>>>>>> hppa64-linux-ld: lib/plist.o(.init.text+0x144): cannot reach printk
>>>>      hppa64-linux-ld: lib/plist.o(.init.text+0x450): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: drivers/clk/clk.o(.init.text+0x250): cannot rea=
ch mutex_lock
>>>>      hppa64-linux-ld: drivers/clk/clk.o(.init.text+0x2b4): cannot rea=
ch mutex_unlock
>>>>>> hppa64-linux-ld: drivers/clk/renesas/rcar-gen2-cpg.o(.init.text+0x1=
54): cannot reach unknown
>>>>      hppa64-linux-ld: drivers/clk/renesas/rcar-gen2-cpg.o(.init.text+=
0x204): cannot reach unknown
>>>>      hppa64-linux-ld: drivers/clk/renesas/rcar-gen2-cpg.o(.init.text+=
0x248): cannot reach unknown
>>>>      hppa64-linux-ld: drivers/clk/renesas/rcar-gen2-cpg.o(.init.text+=
0x390): cannot reach unknown
>>>>      hppa64-linux-ld: drivers/clk/renesas/rcar-gen2-cpg.o(.init.text+=
0x3b8): cannot reach unknown
>>>>      hppa64-linux-ld: drivers/clk/renesas/rcar-gen3-cpg.o(.init.text+=
0x188): cannot reach unknown
>>>>      hppa64-linux-ld: drivers/clk/renesas/rcar-gen3-cpg.o(.init.text+=
0x2b4): cannot reach unknown
>>>>      hppa64-linux-ld: drivers/clk/renesas/rcar-gen3-cpg.o(.init.text+=
0x3ec): cannot reach unknown
>>>>      hppa64-linux-ld: drivers/clk/renesas/rcar-gen3-cpg.o(.init.text+=
0x568): cannot reach unknown
>>>>      hppa64-linux-ld: drivers/clk/renesas/rcar-gen3-cpg.o(.init.text+=
0x65c): cannot reach unknown
>>>>      hppa64-linux-ld: drivers/base/devtmpfs.o(.init.text+0x25c): cann=
ot reach wait_for_completion
>>>>      hppa64-linux-ld: drivers/base/devtmpfs.o(.ref.text+0x60): cannot=
 reach init_mount
>>>>      hppa64-linux-ld: drivers/base/devtmpfs.o(.ref.text+0x80): cannot=
 reach init_chdir
>>>>      hppa64-linux-ld: drivers/base/devtmpfs.o(.ref.text+0x98): cannot=
 reach init_chroot
>>>>      hppa64-linux-ld: mm/mm_init.o(.init.text+0x160): cannot reach pr=
intk
>>>>      hppa64-linux-ld: mm/mm_init.o(.init.text+0x1ac): cannot reach pr=
intk
>>>>      hppa64-linux-ld: mm/mm_init.o(.init.text+0x1f4): cannot reach pr=
intk
>>>>      hppa64-linux-ld: mm/mm_init.o(.init.text+0x2a0): cannot reach pr=
intk
>>>>      hppa64-linux-ld: mm/mm_init.o(.init.text+0x2d4): cannot reach pr=
intk
>>>>      hppa64-linux-ld: mm/mm_init.o(.init.text+0x308): cannot reach pr=
intk
>>>>      hppa64-linux-ld: mm/mm_init.o(.init.text+0x330): cannot reach pr=
intk
>>>>      hppa64-linux-ld: mm/mm_init.o(.init.text+0x364): cannot reach pr=
intk
>>>>      hppa64-linux-ld: mm/sparse.o(.ref.text+0x60): cannot reach membl=
ock_alloc_try_nid
>>>>      hppa64-linux-ld: mm/sparse.o(.init.text+0x9c): cannot reach pani=
c
>>>>      hppa64-linux-ld: mm/sparse.o(.init.text+0x1b8): cannot reach unk=
nown
>>>>      hppa64-linux-ld: mm/sparse.o(.init.text+0x224): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/sparse.o(.init.text+0x280): cannot reach unk=
nown
>>>>      hppa64-linux-ld: mm/sparse.o(.init.text+0x2d8): cannot reach unk=
nown
>>>>      hppa64-linux-ld: mm/sparse.o(.init.text+0x310): cannot reach unk=
nown
>>>>      hppa64-linux-ld: mm/sparse.o(.init.text+0x474): cannot reach pan=
ic
>>>>      hppa64-linux-ld: mm/sparse.o(.init.text+0x4c0): cannot reach unk=
nown
>>>>      hppa64-linux-ld: mm/sparse.o(.init.text+0x564): cannot reach unk=
nown
>>>>      hppa64-linux-ld: mm/sparse.o(.init.text+0x5ac): cannot reach unk=
nown
>>>>      hppa64-linux-ld: mm/sparse.o(.init.text+0x620): cannot reach unk=
nown
>>>>      hppa64-linux-ld: arch/parisc/kernel/processor.o(.init.text+0x6c)=
: cannot reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/processor.o(.init.text+0xc8)=
: cannot reach panic
>>>>      hppa64-linux-ld: arch/parisc/kernel/processor.o(.init.text+0x180=
): cannot reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/processor.o(.init.text+0x2cc=
): cannot reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/processor.o(.init.text+0x31c=
): cannot reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/processor.o(.init.text+0x370=
): cannot reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/processor.o(.init.text+0x3bc=
): cannot reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/processor.o(.init.text+0x3f0=
): cannot reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/processor.o(.init.text+0x4cc=
): cannot reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/processor.o(.init.text+0x600=
): cannot reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/processor.o(.init.text+0x620=
): cannot reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/processor.o(.init.text+0x660=
): cannot reach panic
>>>>      hppa64-linux-ld: arch/parisc/kernel/pdc_chassis.o(.init.text+0x8=
0): cannot reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/pdc_chassis.o(.init.text+0xa=
4): cannot reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/pdc_chassis.o(.init.text+0x1=
4c): cannot reach printk
>>>>      hppa64-linux-ld: kernel/panic.o(.init.text+0x1a8): cannot reach =
printk
>>>>      hppa64-linux-ld: kernel/cpu.o(.init.text+0xb8): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: kernel/cpu.o(.init.text+0x11c): cannot reach un=
known
>>>>      hppa64-linux-ld: kernel/cpu.o(.init.text+0x138): cannot reach un=
known
>>>>      hppa64-linux-ld: kernel/cpu.o(.init.text+0x150): cannot reach un=
known
>>>>      hppa64-linux-ld: kernel/resource.o(.init.text+0x32c): cannot rea=
ch _raw_write_lock
>>>>      hppa64-linux-ld: kernel/resource.o(.init.text+0x364): cannot rea=
ch printk
>>>>      hppa64-linux-ld: kernel/resource.o(.init.text+0x3ac): cannot rea=
ch printk
>>>>      hppa64-linux-ld: kernel/resource.o(.init.text+0x3bc): cannot rea=
ch dump_stack
>>>>      hppa64-linux-ld: kernel/resource.o(.init.text+0x4f8): cannot rea=
ch _raw_write_unlock
>>>>      hppa64-linux-ld: kernel/sched/fair.o(.init.text+0x40): cannot re=
ach printk
>>>>      hppa64-linux-ld: kernel/irq/spurious.o(.init.text+0x30): cannot =
reach printk
>>>>      hppa64-linux-ld: kernel/irq/spurious.o(.init.text+0x48): cannot =
reach printk
>>>>      hppa64-linux-ld: kernel/irq/spurious.o(.init.text+0x98): cannot =
reach printk
>>>>      hppa64-linux-ld: kernel/irq/spurious.o(.init.text+0xb0): cannot =
reach printk
>>>>      hppa64-linux-ld: kernel/dma/debug.o(.init.text+0x50): cannot rea=
ch printk
>>>>      hppa64-linux-ld: kernel/dma/debug.o(.init.text+0xec): cannot rea=
ch printk
>>>>      hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0x90): can=
not reach mutex_lock
>>>>      hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0xc4): can=
not reach mutex_unlock
>>>>      hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0x134): ca=
nnot reach printk
>>>>      hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0x158): ca=
nnot reach printk
>>>>      hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0x1b8): ca=
nnot reach mutex_lock
>>>>      hppa64-linux-ld: kernel/time/clocksource.o(.init.text+0x208): ca=
nnot reach mutex_unlock
>>>>      hppa64-linux-ld: kernel/gcov/fs.o(.init.text+0x44): cannot reach=
 printk
>>>>      hppa64-linux-ld: kernel/gcov/fs.o(.init.text+0x70): cannot reach=
 printk
>>>>>> hppa64-linux-ld: kernel/debug/debug_core.o(.init.text+0xfc): cannot=
 reach printk
>>>>      hppa64-linux-ld: mm/slab_common.o(.init.text+0x148): cannot reac=
h panic
>>>>      hppa64-linux-ld: mm/slab_common.o(.init.text+0x1fc): cannot reac=
h panic
>>>>      hppa64-linux-ld: mm/page_owner.o(.init.text+0xbc): cannot reach =
printk
>>>>      hppa64-linux-ld: crypto/asymmetric_keys/restrict.o(.init.text+0x=
a4): cannot reach printk
>>>>>> hppa64-linux-ld: block/elevator.o(.init.text+0x20): cannot reach pr=
intk
>>>>>> hppa64-linux-ld: lib/crypto/curve25519-selftest.o(.init.text+0x120)=
: cannot reach printk
>>>>      hppa64-linux-ld: lib/crypto/curve25519-selftest.o(.init.text+0x2=
fc): cannot reach printk
>>>>      hppa64-linux-ld: lib/crypto/curve25519-selftest.o(.init.text+0x3=
18): cannot reach printk
>>>>      hppa64-linux-ld: lib/crypto/curve25519-selftest.o(.init.text+0x3=
38): cannot reach printk
>>>>      hppa64-linux-ld: lib/vsprintf.o(.init.text+0x2c): cannot reach p=
rintk
>>>>>> hppa64-linux-ld: drivers/phy/broadcom/phy-bcm63xx-usbh.o(.init.text=
+0x12c): cannot reach _dev_err
>>>>      hppa64-linux-ld: drivers/phy/broadcom/phy-bcm63xx-usbh.o(.init.t=
ext+0x214): cannot reach _dev_err
>>>>      hppa64-linux-ld: drivers/video/console/sticore.o(.init.text+0x88=
): cannot reach unknown
>>>>      hppa64-linux-ld: drivers/video/console/sticore.o(.init.text+0xb8=
): cannot reach unknown
>>>>      hppa64-linux-ld: drivers/video/console/sticore.o(.init.text+0xe0=
): cannot reach unknown
>>>>      hppa64-linux-ld: drivers/tty/serial/8250/8250_early.o(.init.text=
+0x16c): cannot reach $$divU
>>>>      hppa64-linux-ld: drivers/tty/serial/altera_uart.o(.init.text+0x2=
00): cannot reach $$divU
>>>>      hppa64-linux-ld: drivers/tty/serial/arc_uart.o(.init.text+0x2c):=
 cannot reach $$divU
>>>>>> hppa64-linux-ld: kernel/kprobes.o(.init.text+0x258): cannot reach p=
rintk
>>>>      hppa64-linux-ld: kernel/kprobes.o(.init.text+0x270): cannot reac=
h printk
>>>>      hppa64-linux-ld: kernel/workqueue.o(.init.text+0xa8): cannot rea=
ch mutex_lock
>>>>      hppa64-linux-ld: kernel/workqueue.o(.init.text+0x100): cannot re=
ach __warn_printk
>>>>      hppa64-linux-ld: kernel/workqueue.o(.init.text+0x128): cannot re=
ach mutex_unlock
>>>>      hppa64-linux-ld: kernel/workqueue.o(.init.text+0x354): cannot re=
ach mutex_lock
>>>>      hppa64-linux-ld: kernel/workqueue.o(.init.text+0x388): cannot re=
ach mutex_unlock
>>>>      hppa64-linux-ld: kernel/rcu/update.o(.init.text+0xb4): cannot re=
ach __warn_printk
>>>>      hppa64-linux-ld: fs/configfs/mount.o(.init.text+0xbc): cannot re=
ach printk
>>>>>> hppa64-linux-ld: lib/random32.o(.init.text+0xd0): cannot reach unkn=
own
>>>>>> hppa64-linux-ld: lib/random32.o(.init.text+0x138): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: lib/random32.o(.init.text+0x174): cannot reach =
unknown
>>>>      hppa64-linux-ld: lib/random32.o(.init.text+0x204): cannot reach =
_cond_resched
>>>>      hppa64-linux-ld: lib/random32.o(.init.text+0x234): cannot reach =
printk
>>>>      hppa64-linux-ld: lib/random32.o(.init.text+0x254): cannot reach =
printk
>>>>      hppa64-linux-ld: lib/random32.o(.init.text+0x284): cannot reach =
unknown
>>>>      hppa64-linux-ld: drivers/pinctrl/core.o(.init.text+0x28): cannot=
 reach printk
>>>>      hppa64-linux-ld: drivers/pinctrl/core.o(.init.text+0x100): canno=
t reach printk
>>>>      hppa64-linux-ld: drivers/gpio/gpiolib.o(.init.text+0xb8): cannot=
 reach printk
>>>>      hppa64-linux-ld: drivers/gpio/gpiolib.o(.init.text+0x108): canno=
t reach printk
>>>>>> hppa64-linux-ld: drivers/gpio/gpiolib.o(.init.text+0x118): cannot r=
each bus_unregister
>>>>>> hppa64-linux-ld: drivers/gpio/gpiolib.o(.init.text+0x198): cannot r=
each _dev_err
>>>>>> hppa64-linux-ld: drivers/regulator/core.o(.init.text+0x80): cannot =
reach __class_register
>>>>      hppa64-linux-ld: drivers/i2c/i2c-core-base.o(.init.text+0x34): c=
annot reach down_write
>>>>>> hppa64-linux-ld: drivers/dma/dmaengine.o(.init.text+0x198): cannot =
reach __class_register
>>>>      hppa64-linux-ld: kernel/user.o(.init.text+0x80): cannot reach _r=
aw_spin_lock_irq
>>>>      hppa64-linux-ld: kernel/user.o(.init.text+0xb8): cannot reach _r=
aw_spin_unlock_irq
>>>>      hppa64-linux-ld: kernel/params.o(.init.text+0x108): cannot reach=
 printk
>>>>      hppa64-linux-ld: kernel/params.o(.init.text+0x1c8): cannot reach=
 printk
>>>>>> hppa64-linux-ld: kernel/params.o(.init.text+0x250): cannot reach ko=
bject_uevent
>>>>      hppa64-linux-ld: kernel/params.o(.init.text+0x3a0): cannot reach=
 kobject_uevent
>>>>>> hppa64-linux-ld: kernel/kexec_core.o(.init.text+0x50): cannot reach=
 printk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0xa4): cannot reach prin=
tk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0xc4): cannot reach __mu=
ldi3
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0xdc): cannot reach unkn=
own
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x100): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x234): cannot reach pan=
ic
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x4a8): cannot reach __m=
uldi3
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x610): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x634): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x64c): cannot reach unk=
nown
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x678): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x69c): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x6b4): cannot reach unk=
nown
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x6d8): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x6fc): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x714): cannot reach unk=
nown
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x75c): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x780): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x798): cannot reach unk=
nown
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x7c4): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x7e8): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x800): cannot reach unk=
nown
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x82c): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x850): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x868): cannot reach unk=
nown
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x894): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x8b8): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x8d0): cannot reach unk=
nown
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x8fc): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x920): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x938): cannot reach unk=
nown
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x970): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x994): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x9ac): cannot reach unk=
nown
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0xad8): cannot reach __m=
uldi3
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0xb3c): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0xb60): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0xb78): cannot reach unk=
nown
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0xbc8): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0xbec): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0xc04): cannot reach unk=
nown
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0xc24): cannot reach __m=
uldi3
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0xce0): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0xd04): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0xd1c): cannot reach unk=
nown
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0xd3c): cannot reach unk=
nown
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0xe88): cannot reach pan=
ic
>>>>      hppa64-linux-ld: mm/percpu.o(.init.text+0x1078): cannot reach pa=
nic
>>>>>> hppa64-linux-ld: mm/compaction.o(.init.text+0x60): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: mm/page_idle.o(.init.text+0x50): cannot reach p=
rintk
>>>>>> hppa64-linux-ld: crypto/cryptd.o(.init.text+0xe0): cannot reach pri=
ntk
>>>>>> hppa64-linux-ld: crypto/cryptd.o(.init.text+0x114): cannot reach un=
known
>>>>      hppa64-linux-ld: block/bio.o(.init.text+0x13c): cannot reach pan=
ic
>>>>      hppa64-linux-ld: block/genhd.o(.init.text+0x3c): cannot reach __=
class_register
>>>>      hppa64-linux-ld: block/genhd.o(.init.text+0x354): cannot reach p=
rintk
>>>>      hppa64-linux-ld: block/genhd.o(.init.text+0x384): cannot reach p=
rintk
>>>>      hppa64-linux-ld: block/genhd.o(.init.text+0x3ac): cannot reach p=
rintk
>>>>      hppa64-linux-ld: block/blk-crypto.o(.init.text+0x94): cannot rea=
ch panic
>>>>      hppa64-linux-ld: drivers/pwm/sysfs.o(.init.text+0x28): cannot re=
ach __class_register
>>>>      hppa64-linux-ld: drivers/clk/renesas/renesas-cpg-mssr.o(.init.te=
xt+0x1a8): cannot reach _dev_err
>>>>      hppa64-linux-ld: drivers/clk/renesas/renesas-cpg-mssr.o(.init.te=
xt+0x1f0): cannot reach _dev_err
>>>>      hppa64-linux-ld: drivers/clk/renesas/renesas-cpg-mssr.o(.init.te=
xt+0x2bc): cannot reach unknown
>>>>      hppa64-linux-ld: drivers/clk/renesas/renesas-cpg-mssr.o(.init.te=
xt+0x3dc): cannot reach unknown
>>>>      hppa64-linux-ld: drivers/clk/renesas/renesas-cpg-mssr.o(.init.te=
xt+0x51c): cannot reach _dev_err
>>>>      hppa64-linux-ld: drivers/dma/mxs-dma.o(.init.text+0x98): cannot =
reach _dev_err
>>>>      hppa64-linux-ld: drivers/watchdog/watchdog_core.o(.init.text+0x5=
4): cannot reach mutex_lock
>>>>      hppa64-linux-ld: drivers/watchdog/watchdog_core.o(.init.text+0xe=
0): cannot reach mutex_unlock
>>>>      hppa64-linux-ld: kernel/locking/lock_events.o(.init.text+0x104):=
 cannot reach printk
>>>>      hppa64-linux-ld: fs/eventpoll.o(.init.text+0x3c): cannot reach _=
_udivdi3
>>>>      hppa64-linux-ld: fs/eventpoll.o(.init.text+0x54): cannot reach _=
_udivdi3
>>>>      hppa64-linux-ld: fs/anon_inodes.o(.init.text+0x88): cannot reach=
 panic
>>>>      hppa64-linux-ld: fs/proc/bootconfig.o(.init.text+0x70): cannot r=
each unknown
>>>>      hppa64-linux-ld: fs/proc/bootconfig.o(.init.text+0x308): cannot =
reach unknown
>>>>      hppa64-linux-ld: fs/hugetlbfs/inode.o(.init.text+0xa8): cannot r=
each printk
>>>>      hppa64-linux-ld: block/scsi_ioctl.o(.init.text+0x18): cannot rea=
ch unknown
>>>>      hppa64-linux-ld: arch/parisc/kernel/pdc_cons.o(.init.text+0x7c):=
 cannot reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/pdc_cons.o(.init.text+0x98):=
 cannot reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/pdc_cons.o(.init.text+0x1d0)=
: cannot reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/pdc_cons.o(.init.text+0x240)=
: cannot reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/perf.o(.init.text+0x8c): can=
not reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/perf.o(.init.text+0xc8): can=
not reach printk
>>>>      hppa64-linux-ld: arch/parisc/kernel/perf.o(.init.text+0xfc): can=
not reach printk
>>>>      hppa64-linux-ld: kernel/locking/locktorture.o(.init.text+0xec): =
cannot reach printk
>>>>      hppa64-linux-ld: kernel/locking/locktorture.o(.init.text+0x114):=
 cannot reach printk
>>>>      hppa64-linux-ld: kernel/locking/locktorture.o(.init.text+0x214):=
 cannot reach unknown
>>>>      hppa64-linux-ld: kernel/locking/locktorture.o(.init.text+0x28c):=
 cannot reach unknown
>>>>      hppa64-linux-ld: kernel/locking/locktorture.o(.init.text+0x308):=
 cannot reach unknown
>>>>      hppa64-linux-ld: kernel/locking/locktorture.o(.init.text+0x340):=
 cannot reach printk
>>>>      hppa64-linux-ld: kernel/locking/locktorture.o(.init.text+0x4ac):=
 cannot reach unknown
>>>>      hppa64-linux-ld: kernel/locking/locktorture.o(.init.text+0x4e8):=
 cannot reach printk
>>>>      hppa64-linux-ld: kernel/locking/locktorture.o(.init.text+0x574):=
 cannot reach unknown
>>>>      hppa64-linux-ld: kernel/locking/locktorture.o(.init.text+0x5b0):=
 cannot reach printk
>>>>      hppa64-linux-ld: kernel/locking/locktorture.o(.init.text+0x748):=
 cannot reach printk
>>>>      hppa64-linux-ld: kernel/locking/locktorture.o(.init.text+0x760):=
 cannot reach printk
>>>>      hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0xe4): canno=
t reach printk
>>>>      hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0x104): cann=
ot reach printk
>>>>      hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0x134): cann=
ot reach printk
>>>>      hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0x1b4): cann=
ot reach unknown
>>>>      hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0x3c4): cann=
ot reach unknown
>>>>      hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0x3f8): cann=
ot reach printk
>>>>      hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0x464): cann=
ot reach unknown
>>>>      hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0x8b0): cann=
ot reach printk
>>>>      hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0x8f4): cann=
ot reach printk
>>>>      hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0xa20): cann=
ot reach printk
>>>>      hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0xa3c): cann=
ot reach printk
>>>>      hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0xa84): cann=
ot reach unknown
>>>>      hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0xaac): cann=
ot reach unknown
>>>>      hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0xc7c): cann=
ot reach printk
>>>>      hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0xcd8): cann=
ot reach printk
>>>>      hppa64-linux-ld: kernel/rcu/rcutorture.o(.init.text+0xcf0): cann=
ot reach printk
>>>>      hppa64-linux-ld: kernel/rcu/refscale.o(.init.text+0xe0): cannot =
reach printk
>>>>      hppa64-linux-ld: kernel/rcu/refscale.o(.init.text+0x100): cannot=
 reach printk
>>>>      hppa64-linux-ld: kernel/rcu/refscale.o(.init.text+0x19c): cannot=
 reach printk
>>>>      hppa64-linux-ld: kernel/rcu/refscale.o(.init.text+0x228): cannot=
 reach schedule_timeout_uninterruptible
>>>>      hppa64-linux-ld: kernel/rcu/refscale.o(.init.text+0x29c): cannot=
 reach printk
>>>>      hppa64-linux-ld: kernel/rcu/refscale.o(.init.text+0x2c8): cannot=
 reach printk
>>>>      hppa64-linux-ld: kernel/rcu/refscale.o(.init.text+0x434): cannot=
 reach printk
>>>>      hppa64-linux-ld: kernel/rcu/refscale.o(.init.text+0x44c): cannot=
 reach printk
>>>>      hppa64-linux-ld: kernel/time/timekeeping.o(.init.text+0x188): ca=
nnot reach printk
>>>>      hppa64-linux-ld: kernel/time/timekeeping.o(.init.text+0x228): ca=
nnot reach _raw_spin_lock_irqsave
>>>>      hppa64-linux-ld: kernel/time/timekeeping.o(.init.text+0x320): ca=
nnot reach _raw_spin_unlock_irqrestore
>>>>      hppa64-linux-ld: kernel/time/sched_clock.o(.init.text+0x170): ca=
nnot reach __muldi3
>>>>      hppa64-linux-ld: kernel/time/sched_clock.o(.init.text+0x214): ca=
nnot reach __udivdi3
>>>>      hppa64-linux-ld: kernel/time/sched_clock.o(.init.text+0x240): ca=
nnot reach __udivdi3
>>>>      hppa64-linux-ld: kernel/time/sched_clock.o(.init.text+0x278): ca=
nnot reach printk
>>>>      hppa64-linux-ld: kernel/seccomp.o(.init.text+0x44): cannot reach=
 printk
>>>>      hppa64-linux-ld: certs/system_keyring.o(.init.text+0x20): cannot=
 reach printk
>>>>      hppa64-linux-ld: certs/system_keyring.o(.init.text+0x8c): cannot=
 reach panic
>>>>      hppa64-linux-ld: certs/system_keyring.o(.init.text+0x118): canno=
t reach printk
>>>>      hppa64-linux-ld: certs/system_keyring.o(.init.text+0x1d4): canno=
t reach printk
>>>>      hppa64-linux-ld: certs/system_keyring.o(.init.text+0x1f8): canno=
t reach printk
>>>>      hppa64-linux-ld: certs/system_keyring.o(.init.text+0x238): canno=
t reach printk
>>>>      hppa64-linux-ld: mm/workingset.o(.init.text+0xfc): cannot reach =
printk
>>>>      hppa64-linux-ld: fs/filesystems.o(.init.text+0xb0): cannot reach=
 _raw_read_lock
>>>>      hppa64-linux-ld: fs/filesystems.o(.init.text+0x130): cannot reac=
h _raw_read_unlock
>>>>      hppa64-linux-ld: fs/block_dev.o(.init.text+0xf0): cannot reach p=
anic
>>>>      hppa64-linux-ld: fs/aio.o(.init.text+0x50): cannot reach panic
>>>>      hppa64-linux-ld: fs/ext4/super.o(.init.text+0x1e4): cannot reach=
 printk
>>>>      hppa64-linux-ld: fs/ext4/super.o(.init.text+0x220): cannot reach=
 printk
>>>>      hppa64-linux-ld: fs/jbd2/journal.o(.init.text+0x164): cannot rea=
ch printk
>>>>      hppa64-linux-ld: fs/jbd2/journal.o(.init.text+0x1a4): cannot rea=
ch unknown
>>>>      hppa64-linux-ld: fs/xfs/xfs_super.o(.init.text+0x6ec): cannot re=
ach printk
>>>>      hppa64-linux-ld: fs/xfs/xfs_super.o(.init.text+0x8ac): cannot re=
ach wait_for_completion
>>>>      hppa64-linux-ld: fs/xfs/xfs_super.o(.init.text+0x934): cannot re=
ach unknown
>>>>      hppa64-linux-ld: fs/xfs/xfs_super.o(.init.text+0x944): cannot re=
ach unknown
>>>>      hppa64-linux-ld: security/keys/proc.o(.init.text+0x94): cannot r=
each panic
>>>>      hppa64-linux-ld: crypto/jitterentropy-kcapi.o(.init.text+0x38): =
cannot reach printk
>>>>      hppa64-linux-ld: block/bsg.o(.init.text+0x150): cannot reach pri=
ntk
>>>>      hppa64-linux-ld: lib/sg_pool.o(.init.text+0xa4): cannot reach pr=
intk
>>>>      hppa64-linux-ld: drivers/phy/phy-core.o(.init.text+0x64): cannot=
 reach printk
>>>>      hppa64-linux-ld: drivers/gpio/gpio-mockup.o(.init.text+0x2f4): c=
annot reach unknown
>>>>      hppa64-linux-ld: drivers/char/ipmi/ipmi_msghandler.o(.init.text+=
0x4c): cannot reach mutex_lock
>>>>
>>>> ---
>>>> 0-DAY CI Kernel Test Service, Intel Corporation
>>>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>>
>>>
>>>
>>
>
>

