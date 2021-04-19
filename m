Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12200364A32
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 21:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241241AbhDSTAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 15:00:54 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:59030 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230295AbhDSTAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 15:00:47 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EA656C06C2;
        Mon, 19 Apr 2021 19:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618858817; bh=tjUlcu8sMd7DyC6z2kaYxXkUw6dmA5jywQ/dLibBR3g=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=mQzd3yMfiHyEqfQobU+WCSxjvFTyRSTPWWHm8389yMgf2XQKvmE15ti9yjJ94NJaS
         Sr0+2oDx2RGaInSfRtjmxSnYBvX9ajq7PPNrHEINNzljRAxD0vfUoEOLb4gYOolWdK
         jAdcD6Mz4QPxFlawaQpRf3yxlL3PWI1Qj9HIkRv8UFG5lM6C+Y902zfMyf4XKJT+Fe
         +qlYcyMaL3UBAddqnRunMGdGPMr87nKSLy9f0Qe3mNS9WLkwgZPxAVy/eXmtK6bxVI
         zz7FJB/ztrKylULpzhlYlSeEurlC3QtKdv822dIIjng/+sr6nvg9KCOzIiGA82qlCc
         8Nt2fcFKK+zUw==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 93549A0075;
        Mon, 19 Apr 2021 19:00:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id DF0AD40133;
        Mon, 19 Apr 2021 19:00:15 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Rg872VRg";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fw27Jdg+g1MLqCKTzja/9AlK/vX4c8s6HZDWvX3mm2O+s9lVuLytKJUQiLJzxwSXXtDJMr6QyacOS29eWZKa4r4DH/QzQ27mC1XY3l725c00k9nSzmkUWuI/hdh9fBDSo7Y5tMYYHPoxhLJFMyex6MEjbzyPHuTFJjJpwBN1tSLyCei0rDyIKd/CJAhJ2ySSwXb36nTmMkp3eXCuaEw+jKPpicdfvg12TWaJABDfRz12wNHC9GQON0SiEz94iFH9eFm9FSgd+uj7mCGD91Z1pYwfMbweJAXl5b0e9eTdG5XSD4SpW3I8ZZPvUJyaJRtdIYwHclMEdzjmjjOnANawQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjUlcu8sMd7DyC6z2kaYxXkUw6dmA5jywQ/dLibBR3g=;
 b=CWXP13nBHOU8AvniXLoNYszomLJ0Rpfyup95j0BVS5EOhzc8EzQJdigRM2anI5QofXznxXuuKtLcdDwlcCoeeaQwUdsRfUmbWTIc11aREdv6qv/VqJPyde143nW+5DUM2gc0oxHgzJUJanxq/n0EuN5JZB7IHcq8dQ3UY0F5usM26G5+BTM+DZQdmNHOHOtKeGiQ/aIaNRSOFkWCRAzUacGUn9eGnOOM9jpNsoEWf/LpxPaEA9yIOd0pfDT2k9OsvkySuystZv3WNQ3SheaLbvNXO7KZy1aBR9ddv9hn2KgIhmb8mbNLGXkYXzafMSzkQqSmbd3TqPDCC5K8hcCB5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjUlcu8sMd7DyC6z2kaYxXkUw6dmA5jywQ/dLibBR3g=;
 b=Rg872VRgXrYboCoXSY7PJqIGQl70/3RjipSkU1x9kgHSJRkx1d4jfto9j1GrgQd/81ZblAlyuRJF5QTizkOZOpOHyqdnE0HF8qsT9iHkl9TOdbEuZSueNmprPilPjQ2t2T3vPzftdiTQSXqhho8gqhLp16oWZ0nZN/wpXV/UCzE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB2854.namprd12.prod.outlook.com (2603:10b6:a03:135::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Mon, 19 Apr
 2021 19:00:14 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c%6]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 19:00:14 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH] usb: dwc3: gadget: Avoid canceling current request for
 queuing error
Thread-Topic: [PATCH] usb: dwc3: gadget: Avoid canceling current request for
 queuing error
Thread-Index: AQHXMX21njNOe3FucUqaGApnopX6p6q1HZsAgAC/NYCAAAMrAIAAGCiAgAY7hwCAAAXRgA==
Date:   Mon, 19 Apr 2021 19:00:13 +0000
Message-ID: <dad2e218-ad43-3086-d8b8-a1aff08140f3@synopsys.com>
References: <1618439388-20427-1-git-send-email-wcheng@codeaurora.org>
 <87mtu0njvj.fsf@kernel.org>
 <677afbd3-6c72-29c0-ca25-88dd1bff335a@codeaurora.org>
 <2e956314-b3e1-5c0e-104a-7416cf81f3ba@synopsys.com>
 <4c2c6d76-e4d5-67f5-d91c-7e402b0828f7@synopsys.com>
 <ab660f3f-9275-8f82-7c37-cb2a41eb7c3f@codeaurora.org>
In-Reply-To: <ab660f3f-9275-8f82-7c37-cb2a41eb7c3f@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2aa1e7e-05a9-4be8-89e1-08d903655d38
x-ms-traffictypediagnostic: BYAPR12MB2854:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2854CAC03CE98857000A01A6AA499@BYAPR12MB2854.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o7C19jgcxzreZVOVzqAVfl5KgCjyZmUdHLbTN75vW/LCqVdJ49MUALFiQb1Mxa48gJZA8Gk3QqKjhv8DyRbb22zQpEYXjrjXHNwJO0DRljnwfBX0ecDYfl4Kv8uJ+STW4y4xmc6KWjY1+knZJjtJf1MTiM2r1JjJBQgYdVvDolsOMaQL6seRkrijWuFg5Mm+T4oIKlfRrF4DnqkqsyhPkbtnuXRNJPwMktMguRp+viqhc6QliSJwgEyYCy21V7y8pNYbXewRr17qO+3RS0VvcmhzWCHGuWXwUFfa/L5IxWgb6NTknIHTxK4aB0SntUMiHy+emj2P93t0hv6vQiGsefS3FNx2pSYsqyBieNTbZ3m8vkSlkLObcceWsWK2ZCIxk9HC0cDlhX7R9dgwKTt8Cvb99QjXkwvN+nA1ox5avMEMdo0ZtKlb02nEVGEEP4AKA452FT3oanx2+qUHHXKdFRmtnTzhNrDKx2RdrIMXE0SVLamZ8JhKZ6+XefoMVIaCvErPu4anxDzHMH+fe9USFQDEcZNUkA/JmAtYOezvy0yRJibBBPRiWpIJzy0v5u/I81HSGqHf8L+qb3OsKA/bAbu5F0LvsYH4a/KcEEW+1Gg80qmsWHZ8RHEOLvVe3aWYK6VwA/6F8KgrMfh/I94dSCubpE5HoVngnmjL4TFtiSDHWx9S8ZlLE9b/4/LJ8JWG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(396003)(39860400002)(346002)(122000001)(31686004)(86362001)(36756003)(66946007)(66476007)(478600001)(66556008)(31696002)(66446008)(2616005)(26005)(64756008)(54906003)(71200400001)(2906002)(186003)(8936002)(38100700002)(110136005)(4326008)(53546011)(8676002)(83380400001)(6512007)(6506007)(6486002)(5660300002)(316002)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?T3hVSUJjQnVvRXNjUVV2cXBVOTd2L1NSUnNxQU1Cbld1WHVMQ0lJaUFJWFVW?=
 =?utf-8?B?UVV0OG5uVFdoSjlLR2tDSjFPamlmUzNYZXRSMTZsMzNqbGhGbzNpRFZybnpO?=
 =?utf-8?B?MUo4YjBSV2pBdXZVSmZzU1ErNzcySThWcFZUSDltYkFCaHNPM1JBdU0zaysv?=
 =?utf-8?B?OW1qU0syd3oyTmMwQ0dPZWJxTEtxa0ZjejZGMEZXYWpuVm1CWDBLRFVaK1ov?=
 =?utf-8?B?T0I3TXQrcTU2a25TYU56Y0N4VG5LZnRoeFU2YnNuQ1g0MTArOGNGUUZvUnV5?=
 =?utf-8?B?VUlQYnJHYmk1RFN3NGxMZUFnLzQ1MlVwcWFyVCsrck1YYzZuWXc3TTNiWm9a?=
 =?utf-8?B?OS9rZWI5alpBV3UzQmpoVExVaHdiRzh3UjM4V2Z4Qy8zQWtjbWtJRkttdVM1?=
 =?utf-8?B?Q2RSNG1ndXdvRlppUE5PRWFxSUdHa2FTUFpMWDRIWlNFS0NENW1penNiN3Fu?=
 =?utf-8?B?WVVOWjA3aEszVktxSUdUd3l3VG43NFBkbk95VlgxUkJURERVQWlVald4akZH?=
 =?utf-8?B?WjhmSmFCaEt3YVFyZ1ZDUTNsQXBjZ2dDVjIrYmdEU253cG9zSjAyWVoraXhv?=
 =?utf-8?B?cnkvNFVsK0hibUpsQ0FFQityNVh2V3ZZZHYxTWs2K2dhUjhLczUrUlRrdmRU?=
 =?utf-8?B?dUNpK2VJanVCbzl4ZzJUaGlNdUphbWFxcEc2Q093WTNoZ2c1MjNhZ2VuQWNx?=
 =?utf-8?B?SW9leTVBWHRqZ051d3A5Q09qMHpuaTFPeEJ1S29lRDRxV0NhKytRN1Iwcmd5?=
 =?utf-8?B?ZEpGM1RLZTRqRVNyOUg5OFM1MjhVN2kxMkl0R3Q3VGlKbGNMcDRJQWZ3TUwx?=
 =?utf-8?B?MDdrOVBVQlVjSk1oMVMyMjV0T3RuZC8xTGlYVzVaQWFKdjNsalNXckhWZmZv?=
 =?utf-8?B?bkFITGlsendtQ2VMdUN4b0s1NEVoRk9LR21icVEySTQzUWRKWVFyMVIzQ1NP?=
 =?utf-8?B?U2RFU0M1ekZTWDd3OElxbUt2bmpsYmNzSHhEdFp1K2hycHZCOEZucXRVRldz?=
 =?utf-8?B?dXRvK2VLMVo5VkpFRDVjazF3M3VadzFKcjN5M21UeVZGVkpKUTVrRmNPNjNC?=
 =?utf-8?B?YTUvOG9QbSs1QWh1SjlZK2hqZW1aWmdVcGFQNk1hSzhZRnVHODJUbDJHeUVZ?=
 =?utf-8?B?c0M5RjlaRWJNbGtZSURvRkxpVFZqbUYwT1o0SzZUZlVxOUo4eWcyNkNMd09P?=
 =?utf-8?B?UGxIbloyM3M1aWpXY0E2d2hOYWgrOWJpVTUxelVkajl4TG84N0tjenJGMThy?=
 =?utf-8?B?OUVWTlJLNEN0b2UwM3gzaUUwKzdYYStzS3UwalBMNVYzOTluZko4VHI2cCtl?=
 =?utf-8?B?Y0NVdUhUMVhlNjVZK3ZEOC9uNWRZRXQwMXBudU9QSzU4TDlyd3h6anIvWGNt?=
 =?utf-8?B?SmpZOVZZVnZFRkhmdlduUzRUd2tFTkVrUnY4cWlEZTNsNURUU01zVHkyRmpj?=
 =?utf-8?B?YUZPSEV0aU94UjBNR0Q3R1R2bXhSaHVIWGhNWVV0dmdNbEdOTVQ4MjFrbGJ5?=
 =?utf-8?B?aDIxZ0wybHJCRkY5UXBSUmYydXRIOXVERlBTRFY2TXF1OFJUN1Z1NGpSWE16?=
 =?utf-8?B?WDhBWWVDRjRRbVRRQWdvTGdSdjNwLzhkZytxUFFzekY2Rk11Mm5POHFIM3Bw?=
 =?utf-8?B?ZE1sc2V0M3l1QjEyRmN2ek9UOVozZmtiN0Nmb1k1emtCR2xHa0VyT3ZmWm5C?=
 =?utf-8?B?cERWaUVuaXk4bGpVOCt3YkNvaHQzUHdYQkZDUDJkMnhXNDkyU0xTUDdiZlhj?=
 =?utf-8?Q?oO0Y61Om/yB4cBPFZY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D3C12556576EB41BD4410674474A399@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2aa1e7e-05a9-4be8-89e1-08d903655d38
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 19:00:13.9842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqSUy1ZeyAmWN53UyLnNyAB/yMX9bc2u7dsY5/jM+RtP6rp2QtNPcMXu6vzFZkOsv/vXMXaM8UInh8JEZdjhmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2854
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPiANCj4gDQo+IE9uIDQvMTUvMjAyMSAxMjoyOCBQTSwgVGhp
bmggTmd1eWVuIHdyb3RlOg0KPj4gVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4+IFdlc2xleSBDaGVu
ZyB3cm90ZToNCj4+Pj4NCj4+Pj4NCj4+Pj4gT24gNC8xNC8yMDIxIDExOjI2IFBNLCBGZWxpcGUg
QmFsYmkgd3JvdGU6DQo+Pj4+PiBXZXNsZXkgQ2hlbmcgPHdjaGVuZ0Bjb2RlYXVyb3JhLm9yZz4g
d3JpdGVzOg0KPj4+Pj4NCj4+Pj4+PiBJZiBhbiBlcnJvciBpcyByZWNlaXZlZCB3aGVuIGlzc3Vp
bmcgYSBzdGFydCBvciB1cGRhdGUgdHJhbnNmZXINCj4+Pj4+PiBjb21tYW5kLCB0aGUgZXJyb3Ig
aGFuZGxlciB3aWxsIHN0b3AgYWxsIGFjdGl2ZSByZXF1ZXN0cyAoaW5jbHVkaW5nDQo+Pj4+Pj4g
dGhlIGN1cnJlbnQgVVNCIHJlcXVlc3QpLCBhbmQgY2FsbCBkd2MzX2dhZGdldF9naXZlYmFjaygp
IHRvIG5vdGlmeQ0KPj4+Pj4+IGZ1bmN0aW9uIGRyaXZlcnMgb2YgdGhlIHJlcXVlc3RzIHdoaWNo
IGhhdmUgYmVlbiBzdG9wcGVkLiAgQXZvaWQNCj4+Pj4+PiBoYXZpbmcgdG8gY2FuY2VsIHRoZSBj
dXJyZW50IHJlcXVlc3Qgd2hpY2ggaXMgdHJ5aW5nIHRvIGJlIHF1ZXVlZCwgYXMNCj4+Pj4+PiB0
aGUgZnVuY3Rpb24gZHJpdmVyIHdpbGwgaGFuZGxlIHRoZSBFUCBxdWV1ZSBlcnJvciBhY2NvcmRp
bmdseS4NCj4+Pj4+PiBTaW1wbHkgdW5tYXAgdGhlIHJlcXVlc3QgYXMgaXQgd2FzIGRvbmUgYmVm
b3JlLCBhbmQgYWxsb3cgcHJldmlvdXNseQ0KPj4+Pj4+IHN0YXJ0ZWQgdHJhbnNmZXJzIHRvIGJl
IGNsZWFuZWQgdXAuDQo+Pj4+Pj4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBXZXNsZXkgQ2hlbmcg
PHdjaGVuZ0Bjb2RlYXVyb3JhLm9yZz4NCj4+Pj4+PiAtLS0NCj4+Pj4+PiAgZHJpdmVycy91c2Iv
ZHdjMy9nYWRnZXQuYyB8IDUgKysrKysNCj4+Pj4+PiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKQ0KPj4+Pj4+DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2Fk
Z2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+Pj4+Pj4gaW5kZXggZTFiMDRjOTcu
LjQyMDA3NzUgMTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0K
Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4+Pj4+PiBAQCAtMTM5OSw2
ICsxMzk5LDExIEBAIHN0YXRpYyBpbnQgX19kd2MzX2dhZGdldF9raWNrX3RyYW5zZmVyKHN0cnVj
dCBkd2MzX2VwICpkZXApDQo+Pj4+Pj4gIAkJaWYgKHJldCA9PSAtRUFHQUlOKQ0KPj4+Pj4+ICAJ
CQlyZXR1cm4gcmV0Ow0KPj4+Pj4+ICANCj4+Pj4+PiArCQkvKiBBdm9pZCBjYW5jZWxpbmcgY3Vy
cmVudCByZXF1ZXN0LCBhcyBpdCBoYXMgbm90IGJlZW4gc3RhcnRlZCAqLw0KPj4+Pj4+ICsJCWlm
IChyZXEtPnRyYikNCj4+Pj4+PiArCQkJbWVtc2V0KHJlcS0+dHJiLCAwLCBzaXplb2Yoc3RydWN0
IGR3YzNfdHJiKSk7DQo+Pj4+Pg0KPj4+Pj4gd2UgZG9uJ3QgbmVlZCBhIGZ1bGwgbWVtc2V0LiBJ
IHRoaW5rIGVuc3VyaW5nIEhXTyBiaXQgaXMgemVybyBpcyBlbm91Z2guDQo+Pj4+Pg0KPj4+PiBI
aSBGZWxpcGUsDQo+Pj4+DQo+Pj4+IFRoYW5rcyBmb3IgdGhlIGlucHV0L3Jldmlldywgd2lsbCBt
YWtlIHRoaXMgY2hhbmdlIHRvIGp1c3QgY2xlYXIgdGhlIEhXTy4NCj4+Pj4NCj4+Pg0KPj4+IE1h
a2Ugc3VyZSB0byBpbmNyZW1lbnQgdGhlIGRlcXVldWUgcG9pbnRlciBhbHNvLiBJIHRoaW5rIHlv
dSBjYW4gdXNlDQo+Pj4gZHdjM19nYWRnZXRfZXBfc2tpcF90cmJzKCkuDQo+Pj4NCj4+DQo+PiBO
ZXZlcm1pbmQuIFRoZXJlIG1heWJlIGEgcHJvYmxlbSB3aXRoIHVzaW5nIGR3YzNfZ2FkZ2V0X2Vw
X3NraXBfdHJicygpLg0KPj4NCj4+IFRoaW5oDQo+Pg0KPiBIaSBUaGluaCwNCj4gDQo+IFRoYW5r
IHlvdSBmb3IgeW91ciBpbnB1dC4gIEluIHRoaXMgY2FzZSAoaWYga2ljayB0cmFuc2ZlciBmYWls
cyB3LyBhbg0KPiBlcnJvciksIHdvdWxkIHdlIHN0aWxsIG5lZWQgdG8gbWVzcyB3aXRoIHRoZSBl
bnF1ZXVlL2RlcXVldWUgcG9pbnRlcnM/DQo+IE5vdCBzdXJlIGlmIG15IGFzc3VtcHRpb24gaXMg
Y29ycmVjdCwgYnV0IHRoZSBUUkIgd291bGRuJ3QgaGF2ZSBiZWVuDQo+IHN0YXJ0ZWQsIHNvIHdl
IGNhbiB1c2UgdGhlIHNhbWUgKGZhaWxlZCkgVFJCIGZvciBmdXR1cmUgcmVxdWVzdHMsIHJpZ2h0
Pw0KPiANCj4gSSB0aGluayBvbmUgdGhpbmcgSSB3aWxsIG5lZWQgdG8gdXBkYXRlIGlzIHRvIGxv
b3AgdGhyb3VnaCBudW1fdHJicyBhbmQNCj4gY2xlYXIgYWxsIEhXTyBiaXRzIGlmIHRoZSBhYm92
ZSBpcyBub3QgbmVlZGVkLg0KPiANCg0KTm8uIFdlIHRyYWNrIGFuZCBpbmNyZW1lbnQgdGhlIFRS
QiBlbnF1ZXVlIGNvdW50ZXIgd2hlbmV2ZXIgd2UgcHJlcGFyZWQNCm9uZS4gV2hhdCB5b3UgbmVl
ZCB0byBkbyBpcyB0aGUgb3Bwb3NpdGUgYXMgZHdjM19nYWRnZXRfZXBfc2tpcF90cmJzKCkuDQpZ
b3UnZCBuZWVkIHRvIGRlY3JlbWVudCB0aGUgZW5xdWV1ZSBjb3VudGVyIG9mIGFsbCB0aGUgVFJC
IHByZXBhcmVkIGJ5DQp0aGUgcmVxdWVzdC4NCg0KTm90IGV2ZXJ5IHJlcXVlc3QgaXMgdGhlIHNh
bWUsIGFuZCB3ZSBzaG91bGRuJ3QgcmVseSBvbiB0aGUgZnVuY3Rpb24NCmRyaXZlciBiZWhhdmlv
ciB0byByZXVzZS9yZXN1Ym1pdCB0aGUgc2FtZSByZXF1ZXN0Lg0KDQpBbHNvLCB3ZSB1c2UgX19k
d2MzX2dhZGdldF9raWNrX3RyYW5zZmVyKCkgZXZlcnl3aGVyZSBhbmQgbm90IGp1c3Qgd2hlbg0K
cXVldWluZyBuZXcgcmVxdWVzdC4gTWFrZSBzdXJlIHRoYXQgeW91ciBjaGFuZ2Ugb25seSBhcHBs
aWVzIHdoZW4NCnF1ZXVpbmcgbmV3IHJlcXVlc3QgZmFpbGVkIGFuZCBub3QgYmVjYXVzZSBvZiBv
dGhlciBzY2VuYXJpb3MuDQoNClRoYW5rcywNClRoaW5oDQoNCg==
