Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8F9429F40
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbhJLIF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:05:57 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:57034 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234867AbhJLIEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:04:48 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19C4UWes024001;
        Tue, 12 Oct 2021 01:01:51 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-0016f401.pphosted.com with ESMTP id 3bn3d58see-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 01:01:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KG4Fvvsvnb8fcMJQBVm7LpT6YPgo3AoKiSxTKzKprGZMwFpkZd92jgm3bTX3TVB9wrjAS6Xn8vCEecSdeyFZ6A2DYME+ON93HM+hHvd7LiiAky5lrbDeH+jTNgxeABdSxpwlNwgaVjyj+N9rpN/FiAFFgqI1hQcs2vO6WouenQ/sr6hsQrXm/4Qf2P7Ebf87abDDlaA2H3KyiSMBFKaLa1S+SCvlpL0j0oBz72elP3c9+0vNLXDpKqruOktBGIUioYwYOj74/YmSX9sVs3T41bpxjIBRfSwTPIkYdV7pRfk++RrTEtmBClo327wjKvCWdvz8eMJjjuxsOBNKXKJbrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QYMtwIdITUvQUlfsMzvOwEV6/V7N8VoCpsuvIThEmE=;
 b=K1yoC+o/AHRDPNhupyKigsmqtHAdKgLbOCic4mQ1Fe4j4mWeNMnX9uooXV5cwaVYBCsgH1y8lS44HLuknPzYXPn7ULk1HF6fk+eR4WHgnjJ8KhvOQdHYlQlKK1cDTZ4qbILYVfoL9sNB/fxek/5t9NLFpSVcoWS9TfcNzy6nczjUWIOCPAfh8sG0iiYyH/fIbpoyrHJUB/p6vFghbxI9KdEW0EukCvtyY+tghJYmDxGZkPRcKiJRt30SZU5lmxRuCmlJBPRmBpDfLyBbqmHJwSuA+Leityzr7PEiNiSCQGgiJ9Y0dbXIePrVhoUaeBJjbzlbFmdOxMV7d3tlUcsE6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QYMtwIdITUvQUlfsMzvOwEV6/V7N8VoCpsuvIThEmE=;
 b=CNV2O4yZqIxLY7sJ4sYO3SGGoIOlsKK1vu084sYZpgZp6XvsTpAlBibTVeczTfITRMy/Uxokq09uepJlAEJwRIDbZQGeXoqLTpH/Pi/+JQU7yBdJw/aERLfLCA/NO07gU8AsCYD91gIBtgsBUavFBRWvnxV4qGC79Iv9Ty3/Rqc=
Received: from CO6PR18MB4465.namprd18.prod.outlook.com (2603:10b6:303:13b::10)
 by CO1PR18MB4697.namprd18.prod.outlook.com (2603:10b6:303:e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Tue, 12 Oct
 2021 08:01:49 +0000
Received: from CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::9da7:4d20:98ff:e441]) by CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::9da7:4d20:98ff:e441%6]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 08:01:49 +0000
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     Bharat Bhushan <bbhushan2@marvell.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bhaskara Budiredla <bbudiredla@marvell.com>
Subject: RE: [PATCH v4 3/4] perf/marvell: cn10k DDR perfmon event overflow
 handling
Thread-Topic: [PATCH v4 3/4] perf/marvell: cn10k DDR perfmon event overflow
 handling
Thread-Index: AQHXrd2VR4ab2xjTt0KWsAYlbSj/lKvPIwag
Date:   Tue, 12 Oct 2021 08:01:49 +0000
Message-ID: <CO6PR18MB4465D37CFC942E0CD3C47A70E3B69@CO6PR18MB4465.namprd18.prod.outlook.com>
References: <20210920050823.10853-1-bbhushan2@marvell.com>
 <20210920050823.10853-4-bbhushan2@marvell.com>
In-Reply-To: <20210920050823.10853-4-bbhushan2@marvell.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1a57abd-c5e8-4b60-68c7-08d98d568b65
x-ms-traffictypediagnostic: CO1PR18MB4697:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR18MB46979BB5358A10E55C083B73E3B69@CO1PR18MB4697.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wvxtBwW5Vz8Dbq3H4IyDVH/AcmI+oMUhUyJDSFcmqI4A261Q7Mv3RqfqI5aePT44OWeABbQoYwDwtE5/tntHLL0dd0QoYH2kHBEREKpPx+5EnZh+LdhZI0WxGjRQ9K9mnJrV8lIZAuBBiS4WjnGQP+QzyeP9vcjD3i/ZpIlYtJiJkalk0Hpks2sE3OCU6q18crcgIFxbf+Kb12fAy/+VRIO3sy8A1cGQuFnxKukF8IJ8P0LwGj1knVPn6JBAgfTGG0L6xJ0wINfO/H39D1BzR/eWTeQKIDYfik4yF4AGgKxT4KUmKFmIgQG/plnPBaDPgUS9Is+7kyXU5kmprPLHRXwEgKK0VEYnByxo+zkTYgvqpXZvlgEr/rkLsdf6ZpSqzuWkIEqfjLffILGOU7j8q7CaBO98BdjmNVwu6IJC28gGcetVPNsC+PgiqWs9JabqgJLWWYn2wlfFS0HHqzSeeJZfl5XdDwrdfnoQYmSjeqGA68oZYeRtVkwW3ujGG7gW10hFay5AtWutXysis0hTMoLSqwjy7Yw6lKv5mTFPBjGv/3ivD0MwWKXsHQ2lwYPbDq1UQ3jzSQ7IyY8FxSTATCtJAL4HW8Yp+JJQoILQxWTnvm1EFgm/YB6A1OZhNQ9/mWAtUPGoRQ+xgEpkVFpOf4JEWpseM/eaw/pOwaK1if6g/XY3ZA1r9M2qp+i4CAm0YhOaO7787CXrpJODzgZAYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4465.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(83380400001)(66946007)(66476007)(66556008)(64756008)(66446008)(8676002)(71200400001)(186003)(2906002)(76116006)(508600001)(7696005)(52536014)(86362001)(316002)(5660300002)(38100700002)(55016002)(53546011)(6506007)(38070700005)(6636002)(26005)(33656002)(9686003)(110136005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JdVMO2uFe5AsKZBJrlVcRp1aiMbqKtUE85eT2c4mvM75vhCZIKifni0swdRN?=
 =?us-ascii?Q?24tkMoJVIXGC02mIwV9gEfbCkMtF6rVewdlVRJ9/oXJC395mXsgQJfa49Nct?=
 =?us-ascii?Q?fi0lAGzOot+1yBtHFriFo25qiUyx5hNR3m60Z+n4vm39pjhcAlyRUVyDa8wH?=
 =?us-ascii?Q?KXKA6gIYb99LhzgQsF6bV2jAWVMR9xSN7zv1ovCSijwOAcGH/alEJacrLs0Z?=
 =?us-ascii?Q?aWImmCYJh5IAmAMgJ04KLa+7Awi2kEWgt+TATeMOhZE82CSVDpeWJGtVNQDO?=
 =?us-ascii?Q?pDCJaBlnh8iA4JTJGNFkgT4vDaftXpvrKgBWbwSIWjiD1xo6rjp3QHHSv+l7?=
 =?us-ascii?Q?ZTEswzmEFcWA/AwUzBF7W0FGkwattinxq+BVgbPGZJCeq27x0hqleetkdDyL?=
 =?us-ascii?Q?jgu8YY40Lben/PlVThYoQqVGW1fFeQCDqD+xtefnusGHDo8SYfuUZ7Xl+ZI8?=
 =?us-ascii?Q?vdSP9xazb7LTEmYqInV/BhUSW16MBBPL2HqYnBkSISpD6CT1Myz/mbTHqwQr?=
 =?us-ascii?Q?A6JSY5i4zFnAUIOJJ0EmQPFinP391YDQqeaFDNKXr3NkmqxGQaf+5OXBE8YG?=
 =?us-ascii?Q?widH3afVr1znoONKMTLWP3zF2Trvs6xnjo+gRDlP1rZtYh6nDr1KNcBOIssb?=
 =?us-ascii?Q?BkmvnTlZ7Kl7up5rUoVlF+d8Sf1KCeyfAYTRLL5HwxAUl0zMxbPCajLzou21?=
 =?us-ascii?Q?qdgKQOAcMIPHUQsKo7GRY0x7VYhLrcSV2o9jymrEzBQ1lehheiHmVwjEYphT?=
 =?us-ascii?Q?ijzu4XkjPqTUcbuyzPbmgz0oezshURE76Y4VOpM6EocB0xtg1l6D4XXjHD4N?=
 =?us-ascii?Q?ECLR9VQ8g0faNh0a4QAqiHnZxLn07isNB8HVZ6Q9xvFUBusm/Xc62lnY/0hw?=
 =?us-ascii?Q?KlJDInKPnTa6or+0UAiaHv0sz7SR6cI9XzoPOP1o+1frMkXGp+2HhBL/CtHS?=
 =?us-ascii?Q?MBglJ6MX0B8oZKXIce8c3YSL4pLAgLFBUz2dy7Q8nghgqb+31yP3FbqOO1BL?=
 =?us-ascii?Q?Ny45eyGvTFbgZPyS0cJclwPhTedBdzCzBd/jJLRCa8+2BP3WqdUfMwjnSmQ9?=
 =?us-ascii?Q?2XtADHfhORydq8hZFXFeOj7/kYfX7i7BdR8SWjgUPqf+pbtHfu0rWFW5WeqP?=
 =?us-ascii?Q?/7FEGfS+qY5/49PaEEHxezP/bHq1ygQoGkyx4JTQdXec9X1+NC2lww9uNAqv?=
 =?us-ascii?Q?tuQpVMpQjWn5J2rfEG56X1l+ACTDDNjRot0anjupw+PZHyfOo5bL3nPgnHjY?=
 =?us-ascii?Q?wOuBHZ84tySnNToqAXVzzrhQpNcGAvxfl0hBK8ljXL/SqYrydQ1/UnjyhRLE?=
 =?us-ascii?Q?h3oL1cf/OtYI9exhslR2kE3k?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4465.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a57abd-c5e8-4b60-68c7-08d98d568b65
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 08:01:49.2778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XG0m+9g36OmiExxpZcpVyFUjNWiY/ZhHV5qrM89cc22+1TWLAvFuavUcYM70lufGI9o8K+IwBNkXBWGuJMbQQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4697
X-Proofpoint-ORIG-GUID: bLgi-t7BSzQdutL0H57GNFS2JReEIxoL
X-Proofpoint-GUID: bLgi-t7BSzQdutL0H57GNFS2JReEIxoL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_01,2021-10-11_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Bhaskara

> -----Original Message-----
> From: Bharat Bhushan <bbhushan2@marvell.com>
> Sent: Monday, September 20, 2021 10:38 AM
> To: will@kernel.org; mark.rutland@arm.com; robh+dt@kernel.org; linux-arm-
> kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Bharat Bhushan <bbhushan2@marvell.com>
> Subject: [PATCH v4 3/4] perf/marvell: cn10k DDR perfmon event overflow
> handling
>=20
> CN10k DSS h/w perfmon does not support event overflow interrupt, so perio=
dic
> timer is being used. Each event counter is 48bit, which in worst case sce=
nario can
> increment at maximum 5.6 GT/s. At this rate it may take many hours to ove=
rflow
> these counters. Therefore polling period for overflow is set to 100 sec, =
which can
> be changed using sysfs parameter.
>=20
> Two fixed event counters starts counting from zero on overflow, so overfl=
ow
> condition is when new count less than previous count. While eight
> programmable event counters freezes at maximum value. Also individual cou=
nter
> cannot be restarted, so need to restart all eight counters.
>=20
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
> v3->v4:
>  - No Change
>=20
> v2->v3:
>  - uintXX_t -> uXX
>=20
> v1->v2:
>  - No Change
>=20
>  drivers/perf/marvell_cn10k_ddr_pmu.c | 111 +++++++++++++++++++++++++++
>  1 file changed, 111 insertions(+)
>=20
> diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c
> b/drivers/perf/marvell_cn10k_ddr_pmu.c
> index 9b6d5e716b94..21fccb9090c5 100644
> --- a/drivers/perf/marvell_cn10k_ddr_pmu.c
> +++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
> @@ -11,6 +11,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
>  #include <linux/perf_event.h>
> +#include <linux/hrtimer.h>
>=20
>  /* Performance Counters Operating Mode Control Registers */
>  #define DDRC_PERF_CNT_OP_MODE_CTRL	0x8020
> @@ -127,6 +128,7 @@ struct cn10k_ddr_pmu {
>  	struct	device *dev;
>  	int active_events;
>  	struct perf_event *events[DDRC_PERF_NUM_COUNTERS];
> +	struct hrtimer hrtimer;
>  };
>=20
>  #define to_cn10k_ddr_pmu(p)	container_of(p, struct cn10k_ddr_pmu, pmu)
> @@ -251,6 +253,18 @@ static const struct attribute_group *cn10k_attr_grou=
ps[]
> =3D {
>  	NULL,
>  };
>=20
> +/* Default poll timeout is 100 sec, which is very sufficient for
> + * 48 bit counter incremented max at 5.6 GT/s, which may take many
> + * hours to overflow.
> + */
> +static unsigned long cn10k_ddr_pmu_poll_period_sec =3D 100;
> +module_param_named(poll_period_sec, cn10k_ddr_pmu_poll_period_sec,
> +ulong, 0644);
> +
> +static ktime_t cn10k_ddr_pmu_timer_period(void) {
> +	return ms_to_ktime((u64)cn10k_ddr_pmu_poll_period_sec *
> USEC_PER_SEC);
> +}
> +
>  static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap)  {
>  	switch (eventid) {
> @@ -433,6 +447,10 @@ static int cn10k_ddr_perf_event_add(struct perf_even=
t
> *event, int flags)
>  	pmu->active_events++;
>  	hwc->idx =3D counter;
>=20
> +	if (pmu->active_events =3D=3D 1)
> +		hrtimer_start(&pmu->hrtimer, cn10k_ddr_pmu_timer_period(),
> +			      HRTIMER_MODE_REL_PINNED);
> +
>  	if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
>  		/* Generic counters, configure event id */
>  		reg_offset =3D DDRC_PERF_CFG(counter);
> @@ -484,6 +502,10 @@ static void cn10k_ddr_perf_event_del(struct perf_eve=
nt
> *event, int flags)
>  	cn10k_ddr_perf_free_counter(pmu, counter);
>  	pmu->active_events--;
>  	hwc->idx =3D -1;
> +
> +	/* Cancel timer when no events to capture */
> +	if (pmu->active_events =3D=3D 0)
> +		hrtimer_cancel(&pmu->hrtimer);
>  }
>=20
>  static void cn10k_ddr_perf_pmu_enable(struct pmu *pmu) @@ -502,6 +524,92
> @@ static void cn10k_ddr_perf_pmu_disable(struct pmu *pmu)
>  		       DDRC_PERF_CNT_END_OP_CTRL);
>  }
>=20
> +static void cn10k_ddr_perf_event_update_all(struct cn10k_ddr_pmu *pmu)
> +{
> +	struct hw_perf_event *hwc;
> +	int i;
> +
> +	for (i =3D 0; i < DDRC_PERF_NUM_GEN_COUNTERS; i++) {
> +		if (pmu->events[i] =3D=3D NULL)
> +			continue;
> +
> +		cn10k_ddr_perf_event_update(pmu->events[i]);
> +	}
> +
> +	/* Reset previous count as h/w counter are reset */
> +	for (i =3D 0; i < DDRC_PERF_NUM_GEN_COUNTERS; i++) {
> +		if (pmu->events[i] =3D=3D NULL)
> +			continue;
> +
> +		hwc =3D &pmu->events[i]->hw;
> +		local64_set(&hwc->prev_count, 0);
> +	}
> +}
> +
> +static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu
> +*pmu) {
> +	struct perf_event *event;
> +	struct hw_perf_event *hwc;
> +	u64 prev_count, new_count;
> +	u64 value;
> +	int i;
> +
> +	event =3D pmu->events[DDRC_PERF_READ_COUNTER_IDX];
> +	if (event) {
> +		hwc =3D &event->hw;
> +		prev_count =3D local64_read(&hwc->prev_count);
> +		new_count =3D cn10k_ddr_perf_read_counter(pmu, hwc->idx);
> +
> +		/* Overflow condition is when new count less than
> +		 * previous count
> +		 */
> +		if (new_count < prev_count)
> +			cn10k_ddr_perf_event_update(event);
> +	}
> +
> +	event =3D pmu->events[DDRC_PERF_WRITE_COUNTER_IDX];
> +	if (event) {
> +		hwc =3D &event->hw;
> +		prev_count =3D local64_read(&hwc->prev_count);
> +		new_count =3D cn10k_ddr_perf_read_counter(pmu, hwc->idx);
> +
> +		/* Overflow condition is when new count less than
> +		 * previous count
> +		 */
> +		if (new_count < prev_count)
> +			cn10k_ddr_perf_event_update(event);
> +	}
> +
> +	for (i =3D 0; i < DDRC_PERF_NUM_GEN_COUNTERS; i++) {
> +		if (pmu->events[i] =3D=3D NULL)
> +			continue;
> +
> +		value =3D cn10k_ddr_perf_read_counter(pmu, i);
> +		if (value =3D=3D DDRC_PERF_CNT_MAX_VALUE) {
> +			pr_info("Counter-(%d) reached max value\n", i);
> +			cn10k_ddr_perf_event_update_all(pmu);
> +			cn10k_ddr_perf_pmu_disable(&pmu->pmu);
> +			cn10k_ddr_perf_pmu_enable(&pmu->pmu);
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static enum hrtimer_restart cn10k_ddr_pmu_timer_handler(struct hrtimer
> +*hrtimer) {
> +	struct cn10k_ddr_pmu *pmu =3D container_of(hrtimer, struct
> cn10k_ddr_pmu,
> +						 hrtimer);
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	cn10k_ddr_pmu_overflow_handler(pmu);
> +	local_irq_restore(flags);
> +
> +	hrtimer_forward_now(hrtimer, cn10k_ddr_pmu_timer_period());
> +	return HRTIMER_RESTART;
> +}
> +
>  static int cn10k_ddr_perf_probe(struct platform_device *pdev)  {
>  	struct cn10k_ddr_pmu *ddr_pmu;
> @@ -550,6 +658,9 @@ static int cn10k_ddr_perf_probe(struct platform_devic=
e
> *pdev)
>  	if (!name)
>  		return -ENOMEM;
>=20
> +	hrtimer_init(&ddr_pmu->hrtimer, CLOCK_MONOTONIC,
> HRTIMER_MODE_REL);
> +	ddr_pmu->hrtimer.function =3D cn10k_ddr_pmu_timer_handler;
> +
>  	ret =3D perf_pmu_register(&ddr_pmu->pmu, name, -1);
>  	if (ret)
>  		return ret;
> --
> 2.17.1

