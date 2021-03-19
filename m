Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25990341377
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 04:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhCSDbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 23:31:51 -0400
Received: from mail-eopbgr30045.outbound.protection.outlook.com ([40.107.3.45]:1377
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233358AbhCSDbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 23:31:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZLiEfH+9qaaU+CzFxJPJUROSxkQ2tEVNw9sgulVIXiWqHRQMCNRrJuxc6t+dtdBicgqQuYk587vSEsR2qyr8lo2TIM7iC/grSdzWVR/2Foh9FJQlaflWVpQpUFaRdONBv3yAsxIdSmuHztEmFIlaQsnSK5yI/B8nQOVI2wKspcP8r2GAK5S7szYWGRRz9AxjlGyIVGWxELN98HKxBfTYt5oXxhl7fHuwi8+8tMgEdyTJHWiFX7kn1jBsPhHsTMd+RxIAhVKYcD0pNbP9J+f2pYGKIRnR+WJsaFg8/M4XMxmmy6l7KiDeYDWe4AKa075GvO0yJ8mQhlvserG1a1wDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qS1xslb78aioK2eYYLaiehNwT/Y4AD+7qGmM/qxXJmE=;
 b=WYelPfBqHjIQFtepQc90Jwil3Sibm5yQuHKieH1rqSEVX84hAVkBwenbMgGTwgMOAuNNiikXYTUazW8sf3egoGUZ5UTMHe6f2oMn+OzSF2RZoMbu0NBN8YvjpneRtK5CrLQGu/s9yQAbS28lgjvr1RRslMhOMPJLvvtoicq1iDGtRAOgUB30ZCqbrV9c+WP+DmuWuGcfogkycbiEQG2i+rQc+acyMpJ23DV554U3KcCjG880pefAPOM0i0xrSFwuCckn6JFASuXpQ6Sz5MkSo0wLCGGInuOQ4anDVkT42iGEiz5ctf9pT1YM7hHWDli969j6n9IvRkwOgS0n6OzMQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qS1xslb78aioK2eYYLaiehNwT/Y4AD+7qGmM/qxXJmE=;
 b=pR/vKw+xOLQPlM0UfzpNqYia1We/gCWo6uzVHjnv1ypRuhriPhuLrRvLNU2ae+2qzu1lY2KqaiDY5bn1eX0JR/34u2+e8rC8R+LMmaCHRiH94J9E6R+5ZQw+eDe2TNPPGT8U8K/YPj5lfm0UQOITi5LKcL/Ouh/5FjKRhyhPrTc=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR0402MB3335.eurprd04.prod.outlook.com (2603:10a6:209:a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 19 Mar
 2021 03:31:40 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::ecad:ebb8:8eb0:d359]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::ecad:ebb8:8eb0:d359%7]) with mapi id 15.20.3955.023; Fri, 19 Mar 2021
 03:31:39 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
CC:     Ying Liu <victor.liu@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] firmware: imx: scu-pd: Update comments for single global
 power domain
Thread-Topic: [PATCH] firmware: imx: scu-pd: Update comments for single global
 power domain
Thread-Index: AQHXGxBWUMgDKePzUE67V1yDeFaFi6qKqT2g
Date:   Fri, 19 Mar 2021 03:31:39 +0000
Message-ID: <AM6PR04MB4966C6D0E08AB4C25B280CF480689@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <20210317093117.16091-1-ulf.hansson@linaro.org>
In-Reply-To: <20210317093117.16091-1-ulf.hansson@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d0ca17a8-25d2-4910-fb52-08d8ea878200
x-ms-traffictypediagnostic: AM6PR0402MB3335:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB3335991EA83D7C386AFD6FD280689@AM6PR0402MB3335.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /cosnciu8vPb3hcLc/pFuHohGnNQKxt7cUzUvI1kNkjgaP5pclwGITEDSijknn27tNR7BUQK8k8HsnIm72XL7ZM1URZwsBbyYaCOKwultODx7qzeS0FQbecrWMUAuSaNZeqm1GBzHqapdeqvOZwYf/eBjZldrpYViDZKflp3StbZxG/DPf3eOkvgo6lSNOipfGevM9Z8LqkLqfDszSLP35NPsxfoTvdgnbV2xOHrj+DiAOC5o04uen301d4ArIirrOb4s3vxORqN9ZA32zi0jHimO7O+aizBOqK5JBndEL4vgbqbsQ21a3dDArH+3RJIKZ3f5FgYJ9nidtMbXzvUBFx9rVFYkM1VSIEp97QzLuig0DHD4jbpuvN2vljsZhA5p/HBePRlmQUKZ/rQH91Hl700UbZSqG9dp5iyzitjsJFAutrQ4+TkHZDVOQRo3I3Cpo7ZTD8M6DhxEmYgG1yIWolVghcwHReN07OdSudpSIfKSPFfWkwlnMBJgRsTVgQi+r6KQxl+Q5jjPScjrXuuhLbx4fZBSaGB5BMn80GCW4/SjrCrbJLu7JiVyKUG/hcQvHluMK2Wz/jtAHL3/3HpVuNcQaDMzxVB6L79k4ijd2++q2+kCFJcO0dgkitUVYy8tID5Hu78vQJt4PL76MKWIcQ3/8iWiuu/MBNf7n9A4a0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(54906003)(76116006)(316002)(66446008)(478600001)(7696005)(110136005)(83380400001)(66946007)(86362001)(55016002)(44832011)(186003)(38100700001)(8676002)(8936002)(66556008)(6506007)(5660300002)(33656002)(26005)(2906002)(64756008)(71200400001)(9686003)(52536014)(15650500001)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VzRPOFloUFdlbEJRWHlGa0VMY3hlaWV5U2YxMk1xUThNN1R4ZDQveHBrOTI3?=
 =?utf-8?B?WXNwNWoxTVBLeldxcnJ6NFdTM2pDaVZSTHJmb1VXZjdtaDd2VkwvVkV4TGNM?=
 =?utf-8?B?ZzhDdmtNSnNzWFJkbS9haXBSRVNXdkR1TW5jNnFMeWI5VUFxZGNQdDJxTUxx?=
 =?utf-8?B?RXJTQ3hyZFg3THJ5MXJDS0Jxd09XMEhHZkVXcy8zWTFHbHJBeFJuckFOYnhv?=
 =?utf-8?B?bnMyYmp2VlU4NGoyNklMVCt2YVc2NVRnSVVDa250TWJxbDhhQTZZR1hoYmRT?=
 =?utf-8?B?MCt1b1FjajY0WVZMaEd0QkRNSXM3cXErMnFrSnBKUkN1ZjBNSVdUeDVKN0t6?=
 =?utf-8?B?bWRqY2x5SGNmdmlPcFdHamJEa2lMNGU3R0E2T3ZkNXFlZXZtQmpnMk01dzZY?=
 =?utf-8?B?RGoxRitvR1Y1SFlZU0Q2ZG9DZE4zVjFxS0dlNjJFcmIxUGs3TGxRTWhGbGlE?=
 =?utf-8?B?SkloVzVnampBVUlrOGgrdjBzYVVWeVJ2TmVhVUFITlJUSTV0UUhXNVd1Mys2?=
 =?utf-8?B?RWlvbzRNKzE0dngxNVl2VERiNVBuK1lyVlM4RzBVVzJtNzlrdGhIWDhMQ1Bk?=
 =?utf-8?B?WDNXbGFzazN6cEYvZmthWHZxcERSYkNWQVVnTW9OcURYTTJCckk1a0daUm5B?=
 =?utf-8?B?c3l3YXA1Qko2dWRrRXZHVlJscjRyQWN1ZkJQNHdjak9LaGlSRDRYQUxwREZS?=
 =?utf-8?B?ZmhmTzU2RXlOSlF5OVJIZXFDcFhDQWZsOEpiVWsrbG13VVMvRlBuODVodlN4?=
 =?utf-8?B?N0FHeEN6U3NnNnJFYklBOVZ0WWdNTllZVWJYRUoyVFlFRWc0aWJoWWFlb0F1?=
 =?utf-8?B?TlpzaGxGMThkTXZrSXh5Z0V2MXFBTUtwdnZ3emdqaG5ZbkNJMmtENXRwZ2R5?=
 =?utf-8?B?anJ3bnlybmtsY0g0TEN0SDFwKzFLemdDdU5MaFFxRFNEWU9ocTVXNDFjZ2FN?=
 =?utf-8?B?cmJkZkEydTFJcWFPY3ZHUWFLcGVHMGpPajFCOGhON25LaHU3MjVPakZJcTll?=
 =?utf-8?B?cEtUb3orazRvRGt6bUVmTW5uWEl0R1VsWEwyWDlBTlFBMFZBb3JaMjg5SWF2?=
 =?utf-8?B?cldoWlhUdjRkbmd1emZwcWpRZGYzNGdiZ2NJQTVVUDdLNlpvTmNHdGo0by91?=
 =?utf-8?B?cXo3bnFiaTJIaWo4RzdtOFF6SW9TOWtIdDdPSmdFK3ZDcGVlbmhOZVlHKzFG?=
 =?utf-8?B?aHdHUTVlUTRKajdOeWp1eWJlOFBkOW9ZNElpOVhJdXFNVStWRnlKWm1hZFBu?=
 =?utf-8?B?Q3dTc0ZKOTkzQ3FCZVhjVTlQVkN4YW9meXhKaEl1Mkd6Mmd1eDJnUmczRTIx?=
 =?utf-8?B?c3BiaWR3MjV3Y3lvNngxR3MxS1dlT3p5d2xiUy9UZEdVdUtiOG96VW90SkFm?=
 =?utf-8?B?Znl3UkVNc0hOU3duaW56Z095R1kxU1JPdFQ3VlliRkU4NXMzQlBRMjZDTzJ6?=
 =?utf-8?B?Q3N4cTdmN2VXdEhPUVZtVkJNUVdMNGl6YmgwYnFPUll0U3lqbkFPN28xTkh2?=
 =?utf-8?B?a1MzbmswN2ZEdXpNa1hXSzJSRGxLekhhYXZVbFl0RGFmdHBWUitaWmxtaDhv?=
 =?utf-8?B?MXc4aUh0SllIQ1J0bms1djgvRXJNWTh4Rk1YZ2cwT0ZTNWZmYy9RZS9KZFlm?=
 =?utf-8?B?TzB4cXFlWmFobXJoZ3psZ1UrRjdkRjJXaCs5RlJ2MVY1S1lPVkNJV2s2UURx?=
 =?utf-8?B?RUR5ck9jQ1BDM2FEMVRSbjFYaG1ZT0xmTjdUSFkrbm13cDFJRUFuZTNuNHEr?=
 =?utf-8?Q?wtsbS61v12JVRcLcbAexRQL7+W0mASpY5axoix8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ca17a8-25d2-4910-fb52-08d8ea878200
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 03:31:39.4439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2w6hZXjGvVhWtZL91TnEHamfb4YY7/4zql7b+KrZMUPYm8zeeXvzAEHr6SuhCNykJbo+et17tbdnAg4GsPIK+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3335
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVWxmLA0KDQo+IEZyb206IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0K
PiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDE3LCAyMDIxIDU6MzEgUE0NCj4gDQo+IFNpbmNlIHRo
ZSBpbnRyb2R1Y3Rpb24gb2YgdGhlIFBNIGRvbWFpbiBzdXBwb3J0IGZvciB0aGUgc2N1LXBkLCB0
aGUgZ2VucGQNCj4gZnJhbWV3b3JrIGhhcyBiZWVuIGNvbnRpbnVvdXNseSBpbXByb3ZlZC4gTW9y
ZSBwcmVjaW91c2x5LCB1c2luZyBhIHNpbmdsZQ0KPiBnbG9iYWwgcG93ZXIgZG9tYWluIGNhbiBx
dWl0ZSBlYXNpbHkgYmUgZGVwbG95ZWQgZm9yIGlteCBwbGF0Zm9ybXMuDQo+IA0KPiBUbyBhdm9p
ZCBjb25mdXNpb25zLCBsZXQncyB0aGVyZWZvcmUgbWFrZSBhbiB1cGRhdGUgdG8gdGhlIGNvbW1l
bnRzIGFib3V0DQo+IHRoZSBtaXNzaW5nIHBpZWNlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFVs
ZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KDQpUaGFua3MgZm9yIHRoZSB1cGRh
dGUuDQpSZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCg0K
QlRXLCBJJ20gc3RpbGwgdW5jZXJ0YWluIGlmIHRoZSBuZXcgYXBwcm9hY2ggY2FuIGZpbmFsbHkg
d29yayB3ZWxsIGZvciBpLk1YIGFzIFNDVSBQRA0KYWxzbyBzdXBwb3J0cyBtdWx0aXBsZSBsb3cg
cG93ZXIgc3RhdGUuDQpJIGNvdWxkIGludmVzdGlnYXRlIGl0IG1vcmUgd2hlbiBJIGFkZGluZyBt
dWx0aSBsb3cgcG93ZXIgc3RhdGVzIHN1cHBvcnQuDQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiAt
LS0NCj4gIGRyaXZlcnMvZmlybXdhcmUvaW14L3NjdS1wZC5jIHwgMTEgKysrKysrKysrLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9pbXgvc2N1LXBkLmMgYi9kcml2ZXJzL2Zpcm13
YXJlL2lteC9zY3UtcGQuYw0KPiBpbmRleCAwODUzM2VlNjc2MjYuLjZlMTc4YTYzNDQyZCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9maXJtd2FyZS9pbXgvc2N1LXBkLmMNCj4gKysrIGIvZHJpdmVy
cy9maXJtd2FyZS9pbXgvc2N1LXBkLmMNCj4gQEAgLTI5LDYgKzI5LDEwIEBADQo+ICAgKiAgICBU
aGUgZnJhbWV3b3JrIG5lZWRzIHNvbWUgcHJvcGVyIGV4dGVuc2lvbiB0byBzdXBwb3J0IG11bHRp
IHBvd2VyDQo+ICAgKiAgICBkb21haW4gY2FzZXMuDQo+ICAgKg0KPiArICogICAgVXBkYXRlOiBH
ZW5wZCBhc3NpZ25zIHRoZSAtPm9mX25vZGUgZm9yIHRoZSB2aXJ0dWFsIGRldmljZSBiZWZvcmUg
aXQNCj4gKyAqICAgIGludm9rZXMgLT5hdHRhY2hfZGV2KCkgY2FsbGJhY2ssIGhlbmNlIHBhcnNp
bmcgZm9yIGRldmljZSByZXNvdXJjZXMgdmlhDQo+ICsgKiAgICBEVCBzaG91bGQgd29yayBmaW5l
Lg0KPiArICoNCj4gICAqIDIuIEl0IGFsc28gYnJlYWtzIG1vc3Qgb2YgY3VycmVudCBkcml2ZXJz
IGFzIHRoZSBkcml2ZXIgcHJvYmUgc2VxdWVuY2UNCj4gICAqICAgIGJlaGF2aW9yIGNoYW5nZWQg
aWYgcmVtb3ZpbmcgLT5wb3dlcl9vbnxvZmYoKSBjYWxsYmFjayBhbmQgdXNlDQo+ICAgKiAgICAt
PnN0YXJ0KCkgYW5kIC0+c3RvcCgpIGluc3RlYWQuIGdlbnBkX2Rldl9wbV9hdHRhY2ggd2lsbCBv
bmx5IHBvd2VyDQo+IEBAIC0zOSw4ICs0MywxMSBAQA0KPiAgICogICAgZG9tYWluIGVuYWJsZWQg
d2lsbCB0cmlnZ2VyIGEgSFcgYWNjZXNzIGVycm9yLiBUaGF0IG1lYW5zIHdlIG5lZWQgZml4DQo+
ICAgKiAgICBtb3N0IGRyaXZlcnMgcHJvYmUgc2VxdWVuY2Ugd2l0aCBwcm9wZXIgcnVudGltZSBw
bS4NCj4gICAqDQo+IC0gKiBJbiBzdW1tYXJ5LCB3ZSBuZWVkIGZpeCBhYm92ZSB0d28gaXNzdWUg
YmVmb3JlIGJlaW5nIGFibGUgdG8gc3dpdGNoIHRvDQo+IC0gKiB0aGUgInNpbmdsZSBnbG9iYWwg
cG93ZXIgZG9tYWluIiB3YXkuDQo+ICsgKiAgICBVcGRhdGU6IFJ1bnRpbWUgUE0gc3VwcG9ydCBp
c24ndCBuZWNlc3NhcnkuIEluc3RlYWQsIHRoaXMgY2FuIGVhc2lseSBiZQ0KPiArICogICAgZml4
ZWQgaW4gZHJpdmVycyBieSBhZGRpbmcgYSBjYWxsIHRvIGRldl9wbV9kb21haW5fc3RhcnQoKSBk
dXJpbmcNCj4gcHJvYmUuDQo+ICsgKg0KPiArICogSW4gc3VtbWFyeSwgdGhlIHNlY29uZCBwYXJ0
IG5lZWRzIHRvIGJlIGFkZHJlc3NlZCB2aWEgbWlub3IgdXBkYXRlcw0KPiArIHRvIHRoZQ0KPiAr
ICogcmVsZXZhbnQgZHJpdmVycywgYmVmb3JlIHRoZSAic2luZ2xlIGdsb2JhbCBwb3dlciBkb21h
aW4iIG1vZGVsIGNhbiBiZQ0KPiB1c2VkLg0KPiAgICoNCj4gICAqLw0KPiANCj4gLS0NCj4gMi4y
NS4xDQoNCg==
