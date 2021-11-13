Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472DF44F3D4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 16:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbhKMPM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 10:12:58 -0500
Received: from mga06.intel.com ([134.134.136.31]:34729 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229668AbhKMPM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 10:12:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10166"; a="294090934"
X-IronPort-AV: E=Sophos;i="5.87,232,1631602800"; 
   d="gz'50?scan'50,208,50";a="294090934"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2021 07:10:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,232,1631602800"; 
   d="gz'50?scan'50,208,50";a="584339588"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Nov 2021 07:10:03 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sat, 13 Nov 2021 07:10:02 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sat, 13 Nov 2021 07:10:01 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sat, 13 Nov 2021 07:10:01 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sat, 13 Nov 2021 07:10:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVKWavP8ior2/sYt8vwBS/83BTlSCnVN7n/DxDSlnNQVYyNBfxy+8+57o80HFBuqZtE9c4tB8oKKZwqxQl4lGArVbK4XYF86x3sh4BQ4/PecSYrlOrHkBx5YlAWmFPJU1vnztnYV7BiZscBvvuiuSpqiUNcCSF9riLbc3zmCbbfMezuQ4SFJjfnRD83dh+hvcGRfEAVo/tsrpydRGAOC5dMIjNvWbhG4bhNLdj8l1TU/VPapM+y/QQqsC40STj20+fLG2AOCQdAIjKv6E9Zt/rI6Cz9ZSazulxwDNxhVCf6hboO2vkbR2Whf0KmDVNlt910szZbHUFKUT9cmhMK1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JiHiPquvXRzRP+rmhSI+/FiZW4+kl6hkesgNUEIejM=;
 b=YhUL5Ws+8xsHNUWCvMCSnvk8rSRjOL8zOeZ50x+wq5YBGGJYYAG8OhQ8DDgd1liMerYN8p547Cv1QrQs/E2uLvszDJYF3sFb1I2ZpbC3cadPN7eo2HvMMI/Et9laq4RT9EVSD9PCKrSiPsUzkjSqXnwyE1xEjztXjvano96hWYW/cZwLrhs5ZZ0RsWx7iVdVEFiP2ufkWfhkRzU+Cb6yatZB9t/stFaX19wy+C82kog1FyqVol9CnzkJepcUOQoMFMxxkYouFyzUSWjWcaogUPwDmf64cQ+ddYJSwue95qBPLJ082tjjgz1A8gh/SqgN659uN2xfr8wo2+MLHuDoXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JiHiPquvXRzRP+rmhSI+/FiZW4+kl6hkesgNUEIejM=;
 b=SodV40EZWAcmqyJDzZ2xePc3ib/4n5jckHZW1GnsFR6pb2hOnYu0QWL3Xl42vagEUv9V5TzFYCwjYrueGtt8+8FPI6S4flEj/KgsrRfd/FZ8Q61Y0be+zFTXd3I7bYVjLQeKqcOFRdd1cDoXE/i+CKmM/GC7FUYhCErNX3b0PmQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5600.namprd11.prod.outlook.com (2603:10b6:a03:3ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Sat, 13 Nov
 2021 15:09:58 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::3455:d126:2541:7723]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::3455:d126:2541:7723%2]) with mapi id 15.20.4690.019; Sat, 13 Nov 2021
 15:09:58 +0000
Content-Type: multipart/mixed; boundary="------------Z3VJ4EZgaH8uT8cuJMP5NgZP"
Message-ID: <5c6ab57d-dbd6-85e2-72fc-d74998ae15b0@intel.com>
Date:   Sat, 13 Nov 2021 23:09:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.0
Subject: [rhvgoyal:fuse-secctx 2/2] fs/fuse/dir.c:502:3: warning: Call to
 function 'strcpy' is insecure as it does not provide bounding of the memory
 buffer. Replace unbounded copy functions with analogous functions that
 support length arguments such as 'strlcpy'. CWE-119 [clang-analyzer-se...
References: <202111070845.Tc6wc56m-lkp@intel.com>
Content-Language: en-US
From:   kernel test robot <yujie.liu@intel.com>
To:     Vivek Goyal <vgoyal@redhat.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <202111070845.Tc6wc56m-lkp@intel.com>
X-Forwarded-Message-Id: <202111070845.Tc6wc56m-lkp@intel.com>
X-ClientProxiedBy: HK2PR02CA0201.apcprd02.prod.outlook.com
 (2603:1096:201:20::13) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
Received: from [10.254.209.193] (192.198.143.24) by HK2PR02CA0201.apcprd02.prod.outlook.com (2603:1096:201:20::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Sat, 13 Nov 2021 15:09:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dcbdfdd-b82e-4118-b686-08d9a6b7a841
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5600:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB560074D262B2B2F9CC2A7C74FB969@SJ0PR11MB5600.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7f+u7MoLfurYhyQ0ejFCbEc6xuerPKjMmDVu71h2xMYOJMW+bUgxNOc5gFHaNqQiXEW+AlgWkbbIhmDfV7oqIyCuEnAfp7YI+ZtUPyHg6WCKEeVWTesJGc17t0RVFEy+lE2B3f0WOUy/Shfl02Hc5YN08gMnj5AH427506bWu6tshrcP+i2hMpB46u7IIdoNARIJGpsAxf1sYyt6tihb2S+qO7+jvbNOGAzsu9/xjbMFXikKk/M82CaW68GShxrEi5qyKQaurCQN/iQh7RcMPNCQtc1GmhJXJsqEhV2ksTzGQNA1PkC/3yoHSWtEh5USW+NRd0ay7fRN1hUZ7RHS3c30ct0IoOFY967vg3reAwVkSgM5ZsXrABZEyFMTo2yAdqdwJonJZH6QctBIBOk/GQ2ltv3qp9ODBiXMnkKAomFosV/z4NnVrAY0B03xwV49vjZQuymYWEZen1b3p2vW+a77rm+2FpS2mfvIJfh4wjSWbQ0CyUNB4Xd/iyQB5D0GLvKwMhxoNjTPHhi4B2b7p48gvHlvadr000AcGoEM4tPyXoI+zRjDP40cfRRgB4qOnp4/UC8uwVLOy/USH52VNAizxT9NhVNp6duAPSKprvszZaEoMCL5czXWhmsiKuXkv44pHwfZbzxEHwH3AgEAcWidxX+zhtrwjWAq5Mtq55bI7a6Vpq7oF1x07yaEf8Tc4lvLZq7DXY/+0yevc6ANoj4QE02PyZpKjGKkH+2q0s2FfUuPyPGSa/dElJomIlgCuTM2txlu8RCeUTAAK/u8VQhFFWV63Fci7HAlLqH7Zv5Kb8Mxjrsrk6r7VIF9lKiH1bVsJJUNdoqzM8rh/Grp5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(8676002)(508600001)(6916009)(66556008)(66946007)(33964004)(36756003)(5660300002)(4326008)(956004)(8936002)(966005)(2616005)(82960400001)(26005)(31696002)(186003)(2906002)(86362001)(235185007)(316002)(38100700002)(83380400001)(16576012)(66476007)(31686004)(6486002)(219693004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWVWdWNXMGhoblVkNi85NEtib0NnTzcvSGV3Tzh5R3N4MzNYK2I5TnVrRFJp?=
 =?utf-8?B?NXdvRnR5S0VNZnZ5VlYyV3lUL252RWQrN1BFNFM4TjlWZFNqeVpYNm44WXor?=
 =?utf-8?B?WVZ2MVZmK1I1WVdFeGN3V3FrV3NNYXMvMCtMZmNCRW5HT1V6Q0ltMllpZ2VO?=
 =?utf-8?B?RmxCL095MFZUV0RrUWkyRi9laU1HbU4zZWtWRGIzZ2s4WTc0V1Buakkwb1hs?=
 =?utf-8?B?aGxpRU9VK0RpeHgvR1QxSWlzT2hSaW9SN2FMUjczZVJFckE0dU0zNmhIbGlm?=
 =?utf-8?B?cUUzUkhCUVQvTnFFeVZSRDZVNjdrTDVVd2VKRHpFNGxNcjVUSEE1dHpBWVhN?=
 =?utf-8?B?ZnphY0pFaUg3cGJKazJGaXJOOVl6MmM3L1hidlFtUlBydEpYS1VuZ2hNcjFi?=
 =?utf-8?B?K3RNV3N5eWRkRXc3WlM0VXRvRHRsVHUveGl6NWE4OUIzM0NYYWJXd2JZeUVZ?=
 =?utf-8?B?UWRDSm44MjBKVGIyNDdneENjcXkyNDNZNk1XUzcrT2dkVExPQzVOUytHZnlm?=
 =?utf-8?B?RHBlVzlzMk9xcEt2M2JLTVh6Q0VVZFI3bExNTHBJUUJaRFBWQllKWW1KUkta?=
 =?utf-8?B?UnFGS01odlE1Z0UyUnVjUWVwWS9HbEdnbTkxNk5mSmRSaU9GN2o2TUdHcHlq?=
 =?utf-8?B?N3RrSUVyWWgvTlg2bFdqNjJaNnhseFlWa1k5RGJ1V0FQTlk4cW9DMnpZRzNo?=
 =?utf-8?B?R0lKaHRVSzhpNDJsejNQZWhqWGJwTXp5ZUpmYThwbjZKWTgvcGZpODJxRmxY?=
 =?utf-8?B?S1lmVlg3QjJ1Mk5VTiszWk9Uck9ydFl4dDgyaXlaaGUydDNmS08vUllYOVdR?=
 =?utf-8?B?VURwVnkvV3pSb0toR2FDV0VONnRjSkNNeXdYZW9FNDRnR1RNR2Y3cFBENCs0?=
 =?utf-8?B?bXBTSzFRMGdjS1JTSDl0eVd2dnUzRXlha1BOcFRqN0I1cnZQVUQ1YWRuNTJJ?=
 =?utf-8?B?dTBTay9MdG1HeDF4OVNhTG0rR0tDYlJtZUk4VXpycVRRK1BFZVNEaUVyaFVD?=
 =?utf-8?B?dVZsS0JLMjFodlBvdW5HVGlNbTIrbUx3WGcyNFVQQWRRT0tNWVkxcjlEUzAx?=
 =?utf-8?B?YWoxaWVQeXJuT0hINXNyQm01MllBWnlIc3lQdmVtajI0Z2dpK3MwMW5jeFFT?=
 =?utf-8?B?V2NZbkVwcTVRUnFPTzBmc015WEtrdlBQeERkTlgwUmYrdXFwSmkwalVUSjdh?=
 =?utf-8?B?azVoVG9PNGkwR1Fpai9TdXUwMjNwakhsdnQydGFlVFdNOG1iMmlFcEw1bDdF?=
 =?utf-8?B?Nm5PUmsvcWhZYlY1UHVPV1BFcFVQNzQ1WGtKdFRDOWdoRllmK1NwbWR3b0pu?=
 =?utf-8?B?WU1LNDg1N0hXT21hM3NjekFBemlHNW9OOTVVUVJ6ZnIrOFVzSjlrc2RnY2Ft?=
 =?utf-8?B?c1RvWmVYNjUxNWxGQkVqbTJLM05pMjVweFNUN3YwTkVkeVJoV1RDM1h3YTRH?=
 =?utf-8?B?QytCQVJja1E1Ylc3VHBac3lEamw2YTdjNXpXOG0yN2liN3hHYUIxVitLaE9j?=
 =?utf-8?B?aXVFR1VDMVRrU3E5T3FlSldTR0FXc1Q4VWZyLzJZRG5xWFVVTHZQcFJ3b0JH?=
 =?utf-8?B?c0pQdG84U0NTL245aXR0WHBkbkRkREJNbCtkbWxFbUNmSUlGOXlPL1FVdVFw?=
 =?utf-8?B?SGhLTzJka1FqODhidFhscjVmN0orRXJWQ2NtYkRKeDJTUFYyS3E5L0Y4L1Bt?=
 =?utf-8?B?RlQ3THBFVStGQ3dWSlRQb21IeFJLdkd3YXJtbkNzWVE4UVp3TGpNbmRjdmNP?=
 =?utf-8?B?eTIrZ0ZmL1kzMDFCUit4NHRTSzZHZWhBTS96amhVQ242ZHBYQ1FkbnZ2czFq?=
 =?utf-8?B?VDNlRzFLVGxsSTE3NEVLUmJRazBzclFTN0xLa1BtQUJjZ2FLVnFyYklRMUZH?=
 =?utf-8?B?QlFTc0w3S0MzNzljL3lhdVZ4WHVkc1NPMjI4OWJoeDdSNWhlUzd2N0pFeWNS?=
 =?utf-8?B?NHBtS04yZ2FPdHpaTlA4Z0ZNd1daMzNVcnlkdHV4RnE2TDJOOFl1ZFBRQ09m?=
 =?utf-8?B?Tk8yMXFYSDlEc0Y4OHZGOGorOWxQdEFQK05PUFIxRVRYTHVzR1ZpQVdKM0RY?=
 =?utf-8?B?OUM5SGJubHlhTkVkOWlZODdXdnlpSkVTNTh5MUdLb0ZEeEpveHY3d1pjUnZj?=
 =?utf-8?B?cy9JanZuNnlPN01uOUN3YWJqSTdHVWZFR1p3OTIrS2NGejBtVkN4UFN4RXdu?=
 =?utf-8?Q?G+/f/vvJ+RsZX81ECp28bbE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dcbdfdd-b82e-4118-b686-08d9a6b7a841
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2021 15:09:58.4747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ht6FEle3dTjpHsySkSXT+UJvUGPPxCJlL8sYroDuzUCRAFeMsUiMCbqotgAPlWrVHWTDEtb3SPGyHKNmV3poWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5600
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------Z3VJ4EZgaH8uT8cuJMP5NgZP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

tree:   https://github.com/rhvgoyal/linux fuse-secctx
head:   6df7ad1315eb0cf5fec0a2efc1a35743052f3087
commit: 6df7ad1315eb0cf5fec0a2efc1a35743052f3087 [2/2] fuse: Send security context of inode on file creation
config: riscv-randconfig-c006-20210930 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 28981015526f2192440c18f18e8a20cd11b0779c)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # install riscv cross compiling tool for clang build
         # apt-get install binutils-riscv64-linux-gnu
         # https://github.com/rhvgoyal/linux/commit/6df7ad1315eb0cf5fec0a2efc1a35743052f3087
         git remote add rhvgoyal https://github.com/rhvgoyal/linux
         git fetch --no-tags rhvgoyal fuse-secctx
         git checkout 6df7ad1315eb0cf5fec0a2efc1a35743052f3087
         # save the attached .config to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> fs/fuse/dir.c:502:3: warning: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
                    strcpy(ptr, name);
                    ^~~~~~

 >> fs/fuse/dir.c:772:2: warning: Address of stack memory associated with local variable 'outarg' is still referred to by the stack variable 'args' upon returning to the caller.  This will be a dangling reference [clang-analyzer-core.StackAddressEscape]
            return err;
            ^


vim +502 fs/fuse/dir.c

e5e5558e923f35 Miklos Szeredi 2005-09-09  461
6df7ad1315eb0c Vivek Goyal    2021-09-24  462  static int get_security_context(struct dentry *entry, umode_t mode,
6df7ad1315eb0c Vivek Goyal    2021-09-24  463  				void **security_ctx, u32 *security_ctxlen)
6df7ad1315eb0c Vivek Goyal    2021-09-24  464  {
6df7ad1315eb0c Vivek Goyal    2021-09-24  465  	struct fuse_secctx *fsecctx;
6df7ad1315eb0c Vivek Goyal    2021-09-24  466  	void *ctx, *full_ctx;
6df7ad1315eb0c Vivek Goyal    2021-09-24  467  	u32 ctxlen, full_ctxlen;
6df7ad1315eb0c Vivek Goyal    2021-09-24  468  	int err = 0;
6df7ad1315eb0c Vivek Goyal    2021-09-24  469
6df7ad1315eb0c Vivek Goyal    2021-09-24  470  	err = security_dentry_init_security(entry, mode, &entry->d_name, &ctx,
6df7ad1315eb0c Vivek Goyal    2021-09-24  471  					    &ctxlen);
6df7ad1315eb0c Vivek Goyal    2021-09-24  472  	if (err) {
6df7ad1315eb0c Vivek Goyal    2021-09-24  473  		if (err != -EOPNOTSUPP)
6df7ad1315eb0c Vivek Goyal    2021-09-24  474  			goto out_err;
6df7ad1315eb0c Vivek Goyal    2021-09-24  475  		/* No LSM is supporting this security hook. Ignore error */
6df7ad1315eb0c Vivek Goyal    2021-09-24  476  		err = 0;
6df7ad1315eb0c Vivek Goyal    2021-09-24  477  		ctxlen = 0;
6df7ad1315eb0c Vivek Goyal    2021-09-24  478  	}
6df7ad1315eb0c Vivek Goyal    2021-09-24  479
6df7ad1315eb0c Vivek Goyal    2021-09-24  480  	if (ctxlen > 0) {
6df7ad1315eb0c Vivek Goyal    2021-09-24  481  		/*
6df7ad1315eb0c Vivek Goyal    2021-09-24  482  		 * security_dentry_init_security() does not return the name
6df7ad1315eb0c Vivek Goyal    2021-09-24  483  		 * of lsm or xattr to which label belongs. As of now only
6df7ad1315eb0c Vivek Goyal    2021-09-24  484  		 * selinux implements this. Hence, hardcoding the name to
6df7ad1315eb0c Vivek Goyal    2021-09-24  485  		 * security.selinux.
6df7ad1315eb0c Vivek Goyal    2021-09-24  486  		 */
6df7ad1315eb0c Vivek Goyal    2021-09-24  487  		char *name = "security.selinux";
6df7ad1315eb0c Vivek Goyal    2021-09-24  488  		void *ptr;
6df7ad1315eb0c Vivek Goyal    2021-09-24  489
6df7ad1315eb0c Vivek Goyal    2021-09-24  490  		full_ctxlen = sizeof(*fsecctx) + strlen(name) + ctxlen + 1;
6df7ad1315eb0c Vivek Goyal    2021-09-24  491  		full_ctx = kzalloc(full_ctxlen, GFP_KERNEL);
6df7ad1315eb0c Vivek Goyal    2021-09-24  492  		if (!full_ctx) {
6df7ad1315eb0c Vivek Goyal    2021-09-24  493  			err = -ENOMEM;
6df7ad1315eb0c Vivek Goyal    2021-09-24  494  			kfree(ctx);
6df7ad1315eb0c Vivek Goyal    2021-09-24  495  			goto out_err;
6df7ad1315eb0c Vivek Goyal    2021-09-24  496  		}
6df7ad1315eb0c Vivek Goyal    2021-09-24  497
6df7ad1315eb0c Vivek Goyal    2021-09-24  498  		ptr = full_ctx;
6df7ad1315eb0c Vivek Goyal    2021-09-24  499  		fsecctx = (struct fuse_secctx*) ptr;
6df7ad1315eb0c Vivek Goyal    2021-09-24  500  		fsecctx->size = ctxlen;
6df7ad1315eb0c Vivek Goyal    2021-09-24  501  		ptr += sizeof(*fsecctx);
6df7ad1315eb0c Vivek Goyal    2021-09-24 @502  		strcpy(ptr, name);
6df7ad1315eb0c Vivek Goyal    2021-09-24  503  		ptr += strlen(name) + 1;
6df7ad1315eb0c Vivek Goyal    2021-09-24  504  		memcpy(ptr, ctx, ctxlen);
6df7ad1315eb0c Vivek Goyal    2021-09-24  505  		kfree(ctx);
6df7ad1315eb0c Vivek Goyal    2021-09-24  506  	} else {
6df7ad1315eb0c Vivek Goyal    2021-09-24  507  		full_ctxlen = sizeof(*fsecctx);
6df7ad1315eb0c Vivek Goyal    2021-09-24  508  		full_ctx = kzalloc(full_ctxlen, GFP_KERNEL);
6df7ad1315eb0c Vivek Goyal    2021-09-24  509  		if (!full_ctx) {
6df7ad1315eb0c Vivek Goyal    2021-09-24  510  			err = -ENOMEM;
6df7ad1315eb0c Vivek Goyal    2021-09-24  511  			goto out_err;
6df7ad1315eb0c Vivek Goyal    2021-09-24  512  		}
6df7ad1315eb0c Vivek Goyal    2021-09-24  513  	}
6df7ad1315eb0c Vivek Goyal    2021-09-24  514
6df7ad1315eb0c Vivek Goyal    2021-09-24  515  	*security_ctxlen = full_ctxlen;
6df7ad1315eb0c Vivek Goyal    2021-09-24  516  	*security_ctx = full_ctx;
6df7ad1315eb0c Vivek Goyal    2021-09-24  517  out_err:
6df7ad1315eb0c Vivek Goyal    2021-09-24  518  	return err;
6df7ad1315eb0c Vivek Goyal    2021-09-24  519  }
6df7ad1315eb0c Vivek Goyal    2021-09-24  520

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
--------------Z3VJ4EZgaH8uT8cuJMP5NgZP
Content-Type: application/gzip; name=".config.gz"
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--------------Z3VJ4EZgaH8uT8cuJMP5NgZP--
