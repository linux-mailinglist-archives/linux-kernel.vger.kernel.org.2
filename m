Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4794434A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhJTL5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:57:19 -0400
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:39585
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229548AbhJTL5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zjAI4vWI6wEyQ61lYNtK+xcGPwpOL1VQFVCV4ColAE=;
 b=xIGeI0Btl5X/bzkOSNsGNRWlMvwTRDH58TPwiwsgAwcejO1nrU66bG4lT3YYxHfa3CzLze7OhZUT9InuFAr64qZ/thK91VF99ab98ZuClmraaNnhoJKl8n36jP95UjpwrwCcSuLUFof7ov/WnRAjq4DbYCKyHVJ8R2kVFv41ImU=
Received: from AM6P195CA0013.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::26)
 by AM9PR08MB6131.eurprd08.prod.outlook.com (2603:10a6:20b:2de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 11:54:50 +0000
Received: from AM5EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:81:cafe::b9) by AM6P195CA0013.outlook.office365.com
 (2603:10a6:209:81::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Wed, 20 Oct 2021 11:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT045.mail.protection.outlook.com (10.152.17.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Wed, 20 Oct 2021 11:54:49 +0000
Received: ("Tessian outbound b9598e0ead92:v103"); Wed, 20 Oct 2021 11:54:49 +0000
X-CR-MTA-TID: 64aa7808
Received: from 0261e836b825.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DF80738D-E47B-48B8-B4CA-A87D2ADD756F.1;
        Wed, 20 Oct 2021 11:54:38 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0261e836b825.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 20 Oct 2021 11:54:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXsW1HU5jqtpPpWhGOeB1ptUnxUc6ax7hDFltIgT0aLwHNX69QC8MHHP9N6fVn2WlLuqkLs5Axc9nVqTRHsjDXVR1IGnpSNB9vJBjOQOsxycHnIrL3E0Pu2gebzueZY4JHnDGsRI0N/WkGLS5x9tWRBnKiomNlCQN2STtbJ1/l6jZrkn0KZS+Kr55XHcJcsABld0axT2aERGDV0aerkDbvZHtT7DKUfSgQ0/9RgeBo+W7LbLaROt5QmEHTDmJmKel0Hg24n1NCy13oSnvOQSHAOAJzR2DvFwUKo7qnyih0lnNpsiHGtvlSGi1qwzPX96vvkmykBJ9oILhP6/yad9hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zjAI4vWI6wEyQ61lYNtK+xcGPwpOL1VQFVCV4ColAE=;
 b=T/GXRC8TP1vjcLuaP/H1B+X5JwUEuyVsp4MGey8qm+nDzpVebDHtF+tCyimZaG4HXkwcrEokOKg1KFIfrbs4fFOXsWpmP/g5zvTbEZ2Q30EkuX8uKf9ADV2I5d0/kT/DT1q3K44nc/A1n3S9FHKW+W++P6YPB/E4cqq15SMev+MIS02NIfbAHcYhKA8hdOLKOl1NUPajd0tpSTVCWHNlN3yOtVKCDF3INp4cumtGrdBRu+hLKnMStMyXTONuijXEZKImJJkzbp5CoCkiyFblErtOWRxpgQeTbMrnG1B+TOC0w7fEv7d0GbKROewohFL1cGeIRB5lVuywsM6yNyQiUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zjAI4vWI6wEyQ61lYNtK+xcGPwpOL1VQFVCV4ColAE=;
 b=xIGeI0Btl5X/bzkOSNsGNRWlMvwTRDH58TPwiwsgAwcejO1nrU66bG4lT3YYxHfa3CzLze7OhZUT9InuFAr64qZ/thK91VF99ab98ZuClmraaNnhoJKl8n36jP95UjpwrwCcSuLUFof7ov/WnRAjq4DbYCKyHVJ8R2kVFv41ImU=
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com (2603:10a6:20b:437::11)
 by AM9PR08MB7168.eurprd08.prod.outlook.com (2603:10a6:20b:3de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Wed, 20 Oct
 2021 11:54:36 +0000
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::9032:349b:1fd4:fabe]) by AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::9032:349b:1fd4:fabe%3]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 11:54:36 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     David Hildenbrand <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>
CC:     "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Justin He <Justin.He@arm.com>, nd <nd@arm.com>
Subject: RE: [PATCH v1] init: avoid race condition of update page table in
 kernel init
Thread-Topic: [PATCH v1] init: avoid race condition of update page table in
 kernel init
Thread-Index: AQHXxVdULJsQdGH9v0Wa3uDTZCwDxavbdvUAgAAB2ZCAAB+vgIAADnUA
Date:   Wed, 20 Oct 2021 11:54:36 +0000
Message-ID: <AM9PR08MB7276F15F55066A0C264A4B9CF4BE9@AM9PR08MB7276.eurprd08.prod.outlook.com>
References: <20211020020712.90240-1-jianyong.wu@arm.com>
 <4858258b-8fb9-b060-8724-25c89ba2ce0e@redhat.com>
 <AM9PR08MB7276FEF0AE524A9728F63A4CF4BE9@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <cbe8d847-8a2d-4220-c6a3-775d517e2edd@redhat.com>
In-Reply-To: <cbe8d847-8a2d-4220-c6a3-775d517e2edd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Anshuman.Khandual@arm.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 047D88BAF82ED444AD75D63EB0193963.0
x-checkrecipientchecked: true
Authentication-Results-Original: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 8c2db400-8c40-46a6-bfbc-08d993c06bb5
x-ms-traffictypediagnostic: AM9PR08MB7168:|AM9PR08MB6131:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM9PR08MB6131B130B71313449FC87531F4BE9@AM9PR08MB6131.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: R7UkD3269m93LifyDatqvUZKMZnxXr4oN94M2ASAemgY2NnB88GmoKRcgwzmZHrO6GucmSGC1sqcRBgNg3AXDr3XPvDFNib7x3qyWRTwliA5C0+LmGldW6cfeX2R7oXpp6gQie6Zx4ekgdkdrsJl3ELSfKQBA3ALSpRyCmcvMTp1bB0mbVkWxi/QjPXTdalN4knx7xVELC/dphE8gA6F/JBJG6XvuQaUw28qy9A2rAZHkmOyBw7mqwNLw86AeLzk2CqwWV4+u93G7N4MJ7d/SZ2P+/9tMvCtF974MTShfbjBrQIAdsCpNAA02q29LH/6LE5eOhRe5mIS0gQxEijz0hDQ7IpjHQ0z5lSOtUtmyARs968cWkMZOHHgwk6z89y1j7+cv5CWu4kvo9io5VwEL34VrNIX/FNJUKxYv/wyum5wQytNFkF5O7lUPGvhhTcOqzoPEIxPfneFZlbvcb3Y+TTAoT1eBTn2Ao2TaNrsIc2o8r8pqkHLCgX7wVtw5QdRNrW//dcQcZTpFZRBqpO0jhqy9GKaKgnwU+Hu/UGeD1M7hGEeGLwTsq3X46/ZWUQ0ALXGkrYYaXAphBTPRtECe7zGDEggKRp4/uIV4HbrIKNxyQ8akJ5fgikTDEQOxF7n4mf2qPcBYtieCCRCT2LjMuVxBJbQ/zrxy5YeCV0e/TEoVkR8roPV/4hz9djQGBXAqkv+KKZFo7y4bsjsFd+ozw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7276.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(8676002)(186003)(2906002)(8936002)(52536014)(316002)(4326008)(38100700002)(110136005)(122000001)(76116006)(71200400001)(86362001)(66446008)(66476007)(26005)(54906003)(83380400001)(66556008)(66946007)(64756008)(6636002)(7696005)(33656002)(9686003)(53546011)(55016002)(6506007)(5660300002)(508600001)(15650500001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB7168
Original-Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 29672346-0d43-4753-9025-08d993c063c8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6EO6WXmwMrbKm89NnTztSilaP7KECRWUeG0LD+zmlFzpfRlgmfo/LVPWwHr83poxGSTJih/qQ1Wjk025+IwKjiFfL9tcHcmM+AbYYvPJNOodvDr2JB7c3FR/rKB7AKtNqb8drtrJsaHFdmeon8fcRhmpvDnIB7mBYSl/dripUe43obOsPm8H/s0WG6knQvdxqmpRPsIYQ5uVWt6SHVRhXHKRG0iQAWv6yIW1rLxyyrnaw62XJOe78aRpQ5RpHvmpHcatMvYA6vQ9D613DF2K7lC/1Z/uoNngt5q9bTeV/CX3rdREKp/IJx0ORr3y2j8MDTLSzDJkwNrEkWdYgXwbg5dYFF0EZ+OrS45cBPFRVCJ9Wi/6q4xQ6jZYQeJt7mHZTv5fxH7C9iI9l6arNfIrhJJmc/2sSA4F8YwbmOEs0v0S/gtk19iSpqrkrcRBVU1C6zM5TOgcHuLpHQVt7G6B+3Ar7Gl0o3QQWV/DTh12S3dlw/8wHIpXBugG+hN0/ze0HcPLpAGsfK3hsqSn31xf0Myk3iGSWsfXGFrfKq8ndCLxUS6s3/MqI4crHGN2nbDhgAHA0W15slIQ/Qe919hmpXFc5Bq4ccqiho312SAGdK/Vqnn9f3RsHuOMMg0gB7kH8NjxEvCb/nhJ7i52FbVNwYUZIxnzWWBdWhBBFybdPhCOxsaSipPAcGyLzfy1QkToDLiZcCuoZDks8Izpvzykag==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(47076005)(26005)(508600001)(2906002)(4326008)(52536014)(356005)(81166007)(6506007)(53546011)(86362001)(7696005)(82310400003)(186003)(110136005)(55016002)(8676002)(8936002)(83380400001)(54906003)(15650500001)(70206006)(70586007)(6636002)(316002)(36860700001)(9686003)(33656002)(5660300002)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 11:54:49.9113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2db400-8c40-46a6-bfbc-08d993c06bb5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6131
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgSGlsZGVuYnJh
bmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyMCwgMjAy
MSA1OjA1IFBNDQo+IFRvOiBKaWFueW9uZyBXdSA8SmlhbnlvbmcuV3VAYXJtLmNvbT47IGFrcG1A
bGludXgtZm91bmRhdGlvbi5vcmc7DQo+IG1oaXJhbWF0QGtlcm5lbC5vcmc7IHBldGVyekBpbmZy
YWRlYWQub3JnDQo+IENjOiByb3N0ZWR0QGdvb2RtaXMub3JnOyB2YmFia2FAc3VzZS5jejsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gQW5zaHVtYW4gS2hhbmR1YWwgPEFuc2h1bWFu
LktoYW5kdWFsQGFybS5jb20+OyBKdXN0aW4gSGUNCj4gPEp1c3Rpbi5IZUBhcm0uY29tPjsgbmQg
PG5kQGFybS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIGluaXQ6IGF2b2lkIHJhY2Ug
Y29uZGl0aW9uIG9mIHVwZGF0ZSBwYWdlIHRhYmxlIGluDQo+IGtlcm5lbCBpbml0DQo+IA0KPiA+
PiBCdXQgd2h5IGRvZXMgaXQgbWF0dGVyIG9uIGFybTY0PyBDYW4geW91IGRlc2NyaWJlIGhvdyB0
aGUgZXhhY3QgcmFjZQ0KPiA+PiB0cmlnZ2Vycz8NCj4gPg0KPiA+IEkgZG9uJ3Qga25vdyBtdWNo
IGFib3V0IGhvdyB4ODYgZG9lcyBpbiBtZW1vcnkgbWFwLiBMZXQgbWUgc2hvdyB5b3UNCj4gaG93
IHRoZSByYWNlIGhhcHBlbnMgb24gYXJtNjQuDQo+ID4gV2hlbiB2aXJ0aW8tbWVtIHdvcmtxdWV1
ZSBpcyB0cmlnZ2VyZWQsIGFyY2hfbWVtb3J5X2FkZCB3aWxsIGJlIGNhbGxlZA0KPiB3aGVyZSB0
aGUgcmVsYXRlZCBwYWdlIHRhYmxlIHdpbGwgYmUgY3JlYXRlZC4gVGhlIGNhbGwgY2hhaW4gaXMN
Cj4gYXJjaF9tZW1vcnlfYWRkLT5fX2NyZWF0ZV9wZ2RfbWFwcGluZy0+YWxsb2NfaW5pdF9wdWQu
IEFzIHRoZSBtZW1vcnkNCj4gYWRkIG1heSB0YWtlIGZvciBzZXJ2YWwgc2Vjb25kcywgaXQgbWF5
IGJlIGNvbmN1cnJlbnQgd2l0aCBtYXJrX3JvZGF0YV9ybywNCj4gaW4gd2hpY2ggcGFnZSB0YWJs
ZXMgYXJlIGNyZWF0ZWQgZWl0aGVyLg0KPiANCj4gPiBUaGUgcmFjZSBjYW4gb2NjdXIgaW4gYWxs
b2NfaW5pdF9wdWQuIFNlZSBiZWxvdzoNCj4gPg0KPiAvKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqDQo+ICoqKioqKioqKioqKi8N
Cj4gPiBWaXJ0aW8tbWVtIHdvcmtxdWV1ZSB0aHJlYWQNCj4gbWFya19yb2RhdGFfcm8gdGhyZWFk
DQo+ID4gew0KPiA+IC4uLg0KPiA+ICAgICAgICAgcHVkcCA9IHB1ZF9zZXRfZml4bWFwX29mZnNl
dChwNGRwLCBhZGRyKTsgLy8gc2V0IGZpeG1hcA0KPiA+ICAgICAgICAgZG8gew0KPiA+ICAgICAg
ICAgICAgICAgICBwdWRfdCBvbGRfcHVkID0gUkVBRF9PTkNFKCpwdWRwKTsNCj4gPiAuLi4NCj4g
PiAgICAgICAgIH0gd2hpbGUgKHB1ZHArKywgYWRkciA9IG5leHQsIGFkZHIgIT0gZW5kKTsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHB1ZHAgPQ0KPiBwdWRfc2V0X2ZpeG1hcF9v
ZmZzZXQ7ICAvL3NldCBmaXhtYXANCj4gPiAgICAgICAgIHB1ZF9jbGVhcl9maXhtYXAoKTsgIC8v
IGNsZWFyIGZpeG1hcCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBkbyB7DQo+ID4gfQ0KPiBwdWRfdCBvbGRfcHVkID0gUkVBRF9PTkNFKCpwdWRwKTsvL0NSQVNI
DQo+ID4NCj4gDQo+IEkgc3RpbGwgZG9uJ3QgcXVpdGUgdW5kZXJzdGFuZCBob3cgdGhhdCByYWNl
IGNhbiBldmVuIGV4aXN0LiBJIGFzc3VtZSBpdCdzIGR1ZQ0KPiB0byB0aGUgd2VpcmQgc2VtYW50
aWNzIG9mIHRoZSAiZml4bWFwIi4gKHdoYXRldmVyIHRoYXQgaXMgOikgKSBJIGRvbid0IHNlZQ0K
PiBhbnl0aGluZyBzaW1pbGFyIGhhcHBlbiBvbiBvdGhlciBhcmNocywgZXNwZWNpYWxseSB4ODYt
NjQgYW5kIHMzOTB4LCB3aGljaA0KPiBJJ20gZmFtaWxpYXIgd2l0aC4NCj4gDQo+IHMzOTB4IHNp
bWlsYXJseSB0byB4ODYtNjQgY29kZSB1c2VzIGEgdm1lbV9tdXRleCB0byBzZXJpYWxpemUgYWRk
L3JlbW92ZQ0KPiBpbiB0aGUgZGlyZWN0IG1hcCBhbmQgYSBjcGFfbXV0ZXggdG8gc2VyaWFsaXpl
IGF0dHJpYnV0ZSBjaGFuZ2VzIChhbmQNCj4gc3BsaXR0aW5nIG9mIGxhcmdlIG1hcHBpbmdzKS4N
Cj4gDQoNClllYWgsIEkgc2VlIHRoYXQgdGhlcmUgaXMgYSBzcGluIGxvY2sgd2hlbiB1cGRhdGUg
cGFnZSB0YWJsZSBpbiB4ODYuDQpPSywgbGV0IG1lIHBva2UgQW5zaHVtYW4gYWJvdXQgdGhpcy4N
CklmIHRoaXMgaXNzdWUgd29uJ3QgYWZmZWN0IGFsbCBhcmNoZXMsIHNob3VsZCB3ZSBvbmx5IGZp
eCBpdCBvbiBhcm02ND8gQEFuc2h1bWFuIEtoYW5kdWFsDQoNClRoYW5rcw0KSmlhbnlvbmcNCg0K
DQo+IFRoZSByaWdodCBzaG91bGQgYmUgdG8gdGVhY2ggYXJtNjQgbW11IGNvZGUgdGhhdCBkaXJl
Y3QgbWFwcGluZyB1cGRhdGVzDQo+IG1pZ2h0IGJlIGNvbmN1cnJlbnQsIGFuZCB0aGF0IHR3byBp
bnN0YW5jZXMgbWlnaHQgdHJ5IG1lc3Npbmcgd2l0aCB0aGUNCj4gZml4bWFwIGNvbmN1cnJlbnRs
eS4NCj4gDQo+IA0KPiBPbiBhIHNpbWlsYXIgdG9waWM6IEkgdGhpbmsgd2UgbWlnaHQgd2FudCB0
byByZWNsYWltIGNvbXBlbHRlbHkgZW1wdHkgcGFnZQ0KPiB0YWJsZXMgd2hlbiB1bnBsdWdnaW5n
IG1lbW9yeTsgSSBzdXNwZWN0IHRoYXQgd2UgYWxzbyBoYXZlIHRvIG1lc3Mgd2l0aA0KPiB0aGUg
Zml4bWFwIHRoZW4sIHdoZW0gcmVtb3ZpbmcgcGFnZSB0YWJsZXMuIEJ1dCBJIGZlZWwgbGlrZSB0
aGUgd2hvbGUgZml4bWFwDQo+IG1hY2hpbmVyeSBpcyBzdGlsbCBhIGJpZyBibGFjayBib3ggZm9y
IG1lLg0KPiANCiANCj4gLS0NCj4gVGhhbmtzLA0KPiANCj4gRGF2aWQgLyBkaGlsZGVuYg0KDQo=
