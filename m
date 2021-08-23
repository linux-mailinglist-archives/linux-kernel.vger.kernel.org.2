Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF76C3F4EC5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 18:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhHWQyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 12:54:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8232 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229674AbhHWQyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 12:54:00 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17NEZbUm005548;
        Mon, 23 Aug 2021 16:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=NgXDILMUNAFIO0/WZf+p0MXvRhqcBs6Nj10nOfwqqJ0=;
 b=xwTqqvNgf7JCckiZjjcnKQvQGrR3zTJhWKRof44u83B3y/VDE6IJ3eSjDeT3bP912Kkx
 GECXEMQI1ntCSnvrNwSonoVDJvFypaS3SezsAHClSj/v1lulL3r2kw6FsEPBnCwGkdV7
 HsyZyBeAK4v8tDtxyNy4CYfnmatKRr5qQnul0J1mhlsK2g3QMt5Knqxubb4L5Q2/Qahh
 EkMC6VWCpsxrR8Vhn7qvtQf2muALMVUcxmga2p2+HQYHIbaQVvakQyk/w3qQV4e/fjlR
 jzgQlF4DbmGiDN/SNGNr9tXc6Mnq3rX7R5yDSHcM6th2Vk+mjgTkAnnpqE8e/HjUMJ+g wA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=NgXDILMUNAFIO0/WZf+p0MXvRhqcBs6Nj10nOfwqqJ0=;
 b=wqHpbDPr8pbqsnQX4X6T3/JTr7x757p2IfNL/fq8/y0ZEp+XR8+8sgmaCV76IZO8D6zd
 S6bV1RVrhehanppS3lolpXvH+IWK62ZxY0U2LPXJ4mb4SNvEGMgYlZ3Jkx84zUfKsj0X
 XRgtU+e+LeSGu0l0+nV/wNd2FODv8+/lYzf1woKKthKVCU8gG5gcmS/30fMZSO3tVAcm
 Yuq71yO2oUd62cVImQNB9XW91Eu/ZcVx+VuwIFkDxKegUJta1/x+hFOQl9j5WQiNea/O
 KWyHHm2n9B/T1MevUtioF6p2xoy/s7nBR/7FlFvB/go7F52RU1YnlTZ0oRA8AZxrTIk9 eA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akuswj52d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 16:52:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17NGpOSe182812;
        Mon, 23 Aug 2021 16:52:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by userp3020.oracle.com with ESMTP id 3akb8t1u97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 16:52:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbHhtPF0GE5Cru5qo6hMtv/FwyR+rZV2ADkZzDHvGMtOBfOIcTv2Q709wIjODRzw0ddrFYHzyDXIECgRx+3rcD5ZXlBpVVBfdA7d+Yhutgq3uXDjZCt6nZ3Y+86xlCXL1ccF7plvdhuiKdGhrz10J0mXpX7h5TWlTao4o311kXfKhAXRAST80ezfaQqOy9oQ2Lo8I6m1y1qbANFxUS+UXNtK29WFkImOps9S8CksSNOfdmc4o/5xIraaxxQCuIT3tKCg/PcMBWwNBYPexEvVWTCn0tyegavFpzeG/L0sIgz/pNuO0ogDSjsyjHYLrWGaYW8piCicVcHjPzWnyT4VPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgXDILMUNAFIO0/WZf+p0MXvRhqcBs6Nj10nOfwqqJ0=;
 b=lkJVVB8Un0kD24QV97EV1mX5GGsEfnMy3Izxs3P/XKCP44wOwJbRcW1myRxxO0KBSH+yQgVrVq6Qm1dNxo0lNrCd800/ZacSdW+qcZITujfc2qO6OWBadJH8l8UtpYIms2dHgUuqbByYUTX2N2dyKqGKKGRb31xhftCahj9/DBsVCsNaXwIHhfy2B1qrjS++ORlXpVoI99JuLMifdr23b4wXcW1LxNcNFs85oVfr+oSfELvLiMqz9+Ab0ZPhWuEjJAYUG2lDVWRaBhqij9T+llaCiEgHbsheo9OO44uZcGgZ2ZjX4OJfwTCx01GGis04gEV6VVrHQs0+O/eNDflDKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgXDILMUNAFIO0/WZf+p0MXvRhqcBs6Nj10nOfwqqJ0=;
 b=Hy2ppVroFiYro6osumZfsq8CwNG/eKTkiLWLBtSH3V8abdSobmBosDYaFYKBTfsSx9/To1taXkmLkKe2Oqf5yYB7O7Hr0URBNUXKTjZIKw/A4oajTYH3Ne6nVSvkk1XiPgzLpZ3utg4VVKgD/eFJqaKP/h2/yVZ33m67OlZo6Po=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4526.namprd10.prod.outlook.com (2603:10b6:a03:2d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 16:52:46 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.023; Mon, 23 Aug 2021
 16:52:46 +0000
Subject: Re: [PATCH] hugetlbfs: add hugepages_node kernel parameter
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     yaozhenguo <yaozhenguo1@gmail.com>, corbet@lwn.net,
        yaozhenguo@jd.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
References: <20210820030536.25737-1-yaozhenguo1@gmail.com>
 <20210822151952.23ca9547316dc34c9f3bd482@linux-foundation.org>
 <YSLPWybBCyE/6x7s@casper.infradead.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <440095e1-a564-d522-eb86-1eaaa0dbf572@oracle.com>
Date:   Mon, 23 Aug 2021 09:52:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YSLPWybBCyE/6x7s@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0145.namprd03.prod.outlook.com
 (2603:10b6:303:8c::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.123] (50.38.35.18) by MW4PR03CA0145.namprd03.prod.outlook.com (2603:10b6:303:8c::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 16:52:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f8991fd-dc5f-42e7-469e-08d966566e94
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4526:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB452663225CA8DFDAC92F3F1EE2C49@SJ0PR10MB4526.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /1blC7GzF48fBZBXGARYjXAtpa7xqzIZ5ATqPuGjPt2X2ozt8u+ZyRUtSZP1uljtRdrWBfpEPH1fpw+QN28wIiZBI5kQFVUvdFSmZxzoiZmHpt6DNSiyFMtQYN8ka4kxhhjdieVOAsT4icvK1+piNCDnqQOXJUXVh+a5ATuKPVDhq8aSZBlBudKOVtuHGT1qfDZ8DX9ZXHjoKbae0u324Jx0P9VvsV5/4syl3zQsFD7X0KPbxjE3rr8DbOexD5B5ZuT7kFMEVa+cVCt992bIKOwcntMrOG0zEEtXG+iPCFUQCQ5sQMMbAMwRNReKFvi81VJPkw7+g+xx8dyUNKMrmDJ19JYO97NcYrtinLrHfyALuZ/k9bU/nNakD/uDK2N2+QuYv3kwhVyobV1A67JdJZoeYhhoema520CqpUVavh5DdGzcA/KQWgo3uNmKZdQROI9PlFlvMhofO9xfQkBfwSoIAH6AlBacj5m5viukK/UGItO6fStZQzsvjD9xIco5oJTT5PaxHLzcYNhVXNvwmbDQeTzmASYpFIJ2kgS0nS4eRW5hTExHYao5jxw+y1Dk9PKa+LNciQNMw0n5+Ajcdocy9nMltDSOxVRxLAvBV6xnXW8fPMaYWKp+VT5ShIZsWfuJdFlhtsuwd3wWymR17vFWJ08m/pbmFDbOzeLUUCckHGRzF0p1kKLJpQ1SoA4kOmMsLMBi2dWRZqlS03kGyYF0QUCGeS/Z8rGsXiXvzujZq3mC7pWnXeuWGVXl9eWLAbW2vImNad+KqNixI+6H4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(396003)(376002)(39860400002)(956004)(6486002)(31686004)(186003)(31696002)(38100700002)(38350700002)(36756003)(478600001)(83380400001)(2616005)(2906002)(16576012)(66946007)(316002)(66476007)(8936002)(66556008)(44832011)(110136005)(86362001)(8676002)(52116002)(4326008)(26005)(53546011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEpOUVdvc3JxV0xseTlYbUVtekxMbGJTaFVneDlLS1Y2Q2kvVjR6dklhQm1I?=
 =?utf-8?B?QVhSeVU0QVdBVHpNK0hsclFqNlFiU09Mc2xmeDBlanYrTG9yZzJ1SVdXanhN?=
 =?utf-8?B?ekp2L0N4V0QvdE1OZ0JpR0Z3MHJ4bjJrRVU3L2NEcGxxQVNBaVNLU2ZhNyty?=
 =?utf-8?B?aDF5Ym9LbDFJOGxDVWhOaGtNa0Z5em1SQkV2TS8xY3NSVlcwak95VUhTdmly?=
 =?utf-8?B?MUtoOFN1aWF1cjZOOVNPSkNHdnZybkxtTHBNb1NtakdRWlU1U1VNRzAydWdQ?=
 =?utf-8?B?Q25JdXJWNTNYeUkvQ0xXc2FPRlNVTnVGV29SbVdUWXZPLzFpckhQQjJ1ZjdS?=
 =?utf-8?B?WDZXZ3E4QTdPUXNDR1o5Rk9nM0FrQi81MENOZzA4UUhPME1XYTZqUFlSb09v?=
 =?utf-8?B?TUp6YWgzOHgzWkRsWGF5aUgxNitFbm1oUGRTYmVkZ1BiWTR2TU5ldFpUSFBl?=
 =?utf-8?B?S0hNSE9paXJHQnJETngzVlcwejIwVnpISDJmTnJsWHRZZmFMZzBOQVpjNlk0?=
 =?utf-8?B?RmNkcmZ2azRDS2NxdTQ3enZUanZ0andhK25KTk82dENUd1hUenFLY1BHd1pG?=
 =?utf-8?B?OXhpWmhvNVcrVzFWRTdXaExrS0k0dERsbGtqaW5pa04ydFQvV3ZnUW5QeCtX?=
 =?utf-8?B?VXlwbjRvT1M5RFNpRmpyekNEcnkyQzExYndpeUNGZ0VlTkpCbDJpSjNvTUVC?=
 =?utf-8?B?a1FNclJpOUxOcERLSUZOZU9sLzM2UU5FZ01rR0V5Q3FIYTQxb3RSWDdpRG1P?=
 =?utf-8?B?NzFDYXh3aHg1Y3NncXZhSEkwUjdtRHF4UDVEc01PSTg5RG1ORUFUK0tUeDZH?=
 =?utf-8?B?QzlVeE9JUDFJdXJoYU10bHhOK3RacXRqbk1nbGhGd1huN3k1SWdURE5Jcm81?=
 =?utf-8?B?WFZyL0FMWHoyRE8vVkJTNTZPR21VeXc4QkM3L1FUR21Ja0FsM0lpN2REWlpD?=
 =?utf-8?B?S0pxb1A3eGloaGlBM3ZzUE83cWxaMTFYYnI2b21QeEJEZTNxZXNWdXhnekJj?=
 =?utf-8?B?U2w0VHI5VGJJMWV6eDQ4L3U1SGErSTdOcDVmVHBBTzJRZWoxeERhSWNYVlhq?=
 =?utf-8?B?d0gvR1NVRlVxLy9ERlpBY3dFVEJOT3NVMk03OFhaSVRjUnhUalRwbUNwbFpv?=
 =?utf-8?B?MU1yaHdaQ2Q5OTNzclNaNmU4YnZKRStuT1o0THFDSTNPNjlIVC9Ta3lGTk9t?=
 =?utf-8?B?aU5ZSlNrTEpPakgvelRLaVZLM1B6WTJTVTRwSzNKcGZ1T2Uzcm5IbEI2YTh1?=
 =?utf-8?B?cGU2RzVwVlNLbkhJeU5Bbmpocmd4bHRZdGZpK2tZRHNjTWl4RDlSS3B0Zlg3?=
 =?utf-8?B?cE9wNTB3ZXNJWVhPY1dlVjBqM3FETDNGd1cva0huVjFEc1AvMkFxUmpOYkgr?=
 =?utf-8?B?ZWhLMGtjZFBZc1ZBckNCMkxOd0NFNmZXU05mZ1gxYXVTSURtWkF3RG5DUDl6?=
 =?utf-8?B?cjZSaDFlL0crZlFZMTgvNWdiVVZISm9qK0hRRldDNTljY3N6Y0ozQzlOaSt5?=
 =?utf-8?B?NUJDaXlSSTlJS2s2ZGk0SC9oMjFrcnlJaHUrWXVLS0x1VzB2SkdxUHRmNElN?=
 =?utf-8?B?cG5wZ2ZDei90OGxtaWhCcFUxWVpmTlAvWjMybjIzcVlSYkxNTllCbGlId3E0?=
 =?utf-8?B?STZjRHFlMUJyTFdVNlR1L2FIWEZxR0pXVlpVekNEWDV1S0xiMHZlV21pRzgw?=
 =?utf-8?B?SGNrT2NFZU9oZDdnMXJOcmxhM25BMUlFSTBxTC9uSjVwalJpT001aUcxNzlG?=
 =?utf-8?Q?cu0AKcm+twE66Z68Quq9bypqtaPEvVThuYYWcAV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8991fd-dc5f-42e7-469e-08d966566e94
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 16:52:46.1044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SgCasOEt7gZFc0daD3uzqW4BouIQqKngR6CykaLglJwk0ubgYqH49JCEvmhJsu+h6PzcMxfBCQzyGZFXdfPOOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4526
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108230115
X-Proofpoint-ORIG-GUID: 4ZFSejvRWY67t9SZ36KvUi2K1Tr6wEf6
X-Proofpoint-GUID: 4ZFSejvRWY67t9SZ36KvUi2K1Tr6wEf6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/21 3:27 PM, Matthew Wilcox wrote:
> On Sun, Aug 22, 2021 at 03:19:52PM -0700, Andrew Morton wrote:
>> On Fri, 20 Aug 2021 11:05:36 +0800 yaozhenguo <yaozhenguo1@gmail.com> wrote:
>>
>>> We can specify the number of hugepages to allocate at boot. But the
>>> hugepages is balanced in all nodes at present. In some scenarios,
>>> we only need hugepags in one node. For example: DPDK needs hugepages
>>> which is in the same node as NIC. if DPDK needs four hugepags of 1G
>>> size in node1 and system has 16 numa nodes. We must reserve 64 hugepags
>>> in kernel cmdline. But, only four hugepages is used. The others should
>>> be free after boot.If the system memory is low(for example: 64G), it will
>>> be an impossible task. So, add hugepages_node kernel parameter to specify
>>> node number of hugepages to allocate at boot.
>>> For example add following parameter:
>>>
>>> hugepagesz=1G hugepages_node=1 hugepages=4
>>>
>>> It will allocate 4 hugepags in node1 at boot.
>>
>> If were going to do this, shouldn't we permit more than one node?
>>
>> 	hugepages_nodes=1,2,5
> 
> I'd think we'd be better off expanding the definition of hugepages.
> eg:
> 
> hugepagesz=1G hugepages=1:4,3:8,5:2
> 
> would say to allocate 4 pages from node 1, 8 pages from node 3 and 2
> pages from node 5.

Thanks Matthew and Andrew!

I was trying to wrap my head around the big issue before making any
suggestions.  It is true that the desired functionality of allocating
huge pages from a specific node is lacking today.

I like the idea of expanding the definition of hugepages so that nodes
can be specified.

One word of caution.  It is easy to make mistakes when taking data
directly from the user on the command line.  For example, in the follow
on patch I do not believe node is not checked against MAX_NUMNODES so
it may write beyond the end of array.  Also, we need to think about what
the behavior should be if part of the
'node1:count1,node2:count2,node3:count3' string is invalid?  Suppose
node2 is invalid.  Do we still allocate from node1 and node3, or do we
just discard the entire string?  During a recent rewrite of hugetlb
command line processing, I had a matrix of different command line
options, order, values and expected results.  We need to be as thorough
when adding this new option.

I'll take a closer look at the proposed patch in the next few days.
-- 
Mike Kravetz
