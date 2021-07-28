Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9AE3D9972
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 01:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhG1Xa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 19:30:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48852 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232116AbhG1Xa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 19:30:27 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SNPWOo026708;
        Wed, 28 Jul 2021 16:30:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=i5yRx3SteCb0xTQKKplIF8sncnpIre/3GTieAxKzztI=;
 b=c/c3nyQZkvXJ4Vner0yEHAlheHDgsriDiRNkWVl/WBMrwoQU06qXObAHP77S4sj1DbB/
 b0zdBUSzAUU182COgCyCoB556GEC9REpI81PfJGbpDXC6U7znwmozA4uuYYhOOWP08h0
 MU4eqel6V+g9hHFqExAUXJhh4uqdcs9Wh40= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3a3a9qtp4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 28 Jul 2021 16:30:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 16:30:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1ZBvOvOK1+Xar0iqotKZwsrrSxCbMOUTum28U9CSVuZhuRaPtaOh3N0bx/ZXbD9BPh3f+GR485nUlk2cHPeedVxBDIOPfj/a15yGp0KCZ/+qntBAyHPBv+ALgmeuo/Zc+eBlA9ha5x/y0c78BUC1Bsw7sFZtWxvZ7pMs0Oprw/5pdY9bRU4DpzN3O7H/Sv9FKUFRD9QhXcg5E+D4/7Hmz15kuZeVnZpg8ZitJf70bDb1TMdoPXiBanaQDISWgwen0jHfAkYQ69s6Q8T+kv87TX3lCecG+XxDwGWphpS7Yw3FX7/QATYfBNBH9maZRE1Dt9zZI2x+BHWGYqJp4mvwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5yRx3SteCb0xTQKKplIF8sncnpIre/3GTieAxKzztI=;
 b=F6p50LX1KQpNPUYZPatN5MU9664eCLF5Czrx24BmcNeurG6wATwMNoC+w0mFRK3AJnCwlDdrgiVQukJH7dzVSVgVrAAWK1A1IWhg35YzEGLXc+0NH4713JoQkAYm2tXBBifnLEgYvIwDkLY7KhTeT8XQn7znTT7k/WBdjYxTHIUikoAGLfQ/VwdMN4e6V3NvjvOnoudBuek5+l66YWZCFp4DaiAln4E0k38aokHH2PtaKK+V1wneUkZWwXjJij9oasiccOHjiAr3FgU+GDDRKnKoYEDHG7h6QEPunwHR8JQUcmDGnmYxPWVauypOqgPPORwJSZZXAB0PEN33V18dRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2277.namprd15.prod.outlook.com (2603:10b6:a02:92::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Wed, 28 Jul
 2021 23:30:03 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7%6]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 23:30:03 +0000
Date:   Wed, 28 Jul 2021 16:30:00 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Wang Hai <wanghai38@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] slub: fix unreclaimable slab stat for bulk free
Message-ID: <YQHoeNk/i9QK6OgM@carbon.lan>
References: <20210728155354.3440560-1-shakeelb@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210728155354.3440560-1-shakeelb@google.com>
X-ClientProxiedBy: BYAPR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::48) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:d9b0) by BYAPR03CA0035.namprd03.prod.outlook.com (2603:10b6:a02:a8::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 23:30:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf8f9404-d3dd-405a-11e5-08d9521f9fea
X-MS-TrafficTypeDiagnostic: BYAPR15MB2277:
X-Microsoft-Antispam-PRVS: <BYAPR15MB22776E04A7A22DF972478BC4BEEA9@BYAPR15MB2277.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pdn/qARpr525FzxEjZdz4AM+KECf4NWHke1f9Z6y79dCN/ugvwZaIrC9BcopzEfIxIV/UTao0qJGVFGnEGCKdLr3bc8qpG3w/RjENbGbX4yCNMLL6oQ09YtOeGe3HeytLSpfg3du2mHrXP4zSIcYzX5Mtar2mfCoMEQ1XQOy7aCMzbXzetTIZs6+DplM8dCj+o4XZi+m/9JBFp4Q5e/MIEGBHMRycB8pbjpSGglvUKy/MUuIdmEiR4p6DkTx29SqpGSAlkrYtzEzynhfFmG9PQHGofo5p465bXOWO2/toHLvIB9wESKxMiK/jqzyGe7zgIy9fHz+Z3OsOrBdRAcpHBFgOVhviMGK09TI/iCa9aPXJ7Micm9fTq0saOqbb6ngz5g1Qj+d1ClVYwX31+HiB3rDf8mk1EEhUPYcOPRjS99u8DJ5grglndXq1PuOulUKOwyrhxzDQtNbdhYyG7R+Q4tF51KUg+8q6BhlXJ0b0dcIJhWVBDVOXqYSc9wmwe6+SMtQHprfVWHCdmOhTWTONi4X5Nu7w90zqg9Jf+Px7YDzuIZGlt8Pm+/v9WUVFkh/sKrBroClmUtoc7xuUSqlN7w+M2ZUTKHChp935vwZYRmsDR04zuM+iOcmBj8XCJUox+NzY0YVKFln6gK6c4HQ8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(7416002)(316002)(36756003)(7696005)(52116002)(83380400001)(66556008)(86362001)(186003)(4326008)(38100700002)(2906002)(508600001)(6506007)(9686003)(66946007)(8936002)(54906003)(66476007)(55016002)(5660300002)(6916009)(4744005)(8886007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O3NhGxGwBJ8O5JEdBwhXEtaPoUy/N1xZUjYF19yQwNngEtuSYHohTbrIvkQk?=
 =?us-ascii?Q?vfdGBQNZKuuy6KKpBPuAiaktbwTbbcgkKEgmVRNphCinIGZsBU0TW6fKXLRp?=
 =?us-ascii?Q?ItgkvMsIHnvDuXDQ65RCf7C5GAQ1NKGoqjBEfaxuXOyi/nWKCTZ+/pFG2ojZ?=
 =?us-ascii?Q?2jZrAuFM7XB8KFC44CYuzHXn/j4ex1a0p43JSWBkpquT1DVhQPsptcJK0XKo?=
 =?us-ascii?Q?k5o0jkIAvw6aKrX1j+wNmYkGjlUP+OPtMfIlajSroI+KJopPzsmv24VfFRwq?=
 =?us-ascii?Q?iOvewuo5nFhKyvzljQvGbUyWNksgw5GTffQyiHmEY+BfQSNyPNpNydJ+MVpI?=
 =?us-ascii?Q?BibHHFzFLkGh51vvJmJe8Y4SieFNWrqjGr+XKGkTaozCs/ZWoIinp8kTIf/U?=
 =?us-ascii?Q?l5ec1whrQ9P2O6tnEUGli12khNolVGAfmZCQl7a9/MmGWJLGema7JF89cuDj?=
 =?us-ascii?Q?rYwjS0PNYz5rmsV3ByGd3dyPui0AGZFdWZ5Sdk7wvqeX84uBDJrVHfTSmiAq?=
 =?us-ascii?Q?dUIYdqIW7MkR5A0yV3fqU5J469Z2Thf9OjI8wLFVfm25SVa05o98IAp4Q0xk?=
 =?us-ascii?Q?eaDC2KuCGrEirg6KPTsRXoyxNDT51WZZ1xq27A5LXbkJ1i49Sgp5Dp6+G+bb?=
 =?us-ascii?Q?g3LQN2fHxCZSrbJPqU65okYOL3Dx0VyvRlkimm4HggKAF4X3kcmyBsa5mMDl?=
 =?us-ascii?Q?jfcYlcoDOYM6aqkMPnEDZEcWAlFU7bX4y4FPS4aJ4oX3Z5Z2Ujg4zVGDyoQs?=
 =?us-ascii?Q?ArjphcNYXHT3LeIVGTAUL7oWzyeJAmFsgLtQb184EFeFYIWrS8ptYtRy7yxh?=
 =?us-ascii?Q?YJdMMdqLqOBDynNbd6oGjxn8xWHajGwKXqmnqaVr++tg46DuHERN9Elzty5U?=
 =?us-ascii?Q?C61NYrsbt5XChab7xFkcGFbk1/qnKSaSa9Rvy1f4NZSE5CM2u45nHPpK3NPY?=
 =?us-ascii?Q?747dvxYi0k1o/diaBEKkN7EgDgkD/W0mDCaapr8qM5uM+YJW/0jLLFTEA/Mj?=
 =?us-ascii?Q?2/ex7Pb6t13X/QqumqbJThmwUBPHrlHmtH2ruLcPe8wg9QRt+eD9dhafUcNm?=
 =?us-ascii?Q?un3rolhLgK6cZtmJc8QsiK9PkjwMyft3JrFVqI4OGG0B25kebaouLN4mJf/J?=
 =?us-ascii?Q?xldr2mDMcphqVn6lXO27ovcSgF/v9NLKlExgxD4wkijdhUzxBwvoEAGdgfic?=
 =?us-ascii?Q?3BZ1r5Sn8aQ4sS/8JE3ibLhdG94mRTOEHZmFfHobgafK5ATNxnSCBC7pUg/V?=
 =?us-ascii?Q?dVd+iUGt5FvJlZl5kiMYy/jwX6Pm7Rsl2hYogSkq7EbQgfVB05mwV0ApjifW?=
 =?us-ascii?Q?+ClPHfJWKXsRbkY2GMG/OUiYPEOKGdpUApQcBnSVcnxN/A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8f9404-d3dd-405a-11e5-08d9521f9fea
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 23:30:03.2325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GaUFogLWjro2XPFmkoobjJbWcXn0NsM4TeYddB9U5mdq4/Bw33KUbDkOdZjYMXU2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2277
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: tlsXJndZEHQ7z1CPOs-vZM7kHbW_8qAY
X-Proofpoint-ORIG-GUID: tlsXJndZEHQ7z1CPOs-vZM7kHbW_8qAY
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_12:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1011 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 08:53:54AM -0700, Shakeel Butt wrote:
> SLUB uses page allocator for higher order allocations and update
> unreclaimable slab stat for such allocations. At the moment, the bulk
> free for SLUB does not share code with normal free code path for these
> type of allocations and have missed the stat update. So, fix the stat
> update by common code. The user visible impact of the bug is the
> potential of inconsistent unreclaimable slab stat visible through
> meminfo and vmstat.
> 
> Fixes: 6a486c0ad4dc ("mm, sl[ou]b: improve memory accounting")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
