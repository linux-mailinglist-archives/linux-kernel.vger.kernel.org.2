Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5E8351260
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbhDAJe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:34:57 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:48919 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbhDAJel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617269680; x=1648805680;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mjFmpcUIb3+kRHSvQD1SHCArNLfizYN0kYuyEgZZWH0=;
  b=A2QfkkM2zRZKuTp+5JPYJ0BaTUmr1EsZtfLPBriDxq0UjTN+hA5HuvpH
   la2+mNwWO0XJF16tAbgMqXuhWhNyQvNJ+eleUyQh4v6+cw4NRNapUFg8C
   TEkPfknGp2YsKZCO1PGhNRm3SmUvcOe8AvROpE/L9tO8l7uyrF2trMj8Z
   fw0aabFiArJHRfGlEDDuSqqAwXaMEsz93Mf5dOVr5yo2fvAP94gasyacJ
   W6IN2f/7JGsYKmVjzc3uRhJgI5R1nTUhNiR5F+z5Rx+15YMLVXstuDRWC
   dwxoruv7uuWbbIu/bv2CTk5RGBBPupMjASXp3LWwqv+uCPf45Go5eyNRU
   Q==;
IronPort-SDR: oKY5aLHS/M8St8pB/6mfumCwjzk29h0VU7wor7nYZHlIS1eHuuHwNbk+rnBiblm6xP/FUrz3ki
 Uf7vvGKwkMurGasJfibEaQbbI8IXcY97aLPGYYGseQzx2PjX9RTvV6cWdEPgwCtyRENtnyFXqn
 LlK38UPebEJMk9Kb/RAm+1533Fm73n3QP60zpbNRhqkXfRUSfpcUE7AoENSYD0221fhlX+0C2I
 ZWxQtRvm1D8bzwFU6OH7sjgkouIlKaYmiirkq+Kl13glEJDqrtievQPgVKrDwZK+OqqEGZ2S1o
 RcQ=
X-IronPort-AV: E=Sophos;i="5.81,296,1610434800"; 
   d="scan'208";a="121393415"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Apr 2021 02:34:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 02:34:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Thu, 1 Apr 2021 02:34:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQtojOKywdkK6ZsG+5PrRjwswvatUEeoEvRN6Y5ChiJLpX6lXIdHoFZGVXUR64VQPFLiePxZNwNLjaacdFmSC4ACBnTi+8B7yldRkA2GVb+YU3ru9sZ1Wjh9DLr5eJOQJABqZmXwr0asDnTRFx6w9/dT2ha6NgfH6mcGNmi5hpF4xRiu932cQFFbrOxoF3iVxr+MIWkkNDSb/rZc8bUQ/go34sUVtRXJtni0bXZJnus2znmYXAR+5LTiaryx8MTdOfaSjo56nYCnngILp3xHkbTJOFR36cKdwsvZGDNEem6pHEYvWhmcPjsbLvRoZKB4iPOTYWK9TUYh5InB4FYxhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjFmpcUIb3+kRHSvQD1SHCArNLfizYN0kYuyEgZZWH0=;
 b=La0i4V0p3GOdc5L0NtWqmbAuBH5K2/FzZh/DwDcFaz8+JbSHguxHsAe19ERZnXm2qYgLFgplZ0PJD+ZSc8piB/Mwpr9hdWwoB6bqLHond9bDA8EL3x8XMXydXKLoxQI50hQX/WXJGHRAAL/+o9jZTrH3zfRFzihveSGQH2jXPUwq0EFi9Oh9N5wkt0yxsHOK9dqMcSzIdozpXeewJoDUIP8GeM/UoSRYdiK7ZYNEqKyK9tm8m+jFDcxZvvsw1pevbw0cwp1Cusfa6mnDQpmauhrVjkFDYMDjJubHQaA/fgSh2wF39h5/VUospePJG01aaANmDTMDGeSZZIpgmWwYkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjFmpcUIb3+kRHSvQD1SHCArNLfizYN0kYuyEgZZWH0=;
 b=ge2kkm6gO3TpwS4Dtd8V9c3KwuHkAit5BrP1sscFL8vWX8iwVxJKEPStEB77LULB3nEGQtr6l3dUZPb8vfC96MtHHgqHc7Qwba3brPEJ3l/GR/pxzvLpg5E1j6TfCcJIEQRSASVyfzelEaB3nAIW/z1de5SEmigTzUnC7M1GmAw=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM5PR11MB1244.namprd11.prod.outlook.com (2603:10b6:3:13::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.30; Thu, 1 Apr 2021 09:34:28 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::d405:a5f2:bb71:38d7]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::d405:a5f2:bb71:38d7%2]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 09:34:27 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <robh+dt@kernel.org>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/24] ARM: at91: sfrbu: add sfrbu registers definitions
 for sama7g5
Thread-Topic: [PATCH 10/24] ARM: at91: sfrbu: add sfrbu registers definitions
 for sama7g5
Thread-Index: AQHXJto1cqEGPMubF0ah/8RAh+Uf6g==
Date:   Thu, 1 Apr 2021 09:34:27 +0000
Message-ID: <cf45c875-5df8-5b3c-a0c1-7d5d8fc32ccb@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
 <20210331105908.23027-11-claudiu.beznea@microchip.com>
 <YGSbMtNzcVmBg7fQ@piout.net>
In-Reply-To: <YGSbMtNzcVmBg7fQ@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [82.76.227.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 570114cc-5aea-4a40-26fc-08d8f4f15852
x-ms-traffictypediagnostic: DM5PR11MB1244:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB124481C3D499605F1B188785877B9@DM5PR11MB1244.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EvoIYfQzFxROeQgTY0fD/VDhDw0vPZ0pTjtIifBI/ArxfugpE5BtjBTjIGT0Zz2JeYg9Mt1KZWSbDqX7lUyh5zVlhjoXKuQE4lISzGmeeilFYFZm5FP8Sx9mVdN5OBKsJroiqzQy85V5mK7AFZcSpluPBgPt4pwF0xiDzGYadUBCn9NA4WrOuEhqW6JFIG8nUkPlicTXAb9jq9vV4z2Lk4I4BvmtiLfr85wkK56fblpbEI8sNlkbIQaWw9wbqOA0exv5gqfrqpkbbm81a/dJTv0A3Py5CkYPY7z38xn5onbEi/x2fsX6ybyGwxJxIb37x6svCsUmyyrHwbX+qQ9l/IGlCOndTw3xufEx8GXNh/4nHF1PhxpyaKhiF+MuoTwUtCfYGoS+YrVRw86onZRjO7RN/LFQplmadjvkoetxFrIww7vuG7Fs/bwncRd9Q8u6pJf6ZrcP1NSgoSjChE9fTjsvB0bfjLdyKeBoDjibAbn0lfa5uKHsEXF71F2SkxUI+/rtNkP8uIZUxClNpQ5FxUENBXdmSaYGvuY0Wgo97iyLohaXISOC9YMIAdNuSdnxFh9efP1KzScjL06VWhSeCvsDEr4DjlWODpG2ulVJIDBr9pkk8GZZEvBivCcKPRDQRJRrs6azizvV5L6ZUKoOKp+vaaFVh90IWXnyxRWQ8QpYA5cE86nP20F2XipggFOawuy0uXbqclY5PbRhyZycy9ba8ViK05wVrwIisTyvVjqbDZ4GU7W4wsXM0Vjbn2Yu4k/wOoXSP+DkFvU1F66+qGEW/Bsb1pweif2lfL29Q+LixXYzP9BepkYvh0+GuLNd9cuJTnt+2ZApLlmEqc5Uxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(346002)(396003)(136003)(316002)(54906003)(6486002)(2616005)(91956017)(66556008)(186003)(86362001)(53546011)(8936002)(38100700001)(83380400001)(31686004)(64756008)(5660300002)(26005)(31696002)(6506007)(478600001)(66946007)(66476007)(4326008)(2906002)(36756003)(6916009)(8676002)(966005)(6512007)(71200400001)(76116006)(66446008)(138113003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?a3IveXYrZnRsM2JvVW1zejNEalpnVml5TFBIZjhzVzROTktvNDJPai9iaHJs?=
 =?utf-8?B?SkgwdjhFODh5bkVoS1IzNUM5VjRyQ3RMcDN4djBwR1IvN2JIY3VyaEc4eHF5?=
 =?utf-8?B?dDBSRkI3b2VCaFFvZldIbTdPUnE0MWplcFVPWVJyZ2pDOUpQcm1ROTVDSVVy?=
 =?utf-8?B?ZXlsekhkSEV0Y1h1VDQvRlhrTzNkbWVCV3VHUkhmNnJXSW12c2tFRTVkS3Nu?=
 =?utf-8?B?NHdTRGN5aXQwd1pXWVBZZG00c3JubGZmaHJRUmdzMFNRaStSdFAvWnRya0R0?=
 =?utf-8?B?S1RDMUI0dDg4KzFCL1A2ZTRqQm52RGsrUFRwT1BDOUh3cXFYWHNjZXFqTnB3?=
 =?utf-8?B?bkRIQUNLbFVQS25nVWhISG5sNnNheGo2YXNmSkNUNWQ1eGVhNnErTG9JNGZJ?=
 =?utf-8?B?NVluaTBOa0pnVG1STzgwcUtsZmxkekdqWENGZlZKeEMvcVdQUzRKam5ZVkF5?=
 =?utf-8?B?bG1hcEw4RlI1Qm1WeUo2VnZISE1nNHJTZ2dTNW4vRTgxZ2VjQWRzZ3dOT0RL?=
 =?utf-8?B?aldKUklZUnZ2Wk5EM29OVXdwMEdUU1ZlUklzbVlFTmtPZm5iMHQ5ZE55MmUz?=
 =?utf-8?B?NXUvWnFoWUVFaldYMm9UbU9EYWxmcFNOeEx6b0NPcGM2SVFpTmxrTTJNOUhY?=
 =?utf-8?B?N1k1VDZmTzc5OGZEcktROW9hTXpKdHRsa3RVYmY3Yk12aCtSZ2tkdC9mT09w?=
 =?utf-8?B?ZWJ0S0VjNkNSekFZcStzWUxpWEQ0SzJPOVFwS3dNUkkrSWY5cGV2Q0ZVTlNO?=
 =?utf-8?B?SDVGd05HU1I2R0dwN2xES1hpRjE3S3ZaT1l1Mk0zWm11MVZ1NlQ5M2RERU94?=
 =?utf-8?B?S2tHQXlSYm9aamZrcnZXUlFGbzg0ZWYwRVJKRVFLZnYrbVFJeUVEblcrdWsy?=
 =?utf-8?B?cWRIOFg1bk9idVFnbk91SXlBRWRpeWdWQWxjMWkxemVsZmFpRDl0a3pCbHc1?=
 =?utf-8?B?amJENXlMRUZnd2FtN2ZOZUlJbTZUSm82dDR0Q0hRenZkQjBTUnNzQmhNNmVN?=
 =?utf-8?B?dXJFR01uVzE4WFZDMEc3eFMvdFNuRUJpVjJVNHBiU2lmcm1nOWNNNW1wcDdD?=
 =?utf-8?B?U1I3Vk03ZnkyUS9hWm5lOUY4b0ptTTdQdEROQ1VQYSs5bnVDSHk1bStPZ3Nh?=
 =?utf-8?B?U2dnRW9SZXJ0T1RXYmM5ZlRJRTRjUXB4T0FFdGhHZmQxc1liQzFEVHlqYVVq?=
 =?utf-8?B?NUxaN0RMU1FIZDAzYnh0eDdkVHNwa21TVWgzZ1Z6RE45SHFEWndRcllydnVO?=
 =?utf-8?B?VnhpcmNhbkFRMDZnWHplRXFwS0ZBOHZHSmxLRkxTL1NOYmRQbWVLYjlLWFVE?=
 =?utf-8?B?KzN6YlhTV2dOcTNJOGdHVU1UVDBVdDFjdGRzam1VRVNKYlJKTGtCY1FSaHA5?=
 =?utf-8?B?K3F3Sm5NTldldXNqUHcwN08vRDNsbnJQd2EvMy9YQ1lERGI1bDNyT3AyQjcx?=
 =?utf-8?B?KzY1WjhjNVM4TGtzQWNza2FCZ3JMalpEZkdnemR5VU03ZzVySkdwMEtoZkk5?=
 =?utf-8?B?NVllY0RkcnZ2Y29RYzlrbG9xdWdzSGgzYWEzSjFiYUI3alBKcWV6eEpoZFE1?=
 =?utf-8?B?bEswVk9QdytCSGNuZUNwM28rM01QZjE2NzZiT1VHbk1ZSzN5TXJWMWwzRnow?=
 =?utf-8?B?NER2cnJWOGF4M24vK2hqYW1OQzFiRjhCbWI0NlBrOFh2bkZGTXkwQ045YlFK?=
 =?utf-8?B?SDk2eVIrNitQZklNVnR3MmViOTJpNFZHWW5XTGNscGt6NlVUMjl5dDkxeitN?=
 =?utf-8?Q?YeuckV5lN/f1/yhva8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73AF9BEB12B7FF41A984E634C5EE14CB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570114cc-5aea-4a40-26fc-08d8f4f15852
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 09:34:27.7480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7lfOpI8IUS7xLTAnHYqkWbisZALwxiDcLVCJL+ZH5wZycCPGZX8fe2WneB2xXEjJSOkmuXCixkkIJL1K4uowKrlEM3N+Fy5H8hu7Ll5+5ZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1244
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzEuMDMuMjAyMSAxODo1NCwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMzEvMDMvMjAyMSAxMzo1ODo1NCsw
MzAwLCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+IEFkZCBTRlJCVSByZWdpc3RlcnMgZGVmaW5p
dGlvbnMgZm9yIFNBTUE3RzUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEg
PGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICBpbmNsdWRlL3NvYy9h
dDkxL3NhbWE3LXNmcmJ1LmggfCAzNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+PiAgMSBmaWxlIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKykNCj4+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgaW5jbHVkZS9zb2MvYXQ5MS9zYW1hNy1zZnJidS5oDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvc29jL2F0OTEvc2FtYTctc2ZyYnUuaCBiL2luY2x1ZGUvc29jL2F0OTEvc2FtYTct
c2ZyYnUuaA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4u
NzZiNzQwODEwZDM0DQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9pbmNsdWRlL3NvYy9hdDkx
L3NhbWE3LXNmcmJ1LmgNCj4+IEBAIC0wLDAgKzEsMzQgQEANCj4+ICsvKiBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMC1vbmx5ICovDQo+PiArLyoNCj4+ICsgKiBNaWNyb2NoaXAgU0FN
QTcgU0ZSQlUgcmVnaXN0ZXJzIG9mZnNldHMgYW5kIGJpdCBkZWZpbml0aW9ucy4NCj4+ICsgKg0K
Pj4gKyAqIENvcHlyaWdodCAoQykgWzIwMjBdIE1pY3JvY2hpcCBUZWNobm9sb2d5IEluYy4gYW5k
IGl0cyBzdWJzaWRpYXJpZXMNCj4+ICsgKg0KPj4gKyAqIEF1dGhvcjogQ2xhdWR1IEJlem5lYSA8
Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+ICsgKi8NCj4+ICsNCj4+ICsjaWZuZGVm
IF9fU0FNQTdfU0ZSQlVfSF9fDQo+PiArI2RlZmluZSBfX1NBTUE3X1NGUkJVX0hfXw0KPj4gKw0K
Pj4gKyNpZmRlZiBDT05GSUdfU09DX1NBTUE3DQo+PiArDQo+PiArI2RlZmluZSBBVDkxX1NGUkJV
X1BTV0JVICAgICAgICAgICAgICAgICAgICAgKDB4MDApICAgICAgICAgIC8qIFNGUkJVIFBvd2Vy
IFN3aXRjaCBCVSBDb250cm9sIFJlZ2lzdGVyICovDQo+PiArI2RlZmluZSAgICAgICAgICAgICAg
QVQ5MV9TRlJCVV9QU1dCVV9QU1dLRVkgICAgICAgICAoMHg0QkQyMEMgPDwgOCkgLyogU3BlY2lm
aWMgdmFsdWUgbWFuZGF0b3J5IHRvIGFsbG93IHdyaXRpbmcgb2Ygb3RoZXIgcmVnaXN0ZXIgYml0
cyAqLw0KPj4gKyNkZWZpbmUgICAgICAgICAgICAgIEFUOTFfU0ZSQlVfUFNXQlVfU1RBVEUgICAg
ICAgICAgKDEgPDwgMikgICAgICAgIC8qIFBvd2VyIHN3aXRjaCBCVSBzdGF0ZSAqLw0KPj4gKyNk
ZWZpbmUgICAgICAgICAgICAgIEFUOTFfU0ZSQlVfUFNXQlVfU09GVFNXSVRDSCAgICAgKDEgPDwg
MSkgICAgICAgIC8qIFBvd2VyIHN3aXRjaCBCVSBzb3VyY2Ugc2VsZWN0aW9uICovDQo+PiArI2Rl
ZmluZSAgICAgICAgICAgICAgQVQ5MV9TRlJCVV9QU1dCVV9DVFJMICAgICAgICAgICAoMSA8PCAw
KSAgICAgICAgLyogUG93ZXIgc3dpdGNoIEJVIGNvbnRyb2wgKi8NCj4gDQo+IFBsZWFzZSB1c2Ug
QklUDQo+IA0KPj4gKw0KPj4gKyNkZWZpbmUgQVQ5MV9TRlJCVV8yNUxET0NSICAgICAgICAgICAg
ICAgICAgICgweDBDKSAgICAgICAgICAvKiBTRlJCVSAyLjVWIExETyBDb250cm9sIFJlZ2lzdGVy
ICovDQo+PiArI2RlZmluZSAgICAgICAgICAgICAgQVQ5MV9TRlJCVV8yNUxET0NSX0xET0FOQUtF
WSAgICAoMHgzQjZFMTggPDwgOCkgLyogU3BlY2lmaWMgdmFsdWUgbWFuZGF0b3J5IHRvIGFsbG93
IHdyaXRpbmcgb2Ygb3RoZXIgcmVnaXN0ZXIgYml0cy4gKi8NCj4+ICsjZGVmaW5lICAgICAgICAg
ICAgICBBVDkxX1NGUkJVXzI1TERPQ1JfU1RBVEUgICAgICAgICgxIDw8IDMpICAgICAgICAvKiBM
RE9BTkEgU3dpdGNoIE9uL09mZiBDb250cm9sICovDQo+PiArI2RlZmluZSAgICAgICAgICAgICAg
QVQ5MV9TRlJCVV8yNUxET0NSX0xQICAgICAgICAgICAoMSA8PCAyKSAgICAgICAgLyogTERPQU5B
IExvdy1Qb3dlciBNb2RlIENvbnRyb2wgKi8NCj4+ICsjZGVmaW5lICAgICAgICAgICAgICBBVDkx
X1NGUkJVX1BEX1ZBTFVFX01TSyAgICAgICAgICgweDMpDQo+IA0KPiBHRU5NQVNLDQo+IA0KPj4g
KyNkZWZpbmUgICAgICAgICAgICAgIEFUOTFfU0ZSQlVfMjVMRE9DUl9QRF9WQUxVRSh2KSAgKCh2
KSAmIEFUOTFfU0ZSQlVfUERfVkFMVUVfTVNLKSAvKiBMRE9BTkEgUHVsbC1kb3duIHZhbHVlICov
DQo+IA0KPiB0aGlzIG1hY3JvIGlzIG5vdCBuZWNlc3NhcnksIHlvdSBjYW4gdXNlIEZJRUxEX1BS
RVAgd2l0aCB0aGUgcHJldmlvdXMNCj4gZGVmaW5lLg0KPiANCg0KVGhpcyBmaWxlIChhcyB3ZWxs
IGFzIGluY2x1ZGUvc29jL2F0OTEvc2FtYTctZGRyLmgpIGlzIHVzZWQgaW4NCmFyY2gvYXJtL21h
Y2gtYXQ5MS9wbV9zdXNwZW5kLlMgd2hvJ3MgY29udGVudCBpcyBleGVjdXRlZCBmcm9tIENQVSBp
bnRlcm5hbA0KU1JBTS4gSSBjaG9zZSB0byBoYXZlIHRoZXNlIGRlZmluZXMgdy9vIEJJVCgpLCBH
RU5NQVNLKCkgYW5kIGZyaWVuZHMgdG8gbm90DQpkZXBlbmQgb24gdGhlIGJpdG9wcy5oIHdobydz
IHNpemUgbWlnaHQgYmUgY2hhbmdlZCBhdCBhbnkgdGltZS4NCg0KPiANCj4gLS0NCj4gQWxleGFu
ZHJlIEJlbGxvbmksIGNvLW93bmVyIGFuZCBDT08sIEJvb3RsaW4NCj4gRW1iZWRkZWQgTGludXgg
YW5kIEtlcm5lbCBlbmdpbmVlcmluZw0KPiBodHRwczovL2Jvb3RsaW4uY29tDQo+IA0KDQo=
