Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECD341FE5E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 00:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhJBWNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 18:13:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:17620 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234063AbhJBWNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 18:13:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10125"; a="205901459"
X-IronPort-AV: E=Sophos;i="5.85,342,1624345200"; 
   d="scan'208";a="205901459"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2021 15:11:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,342,1624345200"; 
   d="scan'208";a="481803221"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 02 Oct 2021 15:11:48 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sat, 2 Oct 2021 15:11:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sat, 2 Oct 2021 15:11:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sat, 2 Oct 2021 15:11:48 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sat, 2 Oct 2021 15:11:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrmHfVqgXr+lAQreRxpJU07v0Ig1jCSgD4Sy26DFpN92UzVLBw227AJWtS70yf8WboABxI0qofAHi2s5Vk5QDGpurEJMfBYM8isdsoIlF6uLtmBGPRUNK0KEfANkNwNfBFspxqEGWdJEknHCtWITL6WQrPPXUq1M0YdfdrRiTNXyUDLbJDqdJdBq+vhoGoP9ZpbXEFYSgKHE1clTJ6sOPQCL0HZgUG6Xc+kcfNF0OXrYyOL30ibRvupW+i4u71OEyZItMD9mbtJI0epe9wrmdVvNfb+vxIGgTx8HXTaNWmcKz8qySeHmPqQdVnxjWQHShyjbu80vRv3RKzNRoHxxxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayUoh59syjiM8BJjkxiN2iyXwb9c88vajprRdHmlRmo=;
 b=bJ5y58qprZyeA6rtaV7w149xLQd6T58Ni/+VOOQQpFzHi5ugZc1dai9DB1v88ft/byVUIDVhhCtJE5/6W+JWIXLWrCeW3d4MRtuqtRFsBNj+xuz709Fpxt39q10rW2zM/Eg3Vyuh+fJ2nB6+G2WWrmgK+tBQLR5n/e23SxK4ovCccJxanbznbU36glSa5KTtT+0kCovJBJ3lMjkrFbidXSeUdWDf8ZlhtKJQHz+C34rA3OLOY6dDR5Zp784i2FlYDCIz+jOf7+1qypEMIl84j26uv72lx19e+Qspcn1Pga0B6xKJeYPgTFQ/0vyE8tAE8N+cEjanDjRRaxgavkhx6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayUoh59syjiM8BJjkxiN2iyXwb9c88vajprRdHmlRmo=;
 b=y3mAZ40NKTKRRrZbwGueTpgE11gFKkfUu/sFFgYPnUDxWC7UVUopvIPzOTwkSJGutPmzXDP9jKaw5llBom4gIOXDjwn4nxwahly1DCnMlpUEywXmK5Hu0/J5y/HhkU90NEc50tvzNf94+OYOMA0060alUv/C9futq3o1bQ0+r88=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Sat, 2 Oct
 2021 22:11:42 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983%3]) with mapi id 15.20.4566.022; Sat, 2 Oct 2021
 22:11:42 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "bp@suse.de" <bp@suse.de>, "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 00/29] x86: Support Intel Advanced Matrix Extensions
Thread-Topic: [PATCH v11 00/29] x86: Support Intel Advanced Matrix Extensions
Thread-Index: AQHXtxXjpXjC3Qk5Sky+qg9KSaDYk6vAQgwAgAAEuoA=
Date:   Sat, 2 Oct 2021 22:11:42 +0000
Message-ID: <5677A76F-82AA-458A-A910-C92E8B0C1061@intel.com>
References: <20211001223728.9309-1-chang.seok.bae@intel.com>
 <87mtnrgkij.ffs@tglx>
In-Reply-To: <87mtnrgkij.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c4a5fe7-13c6-4518-b01c-08d985f19d6b
x-ms-traffictypediagnostic: PH0PR11MB5013:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB501344FA8970BEBEEF2E0C07D8AC9@PH0PR11MB5013.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:626;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KKxv/qbRlxPBOpmGDRHbs07Yc9MQUVLsR35l6I0QoAaUHD1DEgrdpLyHqqVhwwIz67hIWoowkpzJpU1hId4DWTPuP4MmHfVS7zdJs+92+0UwlRJ9tOQpuLaUx1LDQR1gb6TgaEqwcZ+8JelQAqIPxBxqOyrqOoxP1i4pg15aeWXICrwMmNBQETP4TBcY6HZFECigONPCbnY3/1FoOKuXmEkuUZUAxJQHr684pxVlLH/Q3kcwNZjirGhQ7NacK2oE8yd/GyQseF/Fwn1rAQ1QnxL1kK+7gUxKeqshmGAwMZCFZ9wz7GPyWEDLrKah8hj91ZY+2o/Ff3pgkkvIGPzoUwjoY5IEQ1ikoXtnqOS9mCc5N1nffV7vrq8HcAa5vYlSiK+ZzT2SO/F/GgbV8xzEuJegiK5m4af4YEzxDkN5Zyybx3SfFvw9ENa64VZhCWON/a/3g3bOtah6W2dgwLklVh4HIXdIyu4XLpJxTsw4DTK+Pp4r5mClweTxgOuVYJIMP0qs89kw1FBNLiC0SfCNlQ0UArcd62CbS+nSNz82bCjJ4RYBWSM6m/Xjl2KAKyPqGoMFOVww8quirdLUheefZ98Bav31glZUgx5GMcTmdyWNzVbbFe4o2jYl+vm5FusYZio38HiEbWpBHx74hWuiyVBsUILavPFKF7hlk2g2DkILVCkZkPKRg+sVKXACRp1jlP+zfzYPkmKSiOHb+lzsedHjo0ZrC9ydvh97IaZMzlF/6NkqVGpq7Fexpj/3E1V+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(6916009)(4744005)(53546011)(38100700002)(6506007)(508600001)(66556008)(64756008)(76116006)(6512007)(86362001)(66946007)(8676002)(66446008)(66476007)(2906002)(316002)(122000001)(8936002)(33656002)(5660300002)(38070700005)(71200400001)(4326008)(26005)(54906003)(6486002)(186003)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTZlcUdIR2tzRkhNQ20zZ1lyK0pBYml3d0dZa2kvNERBaEp5Q082TlhYSVNW?=
 =?utf-8?B?dFBOQUZqdUtWaEZSUHVhMWFjMS84SFY3VlFRSnBiVkp6RmczdFhsUTVkWlZr?=
 =?utf-8?B?dk9jbVZFdGdYUEk1TnNBb2R1c3gzL09aTzZZVXN0NzlSMWxpbmNoZGpMdzB4?=
 =?utf-8?B?M2hoWlRsM1pQdVNESWpSSTJvRWFteHN2RUliUGVieWlFeFlZOFlCeXMxTnJK?=
 =?utf-8?B?bDlramxITXJuZWpmd2t4ejNCYitxeTRESnhRNWdHNUovZk1qNEJBbllRYitu?=
 =?utf-8?B?RlFORlJPU0g3a0FKQnRYazFZQnZlaDBPdEsvMFJZMnUrclo3QkNZQkdWSExm?=
 =?utf-8?B?czdyd3VqeXZhdGV0K0g4U21DR1BmM3NFb3dKK1l2V3JIaHVEckI4cmNoc3dI?=
 =?utf-8?B?WEVQZUlqNnl3dEZNVGg4cnRNSDJkdzZqb3RmT3lLcGJhWUxQWkRseExKU0k2?=
 =?utf-8?B?UER1UXNzVjZoVXdJMFdDcTZJcG1HT3crT2YyVFVxV1pFcVZRYzk0MldRTTNI?=
 =?utf-8?B?VkpvdWhDeFpqRlpuNnpHR0dVMnZlSGNBWlFUQlZiTzFZNWVqYVJiOElCZEFO?=
 =?utf-8?B?c1l4TjR4Y21yV1hDQVJuSXhtRjZVWWJaWks2TzUyT3FSc1FROXY0OXdTcTMy?=
 =?utf-8?B?ZURrb1lzNEg1cTZvSlgzemdHTDdvWEVSTWRFd3JvSmlTUVAzcWsrbjBmOU1K?=
 =?utf-8?B?eXBKRXdJUDk3eVRwWnErcDlXcTVSL3BvK0pJbDgxWCtDclhJUDh5TVlNY1J1?=
 =?utf-8?B?Y1V0dkZwMThaTllqcmF1M1lqY0VSYldLZ2kyc0N5Q3ZNQlFiZ203YlUreUFr?=
 =?utf-8?B?SzBzMlBqZkd4cnp2eS9iMURPa0hFYWVnMWc0Vk9hWmliSWdKYzlIOHdsMGgx?=
 =?utf-8?B?b1ZIVG5XK1FLUVQ2YXhrM3FGVU05anZWZ0lWaUVoN2JEWnF5ZEhld09WaFRU?=
 =?utf-8?B?MjlqYWtsUHJ3TFkyd252MHhHdWkrb25Fd0t3L1ZkOS9rVWE5YVlIVEFxZFJy?=
 =?utf-8?B?MFQ5TFk4UHUyaXNzQXpBTjhSaWNYdjdOMFAyZlVGMlJNSS8rVy9SVE9aa3lq?=
 =?utf-8?B?VlUwTGg5eFRma2psTll0OWJ5K1FYUWtGR3ZnNFgybVhCUzduQ2JOeVJtQURE?=
 =?utf-8?B?ZmRVVTkxdUNsUTdwKy9qUG5rT3c0WVR0UENOOGcrMVQwNFh6dnc5Q2dJSkIw?=
 =?utf-8?B?bUFFdEYva1BOSVEza21VWTZ5WGZBRU9saXZpbzljSHdMbXhpR0Zjc3RpcGJC?=
 =?utf-8?B?cjZsTlpoeU9mMjJ2T2dINVdxVUtyWlJKVXhGaTF5N1NVSFNzaVhmU3FjS1J6?=
 =?utf-8?B?KzFhaHhISVIveXNDRHgzUzFxMGt6VFFYRVZVOU5kMDZHaXF6YmVrTTRsNTlh?=
 =?utf-8?B?KzVqelVoSklpc3VCWFAyaUNxcnZSREJ3ckpDRVpYc3c5ZnU4WVUvVzROSWk4?=
 =?utf-8?B?ZGFGTkthVDFTbEtjSUZOcTF1Q0NJcW9GOVhWeVNoM2FmbXM1RE14aWkxL1pk?=
 =?utf-8?B?K1VGZE5RUVdDd2lnamZ4bWNUOFZ5TlFEbXRaeXY3L2V3L3Q5dXpHSVJQYTUz?=
 =?utf-8?B?N3VQY1NOUU9EdDBaTzBqdEVjRGp2Zk5EanR2T1NMdytySTdabnh4ZzdZU2lE?=
 =?utf-8?B?S0lJUHUyd3E4cHEreUlNcmg2eTZOQXB1Wk54dEljYXN5eGI4dzBXNHhPZ1Rv?=
 =?utf-8?B?MCtMWmZQdldqVW9JR2RoUGVSbTBuTXQyMFRGZzNkNVd1OFJzSkowNFFvcFVH?=
 =?utf-8?Q?9s8ZrctuYjEiXTPyU3PXWlEZ4KKHjSggHWLubnJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD84B38F11F5EF4E97FBAC630D5CD04C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4a5fe7-13c6-4518-b01c-08d985f19d6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2021 22:11:42.2257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p72MIdiL5swrNZp2YwrmUG5SKfnD0ARZHSh55CM2H4Ht9/pCPbraqCn/W0TYtwK+3jBI3EbEuNU77qaXEl/7jPlg9+gyBUx5etbBB0DWjsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5013
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gT2N0IDIsIDIwMjEsIGF0IDE0OjU0LCBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25p
eC5kZT4gd3JvdGU6DQo+IE9uIEZyaSwgT2N0IDAxIDIwMjEgYXQgMTU6MzYsIENoYW5nIFMuIEJh
ZSB3cm90ZToNCj4+IFRoZSBwYXRjaGVzIGFyZSBidWlsdCBvbiB0b3Agb2YgdGhlIHJlY2VudCB1
cHN0cmVhbSB4ODYgRlBVIGNoYW5nZXMgWzEzXS4NCj4gDQo+IHdoaWNoIGRvZXMgbm90IGFwcGx5
IG9uOg0KPiANCj4gICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvdGlwL3RpcC5naXQgbWFzdGVyDQo+IA0KPiBiZWNhdXNlIHRoZSByZWxlbnRsZXNzIHg4NiBm
b2xrcyBjaGFuZ2VkIHRoZSBGUFUgY29kZSBzb21lIG1vcmUuLi4NCj4gDQo+IFlvdSBzaG91bGQg
a25vdyB0aGUgZHJpbGwgYnkgbm93Lg0KDQpPaCwgSeKAmW0gc29ycnksIHRoYXQgc2VudGVuY2Ug
d2FzIGNvcGllZCBmcm9tIHRoZSBvbGQgY292ZXIgbGV0dGVycy4NCg0KSSBzaG91bGQgaGF2ZSBm
aXhlZCB0aGF0IGJ5IHNheWluZyBpdCBpcyBubyB0b3Agb2YgdGhlIG1haW5saW5lIDUuMTUtcmMz
IGFzDQpzaG93biBvbiB0aGUgYm90dG9tOg0KDQo+IGJhc2UtY29tbWl0OiA1ODE2YjNlNjU3N2Vh
YTY3NmNlYjAwYTg0OGYwZmQ2NWZlMmFkYzI5DQoNClRoYW5rcywNCkNoYW5nDQoNClAuUy4gSSB3
aWxsIHJlcGx5IHRvIHlvdXIgY29tbWVudHMgb24gdjEwIHNob3J0bHku
