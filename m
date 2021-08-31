Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F9D3FC090
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 03:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239312AbhHaBs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 21:48:28 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:63376 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235217AbhHaBsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 21:48:25 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17V1j2mk004549;
        Mon, 30 Aug 2021 18:47:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=5C76N19jQ+vJMhB5VOG3h8yrZFBYKxMRAOD9h6iFvME=;
 b=E7uSfAhtFtRoSrp/jLHapWJ9BtAuhYhp30tVlfF+DIj9SF3PAJqdv2fOgREFcmZAI2HG
 W9Hdm+WBUL6N6T+byIm1bpRdHMvZAP0ut0eEfk8QC/gHXWz1A2Gpvhmc9+jU5LToeLBz
 QnGsp79IiYXqJQoPlTk6nc3yCIcoj+V4nvxBm8rl2fFeiq3sCBW46uHGPWUcfUKK1gya
 B74U61FhDaa4F1pfpIDfY7NI7UVNfrXBLq7zWz+1plt4LXW11PVx0+h6V0y6cW+WzVrr
 K4HXvoVW+qlJpu2B7ReerLFXE5K6w0QLYoL23db8S2cIhKKq695YcnbVE/yAQdAwBkbN Vg== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2046.outbound.protection.outlook.com [104.47.74.46])
        by mx0a-0064b401.pphosted.com with ESMTP id 3as5qr06fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Aug 2021 18:47:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nL+wsRAvhrBbgUZxW6GYcO6LIiCMlnIz97PCcvBfhfTvJIWXY6CdCEN9kpoqDP6PKXOAsS4qBZvw2K841CV6tziOSafNThccz0WHAzp2hefMO6tgLTrx+oVhKe4U5YUBM+XrZOlnw6rjQp3VURh4N7uFxoWukzbQM1IHNNmKkM5u4ov8h7I5EtT6YJEXkpfmpQed1xbMZuhDwMr9S6VYJXSHkxuY3B1h/toUl3YWWCFY5cY+wBemrzx1B6e9ItwUNC3n3sH5tI4RPX+YkoJAF1e+wrL/nyECC6hkGrd2thfHXZthSce8B8g7dkdWAkgstdb7fVrJjuVKbz+B9wiRgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5C76N19jQ+vJMhB5VOG3h8yrZFBYKxMRAOD9h6iFvME=;
 b=YyImsrot8Z/UNLvka1wqG7K0iTA9yhmnpa+un0Bje+48wdiKZU60NcWVe3P95j+Wvl9ZAi61aeTwuxa/I4iOyuukKcNrO+/bgNk7NTbm0/xAbXGPlsS6OncgbwxJxQf3in9h/4KkHb+fslnjbgFi52SQHFTG9ayNv0Gdctr1Ar81qFl4Kn/Lhh7UCX/tAA+BKuAA15vP516NqV5sGiC5EQw39zK10KXSLIq6Irpg1o8PEbzSTq3nwfMlHnMy2k+WcBdPJ+Gn6ZbwMouBjH0iKmjVzRbogcrX1usL9QVwbEnehdOhvfeCAXVTQsHxcXCNb7EuuBbZgKIF4LvgbKMiWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BL1PR11MB5478.namprd11.prod.outlook.com (2603:10b6:208:31d::12)
 by BL1PR11MB5543.namprd11.prod.outlook.com (2603:10b6:208:317::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Tue, 31 Aug
 2021 01:47:08 +0000
Received: from BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::19db:ee0e:abd0:df6d]) by BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::19db:ee0e:abd0:df6d%7]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 01:47:08 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bristot@kernel.org" <bristot@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] trace/osnoise: fix missed cpus_read_unlock()
Thread-Topic: [PATCH] trace/osnoise: fix missed cpus_read_unlock()
Thread-Index: AQHXnJoLeOd9goCTS0mJbcCiduHOD6uMTzKAgACKRZU=
Date:   Tue, 31 Aug 2021 01:47:08 +0000
Message-ID: <BL1PR11MB5478B08715D6A30F8E42529BFFCC9@BL1PR11MB5478.namprd11.prod.outlook.com>
References: <20210829055206.137025-1-qiang.zhang@windriver.com>
 <fb07e806-71bf-6bac-ac3c-1d99136d6f8e@redhat.com>
In-Reply-To: <fb07e806-71bf-6bac-ac3c-1d99136d6f8e@redhat.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=windriver.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a99ba16c-920b-4699-9b73-08d96c213e67
x-ms-traffictypediagnostic: BL1PR11MB5543:
x-microsoft-antispam-prvs: <BL1PR11MB55433219EA419F42F58AACC8FFCC9@BL1PR11MB5543.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZNKa3LP1O9q//hktC8Y5NkOQNjck183D0qxS1jyZhEi4pjxIKuMprquG7Oj971F61xkQaWrAtLl35i7lYsW6kOuA8WDb+2+Xit8WeVsD09CJZZRvRqBLTkvUQM7wD9+LSq2RbzWCaWknDexeL0+Y/eqGAjamluoQ5hEqqYjR37wOu5ofRFjmN0WP3Xpdm/mxwbQvb0jGqDyQxaMkdonFp7AgNCtJ94wgaNktRBIaKre0n6nowJopK40BAuv1275uqYUA8/q1xr5qSnaqe5teI4lrydp8QhLlWOY6I6w8w+GsYV/BTQHEAbcsby3GlOuiS1h47dBOEWH3x2MdnSp50HzqF5UBmhbH/8KwOlHNbpDaIYKbrKbF5C+E32fvTV7462xFGJjdykQnJMj7vFXra2VWjiwCRDm4NsE3wbIf5nMkQeln41RGQM/tO6w8EWUS5U6p+K8uFZLXAVJlk8qW3QDyDmcDTJH3xvvZ3OAyu5IY1UkSI0REQJ+VerR6aNMKzzsUhtel6g6F0D63f5VaFawjIEVmBe7A4eQ4oMiy7goN8Q6aGrtO02jsyrZzGkpuIK7VLTyMewhDTYDPoD4MekSTagF6krApehV6Q76l5KeqqktmrAngl7/JaemMKdewVvdML+PSHRGSlG34Oa8Ckz5ewwO42JwEQynwuKJsUsYgskbWhS3s/HEGVw7DZLwhoUrg5Zmk57/x4iSQguvcsLAntFhH+4I2mwV9s+qPVwNwzq98Gghvn8t7JwrWgjoE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(26005)(76116006)(8936002)(122000001)(66446008)(38070700005)(91956017)(52536014)(316002)(4326008)(66556008)(110136005)(66946007)(66476007)(64756008)(83380400001)(2906002)(5660300002)(38100700002)(53546011)(55016002)(6506007)(8676002)(33656002)(86362001)(7696005)(9686003)(186003)(508600001)(586874002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F9kHuVH3/JHoZwglWvp2tqTXp7wmYBWe8g8kKXm4YTxml6htKbV3vQs4f9ni?=
 =?us-ascii?Q?o8wLaRi551WaaB39TW8YqF6+pZNhRxEGlj/A+lkLSyldW5z/EkpiPvp5IO/w?=
 =?us-ascii?Q?ld6owpGoSJJJGbaLO87cGyf2U1FFtcCgpj82nAGKdb5/WKQNOch2Hke2Fzl0?=
 =?us-ascii?Q?HiMZm3hzFU437q/Yv0LaQZVCHAHO2FSdaqJbIZ5zjSmz8JWd8ripo/otwzvU?=
 =?us-ascii?Q?p22pVzyTLFJcTkeMvSkx2wGDvidy0hubJ4XZsesz6QujweH1meVls3mPp6La?=
 =?us-ascii?Q?zB0MS13SleKMP2SzgbpWtTtrbjDw+BwAQdEib5clhAGctc6QgV6kFoQo8PBa?=
 =?us-ascii?Q?cjY9IkclxArGGbDkzB0ovxiZ9tOxpcz3xuTVjTBA9wAC9z5gnkA1lZfyUJzC?=
 =?us-ascii?Q?zq6NoXBSIlafTNu8Tov10aM7pb9fH32NJTvsyE/s2VA/1C4sJnOTxFp8bg0Z?=
 =?us-ascii?Q?1k5h9wHLn2l4wKBenokBCy3Hh/XgIQT1Mk8NKAUThr4slMr82AGjQ7SCr8nI?=
 =?us-ascii?Q?sA94VnazREDJ1XV1WEmBBNH0QGWdh7QFFNsqciQDE390em+Rlp4SFUl9DKig?=
 =?us-ascii?Q?ZPSQyay1if0IHIhoufeExZmSbGfcgsPRnbuzqAWjCLFWktZE0biuDZPJuTRv?=
 =?us-ascii?Q?5Vd1Rpf5XY//RB6M61IPzg6rl/APGyCUb9maaJcUd4ubdoFqGzbA6DkyfLCX?=
 =?us-ascii?Q?yuWOw5vBf5W6utnfDHMdBRiQ5g+WXA6mfWZswSp+v7KKEYeJ5TFbTnI/jrDL?=
 =?us-ascii?Q?aU8448OUjVmm2vSrj2Vo0CrdsmlpzgENlum5DOaXUarJ5SO4k4j3g9lL9zhe?=
 =?us-ascii?Q?sIaZfNqILDE24x32oWlzzmRW6vSjUyh+NmnwfGo9W3MGLfoDlkRmK6Eikf3a?=
 =?us-ascii?Q?2HhgaXBY/FubOulOtApSFJ1PFTuFRPlULxgkhYnGQw0isjKBEJpN9HEKnqiX?=
 =?us-ascii?Q?jPxH+PliDiG4WCtKROIcDpwBFf1MgmKvyXkceagsABUERiIsV/Qa1fM1zT3/?=
 =?us-ascii?Q?CBiYEySfnfoxrP4AFPZBVlbjidUe4AEpVZE4Duut+1ysssWFCIGzqQQddAR5?=
 =?us-ascii?Q?JupmKkdnhG/LzFxEtvg6Fa3gXGw3AcVSGGV3lOm2nFF3cc1g0ltJ7pfs1RoT?=
 =?us-ascii?Q?LiqzogedJR4T72plPWALxooMzgy6F0h22F5jBEjNz8vlIBwx3e2vfZt/g0WA?=
 =?us-ascii?Q?XLpfzLuds/bdHv7AvEaHhkiwDp0OdRWHaBUPt2VVfHun3lvB0kcBJApb6giB?=
 =?us-ascii?Q?RnDiL+hiYiDKCBvLoApK+u4dsuHrBdrns92xfeZ2peCYxeCRmD5+mT0QrCEE?=
 =?us-ascii?Q?7s0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a99ba16c-920b-4699-9b73-08d96c213e67
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 01:47:08.3655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nKjxKyZ+Jc29CfqlTw/afEJ9C0APuX28dhlOeSpC2GtpGRzLqZhcw98hsZUMj5FKbdi55g7a3bekrmzIVQF71vxH9/NnC6jd8usrTyTzJ+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5543
X-Proofpoint-GUID: WQxs8PWmy5J0UY0B8flqL6bn1TpDWDlH
X-Proofpoint-ORIG-GUID: WQxs8PWmy5J0UY0B8flqL6bn1TpDWDlH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-30_06,2021-08-30_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310008
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
=0A=
________________________________________=0A=
From: Daniel Bristot de Oliveira <bristot@redhat.com>=0A=
Sent: Tuesday, 31 August 2021 01:26=0A=
To: Zhang, Qiang; rostedt@goodmis.org; bristot@kernel.org; mingo@redhat.com=
=0A=
Cc: linux-kernel@vger.kernel.org=0A=
Subject: Re: [PATCH] trace/osnoise: fix missed cpus_read_unlock()=0A=
=0A=
[Please note: This e-mail is from an EXTERNAL e-mail address]=0A=
=0A=
>Hi Qiang,=0A=
>=0A=
>On 8/29/21 7:52 AM, qiang.zhang@windriver.com wrote:=0A=
> From: "Qiang.zhang" <qiang.zhang@windriver.com>=0A=
>set the Subject to:=0A=
=0A=
>trace/osnoise: Fix missed cpus_read_unlock() in start_per_cpu_kthreads()=
=0A=
>=0A=
>=0A=
> When start_kthread() return error, the cpus_read_unlock() need=0A=
> to be called.=0A=
>=0A=
> Signed-off-by: Qiang.zhang <qiang.zhang@windriver.com>=0A=
=0A=
>Add:=0A=
>=0A=
>Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")=0A=
>Cc: <stable@vger.kernel.org> # v5.14+=0A=
>=0A=
> ---=0A=
>  kernel/trace/trace_osnoise.c | 1 +=0A=
>  1 file changed, 1 insertion(+)=0A=
>=0A=
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c=
=0A=
> index 65b08b8e5bf8..45d22d6f3acb 100644=0A=
> --- a/kernel/trace/trace_osnoise.c=0A=
> +++ b/kernel/trace/trace_osnoise.c=0A=
> @@ -1568,6 +1568,7 @@ static int start_per_cpu_kthreads(struct trace_arra=
y *tr)=0A=
>               retval =3D start_kthread(cpu);=0A=
>               if (retval) {=0A=
>                       stop_per_cpu_kthreads();=0A=
> +                     cpus_read_unlock();=0A=
>                       return retval;=0A=
>               }=0A=
>       }=0A=
>=0A=
>Why not initialize retval =3D 0, and then remove the "return retval" from =
this if,=0A=
>returning rteval at the end of the function?=0A=
>=0A=
=0A=
Thank you for your suggestion. I'll modify it and resend it. =0A=
=0A=
Qiang.zhang=0A=
=0A=
>-- Daniel=0A=
=0A=
