Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477133584DC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhDHNjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:39:36 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:45506 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231195AbhDHNj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:39:28 -0400
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9568BC09C9;
        Thu,  8 Apr 2021 13:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617889156; bh=cSNVM6xT3EIlUTlTUc2Z7sLoAmkDxAcatFbcREupdzE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZkzdpmXWVyyj/FzlRuyNbB7MSAVGRkJEY7126tKtC0flAjBtZujEhQcS+T3CZmxyX
         UKcTBpZfPAm3GJ7jtzwGPhHhyxk1VN72+QmUU3yQBVDEbNyCoz9XSQ/3y7IY/G+YY8
         k//cBqZxOgmWhh6gSJqAjfnscbIeND/0xHEPLatctCb0glRyDM2sdOllykRyqpX1FF
         URkSmTkVVjXzLxhb8LubnVP1tFWvB4RWpjOb/ZHRHgV8+UFu3LKOKHjNQZJtfcV/1Y
         SKoAyz0rXro1LLXWkPsazl+5kj1ctg5aEmRUPpItXXeFvgoqgHnH6JPqsfNNaHwMLS
         82mBOA2k2bgnw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5226FA00AD;
        Thu,  8 Apr 2021 13:39:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6B47B80129;
        Thu,  8 Apr 2021 13:39:15 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Aqv8nzE+";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfcjA0Vll82QNezd3PHFAwbEHorzwLULDuPh1fuuhqTFbwK7v8vOrwOytOgjMI7vj7rThS1+QrBt1sSJjoO1hw7t2psBHDq/dE2Iepvp4XfE8s69ZElcV0UNFlUeipea6d/8Qhx6LXCaslW80z3+0VoWJ8CovI7u8zjw9XQlGZOn91haoxFv561XYhYE9ydLrMBhB+LoMHoyfVVl7MmWXHN8E4196rZPuf4xn8TOEPWGdJn/w30dFcepWQNh6YnUF1D4FRsZ3hvIqyg2Ozcu7NjkGIHrssR4qH1t4el19jkVqSoFxYVMe9j3HCNmm+Gv+a/iztJRFOj52byxT7KFmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSNVM6xT3EIlUTlTUc2Z7sLoAmkDxAcatFbcREupdzE=;
 b=Y+7mpLiWY+SIznwrSnPepdZ0gek0riL10h4i0xTc9hEksRocTDR/fFXwzx9xGRqy1AR1UWfBRKcpZXx/GGC9FQpA4vaeOPAVcusvj3duM7yvZUtEcY9HXnLAxuYcsBZ+4PTVFYEPq20y7oV4WebNTXV5r7oafDKMtgR/Xci/bgA6N/x/5Lpd2h5p/MoCz1mNkiVcwt/1yeD4lsnHz/Ep/+xAv6JTjgZXfIag31y9xdc9NniCzUUybpmr4pV8PO6/sErLVgCxK2Hsd3janRU6NewKN0IPsJeZCeAvcRmKcYgRrOjqV2kWE/FMCZsFyBUm6vvIuuzLB7MbBQJz1AXg8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSNVM6xT3EIlUTlTUc2Z7sLoAmkDxAcatFbcREupdzE=;
 b=Aqv8nzE+GzbTdlM5JaqE+3HtdpHXbCK2giUDL2saZKSb0QMGitjyxbqcCwpNDwLlnMP3CZwPS0oM7p2Q3SQpxWJ86iaXNY5GivicWObDTjd3rHgfcp/qmy1mpOU/fyLDZXM3vqNWJTA/lqFTZxpcBEg04bhSOgvMNAg2R3ov2qY=
Received: from BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16)
 by BYAPR12MB4773.namprd12.prod.outlook.com (2603:10b6:a03:109::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 8 Apr
 2021 13:39:13 +0000
Received: from BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1]) by BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1%4]) with mapi id 15.20.4020.018; Thu, 8 Apr 2021
 13:39:13 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Youn <John.Youn@synopsys.com>
Subject: Re: [PATCH v3 05/14] usb: dwc2: Update port suspend/resume function
 definitions.
Thread-Topic: [PATCH v3 05/14] usb: dwc2: Update port suspend/resume function
 definitions.
Thread-Index: AQHXLFvcQD45oeE2D0O0+MVEV8gDaqqqoGYA
Date:   Thu, 8 Apr 2021 13:39:13 +0000
Message-ID: <8e928fca-a36c-f8f3-bc65-57d27ef93579@synopsys.com>
References: <cover.1617782102.git.Arthur.Petrosyan@synopsys.com>
 <20210408094502.61D18A0232@mailhost.synopsys.com>
In-Reply-To: <20210408094502.61D18A0232@mailhost.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.80.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f25f7adc-d7fe-4805-a272-08d8fa93b271
x-ms-traffictypediagnostic: BYAPR12MB4773:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB4773A1E61171D85516C7FE28A7749@BYAPR12MB4773.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zM22hLwa5YazvnRlWB7k4h3cIvOedCGTSgfjxiNYLBnrniiaMyY6HrItt46LUmAbC8RHGYUi7Qb2Ak+G3c0DW5yYPu0IVao7UiMj/AE/EiQc5QVsdD81YK/QO0N4inFoR2xqSuoohU5dki/WdUOgoHYCGKyMfJqFct+2MSYBFaMxdA8fWHHHAHZqLCaAAKbLKzyWJTaXismjGWhsYOW9DjJAL/qVSb2PpblzSKhJcOvPMmv0YMM2KTWmi62cy8vHvVS3+nhmg4XGhcOXIR3dkxHJEa1jD9S+DxfYCArhY2Yu40qYYUpXGeSDdi+gbAZmEvxvFDSTyCV1b9FvICwbf14HDBa57tcyjfuya0dhQKo5O1aqsuOPn7vT336OMYVeiG8O7fp/rUuWTlZxNvrLA6d4uJS+B9UGRTJQ3zyTMpsUpM17bRk77j+m4BAj6N2x4FFgBWZ/x88eld36MifLDbA3Ws7jkF2YRaJEeOUQsRBk6m3uVU3XlR69nK17SPJi3KA0EO6Jsg3Nn8YErvtPfJfO9xUMtOyTAFv9cUg6ixhn5U0Rmcv3dQdjvRQg4RZ/rg8lnuc+aAvWa09fvjdmY2SKY8ucCs3AAVasGFjbuAPVeA/UISfAOHqeUn/EDnOA24lI2rJlNBMEEL5SJvERYzCiQTQZ3N18f5rl1w96so4lVDBlmhyao5qETnCknlSKDH1r9L7Nd96tYuJavEruVnAO/0i6y87cARv1tDZq6L4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3462.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(396003)(136003)(376002)(39860400002)(66476007)(66946007)(66556008)(83380400001)(107886003)(64756008)(31686004)(478600001)(66446008)(15650500001)(4326008)(86362001)(36756003)(31696002)(6512007)(110136005)(316002)(2616005)(2906002)(8676002)(5660300002)(8936002)(6506007)(6486002)(186003)(38100700001)(26005)(76116006)(71200400001)(91956017)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TGY5d0pGcktSMmg3NzF5ZUFWcnlQOXJDYmNPS1RhOWJXSzRoV3RtZ1hmLzJB?=
 =?utf-8?B?cmR1dkpaMmhyaldiSURUallPWXY0NEZXempsV3ZTeWVWVzNMK3NISTg0MWNm?=
 =?utf-8?B?bHF4S213V0tiTFdXK3EwZnFzV0ZpLzlFSmprM1paRkJQU3dCaUxqR2l3b3Zy?=
 =?utf-8?B?cU5tR1VZRGs5SE1JQWlONlJ5Q0xLT0N4RGtiL1dtYjlaWjVKbk5QL0hTR3Az?=
 =?utf-8?B?aFh0b3JjYlZlYm96Z0dvKzc3cWpFUkFweGN1ZWdGa1FSK2ExRjBSOVdSaC9r?=
 =?utf-8?B?cjBWQ3hpWW5LV1QxNmhnclVSUXhFZXBIbnFHc0hiaVZaMDBMSER6VWtUWEFL?=
 =?utf-8?B?SDZ5UHFtYktNTmFVNTRkZFc0NTBDbm14N3NVWHJRVytMR2FqVlZYWEhPRVBr?=
 =?utf-8?B?azJrQW9rQWU0MFJrc0JwRlVuV2hhbC9JYS94Qjg0NElpRVZ6S1Uwb2gvUEFt?=
 =?utf-8?B?OGhBbGxpdFpicU5pMCtCRUxaMmVhckJpRWVacVFJWUJJU2VHOTRnQVJUMHRo?=
 =?utf-8?B?bitmTzFMR1lJSW1xVjRaOWpyRGZ2dGVVQU82c0hkRjdCMFV1Y1pDeDZvc3Vr?=
 =?utf-8?B?WitCWjlBMEppY1RISE1hTVloYWNwZGlCbFZQVXdldmZHZmJsczk4bzdBRUxL?=
 =?utf-8?B?TXNsUkYxSUZGOHh1N0xjdGFFemRZWXhySW0xSkEzd0lvclpJdlRQSkdackdD?=
 =?utf-8?B?dTdoSmFaTUU2cHZPekgyeWpLUW5DRkZXMm1ZbW10OTlpYit3c2pFcVJ5N3hV?=
 =?utf-8?B?TUhJZDBUeUg0bERNaWtaN2lSNnVDQk1PeUJVcnArcmlnaFBlZzdTV3c3V0lh?=
 =?utf-8?B?Um0ra2wzODFwVGZVdnNCY0p0clJ2OThmV29WS2hzWnBwdEo2aU5hU2VEMndE?=
 =?utf-8?B?djJKc0lmek1mQUNlUnBsSzNMbzRITzkyWmxBdkVpbXBwL3VsTWdUQ0ZrQVdO?=
 =?utf-8?B?VzNDMEZNWjNXZUJGRW13VUxLZ2hHQ2kxMC9hVVFPb0I0QnpwZTJhS05iZ25I?=
 =?utf-8?B?emRaVFV5RUY1ejJFNG5WNGxDcUc3REY5Q08waS94K2hnaUJuNEJ2VVB5RGNh?=
 =?utf-8?B?T1ZUc2tuaERNOEExMG8wMCtPMmFEcElaMGJQdVJaNHB0TDNOQ2JUdzhuZ01B?=
 =?utf-8?B?aXJLblM5cGJUUUY1N3FUcnRpVnZUQW9tMHJyaDRPZm03YlNGMzNNTHMvbWNQ?=
 =?utf-8?B?R3QySHB2SlgxcXhpVXkvVVJ6M2NzNDZtamlQRk5MT2lPUVN2bjd3bWI2SnNa?=
 =?utf-8?B?Q2NONTZWKy83dGd6Q0xGOXNoMm9DK1dPR3VhMjhOYnZ0YVVKbC8xbzZMdTl3?=
 =?utf-8?B?UzdDSXJYMWovbDl6NTJkb1dYYkZSdGdaMkZueXdSN01WOXpNZW5lL2dONlBw?=
 =?utf-8?B?cDUzK05oZENUVGpNamVyQTgwS2J0OHV5cjVaT2hoZDBVWHRCNk9BZERjQTZt?=
 =?utf-8?B?UW1mYTE1UmRldVpRQndHWGlCdGxtUldCcExwSlFHcy8vWEdUeGlyZXdUVXlR?=
 =?utf-8?B?bmpMQWJ3amJ0MVEwU3ZJb2FhU2VrdFdGVTRPMEFBaW5Kc1dBUGxycUkzWUM2?=
 =?utf-8?B?Y2s5QndNck9qRExkSEtnYmZ4UEVkdVlSSTVWY3dEVlpVdUN6QVZGUzIrL0pK?=
 =?utf-8?B?SDNETTNuUGJhQkJRN3ZvSE94RTcrVnZ1VFA2ZmtDU2tyWTZoM1hYMFc4Rzda?=
 =?utf-8?B?NjVrSi8vd1JYWXZNMkZHRUEwcm9iZVFvYnlRWmxCYVRtZnE0S2lBcGhzcFps?=
 =?utf-8?Q?/ZBQIwgYlE8xWfRmOU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA4ECF60D619424C9F08FB62475D79EF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f25f7adc-d7fe-4805-a272-08d8fa93b271
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 13:39:13.2154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ANThOkuox3aLv5z1ZTgIe7QDoMu6rrWiBI6O9u/qBgIktyv7Z6pLO3PvNuRhT+3h25NG7Num/nKyNmIyxQAsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4773
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC84LzIwMjEgMTo0NSBQTSwgQXJ0dXIgUGV0cm9zeWFuIHdyb3RlOg0KPiBFYXJsaWVyICJk
d2MyX3BvcnRfc3VzcGVuZCgpIiBhbmQgImR3YzJfcG9ydF9yZXN1bWUoKSIgZnVuY3Rpb25zDQo+
IHdlcmUgaW1wbGVtZW50ZWQgd2l0aG91dCBwcm9wZXIgZGVzY3JpcHRpb24gYW5kIGhvc3Qgb3Ig
ZGV2aWNlIG1vZGUNCj4gZGlmZmVyZW5jZS4NCj4gDQo+IC0gQWRkZWQgImR3YzJfcG9ydF9zdXNw
ZW5kIiBhbmQgImR3YzJfcG9ydF9yZXN1bWUiIGZ1bmN0aW9ucyB0bw0KPiAgICAiY29yZS5oIiBo
ZWFkZXIgZmlsZS4NCj4gDQo+IC0gVXBkYXRlZCBmdW5jdGlvbiBkZXNjcmlwdGlvbiBpbiBkb2N1
bWVudGF0aW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQXJ0dXIgUGV0cm9zeWFuIDxBcnRodXIu
UGV0cm9zeWFuQHN5bm9wc3lzLmNvbT4NCg0KQWNrZWQtYnk6IE1pbmFzIEhhcnV0eXVueWFuIDxN
aW5hcy5IYXJ1dHl1bnlhbkBzeW5vcHN5cy5jb20+DQoNCj4gLS0tDQo+ICAgQ2hhbmdlcyBpbiB2
MzoNCj4gICAtIE5vbmUNCj4gICBDaGFuZ2VzIGluIHYyOg0KPiAgIC0gTm9uZQ0KPiANCj4gICBk
cml2ZXJzL3VzYi9kd2MyL2NvcmUuaCB8ICA0ICsrKysNCj4gICBkcml2ZXJzL3VzYi9kd2MyL2hj
ZC5jICB8IDI1ICsrKysrKysrKysrKysrKysrKystLS0tLS0NCj4gICAyIGZpbGVzIGNoYW5nZWQs
IDIzIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZHdjMi9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MyL2NvcmUuaA0KPiBpbmRleCAz
OTAzNzcwOWEyYWQuLmI3ZDk5Y2Y5ZTg0YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdj
Mi9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9jb3JlLmgNCj4gQEAgLTE0NzAsNiAr
MTQ3MCw4IEBAIHZvaWQgZHdjMl9oY2RfY29ubmVjdChzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcp
Ow0KPiAgIHZvaWQgZHdjMl9oY2RfZGlzY29ubmVjdChzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcs
IGJvb2wgZm9yY2UpOw0KPiAgIHZvaWQgZHdjMl9oY2Rfc3RhcnQoc3RydWN0IGR3YzJfaHNvdGcg
Kmhzb3RnKTsNCj4gICBpbnQgZHdjMl9jb3JlX2luaXQoc3RydWN0IGR3YzJfaHNvdGcgKmhzb3Rn
LCBib29sIGluaXRpYWxfc2V0dXApOw0KPiArdm9pZCBkd2MyX3BvcnRfc3VzcGVuZChzdHJ1Y3Qg
ZHdjMl9oc290ZyAqaHNvdGcsIHUxNiB3aW5kZXgpOw0KPiArdm9pZCBkd2MyX3BvcnRfcmVzdW1l
KHN0cnVjdCBkd2MyX2hzb3RnICpoc290Zyk7DQo+ICAgaW50IGR3YzJfYmFja3VwX2hvc3RfcmVn
aXN0ZXJzKHN0cnVjdCBkd2MyX2hzb3RnICpoc290Zyk7DQo+ICAgaW50IGR3YzJfcmVzdG9yZV9o
b3N0X3JlZ2lzdGVycyhzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcpOw0KPiAgIGludCBkd2MyX2hv
c3RfZW50ZXJfaGliZXJuYXRpb24oc3RydWN0IGR3YzJfaHNvdGcgKmhzb3RnKTsNCj4gQEAgLTE0
OTMsNiArMTQ5NSw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBkd2MyX2hjZF9zdGFydChzdHJ1Y3Qg
ZHdjMl9oc290ZyAqaHNvdGcpIHt9DQo+ICAgc3RhdGljIGlubGluZSB2b2lkIGR3YzJfaGNkX3Jl
bW92ZShzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcpIHt9DQo+ICAgc3RhdGljIGlubGluZSBpbnQg
ZHdjMl9jb3JlX2luaXQoc3RydWN0IGR3YzJfaHNvdGcgKmhzb3RnLCBib29sIGluaXRpYWxfc2V0
dXApDQo+ICAgeyByZXR1cm4gMDsgfQ0KPiArc3RhdGljIGlubGluZSB2b2lkIGR3YzJfcG9ydF9z
dXNwZW5kKHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZywgdTE2IHdpbmRleCkge30NCj4gK3N0YXRp
YyBpbmxpbmUgdm9pZCBkd2MyX3BvcnRfcmVzdW1lKHN0cnVjdCBkd2MyX2hzb3RnICpoc290Zykg
e30NCj4gICBzdGF0aWMgaW5saW5lIGludCBkd2MyX2hjZF9pbml0KHN0cnVjdCBkd2MyX2hzb3Rn
ICpoc290ZykNCj4gICB7IHJldHVybiAwOyB9DQo+ICAgc3RhdGljIGlubGluZSBpbnQgZHdjMl9i
YWNrdXBfaG9zdF9yZWdpc3RlcnMoc3RydWN0IGR3YzJfaHNvdGcgKmhzb3RnKQ0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvZHdjMi9oY2QuYyBiL2RyaXZlcnMvdXNiL2R3YzIvaGNkLmMNCj4g
aW5kZXggZGQwMzYyZTA3NDQ0Li5mNDI0N2E2NmMyYjIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
dXNiL2R3YzIvaGNkLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9oY2QuYw0KPiBAQCAtNTYs
OCArNTYsNiBAQA0KPiAgICNpbmNsdWRlICJjb3JlLmgiDQo+ICAgI2luY2x1ZGUgImhjZC5oIg0K
PiAgIA0KPiAtc3RhdGljIHZvaWQgZHdjMl9wb3J0X3Jlc3VtZShzdHJ1Y3QgZHdjMl9oc290ZyAq
aHNvdGcpOw0KPiAtDQo+ICAgLyoNCj4gICAgKiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ICAgICogIEhv
c3QgQ29yZSBMYXllciBGdW5jdGlvbnMNCj4gQEAgLTMyNzcsOCArMzI3NSwxNiBAQCBzdGF0aWMg
aW50IGR3YzJfaG9zdF9pc19iX2hucF9lbmFibGVkKHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZykN
Cj4gICAJcmV0dXJuIGhjZC0+c2VsZi5iX2hucF9lbmFibGU7DQo+ICAgfQ0KPiAgIA0KPiAtLyog
TXVzdCBOT1QgYmUgY2FsbGVkIHdpdGggaW50ZXJydXB0IGRpc2FibGVkIG9yIHNwaW5sb2NrIGhl
bGQgKi8NCj4gLXN0YXRpYyB2b2lkIGR3YzJfcG9ydF9zdXNwZW5kKHN0cnVjdCBkd2MyX2hzb3Rn
ICpoc290ZywgdTE2IHdpbmRleCkNCj4gKy8qKg0KPiArICogZHdjMl9wb3J0X3N1c3BlbmQoKSAt
IFB1dCBjb250cm9sbGVyIGluIHN1c3BlbmQgbW9kZSBmb3IgaG9zdC4NCj4gKyAqDQo+ICsgKiBA
aHNvdGc6IFByb2dyYW1taW5nIHZpZXcgb2YgdGhlIERXQ19vdGcgY29udHJvbGxlcg0KPiArICog
QHdpbmRleDogVGhlIGNvbnRyb2wgcmVxdWVzdCB3SW5kZXggZmllbGQNCj4gKyAqDQo+ICsgKiBU
aGlzIGZ1bmN0aW9uIGlzIGZvciBlbnRlcmluZyBIb3N0IG1vZGUgc3VzcGVuZC4NCj4gKyAqIE11
c3QgTk9UIGJlIGNhbGxlZCB3aXRoIGludGVycnVwdCBkaXNhYmxlZCBvciBzcGlubG9jayBoZWxk
Lg0KPiArICovDQo+ICt2b2lkIGR3YzJfcG9ydF9zdXNwZW5kKHN0cnVjdCBkd2MyX2hzb3RnICpo
c290ZywgdTE2IHdpbmRleCkNCj4gICB7DQo+ICAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICAg
CXUzMiBocHJ0MDsNCj4gQEAgLTMzMjgsOCArMzMzNCwxNSBAQCBzdGF0aWMgdm9pZCBkd2MyX3Bv
cnRfc3VzcGVuZChzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcsIHUxNiB3aW5kZXgpDQo+ICAgCX0N
Cj4gICB9DQo+ICAgDQo+IC0vKiBNdXN0IE5PVCBiZSBjYWxsZWQgd2l0aCBpbnRlcnJ1cHQgZGlz
YWJsZWQgb3Igc3BpbmxvY2sgaGVsZCAqLw0KPiAtc3RhdGljIHZvaWQgZHdjMl9wb3J0X3Jlc3Vt
ZShzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcpDQo+ICsvKioNCj4gKyAqIGR3YzJfcG9ydF9yZXN1
bWUoKSAtIEV4aXQgY29udHJvbGxlciBmcm9tIHN1c3BlbmQgbW9kZSBmb3IgaG9zdC4NCj4gKyAq
DQo+ICsgKiBAaHNvdGc6IFByb2dyYW1taW5nIHZpZXcgb2YgdGhlIERXQ19vdGcgY29udHJvbGxl
cg0KPiArICoNCj4gKyAqIFRoaXMgZnVuY3Rpb24gaXMgZm9yIGV4aXRpbmcgSG9zdCBtb2RlIHN1
c3BlbmQuDQo+ICsgKiBNdXN0IE5PVCBiZSBjYWxsZWQgd2l0aCBpbnRlcnJ1cHQgZGlzYWJsZWQg
b3Igc3BpbmxvY2sgaGVsZC4NCj4gKyAqLw0KPiArdm9pZCBkd2MyX3BvcnRfcmVzdW1lKHN0cnVj
dCBkd2MyX2hzb3RnICpoc290ZykNCj4gICB7DQo+ICAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+
ICAgCXUzMiBocHJ0MDsNCj4gDQoNCg==
