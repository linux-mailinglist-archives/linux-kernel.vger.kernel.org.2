Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FEA3FB2A8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 10:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhH3IoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 04:44:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:13639 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235000AbhH3IoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 04:44:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10091"; a="303812364"
X-IronPort-AV: E=Sophos;i="5.84,363,1620716400"; 
   d="gz'50?scan'50,208,50";a="303812364"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 01:43:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,362,1620716400"; 
   d="gz'50?scan'50,208,50";a="644915575"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 30 Aug 2021 01:43:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 30 Aug 2021 01:43:01 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 30 Aug 2021 01:43:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 30 Aug 2021 01:43:01 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 30 Aug 2021 01:43:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHKz4h7fTb60JwgaChk4sUpMGE9mj2xiFsgK2fR/Nk8WusQoi/b96FQ9Qe3r0OVW+rY/kkH0z44gRaYTwzTIOqdYMJx83UEDEdcZBM2oU+VqrG4a1VzeUSZgLVaBBuv5NhWIIi70UbTHYGS+OXtwST1ZAFFFxo1a+jjacQdUjF7+PFWmLw8hAFZM7J2crg3UOiC2PxvHbbY1m1xJEbqkV3SCMNlxsuqANDsf4x41hByYYpDAvEx02xwUzSk46c1sI6PUEt73+arf0PxTHuToUbE0twO+aGEuVVzlmATCExHMWDiP66V1YPejCecGddUciF8gCBbzHlEbvYYLq83kyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aTrneFuJa0hmK3nWsC9L8DIck0c6eE1PtByzEfMytE=;
 b=n3AVgTAGLvOHhAC4TUWgdPzSzDuxxPKP2UrSDdZhxsaKofSvrr8OFRhpmoq4BLgVMzEHNkIbAV59VhJNgV1gRXulhlxnZGTH5ZL+m85WHwuPWGd1814cuEvDEMkWtaVdOOYqCOuQGKU/7yFk/sMT+mCYeiSes25yH5bTLm4iYexMnZPr5DQQB+coz2w2R1haki/DmQ5VDLpXDT2P2oaZKndFKOdeYMFhBb8+vWRKUwuCS/anjCjvn4QlyQBKSscZ5/34iAeQi1yFyDsUqzEWTfr8f+6jp1p5TPNFKbrMmdp8VvjsbepliC9gnBGz+qF3N6ftdsnHOWtVs5fbpK/Srw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aTrneFuJa0hmK3nWsC9L8DIck0c6eE1PtByzEfMytE=;
 b=TcAZDxC7tRa0tsuVyZSK7lqNOEJUyTIayHevsPzeciEmMR5jgrjE8u31jSN/sNop/T4qzuBo5FchapHTXYuR+U6EC+7xTUpLcMCH4WKMTQMn59gGA1NAUvE9nbYN+V+w6fjFOBwfl/Veolpkqd2sC/GdhY1Sq7fK8GtlV4+KsTw=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5647.namprd11.prod.outlook.com (2603:10b6:a03:3af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 08:42:55 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::6d71:2479:2bf5:de7f]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::6d71:2479:2bf5:de7f%7]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 08:42:54 +0000
Content-Type: multipart/mixed; boundary="------------v4r0SmfRqnrwI3cCadHSwhl0"
Message-ID: <e89de0a6-a4a2-f4c4-6a09-59052ed73cb4@intel.com>
Date:   Mon, 30 Aug 2021 16:42:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.0.3
Subject: drivers/mtd/nand/raw/intel-nand-controller.c:205:24: warning:
 Division by zero [clang-analyzer-core.DivideZero]
References: <202108281724.njFvkgI7-lkp@intel.com>
Content-Language: en-US
From:   kernel test robot <yujie.liu@intel.com>
To:     Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
In-Reply-To: <202108281724.njFvkgI7-lkp@intel.com>
X-Forwarded-Message-Id: <202108281724.njFvkgI7-lkp@intel.com>
X-ClientProxiedBy: HK2PR0401CA0015.apcprd04.prod.outlook.com
 (2603:1096:202:2::25) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.238.2.112] (192.198.142.21) by HK2PR0401CA0015.apcprd04.prod.outlook.com (2603:1096:202:2::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 08:42:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e542e844-c23e-4573-d8da-08d96b9228e4
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5647:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5647513D7E6F536394B4A6B8FBCB9@SJ0PR11MB5647.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:419;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1Hdo8xNv9NkP7tveX9461jX58t8sCyC2/cLIqPj48/yUu0ybfHpnq4AasxnglPRnAfe5CV7L3YsWAupyqNKR6FAy5A9UHdSiQ+7N1O6CcwVy/tTAPUcWPhvr0MDeD8n4lpnRztq3JVrccgY5mpop00TRTo1dvzd9hN5HkYLQtvi+FlSFle9Z9p0xzS8PtVTV4W5+gDP4ftz3HE19pmXeEaEP1Tpd6OICq4mp8r/BxS3XbnnY2d1UgDYKy5uaXUzcRze3+YnNpr0bvmOUAcvInzMk/5BtMEe9CuwuRK0gfiVaOr9RwuK0Y9M3Vud2lDvE/Ra/Pofwi6lU0vPvhR7tWdOTNOUoswqF+az30lLpOd0ySbO1fNTlFybjkJFvQapAD40GvhoubHq28NszXSI/Fa/cz2WulPn/65SVgU+zZ+9S8h21gAHsGEyoPMLsb/PtM7/uYYA73qyawSV5NbvLFmrIg8Fk4MwhCT8cZDKZXDDOdGYc+jadsxOkjH2qRLODKvD9aZsIS+PPCnBWqlPh4gvTwS9aUH7vbZBH0u1Z70QpV7hQYKAA6DzJDxDHZHwEsoEYwEFS16c3e9FRpSFVJTGZaTBR8zFIFGo4bo1T4fVQHXFcUwFGJ6Fp4d8xA44DafgghtECdsm2+OX+kjklN9iZHjViHb83M6zwZDJ1kG4IB1OYLpCB4gm1eDYS/HJVvf5BtzI/6S4EmO/oBptbBXI75a9/TcilUZjPjHG5fKCjBqavTlVj2k5CsrrZtGnSKkvF0RkjO5U2QbbFaAjQVlwKrwOji1rh3/HSGAED/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(33964004)(316002)(16576012)(26005)(6666004)(38100700002)(83380400001)(478600001)(8936002)(2906002)(4326008)(5660300002)(54906003)(235185007)(956004)(2616005)(6916009)(6486002)(4001150100001)(66476007)(66946007)(66556008)(66616009)(966005)(186003)(31686004)(86362001)(8676002)(36756003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXJBTFRMNmc3ejV0MldjSmhvYVU4bURFTkRROTJ5SDRHZjdKMUFqRkZMbDh3?=
 =?utf-8?B?QzBFVU9IVzZOSWs1MzVvb3RZT2U2OXBjRm9WTWxYRzRUUUNYQmVGUTl2ZFU0?=
 =?utf-8?B?VmNabTA0dkZRMVRmMWsvWVhOeVlKQTZCalh1TVNoUTJPUXAxeGVuRnVyQklD?=
 =?utf-8?B?dDRraDR3aHVhUmlZL0RBaFNETVRmZE5NMDFqN0c4YUdUK2l4aVhoV0xEZjBY?=
 =?utf-8?B?T2ZuajRPNVBicGVEV2J0Z3JDc3Q3OWZIQWNYMk1kakpONnY1Mlhwd0ovbDJ4?=
 =?utf-8?B?ZmU1WG5CQ0lmWGxFRExUMCtlRXdaNFlqOFVuR0hMaGhONzRDZWVpRXhidlE3?=
 =?utf-8?B?MUhOUzFxV0R4MDNibzB5dFh2RjJIYlczL211TnlOZFRLN3VJdW5ZZmxwQzEy?=
 =?utf-8?B?K3I4dDNCQ0F4aEFsQWlwY3Z1VDlCWXc5cFZTdHdGRmh5aDlFN3VkMWFRdzdl?=
 =?utf-8?B?M1dLWUZ2U3ExYUhKazJ4KzVIRWRnY2ZBaGZtaVdDNkxxRWN4RmZmcHdpS2o2?=
 =?utf-8?B?QzZ5NlpiSlgraHM5Z0F4a2tQdGMxd3pOOEJldGxVOEQxWHBkUm5PdVM0NnRv?=
 =?utf-8?B?bWF4MjhFRWl2bThFbzNsT09FbWRFZmt4R2VyVjljQ0VtTVE4dC9nYUxDQU05?=
 =?utf-8?B?VCtOakUvVzZHNjJBNjRvNitsMEZSY082Z0NISHQwOVdNOWd2UkRPWmV3WUZO?=
 =?utf-8?B?SEZnN3FIa29KWk9yMytuTkpLRmdXQXFPUENOQ25KdHRITG1XL0llNWJhaEN3?=
 =?utf-8?B?QWYyTWR2bGJPMmxvZFVtSjJmY3k3cWtYeW5zc2xoTHNxdFpUQWRmTSs3T2pU?=
 =?utf-8?B?MzRMTFhqVzlTTzBRamYyVVNQUU1vQXJDa1BVQ2t1UmluYlBHN1FkMkxUNjRl?=
 =?utf-8?B?R255ZzJMVUxwNWEyZEwzWGpSMm9RSkdWRUxXbHpka3Azb3FEWEFnNlVBdTg2?=
 =?utf-8?B?WVhZVzE2L0o5RW9HYVlhSFdaRWtYcURPTWl3QU1vZm5uY29nWVpuaG5XWGth?=
 =?utf-8?B?a0lBTmNBSjBpVnl4N3JVbmMyNFRVNHA2UFVLTkJBK2tUT3pIcWUzeHZOOFM3?=
 =?utf-8?B?a3lZbXVoTzJkSW1VRm1XMHRMS1Y2aWwwRSs4bWE1QVM5cUpYN0tDY3U4NGNu?=
 =?utf-8?B?N0R5RTJBem5HMkNydmdXQjdSTCtLTE1XMHd2NHYxbDhlQ1FScGtWWXM4eFVk?=
 =?utf-8?B?RjNDSnpFQVdUdUFiZkVQQW5qeVBtZFJZR2dWNWVvN2pJS010Ky9RNXREc3JB?=
 =?utf-8?B?TnJzemdSNDhWVm5KMmxOYzNneFU3Nm91ZExZZVFScTZWTXVTanQ4YWtrSy80?=
 =?utf-8?B?QityanVwelMzRmJ0SGJwZVBCODBIOVE4WUtodEtvMlB3STdEQ1dtbzB4Um81?=
 =?utf-8?B?L2ROWWd1eWo2ODZNalZFTTZreEZXaW00bDhnS2phZHRDbXk2alQvYTlEaTN1?=
 =?utf-8?B?Zy9SVjJlcGovVGVUQUdFbEhIbHlxMHhYNTdUQndZdGtqNjVuUDJLdTNBbzkw?=
 =?utf-8?B?QTl4bHY2UXozTGJVUmo2d2FBS2FRN09uZE1BNnVJZWdwT2xUbTFWckhJS2Zo?=
 =?utf-8?B?ZGxBU1cyWmYrVERwUGR6L1N2cHpsaUo0dzVlKzR3dU1wMituMEpCZGhTYXRt?=
 =?utf-8?B?U2ovcEZBOXY4QWNmclNGZTZzczd3ZlFkUTRFbm9qS0MxSURicXdSa3BNc0ZY?=
 =?utf-8?B?M0Z2bjl0UnA4OXdtNG1remh2NTlTejRhMUM4elcvakRVaGhTa2FwN3JMSEFE?=
 =?utf-8?Q?OMeM8YmCrFJrK8lccrLV4S49EVsxk/BmSypwIUq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e542e844-c23e-4573-d8da-08d96b9228e4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 08:42:54.8195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Je9SSLPfv2k1I4pOj+ihkHuIiGDWgHqjEmi6oGvdOEo2MOe+uoXStmvvW9l6VCHIDuL8qBZGfE0Tn3+gw/ggFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5647
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------v4r0SmfRqnrwI3cCadHSwhl0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   64b4fc45bea6f4faa843d2f97ff51665280efee1
commit: 0b1039f016e8a37c779a4aee362cb2100ebb1cfd mtd: rawnand: Add NAND controller support on Intel LGM SoC
date:   9 months ago
:::::: branch date: 11 hours ago
:::::: commit date: 9 months ago
config: powerpc-randconfig-c003-20210827 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project ea08c4cd1c0869ec5024a8bb3f5cdf06ab03ae83)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # install powerpc cross compiling tool for clang build
         # apt-get install binutils-powerpc64-linux-gnu
         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0b1039f016e8a37c779a4aee362cb2100ebb1cfd
         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
         git fetch --no-tags linus master
         git checkout 0b1039f016e8a37c779a4aee362cb2100ebb1cfd
         # save the attached .config to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> drivers/mtd/nand/raw/intel-nand-controller.c:205:24: warning: Division by zero [clang-analyzer-core.DivideZero]
            unsigned int period = DIV_ROUND_UP(USEC_PER_SEC, rate);
                                  ^
    include/linux/kernel.h:85:22: note: expanded from macro 'DIV_ROUND_UP'
    #define DIV_ROUND_UP __KERNEL_DIV_ROUND_UP
                         ^
    include/uapi/linux/kernel.h:13:54: note: expanded from macro '__KERNEL_DIV_ROUND_UP'
    #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
                                         ~~~~~~~~~~~~~~~~^~~~~
    drivers/mtd/nand/raw/intel-nand-controller.c:204:22: note: Calling 'clk_get_rate'
            unsigned int rate = clk_get_rate(ctrl->clk) / HZ_PER_MHZ;
                                ^~~~~~~~~~~~~~~~~~~~~~~
    include/linux/clk.h:842:2: note: Returning zero
            return 0;
            ^~~~~~~~
    drivers/mtd/nand/raw/intel-nand-controller.c:204:22: note: Returning from 'clk_get_rate'
            unsigned int rate = clk_get_rate(ctrl->clk) / HZ_PER_MHZ;
                                ^~~~~~~~~~~~~~~~~~~~~~~
    drivers/mtd/nand/raw/intel-nand-controller.c:204:2: note: 'rate' initialized to 0
            unsigned int rate = clk_get_rate(ctrl->clk) / HZ_PER_MHZ;
            ^~~~~~~~~~~~~~~~~
    drivers/mtd/nand/raw/intel-nand-controller.c:205:24: note: Division by zero
            unsigned int period = DIV_ROUND_UP(USEC_PER_SEC, rate);
                                  ^


vim +205 drivers/mtd/nand/raw/intel-nand-controller.c

0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  199
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  200  static int ebu_nand_set_timings(struct nand_chip *chip, int csline,
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  201  				const struct nand_interface_config *conf)
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  202  {
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  203  	struct ebu_nand_controller *ctrl = nand_to_ebu(chip);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  204  	unsigned int rate = clk_get_rate(ctrl->clk) / HZ_PER_MHZ;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10 @205  	unsigned int period = DIV_ROUND_UP(USEC_PER_SEC, rate);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  206  	const struct nand_sdr_timings *timings;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  207  	u32 trecov, thold, twrwait, trdwait;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  208  	u32 reg = 0;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  209
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  210  	timings = nand_get_sdr_timings(conf);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  211  	if (IS_ERR(timings))
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  212  		return PTR_ERR(timings);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  213
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  214  	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  215  		return 0;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  216
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  217  	trecov = DIV_ROUND_UP(max(timings->tREA_max, timings->tREH_min),
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  218  			      period);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  219  	reg |= EBU_BUSCON_RECOVC(trecov);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  220
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  221  	thold = DIV_ROUND_UP(max(timings->tDH_min, timings->tDS_min), period);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  222  	reg |= EBU_BUSCON_HOLDC(thold);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  223
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  224  	trdwait = DIV_ROUND_UP(max(timings->tRC_min, timings->tREH_min),
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  225  			       period);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  226  	reg |= EBU_BUSCON_WAITRDC(trdwait);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  227
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  228  	twrwait = DIV_ROUND_UP(max(timings->tWC_min, timings->tWH_min), period);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  229  	reg |= EBU_BUSCON_WAITWRC(twrwait);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  230
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  231  	reg |= EBU_BUSCON_CMULT_V4 | EBU_BUSCON_BCGEN_CS | EBU_BUSCON_ALEC |
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  232  		EBU_BUSCON_SETUP_EN;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  233
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  234  	writel(reg, ctrl->ebu + EBU_BUSCON(ctrl->cs_num));
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  235
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  236  	return 0;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  237  }
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  238

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
--------------v4r0SmfRqnrwI3cCadHSwhl0
Content-Type: application/gzip; name=".config.gz"
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
u/8Pjj/C9Ef2AQA=

--------------v4r0SmfRqnrwI3cCadHSwhl0--
