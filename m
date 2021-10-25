Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1890A43908A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhJYHqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 03:46:55 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:59911 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhJYHqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 03:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635147871; x=1666683871;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kLK6NTei9M+kZ1dZky/vXBSDUug77U/jducyGaJ4R9U=;
  b=0vSZVtkGyFEH7lbWVKssZGbrFsmWPBuhHHrEGkLCCNONYBuXn0FsjSaq
   hZh+Hq1C19k1AiTAYNK4buoYOXhjZ61BHJX610s3QbL508AHsueYai6Nk
   iD035AyNY+1rZ/eGzo7ySgM0mPyDuCIxZEakLfQN6deODAAyVnAWjLA6K
   LwfDGbJL57t2tXTuG+NRQ4oL/hD29R/PcokuodFW7DJQSY8u4YYaYJ3AR
   EYFet29sEkm8BluTT9wyKCG2JVDLCDd7WeycRV4I4MKQbqJJtoBsTkIUU
   W113DMM1FD75HPGN2fZEmZkXErsZVJHnmuNL07LPSFye54MRUFtwb/qh1
   w==;
IronPort-SDR: 2eK8GzrHQGqDEDnrGVAIhknGlexBXr3hrXUtbIMs9usmDVHnHmedCkeqap5TTbnnUjgVnlYh7B
 07QhUsE82UuOOT3D+9Dyfb5SHmPGRZbCf0NzzMkYeGpbfauMso8Ar/GNx5uLeVuqmIr8sNN7II
 Mj5UINgjqJl69QCjHIL6SC/GW8I4OyuwFLP9r+CldfkWDET1cI/nAnsnGsAxhe6mshwRjK1nCq
 Qr+1faLoIkar+qns1W6UY/RggkDo0l6i3MAbkzUwiSxc9MMha3+T5GkliilBGhIbymmDShs/wK
 CXaXpT44/ReH9NH/LG5JLpsu
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="136747739"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2021 00:44:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 25 Oct 2021 00:44:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Mon, 25 Oct 2021 00:44:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBWICN0Gkk/zZTnb8oyGkIgR3YCI6dyfoPJJuil4/RES1jVXfcdJ8XTwyqkO9yLpJq/+gITMvguj4vFmldUOF7bt/CSkdpjOtcGPUpxrmd2WVk3+UDPSa7aWpH8ecSD+JHc0byvst6R8JPaGDQlame8iE6w6XErOdTkkaGPWbNya8fNhTiUk3iez4sWQ61+W32Nv82St3Zz4ruM9bdeqLjF5iQtfKjm+f9swzkoaGAYpVN6IzZjSgj+XzKjsYxvdM4uKzbHfnd3gcwj0tjjqzJ4o5iBITCIMEGwZks+gBC6C2PLeNpcDFJaesXzt4OASuRs4E1KrMVC22IXIHRk6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLK6NTei9M+kZ1dZky/vXBSDUug77U/jducyGaJ4R9U=;
 b=XZEhSau1vmcK86hRpc9qWbb80zsOTlH9v7JZl1RMUof6OOR+PhY1b3rLek7jobVkCEK0ke4PDdqnJ3U+ELYIn7eucIsjCtNxdRxq0rKDyo1+n/OFZsNmxfpPCkzGmfDZ50cCU5eHHFxYqgGhSwC9D09a/vXxcqRunFKBwY0YLb7j2SkPn3F8aopxDUZvlUQlblbBDICwW+mOAEXQ5HAQY5szwJbdbZtyPvkHU+QrleJZ9iM1gzV0rSoYrLOrtk/tRtf2oBxYuIUMxjhA+YK6KBSOji/Cfq+mqdjlHc3SOuioCOGPz10Xy6P1bhIv4ki/psxEraovpC7NISEkScb0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLK6NTei9M+kZ1dZky/vXBSDUug77U/jducyGaJ4R9U=;
 b=rY8CPbCuGl0SO+jVEkO5MNu1K+O4ZkCBlGVOLxXw86oy7QQ9dBfa8a0OkBBjWRmrJQVmGRxskuFQELQNBNC269Or7wR6t/lNFCmIBu8BflQDgh8obEe/bg7zBo0ZkQKcCxek3zS9dXW/Y7UpWYNulIL+bOJzL0RTA0WBb4xpYUM=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by MWHPR11MB0079.namprd11.prod.outlook.com (2603:10b6:301:6b::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Mon, 25 Oct
 2021 07:44:27 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::bd93:cf07:ea77:3b50]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::bd93:cf07:ea77:3b50%7]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 07:44:27 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <yangyingliang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <maz@kernel.org>
Subject: Re: [PATCH -next] irqchip/mchp-eic: Fix return value check in
 mchp_eic_init()
Thread-Topic: [PATCH -next] irqchip/mchp-eic: Fix return value check in
 mchp_eic_init()
Thread-Index: AQHXyXQjJLg/vVccMkK0nbq2OERYnQ==
Date:   Mon, 25 Oct 2021 07:44:27 +0000
Message-ID: <ee48cd8d-49db-80f3-c09d-c65c0b8287bf@microchip.com>
References: <20211025050055.1129845-1-yangyingliang@huawei.com>
In-Reply-To: <20211025050055.1129845-1-yangyingliang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f0d5c23-b1a1-41bc-61d6-08d9978b45a0
x-ms-traffictypediagnostic: MWHPR11MB0079:
x-microsoft-antispam-prvs: <MWHPR11MB00792BBE6D703EFF08FD894D87839@MWHPR11MB0079.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /HcOY4MrsrUTTdCooGsc7olC8lpnZEy+LkeB0mXm6rJybE6TsPl86Qk5uZNlGSSpoGFP0yZvpZ+tWNR5QOYyzWIYx/0aFaECmRhn4RYKTbu5MLq+yZu+EDWzcUxyZY5SA97AeOUIR91p9UQpvqEEoBoGFzzA4HyrxFI29diUmUoHSHopA3gl/JUuo8aHGisCIJMVT56mgcP9aAEXL3/MChlwLpjSKquyzS7spDnms/EVA5kwg9md6O90TYySn6KmIdIKxR6oKQ4vJBE340oyGpyWsVoY0IMEICzQwP9V5E4rdTzB8+EzS2gkXUALxiYbwj3DS+31Ofx4VkOWe941VOkTlaC++q/q6LDfopbzjLMdbI3dJ64N7n6ZPoaBTLSv7y0G99+u4eNM3tRuQWXb7IxL1ApJsndhSKig8HH3241dqTAY3KdYYuy3pp16dc29F1OF//AoBRLJ5mJXabc2UYwyXUxKutzMDN3TfONC4zY83+w4SduOyzz0+rqmgHr2GALgWVc6T49r61mHeIM8J0xAhSO3vnOx4doR6ijmGKcri1JwSMYeurCGBA71jfggjm45r1u2hDHefdA8m09aShhtd8mnDlju/iJ2SphgrYXdge3Is5P+TfEN3tO6gaYlIQuTo2yf52FYBFfdgWugrUiYOOFyC8OeHZ9w1g1ZkG2PaCfZiqLTdWH6tLraLutaD/NZbuabjbWNls8v5eqCXHie98ELkIl9mxqdAcAdLrjQzq22/GDCLGrUrAbM/pSgYhx7kBGlxpSvM/KdofqG8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(6486002)(38100700002)(6506007)(53546011)(508600001)(316002)(86362001)(66446008)(64756008)(110136005)(8936002)(5660300002)(4744005)(76116006)(31696002)(91956017)(186003)(36756003)(71200400001)(8676002)(66946007)(66556008)(66476007)(83380400001)(2906002)(6512007)(2616005)(26005)(31686004)(38070700005)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TW5sMTlLT3JkZGxzeTVUb2wwU0JPL3M2TjBwRndBSzR3UGFXMTEzOVVEUDBW?=
 =?utf-8?B?T09JVHFsVWR1R2I4aUVOVDFEWFFmTnIxV3RZdEpXckUrYmhKQUpOcEQ3UWRK?=
 =?utf-8?B?QWZvZXJlWkpjOUtjNnJsaEZUc1RXSTBUM0RxSzZndnNGbGo3dTBDbFh5cndz?=
 =?utf-8?B?ai9nWlJXa1p4cFJuYkUxQjQ5R2wza2FuZVllMXdjTWRlQ28yK0NXdCtWVGlk?=
 =?utf-8?B?QzNDdUZ4engxVUZSU09UT29ockFJOTJJaVN6QUVTSkJwMUxFbXl2ZFNwQ09h?=
 =?utf-8?B?TXU5bXI3ZlN2TEpPM3JpZUpCSURXQjZnS2Q4eU01MkM0Tlc4eldpZ2lmUHVD?=
 =?utf-8?B?a0dKKzFvb3FsVjdzN3lSK0syTzlLd2ZnRHpxZ3M5R0ZtVWp4SytmSzBqNStP?=
 =?utf-8?B?SFlWNW5RV0J5NUpHR2lVMUxoM2x1bElrekJhZHN5anRMbE5DWXdQTXNaRy9Y?=
 =?utf-8?B?dXhrMWVxVFNsT1dGNmR0MXpaVUw2ZVNmR1JqTzRTY3hwT0R2OGpLbERaSVN4?=
 =?utf-8?B?Znh0MGcxbm1MSzUzYnlzS3BxUGVoYXg4UnA0NnNid05jL3ZVNVNxNUk0aUNH?=
 =?utf-8?B?d1Q0UmloYS9WMHBWRVdSQzRZOWNQazE5V1JncWFxMHQrdm5zQ0NvbzZaTUtv?=
 =?utf-8?B?Qnk4dWF6VGFGcXE4VlVOaGp5YmJUS3JxWC8wOVpXbzBsVTZOdGlwSmJmVG9C?=
 =?utf-8?B?S3llbG9lYmNXbnljbElJVEtBN2t3R0hYTFk0YnQ2NWtZSTFDb2x6aTZ0WDd5?=
 =?utf-8?B?b2ZMMC94VzFvWHVmSndWRnM5ZHFQUFU2YzJaaitMV3Z3TlZKVDEzZDdzVW9k?=
 =?utf-8?B?a0FyblJPOVZZdTR4V1B0UnJ2OTUwTE1MWnFhbmU1bFVRMENDTk1ScGdWN1NN?=
 =?utf-8?B?QnNmSGJPTXVGVEQvLzltOTBOdXNhOTNaMmdGVXg0WmpHYXZ5Nk5lYjZmeEY5?=
 =?utf-8?B?MXBxSXlLUThGd0RFYmtsM1Q5OTl3c0N5U29zMDJVcW5rSUVXaVYwZ1JoejJL?=
 =?utf-8?B?WEFLeS80dGYrYUxvZ0Y5Z3pOUWF2VUh3Z0JtYzNZZXArNzdDRGg3UmpYTWxK?=
 =?utf-8?B?REEzWUtwRnJiN2psUFM2dHByUkVTTmxUMUc5V3pXRFR5TkVUZDlqYXBpUlpp?=
 =?utf-8?B?K3dRUkp4SUVBWDhmUFRaSFJEMlo4WnkwcjlvcDVHWFkrZXUrNlFqQjdRaWlG?=
 =?utf-8?B?MUJvdUQ0UWtqVkZQSkJZRWk4ZDdnSmZTMjJTeGRZbllST003ZVpEajVZZDh6?=
 =?utf-8?B?Q1l3WGF4U3hSeWp1Z3RTalZFelhzMkd2M1VGL0JIZ1pFd3Y2V0ZNWGJjUHQ4?=
 =?utf-8?B?WlBTNUtzNDFhZ1lmWlVTaTRZOGQvTXNYOGFYc1dxQ2QxL1VxS1drM0ErbXBy?=
 =?utf-8?B?ZUJYMlUrSFkwaGdiRE96S2JVTUh2eE8zSE1vZ3ZIWUViM1lPT2liUExpRHNQ?=
 =?utf-8?B?OVJPMmVsbFh0STBkcnRFTm45N1JDb01GaFY0OVIwMWt3Rmw0TTR3cUdSWng1?=
 =?utf-8?B?Nzh4U0FwVUNnT0RNQ0dGWlBTWld3dGcyN2lrVFdUSkVtL3Vpa0wxWjMrT2tH?=
 =?utf-8?B?WG1tSC9ISHRVM0tkemNRdDhzUy9iMkN2cHdjdzBLZUlTc0xSWTdMaVU5R216?=
 =?utf-8?B?SmhrWDVLYkQzZ2x5YnBzNlM5L0RWUUMxYnhkdityMFlub2V1K2gzd0l2TDlV?=
 =?utf-8?B?eTVzbGpSNE5OZVhNNTlCdHpBdVpYOTJUSUx0cHNjOWIvQlJTblR0WnJWV1Ro?=
 =?utf-8?B?MlhjM2JsbDVDQmM1VXRnUklVcjRCMTRYS3gzcjN6czlwa0QwRnp5ek5ha0Vj?=
 =?utf-8?B?SGpvUzYwOHdJWVQ5ZllXbWRWN1VZQ0VHbldIVVRsb28zUlhqY0ZjZUtydWlC?=
 =?utf-8?B?L3NiUk5PMFpYY3J2R0ZNMGRaVDIxUWZBcU1tL1grUkRSbGx3UVNzcituVGdk?=
 =?utf-8?B?Y2xkZ0owQlhpekVsbjVXVTB4eVAyKzZWc0lvN3VOSmNId1RtU1AvRFhwanVo?=
 =?utf-8?B?ZStocDZ1Tk02UGVibDFpRGVjVjBPaEhOOVk3MzlUOFI1TVRMVGxwMG1NditJ?=
 =?utf-8?B?NHNQdVhhajJvaHVtZkFmR3lrZ2g3Q1NBVUFSNXRrOGtOUUVyTmxDMkVDK2NW?=
 =?utf-8?B?anpENXpHM2p0dW1GNnJDVVdobjJmN2FlVkhTV0c4eHpadUUrOU5RdXVRQTZi?=
 =?utf-8?B?QzhqK1Z3dlErVVpUQVNKM3FSamdjaXpRZHlZUTZoTEhORVBDVUw0SERjWENL?=
 =?utf-8?B?WEJDVXdYOWM5TmtPV0NlUDhvaHFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC6521B7F286FF4D9D7D57BF4FEAD7DA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0d5c23-b1a1-41bc-61d6-08d9978b45a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 07:44:27.2997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WhqbhLi7najk2/tswa2j8TDp4RiJCqResjvixG7W3hecoxLVxl1Jb5CtdLDiKLaFMWyN/iUN8V4CJbGvV44ZxXOoNy0ktZFhKlxFdwlMyZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjUuMTAuMjAyMSAwODowMCwgWWFuZyBZaW5nbGlhbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSW4gY2FzZSBvZiBlcnJvciwgdGhlIGZ1bmN0
aW9uIG9mX2lvbWFwKCkgcmV0dXJucyBOVUxMIHBvaW50ZXINCj4gbm90IEVSUl9QVFIoKS4gVGhl
IElTX0VSUigpIHRlc3QgaW4gdGhlIHJldHVybiB2YWx1ZSBjaGVjaw0KPiBzaG91bGQgYmUgcmVw
bGFjZWQgd2l0aCBOVUxMIHRlc3QuDQo+IA0KPiBSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8aHVs
a2NpQGh1YXdlaS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFlhbmcgWWluZ2xpYW5nIDx5YW5neWlu
Z2xpYW5nQGh1YXdlaS4NClJldmlld2VkLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpu
ZWFAbWljcm9jaGlwLmNvbT4NCg0KVGhhbmsgeW91IQ0KDQo+IC0tLQ0KPiAgZHJpdmVycy9pcnFj
aGlwL2lycS1tY2hwLWVpYy5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pcnFjaGlwL2ly
cS1tY2hwLWVpYy5jIGIvZHJpdmVycy9pcnFjaGlwL2lycS1tY2hwLWVpYy5jDQo+IGluZGV4IDA5
YjdhOGNkYjYxMS4uYzcyNmExOTgzN2QyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lycWNoaXAv
aXJxLW1jaHAtZWljLmMNCj4gKysrIGIvZHJpdmVycy9pcnFjaGlwL2lycS1tY2hwLWVpYy5jDQo+
IEBAIC0yMDksNyArMjA5LDcgQEAgc3RhdGljIGludCBtY2hwX2VpY19pbml0KHN0cnVjdCBkZXZp
Y2Vfbm9kZSAqbm9kZSwgc3RydWN0IGRldmljZV9ub2RlICpwYXJlbnQpDQo+ICAgICAgICAgICAg
ICAgICByZXR1cm4gLUVOT01FTTsNCj4gDQo+ICAgICAgICAgZWljLT5iYXNlID0gb2ZfaW9tYXAo
bm9kZSwgMCk7DQo+IC0gICAgICAgaWYgKElTX0VSUihlaWMtPmJhc2UpKSB7DQo+ICsgICAgICAg
aWYgKCFlaWMtPmJhc2UpIHsNCj4gICAgICAgICAgICAgICAgIHJldCA9IC1FTk9NRU07DQo+ICAg
ICAgICAgICAgICAgICBnb3RvIGZyZWU7DQo+ICAgICAgICAgfQ0KPiAtLQ0KPiAyLjI1LjENCj4g
DQoNCg==
