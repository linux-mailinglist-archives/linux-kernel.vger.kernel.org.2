Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89503769B3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 19:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhEGRxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 13:53:38 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64248 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229476AbhEGRxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 13:53:36 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 147HmaQv021184;
        Fri, 7 May 2021 10:52:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=m+eh2hS/ZTdVBncrisQ5UdDss7x4E4uER7M7bOl92nw=;
 b=Z3luy9rM5Iqitqwngu/rpHbvwJJwjoyO+2HUHg70ICUOEoj6pNGI7T0cmsdD2KaOJsbL
 blt4P5W41oErT0GPfThICIBAnPRZXyDmSJr7pyjdL44AqZlGkTMlO2eiwVlnf++DNOZL
 gMcftsBqPJSS8X244MVB80GR87ADv1PavRo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 38csrh4ge7-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 07 May 2021 10:52:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 7 May 2021 10:52:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7GtWgwNxYqDTPsjkToDSdy1Y8mG28uXK06Vvf/ghwhXjBL5frtY13pjp8njwCjkwiGGxcxSPwlmUtMCng0shoAyIPmLIrdMKw/No+1HwuUfzxibgRoEQE0d+3g6ocoOrUW74XNv3wHxn0y8ggHhpRMAFJH2kqEpp0i65mC6RAeCC9dnZfEkWFUyhHjgTGoK9M1uL7/kvoWFN+vnGn2dRfXcJ7PSykikDDtQ5bQz86YlDoP/M/uy5SjpElPfzSlBFwvlTgl8WgVKRI8LRj2SgxeNqcrB7s3x6dWVdGMjN8Re3KsXC6oq5tssRuPZYRiJQgitJYujCI7E0kjbripMaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+eh2hS/ZTdVBncrisQ5UdDss7x4E4uER7M7bOl92nw=;
 b=cPe/SdLxt23cUTmz+nUQ33ZLkBEUzd0nVAJTAtO+tzkyD1wQP0ohv173/2K2C47fvzey2cLn2Wehbh+t6LvBWahlFqZslAnQLcbor0Z5Dj9QC+bcNR3KN2xo02FVUvn4hziazkfffgvJB/Lt3JL1lpqFOuEdCa6i/9yCLupECznkpOfiK+daxZLjiFCSTp+wZo8BpWGKhsUW4sWPDZibu4glaFHvnTmWT67T4YGWsT1zF5leYbql/XuvMw/8XIdSHnYemrn+D4xFtHWn+NnRtGksRBM7hhaUKdwBnAva0RuLkAR1it5NEuHkwLZcffubZnwc8i8jsyilF+HyQ3kTkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3221.namprd15.prod.outlook.com (2603:10b6:a03:102::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Fri, 7 May
 2021 17:52:27 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4108.030; Fri, 7 May 2021
 17:52:27 +0000
Date:   Fri, 7 May 2021 10:52:22 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Oliver Sang <oliver.sang@intel.com>
CC:     Dennis Zhou <dennis@kernel.org>,
        Pratik Sampat <psampat@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@intel.com" <zhengjun.xing@intel.com>
Subject: Re: [percpu]  ace7e70901:  aim9.sync_disk_rw.ops_per_sec -2.3%
 regression
Message-ID: <YJV+Vn9eGfIlxDQE@carbon.dhcp.thefacebook.com>
References: <20210427073448.GD32408@xsang-OptiPlex-9020>
 <YItcfQfZlNZTmQKR@carbon.dhcp.thefacebook.com>
 <40632FBD-8874-4B6C-A945-F2EBC96CF12B@fb.com>
 <20210507030606.GA27263@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210507030606.GA27263@xsang-OptiPlex-9020>
X-Originating-IP: [2620:10d:c090:400::5:b72e]
X-ClientProxiedBy: MW4PR04CA0300.namprd04.prod.outlook.com
 (2603:10b6:303:89::35) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:b72e) by MW4PR04CA0300.namprd04.prod.outlook.com (2603:10b6:303:89::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 17:52:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91538a31-0792-4607-0b64-08d91180e05c
X-MS-TrafficTypeDiagnostic: BYAPR15MB3221:
X-Microsoft-Antispam-PRVS: <BYAPR15MB32211DAA6DBBA47E4640C48FBE579@BYAPR15MB3221.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfXKDQAXhAuEUQLvj+uBJ1aeoazZqRSHX5LEy45/C+LI77html95nlhthoiQkHScQIfHaIc+hlhaRrHH5jLeTGQ+RaBuQ20M9M04e5GUwxOJJR50dmlv67eN7jmoRQuz7RQN8ul8M/WVTHSR0/Kn5tiyxxf/lrg6HbIvC7IjHjzPjigKEbYG5Qll47SSCHHN61ULarLQRXEPIPGcp8uTHzZ6PrWxTmdQ6nqGh7v5Lv9FYL0VU8zcwK8wjLm8fhCg/eBOSCR3s5nWUS6rlT4SO+WCB9UUCe9oPEmEJ+WSHS3dqHXsgftYnOLmzFct8lYlGpi1kPPtEEzrvjt/0dWewGYssL4XtQihlg4TiGlbbjYXHDoAl7UsG5gFkvzw5RKGrdZ/Z57gza4Dzp6N9VViLZ8a0kDh2lH+C59rwaJxOpx/JgnjBREOzV7mLslGRjeMTuhtr+byZyfkzc5Hd4xwXmTUTnuRWhcM0TtN9L2nyUvx7177jxWcp7/Efmb7DNlgIhxGfEQK6Zg2TUrMdcjIIB4G1N6N+xjqsnM9J4Q9Wf9mzH7i195P+fgn8vMFHtaJ8WbdpHOxjLQ97FTaB8CSz39FUQBKL7j1718fEFe+dTVuT3bmAHkQBWHknTF5V1BuL4X/f78BqDlZm8IqyjGL2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(86362001)(478600001)(316002)(16526019)(4744005)(6916009)(186003)(6666004)(38100700002)(6506007)(2906002)(83380400001)(8676002)(54906003)(55016002)(4326008)(9686003)(52116002)(7696005)(66476007)(66946007)(66556008)(8936002)(5660300002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?upkK5RSk1LieLWKo0bBVy5F4velQ+mFhwkAb94SMFszhhb1T8UdHAI2M0qBB?=
 =?us-ascii?Q?7Ntd8fZzZ01bvaXK9GzLlnHTNTBxx2fUzqVmT5fhO77ylpC/zwb7YFxPVhyL?=
 =?us-ascii?Q?pFqg77kGJTOqYhWsOP7xvwznUwpGJ6R4pFJuhWLyKaGbijo8+I9FwyIwmzR0?=
 =?us-ascii?Q?ta0Df69T/0cNYZ1RstFUBd5BX1zchoD/fPaQEwj15oMzTaZ8Emq5ttV+ZMJH?=
 =?us-ascii?Q?ZZatF/vj4R+e5QWxnyBl4pXVRQm55YgH0xQ7mVg4QAfXvkGvovTtquqFhEdy?=
 =?us-ascii?Q?ZWNffJq45W4dJJFOzN8rHR/oo78zS/gvSA46Hy7bQEqsd+nlMWgr4fhVS6GC?=
 =?us-ascii?Q?x+UibOYN8yOg7s4U54MbwbR2QakWgtz2pKNqTT9yb3rT80RpT6Kwg1CoJ9mh?=
 =?us-ascii?Q?LRrPhlJP0MWBcXPWMzabDN4Oi1YGcjk6PwtaRWLf6fIsuFZGzf0Bk6FoCTII?=
 =?us-ascii?Q?9C8EE7nDLaeVbnTit44KWClatufq2vLhspvDQJY1OpzEfk7bPMSVkU5z+/yy?=
 =?us-ascii?Q?Pd+9ohaPVuoj9aPChVIpjJUv5PlISUnCrlK4VVNvFFRSGKd8C4S31VncPUq/?=
 =?us-ascii?Q?KQkXS6jRqXT7KiGhrH+kLzYi7tZbGlXNIHl7qWjeMXkfndNTDzjxggNLfrwG?=
 =?us-ascii?Q?SkGbGYxWULOpIo58+nQC8U858jj3UDD7ttcKeL/ey7kR69YE3eVKPSrjWK5s?=
 =?us-ascii?Q?lu72XlhojmpGlNa2LxVGueLXiPl/6/9YahMBhfl/emDLm0FkNdufMl9aKLT1?=
 =?us-ascii?Q?4VsiI9qhvniYnzUbiVRt12ktrzLpmDpeKEZa0gBP1Y1FHiRJKf++HR90Yf5l?=
 =?us-ascii?Q?Psc2dWJCInX7tAhqxQAIGOFWPXAuXirjI3ddRfXUv9NXCHWw+J94KrA6mvhX?=
 =?us-ascii?Q?rzRpP+FyL+WqVott4lwgedthz09laa0RV46IsSExuieTiBGncjPqosFeAidC?=
 =?us-ascii?Q?WeAeo3RrC+jqzMJ8fr7tho8nnllzN3j4E2xBa8iJTkYMFDcGbVzSEJKFeHvT?=
 =?us-ascii?Q?XBc4Q0tBNwwOEiXnXd+XdxqfGrTA03jKL1XIaxxcm7wQR+/cTVfmzo/1IH+K?=
 =?us-ascii?Q?hqdtafU5DJ0eJew4QzDwUNFg0V5h6TqSxsNkdg9anAvEE8uuZH8iAG+VYIXN?=
 =?us-ascii?Q?5kPK6IUj9eVd6N9FtIFUgbP/JYcWNDGJAOW/AdKscKsQREriKQJoWJgUpN+B?=
 =?us-ascii?Q?ju28ccU5hypnBYnRmHcsbqF5WJ/TEzUGdlCr6RgBxdEfS+J5NBrqL0l4tVH+?=
 =?us-ascii?Q?QQ2/Ny/2DXxow4MTDQvCsYKJCn+onzx2y+EafaHb729dKDGElxUzVvsyef4e?=
 =?us-ascii?Q?UdWVezN/ReqRPQGb7BNLQ3tW6JM6IGcdL7ciFDqDBHA8Xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91538a31-0792-4607-0b64-08d91180e05c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 17:52:26.9426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xe3m9NHU1vdWjKH8izKr2KtHKlcD1toMb4EGFN/+BWdhrXRe+NWJJh5ewd+VYv6M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3221
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: GTwkXbDErNZetjk0sthMVILv3I7ETUcX
X-Proofpoint-ORIG-GUID: GTwkXbDErNZetjk0sthMVILv3I7ETUcX
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-07_07:2021-05-06,2021-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105070116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 11:06:06AM +0800, Oliver Sang wrote:
> hi Roman,
>  
> On Thu, May 06, 2021 at 12:54:59AM +0000, Roman Gushchin wrote:
> > Ping
> 
> sorry for late.
> 
> the new patch makes the performance a little better but still has
> 1.9% regression comparing to
> f183324133 ("percpu: implement partial chunk depopulation")

Hi Oliver!

Thank you for testing it!

Btw, can you, please, confirm that the regression is coming specifically
from ace7e70901 ("percpu: use reclaim threshold instead of running for every page")?
I do see *some* regression in my setup, but the data is very noisy, so I'm not sure
I can confirm it.

Thanks!
