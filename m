Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F7D43C372
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240213AbhJ0HEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 03:04:21 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:25633 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbhJ0HET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635318114; x=1666854114;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UZzsZhryN5HC/ZKeOyCxHMzZ2GCE/ekimYHWDNVZtv4=;
  b=aJisHaqELCYRxwAWCnvXfaC0ouw4EKJxI8Ul4kKCGEcpmw8uKo+QcbKl
   lwh7vkvrL1kT50LhsOQMEXnErbVHBbSlnkB3K7bDEMHja7hCE/Y73rZhw
   cbIMbIUIGUEBgWHzyDAvShwFrJfxs3yxWVbGVMt2GpmVzcHJ8PxXO1xtr
   u5ImZUbdXf9aWw4PAM68XJ5THePMtwJ4yFMmoDioiS2i3Naz4KXRsjg0H
   nbksUYjyP6i3Y+RbgfTsAWnxocgstbUpxMgVhum/2txiHfjqDl9nbfAcS
   xfAIOPo+AtcNK0WEuES6lteQTiRvbeIGtNKBr2vIh6gkQl1xfeXkC1b59
   Q==;
IronPort-SDR: aJDZACArlPUqZxHhvln2y+TkSKG8cpeZeNHYnWo+xuZwEA1JohjIVL6fCoKuzt7rjZJs73Yc28
 IBRyzH1ijVZ7r9PfPq5Cl/72UHLxhkQbxD8Jspc8xXDKt7QWEEqMyFTCr/TT9blYVWBKq57Xnq
 Fw4+K7yiflUNZMvpHmy9bC1FpJbbCB2aaaXphfSUwu757jJ2ZeJvkVviwRvFsQqwrFXi0PyFRX
 EgcWoJlecvTS4jULko7vDEsjr1tVf3kyqiFIxWZ8wYlMbMxoz8ClsPhUlNBoL5v9/IMzHpQsdx
 5F6K/Ei76wJKlwmL3Zqf+lVW
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="74409300"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Oct 2021 00:01:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 27 Oct 2021 00:01:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Wed, 27 Oct 2021 00:01:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVA6Ugu2HB9FvUo9AzP+mLw5Xdkq3ytwAUU5i00ye8hVnpfxnD3bzc6z6pMg2oMKTePjVCUxEteVcC1923FICW80w7S7QIzAFiWXTPuRBfc5F5q5G8PDD86EvMTsrLClbcWKAnDBAtojx85KoZymMAjMTtjsrI3nQO5Vk+hT5VH50oMAEMGiocgcM+SNXdjBEk5P0B4OWKRFMop1vSRF4jX243ZzqcmLyBlRYB5U0kfwa+VP8Gfj+QvMR3NwfqmlafHouo4peagDXX1gZWi/ZGO4wQNgu2JNJMRe3He7CH1MRNiGVmhcbh21WtpYUdQuNKHFNzUpafhnVl8XeBlwLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZzsZhryN5HC/ZKeOyCxHMzZ2GCE/ekimYHWDNVZtv4=;
 b=dluH/qLFyriu/7f7wfA1E8KoS3jEP1hzRYRhZTT+rWV5DQ72q5ykRN9pMzIsbLBi4kXE66hO5rXQx75IoeSFqmVG9yw04yMW9cGMSmaFaJjJe46NJWsXrcLxslZj375/XDQ9VDgqYWQSUulA0kexCzFzPpd+FKmaypAVxX5tyMt/sMbzMiiXuGsZS0IERVFD5Luw2Qre0aCJ03jPdtwdy6L36vfJ3X/H+JcCJ0jjQYliCRLC6XqwvS0QBIw6D+J+9S8k3Ev3zEWd9PvHMw65yY20IraP/K9AD9b2zAvDC14dBdCFX4iokj0cBgo4IjDI5RSJv2sSrwnnyJGEbm6qQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZzsZhryN5HC/ZKeOyCxHMzZ2GCE/ekimYHWDNVZtv4=;
 b=iiodczFcq96BNv33fsOit9V8ozyWXlJM65hYsZIXB0qsj/nJ2z4Evs3SkS2QivboZwFvXwFLG2OkU781EF6eytJ/SE1EcQWncWmpOn3gsND1PMfDFR62l+Rov8dNkIvevmg7QoQfJT3BGCRAENpqSoUP8PFLR37mYhR9RBwSMM8=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Wed, 27 Oct
 2021 07:01:52 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::bd93:cf07:ea77:3b50]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::bd93:cf07:ea77:3b50%7]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 07:01:52 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sboyd@kernel.org>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <mturquette@baylibre.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 15/15] clk: use clk_core_get_rate_recalc() in
 clk_rate_get()
Thread-Topic: [PATCH v5 15/15] clk: use clk_core_get_rate_recalc() in
 clk_rate_get()
Thread-Index: AQHXywCEFuckfWBeKkiIqGz9qMSsRg==
Date:   Wed, 27 Oct 2021 07:01:52 +0000
Message-ID: <46a6581e-a65e-f280-7f4b-a793229068eb@microchip.com>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
 <20211011112719.3951784-16-claudiu.beznea@microchip.com>
 <163529798547.15791.16388896984607981120@swboyd.mtv.corp.google.com>
In-Reply-To: <163529798547.15791.16388896984607981120@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7cee0039-f203-4ecf-5fab-08d99917a77a
x-ms-traffictypediagnostic: MWHPR11MB0048:
x-microsoft-antispam-prvs: <MWHPR11MB004852C3978A8551708DA8F587859@MWHPR11MB0048.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xjayVCkYJ3YfzsJxUuYOi4zjks7muIV6aO69mNqTn7Z7fxa9gZ4EhBrfBu/6uKw/8Dbjs5yRNZSN8q0KiBoWtMWhzenHM2NxvPq7iS4aspI6OYEd8hNtttEHpX5Ab5dwEFbbmB68LNzSu+oV8SaOYWzJ3GPScKeXSZnEyKUVUEh96OylUEPew1DjTPdlxVnAsVZHgzYlEsi3F62Iznk5dgbak1BwNDAyOwruw8klnZf0L6hYEnUcYQFLe9NbJGjReSzS4LJG4PH42QzQp18aXjeCPHW/yIEHgcYCLpVQ4bntmrV76ETPb479YfL/pIsCbRDrQBramzh0EXl4dNH1OouLkseq/52vfeV9ctSQGcekpCb7QVF5N4bqm2D4qGY0Wrox9lR7uy+HIpP1i3/EAYyykeJ4bvap0FA5QxrEIOsi5ebWGSyqqnHhY0YzEXUA9MTb8s2e6DvVuo3tMJFn8lXkdtNDX97hMATW1sfkEOyPpOxxoQwxaYNw16X/+WhLw8uAcu8WEpJ81p+Nl0Y4Mlp6v1hZ4ortNdpUhAhGIfjONM7YorF+42MY0P+RVEE5QJrEh4HmTIFePbceRVYFjbv7fRwsIzD1EuvEnG22+VQNEosCglBxE9FJWuWx29beayqmUFGdT/m/FCY6fgsgtiEddu3CJI1V+80OycLGu73CJoqW4ZDKkhYOrjTfmVAJu3hgfltSVK7preIYaaKuVZdyIX59iVpejStpunzA2LlgH7qaRwkwJDfA5zy0rhyk0sQcMdJkaTa5XB/lk3C6xA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(64756008)(186003)(6636002)(26005)(38070700005)(66476007)(91956017)(76116006)(66446008)(66946007)(86362001)(4001150100001)(8676002)(71200400001)(83380400001)(5660300002)(38100700002)(6512007)(4744005)(31696002)(6506007)(316002)(122000001)(53546011)(8936002)(36756003)(110136005)(4326008)(2616005)(2906002)(6486002)(54906003)(31686004)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V29xVk5hTnd5UytkVXFFRU1HQll1c3BiZFU4SmxHVTNGazFzaVpsM1NkU2xk?=
 =?utf-8?B?SnU0MVY5UXhFdEZPVzFvbGxSaG5FLzYrcFJxalR1bWN2LzJnMHVaRGUxYit1?=
 =?utf-8?B?Sk0vbkR1MXFJU3h3bzMyaW5CVk5PSWkxK0tTdFVUYzdHSUt1Q2VlZy9PdW40?=
 =?utf-8?B?OWp1QWR3TEV3NWw2d09mYTJ1Tk9EWlBZT3ZsdmdLYUxhMTJta1U5eGZndnEx?=
 =?utf-8?B?VENuTUt5ZWpQTFZFQlROQUZLajFNTHBBczg2elNweFBLWGNvVmI0SCswaFlR?=
 =?utf-8?B?QUdGSUptc1lKTVJ0UVNEeDJpWUZOWTQ2MjBPVmVRVWU3M0crUEMvWDR6eDFS?=
 =?utf-8?B?aFRaVzRwTUt3Mi9RN0ZGZXFXRTRkYkNjRHRLcElscWtRTXNNejBMMnhNL0w3?=
 =?utf-8?B?WUlzY0xlZko4aWxDUVBHQWhMZUVMVzdIaFpkRzBLNjhIR0ZETWpoa3Rhb29J?=
 =?utf-8?B?c0w1N1RUU1pQY01aRmpzOSswRTJQcFgzdGlwd3BCYkZDZTM2dlVqa3BRSmE5?=
 =?utf-8?B?OTc5d1JCVmFLV2x5N1J4Skx4bEszcUpyalJXL0lERGc3UWV2MTBrVFFVVTVL?=
 =?utf-8?B?OEZqVGVMYjdVeW51YllFMzc2MUlxTGpPdVRaNXpoa1NnV29DeFNUNTBLZWNi?=
 =?utf-8?B?M3NnZVhuVDZwWm1YN2x0ekFLbEhPZkhYandTSTJ2U1BpRWRqczV1TFZFeVgx?=
 =?utf-8?B?aTFzN1VmMHNnRjYvM3p1NDF5ZFdvbTA0Y2p3ZGs4cCtJVW9YYUJMOERYdlNt?=
 =?utf-8?B?MHBkQmxUamVBZDNuVWJuYU1aamxtOWhVSmROcFRZUkRET3ZhVzRjWWhjL201?=
 =?utf-8?B?dW8yQ1VVWVVyN2ptOEVDTW5xYTMzNzk3VzRnZ0xuYmY4eHJmZUhUU2Ywb2dL?=
 =?utf-8?B?bEIwYm5ZbjVMeW0zUy82bWlqRU1mWUNzaTBQSEFsWGpVbDRidnljb1RGUDNn?=
 =?utf-8?B?eUpiV1g1TmxEbENhSHV0SndrL2Fwcng0aGlvQ2hzOFVLcDdXcWVGSjVpU1J0?=
 =?utf-8?B?eXBadFIvRE1TKzhjMHlML0lCTS9lb1hwa1lJVEU3T3FEZTZHYUpKd1lCQUlK?=
 =?utf-8?B?VkRXdjVGYnZCaFg5N1dXV1QzSGVXNlRLa2gwTkxnTjhvRW4zWGVBeGdiTksz?=
 =?utf-8?B?REdDdndyY29TUTNjeWpnQzlYanoxcWZ6ZzFRall1WW9nOVF0bkpORVZBTUhj?=
 =?utf-8?B?UUFxQStkNEw3YzFTSmw0U2ZKNzA3MXdUQVJuVmdjeW5RMVJRaEM1WnZjUERk?=
 =?utf-8?B?NlB0NVVSMGZoMXl5NDE1UkgrTHdFaGxDSDlYdnY5UTlmWE82Z0tiTC81c0F6?=
 =?utf-8?B?WFdvVk1FSEZYMnhDWVVvYW1IazUzbVRVRFJ3VjU5WXJaa3pWeEp3Z00vUmxC?=
 =?utf-8?B?dnZRYjRQUmxEUkIxTWxzZ3FrTStsTkZ1dVpCdnEvMUJVdE5BSCswK2hWWWNC?=
 =?utf-8?B?dUZScG94T0VOTktaSm5kMDQvRERLcS8zZjJ3WFB3a3h2Si9PZHZJK05XRlZv?=
 =?utf-8?B?OUpFUDB2SnZNV1BiSHlJbGgvaTM0N3hEY1U0NGtHMG9aOUxzdEt3QnpEWmNo?=
 =?utf-8?B?Tm8rYVVEVWsxUzJ2K3puL0hJTDZ0RU9LNnZBcVZHeFlaWGdXZmY3QlRaMHBw?=
 =?utf-8?B?MDFiL3FiejN3UWRxcHo2bFhYR2V0UXFyQXZqL3A4TUVVeURBekZpbi9jTkxT?=
 =?utf-8?B?aDNoemN1VVd6WUc1TWFpWHQxZTNaVGxsNlh2cGxZUXF4ZnJrTlZtbHhlNGk4?=
 =?utf-8?B?ZkVlbG1XbCtCZnJkaE1ydjY0LzkxN1Q2V1IxUThZdi8zZGppS3FmT3gyMFl6?=
 =?utf-8?B?Z1NlSmttNzllT3RTcC9ReWsyaWhwTWJDaHY1MG5reVFOaFdjNHN0Ky9Ldi9z?=
 =?utf-8?B?RDNoZ0orNm5NY2FlanFEbnpJSGFBaFhMa1B0dGdNcXdjZTJUbXpmS3Jidk41?=
 =?utf-8?B?ek1KTlgwQXRGV3pTZWEwT3lJdlkzdDc3UnRPQndLbGZsV1ZYUDZLS2xEL0Q2?=
 =?utf-8?B?eWRhQXdNYmdhVHRMRjdaVmZBYkJCK0JNYzR2L01UM3JiUW9VNVVtZ1VxcDVi?=
 =?utf-8?B?U0hodXRlYmVPRnBMN1ZzNVZLdDVJa0VLSWVhNHpmQmFKakJHeUNXMi8yeGQ1?=
 =?utf-8?B?cjhidjcwT1VIZmtOTUYyYlJkYnVjb0xFNDRjaG5qWGxtdWhuVkIxemVGcSs4?=
 =?utf-8?B?ZVNqamZRR2lZR1VYVTd4aUpVeWwvdEN2eC9md29hdUdQNUZpY2J1SnIwYUVH?=
 =?utf-8?B?VUpzbTlNbDJGenhqT1loMFU2bmZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70AC6D8A9CA30C4D9B57E204A9DCD88E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cee0039-f203-4ecf-5fab-08d99917a77a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 07:01:52.1135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jm1bCQw0zVtJjwDbHlfs85x6AwMhH479MOAMoXHGl8X9CMQSe9k+xAyaUvu23Wa7ZZvtNhNiKvSIgx6z/wSUxelllW4MGRXB1vKGeXmWxCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0048
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjcuMTAuMjAyMSAwNDoyNiwgU3RlcGhlbiBCb3lkIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFF1b3RpbmcgQ2xhdWRpdSBCZXpuZWEgKDIwMjEt
MTAtMTEgMDQ6Mjc6MTkpDQo+PiBJbiBjYXNlIGNsb2NrIGZsYWdzIGNvbnRhaW5zIENMS19HRVRf
UkFURV9OT0NBQ0hFIHRoZSBjbGtfcmF0ZV9nZXQoKQ0KPj4gd2lsbCByZXR1cm4gdGhlIGNhY2hl
ZCByYXRlLiBUaHVzLCB1c2UgY2xrX2NvcmVfZ2V0X3JhdGVfcmVjYWxjKCkgd2hpY2gNCj4+IHRh
a2VzIHByb3BlciBhY3Rpb24gd2hlbiBjbG9jayBmbGFncyBjb250YWlucyBDTEtfR0VUX1JBVEVf
Tk9DQUNIRS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5i
ZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvY2xrL2Nsay5jIHwgMiAr
LQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9jbGsuYyBiL2RyaXZlcnMvY2xrL2Nsay5jDQo+
PiBpbmRleCA2NTUwOGViODllYzkuLjY0ODM4NzU0Y2RlZiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZl
cnMvY2xrL2Nsay5jDQo+PiArKysgYi9kcml2ZXJzL2Nsay9jbGsuYw0KPj4gQEAgLTMxMDgsNyAr
MzEwOCw3IEBAIHN0YXRpYyBpbnQgY2xrX3JhdGVfZ2V0KHZvaWQgKmRhdGEsIHU2NCAqdmFsKQ0K
Pj4gIHsNCj4+ICAgICAgICAgc3RydWN0IGNsa19jb3JlICpjb3JlID0gZGF0YTsNCj4+DQo+PiAt
ICAgICAgICp2YWwgPSBjb3JlLT5yYXRlOw0KPj4gKyAgICAgICAqdmFsID0gY2xrX2NvcmVfZ2V0
X3JhdGVfcmVjYWxjKGNvcmUpOw0KPiANCj4gV2UgbmVlZCB0byBncmFiIHRoZSBwcmVwYXJlIGxv
Y2sgbm93LiBJJ2xsIGZpeCBpdCB3aGVuIGFwcGx5aW5nLg0KDQpUaGFuayB5b3UhDQoNCj4gDQoN
Cg==
