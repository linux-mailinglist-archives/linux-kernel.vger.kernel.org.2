Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6BF360235
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 08:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhDOGQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 02:16:38 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:8731 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhDOGQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 02:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618467375; x=1650003375;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ssoGgSsnFPbOQ6veLDlGrzd2vkKQ+wr8/p1zc0nyGJQ=;
  b=VGjaZaIgFzH95mh20cSgUdhM2ewtIen602HakpEvMZE+bVIxDDFDlix8
   oLCHcXARHYo2gHQCKmKLMzThKBa6MJboabu6rYW611ejor3L1YVzYn84Y
   /xTjr/BNwuPGzpFK1tqTnDDd132jtZC5Cx21NPu+VUNW/W1dpKqij7Iib
   MHcQWG3cO6yFZHa2DH+bfAd3M0RoIod7iyhRlXVMmqm0ak06v/mFKAW/Y
   k2RjyTFREcEh52UvBMklsmgUaYvph2MWtUYgj0TrxK7MnZVpT8LZrLgYL
   PciV52fS7dI14+zc+s8S9d1e3l9PguP7zS6r5ESPg6VXA4Ywf1QhA1c1y
   Q==;
IronPort-SDR: dZmjQXXHA6TJ6ABWliH9x8V4D/8KyO15XWY/4wyP6T6sTc+3ux/14vnWgT0cIIUs0if636cmBU
 qj1xkBisn0XCV2ZJ++/sgy6TE68mxiUhZa4ieJE7Exnah2Z9QboUt8NKqJHhXoB1WtUcr0dwR6
 CDWkUOrTRuDf9AiK5vXSYVRw9/Uwnm5ShjqJKRFnnKmXc5w4l4c1Y/UPzeKijxAXtMiE0gNLGV
 lmUrtfKoLbsZs641aMx8+YNe/M2tEPF09FE0kBBesfBFZmct9A6TMuLWQK44o6nnSaqGaK390n
 OxI=
X-IronPort-AV: E=Sophos;i="5.82,223,1613404800"; 
   d="scan'208";a="275790191"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2021 14:16:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRmZ5VMSEuqDwoe9xr/hfqCyJGHmGgn3DQbgcwt5ezjI6nj9htP5t/L8sN8hQ8W7/Km6AFJuerA63lu/0FVkrXLNeTrxR3bZshhTlnTRS+qbXmyXunN/ZmFen+RwShoN+psctv+fz8DmwtRk+CW+fue9o+VEIpAjCdYuFVo4tuU4BFXrIO5bfJxyXD78C68kkroN4lMEmOYeB0esV9vbGJfHJ4tV8bDQuVcEWffBZVJfXaCUexWlMz4LoTE71Qjg8Nz4VNzw5BHV+GO6ysHXuHIJ64mQWiiOyFP5deGzMlOvpi4emDzt9Kql5HUweIH3HBl2GWWs681JGd/pk9DZog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRFW84aVZCa2AG0q8if9vHhy7fKAnrEuo63B7ZugV0s=;
 b=bPlOCJKXwzIkQzFPoSo59LUpHpnIezbZ4UCcghHmL0/F/XyF/bBSLBQE81zPgQ1jri6/ucPKYM2HoutKmO1hIjFbwOggXhE443uduY0svy7fXOvRZz8Dxf8wTw4NmozdJgbhVRVNtKcJHMVbIDScboCV3zH8u2EfugdIt71oKBdWqeILSGCsQpH1JRh/b98t8P4pFUNJwQx9XvRt2RCitbUEBH833h/PA9XelG8bE9lhu638XIYI9jkLDCkDDD0tH37lD0GI27l9VRVU7y/hx50bdwPKS2S2qjGkaNYrUszrCckTBE35ovYUfcfGgP1pdEWPk5yjLb3k9y43IaLNfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRFW84aVZCa2AG0q8if9vHhy7fKAnrEuo63B7ZugV0s=;
 b=lgZi8hQg/qqRKHBhnShBKpzSgI4gKQjHO/4Pweq9DKqwqbH0TlufETCwn2a6OyDu2oPzqpKWqnMnw9CjCzU5dplyCgSE3+zCzbBUU8tvk/9Jvt4bt58mHo6guMzcvk6bN8jllfA9It6XAF6VBre1YWQho2Wt2UbB4lw6sdq1/Qs=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB6531.namprd04.prod.outlook.com (2603:10b6:208:1c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 06:16:12 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4042.016; Thu, 15 Apr 2021
 06:16:12 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@dabbelt.com>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "uclinux-dev@uclinux.org" <uclinux-dev@uclinux.org>
Subject: Re: [PATCH v2 0/2] Fix binfmt_flat loader for RISC-V
Thread-Topic: [PATCH v2 0/2] Fix binfmt_flat loader for RISC-V
Thread-Index: AQHXK8WacfnVzM4zUUS2ex+k23Zi9Q==
Date:   Thu, 15 Apr 2021 06:16:12 +0000
Message-ID: <BL0PR04MB651449999EBE967EC5622FB9E74D9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <BL0PR04MB65148D80C819A7E3B8365242E74D9@BL0PR04MB6514.namprd04.prod.outlook.com>
 <mhng-61cff5f4-32a0-417d-9a2f-eb6d052cf802@palmerdabbelt-glaptop>
 <20210415055605.GB8947@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:a831:e732:e39f:8a81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fea03c1-a7c0-44fc-7a45-08d8ffd5f7cd
x-ms-traffictypediagnostic: BL0PR04MB6531:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB6531E00A333A306D39FB2DD8E74D9@BL0PR04MB6531.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OAKGGkvDr63BVy+3r9gSzO4X7H4a3F8oCfco26V5mB8T1eUKiN8lAaBcQ3XmiV8dLt9eBOCqDdMS8tOXKuLaybNpjcXpMcbzj6bYKvha5kZ3Z5vS7v2DLqgIrMydKsRNmhdlQyU81+faThPf9pe3dui6k8YzWmJF9CZk7Vcbx2suYLmMHnr11gbAtzNY4T2pOafmR7BCkqFy3oqHyVL21DleYJegCtvfmmyGu4JEmU2JplXn3pBT1Mi/t+1KreEDPASctLdi8z63e5CtBtmjp3t8wvKAPwdkJJVwdOwsY6uBUI2zrxAd1WnkySFlhXMfVhBUyLNyeIJ2woQNoPgQYS2kK1coELdcqDaGyFLeOynI8LNcftGtsA4h4/0Jo8YoQgd6jrAg6GFr7bAP3Z+9Wjwi3OukTc/FPQIYPffopQqJRJZpQ8ltpnnz3GTkQ8FcmyyzPyxbh51YoUf6yCUUNXlXh1pC57fnO/kHlaxTjOretv1zIV5Loi7uQFbwH3/rblzqOkokGwePZThC87ymbXow5fqDiLcuU2lUZvbJ9ucL+6PaP0wQgwJZBjjtWW8VgSrVRaSTb5iq+rTeI0sz5nuZRSW8DaDH06dHKzSHlDI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(186003)(33656002)(86362001)(71200400001)(110136005)(55016002)(54906003)(8676002)(4326008)(316002)(38100700002)(52536014)(5660300002)(9686003)(122000001)(2906002)(66556008)(66946007)(76116006)(91956017)(66476007)(66446008)(64756008)(478600001)(7696005)(8936002)(83380400001)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?n5LBuj6vmDgup6ET4IxymWwQaZJlEesLEY1YRsDtoKAtWibDIM+uWlZci16+?=
 =?us-ascii?Q?4wCwUsGK2eUH3Pm+FI0X81n/aeixEduIkJgGQY9WeQ4z6DIMxudEVDdmRmo4?=
 =?us-ascii?Q?UCacGLRA2xZw2QKsDJkmV5TOBsAeKGKumEQdrXBJGqFU2jWYC2NsHQb+2RK3?=
 =?us-ascii?Q?p3YLZ38w2n6bqg72i04/Pze/bw7s4DpmUN1IVflrB2QUZ6pR9a8SJuI6SK/L?=
 =?us-ascii?Q?d5P40HonyL+b3GDwDnJ6TcniI8HkpOk7wV5jVJ65yNIwMhQyTzNzB623SY9K?=
 =?us-ascii?Q?ili8j16SlVCy6bQlpegUiaaC8g0CuKZluxVQ/qUdRI/SYDfxxMj2LNQwnoK/?=
 =?us-ascii?Q?zIhVYyHKufBVSO92mViSdphfZuCw+bTu24cl8ozDIPwoDSpxpnUFxMVf8tY8?=
 =?us-ascii?Q?zthx9zx1h2LqI57ztjakfSlqAlYkS4ca+knL6wc71pzOZ1y0xuE1Y0pnUiA5?=
 =?us-ascii?Q?0kSNe6w/bBgwt9Vu/6OqPvXSh0unQiYjwiiRJdqX5LgJIzrK4Sgq9o7yG0u7?=
 =?us-ascii?Q?N/2gSvJqYoncH6FWLyTS0rx6A1apXaN7KG9AkHSwCwfI9YatROPv4QMvxvaz?=
 =?us-ascii?Q?GJf8rS8MGuIPO/NB4c9U9N9TpKsx1fETDgHNGO49CZcXvvtZxZfI6+xsxkjV?=
 =?us-ascii?Q?B5wWK9gNOZ+PMeNtC08R9jBQuMHowrUt+pARb74KsrSKWTUYO3s0nI2xDOM5?=
 =?us-ascii?Q?UXEZ1iPHbaKYU6UPR7nU/4l3f3HkYlcNm+HYQVEwbci3RiKhEBqU1tRv5llc?=
 =?us-ascii?Q?AF8Zszn/M+4jzrx5jRSt1xqH1ulKJgG3KgDZueYpLCN8P0P0QLVS6NzD7C9J?=
 =?us-ascii?Q?4P+k2yoO/M0aCr5VAYyynS7Y56KGinpUagzKyoq1wKmgPBnGgKtpS8s++8kX?=
 =?us-ascii?Q?YFlrwAlJbjIbAczx4bn6e5+YosnexUBVBdnwZnVdUuJv3W27jajl1qaoUAfA?=
 =?us-ascii?Q?1tzvpUI9WJYzM1Xu7pa0gaV2OSQlk+m0AuSKxCqjiMKYfmj4lJ5WsFsarJMZ?=
 =?us-ascii?Q?K2Cqc9pkEmJ8zK7NJdyVAr/3jQYY26LcPwtKLes+wQEA515zEQXqnBvukX5x?=
 =?us-ascii?Q?C53MtgMBsGUTLdBOt8dwXpeGsu+M3GvKT91HYZriuB3xCSv7HDrgUMlVsSwf?=
 =?us-ascii?Q?17OeobJe+zxjFm6ijHcGxOnJ7kf0lZWpucxcMUdSVUKC81tBgAdWCd18uk4L?=
 =?us-ascii?Q?RntOcoFYcOXCr9pQrbnzyhLbwehA77uYtXDrmBQiD/takKjfrrK/wyLrzrjJ?=
 =?us-ascii?Q?+WKydOJB9sTsY0PLtAK08LXycWAN/mT3Fedw7LWfIjgIL1Uo2eziMnu0Q4MH?=
 =?us-ascii?Q?cwHH5PvSBoqu61w3B2ttj+vgrVpkkIpZghmDXBTsNdRyuFHpqXAVHDQWiaQP?=
 =?us-ascii?Q?7SoAGS8OM+SZPxO/wiN6Ic0bhdKTaLP72Ppt7iIc4fTbSsknAA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fea03c1-a7c0-44fc-7a45-08d8ffd5f7cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 06:16:12.2365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q1LPJS3Lr5U9Quybnh888BHTfLBRfScGVx3DhmfDh3YePvQTJD4PQtP1E7idqkiT0xuTRG4S92aa8B3F+RUmEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6531
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/04/15 14:56, Christoph Hellwig wrote:=0A=
> binfmt_flat tends to go through Greg's uclinux tree, adding him and=0A=
> the list.=0A=
=0A=
Thanks Christoph. I resent the series adding Gerg and uclinux-dev.=0A=
MAINTAINERS file needs an update may be ?=0A=
=0A=
> =0A=
> On Wed, Apr 14, 2021 at 10:46:36PM -0700, Palmer Dabbelt wrote:=0A=
>> On Wed, 14 Apr 2021 17:32:10 PDT (-0700), Damien Le Moal wrote:=0A=
>>>> On 2021/04/08 0:49, Damien Le Moal wrote:=0A=
>>>> RISC-V NOMMU flat binaries cannot tolerate a gap between the text and=
=0A=
>>>> data section as the toolchain fully resolves at compile time the PC=0A=
>>>> relative global pointer (__global_pointer$ value loaded in gp register=
).=0A=
>>>> Without a relocation entry provided, the flat bin loader cannot fix th=
e=0A=
>>>> value if a gap is introduced and executables fail to run.=0A=
>>>>=0A=
>>>> This series fixes this problem by allowing an architecture to request=
=0A=
>>>> the flat loader to suppress the gap between the text and data sections=
.=0A=
>>>> The first patch fixes binfmt_flat flat_load_file() using the new=0A=
>>>> configuration option CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP. The second=
=0A=
>>>> patch enables this option for RISCV NOMMU builds.=0A=
>>>>=0A=
>>>> These patches do not change the binfmt_flat loader behavior for other=
=0A=
>>>> architectures.=0A=
>>>>=0A=
>>>> Changes from v1:=0A=
>>>> * Replace FLAT_TEXT_DATA_NO_GAP macro with=0A=
>>>>   CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP config option (patch 1).=0A=
>>>> * Remove the addition of riscv/include/asm/flat.h and set=0A=
>>>>   CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP for RISCV and !MMU=0A=
>>>>=0A=
>>>> Damien Le Moal (2):=0A=
>>>>   binfmt_flat: allow not offsetting data start=0A=
>>>>   riscv: Disable text-data gap in flat binaries=0A=
>>>>=0A=
>>>>  arch/riscv/Kconfig |  1 +=0A=
>>>>  fs/Kconfig.binfmt  |  3 +++=0A=
>>>>  fs/binfmt_flat.c   | 21 +++++++++++++++------=0A=
>>>>  3 files changed, 19 insertions(+), 6 deletions(-)=0A=
>>>>=0A=
>>>=0A=
>>> Ping ?=0A=
>>>=0A=
>>> Any comment on these patches ?=0A=
>>>=0A=
>>> Without them, RISC-V NOMMU user space does not run... I would really li=
ke to get=0A=
>>> these in this cycle if possible.=0A=
>>=0A=
>> This LGTM, but it's pretty far out of my area of expertise.  I'm happy t=
o =0A=
>> take them via my tree, but I'd prefer to get an Ack from someone.=0A=
>>=0A=
>> Al, get_maintainer suggests you?=0A=
>>=0A=
>> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>=0A=
> ---end quoted text---=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
