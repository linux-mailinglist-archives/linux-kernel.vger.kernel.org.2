Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161723A3606
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 23:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhFJVf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 17:35:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35022 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhFJVf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 17:35:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15AKAHHM050785;
        Thu, 10 Jun 2021 21:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=7XSkcansVRu2FqtnyudsLFOc6U3yevkPZWtwAKgNacA=;
 b=wnLJ9OOcTqt8VtEZ05tki+6XnebjacaE3GnyDkh1SFpjrbF4Kh0MPGWt6dFWOpCdLdUv
 ttT/MNGHyHX7iJiVBxsbP6XsS+wSuzse67FJc3OR0eW+Ur/2uoliFPiy6KLaHEctOO7Q
 9A1l0g0H+z0Y2YqpqJoGEvrp96xm01SZFWlNatGI9fUjLbLzG2HnZ/b75TgCwndq0p1+
 Sl7fWsh4/z84mkg3wb3dYEszPRZyo9w/cX6SknG0scPjxOHa9LsXlmLmCnJZgEAkQA1h
 pUHvni17zhYR5l78ltWGCWKU9+d3I/kuj4McJPz/2yyWwe0NQhRib46kwAdgLzcE+Tvl TA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 3914quumv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 21:33:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15AKATcO068383;
        Thu, 10 Jun 2021 21:33:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by userp3030.oracle.com with ESMTP id 38yxcwxbmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 21:33:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KS8bOyctMs5fIKGdB5HhBpQyBhO0S8/45c5EdWAb/NjR+gErLsOCSMRiLcL5bAgK9PUJqVOSHLyFVe8JS/BlHJmi1R0jThq9O2vaJZ6IdUEzysCRsc1jPiThEkaVc36m+zdS0WmlU28knP21AqkdMKOK4zxj2+QSpxn/rKysEOc09RxFnPpwhrGMRvHGiXi+PWxYlZYYFUULe/uySVVtY29rZV6ViWXmkK1KS5DG8jrXxsDENiBFueqddQWuOqGiXtsrpg24lcyQDXvxTlRjt35kDEN4IoBC55l6k1kUUGfRe7rPdOtMPQUO97xGmVBks+hwq3M/wAwEZRcj7lrujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XSkcansVRu2FqtnyudsLFOc6U3yevkPZWtwAKgNacA=;
 b=EmY0GFE/9Kslm7FFXYYLlSxVzpmu0d4Nmf5xmZiDlERot23/p8iY1z6vXIg7IklIaeFZ2Dh9mORejwigO26E87zLqVFNesC2r13NwxErABhM39ZWZb74AAyylmz8f9DJquXFwseZjf854SBkLatAz4k05eKSODtB0KjEFYJMAaYm8lQYXkTBDx57NnhLboqfmMMEGKWTPabnNzn884XTFFeM0pc88gSzo7vOfT5cUYoXhArVSHzj5S6FplzUqIG60SxhuEhW+PwWhJlNEQOQRg021R4SnXju3JwlsKTfMwR31S6LppMyxjgpQ17KYfLnRr8oWRAfAwrDL7KZlo6Odg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XSkcansVRu2FqtnyudsLFOc6U3yevkPZWtwAKgNacA=;
 b=Qrl9pPvaCPCupSUwb0gDjmsdl74w5mW3kj9gG8q9BlkgSIr1WtRyBhDysMI6bgcEvzD+jhhKnzSljxaxGYT2lduRcjBRtRwluFPUHbZz2YRG4DdvrGXZVb8I7ECkBOa54pEigZHR6At3mXLqOLzHnGGIvGlhzW2DyNFRvz/aBTE=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4590.namprd10.prod.outlook.com (2603:10b6:a03:2d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 10 Jun
 2021 21:33:00 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838%3]) with mapi id 15.20.4219.023; Thu, 10 Jun 2021
 21:33:00 +0000
Subject: Re: [PATCH 0/5] Split huge PMD mapping of vmemmap pages
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        zhengqi.arch@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210609121310.62229-1-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d4fa211e-e896-e1da-017e-dafd120d3583@oracle.com>
Date:   Thu, 10 Jun 2021 14:32:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210609121310.62229-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR18CA0060.namprd18.prod.outlook.com
 (2603:10b6:104:2::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR18CA0060.namprd18.prod.outlook.com (2603:10b6:104:2::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 21:32:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12b645ec-3759-4f69-6d12-08d92c57523b
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4590:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB45908A00C03864E697C85EDAE2359@SJ0PR10MB4590.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lb+ELX2bH+dWlnUj1Ql464+8yvPCCGCV5NFbGhriogZzjPQhNUe2LPyyabRqJYwMtDxNBfS+B6+6KGSxxOUefwwz/EoShBlvvfo1Utane3tIpAtqU3EEgUrVlF/xVEwkRqaCb0aDdNJMUUZYV921OUe2zw7bDTjFfKZVAzW0mI1lPZtpk+PPgbi3LA2DeJCaYAR5tnbtu5G7euTJ66KnzwLBDZQ/LIyjuGMmVhNOjegqIvjeVCIxWizpRkK4pPB6bhocrnG7NfRRuLxh0FjVdleWrOCcjRcdU8hU0jBqEhtBmD2w4/DVmoT/LDkCO2x/Lusb/+ZZnYoZtiz/BjyAlYGgt28KWEJTNxwwpEW/RjEA7Uknf/5bc2tO/f0etlmJrhXQBaKOqTwwe5Sw00CfKTE99yuIXILhA8WLhQ1d+ztHOBUDt7ri2OyoclI/Q0F0ulNgIxzlaNMpmS1f0BE3rFR0IYO3UR61BeBW+KCYrRIFmX1f+ULHBVUDQCKoEoGOVoK6FBAslTCsshtPWQHOTEBIMYpiGQrPa7hMhnzPVnaZr84PDfdpBK3k0VvC6R2ZqSA5IjZ6DGfAwQx+IiLigiBKS5KDOuF8eBe6Lp8/7enSf2lTEIVG81uFgtYwos5Fcc7Qz6ceFGGPdU6VZonK5C+2N/VE5AgUMTLGKj1mMh+SDmRUgKHU3hEROs5htaTNACKb/YfsjYqz9zCURjxgMgRnG4tnoCd0HXiztivE9225PsPbss5TuRBHMhmyf6vV6ZlKD9vTRlOpzgnrdAaP3t47Dcv8JFWWhX/f+8bNn6wq/ezTP0oYV5SAqgS2HpoHjAxRFNEfjjpqX5pEBsy5F4ZBRBd8mb3ZvOqXlaOuxaE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(39860400002)(346002)(136003)(2616005)(52116002)(4326008)(956004)(36756003)(5660300002)(26005)(316002)(186003)(53546011)(86362001)(2906002)(7416002)(8936002)(31686004)(16526019)(66946007)(31696002)(66476007)(38350700002)(44832011)(8676002)(6486002)(966005)(38100700002)(16576012)(66556008)(83380400001)(478600001)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXpjVHBEQTNKM0UwWUpvejdabWNYTXh6Zmg5UDlDM2dMa3o5TXdoU3dtb2ha?=
 =?utf-8?B?M0dXeG12UEp0bm5EQmYzUVFYTTMvL2w2c09LdzcwNndyQ2Z3SFVGM2xGVWxR?=
 =?utf-8?B?QmdCSTB0Nmk0bFJsMXM3TEdRTzRYWGFYbGQrZkxwSDhRQXBPWWYzak5sYVBx?=
 =?utf-8?B?dEtWMkwrdzJDaDc1M29xQzh1VlcvK2ZCNFgxWVNtVzMwRzhFNXVJZVdVZE4w?=
 =?utf-8?B?b1NhZmpwclRUQVZVR2lmYVhTcHdDMmEveHVHaG5FWlUyNDVIb2RJMVJuR3ZQ?=
 =?utf-8?B?YlAvTmxZNU5tZjVSNnNadENIUUFja0poeTZ5REdtZDQ4WVdRYk5VRHUrbXpk?=
 =?utf-8?B?bnpibzRqSTlvdjBwZXZIVGR3clJKVWpjZ3B3Tlc4ZHpWTEVxTFQySDdJZWxw?=
 =?utf-8?B?blBsd1c4MkZwenZCczg2UkFjZDQrUmx4VXVDdnhGcDRXUkFURzEvM28xUktB?=
 =?utf-8?B?aDNnZFdDQkxvSTRSc0p3aDUyZitLWjg3L0FQeTc2dVJ5K3BERXlXRGZMamtE?=
 =?utf-8?B?amVudnl0Y1VZdC8wNmZ1ZzF0c2JjRkVSU281QnVKaFhZZ084SFVaZzFYN1Nh?=
 =?utf-8?B?Z2h4UVMzWUw4TElJN2dzKzJSWFl1cTUweE5hS3Y3eGI1clFtZmdSa1gxUEsr?=
 =?utf-8?B?SDhkNmlieGJZTThReXVuVEE3b2JqL0Zxa1lIMS9sRHFPTUNuTE1aWnZBYUdI?=
 =?utf-8?B?NENBWmh4ZjJWdnFjSDh1UTMya2J4Tnc4ck9SOUk5Ukl2Z1FnWEFEU0ZsWFpz?=
 =?utf-8?B?ckRhZU5MYmFiK1YrekZZZG1RQkgzSEsxQ1B6TVVNT255RGh4S252M3Z6SWRt?=
 =?utf-8?B?STc3V1E4c1dJR05FSndDZldEcmJNdWRRWW9IMzRjSmdnUlhBV1RPTlQ4UXlU?=
 =?utf-8?B?cEpqNmZKZUlwRkJWaHlISFdiWU1xMndHYndTQVdCK0pmUDFycXZzNVF2NGdH?=
 =?utf-8?B?Y003bDhaZGYvSksxV05qdmZKVnBLdWovNk93cmlYSllqczk3UnpXcWE1RStU?=
 =?utf-8?B?aVovV1BYUU05MGhDWnArOXBobzAyWWN2R0lFQXM3allXeDlDRi9wMUd2SEdH?=
 =?utf-8?B?ZjIvU1paLzlXT2tFSEoyc1ZWN1k5QXpNK05adXdmU2dGUUJQUlJva1ZxOGdx?=
 =?utf-8?B?S053bXdGYXlJcU5wb1NrblBYMTRoZXR0YTVVak9xUFBpSXRSVXVlUWJWOUZ3?=
 =?utf-8?B?cWtBTitNaytiQklsWElvcDAwcFQ5L1V1R2FSdlFkL1RaTldlNnpqQ0VXTHJa?=
 =?utf-8?B?ZzFQTXFJTUxiTE9aZXhWWUxBSitkY2ROQXl6TytXeGpCNjROZnZqZjh1L3Jj?=
 =?utf-8?B?RUYyeEtpTk1DK3ZLUzRINUU4WDBHeFk1T0U0ZlhZT1BSVWc1VUVGRE1qV0JY?=
 =?utf-8?B?U1pzdW1xL3NkOXhTUXpndmNqNjBhNGl3eENET2hOdEc3Z2QzcUJ6MEdUUUEz?=
 =?utf-8?B?bTNUSDFhMmZaNHVrUVljTUFGc2RMUkJWSFBGbzllUVRIeFNLbnBkQjkxYlM4?=
 =?utf-8?B?SDRDK0hvL0ZNeGpoYnJLT2FXbWZaaUxSSzJGd3dsT1RQVFdJQnBKdXY1QXRw?=
 =?utf-8?B?WnFzRVBLeTc5RXF0WWJvbDZtWWQ3WjlBSUZNUmh3RDJsYkwrcmhRMmtFb2dr?=
 =?utf-8?B?RkdYeGpHRURlZE03SXJxRmVDRm0zeUphYU1EVFhuMVBQNzVMSVl4QmRzVzVz?=
 =?utf-8?B?UDBuYldxL2pxU09iOU1pRjlRc090NzBVS0JjZFhrWFpmYWtvZGEvbjJ0anh3?=
 =?utf-8?Q?mBwovtLQhpFnzAeuLsFZ1ahUeqlBYPpR3vJTjVL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b645ec-3759-4f69-6d12-08d92c57523b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 21:33:00.4532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2wUNlnQmWnKr4bTl6CapbOfQ2Kd96xBOWTnQ6A3dgxBy1EIv/VWhiuKOcJgyOOfOsDyxXwPTVRUFkchgA1Rbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4590
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106100130
X-Proofpoint-ORIG-GUID: fuYellopRqOCCsKJPH6yTPVjK3e59V-1
X-Proofpoint-GUID: fuYellopRqOCCsKJPH6yTPVjK3e59V-1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106100130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/21 5:13 AM, Muchun Song wrote:
> In order to reduce the difficulty of code review in series[1]. We disable
> huge PMD mapping of vmemmap pages when that feature is enabled. In this
> series, we do not disable huge PMD mapping of vmemmap pages anymore. We
> will split huge PMD mapping when needed.

Thank you Muchun!

Adding this functionality should reduce the decisions a sys admin needs
to make WRT vmemmap reduction for hugetlb pages.  There should be no
downside to enabling vmemmap reduction as moving from PMD to PTE mapping
happens 'on demand' as hugetlb pages are added to the pool.

I just want to clarify something for myself and possibly other
reviewers.   At hugetlb page allocation time, we move to PTE mappings.
When hugetlb pages are freed from the pool we do not attempt coalasce
and move back to a PMD mapping.  Correct?  I am not suggesting we do
this and I suspect it is much more complex.  Just want to make sure I
understand the functionality of this series.

BTW - Just before you sent this series I had worked up a version of
hugetlb page demote [2] with vmemmap optimizations.  That code will need
to be reworked.  However, if we never coalesce and move back to PMD
mappings it might make that effort easier.

[2] https://lore.kernel.org/linux-mm/20210309001855.142453-1-mike.kravetz@oracle.com/
-- 
Mike Kravetz
