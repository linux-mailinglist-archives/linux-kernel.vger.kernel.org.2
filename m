Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD1134E14A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 08:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhC3Gd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 02:33:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39396 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229468AbhC3Gdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 02:33:36 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12U6OYL3032515;
        Mon, 29 Mar 2021 23:33:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=gpmMS26TLU71FzatxD174F59kCqW9Yx1gcJMXfs9EdQ=;
 b=cpHfH7qbuFbm7brWPCaIfMyrGZAWBf0jn3sajos5QTwQ9kWQzFNHj4deKKgryrCwmpno
 HoxmiQBalxUYZpSOyz/WvduEC6eX+VstWvBP0vOE8bqCnuDWOBLaL79BGMESGzMgzWUc
 vnlxY0N5jmQdyo3mnyrwujKgTL20wkgsZgg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37kcfndr06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Mar 2021 23:33:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Mar 2021 23:33:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjL4n53TFZ1tau/eINiKFaTHCbLZrYLUEMNzeJHURXChtvw6FtIxPnhJtc65ydQxkhGmIKNWSN/ZOIf46kvHeE5A2BVhC4RSOOizNW0Gweh8pLtiNT9CGofX3J4tM6Eh1wWDVYj603TrVmqfCv/9R8e9z2ERmU3v6uCuBxxdmDThc5WcNGNnxI0f4KcvGSwpZfk3rnMAWva6B1e3OZbnknHFNeQ9kHW9OhhEig0QJVszNuGfTlcB7eKvuJQiM5one0yblmejnSmYI3E7cNiG2cSmuoW5tSKzHqTkk9BdTfsxFvffm1746rSIKOHDQvc0VAPempfKQenAfDTkS0ZhvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpmMS26TLU71FzatxD174F59kCqW9Yx1gcJMXfs9EdQ=;
 b=RQi0rsKle/Ew8AVbR87XIQIHoNmYGzk9/pmqA49Js9a1vFq12EsO4eC+wutdJ6R8mPu+EoQudl4RGHmo+ebZlUdzeolayXipbN+D7i2dLYQBeapAF3+pVYbVKkssMffbkgv3xsuvljSzs6HwQ5TWn3/e2pjD9MWb5HfGkqRXQjrFiq58QDGYt/Dmdx1bAaHGmkPaXTNIo6F3C9ERFUyqZUashrD8rLcVjvecic5G/7YxL/g69f4+ajw5jeq67uIqC6dKKLPgN9rWdlI1mv1uLOgI34jVAzNJeENZ8Ena6oUr91UphCSjHPhHEbCtWqWAp83waxD8Q/W/TaKXfczr3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2583.namprd15.prod.outlook.com (2603:10b6:a03:156::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Tue, 30 Mar
 2021 06:33:16 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.039; Tue, 30 Mar 2021
 06:33:16 +0000
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
Thread-Index: AQHXIACsCyQjF284/Uq+advPGrds7aqZrFQAgAEyVQCAAT52gA==
Date:   Tue, 30 Mar 2021 06:33:16 +0000
Message-ID: <8B2062CE-9BD5-4F17-B831-38C9274A1509@fb.com>
References: <20210323162156.1340260-1-namhyung@kernel.org>
 <20210323162156.1340260-2-namhyung@kernel.org>
 <180E871A-7C5E-4DB2-80F4-643237A7FA69@fb.com>
 <CAM9d7cg6-D2G7ii0sEJoEynvvmXUz=QsqjXG5K7j947DL1PymQ@mail.gmail.com>
In-Reply-To: <CAM9d7cg6-D2G7ii0sEJoEynvvmXUz=QsqjXG5K7j947DL1PymQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:6e51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32abc2c4-0f90-469c-a775-08d8f345b3e6
x-ms-traffictypediagnostic: BYAPR15MB2583:
x-microsoft-antispam-prvs: <BYAPR15MB258381FC06D2985C9F1929C1B37D9@BYAPR15MB2583.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y7sKsB6Oi/mKp3/GuCr+SGstH48zj9drRLi0TC3ueBxUDgcsBz735NytGxO38QU3HaWj704TwZwBzVBdrWi/cCumZekHwV5lGEtOLLiycHh+BcjfLJJB+UckJ0X/MuInikjUDJdE8V2wKxEwVMHYHi7qMgX6ZlxextrMgYin+/3q9gi8Cp92ipzQPeQXRpW06C0vOCKaCa6sPY7c4XiHl1pNr0OCui7Ah98oqkJZ8HoDubNtMV0pQbb/Yj8q/CfvLX4VQcnvi7/NRNRiRyCUwMy5c1TsPVxL3PMmzXCbXvbXjLU/1hEUaQuQp97icyIc+zd2OmnSmAYznHN77MRrx0uhBkG9SGsyJEjnUbaR6wDgtyCq6wlze4x68+jSQR5nKzKnblI8mVNcXKniBtV72yiDdk5Xqf6e344zZe5kv0uV2VyMxYT//tIZoDnUnXAPMTB1q+FbJfpSjsJmxZnp6MlvLHJv+JjyfBrUvAD7MtUcDC4+Os2E1uy67/ZVzE1NOj8gSDpzmxgAXvXzQuej81ZZom530Do5E59JwyJ4NJqVlbd9xeqjY8EmrM7O6IYEnZLDjuXiwDlAw/FyTTYq3yVVpve5xUlZlJtfC8DSa4rTMMZyLdDmaDFJdp4axCOidQmGqNFhbGU7TaxaW9SOHEwZH6DW3vxU4EnE7hNwXbSolawha0TdLK+azhqgHciZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(39860400002)(346002)(396003)(38100700001)(8936002)(64756008)(66476007)(6512007)(66946007)(66556008)(66446008)(54906003)(6916009)(83380400001)(8676002)(2616005)(2906002)(478600001)(33656002)(76116006)(6506007)(53546011)(86362001)(5660300002)(7416002)(316002)(186003)(6486002)(4326008)(36756003)(71200400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+TuCTK2ROBPLVJJmU6BncbNJrMx1RddmVpv71QBgeAQI13W+D8ZlBx9kh120?=
 =?us-ascii?Q?pxm/zEsFzgChuCeSOBH/gU+lmC8ZjeItkEvUE/1oM/9tBlGEP47mw1kw4WDK?=
 =?us-ascii?Q?SEk+FkZCJIfomdRJRyw2XKldmw3s0xHD+vbD5E7INjO43bxxTzcPBEgPD2xP?=
 =?us-ascii?Q?NlajsTBUgaNNTSthfNkrglh9dl3HxBzfCMgi55AlC5f+PxZp65J4EEt9LkEW?=
 =?us-ascii?Q?EDarmZ8bJQ5fYM4OhOMj2Y51fDmgUZSqx5myAHQzBqpf24SlRMNNF4UZz078?=
 =?us-ascii?Q?eu43HxY8mb1BOn5hnOgAgtosCc1bSaccoPeqXuhvO09OYB0gYkxN8mXZRpFJ?=
 =?us-ascii?Q?DVjd49de6JiZQitl7ADBjoFSPdFtHYM4HUbdvfl7dQbKd8n/KMUxe48xbOrW?=
 =?us-ascii?Q?Qp4di5ofXKUkFq1VejidvRy60maI6h4M4LbdOJTzWJ0+qm1gGwvHPpFF3Dfj?=
 =?us-ascii?Q?5lh4aWXHMBGT7j88RanNGD0r6qcI2RIrbXaP/Jl4NJvTTIuN24/yWULD/y/1?=
 =?us-ascii?Q?K7aGhnIQVO4jNFr3s5itbvBJfC1f/N3X/emRqnSqT12yKgsAHTPgXYF50Boj?=
 =?us-ascii?Q?XWBV8nwxMVzUam6kzTxhtaUSu2seiEzWzVMWnmVmCVNYaKqIL+fzGyN6hXC5?=
 =?us-ascii?Q?12dW7IG9ohCGzTSqklRQdcetzk6EgqjD7v0lYN0Xyj4H9Irvuy74kKVreCrY?=
 =?us-ascii?Q?oNvtAJENhT6IjFvoHY35XpnmNz/n5NKOZIeN1pThSDWi/vXccePJbczY5nfJ?=
 =?us-ascii?Q?nEwe9U0Ffg0g9KCcOHoBQA0k9OJ3Ni+PBQMgrY0NOALnpkp59EErFn4DoXtd?=
 =?us-ascii?Q?dz2E+V9gAq63+H2PhjvhUePDOJrbKWuqgXSUHVdz++fs7Dt234BA3Wsp94Y8?=
 =?us-ascii?Q?5nwWHYDbMslZXNwshr8Tty8UXsiRF88CKziv82U+huw5iGNl9S77bguthsZ4?=
 =?us-ascii?Q?8xJCI/Po7yX1cKMgAKOG75sNpKbAQhWfFCeT9mD8c2uvzL2yKkdz8Hmq67Gb?=
 =?us-ascii?Q?6XZcVZ+bJRiyuXZQh5TZ5KhDfdeda8QWYmLlLHsBDWLvlxm5PQUImi5uyxb1?=
 =?us-ascii?Q?hX9y8557mRL2XUTKIDQxHWjQfUCp5KCUvPsR2iem18+f94xCvdJFYy+qUmUi?=
 =?us-ascii?Q?R9rHNSBJy13DUzAanlajHpzhwrTUxo72Uh7xTOmwevMG+SQgUQIrQc25KX9F?=
 =?us-ascii?Q?r5SZHlgeC1jjIFsRZNK90A70+p+HJwEbVXPA08WyVJg2hf4jl9FFLAnVZMPa?=
 =?us-ascii?Q?HwQY7KAXvl4/68S164WtKwbX+6heRqKtm1sqWrJ7ObcYsx4eAMe/OLEM6RpA?=
 =?us-ascii?Q?gDegDybeQGYTBHknnkLf0HuXxaIKyRZjLwvl9OW41rYFCBkiONWiSF+1qAJZ?=
 =?us-ascii?Q?f25fgo0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A7090FB691E6E143A432879816F2187B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32abc2c4-0f90-469c-a775-08d8f345b3e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 06:33:16.8766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 35uVJKEbECZMfYSrjEz5JVbNrHgt/FPJ1vRoa6J8sWCHcW7ztk/z5FbYWvsTP0Ptg+6vxncqwE/NAcHQQj0MIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2583
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: JHgFNZkL_qFfU6dOr0mojEp5XwQNNcz2
X-Proofpoint-ORIG-GUID: JHgFNZkL_qFfU6dOr0mojEp5XwQNNcz2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_01:2021-03-26,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 impostorscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103300045
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 29, 2021, at 4:33 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> On Mon, Mar 29, 2021 at 2:17 AM Song Liu <songliubraving@fb.com> wrote:
>>> On Mar 23, 2021, at 9:21 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>>>=20
>>> As we can run many jobs (in container) on a big machine, we want to
>>> measure each job's performance during the run.  To do that, the
>>> perf_event can be associated to a cgroup to measure it only.
>>>=20

[...]

>>> +     return 0;
>>> +}
>>=20
>> Could you please explain why we need this logic in can_attach?
>=20
> IIUC the ss->attach() is called after a task's cgroup membership
> is changed.  But we want to collect the performance numbers for
> the old cgroup just before the change.  As the logic merely checks
> the current task's cgroup, it should be done in the can_attach()
> which is called before the cgroup change.

Thanks for the explanations.=20

Overall, I really like the core idea, especially that the overhead on=20
context switch is bounded (by the depth of cgroup tree).=20

Is it possible to make PERF_EVENT_IOC_ATTACH_CGROUP more flexible?=20
Specifically, if we can have
=20
  PERF_EVENT_IOC_ADD_CGROUP	add a cgroup to the list=20
  PERF_EVENT_IOC_EL_CGROUP	delete a cgroup from the list

we can probably share these events among multiple processes, and=20
these processes don't need to know others' cgroup list. I think=20
this will be useful for users to build customized monitoring in=20
its own container.=20

Does this make sense?

Thanks,
Song

