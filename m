Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD8D3C7BDC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbhGNCfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:35:02 -0400
Received: from foss.arm.com ([217.140.110.172]:56010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237375AbhGNCfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:35:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08C9F1FB;
        Tue, 13 Jul 2021 19:32:11 -0700 (PDT)
Received: from [10.163.65.222] (unknown [10.163.65.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BED43F7D8;
        Tue, 13 Jul 2021 19:32:08 -0700 (PDT)
Subject: Re: [PATCH] arm64/kexec: Test page size support with new TGRAN range
 values
To:     kernel test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kbuild-all@lists.01.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
References: <1626058969-14847-1-git-send-email-anshuman.khandual@arm.com>
 <202107130013.N3v7eJq1-lkp@intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d8151a2c-d970-5930-e19f-75210b7e1d8a@arm.com>
Date:   Wed, 14 Jul 2021 08:02:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202107130013.N3v7eJq1-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/21 9:37 PM, kernel test robot wrote:
> Hi Anshuman,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on arm64/for-next/core]
> [also build test ERROR on arm/for-next soc/for-next kvmarm/next v5.14-rc1 next-20210712]
> [cannot apply to xlnx/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Anshuman-Khandual/arm64-kexec-Test-page-size-support-with-new-TGRAN-range-values/20210712-110329
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> config: arm64-buildonly-randconfig-r005-20210712 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/48b74d46210916db21b8f568b92f1771827bffe9
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Anshuman-Khandual/arm64-kexec-Test-page-size-support-with-new-TGRAN-range-values/20210712-110329
>         git checkout 48b74d46210916db21b8f568b92f1771827bffe9
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arch/arm64/kernel/head.S: Assembler messages:
>>> arch/arm64/kernel/head.S:705: Error: undefined symbol ID_AA64MMFR0_TGRAM64_SUPPORTED_MAX used as an immediate value

Needs a typo fix. Missed 64K build I guess, will fix it.

s/ID_AA64MMFR0_TGRAM64_SUPPORTED_MAX/ID_AA64MMFR0_TGRAN64_SUPPORTED_MAX
