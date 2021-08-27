Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C313F916C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 02:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243869AbhH0Avj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 20:51:39 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:47382 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243811AbhH0Avh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 20:51:37 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CE58946776;
        Fri, 27 Aug 2021 00:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1630025449; bh=RZzgw18Uq7bhzLDZ/hwZ35ca2GJWstJkqYH6qAsNYqA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=kp3haRnPk9yz/nQ4/iNlPl4G4g6TxXbZaFKGpz2+HyQMMWPQDFmhE7BX/qz3HPsnq
         fvgBitveqdUU33f3Ax2IByLeAoo3x+N6mFkEoC37ryab/gBnAFxZROc5S1NB8gUaWP
         0htrlDfwI5XEJJbUJoEV5iIJzeskvYD1xKgU+g8EBe1D8tlA+8smIBqTOpjkTi8gQk
         v3D7FNDA7Bf8mpZfRmFuCxkTXpJanbB1P7LbeFrWiq/S5x2K6hIYCVuiz7rtHNQWfv
         6yYUMmq5KJDQykYsQOnGrhdYpxlQ8/LzwyD61q+Tz1/pX5gwqQ3aQv405nCmzPZlyV
         zQBMhGJdtbzsA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 24FAAA006F;
        Fri, 27 Aug 2021 00:50:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (unknown [104.47.59.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A8FED400A2;
        Fri, 27 Aug 2021 00:50:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="pJnRsH5y";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ep2DKKoC+EUZEATySsjZOaoOyKJbLGBlfcxyqhHx/5JqIJ6vA9vb+k60rWMGC2XLwgi17UV1i5lb0pbK44shQJdtSxelPfXsCT3vEb87Hq8A80StlG5l4V+LKS/GQfzGgFCpTBdLoEVGOTjhgEOP9EhOBSHfIesYeHYR6pTwhAKB8LZXk2ZPktmkMwUCrnkUG6Y+qAMu6DOfCBInD18SXuAMYvSxwjAHxtVMerc5Rk6Z70+Z0oF3eL7v8oaUVamPpj8VoWaD5oFbgqQhtV33uzg9v8ZxGrXl31sxuyzft/w55taRwQ9zjWAO6s3SyXuEEk9qiPcijvAU0eT18g7oXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZzgw18Uq7bhzLDZ/hwZ35ca2GJWstJkqYH6qAsNYqA=;
 b=oBFIvwQiNdGsCnpz1Eqq3DOp4uFK/kWj2lBfaPInaUlR8DyOcBBWsBxB7ZC5tOyD3dkgg5O5wL/HfxwqqzeWXroRjI0WN6GvO0Iqz70cOLkyyNhH5GaA/RXY12ZRRY2OLUA5VVoPiSADy3QYgnKZ7PPvhSjsYrHJDWsvMKnAOyEWWa9WhX1EEFdrgvwi353flHNqIP+7WbYBnm/eRUBOwTM42AEw0pRTkcbPvtj4A6kXbgAY1EBz4u+8iQOPpvMYkq9oq39UiJXJ4Ds+/cuM17/biPzt4uZ0nkObInfEhNPSgm1i7zHGinMLTXA12DyUvG28YdnOOuT/ulsLC2354g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZzgw18Uq7bhzLDZ/hwZ35ca2GJWstJkqYH6qAsNYqA=;
 b=pJnRsH5yJwe1D1Nzl3oIokVHVweGazEA4wQmpxidSmf0ETMb5p2EMCrGGXohS1XTbNmYLejQna80nKoK41UgvzT9DWDYfUhxXcYz/UjCnm0BMEzZl4ml+/v6wa36vjZa6MKeuE9/hKO3aOEKOgzmIYcAGqQ3uAO4PM+RT8PHDa4=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Fri, 27 Aug
 2021 00:50:38 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::508a:1772:de73:d89e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::508a:1772:de73:d89e%4]) with mapi id 15.20.4457.017; Fri, 27 Aug 2021
 00:50:38 +0000
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
Thread-Index: AQHXmZKbDUm/TJv5RU+0RTPysUL82KuEpnqAgAAar4CAAKLBAIABJAqA
Date:   Fri, 27 Aug 2021 00:50:38 +0000
Message-ID: <a2bbb7eb-f952-bc35-6a58-68b15515c716@synopsys.com>
References: <20210824201433.11385-1-ftoth@exalondelft.nl>
 <20210825092107.124419-1-jbrunet@baylibre.com>
 <79bd686d-5c1f-982c-344a-17c10b64a231@gmail.com>
 <9709a13f-46f5-ad53-3d19-86b4954bb0f8@synopsys.com>
 <1jbl5ky7a4.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jbl5ky7a4.fsf@starbuckisacylon.baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78fdd2ab-7231-4590-9d5d-08d968f4b004
x-ms-traffictypediagnostic: BY5PR12MB4099:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4099E831544D462C01E13496AAC89@BY5PR12MB4099.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A5sMAOwGkFvMvuPAkXYnQ8n/Oly9agXu7xunZvkSV8gi0x5W8xFQiutgj/92aOiWwiI7ZZ8O9ePJ6iF1Y/1FdP6SNOSEUIkexeMbtqWUNl2LFs/55CjbD/6Ej8SLLUbMfs5w/SBGD3Xipvt57xOJhNrmXV+4DDWtvWbbIBlbKDejK6C8DpZvpwasxLTCkpPQPHA5UyhmHzocnU+9uriXT4yX11qGIQF3VdshWiDOw+B0WZ+1e3I4UhsSaXUPNYAD9jjrf1qmo3wd/i87brsHAESNluDxACrD2ke2s5n5WmzZALkhD55udnJEfqBqLbAxx3lrvYJisDNc856hwMjsQ3KfJe0/UR3YWi2MUc45GuMtacX159xq0pmDkX6qkCY6VNJKXrLkNcntHaBOiryVw7luTSGhaKbyKzvUzdX577QjnXMOmxr/jZRSBbx7mUC0I07CUKkREwCXQAkxHCTId8wxvUNwACTaP+l6QK7p1drXpo6nfPtxODqFhDMMh2Oiah2LiCj3mrzvD8ov39hYvltlUG5dL7wBuCd0kSBEfq+3K0KAciJuYIU+cElqSn6s1dyEZ5V/c2CUWDO0rX/5IPqK//tTJYRvmEjJ31Nq7CwzErhttNQL73iOn/jaadTt3gexW4gCQ8CtADOMC1H1GuYCjsO+FkRciZx+j1ucANwMx7ojNeq9WHIMz4IqmOiFe9fJ6DiKGaaj64utoV31o2jsWeNVWMktecvBJAabh5UO53VXvlJxAoEBPWa+uQOwgE3CTgk0UI3rzq5xNwcmxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(396003)(346002)(376002)(366004)(36756003)(26005)(110136005)(83380400001)(2616005)(316002)(66476007)(64756008)(86362001)(66446008)(122000001)(31686004)(38100700002)(2906002)(186003)(38070700005)(478600001)(6486002)(6506007)(66556008)(7416002)(6512007)(54906003)(4326008)(76116006)(5660300002)(8676002)(71200400001)(8936002)(66946007)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0xxNlM3MzFiWWJoVGZNUFV0cXp2NXYzRmRDcGZDK1NVeTh6eVRuR0xmWWp6?=
 =?utf-8?B?RXkyOVloVG1IT0txQXIxQlRndHA0YVdxcUJUSk5jdEoySERZWGowWS90SUdY?=
 =?utf-8?B?cDZ6V2owTWdRd2M3aDQ3cWFYckRsN2pqSW9VNkpWWkR3d1JHNmdOMUozeklV?=
 =?utf-8?B?aDA0d3JuODR4cW1JMnNnM2MyRmRxcmlnb3JqTmxObzRGM3EvdVpCb21OSHR6?=
 =?utf-8?B?TlI4U1h6WVRRakdVWFRwUHRmcTJVK1RkRlNUWjNzWVFtNVF4N216OUdpRGN5?=
 =?utf-8?B?SWs2N0N1UUFMZ0dpZ2ttWnpra1NTUEY4c0QzUkxpaEJFb2lCaFc3YkxpajFh?=
 =?utf-8?B?SnhGTG0wNktOL0F0ZW8rcVJGc3ZWT3hJR21kUCtOQXJnYXVPRmZTQ0RBN29R?=
 =?utf-8?B?Qk5pMmtCMEhUcnR2a3g4Nk1oYi8yajFpdmU2ckQ5alBMeXNIQXAyeVFvSHZv?=
 =?utf-8?B?d2I1Y3JrRm1JSEM2M3pSSlU3TnY2RFJVbTlhWUFKVTFPMDhBeTJLTEpudWNp?=
 =?utf-8?B?bGtuYklEd2doSWF1TThDRkdzUk5JdnhZbThmVlBiVlVWejY4eDNTL3p0bkM0?=
 =?utf-8?B?Z2JDYVNTL3NabGE3ZC9aVTFXZW11R043Z2FDRFlsMmcwV2VmVTRSRmlha0JD?=
 =?utf-8?B?MjFDMEhUN0VwU1Z3YmRLdEo1em8xaWlZaTBoSzBIT0tMOHFnYkJiRWFUcW5v?=
 =?utf-8?B?YnJKZXl1Y2lPclRJazJHNmdTRTd5TUFSVzZjYmtPSkwzaFlCZDN3ODgybFpa?=
 =?utf-8?B?S2F4amU3MFFNKzY2bENQNGppdm9ITGZxcU5vRlF6eTVQanYzOFI3YXN6eW1w?=
 =?utf-8?B?RTVQYTJKMGhHRmlVMGxPTTZmQ1ZRTTlheUZpQ0pMeVlBQ3A4NUhsZy9wTlBF?=
 =?utf-8?B?NGNhT0s0SC9KUnl6dFJZQ05YTXBsb25KYU9oZmJMQmhhSXRVdW5YMUkvcDhy?=
 =?utf-8?B?dVJPazRoSGFMSWRYVk1pSUFqaStQYm5LcUF5UnhSS1A1Wkk4ODhnWUNDVzJr?=
 =?utf-8?B?bXlBdThJMmxyRjM3Ri9sR3dUZkZMRm5XUnZZcFdIRnYrSnRKN3A3S2RqQXJV?=
 =?utf-8?B?bXlydjJZTkJsMytRdThXMm5DUCtJMmxuNXR1TFM0bUUyOXVDb09xeS9wOC9E?=
 =?utf-8?B?U0ZXM2krOUVuTzFoUjJtbnJJbndaL1dOTTgyUkw2bStWN3poQU9DWllZMHkz?=
 =?utf-8?B?TTFrM1BjS2JncEVLL3hKU2EwRzVsMFJFZHFuRFRUK1labWNjNXp0aW5pSGNh?=
 =?utf-8?B?WjJOQzdMek1sVWNjemNyNUwva2ljWlB2UDl2YlVmTnFHYnk2MWdwVE1RVlhm?=
 =?utf-8?B?WlRvck81OHVVZzRkTTZ4Q2hXTjZVNnJocXpiQkNrTlZObkozNkxqR3gveURI?=
 =?utf-8?B?eGhBMTFDNmdDZVgydjNMRXhjRE56K0NiSFFkaUxhdG9zc3VzUGdxRVdyVW9j?=
 =?utf-8?B?VU1ocnYrVnZFa1MzNHNJVVJ3QXdzSU5HWm1oMnRUYm0xMGlsRHp1dDcrUkFX?=
 =?utf-8?B?aWpvYkdFWXhtczRUS1BMQkM5dXppVVFXUk9EejQ3YkhtZVJwS3hYNjJ2T3lS?=
 =?utf-8?B?S1dpN3ZQUXVyMkozd1FBZ2Zoc0V4UzJYN2h1ZEI5YUFtVktjbnhtSFZWRFdx?=
 =?utf-8?B?S1I3VVlpZWRVSXh2aHRGbWhQV3JZejJGRitWUWJhaWxnWmtLaUJnQk1Sb1po?=
 =?utf-8?B?dXhiRTB1NHl6a05lakVZMStxMWx1bGUremJERXBHZEorOG1rc0ErekVTOTZR?=
 =?utf-8?Q?qOocQ+ni2sSxFVnQNc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B95D922FB0409C43A5B0F8B119CE1A3B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fdd2ab-7231-4590-9d5d-08d968f4b004
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 00:50:38.3247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Ru3lWykEi7XwdwemcWPJpRxBw7GB2MAMrS06K52E9AkQRhUGcj/lhmrCPB9VPN9bG3Qr7TWmsuV7nDhJIXc/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SmVyb21lIEJydW5ldCB3cm90ZToNCj4gDQo+IE9uIFdlZCAyNSBBdWcgMjAyMSBhdCAyMTo0Miwg
VGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPiB3cm90ZToNCj4gDQo+PiBG
ZXJyeSBUb3RoIHdyb3RlOg0KPj4+IEhpLA0KPj4+DQo+Pj4gT3AgMjUtMDgtMjAyMSBvbSAxMToy
MSBzY2hyZWVmIEplcm9tZSBCcnVuZXQ6DQo+Pj4+IFdoZW4gdGhlIHVhYzIgZnVuY3Rpb24gaXMg
c3RvcHBlZCwgdGhlcmUgc2VlbXMgdG8gYmUgYW4gaXNzdWUgd2l0aCBzb21lDQo+Pj4+IHBsYXRm
b3JtcyAoSW50ZWwgTWVycmlmaWVsZCBhdCBsZWFzdCkNCj4+Pj4NCj4+DQo+PiBUaGUgaXNzdWUg
aXNuJ3QgaGFyZHdhcmUgc3BlY2lmaWMuDQo+IA0KPiBXaGlsZSB0aGUgYWN0dWFsIGJ1ZyBpc250
LCB0aGUgcmVwb3J0IHdhcyAoZ2l2ZW4gdGhlIGlzc3VlIGRpZCBub3Qgc2hvdw0KPiB1cCBkdXJp
bmcgaW5pdGlhbCB0ZXN0aW5nIGJ1dCBkaWQgc2hvdyBvbiBGZXJyeSdzIEhXKQ0KPiBNZXJlbHkg
Y2l0aW5nIHRoZSBidWcgcmVwb3J0IGZyb20gRmVycnkgaGVyZQ0KDQpPaw0KDQo+IA0KPj4NCj4+
Pj4gQlVHOiBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAw
MDAwMDAwMDA4DQo+Pj4+IC4uLg0KPj4+PiBSSVA6IDAwMTA6ZHdjM19nYWRnZXRfZGVsX2FuZF91
bm1hcF9yZXF1ZXN0KzB4MTkvMHhlMA0KPj4+PiAuLi4NCj4+Pj4gQ2FsbCBUcmFjZToNCj4+Pj4g
wqAgZHdjM19yZW1vdmVfcmVxdWVzdHMuY29uc3Rwcm9wLjArMHgxMmYvMHgxNzANCj4+Pj4gwqAg
X19kd2MzX2dhZGdldF9lcF9kaXNhYmxlKzB4N2EvMHgxNjANCj4+Pj4gwqAgZHdjM19nYWRnZXRf
ZXBfZGlzYWJsZSsweDNkLzB4ZDANCj4+Pj4gwqAgdXNiX2VwX2Rpc2FibGUrMHgxYy8weDcwDQo+
Pj4+IMKgIHVfYXVkaW9fc3RvcF9jYXB0dXJlKzB4NzkvMHgxMjAgW3VfYXVkaW9dDQo+Pj4+IMKg
IGFmdW5jX3NldF9hbHQrMHg3My8weDgwIFt1c2JfZl91YWMyXQ0KPj4+PiDCoCBjb21wb3NpdGVf
c2V0dXArMHgyMjQvMHgxYjkwIFtsaWJjb21wb3NpdGVdDQo+Pj4+DQo+Pj4+IFRoZSBpc3N1ZSBo
YXBwZW5zIG9ubHkgd2hlbiB0aGUgZ2FkZ2V0IGlzIHVzaW5nIHRoZSBzeW5jIHR5cGUgImFzeW5j
IiwNCj4+Pj4gbm90DQo+Pj4+ICJhZGFwdGl2ZSIuIFRoaXMgaW5kaWNhdGVzIHRoYXQgcHJvYmxl
bSBpcyBsaWtlbHkgY29taW5nIGZyb20gdGhlDQo+Pj4+IGZlZWRiYWNrDQo+Pj4+IGVuZHBvaW50
LCB3aGljaCBpcyBvbmx5IHVzZWQgd2l0aCBhc3luYyBzeW5jaHJvbml6YXRpb24gbW9kZS4NCj4+
DQo+PiBUaGlzIGRvZXMgbm90IGRlc2NyaWJlIHRoZSBhY3R1YWwgcHJvYmxlbS4gVGhlIHByb2Js
ZW0gaXMgdGhhdCB0aGUNCj4+IHVzYl9lcF9kZXF1ZXVlKCkgY2FuIGJlIGFuIGFzeW5jaHJvbm91
cyBjYWxsLCBhbmQgd2UgY2FuJ3QgZnJlZSB0aGUNCj4+IHJlcXVlc3QgdW50aWwgaXRzIGNvbXBs
ZXRpb24gKGZyb20gY2FuY2VsbGF0aW9uKS4NCj4gDQo+IEluZGVlZC4gSSB3YXMgbm90IHN1cmUg
YXQgdGhlIHRpbWUuDQo+IA0KPj4NCj4+Pj4NCj4+Pj4gVXBkYXRlIHRoZSBmZWVkYmFjayBlbmRw
b2ludCBmcmVlIGZ1bmN0aW9uIHRvIHJlbGVhc2UgdGhlIGVuZHBvaW50IHRoZQ0KPj4+PiBzYW1l
DQo+Pj4+IHdheSBpdCBpcyBkb25lIGZvciB0aGUgZGF0YSBlbmRwb2ludC4NCj4+Pj4NCj4+Pj4g
U2lnbmVkLW9mZi1ieTogSmVyb21lIEJydW5ldCA8amJydW5ldEBiYXlsaWJyZS5jb20+DQo+Pj4+
IC0tLQ0KPj4+Pg0KPj4+PiDCoCBIaSBGZXJyeSwNCj4+Pj4NCj4+Pj4gwqAgV291bGQgeW91IG1p
bmQgdHJ5aW5nIHRoaXMgYmVmb3JlIHJldmVydGluZyB0aGUgd2hvbGUgdGhpbmcgPw0KPj4+PiDC
oCBUaGUgSFcgSSBoYXZlIGRpZCBub3Qgc2hvdyB0aGUgaXNzdWUgc28gZmFyIHNvIEkgY2FuJ3Qg
cmVhbGx5IGNoZWNrDQo+Pj4+IMKgIGlmIGl0IGhlbHBzLiBIb3BlZnVsbHksIGl0IGRvZXMgLi4u
DQo+Pj4NCj4+PiBUZXN0ZWQgdGhpcyBldmVuaW5nIGFuZCBjb25maXJtaW5nIHRoYXQgdGhpcyBy
ZXNvbHZlcyBteSBpc3N1ZS4gSSBjYW4ndA0KPj4+IHNheSBtdWNoIGFib3V0IHRoZSBjb2RlIGl0
c2VsZiwgbWF5YmUgVGhpbmg/DQo+Pg0KPj4gU3VyZS4gSSBjYW4gdGFrZSBhIGxvb2suDQo+Pg0K
Pj4+DQo+Pj4gV291bGQgYmUgZ3JlYXQgaWYgd2UgY291bGQgZ2V0IHRoaXMgaW4gaW5zdGVhZCBv
ZiByZXZlcnRpbmcgdGhlIHNlcmllcy4NCj4+Pg0KPj4+IFRlc3RlZC1ieTrCoCBGZXJyeSBUb3Ro
IDxmdG90aEBleGFsb25kZWxmdC5ubD4gKGR3YzMgLyBJbnRlbCBNZXJyaWZpZWxkKQ0KPj4+DQo+
Pj4+IMKgIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X2F1ZGlvLmMgfCAxNSArKysrKysr
KysrKy0tLS0NCj4+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVu
Y3Rpb24vdV9hdWRpby5jDQo+Pj4+IGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3VfYXVk
aW8uYw0KPj4+PiBpbmRleCAwMThkZDA5Nzg5OTUuLjYzZDkzNDBmMDA4ZSAxMDA2NDQNCj4+Pj4g
LS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3VfYXVkaW8uYw0KPj4+PiArKysgYi9k
cml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9hdWRpby5jDQo+Pj4+IEBAIC0yMzAsNyArMjMw
LDEzIEBAIHN0YXRpYyB2b2lkIHVfYXVkaW9faXNvX2ZiYWNrX2NvbXBsZXRlKHN0cnVjdA0KPj4+
PiB1c2JfZXAgKmVwLA0KPj4+PiDCoMKgwqDCoMKgIGludCBzdGF0dXMgPSByZXEtPnN0YXR1czsN
Cj4+Pj4gwqAgwqDCoMKgwqDCoCAvKiBpL2Ygc2h1dHRpbmcgZG93biAqLw0KPj4+PiAtwqDCoMKg
IGlmICghcHJtLT5mYl9lcF9lbmFibGVkIHx8IHJlcS0+c3RhdHVzID09IC1FU0hVVERPV04pDQo+
Pj4+ICvCoMKgwqAgaWYgKCFwcm0tPmZiX2VwX2VuYWJsZWQpIHsNCj4+DQo+PiBwcm0tPmZiX2Vw
X2VuYWJsZWQgaXMgbm90IHByb3RlY3RlZC4gUG90ZW50aWFsIHJhY2UgcHJvYmxlbSBoZXJlPw0K
PiANCj4gR2l2ZW4gaG93IHRoZSB2YXJpYWJsZSBpcyB1c2VkLCBJIGRvbid0IHRoaW5rIHNvLg0K
PiBDb3VsZCB5b3UgcGxlYXNlIGRldGFpbCA/DQo+IA0KDQpJJ20gdGhpbmtpbmcgb2YgdGhpcyBz
Y2VuYXJpbzoNCg0KU2luY2UgZnJlZV9lcF9mYmFjaygpIGlzIGNhbGxlZCBpbiBhIHNlcGFyYXRl
IHRocmVhZCwNCnVfYXVkaW9faXNvX2ZiYWNrX2NvbXBsZXRlKCkgY2FuIGNvbWUgaW4gdGhlIG1p
ZGRsZSBhZnRlcg0KcHJtLT5mYl9lcF9lbmFibGVkIGlzIGNsZWFyZWQgYnV0IGJlZm9yZSB0aGUg
dXNiX2VwX2RlcXVldWUoKS4gU28gdGhlDQpyZXF1ZXN0IG1heSBiZSBmcmVlZCBiZWZvcmUgYmVp
bmcgYWNjZXNzZWQgYWdhaW4gaW4gdXNiX2VwX2RlcXVldWUoKS4NCg0KPiAoSSBkb24ndCB0aGlu
ayB0aGlzIGlzIHJlYWxseSByZWxhdGVkIHRvIHRoZSBjdXJyZW50IHByb2JsZW0gdGhvdWdoKQ0K
DQpJdCdzIHJlbGF0ZWQgdG8gaG93IHdlIGdvIGFib3V0IHRvIHNvbHZlIHRoZSBwcm9ibGVtIHJp
Z2h0Pw0KDQpDYW4gd2UganVzdCBjaGVjayBmb3IgdGhlIHJlcS0+c3RhdHVzIGZvciAtRUNPTk5S
RVNFVCBhbmQgLUVTSFVURE9XTiBhbmQNCmZyZWUgdGhlIHJlcXVlc3Q/IFRob3NlIDIgc3RhdHVz
ZXMgc2hvdWxkIGJlIGZvciB3aGVuIHRoZSByZXF1ZXN0IGlzDQpjYW5jZWxsZWQgYW5kIHdoZW4g
dGhlIGVuZHBvaW50IGlzIGRpc2FibGVkLg0KDQo+IA0KPj4NCj4+Pj4gK8KgwqDCoMKgwqDCoMKg
IGtmcmVlKHJlcS0+YnVmKTsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHVzYl9lcF9mcmVlX3JlcXVl
c3QoZXAsIHJlcSk7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+Pj4+ICvCoMKgwqAg
fQ0KPj4+PiArDQo+Pj4+ICvCoMKgwqAgaWYgKHJlcS0+c3RhdHVzID09IC1FU0hVVERPV04pDQo+
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+Pj4+IMKgIMKgwqDCoMKgwqAgLyoNCj4+
Pj4gQEAgLTQyMSw5ICs0MjcsMTAgQEAgc3RhdGljIGlubGluZSB2b2lkIGZyZWVfZXBfZmJhY2so
c3RydWN0DQo+Pj4+IHVhY19ydGRfcGFyYW1zICpwcm0sIHN0cnVjdCB1c2JfZXAgKmVwKQ0KPj4+
PiDCoMKgwqDCoMKgIHBybS0+ZmJfZXBfZW5hYmxlZCA9IGZhbHNlOw0KPj4+PiDCoCDCoMKgwqDC
oMKgIGlmIChwcm0tPnJlcV9mYmFjaykgew0KPj4+PiAtwqDCoMKgwqDCoMKgwqAgdXNiX2VwX2Rl
cXVldWUoZXAsIHBybS0+cmVxX2ZiYWNrKTsNCj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGtmcmVlKHBy
bS0+cmVxX2ZiYWNrLT5idWYpOw0KPj4+PiAtwqDCoMKgwqDCoMKgwqAgdXNiX2VwX2ZyZWVfcmVx
dWVzdChlcCwgcHJtLT5yZXFfZmJhY2spOw0KPj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHVzYl9l
cF9kZXF1ZXVlKGVwLCBwcm0tPnJlcV9mYmFjaykpIHsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAga2ZyZWUocHJtLT5yZXFfZmJhY2stPmJ1Zik7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHVzYl9lcF9mcmVlX3JlcXVlc3QoZXAsIHBybS0+cmVxX2ZiYWNrKTsNCj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgIH0NCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHBybS0+cmVxX2ZiYWNrID0g
TlVMTDsNCj4+Pj4gwqDCoMKgwqDCoCB9DQo+Pj4+IMKgIA0KPj4NCj4+IE9uIGEgc2VwYXJhdGUg
bm90ZSwgSSBub3RpY2UgdGhhdCBmX3VhYzIgb25seSBxdWV1ZXMgYSBzaW5nbGUgZmVlZGJhY2sN
Cj4+IHJlcXVlc3QgYXQgYSB0aW1lIGZvciBpc29jIGVuZHBvaW50PyBFdmVuIHRob3VnaCB0aGUg
aW50ZXJ2YWwgaXMgMW1zLA0KPj4gdGhpcyB3aWxsIGVhc2lseSBjYXVzZSBkYXRhIGRyb3AuDQo+
Pg0KPj4gQWxzbywgeW91J3JlIGlnbm9yaW5nIG90aGVyIHJlcXVlc3QgZXJyb3Igc3RhdHVzIGFu
ZCBzdGlsbCBwcm9jZXNzaW5nDQo+PiBib2d1cyBkYXRhIG9uIHJlcXVlc3QgY29tcGxldGlvbj8g
VGhhdCBkb2Vzbid0IHNlZW0gcmlnaHQuDQo+IA0KPiBHYWRnZXQgaXMgc2VuZGluZCB0aGUgZmVl
ZGJhY2sgZGF0YSwgbm90IHByb2Nlc3NpbmcgaXQuIEV2ZXJ5IGRhdGEgc2VudA0KDQpBaCBvay4u
IEkgbWlzc2VkIHRoYXQgaXQncyBJTiByZXF1ZXN0Lg0KDQo+IGlzIE9LLiAgWWVzLCBwYWNrZXRz
IGNhbiBiZSBtaXNzZWQgd2l0aCB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiwNCj4gbWVhbmlu
ZyB0aGUgZmVlZGJhY2sgdmFsdWUgaXMgbm90IHJlcG9ydGVkIGFzIG9mdGVuIGFzIGluaXRpYWxs
eQ0KPiBpbnRlbmRlZC4gT24gc2xvd2VyIEhXLCBwYWNrZXRzIGFyZSBhbHNvIG1pc3NlZCB3aXRo
IDIgcmVxdWVzdHMgcXVldWVkLA0KDQoyIGlzIHN0aWxsIHRvbyBsb3cuIEZyb20gb3VyIEhXIHRl
c3RpbmcsIG1pbmltdW0gc2hvdWxkIGJlIDQgdG8gbWluaW1pemUNCmRhdGEgbG9zcyBhdCAxbXMg
aW50ZXJ2YWwuDQoNCj4gbm90IG9ubHkgb24gdGhlIGZlZWRiYWNrIGVuZHBvaW50IGJ1dCBhbHNv
IG9uIHRoZSBwbGF5YmFjaw0KPiBlbmRwb2ludC4gUGlja2luZyB0aGUgYXBwcm9yaWF0ZSB2YWx1
ZSBpcyBub3Qgc3RyYWlnaHQgZm9yd2FyZC4gRm9yIHRoZQ0KPiBmZWVkYmFjayBlbmRwb2ludCBp
dCBpc24ndCBiaWcgZGVhbCBiZWNhdXNlLCBhY2NvcmRpbmcgdG8gdGhlIHNwZWMsIGlmDQo+IHRo
ZSBmZWVkYmFjayBpcyBub3Qgc2VudCwgdGhlIGhvc3Qgc2hhbGwgYXNzdW1lIHRoZSB2YWx1ZSBo
YXNuJ3QNCj4gY2hhbmdlZC4gVGhpcyB3aHkgdGhlIHdob2xlIHRoaW5nIHdvcmtzIGFzIGl0IGlz
Lg0KDQpXaHkgZG8gdGhpcyB3aGVuIHdlIGNhbiBhdm9pZCBpdC4gV2Uga25vdyB0aGF0IHRoZXJl
IHdpbGwgYmUgZGF0YSBkcm9wDQp3aXRoIHRoZSB3YXkgaXQncyBpbXBsZW1lbnRlZCBub3cuIFRo
ZXJlJ3Mgbm8gb3B0aW9uIHRvIGFkanVzdCB0aGUNCm51bWJlciBvZiBmZWVkYmFjayByZXF1ZXN0
cyBlaXRoZXIuDQoNCj4gDQo+IEkgYWRtaXQgdGhpbmdzIHN0aWxsIGFyZW4ndCBwZXJmZWN0LCBi
dXQgdGhlcmUgaXMgcHJvZ3Jlc3MgLi4uDQo+IA0KVGhhbmtzIGZvciB0aGUgdXBkYXRlcyB0byBh
dWRpby9mX3VhYzIuIEl0J3MgYmVlbiBhIGxvbmcgdGltZSBzaW5jZQ0KYW55b25lIHdvcmtpbmcg
b24gaXQuDQoNCkJSLA0KVGhpbmgNCg==
