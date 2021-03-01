Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D891329B0E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 11:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378531AbhCBBGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 20:06:45 -0500
Received: from mail-dm6nam12on2077.outbound.protection.outlook.com ([40.107.243.77]:9760
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235993AbhCATCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 14:02:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfcyjOQrTMXi22KDrQePDpgJRdxoAQZL/TL3Ly7skPkeFqsBUQOn52vRPODNGHpmc/QY3Oqd+QNz+hm68PYzhW4m6QHP2zYo5W9MpbQEEqt5T38dgWGHi9zpHgQAj+oUX9Byzuer66wCcybSqa3pGSZ78QHLXJf7IBfpugSoXtIWFkpcMnMYHA3FByd3lJNhA0VnZRnBaJqXwcbao+Y/jl1O4Du/hYZ+yIaGfkB6qsZEUEp93IyUpnWHtRY7WE2/nr+eCO74LnyzXkm1ilaExzeTAv7X3Z73J1sOlXxOPeT3f/NxMp+nWq4oi/pOCvrNc6VKYXMh2wDDNBxQ1uXcLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYF8mDembdYw5T35qdwlI36S128oAKYH1FSd8RBXvPc=;
 b=bk/QEgPkYZsvQYlYB+dwO7TRvsanbWIbKqt7u/6HjUkO06CB2ORMTNzfQK/QnA1D9428SNZcEMJke8EF7/TH+YkojICJ98s6rU3zvBz2CVJd8M1aatpcuZ17+fd23Vl9ttJhWG/Nb2ooceSeqBv+Q6QTGg3MobdRK01sE+P2fwF4s7zJY4yI6R8JEXih68A7mT2nr3cMVaZjjmzFyZ8214lqz+DBBMknEqlSqvJ+w5xwJRFKtwcWFS+azYrDL2YOkpL2LmGQFJ/Yl182wg8Q/NJecYp7QZCclGqSnQGSF1TUSq50nwqAbR9xSuizivj9PFbAx18xIZs2GYSzWp2OOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYF8mDembdYw5T35qdwlI36S128oAKYH1FSd8RBXvPc=;
 b=F604Gqxmwv8gLxGbz77m38fRLVNp7gUhhTdwHLtEDqw/yHROnykrWuFwBONDBKpepRw0ACOtcYi/ly9UaRpzgfzKOXB6nsdADBrdy2dBfydtXY3eJ98yJU2DHLRFcDjy31vGl6PQ/Q1TSCJDh41OjQUqFbW/3oQI4BhEB7DqlSE=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BYAPR05MB6037.namprd05.prod.outlook.com (2603:10b6:a03:d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9; Mon, 1 Mar
 2021 19:01:14 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::5905:ca03:9fa3:ab50]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::5905:ca03:9fa3:ab50%7]) with mapi id 15.20.3912.009; Mon, 1 Mar 2021
 19:01:14 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v6 1/9] smp: Run functions concurrently in
 smp_call_function_many_cond()
Thread-Topic: [PATCH v6 1/9] smp: Run functions concurrently in
 smp_call_function_many_cond()
Thread-Index: AQHXDr3d3TEnHlWiMUmQGWL5BJIAGapvfQIA
Date:   Mon, 1 Mar 2021 19:01:13 +0000
Message-ID: <DB46F034-878B-448B-BDBF-C25056C6576C@vmware.com>
References: <20210220231712.2475218-1-namit@vmware.com>
 <20210220231712.2475218-2-namit@vmware.com>
 <YD0gF9VuqKyVUgVS@hirez.programming.kicks-ass.net>
In-Reply-To: <YD0gF9VuqKyVUgVS@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4918fb0-2215-4a7d-f960-08d8dce462c2
x-ms-traffictypediagnostic: BYAPR05MB6037:
x-microsoft-antispam-prvs: <BYAPR05MB60371C2EE8495925D4A0F18FD09A9@BYAPR05MB6037.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Da0auVpUb6xju8S6eKtTUHuNhuK8bWGiVXPYWu+EzDcxbEMv0IgDf9dgmWUFpT7B6UxgcfSwSQWc8vsw7jRNY3CkbaE5E9GJnPzL85wIPUwtodgT2biGI+2LXGn0PUPGNNwxk0qM65j1dlvt7puGQqmXI7DxPt9kfD0AMBOe+6SErFPIRDLobar0+aeW6K2BEXu/75F7TNgUkjWiYnn+JPAg6dHu3TlBoatWI2Zxn3zR9xHa7Ru8hdDeFEmc+M/XLG/X0X//prokBojwoiBxIV1/AIY8m2s78TmCjJ4KiFxxRkKghZjk7x6H87CzW7vmCdEUNVYGIN3dryZz1nfNVmi6JJcpwDnd/aIMTWZVVvaCe9Qc8ViFcakvXlfJL5HOIG7EShPxeNDNOxu7BeIJ+UBF/Mw62DoXriaNFD8iDdelwze9AnpN0g4khDO162ftadOb6V5kpuuZFwfHNhSVW0RasWf6hUku2mnTAMegxqEimD1AW2fs756G8v0Tsa9UqzKm9s1LEGb5bzmUHYbk7wA29u4CvP6B+uwkorK5PUTa97nOcaGJ4pxKebo1Zf94y5eKNm+zfK0ejwl6p5Q0Cg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(66476007)(36756003)(6916009)(71200400001)(66556008)(64756008)(53546011)(66446008)(33656002)(2906002)(66946007)(6506007)(76116006)(83380400001)(316002)(54906003)(8936002)(8676002)(6486002)(5660300002)(478600001)(186003)(6512007)(4744005)(86362001)(4326008)(2616005)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WWdMMGVvNjVlbFVJeUZoTEx4cmhaTDlNVkFqdDNlWkZPTFdrU0Iwb0Z1YWd3?=
 =?utf-8?B?L3NLdGFWdlJqVjFXYW14TERMRlpqdGo3azhpMTRQUkxySTRBdFRDUEtPZGNY?=
 =?utf-8?B?SU0xaEtkQkpkTFd6b2VlWXY0a0pMVG1md3owSkxGM3ZLd1BRdFJTZVFyTEZI?=
 =?utf-8?B?UUwzY3FmQ0lXN0cvYmV0OW5kNTh5YVlsa0hmK1BKTERGc2V6ZEVxTVlnUEEy?=
 =?utf-8?B?TlU3WDRHT2FMWHRkQ2JPR3c2M0Z4ODRqRDN5WklpK1pTUGJYUTd1NGtvVGZv?=
 =?utf-8?B?VTBKZ2hDc2tBNVVSQ1NGTCsrMjFjR09VK3NHTWEwa21XcmVmOGdtSHR6VjZj?=
 =?utf-8?B?bzNPWmpxOTdUZ2k1WlZZeEVQVk9rem00M0pNUG1jUFg3TU55QkFXbG1UcXF3?=
 =?utf-8?B?UzlrSVJxQ2FqWlg5cVVSaXQrUWJ6ZkdJUWxkdzF0MzVISDJwWFcxUjFPMlk0?=
 =?utf-8?B?Ri9OcDB0eEZaSlRWQ3VlUjFTbXRVQThrMEJJQlZ3TUZJZzdBZCs2aS9RTVV0?=
 =?utf-8?B?TGJDZW1aNmxhWm5nbkloRktsUWliY2lMakNySmRIeG1HUVlzSUh6VjRkdEZp?=
 =?utf-8?B?SzZPaTFTTHRSaU1BNUhPNWxneWhSNVJDbC9HSk1aaG5zVzZsTmpjVFA4d1N0?=
 =?utf-8?B?UUlwSWtHZFRtUkxpT0hvT3FqOFR0ZTlXOEl1VWFEdlBJWWlWZ3JKdGl3dGxk?=
 =?utf-8?B?aTV1ZDFROTBvbUNtVUZXVmhWMTJESE5SWENXbkVkVFl6ZW05cndNS0haQjU2?=
 =?utf-8?B?QU5NS2k3dk1ONVZrUW1uRDJ5YTJnd1o1N1ljRHhLSmRpdzFqQ3lMWTh1U0Q2?=
 =?utf-8?B?ZTFvQ3J5Mm1KampPdW83RU5Fa2l6eWVCSXZwMWk5OHZBUE9BQUdxdWRMY2RS?=
 =?utf-8?B?NEcyS2lqdTRIZXpsWmZHY0ZaWWlnT052STdVZFVPbnU3eHpSWjFsczRrb0RG?=
 =?utf-8?B?Nk1vVTB5UllsakhMRm8xS3I2a2E4UzkxbWtkQkpkZHBYNndpSVpnVnVTcS92?=
 =?utf-8?B?ck5VY2N0TDBtSm4zR0xRRDJwTGxMbEc1ejNTZStlS1VIVTVQMGRoamw2UmM2?=
 =?utf-8?B?byttdEVtYVRKcnVLMUFxcm5Fa05EZG5ZRkdjdWp6UmRaY2pPNVMzeDNCc1BH?=
 =?utf-8?B?SWVnSEpuMUV4dzgxcHl5RGNqYWZMdVBQTk5paUZ6bWYzbEhEVHlIM1graWlz?=
 =?utf-8?B?NzVBTmMxd1BhWE4wNDI0QXhLODNQYnQwREcyTHNibWZzS25sTnY4VXlIWG1p?=
 =?utf-8?B?M25NVHhxNkVyNFlvZWpHays5bDQySEhtdzF5UUpjdHNxUVpPOWFKT3FOQ3dP?=
 =?utf-8?B?bzN5WWtmSlpHSGNtY25ucll4TGtzdmFwWWtabHJuSEJlcW15Rksyd0NXTkNR?=
 =?utf-8?B?T3BLdUxFYmlFTjFkblhTbVdrUWk0QWxpTFZVNkFsMGE5aGdzTTIxa3I2NFNV?=
 =?utf-8?B?cWlRWFczQkE5UU1WL2lOVTRJdjJaTUh2aE1YNjBSMVcyRU5qTnVEZ0ZueGJZ?=
 =?utf-8?B?ci9lNGJ4KytsMkM1dThoRjBuenhDRTY1aVI0Qkpka0hBNEtmRXNlMlV6ZU81?=
 =?utf-8?B?ZFpaOS9wcU5qckl5akdidUU4OHdZSGlseU5rZEpaZEprcVZPNzhOL1RxVkFI?=
 =?utf-8?B?bjM2ZjdSMnhWV2I0TCtISmNqL2c0ck9GTGlJR1VRRThaS2dGMzd4d0IzVTIz?=
 =?utf-8?B?YUJNR0RsSVNUd3EwSzN2eHR0UVlGNnVoK0RKTzJLcmRKRmpPcnpBVldxVlBZ?=
 =?utf-8?Q?Pb43iFsl77PK3xmLobqyQ2p2GRurNNWnlh3gHi6?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDC096FE0308E44A958520528A6DC935@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4918fb0-2215-4a7d-f960-08d8dce462c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 19:01:13.9514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IiLzE0psAQ9+Y4gvM+Ork7hOXqyzjZn29bDa+wEIkV7JTE4boHq0zaTcUEHoZuA/xTIkVrAIidLuC/jeN6wzCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6037
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWFyIDEsIDIwMjEsIGF0IDk6MTAgQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpA
aW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBTYXQsIEZlYiAyMCwgMjAyMSBhdCAwMzox
NzowNFBNIC0wODAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4gKwkJLyoNCj4+ICsJCSAqIENob29z
ZSB0aGUgbW9zdCBlZmZpY2llbnQgd2F5IHRvIHNlbmQgYW4gSVBJLiBOb3RlIHRoYXQgdGhlDQo+
PiArCQkgKiBudW1iZXIgb2YgQ1BVcyBtaWdodCBiZSB6ZXJvIGR1ZSB0byBjb25jdXJyZW50IGNo
YW5nZXMgdG8gdGhlDQo+PiArCQkgKiBwcm92aWRlZCBtYXNrLg0KPj4gKwkJICovDQo+PiArCQlp
ZiAobnJfY3B1cyA9PSAxKQ0KPj4gKwkJCWFyY2hfc2VuZF9jYWxsX2Z1bmN0aW9uX3NpbmdsZV9p
cGkobGFzdF9jcHUpOw0KPj4gKwkJZWxzZSBpZiAobGlrZWx5KG5yX2NwdXMgPiAxKSkNCj4+ICsJ
CQlhcmNoX3NlbmRfY2FsbF9mdW5jdGlvbl9pcGlfbWFzayhjZmQtPmNwdW1hc2tfaXBpKTsNCj4g
DQo+IEkganVzdCByYW4gaW50byBjb25mbGljdHMgd2l0aCBhbm90aGVyIHBhdGNoIHNldCwgYW5k
IG5vdGljZWQgdGhhdCB0aGUNCj4gYWJvdmUgc2hvdWxkIHByb2JhYmx5IGJlOg0KPiANCj4gCQlp
ZiAobnJfY3B1cyA9PSAxKQ0KPiAJCQlzZW5kX2NhbGxfZnVuY3Rpb25fc2luZ2xlX2lwaShsYXN0
X2NwdSk7DQo+IAkJZWxzZSBpZiAobGlrZWx5KG5yX2NwdXMgPiAxKSkNCj4gCQkJYXJjaF9zZW5k
X2NhbGxfZnVuY3Rpb25faXBpX21hc2soY2ZkLT5jcHVtYXNrX2lwaSk7DQo+IA0KPiBXaGljaCB3
aWxsIGF2b2lkIHRoZSBJUEkgd2hlbiBAbGFzdF9jcHUgaXMgaWRsZS4NCg0KR29vZCBwb2ludC4g
TWFrZXMgb25lIHdvbmRlciB3aGV0aGVyIGFsbCB0aGVzZSBpbnRlci1jb3JlIGNvbW11bmljYXRp
b24NCih0aHJvdWdoIGNwdV90bGJzdGF0ZS5pc19sYXp5LCBjc2QtPm5vZGUubGxpc3QgYW5kIHRp
LT5mbGFncykgYXJlDQpyZWFsbHkgbmVjZXNzYXJ5IG9yIGNhbiBiZSBjb21iaW5lZC4NCg0KV2Vs
bCwgdGhhdOKAmXMgZm9yIGxhdGVyIEkgcHJlc3VtZS4=
