Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AF23612E6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 21:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbhDOT3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 15:29:21 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:33534 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234859AbhDOT3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 15:29:19 -0400
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5EA72C0153;
        Thu, 15 Apr 2021 19:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618514935; bh=TgyjGMAO5fYS0jeqVph948HCPvZuGYUWKB/LOQ59M38=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Cqzczecme+vlhQTMEEQZ1XsSYM55eopJMG0bmR1DwqNGgH3XbjaKd9toRk6RqzObl
         8jN4xvQuNVOUZQ58xKJIiEJqdWbjZfV71bqRUkBHnSxE3T4ZqeLpdZWVRrg7KFziww
         krU37FCxhL20qtQL8lN2tYbtukdsINCRjiMW1txa/irNmxrWHJTONPpb6ZYcf1GtiD
         t4usicqE+WTwTaTaNJlGVi61oObO/3N7zh85K1qhn8TTGrOnnL7Bta+kMCYQ08c0Yw
         BDrYLo3cfWHYjsfx3hV7B62G1dvn9XtsWKTtCfQYVrponxPegmxA2nibQAQ0sbgVeY
         VP13neUV1100w==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id B586AA0082;
        Thu, 15 Apr 2021 19:28:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id BFC6B800C1;
        Thu, 15 Apr 2021 19:28:53 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="F4wQtNi6";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeFSe+R7BacRbDdV70l8ZmnxQ5fJOqqPZDrWehAeokPAIzeUiMkweyzMh5AFU6BhlytgEvSP94LAUzdgUbdbSmAf8L2KmN/r2TfLMqf7pKjEpHYbZnin7s4hEhOEIfOciXn6Ew+fFwXzrnUjzQO026TJ4rEDsrRy+UoD+1k0K0uQDHbqyY/GzCN448sLvi60ug2APvaheZ9zv0B8euEFFVGqwDhFRIboLWA/N0nIRuFEY2xJc9SalHSpuLh3l3Wshac61NkPT1ZO4XCjTjouOWiODtwHPELGppo8Qrq3iTwwMnWboz0bwdVQLLr2hwxJBEV/9Ona9XTIs0Kbw5UIgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgyjGMAO5fYS0jeqVph948HCPvZuGYUWKB/LOQ59M38=;
 b=Na6ZtyUty+JlFuF9RwUOGyNLgjS2LddnhSpOKWo1ylDqTKejgAvAfKJmVjCto+gYO5dRVrEGZujSaMblKmNK2G9MHw5WABQeKXzRu2Mx7Gx6JhekFg6umTl1360SiCiwhFrpu3eP3zIny3JgTFAcPcT8HCMet+55wnWYNBIBVS4AGMSDAI+mO5lB9YelIZy4zitwcuQpzPvrUr3eYMPS+4hTEFdq5Bsj9L6eo2VCQZWi6255Ce4lnGxVeXXvWWg4uVRMuuL323t9o+EbM89ERrfiUSxDddWpsW2WsPOtnqpXOqqsXRaA1jydZacR8P9DAQOvU30ut6AVnKb0+fzFIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgyjGMAO5fYS0jeqVph948HCPvZuGYUWKB/LOQ59M38=;
 b=F4wQtNi6mAooRCIMfq+2zTZr9QMtYInZ33TzbaTMIxLB24XG33YpQrjukolNmua4sVbpqKXfgZWuIbY/WqqCBRNlKA1a6BOvINGLfsRB9pyWxiEMIdR6h4p5YiMUgO6cycxtlQvnfUrDPyOIiL4Y7lZy+MLjG59iGj/rlXRGeTw=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB2951.namprd12.prod.outlook.com (2603:10b6:a03:138::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Thu, 15 Apr
 2021 19:28:51 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c%6]) with mapi id 15.20.4042.018; Thu, 15 Apr 2021
 19:28:50 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Felipe Balbi <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH] usb: dwc3: gadget: Avoid canceling current request for
 queuing error
Thread-Topic: [PATCH] usb: dwc3: gadget: Avoid canceling current request for
 queuing error
Thread-Index: AQHXMX21njNOe3FucUqaGApnopX6p6q1HZsAgAC/NYCAAAMrAIAAGCiA
Date:   Thu, 15 Apr 2021 19:28:50 +0000
Message-ID: <4c2c6d76-e4d5-67f5-d91c-7e402b0828f7@synopsys.com>
References: <1618439388-20427-1-git-send-email-wcheng@codeaurora.org>
 <87mtu0njvj.fsf@kernel.org>
 <677afbd3-6c72-29c0-ca25-88dd1bff335a@codeaurora.org>
 <2e956314-b3e1-5c0e-104a-7416cf81f3ba@synopsys.com>
In-Reply-To: <2e956314-b3e1-5c0e-104a-7416cf81f3ba@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3ba68dc-3ef2-4bf4-a418-08d90044b2ed
x-ms-traffictypediagnostic: BYAPR12MB2951:
x-microsoft-antispam-prvs: <BYAPR12MB29514DC69C5E0AD962FAA59DAA4D9@BYAPR12MB2951.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TDIV3PqrbyBS7SyzgKaYnjmNbUeR8YsOFVkCXjO3hjhE1W4PTjbVwRn5+P7EVzAj5ejpsW72daOoOshZNreBabplYFJf5p74aGGnUroS3qP7XVLrNUFRoRf7IdmjMNk0RuFAKk0A1BrKnKuSuvSGIXo2c6T3l4Hs5CP/gAt+TDARNFVpraz6g12CkzoI/YGdtj/9zlSkY4g2C8Pg5ZKI+vjFB9p80/IUjfoggPuBumk+Acya1K2iUMKyPEmL1aAqJ/RhUQuQ0qix5OF8FzYCrdyipVVdTuZeRZHG2AjEGrHZ9MAL9IexijO2aZG8c/1vdwMXTtsq7xVNcmzpE328H54/YHfI8hn4iNkg/c1lDI8X06VvWUMFYJcO6IEPrP9lM3tIWCPRGhMJZALnlYKX31P49aSJ51ldrPyMpjPnCcRcctVKyFrE3AlK1pTBrbM5mdecXmtkB0BffIjLe0DDVZJh5NdQTpNIlCiF9lDK3AjN5/I/RISvzkbLQmABFsu1QjRD9rr3SpDBnJ6fb266ZinMU01v9sKawHLQi0UukkLcDklIBp173lsHDqQ47t6YHxAmYRYMvSXD8Db5gEZjLoRdXBrmJ9FjpcewdwDkg5rln6s9t3KnMhUzTIVJdCUcfPtF+N3nCVfQm0rjTSWLY1fH7Wj4HAzdRDK7QW359vNE5QeUfyMjbcQ0I3hwI7Fn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(396003)(346002)(136003)(6486002)(86362001)(38100700002)(71200400001)(122000001)(5660300002)(26005)(4326008)(66556008)(66476007)(186003)(478600001)(8936002)(316002)(2906002)(31686004)(110136005)(76116006)(64756008)(66446008)(66946007)(31696002)(2616005)(6506007)(6512007)(53546011)(83380400001)(8676002)(54906003)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WitXbkN2NnF6Tk1kL1l6cXl5TFUrODg1dksvWE93VjZpRFZYN2l6OEcvVWY5?=
 =?utf-8?B?a0VzZ0ZMb2FNWVVjbW5jR2x2a3FJRldmMmhYMFlRMDROWnlNbFdhMGF3SEx2?=
 =?utf-8?B?cFZKOHorV0FuK0NHOGFJYldDSU1UaldGOFNOOW5lMUpTcEl1VVJicjZmNm1X?=
 =?utf-8?B?QjFPWnhPNEtBMExTUWNkRGJNRWdVSmNHTlE0Zm9zMVlLZzNUVkhqRm0xZ25F?=
 =?utf-8?B?SlJVdFp2RmFuN1BlRnVZeENKL0VvZUlna1dvcE5ydEZ6Zi9RRkZhdjZyU2pz?=
 =?utf-8?B?Q0hVUTlRSHk3UDJrckNrNXlYUTVscEo1cGM3T09qa0duaXY0NE4vWnY0bzZW?=
 =?utf-8?B?YmtOZW43bjZsZHVobmhsYUNEeHF5OCtJQzhMak5Td0pGN043RzAvTHE4eGNZ?=
 =?utf-8?B?WUlvQUFsT2FUNUF4dUZUUWZsMWZWWU92Mzh2ZGwzN0FsMlBZYUFzSWdmVDky?=
 =?utf-8?B?U3dYOHJYUm1kdERSZmFLTlZ5V1c0dFU3U205YkE5TXN6dU9DdFo4ZUJaWmJE?=
 =?utf-8?B?bWZ6YkJ0MkRRekRma2VoQkhJY3dzSTZ3cGsrbm9mSnlSeXNuUDMrOXM1NDVM?=
 =?utf-8?B?eWtkYUlVaDNSZERGNnVCbi9JektnTkxyWkIxR0ljOFN1VGE2M3dveUk5WXh1?=
 =?utf-8?B?am5KK0V3Wkw2blRwUVI3Y2pPcytHdlBrOTNpUGNPK2JUMTZScTBVNmJkc21Z?=
 =?utf-8?B?MlhqR2tXTWd6ekJsMnArN0ZSMnEzT3pvaHptb1YvSXNoSWpXSjYwcWhubjZK?=
 =?utf-8?B?TklDV1cvNVlaS3dXQjJQM01ncGZXNWxrWlViWEUwV2NXMHhoVG1lKzF2S1Jk?=
 =?utf-8?B?aDM3MTFoT3lzTFJkdW9UVnJjOFdvT3VCN08rTEZHeFdlQkZWd1hSeDhBVmJy?=
 =?utf-8?B?bU9FVktnU3FnNFdOTkw0UmF3Wm4rd1hUZE1yM1YxcnUyMWFMZ1grNGZNZTlD?=
 =?utf-8?B?TllvYk93MXlLSDYxcFg2eGhhY014S2RXTHljTzQwYWFzTXhHVUFRNTZRbDly?=
 =?utf-8?B?Wm5kM0p4WU5hRzB3OGZOclEwMlVDOGQwVEo5c2dHZENLeTNPaC9BdE9MS2cw?=
 =?utf-8?B?ZzdEOFB4UjVSVjBuVDNBNGxLMy9RQVh3RXVDRUFZV3QveHdiaXBsbXNISnEz?=
 =?utf-8?B?dTY4dHJwc2hpTWlIcW5sSVZEZElsTGZyYkNHb1hVZ1JGcUdzWnFUcm5GQytu?=
 =?utf-8?B?RmFHUFcxMGVCei8yc3JjRnU5eFJkazJ0OCtvMHJwTExGcm9ocVVCd2d4TGFm?=
 =?utf-8?B?d3JyaTRSdnpoZzBxakcvM3dvRExmcVdjZnB6aHM1U0FlcVRlYUhlbVUyVllm?=
 =?utf-8?B?djdGTm81d0J4aUswV1hzSVpjeElxcFVNRkZYMlRjTlZJOGtxUWlXdW5kb0Zl?=
 =?utf-8?B?clJiRzhmRVhkNWk3V1FyR2NhcWU4T2d6N0htZEF2S3FscVltS0Y5ejVta3ZC?=
 =?utf-8?B?Sk5CdUh4dERrYUhFemFKUlpCczIvT1JFYTBvRmJwdGdmQ0tsZUJZYWJlNmRx?=
 =?utf-8?B?RkhHSzlsUEFLMmRmaW9PVSs4T3Z4a1l5OTVkVEJuZS84aDk1eXdUSW05VVds?=
 =?utf-8?B?L1dhanQvVU1MbzFFVVV2ZHNqMTMxbzFQYUJxRW9IVml5Z1kvVEdIRjhmQnZs?=
 =?utf-8?B?b3BOWU1TZXFzNU1od3hQbm4za2VBWlU5Z0puQnlVNC92bTVvbTc1OThQQVJs?=
 =?utf-8?B?NTJ0T2dwUXZheGdWZzBJdDI0MGhJbkYvTXZlbWliQUdkZFEvV015UkJlMTAx?=
 =?utf-8?Q?L/8Mwk2WtXaIw4gDYinPy+5PIAcN7vd4Qm+ncp+?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5060DDCAD6A0DF4DBF646BD3237BDB49@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ba68dc-3ef2-4bf4-a418-08d90044b2ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 19:28:50.7401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1PsqW26HLyozgk3i8BMmNxDNU+Q8c0TQE1hWGpilpiU9gr/lhYmpmJseijNSrBqwSmWUETn7sorpZkYdcwRWYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2951
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpbmggTmd1eWVuIHdyb3RlOg0KPiBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+Pg0KPj4NCj4+IE9u
IDQvMTQvMjAyMSAxMToyNiBQTSwgRmVsaXBlIEJhbGJpIHdyb3RlOg0KPj4+IFdlc2xleSBDaGVu
ZyA8d2NoZW5nQGNvZGVhdXJvcmEub3JnPiB3cml0ZXM6DQo+Pj4NCj4+Pj4gSWYgYW4gZXJyb3Ig
aXMgcmVjZWl2ZWQgd2hlbiBpc3N1aW5nIGEgc3RhcnQgb3IgdXBkYXRlIHRyYW5zZmVyDQo+Pj4+
IGNvbW1hbmQsIHRoZSBlcnJvciBoYW5kbGVyIHdpbGwgc3RvcCBhbGwgYWN0aXZlIHJlcXVlc3Rz
IChpbmNsdWRpbmcNCj4+Pj4gdGhlIGN1cnJlbnQgVVNCIHJlcXVlc3QpLCBhbmQgY2FsbCBkd2Mz
X2dhZGdldF9naXZlYmFjaygpIHRvIG5vdGlmeQ0KPj4+PiBmdW5jdGlvbiBkcml2ZXJzIG9mIHRo
ZSByZXF1ZXN0cyB3aGljaCBoYXZlIGJlZW4gc3RvcHBlZC4gIEF2b2lkDQo+Pj4+IGhhdmluZyB0
byBjYW5jZWwgdGhlIGN1cnJlbnQgcmVxdWVzdCB3aGljaCBpcyB0cnlpbmcgdG8gYmUgcXVldWVk
LCBhcw0KPj4+PiB0aGUgZnVuY3Rpb24gZHJpdmVyIHdpbGwgaGFuZGxlIHRoZSBFUCBxdWV1ZSBl
cnJvciBhY2NvcmRpbmdseS4NCj4+Pj4gU2ltcGx5IHVubWFwIHRoZSByZXF1ZXN0IGFzIGl0IHdh
cyBkb25lIGJlZm9yZSwgYW5kIGFsbG93IHByZXZpb3VzbHkNCj4+Pj4gc3RhcnRlZCB0cmFuc2Zl
cnMgdG8gYmUgY2xlYW5lZCB1cC4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogV2VzbGV5IENo
ZW5nIDx3Y2hlbmdAY29kZWF1cm9yYS5vcmc+DQo+Pj4+IC0tLQ0KPj4+PiAgZHJpdmVycy91c2Iv
ZHdjMy9nYWRnZXQuYyB8IDUgKysrKysNCj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMg
Yi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+Pj4+IGluZGV4IGUxYjA0Yzk3Li40MjAwNzc1
IDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+Pj4+ICsrKyBi
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4+Pj4gQEAgLTEzOTksNiArMTM5OSwxMSBAQCBz
dGF0aWMgaW50IF9fZHdjM19nYWRnZXRfa2lja190cmFuc2ZlcihzdHJ1Y3QgZHdjM19lcCAqZGVw
KQ0KPj4+PiAgCQlpZiAocmV0ID09IC1FQUdBSU4pDQo+Pj4+ICAJCQlyZXR1cm4gcmV0Ow0KPj4+
PiAgDQo+Pj4+ICsJCS8qIEF2b2lkIGNhbmNlbGluZyBjdXJyZW50IHJlcXVlc3QsIGFzIGl0IGhh
cyBub3QgYmVlbiBzdGFydGVkICovDQo+Pj4+ICsJCWlmIChyZXEtPnRyYikNCj4+Pj4gKwkJCW1l
bXNldChyZXEtPnRyYiwgMCwgc2l6ZW9mKHN0cnVjdCBkd2MzX3RyYikpOw0KPj4+DQo+Pj4gd2Ug
ZG9uJ3QgbmVlZCBhIGZ1bGwgbWVtc2V0LiBJIHRoaW5rIGVuc3VyaW5nIEhXTyBiaXQgaXMgemVy
byBpcyBlbm91Z2guDQo+Pj4NCj4+IEhpIEZlbGlwZSwNCj4+DQo+PiBUaGFua3MgZm9yIHRoZSBp
bnB1dC9yZXZpZXcsIHdpbGwgbWFrZSB0aGlzIGNoYW5nZSB0byBqdXN0IGNsZWFyIHRoZSBIV08u
DQo+Pg0KPiANCj4gTWFrZSBzdXJlIHRvIGluY3JlbWVudCB0aGUgZGVxdWV1ZSBwb2ludGVyIGFs
c28uIEkgdGhpbmsgeW91IGNhbiB1c2UNCj4gZHdjM19nYWRnZXRfZXBfc2tpcF90cmJzKCkuDQo+
IA0KDQpOZXZlcm1pbmQuIFRoZXJlIG1heWJlIGEgcHJvYmxlbSB3aXRoIHVzaW5nIGR3YzNfZ2Fk
Z2V0X2VwX3NraXBfdHJicygpLg0KDQpUaGluaA0KDQo=
