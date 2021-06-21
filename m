Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EDC3AE1CC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 05:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFUDNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 23:13:24 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:65339 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhFUDNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 23:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624245070; x=1655781070;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gY7ZIUxcjvZFdEaa+W3rXccwafIiLamgOL8Arq0d1ec=;
  b=naEzPToS4qmkqDBNHZJPZMGjnGJ7vxXQFha4cUjUH4gOsTP/gA4RFfT6
   RWVF6qtwe6xJm88jZ3xhlXm4187KmQRlRxTn+cggMRroXHDuazMj6kFIK
   l6Esti8/VktuOBYYLaRirL8A7pJicw3qZA/6hfMnT7pHxS03OW0KgLloa
   aG7wjDdQiIZMcz9Q+kPoWB78Ehu2GqIbGrCX68qx/boi5qDYNMf9fs2o/
   Cp+9GBU1l2rxmijk8KD3h336pohzGMgpne+pi5lWCicTHc8CELGl3klqW
   sAMbQEhqmoAgL8mlg9NHjZTNSVAyhfHHvel4bp/a48SiUPlxmYRzBJVL7
   g==;
IronPort-SDR: kYkncknL+IM7UPFZsQfT2XIRAyuAbewTRUE7IpzKam2+7VuPWvRPaFm4GFtJ84GzNsA7pTw/M5
 FU6EUZtuWSV0BoJ+EG3CuB4ykWxGafLRV+300hpaVRKSrfiaJRuhKCppBNrB0U3DsHHa46YrNJ
 PgqTw0MrmtaicqpGePFe4t9ZfcY6VWhday5tgj/vqXGSUmjiAnJnjJiZbVhb9npd4vDEStdUMd
 uUy+oZxnUpo9d6kh2ZQIwaYrMttScSlKvzVgbD2tBiQ4X3Ka2jPZeE6x8xLmcU69AiuOZGwlz0
 PrY=
X-IronPort-AV: E=Sophos;i="5.83,288,1616428800"; 
   d="scan'208";a="171700089"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2021 11:11:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUh4BXov2Gdwwv+h8aRBsvpXzviGQTuNnkovoyaZS5ZVxffKu7T9QJ/8i9FIGvl8JChaK+3nPRSn56enpG6Q/K0lQgDrGUQjxj9VY5jIPgJRQav/oLkYc3VTGwcWGekELKul4/c8gvZdrh0NTqL6pSzeM+OEyAHswC//VFDIl3NZ7qunpeCafIbxytMhnB/oHpIrzQQaxSj5yskGeamb8Bv1Ik6goRp9sd2zaCKMAxV4J01q63vLErDoaOEaO7+0mm2WEJPBEKL+5KZyI+FRzQmkVr4DPbHVUdLKl6eq4uR1xnplEvaXInK4mPzQKTUigbKkFPZrzBc4sxWaUrCtVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gY7ZIUxcjvZFdEaa+W3rXccwafIiLamgOL8Arq0d1ec=;
 b=J1Dq4odmuR8g1MvLmlOYAS/JA2uKoNI0J7y50sZS7HFQ4lDp8M5BWGsW5mWudyoMLJ62j0RlRmhleP7Mm+4qkg0lLkq7KoHsKNQ9fdoMsErKUovcbbz5cvMZb7nRTq/v1cRcTe6gsr4ZXGX8TBg6VVWTvQDXn81gmjyka4/g3CA28pkoNRjQ+t76yExhMGRjD4VaaJvCpBG4J05NJt/tV21a75XONuYtvF1qL+GaaTwECIsXDOJ3/4mBfZZq3EBf6JMd3sWFJSCJ748bSunyWl4WI6ro+LIIzsrKm/0pGw5+eZrYosY3s8oqtrM0iQVZI1qr8cjs36ftLAjFlokAEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gY7ZIUxcjvZFdEaa+W3rXccwafIiLamgOL8Arq0d1ec=;
 b=UudmRyg7yl45gBW4sSI90OU2i5D3rA6crA7YO/DnzcvCnCjogO0RTpEareGDBaLGqtkkp0koH8cDkTtmfOBNf/8a+XQMoaEqnGQaX95XAD975MfW5GuovpcE7KWlfxExXnmtr+7ojNl0XBa8bM5o894/WWQn0txvLceSm5dnXJg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3960.namprd04.prod.outlook.com (2603:10b6:a02:ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Mon, 21 Jun
 2021 03:11:06 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 03:11:06 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     =?gb2312?B?1ty0q7jf?= <zhouchuangao@vivo.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/nvme/host: Use kobj_to_dev() API
Thread-Topic: [PATCH] drivers/nvme/host: Use kobj_to_dev() API
Thread-Index: AQHXZksTanjejgc+JUW2ejpk+dQsXw==
Date:   Mon, 21 Jun 2021 03:11:05 +0000
Message-ID: <BYAPR04MB4965F9291CC991093FD485F7860A9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210618141817.GA18781@lst.de>
 <ABYAKQDNDmr9B7YYOVwFFKqU.3.1624078894067.Hmail.zhouchuangao@vivo.com>
 <20210620172754.GB1137891@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8509251-e8f0-4cb4-21f6-08d9346235a1
x-ms-traffictypediagnostic: BYAPR04MB3960:
x-microsoft-antispam-prvs: <BYAPR04MB3960FC18F3FA0FBA2A66C4D8860A9@BYAPR04MB3960.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pgJsz9cfJxey1UdgL8ClQuIS9LkuSpJgJXTa1CL6JnRESDlDcGbb97SU90k10/X2mcaRD4uDUh98+QhNDwCvuq8TEfRJ4HpSgPJK9yG8FZ0QMHCP64r4an5Q24TWQnCmoIZfXINdNqMKR1X2m6ZfW86BoDA2I7WwPXID2H89qcnLRz5ymBESx6bSWO6o1boKUigmpn4n+hCD7/w2e7os73OSQyd/JJ4kxs1u07qoS8N7mMf0sKoaotwF+e39x+G6sqOBIIvvIuEu4N/5KDF6eI8orvW01KKafmzAPbdt4LpBIrdYtH+Od8Xb/ecAR7tKyu500m3ILefNPBadN9wrmSr1pMmOLY4byrLQANa9KhiFRjzo7pYcH4LS66l26jwlTFFnugVL/CCxi3vk2PV2mBr34uDTDTcWQzgL3YZLRHBLahn83apl/Mhr8sIJZziG3xWnGSe5wuQHDDt+p8UdJdBi31KcFD6bu3Qmqcoi5A8ojW99YxZdNoZ/77ookVFyywR4CweV0CcGUXoR+yKdQ0FgTBhdhRqMDL4CCOR0FrGthEDVhqjrM1b7Ed1YHkPq3U/iNZygq9Q5DH3+jKrIRbqcMHwRpc/+G+HxumyGrKfb2ktuqRaJ6CkJPalVqu2+G1HJS/z9IgrjJvTeuFsI9RINgQaFi9RKoMub0mivLNlEuXOGBZV8XYJygdCfnY2FWz3jF3mgLWHLfEH9UH0sj1+/aO9hj+gGIMDBf6y3nM4kc++iRbHDM8RfIP4/KgPc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(8936002)(5660300002)(9686003)(186003)(122000001)(966005)(55016002)(6916009)(478600001)(86362001)(53546011)(316002)(26005)(8676002)(6506007)(71200400001)(38100700002)(83380400001)(4326008)(52536014)(76116006)(66946007)(33656002)(66476007)(66556008)(2906002)(64756008)(7696005)(54906003)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?YmI3VGZNczFBQ1YrSFBsNGZVVHBPZEJmQlJ4MWVjK0l2UVdtN1p5U1ZJL0hS?=
 =?gb2312?B?SWs5RnRaNVg3Uk56K0hNY2xFWDRGWE1YS0U0VXVObWEvb2Q5dXQ0cG1GVHpB?=
 =?gb2312?B?TjUvMUlEZ0hQOHNjYTRRUmZ0UXFkQzdFTjNnZlkyazYyK3VMbldEazhEOTk0?=
 =?gb2312?B?QXJmUkpqQkxHN29YRzhLamNwdUViYzlid3BBelIwSTVQR2g0TFVodDQ0L2RD?=
 =?gb2312?B?YXVNZmF6UkU0U0I4bktZa29paFFFaEdwUFpBL2hxZDBDU0Q2dFJjd0YxMXBW?=
 =?gb2312?B?dm0yTjZmMjNUUmtJTWFEK2RJZFJrbE00WW1jZjFKWWdKUWN4dkRvSGwxcDVs?=
 =?gb2312?B?Wnd4ZTFETjUxY3JHTytON0xybFE0NjJwenNaVWYzWlNSSVBveVZlempQVzB0?=
 =?gb2312?B?d1NwanRFU1UvKzEvNlkzWUdtdjlkSE1GN0d4MEtJUkNWYjNuR0tEWm90R1dB?=
 =?gb2312?B?OS8zZUNOV1BlWGtieWx2RmFrMG0zbnI4d1JGek9DY3ZxQmZzc2xvQ1RMTWNp?=
 =?gb2312?B?cm1qTi9BM3BoVnMreCtKTm9BOUNHUmU5eHVwdmpzWTFWeUFSZ1pvRlkwSlBB?=
 =?gb2312?B?bTI1NWlSVmRxaTdDUDZrS0p0U2dmeTYzY28xUjU5bFVKb2VmZmV6bFAyVkxz?=
 =?gb2312?B?eURUZmhlNnFnSFhvZlhOVjZEQ0RsdHVzdjgySThqdEhiMSttb3RpOTNKclpo?=
 =?gb2312?B?MGFJVHZQZE5EU1hzTG9GcmlqM0crM2ZKaDR6ZXpjZ2ROT1hJbTJZcmRIOVhq?=
 =?gb2312?B?NXZWMC9ETm1pcUNmUWFxK0F1T01xMWwvWkd6ME5zMExZSlRjNU1KUzJ6UmI0?=
 =?gb2312?B?YW1mL09JekNlL1RZWUVxcHhPOVRUMzBhMW4vNmtKUWhob0lBd0hCaG5leUta?=
 =?gb2312?B?L3hsMFRQamUzMjlVTlN5ZjVQUWI0M0VmcmRSNHBIcGxxdGR5UFQxVUZKNlNH?=
 =?gb2312?B?L2xROC8zeSthVnhSbjVYc0M1ZFhvbDVnSmwzUWhCSlc1bzhBcDJZd2FhYUFv?=
 =?gb2312?B?VVR3MVRuV2h1UTJlaFVXMUVseENNTit5MUljNEswZ245S283cVdtTzM3TUwr?=
 =?gb2312?B?MVJVNXZORVdOWGZndGgxMnNqNjQvMmZyWnk4d2lsU1Q2MXZmdUtYSmVFb2x0?=
 =?gb2312?B?K1FlbXYzZHBtUThVOTNQV0luSkFoMFJyRHI0ZmZwaDArUDhaMUt1TnVSTmRs?=
 =?gb2312?B?eGM4UU43T0RSVzdEQThnY1Z1QXI4VlZMQU8wUEo0aHJtUUlHRlZIRFgvSnYz?=
 =?gb2312?B?OElhYzhTTlp5RVVEbjVzU1c5OUxhQmY4Vkh6RmhwdXh0OGp6ZTN3S0NvR2lk?=
 =?gb2312?B?cmlSaGJTeWIxUWhWWlFVajZtaHZzY1EwcCtlUDRYVitRdVJtYllFVStBek11?=
 =?gb2312?B?Umk0MS9JcXhyMUdNbldBTFhncmh6WHJQS1NLdHNUNWJvQncwd0E5UjJQZjM0?=
 =?gb2312?B?RnBSbkNwNTJYUnE4UlN4K3dlRllDN21HWEVNY1BQN3liOGlpZ3hoWWFGQXJG?=
 =?gb2312?B?a2crUEtqaVFRN0FiZm8zM1g1eEptYm1iMWlNRVk3MHZxUlkwdy9IRllIU3N2?=
 =?gb2312?B?bjZDT0t4d1dBV0c1aXhHeVc5cHdZZFR2QlRON3VtTXlacEpBWGQ1NWdpTDdQ?=
 =?gb2312?B?L2tWTUJZYnp6bFlzdFZ4TUp2Z1hHNG9qbXkwSCtINFY5TnVWNitubWEyUTRQ?=
 =?gb2312?B?U0ViZ1hNdG1tK1pFdmdxYjFCU1JuL05lQXNwWnBIRm9SbFRFQUNiUldONUN6?=
 =?gb2312?Q?L4rIZ3wLoYPGrGrDlP+ztjdPzkJSG6ous73sMX3?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8509251-e8f0-4cb4-21f6-08d9346235a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 03:11:05.9768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VWsnfmu8w56gsVTrrmZAOTgbyIBxuUXy1fV04UT7Fho3gZjMWKNgeNmnOejdH63Ys9LrVCuZXTqjwCV7PUVVq/kbGqy4XSFRndedjAQEKg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3960
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

S2VpdGgsCgpPbiA2LzIwLzIxIDEwOjM0LCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBTYXQsIEp1
biAxOSwgMjAyMSBhdCAwMTowMTozNFBNICswODAwLCDW3LSruN8gd3JvdGU6Cj4+PiBPbiBGcmks
IEp1biAxOCwgMjAyMSBhdCAwNzoxMDo1OEFNIC0wNzAwLCB6aG91Y2h1YW5nYW8gd3JvdGU6Cj4+
Pj4gVXNlIGtvYmpfdG9fZGV2KCkgQVBJIGluc3RlYWQgb2YgY29udGFpbmVyX29mKCkuCj4+PiBX
aHk/ICBUaGF0IGp1c3QgbWFrZXMgdGhlIGNvZGUgaGFyZGVyIHRvIHJlYWQuCj4+IEluIG15IG9w
aW5pb24sIHRoZSBrb2JqX3RvX2RldigpIGludGVyZmFjZSBpcyBwcm92aWRlZCBieSB0aGUga2Vy
bmVsIHNvIHRoYXQKPj4gd2UgY2FuIGdldCBkZXZpY2UgYmFzZWQgb24ga29iaiB3aXRob3V0IGhh
dmluZyB0byBwYXNzIG1vcmUgcGFyYW1ldGVycy4KPj4gSSB0aGluayBpdCdzIGVhc2llciB0byB1
c2UuCj4gVGhpcyBzYW1lIHBhdGNoIGhhcyBiZWVuIHByb3Bvc2VkIGFuZCByZWplY3RlZCBudW1l
cm91cyB0aW1lcy4gRG8gd2UKPiBuZWVkIHRvIHBsYWNlIGEgY29tbWVudCBpbiB0aGUgY29kZSB0
byBwcmV2ZW50IGZ1dHVyZSByZXF1ZXN0cz8KPgo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L3BpcGVybWFpbC9saW51eC1udm1lLzIwMjEtTWFyY2gvMDIzMzE2Lmh0bWwKPiBodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtbnZtZS8yMDIxLUZlYnJ1YXJ5LzAyMzA2
MC5odG1sCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LW52bWUv
MjAyMC1TZXB0ZW1iZXIvMDE5NDYyLmh0bWwKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCj4gTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKPiBMaW51eC1u
dm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUKPgoKSnVzdCBzZW50IGEgcGF0Y2ggd2l0aCB5b3VyIHN1
Z2dlc3RlZC1ieSBzZWUgaWYgdGhhdCBpcyB1c2VmdWwuCgoK
