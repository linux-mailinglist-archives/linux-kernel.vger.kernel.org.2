Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFDA460E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 05:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbhK2EhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 23:37:06 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35660 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232097AbhK2EfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 23:35:05 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AT3K6RH011977;
        Mon, 29 Nov 2021 04:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=dT/vNbL276U+dpgYCkhblCratycDJXNfTmEYBYqRGqs=;
 b=1Lw3LAkVpj/77e/ePHfIxiBejRRTPLs+z/sO8ah0ih0Y07Yazh+AnkRpFOvPkf9zhg7C
 vPgXDDX4QIXnvCVGCNinwfd/1EA3ze4fk++CfctAAziVl1DqAZN6HenY7vLg/xmXt0hN
 VqnfhrVmMoCRGFvn4c+5oRnvDH2T/pK8aFDKXQAWFuSCOgXyixdUTmOycwq0YEUofNIw
 En4jB6pvHr9EAkCuZgdOJvMA9HUy2YTSzwiYXCbG7ymxaTBPca5fyr2d7f4FqDv/Ppy7
 rL482LQdVYJ0BZMqdz3+/SDJMu77N2dybqQCPu6euqXVEeVzII0Upp5vEbf4NCXqtlam BA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ckbf3c5rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 04:31:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AT4Vf4B075852;
        Mon, 29 Nov 2021 04:31:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by userp3030.oracle.com with ESMTP id 3ck9svhkmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 04:31:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVF40Q67AKu3bbLsEf3JRmObsO1D27MDKHfqQ2MzeIisg9uJno2UbB0CCZ0n64JuZ/JLJdpkoKgez2n7reOWLE4Y3BvBSp4VNt0i0mh7HVZeAL0f8neDnSvtkqgj7MrBxOZk/E67r6Z/xfTtpq9YY6OorBYA72D5vGZiMhShUsJN5NEdIqFJG4v+AplULhtAcz6WZqkDgGCpVsEonsrh/6uYhqeKhtpL4D3NMjqdE2t6qZQsxK9bhUliQmFIpzvXcEKBRYWMWzM8V9BSdDy/4uneEWXcrgDS5TZvc9wwA/FSc8eWwwrk62HGp8wpzwvKOD4hWMjavdHtWPiotP/G/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dT/vNbL276U+dpgYCkhblCratycDJXNfTmEYBYqRGqs=;
 b=ctRlIVxFaTSAKJcxWtc0CsouRjs0tapBmyJfoCQi0rFYVWCFJFLEKZV0XB+hWK2xlJDB1G14oJ4vRLpodIA6xRu53w4+9cnrRcxcs462dEy/9omTT0ehgUOUIKU24nz5Lr1lDYIPY4wVOVnSi7lEqUPuf3r40saUn1m89U9E0ikUvjyGlsiMsymmIcYyaXLLcymBW+/sil3BwboYemRQoPeewBkMXqX0+9DCIH6n8u5VP391bRL8GcYVbaKzbm1X/Itf8l4TDSF0NZ79Ch/qHoHcD16gz6Ji+ook4K6X+SuN/wjo/aLqdwtJed4CG1DgQNSid5D3uv4xuDZXoevkeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dT/vNbL276U+dpgYCkhblCratycDJXNfTmEYBYqRGqs=;
 b=Tc6e4PsBE6uSJ40uzIf+ZgK7OONccyFrrnE7iPokMQKTSksNJ3RxOA9AODuw8k+n4YKKzvt4/7CZkLuTsHnmUHOD4bIKDhbRF/xw4v+Z1Sr0XGriYYoBkQZq3de/a34fZSoaj86R3ps+pYQYGDfsYnx7CAxiJk5GK710jic4mfo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3206.namprd10.prod.outlook.com (2603:10b6:a03:155::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 04:31:38 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7%9]) with mapi id 15.20.4713.021; Mon, 29 Nov 2021
 04:31:38 +0000
Message-ID: <ff89f867-0709-d8bb-b6f5-51b2be4cc2dd@oracle.com>
Date:   Sun, 28 Nov 2021 20:31:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: Commit 'hugetlbfs: extend the definition of hugepages parameter
 to support node allocation' breaks old numa less syntax of reserving
 hugepages on boot.
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Zhenguo Yao <yaozhenguo1@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <e52068a6e98031a386b5052a166a55c94fe940f6.camel@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <e52068a6e98031a386b5052a166a55c94fe940f6.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR22CA0002.namprd22.prod.outlook.com
 (2603:10b6:300:ef::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR22CA0002.namprd22.prod.outlook.com (2603:10b6:300:ef::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 04:31:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1da73a50-f2a3-41a0-87fd-08d9b2f12211
X-MS-TrafficTypeDiagnostic: BYAPR10MB3206:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3206594F94AB889E0BDA7644E2669@BYAPR10MB3206.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2XPkzm7gjMl2JA/cREjhDm59EHFmqKEOWK9CKXFq9cDrHPkdi5K0EaNVx/jJ5KK4CLDIm1nn85ytsiYXAB9xZMYD+PIoE+XPAqoOyKw51h7oT/JkhtaPrkoSsVC280SFkBHncIkSJXZs7o2i/aQ9XQl1aeuYCocObKk4rlYslSU5FYOljWMZ+AFh431PcYzo7z3ggXldRbear7OVMpyHlg2kxAsa/A3eQu3qAySKhD3jA5rfeNM63l+VRmN7tIQc3geOdb80chSG1MYY07W6rw12rwDufiGSHIRILdPOzkSHO3DkKIAgQ1McxkganPQq31+DWDAmk+mYi1asOcG4xJwi8IP8XCFJIpnqw1Udk785TQBJadxkVt6x2L9PcHwpTNo0pMf7s9+XuLFjq/B+WK7Hyx5PuUAQeGwTK2nk/EnkE3q6YjyAdR4Dz4vvRu/+ikQP3vG5gTYbEQtmyLApmW95SPwkVccwjdW6a2H1xB/XvZadMsGiWHwGQA/TnWYSctuT8XteG88K/7yC7MC4GSNxvOMtgzGRgLzvIJQhKUXEKwHCWKbCqfPBh26OVwP9yVnQFzf5JNE5gbMjrk9ZqNViFPWHBsCv5Dt5ini9rxVqkcihCi1hJ8Clw89U1LlH9UQBdXxFE3zdzvr15bnlW3dUryMQ6nlHBa4bhSzbQ5EUcENRHCN4DS1bFLOUXKTPHJGd+Bo+Mq5pJyEFdPPn0PIiK1iUA8H4eWoy1+5aqQGj0tjN/VAEmoLJGLrxvUhK4MUabmurBQSdkHY8s2ISFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38350700002)(4326008)(8676002)(53546011)(8936002)(6486002)(186003)(38100700002)(31686004)(83380400001)(26005)(956004)(2906002)(36756003)(44832011)(16576012)(508600001)(5660300002)(66946007)(52116002)(31696002)(86362001)(316002)(110136005)(2616005)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTZBd2NQSTZHMk5uV3o4cHNMT1JTTjFjeFhEU3I1dHZGbUdhMGl4OVg4WlZQ?=
 =?utf-8?B?ZWtESC9ubWxPQkpLQjZpSW1HWDl5M3BOZElrZXBMWmRDMVpBQVplaHdHRkZN?=
 =?utf-8?B?V3VkNUcrQlMxNE95R0huQklneG1RY0dKeWlpUnpLeUw2K2V0WG1EWmtSaDBS?=
 =?utf-8?B?Z2l5M1hyRGtxYlVuSjdoSisyRk9vOEdzc3l6ZnJ6M2lldGZlNS9WbVY0azdr?=
 =?utf-8?B?blV6d3BtZUVIbEtkYmVtV0VCeEJLVU50aW1BWDZPNkRKNVMrbDZCaTBVczlp?=
 =?utf-8?B?OEQ3YnU2dExXYXI5MGkxWnc3SkxBY3BzTDlWZVRTS3Q2aU5QS3pxQWY4NkV6?=
 =?utf-8?B?UDRsRlVqV3FRRjBXeVJIUWNZZkxlbGgrcG41d2dQQ3dCRFNUbjZWcHpwUnR3?=
 =?utf-8?B?VkxvOWdPM3JLVUM4d3E1ZVQ4bTloZlJRS0o4NmVpZTBDVERNTzBZbHBmTnhC?=
 =?utf-8?B?azd4dXFjdE8zUFovdnU2Y2xFSktoQ2xwN3JXcU1MKzFSMVFjendTYWVGY0dX?=
 =?utf-8?B?Q2NTZGtkU0o2UlRianFtTVZYcHQxWkVDYUluT2hXdkwrODF6THd5TXBFMUwr?=
 =?utf-8?B?MEpFeFRFM2p6dXhRVWJZQ2MvYlZXRUZsZXBzQTNKZjBYRjdjdWh2dTJXZ2ps?=
 =?utf-8?B?c2NmNzk0L1h0bWdLeGYxMmhSMTNxZlplbkF6ODZPWXVyK29UdFFlM0VIUGpV?=
 =?utf-8?B?Q2owejhFYVRpVU9DZ0FOdlk4OVUxcTVYeFIwRGYyL0NvaVFXU0tjNG1LSENS?=
 =?utf-8?B?bmpqdUVYa0NoaWMvQUtYQWtPZkx1d0VGTWNzTW1aQmNFaitaOFZxQXliYmRG?=
 =?utf-8?B?Zkdmb0I3QXNxZkZIWFdISWEwb05jVFhQbWJ4TUVnK29CdE8yRkdoUmYyTFRQ?=
 =?utf-8?B?MWdkeU5qOVhXbG1ZWW94cGdIUU40bS9EaDBVc2d2Q2xxQVZhS1lYb2ZBOVpn?=
 =?utf-8?B?UG5XNTJNYkdCU1BmYlZaaXBFRnFVQSttMGViYWcxeVNyemhIRFB5YkFnSCtZ?=
 =?utf-8?B?d2hGMkZUR3B6WjFtNWZjajdlTkxCRkdnc1J2RWR3dFJoQTQySG5RT3JzS3lz?=
 =?utf-8?B?K0dDdHVYRVBJUFVZZUh2TkF2SEhhZlpwRWh6U240L0ZTS0lwdWZlZ2F1bzla?=
 =?utf-8?B?MVY0THlRay9kcGlJWWx3cUltNlRYbmpXT2lpVVJjYytjMzRjMU8xZmdHdVJW?=
 =?utf-8?B?Zys3UEZNKzlnTTN6RWptNVpVaVd3Qm1odzJQRnZndFJGTXdZdTYwaUFoblNF?=
 =?utf-8?B?NXJ5K2xpdUZwNkFCWGdxbEk2RzFCc2xvazR0M2g3a3lrdlgxTzJHYUVDd1BM?=
 =?utf-8?B?dHZDcEhFL1Y3bWhzbjBJa09IVXJYZWViYTNLZWNJRGdMQVcrSElDU3dUM1h3?=
 =?utf-8?B?YlBreUkxZXFYc1ZnVVE2cHgwRWRMQ1ZlR3JLdGErUTY4YytRM3V3blJlVzhl?=
 =?utf-8?B?Z2NoVDhsQjE4UTN2bk5vZFhOcnRKYlZoSjRiNGlNUUhMajEyM3ZjdWRza2Zy?=
 =?utf-8?B?cE8ya1VEdGlEQ2JmcUE1NEhXL3hXTURTRDcrd1hoU204UWFNMUxNdWhjNjV2?=
 =?utf-8?B?dENWUGZTMXk5VWdUMkV4anpWUURjVUc0VUtVZjNYR3pJWUsyNWlmMUNkVjJC?=
 =?utf-8?B?N05UV2xybk9RWjgyNWxqZEhrc3BEQ1pNU254c1pEOWt5ZWR4cUtWMW4yc0Q3?=
 =?utf-8?B?dHlTOXJGZHd2ZFdMSXkrMnY0MkpCeDNrVWZIRmliK2YraU5NK0lseVVQcUkz?=
 =?utf-8?B?UEFmNFJ1RENHU3hObHZYTjJkbnFnbWlmSEhmVjBNRURlYmk2VlRieWZTdWtj?=
 =?utf-8?B?R3lldU50QUd6TVRRNTR3SUR0WEdJK0pXMDRnQ0Z3QTVMTkxPVHdPNWVqdXJm?=
 =?utf-8?B?ZW9WSWxFNmkvTU1LWHFjRi9oZ1VNYVhBZjZLSHk5cGhRdjJSZXZaYk9VMStJ?=
 =?utf-8?B?N3dqMThvckVoOWRXQ24raUZ2YytGMGR3RlYwZXc2RXFESlAyakg5SVc5THdv?=
 =?utf-8?B?b1V0anMvZy9IVUsraXc5N1FGSWFJS0VUd1EwY3BSUENxNDdTMXBmQVhGUFRG?=
 =?utf-8?B?dmpxUkhrOXU1TEVSVW1PNmZYakRwSWpOTFpKZUJCQllLUkQydEhyaDM1YTVP?=
 =?utf-8?B?MUsxdUNiTUc4dk45a1RtZWdxMnNRR1J6Q2dDcldpd1F0S3owaTdvM3lZb0pr?=
 =?utf-8?Q?3ODYPg+UAZF213aMCo9qpBQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da73a50-f2a3-41a0-87fd-08d9b2f12211
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 04:31:37.9765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbsxJM2k0OpPMuO8vNi3zGAHgjczG0hxPkeS42gpWr88jUZ5j8Y/UCDgfHTLFbGB4dRs5tKyFLrhmwwzeyeTPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3206
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10182 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290019
X-Proofpoint-GUID: 27-kufWTHq7bWb-OtPiByrenepSj6eAi
X-Proofpoint-ORIG-GUID: 27-kufWTHq7bWb-OtPiByrenepSj6eAi
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/21 03:18, Maxim Levitsky wrote:
> 
> dmesg prints this:
> 
> HugeTLB: allocating 64 of page size 1.00 GiB failed.  Only allocated 0 hugepages
> 
> Huge pages were allocated on kernel command line (1/2 of 128GB system):
> 
> 'default_hugepagesz=1G hugepagesz=1G hugepages=64'
> 
> This is 3970X and no real support/need for NUMA, thus only fake NUMA node 0 is present.
> 
> Reverting the commit helps.
> 
> New syntax also works ( hugepages=0:64 )
> 
> I can test any patches for this bug.

Argh!  I think preallocation of gigantic pages on all systems with only
a single node is broken.  The issue is at the beginning of
__alloc_bootmem_huge_page:

int __alloc_bootmem_huge_page(struct hstate *h, int nid)
{
        struct huge_bootmem_page *m = NULL; /* initialize for clang */
        int nr_nodes, node;

        if (nid >= nr_online_nodes)
                return 0;

Without using the node specific syntax, nid == NUMA_NO_NODE == -1.  For the
comparison, nid will be converted to an unsigned into to match nr_online_nodes
so we will immediately return 0 instead of doing the allocations.

Zhenguo Yao,
Can you verify and perhaps put together a patch?does

> 
> Also unrelated, is there any progress on allocating 1GB pages on demand so that I could
> allocate them only when I run a VM?

That should be possible.  Such support was added back in 2014 with commit
944d9fec8d7a "hugetlb: add support for gigantic page allocation at runtime".

> 
> i don't mind having these pages to be marked as to be used for userspace only,
> since as far as I remember its the kernel usage that makes some page unmoveable.
> 

Of course, finding 1GB of contiguous space for a gigantic page is often
difficult at runtime.  So, allocations are likely to fail the longer the
system is up and running and fragmentation increases.

> Last time (many years ago) I tried to create a zone with only userspace pages
> (I don't remember what options I used) but it didn't work.

Not too long ago, support was added to use CMA for gigantic page allocation.
See commit cf11e85fc08c "mm: hugetlb: optionally allocate gigantic hugepages
using cma".  This sounds like something you might want to try.
-- 
Mike Kravetz

> 
> Is there a way to debug what is causing unmoveable pages and doesn't let
> /proc/sys/vm/nr_hugepages work (I tried it today and as usual the number
> it can allocate steadly decreases over time).




