Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D17333A095
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 20:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbhCMTiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 14:38:21 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24454 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234344AbhCMTht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 14:37:49 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12DJZobv025728;
        Sat, 13 Mar 2021 11:37:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=2A73qH4paSE5YUP5Q+kJ/7pf2BmNI9XyGGGXJNv4/mw=;
 b=PaiYFjlpVRjvKpn01bmnoKu00YCpkhmwFmiH+J8ErvRqdaCm5YvQ7Ch4ZZP7E2RswG5a
 OiWzZzxd17yR0zSY8AyRFX21EaIbPeVy2NpJMgUr7z3SwS8Cb0xywdarhA3u0n3qY2g8
 eEXuJk4pjp7IxKAkr21BztLvGi+bmqQjfW4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 378ustsce3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 13 Mar 2021 11:37:46 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 13 Mar 2021 11:37:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhvmvN5ce72QyMOHOrBhTqczrRY7agY68uNM5V9QdV4Kg5kxyRxDF4qhonlHhwfJ9XPpxHRYb4r/nFsN7YvA+obK+BP3ZTsweIwGdyapaBXpvaLiyfqwu6QexbD3BTFbikYIpiassy8U3GSuioMgE5CglBWTk8Z2R7JkNUWXwX3SE/7u1aRr4DgKRVm6i7YpTnNup7wK1DB8IO7s1m72TGulFSZGN4Ozd4lWO7QbmNUNpguNFi+0QzC9xxJjThJyYGW/RVzxP46+odrWsqoStp6epqg4ye3qxuzHJn85igqDoDRAWEt5JpAlnntc0wx8ToE39ZONtqarVthOqaq2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2A73qH4paSE5YUP5Q+kJ/7pf2BmNI9XyGGGXJNv4/mw=;
 b=SXVZX8iLZsdGUQfPk5LN5l7d8y69Tp7yz4KtifkTBKvzVdm3fFArn4LqywxCgpxCd3h3wYX/0VWL8+au+2pC+Zw5dRYKWtz/zqUyAlBD4cVzBeKmxlz3vB7jIfem1Q72XXgQ3f0RsXjFGKHUUScTQ388IL3r8laz+tE+YSedMsGpcOKsSIcevgUeuLLNeM+kgd5SjN9wGN1rdOA/rfV6yIXIh4dgys1GqGJPXlIC4QtJR4Zda+mAreA+cWxGT8GVspw0d3mIbrL22oac7pXmdN5JCm312SAuofRgsLc9tV6ROsfFPj9YN+7BduShxsP7XjF0pKvQaIwyFtu5YwX+SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB3256.namprd15.prod.outlook.com (2603:10b6:a03:10f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Sat, 13 Mar
 2021 19:37:44 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.032; Sat, 13 Mar 2021
 19:37:44 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
Thread-Topic: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
Thread-Index: AQHXFuPifzAWbJ/c0EGfxtA8c/wTpKqAB7cAgAB2EYCAALr0gIABGikA
Date:   Sat, 13 Mar 2021 19:37:44 +0000
Message-ID: <E5F52446-8902-4A4B-AF5E-90EBAB7F7A07@fb.com>
References: <20210312020257.197137-1-songliubraving@fb.com>
 <CAM9d7che4Ott6F6SNj8aaXea+wgzDE8pVntkpGr1TCbnfWNXkw@mail.gmail.com>
 <4B3CF1B3-5EED-4882-BC99-AD676D4E3429@fb.com>
 <CAM9d7cg+HD3-vLXX_rUSg1kWSZ3MGeyrQwdJoa5CgbZjeD2+GA@mail.gmail.com>
In-Reply-To: <CAM9d7cg+HD3-vLXX_rUSg1kWSZ3MGeyrQwdJoa5CgbZjeD2+GA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:17f0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e95d5fbe-c29a-4c4f-0004-08d8e6577988
x-ms-traffictypediagnostic: BYAPR15MB3256:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB325682A0CFC48018725B400FB36E9@BYAPR15MB3256.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xrG/8Ub7DxxTT6Glc336a540fJZGZK86TWOiqNlesfMNGkTCEcAOrU1bdtD9gYCy46bm6v8UXQKJQmzpITx02yjlj6l1BWj17QbGQ2QZJqF9XsYb5pD9rLF66Qj6jMlL0RaqLla47iU1CfBml0Z9IkcjtqhN11qNe6pOt66FkaUVDblWeloZZEO/O1ZrNo91gpMzrsdnNPZnUhjEn4nfdjWTZXri9fUCQrCWk12YngsXBpBLGWdMTOcIbJGGWDVle58QTbMu8pgzUvoxNJaPzBJaSGQFhx8QvV2IHWysGVdltPzyjQAMS+B+SpdOlBguWbQlQ50p4QuAK53Pc2hD7pyt/UjnhG30ViO0wec6mwDTP/dmimDdhFqsSBJQglEMQZ9LPkS67GbdSODHCuAyRLTl6zXBRiira8sQbaV0TtRJWbWfIb7p9nzDKOkJErUn30eAXPFHrVpit8xNgspq6FHO6Vp8MvxuTaSgkVd+63pZSPQjqGlS7dOOrUOlT1G3z8FSmfsZ7d33FA5cvHlF5dSpkYVGp9LkEDC7SRSl1sHXTgfK5uhGJqSRk+a1eXLP22h+1rR85nLt9MkvImXBkbGtHJqda2vm4tkynAdDj51tWHVTnTO+1UMfMidxBNsP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(39860400002)(346002)(66556008)(66446008)(86362001)(66946007)(6506007)(71200400001)(8676002)(54906003)(64756008)(2906002)(5660300002)(66476007)(6916009)(91956017)(36756003)(33656002)(83380400001)(53546011)(6486002)(4326008)(478600001)(8936002)(2616005)(76116006)(316002)(6512007)(186003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vPEic2oNAzOyAIUEtz3SQUBeKUKC+xHGdBsJdEKP7JypZLjrWSMRarRtvz31?=
 =?us-ascii?Q?S50AVnt+eGtbkrj+9WvqZBWVDVMCnBtbVOZu/hApyGDf0P8o9KgKBYQIp5ms?=
 =?us-ascii?Q?Izn6hwyWtOgs2ESQ5QnVtnw3y9BBVbMgBVL27BApHm9P9vd1qFtxqY0rBWUw?=
 =?us-ascii?Q?vvGN4IP88qSqHz9g/ebSieKiO2b+9NtkPX8WO62S5/gxRlE1pJof5OBd006Z?=
 =?us-ascii?Q?tVyXgjpjhfBBGLeyJJVXLmTp2Ra3Ms+8dRt502OWgTi6tjM11J9rQp0uHBoA?=
 =?us-ascii?Q?xHv40AYTQOLyslZjAIh6wV7rZq94mw16z570whKXhvW1F0YuB8zvy3lX457w?=
 =?us-ascii?Q?nxCpuLWbq6HgIr4eNUrxZsiF22jPr8zPI7P7MlC97X0rARp/QGgF8Bnhdq5I?=
 =?us-ascii?Q?qtAWUAJKxxQwVWKH0tlRXGHwiAF96ETwdwDtz2V9+DKkdi7Bdi3w+QyRsrG5?=
 =?us-ascii?Q?wlC6IJU09SFK/rGPsTls1wjX2+Eie8WyzEQ9q9YBUEIS8XCtvW4Ol9XEuKOH?=
 =?us-ascii?Q?OBXJzUKBYjQXqpPC0rbqPpHqAiLpJgRbpid450rx0BoVudhpZ/zU8ZklL1aR?=
 =?us-ascii?Q?p+yHI3CdcxVIPC7JcDaKdu2P3Vcy0lw9aACFk9l/LZv6ZwO50fD6rxyTH35A?=
 =?us-ascii?Q?PvvDGP6Y23lXeRPu1VBX+FxEomIgU+CS4JD12Dn1560hXIH6LX7IvMb5svic?=
 =?us-ascii?Q?oBgSzJHezcQFVEvRPx1MK0d5ZM16li4KrHOY5Tyr5pVxlrYAwlPQOwg+x4bf?=
 =?us-ascii?Q?iMPMIflpYk05LTKGm8ttPFdoGKg+TdYRxqNTmzm8bJYQ2vQxhnZEwIofDrwV?=
 =?us-ascii?Q?/EvMLnIZY5aZ4d2HHC8oXpD4ZfCNVAewh2qZkesJs+dqdmzhZ5ZvCI48EinM?=
 =?us-ascii?Q?XPanP5K3iwweRE6XbwlOkDvNA8s6xJBcckfukSXdZ9rga1eQjDVpYHdmVnsL?=
 =?us-ascii?Q?mXYbKG+JVcC7PRs56VfmD3MY2gJn4cSru3xIS4+a3O25GRi4c7LQMtyZ6nql?=
 =?us-ascii?Q?q09PaqyWHe0xMC41miMEtNrfPBAWOUFNn/bcstLTh3aFMc48Fg63vDUOQXqJ?=
 =?us-ascii?Q?UjxP/tbXBCK/InFZZMc5NOHZHI3Lw4MI5u+5QbXv2jTVy8cbtDo86R3msmNS?=
 =?us-ascii?Q?lhqtZcuJ+ZaiH/Z8w5nmPx0Pa9Fg+DlF4U5H95P0O7tpA1YbwwV9n/Zmz7dn?=
 =?us-ascii?Q?UyhV6shYUMM6jzJ/EbAT8TFkSCPdst2GNUHeOTy1ICNI4O8MHU/ekWUSPILp?=
 =?us-ascii?Q?iu+TuAAvJ38BAudRkvSCzKZDXikVXlfY2bHkLjoaky4NqgcVCiM+5XS9bUUJ?=
 =?us-ascii?Q?kiPITFsehmwxT/pIH6DSPC4iz9/Bl3p2B/P1tGJYO2KPrSR6mWix4MGTEMuX?=
 =?us-ascii?Q?e+Ht074=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <85A4066BD1E90B45AA4A6CA484D167F4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95d5fbe-c29a-4c4f-0004-08d8e6577988
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2021 19:37:44.7155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hu2gyH19JG7MiyEvTEvCqaa4p4gk3GmIo0XEvUkD6Ze6XnWx8oyCkC1/2X85oRZZ+Cfi8qz2BExvyRPs9DcKqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3256
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-13_07:2021-03-12,2021-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103130151
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 12, 2021, at 6:47 PM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> On Sat, Mar 13, 2021 at 12:38 AM Song Liu <songliubraving@fb.com> wrote:
>>=20
>>=20
>>=20
>>> On Mar 12, 2021, at 12:36 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>>>=20
>>> Hi,
>>>=20
>>> On Fri, Mar 12, 2021 at 11:03 AM Song Liu <songliubraving@fb.com> wrote=
:
>>>>=20
>>>> perf uses performance monitoring counters (PMCs) to monitor system
>>>> performance. The PMCs are limited hardware resources. For example,
>>>> Intel CPUs have 3x fixed PMCs and 4x programmable PMCs per cpu.
>>>>=20
>>>> Modern data center systems use these PMCs in many different ways:
>>>> system level monitoring, (maybe nested) container level monitoring, pe=
r
>>>> process monitoring, profiling (in sample mode), etc. In some cases,
>>>> there are more active perf_events than available hardware PMCs. To all=
ow
>>>> all perf_events to have a chance to run, it is necessary to do expensi=
ve
>>>> time multiplexing of events.
>>>>=20
>>>> On the other hand, many monitoring tools count the common metrics (cyc=
les,
>>>> instructions). It is a waste to have multiple tools create multiple
>>>> perf_events of "cycles" and occupy multiple PMCs.
>>>>=20
>>>> bperf tries to reduce such wastes by allowing multiple perf_events of
>>>> "cycles" or "instructions" (at different scopes) to share PMUs. Instea=
d
>>>> of having each perf-stat session to read its own perf_events, bperf us=
es
>>>> BPF programs to read the perf_events and aggregate readings to BPF map=
s.
>>>> Then, the perf-stat session(s) reads the values from these BPF maps.
>>>>=20
>>>> Please refer to the comment before the definition of bperf_ops for the
>>>> description of bperf architecture.
>>>=20
>>> Interesting!  Actually I thought about something similar before,
>>> but my BPF knowledge is outdated.  So I need to catch up but
>>> failed to have some time for it so far. ;-)
>>>=20
>>>>=20
>>>> bperf is off by default. To enable it, pass --use-bpf option to perf-s=
tat.
>>>> bperf uses a BPF hashmap to share information about BPF programs and m=
aps
>>>> used by bperf. This map is pinned to bpffs. The default address is
>>>> /sys/fs/bpf/bperf_attr_map. The user could change the address with opt=
ion
>>>> --attr-map.
>>>>=20
>>>> ---
>>>> Known limitations:
>>>> 1. Do not support per cgroup events;
>>>> 2. Do not support monitoring of BPF program (perf-stat -b);
>>>> 3. Do not support event groups.
>>>=20
>>> In my case, per cgroup event counting is very important.
>>> And I'd like to do that with lots of cpus and cgroups.
>>=20
>> We can easily extend this approach to support cgroups events. I didn't
>> implement it to keep the first version simple.
>=20
> OK.
>=20
>>=20
>>> So I'm working on an in-kernel solution (without BPF),
>>> I hope to share it soon.
>>=20
>> This is interesting! I cannot wait to see how it looks like. I spent
>> quite some time try to enable in kernel sharing (not just cgroup
>> events), but finally decided to try BPF approach.
>=20
> Well I found it hard to support generic event sharing that works
> for all use cases.  So I'm focusing on the per cgroup case only.
>=20
>>=20
>>>=20
>>> And for event groups, it seems the current implementation
>>> cannot handle more than one event (not even in a group).
>>> That could be a serious limitation..
>>=20
>> It supports multiple events. Multiple events are independent, i.e.,
>> "cycles" and "instructions" would use two independent leader programs.
>=20
> OK, then do you need multiple bperf_attr_maps?  Does it work
> for an arbitrary number of events?

The bperf_attr_map (or perf_attr_map) is shared among different events.=20
It is a hash map with perf_event_attr as the key. Currently, I hard coded
its size to 16. We can introduce more flexible management of this map.=20

Thanks,
Song

