Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B2B3189CE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 12:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhBKLtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 06:49:01 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:33054 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230468AbhBKLWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 06:22:23 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 59163C00C7;
        Thu, 11 Feb 2021 11:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613042479; bh=5JZqsAa1R4mmS832Rb10kMryCErbbIRhoY/zOq7Z7pk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=NM/WZHbhOi++MuiBX2YE25mx2VnUfHlOp0nkyeVXInQs50JysyGePdzmUCWmUV3yp
         w2fNWoImvcQE6dgv5DXJJQIK2rRwd83A7PeRvinO1Ilq889EXMVyUJTrdyOtQTRR5/
         4UaArgIWUmNuYBLXcQUdE7w/V5f3YsNcLLBBVaO9g9FaXNDsukBnrpT6ENOL9TJL6b
         r1U7+w0vZ/43SzR3aYZgxH1IghGqzn/Big4w+1TL8D3nUpRPIVw2JtR/0+eTYdaPaz
         c1w3kWCVhWm+yi1n83ErAAQCpICJbesGAwFfsggQB+EFKPSFvrl683X44Jo32Ae36v
         +mYa4jF8oS5aQ==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id F0258A0069;
        Thu, 11 Feb 2021 11:21:18 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2056.outbound.protection.outlook.com [104.47.37.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9BD5B80214;
        Thu, 11 Feb 2021 11:21:18 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="W3W6TtmU";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKwQlIProsIKl/VLPFQnWBYGI6Z3jyDh7zGM5wL2IjoXm6l2maevCysUZfbrFLg1ugrA5Vs+KAv0VEYpEA4DcpSlPrMwG5tVCZjPoxR7JMRwItpVMWkkjfwB7z3qeyeqTk5YPp7OKeowozr1xn4vJg9QNMXX6lDfleQaKE0LlqQXFzp424f9kvDvSngNulVyFAldu9eNflJjkcKzGAppEa7IGzkKOa01Vk/eZtIB48oNbyQXvAze9fFpg5mHzHRGCgTbXpmhs2lzrstYvKVvhItdepooqQpbDS3MnS9ebTIUoTA4bJLvWcNbilFrdcrD5QJl0UI62SiIR5aGy3179g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JZqsAa1R4mmS832Rb10kMryCErbbIRhoY/zOq7Z7pk=;
 b=BWrcBpVsnUXICGps3Bo6aJKtlcKlyh1W2CCnZdk/wxOoBwl/5znHbq4789lSNbAznekOPLXQ9lUdm4VXhjgykMFAqdHBguJsOH9Y2918JYQxbRTivX/ESR4JL/c7YVTLERX+c9vB94WsdI6Otx8x1Nr7gd5r+T8k+HSJ7cqq83/Va+E8s3hq1mwHFkPgTR95ILiY+9j5r17ZTwv6IrO2tvMjmBFKhGt1EK/M1RDfmoldSyBHsHtiq2o7AlAC467P7B83tAqZj5ZqPW564sj2LBa7XaCj8l2gLTFDjMuEQol9O8cKBZTX0SsgBrn7xj9awckn7NUUF2gE76lM1IWB9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JZqsAa1R4mmS832Rb10kMryCErbbIRhoY/zOq7Z7pk=;
 b=W3W6TtmUpdHf4xNk8ym/6JV41sPq8kwDutef5ay1zinaSIpLZawhy9nFo+KXrd6C1HYBWYXfUncGsJ4BS6TBGFmiBumG82GO4YTDiv3g0r9257wegOnjuKrA1DWxkcE1QhkM6mKQZwmav509iUzu8yyZkn/k2X62HR28TRl2yhc=
Received: from BY5PR12MB3777.namprd12.prod.outlook.com (2603:10b6:a03:1a9::14)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 11 Feb
 2021 11:21:16 +0000
Received: from BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::e9e5:66f2:5a15:8c1c]) by BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::e9e5:66f2:5a15:8c1c%7]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 11:21:15 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Linux USB <linux-usb@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RPi4 DWC2 gadget doesn't copy data to a buffer in ep0 SETUP +
 DATA OUT transaction
Thread-Topic: RPi4 DWC2 gadget doesn't copy data to a buffer in ep0 SETUP +
 DATA OUT transaction
Thread-Index: AQHW+CsepOTWzTdUVEWkekFV1Dw/f6pS360A
Date:   Thu, 11 Feb 2021 11:21:15 +0000
Message-ID: <2e068eea-605c-3f7f-904f-2a1d7279879f@synopsys.com>
References: <CAB=otbTVxa=nGWF4K1AYcYyPceYYRkC_1HYSb_Nhu6C9RMZEHA@mail.gmail.com>
In-Reply-To: <CAB=otbTVxa=nGWF4K1AYcYyPceYYRkC_1HYSb_Nhu6C9RMZEHA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.95.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d44a6cb-15c3-44a7-aeac-08d8ce7f2597
x-ms-traffictypediagnostic: BY5PR12MB4290:
x-microsoft-antispam-prvs: <BY5PR12MB42900C0B790194337F3F697CA78C9@BY5PR12MB4290.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wPVyNVbErSa8D7HwJWx0pY2Q0Fpx9S9lhduui9OLcVkKWHEwism7CV8OB60jOz1iT5r9WTSGGhS9dSQOUW0bl0Ht3Nip31nz6PnRJJPnn9wSZblbCDsIL9R4NhATjL/aBWnXNW00oTG+l1vjtvOoDkqFLmKfFfjHQffC483Cy/NVbe4KrydG8Z4y/9ZuFlunBODd6zqw5UkbgUNPqgpBrdELAc04PQlzc8dQvNhr7RrxMPyyZ52tG/llsdAk4wRow+Cu3dQhKCa+sSl9earaRWLwsWMIBXnax3LHO7Vwu8yZarFDDNRFdIc9+NNBcifpoQBv6emmaWkHvAzYgVpuHnYu34mq7bxxIZlJ3MbO6aSJva5uGopr7SMzjfpBlnk7hpZd5baU5j/pc1u/JM6EpSso3RmDCya6A65pZhhrgRxceD3us8hVfgRnx+HM3HzA/tV4V7OJQo6jXkqGu01ULblN1j8sYE6UqwDIHo9g3ms7nyMU5SAEsPIfclkNiSbZ9R60Vk81YX6/h83XeX50Md5rPO3HS9kmGLAWlGp/IW5zuP6Co+QWKOKnG9Kpjo8Lq6CmNNv8vY283gcHMtvUmmetseQTxIR2+xxSVzhwibU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3777.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(346002)(39860400002)(136003)(31686004)(31696002)(83380400001)(86362001)(66946007)(8676002)(66476007)(478600001)(66556008)(76116006)(91956017)(5660300002)(4326008)(66446008)(71200400001)(186003)(26005)(6506007)(8936002)(53546011)(2616005)(6486002)(36756003)(6512007)(4744005)(64756008)(110136005)(2906002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Z1YwTVNTbjBMdWNpZlN4Q2pKSXdvWjBzOWhRd2g4MldGRVJuR0U4dzBYeVVq?=
 =?utf-8?B?clBMaUY1REJYNVN0N3hFQVZ3YWd4ZWh2aEJBL2lxK2g4Ky9semVpZTR1MWcv?=
 =?utf-8?B?bllkVmFyK1ErME1MUlhrZWwzV0ErWmNZMkhUQW9sUThkbkpVcnFXUEtIVmdV?=
 =?utf-8?B?aXMydE1WTjlaNHRNQ3NFaXVJYkM2SXNvZi8xS1lWM3k2S0E5dHFDYlh4SG1B?=
 =?utf-8?B?ZnZmcExNU21rckgzMElSajhzTlBML3ZyQ3I4ZWlXSENacUNrNitqQjRDNStP?=
 =?utf-8?B?U2ljTUJDWFdkWmw1SW9SeXRzS0E4MkFSQWhiQ2lxOVhxSWxKdVRacW9tK2Zj?=
 =?utf-8?B?Qk4zYlpWSkJwWVBNQ3FLdC9mdlRlUWt3Wm1leitYOFJ6RVp5ZkwzTVlKaGFh?=
 =?utf-8?B?eWZMeTVUNHlZVDZSQnRIMTJCUlY2TzVubm5QL3Y0ZGxENVdXb0JmeEtVN1JC?=
 =?utf-8?B?VGQrcm5UOFZSdWlyQ3JDZ1pLZlJGeDhhV1FDckMySE0ySEhRSE05QVVWY3FI?=
 =?utf-8?B?VGd0MmJIMitDZk1EOTJuSDljSnVuMEx5QjNyMmVReDNJWGxENGlzdkNVYWFS?=
 =?utf-8?B?MG1BWWo1d3g3Z0JsbXgwRDhnV1NNem4va0JxSWtLNitBcjRXc2pQdkFGTU85?=
 =?utf-8?B?SW03eGNvSUIrVzRERVBYeGZMN2RKQXhPMjBDbUpwVDVFQWZlaldQQ0ZhRGUv?=
 =?utf-8?B?OG81aklRZ1V0dTBYKzYwL0JhME9ycmJ1RmdDRUs2b2JEMGdMTFVxeHVkaGdI?=
 =?utf-8?B?VHVLWnNPWmpNWm1sVFJlNTNBWERDSzUyS1RWMWdCYjdJc3AzdGg1aWM4T2Jp?=
 =?utf-8?B?bE1kSnRKc2M3RlgrdmdaQmoxRk16dkQvenMrOHpmUE0yeUVIWnNWQnhuOTJI?=
 =?utf-8?B?Y0U0aXJ2SDFXdVFrT2NjK01qNVNSL3c2KzRtZmEzaWZVZXlJdVJ2dU9GTWg5?=
 =?utf-8?B?amo3Rk95dmRESFZTTXE2SHVXbmxHQVFjUUhpenBxV0V5U0F5M1h1aDVRQmNl?=
 =?utf-8?B?alBMQVh4U25qRDNDVWd1dUQ4OGtwOC9wTWhMVk5hdUFPRFJOcFRYNG02MGRp?=
 =?utf-8?B?VldJOXBGd2R1elI3L0F3c2pyd2hReGJZT0VzK0J0RnhDa256THlBbnVoMGV5?=
 =?utf-8?B?bkpYMzlZcXFMS0wya284NVBNNHBwYURKL2lHVGxpTVVKalhlQTZjNXdDQmww?=
 =?utf-8?B?WW0yYzY0SGhnMUpZdFc5QWloVHdWREp2TDVkYVBnSG9YdFNoQ3VTM2EwWVBy?=
 =?utf-8?B?cnVZd0oxZEFzVkFLa21aUDY3eVZaTDBuKzZPVWdHWSsrNW9xUGk3MGh6a3FY?=
 =?utf-8?B?UW5IV1VLZ0s1WGNPOHFaTVRFdGhkOU1nVklZTDBxeUp4cWR5OVZzakFoQm5a?=
 =?utf-8?B?VHMzcUM5QzlkdE9CQjhPVnZxSHBBcjgrNzMza3ljdU9WRlRHUVBTQzRwNXNp?=
 =?utf-8?B?Qm84YzdtRGduUytoU0FVcmsrMmtYOGl6RjVINEdySWdYcGFmNmIyUlBXYTEz?=
 =?utf-8?B?aEs3UW1oaEhyQUN2VlJ5TmNJYmNnUUd3M2JnaXZ6N0FqYy9JN2p3d3lLVlgz?=
 =?utf-8?B?dEdSUllHdXVHYmZXRzkyZzdZMXhHRENDMjFXSnhoaEdhUEJsTGdTbjBweUw4?=
 =?utf-8?B?NTFGaEpQUTZFeEpnay9UakJzR29tRVVWMThTclFVelcrVHFac29nRmNaOThV?=
 =?utf-8?B?QnlZTGs5RVNNMlFseEltdE94YUpXcjVEMWRlTVZucUNKWXJteFhQcFNHekQ0?=
 =?utf-8?Q?YAKmiQoXznIyGRDCcE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <106D46502217F244BE7E63D8B771AC79@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3777.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d44a6cb-15c3-44a7-aeac-08d8ce7f2597
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 11:21:15.7952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B+Vpz/ETQ9zPepbuFANZZjmwHq/qIO4rS8eN/tR9naA78UpUUUeQZmBE4RARQVJInoMEtnIg17+xn5zdOdCVlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUnVzbGFuLA0KDQpPbiAyLzEvMjAyMSAzOjQ0IEFNLCBSdXNsYW4gQmlsb3ZvbCB3cm90ZToN
Cj4gSGkgTWluYXMgYW5kIG90aGVyIFVTQiBleHBlcnRzLA0KPiANCj4gSSdtIGN1cnJlbnRseSBk
ZXZlbG9waW5nIG5ldyBmZWF0dXJlcyBmb3IgVUFDMS9VQUMyIGF1ZGlvIGdhZGdldHMNCj4gbGlr
ZSBWb2x1bWUvTXV0ZSBjb250cm9scyB3aGljaCB1c2UgQ29udHJvbCBTRVRVUCArIERBVEEgT1VU
DQo+IHRyYW5zYWN0aW9ucyB0aHJvdWdoIGVwMC4NCj4gDQo+IFdoaWxlIGl0IHdvcmtzIGZpbmUg
b24gQmVhZ2xlQm9uZSBibGFjayBib2FyZCB3aXRoIE1VU0IgVURDLA0KPiBvbiBSYXNwYmVycnkg
UGkgNCB3aXRoIERXQzIgVURDIHRoZXJlIGlzIGFuIGlzc3VlLg0KPiANCj4gSSBmb3VuZCB0aGF0
IHdoZW4gRFdDMiByZWNlaXZlcyBlcDAgU0VUVVAgKyBEQVRBIE9VVCB0cmFuc2FjdGlvbiwNCj4g
aXQgZG9lc24ndCBjb3B5IGRhdGEgdHJhbnNmZXJyZWQgZnJvbSB0aGUgaG9zdCB0byBFUDAgaW4g
REFUQSBPVVQgc3RhZ2UNCj4gdG8gdGhlIHVzYl9yZXF1ZXN0LT5idWYgYnVmZmVyLiBUaGlzIGJ1
ZmZlciBjb250YWlucyB1bmNoYW5nZWQgZGF0YSBmcm9tDQo+IHByZXZpb3VzIHRyYW5zYWN0aW9u
cy4NCj4gDQoNCkNvdWxkIHlvdSBwbGVhc2Ugc2VuZCBkZWJ1ZyBsb2cgd2l0aCBpc3N1ZSBhbmQg
dXNiIHRyYWNlLg0KDQpUaGFua3MsDQpNaW5hcw0K
