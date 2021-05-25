Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881EB38FCE0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhEYIeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:34:05 -0400
Received: from mail-eopbgr1400084.outbound.protection.outlook.com ([40.107.140.84]:16427
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231365AbhEYIeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:34:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKDcq27z3pNxoMOPNjZscQGojJjKCFB63VDg4pPKCqTSFBBmGcievzwMgqcncN+yZhircUfIbsh1VGzR1lBVESeIomQjD7CY/e+5ngbv72/1JtbqgPxmc186V8VPTSm9QJFEjlARPbFo2wuHBAuEwO6xoBKcKgat1lkvmQvQ9H/uXOoYgNrWlbv0ibQBLmNTnWHdMaeHrAxK9eD22MKBK5M+QOVSpQy2zcybonElxLkBhwx5uNbeSrwhiR3Vi98E1mHNhtEHJ9cxZTojbGPBQqgNAzQpH7+VLIw/cE1pHkZ6cn+sVg6KemCtzFR2heBmELbu/l/XBCrPChmbDqaBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pigyx2DoKbSMx26IPRGfSIt7AgCiWXadjiKmYn+ikAM=;
 b=ZIKfJ5fZOsAlxPqN69k6CkLx+3Ia6QEF41IKt02aed9vsGRrOqkW1sWOR2fju2jkqriQmDABD6DYPNYV9/QdAjIoNc/hTaD0QPkv7fxWTpcs+XduC4iOZ66pTz0e9sTkT7FZ2THvNMrGFhuWYHVwsYa8lJ2m8oyzVJAliNQENp3BBVXVqYrAdXRxc1fmytCqDXJUo7fx4r4Cqkn6hFF4W6ocD91D7COFLD9MPVgOjKeinSoUScHFMEeKoWqgXNN8CUpRn1RyYlINeQzrTtH6fm8vzncspZDfEFbNc4VkPT7fYN929JB0Jcxw3f5MRN7e6G/zymIKvBv/HNgzhPp48Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pigyx2DoKbSMx26IPRGfSIt7AgCiWXadjiKmYn+ikAM=;
 b=lJr5M6y2iKE1JK1tOGExe6hF8oEL0JC5vuYcD7lo0GlZnEL/CJTQbdES0eYReRSiKTXfQy7JirOkoBqeaz3Oiroce76dwPN10VvEhN3PNTcDCQRKer2pukxrobeE+75cZ2vJ5S7MxV/IRMPB6Pt/X/CyTgLVb8vNKDthzJkIEMI=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYYPR01MB7055.jpnprd01.prod.outlook.com (2603:1096:400:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Tue, 25 May
 2021 08:32:29 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563%5]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 08:32:28 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Ding Hui <dinghui@sangfor.com.cn>
CC:     "david@redhat.com" <david@redhat.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm/page_alloc: fix counting of free pages after take
 off from buddy
Thread-Topic: [PATCH v2] mm/page_alloc: fix counting of free pages after take
 off from buddy
Thread-Index: AQHXQ74qL5MFfER7lUaoGADjzS21U6rz+YEA
Date:   Tue, 25 May 2021 08:32:28 +0000
Message-ID: <20210525083228.GA3327407@hori.linux.bs1.fc.nec.co.jp>
References: <8cd355d2-1adc-4189-7b65-cfea13129db5@sangfor.com.cn>
 <20210508035533.23222-1-dinghui@sangfor.com.cn>
In-Reply-To: <20210508035533.23222-1-dinghui@sangfor.com.cn>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sangfor.com.cn; dkim=none (message not signed)
 header.d=none;sangfor.com.cn; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e4de251-5f16-4bd9-c9d8-08d91f57a1fb
x-ms-traffictypediagnostic: TYYPR01MB7055:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYYPR01MB70559115D38DE7AE7B06F8B8E7259@TYYPR01MB7055.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Khg+au9qr8U/68bwtQtID80aSoqV7Gq8z0GY5gOBB0uDLSoaBk/q8OgzTdA0oMC6zLVSpHnxEjw1oaCyV2+iOIWVODLcI7KCuCC93y/vzjO7TB2/VFwxWFNziiQS+34jvlMLsNlY9aPJd5Fsx4Q6fkGa0Sxs1cMtX9q5ksUO/jm+EwWANwWqj/E8U8MR+03RHWl4u+CT4gbuBAOanw9+wC+WT93EAnqBOQ69ED/VHQ8KCVobOmWgnUZpsti2eFYiBr5GIbneHY1n4hYCnjjQgs/64Unycw0Mg6A224dkNTGJbn/vKr8EMRVbI7x0sVQ0TjK/B4+Tkrm3XBgeXYOD/VCGkF3VuIcClB6m/+HCkAFsjsqHUisgFfAvIjR53rV8B1lFXgGfUfLTcyFNGvcEoUATIRIUSl02ieRBbP0KUgYGF95PyZNsmn3sX2tPUcofPyKaV48cdvLnyFulWOGwnZwZDZwAxdplUcITpI5z3GnUEzPJ1hlPp/HpQmPH+1KyEuhfqzGbRv+gWV16nZWcUuecsC5DZthcwevcjzrdK8a8UJFmIZr3H3pQ9DZEt/z54wQfISSwEjELkShx18NOaJ26I7fq8Z7MoGCTbOCMRMI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(122000001)(71200400001)(86362001)(186003)(6916009)(6506007)(6486002)(55236004)(316002)(33656002)(478600001)(66946007)(64756008)(38100700002)(54906003)(66446008)(26005)(9686003)(76116006)(66556008)(66476007)(83380400001)(85182001)(8936002)(8676002)(6512007)(5660300002)(1076003)(4326008)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MkYvd0FVR3RqV2FkaDR5a1l5WkJZZnMybnpUVm0yTFdla0pxbXRQQ3Fxb1Z6?=
 =?utf-8?B?b2xVZWRackZpcFNzOVNsWXlYNmNHTkg3NnRPVE5nVWVRR01acnRVWVJWTzgr?=
 =?utf-8?B?TWpJMGdLWFV2cEQvVG12UWVGUi9oajN3Y3k2OFB4MHFsd001MXdNUFUvSm1y?=
 =?utf-8?B?TVZUVXQrS0tRemNtQkw0aUVOeUszbGkzZmk3N29Ja3kyTWJ2cWdCVzcyRUVu?=
 =?utf-8?B?K1UzQWROUlFWMlBNREtuNFBmL0g2SzNMdTZPRVp5YlplZURmREJCMEgyRDVs?=
 =?utf-8?B?RWwzYmpKOFJqejdBL2M5YmRldWgvYTZBUksvb213M2h3UHdka1Q4UnBrRXkr?=
 =?utf-8?B?U2FtZis4UkFJaHpHVXB4Q2dpcVZod3c0bmRDN3ZtZnJMQlVjeFBaRERJRkxo?=
 =?utf-8?B?ZjNvQ3NOeHc4aWFmREZqc05iSHN1Rm5Sa1pWS1BPVDRwVXc5dFRIcmUxeHRS?=
 =?utf-8?B?cGhhTFNoaUthTlBadFZYaS9PejFYbjhUUlphalZibFptMWtEZ3QrcmtHRENU?=
 =?utf-8?B?czZZMVJtcUp5QkZDaHV6UFdEMTczZW5zTnRJN0pySGdiR2g3cXhNTEdxSmUz?=
 =?utf-8?B?aEVUZ3VZd3ZSbGdJTkNoc012ODVTM0gwNlNpL0xRMFMvbmdtUDlYSnJ1dUNz?=
 =?utf-8?B?dDZ5SFFVS0t4cVByVGh0TmJTK01wTVllcGJCR2Z0WjlwRVV4eUlka2VOL1JN?=
 =?utf-8?B?UCtYUHJVV1NTak9lNnR4REtWVWQyL1pLUmhmM2tybGtGTGlWeEJLaTRIenE1?=
 =?utf-8?B?NzE1Yis1VXV3UGxZakNHMDFBRENpSlpJcnd3bE5RQ21scFNXK09iQ3lYLzgr?=
 =?utf-8?B?MDlPWVdvS3Z3aTBsVUQxMjVaRXZkbWVLViswdDQwWFkwQmY0aUlYQjZnWnV2?=
 =?utf-8?B?UlRXOXRHbURxWm16YVd6N0FqRCtzS1VvMVNnTGEyTVQxUytFSmtweU9ZSkdy?=
 =?utf-8?B?T3VzaUF6NnJJTnh6VXBacXN4cThRdzFONW1zSndpNUpUZ1dBcDkzOVRIaUo3?=
 =?utf-8?B?cXVqTW5xbDREbVpoTzJxVExyRnpGMm5HczA0Q2lKRmczUWdHZ3NlMlMzcnU2?=
 =?utf-8?B?Z2JOV0RxeTBuY0pIZzllTllKd0xRUzF3L20yMUpmUXZtcDF0M0VQaStPL2d5?=
 =?utf-8?B?QjZjSVZhUDNwYm0wRUM5WTh4K1pRWks1dEhjak9tUXNwczJhVy9oZUc2YnU3?=
 =?utf-8?B?Rm9VL3IxTE5sOFQ5a2N4UFdLdDIyeUtJejdGdHlIbDIwbDRUVHVlQWZEK2ph?=
 =?utf-8?B?eVBxNU1ZcFBlMFVQaHNlT3VnNE5JUHpsbnVpdkg0cWo1WkdFN3VoZ3krcm5u?=
 =?utf-8?B?YU5XRXpyc2Y0S0NDOTR6QUZybHErZVViMXhZcE5udE8wRXBDdUh6SldWVjZ4?=
 =?utf-8?B?eWdzUGFwZzdTRXNFS2dyNGhncU15S0pYdTdGdFZEYzB4bThQb0JuRGdyMklj?=
 =?utf-8?B?aHlLTVhGeTVETGU1SElLaFMwRytWeC95bUQyN2FmUm9kWVExdWd2My8zVTBB?=
 =?utf-8?B?bzhjU0dSSG4vdFhvZVgwVGVUc1I2UVpMVVlVS0FUNzh2dWdtWnlXalJwSHhD?=
 =?utf-8?B?SEVjeFVjeVRVSmRiZjZUK3pMOU1vaVBHSU82Wk9pZjVPUUV3b1JZTEE4dldr?=
 =?utf-8?B?cnY2bEk1d284S29MYlF2SEZkc0VvR3c0amcwUEtTYjl6UE1jSEFON0ZtNDgz?=
 =?utf-8?B?bXovL015aWU3aGJNU0xodlZtYkFwb0NLbnlkTk1WRmFudDdGV1RrUkZ0Y1hR?=
 =?utf-8?Q?Fos8z09XAlMRN41/jDxkFuUrEgS9gCmzsaJYJ/w?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0210AAB5204832418C5CAB19DD1B5E6D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4de251-5f16-4bd9-c9d8-08d91f57a1fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 08:32:28.9085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QIr6D/e1k27ktt0Qn7kl+wSHhvExKamaqjAj50c/zioy+CR/urur1opQTOq/em6dMzvB6aPFLkozvCJdFi4IpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBNYXkgMDgsIDIwMjEgYXQgMTE6NTU6MzNBTSArMDgwMCwgRGluZyBIdWkgd3JvdGU6
DQo+IFJlY2VudGx5IHdlIGZvdW5kIHRoZXJlIGlzIGEgbG90IE1lbUZyZWUgbGVmdCBpbiAvcHJv
Yy9tZW1pbmZvIGFmdGVyDQo+IGRvIGEgbG90IG9mIHBhZ2VzIHNvZnQgb2ZmbGluZS4NCj4gDQo+
IEkgdGhpbmsgaXQncyBpbmNvcnJlY3Qgc2luY2UgTlJfRlJFRV9QQUdFUyBzaG91bGQgbm90IGNv
bnRhaW4gSFdQb2lzb24gcGFnZXMuDQo+IEZvciBvZmZsaW5lIGZyZWUgcGFnZXMsIGFmdGVyIGEg
c3VjY2Vzc2Z1bCBjYWxsIHRha2VfcGFnZV9vZmZfYnVkZHkoKSwgdGhlDQo+IHBhZ2UgaXMgbm8g
bG9uZ2VyIGJlbG9uZyB0byBidWRkeSBhbGxvY2F0b3IsIGFuZCB3aWxsIG5vdCBiZSB1c2VkIGFu
eSBtb3JlLA0KPiBidXQgd2UgbWlzc2VkIGFjY291bnRpbmcgTlJfRlJFRV9QQUdFUyBpbiB0aGlz
IHNpdHVhdGlvbi4NCj4gDQo+IERvIHVwZGF0ZSBsaWtlIHJtcXVldWUoKSBkb2VzLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogRGluZyBIdWkgPGRpbmdodWlAc2FuZ2Zvci5jb20uY24+DQo+IC0tLQ0K
PiBWMjoNCj4gdXNlIF9fbW9kX3pvbmVfZnJlZXBhZ2Vfc3RhdGUgaW5zdGVhZCBvZiBfX21vZF96
b25lX3BhZ2Vfc3RhdGUNCj4gDQo+ICBtbS9wYWdlX2FsbG9jLmMgfCAxICsNCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21tL3BhZ2VfYWxsb2Mu
YyBiL21tL3BhZ2VfYWxsb2MuYw0KPiBpbmRleCBjZmM3Mjg3Mzk2MWQuLmUxMjRhNjE1MzAzYiAx
MDA2NDQNCj4gLS0tIGEvbW0vcGFnZV9hbGxvYy5jDQo+ICsrKyBiL21tL3BhZ2VfYWxsb2MuYw0K
PiBAQCAtODk0Nyw2ICs4OTQ3LDcgQEAgYm9vbCB0YWtlX3BhZ2Vfb2ZmX2J1ZGR5KHN0cnVjdCBw
YWdlICpwYWdlKQ0KPiAgCQkJZGVsX3BhZ2VfZnJvbV9mcmVlX2xpc3QocGFnZV9oZWFkLCB6b25l
LCBwYWdlX29yZGVyKTsNCj4gIAkJCWJyZWFrX2Rvd25fYnVkZHlfcGFnZXMoem9uZSwgcGFnZV9o
ZWFkLCBwYWdlLCAwLA0KPiAgCQkJCQkJcGFnZV9vcmRlciwgbWlncmF0ZXR5cGUpOw0KPiArCQkJ
X19tb2Rfem9uZV9mcmVlcGFnZV9zdGF0ZSh6b25lLCAtMSwgbWlncmF0ZXR5cGUpOw0KDQpQYWdl
IG9mZmxpbmUgY29kZSAoc2VlIHNldF9taWdyYXRldHlwZV9pc29sYXRlKCkpIHNlZW1zIHRvIGhh
bmRsZQ0KTlJfRlJFRV9QQUdFUyBjb3VudGVyIGluIGl0cyBvd24gd2F5LCBzbyBJIHRoaW5rIHRo
YXQgaXQncyBtb3JlIGNvcnJlY3QgdG8NCmNhbGwgX19tb2Rfem9uZV9mcmVlcGFnZV9zdGF0ZSgp
IG9ubHkgd2hlbiBpc19taWdyYXRlX2lzb2xhdGUobWlncmF0ZXR5cGUpKQ0KaXMgZmFsc2UuDQoN
Ck90aGVyd2lzZSwgdGhlIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUuDQoNClRoYW5rcywNCk5hb3lh
IEhvcmlndWNoaQ0KDQo+ICAJCQlyZXQgPSB0cnVlOw0KPiAgCQkJYnJlYWs7DQo+ICAJCX0NCj4g
LS0gDQo+IDIuMTcuMQ0KPiA=
