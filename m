Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72499372211
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 22:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhECUyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 16:54:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48330 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhECUyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 16:54:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143KnfLc112624;
        Mon, 3 May 2021 20:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=FtTayhrlGWR4AN2fS3r9VD1FdTzdoZfARpXINKy4/rw=;
 b=VRSy02qghuWM/sKnmN9Xs9xmB1kX+4bLFzPZ06k763s+XFKTgjE7Gh3pR175cPtiqBbs
 jQ0kyk38cBWN/6mVmnhoOEwOppJJahXg9EmMXLdjEl9LCseUcur5rIa2yeg0AgjPEbbe
 kKSLzi7lH0tcwN8jue9hBE68pR7VszACvGJp/E3LsVXsrDDK3mna2bhBMvn0rTkYX21i
 QYKidl2rvQWawbdo/fjjER+Z4d/x/cPR3Huo6HcBRGiArsXlpU0/uQbDO2/SlNn/hP3B
 pvDeR/MmgCkQPx0gPWWLmUK0hv5q0+oLimKBundWH2+HpzJ3cO4nkypbPvC2FChNRihu Kw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 388xdrw130-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 20:53:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143KjKPj158561;
        Mon, 3 May 2021 20:53:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3030.oracle.com with ESMTP id 388w1d4pkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 20:53:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkVNbZm+6KCHuP+pjg+ltDV5+IZrF9W+19EIDqtsPnTp2+XGdpSyjWS3jEdHr/kx2WmWUQfiP2jHhfrwN4bo1qaMPm9dgXtoC6PMVGIfErtmvX5UeTAga+cGNR0lE0kpAJclhMxpGQHbluQJ0bnyQGX2KYTHn2A1OiAcRR6kFi6VMAkyLUItG7IV6pfgW5pOR6ZpG4KnCRODGlSyjM1106Nt+D/xzONSw+dCDDc28opRRbIl2swGLZ8z0GVfRYhFe0o8ZjnAGWjp2TxEwA7qPtdN2GzKLQzLcqxJvlKCRQTsmBmWk63vi7RNmNfgck1FI1dWdlQ9ZXVu458OY+k7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtTayhrlGWR4AN2fS3r9VD1FdTzdoZfARpXINKy4/rw=;
 b=IgFEAqIX7+5rZTTM2HIulj3TzrqnAPbh1DwbJDi6E1hHVhgntVgfPCkiHBT3HGCZ3mW0PotybMBxSAZx3bkA9DGcO2A9FlcEGpQIuZBMpIo+OFZSg0Jfx3LEI66oozsGjmoFwZ+AE9aDVFk6fe9+CgmbvojMBdqf2O8n/795XZhyg/XjHhWba92pO04KmwMj5I5ig73C2XDO+frG9o7IkkY585W9p6HwUge2uMuIYk7pLC5VHviP6pnzC3fcqdt92Kn7JsCzX9ZOIpMDja1o3JZ4zL+HeAYN5TU5AJyuQ+D66WouFAxPSiuwGAncdwHH1utZejef45pafF8vFXGlaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtTayhrlGWR4AN2fS3r9VD1FdTzdoZfARpXINKy4/rw=;
 b=pX2IzOApnvzY4PH1UqdumFOOi7Lo4kb6YAD/iSjvKby5Xp1Ehj/s53/RQRhdRy0DxknlawGOm3NemXxsa9yevWx0KVqKIa5mAsBfYz92j+vt8BijeoOKp+deIu7a7N6075sWin+N/SvlurDRPv+Q5/7ZXw8QYhwLf4AUXWh7/Sc=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39; Mon, 3 May
 2021 20:53:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4087.043; Mon, 3 May 2021
 20:53:05 +0000
Subject: Re: [PATCH 2/2] mm/hugetlb: Fix cow where page writtable in child
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>
References: <20210501144110.8784-1-peterx@redhat.com>
 <20210501144110.8784-3-peterx@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c69c12d6-1615-e528-37a7-4776abfc7200@oracle.com>
Date:   Mon, 3 May 2021 13:53:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210501144110.8784-3-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:300:95::20) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR13CA0034.namprd13.prod.outlook.com (2603:10b6:300:95::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.10 via Frontend Transport; Mon, 3 May 2021 20:53:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc22c4e0-884b-40b6-0d11-08d90e75731f
X-MS-TrafficTypeDiagnostic: BYAPR10MB3077:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3077F313691C23202308A97CE25B9@BYAPR10MB3077.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1MGGbRa3ch2E9PosoatoxrwbGt+D0bD5NQfd5iKjS8NTBHqbSLdfCPKLDVR1IUpt/zBsM/6n4CPDXCGEZ/G4Xa0R14VTl/45TcqweBOMDxC6gt5PFJQCvN3Zp84QJEJE/XAn10JOjUCibIj/lkq4+Agj8zi1l1Rb5aQq6u5cbFrpXiAZ265BW8ikp+lix4/q/GHIwLP27bEc3vNf6yXomJl/f7MlyOvwvUE74vlbSxxK+YOrCAnEaQ/5JwRrKcJYPzIsSOSqqwH8Quv/tplSUW7Fsm7ABt3e8TfJKdPq6BnJtQ2fOP+UKh8dQ074vWqfiL0+NHpIH2+6UEvXaagXcU2QYf/1tFowZPY2VmHqy2bm8FTy4EL1W6/b2YxJl+gyrAMO9udpecEuhmMeAEzf9e03HT2LiQhwcgfpEKI85AiAqccbYejcOSXjDO+0zUAZcErxxGpsxMY+UWLkWmfb7phqUYgdxriiZ5KpSB4tToUTv3OvmXM4APcq0Vy11QQTF/6Yos4dd16sXM0sQ52/HYaqBAi1mbMMOkZikZ616qPb8yQH9bFV1Dc2VuIKamo92oI2h+xWomCbJxexCK7zaKVcCuu/y+q2jbDIzWEEYVZqQLxR9di243qffViwVDAGzzft5zzcPWLh5Cc5os1lI4iyolEPoVOELEFNA9YFNaqpXoR/HDkFoF8DDTW/gax+GWxfy9PYE+F8S5Fjj/oS+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(346002)(136003)(396003)(2616005)(44832011)(36756003)(956004)(66946007)(54906003)(38100700002)(4744005)(86362001)(4326008)(5660300002)(316002)(8936002)(16576012)(66476007)(2906002)(186003)(16526019)(26005)(31696002)(66556008)(478600001)(52116002)(8676002)(6486002)(53546011)(38350700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZUluUnhjOVpMd2owbVc4WmdPaFAxdTFBaFdBY3RCR21FR1doRFJJaHhtNHFD?=
 =?utf-8?B?S3VOblVRVUhueXNBMEZ4Ky9qcHdSY3A2NUVaQjlTRFBqM3RrcjZHYTkrTEJo?=
 =?utf-8?B?Sy9FaW1Zc1M1c0hlclJnNm1YdmpaeHJvNVA1OTFJM2g0d2dZck5sWXVXdWI1?=
 =?utf-8?B?N1ZMWWd3ZVFTUTIvcVQrWUdmeXpVTys3VkhBOHVMZTNNWXZwUnhaK2Y2WVov?=
 =?utf-8?B?UDdMTjlPYi9RdUdyR0taZDNjK0ppOTJXUDB2SHFWeXlsWFZLenhHZG5xYVU5?=
 =?utf-8?B?L2JwWFBYQjRkcUZFbG1IMUlDdWtwUCt5Qkt0UFpCTjl6THJaVDBRaHNHSzlO?=
 =?utf-8?B?aGFvQzBkMkVBeGYyamJpWlFhMS9McGxNZ1lMbC9MNVlLZFdna0UzTmhCQnl5?=
 =?utf-8?B?UmZJVCt1TUk0ZjhpSG5WN1cvczFITkNmbEJCTFBUaCtuL1plVk5FdE5VaGhT?=
 =?utf-8?B?YUVsQSszamFLSjg5WDNzbFhIK2pJS3p6TEYwbkxxZGRIRlFKWjNQSkp5YW1Q?=
 =?utf-8?B?YW9QWjlROUlCdlNQS09sdjZJajR4eE5CZXNkM1J4NTg5M0VWRnIxdzdMd0FZ?=
 =?utf-8?B?cFpzcGo5TGNqNC9nK2dIcEEzV3BrOUZJZzEyaStjamdCMityL2dqMyt0MUNy?=
 =?utf-8?B?RTJYUGRrckl1bjMyRXcvMmQxRHAzZHNFUXhUNnU0WnJYaTd3R3BiK3ZKMkYy?=
 =?utf-8?B?R1d6OUhuK21GNDZ1dlYwdVFOK3ltSXEzMkprMncydmRxZWhPTTgwQmIrZmJi?=
 =?utf-8?B?SVpQMnkxOE5ScGRZeXk5UHZBekFOLzFtS3Z4OEliSFlYaC9KVHViREtFdHhI?=
 =?utf-8?B?MkJtWElpYXplMzBkZzdLZUs2eW52cEZnYnpJWmpITlJ3ekZuNjk2U0dnblFN?=
 =?utf-8?B?SEtxR1NzL3kyUmdUZWFEKzJjWG8yelVra01lWEZET01ERWlETzY4RXZCeU9w?=
 =?utf-8?B?dTRCK2cwZ1hFOUlJOTJ0bFA1M3VKU1RlQUJnSDdCK3ZsMTErSi9VQjBiRVFi?=
 =?utf-8?B?c0MzNVRSTDBnM3E0N2lkQk9CYTdqY2luMGJTZzJacGFtWFRkd2pZOWJQWWJQ?=
 =?utf-8?B?U2VxYlE1bjRDdVdRWm1hU3dyWTRwUWZOWTU4SnFSMk1haUh5Zk8rMllKL29a?=
 =?utf-8?B?aVQ3a0VwV2d4T29XSzVaeWdhU1Y4OUJLZTNOWXJwK1VHV3Blall3NnhWcnI2?=
 =?utf-8?B?YlVkZkNOK28vMmRLc2IvTmVIUmVUaWJZa1hlV3ZRcCtVcUdLUjFITFRUK0VZ?=
 =?utf-8?B?U0xlZEtaN1lqTEVvNHoybDE3L3lGQ201U0ZaeC9GczBIL3MxY3lTZUZGTnNn?=
 =?utf-8?B?QTdCN3hJbFZXaEdQeGtHWW04d002ZldtZ1cya2Z3WjhGVDJTVjlrK3hzZ2xY?=
 =?utf-8?B?NVlOcUhTVnZML2ZqbHRuVFVjeDhtK1hLRGNpQnpYMnNZUWZBUDRacXNrd0ZY?=
 =?utf-8?B?bjcxM3J5bXZlREtoVW8vRFNSRU5Xczk0T2taVXJzcHZXak9DcWpmZTF0MzBj?=
 =?utf-8?B?TWlOcm1CWXpuNVlNZ0hvQWtwcjF1QjlaUXdlc2Q5OUs4L1N2TFRwV1V3Vk9V?=
 =?utf-8?B?YzZHeXhrVDFqNGF0QzAxWXo2TElZaUM2NUtxbHIyb0hERGNLTFJWUmRQUW80?=
 =?utf-8?B?RWpKQ2hoZzlhNVE2SVlmd0NscG1lMGVkSXVlbkFEMytMK1Q2N1U3SEJ1SUZt?=
 =?utf-8?B?SC95ZXFuTVNXQTRWcmR2aUVFV3FRUEVjbjcvL0NOdDJKU25qWnc4aE4vUzFk?=
 =?utf-8?Q?EcBBvQP4GFqg8zWCztV4f0MTrwaHqT0w0HQc/7/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc22c4e0-884b-40b6-0d11-08d90e75731f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 20:53:05.7153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raJK0mQzJYrESmvpeuQTEuSza4E4MPI5YO1GDICgOnlv7FM1n3SZBWnHubbr+VQdevhY5Qd6r5UCHvfHCfnHqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3077
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030143
X-Proofpoint-ORIG-GUID: o41Vwwq6Sft01R6v_NZZOGw4iLsAavbu
X-Proofpoint-GUID: o41Vwwq6Sft01R6v_NZZOGw4iLsAavbu
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030143
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/21 7:41 AM, Peter Xu wrote:
> When fork() and copy hugetlb page range, we'll remember to wrprotect src pte if
> needed, however we forget about the child!  Without it, the child will be able
> to write to parent's pages when mapped as PROT_READ|PROT_WRITE and MAP_PRIVATE,
> which will cause data corruption in the parent process.
> 
> This issue can also be exposed by "memfd_test hugetlbfs" kselftest (if it can
> pass the F_SEAL_FUTURE_WRITE test first, though).
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

I think we need to add, "Fixes: 4eae4efa2c29" as this is now in v5.12
-- 
Mike Kravetz
