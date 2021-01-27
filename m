Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03A6306389
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 19:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344102AbhA0Spv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 13:45:51 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35476 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344041AbhA0SpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 13:45:16 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10RIZGXf077862;
        Wed, 27 Jan 2021 18:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=V1napH+qFCyPVYTFyuECdULClaq92A9Ccs5yEfD7R3w=;
 b=iBKVESIxFZPukRKghAUErj72oBNZMhnYtF9C0gPJ0nNHRISwm6+fDe0LROZTDUvMxntq
 IDRn0a9LK3lGOl0o5WK49PHawIJgBgoTYFrvepz39BRhqEEHa1tXgmWPR9mCoQBefI0p
 nYDRTK8/ZiqjNQBjofwVJGQRFuOdt7k4zQT1x5og46doBQItSfgjRbHvjksPz/Ezevz/
 ppiIswLVrKIfioD1tZncCc+ekK3EcIdYibhxaYx335wTGKIqTMvlb7X2lV8cnZbyE444
 GLZo9u2cFss1CGjmlnrv5+npOFV8YY2QyNVGNugVzroFdc/lxxuhw7gD2fUsL+XC8nHQ fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 3689aarvn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 18:44:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10RIaAOO051828;
        Wed, 27 Jan 2021 18:44:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by userp3030.oracle.com with ESMTP id 368wqy7cy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 18:44:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9zTuBIfXlh95vraqLxR8FHNWsG9tSgzm6Tc35+2JF3+72qCwODGgAU0Fjp3E3Bo7+MtN4DCxZB/VRHwplmGHgY5wf6zgileQGFcpXzBcvcwrX1g1c5x5NZ8UJFg7hI65qA+9XaLsK5TKhy2mzrZy1gDJn06kxMM6NY+C4Yv+6f4JL/bXynp+p4ihcXfeDUFFKt5xK0xxPtqPScMvjRhQAxiptidgdV0/QwBRmR/F4xW0IwKWly7R2wKvci5Hwly44F3VjbfcZXW9K2SqeCuOnRqSp+eufn3yCt87Sl5XgLkgzZpHHSCyqllhzSWaNnDWTg0KRO9XQjlRJW29xhutQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1napH+qFCyPVYTFyuECdULClaq92A9Ccs5yEfD7R3w=;
 b=GnNVkghiBcleMQek3bHL9IWmaF/pXIKseCvf4U6ahKKtlhvQmAIi/ZP1teWDqVeoHiJvy8NUdkDJscFipkI794Sw0BtaPa69c7AauOhfozlXEJpNaw5txqE91jY4RrbB/H7tC4fPufwEcwZSPMh8YKecrucCjK6N1B4AQd5Ej5vqMBotqvF70DYf3SKnsLaQE1Ezs756LHa5bWW4G2smZcZZ9ehlgagxlUOdw52pwqEYRqeFK2vqwN+eh7vWq02KGYh0EOMyTDvOstBVrgUV0TisEdilcrzzyr7fGcL4deJOJKX0XNEQIkAeuF5wXcibgPTHe4/dIS+1F/2qinmy6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1napH+qFCyPVYTFyuECdULClaq92A9Ccs5yEfD7R3w=;
 b=KQjt6LRDUKk2crN7Di2ggh/mQgZwvUfmp8WNqjOe+I/QyRhPfjfy5zJIghQQ+GYSKv5I7P2n2MOKkJSuZn/gPK66q6i1ZOGZ7QpI4SUnPp09urXLApc48oVE9VznDDWxcg9LtH05gk65nKIfmkMeJ+qFclQ321VgysULjF4zGGg=
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB3906.namprd10.prod.outlook.com (2603:10b6:a03:1f7::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Wed, 27 Jan
 2021 18:44:26 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 18:44:26 +0000
Date:   Wed, 27 Jan 2021 13:44:18 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     George Kennedy <george.kennedy@oracle.com>,
        kasan-dev@googlegroups.com, glider@google.com, dvyukov@google.com,
        aryabinin@virtuozzo.com
Cc:     pjones@redhat.com, konrad@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iscsi_ibft: KASAN false positive failure occurs in
 ibft_init()
Message-ID: <YBG0glwiK1wyJTeN@Konrads-MacBook-Pro.local>
References: <1611684201-16262-1-git-send-email-george.kennedy@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611684201-16262-1-git-send-email-george.kennedy@oracle.com>
X-Originating-IP: [138.3.200.30]
X-ClientProxiedBy: CH0PR04CA0084.namprd04.prod.outlook.com
 (2603:10b6:610:74::29) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (138.3.200.30) by CH0PR04CA0084.namprd04.prod.outlook.com (2603:10b6:610:74::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 18:44:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5db7d6f0-49a0-4892-320b-08d8c2f39215
X-MS-TrafficTypeDiagnostic: BY5PR10MB3906:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB3906F728FCBFA20D31D90E7589BB9@BY5PR10MB3906.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jbeqTd14ixevsjLwOYHUcDSP3ZTxI55FmN/YhPpF50qloQWXpg5cf2L/X00Uih40A4pKM9HGHhjgp1/Ck5Dn3nnt6fSar8RF0Pa4vUKAu3yit/ogqcy+WgPlmvYgFsT+wL3QNXu5IWEFpHdbwlO3tmtT5diFEsg+KWeOhWS1e7kWgA7UQlwHBUyD64kGmAhiIujFjN9PP2G2eoKEFB9vNRJB6rpIp8R4hUK+TlF3JczGV6nEIwQUjdqHWe1s8BA188rIA46iaMt6chGjT1o3LgFyXJLCPAz3CWA5TkA2F5XswstVKCKVWSu1PQBuUHigifQLZKsSdY77yRQWjvsNtA6U7FeBVVOpxMjVsIvq6ocFjzmaxW8I8yanVrdNFyYBs/5123lzOsmKEjuf5fIRH4VkJX4SQDzlel+NhCNPkJooVWODGno2YrabDCZ37Vz9DnCb/yOEzHS3Rl0Hg3YU7Hj4887rprxhrfJgA8Sv5CVgg0Ier60jS4vEmAio6XEWgdn11ib5/NRwzEmOPMxtpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(376002)(346002)(396003)(8936002)(9686003)(5660300002)(7696005)(52116002)(4326008)(83380400001)(16526019)(186003)(316002)(26005)(8676002)(956004)(2906002)(66556008)(478600001)(86362001)(6666004)(6506007)(55016002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YOft0t3hEaWEP2Mc9WeKeMqZYhI4heIcfljeoZ49qB1ipTXLScmWEUzw6q3z?=
 =?us-ascii?Q?qt+/Z027749lftMYHWcaFG2eCyqKjLOHa7VRlyCKKZ6pTwhbxrxjlCHCHMFq?=
 =?us-ascii?Q?yvmWhixtqyPDrRm8XCnTe+olXinMXybpry5/l1W4pSV5zcltoAGDHdSpjcS8?=
 =?us-ascii?Q?g89q7U7RG36VpQl/3E8tHYeMSTFM3+qAO3AurDgrvHpN7yMN34noLJSbSYi3?=
 =?us-ascii?Q?FYr+hlIP14IYoWKIGcVmWRuCtsw1ExErVZESU07SBn0wsKESQJVX11m0DEDE?=
 =?us-ascii?Q?Auy9olIiOZ+b0VLqtiuz82GVB+yEPLDVZqclKUdecnk85uqnvxEbSSoMc7X5?=
 =?us-ascii?Q?cExZXcGFaxnhlx8gG/3Y+sRUlfXvBZ0B43ihmFSxCAFH3qUElItG8KFxgchB?=
 =?us-ascii?Q?sNFbcuGWNS71gpAewA5QjxZ+bprC40pTtXvwoVjJQlB8tEOPDQ5fzuyYz44r?=
 =?us-ascii?Q?iqxAe9SRUef601CydmonOFdvByEjC9RfZjGdo2mcknCd1qTgALLOBOj/Jdq2?=
 =?us-ascii?Q?FVw7qAQwStPmzdNy2UGaWJFZOOedhnNMc5VhY+7OgdCbRiiZZXm/8+t91z3a?=
 =?us-ascii?Q?uMODjmpZaXZ28eoFOHhdd7zmiOOYOoKtGEfaNkEuGzgNGEfBatzdehEkfp0i?=
 =?us-ascii?Q?xq9jxpBT6qeKzvnhUvOApqZ8Rhmj2yBrzt7sbibPQVUhYCLx+axXRyW6kH1I?=
 =?us-ascii?Q?CiGi/DzSKzxR8avrRHBZi9t9T5NjkICnE77s1iMtNEdaqGKIRh/abuYosRfK?=
 =?us-ascii?Q?cSDHLT+BBjPwDf+UMEDQbTojr4SJCE4DuszYY32yRSaIB033Q0WrtaDwuVlX?=
 =?us-ascii?Q?S3tar9oC1OPOsN7ElDGIJnS9U2CO2QibToybEjwHOtymaF71M4K6IgfAtGc5?=
 =?us-ascii?Q?g4Bjd9e5GJR0KpTAuSNEIrLou6Tn0peuLA1VV84yDTUo+GUoviNjUlqtX71x?=
 =?us-ascii?Q?Zv58j+b6LazOiLy58T3ilwnEmLGXRGwmlNV0yA4E+ehC9ajmR+E8Mna5hGiF?=
 =?us-ascii?Q?B2yK4VsP3/dpvXYL2ao484QQ2EnXEDRbPfB0TjiLLUQBt9SI1PGybOiTu+2r?=
 =?us-ascii?Q?TbWFIYYA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db7d6f0-49a0-4892-320b-08d8c2f39215
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 18:44:26.0487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4wBBJFJwlcH7aALipQ08l5NOUyXf8i03wJEWwXhc926/G2YeyUF8/hCEfLCayTaakFV7800A8NJH+8jAOH1DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3906
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101270092
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101270092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 01:03:21PM -0500, George Kennedy wrote:
> During boot of kernel with CONFIG_KASAN the following KASAN false
> positive failure will occur when ibft_init() reads the
> ACPI iBFT table: BUG: KASAN: use-after-free in ibft_init
> 
> The ACPI iBFT table is not allocated, and the iscsi driver uses
> a pointer to it to calculate checksum, etc. KASAN complains
> about this pointer with use-after-free, which this is not.
> 

Andrey, Alexander, Dmitry,

I think this is the right way for this, but was wondering if you have
other suggestions?

Thanks!
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> ---
>  drivers/firmware/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 5e013b6..30ddab5 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -14,6 +14,9 @@ obj-$(CONFIG_INTEL_STRATIX10_SERVICE) += stratix10-svc.o
>  obj-$(CONFIG_INTEL_STRATIX10_RSU)     += stratix10-rsu.o
>  obj-$(CONFIG_ISCSI_IBFT_FIND)	+= iscsi_ibft_find.o
>  obj-$(CONFIG_ISCSI_IBFT)	+= iscsi_ibft.o
> +KASAN_SANITIZE_iscsi_ibft.o := n
> +KCOV_INSTRUMENT_iscsi_ibft.o := n
> +
>  obj-$(CONFIG_FIRMWARE_MEMMAP)	+= memmap.o
>  obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
>  obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
> -- 
> 1.8.3.1
> 
