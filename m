Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A656F3F7DEB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 23:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhHYVns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 17:43:48 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:46610 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229599AbhHYVnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 17:43:47 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CCE334669D;
        Wed, 25 Aug 2021 21:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1629927781; bh=ohuDtiODIXndgU5Wz3FHbfWJo/VwRU3+qMrSgrmXlB4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=RKkGewZ/X746xy7izOudmQg8nRpiVZLKf40wZs9gKOOPh/AYakgAXLxXqCMkVPf5r
         bYIFkiDPvpfktrCAfRcKRumfixV6nEVHjuuEI72/6nkkZlmovXXzmJ+DBDGWgidmg5
         D+miKr/GpmefPgLJ2nEzJBNihb70PyRumK++91JjL4/kwC1Jx2gpHmHnMNYfmSo8KP
         hf9757EDa0Yh540abxmobrR/yCt+EZXHwT8F+5qdJo09+x7M8lotdFsKEhzlBEHVYM
         IjoVFSbsBJsPiakOF89teFwMZ2QZcE1a8JOaWu9DgyD4C90ecWRGMYEui/5hvmCSIE
         pLz0fbUQ+fVmQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D075CA0079;
        Wed, 25 Aug 2021 21:42:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (unknown [104.47.55.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2363F4013E;
        Wed, 25 Aug 2021 21:42:55 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="RCvVNp8Y";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/ILZwlxJXyncGnurqnwXWm+iGBh7IYK79R+w3Kl/sSVc0op1zvZ/7d/cM7yh44FZdvcae/3R4jnMQviFwucoP85vvLEbkW32JMHI1W9IfPayrptEOVMQl62eIKYEz1vj22+OtX/u0qUb1R9w0wMne1nUq17AKDP49GmGhuatjXstf9Qx/oYdOp0Girea14wZvcrwuTfxQWM4qbe3J//+gVRQ2R5V84tkoVvkytWoKIRyVBXrojcocFLXtSIeZkhWY3W3BWrLBWbu4EBQ+9Z7KLQCM+z6PpnlA6TdzZkQttE11doT9a5NWgP/FjUpQgmpiljrXljs/9gvi28vFt+Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohuDtiODIXndgU5Wz3FHbfWJo/VwRU3+qMrSgrmXlB4=;
 b=e7FSyFv4V/cZaKP1BRQi1TSmzIsi0GrHq5YjEfKsy5QzebSmRth5X7A7uFgKyRld8MTPoYoVmSEzkvIdVAUaMi8G1wPDcljDKnaLPmE+ujmIns8JxP1obrNc8HOjXQ8mVhcZCHLoD0piOK+uIelVgJc9poS4SixwNtHAedDXxZhmH1ZyGVzy6Luak+/COclkPNz7XU1TE0H3etuTc16q8kS6DnWZLTSttK7a6QQbvAyUn+yg7ivGUkSYuBCw4q6E4W4NZ7GA46Aa+PzNUWfcIEqEZ98aC2hEv9Il7NU9JP2K70mS8/yE9sw7U1H4QtdQlMsUuKmvIr0HBaktut9T2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohuDtiODIXndgU5Wz3FHbfWJo/VwRU3+qMrSgrmXlB4=;
 b=RCvVNp8YDN9u9l8UG5GLXREvXAT2np9rgTCSCYxjxZ9MTQVcjqvlmhPxZWQ3uAnaz9FxEaLw8REy1d8nqznOSdNseMGkVv0TeowUWIzQLzdt9Pwyko2nifXzNehIsAmC8WeNjKhuOtE6c5e4dqcHI5nHRrtoO+ko3FJGgqKPQUw=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Wed, 25 Aug
 2021 21:42:52 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::508a:1772:de73:d89e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::508a:1772:de73:d89e%4]) with mapi id 15.20.4457.017; Wed, 25 Aug 2021
 21:42:52 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Ferry Toth <fntoth@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Ferry Toth <ftoth@exalondelft.nl>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Pavel Hofman <pavel.hofman@ivitera.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jack Pham <jackp@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH] usb: gadget: f_uac2: fixup feedback endpoint stop
Thread-Topic: [PATCH] usb: gadget: f_uac2: fixup feedback endpoint stop
Thread-Index: AQHXmZKbDUm/TJv5RU+0RTPysUL82KuEpnqAgAAar4A=
Date:   Wed, 25 Aug 2021 21:42:52 +0000
Message-ID: <9709a13f-46f5-ad53-3d19-86b4954bb0f8@synopsys.com>
References: <20210824201433.11385-1-ftoth@exalondelft.nl>
 <20210825092107.124419-1-jbrunet@baylibre.com>
 <79bd686d-5c1f-982c-344a-17c10b64a231@gmail.com>
In-Reply-To: <79bd686d-5c1f-982c-344a-17c10b64a231@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60288c1c-bdb0-4dc4-d920-08d968114a5a
x-ms-traffictypediagnostic: BYAPR12MB2806:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2806479BA06A08DBAE58AF67AAC69@BYAPR12MB2806.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BSMuOw9nGrEczOJiHq6qz2PgddyTsrSy9mr6lCEZnmHf0Alr3VCkxO7DCWPuusXg/GlxwhnsFIye7Cs73yGlxwqyubRWSUCQ2W7uGoYSMXR0UQrtSNmRWaW1N+QMeBn7CRY1fGjRquEBXjc3UYtDDiHf1+a6cpEOEtzQLT6PFzet8D73cSnq4410p9f+cdGwNXQl4tMffEkoHYQVdP9cYufi0Xn7yp4F749RI2UdmDLZ2MPa+U65jyNZN0wRDJMMWu3ez5FPt0zu13r4KDjjiqd3TxJm1qFKJkFSWSpyt4rgEjkhqS6puqDY3pzDc2XupL/t8Q2ksP5pK+ab5u8LvUOSag3bZO4WTxGE9CPyc0fC/e5DkKNhDpkguKyuqheeWi7WHgsciwPZzwCmHlFDc23hgg0H/rPTKRv+iwSdR8q7gen2kT1cQJgsChrHvllDP1DmuUen3x1RZRjqYqgH2xlHmJkrQaRVJFoj/c2wEP1Cq86u5nYCHScHnRcyuHCFG6GYNpk4Ykzo7eGj5LUCnRFAmZNd6JGGONnvQsH1rpgE8LS2/9l8f0+6v/boUzAPdvrKnCiZOma9FPPv40+MTcHA+K8qwLHglsDGFYeb+cmRLLtuMl5wPxi4hzysE1dqcC138xyAK1rLp5IrdJgWk+rdl3sG9WNxvmK0HgkAkhiywL2LUp2cxLVFnsT7rPj9p0Du8JesMAB2nFIVtACWbjtziG1cjV0ar1x3+NnE6i5nJnSfLcec5ewlOtuk8DiRn4a3d0cpjuJuckWJK4OIMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(366004)(39860400002)(346002)(64756008)(5660300002)(66556008)(76116006)(66446008)(6506007)(31696002)(66946007)(66476007)(316002)(122000001)(38100700002)(38070700005)(110136005)(6486002)(6512007)(71200400001)(26005)(2906002)(31686004)(8676002)(7416002)(107886003)(478600001)(83380400001)(186003)(2616005)(8936002)(54906003)(86362001)(4326008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dG51aEtCc0M1Nm1rOERSdmNWajhwLzZEeURVUXZ4UlBoMjlBS3BZeU1hT1RK?=
 =?utf-8?B?MENOeFF0Z2pGdkNRb0phbWdCTWhwZTNKRmF2MG1WMDFjZE1DOG1INkIwZWhL?=
 =?utf-8?B?VkpYcGRZSVRHN1ZZMXVocEtlRy94MlZEekJWb0F6ajBoTzAyL2I1OGpYeHpo?=
 =?utf-8?B?MTQ0aWorNlFxZnJvNFkyRFFJaXMyR0NSc3ljVDRQS211UGVpVVl3blNValpy?=
 =?utf-8?B?RlI2NXNwa3lBRVNadG8wZlhmY0pjcmRCMGFRNytjYkw5bjBzUFl3ZitHUUxu?=
 =?utf-8?B?QUZMT1hLUklyNno4VEZ6L09jUTZGUmRuakF1dkR3aUFEMEpTUENra1Q0bStM?=
 =?utf-8?B?MUZMVVdrT244YUdkUU1UYWNmUHgxOHRhdFoyWHdlM0pNZnJNVUVHUnUxT3lu?=
 =?utf-8?B?bHRMcnlCNlk0Vk9KVG5JT0RCL2RxWndHUFJ5aUJncGtZUC8xUkpRNDBNTDIx?=
 =?utf-8?B?YTVwUExnK1BFK0YrS0VtaGFlUW9vbzFFNldscWw3dk1UL3lUcnc0Q2VnVWlW?=
 =?utf-8?B?T1JlQm5ld1BFQmc2RTFwVGdrdVQ2SnZMRldCVzFHcmFsd0praDV0dGxQaVhG?=
 =?utf-8?B?K3lEQzZGZllCTm5mVnIremhvYVVza3Rsdm9ZVDJOYzV4ZFpIRzJpd1BON044?=
 =?utf-8?B?ZkZVdXdvOUthTEUycTVMNzdod3FVc0pnT3MwN3Mxc1A1ZFB2UUtOMUxab0d6?=
 =?utf-8?B?RktZRVJLOUVWZG9sZkZFM0E0VEpIQ3lvNTZmeFhIcURKR1l3RVJWbng0cDU1?=
 =?utf-8?B?VHZTVGNGUXkzbjAxa0tvV0hIUS9BZGhoTW53bEFuVXNycURFNEJReVBZK0Fp?=
 =?utf-8?B?WlMrcUxLWGJ5UUVDWGlpeS9pakdhRkZDZEp5STdNZXRLb2pGempweUNVS2hz?=
 =?utf-8?B?Vy9PZ3BzYUJHdk5TQzl2UndlUjNRYkFhYVF5VHZkYVlIa3VhbXlOSGRCTWw5?=
 =?utf-8?B?cFZnY3JhNFZSeTNobE5ocEh0c2ZqTkhNUEpoMTVQZENjMVFab0F6VVlpRFZ1?=
 =?utf-8?B?c0l6TTNSN0l1WGRoS2FjZUZpc212TXBzcDBnbmxGWWxRQ2MyVFA5Qk9JM0xL?=
 =?utf-8?B?Sk1UeEdBS3Q3eFFLeUgrUnZaR3NnVVhjYmV3MmNNeHQ3R0lKOVJXYmRUSGFE?=
 =?utf-8?B?ZWh4TUVaemllcllrWGVKc2padjRTTzVzeG5zYjZLUHJ2VitVYWFCcHRJZU5l?=
 =?utf-8?B?R0tha0N5OGdSYURnL1k4WllBc0JEOE1SenpzSHNzTHRRRWpzWHFjdUo3cjNL?=
 =?utf-8?B?K3BzM3N4Nmh2RW03alVPMlA2NEtiTnU2OU1JbWVGVkkzZ0taYUgxc2RDRWtv?=
 =?utf-8?B?dXREN2U3Z0RFZnhYVElYRDBKMEJJOGNTNnUvTGFVWnk2cjBLYUkveFdTYUNP?=
 =?utf-8?B?eVFuOHh5RmRCeGtFdFVlaVp6UWdJR2JTL0FHcEVIWmRRbXJsRnpwNjJEN2Mz?=
 =?utf-8?B?bDFleU1HakI3cVlhc0JuMDBiL2kyaGFxaEI2NXlTbE9QWDdIdjJVUlpwOWgr?=
 =?utf-8?B?cmxEZWJ1OGJMYi9nS0xEREdqOTFHbEc3U3NWTDZhZUtoK0pvWm9GSnlleDVT?=
 =?utf-8?B?UDVkSGtPeldMSlpHdXRDQkFLQ043U3pvdURHRHRUUDVFU0R2VGJGNFJNdFBY?=
 =?utf-8?B?dDJMclUwNTZwMFNsRlVLQk1QWTdKN1FKcDZqN1d4ZjJCaittenlHeEJTaW9n?=
 =?utf-8?B?ejg1QkZPLzdPTXU2U0VSQzB0QmtDcUpjQlhKQ3VFVzFLdnkyMWJTcWdBcTY1?=
 =?utf-8?Q?/pUiNHyttvaHesCyVU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACEE9E58DF94D64B8E5B9DBA277280A4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60288c1c-bdb0-4dc4-d920-08d968114a5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 21:42:52.0406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RlrsH76v7TDs0lv3CUO9jlNOKaWAmmXNhe9Rcp4b55ZBKzASNDC344UfcZbjReqM2ueXjJxyy9pB96n4c7uXxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2806
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RmVycnkgVG90aCB3cm90ZToNCj4gSGksDQo+IA0KPiBPcCAyNS0wOC0yMDIxIG9tIDExOjIxIHNj
aHJlZWYgSmVyb21lIEJydW5ldDoNCj4+IFdoZW4gdGhlIHVhYzIgZnVuY3Rpb24gaXMgc3RvcHBl
ZCwgdGhlcmUgc2VlbXMgdG8gYmUgYW4gaXNzdWUgd2l0aCBzb21lDQo+PiBwbGF0Zm9ybXMgKElu
dGVsIE1lcnJpZmllbGQgYXQgbGVhc3QpDQo+Pg0KDQpUaGUgaXNzdWUgaXNuJ3QgaGFyZHdhcmUg
c3BlY2lmaWMuDQoNCj4+IEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwgYWRk
cmVzczogMDAwMDAwMDAwMDAwMDAwOA0KPj4gLi4uDQo+PiBSSVA6IDAwMTA6ZHdjM19nYWRnZXRf
ZGVsX2FuZF91bm1hcF9yZXF1ZXN0KzB4MTkvMHhlMA0KPj4gLi4uDQo+PiBDYWxsIFRyYWNlOg0K
Pj4gwqAgZHdjM19yZW1vdmVfcmVxdWVzdHMuY29uc3Rwcm9wLjArMHgxMmYvMHgxNzANCj4+IMKg
IF9fZHdjM19nYWRnZXRfZXBfZGlzYWJsZSsweDdhLzB4MTYwDQo+PiDCoCBkd2MzX2dhZGdldF9l
cF9kaXNhYmxlKzB4M2QvMHhkMA0KPj4gwqAgdXNiX2VwX2Rpc2FibGUrMHgxYy8weDcwDQo+PiDC
oCB1X2F1ZGlvX3N0b3BfY2FwdHVyZSsweDc5LzB4MTIwIFt1X2F1ZGlvXQ0KPj4gwqAgYWZ1bmNf
c2V0X2FsdCsweDczLzB4ODAgW3VzYl9mX3VhYzJdDQo+PiDCoCBjb21wb3NpdGVfc2V0dXArMHgy
MjQvMHgxYjkwIFtsaWJjb21wb3NpdGVdDQo+Pg0KPj4gVGhlIGlzc3VlIGhhcHBlbnMgb25seSB3
aGVuIHRoZSBnYWRnZXQgaXMgdXNpbmcgdGhlIHN5bmMgdHlwZSAiYXN5bmMiLA0KPj4gbm90DQo+
PiAiYWRhcHRpdmUiLiBUaGlzIGluZGljYXRlcyB0aGF0IHByb2JsZW0gaXMgbGlrZWx5IGNvbWlu
ZyBmcm9tIHRoZQ0KPj4gZmVlZGJhY2sNCj4+IGVuZHBvaW50LCB3aGljaCBpcyBvbmx5IHVzZWQg
d2l0aCBhc3luYyBzeW5jaHJvbml6YXRpb24gbW9kZS4NCg0KVGhpcyBkb2VzIG5vdCBkZXNjcmli
ZSB0aGUgYWN0dWFsIHByb2JsZW0uIFRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlDQp1c2JfZXBfZGVx
dWV1ZSgpIGNhbiBiZSBhbiBhc3luY2hyb25vdXMgY2FsbCwgYW5kIHdlIGNhbid0IGZyZWUgdGhl
DQpyZXF1ZXN0IHVudGlsIGl0cyBjb21wbGV0aW9uIChmcm9tIGNhbmNlbGxhdGlvbikuDQoNCj4+
DQo+PiBVcGRhdGUgdGhlIGZlZWRiYWNrIGVuZHBvaW50IGZyZWUgZnVuY3Rpb24gdG8gcmVsZWFz
ZSB0aGUgZW5kcG9pbnQgdGhlDQo+PiBzYW1lDQo+PiB3YXkgaXQgaXMgZG9uZSBmb3IgdGhlIGRh
dGEgZW5kcG9pbnQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSmVyb21lIEJydW5ldCA8amJydW5l
dEBiYXlsaWJyZS5jb20+DQo+PiAtLS0NCj4+DQo+PiDCoCBIaSBGZXJyeSwNCj4+DQo+PiDCoCBX
b3VsZCB5b3UgbWluZCB0cnlpbmcgdGhpcyBiZWZvcmUgcmV2ZXJ0aW5nIHRoZSB3aG9sZSB0aGlu
ZyA/DQo+PiDCoCBUaGUgSFcgSSBoYXZlIGRpZCBub3Qgc2hvdyB0aGUgaXNzdWUgc28gZmFyIHNv
IEkgY2FuJ3QgcmVhbGx5IGNoZWNrDQo+PiDCoCBpZiBpdCBoZWxwcy4gSG9wZWZ1bGx5LCBpdCBk
b2VzIC4uLg0KPiANCj4gVGVzdGVkIHRoaXMgZXZlbmluZyBhbmQgY29uZmlybWluZyB0aGF0IHRo
aXMgcmVzb2x2ZXMgbXkgaXNzdWUuIEkgY2FuJ3QNCj4gc2F5IG11Y2ggYWJvdXQgdGhlIGNvZGUg
aXRzZWxmLCBtYXliZSBUaGluaD8NCg0KU3VyZS4gSSBjYW4gdGFrZSBhIGxvb2suDQoNCj4gDQo+
IFdvdWxkIGJlIGdyZWF0IGlmIHdlIGNvdWxkIGdldCB0aGlzIGluIGluc3RlYWQgb2YgcmV2ZXJ0
aW5nIHRoZSBzZXJpZXMuDQo+IA0KPiBUZXN0ZWQtYnk6wqAgRmVycnkgVG90aCA8ZnRvdGhAZXhh
bG9uZGVsZnQubmw+IChkd2MzIC8gSW50ZWwgTWVycmlmaWVsZCkNCj4gDQo+PiDCoCBkcml2ZXJz
L3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9hdWRpby5jIHwgMTUgKysrKysrKysrKystLS0tDQo+PiDC
oCAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3VfYXVkaW8uYw0KPj4g
Yi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9hdWRpby5jDQo+PiBpbmRleCAwMThkZDA5
Nzg5OTUuLjYzZDkzNDBmMDA4ZSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9m
dW5jdGlvbi91X2F1ZGlvLmMNCj4+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91
X2F1ZGlvLmMNCj4+IEBAIC0yMzAsNyArMjMwLDEzIEBAIHN0YXRpYyB2b2lkIHVfYXVkaW9faXNv
X2ZiYWNrX2NvbXBsZXRlKHN0cnVjdA0KPj4gdXNiX2VwICplcCwNCj4+IMKgwqDCoMKgwqAgaW50
IHN0YXR1cyA9IHJlcS0+c3RhdHVzOw0KPj4gwqAgwqDCoMKgwqDCoCAvKiBpL2Ygc2h1dHRpbmcg
ZG93biAqLw0KPj4gLcKgwqDCoCBpZiAoIXBybS0+ZmJfZXBfZW5hYmxlZCB8fCByZXEtPnN0YXR1
cyA9PSAtRVNIVVRET1dOKQ0KPj4gK8KgwqDCoCBpZiAoIXBybS0+ZmJfZXBfZW5hYmxlZCkgew0K
DQpwcm0tPmZiX2VwX2VuYWJsZWQgaXMgbm90IHByb3RlY3RlZC4gUG90ZW50aWFsIHJhY2UgcHJv
YmxlbSBoZXJlPw0KDQo+PiArwqDCoMKgwqDCoMKgwqAga2ZyZWUocmVxLT5idWYpOw0KPj4gK8Kg
wqDCoMKgwqDCoMKgIHVzYl9lcF9mcmVlX3JlcXVlc3QoZXAsIHJlcSk7DQo+PiArwqDCoMKgwqDC
oMKgwqAgcmV0dXJuOw0KPj4gK8KgwqDCoCB9DQo+PiArDQo+PiArwqDCoMKgIGlmIChyZXEtPnN0
YXR1cyA9PSAtRVNIVVRET1dOKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4+IMKg
IMKgwqDCoMKgwqAgLyoNCj4+IEBAIC00MjEsOSArNDI3LDEwIEBAIHN0YXRpYyBpbmxpbmUgdm9p
ZCBmcmVlX2VwX2ZiYWNrKHN0cnVjdA0KPj4gdWFjX3J0ZF9wYXJhbXMgKnBybSwgc3RydWN0IHVz
Yl9lcCAqZXApDQo+PiDCoMKgwqDCoMKgIHBybS0+ZmJfZXBfZW5hYmxlZCA9IGZhbHNlOw0KPj4g
wqAgwqDCoMKgwqDCoCBpZiAocHJtLT5yZXFfZmJhY2spIHsNCj4+IC3CoMKgwqDCoMKgwqDCoCB1
c2JfZXBfZGVxdWV1ZShlcCwgcHJtLT5yZXFfZmJhY2spOw0KPj4gLcKgwqDCoMKgwqDCoMKgIGtm
cmVlKHBybS0+cmVxX2ZiYWNrLT5idWYpOw0KPj4gLcKgwqDCoMKgwqDCoMKgIHVzYl9lcF9mcmVl
X3JlcXVlc3QoZXAsIHBybS0+cmVxX2ZiYWNrKTsNCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAodXNi
X2VwX2RlcXVldWUoZXAsIHBybS0+cmVxX2ZiYWNrKSkgew0KPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAga2ZyZWUocHJtLT5yZXFfZmJhY2stPmJ1Zik7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB1c2JfZXBfZnJlZV9yZXF1ZXN0KGVwLCBwcm0tPnJlcV9mYmFjayk7DQo+PiArwqDCoMKg
wqDCoMKgwqAgfQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHBybS0+cmVxX2ZiYWNrID0gTlVMTDsN
Cj4+IMKgwqDCoMKgwqAgfQ0KPj4gwqAgDQoNCk9uIGEgc2VwYXJhdGUgbm90ZSwgSSBub3RpY2Ug
dGhhdCBmX3VhYzIgb25seSBxdWV1ZXMgYSBzaW5nbGUgZmVlZGJhY2sNCnJlcXVlc3QgYXQgYSB0
aW1lIGZvciBpc29jIGVuZHBvaW50PyBFdmVuIHRob3VnaCB0aGUgaW50ZXJ2YWwgaXMgMW1zLA0K
dGhpcyB3aWxsIGVhc2lseSBjYXVzZSBkYXRhIGRyb3AuDQoNCkFsc28sIHlvdSdyZSBpZ25vcmlu
ZyBvdGhlciByZXF1ZXN0IGVycm9yIHN0YXR1cyBhbmQgc3RpbGwgcHJvY2Vzc2luZw0KYm9ndXMg
ZGF0YSBvbiByZXF1ZXN0IGNvbXBsZXRpb24/IFRoYXQgZG9lc24ndCBzZWVtIHJpZ2h0Lg0KDQpC
UiwNClRoaW5oDQo=
