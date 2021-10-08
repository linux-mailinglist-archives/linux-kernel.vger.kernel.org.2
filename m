Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E6C426476
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 08:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhJHGIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 02:08:37 -0400
Received: from mail-mw2nam12on2050.outbound.protection.outlook.com ([40.107.244.50]:6496
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229511AbhJHGId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 02:08:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUtgroyDaFgqKpPE+WKvbCgs+TXbVTyOOhv0QTkrGlAyWcnweTp4O5HdQUvcwhWo8usLDqNxuqhjwhLq7YWUMjzzda2fRpfJL+0YNwQoLihVPC3jDsB1vurtRj3Crt8VRA5NmxpCAIQEwWZt2xtaeEiJNGkPnlFwrF6d4a1Y2m/IJPjAqVeEA9JAur7zlIt6UkDSDNDhJjxzXbEqfSfYYBSkaMiJxnM2v5k0+a20MqbmazHUWrObblG/6WyLjJbgnHxfPH/rwjNR2YSelyMyNQyGZWCyt7vDFmpbHB+wCCNG0cxbcU/f1v9jRyCNUwsg7cW3XIR8hFpDWa8F3iBbJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PNd0TSBk8/7hN5+Mt0Y0Cc1Uqym5eKLLYNLMHr/XFk=;
 b=XU4Z+kGCxiwOpA8mY0XxYuLRy2h1Lg+2JvMToeMA5nxtxYKPTydJ9abEJieJlWL4fwG63s9wvvuELhT6DwsZP8eUITaFzAifPByXi5Ikz6EEgEEju8ApjfYVAY6PZT7XD31tFL5phMP6SoQd/SGGcYJacZ09PGuBnPiyNllbS+4Rz6D9yeKMLkjS93HpoyNXs8DPqLqBlduOBi7UhmNL6V/1+JaGR036c3MTHMWNcoiTitZmhLm7TplNR/qTo8XK/CdZX8nVNoLIwgdzknpkN36p6mREhSCahngN+8LVvCcr0jaETXbHqxmD6YPoTWdDz7irzmTUsFqDO50bYiN9TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PNd0TSBk8/7hN5+Mt0Y0Cc1Uqym5eKLLYNLMHr/XFk=;
 b=XsC9mjsi+yBzDUTOyOpZ1AAXy1Pw02CODrHmiA4o04drVqIAXkl5tFzscOjkGcdOmFWsUmDzthwhWxm0eyjkFEBVMnxcEbtSRvrnJkKbBwRghaWvCBSsJNyuB2NPUqrSUpt5GU4hDt/a7yNiXcTv6RREv/zt0467ymiB3+Kv3/E=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BY5PR05MB6835.namprd05.prod.outlook.com (2603:10b6:a03:1f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.13; Fri, 8 Oct
 2021 06:06:34 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::fd9a:e92c:5d9e:9f6d]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::fd9a:e92c:5d9e:9f6d%7]) with mapi id 15.20.4587.019; Fri, 8 Oct 2021
 06:06:34 +0000
From:   Nadav Amit <namit@vmware.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 2/2] mm/mprotect: do not flush on permission promotion
Thread-Topic: [PATCH 2/2] mm/mprotect: do not flush on permission promotion
Thread-Index: AQHXu3S78aiUxqowA0eKkUItBU98VavHtlGAgAAOXQCAANmxgA==
Date:   Fri, 8 Oct 2021 06:06:34 +0000
Message-ID: <DA49DBBB-FFEE-4ACC-BB6C-364D07533C5E@vmware.com>
References: <20210925205423.168858-1-namit@vmware.com>
 <20210925205423.168858-3-namit@vmware.com>
 <5485fae5-3cd6-9dc3-0579-dc8aab8a3de1@redhat.com>
 <5356D62E-1900-4E92-AF23-AA5625EFFD92@vmware.com>
 <1952fc7c-fb21-7d0e-661b-afa59b4580e5@redhat.com>
In-Reply-To: <1952fc7c-fb21-7d0e-661b-afa59b4580e5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b34a427-78e5-4805-eae5-08d98a21c7e1
x-ms-traffictypediagnostic: BY5PR05MB6835:
x-microsoft-antispam-prvs: <BY5PR05MB683530102E312E970CF3ED10D0B29@BY5PR05MB6835.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CZClNmUHdVZNivHlCbJjb9NHqFcGSPao4nhK7l051jzzL1WN1YmkHT9pwDFLHpSAJEuin5hm8DofWO8ulACd1VqLgp27eEuY6Ai2U0VKgbzkT7Kx8ZykonsWF7DYZ11PL8lqBpYA2uq/9u40RwNHEj3hTKNwwsWUDXbCCyi7G6CNkwNwPZOuC4BNEuepGDdzYe9P8EhkIutb0gUQ+KrwfBjW7/GNZ1eZgtPDcaxJ2ygt++x9h/xfhP8UZJweBXQ3EOO6WSeWfQ7lhLn6feRbWPNXlb5lAEh52zH9MzyWIXMuGZhguO7Tf9GWN4n6koODWRQRHRFTLjLx6c3rMNK0ZXrrJVA7tKkZ+enLtZXz/LdljPNH6nsK+yD5rlnwoC7ecULANzr/jUfv4cZgGxZd4QJ0wbkuZuaU5q4IcbAdsmsWvP/zhuRIitpYX4pKX806Nh7kOBkRG/K3y0BqKKqSy+VIDqlcc7UxaSQfIixelgheovjudISZR0SX/uDEMtpwR/AwTWL/aPY5ESsUbT7LK1zil4B5/HUmbRXiJBrATYxnfb6Ca2IwkqG5Utm3dipiUHVN6MOEOOjG9ikxNvGDUlT0+sTMERK84MVozudEIt+tA3d9nQUfGsZ7Bnt5wI8a12Cs3UD+/ZHcP6BxM7/cxlFdGTVp9b8oOoHCy1hY/6Djs5SYuIdS1UyB1RGkVSe2kEvLmNvvGG07/r8nO+0QTrH36g4Paq6hzLFLR0ioiJqtkXYGIKyfhvwaNWZMYVkp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(64756008)(38100700002)(6916009)(38070700005)(76116006)(66476007)(66446008)(2616005)(5660300002)(71200400001)(66556008)(2906002)(8936002)(7416002)(122000001)(508600001)(8676002)(186003)(33656002)(83380400001)(53546011)(86362001)(316002)(26005)(54906003)(6506007)(66946007)(6512007)(4326008)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RElBZHZ6ZTA2Rm9senpSN3NXaXRGcHFUYXVUVHNwdVEvZzB4RGNGbWpwRlU1?=
 =?utf-8?B?NXRPNnlUT2t5cEVSckY0VUFRSXpLMEhqdGl4aUM0RUZIS0RIcm9tT3djU0V1?=
 =?utf-8?B?eXlUemlpUHhsby9GY3NySFQzWmpXRXNWZXR5RTI1Sm5CR3NuYVNSNGN4cEJs?=
 =?utf-8?B?SHR2ajl2K0RDcmJxVWhDZ092VlkvU3NmRjJtblY1ckIxM245RG4wWVl2eW9i?=
 =?utf-8?B?SFFlUXFPZmNiUEtITjQ5bGhidVV1bk80MnBMUWh3TEhkRkJuOGt4ekMxcW96?=
 =?utf-8?B?VFU1YS9yWCsvSUR4SG5qaEVOZTFHSTFJZWRKb1dWek9ITWo3M1JyajRJM0lH?=
 =?utf-8?B?NGorS0k5bFdvM0dvcmNsS1Fsb2JuSUl4NUJhTDJXalFWeWx5dU84bXlUTVJJ?=
 =?utf-8?B?MU54eVU5dmlaTjU4WnVvRHFsc3dnYmwxWnBWVlNqQmlHaE5aVDAzV3RXVnd6?=
 =?utf-8?B?R1dYbFFuU0JTaTJaaWtQQWl1Q3BPTk5temdMSHlKQ0xCN292MTdHeVJwUk9F?=
 =?utf-8?B?QnNnRTUyN3JZMEVTcVNHNEIrQ1FTVVJQQk5VMDhpdGJpY2xqQ204WVJBS0VG?=
 =?utf-8?B?OVhJc1lDUFNRRGRLM0dJNlVYR2FXOTRaRWU4WUtBOG8zWkpGNHg3U1hrKy9T?=
 =?utf-8?B?ZVNmUmMwZ21BcE83b29tZTdpdXRUQTB0cURFcW5DUlY0WWx3eEs0d1dYWDlK?=
 =?utf-8?B?UG15UG1HNUtkbHVpMndhWURYSXdLQXBiellncWxCMjVkdG1nakJxLzI3MExi?=
 =?utf-8?B?ZHpmc2FwNml6N0E3djlON3Y3ZEJzRUFkaVdyUCt0dnJoNVpiemk0dGVUQ2xP?=
 =?utf-8?B?Q2VUNGo2OWhsOVh4UlJaMm0rc2VzZGcrNXpvMk16cUlSYlFLVkk0UzRLd3Br?=
 =?utf-8?B?WWJ3NDEzdWFMbDA5bDFNaTJHLzh4SGRnNld5TXhvSHZDeXBFc2FiTkt1ejQy?=
 =?utf-8?B?TGd3UVNrZDBOYXZpZE9ZdEg5QjFmR1lsSEttaHd3SXBjejBkMmoyak5uYklG?=
 =?utf-8?B?YllVSDRCMWFFaXVWUWZxdk8xcTIrVDR2U01uakFUdjNDemhNa0c3Z0Z4MjBz?=
 =?utf-8?B?U3Z2KzFST3c1MXpSU3p1djBONWEwL2V3MktyaGFpODcxVnZrcElLUEd5U0Nv?=
 =?utf-8?B?ckNGY25hQzNmS2JUSUtoM094ZDB2Q0d3K0lMMnhjNEI3MGZtekVNQzZPUDFy?=
 =?utf-8?B?V21WRWNjTDJUcW9ZbmozOFhqN3FJS0x3NDdobXlKQ2p5eDNTVGpDQXRaa1lN?=
 =?utf-8?B?ZkFPeWMra0t4OXJWTFJWcldZL0s2VGUxYndpYWdlaXFSK2dSQ0VsOXB2akk1?=
 =?utf-8?B?TE90YTFiTXVPOGNnakx5RTB0Kzh4T0MzRGtRM1A3T1RYbGtLVDVEZERCQnI3?=
 =?utf-8?B?cy9ZREVKaC9zM2VDbitJYmpHeGtJZUg1cGUxSjBBVlJEbjZKcDNkK0NRRE4w?=
 =?utf-8?B?NTVEZFNXaTdYYlRacnlhT0JwclBKLzBPNURlRTNGQjIyYllic3I0M1UwWm0x?=
 =?utf-8?B?bnB1RldKUm9aQzNidWpVS0VKYkVleTBycDJSYXhHSk10L1VjZm43d0ZCeWpF?=
 =?utf-8?B?WVZEQ3MwNkFNMjkrQ2hNRUpWSFpkcGlzdTdOWUhZQ21QUVNkOEUvZkc1R1E0?=
 =?utf-8?B?OTZzRURNelZQcGhRcmw3b0ZQei9ONWFNdU5mM3RVYjJPVTB2alZQZkJiMjFy?=
 =?utf-8?B?dkIyRTRBdjY4L3FKZFF3ejlJeHpTaWxxLzEveUFTa3lPSmNZaUZwOXBPNFF6?=
 =?utf-8?Q?zRQwwLy2YQTzlx7kFJV8uq3mi4z+jtKiiYyuQuW?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7941610003144A4FA21FB2A476570133@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b34a427-78e5-4805-eae5-08d98a21c7e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2021 06:06:34.1044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: odWXkbQb2Gc0D3tpO/GXa975bN66zregfyvFM5G/PfiE+dymM4A5Xx4RhxkNyn3jCfElQvEfkO1a+bagx6RJow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR05MB6835
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDcsIDIwMjEsIGF0IDEwOjA3IEFNLCBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2
aWRAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAwNy4xMC4yMSAxODoxNiwgTmFkYXYgQW1p
dCB3cm90ZToNCj4+PiBPbiBPY3QgNywgMjAyMSwgYXQgNToxMyBBTSwgRGF2aWQgSGlsZGVuYnJh
bmQgPGRhdmlkQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIDI1LjA5LjIxIDIyOjU0
LCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4+PiBGcm9tOiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUu
Y29tPg0KPj4+PiBDdXJyZW50bHksIHVzaW5nIG1wcm90ZWN0KCkgdG8gdW5wcm90ZWN0IGEgbWVt
b3J5IHJlZ2lvbiBvciB1ZmZkIHRvDQo+Pj4+IHVucHJvdGVjdCBhIG1lbW9yeSByZWdpb24gY2F1
c2VzIGEgVExCIGZsdXNoLiBBdCBsZWFzdCBvbiB4ODYsIGFzDQo+Pj4+IHByb3RlY3Rpb24gaXMg
cHJvbW90ZWQsIG5vIFRMQiBmbHVzaCBpcyBuZWVkZWQuDQo+Pj4+IEFkZCBhbiBhcmNoLXNwZWNp
ZmljIHB0ZV9tYXlfbmVlZF9mbHVzaCgpIHdoaWNoIHRlbGxzIHdoZXRoZXIgYSBUTEINCj4+Pj4g
Zmx1c2ggaXMgbmVlZGVkIGJhc2VkIG9uIHRoZSBvbGQgUFRFIGFuZCB0aGUgbmV3IG9uZS4gSW1w
bGVtZW50IGFuIHg4Ng0KPj4+PiBwdGVfbWF5X25lZWRfZmx1c2goKS4NCj4+Pj4gRm9yIHg4Niwg
UFRFIHByb3RlY3Rpb24gcHJvbW90aW9uIG9yIGNoYW5nZXMgb2Ygc29mdHdhcmUgYml0cyBkb2Vz
DQo+Pj4+IHJlcXVpcmUgYSBmbHVzaCwgYWxzbyBhZGQgbG9naWMgdGhhdCBjb25zaWRlcnMgdGhl
IGRpcnR5LWJpdC4gQ2hhbmdlcyB0bw0KPj4+PiB0aGUgYWNjZXNzLWJpdCBkbyBub3QgdHJpZ2dl
ciBhIFRMQiBmbHVzaCwgYWx0aG91Z2ggYXJjaGl0ZWN0dXJhbGx5IHRoZXkNCj4+Pj4gc2hvdWxk
LCBhcyBMaW51eCBjb25zaWRlcnMgdGhlIGFjY2Vzcy1iaXQgYXMgYSBoaW50Lg0KPj4+IA0KPj4+
IElzIHRoZSBhZGRlZCBMT0Mgd29ydGggdGhlIGJlbmVmaXQ/IElPVywgZG8gd2UgaGF2ZSBzb21l
IGJlbmNobWFyayB0aGF0IHJlYWxseSBiZW5lZml0cyBmcm9tIHRoYXQ/DQo+PiBTbyB5b3UgYXNr
IHdoZXRoZXIgdGhlIGFkZGVkIH4xMCBMT0MgKG5ldCkgd29ydGggdGhlIGJlbmVmaXQ/DQo+IA0K
PiBJIHJlYWQgICIzIGZpbGVzIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkiIHRvIG9wdGltaXplIHNvbWV0aGluZyB3aXRob3V0IHByb29mLCBzbyBJIG5hdHVyYWxseSBo
YXZlIHRvIGFzay4gU28gdGhpcyBpcyBqdXN0IGEgInVzdWFsbHkgd2Ugb3B0aW1pemUgYW5kIHNo
b3cgbnVtYmVycyB0byBwcm9vZiIgY29tbWVudC4NCg0KVGhlc2UgbnVtYmVycyBhcmUgbWlzbGVh
ZGluZywgYXMgdGhleSBjb3VudCBjb21tZW50cyBhbmQgb3RoZXIgbm9uLWNvZGUuDQoNCltzbmlw
XQ0KDQo+IA0KPiBBbnkgbnVtYmVycyB3b3VsZCBiZSBoZWxwZnVsLg0KPiANCj4+IElmIHlvdSB3
YW50LCBJIHdpbGwgd3JpdGUgYSBtaWNyb2JlbmNobWFya3MgYW5kIGdpdmUgeW91IG51bWJlcnMu
DQo+PiBJZiB5b3UgbG9vayBmb3IgZnVydGhlciBvcHRpbWl6YXRpb25zIChhbHRob3VnaCB5b3Ug
ZGlkIG5vdCBpbmRpY2F0ZQ0KPj4gc28pLCBzdWNoIGFzIGRvaW5nIHRoZSBUTEIgYmF0Y2hpbmcg
ZnJvbSBkb19tcHJvdGVjdF9rZXkoKSwNCj4+IChpLmUuIGJhdGNoaW5nIGFjcm9zcyBWTUFzKSwg
d2UgY2FuIGRpc2N1c3MgaXQgYW5kIGFwcGx5IGl0IG9uDQo+PiB0b3Agb2YgdGhlc2UgcGF0Y2hl
cy4NCj4gDQo+IEkgdGhpbmsgdGhpcyBwYXRjaCBpdHNlbGYgaXMgc3VmZmljaWVudCBpZiB3ZSBj
YW4gc2hvdyBhIGJlbmVmaXQ7IEkgZG8gd29uZGVyIGlmIGV4aXN0aW5nIGJlbmNobWFya3MgY291
bGQgYWxyZWFkeSBzaG93IGEgYmVuZWZpdCwgSSBmZWVsIGxpa2UgdGhleSBzaG91bGQgaWYgdGhp
cyBtYWtlcyBhIGRpZmZlcmVuY2UuIEV4Y2Vzc2l2ZSBtcHJvdGVjdCgpIHVzYWdlIChwcm90ZWN0
PD51bnByb3RlY3QpIGlzbid0IHNvbWV0aGluZyB1bnVzdWFsLg0KDQpJIGRvIG5vdCBrbm93IGFi
b3V0IGEgY29uY3JldGUgYmVuY2htYXJrIChvdGhlciB0aGFuIG15IHdvcmtsb2FkLCB3aGljaCBJ
IGNhbm5vdCBzaGFyZSByaWdodCBub3cpIHRoYXQgZG9lcyBleGNlc3NpdmUgbXByb3RlY3QoKSBp
biBhIHdheSB0aGF0IHdvdWxkIGFjdHVhbGx5IGJlIG1lYXN1cmFibGUgb24gdGhlIG92ZXJhbGwg
cGVyZm9ybWFuY2UuIEkgd291bGQgYXJndWUgdGhhdCBtYW55IG1hbnkgb3B0aW1pemF0aW9ucyBp
biB0aGUga2VybmVsIGFyZSBzdWNoIHRoYXQgd291bGQgbm90IGhhdmUgc28gbWVhc3VyYWJsZSBi
ZW5lZml0IGJ5IHRoZW1zZWx2ZXMgb24gY29tbW9uIG1hY3JvYmVuY2htYXJrcy4NCg0KQW55aG93
LCBwZXIgeW91ciByZXF1ZXN0IEkgY3JlYXRlZCBhIHNtYWxsIG1pY3JvLWJlbmNobWFyayB0aGF0
IHJ1bnMgbXByb3RlY3QoUFJPVF9SRUFEKSBhbmQgbXByb3RlY3QoUFJPVF9SRUFEfFBST1RfV1JJ
VEUpIGluIGEgbG9vcCBhbmQgbWVhc3VyZWQgdGhlIHRpbWUgaXQgdG9vayB0byBkbyB0aGUgbGF0
dGVyICh3aGVyZSBhIHdyaXRlcHJvdGVjdCBpcyBub3QgbmVlZGVkKS4gSSByYW4gdGhlIGJlbmNo
bWFyayBvbiBhIFZNIChndWVzdCkgb24gdG9wIG9mIEtWTS4NCg0KVGhlIGNvc3QgKGN5Y2xlcykg
cGVyIG1wcm90ZWN0KFBST1RfUkVBRHxQUk9UX1dSSVRFKSBvcGVyYXRpb246DQoNCgkJMSB0aHJl
YWQJCTIgdGhyZWFkcw0KCQktLS0tLS0tLQkJLS0tLS0tLS0tDQp3L3BhdGNoOgkyNDk2CQkJMjUw
NQkJCQ0Kdy9vIHBhdGNoOgk1MzQyCQkJMTA0NTgNCg0KWyBUaGUgcmVzdWx0cyBmb3IgMSB0aHJl
YWQgbWlnaHQgc2VlbSBzdHJhbmdlIGFzIG9uZSBjYW4gZXhwZWN0IHRoZSBvdmVyaGVhZCBpbiB0
aGlzIGNhc2UgdG8gYmUgbm8gbW9yZSB0aGFuIH4yNTAgY3ljbGVzLCB3aGljaCBpcyB0aGUgdGlt
ZSBhIFRMQiBpbnZhbGlkYXRpb24gb2YgYSBzaW5nbGUgUFRFIHRha2VzLiBZZXQsIHRoaXMgb3Zl
cmhlYWQgYXJlIHByb2JhYmx5IHJlbGF0ZWQgdG8g4oCccGFnZSBmcmFjdHVyaW5n4oCdLCB3aGlj
aCBoYXBwZW5zIHdoZW4gdGhlIFZNIG1lbW9yeSBpcyBiYWNrZWQgYnkgNEtCIHBhZ2VzLiBJbiBz
dWNoIHNjZW5hcmlvcywgYSBzaW5nbGUgUFRFIGludmFsaWRhdGlvbiBpbiB0aGUgVk0gY2FuIGNh
dXNlIG9uIEludGVsIGEgZnVsbCBUTEIgZmx1c2guIFRoZSBmdWxsIGZsdXNoIGlzIG5lZWRlZCB0
byBlbnN1cmUgdGhhdCBpZiB0aGUgaW52YWxpZGF0ZWQgYWRkcmVzcyB3YXMgbWFwcGVkIHRocm91
Z2ggaHVnZSBwYWdlIGluIHRoZSBWTSwgYW55IHJlbGV2YW50IDRLQiBtYXBwaW5nIHRoYXQgaXMg
Y2FjaGVkIGluIHRoZSBUTEIgKGFmdGVyIGZyYWN0dXJpbmcgZHVlIHRvIHRoZSA0S0IgR1BBLT5I
UEEgbWFwcGluZykgd291bGQgYmUgcmVtb3ZlZC5dDQoNCkxldCBtZSBrbm93IGlmIHlvdSB3YW50
IG1lIHRvIHNoYXJlIHRoZSBtaWNyby1iZW5jaG1hcmsgd2l0aCB5b3UuIEkgYW0gbm90IGdvaW5n
IHRvIG1lbnRpb24gdGhlIHJlc3VsdHMgaW4gdGhlIGNvbW1pdCBsb2csIGJlY2F1c2UgSSB0aGlu
ayB0aGUgb3ZlcmhlYWQgb2YgdW5uZWNlc3NhcnkgVExCIGludmFsaWRhdGlvbiBpcyB3ZWxsIGVz
dGFibGlzaGVkLg0KDQo=
