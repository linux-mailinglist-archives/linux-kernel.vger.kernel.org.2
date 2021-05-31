Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3163956B3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhEaIOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:14:03 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:53894 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhEaIN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1622448736; x=1653984736;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1QsEFjjaXZ7knlMtVEH6atUjOk/SjbyAgJLCVeQ9h20=;
  b=CuYe3QDLNsjdD9nkZL2CYwVnCBzFvh6hwGPcYRSOqXwFv77YXn9XZl2s
   cTNzK8RXJYfzFzhU9wBYfe66ZgJi6tgt/gq2sBd4vP/osWL9RKdHVFc4H
   wFowQxByr7RN/gEKWnxQpxuwrTKOWMZYfaeXCvlqGEXOWTaw7MsgfBJW/
   ZBY/Pm0G+aU2UKwrEviwmacvunOmrKR9db1EUFRD5mJAe8bd8ggoVDTee
   vqpF5l2vYparwxNKgSd1/r0wIkBa6U2EQg7qnqYo87aSVuyZAADVjclzS
   /a+DcGa6fZaUTd2v7I8d6pCQWwC9lz02KOVch7qzaQQ4mtiT5Fo8dKDRY
   w==;
IronPort-SDR: OD6B7h0+cLnLBTZWOuW3vT9GFh+vM/DuJjplAOEDr8hZwE148aq/V8rCVyF8BLG3O1Cm9JgHkH
 ukivqR1JvJTmTz1MTTmAklllJRpPR/QPEgZ/Sfb2hOBAICFEuKwaepLWa3cSketw0uwmtJPxSg
 vJ7w1jiDYNe1tnYJU+Xiw/SWHyEf58qLTnUG8J3Kq4kc0qqild/LaXUud9fG3E/GvU4hMKKvHi
 lbqdP9VtpjLPwkHStlDClpKC4byVjRZj+S/w+XDKXAfFggJhoXVc3ElsMDQQ0kB1FrlkG7g2fv
 LdQ=
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="117123801"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 May 2021 01:12:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 01:12:16 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Mon, 31 May 2021 01:12:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpfUmiZVBIA+6gniKji8vdHd/BOy/Hbzn8nfJoMqmJ1RdMKCDdtAGMT6PtQfyVqvmLKIfrHNWtbNcov0/lZACwi3e7ZEnAMpI0Wv4srlnt0MYykOBg7Q55VNur+PtMhwcTx2AWe9gap7I0YuIUQnhk8ILtw87SjboGS6kKhJiPcqa5o3YZ1Rhvnf7fqAD+a3s1muomemc7FkT62zH6EHy6F3n2wRuFZMJQBGehMZvrHz97qleEHYNAi7QbQMhCTOYHWo1BveJ1FSBRsZemcMSHoUQX81YM09VMnYj8eI4RCc4isX8o3D9mU/bRnhnMtInwM+YP5hHMBSRAFDpKcQLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QsEFjjaXZ7knlMtVEH6atUjOk/SjbyAgJLCVeQ9h20=;
 b=j/n9ZnPcxZ+4dlVj5W5kQtcqq2TSq9HgpTNOb64Qrjl7PmOVeD4gSw6snGPtgubTjQnWYFvqDAh7XZdUZX3idYxxv5/qvDosAbqCixA33REGnFzV5Nh3JRqrQOkHEtMnIN2/be1puj5mPxHSb3x9bs3xVIUaWw4R5sBXtNTNzWf/qm4IYch7lFUIAOH2APSm/WaOb7v6L+E7f5Op2FoxHfuAlyBo2sDCdsbXZd0d5dHYqst5pjrQoKt6QQqp4q3mtNQ/7+yM6xU7w0rep6X7xOrKb33DnebS2vWruEb90q1Xoc9OvPUWimPjsPNtN5cfh+7lxhyKII7oYquA55mq2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QsEFjjaXZ7knlMtVEH6atUjOk/SjbyAgJLCVeQ9h20=;
 b=llJZijB2rtbCw2gA8FBSs0CGAN8nedO8+NQ0CC6tXGzWAnERZi4yDfaaIGC3xvW2xUwqVFWbTbdVVfiEP4r56A5hXUJMdJ4RI+KhUjWpPHPgJAS/AIN3VtQIJWfNqUFzfOWp+Ix+eU8/jfh3NdAYIttiIEGMA60f30/+vSlg688=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MWHPR1101MB2176.namprd11.prod.outlook.com (2603:10b6:301:4f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Mon, 31 May
 2021 08:12:14 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1c4:1014:a541:e370]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1c4:1014:a541:e370%4]) with mapi id 15.20.4173.029; Mon, 31 May 2021
 08:12:14 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v3 2/3] mtd: spi-nor: otp: use more consistent wording
Thread-Topic: [PATCH v3 2/3] mtd: spi-nor: otp: use more consistent wording
Thread-Index: AQHXVfSpsxoRfN5Vh0GYXTu/SyR75A==
Date:   Mon, 31 May 2021 08:12:14 +0000
Message-ID: <6e2a631d-f514-db3b-8b46-b71076bd7993@microchip.com>
References: <20210520155854.16547-1-michael@walle.cc>
 <20210520155854.16547-3-michael@walle.cc>
In-Reply-To: <20210520155854.16547-3-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4ca367f-0618-405f-6aec-08d9240bcc83
x-ms-traffictypediagnostic: MWHPR1101MB2176:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB21764E441A7670F4E92E42BBF03F9@MWHPR1101MB2176.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NSMCv7AtVsPMcApTOQIV278hLLyAqq4kIufQS+QMtP87dJtC7ahPHlFj/shOEKY+Uy3zlb25QQXK2aJi3MPu0a4ojpZ8Mml4PfQEezmMyMkqDBRcYUzFIvGWkKTcnRSnbqd53HGpowq+5A6gyUbObUVGvXevL4nMaiYp/E9dWNpVrTzcDO178tG6/UQh073CR8MhHyW7xLFiGBKPhFD9W32Q0yLkmjU3lERQDoQU4pVfBteR2WzDPrdb8Hs4j/i97+GdGrZp5RZDkqauuhhDST5g6d4cEm2AP9Sec3JnqnVM6HAiH0Mxkf9GlByE0gcjRKBboIiFQ1lx+W1g+2bft4nmDzSHmNq7uaAxgt5wfP/WScK49SKOSAKnZHFfyxWBZMHbRSa87yjbubFSAQmP7i7vT0BqCv53bzovOT4qPnE0y5bmnVYvFs+QeuEfZwdMMuMjXhYi4sJlBFEa6hq/jppeRKrCwnZ2BOyxkR1G1fT+g+Xqbwg48O6Mcd5Q1x84GlI+daBI4/BL0VxeMTeOcIZ/aBWcqDkooGEOP16uQIRbeWztlCLO3UsN9Ix9Y7sLla8MBFGdSHWhja800ZcAD5pm5QeZkHL53kLfd0obzo5J9GtiGUzR4X7BkJlCzLHUeCwivloc1yx7ovSZ4YGwM4+rsHa+Q06GA8B9hyqI83eSnnxgxTurZXlmWqBWbygt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(39860400002)(346002)(376002)(26005)(186003)(86362001)(2906002)(5660300002)(316002)(4326008)(2616005)(83380400001)(38100700002)(122000001)(6486002)(478600001)(64756008)(66946007)(8936002)(31686004)(110136005)(66556008)(76116006)(36756003)(91956017)(53546011)(6506007)(6512007)(71200400001)(8676002)(66476007)(66446008)(31696002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UXZqYXkzWk9POUw0cUFGWXJRdGdXeDlUd0xxRHpmeDFzNTgzK1gzZTF6Zk5m?=
 =?utf-8?B?Q3I1Mnl5enlkL0I5WUlPakNwWTVaVTBQdW9PYWpDZ0FaYVErSU9tMk91bHAv?=
 =?utf-8?B?YkxiZGk1STF3T211OTRzWWRMWVNiUlQ5OGZRcEZDWmZhdDA2VHhjYmlwbnor?=
 =?utf-8?B?cCt2emtROGhKMmFQQi9FUFBPamlVQ3JmdTZDNDd4eUgwTDNmOVNPRHJhcHdz?=
 =?utf-8?B?TllKdCtiUGdSK29pcHFzWkpXaU9hUzBOb2dMQnROc2pJRmVPVDYwb1M5QlRK?=
 =?utf-8?B?bDVtQ2pMVWxYY3FQdXFSc3MxN3JINVB1TEwvVUxnSEsyTUMvRktQQzl0SUF0?=
 =?utf-8?B?aUo0UHl2T05NTTBIOUZrN2VuNEVtVkdtc1ZWMkNZcTRCZm9WQ25hRlhJd2lD?=
 =?utf-8?B?c2lHTlNGWlpoSENCbmUvRXNVWjRBTDJ1NE1QL0t3Yi9FU1FZclJJUzcwMWFu?=
 =?utf-8?B?RUdZVmtEVWMySW9lQ290dXlZT3dPeEpiODNNTVJEZmEzZ2wvM1BpYkk3V2wx?=
 =?utf-8?B?Q3hoV0FXU1VJQzc1WHlMaXJqNElRSUVxYXRJbC9RUi9UbWN6SVFQUi9Va3Q1?=
 =?utf-8?B?ZEhFKzYwRzdlMG9GTzZFZ1ZTdHd5bEE1Z3piZnJ2SVZVNXRMcTVnYStLZytX?=
 =?utf-8?B?T1M4RkwvN1VWZjFhK0ZWTGFZVFVmSFh3cXpKejZOUHhRdm9xZmlrZ0xsY29M?=
 =?utf-8?B?eFNoMk5IT3NMUWJyQ2pMOFpnbDJ3ckRIY09TajBGSExIYjlZcFNaY0NYOEsx?=
 =?utf-8?B?dm5HZjNPVDlmSW9sWU9KZk9SS0QzdVlXQXdWK1YvZFdLK21DdldPc09sa0hQ?=
 =?utf-8?B?WmdwRVIyUkJaVzUrTEdWL2grU2xpWDRtUTFUT2o0MndqQWRDK0hsdGxkdWNG?=
 =?utf-8?B?YjJjdnZkOXM3SElkWXZ6SHN1UHl3WmZjaU03L2V5aTQxWkl2ZVpaYUMwYVcr?=
 =?utf-8?B?UjZWTkdIVGVNc1ZpK2hmOVd0NTJYU3c4SDQwRFJsSUJKMEYrZXJoLzdFQm5x?=
 =?utf-8?B?WC9WWDBoT3FoaC9Ydllxc3loT1MxMEw1ZFlWTzJ3Njd1ZGh6aDV6QksxMEkx?=
 =?utf-8?B?ZXNBR0NZKytneFRNUmF1MElvUVYvWUpsL1ljeHZJeFk0OVAzeE5DdkdtaXJ2?=
 =?utf-8?B?STMzT0NWNTRmTld1bnkxUnZEejdRVURmbWdrd21hREhPRHZ5Q0ZCU2ZvSGdw?=
 =?utf-8?B?R3JrQVdMdS9MV0YxVVUwVHZSTWk1ZEFTekMwU0lmVzZoV2w2RmsxekVnbyt5?=
 =?utf-8?B?L3VFUnRiaFN1ZUJiZXBSWFFKeUVBUkJZNFpyWk5NWjJ2TEZYdW9iV3pFZ1E3?=
 =?utf-8?B?LzAySEN3NnBOZHBRaWZEVTVid1g4T2RyQzNKTTB1aDlKOXRYdHFVam96dTVt?=
 =?utf-8?B?VE1oeTNvcVB2U0JOWFRLQlB1bWZFQTMxWXoyK0xiTldWNWFHUUNlSUJBN29n?=
 =?utf-8?B?VGV0WmhSZ2xNY0pNM0wyR21aR1VvTkl2WGRzYk5SeElNZ2xCbGpZTG9JY3p6?=
 =?utf-8?B?cFJZUkFVRnlpRWFHSXBsbFRzUjZMWWNvWEVydXNWR3lqQVB2eWxlTXJESmJs?=
 =?utf-8?B?ZDE5Sm5NL1ZwR1dYby93ZWFXVEpyRXp1RXRaajV1M0VtR2txemQ4UHJCZVM4?=
 =?utf-8?B?bXFUYXRZQXIrT3QvRkNrR0I0Tkt4TlR1enhpK05LRnhtRlFSZmhTaDYyUkpP?=
 =?utf-8?B?bUszVnlHWVdLVE5FWXVKWjkwSm5rRkNFRnAwRHA3T2c3M3FHdUN4SGl4Rkht?=
 =?utf-8?Q?hLDJKpNScSTTf7xiPY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1624D7D468B43841A4CCC65F171106BB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ca367f-0618-405f-6aec-08d9240bcc83
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 08:12:14.3373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IDgODncOmyKtxVKhGeMBN6Patr0m6/80b5pXROLHkRLoz4dGyjvmDDVrOpt0IJV6aWZhYxB+rb0JvkWkXc5nBbDCJF3NnvyebkDyeUUirF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2176
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yMC8yMSA2OjU4IFBNLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFVzZSB0aGUgd29yZGluZyBhcyB1c2VkIGluIHRo
ZSBkYXRhc2hlZXQgdG8gZGVzY3JpYmUgdGhlIGFjY2VzcyBtZXRob2RzDQo+IG9mIHRoZSBzZWN1
cml0eSByZWdpc3RlcnMgKGFrYSBPVFAgc3RvcmFnZSkuIFRoaXMgd2lsbCBhbHNvIG1hdGNoIHRo
ZQ0KPiBmdW5jdGlvbiBuYW1lcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgV2FsbGUg
PG1pY2hhZWxAd2FsbGUuY2M+DQoNClJldmlld2VkLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5h
bWJhcnVzQG1pY3JvY2hpcC5jb20+DQoNCg0KPiAtLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Iv
b3RwLmMgfCAxOCArKysrKysrKysrLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNl
cnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRk
L3NwaS1ub3Ivb3RwLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL290cC5jDQo+IGluZGV4IDkxYTRj
NTEwZWQ1MS4uZWMwYzFiMzNmN2NjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9y
L290cC5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivb3RwLmMNCj4gQEAgLTE1LDE0ICsx
NSwxNiBAQA0KPiAgI2RlZmluZSBzcGlfbm9yX290cF9uX3JlZ2lvbnMobm9yKSAoKG5vciktPnBh
cmFtcy0+b3RwLm9yZy0+bl9yZWdpb25zKQ0KPiANCj4gIC8qKg0KPiAtICogc3BpX25vcl9vdHBf
cmVhZF9zZWNyKCkgLSByZWFkIE9UUCBkYXRhDQo+ICsgKiBzcGlfbm9yX290cF9yZWFkX3NlY3Io
KSAtIHJlYWQgc2VjdXJpdHkgcmVnaXN0ZXINCj4gICAqIEBub3I6ICAgICAgIHBvaW50ZXIgdG8g
J3N0cnVjdCBzcGlfbm9yJw0KPiAgICogQGFkZHI6ICAgICAgIG9mZnNldCB0byByZWFkIGZyb20N
Cj4gICAqIEBsZW46ICAgICAgICBudW1iZXIgb2YgYnl0ZXMgdG8gcmVhZA0KPiAgICogQGJ1Zjog
ICAgICAgIHBvaW50ZXIgdG8gZHN0IGJ1ZmZlcg0KPiAgICoNCj4gLSAqIFJlYWQgT1RQIGRhdGEg
ZnJvbSBvbmUgcmVnaW9uIGJ5IHVzaW5nIHRoZSBTUElOT1JfT1BfUlNFQ1IgY29tbWFuZHMuIFRo
aXMNCj4gLSAqIG1ldGhvZCBpcyB1c2VkIG9uIEdpZ2FEZXZpY2UgYW5kIFdpbmJvbmQgZmxhc2hl
cy4NCj4gKyAqIFJlYWQgYSBzZWN1cml0eSByZWdpc3RlciBieSB1c2luZyB0aGUgU1BJTk9SX09Q
X1JTRUNSIGNvbW1hbmRzLiBUaGlzIG1ldGhvZA0KPiArICogaXMgdXNlZCBvbiBHaWdhRGV2aWNl
IGFuZCBXaW5ib25kIGZsYXNoZXMgdG8gYWNjZXNzIE9UUCBkYXRhLg0KPiArICoNCj4gKyAqIFBs
ZWFzZSBub3RlLCB0aGUgcmVhZCBtdXN0IG5vdCBzcGFuIG11bHRpcGxlIHJlZ2lzdGVycy4NCj4g
ICAqDQo+ICAgKiBSZXR1cm46IG51bWJlciBvZiBieXRlcyByZWFkIHN1Y2Nlc3NmdWxseSwgLWVy
cm5vIG90aGVyd2lzZQ0KPiAgICovDQo+IEBAIC01NiwxNiArNTgsMTYgQEAgaW50IHNwaV9ub3Jf
b3RwX3JlYWRfc2VjcihzdHJ1Y3Qgc3BpX25vciAqbm9yLCBsb2ZmX3QgYWRkciwgc2l6ZV90IGxl
biwgdTggKmJ1ZikNCj4gIH0NCj4gDQo+ICAvKioNCj4gLSAqIHNwaV9ub3Jfb3RwX3dyaXRlX3Nl
Y3IoKSAtIHdyaXRlIE9UUCBkYXRhDQo+ICsgKiBzcGlfbm9yX290cF93cml0ZV9zZWNyKCkgLSB3
cml0ZSBzZWN1cml0eSByZWdpc3Rlcg0KPiAgICogQG5vcjogICAgICAgIHBvaW50ZXIgdG8gJ3N0
cnVjdCBzcGlfbm9yJw0KPiAgICogQGFkZHI6ICAgICAgIG9mZnNldCB0byB3cml0ZSB0bw0KPiAg
ICogQGxlbjogICAgICAgIG51bWJlciBvZiBieXRlcyB0byB3cml0ZQ0KPiAgICogQGJ1ZjogICAg
ICAgIHBvaW50ZXIgdG8gc3JjIGJ1ZmZlcg0KPiAgICoNCj4gLSAqIFdyaXRlIE9UUCBkYXRhIHRv
IG9uZSByZWdpb24gYnkgdXNpbmcgdGhlIFNQSU5PUl9PUF9QU0VDUiBjb21tYW5kcy4gVGhpcw0K
PiAtICogbWV0aG9kIGlzIHVzZWQgb24gR2lnYURldmljZSBhbmQgV2luYm9uZCBmbGFzaGVzLg0K
PiArICogV3JpdGUgYSBzZWN1cml0eSByZWdpc3RlciBieSB1c2luZyB0aGUgU1BJTk9SX09QX1BT
RUNSIGNvbW1hbmRzLiBUaGlzIG1ldGhvZA0KPiArICogaXMgdXNlZCBvbiBHaWdhRGV2aWNlIGFu
ZCBXaW5ib25kIGZsYXNoZXMgdG8gYWNjZXNzIE9UUCBkYXRhLg0KPiAgICoNCj4gLSAqIFBsZWFz
ZSBub3RlLCB0aGUgd3JpdGUgbXVzdCBub3Qgc3BhbiBtdWx0aXBsZSBPVFAgcmVnaW9ucy4NCj4g
KyAqIFBsZWFzZSBub3RlLCB0aGUgd3JpdGUgbXVzdCBub3Qgc3BhbiBtdWx0aXBsZSByZWdpc3Rl
cnMuDQo+ICAgKg0KPiAgICogUmV0dXJuOiBudW1iZXIgb2YgYnl0ZXMgd3JpdHRlbiBzdWNjZXNz
ZnVsbHksIC1lcnJubyBvdGhlcndpc2UNCj4gICAqLw0KPiBAQCAtODgsNyArOTAsNyBAQCBpbnQg
c3BpX25vcl9vdHBfd3JpdGVfc2VjcihzdHJ1Y3Qgc3BpX25vciAqbm9yLCBsb2ZmX3QgYWRkciwg
c2l6ZV90IGxlbiwNCj4gDQo+ICAgICAgICAgLyoNCj4gICAgICAgICAgKiBXZSBvbmx5IHN1cHBv
cnQgYSB3cml0ZSB0byBvbmUgc2luZ2xlIHBhZ2UuIEZvciBub3cgYWxsIHdpbmJvbmQNCj4gLSAg
ICAgICAgKiBmbGFzaGVzIG9ubHkgaGF2ZSBvbmUgcGFnZSBwZXIgT1RQIHJlZ2lvbi4NCj4gKyAg
ICAgICAgKiBmbGFzaGVzIG9ubHkgaGF2ZSBvbmUgcGFnZSBwZXIgc2VjdXJpdHkgcmVnaXN0ZXIu
DQo+ICAgICAgICAgICovDQo+ICAgICAgICAgcmV0ID0gc3BpX25vcl93cml0ZV9lbmFibGUobm9y
KTsNCj4gICAgICAgICBpZiAocmV0KQ0KPiAtLQ0KPiAyLjIwLjENCj4gDQoNCg==
