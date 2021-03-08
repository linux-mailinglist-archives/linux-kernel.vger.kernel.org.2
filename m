Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B33330B8D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhCHKpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:45:01 -0500
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247]:18075 "EHLO
        esa10.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231139AbhCHKow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:44:52 -0500
IronPort-SDR: UL25CWsboOMQLx2a3TLreXkNTMWAYM1lEx9CsnZIKRvJHXdPFUnFyKOe93qiUblviweOVBqu18
 Q5C7qL1NtHjCHEEhRdso/Bcfqh61Nmu981rkNLaV9LP66ktC4GWYRqltVgLr4gSuiqUU61k/yk
 SLLgaioqKGz8WlN9yetjL9arGkCFINdsOknDzkeGMQCKZxpzzXhs+3l8f+P2rK453nkQ7UYuKh
 HqDH2eBBkAwFXXRFkrVyHGgs0uQk8oeHpikbfYXmAyD8jachWTzq1kUw5MzlSWzxP6Rik6QgLe
 O3c=
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="27467240"
X-IronPort-AV: E=Sophos;i="5.81,232,1610377200"; 
   d="scan'208";a="27467240"
Received: from mail-os2jpn01lp2057.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.57])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 19:44:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrYTeY6JzBLckoxUbdrJ+6Y7+hNJx/LBHIio+WdIPxExsfF3KQVJfV9oQ+6zUHZPnOtBTwZhaMGsFAISNBGRe1n1cW2rsV6kZmhK0k4ZYODyfAboaB69c/3n4XArzsiBqA3VSF3YxQzFbhpQXclaaD3eQYdVq616myMeANbR4mXvvwUTNCteJ4Pszdg7HHQAOiQdr428JE6HsP07YuAidppH+Vis10UgcBM5wit8sa6LRxYezITQCt0pPfpPEop8orL/GxLlEgqKUoPr0YldbxOHqQMhAg9mx2od17uhjPE6VVm4qJWeZpsm+Gn4GJ750CJk6pqCw494H6lk7J6v8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIoBPwUb6QwGmjchYd1LLejP5jxBunZ+5o9XKelVxdo=;
 b=a3T68WR0aq7CPrDQTVT7Zewaqi5/HGJQGCu5HqaktDc96lrCMdlOAJtsg3HQ20hvzso2xKTWkIAN0TlkOz7ELmS6KGT9Dk3WvaMyFpZVFkG88YAjWSmYoMypkVr1kRECJVFHknOZnDnkWJzFOP/uQP5DN8g/9PBGp7FHFmIsOMc7H4xWPwcxtk4OSxmp/dlgwaM1hFqvu0I5BpZZB3Wazwot9+JGnhzl4A8BvYBGS7IlTQLIsDAO+misX5p3K0nheULVVeMEwB3TULSamURnpSMzEUwd1finKYfuUIotDl8ffngFroBBeD7luh4aWoU1jKPR42RcnEsbld0KWo4RNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIoBPwUb6QwGmjchYd1LLejP5jxBunZ+5o9XKelVxdo=;
 b=l7MpFUtMwLlAzcPz51Av01K3OR7jaJqiTQOHTemABXz+jt12henSZBr0iecPZKlvFIKcWGG3hb/FiJlwPYczom5gDtDm1Hty0x14kumKdjvc+MkfYe5YJT0BJNcy9xgc3QBXuYfmtmnrZNdsZNzSk5Zx6KB5PKpFYmikVlqKBjE=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSAPR01MB2196.jpnprd01.prod.outlook.com (2603:1096:603:18::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Mon, 8 Mar
 2021 10:44:44 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd%7]) with mapi id 15.20.3890.037; Mon, 8 Mar 2021
 10:44:44 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     John Garry <john.garry@huawei.com>,
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
Subject: Re: [PATCH v8 3/3] perf vendor events arm64: Add "_" to the event
 name, which starts with a number
Thread-Topic: [PATCH v8 3/3] perf vendor events arm64: Add "_" to the event
 name, which starts with a number
Thread-Index: AQHXEapNblI4cxFnaEqOEHogqiLL9qp1PKYAgASvMZI=
Date:   Mon, 8 Mar 2021 10:44:44 +0000
Message-ID: <OSBPR01MB46004A686748E775ED5C09ADF7939@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210305101841.3133721-1-nakamura.shun@fujitsu.com>
 <20210305101841.3133721-4-nakamura.shun@fujitsu.com>,<b140182c-3250-8c28-c28a-9dc3cefc89a2@huawei.com>
In-Reply-To: <b140182c-3250-8c28-c28a-9dc3cefc89a2@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddd6b065-d25a-477c-7fb2-08d8e21f2ff5
x-ms-traffictypediagnostic: OSAPR01MB2196:
x-microsoft-antispam-prvs: <OSAPR01MB21965B1CE4757B1B51303108F7939@OSAPR01MB2196.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lsj/8tGU3Yr4go0zgUL4whJJvKYhkIE5ksW3zjnnyIgRZRyLGBK1xYHUD2q4kHQCvOPY69cVU6f2r5FEl7Qjy0kc6wXr0CweQ/XJDLbVC3GmpxFNZ7UCzy/gzCYCPjnd1HimLfpcMTssTLuv7PYVNWiwjE2cD4qO0KOAwgKLihJSXjOm5CeucQ8GK2/Zg0O+iMXeyChjeSfSU0WEeiE2XojnBSyGvY57qZLtBu2jpygYSYVHQm9UBXWu/Tj8BLRpRL8u66UtzpE2UtzwRWvPJ4seouO566J2MLHoHI4GB29uO1+rpfIYZwpXnd3p9qqlY3+UIT/tewiqqt+83Wol46/kl0+wYpckjkkbCCOi7vBiA1uxOG7AyphgXIeEWqC5pm5cPVYCTWIbRbxupAp+LFO1NCKsUH5Y+ExAOvJCKvb9TeBmdd3FUFqHt5PWdv2QiiMQvrQ10jY5eDQy1N6kFraCcKYASQAPdqj4EcM5ZSgZ+78tOJY8AF73L6fDq8iEVBfNUVCfKmItZNXsjzv3mZrItrngNtfKHhlwsWCdc5ttHbfjFJPbqqZh3ZD6bI3z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(64756008)(4744005)(2906002)(66446008)(86362001)(921005)(76116006)(4326008)(7696005)(66946007)(66476007)(66556008)(71200400001)(53546011)(6506007)(5660300002)(9686003)(55016002)(85182001)(33656002)(52536014)(186003)(8936002)(110136005)(7416002)(54906003)(8676002)(316002)(26005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?ZEtJSlNwODEwTjhoaWtuSFI5ZmRYcG54dUdrVGNQY2dMcDlua2ZNekRx?=
 =?iso-2022-jp?B?akVXVFFSLzVjSjU5UUMzMEcvYTE3SUs0OWJGZ3pZNVZPemhlS2xEUlJi?=
 =?iso-2022-jp?B?QVJjOXpiL2ZFZ3AyVU1sSDAxNjM1cnNBRTVQbVVoalEzSGx4SnpWdTZM?=
 =?iso-2022-jp?B?Q2RmS1JFeDV1TlFXTmlzYS9QNTIwc2pSZVpWaGZkT0dLUkhIYzI4aWRH?=
 =?iso-2022-jp?B?aHhBeEJTTlBMZnhBZlpJY1UycmE4THZpak9GTm5YSGtiVEtsQzBTNmw0?=
 =?iso-2022-jp?B?RVNRSVlrRkIzSEZMRHpPZHF0dHhlSEVHNlhHOEErRC9WVzRVbW51VXls?=
 =?iso-2022-jp?B?OHdvTlBQMlBJZFVhTEl3M3FCUXFlUEZqRWdPWTloazlMS0xMbjhBbE5n?=
 =?iso-2022-jp?B?YXRjVWN5WU81V1BMWFErMGZ4aDB2TVFoNHA5aWU5MFZ0Sk1NdmU2LzVU?=
 =?iso-2022-jp?B?c0p1czNPRjBmTmtZSlFDd2dobXlsSkxMTS9yZ0pDMXdHZGVRUVBSUXhX?=
 =?iso-2022-jp?B?RWNkemY5RG9WdStTQk1wTzBZS3F2eGsrVm5ueWFPaTE1SUU3NFFYbmRI?=
 =?iso-2022-jp?B?eXlxRDJYbWZ0WS9aZzZDZll5Y2N4TXd2OXhZWjBZbHdnbTMrUnA0cHoz?=
 =?iso-2022-jp?B?WGZUaTJFYU9xLytINk51aFJWOEJyaUhoelJKQ0kybXJUK0ljaEs3b2Ri?=
 =?iso-2022-jp?B?Wm11Qis4WkNYN3RhZGlZRk02SUtqeFZzUjUrSkNzckFuMU0xb051b2kx?=
 =?iso-2022-jp?B?YXpFVnFnWlpOeWc5c0tOeE05a3V1SDhSdUMya2pXcTNxSENPbHBWZHBD?=
 =?iso-2022-jp?B?OERKQmJsbEpjRm5oVUFQaFV5WFI5QlE3RTV4OFlSSmdQaVVqL2Q5TjEy?=
 =?iso-2022-jp?B?dzAvaUExNDRoOTV0NTYwSDBLSU05M3VsOEQ4TEluL1RrdjZQNWh1ZHdo?=
 =?iso-2022-jp?B?TlhhU3JBV2ZFeHh1UGxpZmt5YUM5L3l6QitwVFZxWHh1cjdhMFFQSkZ5?=
 =?iso-2022-jp?B?bU1VWXJMdVppRk5WRWd6dzZaZXZGL1MwTU9CMUwyTUdzcWcrbVVjYTZv?=
 =?iso-2022-jp?B?QWp1VkZaL2ZsbktwR3VCakROQlU0K2k1M05nZU5qNGNhTzA2aFZiWHI4?=
 =?iso-2022-jp?B?YjE3aU55S2NqZEJGODA3ZU1YUGQ5RWMySnlOcmREWThlSEY1Zm1sQnAr?=
 =?iso-2022-jp?B?b1QxVVBUVForMytDMmFmbGdMRGEzTDdIZ0NiNW9oY1AvWGoxUW5IKzZj?=
 =?iso-2022-jp?B?VDdlY3JPNU1hOTd0c0ZydzU5d0d5by8xZkVGQUcyU0ZMVGxmdjcwblhq?=
 =?iso-2022-jp?B?TGo3dEk1UHNCZ3hJY0krV3FVbkFNUWhrV1NHTGhnaTEwUmI4OUFNUHgy?=
 =?iso-2022-jp?B?NHdxQnZrSUFQQWlLRlRXY2FrRjhlT3l0Qm8rMmNDU2xVaUdvcW4xSFFZ?=
 =?iso-2022-jp?B?bFRQankzbFJaLzJaaUI3ZXlUcEEyMnRCbGZFUnZZNUNYNG1qZHlnNFdz?=
 =?iso-2022-jp?B?cVRtWStJTWNHSjJ1MEN5YnhPUzQ0d2FYcjNNL2ZDUHZPaW0wQkhtUklU?=
 =?iso-2022-jp?B?QzZQSk9wY2hkN1JUU1FhZGd3ZjZSQlhhdFRNbG9KUHZZWDgzeEwzSENZ?=
 =?iso-2022-jp?B?SG1DMElLUHRLcU5iL3dKakpPckppZEt0bUd3SVg5WUtaSUIwWW5hK0c1?=
 =?iso-2022-jp?B?OEwyam5WUUc3V3VRajdKL3owYnZYWkdHelR5NS9tbDF2Z0hyd3JpYXBZ?=
 =?iso-2022-jp?B?TFVLVmpZb2lGcC82SzFDRjJJUjk4SDlwQUgyYVVFSk9OMm1TZE9wcmZt?=
 =?iso-2022-jp?B?c1ZjUmV4dnZGa1N4Rm05SDJiTUc5NXV0OTNRU0ZQWFF0anpWNGpCZ1hl?=
 =?iso-2022-jp?B?UGZuZndwS3RhSlIvZytwcTZTMGFnPQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd6b065-d25a-477c-7fb2-08d8e21f2ff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 10:44:44.8737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6DxtzbH0pdmqdZhsaBnAMdx5DBpZCM/gBQANnMcL6WibD7Mf1QJFig+3/hpwV882pbg6H8AxGkqITxSlxFEnJtabBtYhRO4vQO8im2Ezkqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2196
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, John=0A=
=0A=
> On 05/03/2021 10:18, Shunsuke Nakamura wrote:=0A=
> > The perf parser does not support event names that start with a number.=
=0A=
> > This patch adds "_" to the event name, which starts with a number.=0A=
> > =0A=
> > Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>=0A=
> =0A=
> I think that this can be folded into patch 2/3, and my reveiwed-by tag =
=0A=
> still stands for patch 2/3.=0A=
I will fix it.=0A=
=0A=
Best Regards=0A=
Shunsuke=0A=
