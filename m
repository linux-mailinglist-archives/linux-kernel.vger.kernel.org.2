Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A52B36F4C6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 06:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhD3EH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 00:07:27 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:50657 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhD3EH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 00:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619755599; x=1651291599;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IQ80bnySfRXRxuU2drtO5GtuaETmfXcSvBFM+5EXFlI=;
  b=hgRgjKRL6eX1mRxhVYPuCsNRVMOYBDd/qbVKP3C6res8bMslD7htJ+j4
   hQXjU/Z4qWKxBkjR/pUnnPRP2cZj/8b1SwUxxvjpJiy/8yk2s43RBfT2Z
   JLSie08peydg9GOzTG4a7dYUWJjEfdBlP/gq82D0Q0DSlwRjUYQd8Nrvx
   zbqN78o995EFepRWtxjC14TZWoNJSrjUujdGxpE91nYBd1wx+8IEpIypG
   ksdBelR9oxsGfYJm5krbQ3aCJ1qY1JYJe51vWXx2QqZfmkcp+AObu6ai4
   UPg8Mp3tthWGTtpFt+2ouzvHWYfgAgUPWMp4NBC1+wIL4Ae1SLG+V0aC2
   A==;
IronPort-SDR: YkmvJBfVQsvNz20PVO73+wOnctsN7Ft0FDPGHOeLrHxKqpP9TUaYoV8lHNiviuscxd7E3q0eI2
 xKfB67zb+pxseQGQjzHGFqvrqfn9NAxBhp30MT5Iuh8pa5q4fnRQF+hZHDl6uYEhhIzz90BKAA
 L0RWjFCSyd64ETFJZDSOzKCDpM+5XkmUamE7zacFXmn2OuOioyPVOqPJ7LV9or4fAIRzUB9IZx
 Sliv144dRRaGaPl0nMuNFEw7tM1Ng49HXIUHYiyv2lUuy47GVMSdcg2k0un5yY0jWF+FxyJU08
 CPY=
X-IronPort-AV: E=Sophos;i="5.82,260,1613404800"; 
   d="scan'208";a="166089312"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2021 12:06:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAT4ivY/u9GNoknAQyWLWhzLJqhF3aTzrCClkr/o3FMMMJaP2mycMKhdT5HMWwtBmRtu93vdjELHp7uenb7zxHycKw6s7YON9Uxs89HB0O8Qh9UGO3ia+2zOBPoMpAnOfl8forSkAAlS9s7p5rbHMXcTpJhl4QzLwFFbNC9gEXbMuF2+P6at7/g0vwThZwnP8QWO9HLeJuNbJ5tUlGU7NeWk6kWcEVZYgszacxW7ALdlAvg/aK7pNhcQaLD1fIHYnM8qtxuR3TocowUwMEI/HFoUkwPod1O4KMNGmomR3urcFi8UIJvKl6RH3aTooDfkc6wHYfdmmZ87XyLD6Ua4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UafV2C2oXFHtqbhHQOdN+0VKmOnk+l6Whuq3Qmcn8G4=;
 b=QP3UWvzNrKP78stD3N/1v7CucurupV5pdSEN7+DhaeCqO41l2svZ9B1LNyYGKHr2iUvuXsqdPl5MX6CH9bCHkZfze4xqL6JO6+vgA7AIHk9EXSiXrY+B0eSpB8XE6AR3Bla9ERhoIPfRwUjGPSHUxwR5lY8F3/tJu/pdRxuK1JZa9pYscDUhR3qA4Zug7qzDpJdyCUaG2gZ3h+BmVgeQ9e0Jc80FJcN858XA0FmmKQ44KjXuWqE38NwhU23gPXqd3Ab++SrOz45RhmBaLAVPA4DnNVaxVJHKRl6CSq9loNNYMhtWBFOXm8H0MwtMTonda+UNkD14vCEL9KCPrqkH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UafV2C2oXFHtqbhHQOdN+0VKmOnk+l6Whuq3Qmcn8G4=;
 b=og9YOKz+lHEdpwQaHCIR2UXq2zrdpLak7YzNV1sa51mYtGU8hIPhGlIOo/WbW7wcj9S07I7kxChb8pLG4bnNA1I3DCjlp67iskj1y5DeNcUsGmwiHjrbB5IawVnvnn+PGEvbkc4hK8w7STQtFBh2S6aUhNJUwy8GLgSnWwKvHzc=
Received: from MN2PR04MB6207.namprd04.prod.outlook.com (2603:10b6:208:de::32)
 by MN2PR04MB6029.namprd04.prod.outlook.com (2603:10b6:208:da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Fri, 30 Apr
 2021 04:06:35 +0000
Received: from MN2PR04MB6207.namprd04.prod.outlook.com
 ([fe80::2cff:8019:a3d5:3755]) by MN2PR04MB6207.namprd04.prod.outlook.com
 ([fe80::2cff:8019:a3d5:3755%6]) with mapi id 15.20.4087.035; Fri, 30 Apr 2021
 04:06:35 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Changbin Du <changbin.du@gmail.com>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jbaron@akamai.com" <jbaron@akamai.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "zong.li@sifive.com" <zong.li@sifive.com>,
        "guoren@linux.alibaba.com" <guoren@linux.alibaba.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "chenhuang5@huawei.com" <chenhuang5@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: RE: [PATCH] RISC-V: insn: Use a raw spinlock to protect TEXT_POKE*
Thread-Topic: [PATCH] RISC-V: insn: Use a raw spinlock to protect TEXT_POKE*
Thread-Index: AQHXPL+/nC0TgFS8Ak2mo06nM8KQNarLsFWAgABauoCAAFHTAIAAFTAg
Date:   Fri, 30 Apr 2021 04:06:35 +0000
Message-ID: <MN2PR04MB6207E102997326E6513416AB8D5E9@MN2PR04MB6207.namprd04.prod.outlook.com>
References: <20210429061713.783628-1-palmer@dabbelt.com>
        <20210429123007.5144fc0d@gandalf.local.home>
        <20210429215451.yuey5gzmfh2dkzp5@mail.google.com>
 <20210429224742.391154ae@oasis.local.home>
In-Reply-To: <20210429224742.391154ae@oasis.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [122.171.168.110]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b47abb9-a9b2-4302-25ae-08d90b8d58e1
x-ms-traffictypediagnostic: MN2PR04MB6029:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB60296723571BF766C75A30038D5E9@MN2PR04MB6029.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6CAxK1R/SxWq1qDCU0jsRjziKpSnhbcTQ7qq0Mur4vGzNPjz3rapV9l1h9Hpe0OCYLgFFTsUKQWhOBmgUoVbT5fmmxDnGMKXO/klznKud3q4JWujOtfqDW9NUu/XFYD0cFf8ioF1OVsZbOWCsuHTo61pNM+iL/woTVMWuWGumpdBVsrkn3gfqyoYiQpl/TYwx8sci0PiwyrZpQwyMgw1r29R6csgCaA1sU3pajOOK/Lj8LgtH/UwDQ5tZL5svlANWS1D92Oq/wOzecTWEy3Wi0M5Cln+IcGKHq0Z9+Uiz2gMd8Ht5ugQZ3E8aMtRaxgUzCCF0kwPGCy3D/ctDDS0eJT2zEq8upmLhTaaOcbq1cdK+9AhKmlzcg0NyTcwcBZmkeV+ZVJf7xHGFLpCDaQJRV9ccKP0nJoOzk5ZBdpSo7utIHT0407nESrQbqBCiOhIBfL9z/oO5nL1nBfuSlUbhH6EGQFonjklGixuPqLNp4WGjtNKna/QYyn54l5cYzH5d78ViYXaG61JHJteYqMNO4U0pUmfpvAMrslMhr5huopGDBQDx9s9IwPMP5jCDiLMQ2vTa7bS8xQDXpV1JJILuF+JglXBtUP2DTnQ3aKZnAeSq510TVysmJenqXRfZXUt2vEvGK3OyhvZAQUQdgq4b2RzlqvRg/zTi7EJsUqku9ThJIBvBN2OlNXIXLNo2dcS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6207.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(52536014)(316002)(7696005)(8936002)(122000001)(71200400001)(33656002)(66946007)(7416002)(8676002)(186003)(38100700002)(2906002)(83380400001)(55016002)(64756008)(4326008)(6506007)(26005)(53546011)(86362001)(5660300002)(76116006)(966005)(66446008)(54906003)(9686003)(66476007)(66556008)(478600001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cpOfDgzkJEOfIg8xLzvzystDsI6N3M0tqB9+dIVre+bius3KCXWor5h4uVpn?=
 =?us-ascii?Q?wBg3IhF1imVV+4vIfDUCick1/+snshxZzOvi3v0XYB6sqNeMvPGRr0r/k/DE?=
 =?us-ascii?Q?igKMAL1Z/aoh+Z4P8PoQBQue+O+UuRZ8l/JHOGtNglbgTZMiH7mVgI0oXReE?=
 =?us-ascii?Q?lCmWIwn6g8bPXEInq9f3uIPLmrQxVSxqu2+jM9WrjGFPYRXXp/Dsm5j7Qh1A?=
 =?us-ascii?Q?6RBJXZdM6DCnUJlMkhGL8iAkLONO6ONeTRLRpRp4f+q1gtU02aELEDbvYn/b?=
 =?us-ascii?Q?vgDA+EDjj+UPGkt7dLuY+V9YBxD2xjd4+DvUklT5S8RObjkND79XrOvVF9CU?=
 =?us-ascii?Q?fVXelFwaB4eIX1DUWsA3XVoyG6sTZ0bYb0qtpj0rAYx9xTbE48Th852qhoUB?=
 =?us-ascii?Q?RS7ERpLIxz/duxOK+ptHvFwQgYaWL0a66g2IsMBBcrlBNrZLyfetU23h+KiX?=
 =?us-ascii?Q?bnd4BRfVfE8vilqU+QYjK/RFJQ8a2xLxgsTIT0eMXDP3Lr6T0AuejQSbZQF2?=
 =?us-ascii?Q?RfYALPFMeygxh4hBoWkhv6MUhF468DS51C/0YztiFEDswc7zIoyAaDF3B3p9?=
 =?us-ascii?Q?FlA46wLeWRnO2ECCNMhaAP3zsICTp1yYGRCsyBqQ0LVP9u6xb78+3vzKGvqx?=
 =?us-ascii?Q?GnM6i8ufWlAwlL2pKoLzyUB/ZAlFW6YM/vbEjjUc0sgv6bd9mohSY+CSjLxz?=
 =?us-ascii?Q?scxycKj7EQ8Syg8hhV0WQqzQw1nImDP6pkBIrIzzH3KdjGlhSy82QaIvIcz9?=
 =?us-ascii?Q?Br1iDaeCIRBCueGrmDb9cHGha/crYNvCiH/RXUh6zP34mbEE3WMxmTkmcq+B?=
 =?us-ascii?Q?Wy80h28bUja4v3RRAD2bIzC8OMkgaRPIfMFfJPd+7zaIZh/jCZHAhW7UF0Fn?=
 =?us-ascii?Q?JzdmeUszf+QDWDJEhE9UFaAoPcYTYnCS9a+GErWELraklyuqRnXWYrNhe2H/?=
 =?us-ascii?Q?HaE1J5jinanpof1dbVIBmPwYUBC+3kXZM+HmrevTX1kUYPNPGmwG9wvDrX3T?=
 =?us-ascii?Q?/m6YqIiM9EX4osbeLeTO0uYIZsnoetVj8ds+wwcilIb/kDnXS5s/mNRD2gVa?=
 =?us-ascii?Q?yvwODOjtouEzznL5orSB14O83vn+tWw1g729kW/pWoBgkRrf2RKaBrKM81Vb?=
 =?us-ascii?Q?njg4Jxc1BjbJ8vHjbOB25zUABSlzG3OBiVUPoj37uYtiobJHsVWCvplANAd7?=
 =?us-ascii?Q?ABYzNNB20TMiKMdGP5shQRQJmtyNcHtUl+QZOjjxXlkCGH20gdrlNS1wsj2f?=
 =?us-ascii?Q?Fv3v6zKGP725qSAaxf0ankbB7d/+ogtoIwsRXNzD+67PkJIzszOIb4xVRHdz?=
 =?us-ascii?Q?CwhvuSc0FTzIwY7U38v1VBXV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6207.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b47abb9-a9b2-4302-25ae-08d90b8d58e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2021 04:06:35.6261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i3c+Zpe0JPZe8yurn3Xw4gvi0K8RHDKY1ULupxzl3G5fFL1OEuyOnc1uxQVff6b3P7z0HcLRmgxyn3GNX4pBgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6029
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Steven Rostedt <rostedt@goodmis.org>
> Sent: 30 April 2021 08:18
> To: Changbin Du <changbin.du@gmail.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>; linux-riscv@lists.infradead.org;
> Paul Walmsley <paul.walmsley@sifive.com>; aou@eecs.berkeley.edu;
> peterz@infradead.org; jpoimboe@redhat.com; jbaron@akamai.com;
> ardb@kernel.org; Atish Patra <Atish.Patra@wdc.com>; Anup Patel
> <Anup.Patel@wdc.com>; akpm@linux-foundation.org; rppt@kernel.org;
> mhiramat@kernel.org; zong.li@sifive.com; guoren@linux.alibaba.com;
> wangkefeng.wang@huawei.com; 0x7f454c46@gmail.com;
> chenhuang5@huawei.com; linux-kernel@vger.kernel.org; kernel-
> team@android.com; Palmer Dabbelt <palmerdabbelt@google.com>
> Subject: Re: [PATCH] RISC-V: insn: Use a raw spinlock to protect TEXT_POK=
E*
>=20
> On Fri, 30 Apr 2021 05:54:51 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
>=20
> > The problem is that lockdep cannot handle locks across tasks since we
> > use stopmachine to patch code for risc-v. So there's a false positive r=
eport.
> > See privious disscussion here
>=20
> > https://lkml.org/lkml/2021/4/29/63
>=20
> Please use lore.kernel.org, lkml.org is highly unreliable, and is conside=
red
> deprecated for use of referencing linux kernel archives.
>=20
> Would the following patch work?

This patch only takes care of ftrace path.

The RISC-V instruction patching is used by RISC-V jump label implementation
as well and will called from various critical parts of core kernel.

The RAW spinlock approach allows same instruction patching to be used
for kprobes, ftrace, and jump label.

Regards,
Anup

>=20
> (note, I did not even compile test it)
>=20
> -- Steve
>=20
> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftr=
ace.h
> index 845002cc2e57..19acbb4aaeff 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -25,6 +25,8 @@ struct dyn_arch_ftrace {  };  #endif
>=20
> +extern int running_ftrace;
> +
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  /*
>   * A general call in RISC-V is a pair of insts:
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c inde=
x
> 7f1e5203de88..834ab4fad637 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -11,15 +11,19 @@
>  #include <asm/cacheflush.h>
>  #include <asm/patch.h>
>=20
> +int running_ftrace;
> +
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  int ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)  {
>  	mutex_lock(&text_mutex);
> +	running_ftrace =3D 1;
>  	return 0;
>  }
>=20
>  int ftrace_arch_code_modify_post_process(void) __releases(&text_mutex)
> {
> +	running_ftrace =3D 0;
>  	mutex_unlock(&text_mutex);
>  	return 0;
>  }
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c index
> 0b552873a577..4cd1c79a9689 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -12,6 +12,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/fixmap.h>
>  #include <asm/patch.h>
> +#include <asm/ftrace.h>
>=20
>  struct patch_insn {
>  	void *addr;
> @@ -59,8 +60,13 @@ static int patch_insn_write(void *addr, const void
> *insn, size_t len)
>  	 * Before reaching here, it was expected to lock the text_mutex
>  	 * already, so we don't need to give another lock here and could
>  	 * ensure that it was safe between each cores.
> +	 *
> +	 * ftrace uses stop machine, and even though the text_mutex is
> +	 * held, the stop machine task that calls this function will not
> +	 * be the owner.
>  	 */
> -	lockdep_assert_held(&text_mutex);
> +	if (!running_ftrace)
> +		lockdep_assert_held(&text_mutex);
>=20
>  	if (across_pages)
>  		patch_map(addr + len, FIX_TEXT_POKE1);
