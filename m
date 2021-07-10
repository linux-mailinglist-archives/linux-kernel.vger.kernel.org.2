Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037633C345C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 13:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhGJLew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 07:34:52 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:46996 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230468AbhGJLev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 07:34:51 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16ABUfZm030112;
        Sat, 10 Jul 2021 04:32:00 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2169.outbound.protection.outlook.com [104.47.73.169])
        by mx0a-0064b401.pphosted.com with ESMTP id 39q6u583wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Jul 2021 04:31:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKszB+D7/oFM94G4NiDe3i4eJazY3kQbEhdBP3nM3EZ6uj7qzoyUehqboKotYBa00BEAvzaRmQmUP/zfQdNKc0fisA+mEHyakRn36pVgqPvqM4HWKhzAncILMwwt/PizBBzrkTkkRF4BWylC+KVAWFlBpTluhrHvbVDdozDSlGkMr2U9o+5v5n1J+/rbpUy075JVWPJichZsHZ4ALRdhYp2qYzUflSq+8w5fN18Kqr4FpL3yy+81vFPXEXSNrI/cxMK5Ro20ppwKSe+nbfvrxN+whGYhTJB6RMSOfK6fbpRSHVltQ3PX8FsMr1J9GcRtqfWdbXJkDs8Ykyeu7HN9SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3zJ9UI8vqfHFIu+4autTmkXOf6uC9pmp7THmqX4giA=;
 b=LCWKbLpwtKHsqJt6SPuE8CLRt3YBtFwSmC3DFwCAxbawdnUtxeQqpcuQnM8j22JhHd2VoFZF/fxUJ4Q22qSoy90qygxxS2KN1r0fgFkyCNAw5UEUvRm1egpGHvdumnCph5uMRYPeXg38iwPGruMqdKaqQ7d95gp/upn/MwfNqYmCULFtzo6czMR08L2suLydVQOjETGR3WN5vUeYCFmWb8Xl1AIqCcoU3JaIf/cseeS2zw/GnttTWPV/ZzrF8wHo8kf1dmKjTFOjgm7kwoMP2elKmL+mvRQDtJCWkGNGRw0Bsrg6lqFD8k4IbvvDdxm1wPgWnJ6f+5EVbHckK90BmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3zJ9UI8vqfHFIu+4autTmkXOf6uC9pmp7THmqX4giA=;
 b=lrA86AUyZyulECI8+1HjzvdSmKHVZSOCtpxlnTLHy0pqnfNqjDWpF4iusbs5BeFYhJJaZynG2pm4CZkMKH1JyNQYGSJDNWc0xbwfp8AScM8+HSK9F7H4dOn8YXx1wsUHro2HjPE0ZY6PNbblaI9OhsqGt38up0K5gIYFbGrBXyY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5734.namprd11.prod.outlook.com (2603:10b6:8:31::22) by
 DM5PR11MB1930.namprd11.prod.outlook.com (2603:10b6:3:106::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.22; Sat, 10 Jul 2021 11:31:56 +0000
Received: from DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::bce8:81f7:f5a1:af19]) by DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::bce8:81f7:f5a1:af19%8]) with mapi id 15.20.4308.026; Sat, 10 Jul 2021
 11:31:55 +0000
Subject: Re: [PATCH 2/2] mm/page_alloc: avoid counting event if no successful
 allocation
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210709102855.55058-1-yanfei.xu@windriver.com>
 <20210709102855.55058-2-yanfei.xu@windriver.com>
 <20210709122601.GA3840@techsingularity.net>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <cd08e02d-e6c7-237a-f188-d53a2cd5e512@windriver.com>
Date:   Sat, 10 Jul 2021 19:31:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210709122601.GA3840@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR06CA0019.apcprd06.prod.outlook.com
 (2603:1096:202:2e::31) To DM8PR11MB5734.namprd11.prod.outlook.com
 (2603:10b6:8:31::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2PR06CA0019.apcprd06.prod.outlook.com (2603:1096:202:2e::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21 via Frontend Transport; Sat, 10 Jul 2021 11:31:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a48b641b-ca4b-4fce-6982-08d943965229
X-MS-TrafficTypeDiagnostic: DM5PR11MB1930:
X-Microsoft-Antispam-PRVS: <DM5PR11MB1930A5C8393E41C8607DB05DE4179@DM5PR11MB1930.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: voF7jHfELqNW0H9WBbB2aN1SqoxPgsoYjEdiqy2187yFhU8rv9MQwWrj7B+v/Dn/ETpCz+JyBKY06R8NLnXZxdrBd351g0YYMzI+azZnBbE/wmI+XCpRL+894+I1gN7D3Lrqmh/rN6tZig3eMNyxTnU9BoQ6Ayf9cfsCbQ5zzUD+Db/apCCKltJCrLwq2XMx7x2W7e9Pf+6yTcL2pLKMp6jnA1aaj6/gc3ZLo3j377pionkRdzUjMUb0hFLqhHqnNa9ydvyxsriKfIZ0a4LH31lu+JjKMXPV16EDekEE+iYAk8C9FvQ7C16HNPOusIMQ2ZVMd+BcOuHM95C78ztNlAWJTF3zFLV0HgdkR/x8II2uxHtFgT2Q4CE2yEoDmRxzmLSzvgthp+dxQpNtf8YWCxgIAF1OPNZzmq4i//DTRs2nI2N9TNNam1SFZZN1w/gfRXjxwSwFjV6MYyYVS16TrQbqg8AsA/tQrl60OSThE5YskVXreDrV33Gkqp7gG2CzXIZMdEbpB4GPdEJFx8n8QVkNdcMwTgBHuZGTSOHNCnjghhJv5t98eq2AjCYO0Bbor7MpdjNUdd0okQVvl324YK7Wj/NrRpQXv9SKWUKNv4oLfOZUKJcLOyGT1EhF5dRbXjY59GUW4mYHZ6/mDQREOSIGxn/3lXtIUBSnX7rKVvtRgIsTYt59u1qqgD/LqbyO3dwJi8KD5KnnaoWnrnUOX0gn7cMQjUP3e/UrIsMpS9JojVC0ZOlx6pl6DtD40ef1ywhS1K1ggdHzYxRM7ekzdp27aqGhdM2LCcgjYD8Rxcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39850400004)(346002)(366004)(6706004)(66946007)(66556008)(66476007)(2906002)(478600001)(5660300002)(6486002)(8936002)(8676002)(53546011)(83380400001)(26005)(6916009)(52116002)(38350700002)(6666004)(31696002)(4326008)(186003)(36756003)(86362001)(38100700002)(316002)(31686004)(16576012)(2616005)(956004)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-15?Q?nhYOJYJlCY8mtyq20XJRW2vNIg8x+KBNT2wYMvOwa9xFQuT+F7OUo9/3O?=
 =?iso-8859-15?Q?4pYDn8XdEJZzxDua7UsU+5LlTaw3w4H8B3cMSJ4Wsr5toSuH4fD29ZSh9?=
 =?iso-8859-15?Q?ryNU9Y2h7DO7nL3kGPz1Dpyt15EszndLFsoPwgZVOXv/S99NcRqWLGyqU?=
 =?iso-8859-15?Q?PxNy7WMNuTNaqxjKo/VP7K3XqFIBvCfH9/2hBJeuVGhIlIcU1GwDr3IOu?=
 =?iso-8859-15?Q?+u2lJ2NZM8oopu6J9A/WWceOJSvmAHcU7/Wsp4jCuod1w0ZJVz3FmLlTq?=
 =?iso-8859-15?Q?1NzqdGyLp1r2LgfzbzcAQPY7Wl2UHsGZcu1P5FMY+R8+v//q9BYpwn8S8?=
 =?iso-8859-15?Q?YE/odXWymdAaQ+s3W2Bfq3+zkRkTDm7BZ8/C24kE8233BnK5nboNPbGnJ?=
 =?iso-8859-15?Q?MK0mp9gwLN4geQhW9CcIAMKSnXF7O5ViuKMhhI0LQXLfr8B8fai5KF9QW?=
 =?iso-8859-15?Q?ai6JyrFxYhL2dglYE+HRlIfrR1Vj1ysh4Qrev4GDX8xIgUz4yR5MF5ZOj?=
 =?iso-8859-15?Q?YdcaOvGdrp083A9si9d4greb1iKhaVgP4fICkqk2QxcGZTv8nFW5jaDCj?=
 =?iso-8859-15?Q?CfrkTZRj95l02LnEIx/5ZPuZDZgHw+3OWzW6s95MCHnLQ8OBhyieOkEdB?=
 =?iso-8859-15?Q?ErPYXfQejA0ZUQWBj9JgeTwF2KrbG0Zc9eyueZWtsJzvq6O1zcplDvx2R?=
 =?iso-8859-15?Q?8yhf0sEPLueQcKbVbmmomgPnmLRR70FQszV4+jK2G8S4JvnymK1UALebV?=
 =?iso-8859-15?Q?cEac1N3IqCASNWCBMM9SN5I9mKUp2GPGS3szDQQi3D7DnuKphDG2Uxszm?=
 =?iso-8859-15?Q?67ZhkRJ+iA03C3U4067/fCpfdhoynNgkB/RnKHSVEjvj7az52rMfm2PsK?=
 =?iso-8859-15?Q?3Wy9rb78lYdOmHKPSx8oBV+eyh9ZzZWTE1ST2joJriS2K200YZ9PDn5y/?=
 =?iso-8859-15?Q?B1WP80Y+odRPdLPRc7yZCPEsuzuNBy5aaz61HJqQ9M57rpNXYnv+cvkST?=
 =?iso-8859-15?Q?tDVyCaXIgMNL52p/Nb19aYZaS8fRZ8MTwgNrt4d4vRlmLRbV+Yccys6q2?=
 =?iso-8859-15?Q?iVX6rTmaH2GvupTGoFTssnIuYfYkv4DE5zamFVORFwbukgCB1W+3qnjIb?=
 =?iso-8859-15?Q?IU+Lj5MN62qPIlVwO3CmS6UAuzwyHO2xtv0aWZcAjtuXCWYSqRthmSZVF?=
 =?iso-8859-15?Q?O35upgAIcr4vdbcsa0PU4/LFqcbKt/y7HKt5rQoV4Nv3ztp00PUNhQAbu?=
 =?iso-8859-15?Q?lkh+8KAJlCEfNACoSqQlAgAlLpQxUdN8DYiZpP79cTN3/GftoFy17yUki?=
 =?iso-8859-15?Q?aZ/maMRtbo+MikWa89bDzr/TscQ/MHfrKuWFGhT/sU+q6Mms2dzljz8bL?=
 =?iso-8859-15?Q?9gGxmShuCt5PKUsgBtHaJ3p03A5S1wjed?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48b641b-ca4b-4fce-6982-08d943965229
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2021 11:31:55.6398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTSSsAuVV7AYkL9dOOhx3COx7Gkx/PTn2RiNQ0IfUEE03v7Q36UkmkUIq05vDkC1udkNO4T+EZbfQ0SOsX6Jcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1930
X-Proofpoint-ORIG-GUID: bHY-4eg9cDHSc5rsC8OnKJ-uLHek6c6h
X-Proofpoint-GUID: bHY-4eg9cDHSc5rsC8OnKJ-uLHek6c6h
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-10_02:2021-07-09,2021-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107100024
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/9/21 8:26 PM, Mel Gorman wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Fri, Jul 09, 2021 at 06:28:55PM +0800, Yanfei Xu wrote:
>> While the nr_populated is non-zero, however the nr_account might be
>> zero if allocating fails. In this case, not to count event can save
>> some cycles.
>>
> 
> The much more likely path is that nr_account is positive so we avoid a
> branch in the common case.
> 

Got it.

>> And this commit extract the check of "page_array" from a while
>> statement to avoid unnecessary checks for it.
>>
> 
> I'm surprised the compiler does not catch that page_array is invariant
> for the loop. Did you check if gcc generates different code is page_array
> is explicitly checked once instead of putting it in the loop?
> 

Hm.. In fact, the page_array always doesn't appear in the loop due to 
the compiler's optimization. And I just confirmed the assembly.

not apply my patch:

ffffffff81267100 <__alloc_pages_bulk>:
ffffffff81267100:       e8 0b 73 df ff          callq  ffffffff8105e410 
<__fentry__>
ffffffff81267105:       55                      push   %rbp
ffffffff81267106:       48 89 e5                mov    %rsp,%rbp
ffffffff81267109:       41 57                   push   %r15
ffffffff8126710b:       41 56                   push   %r14
ffffffff8126710d:       41 55                   push   %r13
ffffffff8126710f:       41 54                   push   %r12
ffffffff81267111:       53                      push   %rbx
ffffffff81267112:       48 83 ec 58             sub    $0x58,%rsp
ffffffff81267116:       85 c9                   test   %ecx,%ecx
ffffffff81267118:       89 7d c4                mov    %edi,-0x3c(%rbp)
ffffffff8126711b:       89 75 9c                mov    %esi,-0x64(%rbp)
ffffffff8126711e:       48 89 55 a0             mov    %rdx,-0x60(%rbp)
ffffffff81267122:       89 4d d4                mov    %ecx,-0x2c(%rbp)
ffffffff81267125:       4c 89 45 a8             mov    %r8,-0x58(%rbp)
ffffffff81267129:       4c 89 4d c8             mov    %r9,-0x38(%rbp)
ffffffff8126712d:       0f 8e 7c 05 00 00       jle    ffffffff812676af 
<__alloc_pages_bulk+0x5af>
ffffffff81267133:       4d 85 c9                test   %r9,%r9
ffffffff81267136:       0f 84 84 05 00 00       je     ffffffff812676c0 
<__alloc_pages_bulk+0x5c0>
ffffffff8126713c:       49 83 39 00             cmpq   $0x0,(%r9)
ffffffff81267140:       0f 84 7a 05 00 00       je     ffffffff812676c0 
<__alloc_pages_bulk+0x5c0>
ffffffff81267146:       49 8d 41 08             lea    0x8(%r9),%rax
ffffffff8126714a:       89 ca                   mov    %ecx,%edx
ffffffff8126714c:       45 31 e4                xor    %r12d,%r12d
ffffffff8126714f:       eb 0b                   jmp    ffffffff8126715c 
<__alloc_pages_bulk+0x5c>
ffffffff81267151:       48 83 c0 08             add    $0x8,%rax
ffffffff81267155:       48 83 78 f8 00          cmpq   $0x0,-0x8(%rax)
ffffffff8126715a:       74 1c                   je     ffffffff81267178 
<__alloc_pages_bulk+0x78>
ffffffff8126715c:       41 83 c4 01             add    $0x1,%r12d
ffffffff81267160:       44 39 e2                cmp    %r12d,%edx
ffffffff81267163:       75 ec                   jne    ffffffff81267151 
<__alloc_pages_bulk+0x51>
ffffffff81267165:       48 63 45 d4             movslq -0x2c(%rbp),%rax
ffffffff81267169:       48 83 c4 58             add    $0x58,%rsp
ffffffff8126716d:       5b                      pop    %rbx
ffffffff8126716e:       41 5c                   pop    %r12
ffffffff81267170:       41 5d                   pop    %r13
ffffffff81267172:       41 5e                   pop    %r14
ffffffff81267174:       41 5f                   pop    %r15
ffffffff81267176:       5d                      pop    %rbp
ffffffff81267177:       c3                      retq
ffffffff81267178:       8b 45 d4                mov    -0x2c(%rbp),%eax
ffffffff8126717b:       44 29 e0                sub    %r12d,%eax
ffffffff8126717e:       83 f8 01                cmp    $0x1,%eax
ffffffff81267181:       0f 84 47 04 00 00       je     ffffffff812675ce 
<__alloc_pages_bulk+0x4ce>
ffffffff81267187:       8b 0d 53 22 a4 01       mov 
0x1a42253(%rip),%ecx        # ffffffff82ca93e0 
<page_group_by_mobility_disabled>
ffffffff8126718d:       48 63 45 9c             movslq -0x64(%rbp),%rax
ffffffff81267191:       44 8b 7d c4             mov    -0x3c(%rbp),%r15d
ffffffff81267195:       44 23 3d 58 22 a4 01    and 
0x1a42258(%rip),%r15d        # ffffffff82ca93f4 <gfp_allowed_mask>


applied my patch:

ffffffff81267100 <__alloc_pages_bulk>:
ffffffff81267100:       e8 0b 73 df ff          callq  ffffffff8105e410 
<__fentry__>
ffffffff81267105:       55                      push   %rbp
ffffffff81267106:       48 89 e5                mov    %rsp,%rbp
ffffffff81267109:       41 57                   push   %r15
ffffffff8126710b:       41 56                   push   %r14
ffffffff8126710d:       41 55                   push   %r13
ffffffff8126710f:       41 54                   push   %r12
ffffffff81267111:       53                      push   %rbx
ffffffff81267112:       48 83 ec 60             sub    $0x60,%rsp
ffffffff81267116:       85 c9                   test   %ecx,%ecx
ffffffff81267118:       89 7d c8                mov    %edi,-0x38(%rbp)
ffffffff8126711b:       89 75 9c                mov    %esi,-0x64(%rbp)
ffffffff8126711e:       48 89 55 a0             mov    %rdx,-0x60(%rbp)
ffffffff81267122:       89 4d d0                mov    %ecx,-0x30(%rbp)
ffffffff81267125:       4c 89 45 a8             mov    %r8,-0x58(%rbp)
ffffffff81267129:       0f 8e 91 05 00 00       jle    ffffffff812676c0 
<__alloc_pages_bulk+0x5c0>
ffffffff8126712f:       4d 85 c9                test   %r9,%r9
ffffffff81267132:       4d 89 cf                mov    %r9,%r15
ffffffff81267135:       0f 84 4d 05 00 00       je     ffffffff81267688 
<__alloc_pages_bulk+0x588>
ffffffff8126713b:       8d 49 ff                lea    -0x1(%rcx),%ecx
ffffffff8126713e:       31 c0                   xor    %eax,%eax
ffffffff81267140:       eb 03                   jmp    ffffffff81267145 
<__alloc_pages_bulk+0x45>
ffffffff81267142:       48 89 d0                mov    %rdx,%rax
ffffffff81267145:       49 83 3c c7 00          cmpq   $0x0,(%r15,%rax,8)
ffffffff8126714a:       41 89 c4                mov    %eax,%r12d
ffffffff8126714d:       74 0d                   je     ffffffff8126715c 
<__alloc_pages_bulk+0x5c>
ffffffff8126714f:       44 8d 60 01             lea    0x1(%rax),%r12d
ffffffff81267153:       48 39 c1                cmp    %rax,%rcx
ffffffff81267156:       48 8d 50 01             lea    0x1(%rax),%rdx
ffffffff8126715a:       75 e6                   jne    ffffffff81267142 
<__alloc_pages_bulk+0x42>
ffffffff8126715c:       8b 45 d0                mov    -0x30(%rbp),%eax
ffffffff8126715f:       41 39 c4                cmp    %eax,%r12d
ffffffff81267162:       0f 84 19 04 00 00       je     ffffffff81267581 
<__alloc_pages_bulk+0x481>
ffffffff81267168:       44 29 e0                sub    %r12d,%eax
ffffffff8126716b:       83 f8 01                cmp    $0x1,%eax
ffffffff8126716e:       0f 84 66 04 00 00       je     ffffffff812675da 
<__alloc_pages_bulk+0x4da>
ffffffff81267174:       48 63 45 9c             movslq -0x64(%rbp),%rax
ffffffff81267178:       8b 0d 62 22 a4 01       mov 
0x1a42262(%rip),%ecx        # ffffffff82ca93e0 
<page_group_by_mobility_disabled>
ffffffff8126717e:       8b 5d c8                mov    -0x38(%rbp),%ebx
ffffffff81267181:       23 1d 6d 22 a4 01       and 
0x1a4226d(%rip),%ebx        # ffffffff82ca93f4 <gfp_allowed_mask>


Thanks,
Yanfei

> --
> Mel Gorman
> SUSE Labs
> 
