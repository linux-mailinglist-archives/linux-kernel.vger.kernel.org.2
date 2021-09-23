Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805C7415862
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 08:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239438AbhIWGoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 02:44:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47828 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239370AbhIWGoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 02:44:10 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18N42NSc016200
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 23:42:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=TJjc9gPAKr214+CkxVKwmePf+TDHCNZUwWZUxpdfyT0=;
 b=Tut2qKJ3FPG+r8KwqQCwAWmAZl8VC+oc0mj9BZCKdNJ/xJBHfS1qVxE9Zw0/gjdxQ9mx
 Y3xg8QpGznNvIZx23dYayHh4l++Q5XGjD+Enk9/Hs1t6nikYYJyBxFC/w0K7EdiGqSnK
 c6SCcT7KkoRveETcs9kj3V8KtFEFqY0TlSE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3b8j6x0nsn-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 23:42:39 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 22 Sep 2021 23:42:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZxGHiAtixYTx61+MAHu+yA8jq/B45J41QR2fy4NzLykF5LxynzWltL6idHtvx5b5K6As13WCSq6nwcqkSEwQUY0Gi+Wlzwx/Ap5+TnJvFcEO8QXalyp823IUkaT2cBzrBuRIc8ntIkb63gmObd0yKiJJgIcySFYGe0Ka/4XQysP5W5IqPuueaVgY9qzhu5k8drBlbJ1MRNM0fUFy5cvYtl7L1Zv3UufNwkXvj4J3wr9gG4t2TxhG71E/4Jafy2bNpls1fhSDbw6gtihQrIYxHvcMbFF230VDsURRQDPOMqsCTiKzv2SyOz3eZPtZ7wHppBnlJkjTu6BH9EiCz2gbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TJjc9gPAKr214+CkxVKwmePf+TDHCNZUwWZUxpdfyT0=;
 b=AgMQJd5fP3aeWZWi7596k1LC0WIetdSSNqGUbMkmg5IqayicniRoNtWPb2Cb5C1zgMYM/iLu3n4ifAMDnmPsK6an9YD8/xoSIV6a0ZI6s3Lg0gPxsp/+zvbRoCAdm3+UNj+dGT9sBPCO2pm/ZoZmqNYNyrmC3WC58Oi4ReRGDXEysCGJsp46CXMWIPDkdROKCAb+OCsDqFRnONS/GC9a9QZuVKWCCIaqWsdgL4qoqYPDTfDFIQdEcLrlhn36qMbf2o4UmPb26OuSYv6EHqqw6ab3rhNYjZQnY4l0mxxOZzw7rngqcZBLicsuLypIKPrqw8YQ3GNgUudjeIYHKGNE4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5078.namprd15.prod.outlook.com (2603:10b6:806:1dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 06:42:35 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%8]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 06:42:35 +0000
From:   Song Liu <songliubraving@fb.com>
To:     open list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kernel Team <Kernel-team@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Lucian Grijincu <lucian@fb.com>
Subject: Re: [PATCH] perf/core: fix userpage->time_enabled of inactive events
Thread-Topic: [PATCH] perf/core: fix userpage->time_enabled of inactive events
Thread-Index: AQHXr0+haQJZyLrcUUCZvKZzjJ4lwquxLcEA
Date:   Thu, 23 Sep 2021 06:42:35 +0000
Message-ID: <7530C81E-594D-49AD-9E14-D3B2A338A704@fb.com>
References: <20210922011715.4154119-1-songliubraving@fb.com>
In-Reply-To: <20210922011715.4154119-1-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8ee478b-a5a6-4472-3565-08d97e5d5412
x-ms-traffictypediagnostic: SA1PR15MB5078:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB5078761C8D9B27C805C68471B3A39@SA1PR15MB5078.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xmCr2tu4fHJgEeWOSwhvROzsqAWSK00WwdaX0BKQbPK0ei5OzED8fvZTzDFLX6c3qLsrs2B4wK78QtlBqToI7G1/KuO8nUSVTL+LQaitQf01Y5ad0rWhrvfKuxkZttmGksNRJdj7lS0aFIrYjEyJ7PeMJS4dgio9fI8OIv/APBJvWD7PLZccEd3GT58bnK39S7gqU0pYo7ysdRatnDK2SqhfoMlFjC08uIOi1hwPW6CX6pM+2uA9M6nJ1dIrOnQhPT/a4z2j/QH61YCi51Eb70ZpiwNCkDkX5tWvYZvBKjrZgcneslKY895/QyVtaQemiGp4f+NxKHve6SRT3lE6DVRnzA39vbT47dqAS1ukGmyxBa98daOc93bFAGNipJZA5M2Hya0fowCaUAx59fT5z9wQhWFF/+L0f1wWbpjIgWRvk8McwCdHnkhDJ9Qwz2OmCSGiGU/sLQqd+aVbzx6m2tLDHaPixzeuNLMCYQHqPm3d39KtV4tZjZwyfFTXXqS+6ExoI3Pgwy7C2utnniRfbnCKEXBVcZi5J2svevXnjS/DQvB7/hUmE4NUZUzG+WkpwAGRHqYtC3DCZ3pBTMACPyJRAodFpQ8cWpMTS3ZX/sqsf80QG2rxZD9IbQ4hx2zvCkbEWKs19DZCJnXiCVmyJvpk7PGclPHgsLmIXOm1Tv5KYMMqKaZivnwizEUOJCtvzTerO6GSJT/bPfwZM0IYAIfXf2EycnKFKBZEskas5I0Tgb3MQp+8OIZr52cph2P+bN8a23LfEaKk7Cg5fj2JMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(53546011)(71200400001)(4326008)(6506007)(6486002)(186003)(6512007)(76116006)(110136005)(54906003)(8676002)(508600001)(8936002)(2616005)(5660300002)(38100700002)(64756008)(38070700005)(86362001)(66556008)(66446008)(66476007)(66946007)(316002)(122000001)(36756003)(33656002)(91956017)(83380400001)(21314003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yNpF+OUDFHk9/d6vz9HeQOwxqPCKO5vJdkb24bDNTLHP5B391tD61XJj9kgN?=
 =?us-ascii?Q?GdXjj36V/DE7aa5kC53Wz16tk3dMR9ixieKC+F67m/boaQafrWJpfeO1yWcE?=
 =?us-ascii?Q?ORkUgLvpBXVEhXx4Gg8PK8+0LsivcRubh/vGCPbSZwnFJA4tCTRHy2W4nZuA?=
 =?us-ascii?Q?gp+ZvJ0MsGehAmluHXC1D6aREzgT+rgpau5MGufPm/dDyu8bt01bziz+l4PI?=
 =?us-ascii?Q?DEMETYc87zGdP3kFiyvKI8ac1AbfynRQP7KOuD8MqFaQRySapwQIVZbMh6ug?=
 =?us-ascii?Q?ykkj7WMyeQrZX+2VpEkp3hgl6D0wJyQeFTsVVkhuJEwnyoawovbdGYw+Mw/R?=
 =?us-ascii?Q?mDB4nJ2mQrs72N81WcojHmHnaiJR/YUOVB1c8KzXjKckXfmA7DvbfeJ59ikx?=
 =?us-ascii?Q?3mvk9071kMrEBWgwpxGHwha7fC6vMFZvywq6OmduUAFMRG5TJDo9CyxWPKU4?=
 =?us-ascii?Q?22t9Pk29JMAT4qvt+HX63d1xsyVFkjZNs5nDXNZjc7rxFcN9mza/ugoP2ccz?=
 =?us-ascii?Q?yK76SQtUTgm82h5LncUhweerqpO4zAIrtNA9CO0TuccCSmJ4qF5e3lEdW9Co?=
 =?us-ascii?Q?4NZmZd5Cmq3ywE76l4e6SedVBnUIPHP0Scdb8srDwvN76FFKc1yzfB7FzV72?=
 =?us-ascii?Q?VJ1qGRdB02CCsJUii3fsTlcEMWwVp++r9ziBUa7b1ATvByB2NC0FwSrdSVPU?=
 =?us-ascii?Q?fsbv6Exh0eBElcK0spaqNfg1zP9arZ2evbteuIUd5Hm/901THSHzAmRozvvu?=
 =?us-ascii?Q?KhhRg7q+aaskFe6LXW2Cm7rS1Qwi8MHeIRmCAIp9QBNQptIFJDSj6MSFhIaK?=
 =?us-ascii?Q?22rh+Fk92iiWWxscTowQ6B35E2rLKzRPutuTTP1DwFcdhYz+rZFKJ5A4xs6k?=
 =?us-ascii?Q?7GOlQeI2FoZcTZfV2FTfyAb8iddgOmyKyvIY+xUoxj8zWEFzOO2+jkoUATHe?=
 =?us-ascii?Q?x357wU5IRvNTve02hP9JnvfIRwNnsYCFVT4AOURP5Jvdc8j0d/WTP4Z6w/W6?=
 =?us-ascii?Q?G66f1fJzTHE7YV8jDeqCJaUvg8q3Z67iID699SuvdDgmKt+ztf3BcIrXLR0U?=
 =?us-ascii?Q?mZV598z3iFxgXblSSHV/NB5IDc9TTIplx4dCBw5gE9bPEA0ea9Ps1QJU+wfQ?=
 =?us-ascii?Q?C3uTWVPhRLnqLd1CvqPpP+RMuXbuRt9B97AoMqZ4AEu+z/YffKueW37D75jY?=
 =?us-ascii?Q?ehUTqckGMeH03xpl+rC49ntRVAO7i1b5oYjzFV3gun1zJp8TKYrKBGE+tHmQ?=
 =?us-ascii?Q?U77aaFt76oGbTLKOuu/xF8bhmuq4rMRohPARokQh+adrR9d2dLt4lKl5glrc?=
 =?us-ascii?Q?m/LMhhFeZPjJ8gQQhgEuNIkD+XjoJEyj6Jk1F40H4XCOYBgWzf9gJMubk2/d?=
 =?us-ascii?Q?H5jO2CA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D62337FFCC087F459DCE056EA2E2FBC8@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ee478b-a5a6-4472-3565-08d97e5d5412
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 06:42:35.5879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: APQvwHKZ6nToVcU6humOeevpGZfAGFHJWHWdc8i9f3fwLQsFlfBrrZoFFUNLTpNW1aFwfK+1lB7Fu1AAMqUiJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5078
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: qPr6uXgWpRtPEYnkq-QT8zaUcFwzTAcg
X-Proofpoint-ORIG-GUID: qPr6uXgWpRtPEYnkq-QT8zaUcFwzTAcg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-23_02,2021-09-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109230040
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, 

> On Sep 21, 2021, at 6:17 PM, Song Liu <songliubraving@fb.com> wrote:
> 
> Users of rdpmc rely on the mmapped user page to calculate accurate
> time_enabled. Currently, userpage->time_enabled is only updated when the
> event is added to the pmu. As a result, inactive event (due to counter
> multiplexing) does not have accurate userpage->time_enabled. This can
> be reproduced with something like:
> 
>   /* open 20 task perf_event "cycles", to create multiplexing */
> 
>   fd = perf_event_open();  /* open task perf_event "cycles" */
>   userpage = mmap(fd);     /* use mmap and rdmpc */
> 
>   while (true) {
>     time_enabled_mmap = xxx; /* use logic in perf_event_mmap_page */
>     time_enabled_read = read(fd).time_enabled;
>     if (time_enabled_mmap > time_enabled_read)
>         BUG();
>   }
> 
> Fix this by updating userpage for inactive events in ctx_sched_in.
> 
> Reported-and-tested-by: Lucian Grijincu <lucian@fb.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Could you please share your thoughts on this? It works well in our 
tests, but we would like to know your opinion before shipping it to
production. 

Thanks,
Song


> ---
> include/linux/perf_event.h |  4 +++-
> kernel/events/core.c       | 26 ++++++++++++++++++++++++++
> 2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 2d510ad750edc..4aa52f7a48c16 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -683,7 +683,9 @@ struct perf_event {
> 	/*
> 	 * timestamp shadows the actual context timing but it can
> 	 * be safely used in NMI interrupt context. It reflects the
> -	 * context time as it was when the event was last scheduled in.
> +	 * context time as it was when the event was last scheduled in,
> +	 * or when ctx_sched_in failed to schedule the event because we
> +	 * run out of PMC.
> 	 *
> 	 * ctx_time already accounts for ctx->timestamp. Therefore to
> 	 * compute ctx_time for a sample, simply add perf_clock().
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 1cb1f9b8392e2..549ce22df7bc7 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3766,6 +3766,15 @@ ctx_flexible_sched_in(struct perf_event_context *ctx,
> 			   merge_sched_in, &can_add_hw);
> }
> 
> +static inline void
> +perf_event_update_inactive_userpage(struct perf_event *event,
> +				    struct perf_event_context *ctx)
> +{
> +	perf_event_update_time(event);
> +	perf_set_shadow_time(event, ctx);
> +	perf_event_update_userpage(event);
> +}
> +
> static void
> ctx_sched_in(struct perf_event_context *ctx,
> 	     struct perf_cpu_context *cpuctx,
> @@ -3807,6 +3816,23 @@ ctx_sched_in(struct perf_event_context *ctx,
> 	/* Then walk through the lower prio flexible groups */
> 	if (is_active & EVENT_FLEXIBLE)
> 		ctx_flexible_sched_in(ctx, cpuctx);
> +
> +	/*
> +	 * Update userpage for inactive events. This is needed for accurate
> +	 * time_enabled.
> +	 */
> +	if (unlikely(ctx->rotate_necessary)) {
> +		struct perf_event *event;
> +
> +		perf_event_groups_for_each(event, &ctx->pinned_groups) {
> +			if (event->state == PERF_EVENT_STATE_INACTIVE)
> +				perf_event_update_inactive_userpage(event, ctx);
> +		}
> +		perf_event_groups_for_each(event, &ctx->flexible_groups) {
> +			if (event->state == PERF_EVENT_STATE_INACTIVE)
> +				perf_event_update_inactive_userpage(event, ctx);
> +		}
> +	}
> }
> 
> static void cpu_ctx_sched_in(struct perf_cpu_context *cpuctx,
> -- 
> 2.30.2
> 

