Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FAE43DC38
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 09:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhJ1Hit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 03:38:49 -0400
Received: from mail-vi1eur05on2074.outbound.protection.outlook.com ([40.107.21.74]:57440
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229771AbhJ1Hip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 03:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lkavb0wIWz8gU3geBV7Vr6y1UHJ86y1FanilbuRorw=;
 b=Q2fiYSi1ZiE5jgmtb24+C8+5oPexqDw0eLsB2IU1W1TSmu2OErYjHsi8eco+hNvgOPxiSm/dWpRHPdO55h2CmpDNAHD6LDAAjhUrZ01/eUrXkd3HhsXhrisRWJN/yguliV18dyoLj4l82HOshTLee0xKzoA8w45OZdoaW5mccBc=
Received: from AM6PR04CA0050.eurprd04.prod.outlook.com (2603:10a6:20b:f0::27)
 by AM0PR08MB3460.eurprd08.prod.outlook.com (2603:10a6:208:de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Thu, 28 Oct
 2021 07:36:16 +0000
Received: from VE1EUR03FT017.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:f0:cafe::20) by AM6PR04CA0050.outlook.office365.com
 (2603:10a6:20b:f0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Thu, 28 Oct 2021 07:36:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT017.mail.protection.outlook.com (10.152.18.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 07:36:16 +0000
Received: ("Tessian outbound e27daf245730:v103"); Thu, 28 Oct 2021 07:36:15 +0000
X-CR-MTA-TID: 64aa7808
Received: from fb5d250b7723.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 439806C2-45AB-459F-BAA7-96DC42BD20B8.1;
        Thu, 28 Oct 2021 07:36:10 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fb5d250b7723.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 28 Oct 2021 07:36:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npks09r4FGa+XmVSXT5zkVrGL6B3G0yrTv3wefvjFg4TZjBus55ZoqfgEgrO4lXgoVbgSK9CNl0LMSScmEDtNo/37S3M65QVuQX/+nfGcyci8Xc7HhrJwQZvH/SRsst6ZQXW+QLGfJ2m/M3tNUEmRECOk5HG2X6wzyq35WYycyW33zxvFGzrs2r4kQqNpilOTufQJr8D4hAElevGRgDpBKiwM20ugTkRWd7FIsMTLuF4PuFwK96XS9CKfRqLvn9QRyPkECvjvp6Q0ie13tDupo0wHofB83HltgY6ilk9yO1pQIqCRjqbbhAad3G4whzipiPPusQhURdWGDaEwJF9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lkavb0wIWz8gU3geBV7Vr6y1UHJ86y1FanilbuRorw=;
 b=E7R+UHiiPS3kGtZ6kzKNjthvOmFZGW0Kplj5hBnSDqb6L6mWdrQY7JrF2QYUoGWO3ByjUoFqdsodQafuybPGLFBiOezCE7C/vC6RjuywM/1fSiYYu4Of30mVfmoIFnqK/04mFSmyRoYnQaCxGfPY1GmDEFsk4W9p0BhP93DpQgvgYGTZv5Z3hTAemuZZi8lrboj4duPYRae9MDzScvz94EBzuf8g/57IkNhS/NbD8VjdE5ATcDsOZ3eZoxKSWXclZZpMbltE6EJS0oPQp4JOquknEE0dMdq6Zb1CU2vCksMIzC91TppMnYWeCH2r03JP/EW7x6AJhupN/f+WpwDRgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lkavb0wIWz8gU3geBV7Vr6y1UHJ86y1FanilbuRorw=;
 b=Q2fiYSi1ZiE5jgmtb24+C8+5oPexqDw0eLsB2IU1W1TSmu2OErYjHsi8eco+hNvgOPxiSm/dWpRHPdO55h2CmpDNAHD6LDAAjhUrZ01/eUrXkd3HhsXhrisRWJN/yguliV18dyoLj4l82HOshTLee0xKzoA8w45OZdoaW5mccBc=
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com (2603:10a6:20b:437::11)
 by AM9PR08MB7152.eurprd08.prod.outlook.com (2603:10a6:20b:3dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 28 Oct
 2021 07:36:08 +0000
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::9032:349b:1fd4:fabe]) by AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::9032:349b:1fd4:fabe%3]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 07:36:07 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     Anshuman Khandual <Anshuman.Khandual@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "david@redhat.com" <david@redhat.com>,
        "gshan@redhat.com" <gshan@redhat.com>,
        Justin He <Justin.He@arm.com>, nd <nd@arm.com>
Subject: RE: [PATCH v1] arm64/mm: avoid race condition of update page table
 when kernel init
Thread-Topic: [PATCH v1] arm64/mm: avoid race condition of update page table
 when kernel init
Thread-Index: AQHXyxfjckbZs45/jUaWUxeL4pEnmavn60UAgAAWg/A=
Date:   Thu, 28 Oct 2021 07:36:07 +0000
Message-ID: <AM9PR08MB72767A6DFA5A7ED8117E7C44F4869@AM9PR08MB7276.eurprd08.prod.outlook.com>
References: <20211027094828.7629-1-jianyong.wu@arm.com>
 <1cd8e875-24b1-2904-4e9f-2a4eb13674dc@arm.com>
In-Reply-To: <1cd8e875-24b1-2904-4e9f-2a4eb13674dc@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 13EA82099311664CB35FE159147DA915.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 3fc8e0c3-8fd1-4a5a-6935-08d999e5a031
x-ms-traffictypediagnostic: AM9PR08MB7152:|AM0PR08MB3460:
X-Microsoft-Antispam-PRVS: <AM0PR08MB3460457E0A1694A147D6CBACF4869@AM0PR08MB3460.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: JufGJ7xW6Ozicu2IE8IhdpLWiVklco5bIJQRWu0phejkQnvjn8JJjzTODFVQvIyWbfXqboZmzL9J5bp8u3vaYfJfY9DJSBS2hPBtbUH8Oh0ugEB4NAkqJf/gjGlj2X8yIjW7cEOC+Tqm7M+purlE/zl1eaqVlPD8ai1qhma9olbakDOL2QXTjTJh3XGJi0TAY/N9R5gRrZqFkp8ZRUA54yypIVhk6mkaW94qrSvVwY0uc0mtyVmSFW7gM04jMYIB/qjOsy/riWbsdlXhKDWKKx/havXzmYNflq/2nMR5dwMvMpKThUosiUKJsLUvWHArFWAfijNU5gSINFrTS7CKZJkd66LB3uvi2/nmCtXaBBQHszenA1mTb0ANpBXOS8f9UtMLryWcDQme0J9wyDShOPDRfaEHHLowuUXG4XwLrfB/1RKZSFZQcepi8d/ZQDDFPhRzX6bQiTnL85C77uuancysxORzBzfQXG7nviYc8uvRgv0et+vQiLhhnADl3VUDX/EHlxKI5dB16+FPId080EuUg+TNRAa1G9lRTSPsHw6x5OWQNgfXjCOijRuS5Ljl6umGbaW7SN5Mo2vPeHUyl41mPGGUDHg2Y3EzjHRX5XEKe6r+PpgstRVBH9YraX3Bvodz9lVmLh2K6Ltnkxz0H3phUNyu5aQnl+lGtbCimYYW60CT500ochHPq0ils6Y0eE/pw1Kk2w19exRbRDbPfw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7276.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(7696005)(53546011)(110136005)(316002)(54906003)(508600001)(66446008)(64756008)(15650500001)(5660300002)(9686003)(55016002)(71200400001)(52536014)(83380400001)(8676002)(8936002)(186003)(26005)(4326008)(76116006)(66556008)(38070700005)(33656002)(38100700002)(122000001)(2906002)(66946007)(66476007)(86362001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB7152
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 79948d81-5101-4a47-6523-08d999e59b15
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cABNvFwNcLr5nUjJ9tRE/2qJT0WnHkCisyfs2U1O7xKM+npqNzDNIR+9LHOau1v2BouyOpSZpul275VXGN7QUUmVTHeSwIbN+TmQr7/oJYxVwwA5Gt2CGWPsY9Z8vcBeBx0lZ0p5e9XIKg2UwP6Fw1fWl0EFU7PT11iP/4KFuoVR0Ge2I4h8DwD0aJXo4sZlWCK/tEvipO5nC1khBMSVUdq2ME5mJ/vo2RfhkR3fJJyuGZqRc+/yere9EJjAuX0Zj6JxiTw62zuOZ1FYlV+hQpZ1mACHeGKy28SvDMoVBY19ljp7SPdx8PrNFdVA8ia526bXOiOma9HTCCFjMk+lCWgKMsCl3EQ2jtYQgR9BQxWHhL1Y2X+XDt/Pw1cW3gCALj8jenLs0Pxyjk1/4qK5/1qtvR0UtTKBT5TsCLhaYbuswK8T7YC3x76s8Hs82NtjAVSx2yUFe68la3SZLq8r4/jiVhhOQtjn21VuiXcDoDIUo2wHxnHXPQsILuJq9h803jy2kC25U663JSX7hy/zf984HRq+qXIGKM6tnJ8OI8oahZ+C+ssA4lpoH9zLeBzfl1DqhGJ3iDRYt67gcc+698vPP/lsYIktpLVr8+e7gbvmCEAAL0wB57y7m8iCqZcSnkIOEcfRHGjUJuw2UQCqvGjjjRpeun3fDVfOTJz6mOg/nf8Kir9+/jnCN/SZtzt31toblCdNcr6vmQpy45QgOA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(2906002)(70206006)(47076005)(83380400001)(316002)(4326008)(70586007)(356005)(54906003)(110136005)(9686003)(508600001)(52536014)(186003)(26005)(86362001)(33656002)(8676002)(36860700001)(336012)(8936002)(7696005)(55016002)(82310400003)(5660300002)(6506007)(53546011)(81166007)(15650500001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 07:36:16.2429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc8e0c3-8fd1-4a5a-6935-08d999e5a031
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3460
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5zaHVtYW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5z
aHVtYW4gS2hhbmR1YWwgPGFuc2h1bWFuLmtoYW5kdWFsQGFybS5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBPY3RvYmVyIDI4LCAyMDIxIDE6NTggUE0NCj4gVG86IEppYW55b25nIFd1IDxKaWFueW9u
Zy5XdUBhcm0uY29tPjsgQ2F0YWxpbiBNYXJpbmFzDQo+IDxDYXRhbGluLk1hcmluYXNAYXJtLmNv
bT47IHdpbGxAa2VybmVsLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBtYXpAa2VybmVsLm9yZzsg
YXJkYkBrZXJuZWwub3JnOyBkYXZpZEByZWRoYXQuY29tOyBnc2hhbkByZWRoYXQuY29tOw0KPiBK
dXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPjsgbmQgPG5kQGFybS5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjFdIGFybTY0L21tOiBhdm9pZCByYWNlIGNvbmRpdGlvbiBvZiB1cGRhdGUg
cGFnZQ0KPiB0YWJsZSB3aGVuIGtlcm5lbCBpbml0DQo+IA0KPiANCj4gDQo+IE9uIDEwLzI3LzIx
IDM6MTggUE0sIEppYW55b25nIFd1IHdyb3RlOg0KPiA+IFJhY2UgY29uZGl0aW9uIG9mIHBhZ2Ug
dGFibGUgdXBkYXRlIGNhbiBoYXBwZW4gaW4ga2VybmVsIGJvb3QgcGVyaW9kDQo+ID4gYXMgYm90
aCBvZiBtZW1vcnkgaG90cGx1ZyBhY3Rpb24gd2hlbiBrZXJuZWwgaW5pdCBhbmQgdGhlDQo+ID4g
bWFya19yb2RhdGFfcm8gY2FuIHVwZGF0ZSBwYWdlIHRhYmxlLiBGb3IgdmlydGlvLW1lbSwgdGhl
IGZ1bmN0aW9uDQo+IGV4Y3V0ZSBmbG93IGNoYXJ0IGlzOg0KPiA+DQo+ID4gLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiA+IGtlcm5lbF9pbml0DQo+ID4gICBrZXJuZWxfaW5pdF9mcmVlYWJs
ZQ0KPiA+ICAgICAuLi4NCj4gPiAgICAgICBkb19pbml0Y2FsbA0KPiA+ICAgICAgICAgLi4uDQo+
ID4gICAgICAgICAgIG1vZHVsZV9pbml0IFtBXQ0KPiA+DQo+ID4gICAuLi4NCj4gPiAgIG1hcmtf
cmVhZG9ubHkNCj4gPiAgICAgbWFya19yb2RhdGFfcm8gW0JdDQo+ID4gLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiA+IHZpcnRpby1tZW0gY2FuIGJlIGluaXRpYWxpemVkIGF0IFtBXSBhbmQg
c3B3YW4gYSB3b3JrcXVldWUgdG8gYWRkDQo+ID4gbWVtb3J5LCB0aGVyZWZvcmUgdGhlIHJhY2Ug
b2YgdXBkYXRlIHBhZ2UgdGFibGUgY2FuIGhhcHBlbiBpbnNpZGUgW0JdLg0KPiA+DQo+ID4gV2hh
dCdzIG1vcmUsIHRoZSByYWNlIGNvbmRpdGlvbiBjYW4gaGFwcGVuIGV2ZW4gZm9yIEFDUEkgYmFz
ZWQgbWVtb3J5DQo+ID4gaG90cGx1ZywgYXMgaXQgY2FuIGJ1cnN0IGludG8ga2VybmVsIGJvb3Qg
cGVyaW9kIHdoaWxlIHBhZ2UgdGFibGUgaXMNCj4gPiB1cGRhdGluZyBpbnNpZGUgbWFya19yb2Rh
dGFfcm8uDQo+ID4NCj4gPiBUaGF0J3Mgd2h5IG1lbW9yeSBob3RwbHVnIGxvY2sgaXMgbmVlZGVk
IHRvIGd1YXJkIG1hcmtfcm9kYXRhX3JvIHRvDQo+ID4gYXZvaWQgdGhlIHJhY2UgY29uZGl0aW9u
Lg0KPiA+DQo+ID4gSXQgbWF5IG9ubHkgaGFwcGVuIGluIGFybTY0LiBBcyBmaXhtYXAsIHdoaWNo
IGlzIHRoZSBnbG9iYWwgcmVzb3VyY2UsDQo+ID4gaXMgdXNlZCBpbiBwYWdlIHRhYmxlIGNyZWF0
aW5nLiBTbywgdGhlIGNoYW5nZSBpcyBvbmx5IGZvciBhcm02NC4NCj4gPg0KPiA+IFRoZSBlcnJv
ciBvZnRlbiBvY2N1cnMgaW5zaWRlIGFsbG9jX2luaXRfcHVkKCkgaW4gYXJjaC9hcm02NC9tbS9t
bXUuYw0KPiA+DQo+ID4gdGhlIHJhY2UgY29uZGl0aW9uIGZsb3cgaXM6DQo+ID4NCj4gPiAqKioq
KioqKioqKioqKiogYmVnaW4gKioqKioqKioqKioqDQo+ID4NCj4gPiBrZXJlbmxfaW5pdCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZpcnRpby1tZW0gd29ya3F1ZXVlDQo+ID4gPT09
PT09PT09ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9PT09PT09PQ0KPiA+IGFs
bG9jX2luaXRfcHVkKC4uLikNCj4gPiAgIHB1ZHAgPSBwdWRfc2V0X2ZpeG1hcF9vZmZzZXQoLi4p
ICAgICAgICAgIGFsbG9jX2luaXRfcHVkKC4uLikNCj4gPiAuLi4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIC4uLg0KPiA+ICAgICBSRUFEX09OQ0UoKnB1ZHApIC8vT0sh
ICAgICAgICAgICAgICAgICAgICBwdWRwID0gcHVkX3NldF9maXhtYXBfb2Zmc2V0KA0KPiA+IC4u
LiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLi4uDQo+ID4gICBwdWRf
Y2xlYXJfZml4bWFwKCkgLy9maXhtYXAgYnJlYWsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgUkVBRF9PTkNFKCpwdWRwKSAvL0NSQVNIIQ0KPiA+DQo+
ID4gKioqKioqKioqKioqKioqKiBlbmQgKioqKioqKioqKioqKg0KPiA+DQo+ID4gSSBjYXRjaCB0
aGUgcmVsYXRlZCBlcnJvciB3aGVuIHRlc3QgdmlydGlvLW1lbSAoYSBuZXcgbWVtb3J5IGhvdHBs
dWcNCj4gPiBkcml2ZXIpIG9uIGFybTY0Lg0KPiA+DQo+ID4gSG93IHRvIHJlcHJvZHVjZToNCj4g
PiAoMSkgcHJlcGFyZSBhIGtlcm5lbCB3aXRoIHZpcnRpby1tZW0gZW5hYmxlZCBvbiBhcm02NA0K
PiA+ICgyKSBzdGFydCBhIFZNIHVzaW5nIENsb3VkIEh5cGVydmlzb3IgdXNpbmcgdGhlIGtlcm5l
bCBhYm92ZQ0KPiA+ICgzKSBob3RwbHVnIG1lbW9yeSwgMjBHIGluIG15IGNhc2UsIHdpdGggdmly
dGlvLW1lbQ0KPiA+ICg0KSByZWJvb3Qgb3Igc3RhcnQgYSBuZXcga2VybmVsIHVzaW5nIGtleGVj
DQo+ID4NCj4gPiBUZXN0IGZvciBzZXJ2ZXIgdGltZXMsIHlvdSBtYXkgZmluZCB0aGUgZXJyb3Ig
YmVsb3c6DQo+ID4NCj4gPiBbICAgIDEuMTMxMDM5XSBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBw
YWdpbmcgcmVxdWVzdCBhdCB2aXJ0dWFsIGFkZHJlc3MNCj4gZmZmZmZiZmZmZGEzYjE0MA0KPiA+
IFsgICAgMS4xMzQ1MDRdIE1lbSBhYm9ydCBpbmZvOg0KPiA+IFsgICAgMS4xMzU3MjJdICAgRVNS
ID0gMHg5NjAwMDAwNw0KPiA+IFsgICAgMS4xMzY5OTFdICAgRUMgPSAweDI1OiBEQUJUIChjdXJy
ZW50IEVMKSwgSUwgPSAzMiBiaXRzDQo+ID4gWyAgICAxLjEzOTE4OV0gICBTRVQgPSAwLCBGblYg
PSAwDQo+ID4gWyAgICAxLjE0MDQ2N10gICBFQSA9IDAsIFMxUFRXID0gMA0KPiA+IFsgICAgMS4x
NDE3NTVdICAgRlNDID0gMHgwNzogbGV2ZWwgMyB0cmFuc2xhdGlvbiBmYXVsdA0KPiA+IFsgICAg
MS4xNDM3ODddIERhdGEgYWJvcnQgaW5mbzoNCj4gPiBbICAgIDEuMTQ0OTc2XSAgIElTViA9IDAs
IElTUyA9IDB4MDAwMDAwMDcNCj4gPiBbICAgIDEuMTQ2NTU0XSAgIENNID0gMCwgV25SID0gMA0K
PiA+IFsgICAgMS4xNDc4MTddIHN3YXBwZXIgcGd0YWJsZTogNGsgcGFnZXMsIDQ4LWJpdCBWQXMs
DQo+IHBnZHA9MDAwMDAwMDA0MjZmMjAwMA0KPiA+IFsgICAgMS4xNTA1NTFdIFtmZmZmZmJmZmZk
YTNiMTQwXSBwZ2Q9MDAwMDAwMDA0MmZmZDAwMywNCj4gcDRkPTAwMDAwMDAwNDJmZmQwMDMsIHB1
ZD0wMDAwMDAwMDQyZmZlMDAzLCBwbWQ9MDAwMDAwMDA0MmZmZjAwMywNCj4gcHRlPTAwMDAwMDAw
MDAwMDAwMDANCj4gPiBbICAgIDEuMTU1NzI4XSBJbnRlcm5hbCBlcnJvcjogT29wczogOTYwMDAw
MDcgWyMxXSBTTVANCj4gPiBbICAgIDEuMTU3NzI0XSBDUFU6IDAgUElEOiAxIENvbW06IHN3YXBw
ZXIvMCBUYWludGVkOiBHICAgICAgICAgQyAgICAgICAgNS4xNS4wLQ0KPiByYzMrICMxMDANCj4g
PiBbICAgIDEuMTYxMDAyXSBIYXJkd2FyZSBuYW1lOiBsaW51eCxkdW1teS12aXJ0IChEVCkNCj4g
PiBbICAgIDEuMTYyOTM5XSBwc3RhdGU6IDYwNDAwMDA1IChuWkN2IGRhaWYgK1BBTiAtVUFPIC1U
Q08gLURJVCAtU1NCUw0KPiBCVFlQRT0tLSkNCj4gPiBbICAgIDEuMTY1ODI1XSBwYyA6IGFsbG9j
X2luaXRfcHVkKzB4MzhjLzB4NTUwDQo+ID4gWyAgICAxLjE2NzYxMF0gbHIgOiBhbGxvY19pbml0
X3B1ZCsweDM5NC8weDU1MA0KPiA+IFsgICAgMS4xNjkzNThdIHNwIDogZmZmZjgwMDAxMDAxYmQx
MA0KPiA+IC4uLi4uLg0KPiA+IFsgICAgMS4yMDA1MjddIENhbGwgdHJhY2U6DQo+ID4gWyAgICAx
LjIwMTU4M10gIGFsbG9jX2luaXRfcHVkKzB4MzhjLzB4NTUwDQo+ID4gWyAgICAxLjIwMzIxOF0g
IF9fY3JlYXRlX3BnZF9tYXBwaW5nKzB4OTQvMHhlMA0KPiA+IFsgICAgMS4yMDQ5ODNdICB1cGRh
dGVfbWFwcGluZ19wcm90KzB4NTAvMHhkOA0KPiA+IFsgICAgMS4yMDY3MzBdICBtYXJrX3JvZGF0
YV9ybysweDUwLzB4NTgNCj4gPiBbICAgIDEuMjA4MjgxXSAga2VybmVsX2luaXQrMHgzYy8weDEy
MA0KPiA+IFsgICAgMS4yMDk3NjBdICByZXRfZnJvbV9mb3JrKzB4MTAvMHgyMA0KPiA+IFsgICAg
MS4yMTEyOThdIENvZGU6IGViMTUwMDNmIDU0MDAwMDYxIGQ1MDMzYTlmIGQ1MDMzZmRmIChmOTQw
MDBhMSkNCj4gPiBbICAgIDEuMjEzODU2XSAtLS1bIGVuZCB0cmFjZSA1OTQ3MzQxM2ZmZTNmNTJk
IF0tLS0NCj4gPiBbICAgIDEuMjE1ODUwXSBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogQXR0
ZW1wdGVkIHRvIGtpbGwgaW5pdCENCj4gZXhpdGNvZGU9MHgwMDAwMDAwYg0KPiA+DQo+ID4gV2Ug
Y2FuIHNlZSB0aGF0IHRoZSBlcnJvciBkZXJpdmVkIGZyb20gdGhlIGwzIHRyYW5zbGF0aW9uIGFz
IHRoZSBwdGUNCj4gPiB2YWx1ZSBpcyAqMCouIFRoYXQgaXMgYmVjYXVzZSB0aGUgZml4bWFwIGhh
cyBiZWVuIGNsZWFyIHdoZW4gYWNjZXNzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmlhbnlv
bmcgV3UgPGppYW55b25nLnd1QGFybS5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQvbW0v
bW11LmMgfCAyICsrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L21tL21tdS5jIGIvYXJjaC9hcm02NC9tbS9tbXUu
YyBpbmRleA0KPiA+IGNmZDlkZWIzNDdjMy4uNTY3ZGZiYThmMDhhIDEwMDY0NA0KPiA+IC0tLSBh
L2FyY2gvYXJtNjQvbW0vbW11LmMNCj4gPiArKysgYi9hcmNoL2FybTY0L21tL21tdS5jDQo+ID4g
QEAgLTU2NCw4ICs1NjQsMTAgQEAgdm9pZCBtYXJrX3JvZGF0YV9ybyh2b2lkKQ0KPiA+ICAJICog
dG8gY292ZXIgTk9URVMgYW5kIEVYQ0VQVElPTl9UQUJMRS4NCj4gPiAgCSAqLw0KPiA+ICAJc2Vj
dGlvbl9zaXplID0gKHVuc2lnbmVkIGxvbmcpX19pbml0X2JlZ2luIC0gKHVuc2lnbmVkDQo+ID4g
bG9uZylfX3N0YXJ0X3JvZGF0YTsNCj4gPiArCWdldF9vbmxpbmVfbWVtcygpOw0KPiA+ICAJdXBk
YXRlX21hcHBpbmdfcHJvdChfX3BhX3N5bWJvbChfX3N0YXJ0X3JvZGF0YSksICh1bnNpZ25lZA0K
PiBsb25nKV9fc3RhcnRfcm9kYXRhLA0KPiA+ICAJCQkgICAgc2VjdGlvbl9zaXplLCBQQUdFX0tF
Uk5FTF9STyk7DQo+ID4gKwlwdXRfb25saW5lX21lbXMoKTsNCj4gPg0KPiA+ICAJZGVidWdfY2hl
Y2t3eCgpOw0KPiA+ICB9DQo+ID4NCj4gDQo+IFdoaWxlIHRoaXMgc2hvdWxkIHNvbHZlIHRoZSBj
dXJyZW50IHByb2JsZW0gaS5lIHJhY2UgYmV0d2VlbiBjb25jdXJyZW50DQo+IG1lbW9yeSBob3Rw
bHVnIG9wZXJhdGlvbiBhbmQgbWFya19yb2RhdGFfcm8oKSwgYnV0IEkgYW0gc3RpbGwgd29uZGVy
aW5nDQo+IHdoZXRoZXIgdGhpcyBpcyB0aGUgZml4IGF0IHRoZSByaWdodCBwbGFjZSBhbmQgZ3Jh
bnVsYXJpdHkuIEJhc2ljYWxseSBhIGhvdHBsdWcNCj4gb3BlcmF0aW9uIHF1ZXVlZCBpbiBhbiB3
b3JrIHF1ZXVlIGF0IFtBXSBjYW4gZXhlY3V0ZSBkdXJpbmcgW0JdIGlzIHRoZSByb290DQo+IGNh
dXNlIG9mIHRoaXMgcHJvYmxlbS4NCj4gDQoNCk5vdCBleGFjdGx5LCB0aGlzIGlzc3VlIGRvZXNu
J3Qgb25seSBoYXBwZW4gYXQgdGhlIHRoZSAqcHVyZSoga2VybmVsIGJvb3QuIEZvciBleGFtcGxl
LCBob3RwbHVnIG1lbW9yeSB0aHJvdWdoIFZNIG1vbml0b3Igd2hlbiBWTSBib290LiBXZSBjYW4n
dCBmb3Jlc2VlIHdoZW4gdGhhdCBoYXBwZW4uIFRodXMsIHRoaXMgaXNzdWUgY2FuIGFmZmVjdCBh
bGwga2luZHMgb2YgbWVtb3J5IGhvdHBsdWcgbWVjaGFuaXNtLCBpbmNsdWRpbmcgQUNQSSBiYXNl
ZCBtZW1vcnkgaG90cGx1ZyBhbmQgdmlydGlvLW1lbS4NCkknbSBub3Qgc3VyZSB0aGF0IGZpeCBp
dCBoZXJlIGlzIHRoZSBiZXN0IHdheS4gSWYgdGhlIHJhY2Ugb25seSBoYXBwZW5zIGJldHdlZW4g
a2VybmVsIGluaXQgYW5kIG1lbW9yeSBob3RwbHVnLCBJIHRoaW5rIGl0J3MgZmluZSB0byBmaXgg
aXQgaGVyZS4gDQpJTU8sIHRoaXMgaXNzdWUgcmVzdWx0cyBmcm9tIHRoZSByYWNlIGZvciAiZml4
bWFwIiByZXNvdXJjZS4gSSB3b25kZXIgd2h5IHRoaXMgZ2xvYmFsIHJlc291cmNlIGlzIG5vdCBw
cm90ZWN0ZWQgYnkgYSBsb2NrLiBNYXliZSB3ZSBjYW4gYWRkIG9uZSBhbmQgZml4IGl0IHRoZXJl
Lg0KDQo+IHN0YXJ0X2tlcm5lbCguLikNCj4gew0KPiANCj4gYXJjaF9jYWxsX3Jlc3RfaW5pdCgu
LikNCj4gcmVzdF9pbml0KC4uKQ0KPiAJa2VybmVsX3RocmVhZChrZXJuZWxfaW5pdCwgLi4uKQ0K
PiAJCWtlcm5lbF9pbml0KC4uKSB7DQo+IAkJCWtlcm5lbF9pbml0X2ZyZWVhYmxlKC4uKQ0KPiAJ
CQkJZG9fYmFzaWNfc2V0dXAoLi4pDQo+IAkJCQkJZG9faW5pdGNhbGxzKC4uKQ0KPiAJCQkJCQku
Li4uLi4uLg0KPiAJCQkJCQltb2R1bGVfaW5pdCguLikgW0FdDQo+IAkJCS4uLi4uLi4uLi4uLi4u
Li4NCj4gCQkJLi4uLi4uLi4uLi4uLi4uLg0KPiAJCQltYXJrX3JlYWRvbmx5KC4uKQ0KPiAJCQkJ
bWFya19yb2RhdGFfcm8oLi4pDQo+IAkJCQkJdXBkYXRlX21hcHBpbmdfcHJvdCguLikNCj4gCQkJ
CQkJX19jcmVhdGVfcGdkX21hcHBpbmcoLi4pIFtCXQ0KPiAJCQl9DQo+IH0NCj4gDQo+IEFyZSB0
aGVyZSBubyBvdGhlciBub24taG90cGx1ZyBjYWxsIHBhdGggYWZ0ZXIgbW9kdWxlX2luaXQoKSwg
d2hpY2ggY291bGQNCj4gbGFuZCBpbiBfX2NyZWF0ZV9wZ2RfbWFwcGluZygpID8NCj4gDQo+IFBs
ZWFzZSBhbHNvIG5vdGUgdGhhdCB0aGlzIGlzIG5vdCBhbiBleGlzdGluZyBwcm9ibGVtIG9uIGFy
bTY0IHBsYXRmb3JtIHdoaWNoDQo+IG5lZWRzIHRvIGJlIGZpeGVkLCBhcyB2aXJ0aW8tbWVtIGlz
IHlldCB0byBiZSBlbmFibGVkLg0KDQpUaGlzIGlzc3VlIGFmZmVjdHMgYWxsIGtpbmRzIG9mIG1l
bW9yeSBob3RwbHVnIG1lY2hhbmlzbSwgc28sIEkgdGhpbmsgdGhhdCdzIG5vdCB0aGUgYnVzeW5l
c3Mgd2l0aCB2aXJ0aW8tbWVtIGl0c2VsZi4NCg0KVGhhbmtzDQpKaWFueW9uZw0K
