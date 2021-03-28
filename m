Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD2F34BEB3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 22:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhC1UDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 16:03:38 -0400
Received: from mail-eopbgr680069.outbound.protection.outlook.com ([40.107.68.69]:35200
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231425AbhC1UDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 16:03:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNi1zpLiMh5pBp36W1n3hoHcwAE6fKrnatD0Zvxc8Ov4q4JNXfJ65Cgw11TOCu7g37ckLVKJ01c7SFEV0iMYGyDOTxPZUaJn8AxN+gw/1Zkm5V+23FvrCOfWQCINv5GB+kt8fXbkgfayECNuj61HR5qzbEwMACgQwnuKX6WRZH3jsd/nSRHfyTKszG6wtLElcO/UiwmPqhYlNn5Mi2Yy5+uSMN+vYBF7DQIya6ziR1GT+3nKPO3HeGciuAuoBoDOPcDEhi2E0NvHkRQsNQgCknViYmC7TpmRppJaIz9eTzVxHY4CpLdSoUxyRWUxnaWrMenaXjLGq+iVx+vui23NOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gzs2a41KSaCvYUIDfytYlT2GkJZSQSIcsPeuepK/CN4=;
 b=ehLFwjRCYrTjaV6xJZ/3+Z05YgPTGMmAq34DEH3GQXbMcZ3D9cLF2f6Xv4ZpPrPgqj7ajM/wCKIoGltHseOdnF46SuLN/fWv/a3fH9as95ULPIOLqxzkPx3VbCygmmolIPM1qbD+i4Ho7bM1+WEE4FcZHUE4XgGgB4j4B5qUtJ0BZDVbkHZ/xHVk3t7+D7OgJzJTxG8AorQtyC4SJPMI8To97YmVTYYJDk/ukRS8hwNTSGojyxUXInJzwrs5nCKVNf6NXTjDA/QBmwpOnhZNKo7qIbxNF0PvOqoLlt9AKth5B+0UKuepCsqLVg4ds+PVHPYAtYg7Zyh9PnF5+wXnuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gzs2a41KSaCvYUIDfytYlT2GkJZSQSIcsPeuepK/CN4=;
 b=ZxFFFLdvpabWzyTfn60jF/kj+Tx83nq8JtZx9c6JCFG0W9WdDHa8Odk3bA1dHrdvBbODKFW9CNOuUExJoUSbNeN24eSOJJvK+BPi4PXt6mlIAvhVvCxtu2VqhwAM0NeSFj1l2/2KgbzIy39QS0KTBN1T6p0nOkhi/h3ROg/B/rhaMuACEBQRI5Kdr95wS/tVsyo+bFAlFRBFLj5LJ2Ec2EZuFuqRKx96ctqXYhVH700wMevpr2E1NNJdlIUPnm/YANpjPsGRUSOUv3dwAYE8+blTHW74WLIt4Ooblcg01v/T0OPDlEmGyi/nVzsswYe0mKj64RzNbS0jw520WfUsGg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Sun, 28 Mar
 2021 20:03:07 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Sun, 28 Mar 2021
 20:03:07 +0000
Date:   Sun, 28 Mar 2021 16:52:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     kernel test robot <lkp@intel.com>
Cc:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: ERROR: modpost: "zap_vma_ptes" undefined!
Message-ID: <20210328195241.GW2356281@nvidia.com>
References: <202103241611.sznsZyvf-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103241611.sznsZyvf-lkp@intel.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR02CA0104.namprd02.prod.outlook.com
 (2603:10b6:208:51::45) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0104.namprd02.prod.outlook.com (2603:10b6:208:51::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.32 via Frontend Transport; Sun, 28 Mar 2021 20:03:07 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lQbSj-004frN-5e; Sun, 28 Mar 2021 16:52:41 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a1a8ee7-f071-4f7a-624b-08d8f2248140
X-MS-TrafficTypeDiagnostic: DM5PR12MB1884:
X-Microsoft-Antispam-PRVS: <DM5PR12MB18840ACBDA7414E0B6B0D9A8C27F9@DM5PR12MB1884.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:200;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j17JY1KKU3/azUEz55Bq0fEPG/VGSjZWpi/cnQVPB3w9sxYzJLdDNA+aZWRGiWjjmiOJS/SsR7qwK1hs+8RcsDg8xAo7LWRVgyvrp9VmwlAbwl/gc65gr19vEugf6+SA664IhJSI9YfiBYEh3spVpygPM8unl9eRkK+LxWUHfTRkwJGzonRJRZMGODOzesS22+zywu0UNHs06fno5I5hwqeAeXt4yAU3pXXSMLxX5cIwfhs+uTNVvM/sTfuIEGet88Y4NNPHIDVeqayXfQEN45R6pJR3RfuGcjQis27lKdlw+GQHEr1sR01rCdDSrTOuBoyHDnhmIMZ0xMe9QBG3YmcJf8JbEHSq1+3Le+1swFGiQ3se42DArklJ4boUHenc46kLZ5dR1+8jjuOsdr2sA9/ypmaVNGt08isuXBUL8+lupg7bmmrWWaotkne4H3gDyoyupPieyBFtWsGIeYkmnfMMfUE2GA/f9fMYVis9+tywXSISPp6jquT+qF+HunQa8v2QNR81Cmg+OSmjiquM0i84mzsN3DY0MJEoL0/+R8K+BrJFW0eY+L/ULP4CyZP9LnvuyLAWY+LBOZX1SwERo1AcGuHDxK8T+hH+/wy2YpsBalSI0oQLt9NfSD1cRf3J5rd95Wm8Qdmme7pvpxIBdQB6yZIO+0pfrmfeCUMeC4ppb8L7Xpc1rkzmsJTiAhaf0/gx0IyZEr1LMpm/JSedZzOlTGBP2YGzSxepazmajoQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(316002)(54906003)(1076003)(5660300002)(26005)(36756003)(8676002)(66476007)(33656002)(66946007)(38100700001)(86362001)(66556008)(4326008)(966005)(2906002)(186003)(6916009)(9746002)(9786002)(2616005)(83380400001)(478600001)(8936002)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lSG54A6dcnSHyLnsteby628QZr4o9Plpsyy/zi2onuaALNoCPpLkNfj+xfEI?=
 =?us-ascii?Q?r6/Ui0FsGXMenWCB+LpCRt6xN67wK/QcVkasmd+uJQ3dyW2ng9dqAaKpd1sz?=
 =?us-ascii?Q?/T1b2VcLukbXL78BkfDQW/bOLyHZg7fteVs+EG5AN0AA3hao00LG4nX2t1Sq?=
 =?us-ascii?Q?UMIahOwCAY0y1Zuptxq82STCl35O0Z15g2XUSR3BYtxAtC9Mgz3HSP+D+Fpl?=
 =?us-ascii?Q?8v7df9iG5xV9hYkCTSpQyyc4pTzkdHi6HSbon/KC3gGSTfq8f9G9XUNn2S7Z?=
 =?us-ascii?Q?y6xnFrOy96xm6rApl9h5PdllVYkCFZu0IJ2eNiSfFxIQ/7kgP1hU+N+HvNiK?=
 =?us-ascii?Q?fZw8XnelO2jxtCcx08eMfwD2A6LJ2c3AuL9eXxDJ7xYUpeyMiNwBEJavd0wW?=
 =?us-ascii?Q?Z5nBYE5ZMya0WD/5Bixj/8HdL6QA95XqVbPnTmHuSy3dfd/1AHgOe5eZTNwt?=
 =?us-ascii?Q?JYenFtQpE+BcnmIl+FVPt5ZDyIH2moWvjRb/TfFuU3ktG0LcNeSe5rlHH63Z?=
 =?us-ascii?Q?/8IJDxUujNK0maOYzrxZgpxlxnruTHe1tC4Jgrnb7+xQN49aooHdVtz83PpK?=
 =?us-ascii?Q?4x+OrCqKVMJao6biSo8J1XXoQLFYZR0rmnh50bmI3X9Ey1qIo5kq4kRl23H2?=
 =?us-ascii?Q?X/lCWF04MfVJBJ7SBZ6btso38lRBeK4P9RvUWn8BPcTkNIkwvLIXSJDeEyu7?=
 =?us-ascii?Q?yJP5X4y+Z3GLUl0Gioz7RexDlDCapmd8tFjUHLtW5T1fApTX3CVFNz/FdD6g?=
 =?us-ascii?Q?z967tLiCfAcDC8JW6tTK/VgXj4yBJ/SUeAjd5qDkidNS/alvlqFSRHlNlwfA?=
 =?us-ascii?Q?2jKRrXjlwBQKUgpWb4bqVCePc9eykD1Q25bQJhMLkoVUsp02TddU35bp5V/0?=
 =?us-ascii?Q?CdqVKEi/bHPxqS/Guk3b2G2WAEAcwJFXJX2isCcVoSqqwkzxPrkLqBwDjL1x?=
 =?us-ascii?Q?8kOA6MKTTcHBEUyeGQxKK1qeLqtvE0HY+/yVu2QKYDsiVY7cBNyEUZBSLQkL?=
 =?us-ascii?Q?YzbbUIhaAdbKgctlhySTNfZasnbxiGwfbCEcXokIg9w17TX81ntMx4pXshtF?=
 =?us-ascii?Q?da5a6URiMyqv5ZZ361o6niyqCDV5eBnFaiq8hR332JuVhYQeYYq28Zru7Nty?=
 =?us-ascii?Q?W35zzscCEI4ynU2Wzxacsd1Nd1ObGSynv8VKWSh8sjcf2ByseE+2qBcNq5ua?=
 =?us-ascii?Q?uufxlx90cJZKkRORXNWWDlQKkTMXkrhN99LKLpWs2SIN9iINcr6umiKhknEO?=
 =?us-ascii?Q?UvKl0Z95mJofRgzkx/BAbW+iGpmrwQlnulnBJ3aCAgB9l9k9EGa7Id+9mJdU?=
 =?us-ascii?Q?EOENk1JhlR326XJHXXYC/Wl5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1a8ee7-f071-4f7a-624b-08d8f2248140
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2021 20:03:07.5908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+SpnEaU9H6sOnkO9HRE26EHZ5gZof5+wDQ8zvksDw/wAYVribZAo//CfjrQMTxT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1884
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 08:59:13AM +0000, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7acac4b3196caee5e21fb5ea53f8bc124e6a16fc
> commit: 179209fa12709a3df8888c323b37315da2683c24 vfio: IOMMU_API should be selected
> date:   8 days ago
> config: riscv-randconfig-r016-20210324 (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=179209fa12709a3df8888c323b37315da2683c24
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 179209fa12709a3df8888c323b37315da2683c24
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ERROR: modpost: "zap_vma_ptes" [drivers/vfio/pci/vfio-pci.ko] undefined!

This is the because of the patch ordering that Cornelia mentioned,
!MMU is fixed in the next patch

Jason
