Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2829D40C181
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 10:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbhIOIRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 04:17:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:1361 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229847AbhIOIRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 04:17:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="283253942"
X-IronPort-AV: E=Sophos;i="5.85,294,1624345200"; 
   d="scan'208";a="283253942"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 01:15:47 -0700
X-IronPort-AV: E=Sophos;i="5.85,294,1624345200"; 
   d="scan'208";a="508665608"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.174.86]) ([10.249.174.86])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 01:15:45 -0700
Subject: Re: [kbuild-all] Re: [mcgrof-next:20210908-firmware-builtin-v4 2/11]
 drivers/base/firmware_loader/builtin/main.c:36:6: error: no previous
 prototype for function 'firmware_is_builtin'
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Philip Li <philip.li@intel.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
References: <202109101524.pjY4q0Dy-lkp@intel.com>
 <YTv817Srt8hoySP5@bombadil.infradead.org> <20210911012853.GA834679@pl-dbox>
 <YT91dprXpGy+ywBu@bombadil.infradead.org>
 <YT96jYtYsWVjag8w@bombadil.infradead.org>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <cb65a64e-bb56-d02c-ae7e-ab9714e6d1f8@intel.com>
Date:   Wed, 15 Sep 2021 16:15:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YT96jYtYsWVjag8w@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/2021 12:21 AM, Luis Chamberlain wrote:
> On Mon, Sep 13, 2021 at 08:59:50AM -0700, Luis Chamberlain wrote:
>> On Sat, Sep 11, 2021 at 09:28:53AM +0800, Philip Li wrote:
>>> On Fri, Sep 10, 2021 at 05:48:23PM -0700, Luis Chamberlain wrote:
>>>> On Fri, Sep 10, 2021 at 03:41:31PM +0800, kernel test robot wrote:
>>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20210908-firmware-builtin-v4
>>>>> head:   1c69d6a17750179d68bcaf6b16f9a08d2e475989
>>>>> commit: 79e9fce20ee88ffe37542a66277628e6c53dde14 [2/11] firmware_loader: formalize built-in firmware API
>>>>> config: hexagon-buildonly-randconfig-r004-20210910 (attached as .config)
>>>>> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 261cbe98c38f8c1ee1a482fe76511110e790f58a)
>>>>> reproduce (this is a W=1 build):
>>>>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>>          chmod +x ~/bin/make.cross
>>>>>          # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=79e9fce20ee88ffe37542a66277628e6c53dde14
>>>>>          git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
>>>>>          git fetch --no-tags mcgrof-next 20210908-firmware-builtin-v4
>>>>>          git checkout 79e9fce20ee88ffe37542a66277628e6c53dde14
>>>>>          # save the attached .config to linux build tree
>>>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=hexagon
>>>>>
>>>>> If you fix the issue, kindly add following tag as appropriate
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>
>>>>> All errors (new ones prefixed by >>):
>>>>>
>>>>>>> drivers/base/firmware_loader/builtin/main.c:36:6: error: no previous prototype for function 'firmware_is_builtin' [-Werror,-Wmissing-prototypes]
>>>>>     bool firmware_is_builtin(const struct firmware *fw)
>>>>
>>>> This is a lie though its defined on drivers/base/firmware_loader/firmware.h
>>>>
>>>>>          ^
>>>>>     drivers/base/firmware_loader/builtin/main.c:36:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>>>>>     bool firmware_is_builtin(const struct firmware *fw)
>>>>>     ^
>>>>>     static
>>>>>     1 error generated.
>>>>
>>>> I get these odd errors:
>>>>
>>>> Compiler will be installed in /home/mcgrof/0day
>>> hi Luis, would you mind to download the make.cross tool again to give a try, it
>>> was updated recently to use latest clang instead of this 12.0.0?
>>
>> I had clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl and this was
>> used already. Is there a more recent one? Just in case I rm -rf'd it
>> and tried again with the latest make.cross.
> 
> I rm -rf ~/0day and tried again but the failure I get is:
> 
>    CALL    scripts/checksyscalls.sh
>    <stdin>:1515:2: warning: syscall clone3 not implemented [-W#warnings]
>    #warning syscall clone3 not implemented
> 
> Even if I disable CONFIG_WERROR and COMPILE_TEST this still fails here
> and so I can't even test compile the code in question.
> 
>    Luis

Hi Luis,

Sorry for the inconvenience, the error can be reproduced with W=1,
we'll update the reproduce step.

Best Regards,
Rong Chen
