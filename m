Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBC433FFFF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 08:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCRHEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 03:04:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14498 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229743AbhCRHDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 03:03:46 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12I70mCv006127;
        Thu, 18 Mar 2021 00:03:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=o02xxi4nodBEYgowSNBx1hUu460XM96HaZhpTKULHwI=;
 b=V4eI6dBL1ypUJZfMzzvHpAj+bz1JsQK85bzYBa7MrJN1Grks/4d9RR8C8255Ud4kLe7N
 DqDBQ+CnOydxFZOZWyFO49GpDlSUUdtqNqjU6HdPs4mK+6Bxaw9mv4qIDnwxyBOKy3Py
 DCtjgAbD6e9Q514t+9vFFkSzPBDOBMedSIw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37b3bs1ccv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Mar 2021 00:03:43 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 18 Mar 2021 00:03:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOot3+HeJdK9LUTYRap2lk+l5FNdNjghUzmLjUTnJ2LSfL9XI4pr0aFuX7b1FAyabDVT5LRspH3LhFjs/XjCc47U85f22VPk8AZNhJk1AUtux/OWV8SZKxgmskfwvIt6wjrVI0wHqH3jRooGC8AdRhM6viI3L68DHP/lOQm+v32d1wqyfoDuKvl/DpwAFNAK7vEc6bx9hgbge4EuiORLsNjcofVDbUt45CMg/6GFiNzzn0HdGEMdmPQHhHSAnKR3OtyQ1omomzjbRJDxIRn+YZifZGfUXTHDvdrU6dZNVS5glOva3YZ0FNAmPDz4nWtiafQjJ5TwMThvooamQTqPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o02xxi4nodBEYgowSNBx1hUu460XM96HaZhpTKULHwI=;
 b=YNza5tTEbSNlKtdkmpHfMvNWx+o7iA8m29u3XumAzEg9V7UZU5phf1pBiVPjHswbW3/D9ylClNQsg5SafeCT6J64vfmUdoqLMFXBn9OHXc6WvSyNtFX8cLHFTsQwOYjgbKKVpk74y+Y0thlqJ02GeongXSYUMt68g+rtAa8eegAl+TiiKjUSBT3n6ndMO8fmgE//lIqW/mm42QxTaqoF3ji0cekmchAG0WARt2qCfVG0qhP5NQk2zfgvdPCRd5r0AD2gIeZxSpHhPkP7ZLj0CCsViXtXEzHFKcROuj2eyzYWAQnc4muRpw4Ii0QIeqLq4Yc6F4tG0vpXv6ZlKhZTmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by SJ0PR15MB4203.namprd15.prod.outlook.com (2603:10b6:a03:2e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 07:03:41 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 07:03:41 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 0/3] perf-stat: share hardware PMCs with BPF
Thread-Topic: [PATCH v2 0/3] perf-stat: share hardware PMCs with BPF
Thread-Index: AQHXGqn3m2pRtlCATE6KZ0qUM3kt26qHp6sAgACBEACAAPZFAIAACxUAgAAqPoA=
Date:   Thu, 18 Mar 2021 07:03:41 +0000
Message-ID: <B8D1A735-BCE9-443A-8B38-31B0C0A6AA88@fb.com>
References: <20210316211837.910506-1-songliubraving@fb.com>
 <CAM9d7ci=hfFjq3+XuBcCZ0TUJxv6AmdFk0dkHFQD3wx27aJMjA@mail.gmail.com>
 <YFH//FRPvrPswhld@kernel.org> <7D48A756-C253-48DE-B536-826314778404@fb.com>
 <CAM9d7cjAngAKo9EazV=iyNncBZY53-rnE5_8SYuJiEuG4f4-yg@mail.gmail.com>
In-Reply-To: <CAM9d7cjAngAKo9EazV=iyNncBZY53-rnE5_8SYuJiEuG4f4-yg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:591]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7a8705c-3acd-43b6-aa02-08d8e9dbf690
x-ms-traffictypediagnostic: SJ0PR15MB4203:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR15MB42037691ACBE9AEEB3CEC708B3699@SJ0PR15MB4203.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b8b+5CdVVdTZiMWdi8oF45zsOfzTBq/KkNOO4SlKkcfQy43lQmi5yWefrxr2pzR2xeO8Y5/U40jhDIIypO+J8ojp9ez+p/VaW0mJeMK37qKKnFjZiJ9T1MwNb+xnm2OxkurMxVTGbrZrLDHYkJ+ETugR9VHbnXN+TDnCdp9sD9qBG0Tmj+QZC3bBEA4JT4Jo2FdwwqUFSrShnpRyZkihgGeb2ELkrbXnTzGHpqIeFu0AYx7XWxBsngipT8GFqEYLBAMUxQNfmF928KSW27v/oGfcEUYWmUaUbiWGjT7EUM+cSC0eyFKy8DKSopBafNOZIKMIWt2aw2SZsVx0VSd2ueIVndMzmjOwgVMFSusEAdoeIqxq9NYEVU2RO2kJ8zz7sAuNx/Posm0aXXnqZzgsePq/RPwdL8VkOhI3+OISPLMzRymEFtMrTeQQYznNpObACXTdsYf7eZbuW6RhY/7bXnfD9dPilwWcUX5+as0UpSUYHXaKJA/un1hhoQ6kpaO+6F0HTyt5UNUJE6/y3opsUaI8kZ8gacEmjoE1BhqLzZ8OpYJCTXyqBcL8qbVf2rBE31NYbhtGYYMfp1Xb0sMHubWiD9E3k0gHjCadZuS4bbnsG6wpnACo9OEbly5LzA82UxyZ3I1OeMoB3EPp1zqShhC8bfluaolwBJYsTJwmJv8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(39860400002)(366004)(6506007)(64756008)(66446008)(66476007)(86362001)(36756003)(91956017)(6512007)(66556008)(38100700001)(66946007)(76116006)(8676002)(4326008)(53546011)(5660300002)(71200400001)(478600001)(2906002)(6486002)(186003)(316002)(33656002)(54906003)(2616005)(83380400001)(6916009)(8936002)(21314003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3jTXf+4WxUzPoBQT7912pbnoss/mkiZ/+nyhB0F7RQ05v0fykxvoej1Iha+I?=
 =?us-ascii?Q?Nc8gW5E46h5juv1hzLtivgSzaAaKQJhIOHL8VRf13uDABDBl1cBTWmw4XrbZ?=
 =?us-ascii?Q?BgAaP0PVwwnYrp8ET4dpW1y9I9SK1Ws41i8BEEdSydoyrr0FSlfc76DrTpD4?=
 =?us-ascii?Q?/tx+oR3IG6NMGYcrgcSW51Oa8cfwY9G5qBUhiis5qMpGKS1EB/wHqRs3t+qC?=
 =?us-ascii?Q?maeuqVbiR6xOfcS4WnxM8qca12iQAsPIBUKFEIx2p/mWFA8ULp4u+fc0YHqm?=
 =?us-ascii?Q?LWl25Jz5NBt9s1qVr2+yZsMrL9i6xXG40pxsxja3OH3WrwnnABaaowH27Pt+?=
 =?us-ascii?Q?yZbgx54dVVoE2oXZy/QVE2zwCXJP4h5hqJ+Nf3Qy9hzSdyIVxJhqY/hJkouO?=
 =?us-ascii?Q?S1O6+NGHvkSzshehwhpufR7wvlwSK6NSGzbG9yXom6ohSM+OntlcBas85cH1?=
 =?us-ascii?Q?uiljNRUVHcrkh+Ii3TLwBZpwViUmWTwjqCM23sObsYrMwlP+rHncVViQf9mz?=
 =?us-ascii?Q?CRKGA59vHShHPkH/drdIYT7bOQPncdnZNtqH4zqbjzLShsvdQgCazdqvIkBg?=
 =?us-ascii?Q?FALYOWDFuC4v0GITsu4jMTKh4Gp9T7zThEO7U86PMWEl/3nwDV/bH5OKlMqQ?=
 =?us-ascii?Q?yRqzBy8kDYCUhFyt7AMNjXRorKW2r5y958/b2kuNgC0GkNFB53/n+cAFgO35?=
 =?us-ascii?Q?J8SHCEquR0TZkbfuEJNtghwMxV9baE4pVvue3PgrBIZ4d5pLw5y57zO7ohg3?=
 =?us-ascii?Q?FYd1zfqz2SFm0auvMt4vSl7qbS+31cfYs47V/aVrA0B/1iODRd7ZN+qcGVcX?=
 =?us-ascii?Q?rqulnpfx6RlqXM7/eRy44x9cK1HhG+qJ1gs50bayBcJ6gHkoNB2IhABCQOU/?=
 =?us-ascii?Q?My0p/AbDX0Zxh5ilvxbzvW3s8zlKMZgWeXztGFnJyZdFknA3ERp/IRNhqIG/?=
 =?us-ascii?Q?ZV9lImi70sTk53uV66SASYWhYcjzaNNq/ziX5UEdWbycf44FQEhJqAbsPjeR?=
 =?us-ascii?Q?gtxInd3/zoE0bbM8UsDfRUM2NOOjt4eWT/DWKFKrVgFSEsUM2gqA/PiqkIaf?=
 =?us-ascii?Q?05q1TDxflUlCrKLH9n5g3RMaR9Q5das2mRYNdYzG853IuFCL/YZpxAsIrMKb?=
 =?us-ascii?Q?EKpLtcHyiyNBRx33GIonKTEhFvGf07kHylo5WvKrUwXlaqYPr1CUsEA1fNPI?=
 =?us-ascii?Q?oxWlCEquI/wo/tMTdqh2n/Gx1nKmaonTD4OAf2680s2aR6nKpD2DUgQNlTu4?=
 =?us-ascii?Q?XVfs+WvxQkpH6y7Hiv6SBWUkKj1wUB3nevm8WPYo9UlGDTWmrbQRg3ahzrHx?=
 =?us-ascii?Q?b3x7QeUaSMCMV6jVnqy0xL53inzupY60rqD+PFQqwJUhOLg6dO4ak6CF+VA4?=
 =?us-ascii?Q?AK5XpXI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7C8F69ED0AD0614F92F5C7BB939260C8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a8705c-3acd-43b6-aa02-08d8e9dbf690
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 07:03:41.5401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YOVc3rwMbwUdbr3yBpMfsj4N37vRNLiBw5X8kyBFToQq9y1bTI42A/FCpwyUM7V3+xb7wlRZEdZBI0i9gJaJBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4203
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-18_02:2021-03-17,2021-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103180052
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 17, 2021, at 9:32 PM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> On Thu, Mar 18, 2021 at 12:52 PM Song Liu <songliubraving@fb.com> wrote:
>>=20
>>=20
>>=20
>>> On Mar 17, 2021, at 6:11 AM, Arnaldo Carvalho de Melo <acme@kernel.org>=
 wrote:
>>>=20
>>> Em Wed, Mar 17, 2021 at 02:29:28PM +0900, Namhyung Kim escreveu:
>>>> Hi Song,
>>>>=20
>>>> On Wed, Mar 17, 2021 at 6:18 AM Song Liu <songliubraving@fb.com> wrote=
:
>>>>>=20
>>>>> perf uses performance monitoring counters (PMCs) to monitor system
>>>>> performance. The PMCs are limited hardware resources. For example,
>>>>> Intel CPUs have 3x fixed PMCs and 4x programmable PMCs per cpu.
>>>>>=20
>>>>> Modern data center systems use these PMCs in many different ways:
>>>>> system level monitoring, (maybe nested) container level monitoring, p=
er
>>>>> process monitoring, profiling (in sample mode), etc. In some cases,
>>>>> there are more active perf_events than available hardware PMCs. To al=
low
>>>>> all perf_events to have a chance to run, it is necessary to do expens=
ive
>>>>> time multiplexing of events.
>>>>>=20
>>>>> On the other hand, many monitoring tools count the common metrics (cy=
cles,
>>>>> instructions). It is a waste to have multiple tools create multiple
>>>>> perf_events of "cycles" and occupy multiple PMCs.
>>>>=20
>>>> Right, it'd be really helpful when the PMCs are frequently or mostly s=
hared.
>>>> But it'd also increase the overhead for uncontended cases as BPF progr=
ams
>>>> need to run on every context switch.  Depending on the workload, it ma=
y
>>>> cause a non-negligible performance impact.  So users should be aware o=
f it.
>>>=20
>>> Would be interesting to, humm, measure both cases to have a firm number
>>> of the impact, how many instructions are added when sharing using
>>> --bpf-counters?
>>>=20
>>> I.e. compare the "expensive time multiplexing of events" with its
>>> avoidance by using --bpf-counters.
>>>=20
>>> Song, have you perfmormed such measurements?
>>=20
>> I have got some measurements with perf-bench-sched-messaging:
>>=20
>> The system: x86_64 with 23 cores (46 HT)
>>=20
>> The perf-stat command:
>> perf stat -e cycles,cycles,instructions,instructions,ref-cycles,ref-cycl=
es <target, etc.>
>>=20
>> The benchmark command and output:
>> ./perf bench sched messaging -g 40 -l 50000 -t
>> # Running 'sched/messaging' benchmark:
>> # 20 sender and receiver threads per group
>> # 40 groups =3D=3D 1600 threads run
>>     Total time: 10X.XXX [sec]
>>=20
>>=20
>> I use the "Total time" as measurement, so smaller number is better.
>>=20
>> For each condition, I run the command 5 times, and took the median of
>> "Total time".
>>=20
>> Baseline (no perf-stat)                 104.873 [sec]
>> # global
>> perf stat -a                            107.887 [sec]
>> perf stat -a --bpf-counters             106.071 [sec]
>> # per task
>> perf stat                               106.314 [sec]
>> perf stat --bpf-counters                105.965 [sec]
>> # per cpu
>> perf stat -C 1,3,5                      107.063 [sec]
>> perf stat -C 1,3,5 --bpf-counters       106.406 [sec]
>>=20
>> From the data, --bpf-counters is slightly better than the regular event
>> for all targets. I noticed that the results are not very stable. There
>> are a couple 108.xx runs in some of the conditions (w/ and w/o
>> --bpf-counters).
>=20
> Hmm.. so this result is when multiplexing happened, right?
> I wondered how/why the regular perf stat is slower..

I should have made this more clear. This is when regular perf-stat time=20
multiplexing (2x ref-cycles on Intel). OTOH, bpf-counters does enables=20
sharing, so there is no time multiplexing. IOW, this is overhead of BPF=20
vs. overhead of time multiplexing.=20

Thanks,
Song=
