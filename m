Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1B031D6D9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 10:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhBQJME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 04:12:04 -0500
Received: from mail-eopbgr770045.outbound.protection.outlook.com ([40.107.77.45]:12854
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231810AbhBQJMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 04:12:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bePNJfXTL5ZKPGB4L5IjZ84WNiL3VNBcrWf7ZCxFYgbu9Fw4g+6UB0kLnVbNXJOZHZGuDM1v1IgcgC7WvFHNkO42N1pi+p5YeK9xEPL2tpZm+07633jFIMQVjkLS1ylwwp3Gm7W+qDs4CFMTB/3nblQIng0tOaKql4T39NBvR4xXgI6Nc6BjyHTIHoprc3WusuFMh800W4NVOVbvm6FJEgx72QCOpUogNn5r/ROFQ9BTlUQIYsEtCIaflcUobnQs5+2Bopc4bR0JbNwRucZXRFoehkiKpdXyWvMB241wzPw3K9+ar7XT1o9gg4GsfNubjku16EhI0o7HtQxnc98f0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZN3hB7epa5U8e8sviSIS4erC38qEHSFUGH+hOhLS9k=;
 b=YQDi6tqrcwsTxFSHCKpGiPz8IVd/7Cz12mFBO962Yj1zzwfFFWPFZ/SzvSND5IXcVKGk3/ZaFLOzmwEvY6pg62/VzD60rYJSPsfn2hVgf98GX1YqfFRuHRPbZRjaTe5OrlBobNi05e34TaXlPCUk0SoXkCN4V5iVTtFhQ/jtMwqNLkq1I8kFuHMqnqlq+PZD74wimXIsrdIH2AIvYo1rI7sn/g0eDWgx2q3WvzY1eVDB80qMEQkht4LtSxO24mcfvDhfkAKI7UhmcJO/Ql33KRc8YS7e827JbwZhPl+tq3bHoVHDZ4pXnTptUv7SdQX+LcWYO6brLI0NNsZZRA/PhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZN3hB7epa5U8e8sviSIS4erC38qEHSFUGH+hOhLS9k=;
 b=XtD4z4xSSHM4DlskJ20P44vVJrMEYt17vteay3xdEa6bc0MW99P55eQRyWajLa34tdPAmRJnbatsLBW3Xbyh/ppihisZEmZA5E7lqj3MG4N+dIBJ9Ppgp2EvyqjWrLHPWx4e7xxFaOG+1eO1vWqE3C8tGA6HtmUkCxvpZkzdW3M=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB3896.namprd11.prod.outlook.com (2603:10b6:a03:187::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 17 Feb
 2021 09:10:47 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3784.030; Wed, 17 Feb 2021
 09:10:46 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "tj@kernel.org" <tj@kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "htejun@gmail.com" <htejun@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSB3b3JrcXVldWU6IE1vdmUgdGhlIHBvc2l0aW9uIG9m?=
 =?gb2312?B?IGRlYnVnX3dvcmtfYWN0aXZhdGUoKSBpbiBfX3F1ZXVlX3dvcmsoKQ==?=
Thread-Topic: [PATCH] workqueue: Move the position of debug_work_activate() in
 __queue_work()
Thread-Index: AQHXAE9C4QJQTHLg7UyWOZ0wPkNeJapcGBV+
Date:   Wed, 17 Feb 2021 09:10:46 +0000
Message-ID: <BYAPR11MB2632DACFF2D6722222A3818FFF869@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20210211082351.178536-1-qiang.zhang@windriver.com>
In-Reply-To: <20210211082351.178536-1-qiang.zhang@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [106.39.148.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c9c9bae-2d46-4c29-011e-08d8d323e98a
x-ms-traffictypediagnostic: BY5PR11MB3896:
x-microsoft-antispam-prvs: <BY5PR11MB389677DD560DD2736DF5DBFBFF869@BY5PR11MB3896.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2vmpi4Tc0IaSBoFK9mt7Lm8n7CpX01rc1xzHC5XqPiU1+63a58EF2o+WuHdig9TfoLyRPwjTOQxdo5OXa4qaNCvqazXXOzWwPsnNLnTqgODvGhu9xII9kMAEtwRuEIYq0OHo8IEmDUP2Lxib7aqTaKsLx2ttGNGGFn2T7KDnAOC+vldFUyPV6kPpCQ1Zq5G3nwED9yrsNbDoRODJh/CUgutY9UUDyPk+eIcc3nBVzsx5R2RE0uXuqLYyey3IS6zPEOXxdkBf5fhXI70MmjygH1t8VIrnmFhrIItbWdxui3mM5sKWRW/y0wzij9b7uuSjkQ5/p0NgSNg91x/KXdSbQ29EPctV9zTprvwtTn2j0WtBNVeDWgrQWkf1TBi1shQYlHThO+jmXQDDPRBuL24nIiU2FkDeHP5Ta7cRzGq0oFYib5j4sXhfbFFKaO2C/5SNMZIsFb4j4wgL6c/87Sw3V3m7rx/8CYfsviiPlWOwkoPmK0UTVG3tVwG/u1oUJl8RSpM/GK8PAkoAM0ErE9bE3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(376002)(136003)(366004)(396003)(26005)(186003)(6506007)(316002)(91956017)(64756008)(66476007)(66446008)(76116006)(110136005)(478600001)(224303003)(66556008)(66946007)(71200400001)(2906002)(4326008)(5660300002)(7696005)(8936002)(52536014)(83380400001)(86362001)(55016002)(33656002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?N3pJZWJTQ3hQQWVhdjE4ZkFOWHRGNXNENkQ0ZVpZWFNMLzlIM214QURtMDAz?=
 =?gb2312?B?aTlWNlE0bDcrWlpYclYzZTV2Ukd6aFdyek0yRzY2c2MxeHYybFNDbDhkZ29O?=
 =?gb2312?B?NnhnRmhxL1l3VmZ6NkZDeEtaL2tRbEUwUDZicWVzNUdmS2l5ZlRCYkdibTR5?=
 =?gb2312?B?dzgvSzVOd2JwNW9MZkdaR2pKR1dseWVaVWlDSW14V1d2alBRTlRNcXp4bEw2?=
 =?gb2312?B?VE9hWndwS2JFME5iY0FqVUVZbmZkemI2Q2dESlRwT0YzOWJHKzRvTmc4Sm92?=
 =?gb2312?B?VC9QRnA4RStpS0FqcG1wL0IvS2dqQlV0dWdYWjY0dEpMNnVlZ1hSMm1nYzR2?=
 =?gb2312?B?d3FITitnbEtyQjVieXRmRmUwS2M3T3c0ZjIvamQ0SlBiMEEyVmdTbDhXTU9r?=
 =?gb2312?B?WnByVjhMMEhxMTNuWnYxcHN0N1llQ1NZQ2RJYnl5L2ZSS2NMZ1JjYXQ3QUNl?=
 =?gb2312?B?OWxhYjJkMmIrblI5b0lRK0FuM1NSdGZXWEpMV1hUVUdDazBUdk5HUnZDVWFB?=
 =?gb2312?B?TkI2a291RXNVbUpiNFJkMmFLaXdzZzBZUFQ1ZjFCcUgxTmJCRXhHd3dHb0Jj?=
 =?gb2312?B?VWJyYTIxS3ZXQVZTTEg5dGRadU9mNnRhOHQzYTkvNWk1RHNidEpRMWZGV2FI?=
 =?gb2312?B?S3lYeU80RWRkTlZadGZVSHpuZVZKVEdhdkp0d0R6TWtieUthZFErUkJUdXJQ?=
 =?gb2312?B?VzQ3cE5DWFZKdGR2U3JIekgydTFaY2VZbG9rVytPMjVzVFd4TEdodGttK2RE?=
 =?gb2312?B?RlRYN2Fnelc4WGNld1Q5aUNrNFVQRVRwR3l4cGFWVzFPanRPQnR6d3ZnVkhN?=
 =?gb2312?B?eWQ0RmZqL1IxOUdhMGhWQUs1QzFORWIrV05wOWVOSVVBQnJlQlRaZGgrTW42?=
 =?gb2312?B?Y295RExjUlEyMzgrV0FuMnBkTFo2b0VINi9TWlJUd2lNdDFZRE1ScncrMDUz?=
 =?gb2312?B?RXY5Y1lLMnU1bUVka1RzeFN6d2Z6Ti9zbndsNkpHR2FPRnJHN2svdUZNWXF2?=
 =?gb2312?B?VHNqaUFyRUpXWHV1Mk8xbGpoRmdlcDZQK0EvVzRlcWRkTlh1RVd6M3ZUSTV5?=
 =?gb2312?B?Y1dTLy92WDJrR3NhRlJ2V1JhMndmUVZZenQrMUwvUW1CRVFvSWorWlRFZU1r?=
 =?gb2312?B?WUtNZ05yRzhxS3YxeVU0WEJjRnJ1ZmUxVkM3WStOL2pvNmZqK3VDTnQ2Rkl3?=
 =?gb2312?B?VG9hL2JFekhGdGNHYTQvTmc0cFNxRmtxcDlpSyt4Q2dVZUcxTHpIZUJOdWxG?=
 =?gb2312?B?OXh3L0h2L29iZzRudU8zWVBlYmxjdVl1NE1WRWZHWmZuYjk2bGVJeDJQZ2xG?=
 =?gb2312?B?VXV0TzBmNUZZYmFYWGthZEFJSXZ4UEhtaXVGVWZDUzRYU1prM1hDN1FmTkdq?=
 =?gb2312?B?bHVjVmRoS2Jpa1RlSlo1aWtaYlV5RGNub3crYVlubGFJR3VVQU1PRzU5WWhy?=
 =?gb2312?B?UFloblZ0Szdka2lla3RzMTBVR2RZNzNxVGtKek13YTRyTG9ITkZFR2F1Y1p4?=
 =?gb2312?B?b2NFYnhzY0NQNU82aW1BWXZ2aEFWVnBsdXdxcUZweDIxcm5sVmFjeWZxK2Fr?=
 =?gb2312?B?WGhxTFlYY3NMM2tabkk4b25mSGxXZk16bjhkUWFuZ045NEZJc0MxODJSbUdJ?=
 =?gb2312?B?STlscDhSQ0UzTjhRUXluWDV0RVRuM3RxdFJucTc1eXU4ZWNya09kZnRtQ3Uz?=
 =?gb2312?B?bFY0SFlrdENXQnlzWENEeUhMS2NaVEpVNDltdXk2ZGxMNzUvdzQ4TTBjaUw0?=
 =?gb2312?Q?iSqkd/Pr93UnBMHbtQ=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9c9bae-2d46-4c29-011e-08d8d323e98a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2021 09:10:46.5878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lWoekpzsV+aO/gDj0ynGtx9w77bItjLoMUDcL6xNYV4jbUNNg8b3x2pcpXdn3pP9t5b3egyvqxL1fvv1XI92ewnALRIQkmfE5h/fUG3g+ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3896
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gVGVqdW4gSGVvCgpFeGN1c2UgbWUsIGRvIHlvdSBoYXZlIHRpbWUgdG8gbWFrZSBzb21l
IHN1Z2dlc3Rpb25zIGZvciB0aGlzIG1vZGlmaWNhdGlvbj8KClRoYW5rcwpRaWFuZwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwq3orz+yMs6IFpoYW5nLCBRaWFuZyA8
cWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbT4Kt6LLzcqxvOQ6IDIwMjHE6jLUwjExyNUgMTY6MjQK
ytW8/sjLOiB0akBrZXJuZWwub3JnOyBqaWFuZ3NoYW5sYWlAZ21haWwuY29tCrOty806IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcK1vfM4jogW1BBVENIXSB3b3JrcXVldWU6IE1vdmUgdGhl
IHBvc2l0aW9uIG9mIGRlYnVnX3dvcmtfYWN0aXZhdGUoKSBpbiBfX3F1ZXVlX3dvcmsoKQoKRnJv
bTogWnFpYW5nIDxxaWFuZy56aGFuZ0B3aW5kcml2ZXIuY29tPgoKVGhlIGRlYnVnX3dvcmtfYWN0
aXZhdGUoKSBpcyBjYWxsZWQgb24gdGhlIHByZW1pc2UgdGhhdAp0aGUgd29yayBjYW4gYmUgaW5z
ZXJ0ZWQsIGJlY2F1c2UgaWYgd3EgYmUgaW4gV1FfRFJBSU5JTkcKc3RhdHVzLCBpbnNlcnQgd29y
ayBtYXkgYmUgZmFpbGVkLgoKU2lnbmVkLW9mZi1ieTogWnFpYW5nIDxxaWFuZy56aGFuZ0B3aW5k
cml2ZXIuY29tPgotLS0KIGtlcm5lbC93b3JrcXVldWUuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2tlcm5lbC93b3Jr
cXVldWUuYyBiL2tlcm5lbC93b3JrcXVldWUuYwppbmRleCAwZDE1MGRhMjUyZTguLjIxZmIwMGI1
MmRlZiAxMDA2NDQKLS0tIGEva2VybmVsL3dvcmtxdWV1ZS5jCisrKyBiL2tlcm5lbC93b3JrcXVl
dWUuYwpAQCAtMTQxMiw3ICsxNDEyLDYgQEAgc3RhdGljIHZvaWQgX19xdWV1ZV93b3JrKGludCBj
cHUsIHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICp3cSwKICAgICAgICAgKi8KICAgICAgICBsb2Nr
ZGVwX2Fzc2VydF9pcnFzX2Rpc2FibGVkKCk7CgotICAgICAgIGRlYnVnX3dvcmtfYWN0aXZhdGUo
d29yayk7CgogICAgICAgIC8qIGlmIGRyYWluaW5nLCBvbmx5IHdvcmtzIGZyb20gdGhlIHNhbWUg
d29ya3F1ZXVlIGFyZSBhbGxvd2VkICovCiAgICAgICAgaWYgKHVubGlrZWx5KHdxLT5mbGFncyAm
IF9fV1FfRFJBSU5JTkcpICYmCkBAIC0xNDk0LDYgKzE0OTMsNyBAQCBzdGF0aWMgdm9pZCBfX3F1
ZXVlX3dvcmsoaW50IGNwdSwgc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKndxLAogICAgICAgICAg
ICAgICAgd29ya2xpc3QgPSAmcHdxLT5kZWxheWVkX3dvcmtzOwogICAgICAgIH0KCisgICAgICAg
ZGVidWdfd29ya19hY3RpdmF0ZSh3b3JrKTsKICAgICAgICBpbnNlcnRfd29yayhwd3EsIHdvcmss
IHdvcmtsaXN0LCB3b3JrX2ZsYWdzKTsKCiBvdXQ6Ci0tCjIuMjUuMQoK
