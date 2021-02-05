Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA67431090B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 11:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhBEK15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 05:27:57 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:31595 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhBEKZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:25:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612520719; x=1644056719;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eCwxh9D2pgW7DLwSOzuI6nH+h9e/RKFac7gw2SWm3Hc=;
  b=l5wseSfbN4/1y+2glJfQqE+L5mX++5Pfd9Ooq8k1b+xfI7LTyC+ks25V
   MoydmYzyp264FKp/kK+kog/imHn5pC6dqk+HuFJxt8TfnZZWg58uYHNMu
   mleF7enpRchhUO26+okPUojiepoctWK2cB8GNNBjmISQNtDDXIXpmYzec
   /+DpWDKVB6861OH+bNYGrE4IJbcg4j/khiukk91GtfEGb2oBi5V6UYtph
   YsSVs2Rv+rWjTBBBFuIpcSz+hKu1XOuqC9xjPkEPzL9LqpHVYlot4rO2O
   SVhuNWjsfglh0wvPFJJaOCyBNb8hL5XAi2a+wa7evVUJRV/3Hx6tgCJ49
   g==;
IronPort-SDR: 9m3tnGFD1XGP4T9WsVZm+37xIorYbvJS1Ky4BrVyPjbrP6tI2ygPeVSrhEViOrj7u3ImI+iwj6
 yn1l3RHHqW5ArnkBQOVB15ew8QPh/+iInLhJSwI8VZ9EDIg2vK4mFfB2DlWacFz0kcvYUmTMtR
 49EFCp4H9ZpuvcK17LQNVgK1y1PYPvQyK9Mlp4ewfdsA2+y3VZA8Er7wPrVB/0l/EFzyAJvZ4F
 +5FXoo/9NTzNFzgzoJvs2NyNsY8EXFFQ1JKlaS8uGwgiZUP30Xzh+uRbHRDTk8Re7u3KWQgusx
 SxI=
X-IronPort-AV: E=Sophos;i="5.81,154,1610434800"; 
   d="scan'208";a="102719326"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Feb 2021 03:24:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Feb 2021 03:24:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Fri, 5 Feb 2021 03:24:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEjuJw2aRCAHd5iN/3moKGucD5inLV0JxfS8hTiUBTGeiDHDuvUyhYzG/yalf3bUM3r7Pphse041aw4ZBXFndXTMgGxAQcoTQaWQDxcEd1fNiGmHWi80twvauMcxDdnqASeXm4wozZ4AkdoQxig8F6RgvJ0rRPuISjNzEqMWkhz/zbfzasohvef1US632xNxAinLBRpOn1v8JNO97lWjzPcPR20J8sBUOENLMRfHuuImQDWmAA9NBBgN5qmwIpRDMCt/gAxJ/kPq1dp8nUFcU1YHjpcrvU738tsaycwgqLDvstwRvj68jgDA08MdOFZIJtIgJNjfiSo69fPwAHb4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCwxh9D2pgW7DLwSOzuI6nH+h9e/RKFac7gw2SWm3Hc=;
 b=NbfipNlxuVRggonxqlbVo9E5JcntlD/q+jgFAV1YmMeBGJNoXMY0vPAiHDbDwU1ldK66AD3HayseKS3VArsmWFEf8KxUiZZdKLVLHDNGkhTF/yF5kgxtmNjIxY5w6S4kaZDKRaAZtASnZmmD66eulj4IiWMojtyTeBsq6HUTd6iy71ANX0Zosx73zWbBMAesFLPpzkqU7K2ullTVKdLbQNceFRim+qisjzRVgMt3RgvYxkREkZWCMaZOe8ceRlUx9ThFr3rlYY6U9opuNWZCfc/iwXKVp4ckSd1Ruh/ZY/rrWJPHEE+Y1fv46JO5OvEdltFqgfVDRB8CwqeuPDjTCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCwxh9D2pgW7DLwSOzuI6nH+h9e/RKFac7gw2SWm3Hc=;
 b=YWKLmYR7MTGVTJ7Lk3LDhHJNF+5xxD9UFZ1tE/TXYXT+YrMJGtwaAp+U2oscTvVvfHE8kWixJMp/mLicNZlz1d75qHUq8aMyDbTUGC9mWHPR+P7BNY4N7cIajwQFuRTNy6j0QmJ9VsXQtOdnNJmVhRg1dC3LrnGDc+ZSOwIdHeA=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by CO1PR11MB5091.namprd11.prod.outlook.com (2603:10b6:303:6c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Fri, 5 Feb
 2021 10:23:56 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::d188:a2fe:7281:873c]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::d188:a2fe:7281:873c%6]) with mapi id 15.20.3825.020; Fri, 5 Feb 2021
 10:23:56 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <linux@armlinux.org.uk>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: configs: at91: enable drivers for sam9x60
Thread-Topic: [PATCH] ARM: configs: at91: enable drivers for sam9x60
Thread-Index: AQHW+6dpJBlA9WR+tkSqiBGswIFyF6pJWrSA
Date:   Fri, 5 Feb 2021 10:23:56 +0000
Message-ID: <e42ed693-d809-fa1d-c8bf-5264d1ff9783@microchip.com>
References: <1612518871-9311-1-git-send-email-claudiu.beznea@microchip.com>
 <56ee9cda-7943-2f5e-c068-51eff7b021b3@microchip.com>
In-Reply-To: <56ee9cda-7943-2f5e-c068-51eff7b021b3@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [79.115.63.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b5cf80f-7256-4509-6511-08d8c9c024f8
x-ms-traffictypediagnostic: CO1PR11MB5091:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB5091C5C10F99873C09EC96D6F0B29@CO1PR11MB5091.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9q1chJbMG5SBTT8V83T9SoefPAJlXxvPD4Fhi3CtpuNca5otYCyJScAKT5/PikNIS4RFpFT6S57aB9rfjDgSjxkrALaN04Y095VoVUBPp4xmEoyOIoqbyEy3eok8fBV3R0VUlirnSDUmqmumkWmWY4TQDIRTdZPAWrUG3y3zH02pgbMem+NWyXWyeghbgFvWlo6n+NXZAMNb5YqNDsqkRIhCCVwAntzO1/sWQ5hP7yfmwK+Dzka1sLis/qeP0S3l2F3dX4Fkkf+p3iGTlaX/pXs0cvOsdEpH9vRfGAuTd2J2amz+XNWL53qoi7un2FvYW2k//vY5VrFYL6qoedM+kFZ3GQlO8fjrVaoOG30hxDEtLB/jR4k6dGO508U7FLeIO1EKFNboWifHjwwbdlTKiJAqTMPc6OACqY981DYEfVl2Y9dwlcRY6Hw3ec0qC/coiSAK2+Udf6O6ra2ZScBKkeBK8KiKh1fNVuIhPGEZg/cIwLVwctdockClaB3cBrba+wvjtER3otYLy+eBnQE/W7jdq3/x3bfcRoWCj89zSarabZLPhdjySIVdVuEd89lvliPOSCeA0yw/Nc7xgnsHi2YbCXu5SlAPlMigd+dNIUz60R5s25e8ZQfyNqM9E7gyfZqho8l8vlgcXH48Atp4zndYKcSAUqk+A61KXx2ZdUEbDyUaDRtNEOSDPyT7zT4pmRu3WLw+sNWIu3SmR9Du7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(366004)(396003)(346002)(86362001)(71200400001)(31696002)(5660300002)(6636002)(36756003)(76116006)(316002)(478600001)(110136005)(31686004)(966005)(2906002)(4326008)(91956017)(66556008)(66476007)(83380400001)(66446008)(54906003)(64756008)(6486002)(6512007)(2616005)(8676002)(53546011)(66946007)(186003)(26005)(6506007)(8936002)(138113003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WjYxakJ6YkpCREdEeFcwTzhPUk94VkplZTA5YXowWnEvUytka0ZTNllJczdM?=
 =?utf-8?B?NDNOc2FWejE2Q0tHYkpEUis1R0JISlVjZVRhMzVQeXZvS2NmSStaN05xRUs2?=
 =?utf-8?B?cGUrdnU5N0l6bTMrdVpRM1lIMFRTdXZReHlNSUsxZXZPTTZLZ3c1REpQRFBs?=
 =?utf-8?B?SmtzTEcyQWFENThNT1paT0w2TUNEU1FIZzVjdjFKNUxiTTNjRUNBd25vU0g1?=
 =?utf-8?B?UkRra0xxTmNJSHhVRkdLV3J2MGpobW8vMFZjYUd4NWl1czhxN29RREJMeHk3?=
 =?utf-8?B?bEtDaWZGUVJhMFpLYnBpdFRVa2pEVmliT215YlVaeXFWbUc1ZVNNSzJ4Z21C?=
 =?utf-8?B?cEJsOG04dzU3ZytoNnptNXVMaVpsOVRvMnA2MHZvTTRISzdDUXdkQXhKdjRP?=
 =?utf-8?B?Yy8yV1RSNDJ2aUYyRHVYK1JpVC82MjZ1SDM0OXZjbjRQaDhzbEp4cUlaTDVj?=
 =?utf-8?B?c3U3MVp4ZmowdWVmUkpnRHE4UTl2V1pJNmtXbVplRTlQQi9wUHZPT1dFT25V?=
 =?utf-8?B?dHVscStxei8rQTBLTFN3YTF0WElKbnFJQ3cxcTBOSHFuWFRlZ2Y3SmhhWjFP?=
 =?utf-8?B?MC9mSDRHVCtKVjR2ZFFIb1E5U3RuaE9rM3l0aW0yUXZtNnV1UGlJMzYwMlp3?=
 =?utf-8?B?bk1sbm96UjRVblYrQTFIUTNMQzF1dnBvK05xN3hJdnNoeEJkR2hpV0IvOW5Y?=
 =?utf-8?B?U3VKeTdEOFpZcXU1QlVQSWV1TFVkSGMyNjJKRFZFSndWNEtOc0dIeXF4bkxp?=
 =?utf-8?B?ZXllZEhPT2pVWlREVXgrMTJSeUN4NWRDQ3liUVNBUVpGaHdhcXZNbXEwcE1x?=
 =?utf-8?B?MFRMMUhjalh1QlNzckJXaEZKNFBoOGdpb1FQUHAva2FyMC9KOXNDd0FodEI1?=
 =?utf-8?B?QlhIUis3WnoxZUUrWEJlZkxkVzgrckdpREdUaDBTL0tOSjcxaWJwZ21ZMnRm?=
 =?utf-8?B?azdIbXA1S0UyQUQ3VHZRYTBMaHk5cWN1L1pEU1BDUWtiU0UrSklFQzgxSzdN?=
 =?utf-8?B?LzBVUTN1d3o3QUR3UUZuYk9VbDB1Wlc3aG1CQ0ZUS3gyUVpycGRuQW1rSkRy?=
 =?utf-8?B?QlhNVGk1N3dHSnJUT3hXOTVQOGkyNEh6QzJGMHBQbjgrUVVib1MyWXRRRFBz?=
 =?utf-8?B?MmVTb0I2UzZseWg4djFORGpLR2hHYjdNVWFzTVRrcVRmTUdmdFRHQ0FxanhE?=
 =?utf-8?B?cXhYb0phUExiY3NabGlFTFEzQ205L2Y3bDFUYkhKMUdGUDBOdlpJdUd4UFF6?=
 =?utf-8?B?ZXh2eFF1cll5bDRLamkrWlloZnFFY0VUSWw1d1FPTERBTEw0VmRvTzNYbkoz?=
 =?utf-8?B?ZHRxK3MyV2pHWCtHaDFUQk1aTWQxaUY3cHBxaWtIdUhwSUUvVFp1aWhlU2lz?=
 =?utf-8?B?dzd3Qm9TNkxZRFQyeFJNenBuUmRETWdwcGJzamR4NmZHaUlKcU9Id2NrZEtJ?=
 =?utf-8?B?Yjl0YkFjMlQra29NZjFDdFpCb0hZNmFhUzJSekg2NzdoRjRpWlRickZkRzBz?=
 =?utf-8?B?YWxGMzdacVUrbWVkWGdjU0NiTXdjU2swWGxZbGsyS28rWWxvT0xXOTdyK2Mw?=
 =?utf-8?B?bFU0TklRVFdlS2xkNEthU0RWTXlXbXF4SUw1b0c1andJcFFOejZRdUpHY3lF?=
 =?utf-8?B?M1VQS3gwTWRWbzJFeUdJd0VEUzVyZS80cUxneTRJR1hjYnFYUzZCWGYwTlFr?=
 =?utf-8?B?c1dTK0gxM2s3ZFVLSzlkY0VHQWxWNVJyQWZkM0RlZVNjdjRJdU8yNXFIOEkz?=
 =?utf-8?Q?PHTF3cnfl0qKbmXy2Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03AE13E455DA6B45BC38F047D8B2F318@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5cf80f-7256-4509-6511-08d8c9c024f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2021 10:23:56.3101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JdtZCyCuW3Q3eXG2uTxl14MtPQLhlCaMt2yAIGRGdxwsAfUD1VWK2deiIMD2YL6EIixPsMhhczSgs0FUWkc1IsPZraTx2zBZbndBqncBez0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi81LzIxIDEyOjEyIFBNLCBUdWRvci5BbWJhcnVzQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMi81LzIxIDExOjU0
IEFNLCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQg
aXMgc2FmZQ0KPj4NCj4+IEVuYWJsZSBkcml2ZXJzIGZvciBzYW05eDYwL3NhbTl4NjAtZWs6DQo+
PiAtIHNodXRkb3duIGNvbnRyb2xsZXINCj4+IC0gQ0FODQo+PiAtIEFUMjQgRUVQUk9NIChwcmVz
ZW50IG9uIFNBTTlYNjAtRUspDQo+PiAtIE1DUDIzUzA4IChwcmVzZW50IG9uIFNBTTlYNjAtRUsp
DQo+PiAtIEFFUywgVERFUywgU0hBDQo+IA0KPiBDcnlwdG8gSVBzIGFyZSBwcmVzZW50IG9ubHkg
c2FtOXg2MC4gU2hvdWxkIHdlIGhhdmUgdGhlbSBhcyBtb2R1bGVzPw0KICBeVGhlICAgICAgICAg
ICAgICAgICAgICAgICAgXm9uIDopDQo+IA0KPj4NCj4+IEFuZCB1c2UgIm1ha2Ugc2F2ZWRlZmNv
bmZpZyIuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6
bmVhQG1pY3JvY2hpcC5jb20+DQo+IA0KPiBXaXRoIG9yIHdpdGhvdXQgdGhlIENyeXB0byBJUHMg
YXMgbW9kdWxlczoNCj4gDQo+IFJldmlld2VkLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJh
cnVzQG1pY3JvY2hpcC5jb20+DQo+IA0KPj4gLS0tDQo+PiAgYXJjaC9hcm0vY29uZmlncy9hdDkx
X2R0X2RlZmNvbmZpZyB8IDEyICsrKysrKystLS0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L2NvbmZpZ3MvYXQ5MV9kdF9kZWZjb25maWcgYi9hcmNoL2FybS9jb25maWdzL2F0OTFfZHRfZGVm
Y29uZmlnDQo+PiBpbmRleCA1ZjM0MTVjNzQzZWMuLmUyNzRmOGM0OTJkMiAxMDA2NDQNCj4+IC0t
LSBhL2FyY2gvYXJtL2NvbmZpZ3MvYXQ5MV9kdF9kZWZjb25maWcNCj4+ICsrKyBiL2FyY2gvYXJt
L2NvbmZpZ3MvYXQ5MV9kdF9kZWZjb25maWcNCj4+IEBAIC0xNyw4ICsxNyw2IEBAIENPTkZJR19T
T0NfU0FNOVg2MD15DQo+PiAgIyBDT05GSUdfQVRNRUxfQ0xPQ0tTT1VSQ0VfUElUIGlzIG5vdCBz
ZXQNCj4+ICBDT05GSUdfQUVBQkk9eQ0KPj4gIENPTkZJR19VQUNDRVNTX1dJVEhfTUVNQ1BZPXkN
Cj4+IC1DT05GSUdfWkJPT1RfUk9NX1RFWFQ9MHgwDQo+PiAtQ09ORklHX1pCT09UX1JPTV9CU1M9
MHgwDQo+PiAgQ09ORklHX0FSTV9BUFBFTkRFRF9EVEI9eQ0KPj4gIENPTkZJR19BUk1fQVRBR19E
VEJfQ09NUEFUPXkNCj4+ICBDT05GSUdfQ01ETElORT0iY29uc29sZT10dHlTMCwxMTUyMDAgaW5p
dHJkPTB4MjExMDAwMDAsMjUxNjU4MjQgcm9vdD0vZGV2L3JhbTAgcnciDQo+PiBAQCAtMzgsNiAr
MzYsOCBAQCBDT05GSUdfSVBfUE5QX0JPT1RQPXkNCj4+ICBDT05GSUdfSVBfUE5QX1JBUlA9eQ0K
Pj4gICMgQ09ORklHX0lORVRfRElBRyBpcyBub3Qgc2V0DQo+PiAgQ09ORklHX0lQVjZfU0lUXzZS
RD15DQo+PiArQ09ORklHX0NBTj15DQo+PiArQ09ORklHX0NBTl9BVDkxPXkNCj4+ICBDT05GSUdf
Q0ZHODAyMTE9eQ0KPj4gIENPTkZJR19NQUM4MDIxMT15DQo+PiAgQ09ORklHX0RFVlRNUEZTPXkN
Cj4+IEBAIC01OCw2ICs1OCw3IEBAIENPTkZJR19CTEtfREVWX1JBTT15DQo+PiAgQ09ORklHX0JM
S19ERVZfUkFNX0NPVU5UPTQNCj4+ICBDT05GSUdfQkxLX0RFVl9SQU1fU0laRT04MTkyDQo+PiAg
Q09ORklHX0FUTUVMX1NTQz15DQo+PiArQ09ORklHX0VFUFJPTV9BVDI0PW0NCj4+ICBDT05GSUdf
U0NTST15DQo+PiAgQ09ORklHX0JMS19ERVZfU0Q9eQ0KPj4gICMgQ09ORklHX1NDU0lfTE9XTEVW
RUwgaXMgbm90IHNldA0KPj4gQEAgLTkxLDcgKzkyLDYgQEAgQ09ORklHX1JUMjgwMFVTQl9VTktO
T1dOPXkNCj4+ICBDT05GSUdfUlRMODE4Nz1tDQo+PiAgQ09ORklHX1JUTDgxOTJDVT1tDQo+PiAg
IyBDT05GSUdfUlRMV0lGSV9ERUJVRyBpcyBub3Qgc2V0DQo+PiAtQ09ORklHX0lOUFVUX1BPTExE
RVY9eQ0KPj4gIENPTkZJR19JTlBVVF9KT1lERVY9eQ0KPj4gIENPTkZJR19JTlBVVF9FVkRFVj15
DQo+PiAgIyBDT05GSUdfS0VZQk9BUkRfQVRLQkQgaXMgbm90IHNldA0KPj4gQEAgLTExMSw4ICsx
MTEsOCBAQCBDT05GSUdfSTJDX0dQSU89eQ0KPj4gIENPTkZJR19TUEk9eQ0KPj4gIENPTkZJR19T
UElfQVRNRUw9eQ0KPj4gIENPTkZJR19TUElfQVRNRUxfUVVBRFNQST15DQo+PiArQ09ORklHX1BJ
TkNUUkxfTUNQMjNTMDg9bQ0KPj4gIENPTkZJR19QT1dFUl9SRVNFVD15DQo+PiAtIyBDT05GSUdf
UE9XRVJfUkVTRVRfQVQ5MV9TQU1BNUQyX1NIRFdDIGlzIG5vdCBzZXQNCj4+ICBDT05GSUdfUE9X
RVJfU1VQUExZPXkNCj4+ICAjIENPTkZJR19IV01PTiBpcyBub3Qgc2V0DQo+PiAgQ09ORklHX1dB
VENIRE9HPXkNCj4+IEBAIC0yMDgsNyArMjA4LDkgQEAgQ09ORklHX05MU19VVEY4PXkNCj4+ICBD
T05GSUdfQ1JZUFRPX0VDQj15DQo+PiAgQ09ORklHX0NSWVBUT19VU0VSX0FQSV9IQVNIPW0NCj4+
ICBDT05GSUdfQ1JZUFRPX1VTRVJfQVBJX1NLQ0lQSEVSPW0NCj4+IC0jIENPTkZJR19DUllQVE9f
SFcgaXMgbm90IHNldA0KPj4gK0NPTkZJR19DUllQVE9fREVWX0FUTUVMX0FFUz15DQo+PiArQ09O
RklHX0NSWVBUT19ERVZfQVRNRUxfVERFUz15DQo+PiArQ09ORklHX0NSWVBUT19ERVZfQVRNRUxf
U0hBPXkNCj4+ICBDT05GSUdfQ1JDX0NDSVRUPXkNCj4+ICBDT05GSUdfRk9OVFM9eQ0KPj4gIENP
TkZJR19GT05UXzh4OD15DQo+PiAtLQ0KPj4gMi43LjQNCj4+DQo+Pg0KPj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+IGxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0DQo+PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4+
IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbA0KPj4NCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fDQo+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwNCj4gDQoNCg==
