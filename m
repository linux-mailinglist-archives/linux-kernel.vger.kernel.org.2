Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D17439A91
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 17:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbhJYPe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 11:34:27 -0400
Received: from mail-eopbgr1410132.outbound.protection.outlook.com ([40.107.141.132]:6160
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230348AbhJYPeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:34:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9aUFbGkdhTvkmDbobhqyNsq+3SFrnG56RzviES9JlhnNlELhJQUURRsaAovaA3r2+uvigxKgxGjY1Gz0VlZG27qW6u/NFr8pVNZ7jcvmRZE/23Dea/K7N1E0HpO4SiV1kZWYXHA2cptCB8Lx+58ebQwgwKdEXcQQ7aBgfj0mpmpMSNix9fPElKkY+ypl5gACeKOSlrAoEH8ahUI2PMfltynfrRz6arqYTOgO4bnWvhwCvnpt6MO9Eu+0DG6K0tysMnxo31RQs8K07n+fk9QNwd0aEH1sS9tb3X3/vOkHdLtN3ynqshFqb0lQoBpGCgwpgGcDAabSDaY93gBoSYAEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlpmznFBq4KXSdLnJN8p+GCz9vGjXOVJskyOQBhoHV8=;
 b=jkJok7ZUtniLLQIH2B7lHdv18DqN+DE6Cv+PjB6+x4eq/tVposI+k8Cd3k8tPHzrBeNlXUbwY5FS8lWHdL1x89AMaVH4Ne6diTVwK7daNcRaNorT+Z8xCho6i6LLB1CszydhDKKsnfN7iurZFnstBe4O14NQ9fv5uapZEQiZxXC0u5nMTg4cSEhmkiIUO/gOgMzbmzeTyTTolcCogRUNZI+yv11/5nPJyQpIhVij4ukfxDpCilXXmo8YcLmcltwHVlkMh1C87m5lXIRwmD8gNJF5yxvVrjY+dUz3tmY1wR5mxlGl4KcHrGXnC4BpafbYdwFtf+trNUXxsy7UcIhnLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlpmznFBq4KXSdLnJN8p+GCz9vGjXOVJskyOQBhoHV8=;
 b=k44xQ8Ub8pD1lBTKlzMM+pAGjepAjQNp6kbf+3KE+/qeZ6SQfcNPzNmA8JgCpM55n+nOw8HRVGxmyQ+bBaZKi4t+M3au8hDbit+ryQHwmJ9XpjnsS+7HQTOTHxYRLvyBOS//kWBVTf1nRZd53sJU31jlNrhpYSuzJ447ZFP6Sxw=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYCP286MB0750.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:7d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.15; Mon, 25 Oct 2021 15:31:56 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%7]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 15:31:56 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "john.garry@huawei.com" <john.garry@huawei.com>
Subject: =?gb2312?B?u9i4tDogZHJpdmVyL2J1Zzogc3VzcGVjdGVkIG1pc3NpbmcgbnVsbCBjaGVj?=
 =?gb2312?Q?k_in_hisi=5Flpc.c?=
Thread-Topic: driver/bug: suspected missing null check in hisi_lpc.c
Thread-Index: AdfJtAX2fMFFx03OTqmNb23By5R1KQAAUCzA
Date:   Mon, 25 Oct 2021 15:31:56 +0000
Message-ID: <TYCP286MB1188596CE44B1236D4EDD4B88A839@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB118803910D5797B4B1B1938D8A839@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYCP286MB118803910D5797B4B1B1938D8A839@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba506451-3c96-425b-eeee-08d997cc9438
x-ms-traffictypediagnostic: TYCP286MB0750:
x-microsoft-antispam-prvs: <TYCP286MB07502D6FCC2964948FAB41878A839@TYCP286MB0750.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8/+Yg7FPbkluGv4FeW8fRH2Uk+YITH3GP40j4qtEORrIiyPsRc2dBGJuJNxiLf3VZMZwqLHGiuXuN9K/cmErzUjF0YuXq5gsv9xHUATd30HrSqQoANSPSHIBDM/K2AAfUqsaer1U7gNsgwOp/n2XbkFuJ/jFLqslwTFusoCdpxvz4PO3yPb/P+T6Jrt5BY/TTTsRkEXzrk0hun/fUFjEp8x6TJqJ3HsM7ZhnZBHQurw9mz6dkisRNIlzW7m3AyrMo5auZBbbjZmdCtyiOXpd3vXMN/L4M0T1HOe8XLZ+eAzRItdHrqVjzWvLc0lo0hUpiuKABGPk2HaL/fUYdTmdgutl+PRorodWfX/lGbhc4jqupYxsErhlhdnmLIuU7BBCfQmueztkVn2IJBNkOJ/RZrXdG9er+8D/CHYFrFB9q0rdJX594TwTbtXPhypYhqhWs9JgoA2ZLIix93uzFsojYxD/gckLC++HvHVEiJn1AIzC1iXqzNk0flvHjKcgC+CV9+2zNVuz/UrJDHo1DP7QbhRs2vp6ovi9dEWaRkptumJnBhjrJEQxV4Lzx/JnZvC9+aJHjDiEEIAVZWQ9JBiUP/IgYKKSyse9NL49XkibTW35wDo04EsemCMlxjDTg/VEtqIV+TdTKpZxFdv9Tgp1JXVO5kXqU2AVMBhgzp5yxwigS57lvOoy+gKhxVcyggGkLIPUYyslWw3TOiYvtqHhBcYQPxKJuKQpXZXXMCYgz+ee8V+PyuVGjKtbd7XIyiH40cQQrL74t8x0R+iN3vgU06DGQylV/U7UDIYXSZ3W+vg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(508600001)(8936002)(26005)(224303003)(66476007)(66446008)(64756008)(966005)(33656002)(122000001)(4744005)(66946007)(186003)(71200400001)(66556008)(86362001)(9686003)(52536014)(7696005)(83380400001)(55016002)(5660300002)(786003)(2940100002)(110136005)(76116006)(6506007)(316002)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ajJTQnQ1eVZQMFdVcDdOT2t4aG93RTVlNEVnRlJ6cHVtUjl0MmxFRmFHWGU2?=
 =?gb2312?B?eTFGckI3YktHN29wTjFrSGVMQzlJSFZ4QVRMQ0wwWnhHMXh5ZURLUnVJbUEy?=
 =?gb2312?B?eTRkQ1lDRW52Yy9qMnpoYlIyTkFHaFN2N0FxV2o5TlNpeU9IUW54bk9rbG43?=
 =?gb2312?B?TEtRNFVlU3Nib2pKanh3K3dKb1pFaS9OV1lQcDFtS2ZvL0kyZG1CMVltNkFh?=
 =?gb2312?B?WXJidEpheGxTc3RFZ1FPYTRiNXVucUdiYnd6TWRuZnZhdDZ0QmlTUmc5dTB2?=
 =?gb2312?B?bkRKakdhSTBBQmJlM0pVN3lJWStPSys3eEpvL0RUdVAvejdrU1hEM0pjVG1j?=
 =?gb2312?B?eWhkZFdQSDA1QTVXdzB1bk96b3RSd29QSmdxbGQrcGdXZTZRTGtiZXBQamIz?=
 =?gb2312?B?UDVxOFVObkdrR0djODg0YnovRnpySmlsUWIyVUQ5S3Z1bk54Mk1waWtmOFQw?=
 =?gb2312?B?UitXc1RGSHAvaVJTSUNBWEFXUkkySlJ4MWJHODY0RjZSSUNtOHc4ZUtaMWR0?=
 =?gb2312?B?MEJKb3g4Z2ZFcnJSMjVWVGFCR25jNHM0djBJTW1sbEtNcWxHeE5qbkwzTStx?=
 =?gb2312?B?VEs5K2IxaitEQUc5US9MV29CQTNGMGFrK0M4UWNDQU5CLzhFTWRXRHJZRHZL?=
 =?gb2312?B?cDZrVzdOYW9nMzg1NUVMOXhFTzJXS3QzSWRrVk9mb0crbWRKb0FhNEtrcUNp?=
 =?gb2312?B?aFFkM0pYaHFTOFhsVFFBREkzMjdKM0REczc4S1lSRHVTVllvZ3ovRFFycG5v?=
 =?gb2312?B?TTYrczJpTHQ3VG1PMVlvemx1QzI3alB3bzgreXY5U2E1QkYwUiszdXBsZ3M1?=
 =?gb2312?B?eTRzTG5LaW5hNjhmV2pmSFdTQWdpeFhZaGJaN3JTcm44WjhTZmlReWFzZkF3?=
 =?gb2312?B?S3ZnYjRyLzVoa3BmRVU3NnEvcnpZZDVuajNSTnRocWwwa1ppa1pKaVR5aWZp?=
 =?gb2312?B?TGVjTnpINUF2Z3FJek51TERBbXpCa3U0L1cvd1RIeWUzTVc1MUgxcUZsUlFw?=
 =?gb2312?B?WVJRdGU2YThmaFZENEFoaWZBOGM5eUhXODM2aUtxblp5akZ1elJXYjBSSWZX?=
 =?gb2312?B?aVFvQ1lJa3RueHZ4YVpQdThPaEtoWXBuK2R3bHY2UnZzM2RVUVhlWXByUTRw?=
 =?gb2312?B?SndaU0toRlhKWGxFTUpaTWxGNW1mVEV6eHdrV0IxbGc0aFlDRkNtbzhPNTFm?=
 =?gb2312?B?R0xuR095SjV4cTdrZVJNTnMrNVArVjBaVmVvd2tkN3J3eFZ1bCsxcTk2ZkZr?=
 =?gb2312?B?NXFyaStSNUpHcXVhUldKenRNY0ZaVGQ1SSs5cGhidmJZU1ZXRlRnejJ6QXZj?=
 =?gb2312?B?L3EvYVBCL2V6WFlndXZXYzR5ZUpiOGYwNTdlSkV3Y1d0SVVBUTc0NjFYVnM0?=
 =?gb2312?B?eUVsei8rbTJZMFRBRDZpM3NDZmpLSmFNSkJiNjBYVmEyakVJK00vbkF2elBY?=
 =?gb2312?B?QXFHemJ4djhublFrOElESXA4S2ZMZmtyanhRZ01DK1VuYjBBWFZTRy9qc2o5?=
 =?gb2312?B?UUJlVi8yUFhLa0h6SW9xbXdDTG93TkdMM2tGeHBZQUl2TDVieEpNaTByMDAx?=
 =?gb2312?B?eXdmeERuRkZ6ajhMK0RjK2NUbjM2dzN0MFc3ZGVnNjQvNTBkTFlFWHZKaVBl?=
 =?gb2312?B?cmhVcUtuSTBIM2g4V0haeTJLRm5QVlk2bm9zUjRVbURJU2NpaTJuNnp0dlZs?=
 =?gb2312?B?MkFLUFZycmd6aWJyRlBTYjRnd2xHbksxRExvMUl4RFpONklOK013bVVmUm9V?=
 =?gb2312?B?Mks1NW5FQlJyZGNSeWJvNWZDRGdETDZUaU5uNVk4QVhXYnJac3pNQTIrcUN4?=
 =?gb2312?B?WFF4WmtIeDZmNkw0Mjg1Sys1NFcrOEFEeTVkbHQwbnpXai9temdCMWNrekxk?=
 =?gb2312?B?V3h5Sms2eWtZTmNwNUluakhPTytJUlJxaHI3djRGeXh0Sm1QQjBpcXpvbVAx?=
 =?gb2312?B?azAybjRWeTUyTlRCdzNBWnBLcGxZbUxYdklOdm5heFFBSk5JQ2ljNk1Sbjcw?=
 =?gb2312?B?R2xlUFQrQXkzUUNFOUxDd3hiUFdaRlhtKytnVlZHSmJ6azd4RzhCMHZtU3Fw?=
 =?gb2312?B?QW9QQ21iMVdvcFY1cldudlI4alAwTWo3RXFVbTRUM3FQL2tDSXVTV01ValV0?=
 =?gb2312?B?SjJ6ckduNXVrbWtRTmtGb3JOWS85b0Z1WTYyZXJINXpkV2h6bEcwV0QrczVt?=
 =?gb2312?Q?pvvWbTFIYZ5Da1u4XItGt5Q=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ba506451-3c96-425b-eeee-08d997cc9438
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 15:31:56.2799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: djyIFGYkG3lHTeVP3XurZ6HY32ptGwue6rHtoCNSN3Gx7M4NKaRoEgWVyZTj+H1qETYMtrelatNjG0W96pBRog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB0750
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SXQgaXMgZHJpdmVyL2J1cywgc29ycnkgZm9yIHRoZSB0eXBvLg0KDQotLS0tLdPKvP7Urbz+LS0t
LS0NCreivP7IyzogWUUgQ2hlbmdmZW5nIA0Kt6LLzcqxvOQ6IDIwMjHE6jEw1MIyNcjVIDIzOjIy
DQrK1bz+yMs6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGpvaG4uZ2FycnlAaHVhd2Vp
LmNvbQ0K1vfM4jogZHJpdmVyL2J1Zzogc3VzcGVjdGVkIG1pc3NpbmcgbnVsbCBjaGVjayBpbiBo
aXNpX2xwYy5jDQoNCkhpLA0KDQpodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxv
Yi9tYXN0ZXIvZHJpdmVycy9idXMvaGlzaV9scGMuYyNMNDgzDQoNCk91ciBleHBlcmltZW50YWwg
c3RhdGljIGFuYWx5c2lzIHRvb2wgZGV0ZWN0cyBhIG51bGwtcHRyLXJlZmVyZW5jZSBwcm9ibGVt
LiBJdCBjb3VsZCBiZSBmYWxzZSBwb3NpdGl2ZSwgd2UgcmVwb3J0IHRoaXMgdG8geW91IGp1c3Qg
aW4gY2FzZS4NCg0KTnVsbCBjaGVjayBpcyBtaXNzaW5nIGZvciB0aGUgcmV0dXJuIHBvaW50ZXIg
b2YgQUNQSV9DT01QQU5JT04gYXQgbGluZSA0ODMgYW5kIGxpbmUgNTA0LiBJdCBzZWVtcyB0aGF0
IHRoZXJlIGNvdWxkIGJlIHBvdGVudGlhbCBudWxsLXB0ci1kZXJlZmVyZW5jZSBwcm9ibGVtIGF0
IGxpbmUgNDg4IGFuZCBsaW5lIDUwOS4gQ291bGQgeW91IHNwYXJlIHNvbWUgdGltZSB0byBoYXZl
IGEgbG9vayBhdCBpdD8NCg0KVGhhbmtzIHNvIG11Y2gsDQpDaGVuZ2ZlbmcNCg==
