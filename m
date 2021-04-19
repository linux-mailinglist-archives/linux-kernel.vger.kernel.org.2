Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77A2363C83
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237808AbhDSHcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:32:04 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37340 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233438AbhDSHb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:31:59 -0400
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BA92A4061D;
        Mon, 19 Apr 2021 07:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618817490; bh=J71tlgiUzFvr+CGeB8DADxFCIbRN+Pi2iPy/sP7kmms=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=hYVHTCCDhkfeCVT/xNH9dOd8IUdkTQk3j32BrmMJT3Sz53Bi9LL2025YuijmbbtiQ
         t2Dz9yIybLBnsVdmbmXM5JIk+ANcG2gUezGKcSeKUI789o92fg1eB83Qh2JK7OpYe8
         pkOHODfO/MOXoKTQYayMoJTXQs51OF2frnj76ytRnViqEBChw7+LiwuckV47g8kBa0
         UwxxnehxmcSgQYxBepMMiQ3gL6YFPzqR5pIMCKgnt041edGMIVLkLDn3iahkBtlIh4
         26FzMjL9mFo13JS/EIUqLb83BK0+BazqwfzBSKQMPyzKVa9rxFZq3LyQ9st/ciNeES
         khMSXjl/Hng8g==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 74942A009A;
        Mon, 19 Apr 2021 07:31:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id C7994800C1;
        Mon, 19 Apr 2021 07:31:29 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="KTqT/Bku";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=At2W6KtR5W6SGsoyfv+IW0UojpFsW5Xc3Nknfs2rP2Be7tYr+jc6vwIE6ylf7Q9ALIOF2S6YCqy6ug1WNz+JA2BMkeNyXotUjMRDlDmaFz8DpL4QVJlQKaLf61gr3hE+JB6xhR11b23Com63GwVZrmSBwTZ8FZM0tizcQHMf4EGgltIDjLT9I2pwYqVJpT52Ve2SU8gJc5dHqzjQYCUPdyJnAn2lACq0ONOBn5IeqLDEWgsxDoq+oJ+cv5dLf7UkAyHKbarw/QEf5w0OCEuD21vKjjIjjSyqSPAZi5jD3qCnwGn8IGP5KxmG7x+tOcozu8T0THK4yI5830e7nhRzDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J71tlgiUzFvr+CGeB8DADxFCIbRN+Pi2iPy/sP7kmms=;
 b=P7Un8fNV6BMc4n6kxUwVQ3TDYEGDSV85GO+9ZTMwmf+oodb23WCEjZSNVe5YVhisrxSdScAZ+qdNyGwweElFcoydlTkp9KCcmY4kRPrTCHzhhCu7ctYfLT3wLjOGHYXowrEKz6vRxMdDAv9eSgb3woFcoIIJG7ahuj5zTezDGmOLOLnJJ2M+Ix9fjnvQqEvdzB8PYJ65hDtZPWtM0CklwaRKNOjBCTSHrxEWJnGMbZPYymtgVp7Q8DA0EWXoiGUtlf1IrTlMo4p/57aeV7nFio5eNSU5WkJTeKWx+RMMrXd92Xjmij7pxFc1gwTncUMp6k99V+blwftLXs2GwIkKSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J71tlgiUzFvr+CGeB8DADxFCIbRN+Pi2iPy/sP7kmms=;
 b=KTqT/BkuLCeoXKjGiBSbA3tBa3z0+Ejmy26BWj6hnxvL7m8tDWVoi9WtHobjkEc5Nv+kYwzZXe/3ggXYH28m0Wq/Kv33NcmHE6DNg+J72NC0LgKPvvYocoXSUnO0CGbYg+b/pNksOJIunSNasqXsPDVdIVqskr3pGIlmzxt+dsM=
Received: from BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16)
 by BY5PR12MB5000.namprd12.prod.outlook.com (2603:10b6:a03:1d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 07:31:28 +0000
Received: from BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1]) by BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1%4]) with mapi id 15.20.4020.027; Mon, 19 Apr 2021
 07:31:28 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Youn <John.Youn@synopsys.com>
Subject: Re: [PATCH v2 10/15] usb: dwc2: Allow exit hibernation in urb enqueue
Thread-Topic: [PATCH v2 10/15] usb: dwc2: Allow exit hibernation in urb
 enqueue
Thread-Index: AQHXMr7AshZ6H2V1VEWHOO8rr0oeJKq7doaA
Date:   Mon, 19 Apr 2021 07:31:28 +0000
Message-ID: <2ea0b9a6-1abc-6e91-1741-42ae7eacd305@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
 <20210416124803.D1C1FA005F@mailhost.synopsys.com>
In-Reply-To: <20210416124803.D1C1FA005F@mailhost.synopsys.com>
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
x-ms-office365-filtering-correlation-id: 2fe17ee0-7042-4141-f5d6-08d903052521
x-ms-traffictypediagnostic: BY5PR12MB5000:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB500028E4055A3AFBB0492D0CA7499@BY5PR12MB5000.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YsAD4CM2Q2EfG0qbHmIGr7iKhAxqUz3vEPgj7z8RJZoEaqcg6JceDXHfnVNjlM5UubHJgGOgsfmkLs/RPXFkX2bzgICu864keUu/wS0ff0zfI3U4VVIa7+lvZsBxeVYjDWyarqtR0/QobhA/ZmPCH+yyP/AgfqE6LSs5r3YYE8vlCzFh6gJi3O7vuhrT9qnPEnRkreu9c4S4ZXsHxjXPnTuo0WJuIiRK/E5xwSXOgYKoAoLcz79qNzFiCg3XcXEG6fX67ZmWORZZgWnZoPzj7rZdGy2rVU9/k9DPcYpODN5Zd/d3fG5PSzGIKfm7eBYZRTIvrrdbX8T6vKbjf7iGic2owN4GD1XtTclTzA+U973PBOpoXcM8kUVKE5KOdhuURDyzXwGkH1QlFqAmP9wgyyz8Ep2OMA6bn5AfvYplxwNfH88Z9sxs0EfHUURcRXyomf9+nfH6w8F3L2T+Q9rReRZatQc/VK1H7AHT9FlWoLScMxBBD/aMYiehAjfNu8PjwkTF9wpLgmkNPKRVOz/swFqiFjQ69T4maG5cPASKsj7OsDi9n9I7Y/qEYc48gi1mQaLaT6y1GPVcgCHMm3OTPaPTeHNPB2Yxja6cAwKeyqaqts7qgi55qoCIYv6/IGn2+BmNnupCvSqL8rMmZoIkdqVh5ro08p9cgkqmBikwBD8MLdJXNRLvICcxmoMeGB3C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3462.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(376002)(346002)(136003)(8936002)(31696002)(2616005)(83380400001)(86362001)(110136005)(122000001)(2906002)(31686004)(38100700002)(107886003)(6512007)(316002)(4326008)(186003)(26005)(8676002)(478600001)(71200400001)(66476007)(6486002)(76116006)(64756008)(66946007)(91956017)(66446008)(66556008)(36756003)(53546011)(6506007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RkdURGhpUzVDaFdEb0h5LzFpdEhpZVFZRVhhRytIZVRTU0VwTHZIZEU2Kys3?=
 =?utf-8?B?MDdpNkZCREdNQnNCYVcxSUk3RE9GRlViazhkbjFoQzlSS1dYYU9EMkFaelBS?=
 =?utf-8?B?M1ZzL1ErMnFxWlU4NWYxTlpWdVRQU1NaTTJETVNXR3o1QlBnMmVmL0RYUXZ5?=
 =?utf-8?B?a25GdTJDV0tTS3ZFdE9NUWEyM3lKVWF1eUVQNllDTGF0N1pCMmNMMDNqdHQ0?=
 =?utf-8?B?QWxsL0VBZDJSTVQ5eUVBQXBKb0h2ZzRtRWNudFRKZ0FGVGNDY01rNk1TdW1a?=
 =?utf-8?B?enJDUmlEMHpoa1VDcFNBRVJWYmhZK1FYWWdVVUNmQ0dsM1JvRWJkaGhPWVFQ?=
 =?utf-8?B?M1lGWlNwd24yNXhZYzhyQVZ0WUkyOUhYSUo4cC9nbVI2LzMrTXFwa2V4NWhW?=
 =?utf-8?B?RHI1OXE2VGN5eEVsekNHTkJVSEdiUnFZUVRjVEh1MlFyOWZDZEtQVTdZWDFN?=
 =?utf-8?B?Y3ZMc0J2c24yMER6U0J5Vm5xbjhvbTdRdDJoNXBOR25MdXpwRHhkZ3lLTlhC?=
 =?utf-8?B?L2JOT09MVDFaQ0syU1diaGs0WUgvNmxydzcvZ0dPS3JvZUR2T1NVamFoaHow?=
 =?utf-8?B?Q0FKczhPUVh1REZRUVA4bTBhV2FmUUVKdk9zZ0xmS00xMisxZkJoQ3ErOTN3?=
 =?utf-8?B?MEtjU3ozT2lzOWgrRTFjRUIycXMvWUNQYlFEaWhvWVU0WWhCMjZnVlp5Wldj?=
 =?utf-8?B?bnZxOUs3V1pvaE5WMVRHM3cxOStxYTB3YkNMYVRXUi91M0RVWnpTeFBPZnZx?=
 =?utf-8?B?eXYwWkRkTG1CQkc1dFhHM215RGpWcFpKeEpuNndHb3Y4R0k3VWx1RkxsM0JV?=
 =?utf-8?B?ZVlhRG5rTXdsSHMyVkVlNTJoYldQbEJGcHBIdFh5dGhFcW5Uemp1VzRNZStl?=
 =?utf-8?B?Q1ZJMWtLWUJjSXNoQ2N3RExmSmZaOEpoL09GdlVRbW1tcDVGQXBjck1ISlp6?=
 =?utf-8?B?dlVoZUlRZ0g1T1NEV1JxNENlb0tYRFZoVmN4SWZyVmg5Y0ZmelRUT1B5SnF6?=
 =?utf-8?B?MXdsOTg4S2F0VnRxU2R6ZklZMEt3K2U5cDl6ZmVMSjYzMi9ZMlF2M0pZU1ZK?=
 =?utf-8?B?TVFHT29GaTg1VXU4UGhjTHpzd0FqcG9ycEdVcW1qQ0VoeHVWUllzUnlWZzRZ?=
 =?utf-8?B?dGh6SnB2UlJmRTA2S0Q0UWloT2N4a1lBYUhKSjV1eXBndkwvMlR6VGVaMjJV?=
 =?utf-8?B?ejk3YUc3VW1DcnVjb3lORGxPVkhjak15cUM5dW5xc0RqSzFZTjJKQWo4Unov?=
 =?utf-8?B?VHh1MHMzNVhNS0NldHpLQ3M5aG9MdjhBWHcrc1d4azZaUVM4SlVJd0dEZ0NJ?=
 =?utf-8?B?SlRJN2REcXVlTEVkaVZqdTdCWGMxQTFNaUdqNnRGaUxJUkdBN1JMdzBxcVRi?=
 =?utf-8?B?bDVONTM4WUlScUJmRzRVQ2VWZHR0Ym5jVkNwYVRKZFlCM2lBVSswUFNKRWRU?=
 =?utf-8?B?UmdkOFBKQzlyOEdvM2wrbEl0VExSVzlOb1kxc0NST2JzZU9rREVJMVg4TTJ1?=
 =?utf-8?B?OXh5eTVtaVY1OGxOcjl3aDErbXJ3YTlzbkZuQlNYazJra25CTE81NCtXV1BD?=
 =?utf-8?B?OGNQNUVYblQ4K3dKZ0YrakNlNytvbUFxZFptKzZhVitwTHdBNjFUc3V4bkI0?=
 =?utf-8?B?LzJjNjlZMjFZT3l2MnVyOWJNK014cWFjSFNRV3lyYTByNkFMQlYrNVFLMXd1?=
 =?utf-8?B?OWx1MzVPS3hMUXowUnBUM296ZVZaZjk0QVMydnpDSHNna2IxRElnZ1NQV08z?=
 =?utf-8?Q?RASr9l28p2G8vF7z98=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0762CF5C3B658840BF0948F679761074@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe17ee0-7042-4141-f5d6-08d903052521
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 07:31:28.1318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AAOzSoPuiLWsLHpRmsFOch91lLbxE0hv39w/mpsFX5Fm7SmGSBTRL/qoBFgr17kXaV/zKPmBT8ziluwV0BvzMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xNi8yMDIxIDQ6NDggUE0sIEFydHVyIFBldHJvc3lhbiB3cm90ZToNCj4gV2hlbiBjb3Jl
IGlzIGluIGhpYmVybmF0aW9uIHN0YXRlIGFuZCBhbiBleHRlcm5hbA0KPiBodWIgaXMgY29ubmVj
dGVkLCB1cHBlciBsYXllciBzZW5kcyBVUkIgZW5xdWV1ZSByZXF1ZXN0LA0KPiB3aGljaCByZXN1
bHRzIGluIHBvcnQgcmVzZXQgaXNzdWUuDQo+IA0KPiAtIEFkZGVkIGV4aXQgZnJvbSBoaWJlcm5h
dGlvbiBzdGF0ZSB0byBhdm9pZCBwb3J0DQo+IHJlc2V0IGlzc3VlIGFuZCBwcm9jZXNzIHVwcGVy
IGxheWVyIHJlcXVlc3QgcHJvcGVybHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBcnR1ciBQZXRy
b3N5YW4gPEFydGh1ci5QZXRyb3N5YW5Ac3lub3BzeXMuY29tPg0KDQpBY2tlZC1ieTogTWluYXMg
SGFydXR5dW55YW4gPE1pbmFzLkhhcnV0eXVueWFuQHN5bm9wc3lzLmNvbT4NCg0KPiAtLS0NCj4g
ICBDaGFuZ2VzIGluIHYyOg0KPiAgIC0gTW92ZWQgZHVwbGljYXRlZCBlcnJvciBjaGVja2luZyAq
aWYqIGNvbmRpdGlvbnMgZnJvbSBpbm5lcm1vc3QgdG8gb3V0c2lkZSBpZi4NCj4gDQo+ICAgZHJp
dmVycy91c2IvZHdjMi9oY2QuYyB8IDE0ICsrKysrKysrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDE0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2My
L2hjZC5jIGIvZHJpdmVycy91c2IvZHdjMi9oY2QuYw0KPiBpbmRleCBjYzlhZDZjZjAyZDkuLjA5
M2IxNzE3ZGYwMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMi9oY2QuYw0KPiArKysg
Yi9kcml2ZXJzL3VzYi9kd2MyL2hjZC5jDQo+IEBAIC00NjMxLDEyICs0NjMxLDI2IEBAIHN0YXRp
YyBpbnQgX2R3YzJfaGNkX3VyYl9lbnF1ZXVlKHN0cnVjdCB1c2JfaGNkICpoY2QsIHN0cnVjdCB1
cmIgKnVyYiwNCj4gICAJc3RydWN0IGR3YzJfcWggKnFoOw0KPiAgIAlib29sIHFoX2FsbG9jYXRl
ZCA9IGZhbHNlOw0KPiAgIAlzdHJ1Y3QgZHdjMl9xdGQgKnF0ZDsNCj4gKwlzdHJ1Y3QgZHdjMl9n
cmVnc19iYWNrdXAgKmdyOw0KPiArDQo+ICsJZ3IgPSAmaHNvdGctPmdyX2JhY2t1cDsNCj4gICAN
Cj4gICAJaWYgKGRiZ191cmIodXJiKSkgew0KPiAgIAkJZGV2X3ZkYmcoaHNvdGctPmRldiwgIkRX
QyBPVEcgSENEIFVSQiBFbnF1ZXVlXG4iKTsNCj4gICAJCWR3YzJfZHVtcF91cmJfaW5mbyhoY2Qs
IHVyYiwgInVyYl9lbnF1ZXVlIik7DQo+ICAgCX0NCj4gICANCj4gKwlpZiAoaHNvdGctPmhpYmVy
bmF0ZWQpIHsNCj4gKwkJaWYgKGdyLT5nb3RnY3RsICYgR09UR0NUTF9DVVJNT0RFX0hPU1QpDQo+
ICsJCQlyZXR2YWwgPSBkd2MyX2V4aXRfaGliZXJuYXRpb24oaHNvdGcsIDAsIDAsIDEpOw0KPiAr
CQllbHNlDQo+ICsJCQlyZXR2YWwgPSBkd2MyX2V4aXRfaGliZXJuYXRpb24oaHNvdGcsIDAsIDAs
IDApOw0KPiArDQo+ICsJCWlmIChyZXR2YWwpDQo+ICsJCQlkZXZfZXJyKGhzb3RnLT5kZXYsDQo+
ICsJCQkJImV4aXQgaGliZXJuYXRpb24gZmFpbGVkLlxuIik7DQo+ICsJfQ0KPiArDQo+ICAgCWlm
IChoc290Zy0+aW5fcHBkKSB7DQo+ICAgCQlyZXR2YWwgPSBkd2MyX2V4aXRfcGFydGlhbF9wb3dl
cl9kb3duKGhzb3RnLCAwLCB0cnVlKTsNCj4gICAJCWlmIChyZXR2YWwpDQo+IA0KDQo=
