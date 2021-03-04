Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9787032C982
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453215AbhCDBHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:07:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:7525 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1387983AbhCDA4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:56:08 -0500
IronPort-SDR: Lb90IAeWt+xlCYeDEQrYTUo58WPnd/cTykHEGEl/keqhx9M/DH7Tu9I9rFFH6AsE+xb8x5xs4E
 BpPGpD4i2ORw==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="174429218"
X-IronPort-AV: E=Sophos;i="5.81,221,1610438400"; 
   d="scan'208";a="174429218"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 16:51:51 -0800
IronPort-SDR: I2X4uxUlLiP/qzBmatJaeum5L1yPq6ARmdFneTWBMImvMy0V6gEB+zwpwGtWHZVMyPng99cy84
 00b3rhGOImTg==
X-IronPort-AV: E=Sophos;i="5.81,221,1610438400"; 
   d="scan'208";a="407478569"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 16:51:49 -0800
Subject: Re: [kbuild-all] Re: COPYING CREDITS Documentation Kbuild Kconfig
 LICENSES MAINTAINERS Makefile README arch block certs crypto drivers fs
 include init ipc kernel lib mm net samples scripts security sound tools usr
 virt No rule to make target 'arch/c6x/Makefile'.
To:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <202103040304.DTElvlrq-lkp@intel.com>
 <CAK8P3a3x+JnCDVsNpCn0sSChXG41hCKmQMVAOuiLovGJSStUgA@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <6afc4b44-58fb-414b-b7c0-53959cc19c9b@intel.com>
Date:   Thu, 4 Mar 2021 08:51:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3x+JnCDVsNpCn0sSChXG41hCKmQMVAOuiLovGJSStUgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/4/21 4:07 AM, Arnd Bergmann wrote:
> On Wed, Mar 3, 2021 at 8:44 PM kernel test robot <lkp@intel.com> wrote:
>> Hi Arnd,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   f69d02e37a85645aa90d18cacfff36dba370f797
>> commit: a579fcfa8e49cc77ad59211bb18bc5004133e6a0 c6x: remove architecture
>> date:   6 weeks ago
>> config: c6x-randconfig-r026-20210303 (attached as .config)
>> compiler: c6x-elf-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a579fcfa8e49cc77ad59211bb18bc5004133e6a0
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout a579fcfa8e49cc77ad59211bb18bc5004133e6a0
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=c6x
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     Makefile:681: arch/c6x/Makefile: No such file or directory
> Yes, arch/c6x is gone and unlikely to return. Please fix the 0day scripts
> to no longer build it on v5.12-rc1 or higher.

Hi Arnd,

Thanks for the warning, we have removed the related tests.

Best Regards,
Rong Chen

>          Arnd
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

