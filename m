Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE64C3CA299
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 18:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhGOQpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 12:45:12 -0400
Received: from mga17.intel.com ([192.55.52.151]:51413 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229635AbhGOQpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 12:45:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="190958698"
X-IronPort-AV: E=Sophos;i="5.84,242,1620716400"; 
   d="scan'208";a="190958698"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 09:42:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,242,1620716400"; 
   d="scan'208";a="428859618"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jul 2021 09:42:11 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 15 Jul 2021 09:42:11 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 15 Jul 2021 09:42:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Thu, 15 Jul 2021 09:42:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 15 Jul 2021 09:42:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGQQrUSP/t2S520O1CC4gDLXMzLhzpFMHgc/Oa4sP2IomBE3d6cMv+piEvK+xVNhxebCWcLW0i1mZw7UqVzvPAb6D7/DBWpr5h7J4HuEb75+cJ0zg5mjT5Ts8Tx4lc6ibb2O1eXVRgvsA8Aw81fTPNG9Lye6EE0kzJRmA5lpGGNn43vf3YJt4Gzfug/mjlQb6rtJaWvYGqhfzO7W6QI5y9jBfPZZapRJHx3bnEwt290Aj4ukXP1bXwFyR/DYOT4fIcau94bg7hZokOCusu5lfSwwN/vySmnJgfNNsAwo2SMCdTrRSAL6oHazWSKtUWPf7bri9YVAC4ix7OGWypktAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFpBaYLaVSYZ/nY23JZd6mgFX6YxX+kBbVunJNceDuk=;
 b=XxrY12CXjx+v6AS8AeOySzEkrKVibl/exgjxS8DCHlSRiI2Qmmgz6Jhm56a0cu+BAXzgQv7Yrqxnm9eP89pRe2wrvvGo+h4mARUtbZl1Tg4e5mTHk7uU7e/dmJv6neAP8mX9sPFtkbS8YG1XchKD3SX2fvLZvJMoV3KOIKa8Q0VHZliFU7NInYIeh5QlcdjQfoliZW3GzN0boRm/SgJBOqjBVqbi77Z/ekPQV0tZdTrBd5xqVYkH166P52pVtlaSfjFDUkeYIck1AZBnooqbWz6OWJXLB7A8FtIrbSxkvKHo0H8ZBDj794QDfJT/Xb6HtXMVXCFcnAHUiMgOmX05+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFpBaYLaVSYZ/nY23JZd6mgFX6YxX+kBbVunJNceDuk=;
 b=gCCqYstAV+OdXu5DfCWGZZBErlvqeb0Omsqk7rWaNmwqY4BLiS18EivqwssYC6o8kx/OhwBeBE+L1dkM8rVouL6Ui3NJEHtyF/EI925SYqZmskJfdlB839eqE8DM7T6arD7bzw196CpOvWE3z6ab5+eWro5p8v340n+VZcXDr7g=
Received: from SN6PR11MB2589.namprd11.prod.outlook.com (2603:10b6:805:53::12)
 by SA2PR11MB4971.namprd11.prod.outlook.com (2603:10b6:806:118::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 16:42:05 +0000
Received: from SN6PR11MB2589.namprd11.prod.outlook.com
 ([fe80::357a:ba5:ee4f:d5f1]) by SN6PR11MB2589.namprd11.prod.outlook.com
 ([fe80::357a:ba5:ee4f:d5f1%7]) with mapi id 15.20.4331.022; Thu, 15 Jul 2021
 16:42:05 +0000
From:   "Winiarska, Iwona" <iwona.winiarska@intel.com>
To:     "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "jae.hyun.yoo@linux.intel.com" <jae.hyun.yoo@linux.intel.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH 07/14] peci: Add peci-aspeed controller driver
Thread-Topic: [PATCH 07/14] peci: Add peci-aspeed controller driver
Thread-Index: AQHXd2rgJ2vtBAF9sEOGUwpyjZOFA6tAWaGAgAPoOAA=
Date:   Thu, 15 Jul 2021 16:42:05 +0000
Message-ID: <787288238eba562e1e1927469c7e8dbb2b4912df.camel@intel.com>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
         <20210712220447.957418-8-iwona.winiarska@intel.com>
         <b894ba5e-e1ae-e5dd-87be-dc33912dd5c0@infradead.org>
In-Reply-To: <b894ba5e-e1ae-e5dd-87be-dc33912dd5c0@infradead.org>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fd327b6-2fab-4858-555d-08d947af7b03
x-ms-traffictypediagnostic: SA2PR11MB4971:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB4971FE592B1B7F0622AEF02DEC129@SA2PR11MB4971.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gyxKdI7QMvk0+6w7NUHnDBn2JaXeNoqiufa40DMoqAyZHBQaFExPM6FvcGs8eAxxxPfD3ooDgIYnlPlHVR24si/hia/ZJad7XISv90pUoxQPho7WUmaiU7/AkncoJVTi89xQv8VemoUnBQF60oI5WJLgVSs5TSw8g8QHy4PyAlZRTHpWQq32rJQp8obiuTYNshukUWRiEaUVv7L5lE59zc9+mvqRF/F7jnCfliOQ7/zrjtfLkZhVjGZNE0XXPyMI4HLICLSOa6GlrSAcRA1RLe6LkUDBWiYEhwci+ha0207sQ3wXuA4XJizh+m/KXTH+TmIy6vRqlPm8QV4ZuZFXOPvhmvqz0tXWjtfQ4PBrH3x1E2JIG7mdpQGIyO/zJsFNGY6baLaIpw/pzg6IUVvVxDGdDsB5FXQQqln3UjoYP2t/I0/7sMHDikuhe5TK4yTfcULY/18tiZBDB4kkIqGz1JA51pXxNJAOWE/eFugn1iqAyTiUDbbusPPXBOD0EA827TOKZnl2YolvbohNO/rwmPnqt73D9ruz+ZWXK0QfeHd8wfatA7lwDcEW+iXuGsGBnjXZeNXdtsbgcL8BRXhoDH3V/LgTUNaWwNiPYr+aGpRQ75wh5bknt3MQ92/KnqaOmRNmZPH/fHUl2jn0eBIWlKl5Di2Xwvu/74gJsWhR57zdknyxknrqsKGKq3tqci831CAiHRhhAaoViHaeS+NlgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2589.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(53546011)(6506007)(7416002)(26005)(5660300002)(186003)(64756008)(66556008)(66476007)(91956017)(2616005)(316002)(66446008)(478600001)(66946007)(76116006)(8936002)(54906003)(8676002)(2906002)(38100700002)(122000001)(36756003)(6512007)(6486002)(86362001)(110136005)(4326008)(4744005)(71200400001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTcvZmJMOCtnOG15ajhrMXJtUzVQdWdHZVBKZlVtRENmdkJvNHFoZHUydnRU?=
 =?utf-8?B?ODVHTmdDZjdsT1FaNXltNmJQcWI3eWhOOHBScUF6MXF2Wm41a2t5UG96ZVNS?=
 =?utf-8?B?SUpDNXQ2OEQ2M1Fvd1E1Z3h3Q0hpQ01rcFF1WVBmQUtQQ2dVZzFPM2NxR1V5?=
 =?utf-8?B?Z0J2Q0lINjNLTit4bmg1eVhlNXlMazcraS9oeVUrbGVJcS9aUEF0VUpkVXkr?=
 =?utf-8?B?eUdISFAySlVOU0srUTRrdmpZd1kyT2UybElSSVB0eUhLUkprNkl5Mncybmhu?=
 =?utf-8?B?ajNZTVJ0OTI0SE9WaElyTmlXcTZpRkJ1cjBpblFZbmt4d1RnKzF6dkVKcGZP?=
 =?utf-8?B?RTFiMEtaQUdkOTVWS0F4c1o2MzVHU1pjV1pqcXluckJHK1lBY0FEM2kwZkdI?=
 =?utf-8?B?ejJScHE0b3lrbFZmWUZqQk9HMVJPbzFUSklmL005WWpiVVN6Ylk2akEwZWY0?=
 =?utf-8?B?KzBGVUVpcENTbE4zSXRpejcybWRwejNraHBybEQwcEJsejVEWDgrMEZBTEJm?=
 =?utf-8?B?NnJJMFpYbW0rdWsxY2ZHM043UzhTVjE4QjB6ZmgzNUpBQXpDZndkcEEzZ0hV?=
 =?utf-8?B?RC94YjU2Zjc3SVAvREtQdDRSWEs0enpTTFFUUHZxRmxCMHNZaTFlNVVLc05G?=
 =?utf-8?B?MW92ZGV6eWx4RUtVQUxOMnJDTHdhbjhLWTF1eG9WTDg3cmNESTNMdVo2c0dW?=
 =?utf-8?B?ckZGQXVzbDhkSUVDSndhRnZ1cXBoRVpQb1Y0Ynl3dVR6NHVkSWxLYmhCN2tu?=
 =?utf-8?B?bXFsZUJoWVg5RlFKSEtmVXYrWWdmRnk0VW85MjZURUw3WTJTekU2RlFUVUFj?=
 =?utf-8?B?YXNqMklLY1NIRmpUNWRiRitpc1VnbTRKaEJJRmNYWndxYkdxM1dZRmlxdnJ3?=
 =?utf-8?B?SlRoK0J2S3RCTWZOL0dzSUF5bUJpVkUyVkZaVitvdXBqL09GT0JiOWk2a0tk?=
 =?utf-8?B?L29oNUs1MDFUdm95bVBrNGtNMlJCZnZWYVM0MUlhOWxicjh4bGF6YkdUd0dq?=
 =?utf-8?B?dzRveVhoZ0IxcUR3Tzc1WW9Db1p3TUE1WTE3bWwrM2ZDZkhjU3Q2bEZpaXBm?=
 =?utf-8?B?NDg3R3ZSV252c1gwZUR6aGEwR0NQOGRPWElFWnZ2cDVQcGFKZlNCakdXRGU0?=
 =?utf-8?B?OTRZYjRYQnh4N2JxVGFseWtqRXpMVWN2SmxoN3FrS3FQNkRnTVEwWVFOMWJF?=
 =?utf-8?B?NVRtU1poYmZzaFBhZUR5Mzl2bWxCczVuV0J3d0xmOHhBQ0NKb1JJVW1vOVRE?=
 =?utf-8?B?L0ZvbW4vY2Fsa3dtRldIbERLWFhCbkpxQklmTUxMclp6SDF4cXBTTXdpQkVX?=
 =?utf-8?B?d1FuQW1RZ2EvODYydjN6OHBONjFkL1MzZVYrTUZWMXBGUXFQOFVzdkhZTnRH?=
 =?utf-8?B?Rm9DTnpMbjBHRkRLUEdVWmVrZGMvMXhZU2JHVEwrU0N6MG9YV01LZ0dlN3E4?=
 =?utf-8?B?R2wzVm1ENElTREx4c1NxTmZVckV6NDFOQ0ZSeDlNTTV0OWg2aXBhbHRNdlpJ?=
 =?utf-8?B?bm1IdW96M3lMQ1l2eUxQRnNKaDdyM25vbXpkUDZpNTNUVytIbWkrc3hueXcx?=
 =?utf-8?B?N2NHMGhwK0VWdHo1enBVRkxNbDV1U3NKVTI1elpoUUxJUFFTZmY4cGJyY0x5?=
 =?utf-8?B?NFZnVUJIaFp6VGQ4ejI0cTM0c294RTJuVTM5cHA1MlVIN2E5VjdYdUtMMUtX?=
 =?utf-8?B?YVJONHB5Z0ZxUkdyTnF2UnFhRTRDbS9zajN3KzRtQkNhQk1kZnZMekZlU1li?=
 =?utf-8?B?ZXZ2ZGxaanpVMXcvWXVueFArbVdIYkdDYmR0Q285ZjRYU3RQV0ZuRnlrYzNk?=
 =?utf-8?B?S3FIVTN4SjhTTzBobGNpZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B787E8B3692894BA90BD5E7C6604444@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2589.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd327b6-2fab-4858-555d-08d947af7b03
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 16:42:05.6751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 856WZrpK8XFTVVYUCiM/uvi03hI5YI5C3i9zitx6vqqBia77bK6P7YinZ1JF/PdL7XkKfoZFkPKbiYNfiGnm35OSDCMeJNcSo635QNOO/l4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4971
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA3LTEyIGF0IDIyOjAyIC0wNzAwLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+
IE9uIDcvMTIvMjEgMzowNCBQTSwgSXdvbmEgV2luaWFyc2thIHdyb3RlOg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BlY2kvY29udHJvbGxlci9LY29uZmlnDQo+ID4gYi9kcml2ZXJzL3BlY2kv
Y29udHJvbGxlci9LY29uZmlnDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAw
MDAwMDAwMDAwMDAuLjhkZGJlNDk0Njc3Zg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9k
cml2ZXJzL3BlY2kvY29udHJvbGxlci9LY29uZmlnDQo+ID4gQEAgLTAsMCArMSwxMiBAQA0KPiA+
ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCj4gPiArDQo+ID4gK2Nv
bmZpZyBQRUNJX0FTUEVFRA0KPiA+ICvCoMKgwqDCoMKgwqDCoHRyaXN0YXRlICJBU1BFRUQgUEVD
SSBzdXBwb3J0Ig0KPiA+ICvCoMKgwqDCoMKgwqDCoGRlcGVuZHMgb24gQVJDSF9BU1BFRUQgfHwg
Q09NUElMRV9URVNUDQo+ID4gK8KgwqDCoMKgwqDCoMKgZGVwZW5kcyBvbiBPRg0KPiA+ICvCoMKg
wqDCoMKgwqDCoGRlcGVuZHMgb24gSEFTX0lPTUVNDQo+ID4gK8KgwqDCoMKgwqDCoMKgaGVscA0K
PiA+ICvCoMKgwqDCoMKgwqDCoMKgIEVuYWJsZSB0aGlzIGRyaXZlciBpZiB5b3Ugd2FudCB0byBz
dXBwb3J0IEFTUEVFRCBQRUNJDQo+ID4gY29udHJvbGxlci4NCj4gPiArDQo+ID4gK8KgwqDCoMKg
wqDCoMKgwqAgVGhpcyBkcml2ZXIgY2FuIGJlIGFsc28gYnVpbGQgYXMgYSBtb2R1bGUuIElmIHNv
LCB0aGUNCj4gPiBtb2R1bGUNCj4gDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjYW4gYWxzbyBiZSBidWlsdCBhcyBhIG1vZHVsZS4NCg0KVGhhbmsgeW91IFJh
bmR5IC0gSSdsbCBmaXggdGhpcyBpbiB2Mi4NCg0KLUl3b25hDQoNCj4gDQo+ID4gK8KgwqDCoMKg
wqDCoMKgwqAgd2lsbCBiZSBjYWxsZWQgcGVjaS1hc3BlZWQuDQo+IA0KPiANCj4gLS0gDQo+IH5S
YW5keQ0KPiANCg0K
