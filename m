Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EB13051CC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbhA0FOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 00:14:50 -0500
Received: from mga07.intel.com ([134.134.136.100]:53833 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239594AbhA0Er1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 23:47:27 -0500
IronPort-SDR: QlbPEZh+ubB+5NX+VBMt7GtqDVAs2uBudBAxWlH4VCmYdOvvp8mbpiCehcP1p7afdLnJEIbR8X
 y8fXas2jfZHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="244092780"
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; 
   d="scan'208";a="244092780"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 20:46:42 -0800
IronPort-SDR: yCluNDb5gj63h/4PMYVsTVXzFwyQ2oUZCbwPcg25/Ag3zWPyNx3qMe+FuWYvHEuw8rx6zN95vT
 33vJxrWDV4fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; 
   d="scan'208";a="473019899"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jan 2021 20:46:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 26 Jan 2021 20:46:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 26 Jan 2021 20:46:39 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 26 Jan 2021 20:46:39 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 26 Jan 2021 20:45:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpRrLLiWZQxETVfLGyMtZpRio92KTTjzfH8P1C4UuifwyqwwrnE62mfJ40WBmY5LiWwWZQeYqJEDLsQRzX7LFlGW8d8vxo4eRfMQFz7Ohi0obcXO6GBgazYlbttEH0FCHMG54uQ+OrVV1GL2uzhOImwkVY24L3tbrlo3/b+e3JuAXcI3EawA2ZeglJnFSOsPZHEPMnAAYiaCcHj/Sg+1Zjp55TVkdkwwbK0AMahZxwRfxg8KrZkfgY3MTTWinZVw4Gl21YDqtEBy/q/N5bUcaqabXtLwIIa+C++XXHFO8aWPg01sZn+zGSlI6SWrWQpty803GHJ04nkH+kwoTMCU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdj0XF70xDLlWcNzJwJ+2zOgDUUOhVVLsw8CvoG/CmQ=;
 b=JVeBitFqW38WJJ6o4iwPIaox8iZXRXqfgFQezhhRumSBCBSv/tjyzGxGAbKHMiPnpIJHbmo6LWe4Wo6dpFeuy8QanPWNQZMC0FSKZFLLh5vNrjUqTInCt6mN+FeG3sCA0c8b5qC0ZXKZrHdKFB3w8rSqeNiWYe+NxkFHp2HSbICHbRVZP/Z1vHK0J68UY5+F8fvAEXOO4PEEcDvZJ5SH/F8u6pt6vk9gOF1hy1mL/2LOVBH2kB48/W3qLHdIxuTM1Hce9dAKe8EPzlPxYHzqAJTR+2GWqERTamx+JZoHfrQGk2dhQ+it+hnHS42OxWuADaY8khmpfpIk21Y7kmiMjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdj0XF70xDLlWcNzJwJ+2zOgDUUOhVVLsw8CvoG/CmQ=;
 b=o23JnDg331TRZCzXZnry2Cc7ItywQ90YmAvV0LYvmSXAWgTcLiGSyUVKicPdGsOaR8Z6UGqAagmTnpFHsyJNVnura0orcZuewyFHMznrHbeEF1EqJb+F3kkbU2zPOi99HxRp2dSHX40vRnee4eBy13ELBtLCTRpWDHTirabta4E=
Received: from BL0PR11MB3234.namprd11.prod.outlook.com (2603:10b6:208:65::14)
 by MN2PR11MB4552.namprd11.prod.outlook.com (2603:10b6:208:263::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Wed, 27 Jan
 2021 04:45:19 +0000
Received: from BL0PR11MB3234.namprd11.prod.outlook.com
 ([fe80::d19a:edde:cd0:9835]) by BL0PR11MB3234.namprd11.prod.outlook.com
 ([fe80::d19a:edde:cd0:9835%7]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 04:45:19 +0000
From:   "C, Udhayakumar" <udhayakumar.c@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        "markgross@kernel.org" <markgross@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        gregkh <gregkh@linuxfoundation.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "Palmer Dabbelt" <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "C@linux.intel.com" <C@linux.intel.com>
Subject: RE: [PATCH v2 29/34] Intel tsens i2c slave driver.
Thread-Topic: [PATCH v2 29/34] Intel tsens i2c slave driver.
Thread-Index: AQHW5gTl099PmuE5tkyFIEjInFJNy6ojmUQAgBWBXoCAAIemgIABX+FA
Date:   Wed, 27 Jan 2021 04:45:19 +0000
Message-ID: <BL0PR11MB3234D58C7FAEC017B580851BE2BB9@BL0PR11MB3234.namprd11.prod.outlook.com>
References: <20210108212600.36850-1-mgross@linux.intel.com>
 <20210108212600.36850-30-mgross@linux.intel.com>
 <fe1aad31-a536-4f0b-e817-b795890f4b45@infradead.org>
 <20210125233935.GA13745@linux.intel.com>
 <CAK8P3a0V5wFYypYDXbVFQvzbjL5K0Gp0j+Zfg_7-5vML1B1-Cg@mail.gmail.com>
In-Reply-To: <CAK8P3a0V5wFYypYDXbVFQvzbjL5K0Gp0j+Zfg_7-5vML1B1-Cg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.167.43.243]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee6ab163-cb40-4683-1780-08d8c27e59af
x-ms-traffictypediagnostic: MN2PR11MB4552:
x-microsoft-antispam-prvs: <MN2PR11MB455259ACC47B87E6C6ACC8C2E2BB9@MN2PR11MB4552.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DFlehDVXzEyTml83Mj5yI7i0EmNu7ULjfPiCkFWzMOdgkZTueiHO+Mv/KEbHwqD5IvBXL1LkxGZbyjUaFAuxRagjufuEUOmxZBPYo6M/Ovg6cyPbdqIBHOkuy4xADo+Q+h677CgfqzNAlNnoAOe45coJ34VP/J87zeHMc0lpJUtxIiOfZpiL6h6t0Y2roNZ4Y9IzY6gZlXqsurZcTqRTQYC7YF+CTkWdm1w8b0IinT7cAQlCLKLWobKB/EMkh2PrjC3bvG8+7pxZIod0vgtw1pZBfGSDVKWeox0ns+Y/2P1UtW8Dn1sTS1yyqX/TKYMquSeBFAcqPisH/P5fJjQam84tzhnKwNEqJCSTCduYNKgg/iNmAC9WOv/2SXl+hjIqN89/DB8Lmmph7rKGyoX279JAx2TkzqfnHerfJbezR6/8P5y0iIhYBDM3HSnkg/8zPCn2NjiRBFGyyGRrsxtF2uzKpjb21YU2UteJjVdsvZ87w46GvEsneQjGQSpMx08v2LRHfhlfRkQwbD4UujIUwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3234.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(8676002)(6506007)(86362001)(7696005)(71200400001)(53546011)(2906002)(8936002)(54906003)(478600001)(33656002)(110136005)(5660300002)(4326008)(83380400001)(52536014)(76116006)(186003)(55016002)(9686003)(26005)(316002)(66446008)(7416002)(64756008)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SW1qcFZFZ3pzRklVcWRRZmlPcU1nbHZiaXNWREtuQ0ROQnUvSWk3aDlqcUdP?=
 =?utf-8?B?cHoycHlnZklRSy9oTkozSytXT2hNNmRVYW1vdUd5OW92S0JrdlU2SmkrQmZl?=
 =?utf-8?B?WVVaNGl3U3ptTjQwS1E4eGV4ZE1sUExNUStHS0Q0ZFcxWjNRV0lDSmVLU1Zv?=
 =?utf-8?B?V0wwWmtGM1RZSktuZUVYQlpteG1MMW9VbWlldlBTaDdSVW1Vb0RCY2lYaTl3?=
 =?utf-8?B?RzBBVTFqTWEzMk1HYnZwbEJEM3JXcjA3SkoreDBIb2pjRjROUzRlV2dZR2Zj?=
 =?utf-8?B?UXVFaEFHNkJVcVZmVmV4NkFCdVdmS1pLNVlEU2xHRjhkYkNqSkRnSTd5aWRW?=
 =?utf-8?B?MDY5WVZoLzY1RzlvT0R0SnVLbm5XRXl1YVhLQTVNYjJhNmF6OGJMdkVxTUlS?=
 =?utf-8?B?TDJYakhIZExkSXNLZTZkblVMbEFVOEpCMEFWRnpvVHlzbFZKUDRvNTViWWdn?=
 =?utf-8?B?RjR0U05qTDV6QXNMOGZlZlFVSnBCY0J3RldzZkdsQy9hZW1vcFVXbncrVElp?=
 =?utf-8?B?Yy96M3JDQks5b0dlMGhseEtYdTJGbmFRcUJsKzlhYWYvbDV4Q0JqZmV2cDBN?=
 =?utf-8?B?S1N1KzFmTUM3WUxzRUYzcVBLLzJXTHVvYkNuREY0dXViSEVwVFFQVmkrblM0?=
 =?utf-8?B?UG4vM2RFK0hTNkNlMit5VE5NeWdoSU1LWXJkbHZsL1BObGpjM3pwQ2RaOTd2?=
 =?utf-8?B?cEVNdzczN1dJZ0pwUVVoa2xmRk5UMUF3OTBBR1ovYlkra25ma0JDNFRqT3la?=
 =?utf-8?B?dGtXVkFKb29MeW0rTnJwbCs3UmFwTyttZGF4T09KQ3RsSzdVQVk3ZTU3N1lI?=
 =?utf-8?B?N0pPME5LbFhGUDN1TEt4RVY5NHJaT1FPYjZ4TzEyNjk4TThXNkxhVTNVL2tm?=
 =?utf-8?B?QiswVmtCaWthSWlGYnBzTWtZQ21xY2FFQ3ZlMDVVTnBPN1F3dGNUNUxrWGVW?=
 =?utf-8?B?M2lkVHJEM0VTbnhPVlQ0ckgvTG5RSTlvVnB0OUhncFhzb2VqZ2hNWnRXWlFB?=
 =?utf-8?B?cXdUQzFXRUUzTnhzNkk5WGFvMHFxV2ZqcG41WlR1NFU4VmpORHhQREQybG5h?=
 =?utf-8?B?RFFCQU1BV2tpblRzZGVONXpEVWlzM3JYd2NtdHd3dHRIWllFRVMwcXRhbFQx?=
 =?utf-8?B?N3Y0Q0Zrc0FaaTZiVlpCNlZHTXA2SnBKRUN5Q095QmFCT3laRjB2ZmpYUnpp?=
 =?utf-8?B?UTV4cWxjZW1YcUI1ZUhZUXFSeHlZd2Rkd3Y2Vit5V25LRFczNnJ2aFRLVER2?=
 =?utf-8?B?NktzMXpNcG5vSG11SkpacjFNTVFnTGJGRHlnaFFHdHRQNWZCMG9QWjViZWhK?=
 =?utf-8?B?QlNIMytoZ2dRdnFaZnU1MnU0VWlheS9qQWRMdURWVzByUWRUWW9jQmtWd1hz?=
 =?utf-8?B?Z2cwS1dQZ2lxcHltRTNzT05tV0NkblQxZlBTQithVU1Jd3E3UWZEMTN6Sm9E?=
 =?utf-8?Q?3uHqChAf?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3234.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6ab163-cb40-4683-1780-08d8c27e59af
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 04:45:19.8030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZHd7+3qDlHgn6tmdXSy0lZ3iDJrrxwwSfutrSkeeP+beRLqzLmvpHtIHG1tyIOFpjSjElg2iYC4NkqVkMhKYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4552
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUdWUsIEphbiAyNiwgMjAyMSBhdCAxMjozOSBBTSBtYXJrIGdyb3NzIDxtZ3Jvc3NAbGlu
dXguaW50ZWwuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IE9uIE1vbiwgSmFuIDExLCAyMDIxIGF0
IDExOjE1OjA2UE0gLTA4MDAsIFJhbmR5IER1bmxhcCB3cm90ZToNCj4gPiA+IE9uIDEvOC8yMSAx
OjI1IFBNLCBtZ3Jvc3NAbGludXguaW50ZWwuY29tIHdyb3RlOg0KPiA+ID4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9taXNjL2ludGVsX3RzZW5zL0tjb25maWcNCj4gPiA+ID4gYi9kcml2ZXJzL21p
c2MvaW50ZWxfdHNlbnMvS2NvbmZpZw0KPiA+ID4gPiBpbmRleCA4YjI2M2ZkZDgwYzMuLmMyMTM4
MzM5YmQ4OSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9taXNjL2ludGVsX3RzZW5zL0tj
b25maWcNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9taXNjL2ludGVsX3RzZW5zL0tjb25maWcNCj4g
PiA+ID4gQEAgLTE0LDYgKzE0LDIwIEBAIGNvbmZpZyBJTlRFTF9UU0VOU19MT0NBTF9IT1NUDQo+
ID4gPiA+ICAgICAgIFNheSBZIGlmIHVzaW5nIGEgcHJvY2Vzc29yIHRoYXQgaW5jbHVkZXMgdGhl
IEludGVsIFZQVSBzdWNoIGFzDQo+ID4gPiA+ICAgICAgIEtlZW0gQmF5LiAgSWYgdW5zdXJlLCBz
YXkgTi4NCj4gPiA+ID4NCj4gPiA+ID4gK2NvbmZpZyBJTlRFTF9UU0VOU19JMkNfU0xBVkUNCj4g
PiA+ID4gKyAgIGJvb2wgIkkyQyBzbGF2ZSBkcml2ZXIgZm9yIGludGVsIHRzZW5zIg0KPiA+ID4N
Cj4gPiA+IFdoeSBib29sIGluc3RlYWQgb2YgdHJpc3RhdGU/DQo+ID4gQmVjdWFzZSB0aGUgSTJD
IGRyaXZlciBkZXBlbmRzIG9uIGEgZmlsZSBzY29wZWQgZ2xvYmFsIGkyY19wbGF0X2RhdGENCj4g
PiBpbnN0YW5jaWF0ZWQgaW4gdGhlIElOVEVMTF9UU0VOU19MT0NBTF9IT1NUIERSSVZFUg0KPiA+
IChpbnRlbF90c2Vuc190aGVybWFsLltjaF0pDQo+ID4NCj4gPiBVZGhheWEsIHdvdWxkIHlvdSBj
YXJlIHRvIGNvbW1lbnQgZnVydGhlcj8NCj4gDQo+ID4gPiA+ICsgICBkZXBlbmRzIG9uIElOVEVM
X1RTRU5TX0xPQ0FMX0hPU1QNCj4gPiA+ID4gKyAgIHNlbGVjdCBJMkMNCj4gPiA+ID4gKyAgIHNl
bGVjdCBJMkNfU0xBVkUNCj4gDQo+IFBsZWFzZSBtYWtlIHRoaXMgJ2RlcGVuZHMgb24gSTJDPXkg
JiYgSTJDX1NMQVZFJyBpbnN0ZWFkIG9mICdzZWxlY3QnDQo+IGluIHRoaXMgY2FzZS4gQSByYW5k
b20gZHJpdmVyIHNob3VsZCBuZXZlciBmb3JjZS1lbmFibGUgYW5vdGhlciBzdWJzeXN0ZW0uDQo+
IA0KV2lsbCB1cGRhdGUgaW4gdjIgdmVyc2lvbiBvZiBwYXRjaC4gVGhhbmtzIGZvciBmZWVkYmFj
ay4NCj4gICAgICAgQXJuZA0K
