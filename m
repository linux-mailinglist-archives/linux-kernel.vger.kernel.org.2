Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97EE439D92D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhFGJ6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:58:43 -0400
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:62432
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230258AbhFGJ6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:58:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bP6SIBTH+rk5BvB4udySNobo2IbefDxYGra7+QPasS12QnOqBFmsBl2fZ4BrphdVMJbtZK1W6vj3h739RlPJPvzGQSU1O/2Rmlp8aOT1imOL2OLLlW+n+dGU/hhn6Z5qJU6BVGEhL4BbmLTNwLQLHfifZk5tbHMgLaaUxk6a35TNFCJ3KIYlUSwtirEm2DxwMYPYGXLbBvG7MwcW3hhMF9OxWFBWJB8wVhkPiIvQqZ//RFidtMfk+eg8/LYnGgYH+AcSMbmtGqOQ17osa5S/vz6GfY7OIsjWKn/3EXPTz0MP+Xqh178/XykyurHFwQBlRxQbTiu4jA565lqzdNy77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYFDbR3ToFSyEDlZX8pQxY+IHJO88bdH6XJBuE95X2M=;
 b=KUYhHyHIyGSFTh8yL+fgBpMW9fLSi3JFtGwP6e6IHnbMI8jnblb4lT+DuLyuuhj1zPQrB8PqFloPJhS79kFISU4LLHp78+mhu7nuzYogFOuMAyWONxQ5gahVDZdULRKGR+pvmIvZtZ/ymRBHJEmcJXWIQClBQcKafjdD7vGEG0C0XDykzhMFR8jZUjYRNfji6AW+glwUiIElXD5dslL1frhpmvTPuraaBkW+7eaud6wXjLP0RNo2r/SNiGLPxz9JcNt+cOAERuQhLXI79ujefaIpEyFsUEU1S27t5Nfn7L6SJJ9rHw7FNceJ5eITSKlg1YUWfMp0qYKqLXjRNzdPTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYFDbR3ToFSyEDlZX8pQxY+IHJO88bdH6XJBuE95X2M=;
 b=OIPFe6PrQcRtVAiaDI9NWcFRJPTlq5Ptg+ApB1qScM1KlTfjDcDHlfudmGiJzQfhPrch17o0JIe0ItpuA3CJnk2RmIzdNkO74mF6BUB6G6rP08uzEBBp9qdQ8kTdRXa/tm6JNzMdhd3YiCH0uZOi1R9g4igww9raM9BJDnlOqok=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN3PR03MB2194.namprd03.prod.outlook.com (2a01:111:e400:7bba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 09:56:50 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::502a:5487:b3ee:f61c]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::502a:5487:b3ee:f61c%3]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 09:56:50 +0000
Date:   Mon, 7 Jun 2021 17:56:42 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reset: berlin: support module build
Message-ID: <20210607175642.1c0e8ba4@xhacker.debian>
In-Reply-To: <562cabc4162d9f2c0fb3a307213ec1c5b4bb5535.camel@pengutronix.de>
References: <20210520171316.395de63e@xhacker.debian>
        <9f5bee632ed493b150c47f3127242c259a385192.camel@pengutronix.de>
        <20210607174445.3d532e6b@xhacker.debian>
        <562cabc4162d9f2c0fb3a307213ec1c5b4bb5535.camel@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR11CA0088.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::29) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR11CA0088.namprd11.prod.outlook.com (2603:10b6:a03:f4::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 09:56:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b09be89e-adfd-4ae4-21de-08d9299a91df
X-MS-TrafficTypeDiagnostic: BN3PR03MB2194:
X-Microsoft-Antispam-PRVS: <BN3PR03MB21948A1E7E3D1A242DFDE8FFED389@BN3PR03MB2194.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0yCQ+ktt6NiClvldW9Yr1pSSoMXFgZDQaGOTgMXnSwteRc3jFs8qwPz7MkPSv1OjmVIksCMJ/704fE7PZdQDVxaM/5iUNxGHGiFT2CxINTSLwuE+E6+oD5wtl7REibjbaebZO3gL1W1fWzLQMy9bfMrNB3AsrGCmZM8x/EsItUqDV4uNYGKNKAXKm+hs0VcmC9m7qM/NVE2x9kXINsqMz2dCc3kgNotL0FH6BW0RDX5ELSnssQfBaQRIFuG8Ro5sXfZNQThe6LdBTBPxVPwXeUAr5C83vfSjZB7wz2OWHK8n4WeeYbK1xQEpvDpCmAEqP8PL5BISYLIPZ5q+wZGZtLlq7EnAv+GbeAWs7691ZHJPwpin43vdfgtbNQI8kJGqQM7W5TWzj5Qnxw91lbNkHrY1DLJrChNEojCtlCZXwB3uAZHocAojdwBgvqlnkyu7g+RsmlIGdL5SXHsZ5qZz7SKleZfbxejQ6AbFPhix4rAGChZsBLiTtCSaeihlAlbJzflZZecIsBkVsBdj9WbhxqBJtOPFUqkYOh2oTBNF8V7UraidtJymAAMa6TyjX65HdyiLmZ4ThCb9S0CgrS7xrHeNb+/6P2djKmwywMSdxBFNLZX7C9UGaJ+EHc+yqVoYEv8EwVGXiWIBmvp/wj8Qhpn1QUlMdO/eC8iDz3+zC/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(346002)(396003)(376002)(136003)(5660300002)(66556008)(9686003)(66476007)(38350700002)(55016002)(956004)(38100700002)(8676002)(52116002)(7696005)(6506007)(66946007)(8936002)(16526019)(186003)(6916009)(86362001)(6666004)(316002)(478600001)(26005)(4326008)(83380400001)(2906002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?s1ZmE+mCmd9aKOF07lOuUhS2E9tINTaTN4aDigOk7MxJQUTXgG+B3HHD0XZF?=
 =?us-ascii?Q?jiXVNsmeABe2zWuoyAcig6D0jd6NYrXMeaWCa5j3vOJ3XATFll79YBZrsWhq?=
 =?us-ascii?Q?pkQKjClvqX0XFDM1qqOmbDAQMOiLp9eR1x7gNgb3DkvRVe2Jbtrdc8R1KMG/?=
 =?us-ascii?Q?TID2u8pVrFdApe7PjzJeJ3uRfV+kfPKod31e+syu2FJiSYAgD/nloBGHMKob?=
 =?us-ascii?Q?TyNYh14+6tneI5/qArwnC3kTQalsNHnWcFzxg7lvU09uV21gIm74DLU7+tYy?=
 =?us-ascii?Q?EYQGkIn9s5c9GR0m1hFdFVicXgs3Tl1FwY+z1eIr9RaAMHkIAxsW8CPXjGde?=
 =?us-ascii?Q?oQ5jGBV+ORrxzDxWyvdDE0Pg2tD8ENqFNHOgptzBMG257LwowevvNJEHI3ms?=
 =?us-ascii?Q?75bLtA6MwxgiryVNtAd/NRc38tUC18HYG9xL0m6QNB8F+sK4OmcQyVVG/URj?=
 =?us-ascii?Q?F9w52C2nL6b7L7Jiz+JpLX4bLi1N1y87h8ZgW1VdSPQZw9n4P4NbS+1WR24o?=
 =?us-ascii?Q?LbzY1BqHv9sLhtFfx2zTK1hf3jjn4ZpxHSCPOTx2176BA67/jZa/iwhMnuKv?=
 =?us-ascii?Q?4Nw/95AFN/xmUimqiYU16MGKQlzm4l2kMaLSlPZ+nDksJEXteq+gZOTnK6EH?=
 =?us-ascii?Q?xEgrCeY5TGPDFtpJvAHvznDlUgPstOLhyCKkgvJiydP+wKTYhRPqWT7eZyNu?=
 =?us-ascii?Q?8kzpo34OM3ppNqVK3yPfCG3ONrXcnqEzgN8pAryU4VB2iuoA1Lldiih11h83?=
 =?us-ascii?Q?mdOEXid4ZechYd2SHeKAC0WhHmK+wpoZvSh5PJKrnudL6NvMNdNXezEkMLEa?=
 =?us-ascii?Q?krwFQWUAbsK3zCwmBe3Xg+x2eZSRYIkUQbNHWSn8KvCqJro/vqroZfK2NuNZ?=
 =?us-ascii?Q?tf5/5GQIW9JLLX3v1oKB2zx1wh7wVMisB01HdgJIlcEAmGcWuQdP1HPkKogM?=
 =?us-ascii?Q?ZA+LxzTYtizw1vt3jSIEArzfnG+C6aCGIpiuUUZeQSoZiJyOr6V5taPQV5B1?=
 =?us-ascii?Q?xPBUQmRH/u3Lw+u/C7MgL1/pD94z2a0Rnj86d71UjtsFy5dv6MCAjOsTcKlD?=
 =?us-ascii?Q?d8I37VxshcNmfvrO8zwqBqpcomebeQkNLdDkmlWBe5RcoJJPg12tdXJ3dnLh?=
 =?us-ascii?Q?zOJrVm+ghnuFf1McLtiBbjL4oHN6Ih2NJ1mbxn2ZW+7r4/SMWWHgunyu7ZWQ?=
 =?us-ascii?Q?LcCifqbNwlDQ8s5L46yrU01HXmFK3J3OEvvoDe3jhsHBndgLUCRMuls0ATXK?=
 =?us-ascii?Q?CqKCwp4kogx4uUG4OdZvZMF0CLkf1kpeEYclY4glj++seEurh+rADRyOh+zo?=
 =?us-ascii?Q?yhVxe2I1hIjTAMQY2IODgwTQ?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09be89e-adfd-4ae4-21de-08d9299a91df
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 09:56:49.9703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzlGbHfAKZaYDShTmL7VWteZceCUYwZ+tJ9ABNnmTNWHAtsk+57UhtWYyxoAv/1v0hz1pKTjn+GrE4enkBw3Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2194
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Jun 2021 11:49:45 +0200
Philipp Zabel <p.zabel@pengutronix.de> wrote:


> 
> 
> On Mon, 2021-06-07 at 17:44 +0800, Jisheng Zhang wrote:
> > On Mon, 07 Jun 2021 11:23:57 +0200
> > Philipp Zabel <p.zabel@pengutronix.de> wrote:
> >
> >  
> > >
> > > On Thu, 2021-05-20 at 17:13 +0800, Jisheng Zhang wrote:  
> > > > Make reset-berlin driver to be tristate module, support to build as
> > > > a module, this is useful for GKI.
> > > >
> > > > Partially revert commit ed4dba99cae8 ("reset: berlin: make it
> > > > explicitly non-modular")
> > > >
> > > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > > > ---
> > > >  drivers/reset/Kconfig        |  4 ++--
> > > >  drivers/reset/reset-berlin.c | 10 ++++++++--
> > > >  2 files changed, 10 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > > > index 3e7f55e44d84..1e7443a4dae1 100644
> > > > --- a/drivers/reset/Kconfig
> > > > +++ b/drivers/reset/Kconfig
> > > > @@ -43,8 +43,8 @@ config RESET_BCM6345
> > > >         This enables the reset controller driver for BCM6345 SoCs.
> > > >
> > > >  config RESET_BERLIN
> > > > -     bool "Berlin Reset Driver" if COMPILE_TEST
> > > > -     default ARCH_BERLIN
> > > > +     tristate "Berlin Reset Driver"
> > > > +     depends on ARCH_BERLIN || COMPILE_TEST  
> > >
> > > Is there a reason not to keep "default ARCH_BERLIN"?
> > >  
> >
> > Hi,
> >
> > After this patch, the reset driver will be built as module in most cases
> > so I removed default ARCH_BERLIN  
> 
> I see, how about "default m if ARCH_BERLIN" then?

Good idea. I think "default m" is enough, because we have a "depends on
ARCH_BERLIN || COMPILE_TEST" above

Will send out v2 soon

Thanks

> 
> I'd just like to avoid anybody getting surprised by a suddenly
> deactivated reset controller driver.
> 
> regards
> Philipp

