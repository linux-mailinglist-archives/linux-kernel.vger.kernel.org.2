Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D87537F8F5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 15:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbhEMNn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 09:43:29 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:18024 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbhEMNn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 09:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1620913338; x=1652449338;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=41ffHXe3fy4OSvKtQaF/Gg+iX0dxGFLSUCL+S9ONN2E=;
  b=2gtgauHs1PeptYrtbnEq2CKacx9Yr5wKhOODiLVf9J+mK6+7Ssjm0o3I
   Yq26EDgm3qROp9XUZz7NewWm3T2qd9CFFkHhCuOt5vfGeAzXaeoqdI5PD
   PhfqIzuMfFRGt+/UPQkLAj2fVpWqX0Gv+w9cdoHe3Zp7r15a4/mc868kj
   KFOgr4CJlHe+yY8oEQX9qbVGsmJeWAKDiijFAM3obcJ732dZg8qfp7u+U
   /pEDvbBk9gFRuUD1o7DvKtDYSOH5mYWpR9rZvvldKytNiHNyPye5QeLss
   Wv0+2OHPRpsS2LBvQvXUkCt6bT0bMm27CoRa3riwULDS4p+oko6vMoDuh
   A==;
IronPort-SDR: /MyyhhVwFgFeFaqqZ4l/nTUaghIRaoL8+bHr/hUrLC+6Bhv0sbzCZb60+lMhcgzktvDrI5poGj
 kgieQpddjpk75KDzYJsE3+RNY67HslWTPxKDlRwHgo6xD6L5ruBQWCQaV7x8Y83ooAepNl4QmX
 t6VxfsUeIWHLBVBwau1E+Ybc/BIRjvi7RwXrb2cXi26fWMiZWYUOBBQkUx7dfmDDCNZCh/psnN
 Mzr1ustcX4ogtKWcsNilwQkrCprwYkuVKWQ0fVp58ImXnlpxJpYjga/pVHO/g6e/U5YZKvmNWM
 qlw=
X-IronPort-AV: E=Sophos;i="5.82,296,1613458800"; 
   d="scan'208";a="55445327"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2021 06:42:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 13 May 2021 06:42:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Thu, 13 May 2021 06:42:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UH3d+3NvlimGEZIVXdBF1mkMYvZJIsqWTauWIbafdQDcQrKR2Nw0msUKH/2osM/nRheScXvzSysk+vV31z6gwawBwr8o7o3lBsw1LTYsR8bcj1fYhOMCNG6KPNBve4izd502UslU2KK8QAEQr93cFnRiBCenICvkhfY4meP1C8NF35PqfKJYZ5SVBKTBYsCkBfHn9TUQoWoFa3GwkajhlrEU/i97GNguijuRkY4Hu0OAI+B9hn/R0AWv93qz9Hur1xdoJ5WwtSuOefal7ZDMVmG5vZM+Mc/ZJ8W1Ve6ZEgDvDZP1cpq0yFzvobynl1eXMo++c+n5ONZkFCwc79bFCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41ffHXe3fy4OSvKtQaF/Gg+iX0dxGFLSUCL+S9ONN2E=;
 b=VmicrSnawBA9uLEJqLPVM+guAvbOa1082VjnUuqphDA6gbXxAcya7utq41dTXgLDaiEf4G4/gQUHX7PSYR3AhB1b5voDvW4FXr0GmG9zSOBVos6ZCavJBCdZ9bkAtFymPiIXiOZhWD505iFxk6ub0b53CwHKbXI7QMHFe1O0KkvDajgOtiBUszJnW+tBERcdKz0hJwsf4mSQ/9wf2QTXPpswRypivRvECFkGHchlef55ae1gh7dATIL1gYFeahLLWYv13EsnrhnzPFHgugx37b1sXDHhCkvBAC+w3hXRMfNMEW8VQ3fgpP+y6vdYHqSlB9U/GAbfhnmt3oiY0Hp+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41ffHXe3fy4OSvKtQaF/Gg+iX0dxGFLSUCL+S9ONN2E=;
 b=gr2e1WWhMzXNw9Qldp+TYxc8N5y1XZuGYR0BLCPe7A0j6U1xa1XaVkysRfFwlsViB1DN+Y6KBAJ/lsxnMHzUanunuauVnU9u/Uk48f/zcuRVCsZvk5hgCJ9Z7ocJkGaJTcd5kUP2cO/TWSbnEENm2X/tYUDROhMFUOg7Ajy9amk=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MWHPR1101MB2079.namprd11.prod.outlook.com (2603:10b6:301:50::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 13 May
 2021 13:42:13 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1c4:1014:a541:e370]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1c4:1014:a541:e370%4]) with mapi id 15.20.4108.031; Thu, 13 May 2021
 13:42:13 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Eugen.Hristev@microchip.com>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Codrin.Ciubotariu@microchip.com>
Subject: Re: [PATCH v3 2/4] ARM: dts: at91: add sama7g5 SoC DT and sama7g5-ek
Thread-Topic: [PATCH v3 2/4] ARM: dts: at91: add sama7g5 SoC DT and sama7g5-ek
Thread-Index: AQHXR/3HL6I3+ZZzaEmk5Vx1ejjgwQ==
Date:   Thu, 13 May 2021 13:42:13 +0000
Message-ID: <e68afc06-4ad9-9feb-8082-94f4ed7245da@microchip.com>
References: <20210513061354.138158-1-eugen.hristev@microchip.com>
 <20210513061354.138158-2-eugen.hristev@microchip.com>
In-Reply-To: <20210513061354.138158-2-eugen.hristev@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [79.115.63.165]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33408e43-7db2-4043-5c33-08d91614ea6f
x-ms-traffictypediagnostic: MWHPR1101MB2079:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2079648BFD74E9BD00610ECBF0519@MWHPR1101MB2079.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TC0+sMQ0kxbDeGH3RDmKuhn8WyFDgqLBFS5r07wy0q/dtk51UCXUziQG9w9k3znYi1p/UD3+zqyJPZNXOPdKtkK8P3BFfpdcRSKSyK9uRqkmKiNlHgtN7HEVygNygYFJJHwZTsyjQ1Z6Ym3p7kJwJ/g+ol3FocoB7IGsDf1XVwQG7ZQWa0Mfvwr2EnPGWzx2gbwgRDGahUWiP7HOk7e011ayo0u8TFtrxXiHNb1M+vo1ltR+ka4zrVN7J/pyHos0oWhoQDF8jTY/Tqej8otEKFoXzyMNIyPBkka/WYpUY3PiS/zmLZQit8Z5ZwalWV59oct8rahfw3mWxkJAl8v+5IBVZBsSH6WtP27GB7zWFM2tTEB3WN2zS5jv80LgNNrNUrxHdsEZOwyWmukJEYJCQgYEBQ1RAXpTlabeEPvXiXjhxIabpC73XU0z2/umyH9Z/SPax3Oa0IOj2i3/Qz9d+zwShsn0do2J9avx462hrjc6UINXPhjngkVNUOiZ5vvoyG2tH5L1Y4C8JkP2UjcGVcwZikW1LfXx+jIqib8uhbLaMctfsfNYcgbLkEOBwjaRXRM+fibXuYHaHE3L5NJskDL8+MVw/egG5jei4urmdAl8FiAbpK/lOSENm23kKe/5ehyXq1IZSdQRUCwRvu7VCjJZmfcUbDBO0N3LWXAa6fuCbqd4yeC+prJTVECswui1+yzwnDcvboi2BoZR13bFKlTf+YNNKQggu5qugs/FqDjy0fO+GToEV9emAD9HPgCZaMTydLjSZ3PuyUrxiJAsPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(396003)(366004)(346002)(376002)(5660300002)(316002)(8936002)(6512007)(110136005)(26005)(8676002)(107886003)(6486002)(76116006)(54906003)(186003)(4326008)(64756008)(36756003)(2616005)(66946007)(6506007)(122000001)(478600001)(6636002)(38100700002)(86362001)(71200400001)(66446008)(2906002)(66556008)(31686004)(4744005)(31696002)(66476007)(91956017)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WHkxZzQ3VG9rOUNVTjhBa0NiVzRDOEtRSFhxcE5MZ2E4dUdPcHE5amJNRy9Y?=
 =?utf-8?B?RVhwMGZrZWRYc2lCOS9DRFJwUWVnSmczU05xWjZ1MThlZEdGNnhjc2ZyRldE?=
 =?utf-8?B?a1phYitqcVVoVkEyTVVjYi9qaXBCT0ZoVGFxVG9RY3J6ZWJMeHIwL2QwTHlu?=
 =?utf-8?B?R3dBSWNaQ1RmK3ZVTlVnU3JyRzNudm9jQUVJdmRreVdlWVg5VlFnZnJoOFhy?=
 =?utf-8?B?T2hQRzVPT2FQN1RRUnJkN1ZFVVZab2ZWKzBZVXp1TmpUM0VUK3RQUjI1RjRj?=
 =?utf-8?B?SzRGWVNxdE9GTGZuN01qTkszd2NoRDZmZkFKVHYreUE5NVh5WkN0cXpTeGR4?=
 =?utf-8?B?OGZmUzQ1dkNxaWVXWXdaU3ZmM1dsMnpDR011L3dxTG1TOU1yak1uU0dHSTh3?=
 =?utf-8?B?N3RIUkxzRVFDbC9IaUZJVDdBZXJrQkpER3pnT1d1NGFyZkU3VHBaUlc0Y2tE?=
 =?utf-8?B?ajJodURoN0txSElUbG5tNlp2dnN2STRlVkJmeXRUSE05UktDaHJtSE1jQmhZ?=
 =?utf-8?B?WFdLYlc3OVdGQUxUdVJscVBpNWRtbkxjYmltOGpKS0JFVFFwREdJVlY1K0xi?=
 =?utf-8?B?bUtXc2svdVplNjB4cDhGYUVteTA2Q2ZUVWdOS3dqeHJ3UDRiK0lCUmlhZUpX?=
 =?utf-8?B?NXUxcmdLY3lyT3lyVUMzQkc3UEZXR3Z5QWc4eVBhUnphSDl4RFNTVmFSazE5?=
 =?utf-8?B?aCthWGdzNzhYMXB3NzUrWFBVUjhXK084cm1TcUE3ZzJhR1dhVk1kZ09zSldO?=
 =?utf-8?B?VHpZVWNId2FXYkdzenNEcE1oZHArSWpVaFYwcEVySzBURExqak9jL2Y3T1FD?=
 =?utf-8?B?bXlmWUorWVVFbTRrNHlQZDBaVnRnYU1HMCtIUUpNY2VnRzNITjFac2U2MGVa?=
 =?utf-8?B?S3pFV2NzVHBNRytBMUY1NmkrMmlGOTh4b2hNd3YxM1ViVzRVMjF0YldWUVUv?=
 =?utf-8?B?UHVkZ3JCMnl5dTM0UlNUYlB5L0I3Vm9POGFDYlltenZqR0RXSVV1ZkRvV0VO?=
 =?utf-8?B?Z3VLd1ZxR1VZRHk0clovUm5zblZKVkNIY3VBVFN2L1JodlNVNTZOTUZVTmxj?=
 =?utf-8?B?UU11MHZrZ2hEWjA0dVhyWXAySVUwRkxqV3dUd3gvUE9Tb0pzbDhaTDR4Sis2?=
 =?utf-8?B?UStZZ1B5cWROM1c2eWFHMGl3UCsvL2FUTzBzdFZQVEZDTkJ5TzdianRTcnU5?=
 =?utf-8?B?RXJzUFBjcGk3S3Z2OVVzSi9BSEhKNWxHM0NRREhHbmZHMmUrOE80QjhVTnF0?=
 =?utf-8?B?Q2o2b083V09Sajh2b0FsUE5LZjRIMnExbWlCajZRUnk2cHNZeGVKZ2IzV1Yr?=
 =?utf-8?B?Nk5sMHJuTWJDbkdnOWZYQ0FXMEhocDd3U2Y3NERsS3A3QzNJOFI5OTlOVm44?=
 =?utf-8?B?T3lOUEQvczdQN1RoQ0hEOE11N2FTY04xWlVzVkttRHZVT2RadklIdExMZ3M1?=
 =?utf-8?B?alpjRDV4OFJVVC9CRWhmV0h3NlhWQWh0NkJxbjVDdWtFZm5ob3ZNZ1lSam1F?=
 =?utf-8?B?VllwQWJFaTVzQmFIT1FjTGdoNzBuUUhtMDhMSklqQS9tQVpOamNmc2dLbGNY?=
 =?utf-8?B?WXJiVVpuNUlaNjZyK0pZU0ZxL3djeG01NGtoc0xRVXRlRDlXRmdsb0poUjVY?=
 =?utf-8?B?RGVSSSthK2NaZjIxMDVYZ0JwYUVldTR5UDJMTjUvZjBVbnAxcFhHRURlUkt1?=
 =?utf-8?B?U3gyWDZRdGxibU55djMzVHgxcnRsaEJPSDdpVGZ3ZFBBM1hXZmtQOEVFWm1a?=
 =?utf-8?Q?fCXGRaxJPwCTwaTHcA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <104ACE54BF0BD64A85B5F2A0724E44D4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33408e43-7db2-4043-5c33-08d91614ea6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 13:42:13.6147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KUcnmzZx1a5jo4sAOLzNnbe3mutN/SyJtGNCnqhIetB2NtDl96KSUn3z7pdFL4/glDUWyDDH92CRlsLg8Dg9/lN66KUW//WV6xPWmRFEAnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Y3V0DQoNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTdnNWVrLmR0
cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTdnNWVrLmR0cw0KPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLmQ3MWMzMjI0YTBmOQ0KPiAtLS0gL2Rldi9u
dWxsDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTdnNWVrLmR0cw0KPiBAQCAt
MCwwICsxLDcwNSBAQA0KDQpjdXQNCg0KPiArJmZseDExIHsNCj4gKyAgICAgICBhdG1lbCxmbGV4
Y29tLW1vZGUgPSA8QVRNRUxfRkxFWENPTV9NT0RFX1NQST47DQo+ICsgICAgICAgc3RhdHVzID0g
Im9rYXkiOw0KPiArDQo+ICsgICAgICAgc3BpMDogc3BpQDQwMCB7DQo+ICsgICAgICAgICAgICAg
ICBjb21wYXRpYmxlID0gImF0bWVsLGF0OTFybTkyMDAtc3BpIjsNCg0KVGhlIHNwaSBmdW5jdGlv
biBmb3IgZmx4MTEgc2hvdWxkIGJlIGRlc2NyaWJlZCBpbiB0aGUgU29DIGR0LiBZb3UgbWF5IGNo
ZWNrDQp3aGF0IEkgZGlkIGF0Og0KaHR0cHM6Ly93d3cubWFpbC1hcmNoaXZlLmNvbS9saW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnL21zZzIxNTkwMzcuaHRtbA0KDQpDaGVlcnMsDQp0YQ0K
