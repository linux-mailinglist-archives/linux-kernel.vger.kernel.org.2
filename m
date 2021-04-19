Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF823363C89
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbhDSHcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:32:43 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37384 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237826AbhDSHcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:32:39 -0400
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CC31B4061D;
        Mon, 19 Apr 2021 07:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618817530; bh=V9OK23an2Fgz/wWSci+Js9MyNCEKNpIxz5/driShvWU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=J6AcP4Xf/YL7HzDJ2ZbMiR9u0ZmOQUvTiLCCvRoG5/y3I4pEtp/Y9WFjcAr3nG+g6
         WUVFsviJPkD8JQsmt4RtudKsF1gRFKLGH2NvJHZ/MUPSFNM+qqGXztGZgO7KCP/5pD
         3RrtPJ8UWFibC3n0urnNGYVw0f3z/tO564Bp2geUUXQ4u8ZhcSfNMnzA1OAugrUGMn
         bkmG4JYh0RIBk31TVHRRM9CnFjXKkxIVIg2AzEb6B93E08M2EBWuMWqmtLpvNkkePe
         tcBEdRGmtHKnvA2kJNkp038G2eQaGUnY5FhoYFBL6ya8l566XGRALZAT9rdydoJ7Vs
         XxWre4V9QcxDg==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8BECCA00A8;
        Mon, 19 Apr 2021 07:32:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1B4CB40145;
        Mon, 19 Apr 2021 07:32:10 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="ZASDSHMe";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcVQPjvAey9SN1dDNIUlXmkxqQ/9B4XEaPzCnhDKffi2TD65i4MG/GndV97DC8dg5XkYEXQnZA+1kpTIwa2O232AnWdCrKindnP0hDwYAd1Bcloq8Us8ZDAAZpV2fzMnoBYGIxHEjPWBizTj+axX2D50diF8Iv+APey39O++SzCYxnajGvAQtju1PGv51KVB1TNgVQak1In3Gnnp2ez7EWyM+sBcwTeo3VCOUqmJJnmEBwLZdMIHFs3Z/Hz6/gWi4gH/UYfgOGcTOLMHgHJmA3f2gS84walafDDg1yNb5igwuhkbc30lPt9/wwhiZvGV/XgjfLEmh9Y7AlcbBdYE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9OK23an2Fgz/wWSci+Js9MyNCEKNpIxz5/driShvWU=;
 b=YI/ACibJhJ7lJw827Q7NVSP0BYVdljABiofvxVhLaACwFoLW/2yfgseMj00+tpj6X5DuzNiayjPUR7x6r0te1Qo5afp+jf+eAvNY6TC884uNv18NHSlzVYBtO7bTZQSEn8fmmJCXpUNK86fsGjCZaCPTj/dhRR4F6+pw2cmAmioZvm+VIM7yideT8/YQkaucvUTftCr4Nbvj1WbbHZ4Tr8DCnPDss6Yxr9PJRuELmx5RWevoCHs4p8b32bKmOK+9SRnn+gH5vsPra/t5iMH1pim0DX3kooUHMaciZhfpjwMrj7GKE+chINtSkOh6IqKMhJ2HvU10iZEWYROwR94qYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9OK23an2Fgz/wWSci+Js9MyNCEKNpIxz5/driShvWU=;
 b=ZASDSHMe/12Josqv0MFcH2oqD04ZGRJ2Jg7v00S0FZvvZ5Uzj9S/L6QFVyqqWj8P4vv8mPd4HaDb1D8g8g/ZUo+xNGzyUaehuHaZM7RNyia26XP6+Cm3b1ibKQa5SwN1lXt3/Z22jfMtJps/F+CZRpSj3eJhZn8pwui57elBx+s=
Received: from BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16)
 by BY5PR12MB5000.namprd12.prod.outlook.com (2603:10b6:a03:1d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 07:32:08 +0000
Received: from BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1]) by BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1%4]) with mapi id 15.20.4020.027; Mon, 19 Apr 2021
 07:32:08 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Youn <John.Youn@synopsys.com>
Subject: Re: [PATCH v2 13/15] usb: dwc2: Add exit hibernation mode before
 removing drive
Thread-Topic: [PATCH v2 13/15] usb: dwc2: Add exit hibernation mode before
 removing drive
Thread-Index: AQHXMr7PXMbl1dPfgEOUXNV5eUfKfKq7drcA
Date:   Mon, 19 Apr 2021 07:32:08 +0000
Message-ID: <86873bd0-cf83-74ce-7a7d-8cf7c27bdab7@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
 <20210416124827.9BB59A005D@mailhost.synopsys.com>
In-Reply-To: <20210416124827.9BB59A005D@mailhost.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.80.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9748120d-075d-44f7-0262-08d903053d65
x-ms-traffictypediagnostic: BY5PR12MB5000:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB500065FA2CAD53280EC1D355A7499@BY5PR12MB5000.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7aGs8tk0iqGP3agyzmR48JbQsfYWJ+j6U7Z12+zYPi3VC/2KKAWcCyeVz6R2A8v/ulx8W0WswAw7N3FkkwDjsicA7RLfSc+L0EM6T1pCdPNyFfHf9yZqP/wG4f4pptMiTDuGQkhGLiP1geFJRm7B2bZmSki1qMXU08QQV1r0pMxWhMmQQ7EruF6JAmLRyson+3k+n6Bx+UA2PD7G+IP7HFOl/S5wZRdvfR5MCYorFJAQXorTFp281WA+wO2P/kt89rSpvxaampbzywvF1ruWtxJ8TLZ0bN6grmtSJtINknLzgqTlQXzX36HfRhpZMVqhSEZK/OemiiXXjqyzEt6SU5evJ7O+b4vukbZ+NTzHjI5BKL7+mt85G3iWbbxpFCX3vu55eTGYUFAS+xBQI6NnZfXPoiMyCV2uAlhN0JgqkLoctg4X8bfGUAYjF4qXaXwXGmpFH8/IHSR+xcx16iOPKzGNsc2O9dNgCJRSCLL3LKOfREonmmy9M+Zr/KwpUyUPtM/UTgOM3xB24o7tffQNPAckaZMagMk2NBit7uZfvZPtEzJEaALoVLMs6lHwPQI3t6NzWVZud1HsbDip3y8OaG/bvlukSTi+dxBshB1MbvtjaONbN6pDt6Gx4jdlzckEQUjCpPD6WVqGB38EkR71nf0d+F/2fY8c8FnmYa5RNxq4UwxEJulcC4D6Q1Igsjy5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3462.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(376002)(346002)(136003)(8936002)(31696002)(2616005)(83380400001)(86362001)(110136005)(122000001)(2906002)(31686004)(38100700002)(107886003)(6512007)(316002)(4326008)(186003)(26005)(8676002)(478600001)(71200400001)(66476007)(6486002)(76116006)(64756008)(66946007)(91956017)(66446008)(66556008)(36756003)(53546011)(6506007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bTRpU1p1a1J1a04rNXFPUDFrcGRDcnBzcVlNQW9YQXZ0ZTNIYVovaTVsSXZk?=
 =?utf-8?B?bmVsaWVwanRHRVNUcCs3UW04dEIvTEt6bmRPK3prZGUxQlRFL2NJR0N2SUpK?=
 =?utf-8?B?aHBBTDN1WnJHWnVyNFc1V0drMjNycUo0ODF5SWVZdTFxVU5xV3liNU5BYjJa?=
 =?utf-8?B?UlVlVFVtVFhJeWFHS3lKRE9lRTZDcDlBclFPbHdQaHBSQzVjVU81RlFOY0FL?=
 =?utf-8?B?a0xibDEyNlJKUHZvZy9mZ3kxeU5oVEw0QTZ6U0J2aTJoR1pJN0NiUDNpR1pS?=
 =?utf-8?B?a21mTmtSTUNRbW9WaWs0cHV0d1RYQmxEZjBBcE1CbUdKc2JTQzRmcHIzemw4?=
 =?utf-8?B?NFR2Z0dTWFBjaFlkdmZydDl0aXJibGV2SHlBV3JZdU9MY3B1R2tOU0tpOE1B?=
 =?utf-8?B?a0hqbFMvRU01V0dERmxRYW1KeVV6dUVHUWFhemxSa2pGTk1kN2Nyb2ExZ29z?=
 =?utf-8?B?SjA3T0tJN1FQN0FkSmU1R1lNRkNxVHF1S1h0UHhDZzNoTlpwbkVpeE9kOTJa?=
 =?utf-8?B?VWR0VTVJSi9TakY2TkF3eXNDMnprSkx0NGdCUlZmRldEMjdZSDE2Z0plcHZr?=
 =?utf-8?B?SWNrK3YvNXY0Tm80Rm1EcGZGRkk0Q1Y4Y3Jab0haeDlFOFhZZXR1ai80TlAz?=
 =?utf-8?B?dXR3RVJEekdxVit2NlpNNUtUVWFlcnd1anB3V242T1ExV0VITVdrWWlEQ3Rw?=
 =?utf-8?B?M0ZqQm05bndZODd4SUhweWFnbGxGV3JzNk93TlhpcFlJTmFIUDlHRFBrbDFK?=
 =?utf-8?B?RmVTdWV5Q1M3Rnc4UElpUUtiM0JYdzFmdW5CZ0tDZGxOOWlNRDVZNEd0cFVH?=
 =?utf-8?B?d015WlYvd2YyUE5lZFZ0anRZRXdoWExYZi8zSitEbG5uRndYOVJXejllOVZ4?=
 =?utf-8?B?VzdiT1lYQWkvMVJDTkl4cm1nNUdqWDB5Tkc5N3psYTdQeFlIN0dLZU5qVDVz?=
 =?utf-8?B?OWEzdEVHMjV0N2hFT3ZnUEt2YXpzZHhiV2NsS09CZFYrZVpnMHYxVTFBUkhx?=
 =?utf-8?B?MkNtbjlFNWlReEFjKzJFRTk3TlNoaFRqVG9MMU9zMFg5eGVPbkdDR1hHLzRi?=
 =?utf-8?B?VHhqWEV6ZU14M21pL2VaV01WV1hjcmRFSHNKWnR3Um1kcEJTWm1McmNsT3pm?=
 =?utf-8?B?Ung3bGV2U2ovZkk5eUxHVUQ0R1NMMEZZbEZRM1RnclpqYXFYTU5iOVFtdFhO?=
 =?utf-8?B?cytSREVoQWNGYXFScm04eFZiS3VmVm9yVXplalZnOTR1NFlyOEVKanRLRUwr?=
 =?utf-8?B?Z1p3NHE4SC95SEZNTmxFRDBDVzZlcnM4YlJ5d0g5ZUw0UStSQnFWUGFRRWR4?=
 =?utf-8?B?Ym93Qzd2WlZUWnZnckoyZWtuY0hla0dJVGNkL0ZJaVl0clh6dktuenNEeEQ3?=
 =?utf-8?B?UlI1dFJnRWF3Z1A1ZlozYnJoMkhGZnc1c2IvdTJmOXk4NWo5NUY2QTJDR0ND?=
 =?utf-8?B?ZlIzYmZVcEd3Wk03dFdXMGwwZHN1Ulg1TXVTNnJ3LzIvSWZYc3p6eHFoUGFu?=
 =?utf-8?B?QUt6R3lkRXMzZ0RCUHhwTjlWT3lwREFwRW9ETjl4a29YblFUNnZaSThnb3lR?=
 =?utf-8?B?ZHVpZ2lSaXp0MlFDQXZvUEdOaStzaXN4WDNhR1hQamt1TVhnSGdLejJtcEEv?=
 =?utf-8?B?ejZueGN6QmRZdVo0Vk5jcUNoTFk5aXh6TGl3a2JzR3VnV2tGNEhoaHpmYmIx?=
 =?utf-8?B?a0UyQUpJZ0QreGc3NU56d3Q4ZFFNTDF4N2tiQXVZcFM1a3BDUjhsMlNqT2k0?=
 =?utf-8?Q?cEGdUUJihz01SyCL8k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33BEECF9CE4A1847B4A595E854DE5D9C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9748120d-075d-44f7-0262-08d903053d65
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 07:32:08.8396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EQVpydeWRqk6BOPY17XVGuFJH4h7RgI2vzLoLpC1uOzJ0V32M1vqn4YZTj+aqY8mL0kR6lyMfh3AZwPk5QRmcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xNi8yMDIxIDQ6NDggUE0sIEFydHVyIFBldHJvc3lhbiB3cm90ZToNCj4gV2hlbiBkd2My
IGNvcmUgaXMgaW4gaGliZXJuYXRpb24gbW9kZSBsb2FkaW5nDQo+IGRyaXZlciBhZ2FpbiBjYXVz
ZXMgZHJpdmVyIGZhaWwuIEJlY2F1c2UgaW4NCj4gdGhhdCBtb2RlIHJlZ2lzdGVycyBhcmUgbm90
IGFjY2Vzc2libGUuDQo+IA0KPiBJbiBvcmRlciB0byBleGl0IGZyb20gaGliZXJuYXRpb24gY2hl
Y2tpbmcNCj4gZHdjMiBjb3JlIHBvd2VyIHNhdmluZyBzdGF0ZSBpbiAiZHdjMl9kcml2ZXJfcmVt
b3ZlKCkiDQo+IGZ1bmN0aW9uLiBJZiBjb3JlIGlzIGluIGhpYmVybmF0aW9uLCB0aGVuIGNoZWNr
aW5nIHRoZQ0KPiBvcGVyYXRpb25hbCBtb2RlIG9mIHRoZSBkcml2ZXIuIFRvIGNoZWNrIHdoZXRo
ZXIgZHdjMiBjb3JlDQo+IGlzIG9wZXJhdGluZyBpbiBob3N0IG1vZGUgb3IgZGV2aWNlIG1vZGUg
dGhlcmUgaXMgb25lIHdheQ0KPiB3aGljaCBpcyByZXRyaWV2aW5nIHRoZSBiYWNrdXAgdmFsdWUg
b2YgImdvdGdjdGwiIGFuZCBjb21wYXJlDQo+IHRoZSAiQ3VyTW9kIiB2YWx1ZS4gSWYgcHJldmlv
dXNseSBjb3JlIGVudGVyZWQgaGliZXJuYXRpb24NCj4gaW4gaG9zdCBtb2RlIHRoZW4gdGhlIGV4
aXQgaXMgcGVyZm9ybWVkIGZvciBob3N0IGlmIG5vdCB0aGVuDQo+IGV4aXQgaXMgcGVyZm9ybWVk
IGZvciBkZXZpY2UgbW9kZS4gVGhlIGludHJvZHVjZWQgY2hlY2tpbmcNCj4gaXMgYmVjYXVzZSBp
biBoaWJlcm5hdGlvbiBzdGF0ZSBhbGwgcmVnaXN0ZXJzIGFyZSBub3QNCj4gYWNjZXNzaWJsZS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFydHVyIFBldHJvc3lhbiA8QXJ0aHVyLlBldHJvc3lhbkBz
eW5vcHN5cy5jb20+DQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVs
LmNvbT4NCj4gUmVwb3J0ZWQtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xl
LmNvbT4NCg0KQWNrZWQtYnk6IE1pbmFzIEhhcnV0eXVueWFuIDxNaW5hcy5IYXJ1dHl1bnlhbkBz
eW5vcHN5cy5jb20+DQoNCj4gLS0tDQo+ICAgZHJpdmVycy91c2IvZHdjMi9wbGF0Zm9ybS5jIHwg
MTUgKysrKysrKysrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL3BsYXRmb3JtLmMgYi9kcml2ZXJz
L3VzYi9kd2MyL3BsYXRmb3JtLmMNCj4gaW5kZXggZjhiODE5Y2ZhODBlLi44YWQzM2UwNDJhMTQg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzIvcGxhdGZvcm0uYw0KPiArKysgYi9kcml2
ZXJzL3VzYi9kd2MyL3BsYXRmb3JtLmMNCj4gQEAgLTMxNiw4ICszMTYsMjMgQEAgc3RhdGljIGlu
dCBkd2MyX2xvd2xldmVsX2h3X2luaXQoc3RydWN0IGR3YzJfaHNvdGcgKmhzb3RnKQ0KPiAgIHN0
YXRpYyBpbnQgZHdjMl9kcml2ZXJfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmRldikN
Cj4gICB7DQo+ICAgCXN0cnVjdCBkd2MyX2hzb3RnICpoc290ZyA9IHBsYXRmb3JtX2dldF9kcnZk
YXRhKGRldik7DQo+ICsJc3RydWN0IGR3YzJfZ3JlZ3NfYmFja3VwICpncjsNCj4gICAJaW50IHJl
dCA9IDA7DQo+ICAgDQo+ICsJZ3IgPSAmaHNvdGctPmdyX2JhY2t1cDsNCj4gKw0KPiArCS8qIEV4
aXQgSGliZXJuYXRpb24gd2hlbiBkcml2ZXIgaXMgcmVtb3ZlZC4gKi8NCj4gKwlpZiAoaHNvdGct
PmhpYmVybmF0ZWQpIHsNCj4gKwkJaWYgKGdyLT5nb3RnY3RsICYgR09UR0NUTF9DVVJNT0RFX0hP
U1QpDQo+ICsJCQlyZXQgPSBkd2MyX2V4aXRfaGliZXJuYXRpb24oaHNvdGcsIDAsIDAsIDEpOw0K
PiArCQllbHNlDQo+ICsJCQlyZXQgPSBkd2MyX2V4aXRfaGliZXJuYXRpb24oaHNvdGcsIDAsIDAs
IDApOw0KPiArDQo+ICsJCWlmIChyZXQpDQo+ICsJCQlkZXZfZXJyKGhzb3RnLT5kZXYsDQo+ICsJ
CQkJImV4aXQgaGliZXJuYXRpb24gZmFpbGVkLlxuIik7DQo+ICsJfQ0KPiArDQo+ICAgCS8qIEV4
aXQgUGFydGlhbCBQb3dlciBEb3duIHdoZW4gZHJpdmVyIGlzIHJlbW92ZWQuICovDQo+ICAgCWlm
IChoc290Zy0+aW5fcHBkKSB7DQo+ICAgCQlyZXQgPSBkd2MyX2V4aXRfcGFydGlhbF9wb3dlcl9k
b3duKGhzb3RnLCAwLCB0cnVlKTsNCj4gDQoNCg==
