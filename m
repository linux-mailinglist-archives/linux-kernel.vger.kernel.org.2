Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAC331DC38
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbhBQPdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:33:54 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:17154 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbhBQP3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:29:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1613575781; x=1645111781;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cj7uMCOb+rvSrtBSQD/OLqQ9h597gQoYCSbzH6e1ID4=;
  b=DYkETINTcMjzpJpcCvp/QZ95vYGb0r9C9wiuOPy2IGTDKcn/H+9IOYg8
   f2wkzvegPp3BwP5Uc3lAr1IS2nn4USGj5WmVR/DtB9UikYw4gKDvxA9Kb
   fcVIWOxhTMsxNLCksPG/SQiZ9FhdhpyL2rnGXtjv7Gc4D6ot39mhWsjJT
   1TWOZKtLWGhWVbODAesWzEVvQqLP8rKfaUd117OoNZqn3NfKrJXxRdM4y
   ev7ilqb2mrUsv4kuPvkODiWyxT5FIcn5cRgShaN/vtPugzkKH90v549Da
   6O79hvvnWik2NZ7+44Uob/79XKxEv7bOwoyP/c+ppY3zqOQhDSlE9XQz7
   Q==;
IronPort-SDR: gmZ85s28ZVFhSPsD+nk9WJJTAi2eWCYuEl9LZj1Pnx7P4efQ+cbeSsnMBxTkv4A0VivAGsywWp
 u2quR5CIYlsdcX2BVQr//cC/dRnmpzpM9vuYf406Xy5jbPVVppU5fiJRoHLwDMkhkYDkvTN/VR
 G6NlyuQIwL1Hl7ONxsbcP5/EY4/Amds+ZwhnRLf00EAzmDDFyKYDKpy2lT1h+dc/4ZmdjQ9e3F
 y3PDUm3UOBxBkpLhLRbW3STNS2uvRcz+8smXpl7DDb7HMRcnIVou30Mu3fNNki9CBivL1fS8ok
 t+M=
X-IronPort-AV: E=Sophos;i="5.81,184,1610434800"; 
   d="scan'208";a="115476095"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2021 08:28:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Feb 2021 08:28:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 17 Feb 2021 08:28:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1gY5G4Z8Gabk/tpSrvjck3CCgM2o9nqQLXjPRg1qwv9cQp19ksico8xV7YWRfjiNhO6Y4zsr8nJ0thJzOP2/1bepVV/ZSTvJ/G3hT4Uv+jCm+2sZFqHLIQO+DUPcFV3Kqr4RaJ1HGNxR2nrPkYLYXnmW4ZwzjFzUKIEpPq7h5jxPg9SQuw3DLCKLITPvnZD+xFJ1W80yt2xS0iI8glgC0OPnDRAcs1U6v+a+7bZrNYKKPm+iG/h9FBVHV/hTIW17ig0dNFll92Zvwl8oddXTIfdWoJ3Vn0drVBx2soWp972FDkVGWmJDw0CASybi0AXW5R5p+U6dKrvxYFhhTuvvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cj7uMCOb+rvSrtBSQD/OLqQ9h597gQoYCSbzH6e1ID4=;
 b=WTZ1ZYZZtJCu5NJJ715FQ7hUMBjjVpRmAkGb00oVP5SNvzk49zy48VM5LegoZr3ivM1r0D/3S7R3vBtauqRUnk23VcP+bU0EBzksmlNJBxPS8Wj5gesLUpwmQDvaJTAvF1JIBIG4CsriNnQeMFUXfSRiiP64gmU1jT/52yXLF4k1xgfMt58bpRTck7iICUc/VsoA9pq1T7ZRmGu5sD2RqCbx1EtJ87CNd6Ljkl/DQta8MlzhR72H+SkypT2yUMujfPQBSkur9GiJbPzgGXQGnGCW3cmYLXaiFiMDoa4Pg5VvQAHnnujlL2Xyl6PYbFGdACXM/w65v2fpZQoL6rcaQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cj7uMCOb+rvSrtBSQD/OLqQ9h597gQoYCSbzH6e1ID4=;
 b=NXDrRbM+V4c/x6h+Y+QITr4mgcyFg17HWtXptaFkfFKxjagzg5sURgTXOLpwsAxLX4Erhapymujmt0WUlfRc2oNKnZpXW2p6KGIRdGE3dN1kFSlXa29FD0gqLyQrl42UoCH+P0T+8jPTDyuRPR+gpNXHNadnRgG3csCmWfL8Lwc=
Received: from MWHPR1101MB2288.namprd11.prod.outlook.com
 (2603:10b6:301:53::11) by CO1PR11MB5105.namprd11.prod.outlook.com
 (2603:10b6:303:9f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Wed, 17 Feb
 2021 15:28:18 +0000
Received: from MWHPR1101MB2288.namprd11.prod.outlook.com
 ([fe80::7894:25ca:9c09:23a9]) by MWHPR1101MB2288.namprd11.prod.outlook.com
 ([fe80::7894:25ca:9c09:23a9%6]) with mapi id 15.20.3846.041; Wed, 17 Feb 2021
 15:28:18 +0000
From:   <Cristian.Birsan@microchip.com>
To:     <heikki.krogerus@linux.intel.com>
CC:     <linux@roeck-us.net>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Using TCPM for ports without Power Delivery support
Thread-Topic: Using TCPM for ports without Power Delivery support
Thread-Index: AQHXA7+OKoygPd4GXEGTVNQ1L/OawKpagC+AgAH7WYA=
Date:   Wed, 17 Feb 2021 15:28:17 +0000
Message-ID: <5c2e12ff-5a48-1f2a-2f72-77d257f97c1b@microchip.com>
References: <6cf411e1-8234-d1ca-541d-067665620945@microchip.com>
 <YCuMeW6lbaSq8CIM@kuha.fi.intel.com>
In-Reply-To: <YCuMeW6lbaSq8CIM@kuha.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [2a02:2f01:5e02:3600::92e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e5e131c-0967-44cd-3e54-08d8d358a6c0
x-ms-traffictypediagnostic: CO1PR11MB5105:
x-microsoft-antispam-prvs: <CO1PR11MB510500CCD5A2D0A31F5056D5EF869@CO1PR11MB5105.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3NUPzHPlU4dUvJ3DGRXcvf9MEr+sr8QoFvafCdtpn1z+qYewHxrapBLLloglchYgwh8WUtHVrrC9xZZefGOvqCBEuN91RZai4ep9pp0z42b9q5lkq5NOGb8M+nn/V7VD2ZehkwzqADPJp5usG69D3hGZd4yqxXrqFbeDof6BOjB7xb2d4yembEiu8B05JQN5YmhxeGr4vD9uFNHhfb42chp0HklGPhcHEJEVrIaaOXzBlylbpbIQprrBYMgWSXVxtyGHqWTLWwv5hVYmnBuFMbg2NvV4SPrdyLf9Hd55F3wHrwplvuCB33rsSpmtXLsHg62bhxzXu8RUhGPW1yrmu3H9dNN3e4QdNFfddIB3oaOmXiPauNFgGJ6d/CCnlpEl1EjoS4hdcQfxJ+uDefP05qYhQ7J7Du6K0wP/HoEwouFcod0bAsNr0hxezvMhj0WikTxLjIEf2n7IY8iVApbST0XR2Ipq1+ywmiPJxuL5WV2uA0aEXniwlZg2PTiJTWbhyOZcX7WAbEXTndJ72JNpjvcdB/ebONTaxhxWsM1qV1bfSa1NYys0IQ2w8PG2BN9zdszb5leqBSGdz1NJfu86QwvyoItIS3f75CaVeQfa2sTHa6sXDwplqP5rzBG482Ng+VCwA8iphdX6gqgKGP46N8u9gi6+DC4UwPK+ruRF7pOq2azHp9v2UCYBNy/QqsHG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2288.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(136003)(366004)(376002)(8936002)(6512007)(478600001)(86362001)(83380400001)(5660300002)(71200400001)(6506007)(66446008)(66476007)(66556008)(64756008)(6486002)(2616005)(66946007)(4326008)(91956017)(36756003)(53546011)(76116006)(316002)(6916009)(31686004)(8676002)(31696002)(2906002)(966005)(186003)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MW53Y3d6aUoyYkd5Q1VYamhYZkxHcXBYd3FUbGlkWU9sa1B0VFVCTktvY3U3?=
 =?utf-8?B?dlFwajd0NTVmYjRHWnVib3JWV1M3RGZORXFEL3Z5K2hpN3NpVzJsR2oyVlB0?=
 =?utf-8?B?TExZZkkrOWpHTHFpam5UZTE0YXNacFVWNUpRZi9LcGRVTWZjYS9pTWNuVEtk?=
 =?utf-8?B?Skd1THkwMndROHN5SFdYWTh6Y1NhakRmWTNrSEVrd0FBM0pROHk2SlVZVlZT?=
 =?utf-8?B?Rm1qMnB4QjhXL1VOY1dBOXZ3bGhISmdTbEVwUHFXTHkvYTZxZldDRnJsSUZh?=
 =?utf-8?B?V2NHaytaNVd5WjRRQjFIR1IydFN0ZmVKOHlyUTI0MUJYRmF3M3pkL3JvQUJm?=
 =?utf-8?B?bkozaDlFQkNZbUpmK1JWSlkwVVBJb3Q2MS9NSjFFYTFvbE5ZZitPLzZGV2Zh?=
 =?utf-8?B?SlFGOVNYZ1ZxZnVUbllHVU5sMUtURmR1SnpxVU9VWDVFa1NPZTAwTWZUekto?=
 =?utf-8?B?T0ZoWGdiOG5yMzdINUpDc3ZFdUtVdTNCRWp1ZGY5bkFTbDdPWm9ESTk1VmNX?=
 =?utf-8?B?VXdHUE9XODYyWkNpMVJhNkdRRFpQbFVJcXpYcmRXL3kyeWNFeHBneXZZL2Ew?=
 =?utf-8?B?QnRoU0ttQWZHNmRhamVCcWNqUnF0YVpCMkhyVmFJVUxaZEIycjFMeWhkK1dt?=
 =?utf-8?B?bGd1TXlya0F2ZGFseHdnbFdWSjQ3cXRiTmFmVkpvcG8zdlpOZENGd0xwbEFu?=
 =?utf-8?B?bTg4SGd6M0lsQWJLdXlMUVNmTThMcFE1UW9SM1dMWHRYUEx5R3NLSEc1UTVm?=
 =?utf-8?B?WGlmTE4yN2NSSmRMUkYrQjJtSFZib295dGhNY1VNaTN4b08vYTJpOFZlOFBm?=
 =?utf-8?B?Wm9WOW1HNEY3V21aSjZFMlV2RnlXUzRqOVhiNGdHTjlSQVE4L0ZLWDVJcDNF?=
 =?utf-8?B?T0x6VHNhZW5jLzdGblB3NGlLM0NKQ3l2Q0pIQnJTS0NmOE52SU9sSTRXbUZM?=
 =?utf-8?B?emsvVUY0M1dORzZpT044WEp0c2NpY1kyaUxDbVVSNWZlY2VuMVBvZjBJOEJ1?=
 =?utf-8?B?clZmS3pRdENkcjFKdW8xcDhkRGhRWDZXMEVyMGFGa0dZaVcwaC9JeXhCWEY2?=
 =?utf-8?B?QXNTQ2paNThUL2pHN1lhbURiZTY2bzVmYmhaVmhxbDVORkNPR29OSm0ra0li?=
 =?utf-8?B?aDQzZzk1K0dqaXBocjY4MTJTL2syaGlwS2EzTUZJRXhnVHlkMnRxQW5Pd1BW?=
 =?utf-8?B?UDZldUxzaDNtNVRpdk9EckRTU0o0a1JQMUQrbDNOMVdYYWN2Q3dTaG5CY084?=
 =?utf-8?B?YWhaVjh4QmJ0MFI0L0dGMGw2cnVEWDBJMkRId0dXOWFmYnl2VVlQeDB4eUkw?=
 =?utf-8?B?YllzTVlwaGFHaXI3Yk5vcTBmU1Y3ZnB5Zi9LWmxwTHVzY3IyNWt4TEhGemF1?=
 =?utf-8?B?dGJXdmtVZ0k4VE1HMVZnRXAzR3hQVGl6a3FuS0o1anBFVmttekpQVkZWVXk3?=
 =?utf-8?B?b0lhdGpCYU1MZTM5NnpNQi80SnE4Ky9oMDF3cnFVTHFUTFFzZkN1NmgvbTli?=
 =?utf-8?B?VEtka0ZzK3JhbDg1ditudzRyRjdCRm92VGpiU0JGRlhMeDl2RlFadnErUldD?=
 =?utf-8?B?V29URXVMQXlxN2ZzWTlvVFFpUEtRR2h2UUN1VUU2dlhtMFUxbG1LcXVNWm01?=
 =?utf-8?B?SDdwR1BBT1hKRnZQYlQ5dnArZG1LTDBycmRUSnFaWTkxTFNkbWZXVVpzbDFP?=
 =?utf-8?B?VFFmekdHbU0yTUJtYXhIZlorNzN2Z2trOXoyQndNRWRPaFBBZk5TeG1Tb2xh?=
 =?utf-8?B?R2RWNURDRHJGZFR1U3lEZVk4aVNKSjlWandEeHlyeERudXloSjN0ZEZKOHJW?=
 =?utf-8?B?M3p2RU1UaW4xM053aWcrQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1310F973DA9EF940B2121583EA31B04F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2288.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5e131c-0967-44cd-3e54-08d8d358a6c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2021 15:28:18.0175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MEa9ddAQjYQFxPLNQcy4JrPP0MO/9TOb3aYIcy10MHg1xwcNXuKzlFOTpOyGxBcMzwZzeP0va0Ok6YETo8CFXSL48pzCFHlCjc+RNHMQsH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGVpa2tpLA0KDQpPbiAyLzE2LzIxIDExOjEyIEFNLCBIZWlra2kgS3JvZ2VydXMgd3JvdGU6
DQo+IA0KPiBIaSBDcmlzdGlhbiwNCj4gDQo+IE9uIE1vbiwgRmViIDE1LCAyMDIxIGF0IDA1OjI1
OjI5UE0gKzAwMDAsIENyaXN0aWFuLkJpcnNhbkBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gTXkg
bmFtZSBpcyBDcmlzdGlhbiBhbmQgSSdtIHdvcmtpbmcgb24gYnJpbmdpbmcgdXAgYSBVU0IgVHlw
ZS1DIFBvcnQgQ29udHJvbGxlcg0KPj4gKFRDUEMpIHdpdGhvdXQgUG93ZXIgRGVsaXZlcnkgc3Vw
cG9ydCB3aGljaCBpcyBpbnRlbmRlZCB0byB3b3JrIHdpdGggVVNCIDIuMA0KPj4gSG9zdC9EZXZp
Y2UuDQo+Pg0KPj4gVGhlIElQIGlzIGludGVncmF0ZWQgaW50byBvbmUgb2YgTWljcm9jaGlwJ3Mg
U29DcywgaXQgaXMgbWVtb3J5LW1hcHBlZCBhbmQgaXQNCj4+IHdhcyBkZXNpZ25lZCBiYXNlZCBv
biBVU0IgVHlwZS1DIENhYmxlIGFuZCBDb25uZWN0b3Igc3BlY2lmaWNhdGlvbiByZXZpc2lvbiAx
LjIuDQo+Pg0KPj4gSW4gYnJpZWYsIGl0IGhhcyBzdXBwb3J0IGZvciBkZXRlY3RpbmcgdGhlIHRo
cmVzaG9sZCB2b2x0YWdlcyBvbiBDQzEsIENDMiBsaW5lcywNCj4+IGNvbnRyb2wgb2YgdGhlIGN1
cnJlbnQgc291cmNlIChJcCksIGFuZCBwdWxsLWRvd24gcmVzaXN0b3JzIChSZCkuIFRoZSBtYW5h
Z2VtZW50DQo+PiBvZiB0aGUgY29udHJvbGxlciBpcyB0byBiZSBpbXBsZW1lbnRlZCBpbiBzb2Z0
d2FyZSAoaXQgaXMgbm90IGF1dG9ub21vdXMpLg0KPj4NCj4+IEhhdmluZyBpbiBtaW5kIHRoYXQg
dGhlIGNvbnRyb2xsZXIgdXNlcyBwcm9wcmlldGFyeSByZWdpc3RlcnMsIEkgY2hvc2UgdG8NCj4+
IGltcGxlbWVudCBpdCB1c2luZyBUQ1BNIGRpcmVjdGx5IGFuZCBza2lwIHRoZSBUQ1BDIEludGVy
ZmFjZS4NCj4+DQo+PiBGb3IgdGhlIGJlZ2lubmluZywgSSB3b3VsZCBsaWtlIHRvIGVuYWJsZSBz
aW1wbGUgdXNlIGNhc2VzIGxpa2UgdGhlIG9uZXMNCj4+IGRlc2NyaWJlZCBpbiBDb25uZWN0aW9u
IFN0YXRlIERpYWdyYW06IFNvdXJjZSBhbmQgQ29ubmVjdGlvbiBTdGF0ZSBEaWFncmFtOiBTaW5r
DQo+PiBmcm9tIFVTQiBUeXBlLUMgQ2FibGUgYW5kIENvbm5lY3RvciBTcGVjaWZpY2F0aW9uLg0K
Pj4NCj4+IFNvbWUgb2YgdGhlIHByb2JsZW1zIHRoYXQgSSBlbmNvdW50ZXJlZCB1bnRpbCBub3cg
YXJlOg0KPj4NCj4+IDEuIHRjcG1fcmVnaXN0ZXJfcG9ydCgpIGZhaWxzIGlmIHNldF9wZF9yeCgp
LCBwZF90cmFuc21pdCgpIG9yIHNldF92Y29ubigpDQo+PiBmdW5jdGlvbnMgYXJlIG1pc3Npbmcu
DQo+Pg0KPj4gMi4gdGhlIHBvcnQgY2FwYWJpbGl0aWVzIGFyZSBzcGVjaWZpZWQgaW4gdGhlIGNv
bm5lY3RvciBEVCBiaW5kaW5ncyBvbmx5IHRocm91Z2gNCj4+IFBET3MsIGV2ZW4gdGhvdWdoIFBE
T3MgYXJlIHNwZWNpZmljIHRvIFBEIG1vZGUuDQo+Pg0KPj4gMy4gb25jZSBJIHdhcyBhYmxlIHRv
IHN0YXJ0IHRoZSBUQ1BNIHN0YXRlIG1hY2hpbmUsIGl0IGNhbGxlZCBwZF90cmFuc21pdCgpIGlu
DQo+PiB0aGUgcHJvY2VzcyB0byBuZWdvdGlhdGUgdGhlIGNhcGFiaWxpdGllcy4gRm9yIG15IGNh
c2UgSSB1c2VkIGEgZHVtbXkgZnVuY3Rpb24NCj4+IGp1c3QgdG8gYmUgYWJsZSB0byByZWdpc3Rl
ciB0aGUgcG9ydC4NCj4+DQo+PiBQbGVhc2UgbGV0IG1lIGtub3cgd2hhdCB5b3UgdGhpbmsgYW5k
IGlmIHlvdSBoYXZlIGFueSBhZHZpY2UuIEFtIEkgZ29pbmcgaW4gdGhlDQo+PiByaWdodCBkaXJl
Y3Rpb24gb3IgaXMgdGhlcmUgYSBiZXR0ZXIgd2F5IHRvIGltcGxlbWVudCB0aGlzPw0KPiANCj4g
RG9uJ3QgYm90aGVyIHdpdGggdGNwbSBpZiB5b3UgZG9uJ3QgaGF2ZSBQRCBzdXBwb3J0LiBKdXN0
IHJlZ2lzdGVyDQo+IHlvdXIgcG9ydChzKSBhbmQgdGhlIHBhcnRuZXJzIGRpcmVjdGx5IHdpdGgg
dGhlIGNvbm5lY3RvciBjbGFzczoNCj4gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9s
YXRlc3QvZHJpdmVyLWFwaS91c2IvdHlwZWMuaHRtbA0KPiANCj4gWW91IGNhbiB1c2UgdGhlIGRy
aXZlciBmb3IgdGhlIFRJIEhEM1NTMzIyMCBjb250cm9sbGVyIGFzIGFuIGV4YW1wbGUNCj4gaG93
IHRvIGRvIHRoYXQgKGRyaXZlcnMvdXNiL3R5cGVjL2hkM3NzMzIyMC5jKS4gVGhhdCB0aGluZyBp
cyBhbHNvDQo+IGp1c3QgVVNCIFR5cGUtQyBQSFkgd2l0aG91dCBQRCBzdXBwb3J0IGp1c3QgbGlr
ZSB5b3VyIHBvcnQgY29udHJvbGxlci4NCj4gDQoNClRoYW5rIHlvdSBmb3IgdGhlIHN1Z2dlc3Rp
b24uIEkgaGFkIGEgbG9vayBhdCB0aGUgZHJpdmVyIHlvdSBtZW50aW9uZWQgYW5kIGFsc28NCm90
aGVyIGRyaXZlcnMgZnJvbSB0aGUgc2FtZSBmb2xkZXIuIFRoZSBjaGlwcyBoYXZlIGxvZ2ljIGVt
YmVkZGVkIGludG8NCnRoZW0gdG8gaGFuZGxlIENDIGxpbmVzIGFuZCBWQlVTIHdoaWxlIHRoZSBj
b250cm9sbGVyIG9uIHdoaWNoIEknbSB3b3JraW5nDQpwcm92aWRlcyBiYXNpYyBhY2Nlc3MgdG8g
Q0MgbGluZXMgYW5kIGl0IGlzIHVwIHRvIHRoZSBzb2Z0d2FyZSB0byBkcml2ZSBpdC4NClZCVVMg
aXMgdG8gYmUgZGV0ZWN0ZWQvZW5hYmxlZCB0aHJvdWdoIGEgc3RhbmRhcmQgR1BJTy4NCg0KVGhl
IHJlYXNvbiBmb3Igd2hpY2ggSSB0cmllZCB0byB1c2UgVENQTSBpcyB0aGF0IEkgbmVlZCB0byBp
bXBsZW1lbnQgaW4gc29mdHdhcmUNCnRoZSBTaW5rL1NvdXJjZSBDb25uZWN0aW9uIFN0YXRlIERp
YWdyYW1zLCBDQyBkZWJvdW5jZSwgYW5kIFZCVVMgbWFuYWdlbWVudC4NCkkgdHJpZWQgdG8gYXZv
aWQgY29kZSBkdXBsaWNhdGlvbiBidXQgb24gdGhlIG90aGVyIGhhbmQsIG15IHVzZSBjYXNlIGRv
ZXMgbm90DQppbnZvbHZlIFBELg0KDQpJZiB0aGVyZSBhcmUgYmV0dGVyIGNoYW5jZXMgdG8gdXBz
dHJlYW0gdGhlIGRyaXZlciB1c2luZyBqdXN0IHRoZSBjb25uZWN0b3INCmNsYXNzLCBJJ2xsIG1v
dmUgZm9yd2FyZCB3aXRoIHRoaXMgZGlyZWN0aW9uLiBJIGp1c3Qgd2FudGVkIHRvIG1ha2Ugc3Vy
ZSBJDQpleHBsYWluZWQgY29ycmVjdGx5IG1heSB1c2UgY2FzZSBiZWZvcmUgaW1wbGVtZW50aW5n
IGl0Lg0KDQpDcmlzdGlhbg0KDQo+IA0KPiBCciwNCj4gDQo+IC0tDQo+IGhlaWtraQ0KPiANCg==
