Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B955E33ED09
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCQJag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:30:36 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:5976 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCQJaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615973424; x=1647509424;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5OGiP9m1lbd5FvGtspC9X4+CYQWay080MQa2EvkDtbY=;
  b=q81D9AepFVDSTk/euBiDs6qTbG/yUI+UybIEoSyOrjZguLGFp9h3n2sX
   ca3fDDFU6wg+GuBg8nHzUQvfnTcRA4foYUTBephANedvSdUHKms7txay0
   15XLerGarqtdkR+Io4gCUVDlUm1I+N2WNdb5eQKpcOBREVCKMliLKs4gL
   +JLjuV8VYD1juR0+LhqUAk0j90YRt8o32lYpiVWzZKiQSt9/TP8eSWBty
   TgxwFYshzSK7aP4qFC4P+4C0dQOKvKJ2qaBq/bOSCfTxD70eGM/+P9daS
   vo+3o3LRf4FxJhwlHBFZfxgXxLujJC3wx8kgiKTlu7++DFIJOxYuA03Qq
   Q==;
IronPort-SDR: auiPlRxz48VAdfE7XIxpu13HD2b0rQFhvfiNzVVeKwWQbhCgF52pSBKq9uwrVCx8zv588GI3nx
 9lDTvwGzy2owQaAklPFfBpbBHZMU0SWxe3PEQu7NVR3fWgO1WFiefG1ue6dwuAezafwwsbESU4
 bNJFZCMTMBOASAlDb9u2UsuqLbSHoAdMUsd8QBGRKJX4a6KMHJpe9IU25T0Tn/9Pk/MJyiNf55
 EbWUuPXOW/ZmSnZtROvvdgZyGVFw6mRSSjkM+5grsUrRv5LfXt0xyTXnRdx+9U7Z98nKtXqDkn
 J44=
X-IronPort-AV: E=Sophos;i="5.81,255,1610434800"; 
   d="scan'208";a="113554985"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Mar 2021 02:30:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 17 Mar 2021 02:30:24 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Wed, 17 Mar 2021 02:30:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjfp3ND561tI1hj1cjEIt7C9gPWQdzcKcbZl8sTD8d1baQjqCV8NOdSlE4lKQQz/oBQt2eKsvDzkkPwusPjeJHrGZdwHqdgqxo0Rou46ezZ+HYpbUIDvhn8mJGorTmcIv3lyVKnNfAVkrcltu15ukrIa8kqgT3xDAS3QmdZQFlnGxWI3LlIm1OSi/2a3EvQP4ac3ivIxhhv6C9Va6Ky88+K35VS9IOvZTv0+yeN1kw6wHeT4BttM2Idi8HYQeuTcOA0DZ7GUTcgpkXuSig8u8JBjv4pNhrJFnVVQs0hbM2cwJeQa8wQ7+/44XQHSWNjUIzNMckkC7WOgUOPt/xiraQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OGiP9m1lbd5FvGtspC9X4+CYQWay080MQa2EvkDtbY=;
 b=VmsjVZB8xmzK3sLA6PDnoIA2R5Ee2vUtv1NHLxbQGZL9mELPBqW/qtKI+OXMldW0s9xIK52YEBAmJ3kQ21Wj/YoUCMbto/35Zg+QqzCZ/K8mFvIvlTOkXDywjamPrY3boDLLCVyfx8E6LBjdfEUdN6jrLrqchEcLLuptQ9g0jm94fTdeaQP8gJg41xEeEawchbRzJ5hq3tObDQppRWOuqGPn60o9rDZdnJvhLYjI5INRiFCRsRIOqMzm0A09ys8cZMW+X5CEOlPxv4UfE7h6eTsCjGhLRN8IGn2HOareao2SfX7xvOU1+W7OAVU66EwZa7BsE/zNJOwPfRefhxy6/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OGiP9m1lbd5FvGtspC9X4+CYQWay080MQa2EvkDtbY=;
 b=IX77e50XQ0MClhp4kDQgxnNc0tX/LzsU/tmelOk/C3jsc5le35qMtY12CX3sTMdveCWpUNtk79wiexFnUrKUp+/7kNkVtN9JRdEvtd1FylmF7XU01raOQJwgDw+5R4M6NVdpn8CZclbMgQbfw6fQ+WkhjiMy+NzCJx4e12EZP0E=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3293.namprd11.prod.outlook.com (2603:10b6:805:be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Wed, 17 Mar
 2021 09:30:23 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::c9e8:9bf4:b08c:c30f]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::c9e8:9bf4:b08c:c30f%7]) with mapi id 15.20.3955.018; Wed, 17 Mar 2021
 09:30:23 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <vigneshr@ti.com>, <p.yadav@ti.com>,
        <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] mtd: spi-nor: Move Software Write Protection logic
 out of the core
Thread-Topic: [PATCH v2 4/5] mtd: spi-nor: Move Software Write Protection
 logic out of the core
Thread-Index: AQHXFLXahW+TwdBlzkur1VDkcdYBtg==
Date:   Wed, 17 Mar 2021 09:30:23 +0000
Message-ID: <fe28e8f9-a3a5-b445-e7fc-01c8743bacbe@microchip.com>
References: <20210306095002.22983-1-tudor.ambarus@microchip.com>
 <20210306095002.22983-5-tudor.ambarus@microchip.com>
 <963232a4-9100-ebca-927c-7f5a1e947fbe@ti.com>
 <9889bae0-8eba-7cbc-d9bb-04e038bd28c8@microchip.com>
 <6016b725-a779-1d2c-9884-099c58f53557@ti.com>
 <45d00a12-cb79-774e-f8e8-d65602629a90@microchip.com>
 <a9e1e18c034dfa185eeb5492acf2dff7@walle.cc>
In-Reply-To: <a9e1e18c034dfa185eeb5492acf2dff7@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 819f0cfb-10fe-4ab6-b959-08d8e9274a45
x-ms-traffictypediagnostic: SN6PR11MB3293:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3293AADD68864CC93E093F16F06A9@SN6PR11MB3293.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8/OitlzRzOlkpI9pM8DqPjhTUjUG2XKm2YzfKXdvSvoPW33eJ2B3qKrx2VHLrKiwVbhWhiYzQtyU/gFzLwzb6GHZxP0dMTgL6nGo6hgtB9cPtiVCJsL7W98fvJbiadp1iVE3m3X7nYhdPeHJC3dRkiCORCcRYxU6rHp2cgEZcuum2cJCaFia2WZai+fjWnwmMYdALvli3n9RJ14g+9r7PyM9aE3APL/fLqWIXGWJyyu3c9YM8A8cvVQC0dhaxE6v1bSTiWfBuXHCHVom1ErVM6XuktR21k3H0QSUqk5NjS2iZ+ZJz0i+XCpEScRKN/Kw1clRVaBaqNCUkNtgoJRkyXneaOeE3ZQsSsxvIcYjtS8WvD6IdBIB50ukJpK1upLez0CkF3n6/gXbXj398pah0a7XJJKC13u/uV5UiUDD9ljEh6GGP4f4TPbAlwv4INPshwGupPb3nWSlkU3yoC74E6zsg6sVQxw4jbo4o2ScKIgTmWGe2qh5e0aTvJgo7iVflt2KVfO2AQNuzssBQmDNFkW3c6PeUGk127t5cp7LI2WNyEwPu4Kj/jJEYrX0xzAh7nkZ3ObRrpr2ji0MM0akY/uiUY5AZhiN6RouHesRf3iYh/ZBScktpyt1OPswEsYbvZ/6Mz8f7hh3iFGUrLFVzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(346002)(376002)(396003)(76116006)(6916009)(31696002)(36756003)(6506007)(2906002)(316002)(66476007)(86362001)(6486002)(53546011)(31686004)(8936002)(5660300002)(83380400001)(54906003)(478600001)(64756008)(8676002)(91956017)(71200400001)(6512007)(26005)(66556008)(186003)(66446008)(4326008)(66946007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YzVNaGlPQ2JNWFAyR0tJVFdBTnR3TVJVWEo5MWZwa2JjWm04SzJCUzlua2Fh?=
 =?utf-8?B?RjBoMzlaRG1MdTR5bEdheng3YktGM2RvVXZjeEtpOExGUDNBbEhjUEtoSWh5?=
 =?utf-8?B?SEFPbXkwcEtUNEU1WWFkRUN4RW53OHdWMlFnYllMaERVdU5MK2UwaE5vM0s3?=
 =?utf-8?B?aTZkRlZyWkZUQTg3aVN6TjdBNVlVNEpDT0ZMMFZLZWJjTGJYNzEzUlpoZWt5?=
 =?utf-8?B?dDViY2RuR0MyQTBYMjBJUUdxZEl0cEhXR0tPdnZLTlR4M1hxaFRXaVkwMW5V?=
 =?utf-8?B?SUZwK0YwTTQ4VGJHQWR1b1ZzcnZiSW9Ra2tBNHg2YzQwSFlWV0tsa00zRkI2?=
 =?utf-8?B?NFlTRmt4dXhsNWhIbkZvNDhYM01IclNKWUlXMkxnNU83aEsxZTdJT0I2Y2Rl?=
 =?utf-8?B?aFYvY21ncFhNYTRUenROWWRQZ0JJU09qYlk1TGVJT050a1hPWXJiZTNiQkpC?=
 =?utf-8?B?Vk5mVWl0QVJYUnVHNXpnOEt3TTJJMU5FSzFnbzhqWlFYdjFodDZ3SVB0YmhR?=
 =?utf-8?B?a1U5S2xCeFdOVGwxV1o5cUQ4T0s2TGhqd3BkaVhYWUpDbS80MWJ3OHB2M1Ji?=
 =?utf-8?B?eWpFcHV3NFZIU1hCNzU5bUZIZkdZOU5FVUY0YVRVY1ZnS3dyT0RNYzZVb2hJ?=
 =?utf-8?B?bU13MVJKbnk1VFNlRmUzSktGQjcwLzN5YVVhdm5Bd3Y0bUV4TGd5UHArazk1?=
 =?utf-8?B?NzVvNWE3Y3lwODRWTWdjV3lLSTJHcnM4VTRUS0dYUE13L0c1V3NUWmgwaXJm?=
 =?utf-8?B?K21mbHNJODJmMGt5NnpwYnZnY1ZiM0pnUEpweTRKaFVHdXh4UmZFWk1KZVJN?=
 =?utf-8?B?bXZPRURyRm9iZFV5QUNXYVhoaEVyUlo3VVB2eGJjTjVLWDhEMFFuamlsSUFL?=
 =?utf-8?B?WnpNY1dHc3BKeHllSFBKcXR3eWppVWo2L2wzT094TC9rV3Z1Q3JibEpIRlhR?=
 =?utf-8?B?VTJqOFgwaHMvcHZyb0hBV3dZUFZEMStCWEtvUUJ1eDhpcXp0MUg2V0RBQ3dW?=
 =?utf-8?B?TFBCamU3VitNQTVoalhhU29yVVU0Vy9tS2hIR1pKK1VOd21JNU1SSE1NMWpN?=
 =?utf-8?B?MmY2clBoRnlwOVNpQk4zSldYYWxOZXlGcUVTQWtRWFhGZFgyVFNHbTJaUGMz?=
 =?utf-8?B?YUQrYklUUFAxZzdYUXNEV1lIZjFNNkZBSVQrWmJmM2c1MGZVSGw4OVZCTGkx?=
 =?utf-8?B?V05yODR6KzUxSHBDcWY5Zy9ONDQxbjBGV1B5aVFwK3pYTDZRM0xKOHptQ0Vo?=
 =?utf-8?B?MzQyR2Zsby9iRHlMYjlFamdWUm8ydTROUGNzMm01OXVsUFcyc1VoNktwYjlh?=
 =?utf-8?B?UmpXUVFlbU5rS2djRmxNNld0bStsZWFFMkEwQ3NVSXpRaDhyUU8yeFdNVURa?=
 =?utf-8?B?RGc3WTM4R054QlRuOFJqMUlQMk1IOHpYQ21hdmlDdWR5NVoyemErRFp3S2xK?=
 =?utf-8?B?SWVVcHAxQy9pT1R2T0t5ZSs3eWgxU1V1cnZweTU3bGhVb1crM0Jtb2paUWYw?=
 =?utf-8?B?VFVaVmp0L2djLzNLYkFlU0pOdFlHZnAvZVNjTUJHY1ZFMDgvbFJEbWExVGRR?=
 =?utf-8?B?TlhDblNPSFRiQUJYWmcrSU9YVUVPRW0yOGR3NmNTNGxnaFRySFRDUFI1dVpC?=
 =?utf-8?B?b0IyMlpJYVJvYXRtZnJTc3RFa2lSRUFtWVp5bjVzTmM3K1RCcngyaDJHbTVT?=
 =?utf-8?B?ODA4aFprQVJHSnNTc3RJcE50cFRjdXZ2SDlGVHgwODU2bjV4TnhSUi84R0xh?=
 =?utf-8?Q?spvlheI6wwnkfd3FiY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <792D5B2A4704004E9A42967CC858B459@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819f0cfb-10fe-4ab6-b959-08d8e9274a45
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 09:30:23.0680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ihjlHG9dBlwo9xe4KExmYt0LBE93cTjqeamX+ABmBtKKf9uWDwb3vnEBaxDe9QprXVSPEoyOnNwPcPlzb1O54UrIWM1brkGxJVQFrvk/SA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3293
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xNy8yMSAxMDoyMSBBTSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIxLTAzLTE3IDA3OjA5LCBzY2hyaWVi
IFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbToNCj4+IE9uIDMvMTUvMjEgODoyMyBBTSwgVmln
bmVzaCBSYWdoYXZlbmRyYSB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNr
IGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93DQo+Pj4gdGhlIGNvbnRl
bnQgaXMgc2FmZQ0KPj4+DQo+Pj4gT24gMy85LzIxIDEyOjU4IFBNLCBUdWRvci5BbWJhcnVzQG1p
Y3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4+IE9uIDMvOC8yMSA3OjI4IFBNLCBWaWduZXNoIFJhZ2hh
dmVuZHJhIHdyb3RlOg0KPj4+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4+Pj4+IGtub3cgdGhlIGNvbnRlbnQgaXMg
c2FmZQ0KPj4+Pj4NCj4+Pj4+IE9uIDMvNi8yMSAzOjIwIFBNLCBUdWRvciBBbWJhcnVzIHdyb3Rl
Og0KPj4+Pj4+IEl0IG1ha2VzIHRoZSBjb3JlIGZpbGUgYSBiaXQgc21hbGxlciBhbmQgcHJvdmlk
ZXMgYmV0dGVyIHNlcGFyYXRpb24NCj4+Pj4+PiBiZXR3ZWVuIHRoZSBTb2Z0d2FyZSBXcml0ZSBQ
cm90ZWN0aW9uIGZlYXR1cmVzIGFuZCB0aGUgY29yZSBsb2dpYy4NCj4+Pj4+PiBBbGwgdGhlIG5l
eHQgZ2VuZXJpYyBzb2Z0d2FyZSB3cml0ZSBwcm90ZWN0aW9uIGZlYXR1cmVzIChlLmcuDQo+Pj4+
Pj4gSW5kaXZpZHVhbA0KPj4+Pj4+IEJsb2NrIFByb3RlY3Rpb24pIHdpbGwgcmVzaWRlIGluIHN3
cC5jLg0KPj4+Pj4+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3Iu
YW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+IMKgZHJpdmVycy9tdGQv
c3BpLW5vci9NYWtlZmlsZSB8wqDCoCAyICstDQo+Pj4+Pj4gwqBkcml2ZXJzL210ZC9zcGktbm9y
L2NvcmUuY8KgwqAgfCA0MDcNCj4+Pj4+PiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+Pj4+Pj4gwqBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaMKgwqAgfMKgwqAgNCArDQo+
Pj4+Pj4gwqBkcml2ZXJzL210ZC9zcGktbm9yL3N3cC5jwqDCoMKgIHwgNDE5DQo+Pj4+Pj4gKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+Pj4+DQo+Pj4+PiBIbW1tLCBuYW1l
IHN3cC5jIGRvZXMgbm90IHNlZW0gaW50dWl0aXZlIHRvIG1lLiBIb3cgYWJvdXQgZXhwYW5kaW5n
DQo+Pj4+PiBpdCBhDQo+Pj4+PiBiaXQ6DQo+Pj4+Pg0KPj4+Pj4gc29mdC13ci1wcm90ZWN0LmMg
b3Igc29mdHdhcmUtd3JpdGUtcHJvdGVjdC5jID8NCj4+DQo+PiBIYXZpbmcgaW4gbWluZCB0aGF0
IHdlIGhhdmUgdGhlIFNXUCBjb25maWdzLCBJIHRoaW5rIEkgcHJlZmVyIHN3cC5jLg0KPj4gQnV0
IGxldCdzIHNlZSB3aGF0IG1ham9yaXR5IHRoaW5rcywgd2UnbGwgZG8gYXMgbWFqb3JpdHkgcHJl
ZmVycy4NCj4+IE1pY2hhZWwsIFByYXR5dXNoPw0KPiANCj4gSXQncyBqdXN0IGFuIGludGVybmFs
IG5hbWUsIHRodXMgYXMgbG9uZyBhcyBpdCByZW1vdGVseSBtYWtlcyBzZW5zZSwNCj4gSSdtIGZp
bmUuIEl0J3MganVzdCBhIG1hdHRlciBvZiB0YXN0ZSwgaXNuJ3QgaXQ/DQoNClN1cmUsIGl0J3Mg
YSBtYXR0ZXIgb2YgcHJlZmVyZW5jZS4gV2hhdCdzIHlvdXJzPw0KDQo+IA0KPiBCdXQgaGVyZSdz
IG9uZSB0ZWNobmljYWwgcmVhc29uIHRoYXQgd291bGQgYm90aGVyIG1lIG1vcmU6IG5hbWUNCj4g
Y2xhc2hlcyBiZXR3ZWVuIHRoZSBjb3JlIG1vZHVsZXM6IGNvcmUsIHNmZHAsIG90cCwgc3dwIGFu
ZCB0aGUNCj4gdmVuZG9yIG5hbWVzLiBJdCBpcyB2ZXJ5IHVubGlrZWx5LCBidXQgdGhlcmUgaXMg
YSBub24temVybyBjaGFuY2UgOykNCj4gDQoNCldlIGNhbiBtb3ZlIGFsbCBtYW51ZmFjdHVyZXJz
IHRvIGEgbWFudWZhY3R1cmVycy8gZm9sZGVyLiBFYWNoIG1hbnVmYWN0dXJlcg0KZHJpdmVyIHdp
bGwgaGF2ZSB0byAjaW5jbHVkZSAiLi4vY29yZS5oIiwgYWJvdXQgd2hhdCBJIGhhdmUgc29tZSBt
aXhlZA0KZmVlbGluZ3MuDQo=
