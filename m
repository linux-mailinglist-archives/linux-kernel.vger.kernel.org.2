Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CD13B3B35
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 05:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhFYDiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 23:38:18 -0400
Received: from mail-eopbgr1320129.outbound.protection.outlook.com ([40.107.132.129]:17697
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232917AbhFYDiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 23:38:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLOqLSk85d2aSwKlCGTvbArbiSjIqZTl+MUG/ROu1AxmXbFtyp/mcE6b6c8AJaQs1UkS8dBFERIOuH9UlTYUIQTO0et9wMNg+n90MAp5nXyvj8JKycyu5adu6r+TkrO2ms+wSyRhTSAOXmwdZI3mBqPF23aeCJcG/w1EScGYe8BbV/l0lLLML/sN2xqvWM5QwDXeXiWZjnAZqCpJIh1cqf6Xs5Klrzk4sjNzwN7oPhJ0QJcs4XeREs8nOiLdNYRPDBg0QVtpl6eGBCySd+usWS6781kU0KkSdI0Ez2tZZRIfph6LeYjtFUjMVrC+MUDliXh89lRcufFPg+VSOWsl2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmYxbbpTzvb7unzmFoB13KS5TMswpZpOZVolzBw38mk=;
 b=nJGAkswKR5MIrO/3hqeGPEPPu2ooenvwsfgrtvEtjoLAMLHYt9Vx7PiLWAoUqCDIFOlhdnS6TU6fwDk6u2Jj4SGTYhYsmvGcIaGoftahHdZoGgm5acOyCdPTT9Yejt9JInzxywPnDTPo6Dim7EU/jU4JNO8u6hl1z6FgHoWXhMzzzHLYGepg/ZrK8Om1GuXRQ0BYr9M/XDbw8efxMrlXwMwRjAwZA5xf2oIdpOvtNH4B0quflYAHXaoIwgKYqjj+EjGP6vutAAhKzMqPg4or4C/F56pCJto5HkL6afmuGSmuTM6qGER/Z8WLVUzLi2Q4GFporNFYkCVrK6LqoKuGVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmYxbbpTzvb7unzmFoB13KS5TMswpZpOZVolzBw38mk=;
 b=wPKhE4MrfoI0jIzfdUMbpPv3ChLNzs276ucOIQuZB+d4y/6Rj/jkPflu8AEkGaFdsr8Sq3SzLvINM6h/Keoy6WrxMl5rYENDdHpLV3M7GqpTYFZPk42PtlWfjvLxlf89tIh7Fy4Cfi6w1UVEd7RGI9PGGjRZd2MtTKh0o4lN4sxZt/HKhGplG/gM1i9EloiwyTYjuZSZo5RTlRfoBb0H5tYxXG7YR6AFhgrC/4ql9dDLZHSj8MFyifn6vJG25j9KdtgCfTT3SoFev/v5vNfUetPC6NJjfYGwMJGDuEtZ1AuVyOa106vu65zl6gv5lKhH6w/gS0+TFg8A6zSfVo6leA==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK0PR06MB2673.apcprd06.prod.outlook.com (2603:1096:203:31::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Fri, 25 Jun
 2021 03:35:44 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::acdc:77b3:e0c4:4a3d]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::acdc:77b3:e0c4:4a3d%3]) with mapi id 15.20.4242.025; Fri, 25 Jun 2021
 03:35:44 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [PATCH] hwmon: (aspeed-pwm-tacho) Using falling edge.
Thread-Topic: [PATCH] hwmon: (aspeed-pwm-tacho) Using falling edge.
Thread-Index: AQHXaK0GIwSWBAdj6kWpxS7NyKwlrKsjG/0AgAF/H4A=
Date:   Fri, 25 Jun 2021 03:35:43 +0000
Message-ID: <51093C5F-61E2-4155-9C9A-035E330AEA1E@aspeedtech.com>
References: <20210624035821.25375-1-billy_tsai@aspeedtech.com>
 <20210624124428.GB1670703@roeck-us.net>
In-Reply-To: <20210624124428.GB1670703@roeck-us.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none
 header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa9b1a15-c7dd-480f-a1c7-08d9378a5065
x-ms-traffictypediagnostic: HK0PR06MB2673:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB2673803A82BD7F92F06F97448B069@HK0PR06MB2673.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cC7kTUUCZw5aWcSGV1KKrTBLCCXrxBG/v+0E1Kclr4Kaqeuw2J+kPtAkk1NMDP/5gFRROINm1CM9o89JeMt46fRqAxR3110gFuOrC3zE4njvJH7TXtdtOlfWk4yVjlctsnXehwb0/T2jK1xSjUVuBtuLRuui4UQl1AgSjowBOGe3+MFFlg5dUFGNaAjgLkgydSJmavUw5ziUS2+62E58BHHYgRxXz+VI102/uV8szLyebaIA2QE0S3tJ5V3FYB+lSBS7xmTe6BF5edoT7tDX3aJmPHG5HMz+t7rdA2vv5yo2eExEsw3AWk7owgfjd1Wsf1fgwZ/wUTl9yZcXC8qKRrQxq09fzfFrTAVWdnD/7hrQDETN86XPOd4KfOOXSH2sVByNRQfHio0tLswmrPzhE1RAFsrHQQjOcPIaSyH4PjdWchlQd7xmgWA6EYh6EunYdYEolIoDVYq9y5tT4nFgcHbCdMNK0+0sU96rq6H0a8++P2PuW9S4do+PzWSV+1ovFpY6qLF0RHDkbp2prgwbTkqVqum5XOGcwZxlHNNOdfzhSDiH8l1fIVJznw7HQ0yWuS9vcUnU4WODB26ypXQRGexq7SXrf4ghPA6dvOJEBjraA62dxxFsYSQ7wVMjGW+zLvmMw6pTam8HDYvp6LHZr9uHjwyEHchh9fNtAwjQRUI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(346002)(396003)(136003)(366004)(376002)(478600001)(53546011)(2906002)(38100700002)(55236004)(6506007)(8676002)(26005)(33656002)(316002)(86362001)(5660300002)(107886003)(6916009)(66946007)(54906003)(83380400001)(2616005)(76116006)(6486002)(6512007)(122000001)(4326008)(66476007)(66556008)(36756003)(8936002)(71200400001)(66446008)(186003)(64756008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWNRSVRpQjJ5bTZUYkx5QnNNUzBoNEJDZzMrYW9ndUxjNWVGSDVsOUsyVERK?=
 =?utf-8?B?YTRsckNlbzM3eWJUcnROSTNtQXBYU3QrSmZ2cE9NR2RJd3RBSFhYaTdaK01k?=
 =?utf-8?B?V29kMmx0U0pZZGJhdkRIMmpFZi81N3RLcmdrWWtGOTFTKzJYZnlnNHVOa0dR?=
 =?utf-8?B?SWQ0Y2NVR2Z1QThWdXRqNTZKOWg0OEVEekR5dk5rbXFFMHJQWXVhV245Tnh3?=
 =?utf-8?B?Vk02RUJUd0Z0RmFxUHd2ZkJSRnUxaFY3YzNlQ3h6UGhXKzlLODFGdGYvNXU2?=
 =?utf-8?B?MEV5dXliZG5HNzFNd2drajd5RmZ3cEVvTFE4aVowckNXSm9TZklSWWtXb2tG?=
 =?utf-8?B?VExiZDdKK0lSNUxRL1lVbHNnaVNvZjRmTkRzamJzYU1iNWVRYzdsVWdhZXpX?=
 =?utf-8?B?YjBqMmpZVTR5aWNicE44ak9LUHR2WnJxZnhiSDhFdXJ4L1ZvcXFtRDJhOVZi?=
 =?utf-8?B?aC9QeUFxNFF6cGUycDhDUWp0b1hLdkNQSjlMaXhaZEIweHBMbUY2WTB2NjYv?=
 =?utf-8?B?SkMzYmhVWm9OaFhpVEw3ZlZNa3VWc1pJQjRjR2RDMllNV3pNSitZN1FBNUlj?=
 =?utf-8?B?UWxRSHZiems0UmRzT3FaZVdoU29ZRkZBaExlTytHdDd3MnN1WXIzNER4UDMy?=
 =?utf-8?B?VndYRWxvamdkbVhnSXp2aS9GOTBIS3U0dVlmR3Rob0QwZzhsaHFKMlc4TEpJ?=
 =?utf-8?B?V2grY3kvNGJ2THBkRzF4QjdpU2hGNXVQc3hhVURRRHNFbFlQNFczYWljVU5N?=
 =?utf-8?B?M2hDeTVqaDZvTS9wcUx2UDlkVmhzcDVOekN5NFFmR1N4Y1QrL1pyRjZZZHMx?=
 =?utf-8?B?eFpEU250TENieFZ6ekxVWG5tekdTRDU2Um5jYkw3S0xHZDZZZDhoeU1UM1NC?=
 =?utf-8?B?WG9UTWIvN3Z6Y1o5WHRrem9jOXE5NjFwWUswZDRwaUg4ckZjcit5aVlRMU1j?=
 =?utf-8?B?MFJlM3BTclpORVJjTWpGaFNIOU5PQWprcmdaM2lieXBDbVp3ZDRSdGg5Sk1P?=
 =?utf-8?B?NGdFTHFMekdlMzVPSzU3RUp1bjRKNU9UWEQ2dzY0ZUdFRTZGS3pUVTJtZlk5?=
 =?utf-8?B?MWVvSGkvYzNheGtxRjh6SDAwcEpZWmxKTWV0SDQ4Y2FOUjZxSE8wMTNlck41?=
 =?utf-8?B?enhCRW1kamQxQVozN2JzUEVkaU82MFBlV3dkVnVnTEh6OUp4SkdMOW9RdEc4?=
 =?utf-8?B?ZDQvRXV4YlNIQWhCM3dWU1lMejFEVWFLeDcwcUYxQXZmYTU2cE1CQU1aejhH?=
 =?utf-8?B?RmZlOHRNd25wT2RFTE1DYWQ2ckJiUkJkUWRjK3hSS2d4dXNQWkpqL2RHRVd2?=
 =?utf-8?B?NDI1YlVOMk1uVGdQVHdsN1JzUSt5OUxmUmw2ck5HMmpDTzJOSk9rLytDMllN?=
 =?utf-8?B?NGRsaXFlQkdoN0RqYk5lQ1kvcXEzL0R2VFNNQXFDMWFsdkdocUQyNkxRWDhl?=
 =?utf-8?B?KzZMVUFLRGVOUW45TkE2SzR2SWZUeVFsbE0vZGwxSThlOUhqcExMWkFvRXRq?=
 =?utf-8?B?dFdEUTRWcHo3bHFvSFltcXRJVVlQWjI3Q0c2UVdNMVB2em1CNUpFYmkrK2tu?=
 =?utf-8?B?OE9FUTJ0bWZraWdxRTVHcDlHc09mV09rbytZMWNmVFRxczVNVHJHVDhVTVVX?=
 =?utf-8?B?K2V2OVdNVjJPWkQ0RFBqUG0yeGMzTS9XOVVRc0hEYjZNSXk1a2VrYkpGYVIz?=
 =?utf-8?B?bGpSdUNoSUhrSlJxYm83QkQ4dElXK0w2ZDkva2ZzZWVYMDI2aHRtUjB1ZXR0?=
 =?utf-8?Q?Vj4DV6u90ZxYpTd8d1p2sEFf4OT+dzH8GWvepF6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1BBD37A74417DE45BD954E0504F220BB@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9b1a15-c7dd-480f-a1c7-08d9378a5065
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2021 03:35:44.0699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sTtzpbe3yDLvDNU7kpdVF8oOqE73fXnLpzicp2W75zOBncv3B3pjpqfypp7pDdn9DRNxtREf3OMwGr/SyN3L47uonnuCElrLS6Rp/ECDbz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2673
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMS82LzI0LCA4OjQ0IFBNLCAiR3VlbnRlciBSb2VjayIgPGdyb2VjazdAZ21haWwuY29t
IG9uIGJlaGFsZiBvZiBsaW51eEByb2Vjay11cy5uZXQ+IHdyb3RlOg0KDQogICAgT24gVGh1LCBK
dW4gMjQsIDIwMjEgYXQgMTE6NTg6MjFBTSArMDgwMCwgQmlsbHkgVHNhaSB3cm90ZToNCiAgICA+
PiBUaGUgdGFjaCBzaG91bGRuJ3QgdXNlIGJvdGggZWRnZXMgdG8gbWVhc3VyZS4gV2hlbiB0aGUg
dGFjaCBpbnB1dA0KICAgID4+IGR1dHkgY3ljbGUgaXNuJ3QgNTAlIHRoZSByZXR1cm4gdmFsdWUg
d2lsbCBpbmFjY3VyYXRlLg0KICAgID4+IA0KICAgID4gQSB0YWNob21ldGVyIGRvZXNuJ3QgaGF2
ZSBhIGR1dHkgY3ljbGUuIEEgcHdtIGhhcyBhIGR1dHkgY3ljbGUsIGJ1dCB0aGF0DQogICAgPiBp
cyBjb21wbGV0ZWx5IGluZGVwZW5kZW50IG9mIHRoZSBwd20gZHV0eSBjeWNsZSB1c2VkIHRvIHNl
dCB0aGUgZmFuIHNwZWVkLg0KICAgID4gU28gdGhpcyBwYXRjaCBkb2VzIG5vdCByZWFsbHkgbWFr
ZSBzZW5zZSB3aXRoIHRoZSBhYm92ZSBleHBsYW5hdGlvbi4NCg0KVGhlIGR1dHkgY3ljbGUgbWVh
bnMgdGhlIHdhdmVmb3JtIHRoYXQgcmVwb3J0ZWQgZnJvbSB0aGUgZmFuIHRhY2ggcGluIG5vdCBw
d20gc2lnbmFsLg0KDQogICAgPiBUaGUgaW1wYWN0IG9mIHRoaXMgcGF0Y2ggaXMgbGlrZWx5IHRo
YXQgdGhlIHJlcG9ydGVkIGZhbiBzcGVlZCBpcyByZWR1Y2VkDQogICAgPiBieSA1MCUuIEl0IG1h
eSB3ZWxsIGJlIHRoYXQgdGhlIGRyaXZlciBjdXJyZW50bHkgcmVwb3J0cyB0d2ljZSB0aGUgcmVh
bCBmYW4NCiAgICA+IHNwZWVkLiBJIGhhdmUgbm8gaWRlYSBpZiB0aGF0IGlzIHRoZSBjYXNlLCBi
dXQgaWYgaXQgaXMgaXQgc2hvdWxkIG5vdCBiZQ0KICAgID4gY29uZGl0aW9uYWwuIFRoZSBkZXNj
cmlwdGlvbiBhYm92ZSBzdGF0ZXMgIndoZW4gdGhlIHRhY2ggaW5wdXQgY3ljbGUgaXNuJ3QNCiAg
ICA+IDUwJSIsIHN1Z2dlc3RpbmcgdGhhdCB0aGlzIGlzIGNvbmRpdGlvbmFsIG9uIHNvbWUgb3Ro
ZXIgY29uZmlndXJhdGlvbi4NCiAgICA+IEkgZG9uJ3Qga25vdyB3aGF0IHRoYXQgbWlnaHQgYmUg
ZWl0aGVyLg0KDQpBY2NvcmRpbmcgdG8gdGhlIHRhY2ggbW9kZSwgb3VyIHRhY2ggY29udHJvbGxl
ciB3aWxsIHNhbXBsZSB0aGUgdGltZSBvZiBvbmNlIGNvbmRpdGlvbmFsIG1lZXQgYW5kIHRyYW5z
bGF0ZSBpdCB0byB0YWNoIHZhbHVlLg0KV2hlbiB0aGUgdGFjaCBzaWduYWwgZHV0eSBjeWNsZSBp
c24ndCA1MCUsIHVzaW5nIGJvdGggZWRnZXMgbW9kZSB3aWxsIGdldCB0aGUgdGFjaCB2YWx1ZSB3
aXRoIGVycm9yIHJhdGUuDQpJbiBhZGRpdGlvbiwgdGhlIGN1cnJlbnQgcmVwb3J0IHZhbHVlIG9m
IGJvdGggZWRnZXMgd2lsbCB0d2ljZSB0aGUgcmVzdWx0IHdoaWNoIHdpbGwgZW5sYXJnZSB0aGUg
ZXJyb3IgcmF0ZS4NCkFjdHVhbGx5LCB0aGUgdGFjaCBzaWduYWwgd29uJ3QgYmUgYSBjb21wbGV0
ZSA1MCUgZHV0eSBjeWNsZSwgc28gYm90aCBlZGdlcyBtb2RlIGlzbid0IHJlY29tbWFuZGVkIGZv
ciB0aGUgZmFuIHVzYWdlLg0KV2l0aCByaXNpbmctdG8tcmlzaW5nIG1vZGUgdGhlIHNrZXcgdGlt
ZSBvZiB0YWNoIHNpZ25hbCB3aWxsIGFsc28gZWZmZWN0IHRoZSBhY2N1cmFjeS4NClRodXMsIHVz
aW5nIHRoZSBmYWxsaW5nLXRvLWZhbGxpbmcgbW9kZSBpcyB0aGUgYmV0dGVyIHdheSBmb3IgYSBm
YW4gdGFjaCBtb25pdG9yLg0KQnV0IGZvciBmbGV4aWJpbGl0eSwgSSB0aGluayB1c2luZyBkdHMg
cHJvcGVydHkgdG8gY29udHJvbCB0aGUgdGFjaCBtb2RlIGlzIGJldHRlciB0aGUgdXNlciBjYW4g
Y2hhbmdlIHRoZSBtb2RlIHRvIGFkYXB0ZXIgdGhlIG1vbml0b3IgZGV2aWNlLg0KDQogICAgPiBT
bywgc29ycnksIEkgY2FuJ3QgYWNjZXB0IHRoaXMgcGF0Y2ggd2l0aG91dCBhIG1vcmUgZGV0YWls
ZWQgYW5kIGFjY3VyYXRlDQogICAgPiBkZXNjcmlwdGlvbiBhbmQgZXhwbGFuYXRpb24gd2h5IGl0
IGlzIG5lZWRlZC4NCg0KICAgID4+IFNpZ25lZC1vZmYtYnk6IEJpbGx5IFRzYWkgPGJpbGx5X3Rz
YWlAYXNwZWVkdGVjaC5jb20+DQogICAgPj4gLS0tDQogICAgPj4gIGRyaXZlcnMvaHdtb24vYXNw
ZWVkLXB3bS10YWNoby5jIHwgMiArLQ0KICAgID4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCiAgICA+PiANCiAgICA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9od21vbi9hc3BlZWQtcHdtLXRhY2hvLmMgYi9kcml2ZXJzL2h3bW9uL2FzcGVlZC1wd20tdGFj
aG8uYw0KICAgID4+IGluZGV4IDNkODIzOWZkNjZlZC4uMGE3MGEwZTIyYWNmIDEwMDY0NA0KICAg
ID4+IC0tLSBhL2RyaXZlcnMvaHdtb24vYXNwZWVkLXB3bS10YWNoby5jDQogICAgPj4gKysrIGIv
ZHJpdmVycy9od21vbi9hc3BlZWQtcHdtLXRhY2hvLmMNCiAgICA+PiBAQCAtMTU4LDcgKzE1OCw3
IEBADQogICAgPj4gICAqIDEwOiBib3RoDQogICAgPj4gICAqIDExOiByZXNlcnZlZC4NCiAgICA+
PiAgICovDQogICAgPj4gLSNkZWZpbmUgTV9UQUNIX01PREUgMHgwMiAvKiAxMGIgKi8NCiAgICA+
PiArI2RlZmluZSBNX1RBQ0hfTU9ERSAweDAwIC8qIDEwYiAqLw0KDQogICAgPiBUaGF0IGNvbW1l
bnQgaXMgbm93IHdyb25nLg0KDQogICAgPiBHdWVudGVyDQoNCiAgICA+PiAgI2RlZmluZSBNX1RB
Q0hfVU5JVCAweDAyMTANCiAgICA+PiAgI2RlZmluZSBJTklUX0ZBTl9DVFJMIDB4RkYNCiAgICA+
PiAgDQogICAgPj4gLS0gDQogICAgPj4gMi4yNS4xDQogICAgPj4NCg0K
