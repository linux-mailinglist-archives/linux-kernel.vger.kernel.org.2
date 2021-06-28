Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF403B587B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 06:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhF1E6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 00:58:14 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:11727 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhF1E6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 00:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624856149; x=1656392149;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tQldcAy16xB0MzL+yOyd7W0V1su0vj+O2g83xXwAy7c=;
  b=CU1NMhHg7Fkh2lcB2FSFJK56mh05okVx4lX3rVDqSBx3s1RVElHBjus8
   bd+nJPmzrUVqD7LFLFHITjvNalZk9WmhP+ygyF2xdanE/txOznpyvKyTm
   pubFD5ml1T3NUlMztxd5lPeqEClOd84ynVkEIGW/nw0md9MT6ddHzm0Tv
   HzI/A1oWBNCw9+TAxPgWHKXZLddTfmOetMM7GTOz7XcuMW/3h9gwKp3Cg
   TXdkxr219tiNeyX/1bOVwPbvBBE9CYJyVSfPVbXSPqn3BPGkwyLp31fUy
   VbT90b3Lw1XSejEIx+Hpw2+x3eNHQ9BcyvFCD8QBwoobW8gu4qY2KwElC
   Q==;
IronPort-SDR: Xe0RVqhnMkfgY7RpkMPYwxQsXkVSvbNk8EKw9hO0pY71e8p6joWOmZWbQa1UEMar13gc3WN8cy
 JPRpWH11bcz0bzvpfRJtWb2Cc0hK0VfzR3flcf6xBuO+3k5jJ98oVtieEQeQollJWN+Rtgtfl4
 k0L9qHMMBuZAuXJB53rSPM4M6/NIjin6QW8zwPyAABd7sCSMCl+Rd0TyDH9jp7bnoJMkmBBHUn
 XChCshUW0iGHRUlRALzaY8445Eu+UBsdHbGsuytnFspPnxCJLAX+dEUP2XMtqvUijaSXl7AX1L
 0G8=
X-IronPort-AV: E=Sophos;i="5.83,305,1616482800"; 
   d="scan'208";a="126277067"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jun 2021 21:55:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 27 Jun 2021 21:55:46 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Sun, 27 Jun 2021 21:55:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zu+vntlw0ExUPjT+skLLsgtQOvSJgpujBFlIRcmWWvU2EdFN4rPxM/v31K7nyqRvj96a5/37DtPSao88K6JaEClXOeHuvPgRKwgqlUbSE0n/tWKWSZTTYpGG+zfd89AkzVZ73ULIgNp/lfXfH/qhMoE5VGyDVMpGe6Q3ZxoZl1Xfit8pU2qXZ9X44ky5yCa/FBKXKYRSC507IzpzYH4jgkt/Zp2iaQieV044ugHs6g+YVpv5dXdwubteml4/8bqAQZjzHtfln0ymvol7H0Cbp1Ie6xN6nlJwmkTyD5v7bVxSJONun41ekJvENsJOfdlCS+E73AV3esUCKahqiYeFXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQldcAy16xB0MzL+yOyd7W0V1su0vj+O2g83xXwAy7c=;
 b=JaEXJSzmwmScFgwIRLrg96Ylag5NJUW+Sm7FUNsYWqVM3uURIVwBsaDi7lDEDoaQNWO0IQIQ0Iwgk26MO2xQ50jbr6/7C86eWFQCKLQn4QqEHRftZAMpQg3tV/5C/DEFSi42F6FYKc/GT3NFw8DyLqjaUHL1dBpM+YxJcH2LwMDmseUwz7lrbR0gVjC6g0hro4dVgUeiM+5qVtJbC4UuP953KiZTQgMTEm/b2KukZCS/z8nUib7HE0XIHT4MkEA09929SDu9TxaVzf/I+b391zWl1jYwu4PtpSuaLcJHldAZJjxMdCcmMIgH4pGY4j4EJoWw3fUpqmqf9yfLgCykHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQldcAy16xB0MzL+yOyd7W0V1su0vj+O2g83xXwAy7c=;
 b=AIat3dhjpYBZiyMMHbi6vuWBrJW5G37yzYA9JB4CURnNvgQoy8QzT8l743PztkeDKQTc42RXzLDkrixevaXluHm2VdmFkF16AoFmHW7Jk8mCvIgNm2+IP+70gdYmnV16aZSTrlqJH6++4o7D5Md5BbR4t0d4+oEx+CKEFQW2/KU=
Received: from PH0PR11MB4869.namprd11.prod.outlook.com (2603:10b6:510:41::8)
 by PH0PR11MB5080.namprd11.prod.outlook.com (2603:10b6:510:3f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Mon, 28 Jun
 2021 04:55:43 +0000
Received: from PH0PR11MB4869.namprd11.prod.outlook.com
 ([fe80::5067:83f9:991d:2ab4]) by PH0PR11MB4869.namprd11.prod.outlook.com
 ([fe80::5067:83f9:991d:2ab4%9]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 04:55:43 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <code@reto-schneider.ch>
CC:     <linux-mtd@lists.infradead.org>, <sr@denx.de>,
        <reto.schneider@husqvarnagroup.com>, <miquel.raynal@bootlin.com>,
        <p.yadav@ti.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mtd: spi-nor: Add support for XM25QH64C
Thread-Topic: [PATCH v1] mtd: spi-nor: Add support for XM25QH64C
Thread-Index: AQHXa9nZhBHIVrQioUm7jO1Sivr3QA==
Date:   Mon, 28 Jun 2021 04:55:43 +0000
Message-ID: <0328347c-572d-b636-5542-99cb36e9efa9@microchip.com>
References: <20210613121248.1529292-1-code@reto-schneider.ch>
 <1ba367f93650cb65122acd32fb4a4159@walle.cc>
In-Reply-To: <1ba367f93650cb65122acd32fb4a4159@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23132481-49ff-43f6-206d-08d939f0fc55
x-ms-traffictypediagnostic: PH0PR11MB5080:
x-microsoft-antispam-prvs: <PH0PR11MB50806C44AE67C7C21E452324F0039@PH0PR11MB5080.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NQHadt8/lLuHsbRsaniGxAoWx0ssU/JYT3+VQEw8Vu0FELXLeDVo1P0axDRrV4zJrXit6KJ+ksOUb6bQdT6b8esEiO4lMjXsjlSwiD2goNUMQ1GN7n14jDr0d9IhRVUPmXUb+5KaYRuIl9O6rTjmlc1VdnRFM72Q4U5hsgGk9mwuAsiEpPqTL9bcyLo5VwRSumFW0cqZ7zdzJoDJ9vikQdThG16VXcH/VonkCF16M2wM9ASUdBQEyjFXrDF3l+EQlbGerbyscu6xnNMoLzIgMzTHsDorEdBr7w0g6DN3f1ruZjUn7Ghoe+YGhadibSsMAWbRxr4TIOB8EVstxmm8Nn0wL4OyjtgS8LxqYys9K8Fx3OjLnGz3z3a/CX8yTuYM2WlRBKnkQtQrUdoGAUNrmt6F74wKcyMCbTJphQrPDreTJMa4zuEzomJJsr5tLUikAP3ZehW9CURg261lUvdkgOeR14vRfYJvGbDFEIjF6QZknGao/B+h/eakCsHkb9+dqMuuquVbAxP1Ks8ldamH7FDkON+rNEOo1ej8Mp8bOov8R14SxI9k0YztuHxmfVlV4yNNTjhRlDL0P/jvPab5XiENiPqyAJrl/HAQcRMxQR5u+tF1uusrMQoJu2+I7sQ17ukMhkzwCCkQNWesFa0TUXaSFrS8UC105j2CioctVGcrM9nQSFM0q2X7DfoyLrj7ca+SkGugXBisEaEwJP9cSFKUiy3jCGjqg3ejoxJi9EGW3CJisjJfzVKVacARelMSu7EIhKBp9eW1cas7praquCn1brLwDHxxYZM8GwTR9N67oCzmtsZpH5IavPQFGqqo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(376002)(396003)(346002)(6486002)(8676002)(31686004)(6506007)(53546011)(110136005)(54906003)(316002)(8936002)(7416002)(186003)(26005)(4326008)(966005)(2616005)(6512007)(478600001)(36756003)(66476007)(122000001)(66556008)(5660300002)(76116006)(83380400001)(31696002)(64756008)(66446008)(91956017)(38100700002)(4001150100001)(71200400001)(66946007)(2906002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2YzclJRS1M2eE1sbFc4U0JnQkg3VzREQUJqazNaOG55Wmc0TnRQUThsa0xN?=
 =?utf-8?B?alRTR2VYcTkzUXVjWXE1TnNxbGRTSVVhWW4yYnJRbHBZZVlVQkw2R2ZrUzlw?=
 =?utf-8?B?Tk9GVWZnUUxoaGhvOWI0OTJ2cUxSL2VNUE0rRzRBaUVxaUVJWVYvTFpBQ003?=
 =?utf-8?B?OVU4Vlc3QTVJeEFnTEdncGpRYmdWc2dKYlRkTnllc21WWHNqZm1EWnN1ZURh?=
 =?utf-8?B?bHpGYmdCR0ZPejBOVUZvaURNTnpicEduT3FXQ3JaeGNVYzRIUkhoVi9QT2JO?=
 =?utf-8?B?NUtZdnFxZDNsWUdHdkJJWkx0MXY3Snd1eEk4eGNTWHZKV2tpVEJIVC9YWnc2?=
 =?utf-8?B?bktjNkxvQnJqb1NtR3dDOTgxRnI5SGxFVlhRQjE3K2R1aG9GdEtDSHNLRlVi?=
 =?utf-8?B?eDMzWHpoMmppRDFkYkdMcG9iUlZoc2plYlIvZkRaRzNMRTh5ZkFZL2JkczZ1?=
 =?utf-8?B?dnpRREZ5Mk0vWTNUZE5jK0plSHJWVTg2azc2NFpZSG1ERXY0UFNnT1I5OHJD?=
 =?utf-8?B?dFhOSDlSRGt0ZzNsMDBrbmxSa3hiT1FkT08rYkxNQVdCOTVFS21XQUhMTjdh?=
 =?utf-8?B?ZUh0dWU1bE5XdlhEKzNEb1ROYVpDRnJjWkFXYTB4RlYxaERyWEZNRDhoQ3lh?=
 =?utf-8?B?ZnNKc2RKZmcxUDRqU2Z5bTU1Q1BDYWxWaThDVkUzL00vWWlVNHYyL2tSZVZt?=
 =?utf-8?B?ZVVTOGhSdSswaWQzRVYydWhpTGdsa0wzeUxnUEtJNG1sVHIydU82azZoTkNo?=
 =?utf-8?B?YW9BRm0rVGZTOXlmclovcHZEaU5zZXYxTERrL1ZGR3I2TjZhNGtidXF0S3Bj?=
 =?utf-8?B?SVk1WXlvK1QrUTB4cnljRjlrTk01d1R0amtpNERZRUNHR2w4R3c2aU1nUXVO?=
 =?utf-8?B?UUhVeG1DNWowWk5tKzFIcXVBL0NCMWtFdFlmN2p0U0pCeUNSUVNBL0dYQmRD?=
 =?utf-8?B?RUY5K0RUSjVjZEp1WG9XREVQTmFuTlJQWFdKRkR1c2o4b2dlQmRWV2tBeW51?=
 =?utf-8?B?WS9JSVNOL0l3eVRMTm9OejB6WWg5dGJhYys3UnIwRm40UnR0c2RLN2JubUox?=
 =?utf-8?B?ZlQ1bmE4NU1YM2w1WHB2Vld0M0lRYy9tckRSeTB3cG5tV0N3Uk41KzhVTWNQ?=
 =?utf-8?B?MHZSaWJNVlZWN2tkT1VoT0s4YlpWTVhLcnUzRnVYdytiR3B2aDlFWDRvZWFU?=
 =?utf-8?B?OUlkb29aOGdZUkRpaDlzRkNPcEpJQjJOdFQyejU3TExqZFpyUmxWcXhHNnNX?=
 =?utf-8?B?c09HdHQzU21qNThRRzJPak5adS96ZEdsR000K3JzTVpwZW9VQkczelhhZFcr?=
 =?utf-8?B?amlmdHA4U2VwNXpDejJ3VkhrK3VzVkhIWTNyYytYclFRa0hEWXlxQTE4eUdV?=
 =?utf-8?B?Q0drUkVkZFVkaSsrUUpXcUV0NkJNdUhWaWJRbWZxZThwWThwdVFVaGJNUmQ3?=
 =?utf-8?B?S083K1FKc0dYRHZKeVVjc0ZCREllR2E5WDJveXI4Zk96Mzh4TWtnT3V2UDNC?=
 =?utf-8?B?eERoTm5GbG9PdGgxeDM1aHBCc2RDc0hoaVlaQnZLM25RQ0NJS1BtdHpxODRX?=
 =?utf-8?B?Z3Z6dEFpTW85YXJBZGZGeDN2TTZ5ZjZKVHlXTDBQWkpVaXhSQ1UvT1l1azFw?=
 =?utf-8?B?VDhWOWc0QVZqV2g1OXRHNUlPdU56TVloTzhHbkVrcU1qK1NQaUoraW1RYXdC?=
 =?utf-8?B?anFnOWhhRGIyODk0bUVhamhaQlllcHh2ejdtbzZERmhqOVRyVmg0M2hrWlZX?=
 =?utf-8?Q?vOKWIvsGDZriPZf55M=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F8A4134802C184BAC6DB15DCC9D2E44@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23132481-49ff-43f6-206d-08d939f0fc55
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 04:55:43.6364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WG+N8cQHtisBkb2skHWBV0VrRMdT4Ed744uifTcVqmWlVLVea/c6flOI1MFr2vQHMiqn3c4Agbni/m286l/OKT4C5Oe930W7ZqYKAldrVrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8xNC8yMSA5OjU2IEFNLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpIFJldG8sDQo+IA0KPiBBbSAyMDIxLTA2LTEz
IDE0OjEyLCBzY2hyaWViIFJldG8gU2NobmVpZGVyOg0KPj4gRnJvbTogUmV0byBTY2huZWlkZXIg
PHJldG8uc2NobmVpZGVyQGh1c3F2YXJuYWdyb3VwLmNvbT4NCj4+DQo+PiBUaGUgZGF0YSBzaGVl
dHMgY2FuIGJlIGZvdW5kIGhlcmU6DQo+PiBodHRwOi8veG1jd2guY29tL1VwbG9hZHMvMjAyMC0x
Mi0xNy9YTTI1UUg2NENfVmVyMS4xLnBkZg0KPiANCj4gQ291bGQgeW91IGFkZCB0aGF0IGFzIGEg
IkRhdGFzaGVldDoiIHRhZyBiZWZvcmUgeW91ciBTb2IgdGFnPw0KPiANCj4+IFRoaXMgY2hpcCBo
YXMgYmVlbiAoYnJpZWZseSkgdGVzdGVkIG9uIHRoZSBNZWRpYVRlayBNVDc2ODggYmFzZWQNCj4+
IEdBUkRFTkENCj4+IHNtYXJ0IGdhdGV3YXkuDQo+IA0KPiBDb3VsZCB5b3UgYWxzbyBhcHBseSBt
eSBTRkRQIHBhdGNoIFsxXSBhbmQgc2VuZCB0aGUgZHVtcD8gVW5mb3J0dW5hdGVseSwNCj4gSSBj
YW4ndCB0aGluayBvZiBhIGdvb2Qgd2F5IHRvIGRvIHRoYXQgYWxvbmcgd2l0aCB0aGUgcGF0Y2gg
YW5kIGlmIHRoaXMNCj4gaW4gc29tZSB3YXkgcmVnYXJkZWQgYXMgY29weXJpZ2h0ZWQgbWF0ZXJp
YWwuIFNvIGZlZWwgZnJlZSB0byBzZW5kIGl0IHRvDQo+IG1lIHByaXZhdGVseS4gSSdtIHN0YXJ0
aW5nIHRvIGJ1aWxkIGEgZGF0YWJhc2UuDQo+DQoNCkNhbiB0aGUgU0ZEUCBkdW1wIGZpdCBpbiB0
aGUgY29tbWl0IG1lc3NhZ2Ugd2hlbiBpbnRyb2R1Y2luZyBhIG5ldyBmbGFzaCBJRD8NClRoZSBT
RkRQIHN0YW5kYXJkIGlzIHB1YmxpYy4gU0ZEUCByZXZlYWxzIGp1c3Qgd2hhdCB0aGUgZmxhc2gg
c3VwcG9ydHMsIHdoeSB3b3VsZA0KdGhhdCBiZSBzZW5zaXRpdmUgaW5mb3JtYXRpb24/IFJldG8s
IHdvdWxkIHlvdSBwbGVhc2UgZHVtcCB0aGUgU0ZEUCB0YWJsZXMgaGVyZT8NCg==
