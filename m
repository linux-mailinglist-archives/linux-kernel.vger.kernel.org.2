Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1783D8722
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 07:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbhG1FYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 01:24:43 -0400
Received: from mail-bn7nam10on2077.outbound.protection.outlook.com ([40.107.92.77]:15456
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229752AbhG1FYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 01:24:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C16xSZKtzL3T/2TYdgHyewFVpv9CuPwpu3s+W6G/rcYUjLlDE76L6OFlgZTo0ooX685ZsEPYmroPCTxGDaN/V/aBlXvbboaz3wKjx/ELVB1NRY3xKNdtiF06p3YKkRyyj13Jym90BVmvo1BWcljwn3tY6KYYsWecm/QKJ6DOSXlsyLvHFExHz5GOIhdTseYnRomOtpFYhApdghc9J1b1PFNtLsNBzvzeierMbOYECahjMOkXQxs/qjYyof0CjIZIebRXy2/l9UjTGdJnnvgj2xGpBNzSKcShcrB+btnDYFPSVcd+Hvcgh2I7rRWon5h9MfCX1ArOgJRnapf8E1UOog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Pax0ZViEAIOL8xgj5/StArnAu1PE/mnHVmauloNClY=;
 b=GwHiRy7Tuifde5Tz1473L1pgBpYUUPpgAHptl6npqbpOhz8xxy6LG4m4kZ9tog/SrIbCejh44Roew5yyXKiMufsrvIa8xkj4eiijRrriYhZcfsAvvaqvkKSOAtymgd+zTrj7dxBMt1psY+XJOxw6iysjtH5bEYtxpYhPpCC2Lf6OkVUvsVbnrE66OMdg9X9pm8XkVI66Huz3eyNUSrd2bqMDa1lWu2KMvQx+CGtmeYcdmfXzVx8uWou9zKQgd2PjZxcS8xWd1a1M1ysuKedVJB8tnWgVGYZ/t8e4D5dRa1br0WqrmvRRsH2YrM6ZAua74/qo+RxcLd82t4OnwyKfQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.01.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Pax0ZViEAIOL8xgj5/StArnAu1PE/mnHVmauloNClY=;
 b=ixaHRxzD+V5QoNf8rIZXdA4yJXqwxpMBF+aonsald87hQZrT/b8FM8Li7B0JWgFP2If+0rGOMc6E1dkD8c9kmfZ0tfgwDxdR8uMR8+4NcaUCSfrVjjxPX58ZgAqYJu5XktFkK4BeLkHq7fTfn92/TMqYO96Wnnf7t006l+5JnuCLVv4cm/gwieDO6qlxiF5pjFYkv4eY5iMyrsSIHWFooFLncsvxwUMAlYQ37CNv7LNrIHn4d3Hz6VVdLwPYZvjaSB6IiSjHlgqM++QiUNGC2l3iE86TArd24SzikPc8Cg4onIiitToINjuNq1K7I5WvWI8woNeMLYVlF7XhIBjGEg==
Received: from DM6PR02CA0079.namprd02.prod.outlook.com (2603:10b6:5:1f4::20)
 by DM6PR12MB4986.namprd12.prod.outlook.com (2603:10b6:5:16f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Wed, 28 Jul
 2021 05:24:37 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::2b) by DM6PR02CA0079.outlook.office365.com
 (2603:10b6:5:1f4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend
 Transport; Wed, 28 Jul 2021 05:24:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 05:24:37 +0000
Received: from [10.2.52.97] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 28 Jul
 2021 05:24:36 +0000
Subject: Re: gup_test.c:1:10: fatal error: fcntl.h: No such file or directory
To:     kernel test robot <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <202107281223.L61SLDL2-lkp@intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <6af32770-1825-ff9a-ccf2-46600ed6fc7e@nvidia.com>
Date:   Tue, 27 Jul 2021 22:24:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <202107281223.L61SLDL2-lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83f8f38f-7672-491b-2bd5-08d95187fde6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4986:
X-Microsoft-Antispam-PRVS: <DM6PR12MB498625B6569DFD9C641979F0A8EA9@DM6PR12MB4986.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VbhI9ImdRxsQPtXkWziDNRG3evIzAQ3bFuSjtw5MlgMaHHhd/2/+pdH1xnx7urpUDfOEFIo2adrpOpahco8g2Uy3EuBZ3YN9uRISb5xGE/6axAaggsb34T2sQPKv/jQx3Q0y1KMKiq4ra5Lvj0At2sKUwQmxcKgLJQ+Nwc0m7uFAd2EELh0XMnQq8YyPcIzRpGeEg95OUGmjCfVze2rH67e/+nSyrmKVr++mAibJUzJowZt/Uy9xDeGcIyriJeGsyEKKaZz7GffKPs1EOzlS08jzMotNWGWCwbnqrvTV7U7cOXSGe+iacp0i8X2XRy9WStgkWNnyTTD6beJWz+BDulUbdxhqoBC19O/7TeOkgeY5dkTJZmrgZ+WD/byS9u//NsMTt9VW26WWLg5rKK6qV1UHT+ZB1xowKtQGMgPzYiX2Bgc06bq0ElPGUZyW+sYlaJu53vIph29WU2HdyGjWOrN/jCDTZPQFi1skCzGADX+jlho2lNDs5Vsh22INEwGxnGie16ArVBd5NlsrD68D6cqXh2y0uzwqpAZ4IxwbQZWM00wqAgyl/ONdcUkf7N8PxzSHon+L6RmlM6gYEbx0VpnuUi3nod3Xjj9Th/vOln/1tR1gGXv6uzfAOTiss9pJzNESiCRJ5KYpJQ+gRnR8ULS/Xaqd7ydEzzmkLFxUr4s6+JkW2oVbKwRdimRvLMvevxqXRtvMqR5HveRHqVE9UMivb7An3ovIEeSrUdACGvd2QDDvo/3zo5BKP7SqH61RGLMp6JtXSrpHwbzYPkO414vHAAG4QYPQGbfJrVESQhu/rvQfZsGF0tm7i8oJfr8kJMzd3gqDU1z5QKQN7pECAfbB8aHrOhQ/r+X+RvPLvew=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(36840700001)(46966006)(336012)(478600001)(86362001)(426003)(316002)(26005)(82310400003)(8676002)(5660300002)(47076005)(7636003)(16576012)(53546011)(36906005)(83380400001)(36756003)(966005)(8936002)(356005)(54906003)(4326008)(31696002)(6916009)(36860700001)(2616005)(82740400003)(16526019)(70586007)(70206006)(31686004)(2906002)(186003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 05:24:37.0701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f8f38f-7672-491b-2bd5-08d95187fde6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4986
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/21 9:59 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7d549995d4e0d99b68e8a7793a0d23da6fc40fe8
> commit: 9c84f229268fa229e250b7225611d0eb7094fea0 mm/gup_benchmark: rename to mm/gup_test
> date:   7 months ago
> config: openrisc-randconfig-s031-20210726 (attached as .config)
> compiler: or1k-linux-gcc (GCC) 10.3.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # apt-get install sparse
>          # sparse version: v0.6.3-341-g8af24329-dirty
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9c84f229268fa229e250b7225611d0eb7094fea0
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout 9c84f229268fa229e250b7225611d0eb7094fea0
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash -C tools/testing/selftests/vm install
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> gup_test.c:1:10: fatal error: fcntl.h: No such file or directory
>         1 | #include <fcntl.h>
>           |          ^~~~~~~~~
>     compilation terminated.
> 

I reproduced this via the above steps, and noticed that there are missing
header files for most (all?) of the vm tests, not just gup_test.c. And
not just fcntl.h, either. The error list continue as follows (below).

This seems like a new toolchain issue, right?


gup_test.c:1:10: fatal error: fcntl.h: No such file or directory
1 | #include <fcntl.h>
|          ^~~~~~~~~
compilation terminated.
compaction_test.c:10:10: fatal error: stdio.h: No such file or directory
10 | #include <stdio.h>
|          ^~~~~~~~~
In file included from hmm-tests.c:13:
../kselftest_harness.h:56:10: fatal error: asm/types.h: No such file or directory
56 | #include <asm/types.h>
|          ^~~~~~~~~~~~~
hugepage-shm.c:31:10: fatal error: stdlib.h: No such file or directory
31 | #include <stdlib.h>
|          ^~~~~~~~~~
make: *** [../lib.mk:139: /kernel_work/linux-github/tools/testing/selftests/vm/gup_test] Error 1
compilation terminated.
compilation terminated.
compilation terminated.
hugepage-mmap.c:20:10: fatal error: stdlib.h: No such file or directory
20 | #include <stdlib.h>
|          ^~~~~~~~~~
map_hugetlb.c:13:10: fatal error: stdlib.h: No such file or directory
13 | #include <stdlib.h>
|          ^~~~~~~~~~
compilation terminated.
compilation terminated.
on-fault-limit.c:2:10: fatal error: sys/mman.h: No such file or directory
2 | #include <sys/mman.h>
|          ^~~~~~~~~~~~
transhuge-stress.c:9:10: fatal error: stdlib.h: No such file or directory
9 | #include <stdlib.h>
|          ^~~~~~~~~~
map_fixed_noreplace.c:10:10: fatal error: sys/mman.h: No such file or directory
10 | #include <sys/mman.h>
|          ^~~~~~~~~~~~
mlock2-tests.c:3:10: fatal error: sys/mman.h: No such file or directory
3 | #include <sys/mman.h>
|          ^~~~~~~~~~~~
compilation terminated.
compilation terminated.
compilation terminated.
compilation terminated.
mremap_dontunmap.c:9:10: fatal error: sys/mman.h: No such file or directory
9 | #include <sys/mman.h>
|          ^~~~~~~~~~~~
compilation terminated.
va_128TBswitch.c:8:10: fatal error: stdio.h: No such file or directory
8 | #include <stdio.h>
|          ^~~~~~~~~
compilation terminated.
make: *** [../lib.mk:139: /kernel_work/linux-github/tools/testing/selftests/vm/hmm-tests] Error 1
make: *** [../lib.mk:139: /kernel_work/linux-github/tools/testing/selftests/vm/hugepage-shm] Error 1
map_populate.c:9:10: fatal error: errno.h: No such file or directory
9 | #include <errno.h>
|          ^~~~~~~~~
compilation terminated.
make: *** [../lib.mk:139: /kernel_work/linux-github/tools/testing/selftests/vm/compaction_test] Error 1
make: *** [../lib.mk:139: /kernel_work/linux-github/tools/testing/selftests/vm/hugepage-mmap] Error 1
mlock-random-test.c:6:10: fatal error: unistd.h: No such file or directory
6 | #include <unistd.h>
|          ^~~~~~~~~~
compilation terminated.
make: *** [../lib.mk:139: /kernel_work/linux-github/tools/testing/selftests/vm/map_hugetlb] Error 1
khugepaged.c:2:10: fatal error: fcntl.h: No such file or directory
2 | #include <fcntl.h>
|          ^~~~~~~~~
compilation terminated.
make: *** [../lib.mk:139: /kernel_work/linux-github/tools/testing/selftests/vm/on-fault-limit] Error 1
make: *** [../lib.mk:139: /kernel_work/linux-github/tools/testing/selftests/vm/mlock2-tests] Error 1
make: *** [../lib.mk:139: /kernel_work/linux-github/tools/testing/selftests/vm/transhuge-stress] Error 1
make: *** [../lib.mk:139: /kernel_work/linux-github/tools/testing/selftests/vm/map_fixed_noreplace] 
Error 1
make: *** [../lib.mk:139: /kernel_work/linux-github/tools/testing/selftests/vm/mremap_dontunmap] Error 1
make: *** [../lib.mk:139: /kernel_work/linux-github/tools/testing/selftests/vm/va_128TBswitch] Error 1
make: *** [../lib.mk:139: /kernel_work/linux-github/tools/testing/selftests/vm/map_populate] Error 1
thuge-gen.c:16:10: fatal error: sys/mman.h: No such file or directory
16 | #include <sys/mman.h>
|          ^~~~~~~~~~~~
compilation terminated.
make: *** [../lib.mk:139: /kernel_work/linux-github/tools/testing/selftests/vm/khugepaged] Error 1
make: *** [../lib.mk:139: /kernel_work/linux-github/tools/testing/selftests/vm/mlock-random-test] 
Error 1
userfaultfd.c:38:10: fatal error: stdio.h: No such file or directory
38 | #include <stdio.h>
|          ^~~~~~~~~
compilation terminated.
write_to_hugetlbfs.c:7:10: fatal error: err.h: No such file or directory
7 | #include <err.h>
|          ^~~~~~~
compilation terminated.
virtual_address_range.c:8:10: fatal error: stdio.h: No such file or directory
8 | #include <stdio.h>
|          ^~~~~~~~~
compilation terminated.


thanks,
-- 
John Hubbard
NVIDIA
