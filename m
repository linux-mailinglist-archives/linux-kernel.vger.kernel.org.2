Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC93542FF98
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 03:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239497AbhJPBKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 21:10:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9200 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233157AbhJPBKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 21:10:14 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FK03Jr002506
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 18:08:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=bXmxG/6RI/6YwFWVIKqwZg37uQ52Z24X6dbqeazVyDY=;
 b=L3xJcTWdBY2GiKBCwKoT54Ccshr9cBOVMTCxJ4RYTkugb4sAx1favqtL22HjUb/pqqUq
 lFD65FjRbTEL0Kf31LANQ9LfpwMVGyWoJNidHsaG9YNLjSTnC2yte/scCT52qWOOlbWI
 LkSPefmWJmxP2EDoC7MMEA7X/FZnC+Q425s= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bqg5vspmu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 18:08:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 15 Oct 2021 18:08:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/6OjD/QgF0Wp3GV+hPh5P7W6ms2hLLbMIbCGbw2bfAsRwPyrxrfdClTR8j6+JhvhyzGNCnUaH2+kITlDsZfRiaOzR21nUOSEU41uTfsJTshY/Xj6lxB0Ia0K7AhMsTXVgRi74dRWvT+2rcdXcbwvf5iHYK4SYTM/T+j0TzQ1Iag/e5pegek8wAwn4LQpRzH9i7jlbyuGa9S4X6BkuUIBDfZAKaGpV+wQ6rYP3ncJg4pk/L3OjR8fwWtv/4e80nuOzqMaw4QYNlJ5v3RgaPhx65Y+NCZhOsvj3MSS2GkvNInwqR4GD8Gyz72ypz00uxNhZMM2/kTbXt+FjkQRDjp8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXmxG/6RI/6YwFWVIKqwZg37uQ52Z24X6dbqeazVyDY=;
 b=jQ2Xb1iV/qdTH3WTHIRlYwCzAKqOtBwSFWKcy4aAg9vby6ct9nwEq31mbP1yGCtdvNcIRk8tIZ9Ifz8B7iTfdxWdtRAozuHVMAlHe0prHWGKm5/hpsSLczxNlpMrQnosNElekrLcE5Y9xYARCFqaHuiLqURgoJw8g9qYE5DfIzCbOgU1d749nkBwM4g7w3DWViipRnwxwMiYosPzvmUXcwKsLupSt57ZtDnNeSnuVR+9fIjGD4NQL2/4o69iLr+iyKIcsaFEEJkot9hSYja/68zB8QfPRDpmysEDrTEc8vT4Xaom7xzwfMxWKOaVZSiCZ9OE4lluDdPyUeJ0WoB8Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5061.namprd15.prod.outlook.com (2603:10b6:806:1dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Sat, 16 Oct
 2021 01:08:05 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%8]) with mapi id 15.20.4608.017; Sat, 16 Oct 2021
 01:08:05 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maddy@linux.vnet.ibm.com" <maddy@linux.vnet.ibm.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "eranian@google.com" <eranian@google.com>
Subject: Re: [V2] perf/core: Avoid calling perf_mux_hrtimer_restart multiple
 times when scheduling event groups
Thread-Topic: [V2] perf/core: Avoid calling perf_mux_hrtimer_restart multiple
 times when scheduling event groups
Thread-Index: AQHXwZLlTFeMgeJLOEqerJc97707T6vU0WUA
Date:   Sat, 16 Oct 2021 01:08:04 +0000
Message-ID: <6E561141-B584-4DB8-A33E-BCD3FF572FA4@fb.com>
References: <20211015070403.4809-1-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20211015070403.4809-1-atrajeev@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: linux.vnet.ibm.com; dkim=none (message not signed)
 header.d=none;linux.vnet.ibm.com; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ab389ca-24f2-4479-9b03-08d99041688b
x-ms-traffictypediagnostic: SA1PR15MB5061:
x-microsoft-antispam-prvs: <SA1PR15MB5061A77A7B5797E1C3D8C014B3BA9@SA1PR15MB5061.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 94jgPP4ZfVFMv9yAMsPCzOQAe5yxheiIJqWR3BC5RLBQjQodExsqpP9znvRzYuAF+wS1+Dx49d7JBKoA71oII0hzY6Ybjq8NfnsIEZ9OSYt4GxCfUs52cnKnvEGzKzf17zQKb50Dqoygml4f/ZfpE2xwIwunTw8JdGP3x7ThdKi05g2wL6eCl6HvdO4jZUMiX5NxeDx1jK0aVWMfSa67l9RQBMYOWhSWQ6TjgE4VUlAmL6GtecUxhSUYxpeuS+jnrC6QYJABB+BPJQukQk7XXJBK+hzJwlCqg+SQixncRI93eqieG7edZKGtyT4g4bBV4i1hYHgM+w0ZYvBYKT/8tRc2hOEydIVOyFFt4RUHVI1vgOl/FmFe/dCG1qTU0yp63njj+W/Ekd3XmN4bFAydNP4ESGWaMrEOHG65+xKjEA373eij9eR0hFHoeGxt2DgqI9Y2AMvnMafZEk9q7iIjLYcPbGWdYxtSxKVOTVp4Coib4GtN2g+zS/9+f0+MLb2dXDlTmh0/Szm1ol0afsKRjW74XiaK/zhty3oSbNmlbHqaI7priR7+YH5xOAZMQVqTU1/O/ejlLcAXJro/IR2ZZUfagZ7Pnbaft1aw/C99bMpEyqBApjkIH2AalQzXtb/RaWGPN8sEsJ3s7sqWGCtn75yQ6SAvq5xRwXbLYtmcSedZbsMES8cd9Ga/gPOHiJsH1PQMZNW5sa38/l+NAlzxa+Y9jCnCzp8kHIfthzITZ1pVf2lJfZbqkDWEa0i0s0wK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(6486002)(6512007)(38100700002)(508600001)(122000001)(8936002)(5660300002)(2616005)(316002)(71200400001)(91956017)(66556008)(4326008)(66476007)(38070700005)(76116006)(8676002)(66946007)(64756008)(4744005)(33656002)(53546011)(36756003)(54906003)(2906002)(86362001)(66446008)(6916009)(6506007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xBh7+LdgjxYnCM0Q/xdRIhji29oMsleVt4TubFuFTXvffrj/98Dp5/4YV294?=
 =?us-ascii?Q?yMDhrSqiTdoA0tZy3ugb1X8Ed6LC7obGCo5xO4Wg3+G5P+ea+pxCJ1grTRt1?=
 =?us-ascii?Q?RMZCfg0hhrvSLGBE86p9TSNZnOC5NEPreOaEUPStU7urJmCX3ZO57O/+jvrm?=
 =?us-ascii?Q?94f8Vzsa++rq4M4yRCX8yo/aAWwQWpgruycVgJeCAzfvy9aPOOX0jZ55VaJ2?=
 =?us-ascii?Q?/T4fU1bd6c6vk6FQbkI78o0iMVLz+Iw8SV6MEnQnwqnzwTK2Z5oWFaGE9pkM?=
 =?us-ascii?Q?yHvJzkqtConLto0wjrKwEfmMzCkN5co1FgoxJgnLQYney2YGYobc7TkBrizt?=
 =?us-ascii?Q?tORWunZSNmskfcChXc/i8tgkeW7zU/CPOe/i5VmhcU4p1TbDZ0BCLwh6Koky?=
 =?us-ascii?Q?ZZc28NefWSaSw2IUfL+N5eHII4meHMvY8nvNUVUsxLHADqrMrFcRPIai3eeq?=
 =?us-ascii?Q?7CcGg5TwQ5IWYVHJOpkQcOVYHL/xnIwLNugEORbiR1oPbw8uoRxb/eNdJb1o?=
 =?us-ascii?Q?li82gVfGv6QgfQ+NR2+nC6tQL5Ro1/L40+beW6/nq0awU9nWedqVq/1aqNBu?=
 =?us-ascii?Q?i8FmPRad9Six0dedLksnPKID37dXWJBjlp2xHGGIOVRMfKYdnP6oXlq0/F8v?=
 =?us-ascii?Q?AgW03zAYfiGcifZt5CKMbVhUz/uwDV2G9Mzcz4QxpopnTWzhDPdQRgQpvSSU?=
 =?us-ascii?Q?DZQdx57QUIsVHYFwD89NmxkQsVSjjljdXXPwDq5muvDlRC16GJWem7TztBeL?=
 =?us-ascii?Q?icME5LllNI+ho/YXPusclZ4p2kZizBeW+Rt/5Bc2vj/vSPOLGpVsSXN/yxQo?=
 =?us-ascii?Q?RQdIL6bfNfmtPhvNVlVCwrYsfAdMIiq2A/ptSdRQW7zOtx6Vh3ddmN2O7uT8?=
 =?us-ascii?Q?rORbufeDTG5DFN6QgB51YpZf67l/Hlc6nETpLXshEkbeXgCHsokf1DwRdXoG?=
 =?us-ascii?Q?dCE7G+lK5BT/Nobl0QD0XJbcsd8/KDMuIiHYGhZxFo+Sx1l1qCY7AzzPv8dj?=
 =?us-ascii?Q?pDWKAE4vUsniwtNninZrNPYD2UkMOOUFC1lb8/iX5VetTINzTiEphhSqiTJo?=
 =?us-ascii?Q?LgYVMKIiaUxPYuRWzoLY1sKQ2z8PN7bPDJ+k70SepjBg6w/Q8hE0GpkkVKC4?=
 =?us-ascii?Q?SvXt3RrWeXRalWHVvM5xlik8Vp94U6ReqCQlJBX76G3k6I6MCvWcvJQe+ozC?=
 =?us-ascii?Q?XuKFf7EIIgdme8w75dk/BGQjSUMRsn1DcZS761Cw753yc8MkG5p6gDTbIfBO?=
 =?us-ascii?Q?aiGDAoE1FAEkzUY4DDD15aZZ0S/Lhs0DHdv9UsAsT/oG59M0Fzss3fiD1uE0?=
 =?us-ascii?Q?x+k6QB0pTpL7ezp8dCQ2PhEw9zWFbT8hAW4Wfq/si5qhC/n7oQCnmjgMccjw?=
 =?us-ascii?Q?dN8dfEk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B4D63C2A27C29F45BCAE1721C67EA397@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab389ca-24f2-4479-9b03-08d99041688b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2021 01:08:04.9281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KvAkD6QxKixdGdurHC6r/+F2UVvOh5qw0jK12DSEFZWiTPxObvaLvYUBWDoiJ+S6jJxOPu/AUWUMyPP6CWY6zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5061
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: tvm9PbqrrgoOKvqgW0ZnMbYNuT7Emr_F
X-Proofpoint-ORIG-GUID: tvm9PbqrrgoOKvqgW0ZnMbYNuT7Emr_F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-15_07,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=994 adultscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110160005
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 15, 2021, at 12:04 AM, Athira Rajeev <atrajeev@linux.vnet.ibm.com> wrote:
> 
> Perf uses multiplexing if there are more events to be scheduled than the
> available counters. With multiplexing, event groups will be rotated at
> specified interval of time which is set using "hrtimer". During event
> scheduling, if any of the event group fails to schedule, multiplexing
> gets enabled by setting "rotate_necessary" for that event context and
> starting the hrtimer by calling "perf_mux_hrtimer_restart".
> 
> Patch adds an optimisation to avoid calling "perf_mux_hrtimer_restart"
> multiple times if already rotate_necessary is set for that context.
> Even though "perf_mux_hrtimer_restart" will just return if hrtimer is
> already active, this could avoid the overhead of calling this function
> multiple times if there are many event groups. Patch adds the check to
> avoid calling perf_mux_hrtimer_restart() for each event group on
> every schedule.
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Acked-by: Song Liu <song@kernel.org>
