Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3023736EF65
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 20:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241144AbhD2SSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 14:18:13 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:57200 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241133AbhD2SSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 14:18:10 -0400
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2A1AC405C4;
        Thu, 29 Apr 2021 18:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1619720244; bh=lIic3PP9LwGLMhtY3imJw5bc2mo+m+TAUz/vwZhrokM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=XkHh6jM48dmju2npERsOnvuiKYcj0b92HGc1SBbQr0YLlFZByPvHdkwzR9i5FJORS
         KoieXI4GauLCUFTVzcgn6oVDoGC+TbmUBuuU9jn4D0sw/qqJBCSMIA5WBLb7r81bK8
         CoKT73zGo/xxzaRXf8gWV11CT12swo+aPyV88wiiMtTO0vg91GYG+qYLXFtGAwoUq5
         wdmcMyKxXkiQZSwjXwJymZuc0CRPJ6G7EUVvSJL2HrAgfmxe0hCouLUPDRLcj2BGOg
         NIN4cgDBMb/tB12cSyCj7oRXv+pri80cU0e0nyoaHTggH/0ND/2koa95/M+6fSq4Ve
         kZcVRNw/aOstg==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8EC27A007C;
        Thu, 29 Apr 2021 18:17:23 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2053.outbound.protection.outlook.com [104.47.37.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E96B34017D;
        Thu, 29 Apr 2021 18:17:22 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="wISHb4Fz";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZAl5IB0KB6eEviUVJGcIDgv6euIc8k6ZC2pss1tEwWykGE+ryyobUEtnxsuoRJn5tEwEFDWctWsVkGEDb2u+ThYmpLzrXjnEW3Su4d7q6UsU18twRK/LjnUTHexq5jqbDrwTlT8bmkZxbQcHBG35P86+/Rw2QW/LjuOP3m8+MVfq5Z7PznbPtSZocLAjSGVMkplFkhQFGDF0hH7HZUsIloQwJUFwIp18Ie4HQzew6PeURgqYssmsDtDPwrMz8O9kKR8wYUAuxsSn8mR0vIn3/+tYynnvgrT4ehv+FeCOQ5m5Gk9Kc3m0SCg9iHQa+ShPjXIinnH6zFJCK2ETnoSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIic3PP9LwGLMhtY3imJw5bc2mo+m+TAUz/vwZhrokM=;
 b=BGNGzmnHO/KtuHoOi0bWJzGUG0YdlC24/agP7DhAQODs/AYaeJ7B5Ukog7GiP/Tz+GPlF3aK7/g4WhETHNveNIehmmW1cPxzfe1bvwqGId//1L2NTFFseHArhT0njE28dBNIA8u7tAiefNc1zbP5g6W62Jyj/z4hp1HThtevWBOnLIKadAJpDmoaEKath5zwlKk1myBSQkwmg9SK/z5uahEPjaB4JJuoDTFXc9Xe/et2San6yWs5X9H+D7vJd88AHJWw9sCqHcmDm9w4O5y3toujTf9G0OipA6QIjGMuDH5/jTmP92/TJSfPEgxoeWXlNOJBwfKLs6DOS4lcv/vH0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIic3PP9LwGLMhtY3imJw5bc2mo+m+TAUz/vwZhrokM=;
 b=wISHb4Fz2kTi1x9zp828jDnKRG37Ks7Th5oX6ELj2Ajah037bjfHdYhk7VGETBy+G9SFDpoFLfe9ZZC51ouGisMNStXfP6hujXPSmyTux2/YgKIDig5K8U5PlE2ebkB5dR9YL183vzoXUXAlWThNNJgC9UNt6hD187eqi0PG6ac=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB4982.namprd12.prod.outlook.com (2603:10b6:a03:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Thu, 29 Apr
 2021 18:17:20 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d%7]) with mapi id 15.20.4087.026; Thu, 29 Apr 2021
 18:17:20 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARC: entry: fix off-by-one error in syscall number
 validation
Thread-Topic: [PATCH] ARC: entry: fix off-by-one error in syscall number
 validation
Thread-Index: AQHXOHpES7ZmhLssX0aB/7vkj4ik5qrLZ8cAgABvDQA=
Date:   Thu, 29 Apr 2021 18:17:20 +0000
Message-ID: <c0bb4c71-a3c6-2ae6-c978-d48732a13e78@synopsys.com>
References: <20210423195257.892560-1-vgupta@synopsys.com>
 <8d154e49-d77e-012a-81df-c1946b669bb4@synopsys.com>
In-Reply-To: <8d154e49-d77e-012a-81df-c1946b669bb4@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3db42dd7-5ec7-4bcc-133f-08d90b3b078e
x-ms-traffictypediagnostic: BYAPR12MB4982:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB4982E6D3C1E2E287D91B552CB65F9@BYAPR12MB4982.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b5yZ+Dqda2QZFlacd/e9BOe6uBEw+JKUkSR4gaSmOouftzQ+yM5xnvVWyjFF7UDu12YorPg0eGFa26osdOqVMxOhoLAgs/CS2i2GP3mWooj5GYDK4e3ktDyVr/qRZb4qzWNZcefhGNBDTu3+5/egO/oClWM0l8kUBYsAlJMCas27GaofCb3q/IRAjE4tIU2yu/E4DQva3uwPLcc8RWs/jYfCo2we1ieKrfrTKU7LnJkPhDc9TyO7TCjrlye3avVZdA4SFhtJrbniZV4+AJ2E7QuqFEFx+/l6Ul7l+mjcwoLzxRILBj8znEjj31pXOsQUVVJnhlZcS72kVXSlcMMhhzTiDMrhFpIn5fcM7Rjv9lag1eZT2uJeqNYnM2JJXvR2oZ82vzQuB0W1xzipn583HO9WFz1qbF4rS/IdVqu//pQdsOqSpby+csGW3NJWGtXBMW028XoCPa7T2Gp49T60B455miMardXN+/dszqu9gH/lz8ufDghjLYS+rTIXtO0XJs3EM08e+YAobqlgL1mHL1iE+NqVkejVqQYRlcs/WK059a/lWKcZ1aotjfka9Ooxctww5KAKMLpSWVNJLhmwFRCv06e/D+ibNpsJIJPdGeLEXMGuewhg9IQT1neiXDWUS9ie+7VAwPgj9Css8ko2csm1NSNjwU7sZiZWbzUWuOGXS4q0ri/pCT4jKAaPPRxc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(376002)(39840400004)(136003)(38100700002)(5660300002)(53546011)(26005)(478600001)(71200400001)(122000001)(6506007)(66946007)(36756003)(6486002)(83380400001)(8676002)(2906002)(76116006)(86362001)(31686004)(31696002)(4326008)(66446008)(316002)(66556008)(66476007)(186003)(64756008)(110136005)(8936002)(4744005)(6512007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?R1FQcFh5SGRTYmd6N3NKMWpFSGdEZGRQWElka2RqbFRDNlBENmMrcVJrNG9W?=
 =?utf-8?B?eDhZdW96ZnhUS1kvZmhXcGJRUFVsNk50d3B3cFBSTy9udis4bjJiZ253dStt?=
 =?utf-8?B?c0cwbTN2UWpua2k4VHJFZWd3elZPbTVQUEMrdXplczIzQXVmZCtnbThnQ0JD?=
 =?utf-8?B?V1gxeklid2cvZmhKaHlMKzhvakw3aUY5c1VOU29xb1ppMms1dUVNdU5XSFQw?=
 =?utf-8?B?TG5tWCt3bnlrQ2ZlMzJhWmI5cmFJMWk5bW1yYlJIUG9QY2doUFA1T2w4VVli?=
 =?utf-8?B?QzI4eEd4UjFEQ1lWd25obXZtdHlpZjJXVlpyak1Qc0NwcTNhY01sMHBrM0pY?=
 =?utf-8?B?S3V1WDhRODVud3ZucUlmZVY0VTNyQlB3VFFYMnNuQ2RTSWNHMUhUTWNvZmdp?=
 =?utf-8?B?SmZGYTF0TnU2QjAwR3hZbC94OTlQRGIwdzAvY2F0SysxN3pSMkhtUzJTY29t?=
 =?utf-8?B?UUw1NCtwVTZHZlNGMk1GbTJnSlJFcXhvVS9xRnpJZFkwdFpuT0oxYlZDMHdv?=
 =?utf-8?B?U2FEcUJDOUhHOFhwY0JVNXZBcHc0czdIR3JvSm1CU1NlZlduQ2VUK1dVQkIy?=
 =?utf-8?B?Szh1N0E3VW00d1JsUUpSYTVvaStSd3FDUXhuZnRFcjFqZW1JYjBBdkdFY1Zv?=
 =?utf-8?B?YlU5Q0RyQzVXeHNxSlJYWUtWM3V4ZlROSHlmS25VUFhJbnNXQUNSL0pXaHFO?=
 =?utf-8?B?UWZWN2VjTHROT2luTEM4c0tHdWxNWlYySEYrVkRpaFo3M2pyTWN1bUtHMGYx?=
 =?utf-8?B?RTczTzMrSDVNajdsWlFMZmFlQ1BrbmRuNE5IM1RUeGI4dkR2Z3hvQXNJQVBN?=
 =?utf-8?B?aExSbXBSNnFLR1V4R095azlqMUlyNDI1NnpVeGo5NjJneW9MRVZnOGxuaHhp?=
 =?utf-8?B?eU1UVGhYUmpJQzhkMitDWnAwZ0g5L3NZdXprRkZIWVBpOHFwbTRjeUdvdUQ5?=
 =?utf-8?B?bFFHTS9rWisrbDRpTHlOZUNkaERqY1JiRkUvTzY3eklIVTY5ZS9Cd2dSOGpC?=
 =?utf-8?B?VzlsTzdEUDMyZkFsT3FBa2xjTXZrOWtuUlo4cGpsQ1RUVm01SmdBTDM1ektJ?=
 =?utf-8?B?eW5sakRpeG11YVdyR2dJUlNqL1FsVHNNWHpoVWUwY2VmdVdnRzNXWHZOQTJV?=
 =?utf-8?B?NGtJenFacGRlTGhGQ0o3ZldBZmN0cDM5SktxNjhwWE9DUXJvRGl1WDlVT3pP?=
 =?utf-8?B?S3llOFdjc0dWTDdQYUlrMEM2SGxONUZZTXRXL0sxOFJoNkk2Rk1seW9wanp3?=
 =?utf-8?B?Q2hJME1lVWhKRWQzQU9sRlV6QmpTUTQ5RWd5L2VZZnorYjhIYlJXYU96b1ow?=
 =?utf-8?B?NHc4MXBBSHpRZTlJWTNKRS9YYStzdUw5U3VqU3M1NGFzMnF4UEtvTjd3RjZ3?=
 =?utf-8?B?OXNtSlZXdGt6MXdIdGxDdlZJYW1POVFLanFJMzBua2Z5cnU0QjBzMWZKdHkv?=
 =?utf-8?B?WVZXbFdBcUdmdS9pRGxxZlIxaGFCVWkzU3poRFhMenNvbkxVVnBQbDdZVk1l?=
 =?utf-8?B?MHlGRUh6T3A1L2RqL2RrRENabjRnMzlHeGo5L3p0QUFZQnJzOFpDaHhXaTEy?=
 =?utf-8?B?R0lKQTZoVHdINVFGWWNzWGM4bXJHSnpHWDd3c3EzUGo3WDBwZGl1bUx1aU4w?=
 =?utf-8?B?NHNQT1VYMDMvN3ZtbWIzS3pScTR2aEZMMElaOEgvczd5cWVVc01vSE9Qclg0?=
 =?utf-8?B?RlMzN1lUem1YRXROdFRKRVU3WXVxY2ljSU5abmNlS1RyQ1d6WDlRTjFSa0Qv?=
 =?utf-8?Q?8tmsalTlZT1YLB293w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FA7A94581E38C46956FA75BD1807181@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db42dd7-5ec7-4bcc-133f-08d90b3b078e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 18:17:20.6843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6bQdaj+xqDNQn7KwtaNiw1Cw3DwzRonIg2hg8V4ytWEBGq7vX+jTECNwB313qFwS2WlaSzdpy3gBPn6o12awng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4982
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yOS8yMSA0OjM5IEFNLCBTaGFoYWIgVmFoZWRpIHdyb3RlOg0KPiBPbiA0LzIzLzIxIDk6
NTIgUE0sIFZpbmVldCBHdXB0YSB3cm90ZToNCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FyYy9rZXJu
ZWwvZW50cnkuUyBiL2FyY2gvYXJjL2tlcm5lbC9lbnRyeS5TDQo+PiBpbmRleCAxNzQzNTA2MDgx
ZGEuLmFlYTliNTU4OTkzZCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJjL2tlcm5lbC9lbnRyeS5T
DQo+PiArKysgYi9hcmNoL2FyYy9rZXJuZWwvZW50cnkuUw0KPj4gQEAgLTI1NSw3ICsyNTUsNyBA
QCBFTlRSWShFVl9UcmFwKQ0KPj4gICAJOz09PT09PT09PT09PSBOb3JtYWwgc3lzY2FsbCBjYXNl
DQo+PiAgIA0KPj4gICAJOyBzeXNjYWxsIG51bSBzaGQgbm90IGV4Y2VlZCB0aGUgdG90YWwgc3lz
dGVtIGNhbGxzIGF2YWlsDQo+PiAtCWNtcCAgICAgcjgsICBOUl9zeXNjYWxscw0KPj4gKwljbXAg
ICAgIHI4LCAgTlJfc3lzY2FsbHMgLSAxDQo+PiAgIAltb3YuaGkgIHIwLCAtRU5PU1lTDQo+PiAg
IAliaGkgICAgIC5McmV0X2Zyb21fc3lzdGVtX2NhbGwNCj4gU2FtZSBwcm9ibGVtIGV4aXN0cyBp
biAic3lzY2FsbCBUcmFjaW5nIiBzZWN0aW9uOg0KPg0KPiA7IERvIHRoZSBTeXMgQ2FsbCBhcyB3
ZSBub3JtYWxseSB3b3VsZC4NCj4gOyBWYWxpZGF0ZSB0aGUgU3lzIENhbGwgbnVtYmVyDQo+IGNt
cCAgICAgcjgsICBOUl9zeXNjYWxscw0KPiBtb3YuaGkgIHIwLCAtRU5PU1lTDQo+IGJoaSAgICAg
dHJhY2VzeXNfZXhpdA0KDQpUaGFua3MgZm9yIHNwb3R0aW5nIHRoaXMuIEknbGwgZml4IHRoaXMg
dXAgYW5kIHJlcHVzaCAoYWZ0ZXIgdGhlIG9uZ29pbmcgDQptZXJnZSB3aW5kb3cpLg0KDQotVmlu
ZWV0DQo=
