Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B56306856
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbhA0X5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:57:45 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14494 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231649AbhA0X50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:57:26 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10RNtXNQ000451;
        Wed, 27 Jan 2021 15:56:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=f+qcT7yvRuMknKfQC5Ts6FzPCYsud6zAMsoRsAFRvV8=;
 b=GHYRERRME2TLXv+GO4iFqLGxH55pDFd8vXFCzTPQNMF3+5gZ47kE5ZpbWYovD5EgDrgc
 TMzRUOL4sZnq0Iiu2H4Z02SQW6Cg6KIQkamBSxcfA+NYfeKTh7vhC4iPCOaXz3KWSvg3
 8q23O1pFtoZDpU8SNTbnEKhpIhe4//wrIjs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36b7vwkmdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Jan 2021 15:56:35 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 27 Jan 2021 15:56:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9t+n3zC1sbsGk8sXpBAT0krbKOg0S0GdUro/PyLQRHvyHM494ZCs4HXZtthAGwrvWPhf/JNYp3wzx10v0sU7NpibxDzHpGqJ7PLlnZs//3Lrcqq6785U/m7UZoSiuRe1D1dUHgenfi998FMh5NMIi7QK85SezZPMhGiZ+etnT1cAFBAxw3621/HDanz8NdpojtkQT9opxZypv6T8N0pP3YdiXVYb48Ix6v8nMOWvhrA1Y0p3XLTEz0MTlPx2PxMkp4u0qjxnBHzp4SvnaVzznGNrR6RqBF+r3hvcOHyJqVwRkeBpqh9J3p5l2pRspknjKr93hzUUfxZBfQcS+VDSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+qcT7yvRuMknKfQC5Ts6FzPCYsud6zAMsoRsAFRvV8=;
 b=bhV4RU+A0h8s0AwhX+E5VbFrqWg4YDKk/UOcrC/bE4raUqs+vkSJfprb8bKvKlOsEkTzmbPh23svsBPnbEOcebQQf+LSFYZJUtJWtqN34kUnoBiQJXPfXmjpVGvqIARh/UoPhhwCO1gCZ7+RXgTHxM9UzgnJlZR+n2tht3JTJluSPj2OG3ocORpFobZ+NnPX5O+hGwIetDpipfBkJgbAjAqVciJJW32qkG25y4XMj6WygSla3a7746E2kZyjARylaL1AkquGrKhZdZQoIaV1wsyOvgmIZDGs3INHybPG7uARxwslNdrhYXAH+BGhpHjyMOHqkXcq5p2+kgtfwvF7Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+qcT7yvRuMknKfQC5Ts6FzPCYsud6zAMsoRsAFRvV8=;
 b=lMeZCzl/1PQq8hYG2WBdI226c3daFChIY2/HmENU5RJOAJnGTJJx5sSzrJ13z5jH/LWv9eIuCLdyg+8UYEtV8896aLOXjnz67QWm3js6N3A+3hm+LW+6ZJ+KPgEv1qqN/yYFS/Gj2AuPmjLPHiZL8C9Cq1P08q/RfJUZ5zMh1Vg=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2126.namprd15.prod.outlook.com (2603:10b6:805:5::14)
 by SN6PR15MB2288.namprd15.prod.outlook.com (2603:10b6:805:27::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 27 Jan
 2021 23:56:30 +0000
Received: from SN6PR1501MB2126.namprd15.prod.outlook.com
 ([fe80::e814:36cb:5723:8bf8]) by SN6PR1501MB2126.namprd15.prod.outlook.com
 ([fe80::e814:36cb:5723:8bf8%4]) with mapi id 15.20.3805.017; Wed, 27 Jan 2021
 23:56:30 +0000
Date:   Wed, 27 Jan 2021 15:56:23 -0800
From:   Saravanan D <saravanand@fb.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     <x86@kernel.org>, <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH V3] x86/mm: Tracking linear mapping split events
Message-ID: <20210127235623.kuzewq5ryusitw4z@devvm1945.atn0.facebook.com>
References: <YBHc4JHc4ogwV93W@slm.duckdns.org>
 <20210127225059.246646-1-saravanand@fb.com>
 <9ea21e39-5642-cc84-ab2d-a813cdb773cd@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ea21e39-5642-cc84-ab2d-a813cdb773cd@infradead.org>
X-Originating-IP: [2620:10d:c090:400::5:7429]
X-ClientProxiedBy: MWHPR2001CA0013.namprd20.prod.outlook.com
 (2603:10b6:301:15::23) To SN6PR1501MB2126.namprd15.prod.outlook.com
 (2603:10b6:805:5::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from devvm1945.atn0.facebook.com (2620:10d:c090:400::5:7429) by MWHPR2001CA0013.namprd20.prod.outlook.com (2603:10b6:301:15::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 23:56:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d2c10f4-da7f-4560-b4ab-08d8c31f2aed
X-MS-TrafficTypeDiagnostic: SN6PR15MB2288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB228829F8ECBE82DD5A83901FA2BB9@SN6PR15MB2288.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m0YKmBAsFZ1rzR7+psDT46ZxA0QZnuSN3i4DKpgwfa9lArYVePZaoZ+T1SSQEsS3hLfBw5VVgr0ZuSAY8xXV1tdCqBY4ylsuwCHXJAvj6oZMVa3ayImAFk/q0n3wvvpJgLTdBU1TT+/7bjvK1/tgUBQNO4Vkq1Q+/ti6VKv38Ttbs2vb0YE4iaxK8Bgb7tGsPMxXu1DGFzbFybRTbsWFunLA1VxjuWdZBA5RXzqKn8DwQ+N5lG36dcwnP6j7632B/lbelpr/AXUEfKivGxQIXPDOERDgUJOagmbM77leZqvJkiWZYVOX59snFlVw6B/C9ot0AyXNM+W9TDTA3MxwS0GzVQFELOlc4PxvEDL4HQV5QjScqER2PBwsj0F7lRGS8o62VglpwTvLfrH5+Jo/wmj77QqzmvcvI6bS1YUfXHRPsGctxvktWug8k552UUQcaUeUNHG9LdI0/Zq043yO6ZN39Jt74pPAFoOvqW87gneZziEvJZ+4jfwhtitwiv7i2H4VxLQkXenC9QphuXfHsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2126.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(366004)(136003)(376002)(6666004)(6916009)(7696005)(1076003)(5660300002)(478600001)(16526019)(83380400001)(2906002)(8676002)(558084003)(86362001)(6506007)(55016002)(4326008)(316002)(66946007)(66556008)(52116002)(66476007)(9686003)(8936002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QuNwkdg8NZiMMNzx2cvopflRU4CrxTnMCPCZiQZux598jBaMcvmKWSAaUqgN?=
 =?us-ascii?Q?VbWGSz5AcaByvtd2cNVYp+6VshuHtTHzmY3Xft5PDfKVuYJpguZXPgIERecF?=
 =?us-ascii?Q?KHF8Sbfr/UypdmOaxQ00hPkMhrmHzWjTORTYuGBfhCksvFD+8NH1GMU9v06z?=
 =?us-ascii?Q?3G8rDefAD7VOut9b6NoRS0FiGtUW52x+RJj5v/XhJ0PR5sAgJDcE6JnqAHLX?=
 =?us-ascii?Q?++k5jXzPcujTNFFxV7ln0X0mDI8mmNKQA0RAyjisKPhWa1eC9BEz3VmEqCw+?=
 =?us-ascii?Q?V39he42rW547UglXUt9nH1pfj1TBcOkZe8zUmuOw+e0JvCdzQ6CetZhDHnQY?=
 =?us-ascii?Q?jO7lDSktJOqOf9srlGN5o4Son2/+UJEEIOJMAz9vOfuxzZT3IrIfu2k6EHuU?=
 =?us-ascii?Q?kBqvbhRoT7vSUI1wLzIOYVfZl4kIaHaHOwDuW/n/kA09/CAHQ2enHbwzfRC1?=
 =?us-ascii?Q?F4+AVvSTpGMJDolY/K82wpUGLCQb2XPAtErXsH9k1Q8ldyBPbEB+6r8CQcEX?=
 =?us-ascii?Q?QHBmfWcE6V8WKYpKwyoPz+jsZKIkGSS9QM2BRGJWpkb/K8Jy3mpVEsDvtrux?=
 =?us-ascii?Q?FoB5KrExsMtZdx8iMc3CkPiJAHvqLwopC92qkay/z4vJTaA+uQyfuZHJjbym?=
 =?us-ascii?Q?ygf7B4rVWkcfaRSialij15ETO7uXcOhxlPUMDuuucupUq8HB6u/51JBXLmvc?=
 =?us-ascii?Q?P7NXrZuDjkUyO8WBcKBq062n4c3t8a41yQmELwHuyfF2tMP1pSz/OgbS9UAJ?=
 =?us-ascii?Q?xr997WcGL/c7SCwaxW4kqyjvfGOYERE9YdDYWQ2UdWIELvYZmvS9IPTbI/3J?=
 =?us-ascii?Q?qdOS/I431zZbLtTQXHPg4mkmDdrWcc5ntH8A2FPVVWRHTDrTFpCnGMtmC1Lz?=
 =?us-ascii?Q?KxGKVV/abuZ5oXdC68ci45bH+HpfSuYxYmniUoUBjESNDr277SMfwlYzMa8Z?=
 =?us-ascii?Q?9RFvAnyZ0Di2Wv3twB5pucm73U/Q/z3cEimV7sRc7KjwkdW8FM8Yxiny0YpQ?=
 =?us-ascii?Q?AVGB5EdYjERSnrMOIOy5cQEecpCyRbUzTHQCRSDd1mji4dPHAjzmsMTv5vrh?=
 =?us-ascii?Q?ufsgrRY84Wzt2IheZfgq/+OHx0G3HM+VJ5CvOGnvr51aToKEe90=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2c10f4-da7f-4560-b4ab-08d8c31f2aed
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2126.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 23:56:30.6687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSpcxin3bUBHXnYR2/I1blYss/PCR9Ncox7bwg5AHRUBMRRBiNIMZYexqqoq5TObWzvqTQMZBlEhHeSRq5BO8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2288
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-27_10:2021-01-27,2021-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1011
 mlxlogscore=875 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101270118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,
> Documenation/ update, please.
I will include it in the V4 patch.

- Saravanan D
