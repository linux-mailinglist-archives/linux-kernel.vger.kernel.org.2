Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E969D313212
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhBHMSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:18:04 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:31504 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbhBHMAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612785645; x=1644321645;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aDrpuNgcXzO1r7l59ezzLmvCA9AdVsvjpVuHXu7qd7U=;
  b=GZ6UkCcIFXMhqe8tzhet/ckYQ3c9y8dq7Eg4C1AmG14m9W5Fn/l1InZ3
   WHtg2YUCNFzjdGC7rkgbpuz3dy63rOHpZ7MNVJWuayH0iBUW/jA6hVzFA
   ZcOd0f0XiRwKrj5OGVo2k8IzkZ9sZ4YOIrHBMRqq9Jq8PjvI8RLcmgsOO
   lCCiHT0Nn7CTeObmW9/Z/E9wD0SNEOOqbvX2hBLYQgQTjQHAl0h7WGk0j
   xHMgnCxG9pBQArp3O8VTdVNe2/wGmEt3WgQwJSFyA78rmSFP4lci73lBH
   6EEoEwkLGjUpRVsrmoUONfNru1nDvrX7JivKuzxc//GBbdwvX3Wr/txEa
   g==;
IronPort-SDR: 9z7mFZWFaE1itRc0jtfTA2cXt4JbTM41fSQkOP7MTFsoeQw8eAbyD9NuLtJY0uDPbRDSlDYZAD
 NJNgdlN/0CVBwwXHt8zRddDeiPZn83hmKtxRS4ieKQjR0XURkc1MlfgKv1/B2IZ9Zi+8azuzU1
 yTEcYixuEQhl4jQ1F8n1BfBF/uvT7RAKSkrDDc9oGuuprT5o7yUvPtBAQVZPNrcP4yJZZR4CQW
 72nc1KdsEI2LVePCmj7qAhIdVuEpG6WSXz5A9CX6heB15K4js0Ql1a2YriMeWju+kf4mhq70q3
 rx8=
X-IronPort-AV: E=Sophos;i="5.81,161,1610434800"; 
   d="scan'208";a="43329319"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Feb 2021 04:59:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Feb 2021 04:59:24 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Mon, 8 Feb 2021 04:59:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpWme+dhMYgsp8Fgi3D/yQxydRKb+/5WISkZC+gBOq5q4oqmo9GR5IfHOiN3EUVRom60VqcfrgWNdumSrKXdREYnvhiuWdZgzIO9HtcSP1aMFsp7Vil8vvogfLY1DJGexvwyr0hdTOV88nMixsPbmEjkJFtmFuDWx34agztoM/yyz71YEe5DpcBsX5iVy2JJtqpbYL95Lha+RJIVj2G7F/LTP8uNgCI7rTqu8aVPQ92Ry1W+3pYhFVIiCxy7hO0tjBVBI7cQCV/3GQICq2Of+CwKQtsxhYTPqfAGsze9AbHH6rP1z22EAyO09hLav70bsDxwkN0nP7Q8hpqhhbxqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDrpuNgcXzO1r7l59ezzLmvCA9AdVsvjpVuHXu7qd7U=;
 b=EM/25LQyfMgDCDaNWdEsm6wm/A9R+aMCaoU4kk3qx28WGgoM2AIr3Ya9SixKKmev3eLv/M8ZoElb3pC7LY/aGZEDLJuC4TIVEliTv8ZPJOZTfmsYBcJRioT/nlQfcP8GBaKhPbtDduE7/KhFwQpPDmjRhgUIu+J/7v5Yn+D720wcdQnn3DirxdKumj9QGOchE6wMjHfCquL/JespppOYPLyXQF7kPufsQp5PBTZpYHmZ+LORV7+QJjzE3G/8XExmRDvdBQb3Pfb0VHiIfNRmeeZu2pEv9FN9cjDTInSyX3QBf0KwegSvKMnuhDM1W60ToBaMZmZeL1Pt7w1Vmzo/ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDrpuNgcXzO1r7l59ezzLmvCA9AdVsvjpVuHXu7qd7U=;
 b=i18ikWv79hahJsZ6SOvRj2LTkVP8vmduSlGatQTFX0oDzYYqC36ima67O0XlwJP3n8MOHIHL7WugMYReModqHcrQMmCyPyuBFOzX9/ZXK9FCTWJASu3V6fKIDjkeNPzebUH2JtR+D20+N1J/fGD3it9W25Re/F7QCXTfZfotAGQ=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2622.namprd11.prod.outlook.com (2603:10b6:805:57::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Mon, 8 Feb
 2021 11:59:22 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab%4]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 11:59:22 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <Takahiro.Kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mtd: spi-nor: core: Add dbg msg for
 spi_nor_erase_multi_sectors()
Thread-Topic: [PATCH 2/2] mtd: spi-nor: core: Add dbg msg for
 spi_nor_erase_multi_sectors()
Thread-Index: AQHW/hHVEpKn2JTJa0aWCwOGb8xJSw==
Date:   Mon, 8 Feb 2021 11:59:22 +0000
Message-ID: <b6865143-f52a-c63b-dbe6-bc6de480c74e@microchip.com>
References: <20210205135253.675793-1-tudor.ambarus@microchip.com>
 <20210205135253.675793-2-tudor.ambarus@microchip.com>
 <20210208114125.5bmdvywjcruvhu7a@ti.com>
In-Reply-To: <20210208114125.5bmdvywjcruvhu7a@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e17f2ef9-9e1f-4a6f-ae01-08d8cc28f919
x-ms-traffictypediagnostic: SN6PR11MB2622:
x-microsoft-antispam-prvs: <SN6PR11MB2622CF75D10EBEA802C58C3EF08F9@SN6PR11MB2622.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vrfRq9A9sKQvvTPxCXFcMalWk4tTmbUnChfhynot8X0lfaZRNwYfdzmHCjncLMD/nctby3Z/aj9e4AEzxknh+iii4x0e8rZVORt9dKGnl9gIvFRtbXxEQNEkCWZKNxi65GuhnoRQkirAuQvXQslavzOUjrS1N3CxFjDQQQXuPhahuJpbFT7mglZhJtIocfgjTwkAuxjUe38jfse+NdIJd9L9lOKCwt4zYBcVCw4jC2cnBh51Nouhs/1wxRS10tmMMWS5C4q/8CQdzWMvKfi/8Ut+3r+W35urkn1/Oby+l4F0VMgPRi778XWGZr81fW9ZE7rv0R5Qaho3TcSTQoMx7/VSYK4lck51waIar8gJZvBc7NIefCtS3mVImmHECaLNnvxRYaIhxMDLB8ridNMPo4eapp3LlCqdq678rCaLbLfNA7m7KpMcoGLrekBecX8WSJk55J4MrlOvN2zuwlcPSfDVKCAym3bLd57S2utlR0CcdJq0Cr6wwchwCPHwe2xb3NZL8I/mfXWLHP96GGwAIdowId+CCGoOHcRtvLGTKX+r8fndgjIsBwklcnN+/qLF6jraQ3IZRrjcPGsEQT7FIswtyklCOt5qXEiv1yZcmxU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(396003)(366004)(136003)(64756008)(66446008)(316002)(36756003)(2616005)(8676002)(66946007)(83380400001)(86362001)(91956017)(6512007)(6486002)(66556008)(66476007)(2906002)(6916009)(76116006)(478600001)(4326008)(5660300002)(6506007)(53546011)(31696002)(8936002)(71200400001)(54906003)(26005)(186003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ZUmFCMYtdMlYsB33Wmwwb4WlkipqXaOo9qfALVVgpoBzZzHShBU4S7IOF1dWmi1RTbVjEO4NvdA2U2Fvdt3Jc6F4go7TJJhySzFMIuFZQo+jtAZSk1qijFinPTrrFxO3ycYXBNC4uoBaHdeVKtDLNe4HtZWWqU0qE39E1P3Eg62Qmtgj+aE0HMnDyvx/taXHUdddxFTeJAztYjlvnXErJ8IHLVixyWA9rrEDubJ4KvkBMHYYXtn6zPGoUWAWwvb3Twg2CsQTfE70EsBLNWfWt+8J/REVk4ObsTniS8Dnw7VGPjWRbqwSahwhFvRUH6vUE+H7ddbzUI/+gMKDim1jDVL/fWAJK4HNu483qxu2Fe3QK1G0KtYU1QW96NeGlobOR44hHbqBfmjpTyLNoNbP1Nf76qxpF0TufyHcjvjHWBAiuph91lsWXV/GEBvbFcgCpcBj9IuB8FcdvXelgJOF5bGe7t44Cofzk2ZL7yB+rwyEYah828nKgif0WjGg9k/BkqjnynuvRAuyWYZ2KfALcUpKWFj+IVDwngfSeuNRb4+2c4UHrru/aJ0m9oKh8iLVA+cupdFYldjlmEY7I1H919LGUdOT3ttQeHR5bgSA/KdiNEK+hIGq7wwT/djSb1T72BufamU4oxkeEnC7bX6aNv0HnjiaMwjY2MKit7lUfD1cgRLJp5OorAdaWR6j/YTswuc+5EJfimzjk+kcMVR8Vdyo1zzArHADkdckDkcgBgs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <295DA42BE74BDA45A0B84CADB53BA301@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17f2ef9-9e1f-4a6f-ae01-08d8cc28f919
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 11:59:22.2206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZ9DUsbpBqy7uVCmE3kjO+WIINgJ4NBoV+4RGoKa3E1XktzsDjJKGNa8eOHaGN7oa6u3sfiQxob7+pf82aCLz2q1kmXRgx2FxzC2fwarnSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2622
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi84LzIxIDE6NDEgUE0sIFByYXR5dXNoIFlhZGF2IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDA1LzAyLzIxIDAzOjUyUE0sIFR1ZG9yIEFt
YmFydXMgd3JvdGU6DQo+PiBVc2VmdWwgd2hlbiBkZWJ1Z2dpbmcgbm9uLXVuaWZvcm0gZXJhc2Uu
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNy
b2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgfCAzICsr
Kw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUu
Yw0KPj4gaW5kZXggYmNhYTE2MWJjN2RiLi43NDAxYzYwYjUzZTYgMTAwNjQ0DQo+PiAtLS0gYS9k
cml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9j
b3JlLmMNCj4+IEBAIC0xNjIyLDYgKzE2MjIsOSBAQCBzdGF0aWMgaW50IHNwaV9ub3JfZXJhc2Vf
bXVsdGlfc2VjdG9ycyhzdHJ1Y3Qgc3BpX25vciAqbm9yLCB1NjQgYWRkciwgdTMyIGxlbikNCj4+
ICAgICAgICAgICAgICAgICAgICAgICBpZiAocmV0KQ0KPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZ290byBkZXN0cm95X2VyYXNlX2NtZF9saXN0Ow0KPj4NCj4+ICsgICAgICAgICAg
ICAgICAgICAgICBkZXZfZGJnKG5vci0+ZGV2LCAiZXJhc2VfY21kLT5zaXplID0gMHglMDh4LCBl
cmFzZV9jbWQtPm9wY29kZSA9IDB4JTAyeCwgZXJhc2VfY21kLT5jb3VudCA9ICVkXG4iLA0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY21kLT5zaXplLCBjbWQtPm9wY29kZSwgY21k
LT5jb3VudCk7DQo+PiArDQo+IA0KPiBJIGRvbid0IGxpa2UgdGhlIHBvc2l0aW9uIG9mIHRoaXMg
ZGVidWcgbWVzc2FnZS4gVGhpcyBwcmludHMgY21kLT5jb3VudA0KPiBfYWZ0ZXJfIHRoZSBlcmFz
ZSBpcyBkb25lIGJ1dCBfYmVmb3JlXyBjbWQtPmNvdW50IGlzIHVwZGF0ZWQuIEl0IG1pZ2h0DQoN
Cm9oLCB5ZXMuDQoNCj4gZW5kIHVwIGdpdmluZyBzb21lIHdyb25nIG9yIG1pc2xlYWRpbmcgaW5m
b3JtYXRpb24uIENhbiB5b3UgZWl0aGVyIG1vdmUNCj4gaXQgYmVmb3JlIHRoZSBzdGFydCBvZiB0
aGUgZXJhc2Ugb3IgYWZ0ZXIgYWxsIHRoZSBib29ra2VlcGluZyBpcyBkb25lPw0KDQpCZWZvcmUg
dGhlIHN0YXJ0IG9mIHRoZSBlcmFzZSBzb3VuZHMgZ29vZCwgYnV0IHN0aWxsIGluc2lkZSB0aGUg
d2hpbGUsDQpzbyB0aGF0IHdlIGNhdGNoIGVhY2ggZXhlY3V0ZWQgY29tbWFuZC4gQW5kIG1heWJl
IEknbGwgY2hhbmdlIGRldl9kYmcNCnRvIGRldl92ZGJnLiBJJ2xsIG1hZGUgbXkgbWluZCBiZWZv
cmUgdjIuDQoNCkNoZWVycywNCnRhDQo+IA0KPj4gICAgICAgICAgICAgICAgICAgICAgIGFkZHIg
Kz0gY21kLT5zaXplOw0KPj4gICAgICAgICAgICAgICAgICAgICAgIGNtZC0+Y291bnQtLTsNCj4+
ICAgICAgICAgICAgICAgfQ0KPj4gLS0NCj4+IDIuMjUuMQ0KPiANCj4gLS0NCj4gUmVnYXJkcywN
Cj4gUHJhdHl1c2ggWWFkYXYNCj4gVGV4YXMgSW5zdHJ1bWVudHMgSW5jLg0KPiANCg0K
