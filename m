Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E5E404062
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 23:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352047AbhIHVBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 17:01:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63360 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235437AbhIHVBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 17:01:47 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188Hxjmp001118;
        Wed, 8 Sep 2021 21:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1mwdpwEdvcb+Na3U+GIf0xxuV5yZ4QFLbPUs05tA6vI=;
 b=Qwca4EsP569JGW6OuzfqZ7jom3FfwbafR074ocf3lSy13c0T1X3FksKxOW3767187Zhh
 97XPOBDTMjKRWB91g2bxgdWKVZzKRcR3sYqtvziDbWfjagsm/HTiCM0DrU2uLf9M/Y61
 wizx1KrDWypYjal3ghDFUYO8On/rzoEkwHq8qbPi1VuQ4Qd5bnFRtAK7DexzIk4QRFOP
 ZMKrSYkn9NwLgv9Yk5cXU+YVueqvptGT7kZ5ftrn9Fx/dG+efRCrzwoLisHIO5kA+3cU
 wypjWgBAyIAjDAQ0KjfnfzOPbsk1+Y6LXxDtssXo0ceFK70jopjP2BHh+lvgbzZwcOk2 Yg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=1mwdpwEdvcb+Na3U+GIf0xxuV5yZ4QFLbPUs05tA6vI=;
 b=U7s4K33NSqbAk68y7DMz2bg5FkH5DbjW3qFIl8uhb2BOzSo+s7mlv09ZdYDzIjBCfLI4
 MJdo7ew0HrqaLyHNlxwvZeA+lnz7tp0V9MjUYFknTAnKNPahggiZNs5KkPIhZo84gMxW
 lB5Ih3QR11Ixjq0+Y5KIyFA7zlPY50RBhErDOVamN4SkjpGXR+Ie4JTzSKI43Fgz9yre
 GnfW1bGZZyRFMGKc/j/A2IZ4aptD5aiVpKr4FpR4IsQmN2fFpKHFkqVJhLC6m6Xk5Mgq
 JuCJL5o77sPHOe6vOpAhQPj1CfC5t3PlQINtMP2ygj95igWzquWSARDIMA4y/FG/FR4P Xw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcs1c1x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 21:00:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 188KorQW144588;
        Wed, 8 Sep 2021 21:00:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by userp3030.oracle.com with ESMTP id 3axcq1yamh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 21:00:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJLXG6VQ+diSHIezmLUVhI2IvEeiepyfQr18FupXj8RP6O1rU1QVyJWDDgHdxsRUNUkSgunpv2/nrvXYHmxheockGXZ+vHULKPXPWjUYDFmo6IxKhyf4uFZMn7OeTFZ7gTJYVJYINWISCi6vka5tlYdXAvFBj4T764ZtpC5PG4ZvxE7AlGUSiuulHeP27X/qXuxWxz+Yob/PelTIq9jZSYiX91ll2bp/hCRKNg6D/k3wx4KwxZyvQztMU3X6/pzWMDhVWzXSsyVAhn/6N1AQJt6x1rJqQhVVk6ON3TK6dDCFm5vH7CMqHK/B1vW+D7I7XIB1BnDPuJkSVa0XDvEzzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=1mwdpwEdvcb+Na3U+GIf0xxuV5yZ4QFLbPUs05tA6vI=;
 b=HYb9nXS17qojWPnJRR/DEIc6QCDTdwauvWCmBHMxRy1yzHxnxenljTeevEzFI2Xo5Vm8V7bje1HZtZcFHU2O/5H/ITgk8K2lUTCi/K0VnuMzTTvUSenSAal7xvxbYKTQ+YXKonHHKCkX7SNL+S0xMccTPllphMByH08Hz82Bjo5jJ/7FgfhtNsyoJEayU1CsYSeQ5tkobmaysKaADXOTeW09mYHbhFJlZ8LBQ45+eDJ9wCpr4k/Mu/QWFUdhWijA0HIqlfyzphX+5MgA86YgND86A5aSiZk1jRl4fIF0w+ptIkPGzJ6GtCGb1Uq9uPct3qkEjeqAQSvwrpcj81MZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mwdpwEdvcb+Na3U+GIf0xxuV5yZ4QFLbPUs05tA6vI=;
 b=RjW3MtRbcfbN0XizfySbF1h5QPuaM0P4BGEnCYWVvx6jbwJ1PKmnIXYGfGjlYC3qyiAUWtCzD/elD7eDx6WszEXRRzzE3mXpjRxJR4vEr0iyYu21zqb9g2nICL4FiDFADfXhlP5j53c+vZRgwTFZ8GtKn5i25tOLeLDg0YAJ3YA=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4068.namprd10.prod.outlook.com (2603:10b6:a03:1b2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 21:00:21 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b%9]) with mapi id 15.20.4500.016; Wed, 8 Sep 2021
 21:00:21 +0000
Subject: Re: [PATCH RESEND 0/8] hugetlb: add demote/split page functionality
To:     Hillf Danton <hdanton@sina.com>, Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
 <20210816162749.22b921a61156a091f3e1d14d@linux-foundation.org>
 <b4401912-b59a-2150-feef-468c2d25ba3e@oracle.com>
 <20210816184611.07b97f4c26b83090f5d48fab@linux-foundation.org>
 <10d86c18-f0cf-395f-4209-17ac71b9fc03@oracle.com>
 <efcf6049-6110-d516-b21f-41bb8775f042@suse.cz>
 <2d826470-d345-0196-1359-b79ed08dfc66@oracle.com>
 <b3b334ea-0e6f-ced9-e444-df4ec49455a0@suse.cz>
 <02a1a50f-4e7c-4eb7-519c-35b26ec2c6af@oracle.com>
 <20210907085001.3773-1-hdanton@sina.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <6c42bed7-d4dd-e5eb-5a74-24cf64bf52d3@oracle.com>
Date:   Wed, 8 Sep 2021 14:00:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210907085001.3773-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR18CA0026.namprd18.prod.outlook.com
 (2603:10b6:320:31::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR18CA0026.namprd18.prod.outlook.com (2603:10b6:320:31::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 21:00:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 254ee5c2-0079-47a0-6119-08d9730bab76
X-MS-TrafficTypeDiagnostic: BY5PR10MB4068:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4068EDF0944860DDB564F5C8E2D49@BY5PR10MB4068.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lXRMjFfNtmyzP8kzWG18l8ND9uXXf9sIHkb3L/lwJg7lcwbAq+nJNeAgt0wE07JrcTF7EoTP1oYgcFxHsrnCgg7Os6oK9WeGTpt6IwDYEAQzTEKZPtYbDFDxSaVNDu72x8YOWQtnMTp/QyXOgXmoun+7iYNwtx/BjKf9GuCNtxiqFp9Fb69CW2akdy0bBYzDDzSLZvPtaWjIi8ikXQLKeYRHlW/SkMQlJK3A+FCfZsqYVuy5sQFpU+qxPDVLzOJwIu5tnWAjXZWL7HhNbb+lWzqQdY+Ypfy5o2DPQ7bw8IiaxSllhtMZr5TUcq9CBphYgNIq6v0xbUGfNRA5Mnn2Co9f1JaFZH4HNUR+DlBbvd2fHLhqTAWyxwgOWlFgXjGw52mexkj0UpRLcS/YwZ7T5PsY+52iKL3jKqgc6zOuhMLPxfUsacR87T3NifjXcdCXALl5xbkk1aE+GpT7UD3eqZamBuz2lBvnvUcKfARoc3mXdRCRFVgVYwSWhODYjCfSyPBrByxvpI4iUNIGiVqdtL81pV+Y+Hr7y79GvvLMPqX+z7xKWw9kgrwkdht0iQ1rTw6pNYcoyBAR6X6mNuK92jqoxpiNXb+1CjIqi8OALDP2aaF7d/P9rgPbinkpzf4exCQCXL1Bm1uIJUkO0EBvv5Ofq4KlBa2WHu34aTvz5KptX+B3/Gv9uU0Ny5mt6DNYqaZnaso6rJ/PlDrR4DyCuXpXnjP8rwFT2PT6DHff4/V4XDnMV0AS0J/jhFn8DRIAasfuN42lCPX08xdCn1vHrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(396003)(366004)(376002)(2906002)(16576012)(316002)(66476007)(6486002)(44832011)(2616005)(8676002)(66556008)(66946007)(4326008)(31696002)(83380400001)(26005)(110136005)(36756003)(52116002)(186003)(53546011)(478600001)(86362001)(5660300002)(956004)(38100700002)(38350700002)(31686004)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjN3TGV3c2RaOXYwSWRpeVpNV3lyUHNtY0M0UHRsb1RCRW9RTVJVOENVK0pJ?=
 =?utf-8?B?R1dWVWtZYzZDeEd3bFNSeGRiekd5RVltbTVJazZHNjd1TXRiSDRQOStGZVZw?=
 =?utf-8?B?cm8ycXkxSUxlMWM4dGp5RUh4cVRSOUE0YkFYenRvREhCRUhmN1VvRVB0V2Yz?=
 =?utf-8?B?aUQvS2tVLzJ5Ly9WRC9XazgvMG12YTB2U1dLZ2dyY3g3SWptbkJuN0hmK1A1?=
 =?utf-8?B?eHJuMnI4czYwb09VR3ZDYU9BeDJweEZySUVnOHJmVDNWVEpiUVgwYTF1VU9M?=
 =?utf-8?B?akJvVi90NHNUUHlFdFZMOEtpbDJ0MGxtRWpPVy9TelJrUkM4T2w2UUVheFM3?=
 =?utf-8?B?S1h1c1l6d1dVd3JqbjQ0R2F1emJmV0pPekkxdXhrLzhrUkMxOERmaWNEbzlT?=
 =?utf-8?B?Z0FJL3Ardnh3azY3OXJ5TUUwSzkvTm1RUVd5TjhnUnBySnVwM3dDVWxPMDlK?=
 =?utf-8?B?ZUtjTWhRRGZRTm15aG1iVHBheG9Ccy91QlhaQXBZM0RtUXhyWWVlRjlSVWhs?=
 =?utf-8?B?Qmk4bzYrSnVpZHlQQ2k5UHVFRmxoZElPbDkySUxGa3ZlMC9KR0xXL1lERFhT?=
 =?utf-8?B?cUJ0QmdhekNPUU10OC9acENGbXZaNDNSRnBYUTVQZFJ1eGs2aWJ3UE1MdFNO?=
 =?utf-8?B?Z1hQbCtVYnJKM0FGb0FEZHBzd3MzaTVWYmhaeUErM3JBL210a0pBbG1lSU90?=
 =?utf-8?B?ZERGRjZRL2l2UGM4SHkrUjM4L3MweXc2RUl6QXJSV09LdFR4SHRsRVB3N0pU?=
 =?utf-8?B?dEhLenZ1Q1RtU3RZbWkyTDFkMGVQWFkwZ3dTdHl5cEQzenl2QThxaXZUSHdp?=
 =?utf-8?B?d28zNXdvekhaUE1scGRQNTVBNzFLUTBYT2NSQ25RUndnTDZJeXNBbkdycUZK?=
 =?utf-8?B?bkJ0bVFyaTFhUEdQQTJMSk1Qb1pLSHdkemJ6ZUwrR29rQTlSOWRScWpkRzdJ?=
 =?utf-8?B?ZUJlNmNNNU5TelFhNDhQbTdoUjBzLzBsb1BSRy81RlpzTVFtVkJpS042VHJJ?=
 =?utf-8?B?NlpDd080TDhSL29uZkQwVG4rcnQvNTl2Y2E1YXU1VmVMa1R5WjRldHltcmpN?=
 =?utf-8?B?SUYrVERjeUpDTVVIMmJ2cEQwa0xsY3RDY09TWmhvVXNVMnZvMHlpNmZkdTBM?=
 =?utf-8?B?QS9xNEM4THJhMVpZMkJLT0JsZUk2eFAvM0ZqVm9ZUU5MRFBxYjBIRzQ5ZjVH?=
 =?utf-8?B?a3dadVdWM2VaUWxUODJnMGtLUWtUOGVHcHNXeG4ya0p6RDRidlplaXdxTHRx?=
 =?utf-8?B?aFQ1L3VWeGx3V0Ewa0RtZmxoM0VxZHZWTXcwNnFZUVFGSFdBWFhybWhXVC9m?=
 =?utf-8?B?dHUzOGFlZGJwemNUSmJ1TGhzQmtHSUljVDFwem04NGhQUDRuSTZvV0JKSU9x?=
 =?utf-8?B?RmZzM2wzeTBGTDR3K3F2bytUakJjZTNCQUZ4Qi9WaTRnNnpmZ0svZnVmQUNV?=
 =?utf-8?B?MWVGUnNmOVREc1B2S1BWY2svcUZhYXc1WkdmK3R0WlJ6T1NqK0JvVXBoUjJM?=
 =?utf-8?B?WnpFbjdvY09jT2E4RU1QdlBCczhYcC8xS3lMb2FYcmliMC9aR3BJZmE4a1Fv?=
 =?utf-8?B?WWMwM2E5VE9UajgydzhvSzNvd1VvSDRpTktRcWZQRlorV1FWUGZ6QUdhT2xp?=
 =?utf-8?B?NXgxMXljREFnMWw5QnBoRlA3MEZYQ1k4WmV5VHRCL0NsSHY4c2N5ZnZHZjJ4?=
 =?utf-8?B?eVdvZnN1QUVVVUNVTjE1anAzNFlVVmw1UUFKdVo2L1MrWDJ2SEVLMDlDazBC?=
 =?utf-8?Q?GtxZT51bP2pc+HJ7E/J3nMXqGWmlCIeFN3OlHiw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 254ee5c2-0079-47a0-6119-08d9730bab76
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 21:00:21.2274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDBjpQum9GdcQNkIV0Us8Y75Ev8Q8+wzv+D5mhfdjeXy+jyGX8qUvN9+GxGc+2ecay6xAZLlwW6p5Ce/+qRehw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4068
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080131
X-Proofpoint-ORIG-GUID: obGPR51sllxry9rcR0QfYEz_NOYXs7sQ
X-Proofpoint-GUID: obGPR51sllxry9rcR0QfYEz_NOYXs7sQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/21 1:50 AM, Hillf Danton wrote:
> On Mon, 6 Sep 2021 16:40:28 +0200 Vlastimil Babka wrote:
>> On 9/2/21 20:17, Mike Kravetz wrote:
>>>
>>> Here is some very high level information from a long stall that was
>>> interrupted.  This was an order 9 allocation from alloc_buddy_huge_page().
>>>
>>> 55269.530564] __alloc_pages_slowpath: jiffies 47329325 tries 609673 cpu_tries 1   node 0 FAIL
>>> [55269.539893]     r_tries 25       c_tries 609647   reclaim 47325161 compact 607     
>>>
>>> Yes, in __alloc_pages_slowpath for 47329325 jiffies before being interrupted.
>>> should_reclaim_retry returned true 25 times and should_compact_retry returned
>>> true 609647 times.
>>> Almost all time (47325161 jiffies) spent in __alloc_pages_direct_reclaim, and
>>> 607 jiffies spent in __alloc_pages_direct_compact.
>>>
>>> Looks like both
>>> reclaim retries > MAX_RECLAIM_RETRIES
>>> and
>>> compaction retries > MAX_COMPACT_RETRIES
>>>
>> Yeah AFAICS that's only possible with the scenario I suspected. I guess
>> we should put a limit on compact retries (maybe some multiple of
>> MAX_COMPACT_RETRIES) even if it thinks that reclaim could help, while
>> clearly it doesn't (i.e. because somebody else is stealing the page like
>> in your test case).
> 
> And/or clamp reclaim retries for costly orders
> 
> 	reclaim retries = MAX_RECLAIM_RETRIES - order;
> 
> to pull down the chance for stall as low as possible.

Thanks, and sorry for not replying quickly.  I only get back to this as
time allows.

We could clamp the number of compaction and reclaim retries in
__alloc_pages_slowpath as suggested.  However, I noticed that a single
reclaim call could take a bunch of time.  As a result, I instrumented
shrink_node to see what might be happening.  Here is some information
from a long stall.  Note that I only dump stats when jiffies > 100000.

[ 8136.874706] shrink_node: 507654 total jiffies,  3557110 tries
[ 8136.881130]              130596341 reclaimed, 32 nr_to_reclaim
[ 8136.887643]              compaction_suitable results:
[ 8136.893276]     idx COMPACT_SKIPPED, 3557109
[ 8672.399839] shrink_node: 522076 total jiffies,  3466228 tries
[ 8672.406268]              124427720 reclaimed, 32 nr_to_reclaim
[ 8672.412782]              compaction_suitable results:
[ 8672.418421]     idx COMPACT_SKIPPED, 3466227
[ 8908.099592] __alloc_pages_slowpath: jiffies 2939938  tries 17068 cpu_tries 1   node 0 success
[ 8908.109120]     r_tries 11       c_tries 17056    reclaim 2939865  compact 9

In this case, clamping the number of retries from should_compact_retry
and should_reclaim_retry could help.  Mostly because we will not be
calling back into the reclaim code?  Notice the long amount of time spent
in shrink_node.  The 'tries' in shrink_node come about from that:

	if (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
				    sc))
		goto again;

compaction_suitable results is the values returned from calls to
should_continue_reclaim -> compaction_suitable.

Trying to think if there might be an intelligent way to quit early.
-- 
Mike Kravetz
