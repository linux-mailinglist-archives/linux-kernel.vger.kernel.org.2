Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EF734F58E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 02:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbhCaAlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 20:41:21 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:46774 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232824AbhCaAlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 20:41:19 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5C08A4023B;
        Wed, 31 Mar 2021 00:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617151279; bh=Mr5VE5xLphVU8chJPOcNeewhdVPxs530ArDi85RaLfM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=fvi8cabvPLDx8yFMW5hm6KdTtVs3CkUnupXHk5l6kJnrAOjnW26rC0aHHyC1p9Dja
         lLd6CI6B422vSIRAB/xkA8Qlm/zxc2zYN7XUyYa6uqErgXYAR+8Sm/7nFh+G+N7wN2
         HZ0+WwxYS/oV5WjGyw2w9gPApiZaps+J3l20XNdtRSJP/RU1fkQu3Ald+Tzut5lYLS
         WQz3/SK7qfDELGrGZ7GNAYN6o8jCWHK5Jb5yE5U/g2rUhD5cYu9+EZhIGs30+VDRVc
         H7bUFtjlJG3DXXi1fdNXi9OM3dK10cw5oAGSrlhg2mZFZtocCJ5ZgZs2oS38V4laoz
         KNSKnVPoYDyIA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id C07D1A007C;
        Wed, 31 Mar 2021 00:41:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8E06A400DF;
        Wed, 31 Mar 2021 00:41:17 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="nm55mA8s";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioU4lpROva/alImPpmTiEqmMlHVqh53O94ElhSWC/MVJ3D9E8Yd10HgrUbgHXumltN3Zu+KL1cOhuk8L3wsINegyl2NnKEHC7ledGKQKHM8lz8rpKlewLikk15M1IB9LwFbHs0S9Y7WqFZBoqtjCI+ZdzMcLQQv9fnK9cKC6sPDgP9o4uKmvSf3nDD8oH7zGBZHxLvrxtpPT8UtK1yYDRxDR5kDoBye+PL9WZG2gzt3x1GBEOGp4ia+nxLeYYS2oLimCkKjPmLV98XWf4OwWNWKOg/pArjN8diKnmHwfnDLrzptHSHaGiGyGM42ZcHsAG5r28WL8cJGWnQPE6Ic7Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mr5VE5xLphVU8chJPOcNeewhdVPxs530ArDi85RaLfM=;
 b=fSxugdMWjbvVGlDtRc1en4M/jgq/UxF9m4LdIc8AGGpIQvMMdH31n7coCozc8p4w70ul4DiKeGnXoQaY65gpR48whTB/pfFTfhuah1gABFpRet7mTAYoSpKerYmJSPh/0Q+moPkavK8+UlU5NnBEC9KBoAiZg1nlAzMDLiVJ5g76erg52bIiPEiIDdDNvvISaimielf9QVgIXe790YDLgrmPMey9WBl3crQUKAqp9MHS+DZliYhMxp91azxzVFf51vYkfIFHwYl034WDLA1cMXC9K21pobqYLNY+Gxz9r1vB0kb8b7EPna5YJ3hADoAOt1PDFIqJXkyHwLRR1B2d7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mr5VE5xLphVU8chJPOcNeewhdVPxs530ArDi85RaLfM=;
 b=nm55mA8soLGNdveABOqD/JOmIDCyhayOxmycOpTFsNGRbjCK085MIlLxWsl48Kh4frFNUKMpHwzHLuR0hB5+qfTEQXq22AhzAk9edMXAKEpi+YVL3YJJHY8VTbsfdmzZve0nG5bPeSSd55/2XUMtJ9pft3tn0rzVJlwO2szDthE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4966.namprd12.prod.outlook.com (2603:10b6:a03:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 31 Mar
 2021 00:41:16 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c%6]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 00:41:15 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Ray Chi <raychi@google.com>, "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "albertccwang@google.com" <albertccwang@google.com>
Subject: Re: [Patch v4] usb: dwc3: add cancelled reasons for dwc3 requests
Thread-Topic: [Patch v4] usb: dwc3: add cancelled reasons for dwc3 requests
Thread-Index: AQHXIzV/I5HhKapBQEaOjyW5DrXPsaqdRrAA
Date:   Wed, 31 Mar 2021 00:41:15 +0000
Message-ID: <9eba9e7e-4d7e-991b-1415-86b3cb6a7ff5@synopsys.com>
References: <20210327181742.1810969-1-raychi@google.com>
In-Reply-To: <20210327181742.1810969-1-raychi@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ce17827-a7a4-4d13-8ca2-08d8f3ddb13b
x-ms-traffictypediagnostic: BY5PR12MB4966:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB49667C1D2358E8D7C58014EFAA7C9@BY5PR12MB4966.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dkkg0pqhWa/UkpqumZ1u+mZadaH0ZDnXbBcdKdTrifyNK6N6jmfDQ+UCaleJT+s7P+NAWWbNudAMAK7dsWAFRA+4uhEpxUa0jABCykEzrzzrneqWNNvip4KteOGHdNpX9I3F7urr3FPRcFoqYNN6j7CvH116H8xwZnvE16PMN37Ysfm15qXOfGPSOUEl2H0kcxnr6hrXD9kP7LSHtxEvhhLqypoTdLEgh/5i26Dqa/h8lERpCZoXIVcVmUV6lMTVbyR4ZhPTQwzQUTAj5eG8f9aCOtENG8D73qTYpIRlVccnKE+OPY3TSFF3A+Y3SuxDZEseL0TpzbC+gzeD6qOxTENXFutjWpwBeCVC35vh8gH+Qkj9g6gVNtefPUKdYgLUywro5CM6fx8lZOQyPABzwKlfzAPq5ho3W6DcHKoflgG2OCHa0kyejpGpxZ+HQUI4XPQ4IoJ7eIu8KhLjxOlT1Tsh1OwgQsCf0CLjsUFGXqoPGhP94oDBACSBhRs7ey3HBZymTRKP2AmO8ZQ0lW/ZKbShDJ2Sl+CDi47jnOEj3LedknYBWFbvuhkb/mCHrFhIh7bY+Mzd1cPoWeZNCHg1ldSsq6K0Wx5SP9XpVa2A+/zMGOrVhelZWirGDZXJtgMtw5zlXXtf+k9UIdQLInXePfnUx2zJ2Z0sUVav/fQpxGJbG/wgtbTImRPhJ3BE1s7Nl725bSxhk0ad+xG6cuc32w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(39860400002)(396003)(346002)(110136005)(31686004)(316002)(76116006)(8936002)(26005)(54906003)(186003)(5660300002)(38100700001)(4326008)(2616005)(71200400001)(6486002)(6512007)(83380400001)(31696002)(66556008)(86362001)(36756003)(2906002)(478600001)(6506007)(66476007)(64756008)(8676002)(66946007)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?M1QxVWp6T3VVL1E1NGIzWnBNbVN2ejNQSDVzRDY5SWk4Si9wUWE3RWtmWWRJ?=
 =?utf-8?B?Y2k2dXRWVVJqczZZVEtCSllIbjJlN3ZxZ3JOWCsvanV2a0JTdXRBSnFnVWJJ?=
 =?utf-8?B?by9SZ1NHa1ZaNGl3SFl1eHl0QlRBZnJWdW92RGkyZE83cWFJTHZBZmdnci9L?=
 =?utf-8?B?T05BYlZaeUtwM0FheGNla1RqQ3pieURGOUZDMCtPVUJ1Nm5OLzJMT2lEWGRs?=
 =?utf-8?B?K04zWnFHWUdKSUxxUEZHbHFmcHpvNXFRSll1QTFNeDRsTDZ6VDVxYlplWmRV?=
 =?utf-8?B?TE5pRnNLQnVzL1NqZlozcUxyVDF0VWUreW1HK1VUZW44d2VEaVRIY0Vlb0xr?=
 =?utf-8?B?YUgzMmFxV2JvYTd6OHBvWmFrd2wwZlhqOHNwM0hGYTVlaXQvWDBiOGI0Zzk1?=
 =?utf-8?B?Q2R6Rk1wdVFyc1hmVHoxNG96T0VhbWFJV0RTeGM2eVQwdzEyR2o4eUgrZ3d1?=
 =?utf-8?B?OXY4N0dKSHJNL0RFc0tVeEpBTVNjZExFQWFzeTBJM2FEaEhKL0xTQW1XVXZk?=
 =?utf-8?B?NlFScFY3MGxoMzZjRVplTzVrVnU5dEhwcU0vRmRXVlBTY0pNanFLNkpDOS9x?=
 =?utf-8?B?Vk1hKzN2VGdHSVFUdUhZWHBYUHFraG54aWZZaktFQmROR2pWUEtVUzBhblVp?=
 =?utf-8?B?MG9JVzVIcG9xVHB0M0pTNEdQaWpTUnpackVBWkRIVDNSS1FmeGNXUjBndVpa?=
 =?utf-8?B?LzdyVWl5QmMzak03OXlUZFhVUG5uQWNqSmxUNzgwaG1FVTU3dUpCWGpvQUkx?=
 =?utf-8?B?clJqNlZNdDlwVmh1VkdmZDhTU3FzUXN1dVFZNTYzcjBNRk04ZU1YektXb3l2?=
 =?utf-8?B?WnB2SGtuZC9sajRTZEFYSzdQN05zeStBVWNnWVVhMHBtUjIxc3VwWFM1K21j?=
 =?utf-8?B?ZWJqNzFxdHo4K2dMbW5rTFd3VDM3Y0VZQVZVOGJ3cEJBZ2k1QnNob3kwODRh?=
 =?utf-8?B?UjFrb2pTTUxpYThDeG1mT213SURCK1pwVzNlMTBRSFkyaDBzZXJKbGQybkZB?=
 =?utf-8?B?YVUrcHJTdTAydURjWXU3dmYyaGZXbmpNcTNqWm8xOWxkRjFZTXA1aUdNZEVs?=
 =?utf-8?B?a3BheFhDdjZCWGFsOFlrM3ptMTdPdzdzd1Q4cGlFMldzNGRMY0J5UDl6SmZ6?=
 =?utf-8?B?SUdDd05QczdXMDBWbUVSSUFPYjRlY29mZ3RyR1c2QWNBUytOTnhHV2VPaUJv?=
 =?utf-8?B?bXVyd05OOEFQUEIrRjlOdmY3NmUrWEIvRVJkc3JiV29rREwwSFVqR0JFdVlZ?=
 =?utf-8?B?dThVOFBVaXhhN2RCWUIxcXZLaVlKOGFWZFBmQkZrMmlHM2FreElaak02azVL?=
 =?utf-8?B?bkU5YVZ0ZGQ2SUIxMnlXc1VzU1ptcWZsU21EQUVvOVQyQjNCMElIRTduYjlH?=
 =?utf-8?B?SnNRMThwT1YyblNQdGlCLzd6cGpmRERtL1hZaTRJQmM1ZVVPMENsRjJoZktV?=
 =?utf-8?B?YjFnNzhWTjk3bWVDZUxWalNReGsxTk54V1Y0WGdvSDVLR1pmb3JOMnNRemcw?=
 =?utf-8?B?aExjR0NBY2tuZzZxVk1MZnRMYzA4S1lOSUJua3I4VW1Ga1N3UVdKNW9kVitP?=
 =?utf-8?B?KzNad1d4R1pxSDZLTWc0Zy80TWRVSUVsSE4xQlk0NWxEcUx4M1FCVm51MGpI?=
 =?utf-8?B?WG55YXh4Y1Y5dU9wdlJ2R25Cbi8wemNtOUtxSUxDelhMNjJtdHNqYXJJL3Rs?=
 =?utf-8?B?aUNOVmdwSUc4bnpqZEU3TDRYS2RFY3piak1yZFRoOXA5b3hralg3STRFU0g4?=
 =?utf-8?Q?ErapI8U6kzse711dqg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9002DC6534778043AB09C84AA0F2FFEA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce17827-a7a4-4d13-8ca2-08d8f3ddb13b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 00:41:15.7878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i6+DwyMN8mf7YkkXOBzMsLw0RMny6qpXpfNixUfH+39eltSebsYD42k6Xj30IN+vhPDkFCjaWsAyEgOild6jgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4966
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmF5IENoaSB3cm90ZToNCj4gQ3VycmVudGx5LCB3aGVuIGR3YzMgaGFuZGxlcyByZXF1ZXN0IGNh
bmNlbGxlZCwgZHdjMyBqdXN0IHJldHVybnMNCj4gLUVDT05OUkVTRVQgZm9yIGFsbCByZXF1ZXN0
cy4gSXQgd2lsbCBjYXVzZSBVU0IgZnVuY3Rpb24gZHJpdmVycw0KPiBjYW4ndCBrbm93IGlmIHRo
ZSByZXF1ZXN0cyBhcmUgY2FuY2VsbGVkIGJ5IG90aGVyIHJlYXNvbnMuDQo+IA0KPiBUaGlzIHBh
dGNoIHdpbGwgcmVwbGFjZSBEV0MzX1JFUVVFU1RfU1RBVFVTX0NBTkNFTExFRCB3aXRoIHRoZQ0K
PiByZWFzb25zIGJlbG93Lg0KPiAgIC0gRFdDM19SRVFVRVNUX1NUQVRVU19ESVNDT05ORUNURUQN
Cj4gICAtIERXQzNfUkVRVUVTVF9TVEFUVVNfREVRVUVVRUQNCj4gICAtIERXQzNfUkVRVUVTVF9T
VEFUVVNfU1RBTExFRA0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmF5IENoaSA8cmF5Y2hpQGdvb2ds
ZS5jb20+DQo+IC0tLQ0KPiBDaGFuZ2Vsb2cgc2luY2UgdjM6DQo+IC0gYWRkIGVycm9yIGxvZyBh
bmQgcGFzcyAtRUNPTk5SRVNFVCBpbiBkZWZhdWx0IGNhc2UNCj4gDQo+IENoYW5nZWxvZyBzaW5j
ZSB2MjoNCj4gLSBtb2RpZnkgdGhlIGNoYW5nZWxvZyANCj4gLSByZW1vdmUgdGhlcmVlIGRlZmlu
aXRpb25zDQo+IC0gcmVwbGFjZSBEV0MzX1JFUVVFU1RfU1RBVFVTX0NBTkNFTExFRCB3aXRoIG5l
dyBjYW5jZWxsZWQgcmVhc29uDQo+IC0gSW4gZHdjM19nYWRnZXRfZXBfY2xlYW51cF9jYW5jZWxs
ZWRfcmVxdWVzdHMoKSwgDQo+ICAgYWRkIGEgc3dpdGNoIGNhc2UgdG8gZ2l2ZSBkaWZmZXJlbnQg
ZXJyb3IgY29kZSBiYXNlIG9uIHRoZSByZWFzb24NCj4gDQo+IENoYW5nZWxvZyBzaW5jZSB2MToN
Cj4gLSBBZGRlZCBuZXcgcGFyYW1ldGVyIHRvIGR3YzNfZ2FkZ2V0X21vdmVfY2FuY2VsbGVkX3Jl
cXVlc3QoKQ0KPiAtIEFkZGVkIHRocmVlIGRlZmluaXRpb25zIGZvciBjYW5jZWxsZWQgcmVhc29u
cw0KPiAtIFBhc3NlZCB0aGUgcmVhc29uIHRvIHJlcS0+cmVxdWVzdC5zdGF0dXMNCj4gDQo+ICBk
cml2ZXJzL3VzYi9kd2MzL2NvcmUuaCAgIHwgMTIgKysrKysrKy0tLS0tDQo+ICBkcml2ZXJzL3Vz
Yi9kd2MzL2dhZGdldC5jIHwgMjQgKysrKysrKysrKysrKysrKysrKystLS0tDQo+ICBkcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5oIHwgIDYgKysrKy0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDMxIGlu
c2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gaW5kZXggNGNhNGI0
YmU4NWU0Li41MWEzZWVjMjQyOGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IEBAIC05MDgsMTEgKzkwOCwx
MyBAQCBzdHJ1Y3QgZHdjM19yZXF1ZXN0IHsNCj4gIAl1bnNpZ25lZCBpbnQJCXJlbWFpbmluZzsN
Cj4gIA0KPiAgCXVuc2lnbmVkIGludAkJc3RhdHVzOw0KPiAtI2RlZmluZSBEV0MzX1JFUVVFU1Rf
U1RBVFVTX1FVRVVFRAkwDQo+IC0jZGVmaW5lIERXQzNfUkVRVUVTVF9TVEFUVVNfU1RBUlRFRAkx
DQo+IC0jZGVmaW5lIERXQzNfUkVRVUVTVF9TVEFUVVNfQ0FOQ0VMTEVECTINCj4gLSNkZWZpbmUg
RFdDM19SRVFVRVNUX1NUQVRVU19DT01QTEVURUQJMw0KPiAtI2RlZmluZSBEV0MzX1JFUVVFU1Rf
U1RBVFVTX1VOS05PV04JLTENCj4gKyNkZWZpbmUgRFdDM19SRVFVRVNUX1NUQVRVU19RVUVVRUQJ
CTANCj4gKyNkZWZpbmUgRFdDM19SRVFVRVNUX1NUQVRVU19TVEFSVEVECQkxDQo+ICsjZGVmaW5l
IERXQzNfUkVRVUVTVF9TVEFUVVNfRElTQ09OTkVDVEVECTINCj4gKyNkZWZpbmUgRFdDM19SRVFV
RVNUX1NUQVRVU19ERVFVRVVFRAkJMw0KPiArI2RlZmluZSBEV0MzX1JFUVVFU1RfU1RBVFVTX1NU
QUxMRUQJCTQNCj4gKyNkZWZpbmUgRFdDM19SRVFVRVNUX1NUQVRVU19DT01QTEVURUQJCTUNCj4g
KyNkZWZpbmUgRFdDM19SRVFVRVNUX1NUQVRVU19VTktOT1dOCQktMQ0KDQpUaGUgLTEgaGVyZSBp
cyBhbiB3ZWlyZC4uLiBhcyB0aGUgZHdjM19yZXF1ZXN0IHN0YXR1cyBpcyBhbiB1bnNpZ25lZCBp
bnQNCnR5cGUuIFdlIGNhbiBtYWtlIHRoaXMgZml4IGluIGEgc2VwYXJhdGUgcGF0Y2gsIGFuZCB3
aGF0J3MgZG9uZSBoZXJlDQpsb29rcyBnb29kLg0KDQo+ICANCj4gIAl1OAkJCWVwbnVtOw0KPiAg
CXN0cnVjdCBkd2MzX3RyYgkJKnRyYjsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMv
Z2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IGUxNDQyZmM3NjNl
MS4uNDkyMDg2NTE5NTM5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5j
DQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTE0MDIsNyArMTQwMiw3
IEBAIHN0YXRpYyBpbnQgX19kd2MzX2dhZGdldF9raWNrX3RyYW5zZmVyKHN0cnVjdCBkd2MzX2Vw
ICpkZXApDQo+ICAJCWR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoZGVwLCB0cnVlLCB0cnVlKTsN
Cj4gIA0KPiAgCQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUocmVxLCB0bXAsICZkZXAtPnN0YXJ0
ZWRfbGlzdCwgbGlzdCkNCj4gLQkJCWR3YzNfZ2FkZ2V0X21vdmVfY2FuY2VsbGVkX3JlcXVlc3Qo
cmVxKTsNCj4gKwkJCWR3YzNfZ2FkZ2V0X21vdmVfY2FuY2VsbGVkX3JlcXVlc3QocmVxLCBEV0Mz
X1JFUVVFU1RfU1RBVFVTX0RFUVVFVUVEKTsNCj4gIA0KPiAgCQkvKiBJZiBlcCBpc24ndCBzdGFy
dGVkLCB0aGVuIHRoZXJlJ3Mgbm8gZW5kIHRyYW5zZmVyIHBlbmRpbmcgKi8NCj4gIAkJaWYgKCEo
ZGVwLT5mbGFncyAmIERXQzNfRVBfRU5EX1RSQU5TRkVSX1BFTkRJTkcpKQ0KPiBAQCAtMTcyOSwx
MCArMTcyOSwyNSBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9lcF9jbGVhbnVwX2NhbmNlbGxl
ZF9yZXF1ZXN0cyhzdHJ1Y3QgZHdjM19lcCAqZGVwKQ0KPiAgew0KPiAgCXN0cnVjdCBkd2MzX3Jl
cXVlc3QJCSpyZXE7DQo+ICAJc3RydWN0IGR3YzNfcmVxdWVzdAkJKnRtcDsNCj4gKwlzdHJ1Y3Qg
ZHdjMwkJCSpkd2MgPSBkZXAtPmR3YzsNCj4gIA0KPiAgCWxpc3RfZm9yX2VhY2hfZW50cnlfc2Fm
ZShyZXEsIHRtcCwgJmRlcC0+Y2FuY2VsbGVkX2xpc3QsIGxpc3QpIHsNCj4gIAkJZHdjM19nYWRn
ZXRfZXBfc2tpcF90cmJzKGRlcCwgcmVxKTsNCj4gLQkJZHdjM19nYWRnZXRfZ2l2ZWJhY2soZGVw
LCByZXEsIC1FQ09OTlJFU0VUKTsNCj4gKwkJc3dpdGNoIChyZXEtPnN0YXR1cykgew0KPiArCQlj
YXNlIERXQzNfUkVRVUVTVF9TVEFUVVNfRElTQ09OTkVDVEVEOg0KPiArCQkJZHdjM19nYWRnZXRf
Z2l2ZWJhY2soZGVwLCByZXEsIC1FU0hVVERPV04pOw0KPiArCQkJYnJlYWs7DQo+ICsJCWNhc2Ug
RFdDM19SRVFVRVNUX1NUQVRVU19ERVFVRVVFRDoNCj4gKwkJCWR3YzNfZ2FkZ2V0X2dpdmViYWNr
KGRlcCwgcmVxLCAtRUNPTk5SRVNFVCk7DQo+ICsJCQlicmVhazsNCj4gKwkJY2FzZSBEV0MzX1JF
UVVFU1RfU1RBVFVTX1NUQUxMRUQ6DQo+ICsJCQlkd2MzX2dhZGdldF9naXZlYmFjayhkZXAsIHJl
cSwgLUVQSVBFKTsNCj4gKwkJCWJyZWFrOw0KPiArCQlkZWZhdWx0Og0KPiArCQkJZGV2X2Vycihk
d2MtPmRldiwgInJlcXVlc3QgY2FuY2VsbGVkIHdpdGggd3JvbmcgcmVhc29uOiVkXG4iLCByZXEt
PnN0YXR1cyk7DQo+ICsJCQlkd2MzX2dhZGdldF9naXZlYmFjayhkZXAsIHJlcSwgLUVDT05OUkVT
RVQpOw0KPiArCQkJYnJlYWs7DQo+ICsJCX0NCj4gIAl9DQo+ICB9DQo+ICANCj4gQEAgLTE3NzYs
NyArMTc5MSw4IEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfZXBfZGVxdWV1ZShzdHJ1Y3QgdXNi
X2VwICplcCwNCj4gIAkJCSAqIGNhbmNlbGxlZC4NCj4gIAkJCSAqLw0KPiAgCQkJbGlzdF9mb3Jf
ZWFjaF9lbnRyeV9zYWZlKHIsIHQsICZkZXAtPnN0YXJ0ZWRfbGlzdCwgbGlzdCkNCj4gLQkJCQlk
d2MzX2dhZGdldF9tb3ZlX2NhbmNlbGxlZF9yZXF1ZXN0KHIpOw0KPiArCQkJCWR3YzNfZ2FkZ2V0
X21vdmVfY2FuY2VsbGVkX3JlcXVlc3QociwNCj4gKwkJCQkJCURXQzNfUkVRVUVTVF9TVEFUVVNf
REVRVUVVRUQpOw0KPiAgDQo+ICAJCQlkZXAtPmZsYWdzICY9IH5EV0MzX0VQX1dBSVRfVFJBTlNG
RVJfQ09NUExFVEU7DQo+ICANCj4gQEAgLTE4NDgsNyArMTg2NCw3IEBAIGludCBfX2R3YzNfZ2Fk
Z2V0X2VwX3NldF9oYWx0KHN0cnVjdCBkd2MzX2VwICpkZXAsIGludCB2YWx1ZSwgaW50IHByb3Rv
Y29sKQ0KPiAgCQlkd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyKGRlcCwgdHJ1ZSwgdHJ1ZSk7DQo+
ICANCj4gIAkJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKHJlcSwgdG1wLCAmZGVwLT5zdGFydGVk
X2xpc3QsIGxpc3QpDQo+IC0JCQlkd2MzX2dhZGdldF9tb3ZlX2NhbmNlbGxlZF9yZXF1ZXN0KHJl
cSk7DQo+ICsJCQlkd2MzX2dhZGdldF9tb3ZlX2NhbmNlbGxlZF9yZXF1ZXN0KHJlcSwgRFdDM19S
RVFVRVNUX1NUQVRVU19TVEFMTEVEKTsNCj4gIA0KPiAgCQlpZiAoZGVwLT5mbGFncyAmIERXQzNf
RVBfRU5EX1RSQU5TRkVSX1BFTkRJTkcpIHsNCj4gIAkJCWRlcC0+ZmxhZ3MgfD0gRFdDM19FUF9Q
RU5ESU5HX0NMRUFSX1NUQUxMOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuaCBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmgNCj4gaW5kZXggMGNkMjgxOTQ5OTcwLi43
N2RmNGI2ZDZjMTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmgNCj4g
KysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuaA0KPiBAQCAtOTAsMTUgKzkwLDE3IEBAIHN0
YXRpYyBpbmxpbmUgdm9pZCBkd2MzX2dhZGdldF9tb3ZlX3N0YXJ0ZWRfcmVxdWVzdChzdHJ1Y3Qg
ZHdjM19yZXF1ZXN0ICpyZXEpDQo+ICAvKioNCj4gICAqIGR3YzNfZ2FkZ2V0X21vdmVfY2FuY2Vs
bGVkX3JlcXVlc3QgLSBtb3ZlIEByZXEgdG8gdGhlIGNhbmNlbGxlZF9saXN0DQo+ICAgKiBAcmVx
OiB0aGUgcmVxdWVzdCB0byBiZSBtb3ZlZA0KPiArICogQHJlYXNvbjogY2FuY2VsbGVkIHJlYXNv
biBmb3IgdGhlIGR3YzMgcmVxdWVzdA0KPiAgICoNCj4gICAqIENhbGxlciBzaG91bGQgdGFrZSBj
YXJlIG9mIGxvY2tpbmcuIFRoaXMgZnVuY3Rpb24gd2lsbCBtb3ZlIEByZXEgZnJvbSBpdHMNCj4g
ICAqIGN1cnJlbnQgbGlzdCB0byB0aGUgZW5kcG9pbnQncyBjYW5jZWxsZWRfbGlzdC4NCj4gICAq
Lw0KPiAtc3RhdGljIGlubGluZSB2b2lkIGR3YzNfZ2FkZ2V0X21vdmVfY2FuY2VsbGVkX3JlcXVl
c3Qoc3RydWN0IGR3YzNfcmVxdWVzdCAqcmVxKQ0KPiArc3RhdGljIGlubGluZSB2b2lkIGR3YzNf
Z2FkZ2V0X21vdmVfY2FuY2VsbGVkX3JlcXVlc3Qoc3RydWN0IGR3YzNfcmVxdWVzdCAqcmVxLA0K
PiArCQl1bnNpZ25lZCBpbnQgcmVhc29uKQ0KPiAgew0KPiAgCXN0cnVjdCBkd2MzX2VwCQkqZGVw
ID0gcmVxLT5kZXA7DQo+ICANCj4gLQlyZXEtPnN0YXR1cyA9IERXQzNfUkVRVUVTVF9TVEFUVVNf
Q0FOQ0VMTEVEOw0KPiArCXJlcS0+c3RhdHVzID0gcmVhc29uOw0KPiAgCWxpc3RfbW92ZV90YWls
KCZyZXEtPmxpc3QsICZkZXAtPmNhbmNlbGxlZF9saXN0KTsNCj4gIH0NCj4gIA0KPiANCg0KDQpS
ZXZpZXdlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpU
aGFua3MgZm9yIHRoZSBwYXRjaCwNClRoaW5oDQo=
