Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7EF346B63
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbhCWVwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:52:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:28243 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233721AbhCWVwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:52:09 -0400
IronPort-SDR: Lj4ELqme6DJQFFppn4PN1QwtaIt1V/K0WurJgTVS92P6EZmFID+XPm3FLBNN/xYu1oyAIjUM0q
 r+YNn2nsTlPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="170538321"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="170538321"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 14:52:08 -0700
IronPort-SDR: oDubnj5HfHaJgT56T+06tEJmNcDudDvUxu0v0spNgF+uDi7fPmqAmueSGeuOPmYGAJscrtLxpl
 k68NrqIOCyvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="381506439"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga007.fm.intel.com with ESMTP; 23 Mar 2021 14:52:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 14:52:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 14:52:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 23 Mar 2021 14:52:07 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 23 Mar 2021 14:52:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LX31sVwNy274NaWe4h6ZZd3pvAg/5UzmN0DWW9s+XM+2oBZoSr4Ad3A7Hdq5sp5hb1Asva18hJrhucpTs2DsQbfAR4DRYZpV3zb5LG4XLweXgOi6YHUOOKyf32PZ48yxcF/ypASumoPGe+MnyjVdVlwfSeB1o6AH3YqI38os5SCIf6RmXOuhSqRhDZEV53aJ+yH1ay/ky4ZukNKW5/C4j1xJt10r7+qOBGOn7lm3GzXCHkkmI0UG+t1GKX7A1EiGYcht1AO8jaxSIjh4aPXdUy+TILSTowk02n/V2ZtN2ZlJIGGVCeieQ9uc8++3Usur+g+pH3+WBRdqyBFnX1n+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZGes9b/7AfkZ4C0PO4JSoMmP7hLfFD+tGlF9Yo05ns=;
 b=m/DwrjY2CLIzrRrK0h9k2bS+2t7edPkf14TQ9WlUSBr8hlNgD2380uO/GcuTHoyM4LPhgJVx2ioWOnYz15Q9LCBjdSnFEiqRu4YGU8+/bc6cxohCL8zd+CZ3Jhbl6FTfPKbdGvZ7OT5kPojOQRJq9jpV31p3f5NOOAekI3OmDukzQiCL700H2uGmWpPonV0R8krRKi07Pl4AcE0radMQAJ34BEFwhG/H43Fb5B7K4Rb/Tw4PTWgnU6QD2cxO2o2ubA4EeFpiCZ/NM7QOQe6TJvMoLY7rt6+SyUHgEU8lYUNNAYiAHFMQY/sU1iPiK8/YTaChOCJOwb02+izRyOOoGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZGes9b/7AfkZ4C0PO4JSoMmP7hLfFD+tGlF9Yo05ns=;
 b=GrQPGsoCqK40lxLZridmORhqAyqvc6Ms4l7skbG47mscELLFUB4aMxjf+fXaRxBeYQzZaxTcazMXWdxU5miSJUUdunzVGknCATXvrMYm6DwfOxkjc7po2ZoWClYh3/+YbWBx5tCU6zEbmLbFxRkqzXsR7B+9hOwSVGZFmcFDBvg=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5046.namprd11.prod.outlook.com (2603:10b6:510:3b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 23 Mar
 2021 21:52:05 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 21:52:05 +0000
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
Subject: Re: [PATCH v4 18/22] x86/fpu/amx: Define AMX state components and
 have it used for boot-time checks
Thread-Topic: [PATCH v4 18/22] x86/fpu/amx: Define AMX state components and
 have it used for boot-time checks
Thread-Index: AQHXCIQFlBet9SHM2EG13IEdU84QiKqNj60AgAS80AA=
Date:   Tue, 23 Mar 2021 21:52:05 +0000
Message-ID: <B52B125F-2758-4423-B4D7-2209F822BB87@intel.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-19-chang.seok.bae@intel.com>
 <87sg4pa4wt.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87sg4pa4wt.fsf@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b78a5999-9e93-4c6e-d69a-08d8ee45e62a
x-ms-traffictypediagnostic: PH0PR11MB5046:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5046AB1D76DA8640A48205EAD8649@PH0PR11MB5046.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jx9oOTdzoX3NxvjzYJrgrAkYHAL4/KZ11CUH+nxxcSpPp/Zpjx5KdODsaCUeVEoyOK/iIFGcDcvHXA/OahI7J7Q4WRtnAEA9qktKaV04PPGj3zrMDlPCkDRNOu0Pts8LS22B7pG1JgZWZdySa3rijUvdIW+AvF6hJO6TTGSAgdHHk8Ze6k+W1K0FazlNJDHNFMa+z7tMWC4xIhqC1ni7s5ufICOmG1FAqgcsOJVdB1/y28RSdAKcDb3irPh8kGF8C9eWHSIWPj2fRX5GM6lMUHi4Pov0AFGFUriHPSo82XVpimDM9nJZhCWxSFPMmRaN60LfZfOHmAgiyptdC/8VFdNLvdl8sOEtGsV72TRyIdzE0mzamO4/JGYmhtjbly9ub2RD9zL6utshlBhKgsGP08L2s09irdymEkvvEF/25/9qsl8voDaNknJzIU/t2a5r9Q4/TPsHBm25hHLBlbpK0nMfY+2pW/ehyr0rqxePdWVGWMF34MdZaDeaN72uidjUTvgvDcjnXh2BnzMES46mxx69H3cqsa+ceZY6inuATXMNDCp+rHK/Kekj9jBvY51chcfA61CcA4t5VvwXtc83YfiFjfsruSBcKaMiYTXMs+mYtl4sqoF7q1C38hmRLnMBIkTqH71V9iKwhqobXZtzqOkakp9sAE9pTLdtSV6CafbvbDGbVmefAm6pLqsPSl4ex+BdRpjBOyNRHYir8DnrsBcCkCpy7DgOpAM4OQ2cMn2QmHbJFJtAbMx1NNznbmSzedHSWWts+IKb71iyzuPflA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(366004)(39860400002)(6512007)(66446008)(64756008)(2906002)(66946007)(76116006)(33656002)(66476007)(83380400001)(86362001)(54906003)(66556008)(316002)(26005)(8676002)(53546011)(6506007)(186003)(478600001)(6916009)(38100700001)(71200400001)(4326008)(2616005)(6486002)(5660300002)(36756003)(8936002)(966005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Tm5uYitFbUowL1YzN0x1alBVVDFxSGNsdDJNb3JtdkJSYnZRWG1RNXBWWWZI?=
 =?utf-8?B?N2FKQnBzZURGV3ZVd1MyRzk3UWFQTk9jbHJnekFOekpJTW95bjIrdFo4NTdh?=
 =?utf-8?B?RXU4elpVbVJLeFcxN1IyV2kvMmV5azlnbDFCWjN4T3NDUndOMVR4MGN1N0xq?=
 =?utf-8?B?RjNrQVdOMkkzWWZRRGNRRURsaE05VE43T0tpSzFVSnIrNk1Ob0hMQk5yMDBQ?=
 =?utf-8?B?dmJyeStuK0g3U3NwUkhEbCsxcStTdGdLeUpYT01VNlkzNmFERFlKWU5IZVRJ?=
 =?utf-8?B?dEdQUVpJWnZhUmtlbVRaZ1g3Qm1ibkxjOWZaQ1lwTU05RzU3eENadkV2R0ls?=
 =?utf-8?B?RkZUUkhwM0lBTzZZMGtmVlJnNmNXRGdza0VieHF2QUNWMm5EZUNuRU1wWjJu?=
 =?utf-8?B?VkR5emd6OXhkSXBObmtTYzl1L3pGOUNZd3FhM2J6TFkzT1BJbyswQ3JUV1Zt?=
 =?utf-8?B?aU5ZeDNIMU1nSDkweUt2U2wySjNzZlJidDQ5ODEwRTJ6L3A5bWpJZjA3TVF0?=
 =?utf-8?B?ZzV6NU1SSFZuRVNvcVhTTVQ3R1d5dmZKUlJDbkZvVjNlT2tod0xzalkwVGV2?=
 =?utf-8?B?SkpQYUc4c0lJRWw0SmYxeUg3WlRScWNhZzVSQkUyaGU5RFNqR1BZVi9KRUlq?=
 =?utf-8?B?T0hCL2k0MmMvN3gwbWx0L0ZtNzdzVU9MUDJXS1NMMlp6b2VpZHdSS0phMUdh?=
 =?utf-8?B?Yldib0VObUZ3YTlic1BBUHBPNlVVRzJlbnVhMGdJdU9hWWsxRFJqTi9jUFJI?=
 =?utf-8?B?WFBPQ2JLR2EzOW1QdlBMYU95ZW80Uis4SS9vOWhVZk5vaU9QcVA1VFZQOGk3?=
 =?utf-8?B?Lzd0MWdGcGQvdTNybkdDeGpZcDExbGg5NnFNbE1kRktEU05jTEJEWDB3cWVw?=
 =?utf-8?B?MUt2WkprZUZHb2xXVTgwTEtDT0ZVaG9ybHF5QWVVOXdMdExYT09iMWlsbXNM?=
 =?utf-8?B?UW9UdVNBUFE2Mm5XQWxRY202Zkx5YWZHQWVBY01Ha1NKMjNBcDgzdUljVHFt?=
 =?utf-8?B?eDl2YmtKaFBxeXFaZEJDYjlIcXlncmNMSC80OEZCcHZEYmNOYm85TlhucEpD?=
 =?utf-8?B?V29WZDkvTWNzd1Jxa2xEWXNIUEp1a2Mzc3JpcXJneGR4TDRucW90Z0JrNnlS?=
 =?utf-8?B?ZkpVYVNGbnF5bmhSam5oTENqcUYreHpMdE5oUXlla0QySS9TK2NwMkN1aDlF?=
 =?utf-8?B?bFoxYXk4VDd4VDZUOXZEaDM1M2s3bDZPS281ekVLS3NVTGE3OEF2T04vTm52?=
 =?utf-8?B?V3JPbmNpN3I1TWMvU1B4T3BiSDJBaEorMGtSZ3Bid0pmaFZDYTZFa3J6TlV4?=
 =?utf-8?B?MmpNSzVWbU1HNzJ3S1ZXWWFPeVlmMm9EVTkyL201ZDArbHRxcVBvUjBSalh6?=
 =?utf-8?B?R0dzTWJhRHZUaW4xNDkyVCs0eEtjUjhnMzc1SHd3ckJ2bFFrUWpERk9QTnlE?=
 =?utf-8?B?bWhYa1JZRDlveEpqbTZsek1KVkUvbHF6SmZDUkx1a3V5ZmJ6KzJSTVR0YUd2?=
 =?utf-8?B?QXl5ODlhVm1BcTZmTHcyMmVqSWJFWmp6SGtqMjBUNUozRlVRc2NDNjR6OHpK?=
 =?utf-8?B?M2RRYlAxczJmN1FhR2RYNWEyZDk1VmdBRlpqNUZKUWFYRzhoMVZLVEhGSVRv?=
 =?utf-8?B?V0RKYnd1ZWdMVVV3YUZnSU9sbGEyTXpUZi96RjNoUTlkRGJXenF3bDJmMFdF?=
 =?utf-8?B?bloySmpYcjFqeFJJK2d1REpHdzhtRGhrS2JhaWRiRFlyTWhxSVR5Mjh4eWdK?=
 =?utf-8?Q?bYj6aTGqLM1XLxMd+pN0m3ss1ABYESG4W+1EDls?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3FFC66EEC9AC94DA836F5CD431566DA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78a5999-9e93-4c6e-d69a-08d8ee45e62a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 21:52:05.3152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /TwtcO5RIAMzCxXN1jXI1Pofmp0faJPBOulIRup0vwonMijls9umRU6/NeQQ6BjtVZeBtfJl3ieaYm06nG5ahmnHVB40QPqV/pDaTlnIVnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5046
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTWFyIDIwLCAyMDIxLCBhdCAxNDozMSwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9u
aXguZGU+IHdyb3RlOg0KPiBPbiBTdW4sIEZlYiAyMSAyMDIxIGF0IDEwOjU2LCBDaGFuZyBTLiBC
YWUgd3JvdGU6DQo+PiANCj4+ICtzdGF0aWMgdm9pZCBjaGVja194dGlsZV9kYXRhX2FnYWluc3Rf
c3RydWN0KGludCBzaXplKQ0KPj4gK3sNCj4+ICsJdTMyIG1heF9wYWxpZCwgcGFsaWQsIHN0YXRl
X3NpemU7DQo+PiArCXUzMiBlYXgsIGVieCwgZWN4LCBlZHg7DQo+PiArCXUxNiBtYXhfdGlsZTsN
Cj4+ICsNCj4+ICsJLyoNCj4+ICsJICogQ2hlY2sgdGhlIG1heGltdW0gcGFsZXR0ZSBpZDoNCj4+
ICsJICogICBlYXg6IHRoZSBoaWdoZXN0IG51bWJlcmVkIHBhbGV0dGUgc3VibGVhZi4NCj4+ICsJ
ICovDQo+PiArCWNwdWlkX2NvdW50KFRJTEVfQ1BVSUQsIDAsICZtYXhfcGFsaWQsICZlYngsICZl
Y3gsICZlZHgpOw0KPj4gKw0KPj4gKwkvKg0KPj4gKwkgKiBDcm9zcy1jaGVjayBlYWNoIHRpbGUg
c2l6ZSBhbmQgZmluZCB0aGUgbWF4aW11bQ0KPj4gKwkgKiBudW1iZXIgb2Ygc3VwcG9ydGVkIHRp
bGVzLg0KPj4gKwkgKi8NCj4+ICsJZm9yIChwYWxpZCA9IDEsIG1heF90aWxlID0gMDsgcGFsaWQg
PD0gbWF4X3BhbGlkOyBwYWxpZCsrKSB7DQo+PiArCQl1MTYgdGlsZV9zaXplLCBtYXg7DQo+PiAr
DQo+PiArCQkvKg0KPj4gKwkJICogQ2hlY2sgdGhlIHRpbGUgc2l6ZSBpbmZvOg0KPj4gKwkJICog
ICBlYXhbMzE6MTZdOiAgYnl0ZXMgcGVyIHRpdGxlDQo+PiArCQkgKiAgIGVieFszMToxNl06ICB0
aGUgbWF4IG5hbWVzIChvciBtYXggbnVtYmVyIG9mIHRpbGVzKQ0KPj4gKwkJICovDQo+PiArCQlj
cHVpZF9jb3VudChUSUxFX0NQVUlELCBwYWxpZCwgJmVheCwgJmVieCwgJmVkeCwgJmVkeCk7DQo+
PiArCQl0aWxlX3NpemUgPSBlYXggPj4gMTY7DQo+PiArCQltYXggPSBlYnggPj4gMTY7DQo+PiAr
DQo+PiArCQlpZiAoV0FSTl9PTkNFKHRpbGVfc2l6ZSAhPSBzaXplb2Yoc3RydWN0IHh0aWxlX2Rh
dGEpLA0KPj4gKwkJCSAgICAgICIlczogc3RydWN0IGlzICV6dSBieXRlcywgY3B1IHh0aWxlICVk
IGJ5dGVzXG4iLA0KPj4gKwkJCSAgICAgIF9fc3RyaW5naWZ5KFhGRUFUVVJFX1hUSUxFX0RBVEEp
LA0KPj4gKwkJCSAgICAgIHNpemVvZihzdHJ1Y3QgeHRpbGVfZGF0YSksIHRpbGVfc2l6ZSkpDQo+
PiArCQkJX194c3RhdGVfZHVtcF9sZWF2ZXMoKTsNCj4+ICsNCj4+ICsJCWlmIChtYXggPiBtYXhf
dGlsZSkNCj4+ICsJCQltYXhfdGlsZSA9IG1heDsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlzdGF0ZV9z
aXplID0gc2l6ZW9mKHN0cnVjdCB4dGlsZV9kYXRhKSAqIG1heF90aWxlOw0KPj4gKwlpZiAoV0FS
Tl9PTkNFKHNpemUgIT0gc3RhdGVfc2l6ZSwNCj4+ICsJCSAgICAgICIlczogY2FsY3VsYXRlZCBz
aXplIGlzICV1IGJ5dGVzLCBjcHUgc3RhdGUgJWQgYnl0ZXNcbiIsDQo+PiArCQkgICAgICBfX3N0
cmluZ2lmeShYRkVBVFVSRV9YVElMRV9EQVRBKSwgc3RhdGVfc2l6ZSwgc2l6ZSkpDQo+PiArCQlf
X3hzdGF0ZV9kdW1wX2xlYXZlcygpOw0KPiANCj4gU28gd2UgaGF2ZSAyIHdhcm5pbmdzIHdoaWNo
IGNvbXBsYWluIGFib3V0IGluY29uc2lzdGVudCBzdGF0ZSBhbmQgdGhhdCdzDQo+IGl0PyBXaHkg
aGFzIHRoaXMgYWJzb2x1dGVseSBubyBjb25zZXF1ZW5jZXM/IFdlIGp1c3Qga2VlcCBzdHVmZiBl
bmFibGVkDQo+IGFuZCBqdWcgYWxvbmcsIHJpZ2h0Pw0KPiANCj4gV2hpY2ggb25lIG9mIHRoZSB0
d28gc3RhdGVzIGlzIGNvcnJlY3Q/IFdoeSBkb24ndCB3ZSBqdXN0IGRpc2FibGUgdGhhdA0KPiBt
dWNrIGFuZCBiZSBkb25lIHdpdGggaXQgdG8gcGxheSBpdCBzYWZlPw0KPiANCj4gRmFpbGluZyB0
byBleGVjdXRlIHNvbWUgd29ya2xvYWQgYnkgc2F5aW5nIE5PIGR1ZSB0byBpbmNvbnNpc3RlbmN5
IGlzDQo+IGZhciBtb3JlIHVzZWZ1bCB0aGFuIHRha2luZyB0aGUgY2hhbmNlIG9mIHBvdGVudGlh
bCBzaWxlbnQgZGF0YQ0KPiBjb3JydXB0aW9uLg0KDQpUaGlzIGNoYW5nZSBpbiBmYWN0IGZvbGxv
d3MgdGhlIG1haW5saW5lIGNvZGUgWzFdLCB3aGVyZSB0aGlzIHR5cGUgb2Ygd2FybmluZw0KaXMg
ZW1pdHRlZCB3aXRoIHN1Y2ggbWlzbWF0Y2guDQoNClllcywgZGlzYWJsaW5nIHRoZSBmZWF0dXJl
IGxvb2tzIHRvIGJlIHRoZSByaWdodCB3YXkuIE9yLCBwZXJoYXBzLCB0YWtpbmcgYQ0KbGFyZ2Ug
b25lIGlzIGFuIG9wdGlvbiB3aGVuIG1pc21hdGNoZWQgPw0KDQpBdCBsZWFzdCwgZ2l2ZW4gdGhl
IGZlZWRiYWNrLCB0aGUgbWFpbmxpbmUgbmVlZHMgdG8gYmUgcmV2aXNlZCBiZWZvcmUgYXBwbHlp
bmcNCnRoaXMuIENvcnJlY3QgbWUgaWYgeW91IGRvbuKAmXQgdGhpbmsgc28uDQoNClsxXSBodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51
eC5naXQvdHJlZS9hcmNoL3g4Ni9rZXJuZWwvZnB1L3hzdGF0ZS5jI241NjcNCg0KVGhhbmtzLA0K
Q2hhbmc=
