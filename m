Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF1E3598A6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhDIJHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:07:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58224 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbhDIJHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:07:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1398xriq190716;
        Fri, 9 Apr 2021 09:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=FShP8rburMB8OG9zJ56ss134JLHbF60R/4eBRaoqQss=;
 b=x2ch6pBwX7s8b5D4Xdyhz+4zUTEhR2UUbUGfV7zRStKvGP23njuK+s24o+EUACy1foXe
 RYTO7kuHUACYS7s2aAwmgxnwDGdQWb0qPoPya1MoI7U0riqjx/3UuQYWHi3rl6G/w1Oq
 PD+lmZoqmEUsJ6y48Drhb+65FCrkFQmF6LkTJYQndKu/ApvvHfpuFstaR9KdWOF4ZRMX
 OeG4+Pxj9U72LGu456R5+tL9hLIReEqux7EeG4fxsG9CO6UMQxf/zD106tJ4sSAKqGkP
 17RB//QjEoz3i7PdML395Ap1WC3DQ6LJJAwlRrNCXSQKh0dB/sP9WdVhbyaltbzPapPM Gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37rva68r0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 09:06:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13995DYg138484;
        Fri, 9 Apr 2021 09:06:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by userp3020.oracle.com with ESMTP id 37rvb2ag79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 09:06:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PH89+b68yLeu8fV7zLMhTOr/Kykjx7Rt7w1tDJEC7CTiJGSPFQfo2EoF7ipHW9+/QNZwNgkd/jJ4Sqmp2mzZnrh/stXSJmltkXhN+7iZg8nN1aK86lwi1Y6N5vvAwle3ICmHFmy4ZVmVI3YueLGZ2j3E1nj3PFREzz6LGR6C/4J53xPCLxUHyBR53haPQUm148FsR3bm1MVkfjPWF5wJmxFOHpMAUXvaa0i+hCLj8cg0Suekt6pZEEu+kC8fW1SjzopXFfm3OcSKuPBfg/lmYk7ezKmXeTGdgB4L3qdEyhd8e7NdgK+kyWm1P0nBqwbPBStASZuWdhQJHa0/Ilyyvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FShP8rburMB8OG9zJ56ss134JLHbF60R/4eBRaoqQss=;
 b=H5yI3s3BCL2uPeweYctNmVu+NOpWmb7iegjIeVndEJz0y1fswxmPCogM7gS/QO75Sldb7kDvUBw8Gta50M3V3zmrkXMkaw4GZMDxzcaqluN/K8/pNzdkmdSR8VGKNgeWAafiqdn217yr8jYHrPyLl6oLlRQ1Otd672mCKNkx2ULWjhno6vzPiOxO3VU80p9XmNQsjYDZQ2rGiLxjAUTtiNdHehgiDyEiyCXNqVS0fJrh6YpAamWVdneQLRZ+RHV6CoHAAK3G2XGILOlNt2btY+/gSdfDVzJMVkpR2+F1Ry37IuDpTONtH7R9uSZqsTypGGhh27Aa8PxNzvFlWdZ96A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FShP8rburMB8OG9zJ56ss134JLHbF60R/4eBRaoqQss=;
 b=WYYQECDBSAZXZswXK2Aj1zGgq66JlCbqOlyCFDYPBzJ4plEVBPgqIeikOfmXgkdIxhvpKGT1684A1IHsGLO8esyVOP0fQTkFyr3rqFWIHTeyYM6/5DcPGKPF6Z3EKupBEHvR0TenRvT84vgZHUIGchcOKpcyrPUg3kuclJZqsf8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4391.namprd10.prod.outlook.com (2603:10b6:610:7d::11)
 by CH2PR10MB4343.namprd10.prod.outlook.com (2603:10b6:610:a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Fri, 9 Apr
 2021 09:06:23 +0000
Received: from CH2PR10MB4391.namprd10.prod.outlook.com
 ([fe80::652c:d431:87f4:b6e]) by CH2PR10MB4391.namprd10.prod.outlook.com
 ([fe80::652c:d431:87f4:b6e%7]) with mapi id 15.20.4020.021; Fri, 9 Apr 2021
 09:06:23 +0000
Subject: Re: [PATCH 1/2] x86/traps: call cond_local_irq_disable before
 returning from exc_general_protection and math_error
To:     Thomas Tai <thomas.tai@oracle.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org
Cc:     sean.j.christopherson@intel.com, luto@amacapital.net,
        jarkko@kernel.org, bp@suse.de, jethro@fortanix.com,
        linux-kernel@vger.kernel.org
References: <1617902914-83245-1-git-send-email-thomas.tai@oracle.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <20435165-ad96-ef85-5b3a-9ca88cac64f1@oracle.com>
Date:   Fri, 9 Apr 2021 11:06:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <1617902914-83245-1-git-send-email-thomas.tai@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [92.157.39.73]
X-ClientProxiedBy: PR2P264CA0005.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::17)
 To CH2PR10MB4391.namprd10.prod.outlook.com (2603:10b6:610:7d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (92.157.39.73) by PR2P264CA0005.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Fri, 9 Apr 2021 09:06:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 194b2fd6-268d-43c5-251c-08d8fb36bf2e
X-MS-TrafficTypeDiagnostic: CH2PR10MB4343:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB43433D7C5A5891651373C2D99A739@CH2PR10MB4343.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ux9nY1LaTZCccFiwCionO3imsmjE/sOli5E0JUuvuXcaZ2dcnWlb2a1doQq8nZo+3K9jfIg75KrPxCOmZHildMorUCsJSd6QNeGyOBQsA3Q23d6Xz3Y/lWMpAnoWMUnT2K8dNHutKktvvjK/e67nJA+nA0xlXfb0ErZ1xVb8RziDvnorKWcoh395dT0cu/DYXBdz8aqeFUSo4TRYcS7ttLIhMWY3N94DMrWjVApFaupyyozi5h/6IkEWZhhG1x0LZexYWF3ua5wF7mztu0KQBv7u/vEZbICyPOHNDooGVwhfSyKZL5tkUMi+z2OK7wuzx1PT8TegM4ikWIEzXjwe9DpdNQ/89z6Dv3jsSO53PK5HzBUi3kYG2cpxAAqlSVAd60JeqYwX/ERldMb+E6Ccv2ylz/1plNp5kb0Rexy39I9xDltT9IZz4ncKTApGBa0ltYUT/ZCyQbYioT+lWOtdafxPBB3O3OdZi11CuVuY1j3W9ju837l02xv94no27NPPBzYzZvAYt2/Uglk26ygXdIHN7Fa/cFignpDzcZON3djEfHSN469DL4xCE5rXmTX3QVUzu1Bxpq5zp85lGzOyJa8PaVjGbpnvtlee5Mnj3khwksFX4rkPELBGDWJQq7QFKUHxWn+Lg1uoNMtxtyVhWmCwLhICP8FDUqlQz6dwzUCoNT8sPZhhikInihWdF2O3j8KKq5cCsTqvl6kM2f1IJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4391.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(346002)(366004)(39860400002)(16526019)(956004)(186003)(5660300002)(316002)(4744005)(478600001)(8936002)(8676002)(66476007)(66946007)(66556008)(2616005)(6666004)(53546011)(4326008)(36756003)(6486002)(26005)(31696002)(83380400001)(31686004)(44832011)(7416002)(6506007)(38100700001)(6512007)(2906002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Rjc4UDliMnFDSVkxWWVHQ0JPaXV0d2pqQ1N1TDNNdTR5ZWFGQzhkL0cwYXd1?=
 =?utf-8?B?d1RxMCt4aTc4VHpQMGtZUTAydUhiSUdYYlNjTU1xTUtvSXNvOGJvV0xXTnRm?=
 =?utf-8?B?dWJmOHM4YVNuV2xNdU42ZzhoK05GQlRFR1g4RHRBc0tnSkNlWTZYSVpvQWtL?=
 =?utf-8?B?aS93YmF3b3N2S0hPUGdBTUNaUUxTOWNuRkdYYk5GdzdFYWVmZFlvR0tjOWRS?=
 =?utf-8?B?eGlSOEFzd2J6Mlc4dFpuanREamd4QlVrZmFyYUxkL1lqSWJ2SzB4Z1pZTFY2?=
 =?utf-8?B?UjdtUjY0R1dWVlF3ZlZDanQzd1VsMHRBdlBWWFJ2SDNnV0ZtNVNrZjh3UDBR?=
 =?utf-8?B?TzZYUUtWdnZ0Ykc5VG5pM3V6dnBtMk02TU56c1JZYVZ0Z0d6dWcxRXBuQjlp?=
 =?utf-8?B?VVE1eEdHbk1EbEdiQXk2SGlZd3A4WmUyRkFGekhVR2JIblkwRWYwTG5TU3or?=
 =?utf-8?B?MS9DdVB4ZFZkQzVUSUhBMWtZNXhSWFNkTktlSzYxMXJTODVZWXRvVmo1NjVi?=
 =?utf-8?B?RTN1L0pnL1JVaEJVZ1lUNkFLaVpvNkpYMkNjUGhROE4rTEdCUFRGUGIxZk0w?=
 =?utf-8?B?Mll2cGY3UEozclJocjRnMFhYdVNtVEN3LzAzTUNDdWJPTXIxSWJaUndtSHE3?=
 =?utf-8?B?ZThiQWJQVndvTzdoSWFEMW80bVdMSUtJZ0djM3FoWmNZNWcwd1FlTHpFVUVR?=
 =?utf-8?B?OHdOMWtwc2JPemNqUHJMcWRlQVgxQ3F3dVBENElreHI0R1N1RnREUnRSVDI1?=
 =?utf-8?B?UkdMcDhCemJKVEpnRktvYWZhaG55blNpR0R0Y3oraElmYTlxZmhFUkoraEsz?=
 =?utf-8?B?TitrL3dua3FvY0ttVEdmZ1h3VktYd0FVNE5LL0dFSnhqUHpYOWlQVStGM3BV?=
 =?utf-8?B?d3o4Sy9HOC9jLzF5b21OakJyYmlBSUVaV2RKbENZQUlEZC9Ka1FHMmJLN1Fs?=
 =?utf-8?B?WUx6dmVNK25ac3hEQ2VVdnJZK080WEliU042YlhVV2tmMWtlRmhtZFdJU3dP?=
 =?utf-8?B?aUJ1dEJic0hybk1HR05jdGNxZDJBVnlPeGZibVlpQmdKNmEwa0lwR1dPNThJ?=
 =?utf-8?B?TlJWZ00yOWtCNXphYmFYMGlhL3UyUGRVWmNubW1ybGJrT3ltTDA5dlhzSzlO?=
 =?utf-8?B?bzAvR1AvMmdaaDBDT2dBNXhORjhpbzZxMUVlaFVFZ1RORzJRenBuemVGcU02?=
 =?utf-8?B?b3kxQWtPQk9KNVJyWFBaSnlINDlnYXlCU2ZlU3Bjd3JpbjBwbVEyWUtKNmsz?=
 =?utf-8?B?bWk2Y1I1ckl0TWg0MitFSmUzT0lIcnYxVG4remhIYjhXK0FkbFUvc1V2NTJM?=
 =?utf-8?B?Qlkzb3htcjhIN0dlOFZZRDMyWGh1YTV6SGw5U1FGTk1jc21XazROOXhBRklk?=
 =?utf-8?B?RGFhNlBUZXdyS0d3SWRRazlZZ1RNVWU4dmpRT2xFVjJoeTdSc3R5cUtUUndk?=
 =?utf-8?B?WGlCVnl4bU5udC9YWmV2cyt1dit3UGFZYytHMmtycFRsaUJDM21YQzNoZXlW?=
 =?utf-8?B?MDAxMEZsWTRZdDZML09rOG0xWDE0cUZkUWhPN0c5aW1ZOVpLeXlsaVlqcmpt?=
 =?utf-8?B?d0ZkNVhnL3hYb0JwT1NpMVJyMWpaR29vZFFwWnNYVnZtdTZWYmRjeGZiL3J3?=
 =?utf-8?B?dDVsREZUOWxpemRSaGg0UmR5a3g3S0w1U3ZEWlkrUElVYUJVU1N2ZThyTXUv?=
 =?utf-8?B?U21EOFMycWxxekdaTGx5Vkd2WTNmVFhSVG05UzJLYm1yNERCT05QeUVHanAw?=
 =?utf-8?Q?Qg2KyzTI5Dl4Itr5ir63gM0g2Uz/V52glCnkCn8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194b2fd6-268d-43c5-251c-08d8fb36bf2e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4391.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 09:06:22.8467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWs1rNlycEC5l4GL4UN+H6r5yzIrLOhRRkpLFVlUQHimR4NRQ2r/1n0ps5SM/ZBk8wxuXYPj82rbzCrJZ1aqB41oKr+OF9OlXLoqBcFxOOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4343
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090067
X-Proofpoint-GUID: LWTJFHoQNB86JX1iX4yPzCmE3N3jU4FT
X-Proofpoint-ORIG-GUID: LWTJFHoQNB86JX1iX4yPzCmE3N3jU4FT
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/8/21 7:28 PM, Thomas Tai wrote:
> This fixes commit 334872a09198 ("x86/traps: Attempt to fixup exceptions
> in vDSO before signaling") which added return statements without calling
> cond_local_irq_disable(). According to commit ca4c6a9858c2
> ("x86/traps: Make interrupt enable/disable symmetric in C code"),
> cond_local_irq_disable() is needed because the ASM return code no
> longer disables interrupts. Follow the existing code as an example to
> use "goto exit" instead of "return" statement.
> 
> Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
> ---
>   arch/x86/kernel/traps.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)


Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

And it is probably worth adding a 'Fixes:' tag:

Fixes: 334872a09198 ("x86/traps: Attempt to fixup exceptions in vDSO before signaling")

alex.
