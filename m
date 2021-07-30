Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFB23DB4FE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 10:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbhG3IWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 04:22:34 -0400
Received: from mail-eopbgr1300134.outbound.protection.outlook.com ([40.107.130.134]:52144
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231411AbhG3IWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:22:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNIppjk5x25jgNbh/9W+X5BG+ddFXwPQPWC5tB2SAiPtX2nIQxmKvyfQ2JEjDgd5qZZbDsCTiWqolqGqXP66TC31FAcT0TbpQ/t7uJziBmg4LG1fQamGx+wPE7Gi0NeKnME2EidtRgi4+fXpg25V9xvtDGRPs3raoqpKIFLBty5jUEagWQ/Aeor1ZcjTpkLeJfKA3ceTGujKOxA/FcNSZP06cDDb/C4iaf+zWxVUF2zxBfFab/PKkJ91FFHkILdh3bBU70uxzf+A5huSCq3Te53WGhW1QgfP2Y6AGLaMD6bHL3DT18x5lxcZFPPggjkXutyf0ii0d8LWWEzE+ARA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04YqgEtWZRwQLrViTAodA5HiS6OmGuftkntuVy63+lQ=;
 b=OD8YdrptQwEcZInIDUEPzypwcRDUCTLkU31YO9DJCuPfjFwIurWGvOow9OIEftOnueq7V6wX5c3vUOQCZoE6LSGD/3Kf39a4RzgqCjp4WfdLBsy3k92hQMMV7ifzgMej0cmwoNRVXN1C9waaBCk6xXRWUnzFogqv7gFbdi3x4+31GfMNznVHM/IgjiIbkGYFqBC01tTKiAfDKOLOLEledfMHj3jX77kbXlS3AlEUourlejOB1qXSlKo+QDYOoRXN4SEKBNN+Gq9jMUGR1KGF2qM6T6w3JKjqsW6oocv9ucq6+tb0Upg6+6AsmIgsiI0Im+650IRi7raSyQQYc8U3Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zeku.com; dmarc=pass action=none header.from=zeku.com;
 dkim=pass header.d=zeku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04YqgEtWZRwQLrViTAodA5HiS6OmGuftkntuVy63+lQ=;
 b=KGIOIYtr3Xvz3Un7q/wok/6x1w653Rrkl0TCvuttqld+2R8AtghXp5USB8lqYwBur2NEhChGrftRzkoP4v3ZxIaWXeqlV45p5LYGXNYeFJex2TydSNYPm4oy3rJXBUdsqq+8NJUDiaGLk1Fw/SAHT4IEYm/sRxmDcTxMbR1SXfhMk/jWqt+5CPN+FAJKeXMSaoNqdDiksJWoOYvdD4ylAjt3AOm7ObZLKITdaSOdL74up3XgXk8jNm3hASQYVEBs2WzxtBc8nAzeZJVf0eiBuuuwi9kbYHxkudkN41QWeteJMtSMRZnLTODLTDioY3MBpXhmMgXIaQpoJ06tFtG/AQ==
Received: from KL1PR02MB4788.apcprd02.prod.outlook.com (2603:1096:820:5a::11)
 by KL1PR02MB4708.apcprd02.prod.outlook.com (2603:1096:820:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Fri, 30 Jul
 2021 08:22:23 +0000
Received: from KL1PR02MB4788.apcprd02.prod.outlook.com
 ([fe80::883f:a6d7:92f5:c16b]) by KL1PR02MB4788.apcprd02.prod.outlook.com
 ([fe80::883f:a6d7:92f5:c16b%4]) with mapi id 15.20.4373.024; Fri, 30 Jul 2021
 08:22:23 +0000
From:   =?gb2312?B?y9W71ChSb2JlcnQgU3Up?= <suhui@zeku.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSB4ODYvaW50ZWxfcmR0OiB1c2UgX190aGlzX2NwdV9y?=
 =?gb2312?B?ZWFkIGluIHBzZXVkb19sb2NrX2ZuKCk=?=
Thread-Topic: [PATCH] x86/intel_rdt: use __this_cpu_read in pseudo_lock_fn()
Thread-Index: AQHXf2suyi3EY8LDe0SFCiNWW3SJ36tXM0IAgAQEhyY=
Date:   Fri, 30 Jul 2021 08:22:23 +0000
Message-ID: <KL1PR02MB47882A3A37249394CB6B5D84C6EC9@KL1PR02MB4788.apcprd02.prod.outlook.com>
References: <20210723023342.3015-1-suhui@zeku.com>,<ddb942f0-4c34-4e10-7d46-526d411f5ebd@intel.com>
In-Reply-To: <ddb942f0-4c34-4e10-7d46-526d411f5ebd@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=zeku.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dac36eed-795d-4c50-8c1c-08d953332847
x-ms-traffictypediagnostic: KL1PR02MB4708:
x-microsoft-antispam-prvs: <KL1PR02MB4708ED706F46F77CEE5274E4C6EC9@KL1PR02MB4708.apcprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cf9HfMpuRe/lLqNGjdNAVZO3pautvA9AQo74gmbLuwMEWuGEtTwrd+g2MF+qrgUrZI6FaInzVkEG9kTSWILx5ogs4agyQw3BvAq+XeKb/SmRCCzagDAmG/zBFmhEIEIAgS19sKT0F5TpJqs67uTpNx+VKqsz7f0GdHZIiqi2mP10Bl/DsmGvwHkHD1CENAYFyDiaGtyaL2U6QbcUyJyab4+sSaxOIclOLkbwKCSsqvSBVtcPbGSODLST07ps+6LCtbeDr4ut93N3qPmfVQ4SxHvg6waLcumUOMx9f5CmnAffiXVSgLMERqxjugFVPsTr6mX3wvbd+5mtWQ0aP8qjHx7jdMJ5ij8SrOX+4buoEf/68M3S/ICPHGNi24N4B8POF0t3Hf1A7BgfyZpq5ZMwPqbWmo6qfX3O/cKcin7CmhEcWGFvJhgwScHC+foAQM8lkhwaioQXtAkXAkt1oJesMwTbi/oXBF2eKsbQ/o60VlsK+Zk7SXt35ECbeWuUVNdHdTzcuoxMhmrP28VpM0MMOlSp5xU+rOGfDHgl4XhcO0VF2PPt356q4GE18zFDyKxHV643FqQQF08QWXaw9gztpuX20CqqJ0ILO1LlBwWQ51uo/Ao05Ltgblgbx0/kz7NDipb13Ym5cXe40k+QawtKv3MuqYalCtfyovGuQ7B6B3ChrsT0Qg+eP5HzxxAynRJj5XZUKIXIDWb5bpWKpPU7AnpUXJT8qxSSogzTRRNnAQs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR02MB4788.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39850400004)(136003)(376002)(366004)(86362001)(33656002)(2906002)(85182001)(122000001)(6506007)(110136005)(38070700005)(5660300002)(53546011)(9686003)(186003)(83380400001)(26005)(8936002)(7696005)(224303003)(66476007)(478600001)(316002)(71200400001)(66946007)(38100700002)(52536014)(76116006)(66446008)(64756008)(66556008)(55016002)(11606007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SnFBeVh2M3piNGNJVi9hS2xNT3ZFbVh4aG5BMXF3VU5aSU90NEFQL2RmRU9y?=
 =?gb2312?B?VEpWSmZ5Q2J1RTFoM2xMaUdJa2JTMk5EcUJMTzdWNXErNTJwdjVrRzNibEE0?=
 =?gb2312?B?YlFyeWxtaTh2UG5haHNRMUNXdXd5TGx0bkpPWTVab1RmUEZISEdFZXUvOUpI?=
 =?gb2312?B?a0tlcTVQNGJDQ2dFTjVGYkhaSUVTeWt1K203TTY4aFhZUmZQLzliR2RKWUJu?=
 =?gb2312?B?Rm9IT05adlBrSWJGVmtpbWt6eFZ0czZHU1k5S252Wm1LNHZhMlpMdEcxUlJW?=
 =?gb2312?B?WWpSRFJuSEllS1pndVBKL1VMM0w3Y2t2VFJpbWFlZE1xQVMrWC9WQkgweDRq?=
 =?gb2312?B?bngwY3ZvdzZkdTU5bS9zTzZ0Z0pjek1PN3pKZHpSb3BWU2ZlSzZqbWtIdnpQ?=
 =?gb2312?B?NUx3ZDZVYUp6eEJFemRqYzUwUThvOHA4d1pjRTRGOVpmWkx5Y3Z5QWtxbFVy?=
 =?gb2312?B?RlRvL0tVSG1rbXF1TUR0dStOTkJiTDR1V0o5c3grNVcrejdWMlVhbW9pejdF?=
 =?gb2312?B?bnh0Vyt2ZStkOENwM2g4UEMvRGRZcEd3SDIrWW9RN29HZXpzeTRQMHRLTjB4?=
 =?gb2312?B?WU5mK3llSEQxTlB2dXVyM3hDSUVxVHhzeVM1blFlWnBOei9kdjJMZjBhb1hj?=
 =?gb2312?B?WUY0ZjVvbDhJaVd3RzNMc3JTNWxnNCt4NDNBWmFQOVJxQlRwU1FpNVY2aEVp?=
 =?gb2312?B?eVQzb0FrQm85b0V0NWZRMllXK0NvT1JWYTZSamkzeUdBWlpaREUvbzRUUDI0?=
 =?gb2312?B?RmtlQ0E0WWRWV0VDdHhyQWVGbHpBcFhhZ2tPWmk1dHNIcnRFd29ScDkzVGxI?=
 =?gb2312?B?b1NDTzQrRkJRS1RRNWUzeWN4QjFoVlpIZTRMRE1YWURtRnFVc20wRjBEcitF?=
 =?gb2312?B?NWxCeEJMNEpTd0NGUTdVSm1EQVpVemlwZFZXSlB5NzZlQ0lENU52WlI2d2lP?=
 =?gb2312?B?M2ZUbXJ5U1ptMGxtMWhLNDEydDZ2SXB0NEkzRjB6WTREREpqQWtpV0xrOXhn?=
 =?gb2312?B?NEdyeTBYbjBCcHNDKytnaU9nV1o4d1hHWlhnekF6NUp3VHN2ZjJBMUtWS2o2?=
 =?gb2312?B?NkdvRzJZNCsrOHVIYjIrU1RienMzaHMvUjdoL2dlRDN4MWhzR0ZvS05MTE1p?=
 =?gb2312?B?NlM4RVZHdllOUjZwUDk5TXBzdG1vVGhNMWhkdXpvNG1hMjRTQmM2bmg4QUsw?=
 =?gb2312?B?WXpPM0lTb2I4eDNJSjgyRC9QRkNyaC9rcmdQMi93dUdNb3ZwR1ROcmpLM1JF?=
 =?gb2312?B?VEdpeFp2aTNzazdob0liSW00dlN5TXpQbkMrVzFGUFo5TEw3UXJwNnlZVjUr?=
 =?gb2312?B?MjI1VWRkZFZiOEtLRWZvN1JuMW9EVE95Q1NoNUtBQlFMTTBmWVZCa2duZER3?=
 =?gb2312?B?WFJoZW9BQVgxZG5NSnVoclRMdlh1KzhZalZJUDdmbWhvZG9DbEN3UU1ocXFG?=
 =?gb2312?B?N2o2M0s0M3RTTlYvWjdrRUNxN0NzUmk5M3dWK3g2bTVhL2JQampIMHN4ODd1?=
 =?gb2312?B?WUtvMGZBZk8zVUtqT1AveU00eE5NWmdQUmpoL2kyMGc2aVpMbUhiR3JnV2w4?=
 =?gb2312?B?YzFDajBVZnV1THU1Smc3QWR2UUs5ZE5FR0RHNWJlRWx6emJ5cmdhd0xaZUxm?=
 =?gb2312?B?ZjJkc09oVE1iNmV3eUhxRGMzUmVnb0NVc0JVWlF1SnJLaEFRaUdhNHZMNFBt?=
 =?gb2312?B?aFJmVk5ZUzQrampSR2pNanJ5MFM4blJHYnI0V3B3YUhiN3dDRGFOSUJxUG84?=
 =?gb2312?Q?2SwAL2x4IFo3uDHX6o=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: zeku.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4788.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac36eed-795d-4c50-8c1c-08d953332847
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2021 08:22:23.2327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 171aedba-f024-43df-bc82-290d40e185ac
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qy+gPekizlv7ei/IhwfM7IVzb3rS9sfLhNbVHg/xABevIFLorv7OOfEOd5aUc0pV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB4708
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJlaW5ldHRlOgoKICAgIFRoZXJlIGlzIG5vIGlzc3VlIGhlcmUsIGkganVzdCB0aGluayBp
dCdzIGJldHRlciB0byB1c2UgX190aGlzX2NwdV9yZWFkIHdoZW4KaW50ZXJydXB0IGRpc2FibGVk
LgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwq3orz+yMs6IFJlaW5l
dHRlIENoYXRyZSA8cmVpbmV0dGUuY2hhdHJlQGludGVsLmNvbT4Kt6LLzcqxvOQ6IDIwMjHE6jfU
wjI4yNUgMjo1NgrK1bz+yMs6IMvVu9QoUm9iZXJ0IFN1KTsgZmVuZ2h1YS55dUBpbnRlbC5jb207
IHRnbHhAbGludXRyb25peC5kZTsgbWluZ29AcmVkaGF0LmNvbTsgYnBAYWxpZW44LmRlOyB4ODZA
a2VybmVsLm9yZzsgaHBhQHp5dG9yLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwrW
98ziOiBSZTogW1BBVENIXSB4ODYvaW50ZWxfcmR0OiB1c2UgX190aGlzX2NwdV9yZWFkIGluIHBz
ZXVkb19sb2NrX2ZuKCkKCkhpLAoKT24gNy8yMi8yMDIxIDc6MzMgUE0sIEh1aSBTdSB3cm90ZToK
PiBUaGUgY29kZSBpcyBleGVjdXRlZCB3aXRoIGludGVycnVwdHMgZGlzYWJsZWQsCj4gc28gaXQn
cyBzYWZlIHRvIHVzZSBfX3RoaXNfY3B1X3JlYWQoKS4KClRydWUgLi4uIGJ1dCBjb3VsZCB5b3Ug
cGxlYXNlIGVsYWJvcmF0ZSB3aGF0IHRoZSBpc3N1ZSBpcyB3aXRoIHVzaW5nCnRoaXNfY3B1X3Jl
YWQoKT8gSXQgdG9vIGlzIHNhZmUgdG8gdXNlIHdoZW4gaW50ZXJydXB0cyBhcmUgZGlzYWJsZWQu
Cgo+Cj4gU2lnbmVkLW9mZi1ieTogSHVpIFN1IDxzdWh1aUB6ZWt1LmNvbT4KPiAtLS0KPiAgIGFy
Y2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9wc2V1ZG9fbG9jay5jIHwgNCArKy0tCj4gICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9wc2V1ZG9fbG9jay5jIGIvYXJjaC94ODYv
a2VybmVsL2NwdS9yZXNjdHJsL3BzZXVkb19sb2NrLmMKPiBpbmRleCAyMjA3OTE2Y2FlNjUuLmYw
Y2MwYTg5MzMzYiAxMDA2NDQKPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvcHNl
dWRvX2xvY2suYwo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9wc2V1ZG9fbG9j
ay5jCj4gQEAgLTQ2NCw4ICs0NjQsOCBAQCBzdGF0aWMgaW50IHBzZXVkb19sb2NrX2ZuKHZvaWQg
Kl9yZHRncnApCj4gICAgICAgICogY2FjaGUuCj4gICAgICAgICovCj4gICAgICAgX193cm1zcihN
U1JfTUlTQ19GRUFUVVJFX0NPTlRST0wsIHByZWZldGNoX2Rpc2FibGVfYml0cywgMHgwKTsKPiAt
ICAgICBjbG9zaWRfcCA9IHRoaXNfY3B1X3JlYWQocHFyX3N0YXRlLmN1cl9jbG9zaWQpOwo+IC0g
ICAgIHJtaWRfcCA9IHRoaXNfY3B1X3JlYWQocHFyX3N0YXRlLmN1cl9ybWlkKTsKPiArICAgICBj
bG9zaWRfcCA9IF9fdGhpc19jcHVfcmVhZChwcXJfc3RhdGUuY3VyX2Nsb3NpZCk7Cj4gKyAgICAg
cm1pZF9wID0gX190aGlzX2NwdV9yZWFkKHBxcl9zdGF0ZS5jdXJfcm1pZCk7Cj4gICAgICAgbWVt
X3IgPSBwbHItPmttZW07Cj4gICAgICAgc2l6ZSA9IHBsci0+c2l6ZTsKPiAgICAgICBsaW5lX3Np
emUgPSBwbHItPmxpbmVfc2l6ZTsKPgoKUmVpbmV0dGUK
