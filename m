Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8769C453794
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 17:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhKPQgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 11:36:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232252AbhKPQgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:36:42 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AGFN2iL018922;
        Tue, 16 Nov 2021 16:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=XZA9CL4T6TMkUfExctQyfI55nNHfGj6b/hGL8hRVGDI=;
 b=pelsoCnr+2T2ws7Woz8CL2BWjBOGCGYc8QImkdGqPcKVHnbc6l0gNCvmhQ0tjwjXjvqv
 68BE5H5GWY45lP5YCrL8HJdC2pDJn8ZNfuqyMb7LR0dR3EGWTOI9322Iat5+mFQOqoyQ
 5qW1gZzoKBr0diAHH4V/BuUTt4nqqqDGEGxHINoS1da4l4WD3aICk0vEZYYOdjOpaapg
 QTD/nzHgOdTzRnKzjt4MvTj8wqH6PvB1xBvXr8XE4f6m8y1xKCqviVTSVqdunmkvq/lu
 vxolvUWisftCeeKWQ5LPbecrk/f6CJdA1xSRxf0dWGXis3n8tv+1tf5QPVgEVp6VMeS1 yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ccf841p2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 16:32:08 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AGFtRoV002764;
        Tue, 16 Nov 2021 16:32:06 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ccf841p15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 16:32:06 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AGGIilO021895;
        Tue, 16 Nov 2021 16:32:03 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3ca50a0rqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 16:32:03 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AGGW1Dg24838636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 16:32:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49C1F5204F;
        Tue, 16 Nov 2021 16:32:01 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.79.191.60])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 59A9052050;
        Tue, 16 Nov 2021 16:31:57 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC 3/3] perf tools: Fix p_stage_cyc sort key behavior
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20211105225617.151364-3-namhyung@kernel.org>
Date:   Tue, 16 Nov 2021 21:59:42 +0530
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5CF112C6-95B5-47C5-95B7-55129B5CB24B@linux.vnet.ibm.com>
References: <20211105225617.151364-1-namhyung@kernel.org>
 <20211105225617.151364-3-namhyung@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9ADHcUredu4kB_tNb61vqHppIGhrc-J3
X-Proofpoint-GUID: GUu-m_SHwBSIDLu7qjnuHXz96kbQtdXz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-16_03,2021-11-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111160081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 06-Nov-2021, at 4:26 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> Like weight and local_weight, the p_stage_cyc (for pipeline stage
> cycles) should be handled the same way.  Not sure it also needs
> the local and global variants.

Hi Namhyung,

Thanks for the fixes. I could test the fix for "weight" and "ins_lat" in =
powerpc.
Also it makes sense to have global variant for p_stage_cyc as well. =
Thanks for pointing that. I will post fix to have both the variants for =
the p_stage_cyc.

Thanks
Athira
>=20
> But I couldn't test it actually because I don't have the machine.
>=20
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> tools/perf/util/hist.c | 12 ++++--------
> tools/perf/util/sort.c |  4 ++--
> tools/perf/util/sort.h |  2 +-
> 3 files changed, 7 insertions(+), 11 deletions(-)
>=20
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 54fe97dd191c..b776465e04ef 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -289,12 +289,10 @@ static long hist_time(unsigned long htime)
> 	return htime;
> }
>=20
> -static void he_stat__add_period(struct he_stat *he_stat, u64 period,
> -				u64 p_stage_cyc)
> +static void he_stat__add_period(struct he_stat *he_stat, u64 period)
> {
> 	he_stat->period		+=3D period;
> 	he_stat->nr_events	+=3D 1;
> -	he_stat->p_stage_cyc	+=3D p_stage_cyc;
> }
>=20
> static void he_stat__add_stat(struct he_stat *dest, struct he_stat =
*src)
> @@ -305,7 +303,6 @@ static void he_stat__add_stat(struct he_stat =
*dest, struct he_stat *src)
> 	dest->period_guest_sys	+=3D src->period_guest_sys;
> 	dest->period_guest_us	+=3D src->period_guest_us;
> 	dest->nr_events		+=3D src->nr_events;
> -	dest->p_stage_cyc	+=3D src->p_stage_cyc;
> }
>=20
> static void he_stat__decay(struct he_stat *he_stat)
> @@ -593,7 +590,6 @@ static struct hist_entry =
*hists__findnew_entry(struct hists *hists,
> 	struct hist_entry *he;
> 	int64_t cmp;
> 	u64 period =3D entry->stat.period;
> -	u64 p_stage_cyc =3D entry->stat.p_stage_cyc;
> 	bool leftmost =3D true;
>=20
> 	p =3D &hists->entries_in->rb_root.rb_node;
> @@ -612,11 +608,11 @@ static struct hist_entry =
*hists__findnew_entry(struct hists *hists,
>=20
> 		if (!cmp) {
> 			if (sample_self) {
> -				he_stat__add_period(&he->stat, period, =
p_stage_cyc);
> +				he_stat__add_period(&he->stat, period);
> 				hist_entry__add_callchain_period(he, =
period);
> 			}
> 			if (symbol_conf.cumulate_callchain)
> -				he_stat__add_period(he->stat_acc, =
period, p_stage_cyc);
> +				he_stat__add_period(he->stat_acc, =
period);
>=20
> 			/*
> 			 * This mem info was allocated from =
sample__resolve_mem
> @@ -726,7 +722,6 @@ __hists__add_entry(struct hists *hists,
> 		.stat =3D {
> 			.nr_events =3D 1,
> 			.period	=3D sample->period,
> -			.p_stage_cyc =3D sample->p_stage_cyc,
> 		},
> 		.parent =3D sym_parent,
> 		.filtered =3D symbol__parent_filter(sym_parent) | =
al->filtered,
> @@ -741,6 +736,7 @@ __hists__add_entry(struct hists *hists,
> 		.time =3D hist_time(sample->time),
> 		.weight =3D sample->weight,
> 		.ins_lat =3D sample->ins_lat,
> +		.p_stage_cyc =3D sample->p_stage_cyc,
> 	}, *he =3D hists__findnew_entry(hists, &entry, al, sample_self);
>=20
> 	if (!hists->has_callchains && he && he->callchain_size !=3D 0)
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index adc0584695d6..a111065b484e 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -1394,13 +1394,13 @@ struct sort_entry sort_global_ins_lat =3D {
> static int64_t
> sort__global_p_stage_cyc_cmp(struct hist_entry *left, struct =
hist_entry *right)
> {
> -	return left->stat.p_stage_cyc - right->stat.p_stage_cyc;
> +	return left->p_stage_cyc - right->p_stage_cyc;
> }
>=20
> static int hist_entry__p_stage_cyc_snprintf(struct hist_entry *he, =
char *bf,
> 					size_t size, unsigned int width)
> {
> -	return repsep_snprintf(bf, size, "%-*u", width, =
he->stat.p_stage_cyc);
> +	return repsep_snprintf(bf, size, "%-*u", width, =
he->p_stage_cyc);
> }
>=20
> struct sort_entry sort_p_stage_cyc =3D {
> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> index 22ae7c6ae398..7b7145501933 100644
> --- a/tools/perf/util/sort.h
> +++ b/tools/perf/util/sort.h
> @@ -49,7 +49,6 @@ struct he_stat {
> 	u64			period_us;
> 	u64			period_guest_sys;
> 	u64			period_guest_us;
> -	u64			p_stage_cyc;
> 	u32			nr_events;
> };
>=20
> @@ -109,6 +108,7 @@ struct hist_entry {
> 	u64			code_page_size;
> 	u64			weight;
> 	u64			ins_lat;
> +	u64			p_stage_cyc;
> 	u8			cpumode;
> 	u8			depth;
>=20
> --=20
> 2.34.0.rc0.344.g81b53c2807-goog
>=20

