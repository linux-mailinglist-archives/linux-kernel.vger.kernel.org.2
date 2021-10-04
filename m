Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0404204F6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 04:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhJDCj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 22:39:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22546 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230295AbhJDCj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 22:39:27 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 193N0xIh010779;
        Mon, 4 Oct 2021 02:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ZD4o45bYwW/KpbVBxzKIVqnOalxvsxJBiNYrZ+CE2rY=;
 b=gLkRIuhwKVdvOyQuN38Sdz2ptxxvPQczBoC7gIWM+O3Hk9h4cdJBsEZSVRQiB8ILw7K/
 I5h3YEkvRyx+lVlPyoig7gxathKLNjEyPvvJa9Kp/57ZaEdw+8KNv3JDy2qbPnXhaHj6
 5M7Vw4wl4jAAVnjjoQPdO1CSjOug0mT75h2NDZv9u1zMMl2g/q7TYmEPVs5JwcJmrQ6m
 tfdwBhySkcKArgV1VJXwpLBeSWZ4q0mJfgtu5kFVzOUSaYNCrMXd9DyiDp6Fwa2i4LRK
 LYcraAx3bvvP41fu2U3i9iaxyq8Q/NBrY49+h3U3HwKVWIYJBVcy8twI/J5IVpTDXA2m SA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bfasksaph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 04 Oct 2021 02:37:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1942YXO6164867;
        Mon, 4 Oct 2021 02:37:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by userp3030.oracle.com with ESMTP id 3bf0s48qah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 02:37:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBv2rIHH5cxKhL1PB5X4UDDqmOrfZkKVFCZ3a7ubj8CdTU6tjtZpNVJl/Qxw9QkBp+RofopP2dDXw3fX4L5a5v6kfEptgmB9g7h681svxcU3aboz0la934z2q9yIIBFBx6txBKqmbzZEHBgdzy+FbutUAPdRLrEvDbBWy3F/x9bMMftQT7QPdBHQ/ncoxne8QWU6k7d2M6GeCcoMjITYLxTPAiG5YqACPj7r/4JIPAWRj24U67xQm+psJxh8CfhGuEjUsGW/NjLFCQegX/V/9Uy1dDC32BON2inPUJTUGGbn8x3JdZdE83Vyf/c6wFz+044xB1pVDFZuBLA0q1EIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZD4o45bYwW/KpbVBxzKIVqnOalxvsxJBiNYrZ+CE2rY=;
 b=JnoTTR483YmzgLO3l6oCsYlo9/JJnEs2EyuOftELK17ItJRJ1sBaRPYLd14cglmtOo1ngSXoB0DADFCGuvHRTnw5S86gc9DsDMCrAtyrj68dY57f5wIOpSPkPft/kugi/2VOoINc1VJ/9L6HEUwFhy42MxaqotIeee8XBM26KV0YK0lSPN5rPBYzn844vuALfkte/Zt2KoMI52KD3qcVwclJZKbKCQrKQUKZHmkxr6eUfzPoDX1kp6591uiibJiQbWzIaQgRIud6/WmcjPbOE0fHTTzF9/M9lG9nUOz7talYqVSCBRV80j/YMrazAN2kPZJNlbiuSBTTBhU+nFIN7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZD4o45bYwW/KpbVBxzKIVqnOalxvsxJBiNYrZ+CE2rY=;
 b=uvFigZyFgTVTOfaj/LLfmX7713Caa5dEeB7mdL5FSck7PhZqXPaE5bGl/rwqUmlKVKcQm7b3zM1FlBkUE7uaXntj0dBwrXUZtYMN/Oto0aGwo1OMq9c+uOLpECwnlxjH7Kk6/NsF0+URFy4sIQtQWvhSUi8cHAZKHq8DL63dAFI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4354.namprd10.prod.outlook.com (2603:10b6:a03:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Mon, 4 Oct
 2021 02:36:57 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%6]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 02:36:57 +0000
Subject: Re: [PATCH] mm/hugetlb.c: remove dead store in demote_size_show()
To:     Matthew Wilcox <willy@infradead.org>,
        Nghia Le <nghialm78@gmail.com>
Cc:     akpm@linux-foundation.org, nathan@kernel.org,
        ndesaulniers@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        lukas.bulwahn@gmail.com, kernel-janitors@vger.kernel.org
References: <20211003114113.109463-1-nghialm78@gmail.com>
 <YVm2MHbhEU0b7HPM@casper.infradead.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ccee8f63-f5dd-6231-5625-a67ad3b80a6d@oracle.com>
Date:   Sun, 3 Oct 2021 19:36:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YVm2MHbhEU0b7HPM@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:300:16::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR13CA0013.namprd13.prod.outlook.com (2603:10b6:300:16::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.7 via Frontend Transport; Mon, 4 Oct 2021 02:36:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22862634-afbb-4a50-94bc-08d986dfd5e8
X-MS-TrafficTypeDiagnostic: BY5PR10MB4354:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4354854F223DA4B070BB257DE2AE9@BY5PR10MB4354.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RDOU/6CJjMFTlxzIAneFHufMA6VrqS86fxYwG/ABus2MxLJo8dxbfJJ91amnUDThCfUAokjwJtRLO9E7m26v3DmFF9nf8izjKTEVPxBcuuPjn7OIfl2eiI2nM6jxezaKJDb/YiltcN9bAzTBNah/LuEygfBIX6IxHD6Jiyid7J1A9LKLAX6nn4naGoi1i11bDzmmXVUqAeEKKDom2ktHvlbJcQxfb3zSSlmppeLhpF0AswERxWSn/gTWFS0oxL9IItESUTxr3lA/tBzNbw2DgtGkA+0m7v+Fvq0E4Zvc49fnqvzNGvz57HSKnrG2gP7cgZRU7pVU5YuguhnPocj7sJIZjm8ZXhYbZQbP5uU6UuC0Ae6ve/qvQHCRYAb4YbQH/EeBiSEIkcRStjHY2fNz/4zYXPPcpwixgQnh+nNhjLcHge226YSMHn6FFvDc8xJOteVFeufxs+Zvhd1IC8aSbpq5o70l6Wv1/s1BlDB1wVAbOVUSKQiyvbcBiiIFyfoIQNRoe3qx2nRutJwHliAG72y2HxtYCrQu20fGp1vHiRpvlJvy5WaHdKsMGUVDyFzauvsQgFlu5+r0C9duUuLpWnvrm78KzwkIuSgfJm3Fw7RZ/fn54OvBW1xz0/nCjoQJZIwlXfuGXxG2VVafauvzj/uLx6gOW6V4QJAM45eMWkgYPggBQZswXj9xa2+4muNFv2+R/ZD+SaC7tOe9duapDpP+W9k4FrDM7RByr+/td+YRgAHf3bNizdkaCuSPINAY5LH+n0reI5mLy2MGLpZLVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(31696002)(508600001)(44832011)(4326008)(186003)(38350700002)(38100700002)(31686004)(36756003)(66946007)(2616005)(16576012)(86362001)(53546011)(8936002)(66476007)(316002)(4744005)(110136005)(66556008)(6666004)(8676002)(6486002)(26005)(83380400001)(52116002)(5660300002)(2906002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0Y2L1JXano0SGc5TzJVNEdlR2JUZlRUanBUUFpKRHVtUEJKWWZyV0k0R1pB?=
 =?utf-8?B?ZmViN1J3cjhwTmhMbnFuN3VXajJoaldmcmZiMmRrTFpKNmdOZVk4Y3JTbmN3?=
 =?utf-8?B?ZVVOTmxFUTZYZWlUYUtpWjM3aDl6akJqNnBvL05CaXlZY1U1OStqK0x2MW5X?=
 =?utf-8?B?TnR2SUNqQUVOMjRPOFhDR24xMU5ncVJQOXV5eHU5V1B4NUN2bXpxbjU3YlBV?=
 =?utf-8?B?YjdEUHFqSVJJQmJTd0FVTlpxdlFtcDVEM3kxeWk3aTlCU1UvVmRzUWtjSXdM?=
 =?utf-8?B?ZHRHeUdadVoxSG85R1Vud1hoaUE1cVZ1VExEbjBlU0lVaGo5YmJEMExhZXQz?=
 =?utf-8?B?OW5qNERpYTkxRDlBV1IzUUdpQisxWTRJdE5JcThNZDNEL3c4RnlkYlBhZkNL?=
 =?utf-8?B?LzBNOE1EOUlubWxmQzF3ZS9aZUFjS3hJNjFXMWpxVzBiaVNKM1hOemxsZDcw?=
 =?utf-8?B?TzJrRVNCbVZxMzJVME42ODByZVY0ZHNvcXZYaXRUZ3VSQjdjRGN6dHVJV3N3?=
 =?utf-8?B?Q0djYVJJYkVqZHJFNm1YMi9EYnhOTHN0S0o3aGJkaE1vRWpjYXVwUWkxd0Ni?=
 =?utf-8?B?ZTU3RUVvRnRsMHpOV2VoY2ora29lYlNwMzgxc2UwVmZzeHZYMC9hVVQxK2Fx?=
 =?utf-8?B?VElkYXMzVklUekdVejNEZ3pVWTc1S2VtNjIvUzN4SEMrZUlaVFVaWlI1ZGkv?=
 =?utf-8?B?bkxCTlBMd0Vtczl2TStyYnI2bDV3WVZzY2EramlLaThqbjZvZnZ1YUZWVVNj?=
 =?utf-8?B?TUVoeUtWZGR4ODV2dmZkc1FIdlhsY0N6VGIzZ3JlTHQxU3hFcUJWRmV0anV1?=
 =?utf-8?B?Tk95YXQvaXM1bW9jTGYxWGpkTmhRbEpSM2t2OEQzY0RNb0RwWTBhcXRyM1JE?=
 =?utf-8?B?N09iRzY0TG5NNk1JeXRNbmE2cjZCcDVqMldQZ3dKa0I2d2hBNk5rWksrRERs?=
 =?utf-8?B?dUNORmFDYW9RQ0FkcW5HNEZBaFFsVFZMaWROV2N6UUMvNnVqb3MvVVE4empW?=
 =?utf-8?B?OHI4dzNuZEZnOFp2S3QrUCtkR3czU1NKU1NqZXJZN2NJQysrVDVLYnlXZnFq?=
 =?utf-8?B?MGMrUlBTWC9KRmk3ZWJkdWQ0MHFkSzhwYmpEY1FiNFkzZXM1TVVoYjdCek1T?=
 =?utf-8?B?SlYzREs5VVNJVWlSK3g4WnVIaXpBMmNEcTVwcVVwUzNjRHk4c3BJb0N1SHVL?=
 =?utf-8?B?WFBRSEZ1SFgzQ0t6Z05tL1diQXJZM3J0RG5CdTRkOUJ6WXMrU3BvV0RYYlU2?=
 =?utf-8?B?YmpIV25DejYrb2dPMWFUQXVUY3pnT25hTm9mY3NjNkdGUVkzM1Y5Y0RaNHA1?=
 =?utf-8?B?VWhqM1Y1TlpQWEZuK1dTbmtWeFNDOUFqYTd5YVU3QjFBWGI1bVVrbXFkUHNv?=
 =?utf-8?B?SngwajFqMDZOTW5JTGp6WFBFK0hnd3lVR1Q1KzRwU3dLTVFVL1dUTTRWelNR?=
 =?utf-8?B?RjlsL04veXAvalBUWUhUV0UzRnk2UHZocTN5RHJwRmJhOEJmQ1ZpaGJseG5D?=
 =?utf-8?B?bHBsdGwxemRHSlBUR0l1bWNlVXFtWmdPOUVVRHlWVk1ZbCtsVldjaUI2T1Fy?=
 =?utf-8?B?ZXJpRGNSSk5sK0ZpcFpteDhQN1N5bnJKRnduWHpEQ0kwT0szT3owM1FJNFBO?=
 =?utf-8?B?TjRzY09OU0I5MHdwTFJPYVlOK1YxVHVHVytEUzgzdDBVRzJUUjhRd2pmNGJj?=
 =?utf-8?B?NlM1VzZvcGZJaFRML1JybjFacjA4QkhhbU1iL2pmMmoxUENwQ0d4emxYc2pt?=
 =?utf-8?Q?dpMg3aHTSCuhStEKwv0bCi9RTaCi3zWo6B+fX4X?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22862634-afbb-4a50-94bc-08d986dfd5e8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 02:36:57.7111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3iWWg329OUXSIg5wB94xBqDKtIaB2YAZElVlIK6GtPb5P5AdP+j1ahoHB9nkCBwQqQ5oYamsFiBVGWGCRepUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4354
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10126 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110040018
X-Proofpoint-ORIG-GUID: kn-V5KyN_peEPtboJcEQWVoSKLtbrRIG
X-Proofpoint-GUID: kn-V5KyN_peEPtboJcEQWVoSKLtbrRIG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/21 6:54 AM, Matthew Wilcox wrote:
> On Sun, Oct 03, 2021 at 06:41:13PM +0700, Nghia Le wrote:
>>  {
>>  	struct hstate *h;
>> -	unsigned long demote_size;
>>  	int nid;
>>  
>>  	h = kobj_to_hstate(kobj, &nid);
>> -	demote_size = h->demote_order;
>>  
>>  	return sysfs_emit(buf, "%lukB\n",
>>  			(unsigned long)(PAGE_SIZE << h->demote_order) / SZ_1K);
> 
> I'd suggest this function would look better written as:
> 
> 	int nid;
> 	struct hstate *h = kobj_to_hstate(kobj, &nid);
> 	unsigned long demote_size = (PAGE_SIZE << h->demote_order) / SZ_1K;
> 
> 	return sysfs_emit(buf, "%lukB\n", demote_size);
> 

Thank you Nghia Le for spotting this, and thank you Matthew for the
suggestion.

This is still just in Andrew's tree and subject to modification before
the next merge window.  I am still expecting additional comments on the
series.

If another version of the series is needed, I will include Matthew's
suggestion.   If not, I will ask Andrew how he would prefer to fold in
the changes.
-- 
Mike Kravetz
