Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807FD392977
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbhE0IYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:24:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:37972 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235359AbhE0IYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:24:53 -0400
IronPort-SDR: Lhi7fOBKCE7Zu6qrkAjKI53zu6LAETiA2EyJT6noTxi/ju0SfQReSgiLtLucNPrAT65AJwFJSe
 oHDE/KH9KO+Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="189799606"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="189799606"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 01:23:19 -0700
IronPort-SDR: 6Dbe1S41vi/PfqU5I9/mmPBexyuLn5xnamuBsUggtOZavmdxnAcz9zbcSQ8VReaaTGOg41WoPD
 zrfDMfkirZjg==
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="477387908"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 01:23:17 -0700
Subject: Re: [kbuild-all] Re: [PATCH v8 4/4] arm64: dts: mt8192: add spmi node
To:     Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        kernel test robot <lkp@intel.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1622025344-31888-5-git-send-email-hsin-hsiung.wang@mediatek.com>
 <202105270021.c336cIqx-lkp@intel.com> <1622081330.22138.0.camel@mtksdaap41>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <d9a87eca-ae28-8da4-d78e-ae2602201648@intel.com>
Date:   Thu, 27 May 2021 16:22:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1622081330.22138.0.camel@mtksdaap41>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Hsiung,

Thanks for the clarification, the bot can't parse the previous patchset 
from a link,
but can get the base from '--base' option in 
https://git-scm.com/docs/git-format-patch.

Best Regards,
Rong Chen

On 5/27/21 10:08 AM, Hsin-hsiung Wang wrote:
> Hi, Sirs
> Thanks for the review.
> This series is based on Chun-Jie's patches[1].
>
> [1]
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=488239
>
> On Thu, 2021-05-27 at 00:46 +0800, kernel test robot wrote:
>> Hi Hsin-Hsiung,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on robh/for-next]
>> [also build test ERROR on mediatek/for-next linus/master v5.13-rc3 next-20210526]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Hsin-Hsiung-Wang/Add-SPMI-support-for-Mediatek-MT6873-8192-SoC-IC/20210526-183803
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
>> config: arm64-randconfig-r016-20210526 (attached as .config)
>> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 99155e913e9bad5f7f8a247f8bb3a3ff3da74af1)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install arm64 cross compiling tool for clang build
>>          # apt-get install binutils-aarch64-linux-gnu
>>          # https://github.com/0day-ci/linux/commit/423b4a1660f5157dbac566f9c498c61927f09022
>>          git remote add linux-review https://github.com/0day-ci/linux
>>          git fetch --no-tags linux-review Hsin-Hsiung-Wang/Add-SPMI-support-for-Mediatek-MT6873-8192-SoC-IC/20210526-183803
>>          git checkout 423b4a1660f5157dbac566f9c498c61927f09022
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> Error: arch/arm64/boot/dts/mediatek/mt8192.dtsi:299.24-25 syntax error
>>     FATAL ERROR: Unable to parse input tree
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

