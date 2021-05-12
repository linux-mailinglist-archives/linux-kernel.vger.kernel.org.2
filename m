Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC40837BC48
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhELMME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:12:04 -0400
Received: from mail-co1nam11on2089.outbound.protection.outlook.com ([40.107.220.89]:12192
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230411AbhELMME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:12:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kX+kqZN3oGvyh/OAb6bK15S2IqIKCZxeGNxMlvDJM+zdJ5aBH6Ev/RYvcWQvGsFwHtZ6xDVflxx0l3NVXBEJTEswOJ4dKRw3Um15ToN2oVGqYo8raf9Dia+gNbsIje6s6J59gJ+3pD7v/P1TOvQR3VSAfP7oHpjDGSObf39cEWDOsbbQeuqgoaHTcyf1Ls8Q99fLZxmRhdCVjzjx//rRDRonOe/hoO0uS45RJqgk1MfH0/FLNuA5nNcD0aNXZ6B5GululmkhWyAwq16yKOSd0gqx1i4f7XCSw9y2A3Dgfe2bZrXIeU4V34LhOngUhxiTsjBfuF278EpjyoCOr0VpcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frML+m/pT68VW7UE3GCjCPdfxZ6zScIsNCeu7u79rmw=;
 b=QeGabSNwvViPCKLxPwNtiE24VebyuSxdlN5taXHzFeexgIQ7F9B64QPH/W5fRdNLgmiXHf/PCoD7XdlbdiV8eArQaoIiF9tc7kl/79HUe8PCA76RQHftBQYbd4UEbH202+yTDmosvlvanZUIZVwmwXv7J049Nk8pcWtLyXBMJFqZaxwwgZIrhxYqL9JaKfL2uZmSYrSShBYjsewhBIj26tFtpE1d0aVevgxqkAwJdOuOIpVRKn3Vov9vBc8ZG4NkoEpgCNUS8/mEwHbx/DxhrpOXEf2qU/BurGzl/0AGjTrwmoRWFVlVKPXpUAYi6PssWiE34Rr5lUlQwr2bXKakJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frML+m/pT68VW7UE3GCjCPdfxZ6zScIsNCeu7u79rmw=;
 b=MtBhYcZpEak9NSBXXjmyDoX4Ci0SUBPDNVut/hehR9bhDoicm+wX1cH4z1Ep61esAkPOSVGo7fs7LpCTF1rfWDu88/x8XxDUyjb9gFnpETF7eIXg4+kgy85VM8/6/mrTnnPg+fJcvXBLzLRREVV8YgoYiBf0tg2fMH0JaKYJRhogqkdfLmx1Pay5TAamLm6/7nVxgsDAPaOfFqf0+ztbioF7Mf//yEQDsePgFjbYzWKqf45j3BEA/xNokwuxd53KTT/JA5NWjL66Y9c1tA0R0esglIqmqtr6zUaBenWlWOyUG6e/W8iKRyHnha0BbCsMhMMTND2yNntyavpGu5723A==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 12:10:55 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 12:10:55 +0000
Date:   Wed, 12 May 2021 09:10:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     liulongfang <liulongfang@huawei.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [RFC PATCH 2/3] vfio/hisilicon: register the driver to vfio
Message-ID: <20210512121053.GT1002214@nvidia.com>
References: <1618284983-55581-3-git-send-email-liulongfang@huawei.com>
 <20210415220137.GA1672608@nvidia.com>
 <10d53c5d-e6d5-a165-84b2-eaf8a3b7dcce@huawei.com>
 <20210419123314.GT1370958@nvidia.com>
 <00c4fa43-21fa-a48b-b95d-a2310ffab725@huawei.com>
 <20210420125957.GA1370958@nvidia.com>
 <20210420160457.6b91850a@x1.home.shazbot.org>
 <25d033e6-1cba-0da0-2ee7-03a14e75b8a5@huawei.com>
 <20210421121224.62382e5d@redhat.com>
 <6ea89655-31c5-233b-ca2a-fcc166b5597c@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ea89655-31c5-233b-ca2a-fcc166b5597c@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0247.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::12) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0247.namprd13.prod.outlook.com (2603:10b6:208:2ba::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Wed, 12 May 2021 12:10:54 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lgnhV-005p0P-9R; Wed, 12 May 2021 09:10:53 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17e84c7b-ed43-448a-e2aa-08d9153efe37
X-MS-TrafficTypeDiagnostic: DM6PR12MB4235:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4235888037204C42E570DEA5C2529@DM6PR12MB4235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uW517L6KY0/BoUFTY9AYKjTUJzeDHbk91B2ZGvM6u6rJFjuEBsq7NTQKEzoV47VaX1Sp7suvgP4vHRxO3YF2xTjyGKQbAK2V4nMS1MuqvuOBh7SzSfMon4ge44UmaYlD6oUaQfykuktuQf2ES5LR3+gC5b7QfpzkDiEpCHIleVe9vHR7OOeYvHMDKB2uolr1ED5V+SvF2Bg0co7lCtSTbkTWxBeZD2kXp0dMNwcWcsn7XJLLjIIgebKM4teckbGtWLoR5+G7SsjrT32OLXFL4BKj6vLZ+3oxW9cw8oLrflO6b0zNsjE74ojgLqaSPuiAxD/M2/VZJfxYLXwIqErZN2Si9fiHS/1I3BjHPe/rjQjHY9XUXlOduCfYb53iXsQVtcRj/qPFQmSFOqqkmK6YPb/EryV5NOtzxn12C8//8n/9Xb2Xw4adUAzmm2vWFfpMs7dFLsWLMObYYMQuvf85Kbz3R3kuh++lUUwQ4z+IU6XqNDYPyDTrx84NFbpLCCQhsb/ObQm1N7hsN2p1Rc+10UN+Sk1ls+FyQCYa8diHr25kxpfntU852D/C/yZWixPPByO8qrSjQFSMnvdBI2UoPjQgN+YnpBfBXeRVLStcrW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(2616005)(426003)(5660300002)(36756003)(9746002)(6916009)(83380400001)(8936002)(316002)(186003)(1076003)(9786002)(86362001)(478600001)(66556008)(66476007)(38100700002)(26005)(33656002)(558084003)(8676002)(66946007)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RfW2C+8y/M3Ym3sq63TXg3+wieHNuNVjGIXUGLh1B9mALf480PC7/2i4mUrE?=
 =?us-ascii?Q?HgqeOqVfA1BgFIc616UjVFZhQ+0YH6DgmdICuJMAxEtTxUoHctpw1E06HcQ2?=
 =?us-ascii?Q?3Q1QT86hQVVrI5YzRegaeG9/xCHFImmuL+oLXxiuFafC0VXIKsSdbRDoC8pB?=
 =?us-ascii?Q?InW3F5Wae3VOiymvlgUa/wq+fGJypJNKRCL6IY8wdK3Kl/yvhMxS5H2niK5k?=
 =?us-ascii?Q?8bOgNdmQMOmyCqhIAh0Vrimcnh4blOHQezxivOWrjPegP3Srw5GtJgH4S5Zz?=
 =?us-ascii?Q?mEKrKtwPzNMI8en3l8ziF3kpwAsOPo5B+eDcKk+S5HMGW/BmxOpVqujmsFn2?=
 =?us-ascii?Q?H1b1UXO73n1LUP9RBK39185mTINXQtxH0LvGvRGv/B/wc00+JsW0TEjbLcD9?=
 =?us-ascii?Q?FMZJb8Uepic3ug28diU0WTR5WgchtAWszOG+511EUX2Gini59GpyqwqxOGe/?=
 =?us-ascii?Q?L9Zeb+NS/aqV3InJITSEAqM2z8G+560E6laoAZdziJXR3olQQ8f1IuGGw62m?=
 =?us-ascii?Q?b1ffyWayH43kXbIWeeBGSCVMLP8UpFVSgnGlLBGroNyK5jxGBHnusqDDT5iu?=
 =?us-ascii?Q?4Q5AbLVtE7Y6iVvL4WoNSze825w3E8gBgyf8YOXFh8Y+BqegMAffHG14MaZu?=
 =?us-ascii?Q?IhFnC6DhZaImk7iJarkfeiQIzXD3qmlqDM+eZSL3xgBOlPa45wgQwuk82hnB?=
 =?us-ascii?Q?J7yJcZeB02ynpQ6y3oDFfzMS9wsmHRn5QwiPrmJBOeqD7E0DXcIsEPXc5ahS?=
 =?us-ascii?Q?JGdhnMUzNvEaUUXqVLnlav2NPchzHCgdSvdr7+sAOApJkyn3fVQ3+ioycsBB?=
 =?us-ascii?Q?jERNdEi+LcJkHQu0/CgVePbvOs/a9vEk+Q6DOZM4Q3+pqaO27tSXtOTgE5bt?=
 =?us-ascii?Q?JdwT77nD6jSe3CgoJNGABxhn16TIhKTLTpjVg4g7R2YNvCpN/qsECf+CtdwS?=
 =?us-ascii?Q?ceexycxnQ4dG6ogE6f8D+gGXdHCiwHtO34aqtAlrQZtmSyf0BUmjAvSiCKsD?=
 =?us-ascii?Q?ozQox3UkcMt2GsNuD75e2G3QKm+X04LqAx6AFKAwjSvHZTEVK70NX2HI4ZMV?=
 =?us-ascii?Q?UyZIgGFH4dB1PF8Jjsdy8Zw4S3pGMuf7CEm+2S0BPu8MeOCCl3wRnh2BcLvu?=
 =?us-ascii?Q?RIPtJ52CsnoxLWJGMxw+yScqGHjRo3RaysYFLCua1S1/FzGmujwCLEsrgwKU?=
 =?us-ascii?Q?Lej8BA/0XoVd1dLYpb4x3nieSVArjEz9Zv17MnCBBd4uQW8IFqR7YAmm8rZ8?=
 =?us-ascii?Q?0ApkpICw67cF4qPF1za0bcgCOXbeUqgfmf5D6RTOcAyxaPdY4pLDZMMPtjZc?=
 =?us-ascii?Q?HWYBfn4xoeeC2375+n/8d+t3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e84c7b-ed43-448a-e2aa-08d9153efe37
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 12:10:55.1714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvsWoOZncRKn+wXivAA5f7PZvhf0haoJcLPg6ABFP2PHg7BBJDaYyIHiCi5uMRBz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 04:39:43PM +0800, liulongfang wrote:

> Therefore, this method of limiting the length of the BAR
> configuration space can prevent unsafe operations of the memory.

The issue is DMA controlled by the guest accessing the secure BAR
area, not the guest CPU.

Jason
