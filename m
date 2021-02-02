Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBAC30CCF0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 21:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhBBUUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 15:20:15 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56704 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbhBBUSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:18:07 -0500
X-Greylist: delayed 4443 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Feb 2021 15:18:06 EST
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112J1Qjm058176;
        Tue, 2 Feb 2021 19:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vq56Hf3QBqBi19p2TLa7ItRxm40nWDqQ8FJpKkWJF7s=;
 b=bv9Jno9h6KjG/vEbvp7R1Bmvpk34JXynlu0W4ypxQUulGJ75ucNkHlEG0Ed/I0ATS93n
 1YIoRXXonE+xZ2Fh+CW56iVGiXYHStn5VrWDEA9QjhGpLCfB1cvm7WqkcFZ31fvT25xk
 U+Ohi9OlZLrKulMUZrNIYaoZwXzHxBbcE+xxMQciGNdp5/JWT17Exol/1YoCbJcaqRIq
 7jnFXt9vAoRiehDmztKH7DaG2XRpLfQK8EWD4iPUp8+nCi7HgDJ3tU3YuFDbcfzZhdsE
 K1dLttIsLq4RiiVKYg7oah1GmQFW127OD2YOpPplqnK6FnepFJrM7xYxwGQ9GsQFOPVo ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36dn4wj9yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 19:03:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112IFUK0066617;
        Tue, 2 Feb 2021 19:03:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3030.oracle.com with ESMTP id 36dh1phd0x-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 19:03:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8yzh27CtHXLz9nF6Q4CYANdWx7e708BTA3/vH+MtDoJdnWN1JMC9mcRzPZ4Uwuwv8se98LhCEHSMA1cpKahJK+Y6tOULPqTgAcyjhTmOXcARNRUqLwz0i2gzOE66zcAzndM57ih+Ih1ZkSNikMJfw7AP1RMrYwOCSV1kAdtsAlR/hUB9P4h35+mXhjer3DyhII2GYfYPI4CZgjCj0B7awvJ9u22lqZsb6cEp2P4SU9FQonL4D1BJYYB8X4tiYTWVPNW3u3z+FgSHmT32GqB8C8yHyUf9aorQylWy3qF0P6ChciECcntvQ5V49WHYw/EewsNQLXFKlWd+q25P/35gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vq56Hf3QBqBi19p2TLa7ItRxm40nWDqQ8FJpKkWJF7s=;
 b=iOXydvGFs+ocUtDptEiUqL+YIqobMsojQrJSeT83J4OMqpa8v6gfqgSB7Og/1tN5LRS7tOcgzhIfDkunqNO18+qLdqeyCx5lQzvJW9+PZEXSNW1e10aVhDQIEtlyinCqBHdMKia8iiPemsdRQNZjDyU3Vr7BgMKYnensBcVU9VFRiyjjLzPOVGFw+e2QkcCvXzpqGdg3VFdIvpgGEjKlp47oQV96Z5RQIutCEQZ4nt/m5XgnkjZOXSznfxcLns29bCUC5J8Rx/MJKGWJrVgk4QbKaWsV1BZiWnDL46wy/vQbAi9KJXrav8FgEU4LOiAvUi6nxvgcUVgT8FbjMjozmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vq56Hf3QBqBi19p2TLa7ItRxm40nWDqQ8FJpKkWJF7s=;
 b=hpahLIzXdj4Mk4dwe8kFkkNm0s/YPmHos3n6spsH2WvW0YSwGPNl1HaEfI0VdC/zeGg1rP3hN1aEbTMxstCCxH1XllSeGyvBP3WyM84o5pLqqqzJQFzKuaOqf4VeQ8kWv4qh4HL2lzgOjV6hOxBY3Ag5R7iGgVySY6LbJcItIG4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1278.namprd10.prod.outlook.com (2603:10b6:301:a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Tue, 2 Feb
 2021 19:03:14 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3805.026; Tue, 2 Feb 2021
 19:03:13 +0000
Subject: Re: [PATCH v2] mm/hugetlb: remove redundant check in preparing and
 destroying gigantic page
To:     "Xu, Yanfei" <yanfei.xu@windriver.com>, akpm@linux-foundation.org,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210202112002.73170-1-yanfei.xu@windriver.com>
 <1d700a57-24dd-7448-1d25-11c3e355f5fe@windriver.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7ce64226-6069-ebdc-6b0b-3673f0fa5254@oracle.com>
Date:   Tue, 2 Feb 2021 11:03:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <1d700a57-24dd-7448-1d25-11c3e355f5fe@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR14CA0050.namprd14.prod.outlook.com
 (2603:10b6:300:81::12) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR14CA0050.namprd14.prod.outlook.com (2603:10b6:300:81::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Tue, 2 Feb 2021 19:03:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39804377-f29d-4e81-5b30-08d8c7ad30d8
X-MS-TrafficTypeDiagnostic: MWHPR10MB1278:
X-Microsoft-Antispam-PRVS: <MWHPR10MB12781401CE9911B3B14C7F75E2B59@MWHPR10MB1278.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:415;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JpTD2DxzS9ZDuVI6N+EVsB9S+zqOiy3pFmm2hSlPUVuEivtIemTkeibu6/2eIwFo7ZuWbDk4bRXNdHZgZvDA2a5yRghgVmZ8kR/qkmotth0/kusApg75XmaMXOEWl5TpCw6NM3iExltpspnPwA006o6A2XWZAjchiqlzyETnIzFQuw3wdZU2pdPvGBzz+is5JknYUHiogac4qtjw6UpSlCucIxzvNqMz564tBphvASSh/a+J/u0mjPQYDMC/D6nPXhrjYtkGcrJyp+T1yhSppmDci85G9UWR53BfdKhD/pvSy0yiSRYxCQZ5xP2gfGohuLAB4zGaJU7aNhJf/hwKIgAsDAVU+Irevr1+u2piBIroHveBpbLmrb08Si5V74U0vkH+g6opHVR6bHxPDcBpVGDQoi5j3EuClyn/7hjwKakyoirHrxneuFoa/yVqMAzkqcmXZu4PEEW2DTxeb19su5N3iCuKw1RiZKfYgk0jZEsPOP6j8h7jn0GV6ZF3rBDNDJ8JdWLAKARHQp0VOZXniF2Y+w15evwdBgDCZByYUoPfylUQoqzuFFYWdVtTSHFjWzZ+OTjivC2Z/YGCChUzPCaRBoqdVAMu0X1p5BY7Lfc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(366004)(39860400002)(396003)(26005)(31686004)(44832011)(16526019)(16576012)(956004)(110136005)(5660300002)(31696002)(478600001)(316002)(83380400001)(186003)(66556008)(66476007)(8676002)(66946007)(86362001)(52116002)(6486002)(53546011)(8936002)(2906002)(36756003)(4326008)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S2x0c0xSbWM5ckN1WkhWVnNnZmRzeXBqc0lJaWNSWm9WZ2pMR0JsV1UycFV6?=
 =?utf-8?B?Q04vZUsydGxWbFZCL2crSkhKYWh2b0tNZTZtekgrNEtDejE2WFk3RjdKQ28w?=
 =?utf-8?B?cW95UDB6V0Iwdkhrb29ETDNnMGFUellsRlE1NXd6SytlcjNmZTljN2JaUmoz?=
 =?utf-8?B?NUdyeWdaNnBoeHZRT2lRa216NGJPRjNBSXVsTTVzeldFVURaamhMcnZlY2Nj?=
 =?utf-8?B?UzAyM2dwRnBaSkhUVXJUdk53TmEyWG95Mlh6NEJkY0lOUVVFMXU5NDE4NnI5?=
 =?utf-8?B?VDBBbDVBQ0RoUzE0ZkMvZDRUL1VyOVZKMzZuMzFmam5mSkFTUXFBVzg4MXFR?=
 =?utf-8?B?cmVxSXFBZ3BVb0xiczdaRFIrVERwamtJd21nREJqT09IYWxQdDkxc3pRcHhV?=
 =?utf-8?B?THFWUTF6bDZKbDdoeFJlZUhEOXE5N1BTM2lsVy9CUDVxU0p0UXVhSXFZbkho?=
 =?utf-8?B?SVdYNVdPQ1Q3V3pDQk1GK0JONWdmOU9MbTJPTmQ1Smtra2JFYmVKbTN3alRS?=
 =?utf-8?B?NjhkNU9yNjZERjNnUyt5TkdsNXBENHBvMGNRYndRb09FSlFLRUV0Yi8wdjJR?=
 =?utf-8?B?S0l6OU9HeTZhREZ1Y0srbytqOXNEcjkwTmVRcm50OVFjWjRSZWF0Y0dNZ21l?=
 =?utf-8?B?UEp3WUFMTnNsMmJDcnJCZTVicEVBS0hpb1BSSDNKeUpWdXY5S1FKc21vYWZh?=
 =?utf-8?B?OXAyVnl6SFpQRzBjQWdJM2JqNVlNb0lsTWQrc3loRjRCVGN3N1JlY3JiRzM0?=
 =?utf-8?B?WEVueFE4RkE2YUw1cEdxQXB1bldjTTNMSkV4ZFBmN3E2RFFZdHl4SkU4RzFW?=
 =?utf-8?B?VndzQ2NCRm1oU1dFZktZSWhPZ0daMXoxWm9qcDlUQzU2UWFkdHFnc0svR1BI?=
 =?utf-8?B?bVJSQUR1amh1dDA2eHc4MDJtSkFoZkhsSXdSZmljSC9VVmJuWkgxS1JkR0xy?=
 =?utf-8?B?UFhsQWpNTXYzZVh1cTJGUERMTGlZUk1TSFU2eGZzTHQ5cXpPdW01UG9JUHF5?=
 =?utf-8?B?MXVabFBvNkJPekxINnhvUWxHY1dwNXYzelJFWkIrOVVnQ0VnMXk4aDFraTA4?=
 =?utf-8?B?aGl0ZmprM3FhK0pRK2phbURzUUhRcGZONWxYNU0xTndGOHpsU21zSXpGbGhL?=
 =?utf-8?B?NG9rbWZvaFFUR1ZlcWYySm1yNitWanVpMGZqM0ZDR05xQ3NOQ0N0VUF2NEZX?=
 =?utf-8?B?dXNsTVlzWGF2dVNFLzVUeWxtdVJJUmIzcXp1aGFDQkljMVlBUmJ1V0pUMjU4?=
 =?utf-8?B?MGtsZ2ViZ3dVTDQvc0JJZ2xLbGU4ZGtjQStpNUZVa05HU0ZQY2Qyd0tsOTdw?=
 =?utf-8?B?bXV1RWwvMktPOEVYYmcraFJJSUZqcGRuNWdMRkpaekhmY1pzTFJHTWs5RVRS?=
 =?utf-8?B?SGhLSHYrb285ZmFrSThVNUk1VVRPSjlnc0V1NWlxM3VVaThyVWttd0FSSm43?=
 =?utf-8?B?UzU2dFJMaW9FeWQ0elBYTDFpYUdqMVhweTZobVAzMUpjK0s4ZU5ZOUw4Rkdv?=
 =?utf-8?B?dk44TmN5UUxrelZraC90Q1hsVTRiYXh5SEtHc2JUdkFQblRid3VSb3BVRnE4?=
 =?utf-8?B?Z2xlZDFuZ2dJRDdwZ2Vuc0tsOEJLY2o2NVRhVURtdnhlZnIrUUtXQkNBbFNx?=
 =?utf-8?B?MUhCcHZSbFNMYmQxRkdPbHhzMnQ5THp5anFrK2kybmd4b1JLc2xjSE43bUZh?=
 =?utf-8?B?M0xTdHc1SVl6V2JNRkJ1Z1hBL0RkT1FSUm9JczBBYm9tYzhnSUJIbWNXMlAw?=
 =?utf-8?Q?RXrEt9jJBQ64utFPVMP3ydIepkcA1jvAxUVatqO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39804377-f29d-4e81-5b30-08d8c7ad30d8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 19:03:13.8429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5U+5CqLtJO5kNTDOTbWmB9EikanUpDe6+0J+Ad0nx2LAaG71DRVM58N21BOP1wJwxhRRS09koNKbNfgNmb260A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1278
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020120
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/21 4:19 AM, Xu, Yanfei wrote:
> I'm sorry for forgetting to add David.
> Now add David ：）
> 
> Thanks，
> Yanfei
> 
> On 2/2/21 7:20 PM, yanfei.xu@windriver.com wrote:
>> From: Yanfei Xu <yanfei.xu@windriver.com>
>>
>> Gigantic page is a compound page and its order is more than 1.
>> Thus it must be available for hpage_pincount. Let's remove the
>> redundant check for gigantic page.
>>
>> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
>> ---
>>   mm/hugetlb.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)

I can not imagine a 'hugetlb gigantic page' being <= 1 order, so this change
makes sense.  Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index a3e4fa2c5e94..dac5db569ccb 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1219,8 +1219,7 @@ static void destroy_compound_gigantic_page(struct page *page,
>>       struct page *p = page + 1;
>>         atomic_set(compound_mapcount_ptr(page), 0);
>> -    if (hpage_pincount_available(page))
>> -        atomic_set(compound_pincount_ptr(page), 0);
>> +    atomic_set(compound_pincount_ptr(page), 0);
>>         for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
>>           clear_compound_head(p);
>> @@ -1501,9 +1500,7 @@ static void prep_compound_gigantic_page(struct page *page, unsigned int order)
>>           set_compound_head(p, page);
>>       }
>>       atomic_set(compound_mapcount_ptr(page), -1);
>> -
>> -    if (hpage_pincount_available(page))
>> -        atomic_set(compound_pincount_ptr(page), 0);
>> +    atomic_set(compound_pincount_ptr(page), 0);
>>   }
>>     /*
>>
> 
