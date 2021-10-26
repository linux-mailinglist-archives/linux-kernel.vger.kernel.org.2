Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F38643AF9F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbhJZKCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:02:10 -0400
Received: from mail-eopbgr00066.outbound.protection.outlook.com ([40.107.0.66]:46466
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231937AbhJZKCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Cm63ANI/4WQOOYL0nfpEe0BCVUOgAcGdQS0zt2itOs=;
 b=UoORpYaYtQ55FWo8bxXNNVN4yPLWHmzkXZmy5LO9d5GiSY3AHZivTC/KaefkZDrA2CcaF+YJFXAwkPiWEjhMLvpDoy8AJiX5WsULsKml1afEx6tPN2H27hiPZKONVR7koYvCBxZ9PPRUK7ZP6YQwnpdcAtSLnNUzWDYFnNkYbHw=
Received: from AS8PR04CA0052.eurprd04.prod.outlook.com (2603:10a6:20b:312::27)
 by AM0PR08MB3201.eurprd08.prod.outlook.com (2603:10a6:208:59::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 09:59:42 +0000
Received: from AM5EUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:312:cafe::d6) by AS8PR04CA0052.outlook.office365.com
 (2603:10a6:20b:312::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Tue, 26 Oct 2021 09:59:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT013.mail.protection.outlook.com (10.152.16.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18 via Frontend Transport; Tue, 26 Oct 2021 09:59:42 +0000
Received: ("Tessian outbound e27daf245730:v103"); Tue, 26 Oct 2021 09:59:42 +0000
X-CR-MTA-TID: 64aa7808
Received: from fd2e5854a14c.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D6BB2F10-D3FA-492B-8EAE-FACCFC483AE9.1;
        Tue, 26 Oct 2021 09:59:36 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fd2e5854a14c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Oct 2021 09:59:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBNuaObu/dVDJ1wihGLYfTQPvbL7cA4WxPdGQEQjiSJhMtt6VY8d/yj2VEY06fMxk/Xzi35REFaz3YrBlXjAS0qxHIE5gE61XVonfnD1Wz2vsfTQ3H15YRRPg5A4oEK/y6LMUyTJHLGGj69s0e7StNqao0MXzHSc48rjAHoWLe9xf2LIpLkzwjRepzptMaX/CesDxUtIiogSZVbVKCNRB4uNdzXdcGw4oNY2s95xzSu/HBDOrEJk5WMFJMnwOHPymCp8+M5vK08ZOBPJC2MBYHp+RrqXYL8KD73fm30WBUrSROGpK7OF6aABrdbj6mufpLUnZE1Kzx9/GtLrMFN7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Cm63ANI/4WQOOYL0nfpEe0BCVUOgAcGdQS0zt2itOs=;
 b=VrQ+7iXJqx0l845Ybw104crtBEQsl+uOqPbAbGmeNJYz1jzkRKjRTXdYx+Dpc/r29dIkX+hd08MASKdxSNjhjrArVMWPqqtMjZ4+DshuvtgM+P4V5/WYxUuVuVBEd9fCx3n+N5C9MzIMVGhJ1wdd/kAYhnEgIAcBHxhfLDixRnSapslklGJbrOMOAi7LMbCVf+g0P36wN4ecSH5267VucUmZY71SMy5Sqi0kVOQSBRPZ6+paWgQczNK8bCHnIDtybZt+rl1NAKI3aDQGqtgjxnXoFf1jKjOHtTlydo1iqBQWpkbEuilAzLlzM6guHEeHURfnhi9IENmNvpZoR6vGYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Cm63ANI/4WQOOYL0nfpEe0BCVUOgAcGdQS0zt2itOs=;
 b=UoORpYaYtQ55FWo8bxXNNVN4yPLWHmzkXZmy5LO9d5GiSY3AHZivTC/KaefkZDrA2CcaF+YJFXAwkPiWEjhMLvpDoy8AJiX5WsULsKml1afEx6tPN2H27hiPZKONVR7koYvCBxZ9PPRUK7ZP6YQwnpdcAtSLnNUzWDYFnNkYbHw=
Received: from VI1PR08MB3056.eurprd08.prod.outlook.com (2603:10a6:803:3d::28)
 by VI1PR08MB3773.eurprd08.prod.outlook.com (2603:10a6:803:bb::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Tue, 26 Oct
 2021 09:59:34 +0000
Received: from VI1PR08MB3056.eurprd08.prod.outlook.com
 ([fe80::9528:d287:4b41:1ccc]) by VI1PR08MB3056.eurprd08.prod.outlook.com
 ([fe80::9528:d287:4b41:1ccc%4]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 09:59:34 +0000
From:   Jiamei Xie <Jiamei.Xie@arm.com>
To:     Juergen Gross <jgross@suse.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>
CC:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] xen: Fix implicit type conversion
Thread-Topic: [PATCH v2] xen: Fix implicit type conversion
Thread-Index: AQHXyjurcY7tN33IlE6GkuPKa9q2jKvk4+KAgAAnZaA=
Date:   Tue, 26 Oct 2021 09:59:34 +0000
Message-ID: <VI1PR08MB30564CABD02DBB0F17BBDCDD92849@VI1PR08MB3056.eurprd08.prod.outlook.com>
References: <1635233531-2437704-1-git-send-email-jiasheng@iscas.ac.cn>
 <01fd083e-e9a6-c019-0a74-bf28b2982412@suse.com>
In-Reply-To: <01fd083e-e9a6-c019-0a74-bf28b2982412@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: EA29A9CC81D4E14583D764E12361A4D9.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 226e1bef-6443-49bf-51c3-08d9986754eb
x-ms-traffictypediagnostic: VI1PR08MB3773:|AM0PR08MB3201:
X-Microsoft-Antispam-PRVS: <AM0PR08MB3201C701863DBCE30A895ABC92849@AM0PR08MB3201.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:6108;OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: uPAuM4Rgqb9FxKHTU4H2zurBOk2TCXHxY9Q86L58nGp0WTBRS0cXOAXPUNYzJuwOtOkZ2xwbF7mdcWtCYtFlXxaqCJQPzj+P9Ngx8sCvfTGXL3MqoRG6+4Z7q3EISFrFuuc52pGfnU4+04AQ2zaJGOhduQxThGmwqLNMPYoJWhqqW8MiWWliXrKvlK+6RqpdbYQfrQnC1Zqv4hZPUpNA4gKm4BaVks9IoSDeM1iY0GRoafBLq9XGHMskCh4HIEiQN+VjV7xYy+I2UCTPABOiQjiY7ae/PhZQw/JBs3IEEEm7N5DznZnFVwKxm8jOHj1VycWboJJsrizGPHtCKeAav+lKtgYX2vF08CeUOuEjEpt8Ozpd/ipSJWM5JIy6swWGDnoI1smSbhltRVdtO5fHKAB4PIdNRxDHbpZvXk5NmQWrTTrS+tjZyBM2g0zroEiqcslvMJCT5ygWJ/ohPtg0bx4x8/SsVu4WkxHodnHGUcOE4kl7YiDantXrgQ3hB2kMz95Lx9rMfFMheKXdAKCZ05s+YbKjGwhxIsGPKa2kRjLR1ej7Cbs7OCgkRycUG6FIMS0QUIomki9n/5pirm3SclZtuQHivDYeLkPWW0KfPPvdd2LnuW8VRs0ne4T7suJ5xTsaMcs4WJNbGY6c+Iqp2AGdUodgshygY0b96mvVfQ2JaaXeD1N//aBUi4N2LuW0LVP+SPqGRJxHv864oJ5S9w==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3056.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(38070700005)(55016002)(64756008)(54906003)(86362001)(9686003)(8936002)(66476007)(38100700002)(8676002)(110136005)(2906002)(76116006)(71200400001)(5660300002)(7696005)(52536014)(33656002)(508600001)(186003)(122000001)(66446008)(316002)(83380400001)(6506007)(26005)(66946007)(4326008)(53546011);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3773
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT013.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: e2fdcc41-aa2e-4e07-bf96-08d998675076
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZYNGH3C7ic4xjCjgrRwGYrRdYketkBSEmAMxas2a6t1r4O9cvPKwfIXkOguxiM4ywqUK24MU3dm90n4OGrkzCYwmc+U42cPtHWG6oFfIWi5C04mqQ+qUN/3glpQfzF3yrzzi8hTENryIl2sNERIngu1zshf1FrqBpITA4pdODuQ5Kh8m5z4XEmRhRXxRZSKYPQUmHOJyrg3pwYftOkrI9nvOSQwVYO0xOkhMmNjEnAeXlO/YpDeCI+ExrDUklkQYZGdTaqtUPwVi0qMeQ2SaDmOtzQRAQi5VnKuoHX7gMYOkv3wtSmLQPvI5F6FAsmfb8Y6oGPMECOlCH3MdCe2HIAU5T+FV5nz1sRobQCQNCTcreHFpiHt9GDisIgt17MYveVXmzxpNBcmH6TpqZQuP6LZkyADJ3h2XX6ANiV+vVqKiLqYNKqsEjmNtCDrI33UJT3lgT0CoUWzpje2lt6rYV0Ntay3X2YcDyuCTEJCPlJOz+VBk2dUxstsTL4s9RP7MOKGviJqa6CA3SeGLAqTrkwmCQCgELIEvECduG7YTNpihFfh0orJNmGZGBhDvLQyP2UQwxJt5B2e8hG9Qn2OTpVuGkMLozPYXCO+ZfjEqqJ+REyYRLTwe+aCKXF4Ulf7aifvoAmM8QIY6MTAr7FwNKFH/cCPU3ZWFEfrnuBlxxdh6PA1DLF3WqsypF0b7nB+vMY+xMY+AWcENdYyDhapc0w==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(55016002)(6506007)(7696005)(53546011)(8936002)(8676002)(52536014)(186003)(508600001)(86362001)(9686003)(2906002)(81166007)(82310400003)(83380400001)(356005)(26005)(5660300002)(4326008)(33656002)(336012)(70586007)(70206006)(36860700001)(316002)(54906003)(47076005)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 09:59:42.2797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 226e1bef-6443-49bf-51c3-08d9986754eb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT013.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3201
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWGVuLWRldmVsIDx4ZW4t
ZGV2ZWwtYm91bmNlc0BsaXN0cy54ZW5wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9mDQo+IEp1ZXJn
ZW4gR3Jvc3MNCj4gU2VudDogMjAyMeW5tDEw5pyIMjbml6UgMTU6MzYNCj4gVG86IEppYXNoZW5n
IEppYW5nIDxqaWFzaGVuZ0Bpc2Nhcy5hYy5jbj47IGJvcmlzLm9zdHJvdnNreUBvcmFjbGUuY29t
Ow0KPiBzc3RhYmVsbGluaUBrZXJuZWwub3JnDQo+IENjOiB4ZW4tZGV2ZWxAbGlzdHMueGVucHJv
amVjdC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2Ml0geGVuOiBGaXggaW1wbGljaXQgdHlwZSBjb252ZXJzaW9uDQo+IA0KPiBPbiAyNi4x
MC4yMSAwOTozMiwgSmlhc2hlbmcgSmlhbmcgd3JvdGU6DQo+ID4gVGhlIHZhcmlhYmxlICdpJyBp
cyBkZWZpbmVkIGFzIFVJTlQuDQo+ID4gSG93ZXZlciBpbiB0aGUgZm9yX2VhY2hfcG9zc2libGVf
Y3B1LCBpdHMgdmFsdWUgaXMgYXNzaWduZWQgdG8gLTEuDQo+ID4gVGhhdCBkb2Vzbid0IG1ha2Ug
c2Vuc2UgYW5kIGluIHRoZSBjcHVtYXNrX25leHQoKSBpdCBpcyBpbXBsaWNpdGx5DQo+ID4gdHlw
ZSBjb252ZXJzZWQgdG8gSU5ULg0KPiA+IEl0IGlzIHVuaXZlcnNhbGx5IGFjY2VwdGVkIHRoYXQg
dGhlIGltcGxpY2l0IHR5cGUgY29udmVyc2lvbiBpcw0KPiA+IHRlcnJpYmxlLg0KPiA+IEFsc28s
IGhhdmluZyB0aGUgZ29vZCBwcm9ncmFtbWluZyBjdXN0b20gd2lsbCBzZXQgYW4gZXhhbXBsZSBm
b3INCj4gPiBvdGhlcnMuDQo+ID4gVGh1cywgaXQgbWlnaHQgYmUgYmV0dGVyIHRvIGNoYW5nZSB0
aGUgZGVmaW5pdGlvbiBvZiAnaScgZnJvbSBVSU5UDQo+ID4gdG8gSU5ULg0KPiA+DQo+ID4gRml4
ZXM6IDNmYWMxMDEgKCJ4ZW46IFJlLXVwbG9hZCBwcm9jZXNzb3IgUE0gZGF0YSB0byBoeXBlcnZp
c29yIGFmdGVyIFMzDQo+IHJlc3VtZSAodjIpIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBKaWFzaGVu
ZyBKaWFuZyA8amlhc2hlbmdAaXNjYXMuYWMuY24+DQo+IA0KPiBSZXZpZXdlZC1ieTogSnVlcmdl
biBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPiANCj4gDQo+IEp1ZXJnZW4NCg0KW0ppYW1laSBY
aWVdIA0KUmV2aWV3ZWQtYnk6IEppYW1laSBYaWUgPGppYW1laS54aWVAYXJtLmNvbT4NCg0K
