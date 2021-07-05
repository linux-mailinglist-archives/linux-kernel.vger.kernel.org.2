Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399353BC151
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 18:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhGEQHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 12:07:01 -0400
Received: from mail-mw2nam08on2054.outbound.protection.outlook.com ([40.107.101.54]:59605
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229495AbhGEQHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 12:07:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jt3e7b2/02BIVaMKOEay96UA9hGOffU/1QvI0faG67tD4YH5OZS1+qX+vTd4TC0Da6SjEZYBRrfoqfoU7hOZc1erCvQPDLG3lmFaHlwmwX6pWk2YtTgsV/f43jx2SMsB61dywU917BJLhERk6ecylF9Zey8TNrMMbkC4afEuIOlPB2TF1BN5DS5iLeZARD7fA3UTwsFnHA5ZhcwBTSxzPzs2VfrnsjKQFnxom24j5q09Fe6fZMWQVJ5S4rcIq0MQNLcfBdRABpXGyl3pByhLZZU3OHZorAHg69bB5VxzWxnEd7RW9kCdBT+P/ME2D2J5NF1ISIGRAQQoS7mS06oo3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eum/geYwECBhocPfwhd/KefEF0/Nc0iwwnZJsWJg6LQ=;
 b=Q03HZRoaMZb3h+GvsqBV6/HqXBTTQ7IsejtccVM5+jLRSXcLGL2YVFkR9p6jb3RDhHcfZ5IBG0ggvAD2DUy5ITXgYQUbkUB+qmEM5VfvwmS4mOJyjXDwudL8mRR1PwZZSRYUyEdI/u2A9cswqMtiY4oGCivmTX9a9iwBS2AJ+zMJKzPrKQYBSbxpajysVSobHQ74ezS+sEfgbQaao4m44HORiAI86+fuJAv9VSpX2qVlp7lMVJUzVrQX2vOW8axY1y05/vpYnluZpE7y0qJvlhaqDX7fU9XMF4yqSm7l99yH6oPkt9BI+WKxqLmYetVlt2Qe72R9x2vUx9DWwkwVaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eum/geYwECBhocPfwhd/KefEF0/Nc0iwwnZJsWJg6LQ=;
 b=GJexAfqoyrbWnKeyaaw7OyzWjSAmzBM4DN/qWA809dbvYcFEs763YgR4pxRi+9z/UTHt0nFejshUa0CWqKhcjGT6rBpBUOgxgClUJs2IAHpKWhvtvfVCFncCeL3JQqMXm3GDq5VqflaBS01TI7NIOrjmWLFeU+jJdIyxzAvVWBdulQP8AU3GQagZsBRJWovYIdixoUvx2FmDSrFYeFqrPVB/EA0ft3uLSJOgJE0O+gbDEn8bzlN1YUMI/9JeX8Rkunfq3weWisSKM0Ca6OzVHhWrv8hfnIPnlAMTbMpWbxdfBzyfQRzfTHotqkQbQp1FV9whDTaUK25kCUAMvd7wAA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5524.namprd12.prod.outlook.com (2603:10b6:208:1cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Mon, 5 Jul
 2021 16:04:22 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 16:04:22 +0000
Date:   Mon, 5 Jul 2021 13:04:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     kernel test robot <lkp@intel.com>,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>
Cc:     Shiraz Saleem <shiraz.saleem@intel.com>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/infiniband/hw/irdma/uk.c:934:6: warning: variable
 'total_size' set but not used
Message-ID: <20210705160421.GS4459@nvidia.com>
References: <202107020917.rzVg3a4q-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202107020917.rzVg3a4q-lkp@intel.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0131.namprd02.prod.outlook.com
 (2603:10b6:208:35::36) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0131.namprd02.prod.outlook.com (2603:10b6:208:35::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend Transport; Mon, 5 Jul 2021 16:04:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m0R53-003r0c-KU; Mon, 05 Jul 2021 13:04:21 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f52f34f-3ec6-44d4-4bfd-08d93fce8dd2
X-MS-TrafficTypeDiagnostic: BL0PR12MB5524:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5524A1977A37EB77DC9D3A91C21C9@BL0PR12MB5524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kxwkcsGeNebMl4e2CJFjxRVvDZp+yem1LyhyzW5yT5QkZHvKnHxqcax7FbTd/LoEkuLnoot0fdQeHCOV9koYd8oShNPV2lDL8D7MKTm8YgvhxTiggFmbnX5EF8YDU/9o2WctTgjigAyQip5BgnQdasgcYXuWyTdDAw0Ul0orm8UpBncyHw3jj1uBbgjYLEf9MELb3qUYqFosHP28ZqOj3GAG05+VhVxu/gbJ2IN1nQA1d9ng+iTEf0geaMY/LK5b6e2+UNQm4c1cDZYCR10t3RE6LTOifi4cH5p1riwnNVBoHto5oVnIYZnIZZkR1bAPFOqPW7D+D9O9Ap0rtgY2MqvuDUBfSwU4bWgbNZgAEX35Ojw7EFVyDuT52Vapf15sY1JlsjjcD/YTqVzDRI/ki+RHU7qm0+XlpNTdQwm0KywIQF2BK1HHh4AAxXccbPPySSGKfg46TY1McVt/U+AjPP/eLZVswGupyKR8EKtXrS8QgHeKlpgkfOmKSCQedOqYjpMZI24A9uF6C7cTwmIe6F+qaFXQpm4jfKgPz770LYbV4DfgF0dXismeTcZp1zrgQM5VDJo6aUK/3vPn/sIm+TF7473bqsSxShKvLRnT06tE3NWLgXkPKcjOnAmKUYzOKlrv66sHaUQdQ3a7HKdSB8OLEHotEk52pQFB97AU68vjimvaUQ9Zh81238knHy/z2d4WdYAzYjLRuvZ8UKaF7PDniuEvDYwIfxVQTxBRT3D+lt7kvL9w7Kd/7KIx+QAg1tjVW/zqJUXq24jz2a2VpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(66946007)(186003)(33656002)(66476007)(1076003)(9746002)(9786002)(316002)(66556008)(83380400001)(8676002)(36756003)(26005)(38100700002)(2906002)(2616005)(5660300002)(86362001)(966005)(8936002)(4326008)(478600001)(426003)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6rjHccsEHs3aHhIMNFqcKE823bzCVhmQWOWMN1xXGjsi2AppLt8cqCbgx0du?=
 =?us-ascii?Q?gG6OAyKhAinex2oI/menRGgXP0Mx+6s4wdQbRQ6Iz4CS4WkfCFpjBxGs/Muo?=
 =?us-ascii?Q?vFCnl7eDPAhPiPa2cLfP7Hiz3abrL1Dby9yl1UZBuJTOnzFugLXEeixeG/+L?=
 =?us-ascii?Q?7atsRyVZop/HRhZk6QV7eTgSlzXpd2r9g3ltR67QQ6Wf2zDdj5xDS0FaKO9x?=
 =?us-ascii?Q?JpcG4WjRF7qSLiWvHeuRIIgmoXC8DlkfOXDfa3QyDqJeFNcv2/wK5masRyc/?=
 =?us-ascii?Q?IFYrDq8xOsU2ekAGVo2LKFCfRz4nEntm8E8RaOS2tFP2aS/puX/mkFWsNtmU?=
 =?us-ascii?Q?FalSN67jcSwnBLM/7NdARgeWWd4cazQAbS9SDZmqC24WCK5cw9TSDfGfrlJn?=
 =?us-ascii?Q?pe57IotKG8WIiX+Yhe2sOJZYyvNXp+vQ2FZ75CsO5pL6hLHSLA/mLBTzkY+u?=
 =?us-ascii?Q?1Z5BUs6k0U1hW7oKzaiBFkDQFybTsC/X/hf71aIjmuoOwTv4jIH54rRo/m8W?=
 =?us-ascii?Q?QtX3X86X+9UBaFsyJkC2vvrExfAmQ54U4tQrC/k0pa7SXmQcq+mYIfRoxJ7/?=
 =?us-ascii?Q?nojQswwrTNByKDeZEdzL/Wgbh/p26YKWH0/I8e8Fjkn8Sje4t48DEjf+nidd?=
 =?us-ascii?Q?BLu3jiEw5wibbm7UfSzh9EhQD9TvlcZj5TuSOw8sJxQKyHZAG/btpBODZZhR?=
 =?us-ascii?Q?ucnFEB9vy/X6ldO+9c55OQxYRFSR/d3h2Xutm3LoZQlXFuMTDUP0eEfCOEVJ?=
 =?us-ascii?Q?pgbJ+WqAQ+6DcyxvBE7sAsQDVDA0Jip1pn9K441WEVYLURobUtnpJEwNQgjO?=
 =?us-ascii?Q?dLzOQfC0/+65RcjGnaB1iyE8nWeIzagsu4+ZME8qBSn/FeBxVd14WDChGMfB?=
 =?us-ascii?Q?T6nxhLmb8zcXwALBAskKiL72IdyAoDlGbnA7OBS8kOytkFiwCcx/SkgTroMV?=
 =?us-ascii?Q?1ExOq5GIH6CFH8qOLVIPyD+/6Y3IBXLMR9YkUzi07ZCvrkKwLyEokso3RxR7?=
 =?us-ascii?Q?fPuqK4D1DP5IsWsCScL1d+KLose7gNwMFcvHnw1LVF9FSjtpRl1LhcRdjkwO?=
 =?us-ascii?Q?nCubrz0UDvanyg3VgjcEZbBB3h42V9MhLtt4rYcYdLnll9Maeo0IDcQjdUb0?=
 =?us-ascii?Q?BpKUkcRmTJwRSWada8lYL45h/wFfTWsdlsJktHJE9GijAhT2xAshJUBjDrNk?=
 =?us-ascii?Q?xE+gGBnHAGKsC9kvn5Iii7kCj0KPdg/NH94WK1w//DS5eKWOlZDyEjW2G5DS?=
 =?us-ascii?Q?hvUo7m2y6LCvwY3pCD1PeBkvywCtwhP2ZzeUSlEO48uf5rDFSzxjZaGMs/PS?=
 =?us-ascii?Q?OdquGBDfuTQif80032cBbEpX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f52f34f-3ec6-44d4-4bfd-08d93fce8dd2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 16:04:22.6391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxihEjEX69WySyaEe3j5zJLzi0uWfRTKmhr8B3aA0XGID73yXqZ6/H0Jv+tiyosQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5524
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021 at 09:15:24AM +0800, kernel test robot wrote:
> Hi Shiraz,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   e04360a2ea01bf42aa639b65aad81f502e896c7f
> commit: fa0cf568fd76550c1ddb806c03a65a1a4a1ea909 RDMA/irdma: Add irdma Kconfig/Makefile and remove i40iw
> date:   4 weeks ago
> config: arm-randconfig-r005-20210701 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project e7e71e9454ed76c1b3d8140170b5333c28bef1be)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fa0cf568fd76550c1ddb806c03a65a1a4a1ea909
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout fa0cf568fd76550c1ddb806c03a65a1a4a1ea909
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/infiniband/hw/irdma/uk.c:934:6: warning: variable 'total_size' set but not used [-Wunused-but-set-variable]
>            u32 total_size = 0, wqe_idx, i, byte_off;
>                ^
>    1 warning generated.

Yes, Tatyana please send a patch

Thanks,
Jason
