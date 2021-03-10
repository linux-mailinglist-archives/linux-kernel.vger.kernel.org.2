Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CEA334506
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbhCJRVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:21:31 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34680 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhCJRVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:21:07 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12AH4FCd056039;
        Wed, 10 Mar 2021 17:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3Trz/biwsEKCJYHXufIagzXKnOmuH3XqxTVo8718mz0=;
 b=G3uJMv4Y+oXuRGNd9EzRMGjcCBQNmA1zDXGPXJ1JyrvIt/tUV+PTExqvg450iVnPN3Oy
 adTxd2tX5pAFbmg6sd9vB+DePLtZTvgIPQHJaPZmSgc8ahjU8GaS2xm0K8dElSFGAy+l
 VZqAG4Ho3MQ6aBzXsPjvXtBHj/TIT9wxjqI75JCkJ214eZiOtCA/6DMNaEv8heEMdsSM
 /9l1PYZ1CWk9VtgN0jdiFiV2ZEv3PNXK6KjseAFVbeZY7luPqP1zDsXo1Ouhyzwt1x5Q
 PUPgfjz4Hb7RHsr2MPWe38y1YnNoazC8OgUT5K8theTRgvHpBQflfePapvnnYnmQcEP6 wQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37415rbr9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 17:17:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12AH5kOT055295;
        Wed, 10 Mar 2021 17:17:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by aserp3030.oracle.com with ESMTP id 374kaqgu51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 17:17:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2bdHa55Yq0D1FXhxFqdmGNzzRACu0v/sbKPTKc6vYE1U0/xW8NotB77t/747On8kLpOHJxQY4nib99XUrbYMQU7VajfQ959C/XOm/DwEHscrcDb8XpUx9UE/Qvt4RVe9gZQFRikf8M3SdYLoBGjRDvxLPKdYXhhcIA07N1B/vBvqKaHIuZJDEu1e1JvQk6IRo5M9/HdppVJoz22xlvQcMizd7qiRpvUok7OjGg6r3LV3kO7E2vyE7LTejM5TM5DAJam2XxghuJzT7sicqbNrsr5fqs4D2iOen9ITdIyhXTY0JZxD92ORWzEz4qTUc1S7db1fvHb85BLo+TTM5kLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Trz/biwsEKCJYHXufIagzXKnOmuH3XqxTVo8718mz0=;
 b=O5rB1w5Hk/y4u6sy/6tU+TV+ZAMLd1M1desHa9Ovxh5qmx+2E1lp9Q6z72t22WRHWAxU2dyZ3DYksI/Ot0mVNXK+ABNJOsGtNZLOxINg+zqe21ssgLQiwoLqMNYFidO6VLbNsueA0KkDZ6j8Y2Ofpby7hHpNHyu4ndkYPnp9To9GAgYUIkOJBng2VEEjKbTrm802P1qo76+IIXOEJQ+lNwUR0isevqHundr/1Xk6G4Hcp/bP0JoSgxmvPjHEeL/oPUonCL+zvqqCrrKHvndB1aSBhm/C6FbijdVFSmqhX0bPLfHf618v1qzV76yZtaDkMc5zPSiqsFF9soB5zqkUSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Trz/biwsEKCJYHXufIagzXKnOmuH3XqxTVo8718mz0=;
 b=jxmvWm575FXqhgZIoFdvbz7c/vOc3YiPUnr/Lj7hvOpGVdEaLFXxkCWWm+cMurSODv13WawxIE58CPLz/ouTk3lnPQDr/nuAU24mijzuCxO5J9fZsXj73ZhjSp2jWF966vYsgtSUm6OXS5dvvdID/M9oEtDadpFKwG/RrFl5osw=
Received: from SA2PR10MB4652.namprd10.prod.outlook.com (2603:10b6:806:110::7)
 by SA2PR10MB4809.namprd10.prod.outlook.com (2603:10b6:806:113::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 17:17:05 +0000
Received: from SA2PR10MB4652.namprd10.prod.outlook.com
 ([fe80::b4b8:24f8:549e:f424]) by SA2PR10MB4652.namprd10.prod.outlook.com
 ([fe80::b4b8:24f8:549e:f424%4]) with mapi id 15.20.3912.029; Wed, 10 Mar 2021
 17:17:05 +0000
From:   Alex Kogan <alex.kogan@oracle.com>
To:     kernel test robot <oliver.sang@intel.com>
CC:     0day robot <lkp@intel.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@intel.com" <zhengjun.xing@intel.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "jglauber@marvell.com" <jglauber@marvell.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dave Dice <dave.dice@oracle.com>
Subject: Re: [locking/qspinlock]  0e8d8f4f12:  stress-ng.zero.ops_per_sec
 -9.7% regression
Thread-Topic: [locking/qspinlock]  0e8d8f4f12:  stress-ng.zero.ops_per_sec
 -9.7% regression
Thread-Index: AQHXFdChZkV8XXr+skSimXiMM8pAi6p9dazX
Date:   Wed, 10 Mar 2021 17:17:04 +0000
Message-ID: <SA2PR10MB46525798D53C47B39F88ED5DF1919@SA2PR10MB4652.namprd10.prod.outlook.com>
References: <20201223054455.1990884-4-alex.kogan@oracle.com>,<20201228081601.GA31221@xsang-OptiPlex-9020>
In-Reply-To: <20201228081601.GA31221@xsang-OptiPlex-9020>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [108.20.27.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f53173c-76b6-4b61-8716-08d8e3e853d6
x-ms-traffictypediagnostic: SA2PR10MB4809:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR10MB48099048DB4B6CC26B949413F1919@SA2PR10MB4809.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /32ddLVoY8uHLpHDhKZ9VxDed8O215NOvAyOj/V0QLLfmTWWjMegmN/DduPKCdRi9T1+N6nlDgl9P8sOhGF+VhZ9lvbRP0vdkc1zwGYWxwObI9YPQQWvcbx9HhTaOjyPSt/vlTYomGEMktdwhZjzo4JrJcZFwtULewIThfS2Z+PCf6lH3he8a6ppkGVsc3BThuTeE0+vIx8Np+GU3fdO4iwmkrJqmny1E9yHoIaHzrA3W0VIM+Zwv+xA0Au7YMxyt7kDaOBeBEKDIzvj23AvAN1CRHR9SjfHl1QYO0MD4XG4s8jbbND8AZC++ksNb0JfQe1M4/WKFNw6VApcGQswyxHj2VV7iwTRbDWuqfnEN+XSK/IhFGLtRZex9oFRoYpPPc3m7DHQWlgPaKVmhoIQ9+4P6vcka1SX9JacM6J/akSpJwq776TOqQVFvAn1nZtwSdeWWy54/otBmy7nPJCOv1pfvTcTy3B+sEH6+oka9QMAxlwae0TzWImSM2+bW7y6+otnrzZRGk5pW8F+XwSA6ZghOjrp0iIHJgzQWa+FgjERt3AXiWu9ElptSgc8Nau1IZZWJAdgCprpenWAQhNYbGGOwppBwZkAKWbxWJRKTsmKPZcnaKO29mZkmBbmnTIBtlejY8PoubG1JShjYcAVOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4652.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(366004)(136003)(396003)(54906003)(6506007)(71200400001)(7696005)(66556008)(66476007)(8676002)(19627235002)(5660300002)(107886003)(8936002)(316002)(53546011)(44832011)(966005)(30864003)(6916009)(55016002)(26005)(4326008)(2906002)(66946007)(76116006)(478600001)(52536014)(9686003)(86362001)(66446008)(91956017)(7416002)(64756008)(186003)(33656002)(83380400001)(559001)(579004)(569008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?2N9IuAY8xnKh7560KK3W0i7+ONf9nrHHkD35//uvJjFvS+DFFOqiBm06?=
 =?Windows-1252?Q?AxX9qADSdarM95H/IKH3NiT85lAKLbEXfC/jyEAUuRHfp4d9L2YuVrqX?=
 =?Windows-1252?Q?9RGC2fSHycz+ZeRgBnwbx72JbjzwAULiUtVhIlfAYMYl2xFYx5sef0Ln?=
 =?Windows-1252?Q?R/CCGzEjjInxO6vhmWooAdySeMogJC1e4UmaOhkbX2M6M4Wkx2694ymd?=
 =?Windows-1252?Q?wGMTQFsg4r/VhMFnYXRsZAp/jdoaH/DH2bclghxZKwOXQnIs9IEIZThh?=
 =?Windows-1252?Q?f/GduX8RuFmIfZMrbbo1Lkp5u1x7NgYjrXN/16Lh1z0gSSbnSDkW1EFR?=
 =?Windows-1252?Q?GqQrcPRHaViT33ETnQnEASPEJenWiRIw5SYg9fwy2BBNSmJmBIBHMiYL?=
 =?Windows-1252?Q?MaV2os5j8PDcifv5V+D4l+166vugJeLQ1pTg12FteaXfjW1OglD1YxBw?=
 =?Windows-1252?Q?g2ugd33jYk42ImlXouc4bF3K+s2VAR9xmgql89ZjGIWl4xLuASwtPJ8h?=
 =?Windows-1252?Q?Rkre0t8Z7/opie22aQSxQzHKwtA0wJprwidXqGKl4lt3AyIY6fzIrUCi?=
 =?Windows-1252?Q?KaLIjRWmJHxcmrBWp1ENBcPQ52cU7fVjNKQO9LU///SZy7yKlQhtucR+?=
 =?Windows-1252?Q?XFn5DtOYQ92FPYuIwW0NDZ72EYk/+RjdARv/N9lkkqpsCuxVPypPZBRI?=
 =?Windows-1252?Q?7yJYvoT75HEXEC36GjUnp4f0Zwc3vN5GKztEbGcXqN6L+awswx5B4mBr?=
 =?Windows-1252?Q?+h4jqEExfmrcw1AIfSKTYstjUWYekiXoZnyHsiB4GDr7llCMle99Zdxe?=
 =?Windows-1252?Q?ufKsY35VubywUlwaj6nEXFKjgXmbgHmkINk5dUVcsMan4Ai2waME+0O/?=
 =?Windows-1252?Q?//MpYl8M5In3CJjbFjDUI/gt1te2bUMKhTWhUVpMD4JWtjmXL3/SupNZ?=
 =?Windows-1252?Q?abwpPmHaAK8o3xUM4ex7KmZryVAJd9jRJm7+lDuvv4Ms3ANzoDFgWsAV?=
 =?Windows-1252?Q?w5ye69zwvSBYq5WfPnbejSsN67bETUeHqBD1/SdbIddA5/ZY0aZcUiGG?=
 =?Windows-1252?Q?p4aUZ/x7gVR3DWWLvHa+8JwSk2prE96+Lp6NI13ltCvCr/gjbSlIFnTt?=
 =?Windows-1252?Q?7zT1T3tJBsiyA1Hwi2lGPzzwSNf8HiKEwl2wuT+3lVlsnnnkazgnXg7L?=
 =?Windows-1252?Q?R1ETEKjADbN/7raDpJX7y7krWDXKB3lJVgVwy/5h27TV8BDwkEiv9yIh?=
 =?Windows-1252?Q?eMHjb2WPRsJPcZSpyUAefjtT68n40QLIvxrw/cFzx4+o4RHtM+kR1VTo?=
 =?Windows-1252?Q?0eVplpWohCeTsSg7++BMOQVeWUqz0rpI6gTQJL8A9Vswy3lLSvhJYRjc?=
 =?Windows-1252?Q?90h47XGcq4gf8uaLwSpVWvNWgB5vvMPHyxo=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4652.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f53173c-76b6-4b61-8716-08d8e3e853d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 17:17:04.9439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3sKwECVW5CQ9HnQQe31ilPTabjnbDmCgbN+6Cr8MXQePiTeWokF1pVnACKjciJQL8lxKGJkeb6ADTDRoo5SXzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4809
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100083
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103100083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Looks like my previous reply failed to reach the mailing list. Reposting =
again, after (hopefully)=A0=0A=
fixing the problem with the included URL. Apologies if you have received th=
is message in=0A=
the past. ]=0A=
=0A=
A quick update: there is a problem in running this test to reproduce the re=
gression, =0A=
and Oliver Sang is aware of that.=0A=
=0A=
Along with that, I wonder if this is a real issue or some noise in the meas=
urements.=A0=0A=
This regression is reported with the =93--device" switch, which according t=
o=0A=
https://wiki.ubuntu.com/Kernel/Reference/stress-ng, enables "raw device dri=
ver stressors=94.=0A=
I wonder if it is relevant=A0to the spin lock=A0performance.=0A=
=0A=
Any thoughts?=0A=
=0A=
Also, using this opportunity, any further feedback on the patch would be gr=
eatly appreciated.=0A=
=0A=
Thanks,=0A=
=97 Alex=0A=
=0A=
=0A=
=0A=
From: kernel test robot <oliver.sang@intel.com>=0A=
Sent: Monday, December 28, 2020 3:16 AM=0A=
To: Alex Kogan <alex.kogan@oracle.com>=0A=
Cc: 0day robot <lkp@intel.com>; Steven Sistare <steven.sistare@oracle.com>;=
 Waiman Long <longman@redhat.com>; LKML <linux-kernel@vger.kernel.org>; lkp=
@lists.01.org <lkp@lists.01.org>; ying.huang@intel.com <ying.huang@intel.co=
m>; feng.tang@intel.com <feng.tang@intel.com>; zhengjun.xing@intel.com <zhe=
ngjun.xing@intel.com>; linux@armlinux.org.uk <linux@armlinux.org.uk>; peter=
z@infradead.org <peterz@infradead.org>; mingo@redhat.com <mingo@redhat.com>=
; will.deacon@arm.com <will.deacon@arm.com>; arnd@arndb.de <arnd@arndb.de>;=
 linux-arch@vger.kernel.org <linux-arch@vger.kernel.org>; linux-arm-kernel@=
lists.infradead.org <linux-arm-kernel@lists.infradead.org>; tglx@linutronix=
.de <tglx@linutronix.de>; bp@alien8.de <bp@alien8.de>; hpa@zytor.com <hpa@z=
ytor.com>; x86@kernel.org <x86@kernel.org>; guohanjun@huawei.com <guohanjun=
@huawei.com>; jglauber@marvell.com <jglauber@marvell.com>; Daniel Jordan <d=
aniel.m.jordan@oracle.com>; Alex Kogan <alex.kogan@oracle.com>; Dave Dice <=
dave.dice@oracle.com>=0A=
Subject: [locking/qspinlock] 0e8d8f4f12: stress-ng.zero.ops_per_sec -9.7% r=
egression =0A=
=A0=0A=
=0A=
Greeting,=0A=
=0A=
FYI, we noticed a -9.7% regression of stress-ng.zero.ops_per_sec due to com=
mit:=0A=
=0A=
=0A=
commit: 0e8d8f4f1214cfbac219d6917b5f6460f818bb7c ("[PATCH v13 3/6] locking/=
qspinlock: Introduce CNA into the slow path of qspinlock")=0A=
url: https://urldefense.com/v3/__https://github.com/0day-ci/linux/commits/A=
lex-Kogan/Add-NUMA-awareness-to-qspinlock/20201223-135025__;!!GqivPVa7Brio!=
LF1Vhc6eU7n1kxGSlPpI_wS0LmREqgH6k1226e4w8C7ug0i7368nCfIT44_wbu1g$ =0A=
base: https://urldefense.com/v3/__https://git.kernel.org/cgit/linux/kernel/=
git/tip/tip.git__;!!GqivPVa7Brio!LF1Vhc6eU7n1kxGSlPpI_wS0LmREqgH6k1226e4w8C=
7ug0i7368nCfIT42aMeOW1$=A0 cb262935a166bdef0ccfe6e2adffa00c0f2d038a=0A=
=0A=
in testcase: stress-ng=0A=
on test machine: 48 threads Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with =
112G memory=0A=
with following parameters:=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 nr_threads: 100%=0A=
=A0=A0=A0=A0=A0=A0=A0 disk: 1HDD=0A=
=A0=A0=A0=A0=A0=A0=A0 testtime: 30s=0A=
=A0=A0=A0=A0=A0=A0=A0 class: device=0A=
=A0=A0=A0=A0=A0=A0=A0 cpufreq_governor: performance=0A=
=A0=A0=A0=A0=A0=A0=A0 ucode: 0x42e=0A=
=0A=
=0A=
In addition to that, the commit also has significant impact on the followin=
g tests:=0A=
=0A=
+------------------+-------------------------------------------------------=
--------------------+=0A=
| testcase: change | fsmark: fsmark.files_per_sec 213.9% improvement=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=
=0A=
| test machine=A0=A0=A0=A0 | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU=
 @ 2.30GHz with 192G memory |=0A=
| test parameters=A0 | cpufreq_governor=3Dperformance=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=0A=
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | disk=3D1BRD_48G=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=0A=
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | filesize=3D4M=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=0A=
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | fs=3Dbtrfs=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=0A=
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | iterations=3D1x=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=0A=
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | nr_threads=3D64t=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 |=0A=
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | sync_method=3DNoSync=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=0A=
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | test_size=3D24G=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=0A=
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | ucode=3D0x5003003=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=0A=
+------------------+-------------------------------------------------------=
--------------------+=0A=
| testcase: change | reaim: reaim.jobs_per_min 96.1% improvement=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 |=0A=
| test machine=A0=A0=A0=A0 | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU=
 @ 2.30GHz with 192G memory |=0A=
| test parameters=A0 | cpufreq_governor=3Dperformance=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=0A=
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | nr_task=3D100%=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=0A=
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | runtime=3D300s=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=0A=
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | test=3Dnew_fserver=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=0A=
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | ucode=3D0x5003003=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=0A=
+------------------+-------------------------------------------------------=
--------------------+=0A=
=0A=
=0A=
If you fix the issue, kindly add following tag=0A=
Reported-by: kernel test robot <oliver.sang@intel.com>=0A=
=0A=
=0A=
Details are as below:=0A=
---------------------------------------------------------------------------=
----------------------->=0A=
=0A=
=0A=
To reproduce:=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 git clone https://urldefense.com/v3/__https://github.=
com/intel/lkp-tests.git__;!!GqivPVa7Brio!LF1Vhc6eU7n1kxGSlPpI_wS0LmREqgH6k1=
226e4w8C7ug0i7368nCfIT4ySp2S6I$ =0A=
=A0=A0=A0=A0=A0=A0=A0 cd lkp-tests=0A=
=A0=A0=A0=A0=A0=A0=A0 bin/lkp install job.yaml=A0 # job file is attached in=
 this email=0A=
=A0=A0=A0=A0=A0=A0=A0 bin/lkp run=A0=A0=A0=A0 job.yaml=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/t=
estcase/testtime/ucode:=0A=
=A0 device/gcc-9/performance/1HDD/x86_64-rhel-8.3/100%/debian-10.4-x86_64-2=
0200603.cgz/lkp-ivb-2ep1/stress-ng/30s/0x42e=0A=
=0A=
commit: =0A=
=A0 cb45bab007 ("locking/qspinlock: Refactor the qspinlock slow path")=0A=
=A0 0e8d8f4f12 ("locking/qspinlock: Introduce CNA into the slow path of qsp=
inlock")=0A=
=0A=
cb45bab007ff0cfc 0e8d8f4f1214cfbac219d6917b5 =0A=
---------------- --------------------------- =0A=
=A0=A0=A0=A0=A0=A0 fail:runs=A0 %reproduction=A0=A0=A0 fail:runs=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0 =0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 :4=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 25%=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 1:4=A0=A0=A0=A0 last_state.is_incomplete_run=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 :4=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 25%=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 1:4=A0=A0=A0=A0 dmesg.Kernel_panic-not_syncing:sof=
tlockup:hung_tasks=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 :4=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 25%=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 1:4=A0=A0=A0=A0 dmesg.RIP:smp_call_function_many_c=
ond=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 :4=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 25%=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 1:4=A0=A0=A0=A0 dmesg.RIP:smp_call_function_single=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 %stddev=A0=A0=A0=A0 %change=A0=A0=A0=A0=A0=A0=A0=
=A0 %stddev=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=A0 =0A=
=A0=A0=A0 481980 =B1=A0 9%=A0=A0=A0=A0 -12.0%=A0=A0=A0=A0 424197 =B1=A0 5%=
=A0 stress-ng.time.involuntary_context_switches=0A=
=A01.198e+08=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -4.0%=A0=A0 1.15e+08=A0=A0=A0=
=A0=A0=A0=A0 stress-ng.time.minor_page_faults=0A=
=A0=A0=A0 689.06=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -4.9%=A0=A0=A0=A0 655.29=
=A0=A0=A0=A0=A0=A0=A0 stress-ng.time.user_time=0A=
=A0 10626516=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -9.7%=A0=A0=A0 9598124=A0=A0=
=A0=A0=A0=A0=A0 stress-ng.zero.ops=0A=
=A0=A0=A0 354216=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -9.7%=A0=A0=A0=A0 319937=
=A0=A0=A0=A0=A0=A0=A0 stress-ng.zero.ops_per_sec=0A=
=A0=A0=A0=A0 12871=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +19.8%=A0=A0=A0=A0=A0 1542=
4 =B1 12%=A0 meminfo.max_used_kB=0A=
=A0=A0=A0=A0 29.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +4.6%=A0=A0=A0=A0=A0 30=
.33=A0=A0=A0=A0=A0=A0=A0 vmstat.cpu.id=0A=
=A0=A0=A0=A0 29.66=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +3.7%=A0=A0=A0=A0=A0 30=
.75 =B1=A0 2%=A0 iostat.cpu.idle=0A=
=A0=A0=A0=A0=A0 8.21=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -7.6%=A0=A0=A0=A0=A0=
=A0 7.59 =B1=A0 2%=A0 iostat.cpu.user=0A=
=A0=A0=A0=A0 67636 =B1 12%=A0=A0=A0=A0 -21.3%=A0=A0=A0=A0=A0 53263 =B1 14%=
=A0 sched_debug.cpu.nr_switches.max=0A=
=A0=A0=A0=A0 70.29 =B1 16%=A0=A0=A0=A0 -22.1%=A0=A0=A0=A0=A0 54.73 =B1 14%=
=A0 sched_debug.cpu.nr_uninterruptible.stddev=0A=
=A0=A0=A0=A0=A0 7841 =B1 58%=A0=A0=A0 +418.8%=A0=A0=A0=A0=A0 40676 =B1=A0 2=
%=A0 numa-meminfo.node0.Active=0A=
=A0=A0=A0=A0=A0 6226 =B1 71%=A0=A0=A0 +542.5%=A0=A0=A0=A0=A0 40001=A0=A0=A0=
=A0=A0=A0=A0 numa-meminfo.node0.Active(anon)=0A=
=A0=A0=A0=A0 15043 =B1 32%=A0=A0=A0 +271.6%=A0=A0=A0=A0=A0 55899=A0=A0=A0=
=A0=A0=A0=A0 numa-meminfo.node0.Shmem=0A=
=A0=A0=A0=A0 77673 =B1=A0 3%=A0=A0=A0=A0 -50.0%=A0=A0=A0=A0=A0 38874 =B1=A0=
 9%=A0 numa-meminfo.node1.Active=0A=
=A0=A0=A0=A0 77439 =B1=A0 3%=A0=A0=A0=A0 -51.0%=A0=A0=A0=A0=A0 37925 =B1=A0=
 8%=A0 numa-meminfo.node1.Active(anon)=0A=
=A0=A0=A0 233.75 =B1157%=A0=A0=A0 +306.0%=A0=A0=A0=A0 949.00 =B1 66%=A0 num=
a-meminfo.node1.Active(file)=0A=
=A0=A0=A0 575517 =B1=A0 4%=A0=A0=A0=A0=A0 -8.8%=A0=A0=A0=A0 525050 =B1=A0 3=
%=A0 numa-meminfo.node1.FilePages=0A=
=A0=A0=A0=A0 87936 =B1=A0 4%=A0=A0=A0=A0 -53.1%=A0=A0=A0=A0=A0 41275 =B1=A0=
 9%=A0 numa-meminfo.node1.Shmem=0A=
=A0=A0=A0=A0=A0 2097 =B1=A0 5%=A0=A0=A0=A0 +26.8%=A0=A0=A0=A0=A0=A0 2660 =
=B1 21%=A0 slabinfo.dmaengine-unmap-16.active_objs=0A=
=A0=A0=A0=A0=A0 2097 =B1=A0 5%=A0=A0=A0=A0 +26.8%=A0=A0=A0=A0=A0=A0 2660 =
=B1 21%=A0 slabinfo.dmaengine-unmap-16.num_objs=0A=
=A0=A0=A0=A0 40336 =B1=A0 6%=A0=A0=A0 +102.0%=A0=A0=A0=A0=A0 81465 =B1 50%=
=A0 slabinfo.filp.active_objs=0A=
=A0=A0=A0 657.00 =B1=A0 6%=A0=A0=A0=A0 +98.0%=A0=A0=A0=A0=A0=A0 1301 =B1 49=
%=A0 slabinfo.filp.active_slabs=0A=
=A0=A0=A0=A0 42081 =B1=A0 6%=A0=A0=A0=A0 +97.9%=A0=A0=A0=A0=A0 83296 =B1 49=
%=A0 slabinfo.filp.num_objs=0A=
=A0=A0=A0 657.00 =B1=A0 6%=A0=A0=A0=A0 +98.0%=A0=A0=A0=A0=A0=A0 1301 =B1 49=
%=A0 slabinfo.filp.num_slabs=0A=
=A0=A0=A0=A0 13106 =B1=A0 3%=A0=A0=A0=A0 +12.6%=A0=A0=A0=A0=A0 14752 =B1=A0=
 3%=A0 slabinfo.shmem_inode_cache.active_objs=0A=
=A0=A0=A0=A0 13224 =B1=A0 3%=A0=A0=A0=A0 +12.5%=A0=A0=A0=A0=A0 14873 =B1=A0=
 3%=A0 slabinfo.shmem_inode_cache.num_objs=0A=
=A0=A0=A0=A0=A0 1557 =B1 71%=A0=A0=A0 +545.2%=A0=A0=A0=A0=A0 10045 =B1=A0 2=
%=A0 numa-vmstat.node0.nr_active_anon=0A=
=A0=A0=A0 117.50 =B1 57%=A0=A0=A0=A0 -97.4%=A0=A0=A0=A0=A0=A0 3.00 =B1 47%=
=A0 numa-vmstat.node0.nr_mlock=0A=
=A0=A0=A0=A0=A0 3761 =B1 32%=A0=A0=A0 +273.2%=A0=A0=A0=A0=A0 14037=A0=A0=A0=
=A0=A0=A0=A0 numa-vmstat.node0.nr_shmem=0A=
=A0=A0=A0=A0=A0 1557 =B1 71%=A0=A0=A0 +545.2%=A0=A0=A0=A0=A0 10045 =B1=A0 2=
%=A0 numa-vmstat.node0.nr_zone_active_anon=0A=
=A0=A0=A0=A0 19391 =B1=A0 3%=A0=A0=A0=A0 -50.8%=A0=A0=A0=A0=A0=A0 9533 =B1=
=A0 7%=A0 numa-vmstat.node1.nr_active_anon=0A=
=A0=A0=A0=A0 58.25 =B1157%=A0=A0=A0 +301.1%=A0=A0=A0=A0 233.67 =B1 67%=A0 n=
uma-vmstat.node1.nr_active_file=0A=
=A0=A0=A0 143875 =B1=A0 3%=A0=A0=A0=A0=A0 -8.7%=A0=A0=A0=A0 131291 =B1=A0 3=
%=A0 numa-vmstat.node1.nr_file_pages=0A=
=A0=A0=A0=A0 21981 =B1=A0 4%=A0=A0=A0=A0 -52.9%=A0=A0=A0=A0=A0 10346 =B1=A0=
 8%=A0 numa-vmstat.node1.nr_shmem=0A=
=A0=A0=A0=A0 19391 =B1=A0 3%=A0=A0=A0=A0 -50.8%=A0=A0=A0=A0=A0=A0 9533 =B1=
=A0 7%=A0 numa-vmstat.node1.nr_zone_active_anon=0A=
=A0=A0=A0=A0 58.25 =B1157%=A0=A0=A0 +301.1%=A0=A0=A0=A0 233.67 =B1 67%=A0 n=
uma-vmstat.node1.nr_zone_active_file=0A=
=A0=A0=A0 110768 =B1=A0 3%=A0=A0=A0=A0 -10.6%=A0=A0=A0=A0=A0 99008 =B1=A0 4=
%=A0 softirqs.CPU0.RCU=0A=
=A0=A0=A0 108763 =B1=A0 3%=A0=A0=A0=A0 -10.1%=A0=A0=A0=A0=A0 97774 =B1=A0 4=
%=A0 softirqs.CPU1.RCU=0A=
=A0=A0=A0 104199 =B1=A0 3%=A0=A0=A0=A0=A0 -9.5%=A0=A0=A0=A0=A0 94314 =B1=A0=
 4%=A0 softirqs.CPU12.RCU=0A=
=A0=A0=A0 106156 =B1=A0 5%=A0=A0=A0=A0 -11.6%=A0=A0=A0=A0=A0 93873 =B1=A0 4=
%=A0 softirqs.CPU13.RCU=0A=
=A0=A0=A0 107231 =B1=A0 4%=A0=A0=A0=A0 -11.3%=A0=A0=A0=A0=A0 95088 =B1=A0 6=
%=A0 softirqs.CPU14.RCU=0A=
=A0=A0=A0 105547 =B1=A0 5%=A0=A0=A0=A0 -10.5%=A0=A0=A0=A0=A0 94461 =B1=A0 4=
%=A0 softirqs.CPU15.RCU=0A=
=A0=A0=A0 104326 =B1=A0 5%=A0=A0=A0=A0=A0 -7.4%=A0=A0=A0=A0=A0 96653 =B1=A0=
 4%=A0 softirqs.CPU22.RCU=0A=
=A0=A0=A0 108301 =B1=A0 3%=A0=A0=A0=A0=A0 -9.9%=A0=A0=A0=A0=A0 97571 =B1=A0=
 3%=A0 softirqs.CPU25.RCU=0A=
=A0=A0=A0 109423 =B1=A0 3%=A0=A0=A0=A0 -10.9%=A0=A0=A0=A0=A0 97448 =B1=A0 3=
%=A0 softirqs.CPU26.RCU=0A=
=A0=A0=A0 109554 =B1=A0 4%=A0=A0=A0=A0=A0 -7.2%=A0=A0=A0=A0 101691 =B1=A0 3=
%=A0 softirqs.CPU31.RCU=0A=
=A0=A0=A0 108410 =B1=A0 4%=A0=A0=A0=A0 -11.2%=A0=A0=A0=A0=A0 96233 =B1=A0 3=
%=A0 softirqs.CPU37.RCU=0A=
=A0=A0=A0 107189 =B1=A0 4%=A0=A0=A0=A0=A0 -9.8%=A0=A0=A0=A0=A0 96642 =B1=A0=
 4%=A0 softirqs.CPU38.RCU=0A=
=A0=A0=A0 108943 =B1=A0 4%=A0=A0=A0=A0 -10.9%=A0=A0=A0=A0=A0 97052 =B1=A0 4=
%=A0 softirqs.CPU39.RCU=0A=
=A0=A0=A0=A0=A0 3348 =B1 37%=A0=A0=A0 +214.8%=A0=A0=A0=A0=A0 10541 =B1 51%=
=A0 softirqs.NET_RX=0A=
=A0=A0=A0=A0 20942 =B1=A0 2%=A0=A0=A0=A0=A0 -6.2%=A0=A0=A0=A0=A0 19637 =B1=
=A0 4%=A0 proc-vmstat.nr_active_anon=0A=
=A0=A0=A0=A0 67173 =B1=A0 4%=A0=A0=A0=A0=A0 -3.7%=A0=A0=A0=A0=A0 64699=A0=
=A0=A0=A0=A0=A0=A0 proc-vmstat.nr_anon_pages=0A=
=A0=A0=A0=A0 10595=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -1.7%=A0=A0=A0=A0=A0 10=
418=A0=A0=A0=A0=A0=A0=A0 proc-vmstat.nr_mapped=0A=
=A0=A0=A0=A0 25771 =B1=A0 2%=A0=A0=A0=A0=A0 -5.1%=A0=A0=A0=A0=A0 24461 =B1=
=A0 3%=A0 proc-vmstat.nr_shmem=0A=
=A0=A0=A0=A0 38683=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +5.7%=A0=A0=A0=A0=A0 40=
878 =B1=A0 3%=A0 proc-vmstat.nr_slab_unreclaimable=0A=
=A0=A0=A0=A0 20942 =B1=A0 2%=A0=A0=A0=A0=A0 -6.2%=A0=A0=A0=A0=A0 19637 =B1=
=A0 4%=A0 proc-vmstat.nr_zone_active_anon=0A=
=A0=A0=A0=A0 21010 =B1 11%=A0=A0=A0=A0 -23.8%=A0=A0=A0=A0=A0 16020 =B1 11%=
=A0 proc-vmstat.numa_hint_faults=0A=
=A0=A0=A0=A0 16666 =B1 11%=A0=A0=A0=A0 -28.6%=A0=A0=A0=A0=A0 11904 =B1=A0 7=
%=A0 proc-vmstat.numa_hint_faults_local=0A=
=A0=A0=A0=A0 69020 =B1=A0 3%=A0=A0=A0=A0=A0 -3.7%=A0=A0=A0=A0=A0 66499=A0=
=A0=A0=A0=A0=A0=A0 proc-vmstat.numa_other=0A=
=A0 21276729=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -9.4%=A0=A0 19266740=A0=A0=A0=
=A0=A0=A0=A0 proc-vmstat.pgactivate=0A=
=A0=A0=A0=A0 45217=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +4.0%=A0=A0=A0=A0=A0 47=
044=A0=A0=A0=A0=A0=A0=A0 proc-vmstat.pgalloc_dma32=0A=
=A01.065e+08=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -2.8%=A0 1.035e+08=A0=A0=A0=
=A0=A0=A0=A0 proc-vmstat.pgalloc_normal=0A=
=A0=A0=A0 610.50 =B1 10%=A0=A0=A0=A0 +83.9%=A0=A0=A0=A0=A0=A0 1123 =B1 28%=
=A0 proc-vmstat.pgdeactivate=0A=
=A01.209e+08=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -4.1%=A0 1.159e+08=A0=A0=A0=
=A0=A0=A0=A0 proc-vmstat.pgfault=0A=
=A01.064e+08=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -2.7%=A0 1.035e+08=A0=A0=A0=
=A0=A0=A0=A0 proc-vmstat.pgfree=0A=
=A0=A0=A0=A0=A0 5.50 =B1 20%=A0 +71439.4%=A0=A0=A0=A0=A0=A0 3934 =B1141%=A0=
 proc-vmstat.pgmigrate_fail=0A=
=A0=A0=A0=A0=A0 3540 =B1 29%=A0=A0=A0 +139.9%=A0=A0=A0=A0=A0=A0 8494 =B1=A0=
 7%=A0 proc-vmstat.pgrotated=0A=
=A0 10600738=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -9.5%=A0=A0=A0 9598142=A0=A0=
=A0=A0=A0=A0=A0 proc-vmstat.unevictable_pgs_mlocked=0A=
=A0 10600295=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -9.5%=A0=A0=A0 9598142=A0=A0=
=A0=A0=A0=A0=A0 proc-vmstat.unevictable_pgs_munlocked=0A=
=A0=A0=A0=A0=A0 0.05 =B1 97%=A0=A0=A0=A0 -59.4%=A0=A0=A0=A0=A0=A0 0.02 =B1=
=A0 2%=A0 perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_S=
YSCALL_64_after_hwframe.[unknown]=0A=
=A0=A0=A0=A0=A0 0.03 =B1=A0 6%=A0 +29749.0%=A0=A0=A0=A0=A0=A0 9.03 =B1 71%=
=A0 perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret=
_from_fork=0A=
=A0=A0=A0=A0 20.46 =B1=A0 3%=A0=A0=A0=A0=A0 -8.9%=A0=A0=A0=A0=A0 18.64 =B1=
=A0 4%=A0 perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_=
open.path_openat=0A=
=A0=A0=A0=A0=A0 7526 =B1 15%=A0=A0=A0=A0 -25.7%=A0=A0=A0=A0=A0=A0 5592 =B1=
=A0 5%=A0 perf-sched.total_wait_and_delay.max.ms=0A=
=A0=A0=A0=A0=A0 7526 =B1 15%=A0=A0=A0=A0 -25.7%=A0=A0=A0=A0=A0=A0 5592 =B1=
=A0 5%=A0 perf-sched.total_wait_time.max.ms=0A=
=A0=A0=A0=A0=A0 9.67 =B1168%=A0=A0=A0=A0 -97.6%=A0=A0=A0=A0=A0=A0 0.24 =B1 =
30%=A0 perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resch=
ed.do_user_addr_fault.exc_page_fault.asm_exc_page_fault=0A=
=A0=A0=A0 343.12 =B1139%=A0=A0=A0 +236.4%=A0=A0=A0=A0=A0=A0 1154 =B1 14%=A0=
 perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.gen=
eric_perform_write.__generic_file_write_iter.generic_file_write_iter=0A=
=A0=A0=A0=A0=A0 1.39 =B1173%=A0 +26107.3%=A0=A0=A0=A0 364.94=A0=A0=A0=A0=A0=
=A0=A0 perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_p=
oll.do_epoll_wait.__x64_sys_epoll_wait=0A=
=A0=A0=A0=A0=A0 5.59 =B1=A0 6%=A0=A0=A0=A0 -20.2%=A0=A0=A0=A0=A0=A0 4.46 =
=B1=A0 6%=A0 perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_kthre=
ad.kthread.ret_from_fork=0A=
=A0=A0=A0=A0=A0 1770 =B1=A0 6%=A0=A0=A0=A0 +26.3%=A0=A0=A0=A0=A0=A0 2236 =
=B1=A0 7%=A0 perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthrea=
d.kthread.ret_from_fork=0A=
=A0=A0=A0=A0 18.50 =B1 51%=A0=A0=A0 +272.3%=A0=A0=A0=A0=A0 68.88 =B1 22%=A0=
 perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.rem=
ove_vma.__do_munmap.__vm_munmap=0A=
=A0=A0=A0=A0 20.79 =B1 26%=A0=A0=A0 +217.3%=A0=A0=A0=A0=A0 65.97 =B1=A0 9%=
=A0 perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.=
unmap_vmas.unmap_region.__do_munmap=0A=
=A0=A0=A0 242.02 =B1 18%=A0=A0=A0=A0 -60.5%=A0=A0=A0=A0=A0 95.68 =B1 51%=A0=
 perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.r=
et_from_fork=0A=
=A0=A0=A0=A0=A0 0.12 =B1 32%=A0=A0=A0 +266.9%=A0=A0=A0=A0=A0=A0 0.43 =B1 78=
%=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__al=
loc_pages_nodemask.alloc_pages_vma.do_anonymous_page=0A=
=A0=A0=A0=A0=A0 1971 =B1123%=A0=A0=A0=A0 -99.4%=A0=A0=A0=A0=A0 11.34 =B1 10=
%=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__al=
loc_pages_nodemask.alloc_pages_vma.shmem_alloc_page=0A=
=A0=A0=A0=A0=A0 9.67 =B1168%=A0=A0=A0=A0 -97.6%=A0=A0=A0=A0=A0=A0 0.24 =B1 =
30%=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.do=
_user_addr_fault.exc_page_fault.asm_exc_page_fault=0A=
=A0=A0=A0 348.74 =B1136%=A0=A0=A0 +231.0%=A0=A0=A0=A0=A0=A0 1154 =B1 14%=A0=
 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.generic_=
perform_write.__generic_file_write_iter.generic_file_write_iter=0A=
=A0=A0=A0=A0=A0 5.86 =B1=A0 4%=A0=A0 +1071.7%=A0=A0=A0=A0=A0 68.64 =B1 19%=
=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.khuge=
paged.kthread.ret_from_fork=0A=
=A0=A0=A0=A0 38.63 =B1 52%=A0=A0=A0 +843.9%=A0=A0=A0=A0 364.62=A0=A0=A0=A0=
=A0=A0=A0 perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_pol=
l.do_epoll_wait.__x64_sys_epoll_wait=0A=
=A0=A0=A0=A0=A0 5.57 =B1=A0 6%=A0=A0=A0=A0 -20.3%=A0=A0=A0=A0=A0=A0 4.44 =
=B1=A0 6%=A0 perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kt=
hread.ret_from_fork=0A=
=A0=A0=A0=A0=A0 1.57 =B1 14%=A0=A0=A0 +683.9%=A0=A0=A0=A0=A0 12.28 =B1100%=
=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__all=
oc_pages_nodemask.alloc_pages_vma.do_anonymous_page=0A=
=A0=A0=A0=A0=A0 2468 =B1103%=A0=A0=A0=A0 -99.5%=A0=A0=A0=A0=A0 11.34 =B1 10=
%=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__al=
loc_pages_nodemask.alloc_pages_vma.shmem_alloc_page=0A=
=A0=A0=A0=A0=A0 3.91 =B1 14%=A0=A0=A0=A0 -41.4%=A0=A0=A0=A0=A0=A0 2.29 =B1=
=A0 6%=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched=
.down_read.__x64_sys_msync.do_syscall_64=0A=
=A0=A0=A0=A0=A0 7.68 =B1 17%=A0=A0 +1121.8%=A0=A0=A0=A0=A0 93.81 =B1 13%=A0=
 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.khugepag=
ed.kthread.ret_from_fork=0A=
=A0=A0=A0=A0 18.50 =B1 51%=A0=A0=A0 +272.3%=A0=A0=A0=A0=A0 68.88 =B1 22%=A0=
 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.remove_v=
ma.__do_munmap.__vm_munmap=0A=
=A0=A0=A0=A0 20.79 =B1 26%=A0=A0=A0 +217.3%=A0=A0=A0=A0=A0 65.97 =B1=A0 9%=
=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.unmap=
_vmas.unmap_region.__do_munmap=0A=
=A0=A0=A0 242.00 =B1 18%=A0=A0=A0=A0 -62.5%=A0=A0=A0=A0=A0 90.66 =B1 61%=A0=
 perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_fr=
om_fork=0A=
=A0 47358339 =B1=A0 7%=A0=A0=A0=A0 -10.5%=A0=A0 42382902 =B1=A0 2%=A0 perf-=
stat.i.branch-misses=0A=
=A0 19845519 =B1=A0 2%=A0=A0=A0=A0=A0 -8.5%=A0=A0 18156709 =B1=A0 3%=A0 per=
f-stat.i.cache-misses=0A=
=A0 1.72e+08=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -5.7%=A0 1.621e+08=A0=A0=A0=
=A0=A0=A0=A0 perf-stat.i.cache-references=0A=
=A0=A0=A0 725.90 =B1=A0 5%=A0=A0=A0=A0 -13.2%=A0=A0=A0=A0 630.12 =B1=A0 5%=
=A0 perf-stat.i.cpu-migrations=0A=
=A0 3.09e+09=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -4.3%=A0 2.957e+09=A0=A0=A0=
=A0=A0=A0=A0 perf-stat.i.dTLB-stores=0A=
=A0 19570792=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -6.2%=A0=A0 18352176=A0=A0=A0=
=A0=A0=A0=A0 perf-stat.i.iTLB-load-misses=0A=
=A0=A0=A0=A0 19871 =B1=A0 4%=A0=A0=A0=A0=A0 +9.8%=A0=A0=A0=A0=A0 21819 =B1=
=A0 3%=A0 perf-stat.i.instructions-per-iTLB-miss=0A=
=A0=A0=A0 382.70=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -3.0%=A0=A0=A0=A0 371.36 =
=B1=A0 2%=A0 perf-stat.i.metric.M/sec=0A=
=A0=A0 7111839 =B1=A0 4%=A0=A0=A0=A0 -11.4%=A0=A0=A0 6302363 =B1=A0 2%=A0 p=
erf-stat.i.node-load-misses=0A=
=A0=A0 8853002 =B1=A0 4%=A0=A0=A0=A0=A0 -9.6%=A0=A0=A0 8004893=A0=A0=A0=A0=
=A0=A0=A0 perf-stat.i.node-loads=0A=
=A0=A0 6500622=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -7.9%=A0=A0=A0 5986359 =B1=
=A0 4%=A0 perf-stat.i.node-store-misses=0A=
=A0=A0 8596412=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -6.5%=A0=A0=A0 8036645 =B1=
=A0 3%=A0 perf-stat.i.node-stores=0A=
=A0=A0=A0=A0=A0 5.60 =B1=A0 2%=A0=A0=A0=A0=A0 -3.9%=A0=A0=A0=A0=A0=A0 5.38=
=A0=A0=A0=A0=A0=A0=A0 perf-stat.overall.MPKI=0A=
=A0=A0=A0=A0=A0 0.63 =B1=A0 7%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.5=
7=A0=A0=A0=A0=A0=A0=A0 perf-stat.overall.branch-miss-rate%=0A=
=A0=A0=A0=A0=A0 5180 =B1=A0 2%=A0=A0=A0=A0=A0 +9.2%=A0=A0=A0=A0=A0=A0 5659 =
=B1=A0 3%=A0 perf-stat.overall.cycles-between-cache-misses=0A=
=A0=A0=A0=A0=A0 1575=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +4.8%=A0=A0=A0=A0=A0=
=A0 1651 =B1=A0 3%=A0 perf-stat.overall.instructions-per-iTLB-miss=0A=
=A0=A0=A0=A0 44.52=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -0.5=A0=A0=A0=A0=A0=A0 =
43.98=A0=A0=A0=A0=A0=A0=A0 perf-stat.overall.node-load-miss-rate%=0A=
=A0=A0=A0=A0 43.02=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -0.4=A0=A0=A0=A0=A0=A0 =
42.61=A0=A0=A0=A0=A0=A0=A0 perf-stat.overall.node-store-miss-rate%=0A=
=A0 47096030 =B1=A0 7%=A0=A0=A0=A0 -11.4%=A0=A0 41713545 =B1=A0 3%=A0 perf-=
stat.ps.branch-misses=0A=
=A0 19690067 =B1=A0 2%=A0=A0=A0=A0=A0 -9.4%=A0=A0 17836765 =B1=A0 3%=A0 per=
f-stat.ps.cache-misses=0A=
=A0=A0 1.7e+08 =B1=A0 2%=A0=A0=A0=A0=A0 -6.9%=A0 1.582e+08 =B1=A0 2%=A0 per=
f-stat.ps.cache-references=0A=
=A01.019e+11=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -1.1%=A0 1.008e+11=A0=A0=A0=
=A0=A0=A0=A0 perf-stat.ps.cpu-cycles=0A=
=A0=A0=A0 748.16 =B1=A0 5%=A0=A0=A0=A0 -11.3%=A0=A0=A0=A0 663.37 =B1=A0 5%=
=A0 perf-stat.ps.cpu-migrations=0A=
=A03.052e+09=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -5.5%=A0 2.885e+09 =B1=A0 2%=
=A0 perf-stat.ps.dTLB-stores=0A=
=A0 19264658=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -7.6%=A0=A0 17802646 =B1=A0 2=
%=A0 perf-stat.ps.iTLB-load-misses=0A=
=A0=A0 7041022 =B1=A0 4%=A0=A0=A0=A0 -12.4%=A0=A0=A0 6164936=A0=A0=A0=A0=A0=
=A0=A0 perf-stat.ps.node-load-misses=0A=
=A0=A0 8774703 =B1=A0 4%=A0=A0=A0=A0 -10.5%=A0=A0=A0 7851024=A0=A0=A0=A0=A0=
=A0=A0 perf-stat.ps.node-loads=0A=
=A0=A0 6428583=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -9.0%=A0=A0=A0 5851692 =B1=
=A0 4%=A0 perf-stat.ps.node-store-misses=0A=
=A0=A0 8513354=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -7.5%=A0=A0=A0 7878662 =B1=
=A0 4%=A0 perf-stat.ps.node-stores=0A=
=A0=A0=A0 793.75 =B1=A0 6%=A0=A0=A0=A0 -16.3%=A0=A0=A0=A0 664.33 =B1 12%=A0=
 interrupts.22:IO-APIC.22-fasteoi.ehci_hcd:usb1=0A=
=A0=A0=A0=A0 10846 =B1 12%=A0=A0=A0=A0 -22.7%=A0=A0=A0=A0=A0=A0 8387 =B1=A0=
 8%=A0 interrupts.CPU0.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 4222 =B1 14%=A0=A0=A0=A0 -49.6%=A0=A0=A0=A0=A0=A0 2128 =B1 =
43%=A0 interrupts.CPU1.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 4222 =B1 14%=A0=A0=A0=A0 -49.6%=A0=A0=A0=A0=A0=A0 2128 =B1 =
43%=A0 interrupts.CPU1.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0=A0 3219 =B1 28%=A0=A0=A0=A0 -21.0%=A0=A0=A0=A0=A0=A0 2544 =B1 =
29%=A0 interrupts.CPU10.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 3219 =B1 28%=A0=A0=A0=A0 -21.0%=A0=A0=A0=A0=A0=A0 2544 =B1 =
29%=A0 interrupts.CPU10.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0 12387 =B1=A0 8%=A0=A0=A0=A0 -10.7%=A0=A0=A0=A0=A0 11065 =B1 10=
%=A0 interrupts.CPU10.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3883 =B1 23%=A0=A0=A0=A0 -35.3%=A0=A0=A0=A0=A0=A0 2511 =B1 =
43%=A0 interrupts.CPU11.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 3883 =B1 23%=A0=A0=A0=A0 -35.3%=A0=A0=A0=A0=A0=A0 2511 =B1 =
43%=A0 interrupts.CPU11.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0 11453 =B1 37%=A0=A0=A0=A0 -34.1%=A0=A0=A0=A0=A0=A0 7553 =B1 14=
%=A0 interrupts.CPU12.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 2074 =B1126%=A0=A0=A0=A0 -77.6%=A0=A0=A0=A0 464.00 =B1=A0 9=
%=A0 interrupts.CPU12.RES:Rescheduling_interrupts=0A=
=A0=A0=A0=A0 13347 =B1 59%=A0=A0=A0=A0 -45.5%=A0=A0=A0=A0=A0=A0 7274 =B1 10=
%=A0 interrupts.CPU12.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0 11138 =B1 23%=A0=A0=A0=A0 -31.3%=A0=A0=A0=A0=A0=A0 7657 =B1 13=
%=A0 interrupts.CPU13.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 3399 =B1 34%=A0=A0=A0=A0 -29.1%=A0=A0=A0=A0=A0=A0 2410 =B1 =
50%=A0 interrupts.CPU15.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 3399 =B1 34%=A0=A0=A0=A0 -29.1%=A0=A0=A0=A0=A0=A0 2410 =B1 =
50%=A0 interrupts.CPU15.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0=A0 3318 =B1 29%=A0=A0=A0=A0 -25.3%=A0=A0=A0=A0=A0=A0 2479 =B1 =
34%=A0 interrupts.CPU16.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 3318 =B1 29%=A0=A0=A0=A0 -25.3%=A0=A0=A0=A0=A0=A0 2479 =B1 =
34%=A0 interrupts.CPU16.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0=A0 4574 =B1 17%=A0=A0=A0=A0 -58.7%=A0=A0=A0=A0=A0=A0 1890 =B1 =
29%=A0 interrupts.CPU20.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 4574 =B1 17%=A0=A0=A0=A0 -58.7%=A0=A0=A0=A0=A0=A0 1890 =B1 =
29%=A0 interrupts.CPU20.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0=A0 2768 =B1 37%=A0=A0=A0=A0 -44.7%=A0=A0=A0=A0=A0=A0 1531 =B1 =
30%=A0 interrupts.CPU22.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 2768 =B1 37%=A0=A0=A0=A0 -44.7%=A0=A0=A0=A0=A0=A0 1531 =B1 =
30%=A0 interrupts.CPU22.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 516.00 =B1 23%=A0=A0=A0=A0 -18.9%=A0=A0=A0=A0 418.33 =B1=A0 5%=A0=
 interrupts.CPU22.RES:Rescheduling_interrupts=0A=
=A0=A0=A0=A0=A0 3326 =B1 27%=A0=A0=A0=A0 -28.2%=A0=A0=A0=A0=A0=A0 2387 =B1 =
34%=A0 interrupts.CPU23.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 3326 =B1 27%=A0=A0=A0=A0 -28.2%=A0=A0=A0=A0=A0=A0 2387 =B1 =
34%=A0 interrupts.CPU23.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0=A0 3850 =B1 20%=A0=A0=A0=A0 -39.2%=A0=A0=A0=A0=A0=A0 2340 =B1 =
50%=A0 interrupts.CPU25.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 3850 =B1 20%=A0=A0=A0=A0 -39.2%=A0=A0=A0=A0=A0=A0 2340 =B1 =
50%=A0 interrupts.CPU25.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 859.25 =B1 48%=A0=A0=A0=A0 -46.0%=A0=A0=A0=A0 464.33 =B1=A0 5%=A0=
 interrupts.CPU25.RES:Rescheduling_interrupts=0A=
=A0=A0=A0=A0 13154 =B1 35%=A0=A0=A0=A0 -25.2%=A0=A0=A0=A0=A0=A0 9841 =B1 14=
%=A0 interrupts.CPU25.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3711 =B1 23%=A0=A0=A0=A0 -45.6%=A0=A0=A0=A0=A0=A0 2018 =B1 =
45%=A0 interrupts.CPU26.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 3711 =B1 23%=A0=A0=A0=A0 -45.6%=A0=A0=A0=A0=A0=A0 2018 =B1 =
45%=A0 interrupts.CPU26.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0=A0 4507 =B1=A0 4%=A0=A0=A0=A0 -43.3%=A0=A0=A0=A0=A0=A0 2556 =
=B1 40%=A0 interrupts.CPU27.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 4507 =B1=A0 4%=A0=A0=A0=A0 -43.3%=A0=A0=A0=A0=A0=A0 2556 =
=B1 40%=A0 interrupts.CPU27.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0 11363 =B1=A0 9%=A0=A0=A0=A0 -14.9%=A0=A0=A0=A0=A0=A0 9671 =B1=
=A0 8%=A0 interrupts.CPU27.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4430 =B1=A0 5%=A0=A0=A0=A0 -51.0%=A0=A0=A0=A0=A0=A0 2172 =
=B1 43%=A0 interrupts.CPU28.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 4430 =B1=A0 5%=A0=A0=A0=A0 -51.0%=A0=A0=A0=A0=A0=A0 2172 =
=B1 43%=A0 interrupts.CPU28.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0=A0 9512 =B1=A0 3%=A0=A0=A0=A0 -16.7%=A0=A0=A0=A0=A0=A0 7921 =
=B1=A0 8%=A0 interrupts.CPU29.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 3914 =B1 14%=A0=A0=A0=A0 -59.0%=A0=A0=A0=A0=A0=A0 1606 =B1 =
27%=A0 interrupts.CPU29.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 3914 =B1 14%=A0=A0=A0=A0 -59.0%=A0=A0=A0=A0=A0=A0 1606 =B1 =
27%=A0 interrupts.CPU29.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 998.00 =B1 77%=A0=A0=A0=A0 -55.5%=A0=A0=A0=A0 444.00 =B1=A0 2%=A0=
 interrupts.CPU29.RES:Rescheduling_interrupts=0A=
=A0=A0=A0=A0 11508 =B1 12%=A0=A0=A0=A0 -22.8%=A0=A0=A0=A0=A0=A0 8881 =B1 10=
%=A0 interrupts.CPU29.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3287 =B1 22%=A0=A0=A0=A0 -36.6%=A0=A0=A0=A0=A0=A0 2082 =B1 =
43%=A0 interrupts.CPU30.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 3287 =B1 22%=A0=A0=A0=A0 -36.6%=A0=A0=A0=A0=A0=A0 2082 =B1 =
43%=A0 interrupts.CPU30.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 571.75 =B1 12%=A0=A0=A0=A0 -21.0%=A0=A0=A0=A0 451.67 =B1 10%=A0 i=
nterrupts.CPU30.RES:Rescheduling_interrupts=0A=
=A0=A0=A0=A0 10554 =B1 20%=A0=A0=A0=A0 -26.5%=A0=A0=A0=A0=A0=A0 7757 =B1=A0=
 6%=A0 interrupts.CPU31.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 3521 =B1 21%=A0=A0=A0=A0 -47.8%=A0=A0=A0=A0=A0=A0 1838 =B1=
=A0 9%=A0 interrupts.CPU31.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 3521 =B1 21%=A0=A0=A0=A0 -47.8%=A0=A0=A0=A0=A0=A0 1838 =B1=
=A0 9%=A0 interrupts.CPU31.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 604.00 =B1 20%=A0=A0=A0=A0 -26.0%=A0=A0=A0=A0 447.00 =B1 14%=A0 i=
nterrupts.CPU31.RES:Rescheduling_interrupts=0A=
=A0=A0=A0=A0=A0 3946 =B1 21%=A0=A0=A0=A0 -51.9%=A0=A0=A0=A0=A0=A0 1898 =B1=
=A0 6%=A0 interrupts.CPU32.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 3946 =B1 21%=A0=A0=A0=A0 -51.9%=A0=A0=A0=A0=A0=A0 1898 =B1=
=A0 6%=A0 interrupts.CPU32.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0=A0 2221 =B1 74%=A0=A0=A0=A0 -74.2%=A0=A0=A0=A0 573.00 =B1 13%=
=A0 interrupts.CPU32.RES:Rescheduling_interrupts=0A=
=A0=A0=A0=A0=A0 2969 =B1 22%=A0=A0=A0=A0 -40.2%=A0=A0=A0=A0=A0=A0 1774 =B1 =
11%=A0 interrupts.CPU33.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 2969 =B1 22%=A0=A0=A0=A0 -40.2%=A0=A0=A0=A0=A0=A0 1774 =B1 =
11%=A0 interrupts.CPU33.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0 13653 =B1 16%=A0=A0=A0=A0 -40.8%=A0=A0=A0=A0=A0=A0 8079 =B1=A0=
 6%=A0 interrupts.CPU34.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 3074 =B1 20%=A0=A0=A0=A0 -41.7%=A0=A0=A0=A0=A0=A0 1791 =B1 =
18%=A0 interrupts.CPU34.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 3074 =B1 20%=A0=A0=A0=A0 -41.7%=A0=A0=A0=A0=A0=A0 1791 =B1 =
18%=A0 interrupts.CPU34.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0 18328 =B1 31%=A0=A0=A0=A0 -48.1%=A0=A0=A0=A0=A0=A0 9519 =B1=A0=
 7%=A0 interrupts.CPU34.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0 11937 =B1 21%=A0=A0=A0=A0 -36.1%=A0=A0=A0=A0=A0=A0 7623 =B1 15=
%=A0 interrupts.CPU35.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 3503 =B1 30%=A0=A0=A0=A0 -36.4%=A0=A0=A0=A0=A0=A0 2229 =B1 =
12%=A0 interrupts.CPU35.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 3503 =B1 30%=A0=A0=A0=A0 -36.4%=A0=A0=A0=A0=A0=A0 2229 =B1 =
12%=A0 interrupts.CPU35.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0 16203 =B1 41%=A0=A0=A0=A0 -47.9%=A0=A0=A0=A0=A0=A0 8444 =B1 15=
%=A0 interrupts.CPU35.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4311 =B1 20%=A0=A0=A0=A0 -43.4%=A0=A0=A0=A0=A0=A0 2440 =B1 =
50%=A0 interrupts.CPU37.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 4311 =B1 20%=A0=A0=A0=A0 -43.4%=A0=A0=A0=A0=A0=A0 2440 =B1 =
50%=A0 interrupts.CPU37.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0=A0 1028 =B1 98%=A0=A0=A0=A0 -60.6%=A0=A0=A0=A0 404.67 =B1=A0 5=
%=A0 interrupts.CPU37.RES:Rescheduling_interrupts=0A=
=A0=A0=A0=A0 11376 =B1 22%=A0=A0=A0=A0 -35.6%=A0=A0=A0=A0=A0=A0 7324 =B1=A0=
 2%=A0 interrupts.CPU37.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3390 =B1 35%=A0=A0=A0=A0 -35.8%=A0=A0=A0=A0=A0=A0 2177 =B1 =
50%=A0 interrupts.CPU38.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 3390 =B1 35%=A0=A0=A0=A0 -35.8%=A0=A0=A0=A0=A0=A0 2177 =B1 =
50%=A0 interrupts.CPU38.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0=A0 2077 =B1133%=A0=A0=A0=A0 -80.7%=A0=A0=A0=A0 401.33 =B1 12%=
=A0 interrupts.CPU38.RES:Rescheduling_interrupts=0A=
=A0=A0=A0=A0=A0 3760 =B1 19%=A0=A0=A0=A0 -54.3%=A0=A0=A0=A0=A0=A0 1716 =B1 =
66%=A0 interrupts.CPU39.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 3760 =B1 19%=A0=A0=A0=A0 -54.3%=A0=A0=A0=A0=A0=A0 1716 =B1 =
66%=A0 interrupts.CPU39.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0=A0 3338 =B1 68%=A0=A0=A0=A0 -85.1%=A0=A0=A0=A0 496.67 =B1 17%=
=A0 interrupts.CPU4.RES:Rescheduling_interrupts=0A=
=A0=A0=A0=A0=A0 3731 =B1 27%=A0=A0=A0=A0 -45.6%=A0=A0=A0=A0=A0=A0 2030 =B1 =
38%=A0 interrupts.CPU40.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 3731 =B1 27%=A0=A0=A0=A0 -45.6%=A0=A0=A0=A0=A0=A0 2030 =B1 =
38%=A0 interrupts.CPU40.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0=A0 4265 =B1=A0 5%=A0=A0=A0=A0 -43.5%=A0=A0=A0=A0=A0=A0 2409 =
=B1 45%=A0 interrupts.CPU42.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 4265 =B1=A0 5%=A0=A0=A0=A0 -43.5%=A0=A0=A0=A0=A0=A0 2409 =
=B1 45%=A0 interrupts.CPU42.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0=A0 3425 =B1 18%=A0=A0=A0=A0 -41.4%=A0=A0=A0=A0=A0=A0 2007 =B1 =
51%=A0 interrupts.CPU43.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 3425 =B1 18%=A0=A0=A0=A0 -41.4%=A0=A0=A0=A0=A0=A0 2007 =B1 =
51%=A0 interrupts.CPU43.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 627.00 =B1 46%=A0=A0=A0=A0 -43.4%=A0=A0=A0=A0 354.67 =B1=A0 2%=A0=
 interrupts.CPU43.RES:Rescheduling_interrupts=0A=
=A0=A0=A0=A0=A0 4679 =B1 13%=A0=A0=A0=A0 -71.6%=A0=A0=A0=A0=A0=A0 1331 =B1 =
21%=A0 interrupts.CPU44.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 4679 =B1 13%=A0=A0=A0=A0 -71.6%=A0=A0=A0=A0=A0=A0 1331 =B1 =
21%=A0 interrupts.CPU44.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 494.50 =B1 18%=A0=A0=A0=A0 -25.8%=A0=A0=A0=A0 367.00 =B1 15%=A0 i=
nterrupts.CPU44.RES:Rescheduling_interrupts=0A=
=A0=A0=A0=A0=A0 3975 =B1 18%=A0=A0=A0=A0 -43.4%=A0=A0=A0=A0=A0=A0 2249 =B1 =
46%=A0 interrupts.CPU45.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 3975 =B1 18%=A0=A0=A0=A0 -43.4%=A0=A0=A0=A0=A0=A0 2249 =B1 =
46%=A0 interrupts.CPU45.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0=A0 8711 =B1=A0 9%=A0=A0=A0=A0 -11.6%=A0=A0=A0=A0=A0=A0 7705=A0=
=A0=A0=A0=A0=A0=A0 interrupts.CPU46.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 3650 =B1 22%=A0=A0=A0=A0 -44.9%=A0=A0=A0=A0=A0=A0 2010 =B1 =
55%=A0 interrupts.CPU46.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 3650 =B1 22%=A0=A0=A0=A0 -44.9%=A0=A0=A0=A0=A0=A0 2010 =B1 =
55%=A0 interrupts.CPU46.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 440.75 =B1=A0 9%=A0=A0=A0=A0 -16.7%=A0=A0=A0=A0 367.00 =B1=A0 7%=
=A0 interrupts.CPU46.RES:Rescheduling_interrupts=0A=
=A0=A0=A0=A0=A0 7891 =B1 10%=A0=A0=A0=A0 -25.7%=A0=A0=A0=A0=A0=A0 5860 =B1 =
11%=A0 interrupts.CPU47.CAL:Function_call_interrupts=0A=
=A0=A0=A0 793.00 =B1 40%=A0=A0=A0=A0 -50.6%=A0=A0=A0=A0 392.00 =B1=A0 3%=A0=
 interrupts.CPU47.RES:Rescheduling_interrupts=0A=
=A0=A0=A0=A0=A0 2663 =B1 23%=A0=A0=A0=A0 -21.6%=A0=A0=A0=A0=A0=A0 2087 =B1=
=A0 7%=A0 interrupts.CPU5.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 2663 =B1 23%=A0=A0=A0=A0 -21.6%=A0=A0=A0=A0=A0=A0 2087 =B1=
=A0 7%=A0 interrupts.CPU5.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0 12129 =B1 30%=A0=A0=A0=A0 -32.7%=A0=A0=A0=A0=A0=A0 8164 =B1=A0=
 2%=A0 interrupts.CPU7.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0 14622 =B1 38%=A0=A0=A0=A0 -33.7%=A0=A0=A0=A0=A0=A0 9701 =B1=A0=
 6%=A0 interrupts.CPU7.TLB:TLB_shootdowns=0A=
=A0=A0=A0 793.75 =B1=A0 6%=A0=A0=A0=A0 -16.3%=A0=A0=A0=A0 664.33 =B1 12%=A0=
 interrupts.CPU8.22:IO-APIC.22-fasteoi.ehci_hcd:usb1=0A=
=A0=A0=A0=A0=A0 2516 =B1=A0 7%=A0=A0=A0=A0 +26.7%=A0=A0=A0=A0=A0=A0 3188 =
=B1 15%=A0 interrupts.CPU8.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 2516 =B1=A0 7%=A0=A0=A0=A0 +26.7%=A0=A0=A0=A0=A0=A0 3188 =
=B1 15%=A0 interrupts.CPU8.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0=A0 1784 =B1 54%=A0=A0=A0=A0 -58.8%=A0=A0=A0=A0 735.00 =B1=A0 4=
%=A0 interrupts.CPU8.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 656.75 =B1 18%=A0=A0=A0=A0 +51.0%=A0=A0=A0=A0 992.00 =B1 20%=A0 i=
nterrupts.CPU9.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 168231 =B1=A0 7%=A0=A0=A0=A0 -33.4%=A0=A0=A0=A0 112034 =B1 19%=A0=
 interrupts.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0 168231 =B1=A0 7%=A0=A0=A0=A0 -33.4%=A0=A0=A0=A0 112034 =B1 19%=A0=
 interrupts.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0=A0 7.01 =B1 14%=A0=A0=A0=A0=A0 -3.4=A0=A0=A0=A0=A0=A0=A0 3.60 =
=B1 50%=A0 perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.entry=
_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 4.21 =B1 21%=A0=A0=A0=A0=A0 -1.9=A0=A0=A0=A0=A0=A0=A0 2.29 =
=B1 63%=A0 perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.sysca=
ll_exit_to_user_mode.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 2.84 =B1 12%=A0=A0=A0=A0=A0 -1.9=A0=A0=A0=A0=A0=A0=A0 0.96 =
=B1 39%=A0 perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.e=
ntry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 4.06 =B1 21%=A0=A0=A0=A0=A0 -1.8=A0=A0=A0=A0=A0=A0=A0 2.23 =
=B1 65%=A0 perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode=
_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 2.64 =B1 13%=A0=A0=A0=A0=A0 -1.8=A0=A0=A0=A0=A0=A0=A0 0.87 =
=B1 40%=A0 perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.d=
o_syscall_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 3.84 =B1 22%=A0=A0=A0=A0=A0 -1.7=A0=A0=A0=A0=A0=A0=A0 2.13 =
=B1 67%=A0 perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_us=
er_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 1.49 =B1=A0 7%=A0=A0=A0=A0=A0 -0.9=A0=A0=A0=A0=A0=A0=A0 0.5=
4 =B1 70%=A0 perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.=
do_filp_open.do_sys_openat2.do_sys_open=0A=
=A0=A0=A0=A0=A0 1.46 =B1=A0 8%=A0=A0=A0=A0=A0 -0.9=A0=A0=A0=A0=A0=A0=A0 0.5=
3 =B1 70%=A0 perf-profile.calltrace.cycles-pp.__alloc_file.alloc_empty_file=
.path_openat.do_filp_open.do_sys_openat2=0A=
=A0=A0=A0=A0=A0 1.28 =B1=A0 5%=A0=A0=A0=A0=A0 -0.8=A0=A0=A0=A0=A0=A0=A0 0.5=
1 =B1 71%=A0 perf-profile.calltrace.cycles-pp.syscall_return_via_sysret=0A=
=A0=A0=A0=A0=A0 1.06 =B1=A0 6%=A0=A0=A0=A0=A0 -0.6=A0=A0=A0=A0=A0=A0=A0 0.4=
2 =B1 71%=A0 perf-profile.calltrace.cycles-pp.__entry_text_start=0A=
=A0=A0=A0=A0=A0 0.77 =B1 13%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 1.05 =
=B1 11%=A0 perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm=
_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle=0A=
=A0=A0=A0=A0=A0 0.82 =B1 12%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 1.12 =
=B1 11%=A0 perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt=
.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry=0A=
=A0=A0=A0=A0=A0 1.23 =B1 13%=A0=A0=A0=A0=A0 +0.4=A0=A0=A0=A0=A0=A0=A0 1.68 =
=B1 18%=A0 perf-profile.calltrace.cycles-pp.wait_for_xmitr.serial8250_conso=
le_putchar.uart_console_write.serial8250_console_write.console_unlock=0A=
=A0=A0=A0=A0=A0 1.23 =B1 13%=A0=A0=A0=A0=A0 +0.4=A0=A0=A0=A0=A0=A0=A0 1.68 =
=B1 18%=A0 perf-profile.calltrace.cycles-pp.serial8250_console_putchar.uart=
_console_write.serial8250_console_write.console_unlock.vprintk_emit=0A=
=A0=A0=A0=A0=A0 1.82 =B1 13%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 2.39 =
=B1 17%=A0 perf-profile.calltrace.cycles-pp.create_basic_memory_bitmaps.sna=
pshot_open.misc_open.chrdev_open.do_dentry_open=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=
=A0=A0 0.61 =B1 12%=A0 perf-profile.calltrace.cycles-pp.__sysvec_apic_timer=
_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_=
apic_timer_interrupt.cpuidle_enter_state=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=
=A0=A0 0.62 =B1 12%=A0 perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_=
stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_e=
nter_state.cpuidle_enter=0A=
=A0=A0=A0=A0=A0 4.96 =B1=A0 7%=A0=A0=A0=A0=A0 +1.7=A0=A0=A0=A0=A0=A0=A0 6.6=
9 =B1 19%=A0 perf-profile.calltrace.cycles-pp.mutex_spin_on_owner.__mutex_l=
ock.misc_open.chrdev_open.do_dentry_open=0A=
=A0=A0=A0=A0=A0 7.19 =B1 14%=A0=A0=A0=A0=A0 -3.4=A0=A0=A0=A0=A0=A0=A0 3.78 =
=B1 45%=A0 perf-profile.children.cycles-pp.syscall_exit_to_user_mode=0A=
=A0=A0=A0=A0=A0 3.03 =B1 53%=A0=A0=A0=A0=A0 -2.8=A0=A0=A0=A0=A0=A0=A0 0.24 =
=B1 21%=A0 perf-profile.children.cycles-pp.link_path_walk=0A=
=A0=A0=A0=A0=A0 4.28 =B1 21%=A0=A0=A0=A0=A0 -1.9=A0=A0=A0=A0=A0=A0=A0 2.35 =
=B1 61%=A0 perf-profile.children.cycles-pp.exit_to_user_mode_prepare=0A=
=A0=A0=A0=A0=A0 2.85 =B1 12%=A0=A0=A0=A0=A0 -1.9=A0=A0=A0=A0=A0=A0=A0 0.96 =
=B1 40%=A0 perf-profile.children.cycles-pp.ksys_mmap_pgoff=0A=
=A0=A0=A0=A0=A0 4.26 =B1 21%=A0=A0=A0=A0=A0 -1.9=A0=A0=A0=A0=A0=A0=A0 2.38 =
=B1 62%=A0 perf-profile.children.cycles-pp.task_work_run=0A=
=A0=A0=A0=A0=A0 2.65 =B1 13%=A0=A0=A0=A0=A0 -1.8=A0=A0=A0=A0=A0=A0=A0 0.88 =
=B1 40%=A0 perf-profile.children.cycles-pp.vm_mmap_pgoff=0A=
=A0=A0=A0=A0=A0 4.04 =B1 22%=A0=A0=A0=A0=A0 -1.8=A0=A0=A0=A0=A0=A0=A0 2.27 =
=B1 64%=A0 perf-profile.children.cycles-pp.__fput=0A=
=A0=A0=A0=A0=A0 1.69 =B1 54%=A0=A0=A0=A0=A0 -1.6=A0=A0=A0=A0=A0=A0=A0 0.13 =
=B1 22%=A0 perf-profile.children.cycles-pp.inode_permission=0A=
=A0=A0=A0=A0=A0 1.47 =B1 51%=A0=A0=A0=A0=A0 -1.3=A0=A0=A0=A0=A0=A0=A0 0.16 =
=B1=A0 3%=A0 perf-profile.children.cycles-pp.walk_component=0A=
=A0=A0=A0=A0=A0 1.33 =B1 54%=A0=A0=A0=A0=A0 -1.2=A0=A0=A0=A0=A0=A0=A0 0.11 =
=B1 14%=A0 perf-profile.children.cycles-pp.lookup_fast=0A=
=A0=A0=A0=A0=A0 1.49 =B1 27%=A0=A0=A0=A0=A0 -1.1=A0=A0=A0=A0=A0=A0=A0 0.36 =
=B1 28%=A0 perf-profile.children.cycles-pp._raw_spin_lock=0A=
=A0=A0=A0=A0=A0 1.49 =B1 31%=A0=A0=A0=A0=A0 -1.1=A0=A0=A0=A0=A0=A0=A0 0.40 =
=B1 48%=A0 perf-profile.children.cycles-pp.rwsem_down_write_slowpath=0A=
=A0=A0=A0=A0=A0 1.51 =B1 21%=A0=A0=A0=A0=A0 -1.1=A0=A0=A0=A0=A0=A0=A0 0.44 =
=B1 53%=A0 perf-profile.children.cycles-pp.down_write_killable=0A=
=A0=A0=A0=A0=A0 0.91 =B1 62%=A0=A0=A0=A0=A0 -0.9=A0=A0=A0=A0=A0=A0=A0 0.04 =
=B1 71%=A0 perf-profile.children.cycles-pp.hidraw_release=0A=
=A0=A0=A0=A0=A0 1.58 =B1=A0 8%=A0=A0=A0=A0=A0 -0.8=A0=A0=A0=A0=A0=A0=A0 0.7=
3 =B1 24%=A0 perf-profile.children.cycles-pp.alloc_empty_file=0A=
=A0=A0=A0=A0=A0 1.55 =B1=A0 9%=A0=A0=A0=A0=A0 -0.8=A0=A0=A0=A0=A0=A0=A0 0.7=
2 =B1 24%=A0 perf-profile.children.cycles-pp.__alloc_file=0A=
=A0=A0=A0=A0=A0 1.49 =B1=A0 5%=A0=A0=A0=A0=A0 -0.7=A0=A0=A0=A0=A0=A0=A0 0.7=
4 =B1 28%=A0 perf-profile.children.cycles-pp.syscall_return_via_sysret=0A=
=A0=A0=A0=A0=A0 1.26 =B1=A0 6%=A0=A0=A0=A0=A0 -0.6=A0=A0=A0=A0=A0=A0=A0 0.6=
3 =B1 27%=A0 perf-profile.children.cycles-pp.__entry_text_start=0A=
=A0=A0=A0=A0=A0 1.12 =B1=A0 9%=A0=A0=A0=A0=A0 -0.6=A0=A0=A0=A0=A0=A0=A0 0.5=
5 =B1 24%=A0 perf-profile.children.cycles-pp.kmem_cache_alloc=0A=
=A0=A0=A0=A0=A0 0.87 =B1 18%=A0=A0=A0=A0=A0 -0.6=A0=A0=A0=A0=A0=A0=A0 0.31 =
=B1 34%=A0 perf-profile.children.cycles-pp.do_mmap=0A=
=A0=A0=A0=A0=A0 0.63 =B1=A0 7%=A0=A0=A0=A0=A0 -0.4=A0=A0=A0=A0=A0=A0=A0 0.2=
2 =B1 25%=A0 perf-profile.children.cycles-pp.dput=0A=
=A0=A0=A0=A0=A0 0.55 =B1 17%=A0=A0=A0=A0=A0 -0.4=A0=A0=A0=A0=A0=A0=A0 0.15 =
=B1 34%=A0 perf-profile.children.cycles-pp.security_file_open=0A=
=A0=A0=A0=A0=A0 0.53 =B1 19%=A0=A0=A0=A0=A0 -0.4=A0=A0=A0=A0=A0=A0=A0 0.14 =
=B1 36%=A0 perf-profile.children.cycles-pp.apparmor_file_open=0A=
=A0=A0=A0=A0=A0 0.52 =B1 32%=A0=A0=A0=A0=A0 -0.4=A0=A0=A0=A0=A0=A0=A0 0.14 =
=B1 55%=A0 perf-profile.children.cycles-pp.rwsem_spin_on_owner=0A=
=A0=A0=A0=A0=A0 0.48 =B1 22%=A0=A0=A0=A0=A0 -0.4=A0=A0=A0=A0=A0=A0=A0 0.12 =
=B1 13%=A0 perf-profile.children.cycles-pp.ima_file_check=0A=
=A0=A0=A0=A0=A0 0.65 =B1=A0 7%=A0=A0=A0=A0=A0 -0.4=A0=A0=A0=A0=A0=A0=A0 0.2=
9 =B1 35%=A0 perf-profile.children.cycles-pp.__x64_sys_select=0A=
=A0=A0=A0=A0=A0 0.47 =B1 23%=A0=A0=A0=A0=A0 -0.4=A0=A0=A0=A0=A0=A0=A0 0.11 =
=B1 14%=A0 perf-profile.children.cycles-pp.security_task_getsecid=0A=
=A0=A0=A0=A0=A0 0.64 =B1=A0 7%=A0=A0=A0=A0=A0 -0.4=A0=A0=A0=A0=A0=A0=A0 0.2=
9 =B1 35%=A0 perf-profile.children.cycles-pp.kern_select=0A=
=A0=A0=A0=A0=A0 0.62 =B1 13%=A0=A0=A0=A0=A0 -0.3=A0=A0=A0=A0=A0=A0=A0 0.27 =
=B1 36%=A0 perf-profile.children.cycles-pp.__x64_sys_exit_group=0A=
=A0=A0=A0=A0=A0 0.62 =B1 12%=A0=A0=A0=A0=A0 -0.3=A0=A0=A0=A0=A0=A0=A0 0.28 =
=B1 33%=A0 perf-profile.children.cycles-pp.do_group_exit=0A=
=A0=A0=A0=A0=A0 0.62 =B1 12%=A0=A0=A0=A0=A0 -0.3=A0=A0=A0=A0=A0=A0=A0 0.28 =
=B1 33%=A0 perf-profile.children.cycles-pp.do_exit=0A=
=A0=A0=A0=A0=A0 0.45 =B1 24%=A0=A0=A0=A0=A0 -0.3=A0=A0=A0=A0=A0=A0=A0 0.11 =
=B1 19%=A0 perf-profile.children.cycles-pp.apparmor_task_getsecid=0A=
=A0=A0=A0=A0=A0 0.49 =B1 65%=A0=A0=A0=A0=A0 -0.3=A0=A0=A0=A0=A0=A0=A0 0.16 =
=B1 83%=A0 perf-profile.children.cycles-pp.__x64_sys_munmap=0A=
=A0=A0=A0=A0=A0 0.49 =B1 64%=A0=A0=A0=A0=A0 -0.3=A0=A0=A0=A0=A0=A0=A0 0.16 =
=B1 83%=A0 perf-profile.children.cycles-pp.__vm_munmap=0A=
=A0=A0=A0=A0=A0 0.48 =B1=A0 5%=A0=A0=A0=A0=A0 -0.3=A0=A0=A0=A0=A0=A0=A0 0.1=
6 =B1 34%=A0 perf-profile.children.cycles-pp.lockref_put_or_lock=0A=
=A0=A0=A0=A0=A0 0.51 =B1=A0 9%=A0=A0=A0=A0=A0 -0.3=A0=A0=A0=A0=A0=A0=A0 0.1=
9 =B1 15%=A0 perf-profile.children.cycles-pp.security_file_alloc=0A=
=A0=A0=A0=A0=A0 0.51 =B1=A0 7%=A0=A0=A0=A0=A0 -0.3=A0=A0=A0=A0=A0=A0=A0 0.2=
0 =B1 38%=A0 perf-profile.children.cycles-pp.__x64_sys_close=0A=
=A0=A0=A0=A0=A0 0.59 =B1 12%=A0=A0=A0=A0=A0 -0.3=A0=A0=A0=A0=A0=A0=A0 0.30 =
=B1 13%=A0 perf-profile.children.cycles-pp.__do_sys_clone=0A=
=A0=A0=A0=A0=A0 0.59 =B1 12%=A0=A0=A0=A0=A0 -0.3=A0=A0=A0=A0=A0=A0=A0 0.30 =
=B1 13%=A0 perf-profile.children.cycles-pp.kernel_clone=0A=
=A0=A0=A0=A0=A0 0.41 =B1 11%=A0=A0=A0=A0=A0 -0.3=A0=A0=A0=A0=A0=A0=A0 0.13 =
=B1 18%=A0 perf-profile.children.cycles-pp.apparmor_file_alloc_security=0A=
=A0=A0=A0=A0=A0 0.57 =B1 12%=A0=A0=A0=A0=A0 -0.3=A0=A0=A0=A0=A0=A0=A0 0.29 =
=B1 12%=A0 perf-profile.children.cycles-pp.copy_process=0A=
=A0=A0=A0=A0=A0 0.51 =B1=A0 8%=A0=A0=A0=A0=A0 -0.3=A0=A0=A0=A0=A0=A0=A0 0.2=
3 =B1 38%=A0 perf-profile.children.cycles-pp.core_sys_select=0A=
=A0=A0=A0=A0=A0 0.43 =B1 14%=A0=A0=A0=A0=A0 -0.3=A0=A0=A0=A0=A0=A0=A0 0.17 =
=B1 14%=A0 perf-profile.children.cycles-pp.mmput=0A=
=A0=A0=A0=A0=A0 0.43 =B1 14%=A0=A0=A0=A0=A0 -0.3=A0=A0=A0=A0=A0=A0=A0 0.17 =
=B1 14%=A0 perf-profile.children.cycles-pp.exit_mmap=0A=
=A0=A0=A0=A0=A0 0.45 =B1=A0 8%=A0=A0=A0=A0=A0 -0.3=A0=A0=A0=A0=A0=A0=A0 0.1=
9 =B1 35%=A0 perf-profile.children.cycles-pp.get_unmapped_area=0A=
=A0=A0=A0=A0=A0 0.40 =B1 17%=A0=A0=A0=A0=A0 -0.3=A0=A0=A0=A0=A0=A0=A0 0.14 =
=B1 20%=A0 perf-profile.children.cycles-pp.__do_sys_newfstat=0A=
=A0=A0=A0=A0=A0 0.50 =B1 13%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.26 =
=B1 12%=A0 perf-profile.children.cycles-pp.dup_mm=0A=
=A0=A0=A0=A0=A0 0.71 =B1=A0 9%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.4=
8 =B1 11%=A0 perf-profile.children.cycles-pp.do_softirq_own_stack=0A=
=A0=A0=A0=A0=A0 0.75 =B1 10%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.52 =
=B1 11%=A0 perf-profile.children.cycles-pp.irq_exit_rcu=0A=
=A0=A0=A0=A0=A0 0.49 =B1 12%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.26 =
=B1 12%=A0 perf-profile.children.cycles-pp.dup_mmap=0A=
=A0=A0=A0=A0=A0 0.41 =B1=A0 9%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.1=
9 =B1 36%=A0 perf-profile.children.cycles-pp.__fget_files=0A=
=A0=A0=A0=A0=A0 0.28 =B1 52%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.06 =
=B1 75%=A0 perf-profile.children.cycles-pp.mmap_region=0A=
=A0=A0=A0=A0=A0 0.35 =B1=A0 5%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.1=
4 =B1 34%=A0 perf-profile.children.cycles-pp.security_mmap_file=0A=
=A0=A0=A0=A0=A0 0.39 =B1=A0 7%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.1=
8 =B1 15%=A0 perf-profile.children.cycles-pp.getname_flags=0A=
=A0=A0=A0=A0=A0 0.32 =B1=A0 7%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.1=
2 =B1 35%=A0 perf-profile.children.cycles-pp.complete_walk=0A=
=A0=A0=A0=A0=A0 0.32 =B1=A0 7%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.1=
2 =B1 31%=A0 perf-profile.children.cycles-pp.unlazy_walk=0A=
=A0=A0=A0=A0=A0 0.29 =B1 22%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.09 =
=B1 27%=A0 perf-profile.children.cycles-pp.vfs_fstat=0A=
=A0=A0=A0=A0=A0 0.30 =B1 17%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.10 =
=B1 12%=A0 perf-profile.children.cycles-pp.security_file_free=0A=
=A0=A0=A0=A0=A0 0.28 =B1 21%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.08 =
=B1 14%=A0 perf-profile.children.cycles-pp.aa_get_task_label=0A=
=A0=A0=A0=A0=A0 0.29 =B1 17%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.09 =
=B1 14%=A0 perf-profile.children.cycles-pp.apparmor_file_free_security=0A=
=A0=A0=A0=A0=A0 0.25 =B1 32%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.06 =
=B1 13%=A0 perf-profile.children.cycles-pp.step_into=0A=
=A0=A0=A0=A0=A0 0.36 =B1 10%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.17 =
=B1 39%=A0 perf-profile.children.cycles-pp.do_select=0A=
=A0=A0=A0=A0=A0 0.33 =B1=A0 7%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.1=
4 =B1 34%=A0 perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown=
=0A=
=A0=A0=A0=A0=A0 0.29 =B1=A0 7%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.1=
0 =B1 31%=A0 perf-profile.children.cycles-pp.__legitimize_path=0A=
=A0=A0=A0=A0=A0 0.36 =B1 17%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.17 =
=B1=A0 7%=A0 perf-profile.children.cycles-pp.__schedule=0A=
=A0=A0=A0=A0=A0 0.29 =B1=A0 8%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.1=
1 =B1 40%=A0 perf-profile.children.cycles-pp.terminate_walk=0A=
=A0=A0=A0=A0=A0 0.34 =B1=A0 8%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.1=
7 =B1 34%=A0 perf-profile.children.cycles-pp.__fget_light=0A=
=A0=A0=A0=A0=A0 0.25 =B1 25%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.08 =
=B1 24%=A0 perf-profile.children.cycles-pp.may_open=0A=
=A0=A0=A0=A0=A0 0.25 =B1 18%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.08 =
=B1 35%=A0 perf-profile.children.cycles-pp.mutex_lock=0A=
=A0=A0=A0=A0=A0 0.35 =B1=A0 7%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.1=
8 =B1 50%=A0 perf-profile.children.cycles-pp.__alloc_pages_nodemask=0A=
=A0=A0=A0=A0=A0 0.39 =B1 13%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.22 =
=B1 24%=A0 perf-profile.children.cycles-pp.ksys_lseek=0A=
=A0=A0=A0=A0=A0 0.25 =B1 58%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.09 =
=B1 84%=A0 perf-profile.children.cycles-pp.__do_munmap=0A=
=A0=A0=A0=A0=A0 0.22 =B1=A0 8%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.0=
6 =B1 71%=A0 perf-profile.children.cycles-pp.lockref_get_not_dead=0A=
=A0=A0=A0=A0=A0 0.21 =B1 17%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.06 =
=B1 75%=A0 perf-profile.children.cycles-pp.cdev_put=0A=
=A0=A0=A0=A0=A0 0.25 =B1 10%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.10 =
=B1 38%=A0 perf-profile.children.cycles-pp.__close_fd=0A=
=A0=A0=A0=A0=A0 0.24 =B1 10%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.10 =
=B1 38%=A0 perf-profile.children.cycles-pp.pick_file=0A=
=A0=A0=A0=A0=A0 0.37 =B1 10%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.23 =
=B1 12%=A0 perf-profile.children.cycles-pp._raw_spin_lock_irqsave=0A=
=A0=A0=A0=A0=A0 0.27 =B1=A0 9%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.1=
3 =B1 33%=A0 perf-profile.children.cycles-pp.__alloc_fd=0A=
=A0=A0=A0=A0=A0 0.21 =B1 23%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.07 =
=B1 20%=A0 perf-profile.children.cycles-pp.free_pgtables=0A=
=A0=A0=A0=A0=A0 0.27 =B1 20%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.13 =
=B1=A0 9%=A0 perf-profile.children.cycles-pp.schedule=0A=
=A0=A0=A0=A0=A0 0.26 =B1=A0 7%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.1=
2 =B1 18%=A0 perf-profile.children.cycles-pp.strncpy_from_user=0A=
=A0=A0=A0=A0=A0 0.23 =B1 10%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.09 =
=B1 39%=A0 perf-profile.children.cycles-pp.filp_close=0A=
=A0=A0=A0=A0=A0 0.20 =B1 11%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.07 =
=B1 71%=A0 perf-profile.children.cycles-pp.vm_unmapped_area=0A=
=A0=A0=A0=A0=A0 0.25 =B1=A0 4%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.1=
2 =B1 29%=A0 perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack=0A=
=A0=A0=A0=A0=A0 0.17 =B1 16%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.04 =
=B1 76%=A0 perf-profile.children.cycles-pp.kobject_put=0A=
=A0=A0=A0=A0=A0 0.19 =B1 19%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.06 =
=B1 29%=A0 perf-profile.children.cycles-pp.copy_page_range=0A=
=A0=A0=A0=A0=A0 0.22 =B1 11%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.10 =
=B1 14%=A0 perf-profile.children.cycles-pp.try_to_wake_up=0A=
=A0=A0=A0=A0=A0 0.21 =B1=A0 9%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.0=
8 =B1 34%=A0 perf-profile.children.cycles-pp.common_file_perm=0A=
=A0=A0=A0=A0=A0 0.22 =B1 10%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.10 =
=B1 32%=A0 perf-profile.children.cycles-pp.fput_many=0A=
=A0=A0=A0=A0=A0 0.29 =B1 21%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.17 =
=B1 47%=A0 perf-profile.children.cycles-pp.drm_release=0A=
=A0=A0=A0=A0=A0 0.29 =B1 21%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.17 =
=B1 47%=A0 perf-profile.children.cycles-pp.drm_client_dev_restore=0A=
=A0=A0=A0=A0=A0 0.29 =B1 21%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.17 =
=B1 47%=A0 perf-profile.children.cycles-pp.drm_fbdev_client_restore=0A=
=A0=A0=A0=A0=A0 0.29 =B1 21%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.17 =
=B1 47%=A0 perf-profile.children.cycles-pp.__drm_fb_helper_restore_fbdev_mo=
de_unlocked=0A=
=A0=A0=A0=A0=A0 0.29 =B1 21%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.17 =
=B1 47%=A0 perf-profile.children.cycles-pp.drm_client_modeset_commit=0A=
=A0=A0=A0=A0=A0 0.29 =B1 21%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.17 =
=B1 47%=A0 perf-profile.children.cycles-pp.drm_client_modeset_commit_locked=
=0A=
=A0=A0=A0=A0=A0 0.29 =B1 21%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.17 =
=B1 47%=A0 perf-profile.children.cycles-pp.drm_client_modeset_commit_atomic=
=0A=
=A0=A0=A0=A0=A0 0.28 =B1=A0 4%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.1=
6 =B1 48%=A0 perf-profile.children.cycles-pp.get_page_from_freelist=0A=
=A0=A0=A0=A0=A0 0.20 =B1 15%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.08 =
=B1 30%=A0 perf-profile.children.cycles-pp.unmap_vmas=0A=
=A0=A0=A0=A0=A0 0.16 =B1 21%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.04 =
=B1 76%=A0 perf-profile.children.cycles-pp.copy_pte_range=0A=
=A0=A0=A0=A0=A0 0.18 =B1=A0 9%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.0=
7 =B1 71%=A0 perf-profile.children.cycles-pp.__x64_sys_fcntl=0A=
=A0=A0=A0=A0=A0 0.22 =B1=A0 7%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.1=
0 =B1 36%=A0 perf-profile.children.cycles-pp.__x64_sys_poll=0A=
=A0=A0=A0=A0=A0 0.22 =B1=A0 7%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.1=
0 =B1=A0 9%=A0 perf-profile.children.cycles-pp.__check_object_size=0A=
=A0=A0=A0=A0=A0 0.18 =B1 12%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.07 =
=B1 25%=A0 perf-profile.children.cycles-pp.unmap_page_range=0A=
=A0=A0=A0=A0=A0 0.20 =B1=A0 8%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.0=
9 =B1 33%=A0 perf-profile.children.cycles-pp.do_sys_poll=0A=
=A0=A0=A0=A0=A0 0.15 =B1=A0 7%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.0=
5 =B1 72%=A0 perf-profile.children.cycles-pp.__might_sleep=0A=
=A0=A0=A0=A0=A0 0.15 =B1=A0 8%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.0=
5 =B1 78%=A0 perf-profile.children.cycles-pp.obj_cgroup_charge=0A=
=A0=A0=A0=A0=A0 0.15 =B1=A0 9%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.0=
6 =B1 16%=A0 perf-profile.children.cycles-pp.zap_pte_range=0A=
=A0=A0=A0=A0=A0 0.17 =B1 20%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.07 =
=B1 72%=A0 perf-profile.children.cycles-pp.__slab_alloc=0A=
=A0=A0=A0=A0=A0 0.16 =B1 22%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.07 =
=B1 72%=A0 perf-profile.children.cycles-pp.___slab_alloc=0A=
=A0=A0=A0=A0=A0 0.14 =B1 19%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.04 =
=B1 71%=A0 perf-profile.children.cycles-pp.unlink_anon_vmas=0A=
=A0=A0=A0=A0=A0 0.17 =B1 38%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.07 =
=B1 74%=A0 perf-profile.children.cycles-pp.block_ioctl=0A=
=A0=A0=A0=A0=A0 0.16 =B1=A0 9%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.0=
7 =B1 20%=A0 perf-profile.children.cycles-pp.anon_vma_fork=0A=
=A0=A0=A0=A0=A0 0.18 =B1=A0 5%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.0=
9 =B1 18%=A0 perf-profile.children.cycles-pp.___might_sleep=0A=
=A0=A0=A0=A0=A0 0.14 =B1 32%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.05 =
=B1 81%=A0 perf-profile.children.cycles-pp.drm_stub_open=0A=
=A0=A0=A0=A0=A0 0.14 =B1 32%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.05 =
=B1 81%=A0 perf-profile.children.cycles-pp.drm_open=0A=
=A0=A0=A0=A0=A0 0.14 =B1 32%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.05 =
=B1 81%=A0 perf-profile.children.cycles-pp.drm_master_open=0A=
=A0=A0=A0=A0=A0 0.16 =B1=A0 9%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.0=
7 =B1 23%=A0 perf-profile.children.cycles-pp.get_obj_cgroup_from_current=0A=
=A0=A0=A0=A0=A0 0.16 =B1 38%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.07 =
=B1 74%=A0 perf-profile.children.cycles-pp.blkdev_ioctl=0A=
=A0=A0=A0=A0=A0 0.12 =B1 12%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.04 =
=B1 71%=A0 perf-profile.children.cycles-pp._cond_resched=0A=
=A0=A0=A0=A0=A0 0.12 =B1=A0 8%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.0=
4 =B1 73%=A0 perf-profile.children.cycles-pp.memset_erms=0A=
=A0=A0=A0=A0=A0 0.14 =B1 25%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.06 =
=B1 72%=A0 perf-profile.children.cycles-pp.allocate_slab=0A=
=A0=A0=A0=A0=A0 0.12 =B1 13%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.04 =
=B1 71%=A0 perf-profile.children.cycles-pp.call_rcu=0A=
=A0=A0=A0=A0=A0 0.17 =B1 25%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.09 =
=B1 50%=A0 perf-profile.children.cycles-pp.path_lookupat=0A=
=A0=A0=A0=A0=A0 0.17 =B1 30%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.10 =
=B1 61%=A0 perf-profile.children.cycles-pp.__fxstat64=0A=
=A0=A0=A0=A0=A0 0.11 =B1 12%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.03 =
=B1 70%=A0 perf-profile.children.cycles-pp.anon_vma_clone=0A=
=A0=A0=A0=A0=A0 0.11 =B1 10%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.03 =
=B1 70%=A0 perf-profile.children.cycles-pp.__mod_memcg_lruvec_state=0A=
=A0=A0=A0=A0=A0 0.15 =B1 16%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.08 =
=B1 10%=A0 perf-profile.children.cycles-pp.pick_next_task_fair=0A=
=A0=A0=A0=A0=A0 0.14 =B1=A0 6%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.0=
7 =B1 11%=A0 perf-profile.children.cycles-pp.syscall_enter_from_user_mode=
=0A=
=A0=A0=A0=A0=A0 0.10 =B1 12%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.03 =
=B1 70%=A0 perf-profile.children.cycles-pp.cp_new_stat=0A=
=A0=A0=A0=A0=A0 0.13 =B1 10%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.06 =
=B1 19%=A0 perf-profile.children.cycles-pp.__d_lookup_rcu=0A=
=A0=A0=A0=A0=A0 0.10 =B1 15%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.04 =
=B1 73%=A0 perf-profile.children.cycles-pp.generic_permission=0A=
=A0=A0=A0=A0=A0 0.14 =B1=A0 9%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.0=
8 =B1 20%=A0 perf-profile.children.cycles-pp.__x86_retpoline_rax=0A=
=A0=A0=A0=A0=A0 0.08 =B1=A0 5%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.0=
3 =B1 70%=A0 perf-profile.children.cycles-pp.ktime_get_ts64=0A=
=A0=A0=A0=A0=A0 0.09 =B1=A0 4%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.0=
4 =B1 71%=A0 perf-profile.children.cycles-pp.__might_fault=0A=
=A0=A0=A0=A0=A0 0.07 =B1 17%=A0=A0=A0=A0=A0 -0.0=A0=A0=A0=A0=A0=A0=A0 0.03 =
=B1 70%=A0 perf-profile.children.cycles-pp.schedule_timeout=0A=
=A0=A0=A0=A0=A0 0.11 =B1=A0 9%=A0=A0=A0=A0=A0 -0.0=A0=A0=A0=A0=A0=A0=A0 0.0=
8 =B1 12%=A0 perf-profile.children.cycles-pp.update_load_avg=0A=
=A0=A0=A0=A0=A0 0.09 =B1=A0 8%=A0=A0=A0=A0=A0 -0.0=A0=A0=A0=A0=A0=A0=A0 0.0=
6 =B1=A0 8%=A0 perf-profile.children.cycles-pp.newidle_balance=0A=
=A0=A0=A0=A0=A0 0.10 =B1 14%=A0=A0=A0=A0=A0 -0.0=A0=A0=A0=A0=A0=A0=A0 0.07 =
=B1=A0 7%=A0 perf-profile.children.cycles-pp.task_tick_fair=0A=
=A0=A0=A0=A0=A0 0.06 =B1 15%=A0=A0=A0=A0=A0 +0.0=A0=A0=A0=A0=A0=A0=A0 0.08 =
=B1 16%=A0 perf-profile.children.cycles-pp.tick_irq_enter=0A=
=A0=A0=A0=A0=A0 0.04 =B1 57%=A0=A0=A0=A0=A0 +0.0=A0=A0=A0=A0=A0=A0=A0 0.06=
=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.sched_clock_cpu=0A=
=A0=A0=A0=A0=A0 0.08 =B1 13%=A0=A0=A0=A0=A0 +0.0=A0=A0=A0=A0=A0=A0=A0 0.11 =
=B1=A0 4%=A0 perf-profile.children.cycles-pp.irq_enter_rcu=0A=
=A0=A0=A0=A0=A0 0.07 =B1=A0 5%=A0=A0=A0=A0=A0 +0.0=A0=A0=A0=A0=A0=A0=A0 0.1=
2 =B1 24%=A0 perf-profile.children.cycles-pp.clockevents_program_event=0A=
=A0=A0=A0=A0=A0 0.01 =B1173%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.07 =
=B1 18%=A0 perf-profile.children.cycles-pp.rebalance_domains=0A=
=A0=A0=A0=A0=A0 0.09 =B1=A0 4%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.1=
5 =B1 26%=A0 perf-profile.children.cycles-pp.ktime_get=0A=
=A0=A0=A0=A0=A0 0.16 =B1=A0 9%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.2=
3 =B1=A0 7%=A0 perf-profile.children.cycles-pp.menu_select=0A=
=A0=A0=A0=A0=A0 0.21 =B1 11%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.28 =
=B1 16%=A0 perf-profile.children.cycles-pp.io_serial_out=0A=
=A0=A0=A0=A0=A0 0.15 =B1 20%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.23 =
=B1=A0 6%=A0 perf-profile.children.cycles-pp.delay_tsc=0A=
=A0=A0=A0=A0=A0 1.83 =B1 14%=A0=A0=A0=A0=A0 +0.5=A0=A0=A0=A0=A0=A0=A0 2.38 =
=B1 12%=A0 perf-profile.children.cycles-pp.serial8250_console_putchar=0A=
=A0=A0=A0=A0=A0 1.85 =B1 14%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 2.40 =
=B1 12%=A0 perf-profile.children.cycles-pp.wait_for_xmitr=0A=
=A0=A0=A0=A0=A0 1.99 =B1 15%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 2.56 =
=B1 16%=A0 perf-profile.children.cycles-pp.__dynamic_pr_debug=0A=
=A0=A0=A0=A0=A0 1.82 =B1 13%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 2.39 =
=B1 17%=A0 perf-profile.children.cycles-pp.create_basic_memory_bitmaps=0A=
=A0=A0=A0=A0=A0 2.13 =B1 13%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 2.74 =
=B1 13%=A0 perf-profile.children.cycles-pp.console_unlock=0A=
=A0=A0=A0=A0=A0 2.03 =B1 13%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 2.65 =
=B1 12%=A0 perf-profile.children.cycles-pp.uart_console_write=0A=
=A0=A0=A0=A0=A0 2.17 =B1 15%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 2.79 =
=B1 14%=A0 perf-profile.children.cycles-pp.printk=0A=
=A0=A0=A0=A0=A0 2.17 =B1 15%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 2.79 =
=B1 14%=A0 perf-profile.children.cycles-pp.vprintk_emit=0A=
=A0=A0=A0=A0=A0 2.05 =B1 13%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 2.67 =
=B1 12%=A0 perf-profile.children.cycles-pp.serial8250_console_write=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +3.7=A0=A0=A0=A0=A0=
=A0=A0 3.73 =B1 66%=A0 perf-profile.children.cycles-pp.__cna_queued_spin_lo=
ck_slowpath=0A=
=A0=A0=A0=A0=A0 2.92 =B1=A0 6%=A0=A0=A0=A0=A0 -1.5=A0=A0=A0=A0=A0=A0=A0 1.4=
4 =B1 22%=A0 perf-profile.self.cycles-pp.syscall_exit_to_user_mode=0A=
=A0=A0=A0=A0=A0 1.48 =B1=A0 5%=A0=A0=A0=A0=A0 -0.7=A0=A0=A0=A0=A0=A0=A0 0.7=
4 =B1 28%=A0 perf-profile.self.cycles-pp.syscall_return_via_sysret=0A=
=A0=A0=A0=A0=A0 1.25 =B1=A0 6%=A0=A0=A0=A0=A0 -0.6=A0=A0=A0=A0=A0=A0=A0 0.6=
2 =B1 28%=A0 perf-profile.self.cycles-pp.__entry_text_start=0A=
=A0=A0=A0=A0=A0 0.52 =B1 18%=A0=A0=A0=A0=A0 -0.4=A0=A0=A0=A0=A0=A0=A0 0.13 =
=B1 34%=A0 perf-profile.self.cycles-pp.apparmor_file_open=0A=
=A0=A0=A0=A0=A0 0.50 =B1 32%=A0=A0=A0=A0=A0 -0.4=A0=A0=A0=A0=A0=A0=A0 0.13 =
=B1 54%=A0 perf-profile.self.cycles-pp.rwsem_spin_on_owner=0A=
=A0=A0=A0=A0=A0 0.44 =B1=A0 5%=A0=A0=A0=A0=A0 -0.3=A0=A0=A0=A0=A0=A0=A0 0.1=
3 =B1 36%=A0 perf-profile.self.cycles-pp.lockref_put_or_lock=0A=
=A0=A0=A0=A0=A0 0.38 =B1 12%=A0=A0=A0=A0=A0 -0.3=A0=A0=A0=A0=A0=A0=A0 0.12 =
=B1 18%=A0 perf-profile.self.cycles-pp.apparmor_file_alloc_security=0A=
=A0=A0=A0=A0=A0 0.52 =B1=A0 4%=A0=A0=A0=A0=A0 -0.3=A0=A0=A0=A0=A0=A0=A0 0.2=
7 =B1 25%=A0 perf-profile.self.cycles-pp._raw_spin_lock=0A=
=A0=A0=A0=A0=A0 0.28 =B1 22%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.05 =
=B1 72%=A0 perf-profile.self.cycles-pp.aa_get_task_label=0A=
=A0=A0=A0=A0=A0 0.45 =B1=A0 7%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.2=
4 =B1 20%=A0 perf-profile.self.cycles-pp.kmem_cache_alloc=0A=
=A0=A0=A0=A0=A0 0.39 =B1 10%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.19 =
=B1 36%=A0 perf-profile.self.cycles-pp.__fget_files=0A=
=A0=A0=A0=A0=A0 0.28 =B1 19%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.08 =
=B1 11%=A0 perf-profile.self.cycles-pp.apparmor_file_free_security=0A=
=A0=A0=A0=A0=A0 0.30 =B1=A0 8%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.1=
1 =B1 36%=A0 perf-profile.self.cycles-pp.do_dentry_open=0A=
=A0=A0=A0=A0=A0 0.21 =B1 21%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.04 =
=B1 76%=A0 perf-profile.self.cycles-pp.mutex_lock=0A=
=A0=A0=A0=A0=A0 0.20 =B1=A0 3%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.0=
6 =B1 71%=A0 perf-profile.self.cycles-pp.lockref_get_not_dead=0A=
=A0=A0=A0=A0=A0 0.20 =B1 11%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.06 =
=B1 73%=A0 perf-profile.self.cycles-pp.vm_unmapped_area=0A=
=A0=A0=A0=A0=A0 0.18 =B1=A0 8%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.0=
6 =B1 73%=A0 perf-profile.self.cycles-pp.common_file_perm=0A=
=A0=A0=A0=A0=A0 0.17 =B1 14%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.04 =
=B1 76%=A0 perf-profile.self.cycles-pp.kobject_put=0A=
=A0=A0=A0=A0=A0 0.27 =B1 15%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.15 =
=B1 25%=A0 perf-profile.self.cycles-pp.__alloc_file=0A=
=A0=A0=A0=A0=A0 0.16 =B1 39%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.05 =
=B1 78%=A0 perf-profile.self.cycles-pp.rwsem_down_write_slowpath=0A=
=A0=A0=A0=A0=A0 0.16 =B1 11%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.05 =
=B1 77%=A0 perf-profile.self.cycles-pp.fput_many=0A=
=A0=A0=A0=A0=A0 0.14 =B1=A0 7%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.0=
4 =B1 71%=A0 perf-profile.self.cycles-pp.__might_sleep=0A=
=A0=A0=A0=A0=A0 0.18 =B1=A0 5%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.0=
9 =B1 30%=A0 perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 0.14 =B1 11%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.04 =
=B1 71%=A0 perf-profile.self.cycles-pp.do_sys_openat2=0A=
=A0=A0=A0=A0=A0 0.15 =B1=A0 5%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.0=
6 =B1 73%=A0 perf-profile.self.cycles-pp.__fput=0A=
=A0=A0=A0=A0=A0 0.20 =B1=A0 5%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.1=
1 =B1 31%=A0 perf-profile.self.cycles-pp._raw_spin_lock_irqsave=0A=
=A0=A0=A0=A0=A0 0.13 =B1 14%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.04 =
=B1 70%=A0 perf-profile.self.cycles-pp.link_path_walk=0A=
=A0=A0=A0=A0=A0 0.18 =B1=A0 8%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.0=
9 =B1 18%=A0 perf-profile.self.cycles-pp.___might_sleep=0A=
=A0=A0=A0=A0=A0 0.13 =B1 14%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.04 =
=B1 71%=A0 perf-profile.self.cycles-pp.get_obj_cgroup_from_current=0A=
=A0=A0=A0=A0=A0 0.12 =B1=A0 6%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.0=
4 =B1 73%=A0 perf-profile.self.cycles-pp.do_mmap=0A=
=A0=A0=A0=A0=A0 0.12 =B1 10%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.05 =
=B1 71%=A0 perf-profile.self.cycles-pp.__x86_retpoline_rax=0A=
=A0=A0=A0=A0=A0 0.12 =B1 24%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.05 =
=B1 72%=A0 perf-profile.self.cycles-pp.allocate_slab=0A=
=A0=A0=A0=A0=A0 0.12 =B1=A0 8%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.0=
6 =B1 19%=A0 perf-profile.self.cycles-pp.__d_lookup_rcu=0A=
=A0=A0=A0=A0=A0 0.10 =B1 13%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.04 =
=B1 71%=A0 perf-profile.self.cycles-pp.generic_permission=0A=
=A0=A0=A0=A0=A0 0.09 =B1=A0 8%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.0=
4 =B1 71%=A0 perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack=0A=
=A0=A0=A0=A0=A0 0.10 =B1=A0 4%=A0=A0=A0=A0=A0 -0.0=A0=A0=A0=A0=A0=A0=A0 0.0=
5 =B1=A0 8%=A0 perf-profile.self.cycles-pp.syscall_enter_from_user_mode=0A=
=A0=A0=A0=A0=A0 0.07 =B1 17%=A0=A0=A0=A0=A0 +0.0=A0=A0=A0=A0=A0=A0=A0 0.11 =
=B1=A0 8%=A0 perf-profile.self.cycles-pp.cpuidle_enter_state=0A=
=A0=A0=A0=A0=A0 0.10 =B1=A0 9%=A0=A0=A0=A0=A0 +0.0=A0=A0=A0=A0=A0=A0=A0 0.1=
4 =B1 10%=A0 perf-profile.self.cycles-pp.menu_select=0A=
=A0=A0=A0=A0=A0 0.03 =B1100%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.09 =
=B1 36%=A0 perf-profile.self.cycles-pp.ktime_get=0A=
=A0=A0=A0=A0=A0 0.15 =B1 20%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.23 =
=B1=A0 6%=A0 perf-profile.self.cycles-pp.delay_tsc=0A=
=A0=A0=A0=A0=A0 0.20 =B1 16%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.28 =
=B1 16%=A0 perf-profile.self.cycles-pp.io_serial_out=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +3.7=A0=A0=A0=A0=A0=
=A0=A0 3.73 =B1 66%=A0 perf-profile.self.cycles-pp.__cna_queued_spin_lock_s=
lowpath=0A=
=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 stress-ng.zero.ops_per_sec=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =0A=
=A0 400000 +---------------------------------------------------------------=
---+=A0=A0 =0A=
=A0=A0=A0=A0=A0=A0=A0=A0 |.+.. .+..=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 .+..+.=A0 .+.+..=A0=A0=A0=A0=A0=A0 +..=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 |=A0=A0 =0A=
=A0 350000 |-+=A0 +=A0=A0=A0 +=A0=A0=A0 +.+..+.+.. .+..+=A0=A0=A0 O +. O O=
=A0 +.+..O+O=A0 +.+..+.+..+.|=A0=A0 =0A=
=A0=A0=A0=A0=A0=A0=A0=A0 | O=A0=A0=A0=A0=A0=A0 : O=A0 : O=A0=A0=A0 O=A0 +=
=A0=A0=A0 O O=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +=A0=A0=A0=A0=
=A0 O=A0 O O=A0=A0=A0 |=A0=A0 =0A=
=A0 300000 |-+=A0=A0=A0=A0=A0=A0 :=A0=A0=A0 :=A0=A0=A0 O=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 =0A=
=A0 250000 |-+=A0=A0=A0=A0=A0=A0=A0 :=A0 :=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 =0A=
=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0 :=A0 :=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 =0A=
=A0 200000 |-+=A0=A0=A0=A0=A0=A0=A0 :=A0 :=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 =0A=
=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0 :=A0 :=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 =0A=
=A0 150000 |-+=A0=A0=A0=A0=A0=A0=A0 : :=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 =0A=
=A0 100000 |-+=A0=A0=A0=A0=A0=A0=A0 : :=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 =0A=
=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ::=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 =
=0A=
=A0=A0 50000 |-+=A0=A0=A0=A0=A0=A0=A0=A0 ::=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 =0A=
=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 :=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=
=A0 =0A=
=A0=A0=A0=A0=A0=A0 0 +-----------------------------------------------------=
-------------+=A0=A0 =0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =0A=
[*] bisect-good sample=0A=
[O] bisect-bad=A0 sample=0A=
=0A=
***************************************************************************=
************************=0A=
lkp-csl-2ap2: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with=
 192G memory=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
compiler/cpufreq_governor/disk/filesize/fs/iterations/kconfig/nr_threads/ro=
otfs/sync_method/tbox_group/test_size/testcase/ucode:=0A=
=A0 gcc-9/performance/1BRD_48G/4M/btrfs/1x/x86_64-rhel-8.3/64t/debian-10.4-=
x86_64-20200603.cgz/NoSync/lkp-csl-2ap2/24G/fsmark/0x5003003=0A=
=0A=
commit: =0A=
=A0 cb45bab007 ("locking/qspinlock: Refactor the qspinlock slow path")=0A=
=A0 0e8d8f4f12 ("locking/qspinlock: Introduce CNA into the slow path of qsp=
inlock")=0A=
=0A=
cb45bab007ff0cfc 0e8d8f4f1214cfbac219d6917b5 =0A=
---------------- --------------------------- =0A=
=A0=A0=A0=A0=A0=A0=A0=A0 %stddev=A0=A0=A0=A0 %change=A0=A0=A0=A0=A0=A0=A0=
=A0 %stddev=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=A0 =0A=
=A0=A0=A0=A0=A0 1180 =B1=A0 2%=A0=A0=A0 +213.9%=A0=A0=A0=A0=A0=A0 3706 =B1 =
11%=A0 fsmark.files_per_sec=0A=
=A0=A0=A0 773.00 =B1=A0 4%=A0=A0=A0=A0 -30.2%=A0=A0=A0=A0 539.75 =B1=A0 7%=
=A0 fsmark.time.percent_of_cpu_this_job_got=0A=
=A0=A0=A0 137.19 =B1=A0 3%=A0=A0=A0=A0 -28.5%=A0=A0=A0=A0=A0 98.13 =B1=A0 8=
%=A0 fsmark.time.system_time=0A=
=A0=A0=A0=A0 48917 =B1=A0 4%=A0=A0=A0=A0=A0 -9.0%=A0=A0=A0=A0=A0 44537 =B1=
=A0 8%=A0 meminfo.AnonHugePages=0A=
=A0=A0=A0=A0=A0 4.83 =B1=A0 4%=A0=A0=A0=A0=A0 -1.0=A0=A0=A0=A0=A0=A0=A0 3.8=
3 =B1=A0 5%=A0 mpstat.cpu.all.sys%=0A=
=A0=A0=A0=A0 93.48=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.1%=A0=A0=A0=A0=A0 94=
.51=A0=A0=A0=A0=A0=A0=A0 iostat.cpu.idle=0A=
=A0=A0=A0=A0=A0 5.76 =B1=A0 2%=A0=A0=A0=A0 -16.9%=A0=A0=A0=A0=A0=A0 4.79 =
=B1=A0 6%=A0 iostat.cpu.system=0A=
=A0=A0=A0=A0 93.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.1%=A0=A0=A0=A0=A0 94=
.00=A0=A0=A0=A0=A0=A0=A0 vmstat.cpu.id=0A=
=A0=A0=A0=A0 20606 =B1=A0 5%=A0=A0=A0=A0 +97.4%=A0=A0=A0=A0=A0 40682 =B1 34=
%=A0 vmstat.system.cs=0A=
=A0=A0 4237881 =B1 29%=A0=A0=A0 +321.3%=A0=A0 17854499 =B1106%=A0 cpuidle.C=
1.time=0A=
=A0=A0=A0=A0 44169 =B1 32%=A0=A0=A0 +396.5%=A0=A0=A0=A0 219318 =B1113%=A0 c=
puidle.C1.usage=0A=
=A0=A0=A0=A0 72208 =B1=A0 6%=A0=A0=A0 +191.8%=A0=A0=A0=A0 210719 =B1 39%=A0=
 cpuidle.POLL.time=0A=
=A0=A0=A0=A0 36708 =B1=A0 9%=A0=A0=A0 +306.0%=A0=A0=A0=A0 149034 =B1 48%=A0=
 cpuidle.POLL.usage=0A=
=A0=A0=A0=A0=A0 2157 =B1=A0 2%=A0=A0=A0=A0 +13.8%=A0=A0=A0=A0=A0=A0 2454 =
=B1=A0 6%=A0 slabinfo.biovec-max.active_objs=0A=
=A0=A0=A0=A0=A0 2271 =B1=A0 2%=A0=A0=A0=A0 +12.8%=A0=A0=A0=A0=A0=A0 2561 =
=B1=A0 5%=A0 slabinfo.biovec-max.num_objs=0A=
=A0=A0=A0=A0=A0 6624=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +13.4%=A0=A0=A0=A0=A0=A0=
 7512 =B1=A0 5%=A0 slabinfo.btrfs_delayed_node.active_objs=0A=
=A0=A0=A0=A0=A0 6768=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +12.1%=A0=A0=A0=A0=A0=A0=
 7589 =B1=A0 5%=A0 slabinfo.btrfs_delayed_node.num_objs=0A=
=A0=A0=A0=A0 47815 =B1 86%=A0=A0=A0=A0 -89.2%=A0=A0=A0=A0=A0=A0 5149 =B1=A0=
 6%=A0 sched_debug.cfs_rq:/.load.stddev=0A=
=A0=A0=A0 142.69 =B1 15%=A0=A0=A0=A0 +66.8%=A0=A0=A0=A0 237.99 =B1 13%=A0 s=
ched_debug.cfs_rq:/.load_avg.avg=0A=
=A0=A0=A0=A0=A0 1598 =B1 30%=A0=A0=A0=A0 +92.4%=A0=A0=A0=A0=A0=A0 3075 =B1 =
20%=A0 sched_debug.cfs_rq:/.load_avg.max=0A=
=A0=A0=A0 383.38 =B1 21%=A0=A0=A0=A0 +90.4%=A0=A0=A0=A0 730.10 =B1 13%=A0 s=
ched_debug.cfs_rq:/.load_avg.stddev=0A=
=A0=A0=A0=A0 37712 =B1 16%=A0=A0=A0=A0 -27.1%=A0=A0=A0=A0=A0 27508 =B1 16%=
=A0 sched_debug.cfs_rq:/.min_vruntime.avg=0A=
=A0=A0=A0=A0 58.89 =B1 49%=A0=A0=A0=A0 +57.8%=A0=A0=A0=A0=A0 92.96 =B1=A0 5=
%=A0 sched_debug.cfs_rq:/.util_est_enqueued.stddev=0A=
=A0=A0=A0=A0=A0 1901 =B1=A0 4%=A0=A0=A0=A0=A0 -8.3%=A0=A0=A0=A0=A0=A0 1743 =
=B1=A0 3%=A0 proc-vmstat.nr_active_anon=0A=
=A0=A0 5055884=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +3.2%=A0=A0=A0 5219972=A0=
=A0=A0=A0=A0=A0=A0 proc-vmstat.nr_file_pages=0A=
=A0=A0 4788961 =B1=A0 2%=A0=A0=A0=A0=A0 +3.4%=A0=A0=A0 4953360=A0=A0=A0=A0=
=A0=A0=A0 proc-vmstat.nr_inactive_file=0A=
=A0=A0=A0=A0 36576 =B1=A0 2%=A0=A0=A0=A0=A0 -4.1%=A0=A0=A0=A0=A0 35069=A0=
=A0=A0=A0=A0=A0=A0 proc-vmstat.nr_kernel_stack=0A=
=A0=A0=A0=A0=A0 9756=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -1.6%=A0=A0=A0=A0=A0=
=A0 9601=A0=A0=A0=A0=A0=A0=A0 proc-vmstat.nr_mapped=0A=
=A0=A0=A0=A0=A0 5205 =B1=A0 2%=A0=A0=A0=A0=A0 -5.1%=A0=A0=A0=A0=A0=A0 4939=
=A0=A0=A0=A0=A0=A0=A0 proc-vmstat.nr_shmem=0A=
=A0=A0=A0=A0=A0 1901 =B1=A0 4%=A0=A0=A0=A0=A0 -8.3%=A0=A0=A0=A0=A0=A0 1743 =
=B1=A0 3%=A0 proc-vmstat.nr_zone_active_anon=0A=
=A0=A0 4788961 =B1=A0 2%=A0=A0=A0=A0=A0 +3.4%=A0=A0=A0 4953360=A0=A0=A0=A0=
=A0=A0=A0 proc-vmstat.nr_zone_inactive_file=0A=
=A0=A0=A0=A0=A0 4864 =B1=A0 5%=A0=A0=A0=A0=A0 -8.2%=A0=A0=A0=A0=A0=A0 4465=
=A0=A0=A0=A0=A0=A0=A0 proc-vmstat.pgactivate=0A=
=A02.507e+09=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -8.7%=A0=A0 2.29e+09=A0=A0=A0=
=A0=A0=A0=A0 perf-stat.i.branch-instructions=0A=
=A0 71942409=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -5.3%=A0=A0 68125925 =B1=A0 2=
%=A0 perf-stat.i.cache-misses=0A=
=A04.372e+10=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -18.5%=A0 3.565e+10 =B1=A0 3%=A0=
 perf-stat.i.cpu-cycles=0A=
=A01.231e+10=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -7.5%=A0 1.138e+10=A0=A0=A0=
=A0=A0=A0=A0 perf-stat.i.instructions=0A=
=A0=A0=A0=A0=A0 2515 =B1=A0 8%=A0=A0=A0=A0 -11.4%=A0=A0=A0=A0=A0=A0 2228 =
=B1=A0 5%=A0 perf-stat.i.instructions-per-iTLB-miss=0A=
=A0=A0=A0=A0=A0 0.23=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -17.3%=A0=A0=A0=A0=A0=A0=
 0.19 =B1=A0 3%=A0 perf-stat.i.metric.GHz=0A=
=A0=A0=A0=A0=A0 0.71 =B1 19%=A0=A0=A0=A0 +37.6%=A0=A0=A0=A0=A0=A0 0.97 =B1 =
17%=A0 perf-stat.i.metric.K/sec=0A=
=A0=A0=A0=A0 35.43=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -6.2%=A0=A0=A0=A0=A0 33=
.24 =B1=A0 2%=A0 perf-stat.i.metric.M/sec=0A=
=A0=A0=A0=A0=A0 3.58=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -8.5%=A0=A0=A0=A0=A0=
=A0 3.28=A0=A0=A0=A0=A0=A0=A0 perf-stat.overall.cpi=0A=
=A0=A0=A0 612.62=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -9.0%=A0=A0=A0=A0 557.36 =
=B1=A0 3%=A0 perf-stat.overall.cycles-between-cache-misses=0A=
=A0=A0=A0=A0=A0 2610 =B1=A0 6%=A0=A0=A0=A0 -11.9%=A0=A0=A0=A0=A0=A0 2299 =
=B1=A0 4%=A0 perf-stat.overall.instructions-per-iTLB-miss=0A=
=A0=A0=A0=A0=A0 0.28=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +9.3%=A0=A0=A0=A0=A0=
=A0 0.31=A0=A0=A0=A0=A0=A0=A0 perf-stat.overall.ipc=0A=
=A0 2.39e+09 =B1=A0 2%=A0=A0=A0=A0=A0 -6.3%=A0 2.239e+09=A0=A0=A0=A0=A0=A0=
=A0 perf-stat.ps.branch-instructions=0A=
=A0 68534728 =B1=A0 2%=A0=A0=A0=A0=A0 -4.6%=A0=A0 65359103 =B1=A0 2%=A0 per=
f-stat.ps.cache-misses=0A=
=A04.199e+10 =B1=A0 2%=A0=A0=A0=A0 -13.3%=A0 3.641e+10=A0=A0=A0=A0=A0=A0=A0=
 perf-stat.ps.cpu-cycles=0A=
=A01.173e+10 =B1=A0 2%=A0=A0=A0=A0=A0 -5.3%=A0 1.112e+10=A0=A0=A0=A0=A0=A0=
=A0 perf-stat.ps.instructions=0A=
=A0=A0=A0 226946 =B1 18%=A0=A0=A0=A0 +44.8%=A0=A0=A0=A0 328685 =B1 19%=A0 n=
uma-meminfo.node0.AnonPages=0A=
=A0=A0=A0 249710 =B1 18%=A0=A0=A0=A0 +41.9%=A0=A0=A0=A0 354296 =B1 20%=A0 n=
uma-meminfo.node0.AnonPages.max=0A=
=A0=A0=A0 233745 =B1 17%=A0=A0=A0=A0 +42.0%=A0=A0=A0=A0 331984 =B1 20%=A0 n=
uma-meminfo.node0.Inactive(anon)=0A=
=A0=A0=A0=A0=A0 8680 =B1 73%=A0=A0=A0 +135.9%=A0=A0=A0=A0=A0 20474 =B1 28%=
=A0 numa-meminfo.node0.PageTables=0A=
=A0=A0=A0 250653 =B1=A0 2%=A0=A0=A0=A0=A0 +6.8%=A0=A0=A0=A0 267784 =B1=A0 5=
%=A0 numa-meminfo.node0.Unevictable=0A=
=A0=A0 2890241 =B1=A0 9%=A0=A0=A0=A0 -58.3%=A0=A0=A0 1206212 =B1 10%=A0 num=
a-meminfo.node0.Writeback=0A=
=A0=A0=A0 338312 =B1 83%=A0=A0=A0 +111.9%=A0=A0=A0=A0 716979 =B1 64%=A0 num=
a-meminfo.node1.Dirty=0A=
=A0=A0=A0=A0=A0 8444 =B1 82%=A0=A0=A0 +169.8%=A0=A0=A0=A0=A0 22785 =B1 37%=
=A0 numa-meminfo.node2.AnonHugePages=0A=
=A0=A0=A0 236489 =B1 16%=A0=A0=A0 +142.5%=A0=A0=A0=A0 573382 =B1 36%=A0 num=
a-meminfo.node2.Dirty=0A=
=A0=A0 2484617 =B1 13%=A0=A0=A0 +117.6%=A0=A0=A0 5406277 =B1 50%=A0 numa-me=
minfo.node2.FilePages=0A=
=A0=A0 2459002 =B1 19%=A0=A0=A0 +115.1%=A0=A0=A0 5290461 =B1 51%=A0 numa-me=
minfo.node2.Inactive=0A=
=A0=A0 2216704 =B1 16%=A0=A0=A0 +131.7%=A0=A0=A0 5135596 =B1 53%=A0 numa-me=
minfo.node2.Inactive(file)=0A=
=A0=A0=A0 871702 =B1 16%=A0=A0=A0=A0 +52.8%=A0=A0=A0 1331684 =B1=A0 6%=A0 n=
uma-meminfo.node2.Writeback=0A=
=A0=A0=A0=A0=A0 3888 =B1 16%=A0=A0=A0=A0 -24.5%=A0=A0=A0=A0=A0=A0 2937 =B1=
=A0 6%=A0 numa-meminfo.node3.Active(anon)=0A=
=A0=A0=A0=A0 57796 =B1 19%=A0=A0=A0=A0 -49.7%=A0=A0=A0=A0=A0 29078 =B1 34%=
=A0 numa-meminfo.node3.KReclaimable=0A=
=A0=A0=A0=A0 57796 =B1 19%=A0=A0=A0=A0 -49.7%=A0=A0=A0=A0=A0 29078 =B1 34%=
=A0 numa-meminfo.node3.SReclaimable=0A=
=A0=A0=A0 130240 =B1=A0 7%=A0=A0=A0=A0 -30.1%=A0=A0=A0=A0=A0 91037 =B1 15%=
=A0 numa-meminfo.node3.Slab=0A=
=A0=A0=A0=A0 56616 =B1 18%=A0=A0=A0=A0 +45.2%=A0=A0=A0=A0=A0 82199 =B1 19%=
=A0 numa-vmstat.node0.nr_anon_pages=0A=
=A0=A0=A0=A0 58314 =B1 17%=A0=A0=A0=A0 +42.4%=A0=A0=A0=A0=A0 83024 =B1 20%=
=A0 numa-vmstat.node0.nr_inactive_anon=0A=
=A0=A0=A0=A0=A0 2172 =B1 73%=A0=A0=A0 +135.7%=A0=A0=A0=A0=A0=A0 5122 =B1 28=
%=A0 numa-vmstat.node0.nr_page_table_pages=0A=
=A0=A0=A0=A0 62662 =B1=A0 2%=A0=A0=A0=A0=A0 +6.8%=A0=A0=A0=A0=A0 66945 =B1=
=A0 5%=A0 numa-vmstat.node0.nr_unevictable=0A=
=A0=A0=A0 738434 =B1=A0 9%=A0=A0=A0=A0 -59.3%=A0=A0=A0=A0 300391 =B1 10%=A0=
 numa-vmstat.node0.nr_writeback=0A=
=A0=A0=A0=A0 58312 =B1 17%=A0=A0=A0=A0 +42.4%=A0=A0=A0=A0=A0 83023 =B1 20%=
=A0 numa-vmstat.node0.nr_zone_inactive_anon=0A=
=A0=A0=A0=A0 62662 =B1=A0 2%=A0=A0=A0=A0=A0 +6.8%=A0=A0=A0=A0=A0 66945 =B1=
=A0 5%=A0 numa-vmstat.node0.nr_zone_unevictable=0A=
=A0=A0=A0 926442 =B1=A0 6%=A0=A0=A0=A0 -53.1%=A0=A0=A0=A0 434282 =B1 12%=A0=
 numa-vmstat.node0.nr_zone_write_pending=0A=
=A0=A0=A0=A0 84324 =B1 81%=A0=A0=A0 +112.0%=A0=A0=A0=A0 178764 =B1 64%=A0 n=
uma-vmstat.node1.nr_dirty=0A=
=A0=A0=A0 427046 =B1 84%=A0=A0=A0=A0 +74.8%=A0=A0=A0=A0 746464 =B1 46%=A0 n=
uma-vmstat.node1.nr_zone_write_pending=0A=
=A0=A0=A0 627042 =B1 18%=A0=A0=A0 +129.0%=A0=A0=A0 1435752 =B1 55%=A0 numa-=
vmstat.node2.nr_dirtied=0A=
=A0=A0=A0=A0 59963 =B1 18%=A0=A0=A0 +137.8%=A0=A0=A0=A0 142585 =B1 36%=A0 n=
uma-vmstat.node2.nr_dirty=0A=
=A0=A0=A0 634106 =B1 15%=A0=A0=A0 +112.1%=A0=A0=A0 1345185 =B1 50%=A0 numa-=
vmstat.node2.nr_file_pages=0A=
=A0=A0=A0 567086 =B1 17%=A0=A0=A0 +125.3%=A0=A0=A0 1277507 =B1 53%=A0 numa-=
vmstat.node2.nr_inactive_file=0A=
=A0=A0=A0 223407 =B1 17%=A0=A0=A0=A0 +48.3%=A0=A0=A0=A0 331299 =B1=A0 7%=A0=
 numa-vmstat.node2.nr_writeback=0A=
=A0=A0=A0 567087 =B1 17%=A0=A0=A0 +125.3%=A0=A0=A0 1277515 =B1 53%=A0 numa-=
vmstat.node2.nr_zone_inactive_file=0A=
=A0=A0=A0 283372 =B1 17%=A0=A0=A0=A0 +67.2%=A0=A0=A0=A0 473906 =B1=A0 8%=A0=
 numa-vmstat.node2.nr_zone_write_pending=0A=
=A0=A0=A0 922.00 =B1 19%=A0=A0=A0=A0 -20.0%=A0=A0=A0=A0 737.25 =B1=A0 6%=A0=
 numa-vmstat.node3.nr_active_anon=0A=
=A0=A0=A0=A0 14591 =B1 20%=A0=A0=A0=A0 -50.1%=A0=A0=A0=A0=A0=A0 7276 =B1 35=
%=A0 numa-vmstat.node3.nr_slab_reclaimable=0A=
=A0=A0=A0 922.00 =B1 19%=A0=A0=A0=A0 -20.0%=A0=A0=A0=A0 737.25 =B1=A0 6%=A0=
 numa-vmstat.node3.nr_zone_active_anon=0A=
=A0=A0=A0 141466 =B1 17%=A0=A0=A0 +523.4%=A0=A0=A0=A0 881964 =B1 85%=A0 num=
a-vmstat.node3.numa_other=0A=
=A0=A0=A0 282981 =B1 14%=A0=A0=A0=A0 +46.6%=A0=A0=A0=A0 414731 =B1 12%=A0 i=
nterrupts.CAL:Function_call_interrupts=0A=
=A0=A0=A0 770.00 =B1 51%=A0=A0=A0=A0 -56.5%=A0=A0=A0=A0 335.00 =B1 59%=A0 i=
nterrupts.CPU0.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0 770.00 =B1 51%=A0=A0=A0=A0 -56.5%=A0=A0=A0=A0 335.00 =B1 59%=A0 i=
nterrupts.CPU0.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 346.25 =B1 15%=A0=A0=A0=A0 -46.7%=A0=A0=A0=A0 184.50 =B1 23%=A0 i=
nterrupts.CPU110.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0 346.25 =B1 15%=A0=A0=A0=A0 -46.7%=A0=A0=A0=A0 184.50 =B1 23%=A0 i=
nterrupts.CPU110.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0=A0 1359 =B1 14%=A0=A0=A0=A0 +31.7%=A0=A0=A0=A0=A0=A0 1789 =B1 =
17%=A0 interrupts.CPU128.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 1378 =B1 14%=A0=A0 +2294.9%=A0=A0=A0=A0=A0 33020 =B1164%=A0=
 interrupts.CPU153.CAL:Function_call_interrupts=0A=
=A0=A0=A0 214.50 =B1 34%=A0=A0=A0=A0 +91.7%=A0=A0=A0=A0 411.25 =B1 39%=A0 i=
nterrupts.CPU16.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0 214.50 =B1 34%=A0=A0=A0=A0 +91.7%=A0=A0=A0=A0 411.25 =B1 39%=A0 i=
nterrupts.CPU16.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 403.50 =B1 35%=A0=A0=A0=A0 -40.3%=A0=A0=A0=A0 241.00 =B1=A0 8%=A0=
 interrupts.CPU169.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0 403.50 =B1 35%=A0=A0=A0=A0 -40.3%=A0=A0=A0=A0 241.00 =B1=A0 8%=A0=
 interrupts.CPU169.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 439.00 =B1 50%=A0=A0=A0=A0 -51.5%=A0=A0=A0=A0 212.75 =B1 22%=A0 i=
nterrupts.CPU170.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0 439.00 =B1 50%=A0=A0=A0=A0 -51.5%=A0=A0=A0=A0 212.75 =B1 22%=A0 i=
nterrupts.CPU170.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0=A0 1062 =B1116%=A0=A0=A0=A0 -77.3%=A0=A0=A0=A0 240.75 =B1 23%=
=A0 interrupts.CPU174.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 1062 =B1116%=A0=A0=A0=A0 -77.3%=A0=A0=A0=A0 240.75 =B1 23%=
=A0 interrupts.CPU174.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 291.25 =B1 31%=A0=A0=A0=A0 -34.2%=A0=A0=A0=A0 191.75 =B1 30%=A0 i=
nterrupts.CPU2.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0 291.25 =B1 31%=A0=A0=A0=A0 -34.2%=A0=A0=A0=A0 191.75 =B1 30%=A0 i=
nterrupts.CPU2.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 342.00 =B1 43%=A0=A0=A0=A0 -58.3%=A0=A0=A0=A0 142.75 =B1 16%=A0 i=
nterrupts.CPU22.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0 342.00 =B1 43%=A0=A0=A0=A0 -58.3%=A0=A0=A0=A0 142.75 =B1 16%=A0 i=
nterrupts.CPU22.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 241.25 =B1 22%=A0=A0=A0=A0 -42.6%=A0=A0=A0=A0 138.50 =B1 22%=A0 i=
nterrupts.CPU23.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0 241.25 =B1 22%=A0=A0=A0=A0 -42.6%=A0=A0=A0=A0 138.50 =B1 22%=A0 i=
nterrupts.CPU23.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0=A0 1365 =B1 14%=A0=A0=A0=A0 +49.5%=A0=A0=A0=A0=A0=A0 2041 =B1 =
24%=A0 interrupts.CPU35.CAL:Function_call_interrupts=0A=
=A0=A0=A0 222.00 =B1 94%=A0=A0=A0 +175.1%=A0=A0=A0=A0 610.75 =B1 51%=A0 int=
errupts.CPU63.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0 222.00 =B1 94%=A0=A0=A0 +175.1%=A0=A0=A0=A0 610.75 =B1 51%=A0 int=
errupts.CPU63.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 146.75 =B1 39%=A0=A0=A0 +104.6%=A0=A0=A0=A0 300.25 =B1 32%=A0 int=
errupts.CPU64.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0 146.75 =B1 39%=A0=A0=A0 +104.6%=A0=A0=A0=A0 300.25 =B1 32%=A0 int=
errupts.CPU64.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 557.00 =B1 88%=A0=A0=A0=A0 -61.3%=A0=A0=A0=A0 215.75 =B1 21%=A0 i=
nterrupts.CPU74.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0 557.00 =B1 88%=A0=A0=A0=A0 -61.3%=A0=A0=A0=A0 215.75 =B1 21%=A0 i=
nterrupts.CPU74.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 319.25 =B1 22%=A0=A0=A0=A0 -43.9%=A0=A0=A0=A0 179.25 =B1 36%=A0 i=
nterrupts.CPU75.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0 319.25 =B1 22%=A0=A0=A0=A0 -43.9%=A0=A0=A0=A0 179.25 =B1 36%=A0 i=
nterrupts.CPU75.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0=A0 1343 =B1 15%=A0=A0=A0=A0 +23.0%=A0=A0=A0=A0=A0=A0 1652 =B1=
=A0 4%=A0 interrupts.CPU80.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 1095 =B1 66%=A0=A0=A0=A0 -76.5%=A0=A0=A0=A0 257.00 =B1 17%=
=A0 interrupts.CPU96.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 1095 =B1 66%=A0=A0=A0=A0 -76.5%=A0=A0=A0=A0 257.00 =B1 17%=
=A0 interrupts.CPU96.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 817.25 =B1 12%=A0=A0=A0=A0 +62.6%=A0=A0=A0=A0=A0=A0 1329 =B1 17%=
=A0 interrupts.RES:Rescheduling_interrupts=0A=
=A0=A0=A0=A0 12.39 =B1 23%=A0=A0=A0=A0=A0 -8.2=A0=A0=A0=A0=A0=A0=A0 4.22 =
=B1=A0 6%=A0 perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwfram=
e=0A=
=A0=A0=A0=A0 12.35 =B1 24%=A0=A0=A0=A0=A0 -8.1=A0=A0=A0=A0=A0=A0=A0 4.21 =
=B1=A0 6%=A0 perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_6=
4_after_hwframe=0A=
=A0=A0=A0=A0 12.12 =B1 24%=A0=A0=A0=A0=A0 -8.0=A0=A0=A0=A0=A0=A0=A0 4.08 =
=B1=A0 6%=A0 perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entr=
y_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0 12.11 =B1 24%=A0=A0=A0=A0=A0 -8.0=A0=A0=A0=A0=A0=A0=A0 4.07 =
=B1=A0 6%=A0 perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_sysca=
ll_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0 12.10 =B1 24%=A0=A0=A0=A0=A0 -8.0=A0=A0=A0=A0=A0=A0=A0 4.06 =
=B1=A0 6%=A0 perf-profile.calltrace.cycles-pp.btrfs_file_write_iter.new_syn=
c_write.vfs_write.ksys_write.do_syscall_64=0A=
=A0=A0=A0=A0 12.07 =B1 24%=A0=A0=A0=A0=A0 -8.0=A0=A0=A0=A0=A0=A0=A0 4.04 =
=B1=A0 6%=A0 perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_fi=
le_write_iter.new_sync_write.vfs_write.ksys_write=0A=
=A0=A0=A0=A0 12.28 =B1 24%=A0=A0=A0=A0=A0 -7.5=A0=A0=A0=A0=A0=A0=A0 4.83 =
=B1=A0 5%=A0 perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys=
_write.do_syscall_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 6.07 =B1 31%=A0=A0=A0=A0=A0 -6.1=A0=A0=A0=A0=A0=A0=A0 0.00=
=A0=A0=A0=A0=A0=A0=A0 perf-profile.calltrace.cycles-pp.native_queued_spin_l=
ock_slowpath._raw_spin_lock.__reserve_bytes.btrfs_reserve_metadata_bytes.bt=
rfs_delalloc_reserve_metadata=0A=
=A0=A0=A0=A0=A0 6.36 =B1 30%=A0=A0=A0=A0=A0 -4.8=A0=A0=A0=A0=A0=A0=A0 1.55 =
=B1 11%=A0 perf-profile.calltrace.cycles-pp.btrfs_delalloc_reserve_metadata=
.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write=0A=
=A0=A0=A0=A0=A0 6.31 =B1 30%=A0=A0=A0=A0=A0 -4.8=A0=A0=A0=A0=A0=A0=A0 1.51 =
=B1 12%=A0 perf-profile.calltrace.cycles-pp.__reserve_bytes.btrfs_reserve_m=
etadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_fi=
le_write_iter=0A=
=A0=A0=A0=A0=A0 6.31 =B1 30%=A0=A0=A0=A0=A0 -4.8=A0=A0=A0=A0=A0=A0=A0 1.51 =
=B1 12%=A0 perf-profile.calltrace.cycles-pp.btrfs_reserve_metadata_bytes.bt=
rfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter.ne=
w_sync_write=0A=
=A0=A0=A0=A0=A0 6.13 =B1 31%=A0=A0=A0=A0=A0 -4.8=A0=A0=A0=A0=A0=A0=A0 1.38 =
=B1 14%=A0 perf-profile.calltrace.cycles-pp._raw_spin_lock.__reserve_bytes.=
btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered=
_write=0A=
=A0=A0=A0=A0=A0 4.39 =B1 18%=A0=A0=A0=A0=A0 -3.2=A0=A0=A0=A0=A0=A0=A0 1.21 =
=B1 15%=A0 perf-profile.calltrace.cycles-pp.btrfs_inode_rsv_release.btrfs_b=
uffered_write.btrfs_file_write_iter.new_sync_write.vfs_write=0A=
=A0=A0=A0=A0=A0 4.38 =B1 18%=A0=A0=A0=A0=A0 -3.2=A0=A0=A0=A0=A0=A0=A0 1.20 =
=B1 15%=A0 perf-profile.calltrace.cycles-pp.btrfs_block_rsv_release.btrfs_i=
node_rsv_release.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write=
=0A=
=A0=A0=A0=A0=A0 4.21 =B1 19%=A0=A0=A0=A0=A0 -3.1=A0=A0=A0=A0=A0=A0=A0 1.09 =
=B1 20%=A0 perf-profile.calltrace.cycles-pp._raw_spin_lock.btrfs_block_rsv_=
release.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_file_write_iter=
=0A=
=A0=A0=A0=A0=A0 0.13 =B1173%=A0=A0=A0=A0=A0 +0.5=A0=A0=A0=A0=A0=A0=A0 0.63 =
=B1=A0 6%=A0 perf-profile.calltrace.cycles-pp.tick_nohz_irq_exit.sysvec_api=
c_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuid=
le_enter=0A=
=A0=A0=A0=A0=A0 4.51 =B1=A0 6%=A0=A0=A0=A0=A0 +0.5=A0=A0=A0=A0=A0=A0=A0 5.0=
4 =B1=A0 3%=A0 perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.sy=
svec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_sta=
te.cpuidle_enter=0A=
=A0=A0=A0=A0=A0 4.48 =B1=A0 5%=A0=A0=A0=A0=A0 +0.5=A0=A0=A0=A0=A0=A0=A0 5.0=
2 =B1=A0 3%=A0 perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interru=
pt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_tim=
er_interrupt.cpuidle_enter_state=0A=
=A0=A0=A0=A0=A0 4.37 =B1=A0 6%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 4.9=
3 =B1=A0 3%=A0 perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_=
apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.a=
sm_sysvec_apic_timer_interrupt=0A=
=A0=A0=A0=A0=A0 0.18 =B1173%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 0.75 =
=B1 27%=A0 perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.dev=
kmsg_emit.devkmsg_write.cold.new_sync_write=0A=
=A0=A0=A0=A0=A0 0.18 =B1173%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 0.76 =
=B1 27%=A0 perf-profile.calltrace.cycles-pp.vprintk_emit.devkmsg_emit.devkm=
sg_write.cold.new_sync_write.vfs_write=0A=
=A0=A0=A0=A0=A0 0.18 =B1173%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 0.76 =
=B1 27%=A0 perf-profile.calltrace.cycles-pp.devkmsg_write.cold.new_sync_wri=
te.vfs_write.ksys_write.do_syscall_64=0A=
=A0=A0=A0=A0=A0 0.18 =B1173%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 0.76 =
=B1 27%=A0 perf-profile.calltrace.cycles-pp.devkmsg_emit.devkmsg_write.cold=
.new_sync_write.vfs_write.ksys_write=0A=
=A0=A0=A0=A0=A0 0.18 =B1173%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 0.77 =
=B1 27%=A0 perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.=
write=0A=
=A0=A0=A0=A0=A0 0.18 =B1173%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 0.77 =
=B1 27%=A0 perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_=
after_hwframe.write=0A=
=A0=A0=A0=A0=A0 0.18 =B1173%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 0.77 =
=B1 27%=A0 perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_=
SYSCALL_64_after_hwframe.write=0A=
=A0=A0=A0=A0=A0 0.18 =B1173%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 0.77 =
=B1 27%=A0 perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall=
_64.entry_SYSCALL_64_after_hwframe.write=0A=
=A0=A0=A0=A0=A0 0.18 =B1173%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 0.77 =
=B1 27%=A0 perf-profile.calltrace.cycles-pp.write=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=
=A0=A0 0.62 =B1=A0 7%=A0 perf-profile.calltrace.cycles-pp.ktime_get.tick_no=
hz_irq_exit.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpu=
idle_enter_state=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.1=A0=A0=A0=A0=A0=
=A0=A0 1.06 =B1 21%=A0 perf-profile.calltrace.cycles-pp.__cna_queued_spin_l=
ock_slowpath._raw_spin_lock.btrfs_block_rsv_release.btrfs_inode_rsv_release=
.btrfs_buffered_write=0A=
=A0=A0=A0=A0=A0 7.48 =B1=A0 5%=A0=A0=A0=A0=A0 +1.2=A0=A0=A0=A0=A0=A0=A0 8.6=
8 =B1=A0 2%=A0 perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt=
.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle=
=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.3=A0=A0=A0=A0=A0=
=A0=A0 1.33 =B1 15%=A0 perf-profile.calltrace.cycles-pp.__cna_queued_spin_l=
ock_slowpath._raw_spin_lock.__reserve_bytes.btrfs_reserve_metadata_bytes.bt=
rfs_delalloc_reserve_metadata=0A=
=A0=A0=A0=A0 11.79 =B1=A0 8%=A0=A0=A0=A0=A0 +2.8=A0=A0=A0=A0=A0=A0 14.63 =
=B1=A0 8%=A0 perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interru=
pt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry=0A=
=A0=A0=A0=A0=A0 9.11 =B1 14%=A0=A0=A0=A0=A0 +4.4=A0=A0=A0=A0=A0=A0 13.51 =
=B1 18%=A0 perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup=
_entry.start_secondary.secondary_startup_64_no_verify=0A=
=A0=A0=A0=A0 10.58 =B1 26%=A0=A0=A0=A0 -10.6=A0=A0=A0=A0=A0=A0=A0 0.00=A0=
=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.native_queued_spin_lock_=
slowpath=0A=
=A0=A0=A0=A0 12.10 =B1 24%=A0=A0=A0=A0=A0 -8.0=A0=A0=A0=A0=A0=A0=A0 4.06 =
=B1=A0 6%=A0 perf-profile.children.cycles-pp.btrfs_file_write_iter=0A=
=A0=A0=A0=A0 12.07 =B1 24%=A0=A0=A0=A0=A0 -8.0=A0=A0=A0=A0=A0=A0=A0 4.04 =
=B1=A0 6%=A0 perf-profile.children.cycles-pp.btrfs_buffered_write=0A=
=A0=A0=A0=A0 14.00 =B1 18%=A0=A0=A0=A0=A0 -7.9=A0=A0=A0=A0=A0=A0=A0 6.09 =
=B1=A0 7%=A0 perf-profile.children.cycles-pp._raw_spin_lock=0A=
=A0=A0=A0=A0 12.64 =B1 23%=A0=A0=A0=A0=A0 -7.8=A0=A0=A0=A0=A0=A0=A0 4.85 =
=B1=A0 5%=A0 perf-profile.children.cycles-pp.ksys_write=0A=
=A0=A0=A0=A0 12.62 =B1 24%=A0=A0=A0=A0=A0 -7.8=A0=A0=A0=A0=A0=A0=A0 4.83 =
=B1=A0 5%=A0 perf-profile.children.cycles-pp.new_sync_write=0A=
=A0=A0=A0=A0 12.63 =B1 23%=A0=A0=A0=A0=A0 -7.8=A0=A0=A0=A0=A0=A0=A0 4.85 =
=B1=A0 5%=A0 perf-profile.children.cycles-pp.vfs_write=0A=
=A0=A0=A0=A0 13.17 =B1 23%=A0=A0=A0=A0=A0 -7.6=A0=A0=A0=A0=A0=A0=A0 5.60 =
=B1=A0 6%=A0 perf-profile.children.cycles-pp.do_syscall_64=0A=
=A0=A0=A0=A0 13.24 =B1 23%=A0=A0=A0=A0=A0 -7.3=A0=A0=A0=A0=A0=A0=A0 5.92 =
=B1=A0 6%=A0 perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe=
=0A=
=A0=A0=A0=A0=A0 6.38 =B1 30%=A0=A0=A0=A0=A0 -4.8=A0=A0=A0=A0=A0=A0=A0 1.55 =
=B1 12%=A0 perf-profile.children.cycles-pp.__reserve_bytes=0A=
=A0=A0=A0=A0=A0 6.33 =B1 30%=A0=A0=A0=A0=A0 -4.8=A0=A0=A0=A0=A0=A0=A0 1.52 =
=B1 12%=A0 perf-profile.children.cycles-pp.btrfs_reserve_metadata_bytes=0A=
=A0=A0=A0=A0=A0 6.36 =B1 30%=A0=A0=A0=A0=A0 -4.8=A0=A0=A0=A0=A0=A0=A0 1.55 =
=B1 11%=A0 perf-profile.children.cycles-pp.btrfs_delalloc_reserve_metadata=
=0A=
=A0=A0=A0=A0=A0 4.49 =B1 18%=A0=A0=A0=A0=A0 -3.3=A0=A0=A0=A0=A0=A0=A0 1.23 =
=B1 15%=A0 perf-profile.children.cycles-pp.btrfs_block_rsv_release=0A=
=A0=A0=A0=A0=A0 4.39 =B1 18%=A0=A0=A0=A0=A0 -3.2=A0=A0=A0=A0=A0=A0=A0 1.21 =
=B1 15%=A0 perf-profile.children.cycles-pp.btrfs_inode_rsv_release=0A=
=A0=A0=A0=A0=A0 0.16 =B1 77%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.06 =
=B1=A0 7%=A0 perf-profile.children.cycles-pp.do_filp_open=0A=
=A0=A0=A0=A0=A0 0.16 =B1 77%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.06 =
=B1=A0 7%=A0 perf-profile.children.cycles-pp.path_openat=0A=
=A0=A0=A0=A0=A0 0.16 =B1 75%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.06 =
=B1=A0 6%=A0 perf-profile.children.cycles-pp.do_sys_open=0A=
=A0=A0=A0=A0=A0 0.16 =B1 75%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.06 =
=B1=A0 6%=A0 perf-profile.children.cycles-pp.do_sys_openat2=0A=
=A0=A0=A0=A0=A0 0.21 =B1 32%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.13 =
=B1 29%=A0 perf-profile.children.cycles-pp.rcu_sched_clock_irq=0A=
=A0=A0=A0=A0=A0 0.22 =B1=A0 9%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.1=
6 =B1=A0 6%=A0 perf-profile.children.cycles-pp.update_blocked_averages=0A=
=A0=A0=A0=A0=A0 0.10 =B1 29%=A0=A0=A0=A0=A0 -0.0=A0=A0=A0=A0=A0=A0=A0 0.05 =
=B1 70%=A0 perf-profile.children.cycles-pp.update_ts_time_stats=0A=
=A0=A0=A0=A0=A0 0.07 =B1 12%=A0=A0=A0=A0=A0 -0.0=A0=A0=A0=A0=A0=A0=A0 0.04 =
=B1 58%=A0 perf-profile.children.cycles-pp.__pagevec_lru_add_fn=0A=
=A0=A0=A0=A0=A0 0.16 =B1=A0 9%=A0=A0=A0=A0=A0 +0.0=A0=A0=A0=A0=A0=A0=A0 0.2=
0 =B1 12%=A0 perf-profile.children.cycles-pp.brd_lookup_page=0A=
=A0=A0=A0=A0=A0 0.13 =B1 11%=A0=A0=A0=A0=A0 +0.0=A0=A0=A0=A0=A0=A0=A0 0.17 =
=B1 18%=A0 perf-profile.children.cycles-pp.__radix_tree_lookup=0A=
=A0=A0=A0=A0=A0 0.14 =B1=A0 7%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.2=
0 =B1=A0 9%=A0 perf-profile.children.cycles-pp.__intel_pmu_enable_all=0A=
=A0=A0=A0=A0=A0 0.48 =B1=A0 8%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.6=
2 =B1=A0 8%=A0 perf-profile.children.cycles-pp._raw_spin_lock_irqsave=0A=
=A0=A0=A0=A0=A0 0.51 =B1 29%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.77 =
=B1 27%=A0 perf-profile.children.cycles-pp.write=0A=
=A0=A0=A0=A0=A0 0.39 =B1 32%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.65 =
=B1=A0 6%=A0 perf-profile.children.cycles-pp.tick_nohz_irq_exit=0A=
=A0=A0=A0=A0=A0 0.50 =B1 30%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.76 =
=B1 27%=A0 perf-profile.children.cycles-pp.devkmsg_write.cold=0A=
=A0=A0=A0=A0=A0 0.50 =B1 30%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.76 =
=B1 27%=A0 perf-profile.children.cycles-pp.devkmsg_emit=0A=
=A0=A0=A0=A0=A0 0.03 =B1173%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.29 =
=B1108%=A0 perf-profile.children.cycles-pp.osq_lock=0A=
=A0=A0=A0=A0=A0 0.03 =B1173%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.29 =
=B1107%=A0 perf-profile.children.cycles-pp.__mutex_lock=0A=
=A0=A0=A0=A0=A0 0.11 =B1130%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.45 =
=B1 68%=A0 perf-profile.children.cycles-pp.__do_sys_finit_module=0A=
=A0=A0=A0=A0=A0 0.11 =B1130%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.45 =
=B1 68%=A0 perf-profile.children.cycles-pp.load_module=0A=
=A0=A0=A0=A0=A0 0.11 =B1130%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.45 =
=B1 67%=A0 perf-profile.children.cycles-pp.syscall=0A=
=A0=A0=A0=A0=A0 0.14 =B1 88%=A0=A0=A0=A0=A0 +0.4=A0=A0=A0=A0=A0=A0=A0 0.54 =
=B1 53%=A0 perf-profile.children.cycles-pp.wb_workfn=0A=
=A0=A0=A0=A0=A0 0.14 =B1 88%=A0=A0=A0=A0=A0 +0.4=A0=A0=A0=A0=A0=A0=A0 0.54 =
=B1 53%=A0 perf-profile.children.cycles-pp.wb_writeback=0A=
=A0=A0=A0=A0=A0 0.14 =B1 88%=A0=A0=A0=A0=A0 +0.4=A0=A0=A0=A0=A0=A0=A0 0.54 =
=B1 53%=A0 perf-profile.children.cycles-pp.writeback_sb_inodes=0A=
=A0=A0=A0=A0=A0 0.12 =B1105%=A0=A0=A0=A0=A0 +0.4=A0=A0=A0=A0=A0=A0=A0 0.53 =
=B1 54%=A0 perf-profile.children.cycles-pp.__writeback_single_inode=0A=
=A0=A0=A0=A0=A0 4.76 =B1=A0 5%=A0=A0=A0=A0=A0 +0.5=A0=A0=A0=A0=A0=A0=A0 5.2=
1 =B1=A0 3%=A0 perf-profile.children.cycles-pp.__sysvec_apic_timer_interrup=
t=0A=
=A0=A0=A0=A0=A0 4.65 =B1=A0 5%=A0=A0=A0=A0=A0 +0.5=A0=A0=A0=A0=A0=A0=A0 5.1=
3 =B1=A0 2%=A0 perf-profile.children.cycles-pp.hrtimer_interrupt=0A=
=A0=A0=A0=A0=A0 6.15 =B1=A0 5%=A0=A0=A0=A0=A0 +0.5=A0=A0=A0=A0=A0=A0=A0 6.6=
5 =B1=A0 2%=A0 perf-profile.children.cycles-pp.asm_call_sysvec_on_stack=0A=
=A0=A0=A0=A0=A0 2.06 =B1 28%=A0=A0=A0=A0=A0 +1.0=A0=A0=A0=A0=A0=A0=A0 3.05 =
=B1=A0 9%=A0 perf-profile.children.cycles-pp.ktime_get=0A=
=A0=A0=A0=A0=A0 7.80 =B1=A0 4%=A0=A0=A0=A0=A0 +1.1=A0=A0=A0=A0=A0=A0=A0 8.9=
4 =B1=A0 2%=A0 perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt=
=0A=
=A0=A0=A0=A0 10.10 =B1=A0 6%=A0=A0=A0=A0=A0 +2.0=A0=A0=A0=A0=A0=A0 12.05 =
=B1=A0 6%=A0 perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrup=
t=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +2.6=A0=A0=A0=A0=A0=
=A0=A0 2.56 =B1 19%=A0 perf-profile.children.cycles-pp.__cna_queued_spin_lo=
ck_slowpath=0A=
=A0=A0=A0=A0=A0 9.16 =B1 14%=A0=A0=A0=A0=A0 +4.4=A0=A0=A0=A0=A0=A0 13.57 =
=B1 18%=A0 perf-profile.children.cycles-pp.menu_select=0A=
=A0=A0=A0=A0 10.50 =B1 26%=A0=A0=A0=A0 -10.5=A0=A0=A0=A0=A0=A0=A0 0.00=A0=
=A0=A0=A0=A0=A0=A0 perf-profile.self.cycles-pp.native_queued_spin_lock_slow=
path=0A=
=A0=A0=A0=A0=A0 0.18 =B1 30%=A0=A0=A0=A0=A0 -0.1=A0=A0=A0=A0=A0=A0=A0 0.11 =
=B1 27%=A0 perf-profile.self.cycles-pp.rcu_sched_clock_irq=0A=
=A0=A0=A0=A0=A0 0.10 =B1 11%=A0=A0=A0=A0=A0 +0.0=A0=A0=A0=A0=A0=A0=A0 0.13 =
=B1 10%=A0 perf-profile.self.cycles-pp.__extent_writepage=0A=
=A0=A0=A0=A0=A0 0.14 =B1=A0 7%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.2=
0 =B1=A0 9%=A0 perf-profile.self.cycles-pp.__intel_pmu_enable_all=0A=
=A0=A0=A0=A0=A0 0.08 =B1 10%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.16 =
=B1 22%=A0 perf-profile.self.cycles-pp.end_page_writeback=0A=
=A0=A0=A0=A0=A0 0.03 =B1173%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.28 =
=B1105%=A0 perf-profile.self.cycles-pp.osq_lock=0A=
=A0=A0=A0=A0=A0 1.77 =B1 32%=A0=A0=A0=A0=A0 +1.0=A0=A0=A0=A0=A0=A0=A0 2.75 =
=B1 10%=A0 perf-profile.self.cycles-pp.ktime_get=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +2.5=A0=A0=A0=A0=A0=
=A0=A0 2.51 =B1 19%=A0 perf-profile.self.cycles-pp.__cna_queued_spin_lock_s=
lowpath=0A=
=A0=A0=A0=A0=A0 7.68 =B1 15%=A0=A0=A0=A0=A0 +4.1=A0=A0=A0=A0=A0=A0 11.79 =
=B1 21%=A0 perf-profile.self.cycles-pp.menu_select=0A=
=0A=
=0A=
=0A=
***************************************************************************=
************************=0A=
lkp-csl-2ap3: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with=
 192G memory=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/te=
stcase/ucode:=0A=
=A0 gcc-9/performance/x86_64-rhel-8.3/100%/debian-10.4-x86_64-20200603.cgz/=
300s/lkp-csl-2ap3/new_fserver/reaim/0x5003003=0A=
=0A=
commit: =0A=
=A0 cb45bab007 ("locking/qspinlock: Refactor the qspinlock slow path")=0A=
=A0 0e8d8f4f12 ("locking/qspinlock: Introduce CNA into the slow path of qsp=
inlock")=0A=
=0A=
cb45bab007ff0cfc 0e8d8f4f1214cfbac219d6917b5 =0A=
---------------- --------------------------- =0A=
=A0=A0=A0=A0=A0=A0 fail:runs=A0 %reproduction=A0=A0=A0 fail:runs=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0 =0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 1:4=A0=A0=A0=A0=A0=A0=A0=A0=A0 -25%=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 :4=A0=A0=A0=A0 last_state.is_incomplete_run=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 1:4=A0=A0=A0=A0=A0=A0=A0=A0=A0 -25%=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 :4=A0=A0=A0=A0 last_state.wget_initrd=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 :4=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 8%=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 0:4=A0=A0=A0=A0 perf-profile.children.cycles-pp.er=
ror_entry=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 %stddev=A0=A0=A0=A0 %change=A0=A0=A0=A0=A0=A0=A0=
=A0 %stddev=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=A0 =0A=
=A0=A0=A0 556.93=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -64.1%=A0=A0=A0=A0 200.03=A0=
=A0=A0=A0=A0=A0=A0 reaim.child_systime=0A=
=A0=A0=A0=A0 49.95=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +3.6%=A0=A0=A0=A0=A0 51=
.77=A0=A0=A0=A0=A0=A0=A0 reaim.child_utime=0A=
=A0=A0=A0 318145=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +96.1%=A0=A0=A0=A0 623983=A0=
=A0=A0=A0=A0=A0=A0 reaim.jobs_per_min=0A=
=A0=A0=A0=A0=A0 1657=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +96.1%=A0=A0=A0=A0=A0=A0=
 3249=A0=A0=A0=A0=A0=A0=A0 reaim.jobs_per_min_child=0A=
=A0=A0=A0=A0 92.26=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -7.8%=A0=A0=A0=A0=A0 85=
.11=A0=A0=A0=A0=A0=A0=A0 reaim.jti=0A=
=A0=A0=A0 327019=A0=A0=A0=A0=A0=A0=A0=A0=A0 +100.4%=A0=A0=A0=A0 655467=A0=
=A0=A0=A0=A0=A0=A0 reaim.max_jobs_per_min=0A=
=A0=A0=A0=A0=A0 3.55=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -49.0%=A0=A0=A0=A0=A0=A0=
 1.81=A0=A0=A0=A0=A0=A0=A0 reaim.parent_time=0A=
=A0=A0=A0=A0=A0 7.19 =B1=A0 2%=A0=A0=A0 +100.0%=A0=A0=A0=A0=A0 14.38 =B1=A0=
 4%=A0 reaim.std_dev_percent=0A=
=A0=A0=A0=A0=A0 0.24 =B1=A0 2%=A0=A0=A0=A0=A0 -7.3%=A0=A0=A0=A0=A0=A0 0.22 =
=B1=A0 2%=A0 reaim.std_dev_time=0A=
=A0=A0=A0 462973=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +17.9%=A0=A0=A0=A0 545826=A0=
=A0=A0=A0=A0=A0=A0 reaim.time.involuntary_context_switches=0A=
=A0=A0=A0=A0 38288=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +98.5%=A0=A0=A0=A0=A0 7599=
6 =B1=A0 2%=A0 reaim.time.major_page_faults=0A=
=A01.041e+08=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +44.8%=A0 1.509e+08=A0=A0=A0=A0=
=A0=A0=A0 reaim.time.minor_page_faults=0A=
=A0=A0=A0=A0 10863=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -39.7%=A0=A0=A0=A0=A0=A0 6=
549=A0=A0=A0=A0=A0=A0=A0 reaim.time.percent_of_cpu_this_job_got=0A=
=A0=A0=A0=A0 30257=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -47.9%=A0=A0=A0=A0=A0 1575=
4=A0=A0=A0=A0=A0=A0=A0 reaim.time.system_time=0A=
=A0=A0=A0=A0=A0 2714=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +50.2%=A0=A0=A0=A0=A0=A0=
 4077=A0=A0=A0=A0=A0=A0=A0 reaim.time.user_time=0A=
=A0=A0 3000456 =B1=A0 2%=A0=A0=A0=A0 +38.9%=A0=A0=A0 4167220 =B1=A0 2%=A0 r=
eaim.time.voluntary_context_switches=0A=
=A0=A0 1043200=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +44.9%=A0=A0=A0 1512000=A0=A0=
=A0=A0=A0=A0=A0 reaim.workload=0A=
=A0=A0=A0=A0 29843=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.0%=A0=A0=A0=A0=A0 4176=
7=A0=A0=A0=A0=A0=A0=A0 uptime.idle=0A=
=A0 20127118 =B1 12%=A0=A0=A0=A0 +48.7%=A0=A0 29930674 =B1=A0 4%=A0 cpuidle=
.C1.time=0A=
=A0=A0=A0 284217 =B1=A0 9%=A0=A0=A0=A0 +66.1%=A0=A0=A0=A0 472177 =B1=A0 2%=
=A0 cpuidle.C1.usage=0A=
=A0=A0=A0 308815 =B1 13%=A0=A0=A0=A0 +26.0%=A0=A0=A0=A0 389201 =B1 16%=A0 c=
puidle.POLL.usage=0A=
=A0=A0=A0=A0 41.44=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +20.8=A0=A0=A0=A0=A0=A0 62=
.28=A0=A0=A0=A0=A0=A0=A0 mpstat.cpu.all.idle%=0A=
=A0=A0=A0=A0=A0 0.69=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.3=A0=A0=A0=A0=A0=
=A0=A0 1.98 =B1=A0 2%=A0 mpstat.cpu.all.soft%=0A=
=A0=A0=A0=A0 51.88=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -24.6=A0=A0=A0=A0=A0=A0 27=
.26=A0=A0=A0=A0=A0=A0=A0 mpstat.cpu.all.sys%=0A=
=A0=A0=A0=A0=A0 4.60=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +2.3=A0=A0=A0=A0=A0=
=A0=A0 6.91=A0=A0=A0=A0=A0=A0=A0 mpstat.cpu.all.usr%=0A=
=A0=A0=A0=A0 41.33=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +50.0%=A0=A0=A0=A0=A0 62.0=
0=A0=A0=A0=A0=A0=A0=A0 vmstat.cpu.id=0A=
=A0=A0=A0=A0 53.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -43.4%=A0=A0=A0=A0=A0 30.0=
0=A0=A0=A0=A0=A0=A0=A0 vmstat.cpu.sy=0A=
=A0=A0=A0 110.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -25.9%=A0=A0=A0=A0=A0 81.50 =
=B1=A0 2%=A0 vmstat.procs.r=0A=
=A0=A0=A0=A0 25559 =B1=A0 2%=A0=A0=A0=A0 +46.2%=A0=A0=A0=A0=A0 37370=A0=A0=
=A0=A0=A0=A0=A0 vmstat.system.cs=0A=
=A0=A0=A0 269427 =B1=A0 4%=A0=A0=A0=A0 -12.8%=A0=A0=A0=A0 234969=A0=A0=A0=
=A0=A0=A0=A0 meminfo.Active=0A=
=A0=A0=A0 269427 =B1=A0 4%=A0=A0=A0=A0 -12.8%=A0=A0=A0=A0 234969=A0=A0=A0=
=A0=A0=A0=A0 meminfo.Active(anon)=0A=
=A0=A0=A0=A0 32953=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +9.7%=A0=A0=A0=A0=A0 36=
144 =B1=A0 2%=A0 meminfo.KernelStack=0A=
=A0=A0=A0=A0 19202=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +63.2%=A0=A0=A0=A0=A0 3133=
8=A0=A0=A0=A0=A0=A0=A0 meminfo.PageTables=0A=
=A0=A0=A0 483410=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +11.8%=A0=A0=A0=A0 540459=A0=
=A0=A0=A0=A0=A0=A0 meminfo.SUnreclaim=0A=
=A0=A0=A0 304770 =B1=A0 4%=A0=A0=A0=A0 -12.8%=A0=A0=A0=A0 265628=A0=A0=A0=
=A0=A0=A0=A0 meminfo.Shmem=0A=
=A0=A0=A0 620741=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +10.5%=A0=A0=A0=A0 685878=A0=
=A0=A0=A0=A0=A0=A0 meminfo.Slab=0A=
=A0 18788579=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +43.8%=A0=A0 27017272 =B1=A0 4%=
=A0 numa-numastat.node0.local_node=0A=
=A0 18827783=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +43.8%=A0=A0 27074532 =B1=A0 4%=
=A0 numa-numastat.node0.numa_hit=0A=
=A0 19046024=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +45.8%=A0=A0 27771991 =B1=A0 2%=
=A0 numa-numastat.node1.local_node=0A=
=A0 19126483=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +45.6%=A0=A0 27844754 =B1=A0 2%=
=A0 numa-numastat.node1.numa_hit=0A=
=A0 18849870=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +44.4%=A0=A0 27228340 =B1=A0 2%=
=A0 numa-numastat.node2.local_node=0A=
=A0 18926181=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +44.1%=A0=A0 27271719 =B1=A0 2%=
=A0 numa-numastat.node2.numa_hit=0A=
=A0 18622314=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +46.2%=A0=A0 27216882 =B1=A0 3%=
=A0 numa-numastat.node3.local_node=0A=
=A0 18686267=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +46.1%=A0=A0 27303516 =B1=A0 3%=
=A0 numa-numastat.node3.numa_hit=0A=
=A0=A0=A0=A0 42977 =B1 81%=A0=A0=A0=A0 -79.9%=A0=A0=A0=A0=A0=A0 8629 =B1 59=
%=A0 numa-meminfo.node0.Active=0A=
=A0=A0=A0=A0 42977 =B1 81%=A0=A0=A0=A0 -79.9%=A0=A0=A0=A0=A0=A0 8629 =B1 59=
%=A0 numa-meminfo.node0.Active(anon)=0A=
=A0=A0=A0=A0=A0 7040=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +24.4%=A0=A0=A0=A0=A0=A0=
 8759 =B1=A0 8%=A0 numa-meminfo.node1.KernelStack=0A=
=A0=A0=A0=A0=A0 2790 =B1 11%=A0=A0=A0 +140.4%=A0=A0=A0=A0=A0=A0 6708 =B1 26=
%=A0 numa-meminfo.node1.PageTables=0A=
=A0=A0=A0 103698=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +19.3%=A0=A0=A0=A0 123717 =
=B1=A0 9%=A0 numa-meminfo.node1.SUnreclaim=0A=
=A0=A0=A0 129487 =B1=A0 2%=A0=A0=A0=A0 +18.0%=A0=A0=A0=A0 152790 =B1=A0 7%=
=A0 numa-meminfo.node1.Slab=0A=
=A0=A0=A0=A0 32541 =B1 26%=A0=A0=A0=A0 +46.6%=A0=A0=A0=A0=A0 47695 =B1 24%=
=A0 numa-meminfo.node2.KReclaimable=0A=
=A0=A0=A0=A0 32541 =B1 26%=A0=A0=A0=A0 +46.6%=A0=A0=A0=A0=A0 47695 =B1 24%=
=A0 numa-meminfo.node2.SReclaimable=0A=
=A0=A0=A0 150472 =B1 20%=A0=A0=A0=A0 +21.5%=A0=A0=A0=A0 182840 =B1 15%=A0 n=
uma-meminfo.node2.Slab=0A=
=A0=A0=A0 167884 =B1 33%=A0=A0=A0=A0 +71.3%=A0=A0=A0=A0 287506 =B1 45%=A0 n=
uma-meminfo.node3.AnonPages.max=0A=
=A0=A0=A0=A0=A0 2974 =B1 11%=A0=A0=A0 +145.0%=A0=A0=A0=A0=A0=A0 7288 =B1 28=
%=A0 numa-meminfo.node3.PageTables=0A=
=A0=A0=A0 109568 =B1=A0 4%=A0=A0=A0=A0 +13.7%=A0=A0=A0=A0 124544 =B1 12%=A0=
 numa-meminfo.node3.SUnreclaim=0A=
=A0=A0=A0=A0 10666 =B1 81%=A0=A0=A0=A0 -79.8%=A0=A0=A0=A0=A0=A0 2152 =B1 59=
%=A0 numa-vmstat.node0.nr_active_anon=0A=
=A0=A0=A0=A0 10665 =B1 81%=A0=A0=A0=A0 -79.8%=A0=A0=A0=A0=A0=A0 2152 =B1 59=
%=A0 numa-vmstat.node0.nr_zone_active_anon=0A=
=A0=A0 9854862=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.8%=A0=A0 13975810 =B1=A0 2=
%=A0 numa-vmstat.node0.numa_hit=0A=
=A0=A0 9773079=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.9%=A0=A0 13870000 =B1=A0 2=
%=A0 numa-vmstat.node0.numa_local=0A=
=A0=A0=A0=A0=A0 7029=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +25.1%=A0=A0=A0=A0=A0=A0=
 8796 =B1=A0 8%=A0 numa-vmstat.node1.nr_kernel_stack=0A=
=A0=A0=A0 678.67 =B1=A0 8%=A0=A0=A0 +152.6%=A0=A0=A0=A0=A0=A0 1714 =B1 26%=
=A0 numa-vmstat.node1.nr_page_table_pages=0A=
=A0=A0=A0=A0 25872=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +20.1%=A0=A0=A0=A0=A0 3106=
2 =B1=A0 9%=A0 numa-vmstat.node1.nr_slab_unreclaimable=0A=
=A0=A0 9970820=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +42.6%=A0=A0 14214395=A0=A0=A0=
=A0=A0=A0=A0 numa-vmstat.node1.numa_hit=0A=
=A0=A0 9810384=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +43.4%=A0=A0 14063434=A0=A0=A0=
=A0=A0=A0=A0 numa-vmstat.node1.numa_local=0A=
=A0=A0=A0=A0=A0 8132 =B1 26%=A0=A0=A0=A0 +46.4%=A0=A0=A0=A0=A0 11904 =B1 24=
%=A0 numa-vmstat.node2.nr_slab_reclaimable=0A=
=A0=A0 9969168=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +43.4%=A0=A0 14294976 =B1=A0 2=
%=A0 numa-vmstat.node2.numa_hit=0A=
=A0=A0 9812426=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +44.6%=A0=A0 14186949 =B1=A0 3=
%=A0 numa-vmstat.node2.numa_local=0A=
=A0=A0=A0 726.67 =B1 12%=A0=A0=A0 +158.7%=A0=A0=A0=A0=A0=A0 1879 =B1 26%=A0=
 numa-vmstat.node3.nr_page_table_pages=0A=
=A0=A0=A0=A0 27327 =B1=A0 4%=A0=A0=A0=A0 +13.9%=A0=A0=A0=A0=A0 31114 =B1 12=
%=A0 numa-vmstat.node3.nr_slab_unreclaimable=0A=
=A0=A0 9719726=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +44.0%=A0=A0 13991557 =B1=A0 2=
%=A0 numa-vmstat.node3.numa_hit=0A=
=A0=A0 9615461=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +44.1%=A0=A0 13853485 =B1=A0 2=
%=A0 numa-vmstat.node3.numa_local=0A=
=A0=A0=A0 104269 =B1 49%=A0=A0=A0=A0 +32.4%=A0=A0=A0=A0 138078 =B1 20%=A0 n=
uma-vmstat.node3.numa_other=0A=
=A0=A0=A0=A0 67226 =B1=A0 4%=A0=A0=A0=A0 -12.4%=A0=A0=A0=A0=A0 58905=A0=A0=
=A0=A0=A0=A0=A0 proc-vmstat.nr_active_anon=0A=
=A0=A0=A0 316527=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -3.1%=A0=A0=A0=A0 306823=
=A0=A0=A0=A0=A0=A0=A0 proc-vmstat.nr_file_pages=0A=
=A0=A0=A0=A0 92663=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -2.9%=A0=A0=A0=A0=A0 89=
935=A0=A0=A0=A0=A0=A0=A0 proc-vmstat.nr_inactive_anon=0A=
=A0=A0=A0=A0 33012=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +9.3%=A0=A0=A0=A0=A0 36=
075 =B1=A0 2%=A0 proc-vmstat.nr_kernel_stack=0A=
=A0=A0=A0=A0=A0 4865=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +59.3%=A0=A0=A0=A0=A0=A0=
 7749 =B1=A0 4%=A0 proc-vmstat.nr_page_table_pages=0A=
=A0=A0=A0=A0 76214 =B1=A0 4%=A0=A0=A0=A0 -12.7%=A0=A0=A0=A0=A0 66510=A0=A0=
=A0=A0=A0=A0=A0 proc-vmstat.nr_shmem=0A=
=A0=A0=A0=A0 34346=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +5.8%=A0=A0=A0=A0=A0 36=
334=A0=A0=A0=A0=A0=A0=A0 proc-vmstat.nr_slab_reclaimable=0A=
=A0=A0=A0 120937=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +11.5%=A0=A0=A0=A0 134852=A0=
=A0=A0=A0=A0=A0=A0 proc-vmstat.nr_slab_unreclaimable=0A=
=A0=A0=A0=A0 67226 =B1=A0 4%=A0=A0=A0=A0 -12.4%=A0=A0=A0=A0=A0 58905=A0=A0=
=A0=A0=A0=A0=A0 proc-vmstat.nr_zone_active_anon=0A=
=A0=A0=A0=A0 92663=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -2.9%=A0=A0=A0=A0=A0 89=
935=A0=A0=A0=A0=A0=A0=A0 proc-vmstat.nr_zone_inactive_anon=0A=
=A0=A0=A0 152011 =B1=A0 9%=A0=A0=A0=A0 -72.0%=A0=A0=A0=A0=A0 42500 =B1 30%=
=A0 proc-vmstat.numa_hint_faults=0A=
=A0 75604538=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +44.9%=A0 1.095e+08=A0=A0=A0=A0=
=A0=A0=A0 proc-vmstat.numa_hit=0A=
=A0 75344552=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +45.0%=A0 1.093e+08=A0=A0=A0=A0=
=A0=A0=A0 proc-vmstat.numa_local=0A=
=A0=A0=A0 129725 =B1 13%=A0=A0=A0=A0 -78.5%=A0=A0=A0=A0=A0 27855 =B1 33%=A0=
 proc-vmstat.numa_pages_migrated=0A=
=A0=A0=A0 440421 =B1=A0 8%=A0=A0=A0=A0 -27.0%=A0=A0=A0=A0 321634 =B1 22%=A0=
 proc-vmstat.numa_pte_updates=0A=
=A0=A0=A0 187992 =B1=A0 4%=A0=A0=A0=A0=A0 +5.4%=A0=A0=A0=A0 198156=A0=A0=A0=
=A0=A0=A0=A0 proc-vmstat.pgactivate=0A=
=A0 83223343=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +45.7%=A0 1.213e+08=A0=A0=A0=A0=
=A0=A0=A0 proc-vmstat.pgalloc_normal=0A=
=A01.056e+08=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +44.3%=A0 1.524e+08=A0=A0=A0=A0=
=A0=A0=A0 proc-vmstat.pgfault=0A=
=A0 83115624=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +45.8%=A0 1.212e+08=A0=A0=A0=A0=
=A0=A0=A0 proc-vmstat.pgfree=0A=
=A0=A0=A0 129725 =B1 13%=A0=A0=A0=A0 -78.5%=A0=A0=A0=A0=A0 27855 =B1 33%=A0=
 proc-vmstat.pgmigrate_success=0A=
=A0 10628125=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +46.1%=A0=A0 15525117=A0=A0=A0=
=A0=A0=A0=A0 proc-vmstat.pgreuse=0A=
=A0=A0=A0=A0 13330 =B1 54%=A0=A0=A0 +717.2%=A0=A0=A0=A0 108933 =B1 77%=A0 s=
ched_debug.cfs_rq:/.MIN_vruntime.avg=0A=
=A0=A0=A0 184231 =B1 54%=A0=A0=A0 +190.7%=A0=A0=A0=A0 535537 =B1 48%=A0 sch=
ed_debug.cfs_rq:/.MIN_vruntime.stddev=0A=
=A0=A0=A0=A0=A0 6040 =B1=A0 6%=A0=A0=A0 +338.5%=A0=A0=A0=A0=A0 26486 =B1 51=
%=A0 sched_debug.cfs_rq:/.load.avg=0A=
=A0=A0=A0 284313 =B1 37%=A0=A0=A0 +159.7%=A0=A0=A0=A0 738429 =B1 14%=A0 sch=
ed_debug.cfs_rq:/.load.max=0A=
=A0=A0=A0=A0=A0 1180 =B1 35%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=A0=
=A0=A0=A0=A0=A0 sched_debug.cfs_rq:/.load.min=0A=
=A0=A0=A0=A0 22088 =B1 35%=A0=A0=A0 +398.6%=A0=A0=A0=A0 110141 =B1 30%=A0 s=
ched_debug.cfs_rq:/.load.stddev=0A=
=A0=A0=A0=A0 13330 =B1 54%=A0=A0=A0 +717.2%=A0=A0=A0=A0 108933 =B1 77%=A0 s=
ched_debug.cfs_rq:/.max_vruntime.avg=0A=
=A0=A0=A0 184231 =B1 54%=A0=A0=A0 +190.7%=A0=A0=A0=A0 535537 =B1 48%=A0 sch=
ed_debug.cfs_rq:/.max_vruntime.stddev=0A=
=A0 16468615=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -51.1%=A0=A0=A0 8045534 =B1 11%=
=A0 sched_debug.cfs_rq:/.min_vruntime.avg=0A=
=A0 16715699=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -50.1%=A0=A0=A0 8341867 =B1 11%=
=A0 sched_debug.cfs_rq:/.min_vruntime.max=0A=
=A0 15817769=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -51.3%=A0=A0=A0 7697369 =B1 11%=
=A0 sched_debug.cfs_rq:/.min_vruntime.min=0A=
=A0=A0=A0=A0=A0 0.71 =B1 11%=A0=A0=A0=A0 -47.8%=A0=A0=A0=A0=A0=A0 0.37 =B1 =
14%=A0 sched_debug.cfs_rq:/.nr_running.avg=0A=
=A0=A0=A0=A0=A0 1.17=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +19.3%=A0=A0=A0=A0=A0=A0=
 1.39 =B1=A0 4%=A0 sched_debug.cfs_rq:/.nr_running.max=0A=
=A0=A0=A0=A0=A0 0.22 =B1 35%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=A0=
=A0=A0=A0=A0=A0 sched_debug.cfs_rq:/.nr_running.min=0A=
=A0=A0=A0=A0=A0 0.14 =B1 18%=A0=A0=A0=A0 +74.2%=A0=A0=A0=A0=A0=A0 0.25 =B1=
=A0 6%=A0 sched_debug.cfs_rq:/.nr_running.stddev=0A=
=A0=A0=A0 694.83 =B1 15%=A0=A0=A0=A0 -51.9%=A0=A0=A0=A0 334.48 =B1 20%=A0 s=
ched_debug.cfs_rq:/.runnable_avg.avg=0A=
=A0=A0=A0 110.72 =B1 51%=A0=A0=A0=A0 -90.4%=A0=A0=A0=A0=A0 10.63 =B1114%=A0=
 sched_debug.cfs_rq:/.runnable_avg.min=0A=
=A0=A0=A0 155.35 =B1 11%=A0=A0=A0=A0 +42.5%=A0=A0=A0=A0 221.31 =B1=A0 9%=A0=
 sched_debug.cfs_rq:/.runnable_avg.stddev=0A=
=A0=A0=A0=A0 64422 =B1 94%=A0=A0=A0 +295.3%=A0=A0=A0=A0 254650 =B1 19%=A0 s=
ched_debug.cfs_rq:/.spread0.avg=0A=
=A0=A0=A0 311765 =B1 14%=A0=A0=A0=A0 +76.7%=A0=A0=A0=A0 550961 =B1 14%=A0 s=
ched_debug.cfs_rq:/.spread0.max=0A=
=A0=A0 -587893=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -84.1%=A0=A0=A0=A0 -93210=A0=
=A0=A0=A0=A0=A0=A0 sched_debug.cfs_rq:/.spread0.min=0A=
=A0=A0=A0 685.90 =B1 14%=A0=A0=A0=A0 -56.7%=A0=A0=A0=A0 297.04 =B1 23%=A0 s=
ched_debug.cfs_rq:/.util_avg.avg=0A=
=A0=A0=A0 100.39 =B1 59%=A0=A0=A0=A0 -90.9%=A0=A0=A0=A0=A0=A0 9.12 =B1125%=
=A0 sched_debug.cfs_rq:/.util_avg.min=0A=
=A0=A0=A0 153.19 =B1 12%=A0=A0=A0=A0 +28.3%=A0=A0=A0=A0 196.53 =B1 12%=A0 s=
ched_debug.cfs_rq:/.util_avg.stddev=0A=
=A0=A0=A0 398.32 =B1 19%=A0=A0=A0=A0 -79.6%=A0=A0=A0=A0=A0 81.24 =B1 25%=A0=
 sched_debug.cfs_rq:/.util_est_enqueued.avg=0A=
=A0=A0=A0 932.06 =B1=A0 8%=A0=A0=A0=A0 -26.5%=A0=A0=A0=A0 684.67 =B1 16%=A0=
 sched_debug.cfs_rq:/.util_est_enqueued.max=0A=
=A0=A0=A0=A0=A0 0.28 =B1 28%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=A0=
=A0=A0=A0=A0=A0 sched_debug.cfs_rq:/.util_est_enqueued.min=0A=
=A0=A0=A0 186.70 =B1 17%=A0=A0=A0=A0 -31.0%=A0=A0=A0=A0 128.84 =B1 18%=A0 s=
ched_debug.cfs_rq:/.util_est_enqueued.stddev=0A=
=A0=A0=A0=A0 42223 =B1 22%=A0=A0=A0=A0 +72.6%=A0=A0=A0=A0=A0 72869 =B1 21%=
=A0 sched_debug.cpu.avg_idle.min=0A=
=A0=A0=A0 513534 =B1 67%=A0=A0=A0=A0 -58.1%=A0=A0=A0=A0 214959 =B1=A0 3%=A0=
 sched_debug.cpu.avg_idle.stddev=0A=
=A0=A0=A0=A0 69440 =B1 18%=A0=A0=A0=A0 -53.1%=A0=A0=A0=A0=A0 32566 =B1 23%=
=A0 sched_debug.cpu.curr->pid.avg=0A=
=A0=A0=A0 465.44 =B1 54%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=A0=A0=
=A0=A0=A0=A0 sched_debug.cpu.curr->pid.min=0A=
=A0=A0=A0=A0=A0 0.71 =B1 11%=A0=A0=A0=A0 -40.6%=A0=A0=A0=A0=A0=A0 0.42 =B1=
=A0 9%=A0 sched_debug.cpu.nr_running.avg=0A=
=A0=A0=A0=A0=A0 0.22 =B1 35%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=A0=
=A0=A0=A0=A0=A0 sched_debug.cpu.nr_running.min=0A=
=A0=A0=A0=A0=A0 0.18 =B1 10%=A0=A0=A0=A0 +68.8%=A0=A0=A0=A0=A0=A0 0.31 =B1=
=A0 5%=A0 sched_debug.cpu.nr_running.stddev=0A=
=A0=A0=A0=A0 21723 =B1=A0 2%=A0=A0=A0=A0 +35.3%=A0=A0=A0=A0=A0 29395 =B1=A0=
 9%=A0 sched_debug.cpu.nr_switches.avg=0A=
=A0=A0=A0=A0 37415 =B1 16%=A0=A0=A0=A0 +23.6%=A0=A0=A0=A0=A0 46248 =B1=A0 5=
%=A0 sched_debug.cpu.nr_switches.max=0A=
=A0=A0=A0=A0 17608=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +44.3%=A0=A0=A0=A0=A0 2541=
7 =B1 10%=A0 sched_debug.cpu.nr_switches.min=0A=
=A0=A0=A0 161.39 =B1 12%=A0=A0=A0=A0 +47.1%=A0=A0=A0=A0 237.34 =B1 18%=A0 s=
ched_debug.cpu.nr_uninterruptible.max=0A=
=A0=A0=A0 -54.78=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +48.6%=A0=A0=A0=A0 -81.42=A0=
=A0=A0=A0=A0=A0=A0 sched_debug.cpu.nr_uninterruptible.min=0A=
=A0=A0=A0=A0 24.07 =B1=A0 4%=A0=A0=A0=A0 +58.5%=A0=A0=A0=A0=A0 38.15 =B1 11=
%=A0 sched_debug.cpu.nr_uninterruptible.stddev=0A=
=A0=A0=A0=A0 11566=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +11.1%=A0=A0=A0=A0=A0 1284=
9=A0=A0=A0=A0=A0=A0=A0 slabinfo.Acpi-State.active_objs=0A=
=A0=A0=A0=A0 11566=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +11.1%=A0=A0=A0=A0=A0 1284=
9=A0=A0=A0=A0=A0=A0=A0 slabinfo.Acpi-State.num_objs=0A=
=A0=A0=A0 240075=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +13.6%=A0=A0=A0=A0 272838=A0=
=A0=A0=A0=A0=A0=A0 slabinfo.dentry.active_objs=0A=
=A0=A0=A0=A0=A0 5793=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +13.6%=A0=A0=A0=A0=A0=A0=
 6580=A0=A0=A0=A0=A0=A0=A0 slabinfo.dentry.active_slabs=0A=
=A0=A0=A0 243365=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +13.6%=A0=A0=A0=A0 276386=A0=
=A0=A0=A0=A0=A0=A0 slabinfo.dentry.num_objs=0A=
=A0=A0=A0=A0=A0 5793=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +13.6%=A0=A0=A0=A0=A0=A0=
 6580=A0=A0=A0=A0=A0=A0=A0 slabinfo.dentry.num_slabs=0A=
=A0=A0=A0 955.00 =B1=A0 9%=A0=A0=A0=A0 +16.4%=A0=A0=A0=A0=A0=A0 1112 =B1=A0=
 7%=A0 slabinfo.file_lock_cache.active_objs=0A=
=A0=A0=A0 955.00 =B1=A0 9%=A0=A0=A0=A0 +16.4%=A0=A0=A0=A0=A0=A0 1112 =B1=A0=
 7%=A0 slabinfo.file_lock_cache.num_objs=0A=
=A0=A0=A0=A0 14271=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +14.7%=A0=A0=A0=A0=A0 1636=
6=A0=A0=A0=A0=A0=A0=A0 slabinfo.files_cache.active_objs=0A=
=A0=A0=A0=A0 14271=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +14.7%=A0=A0=A0=A0=A0 1636=
6=A0=A0=A0=A0=A0=A0=A0 slabinfo.files_cache.num_objs=0A=
=A0=A0=A0 145916=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +52.7%=A0=A0=A0=A0 222770 =
=B1=A0 2%=A0 slabinfo.filp.active_objs=0A=
=A0=A0=A0=A0=A0 2300=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +53.0%=A0=A0=A0=A0=A0=A0=
 3519 =B1=A0 2%=A0 slabinfo.filp.active_slabs=0A=
=A0=A0=A0 147261=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +53.0%=A0=A0=A0=A0 225274 =
=B1=A0 2%=A0 slabinfo.filp.num_objs=0A=
=A0=A0=A0=A0=A0 2300=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +53.0%=A0=A0=A0=A0=A0=A0=
 3519 =B1=A0 2%=A0 slabinfo.filp.num_slabs=0A=
=A0=A0=A0=A0=A0 1319 =B1 14%=A0=A0=A0=A0 +26.2%=A0=A0=A0=A0=A0=A0 1664 =B1=
=A0 8%=A0 slabinfo.khugepaged_mm_slot.active_objs=0A=
=A0=A0=A0=A0=A0 1319 =B1 14%=A0=A0=A0=A0 +26.2%=A0=A0=A0=A0=A0=A0 1664 =B1=
=A0 8%=A0 slabinfo.khugepaged_mm_slot.num_objs=0A=
=A0=A0=A0=A0=A0 1037=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +19.6%=A0=A0=A0=A0=A0=A0=
 1240=A0=A0=A0=A0=A0=A0=A0 slabinfo.kmalloc-512.active_slabs=0A=
=A0=A0=A0=A0 66437=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +19.5%=A0=A0=A0=A0=A0 7942=
4=A0=A0=A0=A0=A0=A0=A0 slabinfo.kmalloc-512.num_objs=0A=
=A0=A0=A0=A0=A0 1037=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +19.6%=A0=A0=A0=A0=A0=A0=
 1240=A0=A0=A0=A0=A0=A0=A0 slabinfo.kmalloc-512.num_slabs=0A=
=A0=A0=A0 114959=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +9.0%=A0=A0=A0=A0 125273=
=A0=A0=A0=A0=A0=A0=A0 slabinfo.kmalloc-8.active_objs=0A=
=A0=A0=A0=A0=A0 4536 =B1=A0 5%=A0=A0=A0=A0=A0 +7.2%=A0=A0=A0=A0=A0=A0 4862 =
=B1=A0 3%=A0 slabinfo.kmalloc-rcl-64.active_objs=0A=
=A0=A0=A0=A0=A0 4536 =B1=A0 5%=A0=A0=A0=A0=A0 +7.2%=A0=A0=A0=A0=A0=A0 4862 =
=B1=A0 3%=A0 slabinfo.kmalloc-rcl-64.num_objs=0A=
=A0=A0=A0=A0 10920=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +18.9%=A0=A0=A0=A0=A0 1297=
8=A0=A0=A0=A0=A0=A0=A0 slabinfo.mm_struct.active_objs=0A=
=A0=A0=A0=A0 10920=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +18.9%=A0=A0=A0=A0=A0 1297=
9=A0=A0=A0=A0=A0=A0=A0 slabinfo.mm_struct.num_objs=0A=
=A0=A0=A0=A0=A0 1104 =B1=A0 5%=A0=A0=A0=A0 -16.9%=A0=A0=A0=A0 917.00 =B1 10=
%=A0 slabinfo.mnt_cache.active_objs=0A=
=A0=A0=A0=A0=A0 1104 =B1=A0 5%=A0=A0=A0=A0 -16.9%=A0=A0=A0=A0 917.00 =B1 10=
%=A0 slabinfo.mnt_cache.num_objs=0A=
=A0=A0=A0=A0=A0 1551=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +14.3%=A0=A0=A0=A0=A0=A0=
 1773 =B1=A0 2%=A0 slabinfo.names_cache.active_objs=0A=
=A0=A0=A0=A0=A0 1551=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +14.3%=A0=A0=A0=A0=A0=A0=
 1773 =B1=A0 2%=A0 slabinfo.names_cache.num_objs=0A=
=A0=A0=A0=A0 35694 =B1=A0 2%=A0=A0=A0=A0 +49.3%=A0=A0=A0=A0=A0 53295 =B1=A0=
 4%=A0 slabinfo.pid.active_objs=0A=
=A0=A0=A0 557.00 =B1=A0 2%=A0=A0=A0=A0 +49.4%=A0=A0=A0=A0 832.25 =B1=A0 4%=
=A0 slabinfo.pid.active_slabs=0A=
=A0=A0=A0=A0 35694 =B1=A0 2%=A0=A0=A0=A0 +49.3%=A0=A0=A0=A0=A0 53295 =B1=A0=
 4%=A0 slabinfo.pid.num_objs=0A=
=A0=A0=A0 557.00 =B1=A0 2%=A0=A0=A0=A0 +49.4%=A0=A0=A0=A0 832.25 =B1=A0 4%=
=A0 slabinfo.pid.num_slabs=0A=
=A0=A0=A0=A0=A0 8786=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +20.2%=A0=A0=A0=A0=A0 10=
558=A0=A0=A0=A0=A0=A0=A0 slabinfo.sighand_cache.active_objs=0A=
=A0=A0=A0 590.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +20.3%=A0=A0=A0=A0 709.75=A0=
=A0=A0=A0=A0=A0=A0 slabinfo.sighand_cache.active_slabs=0A=
=A0=A0=A0=A0=A0 8858=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +20.3%=A0=A0=A0=A0=A0 10=
654=A0=A0=A0=A0=A0=A0=A0 slabinfo.sighand_cache.num_objs=0A=
=A0=A0=A0 590.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +20.3%=A0=A0=A0=A0 709.75=A0=
=A0=A0=A0=A0=A0=A0 slabinfo.sighand_cache.num_slabs=0A=
=A0=A0=A0=A0=A0 8502=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +11.6%=A0=A0=A0=A0=A0=A0=
 9489 =B1=A0 2%=A0 slabinfo.sock_inode_cache.active_objs=0A=
=A0=A0=A0=A0=A0 8502=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +11.6%=A0=A0=A0=A0=A0=A0=
 9489 =B1=A0 2%=A0 slabinfo.sock_inode_cache.num_objs=0A=
=A0=A0=A0=A0 39805 =B1=A0 2%=A0=A0=A0=A0 +45.4%=A0=A0=A0=A0=A0 57892 =B1=A0=
 2%=A0 slabinfo.task_delay_info.active_objs=0A=
=A0=A0=A0 780.00 =B1=A0 2%=A0=A0=A0=A0 +45.5%=A0=A0=A0=A0=A0=A0 1135 =B1=A0=
 2%=A0 slabinfo.task_delay_info.active_slabs=0A=
=A0=A0=A0=A0 39805 =B1=A0 2%=A0=A0=A0=A0 +45.5%=A0=A0=A0=A0=A0 57905 =B1=A0=
 2%=A0 slabinfo.task_delay_info.num_objs=0A=
=A0=A0=A0 780.00 =B1=A0 2%=A0=A0=A0=A0 +45.5%=A0=A0=A0=A0=A0=A0 1135 =B1=A0=
 2%=A0 slabinfo.task_delay_info.num_slabs=0A=
=A0=A0=A0=A0=A0 3088=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +29.3%=A0=A0=A0=A0=A0=A0=
 3992 =B1=A0 2%=A0 slabinfo.task_struct.active_objs=0A=
=A0=A0=A0=A0=A0 3098=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +29.3%=A0=A0=A0=A0=A0=A0=
 4005 =B1=A0 2%=A0 slabinfo.task_struct.active_slabs=0A=
=A0=A0=A0=A0=A0 3098=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +29.3%=A0=A0=A0=A0=A0=A0=
 4005 =B1=A0 2%=A0 slabinfo.task_struct.num_objs=0A=
=A0=A0=A0=A0=A0 3098=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +29.3%=A0=A0=A0=A0=A0=A0=
 4005 =B1=A0 2%=A0 slabinfo.task_struct.num_slabs=0A=
=A01.353e+10=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +11.8%=A0 1.513e+10=A0=A0=A0=A0=
=A0=A0=A0 perf-stat.i.branch-instructions=0A=
=A0 84012986 =B1=A0 5%=A0=A0=A0=A0 +46.6%=A0 1.232e+08 =B1=A0 6%=A0 perf-st=
at.i.branch-misses=0A=
=A0=A0=A0=A0 31.81 =B1 12%=A0=A0=A0=A0 -10.8=A0=A0=A0=A0=A0=A0 21.01 =B1 21=
%=A0 perf-stat.i.cache-miss-rate%=0A=
=A0 68723351 =B1=A0 2%=A0=A0=A0=A0 -10.6%=A0=A0 61409511 =B1=A0 4%=A0 perf-=
stat.i.cache-misses=0A=
=A02.121e+08 =B1 10%=A0=A0=A0=A0 +57.2%=A0 3.333e+08 =B1=A0 8%=A0 perf-stat=
.i.cache-references=0A=
=A0=A0=A0=A0 25583 =B1=A0 2%=A0=A0=A0=A0 +51.4%=A0=A0=A0=A0=A0 38727=A0=A0=
=A0=A0=A0=A0=A0 perf-stat.i.context-switches=0A=
=A0=A0=A0=A0=A0 5.21 =B1=A0 3%=A0=A0=A0=A0 -25.2%=A0=A0=A0=A0=A0=A0 3.90 =
=B1=A0 5%=A0 perf-stat.i.cpi=0A=
=A0=A0=A0 192200=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +7.5%=A0=A0=A0=A0 206633=
=A0=A0=A0=A0=A0=A0=A0 perf-stat.i.cpu-clock=0A=
=A0 3.37e+11=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -28.3%=A0 2.415e+11=A0=A0=A0=A0=
=A0=A0=A0 perf-stat.i.cpu-cycles=0A=
=A0=A0=A0=A0=A0 3432=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +61.5%=A0=A0=A0=A0=A0=A0=
 5541 =B1=A0 3%=A0 perf-stat.i.cpu-migrations=0A=
=A0=A0=A0=A0=A0 4302=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -29.4%=A0=A0=A0=A0=A0=A0=
 3039 =B1=A0 8%=A0 perf-stat.i.cycles-between-cache-misses=0A=
=A0=A0 2726072 =B1 23%=A0=A0=A0=A0 +52.3%=A0=A0=A0 4151327 =B1 26%=A0 perf-=
stat.i.dTLB-load-misses=0A=
=A01.215e+10=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +6.3%=A0 1.292e+10=A0=A0=A0=
=A0=A0=A0=A0 perf-stat.i.dTLB-loads=0A=
=A0=A0=A0 941111 =B1 11%=A0=A0=A0=A0 +46.9%=A0=A0=A0 1382681 =B1 11%=A0 per=
f-stat.i.dTLB-store-misses=0A=
=A02.493e+09=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +48.4%=A0 3.701e+09=A0=A0=A0=A0=
=A0=A0=A0 perf-stat.i.dTLB-stores=0A=
=A0=A0=A0=A0 71.80 =B1=A0 4%=A0=A0=A0=A0=A0 -6.7=A0=A0=A0=A0=A0=A0 65.13=A0=
=A0=A0=A0=A0=A0=A0 perf-stat.i.iTLB-load-miss-rate%=0A=
=A0=A0 8355924 =B1=A0 6%=A0=A0=A0=A0 +47.0%=A0=A0 12280660 =B1=A0 7%=A0 per=
f-stat.i.iTLB-load-misses=0A=
=A0=A0 3268044 =B1 18%=A0=A0=A0=A0 +65.6%=A0=A0=A0 5412376 =B1=A0 8%=A0 per=
f-stat.i.iTLB-loads=0A=
=A06.464e+10=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +19.2%=A0 7.704e+10=A0=A0=A0=A0=
=A0=A0=A0 perf-stat.i.instructions=0A=
=A0=A0=A0=A0=A0 6911 =B1=A0 3%=A0=A0=A0=A0 -32.1%=A0=A0=A0=A0=A0=A0 4691 =
=B1=A0 6%=A0 perf-stat.i.instructions-per-iTLB-miss=0A=
=A0=A0=A0=A0=A0 0.23=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +28.9%=A0=A0=A0=A0=A0=A0=
 0.30=A0=A0=A0=A0=A0=A0=A0 perf-stat.i.ipc=0A=
=A0=A0=A0 124.96=A0=A0=A0=A0=A0=A0=A0=A0=A0 +101.4%=A0=A0=A0=A0 251.73 =B1=
=A0 2%=A0 perf-stat.i.major-faults=0A=
=A0=A0=A0=A0=A0 1.76=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -41.2%=A0=A0=A0=A0=A0=A0=
 1.03=A0=A0=A0=A0=A0=A0=A0 perf-stat.i.metric.GHz=0A=
=A0=A0=A0=A0=A0 0.56 =B1=A0 8%=A0=A0=A0=A0 +32.5%=A0=A0=A0=A0=A0=A0 0.75 =
=B1=A0 7%=A0 perf-stat.i.metric.K/sec=0A=
=A0=A0=A0 332691=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +49.2%=A0=A0=A0=A0 496370=A0=
=A0=A0=A0=A0=A0=A0 perf-stat.i.minor-faults=0A=
=A0=A0=A0=A0 91.27=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -4.0=A0=A0=A0=A0=A0=A0 =
87.22=A0=A0=A0=A0=A0=A0=A0 perf-stat.i.node-load-miss-rate%=0A=
=A0 18748059=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -13.0%=A0=A0 16311904 =B1=A0 3%=
=A0 perf-stat.i.node-load-misses=0A=
=A0=A0 1587953=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +50.0%=A0=A0=A0 2382313=A0=A0=
=A0=A0=A0=A0=A0 perf-stat.i.node-loads=0A=
=A0=A0=A0=A0 86.40=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -8.3=A0=A0=A0=A0=A0=A0 =
78.07 =B1=A0 2%=A0 perf-stat.i.node-store-miss-rate%=0A=
=A0=A0 9547999=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -19.9%=A0=A0=A0 7644037 =B1=A0=
 2%=A0 perf-stat.i.node-store-misses=0A=
=A0=A0 1064509=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +92.2%=A0=A0=A0 2045699 =B1=A0=
 2%=A0 perf-stat.i.node-stores=0A=
=A0=A0=A0 332816=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +49.2%=A0=A0=A0=A0 496622=A0=
=A0=A0=A0=A0=A0=A0 perf-stat.i.page-faults=0A=
=A0=A0=A0 192200=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +7.5%=A0=A0=A0=A0 206633=
=A0=A0=A0=A0=A0=A0=A0 perf-stat.i.task-clock=0A=
=A0=A0=A0=A0=A0 3.25 =B1=A0 9%=A0=A0=A0=A0 +36.0%=A0=A0=A0=A0=A0=A0 4.42 =
=B1=A0 7%=A0 perf-stat.overall.MPKI=0A=
=A0=A0=A0=A0=A0 0.62 =B1=A0 5%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.8=
3 =B1=A0 5%=A0 perf-stat.overall.branch-miss-rate%=0A=
=A0=A0=A0=A0 32.96 =B1 10%=A0=A0=A0=A0 -13.4=A0=A0=A0=A0=A0=A0 19.58 =B1 11=
%=A0 perf-stat.overall.cache-miss-rate%=0A=
=A0=A0=A0=A0=A0 5.25=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -42.4%=A0=A0=A0=A0=A0=A0=
 3.02=A0=A0=A0=A0=A0=A0=A0 perf-stat.overall.cpi=0A=
=A0=A0=A0=A0=A0 4953=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -28.7%=A0=A0=A0=A0=A0=A0=
 3533 =B1=A0 4%=A0 perf-stat.overall.cycles-between-cache-misses=0A=
=A0=A0=A0=A0=A0 0.02 =B1 23%=A0=A0=A0=A0=A0 +0.0=A0=A0=A0=A0=A0=A0=A0 0.03 =
=B1 24%=A0 perf-stat.overall.dTLB-load-miss-rate%=0A=
=A0=A0=A0=A0 72.34 =B1=A0 3%=A0=A0=A0=A0=A0 -3.1=A0=A0=A0=A0=A0=A0 69.29=A0=
=A0=A0=A0=A0=A0=A0 perf-stat.overall.iTLB-load-miss-rate%=0A=
=A0=A0=A0=A0=A0 7868 =B1=A0 6%=A0=A0=A0=A0 -20.0%=A0=A0=A0=A0=A0=A0 6292 =
=B1=A0 7%=A0 perf-stat.overall.instructions-per-iTLB-miss=0A=
=A0=A0=A0=A0=A0 0.19=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +73.5%=A0=A0=A0=A0=A0=A0=
 0.33=A0=A0=A0=A0=A0=A0=A0 perf-stat.overall.ipc=0A=
=A0=A0=A0=A0 92.20=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -4.8=A0=A0=A0=A0=A0=A0 =
87.37=A0=A0=A0=A0=A0=A0=A0 perf-stat.overall.node-load-miss-rate%=0A=
=A0=A0=A0=A0 90.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -9.8=A0=A0=A0=A0=A0=A0 =
80.24=A0=A0=A0=A0=A0=A0=A0 perf-stat.overall.node-store-miss-rate%=0A=
=A0 19255954=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -23.1%=A0=A0 14811673=A0=A0=A0=
=A0=A0=A0=A0 perf-stat.overall.path-length=0A=
=A01.382e+10=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +5.2%=A0 1.454e+10=A0=A0=A0=
=A0=A0=A0=A0 perf-stat.ps.branch-instructions=0A=
=A0 85147082 =B1=A0 5%=A0=A0=A0=A0 +42.1%=A0=A0 1.21e+08 =B1=A0 5%=A0 perf-=
stat.ps.branch-misses=0A=
=A0 69832184 =B1=A0 2%=A0=A0=A0=A0=A0 -9.6%=A0=A0 63144472 =B1=A0 4%=A0 per=
f-stat.ps.cache-misses=0A=
=A02.141e+08 =B1=A0 9%=A0=A0=A0=A0 +52.0%=A0 3.254e+08 =B1=A0 8%=A0 perf-st=
at.ps.cache-references=0A=
=A0=A0=A0=A0 25647 =B1=A0 2%=A0=A0=A0=A0 +46.2%=A0=A0=A0=A0=A0 37498=A0=A0=
=A0=A0=A0=A0=A0 perf-stat.ps.context-switches=0A=
=A03.458e+11=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -35.6%=A0 2.227e+11=A0=A0=A0=A0=
=A0=A0=A0 perf-stat.ps.cpu-cycles=0A=
=A0=A0=A0=A0=A0 3456=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +55.5%=A0=A0=A0=A0=A0=A0=
 5375 =B1=A0 4%=A0 perf-stat.ps.cpu-migrations=0A=
=A0=A0 2731148 =B1 22%=A0=A0=A0=A0 +50.7%=A0=A0=A0 4114660 =B1 24%=A0 perf-=
stat.ps.dTLB-load-misses=0A=
=A0=A0=A0 951612 =B1 11%=A0=A0=A0=A0 +42.4%=A0=A0=A0 1354727 =B1 10%=A0 per=
f-stat.ps.dTLB-store-misses=0A=
=A02.534e+09=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +43.0%=A0 3.624e+09=A0=A0=A0=A0=
=A0=A0=A0 perf-stat.ps.dTLB-stores=0A=
=A0=A0 8410006 =B1=A0 6%=A0=A0=A0=A0 +39.9%=A0=A0 11763281 =B1=A0 6%=A0 per=
f-stat.ps.iTLB-load-misses=0A=
=A0=A0 3251030 =B1 17%=A0=A0=A0=A0 +60.5%=A0=A0=A0 5218236 =B1=A0 7%=A0 per=
f-stat.ps.iTLB-loads=0A=
=A06.591e+10=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +11.7%=A0 7.364e+10=A0=A0=A0=A0=
=A0=A0=A0 perf-stat.ps.instructions=0A=
=A0=A0=A0 127.07=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +97.9%=A0=A0=A0=A0 251.44 =
=B1=A0 2%=A0 perf-stat.ps.major-faults=0A=
=A0=A0=A0 338752=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +44.5%=A0=A0=A0=A0 489644=A0=
=A0=A0=A0=A0=A0=A0 perf-stat.ps.minor-faults=0A=
=A0 19070733=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -11.1%=A0=A0 16952678 =B1=A0 4%=
=A0 perf-stat.ps.node-load-misses=0A=
=A0=A0 1613838=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +51.7%=A0=A0=A0 2448074=A0=A0=
=A0=A0=A0=A0=A0 perf-stat.ps.node-loads=0A=
=A0=A0 9716997=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -18.4%=A0=A0=A0 7933032 =B1=A0=
 2%=A0 perf-stat.ps.node-store-misses=0A=
=A0=A0 1079544=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +80.8%=A0=A0=A0 1952245=A0=A0=
=A0=A0=A0=A0=A0 perf-stat.ps.node-stores=0A=
=A0=A0=A0 338879=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +44.6%=A0=A0=A0=A0 489896=A0=
=A0=A0=A0=A0=A0=A0 perf-stat.ps.page-faults=0A=
=A02.009e+13=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +11.5%=A0 2.239e+13=A0=A0=A0=A0=
=A0=A0=A0 perf-stat.total.instructions=0A=
=A0=A0=A0=A0=A0 0.04 =B1 54%=A0=A0=A0 +278.3%=A0=A0=A0=A0=A0=A0 0.14 =B1 41=
%=A0 perf-sched.sch_delay.avg.ms.d_alloc_parallel.__lookup_slow.walk_compon=
ent.link_path_walk.part=0A=
=A0=A0=A0=A0=A0 0.11 =B1123%=A0=A0=A0 +813.3%=A0=A0=A0=A0=A0=A0 1.04 =B1120=
%=A0 perf-sched.sch_delay.avg.ms.d_alloc_parallel.__lookup_slow.walk_compon=
ent.path_lookupat.isra=0A=
=A0=A0=A0=A0=A0 0.03 =B1=A0 9%=A0=A0=A0 +210.5%=A0=A0=A0=A0=A0=A0 0.10 =B1 =
21%=A0 perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64=
_sys_exit_group.do_syscall_64=0A=
=A0=A0=A0=A0=A0 0.17 =B1 89%=A0=A0=A0 +210.6%=A0=A0=A0=A0=A0=A0 0.52 =B1 59=
%=A0 perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_sys=
call_64=0A=
=A0=A0=A0=A0=A0 0.05 =B1 34%=A0=A0 +1883.2%=A0=A0=A0=A0=A0=A0 0.91 =B1 48%=
=A0 perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_=
user_mode.asm_sysvec_apic_timer_interrupt.[unknown]=0A=
=A0=A0=A0=A0=A0 0.12 =B1 45%=A0=A0=A0 +772.8%=A0=A0=A0=A0=A0=A0 1.04 =B1 65=
%=A0 perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to=
_user_mode.asm_sysvec_call_function_single.[unknown]=0A=
=A0=A0=A0=A0=A0 0.09 =B1=A0 9%=A0=A0 +1004.3%=A0=A0=A0=A0=A0=A0 0.97 =B1 90=
%=A0 perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to=
_user_mode.asm_sysvec_reschedule_ipi.[unknown]=0A=
=A0=A0=A0=A0=A0 0.06 =B1 28%=A0=A0=A0 +390.8%=A0=A0=A0=A0=A0=A0 0.29 =B1 41=
%=A0 perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_=
user_mode.entry_SYSCALL_64_after_hwframe.[unknown]=0A=
=A0=A0=A0=A0=A0 0.63 =B1=A0 7%=A0=A0=A0=A0 +80.2%=A0=A0=A0=A0=A0=A0 1.13 =
=B1 21%=A0 perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_ex=
it_to_user_mode.ret_from_fork.[unknown]=0A=
=A0=A0=A0=A0=A0 0.07 =B1 16%=A0=A0=A0 +113.1%=A0=A0=A0=A0=A0=A0 0.14 =B1 21=
%=A0 perf-sched.sch_delay.avg.ms.io_schedule.__lock_page_killable.filemap_f=
ault.__do_fault=0A=
=A0=A0=A0=A0=A0 0.01 =B1=A0 7%=A0=A0=A0 +196.2%=A0=A0=A0=A0=A0=A0 0.02 =B1 =
65%=A0 perf-sched.sch_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_re=
ad=0A=
=A0=A0=A0=A0=A0 0.04 =B1 45%=A0=A0=A0 +742.5%=A0=A0=A0=A0=A0=A0 0.35 =B1 83=
%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__al=
loc_pages_nodemask.alloc_pages_vma.wp_page_copy=0A=
=A0=A0=A0=A0=A0 0.07 =B1 78%=A0=A0=A0=A0 -84.3%=A0=A0=A0=A0=A0=A0 0.01 =B11=
42%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__=
alloc_pages_nodemask.allocate_slab.___slab_alloc=0A=
=A0=A0=A0=A0=A0 0.04 =B1 79%=A0=A0 +2194.9%=A0=A0=A0=A0=A0=A0 0.89 =B1164%=
=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__all=
oc_pages_nodemask.pte_alloc_one.__pte_alloc=0A=
=A0=A0=A0=A0=A0 0.07 =B1 19%=A0=A0=A0=A0 -86.5%=A0=A0=A0=A0=A0=A0 0.01 =B1 =
59%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__=
anon_vma_prepare.do_fault.__handle_mm_fault=0A=
=A0=A0=A0=A0=A0 0.25 =B1105%=A0=A0=A0=A0 -98.2%=A0=A0=A0=A0=A0=A0 0.00 =B11=
37%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.co=
py_page_to_iter.generic_file_buffered_read.new_sync_read=0A=
=A0=A0=A0=A0=A0 0.40 =B1=A0 6%=A0=A0=A0=A0 +91.2%=A0=A0=A0=A0=A0=A0 0.77 =
=B1=A0 5%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resc=
hed.do_user_addr_fault.exc_page_fault.asm_exc_page_fault=0A=
=A0=A0=A0=A0=A0 0.08 =B1100%=A0=A0=A0=A0 -92.6%=A0=A0=A0=A0=A0=A0 0.01 =B1 =
94%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.do=
wn_write.__anon_vma_prepare.do_anonymous_page=0A=
=A0=A0=A0=A0=A0 0.03 =B1 79%=A0=A0=A0 +277.4%=A0=A0=A0=A0=A0=A0 0.12 =B1 73=
%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down=
_write.__vma_adjust.__split_vma=0A=
=A0=A0=A0=A0=A0 0.01 =B1 16%=A0 +1.5e+05%=A0=A0=A0=A0=A0=A0 8.25 =B1103%=A0=
 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_wri=
te.do_truncate.path_openat=0A=
=A0=A0=A0=A0=A0 0.04 =B1 19%=A0=A0=A0 +318.9%=A0=A0=A0=A0=A0=A0 0.16 =B1 44=
%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down=
_write.unlink_anon_vmas.free_pgtables=0A=
=A0=A0=A0=A0=A0 0.04 =B1=A0 7%=A0=A0 +1180.0%=A0=A0=A0=A0=A0=A0 0.51 =B1145=
%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down=
_write.unlink_file_vma.free_pgtables=0A=
=A0=A0=A0=A0=A0 0.00 =B1 10%=A0=A0=A0=A0 -89.3%=A0=A0=A0=A0=A0=A0 0.00 =B11=
73%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.do=
wn_write_killable.__vm_munmap.__x64_sys_munmap=0A=
=A0=A0=A0=A0=A0 0.07 =B1 54%=A0=A0=A0 +242.3%=A0=A0=A0=A0=A0=A0 0.26 =B1 62=
%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down=
_write_killable.vm_mmap_pgoff.elf_map=0A=
=A0=A0=A0=A0=A0 0.03 =B1 11%=A0=A0=A0=A0 -87.8%=A0=A0=A0=A0=A0=A0 0.00 =B1 =
13%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.do=
wn_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff=0A=
=A0=A0=A0=A0=A0 0.01 =B1 49%=A0 +1.3e+05%=A0=A0=A0=A0=A0=A0 8.04 =B1152%=A0=
 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.dput.do_=
unlinkat.do_syscall_64=0A=
=A0=A0=A0=A0=A0 0.10 =B1127%=A0 +16890.4%=A0=A0=A0=A0=A0 16.82 =B1163%=A0 p=
erf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.dput.done_=
path_create.do_linkat=0A=
=A0=A0=A0=A0=A0 0.13 =B1 18%=A0=A0=A0 +459.3%=A0=A0=A0=A0=A0=A0 0.71 =B1 18=
%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.dput=
.path_openat.do_filp_open=0A=
=A0=A0=A0=A0=A0 0.44 =B1118%=A0=A0=A0 +204.8%=A0=A0=A0=A0=A0=A0 1.33 =B1 94=
%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.dput=
.scan_positives.dcache_readdir=0A=
=A0=A0=A0=A0=A0 0.01 =B1 36%=A0=A0 +3156.9%=A0=A0=A0=A0=A0=A0 0.43 =B1 63%=
=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.dput.=
step_into.path_openat=0A=
=A0=A0=A0=A0=A0 0.07 =B1 21%=A0=A0=A0 +554.5%=A0=A0=A0=A0=A0=A0 0.46 =B1 93=
%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.dput=
.terminate_walk.path_openat=0A=
=A0=A0=A0=A0=A0 0.00 =B1141%=A0 +19625.0%=A0=A0=A0=A0=A0=A0 0.07 =B1150%=A0=
 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.generic_=
file_buffered_read.__kernel_read.load_elf_binary=0A=
=A0=A0=A0=A0=A0 0.08 =B1134%=A0=A0=A0 +686.6%=A0=A0=A0=A0=A0=A0 0.66 =B1 59=
%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem=
_cache_alloc.__d_alloc.d_alloc_cursor=0A=
=A0=A0=A0=A0=A0 0.04 =B1 37%=A0=A0=A0 +648.3%=A0=A0=A0=A0=A0=A0 0.33 =B1 28=
%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem=
_cache_alloc.security_file_alloc.__alloc_file=0A=
=A0=A0=A0=A0=A0 0.21 =B1 61%=A0=A0=A0=A0 -77.6%=A0=A0=A0=A0=A0=A0 0.05 =B11=
39%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.km=
em_cache_alloc.vm_area_alloc.__install_special_mapping=0A=
=A0=A0=A0=A0=A0 0.30 =B1 97%=A0=A0=A0=A0 -99.2%=A0=A0=A0=A0=A0=A0 0.00 =B1 =
34%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.km=
em_cache_alloc.vm_area_alloc.do_brk_flags=0A=
=A0=A0=A0=A0=A0 3.67 =B1140%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00 =B1173=
%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem=
_cache_alloc_node_trace.__get_vm_area_node.__vmalloc_node_range=0A=
=A0=A0=A0=A0=A0 0.05 =B1 51%=A0=A0=A0=A0 +75.6%=A0=A0=A0=A0=A0=A0 0.09 =B1 =
30%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.km=
em_cache_alloc_trace.perf_event_mmap.mmap_region=0A=
=A0=A0=A0=A0=A0 0.19 =B1 85%=A0=A0=A0=A0 -93.9%=A0=A0=A0=A0=A0=A0 0.01 =B11=
48%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.km=
em_cache_alloc_trace.perf_event_mmap.mprotect_fixup=0A=
=A0=A0=A0=A0=A0 0.01 =B1 66%=A0 +89763.4%=A0=A0=A0=A0=A0=A0 8.39 =B1106%=A0=
 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.mnt_want=
_write.path_openat.do_filp_open=0A=
=A0=A0=A0=A0=A0 0.01 =B1108%=A0=A0=A0 +903.8%=A0=A0=A0=A0=A0=A0 0.13 =B1129=
%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.mute=
x_lock.futex_exec_release.exec_mm_release=0A=
=A0=A0=A0=A0=A0 0.03 =B1 53%=A0=A0=A0=A0 -67.5%=A0=A0=A0=A0=A0=A0 0.01 =B1 =
83%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.mu=
tex_lock.futex_exit_release.exit_mm_release=0A=
=A0=A0=A0=A0=A0 0.11 =B1125%=A0=A0 +1883.9%=A0=A0=A0=A0=A0=A0 2.25 =B1 40%=
=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.smpbo=
ot_thread_fn.kthread.ret_from_fork=0A=
=A0=A0=A0=A0=A0 0.01 =B1 70%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=A0=
=A0=A0=A0=A0=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_r=
esched.stop_one_cpu.migrate_task_to.task_numa_migrate=0A=
=A0=A0=A0=A0=A0 0.30 =B1=A0 3%=A0=A0=A0 +308.2%=A0=A0=A0=A0=A0=A0 1.22 =B1 =
26%=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.st=
op_one_cpu.sched_exec.bprm_execve=0A=
=A0=A0=A0=A0=A0 0.08 =B1 68%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=A0=
=A0=A0=A0=A0=A0 perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_r=
esched.wait_for_completion.stop_two_cpus.migrate_swap=0A=
=A0=A0=A0=A0=A0 0.01 =B1103%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=A0=
=A0=A0=A0=A0=A0 perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.page_l=
ock_anon_vma_read.rmap_walk_anon.try_to_unmap=0A=
=A0=A0=A0=A0=A0 0.01 =B1106%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=A0=
=A0=A0=A0=A0=A0 perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.rmap_w=
alk_anon.remove_migration_ptes.migrate_pages=0A=
=A0=A0=A0=A0=A0 0.01 =B1 49%=A0=A0 +1115.0%=A0=A0=A0=A0=A0=A0 0.14 =B1143%=
=A0 perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.__vma_adjust.__sp=
lit_vma.__do_munmap=0A=
=A0=A0=A0=A0=A0 0.03 =B1 52%=A0=A0=A0=A0 -89.4%=A0=A0=A0=A0=A0=A0 0.00 =B11=
07%=A0 perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.anon_vma_clone=
.anon_vma_fork.dup_mmap=0A=
=A0=A0=A0=A0=A0 0.02 =B1 54%=A0=A0 +1681.5%=A0=A0=A0=A0=A0=A0 0.39 =B1 70%=
=A0 perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.do_unlinkat.do_sy=
scall_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 0.01 =B1 80%=A0=A0=A0 +507.1%=A0=A0=A0=A0=A0=A0 0.09 =B1 45=
%=A0 perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.dup_mmap.dup_mm.=
copy_process=0A=
=A0=A0=A0=A0=A0 0.02 =B1 24%=A0=A0 +1250.0%=A0=A0=A0=A0=A0=A0 0.26 =B1 68%=
=A0 perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.filename_create.d=
o_linkat.__x64_sys_link=0A=
=A0=A0=A0=A0=A0 0.07 =B1 65%=A0=A0=A0=A0 -87.3%=A0=A0=A0=A0=A0=A0 0.01 =B1 =
75%=A0 perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.unlink_anon_vm=
as.free_pgtables.exit_mmap=0A=
=A0=A0=A0=A0=A0 0.02 =B1 20%=A0=A0=A0 +232.6%=A0=A0=A0=A0=A0=A0 0.05 =B1 33=
%=A0 perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.unlink_file_vma.=
free_pgtables.exit_mmap=0A=
=A0=A0=A0=A0=A0 0.01 =B1 27%=A0=A0=A0 +363.9%=A0=A0=A0=A0=A0=A0 0.04 =B1 43=
%=A0 perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.vma_link.mmap_re=
gion.do_mmap=0A=
=A0=A0=A0=A0=A0 0.19 =B1 68%=A0=A0=A0=A0 -95.1%=A0=A0=A0=A0=A0=A0 0.01 =B1 =
13%=A0 perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.d=
o_epoll_wait.__x64_sys_epoll_wait=0A=
=A0=A0=A0=A0=A0 0.04 =B1 18%=A0=A0 +5366.5%=A0=A0=A0=A0=A0=A0 1.93 =B1 40%=
=A0 perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from=
_fork=0A=
=A0=A0=A0=A0=A0 0.04 =B1 39%=A0=A0=A0 +464.8%=A0=A0=A0=A0=A0=A0 0.24 =B1 60=
%=A0 perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.re=
t_from_fork=0A=
=A0=A0=A0=A0=A0 0.00 =B1141%=A0 +48300.0%=A0=A0=A0=A0=A0=A0 0.97 =B1170%=A0=
 perf-sched.sch_delay.avg.ms.schedule_timeout.wait_for_completion.__flush_w=
ork.lru_add_drain_all=0A=
=A0=A0=A0=A0=A0 0.20 =B1=A0 7%=A0=A0 +1238.1%=A0=A0=A0=A0=A0=A0 2.63 =B1 31=
%=A0 perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork=0A=
=A0=A0=A0=A0=A0 0.12 =B1 27%=A0=A0=A0=A0 -74.7%=A0=A0=A0=A0=A0=A0 0.03 =B11=
49%=A0 perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_ope=
n.path_openat=0A=
=A0=A0=A0=A0=A0 0.01 =B1=A0 7%=A0=A0 +9784.2%=A0=A0=A0=A0=A0=A0 1.25 =B1 18=
%=A0 perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork=0A=
=A0=A0=A0=A0=A0 5.01 =B1 31%=A0=A0=A0 +324.7%=A0=A0=A0=A0=A0 21.26 =B1 36%=
=A0 perf-sched.sch_delay.max.ms.d_alloc_parallel.__lookup_slow.walk_compone=
nt.link_path_walk.part=0A=
=A0=A0=A0=A0=A0 3.59 =B1132%=A0=A0 +1076.4%=A0=A0=A0=A0=A0 42.25 =B1 96%=A0=
 perf-sched.sch_delay.max.ms.d_alloc_parallel.__lookup_slow.walk_component.=
path_lookupat.isra=0A=
=A0=A0=A0=A0 16.19 =B1=A0 7%=A0=A0 +1397.5%=A0=A0=A0=A0 242.51 =B1 30%=A0 p=
erf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exi=
t_group.do_syscall_64=0A=
=A0=A0=A0=A0=A0 9.13 =B1 27%=A0=A0 +2518.1%=A0=A0=A0=A0 238.94 =B1 62%=A0 p=
erf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_=
mode.asm_sysvec_apic_timer_interrupt.[unknown]=0A=
=A0=A0=A0=A0 10.04 =B1 65%=A0=A0 +1971.0%=A0=A0=A0=A0 207.85 =B1 63%=A0 per=
f-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mo=
de.asm_sysvec_call_function_single.[unknown]=0A=
=A0=A0=A0=A0=A0 9.21 =B1 61%=A0=A0 +2000.8%=A0=A0=A0=A0 193.58 =B1 63%=A0 p=
erf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_=
mode.asm_sysvec_reschedule_ipi.[unknown]=0A=
=A0=A0=A0=A0 11.01 =B1 18%=A0=A0=A0 +799.2%=A0=A0=A0=A0=A0 99.02 =B1 86%=A0=
 perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user=
_mode.entry_SYSCALL_64_after_hwframe.[unknown]=0A=
=A0=A0=A0=A0 14.73 =B1 13%=A0=A0=A0 +265.9%=A0=A0=A0=A0=A0 53.91 =B1 26%=A0=
 perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user=
_mode.ret_from_fork.[unknown]=0A=
=A0=A0=A0=A0 10.65 =B1 44%=A0=A0=A0 +151.1%=A0=A0=A0=A0=A0 26.76 =B1 19%=A0=
 perf-sched.sch_delay.max.ms.io_schedule.__lock_page_killable.filemap_fault=
.__do_fault=0A=
=A0=A0=A0=A0=A0 1.21 =B1 24%=A0=A0 +2921.4%=A0=A0=A0=A0=A0 36.62 =B1124%=A0=
 perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read=0A=
=A0=A0=A0=A0=A0 0.53 =B1 55%=A0=A0 +1359.3%=A0=A0=A0=A0=A0=A0 7.76 =B1113%=
=A0 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__all=
oc_pages_nodemask.alloc_pages_vma.wp_page_copy=0A=
=A0=A0=A0=A0=A0 0.30 =B1 92%=A0=A0=A0=A0 -90.7%=A0=A0=A0=A0=A0=A0 0.03 =B11=
55%=A0 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__=
alloc_pages_nodemask.allocate_slab.___slab_alloc=0A=
=A0=A0=A0=A0=A0 0.37 =B1 69%=A0=A0 +3449.8%=A0=A0=A0=A0=A0 13.07 =B1162%=A0=
 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__alloc_=
pages_nodemask.pte_alloc_one.__pte_alloc=0A=
=A0=A0=A0=A0=A0 0.48 =B1 37%=A0=A0=A0=A0 -89.3%=A0=A0=A0=A0=A0=A0 0.05 =B11=
02%=A0 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__=
anon_vma_prepare.do_fault.__handle_mm_fault=0A=
=A0=A0=A0=A0=A0 0.55 =B1 93%=A0=A0=A0=A0 -95.3%=A0=A0=A0=A0=A0=A0 0.03 =B11=
53%=A0 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__=
kmalloc_node.memcg_alloc_page_obj_cgroups.kmem_cache_alloc_node=0A=
=A0=A0=A0=A0=A0 0.97 =B1 13%=A0=A0=A0 +591.3%=A0=A0=A0=A0=A0=A0 6.72 =B1119=
%=A0 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.chan=
ge_p4d_range.change_protection.mprotect_fixup=0A=
=A0=A0=A0=A0=A0 0.31 =B1106%=A0=A0=A0=A0 -98.6%=A0=A0=A0=A0=A0=A0 0.00 =B11=
37%=A0 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.co=
py_page_to_iter.generic_file_buffered_read.new_sync_read=0A=
=A0=A0=A0=A0 11.49 =B1=A0 5%=A0=A0=A0=A0 +87.8%=A0=A0=A0=A0=A0 21.57 =B1 31=
%=A0 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.do_u=
ser_addr_fault.exc_page_fault.asm_exc_page_fault=0A=
=A0=A0=A0=A0=A0 0.32 =B1102%=A0=A0=A0=A0 -96.0%=A0=A0=A0=A0=A0=A0 0.01 =B1 =
79%=A0 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.do=
wn_write.__anon_vma_prepare.do_anonymous_page=0A=
=A0=A0=A0=A0=A0 1.05 =B1 98%=A0=A0=A0 +478.9%=A0=A0=A0=A0=A0=A0 6.10 =B1 82=
%=A0 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down=
_write.__vma_adjust.__split_vma=0A=
=A0=A0=A0=A0=A0 0.02 =B1=A0 5%=A0 +1.4e+06%=A0=A0=A0=A0 217.29 =B1104%=A0 p=
erf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_write=
.do_truncate.path_openat=0A=
=A0=A0=A0=A0=A0 1.95 =B1 26%=A0=A0=A0 +682.5%=A0=A0=A0=A0=A0 15.25 =B1 64%=
=A0 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_=
write.unlink_anon_vmas.free_pgtables=0A=
=A0=A0=A0=A0=A0 0.93 =B1 14%=A0=A0 +9721.3%=A0=A0=A0=A0=A0 91.57 =B1158%=A0=
 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_wri=
te.unlink_file_vma.free_pgtables=0A=
=A0=A0=A0=A0=A0 0.00 =B1 10%=A0=A0=A0=A0 -78.6%=A0=A0=A0=A0=A0=A0 0.00 =B11=
73%=A0 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.do=
wn_write_killable.__vm_munmap.__x64_sys_munmap=0A=
=A0=A0=A0=A0=A0 0.24 =B1 43%=A0=A0=A0=A0 -96.7%=A0=A0=A0=A0=A0=A0 0.01 =B1 =
72%=A0 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.do=
wn_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff=0A=
=A0=A0=A0=A0=A0 0.01 =B1 28%=A0 +8.3e+05%=A0=A0=A0=A0 113.60 =B1164%=A0 per=
f-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.dput.do_unli=
nkat.do_syscall_64=0A=
=A0=A0=A0=A0=A0 0.21 =B1108%=A0 +34647.0%=A0=A0=A0=A0=A0 72.97 =B1145%=A0 p=
erf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.dput.done_=
path_create.do_linkat=0A=
=A0=A0=A0=A0=A0 3.03 =B1 39%=A0=A0 +1407.5%=A0=A0=A0=A0=A0 45.73 =B1 29%=A0=
 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.dput.pat=
h_openat.do_filp_open=0A=
=A0=A0=A0=A0=A0 1.22 =B1 39%=A0=A0 +4068.4%=A0=A0=A0=A0=A0 50.91 =B1 79%=A0=
 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.dput.ste=
p_into.path_openat=0A=
=A0=A0=A0=A0=A0 3.38 =B1 60%=A0=A0 +3700.6%=A0=A0=A0=A0 128.54 =B1127%=A0 p=
erf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.dput.termi=
nate_walk.path_openat=0A=
=A0=A0=A0=A0=A0 0.88 =B1 46%=A0=A0=A0 +299.6%=A0=A0=A0=A0=A0=A0 3.50 =B1 55=
%=A0 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.exit=
_mmap.mmput.begin_new_exec=0A=
=A0=A0=A0=A0=A0 0.00 =B1141%=A0 +22250.0%=A0=A0=A0=A0=A0=A0 0.30 =B1167%=A0=
 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.generic_=
file_buffered_read.__kernel_read.load_elf_binary=0A=
=A0=A0=A0=A0=A0 0.57 =B1139%=A0 +12527.6%=A0=A0=A0=A0=A0 71.47 =B1 89%=A0 p=
erf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache=
_alloc.__d_alloc.d_alloc_cursor=0A=
=A0=A0=A0=A0=A0 0.00 =B1141%=A0=A0 +1525.0%=A0=A0=A0=A0=A0=A0 0.03 =B1144%=
=A0 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_=
cache_alloc.__delayacct_tsk_init.copy_process=0A=
=A0=A0=A0=A0=A0 1.73 =B1 43%=A0=A0=A0 +863.5%=A0=A0=A0=A0=A0 16.71 =B1 50%=
=A0 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_=
cache_alloc.security_file_alloc.__alloc_file=0A=
=A0=A0=A0=A0=A0 3.67 =B1140%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00 =B1173=
%=A0 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem=
_cache_alloc_node_trace.__get_vm_area_node.__vmalloc_node_range=0A=
=A0=A0=A0=A0=A0 3.19 =B1 52%=A0=A0=A0 +345.8%=A0=A0=A0=A0=A0 14.24 =B1 84%=
=A0 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_=
cache_alloc_trace.perf_event_mmap.mmap_region=0A=
=A0=A0=A0=A0=A0 1.01 =B1 99%=A0=A0=A0=A0 -91.8%=A0=A0=A0=A0=A0=A0 0.08 =B11=
67%=A0 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.km=
em_cache_alloc_trace.perf_event_mmap.mprotect_fixup=0A=
=A0=A0=A0=A0=A0 0.11 =B1 85%=A0 +1.7e+05%=A0=A0=A0=A0 187.38 =B1 84%=A0 per=
f-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.mnt_want_wri=
te.path_openat.do_filp_open=0A=
=A0=A0=A0=A0=A0 0.05 =B1130%=A0=A0=A0 +602.6%=A0=A0=A0=A0=A0=A0 0.36 =B1142=
%=A0 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.mute=
x_lock.futex_exec_release.exec_mm_release=0A=
=A0=A0=A0=A0=A0 0.52 =B1136%=A0 +10794.6%=A0=A0=A0=A0=A0 57.09 =B1 72%=A0 p=
erf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.smpboot_th=
read_fn.kthread.ret_from_fork=0A=
=A0=A0=A0=A0=A0 0.06 =B1 92%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=A0=
=A0=A0=A0=A0=A0 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_r=
esched.stop_one_cpu.migrate_task_to.task_numa_migrate=0A=
=A0=A0=A0=A0 28.50 =B1 12%=A0=A0=A0 +645.4%=A0=A0=A0=A0 212.48 =B1 39%=A0 p=
erf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.stop_one_c=
pu.sched_exec.bprm_execve=0A=
=A0=A0=A0=A0=A0 1.20 =B1 76%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=A0=
=A0=A0=A0=A0=A0 perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_r=
esched.wait_for_completion.stop_two_cpus.migrate_swap=0A=
=A0=A0=A0=A0=A0 0.18 =B1130%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=A0=
=A0=A0=A0=A0=A0 perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.page_l=
ock_anon_vma_read.rmap_walk_anon.try_to_unmap=0A=
=A0=A0=A0=A0=A0 0.20 =B1132%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=A0=
=A0=A0=A0=A0=A0 perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.rmap_w=
alk_anon.remove_migration_ptes.migrate_pages=0A=
=A0=A0=A0=A0=A0 1.33 =B1103%=A0=A0=A0=A0 -96.9%=A0=A0=A0=A0=A0=A0 0.04 =B11=
73%=A0 perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.__put_anon_vma=
.unlink_anon_vmas.free_pgtables=0A=
=A0=A0=A0=A0=A0 1.53 =B1 79%=A0=A0 +6359.8%=A0=A0=A0=A0=A0 98.51 =B1148%=A0=
 perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.__vma_adjust.__split=
_vma.__do_munmap=0A=
=A0=A0=A0=A0=A0 2.57 =B1 63%=A0=A0=A0 +676.1%=A0=A0=A0=A0=A0 19.92 =B1 49%=
=A0 perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.__vma_adjust.__sp=
lit_vma.mprotect_fixup=0A=
=A0=A0=A0=A0=A0 0.78 =B1 76%=A0=A0=A0=A0 -99.2%=A0=A0=A0=A0=A0=A0 0.01 =B11=
38%=A0 perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.anon_vma_clone=
.anon_vma_fork.dup_mmap=0A=
=A0=A0=A0=A0=A0 0.19 =B1 94%=A0=A0=A0=A0 -97.6%=A0=A0=A0=A0=A0=A0 0.00 =B11=
00%=A0 perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.anon_vma_fork.=
dup_mmap.dup_mm=0A=
=A0=A0=A0=A0=A0 5.70 =B1 45%=A0=A0 +1878.3%=A0=A0=A0=A0 112.68 =B1 89%=A0 p=
erf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall=
_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 3.68 =B1111%=A0=A0 +1530.5%=A0=A0=A0=A0=A0 60.07 =B1 26%=A0=
 perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy=
_process=0A=
=A0=A0=A0=A0=A0 6.33 =B1 17%=A0=A0 +2353.2%=A0=A0=A0=A0 155.41 =B1105%=A0 p=
erf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.filename_create.do_lin=
kat.__x64_sys_link=0A=
=A0=A0=A0=A0=A0 2.23 =B1 66%=A0=A0=A0=A0 -98.3%=A0=A0=A0=A0=A0=A0 0.04 =B1 =
65%=A0 perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.unlink_anon_vm=
as.free_pgtables.exit_mmap=0A=
=A0=A0=A0=A0=A0 6.50 =B1 41%=A0=A0=A0 +643.0%=A0=A0=A0=A0=A0 48.28 =B1 78%=
=A0 perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.unlink_file_vma.f=
ree_pgtables.exit_mmap=0A=
=A0=A0=A0=A0=A0 2.45 =B1 43%=A0=A0 +1688.6%=A0=A0=A0=A0=A0 43.80 =B1 88%=A0=
 perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.vma_link.mmap_region=
.do_mmap=0A=
=A0=A0=A0=A0=A0 9.31 =B1 80%=A0=A0=A0=A0 -99.6%=A0=A0=A0=A0=A0=A0 0.04 =B1 =
54%=A0 perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.d=
o_epoll_wait.__x64_sys_epoll_wait=0A=
=A0=A0=A0=A0=A0 0.52 =B1 65%=A0 +15185.6%=A0=A0=A0=A0=A0 79.99 =B1 38%=A0 p=
erf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork=
=0A=
=A0=A0=A0=A0 16.34 =B1 98%=A0=A0=A0 +385.7%=A0=A0=A0=A0=A0 79.39 =B1 79%=A0=
 perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_fr=
om_fork=0A=
=A0=A0=A0=A0=A0 0.00 =B1141%=A0 +72153.1%=A0=A0=A0=A0=A0=A0 1.93 =B1171%=A0=
 perf-sched.sch_delay.max.ms.schedule_timeout.wait_for_completion.__flush_w=
ork.lru_add_drain_all=0A=
=A0=A0=A0=A0 10.28 =B1 58%=A0=A0 +2363.0%=A0=A0=A0=A0 253.08 =B1 17%=A0 per=
f-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork=0A=
=A0=A0=A0=A0=A0 8.41 =B1 37%=A0=A0 +3406.7%=A0=A0=A0=A0 295.08 =B1 29%=A0 p=
erf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork=0A=
=A0=A0=A0=A0=A0 0.12 =B1 74%=A0=A0=A0 +358.2%=A0=A0=A0=A0=A0=A0 0.54 =B1 29=
%=A0 perf-sched.total_sch_delay.average.ms=0A=
=A0=A0=A0=A0 39.70 =B1=A0 3%=A0=A0=A0=A0 -15.2%=A0=A0=A0=A0=A0 33.67 =B1=A0=
 3%=A0 perf-sched.total_wait_and_delay.average.ms=0A=
=A0=A0=A0 157875 =B1=A0 3%=A0=A0=A0=A0 +29.4%=A0=A0=A0=A0 204320 =B1=A0 3%=
=A0 perf-sched.total_wait_and_delay.count.ms=0A=
=A0=A0=A0=A0=A0 5585=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +14.5%=A0=A0=A0=A0=A0=A0=
 6395 =B1=A0 3%=A0 perf-sched.total_wait_and_delay.max.ms=0A=
=A0=A0=A0=A0 39.58 =B1=A0 3%=A0=A0=A0=A0 -16.3%=A0=A0=A0=A0=A0 33.13 =B1=A0=
 3%=A0 perf-sched.total_wait_time.average.ms=0A=
=A0=A0=A0=A0=A0 5585=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +14.5%=A0=A0=A0=A0=A0=A0=
 6395 =B1=A0 3%=A0 perf-sched.total_wait_time.max.ms=0A=
=A0=A0=A0=A0=A0 6.67 =B1=A0 2%=A0=A0=A0=A0 +90.8%=A0=A0=A0=A0=A0 12.72 =B1 =
10%=A0 perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4=
.do_syscall_64=0A=
=A0=A0=A0=A0=A0 6.25 =B1 22%=A0=A0=A0 +706.2%=A0=A0=A0=A0=A0 50.40 =B1 54%=
=A0 perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exi=
t_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]=0A=
=A0=A0=A0=A0=A0 6.09 =B1 15%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=A0=
=A0=A0=A0=A0=A0 perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.=
syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]=0A=
=A0=A0=A0=A0 38.34 =B1 13%=A0=A0=A0=A0 +47.7%=A0=A0=A0=A0=A0 56.61 =B1 33%=
=A0 perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_=
read=0A=
=A0=A0=A0=A0=A0 5.09=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +14.7%=A0=A0=A0=A0=A0=A0=
 5.83 =B1=A0 3%=A0 perf-sched.wait_and_delay.avg.ms.preempt_schedule_common=
._cond_resched.stop_one_cpu.__set_cpus_allowed_ptr.sched_setaffinity=0A=
=A0=A0=A0=A0=A0 0.33 =B1=A0 3%=A0=A0=A0 +330.6%=A0=A0=A0=A0=A0=A0 1.42 =B1 =
24%=A0 perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resch=
ed.stop_one_cpu.sched_exec.bprm_execve=0A=
=A0=A0=A0=A0=A0 1.33 =B1 20%=A0=A0=A0 +419.5%=A0=A0=A0=A0=A0=A0 6.93 =B1=A0=
 7%=A0 perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.do_unlink=
at.do_syscall_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 0.60 =B1 70%=A0=A0=A0 +168.1%=A0=A0=A0=A0=A0=A0 1.61 =B1 18=
%=A0 perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.dup_mmap.du=
p_mm.copy_process=0A=
=A0=A0=A0=A0=A0 3.71 =B1 11%=A0=A0=A0=A0 +29.9%=A0=A0=A0=A0=A0=A0 4.82 =B1 =
12%=A0 perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.path_open=
at.do_filp_open.do_sys_openat2=0A=
=A0=A0=A0=A0=A0 0.04 =B1141%=A0=A0=A0 +440.1%=A0=A0=A0=A0=A0=A0 0.24 =B1 12=
%=A0 perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.unlink_file=
_vma.free_pgtables.unmap_region=0A=
=A0=A0=A0=A0=A0 0.06 =B1141%=A0=A0=A0 +604.1%=A0=A0=A0=A0=A0=A0 0.41 =B1 20=
%=A0 perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.vma_link.mm=
ap_region.do_mmap=0A=
=A0=A0=A0 251.31 =B1=A0 7%=A0=A0=A0=A0 -36.4%=A0=A0=A0=A0 159.76 =B1 18%=A0=
 perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do=
_epoll_wait.__x64_sys_epoll_wait=0A=
=A0=A0=A0=A0 87.92 =B1 14%=A0=A0=A0=A0 +50.7%=A0=A0=A0=A0 132.47 =B1 22%=A0=
 perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_sched=
ule_timeout.constprop.0.do_sys_poll=0A=
=A0=A0=A0 384.15=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -32.3%=A0=A0=A0=A0 260.23 =
=B1 10%=A0 perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_f=
rom_fork=0A=
=A0=A0=A0 142.29=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -30.8%=A0=A0=A0=A0=A0 98.47 =
=B1=A0 6%=A0 perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_fro=
m_fork=0A=
=A0=A0=A0=A0 35.67 =B1 11%=A0=A0=A0=A0 +58.4%=A0=A0=A0=A0=A0 56.50=A0=A0=A0=
=A0=A0=A0=A0 perf-sched.wait_and_delay.count.devkmsg_read.vfs_read.ksys_rea=
d.do_syscall_64=0A=
=A0=A0=A0=A0 14.67 =B1=A0 8%=A0=A0=A0=A0 +19.3%=A0=A0=A0=A0=A0 17.50 =B1=A0=
 4%=A0 perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.__x64=
_sys_nanosleep.do_syscall_64=0A=
=A0=A0=A0=A0 35.67 =B1=A0 9%=A0=A0=A0=A0 +58.4%=A0=A0=A0=A0=A0 56.50=A0=A0=
=A0=A0=A0=A0=A0 perf-sched.wait_and_delay.count.do_syslog.part.0.kmsg_read.=
vfs_read=0A=
=A0=A0=A0=A0 39991=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +28.3%=A0=A0=A0=A0=A0 5129=
5 =B1=A0 4%=A0 perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_grou=
p_exit.__x64_sys_exit_group.do_syscall_64=0A=
=A0=A0=A0=A0 41076=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +26.8%=A0=A0=A0=A0=A0 5208=
8 =B1=A0 4%=A0 perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sy=
s_wait4.do_syscall_64=0A=
=A0=A0=A0 914.67 =B1=A0 2%=A0=A0=A0=A0 +68.3%=A0=A0=A0=A0=A0=A0 1539 =B1=A0=
 6%=A0 perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_e=
xit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]=0A=
=A0=A0=A0 122.33 =B1141%=A0=A0=A0 +401.1%=A0=A0=A0=A0 613.00 =B1 22%=A0 per=
f-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to_use=
r_mode.asm_sysvec_reschedule_ipi.[unknown]=0A=
=A0=A0=A0=A0=A0 1649 =B1=A0 8%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=
=A0=A0=A0=A0=A0=A0 perf-sched.wait_and_delay.count.exit_to_user_mode_prepar=
e.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]=0A=
=A0=A0=A0=A0=A0 4728 =B1 13%=A0=A0=A0=A0 -91.3%=A0=A0=A0=A0 412.00 =B1100%=
=A0 perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.d=
put.scan_positives.dcache_readdir=0A=
=A0=A0=A0=A0=A0 4.67 =B1 44%=A0=A0 +1325.0%=A0=A0=A0=A0=A0 66.50 =B1 51%=A0=
 perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.smpb=
oot_thread_fn.kthread.ret_from_fork=0A=
=A0=A0=A0=A0=A0 1987 =B1=A0 4%=A0=A0=A0=A0 -13.4%=A0=A0=A0=A0=A0=A0 1720 =
=B1=A0 4%=A0 perf-sched.wait_and_delay.count.preempt_schedule_common._cond_=
resched.stop_one_cpu.__set_cpus_allowed_ptr.sched_setaffinity=0A=
=A0=A0=A0=A0=A0 3064 =B1=A0 8%=A0=A0=A0=A0 +76.6%=A0=A0=A0=A0=A0=A0 5412 =
=B1 13%=A0 perf-sched.wait_and_delay.count.preempt_schedule_common._cond_re=
sched.stop_one_cpu.sched_exec.bprm_execve=0A=
=A0=A0=A0=A0=A0 2046 =B1=A0 7%=A0=A0=A0=A0 +68.3%=A0=A0=A0=A0=A0=A0 3443 =
=B1 15%=A0 perf-sched.wait_and_delay.count.rwsem_down_read_slowpath.walk_co=
mponent.path_lookupat.isra.0=0A=
=A0=A0=A0 896.33 =B1=A0 5%=A0=A0=A0=A0 +81.3%=A0=A0=A0=A0=A0=A0 1625 =B1 12=
%=A0 perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.do_unlinkat.=
do_syscall_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0 776.00 =B1 75%=A0=A0=A0 +292.9%=A0=A0=A0=A0=A0=A0 3049 =B1 44%=A0=
 perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.dup_mmap.dup_mm.=
copy_process=0A=
=A0=A0=A0=A0=A0 1649 =B1 32%=A0=A0=A0 +198.7%=A0=A0=A0=A0=A0=A0 4926 =B1 45=
%=A0 perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.unlink_file_=
vma.free_pgtables.exit_mmap=0A=
=A0=A0=A0 354.67 =B1141%=A0=A0=A0 +482.9%=A0=A0=A0=A0=A0=A0 2067 =B1 36%=A0=
 perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.unlink_file_vma.=
free_pgtables.unmap_region=0A=
=A0=A0=A0 350.00 =B1141%=A0=A0=A0 +496.1%=A0=A0=A0=A0=A0=A0 2086 =B1 33%=A0=
 perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.vma_link.mmap_re=
gion.do_mmap=0A=
=A0=A0=A0=A0 13.00 =B1 21%=A0=A0=A0=A0 +61.5%=A0=A0=A0=A0=A0 21.00=A0=A0=A0=
=A0=A0=A0=A0 perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock=
.poll_schedule_timeout.constprop.0.do_select=0A=
=A0=A0=A0 163.67 =B1=A0 3%=A0=A0=A0=A0 -35.2%=A0=A0=A0=A0 106.00 =B1 25%=A0=
 perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedu=
le_timeout.constprop.0.do_sys_poll=0A=
=A0=A0=A0=A0=A0 1762 =B1=A0 4%=A0=A0=A0=A0 -17.5%=A0=A0=A0=A0=A0=A0 1454 =
=B1 12%=A0 perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.=
kthread.ret_from_fork=0A=
=A0=A0=A0=A0=A0 9129 =B1=A0 2%=A0=A0=A0=A0 +43.1%=A0=A0=A0=A0=A0 13062 =B1=
=A0 9%=A0 perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_fro=
m_fork=0A=
=A0=A0=A0=A0 12642=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +52.2%=A0=A0=A0=A0=A0 1924=
2 =B1=A0 3%=A0 perf-sched.wait_and_delay.count.worker_thread.kthread.ret_fr=
om_fork=0A=
=A0=A0=A0=A0=A0 5512=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -30.9%=A0=A0=A0=A0=A0=A0=
 3811=A0=A0=A0=A0=A0=A0=A0 perf-sched.wait_and_delay.max.ms.devkmsg_read.vf=
s_read.ksys_read.do_syscall_64=0A=
=A0=A0=A0=A0=A0 5512=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -30.9%=A0=A0=A0=A0=A0=A0=
 3811=A0=A0=A0=A0=A0=A0=A0 perf-sched.wait_and_delay.max.ms.do_syslog.part.=
0.kmsg_read.vfs_read=0A=
=A0=A0=A0 340.62 =B1141%=A0=A0=A0 +203.4%=A0=A0=A0=A0=A0=A0 1033=A0=A0=A0=
=A0=A0=A0=A0 perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irq=
entry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]=0A=
=A0=A0=A0=A0=A0 5496=A0=A0=A0=A0=A0=A0=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0=
.00=A0=A0=A0=A0=A0=A0=A0 perf-sched.wait_and_delay.max.ms.exit_to_user_mode=
_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]=
=0A=
=A0=A0=A0=A0=A0 5580=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -30.1%=A0=A0=A0=A0=A0=A0=
 3899=A0=A0=A0=A0=A0=A0=A0 perf-sched.wait_and_delay.max.ms.pipe_read.new_s=
ync_read.vfs_read.ksys_read=0A=
=A0=A0=A0=A0=A0 1495 =B1 31%=A0=A0=A0 +114.1%=A0=A0=A0=A0=A0=A0 3203 =B1=A0=
 4%=A0 perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resch=
ed.smpboot_thread_fn.kthread.ret_from_fork=0A=
=A0=A0=A0=A0 28.50 =B1 12%=A0=A0=A0 +645.4%=A0=A0=A0=A0 212.48 =B1 39%=A0 p=
erf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.stop_=
one_cpu.sched_exec.bprm_execve=0A=
=A0=A0=A0=A0 20.64 =B1 78%=A0=A0 +2946.5%=A0=A0=A0=A0 628.69 =B1 62%=A0 per=
f-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.dup_mmap.dup_mm.cop=
y_process=0A=
=A0=A0=A0=A0 20.38 =B1 28%=A0=A0=A0 +299.0%=A0=A0=A0=A0=A0 81.32 =B1 53%=A0=
 perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.unlink_file_vma=
.free_pgtables.exit_mmap=0A=
=A0=A0=A0=A0=A0 3.90 =B1141%=A0=A0=A0 +526.7%=A0=A0=A0=A0=A0 24.46 =B1 34%=
=A0 perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.unlink_file_=
vma.free_pgtables.unmap_region=0A=
=A0=A0=A0=A0=A0 3.78 =B1141%=A0=A0 +1570.8%=A0=A0=A0=A0=A0 63.11 =B1 45%=A0=
 perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.vma_link.mmap_r=
egion.do_mmap=0A=
=A0=A0=A0=A0=A0 5176=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -31.0%=A0=A0=A0=A0=A0=A0=
 3569=A0=A0=A0=A0=A0=A0=A0 perf-sched.wait_and_delay.max.ms.schedule_hrtime=
out_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait=0A=
=A0=A0=A0=A0=A0 5585=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -30.2%=A0=A0=A0=A0=A0=A0=
 3899=A0=A0=A0=A0=A0=A0=A0 perf-sched.wait_and_delay.max.ms.schedule_hrtime=
out_range_clock.poll_schedule_timeout.constprop.0.do_select=0A=
=A0=A0=A0 505.28=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +31.3%=A0=A0=A0=A0 663.68 =
=B1=A0 9%=A0 perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kt=
hread.ret_from_fork=0A=
=A0=A0=A0=A0=A0 4817 =B1 15%=A0=A0=A0=A0 -31.2%=A0=A0=A0=A0=A0=A0 3315 =B1=
=A0 3%=A0 perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_fr=
om_fork=0A=
=A0=A0=A0=A0=A0 1791=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -16.1%=A0=A0=A0=A0=A0=A0=
 1502 =B1=A0 3%=A0 perf-sched.wait_and_delay.max.ms.worker_thread.kthread.r=
et_from_fork=0A=
=A0=A0=A0=A0=A0 0.08 =B1 39%=A0=A0=A0 +460.9%=A0=A0=A0=A0=A0=A0 0.43 =B1 27=
%=A0 perf-sched.wait_time.avg.ms.d_alloc_parallel.__lookup_slow.walk_compon=
ent.link_path_walk.part=0A=
=A0=A0=A0=A0=A0 0.17 =B1 92%=A0=A0=A0 +182.7%=A0=A0=A0=A0=A0=A0 0.48 =B1 59=
%=A0 perf-sched.wait_time.avg.ms.d_alloc_parallel.__lookup_slow.walk_compon=
ent.path_lookupat.isra=0A=
=A0=A0=A0=A0=A0 6.50 =B1=A0 3%=A0=A0=A0=A0 +87.7%=A0=A0=A0=A0=A0 12.20 =B1=
=A0 8%=A0 perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.d=
o_syscall_64=0A=
=A0=A0=A0=A0=A0 0.59 =B1123%=A0=A0=A0 +129.1%=A0=A0=A0=A0=A0=A0 1.35 =B1 86=
%=A0 perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to=
_user_mode.asm_exc_page_fault.[unknown]=0A=
=A0=A0=A0=A0=A0 6.21 =B1 22%=A0=A0=A0 +697.5%=A0=A0=A0=A0=A0 49.49 =B1 55%=
=A0 perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_=
user_mode.asm_sysvec_apic_timer_interrupt.[unknown]=0A=
=A0=A0=A0=A0=A0 8.60 =B1 95%=A0=A0=A0 +175.7%=A0=A0=A0=A0=A0 23.70 =B1 34%=
=A0 perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_=
user_mode.asm_sysvec_call_function_single.[unknown]=0A=
=A0=A0=A0=A0=A0 6.03 =B1 15%=A0=A0=A0 +354.9%=A0=A0=A0=A0=A0 27.43 =B1 13%=
=A0 perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_u=
ser_mode.entry_SYSCALL_64_after_hwframe.[unknown]=0A=
=A0=A0=A0=A0=A0 0.00 =B1 88%=A0 +24178.6%=A0=A0=A0=A0=A0=A0 1.13 =B1156%=A0=
 perf-sched.wait_time.avg.ms.io_schedule.__lock_page.__do_fault.do_fault=0A=
=A0=A0=A0=A0 38.33 =B1 13%=A0=A0=A0=A0 +47.6%=A0=A0=A0=A0=A0 56.59 =B1 33%=
=A0 perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read=
=0A=
=A0=A0=A0=A0=A0 0.53 =B1120%=A0=A0=A0=A0 -98.4%=A0=A0=A0=A0=A0=A0 0.01 =B11=
02%=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__=
alloc_pages_nodemask.__pmd_alloc.__handle_mm_fault=0A=
=A0=A0=A0=A0=A0 0.01 =B1115%=A0=A0 +6617.2%=A0=A0=A0=A0=A0=A0 0.36 =B1168%=
=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__kma=
lloc.load_elf_phdrs.load_elf_binary=0A=
=A0=A0=A0=A0=A0 0.42 =B1 44%=A0=A0=A0 +593.4%=A0=A0=A0=A0=A0=A0 2.89 =B1 57=
%=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__km=
alloc.security_task_alloc.copy_process=0A=
=A0=A0=A0=A0=A0 0.08 =B1 57%=A0=A0=A0 +614.6%=A0=A0=A0=A0=A0=A0 0.60 =B1 48=
%=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__pu=
t_anon_vma.unlink_anon_vmas.free_pgtables=0A=
=A0=A0=A0=A0=A0 0.27 =B1140%=A0=A0=A0 +525.8%=A0=A0=A0=A0=A0=A0 1.67 =B1 86=
%=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.cgro=
up_can_fork.copy_process.kernel_clone=0A=
=A0=A0=A0=A0=A0 0.05 =B1 25%=A0=A0=A0 +978.8%=A0=A0=A0=A0=A0=A0 0.50 =B1 50=
%=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.chan=
ge_p4d_range.change_protection.mprotect_fixup=0A=
=A0=A0=A0=A0=A0 0.53 =B1 73%=A0=A0=A0 +685.8%=A0=A0=A0=A0=A0=A0 4.14 =B1 66=
%=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.copy=
_pte_range.copy_page_range.dup_mmap=0A=
=A0=A0=A0=A0=A0 0.02 =B1123%=A0=A0 +6830.4%=A0=A0=A0=A0=A0=A0 1.59 =B1103%=
=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_=
read.path_openat.do_filp_open=0A=
=A0=A0=A0=A0=A0 0.06 =B1 29%=A0=A0=A0 +796.1%=A0=A0=A0=A0=A0=A0 0.51 =B1 93=
%=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down=
_read.walk_component.link_path_walk=0A=
=A0=A0=A0=A0=A0 0.01 =B1141%=A0=A0 +2254.2%=A0=A0=A0=A0=A0=A0 0.14 =B1161%=
=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_=
read_killable.create_elf_tables.isra=0A=
=A0=A0=A0=A0=A0 0.01 =B1 97%=A0=A0 +9626.4%=A0=A0=A0=A0=A0=A0 1.13 =B1 62%=
=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_=
write.__anon_vma_prepare.do_fault=0A=
=A0=A0=A0=A0=A0 0.02 =B1 87%=A0=A0 +4118.8%=A0=A0=A0=A0=A0=A0 0.79 =B1 55%=
=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_=
write.__vma_adjust.shift_arg_pages=0A=
=A0=A0=A0=A0=A0 1.50 =B1 68%=A0=A0 +1104.7%=A0=A0=A0=A0=A0 18.05 =B1100%=A0=
 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_wri=
te.anon_vma_fork.dup_mmap=0A=
=A0=A0=A0=A0=A0 2.02 =B1 13%=A0=A0=A0 +454.8%=A0=A0=A0=A0=A0 11.23 =B1 69%=
=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_=
write.do_truncate.path_openat=0A=
=A0=A0=A0=A0=A0 1.78 =B1 66%=A0=A0=A0 +587.5%=A0=A0=A0=A0=A0 12.24 =B1 99%=
=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_=
write.dup_mmap.dup_mm=0A=
=A0=A0=A0=A0=A0 0.86 =B1 39%=A0=A0=A0=A0 +37.3%=A0=A0=A0=A0=A0=A0 1.18 =B1 =
11%=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.do=
wn_write.unlink_file_vma.free_pgtables=0A=
=A0=A0=A0=A0=A0 0.01 =B1141%=A0=A0 +3608.3%=A0=A0=A0=A0=A0=A0 0.22 =B1 85%=
=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_=
write_killable.__vm_munmap.elf_map=0A=
=A0=A0=A0=A0=A0 0.01 =B1135%=A0=A0=A0 +539.5%=A0=A0=A0=A0=A0=A0 0.08 =B1 83=
%=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down=
_write_killable.vm_brk_flags.load_elf_interp=0A=
=A0=A0=A0=A0=A0 0.04 =B1 21%=A0=A0=A0 +251.3%=A0=A0=A0=A0=A0=A0 0.14 =B1 50=
%=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down=
_write_killable.vm_mmap_pgoff.elf_map=0A=
=A0=A0=A0=A0=A0 0.25 =B1 70%=A0=A0 +1512.8%=A0=A0=A0=A0=A0=A0 4.09 =B1132%=
=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.=
__fput.task_work_run=0A=
=A0=A0=A0=A0=A0 0.18 =B1139%=A0=A0 +1040.9%=A0=A0=A0=A0=A0=A0 2.06 =B1 93%=
=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.=
dcache_dir_close.__fput=0A=
=A0=A0=A0=A0=A0 0.32 =B1 75%=A0=A0 +3385.1%=A0=A0=A0=A0=A0 11.30 =B1101%=A0=
 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.do_=
unlinkat.do_syscall_64=0A=
=A0=A0=A0=A0=A0 9.06 =B1 10%=A0=A0=A0 +226.6%=A0=A0=A0=A0=A0 29.60 =B1 20%=
=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.=
scan_positives.dcache_readdir=0A=
=A0=A0=A0=A0=A0 2.19 =B1119%=A0=A0=A0 +216.9%=A0=A0=A0=A0=A0=A0 6.95 =B1 21=
%=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput=
.step_into.path_openat=0A=
=A0=A0=A0=A0=A0 0.16 =B1 19%=A0=A0 +1845.7%=A0=A0=A0=A0=A0=A0 3.15 =B1 29%=
=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.=
terminate_walk.path_openat=0A=
=A0=A0=A0=A0=A0 0.03 =B1 70%=A0=A0 +2914.6%=A0=A0=A0=A0=A0=A0 0.82 =B1 63%=
=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.exit_=
mmap.mmput.begin_new_exec=0A=
=A0=A0=A0=A0=A0 0.97 =B1 23%=A0=A0=A0 +131.5%=A0=A0=A0=A0=A0=A0 2.24 =B1 56=
%=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.exit=
_mmap.mmput.do_exit=0A=
=A0=A0=A0=A0=A0 0.01 =B1126%=A0=A0=A0 +319.3%=A0=A0=A0=A0=A0=A0 0.06 =B1 53=
%=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem=
_cache_alloc.__anon_vma_prepare.do_anonymous_page=0A=
=A0=A0=A0=A0=A0 0.04 =B1 15%=A0=A0 +2327.3%=A0=A0=A0=A0=A0=A0 0.89 =B1 54%=
=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_=
cache_alloc.__d_alloc.d_alloc=0A=
=A0=A0=A0=A0=A0 0.62 =B1 70%=A0=A0 +3428.4%=A0=A0=A0=A0=A0 21.95 =B1 35%=A0=
 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc.__d_alloc.d_alloc_cursor=0A=
=A0=A0=A0=A0=A0 0.29 =B1 72%=A0=A0 +1816.0%=A0=A0=A0=A0=A0=A0 5.56 =B1 89%=
=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_=
cache_alloc.copy_fs_struct.copy_process=0A=
=A0=A0=A0=A0=A0 0.05 =B1119%=A0=A0 +1698.6%=A0=A0=A0=A0=A0=A0 0.95 =B1 91%=
=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_=
cache_alloc.getname_flags.do_sys_openat2=0A=
=A0=A0=A0=A0=A0 0.18 =B1 72%=A0=A0=A0 +533.7%=A0=A0=A0=A0=A0=A0 1.16 =B1 31=
%=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem=
_cache_alloc.getname_flags.user_path_at_empty=0A=
=A0=A0=A0=A0=A0 0.41 =B1 34%=A0=A0=A0 +890.7%=A0=A0=A0=A0=A0=A0 4.09 =B1 49=
%=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem=
_cache_alloc.prepare_creds.copy_creds=0A=
=A0=A0=A0=A0=A0 3.70 =B1 18%=A0=A0=A0=A0 +55.5%=A0=A0=A0=A0=A0=A0 5.76 =B1 =
42%=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.km=
em_cache_alloc.vm_area_dup.dup_mmap=0A=
=A0=A0=A0=A0 10.64 =B1105%=A0=A0=A0 +189.5%=A0=A0=A0=A0=A0 30.81 =B1 66%=A0=
 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mnt_want=
_write.path_openat.do_filp_open=0A=
=A0=A0=A0=A0=A0 0.10 =B1 68%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=A0=
=A0=A0=A0=A0=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_r=
esched.mutex_lock_killable.begin_new_exec.load_elf_binary=0A=
=A0=A0=A0=A0=A0 0.05 =B1 97%=A0=A0 +1166.8%=A0=A0=A0=A0=A0=A0 0.58 =B1 67%=
=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.remov=
e_vma.__do_munmap.__vm_munmap=0A=
=A0=A0=A0=A0=A0 5.09=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +14.7%=A0=A0=A0=A0=A0=A0=
 5.83 =B1=A0 3%=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._con=
d_resched.stop_one_cpu.__set_cpus_allowed_ptr.sched_setaffinity=0A=
=A0=A0=A0=A0=A0 2.90 =B1 20%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=A0=
=A0=A0=A0=A0=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_r=
esched.stop_one_cpu.migrate_task_to.task_numa_migrate=0A=
=A0=A0=A0=A0=A0 0.03 =B1=A0 5%=A0=A0=A0 +539.8%=A0=A0=A0=A0=A0=A0 0.20 =B1 =
26%=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.st=
op_one_cpu.sched_exec.bprm_execve=0A=
=A0=A0=A0=A0=A0 2.38 =B1 18%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=A0=
=A0=A0=A0=A0=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_r=
esched.wait_for_completion.stop_two_cpus.migrate_swap=0A=
=A0=A0=A0=A0=A0 0.23 =B1=A0 2%=A0=A0=A0=A0 +87.1%=A0=A0=A0=A0=A0=A0 0.44 =
=B1 35%=A0 perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resche=
d.zap_pte_range.unmap_page_range.unmap_vmas=0A=
=A0=A0=A0=A0=A0 2.62 =B1 44%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=A0=
=A0=A0=A0=A0=A0 perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.page_l=
ock_anon_vma_read.rmap_walk_anon.try_to_unmap=0A=
=A0=A0=A0=A0=A0 2.41 =B1 41%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=A0=
=A0=A0=A0=A0=A0 perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.rmap_w=
alk_anon.remove_migration_ptes.migrate_pages=0A=
=A0=A0=A0=A0=A0 0.17 =B1=A0 4%=A0=A0=A0=A0 +96.1%=A0=A0=A0=A0=A0=A0 0.34 =
=B1 48%=A0 perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.__vma_adju=
st.__split_vma.mprotect_fixup=0A=
=A0=A0=A0=A0=A0 1.31 =B1 21%=A0=A0=A0 +398.6%=A0=A0=A0=A0=A0=A0 6.54 =B1=A0=
 7%=A0 perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.do_unlinkat.do=
_syscall_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 0.93 =B1=A0 7%=A0=A0=A0=A0 +64.0%=A0=A0=A0=A0=A0=A0 1.53 =
=B1 16%=A0 perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.dup_mmap.d=
up_mm.copy_process=0A=
=A0=A0=A0=A0=A0 0.17 =B1 14%=A0=A0=A0=A0 +31.3%=A0=A0=A0=A0=A0=A0 0.22 =B1 =
13%=A0 perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.unlink_file_vm=
a.free_pgtables.unmap_region=0A=
=A0=A0=A0=A0=A0 0.20 =B1 15%=A0=A0=A0=A0 +83.9%=A0=A0=A0=A0=A0=A0 0.37 =B1 =
25%=A0 perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.vma_link.mmap_=
region.do_mmap=0A=
=A0=A0=A0 251.12 =B1=A0 7%=A0=A0=A0=A0 -36.4%=A0=A0=A0=A0 159.75 =B1 18%=A0=
 perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epol=
l_wait.__x64_sys_epoll_wait=0A=
=A0=A0=A0=A0 87.92 =B1 14%=A0=A0=A0=A0 +50.6%=A0=A0=A0=A0 132.37 =B1 23%=A0=
 perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_t=
imeout.constprop.0.do_sys_poll=0A=
=A0=A0=A0 383.96=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -32.9%=A0=A0=A0=A0 257.59 =
=B1=A0 9%=A0 perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from=
_fork=0A=
=A0=A0=A0 142.28=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -31.7%=A0=A0=A0=A0=A0 97.22 =
=B1=A0 6%=A0 perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_for=
k=0A=
=A0=A0=A0=A0=A0 8.16 =B1 46%=A0=A0=A0 +383.8%=A0=A0=A0=A0=A0 39.47 =B1 75%=
=A0 perf-sched.wait_time.max.ms.d_alloc_parallel.__lookup_slow.walk_compone=
nt.link_path_walk.part=0A=
=A0=A0=A0=A0=A0 5512=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -30.9%=A0=A0=A0=A0=A0=A0=
 3811=A0=A0=A0=A0=A0=A0=A0 perf-sched.wait_time.max.ms.devkmsg_read.vfs_rea=
d.ksys_read.do_syscall_64=0A=
=A0=A0=A0=A0=A0 5512=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -30.9%=A0=A0=A0=A0=A0=A0=
 3811=A0=A0=A0=A0=A0=A0=A0 perf-sched.wait_time.max.ms.do_syslog.part.0.kms=
g_read.vfs_read=0A=
=A0=A0=A0=A0=A0 5496=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -30.6%=A0=A0=A0=A0=A0=A0=
 3813=A0=A0=A0=A0=A0=A0=A0 perf-sched.wait_time.max.ms.exit_to_user_mode_pr=
epare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]=0A=
=A0=A0=A0=A0=A0 0.07 =B1107%=A0 +29156.2%=A0=A0=A0=A0=A0 21.16 =B1159%=A0 p=
erf-sched.wait_time.max.ms.io_schedule.__lock_page.__do_fault.do_fault=0A=
=A0=A0=A0=A0=A0 5580=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -30.1%=A0=A0=A0=A0=A0=A0=
 3899=A0=A0=A0=A0=A0=A0=A0 perf-sched.wait_time.max.ms.pipe_read.new_sync_r=
ead.vfs_read.ksys_read=0A=
=A0=A0=A0=A0=A0 4.62 =B1 40%=A0=A0=A0 +343.5%=A0=A0=A0=A0=A0 20.48 =B1 14%=
=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__kma=
lloc.security_task_alloc.copy_process=0A=
=A0=A0=A0=A0=A0 2.87 =B1 85%=A0=A0=A0 +498.7%=A0=A0=A0=A0=A0 17.16 =B1 34%=
=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__put=
_anon_vma.unlink_anon_vmas.free_pgtables=0A=
=A0=A0=A0=A0=A0 1.03 =B1140%=A0=A0=A0 +525.1%=A0=A0=A0=A0=A0=A0 6.42 =B1 54=
%=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.cgro=
up_can_fork.copy_process.kernel_clone=0A=
=A0=A0=A0=A0=A0 0.85 =B1 22%=A0=A0 +2220.1%=A0=A0=A0=A0=A0 19.71 =B1 82%=A0=
 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.change_p=
4d_range.change_protection.mprotect_fixup=0A=
=A0=A0=A0=A0=A0 7.98 =B1 62%=A0=A0=A0 +586.9%=A0=A0=A0=A0=A0 54.83 =B1100%=
=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.copy_=
pte_range.copy_page_range.dup_mmap=0A=
=A0=A0=A0=A0=A0 0.42 =B1 73%=A0=A0=A0 +476.2%=A0=A0=A0=A0=A0=A0 2.44 =B1 95=
%=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.copy=
_strings.isra.0=0A=
=A0=A0=A0=A0=A0 0.18 =B1131%=A0=A0 +4103.5%=A0=A0=A0=A0=A0=A0 7.45 =B1 88%=
=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_=
read.path_openat.do_filp_open=0A=
=A0=A0=A0=A0=A0 2.68 =B1 50%=A0=A0 +1905.1%=A0=A0=A0=A0=A0 53.65 =B1123%=A0=
 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_rea=
d.walk_component.link_path_walk=0A=
=A0=A0=A0=A0=A0 0.04 =B1141%=A0=A0 +3772.9%=A0=A0=A0=A0=A0=A0 1.39 =B1166%=
=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_=
read_killable.create_elf_tables.isra=0A=
=A0=A0=A0=A0=A0 0.03 =B1122%=A0 +22698.3%=A0=A0=A0=A0=A0=A0 6.76 =B1 88%=A0=
 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_wri=
te.__anon_vma_prepare.do_fault=0A=
=A0=A0=A0=A0=A0 0.25 =B1103%=A0=A0 +3843.4%=A0=A0=A0=A0=A0=A0 9.87 =B1 62%=
=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_=
write.__vma_adjust.shift_arg_pages=0A=
=A0=A0=A0=A0 23.74 =B1 13%=A0=A0 +1153.9%=A0=A0=A0=A0 297.72 =B1136%=A0 per=
f-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.a=
non_vma_clone.anon_vma_fork=0A=
=A0=A0=A0=A0=A0 8.46 =B1 76%=A0=A0 +3275.9%=A0=A0=A0=A0 285.49 =B1146%=A0 p=
erf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write=
.anon_vma_fork.dup_mmap=0A=
=A0=A0=A0=A0=A0 8.55 =B1 14%=A0=A0 +2664.7%=A0=A0=A0=A0 236.39 =B1 90%=A0 p=
erf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write=
.do_truncate.path_openat=0A=
=A0=A0=A0=A0=A0 0.02 =B1141%=A0=A0 +3120.9%=A0=A0=A0=A0=A0=A0 0.78 =B1 90%=
=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_=
write_killable.__vm_munmap.elf_map=0A=
=A0=A0=A0=A0=A0 0.63 =B1 47%=A0=A0=A0 +456.1%=A0=A0=A0=A0=A0=A0 3.51 =B1 76=
%=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down=
_write_killable.vm_mmap_pgoff.elf_map=0A=
=A0=A0=A0=A0=A0 0.36 =B1139%=A0=A0=A0 +758.2%=A0=A0=A0=A0=A0=A0 3.10 =B1 66=
%=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput=
.dcache_dir_close.__fput=0A=
=A0=A0=A0=A0=A0 1.91 =B1 89%=A0=A0 +6827.3%=A0=A0=A0=A0 132.20 =B1137%=A0 p=
erf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.do_un=
linkat.do_syscall_64=0A=
=A0=A0=A0 336.18 =B1140%=A0=A0=A0=A0 +73.0%=A0=A0=A0=A0 581.60 =B1 78%=A0 p=
erf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.done_=
path_create.do_linkat=0A=
=A0=A0=A0 341.13 =B1137%=A0=A0=A0 +196.8%=A0=A0=A0=A0=A0=A0 1012=A0=A0=A0=
=A0=A0=A0=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resc=
hed.dput.step_into.path_openat=0A=
=A0=A0=A0=A0=A0 9.64 =B1 52%=A0=A0 +4704.9%=A0=A0=A0=A0 463.29 =B1 72%=A0 p=
erf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.termi=
nate_walk.path_openat=0A=
=A0=A0=A0=A0=A0 0.94 =B1 71%=A0=A0 +1718.2%=A0=A0=A0=A0=A0 17.05 =B1 33%=A0=
 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.exit_mma=
p.mmput.begin_new_exec=0A=
=A0=A0=A0=A0=A0 6.94 =B1 41%=A0=A0=A0 +683.1%=A0=A0=A0=A0=A0 54.36 =B1113%=
=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.exit_=
mmap.mmput.do_exit=0A=
=A0=A0=A0=A0=A0 0.07 =B1119%=A0=A0=A0 +888.4%=A0=A0=A0=A0=A0=A0 0.65 =B1 80=
%=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem=
_cache_alloc.__anon_vma_prepare.do_anonymous_page=0A=
=A0=A0=A0=A0=A0 0.42 =B1 51%=A0=A0 +3060.9%=A0=A0=A0=A0=A0 13.37 =B1 71%=A0=
 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc.__d_alloc.d_alloc=0A=
=A0=A0=A0=A0=A0 1.61 =B1 71%=A0 +29984.9%=A0=A0=A0=A0 484.07 =B1 65%=A0 per=
f-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_a=
lloc.__d_alloc.d_alloc_cursor=0A=
=A0=A0=A0=A0=A0 1.01 =B1 76%=A0=A0=A0 +779.3%=A0=A0=A0=A0=A0=A0 8.90 =B1 68=
%=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem=
_cache_alloc.copy_fs_struct.copy_process=0A=
=A0=A0=A0=A0=A0 1.25 =B1 73%=A0=A0=A0 +327.5%=A0=A0=A0=A0=A0=A0 5.36 =B1 28=
%=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem=
_cache_alloc.getname_flags.user_path_at_empty=0A=
=A0=A0=A0=A0 23.94 =B1 16%=A0=A0=A0 +259.0%=A0=A0=A0=A0=A0 85.92 =B1 53%=A0=
 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cac=
he_alloc.vm_area_dup.dup_mmap=0A=
=A0=A0=A0=A0=A0 6.01 =B1 27%=A0=A0=A0=A0 +52.0%=A0=A0=A0=A0=A0=A0 9.13 =B1 =
24%=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.km=
em_cache_alloc_trace.perf_event_mmap.mmap_region=0A=
=A0=A0=A0=A0=A0 0.27 =B1 77%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=A0=
=A0=A0=A0=A0=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_r=
esched.mutex_lock_killable.begin_new_exec.load_elf_binary=0A=
=A0=A0=A0=A0=A0 0.41 =B1 97%=A0=A0 +1470.1%=A0=A0=A0=A0=A0=A0 6.36 =B1 97%=
=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.remov=
e_vma.__do_munmap.__vm_munmap=0A=
=A0=A0=A0=A0=A0 2.81 =B1 79%=A0=A0=A0 +146.3%=A0=A0=A0=A0=A0=A0 6.92 =B1 44=
%=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.remo=
ve_vma.__do_munmap.mmap_region=0A=
=A0=A0=A0=A0=A0 7.51 =B1 23%=A0=A0=A0 +226.7%=A0=A0=A0=A0=A0 24.54 =B1 98%=
=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.remov=
e_vma.exit_mmap.mmput=0A=
=A0=A0=A0=A0=A0 7.36 =B1116%=A0=A0=A0 +497.6%=A0=A0=A0=A0=A0 44.00 =B1 94%=
=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.shmem=
_undo_range.shmem_truncate_range.shmem_evict_inode=0A=
=A0=A0=A0=A0=A0 1495 =B1 31%=A0=A0=A0 +114.1%=A0=A0=A0=A0=A0=A0 3203 =B1=A0=
 4%=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.sm=
pboot_thread_fn.kthread.ret_from_fork=0A=
=A0=A0=A0=A0=A0 9.21 =B1 22%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=A0=
=A0=A0=A0=A0=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_r=
esched.stop_one_cpu.migrate_task_to.task_numa_migrate=0A=
=A0=A0=A0=A0 12.64 =B1=A0 2%=A0=A0=A0 +300.8%=A0=A0=A0=A0=A0 50.66 =B1 43%=
=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.stop_=
one_cpu.sched_exec.bprm_execve=0A=
=A0=A0=A0=A0=A0 7.61 =B1 29%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=A0=
=A0=A0=A0=A0=A0 perf-sched.wait_time.max.ms.preempt_schedule_common._cond_r=
esched.wait_for_completion.stop_two_cpus.migrate_swap=0A=
=A0=A0=A0=A0 20.69 =B1 50%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=A0=A0=
=A0=A0=A0=A0 perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.page_lock=
_anon_vma_read.rmap_walk_anon.try_to_unmap=0A=
=A0=A0=A0=A0 19.13 =B1 36%=A0=A0=A0 -100.0%=A0=A0=A0=A0=A0=A0 0.00=A0=A0=A0=
=A0=A0=A0=A0 perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.rmap_walk=
_anon.remove_migration_ptes.migrate_pages=0A=
=A0=A0=A0=A0=A0 2.03 =B1 55%=A0=A0=A0=A0 -96.2%=A0=A0=A0=A0=A0=A0 0.08 =B11=
51%=A0 perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.__put_anon_vma=
.unlink_anon_vmas.free_pgtables=0A=
=A0=A0=A0=A0=A0 7.53 =B1 25%=A0=A0=A0 +397.1%=A0=A0=A0=A0=A0 37.43 =B1 76%=
=A0 perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.__vma_adjust.__sp=
lit_vma.mprotect_fixup=0A=
=A0=A0=A0=A0 31.44 =B1 23%=A0=A0 +1888.2%=A0=A0=A0=A0 625.17 =B1 62%=A0 per=
f-sched.wait_time.max.ms.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy_pro=
cess=0A=
=A0=A0=A0=A0=A0 2.32 =B1 99%=A0=A0=A0=A0 -88.3%=A0=A0=A0=A0=A0=A0 0.27 =B1 =
87%=A0 perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.unlink_anon_vm=
as.free_pgtables.exit_mmap=0A=
=A0=A0=A0=A0 20.37 =B1 28%=A0=A0=A0 +184.7%=A0=A0=A0=A0=A0 57.99 =B1 80%=A0=
 perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.unlink_file_vma.free=
_pgtables.exit_mmap=0A=
=A0=A0=A0=A0 11.76 =B1 17%=A0=A0=A0 +170.3%=A0=A0=A0=A0=A0 31.80 =B1 43%=A0=
 perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.vma_link.mmap_region=
.do_mmap=0A=
=A0=A0=A0=A0=A0 5176=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -31.0%=A0=A0=A0=A0=A0=A0=
 3569=A0=A0=A0=A0=A0=A0=A0 perf-sched.wait_time.max.ms.schedule_hrtimeout_r=
ange_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait=0A=
=A0=A0=A0=A0=A0 5585=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -30.2%=A0=A0=A0=A0=A0=A0=
 3899=A0=A0=A0=A0=A0=A0=A0 perf-sched.wait_time.max.ms.schedule_hrtimeout_r=
ange_clock.poll_schedule_timeout.constprop.0.do_select=0A=
=A0=A0=A0 505.14=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +15.5%=A0=A0=A0=A0 583.69 =
=B1=A0 5%=A0 perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread=
.ret_from_fork=0A=
=A0=A0=A0=A0=A0 4816 =B1 15%=A0=A0=A0=A0 -31.5%=A0=A0=A0=A0=A0=A0 3297 =B1=
=A0 3%=A0 perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fo=
rk=0A=
=A0=A0=A0=A0=A0 1791=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -20.7%=A0=A0=A0=A0=A0=A0=
 1420 =B1=A0 3%=A0 perf-sched.wait_time.max.ms.worker_thread.kthread.ret_fr=
om_fork=0A=
=A0=A0=A0=A0 29455 =B1=A0 2%=A0=A0=A0=A0 +33.9%=A0=A0=A0=A0=A0 39449 =B1=A0=
 7%=A0 softirqs.CPU0.NET_RX=0A=
=A0=A0=A0=A0 25470=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +32.0%=A0=A0=A0=A0=A0 3362=
8=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU0.SCHED=0A=
=A0=A0=A0=A0 26529 =B1 11%=A0=A0=A0=A0 +43.7%=A0=A0=A0=A0=A0 38110 =B1=A0 9=
%=A0 softirqs.CPU1.NET_RX=0A=
=A0=A0=A0=A0 22797 =B1=A0 3%=A0=A0=A0=A0 +43.8%=A0=A0=A0=A0=A0 32782 =B1=A0=
 3%=A0 softirqs.CPU1.SCHED=0A=
=A0=A0=A0=A0 28371 =B1=A0 3%=A0=A0=A0=A0 +54.2%=A0=A0=A0=A0=A0 43762 =B1 13=
%=A0 softirqs.CPU10.NET_RX=0A=
=A0=A0=A0=A0 22629 =B1=A0 2%=A0=A0=A0=A0 +43.4%=A0=A0=A0=A0=A0 32439 =B1=A0=
 2%=A0 softirqs.CPU10.SCHED=0A=
=A0=A0=A0=A0 27171 =B1=A0 4%=A0=A0=A0=A0 +38.4%=A0=A0=A0=A0=A0 37593 =B1=A0=
 9%=A0 softirqs.CPU100.NET_RX=0A=
=A0=A0=A0=A0 23180 =B1=A0 2%=A0=A0=A0=A0 +39.1%=A0=A0=A0=A0=A0 32248=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU100.SCHED=0A=
=A0=A0=A0=A0 28196 =B1=A0 2%=A0=A0=A0=A0 +34.4%=A0=A0=A0=A0=A0 37895 =B1=A0=
 5%=A0 softirqs.CPU101.NET_RX=0A=
=A0=A0=A0=A0 23100=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.7%=A0=A0=A0=A0=A0 3251=
1 =B1=A0 2%=A0 softirqs.CPU101.SCHED=0A=
=A0=A0=A0=A0 27883 =B1=A0 3%=A0=A0=A0=A0 +43.5%=A0=A0=A0=A0=A0 40015 =B1 11=
%=A0 softirqs.CPU102.NET_RX=0A=
=A0=A0=A0=A0 22937 =B1=A0 2%=A0=A0=A0=A0 +41.4%=A0=A0=A0=A0=A0 32444 =B1=A0=
 2%=A0 softirqs.CPU102.SCHED=0A=
=A0=A0=A0=A0 28037=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.7%=A0=A0=A0=A0=A0 3946=
1 =B1=A0 7%=A0 softirqs.CPU103.NET_RX=0A=
=A0=A0=A0=A0 23000 =B1=A0 2%=A0=A0=A0=A0 +41.0%=A0=A0=A0=A0=A0 32435 =B1=A0=
 2%=A0 softirqs.CPU103.SCHED=0A=
=A0=A0=A0=A0 28345=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +34.9%=A0=A0=A0=A0=A0 3822=
9 =B1=A0 9%=A0 softirqs.CPU104.NET_RX=0A=
=A0=A0=A0=A0 22314 =B1=A0 3%=A0=A0=A0=A0 +45.3%=A0=A0=A0=A0=A0 32417 =B1=A0=
 2%=A0 softirqs.CPU104.SCHED=0A=
=A0=A0=A0=A0 27097 =B1=A0 2%=A0=A0=A0=A0 +40.7%=A0=A0=A0=A0=A0 38114 =B1=A0=
 3%=A0 softirqs.CPU105.NET_RX=0A=
=A0=A0=A0=A0 22615 =B1=A0 2%=A0=A0=A0=A0 +42.8%=A0=A0=A0=A0=A0 32294 =B1=A0=
 2%=A0 softirqs.CPU105.SCHED=0A=
=A0=A0=A0=A0 26463 =B1=A0 3%=A0=A0=A0=A0 +50.9%=A0=A0=A0=A0=A0 39943 =B1 12=
%=A0 softirqs.CPU106.NET_RX=0A=
=A0=A0=A0=A0 22730 =B1=A0 2%=A0=A0=A0=A0 +42.2%=A0=A0=A0=A0=A0 32319 =B1=A0=
 2%=A0 softirqs.CPU106.SCHED=0A=
=A0=A0=A0=A0 27957 =B1=A0 2%=A0=A0=A0=A0 +29.0%=A0=A0=A0=A0=A0 36058 =B1=A0=
 6%=A0 softirqs.CPU107.NET_RX=0A=
=A0=A0=A0=A0 22901 =B1=A0 2%=A0=A0=A0=A0 +41.3%=A0=A0=A0=A0=A0 32362 =B1=A0=
 2%=A0 softirqs.CPU107.SCHED=0A=
=A0=A0=A0=A0 29320 =B1=A0 8%=A0=A0=A0=A0 +33.4%=A0=A0=A0=A0=A0 39101 =B1 10=
%=A0 softirqs.CPU108.NET_RX=0A=
=A0=A0=A0=A0 22873 =B1=A0 2%=A0=A0=A0=A0 +41.2%=A0=A0=A0=A0=A0 32301 =B1=A0=
 2%=A0 softirqs.CPU108.SCHED=0A=
=A0=A0=A0=A0 29106 =B1=A0 2%=A0=A0=A0=A0 +31.5%=A0=A0=A0=A0=A0 38266 =B1=A0=
 3%=A0 softirqs.CPU109.NET_RX=0A=
=A0=A0=A0=A0 22591 =B1=A0 2%=A0=A0=A0=A0 +43.1%=A0=A0=A0=A0=A0 32336=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU109.SCHED=0A=
=A0=A0=A0=A0 28741 =B1=A0 5%=A0=A0=A0=A0 +34.6%=A0=A0=A0=A0=A0 38676 =B1=A0=
 6%=A0 softirqs.CPU11.NET_RX=0A=
=A0=A0=A0=A0 22399 =B1=A0 3%=A0=A0=A0=A0 +44.5%=A0=A0=A0=A0=A0 32364 =B1=A0=
 2%=A0 softirqs.CPU11.SCHED=0A=
=A0=A0=A0=A0 26804 =B1=A0 5%=A0=A0=A0=A0 +41.8%=A0=A0=A0=A0=A0 38006 =B1=A0=
 5%=A0 softirqs.CPU110.NET_RX=0A=
=A0=A0=A0=A0 22766 =B1=A0 2%=A0=A0=A0=A0 +43.3%=A0=A0=A0=A0=A0 32619 =B1=A0=
 2%=A0 softirqs.CPU110.SCHED=0A=
=A0=A0=A0=A0 25623 =B1=A0 7%=A0=A0=A0=A0 +45.9%=A0=A0=A0=A0=A0 37393 =B1=A0=
 9%=A0 softirqs.CPU111.NET_RX=0A=
=A0=A0=A0=A0 22586 =B1=A0 2%=A0=A0=A0=A0 +43.4%=A0=A0=A0=A0=A0 32391 =B1=A0=
 2%=A0 softirqs.CPU111.SCHED=0A=
=A0=A0=A0=A0 28020 =B1=A0 6%=A0=A0=A0=A0 +31.8%=A0=A0=A0=A0=A0 36917 =B1=A0=
 7%=A0 softirqs.CPU112.NET_RX=0A=
=A0=A0=A0=A0 22741=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +42.2%=A0=A0=A0=A0=A0 3234=
9 =B1=A0 2%=A0 softirqs.CPU112.SCHED=0A=
=A0=A0=A0=A0 28310 =B1=A0 7%=A0=A0=A0=A0 +35.1%=A0=A0=A0=A0=A0 38234 =B1 12=
%=A0 softirqs.CPU113.NET_RX=0A=
=A0=A0=A0=A0 22884 =B1=A0 2%=A0=A0=A0=A0 +42.4%=A0=A0=A0=A0=A0 32577 =B1=A0=
 2%=A0 softirqs.CPU113.SCHED=0A=
=A0=A0=A0=A0 25668 =B1=A0 5%=A0=A0=A0=A0 +45.9%=A0=A0=A0=A0=A0 37457 =B1=A0=
 7%=A0 softirqs.CPU114.NET_RX=0A=
=A0=A0=A0=A0 22706 =B1=A0 3%=A0=A0=A0=A0 +41.7%=A0=A0=A0=A0=A0 32178=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU114.SCHED=0A=
=A0=A0=A0=A0 28637 =B1=A0 5%=A0=A0=A0=A0 +37.6%=A0=A0=A0=A0=A0 39418 =B1=A0=
 6%=A0 softirqs.CPU115.NET_RX=0A=
=A0=A0=A0=A0 22796=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.0%=A0=A0=A0=A0=A0 3213=
9=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU115.SCHED=0A=
=A0=A0=A0=A0 26953 =B1=A0 7%=A0=A0=A0=A0 +42.1%=A0=A0=A0=A0=A0 38291 =B1=A0=
 7%=A0 softirqs.CPU116.NET_RX=0A=
=A0=A0=A0=A0 22646=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +42.1%=A0=A0=A0=A0=A0 3217=
1 =B1=A0 2%=A0 softirqs.CPU116.SCHED=0A=
=A0=A0=A0=A0 28477 =B1=A0 8%=A0=A0=A0=A0 +35.4%=A0=A0=A0=A0=A0 38544 =B1=A0=
 3%=A0 softirqs.CPU117.NET_RX=0A=
=A0=A0=A0=A0 22866 =B1=A0 2%=A0=A0=A0=A0 +40.8%=A0=A0=A0=A0=A0 32189 =B1=A0=
 2%=A0 softirqs.CPU117.SCHED=0A=
=A0=A0=A0=A0 27445 =B1=A0 7%=A0=A0=A0=A0 +40.9%=A0=A0=A0=A0=A0 38675 =B1 11=
%=A0 softirqs.CPU118.NET_RX=0A=
=A0=A0=A0=A0 22902=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.4%=A0=A0=A0=A0=A0 3238=
6 =B1=A0 2%=A0 softirqs.CPU118.SCHED=0A=
=A0=A0=A0=A0 26884 =B1=A0 4%=A0=A0=A0=A0 +38.3%=A0=A0=A0=A0=A0 37182 =B1=A0=
 6%=A0 softirqs.CPU119.NET_RX=0A=
=A0=A0=A0=A0 22721 =B1=A0 2%=A0=A0=A0=A0 +42.0%=A0=A0=A0=A0=A0 32265 =B1=A0=
 2%=A0 softirqs.CPU119.SCHED=0A=
=A0=A0=A0=A0 28376 =B1=A0 9%=A0=A0=A0=A0 +36.6%=A0=A0=A0=A0=A0 38767 =B1=A0=
 9%=A0 softirqs.CPU12.NET_RX=0A=
=A0=A0=A0=A0 22706 =B1=A0 3%=A0=A0=A0=A0 +40.4%=A0=A0=A0=A0=A0 31877 =B1=A0=
 2%=A0 softirqs.CPU12.SCHED=0A=
=A0=A0=A0=A0 27315 =B1=A0 7%=A0=A0=A0=A0 +45.1%=A0=A0=A0=A0=A0 39644 =B1=A0=
 4%=A0 softirqs.CPU120.NET_RX=0A=
=A0=A0=A0=A0 23157 =B1=A0 2%=A0=A0=A0=A0 +38.9%=A0=A0=A0=A0=A0 32175=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU120.SCHED=0A=
=A0=A0=A0=A0 26387 =B1=A0 5%=A0=A0=A0=A0 +51.6%=A0=A0=A0=A0=A0 40015 =B1=A0=
 4%=A0 softirqs.CPU121.NET_RX=0A=
=A0=A0=A0=A0 22856=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +38.5%=A0=A0=A0=A0=A0 3164=
6=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU121.SCHED=0A=
=A0=A0=A0=A0 25176 =B1=A0 7%=A0=A0=A0=A0 +67.6%=A0=A0=A0=A0=A0 42194 =B1=A0=
 4%=A0 softirqs.CPU122.NET_RX=0A=
=A0=A0=A0=A0 22775=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.3%=A0=A0=A0=A0=A0 3196=
2=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU122.SCHED=0A=
=A0=A0=A0=A0 25636 =B1=A0 5%=A0=A0=A0=A0 +60.8%=A0=A0=A0=A0=A0 41225 =B1=A0=
 7%=A0 softirqs.CPU123.NET_RX=0A=
=A0=A0=A0=A0 23322=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +37.7%=A0=A0=A0=A0=A0 3212=
4=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU123.SCHED=0A=
=A0=A0=A0=A0 29777 =B1=A0 2%=A0=A0=A0=A0 +37.4%=A0=A0=A0=A0=A0 40911 =B1=A0=
 3%=A0 softirqs.CPU124.NET_RX=0A=
=A0=A0=A0=A0 23141 =B1=A0 2%=A0=A0=A0=A0 +38.7%=A0=A0=A0=A0=A0 32098=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU124.SCHED=0A=
=A0=A0=A0=A0 25720 =B1=A0 7%=A0=A0=A0=A0 +53.0%=A0=A0=A0=A0=A0 39356 =B1=A0=
 4%=A0 softirqs.CPU125.NET_RX=0A=
=A0=A0=A0=A0 23140 =B1=A0 3%=A0=A0=A0=A0 +38.7%=A0=A0=A0=A0=A0 32104=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU125.SCHED=0A=
=A0=A0=A0=A0 27106 =B1=A0 2%=A0=A0=A0=A0 +44.7%=A0=A0=A0=A0=A0 39214 =B1=A0=
 2%=A0 softirqs.CPU126.NET_RX=0A=
=A0=A0=A0=A0 33141 =B1=A0 3%=A0=A0=A0=A0 +11.4%=A0=A0=A0=A0=A0 36924 =B1=A0=
 7%=A0 softirqs.CPU126.RCU=0A=
=A0=A0=A0=A0 23154 =B1=A0 2%=A0=A0=A0=A0 +38.6%=A0=A0=A0=A0=A0 32083=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU126.SCHED=0A=
=A0=A0=A0=A0 25748 =B1=A0 4%=A0=A0=A0=A0 +53.8%=A0=A0=A0=A0=A0 39601 =B1=A0=
 8%=A0 softirqs.CPU127.NET_RX=0A=
=A0=A0=A0=A0 23011 =B1=A0 2%=A0=A0=A0=A0 +39.4%=A0=A0=A0=A0=A0 32068=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU127.SCHED=0A=
=A0=A0=A0=A0 28647 =B1 11%=A0=A0=A0=A0 +42.1%=A0=A0=A0=A0=A0 40718=A0=A0=A0=
=A0=A0=A0=A0 softirqs.CPU128.NET_RX=0A=
=A0=A0=A0=A0 34186 =B1=A0 3%=A0=A0=A0=A0 +11.6%=A0=A0=A0=A0=A0 38137 =B1=A0=
 7%=A0 softirqs.CPU128.RCU=0A=
=A0=A0=A0=A0 23173 =B1=A0 2%=A0=A0=A0=A0 +38.2%=A0=A0=A0=A0=A0 32016=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU128.SCHED=0A=
=A0=A0=A0=A0 27101 =B1=A0 3%=A0=A0=A0=A0 +48.6%=A0=A0=A0=A0=A0 40259 =B1=A0=
 5%=A0 softirqs.CPU129.NET_RX=0A=
=A0=A0=A0=A0 22818=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.4%=A0=A0=A0=A0=A0 3204=
5=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU129.SCHED=0A=
=A0=A0=A0=A0 31534 =B1 12%=A0=A0=A0=A0 +25.9%=A0=A0=A0=A0=A0 39696 =B1 10%=
=A0 softirqs.CPU13.NET_RX=0A=
=A0=A0=A0=A0 22674 =B1=A0 2%=A0=A0=A0=A0 +41.6%=A0=A0=A0=A0=A0 32108 =B1=A0=
 2%=A0 softirqs.CPU13.SCHED=0A=
=A0=A0=A0=A0 27452=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +48.9%=A0=A0=A0=A0=A0 4087=
1 =B1=A0 2%=A0 softirqs.CPU130.NET_RX=0A=
=A0=A0=A0=A0 23203=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +37.1%=A0=A0=A0=A0=A0 3180=
7 =B1=A0 2%=A0 softirqs.CPU130.SCHED=0A=
=A0=A0=A0=A0 26896 =B1=A0 3%=A0=A0=A0=A0 +51.9%=A0=A0=A0=A0=A0 40860 =B1=A0=
 4%=A0 softirqs.CPU131.NET_RX=0A=
=A0=A0=A0=A0 23148 =B1=A0 2%=A0=A0=A0=A0 +37.4%=A0=A0=A0=A0=A0 31814=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU131.SCHED=0A=
=A0=A0=A0=A0 28393 =B1=A0 3%=A0=A0=A0=A0 +41.2%=A0=A0=A0=A0=A0 40084 =B1=A0=
 7%=A0 softirqs.CPU132.NET_RX=0A=
=A0=A0=A0=A0 23200=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +36.7%=A0=A0=A0=A0=A0 3170=
6=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU132.SCHED=0A=
=A0=A0=A0=A0 26482 =B1=A0 3%=A0=A0=A0=A0 +54.4%=A0=A0=A0=A0=A0 40891 =B1=A0=
 3%=A0 softirqs.CPU133.NET_RX=0A=
=A0=A0=A0=A0 22970=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.0%=A0=A0=A0=A0=A0 3238=
2 =B1=A0 2%=A0 softirqs.CPU133.SCHED=0A=
=A0=A0=A0=A0 26774 =B1=A0 7%=A0=A0=A0=A0 +44.7%=A0=A0=A0=A0=A0 38735 =B1=A0=
 5%=A0 softirqs.CPU134.NET_RX=0A=
=A0=A0=A0=A0 33646=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +10.7%=A0=A0=A0=A0=A0 3724=
0 =B1=A0 7%=A0 softirqs.CPU134.RCU=0A=
=A0=A0=A0=A0 23088 =B1=A0 2%=A0=A0=A0=A0 +38.6%=A0=A0=A0=A0=A0 32008=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU134.SCHED=0A=
=A0=A0=A0=A0 26666=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +54.1%=A0=A0=A0=A0=A0 4108=
1 =B1=A0 7%=A0 softirqs.CPU135.NET_RX=0A=
=A0=A0=A0=A0 33456 =B1=A0 4%=A0=A0=A0=A0 +14.0%=A0=A0=A0=A0=A0 38141 =B1=A0=
 8%=A0 softirqs.CPU135.RCU=0A=
=A0=A0=A0=A0 22804=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.0%=A0=A0=A0=A0=A0 3192=
5=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU135.SCHED=0A=
=A0=A0=A0=A0 26562 =B1=A0 5%=A0=A0=A0=A0 +55.4%=A0=A0=A0=A0=A0 41276 =B1=A0=
 7%=A0 softirqs.CPU136.NET_RX=0A=
=A0=A0=A0=A0 23134 =B1=A0 3%=A0=A0=A0=A0 +38.9%=A0=A0=A0=A0=A0 32141=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU136.SCHED=0A=
=A0=A0=A0=A0 25297 =B1=A0 4%=A0=A0=A0=A0 +62.9%=A0=A0=A0=A0=A0 41210 =B1=A0=
 6%=A0 softirqs.CPU137.NET_RX=0A=
=A0=A0=A0=A0 22846 =B1=A0 2%=A0=A0=A0=A0 +39.9%=A0=A0=A0=A0=A0 31955=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU137.SCHED=0A=
=A0=A0=A0=A0 26519 =B1=A0 6%=A0=A0=A0=A0 +51.6%=A0=A0=A0=A0=A0 40192 =B1=A0=
 4%=A0 softirqs.CPU138.NET_RX=0A=
=A0=A0=A0=A0 22478 =B1=A0 2%=A0=A0=A0=A0 +41.7%=A0=A0=A0=A0=A0 31858=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU138.SCHED=0A=
=A0=A0=A0=A0 26079 =B1=A0 9%=A0=A0=A0=A0 +62.0%=A0=A0=A0=A0=A0 42258 =B1=A0=
 2%=A0 softirqs.CPU139.NET_RX=0A=
=A0=A0=A0=A0 22994 =B1=A0 3%=A0=A0=A0=A0 +39.2%=A0=A0=A0=A0=A0 32007=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU139.SCHED=0A=
=A0=A0=A0=A0 26936 =B1=A0 2%=A0=A0=A0=A0 +43.0%=A0=A0=A0=A0=A0 38512 =B1=A0=
 9%=A0 softirqs.CPU14.NET_RX=0A=
=A0=A0=A0=A0 22604 =B1=A0 3%=A0=A0=A0=A0 +42.3%=A0=A0=A0=A0=A0 32166 =B1=A0=
 3%=A0 softirqs.CPU14.SCHED=0A=
=A0=A0=A0=A0 27625 =B1=A0 9%=A0=A0=A0=A0 +44.2%=A0=A0=A0=A0=A0 39847 =B1=A0=
 5%=A0 softirqs.CPU140.NET_RX=0A=
=A0=A0=A0=A0 33066 =B1=A0 5%=A0=A0=A0=A0 +14.6%=A0=A0=A0=A0=A0 37895 =B1=A0=
 8%=A0 softirqs.CPU140.RCU=0A=
=A0=A0=A0=A0 22609=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.6%=A0=A0=A0=A0=A0 3200=
6=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU140.SCHED=0A=
=A0=A0=A0=A0 26460 =B1=A0 5%=A0=A0=A0=A0 +58.1%=A0=A0=A0=A0=A0 41826 =B1=A0=
 5%=A0 softirqs.CPU141.NET_RX=0A=
=A0=A0=A0=A0 34319 =B1=A0 4%=A0=A0=A0=A0=A0 +9.6%=A0=A0=A0=A0=A0 37601 =B1=
=A0 8%=A0 softirqs.CPU141.RCU=0A=
=A0=A0=A0=A0 22848 =B1=A0 2%=A0=A0=A0=A0 +39.5%=A0=A0=A0=A0=A0 31868=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU141.SCHED=0A=
=A0=A0=A0=A0 27385 =B1=A0 8%=A0=A0=A0=A0 +52.1%=A0=A0=A0=A0=A0 41645 =B1=A0=
 6%=A0 softirqs.CPU142.NET_RX=0A=
=A0=A0=A0=A0 22881 =B1=A0 2%=A0=A0=A0=A0 +40.0%=A0=A0=A0=A0=A0 32033=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU142.SCHED=0A=
=A0=A0=A0=A0 27724 =B1=A0 3%=A0=A0=A0=A0 +46.8%=A0=A0=A0=A0=A0 40700 =B1=A0=
 5%=A0 softirqs.CPU143.NET_RX=0A=
=A0=A0=A0=A0 34109 =B1=A0 4%=A0=A0=A0=A0 +10.8%=A0=A0=A0=A0=A0 37789 =B1=A0=
 8%=A0 softirqs.CPU143.RCU=0A=
=A0=A0=A0=A0 23092 =B1=A0 2%=A0=A0=A0=A0 +39.1%=A0=A0=A0=A0=A0 32110=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU143.SCHED=0A=
=A0=A0=A0=A0 28902 =B1=A0 8%=A0=A0=A0=A0 +30.5%=A0=A0=A0=A0=A0 37711=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU144.NET_RX=0A=
=A0=A0=A0=A0 34885 =B1=A0 7%=A0=A0=A0=A0=A0 +8.2%=A0=A0=A0=A0=A0 37745 =B1=
=A0 7%=A0 softirqs.CPU144.RCU=0A=
=A0=A0=A0=A0 22671=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.8%=A0=A0=A0=A0=A0 3192=
9=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU144.SCHED=0A=
=A0=A0=A0=A0 29181 =B1 10%=A0=A0=A0=A0 +43.3%=A0=A0=A0=A0=A0 41814 =B1=A0 7=
%=A0 softirqs.CPU145.NET_RX=0A=
=A0=A0=A0=A0 22655=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +38.5%=A0=A0=A0=A0=A0 3137=
1 =B1=A0 2%=A0 softirqs.CPU145.SCHED=0A=
=A0=A0=A0=A0 28250 =B1=A0 7%=A0=A0=A0=A0 +33.9%=A0=A0=A0=A0=A0 37815 =B1=A0=
 5%=A0 softirqs.CPU146.NET_RX=0A=
=A0=A0=A0=A0 22502=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +42.7%=A0=A0=A0=A0=A0 3211=
5=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU146.SCHED=0A=
=A0=A0=A0=A0 26352 =B1=A0 5%=A0=A0=A0=A0 +44.3%=A0=A0=A0=A0=A0 38033 =B1=A0=
 4%=A0 softirqs.CPU147.NET_RX=0A=
=A0=A0=A0=A0 34098=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +9.1%=A0=A0=A0=A0=A0 37=
212 =B1=A0 5%=A0 softirqs.CPU147.RCU=0A=
=A0=A0=A0=A0 22712=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +39.8%=A0=A0=A0=A0=A0 3175=
9=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU147.SCHED=0A=
=A0=A0=A0=A0 26457 =B1=A0 5%=A0=A0=A0=A0 +47.7%=A0=A0=A0=A0=A0 39077 =B1=A0=
 2%=A0 softirqs.CPU148.NET_RX=0A=
=A0=A0=A0=A0 34771=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +10.8%=A0=A0=A0=A0=A0 3854=
2 =B1=A0 5%=A0 softirqs.CPU148.RCU=0A=
=A0=A0=A0=A0 22626=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.1%=A0=A0=A0=A0=A0 3192=
5=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU148.SCHED=0A=
=A0=A0=A0=A0 27813 =B1=A0 3%=A0=A0=A0=A0 +38.2%=A0=A0=A0=A0=A0 38431 =B1=A0=
 3%=A0 softirqs.CPU149.NET_RX=0A=
=A0=A0=A0=A0 34785 =B1=A0 3%=A0=A0=A0=A0=A0 +9.4%=A0=A0=A0=A0=A0 38071 =B1=
=A0 6%=A0 softirqs.CPU149.RCU=0A=
=A0=A0=A0=A0 22830=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +39.5%=A0=A0=A0=A0=A0 3185=
7=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU149.SCHED=0A=
=A0=A0=A0=A0 27674=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +35.0%=A0=A0=A0=A0=A0 3735=
6 =B1 10%=A0 softirqs.CPU15.NET_RX=0A=
=A0=A0=A0=A0 22708 =B1=A0 3%=A0=A0=A0=A0 +40.8%=A0=A0=A0=A0=A0 31984 =B1=A0=
 2%=A0 softirqs.CPU15.SCHED=0A=
=A0=A0=A0=A0 28914 =B1=A0 4%=A0=A0=A0=A0 +38.6%=A0=A0=A0=A0=A0 40073 =B1=A0=
 5%=A0 softirqs.CPU150.NET_RX=0A=
=A0=A0=A0=A0 22867=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.2%=A0=A0=A0=A0=A0 3205=
4=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU150.SCHED=0A=
=A0=A0=A0=A0 26654=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +46.9%=A0=A0=A0=A0=A0 3914=
5 =B1=A0 4%=A0 softirqs.CPU151.NET_RX=0A=
=A0=A0=A0=A0 35269 =B1=A0 5%=A0=A0=A0=A0=A0 +7.1%=A0=A0=A0=A0=A0 37772 =B1=
=A0 5%=A0 softirqs.CPU151.RCU=0A=
=A0=A0=A0=A0 22567=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.7%=A0=A0=A0=A0=A0 3198=
7=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU151.SCHED=0A=
=A0=A0=A0=A0 27340 =B1=A0 3%=A0=A0=A0=A0 +35.5%=A0=A0=A0=A0=A0 37050 =B1=A0=
 7%=A0 softirqs.CPU152.NET_RX=0A=
=A0=A0=A0=A0 22561=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.1%=A0=A0=A0=A0=A0 3183=
3=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU152.SCHED=0A=
=A0=A0=A0=A0 25682 =B1=A0 4%=A0=A0=A0=A0 +52.9%=A0=A0=A0=A0=A0 39264 =B1=A0=
 3%=A0 softirqs.CPU153.NET_RX=0A=
=A0=A0=A0=A0 33854 =B1=A0 3%=A0=A0=A0=A0 +13.6%=A0=A0=A0=A0=A0 38450 =B1=A0=
 5%=A0 softirqs.CPU153.RCU=0A=
=A0=A0=A0=A0 22484=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +42.2%=A0=A0=A0=A0=A0 3197=
2=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU153.SCHED=0A=
=A0=A0=A0=A0 27824 =B1=A0 6%=A0=A0=A0=A0 +45.0%=A0=A0=A0=A0=A0 40343=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU154.NET_RX=0A=
=A0=A0=A0=A0 34996 =B1=A0 2%=A0=A0=A0=A0=A0 +9.1%=A0=A0=A0=A0=A0 38165 =B1=
=A0 5%=A0 softirqs.CPU154.RCU=0A=
=A0=A0=A0=A0 22409=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.5%=A0=A0=A0=A0=A0 3171=
7=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU154.SCHED=0A=
=A0=A0=A0=A0 26948 =B1=A0 6%=A0=A0=A0=A0 +51.9%=A0=A0=A0=A0=A0 40940 =B1=A0=
 3%=A0 softirqs.CPU155.NET_RX=0A=
=A0=A0=A0=A0 35069=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +10.6%=A0=A0=A0=A0=A0 3877=
9 =B1=A0 5%=A0 softirqs.CPU155.RCU=0A=
=A0=A0=A0=A0 22696=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +42.2%=A0=A0=A0=A0=A0 3226=
6=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU155.SCHED=0A=
=A0=A0=A0=A0 26787 =B1=A0 3%=A0=A0=A0=A0 +45.7%=A0=A0=A0=A0=A0 39032 =B1=A0=
 4%=A0 softirqs.CPU156.NET_RX=0A=
=A0=A0=A0=A0 22583=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.3%=A0=A0=A0=A0=A0 3190=
2=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU156.SCHED=0A=
=A0=A0=A0=A0 26065 =B1=A0 2%=A0=A0=A0=A0 +47.8%=A0=A0=A0=A0=A0 38529 =B1=A0=
 4%=A0 softirqs.CPU157.NET_RX=0A=
=A0=A0=A0=A0 22442=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +42.0%=A0=A0=A0=A0=A0 3186=
6=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU157.SCHED=0A=
=A0=A0=A0=A0 27310 =B1=A0 3%=A0=A0=A0=A0 +42.2%=A0=A0=A0=A0=A0 38826 =B1=A0=
 8%=A0 softirqs.CPU158.NET_RX=0A=
=A0=A0=A0=A0 22593=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.5%=A0=A0=A0=A0=A0 3175=
2=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU158.SCHED=0A=
=A0=A0=A0=A0 26411 =B1=A0 4%=A0=A0=A0=A0 +47.7%=A0=A0=A0=A0=A0 39018=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU159.NET_RX=0A=
=A0=A0=A0=A0 22535=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +42.5%=A0=A0=A0=A0=A0 3210=
3=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU159.SCHED=0A=
=A0=A0=A0=A0 28586 =B1=A0 3%=A0=A0=A0=A0 +30.9%=A0=A0=A0=A0=A0 37421 =B1=A0=
 8%=A0 softirqs.CPU16.NET_RX=0A=
=A0=A0=A0=A0 22668 =B1=A0 3%=A0=A0=A0=A0 +45.0%=A0=A0=A0=A0=A0 32879 =B1=A0=
 3%=A0 softirqs.CPU16.SCHED=0A=
=A0=A0=A0=A0 27341 =B1=A0 2%=A0=A0=A0=A0 +39.4%=A0=A0=A0=A0=A0 38105 =B1=A0=
 2%=A0 softirqs.CPU160.NET_RX=0A=
=A0=A0=A0=A0 22494=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.5%=A0=A0=A0=A0=A0 3182=
9=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU160.SCHED=0A=
=A0=A0=A0=A0 26309=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +47.7%=A0=A0=A0=A0=A0 3887=
0 =B1=A0 6%=A0 softirqs.CPU161.NET_RX=0A=
=A0=A0=A0=A0 22652=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.1%=A0=A0=A0=A0=A0 3196=
4=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU161.SCHED=0A=
=A0=A0=A0=A0 28102 =B1=A0 3%=A0=A0=A0=A0 +35.3%=A0=A0=A0=A0=A0 38031 =B1=A0=
 3%=A0 softirqs.CPU162.NET_RX=0A=
=A0=A0=A0=A0 34995 =B1=A0 4%=A0=A0=A0=A0=A0 +6.5%=A0=A0=A0=A0=A0 37255 =B1=
=A0 7%=A0 softirqs.CPU162.RCU=0A=
=A0=A0=A0=A0 22800=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.4%=A0=A0=A0=A0=A0 3200=
0=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU162.SCHED=0A=
=A0=A0=A0=A0 24958 =B1=A0 5%=A0=A0=A0=A0 +53.9%=A0=A0=A0=A0=A0 38412 =B1=A0=
 7%=A0 softirqs.CPU163.NET_RX=0A=
=A0=A0=A0=A0 22582=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +42.1%=A0=A0=A0=A0=A0 3207=
9=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU163.SCHED=0A=
=A0=A0=A0=A0 27327 =B1=A0 2%=A0=A0=A0=A0 +36.9%=A0=A0=A0=A0=A0 37415 =B1=A0=
 4%=A0 softirqs.CPU164.NET_RX=0A=
=A0=A0=A0=A0 22516=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +43.0%=A0=A0=A0=A0=A0 3220=
4=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU164.SCHED=0A=
=A0=A0=A0=A0 27456 =B1=A0 5%=A0=A0=A0=A0 +46.4%=A0=A0=A0=A0=A0 40188 =B1=A0=
 4%=A0 softirqs.CPU165.NET_RX=0A=
=A0=A0=A0=A0 22509=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +42.6%=A0=A0=A0=A0=A0 3210=
4=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU165.SCHED=0A=
=A0=A0=A0=A0 26840 =B1=A0 3%=A0=A0=A0=A0 +42.0%=A0=A0=A0=A0=A0 38118 =B1=A0=
 5%=A0 softirqs.CPU166.NET_RX=0A=
=A0=A0=A0=A0 22847=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.1%=A0=A0=A0=A0=A0 3200=
2=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU166.SCHED=0A=
=A0=A0=A0=A0 28288 =B1=A0 2%=A0=A0=A0=A0 +45.7%=A0=A0=A0=A0=A0 41208 =B1=A0=
 8%=A0 softirqs.CPU167.NET_RX=0A=
=A0=A0=A0=A0 22656=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +43.6%=A0=A0=A0=A0=A0 3252=
9 =B1=A0 2%=A0 softirqs.CPU167.SCHED=0A=
=A0=A0=A0=A0 27845=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.0%=A0=A0=A0=A0=A0 3898=
2 =B1=A0 5%=A0 softirqs.CPU168.NET_RX=0A=
=A0=A0=A0=A0 22861=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +39.9%=A0=A0=A0=A0=A0 3198=
4=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU168.SCHED=0A=
=A0=A0=A0=A0 26590 =B1=A0 8%=A0=A0=A0=A0 +55.4%=A0=A0=A0=A0=A0 41316 =B1=A0=
 5%=A0 softirqs.CPU169.NET_RX=0A=
=A0=A0=A0=A0 22774=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.5%=A0=A0=A0=A0=A0 3199=
0=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU169.SCHED=0A=
=A0=A0=A0=A0 27965 =B1=A0 4%=A0=A0=A0=A0 +34.4%=A0=A0=A0=A0=A0 37581 =B1=A0=
 6%=A0 softirqs.CPU17.NET_RX=0A=
=A0=A0=A0=A0 22416=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +43.0%=A0=A0=A0=A0=A0 3206=
4 =B1=A0 3%=A0 softirqs.CPU17.SCHED=0A=
=A0=A0=A0=A0 29095 =B1=A0 2%=A0=A0=A0=A0 +43.8%=A0=A0=A0=A0=A0 41848 =B1=A0=
 4%=A0 softirqs.CPU170.NET_RX=0A=
=A0=A0=A0=A0 22753=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.9%=A0=A0=A0=A0=A0 3229=
5=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU170.SCHED=0A=
=A0=A0=A0=A0 25289=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +56.3%=A0=A0=A0=A0=A0 3953=
8 =B1=A0 4%=A0 softirqs.CPU171.NET_RX=0A=
=A0=A0=A0=A0 33179 =B1=A0 2%=A0=A0=A0=A0=A0 +7.3%=A0=A0=A0=A0=A0 35615 =B1=
=A0 7%=A0 softirqs.CPU171.RCU=0A=
=A0=A0=A0=A0 22899=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.5%=A0=A0=A0=A0=A0 3217=
1=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU171.SCHED=0A=
=A0=A0=A0=A0 25293 =B1=A0 3%=A0=A0=A0=A0 +60.0%=A0=A0=A0=A0=A0 40480 =B1=A0=
 7%=A0 softirqs.CPU172.NET_RX=0A=
=A0=A0=A0=A0 22584=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +42.6%=A0=A0=A0=A0=A0 3219=
6=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU172.SCHED=0A=
=A0=A0=A0=A0 27200 =B1=A0 5%=A0=A0=A0=A0 +50.1%=A0=A0=A0=A0=A0 40831 =B1=A0=
 4%=A0 softirqs.CPU173.NET_RX=0A=
=A0=A0=A0=A0 22804=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.1%=A0=A0=A0=A0=A0 3218=
3=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU173.SCHED=0A=
=A0=A0=A0=A0 27779 =B1=A0 3%=A0=A0=A0=A0 +49.3%=A0=A0=A0=A0=A0 41464 =B1=A0=
 7%=A0 softirqs.CPU174.NET_RX=0A=
=A0=A0=A0=A0 22569=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +42.0%=A0=A0=A0=A0=A0 3205=
6=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU174.SCHED=0A=
=A0=A0=A0=A0 26980 =B1=A0 6%=A0=A0=A0=A0 +49.2%=A0=A0=A0=A0=A0 40261 =B1=A0=
 5%=A0 softirqs.CPU175.NET_RX=0A=
=A0=A0=A0=A0 22818=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.2%=A0=A0=A0=A0=A0 3222=
0=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU175.SCHED=0A=
=A0=A0=A0=A0 27496 =B1=A0 6%=A0=A0=A0=A0 +48.8%=A0=A0=A0=A0=A0 40909 =B1=A0=
 9%=A0 softirqs.CPU176.NET_RX=0A=
=A0=A0=A0=A0 22818=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.9%=A0=A0=A0=A0=A0 3213=
9=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU176.SCHED=0A=
=A0=A0=A0=A0 27197=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +42.7%=A0=A0=A0=A0=A0 3881=
7 =B1=A0 8%=A0 softirqs.CPU177.NET_RX=0A=
=A0=A0=A0=A0 22770=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.4%=A0=A0=A0=A0=A0 3197=
6=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU177.SCHED=0A=
=A0=A0=A0=A0 27688 =B1=A0 2%=A0=A0=A0=A0 +45.6%=A0=A0=A0=A0=A0 40318 =B1=A0=
 8%=A0 softirqs.CPU178.NET_RX=0A=
=A0=A0=A0=A0 22820=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +39.9%=A0=A0=A0=A0=A0 3193=
7=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU178.SCHED=0A=
=A0=A0=A0=A0 26078 =B1=A0 4%=A0=A0=A0=A0 +51.3%=A0=A0=A0=A0=A0 39444 =B1=A0=
 5%=A0 softirqs.CPU179.NET_RX=0A=
=A0=A0=A0=A0 22716=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.5%=A0=A0=A0=A0=A0 3191=
2=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU179.SCHED=0A=
=A0=A0=A0=A0 27755 =B1=A0 2%=A0=A0=A0=A0 +41.2%=A0=A0=A0=A0=A0 39191 =B1=A0=
 8%=A0 softirqs.CPU18.NET_RX=0A=
=A0=A0=A0=A0 22621 =B1=A0 2%=A0=A0=A0=A0 +41.0%=A0=A0=A0=A0=A0 31900=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU18.SCHED=0A=
=A0=A0=A0=A0 28019 =B1=A0 5%=A0=A0=A0=A0 +40.3%=A0=A0=A0=A0=A0 39303 =B1=A0=
 9%=A0 softirqs.CPU180.NET_RX=0A=
=A0=A0=A0=A0 22549=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.3%=A0=A0=A0=A0=A0 3186=
9=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU180.SCHED=0A=
=A0=A0=A0=A0 27487 =B1 10%=A0=A0=A0=A0 +46.9%=A0=A0=A0=A0=A0 40381 =B1=A0 7=
%=A0 softirqs.CPU181.NET_RX=0A=
=A0=A0=A0=A0 22776=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.2%=A0=A0=A0=A0=A0 3194=
3=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU181.SCHED=0A=
=A0=A0=A0=A0 26432 =B1=A0 2%=A0=A0=A0=A0 +55.0%=A0=A0=A0=A0=A0 40971 =B1=A0=
 7%=A0 softirqs.CPU182.NET_RX=0A=
=A0=A0=A0=A0 22815=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.7%=A0=A0=A0=A0=A0 3210=
5=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU182.SCHED=0A=
=A0=A0=A0=A0 27997 =B1=A0 4%=A0=A0=A0=A0 +46.5%=A0=A0=A0=A0=A0 41010 =B1=A0=
 4%=A0 softirqs.CPU183.NET_RX=0A=
=A0=A0=A0=A0 22875=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +39.9%=A0=A0=A0=A0=A0 3200=
4=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU183.SCHED=0A=
=A0=A0=A0=A0 24478 =B1 14%=A0=A0=A0=A0 +67.2%=A0=A0=A0=A0=A0 40939 =B1 10%=
=A0 softirqs.CPU184.NET_RX=0A=
=A0=A0=A0=A0 22192 =B1=A0 3%=A0=A0=A0=A0 +45.0%=A0=A0=A0=A0=A0 32177=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU184.SCHED=0A=
=A0=A0=A0=A0 27366=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.4%=A0=A0=A0=A0=A0 3841=
7 =B1=A0 8%=A0 softirqs.CPU185.NET_RX=0A=
=A0=A0=A0=A0 22879=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.4%=A0=A0=A0=A0=A0 3211=
9=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU185.SCHED=0A=
=A0=A0=A0=A0 28955 =B1=A0 4%=A0=A0=A0=A0 +36.2%=A0=A0=A0=A0=A0 39443 =B1=A0=
 6%=A0 softirqs.CPU186.NET_RX=0A=
=A0=A0=A0=A0 22929=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +39.2%=A0=A0=A0=A0=A0 3191=
3=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU186.SCHED=0A=
=A0=A0=A0=A0 26140 =B1=A0 5%=A0=A0=A0=A0 +50.3%=A0=A0=A0=A0=A0 39290 =B1=A0=
 8%=A0 softirqs.CPU187.NET_RX=0A=
=A0=A0=A0=A0 23163=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +38.6%=A0=A0=A0=A0=A0 3211=
0=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU187.SCHED=0A=
=A0=A0=A0=A0 26199=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +56.2%=A0=A0=A0=A0=A0 4092=
0 =B1 11%=A0 softirqs.CPU188.NET_RX=0A=
=A0=A0=A0=A0 22814=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.5%=A0=A0=A0=A0=A0 3227=
6=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU188.SCHED=0A=
=A0=A0=A0=A0 27178 =B1=A0 5%=A0=A0=A0=A0 +49.7%=A0=A0=A0=A0=A0 40699 =B1=A0=
 3%=A0 softirqs.CPU189.NET_RX=0A=
=A0=A0=A0=A0 22673=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.5%=A0=A0=A0=A0=A0 3208=
3=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU189.SCHED=0A=
=A0=A0=A0=A0 27438 =B1=A0 7%=A0=A0=A0=A0 +38.7%=A0=A0=A0=A0=A0 38069 =B1=A0=
 5%=A0 softirqs.CPU19.NET_RX=0A=
=A0=A0=A0=A0 22583 =B1=A0 3%=A0=A0=A0=A0 +42.0%=A0=A0=A0=A0=A0 32066 =B1=A0=
 2%=A0 softirqs.CPU19.SCHED=0A=
=A0=A0=A0=A0 26118 =B1=A0 9%=A0=A0=A0=A0 +42.6%=A0=A0=A0=A0=A0 37257 =B1=A0=
 8%=A0 softirqs.CPU190.NET_RX=0A=
=A0=A0=A0=A0 22621=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.6%=A0=A0=A0=A0=A0 3202=
2=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU190.SCHED=0A=
=A0=A0=A0=A0 25609 =B1=A0 5%=A0=A0=A0=A0 +52.5%=A0=A0=A0=A0=A0 39055 =B1=A0=
 9%=A0 softirqs.CPU191.NET_RX=0A=
=A0=A0=A0=A0 22510=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.5%=A0=A0=A0=A0=A0 3161=
8=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU191.SCHED=0A=
=A0=A0=A0=A0 28410 =B1=A0 5%=A0=A0=A0=A0 +34.1%=A0=A0=A0=A0=A0 38091 =B1=A0=
 5%=A0 softirqs.CPU2.NET_RX=0A=
=A0=A0=A0=A0 22190=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +43.9%=A0=A0=A0=A0=A0 3193=
7 =B1=A0 2%=A0 softirqs.CPU2.SCHED=0A=
=A0=A0=A0=A0 28923 =B1 10%=A0=A0=A0=A0 +37.5%=A0=A0=A0=A0=A0 39780 =B1=A0 9=
%=A0 softirqs.CPU20.NET_RX=0A=
=A0=A0=A0=A0 22749 =B1=A0 4%=A0=A0=A0=A0 +41.2%=A0=A0=A0=A0=A0 32113 =B1=A0=
 2%=A0 softirqs.CPU20.SCHED=0A=
=A0=A0=A0=A0 27078 =B1=A0 3%=A0=A0=A0=A0 +38.2%=A0=A0=A0=A0=A0 37429 =B1=A0=
 8%=A0 softirqs.CPU21.NET_RX=0A=
=A0=A0=A0=A0 22477 =B1=A0 3%=A0=A0=A0=A0 +42.5%=A0=A0=A0=A0=A0 32029 =B1=A0=
 2%=A0 softirqs.CPU21.SCHED=0A=
=A0=A0=A0=A0 26006 =B1=A0 9%=A0=A0=A0=A0 +49.7%=A0=A0=A0=A0=A0 38922 =B1 11=
%=A0 softirqs.CPU22.NET_RX=0A=
=A0=A0=A0=A0 22743 =B1=A0 3%=A0=A0=A0=A0 +41.2%=A0=A0=A0=A0=A0 32108 =B1=A0=
 2%=A0 softirqs.CPU22.SCHED=0A=
=A0=A0=A0=A0 28691 =B1=A0 2%=A0=A0=A0=A0 +39.6%=A0=A0=A0=A0=A0 40046 =B1=A0=
 5%=A0 softirqs.CPU23.NET_RX=0A=
=A0=A0=A0=A0 22668 =B1=A0 3%=A0=A0=A0=A0 +41.1%=A0=A0=A0=A0=A0 31976 =B1=A0=
 2%=A0 softirqs.CPU23.SCHED=0A=
=A0=A0=A0=A0 32698 =B1=A0 4%=A0=A0=A0=A0 +27.5%=A0=A0=A0=A0=A0 41704 =B1=A0=
 3%=A0 softirqs.CPU24.NET_RX=0A=
=A0=A0=A0=A0 23538=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +34.9%=A0=A0=A0=A0=A0 3176=
4=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU24.SCHED=0A=
=A0=A0=A0=A0 27793=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +44.1%=A0=A0=A0=A0=A0 4003=
8 =B1=A0 9%=A0 softirqs.CPU25.NET_RX=0A=
=A0=A0=A0=A0 22892 =B1=A0 2%=A0=A0=A0=A0 +38.0%=A0=A0=A0=A0=A0 31602=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU25.SCHED=0A=
=A0=A0=A0=A0 30671 =B1=A0 3%=A0=A0=A0=A0 +36.4%=A0=A0=A0=A0=A0 41822 =B1=A0=
 7%=A0 softirqs.CPU26.NET_RX=0A=
=A0=A0=A0=A0 23207 =B1=A0 2%=A0=A0=A0=A0 +36.8%=A0=A0=A0=A0=A0 31744=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU26.SCHED=0A=
=A0=A0=A0=A0 26281 =B1=A0 6%=A0=A0=A0=A0 +57.6%=A0=A0=A0=A0=A0 41417 =B1=A0=
 3%=A0 softirqs.CPU27.NET_RX=0A=
=A0=A0=A0=A0 22758 =B1=A0 2%=A0=A0=A0=A0 +40.4%=A0=A0=A0=A0=A0 31952=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU27.SCHED=0A=
=A0=A0=A0=A0 26713 =B1=A0 5%=A0=A0=A0=A0 +54.6%=A0=A0=A0=A0=A0 41300 =B1=A0=
 4%=A0 softirqs.CPU28.NET_RX=0A=
=A0=A0=A0=A0 33769 =B1=A0 2%=A0=A0=A0=A0 +11.3%=A0=A0=A0=A0=A0 37593 =B1=A0=
 7%=A0 softirqs.CPU28.RCU=0A=
=A0=A0=A0=A0 22857 =B1=A0 3%=A0=A0=A0=A0 +38.2%=A0=A0=A0=A0=A0 31586=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU28.SCHED=0A=
=A0=A0=A0=A0 27219 =B1=A0 3%=A0=A0=A0=A0 +53.1%=A0=A0=A0=A0=A0 41664 =B1=A0=
 8%=A0 softirqs.CPU29.NET_RX=0A=
=A0=A0=A0=A0 22988 =B1=A0 3%=A0=A0=A0=A0 +38.2%=A0=A0=A0=A0=A0 31775=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU29.SCHED=0A=
=A0=A0=A0=A0 26571 =B1=A0 5%=A0=A0=A0=A0 +51.2%=A0=A0=A0=A0=A0 40171 =B1=A0=
 8%=A0 softirqs.CPU3.NET_RX=0A=
=A0=A0=A0=A0 23000 =B1=A0 3%=A0=A0=A0=A0 +38.9%=A0=A0=A0=A0=A0 31946 =B1=A0=
 3%=A0 softirqs.CPU3.SCHED=0A=
=A0=A0=A0=A0 26856 =B1=A0 4%=A0=A0=A0=A0 +57.9%=A0=A0=A0=A0=A0 42396 =B1=A0=
 2%=A0 softirqs.CPU30.NET_RX=0A=
=A0=A0=A0=A0 22915 =B1=A0 3%=A0=A0=A0=A0 +38.0%=A0=A0=A0=A0=A0 31629=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU30.SCHED=0A=
=A0=A0=A0=A0 28747 =B1=A0 6%=A0=A0=A0=A0 +42.3%=A0=A0=A0=A0=A0 40898 =B1=A0=
 9%=A0 softirqs.CPU31.NET_RX=0A=
=A0=A0=A0=A0 22863 =B1=A0 2%=A0=A0=A0=A0 +39.4%=A0=A0=A0=A0=A0 31864=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU31.SCHED=0A=
=A0=A0=A0=A0 26418 =B1=A0 4%=A0=A0=A0=A0 +56.0%=A0=A0=A0=A0=A0 41211 =B1=A0=
 4%=A0 softirqs.CPU32.NET_RX=0A=
=A0=A0=A0=A0 22861 =B1=A0 3%=A0=A0=A0=A0 +38.3%=A0=A0=A0=A0=A0 31613=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU32.SCHED=0A=
=A0=A0=A0=A0 27379 =B1 13%=A0=A0=A0=A0 +52.0%=A0=A0=A0=A0=A0 41619 =B1=A0 3=
%=A0 softirqs.CPU33.NET_RX=0A=
=A0=A0=A0=A0 22743=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +38.7%=A0=A0=A0=A0=A0 3153=
8=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU33.SCHED=0A=
=A0=A0=A0=A0 27331 =B1=A0 6%=A0=A0=A0=A0 +47.9%=A0=A0=A0=A0=A0 40432 =B1=A0=
 7%=A0 softirqs.CPU34.NET_RX=0A=
=A0=A0=A0=A0 23071 =B1=A0 2%=A0=A0=A0=A0 +37.5%=A0=A0=A0=A0=A0 31730=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU34.SCHED=0A=
=A0=A0=A0=A0 27997 =B1=A0 9%=A0=A0=A0=A0 +49.7%=A0=A0=A0=A0=A0 41922 =B1=A0=
 4%=A0 softirqs.CPU35.NET_RX=0A=
=A0=A0=A0=A0 34868 =B1=A0 3%=A0=A0=A0=A0 +10.6%=A0=A0=A0=A0=A0 38580 =B1=A0=
 7%=A0 softirqs.CPU35.RCU=0A=
=A0=A0=A0=A0 23029 =B1=A0 3%=A0=A0=A0=A0 +37.4%=A0=A0=A0=A0=A0 31635=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU35.SCHED=0A=
=A0=A0=A0=A0 26763 =B1=A0 4%=A0=A0=A0=A0 +59.4%=A0=A0=A0=A0=A0 42657 =B1=A0=
 6%=A0 softirqs.CPU36.NET_RX=0A=
=A0=A0=A0=A0 22829=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +38.7%=A0=A0=A0=A0=A0 3165=
7=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU36.SCHED=0A=
=A0=A0=A0=A0 27252=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +48.6%=A0=A0=A0=A0=A0 4048=
9 =B1=A0 3%=A0 softirqs.CPU37.NET_RX=0A=
=A0=A0=A0=A0 22546 =B1=A0 2%=A0=A0=A0=A0 +40.2%=A0=A0=A0=A0=A0 31603=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU37.SCHED=0A=
=A0=A0=A0=A0 26072 =B1=A0 9%=A0=A0=A0=A0 +67.4%=A0=A0=A0=A0=A0 43643 =B1=A0=
 7%=A0 softirqs.CPU38.NET_RX=0A=
=A0=A0=A0=A0 22711 =B1=A0 4%=A0=A0=A0=A0 +39.6%=A0=A0=A0=A0=A0 31710=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU38.SCHED=0A=
=A0=A0=A0=A0 27579 =B1=A0 3%=A0=A0=A0=A0 +57.8%=A0=A0=A0=A0=A0 43518 =B1=A0=
 5%=A0 softirqs.CPU39.NET_RX=0A=
=A0=A0=A0=A0 22705 =B1=A0 2%=A0=A0=A0=A0 +39.2%=A0=A0=A0=A0=A0 31596=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU39.SCHED=0A=
=A0=A0=A0=A0 28570 =B1=A0 3%=A0=A0=A0=A0 +30.7%=A0=A0=A0=A0=A0 37345 =B1=A0=
 7%=A0 softirqs.CPU4.NET_RX=0A=
=A0=A0=A0=A0 22763 =B1=A0 3%=A0=A0=A0=A0 +41.4%=A0=A0=A0=A0=A0 32189 =B1=A0=
 3%=A0 softirqs.CPU4.SCHED=0A=
=A0=A0=A0=A0 26544 =B1=A0 5%=A0=A0=A0=A0 +52.0%=A0=A0=A0=A0=A0 40348 =B1=A0=
 5%=A0 softirqs.CPU40.NET_RX=0A=
=A0=A0=A0=A0 22746 =B1=A0 3%=A0=A0=A0=A0 +39.5%=A0=A0=A0=A0=A0 31726=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU40.SCHED=0A=
=A0=A0=A0=A0 28165 =B1=A0 5%=A0=A0=A0=A0 +47.1%=A0=A0=A0=A0=A0 41432 =B1=A0=
 3%=A0 softirqs.CPU41.NET_RX=0A=
=A0=A0=A0=A0 22791 =B1=A0 3%=A0=A0=A0=A0 +38.8%=A0=A0=A0=A0=A0 31624=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU41.SCHED=0A=
=A0=A0=A0=A0 28718 =B1=A0 6%=A0=A0=A0=A0 +43.4%=A0=A0=A0=A0=A0 41176 =B1=A0=
 8%=A0 softirqs.CPU42.NET_RX=0A=
=A0=A0=A0=A0 22603=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +39.3%=A0=A0=A0=A0=A0 3149=
3=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU42.SCHED=0A=
=A0=A0=A0=A0 27257 =B1=A0 4%=A0=A0=A0=A0 +54.4%=A0=A0=A0=A0=A0 42085 =B1=A0=
 4%=A0 softirqs.CPU43.NET_RX=0A=
=A0=A0=A0=A0 22763 =B1=A0 3%=A0=A0=A0=A0 +39.4%=A0=A0=A0=A0=A0 31742=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU43.SCHED=0A=
=A0=A0=A0=A0 26604 =B1=A0 3%=A0=A0=A0=A0 +58.0%=A0=A0=A0=A0=A0 42041 =B1=A0=
 5%=A0 softirqs.CPU44.NET_RX=0A=
=A0=A0=A0=A0 33772 =B1=A0 5%=A0=A0=A0=A0 +13.2%=A0=A0=A0=A0=A0 38218 =B1=A0=
 7%=A0 softirqs.CPU44.RCU=0A=
=A0=A0=A0=A0 22764 =B1=A0 2%=A0=A0=A0=A0 +39.6%=A0=A0=A0=A0=A0 31790=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU44.SCHED=0A=
=A0=A0=A0=A0 26786 =B1=A0 4%=A0=A0=A0=A0 +54.4%=A0=A0=A0=A0=A0 41361 =B1=A0=
 6%=A0 softirqs.CPU45.NET_RX=0A=
=A0=A0=A0=A0 34271 =B1=A0 3%=A0=A0=A0=A0 +10.2%=A0=A0=A0=A0=A0 37764 =B1=A0=
 8%=A0 softirqs.CPU45.RCU=0A=
=A0=A0=A0=A0 22813 =B1=A0 3%=A0=A0=A0=A0 +38.4%=A0=A0=A0=A0=A0 31565=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU45.SCHED=0A=
=A0=A0=A0=A0 28082 =B1=A0 5%=A0=A0=A0=A0 +43.0%=A0=A0=A0=A0=A0 40154 =B1=A0=
 7%=A0 softirqs.CPU46.NET_RX=0A=
=A0=A0=A0=A0 34703 =B1=A0 4%=A0=A0=A0=A0=A0 +9.0%=A0=A0=A0=A0=A0 37818 =B1=
=A0 6%=A0 softirqs.CPU46.RCU=0A=
=A0=A0=A0=A0 22800 =B1=A0 4%=A0=A0=A0=A0 +39.4%=A0=A0=A0=A0=A0 31785=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU46.SCHED=0A=
=A0=A0=A0=A0 28229 =B1=A0 2%=A0=A0=A0=A0 +49.3%=A0=A0=A0=A0=A0 42156 =B1=A0=
 6%=A0 softirqs.CPU47.NET_RX=0A=
=A0=A0=A0=A0 35007 =B1=A0 3%=A0=A0=A0=A0=A0 +9.5%=A0=A0=A0=A0=A0 38323 =B1=
=A0 7%=A0 softirqs.CPU47.RCU=0A=
=A0=A0=A0=A0 22878 =B1=A0 2%=A0=A0=A0=A0 +38.2%=A0=A0=A0=A0=A0 31613=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU47.SCHED=0A=
=A0=A0=A0=A0 29087 =B1=A0 4%=A0=A0=A0=A0 +39.9%=A0=A0=A0=A0=A0 40686 =B1=A0=
 3%=A0 softirqs.CPU48.NET_RX=0A=
=A0=A0=A0=A0 22510=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.5%=A0=A0=A0=A0=A0 3162=
1=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU48.SCHED=0A=
=A0=A0=A0=A0 27833 =B1=A0 5%=A0=A0=A0=A0 +47.3%=A0=A0=A0=A0=A0 40991 =B1=A0=
 6%=A0 softirqs.CPU49.NET_RX=0A=
=A0=A0=A0=A0 22119=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +42.7%=A0=A0=A0=A0=A0 3157=
2=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU49.SCHED=0A=
=A0=A0=A0=A0 28242=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +35.9%=A0=A0=A0=A0=A0 3837=
4 =B1=A0 6%=A0 softirqs.CPU5.NET_RX=0A=
=A0=A0=A0=A0 22636 =B1=A0 3%=A0=A0=A0=A0 +42.1%=A0=A0=A0=A0=A0 32161 =B1=A0=
 2%=A0 softirqs.CPU5.SCHED=0A=
=A0=A0=A0=A0 28615 =B1=A0 4%=A0=A0=A0=A0 +37.2%=A0=A0=A0=A0=A0 39250 =B1=A0=
 5%=A0 softirqs.CPU50.NET_RX=0A=
=A0=A0=A0=A0 34409=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +12.2%=A0=A0=A0=A0=A0 3862=
3 =B1=A0 5%=A0 softirqs.CPU50.RCU=0A=
=A0=A0=A0=A0 22248=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.5%=A0=A0=A0=A0=A0 3148=
2=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU50.SCHED=0A=
=A0=A0=A0=A0 28739 =B1=A0 5%=A0=A0=A0=A0 +40.6%=A0=A0=A0=A0=A0 40405=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU51.NET_RX=0A=
=A0=A0=A0=A0 22458 =B1=A0 2%=A0=A0=A0=A0 +41.1%=A0=A0=A0=A0=A0 31679=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU51.SCHED=0A=
=A0=A0=A0=A0 28428 =B1=A0 6%=A0=A0=A0=A0 +34.7%=A0=A0=A0=A0=A0 38284=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU52.NET_RX=0A=
=A0=A0=A0=A0 22308=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.7%=A0=A0=A0=A0=A0 3160=
1=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU52.SCHED=0A=
=A0=A0=A0=A0 29032 =B1=A0 6%=A0=A0=A0=A0 +33.6%=A0=A0=A0=A0=A0 38786 =B1=A0=
 7%=A0 softirqs.CPU53.NET_RX=0A=
=A0=A0=A0=A0 34502 =B1=A0 5%=A0=A0=A0=A0 +10.0%=A0=A0=A0=A0=A0 37943 =B1=A0=
 8%=A0 softirqs.CPU53.RCU=0A=
=A0=A0=A0=A0 22408=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.7%=A0=A0=A0=A0=A0 3152=
6=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU53.SCHED=0A=
=A0=A0=A0=A0 27640 =B1=A0 7%=A0=A0=A0=A0 +42.5%=A0=A0=A0=A0=A0 39380 =B1=A0=
 2%=A0 softirqs.CPU54.NET_RX=0A=
=A0=A0=A0=A0 22473=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.7%=A0=A0=A0=A0=A0 3160=
9=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU54.SCHED=0A=
=A0=A0=A0=A0 26943 =B1=A0 9%=A0=A0=A0=A0 +42.4%=A0=A0=A0=A0=A0 38374 =B1=A0=
 4%=A0 softirqs.CPU55.NET_RX=0A=
=A0=A0=A0=A0 22289 =B1=A0 2%=A0=A0=A0=A0 +42.7%=A0=A0=A0=A0=A0 31800=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU55.SCHED=0A=
=A0=A0=A0=A0 27400 =B1=A0 4%=A0=A0=A0=A0 +40.2%=A0=A0=A0=A0=A0 38409 =B1=A0=
 5%=A0 softirqs.CPU56.NET_RX=0A=
=A0=A0=A0=A0 22354=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.0%=A0=A0=A0=A0=A0 3130=
0=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU56.SCHED=0A=
=A0=A0=A0=A0 26999 =B1=A0 2%=A0=A0=A0=A0 +46.5%=A0=A0=A0=A0=A0 39554 =B1=A0=
 6%=A0 softirqs.CPU57.NET_RX=0A=
=A0=A0=A0=A0 34130 =B1=A0 3%=A0=A0=A0=A0 +12.9%=A0=A0=A0=A0=A0 38546 =B1=A0=
 7%=A0 softirqs.CPU57.RCU=0A=
=A0=A0=A0=A0 22383=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.0%=A0=A0=A0=A0=A0 3156=
9=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU57.SCHED=0A=
=A0=A0=A0=A0 26684 =B1=A0 3%=A0=A0=A0=A0 +50.6%=A0=A0=A0=A0=A0 40177 =B1=A0=
 3%=A0 softirqs.CPU58.NET_RX=0A=
=A0=A0=A0=A0 34403 =B1=A0 3%=A0=A0=A0=A0 +11.9%=A0=A0=A0=A0=A0 38510 =B1=A0=
 7%=A0 softirqs.CPU58.RCU=0A=
=A0=A0=A0=A0 21983=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +44.1%=A0=A0=A0=A0=A0 3166=
7=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU58.SCHED=0A=
=A0=A0=A0=A0 28353=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.2%=A0=A0=A0=A0=A0 4003=
7 =B1=A0 5%=A0 softirqs.CPU59.NET_RX=0A=
=A0=A0=A0=A0 22456=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.7%=A0=A0=A0=A0=A0 3158=
9=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU59.SCHED=0A=
=A0=A0=A0=A0 27801 =B1 10%=A0=A0=A0=A0 +34.5%=A0=A0=A0=A0=A0 37398 =B1=A0 5=
%=A0 softirqs.CPU6.NET_RX=0A=
=A0=A0=A0=A0 22604 =B1=A0 3%=A0=A0=A0=A0 +41.8%=A0=A0=A0=A0=A0 32058 =B1=A0=
 2%=A0 softirqs.CPU6.SCHED=0A=
=A0=A0=A0=A0 26348 =B1=A0 3%=A0=A0=A0=A0 +55.7%=A0=A0=A0=A0=A0 41023=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU60.NET_RX=0A=
=A0=A0=A0=A0 22333=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.1%=A0=A0=A0=A0=A0 3151=
7=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU60.SCHED=0A=
=A0=A0=A0=A0 27592 =B1=A0 8%=A0=A0=A0=A0 +43.0%=A0=A0=A0=A0=A0 39449 =B1=A0=
 4%=A0 softirqs.CPU61.NET_RX=0A=
=A0=A0=A0=A0 22340=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.8%=A0=A0=A0=A0=A0 3144=
9=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU61.SCHED=0A=
=A0=A0=A0=A0 27991 =B1=A0 6%=A0=A0=A0=A0 +39.9%=A0=A0=A0=A0=A0 39173 =B1=A0=
 6%=A0 softirqs.CPU62.NET_RX=0A=
=A0=A0=A0=A0 22336=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.0%=A0=A0=A0=A0=A0 3150=
5=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU62.SCHED=0A=
=A0=A0=A0=A0 27979 =B1=A0 6%=A0=A0=A0=A0 +42.4%=A0=A0=A0=A0=A0 39848 =B1=A0=
 6%=A0 softirqs.CPU63.NET_RX=0A=
=A0=A0=A0=A0 22455=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.7%=A0=A0=A0=A0=A0 3159=
5=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU63.SCHED=0A=
=A0=A0=A0=A0 27343 =B1=A0 4%=A0=A0=A0=A0 +47.1%=A0=A0=A0=A0=A0 40224 =B1=A0=
 7%=A0 softirqs.CPU64.NET_RX=0A=
=A0=A0=A0=A0 22264=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +42.4%=A0=A0=A0=A0=A0 3170=
9=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU64.SCHED=0A=
=A0=A0=A0=A0 30930 =B1 12%=A0=A0=A0=A0 +24.7%=A0=A0=A0=A0=A0 38565 =B1=A0 3=
%=A0 softirqs.CPU65.NET_RX=0A=
=A0=A0=A0=A0 22563=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +39.9%=A0=A0=A0=A0=A0 3157=
2=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU65.SCHED=0A=
=A0=A0=A0=A0 27228 =B1=A0 3%=A0=A0=A0=A0 +40.3%=A0=A0=A0=A0=A0 38207 =B1=A0=
 5%=A0 softirqs.CPU66.NET_RX=0A=
=A0=A0=A0=A0 33624 =B1=A0 2%=A0=A0=A0=A0 +10.9%=A0=A0=A0=A0=A0 37300 =B1=A0=
 6%=A0 softirqs.CPU66.RCU=0A=
=A0=A0=A0=A0 22263=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +42.0%=A0=A0=A0=A0=A0 3161=
5=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU66.SCHED=0A=
=A0=A0=A0=A0 26629 =B1=A0 7%=A0=A0=A0=A0 +45.8%=A0=A0=A0=A0=A0 38826 =B1=A0=
 3%=A0 softirqs.CPU67.NET_RX=0A=
=A0=A0=A0=A0 22267=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +42.1%=A0=A0=A0=A0=A0 3164=
4=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU67.SCHED=0A=
=A0=A0=A0=A0 27039 =B1=A0 7%=A0=A0=A0=A0 +46.4%=A0=A0=A0=A0=A0 39598 =B1=A0=
 3%=A0 softirqs.CPU68.NET_RX=0A=
=A0=A0=A0=A0 22376=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.0%=A0=A0=A0=A0=A0 3155=
2=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU68.SCHED=0A=
=A0=A0=A0=A0 26835 =B1=A0 4%=A0=A0=A0=A0 +41.3%=A0=A0=A0=A0=A0 37921 =B1=A0=
 4%=A0 softirqs.CPU69.NET_RX=0A=
=A0=A0=A0=A0 22292=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +42.2%=A0=A0=A0=A0=A0 3169=
5=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU69.SCHED=0A=
=A0=A0=A0=A0 28526 =B1=A0 9%=A0=A0=A0=A0 +36.6%=A0=A0=A0=A0=A0 38980 =B1=A0=
 9%=A0 softirqs.CPU7.NET_RX=0A=
=A0=A0=A0=A0 22556 =B1=A0 3%=A0=A0=A0=A0 +42.0%=A0=A0=A0=A0=A0 32026 =B1=A0=
 3%=A0 softirqs.CPU7.SCHED=0A=
=A0=A0=A0=A0 27716 =B1=A0 6%=A0=A0=A0=A0 +44.2%=A0=A0=A0=A0=A0 39956 =B1=A0=
 5%=A0 softirqs.CPU70.NET_RX=0A=
=A0=A0=A0=A0 22376=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.4%=A0=A0=A0=A0=A0 3142=
1=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU70.SCHED=0A=
=A0=A0=A0=A0 25987 =B1=A0 2%=A0=A0=A0=A0 +54.0%=A0=A0=A0=A0=A0 40017 =B1=A0=
 5%=A0 softirqs.CPU71.NET_RX=0A=
=A0=A0=A0=A0 22256=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +42.9%=A0=A0=A0=A0=A0 3180=
3=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU71.SCHED=0A=
=A0=A0=A0=A0 30271 =B1=A0 2%=A0=A0=A0=A0 +31.6%=A0=A0=A0=A0=A0 39836 =B1=A0=
 8%=A0 softirqs.CPU72.NET_RX=0A=
=A0=A0=A0=A0 22864=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +39.9%=A0=A0=A0=A0=A0 3198=
8=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU72.SCHED=0A=
=A0=A0=A0=A0 28646 =B1=A0 7%=A0=A0=A0=A0 +40.8%=A0=A0=A0=A0=A0 40326 =B1=A0=
 6%=A0 softirqs.CPU73.NET_RX=0A=
=A0=A0=A0=A0 22434=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.4%=A0=A0=A0=A0=A0 3171=
5=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU73.SCHED=0A=
=A0=A0=A0=A0 27673 =B1=A0 4%=A0=A0=A0=A0 +44.6%=A0=A0=A0=A0=A0 40027 =B1=A0=
 5%=A0 softirqs.CPU74.NET_RX=0A=
=A0=A0=A0=A0 22454=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.1%=A0=A0=A0=A0=A0 3168=
8=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU74.SCHED=0A=
=A0=A0=A0=A0 26780 =B1=A0 5%=A0=A0=A0=A0 +50.1%=A0=A0=A0=A0=A0 40207 =B1=A0=
 5%=A0 softirqs.CPU75.NET_RX=0A=
=A0=A0=A0=A0 22613=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.8%=A0=A0=A0=A0=A0 3184=
0=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU75.SCHED=0A=
=A0=A0=A0=A0 28051=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +45.5%=A0=A0=A0=A0=A0 4082=
6 =B1=A0 5%=A0 softirqs.CPU76.NET_RX=0A=
=A0=A0=A0=A0 22608=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.0%=A0=A0=A0=A0=A0 3187=
9=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU76.SCHED=0A=
=A0=A0=A0=A0 26339 =B1=A0 5%=A0=A0=A0=A0 +49.7%=A0=A0=A0=A0=A0 39425 =B1 10=
%=A0 softirqs.CPU77.NET_RX=0A=
=A0=A0=A0=A0 22329=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +43.4%=A0=A0=A0=A0=A0 3201=
9=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU77.SCHED=0A=
=A0=A0=A0=A0 28822=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +38.8%=A0=A0=A0=A0=A0 4001=
1 =B1=A0 6%=A0 softirqs.CPU78.NET_RX=0A=
=A0=A0=A0=A0 22588=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.2%=A0=A0=A0=A0=A0 3190=
3=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU78.SCHED=0A=
=A0=A0=A0=A0 26965 =B1=A0 4%=A0=A0=A0=A0 +50.8%=A0=A0=A0=A0=A0 40656 =B1=A0=
 8%=A0 softirqs.CPU79.NET_RX=0A=
=A0=A0=A0=A0 22337=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.9%=A0=A0=A0=A0=A0 3170=
1=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU79.SCHED=0A=
=A0=A0=A0=A0 28854 =B1=A0 2%=A0=A0=A0=A0 +36.0%=A0=A0=A0=A0=A0 39243 =B1=A0=
 7%=A0 softirqs.CPU8.NET_RX=0A=
=A0=A0=A0=A0 33868 =B1=A0 2%=A0=A0=A0=A0=A0 +8.2%=A0=A0=A0=A0=A0 36644 =B1=
=A0 4%=A0 softirqs.CPU8.RCU=0A=
=A0=A0=A0=A0 22572 =B1=A0 2%=A0=A0=A0=A0 +41.6%=A0=A0=A0=A0=A0 31966 =B1=A0=
 3%=A0 softirqs.CPU8.SCHED=0A=
=A0=A0=A0=A0 25294 =B1=A0 3%=A0=A0=A0=A0 +62.3%=A0=A0=A0=A0=A0 41046 =B1=A0=
 9%=A0 softirqs.CPU80.NET_RX=0A=
=A0=A0=A0=A0 22560=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.6%=A0=A0=A0=A0=A0 3194=
9=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU80.SCHED=0A=
=A0=A0=A0=A0 27226 =B1=A0 6%=A0=A0=A0=A0 +44.2%=A0=A0=A0=A0=A0 39272 =B1=A0=
 5%=A0 softirqs.CPU81.NET_RX=0A=
=A0=A0=A0=A0 22433=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.8%=A0=A0=A0=A0=A0 3180=
2=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU81.SCHED=0A=
=A0=A0=A0=A0 28179 =B1=A0 2%=A0=A0=A0=A0 +45.8%=A0=A0=A0=A0=A0 41089 =B1=A0=
 6%=A0 softirqs.CPU82.NET_RX=0A=
=A0=A0=A0=A0 22503=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.1%=A0=A0=A0=A0=A0 3174=
2=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU82.SCHED=0A=
=A0=A0=A0=A0 25370 =B1=A0 6%=A0=A0=A0=A0 +65.5%=A0=A0=A0=A0=A0 41993 =B1=A0=
 3%=A0 softirqs.CPU83.NET_RX=0A=
=A0=A0=A0=A0 33224 =B1=A0 3%=A0=A0=A0=A0=A0 +9.5%=A0=A0=A0=A0=A0 36387 =B1=
=A0 5%=A0 softirqs.CPU83.RCU=0A=
=A0=A0=A0=A0 22482=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +43.4%=A0=A0=A0=A0=A0 3223=
9=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU83.SCHED=0A=
=A0=A0=A0=A0 29150 =B1=A0 4%=A0=A0=A0=A0 +41.9%=A0=A0=A0=A0=A0 41357 =B1=A0=
 6%=A0 softirqs.CPU84.NET_RX=0A=
=A0=A0=A0=A0 22540=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.3%=A0=A0=A0=A0=A0 3162=
9=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU84.SCHED=0A=
=A0=A0=A0=A0 27566 =B1=A0 7%=A0=A0=A0=A0 +45.2%=A0=A0=A0=A0=A0 40032 =B1=A0=
 6%=A0 softirqs.CPU85.NET_RX=0A=
=A0=A0=A0=A0 22614=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.5%=A0=A0=A0=A0=A0 3177=
9=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU85.SCHED=0A=
=A0=A0=A0=A0 26616 =B1=A0 3%=A0=A0=A0=A0 +48.0%=A0=A0=A0=A0=A0 39392 =B1=A0=
 8%=A0 softirqs.CPU86.NET_RX=0A=
=A0=A0=A0=A0 22503=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.8%=A0=A0=A0=A0=A0 3189=
9=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU86.SCHED=0A=
=A0=A0=A0=A0 27217=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +54.7%=A0=A0=A0=A0=A0 4209=
7 =B1=A0 4%=A0 softirqs.CPU87.NET_RX=0A=
=A0=A0=A0=A0 32656=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +11.1%=A0=A0=A0=A0=A0 3628=
6 =B1=A0 8%=A0 softirqs.CPU87.RCU=0A=
=A0=A0=A0=A0 22383=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.8%=A0=A0=A0=A0=A0 3174=
4=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU87.SCHED=0A=
=A0=A0=A0=A0 29444 =B1=A0 5%=A0=A0=A0=A0 +35.2%=A0=A0=A0=A0=A0 39821 =B1=A0=
 6%=A0 softirqs.CPU88.NET_RX=0A=
=A0=A0=A0=A0 22560 =B1=A0 2%=A0=A0=A0=A0 +41.3%=A0=A0=A0=A0=A0 31887=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU88.SCHED=0A=
=A0=A0=A0=A0 26383 =B1=A0 3%=A0=A0=A0=A0 +49.4%=A0=A0=A0=A0=A0 39403 =B1=A0=
 5%=A0 softirqs.CPU89.NET_RX=0A=
=A0=A0=A0=A0 22647=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.2%=A0=A0=A0=A0=A0 3198=
4=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU89.SCHED=0A=
=A0=A0=A0=A0 27413=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +45.5%=A0=A0=A0=A0=A0 3987=
3 =B1=A0 3%=A0 softirqs.CPU9.NET_RX=0A=
=A0=A0=A0=A0 22436 =B1=A0 3%=A0=A0=A0=A0 +43.3%=A0=A0=A0=A0=A0 32154 =B1=A0=
 2%=A0 softirqs.CPU9.SCHED=0A=
=A0=A0=A0=A0 28117 =B1=A0 4%=A0=A0=A0=A0 +39.1%=A0=A0=A0=A0=A0 39110 =B1=A0=
 5%=A0 softirqs.CPU90.NET_RX=0A=
=A0=A0=A0=A0 22524=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.6%=A0=A0=A0=A0=A0 3190=
3=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU90.SCHED=0A=
=A0=A0=A0=A0 28805 =B1=A0 3%=A0=A0=A0=A0 +43.1%=A0=A0=A0=A0=A0 41207 =B1=A0=
 2%=A0 softirqs.CPU91.NET_RX=0A=
=A0=A0=A0=A0 22981=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +38.0%=A0=A0=A0=A0=A0 3171=
4=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU91.SCHED=0A=
=A0=A0=A0=A0 27920 =B1=A0 9%=A0=A0=A0=A0 +46.1%=A0=A0=A0=A0=A0 40778 =B1=A0=
 7%=A0 softirqs.CPU92.NET_RX=0A=
=A0=A0=A0=A0 33255 =B1=A0 4%=A0=A0=A0=A0=A0 +8.9%=A0=A0=A0=A0=A0 36199 =B1=
=A0 7%=A0 softirqs.CPU92.RCU=0A=
=A0=A0=A0=A0 22467=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +42.2%=A0=A0=A0=A0=A0 3195=
5=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU92.SCHED=0A=
=A0=A0=A0=A0 26935 =B1=A0 5%=A0=A0=A0=A0 +49.3%=A0=A0=A0=A0=A0 40211 =B1=A0=
 6%=A0 softirqs.CPU93.NET_RX=0A=
=A0=A0=A0=A0 22407=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +42.4%=A0=A0=A0=A0=A0 3189=
8=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU93.SCHED=0A=
=A0=A0=A0=A0 25585 =B1=A0 6%=A0=A0=A0=A0 +63.7%=A0=A0=A0=A0=A0 41880 =B1=A0=
 5%=A0 softirqs.CPU94.NET_RX=0A=
=A0=A0=A0=A0 33095 =B1=A0 4%=A0=A0=A0=A0 +10.4%=A0=A0=A0=A0=A0 36528 =B1=A0=
 9%=A0 softirqs.CPU94.RCU=0A=
=A0=A0=A0=A0 22417=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.7%=A0=A0=A0=A0=A0 3176=
1=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU94.SCHED=0A=
=A0=A0=A0=A0 27659 =B1=A0 6%=A0=A0=A0=A0 +43.3%=A0=A0=A0=A0=A0 39639 =B1=A0=
 6%=A0 softirqs.CPU95.NET_RX=0A=
=A0=A0=A0=A0 21998=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +42.6%=A0=A0=A0=A0=A0 3136=
1=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU95.SCHED=0A=
=A0=A0=A0=A0 26582 =B1=A0 2%=A0=A0=A0=A0 +43.4%=A0=A0=A0=A0=A0 38128 =B1=A0=
 8%=A0 softirqs.CPU96.NET_RX=0A=
=A0=A0=A0=A0 22170 =B1=A0 3%=A0=A0=A0=A0 +45.7%=A0=A0=A0=A0=A0 32297=A0=A0=
=A0=A0=A0=A0=A0 softirqs.CPU96.SCHED=0A=
=A0=A0=A0=A0 27522 =B1=A0 5%=A0=A0=A0=A0 +39.4%=A0=A0=A0=A0=A0 38353 =B1=A0=
 9%=A0 softirqs.CPU97.NET_RX=0A=
=A0=A0=A0=A0 22468 =B1=A0 3%=A0=A0=A0=A0 +43.4%=A0=A0=A0=A0=A0 32209 =B1=A0=
 2%=A0 softirqs.CPU97.SCHED=0A=
=A0=A0=A0=A0 27117 =B1 12%=A0=A0=A0=A0 +39.8%=A0=A0=A0=A0=A0 37902 =B1 10%=
=A0 softirqs.CPU98.NET_RX=0A=
=A0=A0=A0=A0 22600=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +43.2%=A0=A0=A0=A0=A0 3236=
1 =B1=A0 2%=A0 softirqs.CPU98.SCHED=0A=
=A0=A0=A0=A0 26557 =B1=A0 2%=A0=A0=A0=A0 +43.7%=A0=A0=A0=A0=A0 38161 =B1=A0=
 7%=A0 softirqs.CPU99.NET_RX=0A=
=A0=A0=A0=A0 23003=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +41.6%=A0=A0=A0=A0=A0 3256=
5=A0=A0=A0=A0=A0=A0=A0 softirqs.CPU99.SCHED=0A=
=A0=A0 5270210=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +44.9%=A0=A0=A0 7635912=A0=A0=
=A0=A0=A0=A0=A0 softirqs.NET_RX=0A=
=A0=A0 4357512=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +40.8%=A0=A0=A0 6136169=A0=A0=
=A0=A0=A0=A0=A0 softirqs.SCHED=0A=
=A0=A0=A0=A0 80.01=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -80.0=A0=A0=A0=A0=A0=A0=A0=
 0.00=A0=A0=A0=A0=A0=A0=A0 perf-profile.calltrace.cycles-pp.native_queued_s=
pin_lock_slowpath._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir=
=0A=
=A0=A0=A0=A0 81.90=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -68.9=A0=A0=A0=A0=A0=A0 13=
.02 =B1=A0 5%=A0 perf-profile.calltrace.cycles-pp.dcache_readdir.iterate_di=
r.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0 81.91=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -68.9=A0=A0=A0=A0=A0=A0 13=
.03 =B1=A0 5%=A0 perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_s=
yscall_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0 81.90=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -68.9=A0=A0=A0=A0=A0=A0 13=
.03 =B1=A0 5%=A0 perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_get=
dents64.do_syscall_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0 80.60=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -68.8=A0=A0=A0=A0=A0=A0 11=
.80 =B1=A0 5%=A0 perf-profile.calltrace.cycles-pp.scan_positives.dcache_rea=
ddir.iterate_dir.__x64_sys_getdents64.do_syscall_64=0A=
=A0=A0=A0=A0 80.30=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -68.7=A0=A0=A0=A0=A0=A0 11=
.63 =B1=A0 5%=A0 perf-profile.calltrace.cycles-pp._raw_spin_lock.scan_posit=
ives.dcache_readdir.iterate_dir.__x64_sys_getdents64=0A=
=A0=A0=A0=A0 85.88=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -51.1=A0=A0=A0=A0=A0=A0 34=
.79 =B1 13%=A0 perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL=
_64_after_hwframe=0A=
=A0=A0=A0=A0 85.98=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -50.8=A0=A0=A0=A0=A0=A0 35=
.15 =B1 13%=A0 perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwfr=
ame=0A=
=A0=A0=A0=A0=A0 0.37 =B1 70%=A0=A0=A0=A0=A0 +0.4=A0=A0=A0=A0=A0=A0=A0 0.80 =
=B1=A0 4%=A0 perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do=
_syscall_64.entry_SYSCALL_64_after_hwframe.creat64=0A=
=A0=A0=A0=A0=A0 0.37 =B1 70%=A0=A0=A0=A0=A0 +0.4=A0=A0=A0=A0=A0=A0=A0 0.81 =
=B1=A0 4%=A0 perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.ent=
ry_SYSCALL_64_after_hwframe.creat64=0A=
=A0=A0=A0=A0=A0 0.37 =B1 70%=A0=A0=A0=A0=A0 +0.4=A0=A0=A0=A0=A0=A0=A0 0.81 =
=B1=A0 4%=A0 perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_6=
4_after_hwframe.creat64=0A=
=A0=A0=A0=A0=A0 0.39 =B1 70%=A0=A0=A0=A0=A0 +0.4=A0=A0=A0=A0=A0=A0=A0 0.82 =
=B1=A0 3%=A0 perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwfram=
e.creat64=0A=
=A0=A0=A0=A0=A0 0.39 =B1 70%=A0=A0=A0=A0=A0 +0.4=A0=A0=A0=A0=A0=A0=A0 0.84 =
=B1=A0 3%=A0 perf-profile.calltrace.cycles-pp.creat64=0A=
=A0=A0=A0=A0=A0 0.37 =B1 70%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 0.93 =
=B1 10%=A0 perf-profile.calltrace.cycles-pp.div_long=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=
=A0=A0 0.62 =B1 10%=A0 perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu=
_do_batch.rcu_core.__softirqentry_text_start.asm_call_sysvec_on_stack=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=
=A0=A0 0.62 =B1 10%=A0 perf-profile.calltrace.cycles-pp.__strcat_chk=0A=
=A0=A0=A0=A0=A0 0.39 =B1 70%=A0=A0=A0=A0=A0 +0.7=A0=A0=A0=A0=A0=A0=A0 1.04 =
=B1=A0 9%=A0 perf-profile.calltrace.cycles-pp.add_int.add_int=0A=
=A0=A0=A0=A0=A0 0.38 =B1 70%=A0=A0=A0=A0=A0 +0.7=A0=A0=A0=A0=A0=A0=A0 1.04 =
=B1=A0 8%=A0 perf-profile.calltrace.cycles-pp.add_long.add_long=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.7=A0=A0=A0=A0=A0=
=A0=A0 0.68 =B1=A0 9%=A0 perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_=
core.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stac=
k=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.7=A0=A0=A0=A0=A0=
=A0=A0 0.69 =B1=A0 9%=A0 perf-profile.calltrace.cycles-pp.rcu_core.__softir=
qentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rc=
u=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.7=A0=A0=A0=A0=A0=
=A0=A0 0.73 =B1=A0 3%=A0 perf-profile.calltrace.cycles-pp.__handle_mm_fault=
.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.8=A0=A0=A0=A0=A0=
=A0=A0 0.76 =B1=A0 9%=A0 perf-profile.calltrace.cycles-pp.__softirqentry_te=
xt_start.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_=
apic_timer_interrupt=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.8=A0=A0=A0=A0=A0=
=A0=A0 0.76 =B1=A0 9%=A0 perf-profile.calltrace.cycles-pp.asm_call_sysvec_o=
n_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_s=
ysvec_apic_timer_interrupt=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.8=A0=A0=A0=A0=A0=
=A0=A0 0.76 =B1=A0 9%=A0 perf-profile.calltrace.cycles-pp.do_softirq_own_st=
ack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrup=
t.cpuidle_enter_state=0A=
=A0=A0=A0=A0=A0 0.36 =B1 70%=A0=A0=A0=A0=A0 +0.8=A0=A0=A0=A0=A0=A0=A0 1.12 =
=B1 11%=A0 perf-profile.calltrace.cycles-pp.__strncat_chk=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.8=A0=A0=A0=A0=A0=
=A0=A0 0.77 =B1=A0 3%=A0 perf-profile.calltrace.cycles-pp.handle_mm_fault.d=
o_user_addr_fault.exc_page_fault.asm_exc_page_fault=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.8=A0=A0=A0=A0=A0=
=A0=A0 0.77 =B1=A0 9%=A0 perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysv=
ec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state=
.cpuidle_enter=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.8=A0=A0=A0=A0=A0=
=A0=A0 0.79 =B1 23%=A0 perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down=
_write_slowpath.__vma_adjust.__split_vma.__do_munmap=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.8=A0=A0=A0=A0=A0=
=A0=A0 0.81 =B1 23%=A0 perf-profile.calltrace.cycles-pp.rwsem_down_write_sl=
owpath.__vma_adjust.__split_vma.__do_munmap.mmap_region=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.8=A0=A0=A0=A0=A0=
=A0=A0 0.81 =B1 22%=A0 perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down=
_write_slowpath.__vma_adjust.__split_vma.mprotect_fixup=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.8=A0=A0=A0=A0=A0=
=A0=A0 0.82 =B1=A0 3%=A0 perf-profile.calltrace.cycles-pp.walk_component.li=
nk_path_walk.path_openat.do_filp_open.do_sys_openat2=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.8=A0=A0=A0=A0=A0=
=A0=A0 0.84 =B1 21%=A0 perf-profile.calltrace.cycles-pp.rwsem_down_write_sl=
owpath.__vma_adjust.__split_vma.mprotect_fixup.do_mprotect_pkey=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.8=A0=A0=A0=A0=A0=
=A0=A0 0.85 =B1=A0 3%=A0 perf-profile.calltrace.cycles-pp.do_user_addr_faul=
t.exc_page_fault.asm_exc_page_fault=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.9=A0=A0=A0=A0=A0=
=A0=A0 0.85 =B1=A0 3%=A0 perf-profile.calltrace.cycles-pp.link_path_walk.pa=
th_openat.do_filp_open.do_sys_openat2.do_sys_open=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.9=A0=A0=A0=A0=A0=
=A0=A0 0.86 =B1=A0 3%=A0 perf-profile.calltrace.cycles-pp.exc_page_fault.as=
m_exc_page_fault=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.9=A0=A0=A0=A0=A0=
=A0=A0 0.86 =B1 22%=A0 perf-profile.calltrace.cycles-pp.__vma_adjust.__spli=
t_vma.__do_munmap.mmap_region.do_mmap=0A=
=A0=A0=A0=A0=A0 0.18 =B1141%=A0=A0=A0=A0=A0 +0.9=A0=A0=A0=A0=A0=A0=A0 1.04 =
=B1 24%=A0 perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowp=
ath.unlink_file_vma.free_pgtables.unmap_region=0A=
=A0=A0=A0=A0=A0 0.17 =B1141%=A0=A0=A0=A0=A0 +0.9=A0=A0=A0=A0=A0=A0=A0 1.03 =
=B1 22%=A0 perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowp=
ath.vma_link.mmap_region.do_mmap=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.9=A0=A0=A0=A0=A0=
=A0=A0 0.88 =B1 24%=A0 perf-profile.calltrace.cycles-pp.unlink_file_vma.fre=
e_pgtables.exit_mmap.mmput.begin_new_exec=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.9=A0=A0=A0=A0=A0=
=A0=A0 0.88 =B1 21%=A0 perf-profile.calltrace.cycles-pp.__split_vma.__do_mu=
nmap.mmap_region.do_mmap.vm_mmap_pgoff=0A=
=A0=A0=A0=A0=A0 0.18 =B1141%=A0=A0=A0=A0=A0 +0.9=A0=A0=A0=A0=A0=A0=A0 1.07 =
=B1 23%=A0 perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.unlin=
k_file_vma.free_pgtables.unmap_region.__do_munmap=0A=
=A0=A0=A0=A0=A0 0.17 =B1141%=A0=A0=A0=A0=A0 +0.9=A0=A0=A0=A0=A0=A0=A0 1.06 =
=B1 21%=A0 perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.vma_l=
ink.mmap_region.do_mmap.vm_mmap_pgoff=0A=
=A0=A0=A0=A0=A0 0.18 =B1141%=A0=A0=A0=A0=A0 +0.9=A0=A0=A0=A0=A0=A0=A0 1.08 =
=B1 23%=A0 perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.u=
nmap_region.__do_munmap.mmap_region=0A=
=A0=A0=A0=A0=A0 0.19 =B1141%=A0=A0=A0=A0=A0 +0.9=A0=A0=A0=A0=A0=A0=A0 1.09 =
=B1 23%=A0 perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.__do=
_munmap.mmap_region.do_mmap=0A=
=A0=A0=A0=A0=A0 0.19 =B1141%=A0=A0=A0=A0=A0 +0.9=A0=A0=A0=A0=A0=A0=A0 1.12 =
=B1 23%=A0 perf-profile.calltrace.cycles-pp.unmap_region.__do_munmap.mmap_r=
egion.do_mmap.vm_mmap_pgoff=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.9=A0=A0=A0=A0=A0=
=A0=A0 0.93 =B1=A0 4%=A0 perf-profile.calltrace.cycles-pp.asm_exc_page_faul=
t=0A=
=A0=A0=A0=A0=A0 0.17 =B1141%=A0=A0=A0=A0=A0 +0.9=A0=A0=A0=A0=A0=A0=A0 1.10 =
=B1 19%=A0 perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.mmput.b=
egin_new_exec.load_elf_binary=0A=
=A0=A0=A0=A0=A0 0.18 =B1141%=A0=A0=A0=A0=A0 +0.9=A0=A0=A0=A0=A0=A0=A0 1.12 =
=B1 20%=A0 perf-profile.calltrace.cycles-pp.vma_link.mmap_region.do_mmap.vm=
_mmap_pgoff.ksys_mmap_pgoff=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.9=A0=A0=A0=A0=A0=
=A0=A0 0.94 =B1 19%=A0 perf-profile.calltrace.cycles-pp.__vma_adjust.__spli=
t_vma.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.0=A0=A0=A0=A0=A0=
=A0=A0 0.98 =B1 18%=A0 perf-profile.calltrace.cycles-pp.__split_vma.mprotec=
t_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.0=A0=A0=A0=A0=A0=
=A0=A0 1.02 =B1 18%=A0 perf-profile.calltrace.cycles-pp.mprotect_fixup.do_m=
protect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwfram=
e=0A=
=A0=A0=A0=A0=A0 0.20 =B1141%=A0=A0=A0=A0=A0 +1.0=A0=A0=A0=A0=A0=A0=A0 1.22 =
=B1 24%=A0 perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.e=
xit_mmap.mmput.do_exit=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.0=A0=A0=A0=A0=A0=
=A0=A0 1.03 =B1 18%=A0 perf-profile.calltrace.cycles-pp.__x64_sys_mprotect.=
do_syscall_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.0=A0=A0=A0=A0=A0=
=A0=A0 1.03 =B1 18%=A0 perf-profile.calltrace.cycles-pp.do_mprotect_pkey.__=
x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 0.39 =B1 72%=A0=A0=A0=A0=A0 +1.1=A0=A0=A0=A0=A0=A0=A0 1.45 =
=B1 11%=A0 perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.en=
try_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 0.39 =B1 72%=A0=A0=A0=A0=A0 +1.1=A0=A0=A0=A0=A0=A0=A0 1.45 =
=B1 11%=A0 perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_=
syscall_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.1=A0=A0=A0=A0=A0=
=A0=A0 1.06 =B1 26%=A0 perf-profile.calltrace.cycles-pp._raw_spin_lock.lock=
ref_get.d_alloc_cursor.dcache_dir_open.do_dentry_open=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.1=A0=A0=A0=A0=A0=
=A0=A0 1.06 =B1 26%=A0 perf-profile.calltrace.cycles-pp.__cna_queued_spin_l=
ock_slowpath._raw_spin_lock.lockref_get.d_alloc_cursor.dcache_dir_open=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.1=A0=A0=A0=A0=A0=
=A0=A0 1.06 =B1 26%=A0 perf-profile.calltrace.cycles-pp.lockref_get.d_alloc=
_cursor.dcache_dir_open.do_dentry_open.path_openat=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.1=A0=A0=A0=A0=A0=
=A0=A0 1.06 =B1 26%=A0 perf-profile.calltrace.cycles-pp.dcache_dir_open.do_=
dentry_open.path_openat.do_filp_open.do_sys_openat2=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.1=A0=A0=A0=A0=A0=
=A0=A0 1.06 =B1 26%=A0 perf-profile.calltrace.cycles-pp.d_alloc_cursor.dcac=
he_dir_open.do_dentry_open.path_openat.do_filp_open=0A=
=A0=A0=A0=A0=A0 0.20 =B1141%=A0=A0=A0=A0=A0 +1.1=A0=A0=A0=A0=A0=A0=A0 1.27 =
=B1 14%=A0 perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.=
__libc_fork=0A=
=A0=A0=A0=A0=A0 0.20 =B1141%=A0=A0=A0=A0=A0 +1.1=A0=A0=A0=A0=A0=A0=A0 1.27 =
=B1 14%=A0 perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_=
after_hwframe.__libc_fork=0A=
=A0=A0=A0=A0=A0 0.20 =B1141%=A0=A0=A0=A0=A0 +1.1=A0=A0=A0=A0=A0=A0=A0 1.27 =
=B1 14%=A0 perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.en=
try_SYSCALL_64_after_hwframe.__libc_fork=0A=
=A0=A0=A0=A0=A0 0.19 =B1141%=A0=A0=A0=A0=A0 +1.1=A0=A0=A0=A0=A0=A0=A0 1.27 =
=B1 14%=A0 perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_=
syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork=0A=
=A0=A0=A0=A0=A0 0.21 =B1141%=A0=A0=A0=A0=A0 +1.1=A0=A0=A0=A0=A0=A0=A0 1.33 =
=B1 22%=A0 perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.mmput.d=
o_exit.do_group_exit=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.1=A0=A0=A0=A0=A0=
=A0=A0 1.12 =B1 11%=A0 perf-profile.calltrace.cycles-pp.__cna_queued_spin_l=
ock_slowpath._raw_spin_lock.dcache_readdir.iterate_dir.__x64_sys_getdents64=
=0A=
=A0=A0=A0=A0=A0 0.60 =B1=A0 6%=A0=A0=A0=A0=A0 +1.1=A0=A0=A0=A0=A0=A0=A0 1.7=
3 =B1 24%=A0 perf-profile.calltrace.cycles-pp.exit_mmap.mmput.begin_new_exe=
c.load_elf_binary.exec_binprm=0A=
=A0=A0=A0=A0=A0 0.20 =B1141%=A0=A0=A0=A0=A0 +1.1=A0=A0=A0=A0=A0=A0=A0 1.33 =
=B1 13%=A0 perf-profile.calltrace.cycles-pp.__libc_fork=0A=
=A0=A0=A0=A0=A0 0.60 =B1=A0 6%=A0=A0=A0=A0=A0 +1.1=A0=A0=A0=A0=A0=A0=A0 1.7=
3 =B1 24%=A0 perf-profile.calltrace.cycles-pp.mmput.begin_new_exec.load_elf=
_binary.exec_binprm.bprm_execve=0A=
=A0=A0=A0=A0=A0 0.17 =B1141%=A0=A0=A0=A0=A0 +1.1=A0=A0=A0=A0=A0=A0=A0 1.32 =
=B1 16%=A0 perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt=
.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.1=A0=A0=A0=A0=A0=
=A0=A0 1.15 =B1 18%=A0 perf-profile.calltrace.cycles-pp.drain_obj_stock.ref=
ill_obj_stock.kmem_cache_free.rcu_do_batch.rcu_core=0A=
=A0=A0=A0=A0=A0 0.62 =B1=A0 6%=A0=A0=A0=A0=A0 +1.2=A0=A0=A0=A0=A0=A0=A0 1.7=
8 =B1 23%=A0 perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binar=
y.exec_binprm.bprm_execve.do_execveat_common=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.2=A0=A0=A0=A0=A0=
=A0=A0 1.18 =B1 21%=A0 perf-profile.calltrace.cycles-pp.sysvec_apic_timer_i=
nterrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.=
do_idle=0A=
=A0=A0=A0=A0=A0 0.80 =B1 20%=A0=A0=A0=A0=A0 +1.2=A0=A0=A0=A0=A0=A0=A0 2.03 =
=B1 22%=A0 perf-profile.calltrace.cycles-pp.__do_munmap.mmap_region.do_mmap=
.vm_mmap_pgoff.ksys_mmap_pgoff=0A=
=A0=A0=A0=A0=A0 0.73 =B1 17%=A0=A0=A0=A0=A0 +1.2=A0=A0=A0=A0=A0=A0=A0 1.98 =
=B1 14%=A0 perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.do_grou=
p_exit.__x64_sys_exit_group=0A=
=A0=A0=A0=A0=A0 0.73 =B1 17%=A0=A0=A0=A0=A0 +1.2=A0=A0=A0=A0=A0=A0=A0 1.98 =
=B1 14%=A0 perf-profile.calltrace.cycles-pp.mmput.do_exit.do_group_exit.__x=
64_sys_exit_group.do_syscall_64=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.3=A0=A0=A0=A0=A0=
=A0=A0 1.28 =B1 18%=A0 perf-profile.calltrace.cycles-pp._raw_spin_lock.lock=
ref_get.do_dentry_open.path_openat.do_filp_open=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.3=A0=A0=A0=A0=A0=
=A0=A0 1.28 =B1 18%=A0 perf-profile.calltrace.cycles-pp.__cna_queued_spin_l=
ock_slowpath._raw_spin_lock.lockref_get.do_dentry_open.path_openat=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.3=A0=A0=A0=A0=A0=
=A0=A0 1.29 =B1 18%=A0 perf-profile.calltrace.cycles-pp.lockref_get.do_dent=
ry_open.path_openat.do_filp_open.do_sys_openat2=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.4=A0=A0=A0=A0=A0=
=A0=A0 1.36 =B1 39%=A0 perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down=
_write_slowpath.dup_mmap.dup_mm.copy_process=0A=
=A0=A0=A0=A0=A0 0.81 =B1 16%=A0=A0=A0=A0=A0 +1.4=A0=A0=A0=A0=A0=A0=A0 2.20 =
=B1 13%=A0 perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys=
_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 0.81 =B1 16%=A0=A0=A0=A0=A0 +1.4=A0=A0=A0=A0=A0=A0=A0 2.21 =
=B1 13%=A0 perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall=
_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 0.81 =B1 16%=A0=A0=A0=A0=A0 +1.4=A0=A0=A0=A0=A0=A0=A0 2.21 =
=B1 13%=A0 perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_gr=
oup.do_syscall_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.4=A0=A0=A0=A0=A0=
=A0=A0 1.41 =B1 38%=A0 perf-profile.calltrace.cycles-pp.rwsem_down_write_sl=
owpath.dup_mmap.dup_mm.copy_process.kernel_clone=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.4=A0=A0=A0=A0=A0=
=A0=A0 1.41 =B1 17%=A0 perf-profile.calltrace.cycles-pp.refill_obj_stock.km=
em_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_start=0A=
=A0=A0=A0=A0=A0 0.18 =B1141%=A0=A0=A0=A0=A0 +1.7=A0=A0=A0=A0=A0=A0=A0 1.92 =
=B1 26%=A0 perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowp=
ath.unlink_file_vma.free_pgtables.exit_mmap=0A=
=A0=A0=A0=A0=A0 0.19 =B1141%=A0=A0=A0=A0=A0 +1.8=A0=A0=A0=A0=A0=A0=A0 2.01 =
=B1 25%=A0 perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.unlin=
k_file_vma.free_pgtables.exit_mmap.mmput=0A=
=A0=A0=A0=A0=A0 0.83 =B1=A0 5%=A0=A0=A0=A0=A0 +1.8=A0=A0=A0=A0=A0=A0=A0 2.6=
5 =B1 14%=A0 perf-profile.calltrace.cycles-pp.load_elf_binary.exec_binprm.b=
prm_execve.do_execveat_common.__x64_sys_execve=0A=
=A0=A0=A0=A0=A0 0.83 =B1=A0 4%=A0=A0=A0=A0=A0 +1.8=A0=A0=A0=A0=A0=A0=A0 2.6=
7 =B1 13%=A0 perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_ex=
ecveat_common.__x64_sys_execve.do_syscall_64=0A=
=A0=A0=A0=A0=A0 0.36 =B1141%=A0=A0=A0=A0=A0 +2.0=A0=A0=A0=A0=A0=A0=A0 2.32 =
=B1 15%=A0 perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clon=
e.__do_sys_clone.do_syscall_64=0A=
=A0=A0=A0=A0=A0 1.24 =B1 20%=A0=A0=A0=A0=A0 +2.0=A0=A0=A0=A0=A0=A0=A0 3.23 =
=B1 21%=A0 perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgo=
ff.ksys_mmap_pgoff.do_syscall_64=0A=
=A0=A0=A0=A0=A0 1.25 =B1 20%=A0=A0=A0=A0=A0 +2.0=A0=A0=A0=A0=A0=A0=A0 3.23 =
=B1 21%=A0 perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap=
_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 1.26 =B1 20%=A0=A0=A0=A0=A0 +2.0=A0=A0=A0=A0=A0=A0=A0 3.25 =
=B1 21%=A0 perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.e=
ntry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 1.26 =B1 20%=A0=A0=A0=A0=A0 +2.0=A0=A0=A0=A0=A0=A0=A0 3.25 =
=B1 21%=A0 perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.d=
o_syscall_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 1.68 =B1 14%=A0=A0=A0=A0=A0 +2.0=A0=A0=A0=A0=A0=A0=A0 3.72 =
=B1 10%=A0 perf-profile.calltrace.cycles-pp.string_rtns_1=0A=
=A0=A0=A0=A0=A0 0.19 =B1141%=A0=A0=A0=A0=A0 +2.1=A0=A0=A0=A0=A0=A0=A0 2.29 =
=B1 15%=A0 perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.ke=
rnel_clone.__do_sys_clone=0A=
=A0=A0=A0=A0=A0 0.39 =B1141%=A0=A0=A0=A0=A0 +2.2=A0=A0=A0=A0=A0=A0=A0 2.58 =
=B1 13%=A0 perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_=
sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +2.6=A0=A0=A0=A0=A0=
=A0=A0 2.62 =B1=A0 6%=A0 perf-profile.calltrace.cycles-pp.do_dentry_open.pa=
th_openat.do_filp_open.do_sys_openat2.do_sys_open=0A=
=A0=A0=A0=A0=A0 0.40 =B1 70%=A0=A0=A0=A0=A0 +3.1=A0=A0=A0=A0=A0=A0=A0 3.52 =
=B1 15%=A0 perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rc=
u_core.__softirqentry_text_start.run_ksoftirqd=0A=
=A0=A0=A0=A0=A0 0.61 =B1 11%=A0=A0=A0=A0=A0 +3.2=A0=A0=A0=A0=A0=A0=A0 3.79 =
=B1 15%=A0 perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__softirq=
entry_text_start.run_ksoftirqd.smpboot_thread_fn=0A=
=A0=A0=A0=A0=A0 0.61 =B1 11%=A0=A0=A0=A0=A0 +3.2=A0=A0=A0=A0=A0=A0=A0 3.79 =
=B1 15%=A0 perf-profile.calltrace.cycles-pp.rcu_core.__softirqentry_text_st=
art.run_ksoftirqd.smpboot_thread_fn.kthread=0A=
=A0=A0=A0=A0=A0 0.61 =B1 11%=A0=A0=A0=A0=A0 +3.2=A0=A0=A0=A0=A0=A0=A0 3.79 =
=B1 15%=A0 perf-profile.calltrace.cycles-pp.__softirqentry_text_start.run_k=
softirqd.smpboot_thread_fn.kthread.ret_from_fork=0A=
=A0=A0=A0=A0=A0 0.61 =B1 11%=A0=A0=A0=A0=A0 +3.2=A0=A0=A0=A0=A0=A0=A0 3.79 =
=B1 15%=A0 perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn=
.kthread.ret_from_fork=0A=
=A0=A0=A0=A0=A0 0.61 =B1 12%=A0=A0=A0=A0=A0 +3.2=A0=A0=A0=A0=A0=A0=A0 3.82 =
=B1 15%=A0 perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_f=
rom_fork=0A=
=A0=A0=A0=A0=A0 0.65 =B1 11%=A0=A0=A0=A0=A0 +3.2=A0=A0=A0=A0=A0=A0=A0 3.88 =
=B1 15%=A0 perf-profile.calltrace.cycles-pp.kthread.ret_from_fork=0A=
=A0=A0=A0=A0=A0 0.65 =B1 11%=A0=A0=A0=A0=A0 +3.2=A0=A0=A0=A0=A0=A0=A0 3.89 =
=B1 15%=A0 perf-profile.calltrace.cycles-pp.ret_from_fork=0A=
=A0=A0=A0=A0=A0 0.22 =B1141%=A0=A0=A0=A0=A0 +4.1=A0=A0=A0=A0=A0=A0=A0 4.27 =
=B1 28%=A0 perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_s=
yscall_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 0.22 =B1141%=A0=A0=A0=A0=A0 +4.1=A0=A0=A0=A0=A0=A0=A0 4.28 =
=B1 28%=A0 perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry=
_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 3.30 =B1 10%=A0=A0=A0=A0=A0 +6.1=A0=A0=A0=A0=A0=A0=A0 9.36 =
=B1 10%=A0 perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.=
cpuidle_enter.do_idle.cpu_startup_entry=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +6.2=A0=A0=A0=A0=A0=
=A0=A0 6.21 =B1=A0 3%=A0 perf-profile.calltrace.cycles-pp._raw_spin_lock.lo=
ckref_get_not_dead.__legitimize_path.unlazy_walk.complete_walk=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +6.2=A0=A0=A0=A0=A0=
=A0=A0 6.22 =B1=A0 3%=A0 perf-profile.calltrace.cycles-pp.lockref_get_not_d=
ead.__legitimize_path.unlazy_walk.complete_walk.path_openat=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +6.2=A0=A0=A0=A0=A0=
=A0=A0 6.22 =B1=A0 3%=A0 perf-profile.calltrace.cycles-pp.unlazy_walk.compl=
ete_walk.path_openat.do_filp_open.do_sys_openat2=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +6.2=A0=A0=A0=A0=A0=
=A0=A0 6.22 =B1=A0 3%=A0 perf-profile.calltrace.cycles-pp.__legitimize_path=
.unlazy_walk.complete_walk.path_openat.do_filp_open=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +6.2=A0=A0=A0=A0=A0=
=A0=A0 6.22 =B1=A0 3%=A0 perf-profile.calltrace.cycles-pp.complete_walk.pat=
h_openat.do_filp_open.do_sys_openat2.do_sys_open=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +6.5=A0=A0=A0=A0=A0=
=A0=A0 6.47 =B1=A0 7%=A0 perf-profile.calltrace.cycles-pp._raw_spin_lock.lo=
ckref_put_or_lock.dput.step_into.path_openat=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +6.5=A0=A0=A0=A0=A0=
=A0=A0 6.47 =B1=A0 7%=A0 perf-profile.calltrace.cycles-pp.__cna_queued_spin=
_lock_slowpath._raw_spin_lock.lockref_put_or_lock.dput.step_into=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +6.5=A0=A0=A0=A0=A0=
=A0=A0 6.47 =B1=A0 7%=A0 perf-profile.calltrace.cycles-pp.dput.step_into.pa=
th_openat.do_filp_open.do_open_execat=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +6.5=A0=A0=A0=A0=A0=
=A0=A0 6.47 =B1=A0 7%=A0 perf-profile.calltrace.cycles-pp.lockref_put_or_lo=
ck.dput.step_into.path_openat.do_filp_open=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +7.0=A0=A0=A0=A0=A0=
=A0=A0 6.99 =B1 19%=A0 perf-profile.calltrace.cycles-pp.do_sys_open.do_sysc=
all_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +7.0=A0=A0=A0=A0=A0=
=A0=A0 6.99 =B1 19%=A0 perf-profile.calltrace.cycles-pp.do_sys_openat2.do_s=
ys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +7.0=A0=A0=A0=A0=A0=
=A0=A0 6.99 =B1 18%=A0 perf-profile.calltrace.cycles-pp.do_syscall_64.entry=
_SYSCALL_64_after_hwframe.__open64_nocancel=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +7.0=A0=A0=A0=A0=A0=
=A0=A0 7.00 =B1 18%=A0 perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_af=
ter_hwframe.__open64_nocancel=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +7.0=A0=A0=A0=A0=A0=
=A0=A0 7.00 =B1 18%=A0 perf-profile.calltrace.cycles-pp.__open64_nocancel=
=0A=
=A0=A0=A0=A0=A0 3.79 =B1 10%=A0=A0=A0=A0=A0 +7.0=A0=A0=A0=A0=A0=A0 10.82 =
=B1=A0 8%=A0 perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_e=
nter.do_idle.cpu_startup_entry.start_secondary=0A=
=A0=A0=A0=A0=A0 3.86 =B1=A0 9%=A0=A0=A0=A0=A0 +7.1=A0=A0=A0=A0=A0=A0 10.96 =
=B1=A0 8%=A0 perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_sta=
rtup_entry.start_secondary.secondary_startup_64_no_verify=0A=
=A0=A0=A0=A0=A0 4.17 =B1=A0 6%=A0=A0=A0=A0=A0 +7.4=A0=A0=A0=A0=A0=A0 11.59 =
=B1=A0 8%=A0 perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.sta=
rt_secondary.secondary_startup_64_no_verify=0A=
=A0=A0=A0=A0=A0 4.17 =B1=A0 6%=A0=A0=A0=A0=A0 +7.4=A0=A0=A0=A0=A0=A0 11.59 =
=B1=A0 8%=A0 perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secon=
dary.secondary_startup_64_no_verify=0A=
=A0=A0=A0=A0=A0 4.17 =B1=A0 6%=A0=A0=A0=A0=A0 +7.4=A0=A0=A0=A0=A0=A0 11.59 =
=B1=A0 8%=A0 perf-profile.calltrace.cycles-pp.start_secondary.secondary_sta=
rtup_64_no_verify=0A=
=A0=A0=A0=A0=A0 4.20 =B1=A0 6%=A0=A0=A0=A0=A0 +7.4=A0=A0=A0=A0=A0=A0 11.63 =
=B1=A0 8%=A0 perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verif=
y=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +8.6=A0=A0=A0=A0=A0=
=A0=A0 8.58 =B1 38%=A0 perf-profile.calltrace.cycles-pp.do_execveat_common.=
__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +8.6=A0=A0=A0=A0=A0=
=A0=A0 8.59 =B1 38%=A0 perf-profile.calltrace.cycles-pp.__x64_sys_execve.do=
_syscall_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +11.2=A0=A0=A0=A0=A0=A0 =
11.23 =B1=A0 5%=A0 perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_=
slowpath._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir=0A=
=A0=A0=A0=A0=A0 0.56 =B1=A0 7%=A0=A0=A0=A0 +11.4=A0=A0=A0=A0=A0=A0 11.95 =
=B1=A0 2%=A0 perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_s=
ys_openat2.do_sys_open.do_syscall_64=0A=
=A0=A0=A0=A0=A0 0.56 =B1=A0 7%=A0=A0=A0=A0 +11.4=A0=A0=A0=A0=A0=A0 11.96 =
=B1=A0 2%=A0 perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.d=
o_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +24.2=A0=A0=A0=A0=A0=A0 =
24.23 =B1=A0 4%=A0 perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_=
get_not_dead.__legitimize_path.unlazy_walk.pick_link=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +24.2=A0=A0=A0=A0=A0=A0 =
24.25 =B1=A0 4%=A0 perf-profile.calltrace.cycles-pp.unlazy_walk.pick_link.s=
tep_into.path_openat.do_filp_open=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +24.2=A0=A0=A0=A0=A0=A0 =
24.25 =B1=A0 4%=A0 perf-profile.calltrace.cycles-pp.__legitimize_path.unlaz=
y_walk.pick_link.step_into.path_openat=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +24.2=A0=A0=A0=A0=A0=A0 =
24.25 =B1=A0 4%=A0 perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__=
legitimize_path.unlazy_walk.pick_link.step_into=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +24.2=A0=A0=A0=A0=A0=A0 =
24.25 =B1=A0 4%=A0 perf-profile.calltrace.cycles-pp.pick_link.step_into.pat=
h_openat.do_filp_open.do_open_execat=0A=
=A0=A0=A0=A0=A0 1.02 =B1=A0 4%=A0=A0=A0=A0 +24.4=A0=A0=A0=A0=A0=A0 25.41 =
=B1=A0 8%=A0 perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_=
execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve=0A=
=A0=A0=A0=A0=A0 1.02 =B1=A0 4%=A0=A0=A0=A0 +24.4=A0=A0=A0=A0=A0=A0 25.42 =
=B1=A0 8%=A0 perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwfram=
e.execve=0A=
=A0=A0=A0=A0=A0 1.02 =B1=A0 4%=A0=A0=A0=A0 +24.4=A0=A0=A0=A0=A0=A0 25.42 =
=B1=A0 8%=A0 perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_6=
4_after_hwframe.execve=0A=
=A0=A0=A0=A0=A0 1.02 =B1=A0 4%=A0=A0=A0=A0 +24.4=A0=A0=A0=A0=A0=A0 25.42 =
=B1=A0 8%=A0 perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_6=
4.entry_SYSCALL_64_after_hwframe.execve=0A=
=A0=A0=A0=A0=A0 1.03 =B1=A0 4%=A0=A0=A0=A0 +24.4=A0=A0=A0=A0=A0=A0 25.43 =
=B1=A0 8%=A0 perf-profile.calltrace.cycles-pp.execve=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +30.4=A0=A0=A0=A0=A0=A0 =
30.45 =B1=A0 3%=A0 perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_=
slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.unlazy_walk=
=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +30.8=A0=A0=A0=A0=A0=A0 =
30.82 =B1=A0 3%=A0 perf-profile.calltrace.cycles-pp.step_into.path_openat.d=
o_filp_open.do_open_execat.bprm_execve=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +30.8=A0=A0=A0=A0=A0=A0 =
30.84 =B1=A0 3%=A0 perf-profile.calltrace.cycles-pp.do_filp_open.do_open_ex=
ecat.bprm_execve.do_execveat_common.__x64_sys_execve=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +30.8=A0=A0=A0=A0=A0=A0 =
30.84 =B1=A0 3%=A0 perf-profile.calltrace.cycles-pp.path_openat.do_filp_ope=
n.do_open_execat.bprm_execve.do_execveat_common=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +30.8=A0=A0=A0=A0=A0=A0 =
30.84 =B1=A0 3%=A0 perf-profile.calltrace.cycles-pp.do_open_execat.bprm_exe=
cve.do_execveat_common.__x64_sys_execve.do_syscall_64=0A=
=A0=A0=A0=A0=A0 0.95 =B1=A0 4%=A0=A0=A0=A0 +32.8=A0=A0=A0=A0=A0=A0 33.76 =
=B1=A0 3%=A0 perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_commo=
n.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe=0A=
=A0=A0=A0=A0 82.33=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -82.3=A0=A0=A0=A0=A0=A0=A0=
 0.00=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.native_queued_sp=
in_lock_slowpath=0A=
=A0=A0=A0=A0 81.90=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -68.9=A0=A0=A0=A0=A0=A0 13=
.02 =B1=A0 5%=A0 perf-profile.children.cycles-pp.dcache_readdir=0A=
=A0=A0=A0=A0 81.91=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -68.9=A0=A0=A0=A0=A0=A0 13=
.03 =B1=A0 5%=A0 perf-profile.children.cycles-pp.__x64_sys_getdents64=0A=
=A0=A0=A0=A0 81.90=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -68.9=A0=A0=A0=A0=A0=A0 13=
.03 =B1=A0 5%=A0 perf-profile.children.cycles-pp.iterate_dir=0A=
=A0=A0=A0=A0 80.60=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -68.8=A0=A0=A0=A0=A0=A0 11=
.80 =B1=A0 5%=A0 perf-profile.children.cycles-pp.scan_positives=0A=
=A0=A0=A0=A0 82.71=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -27.9=A0=A0=A0=A0=A0=A0 54=
.83 =B1=A0 2%=A0 perf-profile.children.cycles-pp._raw_spin_lock=0A=
=A0=A0=A0=A0 89.05=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -18.0=A0=A0=A0=A0=A0=A0 71=
.08=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.do_syscall_64=0A=
=A0=A0=A0=A0 89.35=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -17.5=A0=A0=A0=A0=A0=A0 71=
.82=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.entry_SYSCALL_64_a=
fter_hwframe=0A=
=A0=A0=A0=A0=A0 0.54 =B1 22%=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=A0=A0 0.32 =
=B1 20%=A0 perf-profile.children.cycles-pp.llseek=0A=
=A0=A0=A0=A0=A0 0.62=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=
=A0=A0 0.45 =B1=A0 9%=A0 perf-profile.children.cycles-pp.ksys_lseek=0A=
=A0=A0=A0=A0=A0 0.62=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -0.2=A0=A0=A0=A0=A0=
=A0=A0 0.45 =B1=A0 9%=A0 perf-profile.children.cycles-pp.dcache_dir_lseek=
=0A=
=A0=A0=A0=A0=A0 0.06 =B1=A0 8%=A0=A0=A0=A0=A0 +0.0=A0=A0=A0=A0=A0=A0=A0 0.0=
9 =B1 21%=A0 perf-profile.children.cycles-pp.ktime_get_update_offsets_now=
=0A=
=A0=A0=A0=A0=A0 0.06 =B1 13%=A0=A0=A0=A0=A0 +0.0=A0=A0=A0=A0=A0=A0=A0 0.10 =
=B1 15%=A0 perf-profile.children.cycles-pp.update_load_avg=0A=
=A0=A0=A0=A0=A0 0.16 =B1=A0 8%=A0=A0=A0=A0=A0 +0.0=A0=A0=A0=A0=A0=A0=A0 0.2=
1 =B1 17%=A0 perf-profile.children.cycles-pp.ktime_get=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.copy_page=
=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.copy_strin=
g_kernel=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.time=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.__x64_sys_=
rt_sigreturn=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.perf_itera=
te_sb=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp._raw_spin_=
trylock=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.irqtime_ac=
count_irq=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.unlock_pag=
e=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05 =B1=A0 8%=A0 perf-profile.children.cycles-pp.common_file_perm=
=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05 =B1=A0 8%=A0 perf-profile.children.cycles-pp.shift_arg_pages=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05 =B1=A0 8%=A0 perf-profile.children.cycles-pp.__list_del_entry_v=
alid=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05 =B1=A0 8%=A0 perf-profile.children.cycles-pp.__check_object_siz=
e=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05 =B1=A0 8%=A0 perf-profile.children.cycles-pp.compar1=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05 =B1=A0 8%=A0 perf-profile.children.cycles-pp.lru_add_drain_cpu=
=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05 =B1=A0 8%=A0 perf-profile.children.cycles-pp.do_faccessat=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05 =B1=A0 8%=A0 perf-profile.children.cycles-pp.call_rcu=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05 =B1=A0 8%=A0 perf-profile.children.cycles-pp.rebalance_domains=
=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05 =B1=A0 9%=A0 perf-profile.children.cycles-pp.__pud_alloc=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05 =B1=A0 9%=A0 perf-profile.children.cycles-pp.do_task_dead=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06 =B1=A0 9%=A0 perf-profile.children.cycles-pp.new_sync_read=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06 =B1=A0 9%=A0 perf-profile.children.cycles-pp.ip_finish_output2=
=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06 =B1=A0 9%=A0 perf-profile.children.cycles-pp.sync_regs=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06 =B1=A0 9%=A0 perf-profile.children.cycles-pp.d_add=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06 =B1=A0 9%=A0 perf-profile.children.cycles-pp.lru_add_drain=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06 =B1=A0 7%=A0 perf-profile.children.cycles-pp._cond_resched=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06 =B1=A0 7%=A0 perf-profile.children.cycles-pp.cfree=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06 =B1=A0 7%=A0 perf-profile.children.cycles-pp.update_rq_clock=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06 =B1=A0 7%=A0 perf-profile.children.cycles-pp.pagevec_lru_move_f=
n=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06 =B1=A0 7%=A0 perf-profile.children.cycles-pp.__rb_insert_augmen=
ted=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06 =B1=A0 7%=A0 perf-profile.children.cycles-pp.kfree=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06 =B1=A0 7%=A0 perf-profile.children.cycles-pp.security_cred_free=
=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06 =B1 14%=A0 perf-profile.children.cycles-pp.worker_thread=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06 =B1 11%=A0 perf-profile.children.cycles-pp.read=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.anon_vma_i=
nterval_tree_insert=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.__might_sl=
eep=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.simple_loo=
kup=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.create_elf=
_tables=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.setup_arg_=
pages=0A=
=A0=A0=A0=A0=A0 0.02 =B1141%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.08 =
=B1 54%=A0 perf-profile.children.cycles-pp.irq_enter_rcu=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06 =B1=A0 6%=A0 perf-profile.children.cycles-pp.alloc_pages_vma=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06 =B1=A0 6%=A0 perf-profile.children.cycles-pp.page_add_file_rmap=
=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06 =B1 17%=A0 perf-profile.children.cycles-pp.memcpy_erms=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1 17%=A0 perf-profile.children.cycles-pp.do_linkat=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1 17%=A0 perf-profile.children.cycles-pp.__x64_sys_link=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1=A0 7%=A0 perf-profile.children.cycles-pp.inode_permission=
=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1=A0 7%=A0 perf-profile.children.cycles-pp.ip_output=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1 23%=A0 perf-profile.children.cycles-pp.tick_nohz_next_event=
=0A=
=A0=A0=A0=A0=A0 0.05 =B1 70%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.12 =
=B1 10%=A0 perf-profile.children.cycles-pp.__close=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1 12%=A0 perf-profile.children.cycles-pp.try_charge=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1=A0 6%=A0 perf-profile.children.cycles-pp.do_truncate=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1 12%=A0 perf-profile.children.cycles-pp.udp_sendmsg=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1 12%=A0 perf-profile.children.cycles-pp.put_task_stack=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1 12%=A0 perf-profile.children.cycles-pp.free_pages_and_swap_=
cache=0A=
=A0=A0=A0=A0=A0 0.02 =B1141%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.08 =
=B1=A0 5%=A0 perf-profile.children.cycles-pp.unlink=0A=
=A0=A0=A0=A0=A0 0.07 =B1 12%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.14 =
=B1 15%=A0 perf-profile.children.cycles-pp.write=0A=
=A0=A0=A0=A0=A0 0.06=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.13=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.wake_up_ne=
w_task=0A=
=A0=A0=A0=A0=A0 0.06 =B1 13%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.13 =
=B1=A0 5%=A0 perf-profile.children.cycles-pp.__d_lookup_rcu=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1 10%=A0 perf-profile.children.cycles-pp.uncharge_batch=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.group_send=
_sig_info=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.__get_user=
_pages=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.strnlen_us=
er=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.security_t=
ask_kill=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.apparmor_t=
ask_kill=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1 10%=A0 perf-profile.children.cycles-pp.__pmd_alloc=0A=
=A0=A0=A0=A0=A0 0.05 =B1=A0 8%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.1=
2 =B1=A0 4%=A0 perf-profile.children.cycles-pp.apparmor_file_open=0A=
=A0=A0=A0=A0=A0 0.09 =B1 24%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.16 =
=B1=A0 6%=A0 perf-profile.children.cycles-pp.kill=0A=
=A0=A0=A0=A0=A0 0.05=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.12 =B1=A0 3%=A0 perf-profile.children.cycles-pp.security_file_free=
=0A=
=A0=A0=A0=A0=A0 0.05=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.12 =B1=A0 3%=A0 perf-profile.children.cycles-pp.apparmor_file_free=
_security=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1=A0 5%=A0 perf-profile.children.cycles-pp.__anon_vma_prepare=
=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1=A0 5%=A0 perf-profile.children.cycles-pp.find_vma=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1=A0 5%=A0 perf-profile.children.cycles-pp.get_arg_page=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1=A0 5%=A0 perf-profile.children.cycles-pp.__get_user_pages_r=
emote=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1=A0 5%=A0 perf-profile.children.cycles-pp.mem_cgroup_charge=
=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1=A0 5%=A0 perf-profile.children.cycles-pp.try_to_wake_up=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1=A0 5%=A0 perf-profile.children.cycles-pp.rcu_sched_clock_ir=
q=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1 22%=A0 perf-profile.children.cycles-pp.file_free_rcu=0A=
=A0=A0=A0=A0=A0 0.05 =B1=A0 8%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.1=
3 =B1=A0 6%=A0 perf-profile.children.cycles-pp.security_file_open=0A=
=A0=A0=A0=A0=A0 0.05 =B1=A0 8%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.1=
3 =B1=A0 3%=A0 perf-profile.children.cycles-pp.getname_flags=0A=
=A0=A0=A0=A0=A0 0.03 =B1 70%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.11 =
=B1=A0 4%=A0 perf-profile.children.cycles-pp.kill_pid_info=0A=
=A0=A0=A0=A0=A0 0.07=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.15 =B1=A0 3%=A0 perf-profile.children.cycles-pp.native_irq_return_=
iret=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.08 =B1=A0 6%=A0 perf-profile.children.cycles-pp.vfs_read=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.08 =B1=A0 6%=A0 perf-profile.children.cycles-pp.__mod_memcg_state=
=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.08 =B1=A0 6%=A0 perf-profile.children.cycles-pp.mem_cgroup_uncharg=
e_list=0A=
=A0=A0=A0=A0=A0 0.03 =B1 70%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.11=
=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.kill_something_info=
=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.08 =B1=A0 5%=A0 perf-profile.children.cycles-pp.ksys_read=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.08 =B1 10%=A0 perf-profile.children.cycles-pp.rcu_cblist_dequeue=
=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.08 =B1=A0 8%=A0 perf-profile.children.cycles-pp.vma_interval_tree_=
remove=0A=
=A0=A0=A0=A0=A0 0.04 =B1 71%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.12 =
=B1=A0 3%=A0 perf-profile.children.cycles-pp.__x64_sys_kill=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.08 =B1 10%=A0 perf-profile.children.cycles-pp.filldir64=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.08 =B1 10%=A0 perf-profile.children.cycles-pp.put_cred_rcu=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.08 =B1 26%=A0 perf-profile.children.cycles-pp.tick_nohz_get_sleep_=
length=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.08 =B1 13%=A0 perf-profile.children.cycles-pp.__slab_free=0A=
=A0=A0=A0=A0=A0 0.02 =B1141%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.10=
=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.up_write=0A=
=A0=A0=A0=A0=A0 0.05 =B1=A0 8%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.1=
4 =B1=A0 3%=A0 perf-profile.children.cycles-pp.copy_pte_range=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.08 =B1=A0 5%=A0 perf-profile.children.cycles-pp.clear_page_erms=0A=
=A0=A0=A0=A0=A0 0.06 =B1=A0 8%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.1=
4 =B1=A0 5%=A0 perf-profile.children.cycles-pp.down_write=0A=
=A0=A0=A0=A0=A0 0.02 =B1141%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.10 =
=B1 10%=A0 perf-profile.children.cycles-pp.malloc=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.09 =B1=A0 4%=A0 perf-profile.children.cycles-pp.wait4=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.09 =B1=A0 4%=A0 perf-profile.children.cycles-pp.down_read=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.09 =B1=A0 4%=A0 perf-profile.children.cycles-pp.__get_free_pages=
=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.09 =B1=A0 4%=A0 perf-profile.children.cycles-pp.__put_anon_vma=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.09 =B1=A0 4%=A0 perf-profile.children.cycles-pp.arch_do_signal=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.09 =B1=A0 4%=A0 perf-profile.children.cycles-pp.__dentry_kill=0A=
=A0=A0=A0=A0=A0 0.02 =B1141%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.11 =
=B1=A0 4%=A0 perf-profile.children.cycles-pp._raw_spin_lock_irqsave=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.09=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.strncpy_fr=
om_user=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.09 =B1=A0 7%=A0 perf-profile.children.cycles-pp.aa_get_task_label=
=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.09 =B1=A0 7%=A0 perf-profile.children.cycles-pp.schedule_idle=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.09 =B1 17%=A0 perf-profile.children.cycles-pp.rwsem_wake=0A=
=A0=A0=A0=A0=A0 0.02 =B1141%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.11 =
=B1=A0 4%=A0 perf-profile.children.cycles-pp.___might_sleep=0A=
=A0=A0=A0=A0=A0 0.03 =B1 70%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.12 =
=B1=A0 4%=A0 perf-profile.children.cycles-pp.copy_strings=0A=
=A0=A0=A0=A0=A0 0.09 =B1 13%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.19 =
=B1 14%=A0 perf-profile.children.cycles-pp.update_cfs_group=0A=
=A0=A0=A0=A0=A0 0.08 =B1 10%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.17 =
=B1 11%=A0 perf-profile.children.cycles-pp.new_sync_write=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.09 =B1=A0 4%=A0 perf-profile.children.cycles-pp.sched_exec=0A=
=A0=A0=A0=A0=A0 0.02 =B1141%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.11=
=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.alloc_set_pte=0A=
=A0=A0=A0=A0=A0 0.05 =B1=A0 8%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.1=
5 =B1=A0 2%=A0 perf-profile.children.cycles-pp.get_page_from_freelist=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.10 =B1=A0 5%=A0 perf-profile.children.cycles-pp.prep_new_page=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.10 =B1=A0 9%=A0 perf-profile.children.cycles-pp.__pte_alloc=0A=
=A0=A0=A0=A0=A0 0.04 =B1 71%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.13 =
=B1=A0 6%=A0 perf-profile.children.cycles-pp.__mmap=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.10 =B1=A0 8%=A0 perf-profile.children.cycles-pp.sock_sendmsg=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.10 =B1=A0 4%=A0 perf-profile.children.cycles-pp.perf_event_mmap=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.10 =B1=A0 8%=A0 perf-profile.children.cycles-pp.__memcg_kmem_uncha=
rge_page=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.10 =B1 45%=A0 perf-profile.children.cycles-pp.dcache_dir_close=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.10 =B1=A0 7%=A0 perf-profile.children.cycles-pp.sock_write_iter=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.10 =B1=A0 7%=A0 perf-profile.children.cycles-pp.lockref_put_return=
=0A=
=A0=A0=A0=A0=A0 0.09 =B1 10%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.19 =
=B1=A0 9%=A0 perf-profile.children.cycles-pp.ksys_write=0A=
=A0=A0=A0=A0=A0 0.02 =B1141%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.12 =
=B1=A0 3%=A0 perf-profile.children.cycles-pp.apparmor_task_getsecid=0A=
=A0=A0=A0=A0=A0 0.08 =B1=A0 5%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.1=
9 =B1=A0 9%=A0 perf-profile.children.cycles-pp.vfs_write=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.11 =B1 10%=A0 perf-profile.children.cycles-pp.do_unlinkat=0A=
=A0=A0=A0=A0=A0 0.08 =B1 10%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.19 =
=B1=A0 2%=A0 perf-profile.children.cycles-pp.find_idlest_group=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.11 =B1 33%=A0 perf-profile.children.cycles-pp.__close_nocancel=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.11 =B1=A0 4%=A0 perf-profile.children.cycles-pp.vm_area_alloc=0A=
=A0=A0=A0=A0=A0 0.06 =B1 16%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.16 =
=B1=A0 5%=A0 perf-profile.children.cycles-pp.do_anonymous_page=0A=
=A0=A0=A0=A0=A0 0.02 =B1141%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.12 =
=B1=A0 4%=A0 perf-profile.children.cycles-pp.security_task_getsecid=0A=
=A0=A0=A0=A0=A0 0.08 =B1 14%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.19 =
=B1=A0 6%=A0 perf-profile.children.cycles-pp.__xstat64=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.11=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.__mod_memc=
g_lruvec_state=0A=
=A0=A0=A0=A0=A0 0.06 =B1 16%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.17 =
=B1=A0 4%=A0 perf-profile.children.cycles-pp.obj_cgroup_charge=0A=
=A0=A0=A0=A0=A0 0.07=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.18 =B1=A0 5%=A0 perf-profile.children.cycles-pp.apparmor_file_allo=
c_security=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.11 =B1=A0 3%=A0 perf-profile.children.cycles-pp.__clear_user=0A=
=A0=A0=A0=A0=A0 0.20 =B1 12%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.31 =
=B1 15%=A0 perf-profile.children.cycles-pp.task_tick_fair=0A=
=A0=A0=A0=A0=A0 0.02 =B1141%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.13 =
=B1=A0 5%=A0 perf-profile.children.cycles-pp.find_busiest_group=0A=
=A0=A0=A0=A0=A0 0.02 =B1141%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.13 =
=B1=A0 5%=A0 perf-profile.children.cycles-pp.update_sd_lb_stats=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.11 =B1=A0 4%=A0 perf-profile.children.cycles-pp.ima_file_check=0A=
=A0=A0=A0=A0=A0 0.08 =B1 10%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.20 =
=B1=A0 4%=A0 perf-profile.children.cycles-pp.vma_interval_tree_insert=0A=
=A0=A0=A0=A0=A0 0.07 =B1 14%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.18 =
=B1=A0 4%=A0 perf-profile.children.cycles-pp.page_remove_rmap=0A=
=A0=A0=A0=A0=A0 0.02 =B1141%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.14 =
=B1=A0 3%=A0 perf-profile.children.cycles-pp.wp_page_copy=0A=
=A0=A0=A0=A0=A0 0.02 =B1141%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.14 =
=B1=A0 6%=A0 perf-profile.children.cycles-pp.pte_alloc_one=0A=
=A0=A0=A0=A0=A0 0.03 =B1 70%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.15 =
=B1=A0 2%=A0 perf-profile.children.cycles-pp.schedule=0A=
=A0=A0=A0=A0=A0 0.07 =B1 11%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.19=
=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp._dl_addr=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.12 =B1=A0 8%=A0 perf-profile.children.cycles-pp.finish_task_switch=
=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.12 =B1 13%=A0 perf-profile.children.cycles-pp.__put_task_struct=0A=
=A0=A0=A0=A0=A0 0.08=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.20 =B1=A0 5%=A0 perf-profile.children.cycles-pp.security_file_allo=
c=0A=
=A0=A0=A0=A0=A0 0.09 =B1=A0 9%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.2=
1 =B1=A0 2%=A0 perf-profile.children.cycles-pp.select_task_rq_fair=0A=
=A0=A0=A0=A0=A0 0.04 =B1 71%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.16 =
=B1=A0 5%=A0 perf-profile.children.cycles-pp.load_balance=0A=
=A0=A0=A0=A0=A0 0.05 =B1=A0 8%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.1=
8 =B1=A0 4%=A0 perf-profile.children.cycles-pp.vm_area_dup=0A=
=A0=A0=A0=A0=A0 0.04 =B1 71%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.17 =
=B1=A0 2%=A0 perf-profile.children.cycles-pp.__d_alloc=0A=
=A0=A0=A0=A0=A0 0.02 =B1141%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.15 =
=B1=A0 7%=A0 perf-profile.children.cycles-pp.do_wait=0A=
=A0=A0=A0=A0=A0 0.02 =B1141%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.15 =
=B1=A0 5%=A0 perf-profile.children.cycles-pp.pick_next_task_fair=0A=
=A0=A0=A0=A0=A0 0.06 =B1 16%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.19 =
=B1=A0 3%=A0 perf-profile.children.cycles-pp.anon_vma_clone=0A=
=A0=A0=A0=A0=A0 0.02 =B1141%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.15 =
=B1=A0 8%=A0 perf-profile.children.cycles-pp.__do_sys_wait4=0A=
=A0=A0=A0=A0=A0 0.02 =B1141%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.15 =
=B1=A0 8%=A0 perf-profile.children.cycles-pp.kernel_wait4=0A=
=A0=A0=A0=A0=A0 0.05 =B1=A0 8%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.1=
9 =B1=A0 2%=A0 perf-profile.children.cycles-pp.__vm_munmap=0A=
=A0=A0=A0=A0=A0 0.28 =B1 13%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.42 =
=B1 12%=A0 perf-profile.children.cycles-pp.scheduler_tick=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.14 =B1=A0 3%=A0 perf-profile.children.cycles-pp.cna_order_queue=0A=
=A0=A0=A0=A0=A0 0.08 =B1 12%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.22 =
=B1=A0 5%=A0 perf-profile.children.cycles-pp.copy_page_range=0A=
=A0=A0=A0=A0=A0 0.06 =B1 19%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.21 =
=B1=A0 7%=A0 perf-profile.children.cycles-pp.__memcg_kmem_charge_page=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.15 =B1=A0 5%=A0 perf-profile.children.cycles-pp.newidle_balance=0A=
=A0=A0=A0=A0=A0 0.05 =B1=A0 8%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.2=
1 =B1 19%=A0 perf-profile.children.cycles-pp.__lock_parent=0A=
=A0=A0=A0=A0=A0 0.08 =B1 14%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.26 =
=B1=A0 4%=A0 perf-profile.children.cycles-pp.rwsem_spin_on_owner=0A=
=A0=A0=A0=A0=A0 0.09 =B1 15%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.28 =
=B1=A0 4%=A0 perf-profile.children.cycles-pp.release_pages=0A=
=A0=A0=A0=A0=A0 0.09 =B1 19%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.28 =
=B1=A0 5%=A0 perf-profile.children.cycles-pp.page_counter_try_charge=0A=
=A0=A0=A0=A0=A0 0.21 =B1 21%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.41 =
=B1 10%=A0 perf-profile.children.cycles-pp.div_int=0A=
=A0=A0=A0=A0=A0 0.39 =B1 14%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.58 =
=B1 10%=A0 perf-profile.children.cycles-pp.update_process_times=0A=
=A0=A0=A0=A0=A0 0.39 =B1 14%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.59 =
=B1 10%=A0 perf-profile.children.cycles-pp.tick_sched_handle=0A=
=A0=A0=A0=A0=A0 0.09 =B1 20%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.29 =
=B1=A0 3%=A0 perf-profile.children.cycles-pp.__memcg_kmem_charge=0A=
=A0=A0=A0=A0=A0 0.08 =B1 17%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.28 =
=B1=A0 3%=A0 perf-profile.children.cycles-pp.anon_vma_fork=0A=
=A0=A0=A0=A0=A0 0.16 =B1 12%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.36 =
=B1 10%=A0 perf-profile.children.cycles-pp.mem_rtns_1=0A=
=A0=A0=A0=A0=A0 0.25 =B1 20%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.46 =
=B1 10%=A0 perf-profile.children.cycles-pp.div_short=0A=
=A0=A0=A0=A0=A0 0.07 =B1 25%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.28 =
=B1=A0 4%=A0 perf-profile.children.cycles-pp.remove_vma=0A=
=A0=A0=A0=A0=A0 0.43 =B1 14%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.64 =
=B1 10%=A0 perf-profile.children.cycles-pp.tick_sched_timer=0A=
=A0=A0=A0=A0=A0 0.14 =B1=A0 3%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.3=
6 =B1=A0 5%=A0 perf-profile.children.cycles-pp.setlocale=0A=
=A0=A0=A0=A0=A0 0.09 =B1=A0 9%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.3=
1=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.__schedule=0A=
=A0=A0=A0=A0=A0 0.11 =B1 12%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.33 =
=B1=A0 4%=A0 perf-profile.children.cycles-pp.tlb_flush_mmu=0A=
=A0=A0=A0=A0=A0 0.11 =B1 16%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.34 =
=B1=A0 5%=A0 perf-profile.children.cycles-pp.tlb_finish_mmu=0A=
=A0=A0=A0=A0=A0 0.10 =B1=A0 4%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.3=
3 =B1 11%=A0 perf-profile.children.cycles-pp.__fput=0A=
=A0=A0=A0=A0=A0 0.11 =B1 11%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.35 =
=B1=A0 4%=A0 perf-profile.children.cycles-pp.__alloc_pages_nodemask=0A=
=A0=A0=A0=A0=A0 0.52 =B1 14%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.76 =
=B1 12%=A0 perf-profile.children.cycles-pp.__hrtimer_run_queues=0A=
=A0=A0=A0=A0=A0 0.22 =B1 19%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.46 =
=B1 11%=A0 perf-profile.children.cycles-pp.add_short=0A=
=A0=A0=A0=A0=A0 0.13 =B1 10%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.38 =
=B1=A0 5%=A0 perf-profile.children.cycles-pp.lookup_fast=0A=
=A0=A0=A0=A0=A0 0.09 =B1 15%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.35=
=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.unlink_anon_vmas=0A=
=A0=A0=A0=A0=A0 0.09 =B1 19%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.34 =
=B1=A0 4%=A0 perf-profile.children.cycles-pp.get_obj_cgroup_from_current=0A=
=A0=A0=A0=A0=A0 0.12 =B1=A0 3%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.3=
8 =B1 10%=A0 perf-profile.children.cycles-pp.task_work_run=0A=
=A0=A0=A0=A0=A0 0.09 =B1 20%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.35=
=A0=A0=A0=A0=A0=A0=A0 perf-profile.children.cycles-pp.iterate_supers=0A=
=A0=A0=A0=A0=A0 0.09 =B1 20%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.36 =
=B1=A0 2%=A0 perf-profile.children.cycles-pp.__x64_sys_sync=0A=
=A0=A0=A0=A0=A0 0.09 =B1 20%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.36 =
=B1=A0 2%=A0 perf-profile.children.cycles-pp.ksys_sync=0A=
=A0=A0=A0=A0=A0 0.12 =B1 11%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.39 =
=B1=A0 2%=A0 perf-profile.children.cycles-pp.d_alloc=0A=
=A0=A0=A0=A0=A0 0.09 =B1 20%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.36 =
=B1=A0 2%=A0 perf-profile.children.cycles-pp.sync=0A=
=A0=A0=A0=A0=A0 0.75 =B1 12%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 1.03 =
=B1 11%=A0 perf-profile.children.cycles-pp.hrtimer_interrupt=0A=
=A0=A0=A0=A0=A0 0.75 =B1 12%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 1.04 =
=B1 12%=A0 perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt=0A=
=A0=A0=A0=A0=A0 0.15 =B1=A0 3%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.4=
5 =B1=A0 8%=A0 perf-profile.children.cycles-pp.exit_to_user_mode_prepare=0A=
=A0=A0=A0=A0=A0 0.09 =B1 20%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.39 =
=B1=A0 3%=A0 perf-profile.children.cycles-pp.load_elf_interp=0A=
=A0=A0=A0=A0=A0 0.19 =B1 12%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.49 =
=B1=A0 3%=A0 perf-profile.children.cycles-pp.zap_pte_range=0A=
=A0=A0=A0=A0=A0 0.20 =B1 11%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.51 =
=B1=A0 3%=A0 perf-profile.children.cycles-pp.unmap_page_range=0A=
=A0=A0=A0=A0=A0 0.52 =B1 19%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.84 =
=B1=A0 3%=A0 perf-profile.children.cycles-pp.creat64=0A=
=A0=A0=A0=A0=A0 0.21 =B1=A0 8%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.5=
4 =B1=A0 3%=A0 perf-profile.children.cycles-pp.unmap_vmas=0A=
=A0=A0=A0=A0=A0 0.09 =B1 24%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.42 =
=B1 11%=A0 perf-profile.children.cycles-pp.propagate_protected_usage=0A=
=A0=A0=A0=A0=A0 0.28 =B1 14%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.62 =
=B1 10%=A0 perf-profile.children.cycles-pp.__strcat_chk=0A=
=A0=A0=A0=A0=A0 0.25 =B1=A0 7%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.5=
9 =B1=A0 4%=A0 perf-profile.children.cycles-pp.path_lookupat=0A=
=A0=A0=A0=A0=A0 0.25 =B1=A0 8%=A0=A0=A0=A0=A0 +0.4=A0=A0=A0=A0=A0=A0=A0 0.6=
0 =B1=A0 4%=A0 perf-profile.children.cycles-pp.filename_lookup=0A=
=A0=A0=A0=A0=A0 0.26 =B1=A0 8%=A0=A0=A0=A0=A0 +0.4=A0=A0=A0=A0=A0=A0=A0 0.6=
2 =B1=A0 4%=A0 perf-profile.children.cycles-pp.__do_sys_newstat=0A=
=A0=A0=A0=A0=A0 0.19 =B1 11%=A0=A0=A0=A0=A0 +0.4=A0=A0=A0=A0=A0=A0=A0 0.56 =
=B1=A0 4%=A0 perf-profile.children.cycles-pp.__alloc_file=0A=
=A0=A0=A0=A0=A0 0.19 =B1=A0 9%=A0=A0=A0=A0=A0 +0.4=A0=A0=A0=A0=A0=A0=A0 0.5=
6 =B1=A0 3%=A0 perf-profile.children.cycles-pp.alloc_empty_file=0A=
=A0=A0=A0=A0=A0 0.26 =B1=A0 8%=A0=A0=A0=A0=A0 +0.4=A0=A0=A0=A0=A0=A0=A0 0.6=
3 =B1=A0 4%=A0 perf-profile.children.cycles-pp.vfs_statx=0A=
=A0=A0=A0=A0=A0 0.12 =B1 15%=A0=A0=A0=A0=A0 +0.4=A0=A0=A0=A0=A0=A0=A0 0.49 =
=B1=A0 2%=A0 perf-profile.children.cycles-pp.elf_map=0A=
=A0=A0=A0=A0=A0 0.22 =B1 11%=A0=A0=A0=A0=A0 +0.4=A0=A0=A0=A0=A0=A0=A0 0.60 =
=B1=A0 2%=A0 perf-profile.children.cycles-pp.d_alloc_parallel=0A=
=A0=A0=A0=A0=A0 0.29 =B1=A0 8%=A0=A0=A0=A0=A0 +0.4=A0=A0=A0=A0=A0=A0=A0 0.6=
8 =B1=A0 3%=A0 perf-profile.children.cycles-pp.filemap_map_pages=0A=
=A0=A0=A0=A0=A0 0.24 =B1=A0 9%=A0=A0=A0=A0=A0 +0.4=A0=A0=A0=A0=A0=A0=A0 0.6=
3 =B1=A0 2%=A0 perf-profile.children.cycles-pp.__lookup_slow=0A=
=A0=A0=A0=A0=A0 0.30 =B1 32%=A0=A0=A0=A0=A0 +0.4=A0=A0=A0=A0=A0=A0=A0 0.73 =
=B1 41%=A0 perf-profile.children.cycles-pp.syscall_exit_to_user_mode=0A=
=A0=A0=A0=A0=A0 0.49 =B1 20%=A0=A0=A0=A0=A0 +0.4=A0=A0=A0=A0=A0=A0=A0 0.93 =
=B1 10%=A0 perf-profile.children.cycles-pp.div_long=0A=
=A0=A0=A0=A0=A0 0.32 =B1 10%=A0=A0=A0=A0=A0 +0.5=A0=A0=A0=A0=A0=A0=A0 0.78 =
=B1=A0 3%=A0 perf-profile.children.cycles-pp.do_fault=0A=
=A0=A0=A0=A0=A0 0.52 =B1 17%=A0=A0=A0=A0=A0 +0.5=A0=A0=A0=A0=A0=A0=A0 1.04 =
=B1=A0 9%=A0 perf-profile.children.cycles-pp.add_int=0A=
=A0=A0=A0=A0=A0 0.51 =B1 18%=A0=A0=A0=A0=A0 +0.5=A0=A0=A0=A0=A0=A0=A0 1.04 =
=B1=A0 8%=A0 perf-profile.children.cycles-pp.add_long=0A=
=A0=A0=A0=A0=A0 0.50 =B1 14%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 1.12 =
=B1 11%=A0 perf-profile.children.cycles-pp.__strncat_chk=0A=
=A0=A0=A0=A0=A0 0.12 =B1 14%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 0.74 =
=B1 10%=A0 perf-profile.children.cycles-pp.terminate_walk=0A=
=A0=A0=A0=A0=A0 0.39 =B1 19%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 1.02 =
=B1 18%=A0 perf-profile.children.cycles-pp.mprotect_fixup=0A=
=A0=A0=A0=A0=A0 0.39 =B1 18%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 1.03 =
=B1 18%=A0 perf-profile.children.cycles-pp.__x64_sys_mprotect=0A=
=A0=A0=A0=A0=A0 0.39 =B1 18%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 1.03 =
=B1 18%=A0 perf-profile.children.cycles-pp.do_mprotect_pkey=0A=
=A0=A0=A0=A0=A0 0.21 =B1 23%=A0=A0=A0=A0=A0 +0.7=A0=A0=A0=A0=A0=A0=A0 0.90 =
=B1 13%=A0 perf-profile.children.cycles-pp.__memcg_kmem_uncharge=0A=
=A0=A0=A0=A0=A0 0.46 =B1 21%=A0=A0=A0=A0=A0 +0.7=A0=A0=A0=A0=A0=A0=A0 1.20 =
=B1 21%=A0 perf-profile.children.cycles-pp.unmap_region=0A=
=A0=A0=A0=A0=A0 0.30 =B1 17%=A0=A0=A0=A0=A0 +0.7=A0=A0=A0=A0=A0=A0=A0 1.04 =
=B1=A0 3%=A0 perf-profile.children.cycles-pp.kmem_cache_alloc=0A=
=A0=A0=A0=A0=A0 0.48 =B1=A0 9%=A0=A0=A0=A0=A0 +0.8=A0=A0=A0=A0=A0=A0=A0 1.2=
3 =B1=A0 3%=A0 perf-profile.children.cycles-pp.__handle_mm_fault=0A=
=A0=A0=A0=A0=A0 0.50 =B1 10%=A0=A0=A0=A0=A0 +0.8=A0=A0=A0=A0=A0=A0=A0 1.30 =
=B1=A0 3%=A0 perf-profile.children.cycles-pp.handle_mm_fault=0A=
=A0=A0=A0=A0=A0 0.53 =B1=A0 9%=A0=A0=A0=A0=A0 +0.8=A0=A0=A0=A0=A0=A0=A0 1.3=
7 =B1=A0 3%=A0 perf-profile.children.cycles-pp.do_user_addr_fault=0A=
=A0=A0=A0=A0=A0 0.47 =B1=A0 9%=A0=A0=A0=A0=A0 +0.8=A0=A0=A0=A0=A0=A0=A0 1.3=
0 =B1=A0 2%=A0 perf-profile.children.cycles-pp.link_path_walk=0A=
=A0=A0=A0=A0=A0 0.54 =B1=A0 8%=A0=A0=A0=A0=A0 +0.8=A0=A0=A0=A0=A0=A0=A0 1.3=
8 =B1=A0 3%=A0 perf-profile.children.cycles-pp.exc_page_fault=0A=
=A0=A0=A0=A0=A0 0.48 =B1=A0 9%=A0=A0=A0=A0=A0 +0.9=A0=A0=A0=A0=A0=A0=A0 1.3=
3 =B1=A0 3%=A0 perf-profile.children.cycles-pp.walk_component=0A=
=A0=A0=A0=A0=A0 0.49 =B1 18%=A0=A0=A0=A0=A0 +0.9=A0=A0=A0=A0=A0=A0=A0 1.34 =
=B1 13%=A0 perf-profile.children.cycles-pp.__libc_fork=0A=
=A0=A0=A0=A0=A0 0.50 =B1 20%=A0=A0=A0=A0=A0 +0.9=A0=A0=A0=A0=A0=A0=A0 1.41 =
=B1 16%=A0 perf-profile.children.cycles-pp.vma_link=0A=
=A0=A0=A0=A0=A0 0.59 =B1=A0 4%=A0=A0=A0=A0=A0 +0.9=A0=A0=A0=A0=A0=A0=A0 1.5=
1 =B1=A0 4%=A0 perf-profile.children.cycles-pp.asm_exc_page_fault=0A=
=A0=A0=A0=A0=A0 0.34 =B1 22%=A0=A0=A0=A0=A0 +1.1=A0=A0=A0=A0=A0=A0=A0 1.43 =
=B1 12%=A0 perf-profile.children.cycles-pp.page_counter_cancel=0A=
=A0=A0=A0=A0=A0 0.72 =B1 19%=A0=A0=A0=A0=A0 +1.2=A0=A0=A0=A0=A0=A0=A0 1.88 =
=B1 19%=A0 perf-profile.children.cycles-pp.__vma_adjust=0A=
=A0=A0=A0=A0=A0 0.36 =B1 22%=A0=A0=A0=A0=A0 +1.2=A0=A0=A0=A0=A0=A0=A0 1.54 =
=B1 12%=A0 perf-profile.children.cycles-pp.page_counter_uncharge=0A=
=A0=A0=A0=A0=A0 0.74 =B1 19%=A0=A0=A0=A0=A0 +1.2=A0=A0=A0=A0=A0=A0=A0 1.94 =
=B1 19%=A0 perf-profile.children.cycles-pp.__split_vma=0A=
=A0=A0=A0=A0=A0 0.37 =B1 21%=A0=A0=A0=A0=A0 +1.2=A0=A0=A0=A0=A0=A0=A0 1.59 =
=B1=A0 5%=A0 perf-profile.children.cycles-pp.irq_exit_rcu=0A=
=A0=A0=A0=A0=A0 0.36 =B1 22%=A0=A0=A0=A0=A0 +1.2=A0=A0=A0=A0=A0=A0=A0 1.59 =
=B1=A0 5%=A0 perf-profile.children.cycles-pp.do_softirq_own_stack=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.2=A0=A0=A0=A0=A0=
=A0=A0 1.23 =B1 19%=A0 perf-profile.children.cycles-pp.dcache_dir_open=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.2=A0=A0=A0=A0=A0=
=A0=A0 1.23 =B1 19%=A0 perf-profile.children.cycles-pp.d_alloc_cursor=0A=
=A0=A0=A0=A0=A0 0.69 =B1 15%=A0=A0=A0=A0=A0 +1.3=A0=A0=A0=A0=A0=A0=A0 1.96 =
=B1 14%=A0 perf-profile.children.cycles-pp.begin_new_exec=0A=
=A0=A0=A0=A0=A0 0.85 =B1 20%=A0=A0=A0=A0=A0 +1.4=A0=A0=A0=A0=A0=A0=A0 2.21 =
=B1 20%=A0 perf-profile.children.cycles-pp.__do_munmap=0A=
=A0=A0=A0=A0=A0 0.81 =B1 16%=A0=A0=A0=A0=A0 +1.4=A0=A0=A0=A0=A0=A0=A0 2.22 =
=B1 13%=A0 perf-profile.children.cycles-pp.__x64_sys_exit_group=0A=
=A0=A0=A0=A0=A0 0.81 =B1 16%=A0=A0=A0=A0=A0 +1.4=A0=A0=A0=A0=A0=A0=A0 2.22 =
=B1 13%=A0 perf-profile.children.cycles-pp.do_group_exit=0A=
=A0=A0=A0=A0=A0 0.81 =B1 16%=A0=A0=A0=A0=A0 +1.4=A0=A0=A0=A0=A0=A0=A0 2.22 =
=B1 13%=A0 perf-profile.children.cycles-pp.do_exit=0A=
=A0=A0=A0=A0=A0 1.09 =B1 16%=A0=A0=A0=A0=A0 +1.4=A0=A0=A0=A0=A0=A0=A0 2.50 =
=B1=A0 8%=A0 perf-profile.children.cycles-pp.asm_call_sysvec_on_stack=0A=
=A0=A0=A0=A0=A0 0.84 =B1 20%=A0=A0=A0=A0=A0 +1.4=A0=A0=A0=A0=A0=A0=A0 2.29 =
=B1 15%=A0 perf-profile.children.cycles-pp.dup_mmap=0A=
=A0=A0=A0=A0=A0 0.39 =B1 20%=A0=A0=A0=A0=A0 +1.5=A0=A0=A0=A0=A0=A0=A0 1.84 =
=B1 12%=A0 perf-profile.children.cycles-pp.drain_obj_stock=0A=
=A0=A0=A0=A0=A0 0.85 =B1 20%=A0=A0=A0=A0=A0 +1.5=A0=A0=A0=A0=A0=A0=A0 2.32 =
=B1 15%=A0 perf-profile.children.cycles-pp.dup_mm=0A=
=A0=A0=A0=A0=A0 1.18 =B1 15%=A0=A0=A0=A0=A0 +1.6=A0=A0=A0=A0=A0=A0=A0 2.74 =
=B1=A0 8%=A0 perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt=0A=
=A0=A0=A0=A0=A0 0.94 =B1 18%=A0=A0=A0=A0=A0 +1.6=A0=A0=A0=A0=A0=A0=A0 2.58 =
=B1 13%=A0 perf-profile.children.cycles-pp.copy_process=0A=
=A0=A0=A0=A0=A0 1.29 =B1 11%=A0=A0=A0=A0=A0 +1.6=A0=A0=A0=A0=A0=A0=A0 2.94 =
=B1=A0 7%=A0 perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrup=
t=0A=
=A0=A0=A0=A0=A0 1.00 =B1 18%=A0=A0=A0=A0=A0 +1.7=A0=A0=A0=A0=A0=A0=A0 2.72 =
=B1 13%=A0 perf-profile.children.cycles-pp.__do_sys_clone=0A=
=A0=A0=A0=A0=A0 1.00 =B1 18%=A0=A0=A0=A0=A0 +1.7=A0=A0=A0=A0=A0=A0=A0 2.72 =
=B1 13%=A0 perf-profile.children.cycles-pp.kernel_clone=0A=
=A0=A0=A0=A0=A0 0.47 =B1 18%=A0=A0=A0=A0=A0 +1.8=A0=A0=A0=A0=A0=A0=A0 2.25 =
=B1 12%=A0 perf-profile.children.cycles-pp.refill_obj_stock=0A=
=A0=A0=A0=A0=A0 0.92 =B1 14%=A0=A0=A0=A0=A0 +1.9=A0=A0=A0=A0=A0=A0=A0 2.78 =
=B1 10%=A0 perf-profile.children.cycles-pp.load_elf_binary=0A=
=A0=A0=A0=A0=A0 0.93 =B1 14%=A0=A0=A0=A0=A0 +1.9=A0=A0=A0=A0=A0=A0=A0 2.79 =
=B1 10%=A0 perf-profile.children.cycles-pp.exec_binprm=0A=
=A0=A0=A0=A0=A0 1.68 =B1 14%=A0=A0=A0=A0=A0 +2.1=A0=A0=A0=A0=A0=A0=A0 3.74 =
=B1 10%=A0 perf-profile.children.cycles-pp.string_rtns_1=0A=
=A0=A0=A0=A0=A0 1.30 =B1 20%=A0=A0=A0=A0=A0 +2.1=A0=A0=A0=A0=A0=A0=A0 3.37 =
=B1 20%=A0 perf-profile.children.cycles-pp.ksys_mmap_pgoff=0A=
=A0=A0=A0=A0=A0 1.35 =B1 19%=A0=A0=A0=A0=A0 +2.2=A0=A0=A0=A0=A0=A0=A0 3.51 =
=B1 24%=A0 perf-profile.children.cycles-pp.unlink_file_vma=0A=
=A0=A0=A0=A0=A0 1.36 =B1 20%=A0=A0=A0=A0=A0 +2.3=A0=A0=A0=A0=A0=A0=A0 3.63 =
=B1 18%=A0 perf-profile.children.cycles-pp.mmap_region=0A=
=A0=A0=A0=A0=A0 1.37 =B1 20%=A0=A0=A0=A0=A0 +2.3=A0=A0=A0=A0=A0=A0=A0 3.67 =
=B1 18%=A0 perf-profile.children.cycles-pp.do_mmap=0A=
=A0=A0=A0=A0=A0 1.39 =B1 20%=A0=A0=A0=A0=A0 +2.3=A0=A0=A0=A0=A0=A0=A0 3.72 =
=B1 18%=A0 perf-profile.children.cycles-pp.vm_mmap_pgoff=0A=
=A0=A0=A0=A0=A0 1.46 =B1 19%=A0=A0=A0=A0=A0 +2.5=A0=A0=A0=A0=A0=A0=A0 3.92 =
=B1 21%=A0 perf-profile.children.cycles-pp.free_pgtables=0A=
=A0=A0=A0=A0=A0 1.40 =B1 16%=A0=A0=A0=A0=A0 +2.5=A0=A0=A0=A0=A0=A0=A0 3.88 =
=B1 14%=A0 perf-profile.children.cycles-pp.exit_mmap=0A=
=A0=A0=A0=A0=A0 1.40 =B1 16%=A0=A0=A0=A0=A0 +2.5=A0=A0=A0=A0=A0=A0=A0 3.89 =
=B1 14%=A0 perf-profile.children.cycles-pp.mmput=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +2.7=A0=A0=A0=A0=A0=
=A0=A0 2.65 =B1=A0 9%=A0 perf-profile.children.cycles-pp.lockref_get=0A=
=A0=A0=A0=A0=A0 0.08 =B1=A0 5%=A0=A0=A0=A0=A0 +2.7=A0=A0=A0=A0=A0=A0=A0 2.8=
0 =B1=A0 8%=A0 perf-profile.children.cycles-pp.do_dentry_open=0A=
=A0=A0=A0=A0=A0 0.61 =B1 11%=A0=A0=A0=A0=A0 +3.2=A0=A0=A0=A0=A0=A0=A0 3.79 =
=B1 15%=A0 perf-profile.children.cycles-pp.run_ksoftirqd=0A=
=A0=A0=A0=A0=A0 0.61 =B1 12%=A0=A0=A0=A0=A0 +3.2=A0=A0=A0=A0=A0=A0=A0 3.82 =
=B1 15%=A0 perf-profile.children.cycles-pp.smpboot_thread_fn=0A=
=A0=A0=A0=A0=A0 0.65 =B1 11%=A0=A0=A0=A0=A0 +3.2=A0=A0=A0=A0=A0=A0=A0 3.88 =
=B1 15%=A0 perf-profile.children.cycles-pp.kthread=0A=
=A0=A0=A0=A0=A0 0.66 =B1 11%=A0=A0=A0=A0=A0 +3.3=A0=A0=A0=A0=A0=A0=A0 3.92 =
=B1 15%=A0 perf-profile.children.cycles-pp.ret_from_fork=0A=
=A0=A0=A0=A0=A0 0.91 =B1 14%=A0=A0=A0=A0=A0 +4.3=A0=A0=A0=A0=A0=A0=A0 5.25 =
=B1 12%=A0 perf-profile.children.cycles-pp.rcu_do_batch=0A=
=A0=A0=A0=A0=A0 0.92 =B1 13%=A0=A0=A0=A0=A0 +4.3=A0=A0=A0=A0=A0=A0=A0 5.25 =
=B1 12%=A0 perf-profile.children.cycles-pp.rcu_core=0A=
=A0=A0=A0=A0=A0 0.97 =B1 13%=A0=A0=A0=A0=A0 +4.4=A0=A0=A0=A0=A0=A0=A0 5.38 =
=B1 12%=A0 perf-profile.children.cycles-pp.__softirqentry_text_start=0A=
=A0=A0=A0=A0=A0 0.99 =B1 14%=A0=A0=A0=A0=A0 +4.5=A0=A0=A0=A0=A0=A0=A0 5.52 =
=B1 10%=A0 perf-profile.children.cycles-pp.kmem_cache_free=0A=
=A0=A0=A0=A0=A0 3.02 =B1 19%=A0=A0=A0=A0=A0 +4.7=A0=A0=A0=A0=A0=A0=A0 7.76 =
=B1 23%=A0 perf-profile.children.cycles-pp.osq_lock=0A=
=A0=A0=A0=A0=A0 3.15 =B1 19%=A0=A0=A0=A0=A0 +5.0=A0=A0=A0=A0=A0=A0=A0 8.16 =
=B1 22%=A0 perf-profile.children.cycles-pp.rwsem_down_write_slowpath=0A=
=A0=A0=A0=A0=A0 3.33 =B1 10%=A0=A0=A0=A0=A0 +6.1=A0=A0=A0=A0=A0=A0=A0 9.38 =
=B1 10%=A0 perf-profile.children.cycles-pp.intel_idle=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +6.4=A0=A0=A0=A0=A0=
=A0=A0 6.37 =B1=A0 2%=A0 perf-profile.children.cycles-pp.complete_walk=0A=
=A0=A0=A0=A0=A0 0.13 =B1=A0 3%=A0=A0=A0=A0=A0 +7.1=A0=A0=A0=A0=A0=A0=A0 7.1=
9 =B1 18%=A0 perf-profile.children.cycles-pp.__open64_nocancel=0A=
=A0=A0=A0=A0=A0 3.89 =B1=A0 9%=A0=A0=A0=A0=A0 +7.1=A0=A0=A0=A0=A0=A0 10.99 =
=B1=A0 8%=A0 perf-profile.children.cycles-pp.cpuidle_enter_state=0A=
=A0=A0=A0=A0=A0 3.89 =B1=A0 9%=A0=A0=A0=A0=A0 +7.1=A0=A0=A0=A0=A0=A0 11.00 =
=B1=A0 8%=A0 perf-profile.children.cycles-pp.cpuidle_enter=0A=
=A0=A0=A0=A0=A0 0.28 =B1=A0 3%=A0=A0=A0=A0=A0 +7.2=A0=A0=A0=A0=A0=A0=A0 7.4=
8 =B1=A0 6%=A0 perf-profile.children.cycles-pp.lockref_put_or_lock=0A=
=A0=A0=A0=A0=A0 4.17 =B1=A0 6%=A0=A0=A0=A0=A0 +7.4=A0=A0=A0=A0=A0=A0 11.59 =
=B1=A0 8%=A0 perf-profile.children.cycles-pp.start_secondary=0A=
=A0=A0=A0=A0=A0 4.20 =B1=A0 6%=A0=A0=A0=A0=A0 +7.4=A0=A0=A0=A0=A0=A0 11.63 =
=B1=A0 8%=A0 perf-profile.children.cycles-pp.secondary_startup_64_no_verify=
=0A=
=A0=A0=A0=A0=A0 4.20 =B1=A0 6%=A0=A0=A0=A0=A0 +7.4=A0=A0=A0=A0=A0=A0 11.63 =
=B1=A0 8%=A0 perf-profile.children.cycles-pp.cpu_startup_entry=0A=
=A0=A0=A0=A0=A0 4.20 =B1=A0 6%=A0=A0=A0=A0=A0 +7.4=A0=A0=A0=A0=A0=A0 11.63 =
=B1=A0 8%=A0 perf-profile.children.cycles-pp.do_idle=0A=
=A0=A0=A0=A0=A0 0.54 =B1=A0 4%=A0=A0=A0=A0=A0 +7.5=A0=A0=A0=A0=A0=A0=A0 8.0=
4 =B1=A0 6%=A0 perf-profile.children.cycles-pp.dput=0A=
=A0=A0=A0=A0=A0 1.12 =B1=A0 2%=A0=A0=A0=A0 +11.1=A0=A0=A0=A0=A0=A0 12.26 =
=B1=A0 2%=A0 perf-profile.children.cycles-pp.do_sys_open=0A=
=A0=A0=A0=A0=A0 1.12 =B1=A0 2%=A0=A0=A0=A0 +11.1=A0=A0=A0=A0=A0=A0 12.25 =
=B1=A0 2%=A0 perf-profile.children.cycles-pp.do_sys_openat2=0A=
=A0=A0=A0=A0=A0 0.06 =B1 14%=A0=A0=A0=A0 +24.2=A0=A0=A0=A0=A0=A0 24.28 =B1=
=A0 4%=A0 perf-profile.children.cycles-pp.pick_link=0A=
=A0=A0=A0=A0=A0 1.03 =B1=A0 4%=A0=A0=A0=A0 +24.4=A0=A0=A0=A0=A0=A0 25.43 =
=B1=A0 8%=A0 perf-profile.children.cycles-pp.execve=0A=
=A0=A0=A0=A0=A0 0.17 =B1 10%=A0=A0=A0=A0 +30.8=A0=A0=A0=A0=A0=A0 30.92 =B1=
=A0 3%=A0 perf-profile.children.cycles-pp.lockref_get_not_dead=0A=
=A0=A0=A0=A0=A0 0.10 =B1=A0 8%=A0=A0=A0=A0 +30.8=A0=A0=A0=A0=A0=A0 30.87 =
=B1=A0 3%=A0 perf-profile.children.cycles-pp.do_open_execat=0A=
=A0=A0=A0=A0=A0 0.18 =B1=A0 9%=A0=A0=A0=A0 +30.8=A0=A0=A0=A0=A0=A0 30.95 =
=B1=A0 3%=A0 perf-profile.children.cycles-pp.__legitimize_path=0A=
=A0=A0=A0=A0=A0 0.18 =B1 12%=A0=A0=A0=A0 +30.8=A0=A0=A0=A0=A0=A0 30.96 =B1=
=A0 3%=A0 perf-profile.children.cycles-pp.unlazy_walk=0A=
=A0=A0=A0=A0=A0 0.20 =B1 10%=A0=A0=A0=A0 +31.0=A0=A0=A0=A0=A0=A0 31.15 =B1=
=A0 3%=A0 perf-profile.children.cycles-pp.step_into=0A=
=A0=A0=A0=A0=A0 1.05 =B1 14%=A0=A0=A0=A0 +32.7=A0=A0=A0=A0=A0=A0 33.76 =B1=
=A0 3%=A0 perf-profile.children.cycles-pp.bprm_execve=0A=
=A0=A0=A0=A0=A0 1.14 =B1 13%=A0=A0=A0=A0 +32.9=A0=A0=A0=A0=A0=A0 33.99 =B1=
=A0 3%=A0 perf-profile.children.cycles-pp.do_execveat_common=0A=
=A0=A0=A0=A0=A0 1.15 =B1 13%=A0=A0=A0=A0 +32.9=A0=A0=A0=A0=A0=A0 34.01 =B1=
=A0 3%=A0 perf-profile.children.cycles-pp.__x64_sys_execve=0A=
=A0=A0=A0=A0=A0 1.16 =B1=A0 3%=A0=A0=A0=A0 +41.8=A0=A0=A0=A0=A0=A0 42.98 =
=B1=A0 2%=A0 perf-profile.children.cycles-pp.path_openat=0A=
=A0=A0=A0=A0=A0 1.17 =B1=A0 3%=A0=A0=A0=A0 +41.8=A0=A0=A0=A0=A0=A0 42.98 =
=B1=A0 2%=A0 perf-profile.children.cycles-pp.do_filp_open=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +54.2=A0=A0=A0=A0=A0=A0 =
54.20 =B1=A0 2%=A0 perf-profile.children.cycles-pp.__cna_queued_spin_lock_s=
lowpath=0A=
=A0=A0=A0=A0 81.68=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -81.7=A0=A0=A0=A0=A0=A0=A0=
 0.00=A0=A0=A0=A0=A0=A0=A0 perf-profile.self.cycles-pp.native_queued_spin_l=
ock_slowpath=0A=
=A0=A0=A0=A0=A0 0.05 =B1=A0 8%=A0=A0=A0=A0=A0 +0.0=A0=A0=A0=A0=A0=A0=A0 0.0=
8 =B1 21%=A0 perf-profile.self.cycles-pp.ktime_get_update_offsets_now=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05=A0=A0=A0=A0=A0=A0=A0 perf-profile.self.cycles-pp.link_path_walk=
=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05=A0=A0=A0=A0=A0=A0=A0 perf-profile.self.cycles-pp.apparmor_task_=
getsecid=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05=A0=A0=A0=A0=A0=A0=A0 perf-profile.self.cycles-pp.page_add_file_=
rmap=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05=A0=A0=A0=A0=A0=A0=A0 perf-profile.self.cycles-pp.common_file_pe=
rm=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05=A0=A0=A0=A0=A0=A0=A0 perf-profile.self.cycles-pp.__list_del_ent=
ry_valid=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05=A0=A0=A0=A0=A0=A0=A0 perf-profile.self.cycles-pp.copy_page=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05=A0=A0=A0=A0=A0=A0=A0 perf-profile.self.cycles-pp._raw_spin_tryl=
ock=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05 =B1=A0 8%=A0 perf-profile.self.cycles-pp.__rb_insert_augmented=
=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.05 =B1=A0 8%=A0 perf-profile.self.cycles-pp.compar1=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06 =B1=A0 9%=A0 perf-profile.self.cycles-pp.__might_sleep=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06 =B1=A0 9%=A0 perf-profile.self.cycles-pp.sync_regs=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06 =B1 14%=A0 perf-profile.self.cycles-pp.__alloc_file=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06 =B1=A0 7%=A0 perf-profile.self.cycles-pp.kfree=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06=A0=A0=A0=A0=A0=A0=A0 perf-profile.self.cycles-pp.strnlen_user=
=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06=A0=A0=A0=A0=A0=A0=A0 perf-profile.self.cycles-pp.anon_vma_inter=
val_tree_insert=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06 =B1 11%=A0 perf-profile.self.cycles-pp.memcpy_erms=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.06 =B1=A0 6%=A0 perf-profile.self.cycles-pp.free_pages_and_swap_ca=
che=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1=A0 7%=A0 perf-profile.self.cycles-pp.filldir64=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1=A0 7%=A0 perf-profile.self.cycles-pp.rcu_sched_clock_irq=0A=
=A0=A0=A0=A0=A0 0.06 =B1 16%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.12 =
=B1=A0 3%=A0 perf-profile.self.cycles-pp.__d_lookup_rcu=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1=A0 6%=A0 perf-profile.self.cycles-pp.copy_pte_range=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1=A0 6%=A0 perf-profile.self.cycles-pp._raw_spin_lock_irqsave=
=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1 19%=A0 perf-profile.self.cycles-pp.file_free_rcu=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1 10%=A0 perf-profile.self.cycles-pp.rwsem_down_write_slowpat=
h=0A=
=A0=A0=A0=A0=A0 0.05 =B1=A0 8%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.1=
2 =B1=A0 4%=A0 perf-profile.self.cycles-pp.apparmor_file_open=0A=
=A0=A0=A0=A0=A0 0.05=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.12 =B1=A0 3%=A0 perf-profile.self.cycles-pp.apparmor_file_free_sec=
urity=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.07 =B1=A0 5%=A0 perf-profile.self.cycles-pp.vma_interval_tree_remo=
ve=0A=
=A0=A0=A0=A0=A0 0.07=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.15 =B1=A0 3%=A0 perf-profile.self.cycles-pp.native_irq_return_iret=
=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.08 =B1=A0 6%=A0 perf-profile.self.cycles-pp.__mod_memcg_state=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.08 =B1 11%=A0 perf-profile.self.cycles-pp.rcu_cblist_dequeue=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.08 =B1 14%=A0 perf-profile.self.cycles-pp.__handle_mm_fault=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.08 =B1=A0 5%=A0 perf-profile.self.cycles-pp.down_read=0A=
=A0=A0=A0=A0=A0 0.02 =B1141%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.10 =
=B1=A0 5%=A0 perf-profile.self.cycles-pp.up_write=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.08 =B1 13%=A0 perf-profile.self.cycles-pp.__slab_free=0A=
=A0=A0=A0=A0=A0 0.06 =B1=A0 8%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.1=
4 =B1=A0 8%=A0 perf-profile.self.cycles-pp.lockref_get_not_dead=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.08 =B1=A0 5%=A0 perf-profile.self.cycles-pp.clear_page_erms=0A=
=A0=A0=A0=A0=A0 0.03 =B1 70%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.12 =
=B1=A0 6%=A0 perf-profile.self.cycles-pp.down_write=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.09 =B1=A0 7%=A0 perf-profile.self.cycles-pp.malloc=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.09 =B1=A0 7%=A0 perf-profile.self.cycles-pp.aa_get_task_label=0A=
=A0=A0=A0=A0=A0 0.02 =B1141%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.11 =
=B1=A0 4%=A0 perf-profile.self.cycles-pp.___might_sleep=0A=
=A0=A0=A0=A0=A0 0.09 =B1 13%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.19 =
=B1 14%=A0 perf-profile.self.cycles-pp.update_cfs_group=0A=
=A0=A0=A0=A0=A0 0.06 =B1 13%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.15 =
=B1=A0 5%=A0 perf-profile.self.cycles-pp.page_remove_rmap=0A=
=A0=A0=A0=A0=A0 0.07 =B1 11%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.17 =
=B1=A0 2%=A0 perf-profile.self.cycles-pp.find_idlest_group=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.10 =B1=A0 4%=A0 perf-profile.self.cycles-pp.lockref_put_return=0A=
=A0=A0=A0=A0=A0 0.07 =B1=A0 7%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.1=
7 =B1=A0 6%=A0 perf-profile.self.cycles-pp.apparmor_file_alloc_security=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.11 =B1=A0 7%=A0 perf-profile.self.cycles-pp.update_sd_lb_stats=0A=
=A0=A0=A0=A0=A0 0.08 =B1 10%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.19 =
=B1=A0 3%=A0 perf-profile.self.cycles-pp.vma_interval_tree_insert=0A=
=A0=A0=A0=A0=A0 0.04 =B1 71%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.15 =
=B1=A0 5%=A0 perf-profile.self.cycles-pp.release_pages=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.12 =B1 13%=A0 perf-profile.self.cycles-pp.page_counter_uncharge=0A=
=A0=A0=A0=A0=A0 0.07 =B1 11%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.19 =
=B1=A0 2%=A0 perf-profile.self.cycles-pp._dl_addr=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=
=A0=A0 0.13 =B1=A0 3%=A0 perf-profile.self.cycles-pp.cna_order_queue=0A=
=A0=A0=A0=A0=A0 0.10 =B1=A0 8%=A0=A0=A0=A0=A0 +0.1=A0=A0=A0=A0=A0=A0=A0 0.2=
5 =B1=A0 2%=A0 perf-profile.self.cycles-pp.zap_pte_range=0A=
=A0=A0=A0=A0=A0 0.08 =B1 22%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.23 =
=B1=A0 4%=A0 perf-profile.self.cycles-pp.page_counter_try_charge=0A=
=A0=A0=A0=A0=A0 0.08 =B1 14%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.25 =
=B1=A0 2%=A0 perf-profile.self.cycles-pp.rwsem_spin_on_owner=0A=
=A0=A0=A0=A0=A0 0.21 =B1 20%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.40 =
=B1 11%=A0 perf-profile.self.cycles-pp.div_int=0A=
=A0=A0=A0=A0=A0 0.15 =B1=A0 9%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.3=
5 =B1 11%=A0 perf-profile.self.cycles-pp.mem_rtns_1=0A=
=A0=A0=A0=A0=A0 0.25 =B1 22%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.45 =
=B1 11%=A0 perf-profile.self.cycles-pp.div_short=0A=
=A0=A0=A0=A0=A0 0.22 =B1 19%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.45 =
=B1 10%=A0 perf-profile.self.cycles-pp.add_short=0A=
=A0=A0=A0=A0=A0 0.08 =B1 27%=A0=A0=A0=A0=A0 +0.2=A0=A0=A0=A0=A0=A0=A0 0.32 =
=B1=A0 4%=A0 perf-profile.self.cycles-pp.get_obj_cgroup_from_current=0A=
=A0=A0=A0=A0=A0 0.42 =B1=A0 2%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.6=
9 =B1=A0 2%=A0 perf-profile.self.cycles-pp._raw_spin_lock=0A=
=A0=A0=A0=A0=A0 0.22 =B1=A0 9%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.4=
9 =B1=A0 2%=A0 perf-profile.self.cycles-pp.filemap_map_pages=0A=
=A0=A0=A0=A0=A0 0.11 =B1 19%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.41 =
=B1=A0 3%=A0 perf-profile.self.cycles-pp.kmem_cache_alloc=0A=
=A0=A0=A0=A0=A0 0.07 =B1=A0 6%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.4=
0 =B1 10%=A0 perf-profile.self.cycles-pp.refill_obj_stock=0A=
=A0=A0=A0=A0=A0 0.28 =B1 14%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.60 =
=B1 11%=A0 perf-profile.self.cycles-pp.__strcat_chk=0A=
=A0=A0=A0=A0=A0 0.09 =B1 24%=A0=A0=A0=A0=A0 +0.3=A0=A0=A0=A0=A0=A0=A0 0.42 =
=B1 11%=A0 perf-profile.self.cycles-pp.propagate_protected_usage=0A=
=A0=A0=A0=A0=A0 0.07 =B1 11%=A0=A0=A0=A0=A0 +0.4=A0=A0=A0=A0=A0=A0=A0 0.46 =
=B1 10%=A0 perf-profile.self.cycles-pp.drain_obj_stock=0A=
=A0=A0=A0=A0=A0 0.49 =B1 19%=A0=A0=A0=A0=A0 +0.4=A0=A0=A0=A0=A0=A0=A0 0.92 =
=B1 10%=A0 perf-profile.self.cycles-pp.div_long=0A=
=A0=A0=A0=A0=A0 0.51 =B1 17%=A0=A0=A0=A0=A0 +0.5=A0=A0=A0=A0=A0=A0=A0 1.01 =
=B1=A0 8%=A0 perf-profile.self.cycles-pp.add_long=0A=
=A0=A0=A0=A0=A0 0.51 =B1 17%=A0=A0=A0=A0=A0 +0.5=A0=A0=A0=A0=A0=A0=A0 1.02 =
=B1=A0 9%=A0 perf-profile.self.cycles-pp.add_int=0A=
=A0=A0=A0=A0=A0 0.49 =B1 14%=A0=A0=A0=A0=A0 +0.6=A0=A0=A0=A0=A0=A0=A0 1.10 =
=B1 11%=A0 perf-profile.self.cycles-pp.__strncat_chk=0A=
=A0=A0=A0=A0=A0 0.26 =B1 21%=A0=A0=A0=A0=A0 +0.8=A0=A0=A0=A0=A0=A0=A0 1.04 =
=B1 12%=A0 perf-profile.self.cycles-pp.page_counter_cancel=0A=
=A0=A0=A0=A0=A0 1.66 =B1 14%=A0=A0=A0=A0=A0 +2.0=A0=A0=A0=A0=A0=A0=A0 3.65 =
=B1 10%=A0 perf-profile.self.cycles-pp.string_rtns_1=0A=
=A0=A0=A0=A0=A0 0.49 =B1 13%=A0=A0=A0=A0=A0 +2.6=A0=A0=A0=A0=A0=A0=A0 3.11 =
=B1=A0 9%=A0 perf-profile.self.cycles-pp.kmem_cache_free=0A=
=A0=A0=A0=A0=A0 2.93 =B1 19%=A0=A0=A0=A0=A0 +4.6=A0=A0=A0=A0=A0=A0=A0 7.50 =
=B1 22%=A0 perf-profile.self.cycles-pp.osq_lock=0A=
=A0=A0=A0=A0=A0 3.33 =B1 10%=A0=A0=A0=A0=A0 +6.0=A0=A0=A0=A0=A0=A0=A0 9.38 =
=B1 10%=A0 perf-profile.self.cycles-pp.intel_idle=0A=
=A0=A0=A0=A0=A0 0.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +53.4=A0=A0=A0=A0=A0=A0 =
53.38 =B1=A0 2%=A0 perf-profile.self.cycles-pp.__cna_queued_spin_lock_slowp=
ath=0A=
=A0=A0=A0=A0=A0 1579 =B1 53%=A0=A0=A0 +572.8%=A0=A0=A0=A0=A0 10624 =B1 82%=
=A0 interrupts.31:PCI-MSI.524289-edge.eth0-TxRx-0=0A=
=A0=A0=A0=A0=A0 1203 =B1112%=A0=A0=A0=A0 +61.3%=A0=A0=A0=A0=A0=A0 1940 =B1 =
68%=A0 interrupts.32:PCI-MSI.524290-edge.eth0-TxRx-1=0A=
=A0=A0=A0=A0=A0 8340 =B1 68%=A0=A0=A0=A0 -76.0%=A0=A0=A0=A0=A0=A0 2003 =B1 =
74%=A0 interrupts.34:PCI-MSI.524292-edge.eth0-TxRx-3=0A=
=A0=A0=A0 775419 =B1=A0 5%=A0=A0=A0=A0 +21.9%=A0=A0=A0=A0 944875 =B1=A0 2%=
=A0 interrupts.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5146 =B1=A0 4%=A0=A0=A0=A0 -51.2%=A0=A0=A0=A0=A0=A0 2512 =
=B1 34%=A0 interrupts.CPU0.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5146 =B1=A0 4%=A0=A0=A0=A0 -51.2%=A0=A0=A0=A0=A0=A0 2512 =
=B1 34%=A0 interrupts.CPU0.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0=A0=A0 1113 =B1=A0 8%=A0=A0=A0=A0 +13.1%=A0=A0=A0=A0=A0=A0 1259 =
=B1=A0 4%=A0 interrupts.CPU0.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 643.67 =B1=A0 4%=A0=A0=A0=A0 +53.6%=A0=A0=A0=A0 988.50 =B1=A0 7%=
=A0 interrupts.CPU0.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4043 =B1=A0 7%=A0=A0=A0=A0 +33.6%=A0=A0=A0=A0=A0=A0 5400 =
=B1=A0 5%=A0 interrupts.CPU1.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5177 =B1=A0 3%=A0=A0=A0=A0 -41.7%=A0=A0=A0=A0=A0=A0 3020 =
=B1 36%=A0 interrupts.CPU1.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5177 =B1=A0 3%=A0=A0=A0=A0 -41.7%=A0=A0=A0=A0=A0=A0 3020 =
=B1 36%=A0 interrupts.CPU1.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 735.33 =B1=A0 5%=A0=A0=A0=A0 +48.3%=A0=A0=A0=A0=A0=A0 1090 =B1=A0=
 8%=A0 interrupts.CPU1.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 562.00 =B1 12%=A0=A0=A0=A0 +47.5%=A0=A0=A0=A0 829.00 =B1=A0 6%=A0=
 interrupts.CPU1.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 1579 =B1 53%=A0=A0=A0 +572.8%=A0=A0=A0=A0=A0 10624 =B1 82%=
=A0 interrupts.CPU10.31:PCI-MSI.524289-edge.eth0-TxRx-0=0A=
=A0=A0=A0=A0=A0 3821 =B1=A0 7%=A0=A0=A0=A0 +28.3%=A0=A0=A0=A0=A0=A0 4903 =
=B1=A0 6%=A0 interrupts.CPU10.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5187 =B1=A0 4%=A0=A0=A0=A0 -23.5%=A0=A0=A0=A0=A0=A0 3968 =
=B1=A0 5%=A0 interrupts.CPU10.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5187 =B1=A0 4%=A0=A0=A0=A0 -23.5%=A0=A0=A0=A0=A0=A0 3968 =
=B1=A0 5%=A0 interrupts.CPU10.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 738.67 =B1=A0 5%=A0=A0=A0=A0 +48.7%=A0=A0=A0=A0=A0=A0 1098 =B1=A0=
 4%=A0 interrupts.CPU10.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 522.00 =B1 33%=A0=A0=A0=A0 +72.4%=A0=A0=A0=A0 900.00 =B1 10%=A0 i=
nterrupts.CPU10.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3934 =B1=A0 9%=A0=A0=A0=A0 +24.9%=A0=A0=A0=A0=A0=A0 4913 =
=B1=A0 6%=A0 interrupts.CPU100.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5204 =B1=A0 3%=A0=A0=A0=A0 -24.7%=A0=A0=A0=A0=A0=A0 3916 =
=B1=A0 8%=A0 interrupts.CPU100.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5204 =B1=A0 3%=A0=A0=A0=A0 -24.7%=A0=A0=A0=A0=A0=A0 3916 =
=B1=A0 8%=A0 interrupts.CPU100.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 743.67 =B1=A0 7%=A0=A0=A0=A0 +61.4%=A0=A0=A0=A0=A0=A0 1200 =B1=A0=
 9%=A0 interrupts.CPU100.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 474.00 =B1 14%=A0=A0=A0=A0 +91.8%=A0=A0=A0=A0 909.00 =B1 12%=A0 i=
nterrupts.CPU100.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3945 =B1=A0 4%=A0=A0=A0=A0 +24.3%=A0=A0=A0=A0=A0=A0 4901 =
=B1=A0 4%=A0 interrupts.CPU101.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5197 =B1=A0 3%=A0=A0=A0=A0 -36.2%=A0=A0=A0=A0=A0=A0 3313 =
=B1 26%=A0 interrupts.CPU101.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5197 =B1=A0 3%=A0=A0=A0=A0 -36.2%=A0=A0=A0=A0=A0=A0 3313 =
=B1 26%=A0 interrupts.CPU101.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 720.33 =B1=A0 5%=A0=A0=A0=A0 +60.8%=A0=A0=A0=A0=A0=A0 1158 =B1=A0=
 7%=A0 interrupts.CPU101.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 496.67 =B1=A0 7%=A0=A0=A0=A0 +82.6%=A0=A0=A0=A0 906.75 =B1 15%=A0=
 interrupts.CPU101.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3918 =B1=A0 5%=A0=A0=A0=A0 +22.8%=A0=A0=A0=A0=A0=A0 4810 =
=B1=A0 6%=A0 interrupts.CPU102.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5186 =B1=A0 4%=A0=A0=A0=A0 -25.2%=A0=A0=A0=A0=A0=A0 3879 =
=B1 10%=A0 interrupts.CPU102.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5186 =B1=A0 4%=A0=A0=A0=A0 -25.2%=A0=A0=A0=A0=A0=A0 3879 =
=B1 10%=A0 interrupts.CPU102.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 699.33 =B1=A0 3%=A0=A0=A0=A0 +61.8%=A0=A0=A0=A0=A0=A0 1131 =B1=A0=
 7%=A0 interrupts.CPU102.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 406.33 =B1=A0 7%=A0=A0=A0 +108.2%=A0=A0=A0=A0 846.00 =B1 12%=A0 i=
nterrupts.CPU102.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3882 =B1=A0 5%=A0=A0=A0=A0 +26.2%=A0=A0=A0=A0=A0=A0 4897 =
=B1=A0 4%=A0 interrupts.CPU103.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5224 =B1=A0 3%=A0=A0=A0=A0 -34.9%=A0=A0=A0=A0=A0=A0 3399 =
=B1 26%=A0 interrupts.CPU103.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5224 =B1=A0 3%=A0=A0=A0=A0 -34.9%=A0=A0=A0=A0=A0=A0 3399 =
=B1 26%=A0 interrupts.CPU103.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 658.33 =B1=A0 4%=A0=A0=A0=A0 +73.4%=A0=A0=A0=A0=A0=A0 1141 =B1=A0=
 5%=A0 interrupts.CPU103.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 449.00 =B1 16%=A0=A0=A0=A0 +89.6%=A0=A0=A0=A0 851.50 =B1=A0 8%=A0=
 interrupts.CPU103.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3881 =B1=A0 3%=A0=A0=A0=A0 +23.9%=A0=A0=A0=A0=A0=A0 4807 =
=B1=A0 3%=A0 interrupts.CPU104.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5212 =B1=A0 3%=A0=A0=A0=A0 -26.6%=A0=A0=A0=A0=A0=A0 3826 =
=B1=A0 8%=A0 interrupts.CPU104.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5212 =B1=A0 3%=A0=A0=A0=A0 -26.6%=A0=A0=A0=A0=A0=A0 3826 =
=B1=A0 8%=A0 interrupts.CPU104.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 637.67 =B1=A0 7%=A0=A0=A0=A0 +73.6%=A0=A0=A0=A0=A0=A0 1106 =B1=A0=
 9%=A0 interrupts.CPU104.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 423.33 =B1=A0 7%=A0=A0=A0=A0 +90.1%=A0=A0=A0=A0 804.75 =B1 14%=A0=
 interrupts.CPU104.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3845=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +20.2%=A0=A0=A0=A0=A0=A0=
 4623=A0=A0=A0=A0=A0=A0=A0 interrupts.CPU105.CAL:Function_call_interrupts=
=0A=
=A0=A0=A0 661.33 =B1=A0 8%=A0=A0=A0=A0 +68.5%=A0=A0=A0=A0=A0=A0 1114 =B1=A0=
 2%=A0 interrupts.CPU105.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 467.33 =B1 17%=A0=A0=A0=A0 +87.6%=A0=A0=A0=A0 876.50 =B1 21%=A0 i=
nterrupts.CPU105.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3959 =B1=A0 4%=A0=A0=A0=A0 +18.2%=A0=A0=A0=A0=A0=A0 4679=A0=
=A0=A0=A0=A0=A0=A0 interrupts.CPU106.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5251 =B1=A0 3%=A0=A0=A0=A0 -25.6%=A0=A0=A0=A0=A0=A0 3905 =
=B1 10%=A0 interrupts.CPU106.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5251 =B1=A0 3%=A0=A0=A0=A0 -25.6%=A0=A0=A0=A0=A0=A0 3905 =
=B1 10%=A0 interrupts.CPU106.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 721.33 =B1=A0 5%=A0=A0=A0=A0 +59.2%=A0=A0=A0=A0=A0=A0 1148 =B1=A0=
 8%=A0 interrupts.CPU106.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 419.00 =B1 15%=A0=A0=A0 +150.8%=A0=A0=A0=A0=A0=A0 1050 =B1 30%=A0=
 interrupts.CPU106.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3930 =B1=A0 5%=A0=A0=A0=A0 +18.9%=A0=A0=A0=A0=A0=A0 4674 =
=B1=A0 4%=A0 interrupts.CPU107.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5177 =B1=A0 5%=A0=A0=A0=A0 -34.4%=A0=A0=A0=A0=A0=A0 3398 =
=B1 26%=A0 interrupts.CPU107.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5177 =B1=A0 5%=A0=A0=A0=A0 -34.4%=A0=A0=A0=A0=A0=A0 3398 =
=B1 26%=A0 interrupts.CPU107.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 665.33 =B1=A0 5%=A0=A0=A0=A0 +75.8%=A0=A0=A0=A0=A0=A0 1169 =B1=A0=
 4%=A0 interrupts.CPU107.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 445.00 =B1 18%=A0=A0=A0=A0 +83.9%=A0=A0=A0=A0 818.50 =B1 13%=A0 i=
nterrupts.CPU107.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3915 =B1=A0 8%=A0=A0=A0=A0 +20.9%=A0=A0=A0=A0=A0=A0 4735 =
=B1=A0 3%=A0 interrupts.CPU108.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5255 =B1=A0 3%=A0=A0=A0=A0 -36.2%=A0=A0=A0=A0=A0=A0 3350 =
=B1 25%=A0 interrupts.CPU108.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5255 =B1=A0 3%=A0=A0=A0=A0 -36.2%=A0=A0=A0=A0=A0=A0 3350 =
=B1 25%=A0 interrupts.CPU108.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 684.33 =B1=A0 7%=A0=A0=A0=A0 +67.5%=A0=A0=A0=A0=A0=A0 1146 =B1=A0=
 7%=A0 interrupts.CPU108.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 509.00 =B1 11%=A0=A0=A0=A0 +66.4%=A0=A0=A0=A0 846.75 =B1=A0 6%=A0=
 interrupts.CPU108.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3965 =B1=A0 3%=A0=A0=A0=A0 +19.8%=A0=A0=A0=A0=A0=A0 4749 =
=B1=A0 4%=A0 interrupts.CPU109.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5207 =B1=A0 3%=A0=A0=A0=A0 -42.8%=A0=A0=A0=A0=A0=A0 2976 =
=B1 38%=A0 interrupts.CPU109.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5207 =B1=A0 3%=A0=A0=A0=A0 -42.8%=A0=A0=A0=A0=A0=A0 2976 =
=B1 38%=A0 interrupts.CPU109.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 701.00 =B1=A0 4%=A0=A0=A0=A0 +55.2%=A0=A0=A0=A0=A0=A0 1087 =B1=A0=
 5%=A0 interrupts.CPU109.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 510.33 =B1 11%=A0=A0=A0=A0 +71.9%=A0=A0=A0=A0 877.25 =B1=A0 6%=A0=
 interrupts.CPU109.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 1203 =B1112%=A0=A0=A0=A0 +61.3%=A0=A0=A0=A0=A0=A0 1940 =B1 =
68%=A0 interrupts.CPU11.32:PCI-MSI.524290-edge.eth0-TxRx-1=0A=
=A0=A0=A0=A0=A0 3794 =B1=A0 5%=A0=A0=A0=A0 +31.8%=A0=A0=A0=A0=A0=A0 4999 =
=B1=A0 4%=A0 interrupts.CPU11.CAL:Function_call_interrupts=0A=
=A0=A0=A0 734.33 =B1=A0 6%=A0=A0=A0=A0 +51.7%=A0=A0=A0=A0=A0=A0 1114 =B1=A0=
 3%=A0 interrupts.CPU11.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 458.67 =B1 14%=A0=A0=A0 +100.9%=A0=A0=A0=A0 921.50 =B1 10%=A0 int=
errupts.CPU11.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3949 =B1=A0 5%=A0=A0=A0=A0 +27.3%=A0=A0=A0=A0=A0=A0 5029 =
=B1=A0 4%=A0 interrupts.CPU110.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5230 =B1=A0 3%=A0=A0=A0=A0 -35.3%=A0=A0=A0=A0=A0=A0 3385 =
=B1 24%=A0 interrupts.CPU110.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5230 =B1=A0 3%=A0=A0=A0=A0 -35.3%=A0=A0=A0=A0=A0=A0 3385 =
=B1 24%=A0 interrupts.CPU110.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 670.67 =B1=A0 6%=A0=A0=A0=A0 +74.5%=A0=A0=A0=A0=A0=A0 1170 =B1=A0=
 7%=A0 interrupts.CPU110.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 442.00 =B1=A0 8%=A0=A0=A0=A0 +88.5%=A0=A0=A0=A0 833.00 =B1 18%=A0=
 interrupts.CPU110.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3865 =B1=A0 4%=A0=A0=A0=A0 +24.2%=A0=A0=A0=A0=A0=A0 4802 =
=B1=A0 4%=A0 interrupts.CPU111.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5230 =B1=A0 3%=A0=A0=A0=A0 -36.3%=A0=A0=A0=A0=A0=A0 3330 =
=B1 25%=A0 interrupts.CPU111.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5230 =B1=A0 3%=A0=A0=A0=A0 -36.3%=A0=A0=A0=A0=A0=A0 3330 =
=B1 25%=A0 interrupts.CPU111.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 634.00 =B1=A0 9%=A0=A0=A0=A0 +85.7%=A0=A0=A0=A0=A0=A0 1177 =B1 10=
%=A0 interrupts.CPU111.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 441.33 =B1 13%=A0=A0=A0=A0 +96.4%=A0=A0=A0=A0 866.75 =B1 14%=A0 i=
nterrupts.CPU111.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3873 =B1=A0 5%=A0=A0=A0=A0 +24.7%=A0=A0=A0=A0=A0=A0 4829 =
=B1=A0 2%=A0 interrupts.CPU112.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5121 =B1=A0 4%=A0=A0=A0=A0 -35.0%=A0=A0=A0=A0=A0=A0 3326 =
=B1 24%=A0 interrupts.CPU112.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5121 =B1=A0 4%=A0=A0=A0=A0 -35.0%=A0=A0=A0=A0=A0=A0 3326 =
=B1 24%=A0 interrupts.CPU112.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 669.00 =B1=A0 2%=A0=A0=A0=A0 +72.3%=A0=A0=A0=A0=A0=A0 1152 =B1=A0=
 7%=A0 interrupts.CPU112.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 430.00 =B1=A0 2%=A0=A0=A0 +111.9%=A0=A0=A0=A0 911.00 =B1 15%=A0 i=
nterrupts.CPU112.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3921 =B1=A0 6%=A0=A0=A0=A0 +24.6%=A0=A0=A0=A0=A0=A0 4885 =
=B1=A0 3%=A0 interrupts.CPU113.CAL:Function_call_interrupts=0A=
=A0=A0=A0 672.33 =B1=A0 8%=A0=A0=A0=A0 +70.0%=A0=A0=A0=A0=A0=A0 1142 =B1=A0=
 7%=A0 interrupts.CPU113.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 431.33 =B1=A0 9%=A0=A0=A0=A0 +98.2%=A0=A0=A0=A0 855.00 =B1 11%=A0=
 interrupts.CPU113.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3779 =B1=A0 7%=A0=A0=A0=A0 +27.7%=A0=A0=A0=A0=A0=A0 4827 =
=B1=A0 4%=A0 interrupts.CPU114.CAL:Function_call_interrupts=0A=
=A0=A0=A0 641.00 =B1 13%=A0=A0=A0=A0 +79.3%=A0=A0=A0=A0=A0=A0 1149 =B1=A0 4=
%=A0 interrupts.CPU114.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 504.00 =B1 10%=A0=A0=A0=A0 +77.2%=A0=A0=A0=A0 893.25 =B1 20%=A0 i=
nterrupts.CPU114.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3904 =B1=A0 6%=A0=A0=A0=A0 +20.2%=A0=A0=A0=A0=A0=A0 4693=A0=
=A0=A0=A0=A0=A0=A0 interrupts.CPU115.CAL:Function_call_interrupts=0A=
=A0=A0=A0 651.67 =B1=A0 3%=A0=A0=A0=A0 +78.9%=A0=A0=A0=A0=A0=A0 1165 =B1=A0=
 2%=A0 interrupts.CPU115.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 501.67 =B1 29%=A0=A0=A0=A0 +69.9%=A0=A0=A0=A0 852.50 =B1=A0 4%=A0=
 interrupts.CPU115.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3818 =B1=A0 3%=A0=A0=A0=A0 +23.2%=A0=A0=A0=A0=A0=A0 4703=A0=
=A0=A0=A0=A0=A0=A0 interrupts.CPU116.CAL:Function_call_interrupts=0A=
=A0=A0=A0 630.67 =B1=A0 7%=A0=A0=A0=A0 +81.6%=A0=A0=A0=A0=A0=A0 1145 =B1=A0=
 6%=A0 interrupts.CPU116.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 439.67 =B1 14%=A0=A0=A0=A0 +98.7%=A0=A0=A0=A0 873.50 =B1 15%=A0 i=
nterrupts.CPU116.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4154 =B1=A0 4%=A0=A0=A0=A0 +13.8%=A0=A0=A0=A0=A0=A0 4728=A0=
=A0=A0=A0=A0=A0=A0 interrupts.CPU117.CAL:Function_call_interrupts=0A=
=A0=A0=A0 650.67 =B1=A0 8%=A0=A0=A0=A0 +70.7%=A0=A0=A0=A0=A0=A0 1110 =B1=A0=
 6%=A0 interrupts.CPU117.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 502.33 =B1 12%=A0=A0=A0=A0 +77.0%=A0=A0=A0=A0 889.00 =B1 10%=A0 i=
nterrupts.CPU117.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3947 =B1=A0 5%=A0=A0=A0=A0 +21.6%=A0=A0=A0=A0=A0=A0 4798 =
=B1=A0 5%=A0 interrupts.CPU118.CAL:Function_call_interrupts=0A=
=A0=A0=A0 659.33=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +71.4%=A0=A0=A0=A0=A0=A0 113=
0 =B1=A0 4%=A0 interrupts.CPU118.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 464.67 =B1 11%=A0=A0=A0=A0 +84.5%=A0=A0=A0=A0 857.25 =B1=A0 9%=A0=
 interrupts.CPU118.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4065 =B1=A0 4%=A0=A0=A0=A0 +19.6%=A0=A0=A0=A0=A0=A0 4860 =
=B1=A0 5%=A0 interrupts.CPU119.CAL:Function_call_interrupts=0A=
=A0=A0=A0 614.00 =B1=A0 8%=A0=A0=A0=A0 +82.9%=A0=A0=A0=A0=A0=A0 1123 =B1=A0=
 4%=A0 interrupts.CPU119.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 480.33 =B1=A0 8%=A0=A0=A0=A0 +74.6%=A0=A0=A0=A0 838.50 =B1=A0 8%=
=A0 interrupts.CPU119.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4011 =B1=A0 3%=A0=A0=A0=A0 +20.9%=A0=A0=A0=A0=A0=A0 4848 =
=B1=A0 7%=A0 interrupts.CPU12.CAL:Function_call_interrupts=0A=
=A0=A0=A0 769.33 =B1=A0 2%=A0=A0=A0=A0 +44.1%=A0=A0=A0=A0=A0=A0 1108 =B1=A0=
 8%=A0 interrupts.CPU12.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 502.00 =B1=A0 4%=A0=A0=A0=A0 +96.4%=A0=A0=A0=A0 986.00 =B1 12%=A0=
 interrupts.CPU12.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4091 =B1=A0 4%=A0=A0=A0=A0 +22.3%=A0=A0=A0=A0=A0=A0 5003 =
=B1=A0 3%=A0 interrupts.CPU120.CAL:Function_call_interrupts=0A=
=A0=A0=A0 717.33 =B1=A0 9%=A0=A0=A0=A0 +64.2%=A0=A0=A0=A0=A0=A0 1177 =B1=A0=
 6%=A0 interrupts.CPU120.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 459.67 =B1 14%=A0=A0=A0 +103.1%=A0=A0=A0=A0 933.50 =B1 15%=A0 int=
errupts.CPU120.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3923 =B1=A0 4%=A0=A0=A0=A0 +25.2%=A0=A0=A0=A0=A0=A0 4913 =
=B1=A0 3%=A0 interrupts.CPU121.CAL:Function_call_interrupts=0A=
=A0=A0=A0 617.33 =B1=A0 3%=A0=A0=A0=A0 +89.4%=A0=A0=A0=A0=A0=A0 1169 =B1=A0=
 4%=A0 interrupts.CPU121.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 401.67 =B1 22%=A0=A0=A0 +195.5%=A0=A0=A0=A0=A0=A0 1186 =B1 39%=A0=
 interrupts.CPU121.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3867 =B1=A0 4%=A0=A0=A0=A0 +34.9%=A0=A0=A0=A0=A0=A0 5218 =
=B1=A0 4%=A0 interrupts.CPU122.CAL:Function_call_interrupts=0A=
=A0=A0=A0 596.67 =B1=A0 8%=A0=A0=A0 +100.9%=A0=A0=A0=A0=A0=A0 1198 =B1=A0 5=
%=A0 interrupts.CPU122.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 450.00 =B1 16%=A0=A0=A0 +109.0%=A0=A0=A0=A0 940.50 =B1=A0 6%=A0 i=
nterrupts.CPU122.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4031 =B1=A0 8%=A0=A0=A0=A0 +23.2%=A0=A0=A0=A0=A0=A0 4967 =
=B1=A0 3%=A0 interrupts.CPU123.CAL:Function_call_interrupts=0A=
=A0=A0=A0 628.00 =B1=A0 4%=A0=A0=A0=A0 +94.1%=A0=A0=A0=A0=A0=A0 1218 =B1=A0=
 7%=A0 interrupts.CPU123.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 474.67 =B1 13%=A0=A0=A0=A0 +96.1%=A0=A0=A0=A0 931.00 =B1 12%=A0 i=
nterrupts.CPU123.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4232 =B1=A0 4%=A0=A0=A0=A0 +20.3%=A0=A0=A0=A0=A0=A0 5090 =
=B1=A0 3%=A0 interrupts.CPU124.CAL:Function_call_interrupts=0A=
=A0=A0=A0 639.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +82.9%=A0=A0=A0=A0=A0=A0 116=
8 =B1=A0 7%=A0 interrupts.CPU124.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 463.33 =B1 17%=A0=A0=A0 +110.1%=A0=A0=A0=A0 973.25 =B1 11%=A0 int=
errupts.CPU124.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3972=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +21.5%=A0=A0=A0=A0=A0=A0=
 4826 =B1=A0 3%=A0 interrupts.CPU125.CAL:Function_call_interrupts=0A=
=A0=A0=A0 658.67 =B1=A0 8%=A0=A0=A0=A0 +78.4%=A0=A0=A0=A0=A0=A0 1175 =B1=A0=
 4%=A0 interrupts.CPU125.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 480.00 =B1 13%=A0=A0=A0=A0 +96.0%=A0=A0=A0=A0 940.75 =B1 23%=A0 i=
nterrupts.CPU125.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4093 =B1=A0 3%=A0=A0=A0=A0 +20.8%=A0=A0=A0=A0=A0=A0 4947 =
=B1=A0 4%=A0 interrupts.CPU126.CAL:Function_call_interrupts=0A=
=A0=A0=A0 672.67 =B1=A0 5%=A0=A0=A0=A0 +75.9%=A0=A0=A0=A0=A0=A0 1183 =B1=A0=
 2%=A0 interrupts.CPU126.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 498.00 =B1 10%=A0=A0=A0=A0 +90.0%=A0=A0=A0=A0 946.25 =B1 11%=A0 i=
nterrupts.CPU126.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4111 =B1=A0 5%=A0=A0=A0=A0 +20.8%=A0=A0=A0=A0=A0=A0 4965 =
=B1=A0 5%=A0 interrupts.CPU127.CAL:Function_call_interrupts=0A=
=A0=A0=A0 613.67 =B1=A0 2%=A0=A0=A0=A0 +95.2%=A0=A0=A0=A0=A0=A0 1198 =B1=A0=
 5%=A0 interrupts.CPU127.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 451.67 =B1 21%=A0=A0=A0 +109.8%=A0=A0=A0=A0 947.50 =B1 14%=A0 int=
errupts.CPU127.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4066=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +20.3%=A0=A0=A0=A0=A0=A0=
 4891 =B1=A0 3%=A0 interrupts.CPU128.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5200 =B1=A0 2%=A0=A0=A0=A0 -23.3%=A0=A0=A0=A0=A0=A0 3986 =
=B1=A0 9%=A0 interrupts.CPU128.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5200 =B1=A0 2%=A0=A0=A0=A0 -23.3%=A0=A0=A0=A0=A0=A0 3986 =
=B1=A0 9%=A0 interrupts.CPU128.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 663.33 =B1=A0 4%=A0=A0=A0=A0 +74.6%=A0=A0=A0=A0=A0=A0 1158 =B1=A0=
 6%=A0 interrupts.CPU128.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 472.33 =B1 17%=A0=A0=A0 +102.4%=A0=A0=A0=A0 956.00 =B1=A0 8%=A0 i=
nterrupts.CPU128.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4075 =B1=A0 8%=A0=A0=A0=A0 +20.3%=A0=A0=A0=A0=A0=A0 4900=A0=
=A0=A0=A0=A0=A0=A0 interrupts.CPU129.CAL:Function_call_interrupts=0A=
=A0=A0=A0 640.33 =B1=A0 2%=A0=A0=A0=A0 +73.2%=A0=A0=A0=A0=A0=A0 1108 =B1=A0=
 8%=A0 interrupts.CPU129.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 445.33 =B1 19%=A0=A0=A0 +113.4%=A0=A0=A0=A0 950.25 =B1 11%=A0 int=
errupts.CPU129.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 8340 =B1 68%=A0=A0=A0=A0 -76.0%=A0=A0=A0=A0=A0=A0 2003 =B1 =
74%=A0 interrupts.CPU13.34:PCI-MSI.524292-edge.eth0-TxRx-3=0A=
=A0=A0=A0=A0=A0 4049 =B1=A0 7%=A0=A0=A0=A0 +20.6%=A0=A0=A0=A0=A0=A0 4885 =
=B1=A0 2%=A0 interrupts.CPU13.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5130 =B1=A0 3%=A0=A0=A0=A0 -24.2%=A0=A0=A0=A0=A0=A0 3886 =
=B1=A0 5%=A0 interrupts.CPU13.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5130 =B1=A0 3%=A0=A0=A0=A0 -24.2%=A0=A0=A0=A0=A0=A0 3886 =
=B1=A0 5%=A0 interrupts.CPU13.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 724.00 =B1=A0 5%=A0=A0=A0=A0 +57.8%=A0=A0=A0=A0=A0=A0 1142 =B1=A0=
 5%=A0 interrupts.CPU13.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 532.67 =B1 23%=A0=A0=A0=A0 +70.5%=A0=A0=A0=A0 908.25 =B1 12%=A0 i=
nterrupts.CPU13.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3881 =B1=A0 6%=A0=A0=A0=A0 +30.0%=A0=A0=A0=A0=A0=A0 5044 =
=B1=A0 4%=A0 interrupts.CPU130.CAL:Function_call_interrupts=0A=
=A0=A0=A0 621.33 =B1 10%=A0=A0=A0=A0 +89.4%=A0=A0=A0=A0=A0=A0 1176 =B1=A0 8=
%=A0 interrupts.CPU130.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 516.33 =B1 16%=A0=A0=A0=A0 +92.9%=A0=A0=A0=A0 996.25 =B1 15%=A0 i=
nterrupts.CPU130.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4035 =B1=A0 2%=A0=A0=A0=A0 +22.0%=A0=A0=A0=A0=A0=A0 4923 =
=B1=A0 3%=A0 interrupts.CPU131.CAL:Function_call_interrupts=0A=
=A0=A0=A0 661.67 =B1=A0 7%=A0=A0=A0=A0 +69.5%=A0=A0=A0=A0=A0=A0 1121 =B1=A0=
 4%=A0 interrupts.CPU131.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 425.67 =B1 11%=A0=A0=A0 +116.8%=A0=A0=A0=A0 922.75 =B1 15%=A0 int=
errupts.CPU131.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4345 =B1=A0 3%=A0=A0=A0=A0 +13.3%=A0=A0=A0=A0=A0=A0 4924 =
=B1=A0 5%=A0 interrupts.CPU132.CAL:Function_call_interrupts=0A=
=A0=A0=A0 694.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +68.9%=A0=A0=A0=A0=A0=A0 117=
2 =B1=A0 5%=A0 interrupts.CPU132.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 476.00 =B1 11%=A0=A0=A0=A0 +94.5%=A0=A0=A0=A0 926.00 =B1 13%=A0 i=
nterrupts.CPU132.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4091 =B1=A0 7%=A0=A0=A0=A0 +22.7%=A0=A0=A0=A0=A0=A0 5018 =
=B1=A0 4%=A0 interrupts.CPU133.CAL:Function_call_interrupts=0A=
=A0=A0=A0 663.67 =B1=A0 6%=A0=A0=A0=A0 +68.6%=A0=A0=A0=A0=A0=A0 1119 =B1=A0=
 4%=A0 interrupts.CPU133.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 534.33 =B1=A0 9%=A0=A0=A0=A0 +78.7%=A0=A0=A0=A0 954.75 =B1 13%=A0=
 interrupts.CPU133.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3856 =B1=A0 7%=A0=A0=A0=A0 +26.7%=A0=A0=A0=A0=A0=A0 4886 =
=B1=A0 3%=A0 interrupts.CPU134.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5199 =B1=A0 2%=A0=A0=A0=A0 -34.5%=A0=A0=A0=A0=A0=A0 3406 =
=B1 24%=A0 interrupts.CPU134.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5199 =B1=A0 2%=A0=A0=A0=A0 -34.5%=A0=A0=A0=A0=A0=A0 3406 =
=B1 24%=A0 interrupts.CPU134.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 667.00 =B1 13%=A0=A0=A0=A0 +74.7%=A0=A0=A0=A0=A0=A0 1165 =B1=A0 6=
%=A0 interrupts.CPU134.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 447.33 =B1=A0 9%=A0=A0=A0 +116.7%=A0=A0=A0=A0 969.25 =B1=A0 3%=A0=
 interrupts.CPU134.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4120 =B1 11%=A0=A0=A0=A0 +18.6%=A0=A0=A0=A0=A0=A0 4886 =B1=
=A0 3%=A0 interrupts.CPU135.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5233 =B1=A0 3%=A0=A0=A0=A0 -24.8%=A0=A0=A0=A0=A0=A0 3934 =
=B1=A0 9%=A0 interrupts.CPU135.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5233 =B1=A0 3%=A0=A0=A0=A0 -24.8%=A0=A0=A0=A0=A0=A0 3934 =
=B1=A0 9%=A0 interrupts.CPU135.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 643.67 =B1=A0 5%=A0=A0=A0=A0 +81.8%=A0=A0=A0=A0=A0=A0 1170 =B1=A0=
 7%=A0 interrupts.CPU135.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 490.00 =B1 17%=A0=A0=A0=A0 +88.4%=A0=A0=A0=A0 923.00 =B1 18%=A0 i=
nterrupts.CPU135.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4092 =B1=A0 3%=A0=A0=A0=A0 +22.8%=A0=A0=A0=A0=A0=A0 5026 =
=B1=A0 3%=A0 interrupts.CPU136.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5225 =B1=A0 3%=A0=A0=A0=A0 -34.3%=A0=A0=A0=A0=A0=A0 3430 =
=B1 26%=A0 interrupts.CPU136.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5225 =B1=A0 3%=A0=A0=A0=A0 -34.3%=A0=A0=A0=A0=A0=A0 3430 =
=B1 26%=A0 interrupts.CPU136.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 673.33 =B1=A0 4%=A0=A0=A0=A0 +80.6%=A0=A0=A0=A0=A0=A0 1216 =B1=A0=
 4%=A0 interrupts.CPU136.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 488.00 =B1=A0 8%=A0=A0=A0=A0 +87.9%=A0=A0=A0=A0 916.75 =B1 13%=A0=
 interrupts.CPU136.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4234 =B1=A0 9%=A0=A0=A0=A0 +16.3%=A0=A0=A0=A0=A0=A0 4925 =
=B1=A0 4%=A0 interrupts.CPU137.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5217 =B1=A0 4%=A0=A0=A0=A0 -34.5%=A0=A0=A0=A0=A0=A0 3418 =
=B1 24%=A0 interrupts.CPU137.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5217 =B1=A0 4%=A0=A0=A0=A0 -34.5%=A0=A0=A0=A0=A0=A0 3418 =
=B1 24%=A0 interrupts.CPU137.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 625.33 =B1 14%=A0=A0=A0=A0 +87.5%=A0=A0=A0=A0=A0=A0 1172 =B1=A0 6=
%=A0 interrupts.CPU137.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 441.67 =B1 10%=A0=A0=A0 +115.5%=A0=A0=A0=A0 951.75 =B1 13%=A0 int=
errupts.CPU137.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3987 =B1=A0 6%=A0=A0=A0=A0 +23.1%=A0=A0=A0=A0=A0=A0 4907 =
=B1=A0 2%=A0 interrupts.CPU138.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5218 =B1=A0 3%=A0=A0=A0=A0 -42.7%=A0=A0=A0=A0=A0=A0 2992 =
=B1 38%=A0 interrupts.CPU138.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5218 =B1=A0 3%=A0=A0=A0=A0 -42.7%=A0=A0=A0=A0=A0=A0 2992 =
=B1 38%=A0 interrupts.CPU138.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 672.33 =B1=A0 3%=A0=A0=A0=A0 +76.5%=A0=A0=A0=A0=A0=A0 1186 =B1=A0=
 4%=A0 interrupts.CPU138.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 439.67 =B1=A0 8%=A0=A0=A0 +113.4%=A0=A0=A0=A0 938.25 =B1 11%=A0 i=
nterrupts.CPU138.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4040 =B1=A0 7%=A0=A0=A0=A0 +23.1%=A0=A0=A0=A0=A0=A0 4973 =
=B1=A0 4%=A0 interrupts.CPU139.CAL:Function_call_interrupts=0A=
=A0=A0=A0 635.33 =B1=A0 3%=A0=A0=A0=A0 +85.3%=A0=A0=A0=A0=A0=A0 1177 =B1=A0=
 7%=A0 interrupts.CPU139.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 425.33 =B1 17%=A0=A0=A0 +110.7%=A0=A0=A0=A0 896.00 =B1 10%=A0 int=
errupts.CPU139.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3920 =B1=A0 2%=A0=A0=A0=A0 +21.7%=A0=A0=A0=A0=A0=A0 4771 =
=B1=A0 2%=A0 interrupts.CPU14.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5123 =B1=A0 4%=A0=A0=A0=A0 -43.3%=A0=A0=A0=A0=A0=A0 2903 =
=B1 30%=A0 interrupts.CPU14.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5123 =B1=A0 4%=A0=A0=A0=A0 -43.3%=A0=A0=A0=A0=A0=A0 2903 =
=B1 30%=A0 interrupts.CPU14.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 725.00 =B1 12%=A0=A0=A0=A0 +56.2%=A0=A0=A0=A0=A0=A0 1132 =B1=A0 6=
%=A0 interrupts.CPU14.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 402.00 =B1=A0 6%=A0=A0=A0 +110.0%=A0=A0=A0=A0 844.25 =B1 10%=A0 i=
nterrupts.CPU14.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4006 =B1 11%=A0=A0=A0=A0 +19.8%=A0=A0=A0=A0=A0=A0 4800 =B1=
=A0 3%=A0 interrupts.CPU140.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5230 =B1=A0 3%=A0=A0=A0=A0 -24.8%=A0=A0=A0=A0=A0=A0 3932 =
=B1 10%=A0 interrupts.CPU140.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5230 =B1=A0 3%=A0=A0=A0=A0 -24.8%=A0=A0=A0=A0=A0=A0 3932 =
=B1 10%=A0 interrupts.CPU140.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 578.33 =B1=A0 3%=A0=A0=A0 +102.5%=A0=A0=A0=A0=A0=A0 1171 =B1=A0 5=
%=A0 interrupts.CPU140.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 506.00 =B1=A0 5%=A0=A0=A0=A0 +90.3%=A0=A0=A0=A0 963.00 =B1 11%=A0=
 interrupts.CPU140.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4080 =B1=A0 6%=A0=A0=A0=A0 +25.8%=A0=A0=A0=A0=A0=A0 5131 =
=B1=A0 7%=A0 interrupts.CPU141.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5148 =B1=A0 4%=A0=A0=A0=A0 -33.6%=A0=A0=A0=A0=A0=A0 3418 =
=B1 25%=A0 interrupts.CPU141.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5148 =B1=A0 4%=A0=A0=A0=A0 -33.6%=A0=A0=A0=A0=A0=A0 3418 =
=B1 25%=A0 interrupts.CPU141.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 695.00 =B1=A0 3%=A0=A0=A0=A0 +74.7%=A0=A0=A0=A0=A0=A0 1214 =B1=A0=
 7%=A0 interrupts.CPU141.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 503.33 =B1 23%=A0=A0=A0 +150.9%=A0=A0=A0=A0=A0=A0 1263 =B1 44%=A0=
 interrupts.CPU141.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4155 =B1=A0 8%=A0=A0=A0=A0 +16.6%=A0=A0=A0=A0=A0=A0 4843 =
=B1=A0 4%=A0 interrupts.CPU142.CAL:Function_call_interrupts=0A=
=A0=A0=A0 638.00 =B1=A0 6%=A0=A0=A0=A0 +82.1%=A0=A0=A0=A0=A0=A0 1161 =B1=A0=
 6%=A0 interrupts.CPU142.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 509.33 =B1=A0 8%=A0=A0=A0=A0 +89.0%=A0=A0=A0=A0 962.50 =B1 14%=A0=
 interrupts.CPU142.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4018 =B1=A0 6%=A0=A0=A0=A0 +24.3%=A0=A0=A0=A0=A0=A0 4993=A0=
=A0=A0=A0=A0=A0=A0 interrupts.CPU143.CAL:Function_call_interrupts=0A=
=A0=A0=A0 643.67 =B1=A0 2%=A0=A0=A0=A0 +86.6%=A0=A0=A0=A0=A0=A0 1201 =B1=A0=
 8%=A0 interrupts.CPU143.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 553.67 =B1=A0 7%=A0=A0=A0=A0 +83.0%=A0=A0=A0=A0=A0=A0 1013 =B1 10=
%=A0 interrupts.CPU143.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3990 =B1=A0 5%=A0=A0=A0=A0 +25.0%=A0=A0=A0=A0=A0=A0 4989 =
=B1=A0 4%=A0 interrupts.CPU144.CAL:Function_call_interrupts=0A=
=A0=A0=A0 654.00 =B1 10%=A0=A0=A0=A0 +78.0%=A0=A0=A0=A0=A0=A0 1164 =B1=A0 4=
%=A0 interrupts.CPU144.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 415.33 =B1=A0 4%=A0=A0=A0 +124.9%=A0=A0=A0=A0 934.25 =B1=A0 9%=A0=
 interrupts.CPU144.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3875 =B1=A0 3%=A0=A0=A0=A0 +30.5%=A0=A0=A0=A0=A0=A0 5056 =
=B1=A0 6%=A0 interrupts.CPU145.CAL:Function_call_interrupts=0A=
=A0=A0=A0 647.00 =B1 13%=A0=A0=A0=A0 +79.9%=A0=A0=A0=A0=A0=A0 1163 =B1=A0 4=
%=A0 interrupts.CPU145.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 445.67 =B1 16%=A0=A0=A0 +112.7%=A0=A0=A0=A0 947.75 =B1 12%=A0 int=
errupts.CPU145.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3891 =B1=A0 7%=A0=A0=A0=A0 +24.8%=A0=A0=A0=A0=A0=A0 4857 =
=B1=A0 5%=A0 interrupts.CPU146.CAL:Function_call_interrupts=0A=
=A0=A0=A0 635.00 =B1=A0 6%=A0=A0=A0=A0 +80.7%=A0=A0=A0=A0=A0=A0 1147 =B1=A0=
 5%=A0 interrupts.CPU146.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 438.67 =B1 11%=A0=A0=A0 +127.1%=A0=A0=A0=A0 996.25 =B1 10%=A0 int=
errupts.CPU146.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3899 =B1=A0 7%=A0=A0=A0=A0 +28.0%=A0=A0=A0=A0=A0=A0 4990 =
=B1=A0 4%=A0 interrupts.CPU147.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5189 =B1=A0 3%=A0=A0=A0=A0 -24.6%=A0=A0=A0=A0=A0=A0 3915 =
=B1 10%=A0 interrupts.CPU147.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5189 =B1=A0 3%=A0=A0=A0=A0 -24.6%=A0=A0=A0=A0=A0=A0 3915 =
=B1 10%=A0 interrupts.CPU147.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 643.33=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +80.3%=A0=A0=A0=A0=A0=A0 116=
0 =B1=A0 2%=A0 interrupts.CPU147.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 430.00 =B1 16%=A0=A0=A0 +116.9%=A0=A0=A0=A0 932.50 =B1 17%=A0 int=
errupts.CPU147.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4129 =B1 12%=A0=A0=A0=A0 +18.4%=A0=A0=A0=A0=A0=A0 4889=A0=
=A0=A0=A0=A0=A0=A0 interrupts.CPU148.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5219 =B1=A0 3%=A0=A0=A0=A0 -24.7%=A0=A0=A0=A0=A0=A0 3932 =
=B1=A0 9%=A0 interrupts.CPU148.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5219 =B1=A0 3%=A0=A0=A0=A0 -24.7%=A0=A0=A0=A0=A0=A0 3932 =
=B1=A0 9%=A0 interrupts.CPU148.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 588.33 =B1=A0 7%=A0=A0=A0=A0 +93.6%=A0=A0=A0=A0=A0=A0 1139 =B1=A0=
 5%=A0 interrupts.CPU148.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 501.00 =B1 16%=A0=A0=A0=A0 +78.7%=A0=A0=A0=A0 895.25 =B1=A0 8%=A0=
 interrupts.CPU148.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4186 =B1=A0 9%=A0=A0=A0=A0 +18.3%=A0=A0=A0=A0=A0=A0 4953 =
=B1=A0 3%=A0 interrupts.CPU149.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5185 =B1=A0 4%=A0=A0=A0=A0 -32.3%=A0=A0=A0=A0=A0=A0 3509 =
=B1 31%=A0 interrupts.CPU149.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5185 =B1=A0 4%=A0=A0=A0=A0 -32.3%=A0=A0=A0=A0=A0=A0 3509 =
=B1 31%=A0 interrupts.CPU149.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 638.67=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +70.9%=A0=A0=A0=A0=A0=A0 109=
1 =B1=A0 2%=A0 interrupts.CPU149.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 558.33 =B1 15%=A0=A0=A0=A0 +71.8%=A0=A0=A0=A0 959.25 =B1=A0 7%=A0=
 interrupts.CPU149.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3912 =B1=A0 6%=A0=A0=A0=A0 +21.4%=A0=A0=A0=A0=A0=A0 4750 =
=B1=A0 4%=A0 interrupts.CPU15.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5197 =B1=A0 3%=A0=A0=A0=A0 -22.8%=A0=A0=A0=A0=A0=A0 4013 =
=B1=A0 4%=A0 interrupts.CPU15.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5197 =B1=A0 3%=A0=A0=A0=A0 -22.8%=A0=A0=A0=A0=A0=A0 4013 =
=B1=A0 4%=A0 interrupts.CPU15.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 776.33 =B1=A0 7%=A0=A0=A0=A0 +39.1%=A0=A0=A0=A0=A0=A0 1080 =B1=A0=
 6%=A0 interrupts.CPU15.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 473.00 =B1 12%=A0=A0=A0=A0 +98.5%=A0=A0=A0=A0 938.75 =B1 11%=A0 i=
nterrupts.CPU15.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4178 =B1=A0 9%=A0=A0=A0=A0 +18.1%=A0=A0=A0=A0=A0=A0 4936 =
=B1=A0 4%=A0 interrupts.CPU150.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5192 =B1=A0 4%=A0=A0=A0=A0 -25.4%=A0=A0=A0=A0=A0=A0 3873 =
=B1 10%=A0 interrupts.CPU150.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5192 =B1=A0 4%=A0=A0=A0=A0 -25.4%=A0=A0=A0=A0=A0=A0 3873 =
=B1 10%=A0 interrupts.CPU150.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 678.67 =B1=A0 8%=A0=A0=A0=A0 +64.3%=A0=A0=A0=A0=A0=A0 1115 =B1=A0=
 5%=A0 interrupts.CPU150.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 513.33 =B1 28%=A0=A0=A0=A0 +73.6%=A0=A0=A0=A0 891.00 =B1 21%=A0 i=
nterrupts.CPU150.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4052 =B1=A0 6%=A0=A0=A0=A0 +21.9%=A0=A0=A0=A0=A0=A0 4939 =
=B1=A0 3%=A0 interrupts.CPU151.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5260 =B1=A0 3%=A0=A0=A0=A0 -25.8%=A0=A0=A0=A0=A0=A0 3903 =
=B1 10%=A0 interrupts.CPU151.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5260 =B1=A0 3%=A0=A0=A0=A0 -25.8%=A0=A0=A0=A0=A0=A0 3903 =
=B1 10%=A0 interrupts.CPU151.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 623.33 =B1=A0 3%=A0=A0=A0=A0 +86.9%=A0=A0=A0=A0=A0=A0 1164 =B1=A0=
 4%=A0 interrupts.CPU151.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 484.67 =B1 11%=A0=A0=A0=A0 +98.0%=A0=A0=A0=A0 959.50 =B1=A0 8%=A0=
 interrupts.CPU151.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3982 =B1=A0 8%=A0=A0=A0=A0 +25.1%=A0=A0=A0=A0=A0=A0 4982 =
=B1=A0 4%=A0 interrupts.CPU152.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5183 =B1=A0 2%=A0=A0=A0=A0 -32.9%=A0=A0=A0=A0=A0=A0 3475 =
=B1 26%=A0 interrupts.CPU152.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5183 =B1=A0 2%=A0=A0=A0=A0 -32.9%=A0=A0=A0=A0=A0=A0 3475 =
=B1 26%=A0 interrupts.CPU152.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 623.33 =B1=A0 5%=A0=A0=A0=A0 +79.5%=A0=A0=A0=A0=A0=A0 1119 =B1=A0=
 2%=A0 interrupts.CPU152.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 494.00 =B1 14%=A0=A0=A0=A0 +89.7%=A0=A0=A0=A0 937.25 =B1=A0 9%=A0=
 interrupts.CPU152.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4109 =B1=A0 6%=A0=A0=A0=A0 +24.9%=A0=A0=A0=A0=A0=A0 5131 =
=B1 10%=A0 interrupts.CPU153.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5179 =B1=A0 4%=A0=A0=A0=A0 -31.7%=A0=A0=A0=A0=A0=A0 3536 =
=B1 31%=A0 interrupts.CPU153.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5179 =B1=A0 4%=A0=A0=A0=A0 -31.7%=A0=A0=A0=A0=A0=A0 3536 =
=B1 31%=A0 interrupts.CPU153.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 614.67 =B1=A0 3%=A0=A0=A0=A0 +94.8%=A0=A0=A0=A0=A0=A0 1197 =B1=A0=
 9%=A0 interrupts.CPU153.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 486.00 =B1 19%=A0=A0=A0=A0 +83.9%=A0=A0=A0=A0 893.75 =B1 13%=A0 i=
nterrupts.CPU153.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4161 =B1=A0 5%=A0=A0=A0=A0 +16.5%=A0=A0=A0=A0=A0=A0 4846 =
=B1=A0 2%=A0 interrupts.CPU154.CAL:Function_call_interrupts=0A=
=A0=A0=A0 635.33 =B1=A0 3%=A0=A0=A0=A0 +74.6%=A0=A0=A0=A0=A0=A0 1109 =B1=A0=
 3%=A0 interrupts.CPU154.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 490.67 =B1 21%=A0=A0=A0=A0 +87.4%=A0=A0=A0=A0 919.50 =B1=A0 8%=A0=
 interrupts.CPU154.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3946 =B1=A0 8%=A0=A0=A0=A0 +28.2%=A0=A0=A0=A0=A0=A0 5057 =
=B1=A0 2%=A0 interrupts.CPU155.CAL:Function_call_interrupts=0A=
=A0=A0=A0 631.33 =B1=A0 9%=A0=A0=A0=A0 +78.6%=A0=A0=A0=A0=A0=A0 1127 =B1=A0=
 3%=A0 interrupts.CPU155.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 489.33 =B1 17%=A0=A0=A0 +107.9%=A0=A0=A0=A0=A0=A0 1017 =B1 11%=A0=
 interrupts.CPU155.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4028 =B1=A0 5%=A0=A0=A0=A0 +21.3%=A0=A0=A0=A0=A0=A0 4887 =
=B1=A0 4%=A0 interrupts.CPU156.CAL:Function_call_interrupts=0A=
=A0=A0=A0 627.33 =B1=A0 2%=A0=A0=A0=A0 +82.2%=A0=A0=A0=A0=A0=A0 1142 =B1=A0=
 2%=A0 interrupts.CPU156.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 452.33 =B1 14%=A0=A0=A0 +113.0%=A0=A0=A0=A0 963.25 =B1 15%=A0 int=
errupts.CPU156.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3893 =B1=A0 8%=A0=A0=A0=A0 +28.2%=A0=A0=A0=A0=A0=A0 4993 =
=B1=A0 4%=A0 interrupts.CPU157.CAL:Function_call_interrupts=0A=
=A0=A0=A0 637.33=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +80.4%=A0=A0=A0=A0=A0=A0 114=
9 =B1=A0 4%=A0 interrupts.CPU157.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 451.67 =B1 20%=A0=A0=A0 +105.6%=A0=A0=A0=A0 928.50 =B1 11%=A0 int=
errupts.CPU157.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4155 =B1=A0 9%=A0=A0=A0=A0 +19.6%=A0=A0=A0=A0=A0=A0 4971 =
=B1=A0 4%=A0 interrupts.CPU158.CAL:Function_call_interrupts=0A=
=A0=A0=A0 628.33 =B1=A0 6%=A0=A0=A0=A0 +75.8%=A0=A0=A0=A0=A0=A0 1104 =B1=A0=
 2%=A0 interrupts.CPU158.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 468.33 =B1 11%=A0=A0=A0 +103.4%=A0=A0=A0=A0 952.50 =B1 11%=A0 int=
errupts.CPU158.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3965 =B1=A0 8%=A0=A0=A0=A0 +23.8%=A0=A0=A0=A0=A0=A0 4910 =
=B1=A0 5%=A0 interrupts.CPU159.CAL:Function_call_interrupts=0A=
=A0=A0=A0 597.33 =B1=A0 4%=A0=A0=A0=A0 +95.2%=A0=A0=A0=A0=A0=A0 1166 =B1=A0=
 2%=A0 interrupts.CPU159.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 436.00 =B1 12%=A0=A0=A0 +121.7%=A0=A0=A0=A0 966.50 =B1 11%=A0 int=
errupts.CPU159.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3811 =B1=A0 3%=A0=A0=A0=A0 +28.3%=A0=A0=A0=A0=A0=A0 4890 =
=B1=A0 6%=A0 interrupts.CPU16.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5211 =B1=A0 3%=A0=A0=A0=A0 -24.1%=A0=A0=A0=A0=A0=A0 3953 =
=B1=A0 5%=A0 interrupts.CPU16.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5211 =B1=A0 3%=A0=A0=A0=A0 -24.1%=A0=A0=A0=A0=A0=A0 3953 =
=B1=A0 5%=A0 interrupts.CPU16.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 726.67 =B1=A0 6%=A0=A0=A0=A0 +55.9%=A0=A0=A0=A0=A0=A0 1132 =B1=A0=
 7%=A0 interrupts.CPU16.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 505.67 =B1 13%=A0=A0=A0=A0 +75.1%=A0=A0=A0=A0 885.50 =B1 12%=A0 i=
nterrupts.CPU16.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3965 =B1=A0 8%=A0=A0=A0=A0 +24.8%=A0=A0=A0=A0=A0=A0 4948 =
=B1=A0 6%=A0 interrupts.CPU160.CAL:Function_call_interrupts=0A=
=A0=A0=A0 636.67 =B1=A0 4%=A0=A0=A0=A0 +74.8%=A0=A0=A0=A0=A0=A0 1113 =B1=A0=
 2%=A0 interrupts.CPU160.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 516.67 =B1 17%=A0=A0=A0=A0 +88.3%=A0=A0=A0=A0 973.00 =B1 14%=A0 i=
nterrupts.CPU160.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4054 =B1=A0 8%=A0=A0=A0=A0 +24.2%=A0=A0=A0=A0=A0=A0 5036 =
=B1=A0 4%=A0 interrupts.CPU161.CAL:Function_call_interrupts=0A=
=A0=A0=A0 601.00 =B1=A0 6%=A0=A0=A0=A0 +89.6%=A0=A0=A0=A0=A0=A0 1139 =B1=A0=
 3%=A0 interrupts.CPU161.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 514.33 =B1 13%=A0=A0=A0=A0 +81.9%=A0=A0=A0=A0 935.50 =B1 12%=A0 i=
nterrupts.CPU161.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4039 =B1 11%=A0=A0=A0=A0 +19.7%=A0=A0=A0=A0=A0=A0 4836 =B1=
=A0 3%=A0 interrupts.CPU162.CAL:Function_call_interrupts=0A=
=A0=A0=A0 643.33 =B1=A0 7%=A0=A0=A0=A0 +67.2%=A0=A0=A0=A0=A0=A0 1075=A0=A0=
=A0=A0=A0=A0=A0 interrupts.CPU162.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 469.33 =B1 18%=A0=A0=A0 +107.1%=A0=A0=A0=A0 972.00 =B1=A0 8%=A0 i=
nterrupts.CPU162.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4022 =B1=A0 7%=A0=A0=A0=A0 +20.9%=A0=A0=A0=A0=A0=A0 4864 =
=B1=A0 3%=A0 interrupts.CPU163.CAL:Function_call_interrupts=0A=
=A0=A0=A0 609.33 =B1=A0 3%=A0=A0=A0=A0 +92.5%=A0=A0=A0=A0=A0=A0 1172=A0=A0=
=A0=A0=A0=A0=A0 interrupts.CPU163.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 431.00 =B1 18%=A0=A0=A0 +146.3%=A0=A0=A0=A0=A0=A0 1061 =B1=A0 6%=
=A0 interrupts.CPU163.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4036=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +20.7%=A0=A0=A0=A0=A0=A0=
 4869 =B1=A0 4%=A0 interrupts.CPU164.CAL:Function_call_interrupts=0A=
=A0=A0=A0 613.00 =B1=A0 4%=A0=A0=A0=A0 +86.4%=A0=A0=A0=A0=A0=A0 1142 =B1=A0=
 6%=A0 interrupts.CPU164.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 492.33 =B1 19%=A0=A0=A0=A0 +87.9%=A0=A0=A0=A0 925.25 =B1 10%=A0 i=
nterrupts.CPU164.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3957 =B1=A0 3%=A0=A0=A0=A0 +23.4%=A0=A0=A0=A0=A0=A0 4883 =
=B1=A0 4%=A0 interrupts.CPU165.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 4307 =B1 27%=A0=A0=A0=A0 -42.1%=A0=A0=A0=A0=A0=A0 2492 =B1 =
41%=A0 interrupts.CPU165.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 4307 =B1 27%=A0=A0=A0=A0 -42.1%=A0=A0=A0=A0=A0=A0 2492 =B1 =
41%=A0 interrupts.CPU165.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 583.00 =B1 10%=A0=A0=A0=A0 +88.9%=A0=A0=A0=A0=A0=A0 1101 =B1=A0 3=
%=A0 interrupts.CPU165.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 449.00 =B1 22%=A0=A0=A0 +108.7%=A0=A0=A0=A0 937.25 =B1 13%=A0 int=
errupts.CPU165.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4219 =B1=A0 5%=A0=A0=A0=A0 +16.9%=A0=A0=A0=A0=A0=A0 4932 =
=B1=A0 4%=A0 interrupts.CPU166.CAL:Function_call_interrupts=0A=
=A0=A0=A0 624.33 =B1=A0 4%=A0=A0=A0=A0 +76.9%=A0=A0=A0=A0=A0=A0 1104 =B1=A0=
 5%=A0 interrupts.CPU166.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 484.33 =B1 17%=A0=A0=A0 +100.6%=A0=A0=A0=A0 971.50 =B1 17%=A0 int=
errupts.CPU166.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4064 =B1 10%=A0=A0=A0=A0 +21.0%=A0=A0=A0=A0=A0=A0 4918 =B1=
=A0 3%=A0 interrupts.CPU167.CAL:Function_call_interrupts=0A=
=A0=A0=A0 616.67 =B1=A0 6%=A0=A0=A0=A0 +83.5%=A0=A0=A0=A0=A0=A0 1131 =B1=A0=
 4%=A0 interrupts.CPU167.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 452.00 =B1 12%=A0=A0=A0=A0 +95.7%=A0=A0=A0=A0 884.50 =B1=A0 8%=A0=
 interrupts.CPU167.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4087 =B1=A0 6%=A0=A0=A0=A0 +19.4%=A0=A0=A0=A0=A0=A0 4879 =
=B1=A0 6%=A0 interrupts.CPU168.CAL:Function_call_interrupts=0A=
=A0=A0=A0 649.67=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +69.1%=A0=A0=A0=A0=A0=A0 109=
8 =B1=A0 4%=A0 interrupts.CPU168.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 478.33 =B1=A0 6%=A0=A0=A0=A0 +92.4%=A0=A0=A0=A0 920.50 =B1 12%=A0=
 interrupts.CPU168.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3753 =B1=A0 7%=A0=A0=A0=A0 +20.6%=A0=A0=A0=A0=A0=A0 4524 =
=B1=A0 4%=A0 interrupts.CPU169.CAL:Function_call_interrupts=0A=
=A0=A0=A0 585.67=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +81.9%=A0=A0=A0=A0=A0=A0 106=
5 =B1=A0 2%=A0 interrupts.CPU169.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 459.00 =B1=A0 4%=A0=A0=A0 +104.2%=A0=A0=A0=A0 937.50 =B1=A0 3%=A0=
 interrupts.CPU169.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3764 =B1=A0 5%=A0=A0=A0=A0 +28.6%=A0=A0=A0=A0=A0=A0 4841 =
=B1=A0 3%=A0 interrupts.CPU17.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5198 =B1=A0 3%=A0=A0=A0=A0 -43.0%=A0=A0=A0=A0=A0=A0 2964 =
=B1 35%=A0 interrupts.CPU17.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5198 =B1=A0 3%=A0=A0=A0=A0 -43.0%=A0=A0=A0=A0=A0=A0 2964 =
=B1 35%=A0 interrupts.CPU17.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 729.33 =B1=A0 5%=A0=A0=A0=A0 +52.1%=A0=A0=A0=A0=A0=A0 1109 =B1=A0=
 7%=A0 interrupts.CPU17.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 450.67 =B1 10%=A0=A0=A0 +104.4%=A0=A0=A0=A0 921.25 =B1=A0 7%=A0 i=
nterrupts.CPU17.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4099 =B1=A0 8%=A0=A0=A0=A0 +24.8%=A0=A0=A0=A0=A0=A0 5118 =
=B1=A0 5%=A0 interrupts.CPU170.CAL:Function_call_interrupts=0A=
=A0=A0=A0 590.67 =B1=A0 7%=A0=A0=A0=A0 +91.4%=A0=A0=A0=A0=A0=A0 1130=A0=A0=
=A0=A0=A0=A0=A0 interrupts.CPU170.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 552.33 =B1 17%=A0=A0=A0=A0 +75.9%=A0=A0=A0=A0 971.75 =B1 10%=A0 i=
nterrupts.CPU170.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4023 =B1=A0 8%=A0=A0=A0=A0 +19.5%=A0=A0=A0=A0=A0=A0 4808=A0=
=A0=A0=A0=A0=A0=A0 interrupts.CPU171.CAL:Function_call_interrupts=0A=
=A0=A0=A0 594.67 =B1=A0 7%=A0=A0=A0=A0 +82.6%=A0=A0=A0=A0=A0=A0 1085 =B1=A0=
 5%=A0 interrupts.CPU171.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 468.33 =B1 13%=A0=A0=A0=A0 +94.0%=A0=A0=A0=A0 908.75 =B1=A0 7%=A0=
 interrupts.CPU171.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3917 =B1=A0 9%=A0=A0=A0=A0 +25.0%=A0=A0=A0=A0=A0=A0 4895 =
=B1=A0 5%=A0 interrupts.CPU172.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5248 =B1=A0 3%=A0=A0=A0=A0 -25.4%=A0=A0=A0=A0=A0=A0 3915 =
=B1 10%=A0 interrupts.CPU172.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5248 =B1=A0 3%=A0=A0=A0=A0 -25.4%=A0=A0=A0=A0=A0=A0 3915 =
=B1 10%=A0 interrupts.CPU172.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 543.00 =B1=A0 3%=A0=A0=A0 +103.6%=A0=A0=A0=A0=A0=A0 1105 =B1=A0 5=
%=A0 interrupts.CPU172.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 468.67 =B1 15%=A0=A0=A0=A0 +94.0%=A0=A0=A0=A0 909.25 =B1 17%=A0 i=
nterrupts.CPU172.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4057 =B1=A0 6%=A0=A0=A0=A0 +22.6%=A0=A0=A0=A0=A0=A0 4975 =
=B1=A0 2%=A0 interrupts.CPU173.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5158 =B1=A0 5%=A0=A0=A0=A0 -31.7%=A0=A0=A0=A0=A0=A0 3521 =
=B1 31%=A0 interrupts.CPU173.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5158 =B1=A0 5%=A0=A0=A0=A0 -31.7%=A0=A0=A0=A0=A0=A0 3521 =
=B1 31%=A0 interrupts.CPU173.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 597.67 =B1=A0 5%=A0=A0=A0=A0 +87.9%=A0=A0=A0=A0=A0=A0 1123 =B1=A0=
 3%=A0 interrupts.CPU173.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 498.67 =B1 19%=A0=A0=A0 +133.2%=A0=A0=A0=A0=A0=A0 1163 =B1 26%=A0=
 interrupts.CPU173.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3833 =B1=A0 8%=A0=A0=A0=A0 +26.8%=A0=A0=A0=A0=A0=A0 4859 =
=B1=A0 3%=A0 interrupts.CPU174.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5208 =B1=A0 4%=A0=A0=A0=A0 -24.7%=A0=A0=A0=A0=A0=A0 3920 =
=B1 11%=A0 interrupts.CPU174.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5208 =B1=A0 4%=A0=A0=A0=A0 -24.7%=A0=A0=A0=A0=A0=A0 3920 =
=B1 11%=A0 interrupts.CPU174.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 570.67 =B1=A0 2%=A0=A0=A0=A0 +91.1%=A0=A0=A0=A0=A0=A0 1090 =B1=A0=
 7%=A0 interrupts.CPU174.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 470.00 =B1 19%=A0=A0=A0 +108.3%=A0=A0=A0=A0 979.00 =B1 12%=A0 int=
errupts.CPU174.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4117 =B1=A0 7%=A0=A0=A0=A0 +17.7%=A0=A0=A0=A0=A0=A0 4845 =
=B1=A0 3%=A0 interrupts.CPU175.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5202 =B1=A0 4%=A0=A0=A0=A0 -25.1%=A0=A0=A0=A0=A0=A0 3896 =
=B1=A0 8%=A0 interrupts.CPU175.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5202 =B1=A0 4%=A0=A0=A0=A0 -25.1%=A0=A0=A0=A0=A0=A0 3896 =
=B1=A0 8%=A0 interrupts.CPU175.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 638.33 =B1=A0 3%=A0=A0=A0=A0 +70.8%=A0=A0=A0=A0=A0=A0 1090 =B1=A0=
 5%=A0 interrupts.CPU175.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 463.00 =B1 17%=A0=A0=A0 +104.4%=A0=A0=A0=A0 946.50 =B1=A0 8%=A0 i=
nterrupts.CPU175.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4021 =B1=A0 4%=A0=A0=A0=A0 +16.9%=A0=A0=A0=A0=A0=A0 4699 =
=B1=A0 2%=A0 interrupts.CPU176.CAL:Function_call_interrupts=0A=
=A0=A0=A0 608.67 =B1=A0 6%=A0=A0=A0=A0 +79.4%=A0=A0=A0=A0=A0=A0 1091 =B1=A0=
 6%=A0 interrupts.CPU176.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 477.33 =B1 10%=A0=A0=A0=A0 +97.2%=A0=A0=A0=A0 941.50 =B1=A0 7%=A0=
 interrupts.CPU176.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4071 =B1=A0 7%=A0=A0=A0=A0 +15.5%=A0=A0=A0=A0=A0=A0 4702=A0=
=A0=A0=A0=A0=A0=A0 interrupts.CPU177.CAL:Function_call_interrupts=0A=
=A0=A0=A0 596.33 =B1=A0 4%=A0=A0=A0=A0 +82.2%=A0=A0=A0=A0=A0=A0 1086=A0=A0=
=A0=A0=A0=A0=A0 interrupts.CPU177.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 435.00 =B1=A0 5%=A0=A0=A0 +114.7%=A0=A0=A0=A0 934.00 =B1 14%=A0 i=
nterrupts.CPU177.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4130 =B1=A0 7%=A0=A0=A0=A0 +16.6%=A0=A0=A0=A0=A0=A0 4815 =
=B1=A0 4%=A0 interrupts.CPU178.CAL:Function_call_interrupts=0A=
=A0=A0=A0 633.33 =B1=A0 4%=A0=A0=A0=A0 +64.1%=A0=A0=A0=A0=A0=A0 1039 =B1=A0=
 4%=A0 interrupts.CPU178.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 478.67 =B1 15%=A0=A0=A0=A0 +95.2%=A0=A0=A0=A0 934.50 =B1 19%=A0 i=
nterrupts.CPU178.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3821 =B1=A0 4%=A0=A0=A0=A0 +26.8%=A0=A0=A0=A0=A0=A0 4846 =
=B1=A0 3%=A0 interrupts.CPU179.CAL:Function_call_interrupts=0A=
=A0=A0=A0 594.67=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +76.6%=A0=A0=A0=A0=A0=A0 105=
0 =B1=A0 4%=A0 interrupts.CPU179.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 479.00 =B1=A0 7%=A0=A0=A0=A0 +96.5%=A0=A0=A0=A0 941.00 =B1=A0 6%=
=A0 interrupts.CPU179.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4196 =B1=A0 4%=A0=A0=A0=A0 +16.5%=A0=A0=A0=A0=A0=A0 4890 =
=B1=A0 5%=A0 interrupts.CPU18.CAL:Function_call_interrupts=0A=
=A0=A0=A0 728.33=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +51.1%=A0=A0=A0=A0=A0=A0 110=
0 =B1=A0 3%=A0 interrupts.CPU18.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 506.00 =B1 11%=A0=A0=A0=A0 +71.7%=A0=A0=A0=A0 868.75 =B1=A0 6%=A0=
 interrupts.CPU18.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3950 =B1=A0 6%=A0=A0=A0=A0 +23.3%=A0=A0=A0=A0=A0=A0 4870 =
=B1=A0 2%=A0 interrupts.CPU180.CAL:Function_call_interrupts=0A=
=A0=A0=A0 606.33 =B1=A0 8%=A0=A0=A0=A0 +72.5%=A0=A0=A0=A0=A0=A0 1045 =B1=A0=
 2%=A0 interrupts.CPU180.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 498.00 =B1=A0 5%=A0=A0=A0=A0 +72.3%=A0=A0=A0=A0 858.00 =B1 17%=A0=
 interrupts.CPU180.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4113 =B1 11%=A0=A0=A0=A0 +18.3%=A0=A0=A0=A0=A0=A0 4864 =B1=
=A0 5%=A0 interrupts.CPU181.CAL:Function_call_interrupts=0A=
=A0=A0=A0 620.33 =B1=A0 4%=A0=A0=A0=A0 +73.7%=A0=A0=A0=A0=A0=A0 1077 =B1=A0=
 5%=A0 interrupts.CPU181.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 483.33 =B1=A0 5%=A0=A0=A0=A0 +90.3%=A0=A0=A0=A0 919.75 =B1 11%=A0=
 interrupts.CPU181.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4070 =B1=A0 8%=A0=A0=A0=A0 +17.0%=A0=A0=A0=A0=A0=A0 4761 =
=B1=A0 2%=A0 interrupts.CPU182.CAL:Function_call_interrupts=0A=
=A0=A0=A0 588.00 =B1=A0 7%=A0=A0=A0=A0 +82.8%=A0=A0=A0=A0=A0=A0 1075 =B1=A0=
 3%=A0 interrupts.CPU182.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 480.00 =B1 17%=A0=A0=A0 +124.7%=A0=A0=A0=A0=A0=A0 1078 =B1 10%=A0=
 interrupts.CPU182.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4198 =B1=A0 7%=A0=A0=A0=A0 +15.9%=A0=A0=A0=A0=A0=A0 4868 =
=B1=A0 2%=A0 interrupts.CPU183.CAL:Function_call_interrupts=0A=
=A0=A0=A0 681.33 =B1=A0 6%=A0=A0=A0=A0 +59.5%=A0=A0=A0=A0=A0=A0 1087 =B1=A0=
 6%=A0 interrupts.CPU183.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 509.33 =B1 16%=A0=A0=A0=A0 +78.5%=A0=A0=A0=A0 909.00 =B1 15%=A0 i=
nterrupts.CPU183.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3955 =B1=A0 2%=A0=A0=A0=A0 +25.7%=A0=A0=A0=A0=A0=A0 4970 =
=B1=A0 3%=A0 interrupts.CPU184.CAL:Function_call_interrupts=0A=
=A0=A0=A0 565.00 =B1=A0 6%=A0=A0=A0=A0 +93.8%=A0=A0=A0=A0=A0=A0 1095 =B1=A0=
 6%=A0 interrupts.CPU184.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 443.67 =B1 14%=A0=A0=A0 +107.0%=A0=A0=A0=A0 918.25 =B1=A0 9%=A0 i=
nterrupts.CPU184.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4105 =B1=A0 6%=A0=A0=A0=A0 +16.5%=A0=A0=A0=A0=A0=A0 4781 =
=B1=A0 5%=A0 interrupts.CPU185.CAL:Function_call_interrupts=0A=
=A0=A0=A0 546.67 =B1=A0 5%=A0=A0=A0 +105.8%=A0=A0=A0=A0=A0=A0 1125 =B1=A0 7=
%=A0 interrupts.CPU185.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 505.00 =B1 18%=A0=A0=A0=A0 +86.8%=A0=A0=A0=A0 943.50 =B1=A0 8%=A0=
 interrupts.CPU185.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4067 =B1=A0 6%=A0=A0=A0=A0 +19.9%=A0=A0=A0=A0=A0=A0 4878 =
=B1=A0 3%=A0 interrupts.CPU186.CAL:Function_call_interrupts=0A=
=A0=A0=A0 604.67 =B1=A0 6%=A0=A0=A0=A0 +71.2%=A0=A0=A0=A0=A0=A0 1035 =B1=A0=
 7%=A0 interrupts.CPU186.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 486.67 =B1 12%=A0=A0=A0=A0 +89.7%=A0=A0=A0=A0 923.25 =B1=A0 8%=A0=
 interrupts.CPU186.TLB:TLB_shootdowns=0A=
=A0=A0=A0 588.00 =B1=A0 6%=A0=A0=A0=A0 +77.9%=A0=A0=A0=A0=A0=A0 1046 =B1=A0=
 5%=A0 interrupts.CPU187.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 499.67 =B1 15%=A0=A0=A0=A0 +86.2%=A0=A0=A0=A0 930.50 =B1 15%=A0 i=
nterrupts.CPU187.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4186 =B1=A0 5%=A0=A0=A0=A0 +17.1%=A0=A0=A0=A0=A0=A0 4901 =
=B1=A0 5%=A0 interrupts.CPU188.CAL:Function_call_interrupts=0A=
=A0=A0=A0 616.33 =B1=A0 2%=A0=A0=A0=A0 +77.1%=A0=A0=A0=A0=A0=A0 1091 =B1=A0=
 4%=A0 interrupts.CPU188.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 461.33 =B1=A0 9%=A0=A0=A0 +102.1%=A0=A0=A0=A0 932.25 =B1 15%=A0 i=
nterrupts.CPU188.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3980 =B1=A0 6%=A0=A0=A0=A0 +21.8%=A0=A0=A0=A0=A0=A0 4849 =
=B1=A0 2%=A0 interrupts.CPU189.CAL:Function_call_interrupts=0A=
=A0=A0=A0 594.33=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +87.8%=A0=A0=A0=A0=A0=A0 111=
6 =B1=A0 3%=A0 interrupts.CPU189.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 431.33 =B1 10%=A0=A0=A0 +126.0%=A0=A0=A0=A0 974.75 =B1=A0 5%=A0 i=
nterrupts.CPU189.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3937 =B1=A0 5%=A0=A0=A0=A0 +21.2%=A0=A0=A0=A0=A0=A0 4772 =
=B1=A0 5%=A0 interrupts.CPU19.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5173 =B1=A0 3%=A0=A0=A0=A0 -31.9%=A0=A0=A0=A0=A0=A0 3525 =
=B1 25%=A0 interrupts.CPU19.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5173 =B1=A0 3%=A0=A0=A0=A0 -31.9%=A0=A0=A0=A0=A0=A0 3525 =
=B1 25%=A0 interrupts.CPU19.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 722.67 =B1=A0 9%=A0=A0=A0=A0 +48.1%=A0=A0=A0=A0=A0=A0 1070 =B1=A0=
 2%=A0 interrupts.CPU19.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 479.67 =B1 18%=A0=A0=A0=A0 +95.3%=A0=A0=A0=A0 937.00 =B1=A0 9%=A0=
 interrupts.CPU19.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3905 =B1=A0 5%=A0=A0=A0=A0 +25.2%=A0=A0=A0=A0=A0=A0 4890 =
=B1=A0 5%=A0 interrupts.CPU190.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5230 =B1=A0 2%=A0=A0=A0=A0 -24.7%=A0=A0=A0=A0=A0=A0 3937 =
=B1 10%=A0 interrupts.CPU190.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5230 =B1=A0 2%=A0=A0=A0=A0 -24.7%=A0=A0=A0=A0=A0=A0 3937 =
=B1 10%=A0 interrupts.CPU190.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 580.33 =B1=A0 3%=A0=A0=A0=A0 +84.6%=A0=A0=A0=A0=A0=A0 1071 =B1=A0=
 2%=A0 interrupts.CPU190.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 454.33 =B1 12%=A0=A0=A0 +111.7%=A0=A0=A0=A0 961.75 =B1 14%=A0 int=
errupts.CPU190.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3985 =B1=A0 4%=A0=A0=A0=A0 +23.4%=A0=A0=A0=A0=A0=A0 4918 =
=B1=A0 4%=A0 interrupts.CPU191.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5184 =B1=A0 4%=A0=A0=A0=A0 -34.0%=A0=A0=A0=A0=A0=A0 3422 =
=B1 24%=A0 interrupts.CPU191.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5184 =B1=A0 4%=A0=A0=A0=A0 -34.0%=A0=A0=A0=A0=A0=A0 3422 =
=B1 24%=A0 interrupts.CPU191.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 589.67 =B1=A0 2%=A0=A0=A0=A0 +91.5%=A0=A0=A0=A0=A0=A0 1129 =B1=A0=
 7%=A0 interrupts.CPU191.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 498.67 =B1 25%=A0=A0=A0 +102.2%=A0=A0=A0=A0=A0=A0 1008 =B1 14%=A0=
 interrupts.CPU191.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3847 =B1=A0 6%=A0=A0=A0=A0 +29.1%=A0=A0=A0=A0=A0=A0 4965 =
=B1=A0 8%=A0 interrupts.CPU2.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5162 =B1=A0 3%=A0=A0=A0=A0 -23.5%=A0=A0=A0=A0=A0=A0 3948 =
=B1=A0 5%=A0 interrupts.CPU2.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5162 =B1=A0 3%=A0=A0=A0=A0 -23.5%=A0=A0=A0=A0=A0=A0 3948 =
=B1=A0 5%=A0 interrupts.CPU2.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 691.33 =B1=A0 3%=A0=A0=A0=A0 +59.0%=A0=A0=A0=A0=A0=A0 1099 =B1=A0=
 7%=A0 interrupts.CPU2.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 486.67 =B1=A0 6%=A0=A0=A0=A0 +83.7%=A0=A0=A0=A0 894.25 =B1 13%=A0=
 interrupts.CPU2.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4000 =B1=A0 3%=A0=A0=A0=A0 +19.6%=A0=A0=A0=A0=A0=A0 4786 =
=B1=A0 5%=A0 interrupts.CPU20.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5181 =B1=A0 2%=A0=A0=A0=A0 -42.1%=A0=A0=A0=A0=A0=A0 2999 =
=B1 32%=A0 interrupts.CPU20.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5181 =B1=A0 2%=A0=A0=A0=A0 -42.1%=A0=A0=A0=A0=A0=A0 2999 =
=B1 32%=A0 interrupts.CPU20.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 774.00 =B1 11%=A0=A0=A0=A0 +45.8%=A0=A0=A0=A0=A0=A0 1128 =B1=A0 5=
%=A0 interrupts.CPU20.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 458.33 =B1 11%=A0=A0=A0 +111.7%=A0=A0=A0=A0 970.25 =B1 12%=A0 int=
errupts.CPU20.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4143 =B1=A0 4%=A0=A0=A0=A0 +13.1%=A0=A0=A0=A0=A0=A0 4684 =
=B1=A0 3%=A0 interrupts.CPU21.CAL:Function_call_interrupts=0A=
=A0=A0=A0 814.67 =B1 19%=A0=A0=A0=A0 +35.1%=A0=A0=A0=A0=A0=A0 1100 =B1=A0 6=
%=A0 interrupts.CPU21.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 453.67 =B1 12%=A0=A0=A0=A0 +97.1%=A0=A0=A0=A0 894.25 =B1 13%=A0 i=
nterrupts.CPU21.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3936=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +26.2%=A0=A0=A0=A0=A0=A0=
 4968 =B1=A0 4%=A0 interrupts.CPU22.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5194 =B1=A0 2%=A0=A0=A0=A0 -22.7%=A0=A0=A0=A0=A0=A0 4017 =
=B1=A0 5%=A0 interrupts.CPU22.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5194 =B1=A0 2%=A0=A0=A0=A0 -22.7%=A0=A0=A0=A0=A0=A0 4017 =
=B1=A0 5%=A0 interrupts.CPU22.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 754.67 =B1 11%=A0=A0=A0=A0 +45.8%=A0=A0=A0=A0=A0=A0 1100 =B1=A0 7=
%=A0 interrupts.CPU22.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 467.67 =B1 14%=A0=A0=A0 +100.0%=A0=A0=A0=A0 935.25 =B1 17%=A0 int=
errupts.CPU22.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4046 =B1=A0 4%=A0=A0=A0=A0 +17.6%=A0=A0=A0=A0=A0=A0 4758 =
=B1=A0 2%=A0 interrupts.CPU23.CAL:Function_call_interrupts=0A=
=A0=A0=A0 716.67 =B1=A0 2%=A0=A0=A0=A0 +45.6%=A0=A0=A0=A0=A0=A0 1043 =B1=A0=
 5%=A0 interrupts.CPU23.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 416.33 =B1=A0 7%=A0=A0=A0 +108.4%=A0=A0=A0=A0 867.50 =B1 12%=A0 i=
nterrupts.CPU23.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4323 =B1=A0 6%=A0=A0=A0=A0 +17.2%=A0=A0=A0=A0=A0=A0 5066 =
=B1=A0 5%=A0 interrupts.CPU24.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5170 =B1=A0 3%=A0=A0=A0=A0 -22.1%=A0=A0=A0=A0=A0=A0 4027 =
=B1=A0 6%=A0 interrupts.CPU24.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5170 =B1=A0 3%=A0=A0=A0=A0 -22.1%=A0=A0=A0=A0=A0=A0 4027 =
=B1=A0 6%=A0 interrupts.CPU24.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 876.33 =B1=A0 4%=A0=A0=A0=A0 +33.1%=A0=A0=A0=A0=A0=A0 1166 =B1=A0=
 6%=A0 interrupts.CPU24.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 678.33 =B1 16%=A0=A0=A0=A0 +50.4%=A0=A0=A0=A0=A0=A0 1020 =B1=A0 9=
%=A0 interrupts.CPU24.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4259 =B1=A0 7%=A0=A0=A0=A0 +18.1%=A0=A0=A0=A0=A0=A0 5027 =
=B1=A0 2%=A0 interrupts.CPU25.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5240 =B1=A0 3%=A0=A0=A0=A0 -23.8%=A0=A0=A0=A0=A0=A0 3993 =
=B1=A0 8%=A0 interrupts.CPU25.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5240 =B1=A0 3%=A0=A0=A0=A0 -23.8%=A0=A0=A0=A0=A0=A0 3993 =
=B1=A0 8%=A0 interrupts.CPU25.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 791.67 =B1=A0 3%=A0=A0=A0=A0 +44.3%=A0=A0=A0=A0=A0=A0 1142 =B1=A0=
 7%=A0 interrupts.CPU25.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 594.00 =B1 22%=A0=A0=A0=A0 +62.4%=A0=A0=A0=A0 964.75 =B1 15%=A0 i=
nterrupts.CPU25.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4234 =B1 13%=A0=A0=A0=A0 +20.7%=A0=A0=A0=A0=A0=A0 5111 =B1=
=A0 3%=A0 interrupts.CPU26.CAL:Function_call_interrupts=0A=
=A0=A0=A0 821.33 =B1=A0 3%=A0=A0=A0=A0 +41.4%=A0=A0=A0=A0=A0=A0 1161 =B1=A0=
 6%=A0 interrupts.CPU26.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 528.00 =B1=A0 5%=A0=A0=A0=A0 +96.6%=A0=A0=A0=A0=A0=A0 1038 =B1 18=
%=A0 interrupts.CPU26.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4202 =B1=A0 4%=A0=A0=A0=A0 +21.4%=A0=A0=A0=A0=A0=A0 5101 =
=B1=A0 4%=A0 interrupts.CPU27.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5218 =B1=A0 2%=A0=A0=A0=A0 -22.5%=A0=A0=A0=A0=A0=A0 4045 =
=B1=A0 8%=A0 interrupts.CPU27.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5218 =B1=A0 2%=A0=A0=A0=A0 -22.5%=A0=A0=A0=A0=A0=A0 4045 =
=B1=A0 8%=A0 interrupts.CPU27.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 720.00 =B1=A0 5%=A0=A0=A0=A0 +58.6%=A0=A0=A0=A0=A0=A0 1142 =B1=A0=
 5%=A0 interrupts.CPU27.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 502.67 =B1 16%=A0=A0=A0=A0 +89.7%=A0=A0=A0=A0 953.50 =B1 12%=A0 i=
nterrupts.CPU27.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4162 =B1 14%=A0=A0=A0=A0 +18.2%=A0=A0=A0=A0=A0=A0 4921 =B1=
=A0 5%=A0 interrupts.CPU28.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5157 =B1=A0 2%=A0=A0=A0=A0 -23.4%=A0=A0=A0=A0=A0=A0 3951 =
=B1=A0 7%=A0 interrupts.CPU28.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5157 =B1=A0 2%=A0=A0=A0=A0 -23.4%=A0=A0=A0=A0=A0=A0 3951 =
=B1=A0 7%=A0 interrupts.CPU28.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 755.33 =B1=A0 3%=A0=A0=A0=A0 +47.4%=A0=A0=A0=A0=A0=A0 1113 =B1=A0=
 5%=A0 interrupts.CPU28.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 497.00 =B1 10%=A0=A0=A0=A0 +91.9%=A0=A0=A0=A0 953.50 =B1=A0 3%=A0=
 interrupts.CPU28.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4088 =B1=A0 5%=A0=A0=A0=A0 +24.1%=A0=A0=A0=A0=A0=A0 5072 =
=B1=A0 6%=A0 interrupts.CPU29.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5188 =B1=A0 3%=A0=A0=A0=A0 -22.5%=A0=A0=A0=A0=A0=A0 4021 =
=B1=A0 6%=A0 interrupts.CPU29.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5188 =B1=A0 3%=A0=A0=A0=A0 -22.5%=A0=A0=A0=A0=A0=A0 4021 =
=B1=A0 6%=A0 interrupts.CPU29.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 719.33 =B1=A0 6%=A0=A0=A0=A0 +57.0%=A0=A0=A0=A0=A0=A0 1129 =B1=A0=
 6%=A0 interrupts.CPU29.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 464.33 =B1=A0 2%=A0=A0=A0 +131.1%=A0=A0=A0=A0=A0=A0 1073 =B1 26%=
=A0 interrupts.CPU29.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3770=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +25.7%=A0=A0=A0=A0=A0=A0=
 4739 =B1=A0 5%=A0 interrupts.CPU3.CAL:Function_call_interrupts=0A=
=A0=A0=A0 746.33 =B1=A0 6%=A0=A0=A0=A0 +50.2%=A0=A0=A0=A0=A0=A0 1120 =B1 11=
%=A0 interrupts.CPU3.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 511.67 =B1 14%=A0=A0=A0=A0 +74.5%=A0=A0=A0=A0 892.75 =B1=A0 6%=A0=
 interrupts.CPU3.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4203 =B1=A0 7%=A0=A0=A0=A0 +18.9%=A0=A0=A0=A0=A0=A0 4998 =
=B1=A0 3%=A0 interrupts.CPU30.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5183 =B1=A0 3%=A0=A0=A0=A0 -41.1%=A0=A0=A0=A0=A0=A0 3055 =
=B1 37%=A0 interrupts.CPU30.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5183 =B1=A0 3%=A0=A0=A0=A0 -41.1%=A0=A0=A0=A0=A0=A0 3055 =
=B1 37%=A0 interrupts.CPU30.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 749.33 =B1=A0 5%=A0=A0=A0=A0 +52.9%=A0=A0=A0=A0=A0=A0 1146 =B1=A0=
 6%=A0 interrupts.CPU30.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 469.33 =B1 17%=A0=A0=A0 +108.5%=A0=A0=A0=A0 978.75 =B1=A0 8%=A0 i=
nterrupts.CPU30.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4133 =B1=A0 5%=A0=A0=A0=A0 +20.3%=A0=A0=A0=A0=A0=A0 4971 =
=B1=A0 2%=A0 interrupts.CPU31.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5174 =B1=A0 3%=A0=A0=A0=A0 -31.7%=A0=A0=A0=A0=A0=A0 3536 =
=B1 26%=A0 interrupts.CPU31.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5174 =B1=A0 3%=A0=A0=A0=A0 -31.7%=A0=A0=A0=A0=A0=A0 3536 =
=B1 26%=A0 interrupts.CPU31.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 777.33 =B1=A0 5%=A0=A0=A0=A0 +53.8%=A0=A0=A0=A0=A0=A0 1195 =B1=A0=
 5%=A0 interrupts.CPU31.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 496.00 =B1=A0 9%=A0=A0=A0=A0 +96.7%=A0=A0=A0=A0 975.75 =B1 16%=A0=
 interrupts.CPU31.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4107 =B1=A0 7%=A0=A0=A0=A0 +18.1%=A0=A0=A0=A0=A0=A0 4849 =
=B1=A0 2%=A0 interrupts.CPU32.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5163 =B1=A0 3%=A0=A0=A0=A0 -21.8%=A0=A0=A0=A0=A0=A0 4038 =
=B1=A0 7%=A0 interrupts.CPU32.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5163 =B1=A0 3%=A0=A0=A0=A0 -21.8%=A0=A0=A0=A0=A0=A0 4038 =
=B1=A0 7%=A0 interrupts.CPU32.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 711.67=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +52.9%=A0=A0=A0=A0=A0=A0 108=
8 =B1=A0 5%=A0 interrupts.CPU32.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 489.33 =B1 18%=A0=A0=A0 +115.7%=A0=A0=A0=A0=A0=A0 1055 =B1 11%=A0=
 interrupts.CPU32.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4170 =B1=A0 4%=A0=A0=A0=A0 +17.4%=A0=A0=A0=A0=A0=A0 4897 =
=B1=A0 2%=A0 interrupts.CPU33.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5215 =B1=A0 3%=A0=A0=A0=A0 -33.3%=A0=A0=A0=A0=A0=A0 3480 =
=B1 25%=A0 interrupts.CPU33.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5215 =B1=A0 3%=A0=A0=A0=A0 -33.3%=A0=A0=A0=A0=A0=A0 3480 =
=B1 25%=A0 interrupts.CPU33.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 785.33 =B1=A0 7%=A0=A0=A0=A0 +46.2%=A0=A0=A0=A0=A0=A0 1148 =B1=A0=
 4%=A0 interrupts.CPU33.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 547.67 =B1 13%=A0=A0=A0=A0 +71.6%=A0=A0=A0=A0 939.75 =B1 11%=A0 i=
nterrupts.CPU33.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4302 =B1=A0 6%=A0=A0=A0=A0 +16.0%=A0=A0=A0=A0=A0=A0 4992 =
=B1=A0 4%=A0 interrupts.CPU34.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5214 =B1=A0 3%=A0=A0=A0=A0 -22.7%=A0=A0=A0=A0=A0=A0 4031 =
=B1=A0 6%=A0 interrupts.CPU34.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5214 =B1=A0 3%=A0=A0=A0=A0 -22.7%=A0=A0=A0=A0=A0=A0 4031 =
=B1=A0 6%=A0 interrupts.CPU34.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 787.33 =B1=A0 4%=A0=A0=A0=A0 +41.4%=A0=A0=A0=A0=A0=A0 1113 =B1=A0=
 4%=A0 interrupts.CPU34.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 590.33 =B1=A0 2%=A0=A0=A0=A0 +60.2%=A0=A0=A0=A0 945.50 =B1 11%=A0=
 interrupts.CPU34.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4044 =B1 11%=A0=A0=A0=A0 +22.9%=A0=A0=A0=A0=A0=A0 4969 =B1=
=A0 4%=A0 interrupts.CPU35.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5220 =B1=A0 3%=A0=A0=A0=A0 -32.6%=A0=A0=A0=A0=A0=A0 3520 =
=B1 25%=A0 interrupts.CPU35.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5220 =B1=A0 3%=A0=A0=A0=A0 -32.6%=A0=A0=A0=A0=A0=A0 3520 =
=B1 25%=A0 interrupts.CPU35.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 735.67 =B1=A0 4%=A0=A0=A0=A0 +56.9%=A0=A0=A0=A0=A0=A0 1154 =B1=A0=
 9%=A0 interrupts.CPU35.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 485.00 =B1 12%=A0=A0=A0 +101.3%=A0=A0=A0=A0 976.50 =B1 11%=A0 int=
errupts.CPU35.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4291 =B1=A0 8%=A0=A0=A0=A0 +14.9%=A0=A0=A0=A0=A0=A0 4930 =
=B1=A0 5%=A0 interrupts.CPU36.CAL:Function_call_interrupts=0A=
=A0=A0=A0 782.67 =B1=A0 4%=A0=A0=A0=A0 +51.0%=A0=A0=A0=A0=A0=A0 1182 =B1=A0=
 4%=A0 interrupts.CPU36.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 491.00 =B1 16%=A0=A0=A0=A0 +84.3%=A0=A0=A0=A0 904.75 =B1 16%=A0 i=
nterrupts.CPU36.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3949 =B1=A0 5%=A0=A0=A0=A0 +24.1%=A0=A0=A0=A0=A0=A0 4898 =
=B1=A0 4%=A0 interrupts.CPU37.CAL:Function_call_interrupts=0A=
=A0=A0=A0 723.67 =B1=A0 3%=A0=A0=A0=A0 +54.0%=A0=A0=A0=A0=A0=A0 1114 =B1=A0=
 7%=A0 interrupts.CPU37.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 490.00 =B1=A0 9%=A0=A0=A0 +111.4%=A0=A0=A0=A0=A0=A0 1036 =B1=A0 8=
%=A0 interrupts.CPU37.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 5218 =B1=A0 2%=A0=A0=A0=A0 -23.3%=A0=A0=A0=A0=A0=A0 4000 =
=B1=A0 7%=A0 interrupts.CPU38.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5218 =B1=A0 2%=A0=A0=A0=A0 -23.3%=A0=A0=A0=A0=A0=A0 4000 =
=B1=A0 7%=A0 interrupts.CPU38.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 797.67 =B1 10%=A0=A0=A0=A0 +40.3%=A0=A0=A0=A0=A0=A0 1119 =B1=A0 6=
%=A0 interrupts.CPU38.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 500.33 =B1 16%=A0=A0=A0=A0 +89.6%=A0=A0=A0=A0 948.50 =B1 12%=A0 i=
nterrupts.CPU38.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3987 =B1=A0 5%=A0=A0=A0=A0 +26.0%=A0=A0=A0=A0=A0=A0 5023 =
=B1=A0 5%=A0 interrupts.CPU39.CAL:Function_call_interrupts=0A=
=A0=A0=A0 772.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +47.0%=A0=A0=A0=A0=A0=A0 113=
4 =B1=A0 6%=A0 interrupts.CPU39.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 483.00 =B1 10%=A0=A0=A0 +102.2%=A0=A0=A0=A0 976.75 =B1 17%=A0 int=
errupts.CPU39.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3933 =B1=A0 6%=A0=A0=A0=A0 +38.0%=A0=A0=A0=A0=A0=A0 5428 =
=B1 14%=A0 interrupts.CPU4.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5183 =B1=A0 4%=A0=A0=A0=A0 -43.3%=A0=A0=A0=A0=A0=A0 2939 =
=B1 31%=A0 interrupts.CPU4.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5183 =B1=A0 4%=A0=A0=A0=A0 -43.3%=A0=A0=A0=A0=A0=A0 2939 =
=B1 31%=A0 interrupts.CPU4.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 799.33 =B1=A0 5%=A0=A0=A0=A0 +35.5%=A0=A0=A0=A0=A0=A0 1083 =B1=A0=
 4%=A0 interrupts.CPU4.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 489.67 =B1 14%=A0=A0=A0 +100.9%=A0=A0=A0=A0 983.50 =B1 11%=A0 int=
errupts.CPU4.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4034 =B1=A0 6%=A0=A0=A0=A0 +23.7%=A0=A0=A0=A0=A0=A0 4991=A0=
=A0=A0=A0=A0=A0=A0 interrupts.CPU40.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5212 =B1=A0 2%=A0=A0=A0=A0 -24.0%=A0=A0=A0=A0=A0=A0 3963 =
=B1=A0 7%=A0 interrupts.CPU40.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5212 =B1=A0 2%=A0=A0=A0=A0 -24.0%=A0=A0=A0=A0=A0=A0 3963 =
=B1=A0 7%=A0 interrupts.CPU40.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 745.67 =B1=A0 5%=A0=A0=A0=A0 +53.6%=A0=A0=A0=A0=A0=A0 1145 =B1=A0=
 6%=A0 interrupts.CPU40.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 407.67 =B1 11%=A0=A0=A0 +140.6%=A0=A0=A0=A0 981.00 =B1 13%=A0 int=
errupts.CPU40.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4029 =B1=A0 3%=A0=A0=A0=A0 +25.1%=A0=A0=A0=A0=A0=A0 5040 =
=B1=A0 4%=A0 interrupts.CPU41.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5237 =B1=A0 2%=A0=A0=A0=A0 -24.0%=A0=A0=A0=A0=A0=A0 3980 =
=B1=A0 7%=A0 interrupts.CPU41.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5237 =B1=A0 2%=A0=A0=A0=A0 -24.0%=A0=A0=A0=A0=A0=A0 3980 =
=B1=A0 7%=A0 interrupts.CPU41.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 764.00 =B1 11%=A0=A0=A0=A0 +49.6%=A0=A0=A0=A0=A0=A0 1143 =B1 10%=
=A0 interrupts.CPU41.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 480.33 =B1 15%=A0=A0=A0 +102.8%=A0=A0=A0=A0 974.00 =B1 14%=A0 int=
errupts.CPU41.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4158 =B1=A0 9%=A0=A0=A0=A0 +19.1%=A0=A0=A0=A0=A0=A0 4950 =
=B1=A0 5%=A0 interrupts.CPU42.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5205 =B1=A0 2%=A0=A0=A0=A0 -23.9%=A0=A0=A0=A0=A0=A0 3963 =
=B1=A0 7%=A0 interrupts.CPU42.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5205 =B1=A0 2%=A0=A0=A0=A0 -23.9%=A0=A0=A0=A0=A0=A0 3963 =
=B1=A0 7%=A0 interrupts.CPU42.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 777.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +48.0%=A0=A0=A0=A0=A0=A0 115=
0 =B1=A0 7%=A0 interrupts.CPU42.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 494.67 =B1=A0 7%=A0=A0=A0=A0 +85.4%=A0=A0=A0=A0 917.25 =B1=A0 6%=
=A0 interrupts.CPU42.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4145 =B1=A0 5%=A0=A0=A0=A0 +20.0%=A0=A0=A0=A0=A0=A0 4974 =
=B1=A0 2%=A0 interrupts.CPU43.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5199 =B1=A0 3%=A0=A0=A0=A0 -23.6%=A0=A0=A0=A0=A0=A0 3971 =
=B1=A0 6%=A0 interrupts.CPU43.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5199 =B1=A0 3%=A0=A0=A0=A0 -23.6%=A0=A0=A0=A0=A0=A0 3971 =
=B1=A0 6%=A0 interrupts.CPU43.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 734.00 =B1=A0 4%=A0=A0=A0=A0 +54.8%=A0=A0=A0=A0=A0=A0 1136 =B1=A0=
 3%=A0 interrupts.CPU43.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 479.33 =B1 21%=A0=A0=A0 +116.7%=A0=A0=A0=A0=A0=A0 1038 =B1 12%=A0=
 interrupts.CPU43.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4038 =B1=A0 6%=A0=A0=A0=A0 +20.5%=A0=A0=A0=A0=A0=A0 4867 =
=B1=A0 2%=A0 interrupts.CPU44.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5236 =B1=A0 3%=A0=A0=A0=A0 -34.3%=A0=A0=A0=A0=A0=A0 3438 =
=B1 24%=A0 interrupts.CPU44.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5236 =B1=A0 3%=A0=A0=A0=A0 -34.3%=A0=A0=A0=A0=A0=A0 3438 =
=B1 24%=A0 interrupts.CPU44.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 721.67=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +57.3%=A0=A0=A0=A0=A0=A0 113=
5 =B1=A0 6%=A0 interrupts.CPU44.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 486.67 =B1 12%=A0=A0=A0=A0 +94.9%=A0=A0=A0=A0 948.50 =B1 11%=A0 i=
nterrupts.CPU44.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4089 =B1=A0 7%=A0=A0=A0=A0 +19.7%=A0=A0=A0=A0=A0=A0 4895 =
=B1=A0 4%=A0 interrupts.CPU45.CAL:Function_call_interrupts=0A=
=A0=A0=A0 744.67 =B1=A0 4%=A0=A0=A0=A0 +45.4%=A0=A0=A0=A0=A0=A0 1083 =B1=A0=
 2%=A0 interrupts.CPU45.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 450.33 =B1 17%=A0=A0=A0 +114.5%=A0=A0=A0=A0 966.00 =B1 19%=A0 int=
errupts.CPU45.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3816 =B1=A0 5%=A0=A0=A0=A0 +30.8%=A0=A0=A0=A0=A0=A0 4991 =
=B1=A0 5%=A0 interrupts.CPU46.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5219 =B1=A0 3%=A0=A0=A0=A0 -32.9%=A0=A0=A0=A0=A0=A0 3502 =
=B1 23%=A0 interrupts.CPU46.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5219 =B1=A0 3%=A0=A0=A0=A0 -32.9%=A0=A0=A0=A0=A0=A0 3502 =
=B1 23%=A0 interrupts.CPU46.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 740.33 =B1=A0 8%=A0=A0=A0=A0 +61.8%=A0=A0=A0=A0=A0=A0 1197 =B1=A0=
 5%=A0 interrupts.CPU46.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 455.00 =B1=A0 6%=A0=A0=A0 +107.6%=A0=A0=A0=A0 944.75 =B1 15%=A0 i=
nterrupts.CPU46.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3989 =B1=A0 2%=A0=A0=A0=A0 +24.0%=A0=A0=A0=A0=A0=A0 4947 =
=B1=A0 2%=A0 interrupts.CPU47.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5204 =B1=A0 3%=A0=A0=A0=A0 -32.6%=A0=A0=A0=A0=A0=A0 3506 =
=B1 24%=A0 interrupts.CPU47.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5204 =B1=A0 3%=A0=A0=A0=A0 -32.6%=A0=A0=A0=A0=A0=A0 3506 =
=B1 24%=A0 interrupts.CPU47.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 741.67 =B1=A0 4%=A0=A0=A0=A0 +53.1%=A0=A0=A0=A0=A0=A0 1135 =B1 12=
%=A0 interrupts.CPU47.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 437.33 =B1 17%=A0=A0=A0 +120.8%=A0=A0=A0=A0 965.75 =B1 16%=A0 int=
errupts.CPU47.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4165 =B1=A0 2%=A0=A0=A0=A0 +22.3%=A0=A0=A0=A0=A0=A0 5095 =
=B1=A0 3%=A0 interrupts.CPU48.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5176 =B1=A0 4%=A0=A0=A0=A0 -21.7%=A0=A0=A0=A0=A0=A0 4053 =
=B1=A0 8%=A0 interrupts.CPU48.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5176 =B1=A0 4%=A0=A0=A0=A0 -21.7%=A0=A0=A0=A0=A0=A0 4053 =
=B1=A0 8%=A0 interrupts.CPU48.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 835.00 =B1=A0 2%=A0=A0=A0=A0 +29.0%=A0=A0=A0=A0=A0=A0 1077 =B1=A0=
 2%=A0 interrupts.CPU48.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 594.67 =B1 17%=A0=A0=A0=A0 +62.2%=A0=A0=A0=A0 964.50 =B1=A0 5%=A0=
 interrupts.CPU48.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4171 =B1=A0 9%=A0=A0=A0=A0 +18.7%=A0=A0=A0=A0=A0=A0 4950 =
=B1=A0 6%=A0 interrupts.CPU49.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5186 =B1=A0 4%=A0=A0=A0=A0 -33.4%=A0=A0=A0=A0=A0=A0 3452 =
=B1 24%=A0 interrupts.CPU49.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5186 =B1=A0 4%=A0=A0=A0=A0 -33.4%=A0=A0=A0=A0=A0=A0 3452 =
=B1 24%=A0 interrupts.CPU49.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 710.67 =B1=A0 4%=A0=A0=A0=A0 +55.6%=A0=A0=A0=A0=A0=A0 1105 =B1=A0=
 4%=A0 interrupts.CPU49.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 553.67 =B1=A0 5%=A0=A0=A0=A0 +74.0%=A0=A0=A0=A0 963.25 =B1 10%=A0=
 interrupts.CPU49.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4064 =B1=A0 6%=A0=A0=A0=A0 +21.6%=A0=A0=A0=A0=A0=A0 4944 =
=B1=A0 5%=A0 interrupts.CPU5.CAL:Function_call_interrupts=0A=
=A0=A0=A0 772.33 =B1=A0 2%=A0=A0=A0=A0 +45.7%=A0=A0=A0=A0=A0=A0 1125 =B1=A0=
 4%=A0 interrupts.CPU5.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 491.00 =B1 14%=A0=A0=A0=A0 +95.2%=A0=A0=A0=A0 958.50 =B1 10%=A0 i=
nterrupts.CPU5.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3929 =B1=A0 4%=A0=A0=A0=A0 +26.4%=A0=A0=A0=A0=A0=A0 4966 =
=B1=A0 2%=A0 interrupts.CPU50.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5201 =B1=A0 4%=A0=A0=A0=A0 -22.9%=A0=A0=A0=A0=A0=A0 4011 =
=B1=A0 7%=A0 interrupts.CPU50.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5201 =B1=A0 4%=A0=A0=A0=A0 -22.9%=A0=A0=A0=A0=A0=A0 4011 =
=B1=A0 7%=A0 interrupts.CPU50.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 747.00 =B1=A0 4%=A0=A0=A0=A0 +40.6%=A0=A0=A0=A0=A0=A0 1050 =B1=A0=
 3%=A0 interrupts.CPU50.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 482.33 =B1 17%=A0=A0=A0 +103.1%=A0=A0=A0=A0 979.75 =B1 12%=A0 int=
errupts.CPU50.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4192 =B1=A0 4%=A0=A0=A0=A0 +20.3%=A0=A0=A0=A0=A0=A0 5043 =
=B1=A0 4%=A0 interrupts.CPU51.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5249 =B1=A0 3%=A0=A0=A0=A0 -24.0%=A0=A0=A0=A0=A0=A0 3987 =
=B1=A0 7%=A0 interrupts.CPU51.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5249 =B1=A0 3%=A0=A0=A0=A0 -24.0%=A0=A0=A0=A0=A0=A0 3987 =
=B1=A0 7%=A0 interrupts.CPU51.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 780.33 =B1=A0 7%=A0=A0=A0=A0 +54.9%=A0=A0=A0=A0=A0=A0 1209 =B1=A0=
 9%=A0 interrupts.CPU51.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 504.00 =B1 11%=A0=A0=A0=A0 +95.9%=A0=A0=A0=A0 987.50 =B1=A0 9%=A0=
 interrupts.CPU51.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4084 =B1=A0 4%=A0=A0=A0=A0 +21.8%=A0=A0=A0=A0=A0=A0 4972 =
=B1=A0 4%=A0 interrupts.CPU52.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5208 =B1=A0 4%=A0=A0=A0=A0 -23.1%=A0=A0=A0=A0=A0=A0 4006 =
=B1 11%=A0 interrupts.CPU52.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5208 =B1=A0 4%=A0=A0=A0=A0 -23.1%=A0=A0=A0=A0=A0=A0 4006 =
=B1 11%=A0 interrupts.CPU52.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 724.33 =B1=A0 3%=A0=A0=A0=A0 +48.6%=A0=A0=A0=A0=A0=A0 1076 =B1=A0=
 4%=A0 interrupts.CPU52.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 536.00 =B1 13%=A0=A0=A0=A0 +91.7%=A0=A0=A0=A0=A0=A0 1027 =B1=A0 7=
%=A0 interrupts.CPU52.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 5184 =B1=A0 3%=A0=A0=A0=A0 -24.1%=A0=A0=A0=A0=A0=A0 3933 =
=B1 10%=A0 interrupts.CPU53.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5184 =B1=A0 3%=A0=A0=A0=A0 -24.1%=A0=A0=A0=A0=A0=A0 3933 =
=B1 10%=A0 interrupts.CPU53.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 722.67 =B1=A0 4%=A0=A0=A0=A0 +49.1%=A0=A0=A0=A0=A0=A0 1077 =B1=A0=
 5%=A0 interrupts.CPU53.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 447.33 =B1 20%=A0=A0=A0 +118.6%=A0=A0=A0=A0 978.00 =B1 11%=A0 int=
errupts.CPU53.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4057 =B1=A0 3%=A0=A0=A0=A0 +25.0%=A0=A0=A0=A0=A0=A0 5073 =
=B1=A0 5%=A0 interrupts.CPU54.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5172 =B1=A0 4%=A0=A0=A0=A0 -32.6%=A0=A0=A0=A0=A0=A0 3487 =
=B1 24%=A0 interrupts.CPU54.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5172 =B1=A0 4%=A0=A0=A0=A0 -32.6%=A0=A0=A0=A0=A0=A0 3487 =
=B1 24%=A0 interrupts.CPU54.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 722.67=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +50.7%=A0=A0=A0=A0=A0=A0 108=
8 =B1=A0 7%=A0 interrupts.CPU54.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 491.33 =B1 14%=A0=A0=A0 +382.4%=A0=A0=A0=A0=A0=A0 2370 =B1102%=A0=
 interrupts.CPU54.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4092 =B1=A0 5%=A0=A0=A0=A0 +17.9%=A0=A0=A0=A0=A0=A0 4825=A0=
=A0=A0=A0=A0=A0=A0 interrupts.CPU55.CAL:Function_call_interrupts=0A=
=A0=A0=A0 755.67 =B1 10%=A0=A0=A0=A0 +49.2%=A0=A0=A0=A0=A0=A0 1127 =B1=A0 4=
%=A0 interrupts.CPU55.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 445.67=A0=A0=A0=A0=A0=A0=A0=A0=A0 +117.2%=A0=A0=A0=A0 968.00 =B1 =
11%=A0 interrupts.CPU55.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4116 =B1=A0 4%=A0=A0=A0=A0 +20.0%=A0=A0=A0=A0=A0=A0 4940 =
=B1=A0 5%=A0 interrupts.CPU56.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5144 =B1=A0 5%=A0=A0=A0=A0 -33.4%=A0=A0=A0=A0=A0=A0 3427 =
=B1 23%=A0 interrupts.CPU56.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5144 =B1=A0 5%=A0=A0=A0=A0 -33.4%=A0=A0=A0=A0=A0=A0 3427 =
=B1 23%=A0 interrupts.CPU56.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 707.67=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +55.5%=A0=A0=A0=A0=A0=A0 110=
0=A0=A0=A0=A0=A0=A0=A0 interrupts.CPU56.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 448.00 =B1 16%=A0=A0=A0 +120.1%=A0=A0=A0=A0 986.00 =B1 13%=A0 int=
errupts.CPU56.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3861=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +26.2%=A0=A0=A0=A0=A0=A0=
 4871 =B1=A0 3%=A0 interrupts.CPU57.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5187 =B1=A0 3%=A0=A0=A0=A0 -33.0%=A0=A0=A0=A0=A0=A0 3474 =
=B1 25%=A0 interrupts.CPU57.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5187 =B1=A0 3%=A0=A0=A0=A0 -33.0%=A0=A0=A0=A0=A0=A0 3474 =
=B1 25%=A0 interrupts.CPU57.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 703.00 =B1=A0 3%=A0=A0=A0=A0 +55.6%=A0=A0=A0=A0=A0=A0 1094 =B1=A0=
 4%=A0 interrupts.CPU57.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 495.67 =B1 19%=A0=A0=A0 +106.5%=A0=A0=A0=A0=A0=A0 1023 =B1=A0 8%=
=A0 interrupts.CPU57.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4003 =B1=A0 6%=A0=A0=A0=A0 +25.3%=A0=A0=A0=A0=A0=A0 5016 =
=B1=A0 4%=A0 interrupts.CPU58.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5267=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -32.7%=A0=A0=A0=A0=A0=A0=
 3543 =B1 30%=A0 interrupts.CPU58.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5267=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -32.7%=A0=A0=A0=A0=A0=A0=
 3543 =B1 30%=A0 interrupts.CPU58.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 692.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +61.0%=A0=A0=A0=A0=A0=A0 111=
4=A0=A0=A0=A0=A0=A0=A0 interrupts.CPU58.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 467.67 =B1 16%=A0=A0=A0 +109.8%=A0=A0=A0=A0 981.25 =B1=A0 9%=A0 i=
nterrupts.CPU58.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4147 =B1=A0 7%=A0=A0=A0=A0 +21.2%=A0=A0=A0=A0=A0=A0 5024 =
=B1=A0 4%=A0 interrupts.CPU59.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5175 =B1=A0 3%=A0=A0=A0=A0 -33.9%=A0=A0=A0=A0=A0=A0 3419 =
=B1 24%=A0 interrupts.CPU59.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5175 =B1=A0 3%=A0=A0=A0=A0 -33.9%=A0=A0=A0=A0=A0=A0 3419 =
=B1 24%=A0 interrupts.CPU59.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 765.00 =B1=A0 2%=A0=A0=A0=A0 +40.8%=A0=A0=A0=A0=A0=A0 1077 =B1=A0=
 5%=A0 interrupts.CPU59.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 477.67 =B1 23%=A0=A0=A0=A0 +97.7%=A0=A0=A0=A0 944.25 =B1=A0 9%=A0=
 interrupts.CPU59.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4121 =B1=A0 7%=A0=A0=A0=A0 +19.7%=A0=A0=A0=A0=A0=A0 4932 =
=B1=A0 4%=A0 interrupts.CPU6.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5158 =B1=A0 4%=A0=A0=A0=A0 -31.8%=A0=A0=A0=A0=A0=A0 3518 =
=B1 25%=A0 interrupts.CPU6.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5158 =B1=A0 4%=A0=A0=A0=A0 -31.8%=A0=A0=A0=A0=A0=A0 3518 =
=B1 25%=A0 interrupts.CPU6.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 735.33 =B1 10%=A0=A0=A0=A0 +48.5%=A0=A0=A0=A0=A0=A0 1091 =B1=A0 5=
%=A0 interrupts.CPU6.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 535.33 =B1 13%=A0=A0=A0=A0 +72.5%=A0=A0=A0=A0 923.25 =B1 14%=A0 i=
nterrupts.CPU6.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4122 =B1=A0 4%=A0=A0=A0=A0 +32.7%=A0=A0=A0=A0=A0=A0 5471 =
=B1 18%=A0 interrupts.CPU60.CAL:Function_call_interrupts=0A=
=A0=A0=A0 746.67 =B1=A0 4%=A0=A0=A0=A0 +48.7%=A0=A0=A0=A0=A0=A0 1110 =B1=A0=
 4%=A0 interrupts.CPU60.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 496.00 =B1 23%=A0=A0=A0=A0 +92.2%=A0=A0=A0=A0 953.25 =B1 13%=A0 i=
nterrupts.CPU60.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4022 =B1=A0 4%=A0=A0=A0=A0 +33.7%=A0=A0=A0=A0=A0=A0 5376 =
=B1 14%=A0 interrupts.CPU61.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5190 =B1=A0 4%=A0=A0=A0=A0 -34.9%=A0=A0=A0=A0=A0=A0 3378 =
=B1 24%=A0 interrupts.CPU61.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5190 =B1=A0 4%=A0=A0=A0=A0 -34.9%=A0=A0=A0=A0=A0=A0 3378 =
=B1 24%=A0 interrupts.CPU61.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 734.33 =B1=A0 4%=A0=A0=A0=A0 +48.2%=A0=A0=A0=A0=A0=A0 1088 =B1=A0=
 2%=A0 interrupts.CPU61.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 484.67 =B1 15%=A0=A0=A0 +109.0%=A0=A0=A0=A0=A0=A0 1013 =B1=A0 9%=
=A0 interrupts.CPU61.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3917 =B1=A0 5%=A0=A0=A0=A0 +26.4%=A0=A0=A0=A0=A0=A0 4953 =
=B1=A0 3%=A0 interrupts.CPU62.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5189 =B1=A0 4%=A0=A0=A0=A0 -32.8%=A0=A0=A0=A0=A0=A0 3489 =
=B1 25%=A0 interrupts.CPU62.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5189 =B1=A0 4%=A0=A0=A0=A0 -32.8%=A0=A0=A0=A0=A0=A0 3489 =
=B1 25%=A0 interrupts.CPU62.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 778.00 =B1=A0 3%=A0=A0=A0=A0 +42.6%=A0=A0=A0=A0=A0=A0 1109 =B1=A0=
 2%=A0 interrupts.CPU62.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 486.33 =B1 23%=A0=A0=A0 +110.0%=A0=A0=A0=A0=A0=A0 1021 =B1 17%=A0=
 interrupts.CPU62.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4163 =B1=A0 8%=A0=A0=A0=A0 +20.8%=A0=A0=A0=A0=A0=A0 5029=A0=
=A0=A0=A0=A0=A0=A0 interrupts.CPU63.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5231 =B1=A0 2%=A0=A0=A0=A0 -34.6%=A0=A0=A0=A0=A0=A0 3419 =
=B1 24%=A0 interrupts.CPU63.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5231 =B1=A0 2%=A0=A0=A0=A0 -34.6%=A0=A0=A0=A0=A0=A0 3419 =
=B1 24%=A0 interrupts.CPU63.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 775.67 =B1=A0 6%=A0=A0=A0=A0 +39.5%=A0=A0=A0=A0=A0=A0 1082=A0=A0=
=A0=A0=A0=A0=A0 interrupts.CPU63.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 491.00 =B1 22%=A0=A0=A0=A0 +95.8%=A0=A0=A0=A0 961.25 =B1 16%=A0 i=
nterrupts.CPU63.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4016 =B1=A0 2%=A0=A0=A0=A0 +24.2%=A0=A0=A0=A0=A0=A0 4990 =
=B1=A0 3%=A0 interrupts.CPU64.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5129 =B1=A0 5%=A0=A0=A0=A0 -42.0%=A0=A0=A0=A0=A0=A0 2973 =
=B1 36%=A0 interrupts.CPU64.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5129 =B1=A0 5%=A0=A0=A0=A0 -42.0%=A0=A0=A0=A0=A0=A0 2973 =
=B1 36%=A0 interrupts.CPU64.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 757.67 =B1=A0 4%=A0=A0=A0=A0 +47.7%=A0=A0=A0=A0=A0=A0 1119 =B1=A0=
 3%=A0 interrupts.CPU64.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 453.67 =B1 11%=A0=A0=A0 +119.8%=A0=A0=A0=A0 997.00 =B1 11%=A0 int=
errupts.CPU64.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3854 =B1=A0 2%=A0=A0=A0=A0 +26.3%=A0=A0=A0=A0=A0=A0 4868 =
=B1=A0 7%=A0 interrupts.CPU65.CAL:Function_call_interrupts=0A=
=A0=A0=A0 767.33 =B1=A0 7%=A0=A0=A0=A0 +37.7%=A0=A0=A0=A0=A0=A0 1056 =B1=A0=
 3%=A0 interrupts.CPU65.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 519.67 =B1 14%=A0=A0=A0=A0 +85.3%=A0=A0=A0=A0 962.75 =B1 13%=A0 i=
nterrupts.CPU65.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3915 =B1=A0 8%=A0=A0=A0=A0 +24.8%=A0=A0=A0=A0=A0=A0 4888 =
=B1=A0 3%=A0 interrupts.CPU66.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5199 =B1=A0 3%=A0=A0=A0=A0 -34.4%=A0=A0=A0=A0=A0=A0 3409 =
=B1 25%=A0 interrupts.CPU66.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5199 =B1=A0 3%=A0=A0=A0=A0 -34.4%=A0=A0=A0=A0=A0=A0 3409 =
=B1 25%=A0 interrupts.CPU66.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 712.67 =B1=A0 3%=A0=A0=A0=A0 +56.9%=A0=A0=A0=A0=A0=A0 1118 =B1=A0=
 6%=A0 interrupts.CPU66.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 431.67 =B1 30%=A0=A0=A0 +138.8%=A0=A0=A0=A0=A0=A0 1030 =B1 14%=A0=
 interrupts.CPU66.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4026 =B1=A0 9%=A0=A0=A0=A0 +21.0%=A0=A0=A0=A0=A0=A0 4870 =
=B1=A0 3%=A0 interrupts.CPU67.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5157 =B1=A0 5%=A0=A0=A0=A0 -23.4%=A0=A0=A0=A0=A0=A0 3950 =
=B1=A0 9%=A0 interrupts.CPU67.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5157 =B1=A0 5%=A0=A0=A0=A0 -23.4%=A0=A0=A0=A0=A0=A0 3950 =
=B1=A0 9%=A0 interrupts.CPU67.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 671.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +56.9%=A0=A0=A0=A0=A0=A0 105=
3 =B1=A0 2%=A0 interrupts.CPU67.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 489.67 =B1 16%=A0=A0=A0=A0 +99.6%=A0=A0=A0=A0 977.50 =B1 12%=A0 i=
nterrupts.CPU67.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4034 =B1=A0 4%=A0=A0=A0=A0 +22.0%=A0=A0=A0=A0=A0=A0 4921 =
=B1=A0 2%=A0 interrupts.CPU68.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5175 =B1=A0 4%=A0=A0=A0=A0 -31.2%=A0=A0=A0=A0=A0=A0 3561 =
=B1 30%=A0 interrupts.CPU68.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5175 =B1=A0 4%=A0=A0=A0=A0 -31.2%=A0=A0=A0=A0=A0=A0 3561 =
=B1 30%=A0 interrupts.CPU68.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 709.00 =B1=A0 4%=A0=A0=A0=A0 +56.2%=A0=A0=A0=A0=A0=A0 1107 =B1=A0=
 3%=A0 interrupts.CPU68.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 493.00 =B1 15%=A0=A0=A0=A0 +95.8%=A0=A0=A0=A0 965.25 =B1 12%=A0 i=
nterrupts.CPU68.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4014 =B1 10%=A0=A0=A0=A0 +24.6%=A0=A0=A0=A0=A0=A0 5001 =B1=
=A0 2%=A0 interrupts.CPU69.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5152 =B1=A0 4%=A0=A0=A0=A0 -32.5%=A0=A0=A0=A0=A0=A0 3476 =
=B1 25%=A0 interrupts.CPU69.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5152 =B1=A0 4%=A0=A0=A0=A0 -32.5%=A0=A0=A0=A0=A0=A0 3476 =
=B1 25%=A0 interrupts.CPU69.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 717.33 =B1=A0 3%=A0=A0=A0=A0 +50.3%=A0=A0=A0=A0=A0=A0 1078 =B1=A0=
 7%=A0 interrupts.CPU69.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 434.67 =B1 26%=A0=A0=A0 +123.0%=A0=A0=A0=A0 969.25 =B1=A0 8%=A0 i=
nterrupts.CPU69.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3972 =B1=A0 8%=A0=A0=A0=A0 +23.1%=A0=A0=A0=A0=A0=A0 4892=A0=
=A0=A0=A0=A0=A0=A0 interrupts.CPU7.CAL:Function_call_interrupts=0A=
=A0=A0=A0 776.67 =B1=A0 5%=A0=A0=A0=A0 +40.6%=A0=A0=A0=A0=A0=A0 1091 =B1=A0=
 4%=A0 interrupts.CPU7.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 467.33 =B1 11%=A0=A0=A0 +102.8%=A0=A0=A0=A0 947.75 =B1 16%=A0 int=
errupts.CPU7.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4068 =B1 11%=A0=A0=A0=A0 +26.2%=A0=A0=A0=A0=A0=A0 5134=A0=
=A0=A0=A0=A0=A0=A0 interrupts.CPU70.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5188 =B1=A0 4%=A0=A0=A0=A0 -42.6%=A0=A0=A0=A0=A0=A0 2975 =
=B1 37%=A0 interrupts.CPU70.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5188 =B1=A0 4%=A0=A0=A0=A0 -42.6%=A0=A0=A0=A0=A0=A0 2975 =
=B1 37%=A0 interrupts.CPU70.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 718.00 =B1=A0 4%=A0=A0=A0=A0 +54.3%=A0=A0=A0=A0=A0=A0 1107 =B1=A0=
 2%=A0 interrupts.CPU70.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 494.00 =B1 11%=A0=A0=A0 +104.5%=A0=A0=A0=A0=A0=A0 1010 =B1=A0 6%=
=A0 interrupts.CPU70.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3920 =B1=A0 4%=A0=A0=A0=A0 +29.5%=A0=A0=A0=A0=A0=A0 5078 =
=B1=A0 4%=A0 interrupts.CPU71.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5112 =B1=A0 4%=A0=A0=A0=A0 -23.3%=A0=A0=A0=A0=A0=A0 3920 =
=B1 11%=A0 interrupts.CPU71.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5112 =B1=A0 4%=A0=A0=A0=A0 -23.3%=A0=A0=A0=A0=A0=A0 3920 =
=B1 11%=A0 interrupts.CPU71.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 667.67=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +64.9%=A0=A0=A0=A0=A0=A0 110=
1 =B1=A0 5%=A0 interrupts.CPU71.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 473.00 =B1 13%=A0=A0=A0 +103.8%=A0=A0=A0=A0 963.75 =B1 13%=A0 int=
errupts.CPU71.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3913 =B1=A0 3%=A0=A0=A0=A0 +26.8%=A0=A0=A0=A0=A0=A0 4963 =
=B1=A0 2%=A0 interrupts.CPU72.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5206 =B1=A0 3%=A0=A0=A0=A0 -24.5%=A0=A0=A0=A0=A0=A0 3932 =
=B1 10%=A0 interrupts.CPU72.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5206 =B1=A0 3%=A0=A0=A0=A0 -24.5%=A0=A0=A0=A0=A0=A0 3932 =
=B1 10%=A0 interrupts.CPU72.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 811.67 =B1=A0 3%=A0=A0=A0=A0 +33.3%=A0=A0=A0=A0=A0=A0 1081 =B1=A0=
 4%=A0 interrupts.CPU72.RES:Rescheduling_interrupts=0A=
=A0=A0=A0=A0=A0 3939 =B1=A0 3%=A0=A0=A0=A0 +26.0%=A0=A0=A0=A0=A0=A0 4962 =
=B1=A0 6%=A0 interrupts.CPU73.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5184 =B1=A0 2%=A0=A0=A0=A0 -34.3%=A0=A0=A0=A0=A0=A0 3408 =
=B1 25%=A0 interrupts.CPU73.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5184 =B1=A0 2%=A0=A0=A0=A0 -34.3%=A0=A0=A0=A0=A0=A0 3408 =
=B1 25%=A0 interrupts.CPU73.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 763.00 =B1=A0 4%=A0=A0=A0=A0 +40.6%=A0=A0=A0=A0=A0=A0 1072 =B1=A0=
 4%=A0 interrupts.CPU73.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 570.00 =B1=A0 5%=A0=A0=A0=A0 +97.1%=A0=A0=A0=A0=A0=A0 1123 =B1 25=
%=A0 interrupts.CPU73.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4069 =B1=A0 6%=A0=A0=A0=A0 +21.7%=A0=A0=A0=A0=A0=A0 4954 =
=B1=A0 3%=A0 interrupts.CPU74.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5223 =B1=A0 3%=A0=A0=A0=A0 -23.9%=A0=A0=A0=A0=A0=A0 3972 =
=B1 10%=A0 interrupts.CPU74.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5223 =B1=A0 3%=A0=A0=A0=A0 -23.9%=A0=A0=A0=A0=A0=A0 3972 =
=B1 10%=A0 interrupts.CPU74.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 715.33=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +53.9%=A0=A0=A0=A0=A0=A0 110=
1 =B1=A0 5%=A0 interrupts.CPU74.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 526.00 =B1 14%=A0=A0=A0=A0 +90.9%=A0=A0=A0=A0=A0=A0 1004 =B1 11%=
=A0 interrupts.CPU74.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4034 =B1 10%=A0=A0=A0=A0 +21.5%=A0=A0=A0=A0=A0=A0 4900 =B1=
=A0 4%=A0 interrupts.CPU75.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5241 =B1=A0 2%=A0=A0=A0=A0 -42.9%=A0=A0=A0=A0=A0=A0 2995 =
=B1 37%=A0 interrupts.CPU75.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5241 =B1=A0 2%=A0=A0=A0=A0 -42.9%=A0=A0=A0=A0=A0=A0 2995 =
=B1 37%=A0 interrupts.CPU75.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 712.00 =B1=A0 2%=A0=A0=A0=A0 +49.6%=A0=A0=A0=A0=A0=A0 1065 =B1=A0=
 6%=A0 interrupts.CPU75.RES:Rescheduling_interrupts=0A=
=A0=A0=A0=A0=A0 4203 =B1=A0 8%=A0=A0=A0=A0 +18.8%=A0=A0=A0=A0=A0=A0 4995 =
=B1=A0 5%=A0 interrupts.CPU76.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5216 =B1=A0 2%=A0=A0=A0=A0 -32.4%=A0=A0=A0=A0=A0=A0 3525 =
=B1 31%=A0 interrupts.CPU76.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5216 =B1=A0 2%=A0=A0=A0=A0 -32.4%=A0=A0=A0=A0=A0=A0 3525 =
=B1 31%=A0 interrupts.CPU76.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 719.00 =B1=A0 2%=A0=A0=A0=A0 +44.5%=A0=A0=A0=A0=A0=A0 1039 =B1=A0=
 5%=A0 interrupts.CPU76.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 488.00 =B1 10%=A0=A0=A0=A0 +87.1%=A0=A0=A0=A0 913.25 =B1=A0 9%=A0=
 interrupts.CPU76.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3955 =B1=A0 7%=A0=A0=A0=A0 +23.9%=A0=A0=A0=A0=A0=A0 4901 =
=B1=A0 3%=A0 interrupts.CPU77.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5224 =B1=A0 3%=A0=A0=A0=A0 -24.5%=A0=A0=A0=A0=A0=A0 3944 =
=B1 11%=A0 interrupts.CPU77.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5224 =B1=A0 3%=A0=A0=A0=A0 -24.5%=A0=A0=A0=A0=A0=A0 3944 =
=B1 11%=A0 interrupts.CPU77.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 703.67 =B1=A0 8%=A0=A0=A0=A0 +50.9%=A0=A0=A0=A0=A0=A0 1062 =B1=A0=
 3%=A0 interrupts.CPU77.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 466.67 =B1=A0 7%=A0=A0=A0 +125.8%=A0=A0=A0=A0=A0=A0 1053 =B1 13%=
=A0 interrupts.CPU77.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4189 =B1=A0 6%=A0=A0=A0=A0 +15.8%=A0=A0=A0=A0=A0=A0 4852 =
=B1=A0 6%=A0 interrupts.CPU78.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5190 =B1=A0 4%=A0=A0=A0=A0 -33.4%=A0=A0=A0=A0=A0=A0 3455 =
=B1 24%=A0 interrupts.CPU78.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5190 =B1=A0 4%=A0=A0=A0=A0 -33.4%=A0=A0=A0=A0=A0=A0 3455 =
=B1 24%=A0 interrupts.CPU78.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 706.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +49.5%=A0=A0=A0=A0=A0=A0 105=
5 =B1=A0 4%=A0 interrupts.CPU78.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 442.67 =B1=A0 8%=A0=A0=A0 +135.9%=A0=A0=A0=A0=A0=A0 1044 =B1 15%=
=A0 interrupts.CPU78.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3902 =B1=A0 3%=A0=A0=A0=A0 +24.7%=A0=A0=A0=A0=A0=A0 4865 =
=B1=A0 3%=A0 interrupts.CPU79.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5225 =B1=A0 3%=A0=A0=A0=A0 -35.1%=A0=A0=A0=A0=A0=A0 3390 =
=B1 24%=A0 interrupts.CPU79.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5225 =B1=A0 3%=A0=A0=A0=A0 -35.1%=A0=A0=A0=A0=A0=A0 3390 =
=B1 24%=A0 interrupts.CPU79.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 704.67 =B1=A0 4%=A0=A0=A0=A0 +58.3%=A0=A0=A0=A0=A0=A0 1115 =B1=A0=
 7%=A0 interrupts.CPU79.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 444.00 =B1 13%=A0=A0=A0 +111.1%=A0=A0=A0=A0 937.25 =B1 11%=A0 int=
errupts.CPU79.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4089 =B1=A0 4%=A0=A0=A0=A0 +19.8%=A0=A0=A0=A0=A0=A0 4898=A0=
=A0=A0=A0=A0=A0=A0 interrupts.CPU8.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5181 =B1=A0 4%=A0=A0=A0=A0 -22.3%=A0=A0=A0=A0=A0=A0 4024 =
=B1=A0 5%=A0 interrupts.CPU8.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5181 =B1=A0 4%=A0=A0=A0=A0 -22.3%=A0=A0=A0=A0=A0=A0 4024 =
=B1=A0 5%=A0 interrupts.CPU8.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 785.33 =B1=A0 4%=A0=A0=A0=A0 +41.3%=A0=A0=A0=A0=A0=A0 1110 =B1=A0=
 6%=A0 interrupts.CPU8.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 480.00 =B1=A0 9%=A0=A0=A0=A0 +94.0%=A0=A0=A0=A0 931.00 =B1 17%=A0=
 interrupts.CPU8.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4093 =B1=A0 6%=A0=A0=A0=A0 +22.6%=A0=A0=A0=A0=A0=A0 5018 =
=B1=A0 4%=A0 interrupts.CPU80.CAL:Function_call_interrupts=0A=
=A0=A0=A0 721.33 =B1=A0 5%=A0=A0=A0=A0 +44.9%=A0=A0=A0=A0=A0=A0 1045 =B1=A0=
 2%=A0 interrupts.CPU80.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 485.33 =B1 10%=A0=A0=A0 +101.9%=A0=A0=A0=A0 980.00 =B1=A0 6%=A0 i=
nterrupts.CPU80.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4059 =B1=A0 9%=A0=A0=A0=A0 +19.3%=A0=A0=A0=A0=A0=A0 4843 =
=B1=A0 4%=A0 interrupts.CPU81.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5243 =B1=A0 3%=A0=A0=A0=A0 -25.7%=A0=A0=A0=A0=A0=A0 3894 =
=B1 10%=A0 interrupts.CPU81.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5243 =B1=A0 3%=A0=A0=A0=A0 -25.7%=A0=A0=A0=A0=A0=A0 3894 =
=B1 10%=A0 interrupts.CPU81.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 689.67 =B1=A0 7%=A0=A0=A0=A0 +53.0%=A0=A0=A0=A0=A0=A0 1055 =B1=A0=
 7%=A0 interrupts.CPU81.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 553.67 =B1 16%=A0=A0=A0=A0 +87.9%=A0=A0=A0=A0=A0=A0 1040 =B1 13%=
=A0 interrupts.CPU81.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3950 =B1=A0 8%=A0=A0=A0=A0 +23.1%=A0=A0=A0=A0=A0=A0 4863 =
=B1=A0 6%=A0 interrupts.CPU82.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5207 =B1=A0 3%=A0=A0=A0=A0 -33.8%=A0=A0=A0=A0=A0=A0 3447 =
=B1 25%=A0 interrupts.CPU82.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5207 =B1=A0 3%=A0=A0=A0=A0 -33.8%=A0=A0=A0=A0=A0=A0 3447 =
=B1 25%=A0 interrupts.CPU82.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 723.33=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +45.0%=A0=A0=A0=A0=A0=A0 104=
8 =B1=A0 2%=A0 interrupts.CPU82.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 424.67 =B1 12%=A0=A0=A0 +143.4%=A0=A0=A0=A0=A0=A0 1033 =B1 11%=A0=
 interrupts.CPU82.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4227 =B1=A0 9%=A0=A0=A0=A0 +20.3%=A0=A0=A0=A0=A0=A0 5085 =
=B1=A0 6%=A0 interrupts.CPU83.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5224 =B1=A0 3%=A0=A0=A0=A0 -42.6%=A0=A0=A0=A0=A0=A0 2998 =
=B1 38%=A0 interrupts.CPU83.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5224 =B1=A0 3%=A0=A0=A0=A0 -42.6%=A0=A0=A0=A0=A0=A0 2998 =
=B1 38%=A0 interrupts.CPU83.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 690.00 =B1=A0 7%=A0=A0=A0=A0 +57.2%=A0=A0=A0=A0=A0=A0 1084 =B1=A0=
 3%=A0 interrupts.CPU83.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 437.33 =B1=A0 9%=A0=A0=A0 +170.6%=A0=A0=A0=A0=A0=A0 1183 =B1 19%=
=A0 interrupts.CPU83.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4122 =B1 10%=A0=A0=A0=A0 +19.3%=A0=A0=A0=A0=A0=A0 4918 =B1=
=A0 3%=A0 interrupts.CPU84.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5236 =B1=A0 3%=A0=A0=A0=A0 -44.5%=A0=A0=A0=A0=A0=A0 2906 =
=B1 29%=A0 interrupts.CPU84.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5236 =B1=A0 3%=A0=A0=A0=A0 -44.5%=A0=A0=A0=A0=A0=A0 2906 =
=B1 29%=A0 interrupts.CPU84.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 714.00 =B1=A0 2%=A0=A0=A0=A0 +49.4%=A0=A0=A0=A0=A0=A0 1066 =B1=A0=
 4%=A0 interrupts.CPU84.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 460.00 =B1 17%=A0=A0=A0 +124.9%=A0=A0=A0=A0=A0=A0 1034 =B1 11%=A0=
 interrupts.CPU84.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4072 =B1=A0 5%=A0=A0=A0=A0 +19.5%=A0=A0=A0=A0=A0=A0 4864 =
=B1=A0 4%=A0 interrupts.CPU85.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5256 =B1=A0 3%=A0=A0=A0=A0 -24.5%=A0=A0=A0=A0=A0=A0 3967 =
=B1=A0 9%=A0 interrupts.CPU85.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5256 =B1=A0 3%=A0=A0=A0=A0 -24.5%=A0=A0=A0=A0=A0=A0 3967 =
=B1=A0 9%=A0 interrupts.CPU85.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 696.67 =B1=A0 5%=A0=A0=A0=A0 +53.2%=A0=A0=A0=A0=A0=A0 1067 =B1=A0=
 5%=A0 interrupts.CPU85.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 445.67 =B1 13%=A0=A0=A0 +112.0%=A0=A0=A0=A0 945.00 =B1=A0 2%=A0 i=
nterrupts.CPU85.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4091 =B1=A0 3%=A0=A0=A0=A0 +21.3%=A0=A0=A0=A0=A0=A0 4964 =
=B1=A0 4%=A0 interrupts.CPU86.CAL:Function_call_interrupts=0A=
=A0=A0=A0 699.33 =B1=A0 5%=A0=A0=A0=A0 +56.4%=A0=A0=A0=A0=A0=A0 1093 =B1=A0=
 4%=A0 interrupts.CPU86.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 466.00 =B1 14%=A0=A0=A0 +126.0%=A0=A0=A0=A0=A0=A0 1053 =B1=A0 4%=
=A0 interrupts.CPU86.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4003 =B1=A0 8%=A0=A0=A0=A0 +25.3%=A0=A0=A0=A0=A0=A0 5015 =
=B1=A0 4%=A0 interrupts.CPU87.CAL:Function_call_interrupts=0A=
=A0=A0=A0 687.00 =B1=A0 3%=A0=A0=A0=A0 +54.1%=A0=A0=A0=A0=A0=A0 1058 =B1=A0=
 5%=A0 interrupts.CPU87.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 474.33 =B1 18%=A0=A0=A0 +116.1%=A0=A0=A0=A0=A0=A0 1025 =B1=A0 9%=
=A0 interrupts.CPU87.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4087 =B1=A0 8%=A0=A0=A0=A0 +21.9%=A0=A0=A0=A0=A0=A0 4982 =
=B1=A0 3%=A0 interrupts.CPU88.CAL:Function_call_interrupts=0A=
=A0=A0=A0 695.67=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +48.5%=A0=A0=A0=A0=A0=A0 103=
3 =B1=A0 2%=A0 interrupts.CPU88.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 482.00 =B1 12%=A0=A0=A0 +114.2%=A0=A0=A0=A0=A0=A0 1032 =B1=A0 7%=
=A0 interrupts.CPU88.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3940 =B1=A0 8%=A0=A0=A0=A0 +25.5%=A0=A0=A0=A0=A0=A0 4944 =
=B1=A0 5%=A0 interrupts.CPU89.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5209 =B1=A0 3%=A0=A0=A0=A0 -25.2%=A0=A0=A0=A0=A0=A0 3895 =
=B1 10%=A0 interrupts.CPU89.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5209 =B1=A0 3%=A0=A0=A0=A0 -25.2%=A0=A0=A0=A0=A0=A0 3895 =
=B1 10%=A0 interrupts.CPU89.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 695.67 =B1=A0 4%=A0=A0=A0=A0 +51.6%=A0=A0=A0=A0=A0=A0 1054 =B1=A0=
 4%=A0 interrupts.CPU89.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 434.00 =B1 15%=A0=A0=A0 +131.6%=A0=A0=A0=A0=A0=A0 1005 =B1=A0 9%=
=A0 interrupts.CPU89.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3991 =B1=A0 2%=A0=A0=A0=A0 +18.5%=A0=A0=A0=A0=A0=A0 4728 =
=B1=A0 3%=A0 interrupts.CPU9.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5149 =B1=A0 5%=A0=A0=A0=A0 -33.6%=A0=A0=A0=A0=A0=A0 3418 =
=B1 25%=A0 interrupts.CPU9.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5149 =B1=A0 5%=A0=A0=A0=A0 -33.6%=A0=A0=A0=A0=A0=A0 3418 =
=B1 25%=A0 interrupts.CPU9.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 704.67 =B1=A0 7%=A0=A0=A0=A0 +56.2%=A0=A0=A0=A0=A0=A0 1100 =B1=A0=
 4%=A0 interrupts.CPU9.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 433.67 =B1=A0 8%=A0=A0=A0 +107.6%=A0=A0=A0=A0 900.25 =B1 12%=A0 i=
nterrupts.CPU9.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4145 =B1=A0 6%=A0=A0=A0=A0 +17.4%=A0=A0=A0=A0=A0=A0 4868 =
=B1=A0 6%=A0 interrupts.CPU90.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5217 =B1=A0 3%=A0=A0=A0=A0 -42.9%=A0=A0=A0=A0=A0=A0 2977 =
=B1 40%=A0 interrupts.CPU90.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5217 =B1=A0 3%=A0=A0=A0=A0 -42.9%=A0=A0=A0=A0=A0=A0 2977 =
=B1 40%=A0 interrupts.CPU90.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 672.33 =B1=A0 4%=A0=A0=A0=A0 +61.4%=A0=A0=A0=A0=A0=A0 1085 =B1=A0=
 2%=A0 interrupts.CPU90.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 491.33 =B1 14%=A0=A0=A0=A0 +90.1%=A0=A0=A0=A0 934.00 =B1=A0 9%=A0=
 interrupts.CPU90.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4304 =B1=A0 7%=A0=A0=A0=A0 +17.4%=A0=A0=A0=A0=A0=A0 5051 =
=B1=A0 3%=A0 interrupts.CPU91.CAL:Function_call_interrupts=0A=
=A0=A0=A0 799.00 =B1=A0 4%=A0=A0=A0=A0 +34.7%=A0=A0=A0=A0=A0=A0 1076 =B1=A0=
 3%=A0 interrupts.CPU91.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 458.33 =B1 13%=A0=A0=A0 +112.6%=A0=A0=A0=A0 974.50 =B1=A0 3%=A0 i=
nterrupts.CPU91.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3978 =B1=A0 4%=A0=A0=A0=A0 +21.1%=A0=A0=A0=A0=A0=A0 4816 =
=B1=A0 3%=A0 interrupts.CPU92.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5190 =B1=A0 4%=A0=A0=A0=A0 -54.3%=A0=A0=A0=A0=A0=A0 2371 =
=B1 21%=A0 interrupts.CPU92.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5190 =B1=A0 4%=A0=A0=A0=A0 -54.3%=A0=A0=A0=A0=A0=A0 2371 =
=B1 21%=A0 interrupts.CPU92.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 648.00=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +66.6%=A0=A0=A0=A0=A0=A0 107=
9 =B1=A0 4%=A0 interrupts.CPU92.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 470.67 =B1 14%=A0=A0=A0=A0 +99.7%=A0=A0=A0=A0 940.00 =B1 17%=A0 i=
nterrupts.CPU92.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3937 =B1=A0 6%=A0=A0=A0=A0 +23.5%=A0=A0=A0=A0=A0=A0 4863 =
=B1=A0 5%=A0 interrupts.CPU93.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5221 =B1=A0 3%=A0=A0=A0=A0 -35.6%=A0=A0=A0=A0=A0=A0 3365 =
=B1 23%=A0 interrupts.CPU93.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5221 =B1=A0 3%=A0=A0=A0=A0 -35.6%=A0=A0=A0=A0=A0=A0 3365 =
=B1 23%=A0 interrupts.CPU93.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 677.67 =B1=A0 6%=A0=A0=A0=A0 +53.6%=A0=A0=A0=A0=A0=A0 1041 =B1=A0=
 5%=A0 interrupts.CPU93.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 481.00 =B1=A0 4%=A0=A0=A0 +123.9%=A0=A0=A0=A0=A0=A0 1077 =B1=A0 4=
%=A0 interrupts.CPU93.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4005 =B1=A0 5%=A0=A0=A0=A0 +22.8%=A0=A0=A0=A0=A0=A0 4919 =
=B1=A0 6%=A0 interrupts.CPU94.CAL:Function_call_interrupts=0A=
=A0=A0=A0 648.00 =B1=A0 2%=A0=A0=A0=A0 +61.7%=A0=A0=A0=A0=A0=A0 1047 =B1=A0=
 6%=A0 interrupts.CPU94.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 469.67 =B1=A0 9%=A0=A0=A0 +103.2%=A0=A0=A0=A0 954.25 =B1 17%=A0 i=
nterrupts.CPU94.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4039 =B1=A0 2%=A0=A0=A0=A0 +26.0%=A0=A0=A0=A0=A0=A0 5088 =
=B1=A0 5%=A0 interrupts.CPU95.CAL:Function_call_interrupts=0A=
=A0=A0=A0 664.00 =B1=A0 8%=A0=A0=A0=A0 +65.4%=A0=A0=A0=A0=A0=A0 1098 =B1=A0=
 8%=A0 interrupts.CPU95.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 458.00 =B1 18%=A0=A0=A0 +119.0%=A0=A0=A0=A0=A0=A0 1003 =B1=A0 8%=
=A0 interrupts.CPU95.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3941 =B1=A0 2%=A0=A0=A0=A0 +20.5%=A0=A0=A0=A0=A0=A0 4750 =
=B1=A0 3%=A0 interrupts.CPU96.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5213 =B1=A0 5%=A0=A0=A0=A0 -26.6%=A0=A0=A0=A0=A0=A0 3824 =
=B1=A0 9%=A0 interrupts.CPU96.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5213 =B1=A0 5%=A0=A0=A0=A0 -26.6%=A0=A0=A0=A0=A0=A0 3824 =
=B1=A0 9%=A0 interrupts.CPU96.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 707.67 =B1=A0 4%=A0=A0=A0=A0 +69.0%=A0=A0=A0=A0=A0=A0 1196 =B1=A0=
 4%=A0 interrupts.CPU96.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 453.00 =B1=A0 5%=A0=A0=A0 +111.2%=A0=A0=A0=A0 956.75 =B1=A0 9%=A0=
 interrupts.CPU96.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3892 =B1=A0 3%=A0=A0=A0=A0 +29.5%=A0=A0=A0=A0=A0=A0 5041 =
=B1=A0 8%=A0 interrupts.CPU97.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5166 =B1=A0 4%=A0=A0=A0=A0 -25.1%=A0=A0=A0=A0=A0=A0 3867 =
=B1=A0 9%=A0 interrupts.CPU97.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5166 =B1=A0 4%=A0=A0=A0=A0 -25.1%=A0=A0=A0=A0=A0=A0 3867 =
=B1=A0 9%=A0 interrupts.CPU97.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 755.67 =B1=A0 8%=A0=A0=A0=A0 +55.6%=A0=A0=A0=A0=A0=A0 1175 =B1=A0=
 5%=A0 interrupts.CPU97.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 487.00 =B1 10%=A0=A0=A0=A0 +86.1%=A0=A0=A0=A0 906.25 =B1=A0 8%=A0=
 interrupts.CPU97.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 3869 =B1=A0 3%=A0=A0=A0=A0 +23.6%=A0=A0=A0=A0=A0=A0 4782=A0=
=A0=A0=A0=A0=A0=A0 interrupts.CPU98.CAL:Function_call_interrupts=0A=
=A0=A0=A0=A0=A0 5178 =B1=A0 5%=A0=A0=A0=A0 -34.9%=A0=A0=A0=A0=A0=A0 3369 =
=B1 24%=A0 interrupts.CPU98.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0=A0=A0 5178 =B1=A0 5%=A0=A0=A0=A0 -34.9%=A0=A0=A0=A0=A0=A0 3369 =
=B1 24%=A0 interrupts.CPU98.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 687.33 =B1=A0 5%=A0=A0=A0=A0 +68.1%=A0=A0=A0=A0=A0=A0 1155 =B1=A0=
 4%=A0 interrupts.CPU98.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 389.00 =B1 13%=A0=A0=A0 +121.1%=A0=A0=A0=A0 860.25 =B1=A0 8%=A0 i=
nterrupts.CPU98.TLB:TLB_shootdowns=0A=
=A0=A0=A0=A0=A0 4000=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +21.9%=A0=A0=A0=A0=A0=A0=
 4876 =B1=A0 6%=A0 interrupts.CPU99.CAL:Function_call_interrupts=0A=
=A0=A0=A0 719.67=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +67.0%=A0=A0=A0=A0=A0=A0 120=
2 =B1=A0 2%=A0 interrupts.CPU99.RES:Rescheduling_interrupts=0A=
=A0=A0=A0 463.00 =B1=A0 8%=A0=A0=A0=A0 +76.1%=A0=A0=A0=A0 815.50 =B1 10%=A0=
 interrupts.CPU99.TLB:TLB_shootdowns=0A=
=A0=A0=A0 913220 =B1=A0 2%=A0=A0=A0=A0 -24.1%=A0=A0=A0=A0 693121 =B1=A0 9%=
=A0 interrupts.NMI:Non-maskable_interrupts=0A=
=A0=A0=A0 913220 =B1=A0 2%=A0=A0=A0=A0 -24.1%=A0=A0=A0=A0 693121 =B1=A0 9%=
=A0 interrupts.PMI:Performance_monitoring_interrupts=0A=
=A0=A0=A0 132379=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +62.4%=A0=A0=A0=A0 215045=A0=
=A0=A0=A0=A0=A0=A0 interrupts.RES:Rescheduling_interrupts=0A=
=A0=A0=A0=A0 94465 =B1 13%=A0=A0=A0=A0 +95.5%=A0=A0=A0=A0 184704 =B1=A0 9%=
=A0 interrupts.TLB:TLB_shootdowns=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
Disclaimer:=0A=
Results have been estimated based on internal Intel analysis and are provid=
ed=0A=
for informational purposes only. Any difference in system hardware or softw=
are=0A=
design or configuration may affect actual performance.=0A=
=0A=
=0A=
Thanks,=0A=
Oliver Sang=0A=
