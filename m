Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4561F3EC64E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 02:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhHOA0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 20:26:53 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:38642 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229453AbhHOA0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 20:26:51 -0400
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E0B64C0101;
        Sun, 15 Aug 2021 00:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628987182; bh=2+IfQZd+8O1e+iSRlmczZpIlGXqpA4hnRwNFPwcGF18=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=D7tC+CAfy/csGHDZaSiZlBj92S8lGK7t4uKrZ3QCXZXQ8XLneatazWOYrMSMt28lm
         MxiV6WGWXIiB80ILXMwqd4Ir7YTAIG04lyCOXkgNeUdj+FcP8Pz699KxYwZnor68Q8
         htvOlOkVbsX7yyhcvshDBzhbnbWhVj1se3e0RsiOCHDkzkpAaccjPlgWst1Opmva8W
         LCbqz0y9VOiLScT8fX88MzknTutodb6js94R0cOMoZnZQC2q2RnMg63GMnCVpi2Cwp
         imngwJlKzqXqMSOI7wdXCIc1HsfrHETjccC8t7zZIyx3kbfmPGyPE8f6WEx5w+Od7m
         2gPDVDo4OmFpg==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id B051FA008A;
        Sun, 15 Aug 2021 00:26:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1DF9F800C0;
        Sun, 15 Aug 2021 00:26:18 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="UXatYja+";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlgLNpk41bosh8VCLjkmRjvH2Lu7swxqEsPBmutqoOgE/D3KdBAsHLkqu3HeTjI+R8VPZweyVSzQ9bCBWh/0LLghSxgitGUoNKWcLhLWL58M94JlcVxyvBUmxah0zcOp0CovVNLJwSsHXBpDCyIisGp/a20tVxrmwWSdt64lfvnckiWV7mlZmHriFmTzyvTqJwitg99Yn4L3f/1LzjhjTUV6y1C5U/OBvAtjA2j1J09SgLlfF3tlEsQnwByvQuw/oFLni1x+GLjPRPh94mN4iayAqh2BwJypl/d23gYFxka+07stD5b3mgO3WNyEAAa7VD9C6GeVwRWmoRQgIahf9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+IfQZd+8O1e+iSRlmczZpIlGXqpA4hnRwNFPwcGF18=;
 b=QpzyUnFGmtmttLvmOcbLLLjtKWNlbbzn/4j9RvAo/LyWji5FIZQq2SSEPl01tj4WFZByjBz1U64cHovO4S6c1bExnxUCSEzvCyGz9UvwxVK7AMNsBfd0QPXHL+iB/UU7HecdQIPljTIwdCKdTrV/Lu8FvfAAeoOeNDuGlMK2V/CTQp1QNM+LxcOGrPktsj5rJ/JiYCstCQn7fOhOFxNW297JdSxoZ2z6wCyJtEc6z/vaZgN5OcbUwfTVkjrLgmSZD4XkAlU+I1Op4uqCmn6J8c6ApY+obv0UPJ/98QxtmW3Ikz2RVJgya/E0b10Rscr7Qs74nwS6SERK+r25cM2Nog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+IfQZd+8O1e+iSRlmczZpIlGXqpA4hnRwNFPwcGF18=;
 b=UXatYja++iZwqG4FRxM/tBpdPpqNp9iKLQWCFE6nvK6YSIYER/WaaNwUvqHdJEaNqd5bsP/iFVHT/mfIdRb4by+WQBDASZ6OvUl4oqXv4lOrhf9NorGLfm291YSPrlVnKOuKRuu+DKclXmHPVFJyUK7EVcSzrZoGNnWlgtmYjcc=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Sun, 15 Aug
 2021 00:26:14 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9%7]) with mapi id 15.20.4415.022; Sun, 15 Aug 2021
 00:26:08 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeauora.org" <jackp@codeauora.org>
Subject: Re: [RFC][PATCH] usb: dwc3: usb: dwc3: Force stop EP0 transfers
 during pullup disable
Thread-Topic: [RFC][PATCH] usb: dwc3: usb: dwc3: Force stop EP0 transfers
 during pullup disable
Thread-Index: AQHXjlfnBCk6lwHDK0Kvf9A7ww7BQqtvCnaAgAETMgCAAEh3AIAAHhwAgAGTEQCAAAe1gIAAC4YAgAGREQA=
Date:   Sun, 15 Aug 2021 00:26:08 +0000
Message-ID: <00952bdc-acc2-f373-9286-6a8380e0b7d1@synopsys.com>
References: <1628648608-15239-1-git-send-email-wcheng@codeaurora.org>
 <bcc8ff30-5c49-bddd-2f61-05da859b2647@synopsys.com>
 <3edf74ba-d167-0589-a7ab-827b57aa5d9c@codeaurora.org>
 <e07b7061-e9cf-3146-d115-56967298051e@synopsys.com>
 <c82ee8f3-a364-f96f-76ac-2b78c1dc0517@codeaurora.org>
 <f760fdcf-cd59-2c71-8c85-a4624620edeb@synopsys.com>
 <5be881a9-c79d-3f21-9e2e-173307fef734@codeaurora.org>
 <dc37617c-0fe4-47b3-cbd0-1d729ce6201a@synopsys.com>
In-Reply-To: <dc37617c-0fe4-47b3-cbd0-1d729ce6201a@synopsys.com>
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
x-ms-office365-filtering-correlation-id: ae300369-f5cd-4909-0346-08d95f83472c
x-ms-traffictypediagnostic: BY5PR12MB4033:
x-microsoft-antispam-prvs: <BY5PR12MB4033888DD1F39723AA0CA5F4AAFC9@BY5PR12MB4033.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: neEut0iHjdbkzHB11kzCnBuebdRVrrrQnQgtI0oL6mjlHCuo+iUuIt5k5KZaoKzSO5Bgg5zAzpInb/eB3eucp/gX9aLI2ppCZwN8DPeuPMSEJD2gLYQT5hNqA0v8En5zzmQIz6lYMjcHeFpem2nkrw5KgHQKuzmf1Go1y/9sFeRRszumDCC0wDG5oxc/NV8Q5GPDagi3USW9W2qSWmjVKCFjhukOMBW5mfMG5iSqxejzNKbWVPSxZn9UMEWd0CE+WNJ1iBBsk7EA+1pdOWHWJJCA674c9QAAnA098HoAB/0VmQ1XfHxq2sVSJGvbJUq9nX73wYFyEW6K2bDNMlGR/ZWE+pnym6gprYbX2Zt7eBEHj8oWHhaeDSyks36Fy7uS00UcRC+JPZpyFJbnyZ1IWnLq2wRrz8boQHme22CSMF8XHxE1aHw7jnLE9QwhJEgcVjEyOhvxKQ1oaqY9tqqcbjWt3MjE5LDSreOHIYUm8fRqqGgSeCCl4ZptO0w5a0IpobD8Gkq9ubwyfxQOh7RNZqWm6rBNQPXnSJ2gBMMi8NL2ufvvOkg/wwqJs+HieVtrBiQP7FwqmHB2BLYk2S4TMdOOetK6yrSpFaFyJs4EDVokjJy5V7sjfCeQ6lck3ScumTV51Nebt7EAM87CcWQ1amJDbglDuLuXB9BkUaFONQbLSL68Xvyx0SawktMvPE7wG2kW57RuySXarCyQjANGgJpZBhmiy928F/BPa1lRDRYVU1abfFMrJn5oTG3aq2fDYa2ZpojgvzWYSpF2i/nF3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39850400004)(366004)(346002)(376002)(136003)(110136005)(76116006)(5660300002)(2616005)(31686004)(186003)(83380400001)(478600001)(316002)(8936002)(2906002)(122000001)(4326008)(54906003)(71200400001)(6486002)(66946007)(66476007)(38070700005)(66446008)(66556008)(64756008)(8676002)(38100700002)(86362001)(31696002)(36756003)(26005)(6506007)(6512007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlpKNUNLSmdYaEVsaVFRTXdSd3pZUmhSZ3lUN2FtSTA4bWNuY2hmeDk3M3JB?=
 =?utf-8?B?VTVVQVB5Wkc1dmo1STlEd2c3dkZPTmJBMDQ0VjlqUkN3WDlWUURFMjNtcGkw?=
 =?utf-8?B?NzIxZUs1aDBicHNQcncvVzlVeDBTYkY3UXZKb1RkVExkZDR1QktnelIzVnZt?=
 =?utf-8?B?V2hDOG5LZGY3YmVPZFRwVVlJSys4SjNaRTBvdnFXU29oN2tRN09yZ0t1eGVl?=
 =?utf-8?B?MWpsU2tOVmNLd1RNZXY2Z3o0d0crSFRkTE5nbnpBVjVHRTAwZzNpK3hrdnNn?=
 =?utf-8?B?V1FXRjdtWXJmTWpHcm0yeUV1UHJzLzlUdW5CN0M1OFRMYlBVWXRBZCtWVGFS?=
 =?utf-8?B?VkZKeDF0V0dMcUpPbkFwVGhpbmZ6eHlJTmtLZ3ZvQkY4VUVPeUg3aGZZb0th?=
 =?utf-8?B?eUltVktBZzNQRnNZVlIveVA4RTBBeVJiNkl5ejZXQU5jZDdvYUMzQURjaDBZ?=
 =?utf-8?B?cmI1OW5aSjg4M0toL3JqM0NHQnlCZmtTYkhiaHNaSXpIU1RNMnVFMW5rK2J2?=
 =?utf-8?B?eDlvOUNUeVpFUGd2YlNJcmt4NHRmd2Q4d1IzVEZOd2FrLzNXQWxFb2NpN3cr?=
 =?utf-8?B?OGsyNHNsNzZxM1crVlBNek9kYlNLa3VhOC93WTBaYjFpTklYTm1ZM3hIdVJY?=
 =?utf-8?B?N1RwWVZIckhvcjZ2OGVoQ0lpaW4yUUhlMjFLM3oyNW1JZUt2V2txYlVKVlpk?=
 =?utf-8?B?TkhPZ2wxUi9RaEhCemVTNVFMNDh1dW01RGJueXBSV0hnWUZQcnBNUGsrMWZ4?=
 =?utf-8?B?eUtRTGx3dW1VZG9zQzVxNmJ6NW1rTk9NbWZ0SmQrMW5rd3N2a0g5UGxmZjhK?=
 =?utf-8?B?bGhGRFJCMVZIdGtyL2NCMGIyRU1sYWNTUXpIdFhEVnZCbXJyYkpDZ29LVVF6?=
 =?utf-8?B?eWZGakFNdGxhY2RnMXUxZzRKVzhTN2g4NE0yK1NnSGlGaVpoczVNZ0dhbjVw?=
 =?utf-8?B?WG1wWTJkZ1p1NFdOZVcwSjBmSUVqTUJnRmxlenExbmxnU1dRc2ZHZjBaTlYy?=
 =?utf-8?B?UkxHWlRrS3QveWZhekIySzN5YS9aQXhKdEtxWkdMZjZzRlpveXYrUDdLRGdN?=
 =?utf-8?B?N1J2bEhzREVpNFluaUJTZlpSdG9XTStMcGtzeE00YTZwZ3lxWmRKVklCSFk5?=
 =?utf-8?B?SkNwek1mbklEZldJVXdpblZlUW1rRURvU0x5TVBxMmFvcU1pek95K0x3elVD?=
 =?utf-8?B?dUFPUUNVUXM0cXVUOUdkYVVlUXRuY1c5SWNiRy9yV2JYdW13UnJhWmRBdTlI?=
 =?utf-8?B?Tkk3UDR1UlRJa0U1QlFtQjdsbGFEbmgwSXRMdVVpYUpPMkVNRVBCZHovNmZk?=
 =?utf-8?B?Wnd1dmhNc1Z0Q0tGdzZQVTRwcHZpK3BXVG15NXlsOCtNMUFRbG1yeGFFdTVY?=
 =?utf-8?B?NTVuQm4rSVBlMUhJWXJWUTFKMU5BcWxKWk5PSERBcjZmc09oNVFSR3lta2ND?=
 =?utf-8?B?WnhNNXhRa1QwNXQvQWt0a3l1a3JrTDErRS9QNmk3RXFWUERseEtNcWFWZFRZ?=
 =?utf-8?B?Y2dFQy9NbWduNGlNVUtNV3RxMGgxY0QvYmxsQ3J3V2R1eGpwM3NlV3BqUVVU?=
 =?utf-8?B?cWh1amNwR3k4R1RFU0xhUHBLLzBESXp2QWRQUTU2TVBoQ3JWY1Znd1ZNVlBk?=
 =?utf-8?B?UmhDaGVqVDc3dnRsN0h3M2lQQldqc0FFVWxMTDJUYnlIK2pLYU5kRHR0N25Y?=
 =?utf-8?B?ZHBOaENnWEZ5T2lWN21qRm5iK1FkY29tS1J6QURqdmtvTXk3VThzU3pyZ1pU?=
 =?utf-8?Q?yOaFQx3x0Xrb603bdc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BB1D449EC585E4D857DAFA6FA63F507@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae300369-f5cd-4909-0346-08d95f83472c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2021 00:26:08.8327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9oFbnDvDlsGC7sN2f0aoImPONgWixUNYEtju7qMe/hQk4Ql1vIjK8qVrDf7Jnf4nngrJPH7v2Jm0TomFKmxF1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpbmggTmd1eWVuIHdyb3RlOg0KPiBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+PiBIaSBUaGluaCwN
Cj4+DQo+PiBPbiA4LzEzLzIwMjEgNDoyMSBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4+IFdl
c2xleSBDaGVuZyB3cm90ZToNCj4+Pj4gSGkgVGhpbmgsDQo+Pj4+DQo+Pj4+IE9uIDgvMTIvMjAy
MSAyOjMxIFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+Pj4+PiBXZXNsZXkgQ2hlbmcgd3JvdGU6
DQo+Pj4+Pj4gSGkgVGhpbmgsDQo+Pj4+Pj4NCj4+Pj4+PiBPbiA4LzExLzIwMjEgNTo0NyBQTSwg
VGhpbmggTmd1eWVuIHdyb3RlOg0KPj4+Pj4+PiBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+Pj4+Pj4+
PiBEdXJpbmcgYSBVU0IgY2FibGUgZGlzY29ubmVjdCwgb3Igc29mdCBkaXNjb25uZWN0IHNjZW5h
cmlvLCBhIHBlbmRpbmcNCj4+Pj4+Pj4+IFNFVFVQIHRyYW5zYWN0aW9uIG1heSBub3QgYmUgY29t
cGxldGVkLCBsZWFkaW5nIHRvIHRoZSBmb2xsb3dpbmcNCj4+Pj4+Pj4+IGVycm9yOg0KPj4+Pj4+
Pj4NCj4+Pj4+Pj4+ICAgICBkd2MzIGE2MDAwMDAuZHdjMzogdGltZWQgb3V0IHdhaXRpbmcgZm9y
IFNFVFVQIHBoYXNlDQo+Pj4+Pj4+DQo+Pj4+Pj4+IEhvdyBjb3VsZCBpdCBiZSBhIGNhc2Ugb2Yg
Y2FibGUgZGlzY29ubmVjdD8gVGhlIHB1bGx1cCgwKSBvbmx5IGFwcGxpZXMNCj4+Pj4+Pj4gZm9y
IHNvZnQtZGlzY29ubmVjdCBzY2VuYXJpby4gSWYgdGhlIGRldmljZSBpbml0aWF0ZWQgYSBkaXNj
b25uZWN0LCB0aGVuDQo+Pj4+Pj4NCj4+Pj4+PiBUaGFua3MgZm9yIHRoZSByZXNwb25zZS4gIEkg
Z3Vlc3MgdGhpcyBpcyBzcGVjaWZpYyBmb3Igc29tZSB1c2UgY2FzZXMsDQo+Pj4+Pj4gYnV0IHNv
bWUgYXBwbGljYXRpb25zIHN1Y2ggYXMgQURCIHdpbGwgY2xvc2UgdGhlIEZGUyBFUCBmaWxlcyBh
ZnRlciBpdA0KPj4+Pj4+IGdldHMgdGhlIGRpc2Nvbm5lY3Rpb24gZXZlbnQsIGxlYWRpbmcgdG8g
dGhpcyBwdWxsdXAgZGlzYWJsZSBhcyB3ZWxsLg0KPj4+Pj4+IFNvIGl0cyBzcGVjaWZpYyB0byB0
aGF0IHBhcnRpY3VsYXIgdXNlIGNhc2UuDQo+Pj4+Pg0KPj4+Pj4gRG9lcyB0aGF0IG1lYW4gdGhh
dCB0aGUgQURCIGFwcGxpY2F0aW9uIHdvbid0IGV4cGVjdCBhIGNvbm5lY3Rpb24gdW50aWwNCj4+
Pj4+IHVzZXIgaW50ZXJ2ZW50aW9uIG9yIHNvbWUgb3RoZXIgbm90aWZpY2F0aW9uIHRvIGRvIHB1
bGx1cCgxKT8NCj4+Pj4+DQo+Pj4+DQo+Pj4+IFllcywgY29ycmVjdC4gIFRoZSBBbmRyb2lkIFVT
QiBmcmFtZXdvcmsgd2lsbCB0cmlnZ2VyIHRoZSBwdWxsdXAoMSkgYWdhaW4uDQo+Pj4+DQo+Pj4+
Pj4NCj4+Pj4+Pj4gdGhlIGRyaXZlciBzaG91bGQgd2FpdCBmb3IgdGhlIGNvbnRyb2wgcmVxdWVz
dCB0byBjb21wbGV0ZS4gSWYgaXQgdGltZXMNCj4+Pj4+Pj4gb3V0LCBzb21ldGhpbmcgaXMgYWxy
ZWFkeSB3cm9uZyBoZXJlLiBUaGUgcHJvZ3JhbW1pbmcgZ3VpZGUgb25seQ0KPj4+Pj4+PiBtZW50
aW9ucyB0aGF0IHdlIHNob3VsZCB3YWl0IGZvciBjb21wbGV0aW9uLCBidXQgaXQgZG9lc24ndCBz
YXkgYWJvdXQNCj4+Pj4+Pj4gcmVjb3ZlcnkgaW4gYSBjYXNlIG9mIGh1bmcgdHJhbnNmZXIuIEkg
bmVlZCB0byBjaGVjayBpbnRlcm5hbGx5IGJ1dCBpdA0KPj4+Pj4+PiBzaG91bGQgYmUgc2FmZSB0
byBpc3N1ZSBFbmQgVHJhbnNmZXIuDQo+Pj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+PiBZZXMsIHdoYXQg
SSBkaWQgd2FzIG1vZGlmeSBhIGRldmljZSBydW5uaW5nIHRoZSBMaW51eCBYSENJIHN0YWNrIHcv
bw0KPj4+Pj4+IHJlYWRpbmcvc2VuZGluZyBvdXQgdGhlIFNFVFVQIERBVEEgcGhhc2UsIHNvIHRo
YXQgb24gdGhlIGRldmljZSBlbmQgd2UnZA0KPj4+Pj4+IGFsd2F5cyBydW4gaW50byB0aGF0IHNp
dHVhdGlvbiB3aGVyZSB0aGVyZSdzIHN0aWxsIGEgcGVuZGluZyBFUDAgVFJCIHF1ZXVlZC4NCj4+
Pj4+DQo+Pj4+PiBJcyB0aGlzIG9ubHkgZm9yIHZhbGlkYXRpb24gcHVycG9zZT8NCj4+Pj4+DQo+
Pj4+DQo+Pj4+IFllcywganVzdCB0byBoZWxwIHZlcmlmeSB0aGUgZml4IGJ5IGluamVjdGluZyB0
aGUgZXJyb3IgY29uZGl0aW9uLg0KPj4+DQo+Pj4gSnVzdCB3YW50IHRvIGNsYXJpZnksIHNvIHlv
dSBkaWRuJ3QgcmVhbGx5IHJ1biBpbnRvIHRoaXMgcHJvYmxlbSBidXQNCj4+PiB3YW50IHRvIGZp
eCB0aGUgcmVjb3ZlcnkgcGF0aCByaWdodD8NCj4+Pg0KPj4gTm8sIHdlIHJhbiBpbnRvIHRoaXMg
aXNzdWUsIGJ1dCBpdCB3YXMgb25seSBzZWVuIGluIG91ciBtYXNzIGRldmljZQ0KPj4gdGVzdGlu
Zy4gIEkgb25seSBtYWRlIHRoZSBjaGFuZ2VzIHRvIHNpbXVsYXRlIHRoZSBpc3N1ZSwgc28gdGhl
biBJDQo+PiB3b3VsZG4ndCBuZWVkIHRvIGhhdmUgdG8gd2FpdCBmb3IgdGhlIHRlc3QgcmVzdWx0
cy4NCj4+DQo+PiBIb3dldmVyLCB3ZSBkaWQgZ2V0IGEgbWFzcyBkZXZpY2UgdGVzdCBydW4gaW4g
dy8gdGhlIGNoYW5nZXMsIGFuZCB0aGV5DQo+PiB3ZXJlIHVuYWJsZSB0byByZXByb2R1Y2UgdGhl
IHNhbWUgaXNzdWVzIHdlJ3ZlIGJlZW4gc2VlaW5nLCBzbyB0aGlzIGRvZXMNCj4+IGZpeCBhbiBh
Y3R1YWwgaXNzdWUuDQo+IA0KPiBPaw0KPiANCj4+Pj4NCj4+Pj4+Pg0KPj4+Pj4+IFdlJ3JlIHJ1
bm5pbmcgbXVsdGlwbGUgZGV2aWNlcyB3aXRoIHRoaXMgZml4IGFzIHdlbGwsIGFuZCBkb2luZyBk
ZXZpY2UNCj4+Pj4+PiBpbml0aWF0ZWQgZGlzY29ubmVjdC4NCj4+Pj4+Pg0KPj4+Pj4+Pj4NCj4+
Pj4+Pj4+IElmIHRoaXMgb2NjdXJzLCB0aGVuIHRoZSBlbnRpcmUgcHVsbHVwIGRpc2FibGUgcm91
dGluZSBpcyBza2lwcGVkIGFuZA0KPj4+Pj4+Pj4gcHJvcGVyIGNsZWFudXAgYW5kIGhhbHRpbmcg
b2YgdGhlIGNvbnRyb2xsZXIgZG9lcyBub3QgY29tcGxldGUuDQo+Pj4+Pj4+PiBJbnN0ZWFkIG9m
IHJldHVybmluZyBhbiBlcnJvciAod2hpY2ggaXMgaWdub3JlZCBmcm9tIHRoZSBVREMNCj4+Pj4+
Pj4+IHBlcnNwZWN0aXZlKSwgZG8gd2hhdCBpcyBtZW50aW9uZWQgaW4gdGhlIGNvbW1lbnRzIGFu
ZCBmb3JjZSB0aGUNCj4+Pj4+Pj4+IHRyYW5zYWN0aW9uIHRvIGNvbXBsZXRlIGFuZCBwdXQgdGhl
IGVwMHN0YXRlIGJhY2sgdG8gdGhlIFNFVFVQIHBoYXNlLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IFNp
Z25lZC1vZmYtYnk6IFdlc2xleSBDaGVuZyA8d2NoZW5nQGNvZGVhdXJvcmEub3JnPg0KPj4+Pj4+
Pj4gLS0tDQo+Pj4+Pj4+PiAgZHJpdmVycy91c2IvZHdjMy9lcDAuYyAgICB8IDQgKystLQ0KPj4+
Pj4+Pj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCA2ICsrKysrLQ0KPj4+Pj4+Pj4gIGRy
aXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmggfCAzICsrKw0KPj4+Pj4+Pj4gIDMgZmlsZXMgY2hhbmdl
ZCwgMTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9lcDAuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZXAw
LmMNCj4+Pj4+Pj4+IGluZGV4IDY1ODczOTQuLmFiZmM0MmIgMTAwNjQ0DQo+Pj4+Pj4+PiAtLS0g
YS9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jDQo+Pj4+Pj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2Mz
L2VwMC5jDQo+Pj4+Pj4+PiBAQCAtMjE4LDcgKzIxOCw3IEBAIGludCBkd2MzX2dhZGdldF9lcDBf
cXVldWUoc3RydWN0IHVzYl9lcCAqZXAsIHN0cnVjdCB1c2JfcmVxdWVzdCAqcmVxdWVzdCwNCj4+
Pj4+Pj4+ICAJcmV0dXJuIHJldDsNCj4+Pj4+Pj4+ICB9DQo+Pj4+Pj4+PiAgDQo+Pj4+Pj4+PiAt
c3RhdGljIHZvaWQgZHdjM19lcDBfc3RhbGxfYW5kX3Jlc3RhcnQoc3RydWN0IGR3YzMgKmR3YykN
Cj4+Pj4+Pj4+ICt2b2lkIGR3YzNfZXAwX3N0YWxsX2FuZF9yZXN0YXJ0KHN0cnVjdCBkd2MzICpk
d2MpDQo+Pj4+Pj4+PiAgew0KPj4+Pj4+Pj4gIAlzdHJ1Y3QgZHdjM19lcAkJKmRlcDsNCj4+Pj4+
Pj4+ICANCj4+Pj4+Pj4+IEBAIC0xMDczLDcgKzEwNzMsNyBAQCB2b2lkIGR3YzNfZXAwX3NlbmRf
ZGVsYXllZF9zdGF0dXMoc3RydWN0IGR3YzMgKmR3YykNCj4+Pj4+Pj4+ICAJX19kd2MzX2VwMF9k
b19jb250cm9sX3N0YXR1cyhkd2MsIGR3Yy0+ZXBzW2RpcmVjdGlvbl0pOw0KPj4+Pj4+Pj4gIH0N
Cj4+Pj4+Pj4+ICANCj4+Pj4+Pj4+IC1zdGF0aWMgdm9pZCBkd2MzX2VwMF9lbmRfY29udHJvbF9k
YXRhKHN0cnVjdCBkd2MzICpkd2MsIHN0cnVjdCBkd2MzX2VwICpkZXApDQo+Pj4+Pj4+PiArdm9p
ZCBkd2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKHN0cnVjdCBkd2MzICpkd2MsIHN0cnVjdCBkd2Mz
X2VwICpkZXApDQo+Pj4+Pj4+PiAgew0KPj4+Pj4+Pj4gIAlzdHJ1Y3QgZHdjM19nYWRnZXRfZXBf
Y21kX3BhcmFtcyBwYXJhbXM7DQo+Pj4+Pj4+PiAgCXUzMgkJCWNtZDsNCj4+Pj4+Pj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYw0KPj4+Pj4+Pj4gaW5kZXggNTRjNWEwOC4uYTBlMmU0ZCAxMDA2NDQNCj4+Pj4+Pj4+IC0t
LSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMNCj4+Pj4+Pj4+IEBAIC0yNDM3LDcgKzI0MzcsMTEgQEAgc3RhdGljIGlu
dCBkd2MzX2dhZGdldF9wdWxsdXAoc3RydWN0IHVzYl9nYWRnZXQgKmcsIGludCBpc19vbikNCj4+
Pj4+Pj4+ICAJCQkJbXNlY3NfdG9famlmZmllcyhEV0MzX1BVTExfVVBfVElNRU9VVCkpOw0KPj4+
Pj4+Pj4gIAkJaWYgKHJldCA9PSAwKSB7DQo+Pj4+Pj4+PiAgCQkJZGV2X2Vycihkd2MtPmRldiwg
InRpbWVkIG91dCB3YWl0aW5nIGZvciBTRVRVUCBwaGFzZVxuIik7DQo+Pj4+Pj4+PiAtCQkJcmV0
dXJuIC1FVElNRURPVVQ7DQo+Pj4+Pj4+PiArCQkJc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9j
aywgZmxhZ3MpOw0KPj4+Pj4+Pj4gKwkJCWR3YzNfZXAwX2VuZF9jb250cm9sX2RhdGEoZHdjLCBk
d2MtPmVwc1swXSk7DQo+Pj4+Pj4+PiArCQkJZHdjM19lcDBfZW5kX2NvbnRyb2xfZGF0YShkd2Ms
IGR3Yy0+ZXBzWzFdKTsNCj4+Pj4+Pj4NCj4+Pj4+Pj4gRW5kIHRyYW5zZmVyIGNvbW1hbmQgdGFr
ZXMgdGltZSwgbmVlZCB0byB3YWl0IGZvciBpdCB0byBjb21wbGV0ZSBiZWZvcmUNCj4+Pj4+Pj4g
aXNzdWluZyBTdGFydCB0cmFuc2ZlciBhZ2Fpbi4gQWxzbywgd2h5IHJlc3RhcnQgYWdhaW4gd2hl
biBpdCdzIGFib3V0IHRvDQo+Pj4+Pj4+IGJlIGRpc2Nvbm5lY3RlZC4NCj4+Pj4+Pg0KPj4+Pj4+
IEkgY2FuIHRyeSB3aXRob3V0IHJlc3RhcnRpbmcgaXQgYWdhaW4sIGFuZCBzZWUgaWYgdGhhdCB3
b3Jrcy4gIEluc3RlYWQNCj4+Pj4+PiBvZiB3YWl0aW5nIGZvciB0aGUgY29tbWFuZCBjb21wbGV0
ZSBldmVudCwgY2FuIHdlIHNldCB0aGUgRm9yY2VSTSBiaXQsDQo+Pj4+Pj4gc2ltaWxhciB0byB3
aGF0IHdlIGRvIGZvciBkd2MzX3JlbW92ZV9yZXF1ZXN0cygpPw0KPj4+Pj4+DQo+Pj4+Pg0KPj4+
Pj4gRm9yY2VSTT0xIG1lYW5zIHRoYXQgdGhlIGNvbnRyb2xsZXIgd2lsbCBpZ25vcmUgdXBkYXRp
bmcgdGhlIFRSQnMNCj4+Pj4+IChpbmNsdWRpbmcgbm90IGNsZWFyaW5nIHRoZSBIV08gYW5kIHJl
bWFpbiB0cmFuc2ZlciBzaXplKS4gVGhlIGRyaXZlcg0KPj4+Pj4gc3RpbGwgbmVlZHMgdG8gd2Fp
dCBmb3IgdGhlIGNvbW1hbmQgdG8gY29tcGxldGUgYmVmb3JlIGlzc3VpbmcgU3RhcnQNCj4+Pj4+
IFRyYW5zZmVyIGNvbW1hbmQuIE90aGVyd2lzZSBTdGFydCBUcmFuc2ZlciB3b24ndCBnbyB0aHJv
dWdoLiBJZiB3ZSBrbm93DQo+Pj4+PiB0aGF0IHdlJ3JlIG5vdCBnb2luZyB0byBpc3N1ZSBTdGFy
dCBUcmFuc2ZlciBhbnkgdGltZSBzb29uLCB0aGVuIHdlIG1heQ0KPj4+Pj4gYmUgYWJsZSB0byBn
ZXQgYXdheSB3aXRoIGlnbm9yaW5nIEVuZCBUcmFuc2ZlciBjb21tYW5kIGNvbXBsZXRpb24uDQo+
Pj4+Pg0KPj4+Pg0KPj4+PiBJIHNlZS4gIEN1cnJlbnRseSwgaW4gdGhlIHBsYWNlIHRoYXQgd2Ug
ZG8gdXNlDQo+Pj4+IGR3YzNfZXAwX2VuZF9jb250cm9sX2RhdGEoKSwgaXRzIGZvbGxvd2VkIGJ5
DQo+Pj4+IGR3YzNfZXAwX3N0YWxsX2FuZF9yZXN0YXJ0KCkgd2hpY2ggd291bGQgZXhlY3V0ZSBz
dGFydCB0cmFuc2Zlci4gIEZvcg0KPj4+DQo+Pj4gVGhhdCBkb2Vzbid0IGxvb2sgcmlnaHQuIFlv
dSBjYW4gdHJ5IHRvIHNlZSBpZiBpdCBjYW4gcmVjb3ZlciBmcm9tIGENCj4+PiBjb250cm9sIHdy
aXRlIHJlcXVlc3QuIE9mdGVuIHRpbWUgd2UgZG8gY29udHJvbCByZWFkIGFuZCBub3Qgd3JpdGUu
DQo+Pj4gKGkuZS4gdHJ5IHRvIEVuZCBUcmFuc2ZlciBhbmQgaW1tZWRpYXRlbHkgU3RhcnQgVHJh
bnNmZXIgb24gdGhlIHNhbWUNCj4+PiBkaXJlY3Rpb24gY29udHJvbCBlbmRwb2ludCkuDQo+Pj4N
Cj4+IE9LLCBJIGNhbiB0cnksIGJ1dCBqdXN0IHRvIGNsYXJpZnksIEkgd2FzIHJlZmVycmluZyB0
byBob3cgaXQgd2FzIGJlaW5nDQo+PiBkb25lIGluOg0KPj4NCj4+IHN0YXRpYyB2b2lkIGR3YzNf
ZXAwX3hmZXJub3RyZWFkeShzdHJ1Y3QgZHdjMyAqZHdjLA0KPj4gCQljb25zdCBzdHJ1Y3QgZHdj
M19ldmVudF9kZXBldnQgKmV2ZW50KQ0KPj4gew0KPj4gLi4uDQo+PiAJCWlmIChkd2MtPmVwMF9l
eHBlY3RfaW4gIT0gZXZlbnQtPmVuZHBvaW50X251bWJlcikgew0KPj4gCQkJc3RydWN0IGR3YzNf
ZXAJKmRlcCA9IGR3Yy0+ZXBzW2R3Yy0+ZXAwX2V4cGVjdF9pbl07DQo+Pg0KPj4gCQkJZGV2X2Vy
cihkd2MtPmRldiwgInVuZXhwZWN0ZWQgZGlyZWN0aW9uIGZvciBEYXRhIFBoYXNlXG4iKTsNCj4+
IAkJCWR3YzNfZXAwX2VuZF9jb250cm9sX2RhdGEoZHdjLCBkZXApOw0KPj4gCQkJZHdjM19lcDBf
c3RhbGxfYW5kX3Jlc3RhcnQoZHdjKTsNCj4+IAkJCXJldHVybjsNCj4+IAkJfQ0KPj4NCg0KTG9v
a2luZyBhdCB0aGlzIHNuaXBwZXQgYWdhaW4sIGl0IGxvb2tzIHdyb25nLiBGb3IgY29udHJvbCB3
cml0ZQ0KdW5leHBlY3RlZCBkaXJlY3Rpb24sIGlmIHRoZSBkcml2ZXIgaGFzbid0IHNldHVwIGFu
ZCBzdGFydGVkIHRoZSBEQVRBDQpwaGFzZSB5ZXQsIHRoZW4gaXQncyBmaW5lLCBidXQgdGhlcmUg
aXMgYSBwcm9ibGVtIGlmIGl0IGRpZC4NCg0KU2luY2UgZHdjM19lcDBfZW5kX2NvbnRyb2xfZGF0
YSgpIGRvZXNuJ3QgaXNzdWUgRW5kIFRyYW5zZmVyIGNvbW1hbmQgdG8NCmVwMCBkdWUgdG8gdGhl
IHJlc291cmNlX2luZGV4IGNoZWNrLCBpdCBkb2Vzbid0IGZvbGxvdyB0aGUgY29udHJvbA0KdHJh
bnNmZXIgZmxvdyBtb2RlbCBpbiB0aGUgcHJvZ3JhbW1pbmcgZ3VpZGUuIFRoaXMgbWF5IGNhdXNl
DQpkd2MzX2VwMF9zdGFsbF9hbmRfcmVzdGFydCgpIHRvIG92ZXJ3cml0ZSB0aGUgVFJCcyBmb3Ig
dGhlIERBVEEgcGhhc2UNCndpdGggU0VUVVAgc3RhZ2UuIEFsc28sIGlmIHRoZSBlcDAgaXMgYWxy
ZWFkeSBzdGFydGVkLCB0aGUgZHJpdmVyIHdvbid0DQppc3N1ZSBTdGFydCBUcmFuc2ZlciBjb21t
YW5kIGFnYWluLg0KDQpUaGlzIGlzc3VlIGlzIHVubGlrZWx5IHRvIG9jY3VyIHVubGVzcyB3ZSBz
ZWUgYSBtaXNiZWhhdmUgaG9zdCBmb3INCmNvbnRyb2wgd3JpdGUgcmVxdWVzdC4gUmVnYXJkbGVz
cywgd2UgbmVlZCB0byBmaXggdGhpcy4gSSBtYXkgbmVlZCBzb21lDQp0aW1lIGJlZm9yZSBJIGNh
biBjcmVhdGUgYSBwYXRjaCBhbmQgdGVzdCBpdC4gSWYgeW91IG9yIGFueW9uZSBpcyB1cCB0bw0K
dGFrZSB0aGlzIG9uLCBpdCdkIGJlIGhpZ2hseSBhcHByZWNpYXRlZC4NCg0KSWYgSSBtaXNzZWQg
YW55dGhpbmcsIGRvIGxldCBtZSBrbm93Lg0KDQpUaGFua3MsDQpUaGluaA0K
