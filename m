Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4C33CCFC9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 11:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbhGSIUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 04:20:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:20313 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235739AbhGSIUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:20:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10049"; a="296580522"
X-IronPort-AV: E=Sophos;i="5.84,251,1620716400"; 
   d="scan'208";a="296580522"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 02:00:55 -0700
X-IronPort-AV: E=Sophos;i="5.84,251,1620716400"; 
   d="scan'208";a="468354684"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 02:00:53 -0700
Subject: drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c:503:11: warning:
 %d in format string (no. 1) requires 'int' but the argument type is 'unsigned
 int'. [invalidPrintfArgType_sint]
References: <202107191125.de9s3IPs-lkp@intel.com>
To:     Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Cc:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Huang Rui <ray.huang@amd.com>
From:   kernel test robot <rong.a.chen@intel.com>
X-Forwarded-Message-Id: <202107191125.de9s3IPs-lkp@intel.com>
Message-ID: <ca53efc5-45b7-2042-d7c9-390a84b88f57@intel.com>
Date:   Mon, 19 Jul 2021 17:00:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202107191125.de9s3IPs-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
master
head: 2734d6c1b1a089fb593ef6a23d4b70903526fe0c
commit: bd8dcea93a7d45a3366b5f3e6c341a677ff90acf drm/amd/pm: add 
callbacks to read/write sysfs file pp_power_profile_mode
date: 6 weeks ago
compiler: ia64-linux-gcc (GCC) 10.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
In file included from 
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/yellow_carp_ppt.c:
>> drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c:503:11: warning: 
>> %d in format string (no. 1) requires 'int' but the argument type is 
>> 'unsigned int'. [invalidPrintfArgType_sint]
size += sprintf(buf + size, "%2d %14s%sn",
^

vim +503 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c

4cea0fc9816add7 Xiaomeng Hou 2021-02-09 473 bd8dcea93a7d45a Xiaomeng Hou 
2021-03-29 474 static int yellow_carp_get_power_profile_mode(struct 
smu_context *smu,
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 475 char *buf)
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 476 {
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 477 static const char 
*profile_name[] = {
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 478 "BOOTUP_DEFAULT",
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 479 "3D_FULL_SCREEN",
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 480 "POWER_SAVING",
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 481 "VIDEO",
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 482 "VR",
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 483 "COMPUTE",
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 484 "CUSTOM"};
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 485 uint32_t i, size = 0;
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 486 int16_t workload_type = 0;
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 487 bd8dcea93a7d45a Xiaomeng Hou 
2021-03-29 488 if (!buf)
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 489 return -EINVAL;
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 490 bd8dcea93a7d45a Xiaomeng Hou 
2021-03-29 491 for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 492 /*
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 493 * Conv PP_SMC_POWER_PROFILE* 
to WORKLOAD_PPLIB_*_BIT.
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 494 * Not all profile modes are 
supported on yellow carp.
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 495 */
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 496 workload_type = 
smu_cmn_to_asic_specific_index(smu,
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 497 CMN2ASIC_MAPPING_WORKLOAD,
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 498 i);
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 499 bd8dcea93a7d45a Xiaomeng Hou 
2021-03-29 500 if (workload_type < 0)
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 501 continue;
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 502 bd8dcea93a7d45a Xiaomeng Hou 
2021-03-29 @503 size += sprintf(buf + size, "%2d %14s%s\n",
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 504 i, profile_name[i], (i == 
smu->power_profile_mode) ? "*" : " ");
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 505 }
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 506 bd8dcea93a7d45a Xiaomeng Hou 
2021-03-29 507 return size;
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 508 }
bd8dcea93a7d45a Xiaomeng Hou 2021-03-29 509
---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
