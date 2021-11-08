Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E177D449C88
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 20:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237538AbhKHTgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 14:36:55 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:17338 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230136AbhKHTgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 14:36:53 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A8JCxiZ003356;
        Mon, 8 Nov 2021 19:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ftthP2uYO3WeC9jVfSO5GkVVQ/IQVhcbuIbPy0jPwCk=;
 b=S/ekqFWgJP3NYre+izuHFZjwpYRrwanuNjCRStCFyIoQ7OQjzP+7QJAfL7rZUmbmKjrp
 Ui8krz5eTKo9+GnUXWmmOqRoPbdShwFhEVxBzQ2jYGaQJOHH0YMo0fPOzBQKyEuUJr8X
 zqipjDP1e8vwSS2ZaBomn4tnXJuDSmfdzSNDjy11kYZvX5ow3+YZ+IFyFs5y1Axez9DQ
 y5iGkz7Ext4qRWy1Z9tXuj1EumbYYV0Wkl5n9tFGlZ3QLZ5kAs0wqywU3W1BMmK+bKYU
 gM3TsUQFpVoCbZq+rAo2ihsFHZMlJ6jo6ITDtSOykphsho3KER6UXuKnLC/6FNx2D5yu wg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6uh4djue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Nov 2021 19:33:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A8JFLnS076512;
        Mon, 8 Nov 2021 19:33:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by userp3030.oracle.com with ESMTP id 3c5etug41j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Nov 2021 19:33:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ytvc5McKWORBLuDNu0agfoZzm70/C+HhOdY23yGct+LixV69sMvZ5eGXxB3+XiK53UFQ1hA2WJeIbpt16dv9YysGtIYeZP6ksiqfgpflFunG8NpwQkUSvhmhBZnfaWVOS2ZMbY4Kflzi31uVBAHE8QE5oaM+w1HJcBrgoNWXZQ6pJWiqrLCZ4nlYJ3/rB3DKIvUZhanhGvFZ8xNJ60SANcQQUXjCUKciwxUAKl9VpBPw5x4qAnNvn0yFoOYUpGM/mIFRJYloPA4h9phT4iDEer/8n2VN2uo1QUw2O77XrcrF5lUDIisC1ZVEKEBQs0J3IltdA78hvdTEiQ9AFLdKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftthP2uYO3WeC9jVfSO5GkVVQ/IQVhcbuIbPy0jPwCk=;
 b=TKIthtUT3tciZyYzagpAPJKXMDEWkLGJwcluy1zmUq6EHUogBx4riWothlHzTFsjKCpiCfgI+xfwv2L6u1Bpsjc5MGqz7oKYcx8m/mdhOQK8Ky8uieOaMKvrhzIyMpaRVVZ50g6ND7yHr0gL4S/2y0uBDmB5QraZ1hbfJdRrpgnKelUPttLfKzzSCsx2WMATnZIQiZAHLzkk/9Up0/pw3opps1oncD/CFKB9xyIeP/Cb73FfhjPC5g7vMLGDTq8x7b4t7+hCZR9gAmCsCFeUoyp0YZAHaVTiGH0cMNtIke/86X0uKH8ldQv7aLIEHtyiLYftzDB//kvYTrdUGE/Uxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftthP2uYO3WeC9jVfSO5GkVVQ/IQVhcbuIbPy0jPwCk=;
 b=s1AI+FMRzX+Kt24aZz5TXLzoHpu4cDh6o9O/RMwrfJmllWP7DnZE1hDN2synmlzkFCzs4pbywgVjeVx8myKYJ0RCQJPKW9EnW1/x+DA9Ryw+kuXP+kuM4iyyn5OfeSMFApgb67Ik1AGnZQ0mbxe1BS6ruVTzYDzVzE+PUXlSCzU=
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2950.namprd10.prod.outlook.com (2603:10b6:a03:8b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Mon, 8 Nov
 2021 19:33:14 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7%7]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 19:33:14 +0000
Subject: Re: [PATCH v7 0/5] Free the 2nd vmemmap page associated with each
 HugeTLB page
To:     Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, Muchun Song <smuchun@gmail.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Barry Song <21cnbao@gmail.com>,
        Chen Huang <chenhuang5@huawei.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>
References: <20211101031651.75851-1-songmuchun@bytedance.com>
 <CAMZfGtUeL45=WG3ceaZ_tALMGZTLtuD9jbfKEzeQv270OnaLYQ@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <35c5217d-eb8f-6f70-544a-a3e8bd009a46@oracle.com>
Date:   Mon, 8 Nov 2021 11:33:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAMZfGtUeL45=WG3ceaZ_tALMGZTLtuD9jbfKEzeQv270OnaLYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR14CA0054.namprd14.prod.outlook.com
 (2603:10b6:300:81::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.168.181] (50.38.35.18) by MWHPR14CA0054.namprd14.prod.outlook.com (2603:10b6:300:81::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Mon, 8 Nov 2021 19:33:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d135204f-df65-4bae-9a55-08d9a2ee9b62
X-MS-TrafficTypeDiagnostic: BYAPR10MB2950:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2950976DF7C3D9B866386ABDE2919@BYAPR10MB2950.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jb+R/RFo3vgFC/NySveW0uutnc8Jjk3BwZtjmx007IO/syBM9CoAgzclCSfzKeSpjZCU9itLxVZ8DTvvJ1uUy5MR67jCMdUYu0d5S1D2XWN9XUGaoDyAg22oj61DsLeLagwt3x1m55vbcUlvm2f7ckY6Db9+hte6AsbOW2Ttytg6ev4OGHzBMDg3o1OtDno4qRFlDCK1ekyE9XjWd0HVWz/BuKFOgRxHzbjZXeBZ+gFXP5xojy+nwS1YOLwJbjpM2OzJFM0czhOu5I66PYQousI35td1gpTQC9JP07za0oe44XAZsgrEA6GfiJXRhU0m6osQQR3UrFLVpeo1tn2LGQr+bWRuPEo9+e0Ce10EubcciykDfvVFBNqWOtZxFkbTO03T24q3TnySyam9CwXz7pv4W2h0HgYnBbXR2AGP5uu2uA8K63CVSiGYBeXZCITh5leyHSEsRBvNjBcN/geS0quuylL1l5nHcn/q5CwYaGebdaxxorkxlbNC2iNP9w8WXFPzOk8ZHCO6D4f3lTrIPcVyetXdz4NwsalgbtTeTuQkDb1/CVJAB/w3hvsFN7ZvWoxdeTzDzBbw1z2qdwkvia0D7nioyyu9lJtWn/iwHdxTt5289G9zNrQfTBESi1j9qUUaLnVUtI0eSbAVWAqrdVpIMq38qiIe/HaebP2r4DY0dfSMPGBILwmBghkeUjxOGnxbGtrVF3QGcmLHgrFiDeuV+lVb39etkBRpjHHbqMml+2nVGCtu0rS55wZV/CHuaYPOUOR6hbYVv4dg+ZXjeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(86362001)(54906003)(4744005)(52116002)(110136005)(53546011)(8936002)(186003)(31696002)(83380400001)(508600001)(66476007)(8676002)(66556008)(6486002)(31686004)(7416002)(956004)(36756003)(2616005)(44832011)(5660300002)(316002)(38350700002)(4326008)(6666004)(16576012)(2906002)(38100700002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REpxKzNialBkb1pqMWNVb2c2OFNzQTJYOWsvUTROQ2h0T2laTkp6U0dYdUlT?=
 =?utf-8?B?VTdnOS9saUFwak53ZWZiQVBOckQyYmpua0VjMDJvT1liWFNxRHNPUFc1V1hp?=
 =?utf-8?B?OWw2Sm54UlUxMFBoVEZXRlpNaVR4NlhEVWRoQmZWc3RjWDBub2toN25rb0tR?=
 =?utf-8?B?T0hIbGdndm4rZUNNaUk1eWpaNDJjR0FISVdZRlJjKzBQamlnSFlITEg4dHlJ?=
 =?utf-8?B?YkU5b09zTnhrL2R0dUhjd0pDRW1xRmRrVS9UT0N6OUsvcENzN09ja0xmT3ls?=
 =?utf-8?B?aFpaZEY2dmZ3VGZpTUpqOFhNSUtIaWxpV1A2UElOMXNnRzlSYkpJVlk2bkYr?=
 =?utf-8?B?dmttQWowR2J4bklLQUxIYXVJZE9NWWowRWVjcDBVZmVXcjAzdEZuZjZrQ1hk?=
 =?utf-8?B?Wkc1Z3JXUmZ2N2l5QUk4MGpKbXV6TlBod0F2TG1wdkVrOVRCcVhUcFEzSFFD?=
 =?utf-8?B?L0NiUmNwL0JLTUR6REtOYjhsM3F3S0tIcWNYMHNXaFlZUk9HYks1TjBES2RG?=
 =?utf-8?B?OHYwMW9XcGRaQ1BJRSt4UTVKYTl2Z1BxQ1VqbUJZNmtaVXRXSjh1ZzdUY0ZT?=
 =?utf-8?B?cXh4Q1Q0SE5WUnNnVUxPUXdKcSs3WDdZcktaUWNGbWZQUVR1RWY5b01WVXBG?=
 =?utf-8?B?bHZsb1lYMlNxZGFhWm1zWW5aa3MvdC94RjZZVmJlcjlpY0dqbUR6MmcwQks1?=
 =?utf-8?B?cnRYVm1wTXR5Qmo4ejVwV0ExbWYwa3k4WjVxaFBQYXpwU1poWGxDT3RXQ3hE?=
 =?utf-8?B?QW9EbWFVVXZ3R3JZMktoSE1SU1ROTHh3blEwSkRLd2RkYTJQMGhQUlArdmk4?=
 =?utf-8?B?b1pqMEpPbXNSNEFWWDJXMFB5YUtRbWJPa0dxSEpTVlBnRVIvUnFZckNvZytm?=
 =?utf-8?B?WjhlSFdtUXhOS0E1MjN3OVNhdzdQVzBKWmVEdTVhM1p4RGVOV1o1SzQzZkgy?=
 =?utf-8?B?T1Vkc0NrbEQ3R3lEOXZUTElndTFQM0xNZU95bjN6Syt2QlZDS3h3WnRGM1ZU?=
 =?utf-8?B?SGJRZ1BmOEdxS2VvcW5zVGlCU0tFcXRCQnliQVF4ZGhXL1ZMRWovL2xuZFVa?=
 =?utf-8?B?b3h1U2s3dU0vMmh6QmFIT0hqSS9KQWpYSis0a0cvaUdST3hFVlozcUJxWjNh?=
 =?utf-8?B?QjV2cDQzRVJmSEFmdFBvc3RCb3pnOXJOZFJ5UXpVQU1CM3J5WkhuNkNxbjVY?=
 =?utf-8?B?OVorNnIraDJOb21xVFFkQk51SGN4RGVRcEV5VjdBd25iK1U4SXI1UzFYQlVH?=
 =?utf-8?B?NmJCQnNoY05COFgxcWV1Tmk1cHZpZmlpZVJpRTlnanRVcmo2STdaSTA2YkFr?=
 =?utf-8?B?LzI2UGN6WDBMM05rZWlUbkJzMzl1THYrUHllblJNNi9FbjZ2U3JRWVFhMmJv?=
 =?utf-8?B?b3l0S29FQnR1TytSeDg4eC93UWIxK1pYT2RML29scnpaeDdBR1JBcE5TbEdE?=
 =?utf-8?B?bytwaU5ROUk0clk3NUw0b3JTQVo0eFd5ZWI3Y0hUSjF5UDlXOXNFVWFxQ2JM?=
 =?utf-8?B?QlNadTZhaTFCYVhwSTdROFdRb2xOV3U3NFhKaVFUNzJXWnJ0TWx1MUZzRmZs?=
 =?utf-8?B?UHBoQ0pZeHYvRmdERUhRanRlc21xQ0NSUk83TnNRSUVwOGtuYkFpYXErSjVr?=
 =?utf-8?B?L2RBczhoUGF0bzJGR3kvTHNxc3ZUUENwK0xLZjUvaGJ6V0M0b1ZmcFp3QzRk?=
 =?utf-8?B?UjZLRHBiTGRFVEtFQXZidUJDYi9wNWp6b3ZPNmJVMFVwUTVyMHQyMUo2MHNO?=
 =?utf-8?B?eEw2ZzJOa0Z0bS91Q3BNdUNYMXFGUWhFcTc3Smk3NFdVWkljSkFFSHZSR1E4?=
 =?utf-8?B?eWpSQURRb08xSWVuMWN2K0YyN3RwKzgvYTg1cUNBY2ZBMC9iOVRHajBpMklS?=
 =?utf-8?B?L3gzUDVPRlBTTzh3czczNzBFbGlFeVBuZXRONVh2ZFdQcXcvZ0thNzBiOVRS?=
 =?utf-8?B?aFdWN3U5cENnbjV1bE5DcUgxRkdjdDFzREVSSGt0cGdWK3E5VW15U1c3UVJt?=
 =?utf-8?B?dVJhbEJEb3MvemlXdHF0Wk1hdkZzTXRWWHF1Q09oYWFMdmJjZzRhRmRiT2xu?=
 =?utf-8?B?MEx6UHhjVmZINGJBT3pHeUhWRlIrRVE0bHo5YXFCSndRTndiYnQ4RWpXQWho?=
 =?utf-8?B?V0RFRHVKcXlwQzlhNzlPQU4xTDJTL0N1Y0lUa3hsK01PQ1NITVJXekduZ0FI?=
 =?utf-8?Q?+RK+EzqHCDeXR0SLcmSkQ7w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d135204f-df65-4bae-9a55-08d9a2ee9b62
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 19:33:14.4284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCzEnOQHucmN4ORTqJdr1p7nw3eFAuJM8FVocjlT8yGLnjlIV3S5BQ8xwust9wylmvl0YcxwXPQpLMwNhl36Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2950
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10162 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111080114
X-Proofpoint-ORIG-GUID: fK0MeXbHlpBLTMURaFgwTgJCDx3x0Qi3
X-Proofpoint-GUID: fK0MeXbHlpBLTMURaFgwTgJCDx3x0Qi3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/21 12:16 AM, Muchun Song wrote:
> On Mon, Nov 1, 2021 at 11:22 AM Muchun Song <songmuchun@bytedance.com> wrote:
>>
>> This series can minimize the overhead of struct page for 2MB HugeTLB pages
>> significantly. It further reduces the overhead of struct page by 12.5% for
>> a 2MB HugeTLB compared to the previous approach, which means 2GB per 1TB
>> HugeTLB. It is a nice gain. Comments and reviews are welcome. Thanks.
>>
> 
> Hi,
> 
> Ping guys. Does anyone have any comments or suggestions
> on this series?
> 
> Thanks.
> 

I did look over the series earlier.  I have no issue with the hugetlb and
vmemmap modifications as they are enhancements to the existing
optimizations.  My primary concern is the (small) increased overhead
for the helpers as outlined in your cover letter.  Since these helpers
are not limited to hugetlb and used throughout the kernel, I would
really like to get comments from others with a better understanding of
the potential impact.

-- 
Mike Kravetz
