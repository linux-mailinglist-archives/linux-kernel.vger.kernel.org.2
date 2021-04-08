Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596733589E7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhDHQkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:40:25 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35496 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232331AbhDHQkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:40:19 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 138GYwj7027886;
        Thu, 8 Apr 2021 09:40:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=cCL2jL6EKvzfnl/2P3yK1D4fh8E3m3f7wGFzziojheg=;
 b=T5okve2pue8uZmFQy3ctNOurO3MLkZQHOZrsnPuQkalXvFTGb4KRhSRVT2nTEWCDuY+F
 aWMFls8/CaT2wJJ3h6V4Aji+vbSeZHPURbo0sQMkHlExKVZy82cnWH50jQfeqieJBka/
 XJio3taXWaTCzZ1yV1TeAwuxEBVIw9WtZuk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37t23jsp91-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 08 Apr 2021 09:40:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 8 Apr 2021 09:39:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPGW9J8EtC71NBpAFr3v2iJqFxjjMaUlSIfnhc6yIEobrt6OK1vrUZyCadLzhVnZkh7F8CKcPTw7qnfHYSYoKSMn5/O8Vq4u2tqOqn5Ymp4mGqCelAx6Au+aw6sDpKXzufii8qIwOQQmQfUncUehFQalDhLxaPNm1MHWXNgQzbgN/8x7OiokqLQaTs/pQzjRn2lJoM5N4JIhbMg+L1Tz9ikaJlPg6O6zkGLiw6IccGhLlIEeXifQCXYXalc5Zz5bt7k3dMZdzRM7ugTzEPLONRZMwafJzOkXwY18MakRp5SiDA2E9w4kpsViY7j4WHEubVQsFPVlUrK+e0TbOpyxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCL2jL6EKvzfnl/2P3yK1D4fh8E3m3f7wGFzziojheg=;
 b=QXGocJvX6UvaMmsu/HKZye1mnM8Xp7ZGARzEdamcmdf4xJPWHR9xjth3yR+u/18eD5XqiUXa4RmwjcokD/N9JRojx0RMHNVdFNEVnfWWIr8v/7qDmSzlj+MQyvBUrEsdxqdoxVx8LQFZ83NWk+moQe+y3uZxDB+1kifKIM9QyzFn64dRTzuPPOBbppVj2/ou/zIGkffiILgY8QTpVETOzMm0xU7F6paX+6AIwMFFessNvHLVyGEHKfjCgFWeODU2RsMp3yYHRrdtxRyzOSiFiSxUWEzqNCI15GLkta2Cz5Okewph0ymA1+4Jry1CPsSAIP2VI3NSss2Wt9MiBNTg4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by SJ0PR15MB4203.namprd15.prod.outlook.com (2603:10b6:a03:2e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 8 Apr
 2021 16:39:33 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.039; Thu, 8 Apr 2021
 16:39:33 +0000
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
Thread-Index: AQHXK0YG4LdD7IbPc0ehmtAjm2+fxaqqg16AgABRlYA=
Date:   Thu, 8 Apr 2021 16:39:33 +0000
Message-ID: <FA667178-09F3-48C5-891C-9E44744276C0@fb.com>
References: <20210407003601.619158-1-song@kernel.org>
 <20210407003601.619158-4-song@kernel.org> <YG7tU/mVxQZLNCYL@krava>
In-Reply-To: <YG7tU/mVxQZLNCYL@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:57e2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85acbf3e-7c2d-44e5-5dc2-08d8faace3ec
x-ms-traffictypediagnostic: SJ0PR15MB4203:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR15MB4203A4F80D57E582A707905AB3749@SJ0PR15MB4203.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sN2+WwlDkg7QMTpzdskse7QPDRAhZWc92JCdwuVjlvSrxJHnZ45mbp6AWU6kBHJY7sOr39POjaTNEWdqDiaEOQ3vMLPIyVzQ5o5rSP70EMedvS8e73gdz2pmLfF1IHSSmkJNnjCmj0EgcxP20yrUnUS2UMhOTwNRmmJQkEl7DjXF5AEBRbjc1mG1p6nxvba1zJXd40HZ7UpeY/fBsj8cPPzwkUmdQcrUqdzgRiVl6DBcmSWSDu4T37Gy5bUOiMyDAQSTStvvBH0iPUWEBiZuPpxuzCM3RnK1qNAzF1D7KAy/0IqbrXu/43XO4LSl3nCCUBGisZhalKm1sR9WJKKvVy0LzhVSVYhwvfbwL5lWAo5d44CzKhftRaLPs/D8cnQeWevq9BeGHzeOHIRl2tJrC+D4e8DspmkIsXNmk50+AHoNwb2rogpgv5ePMxKb3OlYiUlGzeOj9jyspDg0OL6ijmI37sblka3yMnb/YWDhtQHTK8Epv9D9oF8Brx3iLgI/Y+UmOeQ3OSnl8qaYSc6SH1AtforWkeO91KpxuLHAcjcLTygNkRZ6jiLtcQBgDUSAIzvzQ4fVu12GFsDilKplLrldwE+BJfIjoh431n0j6dNOLAAOkzze0ucM1ZnlA1zCQCutLdJsxNFpHajECUYlwd0D34zBBI/AYEaPPregiBp7DKnMUf9IU54KvhbHSS75
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39860400002)(376002)(396003)(366004)(8936002)(478600001)(6512007)(4326008)(66476007)(186003)(64756008)(66556008)(66446008)(8676002)(54906003)(66946007)(71200400001)(53546011)(6486002)(2906002)(5660300002)(76116006)(38100700001)(2616005)(33656002)(6506007)(6916009)(91956017)(316002)(86362001)(36756003)(83380400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Tu00VGHy7XezQinzSF+ZyX4qrbt6XAFaV3S/K1NKofYsPdScbRQyN9YavPkl?=
 =?us-ascii?Q?Qr5T4rv3OukXVQJJVm7pwLTMdBvz4JV9HULH8qlwRQyKL8T/xJHiLIY8DORA?=
 =?us-ascii?Q?u/1WN0OsrtyavkiBA/i4FP+Tr/jCmiNCJIB31s6kzgr9ILoPj+GQ/3ij0vA/?=
 =?us-ascii?Q?K/SCK4E6evIiQPCYwdDW4XxsVwWdVX7ZSPMDN3BEtTPohBFQCnTrfNrrXp6c?=
 =?us-ascii?Q?DD1cuYkuY6aJaqa0hCo6wLroIWPV917roAp0dFLjZ0XNbl2JhWunLMY2DcMP?=
 =?us-ascii?Q?k3sUoV+lUzM1cpzLzQRmW4E/NzWmg8LzLrRSLMwM19GiucELy3q4clm357F8?=
 =?us-ascii?Q?T1b5IM8PWkeVfWk6MKL/dhj66+FMV8q5Vje1KSU59RD5S8wPADg9XblJzfT1?=
 =?us-ascii?Q?t4SOuB5IM6EqNsuH/hepIjrCjzOCWcjQxRpu0gtwmEkS0gN30Xh4fEWilW7Y?=
 =?us-ascii?Q?9gzBtPjXwLAPw4YoG2dPPu+Osxtp28IBmYk/rzjRnVyHPyP5KcrRG/NCXt2e?=
 =?us-ascii?Q?KWhMuAJ7FgtJjYhBIg5dqivA2JM8Qi4wWKPtC1dR0j3uneqzD37xVjISdq6g?=
 =?us-ascii?Q?MdFmzKVxCmVixyEWcbibH1HDWFElaKho+L9RrsMv5bdEGh/G+0ynblQ0cG9B?=
 =?us-ascii?Q?SI8+39AoQJSAcmHAHovDjpD496aWnXpoJtwB83EEk7OlOhHmgsqL/o45Xt0/?=
 =?us-ascii?Q?cPn6YENc+WEHOX6IzNgY8/WgCrPdJVgTIEoPrHfUPyarpAmkEK/3VZ76GAYk?=
 =?us-ascii?Q?wwNYCmh0EE/q10gFYKDRNMBMKt+C0qXvEqibKk6B8IV1MGywblHqbtg9Nru7?=
 =?us-ascii?Q?B+5Dt7U4TnYCYhMo2neLbjmJgzjm3hVjUbrTWYNLP2j31jxfqWg+AMGaaRip?=
 =?us-ascii?Q?kJLRz/3XQJRG5ednUxNbhxuiXj8Jq0nYUn5O7curKgU+CLa5j0OkP1oZc/KC?=
 =?us-ascii?Q?du0STUI8BpcGstKF0Z/GlrxwFtdSH/qoe3P9RkPpSlpz7ZWJsvEg4L4PiDBu?=
 =?us-ascii?Q?rDFtGKgcS9kbGFDUowoAUYPATJxENrgPpFtYEKgDe8vGsYgmXHFDi6WtMffc?=
 =?us-ascii?Q?zoaY9gZIFAuaYpLzZlJ184mYWklVDG4uGTegeqPQdJ8WrczO+7NDUiUI68ye?=
 =?us-ascii?Q?xgDpTlidBjFlXC3HMOLZTZAQI+Ui5xycmhCofWlPgsjlsAZbgHHZgJ2IBxGE?=
 =?us-ascii?Q?DQjv3/IMl17KniVW8JDpTMN85BnBMUjPY4YxF7ZV4Bb1/59gfwASz02goJnE?=
 =?us-ascii?Q?2IWIdlSLN8bsVegEGmra/GVqjE89wcNr99l0sqKWMo46T43IiVjDcIaRC7y1?=
 =?us-ascii?Q?AKE/w2CTuBU1xsfyA95KGO5DDFRQw3fTv2eqIScJ2WND+q7lV2ISgmf+XFJG?=
 =?us-ascii?Q?ugaJLEo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6375BB2C43BFE04095AA4897889410A1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85acbf3e-7c2d-44e5-5dc2-08d8faace3ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 16:39:33.6193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ghyf8Bt5/ncfN+qmOKH7A/6OxQBsm2uk7EepN4aSieTVcApoxbwnd5p3JdHnqHuWCHP4VS/vBlyF1LmmdNKMJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4203
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: hol-I3hDyirc5JcfYVuNwiYepG1px7V7
X-Proofpoint-GUID: hol-I3hDyirc5JcfYVuNwiYepG1px7V7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_04:2021-04-08,2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104080110
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 8, 2021, at 4:47 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Tue, Apr 06, 2021 at 05:36:01PM -0700, Song Liu wrote:
>> Currently, to use BPF to aggregate perf event counters, the user uses
>> --bpf-counters option. Enable "use bpf by default" events with a config
>> option, stat.bpf-counter-events. This is limited to hardware events in
>> evsel__hw_names.
>>=20
>> This also enables mixed BPF event and regular event in the same sesssion=
.
>> For example:
>>=20
>>   perf config stat.bpf-counter-events=3Dinstructions
>>   perf stat -e instructions,cs
>>=20
>=20
> so if we are mixing events now, how about uing modifier for bpf counters,
> instead of configuring .perfconfig list we could use:
>=20
>  perf stat -e instructions:b,cs
>=20
> thoughts?
>=20
> the change below adds 'b' modifier and sets 'evsel::bpf_counter',
> feel free to use it

I think we will need both 'b' modifier and .perfconfig configuration.=20
For systems with BPF-managed perf events running in the background,=20
.perfconfig makes sure perf-stat sessions will share PMCs with these=20
background monitoring tools. 'b' modifier, on the other hand, is useful
when the user knows there is opportunity to share the PMCs.=20

Does this make sense?=20

Thanks,
Song

>=20
> jirka
>=20
>=20
> ---
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index ca52581f1b17..c55e4e58d1dc 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -82,6 +82,7 @@ struct evsel {
> 		bool			auto_merge_stats;
> 		bool			collect_stat;
> 		bool			weak_group;
> +		bool			bpf_counter;
> 		int			bpf_fd;
> 		struct bpf_object	*bpf_obj;
> 	};
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index 9ecb45bea948..b5850f1ea90b 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1801,6 +1801,7 @@ struct event_modifier {
> 	int pinned;
> 	int weak;
> 	int exclusive;
> +	int bpf_counter;
> };
>=20
> static int get_event_modifier(struct event_modifier *mod, char *str,
> @@ -1821,6 +1822,7 @@ static int get_event_modifier(struct event_modifier=
 *mod, char *str,
> 	int exclude =3D eu | ek | eh;
> 	int exclude_GH =3D evsel ? evsel->exclude_GH : 0;
> 	int weak =3D 0;
> +	int bpf_counter =3D 0;
>=20
> 	memset(mod, 0, sizeof(*mod));
>=20
> @@ -1864,6 +1866,8 @@ static int get_event_modifier(struct event_modifier=
 *mod, char *str,
> 			exclusive =3D 1;
> 		} else if (*str =3D=3D 'W') {
> 			weak =3D 1;
> +		} else if (*str =3D=3D 'b') {
> +			bpf_counter =3D 1;
> 		} else
> 			break;
>=20
> @@ -1895,6 +1899,7 @@ static int get_event_modifier(struct event_modifier=
 *mod, char *str,
> 	mod->sample_read =3D sample_read;
> 	mod->pinned =3D pinned;
> 	mod->weak =3D weak;
> +	mod->bpf_counter =3D bpf_counter;
> 	mod->exclusive =3D exclusive;
>=20
> 	return 0;
> @@ -1909,7 +1914,7 @@ static int check_modifier(char *str)
> 	char *p =3D str;
>=20
> 	/* The sizeof includes 0 byte as well. */
> -	if (strlen(str) > (sizeof("ukhGHpppPSDIWe") - 1))
> +	if (strlen(str) > (sizeof("ukhGHpppPSDIWeb") - 1))
> 		return -1;
>=20
> 	while (*p) {
> @@ -1950,6 +1955,7 @@ int parse_events__modifier_event(struct list_head *=
list, char *str, bool add)
> 		evsel->sample_read         =3D mod.sample_read;
> 		evsel->precise_max         =3D mod.precise_max;
> 		evsel->weak_group	   =3D mod.weak;
> +		evsel->bpf_counter         =3D mod.bpf_counter;
>=20
> 		if (evsel__is_group_leader(evsel)) {
> 			evsel->core.attr.pinned =3D mod.pinned;
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-event=
s.l
> index 0b36285a9435..fb8646cc3e83 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -210,7 +210,7 @@ name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=
=3D]*[\']
> name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
> drv_cfg_term	[a-zA-Z0-9_\.]+(=3D[a-zA-Z0-9_*?\.:]+)?
> /* If you add a modifier you need to update check_modifier() */
> -modifier_event	[ukhpPGHSDIWe]+
> +modifier_event	[ukhpPGHSDIWeb]+
> modifier_bp	[rwx]{1,3}
>=20
> %%
>=20

