Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F0335139A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhDAK2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:28:44 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:36072 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbhDAK2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617272890; x=1648808890;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+551L8W2JvarfFF+Pi8Z3xpM08QqQi77QOEGtRKCgRA=;
  b=wfTM0GCGBzV0Tro/yHXSY/5HDZPU0nS7vICes6fU0xmNHRsfwliB5Qpj
   yjayYEm/1OXkHPufV5K4BWOTq3AzYQEs9vT74GKO5bvz8b3kItLKh9EAz
   nZq6KVoPyRr1PQt63F0RL94re1ZV7UzxVDd1MkdYJUaJXtAf55sWlYy8n
   ruwvECe25xu/pMGU3NNK7g4KAqbNkisqyWrTvL/bR9WuU/GTVzqHWs+A9
   UqmMECOmWgjfS7xLzNGj+SF7BUOP2pHhhqokEhEOKssud/F/5w1sEsa/f
   FwxQpNw5eUZqi4LRf8R+nNSjU3plPhmBxGkJs9EbnjfBDoO/DlJJU2l2U
   Q==;
IronPort-SDR: Q9WlZLopP1axawl3XtsYZC/2v/XdwU37eq5lVf8lQT6RCYM5dJHAstVu3sulHljkCnEicjBcVj
 zT2Wh+w48WuauAXfWXmk4OgMK3FRF9JQl/NAM7j9s7qETB1cLuYnm1ute9sKOyp/0nZJbeijun
 ecOOoNopBd2VlU4rUxu0/piyUrgJaKMvvRD7JDkZz4BMuICGGRCrYKaXAZivbjkpxvsvzRDiK0
 Wm1E3nRn8OqQwGw5Ni1Xqbli3jOH/k9l//VQXH4PmwAOVCsZyyMaSAGF8BiP2h80cv6M8pQzFj
 TUQ=
X-IronPort-AV: E=Sophos;i="5.81,296,1610434800"; 
   d="scan'208";a="115489144"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Apr 2021 03:25:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 03:25:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Thu, 1 Apr 2021 03:25:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPM9OshjmUY550w4puWPvQv6ze/0i3KGxNz4kkci/elzpAg5wHYDgKN8mkjjO4vk73a3rBck0+TlXipbxnpRswNjjKjxS+tY7kevbW+90Sai+z1jFkmpq13IGRIBmpKNn+lGMWgdII6T8V7Gp07zn/7kpZyFZT/eeUkED4nWAlncAsxqakK6Wqmkzgn4Es3tmpRQJRWIzIoJRHBqNiY1Dbl5zMzj8aXkn566LA16ni6fHmG2/zJH0uJRn8JLuBOHSGvOlMsTcK3PE40TrgFXMIWWC8zoQwwc/AhpVPCgR9jTeSW1rwWjVt2/r972gck3Du65jpfF1wyK0BmnrqzWug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+551L8W2JvarfFF+Pi8Z3xpM08QqQi77QOEGtRKCgRA=;
 b=i1E+rElnB9lBMjNSjauhCNfQqXUQO3A+RsRL37mL3F0JoGSwCgwoKpEmlRsqLNLtX9SiQsp75Jr8w4S9Wp8WcpEPx8LhcMfJ4KQ9b0kw189TdJoOwVTZWnURZ0v6WtK2IVcHa4NZAsix/1x6T0La8zqaBMWSlw18nGxuTDd4VTiMMuDaJie+wwOpi3KeAZTV0x77ppfYpCJOUU+3/US+hn1nHS82zhdeBO1nhKO8Em183XWSEC/UaZT+eedd/ueRyI32nrb69ab+P8MN/rPqUibz3cPS7y0yyY6qufVI8hhxGztq7WJG95+CB1pTeSM2IjiAfYQ3tIYnCJcMLBr6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+551L8W2JvarfFF+Pi8Z3xpM08QqQi77QOEGtRKCgRA=;
 b=bKE5NSY12KskEWfdDRWchrIlI+IKy9VYv4RWVvVMGUB2zSS7/3HQ8cSNcsBY5qLgDj+vsc/6jw/2InX81OKlp0WIA4najeHH9yFuTBPHBrzO8lbBLKmVe7fzG89f9mJKQl+vSqpwFAj2fHJWBPMaPhTL/xZV3tR2GRjP2m/cA7M=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB3515.namprd11.prod.outlook.com (2603:10b6:5:6c::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.30; Thu, 1 Apr 2021 10:24:57 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::d405:a5f2:bb71:38d7]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::d405:a5f2:bb71:38d7%2]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 10:24:57 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <robh+dt@kernel.org>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Eugen.Hristev@microchip.com>
Subject: Re: [PATCH 22/24] ARM: at91: sama7: introduce sama7 SoC family
Thread-Topic: [PATCH 22/24] ARM: at91: sama7: introduce sama7 SoC family
Thread-Index: AQHXJtrVVYAy3lPKIkuJ1UvS6Ea1/aqfdM8A
Date:   Thu, 1 Apr 2021 10:24:57 +0000
Message-ID: <21bd4417-a754-8ee6-370e-4fb4e0f1fef9@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
 <20210331105908.23027-23-claudiu.beznea@microchip.com>
 <YGSc1L8yW0KniOsx@piout.net>
 <a908274a-c4d2-faab-54a4-31fd0ffeab7e@microchip.com>
In-Reply-To: <a908274a-c4d2-faab-54a4-31fd0ffeab7e@microchip.com>
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
x-ms-office365-filtering-correlation-id: f9062bdc-83b9-4ba2-9504-08d8f4f8661c
x-ms-traffictypediagnostic: DM6PR11MB3515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3515CB55CC7F9EF2190213E3877B9@DM6PR11MB3515.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iBfIe76uSZ7pAYYIF1jrgqDcGgCSPKPNoPAqMKZZWYNOnNfGn5bdCPfTONv9+jO6fUYAGPzv9TtLC1y2JuVH5BqVtmHeP/SXNyoDhB5yKiYy5PE9xf1Ypmyzm8m1C3pipcBLxWiOujGNVy59Z6xf1M5vpftS5MQ0OwtUoLTtnsWamR+iLlvzfUsUarwyplYynpinvIN5RRC6mJ8VmoW6TIUeny3bmgDc9bAHQ4ufLt9kbX/PdzGZVxo2GDoTkLFJwGAj/Q/2UUEtYvbpjFAG0kIP313fCrkaxdIO5lwO5n293fdwCUADb+h+fxZ/LUwBeG1ItIFI9eEeRZ4HGQvHs+kegbhk8NhpaJ8k87k2RI/cGlp6gzqMY4RmDOjtOHGR488bgeDN7Pz2BWR3ziCKKFWNgvHGrrelTFtCmXHOX7OipXWKIiF5guJYp5RQo9raLAedr19ads7au4Gf7qaZLIXpLVW/takP7V10DxBkOVnQQdChpdQXk1bS/stVZplkDkz2Q5BlCUypLM1HuQG/oOph9zhQMLgtvQ7GgUfEQzIjo3pw/07Q/aWhdK0uWtgZYGNBVDjSDQ6gcHTEe2UPkoIwnHHjNovevLn3HbweVWAY4ooBKrLavWu6hw1czyZMTEgVF9Cr4pvvcCvCLbNqkaf/PWIBY0deIdmQQHhgiedXpeqmthQOboC+AJ1FgP+jgbntmLmvOsCK2UVOxM58QTLjpc6Mm1JKVJDrii0JNBlbWO320sd3co4CAKwTYG6efPIHwkRlp8ILvZRiG7doF6OcaGuqUYdFaaGPFPf/MgU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39860400002)(376002)(366004)(396003)(186003)(26005)(31696002)(6512007)(36756003)(83380400001)(86362001)(8676002)(71200400001)(478600001)(66476007)(66556008)(8936002)(64756008)(66446008)(4326008)(54906003)(316002)(6916009)(5660300002)(2906002)(91956017)(966005)(76116006)(66946007)(38100700001)(6486002)(2616005)(31686004)(107886003)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cFRlTUFjZjhIS2xLektGd3ozNGwxaHpDTkRaNG8waS8wU2owdms0enRRWDZm?=
 =?utf-8?B?aWxIRHA5ME52TWNRSGZ2MDR5VTF3VjNhWTJLNmVwRkdPRmlxelB1ak5SWjlQ?=
 =?utf-8?B?SEtNUEJNZ0xLRXpCZGtMRVA4WUtaVTlSZXZJNzVXelhxZ3hESEZEYXNhSnZL?=
 =?utf-8?B?c2JKcGZXYWlUczVreGNraXMyd0JIMDBwV2k5TEZUQWdDUTdJVUthcFpiYVE3?=
 =?utf-8?B?UG1hOHFUcUNqV2hsMlUwZ2xnZllTVXdKdjNISFlCak93VGZ1eWZ5RkdSd3Zq?=
 =?utf-8?B?cnowd29XdmZIRzVZVEh0QkxraUxidFJOc1ZFdGcva2tydnp3ZE1ZbjBCbzkx?=
 =?utf-8?B?ZXd3OHZWTkEwdFVKVDJYOTVFaDBCRE1ndlRDWVFmZWpOcG43WVNKTThrenp5?=
 =?utf-8?B?Z2JocEpHbGl4aDhRUzB1bjE2QVJhUkNtNHFqZ0libUdoUjZrVEJrZHlQNXZl?=
 =?utf-8?B?SjNFZnJyWFF0a3M3ZVBEZGZuZzZ5c2JVemN3K2F6cnJ1OEhQL01mYjVaTWZY?=
 =?utf-8?B?bmpoZFBmNlphVElxYjMyaW9YMS9JWkhkViswK0M4blhCOWJjVzVMdTkyS0lo?=
 =?utf-8?B?V0hCVFNSY1ZHUDNuTXdKYmFFaVVMNDgvMXJiVHRwbTQzTEZsUk81Y0NuQ1hs?=
 =?utf-8?B?a1FQTVJrMm5RQWlQZ0RITXF1ai9nUHFwMlR3VlU0cjcvWExQRTNMSWh6c2Fu?=
 =?utf-8?B?UkU3cUpHbFJnVGkreGl4ZnR2TWovZEF5MDc2NFZvMGorZ3VwbDBiVXhYbWJ5?=
 =?utf-8?B?OThicXJreit5MnVneEQzY1k4MnowMm9hK0lNV1ZtRXZ5ZDVYRlMxWk9WTEVw?=
 =?utf-8?B?QWQ0TzdNSXdEUE52Si9DUGJzdUM3aW5vcnRsVUdBa2txRFVYRTIzSU5vUWpZ?=
 =?utf-8?B?K2JlRVo5dk14cGd1czVUbzRHbmtudzMyZXhyU3Q2RGF6VVNhY0pKWVhZTVNn?=
 =?utf-8?B?QXR5aHhvdlUxbllNaW9KRjdCVGRRUVVnM3NCRXQwSFhzY0xRODk5TGdJazNs?=
 =?utf-8?B?aVZNTkRIcjVQVWlqOFBPT0ZnNVN6a3VZWGl5bnpHNVkyUmZSZmZYLzhzTjJP?=
 =?utf-8?B?OGQ5SGNiYnZsQ3hRVkQ1NGdGdlBlTHArUE14eFpUQjBNVVp5aEtJNUxqcWRy?=
 =?utf-8?B?VjJnUE1ieWRqcUhYclVXNHUrWWRRNW1FWTBjNGtjUkVoNFRBTjdLT2w5ckk4?=
 =?utf-8?B?Z240dm9ROHZVcldEbkNzTSt3eFo0ZTVpeS9tc2huSU94SjVBRWM5V3FoR1Rx?=
 =?utf-8?B?MHRNZmM3Z0FteVF0NWNSRmlIM1ROM2VEQUZINTNNM0JKOU01R2c3NTBCWEtu?=
 =?utf-8?B?ajhJcncvanNpL290WmdXTjJvUGpXczQ0eUl0WHAvSENwcE9LVTlHRDViVnR0?=
 =?utf-8?B?czVVQWVrekxGZDdUZ1g1M0hBR3c2WFVHTFk3bGxFR0djZDNUK1JzSCtVWkN1?=
 =?utf-8?B?a0g2eUl1bktUeUNkZzd3WW03Y1J3K2FkajFSOVBGVTlhU3dISW5XSjUybW5H?=
 =?utf-8?B?RmlhTFEyNHd0ckhzbEhpTlhpNFF1d1F5cHZkWVVoRmhMZWJnQmVUZC80OWlN?=
 =?utf-8?B?OFF3Z2F2bUV4Q3c2M0Z0ZnAwK2UwbFh0RjlpMkFLWllSS0IyelRFaE85anBJ?=
 =?utf-8?B?eENNYVdYN3dtUVIzbC9RRzdpM3dycWJDZXNqM1NXSUVkNlVYYWptRWhiMEVI?=
 =?utf-8?B?am1DYlJ4TUI0bkNvWEcyWnFBSWJacDYwZW8xQ0Z4OVFmWHpqN1kwU1pDcWRn?=
 =?utf-8?Q?zaYlLXtwMSIufjICKE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BF363CB2867B043A4D7C87183FAF06C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9062bdc-83b9-4ba2-9504-08d8f4f8661c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 10:24:57.3532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LFCBcJ11a/+8fT38TaEMOVOhbIBwoBz0taTaZ4sVdIRuSQmzvSGQxmnLbCbK95nWuSQHib8kjBJZaImylxq4upfh7aZEyoGSYXBLuwJumhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3515
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEuMDQuMjAyMSAxMjozOCwgQ2xhdWRpdSBCZXpuZWEgLSBNMTgwNjMgd3JvdGU6DQo+IE9u
IDMxLjAzLjIwMjEgMTk6MDEsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pg0KPj4gT24gMzEvMDMvMjAyMSAxMzo1OTowNisw
MzAwLCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+PiBGcm9tOiBFdWdlbiBIcmlzdGV2IDxldWdl
bi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+DQo+Pj4NCj4+PiBJbnRyb2R1Y2UgbmV3IGZhbWlseSBv
ZiBTb0NzLCBzYW1hNywgYW5kIGZpcnN0IFNvQywgc2FtYTdnNS4NCj4+Pg0KPj4+IFNpZ25lZC1v
ZmYtYnk6IEV1Z2VuIEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4NCj4+PiBT
aWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNv
bT4NCj4+PiAtLS0NCj4+PiAgYXJjaC9hcm0vbWFjaC1hdDkxL01ha2VmaWxlIHwgIDEgKw0KPj4+
ICBhcmNoL2FybS9tYWNoLWF0OTEvc2FtYTcuYyAgfCA0OCArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+Pj4gIDIgZmlsZXMgY2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKQ0K
Pj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vbWFjaC1hdDkxL3NhbWE3LmMNCj4+Pg0K
Pj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLWF0OTEvTWFrZWZpbGUgYi9hcmNoL2FybS9t
YWNoLWF0OTEvTWFrZWZpbGUNCj4+PiBpbmRleCBmNTY1NDkwZjFiNzAuLjZjYzY2MjRjZGRhYyAx
MDA2NDQNCj4+PiAtLS0gYS9hcmNoL2FybS9tYWNoLWF0OTEvTWFrZWZpbGUNCj4+PiArKysgYi9h
cmNoL2FybS9tYWNoLWF0OTEvTWFrZWZpbGUNCj4+PiBAQCAtOSw2ICs5LDcgQEAgb2JqLSQoQ09O
RklHX1NPQ19BVDkxU0FNOSkgICAgKz0gYXQ5MXNhbTkubw0KPj4+ICBvYmotJChDT05GSUdfU09D
X1NBTTlYNjApICAgICs9IHNhbTl4NjAubw0KPj4+ICBvYmotJChDT05GSUdfU09DX1NBTUE1KSAg
ICAgICAgICAgICAgKz0gc2FtYTUubw0KPj4+ICBvYmotJChDT05GSUdfU09DX1NBTVY3KSAgICAg
ICAgICAgICAgKz0gc2Ftdjcubw0KPj4+ICtvYmotJChDT05GSUdfU09DX1NBTUE3KSAgICAgICAg
ICAgICAgKz0gc2FtYTcubw0KPj4+DQo+Pj4gICMgUG93ZXIgTWFuYWdlbWVudA0KPj4+ICBvYmot
JChDT05GSUdfQVRNRUxfUE0pICAgICAgICAgICAgICAgKz0gcG0ubyBwbV9zdXNwZW5kLm8NCj4+
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1hdDkxL3NhbWE3LmMgYi9hcmNoL2FybS9tYWNo
LWF0OTEvc2FtYTcuYw0KPj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+Pj4gaW5kZXggMDAwMDAw
MDAwMDAwLi5lMDRjYWRiNTY5YWQNCj4+PiAtLS0gL2Rldi9udWxsDQo+Pj4gKysrIGIvYXJjaC9h
cm0vbWFjaC1hdDkxL3NhbWE3LmMNCj4+PiBAQCAtMCwwICsxLDQ4IEBADQo+Pj4gKy8vIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+Pj4gKy8qDQo+Pj4gKyAqIFNl
dHVwIGNvZGUgZm9yIFNBTUE3DQo+Pj4gKyAqDQo+Pj4gKyAqIENvcHlyaWdodCAoQykgMjAyMSBN
aWNyb2NoaXAgVGVjaG5vbG9neSwgSW5jLiBhbmQgaXRzIHN1YnNpZGlhcmllcw0KPj4+ICsgKg0K
Pj4+ICsgKi8NCj4+PiArDQo+Pj4gKyNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPj4+ICsjaW5jbHVk
ZSA8bGludXgvb2ZfcGxhdGZvcm0uaD4NCj4+PiArDQo+Pj4gKyNpbmNsdWRlIDxhc20vbWFjaC9h
cmNoLmg+DQo+Pj4gKyNpbmNsdWRlIDxhc20vc3lzdGVtX21pc2MuaD4NCj4+PiArDQo+Pj4gKyNp
bmNsdWRlICJnZW5lcmljLmgiDQo+Pj4gKw0KPj4+ICtzdGF0aWMgdm9pZCBfX2luaXQgc2FtYTdf
Y29tbW9uX2luaXQodm9pZCkNCj4+PiArew0KPj4+ICsgICAgIG9mX3BsYXRmb3JtX2RlZmF1bHRf
cG9wdWxhdGUoTlVMTCwgTlVMTCwgTlVMTCk7DQo+Pg0KPj4gSXMgdGhpcyBuZWNlc3Nhcnk/IFRo
aXMgaXMgbGVmdCBhcyBhIHdvcmthcm91bmQgZm9yIHRoZSBvbGQgU29DcyB1c2luZw0KPj4gcGlu
Y3RybC1hdDkxLiBJIGd1ZXNzIHRoaXMgd2lsbCBiZSB1c2luZyBwaW80IHNvIHRoaXMgaGFzIHRv
IGJlIHJlbW92ZWQuDQo+IA0KPiBPSywgSSdsbCBoYXZlIGEgbG9vay4gQlRXLCBTQU1BNUQyIHdo
aWNoIGlzIGFsc28gdXNpbmcgUElPNCBjYWxscw0KPiBvZl9wbGF0Zm9ybV9kZWZhdWx0X3BvcHVs
YXRlKE5VTEwsIE5VTEwsIE5VTEwpOw0KDQpXaXRob3V0IHRoaXMgY2FsbCB0aGUgUE0gY29kZSAo
YXJjaC9hcm0vbWFjaC1hdC9wbS5jKSBpcyBub3QgYWJsZSB0byBsb2NhdGUNCnByb3BlciBEVCBu
b2RlczoNCg0KWyAgICAwLjE5NDYxNV0gYXQ5MV9wbV9iYWNrdXBfaW5pdDogZmFpbGVkIHRvIGZp
bmQgc2VjdXJhbSBkZXZpY2UhDQpbICAgIDAuMjAxMzkzXSBhdDkxX3BtX3NyYW1faW5pdDogZmFp
bGVkIHRvIGZpbmQgc3JhbSBkZXZpY2UhDQpbICAgIDAuMjA3NDQ5XSBBVDkxOiBQTSBub3Qgc3Vw
cG9ydGVkLCBkdWUgdG8gbm8gU1JBTSBhbGxvY2F0ZWQNCg0KPiANCj4+DQo+Pj4gK30NCj4+PiAr
DQo+Pj4gK3N0YXRpYyB2b2lkIF9faW5pdCBzYW1hN19kdF9kZXZpY2VfaW5pdCh2b2lkKQ0KPj4+
ICt7DQo+Pj4gKyAgICAgc2FtYTdfY29tbW9uX2luaXQoKTsNCj4+PiArfQ0KPj4+ICsNCj4+PiAr
c3RhdGljIGNvbnN0IGNoYXIgKmNvbnN0IHNhbWE3X2R0X2JvYXJkX2NvbXBhdFtdIF9faW5pdGNv
bnN0ID0gew0KPj4+ICsgICAgICJtaWNyb2NoaXAsc2FtYTciLA0KPj4+ICsgICAgIE5VTEwNCj4+
PiArfTsNCj4+PiArDQo+Pj4gK0RUX01BQ0hJTkVfU1RBUlQoc2FtYTdfZHQsICJNaWNyb2NoaXAg
U0FNQTciKQ0KPj4+ICsgICAgIC8qIE1haW50YWluZXI6IE1pY3JvY2hpcCAqLw0KPj4+ICsgICAg
IC5pbml0X21hY2hpbmUgICA9IHNhbWE3X2R0X2RldmljZV9pbml0LA0KPj4+ICsgICAgIC5kdF9j
b21wYXQgICAgICA9IHNhbWE3X2R0X2JvYXJkX2NvbXBhdCwNCj4+PiArTUFDSElORV9FTkQNCj4+
PiArDQo+Pj4gK3N0YXRpYyBjb25zdCBjaGFyICpjb25zdCBzYW1hN2c1X2R0X2JvYXJkX2NvbXBh
dFtdIF9faW5pdGNvbnN0ID0gew0KPj4+ICsgICAgICJtaWNyb2NoaXAsc2FtYTdnNSIsDQo+Pj4g
KyAgICAgTlVMTA0KPj4+ICt9Ow0KPj4+ICsNCj4+PiArRFRfTUFDSElORV9TVEFSVChzYW1hN2c1
X2R0LCAiTWljcm9jaGlwIFNBTUE3RzUiKQ0KPj4+ICsgICAgIC8qIE1haW50YWluZXI6IE1pY3Jv
Y2hpcCAqLw0KPj4+ICsgICAgIC5pbml0X21hY2hpbmUgICA9IHNhbWE3X2R0X2RldmljZV9pbml0
LA0KPj4+ICsgICAgIC5kdF9jb21wYXQgICAgICA9IHNhbWE3ZzVfZHRfYm9hcmRfY29tcGF0LA0K
Pj4+ICtNQUNISU5FX0VORA0KPj4+ICsNCj4+PiAtLQ0KPj4+IDIuMjUuMQ0KPj4+DQo+Pg0KPj4g
LS0NCj4+IEFsZXhhbmRyZSBCZWxsb25pLCBjby1vd25lciBhbmQgQ09PLCBCb290bGluDQo+PiBF
bWJlZGRlZCBMaW51eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5nDQo+PiBodHRwczovL2Jvb3RsaW4u
Y29tDQo+Pg0KPiANCg0K
