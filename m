Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C29339D2B4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 03:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhFGBs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 21:48:28 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88]:41830 "EHLO
        esa8.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230147AbhFGBsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 21:48:25 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Jun 2021 21:48:25 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1623030395; x=1654566395;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=nYWAVzXJW4zickYKiiZLzxK13ojLZv58UUXddxsj4dQ=;
  b=wXm1LpKrCgfukvs1rxFA9mzL4HZ4hg5Vzdj7P8p1LwDu4yVKsW+2U9Yn
   S+FntGyhqv/f6szpZJ8rzV2JAvMgu9c6SgF0qzEHnu7wJnk3LCjHT6cD1
   7yLfACW5xxMPXz5+GLqNHQmMhCF0T9SJTcsl+3oI3BRyoxrS0ezuSYOWS
   KDPcJz2Co/FLUoQEaunDfG7JOpTaK6YemZ2LyQYtf1B/RROkWFxqmWt0c
   tJ6xrvgWt4lId2YHMEBH77mW+yfZnVxoyifDoB8LI5zbU769MzfrxJRs3
   TKYYPTotrxS3pNRLyb1lA15YYTQECF2T8sVQJLNM7atgxq8ej17MG2eTE
   g==;
IronPort-SDR: WzcKgoyFWNsK57cUvWGHEFY3MOMmyogszm+tGqPZhkfBkBYc28NQhBtQCXINefuVWNVnFMsFIM
 daIcV16dX5sIGbKjOdc08gAERNcpK5mrlk7ziTUHEkkG5UfMX8FpXlY8fBP+YvtnzSurgZ4TDO
 UX3WF0jdFnnaA9l4T/LekS9BBRTsdOnH4UqNAeWywtgYktJSFscSpNm7ivhq+ZtPlmjpz+plxq
 yOjKTC9DHPEQJgVoFKOn5BAuaipqSGU5hUzh86F/8yk6zvpftBfTCeX9MK1D4JePjx3h0xtbjN
 5Lg=
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="32585077"
X-IronPort-AV: E=Sophos;i="5.83,254,1616425200"; 
   d="scan'208";a="32585077"
Received: from mail-os2jpn01lp2050.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.50])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 10:39:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdjauP1ap6pecEAe+LgthAVRTsuRJSYQEEWaEaPqlpvmQAhBSaqGu9UdWphzwklrpoLkvh5U62dTUPgpFYMDUoMb0MQ0TtKGWLJEk5/Cp+VPYyammKHBquXkvUCiEjcHk7DSNaEFRFexMpQkFstEugvWTTeJl/fDZlY7zkxnn+al+3f1aU9ziWlFU4TiiPVwjXkpnU/7ZCdKMfZI/Roii8Lb2Ig4CtpszqSq+pnscosMVw786nbtHcim4ZZPSAhXYDXz0ScNIDYhB41FUklUOa1cnAtczfpIVndn1ROhvdVKyRBhejJ1BB9kGh4mSJuvw5UGy7yN3KVGrrcM2DMj2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odH8YAftNpUh2OBN9LCgKZz+MCzTEt6gzKO1O9vg+Bw=;
 b=J137HaTJmqX9jSQpRLRI3Sst/iIeNjcB1R4qI963BK/oI3j64wtqVYhX4DLyxW2mVcRJJvwZPSR1VuqNCD/f4quY6xDPLGRJLecUlpD2B+Yx8pMNrb5IHFdmfCfI1YifPJdARjsEUraGqKv1b4Yqx8XrosHN3db6a5n/6gwY6hSnEFOazNJ74hA10HdNx6d1kuIAwtDUzYG8qROeFQrBVAenHaE4GKu8yFhQh9QxXfDLt8K/ZS4ORM8ztQCWNJTg2l0lbl/j/cggT9Jc43H7W6cMQ1BasVumOqtT6WEGV4qbrtJ98Fe7HB5om27v7W3pP9BqgI6YDrr6uyzx5Zv9Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odH8YAftNpUh2OBN9LCgKZz+MCzTEt6gzKO1O9vg+Bw=;
 b=RQ5pDlBFABovHQkiQFg71MHu/Yfa6Ld/HygrFzTvNamlVyv2H014k590K5kDfSZHQMkNDEgT/FqflhV6Mp2h51Cl2msxAB08tD51vToS0O3bz+F22XgW2IcFzDj5m/FxM9rtXs1aCVBL7dc7K2lxGruIOoIMm+9QBHoB3sKEPao=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Mon, 7 Jun
 2021 01:39:21 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::551c:359a:332:906a]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::551c:359a:332:906a%5]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 01:39:21 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     "'hpa@zytor.com'" <hpa@zytor.com>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
CC:     "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
Subject: [RFC] Adding A64FX hardware prefetch sysfs interface
Thread-Topic: [RFC] Adding A64FX hardware prefetch sysfs interface
Thread-Index: AddbPDa/0dTuSZ8EQoejgzf2ST6z3w==
Date:   Mon, 7 Jun 2021 01:39:21 +0000
Message-ID: <OSBPR01MB2037D114B11153F00F233F8780389@OSBPR01MB2037.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [208.127.118.75]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27072891-9af9-4341-5100-08d9295512ce
x-ms-traffictypediagnostic: OSBPR01MB4773:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB47736A673B05A4C22673F42880389@OSBPR01MB4773.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pv0MzjlViLAHSphtYQzgrVQwLCs4Z0mPTaXekmJ/h0Bmxdl35x5tEylXMv/ykXzv3H2DMtx/aR26L1bY5UTdOJPUeei8ehqvoWi3pUWSMU2Xjl6rlC53Vww8H4Aj6Poz4YmNleLVUhGw3EjWbIQF7+JsMBDQFHRn6Zh7cqBabtnBDMiEk6eP8dvKUkqw5GsLhv/fwjgmvPBAfvnOGc0yekJl6xwCUel4R2HnowV+eFHNQu8PsMGL2jwVa4eFOPpwJJXNKRBlK2kOb6zLNbOJ8EEhNswC7BrPheMecp4lArZ9qJwbnr5ag+Wm6/nlJC26OKLBUg3QionLRYtZ8Ra3PRDinhrP99XG6Foak/B9P7QbIu9+zNUkVC8/9R3fyIdrDiGtMW+ZzL8ZBAWiclbuAvfb3H43jBOhXBQvha4ITXFArIqIOodWL4TJn9r+8BM9Y+FxQTXzOknnvBV7pYuM8JdiAJ/IiLV1vyqUNTjoyzwG9jDsYRGAGYbtJPTrZcTsB7pUR5UxezJIKfovFco+GJpzGqZSQyRlOBWHefvnna26EiqbnR6SyX7+NSDAv+lb3KNf/cjsXjAdGCMSVAj67cbckDkWz2spXDh0pj9J6uXLl610dzHlQ96DJRcjpZxeoEYErKyrm97bfjsjLiWhG96/EfL9JFDZsCP5pIA2ylmU18m76L013t1XkoWhNUJHZlF3yc6sc5Dluo4THBC+0cWYjfxMTELIhFAQxwwGC7pKk8pvoOju1RS+tz3BclS+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(7696005)(19627235002)(85182001)(186003)(26005)(6506007)(110136005)(478600001)(8936002)(66476007)(4326008)(66946007)(66556008)(316002)(66446008)(64756008)(5660300002)(76116006)(8676002)(86362001)(52536014)(122000001)(83380400001)(38100700002)(71200400001)(33656002)(2906002)(55016002)(9686003)(107886003)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?WndZZ25PK2w3SnY5U3B1SC9pR2g4VVFBb3FETk1jZ1dqc3gwNjlqNm1G?=
 =?iso-2022-jp?B?RHlmbnFFRG5FZWlIOVBDZWE5YUJVandXSnVTa1NISFc1dDlkNytBbWJv?=
 =?iso-2022-jp?B?dVVlUk1VMTJkWXVVS01TaTNVNFFUVXJJOG54djd0WWR1VUxaak93M1N6?=
 =?iso-2022-jp?B?dWgvY3NYQ1FQc1NabzEvQTMycDVtNktlUjA4bG1sc2pxTGF4S2NLNFpa?=
 =?iso-2022-jp?B?ODZvSkRxaHR4RklkQklOT2pkcVFCb202NHB1SkZCVncybWdsdGtDRGdG?=
 =?iso-2022-jp?B?MGI1alN1dlhqNzVIc2JjWXdKSFl6Tyt4OUgyaE9uUVRZano2Mk5neC9k?=
 =?iso-2022-jp?B?QW5EU0dZdUxlcHpqb2FhQkQyU2tFYytKczIxYVc4MmhBTmJjeHBsNkJr?=
 =?iso-2022-jp?B?cktzOHE3dE4xK3NnRytjajZqL3lhaEdqcnFTcWw0alZ4ZDRNYVpGWStS?=
 =?iso-2022-jp?B?WTBSNUJveVU2eUZYM2RZT1RON3BnTXBPQ1Y2NXFXOWFabzBBRFhOZkdH?=
 =?iso-2022-jp?B?Vk84ajA3cXl0SGxTbW9wYUszamR2MGt0MmZZekR2UWlMV0JHUzhPOHpp?=
 =?iso-2022-jp?B?bzczOEtIeVh6ZEVQV3k2NVlXMDA2SGVHUGNjaUM1aUtBVU83eTJLU01j?=
 =?iso-2022-jp?B?RzJGVHhDWFRmM3pxbGdtOUdOdE1qT3ZBN0FDN3MwZmh5cFkwZUlSSGU4?=
 =?iso-2022-jp?B?Mnp4MVVGTEJVUlpSL0U2QUpUOEtSMEtudmwzSmZIa3pxcmM1NGNBek03?=
 =?iso-2022-jp?B?TlpBdVRoK1RPdFA3empZd2dFWkxpcjNrcFZaMzFTOUliNktPUmpUN01X?=
 =?iso-2022-jp?B?aEpiKzF4a1EvY3N1ako2TXM1d3F5UHlnbmtMM3JIdVRFTWg1NC9vK3k0?=
 =?iso-2022-jp?B?TnFDRFhjZ3ZMaG1hbDJmRGZsMkdlSXo4NFhDNDA4VVRzdzROSmloTExP?=
 =?iso-2022-jp?B?N3k2UmVOaHk2MFliN3EvOVBwUHhzUHpwUmovQyttT1FrNGVGbVkrY2lk?=
 =?iso-2022-jp?B?R0VUL1NQYmkzR0FRSDlRK1BVdGR5UVdGMkJuVERGLzkrSGFPaDVVMWR5?=
 =?iso-2022-jp?B?NE1SbU5lYStiZnR1TEliYnJvdXU5WTJWazJMeitlMkZyYXVlRUJIakU0?=
 =?iso-2022-jp?B?RFdZYk54YXV6ejFvdGpQbkh0dTRkOUNGWG5DTmF6MnpVMGdlZzVCS0M3?=
 =?iso-2022-jp?B?YnpENSs2VEdRbkcwME9hbmhoK0FWbnhXQ0toVmpqcFV0NkM4NXVuampp?=
 =?iso-2022-jp?B?UzZZdTRvaVRTTUFuNXNHZTZZejdQNnhnckJYK3JLcG9rNTBmK1BPM2ly?=
 =?iso-2022-jp?B?RDBZcVBJMHdMTFRrQnU1djZEenlDNWN6T282d3ZneUtEd2tEVjB0MXp2?=
 =?iso-2022-jp?B?SzNudnBtSEpwZ3NiM1ExSVhGZjMzandDeko2bzREZWdsSGVmL2plbU9n?=
 =?iso-2022-jp?B?MU9xOWVwaHZ3dVc5dWF1OHY2dEI4TlljVXBsbUFWQUlWTTVUVThONUJD?=
 =?iso-2022-jp?B?bnUwS2twVjRUMlJiN2tBVDNoc29janNyWFMzRjBldEpNcUZSUlJsL0dz?=
 =?iso-2022-jp?B?KzN2VUZkcFErM0NoM2FrbUxGTnlDcitxOGEwT1pKbFBFY0JxL3gvR0VO?=
 =?iso-2022-jp?B?a1ZRU3JDSjIwTGlrYWdtUXdKM25TWis3amZXMkg5RGJyczcxcGZkbTFH?=
 =?iso-2022-jp?B?alI3RFRnMmdKbjNRdTYzRE5YbEx6UENyRFdpZk5ub3dCNlc3bzhLbGla?=
 =?iso-2022-jp?B?azFNUHJ0eGVvNE9mMGlhNWlwUTN0UWpoRmd5SXhlZ0liR1hyNE1HMTAw?=
 =?iso-2022-jp?B?R09WamFnL2NkR1Zic0Y1eDZ0WnE4VFB5UXE0VDJjQzVEbDR6SmUrcXpm?=
 =?iso-2022-jp?B?ZjhXTVhRVHh5RlFJQzhrb1hlR0RzPQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27072891-9af9-4341-5100-08d9295512ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 01:39:21.3496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZDlI4lPxVMeZrXmVWxvPm5/ZmbT6rDDgsHhxB/D8ToXpkeVoAxo3QQEtQMVwGrvGivibNLcBEbaZjWhO3zNJrckJaq7mL9BpxBlVclr5zvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4773
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I'm Kohei Tarumizu from Fujitsu Limited.=20

Fujitsu A64FX processor implements a vendor specific function, the HPC exte=
nsions[1].
A64FX has some registers for HPC extensions.
We would like to use the register IMP_PF_STREAM_DETECT_CTRL_EL0 for tuning =
the hardware prefetch, but it's not accessible from userspace.
We are considering to implement a kernel common interface via sysfs as a wa=
y to control IMP_PF_STREAM_DETECT_CTRL_EL0 from userspace.
FYI, A64FX also has registers (e.g. IMP_PF_INJECTION_*) to control the beha=
vior of the hardware prefetch from the software using "HPC tag address over=
ride", but this time we don't considered.

[1]https://github.com/fujitsu/A64FX/tree/master/doc/
   A64FX_Specification_HPC_Extension_v1_EN.pdf

This register is similar to the MSR registers 0x1A4(MSR_MISC_FEATURE_CONTRO=
L)[2] and its details are described in [Similarity of each register].
From the discussion about the MSR driver, I understood it is not good idea =
to access registers directly from userspace, and that we want to move it to=
 the proper interface.
We think it would be better to have the common interface which can control =
these registers in the future.
Therefore, we would like to design new sysfs interface, could you give me s=
ome advice?

[2]https://software.intel.com/content/www/us/en/develop/articles/disclosure=
-of-hw-prefetcher-control-on-some-intel-processors.html

[Similarity of each register]
* Settings for Hardware Prefetch
  These registers enable or disable hardware prefetching for L1/L2 cache.
  The A64FX's register also have "Prefetch Distance (bit: [27:24], [19:16])=
" and "Reliableness attribute for prefetch access (bit: [55], [54])".
* Not accessible from userspace
  In the expected usage scene (e.g. User wants to disable hardware prefetch=
), it is necessary to be able to access from the userspace.
* Share settings on a per-CPU basis
  A64FX's register is used in HPC applications and assumes that the process=
 is bound to one core.

Currently, the path name has not been decided yet, but we consider of the f=
ollowing structure like cpufreq(/sys/devices/system/cpu/[CPUNUM]/cpufreq).

/sys/devices/system/cpu/[CPUNUM]/prefetcher/
    l1_enable   : This sets or displays whether hardware prefetch is enable=
d for L1 cache.
    l2_enable   : This sets or displays whether hardware prefetch is enable=
d for L2 cache.
    l1_dist     : This sets or displays whether hardware prefetch distance =
for L1 cache.
    l2_dist     : This sets or displays whether hardware prefetch distance =
for L2 cache.
    l1_reliable : This sets or displays whether reliableness attribute for =
prefetch access for L1 cache.
    l2_reliable : This sets or displays whether reliableness attribute for =
prefetch access for L2 cache.

We would like to implement only the enablement interface, if the A64FX-spec=
ific parameters ("dist" and "reliable") are not accepted.

Best regerds
Kohei Tarumizu
