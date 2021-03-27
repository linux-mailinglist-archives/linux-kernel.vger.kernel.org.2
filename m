Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E0B34B3A7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 02:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhC0B5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 21:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhC0B4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 21:56:34 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCF1C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 18:56:34 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id h3so6016167pfr.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 18:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=faYFDe+Adytg87HgOtz6HNNmF/jVigxYTlJk0XlAIQ0=;
        b=DwrU03JJgXDLNXV9CeSQFMYZg9ID2Gwy+ks485GC+5Zp755Y4XJSnYDr1AMi+gQ3f8
         0nz/Dr9OSBGKntXMhgp/VgCZxEC12QDkH+CJieeYimiH9GmzU8fe8J6cNjl9DJDxmldM
         7RDlELGLVFRbXag5mjhmYnpFgpfrn8iIJXhAKC2liQdYD+aowGiw/u/sicBfSYR9gtQv
         /sVHiFQ8CQEHTA/7OK8a0VkrEczfpDC+ajlBZCKR8K094T6kZA8quuBaKF4ErrW901oE
         kHq99erSohY37QeM8nwwfK3U/Ag+JEkArjZO+lTNFzNiG2Ap3ms1bQEu2LLote727LYi
         zWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=faYFDe+Adytg87HgOtz6HNNmF/jVigxYTlJk0XlAIQ0=;
        b=tVaEMGghaBm9GF+aiHya0F3QY8S5UKHGcPrXeYKB5Ka9nwGeloIia+SxTGnQhTT6ii
         6tmq6RiDcCNgp4apLlE0+amnoXMXQ5H/8pCfCWW5DhXHVyn7gAo+RZfQK/eZcV40KLBl
         sN/xA+/Pfutekud9/zz5V5MFCyBg1xl2SiRrMGq9zyQlYaeFEvlG+crsDtolzfo2K07V
         BhAYi8OG7HmVRmFMGSHBs2turu+DMD9Q3fF0LqlT7UJsDr01pZyTQk99fY9Nz30BdaqJ
         LvSIj4v8g4MJNRZeen4kIST0PpGDbg3cEJNrIfrnRRW6Gvips/Q4Bn97NDtjR7eI2fch
         TLWA==
X-Gm-Message-State: AOAM53106GmAaEN/QPygyocXbpgfgDp/e4rQYNoPNJ2AOS0FASEyu32a
        X4X17/8dS6bNrl5iV6E/4bkZILehUq6U0A==
X-Google-Smtp-Source: ABdhPJwQwT+cQCgAMJ2LQ1829fA4S6VlDz+F2P8G7mPGEAWyzQ40N2eIjXfzdDIs53RaBR5Vek19Hg==
X-Received: by 2002:a62:d414:0:b029:217:24b8:a5b9 with SMTP id a20-20020a62d4140000b029021724b8a5b9mr16044288pfh.41.1616810193297;
        Fri, 26 Mar 2021 18:56:33 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:5dbf:19de:725b:1861])
        by smtp.gmail.com with ESMTPSA id 22sm9722499pjl.31.2021.03.26.18.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 18:56:32 -0700 (PDT)
Date:   Fri, 26 Mar 2021 18:56:29 -0700
From:   Fangrui Song <maskray@google.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Use $(LD) instead of $(CC) to link vDSO
Message-ID: <20210327015629.eecu77zvm4iri657@google.com>
References: <20210325215156.1986901-1-nathan@kernel.org>
 <202103262325.9ejJuOqf-lkp@intel.com>
 <20210326235839.zgfvmtfxrb3hy6i4@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210326235839.zgfvmtfxrb3hy6i4@archlinux-ax161>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021-03-26, Nathan Chancellor wrote:
>On Sat, Mar 27, 2021 at 12:05:34AM +0800, kernel test robot wrote:
>> Hi Nathan,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on linus/master]
>> [also build test ERROR on v5.12-rc4 next-20210326]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Nathan-Chancellor/riscv-Use-LD-instead-of-CC-to-link-vDSO/20210326-055421
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 002322402dafd846c424ffa9240a937f49b48c42
>> config: riscv-randconfig-r032-20210326 (attached as .config)
>> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project f490a5969bd52c8a48586f134ff8f02ccbb295b3)
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # install riscv cross compiling tool for clang build
>>         # apt-get install binutils-riscv64-linux-gnu
>>         # https://github.com/0day-ci/linux/commit/dfdcaf93f40f0d15ffc3f25128442c1688e612d6
>>         git remote add linux-review https://github.com/0day-ci/linux
>>         git fetch --no-tags linux-review Nathan-Chancellor/riscv-Use-LD-instead-of-CC-to-link-vDSO/20210326-055421
>>         git checkout dfdcaf93f40f0d15ffc3f25128442c1688e612d6
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv
>
>For the record, I tried to use this script to reproduce but it has a
>couple of bugs:
>
>1. It does not download the right version of clang. This report says
>that it is clang-13 but the one that the script downloaded is clang-12.
>
>2. It does not download it to the right location. The script expects
>~/0day/clang-latest but it is downloaded to ~/0day/clang it seems. I
>symlinked it to get around it.
>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>> >> riscv64-linux-gnu-objcopy: 'arch/riscv/kernel/vdso/vdso.so.dbg': No such file
>
>This error only occurs because of errors before it that are not shown
>due to a denylist:
>
>ld.lld: error: arch/riscv/kernel/vdso/rt_sigreturn.o:(.text+0x0): relocation R_RISCV_ALIGN requires unimplemented linker relaxation; recompile with -mno-relax
>ld.lld: error: arch/riscv/kernel/vdso/getcpu.o:(.text+0x0): relocation R_RISCV_ALIGN requires unimplemented linker relaxation; recompile with -mno-relax
>ld.lld: error: arch/riscv/kernel/vdso/flush_icache.o:(.text+0x0): relocation R_RISCV_ALIGN requires unimplemented linker relaxation; recompile with -mno-relax
>
>My patch only adds another occurrence of this error because we move from
>$(CC)'s default linker (in clang's case, ld.bfd) to $(LD), which in the
>case of 0day appears to be ld.lld. ld.lld should not be used with RISC-V
>in its current form due to errors of this nature, which happen without
>my patch as well:
>
>https://github.com/ClangBuiltLinux/linux/issues/1020
>
>Linker relaxation in ld.lld for RISC-V is an ongoing debate/process.
>Please give RISC-V the current treatment as s390 with ld.lld for the
>time being to get meaningful reports. We will reach out once that issue
>has been resolved.

>TL;DR: Patch exposes existing issue with LD=ld.lld that would have
>happened without it in different areas, the report can be ignored.

Yes, lkp frequently reports this error. It can be suppressed by using
-mno-relax... if ld.lld is picked.

Hmm. This motivated me to file
https://github.com/riscv/riscv-elf-psabi-doc/issues/183
R_RISCV_ALIGN friendly to linkers not supporting relaxation (riscv_relax_delete_bytes).

>Cheers!
>Nathan
>
>-- 
>You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
>To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
>To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210326235839.zgfvmtfxrb3hy6i4%40archlinux-ax161.
