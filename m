Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED933306D09
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 06:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhA1Fk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 00:40:26 -0500
Received: from esa12.fujitsucc.c3s2.iphmx.com ([216.71.156.125]:18260 "EHLO
        esa12.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229488AbhA1FkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 00:40:19 -0500
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jan 2021 00:40:17 EST
IronPort-SDR: WxBrTKFVE025ni/FEBNjn03mgzQc84RGWgM5wMDH+XuKx22EPnc+1/wwwjY7a52ndat/4fOoTb
 llAA9WvnJwFBsF656J4TEK1kwKg/xM/fwydKZERuzT8K1ciEIChbWNNQjiNgTm0vQWdoZBshfX
 B34y9j7XQos9H/RejKIey0emLzg6xVg/EtCLnhVa5RD8TtZcwcqYxpvXYCZ/gnMi77hiSop+j+
 QNAgVAWAe6A8htZyn6s3Dt61A7qCOJZYYkOZdVxdqhMbIIqcGF3/oNjOxUusZ9L/g1KqLeRzo3
 GG0=
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="25206504"
X-IronPort-AV: E=Sophos;i="5.79,381,1602514800"; 
   d="scan'208";a="25206504"
Received: from mail-os2jpn01lp2050.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.50])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 14:30:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmOoE1VDgB0uwlkCPe+3I10tbJNVPFNAr/dhxehdX8+FJlNRJQHYiVq5D4UNF0nbLz2Vph+42qei2hcO7qUUPxtm5FdxhxUzlKCZhF8O8D7wt4YRk57b/s4j9Q1/f3HDfbO/TjmcTg85mLUGyvVwMEjw7WOgP2G12J1BYfK7D0V5s71fQstOj+KU2N0UMvC+iktfM2qcfAXBvC//yZGbivuaKHV5auMCGdlNM9uW2tcFX/3OWFa6YMZOQYvo7KBz0qXI4rIlo2wXzDY9IGSxJZ3waEu4AKfFdHb2yB2jtahglOgR/Ap716ifbXxZnxwzEEuEFTrqFcdgVjUnepjVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPg+73WiohCy7kxE3yBj6dqqtfzQUJv5NLhpPAMNthc=;
 b=ROdDfCcZQQ6mjxQVI/ftvQLJ7TpF169L2ooBsxTsac2+kV7Y5WU+sMM66acT5knRqDA4P6tjNu4IeAhh3Pwco3KZ82obW8Hsj/31u7Sys8WR2/SiEn5fsQi043cfVSu4NrgZrB2c6RreLnOOeq9aPfExHUkdm6WY1bVnCSmK0pbU5NZmUsH4uyzasbx4Zr6avBqJUhUqe4JoBS0J7ISA6OD3KnKE+QnjgWgcyM+Ls8jGwzDCbBTzP9Qot1qr5LZeCkr5U7Ms8zw36Wy0dqZLoazfUSYu2oBkbOE1M4issUC5XvetkO3T0uy65h9wghRPde8j/SgkYKYqfU/Uo/GsWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPg+73WiohCy7kxE3yBj6dqqtfzQUJv5NLhpPAMNthc=;
 b=cm241Kqdje+uxHqIBvrZWya9XlqROvkJ58BcBRhG7/wANmultko2ba6H0Gxb/TBL/WN0dW+ewmnzXfcWWETXXs/4VodcxywUFyeMBpinEGnNFsy6Tb8k4gTn6RIsb45IvvEvUHF1IH698Vi2/v16KirL14Sk9YFrtWd5qPoJ5eo=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSAPR01MB4353.jpnprd01.prod.outlook.com (2603:1096:604:37::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Thu, 28 Jan
 2021 05:30:14 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd%7]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 05:30:14 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     'John Garry' <john.garry@huawei.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>
Subject: RE: [PATCH 2/4] perf vendor events arm64: Add common and uarch event
 JSON
Thread-Topic: [PATCH 2/4] perf vendor events arm64: Add common and uarch event
 JSON
Thread-Index: AQHW8xFXQOnqHIAd/Eye6spn+Ws0W6o8RHCg
Date:   Thu, 28 Jan 2021 05:30:14 +0000
Message-ID: <OSBPR01MB460053B9A7E7A1710D73D21EF7BA9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <1611575600-2440-1-git-send-email-john.garry@huawei.com>
 <1611575600-2440-3-git-send-email-john.garry@huawei.com>
In-Reply-To: <1611575600-2440-3-git-send-email-john.garry@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckermailid: be0edb01fdcd43649c8333d9d6c31bda
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [210.162.30.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b3e8af6-e9df-4af0-844c-08d8c34dca3d
x-ms-traffictypediagnostic: OSAPR01MB4353:
x-microsoft-antispam-prvs: <OSAPR01MB43536EC85B7381584383D1BEF7BA9@OSAPR01MB4353.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xZuC2AvVOpqQ2Aji9xpdm/vThvI4oq2/ZJ/ByUswIVdsMiQE83+K5l5CpK2TLUQEmzIc/3vDZgrxzEpPZV5irN0fhk6r4FwjbTn9bMWNNs3+foyHQei0SzQzZ9D4tzKE33d5ZYRy64irTfcRk+oq+dGFGhsVhLZen1qshX9oysapwHKh+f4PHHDk8+L7T6zKm4Go/c2WMdQIdWbzGWY0AHSkEi67FlkhxrktghvrUA8fWWXqahdYMQ+FGWCzeoxeIlVuUEF28s4yy9D887ymIpA/ogJgkL+wQb49zdHn9sTNB4loUv6G11rQZUi9jSqvc3JLfYzRxoKaQ3Bw0KQwAaGsLB/jsxRCGwTrixcCCIFgu1OXRXRhnLWSbQhgm/0GiydETxVVwHykj1WnzmVefsBC/ybLqTWcE671kXKMo9W/qwRuqfMtvVhc3qmM+bJgM8Z8kTJUn7TkJMn5HFxMHjlv1QHFa9HOY3zLljug0iDNT3DFbTfdDVuMEtwf5wYUSMHd5f6kuHHUFUOVrv1BC7ESzypXPKQsf58yC37sf0UfSPKYXSVwfRIClMLTVgVUJuRx8YSNW4HuOpJCjbZePqnrHBQiVLTzeHcBfVMpqbs8TrB7T04W8qSuZAXt+zst3RPIxhiRpcJXx6vfjtdr9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(85182001)(54906003)(53546011)(316002)(6506007)(26005)(30864003)(6916009)(7696005)(186003)(8936002)(478600001)(5660300002)(52536014)(9686003)(8676002)(966005)(66476007)(71200400001)(7416002)(66556008)(83380400001)(64756008)(4326008)(66946007)(66446008)(86362001)(33656002)(2906002)(76116006)(55016002)(777600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?SGM5Vy8vaXE2WFU2bFZ0eDZRVDJkcVBPMG9Pb0l5dGlldG5GQTdpTmpw?=
 =?iso-2022-jp?B?ZEI4UitpSWx0eGpHbHZJUmc5YUVrb0hlYW9vS0tPK2JsQUM4cDV1MTIx?=
 =?iso-2022-jp?B?U2lLZzZIZVNKcU9iZzVibnRXQVJJZlVBYTFFMGxueWpyNTNTS3RLNk16?=
 =?iso-2022-jp?B?Vyt3Wm5rRlcveWtvWVhKcy9YbVNwcUtyanRQa1hwT0xCc3dIVG5MZE9u?=
 =?iso-2022-jp?B?cjZRUHgrcHFpaFZ6VGFmNnFyQVBMNlZVZTNIdU1GbzFuUFhTeXVqckg4?=
 =?iso-2022-jp?B?WE1ZL09aMCtsSGdYSndteUQ0YjZpTmxubG9QMzJkakNrQzd5RmRwVVpY?=
 =?iso-2022-jp?B?WmoyeWJsSnZFR2VmYlhIOFZ3eGdBY3ZNcWtjSlB1TXUwQmpBWlQ3MmxW?=
 =?iso-2022-jp?B?TnVEeXo1QklJV2RZd1FUdVljMGRBSGNKT3dQWmEydHk4a3lUK0xPb3FS?=
 =?iso-2022-jp?B?eHdsYjlycjZFZitta0E0UnNjb3luNC8vQUtxWlVBMDJaaFhnR3RGa0lE?=
 =?iso-2022-jp?B?bDlJNERrR3NtcmtESWNDY1RsYS9DN2FHRlIzbjBaSG5Eb2FkWkxwTEM3?=
 =?iso-2022-jp?B?ZFo3Uzl2WGpTQkJxYmVIemhWenFtdXkvSUxEWEtIV0hIODZVZ2lIYmgv?=
 =?iso-2022-jp?B?U1pTTWcrSHZxZHZNMmd4M1lEM1pVOGtuenFmVlpvSXNpZ3g2cGpaMy9z?=
 =?iso-2022-jp?B?MTZGYlZmLzY3WkYzdzNEVVU5R2I2dUFJVk1mVEw0TWVBUHlYSEFuN1hW?=
 =?iso-2022-jp?B?STRoRmttOU1CY0R6NDJ3Y2pFQ3hlT1ptc1V2TTY3endUcVdTR1hNZ3Rr?=
 =?iso-2022-jp?B?bWdqdXJlaXpoZjc3b0xkNWhqbTJZSTh2QnMydkEvOFV3akljL1Naekpx?=
 =?iso-2022-jp?B?ZGlaU3VzWkpXNkxlRW5KZWdKS21kdUk4WUZEOEZ3RXFIL01DNVRPYkpP?=
 =?iso-2022-jp?B?RHc1RWV6dTJ5OWlLZ1JoSm9uYkxKZW9qcWZieDJSL0lqenFuVVVyN1ZP?=
 =?iso-2022-jp?B?ZU44SExzUWw4UmtmWHBhSzdGZzZ3K1l1VHUwemlFL0hPYmVoTk9rUzVY?=
 =?iso-2022-jp?B?MU5ZOU9xdWlUdW15dDBuc0tKeGZzNTNSb0dOOHpZaW42UlNuTnluVEpu?=
 =?iso-2022-jp?B?T0dCM2JvTFVyRExUTm44WTlCUXBvV0tubVd6VERIMzR0a3hBOEgvN2hU?=
 =?iso-2022-jp?B?ajNOcGxPRzdud2xsVHFQNituM3VEOWZuVytVTWlHcXEyYzFKUUNoeG43?=
 =?iso-2022-jp?B?a05mYTBYZHNYVkpqMmpuVGVuZXVQS2RPWVF6TGdrU3Q4eHFWTjhtN3Rs?=
 =?iso-2022-jp?B?OGMzUjJKbzRGQlU1MWtteUdHL2NKb2UwN3E3ME4wY0dhcEN1UnluRkRt?=
 =?iso-2022-jp?B?S0ZYYmM3cHZXWVdPRzh5MEZGdmplRlllb0h1d28wNGpqR0ZjelBBUnJW?=
 =?iso-2022-jp?B?YU5Xb212QjNUSWpvdFVia2V5MVg5azV3emJYdEM5RWlxaWkxaDdVQlhQ?=
 =?iso-2022-jp?B?R054b0J6c0J1ZUpCMXBTb0xpL0FXa1hGY3FPSDZHQmlYVzVSUEU=?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3e8af6-e9df-4af0-844c-08d8c34dca3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 05:30:14.4783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zf3URvQkWroqW274foNnS4/lLfOOQ38jO4klLoqlQkPcZC8fa91r/0MKOt7vXR2PBSxE7b2v/C6ydyO0krMzcVtAjcsA2n+sH0yrFqqGSF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4353
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,john

I would like to make a comment because there is excess or deficiency in com=
ma.
There are no differences in pmu-events.c.

> +    {
> +        "PublicDescription": "Attributable Bus access",
> +        "EventCode": "0x19",
> +        "EventName": "BUS_ACCESS",
> +        "BriefDescription": "Attributable Bus access",
> +    },
Comma is not required at the end of BriefDescription.

> +    {
> +        "PublicDescription": "Bus cycle"
> +        "EventCode": "0x1D",
> +        "EventName": "BUS_CYCLES",
> +        "BriefDescription": "Bus cycle"
> +    },
Missing comma at end of PublicDescription.

> +    {
> +        "PublicDescription": "Attributable Last level cache memory read"
> +        "EventCode": "0x36",
> +        "EventName": "LL_CACHE_RD",
> +        "BriefDescription": "Attributable Last level cache memory read"
> +    },
> +    {
> +        "PublicDescription": "Last level cache miss, read"
> +        "EventCode": "0x37",
> +        "EventName": "LL_CACHE_MISS_RD",
> +        "BriefDescription": "Last level cache miss, read"
> +    },
Missing comma at end of PublicDescription.

> +    },
> +]
Commas are not required.

Best Regards
Shunsuke

> -----Original Message-----
> From: John Garry <john.garry@huawei.com>
> Sent: Monday, January 25, 2021 8:53 PM
> To: peterz@infradead.org; mingo@redhat.com; acme@kernel.org;
> mark.rutland@arm.com; alexander.shishkin@linux.intel.com; jolsa@redhat.co=
m;
> namhyung@kernel.org; irogers@google.com; kjain@linux.ibm.com
> Cc: linux-kernel@vger.kernel.org; linuxarm@openeuler.org;
> james.clark@arm.com; Nakamura, Shunsuke/=1B$BCfB<=1B(B =1B$B=3DS2p=1B(B
> <nakamura.shun@fujitsu.com>; John Garry <john.garry@huawei.com>
> Subject: [PATCH 2/4] perf vendor events arm64: Add common and uarch event
> JSON
>=20
> Add a common and microarch JSON, which can be referenced from CPU JSONs.
>=20
> For now, brief and public description are as event brief event descriptio=
n from the
> ARMv8 ARM [0], D7-11.
>=20
> The list of events is not complete, as not all events will be referenced =
yet.
>=20
> Reference document is at the following:
> [0]
> https://documentation-service.arm.com/static/5fa3bd1eb209f547eebd4141?tok
> en=3D
>=20
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  .../arm64/armv8-common-and-microarch.json     | 248
> ++++++++++++++++++
>  1 file changed, 248 insertions(+)
>  create mode 100644
> tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json
>=20
> diff --git
> a/tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json
> b/tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json
> new file mode 100644
> index 000000000000..430a023ccf6a
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json
> @@ -0,0 +1,248 @@
> +[
> +    {
> +        "PublicDescription": "Instruction architecturally executed, Cond=
ition
> code check pass, software increment",
> +        "EventCode": "0x00",
> +        "EventName": "SW_INCR",
> +        "BriefDescription": "Instruction architecturally executed, Condi=
tion
> code check pass, software increment"
> +    },
> +    {
> +        "PublicDescription": "Level 1 instruction cache refill",
> +        "EventCode": "0x01",
> +        "EventName": "L1I_CACHE_REFILL",
> +        "BriefDescription": "Level 1 instruction cache refill"
> +    },
> +    {
> +        "PublicDescription": "Attributable Level 1 instruction TLB refil=
l",
> +        "EventCode": "0x02",
> +        "EventName": "L1I_TLB_REFILL",
> +        "BriefDescription": "Attributable Level 1 instruction TLB refill=
"
> +    },
> +    {
> +        "PublicDescription": "Level 1 data cache refill",
> +        "EventCode": "0x03",
> +        "EventName": "L1D_CACHE_REFILL",
> +        "BriefDescription": "Level 1 data cache refill"
> +    },
> +    {
> +        "PublicDescription": "Level 1 data cache access",
> +        "EventCode": "0x04",
> +        "EventName": "L1D_CACHE",
> +        "BriefDescription": "Level 1 data cache access"
> +    },
> +    {
> +        "PublicDescription": "Attributable Level 1 data TLB refill",
> +        "EventCode": "0x05",
> +        "EventName": "L1D_TLB_REFILL",
> +        "BriefDescription": "Attributable Level 1 data TLB refill"
> +    },
> +    {
> +        "PublicDescription": "Instruction architecturally executed",
> +        "EventCode": "0x08",
> +        "EventName": "INST_RETIRED",
> +        "BriefDescription": "Instruction architecturally executed"
> +    },
> +    {
> +        "PublicDescription": "Exception taken",
> +        "EventCode": "0x09",
> +        "EventName": "EXC_TAKEN",
> +        "BriefDescription": "Exception taken"
> +    },
> +    {
> +        "PublicDescription": "Instruction architecturally executed, cond=
ition
> check pass, exception return",
> +        "EventCode": "0x0a",
> +        "EventName": "EXC_RETURN",
> +        "BriefDescription": "Instruction architecturally executed, condi=
tion
> check pass, exception return"
> +    },
> +    {
> +        "PublicDescription": "Instruction architecturally executed, cond=
ition
> code check pass, write to CONTEXTIDR",
> +        "EventCode": "0x0b",
> +        "EventName": "CID_WRITE_RETIRED",
> +        "BriefDescription": "Instruction architecturally executed, condi=
tion code
> check pass, write to CONTEXTIDR"
> +    },
> +    {
> +        "PublicDescription": "Mispredicted or not predicted branch
> speculatively executed",
> +        "EventCode": "0x10",
> +        "EventName": "BR_MIS_PRED",
> +        "BriefDescription": "Mispredicted or not predicted branch specul=
atively
> executed"
> +    },
> +    {
> +        "PublicDescription": "Cycle",
> +        "EventCode": "0x11",
> +        "EventName": "CPU_CYCLES",
> +        "BriefDescription": "Cycle"
> +    },
> +    {
> +        "PublicDescription": "Predictable branch speculatively executed"=
,
> +        "EventCode": "0x12",
> +        "EventName": "BR_PRED",
> +        "BriefDescription": "Predictable branch speculatively executed"
> +    },
> +    {
> +        "PublicDescription": "Data memory access",
> +        "EventCode": "0x13",
> +        "EventName": "MEM_ACCESS",
> +        "BriefDescription": "Data memory access"
> +    },
> +    {
> +        "PublicDescription": "Attributable Level 1 instruction cache acc=
ess",
> +        "EventCode": "0x14",
> +        "EventName": "L1I_CACHE",
> +        "BriefDescription": "Attributable Level 1 instruction cache acce=
ss"
> +    },
> +    {
> +        "PublicDescription": "Attributable Level 1 data cache write-back=
",
> +        "EventCode": "0x15",
> +        "EventName": "L1D_CACHE_WB",
> +        "BriefDescription": "Attributable Level 1 data cache write-back"
> +    },
> +    {
> +        "PublicDescription": "Level 2 data cache access",
> +        "EventCode": "0x16",
> +        "EventName": "L2D_CACHE",
> +        "BriefDescription": "Level 2 data cache access"
> +    },
> +    {
> +        "PublicDescription": "Level 2 data refill",
> +        "EventCode": "0x17",
> +        "EventName": "L2D_CACHE_REFILL",
> +        "BriefDescription": "Level 2 data refill"
> +    },
> +    {
> +        "PublicDescription": "Attributable Level 2 data cache write-back=
",
> +        "EventCode": "0x18",
> +        "EventName": "L2D_CACHE_WB",
> +        "BriefDescription": "Attributable Level 2 data cache write-back"
> +    },
> +    {
> +        "PublicDescription": "Attributable Bus access",
> +        "EventCode": "0x19",
> +        "EventName": "BUS_ACCESS",
> +        "BriefDescription": "Attributable Bus access",
> +    },
> +    {
> +        "PublicDescription": "Local memory error",
> +        "EventCode": "0x1a",
> +        "EventName": "MEMORY_ERROR",
> +        "BriefDescription": "Local memory error"
> +    },
> +    {
> +        "PublicDescription": "Operation speculatively executed",
> +        "EventCode": "0x1b",
> +        "EventName": "INST_SPEC",
> +        "BriefDescription": "Operation speculatively executed"
> +    },
> +    {
> +        "PublicDescription": "Instruction architecturally executed, Cond=
ition
> code check pass, write to TTBR",
> +        "EventCode": "0x1c",
> +        "EventName": "TTBR_WRITE_RETIRED",
> +        "BriefDescription": "Instruction architecturally executed, Condi=
tion
> code check pass, write to TTBR"
> +    },
> +    {
> +        "PublicDescription": "Bus cycle"
> +        "EventCode": "0x1D",
> +        "EventName": "BUS_CYCLES",
> +        "BriefDescription": "Bus cycle"
> +    },
> +    {
> +        "PublicDescription": "Attributable Level 2 data cache allocation=
 without
> refill",
> +        "EventCode": "0x20",
> +        "EventName": "L2D_CACHE_ALLOCATE",
> +        "BriefDescription": "Attributable Level 2 data cache allocation =
without
> refill"
> +    },
> +    {
> +        "PublicDescription": "Instruction architecturally executed, bran=
ch",
> +        "EventCode": "0x21",
> +        "EventName": "BR_RETIRED",
> +        "BriefDescription": "Instruction architecturally executed, branc=
h"
> +    },
> +    {
> +        "PublicDescription": "Instruction architecturally executed, misp=
redicted
> branch",
> +        "EventCode": "0x22",
> +        "EventName": "BR_MIS_PRED_RETIRED",
> +        "BriefDescription": "Instruction architecturally executed, mispr=
edicted
> branch"
> +    },
> +    {
> +        "PublicDescription": "No operation issued because of the fronten=
d",
> +        "EventCode": "0x23",
> +        "EventName": "STALL_FRONTEND",
> +        "BriefDescription": "No operation issued because of the frontend=
"
> +    },
> +    {
> +        "PublicDescription": "No operation issued due to the backend",
> +        "EventCode": "0x24",
> +        "EventName": "STALL_BACKEND",
> +        "BriefDescription": "No operation issued due to the backend"
> +    },
> +    {
> +        "PublicDescription": "Attributable Level 1 data or unified TLB a=
ccess",
> +        "EventCode": "0x25",
> +        "EventName": "L1D_TLB",
> +        "BriefDescription": "Attributable Level 1 data or unified TLB ac=
cess"
> +    },
> +    {
> +        "PublicDescription": "Attributable Level 1 instruction TLB acces=
s",
> +        "EventCode": "0x26",
> +        "EventName": "L1I_TLB",
> +        "BriefDescription": "Attributable Level 1 instruction TLB access=
"
> +    },
> +    {
> +        "PublicDescription": "Attributable Level 3 data cache allocation=
 without
> refill",
> +        "EventCode": "0x29",
> +        "EventName": "L3D_CACHE_ALLOCATE",
> +        "BriefDescription": "Attributable Level 3 data cache allocation =
without
> refill"
> +    },
> +    {
> +        "PublicDescription": "Attributable Level 3 data cache refill",
> +        "EventCode": "0x2A",
> +        "EventName": "L3D_CACHE_REFILL",
> +        "BriefDescription": "Attributable Level 3 data cache refill"
> +    },
> +    {
> +        "PublicDescription": "Attributable Level 3 data cache access",
> +        "EventCode": "0x2B",
> +        "EventName": "L3D_CACHE",
> +        "BriefDescription": "Attributable Level 3 data cache access"
> +    },
> +    {
> +        "PublicDescription": "Attributable Level 2 data TLB refill",
> +        "EventCode": "0x2D",
> +        "EventName": "L2D_TLB_REFILL",
> +        "BriefDescription": "Attributable Level 2 data TLB refill"
> +    },
> +    {
> +        "PublicDescription": "Attributable Level 2 data or unified TLB a=
ccess",
> +        "EventCode": "0x2F",
> +        "EventName": "L2D_TLB",
> +        "BriefDescription": "Attributable Level 2 data or unified TLB ac=
cess"
> +    },
> +    {
> +        "PublicDescription": "Access to another socket in a multi-socket
> system",
> +        "EventCode": "0x31",
> +        "EventName": "REMOTE_ACCESS",
> +        "BriefDescription": "Access to another socket in a multi-socket =
system"
> +    },
> +    {
> +        "PublicDescription": "Access to data TLB causes a translation ta=
ble
> walk",
> +        "EventCode": "0x34",
> +        "EventName": "DTLB_WALK",
> +        "BriefDescription": "Access to data TLB causes a translation tab=
le
> walk"
> +    },
> +    {
> +        "PublicDescription": "Access to instruction TLB that causes a
> translation table walk",
> +        "EventCode": "0x35",
> +        "EventName": "ITLB_WALK",
> +        "BriefDescription": "Access to instruction TLB that causes a tra=
nslation
> table walk"
> +    },
> +    {
> +        "PublicDescription": "Attributable Last level cache memory read"
> +        "EventCode": "0x36",
> +        "EventName": "LL_CACHE_RD",
> +        "BriefDescription": "Attributable Last level cache memory read"
> +    },
> +    {
> +        "PublicDescription": "Last level cache miss, read"
> +        "EventCode": "0x37",
> +        "EventName": "LL_CACHE_MISS_RD",
> +        "BriefDescription": "Last level cache miss, read"
> +    },
> +]
> --
> 2.26.2

