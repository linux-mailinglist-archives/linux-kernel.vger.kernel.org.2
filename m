Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD7E42E9B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbhJOHMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:12:53 -0400
Received: from mail-eopbgr1300115.outbound.protection.outlook.com ([40.107.130.115]:21790
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234497AbhJOHMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:12:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1bD68Dh2+9C3b6Pi2JF7mlnVjPL/4PnLgGbenfGnNmf3LSMXfeNJ8bsPswEf4ZxkJ0DU4bD9+7NlUbyw1h68Pr3Jrev161yoo2sCiOd35hvo2CQyT3wT7ImBTwNMMcxGOiA2OlDI5aWO7mWTIdleE5iZE35PCubT9xwQXaWWofoGcMNO7kdKWDwIa2XJvR68c1YIwMAT6EHF3oBktw1LbNsp1MepqkVVD3u9fmCQ+lbK+tYEHpVMfohsAM3vowzt+dvGNAhQW03ReYfOptej0oL+2fSws9h9cwrGbcTG9H4Dx9vuP7eAOKcXlMqUk/7cVMizg69ax7QRxAdRB9+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hj1n2OfjRBzgPl1YxpBrxXFwgUrjQX/x8fMQZTwO0sA=;
 b=jVgOwe3C3QQloeNEU1C0fepLxNgsAHjjPBMctU7FpesvWJphop+VCceq9UwVE5Q8DveppdI/wVicWtJp5wK+yaHxgTvH1PepINUbAmcwG7boZVgR7R14dHnffwNYl0VzvBVKeNd1/DQKDIq1VPqGpFoDnJppedlb56osVhX99rA1W218mb53s6EB/ISS4CFRDiVmkeOHnLkZ7IH2P4AEupBVuzPc925H8F7rppGRJGHwiYp4FLgG686B+wd3E7yik3MOmIp5Far7uy1WbPKmZCB3nTrttY36+zprSbgWiDMj3ZJ1amXHyOI0wLPaCbFRoRpGCMS0jbiuLJz+aXQxpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hj1n2OfjRBzgPl1YxpBrxXFwgUrjQX/x8fMQZTwO0sA=;
 b=pZS8C/Z+KUZuLlZtCU+A/TheDaxRxQHLykobXhmLSD5EMse2VfgUob3Qp0Y/QswqoNCFqluWkEOZ/kvKqyAtM5uofpEHXsZzEIL8tNPuF1bUOL1noq8A9Gg4b9JRwlbOnGqoE1hA19FFc6hpWLGA0700Zfj48k/thnNIFGqqWdY=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3404.apcprd06.prod.outlook.com (2603:1096:100:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Fri, 15 Oct
 2021 07:10:42 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 07:10:42 +0000
From:   =?gb2312?B?zfXH5g==?= <wangqing@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "efremov@linux.com" <efremov@linux.com>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSB0dHk6IHZ0OiByZXBsYWNlIHNucHJpbnRmIGluIHNo?=
 =?gb2312?Q?ow_functions_with_sysfs=5Femit?=
Thread-Topic: [PATCH] tty: vt: replace snprintf in show functions with
 sysfs_emit
Thread-Index: AQHXwZEdTSmZ3fODK0+PS0xWG6Zi26vToSSAgAABTbI=
Date:   Fri, 15 Oct 2021 07:10:42 +0000
Message-ID: <SL2PR06MB3082E66577E193F9EE9A09F8BDB99@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1634280696-5056-1-git-send-email-wangqing@vivo.com>
 <APcArgDIEqvUlprBO4*Tk4rA.9.1634281148594.Hmail.wangqing@vivo.com>
In-Reply-To: <APcArgDIEqvUlprBO4*Tk4rA.9.1634281148594.Hmail.wangqing@vivo.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: d11a8a59-afd1-7cda-f0b3-22c6aaf6c333
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22b111c3-5092-4e5d-3e15-08d98faae6b8
x-ms-traffictypediagnostic: SL2PR06MB3404:
x-microsoft-antispam-prvs: <SL2PR06MB34043D15E6130A0179C01EA8BDB99@SL2PR06MB3404.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xqUfvh53jRMDakf1eQidaOOnbUBncUSlDXaITjzljwDjbWHj66e2reD8IizXcm1IVVI34boqDtPN8kh98W8A6ENr1d9F15yFf5k6ctGKHU0ZoAGsGz+p4LYtI7kPmJ2FvoAdEakC7jUw69CzkARW04LqdXXsaKc9OD1JFaSEihC7twALLr157JQEbAOmYm5dLERr7jhi1jYywipRgD5IetozkeHYA1tClFF3a/LvskG6c0ffvCKVYk/zfOa0P90cd8lDO4rKW1zbF4GyFK6gg8GrJDfOS2nt3rnWPwm975ffqdoAfYpVDaWJW/+IbInpjIbNkwKfuFn+87cJPChylWQjK0Xcx7oGiFrgQcslEMJp04V6wrvvDfFH7UE+yFMTnS8Q6lNrJ+MSP3RIjR0oRdj23dIhBiQCDBqMNQxfPIZzsB9golpSxVuFiy5q2bTSOJyHso6lP49egvrLOTlwRTrvUiVYjVAdB9YWu+dqD421mguLG3Skmtcx2hI84NgPU6X/C66NHZTyUB7iilFd6vRrb1qDrJQQq5o2yGBjXzbxCWFXglQWWp2ne9SVNmPEORh71Z24stbUxuLINNxdFs2D93potZhvLPpBT4uIsv6M1HQejUlbkeD4wRmK+IVd3OE53sOEiCxNepH73Sn/QOHUJC07L4rGeaxs2bU+J4spZgUjGG0/2CnnIeBvPCtdI0P1w0BbnYuEk4TnM+V47Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(5660300002)(316002)(66446008)(38070700005)(6506007)(54906003)(55016002)(33656002)(224303003)(110136005)(83380400001)(8936002)(85182001)(66556008)(66946007)(122000001)(76116006)(91956017)(71200400001)(186003)(4744005)(508600001)(52536014)(38100700002)(2906002)(7696005)(4326008)(9686003)(26005)(86362001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UTJhRHRtR3VJd3c3WHhJRC9TdDNBNkQ0bzhDMkFQYXdyN2Fna2VIQjNDbmpC?=
 =?gb2312?B?VjdFekdxUnJLUzZoU1dmcmJHeTVMTnJSQVQvRGhpYzg0UzhQc1IrdEJkSzJt?=
 =?gb2312?B?dC9TQnBUWmlTS2FrQ1lPMVdJWTNsUUZJWW1kL05NeVNnNnpQekdsV1VMazJv?=
 =?gb2312?B?VEdBMDIzSDR4ekFteXdMKzFIL1FhRXN3U29FTUcyaXhvT1FXb2F2Ukx0eVlN?=
 =?gb2312?B?M0kvc3haVHFkNzI1YkljRk9hdTNtVUFOcWp4RS9idTZ0UlROVWVXd2ZlT2VX?=
 =?gb2312?B?a21CN1o0QmdLbGxPRENrVnVnQmxhQW9HUkUrQUErQVc0dXVwTUp2cDFNUkV5?=
 =?gb2312?B?aTdHaWN0bmFsN3Q3R1ZCa1lhVnNuczdBNzZ2Y0VNcng5Uy9oZGg2WHlsUUV6?=
 =?gb2312?B?WFdRcVd1SEcyUXdnbTlPNlZVaDRNN3BiNGprd04rTFh5cnh5TndUNDJqMEhR?=
 =?gb2312?B?QU1HRWZscU1pM0UvMlVsbnlSL2cyY010UWY4R1E3NWZmNVlNejRsQk5vZ21Q?=
 =?gb2312?B?dXg1a3lGMlhHdTEzZk5RS3l5ak4ySnR5dUxOR2dZekRzUjVjYXVOd3g3VHhn?=
 =?gb2312?B?Y0VZYnM3ZVBLdCs1RHhjNWxKQWdJR1A1UitoTEFWOGg0eGQvdzdKa1FZcHky?=
 =?gb2312?B?MzkyQVhPQTN4Umo3WXRiVzc1UDZxV3R0V0w1OEUvZ1hwS1ZGZXBReVFUK1oz?=
 =?gb2312?B?UURrS0RtYjhZVmVORTNuOU5qS1ZNcGdoejJKaEcreUhkUlhFMU5SaFlVNHdh?=
 =?gb2312?B?Wk9DaUFZcy9TUjloRmdDbVo4TVNoSy9uTmZLZ0xYZEVaVE1yM1RobEFROThE?=
 =?gb2312?B?UzMwTUZOcTVvbGZhamJEVWZZQk92aVpEU3dyRHZzL3NxOWVjM2hKSzFONGFl?=
 =?gb2312?B?c1hHd2dDYzc0RXpoS2MwSmRiSjJDUmE4K0dMcVlINXFLMFcwMTNyNm83VFQv?=
 =?gb2312?B?SFZjM05EWG9pNmtTaUIrUkxqZUpOQW9ROWM1VU0wMXdZb0JTL1pmRndRSXpi?=
 =?gb2312?B?T3BTM2FJc3ZJZFo5ak9MWnZYOVZ6bXBzQzRQeSswamxPUFB4Y2ZZUGs3Vyta?=
 =?gb2312?B?REVyS2diNXl6bVgvMmo4Z1dMbDUxNTYxV0N4UHY2c0R0WnBiQ0dneWxlQm9V?=
 =?gb2312?B?LzBvV1BmSWQ4b0FKYnNkMXNKNm53dlZ1MUNYcWtSVDhWeXRIb3dTekk2UEQ4?=
 =?gb2312?B?TjdVNkNpUG9CWUd2QnpHSzRLdkt2VE1zYWxaVWx0bHJZblkyR0dLd1U1Sjd6?=
 =?gb2312?B?YnJkZWJYc3lHb0lsbmNwazZCcG5FNG5ZQ0Zod3BpTi82aEVBNU0zMHUwRFlG?=
 =?gb2312?B?dlB6NTlrb1ZEbVYrZHUvdHVSWlczSmhVOUZMRU5BZVJNNzBLNFJ6dHBUOE1T?=
 =?gb2312?B?VXNqUFJGWENna2NFcGtRZXhQemNpMG1zSG82Mk5yckc2alc4V24rK3VTclNl?=
 =?gb2312?B?Vm5WUzBhK2JyYTRHRzhQZ0ovZ3o3cGFoR0hpSUk1N0hFMUVrUXpVNTlMQ1E4?=
 =?gb2312?B?dmZVay9ISEp1YTVwVmorWlR3Wnc2RXRCbWVPUkErclcyaHd3UFdRSkZTNU9H?=
 =?gb2312?B?UVpwcTlaY1RjSC84R1Z3TmNyN3pqMmdWZnNMMGNFMEs2UmxqbWRzVmNCZkZS?=
 =?gb2312?B?L240NFpnRTBScXN4WHMwUll6VlEyTGRyeWF2UWFOSU5XTVBjYzV1WUNpQkVq?=
 =?gb2312?B?WUk3MHRlS1Z3K0N5RzExcVA5a1NtOUE1Qk5uZjZMRnJBV1Z5bkM4NmxXTzcv?=
 =?gb2312?Q?x2PLboYosbQyymAjhI2Q3t0J4f5gl+yvUyo64f+?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b111c3-5092-4e5d-3e15-08d98faae6b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 07:10:42.6033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nv/Ej8fGwoLOmYg6qO65DXdKPkFLLCe7F2Gi5iJDtX92CyKqMbWPHrMgsuKDtt7w9eaJ7u8yGVMYRGHd4qwqsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3404
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4+IHNob3coKSBtdXN0IG5vdCB1c2Ugc25wcmludGYoKSB3aGVuIGZvcm1hdHRpbmcgdGhlIHZh
bHVlIHRvIGJlCj4+IHJldHVybmVkIHRvIHVzZXIgc3BhY2UuCj4KPkFnYWluLCB3aG8gaXMgbWFr
aW5nIHRoaXMgIm11c3QiIHJlcXVpcmVtZW50Pwo+Cj5JLCBhcyB0aGUgc3lzZnMgbWFpbnRhaW5l
ciwgYW0gbm90IHNheWluZyB0aGF0IGFsbCBleGlzdGluZyBzaG93Cj5mdW5jdGlvbnMgTVVTVCBi
ZSBjb252ZXJ0ZWQsIHNvIEkgZmluZCBpdCBoYXJkIHRvIGJlbGlldmUgdGhhdCBzb21lb25lCj5l
bHNlIGlzLi4uCj4KCkFjY29yZGluZyB0byBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3N5c2Zz
LnR4dDoKc2hvdygpIG1ldGhvZHMgb2YgZGV2aWNlIGF0dHJpYnV0ZXMgc2hvdWxkIHJldHVybiB0
aGUgbnVtYmVyCm9mIGJ5dGVzIHByaW50ZWQgaW50byB0aGUgYnVmZmVyLiBUaGlzIGlzIHRoZSBy
ZXR1cm4gdmFsdWUgb2YgCnNjbnByaW50ZigpLiBzbnByaW50ZigpIHJldHVybnMgdGhlIGxlbmd0
aCB0aGUgcmVzdWx0aW5nIHN0cmluZy4KClNvLCBzaG93KCkgbXVzdCBub3QgdXNlIHNucHJpbnRm
KCkgd2hlbiBmb3JtYXR0aW5nIAp0aGUgdmFsdWUgdG8gYmUgcmV0dXJuZWQgdG8gdXNlciBzcGFj
ZS4gCkFsc28sIHVzZSBzeXNmc19lbWl0IGRpcmVjdGx5IG1ha2VzIG1vcmUgc2Vuc2UuCgpUaGFu
a3MsCgpRaW5nCgo+Cj4+IAo+PiBGaXggdGhlIGZvbGxvd2luZyBjb2NjaWNoZWNrIHdhcm5pbmc6
Cj4+IGRyaXZlcnMvdHR5L3Z0L3Z0LmM6MzkwMjogV0FSTklORzogdXNlIHNjbnByaW50ZiBvciBz
cHJpbnRmLgo+PiBkcml2ZXJzL3R0eS92dC92dC5jOjM5MTA6IFdBUk5JTkc6IHVzZSBzY25wcmlu
dGYgb3Igc3ByaW50Zi4KPgo+U29tZW9uZSBuZWVkcyB0byBjaGFuZ2UgdGhpcyB3YXJuaW5nIHRv
IHNob3cgdGhlIGNvcnJlY3QgdGhpbmcgaGVyZS4KPgo+dGhhbmtzLAo+Cj5ncmVnIGstaA==
