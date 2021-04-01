Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD4F350EF1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 08:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhDAGTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 02:19:45 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13220 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233255AbhDAGTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:19:39 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13167ndk015678;
        Wed, 31 Mar 2021 23:19:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=UIniQkwKJg+jl/9UdVNK5ca+xuUBTkZGQqaZUBWIdGg=;
 b=Bpq+RYA1goMGpRCD8qO2Ld7/s9NqVKqufLAqM6e1pBksAAGRJ/Wr/vGi2/BZrQdNJxue
 6Sd8SvkdFD0MajYD4D2LWaPD7oPzvKyroVsyTBpoPQ9wFR9VkFXtJrkfPPrHGM19BuZB
 rBNDXwTebqtApufl3OyzI6CorI8IQqqdGig= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37n2a21njr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 31 Mar 2021 23:19:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 23:19:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfDBVSmIfUfsACGAeXdXwvM3nQ2vbCIVimBGZLyH8pMIo7yq61F/GL35XCQ1NYQiHyWdv3XbGpW0o4cPrjlaURhZ3Muj/6OT3Kw6uoH+X70vZ/UoLX6vAlrE7LxrF+BDVem+yrGxoA+zCkb/GHjAJwWrmDJK1r+iEwf36/a+aGtwBynj61U+D+fR6yT0hgH47IlYbcS6Iw0q4ems7HEshDG7DNblzQ/BQI57/Ucezqh/KECMOr21tR7W96rMpqRmdONyzhwHMAt1TdsbRpyhTjHb+cVC9SYQkmY+WakmiQkW/9aygLgm+4nvYBuJl4aJWHDVm99afreqX5pbPv5CQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIniQkwKJg+jl/9UdVNK5ca+xuUBTkZGQqaZUBWIdGg=;
 b=AC1+1l3o+DTUm8EBC7Fgqhc1BWtznFQT4p3yulnJTl8vMSyXakdXQdOAa0hRkfjJXGIE+oRC+vX78kDoL8w5nanOWXrckEGrSCXmvDVH+JVHVQTsWaApmBTjafnGBhgMNaTn+iNiHR71kErgHcxTstEcGJcj/52YxLqL7IYzKSfeFOksl0wU3YHBBHKn/aiA9jZKIyerSaFSUEkMBBwa/WaqNQyFjzqs7+xZMKyc1kk32dKuifMCpSGkqcq+eeIoRtJWQOab23NOJQQ4Q7/8Eri+X1mar+s+UUJITLGlh75eZyMt3DGX3byj4HeSO6kZm2mwausKfhXBG5lLqq4a9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by SJ0PR15MB4567.namprd15.prod.outlook.com (2603:10b6:a03:378::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 1 Apr
 2021 06:19:19 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.039; Thu, 1 Apr 2021
 06:19:19 +0000
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
        "Ian Rogers" <irogers@google.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] perf/core: Share an event with multiple cgroups
Thread-Topic: [PATCH 1/2] perf/core: Share an event with multiple cgroups
Thread-Index: AQHXIACsCyQjF284/Uq+advPGrds7aqZrFQAgAEyVQCAAT52gIAAkMUAgAKP/wA=
Date:   Thu, 1 Apr 2021 06:19:19 +0000
Message-ID: <8C7049AE-A3B8-48C2-8A4B-FB5CADE95F6B@fb.com>
References: <20210323162156.1340260-1-namhyung@kernel.org>
 <20210323162156.1340260-2-namhyung@kernel.org>
 <180E871A-7C5E-4DB2-80F4-643237A7FA69@fb.com>
 <CAM9d7cg6-D2G7ii0sEJoEynvvmXUz=QsqjXG5K7j947DL1PymQ@mail.gmail.com>
 <8B2062CE-9BD5-4F17-B831-38C9274A1509@fb.com>
 <CAM9d7chtYw0v49Q5ue6B=D_8kV6ZyMvT7p10_jxsHMc+H309tA@mail.gmail.com>
In-Reply-To: <CAM9d7chtYw0v49Q5ue6B=D_8kV6ZyMvT7p10_jxsHMc+H309tA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:7a9f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 530b4e93-13ab-40cd-cdfa-08d8f4d61585
x-ms-traffictypediagnostic: SJ0PR15MB4567:
x-microsoft-antispam-prvs: <SJ0PR15MB456751F1848B1309F3A65AD9B37B9@SJ0PR15MB4567.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 90qS+jYAAB+QWwyk+R2QskASSvNEsRMciIHURD0JxbSJnTVUvJzXLZDZ1uS04Tbm+3+PEnmx8U35Q2xrBEU6Tku6Acu3YtTHNrBzeWcfs12rVzZYsE2qqHJNMvIjYa2kIeKBJVM0WoBMXNg0ghxGYrY6IVc8wbBxcBXMEup/5K2VXu+BDsbBJsp7lVP+vITPcOpY+AW5zJhH50yafOIvUld2sjbPCsUKudCJJtoKdpEC01g3rzBcH4rt3lr1rfGA2XHcCCGnmVhpWeuWn7e5Rge4tBdZGqLn/X+EI/usAOsoY75vZ9GC+TNWNhqoUd1AF868ahRwNVnTPCmGPaEAPLq0bjPSKwmRa6QMDL3YPmVzZTCtSzMwZiidCxwFICc0CjBwkJ4Qv/TTfXmqhSLrk/7VTF5si/kHw2uVyapJ1rVPLSPRqiNAUJApvXpeBN8q+bUbviEiyTjU2gawmJFgtCYpfqHwSLjrra7frGRgIWu2oBKmVc1K2biUTOY2msz5SK7rLbrRkQJmx9Aw+uAUJosQOHOB/blFb1pOqicHOkYlkszZ+duvA5pOmyXuLoHh3CbHRB1xCYBF+xtEBFe+sbYqNBixZML59XDEQGKacDT2UeWCaY6LFE0VgFJ0qJzTWpJNUm4dq8qW+I+XL01KczKcsdx+bV3XVrwtoXnX/qkzIMqJTYwOBxOgP5l5+t28
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(396003)(39860400002)(136003)(66446008)(66556008)(66476007)(6512007)(2616005)(6506007)(38100700001)(8676002)(64756008)(54906003)(2906002)(33656002)(6486002)(4326008)(76116006)(66946007)(186003)(6916009)(8936002)(86362001)(316002)(83380400001)(478600001)(7416002)(5660300002)(53546011)(71200400001)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DGvUWHvYR2wana0ZF+GwpbDoeNLROnUJp6/CzerpC6Nk+SIdCepuh9msF9VJ?=
 =?us-ascii?Q?6EqbO4kfmUuRRyj/aClPzoeuL069YYbcViBHWkFQ8DAkjPpxdP9BC//FJjRP?=
 =?us-ascii?Q?es7H5pE0D3ufBlLGZrdYc9dJhTUcNcHbYFvebmGhgzpoj1vb9O1TAHU53t+S?=
 =?us-ascii?Q?kYNC9lpVwLmi7tZq7i2rW4u29mZ/jObDqeM9voGwM/IaXKldkrUMCW+yTcAl?=
 =?us-ascii?Q?cQXGrAkBR9c/sG63pDdUVxl6NE51gYUehCiMNbPL+XykPbWtjfv2AQJ58TzJ?=
 =?us-ascii?Q?UdEvi6E9NiYZUwzG4hOfOpg4Hvuo1afJreF7O1gb4/LYSdDSGTG+/sqRwlUF?=
 =?us-ascii?Q?uszDKBEuTK+3eQ8jdyRiToThHfP7BtKWzOQ0Qok1IR82mQSa+1H6NvYLqGQT?=
 =?us-ascii?Q?W7UNIb+Ommyfz6paph7OJrbIqx4huNFdIplSGovNWviGOAOGSnMOm1dNmxEi?=
 =?us-ascii?Q?I2mqrMPNQzZUIiP//JAu3l/OOZwIz8MfMYF9W2E7hmMYTaPq6i5ruXgT/SG0?=
 =?us-ascii?Q?Svh8Tr1iR6aa/jbL4K/DfeZ9wcJktj/PvZ4Z/zZhSTxhO4mduvnBmd3fffgg?=
 =?us-ascii?Q?Ow1K7Ob4bU2wr97sYY0FrMxT4D4Rn7CXIqa9Dcwy1AqtLbrwbUTO15QxF2Wz?=
 =?us-ascii?Q?PgNvyvAHP1ZNnBiJKSjua7EnALBvDv1+v6JLiHv82QWOkStaQFk/TNcMJ5Qz?=
 =?us-ascii?Q?rALJQEOAAo/DXB8bfENwt5wR51U5bv+rKhiDBj+Dkug1wBbYkfOtP1QVsiLt?=
 =?us-ascii?Q?EWLkZTiirI208yGO9Z17uFKHOsMVAgC9Hx71r9OecNJKUGCqXwKdJ9l9L6O6?=
 =?us-ascii?Q?Cr6NqYzu3TMG07yFXf1Yw6h5zDWV/0qalZYcfBY9ZKxu0JInkClRhntlsSrk?=
 =?us-ascii?Q?DNdgBhru+6IifdAvTU7yc3Yvdi4puVzEYQrbw4n7VwJ4JqsCCprx3oQyjQAg?=
 =?us-ascii?Q?Q+KHmMIboNMpYfJFgxbL/G5JOV1FQ/kmhHqk42wKl6Es9rmWF+2efG/c22Cz?=
 =?us-ascii?Q?znHRvAMexR7bML8G5vHn1q2Fn0oFtiSQDXpSJ4v6x+I34VyxQkCc4voNPRZt?=
 =?us-ascii?Q?MKKSjDKtOXG6OnAcSixXJ/4JLMUWGAcb4po/kXxQcCzwefY0Q6CaNWVRXjtY?=
 =?us-ascii?Q?m92fHHFOyBXINMkjQrdCHaiPabGJz1P+FdYz+ib+um2G0gHYR0+/Hjd+w21M?=
 =?us-ascii?Q?DPD1Z3VE5nvt93WSNMDeQ/vI2dHWMPAFm5L1XhnLl5J0BBkYlatm5AXwftf8?=
 =?us-ascii?Q?y6hrO/iIFB/qYBTSFjex7QLniW05k+OUKt7xBhrEjeKJ4bmnITQ3HfU1E3Ic?=
 =?us-ascii?Q?wiSUhZr4ccNnIzbhfhk4DCAr/0had8tKv9l1186D/81JA6+JsBsNTpMeGZhV?=
 =?us-ascii?Q?nbnVe+w=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0903B50F31534B47984A4B85580D50F8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530b4e93-13ab-40cd-cdfa-08d8f4d61585
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 06:19:19.2985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cntDG6x0OFkKlhWiS6clZs+1GNWAuhuKJG1cl0DX49CxwnD2DrGk7Yb78pbaGbhRJRMspVE5fsL+6qjRgY/jMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4567
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: R8OjVmpom6L90ZS5UN_WtCpyacWbKgG4
X-Proofpoint-ORIG-GUID: R8OjVmpom6L90ZS5UN_WtCpyacWbKgG4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-01_02:2021-03-31,2021-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010045
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 30, 2021, at 8:11 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> On Tue, Mar 30, 2021 at 3:33 PM Song Liu <songliubraving@fb.com> wrote:
>>> On Mar 29, 2021, at 4:33 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>>>=20
>>> On Mon, Mar 29, 2021 at 2:17 AM Song Liu <songliubraving@fb.com> wrote:
>>>>> On Mar 23, 2021, at 9:21 AM, Namhyung Kim <namhyung@kernel.org> wrote=
:
>>>>>=20
>>>>> As we can run many jobs (in container) on a big machine, we want to
>>>>> measure each job's performance during the run.  To do that, the
>>>>> perf_event can be associated to a cgroup to measure it only.
>>>>>=20
>>=20
>> [...]
>>=20
>>>>> +     return 0;
>>>>> +}
>>>>=20
>>>> Could you please explain why we need this logic in can_attach?
>>>=20
>>> IIUC the ss->attach() is called after a task's cgroup membership
>>> is changed.  But we want to collect the performance numbers for
>>> the old cgroup just before the change.  As the logic merely checks
>>> the current task's cgroup, it should be done in the can_attach()
>>> which is called before the cgroup change.
>>=20
>> Thanks for the explanations.
>>=20
>> Overall, I really like the core idea, especially that the overhead on
>> context switch is bounded (by the depth of cgroup tree).
>=20
> Thanks!
>=20
>>=20
>> Is it possible to make PERF_EVENT_IOC_ATTACH_CGROUP more flexible?
>> Specifically, if we can have
>>=20
>>  PERF_EVENT_IOC_ADD_CGROUP     add a cgroup to the list
>>  PERF_EVENT_IOC_EL_CGROUP      delete a cgroup from the list
>>=20
>> we can probably share these events among multiple processes, and
>> these processes don't need to know others' cgroup list. I think
>> this will be useful for users to build customized monitoring in
>> its own container.
>>=20
>> Does this make sense?
>=20
> Maybe we can add ADD/DEL interface for more flexible monitoring
> but I'm not sure which use cases it'll be used actually.
>=20
> For your multi-process sharing case, the original events' file
> descriptors should be shared first. =20

Yes, we will need some other work to make the ADD/DEL interface=20
work properly. Let's worry about that later.=20

For both patches:

Acked-by: Song Liu <songliubraving@fb.com>

Thanks,
Song

[...]
