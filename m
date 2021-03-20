Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D6F3429DE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 03:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhCTCCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 22:02:07 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:40120 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229447AbhCTCBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 22:01:48 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B595FC00D3;
        Sat, 20 Mar 2021 02:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1616205705; bh=FyGli3fj6ZrRaItpNT1NkdjHOU1sPhmeHThw614vZ+M=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=OCc1qcDZryVVcrtv3oFpTwFV+j3mNFKo1iO9IEYM3eHsirByhV3WUi0XFNR8EwRU5
         tGFceh2p3y8XMxvVeXYM0DT/Pswhp7dq+DSu64xiylKM5ta08ZIb8MenYQRpoeIWPU
         iYaqK1A4ABOIYDAKDFKCldQpMw0qrV9wH1ifRV9hkJGvwv8GAPiffDsAc3X7+n/LKM
         vjYOM8RdPQhZ1xQb5n3g+OXAluR7Z2UhY54WfXvt/udsIo2VKXkT7EGgFssvTGqM7a
         ZOzxah39hKaWSclRY/CDw51xfQwZcWyN9p78YmfiUqBSMGEsc0VZonv9y3Bby4hjQ7
         deyCsitdexqRg==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2C97FA006A;
        Sat, 20 Mar 2021 02:01:45 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2056.outbound.protection.outlook.com [104.47.38.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 245C080056;
        Sat, 20 Mar 2021 02:01:43 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Cl134jv6";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKpj4wkwPEpvrlJBqlyF7Tcy3FWatvqeaGoxLv762H9ZalxHk0KUGHd4mdb84Go5utIaaF54D5CcmvAgMOyTghhnKndKKs7mCU/ju7/xyOX+3rG3vOG6GgwKkg6aUqeHatVz5IXFNLWv/NGaC9prmXINWFRzWKnpxcIkvB+gXZU/Xj1GTGHtrMOtlILnfMA6dMyZBRK4cVWOrA4Pr2emSQlQ71SdrdoctyoaTGK1On+/dFX67PiGIW/Is34aRuaYqvbhaZWn4uchB9B+7k7h+Q1nS77Z3DyQ8aF5DyDWDzKO8eFUNQ0yKf17sHOrEmALZ0U2+EZTULPsnWMInf3JMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyGli3fj6ZrRaItpNT1NkdjHOU1sPhmeHThw614vZ+M=;
 b=Fq1Rfl7gu88upgGiPL9LoTE0gqOE5dhxzwA/0YEboxz0cohA8rv2fi2c67D1v++ji9M645GNcvUpQd3ByjNVScVQ4Afl3otGasGS1lvNcUoBi8mMW3THC3hilmk9r7fbaqaMlaLChspKu9pXUB4x7wZRrJikjH2zVQr4UOx6FtZBr3kYMY03AL8hx9NV9kkEcj7v4ac7n+xBpnOoVI8Zka6geaxeUxo2cYSE1KCJ/e3WyRAjlqEpqJGWNsIXQNP9whsvzKwijkL8ynhk3xruVspZeoOLfMsOXcDiHEEB53oh3OcNXToKvBcoHN8BuvdFrz3Jk0k47Gb/+bXHf6WEMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyGli3fj6ZrRaItpNT1NkdjHOU1sPhmeHThw614vZ+M=;
 b=Cl134jv6j7vAC13syP1N2pxImqS+SGFTZZJu/9XgXrc7TXhf5+cOb701rfHm0ZKQx11XlnX0BupbnUwl751J7SejqtIlhaJ1odjcLtRJzn15Aa/XK2X2klX3cGjq4WTBtNoZ25hGEoho+YG5cZX8CWOAF1M5CU50TtUvkjwCIUk=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB3304.namprd12.prod.outlook.com (2603:10b6:a03:139::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sat, 20 Mar
 2021 02:01:40 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c%6]) with mapi id 15.20.3955.023; Sat, 20 Mar 2021
 02:01:40 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 2/2] usb: dwc3: gadget: Ignore EP queue requests during
 bus reset
Thread-Topic: [PATCH 2/2] usb: dwc3: gadget: Ignore EP queue requests during
 bus reset
Thread-Index: AQHXHKLL7cdvVEBRMk+XgbJ+0C2uUaqMCeEAgAAHrQCAAA8agA==
Date:   Sat, 20 Mar 2021 02:01:40 +0000
Message-ID: <debcdb02-1164-df83-1174-440dbe31dcc3@synopsys.com>
References: <1616146285-19149-1-git-send-email-wcheng@codeaurora.org>
 <1616146285-19149-3-git-send-email-wcheng@codeaurora.org>
 <eae3f779-acb0-c685-4323-d97c7c5c6296@synopsys.com>
 <1886f649-3da2-de25-405c-69c66876b0fd@codeaurora.org>
In-Reply-To: <1886f649-3da2-de25-405c-69c66876b0fd@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5a8d4a8-3f47-4503-3d59-08d8eb441a56
x-ms-traffictypediagnostic: BYAPR12MB3304:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB33043DC0ACEC1B8872164E5BAA679@BYAPR12MB3304.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y804RzdKTugWFhCmWBINNN8ZhcqN2MOZMfvb4AyqjoWPuk6Gpt0rDl2cTkEUQZHp3NZg6qV/K/PDfRTw8SrvCWzAjlqnH0uzAEEwPeFFrdsR8G3SsYx0n6jKbcV+fYnB856CNuAAszvPmpLEFKza4/qf33cxiffqPlcV+s5FqvpYEinxK0AtVX/5I8sd3krSSf2ydNXRWxYmkxGNvHM7JoOU6UWSEbyIyzAUMNbjoGKjPjGTywldj8lGjNQTEHUW8Gsl4nw4jt4BetehnDzKA56pGdjdi8ne7SQiAasjrqtLs6YXhuctVJLtCG9HaSzO0vOzO7LBgBRK/uJHU9gdGDOERG06fX9B3fqhGubgVB3rkZaeqvZUYBwqFS7IEj1/cI3WK1auMbXt4Exysj/Gfs/JN6vtoe4eiGnB2Pu7rCMV5VibPLKM06VwooVqS5d7SAAnWIOwB1ly9NF3wUqL5GJASA/dXDDd2WfzmPrAYMcVecAErJZ6trbZb2dkj0fzjCo6fHd1+u00eYBE2j/W64XzP7U5s6ZthFIQMLiKR3zUjOd4lX62WjYSIaGYTNZ3FbOoXHfCijkhna9oWQqkOVSrcLfKmeJ7sT1ljJbaVK1++gXn6s+2SkT6twJyFLEcropWWNkXA8V/04EJQk5oscDfBgKrWiVvpN4228PfmOpXY9ojECj3cgOW6cL6Ij53Hm2ugNjicbod+R1GYQ0jk3j0AzTUSk6ULwqkQKxVEr8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(39860400002)(136003)(376002)(316002)(8676002)(5660300002)(31686004)(83380400001)(6512007)(36756003)(186003)(86362001)(4326008)(38100700001)(6486002)(2616005)(2906002)(54906003)(478600001)(31696002)(66446008)(71200400001)(64756008)(53546011)(66556008)(6506007)(66476007)(66946007)(110136005)(76116006)(8936002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?b0Rwbkg0a2RlalkvaUhaM0hpK3N6MXN0ZERYa2JaTlE4aFQ2ZWxvK09Rd0ZF?=
 =?utf-8?B?TVFGbGdKRloxL3BWYUlKRXpHYmlXb3RDeEpFTC9yU2N3TlZvZDNhZk5SOFNK?=
 =?utf-8?B?MlRtS1VWbERUMG9lbmozUGpvcFBQR1hyb0hMWlh5aGtoMk02ZHRVVml6S09v?=
 =?utf-8?B?ei9EbDVwc2UrR2VnTzhCRUg0TWJLRFZRRVdKb3czOGdObUV6bjEzS0JOSnR1?=
 =?utf-8?B?L2hHMDhiT09sUHk3WkRmVjFuRFFiMkhNVW55RlFTQ05tbEY0eWV1S0VsYitI?=
 =?utf-8?B?RERVK2JGOEQzRmdWYm1hNTJCSTRZVFFBSjJ1bVBBSzhUYUg0cFQ4amsyWkxu?=
 =?utf-8?B?MHBSWUxvbW5KU1RoQzFDcWExMDhIUzVQcERHbUdGMXRHbUc0WjNFWDNhYVVl?=
 =?utf-8?B?bEtaQ243SStUcnVNWVZDNmEzNXc0djZPZ3hydVIwWFRTSjZkdDVrRDI4dzRl?=
 =?utf-8?B?MGZ6L3VrWHh0VnVoR0I2bWd6Q1VnbTFoUTNHWllsTGpGc0l6aTZxWnFXLzA4?=
 =?utf-8?B?MFlMMGRWdzhkZTErUTlwNFVwR1RYSTBXMDFVSStxeGU0TUthQUZRdXJRZ0pC?=
 =?utf-8?B?U2x5RGlJUVV2YWhTa2k1WURJNXdqL2VtUzVncDBSZzFEdFpkVDBmRlJOV2Yr?=
 =?utf-8?B?L2V1b1JjV2c2NmJ2U1hQWU5QZHh5MlRtTjc5YVQ4c0RMRW4wR0UyYVJvWEJ0?=
 =?utf-8?B?UlkxNzRIeWN1REIvSndhUEhkc3pnaXk5NHk0NURQcTZpUWtXQUJTV2l6VXBT?=
 =?utf-8?B?K0xkbUllbTZ6bGhDQVVnd0pIbEtYd0xrU0czMjRtTzVDSmpXOUZvaFlUQm1h?=
 =?utf-8?B?aStrLyt5bGNJUG1aTzRjUS96NmUxVDFzSVp3d25uMXYwK2xBMERubmVtbExI?=
 =?utf-8?B?M2pGaVZXbXE4K0tkdDgrZXFrYTVVMHExZmdCNmlCajlNeHY3NDRWVkhDTEV2?=
 =?utf-8?B?UGs5ZDFYQkUwQU9uZi9XZUNMcW1GTjdnbzgydnkwRlNac0RFaFVCYjFBVC9Q?=
 =?utf-8?B?dXV6MG91ZGlMdnhkb0IvQUlPL2dqUTVrNFFmUDZRS0Jqa3dRQlhaeWJIQlRN?=
 =?utf-8?B?L3FmQm1PNmJhaS9wNDhSbHpOTXRIcExaQmU5UkdrSkVvNWlhdC9kWTlYNWxP?=
 =?utf-8?B?QU9qRkUrMDdSTGR5OFZISWhpMG1Db3Bma1d1REpJZm14MHRyNWYwMXRCK2V5?=
 =?utf-8?B?SlhaQzhIcUpjVVpZaWgwck9VZk1RcVc4S0Z2N2ppRCsySWsvL3FPK0dWYkxu?=
 =?utf-8?B?N1hDVE9ML0lrZi8zcGNrWHdjbmpZV2V4NmRMQ0hkekNpOElDSG5ZWDVLUGNO?=
 =?utf-8?B?Z0dDQnBrZENoVHJrT0xhNjRQN3JCbFA0TVZXV2lwRFRmQlhDQ0NLTVhaQTJa?=
 =?utf-8?B?di9oY2hTUXB1dUtmV0RsbHhXQlpPcEZzYTZ0Q25MelQ5NEtOTW5YVFUrQkh6?=
 =?utf-8?B?T3U5TmpZdnlMdmpBSXJ4clhkb1pXMHBDeThUZW9nNUVVUTVHdFJLTStmbU94?=
 =?utf-8?B?dk1lcE5lYjhnWFZHYWNSN3pjWW9aTFRGU2VMeUZtSFdDNEQxQlVwNlltNEdn?=
 =?utf-8?B?dmd6L01KRU91bDRSNE5vaFpXRk5PRDkrdXJYU2lqeElRRGdlNjlPeFhBMFVv?=
 =?utf-8?B?VURSallRUk9LaFY2dnFBTFQ1TFE3YWI5dlE3NHBCWGMzTEYwdHFGZ1NVbUMy?=
 =?utf-8?B?dmh4YjdmVWRWak1XVitkNWdJT3ZiSjZSNTUydzJERVNDenlWRkl2ZmZ2d0NJ?=
 =?utf-8?Q?Jg1ZitdJD4AEgSN0q36BEZRoAAEZPqBbMlh2PQp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB67CD88C6D72348B7D011ADC6DE7DA6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a8d4a8-3f47-4503-3d59-08d8eb441a56
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2021 02:01:40.3928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vPOHTkfQVD6F/xMOSgB5NwYOoQZpnlpjvVQExu8bv4zwdwGFAUFh1bwMn5TTKabwUyjdAFYYOJvcomtfLdJIoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3304
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPiANCj4gDQo+IE9uIDMvMTkvMjAyMSA1OjQwIFBNLCBUaGlu
aCBOZ3V5ZW4gd3JvdGU6DQo+PiBIaSwNCj4+DQo+PiBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+Pj4g
VGhlIGN1cnJlbnQgZHdjM19nYWRnZXRfcmVzZXRfaW50ZXJydXB0KCkgd2lsbCBzdG9wIGFueSBh
Y3RpdmUNCj4+PiB0cmFuc2ZlcnMsIGJ1dCBvbmx5IGFkZHJlc3NlcyBibG9ja2luZyBvZiBFUCBx
dWV1aW5nIGZvciB3aGlsZSB3ZSBhcmUNCj4+PiBjb21pbmcgZnJvbSBhIGRpc2Nvbm5lY3RlZCBz
Y2VuYXJpbywgaS5lLiBhZnRlciByZWNlaXZpbmcgdGhlIGRpc2Nvbm5lY3QNCj4+PiBldmVudC4g
IElmIHRoZSBob3N0IGRlY2lkZXMgdG8gaXNzdWUgYSBidXMgcmVzZXQgb24gdGhlIGRldmljZSwg
dGhlDQo+Pj4gY29ubmVjdGVkIHBhcmFtZXRlciB3aWxsIHN0aWxsIGJlIHNldCB0byB0cnVlLCBh
bGxvd2luZyBmb3IgRVAgcXVldWluZw0KPj4+IHRvIGNvbnRpbnVlIHdoaWxlIHdlIGFyZSBkaXNh
YmxpbmcgdGhlIGZ1bmN0aW9ucy4gIFRvIGF2b2lkIHRoaXMsIHNldCB0aGUNCj4+PiBjb25uZWN0
ZWQgZmxhZyB0byBmYWxzZSB1bnRpbCB0aGUgc3RvcCBhY3RpdmUgdHJhbnNmZXJzIGlzIGNvbXBs
ZXRlLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogV2VzbGV5IENoZW5nIDx3Y2hlbmdAY29kZWF1
cm9yYS5vcmc+DQo+Pj4gLS0tDQo+Pj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCA5ICsr
KysrKysrKw0KPj4+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMv
Z2FkZ2V0LmMNCj4+PiBpbmRleCA2ZTE0ZmRjLi5kNWVkMGY2OSAxMDA2NDQNCj4+PiAtLS0gYS9k
cml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+Pj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYw0KPj4+IEBAIC0zMzI3LDYgKzMzMjcsMTUgQEAgc3RhdGljIHZvaWQgZHdjM19nYWRnZXRf
cmVzZXRfaW50ZXJydXB0KHN0cnVjdCBkd2MzICpkd2MpDQo+Pj4gIAl1MzIJCQlyZWc7DQo+Pj4g
IA0KPj4+ICAJLyoNCj4+PiArCSAqIElkZWFsbHksIGR3YzNfcmVzZXRfZ2FkZ2V0KCkgd291bGQg
dHJpZ2dlciB0aGUgZnVuY3Rpb24NCj4+PiArCSAqIGRyaXZlcnMgdG8gc3RvcCBhbnkgYWN0aXZl
IHRyYW5zZmVycyB0aHJvdWdoIGVwIGRpc2FibGUuDQo+Pj4gKwkgKiBIb3dldmVyLCBmb3IgZnVu
Y3Rpb25zIHdoaWNoIGRlZmVyIGVwIGRpc2FibGUsIHN1Y2ggYXMgbWFzcw0KPj4+ICsJICogc3Rv
cmFnZSwgd2Ugd2lsbCBuZWVkIHRvIHJlbHkgb24gdGhlIGNhbGwgdG8gc3RvcCBhY3RpdmUNCj4+
PiArCSAqIHRyYW5zZmVycyBoZXJlLCBhbmQgYXZvaWQgYWxsb3dpbmcgb2YgcmVxdWVzdCBxdWV1
aW5nLg0KPj4+ICsJICovDQo+Pj4gKwlkd2MtPmNvbm5lY3RlZCA9IGZhbHNlOw0KPj4+ICsNCj4+
PiArCS8qDQo+Pj4gIAkgKiBXT1JLQVJPVU5EOiBEV0MzIHJldmlzaW9ucyA8MS44OGEgaGF2ZSBh
biBpc3N1ZSB3aGljaA0KPj4+ICAJICogd291bGQgY2F1c2UgYSBtaXNzaW5nIERpc2Nvbm5lY3Qg
RXZlbnQgaWYgdGhlcmUncyBhDQo+Pj4gIAkgKiBwZW5kaW5nIFNldHVwIFBhY2tldCBpbiB0aGUg
RklGTy4NCj4+Pg0KPj4NCj4+IFRoaXMgZG9lc24ndCBsb29rIHJpZ2h0LiBEaWQgeW91IGhhdmUg
cmViYXNlIGlzc3VlIHdpdGggeW91ciBsb2NhbA0KPj4gY2hhbmdlIGFnYWluPw0KPj4NCj4+IEJS
LA0KPj4gVGhpbmgNCj4+DQo+IEhpIFRoaW5oLA0KPiANCj4gVGhpcyB3YXMgcmViYXNlZCBvbiBH
cmVnJ3MgdXNiLWxpbnVzIGJyYW5jaCwgd2hpY2ggaGFzIGNvbW1pdA0KPiBmMDlkZGNmY2I4YzUg
KCJ1c2I6IGR3YzM6IGdhZGdldDogUHJldmVudCBFUCBxdWV1aW5nIHdoaWxlIHN0b3BwaW5nDQo+
IHRyYW5zZmVycyIpIG1lcmdlZC4NCg0KQWggSSBzZWUuDQoNCj4gDQo+IGNvbW1pdCBmMDlkZGNm
Y2I4YzUgIG1vdmVkIHRoZSBkd2MtPmNvbm5lY3RlZCA9IHRydWUgdG8gYWZ0ZXIgd2UgaGF2ZQ0K
PiBmaW5pc2hlZCBzdG9wIGFjdGl2ZSB0cmFuc2ZlcnMuICBIb3dldmVyLCB0aGlzIGNoYW5nZSB3
aWxsIGFsc28gZW5zdXJlDQo+IHRoYXQgdGhlIGNvbm5lY3RlZCBmbGFnIGlzIHNldCB0byBmYWxz
ZSB0byBlbnN1cmUgdGhhdCB3aGVuIHdlIGNhbGwgc3RvcA0KPiBhY3RpdmUgdHJhbnNmZXJzLCBu
b3RoaW5nIGNhbiBwcmVwYXJlIFRSQnMuICAocHJldmlvdXMgY29tbWl0IG9ubHkNCj4gYWRkcmVz
c2VzIHRoZSBjYXNlIHdoZXJlIHdlIGdldCB0aGUgcmVzZXQgaW50ZXJydXB0IHdoZW4gY29taW5n
IGZyb20gYQ0KPiBkaXNjb25uZWN0ZWQgc3RhdGUpDQo+IA0KDQpUaGF0IHN0aWxsIGRvZXNuJ3Qg
YWRkcmVzcyB0aGlzIGlzc3VlLg0KDQpCZWNhdXNlOg0KMSkgV2UncmUgc3RpbGwgcHJvdGVjdGVk
IGJ5IHRoZSBzcGluX2xvY2tfaXJxKigpLCBzbyB0aGlzIGNoYW5nZSBkb2Vzbid0DQptYWtlIGFu
eSBkaWZmZXJlbmNlIHdoaWxlIGhhbmRsaW5nIGFuIGV2ZW50Lg0KMikgV2UgZG9uJ3QgZW5hYmxl
IHRoZSBpbnRlcnJ1cHQgZm9yIEVORF9UUkFOU0ZFUiBjb21tYW5kIGNvbXBsZXRpb24NCndoZW4g
ZG9pbmcgZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcnMoKSwgdGhlDQpEV0MzX0VQX0VORF9UUkFO
U0ZFUl9QRU5ESU5HIGZsYWcgd2lsbCBub3QgYmUgc2V0IHRvIHByZXZlbnQgcHJlcGFyaW5nDQpu
ZXcgcmVxdWVzdHMuDQoNCldlIHNob3VsZCBkbyBkd2MtPmNvbm5lY3RlZCA9IHRydWUgd2hlbiB3
ZSBoYW5kbGUgY29ubmVjdGlvbl9kb25lDQppbnRlcnJ1cHQgaW5zdGVhZC4gVGhlIEVORF9UUkFO
U0ZFUiBjb21tYW5kIHNob3VsZCBjb21wbGV0ZSBiZWZvcmUgdGhpcy4NCg0KVGhhbmtzLA0KVGhp
bmgNCg0K
