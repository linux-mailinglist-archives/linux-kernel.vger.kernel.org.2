Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469CB4346A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhJTIUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:20:25 -0400
Received: from mail-eopbgr30049.outbound.protection.outlook.com ([40.107.3.49]:53379
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229503AbhJTIUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04tAZz15xMWQyLBYbDZBbZqfMQwrhFG26Yp6+Vo+jA0=;
 b=VDubdTnmTBUnCXLaF5lqjy4EZFD4WleJg0NxbuzWgHgahhdjW5PHUOjWv5u82uVUZ/AN3Jl7nDrHfpsZLkYh7q18MsjHvG8TlRRFSAl9RlNqh2zk1IFPM7OBEch63J4qArzF3Fkd2h7kgDEBgJOjVuEdxOFDNWRCRJlj9JTTBK0=
Received: from AM6PR01CA0037.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::14) by AM6PR08MB5159.eurprd08.prod.outlook.com
 (2603:10a6:20b:e2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 08:18:06 +0000
Received: from AM5EUR03FT032.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:e0:cafe::bb) by AM6PR01CA0037.outlook.office365.com
 (2603:10a6:20b:e0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Wed, 20 Oct 2021 08:18:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT032.mail.protection.outlook.com (10.152.16.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Wed, 20 Oct 2021 08:18:05 +0000
Received: ("Tessian outbound 8e26f7114b75:v103"); Wed, 20 Oct 2021 08:18:05 +0000
X-CR-MTA-TID: 64aa7808
Received: from 968b0e3028c3.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 400AF1A0-72E4-4DB8-A777-407E9776E3D2.1;
        Wed, 20 Oct 2021 08:17:54 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 968b0e3028c3.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 20 Oct 2021 08:17:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9bPMSLMF2wL/gF8qf80Q6WCta4zccoGftDLHtrycAgGsks+0WINrLK3AXnlfILcLmqlbOrPi0evOqSZsgbHqCi3wnXWwXnO5iQc7D9Tm1uJhLJacNAXhdhXir8cm/FE3K1OPrMVKbzK/SWzlPxvhtjyhV2CItXYQK8xtnkF0k6BiWZ56Hk8OLM/sAjbhakQKjopzkPrhZYj3DG/BdrpE9+IR00Xb23ZXXeXDadK/IESNdn0C6L0YFW3y0UW+4SNDRbu0udzLRgTOfxetoQ5cTjOK5zx/nYaYxxS/rUgSyS8dw/ibZ4SZkJD12viObFVWIZdZeN9lBT+/OZB2BONhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04tAZz15xMWQyLBYbDZBbZqfMQwrhFG26Yp6+Vo+jA0=;
 b=B7CQV4v11qvOG22YQ93VuJ2Q0gTLMODGfgAgXxe844yZXbYnNi63QGKL/ZH/YIVRzwYfc7QEo4CInE1owTacKTR/ilwIAt90PvJn9Ys0x/8xsN2+21OJq2dDBy2/HIL9lOCw/eXHiQYxriSD4AglnhXaNtK3a15auanZXXOEqFjrDagfS+2iCXDVe/t5PuPYpMm7+ETfkPHNA1aZ5+a48WI6SbutkNn6cDG3hv5MnKgiP1uPi+t0MSmXS/t6uUlYrcCmm+cY9Du7bRYBXads6raa7NzB6vrg3yC1XAsp555Zs3okxVKMllfjTG4NGT96LujlL6rt84mLZyKAcWVT9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04tAZz15xMWQyLBYbDZBbZqfMQwrhFG26Yp6+Vo+jA0=;
 b=VDubdTnmTBUnCXLaF5lqjy4EZFD4WleJg0NxbuzWgHgahhdjW5PHUOjWv5u82uVUZ/AN3Jl7nDrHfpsZLkYh7q18MsjHvG8TlRRFSAl9RlNqh2zk1IFPM7OBEch63J4qArzF3Fkd2h7kgDEBgJOjVuEdxOFDNWRCRJlj9JTTBK0=
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com (2603:10a6:20b:437::11)
 by AM9PR08MB7069.eurprd08.prod.outlook.com (2603:10a6:20b:413::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Wed, 20 Oct
 2021 08:17:51 +0000
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::9032:349b:1fd4:fabe]) by AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::9032:349b:1fd4:fabe%3]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 08:17:51 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     David Hildenbrand <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        Justin He <Justin.He@arm.com>, nd <nd@arm.com>
Subject: RE: [PATCH v1] init: avoid race condition of update page table in
 kernel init
Thread-Topic: [PATCH v1] init: avoid race condition of update page table in
 kernel init
Thread-Index: AQHXxVdULJsQdGH9v0Wa3uDTZCwDxavbdvUAgAAB2ZA=
Date:   Wed, 20 Oct 2021 08:17:51 +0000
Message-ID: <AM9PR08MB7276FEF0AE524A9728F63A4CF4BE9@AM9PR08MB7276.eurprd08.prod.outlook.com>
References: <20211020020712.90240-1-jianyong.wu@arm.com>
 <4858258b-8fb9-b060-8724-25c89ba2ce0e@redhat.com>
In-Reply-To: <4858258b-8fb9-b060-8724-25c89ba2ce0e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: B8710506E4DF244E88146F012BDF017A.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 319fe8e8-aef0-4040-1865-08d993a224a5
x-ms-traffictypediagnostic: AM9PR08MB7069:|AM6PR08MB5159:
X-Microsoft-Antispam-PRVS: <AM6PR08MB515937596E75C102D19B2B26F4BE9@AM6PR08MB5159.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: gHx2nkG6zhVTMHHeQSUCBrPpRlXVENDQhuBIrWt5YPQ4ktV26PQS3JFO1iZ7yy5z8yM9E7K4cfDtClZuPbV4SI+f19jGbYuDfU7U+9Zfj6oxzw+KzfhrbXMieXk6t6fYYTvhTlIUFN++GVOkZ7I3iy+vjLM2dCOtW+pWXDqCfanh1BucGuvhiLrvpuWccTUo0R42fZtGWWaqxQZMvnoR76zMecSjFjYSBE/vdVFAOToqoaQUjaGXqoCMuJzLuFZVq8MqO/53LGwx8hqTytfEudt5ZGgVp3/j4YVGBUuoaD2sbVc4I27HrJuGB4NHbNvFa2ABZXhwKtkzyo8K8cRpkTLfeVLVxvprRlGB7Ul3lMb7pfaDSBAqym/kitGH/AE5EEtr/i+ipXjwljt/ZOLZ5K0Zy6YlNBAXemQFoslTZCTSX+uv4PYraX4CnFyrc30hJUBc3agQKiHO+8cJfSxo80rPBTf6hPAbMgIwFjfEuWKj6ticFvc8RmzA/58ghVCKQa4NjmfIedaw/se77pjNXZL1oi1YK9CYpZp0GFSsyOEiZ7lGYZoIRgcLxSEf/04n3nyr0uo/mLs8CVbfMmJTjRsz8739/bKD9zKuhE0Y1++cAuZInOVO2kcEv1gGCFwz8KLKoG4uLiWDttXh9CNjlZ9/xwd2/KDT8NAYOWkRlaIfMiUezNJppE8ID31VrpFug0Qca9wdnppI41x6dUWt7sPPDk+5rgPAJknRhFEdY4O8O+KwwHRHOse49iw4UGjsWlHaPNH6eTf70Ka3EuycKmYhXYpZ2zrEBW/WFjKFGK8=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7276.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016002)(38100700002)(966005)(9686003)(38070700005)(33656002)(2906002)(26005)(122000001)(316002)(52536014)(7696005)(4326008)(54906003)(5660300002)(66946007)(66476007)(64756008)(66446008)(66556008)(110136005)(53546011)(15650500001)(8676002)(186003)(6506007)(76116006)(508600001)(71200400001)(83380400001)(86362001)(8936002);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB7069
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT032.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6a128586-3ec1-46d4-422d-08d993a21c02
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8PkmQPz80JewlfZd/LkxhrkNYZ35WyKQgX1e0Hyk4yIuhR8RdMVkMXkGAxUsgqr3Esgv+mPaE6X899FrrdFlmQqqfxJ5y1OAamq/5tkHnIamLRvq21+CtLFeV+iM6uXgHLTWcClKO2kWXZTl2l8EY8sxYyEqxNV4heGLRgRgDmHriZjt1hcYKyReQXfVx+lhoEnn1UB2c9bPZKlXgGZLXRJMeOh9RMUQHOYs0HEWEDZmSQslaEJNTaZ1iBSNi5D+x6XU2/P9Fw/1KrPQIQsyyS0K6kRg0w/JafnlUwboyklBHxLUDQfTbaAmT5fidoGOZUmq7jG6Yen/Wu+1DA+suVRueBITwwrxx2lRlkOK2PsD2WqHxG9gEKGcsBPDD6QC/jJQUtxUPwMxwzgC8Lc0FwTqQpRSLdwOtABQtP1HhWJY4kWgIWxTh004R7Qs8bhET7/c75SWMOSExhw0b4vQO7b5W6T0Eqzt+KbDX9HjGqqCIeK0xcYjjiBpyfmtQR3eVWyx42rzC9eCojOJVP7zwUDctbvexBsLm6L95tm1oapNlrDeFacZb4P+Ab5KhgK1OgsRqvOzDMBJMoaCi1EdJCZXNGyTADk+qQufzFDqmqLaq1j4eCrDeKJUm33xruUdevY+Dps9Ky8YYj2cyAJCb1OnCbArTk7gr/p6jsKEx+d0rATxg2aHiYau0xei8tKFPh4Z4Tna+rl19kVo2D1dD/cx8HzxyG7mJWPIdJOm74q0B4yUct1yJwBPeF9jYJAfqKuseA4kr96eBFuEFswKwUVaMsgxBwVu1o4nRNFNuhU=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(5660300002)(8936002)(52536014)(186003)(8676002)(7696005)(110136005)(15650500001)(54906003)(6506007)(55016002)(26005)(9686003)(4326008)(81166007)(356005)(53546011)(316002)(966005)(2906002)(33656002)(86362001)(36860700001)(82310400003)(47076005)(83380400001)(70206006)(336012)(508600001)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 08:18:05.7610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 319fe8e8-aef0-4040-1865-08d993a224a5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT032.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5159
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gRGF2aWQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2
aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0
b2JlciAyMCwgMjAyMSAzOjA1IFBNDQo+IFRvOiBKaWFueW9uZyBXdSA8SmlhbnlvbmcuV3VAYXJt
LmNvbT47IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7DQo+IG1oaXJhbWF0QGtlcm5lbC5vcmc7
IHBldGVyekBpbmZyYWRlYWQub3JnDQo+IENjOiByb3N0ZWR0QGdvb2RtaXMub3JnOyB2YmFia2FA
c3VzZS5jejsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gQW5zaHVtYW4gS2hhbmR1
YWwgPEFuc2h1bWFuLktoYW5kdWFsQGFybS5jb20+OyBKdXN0aW4gSGUNCj4gPEp1c3Rpbi5IZUBh
cm0uY29tPjsgbmQgPG5kQGFybS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIGluaXQ6
IGF2b2lkIHJhY2UgY29uZGl0aW9uIG9mIHVwZGF0ZSBwYWdlIHRhYmxlIGluDQo+IGtlcm5lbCBp
bml0DQo+IA0KPiBPbiAyMC4xMC4yMSAwNDowNywgSmlhbnlvbmcgV3Ugd3JvdGU6DQo+ID4gUmFj
ZSBjb25kaXRpb24gb2YgcGFnZSB0YWJsZSB1cGRhdGUgY2FuIGhhcHBlbiBpbiBrZXJuZWxfaW5p
dCBhcyBib3RoDQo+ID4gb2YgbWVtb3J5IGhvdHBsdWcgbW9kdWxlIGluaXQgYW5kIHRoZSBmb2xs
b3dpbmcgbWFya19yb2RhdGFfcm8gY2FuDQo+ID4gdXBkYXRlIHBhZ2UgdGFibGUuIFRoZSBmdW5j
dGlvbiBleGN1dGUgZmxvdyBjaGFydCBpczoNCj4gPg0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4gPiBrZXJuZWxfaW5pdA0KPiA+ICAga2VybmVsX2luaXRfZnJlZWFibGUNCj4gPiAg
ICAgLi4uDQo+ID4gICAgICAgZG9faW5pdGNhbGwNCj4gPiAgICAgICAgIC4uLg0KPiA+ICAgICAg
ICAgICBtb2R1bGVfaW5pdCBbQV0NCj4gDQo+IE5pdDogdmlydGlvLW1lbSBhZGRzIG1lbW9yeSB2
aWEgYSB3b3JrcXVldWUsIG5vdCBkaXJlY3RseSBkdXJpbmcNCj4gbW9kdWxlX2luaXQuDQoNClll
cywgbWF5YmUgaXQncyBtaXNsZWFkaW5nLiBJIHdhbnQgdG8gc2F5IHRoYXQgdGhlIGRyaXZlciBp
bml0aWFsaXphdGlvbiwgZS5nLiB2aXJ0aW8tbWVtLCB0aGUgd29ya3F1ZXVlIHdpbGwgYmUgdHJp
Z2dlcmVkIGJlZm9yZSBtYXJrX3JvZGF0YV9yby4NCg0KPiANCj4gPg0KPiA+ICAgLi4uDQo+ID4g
ICBtYXJrX3JlYWRvbmx5DQo+ID4gICAgIG1hcmtfcm9kYXRhX3JvIFtCXQ0KPiA+IC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gPiBbQV0gY2FuIGNvbnRhaW5zIG1lbW9yeSBob3RwbHVnIGlu
aXQgdGhlcmVmb3JlIGJvdGggW0FdIGFuZCBbQl0gY2FuDQo+ID4gdXBkYXRlIHBhZ2UgdGFibGUg
YXQgdGhlIHNhbWUgdGltZSB0aGF0IG1heSBsZWFkIHRvIHJhY2UuIEhlcmUgd2UNCj4gPiBpbnRy
b2R1Y2UgbWVtb3J5IGhvdHBsdWcgbG9jayB0byBndWFyZCBtYXJrX3JvZGF0YV9ybyB0byBhdm9p
ZCB0aGUNCj4gPiByYWNlIGNvbmRpdGlvbi4NCj4gPg0KPiA+IEkgY2F0Y2ggdGhlIHJlbGF0ZWQg
ZXJyb3Igd2hlbiB0ZXN0IHZpcnRpby1tZW0gKGEgbmV3IG1lbW9yeSBob3RwbHVnDQo+ID4gZHJp
dmVyKSBvbiBhcm02NCBhbmQgbWF5IGJlIGEgcG90ZW50aWFsIGJ1ZyBmb3Igb3RoZXIgYXJjaGVz
Lg0KPiANCj4gVGhhbmtzIGZvciByZXBvcnRpbmcsIHdlIHNob3VsZCBiZSBhYmxlIHRvIHRyaWdn
ZXIgc29tZXRoaW5nIHNpbWlsYXIgdXNpbmcNCj4gQUNQSSwgd2hlbiBob3RwbHVnZ2luZyBESU1N
cyBqdXN0IGF0IHRoZSB3cm9uZyBwb2ludCBpbiB0aW1lLg0KPg0KSSB0aGluayBzbywgQUNQSSBi
YXNlZCBtZW1vcnkgaG90cGx1ZyBtYXkgaGFzIHRoZSBzYW1lIGlzc3VlLiBJJ2xsIHRlc3QgQUNQ
SSBiYXNlZCBkaW1tIGhvdHBsdWcgYWJvdXQgdGhlIGNhc2UuDQogDQo+ID4NCj4gPiBIb3cgdG8g
cmVwcm9kdWNlIG9uIGFybTY0Og0KPiA+ICgxKSBwcmVwYXJlIGEga2VybmVsIHdpdGggdmlydGlv
LW1lbSBlbmFibGVkIG9uIGFybTY0DQo+ID4gKDIpIHN0YXJ0IGEgVk0gdXNpbmcgQ2xvdWQgSHlw
ZXJ2aXNvclsxXSB1c2luZyB0aGUga2VybmVsIGFib3ZlDQo+ID4gKDMpIGhvdHBsdWcgbWVtb3J5
LCAyMEcgaW4gbXkgY2FzZSwgd2l0aCB2aXJ0aW8tbWVtDQo+ID4gKDQpIHJlYm9vdCBvciBsb2Fk
IG5ldyBrZXJuZWwgdXNpbmcga2V4ZWMNCj4gPg0KPiA+IFRlc3QgZm9yIHNlcnZlciB0aW1lcywg
eW91IG1heSBmaW5kIHRoZSBlcnJvciBiZWxvdzoNCj4gPg0KPiA+IFsgICAgMS4xMzEwMzldIFVu
YWJsZSB0byBoYW5kbGUga2VybmVsIHBhZ2luZyByZXF1ZXN0IGF0IHZpcnR1YWwgYWRkcmVzcw0K
PiBmZmZmZmJmZmZkYTNiMTQwDQo+ID4gWyAgICAxLjEzNDUwNF0gTWVtIGFib3J0IGluZm86DQo+
ID4gWyAgICAxLjEzNTcyMl0gICBFU1IgPSAweDk2MDAwMDA3DQo+ID4gWyAgICAxLjEzNjk5MV0g
ICBFQyA9IDB4MjU6IERBQlQgKGN1cnJlbnQgRUwpLCBJTCA9IDMyIGJpdHMNCj4gPiBbICAgIDEu
MTM5MTg5XSAgIFNFVCA9IDAsIEZuViA9IDANCj4gPiBbICAgIDEuMTQwNDY3XSAgIEVBID0gMCwg
UzFQVFcgPSAwDQo+ID4gWyAgICAxLjE0MTc1NV0gICBGU0MgPSAweDA3OiBsZXZlbCAzIHRyYW5z
bGF0aW9uIGZhdWx0DQo+ID4gWyAgICAxLjE0Mzc4N10gRGF0YSBhYm9ydCBpbmZvOg0KPiA+IFsg
ICAgMS4xNDQ5NzZdICAgSVNWID0gMCwgSVNTID0gMHgwMDAwMDAwNw0KPiA+IFsgICAgMS4xNDY1
NTRdICAgQ00gPSAwLCBXblIgPSAwDQo+ID4gWyAgICAxLjE0NzgxN10gc3dhcHBlciBwZ3RhYmxl
OiA0ayBwYWdlcywgNDgtYml0IFZBcywNCj4gcGdkcD0wMDAwMDAwMDQyNmYyMDAwDQo+ID4gWyAg
ICAxLjE1MDU1MV0gW2ZmZmZmYmZmZmRhM2IxNDBdIHBnZD0wMDAwMDAwMDQyZmZkMDAzLA0KPiBw
NGQ9MDAwMDAwMDA0MmZmZDAwMywgcHVkPTAwMDAwMDAwNDJmZmUwMDMsIHBtZD0wMDAwMDAwMDQy
ZmZmMDAzLA0KPiBwdGU9MDAwMDAwMDAwMDAwMDAwMA0KPiA+IFsgICAgMS4xNTU3MjhdIEludGVy
bmFsIGVycm9yOiBPb3BzOiA5NjAwMDAwNyBbIzFdIFNNUA0KPiA+IFsgICAgMS4xNTc3MjRdIENQ
VTogMCBQSUQ6IDEgQ29tbTogc3dhcHBlci8wIFRhaW50ZWQ6IEcgICAgICAgICBDICAgICAgICA1
LjE1LjAtDQo+IHJjMysgIzEwMA0KPiA+IFsgICAgMS4xNjEwMDJdIEhhcmR3YXJlIG5hbWU6IGxp
bnV4LGR1bW15LXZpcnQgKERUKQ0KPiA+IFsgICAgMS4xNjI5MzldIHBzdGF0ZTogNjA0MDAwMDUg
KG5aQ3YgZGFpZiArUEFOIC1VQU8gLVRDTyAtRElUIC1TU0JTDQo+IEJUWVBFPS0tKQ0KPiA+IFsg
ICAgMS4xNjU4MjVdIHBjIDogYWxsb2NfaW5pdF9wdWQrMHgzOGMvMHg1NTANCj4gPiBbICAgIDEu
MTY3NjEwXSBsciA6IGFsbG9jX2luaXRfcHVkKzB4Mzk0LzB4NTUwDQo+ID4gWyAgICAxLjE2OTM1
OF0gc3AgOiBmZmZmODAwMDEwMDFiZDEwDQo+ID4gLi4uLi4uDQo+ID4gWyAgICAxLjIwMDUyN10g
Q2FsbCB0cmFjZToNCj4gPiBbICAgIDEuMjAxNTgzXSAgYWxsb2NfaW5pdF9wdWQrMHgzOGMvMHg1
NTANCj4gPiBbICAgIDEuMjAzMjE4XSAgX19jcmVhdGVfcGdkX21hcHBpbmcrMHg5NC8weGUwDQo+
ID4gWyAgICAxLjIwNDk4M10gIHVwZGF0ZV9tYXBwaW5nX3Byb3QrMHg1MC8weGQ4DQo+ID4gWyAg
ICAxLjIwNjczMF0gIG1hcmtfcm9kYXRhX3JvKzB4NTAvMHg1OA0KPiA+IFsgICAgMS4yMDgyODFd
ICBrZXJuZWxfaW5pdCsweDNjLzB4MTIwDQo+ID4gWyAgICAxLjIwOTc2MF0gIHJldF9mcm9tX2Zv
cmsrMHgxMC8weDIwDQo+ID4gWyAgICAxLjIxMTI5OF0gQ29kZTogZWIxNTAwM2YgNTQwMDAwNjEg
ZDUwMzNhOWYgZDUwMzNmZGYgKGY5NDAwMGExKQ0KPiA+IFsgICAgMS4yMTM4NTZdIC0tLVsgZW5k
IHRyYWNlIDU5NDczNDEzZmZlM2Y1MmQgXS0tLQ0KPiA+IFsgICAgMS4yMTU4NTBdIEtlcm5lbCBw
YW5pYyAtIG5vdCBzeW5jaW5nOiBBdHRlbXB0ZWQgdG8ga2lsbCBpbml0IQ0KPiBleGl0Y29kZT0w
eDAwMDAwMDBiDQo+ID4NCj4gPiBbMV0gaHR0cHM6Ly9naXRodWIuY29tL2Nsb3VkLWh5cGVydmlz
b3IvY2xvdWQtaHlwZXJ2aXNvcg0KPiA+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBBbnNodW1hbiBLaGFu
ZHVhbCA8YW5zaHVtYW4ua2hhbmR1YWxAYXJtLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKaWFu
eW9uZyBXdSA8amlhbnlvbmcud3VAYXJtLmNvbT4NCj4gPiAtLS0NCj4gPiAgaW5pdC9tYWluLmMg
fCAyICsrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9pbml0L21haW4uYyBiL2luaXQvbWFpbi5jIGluZGV4DQo+ID4gODFhNzlhNzdk
YjQ2Li4yOTBjOTg4MmJhOWUgMTAwNjQ0DQo+ID4gLS0tIGEvaW5pdC9tYWluLmMNCj4gPiArKysg
Yi9pbml0L21haW4uYw0KPiA+IEBAIC0xNDcxLDcgKzE0NzEsOSBAQCBzdGF0aWMgdm9pZCBtYXJr
X3JlYWRvbmx5KHZvaWQpDQo+ID4gIAkJICogaW5zZWN1cmUgcGFnZXMgd2hpY2ggYXJlIFcrWC4N
Cj4gPiAgCQkgKi8NCj4gPiAgCQlyY3VfYmFycmllcigpOw0KPiA+ICsJCWdldF9vbmxpbmVfbWVt
cygpOw0KPiA+ICAJCW1hcmtfcm9kYXRhX3JvKCk7DQo+ID4gKwkJcHV0X29ubGluZV9tZW1zKCk7
DQo+IA0KPiBJIGZlZWwgbGlrZSB0aGlzIHNob3VsZCBiZSBoYW5kbGVkIGFjY29yZGluZ2x5IGlu
IHRoZSBhcmNoIGNvZGUgaW5zdGVhZC4NCj4gVGhlIGFyY2ggY29kZSBoYXMgdG8gYmUgYWJsZSB0
byBkZWFsIHdpdGggY29uY3VycmVudCBkaXJlY3QgbWFwIG9wZXJhdGlvbnMNCj4gKGUuZy4sIGNv
bmN1cnJlbnQgc2VjcmV0bWVtIHVwZGF0ZXMsIGNvbmN1cnJlbnQgbWVtb3J5IGhvdGFkZCAvIGhv
dA0KPiByZW1vdmFsKS4NCj4gDQpJTU8sIHRoZSByYWNlIG9mIHBhZ2UgdGFibGUgdXBkYXRlIG1h
eSBoYXBwZW4gaGVyZSBhbmQgYWZmZWN0IGFsbCBhcmNoZXMgYWZ0ZXIgdmlydGlvLW1lbSB3b3Jr
cXVldWUgaXMgdHJpZ2dlcmVkLg0KDQo+IEkgcmVtZW1iZXIgeDg2LTY0IHNlcmlhbGl6ZXMgcGFn
ZSB0YWJsZSBpbml0IHVzaW5nICZpbml0X21tLnBhZ2VfdGFibGVfbG9jaw0KPiBhbmQgcGFnZSB0
YWJsZSB1cGRhdGVzIHVzaW5nIHRoZSBjcGFfbG9jayAoc2VlDQo+IGFyY2gveDg2L21tL3BhdC9z
ZXRfbWVtb3J5LmMpLg0KPg0KIA0KPiBUaGUgcXVlc3Rpb24gd291bGQgYmU6IGluIHdoaWNoIGNh
c2VzIHdvdWxkIHdlIHRvdWNoIHRoZSBzYW1lIHBhZ2UgdGFibGVzDQo+IHdoZW4gYWRkaW5nIG1l
bW9yeSB3aGlsZSBjb25jdXJyZW50bHkgc3BsaXR0aW5nIHN1Y2ggYSBwYWdlIHRhYmxlLiBPbiB4
ODYtDQo+IDY0LCBJSVJDLCBhbGwgdGhhdCBjb3VsZCBoYXBwZW4gaXMgdGhhdCB3ZSBzcGxpdCBh
IGh1Z2UgZGlyZWN0IG1hcHBpbmcgYW5kDQo+IHJlcGxhY2UgaXQgdmlhIGEgcGFnZSB0YWJsZSBo
b2xkaW5nIDRrIG1hcHBpbmdzLiBUaGlzIGNhbm5vdCByZWFsbHkgY29uZmxpY3QNCj4gd2l0aCBt
ZW1vcnkgaG90YWRkLCB3aGljaCB3b3JrcyBpbiBhdCBsZWFzdCAyIE1pQg0KPiAoc3ViLXNlY3Rp
b24pIGdyYW51bGFyaXR5LiBUd28gcmFuZ2VzIGNvdWxkbid0IHNpbGVudGx5IG92ZXJsYXAgYW5k
IHRyaWdnZXINCj4gc3VjaCBhIHJhY2UuDQo+IA0KPiBTbyBJIGRvbid0IHRoaW5rIHNvbWV0aGlu
ZyBsaWtlIHRoYXQgYXBwbGllcyBvbiB4ODYtNjQ6IEkndmUgcnVuIGVuZGxlc3MgdGVzdHMNCj4g
d2l0aCBDT05GSUdfVklSVElPX01FTT15IG92ZXIgdGhlIHllYXJzIChpbnN0ZWFkIG9mICJtIikg
YW5kIG5ldmVyDQo+IHNwb3R0ZWQgc29tZXRoaW5nIHNpbWlsYXIuDQo+IA0KPiBCdXQgd2h5IGRv
ZXMgaXQgbWF0dGVyIG9uIGFybTY0PyBDYW4geW91IGRlc2NyaWJlIGhvdyB0aGUgZXhhY3QgcmFj
ZQ0KPiB0cmlnZ2Vycz8NCg0KSSBkb24ndCBrbm93IG11Y2ggYWJvdXQgaG93IHg4NiBkb2VzIGlu
IG1lbW9yeSBtYXAuIExldCBtZSBzaG93IHlvdSBob3cgdGhlIHJhY2UgaGFwcGVucyBvbiBhcm02
NC4NCldoZW4gdmlydGlvLW1lbSB3b3JrcXVldWUgaXMgdHJpZ2dlcmVkLCBhcmNoX21lbW9yeV9h
ZGQgd2lsbCBiZSBjYWxsZWQgd2hlcmUgdGhlIHJlbGF0ZWQgcGFnZSB0YWJsZSB3aWxsIGJlIGNy
ZWF0ZWQuIFRoZSBjYWxsIGNoYWluIGlzIGFyY2hfbWVtb3J5X2FkZC0+X19jcmVhdGVfcGdkX21h
cHBpbmctPmFsbG9jX2luaXRfcHVkLiBBcyB0aGUgbWVtb3J5IGFkZCBtYXkgdGFrZSBmb3Igc2Vy
dmFsIHNlY29uZHMsIGl0IG1heSBiZSBjb25jdXJyZW50IHdpdGggbWFya19yb2RhdGFfcm8sIGlu
IHdoaWNoIHBhZ2UgdGFibGVzIGFyZSBjcmVhdGVkIGVpdGhlci4NClRoZSByYWNlIGNhbiBvY2N1
ciBpbiBhbGxvY19pbml0X3B1ZC4gU2VlIGJlbG93Og0KLyoqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8NClZp
cnRpby1tZW0gd29ya3F1ZXVlIHRocmVhZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hcmtfcm9kYXRhX3JvIHRocmVhZA0KeyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICANCi4uLg0KICAgICAgICBwdWRwID0gcHVkX3NldF9maXhtYXBfb2Zmc2V0KHA0ZHAsIGFk
ZHIpOyAvLyBzZXQgZml4bWFwDQogICAgICAgIGRvIHsNCiAgICAgICAgICAgICAgICBwdWRfdCBv
bGRfcHVkID0gUkVBRF9PTkNFKCpwdWRwKTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIA0KLi4uDQogICAgICAgIH0gd2hpbGUgKHB1ZHArKywgYWRkciA9IG5leHQsIGFk
ZHIgIT0gZW5kKTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHB1ZHAgPSBwdWRf
c2V0X2ZpeG1hcF9vZmZzZXQ7ICAvL3NldCBmaXhtYXAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIA0KICAgICAgICBwdWRfY2xlYXJfZml4bWFwKCk7ICAvLyBjbGVhciBmaXhtYXAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZG8gew0KfSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHB1ZF90IG9sZF9wdWQgPSBSRUFEX09OQ0UoKnB1ZHApOy8vQ1JBU0gNCg0KLyoqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqLw0KV2hlbiBjcmVhdGUgZGlyZWN0IGtlcm5lbCBtZW1vcnkgbWFwLCBmaXht
YXAsIHdoaWNoIGlzIGdsb2JhbCwgaXMgdXNlZCBhbmQgc2hvdWxkIGF2b2lkIGJlaW5nIHVzZWQg
aW4gY29uY3VycmVuY3kuIE9uY2UgcmFjZSBoYXBwZW4sIGNyYXNoIG1heSBvY2N1ci4gVGhhdCdz
IHdoeSB3ZSBjYW4gc2VlIGluIHRoZSBrZXJuZWwgZHVtcCB0aGF0IHRoZSAqcHRlKiB2YWx1ZSBp
cyAqMCouDQoNClRoYW5rcw0KSmlhbnlvbmcNCg0KPiANCj4gLS0NCj4gVGhhbmtzLA0KPiANCj4g
RGF2aWQgLyBkaGlsZGVuYg0KDQo=
