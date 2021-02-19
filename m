Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD62D31F573
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 08:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhBSHvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 02:51:52 -0500
Received: from mail-eopbgr10082.outbound.protection.outlook.com ([40.107.1.82]:48526
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229524AbhBSHvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 02:51:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pv9XC+AYMmtZNGqf0MB9nbyEh4tpTCHtzkg7QJzmly66bUVZoy4uJIwSZB0B5hZj4g/3KL88at0Da7mthIeRgJOPM9k1MiJCHP9uiJx7CW78JJRllmMt2Wid+qsifztSne3e9BFxcPL4v4Ovkm3UV538Id4BFuihkvKSMvgfADjKTe60BdSlQdlKz7dUXVeAINjK6JBVDDwu5zFo5ynXekFLjX8h1FZT7RC2cpZrepEn6FjkWMbicKDLskzDB8hFpJWd3VGoNbJMS2XjoCiez7yHF4xHgNd4Lpg7oybxtNHRnTb32FzSwOxspniMBswAIy/a8mQEKHmHLEk9Dbpr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QxXEBOWkdBDXZOYf9MAl7dTW5doRGoDK1VxlmeGxGY=;
 b=iWES0Z+drR49x8A/YTopyPWrS/RbM3ZNY0x1IFTBflFDLLGDEZ2MlXfWvjIR3HAUnJ403Qp+JjDNANVmKsxFRsTg6aHZ2kkzk2FSQOq1SEbhzw9c0n/zuvTIc2GLc3BS8N568w97ibPmkNUI9FFquUMt696zRsUOa876pWEqAoXWJD+jgHW+2jO4CoQDPoYyY/Guk6HHDFHwtE9MsuJdxBQjs0o+8/ztLjcqDnFNt0ij6aLezJvj3tEy73hlEsG8FOE8omGyHQi323EcMoe7rdhDhzpsUFB8aPlm6Q38DQBVTP4F+2Tx/ySuew/cA969m0jNgI2AF0wHC/en6iFtyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QxXEBOWkdBDXZOYf9MAl7dTW5doRGoDK1VxlmeGxGY=;
 b=NNxBxWHV7nBa73EXJeCQ03PLxT5em9rJJmyR2HPa0fF0aREnYppQFIfBZi43MAfg+28tShbSDxmp1OKTU/qfFgV6ulAfLmYssSmrd9hmAh2F82EVULAsBI/U/UqBcPCMptXNva8CUudvJKBKPL1z+uyRsIP4ei6ej2nhWDhFs4Q=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB1104.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:a6::18)
 by PR3P192MB0862.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28; Fri, 19 Feb
 2021 07:51:00 +0000
Received: from PR3P192MB1104.EURP192.PROD.OUTLOOK.COM
 ([fe80::7cb9:2a79:ba90:743f]) by PR3P192MB1104.EURP192.PROD.OUTLOOK.COM
 ([fe80::7cb9:2a79:ba90:743f%6]) with mapi id 15.20.3846.043; Fri, 19 Feb 2021
 07:51:00 +0000
Date:   Fri, 19 Feb 2021 08:50:56 +0100
From:   Mathieu Dubois-Briand <mbriand@witekio.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] mtd: spi-nor: sfdp: Fix out of bound array access
Message-ID: <20210219075056.GB3519372@WIPC17090108>
References: <20210212154717.362233-1-mbriand@witekio.com>
 <20210215151414.6542yhluvx3yvbia@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215151414.6542yhluvx3yvbia@ti.com>
X-Originating-IP: [2a01:e0a:4b9:9060:4cf3:81be:15a7:29ed]
X-ClientProxiedBy: PAZP264CA0009.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:21::14) To PR3P192MB1104.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:a6::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from WIPC17090108 (2a01:e0a:4b9:9060:4cf3:81be:15a7:29ed) by PAZP264CA0009.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:21::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.38 via Frontend Transport; Fri, 19 Feb 2021 07:50:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 502e49cd-2ea8-45a6-19f6-08d8d4ab18e5
X-MS-TrafficTypeDiagnostic: PR3P192MB0862:
X-Microsoft-Antispam-PRVS: <PR3P192MB08624F191C593B64E8C0E930A8849@PR3P192MB0862.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:393;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XXh8rHATO5vV3bn4FCnkj8oZKIbhnBhz0s4nL6aji1+3SxtchC0X8HhBV9tLlDXB5ismAOz19i76iHsBkTNqp+ALpjdKpyig5SzZPSo7NJK+Ey6gswezz0KXx0KQtG+e7Y8v+rw+QSk9plfswXw349I7PqFol/HySnivUXjWPA1SO21x/CeaMtY4Tgqy0JkJ4KXG/23PY/b7VJ8ugvTwAp8eXdBmmNsPSQFvVdcBH0q2qp3g9jaWsOpDbQ38ComuCW4wHzjQ263xnD6OTRqTZw3duZKOcdn4EGBaxwFGpXGOFXY+FzBR+rORt4W0E9WcE7jgsuf0fHzHq1YbgYLj2C5EhcCmW1zmiO9sNoPINrJtdTb1xFxUigSc7+fHEgE84VUNWXdLDJ6sakBxMOZ9aX4rZWyFCZ6r8F7s5O3c04R5aqPVH2oRQHQHrjO+yioyMg7BsQ/hTGu2YgkJ6+oMoMDeHa4KgnB8Z/HdGKzjqaRHHleVKYRkx/iPaFICIcMjynHtqNj5nnOdBSkMlOgibiJWWMuUp46mM9Nfo2nvP/7rqfPsMfsa2hcog7B++URacffqBZW55Ib3cLyc0bdSeh88WzH4Zv+RxLVreEbi/S0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB1104.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(136003)(39830400003)(396003)(366004)(376002)(5660300002)(66946007)(66476007)(52116002)(33656002)(6496006)(33716001)(966005)(8936002)(66556008)(8676002)(6916009)(316002)(478600001)(86362001)(16526019)(186003)(9686003)(55016002)(558084003)(2906002)(1076003)(4326008)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?f5ihCfsHryx6Kc4oVxb/LJwaa4yQ+AXRIzqauyhrODuwjEA5xjXSoD6JPOSp?=
 =?us-ascii?Q?T+ktY9UML70ebNbqBlxWxy4pHrMtC2zwoVRO3jGs+JDE5mY5RJ47/qAhBasU?=
 =?us-ascii?Q?W407N6t0wDYAgxJrgdDScpmf7dfj/3krIeizwR3KXBxy/blUVpqChA2/lId/?=
 =?us-ascii?Q?q3TJs5wUl4En+G7O2LzT2+L8wL6ycgQAm7EilANA63gWMhb/j+ZTkDdI58FC?=
 =?us-ascii?Q?ssm1RnbD2SvYMJLvSFIyLsFDy2WglDW3P0qGnfTbwCYWuHzttFNV/cA4HzLT?=
 =?us-ascii?Q?KWcqXvGQOtyMKcOt+jyKC2oEGAXts0KZz8xvo04brIL9l2S0jjlYxHRmHWtp?=
 =?us-ascii?Q?AB3d5lY+a35lma0TUC++QMM9k5cplHTdUdk8Mfm23+fgGp9lGMGUwLEiuXhX?=
 =?us-ascii?Q?ahuBtOVOUBSmIufASp3a2vgokL3nTGhLG5o/6d4df0puNBJSI7qAPcuKmj0v?=
 =?us-ascii?Q?79YV0fVL1gOsRy0kixUwuNjo1jEdQ8eYVrYEjVKvii/niSRIm7EqurEVI93S?=
 =?us-ascii?Q?Eg3g3tRhVgaZNcMXMbPd0/i4QeFVCXuvpTlgn44O5ejcBme2cDtFuo/PMbcJ?=
 =?us-ascii?Q?+dl/G12FrlUg6JpfV+H6RU0NsDuyZGa+YTSNsMqtoR6tSZAiWacF9UEKbrPS?=
 =?us-ascii?Q?JQvlKAD+ddBrQQdFmjrGykPLpK8tuSAQT2LdhRrgJHE416GZubbFjrSF0jyp?=
 =?us-ascii?Q?ZBwFVAoYzyZMD0zPqp9QhDyL1Z1DE0I++QnQE3plL55i4tIJL6AuIp95hRQu?=
 =?us-ascii?Q?8QpmlfVi8bESwuudSLbNaoCagkd9AGpMuW7WwQC0L0y6tppiyxFbRL7DjoJz?=
 =?us-ascii?Q?36e/7Ojo7r2QYTYUlnQEfzdIAy0uTLIFCUBPji1y9P8c2XZxuogHM+19uKA9?=
 =?us-ascii?Q?1WqJnMmmSzzWXBsEpc5NKPQ2aIHi05B+JOFiSg3oxjMkAcVQPMQSxPyb9Pqi?=
 =?us-ascii?Q?vSEimVMzE3DZq+SQGN9IRZSqhl0l08NkJ3XrD7QHoemoTLZ6sQFkYeFBrYY7?=
 =?us-ascii?Q?nzboaLfBHhQM17fOom0U7Y5WcIdigrNhD4y18QVwsPsVQs/2mLQYeNPSdjKo?=
 =?us-ascii?Q?GBSkBYIaNl0Vu7Y9r01Vmr5cTjtD7qHjiJIttHgILbIL1Mp6oK3G9GHP4mLO?=
 =?us-ascii?Q?sJR+NOEPxFs3UYyoRCIwD41cF09VMEMgLFxOFgJptEhsSQViPbAwZc8hvrCv?=
 =?us-ascii?Q?cwZzCeai/gqaDUvwyB7vz0QpBfHyv+l+fkZXdIeCIXnfqMNoGhv7f0PX5PJg?=
 =?us-ascii?Q?1JLepa4fQJA86EwhaovE4tjbhCHBdmZ+VV7VioKN5C6WoW7kaz0EbFOH1IZ1?=
 =?us-ascii?Q?3RNXzWtSnMK/6/Q3NYzG9EEDfd6J5TVImH2x6u5OsNeu3YbnxknhqD7WF06e?=
 =?us-ascii?Q?L4OrhF44nGB2JSu+trPavrSLD2W6?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 502e49cd-2ea8-45a6-19f6-08d8d4ab18e5
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB1104.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 07:50:59.9230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAKwPnfZPm3Y5cYJxmN55xQXwjTnFAg6aJUtNkAx2eLD3XVBhZONlI5lRBVlZ9hstWMKz//5UWkGui8+7TzxdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P192MB0862
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just came across this commit (9166f4af32db) in spi-nor/for-5.12:
https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/commit/?h=spi-nor/for-5.12&id=9166f4af32db74e1544a2149aef231ff24515ea3.

So I believe this patch isn't needed anymore.

Thanks,
Mathieu
