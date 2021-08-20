Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EDF3F2D1E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 15:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhHTN3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 09:29:31 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:2114 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhHTN3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 09:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629466133; x=1661002133;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/RcuyvYtC/wdWIlnHdgzkNVQecyiFabRK/9zWfad//0=;
  b=i0bzQHdUQE5v+I60CRkp93g0zvLR7qx4pwh6GGfK8hvad1OLqOA5SQGJ
   HVIFGKqH3q9dXKDvhD5aQxcliaD3HN+ZOCqBajWlO041BLJupzWrwGt3O
   4gPwJ3iXZdK8x0vGKndkwpbyUCoDMVfi3mMPRVDAASOEnQfb2U+s/gNgJ
   fhhoCTYjqFy/nlhUCrICfuxxRrmX6DsgP8/c5h+wlqYQnRuL6sDNZpt3J
   jfTrYGb/eFdr7P8Bi8FcTHUEajbIOB8GbxJcmocHpC9xAWCtuaZDH3uF5
   pT+ETuOeoub8yhyipccXCZsSjaAXRjMqM8+BBFunIeY2BjydPx2AcwlTW
   A==;
IronPort-SDR: gQz0umw0oQurBWtHS9K5BWvi3u/l37kvVDvTLKaCdA/pkiIMnU9LO5Y5JASj5cfiMjWH58axmt
 NNkYkV4sQTk7IgzHKTl+w4sggxCkXi+SbLbk9c+8E2HeqkgHm6v/uJRVr5ylIDYecfLJSinjv6
 rItXAbaf2WAtJFnKY1HNKAxdxGXvyXixX5dRDfWiatqNU37kCgd1Qh+ml5KPgH4wsTVOnUPlYj
 jLk+e+c++2RQGIWFjHNMIkHRoe5FMyNJu8vhb4c6FA3BEFkomS+Wj2JLYOZbQk9RtLitf20PDs
 TQrDWDuUvcRdm81Kil5OFwlx
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="133027826"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2021 06:28:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 20 Aug 2021 06:28:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Fri, 20 Aug 2021 06:28:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtKmj25sHggEsy+zSPBmfK5gz2g1KCaFOyVzU6ATVfsj4cZy5BWeg3JKW7Lmt6dF37X/1MkRV+aQztwPdLLasRJ4gbv52qFQORZfQPB2ISJcncGC8edozdh2swPNgO8ZeOAkTuOCkkm9coEBcjCMV/eq1NdaymeUtdbbFQvHdAxmtdih451l4OK0nevpAvmooD1YnRWckm0g2Yu6UbSZhImSKoK6vlg0dQW8VSm8eII4q6Hcowp3vKxGW83LDHNPo7slLa1y8TIMCDihc3fTZY3iQPjQhzz9O8m7ShUxfce+jTGd8CAKZo7DBwEWyZ78az05V1UtjOq3DSxfC89FIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RcuyvYtC/wdWIlnHdgzkNVQecyiFabRK/9zWfad//0=;
 b=Txj06o9dLF+1/jPDN3f0qR+1vqLx5cxHcfNfgmUkfSYNwvNcae/yj/AIpoJNNSMxQYg0EojC16PZKS521c52Oaxc3x/Uf+lBHkCYqrYcZHADy2EH2ITd7DCK+CJi+J9/SFMwH36y5C2upwPVz/eQDluBYTTvj6ltr+WFM1woAaiw9pmWL8wB3ltPNba44gi4fa4L4cYQ6qgjjvRTGx9uobBHNfI2KBnUATiDmi+eCk6W8MwbmnHiClVxu/Do63NlhT9pxhZz6QxabqN2JVyjekoFvUHcnxmCYtQ9Mw0yBVYayrCpvWHbRwBwt4AUs0xkKdUj/mR7jQWdzrx2aAZgGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RcuyvYtC/wdWIlnHdgzkNVQecyiFabRK/9zWfad//0=;
 b=ScaQNJoQKsou74fTv2M4KIq27vVRp0eV5SkPrQkjU2jHgsYXg4RCiZ9EXPbYZ8BX0f4Yyec6Tj7hS44sNh2E+pRfBTJ6B+haLaRtzo/0Og1jPpOcHz1pV/4VhTqvg3j3lSUAEZ01EiLq2BN/exaYoWEFM3X/l2zh6+768gEwudc=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.18; Fri, 20 Aug
 2021 13:28:48 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::c884:8fdc:abbf:161d]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::c884:8fdc:abbf:161d%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 13:28:48 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <krzysztof.kozlowski@canonical.com>, <p.yadav@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <atish.patra@wdc.com>, <sagar.kadam@sifive.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 1/5] dt-bindings: mtd: jedec,spi-nor: document
 issi,is25wp256
Thread-Topic: [PATCH 1/5] dt-bindings: mtd: jedec,spi-nor: document
 issi,is25wp256
Thread-Index: AQHXlcdNnytF2NaqukWbODBsWxdUNg==
Date:   Fri, 20 Aug 2021 13:28:48 +0000
Message-ID: <ae4c58fe-0af5-3f1d-cc16-27b78772cbb5@microchip.com>
References: <20210819165908.135591-1-krzysztof.kozlowski@canonical.com>
 <20210819172852.b26mybrdr33wso62@ti.com>
 <5bff5a0c-48e5-3721-5595-836ce0562c6f@canonical.com>
In-Reply-To: <5bff5a0c-48e5-3721-5595-836ce0562c6f@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38ba1272-4c51-4eb2-c26b-08d963de7133
x-ms-traffictypediagnostic: CO1PR11MB5154:
x-microsoft-antispam-prvs: <CO1PR11MB5154A6166EFC07CE71030CB7F0C19@CO1PR11MB5154.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KYz8fRay1Qnw7I0XAAIbDpdNNVYr2cRtvYnZvpnhC7xvzMPbKvLB15rPHwBRjedhBAv0RwGJMeoyvrliDiCI4mTbYlbEe+gLKJTiOgXmzFV/Km2GQCj1LnLNKEMS6q7dQWJNnYzI6Bs1KyPL0/MDAR8/9dwja1mHLl8TyW7I5x2jSMtbpIrUs7Xi0ltFTovSTzSsX2mkJn1yfT7bNbxLW5c4aJyrzI41ESvmAyIhhMWwrRQnamm/7wtJbkCDWwF6pMFWgtuOqRez0rss79h0i+3z9xvG/XaYHifxLykW85iPAHAlUZdGNDXUOBc1fB8GNqz89fjUTVFpFxS3QTTeRo4rFXemEtGSrvC2TL0L+ptO5slc5EgGFWjr8gerS2niwN4UtYKmSaVYse6G0LzOwp2mS8VBsyZXXc3hb6Ec1LoOMyC6V7WN4nGG0SPLm5RZksy8LqydHA9K79py5AKrsm0WC30QKjRIi/0y5VqAHRRcD1yRs64h/2qMWw8zGqjg+Q9wjJn7d7iYrVuRaAVaJuB/tWZReBXTDVr6qUHR+1eU56BUnrDrZ5tfcGal9nd8dh7IYkEND/RUjklW/sn7obSZaHXpP4xPXBD7deDgx/tCbLcXM4SOEqIqztYIrmkOFCg4bi2AOYwdNF/TrtUi0qKkDBWiHi4c/WJIkjNlvKqDV8XAXLgNLlkbN1WHix8GE/zeF45a9bhuxM7p5C1HdeutuHM2SjK/8lPF0fmA8Moao3tmiB1G0R1fpHgdHfCRz0UzGt2Hf8kzhPYawQnYQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(36756003)(91956017)(6486002)(76116006)(2616005)(31696002)(8676002)(8936002)(26005)(4326008)(110136005)(2906002)(53546011)(54906003)(6512007)(66476007)(38070700005)(5660300002)(71200400001)(186003)(31686004)(6506007)(86362001)(66446008)(64756008)(66556008)(38100700002)(316002)(508600001)(7416002)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHJ0TTZsOWozdHYrVVZIT0h3WGZEeDE4UVIyOFNPTXM2OEhvdmdmZ2dxK05h?=
 =?utf-8?B?dC9TRy9SN1R5dVZnUzkvL08zMDlWUUkzWVBxUUJQNWp0TDVUVGYvNGN3UTdT?=
 =?utf-8?B?eUdUbVB5ZG9HTDhiVS9EVUtEOXdncUl0VlkvUUVLZ3lFdGwwZVBpb25MMGRu?=
 =?utf-8?B?eFk0OTAzQUZ2bTF2VE5Vd3FFZmZxTG1lNjdaRnRkbGxHYWcwZnozb3N5dVVn?=
 =?utf-8?B?dEJJZERZZ1A0YjdHZmt2R3lKektJMXEwTGVNaERuUG1GYk8zL05mdnRlVnZD?=
 =?utf-8?B?QnhGeEMycE9waVFEeFJWVUtRdFI3dFZiQUtOM3BnbjdlczBFRUVSamNrb3FW?=
 =?utf-8?B?aFdkaGI1Qyt2R25zWmoydjZkb0Vzc1R3Yy81a0Z5WkhDUm9wT1JRMk8yWDlH?=
 =?utf-8?B?N0ZSWkh1M2JvVlRZKzNVVkNGamxncnNHWStiaE1BU0hzOEY2RFIxcTNPeVFL?=
 =?utf-8?B?ZEFlUGYvZnpZZklHd1UrNUY0d2hjVVRuVmpFa0ZnRnJhSjNNNzlYVU11YUpN?=
 =?utf-8?B?VVVwZFJTVGJiYW9tZmEwRW5MM3NmMlI3TnFrWmJUOGVKVEpGSjVrcWlKWjJS?=
 =?utf-8?B?aGJjK3QrZ3BPUndiZDl2ZEVKWmQwZjB1UnhKMDFlS2UxazFDSXN3TFFWc3p3?=
 =?utf-8?B?RGhEUDkrNThRVUdrQmFtdkJwd1RTWTdkMm5RU0NMWXdhQ0RqMFRIZ2Y0Vjcv?=
 =?utf-8?B?SVVOd3FvWmt6eDJIUkVtSVhIL2M5UWhqSm80Qi9ZUVV5QkdrT0lvRGtadk5Q?=
 =?utf-8?B?WHA1Q3h3aDZvcU1ObnYzYkxwWk04QWtVLzBNdDNCNEIvS0plVVBIT2hublg3?=
 =?utf-8?B?a3VuUjZTZlpiZUV3ZzVraVlSR1BxR0d0ZlROZUY1YU40NDZNY014QlBhUW56?=
 =?utf-8?B?TTExUzEzZjBGOFhvY3BmMkZVeC9udWVENDJhTmg2TDBFekJ4RTExMTJqMzRp?=
 =?utf-8?B?Ung4K0RnTlU2UHQrbnMxbGtsVHlkZDZQT3Avc2wvZlc5NkxoRE5Lc3VtUHNI?=
 =?utf-8?B?YUtJK05tTDlqWXVqb0pQVHpnOG9DN29nY2hXZkRxT2liZFZ4SEtxQzF0ZDFB?=
 =?utf-8?B?TXlMUjQvL0EwRU1MUjZDT3ErK3VUTEFJcDJzRXkxalpXQ3E4Sy9Uem1HTU1Z?=
 =?utf-8?B?MTJNV3V2c3U3Q3hrNzZkV2tDUGkvWW5mVUtpVlZ5b2xvcktFeE40RTdKYjFz?=
 =?utf-8?B?S2hiSzBWVmxzWlZIZDBrak54M3B0aTlqcW0vRVFCL0pvc0dmMWlUWGdWQTRm?=
 =?utf-8?B?aGpjWlp0MThUdzRDUE5qeHFVb2JPc2hEM0dZTVFSR21DQ2w4RE1SNmhBc3hv?=
 =?utf-8?B?aWhYQ0dQdXJsRktRTVAxRkFJUTBwamorRklydHdUMTRCQ1Fuam5RRzh0cDRH?=
 =?utf-8?B?a2lldW05SDJYRXlQN0IyQk9Ja3lLc0c0ZTZYcGJCSW9paXZZQ1I2bDlxU1BQ?=
 =?utf-8?B?M21SdW5FMENqNGZsRDBoek5WRGpKSTMxUlRWSmdNdlhMRE1QK0N3K2tsT2NM?=
 =?utf-8?B?TEI2ZmY1d1paR0lUcmdtM1J4TStrMTBKK1hnWnBEbWJDSHdKUUlQWkRXc09J?=
 =?utf-8?B?R3EvN1BKNmxNQnoyREk4Z3NDSFJwSU56aWNUVitacm5NWUdzdFdGdG1BRmhJ?=
 =?utf-8?B?QkdJZy9GZHpNNmt2UFRnOHFSWmd6SlpsclFwWmxlV0NkV0FpN2ppTFpEUjZT?=
 =?utf-8?B?RDRuM3UyTUhwNEU4ZU9aU2RPZkFuSlcyOW1IREg1ZGlXS3FLQnc0K25tR3Uw?=
 =?utf-8?Q?kQOEzXTXe7t6WkKxec=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4E6803FF4F8284FBBA0CF45ECB04B95@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ba1272-4c51-4eb2-c26b-08d963de7133
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 13:28:48.0920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MqNX7erjRjJwcDyZoKBhd3Ge27uYNxKRABAZ/2k7habxWCVy12X+kTAVSljAgzFoILIEqByeHwxTrgd/62TTGh30zMnGNok1SOMNOq+7vlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5154
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xOS8yMSA4OjM2IFBNLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDE5LzA4LzIwMjEgMTk6MjgsIFBy
YXR5dXNoIFlhZGF2IHdyb3RlOg0KPj4gKyBUdWRvciAoeW91IHNob3VsZCBiZSBsaXN0ZWQgYXMg
YSBtYWludGFpbmVyIGZvciB0aGlzIGZpbGUgSU1PKQ0KPj4NCj4+IE9uIDE5LzA4LzIxIDA2OjU5
UE0sIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+Pj4gRG9jdW1lbnQgYmluZGluZ3MgZm9y
IHRoZSBpc3NpLGlzMjV3cDI1NiBTUEkgTk9SIGZsYXNoLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1i
eTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBjYW5vbmljYWwuY29t
Pg0KPj4+IC0tLQ0KPj4+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL2pl
ZGVjLHNwaS1ub3IueWFtbCB8IDEgKw0KPj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbXRkL2plZGVjLHNwaS1ub3IueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9tdGQvamVkZWMsc3BpLW5vci55YW1sDQo+Pj4gaW5kZXggZWQ1OTBkN2M2ZTM3Li4wZGI2
NGFjN2RjMzMgMTAwNjQ0DQo+Pj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL210ZC9qZWRlYyxzcGktbm9yLnlhbWwNCj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbXRkL2plZGVjLHNwaS1ub3IueWFtbA0KPj4+IEBAIC0zMyw2ICszMyw3
IEBAIHByb3BlcnRpZXM6DQo+Pj4gICAgICAgIC0gaXRlbXM6DQo+Pj4gICAgICAgICAgICAtIGVu
dW06DQo+Pj4gICAgICAgICAgICAgICAgLSBpc3NpLGlzMjVscDAxNmQNCj4+PiArICAgICAgICAg
ICAgICAtIGlzc2ksaXMyNXdwMjU2DQo+Pg0KPj4gSSBkb24ndCB0aGluayB3ZSB3YW50IHRvIGFk
ZCBhbnkgbmV3IGZsYXNoIHNwZWNpZmljIGNvbXBhdGlibGVzLiBXaHkgaXMNCj4+ICJqZWRlYyxz
cGktbm9yIiBub3QgZW5vdWdoIGZvciB5b3U/DQo+IA0KPiBJdCdzIGZpbmUgZm9yIG1lLiBJIGhh
ZCBpbXByZXNzaW9uIHRoYXQgc3BlY2lmaWMgY29tcGF0aWJsZXMgYXJlIHN0aWxsDQo+IHByZWZl
cnJlZCBhbmQgb25lIG9mIGJvYXJkcyBpcyB1c2luZyB0aGlzIG9uZS4gVGhlIG90aGVyIHdheSBp
cyB0bw0KPiByZW1vdmUgdGhpcyBjb21wYXRpYmxlIGZyb20gdGhlIGJvYXJkIERUUy4NCj4gDQoN
ClByYXR5dXNoIGlzIHJpZ2h0LCB3ZSBwcmVmZXIgdG8gYmluZCBqdXN0IHRvIHRoZSBnZW5lcmlj
ICJqZWRlYyxzcGktbm9yIg0KY29tcGF0aWJsZSB3aGVuZXZlciBwb3NzaWJsZS4NCg0KQ2hlZXJz
LA0KdGENCg==
