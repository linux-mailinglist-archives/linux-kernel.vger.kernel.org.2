Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128523F134A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 08:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhHSGWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 02:22:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:51553 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhHSGWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 02:22:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="216524205"
X-IronPort-AV: E=Sophos;i="5.84,334,1620716400"; 
   d="scan'208";a="216524205"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 23:22:18 -0700
X-IronPort-AV: E=Sophos;i="5.84,334,1620716400"; 
   d="scan'208";a="522196075"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.170.111]) ([10.249.170.111])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 23:22:15 -0700
Subject: Re: [kbuild-all] Re: [driver-core:driver-core-testing 28/31] WARNING:
 modpost: vmlinux.o(.text.unlikely+0x156c): Section mismatch in reference from
 the function bitmap_equal() to the variable .init.data:initcall_level_names
To:     Barry Song <21cnbao@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <202108141955.XlQXw3y4-lkp@intel.com> <YRfGfcwxFR0L/e77@kroah.com>
 <CAHp75VdzjsqnwprykT8phofnkUit8087Tz87YuhaZ8dAuExaqQ@mail.gmail.com>
 <CAGsJ_4wzoSLpaPzgQh5k-zwbJEBgN3ckM_MpGz-72ayCeT6aMQ@mail.gmail.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <2f334887-5cc4-87ce-6eaa-61afc8c1265a@intel.com>
Date:   Thu, 19 Aug 2021 14:22:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAGsJ_4wzoSLpaPzgQh5k-zwbJEBgN3ckM_MpGz-72ayCeT6aMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/2021 8:04 AM, Barry Song wrote:
> On Sun, Aug 15, 2021 at 5:18 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>>
>> On Sat, Aug 14, 2021 at 4:36 PM Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>> On Sat, Aug 14, 2021 at 07:03:00PM +0800, kernel test robot wrote:
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-testing
>>>> head:   3b35f2a6a625126c57475aa56b5357d8e80b404c
>>>> commit: 291f93ca339f5b5e6e90ad037bb8271f0f618165 [28/31] lib: test_bitmap: add bitmap_print_bitmask/list_to_buf test cases
>>>> config: xtensa-randconfig-r004-20210814 (attached as .config)
>>>> compiler: xtensa-linux-gcc (GCC) 11.2.0
>>>> reproduce (this is a W=1 build):
>>>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>          chmod +x ~/bin/make.cross
>>>>          # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?id=291f93ca339f5b5e6e90ad037bb8271f0f618165
>>>>          git remote add driver-core https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
>>>>          git fetch --no-tags driver-core driver-core-testing
>>>>          git checkout 291f93ca339f5b5e6e90ad037bb8271f0f618165
>>>>          # save the attached .config to linux build tree
>>>>          mkdir build_dir
>>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash
>>>>
>>>> If you fix the issue, kindly add following tag as appropriate
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>>>>
>>>>>> WARNING: modpost: vmlinux.o(.text.unlikely+0x156c): Section mismatch in reference from the function bitmap_equal() to the variable .init.data:initcall_level_names
>>>> The function bitmap_equal() references
>>>> the variable __initdata initcall_level_names.
>>>> This is often because bitmap_equal lacks a __initdata
>>>> annotation or the annotation of initcall_level_names is wrong.
>>>>
>>>> The below error/warnings are from parent commit:
>>>> << WARNING: modpost: vmlinux.o(.data+0x1a86d8): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:__setup_str_initcall_blacklist
>>>> << WARNING: modpost: vmlinux.o(.data+0x1a87c8): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:__setup_str_initcall_blacklist
>>>> << WARNING: modpost: vmlinux.o(.data+0x1a8948): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:__setup_str_initcall_blacklist
>>
>>> Barry, can I get a fix for this?
>>
>> Max already pointed out, but I guess you were not in Cc list, that
>> it's a GCC bug in his opinion, but GCC people don't ack it.
>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=92938
> 
> I really don't understand what is going on here. My understanding is
> this report has nothing to do with the
> new commit and it doesn't report any valid place where kernel code is wrong.

Hi Barry,

Sorry for the misunderstanding, the warning only changed a little by 
this commit, see:

 >>>> The below error/warnings are from parent commit:
 >>>> << WARNING: modpost: vmlinux.o(.data+0x1a86d8): Section mismatch 
in reference from the variable qed_mfw_legacy_maps to the variable 
.init.rodata:__setup_str_initcall_blacklist
 >>>> << WARNING: modpost: vmlinux.o(.data+0x1a87c8): Section mismatch 
in reference from the variable qed_mfw_ext_maps to the variable 
.init.rodata:__setup_str_initcall_blacklist
 >>>> << WARNING: modpost: vmlinux.o(.data+0x1a8948): Section mismatch 
in reference from the variable qede_forced_speed_maps to the variable 
.init.rodata:__setup_str_initcall_blacklist

we'll update the message to give a heavy hint.

Best Regards,
Rong Chen

> 
> with xtensa gcc 11.1 which is the one i can easily download from here
> after google:
> http://kernel.c3sl.ufpr.br/pub/tools/crosstool/
> 
> i could somehow reproduce this kind of very odd section mismatch
> report from bitmap:
> $ ./build-xenta.sh
>    ...
>    MODPOST vmlinux.symvers
> WARNING: modpost: vmlinux.o(.text.unlikely+0x4d64): Section mismatch
> in reference from the function bitmap_equal() to the variable
> .init.rodata:__setup_str_initcall_blacklist
> The function bitmap_equal() references
> the variable __initconst __setup_str_initcall_blacklist.
> This is often because bitmap_equal lacks a __initconst
> annotation or the annotation of __setup_str_initcall_blacklist is wrong.
> 
> ...
> WARNING: modpost: lib/find_bit_benchmark.o(.text.unlikely+0x0):
> Section mismatch in reference from the (unknown reference) (unknown)
> to the variable .init.data:bitmap2
> The function (unknown)() references
> the variable __initdata bitmap2.
> This is often because (unknown) lacks a __initdata
> annotation or the annotation of bitmap2 is wrong.
> ...
> 
> But after reverting my commit, it is *still* there:
> 
> $ git revert 2069b8b9ce8b758e015ce49225b1fedac4accd9c
> [scheduler e158c85c6ccc] Revert "lib: test_bitmap: add
> bitmap_print_bitmask/list_to_buf test cases"
>   1 file changed, 150 deletions(-)
> 
> $ ./build-xenta.sh
> ...
>    MODPOST vmlinux.symvers
> WARNING: modpost: vmlinux.o(.text.unlikely+0x4d64): Section mismatch
> in reference from the function bitmap_equal() to the variable
> .init.rodata:__setup_str_initcall_blacklist
> The function bitmap_equal() references
> the variable __initconst __setup_str_initcall_blacklist.
> This is often because bitmap_equal lacks a __initconst
> annotation or the annotation of __setup_str_initcall_blacklist is wrong.
> ...
> WARNING: modpost: lib/find_bit_benchmark.o(.text.unlikely+0x0):
> Section mismatch in reference from the (unknown reference) (unknown)
> to the variable .init.data:bitmap2
> The function (unknown)() references
> the variable __initdata bitmap2.
> This is often because (unknown) lacks a __initdata
> annotation or the annotation of bitmap2 is wrong.
> 
>    Kernel: arch/xtensa/boot/boot-elf/../Image.elf is ready
>    GEN     Module.symvers
> 
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
> 
> Thanks
> Barry
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
