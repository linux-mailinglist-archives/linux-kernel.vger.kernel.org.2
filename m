Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A5234BDB3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 19:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhC1Rdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 13:33:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28380 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230525AbhC1RdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 13:33:08 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12SHNV8Z016456;
        Sun, 28 Mar 2021 10:31:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=eJ1CGeU8HsUglu5ak2QmL8ebkBedZhN1aflE7ugC0pw=;
 b=YW6ywqLE7pGQfSRoEcJqjWx4TxbVkAROK8ZqOboRC67PzNR2pd0m7v4eGlpALxLej9Gs
 W1TB2W3qbafs/VZg96MrohUjCyPpXH0mo9zyaXdYwMDKxfYpXk0I4r4fuvD/nysWfS60
 OwfimMzWxUG/UgXqyrI0WxvwMKvusH2J/PY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37jmdghg2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 28 Mar 2021 10:31:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 28 Mar 2021 10:31:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gD9HDzLDl4SG2gq3/xgj5GHbiQzgyScomDCNYaOv3JFOWB1vbgVYl+ZkBTLbIEJJgYv/mqXI0H4BuhU7/7ZicTK6DtG+jsiSHloEjTbiYlG5yiuRTfvbxHOdwzfMg9HtmHKaMm7vyFd1IT+j6QYpHMiw+l3mIuqCuPs20k3W35NEfBdrVMhN21zPfZPLxVz7bVQixiNG62gQuTKpV6dERRgPaO+CUWtmDjZvdBjQoN6b0+doQtoiiYdkPXm15AUUwrUThVh9lAeOZ8cpD47Ev3mldYnU4xjUbfb8WdNgXiDYrI6PG+lQdHgquxgcZi9T+8BAzi5rR8eUHrpwxVhUYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJ1CGeU8HsUglu5ak2QmL8ebkBedZhN1aflE7ugC0pw=;
 b=h/g4adOQKeqdF1ks3Ij53s/ECt0smvgBrgV4kW7vAK2kcsXOi0LP0jNc+5UFrU72LXaAv3+oif6I3HJMMbR0De4CnyRWWm7ndj/DzCQ2HNk36O461LhXg9aoof1yYy3W8yU8QDdxqc++7xpY7UPyY19pnyoDzcpq3+DDmGQCntHXhJMSCtI/aIGkxIj3g2fZZPWy3C/GKEqo4mbJqFi5gKj20x93XCC4PopzKqqLihOqcu2cYXMTh+Bd8B/zSAY0mKtI1ewk0yKTHLigkvYtF4ujiWOhAde7lHsRXiG5wFpP6aNPWIK9TsnRoC7+QOwfvroKmaYJ9ONVczqIQ/aX5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Sun, 28 Mar
 2021 17:31:53 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.039; Sun, 28 Mar 2021
 17:31:53 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Ian Rogers" <irogers@google.com>
Subject: Re: [PATCH 2/2] perf/core: Support reading group events with shared
 cgroups
Thread-Topic: [PATCH 2/2] perf/core: Support reading group events with shared
 cgroups
Thread-Index: AQHXIACu7JGNE4cXD0u4i0rSa+9+76qZsHqA
Date:   Sun, 28 Mar 2021 17:31:53 +0000
Message-ID: <E7B865AC-5160-40B1-9C06-0E790EEEB6EC@fb.com>
References: <20210323162156.1340260-1-namhyung@kernel.org>
 <20210323162156.1340260-3-namhyung@kernel.org>
In-Reply-To: <20210323162156.1340260-3-namhyung@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:4e3b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a541005-c4d8-43ea-73ca-08d8f20f60f6
x-ms-traffictypediagnostic: BYAPR15MB4088:
x-microsoft-antispam-prvs: <BYAPR15MB4088656316A79EEBBCD707BAB37F9@BYAPR15MB4088.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HWKnN5SIYZd5M4PvGHC/j4J9sNf+ZLMh45PpMO0DLTl4sWrdoq18stKfSWLKDl3T8pczA93QNa6uhBwtYdHtGnj8PXcZ7vzHsYN94cbrhSL4Lpn9GxJF47P8VnuD5pZ30fIEXT8pVWuP2BPNa1g52d7E1DQN++rBMHfkWA2cxi6xd9r+6P9xwmUKaMAyEpgiTlAB78Yyho+ho9Y7bUQRuzReR2vpjol/2F3NDNPajXYMRjtKDktmQRUt2iSWExQyEAcYF9AXa6/fkGDhp+y7XM28Y5pDiDCEb0DNOq+J6pdiG1kbkTA1TTDcTbWeY+qFfnSKmEu1S8tXC9XLSSHMQhCQe82lpntMLPupqkPmwqmCyCN7k+kBrv+WI5HM9CnezN5SiWfCsekKuvvbPVpaGa9lt3QVaCU8DCuPCdYOXsoA+oGuyTM0AOedEaypop+UHzyioo+lclzgJCbw5R9jqBsXvM2DMrpj+/QaNCpiFLyVKl1rSGPez3d0pHMQaNh7KbzdapuHA0ltJjWyyF12yuRkshOnUjnYF5DMUAY/IaCxG3W7XFfaPqRNhaznm7vT7ouS96wfhbKklXfV+p9yhy3PWjwX1GCUQSVFX39T9CfXah2uSi/UCBts5Bb6jL+NX3DtNDxims0PrluY8Z4SkqVvdr2hUXlqsBSM71HpdwXQbvj0b6CNH9O4P7PVvRKf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(39860400002)(136003)(376002)(8676002)(5660300002)(8936002)(2616005)(7416002)(186003)(6506007)(71200400001)(86362001)(53546011)(66946007)(66556008)(66446008)(66476007)(64756008)(76116006)(91956017)(6512007)(6486002)(54906003)(6916009)(478600001)(38100700001)(4326008)(316002)(36756003)(2906002)(83380400001)(33656002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cGibosWCmUtcGvK0/JHvTwuLzLMpQOLQGXADa3WnuLYfV0X81aweI9pDgIuo?=
 =?us-ascii?Q?4niy1rSbaYhgOoyTtHFvtqsATXrMJcyJB4G3NXHx8xJK/T5NFfx5hCzN5Z6l?=
 =?us-ascii?Q?TiRUT3pjN/dSXFAlD/L21hOBCtOEte/DganrsjrlybIkK2scu0Coct8QRZ7I?=
 =?us-ascii?Q?8KFVCxTuStS12rptsugl3KwJ8umnCLAVIpgQuoLM+bVFZVvNTAbZjhG2mffw?=
 =?us-ascii?Q?B+tEVNvY3CkV02yoiQB6hRfqtuyYoOH0zfeNyBavzX+MV4SjQrlcgriVtvsJ?=
 =?us-ascii?Q?LJVh98GKanf4qSRofHkNqlJiDxS+DY62I1hZacgorfiqJkW+Wcrsu8UcCv0B?=
 =?us-ascii?Q?eLony+xeVuyzmCnNKUc4gAk0q3dGSGPyqBNZbfmPFLzxOCrFLg3ZOKMyCWN+?=
 =?us-ascii?Q?IM86DyWFn/6AFFsf+mC58SefI+mUUk5kGbVu3n5Govjv0p6pATuA+QlO+KHm?=
 =?us-ascii?Q?gufwwv3GNCfGWyUzPuILypL1KeF1vkMpbJptghXvYaB4TAu8cne/KU3G6Kl0?=
 =?us-ascii?Q?sHjxnMPMnt/ckV86fZaNdd2KBqIpuFK9j4kbCYvOw7mVhoyRoBzM8G1OmSNj?=
 =?us-ascii?Q?bAxIo7SE8oWJGnu5++NAgqo+XgDSgqTFAqlMk//RzERJeZubqxLAi3EDlxGB?=
 =?us-ascii?Q?8lWLpH+70YedsaSGiM2/mdGLpCKxW+9wTJE+2kWIS2aY66dkySFgZyOF4fJY?=
 =?us-ascii?Q?/cEGp/U/VDQ5aGqD0y9Om/o7ZN6lK2vPE/fE+jHN52ysEntwuCf6db4VbO34?=
 =?us-ascii?Q?fS1SPnMnyyBObVs3B+KZqJrs8BAFE8eH3Asn+CGoFnADoUkrTZNj7ygH/oGV?=
 =?us-ascii?Q?FMIfmBfxiUfFdSaF2HlCbXYEK32q85+kjOYejB+YotRw5s+KZVXhLCdHGC1F?=
 =?us-ascii?Q?zKHoYXs4muZpPJquN51+qkV14+QM12BoEezovrOKelB0GKNkl1IhLgR2FzaO?=
 =?us-ascii?Q?bZOT4fwg92/e7/kdlvYLeL5XPzBdJnCThTJ1vmCe/8/+t4mpKwe2ZvdmgBCr?=
 =?us-ascii?Q?jPROPC22Kk2T8mn2YtM4o9/+gUH9Z6pkeAHUYP3rPL+xnbVc4kQ3eC3kJwPS?=
 =?us-ascii?Q?PFrYn/GvF02fXiG7YTlJIGsdNCYjIO6CfB8WmtgZNM2eGZ7Sh1ORZ3yjVbD6?=
 =?us-ascii?Q?K63jJA2jAq9lTGRXOYTZk+x7en7MiBMwVZxBbdHYGu6Wb6/hyFDO1wWAIWhU?=
 =?us-ascii?Q?/GCJFXZnG9kLmmTLU2jyztYY7acQOPGW/Cj9u8jq+7D58EFjFfO3NB1er688?=
 =?us-ascii?Q?Kok6A3hC6VJymju9rWlR5sGCsasa2q8I70AGidrf5BHhE7NFoQemiHJcWIaL?=
 =?us-ascii?Q?wEykX9EClG16lsHhMEArQaeTngd7nSZQDsbkiGy6mNFgLhLIyxpLZI8+q1B4?=
 =?us-ascii?Q?gp0qnH0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9FB7B3B98C0E0240A1D2A51820801798@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a541005-c4d8-43ea-73ca-08d8f20f60f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2021 17:31:53.6921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /t9dY2XB1MwSYoDwiSbYFATfJHf8SpjE1inWJeyh/LUifdEFyA3HIaH4f0wVWwX5j8FmP+cui4FG/4hZcejqRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4088
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: hiFxopfhc_A0JiUpS7GO7YMp14HeJMiX
X-Proofpoint-ORIG-GUID: hiFxopfhc_A0JiUpS7GO7YMp14HeJMiX
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-28_08:2021-03-26,2021-03-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103280134
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 23, 2021, at 9:21 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> This enables reading event group's counter values together with a
> PERF_EVENT_IOC_READ_CGROUP command like we do in the regular read().
> Users should give a correct size of buffer to be read.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> kernel/events/core.c | 119 +++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 116 insertions(+), 3 deletions(-)
>=20

[...]

> +}
> +
> +static int perf_event_read_cgrp_node_group(struct perf_event *event, u64=
 cgrp_id,
> +					   char __user *buf)
> +{
> +	struct perf_cgroup_node *cgrp;
> +	struct perf_event_context *ctx =3D event->ctx;
> +	struct perf_event *sibling;
> +	u64 read_format =3D event->attr.read_format;
> +	unsigned long flags;
> +	u64 *values;
> +	int n =3D 1;
> +	int ret;
> +
> +	values =3D kzalloc(event->read_size, GFP_KERNEL);
> +	if (!values)
> +		return -ENOMEM;
> +
> +	values[0] =3D 1 + event->nr_siblings;
> +
> +	/* update event count and times (possibly run on other cpu) */
> +	(void)perf_event_read(event, true);
> +
> +	raw_spin_lock_irqsave(&ctx->lock, flags);
> +
> +	cgrp =3D find_cgroup_node(event, cgrp_id);
> +	if (cgrp =3D=3D NULL) {
> +		raw_spin_unlock_irqrestore(&ctx->lock, flags);
> +		kfree(values);
> +		return -ENOENT;
> +	}
> +
> +	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
> +		values[n++] =3D cgrp->time_enabled;
> +	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
> +		values[n++] =3D cgrp->time_running;
> +
> +	values[n++] =3D cgrp->count;
> +	if (read_format & PERF_FORMAT_ID)
> +		values[n++] =3D primary_event_id(event);
> +
> +	for_each_sibling_event(sibling, event) {
> +		n +=3D perf_event_read_cgrp_node_sibling(sibling, read_format,
> +						       cgrp_id, &values[n]);
> +	}
> +
> +	raw_spin_unlock_irqrestore(&ctx->lock, flags);
> +
> +	ret =3D copy_to_user(buf, values, n * sizeof(u64));
> +	kfree(values);
> +	if (ret)
> +		return -EFAULT;
> +
> +	return n * sizeof(u64);
> +}
> +
> +static int perf_event_read_cgroup_node(struct perf_event *event, u64 rea=
d_size,
> +				       u64 cgrp_id, char __user *buf)
> +{
> +	u64 read_format =3D event->attr.read_format;
> +
> +	if (read_size < event->read_size + 2 * sizeof(u64))

Why do we need read_size + 2 u64 here?=20

Thanks,
Song

[...]

