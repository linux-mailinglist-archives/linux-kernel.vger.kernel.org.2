Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653523E7DCE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 18:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhHJQvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 12:51:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:27612 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229516AbhHJQvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 12:51:45 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17AGfiD3031244;
        Tue, 10 Aug 2021 16:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=I/1RrKzBxO2lI0SZ9ExvLEkJyr24bV6+iutWRGB/9Ho=;
 b=PxTXcZN4Wr0GFFX7ynVV9BsieT+LJIFMgdF1zo3it7rqByGhK+hwez515jk5CsYI27X/
 it4ILg/joPz/BHqjW/6cd2JxiEac07oO/558OO4hL4032DzxAKTMC2kTfuDj9MEOcpU7
 0j4O+1zhWi4PMFlLijtv4awNfI7pXmx5lTaw2GyrXIdePNMe8cB7l5xOpIee6jQ0DqQO
 aHv8T58u/zv8HhMVGFIR4S3zbIBhTnIe88AwlVxIQs6jMAtcGerlxSt8Epaw+ptaBRTP
 pqAG7An89pPaDLOdmdf9LjbOdI+tUT9Bp5PEF8XeMyW5stmHJIp8QrPfeaaWwI8cK7Jd qg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=I/1RrKzBxO2lI0SZ9ExvLEkJyr24bV6+iutWRGB/9Ho=;
 b=v/BhQYg5qSBMttdo+5PE+rkNVSfCEJPAJm62eh1W8a+uJ54SVVqqT2B8uyjNnnZvB4cS
 qhsmRTFgqjJBdbO2cLNzO6buGiRQolCD7v0wMaG4+8xFYtsoEl0dJMLGlX+gdHO0MTls
 WahR2NQcUeieh/iDLM28ZUfRkUkvbt6V3vfbBvtJVTqnYaapHDea1GdcOnIiiKBPeL+E
 ehUtleVstC9AKo6ylP0boboO/m0jaDfwCjxKC5l6tEtQIdgGRzL+LqGyIMAC9LGcYcax
 EdZaiEipBPtvQoLoZ2VGEXKKTIvtmtWeJPUULDSWsf3DTeVs2RLRnJK/wmX+sKQY7r7N Sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aay0fvd94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 16:51:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17AGo8NM189529;
        Tue, 10 Aug 2021 16:51:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by userp3030.oracle.com with ESMTP id 3abjw4r0km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 16:51:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSWctOJx47wakz6fnYqRnQiLdIhKFaswu1Mo4sZ+IA/xLWzOtOw8eZ3eVd9c+jTG6hiL06kPGZ9/t6SZtFx1AKJTGtIfrp6AyklCjmI+Z/Yr8tv8KawcDYlRfXGlyh145lg5qi7sqPP18n/B7cJb9lWdwXs3n9lLUPP+XWHfozmxLzBJBLSTBIz6XyvCU6uL6VZBxcKYkXLA3NepOgQMVKyl55mBResXwyTvjEAK+TMzd6QofYqt4qXoMJ9Fq/azCWYr0nYaqKZ20vBzSjmeOM5DJyWk8tN3QuAL/hoUL00Ad42hIQpwhvbGTmgyG5KjjqC6mzN3UUbzQMZFpUmoHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/1RrKzBxO2lI0SZ9ExvLEkJyr24bV6+iutWRGB/9Ho=;
 b=OWE/9nYR+K0OlCxjvLN7/3Iq0ezRgyG3vH5AvDzqXDZeBEjPqYIFb3SxXYjCFFjOJ+XT+DvwUpW+X7citakIUIi4kL7ZEy8DsjJyJbV40KkXbl3mbkHn00GCdCRuCKkKMf7H3d/uaLNEKLhDjd2fCwRPknMbSx/5kBnB4/hhd5VRambUUcLdtXqTlWupRjT3ByCcVmVP0ZydJ+abaJU27cArgoBLkN17Wk4wgTIMDojAq2hM6FtLs+Ul1lCx/1g70t/T/8Te3e+q0JgUZ8j8W9XR72WZ6gKfL0tCSBMmtp1aVb/VjUlBVtKJZ1nKZhtRsuKEbtPxx2gALms92/Weiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/1RrKzBxO2lI0SZ9ExvLEkJyr24bV6+iutWRGB/9Ho=;
 b=sB1MPWaw9MV1XqRJ/2Ll2smp8kB6q+Y1VdKnrmNS3qTRA12unO4EGn26NN69/0ncODbIBsju0RCwaUpKA9AIT3JNhRP00mYYcCsRGW/ThSvyvGSxqL6bpgAdd4ZSKy+oMRMYrfotq+JwxAEDOCioBAkUmpG0IIRqMnSU/w1LBKc=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4371.namprd10.prod.outlook.com (2603:10b6:a03:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Tue, 10 Aug
 2021 16:51:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%6]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 16:51:06 +0000
Subject: Re: [PATCH v2 1/3] hugetlb: simplify prep_compound_gigantic_page ref
 count racing code
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210809184832.18342-1-mike.kravetz@oracle.com>
 <20210809184832.18342-2-mike.kravetz@oracle.com>
 <19f47b787269b95bb76d81bb1e6bfcc3@suse.de>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5d5a543a-026a-7b9b-30fd-47a31ac592d7@oracle.com>
Date:   Tue, 10 Aug 2021 09:51:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <19f47b787269b95bb76d81bb1e6bfcc3@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR06CA0060.namprd06.prod.outlook.com
 (2603:10b6:104:3::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.123] (50.38.35.18) by CO2PR06CA0060.namprd06.prod.outlook.com (2603:10b6:104:3::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Tue, 10 Aug 2021 16:51:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf783052-6b8b-4559-85ed-08d95c1f0b95
X-MS-TrafficTypeDiagnostic: BY5PR10MB4371:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4371C5217D3BF33CBA122DBBE2F79@BY5PR10MB4371.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6rQ/dxuc5yEI9PhoWB2MnUniVimIslaqlXeSNLLaQUUJuqgH393qdwpYPPhfkoBcAM0VjdB7FRK32qWhYQdfuiow2iBAiP1ggkxhNx1gHnE8mtYOFCYUNE7VRKqHaE5jwsjTfyJ1ShSHgmTrN/vRxz5gG7du+i3RPGgDJKK1xz/zmPq2XwQaF7zgc4TB6WvkUxVyucHFAOo39koDnG3tjmUoAZpx9gDgSdRH4grETCD8hWMHWPiUzBjR0Kpxi3MWXCfyOU0bNhQ2WzBdJ0gKw7Ljw2+Id7DC/A/jZ0vTZ6EhqxAaHHaY53anEzFhMJ2R6IqISNO/giQPqLEzoL8JfjUQjrVcWpkuEcZpNzQt/EKDCwSy73aiBTm+teKwURXxyd+49HsZ8XgL96GooU8yn+MxMADAAzmrjVbHWe0WchVZcesOJZYzBesKS9PMdOroEOMAQgql9vyULBJyt3sdCcnn/mBViQiareXRY/pnAXROAP22iH0STLHmZLUqAtANb1nqD0kT7UuA9gB4+ZMrpMPCv0NMAzyeMWyzpNy4Ps8bCAq8kSBrTyPkvxlmVY+oNmzQGOl1DngShQ88CRlsa9SPMQ3hr6BqbFYJKiOuGdKwkjFf265PZchNN9d1By+OBvuduFfXr+1MlxTbHCtrCre9zZvNoptVSxnDmKgl2O9m9/7IghZQ2PxhyfP+x5QXnuDIUU0N+0NnVGFPYA+QHH+Qof1jJq1YTtem2EDG9PFQLosli8qiPjlRbaN4T8Ky447B/KliBzXTSSHCst4hHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(136003)(376002)(346002)(4326008)(31686004)(478600001)(66556008)(66476007)(66946007)(36756003)(26005)(2906002)(44832011)(52116002)(54906003)(2616005)(956004)(31696002)(53546011)(16576012)(86362001)(316002)(83380400001)(6916009)(186003)(8676002)(7416002)(38100700002)(5660300002)(8936002)(38350700002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L051KzVCbXEyWk1JSUdRNlN4Vk03eTNMcENWLzhpUUpqdldlUHhoZFkwMVZ4?=
 =?utf-8?B?d1BZVGtUQk1JV2V0SDhCSTZmdVZzb3pwc2tqdVZZaGhwWk9rekJPT3ZqTFkr?=
 =?utf-8?B?Qm5UUXU5cDI4bFhjYkwxM0VaY3lyOXJhRUJEclVaTzYrTXdBTHdsNjZPR3o5?=
 =?utf-8?B?T0tDL0d6anNZL1ZTT2RzZFZ4Ykd4TGxQQXBIN05oU1YyQS9YcCtHK3VEbnZ2?=
 =?utf-8?B?QlEwRGk1dlV0K0RaeDhpSjdxVW40YjVvS0RwUGRzVVVNRGZzYldJckhvQS9J?=
 =?utf-8?B?VWw2Tm1mU01iWWpTK3EycGU2ZVJzZVhaK2hMc01ySHdVWGM4c1FtZ2ZQYWhN?=
 =?utf-8?B?elM5TzdPeENjSGhWeEtWcWliQTVxd09lVGZuYlpmeGNDaGFpT2lhRnJ6TUQ2?=
 =?utf-8?B?VGZELzVXaTRkQU1LR01sNFBpVTRIVUhUYWlYbCs3SHJSSWRYRE16OEZNM2lH?=
 =?utf-8?B?OWF5dWZzV2NDRTBPbTBSVWxleGd0UjhGSnpGZytJUGNMYjhLSzRHT2xEQ2dh?=
 =?utf-8?B?SzlJeEFOL0R2b0tDT2dqV3diNGxzVCttR3NWWnNGVk4vTnhQdVh1S2FUSDhj?=
 =?utf-8?B?T2dXQ0xhTXBSSFY2ckt1TmloUlUwRHNmYU5BWGRsSkl6ek82UmxyYS9JbkY2?=
 =?utf-8?B?dlExdC9aUFBLTHBIUDNWckJjQmRoNUF6YVlNY2l1V1J5cGtpSTg5VVQ1MFFw?=
 =?utf-8?B?dlZzZXgxSkdtNC83bHN4R2tzeFNLRUlKSHdleGNGZm5iS3pWYTF0S3RYYmdm?=
 =?utf-8?B?cWl2VVdod3JjSlcyNGQ5UWg4dW5rbEZEanZmYXE4KzlMbjBLM0Yva1p4OHZx?=
 =?utf-8?B?TFRLUzRmLytFQXpLNDljeG1pMk92UHVGVDNSY1VsaFpSQmVOcmJWTlBmTEdS?=
 =?utf-8?B?VjBhRzg4YTd0R1Y4bnY5VmpSdVpWM0RUSmpMb2RtVHFLTHlYME5UWFg2TUg4?=
 =?utf-8?B?TElBODFuKzVSL0xkM3k5ci91Vks5RStsVTlvc1crVkcwZHluaGtsd0lKbGRS?=
 =?utf-8?B?NUk0QVJqSmFHR3BpczllMHdiVEVGMEZPN0RDU3hURVpTVDRqQ2duR2h2REJi?=
 =?utf-8?B?dkExb3ZPZHZGNzVKM3lZOG5qeDFVdFVtZXdpSU1tTEgxQ0lhUmpSTkpreUZX?=
 =?utf-8?B?dkF6K2VPS3RJUnpwdXJ3NTJlVkM5anh1VGR2alBTazZRYklMQ3hseDV2c2lU?=
 =?utf-8?B?akZ3cVVjb3NsMXFIL2VIREppZ1l6R1pCV3puaFI1N0ZGY0toTndnbjFnT2g5?=
 =?utf-8?B?NW40ck9CTU92b05OMTVmMHd4N28xa1QwL1gvcmRzUlJyQk14QkNEL0hYVk41?=
 =?utf-8?B?U2VoMVNIcllWM1VrRG9TZTVsSUlRbzRMWTh2a1hsN2hSMlZxMkU4VVMzYURR?=
 =?utf-8?B?Y0IwRkhUL293THVMbW9WMlExTllBQVA1Zzg5RFVUQjhmeEpycVJCVUFEa3lL?=
 =?utf-8?B?RmRjRXF5Z0hORHZPWXpkZmRZSzVZU1dRK3BqendKcmRIRm82L1loQzJuZW5F?=
 =?utf-8?B?dGtwQTRUbXl3bjVPWElVbTRNdVFjRTRFbEZDNXBLM2IvUEgrOHdqd3U3STVQ?=
 =?utf-8?B?T1MreUtOZHRsK2RaVUR0Mng3d29pekFPTksvUHg2alFLdmhDYkNOSnJWVGd3?=
 =?utf-8?B?SWJ4eklLU2pHb2N6NE1Nc2grREVhSks2VHlLdUZiSUJUQlE0UW1CT2JxVGlP?=
 =?utf-8?B?VUJxbzNkVTUrMjAvd3Y0NGJVeVI5Z0NLMTRxWFdCdlBrVkc2VGdOM1BxcEJM?=
 =?utf-8?Q?176KK0WYKP3zUffS4mcBojnesV5vJZOJD7TANAE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf783052-6b8b-4559-85ed-08d95c1f0b95
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 16:51:05.9557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQBg0uTwIxvw93URCmIcHo09PSDU7Jm6h05s4AwdlGVS6r8WthPRwJMB+3gMaM2SqEP8270wTnhOEoI8Tf8kbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4371
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10072 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100108
X-Proofpoint-ORIG-GUID: uX_qZnNjeTfzoOPfhL9z8whRmzZCb0pB
X-Proofpoint-GUID: uX_qZnNjeTfzoOPfhL9z8whRmzZCb0pB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/21 2:29 AM, Oscar Salvador wrote:
> On 2021-08-09 20:48, Mike Kravetz wrote:
>> Code in prep_compound_gigantic_page waits for a rcu grace period if it
>> notices a temporarily inflated ref count on a tail page.  This was due
>> to the identified potential race with speculative page cache references
>> which could only last for a rcu grace period.  This is overly complicated
>> as this situation is VERY unlikely to ever happen.  Instead, just quickly
>> return an error.
>> Also, only print a warning in prep_compound_gigantic_page instead of
>> multiple callers.
> 
> The above makes sense to me.

Thanks for taking a look!

> My only question would be: gather_bootmem_prealloc() is an __init function.
> Can we have speculative refcounts due to e.g: pagecache at that early stage?
> I think we cannot, but I am not really sure.

I had the same thought when adding that code.  We cannot have a
speculative refcount this early after boot.  However, further
thinking below...

> 
> We might be able to remove that else() in case we cannot have such scenarios.
> 

Instead of removing the else, I think we should put a BUG_ON() just to
make sure the condition never happens in the future.  Otherwise, we would
just abandon the gigantic page and leave memory (1GB or so) unavailable.

Even if it were possible to have speculative references this early in
the boot process, the likelihood of it happening here is still VERY
small.  So, I would not expect a BUG_ON() to ever be hit in development or
testing.  Rather, with our luck it would show up in some production
environment.

Since handling the race in this routine is so simple, I chose to just
add the code to handle it.
-- 
Mike Kravetz
