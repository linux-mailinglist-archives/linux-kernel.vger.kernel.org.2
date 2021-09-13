Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7314E409A10
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239418AbhIMQyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:54:54 -0400
Received: from mail-dm6nam10on2063.outbound.protection.outlook.com ([40.107.93.63]:20096
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238594AbhIMQyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:54:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFyNekZpIOuBhwxRMs0rrt7w3zIdT/HcWDUNV+kH7mweAkPJ4cp5NoeVmxy0QlYxUer3eCednZBd6sbxxA3m6thx2pM7jaXFixRSQucVBBsio/Nc2AdCNUgwiNGRy0u+y6q+ymEPGuS9q3PXOd57CtwgXWFRyVgSQG/9RPKSC2e4BdVUJeqY1pdT5FP5MUwbqlz9KUNnFxtIuZlxdsId2XYsXpxeUn/Zs62E9Mr4rGPVmFYH8EiQ4UnK+MCdwM69xIOzUvVOu895Pg4+28y6T/Kl8o36RSs/Tk+Xqj9XIz0z02Wo9vzJDB6BugVBNDermBC4PW/UQl/f+ROy3JsGRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=cLHYLnDdgDDwha13KcBVpsZSZ3X08UofQBBYbrnchuE=;
 b=NNxTd/gWbEvN9br7Xjx0SwEUjbqZzFhvjvWyrTY8jnduJ+WZuPEg01wlgTSyXMR/v73wnKf0+O8aI0xPRAUyDdF+mdN0zpOKqb0iY3jvCecLCuYaO3VfZyZtw8YWpZAwtfJFaf9k2y/LURE1Ns4tcQn0eqfle5/hDEEWQoEVcifaIIjeI//7Bep3f5rLkowYKtxEPiM9TNLB3RhfnlK7oTporeMvzCSdDWHE4VuKZjW3WObwwDRDoYMUX9ovdiVjQDOn3WKZK9DoJZrh4X1LuzONlqY6T/7eRtkmkv1qPqQBlncr25FkMCS1xNU4wIJ6h748kdN8pT6QBFzQaOD7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLHYLnDdgDDwha13KcBVpsZSZ3X08UofQBBYbrnchuE=;
 b=p2S9rGyzqvUmv9xCz9rqWbVncphKwn6EXlfbcRq0uAXwck+ZH286xVPq9FtNdHk3f16HfkQmJlfYP7JyMwymDfRvOnBmBgfrmMlCplhp/QF8fgNwT8WBlSrtDZp9QVvV/eI/e4eQZgoyQ4HxlNFBMJ8z6Fu1kpp7H+qq8OCh6L7ZRLrNg/6C1/1Pn48z/jWPWsgVvw67e0BZPwfBHcFJ9cwGIDEoO0oyKPCZKCe+Wh71HdeHl3tn027Ke82PSQ/j2mIP4h1Klh/qNJrVMBojXdUjV7Qet5Zn5jkoAP41mOJ7DKqFsAh9jrYgnjEDy69krtk0C+HZ3hGzTjNf9bebWg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5240.namprd12.prod.outlook.com (2603:10b6:208:319::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 16:53:19 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4500.019; Mon, 13 Sep 2021
 16:53:19 +0000
Date:   Mon, 13 Sep 2021 13:53:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     kernel test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: drivers/infiniband/hw/qib/qib_sysfs.c:413:1: error:
 static_assert expression is not an integral constant expression
Message-ID: <20210913165317.GX2505917@nvidia.com>
References: <202109112002.NZceUwiC-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109112002.NZceUwiC-lkp@intel.com>
X-ClientProxiedBy: MN2PR12CA0029.namprd12.prod.outlook.com
 (2603:10b6:208:a8::42) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR12CA0029.namprd12.prod.outlook.com (2603:10b6:208:a8::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 16:53:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mPpCn-00Gi7C-W7; Mon, 13 Sep 2021 13:53:18 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e24b66cd-ca0a-495f-3e29-08d976d6fd28
X-MS-TrafficTypeDiagnostic: BL1PR12MB5240:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5240C7BC0CF171928876D858C2D99@BL1PR12MB5240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZpNdhnEw0G2NMM8xGPMRAxP2y/hfh13CUvLH5odEtyh2l7sp9+l6fYzqfVwzwPZOKG1DVVYnJKQB4ATYKazYppVfa9/KOh+r/mjuRjeAhsTDNMkGDfCMdC2HjxmVCrGWr9d4hueeb6VR1yKz8aVZpHP2e4PgsRMQVrLUjPsgAKtERgLjP+2ZSOGNLUv5g1fX0k1QM3YV6VoOduDe/GIOZfg439GPjecIf5zEG26hvjSz35Yqf6tHYTRo2wNZpHtXip9ghum15ie07RH0c1YwaPy+lK41bPlsROeIeZhbQXk7nh40bHfMSMxZ9uXRmBpcllSNofU1QMcluT+16TAMYwcUI6C9//d0tbqV5yAkcJqu+D/Noq4zpJ8xJYXAUIJZPUZSXDYRey68hOYpbcePJr1vF8N3xUJ68+A+uYrU2LGdURlQotj7guLEDP+po4ftznf8Iv3hvMBL6n5le95FxFJjNuS8wvxnM+Dq2FlGAM1gWIND9KyreKwG2hMuB95JSNow9bv7qsQ9gHJAuzYfeKJudYaEU4EfywgrFkGkosd5zZEQoBy+gUX5VVUAhcdc/p8Mr/fMAj4thRUZtuv2EjwFFX+80Y/99/Sk8PNDAMCI8rn7PIyeYleFGrkJQj68/So/G+yCBut0DotD+gSofdEtP8O/WIqfj24UYZJtiawBdZoYXDzLPxpoIFN1nB7dcxefaoZ3myXRefm2+/+rL6e9VnBSC48VlfAXMbd9gtxHa3T4haVajfyxkeOOkqWIkh9zREbpsVdB5BDCBtJzCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(66556008)(478600001)(5660300002)(66946007)(8936002)(966005)(110136005)(38100700002)(186003)(66476007)(2616005)(2906002)(9746002)(9786002)(426003)(4326008)(8676002)(83380400001)(1076003)(33656002)(26005)(36756003)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pInG9Hnlo8CLEfVCQ63M1UC6a0xOcj6FlSAsjo3fEL7eeg1wJlwwjva38Vxq?=
 =?us-ascii?Q?cN9KUP0YDkyggDdauTGtaZppZCaA5WB7ggLKvMMWGqNsuGeynMQTpPpp5Id+?=
 =?us-ascii?Q?b9vTUDYutd6tEsUslJICPg0Uw7N0ruu/dvBpMetD5Be4xvbwcu01+IktlMaO?=
 =?us-ascii?Q?+iWNbZYj6c0o9OfzFlggas3sFGFtGBhL3B4VfT+yG7nvuKZHfbJdslVAPr+5?=
 =?us-ascii?Q?iw/nc4XN+QHcHn6YKEedLtQxSGr8Ih/cRDeKH83pn7wDrXsyp9xDANrBUbys?=
 =?us-ascii?Q?hcrJgdSU0/VjliG0gLOux2q1+yFiqLr9Fc2K26qTnKx83+gqBsXERWNbnbqA?=
 =?us-ascii?Q?aTpCrcfl/MnnD3O9QQMesJxEL+NyW4tlzuLdMZSzrD6LTX9NsAXH6MHxdKXp?=
 =?us-ascii?Q?GpFZWtS5Bbn7k0VcwKumnlZqw5CE5ApAzVKE3lrLP9f2RoqQvBCarDUwaocF?=
 =?us-ascii?Q?9Snc68nlO7l7eEY8XFcPiV41oM5e/4r+aZ4Hrrfp1rt4+Azwe6gDFn1xUMdH?=
 =?us-ascii?Q?jFiPk+NeuDYyAIqjHDUVPqqfwBgoDd3HD+75Dvx3E8L8O3F00LeOpmUDsxD/?=
 =?us-ascii?Q?I8SAhCHuS8RGuJ+DMc0g6/tAXMivvOHl4kDXYL2qZk5QuglbNueuDXt7kCNj?=
 =?us-ascii?Q?s37jNXDVWoA0EyZRg8BAPZdKrwBqVGtDUDgaENI0PF8wXGXxfS1AZQvM+ybZ?=
 =?us-ascii?Q?Ml4Kwb++p5FyCRyHVBNxFkdqcF8DJ8xs0uhBbMrpvPXYElnHm++6yEg9l7ig?=
 =?us-ascii?Q?MeLAT1XIOUNrpXwi4RTlqYGrotvOKsVfyWi9OOGq5tIMiuVSC2LWpIaKzw8z?=
 =?us-ascii?Q?e0a6EuiTKkzn8CnOyy2GYqAYWmA+4mU/ErnRoUrb7qjCwDB2Nxvb1uzdDc/+?=
 =?us-ascii?Q?9tIbms5RWu5E131yvPjnKSFzDODd7qtSbfNQVgn8KQDw4Q5MK7Z+JokChHge?=
 =?us-ascii?Q?oSLA0M5HeiQMl7C57KVeBHknpssHoeLHNtrjOLM/2SGFXFVwZmBZYxFS1JrH?=
 =?us-ascii?Q?NC8iurIaOyKG91srIYLSO5EvY5fDyAVUirtgA6AOdllLELrKcEjbnV8TEHye?=
 =?us-ascii?Q?Cc0CNlJiisZV5ZG91m98cLsxtRnPC9XNonNGs3Ju826XZS/OOhDRizzG3bYn?=
 =?us-ascii?Q?D1Tg97Mm10kYX8+KgLt0+65sTXeXawpFr9Gm4WXcAbhjSw2uoU1oyia0Op3C?=
 =?us-ascii?Q?XOwbI+5B28AOedKKHxoe2vruks7oiNMJ+2VLA/4z6dC1qLjXwwH8AUkSB6Gp?=
 =?us-ascii?Q?cf+jx6nDtUtElX5nJ6/8CMgHeZ67g01IETc4r5lxxOcZggUfZFOFWuavM2JI?=
 =?us-ascii?Q?b+5KwhaxGVRSAHFBmZp4iFFH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24b66cd-ca0a-495f-3e29-08d976d6fd28
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 16:53:19.3301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TEKGM7IWCtcpwIz79lvXKw1PiQ08n/9C6RHENVhvla363JnyU/tFAFLcj/RUCvq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5240
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 08:17:08PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   926de8c4326c14fcf35f1de142019043597a4fac
> commit: 84f969e1c48ed3825986e91a0786e363d57f69d1 IB/qib: Fix null pointer subtraction compiler warning
> date:   3 days ago
> config: x86_64-randconfig-a014-20210911 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 261cbe98c38f8c1ee1a482fe76511110e790f58a)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=84f969e1c48ed3825986e91a0786e363d57f69d1
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 84f969e1c48ed3825986e91a0786e363d57f69d1
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/infiniband/hw/qib/qib_sysfs.c:413:1: error: static_assert expression is not an integral constant expression
>    QIB_DIAGC_ATTR(rc_resends);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/infiniband/hw/qib/qib_sysfs.c:406:16: note: expanded from macro 'QIB_DIAGC_ATTR'
>            static_assert(&((struct qib_ibport *)0)->rvp.n_##N != (u64 *)NULL);    \
>            ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
>    #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
>                                     ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
>    #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>                                                           ^~~~
>    drivers/infiniband/hw/qib/qib_sysfs.c:413:1: note: cannot access field of null pointer
>    drivers/infiniband/hw/qib/qib_sysfs.c:406:43: note: expanded from macro 'QIB_DIAGC_ATTR'
>            static_assert(&((struct qib_ibport *)0)->rvp.n_##N != (u64 *)NULL);    \
>                                                     ^
>    drivers/infiniband/hw/qib/qib_sysfs.c:414:1: error: static_assert expression is not an integral constant expression
>    QIB_DIAGC_ATTR(seq_naks);
>    ^~~~~~~~~~~~~~~~~~~~~~~~

Nick/Nathan

Clang is being a real PITA here - do you know of a solution?

This macro would like to know that the passed in member name has a u64
type, all the things I've come up with fail on clang - but many work
fine on gcc. Frankly I think this case is a clang bug myself..

Thanks,
Jason
