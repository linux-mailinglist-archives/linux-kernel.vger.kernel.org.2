Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487173598D2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhDIJJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:09:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60046 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbhDIJJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:09:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1398xhML190653;
        Fri, 9 Apr 2021 09:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=sgBSnx6lOZbbuRcpgV8VUlH7BQ1jGDjKIlfSYd8YJ9M=;
 b=mNy3TMm5qXwMTeRR0+7XfK+guvNlwg3SzJkWma2vYFoeMUIogrtzZRnsKb1+LqMDY7e3
 hLS9RRWeyh2XkNH1pJneEJez+CwOY7wLBr/FMwONiYDQVOACPGdVCejvsvnXazYBbU+7
 pqsLy3Hp/sVrsIuwhn4G3rVlNlAB06P6qvWsCk5m5RZxsb+WSUPVfTn/LvFzWKIshRic
 w3ZghtAYEnidiRquQB6arD15XJvgRWzXHOc3JvQdiGZ7gTZWwk6sGPTod2RBP7htBG6Z
 1se6UtZHxGSTfDe5vS915MyOaLXvNyIMc4sE1VUnVp6TkD+j4P7sr6CJO611LJ+xXP2q 6Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37rva68r6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 09:09:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13995D70138383;
        Fri, 9 Apr 2021 09:09:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by userp3020.oracle.com with ESMTP id 37rvb2ajem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 09:09:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGv0Ujn/NE14/x4IPrf8jPf8jz7lj/91h3cYnvHjVXGXL+zwIIFgxn6/YlIYIJdc9loIHUKcFrUqjWGN8MkzWsBW8ulYg3YeO6vNq48RmmBM5xkVB9tLbBhhOclWcSCaq10zCGXOSKql3ALIxFWYISDe0LmSpEImsfDSwVyVnNhzofzAZVeb+WcsizG6AVzyw76rBURLSguIOXTgwGSYS24739J7zqdefAAmRJSiKG4HUBgW5LZ14D+alaj6QQs4Hzt5Z0evhYrCOePGwv7WcqT6/WU2BkRCxupb8oNY8dcOpGPTgVTRkVNmaAOudna6sPFlMj4xe9ASjGqz09+bXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgBSnx6lOZbbuRcpgV8VUlH7BQ1jGDjKIlfSYd8YJ9M=;
 b=WgyAesn3sJbz5S7lHcB+eU444ia6LHpfQvp3fczyCym3+rpplD5CueQzA8iVTUFVHfZIZfz10hJkOw6oD/MOJYxlPiAiU/ll31y9ZDdwSIPvmK2fw32m6xITj91d/A5fc9AKQPNIcPwg3pLUIf+HCdqUdcEutXQppsOIeGVqu6uWuyD9UGrvs83N7Rci2l+5iAvIJixTCONvllK+3iEFNTm7yv4udVseU7601b50bTU8T9DG2C/HRT6cWLXjVaBDVpLnOZX81ESgUD8V6w8Ja3oK2r74HLonoTGUAVlCgJD7VTjrfKHncIt+10823ATk0Tq2Z7NZ++mtA5j72u3B+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgBSnx6lOZbbuRcpgV8VUlH7BQ1jGDjKIlfSYd8YJ9M=;
 b=uNOY1h0wDr+CcOJGZjh7F3SdPD8lh62C7PH42daDis1mCzde23eqL7eik6jRjSLZR4xrA5P5LJXDP8si+4DCXRm95uPJIjTuV5jcsHAS6xsPLQ2hhnItMi8afoMyQwzK7QjiMPVYvZB0F8nfVSrAKfjJ3vAZN8wC0ABx70061t0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4391.namprd10.prod.outlook.com (2603:10b6:610:7d::11)
 by CH2PR10MB4343.namprd10.prod.outlook.com (2603:10b6:610:a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Fri, 9 Apr
 2021 09:09:16 +0000
Received: from CH2PR10MB4391.namprd10.prod.outlook.com
 ([fe80::652c:d431:87f4:b6e]) by CH2PR10MB4391.namprd10.prod.outlook.com
 ([fe80::652c:d431:87f4:b6e%7]) with mapi id 15.20.4020.021; Fri, 9 Apr 2021
 09:09:16 +0000
Subject: Re: [PATCH 2/2] arch/x86: arch/sparc: tools/perf: fix typos in
 comments
To:     Thomas Tai <thomas.tai@oracle.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org
Cc:     sean.j.christopherson@intel.com, luto@amacapital.net,
        jarkko@kernel.org, bp@suse.de, jethro@fortanix.com,
        linux-kernel@vger.kernel.org
References: <1617902914-83245-1-git-send-email-thomas.tai@oracle.com>
 <1617902914-83245-2-git-send-email-thomas.tai@oracle.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <2f6137ec-8cbb-5766-8010-16c99fefbdf7@oracle.com>
Date:   Fri, 9 Apr 2021 11:09:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <1617902914-83245-2-git-send-email-thomas.tai@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [92.157.39.73]
X-ClientProxiedBy: PR2P264CA0004.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::16)
 To CH2PR10MB4391.namprd10.prod.outlook.com (2603:10b6:610:7d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (92.157.39.73) by PR2P264CA0004.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Fri, 9 Apr 2021 09:09:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9d49fab-d138-4ae2-d0c5-08d8fb372656
X-MS-TrafficTypeDiagnostic: CH2PR10MB4343:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB434395EC9D12F4CA8380A0AE9A739@CH2PR10MB4343.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:86;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IM3n1Nq2dlIVs28saCXHI7Psbgj7nfda92T+CXc1/Mm3pzSwB0vJ5x3OZa3rLdTeuA6i5Sdt5JToYUozjyBl/VeMH6Q2imvlFLvrB5Gxpk/5ww73ciblBgkpF3nRSv09GiV3/JRirHJCCDr9kuV4Co3DHWeW45DHMQtI5aw3jIhzI69rWGt2Jfk+OXoBKhhbrtkYImCxD5aQjbylKdjkYC1oPldgGysi0ALpGKrKbobRll91d6KZwjy7/9UT1EOATqnkza7Wa7t2WEc0BBIHwLQ6ULn4qJL8ri4o+6zIDzshaCFa02rZwcswdvUanH1WacB6vQ4CobMxLxjEOXAK1PelmArV4ai36Y1lg4+5dWNIhCxEXFejn8ePEyWmGlKCgLPWxEK0A6UmuRyYyAQzn2yLH+kUJOeCHWJmRzHRdnyLBUMsUNpQ8flGY5KS2Gx18zBk/wJg9x4QYOOX9RDY7ZIwUdKuNUTvelPgl7zH31+YFRR9fgDol2YiswHcEu089jZuGTCkdu/E6WDMdjO+Hs/yGUQuJX5DYwXSIKFKt//zPkUFSgeD9zDBYmnWn2DHjQGF4uMP6/eXn5IEsZKTcr4wHt7u/ycDi8RoXDa5XT02uLPlW1mLdOUIpFRuYkYdUcfBuAN99B6Oaa/yjHQOM7+I4mZ/RGrYxgVHbqjsWruWIbsdoUYTc2dI48EixtukjGPuARxByhtkvIAuFPzUTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4391.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(346002)(366004)(39860400002)(16526019)(956004)(186003)(5660300002)(316002)(4744005)(478600001)(8936002)(8676002)(66476007)(66946007)(66556008)(2616005)(6666004)(53546011)(4326008)(36756003)(6486002)(26005)(31696002)(83380400001)(31686004)(44832011)(7416002)(6506007)(38100700001)(6512007)(2906002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N1EvS29QTzY1S2VwNElzd2JYZGVtdlZHMmllZ3I5cHJmdHN0cjlLbXpMelEr?=
 =?utf-8?B?L3lUeEhDV1BWTkVJKzlFS3FUQzl1VzdVSHRiN0NDY2ozSlF4MnpNS0x1Vm5Z?=
 =?utf-8?B?dlhVTFNqc2VYQ1JzUlBvU05IMkxqM3FSYnZCNXBMY2J2TWgzV1dOS2dkWjNP?=
 =?utf-8?B?VEMxc0pFNWFRSGdmQlZoWDFvdkFVYVVDbU9pYmdRM3BUNk1aSk4rRHUxUkh3?=
 =?utf-8?B?WVprN2J5Y1JsUWNtZkV1c0FxSE1RWEMzU2V6bHNvMXlBdVQ0R0YrU0tQS05z?=
 =?utf-8?B?QjNFdUs3T3hOMHorYnJZOElGZUdtWlJ5WFRGUmVVWnJYQzJtS3Z3dExyNWRL?=
 =?utf-8?B?TkJxV2hHMld4bkhRV2NOWUNMZWplOFh5VmFMSXRUWWtwU3pvN2lXMlRad3kr?=
 =?utf-8?B?UTBYM054UUNHalNEc2RLUkNoRXJZdEFxNjQxTlRKY3N5NDJpUE9KaWp4OHR0?=
 =?utf-8?B?SUJWZmxBV0FBVUF0VEN3MGJlaXR1SnI1NnZMTXdFZWFIa0ZlaUZsSzZDWG5W?=
 =?utf-8?B?ZGowVENFZFBwa1dkMm9pdWZJOWVjMUVlSVZ3K2lyTkR3VE1vdTJ3eldyWXBK?=
 =?utf-8?B?eDczUWhaQTJrcUFlQ0xQVEJzOSsxRVE1LzBoWVRGY3RhMjFvSG9Icm9PTWtG?=
 =?utf-8?B?MFpzRFFBbW5nWkhva1ZSUERvMGo4VUVlTlUwb1NlZi9tU1lpb3pFNDN5em92?=
 =?utf-8?B?OXQ5MUdzMWJ6RVAxQm9td1FwanRzbHI3eHBxenJWZTJTZ0xxTEVZUE00Rlpl?=
 =?utf-8?B?MGwwbW0wdnR0OEUydE1DaTNTVXBpOVlxL2VFbzZiUFBWMWl2K3J2RFZkMFBE?=
 =?utf-8?B?N3d2K3daeDBrakN2ak9wcTMzYitUOHhVTkxqcWY5NnA4YU9qaGxMcnF2Q2hp?=
 =?utf-8?B?VS9wOWdYZVgxbnFMbXczTjZxN0hxb0s2S0UrQThyZGtqL0tnaFRzNkswcC9u?=
 =?utf-8?B?dlQzTW16MHdaa0M5WWhXcVRkMjFUZWpkMmk2OWJTOWl1dmpIazdwODVIcUl2?=
 =?utf-8?B?a1Bjb0trcU90Z05hOUNyM0pFb2gzR1RCcWg2SnR4TnI0eUJtWEpuZm9TcWcz?=
 =?utf-8?B?aUYwcUxRNUVFdmFyOGpPTERnQW02cWl1NkFLNWNqcFBKU3F6WUYvWW1rVTJZ?=
 =?utf-8?B?NzFCNklXSy9VUVpCcCtQUTYzMFhGMWk3TDVRSWhyUjRXRGxMYWRMWEl3TUQz?=
 =?utf-8?B?UkhFazVqbkhNU3JKTkQ4N3FtdUEwVXJ2RStCNHRHN3k4OWV1MllHOE9DTkc5?=
 =?utf-8?B?am1teENjVnRPdzRZejlWbERqR2Z2dnJSdjJya0VDSWRnUm5ST2FUTUF4MlhG?=
 =?utf-8?B?MjErQUdHNmV1c2JOQVJsVWlkeVI3ZExBZmlsQ1pkTDk4TFovNDBLeFloQnll?=
 =?utf-8?B?VW42YlVxSVMxdVA3NGczYytjeHE3S0xGNHRXL2RWWjZsVG44NFRENWNwS1kv?=
 =?utf-8?B?dWVnTjlFaTlQWjVWSjYrTy9GcEROMit5UGJleDU4MEpJb2l3dFNmOS9CU0p1?=
 =?utf-8?B?U3RvV01hcjB3U1lOb0hQMk53WmlkYWtRWmlSQWJqUWJEd2w1eVVIM3BjMmll?=
 =?utf-8?B?VkZ4V2NzYWhpMGErRG44Mnliclhod091aENGcTVydnp0dGdSNVFycDRVZWVh?=
 =?utf-8?B?ajE0bEFySHdJd29EcnVVb0hWSzFtdmFmZ25IRHBSelMvUUxMR2JsZ1R5R3B4?=
 =?utf-8?B?YzRLRlBSb2J6Y2Y1dyt0NnVYNjNJVGdRNWxsRG9pcCtJVjFDbUl4T0VYc21y?=
 =?utf-8?Q?ZQD9E/lPn2EomxgCIq9XhDGbbqdxT6wDxgj3RRF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d49fab-d138-4ae2-d0c5-08d8fb372656
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4391.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 09:09:15.8977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4GQ4y2C8ZXFrsfoybsFw1vEt09vI5mHN0yHDE0Ot8ElTydFONyVRgRxZGfqYwQCTrbrraeaX836dA6MdIu//xxFVKpNf20PB8VLNVmg5uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4343
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090067
X-Proofpoint-GUID: lVbp73AHT4CHEm6BErbEi9IAq7J52TnT
X-Proofpoint-ORIG-GUID: lVbp73AHT4CHEm6BErbEi9IAq7J52TnT
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/8/21 7:28 PM, Thomas Tai wrote:
> s/insted/instead/
> s/maintaing/maintaining/
> 
> Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
> ---
>   arch/sparc/vdso/vdso2c.c             | 2 +-
>   arch/x86/entry/vdso/vdso2c.c         | 2 +-
>   arch/x86/kernel/cpu/intel.c          | 2 +-
>   tools/perf/arch/x86/util/perf_regs.c | 4 ++--
>   4 files changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.
