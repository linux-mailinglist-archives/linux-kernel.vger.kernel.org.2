Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EBC3B391C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 00:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhFXWSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 18:18:32 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34372 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229712AbhFXWS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 18:18:27 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15OMFQn7004566;
        Thu, 24 Jun 2021 15:15:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=FYJu/nEcQbVJ+lZVt8I9pAAknwZmkFpF61aD6S2YjeI=;
 b=RYQI6TIL6FM8/2t2Ma04fW7OS6sUYYDGTbCbhC30tOzOvtcdY9Hr+s1ecjDTmzuzCpHV
 w+KU5WheUxZzO4m4LRUJcavbF5xyCQK5+Z8CPkLlWikXZx2o05KRPgsZ4YxNbjWc+V2/
 oWVc+mAJsCWVq/gb01aWyGlAVNoNQHvtrsE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 39d24nr742-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 24 Jun 2021 15:15:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 24 Jun 2021 15:15:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+hA5SjnZPtZO6CNNQr/nmD0vBZFy5XdZD1q4zzAppWcz/zK6H9lEueZjX/Is2tkJXb6mq7MAQjqYOIMnGnAZlkNfI8etG/0Gt+2SlHEk1rHzaimHOrecZnwUWPqXrN37LKdBcwyUy3Ux2x/mrwpRgqOcBE9BJt4/dQiq5G6sqESZuMlhtSp9GOXDN9gtI1jQNBhQ9qJLt0seShlGRIjFyuAob6EUrfGakmRKBXTeS1eCtTl2CvdgD3vcdzpiemmQHY8xjheyW/uns4RGp6DdReF+3+71oaEHJO9M36/JSmjTbFxsXa85EksPkb1Vkcxkq9YuhynumtdTPdX8K9Kyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYJu/nEcQbVJ+lZVt8I9pAAknwZmkFpF61aD6S2YjeI=;
 b=eRuUsZrFY/oUde2tnWAbtWVH1H/afflEHrNtpsvu30GQa6ZxLSvuRKKBYFwO2N0BdhG4avH0DKoZ/ri20czbxStBDhDbHizsGkwzhnkleBMt8RYHGLoWeCKI55lyuqeUs9DmyyLE00EWVCf+F+42mlvWKczxv3oBJuuyexqH11ZDWuSDe4/JO433MYXtQQYwwnZ4o+e9rIXiODoSgzjsqreD0rXRAAq5kvFvDkxD7w4l6oX4EGgXvRs29jcQxOc1Ww2ZD4TYAcei9o3zo6ilWqTqO6b3wff4ZC5YKwT75vWwI2Jc0bySvgdzv3AcZfPCJ1XkRKVfYnJaFWEveDHYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 22:15:52 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::38d3:cc71:bca8:dd2a]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::38d3:cc71:bca8:dd2a%5]) with mapi id 15.20.4173.038; Thu, 24 Jun 2021
 22:15:52 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 3/3] perf stat: Enable BPF counter with --for-each-cgroup
Thread-Topic: [PATCH 3/3] perf stat: Enable BPF counter with --for-each-cgroup
Thread-Index: AQHXZzX6p6bVUgsBlEW05HtuW1Dxiasim4OAgAAPYICAALBHAIAATpEAgAAK/QCAAAdNAIAAAokA
Date:   Thu, 24 Jun 2021 22:15:52 +0000
Message-ID: <84A29E44-7B29-43CE-B91C-8912CA09F939@fb.com>
References: <20210622071221.128271-1-namhyung@kernel.org>
 <20210622071221.128271-4-namhyung@kernel.org>
 <C2ABEEDF-04AF-4AB5-BA6C-C8AC5E8579C6@fb.com>
 <CAM9d7ci3kS+=ObL_mfx1Qi2rQ7SYRjdLQLJ5+SVmRUsaUepj_w@mail.gmail.com>
 <D5859F92-8AB6-4327-9D5F-A67DB14CB493@fb.com>
 <CAM9d7cgw5ZtuvA2wwEdVU1rL6Hra2Cy4BTHx0rKsNE_ickjN+Q@mail.gmail.com>
 <A157287B-5DE5-4D8D-B8BE-FF18BFAAC16E@fb.com>
 <CAM9d7chvmH0r85Ezx6kTyDsTM5nWSUDoOjnkEgTkKjE2U5LrVA@mail.gmail.com>
In-Reply-To: <CAM9d7chvmH0r85Ezx6kTyDsTM5nWSUDoOjnkEgTkKjE2U5LrVA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:cce7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3cbd6ed-4344-4488-89c6-08d9375da100
x-ms-traffictypediagnostic: BY5PR15MB3667:
x-microsoft-antispam-prvs: <BY5PR15MB36676216FE4D018F5FE66374B3079@BY5PR15MB3667.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ac77r59vH8sHnMgvVTYqM52Fi2s2ckvM87FdjUsaEy23GzStFzEtJSEsDEn8eyToEMQXxHtVZpWGAI++M5t2XNGLbZhBYUbpgQx7cVj5d3VnJQSIfMFF60h6R1tOLy52bBcj87yctOTiPCjw5aibZByA0WQb9ieEPQiviB/ofa1UrL9RvA99ju1YZmrw9+oQVgbJaUsUI0O2DQ53Q5FJlkwF3nHipdc4v4lGShI/lSIiW0DcO9OrzQ3eKqpTySPCQQyXH66Ss3C31rNW6/Q4Wdhs9nRWsRNzevJxbBQHOvdF3U7Tkj3Zor+rB1kent4Oy8YaZIbLnD1yoc2q3HEXmKv+ozTvMmvwf2YfqF8FzkyW0Z65OiO1uD+LbkoB0LZZpCKXXDSG8uYsYaBPqwo+uM8BbJherXMq8vw9mZJuYjJr51Whv0jvThhIF4rBE15TWdLE/OK2lTB8mYRKK3Az0a+y8pe50a2p+835hrTxXaQ9WlFxI9Nz1n4Kr2jamm1Qm3UpLdqnHB44eDqkTg99w/f9cR+MaxoQXHqZUtP63OmZYlGJtWUAmcnyaEUFEEh5bgN0G83kNRDN9I7FyTbmubaFvKxPLz8Z9Vs3bBGW3w9G6izNym+zn/lUWno03PMagx7q1XHTt7mFJJW0YZFYL6cBhhsl5HPqafvRftLXWGg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(54906003)(36756003)(186003)(122000001)(478600001)(6486002)(6512007)(4326008)(38100700002)(316002)(2616005)(6916009)(86362001)(83380400001)(71200400001)(53546011)(6506007)(2906002)(8676002)(5660300002)(33656002)(66476007)(66556008)(64756008)(66446008)(8936002)(91956017)(66946007)(76116006)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lhoup1M/MwOtncN1r/9zYcB1a8kMpsPfugsbZ/eMEbUlP1ODz/lp2ocp7HM8?=
 =?us-ascii?Q?HYBmswpAtqLnXUu8Summ2OjUz5IL41H+MMYx8hTw2pEUdeBjMhy282ArHkDQ?=
 =?us-ascii?Q?Y7Rt3T+lZH5A0hDtkQJ1D6pGJDhPDGOg+mJYrHyrb4Om/0CQcG9OmbHol/YY?=
 =?us-ascii?Q?TygjCFHZImIO/I676YH+pKAqdqSJIrJjdya5f4NYhRdQb3mFVv8SbS0fmnkQ?=
 =?us-ascii?Q?QfAcwmikBMRgvlYnbozaw/0sZQp8mTE56a72DX0jtvzERXDsPq2RAayTgzVn?=
 =?us-ascii?Q?47LTv7FD1QCqdrajCgGikgDSzsjBGtt8wGErf6XshJxD+ojTehc11rWyIpP1?=
 =?us-ascii?Q?GoLgUYR4v6l9Pf3jMUZU98dN6IN/GQlSSU1yhJdkNanjXrNVTBlLKEjWW70f?=
 =?us-ascii?Q?Hd6Ry0iJrzeViz1A0SK4Rpk7RiUniEJotyVPcz+lfldnKqletWJwBjkHeswl?=
 =?us-ascii?Q?Pfq5WW5Hu0Tu/M5bSreCu+zJ6YEtoNnZeSk4XMLpOPE39oDOedTLV93/5vyZ?=
 =?us-ascii?Q?RG0205vAFcj78zpOyS96ecU5dCf8ZkHfKPPkxgXT9xWtp12J+yM8V8GL/P2X?=
 =?us-ascii?Q?KyYWAqBNp9DGSzeCQDjrBXCoRWy7SStJB0wxZq/r1RszgTHH1qnx2du7AkJr?=
 =?us-ascii?Q?4yF/+n6N3ezpVVZEfyD8APKoLJ8M3fP3o4SWfGS81VIdaJzgn2IGRasXvlHN?=
 =?us-ascii?Q?4QxgQZr3pZa31UBYz7YXCrspQVH/rsCRoqIJJEKs2La7tsWJB/jaC2d3hA5b?=
 =?us-ascii?Q?Et7yiEBjJOX7ZouCv26HgRw4SNIdcS/JbDDjozJ74Syh/mTUvLE4wE9UHg3R?=
 =?us-ascii?Q?jvJh1xipa9w14dtl5QjZ2rKdhalEFgxlbsBvzdbFSnab48obbonn81/uX/rl?=
 =?us-ascii?Q?LuFvDHaFzaZJSHfM2VHqwQH2rZu45OhIcbm2kp7iqhYhD3gUNI+4TCFA0yXi?=
 =?us-ascii?Q?+xQsm68mVIy43XgrML6+EZva9ag/KxEI96kVM2SYcQ5BQqcQo8V/RSJ4nFWi?=
 =?us-ascii?Q?19A7Vcum+KRWqhc16jFSjOGIo+WaZa6YkSRlncitrevC24ZkKBRCHZ7YkDe0?=
 =?us-ascii?Q?iwC1uBfoEZkj+BkNux0vlLEtD5MUT+w+niasz2F43i1tr2mctarxug2uhEOi?=
 =?us-ascii?Q?6YBL4JTYsGOUwLLLg9XiXGImzU0q1s+Fep07KC3Unb7k1/6PElZcBedd/Vdp?=
 =?us-ascii?Q?KySopa9Tj93ZQ5YGalDrURPrmRNFJjw3AKuYKJoTgcwM+B3DRrn27ZI0TR7E?=
 =?us-ascii?Q?NYyreHpX/8oC0hHv6yj82L072EE1zk8HNLQj/G3wFJ+mBgeOPSV55h+D0mwE?=
 =?us-ascii?Q?adttCFMxecN0A4ZEgNndtkdf7SBXxhWnKV7y8mXISO0ejCWa/ukGLnygXj+Q?=
 =?us-ascii?Q?SlEZqcw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <397ED8892C594846B3E7DAB69704FD26@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3cbd6ed-4344-4488-89c6-08d9375da100
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 22:15:52.0550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QzFn+PGPhzRhfk81bFZOjFOZw8QTMghYwQV921kJnNW4MtEYhQPLcmzy9pDCn+ZKr1JzJy6kfvQpjWseroARFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3667
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: P_VQHBU9tojwCSJ9kFMsDo4Ry8dzDNCo
X-Proofpoint-ORIG-GUID: P_VQHBU9tojwCSJ9kFMsDo4Ry8dzDNCo
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-24_16:2021-06-24,2021-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106240124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 24, 2021, at 3:06 PM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> On Thu, Jun 24, 2021 at 2:41 PM Song Liu <songliubraving@fb.com> wrote:
>>=20
>>=20
>>=20
>>> On Jun 24, 2021, at 2:01 PM, Namhyung Kim <namhyung@kernel.org> wrote:
>>>=20
>>> On Thu, Jun 24, 2021 at 9:20 AM Song Liu <songliubraving@fb.com> wrote:
>>>>>>> +
>>>>>>> +// single set of global perf events to measure
>>>>>>> +struct {
>>>>>>> +     __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
>>>>>>> +     __uint(key_size, sizeof(__u32));
>>>>>>> +     __uint(value_size, sizeof(int));
>>>>>>> +     __uint(max_entries, 1);
>>>>>>> +} events SEC(".maps");
>>>>>>> +
>>>>>>> +// from logical cpu number to event index
>>>>>>> +// useful when user wants to count subset of cpus
>>>>>>> +struct {
>>>>>>> +     __uint(type, BPF_MAP_TYPE_HASH);
>>>>>>> +     __uint(key_size, sizeof(__u32));
>>>>>>> +     __uint(value_size, sizeof(__u32));
>>>>>>> +     __uint(max_entries, 1);
>>>>>>> +} cpu_idx SEC(".maps");
>>>>>>=20
>>>>>> How about we make cpu_idx a percpu array and use 0,1 for
>>>>>> disable/enable profiling on this cpu?
>>>>>=20
>>>>> No, it's to calculate an index to the cgrp_readings map which
>>>>> has the event x cpu x cgroup number of elements.
>>>>>=20
>>>>> It controls enabling events with a global (bss) variable.
>>>>=20
>>>> If we make cgrp_idx a per cpu array, we probably don't need the
>>>> cpu_idx map?
>>>=20
>>> Right.
>=20
> Maybe not.  Sometimes we want to profile a subset of cpus only.
> In that case, cpu !=3D idx then I think we still need this.

We can only attach the bpf program on selected CPUs. Say, we want
CPUs 1, 3, 5. We just do=20

	for (i in [1, 3, 5]) {
		link =3D bpf_program__attach_perf_event(skel->progs.on_switch,
						      FD(cgrp_switch, i));
		/* */
	}

The value arrays are still for all cpu, but they will just report zero
for CPU 0, 2, 4, ....=20

Would this work?=20
=09
[...]


>>>>> Maybe.  But I don't know how to access the elements
>>>>> in a per-cpu map from userspace.
>>>>=20
>>>> Please refer to bperf__read() reading accum_readings. Basically, we re=
ad
>>>> one index of all CPUs with one bpf_map_lookup_elem().
>>>=20
>>> Thanks!  So when I use a per-cpu array with 3 elements, I can access
>>> to cpu/elem entries in a row like below, right?
>>>=20
>>> 0/0, 0/1, 0/2, 1/0, 1/1, 1/2, 2/0, 2/1, 2/2, 3/0, ...
>>=20
>> I am not sure I am following here.
>>=20
>> Say the system have 10 cpus, and the array has 3 elements. We can do:
>>=20
>>        __u32 values[10];  /* assuming both key and value are __u32 */
>>        __u32 elem;
>>        int cpu;
>>=20
>>        for (elem =3D 0; elem < 3; elem++) {
>>                bpf_map_lookup_elem(map_fd, &elem, values);
>>                for (cpu =3D 0; cpu < 10; cpu++)
>>                        values[cpu] /* this is the value for cpu/elem */
>>        }
>=20
> Thanks for the explanation, I didn't think that way.
> I thought it like below:
>=20
>    __u32 elem, value;
>=20
>    for (elem =3D 0; elem < 3 * 10; elem++) {
>        bpf_map_lookup_elem(map_fd, &elem, &value);
>    }
>=20
> So in this case, the actual value size is like below, right?
>=20
>  value-size =3D map-value-size * number-of-cpu

This is right (for user space).=20

Thanks,
Song

