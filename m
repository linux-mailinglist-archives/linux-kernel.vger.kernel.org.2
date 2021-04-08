Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BD0358DAD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhDHTrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:47:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20898 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231451AbhDHTrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:47:09 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 138Jid8S018771;
        Thu, 8 Apr 2021 12:46:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=LHyOq/RbMqgC3/v3XdJI6BVUTAlYTNQktzJ4uxtjsZc=;
 b=MVmY7AsQ+vvdoLzoZKi2QV6qTierN3NyZ8r54TV6AHfuLRR+NW/bCKtUs9yPKYuydH2L
 C1GxSocSkz/N7XUu0d0lKPc7LA0/UvHkdm7CAkyVW4CSB8kcXJQk5LTP99Xr5Iak1Zz3
 mgppYQ3IrJcFLJZzauQGHE3LHClWvfwryaU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37t43rhvx4-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 08 Apr 2021 12:46:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 8 Apr 2021 12:46:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JX4FTy3FFuM+Cew9mBNJMkUouiEAkAZJ2C09rCpJqWCCE5PWjIU/1whCiOF3UFlXcHiA/ttT+2WGq4GhvPhqX3j1h2Z/3LkU9Bs5mRn5vzGSE6rIx+W9WRw0ouFD3HlNfvbSbKHChrUD0ML4u0c5tj79Aa/S0xFUnWEBFRFfSjyU57k5sRcyoimwDwSFBcZaVXLIkjXTuW73S8LYaKUjS/eBzN2KaxD+ypj5D0lZRiC/G9OHeT1eo0SI2qJ8rq0ypoPPLKe6Rjm+9638IiyY/Sl2t4ZTvTIb3XNsOouYoOb9TPfW2X2Ri+3s9RkodUqqYN8Hxt/UjxzzhC8psuiB5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHyOq/RbMqgC3/v3XdJI6BVUTAlYTNQktzJ4uxtjsZc=;
 b=X3Lm+L1lmUwalloEy74uoMxKfwb/XzqJWUPbjW03kVGA1X2TPG3Y6yOzkT5v5iJGMpatRlpNqKscQepQVdv/Bc8N3WSG/yYE4wnWEsbjal5YRv9549ba5v9ht5OP7agX7uTB7rrVMb8LS4VJhG6Ynkvdn1055Y1/lHGPkTkiw+cU7guB8WGdG+Su0OnV+/QFU05x/hn8yEJnh/gzjfkSX+XgfdEQWJlJnA2/fMa3U8vHdgqzW66p2g7fs0pMTWigrNd1KkO0rpY8Ok80AHMRqJxAStsHG5WiwBWthe1GE4siMXrrYQ7bs4Y29k5r3MO9vq/hNml0z6SMe6MJKnJBWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB3512.namprd15.prod.outlook.com (2603:10b6:a03:10a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Thu, 8 Apr
 2021 19:46:23 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.039; Thu, 8 Apr 2021
 19:46:23 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Song Liu <song@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH v2 3/3] perf-stat: introduce config
 stat.bpf-counter-events
Thread-Topic: [PATCH v2 3/3] perf-stat: introduce config
 stat.bpf-counter-events
Thread-Index: AQHXK0YG4LdD7IbPc0ehmtAjm2+fxaqqg16AgABRlYCAAAtnAIAAAjCAgAAEzwCAAAZpgIAABJqAgAAWyoA=
Date:   Thu, 8 Apr 2021 19:46:23 +0000
Message-ID: <9F632420-4349-4BB0-B156-9739C27B5B2B@fb.com>
References: <20210407003601.619158-1-song@kernel.org>
 <20210407003601.619158-4-song@kernel.org> <YG7tU/mVxQZLNCYL@krava>
 <FA667178-09F3-48C5-891C-9E44744276C0@fb.com> <YG87VLdSrhG0xSDj@krava>
 <0106D99A-5CBB-4CC4-B6F5-1B795E9B8274@fb.com> <YG9BMss16qFOjhos@krava>
 <FDBEC7CA-7F74-4494-93B3-7E5758E5DED9@fb.com> <YG9Kb9izJhQlth3X@krava>
In-Reply-To: <YG9Kb9izJhQlth3X@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:57e2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cef88d6a-6042-40e9-746d-08d8fac6fd4d
x-ms-traffictypediagnostic: BYAPR15MB3512:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB3512AFF5DC619BC0DF3312EAB3749@BYAPR15MB3512.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tYEDoY459CWCSRL+H+vc29yJyRoHyWrBRdc1pOPtx//fqpvSzKOV1yNDhcl4bA886dEtwpUQlLXmsoQJcrYZ4gHJEiVXmB5Fk5wuRqIfMravqjMVIU3NBPRkS90QXso4gur147ybWdKiLb4g7LapU6ZDcoWjjZ9H3cCvmVA3YaZOKuHqX6FyGokJobngZWShYjKiNrRhUcsRk9LB5FpGl29epRzNv2a003picPo4003lrAr102Udc1QiQOL1TrHfQhD8u6K655CEgH0ZXORgURZh7QGrWdxxgZopZK1nx27CI4NVtKElCIy9LZCmycXMdyFHnd9iIkHmgGO9NvFzPCwGuEbR9eFIxx1VNWT2seRMeDSZvZwEogZvkTZhlGhgFcgtyJUGzuUO5n3gZosPtfjT9gbxGR7/lbcveOR4orVh6GuTRj0muyKVTsbW1BBAHRz8pimY9iLf60fVoz/pCC2SvEFybgLotMAI96HDU50KKM2bnxb4Hs6aCGwlwgnY3AlmUCRYlN3mudCyMLWarvNFiFhWxOeCm7Ne3E1cJ9qzOJMpuQU/TzwD2tDtrH4TgBnOXY3n/oHdCgxAOAYC7FHUc5t+ZzL7EjDuhu/tpnrLdRHWP+f3ihkX8zzmaAq9r+k2WWESezK9R0MfQvOoOoffW8uhiTrpKhYEBAOG2htc5C0QCpqPOpFFmHepM5Hv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(396003)(376002)(39860400002)(83380400001)(36756003)(186003)(8676002)(33656002)(66946007)(38100700001)(4326008)(76116006)(2906002)(316002)(478600001)(2616005)(91956017)(6486002)(53546011)(66476007)(66446008)(64756008)(71200400001)(6916009)(54906003)(5660300002)(8936002)(66556008)(6512007)(6506007)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?w27IPfFvK+jvU0WLXBskLlkI31kRDj62jKIT6FMTGKP1UxSSrHFCfgfitnUc?=
 =?us-ascii?Q?AcGkEh1HiXF/4ZVSBHygpLYMkg4hsg45rBVDBY+wDP/vxtfoXEWjyBW5vKYF?=
 =?us-ascii?Q?CWR6vt71gaJAcnqCzLgceQknBl+BXMvncG9AgRC6ruVwZN15/C81J32lQoLm?=
 =?us-ascii?Q?21xh6OqR9+6hCUrBEEDLGKFsN3+683php5FKiVZDqv0hf6K4MtyE5aHI9mSZ?=
 =?us-ascii?Q?8LJjMlJFqaPFc7QDgPfNGyKrebIRzMRojabbiiGPEUGeTD01pHzNTXsc6SA5?=
 =?us-ascii?Q?i0vPT/pg0Q/hBB+EaenPO271BwZaDEP5HQVH/b4sVLk1zy02uX8Tiw33h9t8?=
 =?us-ascii?Q?MHodkJG4KzO95vxEkOCOcGkNG4RbOByy6QHn4fXNJfs5Xcv2VfKfEY9bdvT7?=
 =?us-ascii?Q?3f42X9E6SlcrrGNr9mu1ql4gpTX1mDSXW40EU22PGIcvn37jv9BTtgKQ2fdP?=
 =?us-ascii?Q?X4mNhcjDevkN1GaR08GCQAZl6j8c6r86z/U/Y6pyU5osaAi1PRBDtVnseXsl?=
 =?us-ascii?Q?0YsXxCUqB1wFFK2NJg1KPhi6QKFHXCA8ed9p/DwYMWA0y1NGw0cgZSW6d2cz?=
 =?us-ascii?Q?PNjWLNhG9ploDZtApjtjM+zoY0IqAvFIo4aBbQ4LSqCL9HH1ini2FrZOBpRo?=
 =?us-ascii?Q?9o5cuk6tRld+nf5LiLoeWnLy8eVgmNKhi/AIKDu4ypCqDy9HcV8fKvSK2Yoa?=
 =?us-ascii?Q?fofLjPMVkleVQZhgV+OOf8zgbFT01BgYuG6Wcl3OA5NgnqtdTc3CJjgNp0FH?=
 =?us-ascii?Q?QFIwzHiCRKhP1ssq908qPH/jktcey9JNKbBMU6zCYdeo2XRXYxN5WlcFLWtd?=
 =?us-ascii?Q?59lZzFe+yAnWgya+NVfKDyE0LoaIcCY8iZieLQ6eADWYJc2dzPSDqpfTRGk0?=
 =?us-ascii?Q?kNgt4/DsIhOOjGHsau2t4BNTc1HZIunwC1Y//i28hPFTz46FBc38ezlbzenB?=
 =?us-ascii?Q?okfGVDuwjE0JjrrzMqdYbTuYADz7nLfYnvgtyEoiG1WIibQinKSPvBwgfEPp?=
 =?us-ascii?Q?iEftGnTdvoAH86Erxn8zie4qOdLRJvXRxRmjCN0MNzuFRFyVRjZX5asau5lS?=
 =?us-ascii?Q?LCpD8GsSRN70LeJw1Kxe9fXxW9sWX9PjLWSnqlHbcsU78KrnPhZ+GnLKFqe0?=
 =?us-ascii?Q?JUf1RhjK0ubrlJLq7mF+laZ8QDEHy10lw2MdG4yym6lx2UnWvd4S6DaPRgjd?=
 =?us-ascii?Q?uAHADBwB+R1OYg2ut4+pjSZqKMYJUpktSJc+8cHJ958fnZEZ77IasOnsRsSj?=
 =?us-ascii?Q?zVyJ+AnhfEYdhI6EcvYjkr7q/KogK6LUPlcNHWglD3ZT5hgHIaBEEfFh+s1B?=
 =?us-ascii?Q?WN6lsY0aULpAt6WOj9npXKjCxLIBAbIy927AAbr9pHl8v03OFPpNEe/BzpX7?=
 =?us-ascii?Q?JcoPmaw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <060379E2587731479701DF67B4843CEF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef88d6a-6042-40e9-746d-08d8fac6fd4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 19:46:23.1626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZmXHGVTcze8orza5g2Te+63Z6Di/fpxByziikQaeDw1JsQ3/ZkWIkKfdzdjp0xo2N0tx8aY1Hs6f5X2y8aJBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3512
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: Fo8OBSp_2c9qCHLlYKYPMGo3Ymu4Tdsk
X-Proofpoint-GUID: Fo8OBSp_2c9qCHLlYKYPMGo3Ymu4Tdsk
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_04:2021-04-08,2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104080131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 8, 2021, at 11:24 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Thu, Apr 08, 2021 at 06:08:20PM +0000, Song Liu wrote:
>>=20
>>=20
>>> On Apr 8, 2021, at 10:45 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>>>=20
>>> On Thu, Apr 08, 2021 at 05:28:10PM +0000, Song Liu wrote:
>>>>=20
>>>>=20
>>>>> On Apr 8, 2021, at 10:20 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>>>>>=20
>>>>> On Thu, Apr 08, 2021 at 04:39:33PM +0000, Song Liu wrote:
>>>>>>=20
>>>>>>=20
>>>>>>> On Apr 8, 2021, at 4:47 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>>>>>>>=20
>>>>>>> On Tue, Apr 06, 2021 at 05:36:01PM -0700, Song Liu wrote:
>>>>>>>> Currently, to use BPF to aggregate perf event counters, the user u=
ses
>>>>>>>> --bpf-counters option. Enable "use bpf by default" events with a c=
onfig
>>>>>>>> option, stat.bpf-counter-events. This is limited to hardware event=
s in
>>>>>>>> evsel__hw_names.
>>>>>>>>=20
>>>>>>>> This also enables mixed BPF event and regular event in the same se=
sssion.
>>>>>>>> For example:
>>>>>>>>=20
>>>>>>>> perf config stat.bpf-counter-events=3Dinstructions
>>>>>>>> perf stat -e instructions,cs
>>>>>>>>=20
>>>>>>>=20
>>>>>>> so if we are mixing events now, how about uing modifier for bpf cou=
nters,
>>>>>>> instead of configuring .perfconfig list we could use:
>>>>>>>=20
>>>>>>> perf stat -e instructions:b,cs
>>>>>>>=20
>>>>>>> thoughts?
>>>>>>>=20
>>>>>>> the change below adds 'b' modifier and sets 'evsel::bpf_counter',
>>>>>>> feel free to use it
>>>>>>=20
>>>>>> I think we will need both 'b' modifier and .perfconfig configuration=
.=20
>>>>>> For systems with BPF-managed perf events running in the background,=
=20
>>>>>=20
>>>>> hum, I'm not sure I understand what that means.. you mean there
>>>>> are tools that run perf stat so you don't want to change them?
>>>>=20
>>>> We have tools that do perf_event_open(). I will change them to use=20
>>>> BPF managed perf events for "cycles" and "instructions". Since these=20
>>>> tools are running 24/7, perf-stat on the system should use BPF managed
>>>> "cycles" and "instructions" by default.=20
>>>=20
>>> well if you are already changing the tools why not change them to add
>>> modifier.. but I don't mind adding that .perfconfig stuff if you need
>>> that
>>=20
>> The tools I mentioned here don't use perf-stat, they just use=20
>> perf_event_open() and read the perf events fds. We want a config to make
>=20
> just curious, how those tools use perf_event_open?
>=20
>> "cycles" to use BPF by default, so that when the user (not these tools)
>> runs perf-stat, it will share PMCs with those events by default.=20
>=20
> I'm sorry but I still don't see the usecase.. if you need to change both =
tools,
> you can change them to use bpf-managed event, why bother with the list?
>=20
>>>=20
>>>>=20
>>>>>=20
>>>>>> .perfconfig makes sure perf-stat sessions will share PMCs with these=
=20
>>>>>> background monitoring tools. 'b' modifier, on the other hand, is use=
ful
>>>>>> when the user knows there is opportunity to share the PMCs.=20
>>>>>>=20
>>>>>> Does this make sense?=20
>>>>>=20
>>>>> if there's reason for that then sure.. but let's not limit that just
>>>>> on HARDWARE events only.. there are RAW events with the same demand
>>>>> for this feature.. why don't we let user define any event for this?
>>>>=20
>>>> I haven't found a good way to config RAW events. I guess RAW events=20
>>>> could use 'b' modifier?=20
>>> any event uing the pmu notation like cpu/instructions/
>>=20
>> Can we do something like "perf config stat.bpf-counter-events=3Dcpu/*" m=
eans=20
>> all "cpu/xx" events use BPF by default?
>=20
> I think there's misundestanding, all I'm saying is that IIUC you check
> events stat.bpf-counter-events to be HARDWARE type, which I don't think
> is necessary and we can allow any event in there

From what I see, most of the opportunity of sharing comes from a few common
events, like cycles, instructions. The second reason is that, the config=20
implementation is easy and straightforward. We sure can extend the config=20
to other events. Before that, 'b' modifier should be good for these use
cases.=20

Thanks,
Song

