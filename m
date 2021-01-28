Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A3B30801A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 22:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhA1VBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 16:01:44 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43318 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229596AbhA1VBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 16:01:30 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10SJi2ZI019317;
        Thu, 28 Jan 2021 11:50:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=qd5E1NrS1ByISztxeRK6ckQbJD5h4PhaeYEeqpNTELw=;
 b=e8utGTwJr7eG8ViVDWOZvJEsKEn+sPT4Ek53uERP6pydxE9Nrx5OPa49G8pDSag3Nuy+
 fltdI7ddNPFzj+VxjO7cZJTXbF6m1D5coiFJmTQIxxBVngBfnCprwz+9hVRxrg6PVA+K
 1Rnxrj/e8PzzUGJtwFz4GSFREVlnH4ys7I4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36awcpu7y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 Jan 2021 11:50:00 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 28 Jan 2021 11:49:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OM7TA49WrPVbvnyLJeLklu/EbcoFtfXKbWyltVgFgiRQgTpUQH4c0nz8uNHaoH9bErukBNomMWHU0FlpzzndE70obxCR/ChC0To8xaAZHkdjGOpekR5Wn7cQhcZaajuQQx4VfP3jX2Cp+39HjsdVhXdd3VemI0vll5ABBmajktfqnSDYRU3d8iV+uo5YdztaaqmRzSXtck6aRPbp69KbzHHxiWHISTlVE7XzzW/3f6sZvtN+nAc3iymNt1VbJo5R1w7nBEZRq3mEaIbonCvQMFONGFOOLsix3go4PlDu4mdT6al+P0KU6c/TRBwzKbTvzEyKZbBQdhgYDyPxBLdCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qd5E1NrS1ByISztxeRK6ckQbJD5h4PhaeYEeqpNTELw=;
 b=HwBk6qPX24/wGldK9+1xJTsuSAN21ASnrzKintpBDTc3voMcpSO5pKntt6gDDLbQutrKoFItrOpL1EIR0GOrS9h4AqdGwxA/1kUAuTNQCguFcr2U1R9yc07N/CMvJjRgqxQy/+S3sXDcmgSAaFUrYONCPx7bs9ixDxMSTvfeLpvurz3xR5qOWDv/EBAra/1nfczNtiwcZq5MYT+NoPzkTGje3F6INDBEBTgKRc0kImoCYr2evZiF4a5L9D3+SsLv7yxwDuaeYzlnUrE1rhrSQSzaKx1QEnAp71zWgyPWSPmsd0A76nf9j4zMnc3N6H0orSOP+063rRpKA8vvmLfLKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qd5E1NrS1ByISztxeRK6ckQbJD5h4PhaeYEeqpNTELw=;
 b=EG8Pp4p11S+gwlO9n0Z124ffPj6tiTX2U+QP7mHVHq9DSlsiG72/f/2nCIoySbIbZjVhEtWrWFNUUsK/F/nWF0PaHZLPLiXniS7K0jx0KxeJv7d0P80RZ1Lzt+nTttV7dEdYoiESRQXcWGLw+glDCCa6yg9ZNrlcUZsw4e7h+sU=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2126.namprd15.prod.outlook.com (2603:10b6:805:5::14)
 by SN7PR15MB4176.namprd15.prod.outlook.com (2603:10b6:806:10c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 28 Jan
 2021 19:49:59 +0000
Received: from SN6PR1501MB2126.namprd15.prod.outlook.com
 ([fe80::e814:36cb:5723:8bf8]) by SN6PR1501MB2126.namprd15.prod.outlook.com
 ([fe80::e814:36cb:5723:8bf8%4]) with mapi id 15.20.3805.017; Thu, 28 Jan 2021
 19:49:59 +0000
Date:   Thu, 28 Jan 2021 11:49:51 -0800
From:   Saravanan D <saravanand@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <x86@kernel.org>, <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
        <songliubraving@fb.com>
Subject: Re: [PATCH V5] x86/mm: Tracking linear mapping split events
Message-ID: <20210128194951.2sy3wt46ere4el3k@devvm1945.atn0.facebook.com>
References: <20210128045153.GW308988@casper.infradead.org>
 <20210128104934.2916679-1-saravanand@fb.com>
 <20210128150444.GY308988@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128150444.GY308988@casper.infradead.org>
X-Originating-IP: [2620:10d:c090:400::5:7429]
X-ClientProxiedBy: MWHPR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:300:4b::28) To SN6PR1501MB2126.namprd15.prod.outlook.com
 (2603:10b6:805:5::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from devvm1945.atn0.facebook.com (2620:10d:c090:400::5:7429) by MWHPR02CA0018.namprd02.prod.outlook.com (2603:10b6:300:4b::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Thu, 28 Jan 2021 19:49:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f370b8f2-88c4-4b15-2d2a-08d8c3c5e4b3
X-MS-TrafficTypeDiagnostic: SN7PR15MB4176:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN7PR15MB41768881CAA1FC149E131E21A2BA9@SN7PR15MB4176.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AHfRCm5DLtl1OE0oBEiJkSnHMnS6X/AO/efM5Nsu2HRMujulNuuaTSv2loclZjg3bs999ximOOK7uDc7WPDkPLnxzLdb/9/qyd68MaGDqdqcoNjwP+suDP+IINE9m8DWcFqb0FJp1tZMfjCQMafbw/i1YvpkKvKXiPfEmjUE24pwpkRms2duf2DqCWiXnIHub2NQ4tQHgUo7T4PbRqrgYFuGO5REfnDpMZm/eOpWYG8rugaKAjJwqSNCWaUjfGjQJEh2bpfMjQgLwQ5pBDpPl21lNVnE4zGJARg1Q4zibwE+Pxim8kLFUL2+PQwXkTE7zP6fW8r1XUdC84yvKZoQNTWx+5H6rDiVOpu5gD9yrPR3UejYpcWc1eTNOoiohrk8Izb7H63c5QGq4SwQlmV/w+LJ6wRT/J3r+qWMjPYKagg+4jMSajriMBfI6nKUscDzExLU/Bc8jd81t/M/yuIW3sWJI45xBEdJIxxEGEN9qRlWDCA/OvFZs9GyoSrYgEDkIWtqjCtMiB9lykQhPwz6fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2126.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(39860400002)(366004)(136003)(9686003)(316002)(1076003)(55016002)(8676002)(52116002)(66946007)(66476007)(66556008)(7696005)(4326008)(2906002)(478600001)(86362001)(6506007)(16526019)(5660300002)(6666004)(8936002)(186003)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LMFfPP6YgVpH0HGzJBrOeUFgwvTm7qt63UAZ9OC1ZauMe0xK7Buj4cwp/Tpn?=
 =?us-ascii?Q?Sid6DihpdnTiaSL8s4w+MpjSKvD6ZiQqFhieg1MEEHr7Nf6pp7Yk8JPfuzZq?=
 =?us-ascii?Q?umoshvK8E+hoG+Tt71c/YWdKR18mq4maVatTT8dnCE6CTzHtf9LyhNIDCFVj?=
 =?us-ascii?Q?q6n3am07+DP3/ytCwdUPYmKtgR6oGLyFstw3UTY6GpVFi3A93TWpCVQzAZDx?=
 =?us-ascii?Q?Okvd/+b94zIBBrl2pTFFdN6rtllzrtVWv/1vzyTqYqG173t4FFeLz4A8zyu8?=
 =?us-ascii?Q?+ToLWF3yP02ijoZ6Evc/81vthDR3CgHGPwakmHryM8x8QCF+H2pbhx7TnaA5?=
 =?us-ascii?Q?OSxzJfRoP3OpVeyC18kN7wkKSb8yP01aHNJQR85a2yukJ6hHJlCwhYN79xWo?=
 =?us-ascii?Q?IYVcIOKwJOb1UqV15p1MAdppktywoCfjZHwd0/AxhByPj5dafzVPEd5iQ7O0?=
 =?us-ascii?Q?grJe7ebueZ9x6SaKDVdQXtZ8fR/61B8pgA0cmMlaKIJRZhesQVLdcObIhW94?=
 =?us-ascii?Q?fNTxt3VQ9t+PkKhA+5TuaulWsobk+CHV6MKVL4nKhixLUtrlbWsF3MFJa0p0?=
 =?us-ascii?Q?NA5U7fng4pQJ+TJ4LuDy+rEiHSdP7JSKMVtVZ1n7xy5Z5ZFcIZ/RwtGWHhmq?=
 =?us-ascii?Q?6U3e321CPCYWiE4R8sjRShbuPox8bBJxm2ivjlU5rRVBfy7j9j4u6SQO7Jak?=
 =?us-ascii?Q?Mr7IbwxbvnjGApSn37ZmzrNftLOJ/3J5bUaQ3TpvJ01F5Vadw5M4KFu9EJOX?=
 =?us-ascii?Q?1qs6oTpGks8ZPjCXNIOXlEGBkHEmXya6te5QVDnBZw1p34CODyVskd/HPJMC?=
 =?us-ascii?Q?cBuiykN0+j+Espi5yfhMHe0fPnaMcS31RfhGuagv5VG+6KVsuNQFJbEJ2IAa?=
 =?us-ascii?Q?dWqcUEctTHPOhl5ctXVaP3yNWijR9yrJ+vKAl4t+evXYGz+xp3jbVuaW1M/K?=
 =?us-ascii?Q?IOV0488yD6jh9Py9N/fyqPJ6hNTaVVMxX8vpSoH8w+hgiUqLrfxBfBtvt+gx?=
 =?us-ascii?Q?vcOhjoBIB8fO6B3L66p/QCAMRiZ1NxzHZXqr6sX2J78Wtm5f1IOM4wIh54Kh?=
 =?us-ascii?Q?Pi5ZXlVBBo4qPNBN748zdnB3HoDHgZPQH+cBmXdOrONr26eKU0E=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f370b8f2-88c4-4b15-2d2a-08d8c3c5e4b3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2126.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 19:49:59.1233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYEKPwzwKfdYfoebHeF7eLozYNQt5361+piwXW0/2dL3MvlwgT32GuK2l6L1nIWyvHd4LEvcc5M6wSfVUBr1iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4176
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-28_12:2021-01-28,2021-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280095
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathew,

> Is this tracing of userspace programs causing splits, or is it kernel
> tracing?  Also, we have lots of kinds of tracing these days; are you
> referring to kprobes?  tracepoints?  ftrace?  Something else?

It has to be kernel tracing (kprobes, tracepoints) as we are dealing with 
direct mapping splits.

Kernel's direct mapping
`` ffff888000000000 | -119.5  TB | ffffc87fffffffff |   64 TB | direct
 mapping of all physical memory (page_offset_base)``

The kernel text range
``ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB | kernel
text mapping, mapped to physical address 0``

Source : Documentation/x86/x86_64/mm.rst

Kernel code segment points to the same physical addresses already mapped 
in the direct mapping range (0x20000000 = 512 MB)

When we enable kernel tracing, we would have to modify attributes/permissions 
of the text segment pages that are direct mapped causing them to split.

When we track the direct_pages_count[] in arch/x86/mm/pat/set_memory.c
There are only splits from higher levels. They never coalesce back.

Splits when we turn on dynamic tracing
....
cat /proc/vmstat | grep -i direct_map_level
direct_map_level2_splits 784
direct_map_level3_splits 12
bpftrace -e 'tracepoint:raw_syscalls:sys_enter { @ [pid, comm] = count(); }'
cat /proc/vmstat | grep -i
direct_map_level
direct_map_level2_splits 789
direct_map_level3_splits 12
....

Thanks,
Saravanan D
