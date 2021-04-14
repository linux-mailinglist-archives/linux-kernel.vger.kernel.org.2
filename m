Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1494A35EE52
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhDNH2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:28:01 -0400
Received: from mail-bn7nam10on2052.outbound.protection.outlook.com ([40.107.92.52]:2209
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230094AbhDNH2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:28:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rrk2oq8fqA5rGf6ASEOmyNyOnUNwzEXHTVBiPNZRp/sWJjzDEBDrw3/rvZtYat27MNC+FzoUgj7byLfBj9ynba7bslpXfCPeeUh1dhJe11Y53DQM1L1/cLl1K8xkz6358XF+GHtokgl9rCaeJ3JaK7g0Achv8ji96xI9b+PXEO5lpUc1Ip0VSCL2KqOqmT/ptXT9/Wwr3IJqg4WpXaVkj5U7Zl18kvXxDOf5EFVfIwlWnbnE2wjrinaW1X071id4clRfSj5tN5RXZiX4adOJyUxE5xneHe99xyxLK3MXMuTeU6MbL8NvpQNO9OVLjJmhU5IibqwT5G6J075/ztvkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6KeXmTjdezb3ZLFeJx1gdJBcxPtpdY+L/67+FZzBeU=;
 b=oRLBW/nFHYMFtXqskfMq0hAFCFnHEWB0hj5KtMb32r4PJabY3KTZdwKobiVPBy1zbKeHFV8kyedIynoMOEmjjEgwxmJahfcJANSar5fr6A4+DiLmJJlooAIIKRmyiG2H0dl2E4OFxerg22RyRzeQiOJyg/+xagvkPujJ4JO72dVQZliSEO44DCxDi5CBwVVOCokUnrEeb15J3BSjprOoHnFNfQnYKxe+x2GXbw+T3Mrt+wHQ09KNFENQk0sHKgBFpEZwSBaI1sng48+168BwKSjGlb1wUrtvQlnxRQtHigIZzFgW+HZ3c1OHe4anolW0UwyNbDV2fQz6X304MPimhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6KeXmTjdezb3ZLFeJx1gdJBcxPtpdY+L/67+FZzBeU=;
 b=NWj9KRECiyoen1GBSdgfsvU45EJekHI0x0bQjMYRTCMytuMvX/D1MlOlbGgMc0PwtT1oWpW/rEUy+cjddWsvqyN6Yr7O0Etn6Tz+f7MRvNc38Jmy1OPM7fLUx7oxZF8F8MGXnV+hx9s1Flzri61oh6X2YsIYZ5bIoou4hWa0h18=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by BYAPR03MB4245.namprd03.prod.outlook.com (2603:10b6:a03:18::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Wed, 14 Apr
 2021 07:27:35 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%8]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 07:27:35 +0000
Date:   Wed, 14 Apr 2021 15:27:28 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kprobes: Simplify alloc_insn_page() with
 __vmalloc_node_range
Message-ID: <20210414152728.418a41fb@xhacker.debian>
In-Reply-To: <20210413220030.d1cbbc63659dcbc52876696d@kernel.org>
References: <20210413180231.19b72601@xhacker.debian>
        <20210413220030.d1cbbc63659dcbc52876696d@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::35) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR13CA0060.namprd13.prod.outlook.com (2603:10b6:a03:2c2::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6 via Frontend Transport; Wed, 14 Apr 2021 07:27:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1838abc4-64ec-46c8-7ae2-08d8ff16c66e
X-MS-TrafficTypeDiagnostic: BYAPR03MB4245:
X-Microsoft-Antispam-PRVS: <BYAPR03MB42458B89C8AC72E59FF302B6ED4E9@BYAPR03MB4245.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B2k6ign1PqTjNQmgOLhxUpA+aAI22tS4lCyFa63V4p60gqEc7JlMJw19GNHV6zUCW9tDqFuYxyXmOqY5Jx7MJvuiyEPYgdu5k2I+gnIb3YonP2+fJ6w6P4WDMYiy5iQAYSbmablRdzIFyA8w+t2o13gBYCO7iq6YUPjcalBEdM6tjr5pQyKziyrieUv82dCVDVipWPfP0mtw1yw96UQzbwC7Y/s49wwPVseykNIxauOHKgLR8fW+sDUIy9/i/sFAgdcozpTxRutbLX/S9EzEpACl4B7rZFsoNvhGpWuZ5nO8dUYFzMy9ohtuD4NGO0hYTeR56UbGuPfZHITcD7oXvqh69I6l63NrPPRHNUIEPCOPa6w2h8K7UxMtxLRqEtnMdQr916lPZRNY8bPamsm+Gdv9Q63JTHiWlpqx8drLTKpV6t5Go+EUoTYDsZ+Aj9tT9o4mTb9SjltlwZjO+vEZXEzfgvWs9w+P29843uR2V7lRbkZJKj++c4lwxKetPzVBE8xE67DN5AEDdUUQt4gofyf9Y1teXm2SjSaL5K686+SFqqQRowMTEvFxMfP3dSalJm/p4SgA8jqW/REEOqhqityYaLzSRpjukp8jysFJ0QY/b8bwOllaZxJ7nBB7PJ0U3MssyuOpDM5F3N+08rrCLzks8UdP0CrcMMAtUFH4szj5dPqKgQkR/vny0LKKni+3oFiWxcrSTPAwLnA5mb05rcdD93hmHO4mSnTjihiv1orx8UQ42V2wDy6jCdfB4x/L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(396003)(39850400004)(346002)(956004)(2906002)(110136005)(38100700002)(186003)(1076003)(38350700002)(66946007)(478600001)(54906003)(83380400001)(9686003)(966005)(6666004)(16526019)(6506007)(26005)(4326008)(66556008)(316002)(86362001)(55016002)(52116002)(5660300002)(8676002)(7696005)(66476007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jxIxH6R05mVW8vlTW9ScU8L1dbdIdWyQ1BwO+6HrYRZDOp1Ah5YXa0cWQbP/?=
 =?us-ascii?Q?VQSCzfB6uraf86xCHp19KHBuQKJtkbEAzknRvmLKrRJ4nxwULh5sSxaZJeQ6?=
 =?us-ascii?Q?oCcwVZnUctW3NoULWEHHNWArQm324oY3JY8QHQP5+6mr5Z5l98Es8DOqPYcP?=
 =?us-ascii?Q?3b32RJNJKJqgia0lKOtLW9sLn3Bx9nztTdHH8MTMITzON8xTN+NmZIquKEtE?=
 =?us-ascii?Q?UgB6WTYaYvVzoCHmjDD+0T2WJnTwfwD3DFneO8YCL630rUiwIKCPfq8aXl8n?=
 =?us-ascii?Q?gJK1noXVPKnhVfT8jXt3Sf+/3a9xMhSL0WeHFovH7fNndKTKryWVCvZ2HeFg?=
 =?us-ascii?Q?ueY+skL208UN+8xYTQwH9OzqgPWC91BgFvw199QO4uDlqNnDgFpWzeIeEWCN?=
 =?us-ascii?Q?py4p5QCmKNy1Wtb9f869gGIDsDLfKh3qCCSX3JpHwhhmCraP1jpNXrEIY7nJ?=
 =?us-ascii?Q?QOaUrS9GD07wZ0J7/sIfB9TpCjAMEv+BcjF3cyFNHsVUYoya7cdPE56slGpN?=
 =?us-ascii?Q?1n0ZgQVFD7kTRBHSaXSnv9FQgga6yq9m3ytlZckwxF7nY2Yec2YUHW7reMGh?=
 =?us-ascii?Q?ulrAvh86FyqHPNjkLjlaayOq0F8GUbYUed8aNKtPNRK0ZJjnjLDaIgRe2pl9?=
 =?us-ascii?Q?el1qXRoLDxGNk9fXDkdGOR0qd10vBoNSLuJ9TPlX6fjyBMshiJX9S/i18aUV?=
 =?us-ascii?Q?ZB54NCbEbXiO4npbYzjbVa6Pud7nHlaEE9HKi7AKmArA3etw/K8laJ8yMUqP?=
 =?us-ascii?Q?fRR9AZGGa2rtkbeWVybTUm0qkeaFxGLZq9v/XyF8qkcfTtzGWKlKtgq0gLza?=
 =?us-ascii?Q?vzO0RpavV4SwXfCjpcbvMAnJrJcGTBRjGJs/kCOJNxbXBmi3YsTFefqWjrqC?=
 =?us-ascii?Q?8RqDQzdSwKw6Aqd17mpkFaCtajQsdNnpBLxNpMIAWvbakZLKEBwHJR25qgqi?=
 =?us-ascii?Q?O4yFKLQIGgVFJEXypaszfz4TsdteUlgj1+AdRVRwibJ9vr084SCEos3Xgfh9?=
 =?us-ascii?Q?SpuuPgMk5HSpiWb8wut3hSjxKBsLiaHIbc22+PB5Rwyzfd5fnJE/w3i6VwkE?=
 =?us-ascii?Q?mdhYES9MnNEX/cjExRmYfeAZsX9rFbjKQKtqlV7IShumap2Gf9xwAWciIUg6?=
 =?us-ascii?Q?NIyphnHpYCNQ7A3SX5DHeYS2wrcgkwIwMZd0b0uJCffiuDTQ/6LxH9bUIEce?=
 =?us-ascii?Q?L/P5bYeQ02MA/yTRboW7uNo7wIOUoQ3FRdo1DciTs8q+NY/aD6DQ70IIC2AD?=
 =?us-ascii?Q?t2x1sOkOdml5GSMGOgQFvYtVOdc+STKidigEjy2tcem+d6UxOQD7fF+T2yej?=
 =?us-ascii?Q?KI993InAQVmZJH0eT/ubUYji?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1838abc4-64ec-46c8-7ae2-08d8ff16c66e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 07:27:35.7861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLDNeTuUyhDnkLRJgDDmJO99w0rgQUBTMup2nWyvWFwWBFngWZqz0lZZsJ+JfqDtZJ8Y72512/xsvWTd6C//+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4245
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jisheng Zhang wrote:

> 
> 
> Hi,  

Hi

> 
> On Tue, 13 Apr 2021 18:03:24 +0800
> Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>   
> > Use the __vmalloc_node_range() to simplify x86's alloc_insn_page() 
> > implementation.  
> 
> Have you checked this is equivarent to the original code on all 
> architecture? IIRC, some arch has a special module_alloc(),  

> Indeed, this isn't equivarent to the original code. FWICT, the differences on x86 are:

> 1) module_alloc() allocates a special vmalloc range
> 2) module_alloc() randomizes the return address via. module_load_offset()
> 3) module_alloc() also supports kasan instrumentation by kasan_module_alloc()

> But I'm not sure whether the above differences are useful for kprobes ss
> insn slot page or not. Take 1) for example, special range in module_alloc
> is due to relative jump limitation, modules need to call kernel .text. does
> kprobes ss ins slot needs this limitation too?

Oops, I found this wonderful thread:
https://www.lkml.org/lkml/2020/7/28/1413

So kprobes ss ins slot page "must be in the range of relative branching only
for x86 and arm"

And Jarkko's "arch/x86: kprobes: Remove MODULES dependency" series look
much better. The last version is v5, I'm not sure whether Jarkko will
send new version to mainline the series.

thanks
