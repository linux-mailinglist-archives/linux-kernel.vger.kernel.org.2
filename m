Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE66E3E2B6F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 15:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344034AbhHFNdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 09:33:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39172 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243664AbhHFNdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 09:33:21 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 176DWCiD008197;
        Fri, 6 Aug 2021 13:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ZZ2UzyZIzA+WqtoQJ6+urvx82T8oS7QfWWpv0b9/MUM=;
 b=uu/n9jjBpVmGG/lXWF8ki6iQFRdcy144EjbZQiYLhWvgSDz3dbbilTBSZi/YU8yTYeXk
 XafODuKgiAk4MnxVekKN+CbIsCLJndt4s2vSsOQSsUGp4Znjb7VY9wYmpANEMSQ+ULzV
 1/gRAXfwu0ysd3NodEExgVAHQ88yy7XKOHe9f4I3srwXyHiX7IJl3fv8OqTBI523aIQn
 Cdip4UOPUaZ6hqlpEKSixoDpykmDo78iPQXisNMoCqbcvCD7/ponKuOcc77UClInCv3Z
 2Hgoxkce2ug6AS6u9Byy+SVYO/Duv36u/oDHOtqgIrZZSceGkwl4OdqTTHgfVF0/4lWr oA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=ZZ2UzyZIzA+WqtoQJ6+urvx82T8oS7QfWWpv0b9/MUM=;
 b=aI+7NgCYtJGcCfd7Ylp9bco5zffvynyTYLhqPo4SCFyGkpvB8x3t5HYOcfXHLwG1PGjB
 CUWl4iONjQ15Kqzcpjk0N2xo3+8Oiwh40TROm2xMIxUSrPcj/4TeDo+TzfGSf5xOYIiT
 BaQgLQfpSQKsvD1NzlaS1N1WXJY/fNpeR88NAFOLryppd/GQv+CL01tvZHROXvSTl8zL
 4zDtsZrYMxtnvUyYLfQhDEkoFr/kic/AQxvuaYmNVqY/fi+876r3Ox1bqwYR01y5lj1h
 xrBUOya0ytXI6ROZQGaDvKU9/voKXAy17CZFV9GLtGcKBqp/txeMZqk5n5dmqZYAZwQi cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a8vy3s4jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 13:33:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 176DUDvM102434;
        Fri, 6 Aug 2021 13:33:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3020.oracle.com with ESMTP id 3a7r4bnax3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 13:33:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnONDHwkog74fxzftxw+/IizcX+Ki1hiYwYahQZ3mDRyWe2WwQ96h7dH+uOMuV2tQIAB9ARLX5J5eNru/DAGGFwsEvKXSuhpOBpSp+yAfciO8Ps4URJ/LuKT//O0a3Thc0R80P1pgX5i3qiBG+18pO8/F7+RbznIgoBHk7XbA28nkVM2R5IGXhjmOni6vEXJaanovqqmGveo0+NCaCyCBEp2rfIy/gmw7pnxNTrZBlJzHG4nWphxu1fbMa/lRMCZ+vkVURcbKDY6B5H9m4RsN/EX9nnRkbCgNyAVZB6LcULpNngTccre559lV74jzFS7muNsUPF9NwLcg3GGorfm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZ2UzyZIzA+WqtoQJ6+urvx82T8oS7QfWWpv0b9/MUM=;
 b=G2M8oAv8b5o9U/uGOD81FTBBhwCrFiG+LeNdmsXqvWpX0eWhEjYbDzTV1KNhgESlQmjSkB05znLHYALNMZC0FIecqoR5BWNu9BXJULNUdXO0cV5X3R5lXlGoUhf5CULn3FfC/6oId9pQSnzFbXBFN6QQ7al0A0NOvw1Vr2+XTSOGh8JrRa1jfRdTfVcyHivpaMD7MFWeOLxBAyyf4KHMDcsqQFApRNEBE1cLbaxihtUhgNsd63tUYry1cDPesRxDSB2SDUDOfjAPMO5kqYXLa5S4qjOGtdnZzmvikxSi+bkQC7Pj+zoaRe1uB2nBOMmiv5UzAtE90WJBr+8LRapx0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZ2UzyZIzA+WqtoQJ6+urvx82T8oS7QfWWpv0b9/MUM=;
 b=WKowq9t4mhg+yvD7XceZfZvrzOcAc8WiuKkBdCrRHz23nCcE2XgKRUwW6kQPx2jrM8WegzopA/CjGAYPGhq2li8Sm72y80UK9ptNZZ4faDVUcqaH2H7/vAFB9vV1v56KECMFZzIdh4epbKLkWhPk2QNYd556ismdHMdZrMJ+fAY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4641.namprd10.prod.outlook.com
 (2603:10b6:303:6d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Fri, 6 Aug
 2021 13:32:58 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4394.020; Fri, 6 Aug 2021
 13:32:58 +0000
Date:   Fri, 6 Aug 2021 16:32:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Thumshirn <jth@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andreas Werner <andreas.werner@men.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mcb: fix error handling in mcb_alloc_bus()
Message-ID: <20210806133240.GQ1931@kadam>
References: <YLX7bAD4UPCpIBmq@mwanda>
 <c4cffc84-be11-6558-60aa-a5217963b1f6@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4cffc84-be11-6558-60aa-a5217963b1f6@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0030.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNXP275CA0030.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Fri, 6 Aug 2021 13:32:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba82ae00-efea-44cb-2ab5-08d958deb414
X-MS-TrafficTypeDiagnostic: CO1PR10MB4641:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4641CF6ABB9FEDF3644A8D3C8EF39@CO1PR10MB4641.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S7k71eAkWFtQwZXY/Vhyqf9NdReMMuk0nj+utpHF/wsjlRkZ9J75nJvXQYd+ytEOM/hsJ56ro1NgvXfFJGMpGVIjCh0tA6pcdGCbxVQVzQMHkXJIbdpsD8nKZbOiW6AR6ct4dZ+p12zLwYBhiuN6mWu6xBb9XdP9DELoxAA7fbMNJKOK8HS1bufzV/ns8Bv5jnBGlzfIMiBGIPx9S3Sgvr7yxeL0m5+ncnuQjr3TWh66uZviLMHIZ3jh/37YsWhWZC8Nq6izU3vANdSsQGaZyrPZUHgf2pmW/5QvehdPOJMZ7LZ9AbHbmFxvvxYAuZU2nNReSHR5PFZFbiJiMznka90Z53Thn8Rnn/jOGT42BjfKcsOsjBJRJZP8a91N2FiFd+HDCbzDPnuaYCQinoBQJkJZJw2Pqp7HiVFNARaVFRbc9SYwFuxGc0NOfvfJ881GPwL4lHlUv8szcnpVAIRsQ1PGoPz7PdMwcOh68RSo3XvMden75K2kAuo8Y0ZudvqVfClkhN4LGTsi5Dg8qZjyH4WL0z5kDubpMtpyPlcGNElUdofMUY+c7Yrgib4zo7PCaMI1ADafVigOntlQ7C0/TkIdaGM3OOasLt6u38z85xNWaq5JJt6j+cMycARUtN3U5fmKKylr6d4F85mH0S9c9fb9rNnjiLZ4aeQhqitPJvyDeYN4AzpnFAjHbQLIsF/I4UczHcPMOGiClSbY1g1qNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(366004)(376002)(136003)(8936002)(4326008)(478600001)(66476007)(5660300002)(6666004)(8676002)(2906002)(66556008)(66946007)(33716001)(26005)(4744005)(86362001)(38350700002)(1076003)(9576002)(956004)(38100700002)(6916009)(54906003)(44832011)(52116002)(186003)(9686003)(55016002)(6496006)(316002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xrj223NJTL7yXWw4lRZDPJ+slrj3g781HQJ0llrJXfNRMyur3fYOjepHnOwE?=
 =?us-ascii?Q?p4sBgh2Bjr01Ex+GBqkZcE8YUMX0UcO9mbeY8hfO1d2nRGyMk6IQQUUe2Nr5?=
 =?us-ascii?Q?i30g9Lz+vDxjGTB4hRaSsx2l6wdT5gA0tL0DoC4H29VrmGkpAv0BIHKk2pqv?=
 =?us-ascii?Q?suya/FBW9jEYb0Q3vA+0s812ycbpv5HTOUbLo90eOn8SPHgYpkf8x8nlouaK?=
 =?us-ascii?Q?ZVgMEfSvq6YXaUXQ4LxHfaAaEK05PRDIxkvx841yhq6pZhqTZ3pPGAmNrD/a?=
 =?us-ascii?Q?q0Us1j4neZeEhAdyo1OtaFKFtySFkRmIteK9yv/nDiFa3dVTGw8057EX9yXU?=
 =?us-ascii?Q?vLZf2tSaJf/ioAQWfw1Gmu7/BB7p4YimjBeKogMrvGluRys8J+tyfTZ3tOHZ?=
 =?us-ascii?Q?Ik6r0DChAmE/KxcNkl3JEW4Q7Ybhl6RKH95RrI2dJjT58XKqTSOMDGeCj2Xv?=
 =?us-ascii?Q?Z2FvC4qU/oeTGSQaVYg09AxQBRvnd+ooLLOwQd/bCgAPgQFV1ciRvKS4ZTVq?=
 =?us-ascii?Q?ukv5DUyLp429iZt5BfH2l6VP1ckmSqzjn5QoSF9irIeaLZnhVRE9zk/KVuGy?=
 =?us-ascii?Q?2wx2CdP6ubZjJiNMgAS0CF3LwUSOHFiWREtl1WipCB/znx8EwTjGMR5+MfIO?=
 =?us-ascii?Q?xmqe9yj86HcXMiJokB8UOJj6eH4ze/JMMTA5AqXMs0z9rIlJArhsIzQQnSal?=
 =?us-ascii?Q?wGN9Bdjq1jjn1dOqPZbM2r7qBOfM7xh3KTHQe1UnJ0+yOi3gjzyRnYejxeE2?=
 =?us-ascii?Q?2TfGAUb2Hy3EdvkChMzVsnFXriW5sV8Vqc4iMtSgfruVZxhE7E9fksN94fbG?=
 =?us-ascii?Q?NS+ZlCw1w5wB05aV18tuv37rWVmSi+4S8ih/LGp5x63UNd1yhh+rU2LwQZhq?=
 =?us-ascii?Q?xo1pYZEGd4qH5N/UyMrODrDaf5JUxREUYlIvAG+qcrrIHh8c6KPTtSO40epz?=
 =?us-ascii?Q?YHlX6y8uOFdhcOKMX95366hj+n5abGCIL86M14nDb5jJFiLeqJ6z9quWRV8r?=
 =?us-ascii?Q?Ac4ePfETFRXrP5vE5myj5pRd27MpdSdPKD17HQ9pRSdgegxw8CObtbOiRjDM?=
 =?us-ascii?Q?1NLh+78crk6K0XnEcC8aDgguqyjiD7JuZSaAlL2LtOLELjOZHlJu2KcjiBZu?=
 =?us-ascii?Q?Aac78h6xK6o2ze9m9ZByNaSaEcoZp3Jqp6+FppGZ++LAqqKrMREmE4LeBIBn?=
 =?us-ascii?Q?qt/lJvj2SRk5wBNS8D1Lr00s1MoKrxWjlPMXoAx4FfWKh/2Cr8sQhV1ZrWaW?=
 =?us-ascii?Q?XpYR2Tcg8LnRE96p8XLUYRn11aXNqi4MHnhmS05TV8IYO2A+yX+FN8AVbE1f?=
 =?us-ascii?Q?qSN8fZwD8UHasi5X3gTtSleu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba82ae00-efea-44cb-2ab5-08d958deb414
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 13:32:58.3276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70kIHlcPzDQ1mZYBWOCbwVuuee539TqH56y7Pe8DC+5GDHc4O5gRbGT0y2FHJfliKLjcnWqq1w+I3ARNhblUoNIc71dbUbOzlSaTYv8/m0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4641
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10068 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108060094
X-Proofpoint-GUID: G2ZSA2jMJJ-3HhXOGgNGI5QmyANMt9KJ
X-Proofpoint-ORIG-GUID: G2ZSA2jMJJ-3HhXOGgNGI5QmyANMt9KJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 03:23:55PM +0200, Johannes Thumshirn wrote:
> 
> 
> Am 01.06.21 um 11:18 schrieb Dan Carpenter:
> > There are two bugs:
> > 1) If ida_simple_get() fails then this code calls put_device(carrier)
> >    but we haven't yet called get_device(carrier) and probably that
> >    leads to a use after free.
> > 2) After device_initialize() then we need to use put_device() to
> >    release the bus.  This will free the internal resources tied to the
> >    device and call mcb_free_bus() which will free the rest.
> >
> > Fixes: 5d9e2ab9fea4 ("mcb: Implement bus->dev.release callback")
> > Fixes: 18d288198099 ("mcb: Correctly initialize the bus's device")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> 
> Thanks applied

I don't think this was actually applied and that's a good thing because
my patch wasn't correct.  It needs to call device_put() on both
carrier and &bus->dev.

I'm going to send a v2 fix for this.

regards,
dan carpenter
