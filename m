Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8601245C7EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353194AbhKXOui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 09:50:38 -0500
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:41728
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1354973AbhKXOue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:50:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSsFHWaUvysSxkeOXUxu7x5UJ2bCMMBZGwTjFZGK9uOXR0M692vbMsiWL7nxpB7rqYJgkNR85m0Rk9P3fDA38mtfUUlchFybhFUGaWkamHxG/YCMJ8Q8fJ4TFYkJTIcmZBELSgfybvRdFpzgmivf3jj3csly9wbssgRObWfwZVD2e59nOPEM8Zpt2TrFMEb3TjoEdZjQ13Y7Bvi955rAlKy0DXyWOJtO2DD1N7E0Zht35UA1sH+1g4gWY63eChnE5ksiDlHnLQ8AOBTHZ31nYu7rTwvhDy/ow4+LFTj8lXBY46TN0bktoSuhmT67NlTc/yUFw47JXbOkXOXLsqE/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfx+XTYCUTk+M0o/YQvH9KAkaqOaKqELfNF6xaSr8v8=;
 b=GwbLPmrOlqZLbCBYGy1N6QbhMhL9vC/mu21BIo5wUWiuwrI1L2DYI3Ws25OihMYRrq55B0owD04MKurtlOxMNUevKz51rFCYA1JiPptUoFLeeNmPT8DlAXvWnB64t4rDrTwdTcesZ2i1cVoyDLW6BJ8cK5opEBhMbIacJGrkK4FQ7xRPuDyzUrCI8zRPaJMEByZ9ruf5GPotmTtVaaXB1FC79FK/zO034guRiwSEH0iEVx+etu0n4Rfz1Ke6sjgfOVBixGoh7fOmSb76ze8ZHaw4ZkEZT0LWDsfCM6BugGR+dEXPUigAtumn5H7xLoYfnWBXIHnsEZxQ56EFTr/ZUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfx+XTYCUTk+M0o/YQvH9KAkaqOaKqELfNF6xaSr8v8=;
 b=rfjfAqb44t1sRqgKC/3hobNrrD/Za1G8HDleZRIZoGJgCHPjrhtYsgZxgcyCe8qdI/60UTr7Obx7MrPh1nInGVyP8msXTqHd+0ARWPT0CL/ZDNcSAeuasrUj4SJtXRPHImYeXKSSIi9bGFedlOzBBR7cIjc0FgAdet4b/yqP/R0=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB9PR10MB4682.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:261::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Wed, 24 Nov
 2021 14:47:22 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276%3]) with mapi id 15.20.4734.020; Wed, 24 Nov 2021
 14:47:22 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Andrej Picej <andrej.picej@norik.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "s.riedmueller@phytec.de" <s.riedmueller@phytec.de>
Subject: RE: [PATCH 2/2] mfd: da9063: Make vbcore registers volatile
Thread-Topic: [PATCH 2/2] mfd: da9063: Make vbcore registers volatile
Thread-Index: AQHX4QDrJvqufsfstUeKlqESd2v2MKwSakiAgABMMQCAAApHgA==
Date:   Wed, 24 Nov 2021 14:47:22 +0000
Message-ID: <DB9PR10MB4652377A18891B66E7449BE880619@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20211124070001.2516750-1-andrej.picej@norik.com>
 <20211124070001.2516750-2-andrej.picej@norik.com>
 <DB9PR10MB4652A195CDB7E237A0D87F6180619@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <358de8cf-ec40-3552-da0d-98b065120649@norik.com>
In-Reply-To: <358de8cf-ec40-3552-da0d-98b065120649@norik.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 325378e3-a819-4cdd-38d9-08d9af595290
x-ms-traffictypediagnostic: DB9PR10MB4682:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DB9PR10MB4682DA07140520D7ED7F6072A7619@DB9PR10MB4682.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hKn/lSZIeT6/Vj111aDLvbqLCzP9BVEexf3TJLleRYEyEuc/ZC392JXa6yyWSkk1+iXGeQQXet8nmQ8JwXZ+YrI8JjQN2eoqyJkzZLzKfO97TLSjfyn1Dq7s5S+S8NAegIOWkRzgHJn6uLMCo/1fy//YgLozew3FyyGenvYpOio+M1BeRGZaDmLa1ubpheVh4Q3rdFR4JYXKpOG0nRuzOrv8XTYnDxVRLYVbO/g59/AfnbamvmwPs/1wu55IbPnZ0BmJYlc8SUbWOH9smBwAE7Nl+n+nvrmzwUzvblbEGeY5hAKgmqENkQ0i7lSD+wrTiU3igwYxMFEo7udQWK0uSWD61/qAlTUtZ/AZA8pu9votFWJy/4VmX563FIeu3EJS3K8q3ohmgp8z9P8jMOiCm3Qkb/TbJRnijf8B3WU6tOgZIfm0HppdX+APH8hPND5uJBPe8WBHogA6/Wt4KOcqVftdrA9SA4oRwiXBVgqGwVTsMQwI6y2mZa1IP1KFw0Gfz4CykNe3ilZzIXONwbK3nBvkwNOi+2eLg0CVKshwTo+a7IvvzBm+npBkMeLxE7qQqeAcaFgHHsVYZWXOLGwZnCATw/f4KOZ6kCi3vvP4XRkBSySwOqHGPSlBzkyLfLFTzSFO0Ur/1DY0EPzQ9Fkir0mMhVrZ/LudSxtkYAUZha0Pd4YG5whebqJsPzhBVPQo6q+gyZHnvIjUiaMeXj0uig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(71200400001)(26005)(2906002)(8936002)(53546011)(122000001)(5660300002)(38100700002)(38070700005)(55236004)(33656002)(76116006)(86362001)(6506007)(66946007)(110136005)(66476007)(52536014)(8676002)(316002)(9686003)(66446008)(64756008)(66556008)(508600001)(186003)(4326008)(54906003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzEzRDlUV1dVWm9iZ1NvTGJkMms1OEwweWg0Z2twdjNsYlRCM0xDTGRVdllT?=
 =?utf-8?B?MkpGN2oyaG4rWHJLeXBoSzJVUWpKRkVqdEM0T3JpQU9UZlJNWWJZZnhESXRx?=
 =?utf-8?B?UGFUYlpyVk5ZUXByWTBhVXUrVmJNNEpxdUhITUhrNUlRLy9FMmJZd0Y5VVZC?=
 =?utf-8?B?YUxFb0lxcmlRK09NTU9pQVl2WWc3dXljQUMwRzZNdjdyaXczVXRRRUVsZ1Z4?=
 =?utf-8?B?c1EvV2p6U0dKczdXMUQ2ZlZDcVlJdVh6bzhsZEE0bWdSajE4UzRITGhIN25Z?=
 =?utf-8?B?bjc3RC9DWlg4andQWnE2YjZQR053NTFEdkJYdE12dFovRGFHS0lrZHZJVHlC?=
 =?utf-8?B?YnpRanR5ZVkvQjI4TVlxakpuNjZXaGh3S2phYWdvMnBBeW5CRlBUczNvTHpQ?=
 =?utf-8?B?S2hZVitlRnVhcnR4VnpscGZTSVJPTlo4L29Gc0VEL3lna0dnSUt6dEdjRk9i?=
 =?utf-8?B?eW9qV2tFVS93bFQ4N3VuMldyZzBnZGgxYWppemljV1VhVG5GZVBnQ21zdkdh?=
 =?utf-8?B?L3FXNnN0b1VCUVZPdEdZY2NYSk1iT3JyL28wbnFHUWN5Wko2NUNPeVhQZmgv?=
 =?utf-8?B?Ni9pTkJXb3dTVUJPMHJFZ1RQMXFMSGtvWVlKeTVhajNvZVZaZVY0Q1RQbVVG?=
 =?utf-8?B?eHVNM1dmc091dmJEd0d3SGlyVldXYjV4eW96cG1XRHd0MmtWTG0vOGhFMTR5?=
 =?utf-8?B?d3hydytmVkZ6VEZCc3pJbWoxRkloa3hMOTZJV01uemxiZHBRV0Uya0V1WkZS?=
 =?utf-8?B?cTdKYXo1NUMyUTlLUDd5Y2VJZHp3cExVY3M2OVJVQmlOMTJpNDlpR3N5OWVY?=
 =?utf-8?B?aE1kYkJmeExKajkzR3hYZVRYUUpaWVpqMy9UdUp4bDd4aFRHcUJKSkFTamo2?=
 =?utf-8?B?b1hqUXFLN05mVmxPZ0oySVRxU25OeVdBVWpwQ0k1OXZOTmZoNC9CejNsa1lU?=
 =?utf-8?B?dHBlSXJ4NnJKeXhxS0I0bnduMisxMG9QcmxBc29uQ2VEK2E4THB4VzZOWDBW?=
 =?utf-8?B?aXd5T1NQbUl2Z3V3ZjVjM0dMcVRteUZvZ2tzY1lxU09MYW91MFdsYng0OU45?=
 =?utf-8?B?K2p2Tm8wOXNtT1ZFZm5QM21vWkVRenlYS1NWbVpkT3VWQmdNSXpMSjFwYVF5?=
 =?utf-8?B?RmdISkpCSnBzWERUMDBWek5LSTBPY0E4MzB5ek5GMS9XMWhjS1Y1ekxmTlMw?=
 =?utf-8?B?c0FuWkp2MU9UaTFpbG1qdjJZOWJBbHE4cW94V3lINFY5ckNWK0I5S0VEVGw0?=
 =?utf-8?B?djcxT3paSzhML0d3VitOZEdVZm1GT2lDR2hLZUVJR2NEQXVLcmdVTlBXcWpi?=
 =?utf-8?B?ZlIrTTVqUWN0ODQvWDBwZzc1V3cvSlFRVzJ0S0JUcVlDRVY0czhWaVFyTTMv?=
 =?utf-8?B?bHljUnNXb2hEdkt3bDVBWmFMaVZlT1p0QS9LaEFFUlhlYWY3SzBTazl2ZnJn?=
 =?utf-8?B?MEU4S2oyNXpaZmpNMnZ4dEZZTC9ha0h1ZW1zQXR5SDBKZFhTcjNhMjA4T1Rq?=
 =?utf-8?B?VHYrL3BIM1Y0NWRuRWV6ZTZJREI3Q1phNXZKbGZIYk1mVnJFeUk1aVliZWlK?=
 =?utf-8?B?NzFqc2hVbkxCcW9zbXR2MUh1emprN0Q5YnZyTmZKTmtuQitrTGlRS282V3FW?=
 =?utf-8?B?czVBWVREeUtaUW9jVVpVUFIzSHp1WVFVZUdabk4rT2tOdlVtZGZ6eEN2QkZD?=
 =?utf-8?B?emY2VitaRThFdUJOREorQWdYbGR6N1Nvb29GSXBiTTNQUjVvVm9MMXVuVVB1?=
 =?utf-8?B?WGRkanlqekRJWXJ0UjBzdzhmVXFWMzlUdGN0NEpIYURHSXY0MjRpek9TbDRr?=
 =?utf-8?B?ZnpBS2NnNmR5dzVSQnlGT3dPem1jZDNhZStYK3JiYUFmaEtZcCt5UUdlQUho?=
 =?utf-8?B?RTVMeVFVZS9jYVg1U1dBNXQrdEV2YmY0QUJ1eGV3bitETlBxcmFrRHhXRVdQ?=
 =?utf-8?B?eHRMczJESDg0aDF4dFBsT3Vtck1TV0FFV21WcEE4RFJicmxxdE9JWVM3dUVy?=
 =?utf-8?B?Ly90eFlYNjBhYWZNS0ZxRGxTTlpjRmQzMUhrcEhxeE92Wk5xYUJuZm5OT3F0?=
 =?utf-8?B?QlNxanduQkJBV2xMcUZVZWRXZDhsUE14bk9UaEtLU25DT0JLNFFmdkNVcXE0?=
 =?utf-8?B?ZDVvNWV2b2xGS0dsNzdHZDl4T2xWS3hPZVV3d2VzV25pbXhqc081NUQ4dDV3?=
 =?utf-8?B?dmtWMWVQSitqODViZkI2OHplbEtsVjRaOXBsd3ZPUmtGVjM1OVdhUGpqQzRD?=
 =?utf-8?B?c0RSeEM0WTY4bU05UGNGSjdZaitRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 325378e3-a819-4cdd-38d9-08d9af595290
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 14:47:22.0763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VlSuGL/EW2Q/xl5VyOsxyEXjYtFBwN6Xj4Ye3HF04eQ5LtXqonwJtWajeMIYBdsWIpEyBuf5jtfxMynuKMNFWYtQaEXRqLBACloW5oYIryg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4682
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjQgTm92ZW1iZXIgMjAyMSAxNDowNSwgQW5kcmVqIFBpY2VqIHdyb3RlOg0KDQo+ID4gSSBk
b24ndCB1bmRlcnN0YW5kIHRoZSBuZWVkIGZvciB0aGlzIGNoYW5nZS4gV2hhdCBpcyB0aGlzIGZp
eGluZz8gQXMgSQ0KPiA+IHVuZGVyc3RhbmQgaXQgdGhlIHJlZ2lzdGVycyBpbiBxdWVzdGlvbiBh
cmVuJ3Qgdm9sYXRpbGUgc28gc2hvdWxkIHBlcnNpc3QuDQo+IA0KPiBTbyBiYXNpY2FsbHkgdGhp
cyB0d28gcGF0Y2hlcyB3ZXJlIG5lZWRlZCBiZWNhdXNlIHdlIG5lZWRlZCB0byBlbmFibGUNCj4g
aW50ZXJuYWwgTERPcyBieXBhc3MgbW9kZSBvbiB0aGUgaW14NiBhbmQgaW4gdGhlIHByb2Nlc3Mg
dGhpcyBQTUlDcyByZWdzDQo+IG5lZWRlZCB0byBiZSBzb21laG93IGFkanVzdGVkLCB3aGljaCBv
bmx5IHdvcmtlZCBpZiB0aGlzIHJlZ3Mgd2VyZQ0KPiBtYXJrZWQgYXMgdm9sYXRpbGUuIExvbmcg
c3Rvcnkgc2hvcnQsIHRoaXMgbWV0aG9kIHdhcyBvbmx5IGludHJvZHVjZWQgaW4NCj4gUGh5dGVj
J3MgdmVyc2lvbiBzbyB1cHN0cmVhbWluZyByZWFsbHkgZG9lc24ndCBtYWtlIG11Y2ggc2Vuc2Uu
DQo+IA0KPiBJIGFwb2xvZ2l6ZSBmb3IgYW55IGluY29udmVuaWVuY2UsIGJ1dCB0aGlzIHR3byBw
YXRjaGVzIHNvbWVob3cgc2xpcHBlZA0KPiB0aHJvdWdoIHRoZSBwcm9jZXNzIGFuZCBsYW5kZWQg
b24gdGhlICJzZW5kLXRvLXVwc3RyZWFtIiBsaXN0LiBJIGFsc28NCj4gdGFsa2VkIHdpdGggQFN0
ZWZhbiBSaWVhZG11ZWxsZXIgYW5kIGhlIGFncmVlZCB0aGF0IHRoaXMgdHdvIHBhdGNoZXMgY2Fu
DQo+IGJlIGRyb3BwZWQuDQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgdGltZS4NCg0KVGhhdCdzIG5v
IHByb2JsZW0gYW5kIHRoYW5rcyBmb3IgY2xhcmlmeWluZy4gV2l0aCByZWdtYXAgd3JpdGVzLCB1
bmxlc3MgdGhlDQp2YWx1ZSB5b3UncmUgd3JpdGluZyBpcyB0aGUgc2FtZSBhcyBpcyBpbiB0aGUg
Y2FjaGUgb3IgaXMgb3V0c2lkZSBvZiB0aGUgdmFsaWQNCnJhbmdlLCB0aGUgd3JpdGUgc2hvdWxk
IGdvIHRocm91Z2guIE9idmlvdXNseSBzb21ldGhpbmcgZWxzZSBhdCBwbGF5IGluIHRoYXQNCnBs
YXRmb3JtIHRob3VnaC4gOikNCg==
