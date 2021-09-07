Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E40402208
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 04:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhIGBad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 21:30:33 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:6300 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229797AbhIGBab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 21:30:31 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1871Pl3i007199;
        Tue, 7 Sep 2021 01:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=6Sufh9Odvg8lk4FuXU0dHP5GeybGC/SQkr+6ykPz4h0=;
 b=UMEU/e1F/TInpv0hdbYCNI3qjuwcuAvs3eSTQus0eD09jdiQcyl+nhIYyAkCS8YxdjRp
 80sC8n9LxIFyTat550DtPfkmW0j07dDyfJb2ZB/JXpBOxExup4Lh3U4gKSNM8sSyQsUA
 n2i2HRf+G7zDBKZEyQveQ7LTw5WjJlj06d03bUJ3B4Z0ODCqnktdxrwHYlLPpULtPU64
 /evL2fZo/QWmOg1JGYY0SmCUsY5u/lUFpV6dv/tQEkdB5Zl09J/8BeOTe34GQ/WhsBcJ
 7ZZ2LkOQ4/tNAiR14ArpKi6v4idyffqqx/7h4AdP7vj5OAUWshmYu+wPacZFYGsJusqw ww== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-0064b401.pphosted.com with ESMTP id 3awsacr4q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Sep 2021 01:29:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q32DcjQX2iU7evVGsXej/Zd7SfuwYFRz5C1yY+RDS3GH6KNAwpqXj37sHbUf82GL8ASGp4iXkiaspp8e/1yIlGo//oJpLCxdXadU86rSxcTg5LW4NTPT/fPdVfKkKQ5fX7CCp7LNjcDpmqq3JtJD3rYqp1xSQbQvH5mxjBBSaCT0LvA+HZnmSoQQqvxlMjDMY7HPUpXhFrkDh4ux1YzCFpp302jvyZpa/P8yQwKnxteHqEGPUfTyX/PvFk9S86pb6faCDusKmnylpVO8nsKZaDg/DhU76OwJct6QO6sch5Hpcg3ByJR0LqfA5sp+WIkF56o6EZJ/EdITE6ulnUrjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6Sufh9Odvg8lk4FuXU0dHP5GeybGC/SQkr+6ykPz4h0=;
 b=lKTamaAXEVmdaKrLzD1LW23yNEeqJrhgD14D8zZEUmF6GUGXylgcPXrT9qCSz8cXQHFMY11NM3jHNOQYNHGzC1haPiBROZs4BgqMGGO4L5Vl1F4gitEqgpU1TGojFcTJkc2Hk6xDpz2L1DGuZpUYId+xJ4ClX8wWom1PEFJU6VEflbzoLIYgBnWhq1zB9yQlBlCmJNP/6xXLI2kBVF6GiXZYNN/emQW78o53/PyABTwDu4WEa00fxU9dunfQD/Q4wtawra70/da8TuDJOD0TgbwzMPpjXdo5RRux7HIDkDzV/ZsQUWiusKKhEVAkaKuonwodYpID3ec4nPfSMpDEJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BL1PR11MB5478.namprd11.prod.outlook.com (2603:10b6:208:31d::12)
 by MN2PR11MB4677.namprd11.prod.outlook.com (2603:10b6:208:24e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 01:29:03 +0000
Received: from BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::19db:ee0e:abd0:df6d]) by BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::19db:ee0e:abd0:df6d%8]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 01:29:03 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "bristot@redhat.com" <bristot@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bristot@kernel.org" <bristot@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] trace/osnoise: Fix missed cpus_read_unlock() in
 start_per_cpu_kthreads()
Thread-Topic: [PATCH v2] trace/osnoise: Fix missed cpus_read_unlock() in
 start_per_cpu_kthreads()
Thread-Index: AQHXng/wEiXsIqQmAkaGQHjRJAFSz6uX0ppJ
Date:   Tue, 7 Sep 2021 01:29:03 +0000
Message-ID: <BL1PR11MB54789CFD3274682522619BE0FFD39@BL1PR11MB5478.namprd11.prod.outlook.com>
References: <20210831022919.27630-1-qiang.zhang@windriver.com>
In-Reply-To: <20210831022919.27630-1-qiang.zhang@windriver.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=windriver.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: debdcfed-70a1-481b-37f4-08d9719ee089
x-ms-traffictypediagnostic: MN2PR11MB4677:
x-microsoft-antispam-prvs: <MN2PR11MB46771EB3A69D697E9849AE5BFFD39@MN2PR11MB4677.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Ehzc299FH1T9+ugMLl95jBhaRZy4l0UCfIjOw8LraM1xKUZGgV11nMg/30tUFjB2IX4JkIoEJ0b6BiD4+wAcCE5Mkd0HMohVyos3iZQiSrTXM4lAxnF2qEwgYCPzypLpyQbOSHGoj5dOyQByi1b9AbxByBCHjsZYwCk8MEKh3Bd+tnr5ahqSKx9t1zu5fReLYq23ycojA+nrukbnAfMygTrbXU/RI5irST3bLbXPtSwTW6UOAiNEaGSczaeDg/v0ZrDjuWz4gIaTQuHvcY891Bww5M0C5esl+3FA/jWKysg63zOcRJM7Vpupa6cHndh8gnK8Ns3boDFAXTHroIVRDNKduKwJJ8usvjyg/DIegldLMVOiLNMK2xdr4rjxGJUQTp5Pr52EPcSjQeCm7pGS60/i0pasJo7YsI/4SN//vhTNPY7kMWJu89trbp17q9PRbX8My4NoepOSqkOrtBjh84/HKSgFWpOV2GFl2NSGELclzk7NnNCUQ5Y+5UZvdDi8OPo1nw+iu56JP2T+XiOT7UZJvAMauQk+QsYy5PqiYAd3g5Ry7i5e4OPzOBzgQlnVY60VWyEC/8qchFl4sNq42dMUFzAUclYlEEzbnhtGQ6XjKh2ncQ95BWvGTTl4WCoER+fDUdQOIbnpDZyGkgTeODipb/Mt9b8mRd+p9jNkuOd6Q46+McJjNZrbzI/QIVLp4bENutvEfEzo7GwTPUwug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39850400004)(53546011)(9686003)(55016002)(5660300002)(33656002)(71200400001)(8936002)(6506007)(52536014)(91956017)(76116006)(38100700002)(2906002)(8676002)(7696005)(26005)(38070700005)(186003)(478600001)(83380400001)(66946007)(4326008)(66446008)(122000001)(64756008)(66476007)(66556008)(86362001)(316002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RsWUTGcB3uB6CIx/4fpoGeCAUt/EKcGxtTl+kkqMq9i7vCZmr3g2bG+PV3RX?=
 =?us-ascii?Q?ap74dvhJQcswbKzK83Um10ymgn1w33T1n46dc0GvClAA5TMdMHLBBvCmw/Dj?=
 =?us-ascii?Q?1IKSPiaTmtMMCjYCSO9/MTJ1Q2kmfbZm9vHHn0GJo3wNdrpNq28xwqcWRoIs?=
 =?us-ascii?Q?r0O/IKZBODVRI2CK85XhJfOm1x/XCCqeO4A4+ZmiEkyHqTTmUksfTpQEeGym?=
 =?us-ascii?Q?gKRNvLuVlVKAeCBwoSR6YNNvCQuKkun5ClhGTEgCQf2pLZXRYAb2eDq0M92q?=
 =?us-ascii?Q?0TDd4DsJgZdNNPH8zjjHBEvUNL2czzujnvqdoR1mlTjTndaVORkW7xTp8Il5?=
 =?us-ascii?Q?2SugF4I9zbR4+blWa9/RhAE7cjKm+3/DxxN1plGA/8YrwU32K4Y+PFz3EwsT?=
 =?us-ascii?Q?TFSNxsxL8+U2qClN0g8SbztlZ71zdL/Edn94GEVOanOvwMS/YJXNE/lSSy2v?=
 =?us-ascii?Q?zQYA4tMWPQmh5ADqHXphd5V97I2QD11uUmQ6NeckCNNP+3PImUKFx9aLJrP9?=
 =?us-ascii?Q?+LcV2GAORt7rB8lkHI0B1l1DDOdKj7PHjEgdqRhnq+rRgPdZo3F+tuCuz7sa?=
 =?us-ascii?Q?tQ79wVnNBd/O2aOtJG2lQGPGgk714uUCMRul8KX+FrDBpp2k2E24fcjscKaT?=
 =?us-ascii?Q?oQZHJ3g4iFoqAwF2gghSlYII9towGxlH0FMd4dS/6uezNC7dirxwCuLou6zv?=
 =?us-ascii?Q?+CBQxZLk/7dJGO4jilzHxRRFi5oKs/RE1knpdPRT6ulRWeNWpDJy5mtZzwAr?=
 =?us-ascii?Q?UW8/N3bjG/dSWq7v6FiI4SjPObvm9qaLNd/sib4F67y35iElTWNXexMrb3za?=
 =?us-ascii?Q?H/pIeZLjwwx6GHfAJt9C4ecKDsySNnevjjBjWFft+mdqJJ8ygEwNQJs4c1yV?=
 =?us-ascii?Q?aOKiEU5659k2+6uW80TXYJvCkN1IBUdCdOvzUssssmYtJXH7wvFSPphb5IYq?=
 =?us-ascii?Q?ltPcgDBsDgxzA5ruVK6xzMeXCrV4frJ3NtQui2/AfcK9sttCqtg13h7o4ZaY?=
 =?us-ascii?Q?uRlHdBXsKvLqmPfBwuXTGv1SptItGWMJlkd3bGFXILnvcg1GbTlKEW0yGNnD?=
 =?us-ascii?Q?wLVNQRlc/DPcMzt1eUpGZ0O9+xh4t8JT8kyBq164hIPLqt2GhEvlrJ1S6lIT?=
 =?us-ascii?Q?heZ1yjVBDDrtxg4nD2u5yvzHHq/3I/saO6dHGicSiwQEObDIxVTSKRtWEhEb?=
 =?us-ascii?Q?pCblHOW2SYaI9CYwpQ/eJGpSyn7GZZ27Mkky5Td5twRgD1gMFdjQIgzgxpTN?=
 =?us-ascii?Q?DG9G7pHmOY4ZY++heYrllbrxNhbvFwAPcS8vZ2pD2omxVxGnPGVKKNqn6nBF?=
 =?us-ascii?Q?ZVU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debdcfed-70a1-481b-37f4-08d9719ee089
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 01:29:03.3963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P2s9FuWhMGTI44FqBkG3JLA3UgHgdJy/TdL418QU1uQqf+5AiwEHWrC5s2GQp77OUcDkYYn0wgfHEJcqttUuEEoE0K3Av1APpr/W5EZGpHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4677
X-Proofpoint-GUID: DpjnNif-M8MVbjfrbQ33IhCG_L2RLZmY
X-Proofpoint-ORIG-GUID: DpjnNif-M8MVbjfrbQ33IhCG_L2RLZmY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-06_10,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109070006
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  Daniel=0A=
=0A=
Do you have time to review this modification?=0A=
=0A=
Thanks=0A=
Qiang.zhang =0A=
=0A=
________________________________________=0A=
From: Zhang, Qiang <qiang.zhang@windriver.com>=0A=
Sent: Tuesday, 31 August 2021 10:28=0A=
To: bristot@redhat.com; rostedt@goodmis.org; bristot@kernel.org; mingo@redh=
at.com=0A=
Cc: linux-kernel@vger.kernel.org=0A=
Subject: [PATCH v2] trace/osnoise: Fix missed cpus_read_unlock() in start_p=
er_cpu_kthreads()=0A=
=0A=
From: "Qiang.Zhang" <qiang.zhang@windriver.com>=0A=
=0A=
When start_kthread() return error, the cpus_read_unlock() need=0A=
to be called.=0A=
=0A=
Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")=0A=
Cc: <stable@vger.kernel.org> # v5.14+=0A=
Signed-off-by: Qiang.Zhang <qiang.zhang@windriver.com>=0A=
---=0A=
 v1->v2:=0A=
 Modify submission information and code style, add tags.=0A=
=0A=
 kernel/trace/trace_osnoise.c | 6 +++---=0A=
 1 file changed, 3 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c=0A=
index 65b08b8e5bf8..ce053619f289 100644=0A=
--- a/kernel/trace/trace_osnoise.c=0A=
+++ b/kernel/trace/trace_osnoise.c=0A=
@@ -1548,7 +1548,7 @@ static int start_kthread(unsigned int cpu)=0A=
 static int start_per_cpu_kthreads(struct trace_array *tr)=0A=
 {=0A=
        struct cpumask *current_mask =3D &save_cpumask;=0A=
-       int retval;=0A=
+       int retval =3D 0;=0A=
        int cpu;=0A=
=0A=
        cpus_read_lock();=0A=
@@ -1568,13 +1568,13 @@ static int start_per_cpu_kthreads(struct trace_arra=
y *tr)=0A=
                retval =3D start_kthread(cpu);=0A=
                if (retval) {=0A=
                        stop_per_cpu_kthreads();=0A=
-                       return retval;=0A=
+                       break;=0A=
                }=0A=
        }=0A=
=0A=
        cpus_read_unlock();=0A=
=0A=
-       return 0;=0A=
+       return retval;=0A=
 }=0A=
=0A=
 #ifdef CONFIG_HOTPLUG_CPU=0A=
--=0A=
2.17.1=0A=
=0A=
