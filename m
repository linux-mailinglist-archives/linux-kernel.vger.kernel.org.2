Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1171358B88
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhDHRit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:38:49 -0400
Received: from mail-eopbgr1400128.outbound.protection.outlook.com ([40.107.140.128]:31557
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232658AbhDHRip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:38:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWxzbLiVA2VI+OVncEMzzUtcJ7yV7W/AgRpY1gaamlwlSlRn638qjZ+p489N3DfX1NTDTefirkAZo4+/KTBRRpvDtwGPBhlHxuROGXF+nfDp9OtMQYKPXKbd9AqE2ublpavVWv1ATgXayZxTjXBVLBMXQDhY2W0Y3A37gJ4AAmyCgi5ya52St4oJVbCPlP+Sz8MpnGcj1/ciQOKFSZmcL9gEuvTHzHkgI5mTN4ZnHeqfnc9sF1h99G7SIFMVhCTEcWhvSZYCGYyT2Zn6/mlObNwAgwDhcjzL3f9N7S72o4XGOd3na4iwl6WOgbg6M/fRm23GK2O3LqUOegZWs9SS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APyk/pSPIcdQosIrdmhHlCKW1c24CbnGkC2gDhc1mFQ=;
 b=PrHQLmhz63P/oZPhm57ulUuoaPbFRBXLJf9b4GCC9RMcVAplxJIfAMed/RYQiniGcaeSkbsasYqiNhorJmQBtPcdIIRn+Mb3bafNuMh+q4ddWAcW5MNEcufgLKmmP42OSH5LHJa8VL030nahkFjGq4gWRAPVYU8yrP0mAdL40kYIAr1Av9ZjHhF9mjPSBmtAGFxvNXPEOWol4dyo364Oxu1U6jnqvMdGjbNi5Q4RD1P12/q8RUx7ZpzpKALB7OPl1drashCF+yV5VFSg32ZI1kAUaL+kPENCM5PV0ENlbZiLg01uQWCbB+ZCM6UBqt+TSBBFqctLvqnfIHmbQHnO8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APyk/pSPIcdQosIrdmhHlCKW1c24CbnGkC2gDhc1mFQ=;
 b=hAVbY2AaCGbIevRBJXc/ZRdZpfWBGk4YUu1OQ0giuBVK0te7EnOgMlgTTvUBx6QbcrfKuBtJ9TsTOM2FjMAivD9HBgADqXQbcgrGhj8huTewvdZk3tycHGc4es/zhm25yznIvIlDBQygdEqpDo6s0+J9GSBAcyIGesWRs9KFiGc=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OSZPR01MB6216.jpnprd01.prod.outlook.com (2603:1096:604:ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 8 Apr
 2021 17:38:32 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433%7]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 17:38:32 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 1/2] mfd: Add Renesas Synchronization
 Management Unit (SMU) support
Thread-Topic: [PATCH net-next v3 1/2] mfd: Add Renesas Synchronization
 Management Unit (SMU) support
Thread-Index: AQHXLBphMmpyIdnLSkKcpoovCRWuzaqqM6eAgACvi9A=
Date:   Thu, 8 Apr 2021 17:38:32 +0000
Message-ID: <OSBPR01MB4773DF588214D8B9E613E074BA749@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1617846650-10058-1-git-send-email-min.li.xe@renesas.com>
 <20210408070809.GD2961413@dell>
In-Reply-To: <20210408070809.GD2961413@dell>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b33aa76a-2715-4ec1-d438-08d8fab520f7
x-ms-traffictypediagnostic: OSZPR01MB6216:
x-microsoft-antispam-prvs: <OSZPR01MB6216EC119EE8D49A723EE40CBA749@OSZPR01MB6216.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qcOrdu+/PlhTKERwu8r575EvL+BV81m/VOxmBoZViQ1c3cTy8fiktZqw2Ac7Puim9Fd/EVMAcvQc1bv0hxpPT40wzJWL+hstA1YxF9l/PuscPhbwywp0c1RPjFN/qzRkv5+axBbuk69VU6VGkGdY38WM/qD0I7Fum7vPzYJQGkBpPI+AjH5vO1itl6yw1KKzeCvsqQcqyXjLY+9Gxg7XvLgKU6rDKNyjkAGxJ55c6szMr6GOIX64K0wYjC4ped5BZLlQQlmC6RfqfEdqSmIAgLzjQC+GI1gkXT0wCCcC6vSXYO5QpQDS0AETuCSPeXKVBDmjkRdsBSXzDerMnlJEzaCqGyy4ZGDBoxlyuD0C/sKyIp78C1w8Ao32HrgHssabGofeFucGN8JriTjjRLDAwXKaRDp8Z5vGzziZAiMNDkw4fadF0iBtqJYjNflJKyRsNTP4yAs/JnttbsGZRHUuAfphoeVIfXkuHG/GoEwqYYDDgh4iVUV0DM3bq5JLvN3kV172wu+KPVmbwx87oDcXlIC/iRGQepOH7viRYDRLVsICZ+2cGYfcL+kQ7ALOTShjsbkxIFBEJz4ph6WmDaYeZbU1iIZinIAuf2OXGsTTNgnE90Emdv7Tm5Eo5+amlAk1LFfIHUdZZj9+QPeIO49m2WpHMipEFDivnOKCA5HRvHw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(66946007)(76116006)(9686003)(26005)(38100700001)(316002)(478600001)(186003)(33656002)(8676002)(66446008)(64756008)(8936002)(66556008)(66476007)(558084003)(2906002)(54906003)(4326008)(71200400001)(6916009)(55016002)(7696005)(5660300002)(86362001)(6506007)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dm9KS1lMcFAyei91K3FIanNad2lYMUtuUTdxaWxpd0llUkVGRWxaRVFCZ1c4?=
 =?utf-8?B?ZVdSNkcwdGR4QlZyT3UwZTBVVS9mTDlrV2Q1Z1FIVWVaZmhKbjllNThVS20v?=
 =?utf-8?B?YmxGZi8zeXNwK0FWK0xZZ3NwUGtvVmsvdk1xL1pDdkFtTFBFTndtd243K3V6?=
 =?utf-8?B?b1ljNmtBUTlCRjFsVzNoV3JJRVljSmlUd0V1eEFQbERiMldZQ3VoWEhNRkIz?=
 =?utf-8?B?UDl2VnRPa2RJbGRNb2t2SUFNKzMrMjFNRGFCUlZQaVAwcDVrdlA0MGVFcTlK?=
 =?utf-8?B?enRSbmFCZ2JnR28vV1V0ZUt2L0d0STRzNzI3NTFYL1M4bTh4RS9uZTJRNjln?=
 =?utf-8?B?RG55Q1lnMHNRSFhoRG1vN3ZrbWRpZUFPdml1dzlOU1UzcXZ5L2lGWW1CZmNK?=
 =?utf-8?B?NDZ4eEdlRHpINXlZM003U0RXZTNueWIvTUhXVVRhNnA4aGVNS2M3NnhCUVpi?=
 =?utf-8?B?dmU3Ly9nOGFCNlNIT1VLVm5Ba1NueXBKZC9Ra1N1K3FreHlkemxYSnJUaTBz?=
 =?utf-8?B?OGVZMUU0Uk50VHdkV2laaVhTRjFFVzBjdWN3ZllwTHQxQkEweEtER0MwblVO?=
 =?utf-8?B?MXNjUG1vcEVGKzVLSlRjZUZ4bklQN0VGTUFReGhXQlhiZTV6SGtDaE51TERi?=
 =?utf-8?B?TXI0RlI4bndUeWlCdFU0dU10R1JlVFJJOTFrTzk4T21hV1JEQ0R3dVU3ZWVM?=
 =?utf-8?B?RERxMVBEQjZGYnZpelE1QnpITThxaEx3YmlTMTRlN3YzWkxrVDhNV3VMN05h?=
 =?utf-8?B?czM0MUNESlZpQVphbE5ydHJycGNOYTN5OFNPcTBNemc1d3UrcE5JbXhjMmY5?=
 =?utf-8?B?LzhEVGc4Z3dPVlNSdnNFQmJqcldvMG5Vb1NtQnl1QnkxZVVnLzBhdG1MYVQ1?=
 =?utf-8?B?aU14OHlYdStXZ0NIcTBsaWFlWWZwK0h5WC9KVEY3ZWtXck1lMEdDMWZtcVVz?=
 =?utf-8?B?RXdzSmJNQkhhNlllWk40M2U4SDFRamlqUUUrNmp4dk1qNGFhNVU5Rnh6K2Yy?=
 =?utf-8?B?R04zd2sxQ0ljdlMzS1V3azdMMEhVMWFUelVlSnJhWkh4eWFxUllMdStXb2g0?=
 =?utf-8?B?K2pFbHRTQVBQekdBYk1jdmRlemdRb0pXUGY1V3hEL1owTXdrVnJiVkpjV2RI?=
 =?utf-8?B?bmNtZEZJcE8zT2ZZU2JVbEZDa2VwQUVGNjZBTTFnNmEyRDMzZi9lRGlhelRv?=
 =?utf-8?B?TGJDK3FLbzZ4RFJCbTd0WW1XTlozc2dpN3NKMmsweXdPazNldWxNUVptQXdG?=
 =?utf-8?B?YXh0WDZ6d2d5WnpJd3hQSjVsZm0vQU1CY1UyRVIyOXdydXdRVHRMeHhFVS9Z?=
 =?utf-8?B?SDRSM00rbFNTVnA5RS9tcGphNk9BMmc0ZmtsaFZOUWNmY1RRZDZuVEMyMERn?=
 =?utf-8?B?L0pqeHBlMEpPdGhwZnZiclJEbkNRQ1B4Q1plNTJoWEhHYzhnOG52ekFWU3NC?=
 =?utf-8?B?ZXlWUXFQMndMVEUrRGhuQVZ2VXkvS3ZGRlduNDlEL09KZkF5T0g4dm1XTXVu?=
 =?utf-8?B?TWdmRXFFdVpkRGhYTzM3cDFZN09BQ085Q1NaMDZRRkVtd0RaME1QQVNSR1lx?=
 =?utf-8?B?Y0JYWGd6b0QwNWNham50aStVMmZpSmErcVQ1QjBmZ1BjM0FIY044NE96UzNk?=
 =?utf-8?B?U3ViTkEyWG93b3NoOVZETVJxQlhuQ284TWFrWllzYi81VzN1eUhYejRqdnhi?=
 =?utf-8?B?ZWFWT2E1a3o4U2FEajZGRVFoVHFza1ZBclh0M1BhQ2NBT0c1R0pTczU0cWVY?=
 =?utf-8?Q?PAIgkZVYRQiSa4sZ+6EljyoFx8eMs4kOLS9ZVHR?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33aa76a-2715-4ec1-d438-08d8fab520f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 17:38:32.0363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9yMXyMrZ+BOe065i34/ZmGTKcuEOodZQPKwGZ6noTV918V2fmYzl8km7N741VcrX7YdEQU3Pzj7+mwIEhYeNVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6216
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gSWYgdGhpcyBpcyB2MywgdGhlcmUgc2hvdWxkIGJlIGEgY2hhbmdlbG9nIGhlcmUuDQo+
IA0KSGkgTGVlDQoNClRoZXJlIGlzIG5vIGNoYW5nZSBpbiB2MyBmb3IgTUZEIHBhcnQgb2YgY29k
ZSwgdjMgaXMgb25seSBmb3IgbWlzYyBwYXJ0LiANCkJ1dCBJIGhhdmUgdG8gZm9ybWF0IDIgcGF0
Y2hlcyB0b2dldGhlciBhbmQgdGhhdCBpcyB3aHkgbWZkIHBhcnQgZ290IHYzIGFzIHdlbGwuDQpC
dXQgaXQgaXMgYWN0dWFsbHkgaWRlbnRpY2FsIHRvIHYyDQo=
