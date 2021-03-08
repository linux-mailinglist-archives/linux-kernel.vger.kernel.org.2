Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93AA331ADE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 00:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhCHXO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 18:14:27 -0500
Received: from mga07.intel.com ([134.134.136.100]:56103 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhCHXOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 18:14:22 -0500
IronPort-SDR: HrmLx+fkyowolCj8emzOV3RwsJ971iFai2Xlmnf8MYj96A/O3T+LUAXZAgQ+bBNuLUsMGyXd9K
 49jKDRH06AeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="252149362"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="252149362"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 15:14:22 -0800
IronPort-SDR: 6teSNqDu7gDzNuZJMnxHQuY8Z2/tJu4WyBylV9vRYyc6f//JUJeDbuaorqUMzSDMU0MgRjYfsT
 cSra4TjlwzUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="369573335"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2021 15:14:22 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 15:14:21 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 8 Mar 2021 15:14:21 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 8 Mar 2021 15:14:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SI8TEmEbYluNpdB18klEDB/Xvl0Fr+8XF7Ev6sZPdvQI99Hax3fN+Nza9WpVcAql6iohlnO0Hncl+cZ1hLq/VOdR1Z2Wvb7gr2PcdQ97ytwsc6RrCtHCPhs+38iR559pP2Q0SiV2Rl3KI7MJjwd3wGoSNYwsAu0FvO9GHM1Xf6lZwmhPm6Zb1ZuY4uUqF2zg7MU9Xes1PBxDGUEw1nzNdaWKrmMHnVsPu+ZBQvbMJMqjIdqYW0XdH/wP0ke8V2/JZmcOTjtmxi5AYcv0Pbcux5/z6ahE4wGMvEIRJ3tWbr/QWPY4kw/balBzCbl0LR0QYy9x+PzqfahK7Z/vcuQNcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auXrk/jnJKulSgUqO0Asz/znkdgHdGl+KeFW4ViNeXA=;
 b=V1UJb3An+/VICV8Sovwx2AECqrr4f3DGHJ38UJS3oAAfzf6qktsu/oG+GoDZm9ztAPBkd6fl0JbWkzbaFy7t3QDEAwHudzXfMjTH9VaWdGdWlBEYg/Rd/z8e6LZnNqHtufT/gaSLQ0nlG8CHR7bFzysk2NB8t39G56/HlGEOVdDt6QnKPdosyhvHEVfjZmBuHHTaHL08vTJOwf8BwDwk1ypyOn43NzB6kGGJQGZgJTu6p3tNIIrCD5XkEy3RTFp2z1HLw34udd3cu04OWso92s/LryHHtaKqN/rxMztf6OP5Z5Xs4Je9dbBOsFI1G0k+h/h/tiqdEEsMZQHLemqruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auXrk/jnJKulSgUqO0Asz/znkdgHdGl+KeFW4ViNeXA=;
 b=i7qFdrjZtVAFxjS3gjpjbLUR8LgAj39uT7MU2n2UEYtvwUWvfviUGFL8BshcV4vfKrFzG23CrlH0pjP+fQXNw7VXukXSNe6vwhgTCzebhvacuNJgWIzt2b9b7vbawOrfRELUOIpuVVvQ3bEecnQSpauXIDzGYNt+9U+Qkk8tk/U=
Received: from BYAPR11MB3095.namprd11.prod.outlook.com (2603:10b6:a03:91::26)
 by BYAPR11MB3574.namprd11.prod.outlook.com (2603:10b6:a03:b1::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Mon, 8 Mar
 2021 23:14:17 +0000
Received: from BYAPR11MB3095.namprd11.prod.outlook.com
 ([fe80::e47d:c2cb:fe53:e0e6]) by BYAPR11MB3095.namprd11.prod.outlook.com
 ([fe80::e47d:c2cb:fe53:e0e6%4]) with mapi id 15.20.3890.035; Mon, 8 Mar 2021
 23:14:17 +0000
From:   "Chen, Mike Ximing" <mike.ximing.chen@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Laatz, Kevin" <kevin.laatz@intel.com>,
        "maximmi@mellanox.com" <maximmi@mellanox.com>
Subject: RE: [PATCH v10 01/20] dlb: add skeleton for DLB driver
Thread-Topic: [PATCH v10 01/20] dlb: add skeleton for DLB driver
Thread-Index: AQHW9P+hri3YEhHn10KqfTIlfsDxHqpP5y6AgAAwW4CAKqelsIAABduAgAAfS4CAABJDgA==
Date:   Mon, 8 Mar 2021 23:14:17 +0000
Message-ID: <BYAPR11MB3095E64709FC02B5ADE4334CD9939@BYAPR11MB3095.namprd11.prod.outlook.com>
References: <20210127225641.1342-1-mike.ximing.chen@intel.com>
 <20210127225641.1342-2-mike.ximing.chen@intel.com>
 <YCKP5ZUL1/wMzmf4@kroah.com>
 <CAPcyv4hC2dJGAXbG2ogO=2THuDUHjgYekkNy4K_zwEmQcXLcjA@mail.gmail.com>
 <BYAPR11MB3095C54BA878D8A5502CA891D9939@BYAPR11MB3095.namprd11.prod.outlook.com>
 <YEaFbyUM0Fu763vm@kroah.com>
 <CAPcyv4iXfBY7rrSLJrFV4KjJsM+_Z_KAeLK5bg73nT7PYqWHcA@mail.gmail.com>
In-Reply-To: <CAPcyv4iXfBY7rrSLJrFV4KjJsM+_Z_KAeLK5bg73nT7PYqWHcA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [69.141.163.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b692209-3c41-4b07-4c9d-08d8e287e5a9
x-ms-traffictypediagnostic: BYAPR11MB3574:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB357407889C62602FCDD794CED9939@BYAPR11MB3574.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nbindXhnutGPq/8u2K2jZmPxxxs+jr3wAov6ciZ6ApDGkCc8hPfuSp8eRyy0gGDn7+s6Esz0kkHLIVH9YznokX20QuOE2RLw8KxOqPEshbhSZFkHfQF/NX1T2l84Wv7FE/bbVOvggrULnwRjbXy28+d718wMSH5lMjK0ugeanuf28lavJ2Dz2NqPxldAwqYF7G/0AGjfupT8XwL9ONfw+hvkJlEvmEfuhaojm8qL4Kq0dI4OUd8zWAg3JpNZ7pau134UEm6dCyCuiH9IxPVJCZQTcNZyA/j1TD5lrlOMI2f4BRfNLTZlWiK8sAE+KBLhQJ5sxuu0vjtefASsOHo+W7W6iKzDQ09aCJKiwiCImOvqEeFa6JvxPqxzehDVycHgRaWVB9wubyLnE2DUPdB9/IchcMoYxyfKiGvePwoDnoe5PGl4bX6Azw4FLm9VnjLiIm6Ck91Zn0YvsmZ3/oMvWybXl0IoQP00ZWttJUOKqIzOPRaMsk68MuNQACfroZ6NFeWqp60oTHcwh2MS61N/Og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(346002)(366004)(8936002)(110136005)(26005)(4326008)(54906003)(66476007)(55016002)(316002)(83380400001)(7696005)(71200400001)(86362001)(478600001)(33656002)(76116006)(66446008)(5660300002)(53546011)(66946007)(6506007)(66556008)(2906002)(186003)(9686003)(64756008)(8676002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZnJMaEZzbURwM3hGV3BUMmVwTE8rSDNkSEMwM3M4SUcyczV2Z3dBQnJRYkVC?=
 =?utf-8?B?UXR4NHd4a0ZOZHk0bGxyTFFuWm52M0lKcThFT3A3NkYrWHNpbUR3bDk5cUVT?=
 =?utf-8?B?NmF2VTE2R1JnTmtsK1pXamMxY1hibXJLN3hEUE8rQitxeWoybGd1WXY5WVJR?=
 =?utf-8?B?QTMzRlU4K2ZNbDRSS3NVRkN5ZTU4ZFRJSUJqVk1BZExOa1ZneHRjeVAraDds?=
 =?utf-8?B?VVZlQ1M3UWNneFZLRmkxK0ZtRU9vOUFYYm1vTGhORi9MWGw0cEtuZHBWUFdM?=
 =?utf-8?B?OGNpdTJpSUpYbC9BaDBnNUN5MUtnTkczdnNPak5oK0sxTEcra0p0K3pBQ25L?=
 =?utf-8?B?dkJ3eEpZZC9DMTZOcmUxTEs1cW1Tdzc5czhsYmUvQ3Mvb096c2xDZTRQaHVw?=
 =?utf-8?B?VTI0TDg1N254amJJdGE2bzJHVG5SOU40emZuSlJ0eGQrWExIWWFxNndjTUpt?=
 =?utf-8?B?U3ZFbVB6Zm5FZ2Z5YnhhQWtIcENFU2hmZEgrNE5lUWN6Vnd4b3k2MWU5OCtP?=
 =?utf-8?B?ZkNKWERZUzJzR21OY2JDY2szK2hNWlhrNmFORzQ0K2xUYWdTenFmQjl1ditU?=
 =?utf-8?B?VGZrTDhnTHFPQ2trbVNYcHZTZWJEcTQyYVkwRHpYZ09uczZINWRlU2VnQ1g4?=
 =?utf-8?B?QlQ2TWc5Z3NLVFBuOFQzQnN6NkZPVE1CNmoxdStDeFp3WkdHazE5YlNIdFFi?=
 =?utf-8?B?ZDBBSEFVSHhHRSsvVXR5ek1kZzh5bHJSWFZBeWhOOStjVk1GaERDeWhOUys2?=
 =?utf-8?B?VzJtcklPRVVXUnd3OUZUenR2bSswT0NKdDM5U1E0ZmRxU253MitwOW1MdTZB?=
 =?utf-8?B?Z29IZU9nWUI2WW56T2lIK0tlenFGcC8zQ0ZEK2swMTRmUTh6SWRMNXZLNk5R?=
 =?utf-8?B?VGZlTWZpMklqMWFZOXJNd2cwYzRHckdxVjYrUlQvMlJ5YTFYcmI0ZjdmSnJK?=
 =?utf-8?B?d2hPblpVRjkzZWJ1RGRqSEsrQU9NeHFNL01TT2MvWnFJdFl1SnAvY2VDalZv?=
 =?utf-8?B?eHh1S3BaY2VON2ZTYUcrSFladjVZbUlOSkJ6aStsSFBSU1JybnZvbllMNGR4?=
 =?utf-8?B?YzQ1dnZTdEF5bEZVNDNiSENoVHl0NWx6b2s5R2NHNjgxWDJyWldKMkRnY2pM?=
 =?utf-8?B?aVdkK2N6blZ5K1BLaURydFE2RmM3NXRkcU9HVmNKS1VlYkNoUHpLVVUvYlRE?=
 =?utf-8?B?VVA0aXNpUzl6c3lYWnhKbXBPWVZYNzZ1dGc1Yy9RcGZXRmFBSzdrb1RYOVI4?=
 =?utf-8?B?dDBIT3ltbWtnU21TZ2FmcWNrQ0YwdmNQaFN3MlJRelhNNkdWUnBQUCt4UU4x?=
 =?utf-8?B?cFM0Tyt5R1NiL3pCdEpxOHFsT1NuT2lVK0hFVTJJUW5IbmRjQnRzZzI4S3NZ?=
 =?utf-8?B?b05hWk42YldpTWZ0dmhKRFZWMHFoWENDam13Wmp5SllRZVpReWJuSnBLdXl2?=
 =?utf-8?B?U1RKUkx4WTJjanpVa01XUmhaVUFiOVJNY1lhNFJPZW54TUhUR2g3Zm5Cd09a?=
 =?utf-8?B?NFVsWHhjaTNGa2xQdFcxbmc2cG5GaUFmUEg4di91Z2VrSVNSdzNEdXplTzhz?=
 =?utf-8?B?Ukp2MGhGVy9oZVBndDZFeWpLallaMExGQXBsUUtCdkNLYmpFQzhxbW5HYU5v?=
 =?utf-8?B?OU5IR2s1bE96UWZoY1BmNW1DWmxMQzFNb3dBRjFtRkcxNWZyOFBiUkxGK1dQ?=
 =?utf-8?B?WDNrQVVWNDFKOUZ6cFhRb0VxN3J2MTVzYU5ZYUJ2bG5XZkFRMC9ZT1RUcEdO?=
 =?utf-8?Q?AXhBADK/zFS9IXZb0dh+Bp0nSG8j/FQt3yZvN8f?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b692209-3c41-4b07-4c9d-08d8e287e5a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 23:14:17.3615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kOpb3N8//z/hId3hfWEWm35xfAbimajwndF9fBjndjmceRrq89i8xjaqANR0AZVAEvCKUhhxea7gIEveZ7eobbhdP/QfdrLqUdLs1260miM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3574
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbiBXaWxsaWFtcyA8ZGFu
Lmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDgsIDIwMjEgNTow
NiBQTQ0KPiBUbzogR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IENjOiBD
aGVuLCBNaWtlIFhpbWluZyA8bWlrZS54aW1pbmcuY2hlbkBpbnRlbC5jb20+OyBMaW51eCBLZXJu
ZWwgTWFpbGluZyBMaXN0DQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgQXJuZCBC
ZXJnbWFubiA8YXJuZEBhcm5kYi5kZT47IFBpZXJyZS1Mb3Vpcw0KPiBCb3NzYXJ0IDxwaWVycmUt
bG91aXMuYm9zc2FydEBsaW51eC5pbnRlbC5jb20+OyBCcmFuZGVidXJnLCBKZXNzZQ0KPiA8amVz
c2UuYnJhbmRlYnVyZ0BpbnRlbC5jb20+OyBrdWJhQGtlcm5lbC5vcmc7IGRhdmVtQGRhdmVtbG9m
dC5uZXQ7DQo+IEthcmxzc29uLCBNYWdudXMgPG1hZ251cy5rYXJsc3NvbkBpbnRlbC5jb20+OyBM
YWF0eiwgS2V2aW4NCj4gPGtldmluLmxhYXR6QGludGVsLmNvbT47IG1heGltbWlAbWVsbGFub3gu
Y29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEwIDAxLzIwXSBkbGI6IGFkZCBza2VsZXRvbiBm
b3IgRExCIGRyaXZlcg0KPiANCj4gWyBhZGQgS2V2aW4gYW5kIE1heGltIF0NCj4gDQo+IE9uIE1v
biwgTWFyIDgsIDIwMjEgYXQgMTI6MTMgUE0gR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24gTW9uLCBNYXIgMDgsIDIwMjEgYXQgMDg6MDA6MDBQ
TSArMDAwMCwgQ2hlbiwgTWlrZSBYaW1pbmcgd3JvdGU6DQo+IFsuLl0NCj4gPiA+IEhpIEdyZWcs
DQo+ID4gPg0KPiA+ID4gV2hpbGUgd2FpdGluZyBmb3IgdGhlIGZlZWRiYWNrIGZyb20gdGhlIG5l
dHdvcmtpbmcgbWFpbnRhaW5lcnMsIEkgYW0NCj4gPiA+IHdvbmRlcmluZyBpZiB5b3UgaGF2ZSBh
bnkgb3RoZXIgY29tbWVudHMvc3VnZ2VzdGlvbnMgdGhhdCBJICBzaG91bGQNCj4gYWRkcmVzcw0K
PiA+ID4gaW4gcGFyYWxsZWwuDQo+ID4NCj4gPiBJdCdzIGluIG15ICJ0by1yZXZpZXciIHF1ZXVl
LCB3aGljaCBpcyBodWdlIGF0IHRoZSBtb21lbnQuICBCdXQgdGhlDQo+ID4gbmV0d29ya2luZyBk
ZXZlbG9wZXJzIHJldmlldyB3aWxsIGRldGVybWluZSBob3cgdGhpcyBzaG91bGQgZ28gZm9yd2Fy
ZCwNCj4gPiBzbyBJJ2xsIGp1c3Qgd2FpdCBmb3IgdGhlbSB0byBnZXQgdG8gaXQuDQo+IA0KPiAN
Cj4gTWlrZSwNCj4gDQo+IFBlcmhhcHMgaXQgd291bGQgaGVscCB0byBzb2xpY2l0IGZlZWRiYWNr
IGZyb20gb3RoZXIgbmV0d29ya2luZw0KPiBkZXZlbG9wZXJzIHRoYXQgaGF2ZSBkZWxpdmVyZWQg
a2VybmVsIGZlYXR1cmVzIHRvIGJlIGNvbnN1bWVkIGJ5IERQREsuDQo+IEEgY29hcnNlIGxvb2sg
cG90ZW50aWFsbHkgZmxhZ3NLZXZpbiBhbmQgTWF4aW0gd29ya2luZyBvbiBBRl9YRFANCj4gdXBk
YXRlcyB0aGF0IERQREsgY29uc3VtZXMsIFBlcmhhcHMgdGhleSB3b3VsZCBiZSB3aWxsaW5nIHRv
IHRha2UgYQ0KPiBsb29rPw0KDQpUaGFua3MsIERhbi4NCg0KS2V2aW4vTWF4aW0sIA0KUGxlYXNl
IGZlZWwgZnJlZSB0byBsZXQgbWUga25vdyBpZiB5b3UgaGF2ZSBhbnkgcXVlc3Rpb24gYWJvdXQg
dGhlIHN1Ym1pc3Npb24uDQoNClRoYW5rcw0KTWlrZQ0K
