Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BBE3F0CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 22:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbhHRUod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 16:44:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:21155 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233302AbhHRUo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 16:44:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="216151649"
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="216151649"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 13:43:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="505806056"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga001.jf.intel.com with ESMTP; 18 Aug 2021 13:43:53 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 18 Aug 2021 13:43:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 18 Aug 2021 13:43:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 18 Aug 2021 13:43:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 18 Aug 2021 13:43:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYf3cQVcvN/mqsOdXFfvJ5AT6u0am1HhWaSy1pM4FcGa1+BqLi7iDLEODXhSFT2dJGb/r8g/L5EmutkSq66SbYVPg465IgOIcTLZebXyTSlnwlFfa3fkMPLogP9O6gn2KOTF+CoLcI/QcHoXMnKxdHP5+sE1zjeJGgZNlLGncd7gC+n/VGYxVOOdFyYJkbvOpoEJkD9bOhx8Ie4EH50QyXXvv3hBNXcBSC/24034mfmIrEPw0/mV1v3n5fabZWGlSnHqLWLX2VF0kHwcxmvm/2NXpxZnFvhbh9FMUzkHr3mA6Ek01R8dJYbiRNHltis1gJRHgxOid3elOjJtH1/NPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0dmr0hqMNqQGh9cpwe2BzAC+7L7PI9wsJBJVvaQTvw=;
 b=jUS81snBbFvfNuvikwSuWQjKvhJ7v/ezc3yD6L6r68/9KK+HCGPn+YeRdKSgTWaiMIxBMk3XOsjy6zlm7sHAb+XZWp+JSdQttHMYk2LlL4APztoogkCjFCBbYWT+5cQCaU14QHKX0Y0EZrlSc9I0gtNHaYYHFwM9+64R7xdYgKb8CayNiZzQr+IC35di0z5SPdfAqKb0WbFfZp0iVMy6V1yNdJ1ijeWvlb5tKoM0mTF8cebcJSIPNOxxgNhWbKtN5pcdFggvunO5Mm7k7C73R4HFqmvLewC3PFucqhuCkDMkyOwp+MZ2wjL3fg7q2Xz73J6U0YyoUWaTIQnN3awT4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0dmr0hqMNqQGh9cpwe2BzAC+7L7PI9wsJBJVvaQTvw=;
 b=Dj17T0KlilneSGhQMveAlrc6z9bfk4Mjq4x1uuW16ylwPMgZVvkXaZDxSZMluSS4EJ89YhCMP+qUiUfxDac8yMdLzHGVv0+GCMIOvsakvwN+BHK6GhmcVQHP/6kHdK5FWJ1PJTFfOvhjuUNUT3/hCdTJkX+ibL+Ac5N1Ctvt4co=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 18 Aug
 2021 20:43:50 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::6c9b:b5e4:1fda:78b8%5]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 20:43:50 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Macieira, Thiago" <thiago.macieira@intel.com>
CC:     "Lutomirski, Andy" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
Thread-Topic: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
Thread-Index: AQHXhVRyjpE4OXS+e0aKA8ZshCCgeqt5kHqAgAAPrgCAAAcJgIAAMaSA
Date:   Wed, 18 Aug 2021 20:43:50 +0000
Message-ID: <BCC327C2-CF9F-4910-B626-315E515E9A3A@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-13-chang.seok.bae@intel.com> <YR00U19168BGoRB9@zn.tnic>
 <3181031.RqgVF4sTRC@tjmaciei-mobl5> <YR1HYRRN0HMTxXrw@zn.tnic>
In-Reply-To: <YR1HYRRN0HMTxXrw@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d236e88-e8f7-4211-ffb4-08d96288e28d
x-ms-traffictypediagnostic: PH0PR11MB5112:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5112878BCFF58717F13F45F9D8FF9@PH0PR11MB5112.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G2XPeW4qZoSJuxyQofl/laLU/juBbZw+Jmps67tgto4mZ2Uisf2yRPdZzlsOf3DJFgiwF9JIWxtShTdW/nYxdZvvs132xFY5bvRIEmClLLEmQdql/P4eOumDb3Eg04HJypHLGgSqXR8LBDVMFfAQriX/F9yba/Njw6rPVhpYhWwQ32uVbbBIpBVCz0PkZ+pEEvqFYw9i2I0Ekb5c8/7KabF4967+lwa4eKA1y+o5HSS8FJHugoqVea/ffplcGjOl7ZBBYg0DAXFU0s3enLlIxWWMLOnPebUA7LV65BasKB/byV8ul+ZwR5jnNfOgxVGpkjG9TaiXIVRNlGNfXL2KlgUYF+48PFuX/8NGwwenpysXTUKgB96I5V0arVpjT8amaaGfemZU53bAC0fXiRqfiE3PyOCc9TuStGLWqd7AXY45AN4YLcFVbsVO6W9t+K9qAarR+5C2MXAE+OhvzIk12cJPnGB4/kx68FZlo0yhLob7vZ0UVa61jg6M24hSbiDwzMYrl9uP3EDwAs2N/5AV4ljZpSiIZGHydwjeXKvL0Sp5Ozl469xaNoBtPwkniOJ+9sLu+//ycA+6SlUysJ4CGsP0Hz+c+SfqX4vNZcqKOWRXNcRbqUP1IrqTNQqQDBiQTfG9QmRQppiYITS6fFo+aN2aaRSaOLMjNk5UBPXXzIgAgASd6UvsIIGDDAygS2gQhMy08QUtHRILfEAQbf8nRSnZTMPuCMTvN4D6k4QYMbuhCYInyQ0RdmY9ytLBO9gB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(316002)(186003)(8676002)(38100700002)(122000001)(6512007)(4326008)(71200400001)(4744005)(6636002)(2906002)(36756003)(110136005)(54906003)(478600001)(66476007)(76116006)(66446008)(6506007)(2616005)(64756008)(26005)(66556008)(8936002)(53546011)(86362001)(5660300002)(66946007)(38070700005)(33656002)(6486002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVNXTHJkbW1hWDk4Q2Z4WHRaOFRRU1pkdmV0azRramtRUXRsMWk0L292WlFt?=
 =?utf-8?B?aXVwWVNZWk5mdUZxclkrZHdIMm9ZcWd2cXh1M0dHTzg0STZJUkFJc0FuamJh?=
 =?utf-8?B?d2xVYTk3ZENCZnNVR2VYZE9ubEx1YWYraFB1MDVsYlI2djJ4c3BKdmIzaFlR?=
 =?utf-8?B?ZXc0VmhUdjliaFRUV2l2OGFxakQ4WUJPSkFlT2dCa1Nab081RW9IS0llYWlw?=
 =?utf-8?B?a0d4eUVDaXpmN2llVzk3TkFpZ2xCOUZJZEhJa091VlNtOGFHQnNkRWkvNDJv?=
 =?utf-8?B?ODlWQko2V01QV0hRclYyOWxJdDE1WTFFYmN4UVpta2ErWC94My9OU2N1NjRJ?=
 =?utf-8?B?amdmTXJCL0tZU2NSN1dVTlpkNWpoTXZES3p1dC9rcEc3UkVDbzNFaE9EQ2tq?=
 =?utf-8?B?QVUrZTNLYTRVTXVpKzZNdmRhR2JCT0IrRzBmRU8rYmV1OWFITUl5aDFmdlNk?=
 =?utf-8?B?MzJIL1NjaGROay9zMHRvc0xqaytVdTZCODdGT2tNeFpvd3pQY2g2RVdESEdV?=
 =?utf-8?B?dDQ5VzJNVEVIL2IxK09XajRha2M5eFdsR3ZUV0w3S0dXUU5SRkJjK0hLdlFr?=
 =?utf-8?B?Ym1LdHFmNEJBSkxNNlFVWU5QUkQ5MTNudFk1ZXBpbXo4ek1KSG5Zbjd0SVZk?=
 =?utf-8?B?WHpmWXdubXlZS2kyNmNzL2R2SG5ITzlGTGU4bHVydjduSzlocnVZc1lxN1RR?=
 =?utf-8?B?YXdkeVZnQ1NpeVlmeFZ6L0xhd09mSkZRYjlmVVQxQVhVcUh2ZzZuaG5VN1Ax?=
 =?utf-8?B?M2w4Z0tqL0x3cVNXakdXdFdaSEpWaFQyV3FwREhadWpQRk01L0trci9yV3RR?=
 =?utf-8?B?cWVieWQrMUU2NUduTkRIQWQ5TWtwbE0wY3pXNDdQWTVhNnNDMG1lMDF1R1FD?=
 =?utf-8?B?U2cwRE94UzU4ZWgvcTU2QlBraHNkTUhQZ2crckJaMGRiVjF0QmpRVzhmR2dp?=
 =?utf-8?B?a2RUbVdtRmIrU1JkQXpwS3RSNE9tbTVUeVJaaHRuY0JEZ0o0Z1llR25SR1A0?=
 =?utf-8?B?L3dNajY1WmV4Y2ZoNlNNK2w5NU8xMG12QkdoaWJQdjd1NnovVHo1anFnZ3hT?=
 =?utf-8?B?cHk0dml0Y1hxMmgzQnV5TVlGcG1QNWRaQ0FlcHZvNGtoQktoMnlWSFRwaFhJ?=
 =?utf-8?B?REttUU95azhZWENyMHNWSmNGdXBraGFVN1k1ZitMZ1BuOEYyRXlNN0hnV2ls?=
 =?utf-8?B?Y1ZxR29BWHVjTXg1YUV4Ti9vbkN2VjFkUUpHOUYyMHNkTm9xbGlQTlVuZEM0?=
 =?utf-8?B?cm5WYnNsa3EyZXhDSkxMVzZheFFVWElUdzk4YzFlai80N3YwU1ZIaGlqdzVB?=
 =?utf-8?B?ZGEwb0dMdkVuL0Nsa0twZWJmTTRwYy9rYllPSEIxcUVMOWUzYm02bTN3TSsx?=
 =?utf-8?B?bU5vOFdUZFVPcXRHMGUxS0d5OFg0cFFqRDVnNlh1ai9MYy9ZSGh2cHh2SHJI?=
 =?utf-8?B?VCtCVnp1YVVRODdPeEk2dVlSNG1aVEIrSXZkaDR1QTM1OWNzY3JIT2JOQVRS?=
 =?utf-8?B?ZVorTDlrMUd4SGRVT1p6SEhSVlB3Z0xoWDRHOEhxOXN3UkFHU2ZDSmlZZUpx?=
 =?utf-8?B?UW5OQWNDdGhDQ0ZqOFlUa1FDUzQvUHZxUFBZbGgvWW94Tm04cVNjOEQwQTRk?=
 =?utf-8?B?bk9iWEpRZlB1T3pHZldPVG5FcFQzdmRDRzM5bndHSFlpZEo1VFBTNWx2eDdD?=
 =?utf-8?B?QkNHRUN0K2lNQ0hKZXJNanJ2N2E3ZFpQQSt4blJxL05saVc1bkxmM3p2MGlw?=
 =?utf-8?Q?3thJQDw26iNVC4fWrSV0V0rb0EMoi/69ggYsYJW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47840064DAD2944986458D9A1B029829@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d236e88-e8f7-4211-ffb4-08d96288e28d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 20:43:50.3660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mEl4K2RsLJkNthC6u+WjGspmebXHibRJS1LA1UL9mW1PAQZoDx0iOLPo+HEH3PzU4kRKmxIBZB7NxDU3DzkcI2VGGnqZE+rI5ecTtluMw+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5112
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gQXVnIDE4LCAyMDIxLCBhdCAxMDo0NiwgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+
IHdyb3RlOg0KPiBPbiBXZWQsIEF1ZyAxOCwgMjAyMSBhdCAxMDoyMDo1OEFNIC0wNzAwLCBUaGlh
Z28gTWFjaWVpcmEgd3JvdGUNCj4+IFRoZSB3YXkgdGhlIEFQSSB0byB1c2Vyc3BhY2UgaXMgaW1w
bGVtZW50ZWQsIHRoZSBvbmx5IHdheSB0byBmaW5kDQo+PiBvdXQgaWYgdGhlIGtlcm5lbCBzdXBw
b3J0cyBhIGdpdmVuIHN0YXRlIGlzIHRvIGVuYWJsZSBpdC4gSXQncyBub3QNCj4+IGN1cnJlbnRs
eSBwb3NzaWJsZSB0byBhc2sgImRvIHlvdSBzdXBwb3J0IEFNWCB0aWxlIGRhdGE/Ig0KPiANCj4g
VGhlbiBvdXIgQVBJIG5lZWRzIGltcHJvdmluZy4gQW4gYXBwIHNob3VsZCBiZSBhYmxlIHRvIGFz
ayB0aGUga2VybmVsDQo+ICJEbyB5b3Ugc3VwcG9ydCBBTVg/IiBnZXQgYSBwcm9wZXIgYW5zd2Vy
IGFuZCBhY3QgYWNjb3JkaW5nbHkuDQoNCk1heWJlIEnigJltIG1pc3Npbmcgc29tZXRoaW5nLCBi
dXQgSSB3b25kZXIgd2hhdOKAmXMgdGhlIGRpZmZlcmVuY2UgZnJvbSByZWFkaW5nDQpYQ1IwLg0K
DQpUaGFua3MsDQpDaGFuZw==
