Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A54635940A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 06:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhDIEiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 00:38:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46546 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhDIEiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 00:38:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1394ZUlj030740;
        Fri, 9 Apr 2021 04:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=l8oVNTByUvRx8vZvU8KiluAwBpXhhQeLuPNcTRMu7c4=;
 b=Hdv0Yn9U0XZIIjc4IZu1JSnPEaUmucawFgVug9sgDA4eYe61XDC36Tw0DUcbz33pU922
 rB51DQ2l+gTAhpilpff35DERqZcYnaD7MQm9gEx/mLbLj/TKOZvutTVwtzFypIkcfu6b
 DhhwcetHxDqbf/HZ0S8OuqojaQnBEJ2V/h7AZJlNgwrt7umVKd3mYtWbkyRk+onv7oZg
 3uZTGJXcMIUpApN49EOu4p3D7r/m7iEcMyKTxu8+BJUtJ1urs6Wmkae6EjGi00oBv23U
 qQzYqZQ5COWcYo83y6DZj7/sU3g+dN54G/lS7uuHlUHrgaaHxYoH+p2UBUiORZBuJFa3 VA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37rvagfycs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 04:37:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1394ZOtf155178;
        Fri, 9 Apr 2021 04:37:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by aserp3020.oracle.com with ESMTP id 37rvb64p3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 04:37:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mD0FCXjRBZSfAuKHpcWw10DPsAGJ9lxpfd2GJo3hLhl2hFiMfBZCfzhItOiGCqBBiz5v1ZYBquuzmMfmP/ChA5Bjsv6Ux6lgdHydHRX6nYoU+j+b2ZiZizSGiXg+kRlqb46UpRLkHqD9qswFVAToc0PLv84MMgm0xDGo7vtL79KUu7NyeGFyfwb9jGaX4gLin5rE5SNpIpX73EqY1iMx3MXnjlGBt87PAEu/LpZs1uuqyOG0jWQsjDcbTJEkArpcaas9G22mnYxuMd+Y6984L21XEoHkO0WURPJfCUIfY8Mivg987EC9YcdGvldZp4PzipcNyp05TMsytexnr58/rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8oVNTByUvRx8vZvU8KiluAwBpXhhQeLuPNcTRMu7c4=;
 b=l81xkmX9XOlwMhuHNbGmue959h4Z3N3mZa21lMCHii63PBa+PFpFutjsBsWrJL1EoZcGi1ja0R0T8XWlkaCHVVPqhG5gmSSVnno0goW/Ixfe8m7KCQwyKQFST+MmAnjbespqUJUqBpGduLBKIID/AZs12y01lClAt3e8YXHRiQZ814qIkoTD6W7RzSiYvB1imRxhL4ygrdrcj6aiJO6K8AuTjhgkr/nlmIt+MVdGufadzP3FtQ7+RkND1sfM95jhkcGe/L8AKQvM9Tx5o1Ungo5sA1XToSfeSRY+STnb3W1vNFPkJv41Bbz/DBtwfSNKk/NAgRJmjqgaojocJfZ7xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8oVNTByUvRx8vZvU8KiluAwBpXhhQeLuPNcTRMu7c4=;
 b=qn2Gj2inJ6wzlhXDgrTTpup7+A0KiPksxHnYqOwsLlFjocm1QuK0Y6V8XMWhU9IrzHppmArt92Cc0EskgiwX7w2yn9nk75OSMrDEAOG4MQ9nmkljyZlWh6gz5zTmn9hVsMWOl8vNQqZHjBkDfTmJ+/55wDKnrhBsx3T0JbmqXqs=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3095.namprd10.prod.outlook.com (2603:10b6:a03:157::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 9 Apr
 2021 04:37:49 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 04:37:49 +0000
Subject: Re: [PATCH 3/4] mm/hugeltb: fix potential wrong gbl_reserve value for
 hugetlb_acct_memory()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210402093249.25137-1-linmiaohe@huawei.com>
 <20210402093249.25137-4-linmiaohe@huawei.com>
 <20afccd5-2bc4-9db9-695e-dd6175b0b42b@oracle.com>
 <1311fcfe-bc5f-e878-3912-ca9a9e0eed90@huawei.com>
 <ecd3e4c9-1add-c304-5f26-7e34e5e6494c@oracle.com>
 <ddec1fba-25ea-ebb3-fb87-41671db5cb92@huawei.com>
 <0ebaa062-80e8-b380-c02e-7eb72e67f973@huawei.com>
 <90188b1a-a206-5586-2da9-683f7537f960@oracle.com>
 <8dfe32a3-1789-6a40-b650-304c2cfb6531@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <83e5f2a0-bf92-ab42-c5ff-52a07eab9ee8@oracle.com>
Date:   Thu, 8 Apr 2021 21:37:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <8dfe32a3-1789-6a40-b650-304c2cfb6531@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0157.namprd04.prod.outlook.com
 (2603:10b6:104:4::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR04CA0157.namprd04.prod.outlook.com (2603:10b6:104:4::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Fri, 9 Apr 2021 04:37:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12b4719d-6d8b-40cc-ca2b-08d8fb113ada
X-MS-TrafficTypeDiagnostic: BYAPR10MB3095:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3095181A9435C7D187F6A7E9E2739@BYAPR10MB3095.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i3OX1g5jCMIIYL7t8Ba/4TIff8s8ced0P8KjvrVNOd7Nfl1r19zS1Rm8uFdUogMzzn2f3hX3bZpJBalEIS9TZfuB5XxmjPfx/4s1B2mtbWTYZzt8kiXIAgR/TDGrpsIZRJIGj1MHtfOlkA3wve02rdgWFp7i9z+StjHgbdv3tkTKywUeBZ90+DRrpcqMKt+PTTHKCXFsJgLaQzbNihwxs1glFUM8H6/PIakmEaxd7baLjurST4Wmeqxe0bRmx1vPAwlkH6DMVEGIJx3XmV+epYOgxjAwFsttx3IjgZEa05nx5C+qJKdxeEHb2OiSFuU7e6gMltF+iM/GJ7Dx5HuaWHHCETRnhLNIKWp1ji8U3QsIY7hnXZa5SXfPoIrg2b3pRlx397O6NwlWysFlCJSUJUacfovLNsseUzemXmLbUdx/0eKHlFMO1fEpKoeCp9PZksV33DivedlnTR3GHzz1cZ3aFKJRi5xfLf4M9kFmvyy5U2tDiTyHbgrGHfLfHX4RUIec/cr1rnujv8ECf6SZMfDkVHFDadJnuZXmSBKVuU8HGUJhQTbCbBNl3qiT0Xk84Ld7NM0i9KcKnZBvgFne7gNn1FzjjcUk2jjqwo6e/NwegfQofjKOxkzxLlHgJ6sJaUa2ytGmK5uXC8Rmp1cHfRPEe2qAaDxAx1kdm3LmKXm8OYqF9mHPXoX6NUnli5nA8WZ2xTbtO0FmBs7PuSdbmxQkg4WOqWLoEV8d861lyPfYEfL4NljULEiyLZ1WydA9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(396003)(39860400002)(376002)(2616005)(956004)(44832011)(6486002)(66476007)(83380400001)(66556008)(6666004)(66946007)(478600001)(36756003)(53546011)(31686004)(186003)(16526019)(8936002)(8676002)(38350700001)(52116002)(38100700001)(86362001)(316002)(16576012)(2906002)(4326008)(5660300002)(31696002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M2l4WkRMZDdXWm9uRm0ydWJzMFJZaWVVcWZFR096Zi9IeUFuYWZCNDhwUlpw?=
 =?utf-8?B?QnZIQ0tGVWpYWGdTM0xoN1lDZ2VzcWxwVVQ0ejJTczlUdVJRS05TbndzVmFR?=
 =?utf-8?B?eGN5ZzVOL3U3cWtxQ2E1eTNTVk10Uyt1Qk54SUE2OEJUMGpzdDRUQlRaaVJT?=
 =?utf-8?B?ei9lZ2w1TnRVeDNBZldNMnB5QjIzWTdzV0psbStIMHpPK0w2cmJTb0owYU9C?=
 =?utf-8?B?cHFycm9xQnJoZnpTYjFYMzdmdVBnZTBsZ2E5Snowb0poT0kycU9zWGU5Qjdy?=
 =?utf-8?B?dnlTY2RaY2ZkaGdiZDJMd2hMTVhReXl3YzZ6QmkzeXFxVmdLRjU5Q0hOMEUv?=
 =?utf-8?B?TWtZMG94K0lhN3N5cDIvNTVVcFNzUHRrd2QvV1VocG1ENUg0V0xaa1cxaU1B?=
 =?utf-8?B?L3FaclB4TnFwdnF1RXhUd2hJSW5vMlVKNy91OTBISHdQZWsvK1A2a1FsTUZG?=
 =?utf-8?B?d2Nhek93eDhFVGsxNmdUMDB1ZDI4blUzN0YwZlA4UVl2YVBMMWlMdlU0KzBm?=
 =?utf-8?B?ZXR6STY1QWJ2UXJ6WHhOVXRzTXBjc2RMKytPMVdYcUQvaWszS1BHSEwyTXhU?=
 =?utf-8?B?VlRyVXUrd3Nac2NVWmlXN0ZjRHgzY1VCcHhpRTdPcEJQWUoxYWIwd3paOUtr?=
 =?utf-8?B?eFB6SmdxUkY0dGt6TnNVR3c3WFNxK0wwVDBDRFNWeHNRbW5ZSGVrSEtmZlR1?=
 =?utf-8?B?aTErRG9tc0txdDI5YThHNWZzejBaR2pZZ1liUlNEdXhsK0ZKc3k4bzFseHBN?=
 =?utf-8?B?V2ZKaU9HTmQxaDN4QVRUNDg3dGtTWUNPVlRodGJkc3lVelE2NllXNUltMVRT?=
 =?utf-8?B?SHZoUCtvUTI1RmFtN2Y4dGUvRW5CWU1vcFZ2RW5GemJFNWxKRWxkNHRyL2lC?=
 =?utf-8?B?UUhiNEJSVWttYmlrWm5FK1hmU29tVUtxa1k3aHZVWjFZRTkzNEptekxpNXNv?=
 =?utf-8?B?YkgvSE05V0p1cjdpbDNQQll3bGNHUVdZMU9ZdGlyUDU2N1YrNGZkSnpXdUk2?=
 =?utf-8?B?MmNMS3FTN2VjanRtSDdXdUpPY3B5NjR5SE9OS29FaHBIK1dTZ0JYWjR2R2NT?=
 =?utf-8?B?VE1OWW5JZHgvd3NMZnFIY01OZ3VFSEc0ck5BRmkrOWhlQVR3R0xpMzZDVHdL?=
 =?utf-8?B?VE1nRE1iZlRpK1BPOHNDbjFLajJDSHc1S3BicEc1aEw0ZGlkY0NkQ0pmSDZS?=
 =?utf-8?B?ZkRUUVhnQWNSV3I0UmxpWVRJRFoyQjFIMDRYeGRxU242dUpXWEprYVNLWWZa?=
 =?utf-8?B?S2dTUFZIQ0ozWVA2VnpzNmpvby9hUE9qQ1RoWFhZNUxvWjBKdFhXOGJ1UEJr?=
 =?utf-8?B?R0IrTUxuc1pTdHg2dENLTkZEYW5oQWI3a2dORjhvNDUweGxPZ3cxcU9Eb3p1?=
 =?utf-8?B?T1lESi9UWHFpV2dmVDdpN2JJSkZWYkFlaFlEdGQ4QU4vL0JPdWlsWmxaTDdM?=
 =?utf-8?B?ZWx0ZGlVMWpaRU00Wk9nWUlSSGpFRHNiV1R0dnlwaHhjeHVZYVlpVHBSbmlT?=
 =?utf-8?B?UDA5S1VlMnlCcEpOTDhNTDkwaHNpKy8vTHlPbXhyUndvSVZTRE5SMWc1eUFy?=
 =?utf-8?B?Q3NHbVFBUzVMSXJBVVk0d0xxNEgxVXN3Yjh3NkpXeGNIRWxTY2FzRTJDVmli?=
 =?utf-8?B?eTdkSFdSZjkwNHdwUjdVSlU4M2dqOGhmcHE5eTVlckVMdTQxcmUzWXFTVVVX?=
 =?utf-8?B?N0FOZlR2akhhQ3ZNRXVxOUhOanYwaExXVTBrMFpvTTN1WHh4MkxjbjJXUzBq?=
 =?utf-8?Q?ebUqVGmATV/H0BozQXrNbNX/bH6RN1Kndy4r6Yd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b4719d-6d8b-40cc-ca2b-08d8fb113ada
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 04:37:49.4886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNDq11u3w/l1IeBosPjXoA0WhGsEDq8bITyoEuRmbl7wggEdPbKvLuB7ugU4uaQWoZPMuMtA/7Mtit9hSkCh9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3095
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090032
X-Proofpoint-GUID: DYn5x6nPOdNl7p_xEslwbrIS1SL6CNMR
X-Proofpoint-ORIG-GUID: DYn5x6nPOdNl7p_xEslwbrIS1SL6CNMR
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090032
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/21 8:01 PM, Miaohe Lin wrote:
> On 2021/4/9 6:53, Mike Kravetz wrote:
>>
>> Yes, add a comment to hugetlb_unreserve_pages saying that !resv_map
>> implies freed == 0.
>>
> 
> Sounds good!
> 
>> It would also be helpful to check for (chg - freed) == 0 and skip the
>> calls to hugepage_subpool_put_pages() and hugetlb_acct_memory().  Both
>> of those routines may perform an unnecessary lock/unlock cycle in this
>> case.
>>
>> A simple
>> 	if (chg == free)
>> 		return 0;
>> before the call to hugepage_subpool_put_pages would work.
> 
> This may not be really helpful because hugepage_subpool_put_pages() and hugetlb_acct_memory()
> both would handle delta == 0 case without unnecessary lock/unlock cycle.
> Does this make sense for you? If so, I will prepare v2 with the changes to add a comment
> to hugetlb_unreserve_pages() __without__ the check for (chg - freed) == 0.

Sorry, I forgot about the recent changes to check for delta == 0.
No need for the check here, just the comment.
-- 
Mike Kravetz
