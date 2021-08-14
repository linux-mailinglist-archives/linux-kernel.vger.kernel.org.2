Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB203EBF02
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 02:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbhHNAbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 20:31:15 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:36086 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235776AbhHNAbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 20:31:13 -0400
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EC8FDC08FB;
        Sat, 14 Aug 2021 00:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628901046; bh=jDDqTbXpSowzRbdE2NYGktQSsCMMmjdbQHQLd8wGlBY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Lqa0sOqexbR02V62Vp7ne5iwflKVt1yPFdGuk1vUjwe7FG8Oi4Fdp2I0iUPWCT14/
         8x8KUXamOZYuq4DImp3IPCheqN4vmTljLMEfkBo7kn0RNabqP/ZTesTCcbWQP6VthV
         /ab0WZiD9HOHW4bxoIp3yHwyNz3hafA4tFNCGDb6h53V+m/oGLbDqPmT891pxMsoAL
         ySAOdHB3970SkiHXj4ioJ07njxAcQESnPG8sBmEH+njiN5ZHG9jZxg3z4i+pYbfKBH
         gDwZ50C/KGXQdpGu4DPg/x9R7Udee0Jx6wmEvGW7zLrm5U84Tk4Gl6bHquOKyrsfn6
         gjerUKhQ/C3kA==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2FE6AA0080;
        Sat, 14 Aug 2021 00:30:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 09A4540097;
        Sat, 14 Aug 2021 00:30:43 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="upDCChLN";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpWfm5QS4oYMQeSDEiAqUP6YkpvYq01vzAqKbML7aTcICpi7mD7BzAo5UAgLJ6iveI2K/Mv9CEyXoqHfdXIrrJlo9/OaHw8v/HtulPfvOKaNNgmclbb1I0IAJ2Tz4FHBvHJhoz3LNdrDEXDASuROUP81MgoUlivmf72inFBr21IhkQ3h8org7STlgfpnGRCFx6uyr7Rwe2k8puR3SJ3RS3TaZv8h1CSqbKvxeF5Urrj+I6eyeey82jd6JAI6+5t3F8UTO7J9/hLUo7guGV87zJRpV80iwihHrHAk26i5CZBiqnjvSZPm/S9KX5TVcLzvG9v7sALMYdit/KWoCepYFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDDqTbXpSowzRbdE2NYGktQSsCMMmjdbQHQLd8wGlBY=;
 b=kMWBuNsauibgJ3/LP1SS3ffhdadzqb5ixZxrNppCDT3vF+G8N1XVSkkOnhNHGjhO9ahxXN5NgOFr8yfrF5gnGBpll50cMwfoXEYEWz1h0ohRux3MREDyGs3OMd4em2jld9uAt22Sy5RUQpiPk/YfbSgvGDQOcmrZGBXztpvW06dJrFGDbOmdKwQLOFBlCLc+wGgr9Hiv6Zh+NwJANeO2NF4u+rNRG9s+Z3fpZhPPBdT4UtCst02aIUXRXlO7IKk49prmEJdQQYrszreT4pX1Y7bFw1vh2yhfSL0W2vo8Lx0ggdYg82Jbwe4nPGIf0uvX5TaMf328CU1z4YFWUBhDPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDDqTbXpSowzRbdE2NYGktQSsCMMmjdbQHQLd8wGlBY=;
 b=upDCChLNRGCnsQjBV6cdfhhsKC/OumauNDPP5qhmdZ5cfwfjfUoNbEdlmwPdMnlCs9pnl6zyh8bi6WRAbFDy2H2Pb/J1bdVGKdFoorXmX4gQVYKczHksGA6AWPiTfUjUv4MaAWZrfkTznoXzKaf7YNBAZqOWtP8wE2fm4457gfI=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB3255.namprd12.prod.outlook.com (2603:10b6:a03:12e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Sat, 14 Aug
 2021 00:30:41 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9%7]) with mapi id 15.20.4415.021; Sat, 14 Aug 2021
 00:30:41 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeauora.org" <jackp@codeauora.org>
Subject: Re: [RFC][PATCH] usb: dwc3: usb: dwc3: Force stop EP0 transfers
 during pullup disable
Thread-Topic: [RFC][PATCH] usb: dwc3: usb: dwc3: Force stop EP0 transfers
 during pullup disable
Thread-Index: AQHXjlfnBCk6lwHDK0Kvf9A7ww7BQqtvCnaAgAETMgCAAEh3AIAAHhwAgAGTEQCAAAe1gIAAC4YA
Date:   Sat, 14 Aug 2021 00:30:40 +0000
Message-ID: <dc37617c-0fe4-47b3-cbd0-1d729ce6201a@synopsys.com>
References: <1628648608-15239-1-git-send-email-wcheng@codeaurora.org>
 <bcc8ff30-5c49-bddd-2f61-05da859b2647@synopsys.com>
 <3edf74ba-d167-0589-a7ab-827b57aa5d9c@codeaurora.org>
 <e07b7061-e9cf-3146-d115-56967298051e@synopsys.com>
 <c82ee8f3-a364-f96f-76ac-2b78c1dc0517@codeaurora.org>
 <f760fdcf-cd59-2c71-8c85-a4624620edeb@synopsys.com>
 <5be881a9-c79d-3f21-9e2e-173307fef734@codeaurora.org>
In-Reply-To: <5be881a9-c79d-3f21-9e2e-173307fef734@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e69e371-3ede-4ed1-3324-08d95ebabefa
x-ms-traffictypediagnostic: BYAPR12MB3255:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3255ECEB4D6F096ACDACA333AAFB9@BYAPR12MB3255.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YQ5PNSALPYJfQWhNcgKmbFi/9yK5szVqRKepPh/wbY8/DFSww3CubP2JGXJaBQ9jNllS6K3hiAgv4d1oilT1kYQ9SMWzl2cASxRaUE56Rs2WF2Eud3hmFutdF2apxbIjiY5Z6L+S8T0NT+isJQM2eFtfzlmIViyd7H2Z/FT5yI9Obs5a5ssaUkAjp+QtCYq7mvB0SmyCvvzMQULm3GoS+Ii825arTYpPImzw6gJgTTo5GpXQgzwGESZCPk9BWOCzAF/RcLKhWjh8i7rPRIIJPnqnlsulYWhyqtf8KCzLe6P3aG+1GkHC8eSi28xWDOQkEZUEwzHjUWhEDka90G0q+cW1B0iorWHhihDwWKjFS+1yymcW+so9NxgHsEpebJb9e4/1UWtjtQSdIYgfkLmKDkDA+1bsAeR/iUpS+T5xKWkSS4rZZQ78LsTmDvpteHVYA6K7DhRkQlrVbrLCnXLRuAxqZSQk84HO2/xDjW0igCEVusHpg4C+HyxHoXXepbNoClOig2NXuVsD1mU5ajqWGUICiIWKSJnrAC3hwNlzQ3lk3Q2PqrDzdlpBBaHaYXceW+8N5TbOZh7++QEMLNxmHxVvQk5OPrSYFyWXH+LkDy7xbttcHHIyMEAVYueQKEsAtGKU2tcfzv/SwqzQ+lymsGXD08fuRIjYBemFhvFc4YERquZssOIUjSUmfAdFNFxvWytFtrsMqJZQuQrvkNQ08UwnpP/gSVKiKbDvN1BhHHAtyZEIkjeWZ7wc+zBVc2oMcir/RVq9ucEOigtVX1070A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(396003)(366004)(39860400002)(478600001)(38100700002)(122000001)(26005)(5660300002)(2906002)(6512007)(66476007)(38070700005)(54906003)(76116006)(64756008)(71200400001)(66946007)(6486002)(66556008)(66446008)(2616005)(83380400001)(316002)(31696002)(31686004)(8676002)(110136005)(6506007)(186003)(53546011)(8936002)(36756003)(4326008)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3pCeEVjTkJDZWIzYm1tRDJEdEsxSEc5TjlYdUZkUVlXb25ueFNFZVBRdnh1?=
 =?utf-8?B?V291Z2hxMmhENElHbnp6dHNmdGRGdWZoY1c1V2ZIYTBoemR6U2dHR25UTkEr?=
 =?utf-8?B?ZFltOXlvSjVOUXNTa1lEcEJkM1JiSTVFZExLWk93YVl5Wk8reE9GWjlwblBt?=
 =?utf-8?B?NjFNbE8zTGE1TVh4MVZ1Q1pLQkpWYXIxd1NsS0kzUjVYNk1ZYW9ncStLSmdu?=
 =?utf-8?B?VnRJbTI5dEtyT25YU3NFNEZQU1EvV0xWQXMwV25NV1ovT0c4TGN4djgzMm5U?=
 =?utf-8?B?K01JZ2U3N1I5K0JFeHptcVZVSmtNUHhRMFdmN1ZoMXVIRDJwb2UxSEpTNTFO?=
 =?utf-8?B?aU5zaVBTQmJoSXJkUlMrNW5DdlBvdlEvb1hMN1lsWlN3L2psZHh3UUtyajBE?=
 =?utf-8?B?c2NiOUt2REtzL3VFOHRaZm5INnZkRUxzSnMrWEFLdnBkZDJNcUwzVnV3dG1q?=
 =?utf-8?B?b2FUT2xseUR1MkRndXpVRlFlRUo2KzV0bmNhb2FTeXhlU0cvNVR6UnU4V0lh?=
 =?utf-8?B?UVc4NHJiOGJKZlVIL0lveFQ5ZDg0L2dnemN1R0Z5cXdWZ0Z2eWRJaXFoZ2Zx?=
 =?utf-8?B?dUlIaFArNldhVUdKVC9EUk5mYzBCcWE5QUJYNEpEckNDOEp1aEdmOWYxeUMr?=
 =?utf-8?B?d3k5NWc4cTRLRXFrdkdnWDJHQXk0TTdNOERxTUlET3FMUjBRRjdQUmV2WXk5?=
 =?utf-8?B?UWJxQmhNWXZMRTR0WnkyenpPaXJsUmNBL1U4eXZ1azR4NDN1Q0ExOHdrejlw?=
 =?utf-8?B?U3NCRUFKWTJYeGxvK3d3SHZBOW5xRjcxSjgyR3VCVVM1a091S0ZDbTJVYkdu?=
 =?utf-8?B?UHhMcXdMNVN4dXV3TXRMd0N5UXM5RnRCM09sd0ZPZGRYcngrclh3TnBIang4?=
 =?utf-8?B?WCtyc2RYajgvbWkxUE52WUZIZUlUcG4zZ2lPNDBPU0ZLRnpiNEF5Nm1UdGVT?=
 =?utf-8?B?eURlZFg5MHdhR3Z3bzhHQm5UcDRySXVDTXN6QkEwdnB0dVZiQ0cwaFI2cTdi?=
 =?utf-8?B?QVA1OHErdnExd3ZJUW1EZ3hOa0FNZGhrdjFYWmFLY05XdGM0eklLaGx5dVli?=
 =?utf-8?B?Y1JPWE4rR25KWExzOTF5bmRDWmVwemhHcy8zYXM5cWFzMVJ1Sk9nckZpUUla?=
 =?utf-8?B?MXowTjZVakpSQlY2UFpEYjJMUkFsWEJYdWFSRGtWOUVkd3l1SjcyRE56cWpt?=
 =?utf-8?B?dDRPUnA5NWZ6VGJxcERJUWdmZFFwM2VPYmNscWtHbjlJZWFpWGNYQUtGUFMy?=
 =?utf-8?B?a1VYVjNZUHJTRjVPbDZ3Q2dEUXNDcnI3Zk15d1g1SkNQSGNyRWJPU2dBVEVT?=
 =?utf-8?B?TzViQmhrbXBWNzNOaEtoaHhnbkJDdW4rZG93RUNiVUtiVXJSMWNta0o2T1Jj?=
 =?utf-8?B?ZzhLYUpHSlB6dERWUGRlLzJkWXBoZm5FVmI4L0lVZXZidXZOM2JMMlpXOHgx?=
 =?utf-8?B?RUVsNGU5QWRYOXBXeWVTUGlvdWVYZ0VqcXFQUXBMQW9zVmx4T2dlQk1ldERG?=
 =?utf-8?B?Y01IK0RXSE50MDZXdnJ2WWE5WDhLV09ldGNTOHBXczhxZUlNZy9OVHRFb1pP?=
 =?utf-8?B?emUzaE1BVCs4b3FJSWk4dWFUN0k3WitIRmVkZFE0eTNKaXpsTEtsMW5qNkxW?=
 =?utf-8?B?QlJ2TTBiMU9pL2dMRXdPNFJ5N0JhRXZ3N0NxZ3ZyN3JuTlNXV1cvVlJMSVZv?=
 =?utf-8?B?WUdUck13MXBKakQxRDg0bm0wS211cllDczg5NlRrbm83MDRYcDBGbms1WE1i?=
 =?utf-8?Q?xJ7RX3Pi1BguLfjOVA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC6588231E578D4399CC6DE5E026C786@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e69e371-3ede-4ed1-3324-08d95ebabefa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2021 00:30:40.9312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iehGziJwFFfu8fT1HdTnH+5cFX0ERa2+Lp0Y+3ow01pQOtxFsqs4fJyNQ+hWwVBrlhFdhrdCTCAbVF+Mwj3XHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3255
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPiBIaSBUaGluaCwNCj4gDQo+IE9uIDgvMTMvMjAyMSA0OjIx
IFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+PiBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+Pj4gSGkg
VGhpbmgsDQo+Pj4NCj4+PiBPbiA4LzEyLzIwMjEgMjozMSBQTSwgVGhpbmggTmd1eWVuIHdyb3Rl
Og0KPj4+PiBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+Pj4+PiBIaSBUaGluaCwNCj4+Pj4+DQo+Pj4+
PiBPbiA4LzExLzIwMjEgNTo0NyBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4+Pj4+IFdlc2xl
eSBDaGVuZyB3cm90ZToNCj4+Pj4+Pj4gRHVyaW5nIGEgVVNCIGNhYmxlIGRpc2Nvbm5lY3QsIG9y
IHNvZnQgZGlzY29ubmVjdCBzY2VuYXJpbywgYSBwZW5kaW5nDQo+Pj4+Pj4+IFNFVFVQIHRyYW5z
YWN0aW9uIG1heSBub3QgYmUgY29tcGxldGVkLCBsZWFkaW5nIHRvIHRoZSBmb2xsb3dpbmcNCj4+
Pj4+Pj4gZXJyb3I6DQo+Pj4+Pj4+DQo+Pj4+Pj4+ICAgICBkd2MzIGE2MDAwMDAuZHdjMzogdGlt
ZWQgb3V0IHdhaXRpbmcgZm9yIFNFVFVQIHBoYXNlDQo+Pj4+Pj4NCj4+Pj4+PiBIb3cgY291bGQg
aXQgYmUgYSBjYXNlIG9mIGNhYmxlIGRpc2Nvbm5lY3Q/IFRoZSBwdWxsdXAoMCkgb25seSBhcHBs
aWVzDQo+Pj4+Pj4gZm9yIHNvZnQtZGlzY29ubmVjdCBzY2VuYXJpby4gSWYgdGhlIGRldmljZSBp
bml0aWF0ZWQgYSBkaXNjb25uZWN0LCB0aGVuDQo+Pj4+Pg0KPj4+Pj4gVGhhbmtzIGZvciB0aGUg
cmVzcG9uc2UuICBJIGd1ZXNzIHRoaXMgaXMgc3BlY2lmaWMgZm9yIHNvbWUgdXNlIGNhc2VzLA0K
Pj4+Pj4gYnV0IHNvbWUgYXBwbGljYXRpb25zIHN1Y2ggYXMgQURCIHdpbGwgY2xvc2UgdGhlIEZG
UyBFUCBmaWxlcyBhZnRlciBpdA0KPj4+Pj4gZ2V0cyB0aGUgZGlzY29ubmVjdGlvbiBldmVudCwg
bGVhZGluZyB0byB0aGlzIHB1bGx1cCBkaXNhYmxlIGFzIHdlbGwuDQo+Pj4+PiBTbyBpdHMgc3Bl
Y2lmaWMgdG8gdGhhdCBwYXJ0aWN1bGFyIHVzZSBjYXNlLg0KPj4+Pg0KPj4+PiBEb2VzIHRoYXQg
bWVhbiB0aGF0IHRoZSBBREIgYXBwbGljYXRpb24gd29uJ3QgZXhwZWN0IGEgY29ubmVjdGlvbiB1
bnRpbA0KPj4+PiB1c2VyIGludGVydmVudGlvbiBvciBzb21lIG90aGVyIG5vdGlmaWNhdGlvbiB0
byBkbyBwdWxsdXAoMSk/DQo+Pj4+DQo+Pj4NCj4+PiBZZXMsIGNvcnJlY3QuICBUaGUgQW5kcm9p
ZCBVU0IgZnJhbWV3b3JrIHdpbGwgdHJpZ2dlciB0aGUgcHVsbHVwKDEpIGFnYWluLg0KPj4+DQo+
Pj4+Pg0KPj4+Pj4+IHRoZSBkcml2ZXIgc2hvdWxkIHdhaXQgZm9yIHRoZSBjb250cm9sIHJlcXVl
c3QgdG8gY29tcGxldGUuIElmIGl0IHRpbWVzDQo+Pj4+Pj4gb3V0LCBzb21ldGhpbmcgaXMgYWxy
ZWFkeSB3cm9uZyBoZXJlLiBUaGUgcHJvZ3JhbW1pbmcgZ3VpZGUgb25seQ0KPj4+Pj4+IG1lbnRp
b25zIHRoYXQgd2Ugc2hvdWxkIHdhaXQgZm9yIGNvbXBsZXRpb24sIGJ1dCBpdCBkb2Vzbid0IHNh
eSBhYm91dA0KPj4+Pj4+IHJlY292ZXJ5IGluIGEgY2FzZSBvZiBodW5nIHRyYW5zZmVyLiBJIG5l
ZWQgdG8gY2hlY2sgaW50ZXJuYWxseSBidXQgaXQNCj4+Pj4+PiBzaG91bGQgYmUgc2FmZSB0byBp
c3N1ZSBFbmQgVHJhbnNmZXIuDQo+Pj4+Pj4NCj4+Pj4+DQo+Pj4+PiBZZXMsIHdoYXQgSSBkaWQg
d2FzIG1vZGlmeSBhIGRldmljZSBydW5uaW5nIHRoZSBMaW51eCBYSENJIHN0YWNrIHcvbw0KPj4+
Pj4gcmVhZGluZy9zZW5kaW5nIG91dCB0aGUgU0VUVVAgREFUQSBwaGFzZSwgc28gdGhhdCBvbiB0
aGUgZGV2aWNlIGVuZCB3ZSdkDQo+Pj4+PiBhbHdheXMgcnVuIGludG8gdGhhdCBzaXR1YXRpb24g
d2hlcmUgdGhlcmUncyBzdGlsbCBhIHBlbmRpbmcgRVAwIFRSQiBxdWV1ZWQuDQo+Pj4+DQo+Pj4+
IElzIHRoaXMgb25seSBmb3IgdmFsaWRhdGlvbiBwdXJwb3NlPw0KPj4+Pg0KPj4+DQo+Pj4gWWVz
LCBqdXN0IHRvIGhlbHAgdmVyaWZ5IHRoZSBmaXggYnkgaW5qZWN0aW5nIHRoZSBlcnJvciBjb25k
aXRpb24uDQo+Pg0KPj4gSnVzdCB3YW50IHRvIGNsYXJpZnksIHNvIHlvdSBkaWRuJ3QgcmVhbGx5
IHJ1biBpbnRvIHRoaXMgcHJvYmxlbSBidXQNCj4+IHdhbnQgdG8gZml4IHRoZSByZWNvdmVyeSBw
YXRoIHJpZ2h0Pw0KPj4NCj4gTm8sIHdlIHJhbiBpbnRvIHRoaXMgaXNzdWUsIGJ1dCBpdCB3YXMg
b25seSBzZWVuIGluIG91ciBtYXNzIGRldmljZQ0KPiB0ZXN0aW5nLiAgSSBvbmx5IG1hZGUgdGhl
IGNoYW5nZXMgdG8gc2ltdWxhdGUgdGhlIGlzc3VlLCBzbyB0aGVuIEkNCj4gd291bGRuJ3QgbmVl
ZCB0byBoYXZlIHRvIHdhaXQgZm9yIHRoZSB0ZXN0IHJlc3VsdHMuDQo+IA0KPiBIb3dldmVyLCB3
ZSBkaWQgZ2V0IGEgbWFzcyBkZXZpY2UgdGVzdCBydW4gaW4gdy8gdGhlIGNoYW5nZXMsIGFuZCB0
aGV5DQo+IHdlcmUgdW5hYmxlIHRvIHJlcHJvZHVjZSB0aGUgc2FtZSBpc3N1ZXMgd2UndmUgYmVl
biBzZWVpbmcsIHNvIHRoaXMgZG9lcw0KPiBmaXggYW4gYWN0dWFsIGlzc3VlLg0KDQpPaw0KDQo+
Pj4NCj4+Pj4+DQo+Pj4+PiBXZSdyZSBydW5uaW5nIG11bHRpcGxlIGRldmljZXMgd2l0aCB0aGlz
IGZpeCBhcyB3ZWxsLCBhbmQgZG9pbmcgZGV2aWNlDQo+Pj4+PiBpbml0aWF0ZWQgZGlzY29ubmVj
dC4NCj4+Pj4+DQo+Pj4+Pj4+DQo+Pj4+Pj4+IElmIHRoaXMgb2NjdXJzLCB0aGVuIHRoZSBlbnRp
cmUgcHVsbHVwIGRpc2FibGUgcm91dGluZSBpcyBza2lwcGVkIGFuZA0KPj4+Pj4+PiBwcm9wZXIg
Y2xlYW51cCBhbmQgaGFsdGluZyBvZiB0aGUgY29udHJvbGxlciBkb2VzIG5vdCBjb21wbGV0ZS4N
Cj4+Pj4+Pj4gSW5zdGVhZCBvZiByZXR1cm5pbmcgYW4gZXJyb3IgKHdoaWNoIGlzIGlnbm9yZWQg
ZnJvbSB0aGUgVURDDQo+Pj4+Pj4+IHBlcnNwZWN0aXZlKSwgZG8gd2hhdCBpcyBtZW50aW9uZWQg
aW4gdGhlIGNvbW1lbnRzIGFuZCBmb3JjZSB0aGUNCj4+Pj4+Pj4gdHJhbnNhY3Rpb24gdG8gY29t
cGxldGUgYW5kIHB1dCB0aGUgZXAwc3RhdGUgYmFjayB0byB0aGUgU0VUVVAgcGhhc2UuDQo+Pj4+
Pj4+DQo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFdlc2xleSBDaGVuZyA8d2NoZW5nQGNvZGVhdXJv
cmEub3JnPg0KPj4+Pj4+PiAtLS0NCj4+Pj4+Pj4gIGRyaXZlcnMvdXNiL2R3YzMvZXAwLmMgICAg
fCA0ICsrLS0NCj4+Pj4+Pj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCA2ICsrKysrLQ0K
Pj4+Pj4+PiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuaCB8IDMgKysrDQo+Pj4+Pj4+ICAzIGZp
bGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pj4+Pj4+DQo+
Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jIGIvZHJpdmVycy91c2Iv
ZHdjMy9lcDAuYw0KPj4+Pj4+PiBpbmRleCA2NTg3Mzk0Li5hYmZjNDJiIDEwMDY0NA0KPj4+Pj4+
PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jDQo+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdXNi
L2R3YzMvZXAwLmMNCj4+Pj4+Pj4gQEAgLTIxOCw3ICsyMTgsNyBAQCBpbnQgZHdjM19nYWRnZXRf
ZXAwX3F1ZXVlKHN0cnVjdCB1c2JfZXAgKmVwLCBzdHJ1Y3QgdXNiX3JlcXVlc3QgKnJlcXVlc3Qs
DQo+Pj4+Pj4+ICAJcmV0dXJuIHJldDsNCj4+Pj4+Pj4gIH0NCj4+Pj4+Pj4gIA0KPj4+Pj4+PiAt
c3RhdGljIHZvaWQgZHdjM19lcDBfc3RhbGxfYW5kX3Jlc3RhcnQoc3RydWN0IGR3YzMgKmR3YykN
Cj4+Pj4+Pj4gK3ZvaWQgZHdjM19lcDBfc3RhbGxfYW5kX3Jlc3RhcnQoc3RydWN0IGR3YzMgKmR3
YykNCj4+Pj4+Pj4gIHsNCj4+Pj4+Pj4gIAlzdHJ1Y3QgZHdjM19lcAkJKmRlcDsNCj4+Pj4+Pj4g
IA0KPj4+Pj4+PiBAQCAtMTA3Myw3ICsxMDczLDcgQEAgdm9pZCBkd2MzX2VwMF9zZW5kX2RlbGF5
ZWRfc3RhdHVzKHN0cnVjdCBkd2MzICpkd2MpDQo+Pj4+Pj4+ICAJX19kd2MzX2VwMF9kb19jb250
cm9sX3N0YXR1cyhkd2MsIGR3Yy0+ZXBzW2RpcmVjdGlvbl0pOw0KPj4+Pj4+PiAgfQ0KPj4+Pj4+
PiAgDQo+Pj4+Pj4+IC1zdGF0aWMgdm9pZCBkd2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKHN0cnVj
dCBkd2MzICpkd2MsIHN0cnVjdCBkd2MzX2VwICpkZXApDQo+Pj4+Pj4+ICt2b2lkIGR3YzNfZXAw
X2VuZF9jb250cm9sX2RhdGEoc3RydWN0IGR3YzMgKmR3Yywgc3RydWN0IGR3YzNfZXAgKmRlcCkN
Cj4+Pj4+Pj4gIHsNCj4+Pj4+Pj4gIAlzdHJ1Y3QgZHdjM19nYWRnZXRfZXBfY21kX3BhcmFtcyBw
YXJhbXM7DQo+Pj4+Pj4+ICAJdTMyCQkJY21kOw0KPj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4+Pj4+Pj4g
aW5kZXggNTRjNWEwOC4uYTBlMmU0ZCAxMDA2NDQNCj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy91c2Iv
ZHdjMy9nYWRnZXQuYw0KPj4+Pj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+
Pj4+Pj4+IEBAIC0yNDM3LDcgKzI0MzcsMTEgQEAgc3RhdGljIGludCBkd2MzX2dhZGdldF9wdWxs
dXAoc3RydWN0IHVzYl9nYWRnZXQgKmcsIGludCBpc19vbikNCj4+Pj4+Pj4gIAkJCQltc2Vjc190
b19qaWZmaWVzKERXQzNfUFVMTF9VUF9USU1FT1VUKSk7DQo+Pj4+Pj4+ICAJCWlmIChyZXQgPT0g
MCkgew0KPj4+Pj4+PiAgCQkJZGV2X2Vycihkd2MtPmRldiwgInRpbWVkIG91dCB3YWl0aW5nIGZv
ciBTRVRVUCBwaGFzZVxuIik7DQo+Pj4+Pj4+IC0JCQlyZXR1cm4gLUVUSU1FRE9VVDsNCj4+Pj4+
Pj4gKwkJCXNwaW5fbG9ja19pcnFzYXZlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4+Pj4+Pj4gKwkJ
CWR3YzNfZXAwX2VuZF9jb250cm9sX2RhdGEoZHdjLCBkd2MtPmVwc1swXSk7DQo+Pj4+Pj4+ICsJ
CQlkd2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKGR3YywgZHdjLT5lcHNbMV0pOw0KPj4+Pj4+DQo+
Pj4+Pj4gRW5kIHRyYW5zZmVyIGNvbW1hbmQgdGFrZXMgdGltZSwgbmVlZCB0byB3YWl0IGZvciBp
dCB0byBjb21wbGV0ZSBiZWZvcmUNCj4+Pj4+PiBpc3N1aW5nIFN0YXJ0IHRyYW5zZmVyIGFnYWlu
LiBBbHNvLCB3aHkgcmVzdGFydCBhZ2FpbiB3aGVuIGl0J3MgYWJvdXQgdG8NCj4+Pj4+PiBiZSBk
aXNjb25uZWN0ZWQuDQo+Pj4+Pg0KPj4+Pj4gSSBjYW4gdHJ5IHdpdGhvdXQgcmVzdGFydGluZyBp
dCBhZ2FpbiwgYW5kIHNlZSBpZiB0aGF0IHdvcmtzLiAgSW5zdGVhZA0KPj4+Pj4gb2Ygd2FpdGlu
ZyBmb3IgdGhlIGNvbW1hbmQgY29tcGxldGUgZXZlbnQsIGNhbiB3ZSBzZXQgdGhlIEZvcmNlUk0g
Yml0LA0KPj4+Pj4gc2ltaWxhciB0byB3aGF0IHdlIGRvIGZvciBkd2MzX3JlbW92ZV9yZXF1ZXN0
cygpPw0KPj4+Pj4NCj4+Pj4NCj4+Pj4gRm9yY2VSTT0xIG1lYW5zIHRoYXQgdGhlIGNvbnRyb2xs
ZXIgd2lsbCBpZ25vcmUgdXBkYXRpbmcgdGhlIFRSQnMNCj4+Pj4gKGluY2x1ZGluZyBub3QgY2xl
YXJpbmcgdGhlIEhXTyBhbmQgcmVtYWluIHRyYW5zZmVyIHNpemUpLiBUaGUgZHJpdmVyDQo+Pj4+
IHN0aWxsIG5lZWRzIHRvIHdhaXQgZm9yIHRoZSBjb21tYW5kIHRvIGNvbXBsZXRlIGJlZm9yZSBp
c3N1aW5nIFN0YXJ0DQo+Pj4+IFRyYW5zZmVyIGNvbW1hbmQuIE90aGVyd2lzZSBTdGFydCBUcmFu
c2ZlciB3b24ndCBnbyB0aHJvdWdoLiBJZiB3ZSBrbm93DQo+Pj4+IHRoYXQgd2UncmUgbm90IGdv
aW5nIHRvIGlzc3VlIFN0YXJ0IFRyYW5zZmVyIGFueSB0aW1lIHNvb24sIHRoZW4gd2UgbWF5DQo+
Pj4+IGJlIGFibGUgdG8gZ2V0IGF3YXkgd2l0aCBpZ25vcmluZyBFbmQgVHJhbnNmZXIgY29tbWFu
ZCBjb21wbGV0aW9uLg0KPj4+Pg0KPj4+DQo+Pj4gSSBzZWUuICBDdXJyZW50bHksIGluIHRoZSBw
bGFjZSB0aGF0IHdlIGRvIHVzZQ0KPj4+IGR3YzNfZXAwX2VuZF9jb250cm9sX2RhdGEoKSwgaXRz
IGZvbGxvd2VkIGJ5DQo+Pj4gZHdjM19lcDBfc3RhbGxfYW5kX3Jlc3RhcnQoKSB3aGljaCB3b3Vs
ZCBleGVjdXRlIHN0YXJ0IHRyYW5zZmVyLiAgRm9yDQo+Pg0KPj4gVGhhdCBkb2Vzbid0IGxvb2sg
cmlnaHQuIFlvdSBjYW4gdHJ5IHRvIHNlZSBpZiBpdCBjYW4gcmVjb3ZlciBmcm9tIGENCj4+IGNv
bnRyb2wgd3JpdGUgcmVxdWVzdC4gT2Z0ZW4gdGltZSB3ZSBkbyBjb250cm9sIHJlYWQgYW5kIG5v
dCB3cml0ZS4NCj4+IChpLmUuIHRyeSB0byBFbmQgVHJhbnNmZXIgYW5kIGltbWVkaWF0ZWx5IFN0
YXJ0IFRyYW5zZmVyIG9uIHRoZSBzYW1lDQo+PiBkaXJlY3Rpb24gY29udHJvbCBlbmRwb2ludCku
DQo+Pg0KPiBPSywgSSBjYW4gdHJ5LCBidXQganVzdCB0byBjbGFyaWZ5LCBJIHdhcyByZWZlcnJp
bmcgdG8gaG93IGl0IHdhcyBiZWluZw0KPiBkb25lIGluOg0KPiANCj4gc3RhdGljIHZvaWQgZHdj
M19lcDBfeGZlcm5vdHJlYWR5KHN0cnVjdCBkd2MzICpkd2MsDQo+IAkJY29uc3Qgc3RydWN0IGR3
YzNfZXZlbnRfZGVwZXZ0ICpldmVudCkNCj4gew0KPiAuLi4NCj4gCQlpZiAoZHdjLT5lcDBfZXhw
ZWN0X2luICE9IGV2ZW50LT5lbmRwb2ludF9udW1iZXIpIHsNCj4gCQkJc3RydWN0IGR3YzNfZXAJ
KmRlcCA9IGR3Yy0+ZXBzW2R3Yy0+ZXAwX2V4cGVjdF9pbl07DQo+IA0KPiAJCQlkZXZfZXJyKGR3
Yy0+ZGV2LCAidW5leHBlY3RlZCBkaXJlY3Rpb24gZm9yIERhdGEgUGhhc2VcbiIpOw0KPiAJCQlk
d2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKGR3YywgZGVwKTsNCj4gCQkJZHdjM19lcDBfc3RhbGxf
YW5kX3Jlc3RhcnQoZHdjKTsNCj4gCQkJcmV0dXJuOw0KPiAJCX0NCj4gDQo+Pj4gdGhlIG1vc3Qg
cGFydCwgd2Ugd2VyZSB0cnlpbmcgdG8gZm9sbG93IHRoZSBmbG93IGRpYWdyYW0gaW46DQo+Pj4N
Cj4+PiAJNC40IENvbnRyb2wgVHJhbnNmZXIgUHJvZ3JhbW1pbmcgTW9kZWwNCj4+Pg0KPj4+IFdl
J2QgdGVjaG5pY2FsbHkgYmUgaW4gdGhlICJ3YWl0IGZvciBob3N0IiBzdGFnZSBhdCB0aGlzIHBv
aW50LCBzbyBoZW5jZQ0KPj4+IHdoeSB3ZSBpc3N1ZWQgdGhlIGVuZCB0cmFuc2ZlciwgdGhlbiBm
b2xsb3dlZCB3aXRoIHRoZSBzdGFsbCBhbmQgcmVzdGFydC4NCj4+Pg0KPj4NCj4+IFlvdSdyZSBu
b3Qgc2V0dGluZyB1cCB0aGUgZGF0YSBzdGFnZSBvbiBob3N0IHNpZGUgcmlnaHQ/IFNvLCB3ZSB3
b3VsZG4ndA0KPj4gcmVjZWl2ZSBhIFhmZXJOb3RSZWFkeShkYXRhKSB0byBwcm9jZWVkIHRvIHRo
ZSBuZXh0IHN0YXRlIHRvIGludGVycHJldA0KPiBDb3JyZWN0LCBzbyB0aGUgc2l0dWF0aW9uIHdl
J3JlIHJ1bm5pbmcgaW50byBpc24ndCB0ZWNobmljYWxseSBzb21ldGhpbmcNCj4gY292ZXJlZCBp
biB0aGUgZmxvdyBjaGFydCwgYnV0IGl0IGlzIGEgc2ltaWxhciBzaXR1YXRpb24gYXMgdGhlIG9u
ZSBpdA0KPiBjdXJyZW50bHkgaGlnaGxpZ2h0cy4NCj4+IHdoZXRoZXIgaXQncyB1bmV4cGVjdGVk
IGRpcmVjdGlvbiB0byBlbmQgYW5kIHJlc3RhcnQuIEFsc28sIHlvdSBzaG91bGQNCj4+IGNoZWNr
IHRvIHNlZSB3aGljaCBkaXJlY3Rpb24vY29udHJvbCBzdGFnZSB3YXMgaHVuZyB0byBpc3N1ZSBF
bmQNCj4+IFRyYW5zZmVyIHRvIGVwMCBvciBlcDEuIE9uIHJlY29ubmVjdCBhZnRlciBkZXZpY2Ug
aW5pdGlhdGVkIGRpc2Nvbm5lY3QsDQo+IGR3YzNfZXAwX2VuZF9jb250cm9sX2RhdGEoKSBkb2Vz
IGNoZWNrIGlmIHRoZSBkZXAtPnJlc291cmNlX2luZGV4ID09IDANCj4gYmVmb3JlIGlzc3Vpbmcg
dGhlIGVuZCB0cmFuc2Zlci4gIFRoZSByZXNvdXJjZSBpbmRleCBzaG91bGQgYmUgemVybyBpZg0K
PiB0aGVyZSB3YXMgbm8gc3RhcnQgdHJhbnNmZXIgcGF0aCBleGVjdXRlZC4gIEhvd2V2ZXIsIEkg
Y2FuIGFkZCBhIGNoZWNrDQo+IGhlcmUgaWYgdGhhdCBpcyBwcmVmZXJyZWQuDQoNClRoZSByZXNv
dXJjZSBpbmRleCBmb3IgZXAwIGlzIDAuIFRoYXQgbWVhbnMgdGhhdCB0aGUgZHJpdmVyIHdpbGwg
bm90DQppc3N1ZSBFbmQgVHJhbnNmZXIgdG8gZXAwLiBJbiB0aGUgYWJvdmUgY29kZSBzbmlwcGV0
LCBpdCBzaG91bGQgbm90IGJlIGENCnByb2JsZW0gYmVjYXVzZSBpZiB0aGUgZHJpdmVyIHJlY2Vp
dmVkIFhmZXJOb3RSZWFkeSBmb3IgZXAwLCB0aGF0IG1lYW5zDQp0aGF0IHRoZSBlbmRwb2ludCBo
YXMgbm90IHN0YXJ0ZWQgeWV0LCBzbyBpdCdzIG9rIHRvIGlzc3VlIFN0YXJ0DQpUcmFuc2ZlciBh
Z2Fpbi4gSWYgaXQncyBmb3IgZXAxLCB0aGVuIGl0J3Mgb2sgdG8gaXNzdWUgRW5kIFRyYW5zZmVy
IG9uDQp0aGF0IGRpcmVjdGlvbiAoSU4pIHdoaWxlIFN0YXJ0IFRyYW5zZmVyIGZvciBlcDAgKE9V
VCkuDQoNCj4+IHRoZSBnYWRnZXQgc2hvdWxkIHN0YXJ0IGVwMCBmb3Igc2V0dXAgc3RhZ2UgYWdh
aW4uDQo+Pg0KPiBZZXMsIHNvIG1heWJlIHdlIGRvbid0IG5lZWQgdG8gZXhwbGljaXRseSBzdGFs
bCBhbmQgcmVzdGFydCBoZXJlLCBhcyBpdA0KPiB3aWxsIGJlIHJlc3RhcnRlZCBkdXJpbmcgZ2Fk
Z2V0IHN0YXJ0Lg0KPj4gTm90ZToNCj4+IEkgZG9uJ3QgdGhpbmsgd2UgY2xlYXJseSBkZWZpbmVk
IGEgcmVjb3ZlcnkgZm9yIHRoaXMgdGltZW91dCBmb3IgZGV2aWNlDQo+PiBpbml0aWF0ZWQgZGlz
Y29ubmVjdC4gTW9zdCBvZiB0aGUgdGltZSB3ZSBkb24ndCB3YW50IHRvIGlzc3VlIEVuZA0KPj4g
VHJhbnNmZXIgZm9yIGVuZHBvaW50IDAgKE9VVCBkaXJlY3Rpb24pIGJlY2F1c2Ugd2UgbWF5IGJl
IGV4cGVjdGluZyBhDQo+PiBzZXR1cCBwYWNrZXQuIEhvd2V2ZXIsIGluIHRoaXMgY2FzZSBvZiBl
cnJvciByZWNvdmVyeSB0byBwcm9jZWVkIHRvDQo+PiBzb2Z0LWRpc2Nvbm5lY3QsIGl0IHNob3Vs
ZCBiZSBmaW5lLg0KPj4NCj4gQW5vdGhlciBzb2x1dGlvbiB3ZSB3ZXJlIGNvbnNpZGVyaW5nIGlz
IGlmIHdlIGp1c3QgYXZvaWQgcmV0dXJuaW5nDQo+IC1FVElNRURPVVQgZXZlbiBpZiB0aGVyZSB3
ZXJlIHBlbmRpbmcgdHJhbnNmZXJzIG9uIEVQMC4gIEluIHRoZSBlbmQsIHRoZQ0KPiBnYWRnZXQg
c3RvcCByb3V0aW5lIHdvdWxkIGRpc2FibGUgRVAwLzEsIHdoaWNoIHdvdWxkIGFsc28gc3RvcCBh
bnkNCj4gYWN0aXZlIHRyYW5zZmVycyBhcyB3ZWxsIHcvIEVQIGV2ZW50cyBkaXNhYmxlZC4NCj4g
DQoNClllcyB0aGF0J3MgdHJ1ZS4gUHJvYmFibHkgYmV0dGVyIHRoaXMgd2F5Lg0KDQpCUiwNClRo
aW5oDQoNCg==
