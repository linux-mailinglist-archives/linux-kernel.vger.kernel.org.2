Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280BC39D965
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhFGKPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:15:12 -0400
Received: from mail-mw2nam12on2078.outbound.protection.outlook.com ([40.107.244.78]:54241
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231169AbhFGKPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:15:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SV950g7/LONEqCr9OKcQ1K6MzuIGMUCf5BWv/DUYpgkyS/1BFfScoRf4et3ykzk0MIZzsBpjfuoiLl4ex7oF9mPSx9m3inCN8U30YSWpkT3zaojGAfuno4cg7oStHMey3knBPvDPZicUZTNsQDXtHar6RxJo6Vlm8Pm1vWvcOMqgLsJEDCiS3GyvBOY57N60t7ra5Kcop5YV5JTRDDUIoV5NfnOgZ/nqXLIe1ryeJI6gwEfLkif6AxwvlL/aKtSr9cYfLj8dZ8OPA8gR1d8IJoUZu+gDO3Z+gmr0/0kH6Uvr17Y2Owg+X16Mua+9jjR+y2b02A9mGIa5VjKgBPhS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELfepVmyXM7QITx1nAM5A2JfCiYap76QF79u7mMOes0=;
 b=GsPB/xL9g/fW+/YleSUJY6XVjdhUhkki2wr18jg36P1WW1neR4HGyuePBVX5qv958CpAHXeldm5OA4uWhClOWBPC7/tFO9iSsktBVnE4KW8hDGTU5uoYOmmxF8OcUP3TGYy7i2AZ0R1iimvI0uwVTah9xbsCTUFNvFvrMCNMH3TIW+/MwbzYvqxIs5CO+TKKn08QgltxnWGsoMdmEZ2bUZb5RPy218H/bp+mfF7FsjvY1igThAhHW6o1H/rROlBb/eaf5YKzPLsUQ1sK0fa/uqLIKs/PgugL9BhSK2mSKAO3rRDOMLKnVcV/4FUZ8OXz8NdWhivzKkgnhS3MyIOyQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELfepVmyXM7QITx1nAM5A2JfCiYap76QF79u7mMOes0=;
 b=Qs0CoqpxpHXZmz65guugz1iZo/KZhUS1d5ATxEHRkSG/ij5JBxodZAEdfF1sngTcmgl2AmGJ41Adb7lKKKbeL6FPILKcQs5myXNUhExV1VNhpE52K1NlfUaZtCagAVlPMtv6CWfbhb2xFuu7aI4iWAsyevc+eP5U5nV78t5hc18=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN8PR03MB5012.namprd03.prod.outlook.com (2603:10b6:408:dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Mon, 7 Jun
 2021 10:13:18 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::502a:5487:b3ee:f61c]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::502a:5487:b3ee:f61c%3]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 10:13:18 +0000
Date:   Mon, 7 Jun 2021 18:13:08 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reset: berlin: support module build
Message-ID: <20210607181308.1d6deb3f@xhacker.debian>
In-Reply-To: <09cc7bc4b14b4995352bd4bd08d3aee556202c06.camel@pengutronix.de>
References: <20210520171316.395de63e@xhacker.debian>
        <9f5bee632ed493b150c47f3127242c259a385192.camel@pengutronix.de>
        <20210607174445.3d532e6b@xhacker.debian>
        <562cabc4162d9f2c0fb3a307213ec1c5b4bb5535.camel@pengutronix.de>
        <20210607175642.1c0e8ba4@xhacker.debian>
        <09cc7bc4b14b4995352bd4bd08d3aee556202c06.camel@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:334::6) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR05CA0091.namprd05.prod.outlook.com (2603:10b6:a03:334::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Mon, 7 Jun 2021 10:13:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7c164e3-db84-41a0-3c26-08d9299cded1
X-MS-TrafficTypeDiagnostic: BN8PR03MB5012:
X-Microsoft-Antispam-PRVS: <BN8PR03MB50125E52ABADFC164E42C72CED389@BN8PR03MB5012.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XzKe/Lc2GPgmJcVsrUbSb+RkvaYpcveNJSVCruYojNABxnACN9+NCYOZG0/ke7rHJOwW9HNNIk0jkzM5RTXNBfXnVPxQhLs1XiqYcLp/Ubfp6XMwQXa55mZUglrpstJLG40iNMzKMExtRp7EXK6YIyIlMFZOpKlS/TotPL0wJeYfyzgsRz9QBA2GqF53NT71dF2uFZrO7deep9neNCnb8Xbmp2diCpluUq6MJmBcpbM7YiwCsB5Hjk3HrYhhEshS/SdVRwO1Nq6zNyLTfxWQIYB+9AJuIIUb+Z1NEK3ylauw8/K0JroTaCLItFU+1CA87X3fI+5uxtIBinKPxZVSKlaMlPrCahxlqJoUpzYFRHMjJNU7iBL9HZZmaysAesBYBvWpm1tWsek/zyfIEA6jSmnSPfjtFCC6DpjrIyECSGYKz7DThW3XdnyBMm9Yixg68lgN1KBkWTrTT7U3nVPJKsbjvNpM3JmFOk3596w1AzRsyjE+8ykPmY382Cye8OKarKHPdk/Qh9vJFotTaooqRJnX6cjIbAb7GjKWQYRzlI6YxhGtwsBdKHClHjFI9nZjGqAYmvPjSRSiQG7dIGzC/r0vblmF3h0+f9CxMt7/b8pglkCrnl0bpDsNNgctrRBBaHWieqfCFKgimBAT0LnkFXCzjUCn7dwSr5uTqJbZWu0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(39860400002)(396003)(136003)(7696005)(52116002)(956004)(86362001)(38350700002)(38100700002)(16526019)(26005)(186003)(4326008)(6666004)(8936002)(316002)(9686003)(55016002)(8676002)(478600001)(6916009)(2906002)(5660300002)(1076003)(83380400001)(6506007)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3usKJTIfhyTvGmP9SpfRysjt92Dq9djvNwmUSPnx+N8VZFZcxFhXToiK6LUj?=
 =?us-ascii?Q?9lcZKDtFaae/a4ny12o1JHojhmb8B45wodEDsm2cMYKt3iIWEq7yqgmF6dbg?=
 =?us-ascii?Q?b5WNdcF95UCF9HYG0vqGk3BRJ4+x+WyQfPum6DnsB4D1kZjbggdvkJDFCWgO?=
 =?us-ascii?Q?gPF7h0KuxfL/APqKAbwU46202ZG4J8HZOqjESY+UyGrX1/qtNGNp2/sBpQCG?=
 =?us-ascii?Q?wU1bX4HrOd3pk58SsCr6gRUi0y0mmAOH8dx/Id14p00FQgTTzoyB5QMJglo7?=
 =?us-ascii?Q?KGtnaiGMRXJ9R6d17mzcCcFE2FCmroXphM2k/7g4Y+Z6U9M8EucctFNMu/RH?=
 =?us-ascii?Q?tElu894KciHl1uqZEMAglBucslhnUlx56raUwQK17553w5hOkyMWl/4ZXNvg?=
 =?us-ascii?Q?6UT/4ZglLL2mUTqQ+K7Lr2gFZ8oCuPKMTJCZF/f7ZLs6rsrG5NUp20uObnMK?=
 =?us-ascii?Q?xzTaTAlh+SR+XS0H0r5xDfyrBNEDMd+cB0qKkhEhJwFI6XjVt7+FqrMOQPgV?=
 =?us-ascii?Q?1Nt6LVt02lYt00PWpk5sxj/pFbhkgqrO/Kux4TO5gAlC0wMd/cB9dqZvxvf+?=
 =?us-ascii?Q?k3KtJn1DSLZP8eutPTPqTnmR4YQwoxcaTsioXGoafdGqVSudP57LozyN2YHu?=
 =?us-ascii?Q?SANG0dKsu4ptU4gN909alwFaR1XdKoqo05ugR6JUmmFB4KTQVuMRkh8brtgd?=
 =?us-ascii?Q?F/GR7g1GvdS0NaaioX4sOUEC4jLJtggs47XircleLsuQY9Sdu6WFsWl/yk+j?=
 =?us-ascii?Q?MaF8tYuG9qM/KgPtvWn1A6nYRPFFFHLW6xs8relkE5p5Aw555SYrt/+AgYhI?=
 =?us-ascii?Q?bXgyhDswtsKYYQsiYiwtC9jP+rDTCxnpsjpoi/aqaWLNSgjKQj5xMfOsH/Mp?=
 =?us-ascii?Q?Hf+Ydyn5979o9V5iAqSIGiEO+94j2IJoCoXHd8PcDNHSwmVNbBr7rJp6Exwt?=
 =?us-ascii?Q?0yJn/p5kjmtZImT6/TZ8tY/NLC/MLa/8VdN8kGPSynM6D3gacexhGHREIhHv?=
 =?us-ascii?Q?el/InSNSgFzZuT2EtsXQmVDKnN220M64WKXi4KOw9cwDFjHwueD3Yo/KAYpi?=
 =?us-ascii?Q?vuBORVPznqq7e3gd6g/9uEfgYc7cRE3nHzd4BBBsFSZd71qQ4sn+XbJCuAnD?=
 =?us-ascii?Q?exTNb2faKJP/EVxUkZQOO/OkMOrxEWgQ06S2lIxdqyA6DMiP/Tcz7daG4uEt?=
 =?us-ascii?Q?IwT5aPkZ4536gaLBDXcf3CBH8nTrekBns40hegF+IDjVJ/r43wIgE5T/u6QY?=
 =?us-ascii?Q?bJGzGzFk+6f4C6YjSxf7F7ayKJmB9ZVbpC3CKskdGCAeFKUb/DKW6lDLb7aX?=
 =?us-ascii?Q?xP4Odjto0h4qBuYz4tKL2jiJ?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c164e3-db84-41a0-3c26-08d9299cded1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 10:13:18.0632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUBulG8luK+Wyiu0hJEK/oVOaNwBXo9YMTP6l2srhRhCJdUhmOz7HS1r8/WYO4/DUscBZUzjxuExBb5Sv65nHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5012
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Jun 2021 12:01:00 +0200
Philipp Zabel <p.zabel@pengutronix.de> wrote:


> 
> 
> On Mon, 2021-06-07 at 17:56 +0800, Jisheng Zhang wrote:
> > On Mon, 07 Jun 2021 11:49:45 +0200
> > Philipp Zabel <p.zabel@pengutronix.de> wrote:
> >
> >  
> > >
> > > On Mon, 2021-06-07 at 17:44 +0800, Jisheng Zhang wrote:  
> > > > On Mon, 07 Jun 2021 11:23:57 +0200
> > > > Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > > >
> > > >  
> > > > > On Thu, 2021-05-20 at 17:13 +0800, Jisheng Zhang wrote:  
> > > > > > Make reset-berlin driver to be tristate module, support to build as
> > > > > > a module, this is useful for GKI.
> > > > > >
> > > > > > Partially revert commit ed4dba99cae8 ("reset: berlin: make it
> > > > > > explicitly non-modular")
> > > > > >
> > > > > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > > > > > ---
> > > > > >  drivers/reset/Kconfig        |  4 ++--
> > > > > >  drivers/reset/reset-berlin.c | 10 ++++++++--
> > > > > >  2 files changed, 10 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > > > > > index 3e7f55e44d84..1e7443a4dae1 100644
> > > > > > --- a/drivers/reset/Kconfig
> > > > > > +++ b/drivers/reset/Kconfig
> > > > > > @@ -43,8 +43,8 @@ config RESET_BCM6345
> > > > > >         This enables the reset controller driver for BCM6345 SoCs.
> > > > > >
> > > > > >  config RESET_BERLIN
> > > > > > -     bool "Berlin Reset Driver" if COMPILE_TEST
> > > > > > -     default ARCH_BERLIN
> > > > > > +     tristate "Berlin Reset Driver"
> > > > > > +     depends on ARCH_BERLIN || COMPILE_TEST  
> > > > >
> > > > > Is there a reason not to keep "default ARCH_BERLIN"?
> > > > >  
> > > >
> > > > Hi,
> > > >
> > > > After this patch, the reset driver will be built as module in most cases
> > > > so I removed default ARCH_BERLIN  
> > >
> > > I see, how about "default m if ARCH_BERLIN" then?  
> >
> > Good idea. I think "default m" is enough, because we have a "depends on
> > ARCH_BERLIN || COMPILE_TEST" above  
> 
> "default m" would also enable the module for COMPILE_TEST by default,
> which may not be what most compile testers need.
> 

Thanks for the suggestion. V2 is sent out
