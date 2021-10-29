Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1FC43F7BF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 09:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhJ2HTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 03:19:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:60559 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232091AbhJ2HT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 03:19:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="316808175"
X-IronPort-AV: E=Sophos;i="5.87,191,1631602800"; 
   d="gz'50?scan'50,208,50";a="316808175"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 00:16:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,191,1631602800"; 
   d="gz'50?scan'50,208,50";a="448281993"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga003.jf.intel.com with ESMTP; 29 Oct 2021 00:16:49 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 29 Oct 2021 00:16:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 29 Oct 2021 00:16:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 29 Oct 2021 00:16:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doKLwq0BslVmFoSrNHaYJ8xy2hXRbC+1II+Kr7c2nkQM/UeCv0Qwzj3oNA2Dfi2BCHU0jtKZb1xrAYqJMsROhZyKK7aUl3BSOKMe3lRyqcB2LFaAQv0giW6vbDEggTI/ZF2YopE1RFSs6tGUEfJQjiPgx4tiz1tybBNuyq42qkO0ixQN5ZGd9/YO0KMEyKsPwoVhqOm3WzAnYz/Q4PFDSpX4trtskc+U2k7UnZj56FZX22MXdF+VJz3akj3LdATmdcGZwT1efCBUs8h+mPOlwwmfJp+S2HU6HLJd8koQbqgH+bDUOHyfTKhdhJWonEa4F/tf0Wmwm5zc47LX4dYPlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q65U5y0gqIz49ieALmPv7RIsnuPq+dp0+hckLkv7p6o=;
 b=SzIraH2G2N3ydSSLMhhrNk3SkaxU+hDHTi6jOJlCnEv6yiU6Kf5/j/oelAY7J2xse5qqm6sfbLqVBZRLecWv72UmNPw1f0vfqozcSYIGfgUhBM+cEODgHX78iHj6IexFdWybljdLUgOqv0oIQZJMwqGuLW0to+gg23fSet2ED8GZDvW2UquFhZq6H4wnL0Ai4P6Sz6La+eVA3yrVLvii2I2K3QTWnAr5u6O71ukfZP207dQwlSwMH91lOl62pJ2KKdqHpKKkqZM4PnKRn3S3aLCWPxLg92irZ5tryCzqj//ecS/cgiPBd4zN3auFF7840133bpJ682RTa/Pwpp88Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q65U5y0gqIz49ieALmPv7RIsnuPq+dp0+hckLkv7p6o=;
 b=DlVu5a4zQ4jVuH1pRs9LpBUNuaQJend7MfTwktgdF1cz8GAWIpO/pzwPWQ/wFHVwQe9GoflbSHSLH5zxKaeuV2SKdbwS2JLj1QT3+ICn1+/0K15d+xjt9NODJgfuuZXkzbtRRy0kNnUKzLjL8KMtEQgIzNZtFnHQGap8iCizha8=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5662.namprd11.prod.outlook.com (2603:10b6:a03:3af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 07:16:45 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::3455:d126:2541:7723]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::3455:d126:2541:7723%2]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 07:16:45 +0000
Content-Type: multipart/mixed; boundary="------------2u072XF93olOwK70H4Wi8Gzf"
Message-ID: <b4214bce-eb3c-981f-e8bc-2e6d08a84580@intel.com>
Date:   Fri, 29 Oct 2021 15:16:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.2.1
Subject: [osandov:btrfs-send-encoded 9/14] fs/btrfs/ioctl.c:4959:15: warning:
 Assigned value is garbage or undefined
 [clang-analyzer-core.uninitialized.Assign]
References: <202110291210.vdIJspdr-lkp@intel.com>
Content-Language: en-US
To:     Omar Sandoval <osandov@fb.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        Omar Sandoval <osandov@osandov.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202110291210.vdIJspdr-lkp@intel.com>
X-Forwarded-Message-Id: <202110291210.vdIJspdr-lkp@intel.com>
X-ClientProxiedBy: HK2PR02CA0190.apcprd02.prod.outlook.com
 (2603:1096:201:21::26) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
Received: from [10.238.2.77] (192.198.142.18) by HK2PR02CA0190.apcprd02.prod.outlook.com (2603:1096:201:21::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 07:16:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9bc3357-576a-4a3b-2c17-08d99aac1071
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5662:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5662B54ACC81F9968D8A6A74FB879@SJ0PR11MB5662.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +YvUVFk/zgotSDkr57fcPT5E51YWxVil1fAi16FtW6FNJ8suHAuoiaNFoqULXqNxZhe0SQYrp4/OV/hgTdG6Db9UYjrOIn1T32g2zZIthMwYB6ni9n5CNzF2bv8p5iZRTXiW8p1nqkF/xIUrsZo4z4UCGjoqTLgxFlHycvPnfypeAOEASswifuUqtd15ibJ6c2yu3jQvuPLxRBxVRCRw5RMDyjZ6bMgDdYToSTHq+CVi57m+WkCL/chGHivYUYfajTP3YNh2ePBCUdCTJrYjRXOijlPfZrVQa9QgmMyYQ/k7qipolabc/iC5Vyn+38PsOZQl+kRlJwkB0jjqk7njdIVvHq9ECExNC3tmEqVuO4ZA8gCtZ14vD8V6s0C+5JbEEg62aLEFYSjo35dw6F+5RRwf6NDHi83zyIXn565u3K5qcBjUAUKSdqfIOaycIvi98+hIfH8luQhk4SsKjhB+Gpj/HdyKmw7LB91x2rU0zkAhvKr3mr97Qpui7xaqulceSnzNK5glbtSSWzmjfC7Mnxp+EP8rSg2Ts3c8YR/thKBBfXCXKY0xkcwIpyIHRurPJ8Fe+xkoDkyuLaZaKgcnVyoLy7SPdGzUcQGgVSk9IrAgnZqvN4Xazl+qsKPLPjW2vwtVbUIC+sX3xMO0bMN6XSM1CxRbLnAeRWVPeSPDPZdU+apt3j2mhh35te9eHj2wMZJWcG3Z141hQ0Mh8/O/EpjYVuOzJMWuLgT2vwwo/xnNEfrPhl/0uk4jOXEzdyspjOEp4W5Dh8clN6w+rJLzN7yIitTzHpNZMPjv4QFJorI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(16576012)(966005)(235185007)(82960400001)(26005)(33964004)(508600001)(316002)(86362001)(2906002)(31696002)(83380400001)(6916009)(38100700002)(956004)(5660300002)(8676002)(8936002)(2616005)(36756003)(66946007)(66556008)(66476007)(54906003)(186003)(4326008)(31686004)(6666004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3NKdkJ4VFFuZTUySVlVN09SMG82VmZ4S0NYajdXTk9mSW8xUXd3TnFBT0M5?=
 =?utf-8?B?bWdRdWJ2VXorNGRLUzQrN0VUMW03MWIxTWtGWStsUGhTM2IyRzJIV2poQW1s?=
 =?utf-8?B?VmlPNHlNM3ZMVFQyVnhNVVZRSi9MUXlhKzJxaFdQMTFLMFlRZVAvQmxjbjli?=
 =?utf-8?B?WTE3Y0QzRzc1RnVTcFQ0YUlxcUtzdU5vRlI0MFRXaHFxbGRJMWJEeFBkbG9q?=
 =?utf-8?B?RTZyMklyYkJFc1BKblBvK1M0RDlNRDZ6MFFJQXVsTE1kd3BxekVlTkZDWEdC?=
 =?utf-8?B?U013a3FyZW1LWnNKWjlmVmpjeHpscUF0Y2M5OTI1b05zNnlyYXFBNCtJY1Jq?=
 =?utf-8?B?bFlCRkExQTZaOENEendFWGovM1hzcHBsSXB0cnlpQTJUNU8zaGtwQ0liN3Uv?=
 =?utf-8?B?WUdPamF2MjZ1clR0akh5OHFwc0JKL3JZZzEvSDBadHpxQ2dndTJZYTVtdDU0?=
 =?utf-8?B?eXZyL1hkdGt4Sk1ORnFVU0l2VzdhdXhoUko0Y2VVUXBDVjF5QjMrZjN0NDhJ?=
 =?utf-8?B?c25VbUw3MFdEKzJXaTZRMVhNQ0FGUXpDTVFiUk9SWnNwbVVzR3k1Nm9xRS93?=
 =?utf-8?B?V0tVS3IvTHFVVjEvVWV1czYzM2dPeHlLRUN1VXBLcG56eDFIY0pKdUVsY2NV?=
 =?utf-8?B?ZGhCWVJCbGQxbWh6bGRuYnBVR28ydTN1RkQyTWpGYlN1WWRCU1loRUNpT1FS?=
 =?utf-8?B?ZnkyVzRwL3cwZkdNOU1oSHEyOVZWU3VJWW9ZYXp0RFh5Z096dTQxMFhzeUlm?=
 =?utf-8?B?R3hOMjU1aDc1cHFVaVJEalRzYmZjMTgwUDlwOGxkbEd6aWUrUGYvTGVzd1hL?=
 =?utf-8?B?bUpOU1J3dWtiOVl3aUpka0FzcHBHWWFhSjJrMnFqRXdQVEQxSWFacXliak1v?=
 =?utf-8?B?OXJjK0FRekNrUEZEb3Fia2NQbUQ1N254OU85SkY3dWNRWi9HQW1pc0VOQ1I0?=
 =?utf-8?B?bjBWbGYyd0thTFFnNWFSbTNDNXZoOUVXdElnN2tKUmhMbVU4WGJtbCtXL2lE?=
 =?utf-8?B?NHI4NUNSbWQ2ZVlCSHZOK0h3dXFZdFE5eXE5MmZ2bWVqMnR5Q1BWeU91QTI0?=
 =?utf-8?B?NmVobS9hNjBmaXJEdlJtZHJlNy9PcDlEeDBmRzYxUHZrNnZzWjA5Z1I4eUMz?=
 =?utf-8?B?T3BxMm04SXFnNVdJN1dZa2hsaEc3czc0NmU1YmVITGxnQVNMbkZDaFJaeW5T?=
 =?utf-8?B?MXNhUklnc1d3aUpCam95Y2JhUFE4NEdkZEcxbXZUQkwwVkRyUGFuVzFRY0Fn?=
 =?utf-8?B?b1g2MU1aN3gvMW5EMW84MEdBeGU0dHRyTS9EV0ZwMVRwZUZGNzJpZnd4eDI0?=
 =?utf-8?B?Sm5DTkk0eTR5aEJLenhuVU9UaHMvMXpOKytIaStMb3M3bnIrNEVPZ1FOT1lx?=
 =?utf-8?B?RWlKdGtqWWZrclBhWlB0NmlDUStBNGJiSldtcEFxR1RqaTAxYmg2Z0E0RFMx?=
 =?utf-8?B?cjA3dDh3bEN6aFRRNUR3SjJIaFJ6MnZPMHhFak9iS0JJQmk2YkM3SmtzTVBp?=
 =?utf-8?B?N1BLUnF6ZzFTYVBxK0xlWTNtT0o3cUNzN0RmNjlsTFlsWWdOV1k4VWNCNnds?=
 =?utf-8?B?SFlvdEtqVStkcEh4ZTV4eHRpUE9NalRiN2NBQlc2NG95RnhObnQxMWZ3MXdu?=
 =?utf-8?B?Y1VLK0hOREhJT3hHZ3EwL3hDeGhnWWVXcnFEUS9pNytSbTlkT05nS2hoMTFq?=
 =?utf-8?B?Vm4vSkhpL1QzMExQWHBVT01adzZKemtNYlh5VEdlNXczdHdmajgxYWczbzln?=
 =?utf-8?B?b1Y5dURINXJ4WGdZeGMvaTlRbFpTazJiL3NaeW8rNTYxVjdKajVob2ZHTTVO?=
 =?utf-8?B?VS9ZSmZSK3Q3L3NZNEovN0Y2SVMwN1h5akJGUEx5YnNDbU1WUkgwVGlNWlY2?=
 =?utf-8?B?QVp5WE5WbWxZMHY2K2RyZHRNYnQzSFh0T3B4Q1RjcW5zTnFtYVdzdFA5TEtl?=
 =?utf-8?B?b2hTb0tPRWFOM1haTW45WVhHYWJTMFovRUk3Wi9yVHFiRWU0MnZ3aG92bnVU?=
 =?utf-8?B?OW5UajZoUGJlNCsrNEIyNW5wNUJQZlB6L2RyVmdWRlN0MHlhZGFIMWtKeWVt?=
 =?utf-8?B?aytQdm5heHY4ZnNPUlFTSUcybTJhWnN4MlYwM3hRYXYzTTRxd0RoOU1IZUJI?=
 =?utf-8?B?cGRCSTRqdXVXYmhQdnFNT0gwbEVseHNENUcxQWpQNTQ4UkZpVE1tYUExZ0FU?=
 =?utf-8?Q?/qZeMyCFFTVfZmiJrrn+AQ8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9bc3357-576a-4a3b-2c17-08d99aac1071
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 07:16:45.6305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xv+0haKbnalgI9A7768n53kcXfa54K2vEXsdG8aUyL+6KFnPOvqKmOLZTzRxhDbHgAb0ERDD4Srww998PAiJyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5662
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------2u072XF93olOwK70H4Wi8Gzf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

tree:   https://github.com/osandov/linux.git btrfs-send-encoded
head:   b460af84b8ddd4fd78e02fec6272b70326b87861
commit: 0aea17a6398e5a7ecab69537ff062b00f6b9c20f [9/14] btrfs: add BTRFS_IOC_ENCODED_WRITE
config: x86_64-randconfig-c007-20211027 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5db7568a6a1fcb408eb8988abdaff2a225a8eb72)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # https://github.com/osandov/linux/commit/0aea17a6398e5a7ecab69537ff062b00f6b9c20f
         git remote add osandov https://github.com/osandov/linux.git
         git fetch --no-tags osandov btrfs-send-encoded
         git checkout 0aea17a6398e5a7ecab69537ff062b00f6b9c20f
         # save the attached .config to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> fs/btrfs/ioctl.c:4959:15: warning: Assigned value is garbage or undefined [clang-analyzer-core.uninitialized.Assign]
                    args.iovcnt = args.iovcnt;
                                ^

vim +4959 fs/btrfs/ioctl.c

d38f9ac9a40338 Omar Sandoval 2019-10-09  4928
0aea17a6398e5a Omar Sandoval 2019-08-13  4929  static int btrfs_ioctl_encoded_write(struct file *file, void __user *argp,
0aea17a6398e5a Omar Sandoval 2019-08-13  4930  				     bool compat)
0aea17a6398e5a Omar Sandoval 2019-08-13  4931  {
0aea17a6398e5a Omar Sandoval 2019-08-13  4932  	struct btrfs_ioctl_encoded_io_args args;
0aea17a6398e5a Omar Sandoval 2019-08-13  4933  	struct iovec iovstack[UIO_FASTIOV];
0aea17a6398e5a Omar Sandoval 2019-08-13  4934  	struct iovec *iov = iovstack;
0aea17a6398e5a Omar Sandoval 2019-08-13  4935  	struct iov_iter iter;
0aea17a6398e5a Omar Sandoval 2019-08-13  4936  	loff_t pos;
0aea17a6398e5a Omar Sandoval 2019-08-13  4937  	struct kiocb kiocb;
0aea17a6398e5a Omar Sandoval 2019-08-13  4938  	ssize_t ret;
0aea17a6398e5a Omar Sandoval 2019-08-13  4939
0aea17a6398e5a Omar Sandoval 2019-08-13  4940  	if (!capable(CAP_SYS_ADMIN)) {
0aea17a6398e5a Omar Sandoval 2019-08-13  4941  		ret = -EPERM;
0aea17a6398e5a Omar Sandoval 2019-08-13  4942  		goto out_acct;
0aea17a6398e5a Omar Sandoval 2019-08-13  4943  	}
0aea17a6398e5a Omar Sandoval 2019-08-13  4944
0aea17a6398e5a Omar Sandoval 2019-08-13  4945  	if (!(file->f_mode & FMODE_WRITE)) {
0aea17a6398e5a Omar Sandoval 2019-08-13  4946  		ret = -EBADF;
0aea17a6398e5a Omar Sandoval 2019-08-13  4947  		goto out_acct;
0aea17a6398e5a Omar Sandoval 2019-08-13  4948  	}
0aea17a6398e5a Omar Sandoval 2019-08-13  4949
0aea17a6398e5a Omar Sandoval 2019-08-13  4950  	if (compat) {
0aea17a6398e5a Omar Sandoval 2019-08-13  4951  #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
0aea17a6398e5a Omar Sandoval 2019-08-13  4952  		struct btrfs_ioctl_encoded_io_args_32 args32;
0aea17a6398e5a Omar Sandoval 2019-08-13  4953
0aea17a6398e5a Omar Sandoval 2019-08-13  4954  		if (copy_from_user(&args32, argp, sizeof(args32))) {
0aea17a6398e5a Omar Sandoval 2019-08-13  4955  			ret = -EFAULT;
0aea17a6398e5a Omar Sandoval 2019-08-13  4956  			goto out_acct;
0aea17a6398e5a Omar Sandoval 2019-08-13  4957  		}
0aea17a6398e5a Omar Sandoval 2019-08-13  4958  		args.iov = compat_ptr(args32.iov);
0aea17a6398e5a Omar Sandoval 2019-08-13 @4959  		args.iovcnt = args.iovcnt;
0aea17a6398e5a Omar Sandoval 2019-08-13  4960  		memcpy(&args.offset, &args32.offset,
0aea17a6398e5a Omar Sandoval 2019-08-13  4961  		       sizeof(args) -
0aea17a6398e5a Omar Sandoval 2019-08-13  4962  		       offsetof(struct btrfs_ioctl_encoded_io_args, offset));
0aea17a6398e5a Omar Sandoval 2019-08-13  4963  #else
0aea17a6398e5a Omar Sandoval 2019-08-13  4964  		return -ENOTTY;
0aea17a6398e5a Omar Sandoval 2019-08-13  4965  #endif
0aea17a6398e5a Omar Sandoval 2019-08-13  4966  	} else {
0aea17a6398e5a Omar Sandoval 2019-08-13  4967  		if (copy_from_user(&args, argp, sizeof(args))) {
0aea17a6398e5a Omar Sandoval 2019-08-13  4968  			ret = -EFAULT;
0aea17a6398e5a Omar Sandoval 2019-08-13  4969  			goto out_acct;
0aea17a6398e5a Omar Sandoval 2019-08-13  4970  		}
0aea17a6398e5a Omar Sandoval 2019-08-13  4971  	}
0aea17a6398e5a Omar Sandoval 2019-08-13  4972
0aea17a6398e5a Omar Sandoval 2019-08-13  4973  	ret = -EINVAL;
0aea17a6398e5a Omar Sandoval 2019-08-13  4974  	if (args.flags != 0)
0aea17a6398e5a Omar Sandoval 2019-08-13  4975  		goto out_acct;
0aea17a6398e5a Omar Sandoval 2019-08-13  4976  	if (memchr_inv(args.reserved, 0, sizeof(args.reserved)))
0aea17a6398e5a Omar Sandoval 2019-08-13  4977  		goto out_acct;
0aea17a6398e5a Omar Sandoval 2019-08-13  4978  	if (args.compression == BTRFS_ENCODED_IO_COMPRESSION_NONE &&
0aea17a6398e5a Omar Sandoval 2019-08-13  4979  	    args.encryption == BTRFS_ENCODED_IO_ENCRYPTION_NONE)
0aea17a6398e5a Omar Sandoval 2019-08-13  4980  		goto out_acct;
0aea17a6398e5a Omar Sandoval 2019-08-13  4981  	if (args.compression >= BTRFS_ENCODED_IO_COMPRESSION_TYPES ||
0aea17a6398e5a Omar Sandoval 2019-08-13  4982  	    args.encryption >= BTRFS_ENCODED_IO_ENCRYPTION_TYPES)
0aea17a6398e5a Omar Sandoval 2019-08-13  4983  		goto out_acct;
0aea17a6398e5a Omar Sandoval 2019-08-13  4984  	if (args.unencoded_offset > args.unencoded_len)
0aea17a6398e5a Omar Sandoval 2019-08-13  4985  		goto out_acct;
0aea17a6398e5a Omar Sandoval 2019-08-13  4986  	if (args.len > args.unencoded_len - args.unencoded_offset)
0aea17a6398e5a Omar Sandoval 2019-08-13  4987  		goto out_acct;
0aea17a6398e5a Omar Sandoval 2019-08-13  4988
0aea17a6398e5a Omar Sandoval 2019-08-13  4989  	ret = import_iovec(WRITE, args.iov, args.iovcnt, ARRAY_SIZE(iovstack),
0aea17a6398e5a Omar Sandoval 2019-08-13  4990  			   &iov, &iter);
0aea17a6398e5a Omar Sandoval 2019-08-13  4991  	if (ret < 0)
0aea17a6398e5a Omar Sandoval 2019-08-13  4992  		goto out_acct;
0aea17a6398e5a Omar Sandoval 2019-08-13  4993
0aea17a6398e5a Omar Sandoval 2019-08-13  4994  	file_start_write(file);
0aea17a6398e5a Omar Sandoval 2019-08-13  4995
0aea17a6398e5a Omar Sandoval 2019-08-13  4996  	if (iov_iter_count(&iter) == 0) {
0aea17a6398e5a Omar Sandoval 2019-08-13  4997  		ret = 0;
0aea17a6398e5a Omar Sandoval 2019-08-13  4998  		goto out_end_write;
0aea17a6398e5a Omar Sandoval 2019-08-13  4999  	}
0aea17a6398e5a Omar Sandoval 2019-08-13  5000  	pos = args.offset;
0aea17a6398e5a Omar Sandoval 2019-08-13  5001  	ret = rw_verify_area(WRITE, file, &pos, args.len);
0aea17a6398e5a Omar Sandoval 2019-08-13  5002  	if (ret < 0)
0aea17a6398e5a Omar Sandoval 2019-08-13  5003  		goto out_end_write;
0aea17a6398e5a Omar Sandoval 2019-08-13  5004
0aea17a6398e5a Omar Sandoval 2019-08-13  5005  	init_sync_kiocb(&kiocb, file);
0aea17a6398e5a Omar Sandoval 2019-08-13  5006  	ret = kiocb_set_rw_flags(&kiocb, 0);
0aea17a6398e5a Omar Sandoval 2019-08-13  5007  	if (ret)
0aea17a6398e5a Omar Sandoval 2019-08-13  5008  		goto out_end_write;
0aea17a6398e5a Omar Sandoval 2019-08-13  5009  	kiocb.ki_pos = pos;
0aea17a6398e5a Omar Sandoval 2019-08-13  5010
0aea17a6398e5a Omar Sandoval 2019-08-13  5011  	ret = btrfs_do_write_iter(&kiocb, &iter, &args);
0aea17a6398e5a Omar Sandoval 2019-08-13  5012  	if (ret > 0)
0aea17a6398e5a Omar Sandoval 2019-08-13  5013  		fsnotify_modify(file);
0aea17a6398e5a Omar Sandoval 2019-08-13  5014
0aea17a6398e5a Omar Sandoval 2019-08-13  5015  out_end_write:
0aea17a6398e5a Omar Sandoval 2019-08-13  5016  	file_end_write(file);
0aea17a6398e5a Omar Sandoval 2019-08-13  5017  	kfree(iov);
0aea17a6398e5a Omar Sandoval 2019-08-13  5018  out_acct:
0aea17a6398e5a Omar Sandoval 2019-08-13  5019  	if (ret > 0)
0aea17a6398e5a Omar Sandoval 2019-08-13  5020  		add_wchar(current, ret);
0aea17a6398e5a Omar Sandoval 2019-08-13  5021  	inc_syscw(current);
0aea17a6398e5a Omar Sandoval 2019-08-13  5022  	return ret;
0aea17a6398e5a Omar Sandoval 2019-08-13  5023  }
0aea17a6398e5a Omar Sandoval 2019-08-13  5024

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
--------------2u072XF93olOwK70H4Wi8Gzf
Content-Type: application/gzip; name=".config.gz"
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--------------2u072XF93olOwK70H4Wi8Gzf--
