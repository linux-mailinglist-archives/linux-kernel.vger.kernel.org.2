Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6974A397C83
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 00:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbhFAWpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 18:45:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52798 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbhFAWpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 18:45:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 151MYvAE160241;
        Tue, 1 Jun 2021 22:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=oTiKvHZX2mLKLuNgUV+ldV+3z26IIsI5Di/wZfdaTvQ=;
 b=uZo2fQKKgckjvEvp4JDiapWnbFNVYTHigYQZQaKBLS8RiLZUOzwGdVGWfj6dPmyqMKIE
 If1Kz9cOE4Kh+KRGjOgZ7i1nWJLvlgCuSgSXaa8fZqglshqZZe8zsNvTGA0iRPosGWIW
 OvIh5+PlGgwhAgErcS2/dAudySevCSwcpqw00KSbPnybUvXLICBhW3+UZ70Hs0MSn7zi
 1j2/DIWJ5Mcya/yNW78yYq9umi8JWLNH6xdc0uK+lu9sd3Hb8VsOnI8dVbQHuF9dewH4
 H2k29iuG6vCviOPoH64fyVANlnH+0gYZGdn2jLTNvUCbz4GBMwtqIBSPyu5xs3XByNZd lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 38ue8pev45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 22:43:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 151MebEx087409;
        Tue, 1 Jun 2021 22:43:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by userp3020.oracle.com with ESMTP id 38uycrrayy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 22:43:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUvB/OAd1BqpWEXMt3sh4qzCvETkMgYN1GW3S6qLdJmDl8XEI9yIwpF4XkDTcYIoWrQDz/n7HOE2QblHtyp/9Sh5W0tX6QR8E/xGzcqY0laiYW2IWbL2fYHRnT6zH8v5Gz+rEAyISPeafWrOPquPCSgM/8R9b9OsRvyQwCGP4PM1Jh4wkxtTJJ2ZmyqVuyHgg0M99MrhfurJbdfIm6kwpnW5r24uZ5risAfS7pzfg5WmZErOh9+ALIQkq/JHuwIoYUuSzcEBm0WcStU+m/nA6N7733C/NNwqRa/4a7mEJjOzrp6ixGQusZh2Eq+gIGRY2w+Y1HE39kLQ9qpEHI+Eqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTiKvHZX2mLKLuNgUV+ldV+3z26IIsI5Di/wZfdaTvQ=;
 b=OdGL08ktyV2DbwFGNaWA76Jnh/44ckh7fkm4WdhM3DHss3Y/jM8rNAhHoMm/Su5i224iLZW7VBzNTNImo3PUNXr498jcS9Mb5ArgKainZWwvKCVAd3UuUVLOlBzmbTYXqcfl/iUHUunieLebiREJIr3UaCuzKdQTf2+6hYBq68HoLtor3jLfaimnHDADqfE8vSnyWbds25oMU0ulhOT8u23YyEcql2Rp8wIArnAFLC5FSHtKH9plnq8cuTo+sGpW5hcRkwzkDFOtJ4RKBZbhGJrQJRLjcyFQZY4WjA72XZzbHttsfunV0c1DWzNF+MKO6XchPZzhOmD4KJLjXizT3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTiKvHZX2mLKLuNgUV+ldV+3z26IIsI5Di/wZfdaTvQ=;
 b=dryHEz14Jf6NYKvOjNMTi5F6GnNCoBHoiHRqQdZXrauOlXDLJVJCBbrB4H9A6eUytxWeXWFcZkilEne8zmXoKHeZroXA5pudc4fvI6Fzd/xo1yEPLAJp8U8lWxKm43nlmVy6oA3taslXxoOgvuMvVKGLWVH+dqNwJal3+S/CHLY=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8)
 by CH0PR10MB4969.namprd10.prod.outlook.com (2603:10b6:610:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Tue, 1 Jun
 2021 22:43:27 +0000
Received: from CH2PR10MB4118.namprd10.prod.outlook.com
 ([fe80::5d0c:35a5:182d:4517]) by CH2PR10MB4118.namprd10.prod.outlook.com
 ([fe80::5d0c:35a5:182d:4517%5]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 22:43:27 +0000
Subject: Re: [PATCH 4/5] x86/pkeys: replace PKRU modification infrastructure
To:     Babu Moger <babu.moger@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, luto@kernel.org, shuah@kernel.org,
        linuxram@us.ibm.com, bauerman@linux.ibm.com, bigeasy@linutronix.de
References: <20210527235109.B2A9F45F@viggo.jf.intel.com>
 <20210527235118.88C9831B@viggo.jf.intel.com>
 <0f98bc0a-3ee4-3fe9-f7c6-9c2b873bec38@amd.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Message-ID: <5617bb6d-2202-53f4-8b4d-7b3e72ca0158@oracle.com>
Date:   Tue, 1 Jun 2021 17:43:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <0f98bc0a-3ee4-3fe9-f7c6-9c2b873bec38@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [68.201.65.98]
X-ClientProxiedBy: SA0PR11CA0079.namprd11.prod.outlook.com
 (2603:10b6:806:d2::24) To CH2PR10MB4118.namprd10.prod.outlook.com
 (2603:10b6:610:a4::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.190] (68.201.65.98) by SA0PR11CA0079.namprd11.prod.outlook.com (2603:10b6:806:d2::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Tue, 1 Jun 2021 22:43:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 911b47e9-dc6e-4064-c88f-08d9254eabc0
X-MS-TrafficTypeDiagnostic: CH0PR10MB4969:
X-Microsoft-Antispam-PRVS: <CH0PR10MB496915BE66A99A3918AEA0C1873E9@CH0PR10MB4969.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZOorBWcxgWLEU/Kj1gODkM76P1TwZnWFpLi4F+PPSFe5O9Yp3ZzPe/NlndPh/w4u8k0wcyookRJfhW5152YfWTeuSIE5JxZLxNWPNVgR8W1IV6rVVWyPdAZIS9E6rUJRA7BIbhYn+f47791OvxIQa7OzgWaoCG6am5rKa4di0VP0GZqmQdg6oVn5jz53NzTuAhrHXlotyQGLQknGnQBwi6oCMyoJp6u0D9OHuoLFdFU366nWTwXmVCx+1jb1NcaOC27mTUmdb4oPgXI6lSG9lMknZg0fRODllruYwLJ2DtfE9huTPXWqFDTFsgX3fmQ3Kij7YYaKPXYqDrnUkxrJdj0S7n1s46sw8BrgpltvJk2PWqqYbGR+HAekjbgMe+Beaopw2LV3paEQhJWGsWrlAWiEWudhrxBqSxj0In8r1imyAhJ3NF7HO8JF3E07KjjbLOkunBgYreGRu6ld3/0wCE9n1f67SGbWs/FwULAzbtb+fjFFl+z08dagjkS2ylCtrWxcPXOWDbBFKAa6oAByMPZca4w4pIHFSIFcY/2RfA01y6Lr7Q3C3pcAvyipfFcOJaSVR4Yv4W4YQPj6kvZNR1IjD2H/caamZWzlG53/oAGGV/9VxqM0My8IBZA9bYDBSwVQo/OzQ6cqYsDZd2qV43PBBoNwP1iSL4I77hYEEg11JCoY50VE93C6hHZgYnwfsZnquLcgWwkMmb57z4GPkENdFGkGj7wwPtDDVGyuowc0lpRujVdCpmNGYe/XZda+Wy5NdEz1IEw5biXW/IOAM8ixyTexMDPPzT3kLMTxsDAm8xFR4sFrqAA8sy86HYRE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4118.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(136003)(39860400002)(376002)(5660300002)(53546011)(4326008)(38100700002)(45080400002)(31696002)(7416002)(44832011)(956004)(16576012)(186003)(316002)(36756003)(30864003)(8676002)(16526019)(31686004)(478600001)(6486002)(66556008)(66946007)(966005)(2906002)(86362001)(110136005)(8936002)(83380400001)(2616005)(26005)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bUJJY2Nwd0lTQ01iL25SVkhFaXVwL0xNWldKWlY5bnB3VnpmaGN5cWVGcEhP?=
 =?utf-8?B?N2xvN3pFWUhXdFFFSTFhdkl6U3BDb1JOM20rK3dUNERJSkNKQ3ZpNmR0UGFE?=
 =?utf-8?B?bjhiWEIraEs3MllNcTBjOW5WS0djRE5WQThZNDV5QzV5czBmdmxVdG1pL0lu?=
 =?utf-8?B?VzlNa2tQWC8vUXVIdUVVb1cweG5MT0ZOUTFYc0dJc1RFQUg3ZWt3T2s0Zyto?=
 =?utf-8?B?L2Q2a3ZWQ0dHaDk4RnEzcndOdzVEVUxGSk5Ec29iL3VkSHJUMnVPdldKQ2R2?=
 =?utf-8?B?QkJNWE1TOWdnNVgrODdMMTBmYkYrVkg1cGtPL3FGT2RnRjVQckR3UzBrNmZx?=
 =?utf-8?B?SDYvRWh3L1ZQbjA3aGw3UVl4SVpXQjlnVWZqdndHZDJhZ0hGdjRsYmRMMWhT?=
 =?utf-8?B?S1VhV3gyUGY1NHRiOU5Bdk5JT3I3Q3dadW1lWTBPb01EVXFDSXFjQXpqb2p1?=
 =?utf-8?B?WTZpeDEvdGpQbnFhOEE0emV1ekdCa2VQeU5RMGdqL3NnNjVJK0puNTRXdUlM?=
 =?utf-8?B?aUQ0Y0paRnhIUTJCTHlEV3NrRElhUFZLVjFTT1lqc1N6ZkN4SURGTkFwY29u?=
 =?utf-8?B?cmJPYVhvaWUyWkRxdVBDbjFxT3FrYlBFNjF1MVBjYittdUtiVUFXRFIvZXJJ?=
 =?utf-8?B?eHRRUmF1dHg3L2dnb0RQYTZ4TzhpSjlyM0Q1YUN6aWQ3RmdnUDBaMFFjZ2Uy?=
 =?utf-8?B?NnhGWjNWYlJZUy9yMUk1Q3l3ZmlLVzlBSTBYb3h6enlUbm56VVBYdjZNV0dB?=
 =?utf-8?B?UkdFcGVHcmJ6MlZhSXp6MWhzR0VKak9seTFTYjNCdHMxVnlRVWoxejNOZ242?=
 =?utf-8?B?cUtOV2cxZlNRQ3hLNExoKzgrZklzL2tXdzV2OWlNZG5iOHpqQXQzT3JzNjhG?=
 =?utf-8?B?bCtRWjFXMHA1VHZ4SE9lTkNQOHZ2d0RkTFA2L29aRmhxZnpwN2JmSTc2SUhN?=
 =?utf-8?B?c01QYXJGdVVUcnFKd1NwcFA4YnNnVTMvUWNxaTBFZUszY0lCMWs2aDlSTU1E?=
 =?utf-8?B?QXYxdGpCN1dDVmdDVSticXZqT1A3S3NLUy9TQ2tUK0VxenYwNkpraTd5bzRJ?=
 =?utf-8?B?WWU2MDZsR1JpSmo3Z1BUTkduMW9EbExIeE5SNDV4ZHZOdUNDeUNUZFpVTXZ3?=
 =?utf-8?B?UDE0U2xiUFRmcTBtcWtoL1ltbDVxR2VzcGVNZEI0VmU2KzVtSWxodE1Kb3NM?=
 =?utf-8?B?S3VBY0ROTWFJRDY4WFBsaC9mdnFja2lNL3dDMkViTzQ3MlRlY2RiRXdUZTNu?=
 =?utf-8?B?aHdLUVJzc29jdzBrYzdiNEdXOEJsUW42SXllVUMwY05wL0tRQWttSUcwVThj?=
 =?utf-8?B?aUNIS1BhQnBGVDlFMEtwaU51WVRJMDBadU1LU201STRBRUJkVHlxZjlLaXFI?=
 =?utf-8?B?RVF6Q1hmMm5ubTNIWEZJYm1WZ2ZVTVpyRVlXUkhzd0lza1VhNGV6VTdGa0Jo?=
 =?utf-8?B?N1hsOFN2MVdCMGtoWVlrTDBxZVBFN3ZMTnhCTU5hM0ZHZFU4THI0Tm1hMGgy?=
 =?utf-8?B?Umh3Y2pmc05jUXZidnNvbC9KTHhxNHpocG1JT0lkTVVqTnR5WkRYQnJnM2JT?=
 =?utf-8?B?NHl6Tyt1NU1CWG44RDZmc0R3WU5SY0swZmovS1hoWlFDNC9GK2lMVnhtdnMv?=
 =?utf-8?B?eTNGbFJoamhyYnhyWVM4UE1Ybm9kc1doWVl2N2N6SHdDQUVjT2NOQVZRMHJo?=
 =?utf-8?B?cVpiRE1hVUpRYko0WHhqSkRrai9pM1N3RE5SUWNzeEExUElGdWRscnlOc2VY?=
 =?utf-8?Q?jgI8MFwMBKiYQgRAJnrvvbi1pDi+B2azD08jw5c?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911b47e9-dc6e-4064-c88f-08d9254eabc0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4118.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 22:43:27.0692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3zDKdFkFkEnWKnCm3RVQQDSIyJnelhLW4IzbNUY9Jye1S7gDedBzuvYupOiAK8ok1NxdtwXWiqPzMwD4kG5UwEyCDlD9p1Ywc/lRzgaxv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4969
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10002 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106010151
X-Proofpoint-GUID: tdQNRi4ZX1Ic90zyTQJDZAiRgR0PJmmU
X-Proofpoint-ORIG-GUID: tdQNRi4ZX1Ic90zyTQJDZAiRgR0PJmmU
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10002 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106010150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/21 4:54 PM, Babu Moger wrote:
> Hi Dave,
> Thanks for the patches and trying to address the issues.
> 
> I know these patches are in early stages and there is still a discussion
> on different ways to address these issues. But I wanted to give a try anyway.
> 
> Tried to boot the system with these patches. But system did not come up
> after this patch(#4). System fails very early in the boot process. So, I
> could'nt collect much logs. It failed both on AMD and Intel machines.
> I will try to collect more logs.
> Thanks
> Babu

Same here. Hitting this line in arch/x86/include/asm/fpu/xstate.h

         BUG_ON(!(xstate->header.xcomp_bv & BIT_ULL(xfeature_nr)));

[    0.384929] kernel BUG at arch/x86/include/asm/fpu/xstate.h:177!
[    0.385529] invalid opcode: 0000 [#1] SMP NOPTI
[    0.386519] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.13.0-rc4+ #1
[    0.386519] RIP: 0010:identify_cpu+0x5ee/0x5f0
[    0.386519] Code: ff 0f 0b ff 14 25 e0 72 e4 bc eb 84 48 89 cf be 09 00 00 00 48 89 4d c0 e8 ef 97 ff ff 48 8b 4d c0 48 c7 00 00 00 00 00 eb a5 <0f> 0b 48 8b 05 01 3e b7 01 48 c1 e8 1d 83 e0 01 74 0b 55 48 89 e5
[    0.386519] RSP: 0000:ffffffffbce03e28 EFLAGS: 00010246
[    0.386519] RAX: ffffffffbce14940 RBX: ffffffffbd3c0220 RCX: ffffffffbce15e80
[    0.386519] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000770eb0
[    0.386519] RBP: ffffffffbce03e68 R08: 0000000000000000 R09: c0000000fffeffff
[    0.386519] R10: 0000000000000001 R11: ffffffffbce03bf8 R12: ffffffffbd6bcd00
[    0.386519] R13: ffffffffbd6bcd58 R14: 0000000000000000 R15: 0000000000000246
[    0.386519] FS:  0000000000000000(0000) GS:ffff91280d200000(0000) knlGS:0000000000000000
[    0.386519] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.386519] CR2: ffff924b3fbff000 CR3: 0000017261a0a001 CR4: 0000000000770eb0
[    0.386519] Call Trace:
[    0.386519]  identify_boot_cpu+0x10/0x9a
[    0.386519]  check_bugs+0x2a/0xa19
[    0.386519]  start_kernel+0x4c7/0x4fa
[    0.386519]  x86_64_start_reservations+0x32/0x34
[    0.386519]  x86_64_start_kernel+0x8a/0x8d
[    0.386519]  secondary_startup_64_no_verify+0xc2/0xcb
[    0.386519] Modules linked in:
[    0.386521] ---[ end trace 12db536e6a291746 ]---
[    0.387520] RIP: 0010:identify_cpu+0x5ee/0x5f0
[    0.388519] Code: ff 0f 0b ff 14 25 e0 72 e4 bc eb 84 48 89 cf be 09 00 00 00 48 89 4d c0 e8 ef 97 ff ff 48 8b 4d c0 48 c7 00 00 00 00 00 eb a5 <0f> 0b 48 8b 05 01 3e b7 01 48 c1 e8 1d 83 e0 01 74 0b 55 48 89 e5
[    0.389519] RSP: 0000:ffffffffbce03e28 EFLAGS: 00010246
[    0.390519] RAX: ffffffffbce14940 RBX: ffffffffbd3c0220 RCX: ffffffffbce15e80
[    0.391519] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000770eb0
[    0.392519] RBP: ffffffffbce03e68 R08: 0000000000000000 R09: c0000000fffeffff
[    0.393519] R10: 0000000000000001 R11: ffffffffbce03bf8 R12: ffffffffbd6bcd00
[    0.394519] R13: ffffffffbd6bcd58 R14: 0000000000000000 R15: 0000000000000246
[    0.395519] FS:  0000000000000000(0000) GS:ffff91280d200000(0000) knlGS:0000000000000000
[    0.396519] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.397519] CR2: ffff924b3fbff000 CR3: 0000017261a0a001 CR4: 0000000000770eb0
[    0.398520] Kernel panic - not syncing: Fatal exception
[    0.399519] ---[ end Kernel panic - not syncing: Fatal exception ]---

> 
> On 5/27/21 6:51 PM, Dave Hansen wrote:
>>
>> From: Dave Hansen <dave.hansen@linux.intel.com>
>>
>> There are two points in the kernel which write to PKRU in a buggy way:
>>
>>   * In switch_fpu_finish(), where having xfeatures[PKRU]=0 will result
>>     in PKRU being assigned 'init_pkru_value' instead of 0x0.
>>   * In write_pkru(), xfeatures[PKRU]=0 will result in PKRU having the
>>     correct value, but the XSAVE buffer will remain stale because
>>     xfeatures is not updated.
>>
>> Both of them screw up the fact that get_xsave_addr() will return NULL
>> for PKRU when it is in the XSAVE "init state".  This went unnoticed
>> until now because on Intel hardware XINUSE[PKRU] is never 0 because
>> of the kernel policy around 'init_pkru_value'.  AMD hardware, on the
>> other hand, can set XINUSE[PKRU]=0 via a normal WRPKRU(0).  The
>> handy selftests somewhat accidentally produced a case[2] where
>> WRPKRU(0) occurs.
>>
>> get_xsave_addr() is a horrible interface[1], especially when used for
>> writing state.  It is too easy for callers to be tricked into thinking:
>>   1. On a NULL return that they have no work to do
>>   2. On a valid pointer return that they *can* safely write state
>>      without doing more work like setting an xfeatures bit.
>>
>> Wrap get_xsave_addr() with some additional infrastructure.  Ensure
>> that callers must declare their intent to read or write to the state.
>> Inject the init state into both reads *and* writes.  This ensures
>> that writers never have to deal with detritus from previous state.
>>
>> The new common xstate infrastructure:
>>
>> 	xstatebuf_get_write_ptr()
>> and
>> 	xfeature_init_space()
>>
>> should be quite usable for other xfeatures with trivial updates to
>> xfeature_init_space().  My hope is that we can move away from
>> all use of get_xsave_addr(), replacing it with things like
>> xstate_read_pkru().
>>
>> The new BUG_ON()s are not great.  But, they do represent a severe
>> violation of expectations and XSAVE state can be security-sensitive
>> and these represent a truly dazed-and-confused situation.
>>
>> 1. I know, I wrote it.  I'm really sorry.
>> 2. https://lore.kernel.org/linux-kselftest/b2e0324a-9125-bb34-9e76-81817df27c48@amd.com/
>>
>> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>> Fixes: 0d714dba1626 ("x86/fpu: Update xstate's PKRU value on write_pkru()")
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: x86@kernel.org
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: Babu Moger <babu.moger@amd.com>
>> Cc: Dave Kleikamp <dave.kleikamp@oracle.com>
>> Cc: Ram Pai <linuxram@us.ibm.com>
>> Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> ---
>>
>>   b/arch/x86/include/asm/fpu/internal.h |    8 --
>>   b/arch/x86/include/asm/fpu/xstate.h   |  111 +++++++++++++++++++++++++++++++---
>>   b/arch/x86/include/asm/processor.h    |    7 ++
>>   b/arch/x86/kernel/cpu/common.c        |    6 -
>>   b/arch/x86/mm/pkeys.c                 |    6 -
>>   5 files changed, 115 insertions(+), 23 deletions(-)
>>
>> diff -puN arch/x86/include/asm/fpu/internal.h~write_pkru arch/x86/include/asm/fpu/internal.h
>> --- a/arch/x86/include/asm/fpu/internal.h~write_pkru	2021-05-27 16:40:26.903705463 -0700
>> +++ b/arch/x86/include/asm/fpu/internal.h	2021-05-27 16:40:26.919705463 -0700
>> @@ -564,7 +564,6 @@ static inline void switch_fpu_prepare(st
>>   static inline void switch_fpu_finish(struct fpu *new_fpu)
>>   {
>>   	u32 pkru_val = init_pkru_value;
>> -	struct pkru_state *pk;
>>   
>>   	if (!static_cpu_has(X86_FEATURE_FPU))
>>   		return;
>> @@ -578,11 +577,8 @@ static inline void switch_fpu_finish(str
>>   	 * PKRU state is switched eagerly because it needs to be valid before we
>>   	 * return to userland e.g. for a copy_to_user() operation.
>>   	 */
>> -	if (current->mm) {
>> -		pk = get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
>> -		if (pk)
>> -			pkru_val = pk->pkru;
>> -	}
>> +	if (current->mm)
>> +		pkru_val = xstate_read_pkru(&new_fpu->state.xsave);
>>   	__write_pkru(pkru_val);
>>   
>>   	/*
>> diff -puN arch/x86/include/asm/fpu/xstate.h~write_pkru arch/x86/include/asm/fpu/xstate.h
>> --- a/arch/x86/include/asm/fpu/xstate.h~write_pkru	2021-05-27 16:40:26.906705463 -0700
>> +++ b/arch/x86/include/asm/fpu/xstate.h	2021-05-27 16:40:26.919705463 -0700
>> @@ -124,27 +124,124 @@ static inline u32 read_pkru(void)
>>   	return 0;
>>   }
>>   
>> +static inline void xfeature_mark_non_init(struct xregs_state *xstate,
>> +					  int xfeature_nr)
>> +{
>> +	/*
>> +	 * Caller will place data in the @xstate buffer.
>> +	 * Mark the xfeature as non-init:
>> +	 */
>> +	xstate->header.xfeatures |= BIT_ULL(xfeature_nr);
>> +}
>> +
>> +
>> +/* Set the contents of @xfeature_nr to the hardware init state */
>> +static inline void xfeature_init_space(struct xregs_state *xstate,
>> +					     int xfeature_nr)
>> +{
>> +	void *state = get_xsave_addr(xstate, xfeature_nr);
>> +
>> +	switch (xfeature_nr) {
>> +	case XFEATURE_PKRU:
>> +		/* zero the whole state, including reserved bits */
>> +		memset(state, 0, sizeof(struct pkru_state));
>> +		break;
>> +	default:
>> +		BUG();
>> +	}
>> +}
>> +
>> +/*
>> + * Called when it is necessary to write to an XSAVE
>> + * component feature.  Guarantees that a future
>> + * XRSTOR of the 'xstate' buffer will not consider
>> + * @xfeature_nr to be in its init state.
>> + *
>> + * The returned buffer may contain old state.  The
>> + * caller must be prepared to fill the entire buffer.
>> + *
>> + * Caller must first ensure that @xfeature_nr is
>> + * enabled and present in the @xstate buffer.
>> + */
>> +static inline void *xstatebuf_get_write_ptr(struct xregs_state *xstate,
>> +					    int xfeature_nr)
>> +{
>> +	bool feature_was_init = xstate->header.xfeatures & BIT_ULL(xfeature_nr);
>> +
>> +	/*
>> +	 * xcomp_bv represents whether 'xstate' has space for
>> +	 * features.  If not, something is horribly wrong and
>> +	 * a write would corrupt memory.  Perhaps xfeature_nr
>> +	 * was not enabled.
>> +	 */
>> +	BUG_ON(!(xstate->header.xcomp_bv & BIT_ULL(xfeature_nr)));
>> +
>> +	/*
>> +	 * Ensure a sane xfeature_nr, including avoiding
>> +	 * confusion with XCOMP_BV_COMPACTED_FORMAT.
>> +	 */
>> +	BUG_ON(xfeature_nr >= XFEATURE_MAX);
>> +
>> +	/* Prepare xstate for a write to the xfeature: */
>> +	xfeature_mark_non_init(xstate, xfeature_nr);
>> +
>> +	/*
>> +	 * If xfeature_nr was in the init state, update the buffer
>> +	 * to match the state. Ensures that callers can safely
>> +	 * write only a part of the state, they are not forced to
>> +	 * write it in its entirety.
>> +	 */
>> +	if (feature_was_init)
>> +		xfeature_init_space(xstate, xfeature_nr);
>> +
>> +	return get_xsave_addr(xstate, xfeature_nr);
>> +}
>> +
>> +/* Caller must ensure X86_FEATURE_OSPKE is enabled. */
>> +static inline void xstate_write_pkru(struct xregs_state *xstate, u32 pkru)
>> +{
>> +	struct pkru_state *pk;
>> +
>> +	pk = xstatebuf_get_write_ptr(xstate, XFEATURE_PKRU);
>> +	pk->pkru = pkru;
>> +}
>> +
>> +/*
>> + * What PKRU value is represented in the 'xstate'?  Note,
>> + * this returns the *architecturally* represented value,
>> + * not the literal in-memory value.  They may be different.
>> + */
>> +static inline u32 xstate_read_pkru(struct xregs_state *xstate)
>> +{
>> +	struct pkru_state *pk;
>> +
>> +	pk = get_xsave_addr(xstate, XFEATURE_PKRU);
>> +	/*
>> +	 * If present, pull PKRU out of the XSAVE buffer.
>> +	 * Otherwise, use the hardware init value.
>> +	 */
>> +	if (pk)
>> +		return pk->pkru;
>> +	else
>> +		return PKRU_HW_INIT_VALUE;
>> +}
>> +
>>   /*
>>    * Update all of the PKRU state for the current task:
>>    * PKRU register and PKRU xstate.
>>    */
>>   static inline void current_write_pkru(u32 pkru)
>>   {
>> -	struct pkru_state *pk;
>> -
>>   	if (!boot_cpu_has(X86_FEATURE_OSPKE))
>>   		return;
>>   
>> -	pk = get_xsave_addr(&current->thread.fpu.state.xsave, XFEATURE_PKRU);
>> -
>> +	fpregs_lock();
>>   	/*
>>   	 * The PKRU value in xstate needs to be in sync with the value that is
>>   	 * written to the CPU. The FPU restore on return to userland would
>>   	 * otherwise load the previous value again.
>>   	 */
>> -	fpregs_lock();
>> -	if (pk)
>> -		pk->pkru = pkru;
>> +	xstate_write_pkru(&current->thread.fpu.state.xsave, pkru);
>>   	__write_pkru(pkru);
>>   	fpregs_unlock();
>>   }
>> diff -puN arch/x86/include/asm/processor.h~write_pkru arch/x86/include/asm/processor.h
>> --- a/arch/x86/include/asm/processor.h~write_pkru	2021-05-27 16:40:26.908705463 -0700
>> +++ b/arch/x86/include/asm/processor.h	2021-05-27 16:40:26.921705463 -0700
>> @@ -854,4 +854,11 @@ enum mds_mitigations {
>>   	MDS_MITIGATION_VMWERV,
>>   };
>>   
>> +/*
>> + * The XSAVE architecture defines an "init state" for
>> + * PKRU.  PKRU is set to this value by XRSTOR when it
>> + * tries to restore PKRU but has on value in the buffer.
>> + */
>> +#define PKRU_HW_INIT_VALUE	0x0
>> +
>>   #endif /* _ASM_X86_PROCESSOR_H */
>> diff -puN arch/x86/kernel/cpu/common.c~write_pkru arch/x86/kernel/cpu/common.c
>> --- a/arch/x86/kernel/cpu/common.c~write_pkru	2021-05-27 16:40:26.912705463 -0700
>> +++ b/arch/x86/kernel/cpu/common.c	2021-05-27 16:40:26.924705463 -0700
>> @@ -466,8 +466,6 @@ static bool pku_disabled;
>>   
>>   static __always_inline void setup_pku(struct cpuinfo_x86 *c)
>>   {
>> -	struct pkru_state *pk;
>> -
>>   	/* check the boot processor, plus compile options for PKU: */
>>   	if (!cpu_feature_enabled(X86_FEATURE_PKU))
>>   		return;
>> @@ -478,9 +476,7 @@ static __always_inline void setup_pku(st
>>   		return;
>>   
>>   	cr4_set_bits(X86_CR4_PKE);
>> -	pk = get_xsave_addr(&init_fpstate.xsave, XFEATURE_PKRU);
>> -	if (pk)
>> -		pk->pkru = init_pkru_value;
>> +	xstate_write_pkru(&current->thread.fpu.state.xsave, init_pkru_value);
>>   	/*
>>   	 * Seting X86_CR4_PKE will cause the X86_FEATURE_OSPKE
>>   	 * cpuid bit to be set.  We need to ensure that we
>> diff -puN arch/x86/mm/pkeys.c~write_pkru arch/x86/mm/pkeys.c
>> --- a/arch/x86/mm/pkeys.c~write_pkru	2021-05-27 16:40:26.914705463 -0700
>> +++ b/arch/x86/mm/pkeys.c	2021-05-27 16:40:26.926705463 -0700
>> @@ -155,7 +155,6 @@ static ssize_t init_pkru_read_file(struc
>>   static ssize_t init_pkru_write_file(struct file *file,
>>   		 const char __user *user_buf, size_t count, loff_t *ppos)
>>   {
>> -	struct pkru_state *pk;
>>   	char buf[32];
>>   	ssize_t len;
>>   	u32 new_init_pkru;
>> @@ -178,10 +177,7 @@ static ssize_t init_pkru_write_file(stru
>>   		return -EINVAL;
>>   
>>   	WRITE_ONCE(init_pkru_value, new_init_pkru);
>> -	pk = get_xsave_addr(&init_fpstate.xsave, XFEATURE_PKRU);
>> -	if (!pk)
>> -		return -EINVAL;
>> -	pk->pkru = new_init_pkru;
>> +	xstate_write_pkru(&init_fpstate.xsave, new_init_pkru);
>>   	return count;
>>   }
>>   
>> _
>>
