Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67EB40A309
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbhINCHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:07:46 -0400
Received: from mail-eopbgr50052.outbound.protection.outlook.com ([40.107.5.52]:30597
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229754AbhINCHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d050h0Kqu0wEBTr9AJFDwGosNZ7lKBQxNHG0u4Ky0qA=;
 b=SK8wjGlXFwWdkqODuaim+L4PD6xHkGWcnw4Z+IUAnfYcddX3VMLtRlC1CS/6c4oZX6ecbsjiEN/bIs44azvBWVialFxtnTiUN/N5FPga9NAYyFFHrs2x8BlJ17TNMh0G9x/RqFqFqXEArUU71pF8RTRWvRE4n/kv4llWcuvKAXA=
Received: from DB6PR0601CA0040.eurprd06.prod.outlook.com (2603:10a6:4:17::26)
 by AM0PR08MB4545.eurprd08.prod.outlook.com (2603:10a6:208:138::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Tue, 14 Sep
 2021 02:06:26 +0000
Received: from DB5EUR03FT036.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:17:cafe::4f) by DB6PR0601CA0040.outlook.office365.com
 (2603:10a6:4:17::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Tue, 14 Sep 2021 02:06:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT036.mail.protection.outlook.com (10.152.20.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 02:06:26 +0000
Received: ("Tessian outbound b9598e0ead92:v103"); Tue, 14 Sep 2021 02:06:25 +0000
X-CR-MTA-TID: 64aa7808
Received: from eb91cf05f0ec.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 61FE3767-8EEF-452C-A0B8-85164C65E7EF.1;
        Tue, 14 Sep 2021 02:06:19 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id eb91cf05f0ec.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 14 Sep 2021 02:06:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0I8sGcdMdQaIilH3pvuElHAu4imgqg56VZg5ty9CNfe8HBfC560gmdwY8e4XimGNV234ny8C41np0yXKIDm1Z6ggj4KAHKx2SSbxCzlVIegEo3nBG0Y25L4WX2bh2oSF+ZnzD4vte6v/3s99U/FkwTAUs9aqELKBAkT4SBMMLap+Qdr9CAPlakQZb8lX43Qye4dfzMf+ULWLCwITAYEolWImnKGgB891WGP2GFhXNCB903O2EdTdtO/cac5kW2FicvVnlh3g0N/oC+LlOGNf5Yvpj8ITVbe98msvcazJUftXQ6TpfNpnrolZkcPq84D0A/IZN2Stw2FIhmsemUsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=d050h0Kqu0wEBTr9AJFDwGosNZ7lKBQxNHG0u4Ky0qA=;
 b=H+Mym5xQlNEbvDzsT70lAAJxXv04/7v21D+oGLX9I+e4Uh+7EDFtBoMzh88oQXtYB/tgFfO3qCccHhbzlfLZIluJ4kFqwcKslXIK8DE/B3EoCAiiVVeCx6YpmwqwaGz1os2+JFvAwOKFa75j4RHxjl1wNvyFTTvlMWNiQsvDOb3F/aBqv9TFmfNvMt//lJwlorWUWR5BtIQbr1G9lwBjwqYVBCgyl/oJ2+bzM3ezPGgNfdVKX6yvS/GVPmPdotTqRji6ZMurQckA2RO8x009cIPIoryg6XW3w2GnyZMnFw+VSCxWwfEMOAHmnoMhwa2g5LwrXUY/lTNPFM/3QFK7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d050h0Kqu0wEBTr9AJFDwGosNZ7lKBQxNHG0u4Ky0qA=;
 b=SK8wjGlXFwWdkqODuaim+L4PD6xHkGWcnw4Z+IUAnfYcddX3VMLtRlC1CS/6c4oZX6ecbsjiEN/bIs44azvBWVialFxtnTiUN/N5FPga9NAYyFFHrs2x8BlJ17TNMh0G9x/RqFqFqXEArUU71pF8RTRWvRE4n/kv4llWcuvKAXA=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM7PR08MB5431.eurprd08.prod.outlook.com (2603:10a6:20b:10c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Tue, 14 Sep
 2021 02:06:15 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::a443:3fd9:42c2:4b85]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::a443:3fd9:42c2:4b85%5]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 02:06:14 +0000
From:   Justin He <Justin.He@arm.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: RE: [PATCH v2] device-dax: use fallback nid when numa node is invalid
Thread-Topic: [PATCH v2] device-dax: use fallback nid when numa node is
 invalid
Thread-Index: AQHXpkHq3fUGFTWAeU2HoMoTrTsySKudaF6AgAViSaA=
Date:   Tue, 14 Sep 2021 02:06:14 +0000
Message-ID: <AM6PR08MB4376FC35158104629C603197F7DA9@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210910124628.6261-1-justin.he@arm.com>
 <CAPcyv4ie_ZzEwrrKJEVrDP19UWAgSiW3GU9f99EqX0e6BPQDPA@mail.gmail.com>
In-Reply-To: <CAPcyv4ie_ZzEwrrKJEVrDP19UWAgSiW3GU9f99EqX0e6BPQDPA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 42A923DEF837EE4086C58B23CD2C5CEA.0
x-checkrecipientchecked: true
Authentication-Results-Original: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: dd987132-5887-47d8-fc29-08d977244210
x-ms-traffictypediagnostic: AM7PR08MB5431:|AM0PR08MB4545:
X-Microsoft-Antispam-PRVS: <AM0PR08MB45458279E4DF5920A69D1719F7DA9@AM0PR08MB4545.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:5516;OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 27GWd5DKNDDkKr2qsMro88/JhZtifYM0E7EVMIxq2kpFesaOLQTwhuYVnOCjw0HyIJaA8RXzucQiSMenviXqM69ifYSTK4YV2bGt1MSPjIhuF2w5VkEvuA9AS3OGZG4c8M/0Iu7RjhHh20U1aqm1FHxx8MC4HsMbbwe+O9PnlBmyajnY9agnI51oA0bTZo3y9juEzKWFf7NAPrzF+3IIN26Emv2OGPcOxI0/QxLkr+XbDHKCLalyUzfLRfU53R+wd9IQ2jiSv1QrkGNw6/yvA7v8JcTbsSpIwnAmdoUN1fx0E1gNfT61k9LYDHubGbDK3QD/7byARV3kWok6ENzZ4b4juoAAjY5uqd2aeHgd183KDXGLrJtKsE1vRH0GdliLQs07db4d8Nb705NQ3N0mK/heA3V2yuFneveUcL8vdJvdoR3YnsQl6uO3XGmJGnb64z1+b3rTBHaFcsJ8sp376Gv0kLTmy0O6j7R+Z8cwMPBt7QJQgZqYbcxK0+CjcDqCB9i6NfJp3iEAkeNWlxCn3hbBIlb2Ecg1bAzpriXpnNPkAQHhuq4nE6MYDJMaXO20MTa6TnSUVeI1Yn8bnWbPfBjrzfFO7bJ0T7/etcbCM2WO6mZKjOS9NvXagggH7nhk4o6yYWHYnHK4E84+q+gx9H1WysQYsqNeVkoziVv5dPTCIjxTIp+Vaxcry3BXHck3QUe7ZwrYFyzushJ7Jkt06w==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(66946007)(76116006)(122000001)(64756008)(66556008)(66476007)(66446008)(9686003)(55016002)(26005)(86362001)(4326008)(8676002)(7696005)(316002)(6916009)(38100700002)(53546011)(2906002)(71200400001)(6506007)(5660300002)(33656002)(38070700005)(478600001)(8936002)(52536014)(186003)(54906003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5431
Original-Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT036.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0b61edd9-f762-46e4-fbbb-08d977243b73
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hgS1yJG+9P1lTtei6SUc6faI9ELvCethJmWqXkR7Qxs7IacLeaQxobSsWC8oiVr1COt0RGQYOlkh61e8fsuklqns1Ic1wUFBzaZE0QxiEUjwI7YwDGjuv0N6ybFEFcMF6RjD45bISZMV0a+CKyLy8V5Ty8L+HQArGrSZuTWTzTJx//C+PZ1Plp2HTB6fWlLEx1o2VLLMcmabGMlA2b78jjZGKjD9uRzhDDhgVXHEZS0z1WWYXPPYSw+K8ucLpeA74sC24CU0DE1oNKT9vwDRs9Ya68O9nqbH5m8g07xWpYfyTsYGFysxJX6iRHBfuKPKWsglnRwym8DoxvOaPIqR7lGm9hBcvMbr0IPJmYFPs3WgG2VEMmvRCktICK001utNUZBqxKA5Cj3KCcXe/RjQEWLdwbKMpS5P6UQDJQKdeUnfQMTb6zVJW5oOWofW6jqf8e0P2ouQuc3KKI2ZPc0QPkWktQP2mPikUROeSp8KdSXwpaSGLY9P3yjDYuKKRfe2YORyIJFDO8Z+KvKRVS0WsT2nbBBVVo+ml/SC4DTcag0gWpAGbnTC/esYtiG7C3f3y9RrER0gGQMCbA5K4liGBloSKzUDe1XzmSN1MirQZF+BXX0uLIzLTSiUojT6ALwyAjI2K0+e2qBpaVCVbNZVXT/8idUXVlpQ34BhkZgj7RliCWjRfjGugJ6mqZNhqNsUaj7EOVgQ+sMyOAgkBBOM9g==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(55016002)(54906003)(5660300002)(26005)(336012)(7696005)(9686003)(4326008)(8936002)(186003)(36860700001)(83380400001)(8676002)(356005)(53546011)(6506007)(86362001)(47076005)(52536014)(316002)(81166007)(70586007)(70206006)(2906002)(33656002)(508600001)(6862004)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 02:06:26.0423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd987132-5887-47d8-fc29-08d977244210
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT036.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4545
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbiBXaWxs
aWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiBTZW50OiBGcmlkYXksIFNlcHRlbWJl
ciAxMCwgMjAyMSAxMTo0MiBQTQ0KPiBUbzogSnVzdGluIEhlIDxKdXN0aW4uSGVAYXJtLmNvbT4N
Cj4gQ2M6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPjsgRGF2ZSBKaWFu
Zw0KPiA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+OyBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVk
aGF0LmNvbT47IExpbnV4IE5WRElNTQ0KPiA8bnZkaW1tQGxpc3RzLmxpbnV4LmRldj47IExpbnV4
IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBkZXZpY2UtZGF4OiB1c2UgZmFsbGJhY2sgbmlkIHdo
ZW4gbnVtYSBub2RlIGlzDQo+IGludmFsaWQNCj4gDQo+IE9uIEZyaSwgU2VwIDEwLCAyMDIxIGF0
IDU6NDYgQU0gSmlhIEhlIDxqdXN0aW4uaGVAYXJtLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBQcmV2
aW91c2x5LCBudW1hX29mZiB3YXMgc2V0IHVuY29uZGl0aW9uYWxseSBpbiBkdW1teV9udW1hX2lu
aXQoKQ0KPiA+IGV2ZW4gd2l0aCBhIGZha2UgbnVtYSBub2RlLiBUaGVuIEFDUEkgc2V0cyBub2Rl
IGlkIGFzIE5VTUFfTk9fTk9ERSgtMSkNCj4gPiBhZnRlciBhY3BpX21hcF9weG1fdG9fbm9kZSgp
IGJlY2F1c2UgaXQgcmVnYXJkcyBudW1hX29mZiBhcyB0dXJuaW5nDQo+ID4gb2ZmIHRoZSBudW1h
IG5vZGUuIEhlbmNlIGRldl9kYXgtPnRhcmdldF9ub2RlIGlzIE5VTUFfTk9fTk9ERSBvbg0KPiA+
IGFybTY0IHdpdGggZmFrZSBudW1hIGNhc2UuDQo+ID4NCj4gPiBXaXRob3V0IHRoaXMgcGF0Y2gs
IHBtZW0gY2FuJ3QgYmUgcHJvYmVkIGFzIFJBTSBkZXZpY2VzIG9uIGFybTY0IGlmDQo+ID4gU1JB
VCB0YWJsZSBpc24ndCBwcmVzZW50Og0KPiA+ICAgJG5kY3RsIGNyZWF0ZS1uYW1lc3BhY2UgLWZl
IG5hbWVzcGFjZTAuMCAtLW1vZGU9ZGV2ZGF4IC0tbWFwPWRldiAtcyAxZw0KPiAtYSA2NEsNCj4g
PiAgIGttZW0gZGF4MC4wOiByZWplY3RpbmcgREFYIHJlZ2lvbiBbbWVtIDB4MjQwNDAwMDAwLTB4
MmJmZmZmZmZmXSB3aXRoDQo+IGludmFsaWQgbm9kZTogLTENCj4gPiAgIGttZW06IHByb2JlIG9m
IGRheDAuMCBmYWlsZWQgd2l0aCBlcnJvciAtMjINCj4gPg0KPiA+IFRoaXMgZml4ZXMgaXQgYnkg
dXNpbmcgZmFsbGJhY2sgbWVtb3J5X2FkZF9waHlzYWRkcl90b19uaWQoKSBhcyBuaWQuDQo+ID4N
Cj4gPiBTdWdnZXN0ZWQtYnk6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEppYSBIZSA8anVzdGluLmhlQGFybS5jb20+DQo+ID4gLS0tDQo+
ID4gdjI6IC0gcmViYXNlIGl0IGJhc2VkIG9uIERhdmlkJ3MgIm1lbW9yeSBncm91cCIgcGF0Y2gu
DQo+ID4gICAgIC0gZHJvcCB0aGUgY2hhbmdlcyBpbiBkZXZfZGF4X2ttZW1fcmVtb3ZlKCkgc2lu
Y2UgbmlkIGhhZCBiZWVuDQo+ID4gICAgICAgcmVtb3ZlZCBpbiByZW1vdmVfbWVtb3J5KCkuDQo+
ID4gIGRyaXZlcnMvZGF4L2ttZW0uYyB8IDMxICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZGF4L2ttZW0uYyBiL2RyaXZlcnMvZGF4
L2ttZW0uYw0KPiA+IGluZGV4IGEzNzYyMjA2MGZmZi4uZTQ4MzZlYjc1MzllIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvZGF4L2ttZW0uYw0KPiA+ICsrKyBiL2RyaXZlcnMvZGF4L2ttZW0uYw0K
PiA+IEBAIC00NywyMCArNDcsNyBAQCBzdGF0aWMgaW50IGRldl9kYXhfa21lbV9wcm9iZShzdHJ1
Y3QgZGV2X2RheCAqZGV2X2RheCkNCj4gPiAgICAgICAgIHVuc2lnbmVkIGxvbmcgdG90YWxfbGVu
ID0gMDsNCj4gPiAgICAgICAgIHN0cnVjdCBkYXhfa21lbV9kYXRhICpkYXRhOw0KPiA+ICAgICAg
ICAgaW50IGksIHJjLCBtYXBwZWQgPSAwOw0KPiA+IC0gICAgICAgaW50IG51bWFfbm9kZTsNCj4g
PiAtDQo+ID4gLSAgICAgICAvKg0KPiA+IC0gICAgICAgICogRW5zdXJlIGdvb2QgTlVNQSBpbmZv
cm1hdGlvbiBmb3IgdGhlIHBlcnNpc3RlbnQgbWVtb3J5Lg0KPiA+IC0gICAgICAgICogV2l0aG91
dCB0aGlzIGNoZWNrLCB0aGVyZSBpcyBhIHJpc2sgdGhhdCBzbG93IG1lbW9yeQ0KPiA+IC0gICAg
ICAgICogY291bGQgYmUgbWl4ZWQgaW4gYSBub2RlIHdpdGggZmFzdGVyIG1lbW9yeSwgY2F1c2lu
Zw0KPiA+IC0gICAgICAgICogdW5hdm9pZGFibGUgcGVyZm9ybWFuY2UgaXNzdWVzLg0KPiA+IC0g
ICAgICAgICovDQo+ID4gLSAgICAgICBudW1hX25vZGUgPSBkZXZfZGF4LT50YXJnZXRfbm9kZTsN
Cj4gPiAtICAgICAgIGlmIChudW1hX25vZGUgPCAwKSB7DQo+ID4gLSAgICAgICAgICAgICAgIGRl
dl93YXJuKGRldiwgInJlamVjdGluZyBEQVggcmVnaW9uIHdpdGggaW52YWxpZA0KPiBub2RlOiAl
ZFxuIiwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG51bWFfbm9kZSk7DQo+
ID4gLSAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+IC0gICAgICAgfQ0KPiA+ICsg
ICAgICAgaW50IG51bWFfbm9kZSA9IGRldl9kYXgtPnRhcmdldF9ub2RlOw0KPiA+DQo+ID4gICAg
ICAgICBmb3IgKGkgPSAwOyBpIDwgZGV2X2RheC0+bnJfcmFuZ2U7IGkrKykgew0KPiA+ICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgcmFuZ2UgcmFuZ2U7DQo+ID4gQEAgLTcxLDYgKzU4LDIyIEBAIHN0
YXRpYyBpbnQgZGV2X2RheF9rbWVtX3Byb2JlKHN0cnVjdCBkZXZfZGF4ICpkZXZfZGF4KQ0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpLCByYW5nZS5zdGFydCwg
cmFuZ2UuZW5kKTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gPiAg
ICAgICAgICAgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgLyoNCj4gPiArICAg
ICAgICAgICAgICAgICogRW5zdXJlIGdvb2QgTlVNQSBpbmZvcm1hdGlvbiBmb3IgdGhlIHBlcnNp
c3RlbnQNCj4gbWVtb3J5Lg0KPiA+ICsgICAgICAgICAgICAgICAgKiBXaXRob3V0IHRoaXMgY2hl
Y2ssIHRoZXJlIGlzIGEgcmlzayBidXQgbm90IGZhdGFsDQo+IHRoYXQgc2xvdw0KPiA+ICsgICAg
ICAgICAgICAgICAgKiBtZW1vcnkgY291bGQgYmUgbWl4ZWQgaW4gYSBub2RlIHdpdGggZmFzdGVy
IG1lbW9yeSwNCj4gY2F1c2luZw0KPiA+ICsgICAgICAgICAgICAgICAgKiB1bmF2b2lkYWJsZSBw
ZXJmb3JtYW5jZSBpc3N1ZXMuIFdhcm4gdGhpcyBhbmQgdXNlDQo+IGZhbGxiYWNrDQo+ID4gKyAg
ICAgICAgICAgICAgICAqIG5vZGUgaWQuDQo+ID4gKyAgICAgICAgICAgICAgICAqLw0KPiA+ICsg
ICAgICAgICAgICAgICBpZiAobnVtYV9ub2RlIDwgMCkgew0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGludCBuZXdfbm9kZSA9DQo+IG1lbW9yeV9hZGRfcGh5c2FkZHJfdG9fbmlkKHJhbmdl
LnN0YXJ0KTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZGV2X2luZm8oZGV2
LCAiY2hhbmdpbmcgbmlkIGZyb20gJWQgdG8gJWQgZm9yDQo+IERBWCByZWdpb24gWyUjbGx4LSUj
bGx4XVxuIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBudW1hX25vZGUs
IG5ld19ub2RlLCByYW5nZS5zdGFydCwNCj4gcmFuZ2UuZW5kKTsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICBudW1hX25vZGUgPSBuZXdfbm9kZTsNCj4gPiArICAgICAgICAgICAgICAgfQ0K
PiA+ICsNCj4gPiAgICAgICAgICAgICAgICAgdG90YWxfbGVuICs9IHJhbmdlX2xlbigmcmFuZ2Up
Ow0KPiANCj4gVGhpcyBmYWxsYmFjayBjaGFuZ2UgYmVsb25ncyB3aGVyZSB0aGUgcGFyZW50IHJl
Z2lvbiBmb3IgdGhlIG5hbWVzcGFjZQ0KPiBhZG9wdHMgaXRzIHRhcmdldF9ub2RlLCBiZWNhdXNl
IGl0J3Mgbm90IGNsZWFyDQo+IG1lbW9yeV9hZGRfcGh5c2FkZHJfdG9fbmlkKCkgaXMgdGhlIHJp
Z2h0IGZhbGxiYWNrIGluIGFsbCBzaXR1YXRpb25zLg0KPiBIZXJlIGlzIHdoZXJlIHRoaXMgc2V0
dGluZyBpcyBoYXBwZW5pbmcgY3VycmVudGx5Og0KPiANCj4gZHJpdmVycy9hY3BpL25maXQvY29y
ZS5jOjMwMDQ6ICAgICAgICAgIG5kcl9kZXNjLT50YXJnZXRfbm9kZSA9DQo+IHB4bV90b19ub2Rl
KHNwYS0+cHJveGltaXR5X2RvbWFpbik7DQpPbiBteSBsb2NhbCBhcm02NCBndWVzdCgndmlydCcg
bWFjaGluZSB0eXBlKSwgdGhlIHRhcmdldF9ub2RlIGlzDQpzZXQgdG8gLTEgYXQgdGhpcyBsaW5l
Lg0KVGhhdCBpczoNClRoZSBjb25kaXRpb24gInNwYS0+ZmxhZ3MgJiBBQ1BJX05GSVRfUFJPWElN
SVRZX1ZBTElEIiBpcyBoaXQuDQoNCj4gZHJpdmVycy9hY3BpL25maXQvY29yZS5jOjMwMDc6ICAg
ICAgICAgIG5kcl9kZXNjLT50YXJnZXRfbm9kZSA9DQo+IE5VTUFfTk9fTk9ERTsNCj4gZHJpdmVy
cy9udmRpbW0vZTgyMC5jOjI5OiAgICAgICBuZHJfZGVzYy50YXJnZXRfbm9kZSA9IG5pZDsNCj4g
ZHJpdmVycy9udmRpbW0vb2ZfcG1lbS5jOjU4OiAgICAgICAgICAgIG5kcl9kZXNjLnRhcmdldF9u
b2RlID0NCj4gbmRyX2Rlc2MubnVtYV9ub2RlOw0KPiBkcml2ZXJzL252ZGltbS9yZWdpb25fZGV2
cy5jOjExMjc6ICAgICAgbmRfcmVnaW9uLT50YXJnZXRfbm9kZSA9DQo+IG5kcl9kZXNjLT50YXJn
ZXRfbm9kZTsNCg0KDQpTb3JyeSxEYW4uIEkgdGhvdWdodCBJIG1pc3NlZCB5b3VyIHByZXZpb3Vz
IG1haWw6DQoNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpMb29r
cyBsaWtlIGl0IGlzIHRoZSBORklUIGRyaXZlciwgdGhhbmtzLg0KDQpJZiB5b3UncmUgZ2V0dGlu
ZyBOVU1BX05PX05PREUgaW4gZGF4X2ttZW0gZnJvbSB0aGUgTkZJVCBkcml2ZXIgaW4NCm1lYW5z
IHlvdXIgQUNQSSBORklUIHRhYmxlIGlzIGZhaWxpbmcgdG8gcG9wdWxhdGUgY29ycmVjdCBudW1h
DQppbmZvcm1hdGlvbi4gWW91IGNvdWxkIHRyeSB0aGUgZm9sbG93aW5nIHRvIGZpeCBpdCB1cCwg
YnV0IEkgdGhpbmsgdGhlDQpyZWFsIHByb2JsZW0gaXMgdGhhdCB5b3VyIHBsYXRmb3JtIEJJT1Mg
bmVlZHMgdG8gYWRkIHRoZSBwcm9wZXIgbnVtYQ0KZGF0YS4NCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYWNwaS9uZml0L2NvcmUuYyBiL2RyaXZlcnMvYWNwaS9uZml0L2NvcmUuYw0KaW5kZXggZmI3
NzViOTY3YzUyLi5kM2EwY2VjNjM1YjEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2FjcGkvbmZpdC9j
b3JlLmMNCisrKyBiL2RyaXZlcnMvYWNwaS9uZml0L2NvcmUuYw0KQEAgLTMwMDUsMTUgKzMwMDUs
OCBAQCBzdGF0aWMgaW50IGFjcGlfbmZpdF9yZWdpc3Rlcl9yZWdpb24oc3RydWN0DQphY3BpX25m
aXRfZGVzYyAqYWNwaV9kZXNjLA0KICAgICAgICBuZHJfZGVzYy0+cmVzID0gJnJlczsNCiAgICAg
ICAgbmRyX2Rlc2MtPnByb3ZpZGVyX2RhdGEgPSBuZml0X3NwYTsNCiAgICAgICAgbmRyX2Rlc2Mt
PmF0dHJfZ3JvdXBzID0gYWNwaV9uZml0X3JlZ2lvbl9hdHRyaWJ1dGVfZ3JvdXBzOw0KLSAgICAg
ICBpZiAoc3BhLT5mbGFncyAmIEFDUElfTkZJVF9QUk9YSU1JVFlfVkFMSUQpIHsNCi0gICAgICAg
ICAgICAgICBuZHJfZGVzYy0+bnVtYV9ub2RlID0gYWNwaV9tYXBfcHhtX3RvX29ubGluZV9ub2Rl
KA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3BhLT5w
cm94aW1pdHlfZG9tYWluKTsNCi0gICAgICAgICAgICAgICBuZHJfZGVzYy0+dGFyZ2V0X25vZGUg
PSBhY3BpX21hcF9weG1fdG9fbm9kZSgNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c3BhLT5wcm94aW1pdHlfZG9tYWluKTsNCi0gICAgICAgfSBlbHNlIHsNCi0gICAgICAgICAgICAg
ICBuZHJfZGVzYy0+bnVtYV9ub2RlID0gTlVNQV9OT19OT0RFOw0KLSAgICAgICAgICAgICAgIG5k
cl9kZXNjLT50YXJnZXRfbm9kZSA9IE5VTUFfTk9fTk9ERTsNCi0gICAgICAgfQ0KKyAgICAgICBu
ZHJfZGVzYy0+bnVtYV9ub2RlID0gbWVtb3J5X2FkZF9waHlzYWRkcl90b19uaWQoc3BhLT5hZGRy
ZXNzKTsNCisgICAgICAgbmRyX2Rlc2MtPnRhcmdldF9ub2RlID0gcGh5c190b190YXJnZXRfbm9k
ZShzcGEtPmFkZHJlc3MpOw0KDQogICAgICAgIC8qDQogICAgICAgICAqIFBlcnNpc3RlbmNlIGRv
bWFpbiBiaXRzIGFyZSBoaWVyYXJjaGljYWwsIGlmDQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0NCg0KRG8geW91IHN0aWxsIHN1Z2dlc3QgZml4aW5n
IGxpa2UgdGhpcz8NCg0KDQotLQ0KQ2hlZXJzLA0KSnVzdGluIChKaWEgSGUpDQoNCg0KDQo=
