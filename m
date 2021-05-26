Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F148390EF3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 05:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhEZDpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 23:45:01 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:56742 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230313AbhEZDo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 23:44:59 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14Q3cb8X013361;
        Tue, 25 May 2021 20:43:04 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-0064b401.pphosted.com with ESMTP id 38s7nt87w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 20:43:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GD6RZkNz4YPf8dtTsRP59EI5KH0ikAe7BMvM+xP0Le2wA/mRmYMgEHiP2WB5nbE7E3mMmBRHJRbWxWKVFiYqekRr//9/Gu8UT3Lwp34YyeZogJHx6Xwh3YlKtkfyf7lgYUFor32YT1QdY/OMiqFsESn9hqpjhDHFk0Oc+NqKqWis7XF4FZgeIwIc0P7emdBn1bLnsDA/4XqkoiNeHpBz1kPWJrcq/sJ++f38OdAUCHDAh2RYhCMyFAcWP5qZcHbvMwrKSsBBNxvwluM+tFH3wE0qm/ut0mLtqokB/rn7obP7101NjTGc1mHK6BzsjeW1py0uPVky1GaSZit8++/TXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHQOjMj+b/mYq/s6gIwEbETWWUNzThNGPI2GjMvHypw=;
 b=TebEnbKqnVi5Dmhu6HEGYUwQsETZoHaiMDksHeCT6a6ivWmstM+C23gXFyREEEe1dz+3+haz3WNFpZYBiVPo7HXSOaXizgGPlkyOaGA7tWZXlvzEEIVN7zxXiJo8mimWGcYgAMouJAMg87plaNs9T0dyZmm9/DUaC3hBlcguQqIUOnuLEkLFCtFMeWTATd+I1PgOYq7cEieDq8PFMgkgmpBbg3+kH0P1bgJtCHCEhCwky3IQYp0+FuyQ4o5fWXNGUYJH15zVQSf1F+YiQ63Qhim28BpXldfDBg1ZU/pnZ97uoC4VOwhcmUBRYjt8IwWJFk97nLzUD/1b+zZayvsyZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHQOjMj+b/mYq/s6gIwEbETWWUNzThNGPI2GjMvHypw=;
 b=PpiTt00P2UAtioS6ziWSxp0GOv/uxdtkh2vYP6Tkx3TlCMQc08ro00ToAUXCQ48FRhEc3+4TRQ4mmfWAKCL5v7M7iIfzH7aYiCNxWXHIxeL0BPFvzYBNSffkWawjjrlbkWjrDOu0NJ6dUlp457FiRzmBnOO4Dp+S2I4Akt3zZUk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18) by CO1PR11MB5074.namprd11.prod.outlook.com
 (2603:10b6:303:97::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Wed, 26 May
 2021 03:43:02 +0000
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87]) by MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87%4]) with mapi id 15.20.4173.021; Wed, 26 May 2021
 03:43:02 +0000
Subject: Re: Concern about arch/alpha/kernel/smc37c669.c
From:   He Zhe <zhe.he@windriver.com>
To:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <7b314145-cbb9-b491-ccf5-d6021a574339@windriver.com>
Message-ID: <705dd441-27f0-6cdd-180c-a911ffaa015e@windriver.com>
Date:   Wed, 26 May 2021 11:42:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <7b314145-cbb9-b491-ccf5-d6021a574339@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [147.11.3.104]
X-ClientProxiedBy: BY3PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:254::33) To MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (147.11.3.104) by BY3PR05CA0028.namprd05.prod.outlook.com (2603:10b6:a03:254::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend Transport; Wed, 26 May 2021 03:43:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eae7194-85b2-4693-20e2-08d91ff85d29
X-MS-TrafficTypeDiagnostic: CO1PR11MB5074:
X-Microsoft-Antispam-PRVS: <CO1PR11MB5074F95D6B789DA4E1F690038F249@CO1PR11MB5074.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iI8Qb1uYUnQtQKvJVzKmvQXHabnLB9+Fwq/m3g+DFypp1vzEOafGNJvQ8+ZQdlfUIWgUNyuZLXHiv3DClx0mbpeEdcxRgSYIdWHl6QT08v/xZs0hO1ep9pDawWXChfgm2fGGForw3D764BXfKPNdnDfRk+QsRCGtLc4ykFNJZVbSlu0XV+yKZlsMGNti22TlF+dC4wcL9qGwd0xhPJaPrctcfOYK8Tu4gsXUUVlzi11ndpp72Vx3XWzd0eTQ1lIG+qAFSGTqikBffRk7q9t0lDw94oAQ9OEQOkJBeObXAa9nbEtBpcfKtHU4Kk/I1lexV9jmMS7SsBAmZXS2ieS66yV/U9RaEo53wfiLBavariBsHZ89Zo9H3O8PG20Y60DpfUz/7TnHXYW3SCfRKKoK6K5rnKMTCaeINJHOwHQ8K6FKTx1doQEk3Mv+wT44gJ4X4u+vghURTmIeGin9nHI2ZMnLXNol3HNrb88Yab3zq8KnvOejldIm9XBHrTJ7RLv4Qnknh9s8tfSSw9XhCCQASUwZhMRRJSJp2t8TRwHO+eXv9dhU0rfxw0uvnt1vmVq73GV4BXZnJ57804OhMgnDq9HiF24nXY60DBQKfXQwHahJsrV/yWh8LRXDOpzAJHXDaHHPyMGH3j0JPRPtnWSn5zbgO9m2cfqehyRhcwiuwJIJSZePeDmbntxvIC1drgmNqs5ACuEZiHj+yFXHwAWF77xE8QyhF2/bX5ZFwhZhGjMiXL/eeuftP7+H7mlVX6kz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2351.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39850400004)(366004)(136003)(4744005)(53546011)(186003)(6666004)(52116002)(6706004)(6486002)(6916009)(16526019)(31696002)(316002)(2906002)(5660300002)(86362001)(31686004)(66476007)(66556008)(16576012)(66946007)(478600001)(38100700002)(26005)(8936002)(8676002)(38350700002)(956004)(36756003)(2616005)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?akV3KzV5cy8vTTVmVUVZaGt2UlZUaGNrdzhzMTR5aUFqOEdLSnM0YkFka2VO?=
 =?utf-8?B?NmlKdSsxYUZaK2pCcVZCQ0tLVndxejN2OUhWdUZWZDFZemUyQmxUZ3RPS2FV?=
 =?utf-8?B?NllsczF0dGx3dTNFVSt4WmVOWXpKOGErd29IeEo5V1BBcCt2YitOdCtkUXdU?=
 =?utf-8?B?dEFZN0hDRUY2MzZSaTJvYnBOOXUwZjZDcjJ1WGJKaDdGcVByM0hMSUZmOFcw?=
 =?utf-8?B?SWZQSUd3dW5uZHhDOWdqYkFySktpNElqNEdNSWI1S0Ywb0xGbmxOa0lySEk0?=
 =?utf-8?B?ZjFQbXUrd0RlZnFRQlhnUDN5S0tOR0xQbUEwKytaREx5dHh6V3Z6SkhVMVlH?=
 =?utf-8?B?eUZzOXBQSDBmRXhtYWZuZ090TER2d0RVRlhSWS9SOFd3SW93M2xTQ3lYUVpU?=
 =?utf-8?B?U3FoODRKRVlDNVhETVFOS3RLcGVSTGZlTXgxTkUwQVBEM1hpM05qMHBJVGpX?=
 =?utf-8?B?MjZmb1dZelB5eG1ZWGExUXBOeldRNTlJb2hNNlAvYzFrUmZyZ0wvV2owUmIw?=
 =?utf-8?B?dktaVUFSNzlrZlRUdjVPTk9BdlNhZU9KZTFsbnZPalBYRDVTRUQrK1pXcHBF?=
 =?utf-8?B?cGg5R0hTbFZ6WGRMUXV2bk1UdWtCc2dzZGJVV2ZTQmVBTjl4ZGNRUGZLc2Va?=
 =?utf-8?B?LzJNdWtHRnZMV3NXSTNHVTNPT0R5aFlIcUdkd0JMeDg5Z2hMYTR1ZVFJRUtW?=
 =?utf-8?B?TzJKUlNRYTNpT2NYVnBZdHdBdlJ6WUtUWng4SHU0TUJrT2RxOVVrZFZjVEVQ?=
 =?utf-8?B?Y0dqNE9aZnE0eS8yWU5VaGpvSDV0aHNraG4wRjg5bWV4VFB4YXI2b05Hcmtv?=
 =?utf-8?B?WFdDcWlBT2IycEFLZEhZMjhOZDJVa0xQVzVFUHRqSHVGaElzbU5HZkhKcjR6?=
 =?utf-8?B?cFRKeS9DZjl4UVExVDZYQ0hRcXBjdlR5Ykg2b0dhbDJpaTZqY3IxdmdGQXBT?=
 =?utf-8?B?eWNqemNDSnljWHpzN01mWTZHY1NIYjRBemlsY0lMQUpQMEtxTEpFejFUMlc0?=
 =?utf-8?B?K2M1dlZwZkUwUkFWWFBib0s4bGdSYzJMRE83TjZZZHNEeWh1M25rK1hRRnYz?=
 =?utf-8?B?T2dqZGxlSXZzVW9rOVYzbU1ldm5leFFSek5kYVN0UWxTR0xISWprMFpBcjJH?=
 =?utf-8?B?YjFORUxZMkNxR1hWUDN3Z3VZSWJPd2xERlA3Vm0zK3hLNVFRUTJReEJlV3A1?=
 =?utf-8?B?bE5UVGJzUWF0YlNUTTFyQmg3MnE0c09YYjU0dTVZUTFvV3FDZ3FyejE0dWIw?=
 =?utf-8?B?ek5CYXJ0M2V6cXJJWkQ1cWhncVBRTDhpcmJhVXlvSmFOQXdUTGhnWVZHYjVr?=
 =?utf-8?B?N1kvbXRnYmhLbmpaYVowVjY3WG44ckQ5L0dSNklaMGwzWVRDMWN1S0crZ3dH?=
 =?utf-8?B?RnZ0VVprUUtBZ2ZrMVJkMmo4UlRlRVNvaGFhdk0rYmZmQ3Zmdm1VU0FDYXlS?=
 =?utf-8?B?T3JjOFlabTcrb1Q5VDJwanFUS21uQzlvcVJJYXVlNDdlakJTQ0IzOHplSzZJ?=
 =?utf-8?B?ZkhMVUxPanlhcU84R05EbUtUNnpMcXI5ekEzb3Z6aE11V3VhbDFRVDFycXRw?=
 =?utf-8?B?TituSDdZd0hBSzF1QXNBWFlOUTZaOWd3aFNnYjlMNUV6OHo3UVNzaGhnelVK?=
 =?utf-8?B?YUNZYXZXRTNsTXo5eWlncERRQXBXd1lCczUyRmxEN25YaWdFRHhCeTF3NUJW?=
 =?utf-8?B?VFpZQ2tVZ3NwZTY2ZXkxano1dWZKdTBMbzNpWitZYmYrTGJoTDZreWJhaU1Y?=
 =?utf-8?Q?rPO5oBKdgnmlL3bhozb6i8uuEjcKcMOxO2gJC3U?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eae7194-85b2-4693-20e2-08d91ff85d29
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2351.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 03:43:02.6312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7MEf6Agy3/93QZDOuWQuDCYc4Ea1JrrneNXbBjetpSGLJyBZXvOGCt8ErAck+NdtCoThJzgmNKS1EDbTtLYCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5074
X-Proofpoint-ORIG-GUID: EVj6dOieH2fgFmVCH6oBBUWwxmCliwkb
X-Proofpoint-GUID: EVj6dOieH2fgFmVCH6oBBUWwxmCliwkb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-26_02:2021-05-25,2021-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=934 clxscore=1011
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260022
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kindly ping.

Zhe

On 5/7/21 4:30 PM, He Zhe wrote:
> Hello maintainers,
>
> There is no "SPDX-License-Identifier: GPL-2.0" in arch/alpha/kernel/smc37c669.c
> and the following copyright is found.
> "
> Copyright (C) 1997 by
> Digital Equipment Corporation, Maynard, Massachusetts.
> All rights reserved.
> "
>
> Does this conflict with GPLv2? Anything else we need to know when using this as opensource software?
>
> Thanks,
> Zhe

