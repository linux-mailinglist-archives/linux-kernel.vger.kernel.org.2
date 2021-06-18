Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C433AC8FD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 12:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhFRKmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 06:42:43 -0400
Received: from mail-eopbgr1310083.outbound.protection.outlook.com ([40.107.131.83]:23225
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232317AbhFRKml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 06:42:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMw/uqJl1jzOr7TiexTWGarmumN4ZB8N94tPuGaUCirGoWg8TuR15WEnfs1K/0onoKK8p4l8mU3vefjGBekj6PoKMnIsUFI4uqDwuKijp7uSh0AqQ4qL7VmXVdQUhdOUVMVCh/A7kw8fyA6LBNdlSWHU0M5z16+YiHv0nDJ/n7PmPchzFEukIZnJpVcug6FCYlfw5Z1Siy0y+5/YNwIEgpJH0eSmHlONiLEAopvJbVFpsIWr+Hkvi1Odch/MGeO5AoV+RUumJTToCZ+vrIXfKNdcbbsJB3x7ys/wvP89WXBE5bKg6vjwO5rPEDC2LyT8Vqm4AOfhyI5FGp7CayzUYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QF6y8Ohvu4gpCs5xTybIOa7SHwNIgfobk+kzhWL214k=;
 b=mKaDc7Pz+Kpj5F2LE3dUtw+INabVFv/X4JfuQgmWRYdZ9DjRQWubRXKWNn09WWypYenw9nd/LSCyJgq7Nxh9fp+Nf6Xqc4b+jxQsFNLpE8fumZVPMKwOuioR1qDopNgPExMUDtssDJsg58Wte+Suqz8T0IUp4Zw60qLWw8nxOlbMOwtCwyNotieCB1Yz4a3gs38Bu0r5jQ20jF9eLdGXc+7Sg/qoNZtyZoaGuQmbRFj+k5dPqy9DWHoEiASavFC8Di4QY5R5Uo/88yV/UBLoPBqu0LNHbFCez0ejPOkLv9NuQugGFmteielQJ8Y70eWTRKmvDfnyp3NK5ArXj3UaYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QF6y8Ohvu4gpCs5xTybIOa7SHwNIgfobk+kzhWL214k=;
 b=FW9uPh3uKoczVwa5crCKafqtbDzcbIdkG5jC3Hq5RjjImtdUIy34b/wh3AlZxhhgu70B70gHnNMnN9mAT5Q8So9RsDX5gN9rSFyg3zIMFrl6YaPKc/s9lfmxYIBKSTvnqdsvQ+cPRONrTOBlJJMVASCq9r+r0Wj4pAiBBjYW8RY=
Received: from HK0PR02MB3154.apcprd02.prod.outlook.com (2603:1096:203:6b::15)
 by HK2PR0201MB2227.apcprd02.prod.outlook.com (2603:1096:202:6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 10:40:29 +0000
Received: from HK0PR02MB3154.apcprd02.prod.outlook.com
 ([fe80::850:c291:f53f:bacf]) by HK0PR02MB3154.apcprd02.prod.outlook.com
 ([fe80::850:c291:f53f:bacf%4]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 10:40:29 +0000
From:   =?gb2312?B?wfW6o8H6KER1Y2tCdUJlZSk=?= <liuhailong@oppo.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "arve@android.com" <arve@android.com>,
        "tkjos@android.com" <tkjos@android.com>,
        "maco@android.com" <maco@android.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "christian@brauner.io" <christian@brauner.io>,
        "hridya@google.com" <hridya@google.com>,
        "surenb@google.com" <surenb@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBzdGFnaW5nOiBhbmRyb2lkOiBhc2htZW06IGFkZCBz?=
 =?gb2312?Q?ize_field_in_procfs_fdinfo?=
Thread-Topic: [PATCH] staging: android: ashmem: add size field in procfs
 fdinfo
Thread-Index: AQHXZCdnjBtkQQZp306asXfx57gd1KsZj5wAgAADNpA=
Date:   Fri, 18 Jun 2021 10:40:28 +0000
Message-ID: <HK0PR02MB31546ACD1FE5BA96CB49B54BAF0D9@HK0PR02MB3154.apcprd02.prod.outlook.com>
References: <20210618095035.32410-1-liuhailong@oppo.com>
 <YMx0GIRQmpRC7pdQ@kroah.com>
In-Reply-To: <YMx0GIRQmpRC7pdQ@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=oppo.com;
x-originating-ip: [58.255.79.106]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2cb0f731-f651-45c2-fde7-08d932457d9b
x-ms-traffictypediagnostic: HK2PR0201MB2227:
x-microsoft-antispam-prvs: <HK2PR0201MB2227BEC72118EC09B2ECBBF2AF0D9@HK2PR0201MB2227.apcprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BRqCqASfGpQrQ5/CFbyXysfWTzkTmC579W/zXYA/fU3pjXGfvyxIL4ji1xI0cPfgaFYDhuuuDq2AqhqEPO6nyZwxiWq4pIGOVtHhyxHD1KkUoadDdqdXoAvtXJR4OrUoeQxfNLy2KwfyYbXZCqcLXmmaKSIbvFActHInSt99Ae6uGLr2xfR+/4aRm4DRJH31Ds8z/NN09vaW5d1Lg7FZCOQ+scGA/sutvcBArKdXCpeuWC8bFlaMBz90jKfMDSbTzA5cwWyKquzlIT0JIdPBtiqr0lCz7lRbwoUGuj9uGG0RWG2mRrTkJQZImBVlIw9iIgwjpCM9CQCIEZ2weYVhD50w/+UGgZqT7fvVusNxWXhgIHYgrP/X6inyaD/+Yd8Gc3e6gtQ1XzoB7l+oBzE0tXFupjl8wM5UPP/aGddVMjOzb+ToZbpS+rtw3YHzYVHyqgP0jCVkqh6EdJqmyNyn8R7YETViTz9qHvFl+1YYX8fFr4d0O362wrJQEqs9MVVhtap4Dlqb3V9odZG1wIzXfVb0mfImZmLsV631hWtI/3AOVPJgKt0S6mIeRFSNUwnH9nIEZlg6YDRQi33Begqxvc7XotPkDuXqZZIyjVSyskdKUHUeraKMljSU12Q1iUEzxVaRKBv816iO1XqixBwTwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR02MB3154.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(5660300002)(54906003)(224303003)(52536014)(64756008)(7696005)(66476007)(9686003)(4326008)(76116006)(71200400001)(316002)(66446008)(66556008)(66946007)(8936002)(33656002)(6916009)(83380400001)(85182001)(38100700002)(7416002)(122000001)(6506007)(2906002)(55016002)(86362001)(186003)(26005)(478600001)(11606007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eVQyRjkvVjdvY1NSNDM1NWdmUk54dXdjeS9UaUNoNEZjUnM3dDNuZWZWOUh4?=
 =?gb2312?B?MnFCQk5uWUllMjczbnFnbVVvVlQyQzJxd0xJSXAwSTY2dzVrc3drc0tVaXU5?=
 =?gb2312?B?WjVsTlVUeWg3RFNHYmNSUmZGemxlcm5Gd0JyRERkMGdsUXdBMm5JdTA1dXpy?=
 =?gb2312?B?dDhNTVJEKzRGTUVjZUhVV29mTG8rYWY1d1l2VFdVU25nR2poSXpOcEU3UGlG?=
 =?gb2312?B?b1g1dHd2bUZiWHlRNTlOc09nLzdZRkY1bTNYa2FsVHN5NDVBWFNqMlluZnNO?=
 =?gb2312?B?am9nSnRGWlRPRkZOVVAxUGdMb1k4M1ZLOFhiSHgwd2RhRHFSV2NDaGZ0bUN6?=
 =?gb2312?B?MmcxQVVUelhBQmtiT0VyVnVmZlVtTGVsR1poZWdOWkUweGlnMnhyN2ZjRHNE?=
 =?gb2312?B?Z2s4VFppYlN0T09ab3dDVm96enN6c3RiNXNGOFZ1UCt4V2tCOWRiWkRkQ3Q2?=
 =?gb2312?B?NjBjeFNkdFpRRFRNUDlhTDVMZzVlUW1wZU1XRjc3aHc1UEJCbVZzNk5hZ2ln?=
 =?gb2312?B?V1htMEVDOWo4MUEzV1pBUTlwREl3VWtNT2x6ajFlY2VxZzJvTi9zVnhtcjZ4?=
 =?gb2312?B?OThvK0xJd0hrN2Q3aW0vYTZ0bldKQXJSN0JWY2QvclBqb0dXeXRPcjZiQ1JO?=
 =?gb2312?B?bTRZRVkvS250VzcrenYyN3ZwZXVGMWhqSGtYNVlXOEJSeXQ2SUpQa3RoWXB1?=
 =?gb2312?B?cFpLT2ZWUU1ENUo2eXlaL3RoaEhCUW11NlMxSng5MWVnRVVKaURvN2JCWGZF?=
 =?gb2312?B?T0tHNUN1YkNPRmJBUWpCVXF1anNpV3Q0RVFsUDNyREtVRzM3VGszQ291U05Q?=
 =?gb2312?B?SWlLWWhUSW9OUm5VaTBEejlmZjZhbld1YWJDRTA4V01mc1lBSXdjbzZnd1pM?=
 =?gb2312?B?U0JDQitGR1kxeXhnWTRKY1lxKzR1b3lqUFI4TWFpbGs1TnlxYjY4MWlOaUJG?=
 =?gb2312?B?ODhpcS80SFl2dWlCN0RoNVdSU2xqNDd0WnRKYVFNdjg5OXVkTmlGRWNjVnVK?=
 =?gb2312?B?aGpwdUNrZS9pU3diVFU5UDJ6REpvTnVwNTdrNzUydUFuNERWV3grdXk3U3d2?=
 =?gb2312?B?SHA0bHUzUUVwTEhNOHRFcWNPNFRGck1EMllHNVcvK01DMUJYOXBRQU9SWEpI?=
 =?gb2312?B?WkxEd3lqNCtMYjVMUitEV05KMGZ1WkpQQUdSaTVIbGQ0M3J1bzd6ZUM1NmZX?=
 =?gb2312?B?L0ZOU2tScDBNeWFBbG1GWlZwSFFXM0JFMVBlRnlUdmU4S25JQnpzWk5WR1NJ?=
 =?gb2312?B?Z285VmJ3YkQrNTB2VFQwSmpCc3FCMHV2ZXQ5QzRhVFlkOWNBNnlkaStUVzFa?=
 =?gb2312?B?RWJLMVE3TVU0TTJYMHJUTFdOWEQ4VWxNdWp6UjBtMXp6UndZQ1VIWXpTaXVs?=
 =?gb2312?B?RnByQ3ZlVkpQbzBiMTJ2akUzaHpzOFVzM0dSMXJCeWd2aUJtOThhSkVGUVBZ?=
 =?gb2312?B?V1VrS0NHc0FJbWZsK3JtVTNHOEJZQUtyeDNnRHowY2dSdkhyRzRYVyt2T1Mv?=
 =?gb2312?B?Y1VoRUoxM05WWjJzdXFOcG9TSFVERHU5V25jem5hUjhyQW5ZdmFvbGE2QldD?=
 =?gb2312?B?VE02K2RUa0tXWENYMG12ci9JOGlybnR2RHU3ak1uc2lBWjZuMFpjMTJaQyt4?=
 =?gb2312?B?aFYzcFZ0YnQ5SFpMM1ZFVHRSMFpCRm96QzAxL1FSUDkwT05ITWwzYTFUdXVN?=
 =?gb2312?B?NmdpazZCOHFxdW1ibXdlQTRLdHRCaG9IZXA3TmpEOUxYcUxGYXh0b2sxeXgx?=
 =?gb2312?Q?uo0N0ckm/CeyHNMtSA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR02MB3154.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb0f731-f651-45c2-fde7-08d932457d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2021 10:40:28.9903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vzUNFFRxC0Qu60PWmyxZ1HDif4/xT6ggZhLmpbPljWNLDg7xMmG0sytXJeG+8AonZq4tzzCtWlUOc41glhyqpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0201MB2227
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgDQpObyB1c2VyIHRvb2xzIHVzZSB0aGlzIHByb2MgZmlsZSBhcyBJIGtub3csIEkgYWRkZWQg
dGhpcyBsaW5lIGNhbiBoZWxwIHVzZXIgbG9jYXRlIHNobWVtIGxlYWsgaXNzdWUuDQoNCnRrcw0K
DQotLS0tLdPKvP7Urbz+LS0tLS0NCreivP7IyzogR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRh
dGlvbi5vcmc+IA0Kt6LLzcqxvOQ6IDIwMjHE6jbUwjE4yNUgMTg6MjMNCsrVvP7IyzogwfW6o8H6
KER1Y2tCdUJlZSkgPGxpdWhhaWxvbmdAb3Bwby5jb20+DQqzrcvNOiBhcnZlQGFuZHJvaWQuY29t
OyB0a2pvc0BhbmRyb2lkLmNvbTsgbWFjb0BhbmRyb2lkLmNvbTsgam9lbEBqb2VsZmVybmFuZGVz
Lm9yZzsgY2hyaXN0aWFuQGJyYXVuZXIuaW87IGhyaWR5YUBnb29nbGUuY29tOyBzdXJlbmJAZ29v
Z2xlLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtc3RhZ2luZ0BsaXN0
cy5saW51eC5kZXYNCtb3zOI6IFJlOiBbUEFUQ0hdIHN0YWdpbmc6IGFuZHJvaWQ6IGFzaG1lbTog
YWRkIHNpemUgZmllbGQgaW4gcHJvY2ZzIGZkaW5mbw0KDQpPbiBGcmksIEp1biAxOCwgMjAyMSBh
dCAwNTo1MDozNVBNICswODAwLCBsaXVoYWlsb25nIHdyb3RlOg0KPiBhZGQgdGhpcyBpbmZvcm1h
dGlvbiB0byBoZWxwIHVzZXIgdG8gZmluZCBhc2htZW0gcHJvYmxlbS4NCj4gDQo+IGFzaG1lbSBs
ZWFrIHNjZW5hcmlvOg0KPiAtMDAwfGZkID0gYXNobWVtX2NyZWF0ZV9yZWdpb24NCj4gLTAwMXxt
bWFwIGFuZCBwYWdlZmF1bHQNCj4gLTAwMnxtdW5tYXANCj4gLTAwM3xmb3JnZXQgY2xvc2UoZmQp
IDwtLS0tIHdoaWNoIGxlYWQgdG8gYXNobWVtIGxlYWsNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IGxp
dWhhaWxvbmcgPGxpdWhhaWxvbmdAb3Bwby5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9zdGFnaW5n
L2FuZHJvaWQvYXNobWVtLmMgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2FuZHJvaWQvYXNobWVtLmMg
DQo+IGIvZHJpdmVycy9zdGFnaW5nL2FuZHJvaWQvYXNobWVtLmMNCj4gaW5kZXggZDY2YTY0ZTQy
MjczLi5lZTJmZDc1MTExZDggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3RhZ2luZy9hbmRyb2lk
L2FzaG1lbS5jDQo+ICsrKyBiL2RyaXZlcnMvc3RhZ2luZy9hbmRyb2lkL2FzaG1lbS5jDQo+IEBA
IC04OTQsNiArODk0LDggQEAgc3RhdGljIHZvaWQgYXNobWVtX3Nob3dfZmRpbmZvKHN0cnVjdCBz
ZXFfZmlsZSAqbSwgc3RydWN0IGZpbGUgKmZpbGUpDQo+ICAJCXNlcV9wcmludGYobSwgIm5hbWU6
XHQlc1xuIiwNCj4gIAkJCSAgIGFzbWEtPm5hbWUgKyBBU0hNRU1fTkFNRV9QUkVGSVhfTEVOKTsN
Cj4gIA0KPiArCXNlcV9wcmludGYobSwgInNpemU6XHQlenVcbiIsIGFzbWEtPnNpemUpOw0KPiAr
DQo+ICAJbXV0ZXhfdW5sb2NrKCZhc2htZW1fbXV0ZXgpOw0KPiAgfQ0KPiAgI2VuZGlmDQo+IC0t
DQo+IDIuMzAuMg0KPiANCj4gDQoNCkFzIHlvdSBhcmUgY2hhbmdpbmcgYSB1c2VyLWZhY2luZyBw
cm9jIGZpbGUsIHdoYXQgdG9vbHMgd2lsbCBicmVhayBub3cgdGhhdCB5b3UgaGF2ZSBhZGRlZCBh
IG5ldyBsaW5lPw0KDQpXaGF0IHRvb2xzIGRvIHlvdSB1c2UgdG8gbG9vayBhdCB0aGlzIGZpbGUg
YW5kIHdoYXQgaGFzIGJlZW4gbW9kaWZpZWQgdG8gaGFuZGxlIHRoZSBjaGFuZ2U/DQoNCnRoYW5r
cywNCg0KZ3JlZyBrLWgNCg==
