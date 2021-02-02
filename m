Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E07230BB8B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhBBJ4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:56:33 -0500
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88]:25269 "EHLO
        esa8.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229991AbhBBJz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:55:58 -0500
IronPort-SDR: JGiUYPRCsiSUCv+wR6o8mlElmmnqj3/jbfckullpJ/IEpPeTKcO16fpu56As6xSkI3pwJatGQo
 +i5Rf/gwUf1tfDzgZExzj/AY+XRFkuc6zNSPpVs0X6SNIZfoS1mNtDgJ/bT01x9QovAC2zxgfK
 0QL+++6Wtk9CztWLMvXAnAS4E4x4Tixq+08WVaHh3jUrgnqM/YBrxVyv0PTxnWDmCVNAcOb2iy
 wGPWAfJQK+YN6EpLzp7dc5OAAArFb31iogUqL5xRKD28+r/mhmmm+M/FTKEUjn39xybnGc7+wE
 M/8=
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="25481611"
X-IronPort-AV: E=Sophos;i="5.79,394,1602514800"; 
   d="scan'208";a="25481611"
Received: from mail-ty1jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 18:53:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQRnoz32eK1LlrHsXYVfyNXUOvtgeJlMWHTu+iVbXkQTZR0xGN1YlG207ddvPq16p4nDJo1GEhl/thtiL3YREaWvX7Sz62YVBtnI9JyDNbEP72qwjReb5cAm3C+yTC/VtOpkNH1xc9RTDMCv9fUL8I7jb0QGrx0TTRJLAVb3SbVyf6+uMgCO0KvbEKoCSrA99IcL1lfQaWGQVa5u/shnnza4LteITtmyUEo0tsPfqIzAxUjk6CVwncyoE5Zg9I++6QWcdfZedFGA72tWQsS/zUQhFARb14u0YMRZ8ECGuJrpSlnjE1EWWbutmj5SZSYl8xL3SuhqtoI2OHZgyqDP3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaUdPYC57kmhFuXH+xBWeCRsuDV/Ghnh8drTX/9eKJQ=;
 b=c6gwHwDtDBz7SlIbql8RILRvMt7D2EmaSYdmTiDExAH0uQWubjFCCWgNwx9uUTHxCMFDJ+jyBzHDXUz64hjdeRNWf6XzvvYEGxp+f3foDg1LqbrnoSJd7RVa4ho5ORLNElTLiOty95MWLzL7qsYeFIz0CK7pAtRpF/A5kkUhPFLaygpCWbAdN35yAxz9NvscrsjpYjErZXQI7UMir3M2hZqBgq87xKvcA0wm/yh9PN6ztoYPyMr0M5qT9eTtfz599VHp3iJWLYJhcbdE/TBcZBDDspoQmrD+1dWL/EIy8x4f0TFQc2WTt/nXZ9j5eyfJR7f80yKkXYIZKEPlH3tipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaUdPYC57kmhFuXH+xBWeCRsuDV/Ghnh8drTX/9eKJQ=;
 b=qC8FXfZG7cmZEbZuxd1QX98Ndfjlm/IrgTe+rgyUXqlQNlOlYgVUEJpM+yP7KZyORb/I+ZnaegM1MmRlmVGnyjxlULgF79wnceoXn10w9feWjFusKbAeGFF8KJ2VBwr+1soWOlthpecU+JhDuChpzghBobKxGBm2D3uPy7B0e7M=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OS0PR01MB5905.jpnprd01.prod.outlook.com (2603:1096:604:ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Tue, 2 Feb
 2021 09:53:29 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd%7]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 09:53:29 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     'John Garry' <john.garry@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/4] perf vendor events: Add L2I_TLB, SVE, SIMD, and FP
 events
Thread-Topic: [PATCH v4 2/4] perf vendor events: Add L2I_TLB, SVE, SIMD, and
 FP events
Thread-Index: AQHW+IwaBJwIDV7skU2AoKNC0iztQqpDWkoAgAFFj9A=
Date:   Tue, 2 Feb 2021 09:53:29 +0000
Message-ID: <OSBPR01MB4600196B268A2341929BBA39F7B59@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210201111310.3231469-1-nakamura.shun@jp.fujitsu.com>
 <20210201111310.3231469-3-nakamura.shun@jp.fujitsu.com>
 <fd65e539-d8cf-e1d0-103b-ad8154a42173@huawei.com>
In-Reply-To: <fd65e539-d8cf-e1d0-103b-ad8154a42173@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckermailid: 4554a1b96ae74d51a8aa9d5a4f8a9ead
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc582f8b-dcce-45cf-97ac-08d8c7606511
x-ms-traffictypediagnostic: OS0PR01MB5905:
x-microsoft-antispam-prvs: <OS0PR01MB59055FA92A6F16955A847EB5F7B59@OS0PR01MB5905.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P6xlSYfb3IZMwRoeGpBYOOfyx9kvETPAP0qTVbmXxsbalw1H+kAkjylMSeU+Xhs9t1p2Vip7M5KZSnyQRD5a1zect5eqs4yGFo/yXWo2hnukTWyxZs2dkd+Qd/SV3HZxRaClzFV/IK8H79texnMRbS+J/CtT4PEwzr9HR3mRGR53uirPA5c8U4udtam7X2QKsrziWzEdpkCrl4BobEC6SABwlpAaiT8JXIN22dZNUjbQcvFNEePUi+IjZVX4wgslvrlOdA9RZVD9S92pvb7vveJvjaIfNbdqqPrAIuaWXCpImpnA+hgGLQS1riju745V3N/ccnO0+fjoGmtZ85nilHZIpMO7CuN+AgazGLKbIckTvN5nBvrml/k0XiHK63uBru5y++iQ/gJGTxvUz4UERxmyb8+ctpl2Fv/R16+4G53LH95Wl0lrkgVH+rgrZG+88tK740GYUs5Tc0oo42e1kpyYTQ1b19U3CZR26zzFxr0T3BH2pP2CeZpMZAHgd+aDLW+OLGnn/+PyJW7MANV+6Rt59xN0C/Bsb40XIfrwbTFvchQJ8DD5q8fnC1o4PnHMkQP9y5T+XCwsSM+rVw67Xg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(8676002)(2906002)(186003)(4326008)(64756008)(55016002)(66476007)(86362001)(52536014)(33656002)(4270600006)(478600001)(9686003)(85182001)(26005)(66556008)(71200400001)(8936002)(7416002)(110136005)(7696005)(76116006)(54906003)(5660300002)(6506007)(921005)(66946007)(316002)(66446008)(558084003)(777600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dXR0QktSTFVlVFRuVzhBZnRqMzJ4Q3Zodk9DaHJ3UUMyaGxwRlJsRjBra09t?=
 =?utf-8?B?cG95OWpvMkc4ZmNHa1J4YnlRdS8yV1BVcXhuZXVXTi8vcTlCVVFxeE1KbmhJ?=
 =?utf-8?B?TTQ2ZVFNcEtGVzJFSjlTbmg0dVB2cklQcGRVOHBYSGhlSHB3cXhERjUwOTFG?=
 =?utf-8?B?QS81OWFjNWczUG55em12ektnL0xRbi9sdE1tY2o0Y21uQ1ZuNVRrVmZ0SFVH?=
 =?utf-8?B?SjF6ZFFUQnVGZXlrU29ob2JzZldqMXNPUkZUaUJPaGIyNDRHNjZzeDQvZlU0?=
 =?utf-8?B?TG1wQTZ6TVhRS2tJc3F6SlRLcGh6d3dRak1EdUxCTXlRRlVHbWZ2VDgxbG1Y?=
 =?utf-8?B?aUQzV1g2ZHhDODZJaGtXcHIwM2pDUWtvUlJWZ3NHRWRscWltMmR3bDdVdTY1?=
 =?utf-8?B?dlJibzV5YmVZQ0NJdWdMMGZHVGFDNnVmVVRXdE1hK1JWM1htbXVzc29KUTJL?=
 =?utf-8?B?ZVpzOFJBcEhSYVVwTHM5dHdmSG5tdjRvWjZJcEVjelk5MGg5czJScVVjTDBQ?=
 =?utf-8?B?TlNrZXpucmV3REFSSnNKV2VzS0Z0dWhZNURING5NZ3NlbzhlRk1QL1IvVjQ5?=
 =?utf-8?B?ZktQbUthaTlBUTBqcVNBYUsrdFhIZ3NNcjJ2M1U2VjF3Q25RYVVrKzgwRmRD?=
 =?utf-8?B?S1djcTN2cUppSGFJQkpnUlAvN0xBbWtUaXVhYm93WGFtT1hoT0R6cFVZaWty?=
 =?utf-8?B?NnY5c1ZKWVg2dCtyd3ZUUGNVKzRuZnQ3blExYmNQTTdLVGZJVDlGN1k1TjQ3?=
 =?utf-8?B?eVdsV3podHpRcVJXb3FjRFpGVU9TOWNFTDFkWlhYQi9rQmEzdEx1eENJWTha?=
 =?utf-8?B?N3VwMVdMQlBMZnlOYlNrcTBuNWxneHRSSmRFK09xSXgrWS9YaDFlUkQ0SGZz?=
 =?utf-8?B?MXRiY0tLZVV3bktheVBTRldqbzFEYjdmRnJJQ2FibjV6S0VQWjFEeDBRU3VG?=
 =?utf-8?B?NFF3MzBha2tUTG1yQzdjMjdCNU5DM1hYZW5aRXdJS01BSjBEamJ3WVpTcitm?=
 =?utf-8?B?LzlQdnpSRnRWaDdNaHVFYmFqS1lPa1pTYTBuajFlU0dDM0p5aTVqUStPVUo1?=
 =?utf-8?B?SWdxajBHVWd4djRsdDVmSDM2dTJyMDJhdDlYanlFVnAxZ2puT0dMZU1GbEdO?=
 =?utf-8?B?eVBSaXJ2UWQvYlE4ejFxU3dBMjZLeUdxQno1T3IySFZjeUI2YytzdDBxTy9P?=
 =?utf-8?B?NzJ1V3RkNDlJTjBKZkt0NXVBTFB3WXJlMWlFbVpmcU9QalVxbFo0RDEvM2lY?=
 =?utf-8?B?aFRoMkFPVmh4WUd2dXN4ZXhSbnprV3dTdzRnOEpiQ1AyMHFMMW13M21hTW5z?=
 =?utf-8?B?c0MxVnR3NzhwTGtIb2MxK09NbEdZakpBYmdITHBWdkNtbDRxclBDREFwT2U4?=
 =?utf-8?B?MUtWeDhyamhubDJtUjVsOXdNR21jUVBqdzZYcnJtbk4zNXlsS0lGckZEQzZh?=
 =?utf-8?Q?g4Osl946?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc582f8b-dcce-45cf-97ac-08d8c7606511
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 09:53:29.8625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tM+ncj9kykJjqVRkqfJRKvy8ByTmNXuR1mr1r8ieOYV0cunCazvylEm32paDZLb72aKUBYUF0zOKq/3BYTolLo3/P4Q5HTr7FOteH+xjd0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5905
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEpvaG4NCg0KVGhhbmtzIGZvciByZXZpZXcuDQpJIHdpbGwgZml4IGl0Lg0KDQpCZXN0IFJl
Z2FyZHMNClNodW5zdWtlDQoNCg==
