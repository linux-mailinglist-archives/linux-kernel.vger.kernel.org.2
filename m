Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0F53144A8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 01:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhBIAKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 19:10:49 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43310 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhBIAKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:10:45 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 119041MW008465;
        Tue, 9 Feb 2021 00:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=FO35my7sbOa1PageFDxE86ZdPDuk5d4seOYjSxvGjYc=;
 b=H+lsj/glrFCurg+7nVkASujbhiyy8nA6TeOZc7YjhqmD74Vhsw6ewLOAM7jlrvJg1z0w
 GCFLizMsQccxHA3JHy0FNXNk4WKNjdSG7gaWmBTaSXgrhe7ZuVlSW1l03VJprm7Ff+iU
 zkHg+1M9e6GUp/+YIQsIOqxkKuW6GTI+JmBQqh3XWGtULXcf5KUykIR6QfW8jqMfSVrs
 f95JXYkunuLmCy+161yd3ORaKLvGH52t9y5ujLKN5K2Yc2Au9YaBfbGySd3iZbhR/9Az
 WJmZUQqyzxUqA3F8/T+EO/nctyib/TI2nmeqGGldVPLz32QCAFhp5Cy4xfYGpQfppvWR MQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36hkrmwrnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 00:09:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11905MsW189390;
        Tue, 9 Feb 2021 00:09:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by aserp3020.oracle.com with ESMTP id 36j510fxg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 00:09:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4fhw1SyajRZ03fLL8gRo1F59WKk6Zg7MN0m9Cqi3EeMGf2jLxbRwJkY1h0UvoVM3ncIboZzHo45s7jIr/aCBroSmd+M9bcNGTiUtBaFs1tWo4GHOArwFzCyxddw6uHdFDq7zywZqEvINenA/Tcb/qSzko/eGEWauIl7FMii2SwUdy5jPTjU8HWMk9LdHlImURsfF2zp367OwQOnXwYDVozRHpplMdAonnyrnT27GQUy1e5EjHDwU7i6IQhBKr9ohbpXwMUANfB38QxpFF0yZoRugspIU1ZLJxQ1E0Jq6rWmFgxWTMctQftIsbilZcK3PbTH4p/k6cl0eH/wdKOAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FO35my7sbOa1PageFDxE86ZdPDuk5d4seOYjSxvGjYc=;
 b=TNONW5JJPvpopmBNram4EgJzepIRXXGVilt+18Y0ppXpuduZIrKSFLYgh9fNQorx/knt3pvHWhSM/od7ECurmTZgzN81gKwUzKxfsgQGBnMF4RoxVt8FCaYC+Gv4NWydwb+fwAUc+yMzSvED5m7VVaW4xEhJBzj8PO+I/QDLUtM6EMTor3fqCKJtcrnKKL5/BC3wINXLB23vosIAdrGzyQ3eQT2rcYj92o9r0KVq+eLPuifZ6GonuuFU4kx64KQNOLXho9tn4eqEgke4KUweIAovP7aHyO+rpLx6nWtN6X8w4UEs8HjtD05YiytuOSZTl9tKPZ96V1uW7CBIdWS4Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FO35my7sbOa1PageFDxE86ZdPDuk5d4seOYjSxvGjYc=;
 b=gah4NCVqoLhUVJ9w8s9JZiDNJBDZjRzFBwITsfVS82HCNUnhot5G7jen7QjlmqwuNFrfmI7ycZdDDp0jaKJu5f76ULyii6bsb/boIV0FyGE4Zg9xVq/oVVXuTXGHCn3JTdE0jC02inaB8nIom0K1HKNjOHSASt2pn3s9shi+HQo=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4740.namprd10.prod.outlook.com (2603:10b6:303:9d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Tue, 9 Feb
 2021 00:09:28 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 00:09:28 +0000
Subject: Re: [PATCH v3 5/5] hugetlb: Do early cow when page pinned on src mm
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Gal Pressman <galpress@amazon.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Wei Zhang <wzam@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210205165406.4655-1-peterx@redhat.com>
 <20210205165406.4655-6-peterx@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e3029aca-f487-225b-7a78-7712c4c465a6@oracle.com>
Date:   Mon, 8 Feb 2021 16:09:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210205165406.4655-6-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR19CA0021.namprd19.prod.outlook.com
 (2603:10b6:300:d4::31) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR19CA0021.namprd19.prod.outlook.com (2603:10b6:300:d4::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Tue, 9 Feb 2021 00:09:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4da189e-2f30-43ac-ae1a-08d8cc8ef71e
X-MS-TrafficTypeDiagnostic: CO1PR10MB4740:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4740F88988332EF86C929386E28E9@CO1PR10MB4740.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tYEJvoWgFQFWj+nfJcw9AsRJ+1Dab3rUoHAPUZteyOeXZpHo5IdSMq7pG1QXO8K0CIgp6sneP/Rpk/+BZwAxozTsDYeitZql4ATLVFVVEEgS+wBl5zyHmY3eW0AwTgp6lX191NNBr37Ftd15ixfj9bz9zxVsyx03cSuEI/1fRSvFd1xmKAWgj9TbBEFW4DYVDlpcJezRS9sJ/O2h3PikR8Q2OdtyJvSoKyJCDOoOBysjBrvYRO+r0AinRZARIM1vM1N7hfPjU8k3BoE2ZllivcE/sD6tYd2fMQ6f0iTgnOFYqKLPD9OahjRo4t4sQoT5yMaVCIbhwqxO/j1Reekn44gqDcdOtGG9/tLMZDI9FHJTEXdwrnyw4F0BJO7oVr7yQVG0Kic8bdE3Bma4/PcHL9Ywu+OISa1gJT4PdHETj1urSz3MD2QsdcQJYCW990zvrD3G/QrKzDE1yPvEz2lRY04zxNqJev3mcus86qhRyX+QR5LOy2BZQm0B3fUWcgG0ou6oItItjHZQuylnXBuBiQR7cjIGJ3yp7o+4K2de7imHxzOuuf9dAua3Fupwcv+1aDc0N4DxTNt+tfH6qkLZqug/4l4AKwlApQhKIK+o5jU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(136003)(346002)(376002)(8676002)(4326008)(83380400001)(16526019)(7416002)(44832011)(6486002)(16576012)(53546011)(52116002)(186003)(2616005)(54906003)(86362001)(31696002)(26005)(316002)(956004)(4744005)(5660300002)(478600001)(2906002)(8936002)(66556008)(66946007)(66476007)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RHkybXhwenRlK1JqOEV0OVozejVzTGRURE1CdC9wcks5bnpEMTJsNU5aSTNK?=
 =?utf-8?B?blp4OEtxZHd3bm5OOGpJeVYvaWYzWk16TzdRV2N4MUpXV1JNTjlwdzJpUVps?=
 =?utf-8?B?aXlWM01tTGJoa09OcHY3Sy9PVXdzVWNOb25hZ1pTRDM1QTNENTlOTGR6U0V1?=
 =?utf-8?B?cHc3MStMR3FEMm81dmU3ZXFodXV1bUNmZVJvM0Q5VUljSzlESzlLRnVrSFV5?=
 =?utf-8?B?MkdmcGZxUWE1SjV0aStSN3VJQS9CVmhTSFJYZDJYcDFYY1dIY05Gc2hPVXlE?=
 =?utf-8?B?N0tzYktFcUFCOTc0R0JBK3pxYnM5Z1diMGhPL2FhZyswNUJvWXQzN2VJNTB2?=
 =?utf-8?B?djlzSnNCWXpoSEFqdE9ESjZ1VWJ5ZEZPZ2phMk41d09WVFlwRVlZV2twditU?=
 =?utf-8?B?SVlWMytUWDVtWUVVMEJOQW1neGZHZmFDUllGL3hkR1JPdndOSmVHcTd5UEhK?=
 =?utf-8?B?VUtleThkbmQwK2o5QVRabTFaSmpKNWpiRXlsSXRsbHYrMVdXaUxjNVRhNjky?=
 =?utf-8?B?Y29lM0QrOHJtUTdaNzMwYmJaV1p4dkZHT0xpSFZjWXVOajd6cm5vZUZqR1Bt?=
 =?utf-8?B?VkZURzFwMXQ2OEZtNVhaTnNocXZuQnJKT1c1aVF6bVlwRWpLeWcvNXNhYWdP?=
 =?utf-8?B?eHJGeGoxL3B1alJYcGY2UkUrZGJieTJyM3RMVUpQZ085TTRGR09oS1VVRDFI?=
 =?utf-8?B?U1dSeVc5SUhNMnBVU245emxGbktJelZDNThhYlA2aFh1a1NsajU3L1pvU0s4?=
 =?utf-8?B?ZVpvZTF0VUo5TWxFRWpieTdDQWw3dDdSYVZuVjJKdE9nblAzQVE4Y0oyWFNJ?=
 =?utf-8?B?c2ZHOEFXWk5sQmdQNTVPMVU0ZzhTWDFDRHN2M2pBOU9mUy9JV3lBaGc5d3dB?=
 =?utf-8?B?ckFSUFFsc2dyOWczZ2xRR3M0VzVqNzc2dndlL2JRcWNxV2hSTWY4cisrUGVj?=
 =?utf-8?B?Q05UdS9VeDNwZGk4bzFjMjdVV0VrdSsrUzRZanE1MWVPd2FSSTU2c0FYTENw?=
 =?utf-8?B?TzBNaS9pZEtCNmZqUGx4OTNwRk9PK1hlbWsrRUtsNlJ4SG5GY2NPQlFod1dF?=
 =?utf-8?B?RlovSTFmRG5McHVEMDc0VHFzRng0VXJrZUt2LzVqM25LTHFBcTRSNVFOcDIy?=
 =?utf-8?B?eGRGTDhPODRVdDRjaGpiNVhrREZzSW5KQUxIS1VRSjI0NTI5Z1RXV1dNQTJV?=
 =?utf-8?B?dkRDOXFTNVVzeFFNR1hhUUJDYnZOa1lDWElOdDl2c211SWZtOTAreVBvSVBo?=
 =?utf-8?B?U0hTdTNuVmFSOWdRZGJuMVdMWC91aXljN1pNWkRibWFrM2FUbGM3b08zU0lD?=
 =?utf-8?B?aVY4bDRmRFpPR2hXT3NBUkNCOVBSYU96bVdjRFBCcExkR09pK0VROXpHbkhS?=
 =?utf-8?B?TGZFWlpSZTRKdW5vZ0NHaVhTQ3ZGcXhVYzJxUSsvR0FjQTdzY0RWU2pnVGhM?=
 =?utf-8?B?SDY3dG00WXVTbmVpZjEwVEt6endrTmdOeHlrbVVJRzJmdHpBZ3pHN0htRWJU?=
 =?utf-8?B?alFVVFRoNWVqRzdhbkZ6S3BnLzVsejZJeTN2bDI3bXlqUnBReXg3c0JrS1Vn?=
 =?utf-8?B?VW5vTWlrMEw4R2U4a3dQYUN2VDI3b056aDRaK0lETnFhMWd4ZjlnS3FXaU5r?=
 =?utf-8?B?Y1JrVUZoWnQzRzJuSDFKQlIyWmcwcmJQTjI1TDczMzd1UHRoUW9mNk9mYTFt?=
 =?utf-8?B?QXFOMytZSzhmclRpZTJaRDF6RWd2UUZHL1BhQkdsUlFKVjludFptMHV6ck9y?=
 =?utf-8?Q?eXVdEE3nYXX1wk0EhGHd/JeR1oOTncR4v6eXEb2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4da189e-2f30-43ac-ae1a-08d8cc8ef71e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 00:09:27.8289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vld8G8r8M/a33YNzCYBgXOddsxzD/5xDn1bQ72MUpO043FfCZU54YHndZ/0fO8EZhkmNGfLbQbryEwA3QajMbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4740
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102080133
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102080133
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/21 8:54 AM, Peter Xu wrote:
> This is the last missing piece of the COW-during-fork effort when there're
> pinned pages found.  One can reference 70e806e4e645 ("mm: Do early cow for
> pinned pages during fork() for ptes", 2020-09-27) for more information, since
> we do similar things here rather than pte this time, but just for hugetlb.

Thanks for all the changes, the patch looks much better.

I did not look at 70e806e4e645 in detail until now.  That commit had the
'write protect trick' which was removed in subsequent commits.  It took me
a bit of git history tracking to figure out the state of that code today and
the reasons for the subsequent changes.  I guess that was a good way to
educate me. :) 

> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 62 insertions(+), 4 deletions(-)

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
