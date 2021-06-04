Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7587A39B5D1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 11:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhFDJWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 05:22:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:55435 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhFDJWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 05:22:52 -0400
IronPort-SDR: v+qOCBIhVv8Rf8oEndWtxCpA6RNbsUt0D1Gdm33Qef1irz1alkKnVi13u9cFwnnMjudWFlpg7H
 LXSRbKS7Sz2Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="184627192"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="184627192"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 02:21:04 -0700
IronPort-SDR: 4EHU3w+Tlvghc3xeOQZT/NTjyWZlVQdv/NLoMzNHDpGsFP/Nfq3bsXxgMR2ApqDdbVvX6+5Zgu
 Rl47SWOYUAqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="551111725"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jun 2021 02:21:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 4 Jun 2021 02:21:04 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 4 Jun 2021 02:21:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Fri, 4 Jun 2021 02:21:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Fri, 4 Jun 2021 02:20:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMPVIZFJFGt3cdSzpFqMvqOLeycRXyLfwMKPqJRlUV1/AmlorC4hwZTskM2/kS3s/eKIUOAfK5zhGeGsHwC3zaTOl0gIjuFGZ6weoV9QEmiNetQnEb6wkiy6IegLdLPv4CH6gIZjQiw6Uf/GbtHLJKhIL5ivLKirXLfsnfUIUKyINYMQgu5PinCj0LPYFUs0JmHRFr3fyrYw0m96h9eOLjRyhjKvriIZzyBAOXF6ePNvvzG2vMNPg5VtachaM+ULSqQQVMhvbF7U6BB7kPZ2C/bUH3qKb5mpbsTK9DrTNxqXdE4INAuTp97e3eetGOV4ZzaP8ASdmcTLKCImuz/qYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eH9MqO9MrF8ln+I2E+WhZUjNK5nj+uQWWlHRE7w5kjE=;
 b=KQ0y/V6modQ6aN9XmWkdNEH5gtEyOOLJDuJMP8qbzSVUs3DQx0ifsTztGpv+8qOK2gKWYcgKcOAg0CIvKCLgjK9IwnpDpo78cbu+sC2N11TzAVr2VvwqDC4kgvRvbc5Zr03CxZveo5UqUqE9uBurh0E8DBo+6aJ6ultn9iC8oLPoAtdLmTCL23QOCnOqNPc1MTPzrxDa/r0YSJoqV7E63aLSTTjfr8psSbCFstvgAXCuNfixjUsBZ7tQ1hjOljx/eBS4EPYarwtexExy+8+5gInGhP9kjPWBMFqY3XpVHJzfrQ/IpEEnCSb+vHLP6BrFcvndo7I5KPjQLYSdmiBnpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eH9MqO9MrF8ln+I2E+WhZUjNK5nj+uQWWlHRE7w5kjE=;
 b=zVuISAAJ5Mpe6jm696sc+8U9oD5r6uHhP2XLvQExZztHp1IppxZTUdcNizqq4wI3Vqv+l1Vxev75fecw1dRaxUcsCRhDSQ4X19tdQDGL0xJds38WB1xbYn/6a7aqUgSJb/pDs95Pvclk9MDqgmVxI3GdMxCPEkZeX3mZKKFlimY=
Received: from BYAPR11MB3128.namprd11.prod.outlook.com (2603:10b6:a03:86::27)
 by BYAPR11MB3382.namprd11.prod.outlook.com (2603:10b6:a03:7f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 4 Jun
 2021 09:19:58 +0000
Received: from BYAPR11MB3128.namprd11.prod.outlook.com
 ([fe80::c34:1c49:28df:c09d]) by BYAPR11MB3128.namprd11.prod.outlook.com
 ([fe80::c34:1c49:28df:c09d%6]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 09:19:58 +0000
From:   "Sanil, Shruthi" <shruthi.sanil@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v3 2/2] clocksource: Add Intel Keem Bay timer support
Thread-Topic: [PATCH v3 2/2] clocksource: Add Intel Keem Bay timer support
Thread-Index: AQHXUsM/OAHnK3YooUyOS36J+8hohqsDi7SAgAAT7AA=
Date:   Fri, 4 Jun 2021 09:19:58 +0000
Message-ID: <BYAPR11MB312880A1CAF52DE4C3B690D9F13B9@BYAPR11MB3128.namprd11.prod.outlook.com>
References: <20210527063906.18592-1-shruthi.sanil@intel.com>
 <20210527063906.18592-3-shruthi.sanil@intel.com>
 <a532a5e2-9d27-f529-ec8c-fec28e648666@linaro.org>
In-Reply-To: <a532a5e2-9d27-f529-ec8c-fec28e648666@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.179.80.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab51e311-23dd-46fa-7dd5-08d92739ecd1
x-ms-traffictypediagnostic: BYAPR11MB3382:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3382ABBF7BF8367EEBC94A9EF13B9@BYAPR11MB3382.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3x9y+L0Lgo2KfA69tgTZBis/V8DzRyZj5zb2DTStWO7TDKB0WKMdXH7juvQyCDapkpEp/Abjgl97DzU2N7ifUts0G0lBdZQzYakJ00zDEv4Jde+w+IgtunGlSOlx9RfOO1cc2xZXHgiDGFcMBLR0WQVsNFBxq6lRr151jy6sQDAaYHNZ2K18xt93kACkaM5Eq9qX2xt8mRnfAl5A0mJJBmjVNYmFKXxnQgk7YYwSrRB1lMnvqKwwhgmknV6iGM8/ABznhPEIh5mILOf9DlO1xPoRQphpV5dJ+IaEg3Yiz8mU+m/nTUpnsUuYIlyKKf9ScqKEJ1sdeQ6cDhdya7vJAt/pYGwJOBedm8XfXmqohp6JUep9lXDh5zDqYzThuy6O5c5UzOjfdXMT8WRykGjrc20Gr3zqSRBPtIr3dMyR9wG3KdUyob/wnARB1XBIhQTIIv2wNwACLjdnS9nh4ZO69wz+X58IkJ5QxLQ5HHB9xbBhYkBJ8zM2ARMBC4i0GqgF+2lVObardXiLKxuqnHPFbtQFKJV9a3Y/fXHv1Rx6p7YPZFnqoDYaxy3TDbdJkcCItYV/3csgGu2PEF9ul7CN0yxRve8bPNt8FzPxtP92SJyFm5tZiVc4La4TjgV7b0KNhHmBk/2pZE7H+HNLIQ2LfmBgcKkXv030HQ1vkSLZnsNs6eKHPLi883HQyL350QlDNSjVwasV4C10XHljZ+r/kRIX53nLZAZTRqRM0ZnZUvBzC3khNfzuxUAjYq2itxLZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3128.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(136003)(346002)(39860400002)(316002)(110136005)(66476007)(2906002)(5660300002)(66446008)(76116006)(64756008)(66556008)(55016002)(66946007)(54906003)(52536014)(33656002)(122000001)(8676002)(71200400001)(8936002)(38100700002)(7696005)(478600001)(186003)(4326008)(86362001)(53546011)(9686003)(6506007)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TnFZMzFRbEZwSUFtUU9ZRTRjbCtIUWMrYlI4ZFlkZ2VNb2RpSHJoRURtREtr?=
 =?utf-8?B?cllyZk5WdklNdGovL1JGUGdTY084bmNTSlY0MFhEV0U5ZUpBSXd3VjVKOFRF?=
 =?utf-8?B?SVVQakh1RFgvQ1JKcmNRcnpqNHpnanUwYWcwdm9GSmtBSU9LbGZCNDZtVjFW?=
 =?utf-8?B?THUyQndQc2Vkb21mM2prNEhDKzhuSE9RcUxDM2ZVVFkzY0toNnFobVZVdmxV?=
 =?utf-8?B?Q0dQNEFFTSt4YnQ0SklxN1FTYXBuSk16MWU0c3g5MHZIWVZ6azdmZDRETFBn?=
 =?utf-8?B?cTdCcjVBSkVlRW1jWUVQNi9vYy8wMnRRWU8vMnQ0Y3BvY1ArWWdxSVN1S2xI?=
 =?utf-8?B?N0dUWGhQNmk0VDJxWFduVjVDOEVYZmp4eXBmSFEvSk1QWi9DZzBSWGg2RDJK?=
 =?utf-8?B?ZCtOWDNQdGthb0lRdFVVSDhJTHl6ZUluZlJ6VWJyNXJIcnBTWldldkQ1VFRv?=
 =?utf-8?B?KzZMVWdFOXFmZ0xmcElublFKQlRtYVZFd05XcXVwNTBtMDM2eUNxVlR5MlJ1?=
 =?utf-8?B?UHlBUlZZRXYrUmxCZGZIZmJ3Y0R1ZGlxUmdwSDk5WjNPU3Q3enBqVGx3cits?=
 =?utf-8?B?cHdJQVJZTFZobjRPR0lRMXlpZVhSMFpZWkZ6cVg1U09iV2xkWlN5QUdFazdw?=
 =?utf-8?B?UDFMQXVnNHhxU1FNenJ6U2pBK0luY2NpdURYNkE4R00yUFIvQko5UU5meXpB?=
 =?utf-8?B?SVUrbnNGZDRaQk1oM0dHaDJFQWlkNlRXek9sM0JFVExlUVhCM0xId3phZm1H?=
 =?utf-8?B?OHZaNDBIa0FhelpCRTdnWUVCL204RDV0S0xZWWdFRFo3dXFIOHhwOW1IZmdN?=
 =?utf-8?B?MkhZdUxTTFNWVnNGUGQ1YytadEpwL2ZWUXZQVHNabE1lTm1odi95emlVc3Ju?=
 =?utf-8?B?SWhBS3ptTDlrdGxMWUVZWW5pNlkyMjRUQkpkRE9uTTlMRlltOWd2Wk5TQlg2?=
 =?utf-8?B?aEJlTUVzbS84eDlqa1lncVg2aVZnOVJpUENBTDAwWkgzb2l0Y2YvNmZROFlP?=
 =?utf-8?B?MFMzbGs4SkU5MGN2K3M4MEhuTCtsQW52VXVSVEMzRWpnMHA2SWRyNkRaMi9p?=
 =?utf-8?B?OEVpb0oyMWRXUEpkYnFmRnFJMStVRVE2MWVOdXRPL0NjNlZMZzlzN1VrMTNZ?=
 =?utf-8?B?MWNmZmJQTXFreno5dldpSkFJNllzalNaSWM1Vy9aMHBUQjIxbFhyZ2tCRGJY?=
 =?utf-8?B?QUl3QkdUK0pxWHk5SmJ2N2JES0kwQVlpSmEyT1BTVkJ5d2ZVWHcyQlNsK1Z3?=
 =?utf-8?B?NjVQK1JwNW5UL0E4K3NOSHc0SmkxUVpwR20rZHdwei9mbmNLRzkrcWFwNE5V?=
 =?utf-8?B?ejRyTUVWQkVVYTB3akdYZ1NuemNQVWt4d2RMRWE4ZnNtSzhWSTUvQmJEejFV?=
 =?utf-8?B?dXE3ZGIxcEIzT0ViZTdWNURhR2paWS9VVlNqNzlYSW1BbzQ0K01NaE1LdEls?=
 =?utf-8?B?dUJ5eEJQZkk1UHZLV3hzdDU0MFBnVXNPQ2dEK1JFS1Y4WDYySjNiQk9yeHgv?=
 =?utf-8?B?MlVwakpqREM2eTdDTWVKbGplYnZPTGxTbStyWUdReWJpQ2dsNWFHcGM4VjVY?=
 =?utf-8?B?TDFjdEdWZ1JJRjI3NXh4Z2V4YTFQSFhab0VOZlROWlgwVmVuR1VpWmNtVDBp?=
 =?utf-8?B?cHdMS2dkK3pVTU5HZmxWanFVUWt6NGZXZTh2Zk9LSzNtam5hTFd0VTlsTVRi?=
 =?utf-8?B?TnRjQjQ0aUFPWXVmQ0NqMGh4ZVlKSmwxSy9vYktVcUJQM3UyYm04STZrT2J5?=
 =?utf-8?Q?y9KpBC9SsbSsL/hRbuzd3e/yL51YUiBhPd+ZrLD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3128.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab51e311-23dd-46fa-7dd5-08d92739ecd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 09:19:58.8537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WLyv4ulZR9ctE9Wrj6LHUt/Jy56hPz1FmVl8qX0QeBUkyTuI0sRTtGI1DPx/MwurlalpWT+ewOOqclFV443K5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3382
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuaWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmll
bCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIEp1
bmUgNCwgMjAyMSAxOjM3IFBNDQo+IFRvOiBTYW5pbCwgU2hydXRoaSA8c2hydXRoaS5zYW5pbEBp
bnRlbC5jb20+OyB0Z2x4QGxpbnV0cm9uaXguZGU7DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcN
Cj4gQ2M6IGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbTsga3Jpcy5wYW5AbGludXgu
aW50ZWwuY29tOw0KPiBtZ3Jvc3NAbGludXguaW50ZWwuY29tOyBUaG9rYWxhLCBTcmlrYW50aCA8
c3Jpa2FudGgudGhva2FsYUBpbnRlbC5jb20+Ow0KPiBSYWphIFN1YnJhbWFuaWFuLCBMYWtzaG1p
IEJhaSA8bGFrc2htaS5iYWkucmFqYS5zdWJyYW1hbmlhbkBpbnRlbC5jb20+Ow0KPiBTYW5nYW5u
YXZhciwgTWFsbGlrYXJqdW5hcHBhIDxtYWxsaWthcmp1bmFwcGEuc2FuZ2FubmF2YXJAaW50ZWwu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIvMl0gY2xvY2tzb3VyY2U6IEFkZCBJbnRl
bCBLZWVtIEJheSB0aW1lciBzdXBwb3J0DQo+IA0KPiBPbiAyNy8wNS8yMDIxIDA4OjM5LCBzaHJ1
dGhpLnNhbmlsQGludGVsLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBTaHJ1dGhpIFNhbmlsIDxzaHJ1
dGhpLnNhbmlsQGludGVsLmNvbT4NCj4gPg0KPiA+IFRoZSBJbnRlbCBLZWVtIEJheSB0aW1lciBk
cml2ZXIgc3VwcG9ydHMgY2xvY2tzb3VyY2UgYW5kIGNsb2NrZXZlbnQNCj4gPiBmZWF0dXJlcyBm
b3IgdGhlIHRpbWVyIElQIHVzZWQgaW4gSW50ZWwgS2VlbSBCYXkgU29DLg0KPiA+IFRoZSB0aW1l
ciBibG9jayBzdXBwb3J0cyAxIGZyZWUgcnVubmluZyBjb3VudGVyIGFuZCA4IHRpbWVycy4NCj4g
PiBUaGUgZnJlZSBydW5uaW5nIGNvdW50ZXIgY2FuIGJlIHVzZWQgYXMgYSBjbG9ja3NvdXJjZSBh
bmQgdGhlIHRpbWVycw0KPiA+IGNhbiBiZSB1c2VkIGFzIGNsb2NrZXZlbnQuIEVhY2ggdGltZXIg
aXMgY2FwYWJsZSBvZiBnZW5lcmF0aW5nDQo+ID4gaW5kaXZpZHVhbCBpbnRlcnJ1cHQuDQo+ID4g
Qm90aCB0aGUgZmVhdHVyZXMgYXJlIGVuYWJsZWQgdGhyb3VnaCB0aGUgdGltZXIgZ2VuZXJhbCBj
b25maWcgcmVnaXN0ZXIuDQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogQW5keSBTaGV2Y2hlbmtvIDxh
bmRyaXkuc2hldmNoZW5rb0BpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hydXRoaSBT
YW5pbCA8c2hydXRoaS5zYW5pbEBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIE1BSU5UQUlORVJT
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA1ICsNCj4gPiAgZHJpdmVycy9jbG9ja3NvdXJj
ZS9LY29uZmlnICAgICAgICAgfCAgMTEgKysNCj4gPiAgZHJpdmVycy9jbG9ja3NvdXJjZS9NYWtl
ZmlsZSAgICAgICAgfCAgIDEgKw0KPiA+ICBkcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLWtlZW1i
YXkuYyB8IDI1NQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgNCBmaWxl
cyBjaGFuZ2VkLCAyNzIgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9jbG9ja3NvdXJjZS90aW1lci1rZWVtYmF5LmMNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9N
QUlOVEFJTkVSUyBiL01BSU5UQUlORVJTIGluZGV4DQo+ID4gMDRiYWJmYThmYzc2Li43MzU0M2Vk
NjBlODQgMTAwNjQ0DQo+ID4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gPiArKysgYi9NQUlOVEFJTkVS
Uw0KPiA+IEBAIC05Mjc4LDYgKzkyNzgsMTEgQEAgRjoJZHJpdmVycy9jcnlwdG8va2VlbWJheS9r
ZWVtYmF5LW9jcy1oY3UtDQo+IGNvcmUuYw0KPiA+ICBGOglkcml2ZXJzL2NyeXB0by9rZWVtYmF5
L29jcy1oY3UuYw0KPiA+ICBGOglkcml2ZXJzL2NyeXB0by9rZWVtYmF5L29jcy1oY3UuaA0KPiA+
DQo+ID4gK0lOVEVMIEtFRU0gQkFZIFRJTUVSIFNVUFBPUlQNCj4gPiArTToJU2hydXRoaSBTYW5p
bCA8c2hydXRoaS5zYW5pbEBpbnRlbC5jb20+DQo+ID4gK1M6CU1haW50YWluZWQNCj4gPiArRjoJ
ZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1rZWVtYmF5LmMNCj4gPiArDQo+ID4gIElOVEVMIE1B
TkFHRU1FTlQgRU5HSU5FIChtZWkpDQo+ID4gIE06CVRvbWFzIFdpbmtsZXIgPHRvbWFzLndpbmts
ZXJAaW50ZWwuY29tPg0KPiA+ICBMOglsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvS2NvbmZpZyBiL2RyaXZlcnMvY2xvY2tz
b3VyY2UvS2NvbmZpZw0KPiA+IGluZGV4IDM5YWEyMWQwMWUwNS4uMDhmNDkxY2Y3ZjYxIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZl
cnMvY2xvY2tzb3VyY2UvS2NvbmZpZw0KPiA+IEBAIC02OTMsNCArNjkzLDE1IEBAIGNvbmZpZyBN
SUNST0NISVBfUElUNjRCDQo+ID4gIAkgIG1vZGVzIGFuZCBoaWdoIHJlc29sdXRpb24uIEl0IGlz
IHVzZWQgYXMgYSBjbG9ja3NvdXJjZQ0KPiA+ICAJICBhbmQgYSBjbG9ja2V2ZW50Lg0KPiA+DQo+
ID4gK2NvbmZpZyBLRUVNQkFZX1RJTUVSDQo+ID4gKwlib29sICJJbnRlbCBLZWVtIEJheSB0aW1l
ciINCj4gPiArCWRlcGVuZHMgb24gQVJDSF9LRUVNQkFZDQo+ID4gKwlzZWxlY3QgVElNRVJfT0YN
Cj4gDQo+IFBsZWFzZSByZWZlciB0byB0aGUgb3RoZXIgdGltZXIgb3B0aW9uIHRvIHNlZSBob3cg
d2UgY3JlYXRlIHNpbGVudCBvcHRpb24uIFdlDQo+IHdhbnQgdGhlIEtjb25maWcncyBwbGF0Zm9y
bSB0byBzZWxlY3QgdGhlIHRpbWVyLCBub3QgdGhlIHVzZXIgZXhjZXB0IGZvcg0KPiBjb21waWxh
dGlvbiBjb3ZlcmFnZSBvciBleHBlcnQgbW9kZS4NCg0KT0ssIEknbGwgY2hlY2sgYW5kIHVwZGF0
ZSBhY2NvcmRpbmdseS4NCg0KVGhhbmtzLA0KU2hydXRoaQ0KDQo+IA0KPiA+ICsJaGVscA0KPiA+
ICsJICBUaGlzIG9wdGlvbiBlbmFibGVzIHRoZSBzdXBwb3J0IGZvciB0aGUgSW50ZWwgS2VlbSBC
YXkNCj4gPiArCSAgZ2VuZXJhbCBwdXJwb3NlIHRpbWVyIGFuZCBmcmVlIHJ1bm5pbmcgY291bnRl
ciBkcml2ZXIuDQo+ID4gKwkgIEVhY2ggdGltZXIgY2FuIGdlbmVyYXRlIGFuIGluZGl2aWR1YWwg
aW50ZXJydXB0IGFuZA0KPiA+ICsJICBzdXBwb3J0cyBvbmVzaG90IGFuZCBwZXJpb2RpYyBtb2Rl
cy4NCj4gPiArCSAgVGhlIDY0LWJpdCBjb3VudGVyIGNhbiBiZSB1c2VkIGFzIGEgY2xvY2sgc291
cmNlLg0KPiA+ICsNCj4gPiAgZW5kbWVudQ0KPiANCj4gT3RoZXIgdGhhbiB0aGF0LCBMR1RNLg0K
PiANCj4gVGhhbmtzDQo+ICAgLS0gRGFuaWVsDQo+IA0KPiANCj4gLS0NCj4gPGh0dHA6Ly93d3cu
bGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0g
U29Dcw0KPiANCj4gRm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZhY2Vib29rLmNvbS9wYWdl
cy9MaW5hcm8+IEZhY2Vib29rIHwNCj4gPGh0dHA6Ly90d2l0dGVyLmNvbS8jIS9saW5hcm9vcmc+
IFR3aXR0ZXIgfCA8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby0NCj4gYmxvZy8+IEJsb2cN
Cg==
