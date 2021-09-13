Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D65409CA8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241243AbhIMTEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:04:08 -0400
Received: from mail-mw2nam10on2073.outbound.protection.outlook.com ([40.107.94.73]:36256
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241050AbhIMTEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:04:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gg/AeLy3FB5d+VgYJZLXJrX8RULnNBv8cpa/yxc2l+FjRuv1uk1kKbXbwSUeJ9rW0Ib9EvEJX96LE3+DOXj+51Cri+CUKDFbqY3W9Br/AdLrwle8YpNk6a9Lv/+fu59sHfPUjQb7T1HcgmAsed943HwY8B4HLXravdnKOwKbZXonuRNiGarE3YppgTyd8BQUoqv0WCe3cGKyfTKuyhhAJrRvOI0IKDQSiz9rc2tl9xiKpvQGGrd4tmz1oSKQ8I4DBuvTWUCYMslYbFob+Jhuu2EY/LHDlrfJJ1NBuWyHV+d+oXKGkuQX90USVvbBREAypIspTdWWMo6TpVXGVdwc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YcJ456lQsB0jcdqGrvhomxh2qaNQb8ShGL3ofYnCxGE=;
 b=SbWbU61dqwQNQd1gZFeyMBNPpwp+E46Qi3HSdsh8A8B+4ZnL99hU00Jt+bV3G1n44i0t/CtBqR0jvSQlp/6Cuy32nrUF0OV6sAcI8OekhTd81dY80v0WaqA0iA31WxGpBFuvY2DYNHtH3tkRazabHPbz5IfATp5yOccbu7FHf44mmH4gIoJ7EDhiZFwB76kvUGZBDhm0KQXldwKH6oyc+xnWxVPcc38hf88j9X9/0OKQdiR69MOV6SCxuDYFGzNwDBHkAUO/gi5UAPiT9j8VyIHXDVh0aHWwwc8+K+BjR9WPXkvghoIA94RQcbFhQOk+RUzCvBkdMI9h8q5ze8jWXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcJ456lQsB0jcdqGrvhomxh2qaNQb8ShGL3ofYnCxGE=;
 b=BrcmjdV+ANPE3qO8ztrfxXja4dNQeHGOB1llc1/Le4+HmiiMFleYCnrEMud4WgApNtTXKBCa7TIV5HwySbKWLYkR2nhEKXWLLegU+rEptt5AQv9ejuE8q9DYa5NFb97qYdCNM3Hkp/WUHgZ8lv6ssR4A1/fdbV/uoXNdG6ooB6TZYWpzrxdBXrZS14MMHe4cixyFTjKPwNRw2RL5N0CEtIeO8hLIVpLBjK4C98TiEycPxzHoYpRasP3yVVMSBKrt5pk+WNgwllEwMvGnr6sengbF3NiE59K7bV3027noa0vCeGu/dOQW2JLP8wPu3zeB7SojyqCLBgoMK+gWPARgnw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5318.namprd12.prod.outlook.com (2603:10b6:208:31d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Mon, 13 Sep
 2021 19:02:47 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4500.019; Mon, 13 Sep 2021
 19:02:47 +0000
Date:   Mon, 13 Sep 2021 16:02:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: drivers/infiniband/hw/qib/qib_sysfs.c:413:1: error:
 static_assert expression is not an integral constant expression
Message-ID: <20210913190246.GA4065468@nvidia.com>
References: <202109112002.NZceUwiC-lkp@intel.com>
 <20210913165317.GX2505917@nvidia.com>
 <CAKwvOdnGaVb1XGwYpNK_3zAEyZ0JC1SDjC1UzzFEH=d_Mdi7Fw@mail.gmail.com>
 <20210913183813.GY2505917@nvidia.com>
 <YT+eJY4JoobVsKWu@archlinux-ax161>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YT+eJY4JoobVsKWu@archlinux-ax161>
X-ClientProxiedBy: BL1PR13CA0440.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0440.namprd13.prod.outlook.com (2603:10b6:208:2c3::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.9 via Frontend Transport; Mon, 13 Sep 2021 19:02:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mPrE6-00H4gF-8N; Mon, 13 Sep 2021 16:02:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ea418e9-0c27-4417-87af-08d976e91346
X-MS-TrafficTypeDiagnostic: BL1PR12MB5318:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53185F42AA01E0565243FC0DC2D99@BL1PR12MB5318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NPNDIn3a/tt+qkgxaJC7P4jSKxOWyo4MfBVVABsJgayvsYyc8FQmL6aGIeEAA8XpD0yrEZsKm/z6PeD240CLEBIMg3NksgkiQaqQ/gvWNUMadWgoRAB7AL2LiKrRDnvUr+8YX5uBoLkFNN8hCwB14LLWd0Y4JAVEa8SpTaGJ2YZ09hFvx0DOthWMzqyKyEXclk1eynFm/NKywqYKUB3ksokRmEeZjWuhSzanxVjk3ZxrlNdDdLmfdQqjvQjApjJ1axxgQf8EXzE1dbxG5lA4YryDNrZJm1iWcAy9/m3KRXL5/ITCRYLsSXCxJJ4IcZnrZ/v9VJT84zAxz8Aiw0ARZ/CRUcuQKHCivVO1xdIVyDfKZNq5kmQKG7A2BDw7WMkPC55ldzDNtKjpM038HkOXav3FobyQ23IBDmhWnw6hN/Nz/uzyY8p4HDQ2EO6qX07T5COlpKPoFNMLbZHK198AOiDmm3ZSut3xzXfQ9Mx29jBGmFHkTxRxP9eW8berLxVG5J8qUj7Z2gIp87MfDO1EqbxHJD1rJrcDrx0DCulhuQ4spmlUhk6YhFpDyTH49h9ehC5dFlspbtXZslCkJHRa6Oduab7LXOcMPMEaeFv+WbxDbjCI4064SfwkclKVir0d+KhSYvQ8GscYsasMSK+04g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(8936002)(6916009)(36756003)(316002)(66476007)(66556008)(426003)(54906003)(8676002)(26005)(86362001)(2906002)(5660300002)(186003)(2616005)(38100700002)(1076003)(4326008)(9746002)(33656002)(508600001)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aD2HHpRDPJvfq0XN4fIAUZs3Ybb57V4rZLNRMeqRsonDhnCA2fMbRMgZsKED?=
 =?us-ascii?Q?4hfGOMyLii+4yqBk/cYW/7D1Xv4xCGZ9yJEfyB9GcY4YYJZIEzect6cQd7xO?=
 =?us-ascii?Q?MsftH1qFVS2ypYtBT7aaIvJKPE57C4B33rAQwe/FdyrYADKr0UjJf9Jqy9T6?=
 =?us-ascii?Q?LStwT/vAdeM0AOEqWzcsDbK3KjODYbYxC8ecshYEBEkpwaaLmsLM5LSVcHMK?=
 =?us-ascii?Q?UXER1JEczHoiEGnOd/Qce2aK2dmCCBEi7MLVggL8XQbQBFqD3v2PgCr6zj6D?=
 =?us-ascii?Q?bhH18KO0XtYjRpMZdaJ6Vwa6t2lX51lIOg6YVwMil0JU75Q+mpwGAqr2zYPy?=
 =?us-ascii?Q?9tdq9A00zPyqmEjWJG3+losiTd11TAFbd8wqrKzC/FH5iysaGrg7QH+H5SVU?=
 =?us-ascii?Q?r+SOFFqLceuvkRyT7cwH4X+g49/97uN6XqRZEzSbl85wRwiARGTCoNRfjuDt?=
 =?us-ascii?Q?YcG5MZODSqoeNfVN5GOwhlSvncnejAPFlxICBPtamtv70BvuGxbxIebodGsw?=
 =?us-ascii?Q?ABdCX5YQNF7kXUDz4kBDQHY082U42Hp+mrdEusQ4IxSuNtPtssfuzMCql/3S?=
 =?us-ascii?Q?/5ykD7Qer2dqpJvlYTjWr24+vir02ZBSfCQvekW5pJCO9hKgE/5t9xuuOlOF?=
 =?us-ascii?Q?cBGnWbWM0lUU9S2jzOrdDV90A9FJIqcBmGs+A+WX+hRVEsu6yuYTqkYiP7pJ?=
 =?us-ascii?Q?PEiS/+sdwpkYYQqZ+3EHqsA/k3rXzoFhl1BdgclXpdshAc8dpPDhm4uvyGwR?=
 =?us-ascii?Q?w02Vec3cML4jj+PqDqEmZx5uqf5w8XjkSqjx6VFuRasTiEhWW0CWXrwleWiu?=
 =?us-ascii?Q?/ZyvdcODU4tLmtqS8NK9RS2w1Xe18I+sDkc4dYIokVccbupfEDN2dWm9W108?=
 =?us-ascii?Q?r61Tf44a89DITycHPty+Cg8aKdXoKJm7t6+svFeA53w8U6doll03Ny+OBRMO?=
 =?us-ascii?Q?AJ1J02X5CqGutGP6SrWXlu5Zo8NxfgKEsuyOS+9ygzBSMJ+TWjcIRg+jHXCJ?=
 =?us-ascii?Q?65zAN6Ev+fZs5ow4Ghhqc9PIzIOZAhMVB6xWCb63XsWdOQaeSIlBJNTpuUMi?=
 =?us-ascii?Q?I4PLZU7shFgQe/zHuU7+Nln/ZyQgYngSMTtEgTnwNUOtxX94mA6hWnB936VH?=
 =?us-ascii?Q?v1o+Mw3mucgWvQw7BR8HU4l9oQD0uM/pUIZlduF9Z6yPBoVm14WibKaGFCMp?=
 =?us-ascii?Q?e7drXseuE8BdR/3MGZkOmSjfl5Td9jJcI/F+ze00bRQ84dG9SATAgFRvPlhx?=
 =?us-ascii?Q?0ZwmBD/6s9Eqzqt5V06JrZqI93sgkteOsQ9yu9FE7bHAkgTqlo0abERtEGzU?=
 =?us-ascii?Q?VqHuvUMuBDNmCYW8d8j0BqKi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea418e9-0c27-4417-87af-08d976e91346
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 19:02:47.3488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LP4fLt7+hxhY8WvbYMkV0UHlt0yk31Mm7ZSNbTphm6CRneQX6Vnc57plJakYQVGV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5318
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 11:53:25AM -0700, Nathan Chancellor wrote:
> On Mon, Sep 13, 2021 at 03:38:13PM -0300, Jason Gunthorpe wrote:
> > On Mon, Sep 13, 2021 at 10:00:02AM -0700, Nick Desaulniers wrote:
> > 
> > > > This macro would like to know that the passed in member name has a u64
> > > > type, all the things I've come up with fail on clang - but many work
> > > > fine on gcc. Frankly I think this case is a clang bug myself..
> > > 
> > > Perhaps, though this assertion looks a bit like offsetof() to me. I
> > > wonder if that can help here?
> > 
> > The assertion would logically like to be this:
> > 
> >          static_assert(typecheck(((struct qib_port *)0)->N, u64))
> 
> This works for me with both GCC and clang, if that is acceptable to you?
> It fails if you change one of the variables to 'u32'.

Yes, thanks. Can't say I've even heard of __same_type before :\ would
be nice if this was in typecheck.h along with the other variations of
the same idea. Presumably it is a little bit different from those
somehow?

Jason
