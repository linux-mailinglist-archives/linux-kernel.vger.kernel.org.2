Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F9845FEBD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 14:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354731AbhK0NO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 08:14:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:63833 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231249AbhK0NM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 08:12:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="233253713"
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="233253713"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 05:09:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="652399596"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga001.fm.intel.com with ESMTP; 27 Nov 2021 05:09:42 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 27 Nov 2021 05:09:41 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sat, 27 Nov 2021 05:09:41 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sat, 27 Nov 2021 05:09:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bc0uEGV+ztaeWGaOjhXluHTHj4eb/2bCa49EO5FWrmTCx03c4/8G6Wk+4BcN7yYHd5P+QeuJI//GzixqNrGY6k5khf8ZYwhWiuYPZ3yhUfpV2wqsOoDICIkybjHDCtEJjdqTb265S0QLI0KAcbyu1WSYPP5Ki5dAp3SAaZKbJ9qfNHi5uAFzLERvA7luKsfmjrGFMheO7znKh4KhEhS07hkrCIxLP4X+DTy8vJmCNyp2kpam3t1qUFrEPWoe4UG+g8AvNVve7T5QH9Q2z9IZBmu5iztPOEbSBvGSRdew/B0MDpsy2MkCcJDZqQezbu1nQP2YVQyZ0JMcDdlRb5a0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kC2pCcXzLTDkXGzyfEV/L0mzobP7O9IEff5SsX70PtA=;
 b=M3K+5PTbP9j82h/PXJpMCG321X0Py08ZJwODt84192QZ0Aa4zpeEAN0nR9bprtVoPw0QfvCQi32PjcQ9fZrUurj1e4OwdfpJSnrtmKp6HJpPVk4vdNBd9cek/xwON20gzsiQBmfsS6jsowMwBVpYOFSyHAqooo+1zAamW+F6PRiYK+5GDWL1fRNCqoZWqn3OV2T6byTydd/u1yM/pWZeL1QRaM7u8xz9vsIphYs6pnqq5KiEBA7zXcQSkYLQ8fhOjmANA1pcnxtOovRpJQwXwgqln9CEMpCA44ob0Z1/eOBs9TCKbZDQJ4BqmsMYJPX+Q4x38m0cM3i1SW0VAbcOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kC2pCcXzLTDkXGzyfEV/L0mzobP7O9IEff5SsX70PtA=;
 b=dkFvU/bMRCjuZzpBI+IZ7UOJ1m0+z3QspO2BDCyNQN40hStaulaflo8KOl6N1SZlxggHJXhmJj/qGe/RW1c4EoxMV5QvxCCJJQ82IxZGw53OQb4pLqiqd/ZVa9ijztPqOTH/y+rlYAxuIy9lnnE3lz/hD5l1iqpU7YbHoAuf2/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5632.namprd11.prod.outlook.com (2603:10b6:a03:3bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Sat, 27 Nov
 2021 13:09:40 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::3455:d126:2541:7723]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::3455:d126:2541:7723%2]) with mapi id 15.20.4690.019; Sat, 27 Nov 2021
 13:09:40 +0000
Message-ID: <e6089409-f85c-3a2b-66fe-d1684289eac7@intel.com>
Date:   Sat, 27 Nov 2021 21:09:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: [djwong-xfs:direct-xfile-mapped-buffers 103/333]
 fs/xfs/xfs_rtalloc.c:1439:17: warning: Value stored to 'off' during its
 initialization is never read [clang-analyzer-deadcode.DeadStores]
References: <202111260911.JKJz6fEX-lkp@intel.com>
Content-Language: en-US
From:   kernel test robot <yujie.liu@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
In-Reply-To: <202111260911.JKJz6fEX-lkp@intel.com>
X-Forwarded-Message-Id: <202111260911.JKJz6fEX-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::16) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
Received: from [10.252.191.82] (192.55.52.197) by PN3PR01CA0017.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:95::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Sat, 27 Nov 2021 13:09:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3d1f67f-cb76-460c-3fdb-08d9b1a72bd8
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5632:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5632052FEA107F7F7020530EFB649@SJ0PR11MB5632.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LEYFY+Sa8gNTGz4ypdnJy3LzgHFf765e0sW6PW+msz4Kr/8DcVR8FsWDzyoWywTJYdLVmFPbhitCQpN0bVwEESZHwcEEQ8gamyoXDy0AbHqH0rh9VqxN92GUMdmiiL1EKnGblA5hcN3JbFCYiqN7hfFa71NOJmXqGZDi7ABaYTZVvZPiNdR52XYDs+1lU6PPTdZ1qbdUjDXw2hvlJuW8NXNmkArFmfY5TTqO15fd2WhcSru+HI2CUN4jXS23TpaamnNUYq3m1QybOXigq+yoIdlUaj7DzfN7+HyP4Ozz4Nifp/ZVTFN/0oI143ttQSxAF6HCSy04ynSKZQCZD8Uh8MBXcC/jIpSNl4TX2Kmub6+KstL9kxfDX9y47N2s6K9McKCKMLAXOdlmsuUHD+wR7hwZGmnArZJeoEivATARAfGMRBw92aDUF4wy6hvWLKIGLdS/XOoGaOzuhbEDZtE4a0qXkKN3phhKHQoYgUb8kFv8E3MHfT2m/xzgnhTeEgKuQGcYWd9nxGpjnp57o0DmaTp7APHWr2YCSUJKzw2zHg3kUmVOFu8uMESzZw6k06HKOURUr5cx76few0NG5YFHe5Gkcdo8STSNLnOFN5dn2BGuVxUXfm/LxTQirXKhbbSH5EWmIqCnzbzgrHmyi1nBZBvPO4OSc9A9S4FZKn8GSJiS5oOap63tAw8AIGqSb+9+uOrF3XBSD0BKtriCcei8q2kgdm5jG1tPF0MBL3whHY8CRpwsuWEWLGBaHyJZtLjbH9ATmCXVEJ7MnlEDIap+e8I/zXkF4WftzmAQZejHKI1UgVwgKgsg6zcf3HCXv8STvkVy4hrUY4e773bBHrxm2Eo6GvFNfcHOWkUng5tbQUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(966005)(66946007)(36756003)(66476007)(508600001)(8936002)(4326008)(186003)(66556008)(2906002)(54906003)(6666004)(83380400001)(31696002)(6916009)(316002)(26005)(31686004)(8676002)(2616005)(82960400001)(956004)(6486002)(16576012)(5660300002)(86362001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3M2eFJyOGk1Mm9VUFErN2FPQzMzMDVGYWloQWtVNTQxZm42MnZBUld1UFE5?=
 =?utf-8?B?ekFIZVQ2bU1HYVNUaFdLd3d2VjFRUHBqNFNVamZGQ01mc3lPTjN3WCt2R0VE?=
 =?utf-8?B?NmU4akZucnhIaUUzZ0VIQnhBV2Ixek9uWHcyMkpjN1AyMngyNS9yOTRiRTBT?=
 =?utf-8?B?a29PRzVaY3dQK3dzUGRRcWVmWXdZOXM5bnVKbWs2b2JQQXk5TmNkYzc4WnZt?=
 =?utf-8?B?ZVJVRzFVb1NyUTR2STlrWHdCRW5CcnNtMlRIajJQWk1hdW5MWFEwck53aG1N?=
 =?utf-8?B?by9JOVpoSlZ1bFVJL3lyMVllKy9SQnhNNUVSbkhPakN1bks0Qy8ydUVNb29V?=
 =?utf-8?B?YzZGenc2dXpSeVBNQ1ZhcFJpSFUxMndtSS9CT21aN21kcExtcW5YV29KVjdZ?=
 =?utf-8?B?dStVaUl0OEhTc1VNN3hSMmNEZzNUZERvVjU5a0xkR2k3elNKcXppNUVPTTF1?=
 =?utf-8?B?T29JNVhEanRUeXBmSUEyRVlVY3lLcGVpdVpEZ3VVcDFGSWtDbXA1dTRSbmV1?=
 =?utf-8?B?dzVza0FIUFVsRnU1SitvMmViUWk0RjhBNkRmdk5SQUdCSjR6djN4czNuRTd5?=
 =?utf-8?B?alZOQjA3c1YwTVgvSzQ5RWxNN0YrSUNTdEIxWFc3MUE0VmdQV1VQYXBJSnM0?=
 =?utf-8?B?Q1dHWWNaRzRqMEZXNmRpdGprcTZJdm40Vm1JSENBb1NnNGlEVVpGQTNFYWQr?=
 =?utf-8?B?dXc3MXVJYjMxd3o0R2VrdXFDQmFuY01jMHVzOVY2bWVlK1BudlRSMmovK0dk?=
 =?utf-8?B?WFJaOUxJU2ZFZkt3Z05PZ0d0VkNzdFdhcitqSnJXMTU2QmVwLzhaT3JPOVhS?=
 =?utf-8?B?S3IyeVJzbWZLMXNVaVpybmVkRDlZT3h5OUxJZklhNmlHeEFHY3BuUGJ3VDIv?=
 =?utf-8?B?ZFQ2alc1NmlUcDBmT3UxSTMvdUJRbWt4Uk5URXNhMm9iU3N2RXRhSUxudW92?=
 =?utf-8?B?cjgycmFwQk8zQmFISkV4RDJxekZZZ2RZdVJ4cktSU0VRUzNNZ2RwNWxyaDB3?=
 =?utf-8?B?VGEvSWlYdHpvVUxQdWQ1MmdhU29zend6dkEvbTBQajI3RldIcWtZWXlrWmdq?=
 =?utf-8?B?M2M0RUl3TXJNemhjZFFFSWFlcWJVSGRjMzdUcHUrTWNvcXp5bXBpNTM3MEFP?=
 =?utf-8?B?SWI4Qml5WGQ4TUk1TU1lS2I4cEI2bUEwR0VmQ3JsRjRCT3p4d0tqSjJrSEht?=
 =?utf-8?B?VVh4dk9BcnpWVG95dUpRUlNHd0V0T2Nmb3hMRC9XWHpHSkh3RkVoOUYzVFZW?=
 =?utf-8?B?aVZmU3A5b3U4cDNINkhaSVh5YmZqV3NFbkNsSk1YeFJzZU9RQXNHem03N3Nn?=
 =?utf-8?B?NEVtVWlIUUZmU3ArRndqa2l0djNnQnJxZUJiZ0J0T2MxZHF4NEJBaU5tbkZw?=
 =?utf-8?B?K08ydGo3czRvYm5HdHpDY0FkcGsrYkppSlB3UUN5MWpiS082NHJZWUV5Tmlm?=
 =?utf-8?B?NzIxeXdmMHFka0MyWkoxclpZZ3BZQUZYdXA4R0orbzlMbDgwSkhQV1BmTkNN?=
 =?utf-8?B?VS82R1lRalZ2NXR3UGxHOGQxT2lGRWh4Z1hTMFJKWDRwaXI1N1dmV0Q1dFBM?=
 =?utf-8?B?NjYyNGUwQ3lXdks2UWZrODVITGZQR2pORDI2bnRjVHdSamlmTVl2M2JMaDJa?=
 =?utf-8?B?bG04Vk1PMnNwOXMxM1ozYVgrSmhrdXBpekVNdGxQOHgzOHlhaEJxTG1kbmdR?=
 =?utf-8?B?UHV1VkpPOTdzd2pUYnhFZUdkZlQ0N01yOU42bGJEbXdpcFY2QWptV1VLazFS?=
 =?utf-8?B?NGwvUUxpRk5EekV5TFpDWWh5TWFvVEkvVGRoOVU0VFdBRUVMMWRtaDdTaHVk?=
 =?utf-8?B?V3owd0lHUWhlUklQUTJhVk55MFRvVzdhRDhzRVNBbmxCR3I4aHlvSmdZakVa?=
 =?utf-8?B?TXMxTmErS3R4UXo2UWpCU3RmSi9CV3ZCWUFtV0RMczFmdFErSGVwMFQvQ2R5?=
 =?utf-8?B?L2I5OUZ3aU9EVWxLOFBuTXpLNnc4SEhCTmJVZ0JZQnk1RDJtRDFYN2xoenZ3?=
 =?utf-8?B?WEJyQkNDMWJWcWhnVjErT3BXSXpVUTVKZDcwRHdQNkh2aVkwa1huUGhBZVBH?=
 =?utf-8?B?YWhveVY1a1dBVXY5VkFBZ0ZwanpaL1FMcmw1bVZxZERETFhTZHJmWjNSUFpq?=
 =?utf-8?B?bkxJTkdMVU9XWHJGRFJTYkZrKzBSQXlqeUJhSUVaOWJITHlhNG9vMForYm9k?=
 =?utf-8?Q?YahY3AFQzDt8fWSIMTQ7Keo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d1f67f-cb76-460c-3fdb-08d9b1a72bd8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2021 13:09:40.6268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QX3ewFpToZyUYeIssy9YHdJ4tfq8goXiC6Hh54NW4d2lfmBL7DlnMHKYVmEv3Tn32FN2/mTnxu/Le34ZB9WQRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5632
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git direct-xfile-mapped-buffers
head:   014cdddffcddd5b13402721de744b9ea76961d74
commit: bd7fa0e8c47bcda25664e1b2572d33a8d61d29c3 [103/333] xfs: make atomic extent swapping support realtime files
config: i386-randconfig-c001-20211031 (https://download.01.org/0day-ci/archive/20211126/202111260911.JKJz6fEX-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d321548c3ce987f4f21350ba1c81fdb5d4354224)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=bd7fa0e8c47bcda25664e1b2572d33a8d61d29c3
         git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
         git fetch --no-tags djwong-xfs direct-xfile-mapped-buffers
         git checkout bd7fa0e8c47bcda25664e1b2572d33a8d61d29c3
         # save the config file to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=i386 clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> fs/xfs/xfs_rtalloc.c:1439:17: warning: Value stored to 'off' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
            xfs_fileoff_t           off = XFS_B_TO_FSBT(mp, pos);
                                    ^~~

vim +/off +1439 fs/xfs/xfs_rtalloc.c

bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1422
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1423  /*
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1424   * For all realtime extents backing the given range of a file, search for
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1425   * unwritten mappings that are do not cover a full rt extent and convert them
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1426   * to zeroed written mappings.  The goal is to end up with one mapping per rt
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1427   * extent so that we can perform a remapping operation.  Callers must ensure
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1428   * that there are no dirty pages in the given range.
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1429   */
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1430  int
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1431  xfs_rtfile_convert_unwritten(
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1432  	struct xfs_inode	*ip,
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1433  	loff_t			pos,
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1434  	uint64_t		len)
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1435  {
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1436  	struct xfs_bmbt_irec	irec;
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1437  	struct xfs_trans	*tp;
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1438  	struct xfs_mount	*mp = ip->i_mount;
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01 @1439  	xfs_fileoff_t		off = XFS_B_TO_FSBT(mp, pos);
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1440  	xfs_fileoff_t           endoff;
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1441  	unsigned int            resblks;
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1442  	int                     ret;
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1443
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1444  	if (mp->m_sb.sb_rextsize == 1)
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1445  		return 0;
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1446
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01 @1447  	off = rounddown_64(XFS_B_TO_FSBT(mp, pos), mp->m_sb.sb_rextsize);
bd7fa0e8c47bcda Darrick J. Wong 2021-09-01  1448  	endoff = roundup_64(XFS_B_TO_FSB(mp, pos + len), mp->m_sb.sb_rextsize);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
