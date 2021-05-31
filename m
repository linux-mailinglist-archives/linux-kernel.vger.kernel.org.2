Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C853956F4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhEaIaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:30:21 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:55502 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhEaIaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1622449710; x=1653985710;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oo+Fzvn3zsOSKk65xvAlXacjN7hnja9sFNksg4BBisU=;
  b=X1HJb/cunAOZh7r0GFjqWY8068thPAcwzy4dtH7l87nCjEKQNMrVqevu
   DZ5f0hRvRweLiO7nCwqw9drb32eiVfLUQdNKzyTfPyeSRW4QmLu45oUj6
   Cmp4bY1a8C3sP16i4RvfDhpxmaAhJl2uQO8q7dwavXNbEaBQTZnh7crHz
   iBrcHFyKvOpcB6u4HfdAtOHuFjKz7u7VzbGtmmlb01+2dW+rc7IMYvEig
   5wzrdjnETonU2Ayp1RksRHFNGDkCWlJ22gkDbmK+sFVviTphQdlw4w9H/
   PErVht6QRXeX/rhTMw92bTNOvVrVUHa0sTXphiGq+AzXAa/pDec1X0eCE
   A==;
IronPort-SDR: BOTLDpGJTGoMmR4VQNwRbk05Yh499GYdiuhd16nBK1zF7mfpJnMJUaI3U2wMhoYA5sK4em6jFF
 gyjR81mpwgO50pzLRLd8kd9J+fxp5aHk5tVfmFQlojonwLMgxVkg3YfsHFlhKECztKUZO0j7Vg
 nLKimR+tUfoezCUXRbXeHBcEFh7xkXvSOT6IU5m8xsae9TKarqvLwqIRbYRpmwCyUsOWtflAAe
 Sdem0K/MUz32dSbcmgEsXS15wWCFQyTssvLRnwlbJu+EjXxyDf9aetRiAZ2R2aMPN8YAz0GHlg
 8MU=
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="117126061"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 May 2021 01:28:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 01:28:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Mon, 31 May 2021 01:28:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awP/ex4V+w1jS+XMKSMCQM0Bykd/u4VzoYiQZceWQATEs2bb1f97l4rNUotjNPZY23RVYBnv8MO51usa4KbPhtYW7DhTYKbveFaONMUH9DXbV0yAz9yKDeJc8ebqmupytZg1adKYMuERHGE1t+IcETKJPYxgoxmrkPJewCbqEOSzUqDkI5rGZ0PkZUaFSgqgEkFbeYYeCseL32U+7pUbDeHHB2vW101AR1oCnwnD3Xfarpj7FnmWfVEEysozEP/gSA52oZYZiyZLy+VX0tmjCR45S9p9RO54pOWwOCZakzhV0lDDnXLDDxcHdWtuPbUUz9EdzQLKrGdtqlGRS6xzeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oo+Fzvn3zsOSKk65xvAlXacjN7hnja9sFNksg4BBisU=;
 b=BwTB47ZvilXure11XFAPiUoN02A0ktoRy6TxN2Tk0sevpmuWFtJxSEl1xYkPTTRgoFI+J1HruZQq3hIAskGSB1eXVhPkeutDS2DNRZWRnWvL7RIQYnNiWAMGWjIfCPQ2uSifFTyzo54gxuJxslqxCvJqKUCS7G18a9LTL9by3Vz+tuSS/CXyorzyrmDGWHINtCrUbkxZuVImBQviVi3OEvD4rYYgHpOajE2cYnr3kP4ioXT98T2FF8QOjDtnjaqrxIFlp4Ys+8Efd32yrmrzMH2Ysa9eRE19sC6lspb7GHvbNKLN8RACuiR1xw16WI1BrLEYT5u1XbJpFJpL+ECa2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oo+Fzvn3zsOSKk65xvAlXacjN7hnja9sFNksg4BBisU=;
 b=AUw8U6akkzcPNWlOOJ8eWAF5AzgQ8kanermTdWCO/cGs5BQ1oI893QtFvFUi8Qe41ktLPf6IeQ3E0HosJoMq+oEOk5J53pkLYMyKWVEfxpA9Q8zniivQcSU5T+i6tU65tdh65II4RkOEjqBrBbif5RqiECvXs95qHpbZ8oINCDE=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MW3PR11MB4571.namprd11.prod.outlook.com (2603:10b6:303:59::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Mon, 31 May
 2021 08:28:28 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1c4:1014:a541:e370]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1c4:1014:a541:e370%4]) with mapi id 15.20.4173.029; Mon, 31 May 2021
 08:28:28 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v4 2/4] mtd: spi-nor: otp: use more consistent wording
Thread-Topic: [PATCH v4 2/4] mtd: spi-nor: otp: use more consistent wording
Thread-Index: AQHXVfbuVF+lruj2ikatKaizLiU5LQ==
Date:   Mon, 31 May 2021 08:28:28 +0000
Message-ID: <8ed3996d-78a5-a27f-978b-635b140ccee6@microchip.com>
References: <20210521194034.15249-1-michael@walle.cc>
 <20210521194034.15249-3-michael@walle.cc>
In-Reply-To: <20210521194034.15249-3-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e95bddd8-0aad-44c3-5fac-08d9240e10f3
x-ms-traffictypediagnostic: MW3PR11MB4571:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4571AC899DE91CA8101A9CA8F03F9@MW3PR11MB4571.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JZd1XXtdiE38ESJvapN4kvTndbKZrjOrNulUd8nsNmDDyXPIljT807oquh0tGshCjPq2kilF4vgoefYeSss+b0/GXz6QRu9xZP6fp7iG1rcb3mDoBgEq8KyKykzbE6amrmM8WzGpWLuVFSDV4Ov1XPA7kfbaLxdpJVaT+piqGTEK3V2og/qkqD8AQemUymebTzaydJEeUbUijXIfRk9s0418as92TBfnL0xjmgA+QEKD/Y+EKHd7M9b6XvYird76b9QGzmyoD4IDjjLZWOqHCFh9lA5kPEgOrUSzpdW5tOEOAZfX47y/RBx+Pbvvu9PvYW/5Ztu5+inuvfpLDDM12c0BwUfqBemda5xI4sxF6OPVGq5tVTXPi1XcYDCan+NGh7JbJTDu9MnVvsYVqv0ARrAi2C0VyTqo5sUz2Vzly84bgVmFUmbiuOyOQssmh3zOsgGP8NgzmZ7y88etrQunv9KaMDdzwmhv8T7Urp2SeehC633ZthG+Eg/gmRmkruLRKHgZ4G2FzJfQdMlC0epXEaBQcshueWycgrCfvpdEQqoHLalPwg6O73GEhRG4y219gSOeIg+E7qxAAKlZqT/2AMVnxc5ThQTirYdPsopMNrIZK1fFkoLDip3jMPYWBudHVjzcyhJlwTkOA9DOhwKFHU0lBxU50nBwF5YGxXMzpkZv3O2fThuZ8A0mWoZWGwMr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(366004)(136003)(39860400002)(2906002)(6506007)(6486002)(478600001)(316002)(38100700002)(83380400001)(71200400001)(110136005)(54906003)(122000001)(26005)(86362001)(36756003)(53546011)(186003)(8676002)(5660300002)(64756008)(66446008)(66476007)(66556008)(66946007)(8936002)(4326008)(31686004)(2616005)(91956017)(6512007)(76116006)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?M01STFVySkpvUU5sT3V2YVBvaXNlaVN1cWlYejVkYmRaMWY2L2xaTUtKdkJu?=
 =?utf-8?B?YVM1Nk5nc1loRjhOcjlLaERmS2cyZjNNQkszcDUxVkVnbzdMZlNlSngyWVln?=
 =?utf-8?B?VVphVjFmZGFXdzV0dGRxbC9udFh2aEFKZlZUc0FPRHBUank3Q2k1U1g1UHJi?=
 =?utf-8?B?bVhHTWZuNE16RncyaHZxOEZ5OFdZSzJ3bDJJKy9wUUprOHlCWmgzUVN3cStv?=
 =?utf-8?B?WFRibGI4VDhud2t3VjJ0TWNkOFZVKzhxOWUyVWMxb1dLMnFJREdXbUkybnFB?=
 =?utf-8?B?L09UTUoycVdDZ0FLZHJqMHBxMkJuUnBSRUNoWFcrYUtndWdHdFRJT0d2OFFJ?=
 =?utf-8?B?R01JZm9MckM5ZVEyYjBTa2hlNTkzK0lVK2NFNTNhOVdzUjV1SkJPRkpEdk0y?=
 =?utf-8?B?a3BwaFpqaUxrTW00MVFnMzhrYmJGNlpyQ0N0K1FCcjZlcGJQYmN3NnVkYUVx?=
 =?utf-8?B?SjZRQzRKT3YzNDdPUitBK3JFY0YxMEs5bHpXZWg0aFFkbmlLQWFmQzhtWUx1?=
 =?utf-8?B?aU9nZU1qYkdGNEZNR0IzZTdLZ3loeDI4dHZQTEdqeGEyaGtFT0NCSzk5K3hI?=
 =?utf-8?B?OGZUamVldlBENHUzd2VSekY2QlVNZXVmQTlTbjlESmNVTFpPekRIOEl0N0tp?=
 =?utf-8?B?RDlIUnVpcmpwM2NGQ082a092U0x2emd4V3ZYYWJGZ0dYdHY3b0Q4d1V3UU5v?=
 =?utf-8?B?aTFUczlCVmJ2V2xMa244anA2eUM5SVlLWk43YWxWb2xoUzBlSE0yVlk4UjJE?=
 =?utf-8?B?a2lGS2xjclN2UDRyM0sxVy91NTlxRzVLbFJwQ240WjlDc0dGQ3lubGJ3aTZ5?=
 =?utf-8?B?OExpanZsMkpoSnFwOGxWNXJEWXRza0VDbE5mallpYWRKV1RUVXI4T3hMYTVG?=
 =?utf-8?B?eE1TRnVRV283Ynk1TEFKSmVOc1VNWU5QUk15SitzQ2VFYnM1aWVkKzhOQnFq?=
 =?utf-8?B?OTROMFlmWWw4aFFEZnFPMmIxSTE2bGE4aWdMMTMxOUpycmhpb0k3UG02OVFs?=
 =?utf-8?B?RDdxVGNXVlNLWll1M2RxVGJwVm0zQTZ5MzhNS2FML3dGeUx5SkljdzRLVHRY?=
 =?utf-8?B?aVNiRHdpMjhFaUhjL3VvVzBpbmszVldXSE03bHZZTTBtUUJwK3d6RGJjZC9K?=
 =?utf-8?B?L0lSYnNDTldtYkYzQUxtRGEvRDZ6R3pON0tQZXJma2ZGWnU3QnBwdWdONk5M?=
 =?utf-8?B?bHNiSVlTL29wUytoNCtvRGhmZHNEdXNMTnArazFUVmRJbEVxL1ZVTWtXdk9W?=
 =?utf-8?B?SzhJZWEvOEliTFBRTkJzT1lPalRuNDN2TjlnWXd1NDNwNXg3S1E5aWFPMGxn?=
 =?utf-8?B?d2lGaFdZd3RnNWVRMnVWbE9pOFhxWG4wSEd5ZnluNmc2eWdHZFc4WXJHRVRO?=
 =?utf-8?B?Y0pDVDF5bEhlQVF2a09YdTlteUNWcUdpanZ0VlZhc2dhRW1CMEtmaHllK2ZQ?=
 =?utf-8?B?RkhMMUVXK3NvOXc5S3dPVHRRQ2MybHhZalNXc21MNWlJRVZSSE03dExUNDBC?=
 =?utf-8?B?VnIxNU9STzdMekVJK3lMelExYklJeWF1UXlEUHR4c1JUMGFvSFk4N1dNUTFj?=
 =?utf-8?B?dWRFTm1zSTB4VzI0MTh0Q3VTTVNJQjdoQ3lHc0RKZlpteGx5bmV3dUdXUmF6?=
 =?utf-8?B?SWx3dEZSeXdPMHQ0VmJOaERmbWRpQjBOWmxsM3JIWFhOUWZRcjV6SnRyK1J6?=
 =?utf-8?B?S2pXbytkcTQ3cGpVd2NBS2l3UXJVMDhMZUc5NkY2WVN1SkdxZm5lVHVJeGpN?=
 =?utf-8?Q?2pFdgrYom9HB+VZ/g8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC182E34E343614E9DC3096F2C607254@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95bddd8-0aad-44c3-5fac-08d9240e10f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 08:28:28.0888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bifZeeGzpQsAaC7c46i+a/J8WCU2wuQY+BtJssbEXswgE5N2bPFVAGZBj3BuE7/3ljyso6ar8JD6U7Io4Ukjw7tsK0MEpcJeH32gi+erob4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4571
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yMS8yMSAxMDo0MCBQTSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBVc2UgdGhlIHdvcmRpbmcgYXMgdXNlZCBpbiB0
aGUgZGF0YXNoZWV0IHRvIGRlc2NyaWJlIHRoZSBhY2Nlc3MgbWV0aG9kcw0KPiBvZiB0aGUgc2Vj
dXJpdHkgcmVnaXN0ZXJzIChha2EgT1RQIHN0b3JhZ2UpLiBUaGlzIHdpbGwgYWxzbyBtYXRjaCB0
aGUNCj4gZnVuY3Rpb24gbmFtZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFdhbGxl
IDxtaWNoYWVsQHdhbGxlLmNjPg0KPiBSZXZpZXdlZC1ieTogUHJhdHl1c2ggWWFkYXYgPHAueWFk
YXZAdGkuY29tPg0KDQpSZXZpZXdlZC1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0Bt
aWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9vdHAuYyB8IDI3
ICsrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2Vy
dGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQv
c3BpLW5vci9vdHAuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivb3RwLmMNCj4gaW5kZXggOTFhNGM1
MTBlZDUxLi4zODk4ZWQ2N2JhMWMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
b3RwLmMNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9vdHAuYw0KPiBAQCAtMTUsMTQgKzE1
LDIxIEBADQo+ICAjZGVmaW5lIHNwaV9ub3Jfb3RwX25fcmVnaW9ucyhub3IpICgobm9yKS0+cGFy
YW1zLT5vdHAub3JnLT5uX3JlZ2lvbnMpDQo+IA0KPiAgLyoqDQo+IC0gKiBzcGlfbm9yX290cF9y
ZWFkX3NlY3IoKSAtIHJlYWQgT1RQIGRhdGENCj4gKyAqIHNwaV9ub3Jfb3RwX3JlYWRfc2Vjcigp
IC0gcmVhZCBzZWN1cml0eSByZWdpc3Rlcg0KPiAgICogQG5vcjogICAgICAgcG9pbnRlciB0byAn
c3RydWN0IHNwaV9ub3InDQo+ICAgKiBAYWRkcjogICAgICAgb2Zmc2V0IHRvIHJlYWQgZnJvbQ0K
PiAgICogQGxlbjogICAgICAgIG51bWJlciBvZiBieXRlcyB0byByZWFkDQo+ICAgKiBAYnVmOiAg
ICAgICAgcG9pbnRlciB0byBkc3QgYnVmZmVyDQo+ICAgKg0KPiAtICogUmVhZCBPVFAgZGF0YSBm
cm9tIG9uZSByZWdpb24gYnkgdXNpbmcgdGhlIFNQSU5PUl9PUF9SU0VDUiBjb21tYW5kcy4gVGhp
cw0KPiAtICogbWV0aG9kIGlzIHVzZWQgb24gR2lnYURldmljZSBhbmQgV2luYm9uZCBmbGFzaGVz
Lg0KPiArICogUmVhZCBhIHNlY3VyaXR5IHJlZ2lzdGVyIGJ5IHVzaW5nIHRoZSBTUElOT1JfT1Bf
UlNFQ1IgY29tbWFuZHMuDQo+ICsgKg0KPiArICogSW4gV2luYm9uZC9HaWdhRGV2aWNlIGRhdGFz
aGVldHMgdGhlIHRlcm0gInNlY3VyaXR5IHJlZ2lzdGVyIiBzdGFuZHMgZm9yDQo+ICsgKiBhbiBv
bmUtdGltZS1wcm9ncmFtbWFibGUgbWVtb3J5IGFyZWEsIGNvbnNpc3Rpbmcgb2YgbXVsdGlwbGUg
Ynl0ZXMgKHVzdWFsbHkNCj4gKyAqIDI1NikuIFRodXMgb25lICJzZWN1cml0eSByZWdpc3RlciIg
bWFwcyB0byBvbmUgT1RQIHJlZ2lvbi4NCj4gKyAqDQo+ICsgKiBUaGlzIG1ldGhvZCBpcyB1c2Vk
IG9uIEdpZ2FEZXZpY2UgYW5kIFdpbmJvbmQgZmxhc2hlcy4NCj4gKyAqDQo+ICsgKiBQbGVhc2Ug
bm90ZSwgdGhlIHJlYWQgbXVzdCBub3Qgc3BhbiBtdWx0aXBsZSByZWdpc3RlcnMuDQo+ICAgKg0K
PiAgICogUmV0dXJuOiBudW1iZXIgb2YgYnl0ZXMgcmVhZCBzdWNjZXNzZnVsbHksIC1lcnJubyBv
dGhlcndpc2UNCj4gICAqLw0KPiBAQCAtNTYsMTYgKzYzLDIwIEBAIGludCBzcGlfbm9yX290cF9y
ZWFkX3NlY3Ioc3RydWN0IHNwaV9ub3IgKm5vciwgbG9mZl90IGFkZHIsIHNpemVfdCBsZW4sIHU4
ICpidWYpDQo+ICB9DQo+IA0KPiAgLyoqDQo+IC0gKiBzcGlfbm9yX290cF93cml0ZV9zZWNyKCkg
LSB3cml0ZSBPVFAgZGF0YQ0KPiArICogc3BpX25vcl9vdHBfd3JpdGVfc2VjcigpIC0gd3JpdGUg
c2VjdXJpdHkgcmVnaXN0ZXINCj4gICAqIEBub3I6ICAgICAgICBwb2ludGVyIHRvICdzdHJ1Y3Qg
c3BpX25vcicNCj4gICAqIEBhZGRyOiAgICAgICBvZmZzZXQgdG8gd3JpdGUgdG8NCj4gICAqIEBs
ZW46ICAgICAgICBudW1iZXIgb2YgYnl0ZXMgdG8gd3JpdGUNCj4gICAqIEBidWY6ICAgICAgICBw
b2ludGVyIHRvIHNyYyBidWZmZXINCj4gICAqDQo+IC0gKiBXcml0ZSBPVFAgZGF0YSB0byBvbmUg
cmVnaW9uIGJ5IHVzaW5nIHRoZSBTUElOT1JfT1BfUFNFQ1IgY29tbWFuZHMuIFRoaXMNCj4gLSAq
IG1ldGhvZCBpcyB1c2VkIG9uIEdpZ2FEZXZpY2UgYW5kIFdpbmJvbmQgZmxhc2hlcy4NCj4gKyAq
IFdyaXRlIGEgc2VjdXJpdHkgcmVnaXN0ZXIgYnkgdXNpbmcgdGhlIFNQSU5PUl9PUF9QU0VDUiBj
b21tYW5kcy4NCj4gKyAqDQo+ICsgKiBGb3IgbW9yZSBpbmZvcm1hdGlvbiBvbiB0aGUgdGVybSAi
c2VjdXJpdHkgcmVnaXN0ZXIiLCBzZWUgdGhlIGRvY3VtZW50YXRpb24NCj4gKyAqIG9mIHNwaV9u
b3Jfb3RwX3JlYWRfc2VjcigpLg0KPiArICoNCj4gKyAqIFRoaXMgbWV0aG9kIGlzIHVzZWQgb24g
R2lnYURldmljZSBhbmQgV2luYm9uZCBmbGFzaGVzLg0KPiAgICoNCj4gLSAqIFBsZWFzZSBub3Rl
LCB0aGUgd3JpdGUgbXVzdCBub3Qgc3BhbiBtdWx0aXBsZSBPVFAgcmVnaW9ucy4NCj4gKyAqIFBs
ZWFzZSBub3RlLCB0aGUgd3JpdGUgbXVzdCBub3Qgc3BhbiBtdWx0aXBsZSByZWdpc3RlcnMuDQo+
ICAgKg0KPiAgICogUmV0dXJuOiBudW1iZXIgb2YgYnl0ZXMgd3JpdHRlbiBzdWNjZXNzZnVsbHks
IC1lcnJubyBvdGhlcndpc2UNCj4gICAqLw0KPiBAQCAtODgsNyArOTksNyBAQCBpbnQgc3BpX25v
cl9vdHBfd3JpdGVfc2VjcihzdHJ1Y3Qgc3BpX25vciAqbm9yLCBsb2ZmX3QgYWRkciwgc2l6ZV90
IGxlbiwNCj4gDQo+ICAgICAgICAgLyoNCj4gICAgICAgICAgKiBXZSBvbmx5IHN1cHBvcnQgYSB3
cml0ZSB0byBvbmUgc2luZ2xlIHBhZ2UuIEZvciBub3cgYWxsIHdpbmJvbmQNCj4gLSAgICAgICAg
KiBmbGFzaGVzIG9ubHkgaGF2ZSBvbmUgcGFnZSBwZXIgT1RQIHJlZ2lvbi4NCj4gKyAgICAgICAg
KiBmbGFzaGVzIG9ubHkgaGF2ZSBvbmUgcGFnZSBwZXIgc2VjdXJpdHkgcmVnaXN0ZXIuDQo+ICAg
ICAgICAgICovDQo+ICAgICAgICAgcmV0ID0gc3BpX25vcl93cml0ZV9lbmFibGUobm9yKTsNCj4g
ICAgICAgICBpZiAocmV0KQ0KPiAtLQ0KPiAyLjIwLjENCj4gDQoNCg==
