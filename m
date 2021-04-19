Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE7D364B21
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 22:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242097AbhDSU0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 16:26:42 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29014 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232318AbhDSU0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 16:26:39 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13JKPBub025130;
        Mon, 19 Apr 2021 13:26:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=WwVNcTabvRcHe0vhLgO/UQJVhorKbXwv7hY70YQMJB4=;
 b=LbvaKZwSEy74v0f6Bodah6zB3nn+aOJD+nWwHEaLCHdtZv3dxb7WYpP1IdINN2kW5iBD
 5SADTAXUvo18a1v1802YOmv9VkP8FhDQ19m+z1qymvfe+qehC0ia5D1t3WKnjecZYmLb
 kS4t2R4Vi1fpXdQRzSAfGZGUwdTLlGOX0N4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 381deus9fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 19 Apr 2021 13:26:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Apr 2021 13:26:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BykXEviJar+dztVKJW+X2Oa84o0P73TNcrk1YdvU8lp/tqIW98ntToUVhg/DiGZTl93RiYG6aL05q8UOUQkpb1cOKZwljtyYawuDxHvQbmIb+ug7lmkiFzHg0Hr/ZYEIYNgKBT24UiWtAdVyyR0P5OAyibLoc1A5SGBaU1ExTwe0+J3qS4/lJei2MZJUPi+ENYIKQ6iA2Sjk2j1Ai/NSjTfOI/3KFuGqiP0p7n45jVcY4bhx0GUGze773YpLEHys2U7MNXC9ybXSUPS2srW3V6pYsvCn696DYZ+0vA8ewKjVuVLIdfahlQce8rEIKJPYhbnb6nqNp24v/Epc5sMhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwVNcTabvRcHe0vhLgO/UQJVhorKbXwv7hY70YQMJB4=;
 b=Mvm7T86jAnJ0+iPcC01SgJZ0f2IuwFO2L7Yi+rPHl8cBIYVBLXUCe75+8zxWPJRUgrEJq/FbbxjGP6D34+7ZbkCXrl7yHzV8b8ragLf6XqXlkkWhzHzShX5S7WuslAa+R4jVaDr2w5gpn25LNHOIRnk1cRO7EyiEXZ9gw27amJ7CCYDM8mk4GioxwJKgWa4wE7kWxpAf1Nbl0AmF0Csb1WszfDBM+AWduRsouq5bVF7Zji4lt6mZdCPmHfMyhdDwFwmkEAL8D/u4oRYbdxc4DVuY7DB75bQA0U/134Cam9JS5CDRr0asc0o5q6ZHDmJVwPktxSQBGaXqFz2dZLnCBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB3366.namprd15.prod.outlook.com (2603:10b6:a03:10d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Mon, 19 Apr
 2021 20:26:03 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.040; Mon, 19 Apr 2021
 20:26:03 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Song Liu <song@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v3 3/4] perf-stat: introduce config
 stat.bpf-counter-events
Thread-Topic: [PATCH v3 3/4] perf-stat: introduce config
 stat.bpf-counter-events
Thread-Index: AQHXMw3DyOxUaVUpS0ODNNUcJNtKe6q46/0AgANiUwA=
Date:   Mon, 19 Apr 2021 20:26:02 +0000
Message-ID: <71CC9E29-ECBD-47DB-AE85-1477BF54C45D@fb.com>
References: <20210416221325.2373497-1-song@kernel.org>
 <20210416221325.2373497-4-song@kernel.org>
 <CAM9d7ciVj+d=Bgqmwu+v9mA1CGTbtr8pfXzgNKJs0Nh3BJtt8A@mail.gmail.com>
In-Reply-To: <CAM9d7ciVj+d=Bgqmwu+v9mA1CGTbtr8pfXzgNKJs0Nh3BJtt8A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:83ef]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6b79da2-2ec5-4b6d-7a6f-08d903715a50
x-ms-traffictypediagnostic: BYAPR15MB3366:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB3366132E0C359E5CDCCE81A5B3499@BYAPR15MB3366.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hnk8yaget5OZvkXyMltvC8yTqjG+yLnBP9TILn3vaaXZ0nTtMo93dFuN2MWvG82v68pn+2tl6G7ckIEbm3GQ3DL1+PIRX14x9Oc6Cq5hO4TySBUnNywInHMLqrHqW4h5CXbjXGnxiLDEP4Zy+YjIZ18tIB65TzkK5oFK8Qe9MAB591O9zQdlaObvuWPh9U8GKPlx9bniiPth68KwafAwixZnIQH5Icp56Wcr9rRowTYxFjEAbhucHunmFy774gmYiOxb/KtWfA4hjmeU4hPXuoaTxVImo1CjNZiE1UITiF4/HzImpZaxPOrVlAh4Cp6ZyKr+OoihP74OyWeBCs7BeFEFSwyLl9BC5Pslw2/NFRQoOLm6tCXEojrxnNEyMGZCAm890ajIp+PxW8b6PRpZYa/z/5zwO9p/vILaRKcveZR8ZTvk06cnyNhPu0t+ayS2Fjpi4fIU6O8tOM2orR21bO0IIffozhrJj4GEQ7uTlCJVx1YMo1brbjw5kjmvjCK+ohLKkfAJE3BXEh6n9wLbpw+Eu4rZzZEWbHv+7QPUfRFjnMVVCeUQM6k+U4dsT+mceu+mla2brKNNjQ9t3D4F/YAGMgBzaJwj3vP1d43I2Gmn6sypPNErHnqHRVCARVC+8N2alP0TTgFt0bdMmUD6TmKjyRI6FaHkWduWRrdoUKo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(346002)(39860400002)(136003)(71200400001)(6512007)(38100700002)(122000001)(2906002)(2616005)(6916009)(6486002)(66946007)(33656002)(186003)(6506007)(478600001)(66446008)(66476007)(53546011)(66556008)(64756008)(316002)(36756003)(54906003)(5660300002)(76116006)(8676002)(91956017)(86362001)(8936002)(4326008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aXHSfECGo1oha0XsA8oPAY+tIkKHijkbtdkpqrIDLP3cEKY5OxhIXPORO2D6?=
 =?us-ascii?Q?F4pcqjR+FWatjNdwmQtSNk0fh1YxMz2Ze3/bAZcF0mPxGOaiNRDwPeF42zI5?=
 =?us-ascii?Q?JLhZgnIKISOg8+aKqrMhQ+cwWWr4hnTk6JWHmQoivVOTl7YwBzNq6Pf2itmt?=
 =?us-ascii?Q?XEI7WLZid2F6BZNq39aotm7CUw6cQR4+MKNmOmKbunjrmTT5Up2mc49i/26C?=
 =?us-ascii?Q?OKpeQvjYdiv3XNPzMWrA2nkyFKbDJv8MYExE2ZmL/kDqWP9GJPg9Kbypj/6B?=
 =?us-ascii?Q?Itks1iIKck4bajbV0s3kdRfGlNjfkKord95V8NGCBPdbCDuNiRq4RuUDUtdT?=
 =?us-ascii?Q?+/X5uPcS9RpJUktFGzV94fyP2ig1rTtu32xrcP3iccarxV1JvRwAur6Wi/Rg?=
 =?us-ascii?Q?Ph3gII0m6anMxqFE35aRzLXk6kGtJDwIj4dTfX/vOfHYhoyqeJ5BYgM4Zryh?=
 =?us-ascii?Q?ugq3ZXVn5jHmdDZ+bQwBusmiNd7QnYDAqyK9t37WEf0T7i2AMDlV1lUHSMoi?=
 =?us-ascii?Q?ECLgvmQ+sCZWIJB9ZZklX0nkMva0GaXq0RSf1SsoluRhObhK5qkEYho9Icfz?=
 =?us-ascii?Q?AoMiBEfE/4UqtCgoVEApEbm337PiqPX4vnQ+lgqb2n+L3E+mSGIXx8RjJ544?=
 =?us-ascii?Q?QDwYFH2jubQ4varjIo+e0Ny09UJlFpTfpRde+Q3903832+h65gtCTREecZPO?=
 =?us-ascii?Q?yTOVR7Jd8GqJUtKLixsiWFI13gffVE/eTEPxYla6o5nzZv08hpc5hg/ZorpR?=
 =?us-ascii?Q?LdZINH7n70yymjQNAscWL3aR2kqnividVfPpjjxCPgEuivTYh/UTB0hSKi4E?=
 =?us-ascii?Q?DQZJ/eo2jMoJllmfWlANQcLh9cjO9Yq7L1VAc1Qi1SLF0nIX7GSY3CRWC48H?=
 =?us-ascii?Q?Z4JiSmSJ2TwtV9MVc6w5ACCjy5fVbL/Dz3S/dolBdFxeR7teRpI1xT/wYCA2?=
 =?us-ascii?Q?+LCE+wz3dgT/CWpRm1lgmP+kmwWWAkKyJcensDzvkYPsXMrhZ4cLsn5y+dMZ?=
 =?us-ascii?Q?EdH9dVwsbCbRkF/TgCwXTt+l8V4dVfjEVkx3uvnGMeG0m5JVWkiHXv9x0zx2?=
 =?us-ascii?Q?T0E2WG1g2mx5+PlqlLoTkycK+3qvz99LrRwHO/eHrdDEfDr6+jnVcw6eBjcT?=
 =?us-ascii?Q?j5uFdTXJ99Tb9yrL9VtxWBc+LfPZmva/xnhFlguWE7TF+Xx8wPNSdNRLNnBe?=
 =?us-ascii?Q?b/DIs4pNeXmTdGfAJYwJQ35ehaVghQJTg4RTIkzL9pHw6YphRWeoguq6YgQA?=
 =?us-ascii?Q?sxGi83UemDfDGjI5M4tvNELb7nomuJln+Mm8+TUQCBfasDEpm5HPXJ1qRq+6?=
 =?us-ascii?Q?Ru1IURrShbkHnSbDCqjekVxXn3OHWl1lkMxUquSbq/jH8qM+z1VUdZCwjja8?=
 =?us-ascii?Q?WvaxT2o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BFE31E0CB41C3941910DF3CA72A6FD32@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b79da2-2ec5-4b6d-7a6f-08d903715a50
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 20:26:02.9997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fCs1+Lyyc0eu5K2zfD7m6YmEUoWn3TWuKbK/nVN3Q8QVZaOjwAu7hptmeQF9A03mfVD40odZHjqq4SE0a9IEsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3366
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Jw-Z5gYRKiTfGlI90VmIQXz748czila3
X-Proofpoint-ORIG-GUID: Jw-Z5gYRKiTfGlI90VmIQXz748czila3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_11:2021-04-19,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190140
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 17, 2021, at 9:45 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> Hi Song,
>=20
> On Sat, Apr 17, 2021 at 7:13 AM Song Liu <song@kernel.org> wrote:
>>=20
>> Currently, to use BPF to aggregate perf event counters, the user uses
>> --bpf-counters option. Enable "use bpf by default" events with a config
>> option, stat.bpf-counter-events. Events with name in the option will use
>> BPF.
>>=20
>> This also enables mixed BPF event and regular event in the same sesssion=
.
>> For example:
>>=20
>>   perf config stat.bpf-counter-events=3Dinstructions
>>   perf stat -e instructions,cs
>>=20
>> The second command will use BPF for "instructions" but not "cs".
>>=20
>> Signed-off-by: Song Liu <song@kernel.org>
>> ---
>> @@ -535,12 +549,13 @@ static int enable_counters(void)
>>        struct evsel *evsel;
>>        int err;
>>=20
>> -       if (target__has_bpf(&target)) {
>> -               evlist__for_each_entry(evsel_list, evsel) {
>> -                       err =3D bpf_counter__enable(evsel);
>> -                       if (err)
>> -                               return err;
>> -               }
>> +       evlist__for_each_entry(evsel_list, evsel) {
>> +               if (!evsel__is_bpf(evsel))
>> +                       continue;
>> +
>> +               err =3D bpf_counter__enable(evsel);
>> +               if (err)
>> +                       return err;
>=20
> I just realized it doesn't have a disable counterpart.

I guess it is not really necessary for perf-stat? It is probably good
to have it though. How about we do it in a follow up patch?

[...]

>> +       if (!evsel__bpf_counter_events)
>> +               return false;
>> +
>> +       ptr =3D strstr(evsel__bpf_counter_events, name);
>> +       name_len =3D strlen(name);
>> +
>> +       /* check name matches a full token in evsel__bpf_counter_events =
*/
>> +       match =3D (ptr !=3D NULL) &&
>> +               ((ptr =3D=3D evsel__bpf_counter_events) || (*(ptr - 1) =
=3D=3D ',')) &&
>> +               ((*(ptr + name_len) =3D=3D ',') || (*(ptr + name_len) =
=3D=3D '\0'));
>=20
> I'm not sure we have an event name which is a substring of another.
> Maybe it can retry if it fails to match.

We have ref-cycles and cycles. And some raw events may be substring of othe=
rs?

Thanks,
Song

[...]

