Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B95402C1D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345483AbhIGPq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:46:59 -0400
Received: from mail-eopbgr120073.outbound.protection.outlook.com ([40.107.12.73]:54784
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345338AbhIGPq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:46:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ch0WvdBqw5Mhjfd1br38lmxq1s4ThISiVSkgA6V8P6RVL3LQzJ5va4A2My9BvP9Ml1cSVbI0kgdJiW1MlGw/lS4xWCsC9D1c7E5A0fAOp2tGAZg7XrGASj3JpPrJjSXGCDzDZhiK6YEkzqkPJPw3Clthvu7y0sV/iWZADxEmmUSXsh38ZHTokV/JAlHuewPFUuIeIp0aT2n1BF9fInxG0o50QPNOPhfBA+/fc/D5rZQdxOEwakoObc/I11D+rkNodCyGRgY7VfnPrLaQS8QmmSQAoYV4csDcFcxJB7DbNk+52zj60+zqQczs3OaB5WdfswNYiLmMhlqkyvhpN6nfwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xb9OKVKhyJq2SRPN0dYNTBhwk0zJ1lhXEETuXHj5Wj8=;
 b=C3yiwTF0VvXR3gOvRuJPp/v35WcAVGzlaGQ+VBa38WfS9rMBjTCytZ+eQLHBhATsVYwI8aFBAxE1H/tRIlxaNapbe6RswmxD6nuqgWdS7shPpCoTN3l6tw3OFUv6/6GINjkXO+BciTHdZzJRk+IqSCkFcoSkItysDylCPTZYRSs3ls5kio4bBCOA3PF6koQKcA4RLYMc8fplW/LtxjZ1v1DdZPREDAeFxPfVjiEk+qXCYrNH+3RNsuBW8SPzaNtcZJT6Y7pkNe/BcjAHJxHq44vPInrHAB6g0VYRnvPX0EpQVxtpIZ5CtNDWvcPt2bxria0bw9L8errOs19OGrcZgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=csgroupeu.onmicrosoft.com; s=selector1-csgroupeu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xb9OKVKhyJq2SRPN0dYNTBhwk0zJ1lhXEETuXHj5Wj8=;
 b=E0PBOkRattQHHoz0O5U17ISScnVK6DfFHZu5clPuqMwpZiZEEUf4Gdr06fFEcJmfukxEj2JVKXtsPHtpB12Yechb0ZIonKNwd04xm20yeFdSrnvz1/jL+qrqUVN/K3qfO9zir3W/3K2RGQOjduraCoavSqzuV9AzhSmR3gqw1OH2VE2ZmEsEW4L7fe/xet5OT4bZqMovkZwBlQpCwYhwZEX/SM5mvPTg0Ah1EClbp4UT3ns4w7EOLbM/DNh8mCvprm91NG39N+ZzNCCgpC9U3nOUv/FIXIl/pRYy8pZpaEjazZ9TiL0U412jlvKAykwd6BSajcciFqgUdKEKH8UYtA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB1911.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:16::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 15:45:48 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a96f:bd29:7b7f:62d3]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a96f:bd29:7b7f:62d3%9]) with mapi id 15.20.4478.026; Tue, 7 Sep 2021
 15:45:48 +0000
From:   LEROY Christophe <christophe.leroy@csgroup.eu>
To:     Paul Moore <paul@paul-moore.com>
CC:     Eric Paris <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>
Subject: RE: [PATCH] audit: Fix build failure by renaming struct node to
 struct audit_node
Thread-Topic: [PATCH] audit: Fix build failure by renaming struct node to
 struct audit_node
Thread-Index: AQHXoOYJu5NjYci2nk+PZvN19Oo7p6uWkpCAgAInV4CAAALM8A==
Date:   Tue, 7 Sep 2021 15:45:47 +0000
Message-ID: <MRZP264MB29885BAAB4F2D486BB33D201EDD39@MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM>
References: <4e2370a9022495c49f3108fe34c5a2b2f4b28dfa.1630684009.git.christophe.leroy@csgroup.eu>
 <CAHC9VhS4Q8U6ZVPoSaVuDawMLS6VOtwZZVNMT1QeFAJUeQHj-Q@mail.gmail.com>
 <2057e2ab-b303-8ec6-9c43-2c2614591925@csgroup.eu>
 <CAHC9VhRV06YHwy5cAAiRvOPUGQ9s1LkOdacMAJVzwykD8B_sgA@mail.gmail.com>
In-Reply-To: <CAHC9VhRV06YHwy5cAAiRvOPUGQ9s1LkOdacMAJVzwykD8B_sgA@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f9bcc058-4ca5-480a-b672-6d2445a83388_ActionId=745651a4-b176-4cee-a2ac-50cadde0b6ec;MSIP_Label_f9bcc058-4ca5-480a-b672-6d2445a83388_ContentBits=0;MSIP_Label_f9bcc058-4ca5-480a-b672-6d2445a83388_Enabled=true;MSIP_Label_f9bcc058-4ca5-480a-b672-6d2445a83388_Method=Standard;MSIP_Label_f9bcc058-4ca5-480a-b672-6d2445a83388_Name=Interne;MSIP_Label_f9bcc058-4ca5-480a-b672-6d2445a83388_SetDate=2021-09-07T15:44:31Z;MSIP_Label_f9bcc058-4ca5-480a-b672-6d2445a83388_SiteId=9914def7-b676-4fda-8815-5d49fb3b45c8;
authentication-results: paul-moore.com; dkim=none (message not signed)
 header.d=none;paul-moore.com; dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f0980c7-b3ee-4134-cc04-08d97216900a
x-ms-traffictypediagnostic: MRZP264MB1911:
x-microsoft-antispam-prvs: <MRZP264MB19115B4B2338D535EC775EC6EDD39@MRZP264MB1911.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qY1OUAaxaQY30KKi2KrfQmjb0DxXS7L9dL9s7uEDtC2d3G2oaeyxoJF6IEGDq5HpzTPK9eI0HJgh++amO8vmxb5DgEDRsR+sdfKZ7/tICF+QA9S4G87O3CB7x6b5HsfnWLpc/+DFvmuxW6E/mdgevn56ssHjHqZTBQ77eTkHep07HT/pB5uRvAtoUdUQoXorxX92qQH6iyEIekGmp714yANlZr/3pj6pWe+xwQexx3q1QB3NfPC4GIuDefWf+57C/gF8wXsyE+XIGlNBy5+oVz5qvEXhkenT4p1/FfQHsGkix7cYSbdg4829zFPvqIaxAdSG6fa5dXQaHnZpqvbg7OO35PPnbWXPVBpOMS0B8lBvk2Iv6A3+2kzaPVtAYCsBl/2jNyZCIrhoZi9jyXDfetzwRmolPf3W1fZ93BxBHQqNqvauCpOZk6PszsHxhv2Bxw/+JLL04WmPct/ZjmRDtp4qTKvWDHdC54UC3Pl3fjxtNORtmmiQZBCYWUSBDipEzK4Xc9AAZ4D8mowACpsTjKK2am0PJQ/S9ReseugEeFyM+sA9Spx+L6gwS4Q7oaYtk8okrAMHhbTO+vVdGNgqsnZpsckTjF0y2jRPgLyXZT47xhgWc53TJkxefoOXtZxOrlpRFCJlq37fOsAjKPTDXk4svaE1tcjXvS0jI4r2Duxnq+YDsBlYt71+FZMby6M2pl8S6LxXWOhqDxhH72gs2y8cSQe5V1NP6ucdOh5EVorOiZjt05OfDxyQlxvYEIKHXhZwoWEzANCoT6D+t6R1IXxz8wCh6ytC+SjZsTfWhFw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(39850400004)(396003)(346002)(38070700005)(86362001)(6506007)(53546011)(66946007)(76116006)(5660300002)(66556008)(186003)(66476007)(54906003)(71200400001)(66446008)(64756008)(55016002)(8936002)(122000001)(7696005)(316002)(38100700002)(33656002)(4326008)(478600001)(9686003)(2906002)(66574015)(6916009)(83380400001)(52536014)(8676002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEFRd0hMTzdBcy8xbloyYy9NdlpaWm9weU8zWndwOGd4T1d1Ung3YU1SWHhr?=
 =?utf-8?B?WTJEdVlTZzJ6NmZKUUQycXFoaXZUKzFJZzVsUVU5ekwrZ2dkeTBGMCtJclRp?=
 =?utf-8?B?TkkvbmE2eU5pbWVJUFIvV2dWTEtGMjkxSzgvNm51MnA3Uk5WSEJVSkR1YkFa?=
 =?utf-8?B?bkhOWVVzcTR0ZUFPTEZyWDJVcVNheUdGb1k1dlo0ZDQyU2xqV2o4b1U1dno0?=
 =?utf-8?B?QmpSajcxRUtyRElzUm1yTUdHTlJmVWl3VGRwUkUyYkR3TlVZa1oxK0MwRlVS?=
 =?utf-8?B?TUM3aEVrMHdGTkdmbWJOWG5CN0p0eEVSa0RnN1Azb3kzeVZkcDNVelorbVNG?=
 =?utf-8?B?bEljcTd2V3FHTmNTYmdaVk5ybGgxa01TU2ZiZEZoZWVpTlZRRG95ZTVScWpC?=
 =?utf-8?B?M3hod2R2UGZLSkh1cDdvaWN6bEtJQkVJUWZZUDZuSmFuOWZ2WTE3dlYwbWZ6?=
 =?utf-8?B?dU54dXBQaE1QNm1WQ0lXSmltWCtLK28xbllWallScnA0U09vUXYveEV5b0g5?=
 =?utf-8?B?b2FoRkphRHI0UmxGc1dudzRpY3BrUVFhTVN6MFVqdTlMaGhZclJZWUlCR0VX?=
 =?utf-8?B?aWdNNmNPYndkR2Ztc3YySzNkQ3hhdVlKYnY1QklwQWYwZzg2VHpwUHp1Z2Fq?=
 =?utf-8?B?Vmd2S1NMVWFlM0pvMWxUaWJ0RzkzOE9zSHBOT3lYYnlKT1VqdkNJUzhSeTVh?=
 =?utf-8?B?ZTlBWU9nM3B0c3hOOWhQeXdkSmNCWnNTQ1phWVhOV2tFUXBSWUpZTXVOdUoy?=
 =?utf-8?B?U1pBVU9hYWpGR3BKc2hRL3JEeEx5TmpHUDlRSlgwSnBlM0dGbEFmd3VPZVli?=
 =?utf-8?B?ZDFZd0ptK2pZd3BoN2xpTkdHTzhJSElUZjFtYlRnVW91VUVnMkFsTWxPMGg1?=
 =?utf-8?B?VnZ0Uk5nWmMxQklhUjM3NkZnSHVQZ2g4Tnp4OE9sVmg4SkczSWp5Ym5jVjR4?=
 =?utf-8?B?czFGRzZLT2ZRbHJYR0hwZmlCRzZ5TFJ0dFNaa0d0R0FQZzZKWDg4QkNJczJI?=
 =?utf-8?B?bEtGbEtnODVwQXlhRlFmSDROSXdsS21mRG8yYmg5Ulo3TXVwVHZMVlFJQU5G?=
 =?utf-8?B?Vm5Gd0o4WnFCd1JVanpSMC8yOHA2TFhpb1A0dTVJUzVjbjZwUWlQSjBNR3pp?=
 =?utf-8?B?S2xhYzRoRWdXUzV4RFlNUllzNXJNSlY4UnRrWU1yb3hCUWVJMTlzTUxGMFBP?=
 =?utf-8?B?K01wenJ2TVZRSG9zTUVpYit4L2R0N1VHQldXL2pFbTg1WDdMTFJvK2NBYTBX?=
 =?utf-8?B?dnpjWWpjM2lPSE1JcS92bHdLZ3JMZEtHeHhxdkc2VFdwOWVlRlNnZFArME43?=
 =?utf-8?B?UmczZmUwbHlDSDZLcndpQ0t2dXhXNWpaaGlJbWtJaENJZmpwUS9LUzNGRWdq?=
 =?utf-8?B?bVZicVluNE0rQkJtSlBRZkNRMmR6WGtaQmRjVmxKV3d1M1NtQWtPUmExUmNx?=
 =?utf-8?B?c292S1VjOXo3MkRLbmE3YTVtKzFvU3VuTy9iM0VKeTg2ZXB0Z3U5UW9HT2Fq?=
 =?utf-8?B?Vk9vb0FSakJwdlc5MEZtMi8vczZFeE9hOVUyWUNHbjZDcktmY1pEWng2N2k0?=
 =?utf-8?B?WitXV0NFZzBtWDFENlNnRUtFOTBhL2E5UEZaMFFON1h1MEVVeWhnc1lqQ2Va?=
 =?utf-8?B?Q2IyckV2M0xBNGx6dWVKMVJCdi9Xa0RjNTgvVXBOMW1xa01tSk9ZODgvVTA0?=
 =?utf-8?B?U0dLTkVQdE1mTjNvR3VxeHUrazhJa3dSRzJySy9NNENOK1JodEJia3BMdys4?=
 =?utf-8?Q?DLKPlSovNECdj17/lE8pxJG9Qo6EbN+T4TiqE62?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0980c7-b3ee-4134-cc04-08d97216900a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 15:45:47.9675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zbu19yHm3iShS4bqlXMDtex8o0vpmDRA2FzvEXl31Myw3AmYCM2u3xUqWkOfFms2WK8qGodcqi5PQCVQ717TKsRlz3tfLdSzxBaMJi1yje8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1911
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1NZXNzYWdlIGQnb3JpZ2luZS0tLS0tDQo+IERlIDogUGF1bCBNb29yZSA8cGF1
bEBwYXVsLW1vb3JlLmNvbT4NCj4gT24gTW9uLCBTZXAgNiwgMjAyMSBhdCAyOjQxIEFNIExFUk9Z
IENocmlzdG9waGUNCj4gPGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldT4gd3JvdGU6DQo+ID4g
TGUgMDMvMDkvMjAyMSDDoCAxOTowNiwgUGF1bCBNb29yZSBhIMOpY3JpdCA6DQo+ID4gPiBPbiBG
cmksIFNlcCAzLCAyMDIxIGF0IDExOjQ4IEFNIENocmlzdG9waGUgTGVyb3kNCj4gPiA+IDxjaHJp
c3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+IHdyb3RlOg0KPiA+ID4+DQo+ID4gPj4gc3RydWN0IG5v
ZGUgZGVmaW5lZCBpbiBrZXJuZWwvYXVkaXRfdHJlZS5jIGNvbmZsaWN0cyB3aXRoIHN0cnVjdA0K
PiA+ID4+IG5vZGUgZGVmaW5lZCBpbiBpbmNsdWRlL2xpbnV4L25vZGUuaA0KPiA+ID4+DQo+ID4g
Pj4gICAgICAgICAgICBDQyAgICAgIGtlcm5lbC9hdWRpdF90cmVlLm8NCj4gPiA+PiAgICAgICAg
ICBrZXJuZWwvYXVkaXRfdHJlZS5jOjMzOjk6IGVycm9yOiByZWRlZmluaXRpb24gb2YgJ3N0cnVj
dCBub2RlJw0KPiA+ID4+ICAgICAgICAgICAgIDMzIHwgIHN0cnVjdCBub2RlIHsNCj4gPiA+PiAg
ICAgICAgICAgICAgICB8ICAgICAgICAgXn5+fg0KPiA+ID4+ICAgICAgICAgIEluIGZpbGUgaW5j
bHVkZWQgZnJvbSAuL2luY2x1ZGUvbGludXgvY3B1Lmg6MTcsDQo+ID4gPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51eC9zdGF0aWNfY2FsbC5oOjEwMiwNCj4g
PiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIGZyb20gLi9hcmNoL3Bvd2VycGMvaW5jbHVk
ZS9hc20vbWFjaGRlcC5oOjEwLA0KPiA+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgZnJv
bSAuL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9hcmNocmFuZG9tLmg6NywNCj4gPiA+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L3JhbmRvbS5oOjEyMSwN
Cj4gPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L25l
dC5oOjE4LA0KPiA+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUv
bGludXgvc2tidWZmLmg6MjYsDQo+ID4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICBmcm9t
IGtlcm5lbC9hdWRpdC5oOjExLA0KPiA+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgZnJv
bSBrZXJuZWwvYXVkaXRfdHJlZS5jOjI6DQo+ID4gPj4gICAgICAgICAgLi9pbmNsdWRlL2xpbnV4
L25vZGUuaDo4NDo4OiBub3RlOiBvcmlnaW5hbGx5IGRlZmluZWQgaGVyZQ0KPiA+ID4+ICAgICAg
ICAgICAgIDg0IHwgc3RydWN0IG5vZGUgew0KPiA+ID4+ICAgICAgICAgICAgICAgIHwgICAgICAg
IF5+fn4NCj4gPiA+PiAgICAgICAgICBtYWtlWzJdOiAqKiogW2tlcm5lbC9hdWRpdF90cmVlLm9d
IEVycm9yIDENCj4gPiA+Pg0KPiA+ID4+IFJlbmFtZSBpdCBhdWRpdF9ub2RlLg0KPiA+ID4+DQo+
ID4gPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBj
c2dyb3VwLmV1Pg0KPiA+ID4+IC0tLQ0KPiA+ID4+ICAga2VybmVsL2F1ZGl0X3RyZWUuYyB8IDIw
ICsrKysrKysrKystLS0tLS0tLS0tDQo+ID4gPj4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gVGhhdCdzIGludGVyZXN0aW5n
LCBJIHdvbmRlciB3aHkgd2UgZGlkbid0IHNlZSB0aGlzIHByaW9yPyAgQWxzbyBhcw0KPiA+ID4g
YW4gYXNpZGUsIHRoZXJlIGFyZSBldmlkZW50bHkgYSBnb29kIGhhbmRmdWwgb2Ygc3ltYm9scyBu
YW1lZA0KPiA+ID4gIm5vZGUiLiAgSW4gZmFjdCBJIGRvbid0IHNlZSB0aGlzIG5vdyBpbiB0aGUg
YXVkaXQvc3RhYmxlLTUuMTUgb3INCj4gPiA+IExpbnVzJyB0cmVlIGFzIG9mIGEgcmlnaHQgbm93
LCBib3RoIHVzaW5nIGFuIGFsbHllc2NvbmZpZzoNCj4gPiA+DQo+ID4gPiAlIGdpdCBzaG93LXJl
ZiBIRUFEDQo+ID4gPiBhOWM5YTZmNzQxY2RhYTJmYTliYTI0YTc5MGRiOGQwNzI5NTc2MWUzIHJl
ZnMvcmVtb3Rlcy9saW51cy9IRUFEICUNCj4gPiA+IHRvdWNoIGtlcm5lbC9hdWRpdF90cmVlLmMg
JSBtYWtlIEM9MSBrZXJuZWwvDQo+ID4gPiAgIENBTEwgICAgc2NyaXB0cy9jaGVja3N5c2NhbGxz
LnNoDQo+ID4gPiAgIENBTEwgICAgc2NyaXB0cy9hdG9taWMvY2hlY2stYXRvbWljcy5zaA0KPiA+
ID4gICBERVNDRU5EIG9ianRvb2wNCj4gPiA+ICAgQ0hLICAgICBrZXJuZWwva2hlYWRlcnNfZGF0
YS50YXIueHoNCj4gPiA+ICAgQ0MgICAgICBrZXJuZWwvYXVkaXRfdHJlZS5vDQo+ID4gPiAgIENI
RUNLICAga2VybmVsL2F1ZGl0X3RyZWUuYw0KPiA+ID4gICBBUiAgICAgIGtlcm5lbC9idWlsdC1p
bi5hDQo+ID4gPg0KPiA+ID4gV2hhdCB0cmVlIGFuZCBjb25maWcgYXJlIHlvdSB1c2luZyB3aGVy
ZSB5b3Ugc2VlIHRoaXMgZXJyb3I/DQo+ID4gPiBMb29raW5nIGF0IHlvdXIgZXJyb3IsIEknbSBn
dWVzc2luZyB0aGlzIGlzIGxpbWl0ZWQgdG8gcHBjIGJ1aWxkcywNCj4gPiA+IGFuZCBpZiBJIGxv
b2sgYXQgdGhlIGFyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9tYWNoZGVwLmggZmlsZSBpbg0KPiA+
ID4gTGludXMgdHJlZSBJIGRvbid0IHNlZSBhIHN0YXRpY19jYWxsLmggaW5jbHVkZSBzbyBJJ20g
Z3Vlc3NpbmcgdGhpcw0KPiA+ID4gaXMgYSAtbmV4dCB0cmVlIGZvciBwcGM/ICBTb21ldGhpbmcg
ZWxzZT8NCj4gPiA+DQo+ID4gPiBXaXRob3V0IGtub3dpbmcgdGhlIGNvbnRleHQsIGlzIGFkZGlu
ZyB0aGUgc3RhdGljX2NhbGwuaCBpbmNsdWRlIGluDQo+ID4gPiBhcmNoL3Bvd2VycGMvaW5jbHVk
ZS9hc20vbWFjaGRlcC5oIGludGVudGlvbmFsIG9yIHNpbXBseSBhIGJpdCBvZg0KPiA+ID4gaW5j
bHVkZSBmaWxlIGNyZWVwPw0KPiA+DQo+ID4gc3RydWN0IG1hY2hkZXBfY2FsbHMgaW4gYXNtL21h
Y2hkZXAuaCBpcyBmdWxsIG9mIGZ1bmN0aW9uIHBvaW50ZXJzIGFuZA0KPiA+IEknbSB3b3JraW5n
IG9uIGNvbnZlcnRpbmcgdGhhdCB0byBzdGF0aWNfY2FsbHMNCj4gPiAoaHR0cHM6Ly9wYXRjaHdv
cmsub3psYWJzLm9yZy9wcm9qZWN0L2xpbnV4cHBjLWRldi9saXN0Lz9zZXJpZXM9MjYwODc4DQo+
ID4gJnN0YXRlPSopDQo+ID4NCj4gPiBTbyB5ZXMsIGFkZGluZyBzdGF0aWNfY2FsbC5oIGluIGFz
bS9tYWNoZGVwLmggaXMgaW50ZW50aW9uYWwgYW5kIHRoZQ0KPiA+IGlzc3VlIHdhcyBkZXRlY3Rl
ZCBieSBDSSBidWlsZCB0ZXN0DQo+ID4gKGh0dHA6Ly9raXNza2IuZWxsZXJtYW4uaWQuYXUva2lz
c2tiL2J1aWxkcmVzdWx0LzE0NjI4MTAwLykNCj4gPg0KPiA+IEkgc3VibWl0dGVkIHRoaXMgY2hh
bmdlIHRvIHlvdSBiZWNhdXNlIGZvciBtZSBpdCBtYWtlIHNlbnNlIHRvIG5vdA0KPiA+IHJlLXVz
ZSBnbG9iYWJseSBkZWZpbmVkIHN0cnVjdCBuYW1lcyBpbiBsb2NhbCBDIGZpbGVzLCBhbmQgYW55
Ym9keSBtYXkNCj4gPiBlbmNvdW50ZXIgdGhlIHByb2JsZW0gYXMgc29vbiBhcyBsaW51eC9ub2Rl
LmggZ2V0cyBpbmNsdWRlZCBkaXJlY3RseQ0KPiA+IG9yIGluZGlyZWN0bHkuIEJ1dCBpZiB5b3Ug
cHJlZmVyIEkgZ3Vlc3MgdGhlIGZpeCBtYXkgYmUgbWVyZ2VkIHRocm91Z2gNCj4gPiBwb3dlcnBj
IHRyZWUgYXMgcGFydCBvZiB0aGlzIHNlcmllcy4NCj4NCj4gWWVzLCB0aGlzIHBhdGNoIHNob3Vs
ZCBnbyBpbiB2aWEgdGhlIGF1ZGl0IHRyZWUsIGFuZCB3aGlsZSBJIGRvbid0IGhhdmUgYW4NCj4g
b2JqZWN0aW9uIHRvIHRoZSBwYXRjaCwgd2hlbmV2ZXIgSSBzZWUgYSBwYXRjaCB0byBmaXggYW4g
aXNzdWUgdGhhdCBpcyBub3QgdmlzaWJsZSBpbg0KPiBMaW51cycgdHJlZSBvciB0aGUgYXVkaXQg
dHJlZSBpdCByYWlzZXMgc29tZSBxdWVzdGlvbnMuICBJIHVzdWFsbHkgaG9wZSB0byBzZWUgdGhv
c2UNCj4gcXVlc3Rpb25zIGFuc3dlcmVkIHByb2FjdGl2ZWx5IGluIHRoZSBjb3ZlciBsZXR0ZXIg
YW5kL29yIHBhdGNoIGRlc2NyaXB0aW9uIGJ1dA0KPiB0aGF0IHdhc24ndCB0aGUgY2FzZSBoZXJl
IHNvIHlvdSBnZXQgdG8gcGxheSBhIGdhbWUgb2YgMjAgcXVlc3Rpb25zLg0KPg0KPiBTcGVha2lu
ZyBvZiB3aGljaCwgSSBkb24ndCByZWNhbGwgc2VlaW5nIGFuIGFuc3dlciB0byB0aGUgIndoZXJl
IGRvIHRoZXNlDQo+IGluY2x1ZGUgZmlsZSBjaGFuZ2VzIGxpdmU/IiBxdWVzdGlvbiwgaXMgaXMg
dGhlIHBwYyAtbmV4dCB0cmVlLCBvciBhcmUgdGhleSBzdGlsbA0KPiB1bm1lcmdlZCBhbmQganVz
dCBvbiB0aGUgcHBjIGxpc3Q/DQo+DQoNCkl0IGlzIHN0aWxsIGFuIFJGQyBpbiB0aGUgcHBjIGxp
c3QuDQoNClRoYW5rcw0KQ2hyaXN0b3BoZQ0KDQpDUyBHcm91cCAtIERvY3VtZW50IEludGVybmUN
Cg==
