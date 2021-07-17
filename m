Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30393CC448
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 17:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbhGQPvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:51:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:39074 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235146AbhGQPu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 11:50:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10047"; a="198053233"
X-IronPort-AV: E=Sophos;i="5.84,248,1620716400"; 
   d="scan'208";a="198053233"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2021 08:47:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,248,1620716400"; 
   d="scan'208";a="563482202"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga004.jf.intel.com with ESMTP; 17 Jul 2021 08:47:52 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sat, 17 Jul 2021 08:47:52 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sat, 17 Jul 2021 08:47:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Sat, 17 Jul 2021 08:47:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Sat, 17 Jul 2021 08:47:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfXPBqJ+CK+0KAvyYhSX+tQ0dRKAvThr4dWBcy0oRZBBP35dfZMsuzMHAynqHvj86rNxJifBDkWVlBqegqMWl7j6KPn90cIKvv3xk359BvBcm6YhIWyM1XjNl7b7ugiQT8Jbc8TtYh+tftDRA+DNCTGep6R881iazCuyplOhkZbeNPXD3IMy4EJQMfBZj7bhhniYX/oZTpBSTcQSc9ngUNnrTpR4i98L9vZaZiVe0coZYznshq+Cv8hS1V/kmzPNlDWVVpNRqGNf505n4Xb11fLUDLrTnBj+4+vLxb/i6o4oKi1/bZasDxJsPmXyHzcw2p2bbaGtbY1U3BfVWclhXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzeeYhK2aNS4xu356pLcAMc4VTLgt8ajAbeXA1xTWdU=;
 b=HgBECWofF9FhdEfoBSoFOuWSz1zwu1Qrh7hhuGlSn1WrG+qyYFKckXPMptSxsaQkWZ7ES//TfCA1fyLUjAsb55k22GAdoHyzP7EWqHBKCvNgzRdyMDiS1N338S3zrfyrv9PXTvZNLnyzZCpOrPRYhyMM7bdyDm6j6Lg0LCmHALi0Z+fweN2pGaoE3Jrww6LE1dCUVslZO/SCSqHXSG+gA8kK+i394463M+dudn9N3rXpOosCJ0YfPUSv0fM/c5k5tgf/amBQU8xYtqmtj7amK9G3iUK9Z/GvE9bqaj6QH+ya0jVcwge6dPiyrpblkacyVdfgZisS2+VDH7Z+/FQWSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzeeYhK2aNS4xu356pLcAMc4VTLgt8ajAbeXA1xTWdU=;
 b=Q5HQ3gJmPiRHJxwcZbnMR0+4WCsm7OkMKOez7kuHVp08jUmJieo2vWzNR37IGsBFri59PWCE0GR/KzdtcAzfRZKMQnicVSivb+xlwxyBBVuGARrYxErv1exXsTU65L24BH+4jjCoeN3Lf+PAIHNEe25GCXYd4qqMn7Kqi/1R8+k=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5045.namprd11.prod.outlook.com (2603:10b6:510:3f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Sat, 17 Jul
 2021 15:47:50 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194%5]) with mapi id 15.20.4331.029; Sat, 17 Jul 2021
 15:47:50 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Macieira, Thiago" <thiago.macieira@intel.com>
CC:     Borislav Petkov <bp@suse.de>, "Lutomirski, Andy" <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
Thread-Topic: [PATCH v7 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
Thread-Index: AQHXdYzJt1bUD052k0KIfuUnAuXsc6tBSyoAgAYP44A=
Date:   Sat, 17 Jul 2021 15:47:50 +0000
Message-ID: <919EAEBF-61EF-4DC4-839C-08055C1A1F29@intel.com>
References: <20210710130313.5072-1-chang.seok.bae@intel.com>
 <20210710130313.5072-13-chang.seok.bae@intel.com>
 <1817232.MPthNTNLIG@tjmaciei-mobl5>
In-Reply-To: <1817232.MPthNTNLIG@tjmaciei-mobl5>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7206f21e-aa3b-4586-5b0f-08d9493a3b9d
x-ms-traffictypediagnostic: PH0PR11MB5045:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB50457F4C5BA3E56DC3589F20D8109@PH0PR11MB5045.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8RV2Yt7lHDyxDSNq0aH6VD0j5Kb4H+U4j1Us3UK6yz6l/FBkJqi8ALC46ohrCmJP0vzgZKAEMQahhKmduTnzVL7U1iGmc4KAMwgK/jzxNmqtfuw7RFqcvAwC/0Pf3K68Tk53qzWO0F2tElBLTYq1vxuuxFyAJtOHdE8sEc+q8fFa3joMwsYY5NVNegC5WBXUP2oFaZiJlEcZKJkg1fAgDF5lA5IcXL8Kmy9obn/dFpIGF+HhfmM2uyT6cB/WHiachzx6P7/DACIHzWUoaN1oL4mYZPiFfA/Q7UKP81lrJqyC3oXS2kwl2AVcfVrTBQsWUNj8tWaF1nJUVAPCvq+7e7/dMoa/LEacmLiP21ulhT4aXSrk9FvbYhhemXAAd76dbJhZX7zT0nqO9/QNnD59g4Tkfg8gnQOk0C//ELIxOAG2yelX5bOSdSZ4w2SX5UccKGzbp1GvAZ+3yAZZo6wcX/tu2OylgenslxIyK+nS2nr9N7qYYuDVZz0TcSx9iNhVzEDaJhtY0m+ta7mysbKFgpuTAVZp7CgDCzYF+89C37MQRDVn/GGSwEfzPnDBh3NBa1XWO+7Dl6jTsiAMIxEyt2O4CuRWvdH+9A+tuMI/AGur8g9ygnPvDww809gZhDqpnICgRXTzfAb+FYMxPzT/Dv9DLOZPKJJiL/OPa/kPugV7x7ZB9rpA/YPiB9WvOBV7wkwokXRXPUglNo41oMIeEPYz6lo9b3KXkLeAuDqRlriDhVOHurah7QoothWAYNA98Hw81r4E7iGS9PApPV3VIuU9xsmuyfK51m2U1AWO6ykQWgU9AxLll5L2OFqaNSO3qWgklk8zx6Cky7SHMH1EchzF+ZhwprSPNIH8ttT8q80=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(122000001)(4744005)(8676002)(37006003)(38100700002)(83380400001)(6486002)(71200400001)(2906002)(5660300002)(26005)(2616005)(6862004)(53546011)(966005)(86362001)(316002)(6506007)(6512007)(186003)(36756003)(478600001)(66556008)(66476007)(33656002)(64756008)(4326008)(54906003)(66946007)(76116006)(66446008)(6636002)(8936002)(45980500001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVd1ejJBeVVYd2xnN3hzdEtIWkpaanBNTUJzbzVPeDZERmR1YlBKc3FaVWNn?=
 =?utf-8?B?dENhQm9YRTJ6eHFRZXBwYi9oeHAzaEd3cmJXbzR0bHZqbjBmajcySHVuZlYx?=
 =?utf-8?B?c3NwWGhtWWQ4a0FvZWdwK3E5SFRyTmg4K0RPeWU2WldRTnlwd080SnVrUWQ4?=
 =?utf-8?B?YnpMYWx2T1FsOGkra0tLbis0TXlsSDlCcHBtenp3MkdxdHk3Q3RCMlRhUXJP?=
 =?utf-8?B?cmdDbDdzNnUvZFVKcnZJL0JZcXgwM1F5YzBBaW0wZnphSWRtWWhSelFkSEV0?=
 =?utf-8?B?d01mQlloWGxxcVg4MjRCSElDeGZNcGZpQVppdGxZUUg0V0E5QXl6aUMzUHBs?=
 =?utf-8?B?QXFZTUxJbzRXZHY2d2RZdzM1aElUYWJJMDRSKzN1azErMkhTcHEzN1hMSGs2?=
 =?utf-8?B?cTlHRzNPdStPNjhXK2xGb3F1KzNVLzJ1S01UclNXK0NRU0Nyck1oU0VuZVRv?=
 =?utf-8?B?cDZhSTFUL3dTRG5SMmlEc3RKcjhUM1ArazF4bkpDWk9EVGRLNnR1MWwySGt2?=
 =?utf-8?B?K2ZZQmlzL283eEtxUEtFczcxelNDMWF6UndQU0lqTUkrQmtsY3lwUEhyQnNx?=
 =?utf-8?B?TUl6TURhc21zRGNpTjRHK3pyU1FvZmZLbXNJVk1PemRJcmpWRmgwYVJpcTBU?=
 =?utf-8?B?U044Rm9pNjRjTmgwaGFjMndwZzRiQzR3aTJnVVJPUzVUN1dQQTQ2WW9DZUZO?=
 =?utf-8?B?SExjYXZJOW5tK1AwdGM5dVNYUUlKaXhpUFRhdXdyZzNxaERWVjJpQTBya2hq?=
 =?utf-8?B?OEl0VXVZUFpIbXVOOFhIUTZnRGFGWW10dkZQakVEUXI1OWF1U2hTcXNZQ1Nn?=
 =?utf-8?B?WFJqc25PeHptQVNxNDloTzNTR29McldCeCttcmc2ME1MRGpSTUxyWlNhTDd4?=
 =?utf-8?B?MnNwT2lCbks3My9adWJpWUllbXRlTi9GdDNUdXo3SW8zZ0FZM1dYQm9aYWd4?=
 =?utf-8?B?WDliNzMzblBpNE5CNmZ3OXorWUg4TlhUQnQzbkR3QXJTbDV5Ui9CZVRQSUda?=
 =?utf-8?B?Q2FPdU41azZFZ3hmVDlVREkwZjIvNmN5TUJXWi94V0JsVFE3ODFuVFZlK0Jh?=
 =?utf-8?B?Ym43K3Q1dGJVVEczaTdDWFQvWUZtV0x3aXJQTytyOW1lMnlrdU1RMmo4RmVZ?=
 =?utf-8?B?a3BBK1JrYkNPdWxmWG1wdDRReFU4aXVVMXdxOHFIeW02Rk11QTkzRG5VUzds?=
 =?utf-8?B?WE9PNEJUaGpISSsxSkdKQlE3d0RONHVzaEVIUGt6cWxCSU5sd3hmOFg0dGhx?=
 =?utf-8?B?a1dJN0VlS3g5My8rbGpmSDRESURibzB3WXRjWjlhZVdhWS9XRWdwMThGV045?=
 =?utf-8?B?K3ltRHJBY2QyMTJaWXRBSDBQemRIZWY4OXY0WnNmU1lSaUpxKzhIZnJTaS9x?=
 =?utf-8?B?Y3dhTDQxUzQ1MG9NM1pQb2tnZ2JtMVd3VEFZbGJVUngxekk4QlFvVTI3aWlo?=
 =?utf-8?B?SWIrUTd1RUlvYiszUkk5OW9zNDVRakJpNk43b28yQXlnT1cwbVZZSndzYThj?=
 =?utf-8?B?cEpDT1dTcDFqRENUV1RPRWhFMkJ4RkZvTnVtSmZwUGswM0lUcXBnd0NYeFBO?=
 =?utf-8?B?VStmWXR0Q1JmYW9TWXNqUkNWQnR3SXhwMjZtcGtsamorWU13Rkc4Wm9sbWlC?=
 =?utf-8?B?ZjQ4UXRxOTNWMTUrblh6VTdqUnNtZXY2d1k4M1F5ZkRsbUZQWUN1OWxXUkZs?=
 =?utf-8?B?L1lSNDZpTE93SkZmOWJlV25XdHo5VGlIV3lLTC9vZHo4bzc5d05jSWJualRS?=
 =?utf-8?Q?bfGlLbD5ymAZ681V6/3QLnFLd256/nk3Q0C4LWK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B60D0397BF6164F97886B4AFA9D15B2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7206f21e-aa3b-4586-5b0f-08d9493a3b9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2021 15:47:50.4494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YYCmJdvjDzWNxynWkpKjLeNZCTiGs8S6TSyP0YEn50UOwxq4OcunU6Gl6moXKKPe3+wsD4qQk3t0aG3RrxrxwI1Ufxl8Q2ZOebgmVdglkk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5045
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gSnVsIDEzLCAyMDIxLCBhdCAxMjoxMywgTWFjaWVpcmEsIFRoaWFnbyA8dGhpYWdvLm1hY2ll
aXJhQGludGVsLmNvbT4gd3JvdGU6DQo+IE9uIFNhdHVyZGF5LCAxMCBKdWx5IDIwMjEgMDY6MDI6
NTkgUERUIENoYW5nIFMuIEJhZSB3cm90ZToNCj4+IA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAvKiBSYWlzZSBhIHNpZ25hbCB3aGVuIGl0IGZhaWxlZCB0byBoYW5kbGUuDQo+
PiAqLyArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChlcnIpDQo+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZm9yY2Vfc2lnKFNJR1NFR1YpOw0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgfQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuOw0KPiANCj4gQ2FuIEkgbWFrZSBhIHN1Z2dlc3Rpb24gdGhhdCB5b3Ugc2VuZCBhIGRpZmZl
cmVudCBzaWduYWwgdGhhbiBTSUdTRUdWIGZvciB0aGUgDQo+IGZhaWx1cmUgb2YgdW5hdXRob3Jp
c2VkIGluc3RydWN0aW9ucz8gSSB3b3VsZCByZWNvbW1lbmQgU0lHSUxMLiBBZGRpdGlvbmFsbHks
IA0KPiBwbGVhc2UgY29uc2lkZXIgYSBuZXcgSUxMXyogY29uc3RhbnQgZm9yIHRoZSBzaV9jb2Rl
IGZpZWxkLg0KDQpBcHBsaWVkIG9uIHY4IFsxXS4NCg0KPiBPbiB0aGUgc2FtZSB0b3BpYywgaXMg
dGhlcmUgYSB3YXkgdG8gc2F2ZSB0aGlzIHN0YXRlIGluIGEgY29yZSBkdW1wPyBUaGUgRlMgDQo+
IGFuZCBHUyBiYXNlcyB3b3VsZCBhbHNvIGJlIHZlcnkgaGFuZHkuDQoNCkFjY29yZGluZyB0byBb
Ml0sDQogICAg4oCcRXhwb3J0aW5nIHRoZSBleHRlbmRlZCByZWdpc3RlciBzdGF0ZSB0aHJvdWdo
IHB0cmFjZSBhbmQgY29yZS1kdW1wDQogICAgIChOVF9YODZfWFNUQVRFIG5vdGUpIGludGVyZmFj
ZXMgd2lsbCBiZSBzYW1lIg0KDQpBbHNvLCBBTVggc3RhdGUgd2FzIGZvdW5kIGFzIEkgcmV0cmll
dmVkIGZyb20gbXkgY29yZS1kdW1wIGltYWdlLg0KDQpUaGFua3MsDQpDaGFuZw0KDQpbMV0gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIxMDcxNzE1MjkwMy43NjUxLTEzLWNoYW5nLnNl
b2suYmFlQGludGVsLmNvbS8NClsyXSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS91c2VyLmgjbjI2
