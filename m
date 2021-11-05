Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD1B445FD4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 07:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhKEGpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 02:45:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:9471 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhKEGo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 02:44:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="292687741"
X-IronPort-AV: E=Sophos;i="5.87,210,1631602800"; 
   d="gz'50?scan'50,208,50";a="292687741"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 23:42:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,210,1631602800"; 
   d="gz'50?scan'50,208,50";a="730428694"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga005.fm.intel.com with ESMTP; 04 Nov 2021 23:42:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 4 Nov 2021 23:42:14 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 4 Nov 2021 23:42:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 4 Nov 2021 23:42:13 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 4 Nov 2021 23:42:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGhXBInvMTaCdtSfNJEizmJYIAQPYAQoGObNr35hnFyuDpBGV3G0morlkk1TKsF9JfUaZ8NSCC+62v/k8obF4ULp5PcNS5k6anj5UmSvjIySMjm7gNT5ynh80eBBcoOUmMDEz9sdkgoTOInDqNtJvj72idcZ244ldUDsJzQGdKZEtpWfF+dyKAAcgzeN8LLA16hfoWW/3KT/NHwl3bhv+Dn3+4pjSfyu4skJS4QDTveQwMsGpApbPkeGACVz9D6rwqxUvwqmPLpFhaNv8fMyKwhuJUqSTPuX3Wi+itbgm7HOq/XeniSTRaEdeiGEAyUi2jg20CdsAlPf5tPXipZwtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZR/Ane60aqJB5niX8CuLa74U7YCUoNVkAVRyWANR2no=;
 b=FlOa54EN3AFQM7jzlSug/YztnSQuTEp5kcQgK1PTobnQ2mS+yK4draxR0G192nPkxAco5blXa+QA8482xZd6yFk5d6NPSwb9I4Om6lHXHNGkCR9skaSbBeXWzdldwETVpiQ80qD5Zq9SZpjAoPoiAtF40sHz2Et4uGE5Kz3yiyeJf6aKzRL3cwJalRTtSTTSBgN5Lfa8le4RtBRCPWWii2lUigiRAXxhsf8t2TdbjwBJzgLGhYRbplRz2nxmZ8g616Ha0hF5sUsM+kwJLeR6ZAH41Dj+dkuRYG7S4X1CdVFD8zLlWGHkSYsA68QR9Idw+FIKHsj0fyicfunlwcDZ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZR/Ane60aqJB5niX8CuLa74U7YCUoNVkAVRyWANR2no=;
 b=CDvfgSses84vtMf6ZRR+HamPfuRMeBbRcLfMkBleiZv3Sm2542jry9FqFz9GYkDTMa9Xnbfg9W5xvh2GE7uKSEbLATSV97/WvuiDuWt5HmV91++LoQH/Ly7qqNF/B1j6jSjp5nmHeAPy2J1QrBbJu5qDDNQBgYCLJKaVGojE7i8=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5632.namprd11.prod.outlook.com (2603:10b6:a03:3bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 5 Nov
 2021 06:42:11 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::3455:d126:2541:7723]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::3455:d126:2541:7723%2]) with mapi id 15.20.4649.019; Fri, 5 Nov 2021
 06:42:11 +0000
Content-Type: multipart/mixed; boundary="------------86AFy9hdVBSC1DjECgFqdAKy"
Message-ID: <dc06f6d0-b7d1-c6cf-bb3a-569af600e9e5@intel.com>
Date:   Fri, 5 Nov 2021 14:42:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.0
Subject: Re: fs/io_uring.c:10086:24: warning: Value stored to 'sqe' during its
 initialization is never read [clang-analyzer-deadcode.DeadStores]
References: <202111051137.alSoelJV-lkp@intel.com>
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202111051137.alSoelJV-lkp@intel.com>
X-Forwarded-Message-Id: <202111051137.alSoelJV-lkp@intel.com>
X-ClientProxiedBy: HK2PR02CA0191.apcprd02.prod.outlook.com
 (2603:1096:201:21::27) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
Received: from [10.238.2.77] (192.198.142.18) by HK2PR02CA0191.apcprd02.prod.outlook.com (2603:1096:201:21::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Fri, 5 Nov 2021 06:42:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cac61575-10fe-44d6-fe71-08d9a0276518
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5632:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5632E6A87362DD7210183F37FB8E9@SJ0PR11MB5632.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:299;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rc9wA/Tk79q7jRxmjuuqpFD2XG0qWPxkillS8AR/zpjFXgT69huZvO7zq0Utb7qkDHrexETGC7OXNxuZQ62DvfDIwlEB8oqX2DzI/oI4itaxpfcKq2I7iR41yFKcfI0WD/pTkFvSSUaFd4oAE114ShlgnckM2wMuaXjaod3Uxzi97hVrC3QxxYl1fXAJXPyrsFXAGA2enCeQ3YcdywYX7CxyOWD+o/7E3gt7ZSUWU88JGdL2h6PzjAUox2VfGL8Pt1GnhIdF1o37U7MO9re5e1arJODRmQxLS3KhvgwpdPJpzq1oikO0SriMx7KdSmTMN6OmwZWBtwMQGce43UPkbinjiA0FMTrzKpUQMKoSZqRZcD7fpfnfUprLFTp7Jba+GRI5aKDysiO+fWmZAk55FX+2Hu+/KUlCK1jyedkavJmCNviW+MCYR4GII+PwTIpRBmu8PAmRdg1wcplP8D/11xYllcdBT91B0fjOP1N3zOMToKmwcCfyzMCF4sk/0zgV1dMbEshMlJo0f8gy5wBL2HdH3KxuHnIywvvYCMpn9CJ4blRlyZov/DhjL5IND0Xp7iZwRhRYHJ1I0a0dTHxkSvKzZBLbARzIXXQX4N0UM3gtqnF8/8tmYOsK3zBQzBNUHdB082//J1VZihj/3QsKywXA3DD88LYru5H/8JzQUiqFP/o5ddpaEwuY9dp302A2gG9gpWSwj7z8FlTzA9qKTijzz9ScxePzEOfZBLn+S90sW68DVIZjrhM57v9ubzxiimgMi8ozoYVBLuZN3tOMnn/gH5er2A6FcwfvAfWZwDlCYaBDM1iEjRRLCcENpD15
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(508600001)(6666004)(2906002)(2616005)(33964004)(4001150100001)(186003)(8936002)(82960400001)(4326008)(86362001)(956004)(5660300002)(36756003)(31686004)(83380400001)(6486002)(30864003)(235185007)(6916009)(66476007)(8676002)(38100700002)(66946007)(66556008)(16576012)(316002)(26005)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE1zWkRqOHJaMkwxRmQ4RUh2c1JlZ2R5Nm5sdWhPVzZWYWpFNUh2YWdUcEpE?=
 =?utf-8?B?RGNXQm1VV0lQMUpURUVNRG81M0FhbWVHb29nMUpoci92QzVoWjlaNUxXcStU?=
 =?utf-8?B?UEQzYnNDdXZwREVDWlRIR1p2MUhMNzVxQ2dNRTd1MVBod0JVZjVaejFxaVVL?=
 =?utf-8?B?SVk4RHRUZjhmMkpkUmR6Wi9kZjNXVGkwVWZMdDE2WkVkV25BTXBhcDUyK1lE?=
 =?utf-8?B?OFFzVXB1OXRrRzJJbGtUQXFWWit0azFxbWRwMGJiVXdnbFdXQzlzd3dOeVpy?=
 =?utf-8?B?cXFyS1dVNy9mQUhZWVRETVgwcVRPQzdUNGhpcU8wMW5DOHIrSzByVlJDTFBx?=
 =?utf-8?B?N3FXcGdGTldDOTFCeEsrOEppL1N3cXVwVllBaWxicjlFOEtkQlBWK052UkFv?=
 =?utf-8?B?eFF5Ni9tS2FRa1RRdkJwM0RBZUpQbkRHd3ZVYkxzS01ZL2pkL3J5UkZzOXZ4?=
 =?utf-8?B?V1BwNHNKMTN2Zkp6VG1jRm5SQmhXVTNrNng1L0FadXB2Qm0xWmtDYWJVaGV6?=
 =?utf-8?B?cG5nQXNlcWwrTlZoTFc0enY4ZUZ6WmhXWXBDY0U5cml3and3bGM3dG5DQnpR?=
 =?utf-8?B?d1F3ZlJYRUdpekJKZkdnd1lIaVlybmdHdFdRWEVRTHR6OWgwb205QktPTEZR?=
 =?utf-8?B?b3E5SDhTQkRPOVFUUVZRNnlLQ2RabURrd3pjRUVxVWlMSXIra1ZzU0hSZVJu?=
 =?utf-8?B?MkxueklKbFZ5bDNSd0JQQ0lRMVpIWFZhVy9WVE0zdFppL1BwRlNDQ05oWWRa?=
 =?utf-8?B?aXlZYzY4WnFjbmxhTmlGdXk2SWIyT1BlRDZYRnFiblVhcUxiVVExRzU1ejZy?=
 =?utf-8?B?akFIbWZzakQ2TmgwTEp0emx6TUtGVHBqVTJBWlhpWFFJYW9qbDF4ZExBVk5z?=
 =?utf-8?B?cGoyaUd5cjZJV2dLUE4vYTBBSUFDU291ODVKN3U1MDkzd2dwb2xNb0hjUkxs?=
 =?utf-8?B?UjdCaS9sdkpQZlp4b1B3bUdMTFR5MXV1eU13MG9sQXgweFlnSXQ5MDhZOVQw?=
 =?utf-8?B?NnQrUTYrL0lIZEl0ZFZDVnNCQm1yMVd2eGhMVTB2bVFPSVpVRmpXS0xWclYz?=
 =?utf-8?B?d3ZXYk1FZEdiOTFGZzFEclA2K0hkNThkNVQxUXRpYUhYMXh3U0hNcENUdGUw?=
 =?utf-8?B?UG9XNzU4YWlTdzhKUk9QQkRvRFlJR2dWREJYdE85U3d0dzluRzUrV3NubFZj?=
 =?utf-8?B?M0d0T0czWS9QWFU5WklKZ2Z2bUZ5Z0ZaZmhMV09lRWczelMzS3MxUXRPYTEr?=
 =?utf-8?B?bEtHbCtCYXM3NXpkSkVRNTNaVm1zNjBoL2tiUDEwRGZvMndYcnUxRnpaR0t2?=
 =?utf-8?B?RkZKVmxSbnRpdXBDWjRqQWRpaHI2OWZma2FzY1EyVW9OSmpWcUptTmZzbVlB?=
 =?utf-8?B?cVJVd3JZRG5nTjBVZlUvSkRzQzl6VFB6ejV0dU1LeExkWlIyem91YXZNRGZL?=
 =?utf-8?B?Szhya29KQzM5eFdsWjY4QndGMFhJdlZSVmdsV3FJS2RDdFVqc2VHcm4xdHNz?=
 =?utf-8?B?Y2dIeXdmdExiVTNzVXhkY0lxRU5jSDc5M0xyakYvcHJiQUMzbHBXcTAxa3pY?=
 =?utf-8?B?TzBsd2h3UUw1UEJNUnNnU2tMbTJCWVFNQW1kaWk4STVZSmM4d0EvYWlLK3Rp?=
 =?utf-8?B?YS9HTXVYTUZzbzNIRE4ySGQ5ZE5CY0RKSXR2bktyWkZUYVNWVldGNDZEcEN1?=
 =?utf-8?B?cE52MWZhbnU4WXl4eklUUDNKZWozOFRiWFNUcWJlaG5FN1ZHWFd3UWxpZkpQ?=
 =?utf-8?B?c0wxTzFZK2xUYTlSUjBBSkh4MVowNTljK3ZBMFE0cUViV3ZyNExQa3Q3S0Zk?=
 =?utf-8?B?a2dTdzl6R3BQaUNIY082TTFSN0w0bFdjZFcwUnVnY1g4b0M5Y2FPVm9PTzJk?=
 =?utf-8?B?Sm1FQXl6MGVlUVlVajBHNWw4dCtTTXRXYmx5ZnM0SXVHRnRhbkEwK3BkVy9i?=
 =?utf-8?B?V3owYy84L1diR2ljVzN3QUJwU1RrZ3Z2M0o5TTRUdnNYMTN2TjZDZmpEQjl6?=
 =?utf-8?B?eVFWWG5MYUdzcjluV3d5S2pWT09JYTkzQm1Idm1TRUxXaHh5V2lMTGlwVFdu?=
 =?utf-8?B?UGZVOSthQXBlNWU5ZStGQmVlTERTKzJlWG16WlJHZFl2aitpU0FtK1BqVmRY?=
 =?utf-8?B?WlVIMDBLZ3pndG5sdkJKQlNxSW9QcFNEMnozb2lwQjgxeFB0bjZFTitpekVj?=
 =?utf-8?Q?hJsA30zQoDSyClnuDnRT+9k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cac61575-10fe-44d6-fe71-08d9a0276518
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 06:42:11.3794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmToORz2bLzcdpXAdKdruULGXCwd/PX2o6plCIj9rBAeyCYyLHt8Xtwvx+7UU8sAKWFVUeHVPlyAFLlIvsAw8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5632
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------86AFy9hdVBSC1DjECgFqdAKy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d4439a1189f93d0ac1eaf0197db8e6b3e197d5c7
commit: f75d118349be055d47407b4ba4ceb98e6437e472 io_uring: harder fdinfo sq/cq ring iterating
date:   7 days ago
config: arm-randconfig-c002-20211031 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 82ed106567063ea269c6d5669278b733e173a42f)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # install arm cross compiling tool for clang build
         # apt-get install binutils-arm-linux-gnueabi
         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f75d118349be055d47407b4ba4ceb98e6437e472
         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
         git fetch --no-tags linus master
         git checkout f75d118349be055d47407b4ba4ceb98e6437e472
         # save the attached .config to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> fs/io_uring.c:10086:24: warning: Value stored to 'sqe' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
                    struct io_uring_sqe *sqe = &ctx->sq_sqes[sq_idx];
                                         ^~~   ~~~~~~~~~~~~~~~~~~~~~


vim +/sqe +10086 fs/io_uring.c

87ce955b24c994 Jens Axboe              2020-01-30  10051
c072481ded14bc Pavel Begunkov          2021-10-04  10052  static __cold void __io_uring_show_fdinfo(struct io_ring_ctx *ctx,
c072481ded14bc Pavel Begunkov          2021-10-04  10053  					  struct seq_file *m)
87ce955b24c994 Jens Axboe              2020-01-30  10054  {
dbbe9c642411c3 Joseph Qi               2020-09-29  10055  	struct io_sq_data *sq = NULL;
83f84356bc8f2d Hao Xu                  2021-09-13  10056  	struct io_overflow_cqe *ocqe;
83f84356bc8f2d Hao Xu                  2021-09-13  10057  	struct io_rings *r = ctx->rings;
83f84356bc8f2d Hao Xu                  2021-09-13  10058  	unsigned int sq_mask = ctx->sq_entries - 1, cq_mask = ctx->cq_entries - 1;
83f84356bc8f2d Hao Xu                  2021-09-13  10059  	unsigned int sq_head = READ_ONCE(r->sq.head);
83f84356bc8f2d Hao Xu                  2021-09-13  10060  	unsigned int sq_tail = READ_ONCE(r->sq.tail);
83f84356bc8f2d Hao Xu                  2021-09-13  10061  	unsigned int cq_head = READ_ONCE(r->cq.head);
83f84356bc8f2d Hao Xu                  2021-09-13  10062  	unsigned int cq_tail = READ_ONCE(r->cq.tail);
f75d118349be05 Jens Axboe              2021-10-29  10063  	unsigned int sq_entries, cq_entries;
fad8e0de4426a7 Jens Axboe              2020-09-28  10064  	bool has_lock;
83f84356bc8f2d Hao Xu                  2021-09-13  10065  	unsigned int i;
83f84356bc8f2d Hao Xu                  2021-09-13  10066
83f84356bc8f2d Hao Xu                  2021-09-13  10067  	/*
83f84356bc8f2d Hao Xu                  2021-09-13  10068  	 * we may get imprecise sqe and cqe info if uring is actively running
83f84356bc8f2d Hao Xu                  2021-09-13  10069  	 * since we get cached_sq_head and cached_cq_tail without uring_lock
83f84356bc8f2d Hao Xu                  2021-09-13  10070  	 * and sq_tail and cq_head are changed by userspace. But it's ok since
83f84356bc8f2d Hao Xu                  2021-09-13  10071  	 * we usually use these info when it is stuck.
83f84356bc8f2d Hao Xu                  2021-09-13  10072  	 */
f75d118349be05 Jens Axboe              2021-10-29  10073  	seq_printf(m, "SqMask:\t\t0x%x\n", sq_mask);
f75d118349be05 Jens Axboe              2021-10-29  10074  	seq_printf(m, "SqHead:\t%u\n", sq_head);
f75d118349be05 Jens Axboe              2021-10-29  10075  	seq_printf(m, "SqTail:\t%u\n", sq_tail);
f75d118349be05 Jens Axboe              2021-10-29  10076  	seq_printf(m, "CachedSqHead:\t%u\n", ctx->cached_sq_head);
f75d118349be05 Jens Axboe              2021-10-29  10077  	seq_printf(m, "CqMask:\t0x%x\n", cq_mask);
f75d118349be05 Jens Axboe              2021-10-29  10078  	seq_printf(m, "CqHead:\t%u\n", cq_head);
f75d118349be05 Jens Axboe              2021-10-29  10079  	seq_printf(m, "CqTail:\t%u\n", cq_tail);
f75d118349be05 Jens Axboe              2021-10-29  10080  	seq_printf(m, "CachedCqTail:\t%u\n", ctx->cached_cq_tail);
f75d118349be05 Jens Axboe              2021-10-29  10081  	seq_printf(m, "SQEs:\t%u\n", sq_tail - ctx->cached_sq_head);
f75d118349be05 Jens Axboe              2021-10-29  10082  	sq_entries = min(sq_tail - sq_head, ctx->sq_entries);
f75d118349be05 Jens Axboe              2021-10-29  10083  	for (i = 0; i < sq_entries; i++) {
f75d118349be05 Jens Axboe              2021-10-29  10084  		unsigned int entry = i + sq_head;
f75d118349be05 Jens Axboe              2021-10-29  10085  		unsigned int sq_idx = READ_ONCE(ctx->sq_array[entry & sq_mask]);
83f84356bc8f2d Hao Xu                  2021-09-13 @10086  		struct io_uring_sqe *sqe = &ctx->sq_sqes[sq_idx];
83f84356bc8f2d Hao Xu                  2021-09-13  10087
f75d118349be05 Jens Axboe              2021-10-29  10088  		if (sq_idx > sq_mask)
f75d118349be05 Jens Axboe              2021-10-29  10089  			continue;
f75d118349be05 Jens Axboe              2021-10-29  10090  		sqe = &ctx->sq_sqes[sq_idx];
83f84356bc8f2d Hao Xu                  2021-09-13  10091  		seq_printf(m, "%5u: opcode:%d, fd:%d, flags:%x, user_data:%llu\n",
f75d118349be05 Jens Axboe              2021-10-29  10092  			   sq_idx, sqe->opcode, sqe->fd, sqe->flags,
f75d118349be05 Jens Axboe              2021-10-29  10093  			   sqe->user_data);
83f84356bc8f2d Hao Xu                  2021-09-13  10094  	}
f75d118349be05 Jens Axboe              2021-10-29  10095  	seq_printf(m, "CQEs:\t%u\n", cq_tail - cq_head);
f75d118349be05 Jens Axboe              2021-10-29  10096  	cq_entries = min(cq_tail - cq_head, ctx->cq_entries);
f75d118349be05 Jens Axboe              2021-10-29  10097  	for (i = 0; i < cq_entries; i++) {
f75d118349be05 Jens Axboe              2021-10-29  10098  		unsigned int entry = i + cq_head;
f75d118349be05 Jens Axboe              2021-10-29  10099  		struct io_uring_cqe *cqe = &r->cqes[entry & cq_mask];
83f84356bc8f2d Hao Xu                  2021-09-13  10100
83f84356bc8f2d Hao Xu                  2021-09-13  10101  		seq_printf(m, "%5u: user_data:%llu, res:%d, flag:%x\n",
f75d118349be05 Jens Axboe              2021-10-29  10102  			   entry & cq_mask, cqe->user_data, cqe->res,
f75d118349be05 Jens Axboe              2021-10-29  10103  			   cqe->flags);
83f84356bc8f2d Hao Xu                  2021-09-13  10104  	}
87ce955b24c994 Jens Axboe              2020-01-30  10105
fad8e0de4426a7 Jens Axboe              2020-09-28  10106  	/*
fad8e0de4426a7 Jens Axboe              2020-09-28  10107  	 * Avoid ABBA deadlock between the seq lock and the io_uring mutex,
fad8e0de4426a7 Jens Axboe              2020-09-28  10108  	 * since fdinfo case grabs it in the opposite direction of normal use
fad8e0de4426a7 Jens Axboe              2020-09-28  10109  	 * cases. If we fail to get the lock, we just don't iterate any
fad8e0de4426a7 Jens Axboe              2020-09-28  10110  	 * structures that could be going away outside the io_uring mutex.
fad8e0de4426a7 Jens Axboe              2020-09-28  10111  	 */
fad8e0de4426a7 Jens Axboe              2020-09-28  10112  	has_lock = mutex_trylock(&ctx->uring_lock);
fad8e0de4426a7 Jens Axboe              2020-09-28  10113
5f3f26f98ae484 Jens Axboe              2021-02-25  10114  	if (has_lock && (ctx->flags & IORING_SETUP_SQPOLL)) {
dbbe9c642411c3 Joseph Qi               2020-09-29  10115  		sq = ctx->sq_data;
5f3f26f98ae484 Jens Axboe              2021-02-25  10116  		if (!sq->thread)
5f3f26f98ae484 Jens Axboe              2021-02-25  10117  			sq = NULL;
5f3f26f98ae484 Jens Axboe              2021-02-25  10118  	}
dbbe9c642411c3 Joseph Qi               2020-09-29  10119
dbbe9c642411c3 Joseph Qi               2020-09-29  10120  	seq_printf(m, "SqThread:\t%d\n", sq ? task_pid_nr(sq->thread) : -1);
dbbe9c642411c3 Joseph Qi               2020-09-29  10121  	seq_printf(m, "SqThreadCpu:\t%d\n", sq ? task_cpu(sq->thread) : -1);
87ce955b24c994 Jens Axboe              2020-01-30  10122  	seq_printf(m, "UserFiles:\t%u\n", ctx->nr_user_files);
fad8e0de4426a7 Jens Axboe              2020-09-28  10123  	for (i = 0; has_lock && i < ctx->nr_user_files; i++) {
7b29f92da377c3 Jens Axboe              2021-03-12  10124  		struct file *f = io_file_from_index(ctx, i);
87ce955b24c994 Jens Axboe              2020-01-30  10125
87ce955b24c994 Jens Axboe              2020-01-30  10126  		if (f)
87ce955b24c994 Jens Axboe              2020-01-30  10127  			seq_printf(m, "%5u: %s\n", i, file_dentry(f)->d_iname);
87ce955b24c994 Jens Axboe              2020-01-30  10128  		else
87ce955b24c994 Jens Axboe              2020-01-30  10129  			seq_printf(m, "%5u: <none>\n", i);
87ce955b24c994 Jens Axboe              2020-01-30  10130  	}
87ce955b24c994 Jens Axboe              2020-01-30  10131  	seq_printf(m, "UserBufs:\t%u\n", ctx->nr_user_bufs);
fad8e0de4426a7 Jens Axboe              2020-09-28  10132  	for (i = 0; has_lock && i < ctx->nr_user_bufs; i++) {
41edf1a5ec967b Pavel Begunkov          2021-04-25  10133  		struct io_mapped_ubuf *buf = ctx->user_bufs[i];
4751f53d74a688 Pavel Begunkov          2021-04-01  10134  		unsigned int len = buf->ubuf_end - buf->ubuf;
87ce955b24c994 Jens Axboe              2020-01-30  10135
4751f53d74a688 Pavel Begunkov          2021-04-01  10136  		seq_printf(m, "%5u: 0x%llx/%u\n", i, buf->ubuf, len);
87ce955b24c994 Jens Axboe              2020-01-30  10137  	}
61cf93700fe635 Matthew Wilcox (Oracle  2021-03-08  10138) 	if (has_lock && !xa_empty(&ctx->personalities)) {
61cf93700fe635 Matthew Wilcox (Oracle  2021-03-08  10139) 		unsigned long index;
61cf93700fe635 Matthew Wilcox (Oracle  2021-03-08  10140) 		const struct cred *cred;
61cf93700fe635 Matthew Wilcox (Oracle  2021-03-08  10141)
87ce955b24c994 Jens Axboe              2020-01-30  10142  		seq_printf(m, "Personalities:\n");
61cf93700fe635 Matthew Wilcox (Oracle  2021-03-08  10143) 		xa_for_each(&ctx->personalities, index, cred)
61cf93700fe635 Matthew Wilcox (Oracle  2021-03-08  10144) 			io_uring_show_cred(m, index, cred);
87ce955b24c994 Jens Axboe              2020-01-30  10145  	}
83f84356bc8f2d Hao Xu                  2021-09-13  10146  	if (has_lock)
83f84356bc8f2d Hao Xu                  2021-09-13  10147  		mutex_unlock(&ctx->uring_lock);
83f84356bc8f2d Hao Xu                  2021-09-13  10148
83f84356bc8f2d Hao Xu                  2021-09-13  10149  	seq_puts(m, "PollList:\n");
79ebeaee8a21a0 Jens Axboe              2021-08-10  10150  	spin_lock(&ctx->completion_lock);
d7718a9d25a614 Jens Axboe              2020-02-14  10151  	for (i = 0; i < (1U << ctx->cancel_hash_bits); i++) {
d7718a9d25a614 Jens Axboe              2020-02-14  10152  		struct hlist_head *list = &ctx->cancel_hash[i];
d7718a9d25a614 Jens Axboe              2020-02-14  10153  		struct io_kiocb *req;
d7718a9d25a614 Jens Axboe              2020-02-14  10154
d7718a9d25a614 Jens Axboe              2020-02-14  10155  		hlist_for_each_entry(req, list, hash_node)
d7718a9d25a614 Jens Axboe              2020-02-14  10156  			seq_printf(m, "  op=%d, task_works=%d\n", req->opcode,
d7718a9d25a614 Jens Axboe              2020-02-14  10157  					req->task->task_works != NULL);
d7718a9d25a614 Jens Axboe              2020-02-14  10158  	}
83f84356bc8f2d Hao Xu                  2021-09-13  10159
83f84356bc8f2d Hao Xu                  2021-09-13  10160  	seq_puts(m, "CqOverflowList:\n");
83f84356bc8f2d Hao Xu                  2021-09-13  10161  	list_for_each_entry(ocqe, &ctx->cq_overflow_list, list) {
83f84356bc8f2d Hao Xu                  2021-09-13  10162  		struct io_uring_cqe *cqe = &ocqe->cqe;
83f84356bc8f2d Hao Xu                  2021-09-13  10163
83f84356bc8f2d Hao Xu                  2021-09-13  10164  		seq_printf(m, "  user_data=%llu, res=%d, flags=%x\n",
83f84356bc8f2d Hao Xu                  2021-09-13  10165  			   cqe->user_data, cqe->res, cqe->flags);
83f84356bc8f2d Hao Xu                  2021-09-13  10166
83f84356bc8f2d Hao Xu                  2021-09-13  10167  	}
83f84356bc8f2d Hao Xu                  2021-09-13  10168
79ebeaee8a21a0 Jens Axboe              2021-08-10  10169  	spin_unlock(&ctx->completion_lock);
87ce955b24c994 Jens Axboe              2020-01-30  10170  }
87ce955b24c994 Jens Axboe              2020-01-30  10171

:::::: The code at line 10086 was first introduced by commit
:::::: 83f84356bc8f2dda9d0c9c7edb94decf71a36d26 io_uring: add more uring info to fdinfo for debug

:::::: TO: Hao Xu <haoxu@linux.alibaba.com>
:::::: CC: Jens Axboe <axboe@kernel.dk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
--------------86AFy9hdVBSC1DjECgFqdAKy
Content-Type: application/gzip; name=".config.gz"
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--------------86AFy9hdVBSC1DjECgFqdAKy--
