Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4DE424161
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbhJFPdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:33:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46244 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238847AbhJFPdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:33:00 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196F33ta014741;
        Wed, 6 Oct 2021 15:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=YUvQ0ckCKh7unHVNJnpiW0z2QmpiB+1BaQwUKTAPuFI=;
 b=P7/KaNNGoN+SRAiuOEkNrTTYxfTBqa0aN9TXxM05KykHu/D1Qhm5sgVJ0gtFbHz90ZQZ
 xTo1ZRk/SgknCCVn2yHuLRTKCtVIgRnzPGsBeZctz9XAInqDYoljybhFUUN4JY/mofYJ
 7I93ucnOkQk6FbIwJYGBahu243D8/3IfTfaRlCn+NDQjVdYBhLiF2+i+Im7+pRBpFvFr
 2N4+6zoYCA3R6QQKqnF2qfeSwXcB3UmFOrHNL5yAQYDv6NvKlGGLpmMzqrOhvz0uBDkp
 I7ZpH5LzQxdt60X9Sqg2SYvlDckFeBGOdLGfUiTZx7GO4TZ8Gi+7Ffp5v6AXUaV86KTD tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bh3y5cm3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 15:30:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 196FUIgQ075399;
        Wed, 6 Oct 2021 15:30:54 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by aserp3030.oracle.com with ESMTP id 3bev7v2x9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 15:30:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdFFdJjV02XToS/XfhZsf7s6RXqnvYjswOAROB+uS9nS/HM9syJQW9PoQGhXLDwG9Z+hw9nmASDScZaB31bZpwxDxMPW1J8cbZCzquCP7r/PDWPkFzvmPS6ffP2GnQj4S4acN8oKnq0F7VIidwo4Syo4xmIGvGqN1DJh8u7L3nReppBNACqG3Fu72IPJjebSUB+URF/shU3ijHiZ1xw6Gvj0Kxl+Sa+4z0H+PBImhmFsYDpFyuujdjc9jJuUONFxlbN+nriEzczL9jgbEUCmcEdLz4n2Fco25C5ldlD+Ulye/c9oVQS6zgW0CxoGdecYocYhqp7WHMN6dN2FN9/CcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUvQ0ckCKh7unHVNJnpiW0z2QmpiB+1BaQwUKTAPuFI=;
 b=H+nMaAWctbWIYPVg/odLBewvXxH7bxpWKjJVgFbsNWDNmNc36k6Za0uS+oN3wUvyKkItwHRd0Q/gsgMV9w3Rl+cH94jaky+R4P3UOHvsumo6lQbH/ed85B/gTIkn9AFlzFastqo/Si5yNdsCzgCxrDm9/bwvg115EmE9kdP3dFFlrLytuMSjjNdVPO014Z0ipV7mHwrQKY4palEhBEfay9yYE7Cd8XF3DUl4/VtFgkhvGfdwXao2Vrr73f/wdz8PjhlVii6+FqbrrQ917oVwPqarQnv0JzDnCCzTmRAv8Hk4MFEC55ypVGjdJP13dQ23uZ2XYTHorz18of1qcJvEyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUvQ0ckCKh7unHVNJnpiW0z2QmpiB+1BaQwUKTAPuFI=;
 b=IAYKC5q20rk3Nq30m7G2hlHU+E20N5wR3nQG+NcJiJ/vifbbcs+OAcuUEF75pPEAl/RNt1MXQL28/5pGL33K6deG8zxhZpaoHPXtVBslsXFgdlhahzEZDaksnRtgoRTsJ9pnZ0NiwW9VfM5wYcCP8GVUatIr/v8noBd2usW+VBI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4517.namprd10.prod.outlook.com (2603:10b6:510:36::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Wed, 6 Oct
 2021 15:30:52 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349%9]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 15:30:52 +0000
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Can Guo <cang@codeaurora.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Fix typo in sysfs-driver-ufs
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1mtnm2nlx.fsf@ca-mkp.ca.oracle.com>
References: <20211006143506.129409-1-sohaib.amhmd@gmail.com>
Date:   Wed, 06 Oct 2021 11:30:49 -0400
In-Reply-To: <20211006143506.129409-1-sohaib.amhmd@gmail.com> (Sohaib
        Mohamed's message of "Wed, 6 Oct 2021 16:35:05 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0068.namprd11.prod.outlook.com
 (2603:10b6:806:d2::13) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.201.19) by SA0PR11CA0068.namprd11.prod.outlook.com (2603:10b6:806:d2::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Wed, 6 Oct 2021 15:30:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76d93d74-068f-405b-a410-08d988de47cd
X-MS-TrafficTypeDiagnostic: PH0PR10MB4517:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB451783F08BDFF3AFBF071D4A8EB09@PH0PR10MB4517.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:628;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uGgBWZdDdMHGo+ArQWzurGamjtO2cTTpyIrOSVxQcA1V+cpoIEFiLzrYno4vzR9pof4exQuyywHveoL5+lDMrft+WhCA2k9awO6Gx+sEVfhP9tAAuRqi+XPXpzI7d1MG5VxtfwionLrq+r9/8bvopu4U/7rjiRosi06kgQu9U9ytFPLQcp8SyBxvxAPpS7SMmkrZUAluxjU70FZ4NTKy/PAOzqsmbiyE5NZbJLoKlTIddPwkEyock1MPKLuBlBJulbiHGno8XE2e//Y5vDPVJlbW4Y8Qp3PxTiC0UFU9Ak5pAJbnnT9TaA0v2lRhiSTGBn5K8WtFPWuis0blwmLRg4obkUVB3AjvDhXJXHCf6HhWgwgd5QTGoFCIVEC/IekdE2m1Aj7ylEobY0YnZOD5jMuDJsU7EhwS0nG7NaXD06G8Ts+iREugir5cWszkjCtBG9TFEQdIqrKCYIefEP9wbQM/pKeJRFLgfLklznrNV5mq0+Q+uQrzp6rkcAP/vqY/YbMz9ZdVlVGbYyH1jSikT1irqDBBrgjvnyraZNKjPrg/pQavMoI1h2hEFvM4sMxGtpWcKm14xb9TvpYlr2yE/2zjw8S5NMiHa2GCdpCZ/K5hI19NnQrNRIOtXcNrLe0lxs0chExaKEgKymg9uEu4RxEWLyvlKPNamN4ZwzbF2NKA8yP1JRZCm+8eH4+Yfm6kWuntS2HbXXcInLP8Mpmvlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4744005)(2906002)(8936002)(86362001)(4326008)(54906003)(66946007)(6916009)(8676002)(83380400001)(7696005)(38100700002)(38350700002)(55016002)(956004)(26005)(36916002)(5660300002)(66556008)(52116002)(316002)(7416002)(186003)(66476007)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GJBX7+vyZyIdTBNPpjDzpVj3ua2HaagR6Hv03zTKwoH4FccLAyI1MeipRZum?=
 =?us-ascii?Q?TUerqQVVk+EruKNOGq85GHWJ9f62yarw/fXkNwgNrwc4PgP5yFziPB8te4dz?=
 =?us-ascii?Q?e0Ka5s/jyBpFULK0jXDSw18m2l9k6yLAACYj3hZftE6QZR7yU3D6wBEbzS4h?=
 =?us-ascii?Q?n3tcX1t14Jr/0RErzUORqWij1VckWux8+ZbNvnL0QnvKbgGAto64D6Fy2vbs?=
 =?us-ascii?Q?JRA11jX1u9NKuS5s4yLbeKpVtPZ79fLqnGbgrpitrkGZ2MTdd3zH5m2qfcKG?=
 =?us-ascii?Q?GvwRobhwplqVq3VGugZ2sWw39rcsViYFH7PsAWwcOD/j+ra/hbP1PVcp4nAN?=
 =?us-ascii?Q?99aNNSU8WXKWx+Aqiuk7q2WpsXAShhXlzzJxAr3ZaIh5j8DSENQE0AImGTza?=
 =?us-ascii?Q?qMaP9gKOFGR8zca3510egwNcvxaQs6rDFsqT0FGkiQr6pGUY1iSwPImG1g5I?=
 =?us-ascii?Q?8365UQ5lwzBFrqpLZdLtDgTR5uuojC+c2p7kIVaBbg2P0ZMJ9552aYYWjDLv?=
 =?us-ascii?Q?ulG6PJZrkoyxj3Q0FThY8XvgpqC7QVU6nIJTg12DN1+GfYoYTdPRxBp3IUL+?=
 =?us-ascii?Q?SGag/k9Vt2HU5tTnLFSX5lW9yUg+AOLigr9iv/GxBu7WQuzuBSNHp5gS5jYw?=
 =?us-ascii?Q?7TlJU9a0QZY6krXI/5VPJ3aVHH0ZNwiAsucMZXbpU+lIeJiDOr7/yFu/G0r9?=
 =?us-ascii?Q?vn3DemjBbjt7Pu7gygGq/Yd5veXEpllssn3D5tKv1ab7hmNmED1N+tlwDcP2?=
 =?us-ascii?Q?kEzkYuQEjcpEWl+Mp85SfVOUaXcbArRFmTK2r0UA4M5minbd2oV0POlttI1R?=
 =?us-ascii?Q?fUVWGjkvoscz2zTQIBCozQxRl02o/VC+Y16DCZPTZLxNkUtU5l8dDETe0TMc?=
 =?us-ascii?Q?kPFGzMMxF1qil9+96dbPBPPjntcJEBbFILMbA8IiziJx1Ri8xot6rOu8ZkYq?=
 =?us-ascii?Q?rDzTUThI5edexcENw1yNn2vc2Wq3tWw3ezjL/ZV84wbAjFTB45BcIrHi6l9f?=
 =?us-ascii?Q?JRsyBO4K9wW/QBUovmSwncj+X8aneNaDfvCcFaY8hJfZW3JfIaznTeTq6b7m?=
 =?us-ascii?Q?DCpYNUfCZpKqQL9cPL2xPdHesE7myJLgQP19+DbgQNlf4Hexgi3eg5JVQOpI?=
 =?us-ascii?Q?3l+fqGpmblSCzG10+1OIUezM+F+6PHJUWGg/UXaFTRWclPM6wObJVNuHZHKI?=
 =?us-ascii?Q?+IctnPwt4ladW9/2i45sW+puQj5ywlUo7UvTZKuJO/OpbYb7pmq/+0x3/sr4?=
 =?us-ascii?Q?Fi/Qw1gDJGEkg71wb04l4T2WAwLxR0zJRW5XqYB4Z918jkZ+Y2o4B0KJo2ed?=
 =?us-ascii?Q?JQRrTfS3e1ibv3xNHP+LlmNZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d93d74-068f-405b-a410-08d988de47cd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 15:30:51.9736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phLKiBAAqNyvig8EK0TXqjHyoWwNwMCq23BKRhc1xcWX9HjtPYiYYSnzJiSFDet+x1znD4NvOjzlxob4DviT6YWhOTLZsuOIElfz3c8SwLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4517
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10129 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=735 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110060097
X-Proofpoint-GUID: WiLMR690d6oz6GgQ6WOG9YiIfuFijcJG
X-Proofpoint-ORIG-GUID: WiLMR690d6oz6GgQ6WOG9YiIfuFijcJG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sohaib,

> Remove repeated world: "the The amount"

s/world/word/

> -Description:	This file shows the The amount of physical memory needed
> +Description:	This file shows The amount of physical memory needed

Between introducing a new typo (in the commit message) and removing the
correctly capitalized "the" in the documentation, this patch doesn't
seem like much of an improvement...

-- 
Martin K. Petersen	Oracle Linux Engineering
