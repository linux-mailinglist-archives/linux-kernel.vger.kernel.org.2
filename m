Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A021E33C26C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhCOQqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:46:31 -0400
Received: from alln-iport-3.cisco.com ([173.37.142.90]:56681 "EHLO
        alln-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbhCOQp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=7557; q=dns/txt; s=iport;
  t=1615826758; x=1617036358;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y9+dWOlbIiYQ8qz0l1rsp+TRLZnI1Z88YMvPzspaBXA=;
  b=M9sJzMpDY7ONIHbPd5dT0lirjbZODEowXcAp2x+5XnMat0Il7evmzD+Q
   tx9qiovgt2CZ1eeL94/KW4WLnE8ue+l0rVajHbKdgPSnr7MO9RRZmLnql
   QVqWwEknzEtqcEqLZY14TkXRj3FUWIPYbKJeYCDjjuOazgATcbz6DPV1A
   I=;
X-IPAS-Result: =?us-ascii?q?A0CmCABJjk9g/5ldJa1aHQEBAQEJARIBBQUBQIFPgVMpK?=
 =?us-ascii?q?Ad2WjYxCod/A4U5iEIDmSuCUwNUCwEBAQ0BASgKAgQBAYETAYJ1RAKBdwIlO?=
 =?us-ascii?q?BMCAwEBAQMCAwEBAQEFAQEBAgEGBHGFYQ2GRAEBAQECAScTBgEBNwEECwIBC?=
 =?us-ascii?q?A4DBAEBAR4QMh0IAgQOBQiCHUyCVQMOIQEOohMCih51gQEzgwQBAQaBMwEDA?=
 =?us-ascii?q?g5BgxwYghQJgTmCdopNJhyBSkKBEUOCWD6CYAECARaBRwIwgxmCK4JEgQITA?=
 =?us-ascii?q?RMQBgIgMEsFgRmTaKZNCiGCYYlKkxaDPoE4iSSVe6BEklqEKgICAgIEBQIOA?=
 =?us-ascii?q?QEGgWsjgVdwFYMkCUcXAg2OH4NvhRSBXYNocwI2AgYKAQEDCXyMXgGBDgEB?=
IronPort-PHdr: A9a23:aZUi8h/Rup2iEP9uWNfoyV9lXQAupqn0MwgJ65Eul7NJdOG58o//O
 FDEjd13gVPJVJmd4PVB2KLasKHlDGoH55vJ8HUPa4dFWBJNj8IK1xchD8iIBQyeTrbqYiU2E
 d4EWApj+He2YlJYFMb3exvZpXjhpTIXEw/0YAxyIOm9E4XOjsOxgua1/ZCbYwhBiDenJ71oK
 xDjpgTKvc5Qioxnec4M
IronPort-HdrOrdr: A9a23:B/6KAqPibbIsH8BcT7Dx55DYdL4zR+YMi2QD/3taDTRIb82VkN
 2vlvwH1RnyzA0cQm0khMroAsi9aFvm39pQ7ZMKNbmvGDPntmyhMZ144eLZrQHIMxbVstRQ3a
 IIScdDIfX7B1RikILe6A63D94vzLC8gd+VrM31pk0dKj1CQadm8gt/F0K/Gkp5WAFJCfMCZe
 Shz+BAoCetfmlSU9+yAWMLU/OGi9rAkp/nZhBuPW9n1CClizS05LnmVyWJxxt2aUIA/Z4O00
 jg1zb46KKqru2hxnbnt1P7wpxKlLLau6B+LeOWjMx9EESIti+JY8BbV6SGrHQJpoiUmSoXuf
 3thztlAMhp8XPWeQiO0FvQ8i3tyiwn5XOn6XLwuwqYneXDSDg3C9VMiOtiG3OzgSdNzbIMsp
 5j5G6Xu4FaChnNhk3GlqX1fit3nUm5q2dKq590s1VjUJATYLIUjYsT8FI9KuZ5IAvG6ZsqGO
 QrMcfE5Pw+SyLiU1nluABUsbiRd0V2Oi3DblkJu8ST3TQTtmt+1VEkyMsWmWpF3I4hSrFfjt
 60cZhApfVrdIs7fKh9DOAOTY+cEWrWWy/BN2qUPBDOCLwHAXTQsJT6iY9Fpt2CSdgt9t8fiZ
 7BWFRXuSoZYET1E/CD25VN71TrTHiiWy/ujuVT/YJwtLG5ZLeDC1zHdHke1++b59kPCMzSXP
 i+fLhMBeX4EGfoEYFVmwLkXZ1fLmQfTd0Vtt43V0nmmLONFqTa8sjgNNrDLrvkFjgpHknlBG
 EYYTT1LMJcqkCnM0WIxiT5ajfIQAjS7JhwGK/V86w4044WLLBBtQATlBC87sGPIjtSr7wucC
 JFUerau5L+gVPz0XfD7m1vNBYYJF1S+q/cX3RDohJPNVj1f7YFs9CWYntTw3ODOx96Q6rtYU
 pijmUy3ZjyA42bxCgkBd7iGHmdlWEvqHWDSIpZhreO/t7/epQzDo8vXat4EQmjLW0spS9a7E
 N4LCMUTE7WET3jzZi/hJsPHefFap1XmwGwO/NZrnrZqGSRrcwiXWEgQjarSMKb6DxeHAZ8tx
 lUyes/iKDFsSuzIWE/6d5IQWFkWSCyOvZ6KyirIK9TgavmfQlsS3ziv03rtzgDPkzw90sTgW
 T9KzazYv+jOCsGhlloloD37VhzamKRO2V3Z3wSi/wgKU32/lBuzOSMeq2/l1G0V2JH6OQcPD
 bZCAFifz9Gz8yr1RKThTaJHWgnwJJrJeDGELE/adjoqwCQAZzNmqccE/BO+pF5cNjor+8QSO
 qaPxSYNTXiFooSqkGoj2dgPCl/s38/l/z0nBXj8WijxXY6aMCia2hOVvUeI9uG6XLjSOvN2J
 Jljcgtte/1NmnqcNaJxeXWaDFEQymj61KeXqUtqZpOu7g1u6Y2F57HUSHQ3HUCxQ4gNq7P5T
 UjabU+5KqENp5kfsQUdS4c9l01lM6XJE9utgDtGOcxcVwkknezBaLE35PY7b40RkGRrgr5Pl
 eStzdQ+PrIRCOP378XAaBYGxUfVGEsrHB5uO+SfYzZDwunM/xZ9F2hK3mnbftTTrOGFbh4lG
 c03/iY2+uMMyz21wDbsWElfuZA82O7TdizBwzJE+hS6NC+MUmNhKzv4MPbtkaCdRKrL0ADwY
 tCfggMa84GjD8ohog+yDKzRaz6uVhNqSoW3Rh30lr2npG762LaF1xcOQLXgp9KTSBeW0L4+P
 jt4KydzjDh+zBL1pnICVdIctxPE9YWSJLrLy0GE7lmgJe4u6w1gipCZx8yD2kzzDDlttkWr4
 uE5A==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.81,251,1610409600"; 
   d="scan'208";a="662585403"
Received: from rcdn-core-2.cisco.com ([173.37.93.153])
  by alln-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 15 Mar 2021 16:45:57 +0000
Received: from mail.cisco.com (xbe-rcd-005.cisco.com [173.37.102.20])
        by rcdn-core-2.cisco.com (8.15.2/8.15.2) with ESMTPS id 12FGjvpo017074
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 15 Mar 2021 16:45:57 GMT
Received: from xfe-rcd-001.cisco.com (173.37.227.249) by xbe-rcd-005.cisco.com
 (173.37.102.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; Mon, 15 Mar 2021
 11:45:57 -0500
Received: from xhs-rtp-002.cisco.com (64.101.210.229) by xfe-rcd-001.cisco.com
 (173.37.227.249) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; Mon, 15 Mar 2021
 11:45:57 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (64.101.32.56) by
 xhs-rtp-002.cisco.com (64.101.210.229) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 15 Mar 2021 12:45:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzsCebAm4kD73+Nlm/99Vl2bnVuGtGRBKqsdL1BftVFyC1JZKkMLPqOHu4Be+wJ+K6csWM5i2E/wBlY7yP56vhzBOmadtCO2aofjbGN1KKzBdf6lWJkx0pFuPTHwGeIoZJPlifZSpv0k1M+ttkZIMg4mUxP7gd2clFiBZ+b2SZT4FVQP8qZxetPw4bOGeGNDXejeb16bbMk/YBtmMG9TJeZX2daWV8MM6/be8Gx4WHzy3kyqLnPPQh/um2CE/GamzrfSQG7WTv6c8XhGux+RFKKLBhdiMjBghNlh9VeXxKRjUB79fxeSkRJ83U5AjVgyhrbYnFZB5ygDslZc476QYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnYMUqvG61NwYtro2mv2ALMI6A1I93FKB73CY/lwaiQ=;
 b=JCHWRTLYiu5yddPmKi3N9i6kbrmsboeWs9ejPRsVmObLlHSJEGztulMIZyCyygkGzgUm1qwX+Ut0t9n/Fq3NYTvv3sBpnmRlfAUZ8/Ul24Bc9/yhWlY67JtO+nm4BQndjMA7Qn+3hbuQb1ITIA9c95bzH9M8+/nruPXPkcvb7jdZPJ5kPh7RZN1Fe5HUHX1D+cCxiiFexOOttJ3z2jzhA99Avk+y6xej92lIBGVrf2EzTrPeavsYTGb7TVNdl7TMSuUflISv8QRbjbEUjxXVc5BMKm1n3uAQ+BMzpncXfCrsnsy69Xfc+31nla4EbE9MGGn7WaKyS8YXL+X1QShR3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnYMUqvG61NwYtro2mv2ALMI6A1I93FKB73CY/lwaiQ=;
 b=lG7HxETXrCMaqJsVUBzxeCL0ERFaAFL5eG/FFjvl0Yf6m2JOxpzLYfRWqbMdxly8FanXEJTPdf9o6qjFbQypNK7g1rmA6uS/+NWtBCKmZilsPBNoAdI0ilD+KTtRjqy4Pjdx8RUMhvvNwpAQqiU4D5wwu71yGXqgL1OumT33Y/8=
Received: from BY5PR11MB4024.namprd11.prod.outlook.com (2603:10b6:a03:192::24)
 by SJ0PR11MB5118.namprd11.prod.outlook.com (2603:10b6:a03:2dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 16:45:56 +0000
Received: from BY5PR11MB4024.namprd11.prod.outlook.com
 ([fe80::6505:b3:4118:8336]) by BY5PR11MB4024.namprd11.prod.outlook.com
 ([fe80::6505:b3:4118:8336%4]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 16:45:56 +0000
From:   "Denys Zagorui -X (dzagorui - GLOBALLOGIC INC at Cisco)" 
        <dzagorui@cisco.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf: build reproducibility improvements
Thread-Topic: [PATCH] perf: build reproducibility improvements
Thread-Index: AQHXGZbN5BjQXZc5V0KXT3VfWmG/vaqFOFN+
Date:   Mon, 15 Mar 2021 16:45:55 +0000
Message-ID: <BY5PR11MB40246F1699546B84817D826AD96C9@BY5PR11MB4024.namprd11.prod.outlook.com>
References: <20210312151700.79714-1-dzagorui@cisco.com>,<YE9TAY05BtXbuHxq@krava>
In-Reply-To: <YE9TAY05BtXbuHxq@krava>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [173.38.209.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33ff3173-8316-4320-39fe-08d8e7d1cdd0
x-ms-traffictypediagnostic: SJ0PR11MB5118:
x-microsoft-antispam-prvs: <SJ0PR11MB5118410B284FD6C289519848D96C9@SJ0PR11MB5118.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v7iHtNakqMLEXw5LHk1DUKyAI9tIb9V15ft+DOh5/w80lwzVr7Cj/g5lfIUsP/08ABWk+k7+eA2RQ5puDW4tZy8CoDn/gHFE8DHbbzrgb7KRtDUrgUIh74UW27gRWmDjEi5BVqx4Cmg9v99KD36cw8U1K6TkDTD6uTo08eO0vix7HX/iYrzpPDxy8Qn9OOx2l4paaP7bxN068W/s+ghLm0qwypev5b5U8YDBBOTg+2D2Ly4DaH78FkqwDGXfCVmgq1ucF6uXSnQPgRJ9VWvw45Q8GW3FGPx3ZJ+Zq0SAQN4bQBi1sYUyx6EgkH6vTLkLl1WbSYgvOvClPfmWbGIawg/FQMgfLsadh9wdBlT8tjrYo5TBXJmgEtRmVSY9bOyrLNOGmKHs+R3Jq7cMKb/gqYgCD4fH0dQIOp7iCMoTbZhy5F8S5sitXxthI+QAwdzTwNbuOSULWsmfp7gfY0ZphDItrpMwn1MXtAuiz8ieIeuaRxoDwzVHzrxfcy/s36IPGY6Gw8rSEXNFvE77k5Gbowk8lQCw5F98k+G8Up0e51xTOzfbRVqdTiHvugvVtMmXtf7tgNk/DWcjh1DcfG8wznXHHoPPm/iDydGSddKO6Fq4IhGLA7R7wqygZq5FBXGw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4024.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(366004)(396003)(64756008)(478600001)(53546011)(9686003)(66446008)(6506007)(8676002)(66556008)(83380400001)(33656002)(7696005)(54906003)(66946007)(6916009)(4326008)(76116006)(2906002)(316002)(26005)(186003)(5660300002)(86362001)(8936002)(52536014)(66574015)(91956017)(55016002)(966005)(71200400001)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fVZ0DjDM/TfPhdPdTMwKGxGKBQZbo0z6sibaTlUbryFz+QUfuIE3dLw1pY1R?=
 =?us-ascii?Q?jxDAJH6VwfQtRp4mBknokOnq5DIV2A6qz219KStIem6TGTidmyw8zqWJ6rmu?=
 =?us-ascii?Q?VD0eJVJay81Fcp2Kr1nmn3HNQ2dTYPjbqHxFG3zt4jDdGR4cmZeWwVwC1XQp?=
 =?us-ascii?Q?+tmTGp6AZpCPmlbgSRBV/xKdc+mAhL3lEfM+KEcqOb+/tNzLjbWNkZTQnHxw?=
 =?us-ascii?Q?1JQt/gmM6lWOsU4xIlqiTri9gA84Mmbe1HYGR8HVRbVNCS2tnD85DTQhnb2F?=
 =?us-ascii?Q?9hPv3F6EZqO/6MDKqjURb90+cErMYsupkuCEyvfmdAVIxHBzBhW6kTi/1tLW?=
 =?us-ascii?Q?ao7kulC/Pii3nHLHVHXwLDCp6Se9ihfY6gprtMwwWh9xQbQqMX7QctCcfAts?=
 =?us-ascii?Q?qG+Bz+iPfRHmR70ll2qarvAkl4Kcvq3lqmo0+0DrKRpHy+uxzx1Ch3B2MS9x?=
 =?us-ascii?Q?qX2A4FPwQOsFqWaNvMAhUMYuGA0zNFWMwX35bx/DgoQc1obIlzc1FSGSuBo4?=
 =?us-ascii?Q?RkGSxNumyQ84l4lNznWBowduvdR2ju1kXVpHbF7lax6Kfsm+rr0G3ZwAE/Y3?=
 =?us-ascii?Q?efqMGXJjQjEGkIHYWMA6Sahpcf6DcnEw9/5kDYF6cHEcVrEnu7KBIIRvqOoi?=
 =?us-ascii?Q?DQ1nLmZ3rp6+ZQwqjv1p7Ux2FMv5TDyfWI6i6OwTB0LcdBN0YFQePcn4DnvW?=
 =?us-ascii?Q?EiQfbsufp1H0TJBC3JymfdJcOSN1xURgwuzswDEQgvEqTIRh3bkZwv5JQ4R1?=
 =?us-ascii?Q?DTqDI8/exJUmqgijhYrz/24UqqSWr4eq1wfIr3syTevZUnpEWwp6h0Cu1PI1?=
 =?us-ascii?Q?Gs5Dl5BOKdl1xWEBwlzLdTMphvdDFJDf4Xq5uk3epoIaG5n3kEn8UfIFGxCK?=
 =?us-ascii?Q?dPFOsuFOcf9QTaQXslKIOONEBvFTUxSxBIIbO97AD02wdBJlNhD99JnpEmMM?=
 =?us-ascii?Q?UoN04+u0wwAtei5W8UE7OUIR24ZkJ0PzZTA1rfTHGsEHWP4OrlRvB9X+AHJ4?=
 =?us-ascii?Q?gB0X1ACUmuDHBFnD1l2cQ0vW6Bx4edOqJJdp6UGPSoBYbkJt/Noa16ewl/zI?=
 =?us-ascii?Q?CxwiLKiHNXu1kllJ3wkq+ftAvVfX0/nP/U99mw9mlCorUq8Mx/NDvkFGn9Oh?=
 =?us-ascii?Q?hsmXbCqel9VFfhGPi846hnhG+ji6H9zlrh9tZGel9b5mtJfhxCTSlOnX5Xif?=
 =?us-ascii?Q?BnWvwzFStEPOXZnDJSXEqic4aWjWEHc61T7ySifY2NPx+aOVmCNcSr3+o+/e?=
 =?us-ascii?Q?gjJJnBnVJLeBHXqtvwuNAwaEvDHjtnIe+g+clkO6IzK12vk7Fb72pJyZvHbg?=
 =?us-ascii?Q?Ong=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ff3173-8316-4320-39fe-08d8e7d1cdd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 16:45:55.8562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZWJ/DM10f/zHV9cVwGD1qbFApBtuKYx84nFkesDl+ofx1IXH0fBlSzITRh5pvHEiojetVAb3Ukwnjq+4ZEM8kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5118
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.20, xbe-rcd-005.cisco.com
X-Outbound-Node: rcdn-core-2.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Makefile.config:1026: No openjdk development package found, please instal=
l JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
> cp: '/home/jolsa/kernel/linux-perf/tools/perf/Documentation/tips.txt' and=
 'Documentation/tips.txt' are the same file
>  BISON    util/parse-events-bison.c
> bison: unrecognized option '--file-prefix-map=3D=3D'

I thought that this flag was added in v3.6.3 because in git history next ta=
g after corresponding bison patch was v3.6.3. But this is not true.

> hum, do we actualy want this? I think we want the exact path
> we used for compilation, no? what's the benefit?
...
> same here, we want to be sure to use the python path
> from the exact build laction no?

This patch makes perf build more deterministic. This means that if we build=
 perf on two different
build machines from exactly the same sources we will have absolutely identi=
cal binaries. To achieve
this absolute paths should not be stored in resulting binary. That is why i=
 tried to determine those paths
in runtime instead of storing them in binary compile time.
There is ongoing project
https://reproducible-builds.org/reports/2021-02/ project
Kernel already achieved this
https://www.kernel.org/doc/html/latest/kbuild/reproducible-builds.html

This patch doesn't make perf 100% reproducible. There is one more known iss=
ue with pmu event ordering
https://bugzilla.opensuse.org/show_bug.cgi?id=3D1180882

________________________________________
From: Jiri Olsa <jolsa@redhat.com>
Sent: 15 March 2021 14:28
To: Denys Zagorui -X (dzagorui - GLOBALLOGIC INC at Cisco)
Cc: peterz@infradead.org; mingo@redhat.com; acme@kernel.org; mark.rutland@a=
rm.com; alexander.shishkin@linux.intel.com; namhyung@kernel.org; linux-kern=
el@vger.kernel.org
Subject: Re: [PATCH] perf: build reproducibility improvements

On Fri, Mar 12, 2021 at 03:17:00PM +0000, Denys Zagorui wrote:
> This patch helps to make perf build more reproducible
>
> It seems there is some need to have an ability to invoke
> perf from build directory without installation
> (84cfac7f05e1: perf tools: Set and pass DOCDIR to builtin-report.c)
> DOCDIR contains an absolute path to kernel source directory.
> In such case this path can be determined in runtime by using
> /proc/self/exe link. In case of building perf with O=3D
> Documentation/tips.txt can be copied to output directory.
>
> There is also python binding test where PYTHONPATH is used to store
> absolute path to python/perf.so library. This path can be
> also determined in runtime.
>
> bison stores full paths in generated files. This can be
> remapped by using --file-prefix-map option that is available
> starting from version 3.6.3.
>
> Signed-off-by: Denys Zagorui <dzagorui@cisco.com>

hi,
I'm getting build error:

[jolsa@krava perf]$ make JOBS=3D1
  BUILD:   Doing 'make -j1' parallel build
Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from=
 latest version at 'include/uapi/linux/kvm.h'
diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
Makefile.config:1026: No openjdk development package found, please install =
JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
cp: '/home/jolsa/kernel/linux-perf/tools/perf/Documentation/tips.txt' and '=
Documentation/tips.txt' are the same file
  BISON    util/parse-events-bison.c
bison: unrecognized option '--file-prefix-map=3D=3D'
Try 'bison --help' for more information.
make[4]: *** [util/Build:211: util/parse-events-bison.c] Error 1
make[3]: *** [/home/jolsa/kernel/linux-perf/tools/build/Makefile.build:139:=
 util] Error 2
make[2]: *** [Makefile.perf:653: perf-in.o] Error 2
make[1]: *** [Makefile.perf:236: sub-make] Error 2
make: *** [Makefile:70: all] Error 2


SNIP

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index f6e609673de2..2bebff69b064 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -627,6 +627,9 @@ $(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_=
EXT_DEPS) $(LIBTRACEEVENT_D
>         --quiet build_ext; \
>       cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
>
> +_dummy :=3D $(shell [ -d '$(OUTPUT)Documentation' ] || mkdir -p '$(OUTPU=
T)Documentation' && \
> +             cp '$(srcdir)/Documentation/tips.txt' '$(OUTPUT)Documentati=
on/')
> +
>  please_set_SHELL_PATH_to_a_more_modern_shell:
>       $(Q)$$(:)
>
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 2a845d6cac09..d9441055357e 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -610,12 +610,27 @@ static int report__browse_hists(struct report *rep)
>       struct perf_session *session =3D rep->session;
>       struct evlist *evlist =3D session->evlist;
>       const char *help =3D perf_tip(system_path(TIPDIR));
> +     char *exec_path;
> +     char *docdir;
>
>       if (help =3D=3D NULL) {
>               /* fallback for people who don't install perf ;-) */
> -             help =3D perf_tip(DOCDIR);
> -             if (help =3D=3D NULL)
> -                     help =3D "Cannot load tips.txt file, please install=
 perf!";
> +             exec_path =3D get_exec_abs_path();
> +             if (exec_path =3D=3D NULL || asprintf(&docdir, "%sDocumenta=
tion", exec_path) < 0) {
> +                     docdir =3D NULL;
> +                     help =3D "Not enough memory or some other internal =
error occurred!";
> +             }

hum, do we actualy want this? I think we want the exact path
we used for compilation, no? what's the benefit?

> +
> +             if (docdir !=3D NULL) {
> +                     help =3D perf_tip(docdir);
> +                     if (help =3D=3D NULL)
> +                             help =3D "Cannot load tips.txt file, please=
 install perf!";
> +             }
> +
> +             if (exec_path)
> +                     free(exec_path);
> +             if (docdir)
> +                     free(docdir);
>       }
>
>       switch (use_browser) {
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 650aec19d490..a20098dcdbc4 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -98,5 +98,5 @@ perf-$(CONFIG_DWARF_UNWIND) +=3D dwarf-unwind.o
>  endif
>
>  CFLAGS_attr.o         +=3D -DBINDIR=3D"BUILD_STR($(bindir_SQ))" -DPYTHON=
=3D"BUILD_STR($(PYTHON_WORD))"
> -CFLAGS_python-use.o   +=3D -DPYTHONPATH=3D"BUILD_STR($(OUTPUT)python)" -=
DPYTHON=3D"BUILD_STR($(PYTHON_WORD))"
> +CFLAGS_python-use.o   +=3D -DPYTHON=3D"BUILD_STR($(PYTHON_WORD))"
>  CFLAGS_dwarf-unwind.o +=3D -fno-optimize-sibling-calls
> diff --git a/tools/perf/tests/python-use.c b/tools/perf/tests/python-use.=
c
> index 98c6d474aa6f..8b4865c90d5d 100644
> --- a/tools/perf/tests/python-use.c
> +++ b/tools/perf/tests/python-use.c
> @@ -8,16 +8,28 @@
>  #include <linux/compiler.h>
>  #include "tests.h"
>  #include "util/debug.h"
> +#include <subcmd/exec-cmd.h>
>
>  int test__python_use(struct test *test __maybe_unused, int subtest __may=
be_unused)
>  {
>       char *cmd;
>       int ret;
> +     char *exec_path =3D NULL;
> +     char *pythonpath;
> +
> +     exec_path =3D get_exec_abs_path();
> +     if (exec_path =3D=3D NULL)
> +             return -1;
> +
> +     if (asprintf(&pythonpath, "%spython", exec_path) < 0)
> +             return -1;

same here, we want to be sure to use the python path
from the exact build laction no?

thanks,
jirka

