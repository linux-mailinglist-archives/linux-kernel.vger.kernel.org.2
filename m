Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC7534C513
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhC2HjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:39:05 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:53594 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhC2Hio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617003524; x=1648539524;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gZ3/9wDkIFJ3fGuHLUSv2f8pAI8JxGlh8qlfBzYov6Y=;
  b=CNI3p96I7OSbsTTDLCsUjdXWaMZGdxDYkFQb8Lupf6wpFBrwiwOnVYJ6
   +/f8+Ry9aEwhGgoLO8WnXG1KJyeAg/jMWyh++Yj+2oOTOSyhG671PnLhX
   5svnoj87kIrsxBftBu0a4WvBlkDt1PsnHXDMmZl2MGk5hieRkUP6tiB57
   Ch5C5QGX2lP+2TgtCOOanrpovQuGuks5LGepm7j2qj/UAnHh/ujMc89zd
   ZCGQR2o98gsnmHPbti+c/1YOgkHDKCeogB4x9K4dNmksVKjmLcLIvdC9+
   1hbOOPihjTE9IOhwleM7a2b0tayRFohyKeS4bbWROrxdUKaO1rPRN3GeF
   Q==;
IronPort-SDR: UZnDP72uShHkZMFnb4NULu9lzcwdBJg2zQC9klfo3tbpcmUHAcQdHc/+oLIdQn8t+zXb3UusUx
 h4D+vVDikblgq+oqcxMVsWi6tSWJZl/wM2fi5WSFNKh/Vev5XCyTKa7OMhf7GpRWD29bw2Yvra
 Jv58ZkVxu//W93NdEr0KVphMPpt3FjfV9lQEmt+wRvliyfn8mreOtHEdKD6k6W2aSlf90jVpKl
 24mXOWfn512UM8WgjHaobMkSYN1CsW9OG0t9gJRgVkC1ajWrNHLMc3Hi16XroX6+D1Udw8zykb
 JHs=
X-IronPort-AV: E=Sophos;i="5.81,287,1610434800"; 
   d="scan'208";a="49202740"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2021 00:38:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Mar 2021 00:38:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Mon, 29 Mar 2021 00:38:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWmp/3g0FT4k4ectQNam+//uViQTsF/+KksdUNHpEr/66n2KDWQj+PnIqqGfkkC4U15rLQQbX7fScW01l4tTUwaJl2yuZPvTV7sSQnzRMHjV0oNZI1ep0Iw2Q+k8H0JSPXPDUKgs3fgqgq8Nzw0vu+o/jtEnlaxFdofy2TehkQfjXepVJAvuIk8icr2J8+L4F+0DuUJPNCTb4EPijIrT5IBXd2x1+ulC3PESrIhG/eaDWQrdTEehtakCG5t4W6PNhkhBKe9/ryFlIwqB7ywPFRnaweDoccWzRQzwh+cRoK/g4e3P+RqB/XHnjDoii6P7a4fh6jEXcp9QsO8DtMpOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZ3/9wDkIFJ3fGuHLUSv2f8pAI8JxGlh8qlfBzYov6Y=;
 b=lub1uLUvao3+Pd7uR4RCAeyNZp88eQI08b+zHZkR7WchBQHlNVRevWjEG1jgFj73WVf1e3xqdeRmAsec6qEv7mu/kXuGf+8KC1PeBEkA6FMvFGQZm4wEojYTkPLHmgzz1aWVwWbLgwg5DJ6I/T3DR/XOz6EvUnudKxm3l/J2pomKnCK7lKftTAdMpnTQRogfIkr7jupu4jhRY7MJAU8LXp0okROyeJpxewvh7DU2Zc4+B+5dHdzZt6mTKd2JUW6IKoOglmvEb6pIlRS6FiItjVGdnodayvTe2ElmeJ65DjJHUGN0thP8EXBb/V+96ppFJ6ABX1gB9kK8IoTgdnLOkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZ3/9wDkIFJ3fGuHLUSv2f8pAI8JxGlh8qlfBzYov6Y=;
 b=ir+Qy7RCA2mJYxuqIAEhAIsmLUg3oXuWldArUk6i4F4I3p5/RaTlu5JVhNX76YYkFSm2NRWG/Y8oDNs+CxX2TexO1uGnwDvWybfCOwPBoJLNAH5eyayiBEuTcA8zKtjLlMH1lxBYSRO5QwYg5bmqMgEBtkH3gwDhvFdt1izG/qM=
Received: from BYAPR11MB3254.namprd11.prod.outlook.com (2603:10b6:a03:7c::19)
 by BYAPR11MB2629.namprd11.prod.outlook.com (2603:10b6:a02:c6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Mon, 29 Mar
 2021 07:38:42 +0000
Received: from BYAPR11MB3254.namprd11.prod.outlook.com
 ([fe80::6c10:a3fe:3cd1:54c0]) by BYAPR11MB3254.namprd11.prod.outlook.com
 ([fe80::6c10:a3fe:3cd1:54c0%4]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 07:38:42 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>
CC:     <tiwai@suse.de>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <tiwai@suse.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 02/17] ASoC: atmel: fix shadowed variable
Thread-Topic: [PATCH 02/17] ASoC: atmel: fix shadowed variable
Thread-Index: AQHXIotjzU2sgbG7Z0uxPmR7NLBJOaqal/sA
Date:   Mon, 29 Mar 2021 07:38:42 +0000
Message-ID: <755ba9c1-3e38-850f-12a3-ec20de9166b4@microchip.com>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
 <20210326215927.936377-3-pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20210326215927.936377-3-pierre-louis.bossart@linux.intel.com>
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
x-ms-office365-filtering-correlation-id: b0f3b096-a2b6-457d-be59-08d8f285ad19
x-ms-traffictypediagnostic: BYAPR11MB2629:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB26297922AEF4EBB1157D0725E77E9@BYAPR11MB2629.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:608;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r0ZvCkKJYCugou3dhFvfBuAWjFfKJbb8FAryhj15YfwfqYso8NFLA3hJpBfTffDU1hfzeQRkqFMOFpVA7I887C8RUL+Ub8M7DveezCTpTZHw4cB0z1J6WleM6y8Tg06OmBlpwxkFnOF+RBcFwUMGNHl0uxTLvOFwT/5IAR3nHxy5CSHINtA5FsbvmtjoP3JPahgkIntgDFAeL9C9RV/KZ/gyVibJgpj/3N2aKlcWHEAGiTONSs0/BCATVPAhF8ynEzZxx4BgztUc1XoXnA8UoYPzAnxRCz/zQxYK5JT1d4TgpP0JxVrhiZ9ehxbL8Wz0HRAX9/DTggzLjIo14sR4f5y+YckhnWhqNOQpKVZcor4QhyUdzCps5vr2d7iSUu7/1XTiLu6Btcn4ls72lOzGX6AZtEiATXQu7YDwkyduLxkk1zOMbzExbxZ9GVqiwq7gbctgjm9ttQ5J74WmzEr4Dqo/Nb6d+WtZbJKuFx2P7X/cIRqztkGLmDOZFgxLUoQQCboaAK03VAGeehO9ZioP0cRb3nabLTyzrIPm3FXmbu12Mk44o72IYCIdx77iZL3G5PRs4ex2qnQ7wf5H9u6p5KhZ2eCQCNBOm+gD4+t4/QS10d1hn/cAFetRdZO3JJEMy5tgNBuAAtgXNwu5KU3wNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3254.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(39860400002)(346002)(396003)(186003)(6512007)(91956017)(4744005)(4326008)(83380400001)(66556008)(66946007)(316002)(54906003)(36756003)(110136005)(66476007)(66446008)(71200400001)(2616005)(76116006)(8936002)(31686004)(478600001)(31696002)(86362001)(38100700001)(53546011)(6506007)(8676002)(7416002)(6486002)(5660300002)(2906002)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Q0tvSDhIN3YzZUdxQTVFODZZWitNNnRrR3UvM3o2d3dEVDlXbmtoZjB3ajcx?=
 =?utf-8?B?NUZDWVRVYXlERjN0b0RhaEtXcnJSTVc2N0I3cmIwN00zZ0xtQlk1emtWV25j?=
 =?utf-8?B?cXlKVllQbm1MVGlsODVpSEZ6SCsvVndLbEhaWGRZUERDYVdDOGZVNExTZllB?=
 =?utf-8?B?SUhydjRQMGN2MEVIbVREb0RFaTdvTUVLakNYWjg3WVlzNG9CSTA3OVJGaWoy?=
 =?utf-8?B?ZkxVTGNNUjd2UFJXN0VxbjR1ZTJDTlMvaUh6WmtvWVQ3MXRvS1FsN2FFOHRE?=
 =?utf-8?B?UHlZTElrQktmN0QzdERJeVJBZlFWdG9OYjk3NHBscUxqRXJUbVE0d2ZUdDY1?=
 =?utf-8?B?ZHYxeVIrcDJsM3dxcnJmWnVJbFVRcVpvdEhBRW52Z2thS2dIZ0IyUTNsTnlK?=
 =?utf-8?B?dVhHS3VVNGxhT3RESUlmZEJhQUwrWEVnVGlrY0wwMlpFVExpZ0lnbEkrc2U1?=
 =?utf-8?B?WUNpb3kvUVc1N1JYaW9vVHlzZmhjNHZkdmdqMzNZbWZPMUVMeUlWdVQ2RVFH?=
 =?utf-8?B?NXRzRHpmZGVBM1FkeGVOTFltWlkyRlpTQUZCYjVGeDFMTzI0a0NKNzVZR0lo?=
 =?utf-8?B?cHpQSzVmcy8rVjRuUGJtc3RCWFc1ZzVFUnBSQ2RqbUlwbHQ5VUxFU0s0QUpK?=
 =?utf-8?B?TmdENGY3TFRGTnhDdGRGTVY0SCtXOHd4UTdBelF3WGRSd1lRbXMzZkRKMSt5?=
 =?utf-8?B?U2wvbGw1WkFKRjBBeGpTeGxMaklwNCtXaXM1dGZabUZMM0R4SUVnalVta2hO?=
 =?utf-8?B?M2pnU2tTQnVITTBVdjQ1K1JEY3g0RFhXWTJZL2xEc0lsVTV0YmxxUjZoQXhj?=
 =?utf-8?B?VkthY3FEMkVESEZkbC9nZ2R3ZE83VnV2eWYzOTh3V0xhZ0l6NmdqMGF1d3VQ?=
 =?utf-8?B?d0p3Y3lrR25rQ3pZemJwMG1ZR2JpU2hZRWt0TVNCVDdhR0pKYlFzK3NLdGVu?=
 =?utf-8?B?cHNYS09RVzVJSGVxSWZJd3haeVZCeHpaRWdBVS9KbTBsL29LZEJHS2prb0Z0?=
 =?utf-8?B?Z2QxMHpnTjVIY3ljMnpoTVF5VitPN0RyenBTcFBpUStUTVF4VUlKejZDeWpl?=
 =?utf-8?B?aVFMUXhHQTFWNWxscDdqV2VKU3lmbFdMcGllOGRjSE5BQmpWQ2MrWit6dTRH?=
 =?utf-8?B?WU9ISU1KN2hhbXZQSzFPOEJodjB0ZEY4bUJTbXdOU0hTWjRGY3llcHZmTjZw?=
 =?utf-8?B?MC9TTXExSUlLQ3dPdkxCRWV0a1dzSGRiOGNXMlc4V0w3cmw5cjkyY0xPdnFW?=
 =?utf-8?B?a1VsaFRaa0l3dnZoSXMvVUozSkVrVGtIUFdqT3ZKQlNpZkUrSkI2V2ROOTcz?=
 =?utf-8?B?ZWFMUVUrWUVPNTlFR05hVmtvMWYxYmI0VlBBUTJoTjJhK04xUzRzdW5kL0Ja?=
 =?utf-8?B?NWt3OVlHUnd2cDFIbTdtbjFISHltUWlGNXhIWC8wT09zL3VnU21iMStqaWMx?=
 =?utf-8?B?akZRU25nWlhqMkxrWjFhWWFLaGlXWk5aSExnS1d1QTlVNklMS1BIVWNxUU14?=
 =?utf-8?B?NGMyQzdlUk5TTzNkc2tKaE5VamN5Q1hwVWRkZE5rRXR2NENsQ3AvcVM0SHRC?=
 =?utf-8?B?ZGJEMVVNeUhBTkNFTm41cWRqdGpKRE5MVFAzRzRDT3dIV011YzVCWG1FVWRF?=
 =?utf-8?B?bStDazQvUElPOXBKd21IdmlscE8waWZSeDRjSWdKaXZZRFFhTThRWGVZd1oy?=
 =?utf-8?B?bHptTzN1ZXRiSHhVNEVseEovdWNiaERwVldtUTB6TzhzRlF0TndWOG1TY2FB?=
 =?utf-8?B?aWpsUmZaYldsRUVWSjJZYUxsREd3VU43Y053STlJM3hISVM4Y0FxZitON3gv?=
 =?utf-8?B?eXBhWmJSejNrTEpxcUJUQTQzK01HdUVqTStTOVFaU2FVWlZ1dXF2M0ZvQ2hl?=
 =?utf-8?Q?/FTazFDDos+V9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFD6D8A035C5F14D8A3583DBE733FFA8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3254.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f3b096-a2b6-457d-be59-08d8f285ad19
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 07:38:42.0433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7fageNh/jT8CbXrHb+t+AAcAeR4rBCW08b/+8Ln41QnMF1kN9TxFAKwyrlDt/m4xV9RNEcbO3sB3fQ9/eW1b4ZCQeP2mZkaDq9Av2NfmWAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2629
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYuMDMuMjAyMSAyMzo1OSwgUGllcnJlLUxvdWlzIEJvc3NhcnQgd3JvdGU6DQo+IEZpeCBj
cHBjaGVjayB3YXJuaW5nOg0KPiANCj4gc291bmQvc29jL2F0bWVsL2F0bWVsLWNsYXNzZC5jOjUx
OjE0OiBzdHlsZTogTG9jYWwgdmFyaWFibGUgJ3B3bV90eXBlJw0KPiBzaGFkb3dzIG91dGVyIHZh
cmlhYmxlIFtzaGFkb3dWYXJpYWJsZV0NCj4gICBjb25zdCBjaGFyICpwd21fdHlwZTsNCj4gICAg
ICAgICAgICAgICBeDQo+IHNvdW5kL3NvYy9hdG1lbC9hdG1lbC1jbGFzc2QuYzoyMjY6Mjc6IG5v
dGU6IFNoYWRvd2VkIGRlY2xhcmF0aW9uDQo+IHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgcHdt
X3R5cGVbXSA9IHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiBzb3VuZC9zb2Mv
YXRtZWwvYXRtZWwtY2xhc3NkLmM6NTE6MTQ6IG5vdGU6IFNoYWRvdyB2YXJpYWJsZQ0KPiAgIGNv
bnN0IGNoYXIgKnB3bV90eXBlOw0KPiAgICAgICAgICAgICAgIF4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFBpZXJyZS1Mb3VpcyBCb3NzYXJ0IDxwaWVycmUtbG91aXMuYm9zc2FydEBsaW51eC5pbnRl
bC5jb20+DQoNClJldmlld2VkLWJ5OiBDb2RyaW4gQ2l1Ym90YXJpdSA8Y29kcmluLmNpdWJvdGFy
aXVAbWljcm9jaGlwLmNvbT4NCg0KVGhhbmtzIQ0K
