Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E5A3FA1D3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 01:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhH0Xbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 19:31:44 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:46486 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232405AbhH0Xbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 19:31:43 -0400
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 541FAC04A5;
        Fri, 27 Aug 2021 23:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1630107053; bh=Qe6gVQcAzHC1BJbwVaTDEkrrkL/Lie6RqViDKYLUndI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=AIOk97i9V6XmDTK/xh9w2kgAcJlR6EglzbKF0BJsPz6/LvC+h6cJyrNYMfa6wQccY
         tbbJ7MOSA38o0NrADw56s0Our5ernLs5V1V0vzwYm4SADVZg860KTE/YTrdAKnSxg4
         YvgG0lKBUAjFq6Um6Lk1124whpNz01QbF/TaWiwrPil91dl37SBeguTD5PKX1oLnAS
         x5+qXNLz9qE33mGn1VEAapzZLYFfK4D6Z8lMjNMDMWQFUw95OlCcNJd9gp/Mf6CrmH
         WOPI/ZOFHOsnPqFhSPbXUZ8nc0XyM6PmtXUgIk4HajuNNPwDlHNIYQuk5AndEkwAZr
         CZBaBIpR6OdVw==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id DB17DA0080;
        Fri, 27 Aug 2021 23:30:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2FB71801BF;
        Fri, 27 Aug 2021 23:30:46 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="e1P852N0";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0ttLTtrWZrUrEgjvGzXyVgNQQFkCL3uEaJvDCxTqICCm3roWGA2SX14P0H1vftmZZifu8O2SN9b8bQhgAzetRpVOsMN2KiFLsEyLSY5FUOcJ5tmYFLGNcguHJinqKBOGAhDFeF+/PsjHd0M5NSU6hLRKAqShsF1ldjsQay1Xz2nLEE526TZwdz1neErUkOhhblDZNBjCPStLLkt9JJVx1jIuDv0I0MDNehsc+JQ9TTqFrBQ5TxaI6A4xhstBqn55iveG/9FlXc1Y4rbOwWwcea8XWMJRiGIn043AagvTiTo3o55NQ2MJ8QxVKcw4Nkl60k+kJdhZu+wg0NImyeJTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qe6gVQcAzHC1BJbwVaTDEkrrkL/Lie6RqViDKYLUndI=;
 b=KfkCjEjanx12WYxC2bnNqNDBBho4cACr3GwDIkMCy97+dPJ0ofiJBjYxtJLJCuqQmu4fX/mE6PLA6MvsDOpFX6xLJOVjDgYufAON6HKY5ZX411c/m/a5Q3ZrKCGgV8WHklcmhVrsGRIZ51UQfR8kqrJSFOZ/RENefcrJOD3ePRRkiOkuNYI2gSDBVy6sYlFFdY1kY0/Ru1dpjEFClGSeWwOET87nKSUoenRuhCbz75iX2QgcNJURo5DpIMSflaE4W1y9NLoyBIG5E6uwCrlJkuNpkAvJgiFT/6yysM6ABelabeSTGfDGWdcUTYj3fFgH50Bdqoo9vm5gSJZWpdWQJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qe6gVQcAzHC1BJbwVaTDEkrrkL/Lie6RqViDKYLUndI=;
 b=e1P852N0QCGwoMcbew7Qbp8DoXIza1Gv4mYi2Dn5A4LJoOnULEeX8V4QfI1qgxP6hFnBJ1fEUAkVqx1+6LOQRjrx26Icngt0Ak8WJJTGZnJs37pUV5qPSD4aEuKsovsGVO1PjQlosfbDEqo+NY9wu5fy7RT7pAK1LjmdxPvm87c=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB2853.namprd12.prod.outlook.com (2603:10b6:a03:13a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Fri, 27 Aug
 2021 23:30:45 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::508a:1772:de73:d89e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::508a:1772:de73:d89e%4]) with mapi id 15.20.4457.017; Fri, 27 Aug 2021
 23:30:45 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Ferry Toth <fntoth@gmail.com>,
        Ferry Toth <ftoth@exalondelft.nl>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Pavel Hofman <pavel.hofman@ivitera.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jack Pham <jackp@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: f_uac2: fixup feedback endpoint stop
Thread-Topic: [PATCH] usb: gadget: f_uac2: fixup feedback endpoint stop
Thread-Index: AQHXmZKbDUm/TJv5RU+0RTPysUL82KuEpnqAgAAar4CAAKLBAIABJAqAgACCpACAAPlggA==
Date:   Fri, 27 Aug 2021 23:30:45 +0000
Message-ID: <1340ee16-b689-442e-71ce-12db0edd9dd0@synopsys.com>
References: <20210824201433.11385-1-ftoth@exalondelft.nl>
 <20210825092107.124419-1-jbrunet@baylibre.com>
 <79bd686d-5c1f-982c-344a-17c10b64a231@gmail.com>
 <9709a13f-46f5-ad53-3d19-86b4954bb0f8@synopsys.com>
 <1jbl5ky7a4.fsf@starbuckisacylon.baylibre.com>
 <a2bbb7eb-f952-bc35-6a58-68b15515c716@synopsys.com>
 <1jk0k7w853.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jk0k7w853.fsf@starbuckisacylon.baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec9068b2-cd13-4fa8-ab0e-08d969b2b1c0
x-ms-traffictypediagnostic: BYAPR12MB2853:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB28530D183765D50672F89547AAC89@BYAPR12MB2853.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 56gCctNFI2eLshuOBOjt39QkRlHrNNKP3/Y5jS2ug/9VLD6i9sqBvZWnqxPGLqU4GZAWRjkTOHmOdN7jF3/jrrbRZvy/B2G2hyCzz5PW/FvR16rZ8WC1tm/duYqNUL2U4FtU2J6quMjdVvaq3iwcshvVnBs0yGJ2m0pdhXOk8AuD+/Qtbx7pHo11V6lswN+0Kc+2GsBTyIROc6wQy9Eg4oih1mRv9TTKHQDNiCkleywocR6KCRgvq5MrSk9YfiO5jsmVrU7j9z0Q5Mid/RKN4eZvN66Xo6kte+7cY27g1UUsMrq4n4JZkUqvhLRBy7Ucn5/CXs7cLixLlMahWL26BjrNn+8/a2G//KN4n/8uh4NkTL1/j2yiOjRfSKBzCM/B0+M8Ly73uZAzg+kBU8+AmyzULtKOIpJv4kr99qrpozZV6GLcBsrvQ2xhNSzrt23kODZEZwC10knNV2Af/CnQz2NXb8wdze23lGRHWFNPXz7B/zR0gNl67UfEY/kDHN9LVxOgCRyLIdvlrNPVeC0I4m02Wm0z7jvChzOEzwpm85xm3WFxJHkBd9Cf/LcbW93d9XvA4kKmtv51N8oQN43P1NwebSl33U7GMakqzIEg8s1Cb9ukq0/1ip5AapoKA+kcloS81yUUeQKiXAxM877xaT3Ju6Z6q2H6tZlA+EbPRAuXju+zh9wXOeT8ovOWwFBHhwsbt/qzA8PQVFEHvn1+mxge6C67x6wfQBMosfX79UDGsN0tUl0wC2fCInQp/2hKLjluNlAet3hyJab4hJ2VjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(136003)(346002)(376002)(38100700002)(8676002)(36756003)(4326008)(2616005)(6506007)(31696002)(86362001)(6512007)(122000001)(83380400001)(478600001)(66446008)(76116006)(31686004)(8936002)(66556008)(26005)(316002)(66476007)(71200400001)(2906002)(7416002)(54906003)(186003)(110136005)(38070700005)(66946007)(5660300002)(64756008)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGxMTGJkWm1WNlhUSnlzZE9kbW8zRjVhajVlY1YrZU9QOXJwK0grQXR5b2dV?=
 =?utf-8?B?OWczNWh0Ymt1NFBLSmhFU3IzY252b1BialMwazBZSFVJMDFlWTlqYnU5ODAv?=
 =?utf-8?B?dnVCTFNBVnNGUVJMVlg5cGFQU2FpejJBSTl0dG9MdE1LNHlrWlBKclVuUEov?=
 =?utf-8?B?ZTlqT2FURGJhOExqbWVyb2J4MzFxTFRnM2xDeFpoMHplVFk1Z2J4bE9FQWhh?=
 =?utf-8?B?bUlKRmhsUSsyVy8zZjV1ZzVSVG9FN0ZYYkI3WDYvaFp4MXJ1YVFKWGx3bXBN?=
 =?utf-8?B?KzJ1d3p1Z01hbEFGSjNLcmJjN3kvcEVwQ1djOVlOL2MwKzdES2tyUHRENTVB?=
 =?utf-8?B?SVlEbW9rSzhnTXNYVDd3ZGJMZnFxSVZQNjJPKzYzakx6MEM4UTMyNG15RFk1?=
 =?utf-8?B?YVpyQ0JaUkVUbkI1ZEN0Y1Zmb2Q3ZG45NUdzTWVMRHc3UnZwWkR2MFdSKzd4?=
 =?utf-8?B?NTNZMnRUSnhHZ3ZVdEJOekNQRTFobWZPUDQvaHp6ZUk4akFxcytBOHVtek5N?=
 =?utf-8?B?NVhwTVNXUVNuWjZSQ3p2WWpPOHV5VVlETitLYjZTWXpWZTRLRDdZMGdObmZ6?=
 =?utf-8?B?Wk1OelUrSHArYlUzVTFrOW14OVU3ZURJOEowSDE4bUlaa0RIa1JmMjVBUTho?=
 =?utf-8?B?SlFiNm1lNUhFVmdwMFhRc0RodTA3OUV2d3JicS9KTG9yMjAySmtNNTZVN2JY?=
 =?utf-8?B?M0QwS0ZwcUFWZnhJaVprTUFlSHFreWRBaTkwYnRTZ01yd3ZvejBRN3Vkb2RR?=
 =?utf-8?B?S1NsaGtURTNkZ3QyTEJ4VnJ2UTE2NXhxMTkwY3FPU0NHNDdYby9BV0lZUFVu?=
 =?utf-8?B?bGVVdHkyVzFhRU1JYnFISTBnWHdaWGZTbFdtUW02OU43bHBVMkZqMUsvVGZE?=
 =?utf-8?B?VkdRUDQ1eFIrSlFibFYwUC85Qy9rYUJzRGs1c25TKzdtZzV5UjRiays4ZlUr?=
 =?utf-8?B?anJRMi9UL1k2VHI0TmgxeFlOZ0pMS2VEbnhFeEhucWRGNG9XaFJPaFZ0b0Fz?=
 =?utf-8?B?dVgzVUxtS0p4NjViaWdmUkdxTGF5UC9GQTQvbURId1RvM3htM0dFM1lHaGZz?=
 =?utf-8?B?dDZTSU9YZTBrR1hQajJPWVdQUGY5QmQ4eEJ6Q2FpQVRPNFlDVi9ic0V5eGdx?=
 =?utf-8?B?NHdXcGxMY2MyamlkS3B1WDR1UFgxVHF6U2oveGQ0UTF0dnowTHFxT0xBV3U5?=
 =?utf-8?B?ZWs0a01oQlh3UGZKTm05RlJoTXg2cU9Ed2swd2VUSVdrc2Q2QkNpN3dNbVJk?=
 =?utf-8?B?dEpuSVZoWmZlN2hMYzhYSThNcUUzY0pNTlllRXl4YXhleXV5eVZzTkZHdXRW?=
 =?utf-8?B?WVVIZk1USE8rZFBLeEhEUWVEZ1FSRVkwNFhlWVZiWHFmTEVHbDg3OWdTL0I2?=
 =?utf-8?B?bzViaGIzaEtJUGJVRm10OEJUY1FqV0hlc2k3NUgxbmcwb01JbCtIL2F6VWpU?=
 =?utf-8?B?QStsMGpyQWRaaHRtcWg3eWhUWCtSYmlJdXlkb1pkeTRkczByLzF0TjNIZVlY?=
 =?utf-8?B?czBjVXhINTlIRk5pVWltd2x4SWxqa0N5REJFYjhoUllQOFc0SEtzWXpSdG9P?=
 =?utf-8?B?K3N4R1dobEFsZExlZk43QVJsNENJM2kwbjI5VERIZURHRVJmYVM5Yythellq?=
 =?utf-8?B?cmptaDY5aDRZSHdVL0dEZVB2MVhIRmRGUDgvWWRqK1hxc0doc3QrTDBvOHhJ?=
 =?utf-8?B?ejVtMkhiN0c3ajhFYnhFbi8rM2Fkb2d0N2Y3NDlDZmNSOHNrUnZFNWZ1UDF3?=
 =?utf-8?Q?1qewmDvMt2pZiIZh8g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBD9B227C0A00647864EA81026DCA134@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9068b2-cd13-4fa8-ab0e-08d969b2b1c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 23:30:45.5885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dpA0l6HnXtj9MWCOd4kB33W3gBNHct+xCaj9/U70OJVGzpSwZOSkLrHOrWl9LxQ5uiIJziYELQh8/Mv+TVJ67g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2853
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SmVyb21lIEJydW5ldCB3cm90ZToNCj4gDQo+IE9uIEZyaSAyNyBBdWcgMjAyMSBhdCAwMDo1MCwg
VGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPiB3cm90ZToNCj4gDQo+Pj4+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X2F1ZGlvLmMNCj4+
Pj4+PiBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X2F1ZGlvLmMNCj4+Pj4+PiBpbmRl
eCAwMThkZDA5Nzg5OTUuLjYzZDkzNDBmMDA4ZSAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9kcml2ZXJz
L3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9hdWRpby5jDQo+Pj4+Pj4gKysrIGIvZHJpdmVycy91c2Iv
Z2FkZ2V0L2Z1bmN0aW9uL3VfYXVkaW8uYw0KPj4+Pj4+IEBAIC0yMzAsNyArMjMwLDEzIEBAIHN0
YXRpYyB2b2lkIHVfYXVkaW9faXNvX2ZiYWNrX2NvbXBsZXRlKHN0cnVjdA0KPj4+Pj4+IHVzYl9l
cCAqZXAsDQo+Pj4+Pj4gwqDCoMKgwqDCoCBpbnQgc3RhdHVzID0gcmVxLT5zdGF0dXM7DQo+Pj4+
Pj4gwqAgwqDCoMKgwqDCoCAvKiBpL2Ygc2h1dHRpbmcgZG93biAqLw0KPj4+Pj4+IC3CoMKgwqAg
aWYgKCFwcm0tPmZiX2VwX2VuYWJsZWQgfHwgcmVxLT5zdGF0dXMgPT0gLUVTSFVURE9XTikNCj4+
Pj4+PiArwqDCoMKgIGlmICghcHJtLT5mYl9lcF9lbmFibGVkKSB7DQo+Pj4+DQo+Pj4+IHBybS0+
ZmJfZXBfZW5hYmxlZCBpcyBub3QgcHJvdGVjdGVkLiBQb3RlbnRpYWwgcmFjZSBwcm9ibGVtIGhl
cmU/DQo+Pj4NCj4+PiBHaXZlbiBob3cgdGhlIHZhcmlhYmxlIGlzIHVzZWQsIEkgZG9uJ3QgdGhp
bmsgc28uDQo+Pj4gQ291bGQgeW91IHBsZWFzZSBkZXRhaWwgPw0KPj4+DQo+Pg0KPj4gSSdtIHRo
aW5raW5nIG9mIHRoaXMgc2NlbmFyaW86DQo+Pg0KPj4gU2luY2UgZnJlZV9lcF9mYmFjaygpIGlz
IGNhbGxlZCBpbiBhIHNlcGFyYXRlIHRocmVhZCwNCj4+IHVfYXVkaW9faXNvX2ZiYWNrX2NvbXBs
ZXRlKCkgY2FuIGNvbWUgaW4gdGhlIG1pZGRsZSBhZnRlcg0KPj4gcHJtLT5mYl9lcF9lbmFibGVk
IGlzIGNsZWFyZWQgYnV0IGJlZm9yZSB0aGUgdXNiX2VwX2RlcXVldWUoKS4gU28gdGhlDQo+PiBy
ZXF1ZXN0IG1heSBiZSBmcmVlZCBiZWZvcmUgYmVpbmcgYWNjZXNzZWQgYWdhaW4gaW4gdXNiX2Vw
X2RlcXVldWUoKS4NCj4+DQo+IA0KPiBZb3UgYXJlIHJpZ2h0IC0gdGhlcmUgaXMgc2hvcnQgd2lu
ZG93IG9mIG9wcG9ydHVuaXR5Lg0KPiBMb29rcyBsaWtlIGEgMm5kIHNlcGFyYXRlIGlzc3VlIGFm
ZmVjdGluZyBhbGwgdV9hdWRpbyBlbmRwb2ludHMuIChXb3VsZA0KPiBiZSBzb2x2ZWQgYnkgcmV2
ZXJ0aW5nIHRoZSBmZWVkYmFjayBzZXJpZXMpDQo+IA0KPiBGaXggc2VlbXMgZmFpcmx5IHNpbXBs
ZS4NCj4gDQo+Pj4gKEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyByZWFsbHkgcmVsYXRlZCB0byB0aGUg
Y3VycmVudCBwcm9ibGVtIHRob3VnaCkNCj4+DQo+PiBJdCdzIHJlbGF0ZWQgdG8gaG93IHdlIGdv
IGFib3V0IHRvIHNvbHZlIHRoZSBwcm9ibGVtIHJpZ2h0Pw0KPj4NCj4+IENhbiB3ZSBqdXN0IGNo
ZWNrIGZvciB0aGUgcmVxLT5zdGF0dXMgZm9yIC1FQ09OTlJFU0VUIGFuZCAtRVNIVVRET1dOIGFu
ZA0KPj4gZnJlZSB0aGUgcmVxdWVzdD8gVGhvc2UgMiBzdGF0dXNlcyBzaG91bGQgYmUgZm9yIHdo
ZW4gdGhlIHJlcXVlc3QgaXMNCj4+IGNhbmNlbGxlZCBhbmQgd2hlbiB0aGUgZW5kcG9pbnQgaXMg
ZGlzYWJsZWQuDQo+Pg0KPiANCj4gVGhlIHNhbWUgcHJvYmxlbSBoYXBwZW5lZCBvbiB0aGUgZGF0
YSBlbmRwb2ludCB3aGlsZSBmZWVkYmFjayB3YXMgYmVpbmcNCj4gcmV2aWV3ZWQuIFRoaXMgaXMg
d2h5IGRhdGEgZ290IGZpeGVkLCBhbmQgdGhlIGZlZWRiYWNrIGVuZHBvaW50IGRpZCBub3QuDQo+
IA0KPiBBcyBleHBsYWluZWQgaW4gdGhlIGRlc2NyaXB0aW9uLCB0aGUgZml4IGlzIG1lcmVseSBh
bGlnbmluZyB3aGF0IGlzDQo+IGRvbmUgZm9yIHRoZSBkaWZmZXJlbnQgZW5kcG9pbnRzIGhlcmUu
DQoNCklNSE8sIGl0J2QgYmUgYmV0dGVyIGlmIHdlIGNhbiBoYXZlIGEgcHJvcGVyIGZpeCB0byB0
aGUgbmV3bHkgaW50cm9kdWNlZA0KZmVlZGJhY2sgZW5kcG9pbnQgc28gdGhhdCBkb2Vzbid0IGxl
YXZlIHByb2JsZW1zIHRvIGJlIHBhdGNoZWQgdXAgbGF0ZXIuDQpUaGlzIG1ha2VzIGl0IGVhc2ll
ciB0byBiYWNrcG9ydCBmaXggcGF0Y2hlcyB0aGF0IGRvbid0IHRvdWNoIHRvbyBtYW55DQpwbGFj
ZXMuDQoNCj4gDQo+IFNvbWUgb2YgdGhlIHBlb3BsZSB3aG8gaGF2ZSB3b3JrZWQgb24gdGhpcyBh
cmUgbm8gVVNCIGV4cGVydCAobXlzZWxmDQo+IGluY2x1ZGVkKSBzbyBJJ20gc3VyZSB0aGluZ3Mg
Y2FuIGJlIGltcHJvdmVkLiBJJ2Qgc3VnZ2VzdCB0byB0YWtlIHRoZQ0KPiByZXdvcmsgdV9hdWRp
byBhcyBhIDJuZCBzdGVwLg0KDQpTdXJlLiBJIGp1c3Qgd2FudGVkIHRvIGJyaW5nIHRoZW0gdXAg
YXMgSSBub3RpY2UgdGhlbSB3aGlsZSBsb29raW5nDQp0aHJvdWdoIHRoZSByZXBvcnRlZCBwYXRj
aC4NCg0KPiANCj4+Pg0KPj4+Pg0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBrZnJlZShyZXEtPmJ1
Zik7DQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHVzYl9lcF9mcmVlX3JlcXVlc3QoZXAsIHJlcSk7
DQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4+Pj4+PiArwqDCoMKgIH0NCj4+Pj4+
PiArDQo+Pj4+Pj4gK8KgwqDCoCBpZiAocmVxLT5zdGF0dXMgPT0gLUVTSFVURE9XTikNCj4+Pj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPj4+Pj4+IMKgIMKgwqDCoMKgwqAgLyoNCj4+
Pj4+PiBAQCAtNDIxLDkgKzQyNywxMCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZnJlZV9lcF9mYmFj
ayhzdHJ1Y3QNCj4+Pj4+PiB1YWNfcnRkX3BhcmFtcyAqcHJtLCBzdHJ1Y3QgdXNiX2VwICplcCkN
Cj4+Pj4+PiDCoMKgwqDCoMKgIHBybS0+ZmJfZXBfZW5hYmxlZCA9IGZhbHNlOw0KPj4+Pj4+IMKg
IMKgwqDCoMKgwqAgaWYgKHBybS0+cmVxX2ZiYWNrKSB7DQo+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKg
IHVzYl9lcF9kZXF1ZXVlKGVwLCBwcm0tPnJlcV9mYmFjayk7DQo+Pj4+Pj4gLcKgwqDCoMKgwqDC
oMKgIGtmcmVlKHBybS0+cmVxX2ZiYWNrLT5idWYpOw0KPj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCB1
c2JfZXBfZnJlZV9yZXF1ZXN0KGVwLCBwcm0tPnJlcV9mYmFjayk7DQo+Pj4+Pj4gK8KgwqDCoMKg
wqDCoMKgIGlmICh1c2JfZXBfZGVxdWV1ZShlcCwgcHJtLT5yZXFfZmJhY2spKSB7DQo+Pj4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAga2ZyZWUocHJtLT5yZXFfZmJhY2stPmJ1Zik7DQo+Pj4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdXNiX2VwX2ZyZWVfcmVxdWVzdChlcCwgcHJtLT5y
ZXFfZmJhY2spOw0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB9DQo+Pj4+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgIHBybS0+cmVxX2ZiYWNrID0gTlVMTDsNCj4+Pj4+PiDCoMKgwqDCoMKgIH0NCj4+Pj4+
PiDCoCANCj4+Pj4NCj4+Pj4gT24gYSBzZXBhcmF0ZSBub3RlLCBJIG5vdGljZSB0aGF0IGZfdWFj
MiBvbmx5IHF1ZXVlcyBhIHNpbmdsZSBmZWVkYmFjaw0KPj4+PiByZXF1ZXN0IGF0IGEgdGltZSBm
b3IgaXNvYyBlbmRwb2ludD8gRXZlbiB0aG91Z2ggdGhlIGludGVydmFsIGlzIDFtcywNCj4+Pj4g
dGhpcyB3aWxsIGVhc2lseSBjYXVzZSBkYXRhIGRyb3AuDQo+Pj4+DQo+Pj4+IEFsc28sIHlvdSdy
ZSBpZ25vcmluZyBvdGhlciByZXF1ZXN0IGVycm9yIHN0YXR1cyBhbmQgc3RpbGwgcHJvY2Vzc2lu
Zw0KPj4+PiBib2d1cyBkYXRhIG9uIHJlcXVlc3QgY29tcGxldGlvbj8gVGhhdCBkb2Vzbid0IHNl
ZW0gcmlnaHQuDQo+Pj4NCj4+PiBHYWRnZXQgaXMgc2VuZGluZCB0aGUgZmVlZGJhY2sgZGF0YSwg
bm90IHByb2Nlc3NpbmcgaXQuIEV2ZXJ5IGRhdGEgc2VudA0KPj4NCj4+IEFoIG9rLi4gSSBtaXNz
ZWQgdGhhdCBpdCdzIElOIHJlcXVlc3QuDQo+Pg0KPj4+IGlzIE9LLiAgWWVzLCBwYWNrZXRzIGNh
biBiZSBtaXNzZWQgd2l0aCB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiwNCj4+PiBtZWFuaW5n
IHRoZSBmZWVkYmFjayB2YWx1ZSBpcyBub3QgcmVwb3J0ZWQgYXMgb2Z0ZW4gYXMgaW5pdGlhbGx5
DQo+Pj4gaW50ZW5kZWQuIE9uIHNsb3dlciBIVywgcGFja2V0cyBhcmUgYWxzbyBtaXNzZWQgd2l0
aCAyIHJlcXVlc3RzIHF1ZXVlZCwNCj4+DQo+PiAyIGlzIHN0aWxsIHRvbyBsb3cuIEZyb20gb3Vy
IEhXIHRlc3RpbmcsIG1pbmltdW0gc2hvdWxkIGJlIDQgdG8gbWluaW1pemUNCj4+IGRhdGEgbG9z
cyBhdCAxbXMgaW50ZXJ2YWwuDQo+IA0KPiBNYXliZSA0IHNob3VsZCBiZSB0aGUgZGVmYXVsdCB0
aGVuID8NCg0KWWVzLiBXb3VsZCBpdCBiZSBhIHByb2JsZW0/DQoNCj4gDQo+Pg0KPj4+IG5vdCBv
bmx5IG9uIHRoZSBmZWVkYmFjayBlbmRwb2ludCBidXQgYWxzbyBvbiB0aGUgcGxheWJhY2sNCj4+
PiBlbmRwb2ludC4gUGlja2luZyB0aGUgYXBwcm9yaWF0ZSB2YWx1ZSBpcyBub3Qgc3RyYWlnaHQg
Zm9yd2FyZC4gRm9yIHRoZQ0KPj4+IGZlZWRiYWNrIGVuZHBvaW50IGl0IGlzbid0IGJpZyBkZWFs
IGJlY2F1c2UsIGFjY29yZGluZyB0byB0aGUgc3BlYywgaWYNCj4+PiB0aGUgZmVlZGJhY2sgaXMg
bm90IHNlbnQsIHRoZSBob3N0IHNoYWxsIGFzc3VtZSB0aGUgdmFsdWUgaGFzbid0DQo+Pj4gY2hh
bmdlZC4gVGhpcyB3aHkgdGhlIHdob2xlIHRoaW5nIHdvcmtzIGFzIGl0IGlzLg0KPj4NCj4+IFdo
eSBkbyB0aGlzIHdoZW4gd2UgY2FuIGF2b2lkIGl0Lg0KPiANCj4gQmVjYXVzZSBpdCB3YXMgbm90
IGtub3duIGF0IHRoZSB0aW1lDQo+IA0KPj4gV2Uga25vdyB0aGF0IHRoZXJlIHdpbGwgYmUgZGF0
YSBkcm9wDQo+PiB3aXRoIHRoZSB3YXkgaXQncyBpbXBsZW1lbnRlZCBub3cuIFRoZXJlJ3Mgbm8g
b3B0aW9uIHRvIGFkanVzdCB0aGUNCj4+IG51bWJlciBvZiBmZWVkYmFjayByZXF1ZXN0cyBlaXRo
ZXIuDQo+Pg0KPj4+DQo+Pj4gSSBhZG1pdCB0aGluZ3Mgc3RpbGwgYXJlbid0IHBlcmZlY3QsIGJ1
dCB0aGVyZSBpcyBwcm9ncmVzcyAuLi4NCj4+Pg0KPj4gVGhhbmtzIGZvciB0aGUgdXBkYXRlcyB0
byBhdWRpby9mX3VhYzIuIEl0J3MgYmVlbiBhIGxvbmcgdGltZSBzaW5jZQ0KPj4gYW55b25lIHdv
cmtpbmcgb24gaXQuDQo+Pg0KDQpUaGFua3MsDQpUaGluaA0K
