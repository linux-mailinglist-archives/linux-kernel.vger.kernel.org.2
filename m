Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D037328180
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbhCAOzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:55:46 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:21963 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236678AbhCAOzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614610522; x=1646146522;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MTddNhQKTf+djEP1J4BkvBOxSfP0J9JqHldHtu+5Lb8=;
  b=M+48CpDZemre1MIWupQRMntbjkCqqYkBf266rQepgjIXhewiAOngDfmA
   8XjDYAqpk1+L3VMDAa9GT/Fd+SgqQ4T7DjujYpJrzUznQ2p0eOMNcpw1w
   XRXaQCR2tMtBdKnv2WflgveUdHzuq+0C+uGBVqJOAvmYvHshy6J26YXQ1
   RcyRw++rfLoxh0VMu5qjwAYmlkf8nmJSGL/2fiC8uUepWEdhhLHOnR+6U
   h1eZVs9TQwTyIzz5Scr1AgNSBtsl9lHFV6KkCWOmVLsde4iji0DdFg+Oq
   1o61dkhehNZvUR2660+w+XJiXSCSbnbZFvDcgYd5Lcy/wfjUbI8yc69QR
   Q==;
IronPort-SDR: xz/RJnuhHFIshKNQanySh7lcpYVOEq2PDmvvVpGW2nzJHwBsKVi7INNpZjQFmSDFUV0YnMTgO3
 ZpB32QpVMtxNK5vlU42pDGiIxcpCeQ2jlGoQo8chI3+ymski+XwAHSQwIY73QbGBWsk3pDDpFy
 wJ6VjB+93b74mRp0asgPUvmWARoqsZ+RnbyQiVZSCltp392lA+oP01Yy8zFfnVPIRrEN0yMFG7
 qGYVULeYmqcZrSs9zw+dmFKZR3QwF4SGDGG+R8qLFznln9avvKeCFeUNW2kAoqpRuS8HT2K9zd
 EJ4=
X-IronPort-AV: E=Sophos;i="5.81,215,1610434800"; 
   d="scan'208";a="45821548"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2021 07:54:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 1 Mar 2021 07:54:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Mon, 1 Mar 2021 07:54:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9b5CVkHFc58js8vAx/tj1ClDLY+A/cg0NAdteMiDb83RDi9dnD50YY8D9NRW0egVKQTpgPxdsXbnOT8vWxvLSN/hc/odjDVsT73b+WO768MXcxpiLAkLMkXMUQ9LZyI67hLf3UU+S3WCG3KfrGvYk9Ktx/yMgm5IsSNndUaILtu3A12rixhC8XGedbnfWjo6/yc8LBukJbI/VZhv0ICpARTGFVKuWSymYIOMQME1tZy1rIMMYvaicM71iOuzImH3d5SDo6BtV1YYKL8KYjIr9p+yk0BzxrrGxFLsxbHZ2kk1FBGEwBNyU8dk4ATwLYAnvqjnFOKZQ8+N9e4juIuIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTddNhQKTf+djEP1J4BkvBOxSfP0J9JqHldHtu+5Lb8=;
 b=GKWlbEKMNyqRfXl3MQa6e8/4ghzebL++1ustACfzEFsGln7rgXorsGn4M0rIMbxEsPWqz7lrsDwRuAXwzDMcOHRV9uyedHrTjw0EPGOK2151qsbPngYx4DqwPlnQEa7BzXMgEp37cr/QErDO6SLg29hnGopi5hMVSP0z2J/Yj2Eu+7F43HYAUqtZsse1C7pR59q/whYxxE8OXBC4prr88I4k7N3gnldDOEMvEJMLyOW1tX2AA7N2z9U2um9Px/CTF9oEMqiKA7NZAQ2Gf7YT/se7TGECNpvt4y+4760kcfec00rPPi1nCqhjlIPhqXuPLnXVyRSGus3stM8K9S3ygA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTddNhQKTf+djEP1J4BkvBOxSfP0J9JqHldHtu+5Lb8=;
 b=D9nDYssj8TyjyhmZBlgeJJxEiXP0giH4bme0cbU4VyKJWaE9NPiIqowOIf3b8q3CnitdRVCC7jRDcvqLOxJ7vS9eh4DmwJC6MYeXwTBIzWf8DgVxJGHlr+y4rxv16wKJsCUJeIj+nzyct/f6hSU6YJRo+EumtaoHDTmKME6Fnf8=
Received: from BYAPR11MB3254.namprd11.prod.outlook.com (2603:10b6:a03:7c::19)
 by SJ0PR11MB4800.namprd11.prod.outlook.com (2603:10b6:a03:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 1 Mar
 2021 14:54:02 +0000
Received: from BYAPR11MB3254.namprd11.prod.outlook.com
 ([fe80::5c0e:70f7:fb8e:8db1]) by BYAPR11MB3254.namprd11.prod.outlook.com
 ([fe80::5c0e:70f7:fb8e:8db1%7]) with mapi id 15.20.3890.023; Mon, 1 Mar 2021
 14:54:02 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <lgirdwood@gmail.com>,
        <robh+dt@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH 1/7] ASoC: convert Microchip I2SMCC binding to yaml
Thread-Topic: [PATCH 1/7] ASoC: convert Microchip I2SMCC binding to yaml
Thread-Index: AQHXChCIhzFRbHwtuEWTt7yBcyoXLKpvMf2AgAAPUIA=
Date:   Mon, 1 Mar 2021 14:54:02 +0000
Message-ID: <a1fce442-e182-fb88-6ee6-29e53f3c9689@microchip.com>
References: <20210223181929.444640-1-codrin.ciubotariu@microchip.com>
 <20210223181929.444640-2-codrin.ciubotariu@microchip.com>
 <20210301135913.GD4628@sirena.org.uk>
In-Reply-To: <20210301135913.GD4628@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.121.56.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b163bc81-e38b-4977-983e-08d8dcc1daa5
x-ms-traffictypediagnostic: SJ0PR11MB4800:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB480062FE2B1A4A0C66879D51E79A9@SJ0PR11MB4800.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UWNm7UI5nWcoLcI1GsMnmQJ292wj1ZTlyn5qLRndCLz0oGSS6MXGwLBR3utUMRp7KOGfN+MU/GAAQfijN67T1JiGEYqjYmlqalNu8IJxFzgH2jWWyt+7iZxdbGn4hXBdH35x5u3o2OF+X+1HJXhdpEVxei1JuOtse3ipT43VL/NrVqKZ2ILAhnWVcQgdeXfbe7GYJa4WZPEK27Lf+zHeNwPeXwGha7tgXiWlpOHZCdMElKdQ2UcxGr3qQGcSQ6sWxtUDXZ0L9L8e5cF/YwIz3lL/0PCdD45SPA6HrOnYBYlKmF6bwCtH/+ZhuLHWGeUbjHgB21L5ceiCnAXA6UrWfENgYaIgItPWfbhkhkVGLVZqU87fcdbypdmDbMiZPf5/grazRjn5KsWMW1yxuGKQV+Mr/urwyBSxD+dLAMVYECY5aYh0Zgfq/qqw/BtXQ/zu1raAon67BTCgeIgNO7v2QAv5mOP2gkOH2fI1yWAyll5s2kRHVwH8qXyRlNagFRMJPPDz/ecNU9Ef8Pm918Htd+SF3uEnFs3qkwFX/omGucnnht57T7nEKDRsb2b/g48cjzHBGb7I62B28NkxEaGKNh2kQKrB/u56aqJz5ZuPufY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3254.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(39860400002)(366004)(346002)(76116006)(31686004)(478600001)(2616005)(71200400001)(4744005)(86362001)(36756003)(26005)(91956017)(7416002)(107886003)(66556008)(8936002)(54906003)(6512007)(6506007)(4326008)(2906002)(66946007)(31696002)(53546011)(66446008)(66476007)(8676002)(5660300002)(186003)(6486002)(316002)(6916009)(83380400001)(64756008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?ODaxeI9uEaIL2GHT9xMtYb/KHDEjr+cR56vEoouR85DlPeLbbMXWHnGn?=
 =?Windows-1252?Q?vuzR0ufQd4qQtKWNjd0xbfSjasbmIALyOtoecSZcDeudkfTpNez8eVpN?=
 =?Windows-1252?Q?1DzMya1VCdtffb3Q+s4jNRVmPot09S1z8ETBJSDdqsFI/DPGbkbc96i3?=
 =?Windows-1252?Q?EurXrXfwt5lVufDWcECwZRZI+ij2fCWoCh0xQIEhDHrgENJbBT/ecZ/c?=
 =?Windows-1252?Q?BNgE251NXfSz6Ck0t5u0pS85h9TL0LCOLsZxrnLA4hNkPgMOpZsvDaZ6?=
 =?Windows-1252?Q?b3enqU1/a6axLMKB5kRSWtrAc5Kc4Qn31urEdn7Qq7fX6DSRtiVfFXI6?=
 =?Windows-1252?Q?Az3gR13Fscv/uxatJ7EsFnHVPX7DJc0mmTlKPNediNcfATSVBLAbxU7v?=
 =?Windows-1252?Q?4jxAxL4qdaQDSWuvrHzwq5AroFDt+koSfbwzCXeDGrYawS3K8OJMAyFU?=
 =?Windows-1252?Q?veqcKoLPtrfPwU7gsc1ZOB5yC7/mUdm3HFF1ptXrRyuf4zuNuyhVX9TU?=
 =?Windows-1252?Q?lDjgnPkfYB/aouYA5VFBEJTw2xi+TSY8TIw7e46G9wqtcA35hbCWL4O5?=
 =?Windows-1252?Q?RcPkox/CXoPj0rcpbTwgC98KRnqIghjNXxi7r9vWTKv6FekAg0saAogf?=
 =?Windows-1252?Q?VYsMlqAdwSr+9ambag+I/GenNBMV+B2OLRg203nCVdnHetUbkmoKkYKU?=
 =?Windows-1252?Q?QaTIXtwgtolWPP/zjqIp7qhWb962tY79QoiuOhVtPNvFM6zCrHHjbd0p?=
 =?Windows-1252?Q?aypdMdBPFxxXsEch/7I7/s8uIhY8GnPNU+pyo9HNgCIo9n8aiuinNhcf?=
 =?Windows-1252?Q?5+9snLHRC38al+KrMHs6dNM2WPAapdlslGscdpn70JBgXvx+n9lJnR+d?=
 =?Windows-1252?Q?NTXrJjEKH5LALovjmifa2yyuWdlLZbBYUUw20iettLUXv9AA/CfB2tch?=
 =?Windows-1252?Q?J3SeG5U5k2JxKuTlErE5Hpi5AENWCCdq1OJUfeKbfaycbBbvGPwKjOL6?=
 =?Windows-1252?Q?5C4YSjUfzl8PqH2FLcFaL08w2ZpIMbZSd9Sc+aFuq70LneeEGBsoTgXl?=
 =?Windows-1252?Q?LaAbSHW44Rj9hBb9bYB1Lvl/+Eauv8I3l1NvCUa7tkFBtboKl8XdyPWG?=
 =?Windows-1252?Q?FAHZfLg34stAIfKe1SrLzPhJ2Te1Q+ikxLZy3WFKQqZxk2sdgYqJnAQg?=
 =?Windows-1252?Q?30BJhQQXzd7+Jp0hr8qG2XGC/SJG/CyruD/6FbfxcLj+hs/Z0KUod7e1?=
 =?Windows-1252?Q?friCnTnW8tAbUe2qoJBKba7DsraXYhtHO6rP9wvDIDhg/et2xIZTUbLX?=
 =?Windows-1252?Q?L+93PWXOArAQDr1MrUiAGpslunphzUrXTtY7Rd/fOncsI5tfnWqp/1cU?=
 =?Windows-1252?Q?a0ud6OzwU0Flc8ibEH8xqdP/BlWYKLsULgg=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <E963C4615FCE734594AE721CFF729466@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3254.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b163bc81-e38b-4977-983e-08d8dcc1daa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 14:54:02.6440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0drql0lZIh9iEGTTOTdduhjCxT3BwsaS8K4BT/CR8WPVrZP3iiMkmh3f6tdaV/wZ0xsR4MNonIu5ao5lVIgpNWtTo1cMiD8RFS7P9JklVME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4800
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.03.2021 15:59, Mark Brown wrote:
> On Tue, Feb 23, 2021 at 08:19:23PM +0200, Codrin Ciubotariu wrote:
>> This patch converts the Microchip I2SMCC bindings to DT schema format
>> using json-schema.
>=20
> Please place any DT binding conversion patches at the end of patch
> serieses, there is a frequent backlog in reviews of those which can
> result in everything else getting held up.
>=20

I didn't know that, will do so in v2. Thanks!
