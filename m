Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A94364B23
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 22:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242110AbhDSU1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 16:27:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44562 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231779AbhDSU1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 16:27:49 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JKO8kl027740;
        Mon, 19 Apr 2021 13:27:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=I0xm2Wf3W27CAz8s39mOMim74iinrtjrrbNwjJy0YM4=;
 b=qA64i8flqTn2we6cx/e6M6BVp4TrvsiEGZ/WQtyQSLAvBDNHQ9BpvYKJFiN1AYXNeutj
 OFfm3Uc2b24Yoebj0NY1li3Im80FdNU+Z5YTnGWiH1fSyhCieQqQTNkYcck8yIhdabV4
 M8Eh8P1l9AQ60KYTAHdsNc1DxjO5kBIRtfM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 380fe4f6rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 19 Apr 2021 13:27:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Apr 2021 13:27:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lmjwhwp6CHdo3Amczxy9o8kY5D6TKWmJMRR09uYl8tPQFP96pGSBy59ebkj0Ik6WQ8BxtrBUv5rdHlwodUR2orHBz9Y4FX5/X1vx/BhZbAm7dHlzgnMQr0uzku+DOSA/DBG3bztZhXuju6gu/uwH3OCTIfth6FHZuRUm02vK2CFBiOVNFRqco7afsukwi7RUW92Fxvg41erdtY7HeThEMi6yM6NwmC1SrpY/ejGvzz7Vrw3EnSIpn/qLd1Idj1l2Dbo5PwH/uMd3PvWaXFqIa6bXGl93gfvSWDTNVvP/p5sHnAAI8oGQC3WLeSMfzJCPZDSpkDVoyB1qn6VKmVOCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0xm2Wf3W27CAz8s39mOMim74iinrtjrrbNwjJy0YM4=;
 b=RBNloit7q4w0gnfa2gunRkriOjh1gVQhkxJ/jLHO53eudC0Ba+CsNsUq3/Jx6sqdB4vzvsniG6B/hUwVnbeDnwYD0D8PgEx+jb9uJGEJ0U9FqMI+sp5wTiScnxex9cIxna6KLSNzkAGicJa2H1w81hRCu/OFIQK0Xkh6SDjOL9xz5dHJgFxnxGsbfUpUN3tYXLr0DSBx7Yib2Dz77Ji0DbPme38efpc+BPMydiZdf4Xb8jE6So5njz7goCKH8KgOaxr77E2L294n32zJXtcH1SAXQtWrzFC1MPQr+BWxlGW1ITn8x5xntmLJmxJuHucq+1HYFWGuh5Pl7fJ7rCDovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BY3PR15MB4978.namprd15.prod.outlook.com (2603:10b6:a03:3c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 20:27:14 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.040; Mon, 19 Apr 2021
 20:27:14 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Song Liu <song@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH v3 3/4] perf-stat: introduce config
 stat.bpf-counter-events
Thread-Topic: [PATCH v3 3/4] perf-stat: introduce config
 stat.bpf-counter-events
Thread-Index: AQHXMw3DyOxUaVUpS0ODNNUcJNtKe6q76eYAgABkwYA=
Date:   Mon, 19 Apr 2021 20:27:14 +0000
Message-ID: <C55B43CE-0909-4322-89DB-143A300871A6@fb.com>
References: <20210416221325.2373497-1-song@kernel.org>
 <20210416221325.2373497-4-song@kernel.org> <YH2THG9zES3rjvEs@krava>
In-Reply-To: <YH2THG9zES3rjvEs@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:83ef]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1e4035f-e799-4c25-cc94-08d9037184b1
x-ms-traffictypediagnostic: BY3PR15MB4978:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY3PR15MB49782DDD71A3ECE445DDCF5DB3499@BY3PR15MB4978.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wUs8UCe4WEszYiY2sSmWlsLuyl3zXlCVRtYI/lu+oWVrdRmMcmWiz91Y43ELULui4E3puAuFnUPoE3578bjz0RfFp93jTGCCZQr7+qA7wJP68ZveCLca+bpdVvhoYvQUV0wy9qBLf+NdKdbjsTefwdL7UZrOsfO0PgtPyYB+5d0AOVr4lbytuYs8vkR+nBZ0n94iXjeu+aBwh7o1ITyVKWB+/cyox7x38XeQgUcI0kQ0UH5+wtm2lgUo2E5G/nthIJ2RdcanTtFqq3iatv/gUiy2JtC+D1sWUzW4O3306To8Y0KO9503dLYNmBAEaNHLrPLzvgOMrAoRqnNEJ0c8yguu3v0CBP6mOtYTjwmQljRc2Tj4I6mgCllA+IdZ1EjWnvSeoqi6K1XzvhQ88OkINhi3XM+iE0NqJfVP6pUQFo/DCqR7XxkRwT1zEIFe04RVOosiL+iRWM9mZhSb+mfThrcvMo8jSNT7zV4CYCTJRv+g1Gs8yCCklKytL1L/9xgiAACzG/h/mRm8K2oUv+iYXiUJAfh8xBIykisOiklMaEdyWZhGBpVLrfaqoHCHOfZcNLyQ2xjPXx1NoNlqT8DCoG//uTYfR7CTLo88BBmbFy5HwCkWCHTm9Rq6lo4eYZ52q4OV1ENPoTrVxUjeU02Dlt9rFfUOyIsoOdilXQvNFcA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(71200400001)(8676002)(86362001)(8936002)(76116006)(54906003)(53546011)(5660300002)(38100700002)(6506007)(6486002)(66556008)(66446008)(122000001)(2616005)(64756008)(66946007)(66476007)(4326008)(186003)(2906002)(33656002)(6512007)(498600001)(91956017)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FdmD0tRbj+ErWXGU7DoL3YblOb0l6h1PBleEhi1tKV1WjQDFrhlQxlxlGIC9?=
 =?us-ascii?Q?BuKyPaGu8lAG6aLrmcRHd2KFPzwRhWcIBTbIr+H/OnpxHtS/o/lPOIRLrK+W?=
 =?us-ascii?Q?iQ+tKIe7/pr2mvXg0ug4mHMx3C1fdPguC5Gga8sCb/k6h6RhGcUvGUdZc/BO?=
 =?us-ascii?Q?Nt+mtnpneau7Sov2U3HXuDJ7NJuRqifP/PSR95vvD95xNijtHt05pnwYj94c?=
 =?us-ascii?Q?xP75TNLsNjHBTkkgIXFe8yM56SAcGwNguap43FJOwaDtyOOwwynoCarEdd1P?=
 =?us-ascii?Q?cVH9G4nxx3/UtyO6B5eUYuwHx6CIqOTw+4h7qXjPM8AQFF/lmVcIpkEThHb6?=
 =?us-ascii?Q?FF/qDp/ZFZ3G9W0FZLpRPCYIpo11VKsEC2e9JbH64Wmlz1DZXWheRsxTon2/?=
 =?us-ascii?Q?+zdf3JtzxI/0z5O6q2Uz8jv2gYkhopvbqv6zbENe/P806yB3gO4FepVIXB3X?=
 =?us-ascii?Q?4CA3TgUpgxSMbdRf6OjaSLINwMfMswfcw79g6H6SnSQYldfROHRaeQWiXo47?=
 =?us-ascii?Q?wll7cw7efjepVAUT7D2kpub48i2/jXua/Nn5sxjzv8tVG3hndRgbjabQbYCK?=
 =?us-ascii?Q?UCJO01DU3SNrWfWR7DOo6nZcwduqteuTcw4EfW9A3V0Lt/ZJJcUhfUQeM2CK?=
 =?us-ascii?Q?ZLN58RcfUlbeefTP7GVopwwCg/SwZD4cUxm8Q1sNqxOY8WjaNUDwXGtvpTVV?=
 =?us-ascii?Q?8032H5j0LBC9odlXkjhGuw3SGQzY9VfULr0mSByiD3SakfoaYgrWJOtVWaen?=
 =?us-ascii?Q?4hB7/ivNmEWf1QRu7cbYYCs12oGPqDxdW2BfId1dpqIKgjNVLuROAuthbvgY?=
 =?us-ascii?Q?M6oERM3wMFER9IOLMVd3OquXqGvaR6y7kZX9s3RzpYLSU8R/t+nSS8TS5JFq?=
 =?us-ascii?Q?BfS9sGuHrUAiTmT65fumeauJRBeTIh5Ddlaf4IBGbm7QnbxMNgVbll9u1at7?=
 =?us-ascii?Q?BnRxdqRc0034p7q0gB7wiSUhm3hD0BRHeTsZsJqVeBtsgRDci7TRTnV+bmCC?=
 =?us-ascii?Q?C5UErMDSGsFNrZIKGt5W8v58f7t0uuno0zGXrK74Cxygmn+bsG6w+ufK1hTI?=
 =?us-ascii?Q?qDP8D/mc4xGVTk96FPiwhyriLs0xVUf3SHgQoEYq53Bn+Ah0Ot3VuaC1GM8o?=
 =?us-ascii?Q?wtFebjshh7vvNOKgZfnmDBdq3zDWRelYdeakZ/QeK9XYsdgTeUPYX5dqec74?=
 =?us-ascii?Q?xTgb9fG9XlTpUz9mRuwm8d8vQbrgZ7QdyFl8Pp9N8sZ620tHTt9dhvBeWwKo?=
 =?us-ascii?Q?7I/hcWyTVdxyhpPrcuM3eubbXPfEM5EABx/US+bRqrkIBmaPD2POd93JBwZs?=
 =?us-ascii?Q?UKTPWppxu3MZUgVrwLuRlKqTdItjub5YZ0axVSi7nc/MOgdVP/+NKOcaoai3?=
 =?us-ascii?Q?Zeor9AY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BE992C2EA7F66E4693749C48E2866D14@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e4035f-e799-4c25-cc94-08d9037184b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 20:27:14.1738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mh6F1/eAqdMNh1Evyd6icA38nyT5PHeprc6mEPDDJ2/eizwngyMH9ld9cdZqZPmjDkAUorLHz8GWmVJ3rWIDLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4978
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: c96VY2J4byrgd768LwrO4mo1PCYUz0pO
X-Proofpoint-GUID: c96VY2J4byrgd768LwrO4mo1PCYUz0pO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_11:2021-04-19,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190140
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 19, 2021, at 7:26 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Fri, Apr 16, 2021 at 03:13:24PM -0700, Song Liu wrote:
>=20
> SNIP
>=20
>> +/*
>> + * Returns:
>> + *     0   if all events use BPF;
>> + *     1   if some events do NOT use BPF;
>> + *     < 0 on errors;
>> + */
>> static int read_bpf_map_counters(void)
>> {
>> +	bool has_none_bpf_events =3D false;
>> 	struct evsel *counter;
>> 	int err;
>>=20
>> 	evlist__for_each_entry(evsel_list, counter) {
>> +		if (!evsel__is_bpf(counter)) {
>> +			has_none_bpf_events =3D true;
>> +			continue;
>> +		}
>> 		err =3D bpf_counter__read(counter);
>> 		if (err)
>> 			return err;
>> 	}
>> -	return 0;
>> +	return has_none_bpf_events ? 1 : 0;
>> }
>>=20
>> static void read_counters(struct timespec *rs)
>> @@ -442,9 +455,10 @@ static void read_counters(struct timespec *rs)
>> 	int err;
>>=20
>> 	if (!stat_config.stop_read_counter) {
>> -		if (target__has_bpf(&target))
>> -			err =3D read_bpf_map_counters();
>> -		else
>> +		err =3D read_bpf_map_counters();
>> +		if (err < 0)
>> +			return;
>> +		if (err)
>> 			err =3D read_affinity_counters(rs);
>=20
> this part is confusing for me.. I understand we don't want to enter
> read_affinity_counters when there's no bpf counter, so we don't set
> affinities in vain.. but there must be better way ;-)
>=20
>> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter=
.c
>> index 5de991ab46af9..3189b63714371 100644
>> --- a/tools/perf/util/bpf_counter.c
>> +++ b/tools/perf/util/bpf_counter.c
>> @@ -792,6 +792,8 @@ int bpf_counter__load(struct evsel *evsel, struct ta=
rget *target)
>> 		evsel->bpf_counter_ops =3D &bpf_program_profiler_ops;
>> 	else if (target->use_bpf)
>> 		evsel->bpf_counter_ops =3D &bperf_ops;
>> +	else if (evsel__match_bpf_counter_events(evsel->name))
>> +		evsel->bpf_counter_ops =3D &bperf_ops;
>=20
> please put this with the target->use_bpf check,
> it seems like it's another thing

Thanks for the review. Fixing these in v4.=20

Song

