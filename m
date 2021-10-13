Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E744C42C522
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbhJMPtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 11:49:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49276 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229842AbhJMPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 11:49:02 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19DF3l3K023590
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:46:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=MHW/vdrOsEpjWcw4TNtwJtp3p9fXlQhKiHlwKCUIp9k=;
 b=qYzcLArPc3aJFBJAP3Yj2Gpxlvyu9HndgvAq60066CZUoFcvGdI7hoVh9jhYFX2FWaR1
 w9/W0LWORUdn60uxS1Kns+Y8Cv/09Cmw8kgH70tdr9Ne0dSZpLLR4fitlP0mVbe7/QDZ
 7maq42XlUlyjQx+EGEybxKZi6FSbjdRB96E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3bnyr7980n-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:46:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 13 Oct 2021 08:46:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zi7dSCXxonhwtTu+qIzfE+jbpqpwtSuDFMb2BEr4cibdzHgsJamOZNHnZmMvcSt0yuPp+VHp6SqumAPS8ac4PbtJVXNsCY0v/CVW8sqgu+58PyW2qynmPAi/5sijJomJJfaOX29USpYElO0AJ8MaHtReft2VVS48XA0PtKQbJMiZv4igfA8msPOz5GodW3oVCgnSrnqVzX9p8348v6iBRVrsyEFJWqRQh0xdHU9xTKLo650/gfjzRI7JJAu9UHggWqet+hrHn7djdQFEH6L8uzvh5O1SKY6sp/FGHk8QaGmGwzSt+K2E+pFYy9lkeEiTJe7oOJKwLxSfL11GIJiOzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHW/vdrOsEpjWcw4TNtwJtp3p9fXlQhKiHlwKCUIp9k=;
 b=FJZfL4kQGOTPbGhkn5RFbZPe6x+xlWt8vRqRoQJ07EaUu/nut+/w0I945TAGOHQAM0WDxCc0zKvgcCjFE7W6WZ4DIk6BT6NtoadFs0m+GQJQvmfH1D5ihMPd8mX3BJ31U8EAXhdj2fu90UT4UNbXxRWd+eEFf0n+09cO82B++S9gDZGegrqYQ4BMXhh/I061fFcO5FinMFyARj4KcGeexSKEXgRFEtMd9tln9vRVb77GcvIZO819bfGf8hqzLYRbmfgCysmHTNOK5qKmSQOxAB4atVT7vbSanz3H0XEr0rs1gCfxs1vXZPBhKobWYmPUfOQmzAoOuc3qJNQfD8ARFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from PH0PR15MB5117.namprd15.prod.outlook.com (2603:10b6:510:c4::8)
 by PH0PR15MB5238.namprd15.prod.outlook.com (2603:10b6:510:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Wed, 13 Oct
 2021 15:46:31 +0000
Received: from PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::2918:43fd:5d67:cbcd]) by PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::2918:43fd:5d67:cbcd%9]) with mapi id 15.20.4587.030; Wed, 13 Oct 2021
 15:46:31 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH] perf/core: allow ftrace for functions in
 kernel/event/core.c
Thread-Topic: [PATCH] perf/core: allow ftrace for functions in
 kernel/event/core.c
Thread-Index: AQHXuvY6V8ldFfNNq02JeUD7jin4B6vPV0aAgAHFx4A=
Date:   Wed, 13 Oct 2021 15:46:31 +0000
Message-ID: <A2707216-E8F3-4D91-87AF-6F09CA63415C@fb.com>
References: <20211006210732.2826289-1-songliubraving@fb.com>
 <YWWCrYM1I1MtmCkY@hirez.programming.kicks-ass.net>
In-Reply-To: <YWWCrYM1I1MtmCkY@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65fdfc37-7b6d-4f58-c83b-08d98e60a0c8
x-ms-traffictypediagnostic: PH0PR15MB5238:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR15MB52388548CE6B74A1F1368017B3B79@PH0PR15MB5238.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gikf7pIFnJY0RWvES4OnOSgnF7jUM3Di0QYtMCnH2eSkKMMAgTbM4OLj6HlqAg7P4K6YVjtjGUJFmev7i2ThUwVlONLYqKINUgE0ZFVVmyfoDpxIYeDI0msXNQo0gJE3G4tdN2Jpv3uipDT0m5IlhKTly69rryzINdoGimZOhqBg78pMTNJEdlTONfv03Q7icb7eNIGvRmjUKVlZM77h1umsWaxfjX/R6vC0sLhr/1yo4tXCCGmTR76wq3ohIP1XorW3dNwRun6c6M+Q1B10shDf9oNjpzOf9M4LwNWugbTYxMdk/kOY1GkrkoUT9rSVaH/7gA5MCNRzrpKaGm6CiuZdsCTvbAxNuyZ0aZU8Fn/bbAHZsHbkHJyBTIo8YnNFb8252j7mxtuRsUjzwaTVbAD1EG4mbudlQ/xAQKzBd978Yd40MK5symPEllkZ5xS/usONFiqq6RoU+UaTj6IKQ4qZh4wMpxgiCweRGYtDfkYzDQLDNkdVFDlytuOnWDWfJ9HAzQtC/mkyoCFz2yUyMLUxZDP19Nq7xXEI/XRsM020a3wqOhg6Wa6LOl8DCuAUrKIrjSILq3b8QZj/OdskAQm41URMak5p+yj+Eqq5VdtVccPI/E9oZ7+4qFVULcu9cnW5Cd5+MPOD/jShnihOd03vdfe6cp5c294dWoTLqgbTeTvu18OuIiI8xEVSENoLZEPGuqMiCIzn+ckNYAQkxPdgrBhUi75ow03d/lNv0oU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5117.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(66556008)(64756008)(2616005)(186003)(6916009)(91956017)(66946007)(38100700002)(36756003)(33656002)(4744005)(76116006)(508600001)(5660300002)(6512007)(66446008)(4326008)(122000001)(66476007)(54906003)(71200400001)(38070700005)(53546011)(6506007)(8676002)(6486002)(316002)(8936002)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kcJrJhSQ0Z3QVHYY4/OrEqi8OXgUtXOPPuzyc+t0RGHDit4XT9ZZ/v/8I9wY?=
 =?us-ascii?Q?A/btGFMGOD39uN4E72W3S48RbMHwVrSv8h+aRl3eUE32YLukRm8GCsZxWD+J?=
 =?us-ascii?Q?0/PiwvUWB5JuVaj83QD4H2LbbLaGpaCkin0ACWCfnrapR4y3+URMmftPjF60?=
 =?us-ascii?Q?0gt4u+KkTX6ITcbyRNVLb0Ms46B1zNIZfQx0oBIY6DfHnGYcGgg0UQR2Vy64?=
 =?us-ascii?Q?IOPufkeDUcjAE/aC6Cb5U5eDgQyNm7g4zqu/WZZ4lUbOsZ/jJUbq8faPaTsx?=
 =?us-ascii?Q?4W8Sd5XeXD6JH0Ml2aB19lCFT/BQ+LIYsnhgO9Hp4g7FkjApqjPOQ3N+OLij?=
 =?us-ascii?Q?yqltCt/VX5L3RHwNEOjH1nlSx0Kre9ufALbLC6aafeSE/greytbFH0seQO3A?=
 =?us-ascii?Q?ZXdHc5Wex8OGwdSoudTcCRi3oKRKFi4d09z4xxeMX2aHWZXybEyr41XA46jf?=
 =?us-ascii?Q?V/9R9y9T+jJ2TEkzicijkT4BIOPAwjMzOO0l5omWmR2Bmi3yyfAFCqPfZQLB?=
 =?us-ascii?Q?OuKStX3a+9GXg5aMipVD4XrMvQJ3VkdlpCobLfXA2eYXHdNF8Cj3agm0BCzJ?=
 =?us-ascii?Q?qt5K5sIXn7ko+lhCoeeteJ8eHIf7sNcSfQcsSOn8jAHM44tY6lRh1/bPcQvU?=
 =?us-ascii?Q?n9BKsrU8wiGDmyuLpeSrJC8Woc+HCn8oSsL/HIqzqQJb2RAQNaN59o9B6bec?=
 =?us-ascii?Q?4+R76+Q8DEsrYCudeBRWO9Mhp/Fq+WrvnLl507cRqMR6tycUO+tcXak1pL1C?=
 =?us-ascii?Q?r26mkrfDelqEDJQk3sc69Bc1dUApu7WUECZbv94i1JluSCE98FR+hEV8PEpN?=
 =?us-ascii?Q?xg5X9aWAqnh3grEnCQbhzK4YZHCWsuucih8TL+KLRebFV1F/L+h5529r9CJY?=
 =?us-ascii?Q?z04QGpSFEAY1kwNIsYC0aboqLE7yu8MwOHWbEF1BQENRcqXV1sXaa2eECsqz?=
 =?us-ascii?Q?hTuBJuU2NjswZsUmb9pyFsCR9/1/ryQf+O8KMVUgQPoGfXbn9zXUubG7Paop?=
 =?us-ascii?Q?+RhXKb3robNmuWSy6lyY97atNmq6mrDU9oCV9g7UwCUwlOCJrzOjEqPH24ab?=
 =?us-ascii?Q?hZJtd/sqpU//5uRO7+jddfhNPSALqHavqq3dr3JZUeUR4b+28wuw361lKP9W?=
 =?us-ascii?Q?e09OYS+R6Y7n9pSQtvjFigp9joJzWiD61Ta38EnymXSlvl57NCIT2aCx2HqK?=
 =?us-ascii?Q?5WccFkMhBNTNZyZgj+Bwsr/Enz4/HkCSwCz5Cjk+92/Zw9ESLSj891t5PCX7?=
 =?us-ascii?Q?WK/WE377rWe8lOdOXfWlG7YmOjpHlZkDyW1kpciD6WZSgeH2MdSN875Uabvp?=
 =?us-ascii?Q?+HmuMxrkTnlGiMVvm9iKZC5gbE1gFfR0Ysu+5oxrLOwQOC2wS+Y0GHuGNbL8?=
 =?us-ascii?Q?fLMrk/s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B5D1C00C0C2DB24497023963D9BD8E55@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5117.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fdfc37-7b6d-4f58-c83b-08d98e60a0c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 15:46:31.4327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iC/Ir3F6pTtT1ijO5A4rlhcPw5+zi66PKatp2qgpSFI3Sspw/07rSPWYvq4iBUzppIUc1CRJclHS0C8nDPFx2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5238
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: pF79XDGYEInyovH2Y9imZnqEHufsl4Bw
X-Proofpoint-ORIG-GUID: pF79XDGYEInyovH2Y9imZnqEHufsl4Bw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_06,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 mlxlogscore=841 malwarescore=0 impostorscore=0 clxscore=1015 mlxscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130102
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 12, 2021, at 5:42 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Wed, Oct 06, 2021 at 02:07:32PM -0700, Song Liu wrote:
>> It is useful to trace functions in kernel/event/core.c. Allow ftrace for
>> them by removing $(CC_FLAGS_FTRACE) from Makefile.
>> 
>> ---
>> We had some discussions about this last year [1]. Seems that enabling
>> ftrace in kernel/events won't really cause fatal recursion in the tests.
>> Shall we give it another try?
> 
> I suppose we can give it a go..

Yes, please. :-) Shall we ship it with 5.16?

Thanks,
Song


