Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECC73F57B4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 07:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhHXFuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 01:50:01 -0400
Received: from mail-eopbgr1410077.outbound.protection.outlook.com ([40.107.141.77]:23009
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230081AbhHXFuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 01:50:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyzvCMJGsyISnAk7ihXa8odL8clEWFJHFjVm3/WEsBd/C6K1OTs+00Q4dPlGLF/W/QzSox75So9kF6f3ycm5aYEaJi+ngWHBmw9OPT8sbxpOTE1doOC/UB24wSGMGhOZpAcExPrmMKg1OGhhv3nrYNSBhHcppNVQXgsu7SU5SqkV9r0OkQ/urLVUCrVL4ks92dDRkM26p1m0JMz1B93kJ16H81q03WYOvZwch+FBnGWTx239kzfj326qG4JEPJugjqgc/HWXmo19tIZhyeIpFDA6tA7y5MnSlXyUWZ5LDuwrbeLswI3c1WQjmSyczgGtqxRRbfqVedC+Augl4zC3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6GDjpfZ9DXemZrDS0at7khXshXhL5DYK4htFxFu9fE=;
 b=iYPFzjJ7VPg0NmkgrH058AD6Wb+t958h6Z3VfVGb/kgZ2nKrkDngljDiYU3R9YWhv9oBg+6Zs1eLyW12XHpVTAKDCqC2YE3tvMEwLX92k+qxr0Nwf2IMrcYL+6BjDZGJaBaVCknAjzJWhzQlteOxd9cpPuMEHvHt4EBPHgbtJ9B4CxIY6V61PoD8KPr42z6iLAmAiD5cK7npaZBH4DPiWydZpkTJeqm5yfp5DR+bXynW35gEG3egOLFrmH5s/P6E+nuU4ZtWD7AyGweSxxlOV9eky8/5LvcXsfB8bLKowyKsbO8V+inkodCX5hNcu76y6/M7KaUQet5G4UPJR6xAwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6GDjpfZ9DXemZrDS0at7khXshXhL5DYK4htFxFu9fE=;
 b=cbIS3XukTbI/r+i1co1lNMr2XZLrtAQCpGadkYkOvFihNdtjHQ9A0dMwyO9Z/ez+fZO+K81LI2HGeV2ezvoL4u8A64CSfQlluUYM6VP1P7RNzgnj2WqKyQZjafP7Htgjfa6bp+d8WTUfOoe0hPLphEhkTT/MEiCOhEDDy+2vZzM=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYCPR01MB5936.jpnprd01.prod.outlook.com (2603:1096:400:42::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Tue, 24 Aug
 2021 05:49:14 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0%7]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 05:49:14 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     "osalvador@suse.de" <osalvador@suse.de>,
        "tdmackey@twitter.com" <tdmackey@twitter.com>,
        "david@redhat.com" <david@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 3/3] mm: hwpoison: dump page for unhandlable page
Thread-Topic: [v3 PATCH 3/3] mm: hwpoison: dump page for unhandlable page
Thread-Index: AQHXmI0lm7IBGD+NbE2ebMYKURY776uCJm8A
Date:   Tue, 24 Aug 2021 05:49:14 +0000
Message-ID: <20210824054914.GB1815685@hori.linux.bs1.fc.nec.co.jp>
References: <20210824020946.195257-1-shy828301@gmail.com>
 <20210824020946.195257-3-shy828301@gmail.com>
In-Reply-To: <20210824020946.195257-3-shy828301@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70fff54e-7519-42ac-aa20-08d966c2e7c0
x-ms-traffictypediagnostic: TYCPR01MB5936:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB59363951A6A61059AE4F5B0FE7C59@TYCPR01MB5936.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z4jMbleitdWFJlCOYQZpKSwR1RVlNillKn+Q/2z10+610ZY8Rqdsv5G0kuIoSacY97NvULJE7+54KvUnjrg1AKxwd93QmmD52etcQ7C3lejYKAhDT6yVRx6ModBR4p0z1ld6QuFtZpNaMPo3iQDRMgBsCr1HJIPbhCsrR3AmWmGxQRYn9W68WMJz7Nks+ouhaEcYn+qh0ekIUDl1mGDF/eHoBvzAFqN/RDPa1vWXyY2c2tbeF1/5kB4lIH78yv+zuVXmPJ61ZVRQm4niDGWGtt9EKSNyQ9PIoXamde4/CjtNsHjYM1BEOgX9SDsfkDaCD2+z/DFghsiRVJpDq91bGaY5zt582vExs5Ae5VlE0SPFDvN+WmbDEP0miXj7epJQ3Lj3pz4AQBLtNDHSs/ABQSnjjXuEmhpBvjE7AJMbUxWg0sTipBO9JeJZsXKhfd22oKxliZ46dy2x85BMWFq78XL67WfpWxhUwosM5m/A8do9nfBvv/t4tf1zWro2G7G3h+z8Etj9NeKUmXIrM4sTHel/WLyPRsnzD8jONEG//dkr/cXTxpLgZihpj/ebK1o6Ep5nRlVbAYdxFV1VT60Lp4XRBzjqT919zLiVpvVpszsh1zWn/13YM9UOEdA+9q4po4RE7+7mDD0dhTbd+jkIcAS+Vq7bPTN6wAFk3gbDs39jc3ey8UyFIy0EBeqw+LvofleT4JI5Z6Hk3c3GCYygMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(316002)(83380400001)(54906003)(71200400001)(6916009)(6506007)(85182001)(2906002)(4326008)(38100700002)(478600001)(33656002)(122000001)(38070700005)(76116006)(26005)(8936002)(86362001)(4744005)(8676002)(186003)(6486002)(66446008)(64756008)(66476007)(66556008)(66946007)(1076003)(55236004)(6512007)(9686003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkZBKzB1eVo2TjJxUWdtT1NTaStWWTZoS3RIQ0NUR0FyMi83S3ZvZUtoVTFM?=
 =?utf-8?B?bFVHVVVsM2hMNFUxamI3TEFRcktXMDNPbW1qY0RJaUtaMTllTTV2SlcxTGNR?=
 =?utf-8?B?L0x0QnZUMHJWUVluOHVZMEdnMnVUMTQyNzRLRDJ0L25EQTNlbDRmY3ZsNjFK?=
 =?utf-8?B?NmZMb0pKRi9zVnVWeDY1alNJUk9xS0Z6KzZ1Q2V3ZUliSC9LeGFDSSttcGJH?=
 =?utf-8?B?RUpQM2NxZFlvZlFYK094WTJzczZBb3M5ZlNCUDFMM1RMQTdOWWlwOWlmR1Nv?=
 =?utf-8?B?QmNmRXpSblVMOFpyUWRwTzVCc1JhNkMvRVM4bldLLzNaN0ZmOWltSWR1RHdz?=
 =?utf-8?B?RjcxejBqLzE2ZkZZeElXREkrYUtSK09lMEFEdFMyaWJ4MDExNHZ2VmhtR1BC?=
 =?utf-8?B?NGgxU3d4bFY2YWwxRDNadFNEalF3UmdnMjhPVVpWTENYbWIxR1FhMlZzcFd3?=
 =?utf-8?B?ZnFmTlpIdTZjTnJWNmZKalFOUFJ5L0FyZ2dhSndXVUVzbnBRcGkrVG15R29m?=
 =?utf-8?B?aHpRcy9xbkFQWno3TXB0L3Y2K3lNcWkzRzhCbW94RE95eXVBcUN0cUxTYkxH?=
 =?utf-8?B?ajdkVEd0N3M1RnJ2Wi9UQUI1ZHRneGJPNXlnR0RQbFM1VTkzV0prN2p2SHlj?=
 =?utf-8?B?U0RjbFlCN3Nhb0hQK0V2WkwvZzNpVDMyVDM0RTBvS1B4d0Y3dDZGdGVTdTJS?=
 =?utf-8?B?VjdObWlhbVhUallxNS96cWZoYzlQRjc2cGNEaUJOYTZON21IK2l4S3FLcjhi?=
 =?utf-8?B?U0xGUG1uM0ttaWRZNFdzY0x2ZTVOVm9DL1FyVXp6NjI3WHduMEluTmRnQnoy?=
 =?utf-8?B?MGdwM3VXOEwvemYzU0NWQjRoZkZUSkQzaDJjc2hTeXgvNjArTnZRZ1pRUmNt?=
 =?utf-8?B?Ty9Vb1E0emNuV2xpUjUrd1JkaXpqZWNiSmZtVHBlODU1TldJY1BBaE91NmtD?=
 =?utf-8?B?bUFJdFpFMC9yYStpYXNFa1dVWWVMQTh2aEtWQmMzdWc4NFduRStvM1FYN0xq?=
 =?utf-8?B?Yy9hcXZhWUVWUUZYSXNidUJGUC9CZWZqVmVHZUltSktiTU5HMFBoWjNSZC9p?=
 =?utf-8?B?VkZpdHV4M2RFd25QcTBSUGJMK21hTjUxQ2djbWxPYXE5a1k5YjM1cGRBcGVQ?=
 =?utf-8?B?QmdITWtaVldRWjhaUlZpNmdZbXBTdmM2cFFtQ25tcHpCbG85WjgwUFhaU1dp?=
 =?utf-8?B?dHk1YkdOa3p0WkJuSGo4cUJGSDA0RVRKNW1xTjhRWDM5bFhHL0J4TkdlbEFY?=
 =?utf-8?B?b0JKTU95Wk9FbDdKaHJVVFNBVnBGZ2FLZGJoSWJLc1pvb21pR1o2bzR1WWc5?=
 =?utf-8?B?cTNkeEc3a1QvcmdjTUpYQzJEbjY2M1llaWxQeXRHSWNaZE4xMk54NjNsREtR?=
 =?utf-8?B?ZGFQOEZOR2xBTnJ0T0JDWnRXdWM1bmhLcDFiaFM5dlZwYjdjMHlNdVJZWnpk?=
 =?utf-8?B?enZ3TlZyaSt2bUh1aHhLNXdDM3hicXhwNUw3MWNLRVlXR0htb2JZM3cwZ2tr?=
 =?utf-8?B?aVRua0Q1NU02bkhuOGI2djRMNEpmY1BCZmduejVudjVFbnhhb3M2engvTlAv?=
 =?utf-8?B?K1ljdm5adlFDc0piWlZVbVhWeWNYNUcwV1M1U0VJQ1JieXQ1Um1HSG5oczVY?=
 =?utf-8?B?aGN4Wkd6MW15VnI0emhya3gxYTI3NmtHWFJKTlZncWwvYWM5cHZGbU81SGVz?=
 =?utf-8?B?RE5wUXN4cnpuUEN3d21mNXVFSDh6cVZybGJxNTRwV3htOVRJVjYvU0VqZnd2?=
 =?utf-8?Q?GXBRASUq/1NAeAgvO/pbTdIzBguj+lnob6dueC6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8CD11ED65C48C44A038DEB9A22B3C80@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fff54e-7519-42ac-aa20-08d966c2e7c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 05:49:14.6768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OinzxYwXuTYLOVbNQwMRX4GWWuNAwU7LMYJ+7x/k7nFeiGDpQfDXIJ1lUgICJXRINBytavF9naZKgITl/2+1bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5936
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBdWcgMjMsIDIwMjEgYXQgMDc6MDk6NDZQTSAtMDcwMCwgWWFuZyBTaGkgd3JvdGU6
DQo+IEN1cnJlbnRseSBqdXN0IHZlcnkgc2ltcGxlIG1lc3NhZ2UgaXMgc2hvd24gZm9yIHVuaGFu
ZGxhYmxlIHBhZ2UsIGUuZy4NCj4gbm9uLUxSVSBwYWdlLCBsaWtlOg0KPiBzb2Z0X29mZmxpbmU6
IDB4MTQ2OWYyOiB1bmtub3duIG5vbiBMUlUgcGFnZSB0eXBlIDVmZmZmMDAwMDAwMDAwMCAoKQ0K
PiANCj4gSXQgaXMgbm90IHZlcnkgaGVscGZ1bCBmb3IgZnVydGhlciBkZWJ1ZywgY2FsbGluZyBk
dW1wX3BhZ2UoKSBjb3VsZCBzaG93DQo+IG1vcmUgdXNlZnVsIGluZm9ybWF0aW9uLg0KPiANCj4g
Q2FsbGluZyBkdW1wX3BhZ2UoKSBpbiBnZXRfYW55X3BhZ2UoKSBpbiBvcmRlciB0byBub3QgZHVw
bGljYXRlIHRoZSBjYWxsDQo+IGluIGEgY291cGxlIG9mIGRpZmZlcmVudCBwbGFjZXMuICBJdCBt
YXkgYmUgY2FsbGVkIHdpdGggcGNwIGRpc2FibGVkIGFuZA0KPiBob2xkaW5nIG1lbW9yeSBob3Rw
bHVnIGxvY2ssIGl0IHNob3VsZCBiZSBub3QgYSBiaWcgZGVhbCBzaW5jZSBod3BvaXNvbg0KPiBo
YW5kbGVyIGlzIG5vdCBjYWxsZWQgdmVyeSBvZnRlbi4NCj4gDQo+IFN1Z2dlc3RlZC1ieTogTWF0
dGhldyBXaWxjb3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+DQo+IENjOiBOYW95YSBIb3JpZ3VjaGkg
PG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiBDYzogT3NjYXIgU2FsdmFkb3IgPG9zYWx2YWRv
ckBzdXNlLmRlPg0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFNoaSA8c2h5ODI4MzAxQGdtYWlsLmNv
bT4NCg0KQWNrZWQtYnk6IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+
DQoNClRoYW5rIHlvdS4=
