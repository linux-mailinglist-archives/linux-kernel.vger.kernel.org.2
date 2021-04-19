Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E51C363C7E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237755AbhDSHbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:31:37 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37324 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232530AbhDSHbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:31:35 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9A5E34066D;
        Mon, 19 Apr 2021 07:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618817466; bh=M5hOS22WO8oE5LOdqsJ8cF+158xAMO0dz0yFOfOTLXg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=dGSK5s9HqzpJ/DVqbymVikGmRm2v83MPoaZoPOkBW0ErqywdAk38CqZ/s2C7QFh9U
         yKr3owvbBMAMZYV19z4Da5MdffJUY9W2aekPuu7pzy/a42Fq9GuEd9iprkdHiwYgue
         wc1CuHiC2M9pfdJRJbs7mo+Xx1gWtp6p4QTun/Z7GxC0FRE5GhF52vmu/cu+m66lHg
         4OKRH49tIwTwwsDffUHE0eVXnTTYQBEia9mDm+eJKZduAE7L831PEKznnFifr/BdlS
         NiWZyxBsvzKiwMD0T3gOhvRgNlNoevSl2/0ZBbNxHHtMuhzhJUyPc8AJUR4N2j1vW1
         /lMlHs/qsEYVg==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7726DA0075;
        Mon, 19 Apr 2021 07:31:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 18C36802D1;
        Mon, 19 Apr 2021 07:31:06 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="jdikAbU1";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0V1YISm+WgTw3E4FgPVkZEH45Tjuge93+LDXRSlINAi+4Z1GHXdYNBY5G0BmedbKzNR0bZUH4km/aEW3nZP2N4dk3GGxfttXJyfQiQ7/0nJUEjRm1p+gGdYIPOMhSqbFnmtkw5aBBqCB25d4K7AjMh/kjCZ7bjWZCApWey/EkiXaCWDPTNM1InKtjuprLGKPUXTMp5aQ+Rl0+r0RdZuBurxJ5HEyZcAMGwrq5u7UwNnkenqObKPHuD+GgLbZcNLJDfPaDvT0IdHyhhliEyFL98o3v5Nyn4o0bNw+qgpU5JRIhIvjiWLC3tYtwR8L6i9tDI96BruheM88W+HbvyYPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5hOS22WO8oE5LOdqsJ8cF+158xAMO0dz0yFOfOTLXg=;
 b=SWpiwyW0wJZ5GaukYANstnLQzM9/kNZ0CrMtyYvnIECiS8fVdPHEWqkzkRbftZorLVMaKYdXWLNSDrRW1BhgJh02pVLIu0PKm0UXxLTq9R2RFc9cFbDxvYVWN5+4o9KWENcNyWvmd058/FBEm9TTQEjIjwhjjzu06KH4huj/nXa1sBe7WZ9GrmtLFrE2D7Y4TThxBkEp8T/6/GN/uW+UVLdQYDLRCg4gc+X2WE0z1hOoBfj2Pz+nHwwhtNek6Uo5HZOE5Ipt9iEldH2pRT5M/5fPgvL/kEfZ9Oj8P9dn1f9EeHPAL3x1elxhW1b70d3pSglE7qaRQCB1vPfH1OQw7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5hOS22WO8oE5LOdqsJ8cF+158xAMO0dz0yFOfOTLXg=;
 b=jdikAbU1b5O49v4fbCf/Iu4Ph0BGyNcTl8xo0uiSjBF1shMgn24tc4FkU0ozAN4zSDi2o6vmw4DsD1kX71ur00do8q+RP9t6NpN+gwJTO9hFT3ghHr0oJD0J1LqoPjwI3qubyWpI0ueHgaMCy4xFsRcKnn0U2T6IHBRddYYpVQA=
Received: from BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16)
 by BY5PR12MB5000.namprd12.prod.outlook.com (2603:10b6:a03:1d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 07:31:04 +0000
Received: from BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1]) by BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1%4]) with mapi id 15.20.4020.027; Mon, 19 Apr 2021
 07:31:04 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Youn <John.Youn@synopsys.com>
Subject: Re: [PATCH v2 08/15] usb: dwc2: Move enter hibernation to
 dwc2_port_suspend() function
Thread-Topic: [PATCH v2 08/15] usb: dwc2: Move enter hibernation to
 dwc2_port_suspend() function
Thread-Index: AQHXMr62xrHFVb8IukW7mSo2ssWLcqq7dmgA
Date:   Mon, 19 Apr 2021 07:31:03 +0000
Message-ID: <3f655630-74a2-3ba2-1a73-69de8fc3c8c5@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
 <20210416124747.EE79EA005C@mailhost.synopsys.com>
In-Reply-To: <20210416124747.EE79EA005C@mailhost.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.80.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08a28066-ed68-4ecb-bfaa-08d903051731
x-ms-traffictypediagnostic: BY5PR12MB5000:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB5000C1F6313794648D399D19A7499@BY5PR12MB5000.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UFRPgGJuCrPW4FLWx7YbSITCZpuC4PRiRYCHAazBDu/5zulK3WNIpkArT5aR7mZfxQHyka/5735kPnWo6/V2gVIge5Wq7F6+t3BskugPjzEx9R0mF6CcJo+6MYeSw+B39ubFqYoBouGnAIT713rLpfGJEaqlW6oBlhKSxfZmm0K1fo2pH1jfJGsisRYQeyoJnTLX7vMwp0ZpkDsAYYMAu9bKEACGXjMfEOnDn+bpD5iE29QG1C0ERKIwyhKlWvGC4GpCRWBzbGvVEL0EW0WWhi3ATgcYPWPqwZmAxnOHSh31eE/P+S8WsinxG/i2ZREhvu9EBjxreasFDqQgziuWbpT0siQ0C+Pyld88GROAadEWMAXsUwhHde91PLs+og90cpHSVT7L7JdlpFCH5HQj2EE5JzgpUzCYHCpZYC18pbsQ0ylDXuIErad4Dn/E8n7f4P7+FQB+c1Kfmua4tDHcRUlvh33KA93cyC3xRYBLs7q6COQ90uKOMgj9f9k3N7VpeQ49TN9J87fd2egNeJMCylB6itPvEsKIQ+vhPytZFScFYd+cwrDqfkcDybfRuJ9k/mIxPsw+7y16/+6djUBkFnHOpQsqWtZ+/slH9Lxkr45dcWmTLs1mS8fb0fNbLd+el/83U5OZ/WyH8uuLKxV0KTDhKsI9hQ5jContptQyjS+ssQnIWxNluwgbT4JEyZPV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3462.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(376002)(346002)(136003)(8936002)(31696002)(2616005)(83380400001)(86362001)(110136005)(122000001)(2906002)(31686004)(38100700002)(107886003)(6512007)(316002)(4326008)(186003)(26005)(8676002)(478600001)(71200400001)(66476007)(6486002)(76116006)(64756008)(66946007)(91956017)(66446008)(66556008)(36756003)(53546011)(6506007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZVVybmJ2RUhvQjB6N1pIOUswVk8vYnBpUWZSTUxtREErYzV5UTJwRlkzSkRt?=
 =?utf-8?B?SFU1NDk1dmg4Y2JHVnBGUmRTVmhBdmhud21yQ0cxb1BaeUl5b2VWZElHRFFl?=
 =?utf-8?B?RGFKZkwxTVQyY1kzQ25heUJvMEt3REhSTlRSZThraHJkUEJEKy9FdVFkckxJ?=
 =?utf-8?B?ZUlqRWpuZG12WTY1Z3BVL2VFYStaTWVkSWpXNTd2THBsd3Fjb1J0cEZ0SkhG?=
 =?utf-8?B?eTRrMGpsN1hCRHBQZE1BVmNybXZNeU5oOVpyWlFLTExqcVVKTXB3RU96azNj?=
 =?utf-8?B?b1pIOHBXZGNrbHVDVnYvaDlWL1ZpdkpQVk9BcW9sNUEra2Jpb1JCOUtQVndx?=
 =?utf-8?B?ZHlZWEVSWlViOERvQmhFOHdQM1VxSUJ1NDFnbSt5aXpzUE1obnN4bFFUazFk?=
 =?utf-8?B?ZUZiT2FQZ1oySDgxSWpIc1RkL3NpSmtaUnRLa2hwT1NoM3EvenZrcXJqRHlI?=
 =?utf-8?B?T3dhUTB5VjNBZ1ZmbjVtSkVRdUhjMkZmMVN3NStZczJTMjdwMVY2cnQzN28y?=
 =?utf-8?B?WDg3R2NiSU1hemF1alcvcWNyQ0s4NGVxL3dFRUhHaHZQd2RHRGZ4MCtDK2gy?=
 =?utf-8?B?YUxUVVAvMG1ORDlqQmpQRnRsUHoxYjNaOWdhNmYxZFlEQ3FydCtMbTZjT1FK?=
 =?utf-8?B?SVRTSk1sYk5TaXpKTFRIZ0V1aUxLTlp4V1EvYitTK1BLbmQ0VFlmdzQyWFFB?=
 =?utf-8?B?SUlNVjliSHJ5a21sWkRsekFGNmFxREtYQVA5ejhRWnZ4WWVWN3RFRkpqV082?=
 =?utf-8?B?dzFoZnNEWTYyS2lPYThsWmYxQUhwY1ZEa3pZMkhLN2FualdHY3NMZ1d4UXVw?=
 =?utf-8?B?ZzdZazhXc0E4cE1UZWlGTUVRWkxscXZranJtS010MXZNazJpcnRGcDZHd2NC?=
 =?utf-8?B?aldScjRSM0lPaDcxYzVESll3WFhBa2MrQ2s4VVlKdGRPdW9wZndvWTd5bm5Y?=
 =?utf-8?B?cVpsV2ZlVmRUbjg3MGRJNXJ3MkFsQklacU9UbE5IUDgzOEg3MmJ5TDVmekpP?=
 =?utf-8?B?aWhEUENucnlRRE1GalpsU3MrWEtTUW50UFZ5czFEV0I4dWFxVndhTjFFT2lU?=
 =?utf-8?B?a2k5YURUMGYvRm1xenZDU1IyNWpjM0dpVlpuZlhrUlYyY1I5ejQ5M1YvL3F1?=
 =?utf-8?B?azJIZkdyNThnaHVxbC9nOWZhaUw5RzBpcjU2TjhIZDlvQ0NnL1MyY2pEZjU5?=
 =?utf-8?B?N2NHckJOZGlTZkdLcXVuZUwvU1U4VmdWeitDNFhLYU9tZ1ZhcVZkekVCNGly?=
 =?utf-8?B?RWlkcHVxNmRUNDM5bFhRK21sYy8weE1GSUQveEFIZlc2aG5JTWRZZGpONlQx?=
 =?utf-8?B?VUw2VUttakp2bU8rYUFjK3poNHRIUWxwM1o0VGpTMHdOc0dEQk95eEQvZmh6?=
 =?utf-8?B?ZHcxNitHbVczOWNCaElWSHdqM1ozbXJJSEdwTGFEUnh5ZTZ1SGN0TnNDR3ZU?=
 =?utf-8?B?cmN3dStlaThvK3BZeHdxSU4wT21rSU9mazlRRHBudnB2MlBmU1ZtYTRocUps?=
 =?utf-8?B?UEtobEMwaEVFTTlyTE5sK0VkRnBkRm9xMmdhQjlIZjVEMVFMVlkvUFo2OS9H?=
 =?utf-8?B?TVMvSDUvUlhjQ0FISnUrc2xDR0lua2V1UXh0Tzhhd3lYYkFKbC9MWUxOb1lo?=
 =?utf-8?B?TXo3ZVpPTDRZQ2JvYVZBT1ZEQ2d5TStTSVNJd0VkWlI3NnRjQm1heVd3azFu?=
 =?utf-8?B?MVc0QVUzb3lFd1VzanQvK1VZK0xTOUliMFpISGtUc292bXA4OHFqcmhzWDVV?=
 =?utf-8?Q?7lF/qnAawUGKS2yQr4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8896D2249D15834EB19D936504C72CDE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a28066-ed68-4ecb-bfaa-08d903051731
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 07:31:03.7408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uy6TJeAQUjJokailI9QKX1PmPPE6SONWX5SIUcpbFPEoNXmk5QqJUQ6fYnfueXzpuOKR5c44fhND9jTrm2l6sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xNi8yMDIxIDQ6NDcgUE0sIEFydHVyIFBldHJvc3lhbiB3cm90ZToNCj4gVGhpcyBtb3Zl
IGlzIGRvbmUgdG8gY2FsbCBlbnRlciBoaWJlcm5hdGlvbiBoYW5kbGVyIGluDQo+ICJkd2MyX3Bv
cnRfc3VzcGVuZCgpIiBmdW5jdGlvbiB3aGVuIGNvcmUgcmVjZWl2ZXMgcG9ydCBzdXNwZW5kLg0K
PiBPdGhlcndpc2UgaXQgY291bGQgYmUgY29uZnVzaW5nIHRvIGVudGVyIHRvIGhpYmVybmF0aW9u
IGluDQo+ICJkd2MyX2hjZF9odWJfY29udHJvbCgpIiBmdW5jdGlvbiBidXQgb3RoZXIgcG93ZXIg
c2F2aW5nIG1vZGVzDQo+IGluICJkd2MyX3BvcnRfc3VzcGVuZCgpIiBmdW5jdGlvbi4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEFydHVyIFBldHJvc3lhbiA8QXJ0aHVyLlBldHJvc3lhbkBzeW5vcHN5
cy5jb20+DQoNCkFja2VkLWJ5OiBNaW5hcyBIYXJ1dHl1bnlhbiA8TWluYXMuSGFydXR5dW55YW5A
c3lub3BzeXMuY29tPg0KDQo+IC0tLQ0KPiAgIENoYW5nZXMgaW4gdjI6DQo+ICAgLSBOb25lDQo+
IA0KPiAgIGRyaXZlcnMvdXNiL2R3YzIvaGNkLmMgfCAxOCArKysrKysrKysrKysrKy0tLS0NCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL2hjZC5jIGIvZHJpdmVycy91c2IvZHdjMi9o
Y2QuYw0KPiBpbmRleCBmZjk0NWM0MGVmOGEuLjQzYTIyOThiN2Q0MiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy91c2IvZHdjMi9oY2QuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MyL2hjZC5jDQo+
IEBAIC0zMzIxLDYgKzMzMjEsMTggQEAgaW50IGR3YzJfcG9ydF9zdXNwZW5kKHN0cnVjdCBkd2My
X2hzb3RnICpoc290ZywgdTE2IHdpbmRleCkNCj4gICAJCQkJImVudGVyIHBhcnRpYWxfcG93ZXJf
ZG93biBmYWlsZWQuXG4iKTsNCj4gICAJCWJyZWFrOw0KPiAgIAljYXNlIERXQzJfUE9XRVJfRE9X
Tl9QQVJBTV9ISUJFUk5BVElPTjoNCj4gKwkJLyoNCj4gKwkJICogUGVyZm9ybSBzcGluIHVubG9j
ayBhbmQgbG9jayBiZWNhdXNlIGluDQo+ICsJCSAqICJkd2MyX2hvc3RfZW50ZXJfaGliZXJuYXRp
b24oKSIgZnVuY3Rpb24gdGhlcmUgaXMgYSBzcGlubG9jaw0KPiArCQkgKiBsb2dpYyB3aGljaCBw
cmV2ZW50cyBzZXJ2aWNpbmcgb2YgYW55IElSUSBkdXJpbmcgZW50ZXJpbmcNCj4gKwkJICogaGli
ZXJuYXRpb24uDQo+ICsJCSAqLw0KPiArCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZoc290Zy0+
bG9jaywgZmxhZ3MpOw0KPiArCQlyZXQgPSBkd2MyX2VudGVyX2hpYmVybmF0aW9uKGhzb3RnLCAx
KTsNCj4gKwkJaWYgKHJldCkNCj4gKwkJCWRldl9lcnIoaHNvdGctPmRldiwgImVudGVyIGhpYmVy
bmF0aW9uIGZhaWxlZC5cbiIpOw0KPiArCQlzcGluX2xvY2tfaXJxc2F2ZSgmaHNvdGctPmxvY2ss
IGZsYWdzKTsNCj4gKwkJYnJlYWs7DQo+ICAgCWNhc2UgRFdDMl9QT1dFUl9ET1dOX1BBUkFNX05P
TkU6DQo+ICAgCQkvKg0KPiAgIAkJICogSWYgbm90IGhpYmVybmF0aW9uIG5vciBwYXJ0aWFsIHBv
d2VyIGRvd24gYXJlIHN1cHBvcnRlZCwNCj4gQEAgLTM2NTAsMTAgKzM2NjIsOCBAQCBzdGF0aWMg
aW50IGR3YzJfaGNkX2h1Yl9jb250cm9sKHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZywgdTE2IHR5
cGVyZXEsDQo+ICAgCQkJCSJTZXRQb3J0RmVhdHVyZSAtIFVTQl9QT1JUX0ZFQVRfU1VTUEVORFxu
Iik7DQo+ICAgCQkJaWYgKHdpbmRleCAhPSBoc290Zy0+b3RnX3BvcnQpDQo+ICAgCQkJCWdvdG8g
ZXJyb3I7DQo+IC0JCQlpZiAoaHNvdGctPnBhcmFtcy5wb3dlcl9kb3duID09IERXQzJfUE9XRVJf
RE9XTl9QQVJBTV9ISUJFUk5BVElPTikNCj4gLQkJCQlkd2MyX2VudGVyX2hpYmVybmF0aW9uKGhz
b3RnLCAxKTsNCj4gLQkJCWVsc2UNCj4gLQkJCQlkd2MyX3BvcnRfc3VzcGVuZChoc290Zywgd2lu
ZGV4KTsNCj4gKwkJCWlmICghaHNvdGctPmJ1c19zdXNwZW5kZWQpDQo+ICsJCQkJcmV0dmFsID0g
ZHdjMl9wb3J0X3N1c3BlbmQoaHNvdGcsIHdpbmRleCk7DQo+ICAgCQkJYnJlYWs7DQo+ICAgDQo+
ICAgCQljYXNlIFVTQl9QT1JUX0ZFQVRfUE9XRVI6DQo+IA0KDQo=
