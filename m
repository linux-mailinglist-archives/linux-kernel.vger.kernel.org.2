Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A486458F43
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 14:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhKVNVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 08:21:55 -0500
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:47168
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230322AbhKVNVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 08:21:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vx3L1Ql05KxrJwey0ey4kQ4Jo2fJOpM7yJvrI35S7H8QjxAY+bsehqGe4bTbofrgEyvtZjNHdMCYdHQeaQtm8rjmo2bSRwDmoDWyYoMV950gXoCqVgGNf1XZc2mF6fJyUbEPEQM1fOu1IDt58M2qMctd9v7YekpmGunaQNlAiAgeDB0avM6rjjKGkdV+IHnCD+o+oQzC7/gE9e6Dzkv3xD63kxoJtZYpQiDqGYNfVdj8GznZBJuGQKh4ro8TdQ5eaxU5u9Dx3pm1hP/x6cqL+wtkqyyYRDU+pO30IK/JwyDIDPyw3+BE3jgdC5JCOdre/HPxRroHNwJUaPVR0fKU7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66lTXSvea8FRCMgKCM92U0T8buKB7y70qPz6CVSAyKg=;
 b=hg4NO/Ks++AURVaREuDFdEzRB484m1fg70d8r8r+jIP52zZGBNwCH1bqqyRYFHpSOabXh8W+FDhQsSH652X8LKgvJhhNZ4NwnGC8X3zal1J6DAqBGPB7UMD+CFZe+YH1M1KggGv+fGtql4aLnDuMl+UfhtBszogYEhDGB4L6zRvJoP0jWrD/HGhVRs9juCaYn4HWOo9OLL5O+O/BWn5WVvm3CiYzmhEFgfvlkmU6QYCTpdlrIe6abBJQp/BI3J38rGKHECgdBiv2WBJ0zXW9WG5qWR0En9uFn/4CebQslVHUkk8R71iQ3nePnDW7S+O9iPnuUqXpAcFOHyZmlpAXIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66lTXSvea8FRCMgKCM92U0T8buKB7y70qPz6CVSAyKg=;
 b=cvd7/ejpbyMMVD18wxPgmOYWP+u/JOCgM/thDvUHvVKtMilN2uJaYcx1/K0hMYP2q0mHXTn4m4mi7i2HIZeKKfVSOsa/ZSosS5BMITZZ1O6RGlu+6veDoLglp/4j3MMGfWU9AdwuVYgIF15v+tPIvAtEgQyu04jAApgyx1zZpWQ=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR03MB2890.eurprd03.prod.outlook.com (2603:10a6:7:5c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.24; Mon, 22 Nov 2021 13:18:43 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::544e:754:6241:aa7f]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::544e:754:6241:aa7f%6]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 13:18:43 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] bitops: Add single_bit_set()
Thread-Topic: [PATCH 1/4] bitops: Add single_bit_set()
Thread-Index: AQHX35CZ2t64bA8wLE2j/heX74SAnqwPaOmAgAAUvoCAAAQ4gIAABfAA
Date:   Mon, 22 Nov 2021 13:18:42 +0000
Message-ID: <e2675600-7b04-19b0-79ce-28a4e1d1f225@fi.rohmeurope.com>
References: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <73d5e4286282a47b614d1cc5631eb9ff2a7e2b44.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <YZt+x2moR632x///@smile.fi.intel.com>
 <2c22b52f-9a1f-06f5-f008-d568096f5c4d@fi.rohmeurope.com>
 <YZuTt3+PPvyJsFQ/@smile.fi.intel.com>
In-Reply-To: <YZuTt3+PPvyJsFQ/@smile.fi.intel.com>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7284ec2e-999d-40ca-cc59-08d9adba9b49
x-ms-traffictypediagnostic: HE1PR03MB2890:
x-microsoft-antispam-prvs: <HE1PR03MB2890A18D4467357E55BF128AAD9F9@HE1PR03MB2890.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UqitafBxGGEVbPGw0pG9nEEesC5qEQHcNNmtSJyOdjJ5n0a8G6BSD/mQOEpeB4rU/8tGrkrb/YH5YG0/WFMhpV/gPJPCzN6KS/qFNYcijmflG9jFwmTA+1ejMdZq5/ayCc6PGxF9ntUrcW5gfUjOSIzG8gW2AZ4+HQPfdD8Ko4gjNSI1yyA//9wu2Z8bJrMvUhDmXlCLjubSq6pFRzeHSPdDImOIjqq5cCbchbQcsmuwD7+TyK+g6W5J5UJWGi5M2Eqfj6O6ppYerLOSfW6RSoXm71NewRSTbNNVD7Vb6Ut9FwxJrXYUKmsviD+uYfe81sfCwKFUymdm8onUgKnyxGxy+Qezjl/dYgb6E9Ry9zg3lhz0b6tuec1xubtlmCnD9yEGjH9aA5saKP+2zErHZfKGz3GBw/A+ugCFUjvW3R15JFqoiFhKIQ/hmhCj6KFmN5Wh6Vqu+Hlh7ECtoSPYHRoFDk2BOx9fFbIlpDgDZsZ6A9fzDeQniquCfv93pXkEKXURY/ZP9kHajtKYl91DTlnFMIpPMPS8X/BVLd3cw+L70NqgkiBDgd9Dglr4rYSdipCuXXXHPP+T10ylTuwfUsGVPAXUFpMjjHu5TsUayxv/xOZMsnKydbiuQDIqezj43PAfF5UCzIdk4GpZTVh1AUtbJVt2u8lZAMOuvbh12NqhaiPbpMTU46lTJUbKFG1EKZR4/gONP/R/n0KM/v7YZgr91+9Y7mUwJPSzrHTKpDOtvO1qh9o/P8jsrwqGRyYmrgEIp44oKZ3iSnsWkg7gbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(31696002)(2906002)(38100700002)(8676002)(7416002)(122000001)(76116006)(38070700005)(66446008)(66556008)(66476007)(83380400001)(6486002)(6512007)(508600001)(6506007)(64756008)(4326008)(8936002)(66946007)(86362001)(2616005)(6916009)(71200400001)(53546011)(316002)(5660300002)(54906003)(26005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dCtvLzUzRmJja09vcHBWWUU4YUdDTlFXVGRCSXRzM2ZEbVRwczBGM2FLU2h3?=
 =?utf-8?B?Yml6M3djbjQ0VXRSN29tWDRCRkZuM3FEMUVzY2xtSTl6bkJtQTByVEhlQ2Iy?=
 =?utf-8?B?elRRUytvS0hwUTZxeHpubWMyS25aMHJJWngzRUNHa21aaTdnSXZoYldYRXFL?=
 =?utf-8?B?R1lGK20za3VXZE41UmhCMzNlMHEyUElBdGJJcEpFTVhwSjNEOVJ2UzBlazZZ?=
 =?utf-8?B?WFRDSUE5Z0E1aFh3T2hMdmpoeXBKZUw4TDQ4RVRnZkIyUmgxdE1sQy8zNkZn?=
 =?utf-8?B?VW5jRld0cTNpUGYwTDVpYVJOaU9sbGJ5SGt6MVF3QWRmZFA5ZE5tWkEvUnM2?=
 =?utf-8?B?cUEwR1hCZU12YTRRRW41R3V0K1JnQU53bklqVzd5MU9sVzhyVFgwOXhkbnBM?=
 =?utf-8?B?Sm9heTAzU1BING5qVUxGejA5cnBtbytmeXpSbW82dXdBRGMreGp3V1orWWE1?=
 =?utf-8?B?Z2h3d21sM09EMWwxR3NzRnlVSytyRlE3MXpHVXRBckZCZFdKdDdmOW9SemNN?=
 =?utf-8?B?QU80U05GN054T1kxUmlhZkp5ei9lYStMdDhQNkN6Wk0rdmRWQWZvTnR2Y1pI?=
 =?utf-8?B?djBBUGl6VTd6YVU4T25yNTZ3U2N4M092VmJXNUs4R1BSTEJiTDhFR1FrVzlu?=
 =?utf-8?B?eWFmdEdxUFF4a3ZpQUFTYjVSNnBqTmdqOWlQa3NYT1ZnbldIeGFzcUVETnRo?=
 =?utf-8?B?d0ZwZmFTU1ljbVRJNDhQT2VsV29PZ2hIZDlEejI2T003NGNWam9xWGpRdTht?=
 =?utf-8?B?emRXUndockNpRG1kWHhhSUNEcFFQbnJscjlwOWY4dWpvdEFHTHNMTVNJcXBC?=
 =?utf-8?B?amdqZXRvWXM4Z21hTjdNZzZ2QkxRM0hiVHNMekZvS2ljUktXT1VSZDFCb2Rs?=
 =?utf-8?B?a1o0MzlDTHB1elR2SlAvalZFbWF1dVRJdk41ckpxRkgyU3ArZVlEbWhHWVB5?=
 =?utf-8?B?em5YT0RXNzNhS3RjR295eGp2a05FNzJtb3Y0SkErUkJzdFpKU3FXVVpRY0JK?=
 =?utf-8?B?cEtzcTZUWnFrMWhoT3FwcFJoMVQ0T0ZuMWFlMllKdzRHd3Vjb3pUUHNuMmxN?=
 =?utf-8?B?eG55dFgxMXJOSXZxYUFKc3NTQk9mdzQvY1FUTHFHQnNOUW01N0NNSDFZbFl1?=
 =?utf-8?B?eHQ2Q002TXBZSXN6d2cxNzlScEgxQ2lOS3B1dFZudzlLeUtKNUQ0K1JVTHRQ?=
 =?utf-8?B?Z1F4cVlYS2hoR2dpRDBUbGZtMU0zcDZrWGVyK0lZaTFHZ0NPK0VVK0tyRjg3?=
 =?utf-8?B?TERLUjhLcnRsUC9RZTdjM3NtYkY1aWdYbmFDSVoySElxMWgzaEZXN09iYXZx?=
 =?utf-8?B?SUtZdHRzalhWdlU0dUxocjRoRHhtSWJ3MXdHOHVZYU1Eb3pVQjhyVmxNT0Qy?=
 =?utf-8?B?enF4dEZVL3IvN2lBWTd4UVNtNnIvUmRsdCt1UXdZT0tjZFg4d1RrdFpVVFNW?=
 =?utf-8?B?VExxK2JCWlVRSWJDL1J6cGVnQmFUOXZDS3BXU0prRU1IT0hEM0Ezc3I2NDBj?=
 =?utf-8?B?UEVNS1RabG8raWxlMlVxNUdpYWg1MytWK1FVeW5yN0cyUXYzc3Bob0ZEcWc0?=
 =?utf-8?B?bjc2TVRwUzRJMUM2RkQ2bjJxRFVybkZDY3FIaHhpR0NyWGdQOXRCcS9yQU0x?=
 =?utf-8?B?QWJodEZHYUpHdDdmaVMxMVRRNFp6alF0elRXSnlBbytqLzJGOTFtYVBQZGlP?=
 =?utf-8?B?eE5LTmkxOE1sMFdvZzdPTTUxb3ZIRTNCOEdvK1l2S0EySUNoZEhRcjJwN0VW?=
 =?utf-8?B?Z3ZrbXdKclpjVEJXTHFzbnVLVHNjVWd5YWI2QmVyODcrZ0N0YlRBNThiaU1w?=
 =?utf-8?B?VFZFRE5HUVNoUUNlTFhuUHE3dlN1L3ZTTE1lYXh4NVAwN0I5Z1dGd3hFbkh1?=
 =?utf-8?B?ZFMwRlNpdWNneXc3VGV0WjZFZ3BKTDhKOHhBbXF3aTJHaFZQWm56ZUVpSzlz?=
 =?utf-8?B?cGIrdDlOSE9ZbnJBT01BKzVoWlF0ZEZ4WXhMWU1OODlBQkRNaGFWZ3JIbDY5?=
 =?utf-8?B?SERQYS9rMkxDM1dheElsTmVYQ3piM0tPelpFU0lKcjM4aWtRanNuMFJ2SUhB?=
 =?utf-8?B?ZTFYblpmdUtLSmhJQVBrQlg2aktIK2dtN2dndnYvMUlhMkN5RHFwWWs5Y2xW?=
 =?utf-8?B?SkJ0Uy9QRDNDajRxRFM1Zzd0TFJSUFVBNUFuU2NzT0FDQnlhUWhrM0VtcWpL?=
 =?utf-8?B?dXlTM0diVnV5NTRYUnEwaWtua0lWNkFJRDE3dXY4cVY4bnR1ZG91Wm0rRDR0?=
 =?utf-8?B?cEhTaXNsMmpzYktjU0dtLzRlYm15V3VKY3hhMUtITEZ3Tktvb253QTR6T0RC?=
 =?utf-8?Q?JFl9Seq7pn3sQo1+tN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36BD0D92918355418628CE01A070FF78@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7284ec2e-999d-40ca-cc59-08d9adba9b49
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 13:18:42.8714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: scD2Ae5DdEN/ei/jZsC4hGmWTFq/5VUEep+6syZAWGQiYIz0uJcUAKDEJKEhoAqPKKSkQV2dFL8h3aphrT4Sc38PMwjxsnk+cT58q3Obq1+AMG/zVk2vfOg+HC2+zPZ+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR03MB2890
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjIvMjEgMTQ6NTcsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gT24gTW9uLCBOb3Yg
MjIsIDIwMjEgYXQgMTI6NDI6MjFQTSArMDAwMCwgVmFpdHRpbmVuLCBNYXR0aSB3cm90ZToNCj4+
IE9uIDExLzIyLzIxIDEzOjI4LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+Pj4gT24gTW9uLCBO
b3YgMjIsIDIwMjEgYXQgMDE6MDM6MjVQTSArMDIwMCwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0K
PiANCj4gV2hhdCBkbyB5b3UgbWVhbiBieSB0aGlzPw0KPiANCj4gaHdlaWdodCgpIHdpbGwgcmV0
dXJuIHlvdSB0aGUgbnVtYmVyIG9mIHRoZSBub24temVybyBlbGVtZW50cyBpbiB0aGUgc2V0Lg0K
DQpFeGFjdGx5LiBUaGUgZnVuY3Rpb24gSSBhZGRlZCBkaWQgb25seSBjaGVjayBpZiBnaXZlbiBz
ZXQgb2YgYml0cyBoYWQgDQpvbmx5IG9uZSBiaXQgc2V0Lg0KDQo+IEluIGFwcGxpY2F0aW9uIHRv
IGJvb2xlYW4gYmFzZWQgYXJyYXlzIGl0IG1lYW5zIHRoZSBudW1iZXIgb2YgYml0cyB0aGF0DQo+
IGFyZSBzZXQuIE9idmlvdXNseSwgdGhlIGNvbmRpdGlvbiBgaHdlaWdodCgpID09IDFgIGlzIHdo
YXQgeW91IGFyZSBsb29raW5nDQo+IGZvci4NCg0KWWVzLiAoaHdlaWdodCgpID09IDEpIHdpbGwg
cmVzdWx0IGV4YWN0bHkgc2FtZSByZXN1bHQgLSB3aGljaCBkb2VzIG5vdCANCm1lYW4gdGhlIHNp
bmdsZV9iaXRfc2V0KCkgd2FzIHNhbWUgYXMgaHdlaWdodCgpLiBTYXksIHdlIGhhdmUgYSAzMmJp
dCANCndpZGUgdmFsdWUsIHdoaWNoIGlzIGxpa2VseSB0byBiZSAnMTEnIChiaW5hcnkpLiBUaGUg
c2luZ2xlX2JpdF9zZXQoKSANCndvdWxkIHJldHVybiAwIGFmdGVyIGNoZWNraW5nIHRoZSAyLm5k
IGJpdC4gU28sIHRoaXMgaXMgbm90IGVxdWFsIHRvIA0KaGFtbWluZyB3ZWlnaHQuIEJ1dCBhcyBJ
IHNhaWQsIG5vbmUgb2YgdGhpcyBpcyByZWFsbHkgbmVlZGVkIGZvciBteSANCnVzZS1jYXNlIGFu
ZCBkb2VzIG5vdCB3YXJyYW50IGFkZGluZyBuZXcgZnVuY3Rpb24uDQoNCj4+IEkgdGhpbmsgSSBh
Y3R1YWxseSB0cmllZCB1c2luZyBod2VpZ2h0KCkgYXQgc29tZSBwb2ludCBidXQgZG9uJ3QgcmVh
bGx5DQo+PiByZW1lbWJlciB3aHkgSSByb2xsZWQgdGhlIHNpbmdsZV9iaXRfc2V0LiAoSSByZW1l
bWJlciB0aGUgaHdlaWdodCgpDQo+PiB1c2FnZSBiZWNhdXNlIEkgaGFkIHRvIGRvIHNvbWUgZ29v
Z2xpbmcgYXMgSSBoYWQgbmV2ZXIgaGVhcmQgdGVybQ0KPj4gaGFtbWluZyB3ZWlnaHQgYmVmb3Jl
KS4NCj4gDQo+IE9oLCBpdCBzaG91bGQgYmUgYSB2ZXJ5IGdvb2QgcmVhc29uIG5vdCB0byB1c2Ug
aHdlaWdodCgpIHNpbmNlIG9uIHNvbWUNCj4gYXJjaGl0ZWN0dXJlcyBpdCBtaWdodCBiZWNvbWUg
anVzdCBvbmUgYXNzZW1ibHkgaW5zdHJ1Y3Rpb24uDQoNCkkgZGlkbid0IGtub3cgb2YgdGhpcy4g
VGhhbmtzIGZvciBzaGFyaW5nLg0KDQo+IChTaWRlIG5vdGU6IGFsbCB5b3VyIHNlbnRlbmNlcyBi
dXQgbGFzdCBpbiBhbGwgb2YgdGhlIHBhcmFncmFwaHMgYXJlIGVuZGluZw0KPiAgIHdpdGggdHJh
aWxpbmcgc3BhY2UuIEZvciBleGFtcGxlLCAic2VyaWVzICIgYW5kICJ0aGFua3MuIiBmb3IgdGhl
IGNvbXBhcmlzb24NCj4gICBpbiB0aGUgcHJldmlvdXMgcGFyYWdyYXBoLiBDYW4geW91IGZpeCB0
aGlzLCBwbGVhc2U/KQ0KDQpJIGNoYW5nZWQgZnJvbSBldm9sdXRpb24gdG8gVGh1bmRlcmJpcmQg
d2hlbiBteSBvbGQgbGFwdG9wIGJyb2tlLiBJdCANCnNlZW1zIFRodW5kZXJiaXJkIGlzIGRvaW5n
IHRoaXMgYnkgZGVmYXVsdCwgZG9uJ3Qga25vdyBpZiBpdCBjYW4gYmUgDQpjaGFuZ2VkIDooIEkn
bGwgc2VlIGlmIEkgZmluZCBhIHNvbHV0aW9uLg0KDQpCZXN0IFJlZ2FyZHMNCgktLU1hdHRpDQoN
Ci0tIA0KVGhlIExpbnV4IEtlcm5lbCBndXkgYXQgUk9ITSBTZW1pY29uZHVjdG9ycw0KDQpNYXR0
aSBWYWl0dGluZW4sIExpbnV4IGRldmljZSBkcml2ZXJzDQpST0hNIFNlbWljb25kdWN0b3JzLCBG
aW5sYW5kIFNXREMNCktpdmloYXJqdW5sZW5ra2kgMUUNCjkwMjIwIE9VTFUNCkZJTkxBTkQNCg0K
fn4gdGhpcyB5ZWFyIGlzIHRoZSB5ZWFyIG9mIGEgc2lnbmF0dXJlIHdyaXRlcnMgYmxvY2sgfn4N
Cg==
