Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FE639D903
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhFGJqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:46:50 -0400
Received: from mail-dm6nam10on2059.outbound.protection.outlook.com ([40.107.93.59]:25569
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230127AbhFGJqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:46:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hrj8mRCAv5j3zzTBcToPbgytqjkqfuPvR4/uLPUAr2qVe2MlobIXLP5AYlAuGQ6Y9wz5xwX08dgjg6H4Tn14hF73+xEwd3pPYzm7xMigeoy6ScLoSI41P+QJCyCOf6aQhavXmqs58zx2yKdKOx8V79WCOwR3lvHnxjgzQOfai3mVT+HpM/4oQ0SFQSsuzlSDlnnSdRylZ29WOtuvsporHj3IvF6hJIdJkPsVGHDJqGoru1ju9XINeC9TV+Tau8TKFuVr+4oahHq9tH8C9zfTfuk8Zky4gupom5qkl2yWfC/NSW6x+1GNp3e3BNZsirzw9KgGvikCKJWlTXjKS2WncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5CLjBYU0wNySQWwbMEpgqXgg9g2t4KlGsCiYEC2jYA=;
 b=NxUoqE63ABnGMB2+OSMPDSAeFMGZLsGdEdNO8msEtePkBbW1CVQqIn9X522mQynNlkREIlw/gMZO7mctdob7XEc6RoJWStj/6hi62eVpHxAxlhVs93OPI0WVV6AoH/URLmO+b/ECjy0lu9sWpMGxk4Gl/Uirpojq6x0RO2GPAa0OntcWqy4YH1D+c5qDIkDlgK1K4Vfb1N0Y8Q70hJIMm/njpmSARHQ2wKbm9W9pq6k6DYLqbVNsa1Nf+DxTWEPV8Y5nCyP+/XV91a6OXgdfkeInoCCeV9ljCYDWFSSaoisjqsTWHw7SKKBQuaEkAI3nHAIoiKmBiYGA9J94Key7eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5CLjBYU0wNySQWwbMEpgqXgg9g2t4KlGsCiYEC2jYA=;
 b=EMmDwyzoTAjHgpQH0HRGv0lFCMmbZ1ZTc63GRRS/WVkFNQvHjvWFa79KVSXmLxfa5k1waM59BJNARzgxLkhmTp/F7nEAdjQJfgcEk1MCSscXcAMrotNTsrxkOIDZDSYoBE2M8G/JqcY0kyW8iyP/OWxk5nGqTDoADFG5Bpxw3tU=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN6PR03MB3379.namprd03.prod.outlook.com (2603:10b6:405:40::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.29; Mon, 7 Jun
 2021 09:44:55 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::502a:5487:b3ee:f61c]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::502a:5487:b3ee:f61c%3]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 09:44:55 +0000
Date:   Mon, 7 Jun 2021 17:44:45 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reset: berlin: support module build
Message-ID: <20210607174445.3d532e6b@xhacker.debian>
In-Reply-To: <9f5bee632ed493b150c47f3127242c259a385192.camel@pengutronix.de>
References: <20210520171316.395de63e@xhacker.debian>
        <9f5bee632ed493b150c47f3127242c259a385192.camel@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR03CA0283.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::18) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR03CA0283.namprd03.prod.outlook.com (2603:10b6:a03:39e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 09:44:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a58e1bed-5693-4aa7-a989-08d92998e7fe
X-MS-TrafficTypeDiagnostic: BN6PR03MB3379:
X-Microsoft-Antispam-PRVS: <BN6PR03MB3379ADDB12B34EFA3D9277C3ED389@BN6PR03MB3379.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5LKnCwu2T62BjuTcZEdSYYrxH9Zk5Ira/FWpHGOaM/ZQs7srHTuzD8XiJCKFuYPaTtNTP8/HaaddQ9l0TpB/1WwXTNuvAdfMsuCMs+xwDXdXKWRWxssFDIpzYTDvEelgYj1zuoSsVhWPJNwijW2wL7iloa43dG9cXRKdkYkqzvRA5UbqHGiEr9t1TJMy6WKUH/g+SIurHdBmPiu0EOgeKQ4sr7jcLJ2mnD3jFLroyd3SbU4uEXVxfQ3tzomIbGcECyyfAsPqoyJ7fvZyffXHifYgaLURSBQyu9DXL+FdREZP7qiuvNxhYbW5XkmZ/6S1+wtDw54fNAB8FMcbTdTum/bjsdOCgUMIELMx5nt6pflmCqxhyvtVCDBRVnIbK9IcjwdCV5PSqKtMuLjn/i4O0SGcep6yOr7QnxJZYPYxAzswX5j3IyvsAJzTWRsqktohoNosrzEW02wKkrMg1s5WGXQ87+wUeY1Al0LD3U5FTNGkNClhuRxbtCntdCQ4cZqFnJQTKE16BG79ds6vrBCDesWbe1QIQqyTQtaeCKWlt+gOUV3osqyJl/EWLkX2kSZStGHYuv/M/K7wV1pnjRWnDJfrSSRGfgF2z0rpJoSvmu3RHt4kjwA/5TTxQkJTOL9uUaX24soBpjaHcbhD7Sra4rmv4WVyfb8a+7h7a1ve2W0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(39860400002)(396003)(366004)(7696005)(52116002)(8936002)(83380400001)(6916009)(2906002)(6506007)(86362001)(4326008)(956004)(55016002)(66476007)(1076003)(66556008)(9686003)(26005)(478600001)(186003)(5660300002)(38350700002)(16526019)(38100700002)(316002)(6666004)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zeqHjZcfbwDvAqhdsCEVh4tZki0Q+hZ6m/2JKN/efuhMREpSNmKS9HE5iKg3?=
 =?us-ascii?Q?YDeCNfPSE+dePY1k24ZiKgscwFnIRBzbN09HO4VnbVIFcTmjKTcMwBII9dyN?=
 =?us-ascii?Q?S76STWeGBZJfPGXVhIhly0TY3NjfNPHmw/Jft0fwAsjThCxTOlwSlwxsQrdy?=
 =?us-ascii?Q?xpsEBCYlKyUcwAp7BiA7FWpiZH7mbKUUL2MgbeWvyXw9IyFSV2YihjnkuYV+?=
 =?us-ascii?Q?APLGKbiVOie34H+aQgaNVWz4fJq0bT+8TwAqx5uD6BY/tjCxDbFh2WK0WIIE?=
 =?us-ascii?Q?lai6YP5Sd35M6Rpizqd0jIhQWY4rf38azugkDLsWT07mATBlJ2rsjlHUdYTq?=
 =?us-ascii?Q?Ac82NrNksqa5zddKBUuyOiiXiB6EjODCy+z15yMqM55dgSFYRnbRynbwMHfD?=
 =?us-ascii?Q?FjdtVv63pdizEu7zJhq15H1GIDQBp+B0xR1PnSbU6G7Ze+zOZzVouFsEDkNg?=
 =?us-ascii?Q?QHEj8Nx1+fYCSuOAtr2SJ8q2LgCHz7KxA6PGvP7TwRMgnMPJjHKGgQz4q5wz?=
 =?us-ascii?Q?5CMePUq1KU9H++MGawa0P+N1MaZ3TnhtCOIQciPjZkiXfH+6hlhS0XgdeYqv?=
 =?us-ascii?Q?IkREUFhZ84/dCZNLUPoeZzxbeNBZWo7udTJ8lzYDGvAEXyVWPYefkR1dcLL0?=
 =?us-ascii?Q?ofaGZVYA1L1lJb+ouF3UfeRl/Hif5OPHJZIsf+bZS/V4nOyYWdKwFAA17umY?=
 =?us-ascii?Q?BAhIBlZWjq12rtSTwuGH+EAquDUUbt3iCTc07eEldycRzQD9psaYDj91lATA?=
 =?us-ascii?Q?vyUDpcc3Y4FyRrXWCmnHcgQKDNhBTiwsxu1v7YamdbesB1bMUeaeR7ez1Jlp?=
 =?us-ascii?Q?xJgrP9hKW9ayWRCp8/gZE8VKLrylsR32matT5CDAzgguB2fXKHdPGQcUZpNI?=
 =?us-ascii?Q?gKhLREWAaNORAS9qUXAPY4Ohsc2fO8z/y12Cq99snhz8fgX4kweTMPj26hB4?=
 =?us-ascii?Q?WCp0VEIVMwIT0RlKVM30lAMYqbXKKUh909X47uYSKXpUGbQnSbLGdzd7ljce?=
 =?us-ascii?Q?Ml5HNxyZZAvdrcqNhdS9oKWooeWarMFvbXyX40lxEmPV5uMdlZzaQpZfg5iG?=
 =?us-ascii?Q?VX+nya8wN57YK4YDYxmtl5HzYPyy38WfFheWoUQq1oMQHzsWHrXBVwYrqG9K?=
 =?us-ascii?Q?/R+7Ia8hJ8dUiGPnk/xWbCL3gka1JDp9sqvQlIOcC7MkOsp8pifQXL0obl/s?=
 =?us-ascii?Q?Vw4cgp3urvC1yg9K7326OS3HSkEDAnQ1bQYBwMoQ4nKj8tjKY16IZbH+t7wE?=
 =?us-ascii?Q?XDnHO2IVdKFkJSquP8wSYd0Vu43wKCcb33y7N0LvvyynOxhD4ePcZdOGZVSt?=
 =?us-ascii?Q?BvQaYB8cuPOCOAsTjq1Phl6J?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58e1bed-5693-4aa7-a989-08d92998e7fe
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 09:44:55.5223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLLH52PclYbM8AC4kz3vA/aCTYJxujNdfNHaCutF4nrdzRshXhJZzjdMXxPsYYml8uBmAzMJoUt0TENrwYbXsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3379
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Jun 2021 11:23:57 +0200
Philipp Zabel <p.zabel@pengutronix.de> wrote:


> 
> 
> On Thu, 2021-05-20 at 17:13 +0800, Jisheng Zhang wrote:
> > Make reset-berlin driver to be tristate module, support to build as
> > a module, this is useful for GKI.
> >
> > Partially revert commit ed4dba99cae8 ("reset: berlin: make it
> > explicitly non-modular")
> >
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  drivers/reset/Kconfig        |  4 ++--
> >  drivers/reset/reset-berlin.c | 10 ++++++++--
> >  2 files changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index 3e7f55e44d84..1e7443a4dae1 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -43,8 +43,8 @@ config RESET_BCM6345
> >         This enables the reset controller driver for BCM6345 SoCs.
> >
> >  config RESET_BERLIN
> > -     bool "Berlin Reset Driver" if COMPILE_TEST
> > -     default ARCH_BERLIN
> > +     tristate "Berlin Reset Driver"
> > +     depends on ARCH_BERLIN || COMPILE_TEST  
> 
> Is there a reason not to keep "default ARCH_BERLIN"?
> 

Hi,

After this patch, the reset driver will be built as module in most cases
so I removed default ARCH_BERLIN

Thanks
