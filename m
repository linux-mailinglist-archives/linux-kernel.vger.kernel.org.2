Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1543E0C8F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 04:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhHEC6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 22:58:40 -0400
Received: from mail-eopbgr1300072.outbound.protection.outlook.com ([40.107.130.72]:42152
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229609AbhHEC6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 22:58:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcXAh4R1J5FGLk/K2IQb0rpJKhPY3yp3mHwlLr/92/mvJfRWUClWn6/xcfJ2pTJCPFHbiRpIzPYdSoQQwFEXXxbmbASh3TEbC52NYL5LxKniXrIzMjJzXtdNZ3pLEZFNFUyRzD1TrQxPm0msxjtMY2uHwikncOYh0t0AAUH2GBAWcUESNHlH1WO6hKsMAKyDwly12N4lxn4n8WAFXuVp4TBkMQ0IRXGlf5AHsqbMoknbiE7/K1wp0aLeO/M1LLEzH0FqfHJM2bFu2CJAuNseKM2VLrWcORzaY9iFhw9WSDKny6pL+2ttFMEPq1Kfbkyux4X/BN7l6NDUl6v8FkWC1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BComOKua7zRWt6k0/JkThn4McI3EwhMMZk6ckDQ4hfQ=;
 b=A4NMwKoA0GVRfcMMT/r76qO/p8RXFq+ggWysh2fI/Oc/dnETnRBOwokNcbxa/dbL3kovNtgnMDkybttG5mgawz1/MJXCga6EzLRcymlksipCGjoYgT17mIttcIpJmcPzvYs8q6jbavHx/t6vnvaCvVf8NWnjPjWfMchUwAfHM4jbbz/M4ZR1viTJP02Y5s5zXhN5TdtwwWqTJr389BqAJWpyTiP4Wi3vb3VLETx0pD3a9eeFohtjyZSLOkaXNLIwHYqXJ4x9ga4XXIb+XNQUdSIlTYYpvwbhTdfI3xV66/UFbZTeYoomwmFNbL0/1H5tC55BRs86t3CH908MbKVDFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BComOKua7zRWt6k0/JkThn4McI3EwhMMZk6ckDQ4hfQ=;
 b=CV4GWOFgS0BlgNzc+LxoloX9IGkTLcramSr6q2rC/bYOq+MWoYwZqV5hgVsaPLTzwzokrnQyDiK3neXIl/urYsxyIRwOcife2XSBuoe64zXokovbQTfxXc1g8OdKEIHuIgxLUAiRFFbQ1nH9sMF9iGbnOLaYy6RZHbCNBDOzuas=
Received: from HKAPR02MB4356.apcprd02.prod.outlook.com (2603:1096:203:d6::16)
 by HK0PR02MB2785.apcprd02.prod.outlook.com (2603:1096:203:6e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Thu, 5 Aug
 2021 02:58:21 +0000
Received: from HKAPR02MB4356.apcprd02.prod.outlook.com
 ([fe80::d4ab:76fc:6326:a0eb]) by HKAPR02MB4356.apcprd02.prod.outlook.com
 ([fe80::d4ab:76fc:6326:a0eb%5]) with mapi id 15.20.4394.017; Thu, 5 Aug 2021
 02:58:21 +0000
From:   =?gb2312?B?1cW//ShLeWxlcik=?= <zhangkui@oppo.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/madvise: add MADV_WILLNEED to process_madvise()
Thread-Topic: [PATCH] mm/madvise: add MADV_WILLNEED to process_madvise()
Thread-Index: AQHXiQmYnOv2MsH7ykqpGVqJzSg8G6tkKWCAgAAQCwA=
Date:   Thu, 5 Aug 2021 02:58:21 +0000
Message-ID: <10168f82-6656-dbef-5a58-7b2aafb4ebee@oppo.com>
References: <20210804082010.12482-1-zhangkui@oppo.com>
 <20210804190055.b484ab15587cc891683eafea@linux-foundation.org>
In-Reply-To: <20210804190055.b484ab15587cc891683eafea@linux-foundation.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oppo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c3fcd98-b1e1-4d1f-7c16-08d957bce289
x-ms-traffictypediagnostic: HK0PR02MB2785:
x-microsoft-antispam-prvs: <HK0PR02MB2785F0AE98861F3AC9FA000AB8F29@HK0PR02MB2785.apcprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FnYI2BNyfxBDUJPEWEe3fmlx6JM4Q/8xSQMG+bQGxGq90zMTLhHJnoSvZ/xgljhBfY6y7Ttp3mhBgNurFsMVGmL52YOW8e0qfvgZYXY4Gwngi0md3fe9UkphB23z53w2AVvqvfyYdnAw0Nc7V0WGjlAnfGY+w9uPr7BD1u33ZThxG/BDw1xtqY2+nDWotPgGGFEWr2090tVDY6PRdxpwUruH478j+EKxaqcNaA1LsV6HmwA0HZY6qdo0ivAutKkqUmAYUTixmksuSEVbLz4QraZag1kVvtOtdG3n3cn+BYAyA7REPc+RVw9npHRbb+l8afHPv04ZXPCOv2Bhg0ku99SK7P4Xj+Or36JcuarNdGmm9iIfwfoIzbZedO1eawgfGpMTTEjYBSOYpg9UXtQ4Ay1zm4cSXyGh7XGLdkn0lusXE8nQhef0F6Lp1YRz88Q6JduAa5jb1aEm8l9Jt8ZeHQrjcGzilpgmehT1O1tzs53cc5HKYp5O6pZd1PN08hI7Lc0zJIlZJHYBhPrhsrOGrDfzrHtBr09pdUv8ULd7rfEvCUqwdjJYqeC9InUsMCcY1/w7muzO7niJrTJnRA5LTQkCk5fTBdMzGztZpdGrFjdfgSx+Tl7QFd/e1xxEnue3OoZkvhLZlRCtZSvASwvlI/vgH3+lbzGNXfWVSbXamjbnoDPdGOG+0V+XmqKY81abCl0hUwhMObG/2FTbcV/vL7lHjMSTxQGkVKEjJMXaoJVbI93nNIUb1WOcE5in1gNR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HKAPR02MB4356.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(86362001)(186003)(26005)(6506007)(6512007)(83380400001)(31696002)(6486002)(54906003)(85182001)(8936002)(6916009)(8676002)(122000001)(38100700002)(4326008)(38070700005)(2906002)(478600001)(2616005)(31686004)(66446008)(5660300002)(66556008)(71200400001)(66946007)(66476007)(64756008)(316002)(36756003)(76116006)(11606007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?N2FzenUzV1BteWFPcDJHUi9vQjEwazNoWm5xU1kwRlMxSjRtWU4wVWE3elJV?=
 =?gb2312?B?NERrVHJBekpZVlZvMHFxcCtJSzhTM1ZHRkxCc0JWN0s1WVF2blVNdWlsMm5Q?=
 =?gb2312?B?NjNGYmtkb3hwb3lDaExUN2R4VW1KdXlLU0ZLYmp6aCtiRzMzbUZwUXBjZllR?=
 =?gb2312?B?MkMzRlNhbS9qejN0d05UdCsxTVhlMm1iejUvVHYxYmRqVUZGZnFjcC9kZmt0?=
 =?gb2312?B?SW4rR0NhaFJPRCtzYS9EQVJJTGhhOElYZk43SUwxYllaSUhSUmFmNFluSHVx?=
 =?gb2312?B?RG9SaWJxT2YwMnBpMDludWthWUY1Y0RGclBLVXh2dlhMK2xLT2N6eEJhN016?=
 =?gb2312?B?YXoyYTlsL001bGFHZWNFa2h6YitINHIyQWZiZGYvWFpzelNrT3FxMXVWRXB3?=
 =?gb2312?B?dVQ3ZGpGbG95S001ZGkrdTl2ekxJbi9FN1hXeFFyN3pIeS9CSWdlTDc2MlBY?=
 =?gb2312?B?Y1B5N3d2MHh6d1haenRwRUI3VWVWclN2YXZYcGEycmlsZjl5cjd3d0QvNEFN?=
 =?gb2312?B?ck9ja2lVQ3Z0Rk5reTd5VWp5Y01GTU1yWVFQS3pxd204ajdBcm4xN29LZnhY?=
 =?gb2312?B?c0x1Y2ZBaEdHRTZnMlM1ZWd6WTBHdFRrSDdkaGswWU82UWFGWUQvUnhiS3B1?=
 =?gb2312?B?WHlrdS9adGRoSTEzcE5BZ0s2aFB6OS9ibXFtaEJzV01aQWgyRjVBK3pMNVJJ?=
 =?gb2312?B?eEN2WCt5bnByVmlOdUlBL0ZOMkJKVlhNSXgrSUVGUHE5ZitiRFQ2V2djdGdX?=
 =?gb2312?B?UzlPQWU0WWYvb3R5QkgvZFdWT3BXUEMxWmcvdjk1NnBnc2szNXA5T3IzL3or?=
 =?gb2312?B?RWJMb3dNbGFXNW5OeGFka21XWnh5Y3REMEd3aVBKMVd5Z25ObWR5cGRLdUJ5?=
 =?gb2312?B?RE0yb2pKK1cydGFna2VqN2RIN2hGRjAyMWVENjlqWktuSUl1MXJUYlY0MEpw?=
 =?gb2312?B?MVNCWEZnVWQwTXNIM2ZGN0dBbjA4RHhVUlNSR3hPWG5mMTNhdGgyTm40bTZF?=
 =?gb2312?B?WDAySVJVMEpyLzNtZXNNT3lZZmRiSFFHUWJ4alRiMUQrRWRaTnp4SXBJZHJz?=
 =?gb2312?B?RDZzUXZPazRNVWxjek8xTVlwc1Q4eHZ0dmtWcVB3Y01lakU2RUMvOUJhK01Z?=
 =?gb2312?B?aXFkMGdWWUlOaHNDV0ovS0VqcjUwV0hsOFRrckUvY0s5cXVWWG96andRbmNn?=
 =?gb2312?B?U2ZTMmE1RGVRUytLbk4xeUVsT2Z4MUs4TytkTFlBU1V3VTNQalVFVHA4N3hh?=
 =?gb2312?B?aVdZemtNTzFLWFdra3JFbVp2Ty82dnV5aTlHdXVVM1BHSnhCeU90MnNJN2lD?=
 =?gb2312?B?L0hFRTM1UWdxdXBTNVJXejVReEc3c2FMQ0E1Q3I1MU0wdzE5TjlaSENtb3pX?=
 =?gb2312?B?RFFpV1JlVG1IMFZkcTNaV2dqd3BpN2JPN2JCcjVnODJSTmUwam9LdDc3M3lV?=
 =?gb2312?B?UTJSL2FwR1R2Z2I0UER0VXhRb0E3WnlWOXZxK0dkU3BQSEVWV1craXcxb1h2?=
 =?gb2312?B?ZXI2M2QzUU55NkpXcDdNaFBRdk9XZHJia2wxald5ZTRpTHRIMDVvSS9MSHV1?=
 =?gb2312?B?OU1hQWhRZUZCSDhWWVhQWG9SbG9PRlVDclU5Vjk3bGpaaXE1dGlBVW1WMEpG?=
 =?gb2312?B?UGNmZXZiOUJiaW16c2EzSllCUGJ4bTRacHRGM0R1WXp5RVE0d2dza0dCUnJQ?=
 =?gb2312?B?SlprOEZnU1BLY1lpQ0xRbDJpQVNTZzBnZ1NINjhiTmp1OGdqK1l5RU15b3JU?=
 =?gb2312?Q?wYAWi2NSzNb54wgMCU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-ID: <FDF857AAA57F0642A9CD6E426FA8C7D5@apcprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HKAPR02MB4356.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3fcd98-b1e1-4d1f-7c16-08d957bce289
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2021 02:58:21.4171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sc81SMmxvnHkakTFEGDxnbu6poIRtGJz9tNhZv96Pb7BP68pXLO4/Gp+3FpfSuja3d3cxPHhPt8YVnOWAKsGsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR02MB2785
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1NogOC81LzIwMjEgMTA6MDAsIEFuZHJldyBNb3J0b24g0LS1wDoNCj4gT24gV2VkLCAgNCBBdWcg
MjAyMSAxNjoyMDoxMCArMDgwMCB6aGFuZ2t1aSA8emhhbmdrdWlAb3Bwby5jb20+IHdyb3RlOg0K
Pg0KPj4gVGhlcmUgaXMgYSB1c2VjYXNlIGluIEFuZHJvaWQgdGhhdCBhbiBhcHAgcHJvY2Vzcydz
IG1lbW9yeSBpcyBzd2FwcGVkIG91dA0KPj4gYnkgcHJvY2Vzc19tYWR2aXNlKCkgd2l0aCBNQURW
X1BBR0VPVVQsIHN1Y2ggYXMgdGhlIG1lbW9yeSBpcyBzd2FwcGVkIHRvDQo+PiB6cmFtIG9yIGEg
YmFja2luZyBkZXZpY2UuIFdoZW4gdGhlIHByb2Nlc3MgaXMgc2NoZWR1bGVkIHRvIHJ1bm5pbmcs
IGxpa2UNCj4+IHN3aXRjaCB0byBmb3JlZ3JvdW5kLCBtdWx0aXBsZSBwYWdlIGZhdWx0cyBtYXkg
Y2F1c2UgdGhlIGFwcCBkcm9wcGVkDQo+PiBmcmFtZXMuDQo+PiBUbyByZWR1Y2UgdGhlIHByb2Js
ZW0sIFNNUyBjYW4gcmVhZC1haGVhZCBtZW1vcnkgb2YgdGhlIHByb2Nlc3MgaW1tZWRpYXRlbHkN
Cj4+IHdoZW4gdGhlIGFwcCBzd2l0Y2hlcyB0byBmb3Jncm91bmQuDQo+PiBDYWxsaW5nIHByb2Nl
c3NfbWFkdmlzZSgpIHdpdGggTUFEVl9XSUxMTkVFRCBjYW4gbWVldCB0aGlzIG5lZWQuDQo+Pg0K
Pg0KPiBXaGF0IGlzIFNNUz8NCj4NClNNUyBpcyB0aGUgYWJicmV2aWF0aW9uIG9mIFN5c3RlbSBN
YW5hZ2VtZW50IFNvZnR3YXJlLg0KRm9yIG1vcmUgaW5mb3JtYXRpb24sIHBsZWFzZSByZWZlciB0
byB0aGUgY29tbWl0DQplY2I4YWM4YjFmMTQ2OTE1YWE2Yjk2NDQ5YjY2ZGQ0ODk4NGNhYWNjLg0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCk9QUE8NCg0Ksb6159fT08q8/rywxuS4
vbz+uqzT0E9QUE+5q8u+tcSxo8Pc0MXPoqOsvfbP3tPa08q8/ta4w/e1xMrVvP7Iy8q508OjqLD8
uqy49sjLvLDIutfpo6mho7371rnIzrrOyMvU2s60vq3K2siotcTH6b/2z8LS1MjOus7Qzsq9yrnT
w6GjyOe5+8T6tO3K1cHLsb7Tyrz+o6zH68GivLTS1LXn19PTyrz+zajWqreivP7Iy7Kiyb6z/bG+
08q8/rywxuS4vbz+oaMNCg0KVGhpcyBlLW1haWwgYW5kIGl0cyBhdHRhY2htZW50cyBjb250YWlu
IGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9tIE9QUE8sIHdoaWNoIGlzIGludGVuZGVkIG9u
bHkgZm9yIHRoZSBwZXJzb24gb3IgZW50aXR5IHdob3NlIGFkZHJlc3MgaXMgbGlzdGVkIGFib3Zl
LiBBbnkgdXNlIG9mIHRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaGVyZWluIGluIGFueSB3YXkg
KGluY2x1ZGluZywgYnV0IG5vdCBsaW1pdGVkIHRvLCB0b3RhbCBvciBwYXJ0aWFsIGRpc2Nsb3N1
cmUsIHJlcHJvZHVjdGlvbiwgb3IgZGlzc2VtaW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFu
IHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykgaXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmUg
dGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSBwaG9uZSBv
ciBlbWFpbCBpbW1lZGlhdGVseSBhbmQgZGVsZXRlIGl0IQ0K
