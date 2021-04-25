Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A09636A999
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 23:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhDYVqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 17:46:43 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43372 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231231AbhDYVqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 17:46:42 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13PLXaRj018688;
        Sun, 25 Apr 2021 14:45:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ti9p8tj61mEP4LaKzEIiZ3YLaWDWFPMOySDSSxFrlzY=;
 b=gTGmVQzA07CqmhLh8D/U/a+4TKywan60AWwR3Cbf8uN0Lq8Rx3MZOUwr+ohAuiS6bKgH
 3bM/NLnf5NqaPXgkzRHNo5W2kBaDFVJ0DS9EFzsxBgq4nBFUuvy5xZ50byPblSZWvwvL
 bu8UYS1gOYELxo+8tbUrAmTjuUETnWeaYps= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3853g8a7ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 25 Apr 2021 14:45:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 25 Apr 2021 14:45:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exMzNZ+eVPRpxj5+K6h9+5ywq3/a6nzxn3WXYyNNZ2y2Le88EcuA8wtFA4S2OJB8NVrBe/7y/R/XPyiHywJv25CsWtEHpIxH98HLzfxVm4S43tQOZ5dF/Qg5KbyT+2T78UHSUSJ+FlUenHXPfBv1JCx9Sb6aHXJqM53qZROj+s5flw7aEgEEnzmaAxgzcAM53uVML5Q7y7HcbcuZCPVcCDgEsVI4GXVEb4pskNrdU+xpybBQHUC1PN7Ml2at7WfskzwVomIufg09V1W4bUY4xwxjy5YqnO9Xh7IemOjVkRLc09ChOdS43W/ENiUvrkUSWRlWsfy4JNgO0a2eoPdrHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKWLBJ0ciOmgWew9FmVvrlChJwSW/qtma7lSCAgiNL8=;
 b=VoqmcucaAT48PbbUzmg63YwXoiOPe+x/tcY8hvXXe9ZLDCWBMZxPT6+R8ITuJXYvFwMpNw6JZew+wJR5MujNLiMeVI5a4BtuaglgWQY/RVRcIwRzAzw/UXyGy2x9HroFWp8Wxghw2cO3irr8YOkNa/td3MHFCy5VSAqjdlGayOSq8ufKNbjDJtZPHp1tqbXjsIm9HevY2jtDJfP6XsMA4Ar/3KYBw7pIbveIS0pvZb7S8673IxB6ze5BfM5OBO1Muu+YKr70Piks5C49tpnRVoTFbjlXXfmmSvX+i3jmSMNs7O3M+FyVDppNb8btNsr7ZjTrBqm9QasHt8Fo4j3pDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2582.namprd15.prod.outlook.com (2603:10b6:a03:154::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Sun, 25 Apr
 2021 21:45:56 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.040; Sun, 25 Apr 2021
 21:45:56 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <song@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@redhat.com" <acme@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH v4 3/4] perf-stat: introduce config
 stat.bpf-counter-events
Thread-Topic: [PATCH v4 3/4] perf-stat: introduce config
 stat.bpf-counter-events
Thread-Index: AQHXNVvKAeJiWUZbmU6OR6cKbig+tKq9qzkAgABAUQCAANkPgIAGkhCAgAAKsACAAEDcAIAAK9CA
Date:   Sun, 25 Apr 2021 21:45:56 +0000
Message-ID: <A6A3FBA3-4E1C-4E62-BBDC-308BDA8D9962@fb.com>
References: <20210419203649.164121-1-song@kernel.org>
 <20210419203649.164121-4-song@kernel.org> <YH8P5ol5JRr5JO5v@krava>
 <EE06CC67-3FFA-43E2-B032-EC8B37A9EC1C@fb.com> <YH/773ecFa3iESlH@krava>
 <YIV+8zIj6YrzNXoL@kernel.org> <YIWH6mKgIvPSfXRP@krava>
 <26FCA13D-B58F-4FD9-8A0F-EA29708B3EED@fb.com>
In-Reply-To: <26FCA13D-B58F-4FD9-8A0F-EA29708B3EED@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:1382]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f90331c-f954-4e57-f55e-08d9083381b5
x-ms-traffictypediagnostic: BYAPR15MB2582:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2582939583BC63AF9C6073A7B3439@BYAPR15MB2582.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mwWZdniXcRpGx/YrnaW3XXSpD0da/8je8WFB5ZUEYZviCKKVE2fvlqt4enWpIX0SLH7eaXEoNb6tKQ1wLM0AXRSY8mn1J2q+pOmZWBDS8bMqw+V9853Krq2fHTjASYoTXuJpXp1mNGVrHiPX6lPk4b6R/FA6tR+MjXIWxiG5htrXlSqmsm4+RUeplsvmZcKTa7hBPMLr1jhDJSZN2HlBnmgNuXAhB2YaRFKlFuNhXl6TvrzkoGF47Zqqr98JAwyJ9m7rLp3VEawQcbmhZV3MiDx7FDgcwQaLb2y35Og3VyNxCt1eklYGpPEUoNMPdVKV4mikm/+k0qsXHEvZafCHopsO+AnxFHXAjTm5L8i8HLX4XGT4Xpd9IOdq2E1186omUEHKOw3YSnaD1MHrJE6E6KLU9a+qtvFu+zBwyygLzTILwTgdzdKNfg9u7YY+lY2h1XQ9qoXgtTGoW2U3QNnF493LvecQV8NVKHW1asF/Xwx3k2fTUIObKzztCujkxgF7zz6DGcK9D4XopDoyJu7rGCWxv8eGyLSPG6b2TukhPwrJ2glV7fqTZUGXVpluUxhLYgO5EggqhpOb715MPGeISqtY/Spc/8izOVDtJivX7NJojPwpbOBEk+A1Jt3EIddC+OrpSqzenk6XoHHrczF+yT01mpuprTZT0r8ycyiDHnUapTwhFwitMwdqHeXxrZgufuSheB9vWWrJ14V7+O4NxjnhYQhjsjeFLHIWqrcHqWm74BUITeTuyeYTZxbdN8Ry
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(6486002)(71200400001)(8936002)(53546011)(6506007)(966005)(6916009)(122000001)(36756003)(38100700002)(54906003)(316002)(6512007)(478600001)(5660300002)(33656002)(76116006)(91956017)(2906002)(66556008)(66946007)(66446008)(2616005)(186003)(86362001)(4326008)(64756008)(66476007)(8676002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lO4j1AqFgLmuETL6HkxjHqSIXAxHK1I7S0l7krg56p6C/lUhKZzx6cuCHP0X?=
 =?us-ascii?Q?Qz8KjohJXatGnxNL4svrGxUk4WuYngURH65TVXqEqA7ICtJ49eXtOdoHNL+V?=
 =?us-ascii?Q?NZ9Jg0VOe/tfWMcCi4+r25vmXH+zukSTDW89d4PRnUIBqTX9FUdUpQ14DkPm?=
 =?us-ascii?Q?JnQIMLmFIQxnx1DQvXSUVb0G0Hwf9otclNh8SoYsOA172OxtZbYsDvMckwaJ?=
 =?us-ascii?Q?x4WJdIDjr6q3MKwjSdyxH+rVKO9rSiBwfyQTPu05ekndL3cdczxC6LEghkxO?=
 =?us-ascii?Q?a/3MIiuga+TLmaSA8yMBnjy1nuaZ8UUPZAtQXzHf4KDsM1OV6T+fqgQqNCNJ?=
 =?us-ascii?Q?JzWnnlfXkzBR/J8UmOoRZoUcbV41xYKE5ly0hOGXkYlCl3Mkmxd0SgriBLun?=
 =?us-ascii?Q?92LqijIsSqASnwm70nf0sduItRofjKyXqR1hMoQNRCINvTVJGk6q6v6ZLMG2?=
 =?us-ascii?Q?x6GLtD/CisxUhfD9tD7MUD/tHBYk9FpHTXLgk+G/57u8XzktrdN6YyDYOZTC?=
 =?us-ascii?Q?Et4Bjsmr+VLaM/a/J6F2fl0VjGC+x4vQ0yUdsw6CkETpCEqPg0Kp5y3ON0EX?=
 =?us-ascii?Q?1gdCjaCK8oOTg87lHZWmjrvj42pDjv6Cihm+PramL7dtOVH0qBVU/wZX6NxN?=
 =?us-ascii?Q?gpi1/Im3xCbs68Gir7+eYDKVbDN+VMwL6tmV5ex7nIN2OnpYQZxbHEwb9sHZ?=
 =?us-ascii?Q?saCScfpSNQQdJddf4mI3rcMomaaf9b53QD13s9VEaZUDcpiBWDtad74iASu7?=
 =?us-ascii?Q?oOcZmjA1+jTCBHzcGSw9CbaVsQ2Kh1HYg4xtlioEsfY2f/Ek7FtdeT4LhHy4?=
 =?us-ascii?Q?Q5q4r1t35n4AG9Kf+pxWgVZdb0csnBie3Sle4k7WmmjSX7ZkIqINHtTetXf3?=
 =?us-ascii?Q?XsRG8M8Kds2FMqFGUv/kQGYtuEiG5Vyx2Pw0+HgXnthK1AAvBIHKKMzuyyjg?=
 =?us-ascii?Q?9jDNZQ+FlRtRTBDEhK4TmX6zMapuM1X/+IwG66Xg5fuv+lN1DExQelePNunH?=
 =?us-ascii?Q?lPIY/YHw/NWI+0cuZceb2HtRFyP4Ijog5DwVrexqgFSdmgbOnscBmLx7ffD/?=
 =?us-ascii?Q?3otau+jyjarvJZjgUcbo0Bzn+6ReOo3Z0Ye2eIr2xPGp0Sw3lGwAH5t2Sbw3?=
 =?us-ascii?Q?vQ/o9KmbnPvHdK9Fj6hwVLG5cAqerPKatZkllSalv/+1U2wjK1oGDSnq/WE1?=
 =?us-ascii?Q?bOfbcJ8kL1WhAF6T5VMqJCHCsiHgMMZuGjyF3tjp5bRXDlXxmYGdh0h3A6DG?=
 =?us-ascii?Q?uRFsOopA1zcxj7VFtiprwr1f9wnJSRXTAyFOhKyBq9Z/BbwGFkd5Q81u4kxs?=
 =?us-ascii?Q?GYH83VoJ7LE7bUI0eOJo3MKLY5WpTtdmJ2KajzRuVjPbc6EvVG6M/rd6jwLn?=
 =?us-ascii?Q?SNSfU0E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A54BAAE7D3F7CE42AA2811B93126A299@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f90331c-f954-4e57-f55e-08d9083381b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2021 21:45:56.0856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3EefDMkDhAXlzDhREutNqD9nO7SgAMwURZvffy+RFvbgPjdyhJJCEjg4jkzzVTVf/fYAHrgj9qfC8H591J3PLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2582
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 9fiyY3Dv2WCYRRZ4QYmtv0AOi-R2S2Xw
X-Proofpoint-GUID: 9fiyY3Dv2WCYRRZ4QYmtv0AOi-R2S2Xw
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-25_09:2021-04-23,2021-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104250162
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 25, 2021, at 12:09 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Apr 25, 2021, at 8:16 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>>=20
>> On Sun, Apr 25, 2021 at 11:38:43AM -0300, Arnaldo Carvalho de Melo wrote:
>>> Em Wed, Apr 21, 2021 at 12:18:23PM +0200, Jiri Olsa escreveu:
>>>> On Tue, Apr 20, 2021 at 09:21:32PM +0000, Song Liu wrote:
>>>>>=20
>>>>>=20
>>>>>> On Apr 20, 2021, at 10:31 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>>>>>>=20
>>>>>> On Mon, Apr 19, 2021 at 01:36:48PM -0700, Song Liu wrote:
>>>>>>=20
>>>>>> SNIP
>>>>>>=20
>>>>>>> 	if (stat_config.initial_delay < 0) {
>>>>>>> @@ -784,11 +790,11 @@ static int __run_perf_stat(int argc, const ch=
ar **argv, int run_idx)
>>>>>>> 	if (affinity__setup(&affinity) < 0)
>>>>>>> 		return -1;
>>>>>>>=20
>>>>>>> -	if (target__has_bpf(&target)) {
>>>>>>> -		evlist__for_each_entry(evsel_list, counter) {
>>>>>>> -			if (bpf_counter__load(counter, &target))
>>>>>>> -				return -1;
>>>>>>> -		}
>>>>>>> +	evlist__for_each_entry(evsel_list, counter) {
>>>>>>> +		if (bpf_counter__load(counter, &target))
>>>>>>> +			return -1;
>>>>>>> +		if (!evsel__is_bpf(counter))
>>>>>>> +			all_counters_use_bpf =3D false;
>>>>>>=20
>>>>>> could be done in bpf_counter__load, check below:
>>>>>>=20
>>>>>>> 	}
>>>>>>>=20
>>>>>>> 	evlist__for_each_cpu (evsel_list, i, cpu) {
>>>>>>> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_co=
unter.c
>>>>>>> index 5de991ab46af9..33b1888103dfa 100644
>>>>>>> --- a/tools/perf/util/bpf_counter.c
>>>>>>> +++ b/tools/perf/util/bpf_counter.c
>>>>>>> @@ -790,7 +790,8 @@ int bpf_counter__load(struct evsel *evsel, stru=
ct target *target)
>>>>>>> {
>>>>>>> 	if (target->bpf_str)
>>>>>>> 		evsel->bpf_counter_ops =3D &bpf_program_profiler_ops;
>>>>>>> -	else if (target->use_bpf)
>>>>>>> +	else if (target->use_bpf ||
>>>>>>> +		 evsel__match_bpf_counter_events(evsel->name))
>>>>>>> 		evsel->bpf_counter_ops =3D &bperf_ops;
>>>>>>=20
>>>>>> with:
>>>>>> 	else
>>>>>> 		all_counters_use_bpf =3D false;
>>>>>>=20
>>>>>> I was also thinking of oving it to evlist, but it's sat specific,
>>>>>> so I think it's good as static.. thanks for changing the implementat=
ion
>>>>>=20
>>>>> Hmm... then we need to somehow make all_counters_use_bpf visible in
>>>>> bpf_counter.c, which won't be very clean. Also, since this is stat=20
>>>>> specific, I guess it is better to keep it inside builtin-stat.c?
>>>>> The runtime overhead should be minimal.=20
>>>>=20
>>>> ah it's different file :) then it's better as it is, sorry
>>>=20
>>> Is this a Reviewed-by?
>>=20
>> there's still the matter of disable callback:
>> https://lore.kernel.org/lkml/YH8Pw4m0w6DuuEXo@krava/
>>=20
>> it looks like now it could wrong value if we don't disable it
>=20
> Sorry for the delay. I will add the disable part and send v5 soon.=20

I just sent v5 with the disable() callback, and a minor fix in 3/5. I haven=
't
figured out the best fallback mechanism. Will work on that in the coming we=
ek.=20

Thanks,
Song

