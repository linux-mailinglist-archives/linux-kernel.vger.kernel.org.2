Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C921B361AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 09:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239707AbhDPHih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 03:38:37 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:10694 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhDPHig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 03:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618558692; x=1650094692;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=EHE/ivofGHKwjS2amYk+9p+WL6y9X09Y+xArdmQEB/I=;
  b=gokepgcMfBA7c6WpvLXZcTOPhGZi9+Xd3oWemoxcekbC/0ZP6B5cP7yo
   +1Dn8F8exvxIYM6kKGx+VpzlornVeFLCPqLYmtmAxyks5nvtNBaruhzkE
   6HrRg98TXPEwbJ+O4W+l8qg+ZeM1PJVjy8Ink7VuAYV3GBO+9zeqOQNwe
   G+lXnrzx49Kj7c+Gw288koyFLN/harxoYa19+yNU4Z76xlCu7Nfl6ra2a
   qY460qEHeQQRWycSK9SSAYfLKSkCpN7NnqCWbVXdGuEan4JMu9ziGRAPc
   /tVTkso44alyDrYJ22bVJg9JgSt096dYyen6c4j2+IS7qDJ6u22shGzyO
   A==;
IronPort-SDR: IyOyMRzUejnRQJWrso7TTpdgQ7Gtwh4UPxUUROzZqhZ9+2LqtTI+E96T5zS7BT6aLPKWb6ElMu
 vNL6llmHPxgWjk5UO2ssIf4FinHCe8EsGEm5wR77I18HfsT1Ba0nwLYf9pQmay/3K9rPDufjke
 yU+ED5WrsF4COhsOs+wYh1s0O6tGF+VxnxKJFlo++daVLSSFer+ve4FqH9vFy6LOU8iuyFDjS0
 aUTNSvqTqc5p33t2EnXfMnZrknfobV4S/EfaBrIbSPe/HkIQ1Qf8zjHSC+h4pAjnf/pamJIKTq
 D4w=
X-IronPort-AV: E=Sophos;i="5.82,226,1613404800"; 
   d="scan'208";a="164438659"
Received: from mail-cys01nam02lp2057.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.57])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2021 15:35:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSn7iBL/W9qPZ+2d4VKFs8vd/tJkZKTUA7KH2Rbriy2luBXz50AytpMJusiuN8yGF96YGTMo3HSbvM8haHDHcqaYrZz9EIZ29sPn4odnmNsRfKqR/Ylq2pPYDHlbPDym+Zi+hTssN913EJxC8T/ggE1spBw1tAqvyUlmMLIiXqJypPqhziBIR15kN/C7Nr2GK0kSyt3xEAJa7tvfbA9rTR2G92WTVKMvaQkJSoxCtUWE6cuiM+zMFzZhfv7/IfND+lDZnPBb6jq5oOfIqJ6yHhIL/1p+DQePK6VcP+JwkjL2U+mw0C8/mYbzKL4Gihblce/i3bit/QZirefGF2fxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJ3zeS9U65ywsSivOcq9ZBYz+wx6iXDB2XZ+wfg0FtY=;
 b=KIF7xoSYR5MkIqU53rTwVXbuUo6nvdOt9OjU5/kasq1ZL/TCGQUXcDTNChwZVs9ouvSpyYpJtsWaRq+IICrTX+KNsldiTLW3kZ3IbU3dZdCU7y+xXVKIqjCloYrYrWwYozKalADiE+lBki4kwcfTxXeVtWRtPH4gmVE71xIWzg+Y/4AZhTj8+HE4NjWKk7Hh0r12Rf+bcfcJW/86FkDvQxDe8Iwy0kTWo/d21qOzNX7fxYFsUKOmYcoHgkBj2l8sgv9rEQQXPtI/CjwKiFGxYbsBfYCPBdcIXS1lO+SkXrMnhnsfKIFXdo53DW9DMf+4d/mhulO6JIHRsRySqdt+LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJ3zeS9U65ywsSivOcq9ZBYz+wx6iXDB2XZ+wfg0FtY=;
 b=r8nbmcvUC3litBr3N3Cpd6rTJUmYwlWM0gT3snZvKWarsQhwhwobW0DyOCC6IFsB3VSXKNXKeuQEjM+VdOMu5b7rHIEUDdHxxbAt+ySBHayc9xXZs39Za0jS3omnZpon/BrW6UOSPYPEy93+FuGUuEREOmWX93ttN5kO7SUpVdU=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6669.namprd04.prod.outlook.com (2603:10b6:208:1e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 16 Apr
 2021 07:35:02 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4042.016; Fri, 16 Apr 2021
 07:35:02 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        "uclinux-dev@uclinux.org" <uclinux-dev@uclinux.org>,
        "ugerg@linux-m68k.org" <ugerg@linux-m68k.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Max Filippov <jcmvbkbc@gmail.com>, Anup Patel <Anup.Patel@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 1/2] binfmt_flat: allow not offsetting data start
Thread-Topic: [PATCH v3 1/2] binfmt_flat: allow not offsetting data start
Thread-Index: AQHXMb61DCVMbvZIeUC4C2ar1xW5kg==
Date:   Fri, 16 Apr 2021 07:35:02 +0000
Message-ID: <BL0PR04MB651452B570CB9BA45AB7C3C1E74C9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210415061502.7248-1-damien.lemoal@wdc.com>
 <20210415061502.7248-2-damien.lemoal@wdc.com>
 <8ff801ad-6e17-fdd2-6186-5443540947a9@linux-m68k.org>
 <BL0PR04MB6514D6C35731EA1CA581095EE74D9@BL0PR04MB6514.namprd04.prod.outlook.com>
 <a0ce28d4-f99d-c1f9-566d-c6ab2f60f585@linux-m68k.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:c420:851d:e64f:2199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a4f041a-0411-4c3d-ae07-08d900aa25d0
x-ms-traffictypediagnostic: MN2PR04MB6669:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6669FE61DDE1D5FA6E67E1BBE74C9@MN2PR04MB6669.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BKbT5wCu4dbgvdIM+0ND+roJOkSySVVKZj0rKl1xNwmFxKdkiTZE2Ktzsnsw8ndEkLOdDb9lhWdWc5ytWeuCWL469xepJJN+jU+puqr2x7dvFfrr+JL46J88STUOTMUZFxRbEv2xCkWuPRUeqS+P2lQ/H09jfVmNLlNLdVtyexVVXNR4t2xRCbPESB+sfZQaOCOHqXcZBjbtgVIJ0rqtYhgLrld54Um98l86iLB4hyyW/Z+2txrcntkeTcJKMDxHYlLxHMBM3pFUUodSfHIJvXuC7v5x3VtWrrHjxp7eR+W71PiOvvEKmXbqfZ38e8g//DD918tKtJgaPESs6EmPfAi5LZbbW+ByZDOmvnfvg6szOrvIAAWJd51e+KJoKPYN7yzEfN5S53allos59b7OpW99zfLzG9AJPcp5AP+e793aH42aekgk8SF8m8GNqDyW1Qa8Hht1d11JTqgGBXG5vMuI6LraQV7tBRX9Dqx2JaxpbXDnJZ3z4UNPaA61veH6Yvrs8zYNANkPG+wcBW+kCX/5tIncHk+kRegNHNag/uVFBGSyvezEVJa8w7aaz47WEH0vngHMpwHKUFWaV2mx9BFQhdNQY71ko/OB+XDe5mQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(76116006)(66446008)(186003)(4326008)(122000001)(2906002)(8676002)(8936002)(33656002)(6506007)(64756008)(54906003)(478600001)(83380400001)(71200400001)(7696005)(91956017)(53546011)(86362001)(52536014)(38100700002)(66476007)(55016002)(9686003)(66946007)(66556008)(316002)(110136005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2svb5AQrhRUS35Axzfd57qzM899pCo/bo9EjYlkwZNraU5TBUavOmBZvpbJP?=
 =?us-ascii?Q?vNhiSTVthhu3k2kO6B9t9YbBAa0XlEhg2bVjSGtM9teEW80DwywWqvcwrXYh?=
 =?us-ascii?Q?Jz2wzKNXJcMnVKSTIC6YYYfSApm0v2dAII/eD4R2ohrGrxn7vGGF1WgXNlRp?=
 =?us-ascii?Q?ihqFkv1oTwZI/RChYno8poEw2giS0jctFBkGjT+/wPS1+gj4oiqwVOmYInw2?=
 =?us-ascii?Q?rpNPdb4knbH8OTggAErbyOgTPauM1lmFscSaDjEJv6Eis2k3zgoBXnnp7Rej?=
 =?us-ascii?Q?2sKADlhxZYASC4mCFEoYguvavR0SImi19VuopJci/7FunCDlxozavKtMolA9?=
 =?us-ascii?Q?QaSGIESOpvsPS38EzBCHZiHHcfsMJXHwB2/pIZVycyxmL7X4gVyBoQs1QguF?=
 =?us-ascii?Q?1yrIaYwQWV98dtszcuyzylpuuRr57lTVCzTis8D7RgCrZxixo5PT2LxMpmLy?=
 =?us-ascii?Q?rJnE6Qpucvy1pBP4oV6mveLElAQauW+i55wxLPmGBXQHqPBQQ9tZZ54VUD1e?=
 =?us-ascii?Q?Ot79SzLYfnSGhA8G+1TH9ZbF0NmIlXqVzv5gmoA23m9ePCqxHpNc76FdeXO/?=
 =?us-ascii?Q?dHUllxmHJk1uIeqCarcnPim/iCtkhXX5kisGgfa/PgsdA1dBdAhlHt/MADCF?=
 =?us-ascii?Q?7Wv6NjS5aWzM6dEG7SNMgeJNGaIwP4xgrW7WhkeeEesNWACThqgDydu4a2hJ?=
 =?us-ascii?Q?hY5xhu3W1MlZy1Pxt6Nb1Pb0dr0VmsCa1M1EJ1e83Kl3WlaX7zTe3gcPUEj6?=
 =?us-ascii?Q?I6rEncx9neSYRZGxqHG4EsF8RXJ+OtLjPqzlaBIffl+GmycZKNh0FCM8+N9A?=
 =?us-ascii?Q?n06yWpwYrxk30qlJJgfBkAQbkhhNNsqxv5s6fa3QKbYhQ76seAqjro3gqX7c?=
 =?us-ascii?Q?1kNVr43e3qZ1wLNxhG6ZdifK5g9vRwRJ1wfOQcfmMfmivy8MpS9mbDk5OF5L?=
 =?us-ascii?Q?JDFCWUN4ADuUqjjeJe1usM946WWpAGn01Vd2q0IOcfeGEm+M4u9tHpScagbj?=
 =?us-ascii?Q?Tnzq2QQenatr7uj6ujdW8lUIJtI7dhZpNshIj+4ptpJCIOAVoLte3qx3FcxM?=
 =?us-ascii?Q?75P4/dvpg34s4xqaKtwNKuQjhKZ/UsBzsHIucDIDKSU4RGqZAtNXuVgq4pRp?=
 =?us-ascii?Q?eWxkDacxC2OlIgDb0mr82Itx/hZnuQkLrUI/gmYTS0sBAoCn+9Fi5oNudhcC?=
 =?us-ascii?Q?jSOKvCKb/PoPqANqFBeSYrMg1+DluAf8VYwb4PijPo5tNvHyEGmUZWHELDKq?=
 =?us-ascii?Q?bU5aMIj2WFj6OQDvnnpTRf/AMYttrl4lobmPqml1Z7bWcEmZmoeaM3RNYclC?=
 =?us-ascii?Q?xysBSdXWlhG5JNsiQ8TzPmA6XcDdbthnvJuVtD+ubq+tozC6+XTUzNKCE4wW?=
 =?us-ascii?Q?8vn7LotXZz+WxhsQemGo61C4RwyTG7qmzwQpcfGBeVQ3l5pSDA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4f041a-0411-4c3d-ae07-08d900aa25d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 07:35:02.7613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ubwGaWu3uKrrhxxQ0AhgH/WXlm1182J86wcYfOBzF1vHNtfQ2jPONfdHCkEy1rSKcbJGHKcVtlp8wCW37nBy/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6669
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/04/16 16:24, Greg Ungerer wrote:=0A=
> =0A=
> On 16/4/21 9:22 am, Damien Le Moal wrote:=0A=
>> On 2021/04/15 23:04, Greg Ungerer wrote:=0A=
>>> Hi Damien,=0A=
>>>=0A=
>>> On 15/4/21 4:15 pm, Damien Le Moal wrote:=0A=
>>>> Commit 2217b9826246 ("binfmt_flat: revert "binfmt_flat: don't offset=
=0A=
>>>> the data start"") restored offsetting the start of the data section by=
=0A=
>>>> a number of words defined by MAX_SHARED_LIBS. As a result, since=0A=
>>>> MAX_SHARED_LIBS is never 0, a gap between the text and data sections=
=0A=
>>>> always exists. For architectures which cannot support a such gap=0A=
>>>> between the text and data sections (e.g. riscv nommu), flat binary=0A=
>>>> programs cannot be executed.=0A=
>>>>=0A=
>>>> To allow an architecture to request contiguous text and data sections,=
=0A=
>>>> introduce the config option CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP.=0A=
>>>> Using this new option, the macro DATA_GAP_WORDS is conditionally=0A=
>>>> defined in binfmt_flat.c to MAX_SHARED_LIBS for architectures=0A=
>>>> tolerating the text-to-data gap (CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP=
=0A=
>>>> disabled case) and to 0 when CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP is=0A=
>>>> enabled. DATA_GAP_WORDS is used in load_flat_file() to calculate the=
=0A=
>>>> data section length and start position.=0A=
>>>>=0A=
>>>> An architecture enabling CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP also=0A=
>>>> prevents the use of the separate text/data load case (when the flat fi=
le=0A=
>>>> header flags FLAT_FLAG_RAM and FLAT_FLAG_GZIP are not set with NOMMU=
=0A=
>>>> kernels) and forces the use of a single RAM region for loading=0A=
>>>> (equivalent to FLAT_FLAG_RAM being set).=0A=
>>>=0A=
>>> So is it the case that a flat format file on RISC-V will never have=0A=
>>> relocations?=0A=
>>=0A=
>> No, it does have relocations. But there is no entry for the global point=
er=0A=
>> (__global_pointer$) location. This is because the loading of that value =
in the=0A=
>> gp register in the C-library crt1.S is done using a PC-relative instruct=
ion. The=0A=
>> value for it is resolved at compile time and does not get a relocation t=
able=0A=
>> entry. Other functions calls and symbol references do have relocation ta=
ble=0A=
>> entries, so the binary can be loaded anywhere. The missing relocation fo=
r the=0A=
>> global pointer mandates that text and data be loaded at the same positio=
ns=0A=
>> relative to each other that the linker file defines. Otherwise, loading =
of=0A=
>> __global_pointer$ into the gp register (first thing that C libraries crt=
1.S do)=0A=
>> result in a garbage value being loaded.=0A=
>>=0A=
>> I tried some tricks with the linker file and changing uclibc crt1.S to h=
ave the=0A=
>> gp loading done using a symbol address instead of a PC-relative offset. =
I could=0A=
>> then see a relocation table entry for that symbol. That still did not wo=
rk as I=0A=
>> was probably doing something wrong. Anyway, such solution requires chang=
ing a=0A=
>> lot of things in C libraries loading assembler that is common between NO=
MMU and=0A=
>> MMU code. Changing it would break MMU enabled programs.=0A=
>>=0A=
>>=0A=
>>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>>>> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>=0A=
>>>> ---=0A=
>>>>    fs/Kconfig.binfmt |  3 +++=0A=
>>>>    fs/binfmt_flat.c  | 21 +++++++++++++++------=0A=
>>>>    2 files changed, 18 insertions(+), 6 deletions(-)=0A=
>>>>=0A=
>>>> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt=0A=
>>>> index c6f1c8c1934e..c6df931d5d45 100644=0A=
>>>> --- a/fs/Kconfig.binfmt=0A=
>>>> +++ b/fs/Kconfig.binfmt=0A=
>>>> @@ -112,6 +112,9 @@ config BINFMT_FLAT_ARGVP_ENVP_ON_STACK=0A=
>>>>    config BINFMT_FLAT_OLD_ALWAYS_RAM=0A=
>>>>    	bool=0A=
>>>>    =0A=
>>>> +config BINFMT_FLAT_NO_TEXT_DATA_GAP=0A=
>>>> +	bool=0A=
>>>> +=0A=
>>>>    config BINFMT_FLAT_OLD=0A=
>>>>    	bool "Enable support for very old legacy flat binaries"=0A=
>>>>    	depends on BINFMT_FLAT=0A=
>>>> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c=0A=
>>>> index b9c658e0548e..2be29bb964b8 100644=0A=
>>>> --- a/fs/binfmt_flat.c=0A=
>>>> +++ b/fs/binfmt_flat.c=0A=
>>>> @@ -74,6 +74,12 @@=0A=
>>>>    #define	MAX_SHARED_LIBS			(1)=0A=
>>>>    #endif=0A=
>>>>    =0A=
>>>> +#ifdef CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP=0A=
>>>> +#define DATA_GAP_WORDS			(0)=0A=
>>>> +#else=0A=
>>>> +#define DATA_GAP_WORDS			(MAX_SHARED_LIBS)=0A=
>>>> +#endif=0A=
>>>> +>   struct lib_info {=0A=
>>>>    	struct {=0A=
>>>>    		unsigned long start_code;		/* Start of text segment */=0A=
>>>> @@ -559,7 +565,10 @@ static int load_flat_file(struct linux_binprm *bp=
rm,=0A=
>>>>    	 * case,  and then the fully copied to RAM case which lumps=0A=
>>>>    	 * it all together.=0A=
>>>>    	 */=0A=
>>>> -	if (!IS_ENABLED(CONFIG_MMU) && !(flags & (FLAT_FLAG_RAM|FLAT_FLAG_GZ=
IP))) {=0A=
>>>> +	if (!IS_ENABLED(CONFIG_MMU) &&=0A=
>>>> +	    !IS_ENABLED(CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP) &&=0A=
>>>=0A=
>>> If RISC-V flat format files must always be loaded to RAM then why don't=
=0A=
>>> they set the FLAT_FLAG_RAM when compiled/generated?=0A=
>>=0A=
>> That is done. The patch I have for elf2flt sets it. Coding it like this =
here is=0A=
>> I think safer (whatever the userspace toolchain did, the kernel assumes=
=0A=
>> FLAT_FLAG_RAM). And it also has the nice side effect to suppress the fir=
st part=0A=
>> of the if () in the final binary. Smaller code size :)=0A=
> =0A=
> My concern here is that CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GA being=0A=
> enabled doesn't just in itself mean you need to force a RAM load.=0A=
> It is just in the RISC-V case it currently does.=0A=
=0A=
Good point.=0A=
=0A=
> =0A=
> And it may change in the future. The considerable RAM savings=0A=
> you get from supporting a separate data segment to code segment=0A=
> means there is motivation to create tooling and code generation=0A=
> to support it.=0A=
=0A=
Totally agree here. And I did try hard to get it to work...=0A=
=0A=
> =0A=
> I don't feel that strongly about it, but this code is obtuse enough alrea=
dy.=0A=
> No need to make it worse if we don't have too.=0A=
=0A=
I see your point. I will remove that=0A=
!IS_ENABLED(CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP) from the top if() conditio=
n.=0A=
Without it, fixing the toolchain etc will indeed not require patching again=
 the=0A=
kernel. Sending a v4.=0A=
=0A=
> =0A=
> Regards=0A=
> Greg=0A=
> =0A=
> =0A=
> =0A=
>>>> +	    !(flags & (FLAT_FLAG_RAM|FLAT_FLAG_GZIP))) {=0A=
>>>> +=0A=
>>>>    		/*=0A=
>>>>    		 * this should give us a ROM ptr,  but if it doesn't we don't=0A=
>>>>    		 * really care=0A=
>>>> @@ -576,7 +585,7 @@ static int load_flat_file(struct linux_binprm *bpr=
m,=0A=
>>>>    			goto err;=0A=
>>>>    		}=0A=
>>>>    =0A=
>>>> -		len =3D data_len + extra + MAX_SHARED_LIBS * sizeof(unsigned long);=
=0A=
>>>> +		len =3D data_len + extra + DATA_GAP_WORDS * sizeof(unsigned long);=
=0A=
>>>>    		len =3D PAGE_ALIGN(len);=0A=
>>>>    		realdatastart =3D vm_mmap(NULL, 0, len,=0A=
>>>>    			PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE, 0);=0A=
>>>> @@ -591,7 +600,7 @@ static int load_flat_file(struct linux_binprm *bpr=
m,=0A=
>>>>    			goto err;=0A=
>>>>    		}=0A=
>>>>    		datapos =3D ALIGN(realdatastart +=0A=
>>>> -				MAX_SHARED_LIBS * sizeof(unsigned long),=0A=
>>>> +				DATA_GAP_WORDS * sizeof(unsigned long),=0A=
>>>>    				FLAT_DATA_ALIGN);=0A=
>>>>    =0A=
>>>>    		pr_debug("Allocated data+bss+stack (%u bytes): %lx\n",=0A=
>>>> @@ -622,7 +631,7 @@ static int load_flat_file(struct linux_binprm *bpr=
m,=0A=
>>>>    		memp_size =3D len;=0A=
>>>>    	} else {=0A=
>>>>    =0A=
>>>> -		len =3D text_len + data_len + extra + MAX_SHARED_LIBS * sizeof(u32)=
;=0A=
>>>> +		len =3D text_len + data_len + extra + DATA_GAP_WORDS * sizeof(u32);=
=0A=
>>>>    		len =3D PAGE_ALIGN(len);=0A=
>>>>    		textpos =3D vm_mmap(NULL, 0, len,=0A=
>>>>    			PROT_READ | PROT_EXEC | PROT_WRITE, MAP_PRIVATE, 0);=0A=
>>>> @@ -638,7 +647,7 @@ static int load_flat_file(struct linux_binprm *bpr=
m,=0A=
>>>>    =0A=
>>>>    		realdatastart =3D textpos + ntohl(hdr->data_start);=0A=
>>>>    		datapos =3D ALIGN(realdatastart +=0A=
>>>> -				MAX_SHARED_LIBS * sizeof(u32),=0A=
>>>> +				DATA_GAP_WORDS * sizeof(u32),=0A=
>>>>    				FLAT_DATA_ALIGN);=0A=
>>>>    =0A=
>>>>    		reloc =3D (__be32 __user *)=0A=
>>>> @@ -714,7 +723,7 @@ static int load_flat_file(struct linux_binprm *bpr=
m,=0A=
>>>>    			ret =3D result;=0A=
>>>>    			pr_err("Unable to read code+data+bss, errno %d\n", ret);=0A=
>>>>    			vm_munmap(textpos, text_len + data_len + extra +=0A=
>>>> -				MAX_SHARED_LIBS * sizeof(u32));=0A=
>>>> +				  DATA_GAP_WORDS * sizeof(u32));=0A=
>>>>    			goto err;=0A=
>>>>    		}=0A=
>>>>    	}=0A=
>>>>=0A=
>>>=0A=
>>=0A=
>>=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
