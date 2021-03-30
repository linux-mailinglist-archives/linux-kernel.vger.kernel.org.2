Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A960E34E1C6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 09:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhC3HJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 03:09:12 -0400
Received: from mail-bn7nam10on2059.outbound.protection.outlook.com ([40.107.92.59]:63393
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231240AbhC3HIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 03:08:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcNIE++qbE3oCYwLKb4WkeFPLzCS11Ko0tkgysBE3tgU3FyHDOmuVRahy1QrFxO0VJJfTcIZ0zAAUPyiC+WVlUwglxW6Dl9NhNbrq0xI2o2liCI2stJRD5bLArTwwC5LyhiyKhWx7wG3qYtjcMY2GmYuS6XhVkrhWE9yJEhzqD0LRAQmngdHCUhYQnPtoLnOiIsLiT9pnByUnI6sUzJMvyq9ey5/vNhcIpqod3fGW06JE3OWd9JAQncSjVmK350gkJmygBMFOODs7awpc2rKskZOGkTw+esDFnezbJwMrjlaQaA7JTFa2a1JFLW8EWeNy5YV97i9UAXWAeAFggqCIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pW+A0+x7PfAec7HE5mfH89iY7Y15nPDi1itILfk8G4=;
 b=c/m86L38ex9e/X8C29n28s/UW+Quvu6nhXkQzWqws4I8Rb8u2vIsmjdWxol3DzHtVNq3PjiTAzvkfla4TSfdFr/5N79b4AivpNm2St1lxckA+uQMsL/vPxYvBhmsGA+zipiT4c535OmlMEqLJczqlUonnCKDFNyeM1lr4cJ+XWw5WCTkCRfvbfYglop6qDGEXohUJ+JKavv24GFHaPDsF107rKZPFHzlQ7/ae/6egSStcN9Um+AvJiOVjbo/Q+jXelNv16QblmnwpwkD86Xv/mBzw20dZJXhJqTZl63Lh96Bw/yRjUQPQrDSBKPOX0Cfw+7GBCgemYqu4KKFi3iEMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pW+A0+x7PfAec7HE5mfH89iY7Y15nPDi1itILfk8G4=;
 b=HWVAYkXlp8iB0oPUHFnh/+Y9FV37qhHus4gkF8DOT1XH68d0Guw2AzTghTkhiABAj4wKaZEsHtOgOQQTKbtvBjnB/j9mihnaBGCZw65I4MqmhlKaxoPlRUy2GcY6NPvutW1Om+rvzlgiPqbgf8lQtftw2DROrRuvxaP5XDHUthTbvXMzHQeGd8iVUMY6iA1KuBGPYFmb8mQTxgx40SQITqFCFkbu4yA7RBhXaYtMGgP0uFxnqniAmD0F00Lh5tSVGk8UxNbLvGW0mYYdqzHv55BzYjRpo7NFqHkrPC63F8FFIP2aCcSZLfHHxEsl10+X3kiFBYbOTp3rVjrtxD16pg==
Received: from DS7PR03CA0255.namprd03.prod.outlook.com (2603:10b6:5:3b3::20)
 by BN6PR12MB1539.namprd12.prod.outlook.com (2603:10b6:405:6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Tue, 30 Mar
 2021 07:08:46 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::3d) by DS7PR03CA0255.outlook.office365.com
 (2603:10b6:5:3b3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend
 Transport; Tue, 30 Mar 2021 07:08:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Tue, 30 Mar 2021 07:08:46 +0000
Received: from [10.2.63.109] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 30 Mar
 2021 07:08:46 +0000
Subject: Re: [PATCH] mm: gup: remove FOLL_SPLIT
To:     kernel test robot <lkp@intel.com>, Yang Shi <shy828301@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210329193828.179993-1-shy828301@gmail.com>
 <202103301403.u00aVRF6-lkp@intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <ffa96851-ce93-12b4-70ca-594f00fa3c2b@nvidia.com>
Date:   Tue, 30 Mar 2021 00:08:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <202103301403.u00aVRF6-lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6449f630-0664-4527-4a9d-08d8f34aa95d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1539:
X-Microsoft-Antispam-PRVS: <BN6PR12MB15398FCE108EC6BDB2FF493EA87D9@BN6PR12MB1539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CgFmiUU0kjIS+mW48CEZoFJUIbdKbz/xQZH22TVp1g6s/tD6bZkk9wpLiJaYppE89jX3poB+2KsED5WNsugQLFdKrDla4OaDamjafreBGjGDtoSebJ3VQSoI/dnCnc/Qr4TYjD+n5ghorxXFOTCGz416zfz0XvuIyY9b8N/saEc7Ntd35ZwCIVCloBERnZyG5P6mvr56F2Nr8yrP0Dn5rNok+cKDVpqtmV7S0UaqEm64zZ3pCm/Q9jNxsGXGxOaHWtMsvACHtwnAzu3bX6ZkBoY6Ms4GVMbrte8K72j1odby3GOrmFzMfhlX3CkniA2kBrqkDVA4cB5vEqLoGqN4EyDczSZ/YtVOtdU1XrP3IcfGdfi78KW5szyipjseOr5ZJ5hwry872J49NVkmwyjrCEHmIK6cGHnThVr5X30LOc9xG3cB4hiG2tHDh0AWCQRjuePCVWqBbBkr2yflgX0mWrn5FgJClSkQONtizkeqqPPjNieOlEeXLsKEKw78CNOG0wDAyI1ys+zE6zl315IntuSfWBsd353Yas20HLP/X7zNl8iuUQUPngvcv9zClCHtJ2P/CGFd6sFVngBdWBVYTKdTYI35DObazq+Uic9I5/grZogjo5wd7HVxobD955SUrTGHW64uMtgNE4drIL0VM5Dqgd8MrWgwA4KxrQyU5BGFWgz0ksPOIivRfTG0EyNVK2X0CDXN5b3raUQaFrSX928eDKsyrlAzCzM0LUwlzPMqyfV3vcWx30JocSVeNuFw4cV25Si5iUIXMkLOTK8zLQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(36840700001)(46966006)(86362001)(16576012)(966005)(478600001)(47076005)(336012)(36860700001)(36756003)(70206006)(356005)(70586007)(4326008)(36906005)(8936002)(5660300002)(426003)(2616005)(316002)(82310400003)(26005)(82740400003)(110136005)(2906002)(31686004)(7636003)(16526019)(19627235002)(54906003)(8676002)(31696002)(53546011)(186003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 07:08:46.5639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6449f630-0664-4527-4a9d-08d8f34aa95d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1539
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 11:24 PM, kernel test robot wrote:
> Hi Yang,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on hnaz-linux-mm/master]
> 
> url:    https://github.com/0day-ci/linux/commits/Yang-Shi/mm-gup-remove-FOLL_SPLIT/20210330-034042
> base:   https://github.com/hnaz/linux-mm master
> config: s390-randconfig-r032-20210330 (attached as .config)
> compiler: s390-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/0day-ci/linux/commit/c8563a636718f98af86a3965d94e25b8f2cf2354
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Yang-Shi/mm-gup-remove-FOLL_SPLIT/20210330-034042
>          git checkout c8563a636718f98af86a3965d94e25b8f2cf2354
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     arch/s390/mm/gmap.c: In function 'thp_split_mm':
>>> arch/s390/mm/gmap.c:2498:27: error: 'FOLL_SPLIT' undeclared (first use in this function); did you mean 'FOLL_PIN'?
>      2498 |    follow_page(vma, addr, FOLL_SPLIT);
>           |                           ^~~~~~~~~~
>           |                           FOLL_PIN
>     arch/s390/mm/gmap.c:2498:27: note: each undeclared identifier is reported only once for each function it appears in
> 
> 
> vim +2498 arch/s390/mm/gmap.c

There appears to be an imperfection in this 0day testing system, because (just as the patch
says), commit ba925fa35057a062ac98c3e8138b013ce4ce351c ("s390/gmap: improve THP splitting"),
July 29, 2020, removes the above use of FOLL_SPLIT.

And "git grep", just to be sure, shows it is not there in today's linux.git. So I guess the
https://github.com/0day-ci/linux repo needs a better way to stay in sync?


thanks,
-- 
John Hubbard
NVIDIA
