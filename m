Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4103CBA67
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 18:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhGPQSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 12:18:24 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:22496 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhGPQSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 12:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1626452128; x=1657988128;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wjWsIykvHIPrxopSlVPRezJ3/QtPnZSlr9h562Y4uiM=;
  b=ikPwHEPi0bJM8JPRY9PfeJfJjQ91uVSNtCpGMGa4BT4ufKD7RhZKf0kE
   fBZHNvvSILlZSx6CmyGrhVuECDOrqXveqiCFOlCfttTpaY2RUKDja2hbi
   irx7HAV+VNrDvmmHM9u9xwNCCCpWIg8dPb5k7xDEHrDA4rSh4R6YnnL3G
   0JAKQeZCx6G3y3hxHMss5uB0/bXwUUYiNN8aCoiK60tnHJSfitRrB3uc2
   LfbUFT3yC7LZAEfAf8XjA/FsrWnMH6gW58LKQUrWk09ufLQnXgRVbL2AD
   MaPdIrzoOe02jPOtSXk2aw/1THiHUdYHeUtQQYaz1SW5oggZpgPLu2ACK
   Q==;
IronPort-SDR: bLiM0b/H4cbAqHEc40YCgeRvvahrLxGjvOxtdpwM57I6eD278uWfdKs3bmuQSt9Lnm6pV9LESO
 81AgpaFXefC0Y/Vvg2z2KtZBXF0jGBjMiTdHE/+F/pHL8zz4E/e8dAa/flaN5kWD3q30L6RMdA
 58lsEZaiVK0/CkOwn1bL1r0gWn5Cz2l17Dhu5inHQz4AVZfTVMoDLw6W1hCEbXZQGHF3HBEPQY
 IR3NX8MZMcrsCRqiTkeFqeIxl5trTXocCpO6iGFmhaUj9ERfLal52H+JgSGbfs5xovdgCS8xvA
 3qajJUj7y+buyXxv2kMhsGWb
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="62504098"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jul 2021 09:15:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 09:15:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Fri, 16 Jul 2021 09:15:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/6mH5SGgm+qCtll4e24vf+t7XN5WegXxnMxKi8dvsOk2dNBW75WBalCpm+oK/ZOCNwCrvmpLmxPqKFueEN0CcF4rDmdBob/BbH1fmuIKvs6bUwdupnRMnrrUqZsfEAuHW5pEFf2lzUn1Jb8YNf3uVcwZFXlvMktmpJpjgxvFILa/nEpQWvxiZ8IKJruqH0qD2bsRkNFqXrc5Q01JohHexsEiwXbPiXc3MM9RJUQm6xbLjjEeB+CBY8AyFQ23SKhGrRGYxOFJxtP8vwTZguSBP+DiaFj6lN7GdAwgBb4Jo2w/mq3R2EsIJw0/9kOPQFHmWKRnHD378M2gMAv5SKnAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjWsIykvHIPrxopSlVPRezJ3/QtPnZSlr9h562Y4uiM=;
 b=P3r+F+EokDpQKt009OxrT4excsJIU0cXOKELWk0+9s3PRodU3Sk7rLJ3lk0pMaL8QIpK/dzFa2uA01idBLWllwqp41a3jdwmtAMGLZpymGIgwqqmhQez3QeigDCGSGMYVtL8y+lAyz1iNcTAiwJekKw6PVYuSGoiisDwlJDx0ZQk2/rjtFjGWARY9dpAHDakhxOgROJ4AoV5O0WfGjEJK4SoYjKchrH21AvPitZmOOBUEQtAKKV4TUYYB++z2/axm6PJ5Si9P1XQeG7tvBrfojbDc5lORubqcabGFh/f6db7TfEaFyfQTXqPerShTYy7weqDp2yv64rJeNhWU6+JNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjWsIykvHIPrxopSlVPRezJ3/QtPnZSlr9h562Y4uiM=;
 b=AVSQ3P/0AeyMUFicMnhK/MDDlBqSwBGNG0cy0RXHlDw1nl1m9cUtoGK9Zf17QjJRKiw0Lfp/guXzM61MYpcvuA/vqZPECOm8wBMS1Vxjo7Pkky9CXPOkPjcnAs0wD9Dkf4SZMIfU9iMQF6sR2YLMuq8H2dVxK7pf/QvARBz7ogQ=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by CO1PR11MB4963.namprd11.prod.outlook.com (2603:10b6:303:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 16:15:25 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::58e9:43d8:74e1:f266]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::58e9:43d8:74e1:f266%5]) with mapi id 15.20.4331.026; Fri, 16 Jul 2021
 16:15:25 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <emil.velikov@collabora.com>
CC:     <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Eugen.Hristev@microchip.com>,
        <Codrin.Ciubotariu@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ARM: configs: at91: sama5: Use make savedefconfig and
 clean leftovers
Thread-Topic: [PATCH 1/2] ARM: configs: at91: sama5: Use make savedefconfig
 and clean leftovers
Thread-Index: AQHXel3IBp7N1hxkOkKs5S/TVk2sMQ==
Date:   Fri, 16 Jul 2021 16:15:25 +0000
Message-ID: <e424bff8-9130-b52f-1bdb-869576c3e6ac@microchip.com>
References: <20210716151447.833967-1-tudor.ambarus@microchip.com>
 <YPGs5qGih6R9DFWG@piout.net>
In-Reply-To: <YPGs5qGih6R9DFWG@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4098cb8b-2f17-4ebd-368e-08d94874eb99
x-ms-traffictypediagnostic: CO1PR11MB4963:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB4963338006CAE0ED312D81F9F0119@CO1PR11MB4963.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RMA9Xykm1V2W/KTadp701O1g+vV60Ef5Wo2kqb87rhaoxsikuTuSyLc8sbw8u5C0OQ+NprHHAJs770zglf7jIzX3PuAkB05BcpG0HuBGaIwWuygDlEImxYhYqHdU+kzXDaMonpfN2vpBMKvoQThpo7TtNsl1M84mJtiBDNsPFN/bPV6cSHyNaMusdkb883idTi1fViL+cVOAAlldLjdYmpwEBr+VyZeXLDPrRNMN/xBq/etZmfz6cP5+3U11+i1E6CmV61NqWlL5XPWqdUtOd4ShemA4x2zdh/lDe2kmYqmOiwYOlks+ROmTloJxb+C/NwDQqUS1J/1wBIZb+1Sz3GQP+J+wJfGuOGwWMQNEShnzKfiHXFrH79DQoW3VEkQoNFndJMf9caRUjJpiGtVpd83X3P0H6Gpi4Ewl7UdyCDlczb6GdLE9ktyJbISdtFxS/9TyZ4YUXWfQMcsEzraTvijOXSdeaZv2cVYNEUx+r+1Vau4D+kNQ9nXvNM+14dSMTO0Hjvdg4FGWfapZML6sSpDLBNy3bd745KtO1oReDEtJYZvg7gnIx99uQ+uMRF8/Zleq0mhhFkcWkOVhsMYr2UbcO4eKVFalGC7kxG6DeilbVBaH7d4L9uJnpMEwCHnmO5D7R8RbbUHmUCJj7Y+4Y3evcXjzi1Xa1MOxa/mVOEKGV4CEQyLHhVVD8oJ9g0d9qVfKQHL68YDb72LBBd3VYHMuD5K6qWSUf9sW9ukYnlyIVh2ud9z9u3y8Vt2T+4e0C6qOHgkrpDHJ7gadA26PaK1KMA72IeBmOXNyAdbcssE7VqU1kbUqogB42aiFCbBj97yGs6cuuuLRb0hfbG+uLIaTFWn+ALzbl9BTC0DwqRQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(366004)(39860400002)(5660300002)(8936002)(316002)(53546011)(31686004)(6486002)(6506007)(66556008)(8676002)(76116006)(91956017)(26005)(966005)(66446008)(186003)(66476007)(4326008)(66946007)(64756008)(31696002)(478600001)(122000001)(110136005)(54906003)(83380400001)(2616005)(2906002)(38100700002)(36756003)(71200400001)(86362001)(6512007)(38070700004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WklhaHRwdmE1M0piN0ZxZUJ6c1l4eElhaVRQMXBMbnFCRmgvMlZsejY0K0lN?=
 =?utf-8?B?NWJHTHhWWHl0RFVyT3RHeUpWVFFjekpHMmx3ekg1UkQ2eG82YjQrMnRvcC84?=
 =?utf-8?B?RnhNWVZPYVFqcXJnZmtPMTJ6Q3g2K0tWT0xSREt4YmM4ZlpkdTRWUUR4VGJx?=
 =?utf-8?B?MXFVMVpqbFlmOUFIaGlGcHBkRXoySFg4cE05aXF5ZnhVTEZvUlMzbXN2bFNE?=
 =?utf-8?B?TFBncnJndEZzbjdOK2cvSGZWUmtqL050WVdmNXhZOHlKY3RCdUh3cVlIVlpy?=
 =?utf-8?B?UGJMdWhycHJ1MjRDMTdIbTdGTFRhSS9JcEM5aVZCRXdGZlR1cU9UOUNkNEpw?=
 =?utf-8?B?L2UrK0ViSlN2M2pCOEhTdmlRdmNJbmlwZFRzNHMzSzdKNXF5RXNRRVIwOUtl?=
 =?utf-8?B?R2JKVUNrS1FFbmp4SEtzQ1ZXR2N1Z0dsMkM2bDN6by8za0hNWE1nSkpicHlH?=
 =?utf-8?B?MnpCYXUySjNGQklKL3JISGdZR2VrSzRJOExQYVJ3Qlg1dkUwdTZ1ZUcycFBs?=
 =?utf-8?B?RExqSFI1dDh2eHZQMkVQQWkzZE1wRWdoSWROMm42VW13dmJrcHJmLy8zNkVM?=
 =?utf-8?B?RE9qUkNocms5ZUg2dW85cDhldXdNUWhIaitLUit0emQrblAwV2JtL3plc3lh?=
 =?utf-8?B?QUl0S3Rtb0lhU202Rmc5M04zSmJGTDBvd2FjZ2w1WmZLR253ZzYxbmdyNUZy?=
 =?utf-8?B?ZnJpRFFrcGkvNGQrK2lEeVVMNThyNUwreDVPamlFVHRkWjA1YXlHSFJPUTd0?=
 =?utf-8?B?N3BvZzdPMjcxbmpSNWx4czIrZ2s4MGdlcHVGK1U3T2w5WTgrVHYvMHlQSUZ0?=
 =?utf-8?B?d0ZuNm93ZXM0NGlrQno1R2VBa21mOC9aZ0Z5VjNITUlQT205akxCcW5TdnY5?=
 =?utf-8?B?cHpkb25XMzJuMld5eVRDOVN6Mk9zWHFJK2t4N2ExRzdiVHRxM0RMZlZKYktR?=
 =?utf-8?B?OWpSMjVSWTdvYTFzWDE2RWJvS2phRzk4bXJuMVo4VS9Fd1psRFdGV1l4QThy?=
 =?utf-8?B?bEFPRWNaakE3VDNuVlNRL0ZCMXZzYUhZRFBmNy9OVnFJSDdkbUdRWHgyQWZY?=
 =?utf-8?B?ZWdVK3BzdkhpWE5WS3JFeGJHcDl5aW9sQ1NHbEttRXBNWFZTeVVOTkU4cVpD?=
 =?utf-8?B?dkRBNGlheTBBSmNMZkt4Nk9oeTFMTkkzTTExZ0ZQMXkrRVpaaWlwaUpqd1FR?=
 =?utf-8?B?cWdTWnlENXhkd3IyRDhWV01ESHd4Sll0ZzAxSnVzalk5dVNPTURYeFVQTEU5?=
 =?utf-8?B?UExENDcxTXhjT0FvZEJveG5HWGtFSEpZOEpFSnVydkZ6SlVQeVRVWEl6M3pT?=
 =?utf-8?B?REkwRGFoNzYvekFyNjNPMWlPQmJWWDBWVlhqaVJmMXAyS2VyQWxmKzZSNEc5?=
 =?utf-8?B?VFA3bFRMeFhQQWd0NHBCSk13ZTZuMW9aT1Y1L0J3eW03Sk9BZVNpQmQrNXlX?=
 =?utf-8?B?T2h6M2x6S1BNMndyQStTK1lPUG9rWVhSL3VDUkdtenZRcW1YdWcwSWRtRmZK?=
 =?utf-8?B?UFUwNjR4b0x5cVJQTCsreG92eitqc1pyaTBsckhZSjBoRU1Mam82MEo2Wkh3?=
 =?utf-8?B?V3hsNEt3OUhtQnpRTCtMaGxrVHlaMnBuTzdJTjN1NjAwRkpXZHFvM0JQYzY1?=
 =?utf-8?B?c3ZEMWdNaFFwOHlOTXorVFpESnhjUXkxRGlwT1htS1dXMVBBWVowT3B4UXZn?=
 =?utf-8?B?bDVoUlhGVEdXRW1QMncwS0Y4SmpGZTV4azhjeGpJVmZUMzJMQ1A1WTBwTGcr?=
 =?utf-8?Q?xUw23/XAPSOkJPAA7g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C220862AC48D24E9C200B20591379DC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4098cb8b-2f17-4ebd-368e-08d94874eb99
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 16:15:25.4613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h6sa4FuiFqVS5G+ejfsTg3ETzf5tXgwI+bZMvSJeTLWEoEqAih58JCVtA7MUc94upS3qM4AJhM2Mc2o34IYl6jPRvGWqHud/Zo6NzWNyjEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4963
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xNi8yMSA2OjU5IFBNLCBBbGV4YW5kcmUgQmVsbG9uaSB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxNi8wNy8yMDIxIDE4OjE0OjQ2KzAz
MDAsIFR1ZG9yIEFtYmFydXMgd3JvdGU6DQo+PiBFdmVuIHNpbmNlIHRoZSBhZGRpdGlvbiBDT05G
SUdfVklERU9fSEFOVFJPIHdhcyBzZXQgdG8gbiBiZWNhdXNlDQo+PiBpdCBkaWQgbm90IHJlc3Bl
Y3QgdGhlIGRlcGVuZGVuY3kgY2hhaW4uIEl0IGRvZXNuJ3QgcmVzcGVjdCBpdCBub3cNCj4+IGVp
dGhlciwgcmVtb3ZlIGl0Lg0KPj4NCj4gDQo+IFNob3VsZG4ndCB5b3UgcmF0aGVyIGVuc3VyZSBp
dCBpcyBlbmFibGVkIHNvIHdlIGdldCBpdCBmb3Igc2FtYTVkND8NCg0KQ09ORklHX1ZJREVPX0hB
TlRSTyBoYXMgdGhlIGZvbGxvd2luZyBkZXBlbmRlbmN5IGNoYWluOg0KRGVwZW5kcyBvbjogU1RB
R0lORyBbPXldICYmIFNUQUdJTkdfTUVESUEgWz15XSAmJiBNRURJQV9TVVBQT1JUIFs9eV0gJiYg
KEFSQ0hfTVhDIFs9bl0gfHwgQVJDSF9ST0NLQ0hJUCBbPW5dIHx8IENPTVBJTEVfVEVTVCBbPW5d
KSAmJiBWSURFT19ERVYgWz15XSAmJiBWSURFT19WNEwyIFs9eV0NCg0KTWF5YmUgYSBiZXR0ZXIg
Zml4IGlzIHRvIGFkZCBBUkNIX0FUOTEgaW4gdGhlIGxpc3Qgb2Ygc3VwcG9ydGVkIGFyY2hzLg0K
RW1pbCwgY2FuIHlvdSBzaGVkIHNvbWUgbGlnaHQgb24gdGhpcz8NCg0KDQo+IA0KPj4gRml4ZXM6
IGEwZTY4MzBjOTViNyAoIkFSTTogY29uZmlnczogYXQ5MTogc2FtYTU6IGVuYWJsZSB0aGUgSGFu
dHJvIEcxIGVuZ2luZSIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5h
bWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICBhcmNoL2FybS9jb25maWdzL3NhbWE1
X2RlZmNvbmZpZyB8IDEgLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2NvbmZpZ3Mvc2FtYTVfZGVmY29uZmlnIGIvYXJjaC9h
cm0vY29uZmlncy9zYW1hNV9kZWZjb25maWcNCj4+IGluZGV4IDE3ZGIzYjNlMmRkMy4uMWNjZjg0
MDkxZGQ3IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm0vY29uZmlncy9zYW1hNV9kZWZjb25maWcN
Cj4+ICsrKyBiL2FyY2gvYXJtL2NvbmZpZ3Mvc2FtYTVfZGVmY29uZmlnDQo+PiBAQCAtMjA3LDcg
KzIwNyw2IEBAIENPTkZJR19BVF9IRE1BQz15DQo+PiAgQ09ORklHX0FUX1hETUFDPXkNCj4+ICBD
T05GSUdfU1RBR0lORz15DQo+PiAgQ09ORklHX1NUQUdJTkdfTUVESUE9eQ0KPj4gLUNPTkZJR19W
SURFT19IQU5UUk89bQ0KPj4gICMgQ09ORklHX0lPTU1VX1NVUFBPUlQgaXMgbm90IHNldA0KPj4g
IENPTkZJR19JSU89eQ0KPj4gIENPTkZJR19BVDkxX0FEQz15DQo+PiAtLQ0KPj4gMi4yNS4xDQo+
Pg0KPiANCj4gLS0NCj4gQWxleGFuZHJlIEJlbGxvbmksIGNvLW93bmVyIGFuZCBDT08sIEJvb3Rs
aW4NCj4gRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZw0KPiBodHRwczovL2Jv
b3RsaW4uY29tDQo+IA0KDQo=
