Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42CB346153
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhCWOTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:19:36 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:46559 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbhCWOSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1616509118; x=1648045118;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U973vbGC3deU+/ldbSPQR/xQWMPleNfAhh6Z5pvCrWk=;
  b=m4rRnnT3HPeOnWrzh5Y8Aqib3rNEgIAKq7ADPni+VeC97STtr8VGOexK
   CuutJvCkupWHkOK2x2v4FZRdQWHPpTF4l9i5EtVSklFX0v5iS1PIUk0ax
   fhDpFbPOy+FDKTjYCn9TW8YcB6ayRWOCL6SIW+iU3xZreA2mz8psHw2fD
   QqFJuPjQ6gncEGoK+Dleee44UoldY6MelXtM3wdaDmO9/nJEddn/NGWkV
   76bpZPgz+/dgyPZQtvmn3e8bb6i/z7aPTED7KbXaYFA7ZKR6Wrkybef86
   7weRU0qlqbZeFiP9kH0yYgj+Dso0pAv90t9x2qTLWKRDMqI9CF21llcwC
   Q==;
IronPort-SDR: /45/7aYxQStwxA+kbtI0IgWyL1RccwD0wjssSp41iw14nKJMSTVeZ6V6soy3XwsyO/aggTNoGH
 cXwWIMuBisV0LURSzyqArCJ96IvR2eE3omzjwZpUG0+0IMSpGkKnaxWxEkIuD+OBOkCLR+hTMQ
 nGDeKnTg/GPqGiaItKZGiTBioNKBtPJVOTKs3vTY8ki/2F4GTuJGd+D5ApO4yXNxGsqlfaSP8c
 YbaNFCrTdN/WRJsRm4vBIZM4cTvsbZcB4Q7Q/keCGoNymngFXuTlGDJQ65qJMfG+OS29CDPKTO
 wQo=
X-IronPort-AV: E=Sophos;i="5.81,271,1610434800"; 
   d="scan'208";a="111022729"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Mar 2021 07:18:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 23 Mar 2021 07:18:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Tue, 23 Mar 2021 07:18:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhL29JwqYAdFRBadaogGJU8hW1XMrgpvhQaytxlHVnu+Kmyw4MQR06SLHXkKGGQ/4PHQFmyU+Atbu9WNM76p3OpQSZTnl8CBAeuqqGprVZHtoroV49O4VyXnDxBaBvPYHUcQBxCZ5koDYHmO86OwCD6CfNuTLfzBqsDanGKbmCc4bWY9w/1mh1645jNZP3f6BHE0wOipvYwHcFVarMt1T2LLF2mOxr3nPmZngfY/ExMsc4UDq4iEfT8Jtkdf0mEe57jc2+LTu2Clr9Ynen3MD3bDKZoMuTRUUEs8x0kQbDB8Fn/l36jWjp2+D9rfF/foc5TixPI0XIJFWkf7I4/Phg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U973vbGC3deU+/ldbSPQR/xQWMPleNfAhh6Z5pvCrWk=;
 b=irUwMNOC9PhFsZ1173TAun19XRaok4GibeO8zbfcELGXTO+iFbzeDO4QXNFPRnLdYZPAe0lhtGA1afB54esUaXFEYBm/Kij4WOjluDYpEoN1Iw3xVZcpRoF65HiC9Bh8+6+V3HCLfmNk3X1tA+NKDKVGlMhW80IE6p+af0BkzSftAkChJ6jp5lxPm5d/UQRfwRe1XXGPy5KvazXldeyCA1fQUNWrtp3h8CKkRHjbt7/+qfE4PLaZ1JR7A1FrKJTvC/XKCV+anij4sMPL7bUiLyyUKj6/Sb8vkJzYLaPpcOakTktkH9D/OMlbFBHrn/aau/B1KDex6Wlt2h0LYyqqiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U973vbGC3deU+/ldbSPQR/xQWMPleNfAhh6Z5pvCrWk=;
 b=m/GFWtRY2YVGnxNrr+Cn01v6jLeo0DGWxl9yMVGTCUISH04zRoOdei6mmiFBR26aai7m1vDml18WrhBtRpNfezdrhAgxpgPGYAnsdigMSfzCSeA09p1t4bFTnCUYtKvVwzthYYjRAmg+/uBowNnfbY+qIOW8KDr7EhEotlCfZBI=
Received: from BYAPR11MB3254.namprd11.prod.outlook.com (2603:10b6:a03:7c::19)
 by BYAPR11MB3606.namprd11.prod.outlook.com (2603:10b6:a03:b5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 14:18:29 +0000
Received: from BYAPR11MB3254.namprd11.prod.outlook.com
 ([fe80::5c0e:70f7:fb8e:8db1]) by BYAPR11MB3254.namprd11.prod.outlook.com
 ([fe80::5c0e:70f7:fb8e:8db1%7]) with mapi id 15.20.3955.025; Tue, 23 Mar 2021
 14:18:28 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <perex@perex.cz>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
CC:     <tiwai@suse.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <mirq-linux@rere.qmqm.pl>, <gustavoars@kernel.org>
Subject: Re: [RFC PATCH 0/3] Separate BE DAI HW constraints from FE ones
Thread-Topic: [RFC PATCH 0/3] Separate BE DAI HW constraints from FE ones
Thread-Index: AQHXH9nLKm9Vc1LsR0iPwMHUtMwvV6qRfMkAgAAiRQA=
Date:   Tue, 23 Mar 2021 14:18:28 +0000
Message-ID: <5e1fb981-48c1-7d5a-79a6-ba54bac26165@microchip.com>
References: <20210323114327.3969072-1-codrin.ciubotariu@microchip.com>
 <a0c862ec-44ba-52e0-551c-0347166ac4e9@perex.cz>
In-Reply-To: <a0c862ec-44ba-52e0-551c-0347166ac4e9@perex.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
authentication-results: perex.cz; dkim=none (message not signed)
 header.d=none;perex.cz; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [2a02:2f0a:c30e:ba00:a0a3:332d:815f:65af]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17f1212a-a203-407a-e4ed-08d8ee0687c0
x-ms-traffictypediagnostic: BYAPR11MB3606:
x-microsoft-antispam-prvs: <BYAPR11MB3606D18C004B2F206E18CA41E7649@BYAPR11MB3606.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 20Qb5GZy7YE0YP+GYmhzOCSk7sq86y1yRWy3xWb2MArQ3ucy+wJFYJA7zsfEoGJIbDkqsAADxuqi0k+rbAGSVFJRmLnv32Et2V1NotJArfIe3xZerzuFIby6iOM7Ie3pfVWzvqoPM/b4Ss1t7HZ1hraRqjtd1NqqsXAt7DoA6H3O0Ffqsa+aaBrmQ6BFo7J52m95GnQcUMVFW2jVJnz/iT2w8uLHrx3lTWWNYDTjRheDjOO1fDniD7uOdURVm1p1czqflDVYhEaH6LwvTaPLmQfgQ3o2qna8rvKzGQpk62wQc5ZYYtBCpSgX1VGNOW4nckvGwOXoIl77qQjfnxeXdvIizkOM/Ybft1uBnQDb+QQxa659CHXnP6ht2/UOcfiJd8vZZ0mQdYj6LrIKVpohQIa9iR8D4SgQaJ7om83vgWRwRXkFrcbgcgtDo+00kK/TE75Q0qJnJXFQWH7agFO7B0LH/hiufmblBiDcq9th1PlehRR+2f8EzKTFhP5d99WNyFWDyCakBtADnEwUgW0QWX+TD4BeNedyPGZc7fuZCoYsKW6KGOKDqj09p5X87tQmImkbZHtLFDKAgAWoRffCfirLJCxVlytQg8ryHHkVQiE0LeALKPI8r1iw47PyuOeHrWubSM0puR40ERznWB/+1/Zkt0HM4KuFW7UA+Dt8HtLYtIw+uwq3OD4/EA7vQdKMN5Wn1yH2BjItYi2Trq20NA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3254.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(39850400004)(366004)(346002)(4326008)(316002)(6506007)(53546011)(71200400001)(54906003)(110136005)(83380400001)(36756003)(6486002)(31686004)(8676002)(38100700001)(5660300002)(91956017)(66946007)(31696002)(186003)(6512007)(86362001)(2906002)(66556008)(76116006)(66476007)(478600001)(2616005)(66446008)(8936002)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QmtiV3AvUEV3NlFQZ1RYUlRQL1dlZU9mMHVZc01xb1kwZmcwYzRZS3BCSmx4?=
 =?utf-8?B?UHBlZnNudThCQ241VnpucFJiSHdjSU5lcGFuUzhwOVpXc1dsbjRvVXhSQm1i?=
 =?utf-8?B?K1BGYXJkbVEvMklCYjRHU3hMRmhuRklUeTBrSkZTcXd3L2loVTloV2d0ODJq?=
 =?utf-8?B?V29UNlJuTzI4a0VKaVlzcmswWjRxSUEvUjAzbVpLcU5NTnVsYVRDZUZwQi9O?=
 =?utf-8?B?aHQ0clhhZXg4a216WXJkYU9qMGFMNkxNU3lYM1E0RU0wWDNVMDRIb2lPM1Fi?=
 =?utf-8?B?dGk3SWk1WnFnbVQ0VUx1NnFDR1Zqd2pWaVBtbG00WkRGc0xiZDc2WTBYS1Er?=
 =?utf-8?B?bDA2ZTVPUkoyRzVNMitkY3c4dDViNGRsZ3NEdy92c0tDOUk2MmpwRUVYdURY?=
 =?utf-8?B?SjZpRlB0L244YkJlNk16a2FlM0xEdXQxOTEzVmJ0K0dKRGlhblptSVdIZGow?=
 =?utf-8?B?T1R0YXZMN0l6SkhtazcwVFVzeHN5TUJ0SzYzc3lCSzVmekRuWnNFeEhTRHlH?=
 =?utf-8?B?d3I4RE9DSWtCcHhqaEZUK2ZLRVJXOGQ0ZFowRTBIWW9aVGhHSlI4MEdaVjlS?=
 =?utf-8?B?ekVtQnpjcFBQVHVGYUJkUlJvZnp3UVY1eDJtVG4xc1NIYTRrdnQzcE9ibmkw?=
 =?utf-8?B?QWFyVHVXcU9wV2YvMDlQc0NUMHNlNE1ZZURQY291Wk5nUVhoSXJma21zWnpq?=
 =?utf-8?B?TWxmT2lPaWhKeXZnYm1OMEJoWWYwNFJkSzJLSkVGaUxNSUdSZHIvdnVRVG5v?=
 =?utf-8?B?TW0vRWpwNTVUT2dQNzFIS1o5Z2duclZWWlVFdkRoT09jZU85cVBQZGlzMHJP?=
 =?utf-8?B?RU0wcm4yRW9aa2xNb0xVVno2dHMwV05XWlEwNFJZZW5TV3E4WkhDMzQvVC9P?=
 =?utf-8?B?TE1KeGJ3YWVaMGVHMVZ1Z3kzOC9iOXVzYmhIUDVUUGF0ZkVGa204V2c0UGxo?=
 =?utf-8?B?Vm1hR3g2WWZUUk56Qml0emRGWFRqbVRSN1ZOUG4zQVFlT0lCdVBGUFJFMzF5?=
 =?utf-8?B?VkMrMEJSUFV5TWZxR0s1ZXlOSGFkN1liaHNYUlNGd0Z4WTlPNm1TL3N0MGlh?=
 =?utf-8?B?bmZaRk94T3BaME44V2ZSeXU0c2gxYTIvdzRFQnZDemVOMmx2YTl5SWFFVzVW?=
 =?utf-8?B?RUxJRnlQNFljRCtSQlVBQnNsYVdtZ1BBVXlrM1JvUXhTNjM4YU1yb1BWWWRr?=
 =?utf-8?B?L1ZjOGdwUzVSeVloVUZNTEsyaml1b0RZUHNrWVdzSE5tOE1XZnppdWRoQjhu?=
 =?utf-8?B?QnFNUVp3UEw4VTVpQWJqdVUwZHU1a1JSOG9aT1A5a2FVU0lRbXBCbmFqL1Fj?=
 =?utf-8?B?TGVyU05HZ3JEL3RIYUxBbzlId2IxNThKS0I1Z3hLMmtRckVwU0hpTG1xQkRN?=
 =?utf-8?B?MmpEUURWOWpabExmTzlRZWhadHVsV1JvREl2aW9TaEZxSTA1UTdoZS9rUE93?=
 =?utf-8?B?bEpMWXFJWFJSQWlwMVZ1eFNYaUNtU01BbkFVcjNnR1RFc2tTQmFhdkIrejFC?=
 =?utf-8?B?cTFMcjFBeDRsTkNiNnp5SWtmQU0vaGw2U0F2OUVjMGZJT2dGVGRXZW5WNE9k?=
 =?utf-8?B?bTZOVklPQlBMOC9PdWlFc1RXOGRiVUFwYVhlNGwrOTdmUkkyTCtpazF6LzBi?=
 =?utf-8?B?NHRRYXZzd04xUTZ0cjJ5TnlNVURueDc0UlBlcEE1cVJ2UUFnbExDK2VOTUFr?=
 =?utf-8?B?eWRpN1VmV3pUM0VaYlhPUVhTMGdJQk84ZzVvdjRiU1BxZzN0dmZpYnpoN2lW?=
 =?utf-8?B?YTR2L3d5dTRDSUlZeDQxcmNaNU9sM3B2UUM5OFo0TmJRZ0l5RzRwSXlhTUdu?=
 =?utf-8?Q?A0svjPNoOhdISLTByp0uQvK27+rsRuHj1GGjU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EB041DF2BA2A34DBAC6E1D2F368E93F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3254.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f1212a-a203-407a-e4ed-08d8ee0687c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 14:18:28.6376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TX6XfbCyPr9xoc23HK74GRWPiIwYnTxP1hLtluKrOGFQUo50d2ZvHEG9PVRZjGm5ADf5sU5dVo1yojlBZhPwgG4IZBAigaVeq1OLtqoUckk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3606
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjMuMDMuMjAyMSAxNDoxNSwgSmFyb3NsYXYgS3lzZWxhIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IERuZSAyMy4gMDMuIDIxIHYgMTI6NDMgQ29k
cmluIENpdWJvdGFyaXUgbmFwc2FsKGEpOg0KPiANCj4+IFRvIGFjaGlldmUgdGhpcywgdGhlIGZp
cnN0IHRoaW5nIG5lZWRlZCBpcyB0byBkZXRlY3Qgd2hldGhlciBhIEhXDQo+PiBjb25zdHJhaW50
IHJ1bGUgaXMgZW5mb3JjZWQgYnkgYSBGRSBvciBhIEJFIERBSS4gVGhpcyBtZWFucyB0aGF0DQo+
PiBzbmRfcGNtX2h3X3J1bGVfYWRkKCkgbmVlZHMgdG8gYmUgYWJsZSB0byBkaWZmZXJlbnRpYXRl
IGJldHdlZW4gdGhlIHR3bw0KPj4gdHlwZSBvZiBEQUlzLiBGb3IgdGhpcywgdGhlIHJ1bnRpbWUg
cG9pbnRlciB0byBzdHJ1Y3Qgc25kX3BjbV9ydW50aW1lIGlzDQo+PiByZXBsYWNlZCB3aXRoIGEg
cG9pbnRlciB0byBzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0sIHRvIGJlIGFibGUgdG8gcmVhY2gN
Cj4+IHN1YnN0cmVhbS0+cGNtLT5pbnRlcm5hbCB0byBkaWZmZXJlbnRpYXRlIGJldHdlZW4gRkUg
YW5kIEJFIERBSXMuDQo+IA0KPiBUaGluayBhYm91dCBvdGhlciBub3Qtc28taW52YXNpdmUgc29s
dXRpb24uIFdoYXQgYWJvdXQgdG8gdXNlDQo+ICdydW50aW1lLT5wcml2YXRlX2RhdGEnIChzdHJ1
Y3Qgc25kX3NvY19wY21fcnVudGltZSAqKSB0byBkZXRlcm1pbmUgRkUgLyBCRT8NCj4gDQoNCkkg
dGhpbmsgc3RydWN0IHNuZF9zb2NfcGNtX3J1bnRpbWUgKiBpcyBwbGFjZWQgaW4gDQpzdWJzdHJl
YW0tPnByaXZhdGVfZGF0YSwgd2hpbGUgcnVudGltZS0+cHJpdmF0ZV9kYXRhIGlzIHVzZWQgbW9y
ZSBieSB0aGUgDQpwbGF0Zm9ybSBkcml2ZXJzLiBydW50aW1lLT50cmlnZ2VyX21hc3RlciBjb3Vs
ZCBiZSBhbiBpZGVhLCBidXQgaXQgbG9va3MgDQpsaWtlIGl0J3MgaW5pdGlhbGl6ZWQganVzdCBi
ZWZvcmUgdGhlIHRyaWdnZXIgY2FsbGJhY2sgaXMgY2FsbGVkLCB3YXkgDQphZnRlciB0aGUgY29u
c3RyYWludCBydWxlcyBhcmUgYWRkZWQgYW5kIEkgYW0gbm90IHN1cmUgaXQgY2FuIGJlIA0KaW5p
dGlhbGl6ZWQgZWFybGllci4uLg0KDQpCZXN0IHJlZ2FyZHMsDQpDb2RyaW4NCg==
