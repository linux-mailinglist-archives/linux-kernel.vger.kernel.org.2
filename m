Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6048338B7F7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 22:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbhETUCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 16:02:11 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59832 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240006AbhETUCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 16:02:01 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14KK0XEi048336;
        Thu, 20 May 2021 20:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=swX9F1j+p7jo5XU/XSl5P7zYoZePIpnN1BGvttOEzxE=;
 b=ha2KG046dNlrTv9y8u2g/StXZA8MPRWrplj/ktBznA/UoA9hydfjq2YIMgvvhH4hB+43
 wjeqi04/NSex1DXGcjiYCNfYyWeazc7P2sCh0KowrEys175H7JZFMVsA3SJKKPh86p8N
 iVxNszhFYEYbFlb0fRIZWO2146P+Wvuhm62F3x/X3ylp297FfX2EezMINLNvdvMccY1m
 rFh9ADUvAh2QdkKNeI9cTnl4/J7ntkhtm38EyFipw7Iq45qvD0zH1/XVOz58MyNUJbfT
 EKrWx9kjVmKkVS3AC2qNsbPHJVtna8MkvjCgd8pnX2KcbirET7eZG8Vow81CgEJESv0t kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 38j3tbnw6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 20:00:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14KK0T9W110960;
        Thu, 20 May 2021 20:00:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by userp3030.oracle.com with ESMTP id 38megmv1c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 20:00:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hj3DmDgjzMm/Jz1grHbjeGXu0vZ543BKVUrqnfBnkz57iflbqbiEcVowTcIPOguKT65kVohHVpbG2akqQKcSPrE4dj6vSOy6SFE4f3EQCCnMBER1+v5B6Uw7lHZRoymc2hk6/nX8EQ2RiWG+jzO/PC7RAu8iE6NzK/3aubQy3PD5eYN9Z0q24fKZQY3bsGt0Oas1eDZr4ERNmS+jVaBmIbL9QyPk1pEKITDBww/GHS53XYCWsnPdBITYNvFRtcytP1qLViiUqIr7T2mLOWfqSReokmzA0tbMBpOIG2z0ymk+IDUPXAmOXFXcuMah2/eMdgY26Wv5IJB+CKeb9TWReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swX9F1j+p7jo5XU/XSl5P7zYoZePIpnN1BGvttOEzxE=;
 b=icEC0gf5qEl6zGeMquwvqEeKsAI+Lb3ojFjU/KgqH5Nri3ExQiSdaX8WLF6aQ+QPPB/F+v/GOwvVac5Oc2cxYCGTAdwyUzKgFBxQMscYTt7mGWtRafIEq8IXC9sovnyw2Fhm732XXRP5qEUe6sRCR0KkGOakJYsu/iIBmA8+KM6BdpFmnyKnURYeS+icZYqgEPORcuGkq4cYy0FUnIr+NaaAulWuKYpZMNdPwnuRjJOWR70W/lvLTJ++Dso7u2v4ibHYYPqPyYsU2b4C5E8Bh0j1VevHZuwNOY14diZYTBrZmRrhCkFAu/gGLXa4PJhp4OC9EVO9EJ2/gC/ioEJlsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swX9F1j+p7jo5XU/XSl5P7zYoZePIpnN1BGvttOEzxE=;
 b=WMPhCutb+iZrNO2TKOh+gOw4/zFJr+ujdAblF/t0d+IC+zy4UyR7Wob4hFGw8nPw1/nnqlPWuPJEpTvavstnvrfr5E55zlZT9ivpK0Z8Jtic+QaAx1mH5irVUUwce2X4VWJlztbk+L9YLn8rb1AMWPdSKapil2fAIOxXlC6U/rY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4702.namprd10.prod.outlook.com (2603:10b6:a03:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Thu, 20 May
 2021 20:00:27 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 20:00:27 +0000
Subject: Re: [PATCH] mm, hugetlb: fix resv_huge_pages underflow on UFFDIO_COPY
To:     Mina Almasry <almasrymina@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210513234309.366727-1-almasrymina@google.com>
 <CAHS8izNkBvS9gkSjy8FbWBOPDynwr8PXXXbMHt_2=5sZJsa6-Q@mail.gmail.com>
 <09dc0712-48e8-8ba2-f170-4c2febcfff83@oracle.com>
 <CAHS8izN3+DwCMnVotW7UoiROKEpBh=i+n2jb+oMJQwbKeegx7Q@mail.gmail.com>
 <CAHS8izNECN6U4KDLS-jrtni6WMszK6rF1XjcWwwGAByb3pEr8A@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <61c78897-27a2-768b-f4fe-04e24b617ab6@oracle.com>
Date:   Thu, 20 May 2021 13:00:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAHS8izNECN6U4KDLS-jrtni6WMszK6rF1XjcWwwGAByb3pEr8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:102:1::48) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR04CA0080.namprd04.prod.outlook.com (2603:10b6:102:1::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Thu, 20 May 2021 20:00:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65bdf3e8-2766-436b-11c0-08d91bc9e9e2
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4702:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB470226E371F33F04FA55F46DE22A9@SJ0PR10MB4702.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pc1OBdhtTv6l4qaKvSvR42llUoc7t2gaeXoGaxkxLsZEZIPR/+XALnyFqZg3TTxaN3BvoP+DoKipP1IicKrKoms7sucfd5v/Pf0Fal6naByjHO7QQ1GYkkqk95E5Jd1QmhWLaPeOd7ZyQ1V0U9+zeT5fGF0AfWnuoiDGCvZ7aJCr3P/BUW4hn068GW3ECaBj6ASooGxTCKgVwaqld4bqsdh/a708LJbNxuuKRPFMgoG+ehkQhr2Mxv2kcK+fOg2IfmDt5zbOITHVw8SOK5DBcgSRyfiwM2pjtx8l71XQh7+WCuDOh1VFRoCO4xpb2Wirjg1TiFwiNHUBKAkikyeauguKswQyKSsli+WKfA5d6FBZRtmMchuZjAtTEwR9QtErpVt5YHikNh+VXc05H73oUhjYgOtNLCwrmp03ynlp4bch18B2/f9cTiMbbRHufH1vV5o2vsXn0T1jIJxiH98I8EHvVtNC7vDbHOSXwJSm7cQqfa5FnTaxjR7dc8QVlQfnOWABGbXXezRj8M0rgdkNTr6XGz5SGvtqGv5YvYZ7dQ7pbho/uF0iJwNmRkGw5X5qIx91J6v7qkatjc/1HYUTNDWo8Jb6DYh8LfjLPBSYMinO0/KYwed9CKyb0TFNeeOe82hWL3ADRNlIdp8PovA8MSXZc+WAltKdMnK8LpKEV3IFrHdHO34jkIXxWV+Euh32eVCy42Wasxz7ENG1BWXQJ+9TT3CkTJ7ge1P1c1y2638=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(396003)(136003)(366004)(16526019)(186003)(2616005)(53546011)(52116002)(478600001)(54906003)(6916009)(44832011)(2906002)(956004)(8676002)(26005)(38350700002)(66946007)(83380400001)(38100700002)(316002)(16576012)(66556008)(8936002)(36756003)(6486002)(66476007)(31696002)(31686004)(86362001)(5660300002)(4326008)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SjBNbnpTRFlQWTlQLzVjUWJqbDBrbTB4dThjNWs4SWE2VDcyanFzcEg3ZndC?=
 =?utf-8?B?RzF6SUNDTWVUbVB0U2VzN3VheTRMYVJheE53Njh5aThWMVR0M0diRUF1Tld2?=
 =?utf-8?B?cDc0K1JwOXA1Z0pzN1lpM0RSdXY5Z3FnVkk1VVh0a3dvTDJBZWlBNlE1VUpL?=
 =?utf-8?B?Ty9Qc1VjRGxUV2NTL3ZJT25EdFVTdVEvYjRwb08yZWduRi9ybzgzUk1GY2FW?=
 =?utf-8?B?Y0VFQUNaT3NKN09GSE1ielR4cmRhRVBrTmowRlRCSGNIZU5td1ZlamVVem9p?=
 =?utf-8?B?T09COVVkN0JYYnByanQ4WmI4cmdEVGRxanJwWFhlTzFLczhqd0NOQ3FLUGNv?=
 =?utf-8?B?dmxxbWNuS1FKMit0aXQ4THBrQXl5Qjk4aW5QUkhVMzlLaFpmMFN0VTdVbnlV?=
 =?utf-8?B?dDJ2amFvY1N5VE9kWHgrVU5FbkhtR0NBaVFZM0FLdVJ3bU01ZFdrME1qMWpl?=
 =?utf-8?B?NDVjWkRVV1VSbCt1U1NvUC9IMCtxMEx0R0RZN3EwQUJ2QTQ0THNjNFNaQ1NV?=
 =?utf-8?B?U1ByclV1TTczQXhyRk5GT0dPWDd1YTVzcnpzRkhIaTVOdWNyOXNGOHdBcFFW?=
 =?utf-8?B?aHJiNnRKdDBCb0VGZDUwVndrcXVxL1VaTkZJMmFLNmZidlJPaE1JSjRXSFA4?=
 =?utf-8?B?T3I3MU1EWUpsbUp5emcvRExhS1NncFRldklyakx5QmNUbkZNNWs3MFlrZC8y?=
 =?utf-8?B?d2MvaGJhTHdNaWMyTUJDUWEvOUtTUzFxQjFCV3E2emt4SGY5TXBPSTE0R2ho?=
 =?utf-8?B?c2tMSVNrVnRWbjVPU3YzbDhkSDdPTzlhVWJXR2NMZ2ZHWjRFTXM5RmVwWVBI?=
 =?utf-8?B?aVVrNVVaQ3hUUER1OGY5cFU4endIY3pOOEJwNzVGRDRGaHBwUW5qc1R3dGFi?=
 =?utf-8?B?N2RXWWhYV0tvNW1TdmtqVTlsVitWd2RFZXFXRXRuNUY3QThvaXY3YTF5VWFs?=
 =?utf-8?B?WDFNdWJvOGE4bWtodXpwbitLVXpScU5xbllvS25XckhpVmNCcFI0VEZMSGtt?=
 =?utf-8?B?L1ZBTEZCSXQxVDZnMmpJZEhkRUE2WExJcW5sNDIrREdHL1VKamM1dDRhTDNC?=
 =?utf-8?B?dUE0OGNnS2laWWJ3d1cwMDRJREh3MGJzUzFJVXkyekozdXFXbDlUSng2dTJZ?=
 =?utf-8?B?UjVkQVhJYktxRFBzVjY2Z29lVjd6WGRsblJEZHIxTHpHazBvRXR5RjJJekdL?=
 =?utf-8?B?enppaWlMdzlOUms1Zy9lZTBNdm9NcDlvWXZLc0pyU1ZaWjdyN2x0L1ltYzVt?=
 =?utf-8?B?MWFzdW04QlV2Q2lwRVRwL0tqQU80U2ZwRG16SEFlY1gxQVNNY3NLTllWc0Y3?=
 =?utf-8?B?NkV5UE5TTk9UTllTeFlLQkMrT2pjMGhTb2NWWVlnZjd6U0FmM29RZFp3ZTdJ?=
 =?utf-8?B?RHdsaGN0NHByYTZycmtnTXBXR01hVVNLME1DYlhEdVh4Qloxc09YRy84OCto?=
 =?utf-8?B?b0RKTTVYQ0lkZG5IRkxVd3R5VmtwbERZZHY5WlMra2twT2hxTWtmYWRHK3ho?=
 =?utf-8?B?WU1ZT0xrTXMzTE5OaFZPVjlMc2lxRjh6cmhPdGpoWGNUUFlYR2R2UmxCeWx4?=
 =?utf-8?B?Q2NoaHdWZTluMElTY1hrZ1cyRk1NVSsxQ2V6bmRmc1BCOE5wZkFoM3NleEFO?=
 =?utf-8?B?bHdPNXlEaDhSN08rLzV6aTJ4SktUVkp1ZWEvT1J5eWhkdnpmTUhuUS9JbStD?=
 =?utf-8?B?UHIvTjhuY3dJUmJOZU5VMXhHMVozL0dLeTkvWjB3T2tKOTE3QllGOGovUzN4?=
 =?utf-8?Q?tCT6tkRxTME2HEXFOH6kpJZEONVNQ7mgNw+6bNI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bdf3e8-2766-436b-11c0-08d91bc9e9e2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 20:00:27.8268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayWKzFCfS8Aqb+AXh18F7VW6bWg2BlHs60513X2+C1lwCDTGdy9YTr8wbX4PNXRHaIuie/9RKkxTNI0qvZ8otA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4702
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9990 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105200123
X-Proofpoint-ORIG-GUID: 6A2n_AJIiV0TDJtEV_qzfj0UR5AeUJ5L
X-Proofpoint-GUID: 6A2n_AJIiV0TDJtEV_qzfj0UR5AeUJ5L
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9990 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105200123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/21 12:21 PM, Mina Almasry wrote:
> On Thu, May 20, 2021 at 12:18 PM Mina Almasry <almasrymina@google.com> wrote:
>>
>> On Thu, May 13, 2021 at 5:14 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>
>>> How about this approach?
>>> - Keep the check for hugetlbfs_pagecache_present in hugetlb_mcopy_atomic_pte
>>>   that you added.  That will catch the race where the page was added to
>>>   the cache before entering the routine.
>>> - With the above check in place, we only need to worry about the case
>>>   where copy_huge_page_from_user fails and we must drop locks.  In this
>>>   case we:
>>>   - Free the page previously allocated.
>>>   - Allocate a 'temporary' huge page without consuming reserves.  I'm
>>>     thinking of something similar to page migration.
>>>   - Drop the locks and let the copy_huge_page_from_user be done to the
>>>     temporary page.
>>>   - When reentering hugetlb_mcopy_atomic_pte after dropping locks (the
>>>     *pagep case) we need to once again check
>>>     hugetlbfs_pagecache_present.
>>>   - We then try to allocate the huge page which will consume the
>>>     reserve.  If successful, copy contents of temporary page to newly
>>>     allocated page.  Free temporary page.
>>>
>>> There may be issues with this, and I have not given it deep thought.  It
>>> does abuse the temporary huge page concept, but perhaps no more than
>>> page migration.  Things do slow down if the extra page allocation and
>>> copy is required, but that would only be the case if copy_huge_page_from_user
>>> needs to be done without locks.  Not sure, but hoping that is rare.
>>
>> Just following up this a bit: I've implemented this approach locally,
>> and with it it's passing the test as-is. When I hack the code such
>> that the copy in hugetlb_mcopy_atomic_pte() always fails, I run into
>> this edge case, which causes resv_huge_pages to underflow again (this
>> time permemantly):
>>
>> - hugetlb_no_page() is called on an index and a page is allocated and
>> inserted into the cache consuming the reservation.
>> - remove_huge_page() is called on this index and the page is removed from cache.
>> - hugetlb_mcopy_atomic_pte() is called on this index, we do not find
>> the page in the cache and we trigger this code patch and the copy
>> fails.
>> - The allocations in this code path seem to double consume the
>> reservation and resv_huge_pages underflows.
>>
>> I'm looking at this edge case to understand why a prior
>> remove_huge_page() causes my code to underflow resv_huge_pages.
>>
> 
> I should also mention, without a prior remove_huge_page() this code
> path works fine, so it seems the fact that the reservation is consumed
> before causes trouble, but I'm not sure why yet.
> 

Hi Mina,

How about quickly posting the code?  I may be able to provide more
suggestions if I can see the actual code.
-- 
Mike Kravetz
