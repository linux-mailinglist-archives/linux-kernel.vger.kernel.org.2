Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488A940ED7A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 00:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241240AbhIPWnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 18:43:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:25366 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241229AbhIPWnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 18:43:11 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GK8s6O002298;
        Thu, 16 Sep 2021 22:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=itrMNLZ4TGtTYyw8rQm4wewa8nSPnM/W8cYdgFKEJHk=;
 b=mWqfwF66NwK8ERq5CM/Q65mVASAFdwW8jUDeFz2WXHzGA4t+aSqHnI7OIqmaWiBnTpxS
 8seeJiaDT4pNosRgtwxhJkvTYFIj1qLCG4xu+Fhv9oTr6pwgMCh1WecEfmr+AGw519v9
 +/0ur2bmrdoaW0LWt1NRUmNjX/HujB22vpRPB/XhmewCIEzCJ9+poPf9anuS4SH/Skd6
 mT78CKBLcWBIzG2oO35NWsZPayE/B8wiEx6YP4NDzyVCpnYKoQClJ5Z6O95w6mI4505v
 tU9+vvJi11LSO0yY2kKeegDleC8oAIUD6ztffk4B9GVd7nRd3yZgktbwfEkBjN3wXBLc 0Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=itrMNLZ4TGtTYyw8rQm4wewa8nSPnM/W8cYdgFKEJHk=;
 b=hhMdzlr3ZTxvTEuLmVBIRk1P9gBK6bSPukKppUBgkKkhY+83AaJMcuj5qAOVx06oBcG9
 UCHqOfT+25pg0HWIWn0RTBfEqzl41go0CB+pSuL9qO04wYgpTuwtyihYuf4H5ia3ngyO
 kc7gFnYhb2r8EMiX6eykgRNACDCYN6fOgEkZewitNxhCwNz2exeOEwB6yG00aT0cYxYU
 k/kP8umAeq4Ai4WcMFmuEIT5V0FDEW6rhjRyBdWQMT3T+EGe/mO8qDg6uSORWTT2RyZA
 ibnPV2zcbebAqoRKBYs/7HdvrinJU2rocZaYIAzuRtizMZc+edtFOCIzu7Chmgf8EHAf 7A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3jysnrje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 22:41:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GMZG2k048161;
        Thu, 16 Sep 2021 22:41:43 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2040.outbound.protection.outlook.com [104.47.73.40])
        by userp3030.oracle.com with ESMTP id 3b0hjyx0e6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 22:41:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3vWBlK4s/M+e47uZcH/MclcxFpHGhwTvSdTtBnYeDmvd1dFVbnRcrIencjNAle4fMeYv4fy2qgb3hsZRthNaOBxhpKrSKwz14UPUCTavhbrG+clUNo1ZuWbbm/NJ+A1Cees09AbBVmiDzmeIL3p57YmWhFmHTcLfZPbr21ow0IeN2zy6DnUgK+YBn2GeePQjPS1sSrX145G3mOUg2BqgQRl5MNMLyl2wvpRhY4tC4P3kbbSJQ1pzSfue2AoDENbGpM6XGN8qmvnbHJ407WD6kTU7rR1q+5/tjVi3nveXeeqweu/eRMKNScDcGN1lLBpg9m9vEfHtSn06iWBr6rCrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=itrMNLZ4TGtTYyw8rQm4wewa8nSPnM/W8cYdgFKEJHk=;
 b=D4XqubYGJuJSdSWUNu2UWRu2Az0OnWFjkB1YKmnUSW4QUlAuHy7lJArh6pQJSCJn9pbWIpLPSrMUDy7fIhwv95z9yyizSitVcR9eePnnuyG2pV//n1qEoAIl1SQ/AKP3WJZF75ynGKKP/HeK0T7HmUz96JfZ8QwMwgDCaVO+MHn7Wo1PpPzEG/ru6zB9xYFPKp4HxpoOnaitVNLkBUR6IBPvokoycmykIjvi5X3XNjtwKlj6PPE7nyE9g4Oyb/Xmsm3p/01AkOUy1/QycfxqA381hdYuQ6196MYeD9OAZ9Sm/N8AlDwKdTDdLWxchBIeCjdEjnX8yzGfFMp8cvRiCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itrMNLZ4TGtTYyw8rQm4wewa8nSPnM/W8cYdgFKEJHk=;
 b=sv0xWxUcKiKPh5BBxopncO5EqHTtzmlzJgY7/72WaVbGo5nd1qUJh/xLzmOGlWMT+Hsb5O3p1CyZohE8pjMKj567vjyOC0C8U24sf+SCVCXLZJH4vwnKUhTI1jGnr9SHaP28JzEiO9RNzEKpzyI8PgeY5FZt0DcwAwX6PzGY8Gc=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4702.namprd10.prod.outlook.com (2603:10b6:a03:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 22:41:41 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b%9]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 22:41:41 +0000
Subject: Re: [PATCH] mm/hugetlb: Drop __unmap_hugepage_range definition from
 hugetlb.h
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
References: <20210916212816.86838-1-peterx@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <275f4a51-7992-5852-9173-abdfa3012836@oracle.com>
Date:   Thu, 16 Sep 2021 15:41:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210916212816.86838-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR12CA0061.namprd12.prod.outlook.com
 (2603:10b6:300:103::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR12CA0061.namprd12.prod.outlook.com (2603:10b6:300:103::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 22:41:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bce1ccd-1d87-4008-e2d0-08d9796326f5
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4702:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4702EA9D5D1CBF9D5DAD89AFE2DC9@SJ0PR10MB4702.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cIo0AwsuSfEuLFxwjeptK+pdY94FP65gMneMazFAZOl0d+6IZZtM3tSakRgEejWWo4Tsl+x6kkXaWA7X54qSTdbBqibFoTx+4cAQxVocWJWvh7O1YB+ZQTuTbbrZ8xa/44h0zAGZHYlqq+PbBubOBf+loNJHECF80RyapGFLF+LYDpQThMxWQmrBVBtKThbhzF5WdC29zphlko9JW1DvZlAO+xKEZ39aGTRBYTVTgshEXZdzhBgB2mim5jv0YsFb9P/5H87cz03n7S0AUBkikp1xe4PFErwT3R7BMIgpBU0K7zI4OFag16HspiMTv47WSOlo5sG8XQpvtBmyQ+ZnFKDYWuuRQI3wKkOa7fF0ySoiw9cIqXcSHmqxum6AUmWHD5//VCXVXMTEp8N2wwSctEcd5daGs5PpELpy43mhn5AQbGMoqX5Se33PAQWXpP8iqFD757pSZFBiXX/O7k4XVdkpCElTEnk2r+Tp1EoTqauX6wAaW8xeBltsI6oSD3sk8sYuUKfbaobMblf3hFOqfYWRO2+FFg0TZW0uT26vPMQTZ7yTZQv57ObY7DphtY/VygqzJLt7NouuAS1f0hflWXUFomdZRDozsmWGVoZ7hBe0C/Q8Pir4Onymo14+3DMGX/IUL5wpW4wdL34xbPpEr37NpWCbh4QMe7i7FP9JpcGQn4GfCjooh7q3UtH2fZPuTfcy4GTnPOvKa2ttQsI5j8wbKgJSm4iaBUAPsLXP5whjK2vfxodCv1ni4RxXoSq4jQI37RseDJiMfzdi48Tgew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(44832011)(186003)(4326008)(31686004)(53546011)(86362001)(36756003)(5660300002)(6486002)(2906002)(31696002)(52116002)(66476007)(508600001)(66556008)(26005)(956004)(316002)(8676002)(83380400001)(38350700002)(38100700002)(16576012)(8936002)(2616005)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk83dFhxT2liTDJFTDQrQUM1UmJGOWxRbnFxVjhYMUlXR0R0WkxJY0lndm05?=
 =?utf-8?B?RGZHbXBvcGpUSzJBS09JaXBpNjRneXQ0WEFSTzhXWmZxS0JTaSt3TXFxOXRS?=
 =?utf-8?B?UC9HSUUrTkc5a3hWdW45YzNnT2N2cGIyNzc2RUluR01VSis1NE1mdlpPZDd5?=
 =?utf-8?B?Tk04K2hMMVJvRFhwWXNEeCs5b3I4TVAzcTIwVmp2cVZXWTRZdGtmclRhalgw?=
 =?utf-8?B?THRkMHl0NHVHVTZYY1BwOHVXMm1KSEtUZWp2TVQ1bGErZHl3V1lMais2dkNk?=
 =?utf-8?B?cm5JdTdYemFrTjhqYXdTU2Zadld5Q0Q3SDJxQ1QwQ1N4TUFCdENxRzBKSEpQ?=
 =?utf-8?B?Z3pjVi9YY1F3YW9XS0NFVmoyVFprZjBBS3RjaDNIekF4cm4yUHFWZndEendT?=
 =?utf-8?B?NGxSdzV3YXNITG0rcC82M1I0M0FuQytTM211Kyt1bnUvQnE4d04wY29BK3Bn?=
 =?utf-8?B?aVVuMmJDYXhwMnVKaUJyRXUwYU51V0RzbVBkUjQrb1F3N2FpRmtxL2JhY0dm?=
 =?utf-8?B?N25nWHdBd2lzUFFHZ2hkZVNUT2t0MjJFdWsyZ1RKbXdhQmZxYjUxSGUwTlFB?=
 =?utf-8?B?WHpaQzR1d2xUdG16OGxuS1NTaTJGVnRMN1hFMFU1akNSV3BZRXFrS1NqMHZV?=
 =?utf-8?B?MzQvMVZoUndLb29wdVR4dmc1UmEvMFRMSmN4TTF5RnJVVHNucm9rbUNQb3lH?=
 =?utf-8?B?NDVMYm5DbmNhcmxzclpxdnJlZlZFd1NMQ3lINEtjTm9uMmNSSnNmMjNGaHVG?=
 =?utf-8?B?bG50VE1OaEQ5WVBDQkE2cW9GY2dmZGprd05Hdm1wN2JwaDU0b0dqNHZrOTdo?=
 =?utf-8?B?WXZuUFJEY0dGT1pYL2I3UE9KQTI3eC9KRVlBcWNCLzFDaHZzL2FCbkVxRGFp?=
 =?utf-8?B?TXR1eHQ0aEF2eWt5dlF3R0x2VFdzTDRBYy82N0pGYnEvci82eWhWclp1QkhX?=
 =?utf-8?B?dytxcm9mZWpoenM1aUs1elZ4c3JxVTZmY0hwZVlpTzl2aGN1RWhkNkk4UnVo?=
 =?utf-8?B?bEk4UU5BTmZvWmszeDNxMC9ZZUpWWjZrOUl2S2UrSHFQNTl2Yk54Y3ZBQ2FB?=
 =?utf-8?B?M0lMZWlDaE9FVmVJWStuVkE3TXJZYXRZbENvdWc2NEZsekQ1NEgwZU1jeTZl?=
 =?utf-8?B?WmtqVSsrMTF1V3laR29wYzlVYTdXMWp3OVVrL0RpZ0pFM3pYRmc5QnFxeW9F?=
 =?utf-8?B?VnViWC9SZkNzcUxlaFpnZk5YZktHcmdLTzFyT0RRVEIxaHZKNzkxNmlRNitn?=
 =?utf-8?B?RlJiaHBJVUNXa3h4dzlTdkFYQ2dYenNnY0JjUzFzRlRGUlhKVCtxYkFEUWZB?=
 =?utf-8?B?a2ZycmJVckkxNVk3b1hEYUtqQ2NnS1hUWjZIL3A4bWxRU2JIR0gxeTBNelRQ?=
 =?utf-8?B?dTNVem1HZ3NIM0tLeCtRMXVGSzh0dDMyc0JlUVJNRDhDTlNoYStDaWw5Sk5Z?=
 =?utf-8?B?R09NUnZjem9xa0xBb1h1Q3IxcHFoQnNnbmNYTmVPc2NsTTRpaW5wbHZNMDRS?=
 =?utf-8?B?U3FaZkxHQUtwMmltV1EvQ2JYczR1VFJqYVd5SEdwb1VFaDlCdmlHSmo4Sk9a?=
 =?utf-8?B?cHdXOTI1TlZIZ1NhaEFRcTdDY3kyMldkRWpRenFKUXZNREN5bjNlNUU1Zi95?=
 =?utf-8?B?QkFIUlpuMHBob1dubFdVQWk3cjY0YnAwby9kQzdjb0pYaUptVHMyZGlsaUZH?=
 =?utf-8?B?dE50Z21xVEd3WnRpaUw1aks4QWovelZxbWtxUjRKUE1tVk5RRzRyZE0yS0Jr?=
 =?utf-8?Q?nISSUyzdOK48lF+ktvwEQeihfLvXgwAhi99V2ta?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bce1ccd-1d87-4008-e2d0-08d9796326f5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 22:41:41.6816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTMD+ZLO91/846v2Ik85wlaEkgvRlq49q4qFxOYQpNfnOUBYSMhPdEcQ6KZFybUzPrk7wB0g7G4CGiESRS73Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4702
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10109 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109160129
X-Proofpoint-GUID: xvtFMoHqJ2NShG9ZzxnNh6Gvfm1zQzrB
X-Proofpoint-ORIG-GUID: xvtFMoHqJ2NShG9ZzxnNh6Gvfm1zQzrB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/21 2:28 PM, Peter Xu wrote:
> Drop it in the header since it's only used in hugetlb.c.
> 
> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/hugetlb.h | 10 ----------
>  mm/hugetlb.c            |  6 +++---
>  2 files changed, 3 insertions(+), 13 deletions(-)

Thanks Peter!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
