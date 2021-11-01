Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC655441B5E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 13:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbhKAMzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 08:55:35 -0400
Received: from mail-bo1ind01olkn0182.outbound.protection.outlook.com ([104.47.101.182]:43542
        "EHLO IND01-BO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231892AbhKAMzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 08:55:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qn9TP/tgg8NZq0Oc38amhk4v7Byb30a9bVb72/mFRJ5VZgUCCqFaLTPB+iKdXVvHJyT2dxHzFFPl78I9RFgqjWK9MQpUjlBZdZ9qO7QrUcke2Pwl8BklRPP2xuKRayg4y9mGexJYEpiSH+76LwbS0sX0hwLS6fZhEZGTBuuugZb9A22pNN9YbnI5MrZaqoifreRgeBmJbR2yJ93aQ0OL/oi0XM4u6mDTE0uAB4stpUnC1so0igKMYXN/XI/MUaNjcx2y/+gsyCmguZho2zgx2EWFSemOSk4KZE+3aiTl7QKeTE1HzUUvkIXcJmmtSMWcDSZog7UKXxrqgYEc6OIjJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGW/sHw0kSGjA/DGql+Vl8q/APgC2eLnFxdG1yQH4Ew=;
 b=c1LJW/KV+t/fCrgREz70+wexN8EVrM2nUTh7PRIiW6GhaE17EM0pfphGL3ooRNJnzIbXIEyQgPELPxGdeabFT9qZ7p91bqP/pyO9BwBMPyHk06IiGChU2X/jFiLEyiGSQvxEQv7qp2i8L0Lt05LKOVVZgVpTyLtjDsznStpNGtF9RIP/fiUz2ImTab53YQxhD6EWIICjwSpitJMqynf3AgK44B4WHu+4q0wc5NvPrXANiJtbhczfZJ1M8h3l2ngYbD0hYYlcScPRRnUTSia+XUiIM6w2eJmNAJtxqV7iWNtqNTbRnMsccilC7cwae1KfTaHa+buc7gYWpJ6y/Fv3hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGW/sHw0kSGjA/DGql+Vl8q/APgC2eLnFxdG1yQH4Ew=;
 b=XNAWVoMNHnt606abzWM5N/BIE7UXyqe3GbD4vLjIfrX+G2AnsmMNWv9mn9eDvV+aJiWejvcyLZKzqRpiVFP9KPzy5aJPi0qjC43IMZywz8DYtBo6SbbHLaJVEZnk5SwX5qRaff7fLKGFj2TcUPbpyyYti4GNwInrf7Yh6SR/t9YFZ8WakA1YjsKtPt8oRuGLpWwH5+XF21JbhjyQnhj8ClcMcmEqLSnux0gU/4OUYhjjUU+I4icCeXzzvZyfVHdwjHnQpTt+H29Rwv63uTLD2ZFcSPt2p/Bb5TdqyOH7q/0NeuYQaqvIcq4oEHmtb1OG3giM0yF1Mk/bu/enagCvWQ==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PN3PR01MB5965.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:7d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 12:52:56 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7%6]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 12:52:56 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     Orlando Chamberlain <redecorating@protonmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] Kernel 5.15 fails to boot on Apple Macs with T2
 chip.
Thread-Topic: [REGRESSION] Kernel 5.15 fails to boot on Apple Macs with T2
 chip.
Thread-Index: AQHXzx4xdN6jyZo2R0iZHJfrQ78gcKvuoIkA
Date:   Mon, 1 Nov 2021 12:52:56 +0000
Message-ID: <7A40981F-AA9A-462E-81D2-CE1FFA5174CA@live.com>
References: <F94B8FCA-E736-4E87-BFAC-D668A481B5C4@live.com>
In-Reply-To: <F94B8FCA-E736-4E87-BFAC-D668A481B5C4@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [jl9xOAbexM5yLgnASgxfITr51PFcmhCdpDCgx/hXedumKJsIoBeAjfXZGDzF69l0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66bbc168-ab7a-4b93-470b-08d99d3686d3
x-ms-traffictypediagnostic: PN3PR01MB5965:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hA1UtJuU6q7Lzzd2YG9DrWRTv2IsuTpcKZk/yrjc9U5akKWS/yqE7SPAMXM3y7mGCO2dTB8HuY0irE1uzJ3VimGPlFG6YZiqfW+fhtHrA2rrKoek9Sxo5iPIKnrpKdiB3f2aBNnO/Al5my0cKd3Hf4wB6KZxXY2kNcYLSO4L/5FKswCB1qAExNldisQrrGfQBwZctkzH97U99fxtBYYlgnN5EcssGw0tGnmBp2oQ5AroA9iyLApnbyBDuaI94nZ37813Xq6Of9PvbuP5OFU+S+hh+zGZBb35wpCaUwdsaDn+yJBRG7VBi2+th7DkDRc4Fjy6dzEoOch31bcdWEqxGUnWLBwQcZWPR6T5MO7AOi0LyQlYqLrMPbYvNpdOUGVGwhdv8TOF572KVeXkM59q5AN5pbASNYjV2r8XMx+C9Rn1wyLNaVZw5Sy/wFuJr0+nUuvXsjhHi7WeUJTM5KU73O2PPvZmjsgSKnYhvMVo4zmXdIx3vxhu8mYoXXZZxDWYYXDQG6tuAFfKeZMNcqYI8HEyAVd4rNNhtWaId7GW9Ps=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 8JewvF/GmyTSrPSPRzJTiqh5QyLieAG9tzBUWkV5hwT4u36IYf+1jDlzyaCcVmfLJm5+eaYlXQjdEGSyU7aaq3jfmyw2IVFPWVIKJuwmcAY4oJ52LcIJDbhBEt2eX6duIo88Ia7PQ3/R6RspMTmAI0sOHv4rhazjyI/ARL/HNRSOvmQq23vneVPOlSYmupA9iK+wLUxuh0E0TE5aSGSHbm/FiY98/kQQeYbDg4kB3vmHPJNOs8D/+qOhwzJEebard5oo/nLk4toXNUyK1BaeTzq5J81N0dq+ySmoYAeIKJ6+wEdm6uj+Ew/ptBtP52emz5bENvZtX5aUqmkGvekEsIdv3WN7pWud3bh/HGismR8u2lNoKOOcqeh59UnCpPuhGDrlr/ibRrCJlJNxl3F/zPJtUlVjL4gN7JZwr66bNWD7+vgu0fC2dl4meCMrkR5ojDco1Df9/xNltJ2p0kLhn4/df+/nRu5y9+NXYC7WTy0WSK2uxpL9GvZ8iAfHvqxcGNis3AHuPNkLwt81IYMVlzWOAPoBszLd4Bo59R3yBkdt5/z0E/ps/ZLXXQJ+Z4NnvDdrtndIwke/HkwCphjR2238rOKSUciaSMXXW73HekUCEM6CC/+AwIO75qk2wQuEk9S9YYud9DpbqODyw4VEr3pjcRrCGXk3giRunWOlvEFrCtM8hEck6wEfMejZDqsJE+2j/rYU0vsX1p9VhJYY345srLVLcGIYfHH2wGRQX8q2xRbK64GJXRc1gUFf6PUaxkL6AELubwTHW0WuoaaLVQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <911325C4AA980B41A6EC11FD5800FAD6@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-a1a1a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bbc168-ab7a-4b93-470b-08d99d3686d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2021 12:52:56.4736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB5965
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSByZW1lbWJlciBmYWNpbmcgdGhpcyBpc3N1ZSBvbiA1LjE1LXJjMyBhbHNvLiBUaG91Z2ggSSBh
bSBub3Qgc3VyZSBhYm91dCByYzIgYW5kIHJjMS4NCg0KPiBPbiAwMS1Ob3YtMjAyMSwgYXQgNjox
NCBQTSwgQWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBsaXZlLmNvbT4gd3JvdGU6DQo+IA0KPiBE
dWUgdG8gc29tZSBpc3N1ZSBpbiBpbnRlbC1scHNzLWFjcGksIGtlcm5lbCA1LjE1IGZhaWxzIHRv
IGJvb3Qgb24gQXBwbGUgTWFjcyB3aXRoIFQyIGNoaXAgaW4gNS4xNS4gQXMgYSB0ZW1wb3Jhcnkg
d29ya2Fyb3VuZCwgIiMgQ09ORklHX01GRF9JTlRFTF9MUFNTX0FDUEkgaXMgbm90IHNldOKAnSBo
YXMgYmVlbiBzZXQgaW4gdGhlIGtlcm5lbCBjb25maWd1cmF0aW9uIHNvIHRoYXQgaXQgZG9lcyBu
b3QgaW50ZXJmZXJlLiBZb3UgYXJlIHJlcXVlc3RlZCB0byBmaXggdGhpcyBpc3N1ZS4NCg0K
