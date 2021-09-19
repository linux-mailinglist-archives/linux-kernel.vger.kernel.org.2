Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168D3410C2C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 17:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbhISPhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 11:37:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:34996 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233114AbhISPhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 11:37:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10112"; a="222675241"
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; 
   d="gz'50?scan'50,208,50";a="222675241"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2021 08:36:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; 
   d="gz'50?scan'50,208,50";a="700398156"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga006.fm.intel.com with ESMTP; 19 Sep 2021 08:36:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 19 Sep 2021 08:36:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sun, 19 Sep 2021 08:36:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sun, 19 Sep 2021 08:36:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9TrRV92mx2mJ+DxkuACpVC7aBO0GndElinleo1nBBgPREwlhzXsT9MjpFENl5kSkb0alrO81sz0w35OR8iMQUm8V62g+hxB2opyagKoOLLk8Dvwbk3cxjKzGLkv4WSbgaecPU8JJZfq7wqYdzqLK49IK/lGm9MpGrm7kM0MC6VJvJQuiPqFIiVakCq620jVPLse5wdSf90rHl2eUmwaM9v9CYVtORdgCrF7Ih6JPzylMo+MxZIkeeKMMi/hJm1fsX1gZ+i12huoyYMegOUR/DNufgaLstpJJ+2spuUnyG4cLili5E3dRLrqvYa051eqfpaeUOR151aOtFfUOHm8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QHA2hhVJne7vvxXBrf7q5BN2yLIltuF6YqqJwLASGYk=;
 b=Miz0NNxz8qqDXTb3STfGOA6hEaVfyCsuQFZnDKb4bnEit5pMubh3OA9Zrafu6v3TVJTQ9ZPLdPsD65ILBaY9xtjlm26FkBEKOcNyx2e1D+5AF+CogVDZzUtWJUKI6FzReF/LqKbM0z70asd38c0oVcx5NhxNJgMIK/l50gOOY9T82AFv3HExtjDrGWMB4ZYPXU5mA8gIE1A9Cc+Zqov0X2BoDDiyDwQ2JRMzZh1PMVhJYGen3JF4FGSrKBd60LTwEd+nkL7tQ2dtPFxAMSRxMfYae0Octopycjq/RBUSVGFf/sbtln8MGTm8ZB9XeXxbuPtaR24qVfu+DanM1JJ4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHA2hhVJne7vvxXBrf7q5BN2yLIltuF6YqqJwLASGYk=;
 b=AKPlwEkO9Jh2OluIy8AzzmhP3nvP7rnBhxJekSab+NysQNktudygNbD9u0Z51uAZGvp+y6kAUKx9J+F7fjHsvyKc4QfC6GxXCLvSc206o0rjOuATZhtPgij6G3rxdb/vFdJyycNtl48VCvgxvoNHtUIUfw67mR+gfMxIZ7Pr4tQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5615.namprd11.prod.outlook.com (2603:10b6:a03:305::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Sun, 19 Sep
 2021 15:36:03 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::6d71:2479:2bf5:de7f]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::6d71:2479:2bf5:de7f%9]) with mapi id 15.20.4523.018; Sun, 19 Sep 2021
 15:36:02 +0000
Content-Type: multipart/mixed; boundary="------------Zzya0etvHxAgcKF0e0LqM07B"
Message-ID: <a96bfbe2-5ed3-97f7-91e1-88df025cfeb6@intel.com>
Date:   Sun, 19 Sep 2021 23:35:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.1.1
Subject: [dhowells-fs:netfs-folio-regions 18/36]
 include/linux/compiler_types.h:328:38: error: call to
 '__compiletime_assert_353' declared with attribute error: Need native word
 sized stores/loads for atomicity.
References: <202108301926.qk8TxNLN-lkp@intel.com>
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202108301926.qk8TxNLN-lkp@intel.com>
X-Forwarded-Message-Id: <202108301926.qk8TxNLN-lkp@intel.com>
X-ClientProxiedBy: HKAPR03CA0019.apcprd03.prod.outlook.com
 (2603:1096:203:c9::6) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
Received: from [10.255.28.110] (192.198.142.18) by HKAPR03CA0019.apcprd03.prod.outlook.com (2603:1096:203:c9::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.6 via Frontend Transport; Sun, 19 Sep 2021 15:36:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 068cf689-f1f2-4936-9288-08d97b832ff1
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5615:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB56156C5A737214C6078FF168FBDF9@SJ0PR11MB5615.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +29SmwME+FTUq4+DdoC3ixilBLenV6VN5AGRmIPv2Z+s97DDBvTbpp7jS0hkDUNDZjZh/Zb+5fBc3AOtYpY4FRcEkKmXiahiNK28ocDFiASRWxqP5TK73BaD+ram+jZmdd9UhbTD45AW5RbGVjo5r2hEo3WkljfJFfFgB9hzy1CEk+HTwl/t24rJ2vnf8MqnlFw/vlCL5Ner9KktSqL+5fi7HiX5sGMrG4JZm6G/ckC/VQgYT7pdfMl9+WikkwmLDGBNlOZDM9jo4V0sMX1UZ6c/XLmNtzdXwq23+r9NLE2pYmKzvOmdP6ZjbW++yGxn6+Jqvbk/pVotaKNd+5YaS04EhZx8bWslakmqvqdvThYWhgxjumELfppkN8rrd3iYEjv2PyPuM7OdblN2yh2v+mYUY5BWgqYQduWFLjMJeIv2acqIHaHMC9zh8wPZxHXg5r5DPKEAeJqllrk6Dbl7QVSxTkeW12NZVoNImf5Dk1O+JDSdk5HqdRxu5BY3sYHfd4ATPlyb7iM6c6iViNUspNyEyw/fDSNQmgw5A++OvDyrJW9XT1avERMhR9bLQMQa4E3i0E5l3KenGEZ+HIm27t8zGp9X6ge194E+vtlAe9PUt9F55DDhLYdC7UGCkbXBthf26cWwOJTjzDYn/xRiiQobfKnazdnjWo+AgEw4JWwYa0rhLrntvtWmvULhPcokofkf0334ohYyd3/KL5U5guiI6m51K/4gjt/uEvOvmO9cvGJ5kEqR990L0hUDd71n3MoGk7jcfSGtk59y7HA9r3imXLlMkDMVRhDjrdiD2Tx57AVF/nbT26jxHgEPLm9u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66616009)(33964004)(66476007)(4326008)(8936002)(31686004)(966005)(83380400001)(5660300002)(66946007)(235185007)(66556008)(508600001)(86362001)(316002)(2906002)(16576012)(186003)(8676002)(6916009)(6666004)(6486002)(2616005)(31696002)(956004)(38100700002)(26005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3JKL2pLUWNkaTN4eHY4VEcvazN5L3BoL0Y5K0lma0RUVHUwVGhsb012cGZx?=
 =?utf-8?B?S2dEVUFGZi9IV1FjZFk4MWFreVhKSklMdXZCa05nVkhGdVQvOWMzSVZSSk5p?=
 =?utf-8?B?YUxIOWJHaUdDVURQVnBsQzRVOUlrdC9LaGFWRFQzOUV4dEpvaytObk1weEc3?=
 =?utf-8?B?d3lpcm5HWHhMOGRVakZ2RThHVkhUMWNGeS9qNDNhTzd5S0FGaXMxYXdCbjZF?=
 =?utf-8?B?dHlqQnZGRDFORGl6NmZZdDNFek1RVER5c1NuTHlkTVBLTEZ3RW9IcjNzWlJl?=
 =?utf-8?B?Qm40S3IrUXk4M0xnL1JmNnZFc3NmSjltbTZNeE1JZnN6ZVhSYUYxS2EvdktP?=
 =?utf-8?B?dk5vOHNidFphTkJVR09MbFNtbzBVRTBVYzBFMmVnOFlycXJmR2M1bXZaVlVD?=
 =?utf-8?B?NFdlQ1BkZ1UvNmFLa1owalRBVjNJUENEUFJ6WDVqTCtIODJYbjZIWlpMbWdi?=
 =?utf-8?B?eVNLdWZvUXg3d1pGcVB3a2ZPbjhtNm5kWXI5ZmcxVUZjVHVNR3hwQ3VhUERM?=
 =?utf-8?B?T3AyaTB3WG5PczBIU3VPczdrdUVycVZBd3hOQlBFUGdUVFViVndxOXBSSjV3?=
 =?utf-8?B?cERwTS90cFJOYVNOanlhSzZ6SW9GY2lBWWJlWk9Remc5YW5jd3hxVmF1dFRH?=
 =?utf-8?B?UjI2djdZd3k2SVNpd3hqY3dYOXYwRTZtMm9aYWpoRjZPVnVQYjlDYjNoamxC?=
 =?utf-8?B?eFpHUzJITFRuT2FTVG5uTnFqM1lXem9xTU1ZUE9mOEwxT3UrbUVCb091elQ2?=
 =?utf-8?B?aUZnR3hlL2NsbTdDcGpzN1J2VEllazNOVjEySEtUTWxDWDRSaGI4TjF4ZTdt?=
 =?utf-8?B?czU0UmtQNWRYdnYxdFhmcXFsdnBoSlkwTjBuMnNQZWxiQzBUSkJLOWlsVnVn?=
 =?utf-8?B?UjltVjc3SnB3UHYyWkRGZ3B0dUVodzBMQTJDcnFUR3c1N3lBL05YNWtsY1px?=
 =?utf-8?B?d3AvRzM5V2pxWlV3dmlyMHJ4cWhiY3lmTDUvMkk1ZWFTVGNQcUtFclh4ZWlr?=
 =?utf-8?B?RHZQdXlabGlKd2NzUW5FSm4raU1BNEtUK1BxRlJVUGR2S29NLzRqUWlEUzE2?=
 =?utf-8?B?bkRkSXBYOEV6N3NnNkFVK0Y2UzNtaGFoTHQxNy81K01SL0JxdGxQdjZMTWE4?=
 =?utf-8?B?Tk5Za3dMSkNBN0oxcWlIU0J1amxWSHY1NlNTNmJIVFBtWFhhNEg0TDF4TUlF?=
 =?utf-8?B?WEFzYTY1K2crdzlpWHh6M3NHOHp3bEpqL2lCQTk0S2k0SHBWdllPYXNobUUv?=
 =?utf-8?B?QnVuSm9PZkVVMGlJVUpLVzVSODRRRm1ENWdXNzJMc1IyQldDK3ovNnlYTCs3?=
 =?utf-8?B?WVNvWTZDcEV0dkVyVFllN3ExRi85RkdYQmw2R1BJd09TQjM1azNDaGRtUiti?=
 =?utf-8?B?MHFJRTFEbFhaTUJpNE1Qd2RFaVZtcnNkeDlNK2pOdFpxUHVrSktCT0ZkeTFF?=
 =?utf-8?B?cWV6TGh5dzk2MnpKcFpKT3JWT1VnQ2hFamx1WlZiOHVXWnZSUnJEU2dnekR4?=
 =?utf-8?B?UmIxQk1oR2FyNXppOHdtOWt1TjM3b0tFdmpYaUVacnUydnZ3M2p3bmxaM3Qz?=
 =?utf-8?B?RmVOUUE0Z0ROREZiNksyN2pJWVhmeXYwa3J1dVNZQW4wYUlJazM2Q202bk1r?=
 =?utf-8?B?elN5RWROaEdXa3BXcjUzZTJxd0R0aUVTcU4yUGhXQkdFOGF0RjA2R3FTUkJ3?=
 =?utf-8?B?d0ovOTVkUVc3VGpjRWo2Q2RBUjRsR2RJcVlBYmNCT2N3Q0hzK0tJRzdSbFZh?=
 =?utf-8?Q?E8uJ76J9+irfA+diOUEF6gdHhWYiYY+hitid3kp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 068cf689-f1f2-4936-9288-08d97b832ff1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2021 15:36:02.8144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fs1FZTUMjVxNEUnAcmdp7vWW8fUZlQGHny5CVjwBLb25reWst96LCHVZrlneyVXfQi9kaAN42iPxY9lTdZ76zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5615
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------Zzya0etvHxAgcKF0e0LqM07B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git netfs-folio-regions
head:   2f3fe780e9a44691136170536363c701b527d0e8
commit: bbfa10bc8233de4c54031fd2009d866b3f6195c6 [18/36] netfs: Keep lists of pending, active, dirty and flushed regions
:::::: branch date: 4 days ago
:::::: commit date: 4 days ago
config: i386-randconfig-s031-20210830 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
         # https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?id=bbfa10bc8233de4c54031fd2009d866b3f6195c6
         git remote add dhowells-fs https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
         git fetch --no-tags dhowells-fs netfs-folio-regions
         git checkout bbfa10bc8233de4c54031fd2009d866b3f6195c6
         # save the attached .config to linux build tree
         make ARCH=i386 olddefconfig
         make ARCH=i386 -j8 fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors:

fs/netfs/read_helper.c: In function 'netfs_write_begin':
fs/netfs/read_helper.c:1286:7: error: implicit declaration of function 'netfs_is_cache_enabled' [-Werror=implicit-function-declaration]
  1286 |  if (!netfs_is_cache_enabled(ctx) &&
       |       ^~~~~~~~~~~~~~~~~~~~~~
In file included from ./include/linux/kernel.h:16,
                  from ./include/linux/list.h:9,
                  from ./include/linux/wait.h:7,
                  from ./include/linux/wait_bit.h:8,
                  from ./include/linux/fs.h:6,
                  from fs/netfs/write_helper.c:9:
fs/netfs/write_helper.c: In function 'copy_folio_from_iter_atomic':
./include/linux/minmax.h:20:28: warning: comparison of distinct pointer types lacks a cast
    20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
       |                            ^~
./include/linux/minmax.h:26:4: note: in expansion of macro '__typecheck'
    26 |   (__typecheck(x, y) && __no_side_effects(x, y))
       |    ^~~~~~~~~~~
./include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
    36 |  __builtin_choose_expr(__safe_cmp(x, y), \
       |                        ^~~~~~~~~~
./include/linux/minmax.h:45:19: note: in expansion of macro '__careful_cmp'
    45 | #define min(x, y) __careful_cmp(x, y, <)
       |                   ^~~~~~~~~~~~~
fs/netfs/write_helper.c:25:26: note: in expansion of macro 'min'
    25 |   unsigned int psize   = min(PAGE_SIZE - offset, size);
       |                          ^~~
In file included from <command-line>:
fs/netfs/write_helper.c: In function 'netfs_perform_write':
././include/linux/compiler_types.h:328:38: error: call to '__compiletime_assert_323' declared with attribute error: Need native word sized stores/loads for atomicity.
   328 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
       |                                      ^
././include/linux/compiler_types.h:309:4: note: in definition of macro '__compiletime_assert'
   309 |    prefix ## suffix();    \
       |    ^~~~~~
././include/linux/compiler_types.h:328:2: note: in expansion of macro '_compiletime_assert'
   328 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
       |  ^~~~~~~~~~~~~~~~~~~
././include/linux/compiler_types.h:331:2: note: in expansion of macro 'compiletime_assert'
   331 |  compiletime_assert(__native_word(t),    \
       |  ^~~~~~~~~~~~~~~~~~
./arch/x86/include/asm/barrier.h:65:2: note: in expansion of macro 'compiletime_assert_atomic_type'
    65 |  compiletime_assert_atomic_type(*p);    \
       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/barrier.h:138:33: note: in expansion of macro '__smp_store_release'
   138 | #define smp_store_release(p, v) __smp_store_release(p, v)
       |                                 ^~~~~~~~~~~~~~~~~~~
fs/netfs/write_helper.c:897:3: note: in expansion of macro 'smp_store_release'
   897 |   smp_store_release(&region->dirty.end, new_pos);
       |   ^~~~~~~~~~~~~~~~~
make[2]: *** [scripts/Makefile.build:271: fs/netfs/write_helper.o] Error 1
make[2]: *** Waiting for unfinished jobs....
cc1: some warnings being treated as errors
make[2]: *** [scripts/Makefile.build:271: fs/netfs/read_helper.o] Error 1
make[1]: *** [scripts/Makefile.build:514: fs/netfs] Error 2
make: *** [Makefile:1842: fs] Error 2


vim +/__compiletime_assert_353 +328 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  314
eb5c2d4b45e3d2 Will Deacon 2020-07-21  315  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  316  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  317
eb5c2d4b45e3d2 Will Deacon 2020-07-21  318  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  319   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  320   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  321   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  322   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  323   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  324   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  325   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  326   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  327  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @328  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  329

:::::: The code at line 328 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
--------------Zzya0etvHxAgcKF0e0LqM07B
Content-Type: application/gzip; name=".config.gz"
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--------------Zzya0etvHxAgcKF0e0LqM07B--
