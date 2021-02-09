Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA46A315C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhBJBVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:21:50 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34246 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbhBIWyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:54:20 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 119JPE0l123201;
        Tue, 9 Feb 2021 19:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nCd9jyVH0x06fmHKCHhbI3VHI7ci9nzD0BUVFAFMWCI=;
 b=iC02iDdH8ZTipGKoE0N3swNAYMKJnxdHLFwV+N/u6bhuFRS64P1jIqmL5lLjybsjk9nh
 heN7RIezsTe8Rz0yIaSFA5eWuaHBP9UXyXo/ISADYbpnMv+09Jr522fXSGoj5xl2lND1
 zjsJS3wVu4L428oy5ViQqpDGMUy8OfkJRI1IPavtSckYTQXS2W+XA5fqKK8VPCr8Fhy6
 +GV7/eKL8HeXUaykVbNxIiECM73spF+ltvvnXwh8dfeRg+FsFNHB2KnzRPeV9qwe1tYh
 W0ueGtK2/gvMktDh+gYerF+X3+moWADGFOZPsF/jJgJIPSUB/coaxmofEAMpYUgcdYi4 Lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36hkrn0qab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 19:30:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 119JTt10107160;
        Tue, 9 Feb 2021 19:30:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3030.oracle.com with ESMTP id 36j4pp5ab3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 19:29:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFazov0yHQ6VsUMoRKtJRdHgNpIDDBl76d5xElhmgDRXsdRhxepuhK2EgR2sXB3x/EaRqEXSgP9aStJQQwjSxUwchXW/Y5Py7bAr9RXOy6P27yBzR91+evb3NkWTxZuMmCg5qr9jb4xLJ+88l2zangb3i+XvnzEWMqlrzOp2Gj1raD24QKn6JuCT/2Q9JNBXpy6uZz7FSksGSpHoCVraAiiCj9rr7F1NbdJyRiyg51jO8K5JBU9Q2zIEgxUxi5Yy0I6sRxytBYhnb6BVB24ANf0G1rsPqThPHhbRtHG2DAnZ6ztkUBoOns3gHZOKJxMiNRmu3Vghp3H7kt6zkkojDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCd9jyVH0x06fmHKCHhbI3VHI7ci9nzD0BUVFAFMWCI=;
 b=eYBM3tzl0XHOD5qtsdtbCoHYB3Bn3jW2xErM567sMgCs9WEzI1ZRT6ClTc7gibqfgHw3Gb8zbwOCCtWLQ2Y1JwLa52dEGwyf+G1jojaEI6wE7Zs8bXwnNV3V5i4qqIydaEZuEdNr4GZZOHmZ7YzvZ1YbFucRmY11uP/5b3+sVtkFbWxzAXEjGxC9D6Y+y0XTJgDT1CZN0Bjc/7FW1VVuvtxeXRyiP8UuLs3deqtvC/a/OgSMCcLf6Lss1dAyX9oUYD7bGmvGHZHKSKkqvKc4Rjt26See4tlQB00EZeEGthycam59dbmqvZMAFdTp/x426HC71fCNtQaYyLNkHtQklA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCd9jyVH0x06fmHKCHhbI3VHI7ci9nzD0BUVFAFMWCI=;
 b=py7sLzEtn0UkegvyJnXvTNACZ09LzJVTlCm5xP8gQ4BYwq0DtO6+HduUszD6L5NyZycQ1HKrvUq+Z9JAUBl7sVOl5pmJFqg1g0Bz49uZwr6/SZaxbqbPSrRKirAWPW105yDptZxg1B9YH3Qpr4m4n+xqfus/MvdpV42w76Nusas=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4401.namprd10.prod.outlook.com (2603:10b6:303:6d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Tue, 9 Feb
 2021 19:29:57 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.027; Tue, 9 Feb 2021
 19:29:57 +0000
Subject: Re: [PATCH RFC 00/30] userfaultfd-wp: Support shmem and hugetlbfs
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20210115170907.24498-1-peterx@redhat.com>
 <20210129224938.GC260413@xz-x1>
 <339d27e8-9f34-3e80-2910-46f46d58e9a6@oracle.com>
 <20210206023627.GD3195@xz-x1>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <201f2636-1193-2cc1-ccee-a91243f14666@oracle.com>
Date:   Tue, 9 Feb 2021 11:29:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210206023627.GD3195@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR12CA0046.namprd12.prod.outlook.com
 (2603:10b6:301:2::32) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR12CA0046.namprd12.prod.outlook.com (2603:10b6:301:2::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Tue, 9 Feb 2021 19:29:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bca1543a-836b-4db2-2f40-08d8cd3115b2
X-MS-TrafficTypeDiagnostic: CO1PR10MB4401:
X-Microsoft-Antispam-PRVS: <CO1PR10MB440191EB1FE3EC50E5040DFAE28E9@CO1PR10MB4401.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: duOHJbxumV4ABBrUI4DkC0zimlZd+PNjpIR/eyHHtTL1cqpr3BGvphAvLad0oli8ujZp7rOl3PEoW6iKkCcsUuWVEvC6xQqWrBeYHoXXGOYZnCwWyc8KSZLFkJXG0B5+O3pLvWizAKTtKAVvbTruY148DLVg1mz2tdJjCVRBykFZHrg7KWDoEEzMxVHEbbYsoY7CFJOQ4i5VSqLTN/JW+WA9+wv74LIU66w1fu7lrRF1CyDD1uyYIW9ajeynQbFpfgmebPHObDfLMUQA+7wOJkhbSIYs25rvtwS3TFTiXY/6z7woQ4OSH2J23CTjBMic47ta9t8Od8UEfOuHOZughGP9WuuPf4Xhek1KWvcCNhqaC3h96W+LmWd3P/+T0skSNEgk4pHYLg7+/u4+FQp8zMaQDzotal0za0s2j3nw3fwKG2Re886EX3ntu6vE1P2phApfDjvEC2gkEj/grLzD4YxD3amuUzKLS1VTIip78Qwv/AQH54V8XbsLVUl3uUiHbpYWCogRyGLfzLgt2AUUFn+RS/mMg0nHI90BzYnIyV9FqK95Im/sTJlpqXEtptcR3INC99SmxcYDQtrg3JueuUDXw2UU9z0hpAeMfcBFLVI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(346002)(366004)(136003)(5660300002)(52116002)(2906002)(54906003)(478600001)(66476007)(66556008)(66946007)(8936002)(26005)(44832011)(31686004)(7416002)(36756003)(6916009)(53546011)(186003)(86362001)(956004)(16526019)(2616005)(31696002)(4326008)(6486002)(316002)(16576012)(83380400001)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U0t3Yno3TWRjVlhsWWxscW5ianBETTJzKzdIaHpsRjk2T1FxZGlialVGR0U4?=
 =?utf-8?B?ZCtwbXVWR0cyTmtnVVZJSHViSG5ZbTBaSGpWODMzcm13Y253elNlbFBZd0FY?=
 =?utf-8?B?eXF2TFByZUo0QlBFckIvMmpyTm9JSjFhQXR5eXZwdTk1bEY1dUJVakVrU2hT?=
 =?utf-8?B?eExUdXh5VGJXMHNrYmtZbzl4ZWJNaFovZ004M0pjaExRVDc2MEhLTTZpalBJ?=
 =?utf-8?B?NXYzUzJUMVhUZElyTkdiR29OdlkxSy9RWWZkV3gwOVVWZU9iVWRTLys4VTZN?=
 =?utf-8?B?cUpVNWRjMkRFQzNGWE5VWXRwRldIekI5bmJsSkkwejlMbXZuNUh5TzBFdS9u?=
 =?utf-8?B?elBPb0ZZT1NoZFl4MjBrR251dUp0MnRjaHdrWDkxV25QcGV1OEdXUDl4d3l2?=
 =?utf-8?B?Wkpvb3JQQ3RoenF5Z0t0dS94a1dUNVhMLzNHWHZYN3orY0ZFajRvRFpqaFFq?=
 =?utf-8?B?Zm9qRXdUR1pOU3kzYkJGTUlIVXJUdzAwWkZzVFJVdGlvR24zMTYra0tldjBL?=
 =?utf-8?B?RGF2NEM1RHZKNDJRbFU0ajFjUVhqN05RZTB1R0lJcWlIeWJqR0ZReVBaZ3N0?=
 =?utf-8?B?OENFcHFITStsL2VxeHRIelFjQ2tHODhmNHRLN0FhOGR4QXpjR3ByS2V2ZHZh?=
 =?utf-8?B?RmxIcElMbGhjYjBMTm9aNnN0RVZiSHNKNmE5VWRXbnRPa2Z2dWFpTFgwc243?=
 =?utf-8?B?eDREaUR2b2JqaCtZSElaK0RZaW5WYXF2V0Q1OFZuQWFOQXh0eGVGZnJSdHRa?=
 =?utf-8?B?RGZXOTdQSnVNN3FDMGhWRXNINi9VRW8rc3MwSEJWZ25RNkNGcDdqQmtUa09F?=
 =?utf-8?B?YXlmd2NWV1dGZDMyQlkrWEFzcGErUDhObXQ4cmFwY3poZllNbDI4SURHR2ZE?=
 =?utf-8?B?RS91M3NiL3ZHZjd4d3IvQVJMMm45Sy9MckJWbDhJbXlncW8wQ0EvUXRCSXF3?=
 =?utf-8?B?blNIVmpKMWJxb3FheVA3T2xMOGtxNDhkRXZQV1RHRmxheHIzcjZhSkNXMTN5?=
 =?utf-8?B?cXpnbCtYZ2Zsd0J6cDF1RnRLWlFRUGdtdG05d3d0eXN1dTVwcXB5SWZFMXZC?=
 =?utf-8?B?L3BMa3V3RHNvSHkyWVJZZGJQVVpNdlFtSWV5ZFNmelFKNEJlSzd4aUZ1NUJl?=
 =?utf-8?B?eFJQbVdoalEzNjFaSE5iQkZLcngwcFNYdHFrT1Znb0FEbS95OU4vbTRxR3Zo?=
 =?utf-8?B?aWdNNXdXblhjcmYrWkxtQ1lmNyt3UmdIVU9FdVRNek9mdlk2RDFWWDBNS1BL?=
 =?utf-8?B?RGV0K0QwcTBwckJQSW1aYklFRVF2dzhQNmJMZlhlVXhKcmQxWkxDUlF0VXZZ?=
 =?utf-8?B?NWhMMHJZU3RwRmY3dFJxMnRQWTd2bnNVaEtFdmxaSjhXVWZPMG16UkZlN1NC?=
 =?utf-8?B?bDNoZjU2VFZEZG54VWV2UXh5ZE9SbHdaMncwSFQvVkIvMzR1dmQycDVQVnov?=
 =?utf-8?B?OFo5bGFzWEhub05LZnV4SXdTSGpUbE1KTEkyMDA1d2h5bHdJYlpvNmcxcmpx?=
 =?utf-8?B?ZzJJYzNYaGFzQzFDRmltSTc2eGg2WWIvOW1jV2d3Ri9nVHgxSk9BazRkUmhN?=
 =?utf-8?B?eVRJQ1NITk8vb01neHVSVm80UW1IemgxcWVCWktQOFdOTGczRW11NW5LamJV?=
 =?utf-8?B?Z1hxdDVJTVFKem12WWZNdVBKMmZ3YktQa1pVK3F5S1BacjVNVUQyOGNTdllr?=
 =?utf-8?B?Wkh2VitxVzcvc3dMN2YzcjZkNmo0aDVDdHIxdUpIT2NZQzA1VlBwbnBUK2dX?=
 =?utf-8?Q?unMY7cUovhZkCZG0UU2wyC7qWyCXUimo74M0kiZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bca1543a-836b-4db2-2f40-08d8cd3115b2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 19:29:57.7074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCM9A9QGGF9ySy8s+7xlxOAnyVKwA8MCSdS+DHwLEJdpMQ92hKY4Uysqc/xiMA1IFCOFSLgD0qzYeGuVXs6R1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4401
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090094
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/21 6:36 PM, Peter Xu wrote:
> On Fri, Feb 05, 2021 at 01:53:34PM -0800, Mike Kravetz wrote:
>> On 1/29/21 2:49 PM, Peter Xu wrote:
>>> On Fri, Jan 15, 2021 at 12:08:37PM -0500, Peter Xu wrote:
>>>> This is a RFC series to support userfaultfd upon shmem and hugetlbfs.
>> ...
>>> Huge & Mike,
>>>
>>> Would any of you have comment/concerns on the high-level design of this series?
>>>
>>> It would be great to know it, especially major objection, before move on to an
>>> non-rfc version.
>>
>> My apologies for not looking at this sooner.  Even now, I have only taken
>> a very brief look at the hugetlbfs patches.
>>
>> Coincidentally, I am working on the 'BUG' that soft dirty does not work for
>> hugetlbfs.  As you can imagine, there is some overlap in handling of wp ptes
>> set for soft dirty.  In addition, pmd sharing must be disabled for soft dirty
>> as here and in Axel's uffd minor fault code.
> 
> Interesting to know that we'll reach and need something common from different
> directions, especially when they all mostly happen at the same time. :)
> 
> Is there a real "BUG" that you mentioned?  I'd be glad to read about it if
> there is a link or something.
> 

Sorry, I was referring to a bugzilla bug not a BUG().  Bottom line is that
hugetlb was mostly overlooked when soft dirty support was added.  A thread
mostly from me is at:
lore.kernel.org/r/999775bf-4204-2bec-7c3d-72d81b4fce30@oracle.com
I am close to sending out a RFC, but keep getting distracted.

>> No objections to the overall approach based on my quick look.
> 
> Thanks for having a look.
> 
> So for hugetlb one major thing is indeed about the pmd sharing part, which
> seems that we've got very good consensus on.

Yes

> The other thing that I'd love to get some comment would be a shared topic with
> shmem in that: for a file-backed memory type, uffd-wp needs a consolidated way
> to record wr-protect information even if the pgtable entries were flushed.
> That comes from a fundamental difference between anonymous and file-backed
> memory in that anonymous pages keep all info in the pgtable entry, but
> file-backed memory is not, e.g., pgtable entries can be dropped at any time as
> long as page cache is there.

Sorry, but I can not recall this difference for hugetlb pages.  What operations
lead to flushing of pagetable entries?  It would need to be something other
than unmap as it seems we want to lose the information in unmap IIUC.

> I goes to look at soft-dirty then regarding this issue, and there's actually a
> paragraph about it:
> 
>         While in most cases tracking memory changes by #PF-s is more than enough
>         there is still a scenario when we can lose soft dirty bits -- a task
>         unmaps a previously mapped memory region and then maps a new one at
>         exactly the same place. When unmap is called, the kernel internally
>         clears PTE values including soft dirty bits. To notify user space
>         application about such memory region renewal the kernel always marks
>         new memory regions (and expanded regions) as soft dirty.
> 
> I feel like it just means soft-dirty currently allows false positives: we could
> have set the soft dirty bit even if the page is clean.  And that's what this
> series wanted to avoid: it used the new concept called "swap special pte" to
> persistent that information even for file-backed memory.  That all goes for
> avoiding those false positives.

Yes, I have seen this with soft dirty.  It really does not seem right.  When
you first create a mapping, even before faulting in anything the vma is marked
VM_SOFTDIRTY and from the user's perspective all addresses/pages appear dirty.

To be honest, I am not sure you want to try and carry per-process/per-mapping
wp information in the file.  In the comment about soft dirty above, it seems
reasonable that unmapping would clear all soft dirty information.  Also,
unmapping would clear any uffd state/information.
-- 
Mike Kravetz

>>
>> I'll try to take a closer look at the areas where efforts overlap.
> 
> I dumped above just to hope maybe it could help a little bit more for the
> reviews, but if it's not, I totally agree we can focus on the overlapped part.
> And, I'd be more than glad to read your work too if I can understand more on
> what you're working on with the hugetlb soft dirty bug, since I do feel uffd-wp
> is servicing similar goals just like what soft-dirty does, so we could share a
> lot of common knowledge there. :)
> 
> Thanks again!
> 
