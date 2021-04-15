Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87B9361612
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 01:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbhDOXWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 19:22:32 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3468 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbhDOXWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 19:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618528927; x=1650064927;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=yAROk7jArod9m2aZ9ZS2QwsszOal9UgOxl2Ftk4+k8Q=;
  b=TQSyNhPaNF/JwRxeEDmr2SdzhpAUGTOPZQX26PKEe90EIhAp28uJbjDl
   oZMZBtyzIn7GC5hhQHH4AO3qLwXSZO44S4w2HpINSCvLrI3AbQjwtvJ8e
   +yzuSj25c4RjhPln9fl++0aJqiKw/tYciBbx5OhYr/WuooYXG+we0yA4A
   nbV0lt1JoZq4pR9n+2z3N19c2YgC5GNsLh96xywOEgGXOOYUJggEW/QT5
   wlBM7ID0uWdSuKvpHr7RYxw8y4SlOlvPMveCA5aw1amCSpRfIegPXTMzA
   uymRAZW25bazu31Ldu/UZr7iOihfuexIkCp7UJJXHTnsnr2UfKJQ7lg8O
   g==;
IronPort-SDR: d35N0lk8nGiQYTfChzo9vYRbAiqA2SXxNODMdAdTzTwxEuvope2JVJP++kM0k0S4N77+1VZk9e
 nlLQt2LpLKClIsmhdZZaPneC9OoCdHXRIyUO8GRDV1VXkxN5/F8ol3AInU+lrOipRdVWC2jL9R
 XNF6GPr1z5A5KeJ+4453RG1C+loh96BzZgQwsaMg32T7MixpoiVZYIMVo1DwkokME2K1QKYizA
 3BBYcJhHLA0Bld8TlyUI+sNm9KRt5jiX/eGK6nV7h+bVtdVsJnFv82ZJnxZyHXik+gZs+X5/0N
 kHs=
X-IronPort-AV: E=Sophos;i="5.82,226,1613404800"; 
   d="scan'208";a="169527945"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2021 07:22:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mC3GNkllqt6TcumjNvI7tPyU+i3NKb+/wleozmbjh25pPJ4k7UbV8pyQrMadIJxlFvBePN/N4FzhCW2XMUVEkESQsDjLYLz8LUxARFnmo7imgTDCah3VP4XeuWEb1A6Duu40l/AAf2aPNwjA2vyxX4T60N76M3Qn3vYV6ZAQ6QYAD933NZL5sFpevFMfTuIOY37B/IVbnPQ107JS/gWTX2esKt+JPww0UF2Ico92Ri+gvgGAUMvRIqgRMui3FMhUArxjx7cI7DLA4TBTebt1BLB90osR3px0+vdjFsEPwxVAAhJ8bVhclmYGIlv1KM4+YIHccJEWkLNBfwtZzkggLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ep6ifwEIIDQcEfOUM8rwAxmITsAXM2zkdW4+aKWg5EQ=;
 b=PZyL+X8npkbNYQPfp6b11X4KxD9tPynpIyOlfFtJoZGnADkg4ge8anpzXAu2aML3rVt9VrHAFBaiqZgNef2f9Iwjl9FY+xxZPBQjrlteGhs/3ajPNXQddFEwsP9Nz6ILyW+dUOUV5VX/f34IAW12DKzdt42G+52kPMsRec9kBWcrzmt/B+H2V4ddOlH0SqPePxnesRG6BxzOUmOaQg+GpnM3bEVVH/HuUtAmv5wdUmNulYqmtiZloYe+sUhiEse3ZCGyeBAm/7pmJFQ0Rca+X9blTzqYNwyXwyt/puzxp5Oo55GiAPIYBYh62sZF6MTgg2bdGUo+SiFGHCylcwMxvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ep6ifwEIIDQcEfOUM8rwAxmITsAXM2zkdW4+aKWg5EQ=;
 b=bjtWeuvgqiUDognVA9HqgHpa0WRBtq21m51/7hEjzuI7pFydIEPtSUkzfwtHc/bnQbKDJN1w/Virk6mFChsgiNzHU1NEt8aw3xYM3phyOm/vZx14CXoOoJ24crd34M+jvg5J1KuQZPxC4qrwh4BoWj/MCnx2dgl0jwnwTOpJ74w=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4916.namprd04.prod.outlook.com (2603:10b6:208:58::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Thu, 15 Apr
 2021 23:22:02 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4042.016; Thu, 15 Apr 2021
 23:22:02 +0000
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
Date:   Thu, 15 Apr 2021 23:22:02 +0000
Message-ID: <BL0PR04MB6514D6C35731EA1CA581095EE74D9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210415061502.7248-1-damien.lemoal@wdc.com>
 <20210415061502.7248-2-damien.lemoal@wdc.com>
 <8ff801ad-6e17-fdd2-6186-5443540947a9@linux-m68k.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:c420:851d:e64f:2199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfa1a36b-bdc0-428a-e616-08d9006546af
x-ms-traffictypediagnostic: BL0PR04MB4916:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4916D4BE41A3116F8453DDCFE74D9@BL0PR04MB4916.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FEyMIMEZ99ElGAezxoBg5h3wtQ24mjWYNXGuUEh0FPEmJmNb9vKfTgIO0D0F67JFpTGgxj/8RWFYWtj/6KPhEGEvm0ct8QjmEiLksbWRXgiJBWDXauAaRdvA4PbjZFmbGwUUiHL4amYGLk882XLEVJ/IipcMfSRGYcLW+SFbudm8f37uZbumxTYqd0EUI2rrEcNRdZSmG/rtuJcqyrDd58avfxJMCE73kIhAyKQj4NNfeGEzQp7VMlucrk4Tj2gju1cUU0DQTTh39E1B5/7KE7GaBF0PQd9qJu1cnEBPlqGBj+G5ng1nTz6mgOdZpbwgzltNAIVirb549C9v+69BS5In6YBXM44BUAVFKPoIrKdQ58CJlUV7wlwsoXYMN4wdO3VSsvWdJF94s6jNK7VGde3rdj8KzFFC/YVP+dimyCEG4I0ZQ5tDxbs1q8MbKf4XzNq0L65991O3ByTWD+W7TXECCeM7hh/GynjGdKAR1WvP4fTIT/YUMERAP4K4Y5mFnnkejhFs+oS+2ihljUCmxnAvPPMC4dVbzYCrkTwd9Zks/2qxZNqDmy5pcRRLFkxwkRrf34yv+MsdD04dlF0k/LAQyKmWo5JZ0im+MXlnJW0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(52536014)(9686003)(2906002)(55016002)(54906003)(122000001)(71200400001)(8676002)(64756008)(66556008)(66476007)(91956017)(76116006)(478600001)(66446008)(66946007)(110136005)(316002)(8936002)(53546011)(83380400001)(5660300002)(6506007)(33656002)(86362001)(4326008)(7696005)(38100700002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NPeGZcfu1RwFyjNtVNCs7yPvD46AFh0t/qcEcOS+fHbvmj1VLKWAP5Vjf4qk?=
 =?us-ascii?Q?ChLee9JDQRZsxn9N4zm9gnykKo58UaFWVgvhkgkehQcAHY78e3akdH4WDt/B?=
 =?us-ascii?Q?5FI37BikMvflnPTBqqTf1aFmRMFYlgyDotk1MiyoSA3GSJaS+JNUsXr3dw6s?=
 =?us-ascii?Q?b34rShLEtgGbdsxPBFmn3bdOAq5gHlx13TDdLTC5pBengh1yz7HLNqqv9NmB?=
 =?us-ascii?Q?VqTGfujyb8+g+9IQ7TT6kzHNnLDmBMrDWORSssfXY6uxwq138EER/ti0jKJL?=
 =?us-ascii?Q?Y4oMNoHtP6uIGhyCexlqbwVVzI9XNFEBw5BFjLnAd29FqIPwfAAP/n6BzLwR?=
 =?us-ascii?Q?ieVQqK0J3YSTRkw2JaQfOYa4zbddU85dPHteiEVyaELTF/DZTQ5BfDo+l0NE?=
 =?us-ascii?Q?VBkqvcHDRHLXGkGi1QioA8Kp/r18NyzcAQ3Rm451oLGgMWNHd4x2nlx+XTgs?=
 =?us-ascii?Q?/ENe9SKRGTgXpURr/0KDtld9+2PdItQOGqhPbfBbbfY8sfTz9GUYPc4LqHzH?=
 =?us-ascii?Q?goBMQes371Pns5QKeWlBCwWOntgeSReyiYD6+wO2ruQvLitn/PuWEnBxPd90?=
 =?us-ascii?Q?A//JuMkyTnl894E/5so2Lg+iMwsxClxKiy3bY3jBnNxrvFFXN9CogB/9ey2s?=
 =?us-ascii?Q?LCrQvsGQvuqFhi8F50FPyJQSesNSNI9icwJusow2ZFMA0dzKcuy2lqB6NXLX?=
 =?us-ascii?Q?PlE+JDeoCbMd82lfe6tGIA9QgCPfQIRk0g9N8HaRAwht0Ex92Xj5Bg+7uDlJ?=
 =?us-ascii?Q?KgIG1AUENCe8eudDLailHTxm5PGfbM6haFaX+GYdSFW1sXcd753wxJ0wYj7m?=
 =?us-ascii?Q?XLcAABrdxJzbZXGWeKrkrSSpsNLvCE/uHnLYiXlFhOygVnyjwE35fPyVVFaY?=
 =?us-ascii?Q?1LygSYcYzuchXwL0ds395wFs6eQrJL8KUjYH/scddmPEXuiWzv5pp/+egIkS?=
 =?us-ascii?Q?0h1Ph9SMLRF0rCdMESGyhDMXGlywVTnQoa4JF/h4iF+DVXJ4OCrXw0mWYv7m?=
 =?us-ascii?Q?cQJYwbtH9OJPJ/XsUMBU1QJPS31B8r+ytqthU2s06q0I7TZsw0Vutu2BePo7?=
 =?us-ascii?Q?v5om87qD59DsGc1aAL4u1kKfDynN7MXViAZ23F6boN9dlSZZoJsfGYOgNxPO?=
 =?us-ascii?Q?j7lyiVsiReI74GlqkvuT4NV3o9Cg2lPyCmSicl+KWv0gIN/81XkZvZ0U04ND?=
 =?us-ascii?Q?J6W0aFCpDUxgfNen9SGoQuI2XDMjM9R+aargH4WiZIT3nftipyUYbdWWZblX?=
 =?us-ascii?Q?m1Jc8+kNwcxXcugj4SxeCsjZoOPGOYkS/zlmZhKJJgtiOHR/OS5VIuXptIjn?=
 =?us-ascii?Q?ViXC7zo/RQhl0eH6b309fDRBWbxdJ+4x2nZJ1FeqhDm2wFFSSTB+NKO2b38b?=
 =?us-ascii?Q?G4UKtmsMylPkfDwD9oczqOxQAgI7EbyMnEQIk1DzM4M8nVpQeg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa1a36b-bdc0-428a-e616-08d9006546af
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 23:22:02.5025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gxHg3st7nz6UXuNjlaWUWwA7kaVQXPwQCwSAn7tCr2uUGPFTWX6NHOsaikY80QRU+wavks2XjOcnuwMpw44klg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4916
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/04/15 23:04, Greg Ungerer wrote:=0A=
> Hi Damien,=0A=
> =0A=
> On 15/4/21 4:15 pm, Damien Le Moal wrote:=0A=
>> Commit 2217b9826246 ("binfmt_flat: revert "binfmt_flat: don't offset=0A=
>> the data start"") restored offsetting the start of the data section by=
=0A=
>> a number of words defined by MAX_SHARED_LIBS. As a result, since=0A=
>> MAX_SHARED_LIBS is never 0, a gap between the text and data sections=0A=
>> always exists. For architectures which cannot support a such gap=0A=
>> between the text and data sections (e.g. riscv nommu), flat binary=0A=
>> programs cannot be executed.=0A=
>>=0A=
>> To allow an architecture to request contiguous text and data sections,=
=0A=
>> introduce the config option CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP.=0A=
>> Using this new option, the macro DATA_GAP_WORDS is conditionally=0A=
>> defined in binfmt_flat.c to MAX_SHARED_LIBS for architectures=0A=
>> tolerating the text-to-data gap (CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP=0A=
>> disabled case) and to 0 when CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP is=0A=
>> enabled. DATA_GAP_WORDS is used in load_flat_file() to calculate the=0A=
>> data section length and start position.=0A=
>>=0A=
>> An architecture enabling CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP also=0A=
>> prevents the use of the separate text/data load case (when the flat file=
=0A=
>> header flags FLAT_FLAG_RAM and FLAT_FLAG_GZIP are not set with NOMMU=0A=
>> kernels) and forces the use of a single RAM region for loading=0A=
>> (equivalent to FLAT_FLAG_RAM being set).=0A=
> =0A=
> So is it the case that a flat format file on RISC-V will never have=0A=
> relocations?=0A=
=0A=
No, it does have relocations. But there is no entry for the global pointer=
=0A=
(__global_pointer$) location. This is because the loading of that value in =
the=0A=
gp register in the C-library crt1.S is done using a PC-relative instruction=
. The=0A=
value for it is resolved at compile time and does not get a relocation tabl=
e=0A=
entry. Other functions calls and symbol references do have relocation table=
=0A=
entries, so the binary can be loaded anywhere. The missing relocation for t=
he=0A=
global pointer mandates that text and data be loaded at the same positions=
=0A=
relative to each other that the linker file defines. Otherwise, loading of=
=0A=
__global_pointer$ into the gp register (first thing that C libraries crt1.S=
 do)=0A=
result in a garbage value being loaded.=0A=
=0A=
I tried some tricks with the linker file and changing uclibc crt1.S to have=
 the=0A=
gp loading done using a symbol address instead of a PC-relative offset. I c=
ould=0A=
then see a relocation table entry for that symbol. That still did not work =
as I=0A=
was probably doing something wrong. Anyway, such solution requires changing=
 a=0A=
lot of things in C libraries loading assembler that is common between NOMMU=
 and=0A=
MMU code. Changing it would break MMU enabled programs.=0A=
=0A=
=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>=0A=
>> ---=0A=
>>   fs/Kconfig.binfmt |  3 +++=0A=
>>   fs/binfmt_flat.c  | 21 +++++++++++++++------=0A=
>>   2 files changed, 18 insertions(+), 6 deletions(-)=0A=
>>=0A=
>> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt=0A=
>> index c6f1c8c1934e..c6df931d5d45 100644=0A=
>> --- a/fs/Kconfig.binfmt=0A=
>> +++ b/fs/Kconfig.binfmt=0A=
>> @@ -112,6 +112,9 @@ config BINFMT_FLAT_ARGVP_ENVP_ON_STACK=0A=
>>   config BINFMT_FLAT_OLD_ALWAYS_RAM=0A=
>>   	bool=0A=
>>   =0A=
>> +config BINFMT_FLAT_NO_TEXT_DATA_GAP=0A=
>> +	bool=0A=
>> +=0A=
>>   config BINFMT_FLAT_OLD=0A=
>>   	bool "Enable support for very old legacy flat binaries"=0A=
>>   	depends on BINFMT_FLAT=0A=
>> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c=0A=
>> index b9c658e0548e..2be29bb964b8 100644=0A=
>> --- a/fs/binfmt_flat.c=0A=
>> +++ b/fs/binfmt_flat.c=0A=
>> @@ -74,6 +74,12 @@=0A=
>>   #define	MAX_SHARED_LIBS			(1)=0A=
>>   #endif=0A=
>>   =0A=
>> +#ifdef CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP=0A=
>> +#define DATA_GAP_WORDS			(0)=0A=
>> +#else=0A=
>> +#define DATA_GAP_WORDS			(MAX_SHARED_LIBS)=0A=
>> +#endif=0A=
>> +>   struct lib_info {=0A=
>>   	struct {=0A=
>>   		unsigned long start_code;		/* Start of text segment */=0A=
>> @@ -559,7 +565,10 @@ static int load_flat_file(struct linux_binprm *bprm=
,=0A=
>>   	 * case,  and then the fully copied to RAM case which lumps=0A=
>>   	 * it all together.=0A=
>>   	 */=0A=
>> -	if (!IS_ENABLED(CONFIG_MMU) && !(flags & (FLAT_FLAG_RAM|FLAT_FLAG_GZIP=
))) {=0A=
>> +	if (!IS_ENABLED(CONFIG_MMU) &&=0A=
>> +	    !IS_ENABLED(CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP) &&=0A=
> =0A=
> If RISC-V flat format files must always be loaded to RAM then why don't=
=0A=
> they set the FLAT_FLAG_RAM when compiled/generated?=0A=
=0A=
That is done. The patch I have for elf2flt sets it. Coding it like this her=
e is=0A=
I think safer (whatever the userspace toolchain did, the kernel assumes=0A=
FLAT_FLAG_RAM). And it also has the nice side effect to suppress the first =
part=0A=
of the if () in the final binary. Smaller code size :)=0A=
=0A=
> =0A=
> Regards=0A=
> Greg=0A=
> =0A=
> =0A=
>> +	    !(flags & (FLAT_FLAG_RAM|FLAT_FLAG_GZIP))) {=0A=
>> +=0A=
>>   		/*=0A=
>>   		 * this should give us a ROM ptr,  but if it doesn't we don't=0A=
>>   		 * really care=0A=
>> @@ -576,7 +585,7 @@ static int load_flat_file(struct linux_binprm *bprm,=
=0A=
>>   			goto err;=0A=
>>   		}=0A=
>>   =0A=
>> -		len =3D data_len + extra + MAX_SHARED_LIBS * sizeof(unsigned long);=
=0A=
>> +		len =3D data_len + extra + DATA_GAP_WORDS * sizeof(unsigned long);=0A=
>>   		len =3D PAGE_ALIGN(len);=0A=
>>   		realdatastart =3D vm_mmap(NULL, 0, len,=0A=
>>   			PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE, 0);=0A=
>> @@ -591,7 +600,7 @@ static int load_flat_file(struct linux_binprm *bprm,=
=0A=
>>   			goto err;=0A=
>>   		}=0A=
>>   		datapos =3D ALIGN(realdatastart +=0A=
>> -				MAX_SHARED_LIBS * sizeof(unsigned long),=0A=
>> +				DATA_GAP_WORDS * sizeof(unsigned long),=0A=
>>   				FLAT_DATA_ALIGN);=0A=
>>   =0A=
>>   		pr_debug("Allocated data+bss+stack (%u bytes): %lx\n",=0A=
>> @@ -622,7 +631,7 @@ static int load_flat_file(struct linux_binprm *bprm,=
=0A=
>>   		memp_size =3D len;=0A=
>>   	} else {=0A=
>>   =0A=
>> -		len =3D text_len + data_len + extra + MAX_SHARED_LIBS * sizeof(u32);=
=0A=
>> +		len =3D text_len + data_len + extra + DATA_GAP_WORDS * sizeof(u32);=
=0A=
>>   		len =3D PAGE_ALIGN(len);=0A=
>>   		textpos =3D vm_mmap(NULL, 0, len,=0A=
>>   			PROT_READ | PROT_EXEC | PROT_WRITE, MAP_PRIVATE, 0);=0A=
>> @@ -638,7 +647,7 @@ static int load_flat_file(struct linux_binprm *bprm,=
=0A=
>>   =0A=
>>   		realdatastart =3D textpos + ntohl(hdr->data_start);=0A=
>>   		datapos =3D ALIGN(realdatastart +=0A=
>> -				MAX_SHARED_LIBS * sizeof(u32),=0A=
>> +				DATA_GAP_WORDS * sizeof(u32),=0A=
>>   				FLAT_DATA_ALIGN);=0A=
>>   =0A=
>>   		reloc =3D (__be32 __user *)=0A=
>> @@ -714,7 +723,7 @@ static int load_flat_file(struct linux_binprm *bprm,=
=0A=
>>   			ret =3D result;=0A=
>>   			pr_err("Unable to read code+data+bss, errno %d\n", ret);=0A=
>>   			vm_munmap(textpos, text_len + data_len + extra +=0A=
>> -				MAX_SHARED_LIBS * sizeof(u32));=0A=
>> +				  DATA_GAP_WORDS * sizeof(u32));=0A=
>>   			goto err;=0A=
>>   		}=0A=
>>   	}=0A=
>>=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
