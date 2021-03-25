Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463B934879E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 04:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhCYDvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 23:51:04 -0400
Received: from mail-eopbgr680042.outbound.protection.outlook.com ([40.107.68.42]:32174
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229500AbhCYDu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 23:50:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2yJ5kyXTPXAbpgWyZC1fE+A4Y7wkzLSelCb3R3VWpvxBUMJuGC49OANT2kbhT1Unotk5DwhRr9NqcwDRhlx0TjWQe+9L1KHcpg3A89RPFZJ6TJxNkbAsxlSTWV/T5rAr2crZS+ZqAMqQ7dySR/nGh0MzvAvoFOm+7LxgHV2u+H2miXUv5izMICTeGLs2PJ55+DK0zfBXCT9TzXcuNMT8HXc7luRnPagNChI7OnE+3hzG5Zs0ZVCd3y9Y/UIWih1QBXKa5v0EfYJRzOEWJT1NN6Rtru1M7RxAKOsklz9/Yn5BIvm+5pYn0DN2YdBSN8zcJqV/wUvPqsgluXYFoMYPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5t1nY3AMFrC/yYGjjvlSs+l7IF9ZRoOANMhtg1cwik=;
 b=l3W6WD0d/tapfc+1tb3mqDoE3cb4oVC0KGsHo78xK3x2dzcyZarxNklajyl6MDSj7fxwwp+R5rQWJCpJNYDuLGq29+7hRuCq1AJ3DDtLQtrttr0j9h14UmaJ/z17AObNc+pZtan1Vi9fCrkKuQnSuDqV76jWL912WFUTEhooja2FiOrauJum0iBt7uII0KTs4g6t64OxiVmvgzcjdWhrvdF0HQu19zSJeZHJATN8JVvobKoO/qoRC2MlHy/Z/IuJwxdNKaoGGA1Gao7T6Bo5aAQOuAJq52Q2jIJnF8tr0opR4IwcWuxIKTUSakLlcqgxVgnKzO5nIGCv6PBAKjMsPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5t1nY3AMFrC/yYGjjvlSs+l7IF9ZRoOANMhtg1cwik=;
 b=IM4t1fcTCOjxHbr4nZe5f3kwDv1a2b2Hcm0K2rbbj4zGwNwflNcAcF0EcA5MPnAZ3vaoYUMvO+LFBXi8ezOTwgxsKWInsog+o8tPTo6Z6UJroZzO4efKgfyzOGuQw5M8pH1KiVSie2lMiO2onVdhFh4HqCE648iUujuUHZxd3So=
Authentication-Results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by SJ0PR03MB5663.namprd03.prod.outlook.com (2603:10b6:a03:27b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 25 Mar
 2021 03:50:54 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 03:50:54 +0000
Date:   Thu, 25 Mar 2021 11:50:43 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tee: optee: add invoke_fn tracepoints
Message-ID: <20210325115043.6c00a33e@xhacker.debian>
In-Reply-To: <20210324105313.4ff3ad07@gandalf.local.home>
References: <20210210144409.36ecdaed@xhacker.debian>
        <20210324143407.GA8717@roeck-us.net>
        <20210324144853.GA5718@roeck-us.net>
        <20210324105313.4ff3ad07@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR03CA0334.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::9) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR03CA0334.namprd03.prod.outlook.com (2603:10b6:a03:39c::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Thu, 25 Mar 2021 03:50:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a69967e8-4750-4675-034c-08d8ef4130ea
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5663:
X-Microsoft-Antispam-PRVS: <SJ0PR03MB56634525C7F604AE7BF14707ED629@SJ0PR03MB5663.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ioXi1F6qtUA+ot3Y3DgqiaismYZd/s2D+1lX/oMzCTvohI7LoOTDBOzi/91ihf6n6FBTybWfnFRSGvrKgZIK4bJV/E+jBil4UV8LkwfVLstm5mPty+/tMYm9klbgvQrK6JbPXn92WUre5/7Px2eHM0gcEYg6RnlQIhDUxQ8FXBwM0t3CfVYxwJZBK0IKC1LOHnpLoaqsjkCXhNSDplhmReU12dnG0n9KxzYl65AXtS2Lh25N5SgfrWq1ssB1fq1ZYTeP0b7ES8jSoSidfaElonE7S9osAkSWMZg8QRY0sE+ni9P3eLlFtoplYovu/HJqGFidgmk++nOd0CXC7HVooDzxDU91guXiScEBeCgTo5kd+eYtrt0Au1LHVYweicZAmVHJDTr1e1cLhSVUzooatJgQ9Lqfs5TlxuTaGGnsms4CVn/owRvH10GtmzNXYpfECVflC2rdsftBhMS7mEsFb4g4O+KSryJCusv+VRNR9l+Q/kLFvqoxMJecqrD30tss7yMyNI49egFjAX+7ej5oFkUxUyNDzU8KhmYzh0WU5ePSVmM7W26Zz9GmvAnvbXnrN7E+sW307YLQGBzsa+FjQ67s+JJHUKcXcxHJgEBmXRl2BPpYJW+Y9FUCldLB/yHkcdERPaW68o8/QNDtUJyFjpeWhKZLijhDibh6u0P/hGw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(39860400002)(136003)(376002)(54906003)(316002)(478600001)(52116002)(8676002)(38100700001)(7696005)(86362001)(4326008)(8936002)(6506007)(26005)(6916009)(55016002)(66946007)(956004)(66476007)(5660300002)(1076003)(83380400001)(6666004)(9686003)(16526019)(2906002)(66556008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pwgs2iQwmQONIkOB7/eU7/hWkJksEjHcLRCuuwwwwXzXdKMqj8wh+VqFDpcO?=
 =?us-ascii?Q?8L2ri5naKPlVwHzzV86FyMdTtUU32RQuiV9pmYHyENUJXv6vmcyI227vooO5?=
 =?us-ascii?Q?LSfipbH3XyzA5ZfkvgIeDBkC93WgUpJSB1kblDfw/LllkDn/7n8wuCIixz7A?=
 =?us-ascii?Q?JksuUerAbCjzUuLKtdF0H7bDnQlLqOWYlOoC8roiY2U4KmVSWkXtzZVz5y6s?=
 =?us-ascii?Q?1+ztfNdGDTTMHpb2ajTOHbjpjHBVI/Lble6e4c/Nen0MhHyz0KaxDfJxacgt?=
 =?us-ascii?Q?nCjdMYhOMO/ZzCrL5RccKWAdVgsgwXdFmWeCSevKAu5OuOF9ZVegIUH61/jY?=
 =?us-ascii?Q?dFYPxGTPWWh2TAWm8nEjGZe9Np9hM+Qun9CwKNjG0DeFUbvVMtTvOEMax+US?=
 =?us-ascii?Q?9CXSsUSY4/y4G31lPbYxv+TG8ZTfgUxlXOFZtp8yOxUudhEwj2asBQvWDDeJ?=
 =?us-ascii?Q?J9C7WKpa3TJJiKBgfl5EMHj2Lv6Q5MZdvckLZULJeu45Fv0U0v6CGMPVW8PH?=
 =?us-ascii?Q?fm7DkA+AsrWzthTBXxvHFJbZxCw+YkmkE3D8DL7fycr6zAuc+dFRpgjoh3wY?=
 =?us-ascii?Q?oiq7CrIRHAfdDIufPGG44c2O8z5zybMzr/clq0X52UrqldT2e70/YZcdGNyX?=
 =?us-ascii?Q?krotLj+qtYT4UK5fnvh79Aga91ZHeecGO5Uy9VaJkJ25wEqwRFdbitsIwxnJ?=
 =?us-ascii?Q?KiyMM5WI5JK9YIOS+qPiw1+LHno5+DsHsZKbev5RDZdxKP8SPiN52nr4NvXj?=
 =?us-ascii?Q?E0EkG5KhjnwwFYqLsmBU7C4YGWpg7A8yy3zpKbpl6yIGNNPz/UGY+B6XzTMc?=
 =?us-ascii?Q?UlH+eoQ3RmThBk9UtNfFHy4KrORyNZft8s03uU+3zEALHkYC5GnZPgSL6+2T?=
 =?us-ascii?Q?Q8djBMxi73wyLU502UeCkM3t8l7Gulz/x8EipVVOQU7cse8fD2TZlKIAMj5Y?=
 =?us-ascii?Q?xCUlzr1AZes++1pso0huEYkjhqQDXn4+6j+Hgj1h/nl6ms9ectmtsUO6gpmH?=
 =?us-ascii?Q?6qfHWPsKFWLWeibnqS8aUAkoWxk8hRl9+4UPgibiKs+uERPmBZ1pIxYjMSQ9?=
 =?us-ascii?Q?rX9EOXUywEAtM+FQd6GnLqfUcb34fN577QtI3xU7Tfu0B241TYhQE79pPsSg?=
 =?us-ascii?Q?UpdJ+swOngr0g2IlTRHAZQ+QIq2y+U5lGMQmpFZBrlLBaM1OnY2Sk6DXDQwn?=
 =?us-ascii?Q?lwvgUzWT100js3Fuvc+sRZIgP+MsMpnSxPIt/GHzRg2B0V71b6WQV9L1FC/s?=
 =?us-ascii?Q?+NFSiFhDd+DgQ2v6y4V0c8kHa5AW9yVCB+FPdnoFdayxsqcEvexs37qT4jGq?=
 =?us-ascii?Q?w0Lmi394tG1F1oHcFwXvW5Yf?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69967e8-4750-4675-034c-08d8ef4130ea
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 03:50:54.6984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdOjngUf1d55tlOyM4JN0X8UTouDOD45AUYHNx9aQ+3zUNZ6yLzvl5RFRN6g7b7lEosVPdn5AsBSbUj5wJ9qvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5663
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021 10:53:13 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:


> 
> On Wed, 24 Mar 2021 07:48:53 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On Wed, Mar 24, 2021 at 07:34:07AM -0700, Guenter Roeck wrote:  
> > > On Wed, Feb 10, 2021 at 02:44:09PM +0800, Jisheng Zhang wrote:  
> > > > Add tracepoints to retrieve information about the invoke_fn. This would
> > > > help to measure how many invoke_fn are triggered and how long it takes
> > > > to complete one invoke_fn call.
> > > >
> > > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>  
> > >
> > > arm64:defconfig:
> > >
> > > make-arm64 -j drivers/tee/optee/call.o
> > >   CALL    scripts/atomic/check-atomics.sh
> > >   CALL    scripts/checksyscalls.sh
> > >   CC      drivers/tee/optee/call.o
> > > In file included from drivers/tee/optee/optee_trace.h:67,
> > >                  from drivers/tee/optee/call.c:18:
> > > ./include/trace/define_trace.h:95:42: fatal error: ./optee_trace.h: No such file or directory
> > >    95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> > >       |                                          ^
> > > compilation terminated.

Interesting, I always build linux kernel with "O=", didn't see such build error
and IIRC, we didn't receive any lkp robot build error report.

My steps are:

mkdir /tmp/test

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=/tmp/test defconfig

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=/tmp/test drivers/tee/optee/

Today, I tried to build the linux kernel w/o "O=...", I reproduced this error!
This is the first time I saw "O=" make a different behavior.

I'll send out a patch to fix it.

Thanks

> > >  
> >
> > The problem also affects arm:imx_v6_v7_defconfig.
> >  
> 
> I think it affects everything. The problem is that the
> drivers/tee/optee/Makefile needs to be updated with:
> 
> CFLAGS_call.o := -I$(src)
> 
> otherwise the compiler wont know how to find the path to optee_tree.h.
> 
> This is described in:
> 
>    samples/trace_events/Makefile

Thank Steven for pointing this out.

