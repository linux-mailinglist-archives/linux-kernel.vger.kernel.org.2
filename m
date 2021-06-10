Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF343A2500
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhFJHGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:06:46 -0400
Received: from mail-co1nam11on2056.outbound.protection.outlook.com ([40.107.220.56]:14176
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230118AbhFJHGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:06:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ptdmfmkiln7UKbe3mSE35sKRzkJbUMpFguiuZpl6B7TK2SKXQJlLtBZOg8ixnQl+UqD03/pNVc8DKFBMQP1nlvLIhNSOgRx7+0nSfdMLeKWg5hW9GZoeNNkPd+5/ki/9x9VX5CGvY/qE7tizViZUx6jXjtx93B/H7j6VGKo7ps8lOloKiyymHwfBkqwuMz1vhFCTXTbaJxFyfbDpnJEoz0+kx5LBuoGVzSYAwvckQbsfo8beEYNH0Gq+SxGKF3qexHmxY/Q6kH9MtYGB4j9geA5MMQOEk6ZxM5fJX6K0nmM5ki4a1vdt6Z/mjYZ31liFQEBAV16bVnJgrMIXviwKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFqlDo/XB2iZQ0g6Sk8RF0BFPocKHXbSQG5c4fBUmc4=;
 b=Of0QQ0CpDEJ01HXdRHgpFPeyEn7ZRJyAF0cdih3rdU2/o2wk6SVmKCyLrwgAimbaEQJpjqx23ziVuvrSMLBUvNpuw2MHNcT6Q/zTMS2yJpA1Njd2wq8AVfAS/vBc1wccbJwMo+/D95ECHCZFilHj+k7DfQ1HkShJsXF3lPpDpYh1nW/dEXYnPB67TVXqx8IoDrHbQp/+LLn/zMheUbe+g+j5PsNfYJIvASn6sM9iAB7/DuOLM2VzyDvm/QMUom8//ZLqTidz7R7yDWZqB025g27MMbeNHsO/4vXZJLQyXTdQkHfTzskbqUTz1M2XFh/R3IjJwK0YFO2Asbfu04/sCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFqlDo/XB2iZQ0g6Sk8RF0BFPocKHXbSQG5c4fBUmc4=;
 b=MnsVpROBcRQe2IzMr6bj1PoQmhc1DuhCuWjWgl47LcJksT0QPkwxgddlrLzVDzQCxTAVBShF9QlGf6i3ZUEdIAqzItzQTrt18iYXL+pOsXeZSjNoUH/gsX9vKs5ZNjBTEVvWEOpArk3bePldLTMA8BIesOPoY++aw8gZ5Z7Iv+Q=
Received: from BYAPR02MB4280.namprd02.prod.outlook.com (2603:10b6:a03:5a::29)
 by BYAPR02MB5272.namprd02.prod.outlook.com (2603:10b6:a03:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Thu, 10 Jun
 2021 07:04:45 +0000
Received: from BYAPR02MB4280.namprd02.prod.outlook.com
 ([fe80::19f2:a0be:769f:44c4]) by BYAPR02MB4280.namprd02.prod.outlook.com
 ([fe80::19f2:a0be:769f:44c4%5]) with mapi id 15.20.4195.030; Thu, 10 Jun 2021
 07:04:45 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Michal Simek <monstr@monstr.eu>,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "helmut.grohne@intenta.de" <helmut.grohne@intenta.de>,
        Srinivas Goud <sgoud@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>
Subject: RE: [PATCH v22 15/18] MAINTAINERS: Add PL353 SMC entry
Thread-Topic: [PATCH v22 15/18] MAINTAINERS: Add PL353 SMC entry
Thread-Index: AQHXXQW0S+SiR3Ddr062xAvqnfeE3qsM0nrA
Date:   Thu, 10 Jun 2021 07:04:45 +0000
Message-ID: <BYAPR02MB428000401E741EF3983C02B2AF359@BYAPR02MB4280.namprd02.prod.outlook.com>
References: <20210609080112.1753221-1-miquel.raynal@bootlin.com>
 <20210609080112.1753221-16-miquel.raynal@bootlin.com>
In-Reply-To: <20210609080112.1753221-16-miquel.raynal@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be34c3cf-dd17-4fdb-3ef5-08d92bde0784
x-ms-traffictypediagnostic: BYAPR02MB5272:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5272BD4304F58F2FC2FA9CF9AF359@BYAPR02MB5272.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lZlh7TGx0wLgFlr5o7vP4MIjMII+34U3wvn/upwmTnMMW1MbCWmxV++35fARmXWi6bVkuR66/OgHGDypvhN60X2LdJ1VKLyBqLFbTKtluRTDNocPsL8jKEkqTE5ijwKDT8Dtv/F7j3bZMAwjqxSLiwW7I1J60oBQHCKFPHZZ5kD4FiJoTI3fZ42hCEg4zm8uDjFP4cGhy9gTTkGH9EeOLESSfef9PkBytKRo9LGaVOoWqEWF4iEgq7PBVJbF4aot7Cf8wLkMAE88GDiAc5pFbWGodE7+gx0htCHxZErl9rmF8JDUWt+wToccrBhYwHEW7GUZD6v7+K+0lbgrCkFs3puP8LmuBN7NvrbG4mCFILEvAwRZIuiXnX+C92W3uhh1E2t29AqBVuqW//D3VjD03OtBfpsDcIbAmsr+dvweN1Ox1RQU8bGlXJE+nT9Mrl0Rg6s9e2FJMQX8pRBhlZm61KCqibOX6nczUM+ERTHQ9Z1IrsOmy+FflMdLSSpnVt6gtYGT1WqvbS/3ExCcxPVekCGEvmTUjKjQqArhkM9uo8QI+qp51gF/ehL0bR/bNGQ/gDqFWwGTTAWY9nXFo6QVxi+UZgOfH+rghM2xYQkUpEA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4280.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(136003)(39850400004)(7696005)(478600001)(8936002)(6506007)(52536014)(5660300002)(7416002)(86362001)(66946007)(64756008)(33656002)(66476007)(26005)(66556008)(66446008)(9686003)(76116006)(53546011)(55016002)(8676002)(83380400001)(4326008)(2906002)(316002)(71200400001)(110136005)(186003)(54906003)(107886003)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEtkdVBkSlB6Y0t2YzZHWVpvZW04V0VOZVNnNGswZ1J0RThiVHdabk9sUEZT?=
 =?utf-8?B?YzhFZkJidzFqOUVwU0tPZ1ZobHcrN3NLSWJwM1BGQUlKbmgrSFRsRjgzMWdi?=
 =?utf-8?B?TGRPN2VBZHkrdytUMVUrUzQ2VUVSWFM0aVZBdDNOeWtKQXN0TkFXQUdsWGYv?=
 =?utf-8?B?bVh0dnNiRkF4NlZVREMvUzNkblp5bUVESnJpbVpwcDFxczRNWW9CdGZmSzVE?=
 =?utf-8?B?bGRPSXRKSHN4RVI5KytoNFlicHNQRDJpaFVBTEwvV2c3VWJybWtXQnV4YWx1?=
 =?utf-8?B?UW1YOS9VdHdMYVV1ZmhEWkltTDBOT29QZTRJakVQK0UwYnR4c3BCaUxPQ0x3?=
 =?utf-8?B?dW5kUW94OHZOeEF3MnVSMmZSdmJSc0k0Wkg1YXdDZXRjQ1k0SU5RaDZRYnJk?=
 =?utf-8?B?cjJNcnptd3JDR1dJWGpSMU0rZmJSSWVwYWk3M09YZDdnejlEdWVESFNuZDVD?=
 =?utf-8?B?UHRqK1FEaUJkYWhYVWtobkZBL0RoZE1Ncm5PZXJJeDlGYVN4OFBZMUdGY0E4?=
 =?utf-8?B?R2R0RGIvUHFQZ0dFQ0xnWHo2bEFNNlo2NFI3aGd6UHdQdGNZMndNbmJjMTZ6?=
 =?utf-8?B?UGdaZzhLREpqZWtZVCtkOHdSWEwwcUZPNllrL2wxTklQbFdURHZUVGZuZmhX?=
 =?utf-8?B?K0V1VWttdTZFRGlGVGN6T3pvWGFTc1BwUFh6NnNqYUdjc1RUWWJxdG9weDlN?=
 =?utf-8?B?RnhwWm5IWTA4cWQyZ0ZLcENRQ1pab0NaYlZ3L0Q3amQrK25VbHBJSkpiZk81?=
 =?utf-8?B?V2ZmSWwyai9JNHNRdFlKUGo2aEhsMjZkQ3F6dFdoTTBYYkpBK1dpMG45ckZB?=
 =?utf-8?B?dTFML3FGSHdZenVMZC8zc0FFcEV0ZFdZZ2R0R3RKY1dkMUhkcGtsNkNtdU14?=
 =?utf-8?B?SDgrS2g5c1BQRitFdXA3eEpWcUZMUUwrSHJzd2NHREM2ZU9qNG9FOTRmRm1H?=
 =?utf-8?B?aStEdUN1b1BVZVBndGJWNy9NQ0tYalNFdVl5THRVbnRHcTdYRmsrODlKemJB?=
 =?utf-8?B?MGdiVXV2aEVPc3l6SVovck5UcmxyajU5elVRNTZ1azViZi8zYXJRTGNGU1pG?=
 =?utf-8?B?VC9yc00rN2ZJd3VEaHQ3SFV3YTE4VmxQMkNURWpYOUpNRW04Qi8wS1QxUE5q?=
 =?utf-8?B?eExnY2VydVpvb3E5YjlPcldEZ2FvVjlLSlVDSGV0bW10KzZHMXhuUEF5eTN3?=
 =?utf-8?B?dVZpRC9XeFNXZm1SeU9lYVBTVFA1TFJsTjN0WTlVWlYyRHdCTzljY3ZSdms3?=
 =?utf-8?B?aG9SMHlGV2VoN1ErbDVYZENXcml5TERzQ2VvWWRHdDhmQ1FPekcySTBLeVhZ?=
 =?utf-8?B?bVlTTTN1MjlsWGo1VFlxdDQ4blVMbVF2aU1PN3F0eVBkYTFUTDh4Q09tbUlY?=
 =?utf-8?B?T1M2UGpRZ1ZCZ0Jad1hoVFA1c3ovQVpiSDVSeFpKVE1PakpZKzRFMFFQSFhY?=
 =?utf-8?B?Z2E4QWNVOXBRdjFyaUl4Vi8wbHd1WDI4RXRSdmsvN092VkZXZE5WN3AyUXlx?=
 =?utf-8?B?SGJ0Zms4Zkc4QUFZejlTZCtidGtsMUpBSlFXZVd2TzZMemFDMHdFdys2RHNK?=
 =?utf-8?B?MHBrdDYvTWZKcTRqQkpnbU9Qdi9tbVRlWU5FeWNHWnNwM1RIT1RTcjlZbE5v?=
 =?utf-8?B?TEx3UnlaS1pDaU12djY3OTlzUHNDRzdDUVE5RFlXTUE0L1lxdGVUWkhidnBx?=
 =?utf-8?B?d2I5U1hpSWIrVi9vRTR5YndsVUY4V3M4K1FTK0MzQnhmZEJtVERnZWR6SVlX?=
 =?utf-8?Q?nLiC54nQRXVRSvpyKuStRvwE9MQR0eC6ePEoO00?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4280.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be34c3cf-dd17-4fdb-3ef5-08d92bde0784
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 07:04:45.6818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bQsSw22RmesmaFd2/x+vBAj9BcSLkemGbC9zGa8CNVlwPFYZ97Wo8fu8i9qwPvM5K1lKSNpXCL/JrM1qCj3WQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5272
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlxdWVsIFJheW5hbCA8
bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDksIDIw
MjEgMTozMSBQTQ0KPiBUbzogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD47IFZp
Z25lc2ggUmFnaGF2ZW5kcmENCj4gPHZpZ25lc2hyQHRpLmNvbT47IFR1ZG9yIEFtYmFydXMgPFR1
ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbT47IGxpbnV4LQ0KPiBtdGRAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47DQo+IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnp5c3p0b2Yua296bG93c2tp
QGNhbm9uaWNhbC5jb20+DQo+IENjOiBNaWNoYWwgU2ltZWsgPG1vbnN0ckBtb25zdHIuZXU+OyBO
YWdhIFN1cmVzaGt1bWFyIFJlbGxpDQo+IDxuYWdhc3VyZUB4aWxpbnguY29tPjsgQW1pdCBLdW1h
ciBNYWhhcGF0cmEgPGFrdW1hcm1hQHhpbGlueC5jb20+Ow0KPiBUaG9tYXMgUGV0YXp6b25pIDx0
aG9tYXMucGV0YXp6b25pQGJvb3RsaW4uY29tPjsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gaGVsbXV0Lmdy
b2huZUBpbnRlbnRhLmRlOyBTcmluaXZhcyBHb3VkIDxzZ291ZEB4aWxpbnguY29tPjsgU2l2YSBE
dXJnYQ0KPiBQcmFzYWQgUGFsYWR1Z3UgPHNpdmFkdXJAeGlsaW54LmNvbT47IE1pcXVlbCBSYXlu
YWwNCj4gPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MjIg
MTUvMThdIE1BSU5UQUlORVJTOiBBZGQgUEwzNTMgU01DIGVudHJ5DQo+IA0KPiBBZGQgTmFnYSBm
cm9tIFhpbGlueCBhbmQgbXlzZWxmIHJlc3BvbnNpYmxlIG9mIHRoaXMgZHJpdmVyLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4N
Cg0KQWNrZWQtYnk6IE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkgPG5hZ2Euc3VyZXNoa3VtYXIucmVs
bGlAeGlsaW54LmNvbT4NCg0KVGhhbmtzLA0KTmFnYSBTdXJlc2hrdW1hciBSZWxsaQ0KPiAtLS0N
Cj4gIE1BSU5UQUlORVJTIHwgOCArKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4g
aW5kZXggYmQ3YWZmMGMxMjBmLi5iNDMxNWI3NjY0NWEgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlO
RVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+IEBAIC0xNDUyLDYgKzE0NTIsMTQgQEAgUzoJT2Rk
IEZpeGVzDQo+ICBGOglkcml2ZXJzL2FtYmEvDQo+ICBGOglpbmNsdWRlL2xpbnV4L2FtYmEvYnVz
LmgNCj4gDQo+ICtBUk0gUFJJTUVDRUxMIFBMMzVYIFNNQyBEUklWRVINCj4gK006CU1pcXVlbCBS
YXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb21AYm9vdGxpbi5jb20+DQo+ICtNOglOYWdh
IFN1cmVzaGt1bWFyIFJlbGxpIDxuYWdhc3VyZUB4aWxpbnguY29tPg0KPiArTDoJbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnIChtb2RlcmF0ZWQgZm9yIG5vbi1zdWJzY3JpYmVy
cykNCj4gK1M6CU1haW50YWluZWQNCj4gK0Y6CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9tdGQvYXJtLHBsMzUzLXNtYy55YW1sDQo+ICtGOglkcml2ZXJzL21lbW9yeS9wbDM1My1z
bWMuYw0KPiArDQo+ICBBUk0gUFJJTUVDRUxMIENMQ0QgUEwxMTAgRFJJVkVSDQo+ICBNOglSdXNz
ZWxsIEtpbmcgPGxpbnV4QGFybWxpbnV4Lm9yZy51az4NCj4gIFM6CU9kZCBGaXhlcw0KPiAtLQ0K
PiAyLjI3LjANCg0K
