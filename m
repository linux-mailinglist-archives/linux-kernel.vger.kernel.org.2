Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F183EAC68
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 23:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbhHLVcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 17:32:00 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:43864 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235246AbhHLVb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:31:59 -0400
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7E744C10CA;
        Thu, 12 Aug 2021 21:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628803893; bh=z3/zq9VGhaS4ii4taaB9GvRokwlz/fXLrwU1xcUOhT0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=JdZpYgOjwy0qmlgsiP60U5tVJy9JOhL2COB5ooxYMS9gXUbrn8PONE6qmtqBO3K4x
         OMOq/10jcAVAQE/wiJEqiVr7k+TnLAhqDAIpswW3V01b+9vK3hes35fNb6tp4zPVgi
         cQ+WnYg2+VL6JCntAulHe20LCXLsrbAb3Yv4peC5npiUdgDJbbslzFWxLeT/OWBZww
         603LO7YV9eULwDr5xlMRh/um4Y+aXIC4CcCGBC42L3SEPfDyk9qrsFCf+FBMoZfX0c
         9pOsBBFNpoQukzFcZOKVH+XqKTeDIZ6Wmj49wYY9K4wSsYXceZEcfXSXUTwlmMYthI
         zdxhjbYySUTTw==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 890E8A0080;
        Thu, 12 Aug 2021 21:31:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7EACF400CB;
        Thu, 12 Aug 2021 21:31:31 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="dLB52PAH";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlMaYYsU9mM5FXmee0GE3DDO/M/rpJNI6BVsef/dmIqQsnTd8zOH2bqcWK5SNFYoV1Go7Dwd/dlD9ncfTZiw64Mph4YMa5MHNW+y4ES0HPdZCvm21G9otkTO5OMIhQBNEpysL1y1rde7TE9iIxSYzu77w8aazQl1OihatvpOp/t2DEFg8gOL4WrmKKikrXLf26lwcGYfUVCKZ9fOIgBdqQLu/hDXmlXoDZ/MyrC5yE3jngwtClaBDn2hdLzJH2fYKoM/1lS5mcGzhMqoiAoi9UcG03YFH6rh4JyqagL44eE0P9X+pR/G0aRUYHNlVXY8j5aphBnFjxGrfK4ALmIojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3/zq9VGhaS4ii4taaB9GvRokwlz/fXLrwU1xcUOhT0=;
 b=QwaAqNSfyX+b2YLB26rF04DMECO/XwvxHK2i6qUBlVno7/ElC2LTF32u4yKhFATX1H+7VsXDlI4hOa5qtDmQ4yB9wPxDVnH8X4KJbfalOCc90T9AjCD1JAL4pei+wOI6nAFoKR3R6+RZNZeP7Hh1UACXRdDrrDA5l0K6yPWXhD26ottc6xOxufBaNKk/3LOCvcPVTOHv9vfb47WUMwGR4tq5cORe/CQBWAQH6MbMh3nOy4F+qhrRk10NFcNquPS+TPtVUuvutDc2sGzzSZnmEOd37Ja21epEMpwnwkBtKRx3yJsn48NhIc+/OgTw9FacbwjXViexq7eIWE4pTTQwyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3/zq9VGhaS4ii4taaB9GvRokwlz/fXLrwU1xcUOhT0=;
 b=dLB52PAHrScrD4AeKXd7BcV6vLnTI+3fCLHSDqVLh/stamybLWleewTkcgzXSHyCpBSTqmQL+ebnepMbXcl670ZGILKOMh5p5T6UMJe7NR/gV9u5FArT9WA5iSiFCGsHRKHROWYhe7WEC3OVyFe4uA5SJPvdCBQAX2UaQxHQXFU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Thu, 12 Aug
 2021 21:31:28 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9%7]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 21:31:28 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeauora.org" <jackp@codeauora.org>
Subject: Re: [RFC][PATCH] usb: dwc3: usb: dwc3: Force stop EP0 transfers
 during pullup disable
Thread-Topic: [RFC][PATCH] usb: dwc3: usb: dwc3: Force stop EP0 transfers
 during pullup disable
Thread-Index: AQHXjlfnBCk6lwHDK0Kvf9A7ww7BQqtvCnaAgAETMgCAAEh3AA==
Date:   Thu, 12 Aug 2021 21:31:27 +0000
Message-ID: <e07b7061-e9cf-3146-d115-56967298051e@synopsys.com>
References: <1628648608-15239-1-git-send-email-wcheng@codeaurora.org>
 <bcc8ff30-5c49-bddd-2f61-05da859b2647@synopsys.com>
 <3edf74ba-d167-0589-a7ab-827b57aa5d9c@codeaurora.org>
In-Reply-To: <3edf74ba-d167-0589-a7ab-827b57aa5d9c@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c068a50-6899-404a-e2c9-08d95dd88b56
x-ms-traffictypediagnostic: BY5PR12MB4259:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB42591C392C55449DA3009847AAF99@BY5PR12MB4259.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xhsfQFNdUZaUiE83m5N2CFLWA3ztIVjojJUbcpcP98Uu7gSprkoO6bsCxMHrhkEqjsywJkdRomB1uNixzGfx5+GU0NnREAUCyn9W5HfD5wvYr0fqjlATx8FkqWQ4W6JKh9R/aaS8tI3N/MLTfFOFMB/jsLj6fjk08ZwX4NvFX6Q2CMuuiwdr73SaZiTcAVE7g5ko03kdzwSQnmOteVcA43aUNIJ3UDYKCVIzmCdJB7sqOtXMJ70VSHbWbCh49tuOp1Y0Yo96JHnW1CpjiXFkp8m/gb7XbpfBZa8hrYrWY3qTcCnEu9IFCOJixLMdKWx7mBYZa7XGwY9F6TbbamBhJOezP8sy/cdU2HRLH82h431WCPryG2qaPWFhYlqMGZ2jiSP1uH6t6C0TIH2QlTka05h3LScq0tKZky98Jb/HGDV3IK9w85MmGMlQ0HDgkVfrJU2NqU9hP3v8wgez8vBas1g1GIp32oKNK3spsIh6WDb3HHDwFVfNdEySD7gxsKkUZ4xzTKHkb9ihBiF/tgXCEscdV8KNYNj3Z6j7VhqcLfIggHILgFl9jmonqS8RHBD5Tv7Ah0qxMgBRMElnJ9AiuuXxLVI0150tI/0u9QikOeewFubLzP5i3PJb4P/lcaAqWWWIO6zeRC/1irKf5+8pxKgsNuV1Q6un2axGPoxm6A20BimN20eXRkOulgOJrQpbnVH62Rf+WaIIP6K7dglwHqH8Iqv3SSz2RUY56M2KXdaNOGHS6fnZHKROA/emJf7U98v+TG/E/MM0nn66XWMwHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39850400004)(136003)(366004)(376002)(396003)(66946007)(38100700002)(4326008)(122000001)(31686004)(31696002)(5660300002)(26005)(110136005)(54906003)(66446008)(316002)(86362001)(76116006)(64756008)(66556008)(66476007)(83380400001)(186003)(8676002)(2616005)(8936002)(2906002)(36756003)(71200400001)(6506007)(53546011)(478600001)(6486002)(6512007)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmVheWlkcmdxbGFhYitDUDgwaXRpYXluZnd1YkRadHRKU01HMzBZK211RE9a?=
 =?utf-8?B?djM1R05yWmVyTEU4eGo3REN4V1NvSnRUcmppOWFZajhWaDFPYkppN3JFZkx4?=
 =?utf-8?B?MTgzcitYMFpnSDlrSy92eU5KMlBSM0JibGt6NDJtQ0NLbUV3cldhQ0g5SlFC?=
 =?utf-8?B?eDZrZnlKSkxOVmhqenhnZDNRbkN6TkxSRlRQYWl5TkFMbCttcHV4U0RhNEF5?=
 =?utf-8?B?NzJsblAvMFljZ1ZUVjlRSEY1cFcvUHFBRVJ2Q2NvQng5bWpIM1RrcVZIdDZF?=
 =?utf-8?B?SHh1MWhuOTcrdHFNYStJeHZBcHFQWXBlbmVlK3pFczVuaFowQkl4MkI0U3FN?=
 =?utf-8?B?LzBub0ZMbERmalRhTXE3VFduZEw3YlpjdjAvWUZYc2xGdEhLMkRTbVlhSDFZ?=
 =?utf-8?B?RlQzM0dZK09sWDdETmREL245OHhsRnZUaWtHYWhmcisreTJIczdVd0o1b1ZO?=
 =?utf-8?B?R0trUnVYVXNzKytKY0xIREVnRTBycWVQYWFncVcxRnNncmZZbmQyMm5UNGJz?=
 =?utf-8?B?NDZhcC9PVDVnMStQSzJyMjgvdEF0c0d1SUZDb3c3bFBJa1lVM05yZmxBaU1G?=
 =?utf-8?B?QW10UGpjUmpBaHkxSkt4aVdtdktCM282cFUxakVBei8xelFVUWswU3c3Zlhh?=
 =?utf-8?B?bStFVUhhMzRRdVY2eTF5MUw5MmRjNGtlYjZjeUpaVGlXcFVOYTdjUjZGT21J?=
 =?utf-8?B?aUR6clovSjI2Mk00NHEyU3hMK2d0K0VFcVlXVWI4S3U5SWxxMUdGUjE4Q0Jt?=
 =?utf-8?B?UDdLOStBQy8zTUg2MzB4TXJMUVdQb3d2cmgwSERsYzJLVndsaVRkTFJ3QldY?=
 =?utf-8?B?VDluTVI1cGJ6ZkErQ0RMV0xFMG1JeUlyMHVDVjJ0K2dWOEZZcGluMW1ZYkRS?=
 =?utf-8?B?dDRiSDg5QUswOGJIcUNXVjdsOUFZSElmVHVCaTFYcXRFdzZRd1V0ZVV3NVRK?=
 =?utf-8?B?bTR0UWRHYWZTRURVWDBTQ3FZZURrRXp4QTc2bm9reEQyc3drWm0xMkZUNnRS?=
 =?utf-8?B?SjcrRDJGWGc2ZWxwd05yak5MVlZoaG52TmQweVF1Z2J1Rk9wOExwc1ByYzVa?=
 =?utf-8?B?elFVbU5NYmN1S0pJZUxVZE9YcDJMb2N1TXExN1p5SmRDZ3FENUkrSThYWGFD?=
 =?utf-8?B?NzFBR0ZtYzFDbURGNWt0UmRaQllDVzB6MEh3YkxVMldJWGhOSnVIR2xaSnBj?=
 =?utf-8?B?R0pENjJZVlhueHN0bGpzK2YvSmk5cENsNlE3V3MvenFHN2FENzBFaTA0eDE1?=
 =?utf-8?B?V25FTEVoZ0ZuV0k1RVlFc2FkWlVNL2p4blpFVzMzSWRWdXBkRmMvMFZYSmMw?=
 =?utf-8?B?dm04bHFWbUMraVFvVk00WlExS1NrNEU1c0tYYWpDUGVDbUh3Z1FiMEVRNHp6?=
 =?utf-8?B?cGdVVjdnNGJzYmRSY2NpMUU1NEVMRW9SL042S1JGYktzZXgwVUFXVFZ1NlJD?=
 =?utf-8?B?Q2V5ZVk1TERVMXAxNWJhZFNyWCtlSlpCcU5vVGZnNmJEekxpWmZwU1pWbEh1?=
 =?utf-8?B?VXFyQUczK0Z4TzVxbExuTmRQWC92amlTNHRMRmxBcHNBT3A1Z1l6c1NNd3Jq?=
 =?utf-8?B?Q3k3NmVCNHo0dVZCREtiTktEU0xuK0thSys2bU8zVHJWOENFUEw3TlUzeFBq?=
 =?utf-8?B?WDhrOENRdjZaRmJSRmRKcEc3RzcwdFZMR3I1MGl0QlQzV0dtcFJWMXpEUkI3?=
 =?utf-8?B?dHpaTHVCMEJLWUhvd1oycEhhV1lBL1g1NUJHYnkweEZkUWZaNGoyWk5Sd3Ey?=
 =?utf-8?Q?id7UW100GXaQCw/rK4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81B492CE88CD8A4C8FA6D48B60238EB6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c068a50-6899-404a-e2c9-08d95dd88b56
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 21:31:27.4246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OJv+Owj5E0VLTeXMOCiNGmlDGthILnfjx0U+E5LUDZJ2q774vIXxqovw1fnxbxKukjGR6NynrCrcgyKz7/jEdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPiBIaSBUaGluaCwNCj4gDQo+IE9uIDgvMTEvMjAyMSA1OjQ3
IFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+PiBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+Pj4gRHVy
aW5nIGEgVVNCIGNhYmxlIGRpc2Nvbm5lY3QsIG9yIHNvZnQgZGlzY29ubmVjdCBzY2VuYXJpbywg
YSBwZW5kaW5nDQo+Pj4gU0VUVVAgdHJhbnNhY3Rpb24gbWF5IG5vdCBiZSBjb21wbGV0ZWQsIGxl
YWRpbmcgdG8gdGhlIGZvbGxvd2luZw0KPj4+IGVycm9yOg0KPj4+DQo+Pj4gICAgIGR3YzMgYTYw
MDAwMC5kd2MzOiB0aW1lZCBvdXQgd2FpdGluZyBmb3IgU0VUVVAgcGhhc2UNCj4+DQo+PiBIb3cg
Y291bGQgaXQgYmUgYSBjYXNlIG9mIGNhYmxlIGRpc2Nvbm5lY3Q/IFRoZSBwdWxsdXAoMCkgb25s
eSBhcHBsaWVzDQo+PiBmb3Igc29mdC1kaXNjb25uZWN0IHNjZW5hcmlvLiBJZiB0aGUgZGV2aWNl
IGluaXRpYXRlZCBhIGRpc2Nvbm5lY3QsIHRoZW4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJlc3Bv
bnNlLiAgSSBndWVzcyB0aGlzIGlzIHNwZWNpZmljIGZvciBzb21lIHVzZSBjYXNlcywNCj4gYnV0
IHNvbWUgYXBwbGljYXRpb25zIHN1Y2ggYXMgQURCIHdpbGwgY2xvc2UgdGhlIEZGUyBFUCBmaWxl
cyBhZnRlciBpdA0KPiBnZXRzIHRoZSBkaXNjb25uZWN0aW9uIGV2ZW50LCBsZWFkaW5nIHRvIHRo
aXMgcHVsbHVwIGRpc2FibGUgYXMgd2VsbC4NCj4gU28gaXRzIHNwZWNpZmljIHRvIHRoYXQgcGFy
dGljdWxhciB1c2UgY2FzZS4NCg0KRG9lcyB0aGF0IG1lYW4gdGhhdCB0aGUgQURCIGFwcGxpY2F0
aW9uIHdvbid0IGV4cGVjdCBhIGNvbm5lY3Rpb24gdW50aWwNCnVzZXIgaW50ZXJ2ZW50aW9uIG9y
IHNvbWUgb3RoZXIgbm90aWZpY2F0aW9uIHRvIGRvIHB1bGx1cCgxKT8NCg0KPiANCj4+IHRoZSBk
cml2ZXIgc2hvdWxkIHdhaXQgZm9yIHRoZSBjb250cm9sIHJlcXVlc3QgdG8gY29tcGxldGUuIElm
IGl0IHRpbWVzDQo+PiBvdXQsIHNvbWV0aGluZyBpcyBhbHJlYWR5IHdyb25nIGhlcmUuIFRoZSBw
cm9ncmFtbWluZyBndWlkZSBvbmx5DQo+PiBtZW50aW9ucyB0aGF0IHdlIHNob3VsZCB3YWl0IGZv
ciBjb21wbGV0aW9uLCBidXQgaXQgZG9lc24ndCBzYXkgYWJvdXQNCj4+IHJlY292ZXJ5IGluIGEg
Y2FzZSBvZiBodW5nIHRyYW5zZmVyLiBJIG5lZWQgdG8gY2hlY2sgaW50ZXJuYWxseSBidXQgaXQN
Cj4+IHNob3VsZCBiZSBzYWZlIHRvIGlzc3VlIEVuZCBUcmFuc2Zlci4NCj4+DQo+IA0KPiBZZXMs
IHdoYXQgSSBkaWQgd2FzIG1vZGlmeSBhIGRldmljZSBydW5uaW5nIHRoZSBMaW51eCBYSENJIHN0
YWNrIHcvbw0KPiByZWFkaW5nL3NlbmRpbmcgb3V0IHRoZSBTRVRVUCBEQVRBIHBoYXNlLCBzbyB0
aGF0IG9uIHRoZSBkZXZpY2UgZW5kIHdlJ2QNCj4gYWx3YXlzIHJ1biBpbnRvIHRoYXQgc2l0dWF0
aW9uIHdoZXJlIHRoZXJlJ3Mgc3RpbGwgYSBwZW5kaW5nIEVQMCBUUkIgcXVldWVkLg0KDQpJcyB0
aGlzIG9ubHkgZm9yIHZhbGlkYXRpb24gcHVycG9zZT8NCg0KPiANCj4gV2UncmUgcnVubmluZyBt
dWx0aXBsZSBkZXZpY2VzIHdpdGggdGhpcyBmaXggYXMgd2VsbCwgYW5kIGRvaW5nIGRldmljZQ0K
PiBpbml0aWF0ZWQgZGlzY29ubmVjdC4NCj4gDQo+Pj4NCj4+PiBJZiB0aGlzIG9jY3VycywgdGhl
biB0aGUgZW50aXJlIHB1bGx1cCBkaXNhYmxlIHJvdXRpbmUgaXMgc2tpcHBlZCBhbmQNCj4+PiBw
cm9wZXIgY2xlYW51cCBhbmQgaGFsdGluZyBvZiB0aGUgY29udHJvbGxlciBkb2VzIG5vdCBjb21w
bGV0ZS4NCj4+PiBJbnN0ZWFkIG9mIHJldHVybmluZyBhbiBlcnJvciAod2hpY2ggaXMgaWdub3Jl
ZCBmcm9tIHRoZSBVREMNCj4+PiBwZXJzcGVjdGl2ZSksIGRvIHdoYXQgaXMgbWVudGlvbmVkIGlu
IHRoZSBjb21tZW50cyBhbmQgZm9yY2UgdGhlDQo+Pj4gdHJhbnNhY3Rpb24gdG8gY29tcGxldGUg
YW5kIHB1dCB0aGUgZXAwc3RhdGUgYmFjayB0byB0aGUgU0VUVVAgcGhhc2UuDQo+Pj4NCj4+PiBT
aWduZWQtb2ZmLWJ5OiBXZXNsZXkgQ2hlbmcgPHdjaGVuZ0Bjb2RlYXVyb3JhLm9yZz4NCj4+PiAt
LS0NCj4+PiAgZHJpdmVycy91c2IvZHdjMy9lcDAuYyAgICB8IDQgKystLQ0KPj4+ICBkcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jIHwgNiArKysrKy0NCj4+PiAgZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuaCB8IDMgKysrDQo+Pj4gIDMgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2VwMC5j
IGIvZHJpdmVycy91c2IvZHdjMy9lcDAuYw0KPj4+IGluZGV4IDY1ODczOTQuLmFiZmM0MmIgMTAw
NjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9lcDAuYw0KPj4+ICsrKyBiL2RyaXZlcnMv
dXNiL2R3YzMvZXAwLmMNCj4+PiBAQCAtMjE4LDcgKzIxOCw3IEBAIGludCBkd2MzX2dhZGdldF9l
cDBfcXVldWUoc3RydWN0IHVzYl9lcCAqZXAsIHN0cnVjdCB1c2JfcmVxdWVzdCAqcmVxdWVzdCwN
Cj4+PiAgCXJldHVybiByZXQ7DQo+Pj4gIH0NCj4+PiAgDQo+Pj4gLXN0YXRpYyB2b2lkIGR3YzNf
ZXAwX3N0YWxsX2FuZF9yZXN0YXJ0KHN0cnVjdCBkd2MzICpkd2MpDQo+Pj4gK3ZvaWQgZHdjM19l
cDBfc3RhbGxfYW5kX3Jlc3RhcnQoc3RydWN0IGR3YzMgKmR3YykNCj4+PiAgew0KPj4+ICAJc3Ry
dWN0IGR3YzNfZXAJCSpkZXA7DQo+Pj4gIA0KPj4+IEBAIC0xMDczLDcgKzEwNzMsNyBAQCB2b2lk
IGR3YzNfZXAwX3NlbmRfZGVsYXllZF9zdGF0dXMoc3RydWN0IGR3YzMgKmR3YykNCj4+PiAgCV9f
ZHdjM19lcDBfZG9fY29udHJvbF9zdGF0dXMoZHdjLCBkd2MtPmVwc1tkaXJlY3Rpb25dKTsNCj4+
PiAgfQ0KPj4+ICANCj4+PiAtc3RhdGljIHZvaWQgZHdjM19lcDBfZW5kX2NvbnRyb2xfZGF0YShz
dHJ1Y3QgZHdjMyAqZHdjLCBzdHJ1Y3QgZHdjM19lcCAqZGVwKQ0KPj4+ICt2b2lkIGR3YzNfZXAw
X2VuZF9jb250cm9sX2RhdGEoc3RydWN0IGR3YzMgKmR3Yywgc3RydWN0IGR3YzNfZXAgKmRlcCkN
Cj4+PiAgew0KPj4+ICAJc3RydWN0IGR3YzNfZ2FkZ2V0X2VwX2NtZF9wYXJhbXMgcGFyYW1zOw0K
Pj4+ICAJdTMyCQkJY21kOw0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdl
dC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPj4+IGluZGV4IDU0YzVhMDguLmEwZTJl
NGQgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPj4+ICsrKyBi
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4+PiBAQCAtMjQzNyw3ICsyNDM3LDExIEBAIHN0
YXRpYyBpbnQgZHdjM19nYWRnZXRfcHVsbHVwKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLCBpbnQgaXNf
b24pDQo+Pj4gIAkJCQltc2Vjc190b19qaWZmaWVzKERXQzNfUFVMTF9VUF9USU1FT1VUKSk7DQo+
Pj4gIAkJaWYgKHJldCA9PSAwKSB7DQo+Pj4gIAkJCWRldl9lcnIoZHdjLT5kZXYsICJ0aW1lZCBv
dXQgd2FpdGluZyBmb3IgU0VUVVAgcGhhc2VcbiIpOw0KPj4+IC0JCQlyZXR1cm4gLUVUSU1FRE9V
VDsNCj4+PiArCQkJc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPj4+ICsJ
CQlkd2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKGR3YywgZHdjLT5lcHNbMF0pOw0KPj4+ICsJCQlk
d2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKGR3YywgZHdjLT5lcHNbMV0pOw0KPj4NCj4+IEVuZCB0
cmFuc2ZlciBjb21tYW5kIHRha2VzIHRpbWUsIG5lZWQgdG8gd2FpdCBmb3IgaXQgdG8gY29tcGxl
dGUgYmVmb3JlDQo+PiBpc3N1aW5nIFN0YXJ0IHRyYW5zZmVyIGFnYWluLiBBbHNvLCB3aHkgcmVz
dGFydCBhZ2FpbiB3aGVuIGl0J3MgYWJvdXQgdG8NCj4+IGJlIGRpc2Nvbm5lY3RlZC4NCj4gDQo+
IEkgY2FuIHRyeSB3aXRob3V0IHJlc3RhcnRpbmcgaXQgYWdhaW4sIGFuZCBzZWUgaWYgdGhhdCB3
b3Jrcy4gIEluc3RlYWQNCj4gb2Ygd2FpdGluZyBmb3IgdGhlIGNvbW1hbmQgY29tcGxldGUgZXZl
bnQsIGNhbiB3ZSBzZXQgdGhlIEZvcmNlUk0gYml0LA0KPiBzaW1pbGFyIHRvIHdoYXQgd2UgZG8g
Zm9yIGR3YzNfcmVtb3ZlX3JlcXVlc3RzKCk/DQo+IA0KDQpGb3JjZVJNPTEgbWVhbnMgdGhhdCB0
aGUgY29udHJvbGxlciB3aWxsIGlnbm9yZSB1cGRhdGluZyB0aGUgVFJCcw0KKGluY2x1ZGluZyBu
b3QgY2xlYXJpbmcgdGhlIEhXTyBhbmQgcmVtYWluIHRyYW5zZmVyIHNpemUpLiBUaGUgZHJpdmVy
DQpzdGlsbCBuZWVkcyB0byB3YWl0IGZvciB0aGUgY29tbWFuZCB0byBjb21wbGV0ZSBiZWZvcmUg
aXNzdWluZyBTdGFydA0KVHJhbnNmZXIgY29tbWFuZC4gT3RoZXJ3aXNlIFN0YXJ0IFRyYW5zZmVy
IHdvbid0IGdvIHRocm91Z2guIElmIHdlIGtub3cNCnRoYXQgd2UncmUgbm90IGdvaW5nIHRvIGlz
c3VlIFN0YXJ0IFRyYW5zZmVyIGFueSB0aW1lIHNvb24sIHRoZW4gd2UgbWF5DQpiZSBhYmxlIHRv
IGdldCBhd2F5IHdpdGggaWdub3JpbmcgRW5kIFRyYW5zZmVyIGNvbW1hbmQgY29tcGxldGlvbi4N
Cg0KQlIsDQpUaGluaA0K
