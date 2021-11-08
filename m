Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E0D449F2A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 00:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240994AbhKHXrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 18:47:49 -0500
Received: from mga04.intel.com ([192.55.52.120]:51527 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240993AbhKHXrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 18:47:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="231063989"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="231063989"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 15:45:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="451672062"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 08 Nov 2021 15:45:02 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 8 Nov 2021 15:45:02 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 8 Nov 2021 15:45:01 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 8 Nov 2021 15:45:01 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 8 Nov 2021 15:45:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M21yvypA/DPjS11E/0Awdvl8k/CX5kFd4pwVcfeEGe5grq+kQAhgrAZwFUKVVLE5ZUX6DNEeC/sabevs+tAEF95tmw25uW12PI/TMkaKgd6oiulAeD44rnkGdQYCO9Ug7PyD6Rjr0/SSOo/sYxKeomy91IBwavQ/jnjad6Y8TebP45PM2tPaWxrLOeifU7n1zakBgxj6QNf8eyDdEJyDzB1Yvvqw7aClqgnv4KdcdlmYR8aAUAzdCUEBdbOhwCBHl9aSohgdKVJLdlXRtAxvty7CGkxZKxxaJibgj5O9HlvVmygFawlLtRW26NDmn9h8iLi3bwCgybI1MFDIFbpkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKAfSc/ej6DTznPx1bIdeLdxNPhhiiO+KDO1Kdj8AQA=;
 b=Gctn++72xJVWioW/8NHRogbmNRbmF+GcKPvBZd9G/axZLTm2QZnSqHIGZpDGu/YitnCOe0A9jwzDtXj4kvEXoA2A+JwQFJYPyJrqp0OA8WUCCYwU3ZC1YH8I1HoXZD2CkSPTjdHUfIqbMqt0kyaoy5vwlbVkWXkuySN4SHqccD1kDY0Sm9T2qATvMmKgBIkFx87OQDhvvumtJSaLsAbANwg7uEJz6scuApd0tcXE5W2VP0ZwjpIjtIlRPPoKhrrlBr2II1AozC/vWnKaVJsRfJam/CLmcWRDokavXJB0fg3oMcEdjISXRW1k+sUrqZs7npUY8JcxLWtVXS4+HBCvqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKAfSc/ej6DTznPx1bIdeLdxNPhhiiO+KDO1Kdj8AQA=;
 b=LSXN+hOPfIdi7wTmQQk9H5HKwf3MA6guvU1q/ihqqT4uC6IEzX5dLnUusBpYaYhLPZICwn+bMaPRPbmnpd95FlXm0gz95wT1IJMI7vTeleXuprrSs9C+OjlHSxvnOdYPt8Bp0vtHMFVVVFuUFOA0gQxHXmZxBV22tRZz0BnN9y0=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5901.namprd11.prod.outlook.com (2603:10b6:510:143::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Mon, 8 Nov
 2021 23:45:00 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::11ef:b2be:5019:6749]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::11ef:b2be:5019:6749%5]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 23:45:00 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Zhong, Yang" <yang.zhong@intel.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@suse.de" <bp@suse.de>, "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>
Subject: Re: [PATCH] x86/fpu: Set the corret permission value for
 perm.__state_perm
Thread-Topic: [PATCH] x86/fpu: Set the corret permission value for
 perm.__state_perm
Thread-Index: AQHX1KUTL54IMov/cU+7hOB6p2r7Qqv5zf0AgAB+BAA=
Date:   Mon, 8 Nov 2021 23:45:00 +0000
Message-ID: <6B4EB4A3-6445-4D1B-9F21-3BD196A6447C@intel.com>
References: <20211108222815.4078-1-yang.zhong@intel.com>
 <045FEB79-B7AE-421F-A7F1-1ABC86E0E19F@intel.com>
In-Reply-To: <045FEB79-B7AE-421F-A7F1-1ABC86E0E19F@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7494f41c-b2e8-4dc5-bd6b-08d9a311c746
x-ms-traffictypediagnostic: PH0PR11MB5901:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR11MB59013E03D24433BA40D6DDBBD8919@PH0PR11MB5901.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ljF4axIOiWZOLhx+u3S7gJTcZzICMZbfTQIWTGTM8/3P8Nxfi0FmcnQhSmCj/Qw30zzeyLZulHhcOrCMBnGJCqW204tTdz0dwEHWotM3xfpRRAi0Ys6qrKh2rLq9Qa8228ZVzOHPbHfJre7W/9CnIKqQX6gSLwVMWz8+/izLpLGbEPxpbS/2k8cj28CjIAmke0KWqDZNXyZTZ5ltE1d2Kfv8Ggx6ni6iyzlLjaQHFRpZUx0x8QZtD8DWAT9BiLlNXKif5No8EalbDKzLdL3TvqBYPyFEMsmgOvLzI8zVz3wViq99TUWnODy0BhRgnJyK3JNIMKo0BDtlv5EA8gztkRcR0n/DSyEOYq8ONUcF9/HO1J9mTSQDpQ6aNgJy9e7NKa/mJjUbqHpZVMMnrbeIk+CZ58HEnoRE2NF5eH2nYrpU7YP1fdP0bYqQEBNfvAAj2wz6Ze53G8cltTxMMj+qOUyL/dXtq22zHaG9sfIgQ6Tdax+ZyQ46jhREVItXNwVmu19LEIrKnDaiS19UQtFFmDG02nY2oBjXJfsH/e+iyp+kvcz7H05XMRAS4QMJczSRZv2X484vM1hOUeXpzel80htdGBtcsOhvqhx1ERLtHoqJjWuNRWtXzDGTKV4wAAc5c4UZnWOpJGD3iSR6QNynqOHertcZCztMh08KkMVkCAX4Ms9FcfANz9heVuyvZuTsUZn9HlgrSnPW07Z09ywYsLVb57oRzhRs/1dx/Z6Y58YWbbK5wVAJ17y/IUASyvFgdjW/S1SORiNSbBZu3+7KJwqbglM5vUxH60LiT+gwblCmJhzauB5JvDZCqxPtTiyBoLuBM1mSScM0hxixC0r8EQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(508600001)(107886003)(966005)(6862004)(6486002)(8936002)(5660300002)(6636002)(4326008)(4744005)(37006003)(2906002)(38070700005)(82960400001)(33656002)(86362001)(64756008)(76116006)(53546011)(6506007)(66556008)(66476007)(122000001)(186003)(36756003)(66446008)(38100700002)(6512007)(66946007)(54906003)(83380400001)(2616005)(71200400001)(26005)(8676002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VktSc3Q4YWptTTEvd2s0VGVKajkwbEVlOTMvVjJFbXNEVkdjM293VE95UjNX?=
 =?utf-8?B?S3RlUXBtWG9WZmlLTFFHWDR1aGcvRXV6a1BCbHRKbDI5aXdVWnVoTzMybHFU?=
 =?utf-8?B?c3VuMm55NGsyNjVLRjJvVklsSlA2SDB1NGFXRlZIbTVjcWl2SHJQbjBQaUdi?=
 =?utf-8?B?NmhwNXNiWjdtdlR3UUUzR2Y4bW0yRFVsR0tPUjZHK2tnajl4M2QyalYzN0FZ?=
 =?utf-8?B?Y2FXeENQbXJHZFUvMVpMZk1aeGhGdTZkNG40SjhGNXFNbGxhNGZJRFh1RFJ3?=
 =?utf-8?B?NjVjQ1gvbU5JVTNZdzM4RHBtN0pxV1pWdFJJSEJ4cCs4YTFqekxPSTJscU5R?=
 =?utf-8?B?QXB6R2JsUGVReVd1VVBVa3lOTG56UTJ2bWppanpiamxVdWVUa1YyS2NTYkJj?=
 =?utf-8?B?SkQ3MnlQMnlBdlJucnF0NHloUjlHZUl6S0lnWlhLcE9oWWxzem1VbkhmUWVs?=
 =?utf-8?B?Nmt6OTdoNURUTUk1SlphNVpkZzdNY0UxaVB0cDBGbDB1WjEzYjRBSWVyM2VH?=
 =?utf-8?B?Q0dTSmRyUGFtRFRmZEFiN1RkUlB4T3ppYk02TE5EN0xrSEJVTTVIWjRmOUR4?=
 =?utf-8?B?SDFxR0lFUlloeDlNZENPYWZOMkhBSEVSNndFR1o4RWRUdURzcnVTTGVRSHdy?=
 =?utf-8?B?R053UE5WSUI3YXdHdHVRZDA4WnpQVG5McVdNTUVMb1h0VnpmQXZNTlhiZ1Ri?=
 =?utf-8?B?eHBtQlF2OHFWWWZWMWs3d0YxVHlBeDhHQ3FEMWNzNm5WeCtJUm9HTlc3ZE9N?=
 =?utf-8?B?czFENWhyT2ZkWjJDT3RvUFNwK0pPZGU4ekdaUE5lMmZ6WDh5ZVBNUDlMTS8v?=
 =?utf-8?B?VHdERlcrcnRDS1dqT0RWK2x3Zmo4N0hDQ3prc2JWNmVMR3BIblk5SVp0Q1Z2?=
 =?utf-8?B?U1JLcXdjcVNZS2o4Tituc1FBelhQbnZLMnhTS0JuRittZk1JNHQwamFTUWZB?=
 =?utf-8?B?cnJSU21LTEFIaStSL1BicWdyYm1vd21heW9QUDdyd0JGdWJYYlVPMTJvY285?=
 =?utf-8?B?V0phVWZHOHk1c0dkblhZUlJaazFJdmQ4WEtYUFk0bjByWk1IeldJNGRBQ3Nj?=
 =?utf-8?B?NnFVV2xXMU1EaEdVNnk3Zm1GYkVHTUo1M2NDVWcyVmxqb0tNSldBbDhkVkxE?=
 =?utf-8?B?NEN0SzFOaDZVL0dzWE5nZERGK1B1YlN0TTh1TjJWSDJadTFoWVlDbnFnNlll?=
 =?utf-8?B?M0R3dkRRZ0dSekZrMDZPdWJ4S1pLcGlqc2tBeklaS2RPYnJSMHNMdUViVi9O?=
 =?utf-8?B?NUVLZk9SV2dabVVTRFZPUkhOZEJIZGZMQlJVYzJndUFQZ1dhYVJRUnNiUmZn?=
 =?utf-8?B?QmRMelUyWUNIWks0eWpSV2V5TDdTTDJrR1UzUWRkSCt0Y3RXS2hUUWlZeVUw?=
 =?utf-8?B?djlLaXpRVENVbjNubmdPeHFSMHNJV2NsbldIeGYyd1o4TllxTWh5THVhNzd3?=
 =?utf-8?B?a1h1WCtnU2hDNlBGQ1lSeUxVVjFxV0taalNKa1NTeUg1bExyNXFIYVFjQXdW?=
 =?utf-8?B?TktkaWxCWjFlS3RBS2toN2NiU3p5ejVNSmxkbnh3NExjblZ1d2xXSjlqUlpU?=
 =?utf-8?B?UDBSbGRUdmttNUVsR1JIVFE3RC9sMHpjbGdpRXVOUEJsMy9QVlNWbForNEhz?=
 =?utf-8?B?QzJGQnFHTithSkdjaHo2NytVTHZIRXIxWEdYMTI1RXpMNEJrb0ZqTEFucEFa?=
 =?utf-8?B?OG5qeTZDVy9RNWJhM3hxcTQ5VTFMaTl4ZmhmRy9uQm85RDB6Wm5HRGlhU0NQ?=
 =?utf-8?B?VUZFdjQzdlNlajhOSzdnUWJRNFJnWUVrbHFQSk93ODFMYlRkUEpxQi9KVm04?=
 =?utf-8?B?OUhzTnJOWFlYd2FWakd1TTVMZ3RoVTc1YSttK2pGRHBTN2lRaTYrc29Id3da?=
 =?utf-8?B?cDdFQUFlcTlYRmIzd0Q4KzNKbGJpaFNSTFNnNFEwRlRtQTVYbGU4QWpmbmx5?=
 =?utf-8?B?T0JHTnB6dHdWcGhjcnI4TVpZdWhuUFpsZzZ4dE02MERSSm9VZDRKd3JFNTlm?=
 =?utf-8?B?WVZVMCtvY0hoWFlDWnN5TjM3U1hpdEVCeHAvMGl3TDlGMzJnTkNBWHB5TGhx?=
 =?utf-8?B?MGFaRk1RdEozZ0RmNmpTc3F1eTREQjdqYll6L2UySHRLUW9jempzNkxPYUlD?=
 =?utf-8?B?NmFiZG95Y2FBZS8yRWRtc1Qyc0tWZHpBNmZ0UnA1Y0dQR3VTMENtRUlIb25V?=
 =?utf-8?B?VmRaZjBsSWpZZ09DK1I1S1dDeEJzZTBIZlUyd2RpNDlqZ2lSODRtY0VrWmw0?=
 =?utf-8?Q?iyJEVRaV2C2EQs+UtFIkkvz90RQRRQ/X0IchdaHG38=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F2A06BC952A5544A21774469C642A33@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7494f41c-b2e8-4dc5-bd6b-08d9a311c746
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2021 23:45:00.1793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pDksQnK6KrUOpVUEjSVA8U0wFb33MGgHqXO3A8vUkNQSRp/SN1U5TrES8y46neBXZ4nE7J3KfJV9E9sm/mwiAgCHr/2QFUbdSrfQ3Tpe1Is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5901
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTm92IDgsIDIwMjEsIGF0IDA4OjEzLCBCYWUsIENoYW5nIFNlb2sgPGNoYW5nLnNlb2suYmFl
QGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiBJIHRoaW5rIHRoaXMgaGFzIHRvIHVwZGF0ZSB0aGUg
Z3JvdXAgbGVhZGVy4oCZcyBsaWtlOg0KPiAgICBXUklURV9PTkNFKGN1cnJlbnQtPmdyb3VwX2xl
YWRlci0+dGhyZWFkLmZwdS5wZXJtLl9fc3RhdGVfcGVybSwgbWFzayk7DQoNClBvc3RlZCBhIG5l
dyBwYXRjaCBhbG9uZyB3aXRoIHRoZSB0ZXN0IHVwZGF0ZSBoZXJlOg0KICAgIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xrbWwvMjAyMTExMDgyMzM1MDEuMTE1MTYtMS1jaGFuZy5zZW9rLmJhZUBp
bnRlbC5jb20vDQoNClRoYW5rcywNCkNoYW5n
