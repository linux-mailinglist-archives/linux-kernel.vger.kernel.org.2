Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EBC407428
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 02:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbhIKAMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 20:12:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44364 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233946AbhIKAMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 20:12:38 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18ALkAH1023692;
        Sat, 11 Sep 2021 00:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=lY5iudD1w/cS4doRe4MVfLphV0TCwQuO6mjduBbTJ18=;
 b=HH/LuXDJ7uSg3+XzWgREWLMm4MoyhITL3qh0Y2oPX7THENiLJgYqYVoEtJzOxBHYuRZK
 Ol+ovriX/HMpv1B9to+rFC4WkVD7isFX32JaLLUBqio7UPM7x4qf8eL4g+3rxcrslIGz
 Unao9PlmFYrByDYWLTP+BtiVY47p+VcW8edvz90M+rSNbpkIaV0vBZpVAkXtMK5070xT
 CQRDMqp5RoLDX0Qnr0zXAhDXyaXuxH370qjuvyxlgSsI4s5PAdI1i55T+SeqmmZ/NZxm
 ECKInigMFbSI4c4SDkUBOAkkSP00ZkaUppVPPaeLTcAPgM4GlQ/fr8I+KmRfNU0nH9NR nQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lY5iudD1w/cS4doRe4MVfLphV0TCwQuO6mjduBbTJ18=;
 b=O85c2PQnkRK1L2wm2qFc4JIz3+XzpS6khaF7oNEFHD+3mYL3vCoQePaUBZ/iNGgpUSnL
 1aBq8OZo/nCkslsrvk1wCKmRdDaOnWjni/A6rZ4cAIZY6tkrS1Lt/viC0BHBUxkeZzMp
 F1PNPLSzPFerTA9C0KfpsChpQQo0t9vv1izLK5KqpozEJlRk91Y4ygrUWa5YpsBsj7PG
 rWuNfGaHlzyzSoIMce1KCOcFkg8e8y7XM+KXe/Li5SI0f17hKAVfKJIYfleSLtKgQB3E
 7tolUcQ7YmI3/PBauUEXlYa6HJM6yrbXI5Ihnt+5PQ/OeexzMewG2ZHVvvKvu7+eiusu PQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aytfkbbfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Sep 2021 00:11:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18B0AuUn159917;
        Sat, 11 Sep 2021 00:11:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3030.oracle.com with ESMTP id 3b0hjr85mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Sep 2021 00:11:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2oaO9Em/SIwbKfyXF0bwtzr2Amr3z1VP4qKSLJNBwANMEogp+6scd9PZMzFi5FfRQqVPUyQhKoZSwNhPTcyXjrmbJl6NC145Yog/TxDyPzhNNYiAFUSpojk+rCtF4Sl/X1+N8MjCT4btr1dSzD352hVBMQJo2+nB9E1x40grzUmAtvejeMEqhbAe2Ddzv27YX9bfJ9QMS/RyhUa3OwEDpCNfn3mUStOP4pFteReHqvCg437zoGiJm9hqc4xWBPdLwLxNamTjI5divnh+/WvHQBozY8maQUVg1sU+kLjqXIkvOJEiDplyOhy0oXWmq9Hzzyoa+ASqgI1RjRnsAif1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=lY5iudD1w/cS4doRe4MVfLphV0TCwQuO6mjduBbTJ18=;
 b=T2IZ3AiL8MuipD1IYF9YOo9PTgGck6dUDE2naPYzg5l8VX7qC44Z8eDPY4DU/PcbTVpwVom51bk7eAOFKdnOQls7r6lGtgX9Qa1VhFjlJ/axcdj9AuY8YZ64jcype4A53Gfq0SfDKYgMVJ4T5kkOSfDnvBAKBo4+iwht6PAy0ULliZTbQqCX47tn5mWXN1d6QAthBDXJoFP3CIcgNczgya/Uo5VwDgWNXGXeJEprYUbH0xNp/kVri5WXirabbWp1D8w8/UD1F/ULUl+2502ZUz01yBCmX4crIF/qTLbV3KNS71WPNMa9+kbU7o6hJbsjZFiy/1JvJ/xJx32oMsH26A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lY5iudD1w/cS4doRe4MVfLphV0TCwQuO6mjduBbTJ18=;
 b=t7zqCnU+hbP1rXrCx+Detm9y+VceCHWUos4mEIowSD3LE41Acosu5hee7e8jXRQMBdlYtm81KdB/SLjk2cM1nksKrQh4DsgGRpeLxkKh5a+tlFInzic778QYmF2aZDb5vaqvMwOx8DerCrHCl1WMajk7RmEmhTAN/aoCOna4fho=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2950.namprd10.prod.outlook.com (2603:10b6:a03:8b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Sat, 11 Sep
 2021 00:11:09 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b%9]) with mapi id 15.20.4500.017; Sat, 11 Sep 2021
 00:11:09 +0000
Subject: Re: [PATCH RESEND 0/8] hugetlb: add demote/split page functionality
To:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>
Cc:     Hillf Danton <hdanton@sina.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210816184611.07b97f4c26b83090f5d48fab@linux-foundation.org>
 <10d86c18-f0cf-395f-4209-17ac71b9fc03@oracle.com>
 <efcf6049-6110-d516-b21f-41bb8775f042@suse.cz>
 <2d826470-d345-0196-1359-b79ed08dfc66@oracle.com>
 <b3b334ea-0e6f-ced9-e444-df4ec49455a0@suse.cz>
 <02a1a50f-4e7c-4eb7-519c-35b26ec2c6af@oracle.com>
 <20210907085001.3773-1-hdanton@sina.com>
 <6c42bed7-d4dd-e5eb-5a74-24cf64bf52d3@oracle.com>
 <YTn196em42sDsXs+@dhcp22.suse.cz>
 <71f855ac-ff61-1eed-454f-909c0e4210b2@suse.cz>
 <YTsVT74kAgpAD17s@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2519e0f8-98ee-6bad-3895-ac733635e5b0@oracle.com>
Date:   Fri, 10 Sep 2021 17:11:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YTsVT74kAgpAD17s@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:300:16::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR13CA0012.namprd13.prod.outlook.com (2603:10b6:300:16::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend Transport; Sat, 11 Sep 2021 00:11:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edcae18d-282a-4500-0a52-08d974b8a7bd
X-MS-TrafficTypeDiagnostic: BYAPR10MB2950:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2950A5645AE62D09F4A514A5E2D79@BYAPR10MB2950.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WhPQ4lqC6ckCi+zdBinqpOIbXf8sgO1kpNwNMCo7gOs/r4zcy9ONaJLwOjMSCy+sQqt/BKiO1ogTFcadXzirB5BFTCdAD73/AyY6P+8PbF4ycuF9eDwKBq+h8TXB+SuNxSiPxSgvF53K2YiJwUd+IMcrc0QZ+KiusoFWvppeQHfI2h4wqUgHbUX3+fMXG5Fb5bN6g1pvOyvQPVFH4M6BuafMxRPxYNXrtk6EIEuWTjxPCUs/HJtmgeqXe+F/KBQTRdfm610/0RKu5H08E8VHscUL1W3eBu+kXcv6vtr56LkmUo7wxW67zjWZF1npWg1pp9uG3LgvpAoGqDVkZwSdKKF7GHwyBH2qJnOqtumqxe4v8Gv2coJZCssCVU819DsW5tW3DeyQAr8SIG0N/ynz6chU1az2MgQAcAbSBApRaTeNsHCqJRfj+/ksnt7kNBfQ1RKefoJTQIbCixPFqIPPAdDu8VkZ/70Yu4tt4H/LCnmR25cej9bPS+xfbWOAP7brF7nQdqGPVZ+R6H4gP7C9nOGOAb7mGhMV2dcgy65lxDo9tu5+uLEK8ql3+pznxDVFCGgIKjoEYvWH9zX5EdXK4huqBo8lOGaiUIjDygKOluQZIZxEFH6bSSJdGSd4sTC0IVvDut5DVjfQJaJ0n2gnEiuMk3F1AK4RpwO5JnJTIwM5S0BrvwFHq5pgk46OZK0k+rfvtPaxanU4H/VDSrb+EHUK5wAVsTafe+D4yhU8yzwARC6XgeoGlLAcxkINdx3mqEf34hUce7kEROHq7yrTjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(366004)(39860400002)(2616005)(2906002)(5660300002)(31696002)(110136005)(36756003)(956004)(66476007)(26005)(478600001)(4326008)(8936002)(6486002)(86362001)(31686004)(53546011)(186003)(44832011)(6666004)(66946007)(38100700002)(38350700002)(8676002)(66556008)(16576012)(316002)(52116002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2RwRkoyU2EwTEVhTi85WWtHOWJIQUxzbDZjOWQrdldSVi9uSk1EVVJEejlL?=
 =?utf-8?B?aGhwRVZkRW9pK2pHUDZ6VGFqTXBuR1N1R0pqWEgxQWFPK1VaRjF3cTlHMEhr?=
 =?utf-8?B?RkFjQXcwa0N4dW50eFNONjdnbERseGY1M1pHallrWFZRSW5sdVZOc2F5QnpU?=
 =?utf-8?B?MlRtY1JLaUxlSTdtOUxCYnUwcldQdGdBVlhUU1JYWmJ3Z042WUVLUUk0cEc2?=
 =?utf-8?B?czRucGswbTgyRXZ3VXNIS1lZK1hBSVVySEhGMm1HdzVnaDlQeDBzQ1k5WnNF?=
 =?utf-8?B?MldrZ3NFdm5MYWVtNS9JUS9vQTVBRDZIQlFYS0dQNHE1QlRZRUFsMkdtcXJj?=
 =?utf-8?B?WVZqZ1ZPbzNHTXBGTUtJT09CdTlpa0ZXRUxxMUZWT3BNK3pJcHlXOGFocURM?=
 =?utf-8?B?WG9sdHVFM0EwdjZneFhZQjVDeFZtMTFxaHFPcjJFUDZmS2xZaXp6ZklLV1dk?=
 =?utf-8?B?eEJtck5TMFFZSkM4RWJJMDB6T01YaHdMM0ZVUVAzdlNwQXlpaS9XRkQ4VlF1?=
 =?utf-8?B?SFhFVXo4ZnU5MERwZUJCL3htdjUvTXpmMUltNmhpUVBTRmJDMEI5clZwMDMr?=
 =?utf-8?B?MUdYRVJVNlIyeHdRMGFYNmFQTnkrazRTOWtXWUdMQ0I2VUYzMjJSUHNhUjcy?=
 =?utf-8?B?eE80NkhmQk01NmQzQ3NOeVlNbjVXR0tLRTFvQWV5S3ZhOThqd0NNZHpwam1R?=
 =?utf-8?B?Y1lKSWM4K2tUSmcyZVFvelNKakViR3FBaDl6NFB0T3lZUTFBdklkVG1yaSt5?=
 =?utf-8?B?ajMvNkFxdjI1N0pQaTBrYTJqZUhyT2pqalR3RDhBYStYK1QvRmVzYlZaZmlw?=
 =?utf-8?B?b2JhTURwWHpHT0FvemxaNU5abnZwRGphVSswWVFMdDFQWjN1ZGp5czg0MHhp?=
 =?utf-8?B?WnVNYTlyTGM3OHAzajRJN1owcGswY0ttTmNXK0dnYS9UdXBYQjREeXZPWkxZ?=
 =?utf-8?B?Nzl3MzRlak1ZdkZXMy9PM0I1NmtPZE1vZnhlcU9PTFgyN2VBZUVnYU56Ti9Y?=
 =?utf-8?B?MDVhcndFSEVwSnJEcGZiZVRDM2VLOEN1VFRnL05ITFkvc2duQzJ5S2NJUWps?=
 =?utf-8?B?WlE3aytjOXpscXUyRzBjMmhSdnp6cXJhblF4b3Q4dkdQbHUwQ0pYL1pudDBx?=
 =?utf-8?B?eDF4dVloM1F1eTBVUkZwbkdpQTcyYlY0aldhajhFY2xKZ1crbnQ1Y2gyanJW?=
 =?utf-8?B?MklLYTFLaWYvSk02OG9IeG5seFdNb3ZmTEc0Vk1oaFQ5S3VockFJbDYvOGR1?=
 =?utf-8?B?dWhvK29lQ0k5b3JoM2xsS09XZWJMZDl1Rm9heEZUd3BuT0d3TVZFaDB3M3Ar?=
 =?utf-8?B?UDJBNXlYdkx0T28vTmlGdGtpb1RHYzNyQzd3M20rbmQyS1NmcysrTFBkMk9I?=
 =?utf-8?B?R3lmWmI3dDY1a3ZEQ1FTeWJDWk1tTzBrU2RBSExIaTFwUnJlNDN3djVIcFVm?=
 =?utf-8?B?ODNnNlBQYVBJRURCd3BNbElaVHhWUko0VDd0TkRhMjhDaWpSekhSZVZFWlZ5?=
 =?utf-8?B?RGNnMVhjemt6STM2aFh6bWR5ZlN6aHJkaUQ3WXRWOUxuSjRYRzBFeWlDSGFQ?=
 =?utf-8?B?NUZtVUNadW80WXJvWGs3SVphb3VMRW9UeC92d1R5VGFxMU4yMHoyM0thU1h3?=
 =?utf-8?B?M20wU0QrYjl2UEdyUnpuS25aY2hxdGtBVkV3TzQxazk1QTNvbisxQXpsclg2?=
 =?utf-8?B?Y00rM3NGT3FyNXlodlhUUi8zUGtpN1NLamRzc3hLcmxselRhR2FJbnAxSXht?=
 =?utf-8?Q?y/5YzDuzmmrvDQNINEvsausi3ZlW5ZVrCnGNsE9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edcae18d-282a-4500-0a52-08d974b8a7bd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2021 00:11:08.8824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRAwMR7peg7k4d4H+7oDnie42IETKxcKnZa4SDpaXXp2TVs1sw4c/Cm4vp8uYnDFB3sKUqaxJFUtRbT2gzEpHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2950
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10103 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109100132
X-Proofpoint-GUID: FtA3wMYbvdRbYwMKRRjvXjmvgFmOmcXq
X-Proofpoint-ORIG-GUID: FtA3wMYbvdRbYwMKRRjvXjmvgFmOmcXq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/21 1:20 AM, Michal Hocko wrote:
> On Thu 09-09-21 15:45:45, Vlastimil Babka wrote:
>>
>> I would say it's simply should_continue_reclaim() behaving similarly to
>> should_compact_retry(). We'll get compaction_suitable() returning
>> COMPACT_SKIPPED because the reclaimed pages have been immediately stolen,
>> and compaction indicates there's not enough base pages to begin with to form
>> a high-order pages. Since the stolen pages will appear on inactive lru, it
>> seems to be worth continuing reclaim to make enough free base pages for
>> compaction to no longer be skipped, because "inactive_lru_pages >
>> pages_for_compaction" is true.
>>
>> So, both should_continue_reclaim() and should_compact_retry() are unable to
>> recognize that reclaimed pages are being stolen and limit the retries in
>> that case. The scenario seems to be uncommon, otherwise we'd be getting more
>> reports of that.
> 
> Thanks this sounds like a viable explanation. For some reason I have
> thought that a single reclaim round can take that much time but reading
> again it seems like a cumulative thing.
> 
> I do agree that we should consider the above scenario when bailing out.
> It is simply unreasonable to reclaim so much memory without any forward
> progress.

A very simple patch to bail early eliminated the LONG stalls and
decreased the time of a bulk allocation request.

Recall, the use case is converting 1G huge pages to the corresponding
amount of 2MB huge pages.  I have been told that 50GB is not an uncommon
amount of pages to 'convert'.  So, test case is free 50GB hugetlb pages
followed by allocate 25600 2MB hugetlb pages.  I have not done enough
runs to get anything statistically valid, but here are some ballpark
numbers.

Unmodified baseline:
-------------------
Unexpected number of 2MB pages after demote
   Expected 25600, have 19944

real    0m42.092s
user    0m0.008s
sys     0m41.467s

Retries capped by patch below:
------------------------------
Unexpected number of 2MB pages after demote
   Expected 25600, have 19395

real    0m12.951s
user    0m0.010s
sys     0m12.840s


The time of the operation is certainly better, but do note that we
allocated 549 fewer pages.  So, bailing early might cause some failures
if we continue trying.  It is all a tradeoff.  One of the reasons for
considering demote functionality is that the conversion would be done in
the hugetlb code without getting the page allocator, recalim,
compaction, etc involved.

> A more robust way to address this problem (which is not really new)
> would be to privatize reclaimed pages in the direct reclaim context and
> reuse them in the compaction so that it doesn't have to just
> pro-actively reclaim to keep watermarks good enough. A normal low order
> requests would benefit from that as well because the reclaim couldn't be
> stolen from them as well.

That does sound interesting.  Perhaps a longer term project.

> Another approach would be to detect the situation and treat reclaim
> success which immediatelly leads to compaction deferral due to
> watermarks as a failure.

I'll look into detecting and responding to this.

Simple limit retries patch:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index eeb3a9c..16f3055 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4896,6 +4896,7 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask)
 	int no_progress_loops;
 	unsigned int cpuset_mems_cookie;
 	int reserve_flags;
+	unsigned long tries = 0, max_tries = 0;
 
 	/*
 	 * We also sanity check to catch abuse of atomic reserves being used by
@@ -4904,6 +4905,8 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask)
 	if (WARN_ON_ONCE((gfp_mask & (__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)) ==
 				(__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)))
 		gfp_mask &= ~__GFP_ATOMIC;
+	if (order > PAGE_ALLOC_COSTLY_ORDER)
+		max_tries = 1Ul << order;
 
 retry_cpuset:
 	compaction_retries = 0;
@@ -4996,6 +4999,7 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask)
 	}
 
 retry:
+	tries++;
 	/* Ensure kswapd doesn't accidentally go to sleep as long as we loop */
 	if (alloc_flags & ALLOC_KSWAPD)
 		wake_all_kswapds(order, gfp_mask, ac);
@@ -5064,8 +5068,18 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask)
 	if (did_some_progress > 0 &&
 			should_compact_retry(ac, order, alloc_flags,
 				compact_result, &compact_priority,
-				&compaction_retries))
+				&compaction_retries)) {
+		/*
+		 * In one pathological case, pages can be stolen immediately
+		 * after reclaimed.  It looks like we are making progress, and
+		 * compaction_retries is not incremented.  This could cause
+		 * an indefinite number of retries.  Cap the number of retries
+		 * for costly orders.
+		 */
+		if (max_tries && tries > max_tries)
+			goto nopage;
 		goto retry;
+	}
 
 
 	/* Deal with possible cpuset update races before we start OOM killing */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index eeae2f6..519e16e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2894,10 +2894,14 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	struct lruvec *target_lruvec;
 	bool reclaimable = false;
 	unsigned long file;
+	unsigned long tries = 0, max_tries = 0;
 
 	target_lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
+	if (sc->order > PAGE_ALLOC_COSTLY_ORDER)
+		max_tries = 1UL << sc->order;
 
 again:
+	tries++;
 	memset(&sc->nr, 0, sizeof(sc->nr));
 
 	nr_reclaimed = sc->nr_reclaimed;
@@ -3066,9 +3070,20 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		wait_iff_congested(BLK_RW_ASYNC, HZ/10);
 
 	if (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
-				    sc))
+				    sc)) {
+		/*
+		 * In one pathological case, pages can be stolen immediately
+		 * after being reclaimed.  This can cause an indefinite number
+		 * of retries.  Limit the number of retries for costly orders.
+		 */
+		if (!current_is_kswapd() &&
+		    max_tries && tries > max_tries &&
+		    sc->nr_reclaimed > sc->nr_to_reclaim)
+			goto done;
 		goto again;
+	}
 
+done:
 	/*
 	 * Kswapd gives up on balancing particular nodes after too
 	 * many failures to reclaim anything from them and goes to


-- 
Mike Kravetz
