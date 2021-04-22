Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855ED367FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbhDVMBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:01:13 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:37206 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbhDVMBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619092835; x=1650628835;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=jFI7cMiC4oh8Am4A9ZGZjLuorlhW4/gmKPPiybmZ5cM=;
  b=rwscUjk0nEB41U0xqLs+3RVLrikQHuNHdAFLRKX5OBNKrDUy/YWZRUHf
   Z4rT9YSrMKln3V+1LnXOXxnNAPaTnhiJMsCjDJnzgBmN6qsMzmspPQInA
   /X7S44M0qBCyQ2lvEX66Tkt7MCDWuZDhZWpaK4xQdL32MFhit71ui6ZOC
   nu1lXNzyITozYdZ4YJ+F5VHSaD5js3i/1T4T+o5sLO6hegMRNY4DeBwm1
   HBxS+rjS3SFNk4sAKawEKyhOKVN0Z/gSbjU3pJax2cpLHf26765HoLMuP
   HpU9DmqoTAypHF2xfrJz67l6bptxrYjDcjgAMD+lNuH+YeJRHY7jtbNi9
   A==;
IronPort-SDR: yVk+BXoWEKySZq9ivtuj/KdXb21/27D9Vwm6HmH3ynf0N+WYgMB0SOcqgiNu1P8NF8lmAGSFvj
 X6AW/p2bt99XOFwcANQ3ciKzSUasZOmY7SAfEHc2DW6d9V3Etdrie2vMV9Tie5IMRWNaH7lC6e
 /VfkXdM79jnuXm03u55XfbGH740M+Mj8TchuCTsRNuCfhe8vZdt7f4D0irLSm2KzVm3zkBTCtn
 wSzLldDB3TFFqU9J3A1XYS7LMG1PmemB6c3zFNysvx59IupFuXsoh2oRACWQMJEaoZ3Q93sZqQ
 5YE=
X-IronPort-AV: E=Sophos;i="5.82,242,1613404800"; 
   d="scan'208";a="170395536"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 22 Apr 2021 20:00:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCulRv/bJUkwuUWve2FALVg4w6cjCL0LWqMenHkMEcKy0FWbp/OAVvQeJivTx8tKuyCGlNk8kIB1IfYreXEAtdO20kDflDSHqiT8vy8JQq8baGaCZA9fGNvpJimCe4JhSP0MaAB+VA1O15oKMHpCOZKJOQNBE8eL4qnzAlTUOhyNCPN4uu0cW0RZulZr62NyYL8e/U7pJGwiqLmEV7C0Vp+l7NPQ/fbe+lSBLNH78K6U04eFjiyw/g/tHBb8k07zCA1qGW/PgE3BI6Wk8KPExiT17MxOfihdVXWug+/90cMx79MBPPcTsnZCIm18XNhDHchqVog/ONpXW/oEKGeywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05v0q5/pgYNB8r4vVtW0Q8jpXRo4ihV4DWNlfBVnpQI=;
 b=bhh3YbEQkxwKYLs7pEJQp7pKSCY8fj2nFTwpp1jMPm0LQHskJn7xd2skDv69/WuRmoixbPPooaeKwmOcA2rU0qOCDu7fdDJaqZv+dlTwuabdaKzmmCGbnqrSgzLtCcJFKSy0BrB3u3+1+gIQmGAolWwEFMIyyn7ujmgY7VtUB2DT4hXjoHmYv8fYMGD9g4FPmovw7bKN11w5eulKqKYgzCQL18TnE2bOfcgU9mH6ibHTwPDWhi6C/Gf/xFRS2FCm93XSFcHYhs1HM1ZRYB/yckN36xmAkkJvTC5qqcdIb1Wld7D17p2+aePU4md4JBYqly5UAR5F5jue7H+36ohecQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05v0q5/pgYNB8r4vVtW0Q8jpXRo4ihV4DWNlfBVnpQI=;
 b=r6JZQHSUs6+UmkrU/Ak9O3D3xL0gMnXqTrsd4IjFlgg8wxSGx01NVaMH6MCLmdZLafsZwtPrQkfCHIlQYztHqnCbdIgJSVTd22Kc7u66edXCZYoR/8fNsBsttfmsw0kH3q9zb5Msj3vjXvot26LARuY6OB4wr8rMHZQAoDMYqfk=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4450.namprd04.prod.outlook.com (2603:10b6:208:42::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Thu, 22 Apr
 2021 12:00:32 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4065.023; Thu, 22 Apr 2021
 12:00:32 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        "uclinux-dev@uclinux.org" <uclinux-dev@uclinux.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 1/2] binfmt_flat: allow not offsetting data start
Thread-Topic: [PATCH v4 1/2] binfmt_flat: allow not offsetting data start
Thread-Index: AQHXMyZv8axGA7lx3kGvgyyYuv6fjQ==
Date:   Thu, 22 Apr 2021 12:00:32 +0000
Message-ID: <BL0PR04MB651434FAFF5566A575FDBE76E7469@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210417011009.54569-1-damien.lemoal@wdc.com>
 <20210417011009.54569-2-damien.lemoal@wdc.com>
 <5227b984-f415-98b5-dae8-0cf84a71bb46@linux-m68k.org>
 <BL0PR04MB651453DC7A8BE4E050B11893E74B9@BL0PR04MB6514.namprd04.prod.outlook.com>
 <b83b023e-abab-35d2-22c7-5d259af2ac97@linux-m68k.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:165:d3a4:4d5e:855d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d8be2b6-81f7-429a-e24d-08d905863af9
x-ms-traffictypediagnostic: BL0PR04MB4450:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB445009DDC9D21AFD6CB3A2CCE7469@BL0PR04MB4450.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pD1XJx3ZVK9Hxh/vGYEnf4vcei1yJvPsADn2JlM2HoWFH8tI+vThbxYI0WepzNooUNKHfDn2MeOrz/JRVVSDOMJOev8hU6m3T62pf8XQdYoQSSTUSztPkgI+Q85kNBQLcvVObOeVR5Zn7zaN1/uMXjkobB4B1hJMBE/vJ8l6px+6tgCUOVNjwvqt5b7O1k+2AoxgZc1WYHxRJ53i3QN6d11zMupAKqhIRaa4zmoLJMr3zX9MYtsvAFADytyhVic9SL7ZsFseO4Bb7EDdEWgBAsI9BoBybb8pIKrR6SYrQQqWciioEoxUHS9DKRIVfpSHteIDRiYsr6rH1JfORu8AMbO5O4AebQwjz5I8sjZTRWe2hJ3BipDMXS4ghPB6RsFCQWX17GL1I6Xoo/T5Qs9OaYy18qq8hbqDqEjF0PHZprEzqUlilocPmvSewNvCwSu7jsKHWYtFk0Bx4dCA2Mn7hp810HRAZkUOctzY4NutcZWf4lRsu/idcxsqYZ+6tYR6Q0nAPJmaZj0/MbTjng747xTQ3JkSBrdmOoE9AiORtSyyzRli8ieI/onk9UaTg6JuWZXjyEYXwOw+IWqvqXx3CrGqE0BweH7a+P+TSABAoIQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(478600001)(9686003)(66446008)(71200400001)(66946007)(64756008)(66556008)(91956017)(76116006)(83380400001)(122000001)(66476007)(38100700002)(7696005)(8936002)(55016002)(8676002)(316002)(110136005)(33656002)(54906003)(53546011)(6506007)(5660300002)(186003)(4326008)(86362001)(52536014)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TXy/mODyqUBCTwd953a/XUHptywWEMGqEAnsvkOwzsnPeC42xMz8T2/9bV64?=
 =?us-ascii?Q?6sRFK49tSp1C98ZcFa6ni3MOXHUtvloP84qwEBuY3Db08bUpephbMLBZyIjn?=
 =?us-ascii?Q?x9wE0DAGSg8EZ/AWsRrcT0yhn0FCsAIyz+Jr1wihj2uY/PPveGUn4JoE0eG6?=
 =?us-ascii?Q?I8h8uDTiK/BdmJU8yPBEG0YNqYQYF2fEogvhcYesyQ1STugjNu7TbeBdi0HT?=
 =?us-ascii?Q?Ei0c9zNpjyMsAiLopWNN3MkZ+KWq77ndgNv3I2BUcs/M/CH9vxJTEMAPYecw?=
 =?us-ascii?Q?s6YVHo1Opzm5poA7WIhoS7nmulv0jsxqUlHZGh/dB4itezEt1QDN30aFLGIK?=
 =?us-ascii?Q?O5v6IiLoC7Qg++5sVoJkUxocM+01WdrfXRXFpdwQZZxcKxTQzskzriWUyHhE?=
 =?us-ascii?Q?5hfs1OghqmZ6KALS2+9gbq3Q+8nmW0ab6nETJEFCkYG7FkHS7VtgwnK75BSD?=
 =?us-ascii?Q?31AdVwaDgmBzrUmmI0oBK7aQPB+o1m7lfzrQ2La9HBSZbhYEOA12K3XASoIp?=
 =?us-ascii?Q?0vFTXHAjxFwyqYSIb8q9NN/omkpjKuOCNDbz5cV1zU7xB60foNtNx2Rp3rxS?=
 =?us-ascii?Q?qhWnqmKC6P2ZqUla1dNNyCLh5Q1br8sm4i92y2r3qfoAn5n9WETioDE5n0vV?=
 =?us-ascii?Q?1KJIPljWN3WndBZVnMtSRSST7cQVkkLW4uhu/KJ2+prY6y6geNdueaHPw92d?=
 =?us-ascii?Q?jtl99go7vf7UkSgp930ZpirDwHo6UV4oMRbum5gTkJiuss7GhxBra1O4EgIR?=
 =?us-ascii?Q?htL8PbGFOD9VBPi24PULKSd082rklzLWAY/5YdkwGt6F7tLhp3A63n89AC86?=
 =?us-ascii?Q?3oRasQZU9B5LAM2qP2HDjQl9Yt+1usnMF/+kQbxtwnrLZcnDb2SsCERz3xvW?=
 =?us-ascii?Q?RbTGNmWJ7iJpoH0g6UtrWPOsNovMt3YCFgrm8jL5imxNgTYZHmhWQrafk2O7?=
 =?us-ascii?Q?aIbkxpEycA7pVEY2jF5qN0FoYNoVPXm/5RM0AUn7geWWV1v8BblLSwUgFwVU?=
 =?us-ascii?Q?fM9avgKAABvMuBh9AIlX+bkIHmldygkNe+TaO8NAfA2W2XTJS8GP4RtfBCOJ?=
 =?us-ascii?Q?4Ty9OYXokQJ4ofP9ejfw/pKa3LVWzzofUbfwNQu6h7ad2TP2fvLdH8A2k0+B?=
 =?us-ascii?Q?5cweJ66yCaVwFlhbhk5NpoZ4xdwBMy4biF3gY+8XR7BUEvLpQn9x8LD5jguk?=
 =?us-ascii?Q?jho08VJPguDibayzK1GN/Usal6iWGW18o0bpdH0H1rt/sAo3L7HOkgCQHdEw?=
 =?us-ascii?Q?WMHK8Ocp0WH8r7eIsflaDDjiiK5OI5uV1je+Nk41u/o6QZlKBqyAW1l4NrKf?=
 =?us-ascii?Q?1SrLVnl5o7bxE1Kk87OQEdqt6ewKJ50/iqe2OjKdp0ogimtS113GvRjVtBTG?=
 =?us-ascii?Q?zc4O5fUuNoRGwZtzKikenGQ7LO8b3NR/ZfQxb41lON7MUmQGRg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8be2b6-81f7-429a-e24d-08d905863af9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 12:00:32.1921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VNM3GJJVzmopOUPONv+Sx41lKiRu87/pyfm9P1g7Ut+H76E5hWwbw+6JpqUsDmtBWkdG+z6LHhgrBeufFygZ/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4450
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/04/18 11:38, Greg Ungerer wrote:=0A=
> =0A=
> =0A=
> On 17/4/21 2:54 pm, Damien Le Moal wrote:=0A=
>> On 2021/04/17 13:52, Greg Ungerer wrote:=0A=
>>>=0A=
>>> On 17/4/21 11:10 am, Damien Le Moal wrote:=0A=
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
>>>> To allow an architecture to request no data start offset to allow for=
=0A=
>>>> contiguous text and data sections for binaries flagged with=0A=
>>>> FLAT_FLAG_RAM, introduce the new config option=0A=
>>>> CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET. Using this new option, the=0A=
>>>> macro DATA_START_OFFSET_WORDS is conditionally defined in binfmt_flat.=
c=0A=
>>>> to MAX_SHARED_LIBS for architectures tolerating or needing the data=0A=
>>>> start offset (CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET disabled case)=
=0A=
>>>> and to 0 when CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET is enabled.=0A=
>>>> DATA_START_OFFSET_WORDS is used in load_flat_file() to calculate the=
=0A=
>>>> data section length and start position.=0A=
>>>>=0A=
>>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>>>> ---=0A=
>>>>    fs/Kconfig.binfmt |  3 +++=0A=
>>>>    fs/binfmt_flat.c  | 19 ++++++++++++++-----=0A=
>>>>    2 files changed, 17 insertions(+), 5 deletions(-)=0A=
>>>>=0A=
>>>> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt=0A=
>>>> index c6f1c8c1934e..06fb7a93a1bd 100644=0A=
>>>> --- a/fs/Kconfig.binfmt=0A=
>>>> +++ b/fs/Kconfig.binfmt=0A=
>>>> @@ -112,6 +112,9 @@ config BINFMT_FLAT_ARGVP_ENVP_ON_STACK=0A=
>>>>    config BINFMT_FLAT_OLD_ALWAYS_RAM=0A=
>>>>    	bool=0A=
>>>>    =0A=
>>>> +config BINFMT_FLAT_NO_DATA_START_OFFSET=0A=
>>>> +	bool=0A=
>>>> +=0A=
>>>>    config BINFMT_FLAT_OLD=0A=
>>>>    	bool "Enable support for very old legacy flat binaries"=0A=
>>>>    	depends on BINFMT_FLAT=0A=
>>>> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c=0A=
>>>> index b9c658e0548e..1dc68dfba3e0 100644=0A=
>>>> --- a/fs/binfmt_flat.c=0A=
>>>> +++ b/fs/binfmt_flat.c=0A=
>>>> @@ -74,6 +74,12 @@=0A=
>>>>    #define	MAX_SHARED_LIBS			(1)=0A=
>>>>    #endif=0A=
>>>>    =0A=
>>>> +#ifdef CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET=0A=
>>>> +#define DATA_START_OFFSET_WORDS		(0)=0A=
>>>> +#else=0A=
>>>> +#define DATA_START_OFFSET_WORDS		(MAX_SHARED_LIBS)=0A=
>>>> +#endif=0A=
>>>> +=0A=
>>>>    struct lib_info {=0A=
>>>>    	struct {=0A=
>>>>    		unsigned long start_code;		/* Start of text segment */=0A=
>>>> @@ -560,6 +566,7 @@ static int load_flat_file(struct linux_binprm *bpr=
m,=0A=
>>>>    	 * it all together.=0A=
>>>>    	 */=0A=
>>>>    	if (!IS_ENABLED(CONFIG_MMU) && !(flags & (FLAT_FLAG_RAM|FLAT_FLAG_=
GZIP))) {=0A=
>>>> +=0A=
>>>=0A=
>>> Random white space change...=0A=
>>> Don't worry about re-spinning though, I will just edit this chunk out.=
=0A=
>>=0A=
>> Oops. Sorry about that. I should have better checked :)=0A=
>>=0A=
>>>=0A=
>>>=0A=
>>>>    		/*=0A=
>>>>    		 * this should give us a ROM ptr,  but if it doesn't we don't=0A=
>>>>    		 * really care=0A=
>>>> @@ -576,7 +583,8 @@ static int load_flat_file(struct linux_binprm *bpr=
m,=0A=
>>>>    			goto err;=0A=
>>>>    		}=0A=
>>>>    =0A=
>>>> -		len =3D data_len + extra + MAX_SHARED_LIBS * sizeof(unsigned long);=
=0A=
>>>> +		len =3D data_len + extra +=0A=
>>>> +			DATA_START_OFFSET_WORDS * sizeof(unsigned long);=0A=
>>>>    		len =3D PAGE_ALIGN(len);=0A=
>>>>    		realdatastart =3D vm_mmap(NULL, 0, len,=0A=
>>>>    			PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE, 0);=0A=
>>>> @@ -591,7 +599,7 @@ static int load_flat_file(struct linux_binprm *bpr=
m,=0A=
>>>>    			goto err;=0A=
>>>>    		}=0A=
>>>>    		datapos =3D ALIGN(realdatastart +=0A=
>>>> -				MAX_SHARED_LIBS * sizeof(unsigned long),=0A=
>>>> +				DATA_START_OFFSET_WORDS * sizeof(unsigned long),=0A=
>>>>    				FLAT_DATA_ALIGN);=0A=
>>>>    =0A=
>>>>    		pr_debug("Allocated data+bss+stack (%u bytes): %lx\n",=0A=
>>>> @@ -622,7 +630,8 @@ static int load_flat_file(struct linux_binprm *bpr=
m,=0A=
>>>>    		memp_size =3D len;=0A=
>>>>    	} else {=0A=
>>>>    =0A=
>>>> -		len =3D text_len + data_len + extra + MAX_SHARED_LIBS * sizeof(u32)=
;=0A=
>>>> +		len =3D text_len + data_len + extra +=0A=
>>>> +			DATA_START_OFFSET_WORDS * sizeof(u32);=0A=
>>>>    		len =3D PAGE_ALIGN(len);=0A=
>>>>    		textpos =3D vm_mmap(NULL, 0, len,=0A=
>>>>    			PROT_READ | PROT_EXEC | PROT_WRITE, MAP_PRIVATE, 0);=0A=
>>>> @@ -638,7 +647,7 @@ static int load_flat_file(struct linux_binprm *bpr=
m,=0A=
>>>>    =0A=
>>>>    		realdatastart =3D textpos + ntohl(hdr->data_start);=0A=
>>>>    		datapos =3D ALIGN(realdatastart +=0A=
>>>> -				MAX_SHARED_LIBS * sizeof(u32),=0A=
>>>> +				DATA_START_OFFSET_WORDS * sizeof(u32),=0A=
>>>>    				FLAT_DATA_ALIGN);=0A=
>>>>    =0A=
>>>>    		reloc =3D (__be32 __user *)=0A=
>>>> @@ -714,7 +723,7 @@ static int load_flat_file(struct linux_binprm *bpr=
m,=0A=
>>>>    			ret =3D result;=0A=
>>>>    			pr_err("Unable to read code+data+bss, errno %d\n", ret);=0A=
>>>>    			vm_munmap(textpos, text_len + data_len + extra +=0A=
>>>> -				MAX_SHARED_LIBS * sizeof(u32));=0A=
>>>> +				  DATA_START_OFFSET_WORDS * sizeof(u32));=0A=
>>>>    			goto err;=0A=
>>>>    		}=0A=
>>>>    	}=0A=
>>>>=0A=
>>>=0A=
>>> Thanks, otherwise looks good.=0A=
>>>=0A=
>>> Acked-by: Greg Ungerer <gerg@linux-m68k.org>=0A=
>>>=0A=
>>> I will push this into my m68knommu tree, for-next branch.=0A=
>>> I just carry the flat format changes in that tree now to make my life e=
asier.=0A=
>>=0A=
>> Great. Thanks !=0A=
>> Are you taking both patches or should Plamer take the riscv Kconfig chan=
ge=0A=
>> through his tree ?=0A=
> =0A=
> I am happy to take both.=0A=
> Palmer?=0A=
=0A=
Palmer,=0A=
=0A=
Ping !=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
