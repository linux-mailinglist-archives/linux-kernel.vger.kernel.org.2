Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F1144FCDB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 03:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbhKOCKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 21:10:41 -0500
Received: from mail-eopbgr30040.outbound.protection.outlook.com ([40.107.3.40]:47966
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229453AbhKOCKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 21:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0ZeQxsL8CZSzcxN+vZq3bppUQnyaCJ1dl66BuwW1Wk=;
 b=XSOX42EFwQJ7rl6mkDM2B5SapT8T9ZGOuwiYw/vb/5QvpgOGr0e/LW58BImGKZlUQYgKwjfOpQZ7aH1gkkL4ov00hPw2yHQ44LphatfNsLcnalnTODjdW2XNaakJzalQNURmz9pBEYqVlMihahrguDWWjiOmifYWqudTGJh+NYc=
Received: from AS8PR04CA0128.eurprd04.prod.outlook.com (2603:10a6:20b:127::13)
 by AM0PR08MB3123.eurprd08.prod.outlook.com (2603:10a6:208:5b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Mon, 15 Nov
 2021 02:07:41 +0000
Received: from AM5EUR03FT034.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:127:cafe::a9) by AS8PR04CA0128.outlook.office365.com
 (2603:10a6:20b:127::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Mon, 15 Nov 2021 02:07:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT034.mail.protection.outlook.com (10.152.16.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.20 via Frontend Transport; Mon, 15 Nov 2021 02:07:41 +0000
Received: ("Tessian outbound 892d2780d3aa:v109"); Mon, 15 Nov 2021 02:07:40 +0000
X-CR-MTA-TID: 64aa7808
Received: from db262cc02957.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 18906442-D0D9-4861-A7EA-E0615138ED09.1;
        Mon, 15 Nov 2021 02:07:30 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id db262cc02957.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 15 Nov 2021 02:07:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+jlUelYNC+Wwfc4C42akRaPHQUVTi22f4fHcxHN2nszYkvhhwxFSaZhPFzaPPNrR1uK/TO0SanKifTEmYgVrDF25PgGAsihMQig81FtcTvsCEc6HcrdhidGNZS5t/vjhbmdClu1R34BA8xug3C8djDTP6MZES4fgcGpPJy8ojRTW1OPdA2cUXXvab/NSDSn01KOdnriPz3i7L1oeEJiQAUUNDnP7MsSbLlRk1xH2DZd5DJT3y7k9QnLpYKPVd7RjioeAzxF+4SGGFRCGqYVgLEkrPFBGn834BBILw/Rre9VL/4CszjPvKAYxOO2StF9yDBpR9LWyepCImcoCwEtdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0ZeQxsL8CZSzcxN+vZq3bppUQnyaCJ1dl66BuwW1Wk=;
 b=NpXYaRUaisvYnEq/lfqd/vjrFAWMAb5LIU9sssXEuQTRC8BjW1V2A16V+kCsMXibyS0uVwjJuxZuh13xl0Ym8e5HbYknAQYDupWDyEROA1gjzUYGk0m5qO4xu76udBSUSp2SfVyXM8m7KNsFUkQe3iAtpJdbgQeIadtUTc2GRVxIKBbKNqg/2EB9cGRppv1gIMBOqZ6NtpeeBPqn0SAQgWT1fxBShJSmJrecRhZqFmB6ti/gpjuX45FqG+y1Fk8ZUbbdO5LXdsxYh4ybD8n0p9HONDc2Wa8isDjUPcaow+Ti1e23NrIf6yqQMPbMXftGQoeTjG+jqD/vAB5b5dQSVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0ZeQxsL8CZSzcxN+vZq3bppUQnyaCJ1dl66BuwW1Wk=;
 b=XSOX42EFwQJ7rl6mkDM2B5SapT8T9ZGOuwiYw/vb/5QvpgOGr0e/LW58BImGKZlUQYgKwjfOpQZ7aH1gkkL4ov00hPw2yHQ44LphatfNsLcnalnTODjdW2XNaakJzalQNURmz9pBEYqVlMihahrguDWWjiOmifYWqudTGJh+NYc=
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com (2603:10a6:20b:437::11)
 by AM9PR08MB7244.eurprd08.prod.outlook.com (2603:10a6:20b:433::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19; Mon, 15 Nov
 2021 02:07:28 +0000
Received: from AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::89be:706d:4ae6:fd14]) by AM9PR08MB7276.eurprd08.prod.outlook.com
 ([fe80::89be:706d:4ae6:fd14%3]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 02:07:28 +0000
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
Thread-Index: AQHXyxfjckbZs45/jUaWUxeL4pEnmavn60UAgAAWg/CAG/MBIA==
Date:   Mon, 15 Nov 2021 02:07:28 +0000
Message-ID: <AM9PR08MB7276BFDE8FF0BE1BC6F9317DF4989@AM9PR08MB7276.eurprd08.prod.outlook.com>
References: <20211027094828.7629-1-jianyong.wu@arm.com>
 <1cd8e875-24b1-2904-4e9f-2a4eb13674dc@arm.com>
 <AM9PR08MB72767A6DFA5A7ED8117E7C44F4869@AM9PR08MB7276.eurprd08.prod.outlook.com>
In-Reply-To: <AM9PR08MB72767A6DFA5A7ED8117E7C44F4869@AM9PR08MB7276.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 8B883AE53474274B9931355CDE43C2CC.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 6216e6ce-5700-4da0-b672-08d9a7dcb471
x-ms-traffictypediagnostic: AM9PR08MB7244:|AM0PR08MB3123:
X-Microsoft-Antispam-PRVS: <AM0PR08MB3123890E7835FCA4DF806C1EF4989@AM0PR08MB3123.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: m3I2xFHGVUHT8nCPpiKJlY8vUh1RxkMhGKepFMMjROivc402Qzw3F5xgxcoMGFn4Gc0bemBqTzCGK0WG8bxc293bKpfYjpTfZJoyV/qv1O0yiyXYs6CEp+y7diaBzb4jMPO+vCF30ik3vGKYJcnbmQ53nf+ofmDHysqjYBNYpNVVNahf8tjyUON9tmbBmA6X59dyo8CiosJhRPfi7xggM4i4NPX9H14SnuDwhBHtvM64zwzaOQ3vyMpu1gKIgN/ujZP+fGviO+VcBGWy6h4ws3VYuso/om344jexKk3A4Bn6MHNw2Bj+cq1BN+OrHqdkmtDUHDeRQblxgS7zAg5IsnTliwd0ucyvD5mPoT0kaDfUUDU9OFnciXz4xruaKYRA0MWz5nL59PPkg3hxLpwRQvoi0z2clSKz37I4GSDP4W5oarnDWcuEmdNhjuzz2U3zAKDHsUsxrlf5698lNDA36O8wBBJtBBE0Fei0hZJJ9yH8Ck954hR5GrwLqoRD4d29cYfUID33RFBeDiw1KPkQz2HztRNJHIhdRsKaxL/3hANv+qF1BVKK8bK1epaBg86VqhZgD2+v53Z6DQKCKr5nqk0cU1+y5tFk0BOJWaRzatkgmyju+QIaDcx5vWTuGJBqCbF6c7HJtnFQRh1eVl5jDjw/fWszCZubDzWHDWjY5zS6P+HK+3KcLr/AW6POcV1qFPvuj038rFvy8ykugZqCSQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7276.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(52536014)(54906003)(316002)(122000001)(5660300002)(33656002)(110136005)(4326008)(8936002)(8676002)(2906002)(9686003)(55016002)(66556008)(64756008)(66946007)(66446008)(66476007)(76116006)(83380400001)(15650500001)(6506007)(71200400001)(38070700005)(53546011)(186003)(7696005)(86362001)(508600001)(26005);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB7244
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: e0a87bb9-0ec5-41ce-8ac9-08d9a7dcacea
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ORFf6mcOtfejIoc9ZcWzVa5cQZhq3TkEhG6UInQ8RXunbbi/xxBQOLC53n9d8NFKDfurbpvNq0JTGgWLD0oRhZ8PaPmnxZCCNtc7CCNrA4dPR056RgGDEqRu8iZhp6lHzmSYPI66SItjh3lkToajdJ7c+94EHTFHtk9ehnuO0ZpSs4tc5dKSpoCgAhRTYA32x4/MdmtD2TwPFSFVdQKRAHXVBgxxQW1o4n7NW58T/e6nnZkuDfQJLcg9HCKxVR+62O64QU87BzFfJTvll9SiV+IXFzc1CNO6HFtyfSrJm0QqHT7Ihq15bcozim8wMKDpQjl+5tM6TuugY+Wgk/o2FG9Yu4PWFTcPCeNnYeCZDa98IbSb3orcMoCcAgB+pNHMOtPtiHIJ44i9KjIyhuVO+L0f1C7RPjctlpcG7DnxP5JhkXZqsWByden0c01hUxgjuP+0YXug5tSnVFbsmrfWG+KNEu6HgyfyHfggeGAVOsr5sPwVdSSjteBYO8bJW9dShw5Rt7lSnt0WhlJL0KeZRMAh5o0NKmcD5f5it8ei2HIup3y78pKZ1o2i8nI+RhdViwve/i289JSuUM9CsYdLBLut0Fd3gkgoHfbUt1XJdo3s1HTpK4feDFrFnjis9ClRmhUHlgRoUA0DBuxsFA92xYDV/Df83QX4eJ3b/kbMQcoqpEFfRo2P7aWBy6c6q6bn2Fm6nsV5AAiXZ739eT5VLw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36860700001)(186003)(110136005)(9686003)(316002)(70586007)(33656002)(356005)(6506007)(54906003)(508600001)(5660300002)(70206006)(26005)(8676002)(82310400003)(4326008)(83380400001)(8936002)(81166007)(52536014)(86362001)(336012)(7696005)(15650500001)(2906002)(55016002)(53546011)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 02:07:41.0801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6216e6ce-5700-4da0-b672-08d9a7dcb471
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZyAuLi4NCkFueSBjb21tZW50cz8NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBKaWFueW9uZyBXdQ0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAyOCwgMjAyMSAz
OjM2IFBNDQo+IFRvOiBBbnNodW1hbiBLaGFuZHVhbCA8YW5zaHVtYW4ua2hhbmR1YWxAYXJtLmNv
bT47IENhdGFsaW4gTWFyaW5hcw0KPiA8Q2F0YWxpbi5NYXJpbmFzQGFybS5jb20+OyB3aWxsQGtl
cm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbWF6QGtlcm5lbC5vcmc7IGFyZGJAa2VybmVs
Lm9yZzsgZGF2aWRAcmVkaGF0LmNvbTsgZ3NoYW5AcmVkaGF0LmNvbTsNCj4gSnVzdGluIEhlIDxK
dXN0aW4uSGVAYXJtLmNvbT47IG5kIDxuZEBhcm0uY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENI
IHYxXSBhcm02NC9tbTogYXZvaWQgcmFjZSBjb25kaXRpb24gb2YgdXBkYXRlIHBhZ2UNCj4gdGFi
bGUgd2hlbiBrZXJuZWwgaW5pdA0KPiANCj4gSGkgQW5zaHVtYW4sDQo+IA0KPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogQW5zaHVtYW4gS2hhbmR1YWwgPGFuc2h1bWFu
LmtoYW5kdWFsQGFybS5jb20+DQo+ID4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMjgsIDIwMjEg
MTo1OCBQTQ0KPiA+IFRvOiBKaWFueW9uZyBXdSA8SmlhbnlvbmcuV3VAYXJtLmNvbT47IENhdGFs
aW4gTWFyaW5hcw0KPiA+IDxDYXRhbGluLk1hcmluYXNAYXJtLmNvbT47IHdpbGxAa2VybmVsLm9y
Zw0KPiA+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPiBtYXpAa2VybmVsLm9yZzsgYXJkYkBrZXJu
ZWwub3JnOyBkYXZpZEByZWRoYXQuY29tOw0KPiBnc2hhbkByZWRoYXQuY29tOw0KPiA+IEp1c3Rp
biBIZSA8SnVzdGluLkhlQGFybS5jb20+OyBuZCA8bmRAYXJtLmNvbT4NCj4gPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYxXSBhcm02NC9tbTogYXZvaWQgcmFjZSBjb25kaXRpb24gb2YgdXBkYXRlIHBh
Z2UNCj4gPiB0YWJsZSB3aGVuIGtlcm5lbCBpbml0DQo+ID4NCj4gPg0KPiA+DQo+ID4gT24gMTAv
MjcvMjEgMzoxOCBQTSwgSmlhbnlvbmcgV3Ugd3JvdGU6DQo+ID4gPiBSYWNlIGNvbmRpdGlvbiBv
ZiBwYWdlIHRhYmxlIHVwZGF0ZSBjYW4gaGFwcGVuIGluIGtlcm5lbCBib290IHBlcmlvZA0KPiA+
ID4gYXMgYm90aCBvZiBtZW1vcnkgaG90cGx1ZyBhY3Rpb24gd2hlbiBrZXJuZWwgaW5pdCBhbmQg
dGhlDQo+ID4gPiBtYXJrX3JvZGF0YV9ybyBjYW4gdXBkYXRlIHBhZ2UgdGFibGUuIEZvciB2aXJ0
aW8tbWVtLCB0aGUgZnVuY3Rpb24NCj4gPiBleGN1dGUgZmxvdyBjaGFydCBpczoNCj4gPiA+DQo+
ID4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiBrZXJuZWxfaW5pdA0KPiA+ID4g
ICBrZXJuZWxfaW5pdF9mcmVlYWJsZQ0KPiA+ID4gICAgIC4uLg0KPiA+ID4gICAgICAgZG9faW5p
dGNhbGwNCj4gPiA+ICAgICAgICAgLi4uDQo+ID4gPiAgICAgICAgICAgbW9kdWxlX2luaXQgW0Fd
DQo+ID4gPg0KPiA+ID4gICAuLi4NCj4gPiA+ICAgbWFya19yZWFkb25seQ0KPiA+ID4gICAgIG1h
cmtfcm9kYXRhX3JvIFtCXQ0KPiA+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4g
dmlydGlvLW1lbSBjYW4gYmUgaW5pdGlhbGl6ZWQgYXQgW0FdIGFuZCBzcHdhbiBhIHdvcmtxdWV1
ZSB0byBhZGQNCj4gPiA+IG1lbW9yeSwgdGhlcmVmb3JlIHRoZSByYWNlIG9mIHVwZGF0ZSBwYWdl
IHRhYmxlIGNhbiBoYXBwZW4gaW5zaWRlIFtCXS4NCj4gPiA+DQo+ID4gPiBXaGF0J3MgbW9yZSwg
dGhlIHJhY2UgY29uZGl0aW9uIGNhbiBoYXBwZW4gZXZlbiBmb3IgQUNQSSBiYXNlZA0KPiA+ID4g
bWVtb3J5IGhvdHBsdWcsIGFzIGl0IGNhbiBidXJzdCBpbnRvIGtlcm5lbCBib290IHBlcmlvZCB3
aGlsZSBwYWdlDQo+ID4gPiB0YWJsZSBpcyB1cGRhdGluZyBpbnNpZGUgbWFya19yb2RhdGFfcm8u
DQo+ID4gPg0KPiA+ID4gVGhhdCdzIHdoeSBtZW1vcnkgaG90cGx1ZyBsb2NrIGlzIG5lZWRlZCB0
byBndWFyZCBtYXJrX3JvZGF0YV9ybyB0bw0KPiA+ID4gYXZvaWQgdGhlIHJhY2UgY29uZGl0aW9u
Lg0KPiA+ID4NCj4gPiA+IEl0IG1heSBvbmx5IGhhcHBlbiBpbiBhcm02NC4gQXMgZml4bWFwLCB3
aGljaCBpcyB0aGUgZ2xvYmFsDQo+ID4gPiByZXNvdXJjZSwgaXMgdXNlZCBpbiBwYWdlIHRhYmxl
IGNyZWF0aW5nLiBTbywgdGhlIGNoYW5nZSBpcyBvbmx5IGZvciBhcm02NC4NCj4gPiA+DQo+ID4g
PiBUaGUgZXJyb3Igb2Z0ZW4gb2NjdXJzIGluc2lkZSBhbGxvY19pbml0X3B1ZCgpIGluDQo+ID4g
PiBhcmNoL2FybTY0L21tL21tdS5jDQo+ID4gPg0KPiA+ID4gdGhlIHJhY2UgY29uZGl0aW9uIGZs
b3cgaXM6DQo+ID4gPg0KPiA+ID4gKioqKioqKioqKioqKioqIGJlZ2luICoqKioqKioqKioqKg0K
PiA+ID4NCj4gPiA+IGtlcmVubF9pbml0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dmlydGlvLW1lbSB3b3JrcXVldWUNCj4gPiA+ID09PT09PT09PSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgPT09PT09PT0NCj4gPiA+IGFsbG9jX2luaXRfcHVkKC4uLikNCj4gPiA+
ICAgcHVkcCA9IHB1ZF9zZXRfZml4bWFwX29mZnNldCguLikgICAgICAgICAgYWxsb2NfaW5pdF9w
dWQoLi4uKQ0KPiA+ID4gLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAuLi4NCj4gPiA+ICAgICBSRUFEX09OQ0UoKnB1ZHApIC8vT0shICAgICAgICAgICAgICAgICAg
ICBwdWRwID0gcHVkX3NldF9maXhtYXBfb2Zmc2V0KA0KPiA+ID4gLi4uICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAuLi4NCj4gPiA+ICAgcHVkX2NsZWFyX2ZpeG1hcCgp
IC8vZml4bWFwIGJyZWFrDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgUkVBRF9PTkNFKCpwdWRwKSAvL0NSQVNIIQ0KPiA+ID4NCj4gPiA+ICoqKioq
KioqKioqKioqKiogZW5kICoqKioqKioqKioqKioNCj4gPiA+DQo+ID4gPiBJIGNhdGNoIHRoZSBy
ZWxhdGVkIGVycm9yIHdoZW4gdGVzdCB2aXJ0aW8tbWVtIChhIG5ldyBtZW1vcnkgaG90cGx1Zw0K
PiA+ID4gZHJpdmVyKSBvbiBhcm02NC4NCj4gPiA+DQo+ID4gPiBIb3cgdG8gcmVwcm9kdWNlOg0K
PiA+ID4gKDEpIHByZXBhcmUgYSBrZXJuZWwgd2l0aCB2aXJ0aW8tbWVtIGVuYWJsZWQgb24gYXJt
NjQNCj4gPiA+ICgyKSBzdGFydCBhIFZNIHVzaW5nIENsb3VkIEh5cGVydmlzb3IgdXNpbmcgdGhl
IGtlcm5lbCBhYm92ZQ0KPiA+ID4gKDMpIGhvdHBsdWcgbWVtb3J5LCAyMEcgaW4gbXkgY2FzZSwg
d2l0aCB2aXJ0aW8tbWVtDQo+ID4gPiAoNCkgcmVib290IG9yIHN0YXJ0IGEgbmV3IGtlcm5lbCB1
c2luZyBrZXhlYw0KPiA+ID4NCj4gPiA+IFRlc3QgZm9yIHNlcnZlciB0aW1lcywgeW91IG1heSBm
aW5kIHRoZSBlcnJvciBiZWxvdzoNCj4gPiA+DQo+ID4gPiBbICAgIDEuMTMxMDM5XSBVbmFibGUg
dG8gaGFuZGxlIGtlcm5lbCBwYWdpbmcgcmVxdWVzdCBhdCB2aXJ0dWFsIGFkZHJlc3MNCj4gPiBm
ZmZmZmJmZmZkYTNiMTQwDQo+ID4gPiBbICAgIDEuMTM0NTA0XSBNZW0gYWJvcnQgaW5mbzoNCj4g
PiA+IFsgICAgMS4xMzU3MjJdICAgRVNSID0gMHg5NjAwMDAwNw0KPiA+ID4gWyAgICAxLjEzNjk5
MV0gICBFQyA9IDB4MjU6IERBQlQgKGN1cnJlbnQgRUwpLCBJTCA9IDMyIGJpdHMNCj4gPiA+IFsg
ICAgMS4xMzkxODldICAgU0VUID0gMCwgRm5WID0gMA0KPiA+ID4gWyAgICAxLjE0MDQ2N10gICBF
QSA9IDAsIFMxUFRXID0gMA0KPiA+ID4gWyAgICAxLjE0MTc1NV0gICBGU0MgPSAweDA3OiBsZXZl
bCAzIHRyYW5zbGF0aW9uIGZhdWx0DQo+ID4gPiBbICAgIDEuMTQzNzg3XSBEYXRhIGFib3J0IGlu
Zm86DQo+ID4gPiBbICAgIDEuMTQ0OTc2XSAgIElTViA9IDAsIElTUyA9IDB4MDAwMDAwMDcNCj4g
PiA+IFsgICAgMS4xNDY1NTRdICAgQ00gPSAwLCBXblIgPSAwDQo+ID4gPiBbICAgIDEuMTQ3ODE3
XSBzd2FwcGVyIHBndGFibGU6IDRrIHBhZ2VzLCA0OC1iaXQgVkFzLA0KPiA+IHBnZHA9MDAwMDAw
MDA0MjZmMjAwMA0KPiA+ID4gWyAgICAxLjE1MDU1MV0gW2ZmZmZmYmZmZmRhM2IxNDBdIHBnZD0w
MDAwMDAwMDQyZmZkMDAzLA0KPiA+IHA0ZD0wMDAwMDAwMDQyZmZkMDAzLCBwdWQ9MDAwMDAwMDA0
MmZmZTAwMywgcG1kPTAwMDAwMDAwNDJmZmYwMDMsDQo+ID4gcHRlPTAwMDAwMDAwMDAwMDAwMDAN
Cj4gPiA+IFsgICAgMS4xNTU3MjhdIEludGVybmFsIGVycm9yOiBPb3BzOiA5NjAwMDAwNyBbIzFd
IFNNUA0KPiA+ID4gWyAgICAxLjE1NzcyNF0gQ1BVOiAwIFBJRDogMSBDb21tOiBzd2FwcGVyLzAg
VGFpbnRlZDogRyAgICAgICAgIEMgICAgICAgIDUuMTUuMC0NCj4gPiByYzMrICMxMDANCj4gPiA+
IFsgICAgMS4xNjEwMDJdIEhhcmR3YXJlIG5hbWU6IGxpbnV4LGR1bW15LXZpcnQgKERUKQ0KPiA+
ID4gWyAgICAxLjE2MjkzOV0gcHN0YXRlOiA2MDQwMDAwNSAoblpDdiBkYWlmICtQQU4gLVVBTyAt
VENPIC1ESVQgLVNTQlMNCj4gPiBCVFlQRT0tLSkNCj4gPiA+IFsgICAgMS4xNjU4MjVdIHBjIDog
YWxsb2NfaW5pdF9wdWQrMHgzOGMvMHg1NTANCj4gPiA+IFsgICAgMS4xNjc2MTBdIGxyIDogYWxs
b2NfaW5pdF9wdWQrMHgzOTQvMHg1NTANCj4gPiA+IFsgICAgMS4xNjkzNThdIHNwIDogZmZmZjgw
MDAxMDAxYmQxMA0KPiA+ID4gLi4uLi4uDQo+ID4gPiBbICAgIDEuMjAwNTI3XSBDYWxsIHRyYWNl
Og0KPiA+ID4gWyAgICAxLjIwMTU4M10gIGFsbG9jX2luaXRfcHVkKzB4MzhjLzB4NTUwDQo+ID4g
PiBbICAgIDEuMjAzMjE4XSAgX19jcmVhdGVfcGdkX21hcHBpbmcrMHg5NC8weGUwDQo+ID4gPiBb
ICAgIDEuMjA0OTgzXSAgdXBkYXRlX21hcHBpbmdfcHJvdCsweDUwLzB4ZDgNCj4gPiA+IFsgICAg
MS4yMDY3MzBdICBtYXJrX3JvZGF0YV9ybysweDUwLzB4NTgNCj4gPiA+IFsgICAgMS4yMDgyODFd
ICBrZXJuZWxfaW5pdCsweDNjLzB4MTIwDQo+ID4gPiBbICAgIDEuMjA5NzYwXSAgcmV0X2Zyb21f
Zm9yaysweDEwLzB4MjANCj4gPiA+IFsgICAgMS4yMTEyOThdIENvZGU6IGViMTUwMDNmIDU0MDAw
MDYxIGQ1MDMzYTlmIGQ1MDMzZmRmIChmOTQwMDBhMSkNCj4gPiA+IFsgICAgMS4yMTM4NTZdIC0t
LVsgZW5kIHRyYWNlIDU5NDczNDEzZmZlM2Y1MmQgXS0tLQ0KPiA+ID4gWyAgICAxLjIxNTg1MF0g
S2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IEF0dGVtcHRlZCB0byBraWxsIGluaXQhDQo+ID4g
ZXhpdGNvZGU9MHgwMDAwMDAwYg0KPiA+ID4NCj4gPiA+IFdlIGNhbiBzZWUgdGhhdCB0aGUgZXJy
b3IgZGVyaXZlZCBmcm9tIHRoZSBsMyB0cmFuc2xhdGlvbiBhcyB0aGUgcHRlDQo+ID4gPiB2YWx1
ZSBpcyAqMCouIFRoYXQgaXMgYmVjYXVzZSB0aGUgZml4bWFwIGhhcyBiZWVuIGNsZWFyIHdoZW4g
YWNjZXNzLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEppYW55b25nIFd1IDxqaWFueW9u
Zy53dUBhcm0uY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgYXJjaC9hcm02NC9tbS9tbXUuYyB8IDIg
KysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvbW0vbW11LmMgYi9hcmNoL2FybTY0L21tL21tdS5jIGlu
ZGV4DQo+ID4gPiBjZmQ5ZGViMzQ3YzMuLjU2N2RmYmE4ZjA4YSAxMDA2NDQNCj4gPiA+IC0tLSBh
L2FyY2gvYXJtNjQvbW0vbW11LmMNCj4gPiA+ICsrKyBiL2FyY2gvYXJtNjQvbW0vbW11LmMNCj4g
PiA+IEBAIC01NjQsOCArNTY0LDEwIEBAIHZvaWQgbWFya19yb2RhdGFfcm8odm9pZCkNCj4gPiA+
ICAJICogdG8gY292ZXIgTk9URVMgYW5kIEVYQ0VQVElPTl9UQUJMRS4NCj4gPiA+ICAJICovDQo+
ID4gPiAgCXNlY3Rpb25fc2l6ZSA9ICh1bnNpZ25lZCBsb25nKV9faW5pdF9iZWdpbiAtICh1bnNp
Z25lZA0KPiA+ID4gbG9uZylfX3N0YXJ0X3JvZGF0YTsNCj4gPiA+ICsJZ2V0X29ubGluZV9tZW1z
KCk7DQo+ID4gPiAgCXVwZGF0ZV9tYXBwaW5nX3Byb3QoX19wYV9zeW1ib2woX19zdGFydF9yb2Rh
dGEpLCAodW5zaWduZWQNCj4gPiBsb25nKV9fc3RhcnRfcm9kYXRhLA0KPiA+ID4gIAkJCSAgICBz
ZWN0aW9uX3NpemUsIFBBR0VfS0VSTkVMX1JPKTsNCj4gPiA+ICsJcHV0X29ubGluZV9tZW1zKCk7
DQo+ID4gPg0KPiA+ID4gIAlkZWJ1Z19jaGVja3d4KCk7DQo+ID4gPiAgfQ0KPiA+ID4NCj4gPg0K
PiA+IFdoaWxlIHRoaXMgc2hvdWxkIHNvbHZlIHRoZSBjdXJyZW50IHByb2JsZW0gaS5lIHJhY2Ug
YmV0d2Vlbg0KPiA+IGNvbmN1cnJlbnQgbWVtb3J5IGhvdHBsdWcgb3BlcmF0aW9uIGFuZCBtYXJr
X3JvZGF0YV9ybygpLCBidXQgSSBhbQ0KPiA+IHN0aWxsIHdvbmRlcmluZyB3aGV0aGVyIHRoaXMg
aXMgdGhlIGZpeCBhdCB0aGUgcmlnaHQgcGxhY2UgYW5kDQo+ID4gZ3JhbnVsYXJpdHkuIEJhc2lj
YWxseSBhIGhvdHBsdWcgb3BlcmF0aW9uIHF1ZXVlZCBpbiBhbiB3b3JrIHF1ZXVlIGF0DQo+ID4g
W0FdIGNhbiBleGVjdXRlIGR1cmluZyBbQl0gaXMgdGhlIHJvb3QgY2F1c2Ugb2YgdGhpcyBwcm9i
bGVtLg0KPiA+DQo+IA0KPiBOb3QgZXhhY3RseSwgdGhpcyBpc3N1ZSBkb2Vzbid0IG9ubHkgaGFw
cGVuIGF0IHRoZSB0aGUgKnB1cmUqIGtlcm5lbCBib290Lg0KPiBGb3IgZXhhbXBsZSwgaG90cGx1
ZyBtZW1vcnkgdGhyb3VnaCBWTSBtb25pdG9yIHdoZW4gVk0gYm9vdC4gV2UgY2FuJ3QNCj4gZm9y
ZXNlZSB3aGVuIHRoYXQgaGFwcGVuLiBUaHVzLCB0aGlzIGlzc3VlIGNhbiBhZmZlY3QgYWxsIGtp
bmRzIG9mIG1lbW9yeQ0KPiBob3RwbHVnIG1lY2hhbmlzbSwgaW5jbHVkaW5nIEFDUEkgYmFzZWQg
bWVtb3J5IGhvdHBsdWcgYW5kIHZpcnRpby1tZW0uDQo+IEknbSBub3Qgc3VyZSB0aGF0IGZpeCBp
dCBoZXJlIGlzIHRoZSBiZXN0IHdheS4gSWYgdGhlIHJhY2Ugb25seSBoYXBwZW5zIGJldHdlZW4N
Cj4ga2VybmVsIGluaXQgYW5kIG1lbW9yeSBob3RwbHVnLCBJIHRoaW5rIGl0J3MgZmluZSB0byBm
aXggaXQgaGVyZS4NCj4gSU1PLCB0aGlzIGlzc3VlIHJlc3VsdHMgZnJvbSB0aGUgcmFjZSBmb3Ig
ImZpeG1hcCIgcmVzb3VyY2UuIEkgd29uZGVyIHdoeQ0KPiB0aGlzIGdsb2JhbCByZXNvdXJjZSBp
cyBub3QgcHJvdGVjdGVkIGJ5IGEgbG9jay4gTWF5YmUgd2UgY2FuIGFkZCBvbmUgYW5kIGZpeA0K
PiBpdCB0aGVyZS4NCj4gDQo+ID4gc3RhcnRfa2VybmVsKC4uKQ0KPiA+IHsNCj4gPg0KPiA+IGFy
Y2hfY2FsbF9yZXN0X2luaXQoLi4pDQo+ID4gcmVzdF9pbml0KC4uKQ0KPiA+IAlrZXJuZWxfdGhy
ZWFkKGtlcm5lbF9pbml0LCAuLi4pDQo+ID4gCQlrZXJuZWxfaW5pdCguLikgew0KPiA+IAkJCWtl
cm5lbF9pbml0X2ZyZWVhYmxlKC4uKQ0KPiA+IAkJCQlkb19iYXNpY19zZXR1cCguLikNCj4gPiAJ
CQkJCWRvX2luaXRjYWxscyguLikNCj4gPiAJCQkJCQkuLi4uLi4uLg0KPiA+IAkJCQkJCW1vZHVs
ZV9pbml0KC4uKSBbQV0NCj4gPiAJCQkuLi4uLi4uLi4uLi4uLi4uDQo+ID4gCQkJLi4uLi4uLi4u
Li4uLi4uLg0KPiA+IAkJCW1hcmtfcmVhZG9ubHkoLi4pDQo+ID4gCQkJCW1hcmtfcm9kYXRhX3Jv
KC4uKQ0KPiA+IAkJCQkJdXBkYXRlX21hcHBpbmdfcHJvdCguLikNCj4gPiAJCQkJCQlfX2NyZWF0
ZV9wZ2RfbWFwcGluZyguLikgW0JdDQo+ID4gCQkJfQ0KPiA+IH0NCj4gPg0KPiA+IEFyZSB0aGVy
ZSBubyBvdGhlciBub24taG90cGx1ZyBjYWxsIHBhdGggYWZ0ZXIgbW9kdWxlX2luaXQoKSwgd2hp
Y2gNCj4gPiBjb3VsZCBsYW5kIGluIF9fY3JlYXRlX3BnZF9tYXBwaW5nKCkgPw0KPiA+DQo+ID4g
UGxlYXNlIGFsc28gbm90ZSB0aGF0IHRoaXMgaXMgbm90IGFuIGV4aXN0aW5nIHByb2JsZW0gb24g
YXJtNjQNCj4gPiBwbGF0Zm9ybSB3aGljaCBuZWVkcyB0byBiZSBmaXhlZCwgYXMgdmlydGlvLW1l
bSBpcyB5ZXQgdG8gYmUgZW5hYmxlZC4NCj4gDQo+IFRoaXMgaXNzdWUgYWZmZWN0cyBhbGwga2lu
ZHMgb2YgbWVtb3J5IGhvdHBsdWcgbWVjaGFuaXNtLCBzbywgSSB0aGluayB0aGF0J3MNCj4gbm90
IHRoZSBidXN5bmVzcyB3aXRoIHZpcnRpby1tZW0gaXRzZWxmLg0KPiANCj4gVGhhbmtzDQo+IEpp
YW55b25nDQo=
