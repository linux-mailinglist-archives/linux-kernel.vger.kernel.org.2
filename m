Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E143128D5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 02:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhBHB4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 20:56:19 -0500
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87]:5111 "EHLO
        esa7.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhBHB4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 20:56:18 -0500
IronPort-SDR: TPa7vrzCDDqqBfkxOj2vUbOfezpTAoI630ef2Van05BXBEtlL7GrLBnAwwATieh4DMG911w071
 UOBYGcpGzZMzT4vkH7AlrYBgvEIooWxaT5gzgS+hFwD/Alt39KL5iOAKiy7D+SGVePwPRnbyLP
 QrAUw9PHI+Asnh26jaYLvCBTkOal56wxALJOIxmIAiU1z4gk2bHrPpdDPm1J39Cce76W9CUP2g
 0YaYd6SOLB3UH+fr44d+N7xziIQcP2wqZ60zMMGO2SaW57L6uFST29zF7hrl0or+E59S1TS/DD
 YMU=
X-IronPort-AV: E=McAfee;i="6000,8403,9888"; a="25698449"
X-IronPort-AV: E=Sophos;i="5.81,160,1610377200"; 
   d="scan'208";a="25698449"
Received: from mail-os2jpn01lp2054.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.54])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 10:53:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K61c4JVeAsgEp60xowqm+B5aQQLaXi2sHgVrdWKCvCa+Iqyk5KclMbk8Y3nN9+mRgPEPE5l/yRTHrusUGS4+Dzn2qF5Tb/ebPXk+QXBmCR4JXsKqQ8suFRY0dGx1h88whqBNE1AFItQbVuQWJUkKaNbhcLozzaFttIZ5NGQmWLWWsCPY1/xQSA5WpZXYeXGQjrurmffGAPo7SxtSIOr4BQ1n+Ofpty4PngodUnTYur8G+3ucI7OYx2oRQo22tjLsXbpY7FVPAO+C0g+0tElEYTc4JNrUT157MjWk3s78EeXb+Nysx1Nk8cyU2SfbYkL/rIHU9Spjf8bI/EwCDS6+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kickNFZk0+bLwRsw3b8nHmI+8YpGXfSwZmtoDGqbOQU=;
 b=dsIjeCbY1cQd6rQujWrW5a09wh5rtaE1nPdaB/Cqk/mpifXqO9AH0F9n95QWt9T+m7mErmnRurfVbOzGr0BV+K5v2uBb+z4vM9xWpgcfKC/6aAXN6ikK5l8Fo5KfVyjRQziDdfjU2IPq5akTUgrz4aGJdesjRlNWHGncCNXgz5jHVlvdC1T64oZGOSMzwjgwCd1vG7knQ0yD6N42Ei8wAiykbkveh95swv2KPymjfPrYNq9vL2DTbCi6eA5aJtJdsyP0FTLMcW3MQ8hNE39dxfzKz0UHX9P6JgzUmkAYTgRlH5Az75m5DeLUnUSjVOlhcwFMyyfp/Urp6FnpvWA3cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kickNFZk0+bLwRsw3b8nHmI+8YpGXfSwZmtoDGqbOQU=;
 b=hEo/oO+DIdxxDaPxSoUxoS1bvA1B9LYKaJ76B17Eh6kzAdnsz17W2qi9T/6Vp0a8fN7NsYZguB4A3Vnewze3d3ZajuLQOFCI9Qw0Hls8z8pDCoxAH5BYU4C1c7HCQfkHtVvMJqy6mbr3JrzLgPdUzFt+R2YExm72fvzWGIKczv4=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OS3PR01MB5751.jpnprd01.prod.outlook.com (2603:1096:604:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Mon, 8 Feb
 2021 01:53:54 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd%7]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 01:53:54 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     'John Garry' <john.garry@huawei.com>,
        "'will@kernel.org'" <will@kernel.org>,
        "'mathieu.poirier@linaro.org'" <mathieu.poirier@linaro.org>,
        "'leo.yan@linaro.org'" <leo.yan@linaro.org>,
        "'peterz@infradead.org'" <peterz@infradead.org>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'acme@kernel.org'" <acme@kernel.org>,
        "'mark.rutland@arm.com'" <mark.rutland@arm.com>,
        "'alexander.shishkin@linux.intel.com'" 
        <alexander.shishkin@linux.intel.com>,
        "'jolsa@redhat.com'" <jolsa@redhat.com>,
        "'namhyung@kernel.org'" <namhyung@kernel.org>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v5 0/4] perf vendor events: Support PMU events for A64FX
Thread-Topic: [PATCH v5 0/4] perf vendor events: Support PMU events for A64FX
Thread-Index: AQHW+WMHTGeMdPN4T0+BYj0CxDS1qqpFEjAAgADvEKCAA3DPIIAEFEWQ
Date:   Mon, 8 Feb 2021 01:53:54 +0000
Message-ID: <OSBPR01MB4600E5D5B5BF038D5A3F8544F78F9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210202125140.1785583-1-nakamura.shun@jp.fujitsu.com>
 <57c6b89d-e0b2-3df4-8dcf-2cc71f772cb4@huawei.com>
 <OSBPR01MB4600991FC47D2E5A7E013F0CF7B49@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <OSBPR01MB46007C599F706F3C56B20E64F7B29@OSBPR01MB4600.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB46007C599F706F3C56B20E64F7B29@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckermailid: 771f7cf5d4bb4206bd03fdfe015eccca
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [210.162.30.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ba54767-68b6-4363-9876-08d8cbd463f3
x-ms-traffictypediagnostic: OS3PR01MB5751:
x-microsoft-antispam-prvs: <OS3PR01MB5751090EDB36C289F7D22851F78F9@OS3PR01MB5751.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CGOTDYCCrN7fwCt+LQ2y5g1G70x5UpnXHHtW6sSnWPwA/zvEnGVkarbcGSVBkzzqlTSK9FzoMdOOFfIpgYLW1a82/Bu9nRo6rUPXlloVqnSD0unFyuLTFdfVyduU+Vnb/BoK7qFmKms8rKB2E8YcTf86NL5yIF3kuFXWMwclLd7u5P03jFV0vOmKwiiLlY6o/6Q0FB0MOigDd1GbakaonJyO/q/uzvigw2ynCU5XwL0tDpgoLQ9crnOHW1g3E/MfUGluZgFyZtt7QYw03H5QGMlTNJcayIhhSURZhL1WQNnSQVaIWBXgPSBHp9H2/uMwiVt7orEESuApsCBagCug/cVkDzlVQdVCkLv7OYtgrmO23BnE8+uj1AZuATWITjC/g9AAxADalY/czpaOL9q5zBwOXnAH18sQO3eEM2Clzql5cCLwT7YcBdFWPetj0eNCMR96uHawfquDwz0bdTkz7AinViERQCYb8F2ozBtr4iW+mJT4KftKJPxapPZPBJpyhoMi0/rLPbE6kcL51o9DNQx8TAv1GnXGYuGUj5tFjn8Bp1BNz/kUBS7lumTsF7BZrb5wRTohTdjleAaAbIP8AeE8Kp1mNiQFACSKoS7TU0g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(8936002)(9686003)(26005)(186003)(4744005)(55016002)(7696005)(478600001)(54906003)(76116006)(52536014)(86362001)(64756008)(66556008)(110136005)(316002)(921005)(83380400001)(33656002)(66446008)(71200400001)(66946007)(8676002)(5660300002)(85182001)(4326008)(7416002)(2906002)(66476007)(6506007)(777600001)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?eUI2T1RhWkdhY3RxcFNiNG80djFueHVPWWdxWlkxbmJxc3UzaWJoVXEv?=
 =?iso-2022-jp?B?ZGd5Z3pJY1U3VnAwWW5PNEM3RzZCYi90TTZFK3phYnJkQms1VDZrQ3RN?=
 =?iso-2022-jp?B?RTZaMVlXSlR0WjE5WmgxcTJsZW9RWnMremRHb0ZURnBPckFpMVNJQ3E5?=
 =?iso-2022-jp?B?eWhZcHJ2RWZiZllUekllKytYVExqWS9GcU1LU0xFdEVQOWJvbVJ3NXY5?=
 =?iso-2022-jp?B?NVdlc3hiT0tNa3FwT3l3WkdSU01mZ0RQK1BWUm9lRUM3QlA3SC9UbzRV?=
 =?iso-2022-jp?B?bjFiYmNrSzgxOTJLVzU2Q3hZa2lLQWI4YUt1cmE5TEZ2RXAvM1AzMHF1?=
 =?iso-2022-jp?B?YXd6MlpBMkljNkJZL2gvWC93ZytQOWlKRWVWVW14Unp5UUZYVTN6WmF0?=
 =?iso-2022-jp?B?SlZpOERjWUUxNUZkOG90c1NtQlNPQnRNL1ZENGMvR2NJTXlFV0ZVN08r?=
 =?iso-2022-jp?B?UXQvWnM2SGZGeW9xZmNwTDl2TjJWR3V2Zy85akM2WnNFeHJRaEtJc3lH?=
 =?iso-2022-jp?B?T25UWUE2WkdVdTZzRWtsSlJ5S1NJTTI2cVU0d1A2L094ZTZWVVNVTlJj?=
 =?iso-2022-jp?B?ZVordFNHQ3YxenprWVpJZ3p4WDczOXZkRmk3dzd6MkF2eldncytBd1Jp?=
 =?iso-2022-jp?B?OXFxK2ZpR0ZBOVZLeHFsVDY5Q3MrUlZSRTh4OVVOTi9NYlhCUDE1cUlB?=
 =?iso-2022-jp?B?L0lLdzJKR25sK201NXBicHNkRXhNdlMxWE4wUTdDQzRjZFRha0NldjJS?=
 =?iso-2022-jp?B?YlBncktuNHhSVmZnLzJESTRnSzlBNXMzY2xFMWt6R05RV1hWQ3FmeTYv?=
 =?iso-2022-jp?B?b21YVFdrMGY5anROelZzQzI4c0oxbWFsUzlwekxKUUhEdVpnR00wWEs0?=
 =?iso-2022-jp?B?ZDdtVTM3YzBSdUxlNnRwZnNaTVVMNnhtd3g3NnFJZkplZ3RlRk15NHVN?=
 =?iso-2022-jp?B?UGthb1QxSkxiN0Z4YlIvTld5Y2xBdW55VXB2ci9LT1VaSGt5YXp2S3k5?=
 =?iso-2022-jp?B?UVdrYWpwcUpuazZPM2dPMk0vZDQveHRwQ09MMkt0TjhKK3Z6K1ZUcTJ1?=
 =?iso-2022-jp?B?YVROSU1pTGk2OGw0UHNFa0Mxc1B2b0xHV0pzSnkzaHFUZ09EWFVnTVV2?=
 =?iso-2022-jp?B?aGVVOUFpbm5PRlVmUzMzK3pvaXBKWUdUSUtRTlRhUk4wQnp3WjFnWWdw?=
 =?iso-2022-jp?B?a3Y1b21XVFNGMVIwUjRDVWNzUC9IR2hkcllGdERIeGgvaDZpVkJ0V2x1?=
 =?iso-2022-jp?B?aHRxZWNXTzNraDAzRFQ3SEpsZktoMkhjb2hZaFd3blgxcnBNa0dOaTh6?=
 =?iso-2022-jp?B?ZWJVSU50QVhwVytWTUhWUy90TjEwQmRTMjN5cjJaZ1FyMmc5WEJuS3lD?=
 =?iso-2022-jp?B?czBQQkJvWEdFSkEvWlJ1SnpPZGcxWmo5ZEZ5c2NaZmVMOEp5ZXQzdmZY?=
 =?iso-2022-jp?B?R1ZOQ2lwRi8rZm56NEJPaEFQT2tvUzhBWVArTUI1Tk03OEw4SWNBS25C?=
 =?iso-2022-jp?B?aURucWhheEdWQ2hJak1qY1NCT2RBLzBOYkdqV09WRjNNK2dDK0ZTMTVY?=
 =?iso-2022-jp?B?ZWRBejVpdUZTL1dTUDNmQkZtYjVkT0xwQjZMYXV2RWEra0NJSnhLeVNl?=
 =?iso-2022-jp?B?eXNNT1ZkNlUxZXpCeXRIcjh3ZlhPRFFDZGNTSVBNTnVoWXhadnJGSHlt?=
 =?iso-2022-jp?B?eGlaVGd1dnU2RTloZ0Exbmdqd29lNFhrOG9BZk5BN2kxNG1UTkpyRUda?=
 =?iso-2022-jp?B?WFFrZmhUdWNnZ0g1WXdkemxpRGM5eE9VbDhHamZ5VEgySElvZWZVY0V4?=
 =?iso-2022-jp?B?OVBDazFpakdOMElzVVkwc1ZCTEE4bHNwcFNEWjV6ZGFoVUxKemkwK09U?=
 =?iso-2022-jp?B?ZFV6c05ZMUpkUzI5YW9xdjhNU204c2NVZ3hZblNQSFpJREJ3K3FDRHIv?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba54767-68b6-4363-9876-08d8cbd463f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 01:53:54.2439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mnHnDqYu7aYvY4rqQ+MZxxeDpyqUnfYlhHLZ5U/T480SiJte1S5HG3MSpQfDvoFfxKP1Ac5Ezq+iqoT4ymk5wcCwnWgQEOXsKK13TaxIFes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5751
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, John

> > > Apart from that, I think that we're a bit uncertain about patch 3/4
> > What are your concerns?
> > I think it's okay for perf to read a new event code with a number at th=
e
> beginning.
>=20
> The impact of this fix is on {name} and later rules.
> parse_events.l uses {name} only in one place.
> The only rule defined after {name} is {name_tag}.
>=20
> I think the point of current fix is that the rules defined after {name} a=
re not
> misrecognize and the syntax is not broken.
> {name_tag} starts with ', but {name} does not contain'.
> Therefore, the corrected {name} does not misrecognize the {name_tag}, and=
 I
> think there is no problem.
Do you have any advice?

Best Regards
Shunsuke

