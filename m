Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A622042ECBB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhJOItj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:49:39 -0400
Received: from mail-eopbgr60051.outbound.protection.outlook.com ([40.107.6.51]:16768
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229849AbhJOIti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:49:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tb9KxA/6sAcTnZ44XeyU6JhZe3Sw4Ho6FblqFprs1zEy0usdTWxEyojTk5gV0U0ixvJgDYNMZGyqtT4Yw5gr9jTz5xj+cmX5v/NO/oabMM1+Zyi3A+p8Azs/AZhUrsuo5ternietD5xvZBJIhye/jsQqrM0661EWHWPRNOUY2ZTSzYexO1g4DTGq4tF1ku2s3NciGqvW3+Ibnw+fBGXTD1Pf+CeO0L3OU1feUL/E2xmBPFR5745gXQGiv8f2bPGakMQiK9nvoEDbMSvcfRQxclif587lFhtHIOoY6J5HF4wEiYx7fAm51yMtLE7uBlVfXb9jNUr1H9JGD19Yl1h0SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luH7z2MDHaNDlWGGQ6boU13wXTmrqrglc6v51zLUuH0=;
 b=H5seEgpKhav+MKtElMqwC0Tx/FIHDm6msyN5q1V5UMkZRzWiVJwNV1hdZ/uwQ45tSPasOB+rKyUaW730po4yPIf/RBBNsu14Iil2WKpa1iS/ih9JLi4vB04NgCo41HIFfZv9YA4owZPx46C9waV/GZOXTA7u/gUxBcqwu4MhULfhfyBHJRvhpImcgFsEUcDqLmQpWyuIXlpvdc3wUKe9pvSdfDjyNE3Zh6ZPuUjVLp9mvJawXVYETx+GcoqLPMFbbjOw8CJgDrNFSWn34vO/l/UL1JmhpgldXsShEqDCqWPz4r3g305FZDyArcIJ21WG9Gbdq5tObf2wP/9NPgBvew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luH7z2MDHaNDlWGGQ6boU13wXTmrqrglc6v51zLUuH0=;
 b=LApS8X0veGQZx01hMa+eEX5GPc4x+7sGPHZRA6yt4gAo5l+TCK3zuAqaCqw1XL3YWIJQP5vW0HmLhPV4sQUOmnIAIvSliSQuO2zgeMeu7uIVpK7JfRtg4PMAlyb401BiXZ/FLLDrjTPHOfnw6xn1wrxFAi7rpFl8tR3WnmZasco=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB7PR10MB2249.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 15 Oct
 2021 08:47:28 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144%6]) with mapi id 15.20.4587.026; Fri, 15 Oct 2021
 08:47:28 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers: mfd: da9063: Add restart notifier implementation
Thread-Topic: [PATCH] drivers: mfd: da9063: Add restart notifier
 implementation
Thread-Index: AQHXrqpI0LoFC+MHc0+B+6k9QHIUIauzTVswgAAUm4CAB616wIABMx0AgAArEQCABmU8AIAAMeyAgAF704CAAUpnYIAAJDmAgAMFyyCABlaakIADfbkAgAEXzpA=
Date:   Fri, 15 Oct 2021 08:47:27 +0000
Message-ID: <DB9PR10MB46526487C9F2B3C10027039A80B99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20210921053356.1705833-1-alexandre.ghiti@canonical.com>
 <DB9PR10MB465252461469340F60A8714780A49@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCvKaS0sE7paCecMDvqpkw-yLM_QFHdF5pgWTAqeH0JAfA@mail.gmail.com>
 <DB9PR10MB46523AE6EF51D6C801B4A9BF80A99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CAEn-LTqVd8z=kpCtWjiPbKuw24NuHLTQxWzw7g34fEJgDYrp8w@mail.gmail.com>
 <CA+zEjCtQN6c8bikg620PQwoPzJ6T4wGLvzQ413iPs1tCeHif0Q@mail.gmail.com>
 <CA+zEjCtVxDkg8K0iK32j4KO+Wgt+hTjXD15HdRhNeCV2Sjpckw@mail.gmail.com>
 <DB9PR10MB4652294AB444536BF57E320A80AE9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCsf6m8cctHNPBxJczg-J9XC-piAcdtNDO71qmtCtDj9gw@mail.gmail.com>
 <DB9PR10MB465270EA5D6F25C44E68D1E580B09@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCvFO6Tz+D42wgnstx_TLNEt=HM0eeT5g0-zwaEscGj2vQ@mail.gmail.com>
 <DB9PR10MB46521072770D6A1C75DEE08380B29@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <DB9PR10MB46525FC6EAF1610178A20B7580B69@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCsFif-pT6aW-XwYiSuLsSbBTWVxme6S2rdSN0oQETnZiA@mail.gmail.com>
In-Reply-To: <CA+zEjCsFif-pT6aW-XwYiSuLsSbBTWVxme6S2rdSN0oQETnZiA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b1554e2-0c84-48d4-ded7-08d98fb86b00
x-ms-traffictypediagnostic: DB7PR10MB2249:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR10MB2249D58802E76ACDD57BC657A7B99@DB7PR10MB2249.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UMMXqRZzIPalrShyggK+jGaIcJY1pZZO3DwEu7fxa9dNSt1U5t3zryOFNZAAGTMxIxP3Kvx8a9PBlt1KXnlSeXRRVmAXxG/CrOS6wPKRrmH3OU/zno9ORrlcI/IBwzjDFlw3jxqR3Xisb78dN65FNQz2e/pKxRniqQzBRuKJI64ZFs5BsKWPrf9Ew46+z1UOlkWU7SQSJx3e1K2FzkmFRnUvnZPWqY48o5kbstm/139pK2AB0W+urxr96RBlRjSOFZ/T+HM0anjkwkDRAtjbMgeWVOrM1Sz+aLB/YguiKG7CqkEs7NrS5aHCVqzW/QY3HObnVabO42urRhIPYu/BW2BDk7VJrWEHE4JCrNG2rjJNbovrPsFjV4aOiQjHsFwttgq5QL8ocoRrCKNckDL+9SZUbVNBqF05Lguh7VQ3rjelDWm4E1fVTGoITpC37K/dK6jHUO1zrVjtJjBLkYN5gwx3nujNt2G24qyRuLTF0WTP9W+/02NGNw7KLVNaawuXg1L4iK/RFLU+a3LDYRCaxh93cLy4Lc1jQeekRjCuHW06VF8yOu6mWEUC1JcxYESm9au0aaIcxviDYTdTNGhJTgtamNds4/kqd72Mnt9GsB59EeEcGDQ4k0coXJmK4zDjg5eVFiZSS636BjpVDgIepSxY6f97eUB1hETlS2ziUdVVLgcrEH6+ZCymDg1UcDoJlVof6A/SPBtmNK/qXVmRMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(4326008)(6506007)(53546011)(76116006)(55016002)(71200400001)(8936002)(52536014)(55236004)(5660300002)(508600001)(2906002)(316002)(66476007)(66446008)(8676002)(64756008)(66556008)(66946007)(26005)(86362001)(33656002)(54906003)(110136005)(83380400001)(122000001)(38100700002)(7696005)(186003)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGFwR0VtZ1JMSnZUSDhNcEtTRFhpWFlOUFRuY3E1Z0NHT2h6dWZGVFZkYVdD?=
 =?utf-8?B?MEtpN1dKeDVtQVltZE4wRFpOUEMrMzBrbW5JcnlEMlJuMnJtTlVMQ1NVTEVX?=
 =?utf-8?B?MFJQT2tPMGNFOXp1aFJkcmI1VWdyb1V2QklNQVl0N3RTNW9ETmtlU0NyVXU2?=
 =?utf-8?B?VUtwaXBTSkhiT01BYTNkMjlmcXZnOFNOVnpETTA1KzRYei9mSDJ1azFtSlNP?=
 =?utf-8?B?TkwvNmNnSU0rMVJHaWcyVlhmY0Jhbmx4VHUrRjBKQ2pVblY1Szcwc3AwS3hQ?=
 =?utf-8?B?alRYQzZLa2t3bUJvaCtVbHhCRHZnZUh3WHBZNzRpdU5HelVwdUpDazBjaW00?=
 =?utf-8?B?RFhhb2tHTE9OK0FiaUdDT01XTlg5dGZjcDZwVFdGL05wbnlRbmozVjVnbVRY?=
 =?utf-8?B?MitGSzAxeEo0VG1CNEEwZVFyb1VyaVExSmJ0YzJidEtHc1ZNR3A2VmRsU3hW?=
 =?utf-8?B?K1hndUxncW93TGJXUjVNVGtQM1pvTUxnMDBaT0VreGp2L0tsVDlMWEdNbWMy?=
 =?utf-8?B?MnJsWXRRd3MrdityYVIxQW1KOTE1b1NYc0UyNE9ZRk94M3F2VnNBZUtLZEZX?=
 =?utf-8?B?SDFtRjl5Y1doK0tRM0dRcEk1OW9DTmphWVd3dENHRDJjQ3UvVTBNcjJkWm9S?=
 =?utf-8?B?aDF1RWpITDhUWVBOeGZiY2t1YVhHdFNGeHhhb2lHTUFWYVdtRXJrb3F0NVJ1?=
 =?utf-8?B?VjVRZVFVT01yejF3YlgvVlVJTmNZOC9LRFlqSURKNTJiWjYzbTg2R3o2OWU2?=
 =?utf-8?B?ZVJ5SDZOQ0hFU3p1c3ptQ2M1MFBIcTV0eld2NWFwdmV4NFJHRlFDUnJhQlky?=
 =?utf-8?B?ZXUrTFNYSituZVBtQ2J2MFlDbW9yMi9OOURoYlBOalVvZTh0RXFsbEh1WGt0?=
 =?utf-8?B?NStNMnpHdWhzTjBPNEVVMXk0aEJGLzdUU1JvTWV6WGJKekVYekpLdXpZRlBz?=
 =?utf-8?B?VU00QXAzNCtmQkdDT2h0R3ZjQkFyN09JV3JBQnZPWUNGemJMcEpTdWNPZGVu?=
 =?utf-8?B?bkRxOWdMN3pFRzMzQjB1VXJuVVBCVkVaNmhTbFVWK3ZoQU8rQ1JQT2MxYjZ0?=
 =?utf-8?B?WHR2YTIxNVg5aklmTmIzRmF3STFPOUxDNHhpcVRKaTBDVmFHMDVjb1NDeGFt?=
 =?utf-8?B?VDgyaEkyQUVpbGMzMU4wS0txQXNoUTdQdEJQaUVVczFBZHVnRVlPc0h6WDM1?=
 =?utf-8?B?Tklubi91U2VSQUlqZzZ2QTk0SU5VSFNob0tjNmR3SG9Od2VNMWdkNHptRXkv?=
 =?utf-8?B?dDk3NlhwWU9kNU5tVkVOT3JUVm9oanNMbWlRQmhTTnRQdFNrNWhNN2NFUGpw?=
 =?utf-8?B?ODNwaU5tNHVpcmNNSndVYXQ1blV6YzF4TGxUQWRDSDFFL1lhWG1xUmxNdUZX?=
 =?utf-8?B?TFhhNnh4MGk2YW9sc214Y3Z0MGJXaU1QNGhSdm1LTlEvQlJpYlJZTytDdStn?=
 =?utf-8?B?b0R1aHZBYnBlWTdEZkRQQlFPbkZ6NHRYbHJEeUU2ZjhhVkRSRlF3c1NwMHc5?=
 =?utf-8?B?RGJsblNqbkRZVm1DODJZNHVZSllkSElyeG9JdlYxZEgrVDJ0NU5tRXZWYnNh?=
 =?utf-8?B?RnI1RS9mOGZBa3FHRGdUYnhvS0dKQnBlcDZ6OU5DN0hjS2xkZElTaGl6M1Q3?=
 =?utf-8?B?andiMUtGTW45MGxVUlNBSFJXR0JrRXFiRGVUTS81QzVwZFRLbE1CeFhyaDMy?=
 =?utf-8?B?bm9XcVdWdDUrUGJ6UlBNTDM2bXNJM2hJM0RNMHAvU3FxU1MwUzFLVGpBMjFD?=
 =?utf-8?Q?mYWQjWIImnC+9SOrLrRb3DwN8+43YPbDRkBx4/L?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1554e2-0c84-48d4-ded7-08d98fb86b00
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 08:47:27.9956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xiq5gQCn7cUUmhgPue5yEs+9x8Oe1HfuFyj3UsYgID7JKYyGX/FFB8XH2NFxjSxkXL2S82oR3r36j3yq09raxOLIyjNN0LQhGvbHwpORraA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2249
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQgT2N0b2JlciAyMDIxIDE2OjUxLCBBbGV4YW5kcmUgR2hpdGkgd3JvdGU6DQoNCj4gPiBT
byBoYXZpbmcgZXhhbWluZWQgeW91ciBzZXF1ZW5jZSBhZ2FpbiBpdCdzIG5vdyBjbGVhcmVyIGFz
IHRvIHdoYXQgaXMNCj4gaGFwcGVuaW5nLg0KPiA+IFdpdGggdGhlIHNlcXVlbmNlIHlvdSBwcm92
aWRlZCB0aGlzIGlzIG9ubHkgYSBwYXJ0aWFsIHJlc2V0IHdoZXJlYnkgYWxsIG9mIHRoZQ0KPiA+
IG91dHB1dCByYWlscyBhcmUgc2VxdWVuY2VkIGRvd24gdGhlbiB1cCBhZ2FpbiBhbmQgcmVzdG9y
ZWQgdG8gT1RQIHZvbHRhZ2VzLg0KPiA+IEhvd2V2ZXIgdGhlIHJlbWFpbmRlciBvZiB0aGUgY2hp
cCBzZXR0aW5ncyBhcmVuJ3QgcmVzZXQgYXMgdGhpcyBpc24ndCBhIHRydWUNCj4gPiByZXNldCBv
ZiB0aGUgZGV2aWNlIGdvaW5nIHRocm91Z2ggZnVsbCByZWxvYWQgZnJvbSBPVFAsIHNvIGZvciBl
eGFtcGxlIHNldHRpbmdzDQo+ID4gb2YgcmVndWxhdG9yIG1vZGUgR1BJTyBzdGF0ZXMsIG9yIElS
USBtYXNrIGJpdHMgd291bGQgcGVyc2lzdCBvbiB0aGUgcmVzdGFydCwNCj4gPiB3aGljaCBjb3Vs
ZCBoYXZlIGltcGxpY2F0aW9ucyBvbiBzeXN0ZW0gb3BlcmF0aW9uLg0KPiANCj4gT2ssIGl0J3Mg
bm90IHBlcmZlY3QgYnV0IEkgdGhpbmsgdGhvc2UgYXJlIHNldHRpbmdzIHRoYXQgd2lsbCBnZXQN
Cj4gcmVpbml0aWFsaXplZCBieSB0aGUgY29ycmVzcG9uZGluZyBkcml2ZXJzIHdoaWxlIGJvb3Rp
bmcsIGNvbnRyYXJ5IHRvDQo+IHRoZSBSVEMgcmVnaXN0ZXJzIHdoaWNoIGFyZSBjbG9iYmVyZWQg
YnkgdGhlIG90aGVyIG1ldGhvZC4NCg0KV2VsbCBJIGd1ZXNzIHRoYXQgZGVwZW5kcyBvbiB3aGlj
aCBEQTkwNjMgZHJpdmVycyBhcmUgYmVpbmcgbG9hZGVkIGFuZCB3aGF0IGlzDQpwb3B1bGF0ZWQg
aW4gRFQuIFRoaXMgaXMgc29tZXRoaW5nIHlvdSdsbCBuZWVkIHRvIGNvbnNpZGVyIG5vdyBhbmQg
d2l0aCBmdXR1cmUNCnVwZGF0ZXMgYXJvdW5kIHRoaXMgYm9hcmQgdG8gbWFrZSBzdXJlIG5vdGhp
bmcgdW50b3dhcmQgaXMgaGFwcGVuaW5nIGFzIGEgc2lkZQ0KZWZmZWN0Lg0KDQo+IA0KPiA+DQo+
ID4gSW4gYWRkaXRpb24gdGhlIG9ubHkgYml0cyBvZiBpbnRlcmVzdCBmb3IgeW91IHNob3VsZCBi
ZToNCj4gPg0KPiA+ICAtIENPTlRST0xfRiAoMHgxMykNCj4gPiAgICAgICAgIFdBS0VfVVAgKEJJ
VCAyKSA9IDENCj4gPiAgLSBDT05UUk9MX0EgKDB4MEUpDQo+ID4gICAgICAgICBTWVNURU1fRU4g
KEJJVCAwKSA9IDANCj4gPg0KPiA+IFNldHRpbmcgdGhvc2UgdHdvIGJpdHMgc2hvdWxkIGJlIGVu
b3VnaCB0byB0cmlnZ2VyIHRoZSBwYXJ0aWFsIHJlc2V0IHNlcXVlbmNlLg0KPiA+IFRoZSBvdGhl
ciBiaXRzIHlvdSBoYWQgaW4geW91ciBzZXF1ZW5jZSBkb24ndCBzZWVtIHRvIGJlIG5lY2Vzc2Fy
eSBvcg0KPiByZWxldmFudC4NCj4gPg0KPiA+IE9uZSBmaW5hbCBjYXZlYXQgdG8gdGhpcyBhcHBy
b2FjaCBpcyB0aGF0IHRoZXJlIGlzIGEgMTZzIGludGVybmFsIHRpbWVyIChhcyB5b3UNCj4gPiBu
b3RlZCBiZWZvcmUsIFZERF9TVEFSVCkgd2hpY2ggaXMgc3RhcnRlZCB3aGVuIHRoZSBkZXZpY2Ug
bW92ZXMgdG8gQUNUSVZFDQo+IG1vZGUuDQo+ID4gV2hlbiB0aGF0IDE2cyB0aW1lciBleHBpcmVz
IHRoZSBkZXZpY2Ugd2lsbCBjbGVhciB0aGUgV0FLRV9VUCBiaXQNCj4gYXV0b21hdGljYWxseS4N
Cj4gPiBUaGlzIG1lYW5zIHRoZXJlJ3MgdGhlIG91dHNpZGUgY2hhbmNlIHRoYXQgeW91IGNvdWxk
IHRyeSB0aGUgcmVzZXQgY29tbWFuZA0KPiA+IHNlcXVlbmNlIGFib3ZlIGFyb3VuZCB0aGUgc2Ft
ZSB0aW1lLCBhbmQgdGhhdCBjb3VsZCBtZWFuIHlvdSBzZXQgdGhlDQo+IFdBS0VfVVANCj4gPiBi
aXQsIGJ1dCBpdCdzIGltbWVkaWF0ZWx5IGNsZWFyZWQgYWdhaW4gYnkgdGhpcyB0aW1lciBleHBp
cnkgYmVmb3JlIHRoZQ0KPiA+IFNZU1RFTV9FTiBiaXQgaXMgc2V0IGxvdy4gSW4gdGhhdCBjYXNl
IHRoZXJlIHdvdWxkIGJlIGEgbmVlZCBmb3IgYW4gZXh0ZXJuYWwNCj4gPiBldmVudCAoZS5nLiBP
TktFWSkgdG8ga2ljayB0aGUgc3lzdGVtIHRvIHN0YXJ0IGFnYWluLg0KPiANCj4gT2ssIHRoZSBy
aXNrIGV4aXN0cyBidXQgdGhlIHdpbmRvdyBpcyBxdWl0ZSBzbWFsbC4NCj4gDQo+IEFmdGVyIGFs
bCwgdGhlIHNvbHV0aW9uIEkgZmlyc3QgcHJvcG9zZWQgaXMgbm90IHBlcmZlY3QsIGJ1dCBub3cg
d2UNCj4ga25vdyB3aHkgaXQgd29ya3MgYW5kIElNTyBpdCBoYXMgbGVzcyBkcmF3YmFja3MgdGhh
biB1c2luZyB0aGUgUlRDDQo+IHJlZ2lzdGVycywgc28gSSB0aGluayB3ZSBzaG91bGQgZ28gZm9y
IHRoaXMgc29sdXRpb24uIEknbGwgc2VlIGlmIEkNCj4gY2FuIGhlbHAgTmlraXRhIGltcGxlbWVu
dCB0aGlzIGRpcmVjdGx5IGluIG9wZW5TQkkuDQoNClBlcnNvbmFsbHksIGlmIGl0IHdhcyBwb3Nz
aWJsZSBJIHRoaW5rIHRoZSBSVEMgYXBwcm9hY2ggd291bGQgYmUgYmVzdCBhcyBpdCdzIGENCmZ1
bGwgcmVzZXQgYW5kIHRvIG1lIGlzIGZhciBzYWZlciB3aXRoIHJlZ2FyZHMgdG8gcG90ZW50aWFs
IHNpZGUgZWZmZWN0cywgYnV0IGFzDQp0aGF0J3Mgbm90IG9uIHRoZSB0YWJsZSB0aGVuIHRoaXMg
c2VlbXMgdGhlIG9ubHkgb3RoZXIgYXBwcm9hY2ggaW4geW91ciBjYXNlLg0KDQo+IEBBZGFtIFRo
b21zb24gSSBoYWQgbWlncmF0ZWQgdGhlIERBOTA2MyBkZXZpY2UgdHJlZSBiaW5kaW5ncyB0byB5
YW1sLA0KPiBJJ2xsIHB1c2ggdGhhdCBzb29uLiBUaGFua3MgZm9yIGFsbCB5b3VyIGhlbHAsIG11
Y2ggYXBwcmVjaWF0ZWQuDQoNCk5vIHByb2JsZW0gYW5kIHRoYW5rcyBmb3IgbWFraW5nIHRoYXQg
dXBkYXRlLiBJJ2xsIHRha2UgYSBsb29rIHdoZW4gdGhlDQpjaGFuZ2VzIGFyZSBhdmFpbGFibGUu
DQo=
