Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8584497EE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 16:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238927AbhKHPQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 10:16:07 -0500
Received: from mail-dm6nam08on2062.outbound.protection.outlook.com ([40.107.102.62]:52260
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241099AbhKHPOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 10:14:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0E8JkEoBrvbTUAQglCbK/y8O/Hg+sSyNfjYjuBPMMEhwxHoEKYNlMuWtDDoevnaZ/3BGTZLsmsezV6LzfRmwX645+z3Fuxyk+xXx6GejfBF7YQBexL4uHy5osT7XhKjuuPwM0OSw9f7R5NCvlseJQMWSoT5dFhuiSbh1V0mADsdodXyxJWxxiSpJw8k6xTb/U/K0tXP62deh8FeXszQ4R3nQlNRrEyTJZSCTYgQSkHMptnPHcvH+Tw/zKpTrWGj/oV1oPqTuZvgQ81fQpXVmktnaOze41cTDtxtOrEeRu2M5HM1PXUM1N+WDsJV1DCKScXhU2jCuwzlXSL9nLXZPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sc0+/LjgG2JwPGmsYPIVVbeEzoXX7iU+vueHVg21Dr4=;
 b=kQk27axxEBtTpPzLHvZD1zYsjt8tidDaczNj7IwWh7FVn7NmmClIpGP5vk+G3KjgCdU2LQr5E7tXRmldXxvx2VWu2nsRKOc+XT/8K9nqMIkGFCAFI4nfRUrz2kAO9B63QHwpz5ZLDOcHnvcV1X1AATPo2U5ZTeDoBaUgRPeorxFAFp1tU1BBqwBcfkV635PGnWMQrarJMka9CYFaR52ieDR3eS02U2rDLGlU6M/E0sD2TcLOwP2laMbmsDuPpq0IOWZ7yRYRCVpnmGKeuyZb4LGkhAZ4paMlB/R6R8JYh8rhN32sL1yMm0jYLyiT6j/SRk5xOdHfCshkTgY/SMVQHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sc0+/LjgG2JwPGmsYPIVVbeEzoXX7iU+vueHVg21Dr4=;
 b=wrVqkin1wk+hFKBs8E8K4l7lHUFkPEwl1OtEkZVde4vWo+9wc8p3hmR4/aJpLc3H/vi6POWoUpL9EeeLZK1YLsaH8erccBZOzpN+Y3p2w4vKm72RxGadZgaCJsWueQ37l4C6cJD6rzoeGUUNG8BmJIkcDd+d4LcssNpyMueZ+DI=
Received: from BLAPR08MB6900.namprd08.prod.outlook.com (2603:10b6:208:325::21)
 by BL0PR08MB5330.namprd08.prod.outlook.com (2603:10b6:208:59::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Mon, 8 Nov
 2021 15:06:10 +0000
Received: from BLAPR08MB6900.namprd08.prod.outlook.com
 ([fe80::bccd:76be:d2ee:be06]) by BLAPR08MB6900.namprd08.prod.outlook.com
 ([fe80::bccd:76be:d2ee:be06%8]) with mapi id 15.20.4669.010; Mon, 8 Nov 2021
 15:06:10 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Richard Weinberger <richard@nod.at>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        shiva linuxworks <shiva.linuxworks@gmail.com>
Subject: RE: [EXT] Re: [PATCH 0/4] enabling Advanced protection and security
 features
Thread-Topic: [EXT] Re: [PATCH 0/4] enabling Advanced protection and security
 features
Thread-Index: AQHXyyD9tLQ6pEH31UG4THX5Vs/e26v5zW9g
Date:   Mon, 8 Nov 2021 15:06:09 +0000
Message-ID: <BLAPR08MB6900B02028177141C1FA4820B8919@BLAPR08MB6900.namprd08.prod.outlook.com>
References: <20211027103352.8879-1-sshivamurthy@micron.com>
 <771780049.41543.1635332049033.JavaMail.zimbra@nod.at>
In-Reply-To: <771780049.41543.1635332049033.JavaMail.zimbra@nod.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=true;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2021-11-08T15:06:07Z;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Standard;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Name=Confidential;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ActionId=7f7e6b80-408a-4b26-b937-397c975bbe04;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=3
authentication-results: nod.at; dkim=none (message not signed)
 header.d=none;nod.at; dmarc=none action=none header.from=micron.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b94e6cb2-209d-4ca3-5f90-08d9a2c94c37
x-ms-traffictypediagnostic: BL0PR08MB5330:
x-microsoft-antispam-prvs: <BL0PR08MB5330E50ABC26F1FB0D66F23BB8919@BL0PR08MB5330.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LQnAHkr4h7z9yfXrptQyWUdd/esEQ+qs/K44ubp2n/VW004EIWbvXyS7PtzsonAnLc7Q0WcX6TGiK4rcBa+DrDwdY3IDKZ6ocxTHK8QQLFbFoMAkMHH1YmRfNYSxusrcEWvq6CYnX2IL+ms7BF9lmaUwAmxkro0X/LQ5E/cy8DKBF3XVTzwhuiREhqHRac9Qf71yR7lEaOqHgSAt1WCM61vzn0BfYNUNQcD9eNI4V0BfcM43NAbTBDEJGvc8MLs7b9CZW4RpbCFIkR0vHlMuYQDKC1aoHU/5b9nT353JW4l+Gqju/PkAeSR9ohVDUNTPaP8Ape1YOD0qljIkufKTuExSxKDQmh0+awCaL4RA6V6+ca7MoXf3l+bwmRRUQoLhMM4GZGKGwSH1Yd1QZcWyfE/WhZQbI4/x3xS80GO7VZbMRIo3myPKl7bYRuPZUJRfcxYCeH+bba4fJfhl9mfDPCeQmlCdqQF5FbfhX1MDFniLlEQipKTWVrxNWl/G9Vs75SD8mBO3LFsmqKCBsZJotrlfpgkFSsw+OwIbA7ASR6rxMDphNnDbYZX3RDqzVKoTbeGMTMjMRlusR+1cerZlebLq0ADL2hia/TARgkGfR2MEHeJ6LGIrm1snXZBOoQgVsOgJGquGxyP1Ut93tGOK1j/ErlRs3PrQewuMieYsRY+a1Inc+HqaDFNTGvLVZlYmQwFhbNHYUaktlWLp9iONEZrWVTPrhj3pPyIn2hW2YQuAijYapy91FYNiWTIDWLzXJKt0p5UJEdo3jo82Id2AXlDt42q5v2xiLrJG6+Bkhh8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR08MB6900.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(33656002)(6506007)(54906003)(76116006)(2906002)(71200400001)(64756008)(66446008)(66946007)(66556008)(66476007)(508600001)(6916009)(966005)(8676002)(7696005)(55016002)(9686003)(86362001)(5660300002)(38100700002)(122000001)(186003)(4326008)(26005)(52536014)(38070700005)(8936002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXdWNXN1WVpINXZRUzJJbWNLMjYvdXA0bjNiWWZLSjV0djYveUFnVkkveFh3?=
 =?utf-8?B?RS95MGJ6RVFJVS9mOTFLU21yYWxsc0d3MTcvMUdRVERudDdMeFliWEF6QThW?=
 =?utf-8?B?dmVUaUV5WnhzSXdoeUtwQ2NyZnRsOWhEdkVHcU40K1gzZ081blpVd1RlUVRM?=
 =?utf-8?B?ZEsrTUc5ZjBTQUNJS1BTYlhPUUJoOXVuNTcyZDJmRGhRQjJNQzRzdU5yVUhK?=
 =?utf-8?B?anFZN1lmdkZZdDZML2RUTFk2T3VTcWxQQk5QbVpsRkxVTUF0dVB6eUFEUnhv?=
 =?utf-8?B?Ni9Vd3FRc1R0anM0WDE5TC9MQjRMYkEwTXBibm1sc1JmeDlMZi85cFI0ZVhG?=
 =?utf-8?B?SmdQbCs1MUpSajFDRThiMS8rWHZKaHE4MlZWMW5NTEZpcWRBT2dDclpzM0sv?=
 =?utf-8?B?Vy8vcUJJNVhFTGNCZHZjUHlSN1NoNjZpajVxZk9QaTczMldTRHF2UnFRQ0pz?=
 =?utf-8?B?aWZQMGRGVDAwOFVvVjBRTmJ5dk9SZXZkb3FnLzVPd0RsQ0I5czR2OXFLQ0Ft?=
 =?utf-8?B?QzJKMkZCMTd6T3BrYnJqRjZFL05zbVNrNXlQZzg4K1lNMEhiVGV3NEh4bzRh?=
 =?utf-8?B?SnVKL3BJM2xGYkFjLzRIQjh6eFJ3a1NVb3BYSS9rM1pINThTSVd0cEFza1cy?=
 =?utf-8?B?VFRoZ2NLeGVLWUcyUEEyckdQVzJJM2hMS2QrS2VQZ0VuS3UvdnluV29zUDRI?=
 =?utf-8?B?NVkyM2p0Mk9BWWs1U08rVjl3RmpaRzRSYW1jZnVjRUhCS1B1ZEpKYkxFQWlZ?=
 =?utf-8?B?blhpdVUzamZnZmVIR3FZaFFocjk3Z1k3VWtGOHRPZS9rL3pZSjF5azBRRm1q?=
 =?utf-8?B?a1EwQi9HL1lSSDhjQ0JhUW5tOHFIMUM1aDR6OTFtWllpYjJ3cGV3S3hXQU9Z?=
 =?utf-8?B?VFN6cDdzWEVmOEJLbTRldUFScytZU2k4N3VZTUpyTkFaWjJyeEpBQ2ZWSGg3?=
 =?utf-8?B?ZkFLODFTYkJwUUh5Rnh3Vmx6b0ZGSDVDMzR1bWJPRVpLamR0eXN4QmtMbXBF?=
 =?utf-8?B?WWJmTDFycjdSZjg3K3JnQ1d0QnNGckR0OXo2ZlNJbG8vbjdsSTJGbTJqTWgr?=
 =?utf-8?B?Sk9oY3ZjdkhkTG5TN09WNlFJcFNQWG45NUZKTHllRUF6d3hJNVJZTFFOR1c5?=
 =?utf-8?B?WElMTTdGMjMrZldoaW91cExhdW1HTW5RQzlGc2lQd3VXNXpuM1hkNDhqVzVo?=
 =?utf-8?B?Njd1ZVREUDBlNGMxUFc2b21XTVB5bEhvME1aNkhybW1OL1RWRXUxODZZeEcx?=
 =?utf-8?B?N2ZvR21SRHpvNGZLS0JuK3NHbGtWVklCQnFhMFlaUFpPNXBxQkQrTmhQZG80?=
 =?utf-8?B?QkJkaS91YTBOdVBHUHlGVnNxbUljSURTRDcxOHNQREJJaGpob1VWMmgwb3dD?=
 =?utf-8?B?R1JoeWE5eFIyVkRsRTJZM3BtTk1mNnVhYllhRE5EcEFnWXFZeGd0UEI3THBZ?=
 =?utf-8?B?MGZSYUxpZjc5cFU1MXgyVzhwd29wRHY2RVAzV3ZZZHpISysyS0ZTTG1tdXN6?=
 =?utf-8?B?MDk5OTdrSTRZV2p2SktWRnF1VjQyWDVqV0QxNXZ2L05JRVhpcVNRcFVIVzE1?=
 =?utf-8?B?MmREbERYcjdnZXJyKzVyUUhKL2kvN1B0NUY2Y0xReklxVXhzQSsybnJkajZh?=
 =?utf-8?B?NGZUbDhTYitvTWNTdUxiYXQ4ckJBVFJiOG1LaWduQ2xwaE1QSFlBZWRUSm1B?=
 =?utf-8?B?TEdXbVNkeFltOW4xakxCdEs0WFFTQ0llWTRheTl6Y0RGaGhjdE1lM0h0MkdJ?=
 =?utf-8?B?anl1OFI4c0w1cjVpZkczdUxSZzF0OVNUaDRRQjA1ckxiS05LNFVRbTUxV0Y4?=
 =?utf-8?B?TUNNbFBSVlU0Wk5zLzVGVlBCY1pKQXJ1TXlabEhpOWo0VCtZVXAzU1hFcHZm?=
 =?utf-8?B?Q3dTS25BWGFQa2tXb2E3elQ1VVJxd0JSd2NGMkZUZUc2S2M2K1MzMm1wNU5K?=
 =?utf-8?B?WmFIbWpvMUxNdzl4KzhKU2tETVdtQ091VFR1QUVySTJ4dm8zb3FNL2NXRGNj?=
 =?utf-8?B?YkhTRnd2RFZsMTBGbmdmekVnMU9nREhhWlJwQitLckJuQTlEcEhDRi95Nytk?=
 =?utf-8?B?Nm5yNGFHT3FrUVl5TGk0OHhkSlhodktQQmlHNTFEcEg4SWFmVjkyaTlCQWxO?=
 =?utf-8?B?SUFtdXZKUVNTSGRKVEFOVW5FU1dMTnBrdGdGcE0rTnhtNzd2NXM0RUNQaFY0?=
 =?utf-8?Q?HM/2B+FMXzre9mgPLyFwrk0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR08MB6900.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b94e6cb2-209d-4ca3-5f90-08d9a2c94c37
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2021 15:06:09.9085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qLXaDW15iGzWcJ5a5VCRoXuWSPH2tvXK9RyAVKDZA+kSMDnPG1nTjzBDKRBQDkvyzS/XjkAw0TeTdkhrJDSGcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR08MB5330
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWljcm9uIENvbmZpZGVudGlhbA0KDQpIaSBSaWNoYXJkLA0KDQpTb3JyeSBmb3IgbGF0ZSByZXBs
eS4NCg0KPiA+IFN0YW5kYXJkIHByb3RlY3Rpb24gZmVhdHVyZXMgaW4gU1BJIE5PUiBmbGFzaGVz
IGFyZSBsZWdhY3kgYW5kIG9mZmVyIGENCj4gPiBzaW1wbGUgd2F5IHRvIHByb3RlY3QgdGhlIG1l
bW9yeSBhcnJheSBhZ2FpbnN0IGFjY2lkZW50YWwgb3IgdW53YW50ZWQNCj4gPiBtb2RpZmljYXRp
b24gb2YgaXRzIGNvbnRlbnQuDQo+ID4NCj4gPiBUaGVzZSBwYXRjaGVzIGVuYWJsZSB0aGUgc3Vw
cG9ydCBmb3IgYWR2YW5jZWQgc2VjdG9yIHByb3RlY3Rpb24gd2hpY2gNCj4gPiBwcm90ZWN0cyBt
ZW1vcnkgZnJvbSBhY2NpZGVudGFsbHkgY29ycnVwdGluZyBjb2RlIGFuZCBkYXRhIHN0b3JlZCwg
YW5kDQo+ID4gaXQgYWxzbyBwcmV2ZW50cyBtYWxpY2lvdXMgYXR0YWNrcyB0aGF0IGNvdWxkIGlu
dGVudGlvbmFsbHkgbW9kaWZ5IHRoZQ0KPiA+IGNvZGUgb3IgZGF0YSBzdG9yZWQgaW4gdGhlIG1l
bW9yeS4NCj4gPg0KPiA+IE1pY3JvbiBGbGFzaGVzIG9mZmVyIHNvbWUgb2YgdGhlIGFkdmFuY2Vk
IHByb3RlY3Rpb24gbWV0aG9kcyB1c2luZw0KPiA+IHZvbGF0aWxlIGxvY2sgYml0cywgbm9uLXZv
bGF0aWxlIGxvY2sgYml0cywgZ2xvYmFsIGZyZWV6ZSBiaXRzLCBhbmQNCj4gPiBwYXNzd29yZC4N
Cj4gDQo+IENhbiB5b3UgcGxlYXNlIHBvaW50IHVzIHRvIHRoZSB0ZWNobmljYWwgZG9jdW1lbnRh
dGlvbiBvZiB0aGVzZSBmZWF0dXJlcz8NCj4gSSdtIGVzcGVjaWFsbHkgaW50ZXJlc3RlZCBpbiB0
aGUgcGFzc3dvcmQgZmVhdHVyZS4NCg0KRG9jdW1lbnQgbGluazoNCmh0dHBzOi8vbWVkaWEtd3d3
Lm1pY3Jvbi5jb20vLS9tZWRpYS9jbGllbnQvZ2xvYmFsL2RvY3VtZW50cy9wcm9kdWN0cy90ZWNo
bmljYWwtbm90ZS9ub3ItZmxhc2gvdG4yNTQxX210MjVxX3Byb3RlY3Rpb25fYW5kX3NlY3VyaXR5
LnBkZj9yZXY9MTMyZGUzNWUxNDliNDJhNGJlYWFjNzg5ZWFjYzAxZDcNCg0KVGhhbmtzLA0KU2hp
dmENCg0KTWljcm9uIENvbmZpZGVudGlhbA0K
