Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E389742EF2F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 12:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbhJOK4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 06:56:51 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:50906 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238173AbhJOK4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 06:56:49 -0400
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2E74DC4405;
        Fri, 15 Oct 2021 10:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1634295283; bh=RQAIWrbOI9obbfAQrCLJpnv5ZntnC6a33nwO/CjRaCs=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=IQD61Qw//+4t7ddZT8JJHdYDOLK99qKcltvOtzvcKkdYN8BgmpVwaFvK+bhDoq6Vz
         6vdhzcp6hc0l+uI8j6qS+A2NzAjP8FOVZZoE+O1pgO2wSfUhhrnumydfcJMIfyORgs
         8+ravgCXR0A8peTGyGooD+llDh/DRfLufZa9v9RAtfkdVXK2pNUvUeturXBxlovzhI
         nRm024EhmBp5OOxBt64MoyZqWFpLNQSiMRXMvcdJu4RdzSAFssD5GpgDEJ+5+DCrak
         WRaGQ3unfqYRcCIzwVd9foEcXujd900GbfD4/yjseAlsS5yTZTwlTJhrIff3aJjg1/
         VZqewGGD8+ldA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D5FB5A0096;
        Fri, 15 Oct 2021 10:54:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id ACCDE800E9;
        Fri, 15 Oct 2021 10:54:40 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="SaCbIPkE";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCQE44jaAQVC2w6jxdnUFluHNKwbw0UqqAc8f6ARdUkQ+43Vw7JABNkvIGot0Rx3Lx3bP4uMzCa0VX6J0jBXJ4cq0oNv8NhtroL0wKdQx3qIAvkWX/O24XCbUiY0lst1bGVuot0YwkHklqFc8nB7hyTNHRmgvUSx+POfCgwCA6mMBZnZlS3sXruoA9K4rsAaF9q9QyVTwAccVM44GDK7lSKAsNqZm2EIoAGfcfQcg79zHQPuqrUe+Trn7lQGyghRtfEv80TxWR6GTB+CSEj3ean+BrlsxNB/4Bl9cnLmllqcRxd4TK19tVbmFHEQLXf7NLShYsQ8IbTO42vRQOvoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQAIWrbOI9obbfAQrCLJpnv5ZntnC6a33nwO/CjRaCs=;
 b=baMZ18Nb2p2J/EyB1aW7iSzfsYqzuWxsEJ1oI31gGLSwwrG/6YsxBjJQR97eYzpeSFzbHTDv5bYN2W7wRP6Z3De2CdbDqkbOMaIYLT5INNntNPj/vO3WNPiHKmAwwxMbqFJq9uriG6NlrNFElgEll6oLRh7atXyy2HvXQWuxr9121lTUfr7p4ggxe5WMpgA0EC72QONx+9whR1yb8KrSKT2LabCxQcE+nvzRbql+pxq3/nkJ95bYb3xsMPDgC+WYtWVtTQFHrgxwQRfPoWn1Hthz/kk9LaFyQJUGrHdIo/AFe7aK57ESEFxOMmvAmO93h3HS+eqzNZqDObNjOo5SGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQAIWrbOI9obbfAQrCLJpnv5ZntnC6a33nwO/CjRaCs=;
 b=SaCbIPkEuRAcKiSczs1VqHaMRO51z0TB7sTCJUOtK5m7fEj0dwEQytRBRl6jHBS57nL0CZGP70SokIOuvFO5H9CZnXrJE7981h+WZ+6PrShw/IJqqoeKQNhke/7cL5NLThzyhVLswN9wMTrskMJnwXpJhJvonAJj54IB8b1Jq+Y=
Received: from BN9PR12MB5383.namprd12.prod.outlook.com (2603:10b6:408:104::7)
 by BN9PR12MB5210.namprd12.prod.outlook.com (2603:10b6:408:11b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 10:54:38 +0000
Received: from BN9PR12MB5383.namprd12.prod.outlook.com
 ([fe80::88fd:96ac:c734:b363]) by BN9PR12MB5383.namprd12.prod.outlook.com
 ([fe80::88fd:96ac:c734:b363%3]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 10:54:38 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH 3/3] usb: dwc2: drd: reset current session before setting
 the new one
Thread-Topic: [PATCH 3/3] usb: dwc2: drd: reset current session before setting
 the new one
Thread-Index: AQHXuc7dYAGavKyIbkic0k99kJNEYavT8noA
Date:   Fri, 15 Oct 2021 10:54:38 +0000
Message-ID: <36940be4-a594-a4db-1b28-e7272ad2a103@synopsys.com>
References: <20211005095305.66397-1-amelie.delaunay@foss.st.com>
 <20211005095305.66397-4-amelie.delaunay@foss.st.com>
In-Reply-To: <20211005095305.66397-4-amelie.delaunay@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: foss.st.com; dkim=none (message not signed)
 header.d=none;foss.st.com; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fa59750-3233-415c-534d-08d98fca2f17
x-ms-traffictypediagnostic: BN9PR12MB5210:
x-microsoft-antispam-prvs: <BN9PR12MB521056160BE22AD0F3D89BBDA7B99@BN9PR12MB5210.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: spWkmqwd9LiMmmHK4+KU5k2FosTyF8eOE9LNAS8VfAAcM9NhOCaIqgVeMdDCXzxge6uTCoHKfqgJRWHEz5X+6Vb5Q0EvqpxIqBfZsWBQr1uzCygpT9ovAkFhcp7yJg1dChjRKBnuU75O8+F73y7hMW9Efl3QE6Ozc7s5iL1NtUx3cRHQhvN5aHpXfkCSlo9jo2n+ShCuf/HSFa6fjf2UfvxIhlh+xo2wA8iMn5fVNKJwv2JjtmuelISCIqtb9gIhrKwyIfRSkRu/X0+K1lxqAIQggwjonVFCMFGqTshZC2ONzSA9Ux1kqNNDUyV7o0sWXaOcDKC0Fc7xofEz/POc0bjQwZYhzhyMLPlCAcit7zyjB5dWblmArOAUQzF8ZHKMqjT6WoTS4FSG1hidllr2wJUFCrt7jZ7iI9r0kvZrBFONXbdY/FKroFNgPpXNnv8OzfTf+58iPWX1hlhzABrMP5ZYgx+CAehNGCImqIDRnJDqyyJFC0UWkz1zdyfmblYwHRwXTJGzOibEI8cLVE5pbc0Qsjomb3H7Jlu4/Cz/4wrJ9fUbLsbXF+xpuabhcj+mG7xPqykKEd5ecOCvnuHWf7Uues/5lYu8QfvRjWd3RpUe/6+w/ARtUbFzWCpqMQmdugO6AfySoBEyZ6UtpnbGnUt43yqLTjrsyFNr3fgDpALkRO9ZiJAgFz82YsIoHnJqirtUJFf3jlqjpOmY0EUUmrEmjQ9RXMEEEiXpjPB1Pu/LhWP36Wv+WR7SWccdN90PYFA/8uRW1BSy8ZskbjwKkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5383.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(6512007)(66476007)(36756003)(31686004)(38070700005)(64756008)(5660300002)(110136005)(66446008)(54906003)(186003)(316002)(122000001)(66946007)(38100700002)(8676002)(91956017)(71200400001)(2906002)(76116006)(86362001)(4326008)(508600001)(8936002)(6506007)(26005)(2616005)(6486002)(53546011)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkNvYjBzRkg1T0ovTWRoWXdaRzBCd1VyMFJuOVBNcnVCR1drdGFyQVpKTGpW?=
 =?utf-8?B?R2FUa3dlVDM3MXdac1RRZVZuazMraitzeFlCMGY5RUlKOWRKY1EvWWhUV3hI?=
 =?utf-8?B?bC9pUmt2S0ZQRlFjMzBjaVdDRzU3T3Y2OTVCTWFLa0k3UWt1RWV2Qzdaamcr?=
 =?utf-8?B?anpod2NCWFlNUEV1WjNzd1lodnJuMkdUSUNoamdEd2prWXh3eDBTRTFhaTc0?=
 =?utf-8?B?VVc4WGZ1L1o5RDh5a2xUbmlSbnNLVlBuT1dJLzA3WUxvN3ZFUVFqSloxM0Jy?=
 =?utf-8?B?QzBpUVVwaXRPSWtSNDFFT1pab2tpalRTLzlGTkU2ZzFLRE1XSWpBNHJXNnB4?=
 =?utf-8?B?VHRwQW0xcUx0bjJyZDhHR1pSdFdOVy85WUxNR1FTclo0N2NRRzRoNms5RzJn?=
 =?utf-8?B?K0NRaUxwNnNiUUE4SWpBVC9POGs1ZDM1WlhZRVh4blVaRVQwSVFpNmprbzRn?=
 =?utf-8?B?OCt2Y2dlY2toSisrbnZGRTc1bmc1TmdXTkk0YmVnUldyYmovQWlyZFRzaE9n?=
 =?utf-8?B?V1luR2NKM1o4WWVCQW5sSzBjUW11UUVHK1BlV1dIbEsvUk5RSklWVUZDcExY?=
 =?utf-8?B?RlVzVDczMFh0SHNuRTQ5VHcvK3ovZU1WVGJoeXdSMXRKMFBhQ2FxOUQrWmJm?=
 =?utf-8?B?RkJiaEV5TFBsS1RLbFY5VVJqYTR1blBtdnBnVFBpc0tEVGxvcFh6M0NkY1BW?=
 =?utf-8?B?V05ROVVWakFkZ2hIbStZQ095ZFh0OFJnTUx6NjN3eUpxUi8vWi96N3pDQ1g2?=
 =?utf-8?B?Z0FTeFluaDVPaVZMenhWWnp1YzFuMktqemloQjNvbVpMOFRSWmpZYnhKdnM5?=
 =?utf-8?B?aUswQXRnVWVhOFdTLzJsbXFCSDFlVk8yVWtCNVR4NXNpVVcvdVZ0Q0JHRTlR?=
 =?utf-8?B?WWJBUit3eHpnbFIyNXZkdUFmSVBIcUZaSCtZMGNNYkx0ZGk3OVpDcmtaNUhG?=
 =?utf-8?B?ZjViSnZXM0JVdnlyMVpORTVMb1FldkREM0lwamdWbU5jbW51RnZQNW1abHRS?=
 =?utf-8?B?aU5MRUtNOE9zcHlwLzd1VzdaVmYvWVB0UGh4YlJIeXo2Z1RUSWErR3Nyam54?=
 =?utf-8?B?eUR3K1hJRzJERWhGMU1tMmZmWW91YmNvNnBTWjNJejcvNm54QmJHdk9acWhu?=
 =?utf-8?B?dUZSeFN3SG5nbjZKbCs0eU5hZHZLc3VRMW1vZXVyMXRZdHJodTd3NUZ6M3U1?=
 =?utf-8?B?OHhHaXVaUFJhQm1INXBpV1JDeDZQUmltbi81dTFQdE5aN0xrSytGQ2xYTHE1?=
 =?utf-8?B?NWpnTWxBQzJxQnJnM2s5aEttUTVBRkpIL0hFQWt2bGtrM3NkNnVlT3Vtd0lL?=
 =?utf-8?B?WDNqdGd4S0N3UEg0OE9MZkxQc1FJSit5cnVYK005clY0bmpDWXNnczhFWXpo?=
 =?utf-8?B?WHRraEZuOHZHZU4zWXZ3RU13Wk9zWjdFZlA3UHVoWUVNS0ttSkV2bUs4aDQw?=
 =?utf-8?B?NW5DNEgyQmNlK3RMVjB0YzAvNmd2b3ZlcC9jRjhuaGdNc3BEQzBiaHRyVWZM?=
 =?utf-8?B?UHpkTVFlRms4SlpvcFhESm1obWdGa3kxbXVxRW1lUHR3TlF5dHpScTBlc0VV?=
 =?utf-8?B?Ym90TTdJTUJFR1h1b0tVanhpa0pVMlZibTA0WlV2YXlKVkkwZjBIV2xVWWMz?=
 =?utf-8?B?T0FpM3hHV203d3N6bXBhaUQwUGFGaFdETHkwU2lqL240emU3YjhhSWpkNU9O?=
 =?utf-8?B?ZFVKVG96L04wWDhVKzY0TTJRT3E3RkxlMkc2SitrUUx0ZkFIOGpzcXp2azFu?=
 =?utf-8?Q?szo7vA3SvkinhEFVa4=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8958010C91EEED4BBFF73BADB1575343@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5383.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa59750-3233-415c-534d-08d98fca2f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 10:54:38.4953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /EJSyhIokPgTyFMRt9FZC0/W/QHxZt5BKi+r9xJCwWaPS4fEP7eC753qtmQvc07he2k6Sm7U16DlV+jtmPw4tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5210
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvNS8yMDIxIDE6NTMgUE0sIEFtZWxpZSBEZWxhdW5heSB3cm90ZToNCj4gSWYgcm9sZSBp
cyBjaGFuZ2VkIHdpdGhvdXQgdGhlICJub25lIiBzdGVwLCBBLSBhbmQgQi0gdmFsaWQgc2Vzc2lv
biBjb3VsZA0KPiBiZSBzZXQgYXQgdGhlIHNhbWUgdGltZS4gSXQgaXMgYW4gaXNzdWUuDQo+IFRo
aXMgcGF0Y2ggcmVzZXRzIEEtc2Vzc2lvbiBpZiByb2xlIHN3aXRjaCBzZXRzIEItc2Vzc2lvbiwg
YW5kIHJlc2V0cw0KPiBCLXNlc3Npb24gaWYgcm9sZSBzd2l0Y2ggc2V0cyBBLXNlc3Npb24uDQo+
IFRoZW4sIGl0IGlzIHBvc3NpYmxlIHRvIGNoYW5nZSB0aGUgcm9sZSB3aXRob3V0IHRoZSAibm9u
ZSIgc3RlcC4NCj4gDQo+IEZpeGVzOiAxN2Y5MzQwMjRlODQgKCJ1c2I6IGR3YzI6IG92ZXJyaWRl
IFBIWSBpbnB1dCBzaWduYWxzIHdpdGggdXNiIHJvbGUgc3dpdGNoIHN1cHBvcnQiKQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbWVsaWUgRGVsYXVuYXkgPGFtZWxpZS5kZWxhdW5heUBmb3NzLnN0LmNvbT4N
Cg0KQWNrZWQtYnk6IE1pbmFzIEhhcnV0eXVueWFuIDxNaW5hcy5IYXJ1dHl1bnlhbkBzeW5vcHN5
cy5jb20+DQoNCj4gLS0tDQo+ICAgZHJpdmVycy91c2IvZHdjMi9kcmQuYyB8IDIgKysNCj4gICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy91c2IvZHdjMi9kcmQuYyBiL2RyaXZlcnMvdXNiL2R3YzIvZHJkLmMNCj4gaW5kZXggOTk2NzIz
NjBmMzRiLi5hYTZlYjc2ZjY0ZGQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzIvZHJk
LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9kcmQuYw0KPiBAQCAtNDAsNiArNDAsNyBAQCBz
dGF0aWMgaW50IGR3YzJfb3ZyX2F2YWxpZChzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcsIGJvb2wg
dmFsaWQpDQo+ICAgCSAgICAoIXZhbGlkICYmICEoZ290Z2N0bCAmIEdPVEdDVExfQVNFU1ZMRCkp
KQ0KPiAgIAkJcmV0dXJuIC1FQUxSRUFEWTsNCj4gICANCj4gKwlnb3RnY3RsICY9IH5HT1RHQ1RM
X0JWQUxPVkFMOw0KPiAgIAlpZiAodmFsaWQpDQo+ICAgCQlnb3RnY3RsIHw9IEdPVEdDVExfQVZB
TE9WQUwgfCBHT1RHQ1RMX1ZCVkFMT1ZBTDsNCj4gICAJZWxzZQ0KPiBAQCAtNTgsNiArNTksNyBA
QCBzdGF0aWMgaW50IGR3YzJfb3ZyX2J2YWxpZChzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcsIGJv
b2wgdmFsaWQpDQo+ICAgCSAgICAoIXZhbGlkICYmICEoZ290Z2N0bCAmIEdPVEdDVExfQlNFU1ZM
RCkpKQ0KPiAgIAkJcmV0dXJuIC1FQUxSRUFEWTsNCj4gICANCj4gKwlnb3RnY3RsICY9IH5HT1RH
Q1RMX0FWQUxPVkFMOw0KPiAgIAlpZiAodmFsaWQpDQo+ICAgCQlnb3RnY3RsIHw9IEdPVEdDVExf
QlZBTE9WQUwgfCBHT1RHQ1RMX1ZCVkFMT1ZBTDsNCj4gICAJZWxzZQ0KPiANCg0K
