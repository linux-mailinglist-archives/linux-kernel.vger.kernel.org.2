Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEB738BFFA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 08:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhEUGti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 02:49:38 -0400
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212]:12688 "EHLO
        esa3.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232027AbhEUGtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 02:49:36 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 May 2021 02:49:36 EDT
IronPort-SDR: 3fE8DJJidGkQm33ZVoDDIPSVZSIadk7syZ+NHEs8H3JZnjLOh0hB7FA62y90AqghxA8n3v3LMQ
 8q/1eyT4X35GmC1VUKBkkHKwIQt1K7ehEEsog0RJ5VwoyVtuO6m11Al1kzwD+nffR2ydAviy9x
 n8EDrAdHyS/gyljiORW4t/EyuVs7tJPR8TPO8jKj/nIwnFacDm1GsOmY56NjbA8hqOVhL4vZbK
 4Vrii5Tah6jpRMBrGfyjI5rEslaHp8Xvk1f3vTGUg0BGbwNXo1eSomsc4/2JqvmQO5gTvTXt/5
 Vqw=
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="39782119"
X-IronPort-AV: E=Sophos;i="5.82,313,1613401200"; 
   d="scan'208";a="39782119"
Received: from mail-os2jpn01lp2059.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.59])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:40:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ME9AVdUv66egINLcGc3W4DHKbxbvwHSI4PwwDalKEcUA1tnJ9EU9y9Ha/lk5HeAJS17bVgIuvbdUVW7LsHd0YFwHxWllzHyfchkHtZbyC8fDUrR62fvpnlI0V6BME7TMEq85jP0PT2mpzAH9KJqzO1im5yrXb+KktV6Z6wovZcAfbA0t2tU04lNAfBFFtt+2IwB+cvrJal7Bxrew0lhJCS7ImFSmDOGoVyCJXa/pXgOAxaJcFgyvE2PIHW0R77vVF6/XHlPepAtyY8Xh9K4OGmFWt3hmCDgFPEhlnEQyuAzVgpK6dmk70sibGMWi+2VxsaHbsx/g26L+YU+6i+3HjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDoXy0b16f9vBQpZjrmHmZfrQ2Vu5rhjfi9BJLURlQQ=;
 b=LPyq5ZraMeTiA+h3taJi3H+/4I4AG/2dAZiUjUu7fTx6Bed920bxzxWztFNdZaZlRPAJEIyzvbnyF7IRK3hx+4OmT/JLQvIRhGF8picbQltq1TZm3YGxDHarbZo07IlfM4vwVnM3NLrnX9wbt11DRf6OzTNvazgxBfndVufdIxo7GxtvJAIvemerddiBqpbuXgkhTxG/OoWShriTfUoN0KxXyxlPbY22IXNoEjKvX/sbFtuNc6gsoWrcQZJa/NxDjPJRJVqNwl0UXb2PN/sgwlYLqnNEs8TODYNVaE3tBsC5g8bceDTd4y/iOx7fUjmkCtyM6dThHPUdA98W/Tsazg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDoXy0b16f9vBQpZjrmHmZfrQ2Vu5rhjfi9BJLURlQQ=;
 b=PrLQksdYyMGPim2CZcrM+lwN8VhBk3dbQ70n1Oo7vt/cmoVJ8UgLzrO+fcdA8/k5y5YmO6nS/WjBduOaPTQPgl1/ZlWSEENnwFtkRUpNz+tGZreguCuPxbMlLv3oHDdNPBBFfA+JTUapi0jqs4mm8PEi6UqozDJfPp/3Pib6pAc=
Received: from OSBPR01MB2183.jpnprd01.prod.outlook.com (2603:1096:603:22::14)
 by OS0PR01MB5747.jpnprd01.prod.outlook.com (2603:1096:604:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 21 May
 2021 06:40:53 +0000
Received: from OSBPR01MB2183.jpnprd01.prod.outlook.com
 ([fe80::702e:951e:8f05:5cbf]) by OSBPR01MB2183.jpnprd01.prod.outlook.com
 ([fe80::702e:951e:8f05:5cbf%7]) with mapi id 15.20.4129.035; Fri, 21 May 2021
 06:40:53 +0000
From:   "hasegawa-hitomi@fujitsu.com" <hasegawa-hitomi@fujitsu.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "'fweisbec@gmail.com'" <fweisbec@gmail.com>,
        "'mingo@kernel.org'" <mingo@kernel.org>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'juri.lelli@redhat.com'" <juri.lelli@redhat.com>,
        "'vincent.guittot@linaro.org'" <vincent.guittot@linaro.org>
CC:     "'dietmar.eggemann@arm.com'" <dietmar.eggemann@arm.com>,
        "'rostedt@goodmis.org'" <rostedt@goodmis.org>,
        "'bsegall@google.com'" <bsegall@google.com>,
        "'mgorman@suse.de'" <mgorman@suse.de>,
        "'bristot@redhat.com'" <bristot@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Utime and stime are less when getrusage (RUSAGE_THREAD) is
 executed on a tickless CPU.
Thread-Topic: Utime and stime are less when getrusage (RUSAGE_THREAD) is
 executed on a tickless CPU.
Thread-Index: AddG3PD5Dm9CD2RNQ7+TrQrb7bYc8AE2IspgAAJjxoAAIq+F+AARwywAAAAeGgAAXleiXg==
Date:   Fri, 21 May 2021 06:40:53 +0000
Message-ID: <OSBPR01MB218357232513BC4EACD0FB59EB299@OSBPR01MB2183.jpnprd01.prod.outlook.com>
References: <OSBPR01MB21837C8931D90AE55AF4A955EB529@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <OSBPR01MB2183384B29F6291EB7C0BB81EB2C9@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <YKN5cQpFSdsgBlBU@hirez.programming.kicks-ass.net>
 <OSBPR01MB21835E55331FCAE6F75E8332EB2B9@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <YKTZag/E8AaOtVT0@hirez.programming.kicks-ass.net>,<YKTaNJ7r/sHnwb5W@hirez.programming.kicks-ass.net>
In-Reply-To: <YKTaNJ7r/sHnwb5W@hirez.programming.kicks-ass.net>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af12c6ee-e3e2-47a8-2039-08d91c236160
x-ms-traffictypediagnostic: OS0PR01MB5747:
x-microsoft-antispam-prvs: <OS0PR01MB574711C957BF5A68770BF0BAEB299@OS0PR01MB5747.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ARsloL/fxuW647AVSEztntn2Q4QQDtfwW/K3/4uLM8ok1s8lp4aU965zNE4WAAe/kCjVJbXrF0dONJyZbm2FAor4sjWA1lSWwNwGyU2ZSTtU5hqJ3G7HKfXWuGk6lPy00ZTn/yGkmkkeLo+YuCkO0GUDkIGfF8gvNggTKrTjtrxNUD0ebLcQxskWar237LOMhitu8/wa/9zDIwliUqohJrL6/dAeCkkHckuwfzF6g6j4j3qjAxn6suORj3QTOnag1Vp6EZmVWjjd+fB++Pw+5wbN/rzs9MjkbEiptX7CW7ltBe9efBEAjEb/bgL1hJAVF491itW2X38LUF7XkW6sjbkjPX5hei6ZOoudwD2KWjy2vf/UYXgyXiSFsPW3X/i49a6GNBl7zdn8YVH3M+sIZVHJZoIB/Em2s/A5F1Yrzhwr3RJt6mmYuqpx3QsgFtQKt0t1/BHfheV9zjzWATrA03fuBQKDRWJTqGtZ03k1MhN/fr91DhppO3pgjIFR/zk8vYxtPRjb4A09KecVu9WQB5oWd5JznkGrbRnvFeygCEb8WklBxf00ouskj1gY544x16ZgL7p6TwPDe9gUeuKS4eSZs78iDXZM6zGukWaYOXRNARpKfjPGjmKD3oDsCuN22fC2yTUBXRVJJkMLn5Ggtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2183.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(83380400001)(5660300002)(8936002)(4326008)(52536014)(33656002)(186003)(2906002)(7416002)(7696005)(55016002)(9686003)(86362001)(66556008)(316002)(38100700002)(54906003)(85182001)(76116006)(8676002)(6506007)(66946007)(110136005)(71200400001)(66446008)(64756008)(478600001)(26005)(66476007)(122000001)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?ajBYWVpMejJnVHZJazBuaGo3UC9ZWmhNL2s3VjNCd2JpaExQU3hhemhN?=
 =?iso-2022-jp?B?cHR6N0xFRS81RGJhU0VieEswMWNENEpQVUpoQlQzTDZXbkQ1c1h4czUv?=
 =?iso-2022-jp?B?cXV1bHZxZk5FZzNaNWJCUXlMNS9yRi9KS00yY2dhZjJJWlR5a1Nid2Zp?=
 =?iso-2022-jp?B?NE03ZmJPRDdjMWhLdkVaWkZzYkRIUG9vMkFmOVB0cmZPVENFMlI3RUl0?=
 =?iso-2022-jp?B?cmpmb3RKaEF4cTQ5R29KQ0srR2tnSzlnWnIyZTM4TlFoY0lHMG1ZZ1ZJ?=
 =?iso-2022-jp?B?cEFGT3BER3pJZVpGUzRrWXk5eDBKWkpYUW5GOURLVEtTNlIxWXErVDl6?=
 =?iso-2022-jp?B?ZlNMMW9HSXBwRHNmdmgrQ1kreXNzMTJhNmxxejZpMG5oWGdwTjA0cWtn?=
 =?iso-2022-jp?B?ZVlQZUlQM3BqMitObUl6SGVhL2h3R0dQVHdEWTVSYjAvc2xhRkpWY0Nt?=
 =?iso-2022-jp?B?TFBJdzcyUmpCZEdWTjMzY2tSTlhpTlpxVnJ1NWhxYWlRd09QL1JCZWNG?=
 =?iso-2022-jp?B?L0pZWmd1RlZoUzloMUNVc2ZJS2x6QWJ6VlN3UWR0RkM0b1lYK0NPSFl6?=
 =?iso-2022-jp?B?c3RLNGNyUXdUMDRoUFVQNzhYZkVJc3ErV0FkRUlRNnhIMlBhZVZnRGt4?=
 =?iso-2022-jp?B?SU9JWXZ5Rm5PVGdzWUVMZWpVdWFFVlJZZUM1QVB3d3JITDZMeVpGN2hY?=
 =?iso-2022-jp?B?TUUrVHZ0ampGRVdvcUFUbTV3OENhRWVDYlI3RllqV09zSXBHTy9oVlUx?=
 =?iso-2022-jp?B?bEF3RGhqdmkyNHlzVnU3aEFrTWk0cWFSZHNRUWp4ZzUxVk5CSTlMYUxs?=
 =?iso-2022-jp?B?dGpvWWk4YkdyNlBKZTY2NUsxR0FwNmx2a0tsTU1acEtuTjRaVVpoZy9B?=
 =?iso-2022-jp?B?cGNWVUZ5dmdKY1MrTnFqbU9FSFJSTFdSOEdyQWRBWVhkdERUVDhjLzNt?=
 =?iso-2022-jp?B?SVdLMStYYjVYUHo2Z3VkVUNsYjBVbzJHUkN3WGk1N3B0UlF4dWZZZTIw?=
 =?iso-2022-jp?B?VWJCNnRKUlNsakZuR0tvRVlaby9rMWE2eXZLMW8wRDdubmVnanhOK1pM?=
 =?iso-2022-jp?B?U0lXaFFBaXAySk9SVDZ1TG1FVmw2bTFianVHRmhmY1hBVzRoenVrbzl3?=
 =?iso-2022-jp?B?R2lucWVmc1o1Kzc3d0t5SzBKM2pkek15bVRDMlU2UVk2MUk0OXA0ckw5?=
 =?iso-2022-jp?B?dVZHVzNBNSsvV0FpMG5MWWNZZU5BU1luUHpBdVVmSFBFNWdhR1ppendJ?=
 =?iso-2022-jp?B?YXN1MTdKRTRoWDRmVTN2M2t4SXBGd0k3bzR4ZER3TVI1T0laZTdHNHRh?=
 =?iso-2022-jp?B?a3BGSVprWlE3dmprTFpxOTF5dmRBZFlrQVpFR0s3V0tvYVo3RDY4dFlR?=
 =?iso-2022-jp?B?QnBoMzZ6WTBPMUFKejVxYlY2RFh1dTJpcVhjM3AzYzc3Rm9FQkVtb2p5?=
 =?iso-2022-jp?B?SjRTVFhod3h2VkJ0b1pPRmpTajVjT0pwYzI2NVF3VTVZUUpsM080U2lK?=
 =?iso-2022-jp?B?WFBQWjhZQ1JORXhaeHNRWktXa1RVbGJiVGVHVzBTaWUxenF5ekdtR2E0?=
 =?iso-2022-jp?B?RkU3KytDNjhrTVFCYlAvN2JSL3lQN2FaeWxtdTQ4TkltMUNCOS9sTmRW?=
 =?iso-2022-jp?B?bkttb3RiTjBNR29BQmFIZkxIeENKSTJ4eEp4Ly9FYU9BaU1VUUxzMGZn?=
 =?iso-2022-jp?B?VE5qU2tYS25XYjhqc1htQWlFRDJkK0U2TUlPeTIvcTZrd0taTHJDRG1Y?=
 =?iso-2022-jp?B?RHlTQXhLb1lLM0VqY0c1dUtSa2ZUMGhZVW9ENUpqcllndWIrMkV3cHhw?=
 =?iso-2022-jp?B?Vkd2UzlOcDh5Ymh1dkNvcWJkVURtUkx6dDRCaFlFNXRCRXpQeDE2b3Bl?=
 =?iso-2022-jp?B?dHR3b1RoVlh5TlF3YmltNUliL2pFPQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2183.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af12c6ee-e3e2-47a8-2039-08d91c236160
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 06:40:53.1639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g+FwqpSiHpKjAJ6/zUDazr7rrw8daN/hXgL/PWE9CsCE+R6fEhWs3zomB9vmiFE+tOKVo8NC4v+3GGrBIa9RMO0jCP4qIm64plAeVbN2xH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5747
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and Frederic=0A=
=0A=
=0A=
> > Would be superfluous for CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=3Dy=0A=
> > architectures at the very least.=0A=
> > =0A=
> > It also doesn't help any of the other callers, like for example procfs.=
=0A=
> > =0A=
> > Something like the below ought to work and fix all variants I think. Bu=
t=0A=
> > it does make the call significantly more expensive.=0A=
> > =0A=
> > Looking at thread_group_cputime() that already does something like this=
,=0A=
> > but that's also susceptible to a variant of this very same issue; since=
=0A=
> > it doesn't call it unconditionally, nor on all tasks, so if current=0A=
> > isn't part of the threadgroup and/or another task is on a nohz_full cpu=
,=0A=
> > things will go wobbly again.=0A=
> > =0A=
> > There's a note about syscall performance there, so clearly someone seem=
s=0A=
> > to care about that aspect of things, but it does suck for nohz_full.=0A=
> > =0A=
> > Frederic, didn't we have remote ticks that should help with this stuff?=
=0A=
> > =0A=
> > And mostly I think the trade-off here is that if you run on nohz_full,=
=0A=
> > you're not expected to go do syscalls anyway (because they're sodding=
=0A=
> > expensive) and hence the accuracy of these sort of things is mostly=0A=
> > irrelevant.=0A=
> > =0A=
> > So it might be the use-case is just fundamentally bonkers and we=0A=
> > shouldn't really bother fixing this.=0A=
> > =0A=
> > Anyway?=0A=
> =0A=
> Typing be hard... that should 'obviously' be reading: Anyone?=0A=
=0A=
=0A=
I understand that there is a trade-off between performance and accuracy=0A=
and that this issue may have already been discussed.=0A=
However, as Peter mentions, the process of updating sum_exec_runtime=0A=
just before retrieving information is already implemented in=0A=
thread_group_cputime() in the root of RUSAGE_SELF etc. So, I think=0A=
RUSAGE_THREAD should follow suit and implement the same process.=0A=
=0A=
Thanks.=0A=
Hitomi Hasegawa=
