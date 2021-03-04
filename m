Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FFC32DB55
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 21:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhCDUrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 15:47:52 -0500
Received: from mx0a-00007101.pphosted.com ([148.163.135.28]:65464 "EHLO
        mx0a-00007101.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232629AbhCDUrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 15:47:36 -0500
X-Greylist: delayed 5679 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Mar 2021 15:47:36 EST
Received: from pps.filterd (m0166256.ppops.net [127.0.0.1])
        by mx0a-00007101.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 124J39xC024771;
        Thu, 4 Mar 2021 19:12:11 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2059.outbound.protection.outlook.com [104.47.46.59])
        by mx0a-00007101.pphosted.com with ESMTP id 372hkp2uuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 19:12:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwjlEmnXVChHpFjrGqfQjviyQw0MRcChDh9FF7sw97wdUsLzVhIE1Kla1UhRVac7tSQNhmDzvKHzwm7B+Ph7wwrjVcafTq2pwe6kzxfRQsr07BN5bGfCw27Xuc10HPHYcQYoiEjGRJ/eDT+1yNrB1bGg8JX8POPaTNTdvnf74zvx3dbwBPZlS0Fp4TZey54lZRjktMR8KaobYyzkXRzUWD+Ygnve/dOQ1MfURq5PWfT1EHm2HBZj2nuW4dt8AnEAMkQsIaKEH544rfKP6T2wSxpT9hUiIWdyFRKaVe32zUqvrwhi8KVHl3qzKGOSIRFNVT2z7sze+Zqj9RXjerEtsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nknBxp1xVNvEhLpkm+o/Paj1Si05uLdnzw4RswtmzhE=;
 b=l8WCgR/IDrJ+yAyxOcxs/2agjiwMaaWn8/dB4a4KpGRmTyHFBpbLhruVda+NDm525BK10nOwabo3DaJa8K70vo1cy1w0nxgwT1ZwAJ/YfcLjZqCyl+vWGfk4r0UR0blk63mB+AuGkOBGZJjZ6VzFCO5lRlZrTPunb/KubAY5QfWJCg9Lsa4t8Eh+N3oe/mF0CnKPyN2xkdhKI3EY+Nto3mptadJCVzSzAyoCKvvX0urN4ZUqTW7H/NcHowk8qFHq/OmOrbinZTqf4MRhIPMXOM8UWE4VX5EMyPoNCNhtB/agwGbcxzppiw3cLQuZIpw0eSH44+RVFBpdESMuuod1ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=illinois.edu;
Received: from CY4PR11MB1574.namprd11.prod.outlook.com (2603:10b6:910:f::16)
 by CY4PR11MB1384.namprd11.prod.outlook.com (2603:10b6:903:2c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 4 Mar
 2021 19:12:09 +0000
Received: from CY4PR11MB1574.namprd11.prod.outlook.com
 ([fe80::ede7:a197:fdbf:b6c9]) by CY4PR11MB1574.namprd11.prod.outlook.com
 ([fe80::ede7:a197:fdbf:b6c9%8]) with mapi id 15.20.3912.018; Thu, 4 Mar 2021
 19:12:09 +0000
Subject: Re: Possible bug kernel/seccomp.c
From:   Hsuan-Chi Kuo <hckuo2@illinois.edu>
To:     keescook@chromium.org
References: <83ebb916-20de-dba5-a5a2-c7f120ba7b21@illinois.edu>
Cc:     linux-kernel@vger.kernel.org
Message-ID: <84856991-dd5e-c2d6-0a0e-1c05097a1b86@illinois.edu>
Date:   Thu, 4 Mar 2021 13:14:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <83ebb916-20de-dba5-a5a2-c7f120ba7b21@illinois.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [192.241.58.140]
X-ClientProxiedBy: CH2PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:610:59::12) To CY4PR11MB1574.namprd11.prod.outlook.com
 (2603:10b6:910:f::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.14] (192.241.58.140) by CH2PR03CA0002.namprd03.prod.outlook.com (2603:10b6:610:59::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 19:12:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a91acfb1-a0b2-442f-8cc9-08d8df4168a1
X-MS-TrafficTypeDiagnostic: CY4PR11MB1384:
X-Microsoft-Antispam-PRVS: <CY4PR11MB138496C868F5417CBAFD60F4F3979@CY4PR11MB1384.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wPHixnenu1gFo2En5x9EnzUP8DaSZ+cReNCtkclMUivCb3P87LgtGd0Wn7tJnIRYND+TxZM67196CorX5JCJQNdEbXunDurvy/FwHIgFu0M1ava0N4Em6GBtASBQEv9PwwnpLbmR/nwwqHcAOvRXrVjJNZFyKn5Y486AQIRM7QavlPQgc+BTIOQCXl+Hi8P4Kg47Uvtip15W24MP0WW/Qz/pPPQNKsAhuH6urm/585XbYqSZBjCFyb7StEcxfvJNH1F8+dofP4pEjKwXMXCzSCQ/yLbOJ9BeadR2WMv36BWICs8YIBY3TU6r1DX75+0IdhYXSxJ6iaM3g4KfFsEjumShnFdrOrk+LE8mg+Q7S9IHMIbtxblhIzVps/Tw2GpKJUDHE2EKDrAdPuo/qIEz0td26UnMUX2pLoUtL78zRFm/RtOGnWvy0cqxnoSVripAP1fzS4922mHAG2KRDGumekqSAk8Jbl/VtmaCJP5zfga0/j+0K/0ye6fMOVeu+G2v+OorvWVSljj5+DsU7E/E+s3/nBQKAY6LjFap7qnYGX53L+WJgrssk0SVwA1KOJ5uodbOYuiutotctlS9EP1zwlwUEJKrFIdcK27lfsCVJTFrcLpSPErFq74pBTFXSEUaG4jKhXO8HSMVb6eWpiYgB9HP70OtwqlmmtsoWw/7ulQ+OP0fCXQtWRRNBEbvyV5f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1574.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(4326008)(36756003)(6486002)(53546011)(956004)(52116002)(26005)(2906002)(31686004)(6916009)(2616005)(558084003)(16526019)(6666004)(186003)(75432002)(8936002)(86362001)(8676002)(66476007)(31696002)(66946007)(66556008)(16576012)(316002)(786003)(478600001)(966005)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OUsyZGp1S1IwamNYblIxK3plNHVtYVUwSWhicFRyOFdRZXQ0aU5pb0wwMzQ2?=
 =?utf-8?B?cjd6RFppVUgzRWpCRHN4ckFjNTR0dHp6UWlUeEtiT2sxNzliRUdWTlU2ZFRp?=
 =?utf-8?B?bnBRaXJ4WDRBTVNoc0VHQU05K1dNRW4vdStmMGJ6NEd5TkFjN2I1MHNxV3d2?=
 =?utf-8?B?ZDdPT0NuWFVhb0Z6dUR0QlVDSU9oZEgzbVhVTjV4TlgrcXNUaXA0Z2ZoZmRy?=
 =?utf-8?B?M1Vra0lhRk9OejF5eUJIMU9UT2NpZ0lwOFJZcjcvWkFqTFhJTFF5aWpkVmRW?=
 =?utf-8?B?T3dQbkxwbVhlU3B1WWxVSGZ0aWJKYzUrSmxaTVNJWjJiTEc1QTFQWlBoazMr?=
 =?utf-8?B?QUN6bXNQVnQzSWJJM0EzSy9hSjZsczh3VWdNeHo3SHdWSThyaUdYMVZyYlc1?=
 =?utf-8?B?Qm42ZEJZdUEvRGlPTUdDYlQ4bFR3UFlFaldGTU5UMUZJRXROMGFMUG12S3Zt?=
 =?utf-8?B?eFRyRHZDY1FWeVNPSm9kaWpjc05IcnZtS2h6eXF3U25vT3lRN3B2Vjd0ampJ?=
 =?utf-8?B?RVFVK3VsRysxajBaWlJDNzNDYXl2a0VHNElseFVPSzhKRnU5QmVRRlB3K3pp?=
 =?utf-8?B?WEJCWmUremJOSkNkWG9IVVlNSlFFWVNWNHpyNVZxV1Urd3lNaUZZQ2RSWHpt?=
 =?utf-8?B?d1lqVUorZUhwQ1B1bTZkODM3Z043bHRZWjNSV0NpdXFBaGlYMWxiVm5CQU4r?=
 =?utf-8?B?bnZpRTE3RFhTZnNTblBna1VtUzU1Z090alU5bHYwVitJUnkxUkNwai94K1dD?=
 =?utf-8?B?d1ROamlyTWJsbUtFSnk0Z0VhWm1xL1c2aWRuZXJxY09nVlpNN0pCc0FlSGw5?=
 =?utf-8?B?L3dSeWprelR2OEZ0Skx2dWpTMktFelJZaC9SWHNHSzJ0VVdWK3hFdWJEcVY2?=
 =?utf-8?B?UmZTTFVFcmFCZ1IzREJxL3QxVDVtMW9FY1hMS0hiam8waVltNjEyQWg3Y0hW?=
 =?utf-8?B?RWNoSWxwQURWdmxVSmJKTlJ2TkRET3ZObWVmMmFhZDAzUGxIS2p6dnhobjNu?=
 =?utf-8?B?bXpBQkFBayt3YWs0bEpkNyt2VU43TkNncVA2dGxGK1hWVXZQclFBQ1ZwY1po?=
 =?utf-8?B?VXBtMlI2eHlYaXRaYk1uWlhwcEJneGY3bFZEL2ZMZG5YZjNnc1I3SmdSNlR0?=
 =?utf-8?B?eUg2OTJjbktoQ1k1ZXF0U0M0TXp5UEZWNVNtWkltUlY4NSthWVdZcnJvcThE?=
 =?utf-8?B?TzkwSWVFa1BwNGlOQXFiZDZFb1pUbUNSN09BRDVMM3pkMzJvdmZPL0tUVmJQ?=
 =?utf-8?B?SzFBcHlnMUIwZzlTU245TVUwbnNKQ05GODYxSDJCRTBlTlpjSnBqYVR3ZXMx?=
 =?utf-8?B?MHdHUHBMMTBtbVFDZ1pRYkJ3SWhsSGs4R0ltL2VXbkthS1pWcndSYmo2WUdG?=
 =?utf-8?B?WVZQdERaOW05TmJZdmFDQ3ZmZTFQRTc5V3JIZlVIcUZGSnMwSFZwbytNS1Ry?=
 =?utf-8?B?ZUppU0R0Ty9IbW13N0FLYjkxRzY2WGx1ZjFSUkhNcmxxeDMzRWlTQ3cxWWNJ?=
 =?utf-8?B?bXBNb0x5clVDZHJDUW5IbzJmTWYwRDVZS3N6N2tMOUQ3bFcwVWtycTRoN0lY?=
 =?utf-8?B?ekx3VzduT0xrUGRQc2RBU29VdnpiRUJqbXRYR3NtZW43VlYvdm1JYW1pYkhR?=
 =?utf-8?B?OVJGaHNpeDBUR0dZam1lYWNNWlVGbXdrMEtheG9oNlh6aUVQeDJyM052RDFL?=
 =?utf-8?B?NFVraGNVQkw0RTVnRDdOVVk3dFNwTjdxMjhEcUhzS0VaQWFaSjdORTJ2dmVo?=
 =?utf-8?Q?My8UXU700ZrFLKGwhjh+USdXar2gcP0bqr8yKVp?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a91acfb1-a0b2-442f-8cc9-08d8df4168a1
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1574.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 19:12:09.5510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SaM+VmezfCGBw6zO96XdI5mAH/ApzkuVJl7qwtA6HNY/+KstZJ0g1+hJfZPA+H4yzlC7WHApvNc6E0x1nYVOXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1384
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 adultscore=0
 spamscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=939 bulkscore=0 phishscore=0
 clxscore=1011 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103040090
X-Spam-Score: 0
X-Spam-OrigSender: hckuo2@illinois.edu
X-Spam-Bar: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc mailing list.

On 3/4/21 1:10 PM, Hsuan-Chi Kuo wrote:
> Hello,
>
> Should this line be atomic_read(&caller->seccomp.filter_count));
>
> https://elixir.bootlin.com/linux/latest/source/kernel/seccomp.c#L600
>
> I think the desired behavior is to synchronize the filter count.
>
> Thank you
>
