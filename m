Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48441368A0D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 02:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbhDWAxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 20:53:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27652 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229865AbhDWAxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 20:53:44 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13N0Tj4j018012;
        Thu, 22 Apr 2021 17:53:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=lWYM4HgC8O3VtsYIIFO+rbFeQG4l900eqy4S4dK4HY8=;
 b=bBNoBbbyYUNHhJGQuxM15RKB/WCvSXStFsOrYA7pi9hl0U5ECWg+Nj0u5acvGM3zA6rv
 jezSlGbz580dkaK95i6tmETh6am/DQgvRwLvCYO/4KnlhRMvjLBX6+sbROO85wVu8lbF
 p3DX2RTaadGziZhERjF4IkzxQeokZKjxRrA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3839sh41bp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 22 Apr 2021 17:53:06 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Apr 2021 17:52:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISAY0fOrvOYXhc96WCseoRkhtjAZ9egWpVHd4ryEMvBFuZoo9bE6izVqXxaP61bK00VDVSfK/I16rrekD7uKYbUJobRZ6KW6sCFLIU8p1qQWmhpdgzTZdtipBft5WGxhP/Bg7WzDPDexcfq1VgbaxinP0t+ZXzDbYvy0brp+qJcqL7/wlPGeh4ab25zKZfRAey3JLZTMYm+qZNOy7Vp2gvL4Ps2r2QgsD4Aib5kN39nveGLRL0HL1V1g5s/Iu1psW6iXjPBTSmV5ckhg1KUUlWb7jPsbXnaLbBj1pbfOLYca4pQ3IRmU8X8gqW5A5HBuJAadbiETGdJKE7c5cMmgog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWYM4HgC8O3VtsYIIFO+rbFeQG4l900eqy4S4dK4HY8=;
 b=e7580E1ZVPUZ2VQJ5oa+8mHhvDAXMtUx7QZKEa3DwBMuSceTdu2lbVWlHooXC8YzH65UJfpEqwTd3KGeYu8Mwdqh/efgUQrUtvdSaYSlT2rDt7J/mouPEcV3+LsPcFRUxJyhjH1Mui/jdCJ1YNUhSFXIvwttgCJ57Y1xBsHwOhhokJd5O+VemqdwsXTlpWQTFNfzlXVEogkCrKgYsP5odPo7oH95Eyyl/1oEitSk3Sw+bFw2bMZKtXXjwHwFbCTRhrGNQLrG2sPHolAhupqBzLoUDenaaMsTwYuTaoKDyKuxEd0mDMqKJM1PFUnjtBJuV5IRd1FOaE7TPbrxAfdCdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY3PR15MB4980.namprd15.prod.outlook.com (2603:10b6:a03:3c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 00:52:58 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4042.024; Fri, 23 Apr 2021
 00:52:58 +0000
Date:   Thu, 22 Apr 2021 17:52:52 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vasily Averin <vvs@virtuozzo.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] tools/cgroup/slabinfo.py: updated to work on current
 kernel
Message-ID: <YIIaZEPdnmXbSMgL@carbon>
References: <cec1a75e-43b4-3d64-2084-d9f98fda037f@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cec1a75e-43b4-3d64-2084-d9f98fda037f@virtuozzo.com>
X-Originating-IP: [2620:10d:c090:400::5:f6e3]
X-ClientProxiedBy: CO2PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:104:1::19) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon (2620:10d:c090:400::5:f6e3) by CO2PR05CA0093.namprd05.prod.outlook.com (2603:10b6:104:1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.16 via Frontend Transport; Fri, 23 Apr 2021 00:52:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d66c7b6-1cd7-429e-4db4-08d905f22347
X-MS-TrafficTypeDiagnostic: BY3PR15MB4980:
X-Microsoft-Antispam-PRVS: <BY3PR15MB4980D4E3FF1971C9458119A6BE459@BY3PR15MB4980.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7mlfAoA/kTkBkKw8BeGRjtb+h308fo+OLy5/t3wGoheovrhDzSjOtqMF1oS55P6hkzOPYEQDYln8H5j5LP/adTvi+CEE8JqeAOoFAYuUsFQYCyz6c4vC7mdkecU2wQdufzp8JVgz8TPBL8Lfrn/3kvlSVaXK2B8j8+JhjAZHnRVAk3UxP0QjCfpKkvfNYHj0VlFGYiKH9cZP5erth97KR2PDAfONm9R50c+3uXpF7IO7zWolyRnQdxSrSTV6dz7caBBxkoMOuqGwXHmp+hTfYcXqWaddICzq3WP6pp8qON0Azh+IE/W+1uF4HeU36D83tTcF+M1ikckaXaLtgRXYzzqMDnQd2r04cQs+fc/EX0RlVgI6ZtaqlEk3F2kDjzmYAS5wvFBeqsunK7iw7FsCsAJ6Q0OYpWXh0lvKZ4ZPxMDIllcsrRCk6DrUJcJNPld1vupKTOZED8zYm9RSqqROnuDelAB3TcOJFuu73krNs9y9XBlfyXF0igDqB7cJmRfHb2/y3pyugB5JuBvw3lM4UN5DkHqThlmyvsZ4ZEklVRANcwYbb7QAZgUUvZFji/qHadbFAFDEfHcDFZTiFrrXcDJ7cffl4izSqJK3Vx2aV2E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(4326008)(9576002)(38100700002)(16526019)(15650500001)(8936002)(55016002)(9686003)(186003)(8676002)(6496006)(66476007)(5660300002)(4744005)(66946007)(52116002)(66556008)(33716001)(6916009)(6666004)(86362001)(54906003)(83380400001)(498600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vY0bo6rd7HDNyxGpIaJy34MOaAWCkwl9Y97eZs0KqnaNYI5igJBaTZWPWE1c?=
 =?us-ascii?Q?jLsvLsRVveCwm4dzzIH3/g9ZL4nkqEZnZzDLo50bJ9Fir8SmaHg19sd2SF+x?=
 =?us-ascii?Q?gNPYTTq3dewEYZxPpAaLks6AxV3JA/q1VWvIjkeuCHcnnIen/Rmfq3U3lZ3K?=
 =?us-ascii?Q?9kbbNls6nqpBJ91ZdYwJn5kZY8WzgFSOK8777mxkrrVI+t6rUpywD9p58IuO?=
 =?us-ascii?Q?Dxc2XwqT6RNvZ863traC1tBZ8/ckoR/k5fxV/JVMdKpikcLAvf33bt9lixE/?=
 =?us-ascii?Q?GPE8xo9FzQkgcua4lfgsyI+F047nyXWjSubcvlv5tpF0LLt9TnowvmjZOfDt?=
 =?us-ascii?Q?Cs3HT5lEcsnxBhD6PXSxHxLbNztK5pXWT6omYNAVNHzBq5SL58YBnjlzx0Dl?=
 =?us-ascii?Q?9li6xMPAipWB/Ey4ips56pCFMLVLFGvRmjsvBXNRHPDNiWV2p5N2ccqNb9ou?=
 =?us-ascii?Q?NkB1Rnbeea+hRsOvdjWp8TdH/xRwCqXkYeLggAYTgXoY+J0SZk9eRiSzQUB9?=
 =?us-ascii?Q?r9xJeEP/3O4vr9+zZdAJfhauB8Uvl7LBFH0gc4lS9Mw1oEbWeezcds5Z7ibz?=
 =?us-ascii?Q?76ABb5uNGldpgl9Imy4gvLwdqtiCl33lZfzMmnjTHugO/jVVAG0qK/mCJAuL?=
 =?us-ascii?Q?Tt4QYnEaJ3zl2HzOaQYkoj+6pnQVXqE0uTd+QPAH7GUiaDqByw7q2pcOiHE7?=
 =?us-ascii?Q?0cBSs6EdqN1ZZYb28Td/HsIcD4R+0C54h0NtDnGpW6D0ENzwSHaJt8FZ/f2w?=
 =?us-ascii?Q?4+P4FMxM38pGRRWa++q0BpqTWaCA6x6N64hKSGdKozitJFymV8JkGo577XTG?=
 =?us-ascii?Q?cyj4D1lOV+XWb+gv3oh2KrDWYSC+GLBs+wWTvWxhURIdKJTEgcXTL3sRMFVs?=
 =?us-ascii?Q?Dp2Bpsje1vAiWmDhAsOWYmuUXgP0PBUa6kOHkEPqx0hjF3SdIcYef/Y6qSGy?=
 =?us-ascii?Q?XLyvpTzZu0bFm/gEv0hUpyhWonaL3X9PWmXjCASok8SFUkQTdIuVMRumLSnr?=
 =?us-ascii?Q?o5YnxeITjJUfhNmrwVkA1uIUYiLXtEZB9kSzu9jjuo5Mfhah+X4K85ZnfZ94?=
 =?us-ascii?Q?lu/7HnZKLHB4ooBMR46kKgPGhD/Fkfo2BxCkgy5pdJ21p1kRNAXaLgWFxUA8?=
 =?us-ascii?Q?Fcb8zW+rt9mVrk18G+QosMIJVhYk9+ibY+padPxWvJ+n32LtMTVDVzUA5+Yg?=
 =?us-ascii?Q?6gZRp5WKqG/tYLc5bgMI830ADTgYridWGt5dJLn2WMP6kfWaGgEhnoYkOdMk?=
 =?us-ascii?Q?6NbgIvXGD/6+pz34vcv02LfF+fd/XljGDr7vmPouFduuYIt5RIXFf/uuDjlt?=
 =?us-ascii?Q?Mt/A2zDY4hfZMY/XC6uRWDPOVqfRSGWDgRPE1uWELvWuiQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d66c7b6-1cd7-429e-4db4-08d905f22347
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 00:52:58.3904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTMzPEJhmqW7pMuyQzh/UQvl7RC1t6fgu0TI2cPc50tyWTAGVfJbfnAu9ez4Enp1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4980
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: Gh5pZyMDEhLvhlZzDIWi8P8puqpfN5gU
X-Proofpoint-GUID: Gh5pZyMDEhLvhlZzDIWi8P8puqpfN5gU
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_15:2021-04-22,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104230001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 08:29:31AM +0300, Vasily Averin wrote:
> slabinfo.py script does not work with actual kernel version.
> First, it was unable to recognise SLUB susbsytem,
> when I specified it manually, it was failed again with
> AttributeError: 'struct page' has no member 'obj_cgroups'
> ... and then again with
>   File "tools/cgroup/memcg_slabinfo.py", line 221, in main
>     memcg.kmem_caches.address_of_(),
> AttributeError: 'struct mem_cgroup' has no member 'kmem_caches'
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Indeed, we forgot to update it after recent changes in page->memcg_data.
Thank you, Vasily, for updating it!

I tested it, and it works great for me. Please, feel free to add
Tested-by: Roman Gushchin <guro@fb.com>
Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
