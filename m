Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915953BA98A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 18:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhGCQpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 12:45:10 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:54015 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhGCQpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 12:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1625330555; x=1656866555;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zZwJZx3Y87UZMEamhRrQsMJ8sEGJwGEnInC1h0yG/Nw=;
  b=1QVdE3EnRPdGvHzz/OZnFnMRF7hNj+qoMt+wAG7DKeT1C2I7r0clfAZU
   rhb3RCK5Gl59QFVG6fHDHuIoI1xuMmf+DKtzuWyHS5ntDIt+vkcW/3KzH
   r8BUFdpktb2T0bHbncWHA01Qj6vp3BjleApaletbg2jLroAk/WpWDkGhf
   DWopX4mWc2mQmsMJ9IhyD8RnaGTQLnRcNKu7urJ/EBIiJ3brrCcqhco8W
   lLBaPanJFQD9lsnTJgnlfrF18voWXIZRszotpb8I+JOVoA6QRguez65vk
   YN2YcES1c4TqNkV8qARDWsBN0MrRx5NMxgH89bmUOJ8ND0A4fvyS5Busl
   A==;
IronPort-SDR: dQwM3YSUWaeupELenPaMSXAbmh9Xw5lvScf0YxF8WzslPdLqcN1j172yOVXavsvQ78w117xFzg
 zbEk5PPs2PWwY1m4SbwpI31jEF1oSPho1zp8z6Wt81EGgpx5dJiRn3TgKBXULKT+O2AE+oakLW
 mIjQEDB3Yi4F8EnwBWqwhASllGAyfPvZlFYr8/2X+AjWLMcLyc5Q2CLxFG587sg8RzPxkK68PZ
 0IYjYPBk9RPRVu5UCs7W2TBH7tEXEa/WdICNInFggBVhsvKqYEpqLSRyVqOWA79mDJf69yfgws
 kJ4=
X-IronPort-AV: E=Sophos;i="5.83,322,1616482800"; 
   d="scan'208";a="61060121"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2021 09:42:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 3 Jul 2021 09:42:33 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Sat, 3 Jul 2021 09:42:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQAPLgnvO2liRqzk2rJoBJGCQAiRFPizv30SX8vVzwRZqrDz+EJxhKGIZNClcYAm9QJuoD9gGpGIOx9qjaPF1hm2FIyvbtO0jixCK+wYXNxZZYLB37DIleJYheeHNUspZefwpadQYrDRu63o9WIR9bkt3J5dq0c+2+m5kpUNewd5dbHFKBa1W5hYNAYYBdoF27vjJmiiAiWEWeFcwMe5fZvRf3QkH6Nx8X9/33Jyv7fFMMQhwu9vh870bcrkAdXbnWPDNbNCf0cpE8v9gfuG4mbVlYV0BMBIcuWfUeUPeiA+Crg2SkaASMmmLB2Zu2QuGxJiSfuXjGySwInEZch01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZwJZx3Y87UZMEamhRrQsMJ8sEGJwGEnInC1h0yG/Nw=;
 b=ofAlNVN+Sm/2L+JIEIV9sLvZ+oZ1IRlHNjA9F5+d9CgvdvGrJltt3McIRpfaTLZ8+W4spMG6gMKfPWlnF+ZTBCOYjnP53qFNt4gZ58zbgtiHvpCVXqwgj39khJpgzXqCqIRq+ZLwEy0++ouOw8u5aMSeScLsUCZLX9sFmPCpqED8RAkGoTJA/MqFexJMNkxOfBKgeCdbDVD1yBNvd+SVgD1ODFzL3DW9NwLbC3M2ymeEt+OkSkA0Or+FyZwwVcGiJIZ98k4mX9JJySh07eHJgKZ3cAqntEOFSoYbZNUG9aLAL93EyvYT6PW0q24aG59gDZ5Fm/ws0UAfqII7U/CDtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZwJZx3Y87UZMEamhRrQsMJ8sEGJwGEnInC1h0yG/Nw=;
 b=efD//sk10k+yIea5sPa0atP8ZZ3Sq41cRb7sR0lTBEpN5MSUnvKKdCSuiAcQBByf/krx2N5N1V9TopdYnvtajY3T2bEiDntIIq70Cw1NmaMyKcyM7QYQh9z8FFQVzvWNGcSU//pVkhxiRJ9d++3TCH66CEdhhORGBNf1of59Yro=
Received: from PH0PR11MB4869.namprd11.prod.outlook.com (2603:10b6:510:41::8)
 by PH0PR11MB4885.namprd11.prod.outlook.com (2603:10b6:510:35::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.30; Sat, 3 Jul
 2021 16:42:30 +0000
Received: from PH0PR11MB4869.namprd11.prod.outlook.com
 ([fe80::5067:83f9:991d:2ab4]) by PH0PR11MB4869.namprd11.prod.outlook.com
 ([fe80::5067:83f9:991d:2ab4%8]) with mapi id 15.20.4287.024; Sat, 3 Jul 2021
 16:42:30 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux@roeck-us.net>
Subject: Re: [PATCH] mtd: core: handle flashes without OTP gracefully
Thread-Topic: [PATCH] mtd: core: handle flashes without OTP gracefully
Thread-Index: AQHXb/GoAw4bbVO2W0KjeZydMqxv/w==
Date:   Sat, 3 Jul 2021 16:42:30 +0000
Message-ID: <8da3d84e-dfbf-2030-98b4-148362d22f52@microchip.com>
References: <20210702093841.32307-1-michael@walle.cc>
 <9bb2acac-aeb8-d2b2-8df0-9acfd972ec5d@microchip.com>
 <9F46D75C-D00D-4577-A337-7411049EC7D9@walle.cc>
In-Reply-To: <9F46D75C-D00D-4577-A337-7411049EC7D9@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57684907-114d-46d6-0e99-08d93e418cca
x-ms-traffictypediagnostic: PH0PR11MB4885:
x-microsoft-antispam-prvs: <PH0PR11MB4885275BA8A7CD55C04B8F13F01E9@PH0PR11MB4885.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RfsLPJsnXb1NWT23iWMCNr8zcmt+oFdKi2OfvQUks80VAod4WvlgJZfpxlrCSDGLZPQ9eZUfbTUiwGaGlTxjMzBQtoJdUZybzmHy/IjVaVZzPDTsD7I0A1hUlf9XdC1ZbNKnZbT+t72hmhrwJGTyj7vauBdRTdQOV++idJF553qQDJPzjyIpWgal0cJOL8XmjrAULP0GktAi1PimxqLgOwNay/C7oZcGJmN3iRnW+81CtBKWjSDKro4Kx9ZD6Vz41g6vhkSkXvbaEIqW62KzxUYjJDTmLwXHdB8/44jQUirioKvIWnu9e91RN1/AD+CuYcrN0Ru2InP84mCYHk8TuF+vff7bIv1Sbg7qLGlp7ktSc2RsK0xZzdldxCIVEdWIUuWlM/rIa5UfDhp0UxXiig5CXhsHFKHP8e/zcm50i+oj9YGX009O1gOTjeGcLmV84CM52rqHSCeb9ypuC/St+/qEwZAeiz2Y6EveuF/FJyWrwrhqj2aoLUuQSkwYB1Z/9R2NErKSEAV2GQl6uZPo9WHmC2Elm5D5AAD5sSOx66OElPPUiBFZDeOBMdEyQ6rEETLeKfsPEcrpi2X+lNtpHs0r5Nk4S3Ws5b1hnBsg267hbovzcirbwy6421B5r6INo1agWwr6KEWVNVpHdxaPrRa66/bB0LIsxrL15XoAh0K9cad3lJUVNca3sbRwaINPG+vO8TbZc8htdWZs0gglqfQsZVLOuNqX8EGdo6Fl6y3nd0YVo1oVaK4SPBfbN2/95D3TjXUXYd0sLB65hFudPq7RUB172pHGfZunEZAHskklOBcH2Za9FLRQTyDSWQIC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(366004)(39850400004)(396003)(966005)(4326008)(83380400001)(2616005)(71200400001)(8676002)(31686004)(186003)(53546011)(5660300002)(6486002)(36756003)(6506007)(2906002)(110136005)(6512007)(54906003)(91956017)(76116006)(316002)(8936002)(31696002)(478600001)(26005)(66446008)(66946007)(122000001)(38100700002)(66556008)(66476007)(64756008)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0IxZjVZM3JPWVR2ZHlXK25hdVQwWnNma214ckZ5Ylk2N2p4R0I4RHRPM3Rl?=
 =?utf-8?B?dFE0NHYrVnp3VzNEODJVUm1LNk9KMEppb3FXclVQUG91aytjbVQ1TTZXN2Ju?=
 =?utf-8?B?Qmt6NGZTSkxOR09HV2ZUS0xZejFpSG5JRzBhMmpnb1l0OGpaRlBVYy9PbStE?=
 =?utf-8?B?MExVdllVSHlQQmhtSCtvVW9sS2FmZGNGZTBCSjRZc3dNcjVBTjNpeTVDb1hZ?=
 =?utf-8?B?QmNKdTNQUEozTHhzbGNvOFFUR0luV0tKUmN6NmYzQVVOYzRYd2ZzeGJqSkRJ?=
 =?utf-8?B?LzJWTUFUUmxpUEt1Z0tjYjZESGpwaWJzS1JkeEllNHpNS0ZXNWZidkpHS0RP?=
 =?utf-8?B?K3VHV256Qk5CVU1xRENOTlh4S05uQXM5UDkySVhQZW41cWs0bTFDUjFCYW00?=
 =?utf-8?B?OEpHTFN0TUZaZEZDd2pBaFppM0ZGbVNJOTZtV3ZVU3NhSW80RkdkMHNnb2RR?=
 =?utf-8?B?cnFVcnJudEUzVFBMQXZTb3BGWk9pcktXMHcxVDVMM0ZoQytHamVZaU51YjQy?=
 =?utf-8?B?dHpLb1VSVUJRcjN2L2ZEY3V1dmk3bG9sUmt6REFISjJnTTVEWC9YK0tIQ2tR?=
 =?utf-8?B?ZHBVbVFWdi9CMFJKVDlJZldscGRzZkhhNWllMmZ4elJlL2g1RitOQVlQczNr?=
 =?utf-8?B?a2N0RS9wTUNIaUNVZVRjSldiajRvSi9BZ1pZcnhtSzZmNHE3ZFhqYjV4WHhT?=
 =?utf-8?B?bTBvUUs0ZmlPTmZWZTd1SGdWRFV0R01IZzBvcTQzMzE5NytURnNUQXJLaThE?=
 =?utf-8?B?dk54WXp6NmZoT2ZRYXZta1NiVzkzWHo3cE80RXVJZ1JuUTh6VTgwYVRsbnlI?=
 =?utf-8?B?K1hKd2d6elY1U1NFbmo3eDdGS3ZSRHlQOGFQVU1MbTBUQzdFazhDaXNmOTFG?=
 =?utf-8?B?T3VRRnprMElpdTlZV2U4aFd0OWY3R0Y2UXd3VDZhOVU0Q0RES3dvc2J4a3R4?=
 =?utf-8?B?OFVHSWJXNHpLNG40S0RIZWhGekRSNDdENURlTE8zc0w3K1IxQTJJVjVGZnBu?=
 =?utf-8?B?ZzdvYldKSXhGOGxiK1FHc0UxNWl3djErdWlBbFZTMDBxcU9NNWRMQ1RuNXpt?=
 =?utf-8?B?Mlk3T0tjVWdOUmMxOTBoWXFZTWNuNFVmLzRMMU56ZnhLWHJEUGZxWDFPR21N?=
 =?utf-8?B?Y2tFSEc2RjhKZGM4UkkxR1RjUGlTemFScXZCdDBQKytOU0k5R1RKM2lheFJC?=
 =?utf-8?B?c1hwdERQci9WSTAzL25HejVST013MjZVbWlBSmRDOHI0bmMzTWNCWFc3ZUk1?=
 =?utf-8?B?TFRpMStZK2RBT1hRU0swMEY0Q0tGdjlMNm14TzRWaEV3QmJKRlZJSTNFVzJa?=
 =?utf-8?B?SG9lb1VsaDF4eklzTzZuMWxidlM1NjVEeFRlRGlVYlRweWZaYmF0L2NNQWlJ?=
 =?utf-8?B?RVFZWnZ3OW5LN0l5R2g4TXFRYnF2TGtPSzJxdzRDUXFMRjA5TDFpQlA3enNO?=
 =?utf-8?B?dHM1bmJqdnFGUjhZYTRiT1QycUN2dVhDb3RnTE1DL3dXK1d3SEM4ZHliUEVq?=
 =?utf-8?B?NWdLdnNHZ0c0L2wvT0NidDF3am05MXBVWXVVbGwvUU1vU21BTUd5ajhQV2Vk?=
 =?utf-8?B?L1VmanhvaURsYXVSNVVjazIzWXh0b24vYzF4Zks3NHlwMWZaUVBOTmh5aGFW?=
 =?utf-8?B?b3M3M2doaTZsVW95MTZLNTJsNEUyekNSU0tFK0tvWDRjVHM3UnF0YjE5b0Y0?=
 =?utf-8?B?Sk80RjlPODFzYmV6b0d6aFhXVWNXTENRbVVXdjRSU3FZWkUrclVmYXU2N3hw?=
 =?utf-8?Q?sRUt4d7WIyLfJndM5E=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <17B07EA39CB175499A751327194E04B3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57684907-114d-46d6-0e99-08d93e418cca
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2021 16:42:30.4498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o21y8+06SmiKmnO+/G9PkEiJHe9RXZH2HemrsODZ/d8SMNDsbWAEhIXxcEmhpD97g9413aaVCQ87hYn6A0tR9OFj0mawHh2x3MR9doaOAho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4885
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8zLzIxIDc6MDggUE0sIE1pY2hhZWwgV2FsbGUgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQW0gMy4gSnVsaSAyMDIxIDExOjU2OjE0IE1FU1og
c2NocmllYiBUdWRvci5BbWJhcnVzQG1pY3JvY2hpcC5jb206DQo+PiBPbiA3LzIvMjEgMTI6Mzgg
UE0sIE1pY2hhZWwgV2FsbGUgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4+IGtub3cgdGhlIGNvbnRl
bnQgaXMgc2FmZQ0KPj4+DQo+Pj4gVGhlcmUgYXJlIGZsYXNoIGRyaXZlcnMgd2hpY2ggcmVnaXN0
ZXJzIHRoZSBPVFAgY2FsbGJhY2tzIGFsdGhvdWdoDQo+PiB0aGUNCj4+PiBmbGFzaCBkb2Vzbid0
IHN1cHBvcnQgT1RQIHJlZ2lvbnMgYW5kIHJldHVybiAtRU5PREFUQSBmb3IgdGhlc2UNCj4+PiBj
YWxsYmFja3MgaWYgdGhlcmUgaXMgbm8gT1RQLiBJZiB0aGlzIGhhcHBlbnMsIHRoZSBwcm9iZSBv
ZiB0aGUgd2hvbGUNCj4+DQo+PiB3aHkgZG8gdGhleSByZWdpc3RlciB0aGUgT1RQIGNhbGxiYWNr
IGlmIHRoZXkgZG9uJ3Qgc3VwcG9ydCBPVFA/DQo+IA0KPiBJIGRvbid0IGtub3cuIEJ1dCBJIGNl
cnRhaW5seSB3b24ndCB0b3VjaCB0aGF0IGNvZGUgOnANCg0Kd2h5PyA6RA0KDQo+IA0KPiANCj4+
PiBmbGFzaCB3aWxsIGZhaWwuIEZpeCBpdCBieSBoYW5kbGluZyB0aGUgRU5PREFUQSByZXR1cm4g
Y29kZSBhbmQgc2tpcA0KPj4+IHRoZSBPVFAgcmVnaW9uIG52bWVtIHNldHVwLg0KPj4+DQo+Pj4g
Rml4ZXM6IDRiMzYxY2ZhODYyNCAoIm10ZDogY29yZTogYWRkIE9UUCBudm1lbSBwcm92aWRlciBz
dXBwb3J0IikNCj4+PiBSZXBvcnRlZC1ieTogR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMu
bmV0Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+
DQo+Pj4gLS0tDQo+Pj4gIGRyaXZlcnMvbXRkL210ZGNvcmUuYyB8IDEwICsrKysrKysrLS0NCj4+
PiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+Pg0K
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9tdGRjb3JlLmMgYi9kcml2ZXJzL210ZC9tdGRj
b3JlLmMNCj4+PiBpbmRleCBiNWNjZDMwMzc3ODguLjY4ODFkMTQyM2RkNiAxMDA2NDQNCj4+PiAt
LS0gYS9kcml2ZXJzL210ZC9tdGRjb3JlLmMNCj4+PiArKysgYi9kcml2ZXJzL210ZC9tdGRjb3Jl
LmMNCj4+PiBAQCAtODgwLDcgKzg4MCwxMCBAQCBzdGF0aWMgaW50IG10ZF9vdHBfbnZtZW1fYWRk
KHN0cnVjdCBtdGRfaW5mbw0KPj4gKm10ZCkNCj4+Pg0KPj4+ICAgICAgICAgaWYgKG10ZC0+X2dl
dF91c2VyX3Byb3RfaW5mbyAmJiBtdGQtPl9yZWFkX3VzZXJfcHJvdF9yZWcpIHsNCj4+PiAgICAg
ICAgICAgICAgICAgc2l6ZSA9IG10ZF9vdHBfc2l6ZShtdGQsIHRydWUpOw0KPj4+IC0gICAgICAg
ICAgICAgICBpZiAoc2l6ZSA8IDApDQo+Pj4gKyAgICAgICAgICAgICAgIC8qIEVOT0RBVEEgbWVh
bnMgdGhlcmUgaXMgbm8gT1RQIHJlZ2lvbiAqLw0KPj4+ICsgICAgICAgICAgICAgICBpZiAoc2l6
ZSA9PSAtRU5PREFUQSkNCj4+DQo+PiBJZiBubyBPVFAgZGF0YSwgbWF5YmUgaXQncyBtb3JlIGFw
cHJvcHJpYXRlIGZvciB0aGUgY2xpZW50cyB0byBqdXN0DQo+PiByZXR1cm4gYSByZXRsZW4gb2Yg
MC4NCj4gDQo+IHlvdSBtZWFuIGFscmVhZHkgY2hlY2tpbmcgRU5PREFUQSBpbiBtdGRfb3RwX3Np
emUoKSBhbmQgcmV0dXJuIDAuIFRoYXQgd291bGQgYWxzbyBtYWtlIHRoZSBodW5rIGJlbG93IHVu
bmVjZXNzYXJ5LiBJJ2xsIGNoYW5nZSBpdC4NCg0KSSd2ZSB0aG91Z2h0IGFib3V0Og0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tdGQvY2hpcHMvY2ZpX2NtZHNldF8wMDAxLmMgYi9kcml2ZXJzL210
ZC9jaGlwcy9jZmlfY21kc2V0XzAwMDEuYw0KaW5kZXggNTRmOTJkMDlkOWNmLi45NDE5YjMzZDcy
MzggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL210ZC9jaGlwcy9jZmlfY21kc2V0XzAwMDEuYw0KKysr
IGIvZHJpdmVycy9tdGQvY2hpcHMvY2ZpX2NtZHNldF8wMDAxLmMNCkBAIC0yMzE0LDcgKzIzMTQs
NyBAQCBzdGF0aWMgaW50IGNmaV9pbnRlbGV4dF9vdHBfd2FsayhzdHJ1Y3QgbXRkX2luZm8gKm10
ZCwgbG9mZl90IGZyb20sIHNpemVfdCBsZW4sDQogDQogICAgICAgIC8qIENoZWNrIHRoYXQgd2Ug
YWN0dWFsbHkgaGF2ZSBzb21lIE9UUCByZWdpc3RlcnMgKi8NCiAgICAgICAgaWYgKCFleHRwIHx8
ICEoZXh0cC0+RmVhdHVyZVN1cHBvcnQgJiA2NCkgfHwgIWV4dHAtPk51bVByb3RlY3Rpb25GaWVs
ZHMpDQotICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9EQVRBOw0KKyAgICAgICAgICAgICAgIHJl
dHVybiAwOw0KDQo+IA0KPiAtbWljaGFlbA0KPiANCj4+DQo+Pg0KPj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHNpemUgPSAwOw0KPj4+ICsgICAgICAgICAgICAgICBlbHNlIGlmIChzaXplIDwg
MCkNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gc2l6ZTsNCj4+Pg0KPj4+ICAg
ICAgICAgICAgICAgICBpZiAoc2l6ZSA+IDApIHsNCj4+PiBAQCAtODk2LDcgKzg5OSwxMCBAQCBz
dGF0aWMgaW50IG10ZF9vdHBfbnZtZW1fYWRkKHN0cnVjdCBtdGRfaW5mbw0KPj4gKm10ZCkNCj4+
Pg0KPj4+ICAgICAgICAgaWYgKG10ZC0+X2dldF9mYWN0X3Byb3RfaW5mbyAmJiBtdGQtPl9yZWFk
X2ZhY3RfcHJvdF9yZWcpIHsNCj4+PiAgICAgICAgICAgICAgICAgc2l6ZSA9IG10ZF9vdHBfc2l6
ZShtdGQsIGZhbHNlKTsNCj4+PiAtICAgICAgICAgICAgICAgaWYgKHNpemUgPCAwKSB7DQo+Pj4g
KyAgICAgICAgICAgICAgIC8qIEVOT0RBVEEgbWVhbnMgdGhlcmUgaXMgbm8gT1RQIHJlZ2lvbiAq
Lw0KPj4+ICsgICAgICAgICAgICAgICBpZiAoc2l6ZSA9PSAtRU5PREFUQSkgew0KPj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgIHNpemUgPSAwOw0KPj4+ICsgICAgICAgICAgICAgICB9IGVsc2Ug
aWYgKHNpemUgPCAwKSB7DQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgZXJyID0gc2l6ZTsN
Cj4+PiAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycjsNCj4+PiAgICAgICAgICAgICAg
ICAgfQ0KPj4+IC0tDQo+Pj4gMi4yMC4xDQo+Pj4NCj4+Pg0KPj4+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPj4+IExpbnV4IE1URCBkaXNj
dXNzaW9uIG1haWxpbmcgbGlzdA0KPj4+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbXRkLw0KPj4+DQo+IA0KDQo=
