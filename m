Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A8B440920
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 15:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhJ3NXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 09:23:13 -0400
Received: from mail-eopbgr1410095.outbound.protection.outlook.com ([40.107.141.95]:10752
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229640AbhJ3NXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 09:23:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPiqvxEe6EDGsev0KhpyybAgHojRSPPouLmZwE7TBsNqtipGw4C51YvE1b9CdgeXnipdV0ScJudrb1Dpg6PTPIGGmLesbAyoXKvJHzBHjjWPlRC6YGYuMAjw7YyKCERWcF8aZnm19q+QFaxCWf6gVfx3dqTuH2fV8lBw1vfjsDlDWncSPRjRTY48Zqstpq93x8t5xO3GmRSTE5L30LX8hrLeG/6TqiXudVaWD5JSY3gBMZcmHm2GEFEmU0iWtZlztbTnUCIo+xl0+X0jE+XdZWgFonY4ve8+vESKC6yB185oWOa6+C3VGwyULYxOdN8CCO06kok0p155hNpj/i9+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9BQCDeMU6+8+fdSJ4PseJ21s9KqhCR42gENjtHPK0M=;
 b=A/6xdxLGoQ9KsYmr8pOPv0FamTrTzP6YGb7jwMlsTdeYfN5pDplkAJNA6/xFj3sVMZ4pAAi212ZLFmCG/Fm62TAId+a+vXmCfsJrGH4IFVn+FpZbqf0TslPWB/5QmC1CrxBzEVF4p41KiJk/XeaYQb80U7TyUdjEKqfjAmDTH/sB/ifR2uLEZyvuK5K8yt9T6X+2OBllk0MSaGY5srUeY/yF2DAEHukd1ALycL8TKu2Pz+evnt0QHX8WpuGfS5eOoQ6NhnYy80Mgoi4AWv8IcIgX4TOQRKYOlaC9zxxYyiG8DiVtkgdfdF9Fm46OmT+Z6b+aRpNIibk90+42B6y/Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9BQCDeMU6+8+fdSJ4PseJ21s9KqhCR42gENjtHPK0M=;
 b=b2askCQX2c0ipKHCwZi8CIjB8hLfPxc8zo6F392lR1xN03R7mxJ4AzdGPzPdelthjQKfLv+D8IE7z1uIRvyhty2QfSBZPNjBNnOIMsgXXHS+gjZRtdhK1SfXcGJSNJvpSWis9Zaqa1UxsLwOlD28MeOwc8NZmcr0MhwEFhiJjI8=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYCP286MB1299.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:ba::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15; Sat, 30 Oct 2021 13:20:38 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%8]) with mapi id 15.20.4649.018; Sat, 30 Oct 2021
 13:20:38 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     Amit Shah <amit@infradead.org>,
        "amit@kernel.org" <amit@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogu9i4tDogZHJpdmVycy9jaGFyOiBzdXNwZWN0ZWQgbnVsbC1wb2lu?=
 =?gb2312?B?dGVyIGRlcmVmZXJlbmNlIHByb2JsZW0gaW4gaGFuZGxlX2NvbnRyb2xfbWVz?=
 =?gb2312?Q?sage?=
Thread-Topic: =?gb2312?B?u9i4tDogZHJpdmVycy9jaGFyOiBzdXNwZWN0ZWQgbnVsbC1wb2ludGVyIGRl?=
 =?gb2312?B?cmVmZXJlbmNlIHByb2JsZW0gaW4gaGFuZGxlX2NvbnRyb2xfbWVzc2FnZQ==?=
Thread-Index: AdfKMDJ0EAQbrvF4TcWJEzNX9uqpaAAJCoiAAADHJPAAZsi1gABngL5Q
Date:   Sat, 30 Oct 2021 13:20:38 +0000
Message-ID: <TYCP286MB11883A093F13CDBEEF7827118A889@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB11884B1010AF8C77F1BBDAF08A849@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
         <a61be974ef65d00fd22b0216fc0d85c0c226f5e9.camel@infradead.org>
         <TYCP286MB11885C2C4C12BFBB42F0D9CE8A849@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
 <dcd5178f3706fd57352f171bb20535ed052d26fe.camel@infradead.org>
In-Reply-To: <dcd5178f3706fd57352f171bb20535ed052d26fe.camel@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed7e7fae-f406-43b8-944d-08d99ba8109f
x-ms-traffictypediagnostic: TYCP286MB1299:
x-microsoft-antispam-prvs: <TYCP286MB1299DE27F066A0B424F0940E8A889@TYCP286MB1299.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b/L/GcfcYsLCllnPegUGwF+Y65L+W3noD4WsmkbT92CAsCtaIQpCvlwxllh2lVKg8jL46WJT90NMsgmPTV3Oqk+b2GCXh0TfIZ3miTw/HKOtBODAD/1EJgw1YCYYNslIP+YlXeYPxUNIFmLlR/Bq/WGnBuZruiMpfieWo+LGlC0kilud3f4Mc4Zcbnr53gj14CsKEEY/3Sfc8nqBGc/UIESSymTe6BcqkEMByDMFmp7BGBq9LQ+pYAyYvqJpOJaRH0fXbwbdgLgzusO9c/bE4r6CGxwr6/jtcqu1Qqyy4O8f4eMFIConPTi0fGf9iMu5wnwm9REJ87PKy3hN5/8yS/4KNU6dE4w8D+BetDuYnVlLiWd62UbKHyVt9AhgN//Tefh05BDHcXqWaQ3p9GsMvNxZNnpC/JVsfe9EV6uacyBx+Xy6YEmWXTa4Gj6iZTLkB9kL3K8t/lnr4knXgr7b+TIas7OTkvDIIVZYWCCKtDfW2ckKsg8cCUtY/LdFib18Znp5Q7icKYL8XKH1PCeTRkenKknEzJf3X1590u7XIg3VPsKoisYEooOcU5DTthiYMpCVdkoSfr7It3I+8RvF+rK3Fg8uZaDdsip94EHsxlnENTwUFEiccYtpe2Vd4lhFQJu4VJOK7Tm/65dsxjdmgcc6ZF2FuQWTxM73KAgGYEC82sYDgwykEU0gixLQp1RfCLE73ojr9TgjxauMjOxrrjTvTZCGrqI2elE1mhkZXpdjO6cnYZ9mfnQcKzvR+Z+wkAJUpBJonvNAstIYdlkzhyQ9Hi4EvNl+cyJClzER7AY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(86362001)(83380400001)(33656002)(5660300002)(38100700002)(6506007)(122000001)(71200400001)(52536014)(186003)(9686003)(7696005)(4001150100001)(966005)(38070700005)(224303003)(45080400002)(8936002)(508600001)(786003)(66946007)(64756008)(316002)(66556008)(26005)(66476007)(66446008)(110136005)(76116006)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dnpmckYrUlhmWE8vZU9KT2l2MmNKTzhhRU9GRlBiN0VlazkxRTlhVWs0RXBK?=
 =?gb2312?B?ejdiQlVENE1lQTNmdU1oRkowWVd0WElpSDAzazF2ZDU1eVFFcmN2bVo0cm9J?=
 =?gb2312?B?aTRnRW1VUVU5aktpcFpOUlBPOGwvRVJzZ3RJdEdtNWZ2cDFxRzl6MmtieVhr?=
 =?gb2312?B?cjJoU0hKVVdHb2hqSFFKTzhvZGRVVUkxRzJvUW03OUFwanp5RXFBaGVnWExI?=
 =?gb2312?B?VkpBMkovd2M3WVEzeTFtQ213ZEdTZEh1STl2OWJrMjNzL0NUT2kycjdMU0hv?=
 =?gb2312?B?UlVldzFHcEx2bTdyVEhMR2RoeGZ5TWRCZE4zOW9QK3dnYi9uQmM3c0dETitE?=
 =?gb2312?B?ejVhc0djVVQzWjZOQ2NuTUwvaTQwOHVqYkdSQ0x2ZmdrNWxmR0VxRm5sWE93?=
 =?gb2312?B?bkZCU25Lb283UG8ySVdwSzQ4eEg5eStTMDhpL3NWWmZya0t2ZmlvVU1NcGF4?=
 =?gb2312?B?SGt0L3RaV2tVWVU4MUpMRnVJNDVkNUlDN1Z2Nk1ibXZ2ckhTUC91dEx6T0ls?=
 =?gb2312?B?NEQxZ1FRN1laSFh3TWZmbFlESkhJMEtQMFRyRGEvck5NejlTaUZWbTR6U3lj?=
 =?gb2312?B?MkoyWk8rTnRwNVB3VHk3TjBGT201MWZVdGVRQm9ETlNhZ2FvZ1R6ckIxWHBH?=
 =?gb2312?B?dlBGemxWQ0FLVW9UNENNL3dYZElPZjV3cWkzdTh1blREeDRwNCt1L0JkdFhs?=
 =?gb2312?B?R3IzVStXeFBRZHpjWUQ1ZlJvbEc4aEtiMyt6TzdZeVB3QzhsclI1TVEvSHlw?=
 =?gb2312?B?d2hMUTduWUdUTFE4Um8xb2JZRHB2SXVxTE9Fem50V3ErK0w3c1BkazdoTGh2?=
 =?gb2312?B?SlhKcWplNlk4eFNPVkNwRmc0eVNvM29aaTFpVUNWNG8zNjlsaXJhVkVPdGNu?=
 =?gb2312?B?bnlwbmRtTnJWS0pKRGhNT01vY252YTdlaU9Jb1NQckhiMkxQeXoxbS9rMEpu?=
 =?gb2312?B?QUxqZ3drdTIrYWxyMlBmd2JOQnBNcGIyRkNTS2Q0bTNQWHQxeHQ2NUZLK3pv?=
 =?gb2312?B?QXZIKzJLYjVYa2dISThCTFdrT3V0ZGZubVZHaVR3NWJZRXZrQ1ZYOEt4TkZG?=
 =?gb2312?B?TnR6ZHIrV2VCOFp2NXdpZVNBUTdialhyb1E3cUthakR0VWpuRXYwVkRqYkl4?=
 =?gb2312?B?b2FQdXBXb29wdHpFWis1eGVnL1cxTjU5WkpqOVdqcUhkTDg3YjZBeGNvYlZz?=
 =?gb2312?B?RGl3WnpGWGVvcGhwZC9YRStZL0FmRFRwRTNPeWYyNVBsNjVKN3dqQ0cvZkZB?=
 =?gb2312?B?SjljWkh4TlNDTGNJT0dYaTRUN0kyVE0yVHlSbXN0SWVuSmw1S0JteXBmWlZo?=
 =?gb2312?B?R2dJc21YUTBhYi9PV2kvdzNYNFVzQjUwanU1Sk5jN0lDbXRFOGU4R1dOVXpY?=
 =?gb2312?B?TWs2aFhxVmFjZlljOE9ZS0ROSC9MYk5GSE9raElNMmQyY2xiVkxZQUNxVEJP?=
 =?gb2312?B?dElDSnBGeFAxMnEyTE50SGZUYVZiU0VZbmtzb2tNQ21sYXdwSEdrZ1BQemhu?=
 =?gb2312?B?TEMzUW1VcjZTcTlWZTFSeEdTcmFMeGJiS1FXS1hISnpiMHVObVhQaXRDRXpm?=
 =?gb2312?B?UFV2TURmaU9HR05qT3l2b21XMjBVN0lQb0F3bkRLaHo3VkpKRlh0WHpDVUhv?=
 =?gb2312?B?Z3NEbGRvK253QkYzeEo4RHpiWW9Jb1MzVllLeitLY0NLa1d1UmduNDQ5NWJK?=
 =?gb2312?B?QXRVMEM5OHhjRzdwZFZXT2NKNVVKaFVVRW50VFBRL1BjZEZVMWZtMlZCYkE0?=
 =?gb2312?B?bFU5WWdNVXdqZXcxeUpYMEI5WFZyVmcrQ0RRZEs5RHJDRXdLQVBTaXBaUE5Z?=
 =?gb2312?B?N3BFcDFTZUpGeEJDeUY5ZDlMdkZQVlhYdU00TnI2VFcyeUtzRzdKTlVZN0pl?=
 =?gb2312?B?dmpZZHZyWGRhNlAzY2RHT3hrUWhyNEh0cnFNL09qNExaQTVkbXB5OHIwajVW?=
 =?gb2312?B?YU9XbkZqZmhyTkFUVTRCSEp1RUdkQmNGUUw5V3VRa2pydmRCM1ZlZDFKWElG?=
 =?gb2312?B?aDNyaUIzcEdwKzZoZTVPYWRJdU9CdTg1QVpkc3JYditNalNUTC8ydXBXbGdp?=
 =?gb2312?B?NEI5aldza2crOEhlcEtsRkZkaEtXWUprdExSN3RKeFJxWEpsQmYxY2NlTGpo?=
 =?gb2312?B?bVloU3JBK00xN0tpUXJwU0JaUkJVeG5YTTZPdEt0Y2pGWGpEL1VpQjBWQmgv?=
 =?gb2312?B?bUE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7e7fae-f406-43b8-944d-08d99ba8109f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2021 13:20:38.2194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uHjUIT0GXSLqsjnmwJzwzGOqtP/6+vYhiKG8dbPALt64hD9oh5Bj+kenK2OAV3BVhUn0LXRG+q/KDuuYeaHvoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1299
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWYgaXQncyBwb3NzaWJsZSBhcyBzYWlkLCBtYXliZSBpdCBzaG91bGQgYmUgZml4ZWQ/IA0KRG8g
eW91IG5lZWQgbXkgaGVscCB0byBzZW5kIGEgcGF0Y2g/DQoNCi0tLS0t08q8/tStvP4tLS0tLQ0K
t6K8/sjLOiBBbWl0IFNoYWggPGFtaXRAaW5mcmFkZWFkLm9yZz4gDQq3osvNyrG85DogMjAyMcTq
MTDUwjI4yNUgMTk6NTUNCsrVvP7IyzogWUUgQ2hlbmdmZW5nIDxjeWVhYUBjb25uZWN0LnVzdC5o
az47IGFtaXRAa2VybmVsLm9yZzsgYXJuZEBhcm5kYi5kZTsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0K1vfM4jogUmU6ILvYuLQ6IGRyaXZlcnMvY2hhcjogc3VzcGVjdGVkIG51bGwtcG9p
bnRlciBkZXJlZmVyZW5jZSBwcm9ibGVtIGluIGhhbmRsZV9jb250cm9sX21lc3NhZ2UNCg0KT24g
VHVlLCAyMDIxLTEwLTI2IGF0IDExOjUxICswMDAwLCBZRSBDaGVuZ2Zlbmcgd3JvdGU6DQo+IFRo
YW5rcyBmb3IgeW91ciByZXBseS4NCj4gDQo+IEFncmVlIHdpdGggeW91LCBzZWVtcyB0aGF0IHRo
ZSBicmFuY2ggYXQgI2xpbmUgMTU3MyBhbHJlYWR5IGhhbmRsZXMgdGhpcyBzaXR1YXRpb24uDQo+
IA0KPiBBbm90aGVyIHF1ZXN0aW9uLCBpcyBpdCBwb3NzaWJsZSB0aGF0IHBvcnQtPm5hbWUgaXMg
bnVsbCB3aGVuIHNob3dfcG9ydF9uYW1lIGlzIGludm9rZWQ/IEkgZG9uJ3Qgc2VlIGFueSBudWxs
LWNoZWNrIHRoZXJlLCBjb3VsZCBpdCBiZSBhIG51bGwtZGVyZWZlcmVuY2UgcHJvYmxlbSBhdCAj
bGluZSAxMjgyPyBMaW5rIGlzIGJlbG93Lg0KPiBodHRwczovL2FwYzAxLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZnaXRodWIuY29tJTJGdG9ydmFs
ZHMlMkZsaW51eCUyRmJsb2IlMkZtYXN0ZXIlMkZkcml2ZXJzJTJGY2hhciUyRnZpcnRpb19jb25z
b2xlLmMlMjNMMTI4MiZhbXA7ZGF0YT0wNCU3QzAxJTdDY3llYWElNDBjb25uZWN0LnVzdC5oayU3
Q2Y3OGRmNTQyNDgyMjQ0Mjc1YTQ0MDhkOTlhMDljMTU5JTdDNmMxZDQxNTIzOWQwNDRjYTg4ZDli
OGQ2ZGRjYTA3MDglN0MxJTdDMCU3QzYzNzcxMDE4ODk2Nzg4MTY0NCU3Q1Vua25vd24lN0NUV0Zw
Ykdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhh
V3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1UR2M4OXFZb0FZaGVIUU92RGtNQ3BB
dHZOSno2bXV3OXpDOG5oUVhBUTBFJTNEJmFtcDtyZXNlcnZlZD0wDQoNCldoeSBkb24ndCB5b3Ug
dHJ5IGl0Pw0KDQpJdCdzIGNlcnRhaW5seSBwb3NzaWJsZSB0aGF0IGEgcG9ydCBkb2Vzbid0IGhh
dmUgYSBuYW1lLg0KDQoNCg==
