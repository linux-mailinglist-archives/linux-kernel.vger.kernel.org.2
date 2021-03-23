Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29C9346B65
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbhCWVxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:53:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:26591 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233630AbhCWVwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:52:38 -0400
IronPort-SDR: BdyCtfSClgz1OLJgaB2TKpTM6HywJPzlKo9VJwNONCxArqEjuxOj3T0LQwlQ0EHq7eTBnL3Zg4
 R7PM15/aM1Hw==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="188254592"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="188254592"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 14:52:34 -0700
IronPort-SDR: cIJCsjBYq/ZRboFdNpOVdjJQ+lupOEwfu4SRkmRGuzpwVGAGjSpDftfKFqYk1zfnsTNjnnU4Xk
 vpsyhQmGuiFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="391051212"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga002.jf.intel.com with ESMTP; 23 Mar 2021 14:52:34 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 14:52:34 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 14:52:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 23 Mar 2021 14:52:33 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.50) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 23 Mar 2021 14:52:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GS6jrQCMW8IgJhAAmwnqsMd2OAFTwNXYz5x84kpOXG77eA53usq3/rxQ6ucYTpAhfIu2hwvi5Qh8KMk65OFfD3nY65gf0Z9EmYLXoEoNEwPFsCcB3H7Q3r8SEVxMqWdiEM/Ik5foxcAShFAYDaBxlh/Ci8UzvH4oOnlNlLv5fVIscQwTf4MZoBi/BXE1kA8Tf/v7hRrmmQzlAGX2Zp2AN2SBczhCJpqJLvj0O4FxJPa5lJYf9QLudn9Agt2G1LC5jY/JeiJ3vSqc5uDJHUXNl5ouA3v0DoU5U3EMkPgW36mz06JjlPO91ngNeeQ/UIvM5D6rkA28HffEMGYGRiHPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NW/vvInaOcBhvDi7wIwBDEGJV9krxRFg9AFJajsWPSo=;
 b=Is3qmcrUYEEErWFj7XgMpHz1VBfQtvloTnZ0lRypWLPRD70rM/E8ANdTbqAJ5FbjlT5tjWFRcv87YWYVEzXxJg6VAqspyiacxnOxHgjJpaX0Bir/e1w8JhgQ+FS7vYFblGDUGPwRJSSW3IsUq5QPrOL2wUu9fl8QBCcpwBkQlmNo1pDeGTd0+uJYnrqjpI1TjFRxyq21tdwPVHrIXOamNod0RC4s97sVDPW7chaKsrYbZc4ljvTa+MIlGyx1ImMry64t2sdXvZvR4zR5auKCIwthECTH955wVOKSC6o8S+4a/jArt69Q5fMiaVReJmZovgIOi0SUvKYAuf3TgJwvkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NW/vvInaOcBhvDi7wIwBDEGJV9krxRFg9AFJajsWPSo=;
 b=Eeb0Yl0mEjp+RR3UxtqD1lQ8IUCizPdpaTzfhISkPzKKpcMIWKrQiT7q6pjpJ/FHTeQscPpVxra29BYtud2Vp92LoKIzJLGxiNIXFqSuHbqu6TIVMZt6OP6OaeMHXjhXt3e+M0uOmltBL3bq3DiUpgTEIrx9ERE+jseW1N9/1Hw=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5128.namprd11.prod.outlook.com (2603:10b6:510:39::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 23 Mar
 2021 21:52:31 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 21:52:31 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Borislav Petkov <bp@suse.de>, "luto@kernel.org" <luto@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the
 first use of dynamic user state
Thread-Topic: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the
 first use of dynamic user state
Thread-Index: AQHXCIQDYHRUMzQ+BU6HvOsZgq/N2KqNm3qAgASxIgA=
Date:   Tue, 23 Mar 2021 21:52:31 +0000
Message-ID: <571F9371-E942-49A7-BEF0-7C422F6A1F0F@intel.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-15-chang.seok.bae@intel.com>
 <87o8fda2ye.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87o8fda2ye.fsf@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a8912dd-485d-4505-42c0-08d8ee45f5dd
x-ms-traffictypediagnostic: PH0PR11MB5128:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5128107F5CED167C62657773D8649@PH0PR11MB5128.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Ojje/QXm544ItPvr12bSa/xq9Qm2Ktv+SNkRxVVsCkQDkysYyfIDZtNVcW7jAq4SR/O5/c9x/xmL7wJDZ8uDNf+RmWUYgkDBKuUGw7S4D36D4x0p5LTChER4DeVw1lINDVlMpsoMGA9EtOzoywqDQiI1BUh66k4jY7vUO1lid/SbAO+/+QvJ5O6lYqctItzP23M2tVu+Oa9y+LrVoaRZ+YVhTqpM9m1C+g8RtUtD75f6/9RhQjoarvwfVfCuaYDgWGa9/m73O9c0CaIGK73rjJzGKo8XlSxchPFdsJUa1RPY2ER9XQ7fe4zxpOXptd6MzQa/epWmQm9uwqs55C4/Q/PWSfNNDGGOAUwHleRkwgdPDVvf2hH5F7RiCadoLn9QIn5IiX4VowSbFVYvdxZNlZHcVde+46OyOxAojoIBtX0/tCch7knOiPwDCRg6+lz5aKlgWWD9HRsbeX3lOaiQ4/nvHhlvuhh9VP5bEv1jIhgiQHrRxuQ7Fm+lZyyYK78idtuuijnsA7/Ld9sZu+/HE7jeNguADgthIuxJjd0mUzIlhAKSVZ+94GRd2RsxGfOmKpSidxKBb6M3RPkhQ6XtS1QtNPFwfnER/pH6X0arFmXjZhx6736XZQzjUUxGFM1vAPREmsLr6Ha61mkARedIjU7FfeS3YU/15G4mr0R2E5R/9OYuXz0VXt/sc5ajENF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(136003)(346002)(376002)(6916009)(478600001)(186003)(86362001)(26005)(54906003)(83380400001)(6512007)(316002)(2616005)(4326008)(36756003)(38100700001)(53546011)(5660300002)(8936002)(6506007)(8676002)(76116006)(64756008)(66556008)(66476007)(66446008)(71200400001)(33656002)(2906002)(6486002)(66946007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MUN1eXFaY2p0T1RWcUtLa3ltcFBnSFVoNXV6bFFYOElGU1VlRDY2aDVaclJU?=
 =?utf-8?B?TE5CdCtVSHdjblZqSGF0WGpvUTNJcitseFJjdkhLWDBIU3EzK254eFkvb0Zj?=
 =?utf-8?B?cVptSGdUVEZKQ1c2Mi94MjJzMlNoWTBQSXFFMFJDaGE2VWNVcVZUK3pxR3ND?=
 =?utf-8?B?NlNiaU1GYkdTbFF6ek1uNTVIZ1ovdFYrM0RYV3dzVjZGaGNlWXkrOGVRY3Ux?=
 =?utf-8?B?VVNZRDRKamdyMXJoYkt1NzlxbkZ1TmRRczZKdm4xMW1DVkdvejlCL3Z5dVdr?=
 =?utf-8?B?Sis2c1NHckJjWjUxaTkzeGk4RzJlVzZQbUJiVXk3dXhQWG4ybFBOQ3ZWNnh6?=
 =?utf-8?B?RVZWcGpBN2pBdDdNWVY1aWkvQVg3NWxiaTdiZjZxaW8yMkZqYkRmaFNFcWVt?=
 =?utf-8?B?WnZCZ1FTVzMrb2F3b3RvK0JKOUhkaTJqZUc0aTJPUFBDZTZIVSt5N1pqNjFJ?=
 =?utf-8?B?bDZ4ZFVVb3BMZVhuZkFGcWsrWURacU9Ma1JMcEcwWmQzNVFsT2pYMG9zZEwr?=
 =?utf-8?B?clNaRFZSOXhxbVQxRWxLcW9MWXQxbzREUGtZQmg5d3Y2ZmFWaTdBazNVVnFO?=
 =?utf-8?B?eFZTZGFDWjZBU0xLellxUjNqTjFEUXNmVHdab1RCUlNxZWx1cWVFS2FwbTl1?=
 =?utf-8?B?QlFVeVhsNVFWM3lkcko2MGNiR1V5RngvcDBJYW1CQ1JxLzdRRkJkMjRlUzFh?=
 =?utf-8?B?eHJxTk9reWxzdEpoR1crSlRJejUvZFFnZ1hhbVFzaGFEQlEzSVVGREtwN2I4?=
 =?utf-8?B?M2hMMGY3dUdRYVQxUEZaUDFxb2Q0OEtWa0tlaTJWVFpoRVcrK3VyM1AzNTRt?=
 =?utf-8?B?QmVNNHFQd1RIWk96SXVsQkhJTFZ3V2U2Zkg5aDE0MWNrT1dzdlBIUUlPQVF5?=
 =?utf-8?B?SzEyVCsyUTVOcGptS0k3SHZIY2lTdk5IRmkveXZ2VUJpWEJFT0NtOVVjaW9O?=
 =?utf-8?B?ZGlFejZsYWpRamZHY0ZnZTFvSmdPOWdlTXNqRXdaUjBDZDdJZXErbG50M1BB?=
 =?utf-8?B?bUVVR3NHeFR6SkJxT1hPSVByTUgvTHNRUjZWWW5GZ3Zpenhsam9uL0ZCa3Jo?=
 =?utf-8?B?VGRqSVZGRENHcEZPTjhLdWpqV1UrN3JQWmxUVlBuYWU3S3VwZDQ4MVlPR3Y4?=
 =?utf-8?B?S3B6OVVWS1JhVW5FczF2RmhvT1c0YW9nRkhuWGl5TEdsQ25JOXc0eXM1dEU3?=
 =?utf-8?B?R3JaUVRXZE9yTzJYNFpQaFlwNksybmtwUVVodUNmdTA2MkZTU3dlY2p5Wmdv?=
 =?utf-8?B?VXBaTWpQZHE3MWN1SFo0Zk5lQklVaUVGQUx2MDNKRWMyUVRUSE9rQ1A0bVBZ?=
 =?utf-8?B?Y3BHZ2hMdUc0Qjltc2hjZUsrTFo4WVJ0SlNLZDNkcnBFa21ldWl4Qk52VXhh?=
 =?utf-8?B?RjZ0VWV0R2FkOGxYMndnZWpVSUd6VFRWYVlDVEIxL2RRYXF3OFZSUTRUMzdm?=
 =?utf-8?B?L3JMOTc1RDhsY3hDMTJWZW5xd2M3bkg4RVFrSWRnWjgxcUMrckUrd2pWMWJO?=
 =?utf-8?B?Wk4vbGxhMmNYNjNDc1lJOTRUSVBUQ2EwVE1Wbm1aTHdTbFFyTkx6WldWZTBu?=
 =?utf-8?B?TnhTODNKZnk1WDJWdWhRTWdsVjJmRWEyWU1jWFJWSEJWVHFSQTdPOXZOWGl1?=
 =?utf-8?B?eUQ5NXJFeGFydEtBc1AxcHZ2L0ZFWEI0bmlDbCtjbnlpOFhnYlNYYnlOaGhS?=
 =?utf-8?B?ZzQ1cUZTS0FRNDFzTGNDN2FkYXYxMDhKaE5aVmp3L0NNYzRPZS82ZmlRdUpl?=
 =?utf-8?B?Lzl6OGRPRDJZdGJvUTdxWUI3empEVFdRaUVmdU1MTHJBRnJmUk5uUmFDR2RO?=
 =?utf-8?B?N0g4ZHJhMURacHRMOExmdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F57CDF2D4E9324BAF1193976FE7D8CB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8912dd-485d-4505-42c0-08d8ee45f5dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 21:52:31.6623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wuWizkZuc10DHZANG3qgVcOPd9Uy4yJls12JqmHlv0sggG25mGj+KdOnecnXvIUkHk+xQOfYBYI0vLaPK4A6lKoHfg8TKML3vAaGwHTucJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5128
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTWFyIDIwLCAyMDIxLCBhdCAxNToxMywgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9u
aXguZGU+IHdyb3RlOg0KPiBPbiBTdW4sIEZlYiAyMSAyMDIxIGF0IDEwOjU2LCBDaGFuZyBTLiBC
YWUgd3JvdGU6DQo+PiArDQo+PiArLyogVXBkYXRlIE1TUiBJQTMyX1hGRCB3aXRoIHhmaXJzdHVz
ZV9ub3RfZGV0ZWN0ZWQoKSBpZiBuZWVkZWQuICovDQo+PiArc3RhdGljIGlubGluZSB2b2lkIHhk
aXNhYmxlX3N3aXRjaChzdHJ1Y3QgZnB1ICpwcmV2LCBzdHJ1Y3QgZnB1ICpuZXh0KQ0KPj4gK3sN
Cj4+ICsJaWYgKCFzdGF0aWNfY3B1X2hhcyhYODZfRkVBVFVSRV9YRkQpIHx8ICF4Zmlyc3R1c2Vf
ZW5hYmxlZCgpKQ0KPj4gKwkJcmV0dXJuOw0KPj4gKw0KPj4gKwlpZiAodW5saWtlbHkocHJldi0+
c3RhdGVfbWFzayAhPSBuZXh0LT5zdGF0ZV9tYXNrKSkNCj4+ICsJCXhkaXNhYmxlX3NldGJpdHMo
eGZpcnN0dXNlX25vdF9kZXRlY3RlZChuZXh0KSk7DQo+PiArfQ0KPiANCj4gU28gdGhpcyBpcyBp
bnZva2VkIG9uIGNvbnRleHQgc3dpdGNoLiBUb2dnbGluZyBiaXQgMTggb2YgTVNSX0lBMzJfWEZE
DQo+IHdoZW4gaXQgZG9lcyBub3QgbWF0Y2guIFRoZSBzcGVjIGRvY3VtZW50IHNheXM6DQo+IA0K
PiAgIlN5c3RlbSBzb2Z0d2FyZSBtYXkgZGlzYWJsZSB1c2Ugb2YgSW50ZWwgQU1YIGJ5IGNsZWFy
aW5nIFhDUjBbMTg6MTddLCBieQ0KPiAgIGNsZWFyaW5nIENSNC5PU1hTQVZFLCBvciBieSBzZXR0
aW5nIElBMzJfWEZEWzE4XS4gSXQgaXMgcmVjb21tZW5kZWQgdGhhdA0KPiAgIHN5c3RlbSBzb2Z0
d2FyZSBpbml0aWFsaXplIEFNWCBzdGF0ZSAoZS5nLiwgYnkgZXhlY3V0aW5nIFRJTEVSRUxFQVNF
KQ0KPiAgIGJlZm9yZSBkb2luZyBzby4gVGhpcyBpcyBiZWNhdXNlIG1haW50YWluaW5nIEFNWCBz
dGF0ZSBpbiBhDQo+ICAgbm9uLWluaXRpYWxpemVkIHN0YXRlIG1heSBoYXZlIG5lZ2F0aXZlIHBv
d2VyIGFuZCBwZXJmb3JtYW5jZQ0KPiAgIGltcGxpY2F0aW9ucy4iDQo+IA0KPiBJJ20gbm90IHNl
ZWluZyBhbnl0aGluZyByZWxhdGVkIHRvIHRoaXMuIElzIHRoaXMgYSByZWNvbW1lbmRhdGlvbg0K
PiB3aGljaCBjYW4gYmUgaWdub3JlZCBvciBpcyB0aGF0IGdvaW5nIHRvIGJlIGR1Y3QgdGFwZWQg
aW50byB0aGUgY29kZQ0KPiBiYXNlIG9uY2UgdGhlIGZpcnN0IHVzZXIgY29tcGxhaW5zIGFib3V0
IHNsb3dkb3ducyBvZiB0aGVpciBub24gQU1YDQo+IHdvcmtsb2FkcyBvbiB0aGF0IG1hY2hpbmU/
DQoNCkkgdGhpbmsgdGhpcyBwYXJ0IGluIHRoZSBkb2MgaXMgd29ydGggdG8gYmUgbWVudGlvbmVk
IGF0IGZpcnN0Og0KDQogICAg4oCcVGhlIFhUSUxFREFUQSBzdGF0ZSBjb21wb25lbnQgaXMgdmVy
eSBsYXJnZSwgYW5kIGFuIG9wZXJhdGluZyBzeXN0ZW0gbWF5DQogICAgcHJlZmVyIG5vdCB0byBh
bGxvY2F0ZSBtZW1vcnkgZm9yIHRoZSBYVElMRURBVEEgc3RhdGUgb2YgZXZlcnkgdXNlcg0KICAg
IHRocmVhZC4gU3VjaCBhbiBvcGVyYXRpbmcgc3lzdGVtIHRoYXQgZW5hYmxlcyBJbnRlbCBBTVgg
bWlnaHQgcHJlZmVyIHRvDQogICAgcHJldmVudCBzcGVjaWZpYyB1c2VyIHRocmVhZHMgZnJvbSB1
c2luZyB0aGUgZmVhdHVyZS4gQW4gZXh0ZW5zaW9uIGNhbGxlZA0KICAgIGV4dGVuZGVkIGZlYXR1
cmUgZGlzYWJsZSAoWEZEKSBpcyBhZGRlZCB0byB0aGUgWFNBVkUgZmVhdHVyZSBzZXQgdG8NCiAg
ICBzdXBwb3J0IHN1Y2ggYSB1c2FnZS4gWEZEIGlzIGRlc2NyaWJlZCBpbiBTZWN0aW9uIDMuMi42
LuKAnQ0KDQpTbywgaW4gdGhpcyBzZXJpZXMsIGluc3RlYWQgb2Ygc2F2aW5nIHRoaXMgc3RhdGUg
YWx3YXlzLCB0aGUgc3RhdGUgaXMgc2F2ZWQNCm9ubHkgd2hlbiB1c2VkLiBYRkQgaGVscHMgdG8g
ZGV0ZWN0IGVhY2ggdGhyZWFk4oCZcyBmaXJzdCB1c2Ugb2YgdGhvc2UNCnJlZ2lzdGVycy4gVGh1
cywgdGhlIFhGROKAmXMgTVNSIGJpdCBpcyBtYWludGFpbmVkIGFzIHBlci10YXNrIGhlcmUuDQoN
ClRoYW5rcywNCkNoYW5n
