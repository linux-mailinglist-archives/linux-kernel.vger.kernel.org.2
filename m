Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EA43906C8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 18:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhEYQli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 12:41:38 -0400
Received: from esa.hc3962-90.iphmx.com ([216.71.140.77]:10979 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhEYQlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 12:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1621960806; x=1622565606;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CO+Kt3daz39D1x3xrVFLpJ8qfD4ZidMr7ddUR7obdPg=;
  b=By5/NODm1udL5x83w175m5l0AKmGi/Iiaig/Kx9PuOKllo1iFShsok7M
   Xwoz4i7PjVO67oSmVXrQxFM7PYxQ887dU374ftAcO4lMaUObH3X0wT8Xe
   OUQcGHnfrFtE0U0ic9ZzHm6XKmAp3A6SNkiXwYey+vWT6bO7n7+oRRwNO
   k=;
IronPort-SDR: BoWy6N8abj3ApBQE8Uzpb9gda3BoEWSdJ6MV8nQV2NV+pbSDVYt75imD07yeNCGah2WlCP2BLV
 SuU/B0HrMHa61N7O3vMo9eh1UoZZ4vpFhU01nP8QQivEsAHylrM8mjnkgDcSeoxzog+DBYL1ul
 JDp+7a5ZsqUH/S/sTMO3Zq9QSuR0+VsLNO5XHYjFQexv3YZtt8hk4szy8QT8aajCHnW7CcSzQd
 cCtU1vASuksGvKHBmsf1873HAiu65KNLd8acseLGY3hoeJZbTn+r1TrtdQRjaVPgM0qDi3rAib
 7GI=
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 16:40:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7Efop/hi179ZnzgHGc+N3Owbe9jWrNEx4n7iq4K4uuQFPTxh78ll0E8nZN/jhmOhSeeTviLyE5hpLXNqwMu+OSCzBy0UWxdwZk21vJlt8C3fEDHA0c0uvgYKwDltVSM72FZm2B7nKtJhkRKMPf38r4shOSqaiBj83AW9r5A0Re0MVAlAGBnVfhST3JJF7+7GLEgl17iy3ArWgCBtctT1YkIWeoJs1qwGBPA3Qf6wlb8VUAKm8YTsH1MxtTvPbvx8wEAJzDlSqUZO+Pzq01w1I30jxbicjMqUDhfZjULdg7Etr9O15GaocB26opN/lWbsmsOvP78ztpcGvBaJVUTUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CO+Kt3daz39D1x3xrVFLpJ8qfD4ZidMr7ddUR7obdPg=;
 b=B4Go5vTdmwPr5lIHDPFINjwRHfaZ63+fWTgwV/vEZDZo3XBAWqfW7OD1JuCj+jQOdhqhZ8K4XbBjIqtHFR6cSNIiaTny1SjOe/V4YouIR9tVIOGUH9AJop07R5C55w7IylqnrSTgu6ERURCD2Sgogi1cTY7LjpnaHw1MsSBd+taTomBBipcnoqmdNZljWFLJ2FXnBh8q3N6dayMzzG25FghzYKOAbzHWO+aFiSbdzADvj78DghMTOt0f63ihEIh0+ciokrhzHW1XmA3JSvud4f4+uTcZk2H1IHkmXj8xRSQwPtEtlxN2vJiAczMWgmxsdaYm9c64ECY6LGoluGOdgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM5PR0201MB3557.namprd02.prod.outlook.com (2603:10b6:4:7f::24)
 by DM6PR02MB4570.namprd02.prod.outlook.com (2603:10b6:5:2e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 16:40:03 +0000
Received: from DM5PR0201MB3557.namprd02.prod.outlook.com
 ([fe80::5dd9:4dea:abee:1800]) by DM5PR0201MB3557.namprd02.prod.outlook.com
 ([fe80::5dd9:4dea:abee:1800%3]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 16:40:03 +0000
From:   "Qian Cai (QUIC)" <quic_qiancai@quicinc.com>
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Arm64 crash while online/offline memory sections
Thread-Topic: Arm64 crash while online/offline memory sections
Thread-Index: AddRetGCwamVTZ1PQ4mClPUkiBXM1gAAXfkAAAHuQUA=
Date:   Tue, 25 May 2021 16:40:03 +0000
Message-ID: <DM5PR0201MB35576550845B1682DC3F38E58E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
References: <DM5PR0201MB35576EF9B568FEE05FE58CF08E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
 <b34499c5-a330-1bfc-d564-8ebffb3236cd@redhat.com>
In-Reply-To: <b34499c5-a330-1bfc-d564-8ebffb3236cd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [163.116.135.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52e9cd60-079e-4db5-4ca4-08d91f9bbf37
x-ms-traffictypediagnostic: DM6PR02MB4570:
x-microsoft-antispam-prvs: <DM6PR02MB45704C6283EC6E06852245C4F2259@DM6PR02MB4570.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CIKg8bjuav9wjI1e+eFOhIWsjjUrALH1aMzSnzLzVY8zL7gIeYVHhIHqp9tvpiwnzCL/rlDpXoSey87wXcpJzLd0jldEPUWA5rZzyj9HQDI33OIDt0gebrSONiwRXClE3ZIuiuQ3V0siYNNNWbcNgM3DmBhaphQvgrTWnnWZAzyY+PL0C6uWk0jS08Uf17e6xuO7YvyYd7b4wPmGBBOqAdsUdi/ZT9modhUn7cgeKhQLGjMJhJz6oJBl8GqkgZBWUCBJmoDvXQx64A80JVfx2F0sIk15kRPyO2Iu4GDBtoTNhJzwKKMfTJj3W/dA3Acl3IhOXM5xhxfonQp3AYzT+agVC9n3Y470Zv3b9TcHEabDej2KCee6cP2pPDmfUKr7QXVgDU5tHG6RRpwpn3J5/ifLgF9MwyRiGrr2Z6bxMBCXEtZttpCZNDudAC3P98ECZ8XryZU86H+aqlHWAnHZaXVgT5LsLa9tIriwEGO8QOczbdD/UnYWDVe5VZOTw/hhmSiFd3570fH0sG4O8Uerr/cjO5xSy7cnYRO/zUyDoZiQ+1FR3Rk6w7ys0z99dqjJamlh9az2eHgFSw80IYbdzl++1kfzZGr8wyzhVEDyPLA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0201MB3557.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(186003)(55016002)(7696005)(54906003)(122000001)(38100700002)(5660300002)(4744005)(86362001)(83380400001)(316002)(71200400001)(66946007)(52536014)(66556008)(478600001)(64756008)(66446008)(66476007)(33656002)(2906002)(26005)(4326008)(110136005)(8936002)(8676002)(76116006)(9686003)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFppdWNURy9DNDJlZHBRSVQweko5K0NzdTZGZ0hoa3Z3TFo4NG9pc0pFeTA5?=
 =?utf-8?B?WTN4REJidTk1dGQ4N3N1Y0EvUmh3aGNsUzB2bnNsVzVNbFpWUnRVMFBzU0Z1?=
 =?utf-8?B?V01IK0tqU3UzOEp5VmpiNmZxaHdCWTBlbEpEb0R5a284UmNlUGNtODI1NXZO?=
 =?utf-8?B?NmpETWsrdTNXMFE0SjExczJUemlWQzZPRVgvY01IdlprVnBJN1BsU0UzZ3VL?=
 =?utf-8?B?VitnYStsMW9lek9nVkdvbUFYYjk5KzhaWDlnTFQrNkxwZmJGL1Y1R1g0U25r?=
 =?utf-8?B?VmV0cFhlNUhtdXRxQVhrRmVmeTRoNU0zL1EyNzNRQmZUUWUwdTRiS0NKbXBS?=
 =?utf-8?B?WFByMUpiTGV5ai9wc2krN1IzeHpKTzNldnl0Si9MQ2hlNHp1T0JHRkNFS3V3?=
 =?utf-8?B?SHdsRW9jbVhnMm4yMmxPVnhreTIvY2FVaDVqVmhVQW1NYldSdUJUdXFVaC9l?=
 =?utf-8?B?MDRoQ2FmODZ0QVUxMDFpcGxxVmFOZlF2d3dSRWtYRXFhSk4zSUpVY1RHc1hE?=
 =?utf-8?B?RHIycGozTzNNbGtZUG1TOXYzR1JabSt5K2tRUS9TbTNLWWJXakpqQWVOOGQ2?=
 =?utf-8?B?NkhVcWZFY2ZKazlxZmR6cm9zdDZJMmJ3eWhZSmZBRGdNczFFN3QvNUpuQWdp?=
 =?utf-8?B?NjdWTjFmUHpMMW5JQjh2dWd3M2o3UExxQkk1bkIxTDZTTitHa2JVN2RSVDhF?=
 =?utf-8?B?NzNkVmVpTzE0UytjZmNJcmx5a0JDcG1tdVBFbXlKWTZ0a290UUZwRDhsRW9H?=
 =?utf-8?B?aCtraXp1VmRvcVZId1c0aExTdEtkeEZWSlM4bkxGWUpwYXJQN1J3RjJnOFhP?=
 =?utf-8?B?MmxqckVMMXZITHVKaE5IYktqSThSOFk4RGU5dGNzT01kZ0FrSFZNUk1IdUJW?=
 =?utf-8?B?dUxVZEFZMzIrRnZiOE1qV0srY0JMS0EvS1E2OGR5UytBcTFIcTNYem9UODR6?=
 =?utf-8?B?RFBxVFV0YnRGcGhwSzh0d3VjN0N6dGxwaHlBN080cmcwd2NOUzFMSjgvMDd4?=
 =?utf-8?B?enhWRDB0NTRJVFI5K0JKVmR5S0VPdUpMdWwwTFV5a3VKVngrc0R3TG9KS0Ns?=
 =?utf-8?B?a0tOYk8zRTVqeUNnaWo1RG03dnViVlljZzIrVTBrYXhUR3FFaGVZT2UxQ2Jk?=
 =?utf-8?B?akl0Zm9aM0ZjNHhrd1B6MXVZdHNReHNnS1QyWjZwdDQwUFhKcFpkYnhhaHZS?=
 =?utf-8?B?RWY2eC84NFA1ZWw3RFV0cW5EZnJBdUsyRURBN1VHVytKRk4yUWdKZGszMnlX?=
 =?utf-8?B?NWhjOTNBYk13a2MxWXVWdXZCOHN4V0NqbHdhdUVlaDhQR3g4MkxDWkVnRzh4?=
 =?utf-8?Q?hu0km2lqy+?=
x-ms-exchange-antispam-messagedata-1: Iua3T/j3AZlxxtZkwP8jnIRasFWSlFzYM+1exEgA8Qb/L+tAkyh38iLxMXWjkxuPkDMZrbYapFxElLnBhXAYDjjJ89qIgbRjmB/tJd2uVEtxNyp6cy4RpQebpGE1luJFWNvboqZr8B2uE2boUjhuKy69BFMZyLVsUVX4hF+4+PeLZg/f9RgsXXFb1Cc5euH/rZd8smMAd2ChSAytS7bv3GDDhjDeBipM0wAaJRYpoOlJyt7M/nD/T2fJ8DkymgP3dtcOg5oOLtfgYvr7hyq2dmYNun7V7pVKIt89dCDsahlWdH0CYYzOFIOTwT2ZnjZ9msHfvlvH8OFPRbin5lMd1M5V
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0201MB3557.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e9cd60-079e-4db5-4ca4-08d91f9bbf37
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 16:40:03.6151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mCK5UYrRhbepVDmxXlG/KxqBTZRivt2xnEpIOs5WuhG+7KfvQrNI8CExMDql7EFaZmP2Z6T2BgvSLVo/nzYJJQdqdvRusI9PbVOD/UxCJTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4570
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhdmlkIEhpbGRlbmJyYW5k
IDxkYXZpZEByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMjUsIDIwMjEgMTE6NDAg
QU0NCj4gVG86IFFpYW4gQ2FpIChRVUlDKSA8cXVpY19xaWFuY2FpQHF1aWNpbmMuY29tPjsgT3Nj
YXIgU2FsdmFkb3INCj4gPG9zYWx2YWRvckBzdXNlLmRlPg0KPiBDYzogQW5kcmV3IE1vcnRvbiA8
YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz47IEFuc2h1bWFuIEtoYW5kdWFsDQo+IDxhbnNodW1h
bi5raGFuZHVhbEBhcm0uY29tPjsgVmxhc3RpbWlsIEJhYmthIDx2YmFia2FAc3VzZS5jej47DQo+
IE1pY2hhbCBIb2NrbyA8bWhvY2tvQGtlcm5lbC5vcmc+OyBMaW51eCBNZW1vcnkgTWFuYWdlbWVu
dCBMaXN0DQo+IDxsaW51eC1tbUBrdmFjay5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0
IDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IEFybTY0
IGNyYXNoIHdoaWxlIG9ubGluZS9vZmZsaW5lIG1lbW9yeSBzZWN0aW9ucw0KPiANCj4gT24gMjUu
MDUuMjEgMTc6MzYsIFFpYW4gQ2FpIChRVUlDKSB3cm90ZToNCj4gPiBSZXZlcnRpbmcgdGhlIHBh
dGNoc2V0ICJBbGxvY2F0ZSBtZW1tYXAgZnJvbSBob3RhZGRlZCBtZW1vcnkgKHBlcg0KPiBkZXZp
Y2UpIiBbMV0gZnJvbSB0b2RheSdzIGxpbnV4LW5leHQgZml4ZWQgYSBjcmFzaCB3aGlsZSBvbmxp
bmUvb2ZmbGluZQ0KPiBtZW1vcnkgc2VjdGlvbnMuDQo+IA0KPiBEbyB3ZSBrbm93IHdoaWNoIHBh
dGNoIGluIHBhcnRpY3VsYXIgaXMgcHJvYmxlbWF0aWM/DQoNCkkgZG9uJ3Qga25vdyB5ZXQuIEl0
IGNvdWxkIGJlIG1lc3N5IHRvIGRpdmUgaW50byBhIHBhdGNoc2V0IHdoaWNoIHVzdWFsbHkgaGFz
IGxlc3MgY2xlYXIgYm91bmRhcmllcywgYnV0IEknbGwgdHJ5IHRvIGRpZyBhIGJpdCBtb3JlLg0K
DQo=
