Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5D245CCB2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 20:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245306AbhKXTIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 14:08:42 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31744 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350892AbhKXTIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 14:08:34 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AOHiCVp012799;
        Wed, 24 Nov 2021 19:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1u8ifKRq7InKg08KJIQQHRLMjxqXsGb8hEKYiUsLUnQ=;
 b=U/3wtfCkDfl1tDbQ5FBRxvDkVSEMdf+haVVhcN6yD+moF7pHr1ixyazcpDnnAOnrVdk9
 sJdEWVFWePn+C+XcQxUMa3CrFyvHtMrcHG2BBRBrB/ubvUDZs1Ws8xMSJY7Maaeom97X
 yCDk13Y4PmxWzGWtAHf+VUPRUFmKbugKGUtekrp9z8xdLxIWa1x51PLoj0yUEa0/jom+
 2msQpk/QF2GbqHAJwmK3r7M3Dpx272Y/0w4x2HB2iwHDkud3CPhg3ixgOUq3pSSGHM7n
 oWpt7ALIQHMhp8mIBJtVX3Zki1jbb/VMfWKqDvTGzfveps7SRp2SI7OtP2NYurNsdQ27 mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3chj7g36ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 19:05:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AOJ1KIJ178884;
        Wed, 24 Nov 2021 19:05:14 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by aserp3020.oracle.com with ESMTP id 3ceru7j12n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 19:05:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSR+dXNRNqTzUwv4hm1OOwcimF4bIWpyUyKk6lxny51vRGKG0HvwYoT1+cvMuhHP02HQ5+oD5BTxeBa8jZkfDx/L3c/57dZvAQvOOWyHL38yEk9jvHsiZM0wC2IqfniLCdVq7Ao5wnVnrB1ZDGuAHkw93TiwOcpUrLrdc9vzcuFcj6Mda9Od16uEzVqM0uFJWlqHtZFpD4RXB+jW7ir/vXw+5Sf/zUEJZh3ShmAx2qoxxnX4Yq+qoxYPKt56tGx0TWWNid4p8QDbpsdnhvVkDdtcFEujiJji3SF8miL4tf0qZPBEiezNVtuFDVyNy1IqNxgsGQ5KF7yHmU+n7a/++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1u8ifKRq7InKg08KJIQQHRLMjxqXsGb8hEKYiUsLUnQ=;
 b=CQ4S6Sf6Z0ditfAds3LG+PhxcLhPa2qkwK2DQaklq//2x2tBWUFQGTclNp3fTC7CtifwnS4BY9fiPbfg5DoUJAwpM7OWlAfUcifmbP4QuMnlt1IniMNKhICInetW4/PADbcMfp6a4VmF43OeU/GjDCICYavNPXu1hoPgMHI3KnZDQdTbnnb2shjiZckDW6aR8Oir5oaumz5zmdHC+k9bbbWBGxU9h5rDSwKZ1k4bOPEH6ngRxkLGC4Vf+g+i+xG9vSQBa0Rnt2lFaCCzgkwdJfpN+7LFzBma4H7hKhWI/qQE/pfFzyBZjJaBseh8wdZHS97zKN9soZ76zAL/lT79+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1u8ifKRq7InKg08KJIQQHRLMjxqXsGb8hEKYiUsLUnQ=;
 b=tFJxaU5EumZpV4TTW4G0AUZ2I9G5n/KO7MWc567+E4kI3+JchhNm5QG9jAAftmUjbvaggfkcjS2/1tGOsL08x7EIUTLOwVZipLgvtDhkPYogO3OQZ2ZA4Yf4YjP/VMlDCe06+jUFfg57rULmVr2a3Awj1uR4klVdZTs0w3q2wNg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3906.namprd10.prod.outlook.com (2603:10b6:a03:1f7::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Wed, 24 Nov
 2021 19:05:12 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7%9]) with mapi id 15.20.4713.021; Wed, 24 Nov 2021
 19:05:12 +0000
Message-ID: <7423472b-a6d4-4b37-0953-24b11aba2fad@oracle.com>
Date:   Wed, 24 Nov 2021 11:05:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 2/3] mm: migrate: Correct the hugetlb migration stats
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     ziy@nvidia.com, shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1636275127.git.baolin.wang@linux.alibaba.com>
 <71a4b6c22f208728fe8c78ad26375436c4ff9704.1636275127.git.baolin.wang@linux.alibaba.com>
 <20211115202146.473fff2404d7fb200dd48bd3@linux-foundation.org>
 <71816b8f-93e5-5a2a-e616-d52a1c4d354c@linux.alibaba.com>
 <3e6dcac6-c947-5f94-cd94-b59a8247dbcf@oracle.com>
 <d51d8f1a-ebda-e45a-9dd5-e5cca707ccdc@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <d51d8f1a-ebda-e45a-9dd5-e5cca707ccdc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::6) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Wed, 24 Nov 2021 19:05:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc6a0ee3-d9e5-42e5-472f-08d9af7d5712
X-MS-TrafficTypeDiagnostic: BY5PR10MB3906:
X-Microsoft-Antispam-PRVS: <BY5PR10MB390625ECFCF1194920B16F5DE2619@BY5PR10MB3906.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8qGNd+tWBZrZfyTTC5Mlxh56lrcgf/GNiQXRLtMz7UjGoB+a2i7d7UAG3oF4EQfdKPdK3MWZRVfR9JmZQT8BBDMejlbcEs4tsfl9j4lZospkPr50FwV/D7EM8vwgYzUu41pRP6Qb9SAJS3leW43gPH+6hhgWPJgTYXS3cp0slNswFjY21yO4lEWnuLhXg4BIUSlsmKa+P+THPO9jhItX5FQMYpvBRPqcmwZ8C8QqY+F0nAxFBwN3EoIN2GO4i/Jj0CPheWVkVeT9ZoXt1ZFxq0P1fzTCq5IZqfgzEpYjY6E3f/nLS8x+J6tFIwUXAJC1OoxqcSwgtJ4d5Ad/rGhfws7it4OLrjDPPaIeO6jBBDMAHws7rDmES6OTBT9mWHCbB98ASuTdubLChyNu2ywLCJQup9cho+3it6vNGXAWmhefXC0uwD417JccwD+Qg9SzumTi3QToMdumrJQZX9xL6qai89IuONF9wXdvx3Qrned62NSTu41+dkgq6A60UGF0irZMwkqUmey6SrVxFdpbIqei3WqVdMrtNfUU3xlfMPl/lTuCgi1L+G0RUN/EUXIkN78qelRbYo4Gu4J4ik58/GfwpKxVQD5eZxJvNCE6+WIwdaKCTW0PbETWC8lSYnewzDdWalZOiXz0H9t5nPOeIgAcJOK0VgdGuUD7eeEHqw5Y930/xP3ZNpc6VhthEwPJPDEBKgFCBLSHzspiG8oHcq1WLISK44YqsNz4HmLhTn3QGYxjoa/UFVwI3pa6Jd2xlgrewQyrZ80h+EdHMYFx9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(4326008)(16576012)(110136005)(8936002)(36756003)(31686004)(53546011)(5660300002)(508600001)(316002)(8676002)(44832011)(26005)(38100700002)(38350700002)(956004)(186003)(2616005)(6486002)(52116002)(66946007)(66556008)(66476007)(86362001)(83380400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnZMUGNkL01UQ2xybGNSbkJpUitrbzh3T29yNXl6YkNuMW45WXJRWDUwUG40?=
 =?utf-8?B?ZW84OUtPVXQvdFVMZjI4cjFKYnBYUENwVWZTd2M2YUR4cEZPSHUzWmhIdzls?=
 =?utf-8?B?WHZQUUxsMnlxZW5jY1Vrc2VRY0tjMExKZ3psaTljSkxNTTU0VVF3cUU2SDZV?=
 =?utf-8?B?OFZYc2QxMmV1TTRyZ3BwYy9KcG44WkkrcUw3Q2FabXhQaFU0TC9rVnYwRzho?=
 =?utf-8?B?R3g3Qkhic1prcllGczEwbGI2VHZjVWdpU3hDajJhM0V5ZXdoRVAwc3huc2E3?=
 =?utf-8?B?YnZzMlYyOVVNdStXTlExc0JkTHZIdXhZQzJ1U255ZGd3RFFKY045NzA1UUpL?=
 =?utf-8?B?VXJwRFJzYkc0d2Jzdm1TcVZmUEIyWHNvc2ZhcU5yT2NlZHgydXBBWVFsMnlF?=
 =?utf-8?B?RGRmZ0hCM0dYaTVDRGtNeDZPOFh1YUtRbS9BMElkY1J1NjduQ3lwK1NwS2hP?=
 =?utf-8?B?NUljdkNZVWt6UXRvaDN0SmhqalUyU1o5dTFmeUxwSzI4aUUyaHhNSlhBRmF6?=
 =?utf-8?B?OHRJZkIxZVRkWUd5bW14UUI4aUt3eUZiWitRVGhUQTJZaEdxcGF5eUhtbTNk?=
 =?utf-8?B?UjJFbENpMGhnaExoa3Uza29SS1BVTmtoazJZMW1vRUFTdVpxQ2s5WW01MFdP?=
 =?utf-8?B?dGVnTFZZemlqWTkvV1VWZFNuNWpwdTVWWWczY0J4WE5UWW8vZndWNzRjOWg3?=
 =?utf-8?B?TWsxcGFPWjdyOE03eXBwUDkzWE1XSThFazMxaklPUC81bUQwVmdBWmxOLzJY?=
 =?utf-8?B?QWJyV2M3eU90R1hwQmUweXRSVVZmczJ4Y2hZQ1pnWkNwa3BpbnAyN3U3UVlX?=
 =?utf-8?B?QUNKSHZ0TlZVY1VVYmJZYXNtZDJ0TWV0c2ZKWERwckhHbzdJTkE0WWU0enZX?=
 =?utf-8?B?NUZ2RU1yMDZCVTBrY0Ira1hIV21aMGVoZTBtTVFmbWx3a0FlZm5JNEk0UWc4?=
 =?utf-8?B?amlUS3NRZlFiQ3JFTlltNmc3TmhBMGRPcW1wSkpJdXVkVHRNSjR2dmFubzIx?=
 =?utf-8?B?UndkekxMclBUUDQ1NWswclVtVnh3aW5VNGFtTW1ZRFlZUkVqY3FpcjRwUVZZ?=
 =?utf-8?B?dlhqREE5OVhvdmpLWStJb2tpS2RjK2pvNXFHQkhqblhtaTZWQ3NqOTU1STFq?=
 =?utf-8?B?aWZFS29PNkl0dFpNajhNRjNRM2NuOEdlbjk3NVBRekhYenE4WCt1S2pMV2RP?=
 =?utf-8?B?Y1g3djQrNTh4WmdtMml5bFJDRURFM0ZyaFFyZi9tdk9Xcm8vQ0RhYklGbDdS?=
 =?utf-8?B?ZkUyMllQRkduMUl4aWFBUGd1akZrQzkxdGk0anBOdVdpb3EzcWtjNjJRaDU0?=
 =?utf-8?B?cE55WmUxeHJiek5td1dQeWZiQmM1cU1QL3VDUnNMVlVIRW45bi9meW9Kcjd4?=
 =?utf-8?B?MVNWc2hQWmFUMGZYM3REOW5Ybk5XR0YvSkFiblJydkJqYW1FWW15dUhJWERS?=
 =?utf-8?B?N29JMVJhRmNWcFhlN2cyOG5RWU85VVZuZUVuNjJWQlYvTFhBZGs1V25XVlFq?=
 =?utf-8?B?TnN5N3N2YlNVM3RCbjZVNkh5N1hLNUVLUEpqMUVnTC9ORTBRSlNJL1Q4RVR0?=
 =?utf-8?B?OHlhVkxOQzFZejluemdES2NoWUxnR2pUNUNVcWNwaVBQY2E2NHVrQllQOTZx?=
 =?utf-8?B?RDBoYzVHcitEamlyK2Q0MWl4V2xRdE83UDVzNXp6VStlSllVZ3hCTXJTS2Ro?=
 =?utf-8?B?bStxZkt0d3BGSzFhY0dEVU1KSnh6NU9Gc0drM0kzK095Qnl2V0VlSElodXds?=
 =?utf-8?B?QXJvRmdJelFFTEdHcHdkd2h6SnZQcjFjWUtoSUtDV3FpM0loVDl6a2s3UmlL?=
 =?utf-8?B?b3JxTmxXY3NYVmhwOHJscmg5Q3luejZiRTYwcU1ZM2IvMTFTSU8ybXVoY3FS?=
 =?utf-8?B?VEprQkxaWnBxblhyRHhZMWNRY2hQdWp5bHBjb2JWb25vczJCZGI0dng3Q0FG?=
 =?utf-8?B?UUJCb0N5SHRycTNSN0p6SHgwNStES1I5YXp2MlpKUm4yclYremlMQ3RlQWI4?=
 =?utf-8?B?amZaNm5FUk1PRmp1VnRjdlRJcFp3a253N0NmTmYvVDhIdUFDOTRwZXIyRnE1?=
 =?utf-8?B?Y3V5L09vWmNERkFkY2lVT2s0UUZaQTVRd3Z1RGJxZCtnNFJCQkcyelBtU1hh?=
 =?utf-8?B?Q1ltY3NXcWRZQ21MMmprZllvUVVTZzFzQ3U3Y3Frb29BZWhEcG42MEdyNkFD?=
 =?utf-8?Q?be7JA98GXOBposUEjHvH8Sw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6a0ee3-d9e5-42e5-472f-08d9af7d5712
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 19:05:11.7667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYSyyl/g//PmYTjOc/iTgesf9SMHdwwPBLLAkeTJD/NbmTKpcDWqvy94oXz0LQTcT1jqKiC9kbLYQUzIHXsp5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3906
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10178 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240099
X-Proofpoint-ORIG-GUID: feFzlZ3luvJdZM9AMmtSf2lef_6kTjW0
X-Proofpoint-GUID: feFzlZ3luvJdZM9AMmtSf2lef_6kTjW0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/21 02:47, Baolin Wang wrote:
> 
> 
> On 2021/11/24 3:25, Mike Kravetz wrote:
>> On 11/15/21 22:03, Baolin Wang wrote:
>>> On 2021/11/16 12:21, Andrew Morton wrote:
>>>> On Sun,  7 Nov 2021 16:57:26 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>>>
>> I 'think' this is OK since the behavior is not really defined today.  But, we
>> are changing user visible output.
> 
> Actually we did not change the user visible output for a hugetlb migration. Since we still return the number of hugetlb failed to migrate as before (though previous hugetlb behavior is not reasonable), not the number of hguetlb subpages. We just correct the hugetlb migration stats for the hugetlb in kernel, like PGMIGRATE_SUCCESS/FAIL stats.
> 

Yes, the values returned by move_pages() will not change.

The 'stats' in the kernel which are changing are user visible.  Specifically.
the fields pgmigrate_success and pgmigrate_fail in the file /proc/vmstat.
The values reported there for migrated hugetlb pages is changing as a result
of this series.

In addition, if someone monitors the trace point at the end of migrate_pages
they will start seeing different values.

As mentioned, these values are not currently documented for hugetlb pages so
I think it is OK to change.  If someone thinks otherwise, please speak up!

Making them be similar to what is reported for THP pages would be a good
thing.

>>
>> Perhaps we should go ahead and document the hugetlb behavior when making these
>> changes?
> 
> Sure. How about adding below modification for hugetlb?

Yes, please do make the below changes as well.
-- 
Mike Kravetz

> diff --git a/Documentation/vm/page_migration.rst b/Documentation/vm/page_migration.rst
> index 08810f5..8c5cb81 100644
> --- a/Documentation/vm/page_migration.rst
> +++ b/Documentation/vm/page_migration.rst
> @@ -263,15 +263,15 @@ Monitoring Migration
>  The following events (counters) can be used to monitor page migration.
> 
>  1. PGMIGRATE_SUCCESS: Normal page migration success. Each count means that a
> -   page was migrated. If the page was a non-THP page, then this counter is
> -   increased by one. If the page was a THP, then this counter is increased by
> -   the number of THP subpages. For example, migration of a single 2MB THP that
> -   has 4KB-size base pages (subpages) will cause this counter to increase by
> -   512.
> +   page was migrated. If the page was a non-THP and non-hugetlb page, then
> +   this counter is increased by one. If the page was a THP or hugetlb, then
> +   this counter is increased by the number of THP or hugetlb subpages.
> +   For example, migration of a single 2MB THP that has 4KB-size base pages
> +   (subpages) will cause this counter to increase by 512.
> 
>  2. PGMIGRATE_FAIL: Normal page migration failure. Same counting rules as for
>     PGMIGRATE_SUCCESS, above: this will be increased by the number of subpages,
> -   if it was a THP.
> +   if it was a THP or hugetlb.
> 
>  3. THP_MIGRATION_SUCCESS: A THP was migrated without being split.


