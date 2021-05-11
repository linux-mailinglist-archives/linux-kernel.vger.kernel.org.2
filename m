Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F5D37AA77
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhEKPSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:18:52 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:48958 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbhEKPSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1620746265; x=1652282265;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=x6pBh7dZr5mqi1oeEMiNKRy3kppJz0eAW+L+MRWrJYo=;
  b=PO0rBwaUAwbJtZCiZ1FL3bFQFdiyC2v0WKVlOQNw/d+EibVEebChqUgo
   dkGMsLt40/u0ZVxrjDZXMEqMVyTYNNP4o9cbmQHPHSvVNw8uiliqWle7R
   ogX/JlSgEdjNrrYxDeKCBpOnf9fBjudI9IMmAi4Ba7iDmNiO8IxaaL5BF
   xNH+7dYeqjoBinund/IMSUTvrZZNWDze/ie8l2ngQF2/olSQ7RDLX/y7K
   vJZ5WnZvXsNgA0C6coKLkfxxNWnktq8XlRZokONaFx6nyjDrq3+CWPnxE
   BpBCfKZvcM9JE8J3OurV3L0MEQtRrWdktwGAU16NF06arZaMt1nMrC5eP
   Q==;
IronPort-SDR: ISiBKsk8fV2it29FYXbbE/Ge250a5XOz2OXvqCaP7/FDrsYteGySWDR+1zY4apUymcxBxh4gWG
 J+53075M6Gz7BHwNHEPsu1ejlMPRuwrWzBGX41QgZ4kHJmnOutXW4OJRlyi6iVhjFOEQm+02Z6
 Q+b0w7k34pJO8lhNy2Q+7ZrczPpHF+iSDmdrKDfIIuBOqw0Ke6Wt33kwF6e6YhlZphgBDv/XMO
 6vC5pWAWBf88PkYdXPwdSPUDoHF25/ZgqdJqg3lJ6Sczdk1ALnHdiRtI6LylGRw5qj07+kTSCN
 Uig=
X-IronPort-AV: E=Sophos;i="5.82,291,1613458800"; 
   d="scan'208";a="120680397"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 May 2021 08:17:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 08:17:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Tue, 11 May 2021 08:17:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fm+QL9/8WqVJUJiylv9FG8n+OG9oqkpq1BLmGok2Od5xR0jUhjAJj4Aotj+8mZp3wkNJDNvelIEe3RWDVHE4QDzdm6niDB9I+PPU1AXQ3fUxsPd6ygjPiPYzRM/05Pk4sidZTRaAXuREqGLN7+hLPT2MVXQwu+gPwWT00VdJGHslvezUDs5bwqGJBPW7FYK/woO8JStcQ5NgA1uaeDzunx/eGIQiLY5u/Gt1MGYsgAX2WVPWPMdArydO68OMY3n14IoPvQagPXKE/KMS5pPkmNbO9UGHLIis5ujGpNdrW8Tt36Z0V2+ynWTJDc/a6j4+86bfeM9+Pmk17FQg5gOWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6pBh7dZr5mqi1oeEMiNKRy3kppJz0eAW+L+MRWrJYo=;
 b=bK+ApY8x67G9LPVUOzdswOqiWwYAH9WqCalcaA9bNshZlMjyEl4D6Axqa54iIMBMI7/jPMJyZSfD2yX931uIFBeix8HtBJv2uxc3n+u6yQDc/8dgLFZqGsRuz+xP9Z2CBfeOO1unES+yOO7PyXVIuCi3Sl8yuIc0sGEKwSdKK5TUbswwcczS3IU8zjcPN9LK3aCat3GWT6t2eGd5w2PQ8f6Pb0GmqevAzp7OHs/inl1Xwv4pSYzz92bl0YUInwhIYCex3phakKkl1jHgPL3Q+NfyEjxrwl6PpTngmuZP9f871ISJPDoCacfAJRf1Smd1k8TFd14FxQpMvY1Vq+6YaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6pBh7dZr5mqi1oeEMiNKRy3kppJz0eAW+L+MRWrJYo=;
 b=j75U18RvTOpCvTnLie+tqTgHksB6MJewW7IbTRFGegUgYOc4EMpxDaz1re7ycCvseipJAy5k35NiAwMESC/ezPJw8F9sD/NtgeNGg7opvc11WNKJvgnjyZZj2M6bSFKfICZqtushIemZv/Q35bFYdIMTQWRrlcRgx/ZRM9E1G9g=
Received: from BYAPR11MB3254.namprd11.prod.outlook.com (2603:10b6:a03:7c::19)
 by BYAPR11MB3816.namprd11.prod.outlook.com (2603:10b6:a03:f8::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Tue, 11 May
 2021 15:17:39 +0000
Received: from BYAPR11MB3254.namprd11.prod.outlook.com
 ([fe80::6c10:a3fe:3cd1:54c0]) by BYAPR11MB3254.namprd11.prod.outlook.com
 ([fe80::6c10:a3fe:3cd1:54c0%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 15:17:39 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <Eugen.Hristev@microchip.com>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 2/4] ARM: dts: at91: add sama7g5 SoC DT and sama7g5-ek
Thread-Topic: [PATCH 2/4] ARM: dts: at91: add sama7g5 SoC DT and sama7g5-ek
Thread-Index: AQHXQ1WBJ3OL0TN3Tk6rA7yEdnXREareauMA
Date:   Tue, 11 May 2021 15:17:39 +0000
Message-ID: <69db39fe-e969-f637-7226-5cb63fc477c5@microchip.com>
References: <20210507152655.182558-1-eugen.hristev@microchip.com>
 <20210507152655.182558-2-eugen.hristev@microchip.com>
In-Reply-To: <20210507152655.182558-2-eugen.hristev@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [2a02:2f0f:910b:600:faed:b4c6:b74:cc75]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07450609-a45b-4813-70dd-08d9148fea77
x-ms-traffictypediagnostic: BYAPR11MB3816:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3816DE4D2FF127217470826CE7539@BYAPR11MB3816.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eleEx5vSAsEHSpz1XU6sLGuNinpJwuq6VXLRkFpen1M7M5XsqyW7TtA4yzxKHTRqpSYVR4XrfjKAQFKmrO+EHpmrhyE3E7EVny0FZHDadibvvUNG4Z3CNnTAfgxB0XaxmR1oGFKZ2OW1ZgF56PDs2z4cJ619v0/M8CeH/6T+ItqgpUphHZr5Cs8vvy52PrFtukCC/sKcucWNym14ajWPVDLHYH29w+dbzoF7iPtp+YctuzZ8OTC+ef1IL5byYIEK4nF5pgACyCnB2VEoWqmyYSbQCeovj1c48TzspyBFuXVbpIHgVMq7CShft9A+JNMnTKx7UnYtzoum6TOaWYrx0qWcnbZm+2sM/V9bJJ0UJo7Zi99qWKnIkJ6UGkKWo/VsRV+zAs1YfLkjD0OsnWPypaxJCGmH9dgXykku6Ehs6hx1VsncjkwmI8gehGIsiuQ9YrVat6SfmRUlr80mc8b2VzFfDXEPTT+6idFxGCE+R0gZL5vTutIybKO+/QfpvUi5WdJ5C8udOoVD+oqjxdfv9c/ncoV6aZGteZ+F5cxl/TNVzadME9LqLHKeBP715CYJQX5fzBk8lkkjr6W2FmMRWCdjHoITTO5g38/Vs/I3ERP9vlvWjqkD2oT+XWgX91deH2M9FLNy+PEN8af4A/5ZkPcKduSS8aKSv3OTnzGidMxVIZZwnHoPpRGgdGWxhNnx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3254.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(366004)(346002)(39860400002)(66946007)(36756003)(71200400001)(31686004)(5660300002)(2906002)(76116006)(66556008)(64756008)(66476007)(6486002)(6636002)(122000001)(110136005)(54906003)(91956017)(316002)(38100700002)(6506007)(107886003)(66446008)(31696002)(478600001)(186003)(8676002)(86362001)(4326008)(8936002)(6512007)(558084003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YWtoMmxIaUx4aVA5NmJ0eS94dzlxK2QrTVlHMGhRMjdkM3V0ajhGVmRZeXgv?=
 =?utf-8?B?cjROY3RYYmdzMHRQTmRnQXprd2s1M214d2FJQUtDNzJOZkNEYlVPNnZNV1d3?=
 =?utf-8?B?cnErbmZXMnd6UjZaaE5QOHZVVUxMcUh1N09xb1RueUMzUWdRd1dqaTV2Z01F?=
 =?utf-8?B?Um9HZnhJTEs3SjhBNEhhQkxmZVRCV1NoUGR2ZmZ6SThaVG5aMjM2QlVFSUsv?=
 =?utf-8?B?Y1V1ZTdPRzZFTUU4bjVlV0FxZGtWbW9CV1NZclNxV21hWDN1aC9laFVmZGpz?=
 =?utf-8?B?S0ZlTmExUmp6ajdKRXA3MDYwOG9Jd1hPSmNpc3V6RXpQY1BESExyaDNDZnB0?=
 =?utf-8?B?RGVyYnVBeTUrL08yQ1Mxc3lIZE10cVdxalZFOEoxdEYxOEs5d24yVkI1TzU1?=
 =?utf-8?B?SkZUMHlLSGlmb2YyZGxqSlg5SjJ0M05tVU5naUtkUDhMYy9uNkwwK0ZXblVn?=
 =?utf-8?B?VmhFNk5ISmhwNUFoYnhXdDdRRWZiQmNpZDJCY1JmSU5aRGwvNnUxTFR4RmFW?=
 =?utf-8?B?MmdEdWVUZmxCTDFoc0VxUnRpbmpqQ2haam9uME9hMVVGczZESm5lK1RwRkFK?=
 =?utf-8?B?NFVTL3crVW55S3ZHTmJFVVk0YUFkQTJ5dDdUK0FzcXAvb09OTjI5WEhUclRZ?=
 =?utf-8?B?ZEd6T0NRZXRvb3ZLTXJWVlNZVTBLMlNMUEIxSzZISWxmV1dDOFR5eHFjeVBI?=
 =?utf-8?B?Y3U3NmZIeStHQmVyZVJYSkQ3TDdJcWlVa3h3T25NVERCTDhtVXR4d00vZzV2?=
 =?utf-8?B?MzBVdC9uRnVuakVoVVoxOW1yeXo2V3lhYk1WU1lidkxMdUdZcEtTb2QweWkv?=
 =?utf-8?B?elk3NXRySkxuYzVyS0VnaDcreG56ODdKd2pMYVprMk5KYU5xUVZvelg2TXdy?=
 =?utf-8?B?NWtUR0x4R1ZlRXpoNWEwbHpjU25kSXFxemJxNTZ2NTBWelpxbkJHTHpYdE5P?=
 =?utf-8?B?NGVIREo3RnJNSlZVWFEzQllzZTBEdVVVSDhQeDBFZUpTRXo4aG1oU2s5SzFz?=
 =?utf-8?B?aUc3cWg5Y1h3QkdocFlPbjRtTmgzQThKQTZSeFFGSVEwbVpKdlR0QzJheE1M?=
 =?utf-8?B?TGZPMnNiMXJ1b1dBeVZhR3ZmdXNmMFpTMUNJNUwreHZoTGhjZk1pVnNvWkFa?=
 =?utf-8?B?Nm54aHo3L25zV2ZtYmxGZDR5NnNvN1lyK1diY1RaZGE2TDRsc3VaSjhjek5V?=
 =?utf-8?B?U2lNWGI5RjRncy9RYUZMZXZ2MnB4MVlFeDA5NVk5Z3ZMUFhSaVRCQ09PVnJx?=
 =?utf-8?B?cHluOG9wa3VTL282RXZkM3luYnFmNWc1aEhxaHlick9IaWhWNlB3Q1BtZ3Iv?=
 =?utf-8?B?SkpyRTRkVFhLVUNVUEJ2dWNLeTI0Z0htN1l0dVRLTWpmVkNFaks4S0s1WG5X?=
 =?utf-8?B?NGNqbCtsbnhTaFVtN3lzcldPY0pwNkF1M09CMGpTU3VVTkdtK1FwRnhNMzQr?=
 =?utf-8?B?VjI2QUFZSHZLSWFLakNaZHo3Z0FDM1hTNjVmb2t1OSs1Wjlmc1A5SXM5NndC?=
 =?utf-8?B?R2REcnIzSzdPT1Q1YnM4eXo1dVZiWnl6S21IY2JsZ1JGUUwvNGtJWFpXQTNM?=
 =?utf-8?B?VDFNNWlBRVRHQXpQVzgrUWk5Z2ZURUFwQkFMSVpBN1lmd0NGOWpndTRCSkcz?=
 =?utf-8?B?dkJFNkgycTU0cldPdmN5SURoai9aNDBoZlh3YUtEd1FlSk9tbmQzSTdrN0Nn?=
 =?utf-8?B?NlZhMlpDaStKbHlTclIvVzZkUVdzS2ZuajV4Q2NmQ2F2MVdZd1MrLzR3bXc5?=
 =?utf-8?B?QUluNkErQnRqMEppdSt3YVNxQjg5bnZDQWhsVzl2NCt0RzlFTWZvdUovUndZ?=
 =?utf-8?Q?IlxL7q4fPMzKRdx9XHbWhR0OyOKDLsWOTjNK0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72E3DAFF8639BF4D9A8BE46BD7829A07@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3254.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07450609-a45b-4813-70dd-08d9148fea77
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 15:17:39.4721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9PidwcSE8hMc40VMleCiiSM/jIkQq+oCsZUViSfmk3zesjI1i1J6l5cHVRW8XbLhNBa3DW2Raa1KT3ucZkBCxrvn1+8+PKRc8/BwiJyajh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3816
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ICsjZGVmaW5lIFBJTl9QQzE2CQkJODANCj4gKyNkZWZpbmUgUElOX1BDMTZfX0dQSU8JCQlQ
SU5NVVhfUElOKFBJTl9QQzE2LCAwLCAwKQ0KPiArI2RlZmluZSBQSU5fUEMxNl9fSTJTTUNDX0RP
VVQyCQlQSU5NVVhfUElOKFBJTl9QQzE2LCAxLCAxKQ0KDQpUaGlzIG9uZSBzaG91bGQgYmUgUElO
X1BDMTZfX0kyU01DQzFfRE9VVDINCg0KQmVzdCByZWdhcmRzLA0KQ29kcmluDQo=
