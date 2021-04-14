Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDCC35F0ED
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 11:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbhDNJjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 05:39:19 -0400
Received: from mail-dm6nam11on2059.outbound.protection.outlook.com ([40.107.223.59]:3425
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232503AbhDNJjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:39:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfSj20KT/SmrdhvLv4Kb6qBplgqWe0+pCxTQifAT4P59ZY7a5OLrE2xmTGthOoP+VeTrw+7DesHfcDggWYblJqLvWJ63zKuQAQtB1A/Nnk5UU9xCowvxZqsbpuzrzKD2VntQJYkzunM7SkcnOIyBxz42cq+stgnNdpQvo+7xNQTUyQDyEu/GBTCh2kG9udB/kWsHTalCDJegctW4NeGtl92OyZfUjJvkDwOzoK/6buVqRwpt7B6CPQjit1FbEL2Pa8ElDn5tUN4azwuP+B+ewklDWlzDJRm3YZc3Wq51Fxswnn+2dezj5i219v2tOXOYYkaMNiiLpWsW2iaMhWoQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1zZJXr025wCYwZ03VgZPHTWfFdwlmtq4D6SWbnexTA=;
 b=J/4G5firr/L2taSclCLRv4cDi82LzOMgIVVv5bGD6xjIwYfsWKhYGZiMGxlGVT6BUI7ewF0mTkV3UYqSJo4z5+iJhvvfF83uC3ujqPIAi4nPUxOc5rLVtn93fCIZm49gQ1+uGzjS/KWDXX1pjQV60FA9i8e6RN0dlR8moUkfVsH1rJnu44wW/yPL89BftirgMkGoSWUdORdrApUOJQNnGFfa54RTBOoo8O7oYw8ToWrM+J7x78kWghq5wkb6Gv1yhESEgBp7AaYLHWFiPBq34ZJP5IIqDxkJv7PRtXTgrt8jOzAH4PrNlfg6BmBnnoOAuBBwwojTbkQeoi7B2kLPow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1zZJXr025wCYwZ03VgZPHTWfFdwlmtq4D6SWbnexTA=;
 b=M6SH2r//uRhJor0lzgJmoIeFfIb0I0l8XmqZWqkyWyNt74wIDeuZYSt5ErscuH9jqngrUtzrobE+Deib0ozGSKkum7z8XML/6PBurUhXCxCSWJpIsy9YDbwCknFb+D3CUH8xjcvnPanVC9BzFJ4RbCgHVaVORD1XcszpkFUq184=
Authentication-Results: csgroup.eu; dkim=none (message not signed)
 header.d=none;csgroup.eu; dmarc=none action=none header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by SJ0PR03MB5440.namprd03.prod.outlook.com (2603:10b6:a03:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Wed, 14 Apr
 2021 09:38:45 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%8]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 09:38:45 +0000
Date:   Wed, 14 Apr 2021 17:38:32 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-parisc@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        openrisc@lists.librecores.org, Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org,
        linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] init: consolidate trap_init()
Message-ID: <20210414173832.52bc3ddb@xhacker.debian>
In-Reply-To: <20210414172757.3ebfaa4c@xhacker.debian>
References: <20210414165808.458a3d11@xhacker.debian>
        <44bdf1f1-117d-0f10-fc59-9edd32d1ad61@csgroup.eu>
        <20210414172757.3ebfaa4c@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::36) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:c0::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6 via Frontend Transport; Wed, 14 Apr 2021 09:38:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c7614f2-058d-4ec7-48bb-08d8ff2918e1
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5440:
X-Microsoft-Antispam-PRVS: <SJ0PR03MB5440EC1241F238CF3050F3FBED4E9@SJ0PR03MB5440.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HOwd3PMqdcpF05NX25PqVYW5PWTB6GgxcazGSivwmtehmz4H4cFPckWw10Q/rZi49D0ARPd6KUfTyvOGHLPjXr0tBC5Jfa6G8rEi5x1ZadZu82yJHWzUsHpJyThBX0BtdRWqoAjmWVLEW/s7elGhZQOSWPLob44HeOzJ4jlNzGPvCyZNtorOKSUnoU+/UMb4HqGv6c+9Ay1PrhC7wIUMlwd3qbJfM9gikx0bMzWEJB1+boFeZzOnCw1T8nRJUXosEKYfoqQotboOR4OpwdrMLojTOukDkBsuxc1wFz8iXccTiEqsenFViRxm6eLcYaOa8vslgej8+o5rNRMt5TVpscUklxH5hX1HyAWITVPF7CXXJC2D9VT9pyIZMJQbr9J14f1wT/KIeyPitI0gK87+xuWs2CypTG8lA79D7iP8CgxQzLQ0YzRChOhUPtBqZBRM7wDk2E4l52fCeGfHYTgCul3GulFZUCAyHemEUdxkb3FgUvncEp1CTS2yuPhRcf4CJrCVjRMTNrmpejmh5ZeX7IarlUC1gNrRoxZGcNPWloUIcbB22ZGo0WS6YIA5KamQW63fjd+UCWgvOSQMLvByCF4JlJ7bdhKzxTvnGq6SfpnlFSfboTCSuVQoDUnqsUTrop6cDH+1lphkDo7G+CHy2Si1pKx3iMyHKCGsZjz+ZTg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39850400004)(366004)(346002)(396003)(5660300002)(9686003)(55016002)(8676002)(6666004)(66556008)(66476007)(478600001)(6506007)(86362001)(6916009)(66946007)(54906003)(2906002)(16526019)(4326008)(1076003)(7406005)(7416002)(7696005)(26005)(52116002)(38350700002)(316002)(956004)(8936002)(38100700002)(186003)(66574015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?blBLQ2ZOOGdEWjY5MFR4Rmg1S2txVEhWUndPTEFzcWVITDl6c2dlY3VXOTdr?=
 =?utf-8?B?K1ZCMWYxdDZwL0lXajN4R2dUK0VzMVRZT3hTSDFteXlTUmFwZU5QMVFNM1ln?=
 =?utf-8?B?MFpZYkE4ckRGTzlkMHQ0M0JuNWp4TENjdjF1T1VlT3ZsSUtwMk1vb2wwSnVG?=
 =?utf-8?B?anF3Mk96WEswcnpZT1VwTmxERkRxd2libGlVNEptTUQ5WFdsYmlpdGZJS0Ux?=
 =?utf-8?B?UFRmdkJqS2FNVjh3bXd0RElCbG1oZnNlSG55QllPbHpkYVpuZVR4RXhLR1VW?=
 =?utf-8?B?V1RvM3FPTVpWbk1VN0s1eDNkdUg1UjBnNTZjQUxxVnZieDZFWFJTM1YwZVd3?=
 =?utf-8?B?d0pvVDM5SzNUbUNlbXZMSWZiRFAzNTRES0ttVFRZNmkzN1UxdjdhS0x4T3V6?=
 =?utf-8?B?cWxzaG9nWUxkMjlZVTZ3UlFLYXdNRUN5Q2lVOHBBME9udDF1cWx4V2hBRmdz?=
 =?utf-8?B?UzVuRGRGMHZkZEh6a2ZlZnJydXJaak1DYnpVc01EYzNCVHVScnZHekNWVE9P?=
 =?utf-8?B?WXI2YXBaL3B5VXhWWm1zKzVrNzF6WWtUY3daVGxmQTg5Q3ZiVG04NEZKcUZ1?=
 =?utf-8?B?RXJqVHRqcFRJZndpQzhENTNyTGhiek1mSTJUNC91UTNGRmdSVERJK3VhMkp2?=
 =?utf-8?B?RU16MjdLUkhZekhjaWo4YVE4dEw2UXo2Vi9MaU93ZlhrcjdQZUs5OXJjSlRu?=
 =?utf-8?B?Y2dqQjlIcytKSjREbUZaN2s5eG0zUDAyRXJHcWRJVVE3bEtCS1luMGxHeGgv?=
 =?utf-8?B?VkgrVnRWbkJsV2ZTOC9QUFBmcU94aEt5TEd0NSsrR1EwVmwrbFBFVG1KczZI?=
 =?utf-8?B?NVpXODV0c1JhdVJaSmJBdTMzbnRjVmt6dlVEdVlxMGxMcXRmeHI3K25DVVBm?=
 =?utf-8?B?ODV0Ri9ZRXJaaUo4WVRHSVNXZUp6Y0RWbndHWmEyY0xPYVNtby9Sd1g2Z0xS?=
 =?utf-8?B?UkpjT0EwU3NLNUlPVzk3UmNnWTk4aXBCdzZSZVBlNTRrbHJLdHdUc2RTdEp0?=
 =?utf-8?B?WHVNRW9OdzkzVjZqeHVCUUkvSTBYcVQwbHJXamQ0dHlnV3lUcEVYQmJRaHoy?=
 =?utf-8?B?cmdxR013VVF5YzFMTHhFYlNQczI4TGpCcnk5VkV2TGdVVW5YOVRmZmZWdmhz?=
 =?utf-8?B?SUt5bjBxdWxrY2FJUDVRenZjYmUyekhWS2xJY0pXbkFoVk9LREFrYTRxcWRz?=
 =?utf-8?B?c2lYdWtmMWQ3M1NIL3dPeGtQekh1SFZVMCt3RkRDVnZlWGxhM2NlYlpwS0N0?=
 =?utf-8?B?WnRrekszQXpiNFd2cUxhdm1Db3JiM0FzK2VFYU9IbGt3QzlRS3VJSWRFOGV2?=
 =?utf-8?B?d09ZdCtKOGV4MGdRRGJnczc0Z2FzSlBxTUJ1ZmpnVEYySkRLN3pWUFY2NmRT?=
 =?utf-8?B?TTlOVkUxRDRWYWpBTFBlaVVVeTRNcDk1MndISGFKK0J1N3dKNFpORklCb3Zk?=
 =?utf-8?B?dDFlUTlXK0g1alhmVzdEbzhHcnB2bGdEeWkybm1Cb1J2dll2R2hqRVRnTlBi?=
 =?utf-8?B?alpMMlAwUzhaMUdseWJjYVN5ZUZsY2JsdnFDMlNsdmJ1WGpMeFlGRllKYWxw?=
 =?utf-8?B?TTNwcVZicXlPdDltU3oxTElIazR1OWx4NXJZbWx5c0ZzR2lkeWt1VlV6WW5u?=
 =?utf-8?B?MytGNGJZRTBMbWY5bVN1T0Rqcklneno3TDlEZktZMmRRT3cwUkJ5WnZTRkF2?=
 =?utf-8?B?aDJoclVadHkxRXdzQ2xSN0s1OVZ5clRQbTVDUDY2ZVlYMUlVdEtMWFAxaU1x?=
 =?utf-8?Q?Po3HMuu7gw0KdPCfzQux4ZIt0I7xsifeBoND27E?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7614f2-058d-4ec7-48bb-08d8ff2918e1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 09:38:45.2011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mIuMcyFpyprnnCRialV/0j+B0sqCGIatNUxuuu5qpQhtxcOnJn9LpXumcXWlVtZrYJDrM+kBJt6PEAmktrRQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5440
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2021 17:27:57 +0800
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> CAUTION: Email originated externally, do not click links or open attachme=
nts unless you recognize the sender and know the content is safe.
>=20
>=20
> On Wed, 14 Apr 2021 11:10:42 +0200
> Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
>=20
> >
> > Le 14/04/2021 =C3=A0 10:58, Jisheng Zhang a =C3=A9crit : =20
> > > Many architectures implement the trap_init() as NOP, since there is
> > > no such default for trap_init(), this empty stub is duplicated among
> > > these architectures. Provide a generic but weak NOP implementation
> > > to drop the empty stubs of trap_init() in these architectures. =20
> >
> > You define the weak function in the __init section.
> >
> > Most but not all architectures had it in __init section.
> >
> > And the remaining ones may not be defined in __init section. For instan=
ce look at the one in alpha
> > architecture.
> >
> > Have you checked that it is not a problem ? It would be good to say som=
ething about it in the commit
> > description. =20
>=20
> For those non-nop platforms, I can only test x86/arm64/, but both has
> __init mark. I'm not sure whether this is a problem for alpha etc. Maybe
> I can check which section the trap_init() sits. Or to avoid any possible
> regression, I can add __init mark to those remaining ones without it in
> preparation patches.
>=20

Hi,

I found only three platforms don't have the __init marker for trap_init(), =
I
will add the __init marker in three preparation patches in new version.

thanks
