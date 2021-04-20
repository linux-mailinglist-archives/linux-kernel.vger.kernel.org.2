Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C60236617B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 23:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbhDTVWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 17:22:11 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20320 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233682AbhDTVWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 17:22:10 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13KLIt6S021472;
        Tue, 20 Apr 2021 14:21:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=xsK9MwpwU9FaF0Y7CXsT+MPsHV7k3flxUDzU4yLzj8E=;
 b=Pb2j69Kpv6D64DAZ9otBkFb7MnZJGkUShuw9eOgDT2ZFtH9Yx4xqcizD0RcTivAfiS9j
 sl9xpxPDfRRbxz03/mMj4t/qNSURmfIscMHivcDt6ePwTI4frLpeEL3ZWlsmmMM6u8Rk
 rDc1xq8ZSy+mq+XkNo0is30isejixWsz8U4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 381mf6wjtk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 20 Apr 2021 14:21:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 20 Apr 2021 14:21:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FChweokDsB28OgBnvamORNl5m3CxFnvRfdNqGqcrtff8YCHn0wnrTzwSDTPDVz5qECslehauwjvDMwkK+7yUKknqwmXNzPwzsb/iWdmFe90q+gSro+d9oBitNzbvH2EMGNOOJDt9oBDYn0MAjuea7TPIb7tIF2d/rMGz5OVZ2tXbhwB22BfH7wt1CbjlzDptgepFiW7fTHWvHVgQsulNTjSZGt8I0FBRx8kKwCicd77s5BAYlGg7LwtJlkoyJNrkhFhlyv0GdqmcXgy5FdCpLiPqe2ZL77/y4Fp/yF64FA0RoFIVATXAAwLA8GaTB2IvB0Pu8VuI1h7JiFLtL6K/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsK9MwpwU9FaF0Y7CXsT+MPsHV7k3flxUDzU4yLzj8E=;
 b=Tp0lvnxAiTuYjMO2NkEnnR5hZ3lQm4uEP9hoNPXsCG1ma1j/+gH47MpRPkehfikZxc8Z7QU6Rr+f4gOQ3xt9lFYy7Tu7KE2fOFDdteg3RfCw6BBk/Sj0kVNU9VLWmX/28uKRysyxVbDVLkyQw/LYZ0z7KAozjdrcZHlQFKTypV7y8n6ki+Tmnqv9u3y4Zajh18S2Af/hMAeNGuJu4iwsxfBewFKeJ47DEB6d49BhJLOSnawFwe47MCEozWF9LjCpUNHxGbDyK9fdpcK1GqFNObfN2ojelY3bFGCjj9RnYjtzdLMLz6lKVVgS/k554PjkHGzmSr4Xe+imYHcgnUoGTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BN8PR15MB2995.namprd15.prod.outlook.com (2603:10b6:408:8a::16)
 by BN6PR15MB1265.namprd15.prod.outlook.com (2603:10b6:404:e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Tue, 20 Apr
 2021 21:21:33 +0000
Received: from BN8PR15MB2995.namprd15.prod.outlook.com
 ([fe80::e4d6:1c0:16c7:f16e]) by BN8PR15MB2995.namprd15.prod.outlook.com
 ([fe80::e4d6:1c0:16c7:f16e%6]) with mapi id 15.20.4042.025; Tue, 20 Apr 2021
 21:21:33 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Song Liu <song@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH v4 3/4] perf-stat: introduce config
 stat.bpf-counter-events
Thread-Topic: [PATCH v4 3/4] perf-stat: introduce config
 stat.bpf-counter-events
Thread-Index: AQHXNVvKAeJiWUZbmU6OR6cKbig+tKq9qzkAgABAUQA=
Date:   Tue, 20 Apr 2021 21:21:32 +0000
Message-ID: <EE06CC67-3FFA-43E2-B032-EC8B37A9EC1C@fb.com>
References: <20210419203649.164121-1-song@kernel.org>
 <20210419203649.164121-4-song@kernel.org> <YH8P5ol5JRr5JO5v@krava>
In-Reply-To: <YH8P5ol5JRr5JO5v@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:c34b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e00a1748-b36b-45a2-6b0d-08d90442458e
x-ms-traffictypediagnostic: BN6PR15MB1265:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR15MB12656EA82E3C450542D591E6B3489@BN6PR15MB1265.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5pYgFUmFVwd4bPrifTdgx9nOHrX/evxagI1VgPIbSSBp4Jq3vrlvu5X3swrU1PdhyXZMAvoIXzCkDLOHAmJZAvXY5WSQHDMF3FzFbcBrFWQ1pqo0GB9PZAYVcJJE+NxZMKBVkmNSsEFoGEtWKEM1JzODxbgtCgHKJZ0Y0/tZ7ha8KO+2ZlgU2T/cQq/c6aTXWxUXYYkxSwDwLvHCJFxOLnePO5vssKNVwx+IH45+o2wFKwEbwOU0DOxjNHhW7q36YLF0lBDjIKIDQqqaxnljDAFo2XfjnMePz7Sl1oPP/rXAeFefjmS2BNFC/R25NrcjnfvsfJawU4nI+kEvLMMDs5Ztq7fwgY6W5vrQv1m2Fxe6KPR/lCPMRinNsa+15i/iL8lmHuz24rVeMbXqq1tuLFjE+5XB0gAcmnPoaH3p8Rkc/oHwJdjfkmI5Tz4ktz4SbzBpYQuCt0euzXC/xS0dg33Li5zU/a6+NqwzzAFsfNxLr6A1FV/MoWHCMJrI57SKSEavyJhg+gYUFG93dm/YAXCg+6C4pvC0p8jtZKEvx3fAdv7hRwyiNMbT9EjJQnqva7wWtnelDC1WWuy0eZJDkf6CDrhTVVjp3l+hvVol5xoKRf+l2nWhP+Tei/s92MXYbK1V9USYDC9nfBfTeWnltqoCCbA9vjwf5Vw1I5g88D8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2995.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39860400002)(136003)(346002)(8676002)(4326008)(5660300002)(54906003)(8936002)(6916009)(76116006)(478600001)(66476007)(66446008)(66556008)(64756008)(91956017)(6486002)(71200400001)(6506007)(66946007)(38100700002)(33656002)(36756003)(86362001)(122000001)(2906002)(316002)(186003)(53546011)(2616005)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ISoxfffjrkCrYgSTPFL3zvwzkK8wN8l5KRFb/VRLUPVzUI5C3rVsRbNoLnE+?=
 =?us-ascii?Q?V/elaQYkxNRCK5SVMsloyzC047Hn8FicwsaIpq+6jGicCaKIg/Z8PF4ISYO/?=
 =?us-ascii?Q?z+Lxp276fHcoMpWxu+/A/ADCliTe9jG3lY4lH4bDFdSePUoXzCLI/fyRgMcB?=
 =?us-ascii?Q?HSf8OCf+RzXJnyI8SCv5NV0A7nTbtrl5SYaWE/psB3GNMIKZE9Bd7vZKgZqo?=
 =?us-ascii?Q?rblLcJe3FA6mNEXhGzB3ylTOYrg4lusrhmClRcdnw4Hvm2DvP0ZEIp/mo7/o?=
 =?us-ascii?Q?L7L9Zrs4n3QvhbnkJjtlRe9jk57qy7X7awhjLVCRoeoTaq9RI/BpXjlzcbvU?=
 =?us-ascii?Q?Soq1sYuiRT/S2X9yae1x9gekFWPZYDkLE4f2Nex+Al6COigpWsTNcpPwoomh?=
 =?us-ascii?Q?wYDilwVAXBqQpQ8tA4BYrjBWoAtcQtShyAIEovawKC4kLgQH/pA7qExqvDKj?=
 =?us-ascii?Q?Xf27b49Je5XjMu5z40lFNJWWFVpl28NPfyab9xXaYTKXFrDTiJxyiLMnnFLG?=
 =?us-ascii?Q?wPNUFJ1FXpUh0i6/Ill5nS9WzmWLKA+n8ubfzwmN2KypGJajBpzonorUSzGQ?=
 =?us-ascii?Q?HGykd3hrMYuu0KZnqkaary9BDT77SEZVDPM/UNSjEJy6PZKRgbiCltKd1VFd?=
 =?us-ascii?Q?aI7/CO0ijRtK5sFDzIwIl1kdrA3IcC1ZJJ6i69H0sNRGsdsJaALh6tpbyYeG?=
 =?us-ascii?Q?f93+o80og9Z7TBs6M5OFxi1j56iqKpzhFlZJYDak4eBcEuQZE87Ilob8Enlz?=
 =?us-ascii?Q?kwwbQ0oXFDX74h6E5rB+YUgyBhPEACJ2oAPKCsxtctpxoA3AXIhJKMhvt/wy?=
 =?us-ascii?Q?6Hi0QYvN45Vbr7jdj43fapgo23r2Wtv7J69atwpJt94JHsWvCOHyApZLttwE?=
 =?us-ascii?Q?8Dibk3CY9iscJZvVI7uJI2cwa62Lsj4Qi8SHx4xmNytXIp3Ow6NgGbXxhHmZ?=
 =?us-ascii?Q?NYYRRRqOEVTs5cu9eKzNb+eJK6/2AoErvDMjd7jRONf08vp80fEG9INen/Ex?=
 =?us-ascii?Q?5P4a2+OVREthYUojRbSYic547qs9IpGALJ2OGVdv/eS7g1SuR1EpFUMCRDeM?=
 =?us-ascii?Q?Rl1CDD6Hw3eWNmf8//hy0nT9VPeUafCcvcql2sW/4F9HLNrwe8YR1RMfcLua?=
 =?us-ascii?Q?jnSv1JOeBvXQRJwtFHBnuFb0fQBz51H/6MdB/DuTIiQfKvQ10oWUoxBvoo0Q?=
 =?us-ascii?Q?GGxv4OcWjTSFAIIaqUdl3Cou621j8sBvZxV+e+ujptBj0an5tnGcLqzuFHJq?=
 =?us-ascii?Q?c7ZfDe56f5n72DbTFPFqHEKvz1uN4r6R+g5xX+l3txw856thqjauxxqcARKw?=
 =?us-ascii?Q?TDYw/+vqh8qTtrQ1PwTJoaBSoOMNDVyU6Y8aXBGvLM4Ve2YqX3xzZDwUby9H?=
 =?us-ascii?Q?7E7SpNo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C2708B3E81230845824AECBA4D3271CB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2995.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00a1748-b36b-45a2-6b0d-08d90442458e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 21:21:32.9650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BBHJL7kydtQLNzpVhFICesDpSOinsXkh9rFp2V6NnBn5giG/eplHpWYc+1T8I//d3iJ0TA63OsReIdMDy4vVbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1265
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: ukFXrP5U6NcAjaqvvtYuped57UoXB0Dq
X-Proofpoint-ORIG-GUID: ukFXrP5U6NcAjaqvvtYuped57UoXB0Dq
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_11:2021-04-20,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200148
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 20, 2021, at 10:31 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Mon, Apr 19, 2021 at 01:36:48PM -0700, Song Liu wrote:
>=20
> SNIP
>=20
>> 	if (stat_config.initial_delay < 0) {
>> @@ -784,11 +790,11 @@ static int __run_perf_stat(int argc, const char **=
argv, int run_idx)
>> 	if (affinity__setup(&affinity) < 0)
>> 		return -1;
>>=20
>> -	if (target__has_bpf(&target)) {
>> -		evlist__for_each_entry(evsel_list, counter) {
>> -			if (bpf_counter__load(counter, &target))
>> -				return -1;
>> -		}
>> +	evlist__for_each_entry(evsel_list, counter) {
>> +		if (bpf_counter__load(counter, &target))
>> +			return -1;
>> +		if (!evsel__is_bpf(counter))
>> +			all_counters_use_bpf =3D false;
>=20
> could be done in bpf_counter__load, check below:
>=20
>> 	}
>>=20
>> 	evlist__for_each_cpu (evsel_list, i, cpu) {
>> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter=
.c
>> index 5de991ab46af9..33b1888103dfa 100644
>> --- a/tools/perf/util/bpf_counter.c
>> +++ b/tools/perf/util/bpf_counter.c
>> @@ -790,7 +790,8 @@ int bpf_counter__load(struct evsel *evsel, struct ta=
rget *target)
>> {
>> 	if (target->bpf_str)
>> 		evsel->bpf_counter_ops =3D &bpf_program_profiler_ops;
>> -	else if (target->use_bpf)
>> +	else if (target->use_bpf ||
>> +		 evsel__match_bpf_counter_events(evsel->name))
>> 		evsel->bpf_counter_ops =3D &bperf_ops;
>=20
> with:
> 	else
> 		all_counters_use_bpf =3D false;
>=20
> I was also thinking of oving it to evlist, but it's sat specific,
> so I think it's good as static.. thanks for changing the implementation

Hmm... then we need to somehow make all_counters_use_bpf visible in
bpf_counter.c, which won't be very clean. Also, since this is stat=20
specific, I guess it is better to keep it inside builtin-stat.c?
The runtime overhead should be minimal.=20

Thanks,
Song

