Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FDC3F51B5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 22:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhHWUJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 16:09:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:48639 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231377AbhHWUJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 16:09:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="204313644"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="204313644"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 13:08:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="507370037"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 23 Aug 2021 13:08:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 23 Aug 2021 13:08:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 23 Aug 2021 13:08:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 23 Aug 2021 13:08:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpzeP2hJfpYgRHt2apK9PilzDzYVZYYg7WuriuzRmd8HhAxKsEht796fE0nP+ZoKuEprL6BxO3UsT0sueJiO72Gdul01X4OdW8tM841qHjeMo4azPHjZeGt4jmowH+ttRkEpaiO35SSO+5TkYgd+33X78/GglfuXS61Ig/3LpQcP4Xi2gksCGGK8cFEGkzhQhQKJ6N24au8V0EKkawyXRf+wDuBq8Mnb42YOzMrnRHjlFShOrWzENc6NWM4zTh1hJzqBwhJAnb/xMfpt+CHGKMP9dRPnptSL1qSBWzsiqK9sM6ObQTeTR+khwujGnPN7TKcWqTTVOZ52bXJinSE7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hc41R2NIg2mLHahhTcnC0keoO7FxTZwUpFM3vhAo2yg=;
 b=IuQ1MWRGPdH5DSo/jKuutReQ6xr6Kov0ftPlq30Qq3NsBU9OMUqPh6RaDUvxpMhlsWJzHfQ6RcFdhhMu+dtpkLoLTRbCDcLernwWkDIQg1KGaf+wKXcuow7qbChIwGDkCAKfk9LQLOTZdb+TIadpV9D6o5kNP2JjDA7Z1KZMctjQhKAQt+ZiXfLNCpQGUBSFjfuLyifB1lWNO0cDNUbaY/BlhgciT7hgIIt3A1KN0ofuN4mKb5bftj2C2Lkz1/jgAH3kkrSnhCS16nBj/6HdilvaBczKiSmqU2MsZnbAv55wWr6ZmBn4Y2DMextviU0IKAm6nafFvBgMB/0Z0cFUfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hc41R2NIg2mLHahhTcnC0keoO7FxTZwUpFM3vhAo2yg=;
 b=WBLsqLRyGOlpLQokf8ZmiJPRbxeQjhAGPYgwMiJ5aJVkaFU63L8Lt8qA3pilD1+gkQ4LH43BrVh9Hawr0bt4FUjtwyshFifT2pnj5lYN5OP7JqFVVaNFG7Jo40jG9lKcLYCrJagg8A5/EEotalWzL3K2Xi+qablPs7lhbIdknXQ=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SA2PR11MB5034.namprd11.prod.outlook.com (2603:10b6:806:f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 20:08:34 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::892e:cae1:bef0:935e]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::892e:cae1:bef0:935e%6]) with mapi id 15.20.4436.019; Mon, 23 Aug 2021
 20:08:34 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "rppt@kernel.org" <rppt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "Lutomirski, Andy" <luto@kernel.org>
Subject: Re: [RFC PATCH 4/4] x86/mm: write protect (most) page tables
Thread-Topic: [RFC PATCH 4/4] x86/mm: write protect (most) page tables
Thread-Index: AQHXmCJh+2nKKJgoEESroy/jSWbbkauBhQeA
Date:   Mon, 23 Aug 2021 20:08:34 +0000
Message-ID: <c572619a193f787ba24f8d2658ae92dcc0734d4f.camel@intel.com>
References: <20210823132513.15836-1-rppt@kernel.org>
         <20210823132513.15836-5-rppt@kernel.org>
In-Reply-To: <20210823132513.15836-5-rppt@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a97d7ffe-4fc1-4fb8-6e39-08d96671c96c
x-ms-traffictypediagnostic: SA2PR11MB5034:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB5034B05C40E7B1E0D5C0C326C9C49@SA2PR11MB5034.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aQlmRlaVodbg+0kZEFpy5bvyelzkiav/P5fTuamxnCVWCKPH7+UU1kPOwXSt51ukfw+J/OAPHuxgI4HXf5sAUd76uAlVdelqV+y0gk6UH1gxWpQ1cVmNJWotUSVWhIYuRX1G44ZH6RfK80nZTKQsEIJFkr+oxE6y5CEJiy+BI5ZjqwaAWES2bIIhc07D85ZaFm5UWMSN0QIpFxbA7dVwHJz2gDHchCsGFoEhnh4WYPXCcLrisliXMHW2N/DQ/V+ootdvFjQ5VB5qdhxu3UagHo21i3P65FGwuBixZFf2VjKR/6GGOQ2yFpqUMmIUuMCAagE1sSua8TEw2UwdAL7fZSEEg6Et3tGFtIYyoOkyXi6JevQCBkVp6hyk9OxcsSjjM0a/V4fw9veAZIwT6tAYzDaTXICxEzBfQ74GTC4saRuPtDjK8CgH5eXcbKQCmYSMoEI6vbLfFaLVFisJA2fRH91JlfvgUul68ZTCecR9L0FOcqfhCkm9iUrPbWtw7hb/c/VhYFB73H7ka+a7F1tSacw6OV6tVDM4ikjo4gEW2PaDVmrwLevaB/Hcfmckh7HsNQ1q2TqKYSUCbjj4+kbZba5G1phK2zNhFYG7vffIQ03BDVQNIoLciQ3t/3isTfoAPAegFyTG3ZzJzK2PPs0suP18ool5nyAYMhOEww95Y9sH4wL/LP3SiDqMObM0pQP6+7Ri5sazMV96h9qDd49nxZtmVBR40SIrHlm5Cl6SOfw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(54906003)(110136005)(4326008)(7416002)(36756003)(6486002)(122000001)(6506007)(26005)(38070700005)(91956017)(76116006)(4744005)(6512007)(38100700002)(186003)(71200400001)(66946007)(66446008)(64756008)(66556008)(66476007)(86362001)(2906002)(478600001)(8676002)(8936002)(316002)(2616005)(5660300002)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXVmbjRRdjZnaENOZjZ3SVMxTHJlWUJTd3ZPM2txbjhmaldCdUZ3SWdKOHV4?=
 =?utf-8?B?T1J0b2dNZklaVWZZamtJL3kvaGFna3c4S2h5MElmRnZFS1Y3SEFtYUJ1azNT?=
 =?utf-8?B?RllFY0lPVVBBSk11cllzUnVzbU1aQXh3dHlVNURQcEVuVWQzV0ZxbGoyMlha?=
 =?utf-8?B?dmVyWWpUeDZxTExlK0F3b1JaTGRDQmhiVEpSb3JWaGhKejM2clZ0ZFI3NGR0?=
 =?utf-8?B?RGVoaUxQaStrMDYxMTFFamdQQzRDejdraXlDYmRpSnZOblhyOUY5NExmT2Mw?=
 =?utf-8?B?MG9KTnUzNGErQlRmby81RmRYSUhhdndWbjU1dDdobmFqZlVFYjNwdmU2eFF0?=
 =?utf-8?B?MmVjZnNwTVo3SmNBalNISlJkNS9SVkgwaWRrc2RyZnBHbWJSYlRDb1lqa3BK?=
 =?utf-8?B?M0ZYdHlMYkZtZWVETElLSndVSlBMZnd5aGIyT3ErMDF6am54TjVIcVNIWDdi?=
 =?utf-8?B?MEU4b3BPNU1NVHBYaWtBZWhiclh3RXhLQ294Wkh0YVIwWStUcnlaL0RjQ2VM?=
 =?utf-8?B?cUJLa2ZpUTVhU0Q2eXo4YkRzR3QyUmcvQ2MvVm5OZ1VoblRQWkNBL05oZXk2?=
 =?utf-8?B?cnZwVlJBdWxCTEFnOWtrMk1YRS91V1kwMnNTdmc0b2txNDFkZVpZc2F4QWs3?=
 =?utf-8?B?Y2JtdXhvWjU1eXNuNlZOdWNOMHZ2RFY0MnBQVnduOGY0TGErdE9Ldmh1Z3dW?=
 =?utf-8?B?ZW5LMkRxKyt0VzhpMklmWmlnTHBjZFk4Nnh5R1BzM29QcHdlUHl2VVRNNE54?=
 =?utf-8?B?NkN1UTkvNFZvdjk2dEFYQWpwREpkNW4xUEFNaWhhZlZKN0hmYmF3VUVWZ1hI?=
 =?utf-8?B?cjhKSEdDM0szT2laT2d1WDltMmpadzUvT1VFdW9FZ09JR0QyZU4rNkxnQTBk?=
 =?utf-8?B?UHR3N0ZQalN1WWtwUU1hYXpPSnJoaTRUUG5lbndHeUloMmJ4aDRQcDZ2T09F?=
 =?utf-8?B?WEhpU1ExL1orelRsZ3VCcTducHVQZnpJeEFybFdVNzhqbllNQmdkdTVFaWR5?=
 =?utf-8?B?dGtvcjN1NzdIZk54cVYvZEY3WjQ4SnQyRnJhU28zemJSMnZBalFNNFlBZTBq?=
 =?utf-8?B?a1pzTFBvS09Ka0RyK25udXBVai9HZWNQcUdxRldNMjE4NS80ZjdWcTZiTXQz?=
 =?utf-8?B?RTVIRzhWc25Zc1NlWmN6UnlXR04rSk1KdFB3UlNJdUNjREVaWnQyWXQ2U2R5?=
 =?utf-8?B?dmNyQTBWd1djT1A5RXV0NlNjc0tZV09YME1qVG5kdUFVVlZFNkllZXFTbVJo?=
 =?utf-8?B?N0ZtQzNIUjFoeFd5SnI5RVJ3azc3VzRqdkM1RGIvbXVycW54ME1NRXRrYUtQ?=
 =?utf-8?B?SUs1SjNBNjAxMWgvNUxoODVOaWRPK3AzVVBTUjcwazJOSks5dlg4OGhoUkhs?=
 =?utf-8?B?R2hQc0xxU2M5ZS8yck5Eem80blRLVGIyTG1VREkxYlpOU3RDNFQzUFlKSXk1?=
 =?utf-8?B?SW1VMTM4WjQvSDdEVzllUmp6VUgyRW9nU29CWmZpaVM2aFAvdGlVSEd5eGNS?=
 =?utf-8?B?L245KzZVYkR5enNlSGFrcnFJWFJQM01pS3VEMzJwbm9rOUkyNDY1Um5lc014?=
 =?utf-8?B?U1J5VXh4N0pXM1krZElIZTFmemFFaTArS3ROWDZDRGNMZkNHaEdUeVcvK3RJ?=
 =?utf-8?B?VnF2UWtnaWdTZ25SQm9mVnZGOXlJSWpLZlFZWmlkNTAzUjNvNGx5aXRucG1q?=
 =?utf-8?B?NWp2dFNLL1dDMzd4Vm9JT3BxY0ZHemNZbmdQVndxb29XNWdITm8vMkYxQ052?=
 =?utf-8?B?czVUeDZIRmJjNEtZTnc1Um9ObDlOTnpqT2J4UlJiVURDcWVzazgxRWNKQTFu?=
 =?utf-8?B?SEMzbktEZm9lVnRxSklXUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <354C4369056BF24DB3AB0A6FBFCDF8E1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97d7ffe-4fc1-4fb8-6e39-08d96671c96c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 20:08:34.0893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bkgSC37YTJowhEBTVe/uCYozPV90dmm1/PG4003cYqrMt2ipote0eHaLGsbZCcqYSM00kSrMwWHa7tROnk9ctY2qmonxo3NXvTiSt37wS64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5034
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA4LTIzIGF0IDE2OjI1ICswMzAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBGcm9tOiBNaWtlIFJhcG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+DQo+IA0KPiBBbGxvY2F0
ZSBwYWdlIHRhYmxlIHVzaW5nIF9fR0ZQX1BURV9NQVBQRUQgc28gdGhhdCB0aGV5IHdpbGwgaGF2
ZSA0Sw0KPiBQVEVzDQo+IGluIHRoZSBkaXJlY3QgbWFwLiBUaGlzIGFsbG93cyB0byBzd2l0Y2gg
X1BBR0VfUlcgYml0IGVhY2ggdGltZSBhDQo+IHBhZ2UNCj4gdGFibGUgcGFnZSBuZWVkcyB0byBi
ZSBtYWRlIHdyaXRhYmxlIG9yIHJlYWQtb25seS4NCj4gDQo+IFRoZSB3cml0YWJpbGl0eSBvZiB0
aGUgcGFnZSB0YWJsZXMgaXMgdG9nZ2xlZCBvbmx5IGluIHRoZSBsb3dlc3QNCj4gbGV2ZWwgcGFn
ZQ0KPiB0YWJsZSBtb2RpZmljdGlvbiBmdW5jdGlvbnMgYW5kIGltbWVkaWF0ZWx5IHN3aXRjaGVk
IG9mZi4NCj4gDQo+IFRoZSBwYWdlIHRhYmxlcyBjcmVhdGVkIGVhcmx5IGluIHRoZSBib290IChp
bmNsdWRpbmcgdGhlIGRpcmVjdCBtYXANCj4gcGFnZQ0KPiB0YWJsZSkgYXJlIG5vdCB3cml0ZSBw
cm90ZWN0ZWQuDQo+IA0KPiBDby1kZXZlbG9wZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAu
ZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUmljayBFZGdlY29tYmUgPHJp
Y2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBNaWtlIFJhcG9wb3J0
IDxycHB0QGxpbnV4LmlibS5jb20+DQo+IC0tLQ0KSSBoYXZlIGEgc2Vjb25kIHZlcnNpb24gb2Yg
dGhlIFBLUyB0YWJsZXMgc2VyaWVzIHRoYXQgSSB0aGluayBnZXRzIGFsbA0Kb2YgdGhlbS4NCg0K
QWxzbywgSSBkaWRuJ3Qgc2VlIGFueSBmbHVzaCBhbnl3aGVyZSB3aGVuIHRvZ2dsaW5nLiBJIGd1
ZXNzIHRoZQ0Kc3B1cmlvdXMga2VybmVsIGZhdWx0IGhhbmRsZXIgaXMgZG9pbmcgdGhlIHdvcms/
IEl0IG1pZ2h0IGJlIGJldHRlciB0bw0KanVzdCBkbyBhIGxvY2FsIGZsdXNoIG9mIHRoZSBhZGRy
ZXNzLg0KDQo=
