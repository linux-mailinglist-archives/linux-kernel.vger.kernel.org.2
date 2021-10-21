Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65C5436392
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhJUN6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 09:58:09 -0400
Received: from mail-dm6nam10on2063.outbound.protection.outlook.com ([40.107.93.63]:37755
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230471AbhJUN6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:58:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbDhF+zlWJsmYWSGAhc1TsK8O1Cno3nSfMWLXTe0DTA2G0nNYUlfjEjglHnRXF/DF7EEosw28jc0KHq8WwQeMPdvjmLOLCmkfbtkIBMgcBbBOPD1cLIPbF4VIF4slSZfOXEGn7xfXdQmUmrDpYSN4QkXOxGGMZFsFVfkotpC8yQz1wiLZEiXZ0ptYtbFfqhIH0kfx7adaQ//RrSMQb8frFkZxaPvbMz/zgY96Y4C8x7S4Xibbxqd+nj574mHwGzERw9ESXMUoGlZyoRGvDRD2xAG5fJKxSxeeqn68+RzaKICbMSkQ/VBIV7lhdJEq70W4XMyn8immzXLdKTKgEbclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=og+yotnU7kMvBrPV0Yelcwyprrlqk57wnDe3dPdPNj0=;
 b=X5gZvWWpm0pBz4zMm6S6PHwuqruqfnUf5g3S508uICrpQb5ruEM3UE9qPHKvt/3pQ6tRNoWo79493XMdabTW/D3stdNKu1Iad13joVgRAtC4ZJ/Ui04oCAM/2F5odiIgwjHVbsJXcXCPKVscKbQ2uBj13lebFzZhYL1GC6teXwI7Z9zpTC+i9L5+ye0KtIzNdjpfW/fGkzwcr0r9sAyNBtzgi78+PoypFjLvQ+6IoMGcZv5MpIWwur9gAPpn0STw0ArbSja6AA0Mx20YbFUyJFCoztphGUYlNcNR0oJFzkw30HBEXvrMo4IIjUGy+f8GKfqRmXUrVM8mjfxO0Lrgnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=og+yotnU7kMvBrPV0Yelcwyprrlqk57wnDe3dPdPNj0=;
 b=DqdhzpzCm9Ih9Xwgdii38fahJfOyFJEPYJPAi2fuGmAlCL4KfNZe6wq+oJldg8xkhldeZ/Cs2drQI46lQf5tkwJv8AuHf8fTPWHSCOeYsHujrsfqLhvNP0TH+fkemwZgel5mNSesUxXNZekBM+OgWxfHB3a9/nN45vwn0S8l91M=
Received: from SA1PR02MB8592.namprd02.prod.outlook.com (2603:10b6:806:1ff::18)
 by SN6PR02MB4046.namprd02.prod.outlook.com (2603:10b6:805:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 13:55:49 +0000
Received: from SA1PR02MB8592.namprd02.prod.outlook.com
 ([fe80::6d3e:7010:c43d:fb23]) by SA1PR02MB8592.namprd02.prod.outlook.com
 ([fe80::6d3e:7010:c43d:fb23%8]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 13:55:49 +0000
From:   Abhyuday Godhasara <agodhasa@xilinx.com>
To:     Michal Simek <michals@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Rajan Vaja <RAJANV@xilinx.com>, Manish Narani <MNARANI@xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Jiaying Liang <jliang@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 0/6] Add Xilinx Event Management Driver
Thread-Topic: [PATCH v4 0/6] Add Xilinx Event Management Driver
Thread-Index: AQHXqjPsj2n6NIOYSUC8o2qDqfgxnKvRBXFQgAAKboCAAAG/AIAADkYwgAAD9YCAAAIsMIAAAwoAgAAQ7gCADHfxcA==
Date:   Thu, 21 Oct 2021 13:55:49 +0000
Message-ID: <SA1PR02MB85922CC2DCFCDC902BC37E68A1BF9@SA1PR02MB8592.namprd02.prod.outlook.com>
References: <438b398c-a901-7568-11e0-cd9bf302343f@xilinx.com>
 <20210915131615.16506-1-abhyuday.godhasara@xilinx.com>
 <SA1PR02MB8592838B99062EFA6EAAE73DA1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
 <YWbYKQXf8g8s55kG@kroah.com> <YWbZoPHDzc4e5Nme@kroah.com>
 <SA1PR02MB8592E68D021E12DCA45B70A2A1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
 <YWbo660XPKlwDZH0@kroah.com>
 <SA1PR02MB8592EB312091543A1D564D70A1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
 <YWbtSiHWNOf2djee@kroah.com>
 <f63e44a0-c187-8278-6c89-935b7006b64f@xilinx.com>
In-Reply-To: <f63e44a0-c187-8278-6c89-935b7006b64f@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29269af9-48e8-42f7-9b47-08d9949a7d11
x-ms-traffictypediagnostic: SN6PR02MB4046:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR02MB404638F1701525E7BBCD6AC2A1BF9@SN6PR02MB4046.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xaqRpG80h3dKIG7I2CojU32oxwZxDGOIH2wL2772hL4ufvw3Z0egy9rQXFw9Ah6c7XOcS5zpXf37curBgVq5NMEBWAyIfLg6Er95iLkzh6hmcAB1jvP2y7eeG2iN4tDqeCISW7Ae50eh0xQ9bXc16+vPoWudsd8kaMa3mdU5lDt3kGRt8zENqBId9YAfvF0d/2/EQIR1LsdknlFs4bixzkwS5Q95ysasNLRNanKcA9r8nVtdqW1etJAu7FCyAGy/yFJpogA9Qw7ZACBl6VuIzpXj3suhL2WnzbwzmAV61m5olbnZIvQkN9gjLEoYkyDuxwnngDcRzNgP2hMTjbBLeiwHELc71uc4lHQb7wIedUV5FlQo+OU6nFlbFIi7rj79qIdnLXgS8PaqpMbtUrrVe2PHmTWI6AJ1Yb0FNFlCtfgNxmNo9u7xMmV042sKKX/elnyogH5eS31XgwfQM6RzuOPmntoyFjhN9sAjNcpXfZrX85ROZ4rVh4fQKVQ3oCZzAFZACaLbbzeN7HAJB42S6TE6/dSETiiPziWYUXgA0M2E4YfcHD90InbP5YmEShES/UKDQuLrx2txvazS/r6lPHZy9iJ+l76dnJfZmG8No4GccWAGanEh1Qo5cKTQ/xmQEZqrcJ5nC1u0TVSbko/BxD7QAdWJ51SP7ZHl8sEnaBzujYIUz9grMl9Y3kQ15vVQ3+OIA+/H9Patkpqh9fxj7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR02MB8592.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(71200400001)(83380400001)(316002)(7696005)(110136005)(55016002)(26005)(66476007)(6506007)(4326008)(8936002)(9686003)(52536014)(38100700002)(53546011)(54906003)(8676002)(5660300002)(2906002)(66556008)(86362001)(186003)(122000001)(33656002)(76116006)(66446008)(64756008)(508600001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXVrT2VKZkpmejFpcEpvSTJEMW1wbFRkWlg5TXNlTkNDRm1iUUozdnJEcWdj?=
 =?utf-8?B?Q2F2QlhkaDFrWFcwZEpKM0N1anV2UDJrUGF4TDZibFlRM3JuUmJQeDVtWWNm?=
 =?utf-8?B?anVSYVBuUWVGNjFFbXUvcVFKQ29ZM2lCdGFvT3pSd3RzUGljM0FwQXdSZDdZ?=
 =?utf-8?B?bHVqWC9YRzZmWTZlZUMrckdpVzNTT1RoV3g3Nk1FdFFVcEExUFFHOWMvUWdG?=
 =?utf-8?B?Vm5Ja0tLNFdiN2M5YVhkUXhDbjBTMmR6YlJNNW1RN2gwNVI3QzREZFEvTTJQ?=
 =?utf-8?B?UnZ1RDlmZG5qb3dYa2o2S2xPL3pISUpRZ2EyOCtjNmZQQUtNc3ovUHFnTW90?=
 =?utf-8?B?cUxqVHZ0aWYwTnVjVmltNE9ZVnlXbXBMZ0tDQ1JXd280aHI2eSs5ZkJ2bVJi?=
 =?utf-8?B?TUJ3TFdDcGJIMUo0UStnN3VKdVJWMks5bFY2RzRuR0FLZ0F1RzVaaVpQT0ZD?=
 =?utf-8?B?T2dFSTUreTlSYlQ3UEpoc3RORVk1WmhBOVJFQ0Rpb29qZmN0aGpPb0FSMjlk?=
 =?utf-8?B?WWVraG9tWndjMmo3QkJhZGpTVStPc3M4VHhVblQvc3M5QUN5S3Bsdm9sSi9u?=
 =?utf-8?B?aWtYNlVYMHFCVGd1ek14L1BmZ0pVdzkrNTdPZ3F1ZXcwL1RnbTJRUTh4Zkw2?=
 =?utf-8?B?ZEYrY2JGNVNtNnd0eHl6b2F6Nk9naUFCZm9JMHZYOHBtbExjUEtXZlVZSHRJ?=
 =?utf-8?B?VG5Qb3c5RWh3b1o4ak50dTk3bHJJWENxRW90TG5sOS9FNVhTZnNtOERJT25P?=
 =?utf-8?B?VzV4ODJLSHN4bXJFV256Y3lwdm0yazkzK2lxTkdTczVUbmtOaERzbm5XamRw?=
 =?utf-8?B?VlRzbzFOeEhOMzRaNUYyS3UrNEYrVk00UGh6RWFiM2h0MlFKZWhtemlUcnF2?=
 =?utf-8?B?a3Q2dndPT0FRUVJVYUFKNUM5WisxYVNISzFBaXdvWXZyemJqSTBDanZON1Uv?=
 =?utf-8?B?YjlNYUJWSkVLdnVPK2kra2tLT1d3NE9HekZWSG9VUk4zZ3JjaS9ySlZQZ2t6?=
 =?utf-8?B?bDJ0dkdRcHlxSlJlWkNnVVpXSzRHYWhqM0p4K2JsVnFCcm5JYVZEVE9aanRF?=
 =?utf-8?B?R2hpS1l6djJzZkgwUkRRRGhZVWVaUlZjTi94K0MzNWoyNlJpKzQ2RGMvV2oy?=
 =?utf-8?B?VWpRc0VGWW5uTWFSTzN1WExudUx1UmowUmNxVmQwRlR2aVQ0UDFFUHNDZUZZ?=
 =?utf-8?B?N0xEL2tOaU1qU3RsQzhPSUEyeEVxWUxmUHNGNzd3bUtjSDMzbTBrb0o0Zlh0?=
 =?utf-8?B?ZExQYjErLzhYZnZ3SzFwVmQrckEzblE0NnliRWJha2hBeWJWT3pveEFYNjRI?=
 =?utf-8?B?NDQ4OUlPSVFERkh2Z3dJZzU5M3l3dGRzNWhrV0g3UUlmbGl2NmVJMXJiREMr?=
 =?utf-8?B?UUJOcU9iOFR4N1ZicmJaUHpsV09ZbXNnL0ZpTXhkWUF5aXhPeTZBQU8waFll?=
 =?utf-8?B?OVpQVFhwcGFHQllRNEhGemhMT2RFaGMwaUNqTWRnd0JNdGpZN1NNR3pJSU5i?=
 =?utf-8?B?dTQzUHg3L3RISEtPZ0F6TElxQmk0S2MvZG5XUjRmeHRGd3pTTE5nSmFwejJR?=
 =?utf-8?B?eGhGNEdlSlBQbTltL2Fhd2t6eXpEcENTcFN2eDlVQTBuSUNtZC9LZVpzRGwv?=
 =?utf-8?B?eEoyQlI4SWlwRDN6QUVwOGl6ajViYWZOTXBBdS9oeFV4L3RjM0NrNyt1V0pr?=
 =?utf-8?B?cENuSlF6TElGQWplVk1VbVNGSzFWajlBRzNqcjhCOFE3M3kxSmdVRnB0ZW1s?=
 =?utf-8?Q?C9RCQ9A18EY5al27kVTvG0cFMBDCrpXYjN+Fvv9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8592.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29269af9-48e8-42f7-9b47-08d9949a7d11
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 13:55:49.1098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: agodhasa@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoYWwg
U2ltZWsgPG1pY2hhbC5zaW1la0B4aWxpbnguY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9i
ZXIgMTMsIDIwMjEgOTowMCBQTQ0KPiBUbzogZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IEFi
aHl1ZGF5IEdvZGhhc2FyYQ0KPiA8YWdvZGhhc2FAeGlsaW54LmNvbT4NCj4gQ2M6IFJhamFuIFZh
amEgPFJBSkFOVkB4aWxpbnguY29tPjsgTWFuaXNoIE5hcmFuaSA8TU5BUkFOSUB4aWxpbnguY29t
PjsNCj4gem91X3dlaUBodWF3ZWkuY29tOyBTYWkgS3Jpc2huYSBQb3R0aHVyaSA8bGFrc2htaXNA
eGlsaW54LmNvbT47IEppYXlpbmcNCj4gTGlhbmcgPGpsaWFuZ0B4aWxpbnguY29tPjsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDAvNl0gQWRkIFhpbGlueCBFdmVudCBN
YW5hZ2VtZW50IERyaXZlcg0KPiANCj4gDQo+IA0KPiBPbiAxMC8xMy8yMSAxNjoyOSwgZ3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmcgd3JvdGU6DQo+ID4gT24gV2VkLCBPY3QgMTMsIDIwMjEgYXQg
MDI6MjE6MDFQTSArMDAwMCwgQWJoeXVkYXkgR29kaGFzYXJhIHdyb3RlOg0KPiA+PiBIaSBHcmVn
LA0KPiA+Pg0KPiA+Pg0KPiA+PiBUaGFua3MsDQo+ID4+IEFiaHl1ZGF5DQo+ID4+DQo+ID4+PiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4gRnJvbTogZ3JlZ2toQGxpbnV4Zm91bmRh
dGlvbi5vcmcgPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiA+Pj4gU2VudDogV2VkbmVz
ZGF5LCBPY3RvYmVyIDEzLCAyMDIxIDc6NDEgUE0NCj4gPj4+IFRvOiBBYmh5dWRheSBHb2RoYXNh
cmEgPGFnb2RoYXNhQHhpbGlueC5jb20+DQo+ID4+PiBDYzogTWljaGFsIFNpbWVrIDxtaWNoYWxz
QHhpbGlueC5jb20+OyBSYWphbiBWYWphDQo+ID4+PiA8UkFKQU5WQHhpbGlueC5jb20+OyBNYW5p
c2ggTmFyYW5pIDxNTkFSQU5JQHhpbGlueC5jb20+Ow0KPiA+Pj4gem91X3dlaUBodWF3ZWkuY29t
OyBTYWkgS3Jpc2huYSBQb3R0aHVyaSA8bGFrc2htaXNAeGlsaW54LmNvbT47DQo+ID4+PiBKaWF5
aW5nIExpYW5nIDxqbGlhbmdAeGlsaW54LmNvbT47IGxpbnV4LSBrZXJuZWxAdmdlci5rZXJuZWwu
b3JnOw0KPiA+Pj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+ID4+PiBT
dWJqZWN0OiBSZTogW1BBVENIIHY0IDAvNl0gQWRkIFhpbGlueCBFdmVudCBNYW5hZ2VtZW50IERy
aXZlcg0KPiA+Pj4NCj4gPj4+IE9uIFdlZCwgT2N0IDEzLCAyMDIxIGF0IDAxOjU3OjU5UE0gKzAw
MDAsIEFiaHl1ZGF5IEdvZGhhc2FyYSB3cm90ZToNCj4gPj4+PiBIaSBHcmVnLA0KPiA+Pj4+DQo+
ID4+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4+IEZyb206IGdyZWdraEBs
aW51eGZvdW5kYXRpb24ub3JnIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gPj4+Pj4g
U2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDEzLCAyMDIxIDY6MzYgUE0NCj4gPj4+Pj4gVG86IEFi
aHl1ZGF5IEdvZGhhc2FyYSA8YWdvZGhhc2FAeGlsaW54LmNvbT4NCj4gPj4+Pj4gQ2M6IE1pY2hh
bCBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPjsgUmFqYW4gVmFqYQ0KPiA+Pj4+PiA8UkFKQU5W
QHhpbGlueC5jb20+OyBNYW5pc2ggTmFyYW5pIDxNTkFSQU5JQHhpbGlueC5jb20+Ow0KPiA+Pj4+
PiB6b3Vfd2VpQGh1YXdlaS5jb207IFNhaSBLcmlzaG5hIFBvdHRodXJpIDxsYWtzaG1pc0B4aWxp
bnguY29tPjsNCj4gPj4+Pj4gSmlheWluZyBMaWFuZyA8amxpYW5nQHhpbGlueC5jb20+OyBsaW51
eC0ga2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPj4+Pj4gbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnDQo+ID4+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMC82XSBBZGQg
WGlsaW54IEV2ZW50IE1hbmFnZW1lbnQgRHJpdmVyDQo+ID4+Pj4+DQo+ID4+Pj4+IE9uIFdlZCwg
T2N0IDEzLCAyMDIxIGF0IDAyOjU5OjIxUE0gKzAyMDAsDQo+ID4+Pj4+IGdyZWdraEBsaW51eGZv
dW5kYXRpb24ub3JnDQo+ID4+Pj4+IHdyb3RlOg0KPiA+Pj4+Pj4gT24gV2VkLCBPY3QgMTMsIDIw
MjEgYXQgMTI6Mjc6NThQTSArMDAwMCwgQWJoeXVkYXkgR29kaGFzYXJhDQo+IHdyb3RlOg0KPiA+
Pj4+Pj4+IEhpIEdyZWcsDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPj4+Pj4+Pj4gRnJvbTogQWJoeXVkYXkgR29kaGFzYXJhIDxhYmh5dWRheS5n
b2RoYXNhcmFAeGlsaW54LmNvbT4NCj4gPj4+Pj4+Pj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1i
ZXIgMTUsIDIwMjEgNjo0NiBQTQ0KPiA+Pj4+Pj4+PiBUbzogZ3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmcNCj4gPj4+Pj4+Pj4gQ2M6IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPjsg
QWJoeXVkYXkgR29kaGFzYXJhDQo+ID4+Pj4+Pj4+IDxhZ29kaGFzYUB4aWxpbnguY29tPjsgUmFq
YW4gVmFqYSA8UkFKQU5WQHhpbGlueC5jb20+OyBNYW5pc2gNCj4gPj4+Pj4+Pj4gTmFyYW5pIDxN
TkFSQU5JQHhpbGlueC5jb20+OyB6b3Vfd2VpQGh1YXdlaS5jb207IFNhaSBLcmlzaG5hDQo+ID4+
Pj4+Pj4+IFBvdHRodXJpIDxsYWtzaG1pc0B4aWxpbnguY29tPjsgSmlheWluZyBMaWFuZw0KPiA+
Pj4+Pj4+PiA8amxpYW5nQHhpbGlueC5jb20+OyBKaWF5aW5nIExpYW5nIDxqbGlhbmdAeGlsaW54
LmNvbT47DQo+ID4+Pj4+Pj4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+Pj4+
Pj4+IGxpbnV4LWFybS0ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPj4+Pj4+Pj4gU3Vi
amVjdDogW1BBVENIIHY0IDAvNl0gQWRkIFhpbGlueCBFdmVudCBNYW5hZ2VtZW50IERyaXZlcg0K
PiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBUaGlzIExpbnV4IGRyaXZlciBwcm92aWRlcyBzdXBwb3J0
IHRvIHN1YnNjcmliZSBlcnJvci9ldmVudA0KPiA+Pj4+Pj4+PiBub3RpZmljYXRpb24gYW5kIHJl
Y2VpdmUgbm90aWZpY2F0aW9uIGZyb20gZmlybXdhcmUgZm9yDQo+ID4+Pj4+Pj4+IGVycm9yL2V2
ZW50IGFuZCBmb3J3YXJkIGV2ZW50IG5vdGlmaWNhdGlvbiB0byBzdWJzY3JpYmVkIGRyaXZlcg0K
PiA+Pj4+Pj4+PiB2aWENCj4gPj4+Pj4gcmVnaXN0ZXJlZCBjYWxsYmFjay4NCj4gPj4+Pj4+Pj4N
Cj4gPj4+Pj4+Pj4gQWxsIHR5cGVzIG9mIGV2ZW50cyBsaWtlIHBvd2VyIGFuZCBlcnJvciB3aWxs
IGJlIGhhbmRsZWQgZnJvbQ0KPiA+Pj4+Pj4+PiBzaW5nbGUgcGxhY2UgYXMgcGFydCBvZiBldmVu
dCBtYW5hZ2VtZW50IGRyaXZlci4NCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gQ2hhbmdlcyBpbiB2
NDoNCj4gPj4+Pj4+Pj4gLSBSZWJhc2Ugb24gbGF0ZXN0IHRyZWUNCj4gPj4+Pj4+Pj4NCj4gPj4+
Pj4+Pj4gQ2hhbmdlcyBpbiB2MzoNCj4gPj4+Pj4+Pj4gLSBVcGRhdGUgdGhlIGNvbW1pdCBtZXNz
YWdlLg0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBDaGFuZ2VzIGluIHYyOg0KPiA+Pj4+Pj4+PiAt
IFJlbW92ZWQgdXBkYXRlZCBjb3B5cmlnaHQgeWVhciBmcm9tIHVuY2hhbmdlZCBmaWxlcy4NCj4g
Pj4+Pj4+Pj4gLSBtYWtlIHNnaV9udW0gYXMgbW9kdWxlIHBhcmFtZXRlciBmb3IgZXZlbnQgbWFu
YWdlbWVudCBkcml2ZXIuDQo+ID4+Pj4+Pj4+IC0gVXNlIHNhbWUgb2JqZWN0IGZvciBlcnJvciBk
ZXRlY3Rpb24gYW5kIHByaW50aW5nLg0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBBY2tlZC1ieTog
TWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAeGlsaW54LmNvbT4NCj4gPj4+Pj4+PiBbQWJoeXVk
YXldIE1pY2hhbCBzdWdnZXN0ZWQgdG8gbWVyZ2UgdGhpcyB2aWEgeW91ciB0cmVlLiBQbGVhc2UN
Cj4gPj4+Pj4+PiBoYXZlIGENCj4gPj4+Pj4gbG9vay4NCj4gPj4+Pj4+PiBQbGVhc2UgbGV0IG1l
IGtub3cgaWYgdGhlcmUgaXMgYW55dGhpbmcgcmVxdWlyZWQgZnJvbSBteSBzaWRlLg0KPiA+Pj4+
Pj4NCj4gPj4+Pj4+IE9rLCBJJ2xsIHBpY2sgaXQgdXAsIHRoYW5rcy4NCj4gPj4+Pj4NCj4gPj4+
Pj4gTm9wZSwgSSBjYW4gbm90IGFzIGZvciBzb21lIHJlYXNvbiBpdCBhbGwgZGlkIG5vdCBzaG93
IHVwIG9uDQo+IGxvcmUua2VybmVsLm9yZy4NCj4gPj4+Pj4NCj4gPj4+Pj4gUGxlYXNlIHJlc2Vu
ZCB0aGlzLCB3aXRoIE1pY2hhbCdzIGFjayBhbmQgSSB3aWxsIGJlIGdsYWQgdG8gcGljayBpdCB1
cC4NCj4gPj4+PiBbQWJoeXVkYXldIFNlbnQgdjUgd2l0aCBNaWNoYWwncyBhY2suDQo+ID4+Pg0K
PiA+Pj4gU2VudCB3aGVyZT8gIERvIHlvdSBoYXZlIGEgbG9yZS5rZXJuZWwub3JnIGxpbms/ICBE
aWQgeW91IGNjOiBtZT8NCj4gPj4gW0FiaHl1ZGF5XSBJIGFkZGVkIGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcgYW5kIGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcg
aW4gQ0MuIGFsc28gIGFkZGVkIHlvdSBpbiAiVG8iIGZvciB2NS4NCj4gPj4gUGxlYXNlIGxldCBt
ZSBrbm93IGlmIHJlcXVpcmUgYW55dGhpbmcgZWxzZSBhbHNvLg0KPiA+DQo+ID4gQWdhaW4sIEkg
ZG8gbm90IHNlZSB0aGVtIGluIG15IGluYm94LCBub3IgZG8gSSBzZWUgdGhlbSBvbg0KPiA+IGxv
cmUua2VybmVsLm9yZy4NCj4gPg0KPiA+IEFyZSB5b3UgX3N1cmVfIHlvdSBzZW50IHRoZW0/DQo+
IA0KPiBJIGdvdCBpdCBidXQgSSBleHBlY3QgdGhleSBhcmUgbm90IHNlbnQgb3V0IG9mIHhpbGlu
eC5jb20gZG9tYWluIGFuZCB5b3UgYXJlIHNvcnQNCj4gb2YgYmxvY2tlZC4gWW91IHNob3VsZCB0
YWxrIHRvIElUIG9yIGp1c3Qgc2ltcGx5IHVzZSBhbnkgZW1haWwgb3V0IG9mIHhpbGlueA0KPiBk
b21haW4gdG8gY2hlY2sgdGhhdCB5b3UgZ290IGl0Lg0KPiBBbHNvIEkgYW0gbm90IGFibGUgdG8g
c2VlIGl0IGluIGxvcmUuDQpbQWJoeXVkYXldIE5vdyB2NSBhcmUgYXZhaWxhYmxlIGluIGxvcmUu
a2VybmVsLm9yZw0KDQpUaGFua3MsDQpBYmh5dWRheQ0KPiANCj4gVGhhbmtzLA0KPiBNaWNoYWwN
Cg0K
