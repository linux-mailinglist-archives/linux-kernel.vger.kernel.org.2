Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28F136A8F8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 21:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhDYTJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 15:09:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32854 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231197AbhDYTJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 15:09:52 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13PIjrPu000347;
        Sun, 25 Apr 2021 12:09:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=GQWKDQM46jqnYWPwu2ni6r5o1Z3A3m28dfWXZsLI9Qw=;
 b=KoOJttBxx+KVtepdWLmgSlLBNryjb5a9ngt+WVbrBwJT4irEierH4G+FabjTbkpKlOro
 mv7qoQ99S69ZlFydbq1Aukcs/L6l+wq+5/2h++2F6y5nrevfABGvn1Km6xBO4853L89R
 cI4qnlO+dhAJE66wRnJvleXrJVN9tPpmGSs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38530b9ywj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 25 Apr 2021 12:09:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 25 Apr 2021 12:09:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUfbJxy4ISOlKEX91qDhwp3cKkB0GntbZ/WfBzK/LnXPoGg5jmt7nt3gv3BXUuniBaMaCBsc8U9hmRjFFOMcRtwHsJ/7lcvZiF+rVmxZ4ZRa2+CsRDGmAf+fphd6QTsdYrq+gl9s6b1ultorGddSDiIil6z3GklpqEgRQCjsSMsyFq9CRda3Ume2Wx0F+PnuUaH7plExJ8CSKolcPqKBk/IAH22TzFLrQ037BYWETsfDs2Ynf2Mkl6rmjS9n0ASUl/bu7In2rjEchC0BRJlk6rouZA2HhDjS878cEMCUPmHrOVZ97VxzUnmgSX9K3whHieY8NiB2PAQ6n7K+mAmPQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQWKDQM46jqnYWPwu2ni6r5o1Z3A3m28dfWXZsLI9Qw=;
 b=aO5o+u1DwGFMMooK9ZfLqTgkScdrehBtbKfS2+6U9Wwtpew2VQYbVAHegDX5+WG9/OcVUHF2SRUpBQG4pJLJpRLsk3bDWimJk1xOJUurf5hTOG56Oal+mg49boDBM7MbUWePf0ZZMtuNw8x3S4RmsnhKxDQxWSN5cfXVd+H/BSt0qGm+TmtceqeWAL5T04r6QaCZLuso89BxmsyFBEnmShuWrgAHPlUeNN+aBAsj7rGLTAuqUVbKvazZBhoo69PykIpljDM1x+iLG/nG6/PhCRJn7LUxtHTQcT543haP04Ih2x0vVjK25NiJaqyrVBicFrB49n4Ah+AAjjii9P0L6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by SJ0PR15MB4679.namprd15.prod.outlook.com (2603:10b6:a03:37c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.20; Sun, 25 Apr
 2021 19:09:07 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.040; Sun, 25 Apr 2021
 19:09:07 +0000
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
Thread-Index: AQHXNVvKAeJiWUZbmU6OR6cKbig+tKq9qzkAgABAUQCAANkPgIAGkhCAgAAKsACAAEDcAA==
Date:   Sun, 25 Apr 2021 19:09:07 +0000
Message-ID: <26FCA13D-B58F-4FD9-8A0F-EA29708B3EED@fb.com>
References: <20210419203649.164121-1-song@kernel.org>
 <20210419203649.164121-4-song@kernel.org> <YH8P5ol5JRr5JO5v@krava>
 <EE06CC67-3FFA-43E2-B032-EC8B37A9EC1C@fb.com> <YH/773ecFa3iESlH@krava>
 <YIV+8zIj6YrzNXoL@kernel.org> <YIWH6mKgIvPSfXRP@krava>
In-Reply-To: <YIWH6mKgIvPSfXRP@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:1382]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9106467-ce70-4598-ad02-08d9081d9975
x-ms-traffictypediagnostic: SJ0PR15MB4679:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR15MB4679056D4FC23EB9D8FB3C4DB3439@SJ0PR15MB4679.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BkGPjXjod4WPA6MmU3YzF0YnEYqRHGAxJEYO8jxIItnIcko+B3E0Eu4054wXXdV+dn99KsIXRtlDNcyJnvdHbx9okeR/GkAJSiJkeh9JYOzNXfBMPzRA/Tlhf6497vdrPtUSTZobab9MWZX5eoMyN9AlHL8Yi/MIHP9ZBPLplaqW8H5WSe39HiFbyUUOEhQ7H96nAiJpnDPwdtacEeKcKK9qDoXtxvFSV7s+wmzYX2JFru5t6r4q0RnZOMj49YWGekk0ouBLF6vd1MW+IHx2xb7Qvak1XU2un/afXtat+jfnzL4EzeVMdUjkCkPFROTvsVfo4MTYbw0TirBiaAuFndAbH4rG82soPHzES7Qsy5DemrPswGpOjghc7xDKs0qoQezdutXY6o9jQB87mpqgVPuPXpwF8/S5rwYA/IWvhcRDMAMaBHi0X45C7OBrg5aK5cJcKHn9wG73CA4Vby3lYMI6YY5GNSNtDqtwrUsPil/OXUS5dJfn931mn/bn89qYkP3agi/Dt/zdMZH1JiyxEfc0mzOXpM2fHwYvqSMefQ87ZhBvj0SP3yMFF++V5HJ6jiFqIrYIByhwm0I2os15aMsnLNokvZZ+39ZXZmVxlJYBXXxhNumBcplwqzv6mGMw1TYPdVBB7cDti2L9Hy8kClrB/SCrplWhZEscyC4CY8dxQtqcHE6WQTlqRacTGnXH7ytT2kWDgFyHACWj3x7uxl0JJ58KXCjZpr8tXtFtqfOon0fw5+kalVgeFAyx+mBL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(66446008)(6512007)(33656002)(66556008)(5660300002)(122000001)(38100700002)(64756008)(36756003)(2616005)(66946007)(478600001)(66476007)(8936002)(2906002)(966005)(6916009)(91956017)(53546011)(4326008)(6506007)(6486002)(316002)(71200400001)(186003)(76116006)(54906003)(8676002)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9D9UKt4oa1jPImr6fz9zWJWZV87Hsg3VggBLeolL/u6LTP1WO6ifwWBfDn2w?=
 =?us-ascii?Q?rasOY3BTjsiaZun1+wYPbX/d5E3C0hdJ0z3V1LLht/wL0bsVeIsLH5K/YT59?=
 =?us-ascii?Q?mEr1pnVEGfFIoyJ6e8Mq2/wyGq9pzFXzMrjwoDZVKTD1qcDYGeUv4L8vUnNg?=
 =?us-ascii?Q?hn3RF20FFKW8oZj2S/mpooEp6nGFB0U23PzMDfBKXi58iyz2x6x632cYjvF5?=
 =?us-ascii?Q?j0O603whmz9ALM1rp2wkngTRl5vsu4lFCSYTA/qfnNbFj07FjawipvoOdxNH?=
 =?us-ascii?Q?ZAJfELvaWQ0XPuX0o+Gy1B8H9OOFiAd0+TqguFXMUQqun6gOCss3QRsNJVwP?=
 =?us-ascii?Q?X3/e2jFcuPIMTrd5muuo2cX3UQAdRjJmLUy7SVc1QNR4HWPLjO56bzdxWtO5?=
 =?us-ascii?Q?HfEHxDrgAZZClYDBj+LlF8jl3uYD+xP/5+9Cr0s7fowBb0RjojzYdYQPaMY2?=
 =?us-ascii?Q?LIcO3kv9tHKXnxgcxO9fJONbEPERqcRUDZJoE5Dv9iMfl6yuVA+HLjDUlk8R?=
 =?us-ascii?Q?nY8057JmF1KWo6oOFoN0yymgmSCtZWMAimibf1EqpbKsAEALcsNkV9l9msT5?=
 =?us-ascii?Q?NVTc3J5DvC5SA4XhxR9KxQpCH/UkopKRJMzuBqyp0VQaWLWug/PLkWEfXK7o?=
 =?us-ascii?Q?SGlLPou1N8gbAX7p4FjzNQCWdkLS8RaaxDwpUOElmuzVpCiODZ06AOkyvsZf?=
 =?us-ascii?Q?X3IwUvUT5PQnNW7ac+rjwNEahbf+Ec5A7LlP5o5qBm9rtPYDVQ9MEbbVQmnf?=
 =?us-ascii?Q?D9JiL1ONg0SPlgoaBtEGsLbWS6FYJMGUrESy9KJTQ69l0Tndqwf+zwqP6frz?=
 =?us-ascii?Q?0BW2NYlfiZP8I1EekDKxMpYmDuD7odDsgK90O1J0yrd1+cLm1DXH7wYt5GxJ?=
 =?us-ascii?Q?b+J35OW9eN9EErKHzHOXuz3MOsPLlpG89W75OFyYO5LN8QswEWB/G+DT/MVX?=
 =?us-ascii?Q?rYC0zbXfCZm4U+e5dH5aQVH7Zmy0UsOmLvp4DbXA1cStiAn/SIMF3OTq5Je4?=
 =?us-ascii?Q?+54ohSPYFDhTj0bL1KVsLFYRWESx8HvIJRc64/vdS42E1L4/pGRQsLqgcWT+?=
 =?us-ascii?Q?t5P5QNeAqj6YTt3R92Cge9vtxcM5lxXSnNrh8uF0M2m/bN25cM3ND7N0t1NA?=
 =?us-ascii?Q?XfVovEhEHqnKhk4/NH0TCf7nTGQm5nAG6cugV7OX0QRvsBihhH2N/EK1T56q?=
 =?us-ascii?Q?ghL7TVbadFzWl7ipHf+mnWOdMYZE5cnU3y3I3bP82yUYbfDFe5iqe8Om73J1?=
 =?us-ascii?Q?E+niydzBSeB3B5AS434unTNkn/bG81ihykA3daXWiUdHfvoV4dBQtl9Dxo/N?=
 =?us-ascii?Q?LN2Hxxiy0w6fMVoSvx3X8OSvfjYS/HKKccMn0WRR77btTQvmT6zVChmgYg8Y?=
 =?us-ascii?Q?gG+lv+Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7D52D82C14541D46B21E6E6E24DA7006@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9106467-ce70-4598-ad02-08d9081d9975
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2021 19:09:07.0915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9TtZqrnkCh5ixxIDMu5ZLYPmF/7szarxVbcLAuX1/UhS5+5OvtoQizceGZWGf3Q9T4letbLZymkmXLZXjevuZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4679
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: zmroBoDm3AqPPa5pl1Dxvg1Gtf7ypSbn
X-Proofpoint-ORIG-GUID: zmroBoDm3AqPPa5pl1Dxvg1Gtf7ypSbn
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-25_08:2021-04-23,2021-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104250141
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 25, 2021, at 8:16 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Sun, Apr 25, 2021 at 11:38:43AM -0300, Arnaldo Carvalho de Melo wrote:
>> Em Wed, Apr 21, 2021 at 12:18:23PM +0200, Jiri Olsa escreveu:
>>> On Tue, Apr 20, 2021 at 09:21:32PM +0000, Song Liu wrote:
>>>>=20
>>>>=20
>>>>> On Apr 20, 2021, at 10:31 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>>>>>=20
>>>>> On Mon, Apr 19, 2021 at 01:36:48PM -0700, Song Liu wrote:
>>>>>=20
>>>>> SNIP
>>>>>=20
>>>>>> 	if (stat_config.initial_delay < 0) {
>>>>>> @@ -784,11 +790,11 @@ static int __run_perf_stat(int argc, const cha=
r **argv, int run_idx)
>>>>>> 	if (affinity__setup(&affinity) < 0)
>>>>>> 		return -1;
>>>>>>=20
>>>>>> -	if (target__has_bpf(&target)) {
>>>>>> -		evlist__for_each_entry(evsel_list, counter) {
>>>>>> -			if (bpf_counter__load(counter, &target))
>>>>>> -				return -1;
>>>>>> -		}
>>>>>> +	evlist__for_each_entry(evsel_list, counter) {
>>>>>> +		if (bpf_counter__load(counter, &target))
>>>>>> +			return -1;
>>>>>> +		if (!evsel__is_bpf(counter))
>>>>>> +			all_counters_use_bpf =3D false;
>>>>>=20
>>>>> could be done in bpf_counter__load, check below:
>>>>>=20
>>>>>> 	}
>>>>>>=20
>>>>>> 	evlist__for_each_cpu (evsel_list, i, cpu) {
>>>>>> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_cou=
nter.c
>>>>>> index 5de991ab46af9..33b1888103dfa 100644
>>>>>> --- a/tools/perf/util/bpf_counter.c
>>>>>> +++ b/tools/perf/util/bpf_counter.c
>>>>>> @@ -790,7 +790,8 @@ int bpf_counter__load(struct evsel *evsel, struc=
t target *target)
>>>>>> {
>>>>>> 	if (target->bpf_str)
>>>>>> 		evsel->bpf_counter_ops =3D &bpf_program_profiler_ops;
>>>>>> -	else if (target->use_bpf)
>>>>>> +	else if (target->use_bpf ||
>>>>>> +		 evsel__match_bpf_counter_events(evsel->name))
>>>>>> 		evsel->bpf_counter_ops =3D &bperf_ops;
>>>>>=20
>>>>> with:
>>>>> 	else
>>>>> 		all_counters_use_bpf =3D false;
>>>>>=20
>>>>> I was also thinking of oving it to evlist, but it's sat specific,
>>>>> so I think it's good as static.. thanks for changing the implementati=
on
>>>>=20
>>>> Hmm... then we need to somehow make all_counters_use_bpf visible in
>>>> bpf_counter.c, which won't be very clean. Also, since this is stat=20
>>>> specific, I guess it is better to keep it inside builtin-stat.c?
>>>> The runtime overhead should be minimal.=20
>>>=20
>>> ah it's different file :) then it's better as it is, sorry
>>=20
>> Is this a Reviewed-by?
>=20
> there's still the matter of disable callback:
>  https://lore.kernel.org/lkml/YH8Pw4m0w6DuuEXo@krava/
>=20
> it looks like now it could wrong value if we don't disable it

Sorry for the delay. I will add the disable part and send v5 soon.=20

Song

