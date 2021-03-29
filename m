Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A88634C501
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhC2Hck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:32:40 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:16789 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhC2Hc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617003146; x=1648539146;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ltyj3TIqkZLYWXaW2I3es1Wp4lphAadFvsFKTH9FiPk=;
  b=RGHg6OEjIsj2/gfk30/EcQpMpKV8+/tmlGhcKhCfExFjbqBIWbGyzhHF
   EKzbaWkaHwJeXHHuAE4iaHwGXdzu1nQ1ZvFdSsj+gdHWi3EevfTO8BeOp
   vx3oyMy1SDcXBxT/MUMF0vh7VR77bRID+CUJYyawL2hZt9W8BfZfvJvJZ
   QBxwds/ulciu7oNs651j1/9wUCFF6auGDNlEFcFlw5V2x67TSRF6HEz66
   Aczq65oHioi1Dg6JxK3JZVgwIUUBLKd/SjxRpBYpeYOV8hqILVsdxcjS/
   cMbwo1P/UBV6TgCHelCr06Jwtgn+otCD/nUO7Qxmpz75SxmuhnxPpu+B3
   w==;
IronPort-SDR: QLl0Bej/y/bhAqciP6p3Fh2HdduivkKzctrd2jxMdN//GfMD9OvMJLAW90Yw+++R4dwb4NfX6O
 1t71NmUAoeg8YR8K9Zckw8yXk4COxhsTwystKnZxyadw0wtFtijK6/KPkwYLomBE3x1TEmNteI
 w6a4w/U1ewF8m7MQjDlgg0Q03JtSUbhTTvABAXzUoW9Jmp/iU52lQeN+JtnR6/oNaleWHe27kG
 QyYnkNvTM8fM8O/4TJH2yWA0NMzj+qwaMsN9CM2m7G+sBi/BeYQzJtY21ztJmxwYx6awL+AfC5
 0nE=
X-IronPort-AV: E=Sophos;i="5.81,287,1610434800"; 
   d="scan'208";a="108874562"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2021 00:32:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Mar 2021 00:32:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Mon, 29 Mar 2021 00:32:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q79kgET1ETH+dzblfpBnXQZqpAMUUwObQEKOh0Gphge11LYhPLYp+xCDvo3zI4AwMmryLR8F2neQjX61n56FpClKp3jDVVIAMCwRncGzXhNtHiHhrFGpg6zydLLNGC0JvTxjvIgPesiVb5Iil/zwuk6emZiiGnTKYaPQX2dteDH6EEXuyWFVfbMwVBgyUJB8yghxmRzoSKsyPRy5QJUbdSQSe+21oflw9jJOM9XgMfR5s1ir9xReBp1PduHi9wBrY01CKzLHbS3Ib1x1nuh4U8qaMWqwfBlMvnhD34bj8TUEBYmZQD0m0XmBYzyukoF7dQ07I817YCW+R9hVviEJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ltyj3TIqkZLYWXaW2I3es1Wp4lphAadFvsFKTH9FiPk=;
 b=U8ShhqgkVS1CZugftoMb4FCcJu2H12LRraIv8s89wf7KB9TGwPoTNKBL/lsh+IxeH7qUSRzCBT/DWdxRAxk1DdWeC0PZGRBCNY1Fpa9g7UDq/RDBKtYmYDk6TwCcCk9zvIrwLyaQTsQ6Ol445sBcICFLlcMx5obsbD79HAoEXEETxLXTTYBO47sXC4yxyRgQel1DhDjfJ3CAU3IIzgzGjWjDUz+nqmh8lZ6ZlzFytyGp6IIAlOIkI69sbEECmjjWG74yo7Pz2QtFlGxQ9VNasVje2QC/cjWkzBz8WNzrx/nm1K8tsYKb3HEpIccrLftxjcchWN/gjfGF0vDVAvh3Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ltyj3TIqkZLYWXaW2I3es1Wp4lphAadFvsFKTH9FiPk=;
 b=sFvnpVLlej1EDDpwUe4pc4UCblVif26/C1hPkgIzvO55nOxHva5blbBvhysc3L12gbCusRrmtz7cLdt8wj4kNhpKH3MePfajxq3ZLOhh7n4V4SZ9TO0BIdMkyXXUMhoEU4XVW/C5LngnmHryeEkPVdiakW4uoctgW54lA/kC2iM=
Received: from BYAPR11MB3254.namprd11.prod.outlook.com (2603:10b6:a03:7c::19)
 by BYAPR11MB3349.namprd11.prod.outlook.com (2603:10b6:a03:1c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Mon, 29 Mar
 2021 07:32:23 +0000
Received: from BYAPR11MB3254.namprd11.prod.outlook.com
 ([fe80::6c10:a3fe:3cd1:54c0]) by BYAPR11MB3254.namprd11.prod.outlook.com
 ([fe80::6c10:a3fe:3cd1:54c0%4]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 07:32:23 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>
CC:     <tiwai@suse.de>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <tiwai@suse.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 03/17] ASoC: atmel: atmel-i2s: remove useless
 initialization
Thread-Topic: [PATCH 03/17] ASoC: atmel: atmel-i2s: remove useless
 initialization
Thread-Index: AQHXIotfJjaQtIdyy0i/qfl+vQFbuKqaljiA
Date:   Mon, 29 Mar 2021 07:32:22 +0000
Message-ID: <bb884a72-84e3-0c63-9d19-35caa297ec45@microchip.com>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
 <20210326215927.936377-4-pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20210326215927.936377-4-pierre-louis.bossart@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [2a02:2f0a:c30f:e500:dfa8:d194:f437:67a8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c18ba33-8fe0-4476-d9a8-08d8f284cb1d
x-ms-traffictypediagnostic: BYAPR11MB3349:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB334968479B918581AB33B14FE77E9@BYAPR11MB3349.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jA65xsi36gro39mTK9KAXtAJQ7MLRAUobWw4mDsNjp5U7J2guCAXhQlm9dUrCkGwFbMlB30p/KmuCtEmgfsfHVf0A1iKQXJ28E5Kywfw1lEuoP6Y0WwdE95Azj+BVHDjZ0TyDpqnme9Gy5OBjMJ+8WLKnJtycbtfFJ1TIWtNlm6xYaEu0ejt00eXuIQ9dI2VpGsa9lYA+C6pliVTKSxEu+YgUmgAFzfHvKBtEiYCCqeWPMAc7CXCvmxrywpUMPaWyy0Sa8f9L1GUk5zi/Z1rMldr8+Et63JccWWxHpdvrJxGXaX2ZrpwbPs/FoL+efd0jL+U0ZUfY8OewrnAs7lC51ASfxXdw5DnG8+DmfImFLeRwzSwxbC5v0utr30kEgWvFtO900DtKIBuYwbz9SIWODsJOMhkCdyPnryhHc3ujaw371QMbTt5GDSoYkEjKAdPZmwcKFZd0Idq4oEqz0svfKwq8d8uGDuTfFdFHOVOk9nh94Jw5SRwMvC54N2HM0fGhlUCiiGAnSAw4Wf7DlMCa08PaJ0PX4vcq7Ct9uM6/ui5G8oqGwbaiVXHs9l/X9r0mmN1UOAR57I0DHK4VTDJUsUKQhWWsVnrDjqyV7o1btHceLcpcWYRK5THBEs+H+IV52s1LbJ7CUb8v2vjXDG6Z7+OSiqmIom5gJj8/j8j10OGQzavhMKkyV8Ju7pIEnFPX3IkDuAZxguiqtIOZoW7NObIvzXcjjFrwBHXsQZMI2A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3254.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(136003)(396003)(39860400002)(66476007)(110136005)(4326008)(64756008)(7416002)(6512007)(31686004)(8936002)(76116006)(91956017)(66946007)(54906003)(31696002)(478600001)(4744005)(5660300002)(2906002)(38100700001)(86362001)(36756003)(71200400001)(6486002)(53546011)(8676002)(83380400001)(66556008)(186003)(66446008)(2616005)(316002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RXBJb3B1NHlycWczTzRsdU50Nk5Td0JoNHFWM3pwZG9ydDBWT3QrNllMRTRh?=
 =?utf-8?B?S3dxZVA2RWs2NExlbEpSTXRacDZRczd5NkMvdzByU2hyUlhZMmJqTE5xZnpp?=
 =?utf-8?B?RVFSZWpzQ25LejYwNklHZ0JXSkd5M0JKaFlmSHJMN08rK3ZtaDRuU2d3WXBD?=
 =?utf-8?B?c214YzQyY0w4QjhvYjcvSFc4Nkx0em9rZGN2NXA2OG50c3B4OUpzbFo0Qm5o?=
 =?utf-8?B?b200Y0YyVFRXUzQ2NzJFdjYvNHVTRUlPbUp5clNvL0paWGZGQjQzRXhQVWUy?=
 =?utf-8?B?NHJ6M3FpRGpNT21VejlhUktqakR4ZFNNU0IrUVVlWW5rYStBb2d3UWpYdWVZ?=
 =?utf-8?B?Ly9LNlo1MVpuK3pDampsRWROUEdEMzFwaFFOZUdnQ2RYdzhFWkYvNXlqZmFo?=
 =?utf-8?B?Q1A1UVRzRUkzWTZab00vVWNIVjRFM0VVaGFKZDVtUFIwbS9NcmY3bkg0aFVS?=
 =?utf-8?B?SjljUXdKYmtPL1p1YXBibUdOUHVEaUNwZVJtbGd4NDMra3NjZ1ZTbFZncTh6?=
 =?utf-8?B?enNiMkJZM041eURxaXVURFJNTHZYYkx2RVdhQU5uQTVMZ1hyZ3Z2N2o5emJJ?=
 =?utf-8?B?THo5aW43RlRlZGFlL002MDNBdEdRTmtUVVNxcFFGYjkxbnA2SnRJVW9haGpi?=
 =?utf-8?B?dHJOb3czQ25UTkN0ZFFTdlI2bVhsMUsrWStJVi9qeDAvVWNmanNsdk9TNFMw?=
 =?utf-8?B?blQ3VUdQQlY5TjJUZ25URXJ2aWtpdHY5Y3pJZGM3ZkY1VHQya0VhN1djVzdO?=
 =?utf-8?B?SXp5UDVZNWhlZlhUdHIvR2phZFlZRDlqdDBWUi8wSkxUcGJRdmgwdUY0VGZv?=
 =?utf-8?B?QWFEOWZwUWVJbVJNMDBSOUhiUEJOendEYnNQeEpSNXBWbXhyU3dHTlRqemhR?=
 =?utf-8?B?V05nZkVIMnBGdzRNWHpSSXYxMVpYdHBoOTJTaldGeklQSGM0ZGRGTlJIajZZ?=
 =?utf-8?B?YTBtcll1dXdCbXVDbUhPWit5dm5mbGtEMnczcVRVYUQzWGZJWEdQMGg2Nmgy?=
 =?utf-8?B?RHFXVU5naEdjeVFqSEtnelhaak13bUNtWTN4U1BaSi9UR3RuSzlxcW91YXMy?=
 =?utf-8?B?ay93dUlmTlNBazd0SkVYSGpjNEsxVTR5WnJVS2NpUGxzYzJDaDl3a081TUZC?=
 =?utf-8?B?di9lNnNIY2JpVm1GVTBkZ0dFcWt3dlArOHhxK2w5MklBVHpDRWYxQUU4R2xX?=
 =?utf-8?B?Q3JweGpXUXpXRXROQXhMUmF5QlFaRGNyNnRrR3BhNU9WOXcxTHBZSGJuUTdi?=
 =?utf-8?B?Z0NQbkk4aFVGS0RwYjM0Yi9ZTTZneXJsblI1YzdXOHE3eUVxTmpGOURZKzBD?=
 =?utf-8?B?M25ING1sR2FtUVJGRW9oU1pUdW5HWDB4cWg2b1RKWkpnWjNLd0g1WmdLV1l1?=
 =?utf-8?B?RllnQm9Lbjc5U2NoSzJwTXJBTnIydzdxVWxYdjhqd0tpWE5WeldBVkI0d0pI?=
 =?utf-8?B?RFltNFVtMmplYUE5WWxJSC9uUkloKzhEaWMwT0kyTm1ibWNlVVJBaUVKdHM1?=
 =?utf-8?B?RnhOcSszd0VNL0h5UkZBeE9jSE56NkpZdlUxVGtzV2NWOHljcnUyODBEa3Rr?=
 =?utf-8?B?NmF1NC95UUJQMTZrY3M2eVNLc0RXNm9vTTJ5ZnlUT2tYcyt5Z0liRWFwQlBo?=
 =?utf-8?B?Y0YrcnUzOWwzcm5MTkREVFE3YWdGWWNnemFjbS9kRGx6U1FENjVmUnFPOW8w?=
 =?utf-8?B?ekJWSzFnNEs3WmVYOFkwOThPcEZFSE1uNlMvNms3d2JhYlI0S0FlWjlvdExu?=
 =?utf-8?B?UjdJZEdaLzZCeDVkSEpZcjVpdC9ITE43c21pTnNld2xwZUMvVXQycTlKVGsy?=
 =?utf-8?Q?Zlhz794T9GfbALsEbaqpDHkp3hEyQhzkBeUrg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7E95C59DA14114686F0776A8C37B031@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3254.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c18ba33-8fe0-4476-d9a8-08d8f284cb1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 07:32:22.9191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EXYMBEBdFbqQSr6C+DH8ayTCuEZvKxRUjViNdhFW2PHDC6jZiPU+xYtjeY+67vzXu6Xc0R6gSE/Win6ia6TBm+Iz1Sxf3kEvjlNl05W8ZYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3349
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYuMDMuMjAyMSAyMzo1OSwgUGllcnJlLUxvdWlzIEJvc3NhcnQgd3JvdGU6DQo+IEVYVEVS
TkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQ3BwY2hlY2sgY29tcGxhaW5zOg0K
PiANCj4gc291bmQvc29jL2F0bWVsL2F0bWVsLWkycy5jOjYyODo2OiBzdHlsZTogUmVkdW5kYW50
IGluaXRpYWxpemF0aW9uIGZvciAnZXJyJy4gVGhlIGluaXRpYWxpemVkIHZhbHVlIGlzIG92ZXJ3
cml0dGVuIGJlZm9yZSBpdCBpcyByZWFkLiBbcmVkdW5kYW50SW5pdGlhbGl6YXRpb25dDQo+ICAg
ZXJyID0gZGV2bV9yZXF1ZXN0X2lycSgmcGRldi0+ZGV2LCBpcnEsIGF0bWVsX2kyc19pbnRlcnJ1
cHQsIDAsDQo+ICAgICAgIF4NCj4gc291bmQvc29jL2F0bWVsL2F0bWVsLWkycy5jOjU5ODoxMDog
bm90ZTogZXJyIGlzIGluaXRpYWxpemVkDQo+ICAgaW50IGVyciA9IC1FTlhJTzsNCj4gICAgICAg
ICAgIF4NCj4gc291bmQvc29jL2F0bWVsL2F0bWVsLWkycy5jOjYyODo2OiBub3RlOiBlcnIgaXMg
b3ZlcndyaXR0ZW4NCj4gICBlcnIgPSBkZXZtX3JlcXVlc3RfaXJxKCZwZGV2LT5kZXYsIGlycSwg
YXRtZWxfaTJzX2ludGVycnVwdCwgMCwNCj4gICAgICAgXg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
UGllcnJlLUxvdWlzIEJvc3NhcnQgPHBpZXJyZS1sb3Vpcy5ib3NzYXJ0QGxpbnV4LmludGVsLmNv
bT4NCg0KUmV2aWV3ZWQtYnk6IENvZHJpbiBDaXVib3Rhcml1IDxjb2RyaW4uY2l1Ym90YXJpdUBt
aWNyb2NoaXAuY29tPg0KDQpUaGFua3MhDQo=
