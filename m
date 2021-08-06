Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013E73E2FD2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 21:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244029AbhHFTqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 15:46:21 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:42502 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244006AbhHFTqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 15:46:20 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C9EC4C0781;
        Fri,  6 Aug 2021 19:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628279164; bh=8w4IRbqyc867gCXusunt5h4W5Xopwcma/CmoiyzuIWI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Pi8NzyGxYiS1wiGdscKIJX4NRgVdh739UDKKQng8s2dfiKnizCrcewx8hpr/zCFMK
         7h7qCA3cpxuiGmEpKgaU2dSY9PPoPQRGX+E4d/YAlalWOL+VqAySk0jXZTWnfq13P/
         C2VdfqtbNYYQjwA6F8YJgzQotLfqk/vYuA49D/oXtFB/UlR9/1k0S/eiX2pIZbBFdb
         NUtOSNIFOkOdKopTi/FN/VqhUgUWSTCtdOnXHjjpSG6b5h9DgSCVvyOegcoWt8Oyf9
         PposGVYoyNwzIlyDs/vrjmg75qUgoowJAPNNEP2PcwHI7inZvGyCwDgz582d0diblg
         Z54a9VtzamBLA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 32592A0080;
        Fri,  6 Aug 2021 19:46:01 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8A85480149;
        Fri,  6 Aug 2021 19:45:59 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="tCFqjpTO";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXdHFGfKxxJT2MmSrlo2z6aXKiji3WQzEXZBJ5z19NPZTGyf80mucEp9pRv4l7W8jE9DdIbG8PYUMBDv1tscjbzGPXe0ImOAgXHOkTgrAI6oDs70ujI7Fd8o1XucTAqU0Ff+X4mGPP4Jc39jpIk/lMdjJgYZd2gEaPGb7HFUVbY1DaH+Pm4ywLVumR2jDZYjU/NEiLTouReGA8ofWZX8bsiB3f20Yd8gyYfglc/TyKFH2ukrXpFyyZkksGwUozcD7uJriDRUcY0pq8vjXLRa6/V/whioWla2Cs3YJdlatTvGmAkTNP8XYwJZ6heZ71RYbuIKIvZlNnSSkYXfge/m3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxRD6wALEAs+I3lqxd9wwzloFQjOm9dtsIbS3Ri2+3k=;
 b=hb880UEUKONetarxwtVZZwjlv8i24sUAwpeAPImnBq4DyGQ8DPr+6ZUXSMoD6lZp2L7ryK9OsRDC1VeM/N94Uv81YchE7l6fEONETKMim9yzQIHtpQBP1AuwOyBu38ir4qDnMwykb4OdQxudH/GmTBFC6Mezi6g87wFbIfrOw35gCwy7+8t1lGdtPrO0C9WxVPAJ2SpEQXZ4rCvyNZG9OMU+HYuXqIXHXtxLYcaXhxpG71tKZV8RTkiFqy0He/+cyX9WBsYrkzi5Hw5BQL0QJPIgHL0nesudmo/SxDpg66AIOBcysJZASViwrq6F6Biklz9Jgpx9Z504sn/oT88PRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxRD6wALEAs+I3lqxd9wwzloFQjOm9dtsIbS3Ri2+3k=;
 b=tCFqjpTOIMZcyanxbnTvKXevwFNUJ1Jibiy09+hE72FMFm4KgiBVKJPpCh3NGcK6+2c1Y+wLSdRdOIOuOeWj2GmgqVy/BxVy5aS7OGwlNramIcPD56P9xgepbpW1hHKHJiwh7E0HCcHCHPyk0dLDBWW6mbfqukWMsZdLYo3Y8hQ=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB3352.namprd12.prod.outlook.com (2603:10b6:a03:a8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Fri, 6 Aug
 2021 19:45:56 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::acbd:42ac:9bab:39ee]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::acbd:42ac:9bab:39ee%3]) with mapi id 15.20.4373.028; Fri, 6 Aug 2021
 19:45:56 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     kernel test robot <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [arc:topic-mmu 27/32] arch/arc/include/asm/hugepage.h:29:36:
 error: implicit declaration of function 'pte_mknotpresent'; did you mean
 'pte_present'?
Thread-Topic: [arc:topic-mmu 27/32] arch/arc/include/asm/hugepage.h:29:36:
 error: implicit declaration of function 'pte_mknotpresent'; did you mean
 'pte_present'?
Thread-Index: AQHXish2QYQcupNsjEKTwrXsvUyKiqtm4ccA
Date:   Fri, 6 Aug 2021 19:45:56 +0000
Message-ID: <ce1644b1-b81c-57f2-ccdd-15f9387a7484@synopsys.com>
References: <202108062145.vVf2WQey-lkp@intel.com>
In-Reply-To: <202108062145.vVf2WQey-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 701b01b7-dfc3-4a8e-2b1f-08d95912cf21
x-ms-traffictypediagnostic: BYAPR12MB3352:
x-microsoft-antispam-prvs: <BYAPR12MB3352CD16D49BDE81C7E88F24B6F39@BYAPR12MB3352.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:462;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZPzD+APCWWb4UXzTnomayfyFkKU14TXCow74RtUGobdwFoOeiW/c23ouVdoND5CWH7a2/HEHyUmib46n68gZw9xQQGBy8g2WUPLs/DqQufJb54cgGmhX9r+BE6NmivmCPW4ristwUhYFdQK1Mv/EPXbMB0vf6fRC29IPHLPhQ0b5vdEIWHarGp1L7KoKy12GK7uu8ddbq6UL7EVP1zDGTF4YRi36tl99xVB0nBPry3U/91A65DMUTuqV5qFGbNH8G2sdpfyUYowvcwrVmLj54lznHE4cyLpMoRqcwsuZ+XMGNQLCLrKX82DuudJtFAF3HqVEl9iw1o+4SQxTSmM2cIzPVQUbhC1c7kN6wlSrQH8UZhYvelI2wh9+Q0ij4k7AOD4Nj4xk38lKikhaG+JG04cr6L4lFf/zsXIG9ni/j1sDkYxAkBi6z5AXoMbY3UYLZ2cHUf8jqIFm0e6HdDSw1uCsD3EIFny4O+FF7K7H/k53UXQ4boDpR0AIRR6w6z3YfU4LcKVMVuSy7i8zUyy+RE2HYUUZpaEv2pTD2DbWCDr6o78PZKs3t36A7rIrQynVDagREpfHwuPlPvq+y1nGVFjhPoPNGWzzqOFVHbDhVssn+5GBYUDgL7+hkOjmBE4shiEeYj5psLdNYnsoSm3m6o4lFbJ/OrPiRRMUetPcO78RYJS9eS3LiU8FE44RKYzcjAqh1MJUJQFCOQ2B8unoGY9K1q3P5l5Ts0XNXBOJco+z9uCwWsbMKlgHTu0LBGtKrWIjtXhM7xn3XYZgMXS6X9LT81uySr+sY1Y2Sj2jpn6qBLGH0szvDFEHaQpKZn/hojU6wugnnl6bTjGU02Q3N6e7BjZ3kBpg8qsL8Du2X0ArG8k8OxKY/2HEruuEX29A3ZKWrJ8RSOe8uglo3qpNYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(366004)(376002)(136003)(122000001)(53546011)(6512007)(38100700002)(2906002)(2616005)(54906003)(8936002)(26005)(316002)(186003)(6506007)(38070700005)(30864003)(66946007)(71200400001)(76116006)(31696002)(83380400001)(86362001)(66476007)(478600001)(966005)(36756003)(6916009)(4326008)(31686004)(5660300002)(66556008)(8676002)(64756008)(6486002)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?VCDqG04Yrzp2o/GeYGsQISLZMqMySnasNhhAjyhf1DN3rAvBTI+9Ncvb?=
 =?Windows-1252?Q?ixzhQKb9NubhVw11RZMu+2ETO4SzQwv+zqeS2wryS0cy7TrZ4XbB5GsU?=
 =?Windows-1252?Q?EMGSeF6evpu8ru3CAODDY9fWmduWwdF/UKVZ25h60DsPdOhC30qtvIuO?=
 =?Windows-1252?Q?aDI0IMHyP/vQ4iw+JR24nBPNcI2LUW/4EL6NOlvyOAo/6H6SzPaYnCBJ?=
 =?Windows-1252?Q?R6zAFIdLbq7E1Q7DGiKJL0oRS8aiZQYzy/bsVPcX/XwpuA4HZQdxAoDv?=
 =?Windows-1252?Q?Cu4P1OcmCkupamAREGeh/shQFPpD81tdxbDhi6f5mquuDuh6cyqHJk7O?=
 =?Windows-1252?Q?RsXo+AqBtuX93K5T70jZenGcrc7XLZjorIlsqlJTs3L6UlzExbw/1Oi1?=
 =?Windows-1252?Q?Jrnq3ah5j0TOCiS0qN+jNmB4LMIPmh33O2sYi7Af+HzcsguawCSArmqh?=
 =?Windows-1252?Q?y91yDB7jXYUUdLGDrcFYbptrQB+cSkwEAGi0erPqMGcOBbs+UmGlsfM4?=
 =?Windows-1252?Q?TcIOczm/ZvpudtI/8ShTEw+OagyVwPBxLtPt6DKgjSss8VoKhFky+kHd?=
 =?Windows-1252?Q?a74ybU3JfIAA4/iD+cAmmXF8EOOFv5F1j9/NVcJf8Qulb3AESuRvlwNy?=
 =?Windows-1252?Q?DdHOgKv+6OIaZpemlz05copRlvzKFz0ag817TAD9YDEOzRC1oDLFyQTv?=
 =?Windows-1252?Q?Ct8V4qamePHLrT4CvJhfOLDY5gTlWzxtIle3AxnWMeDe32JsMcBKpuqs?=
 =?Windows-1252?Q?aPQL7cRYUz+eNrKfCh1qhINZosXt8ugMCDpV0A3l7WQo9Iw0zsD6oxoD?=
 =?Windows-1252?Q?Z4t/q43R/72AuOXqMGZhSvra2WRp9IQwyipUuomQ41AYoQmNx22X1Sat?=
 =?Windows-1252?Q?dNbJ4R4ixe9D4FFOvfJVEeNmBbwEBcION26VWeHxuUm6hrnF64Rwhc8H?=
 =?Windows-1252?Q?/rgtwQmomHNiEFeOtsOQEU9oS03c1z/gKT8r6FL5wSPecTc9PYzuMWCl?=
 =?Windows-1252?Q?pyOCxWxQQZGoInkUBVOH/yIjfkcb7A8NNW7vdASct57R5G5HIWk8pz3F?=
 =?Windows-1252?Q?P1a1AsSebg5DktyN2lYCJwHTQY03gLQH1vtJuzLYtZZUTBod5GRHFPpl?=
 =?Windows-1252?Q?eg1OhLB1gYXUo7q4Qnw3xCIwJJe80tbF1GF0d2T1fjYvrh2puecDn0Rm?=
 =?Windows-1252?Q?e78nJucCt2xuPJQ+srvcwK9HggpwNKas39jmj4c0ek/cDeEgjcm/ksp4?=
 =?Windows-1252?Q?5t7yAWuOUeYUr1+ScbKBosQfhe9ilAyH5DhNFlU2fDD1UjXHYhCw32pR?=
 =?Windows-1252?Q?7FF06wgEuRZJTzinr+IfXLRV13y08JaY8N7VjQNM/Ob4yMpZlXysvaNi?=
 =?Windows-1252?Q?JLX5TTmycXZcxr98G0UMdhcAEABrsGRXGBM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <4A29C4319A69F648A40B7B01FF2D962E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 701b01b7-dfc3-4a8e-2b1f-08d95912cf21
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2021 19:45:56.7007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zyU+2NMoGeklDCKDpBeur9t1IDutlZaiX8XOAbb0amswjEHc4nfHehMGeyP1VjlOgwi/t34dHzWDnv6MKynvyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3352
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/21 6:38 AM, kernel test robot wrote:
> tree:   https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/=
kernel/git/vgupta/arc.git__;!!A4F2R9G_pg!JkynKBqZimbhej1a4Vdszp5CSFVPGZRDks=
LBzwDbrZhdmsyGKSOySAh_3Qh53SoH$  topic-mmu
> head:   aad84191703280f0aace986bff0afd917b77511e
> commit: 9832faa2ca147e7d3fa551f7cc43df19cf569111 [27/32] ARC: mm: remove =
unused pte accessors
> config: arc-allyesconfig (attached as .config)
> compiler: arceb-elf-gcc (GCC) 10.3.0
> reproduce (this is a W=3D1 build):
>          wget https://urldefense.com/v3/__https://raw.githubusercontent.c=
om/intel/lkp-tests/master/sbin/make.cross__;!!A4F2R9G_pg!JkynKBqZimbhej1a4V=
dszp5CSFVPGZRDksLBzwDbrZhdmsyGKSOySAh_3VPXG8J4$  -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://urldefense.com/v3/__https://git.kernel.org/pub/scm/lin=
ux/kernel/git/vgupta/arc.git/commit/?id=3D9832faa2ca147e7d3fa551f7cc43df19c=
f569111__;!!A4F2R9G_pg!JkynKBqZimbhej1a4Vdszp5CSFVPGZRDksLBzwDbrZhdmsyGKSOy=
SAh_3bcRVHFe$
>          git remote add arc https://urldefense.com/v3/__https://git.kerne=
l.org/pub/scm/linux/kernel/git/vgupta/arc.git__;!!A4F2R9G_pg!JkynKBqZimbhej=
1a4Vdszp5CSFVPGZRDksLBzwDbrZhdmsyGKSOySAh_3Qh53SoH$
>          git fetch --no-tags arc topic-mmu
>          git checkout 9832faa2ca147e7d3fa551f7cc43df19cf569111
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-10.3.0 make.cr=
oss ARCH=3Darc
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Thanks for this report. I love this testing. I wish I could buy you guys=20
a beer (or a beverage of choice !)
I've added the Reported-by tag for the ensuing fix.

-Vineet

>
> All errors (new ones prefixed by >>):
>
>     In file included from arch/arc/include/asm/bug.h:30,
>                      from include/linux/bug.h:5,
>                      from include/linux/mmdebug.h:5,
>                      from include/linux/gfp.h:5,
>                      from mm/debug_vm_pgtable.c:13:
>     mm/debug_vm_pgtable.c: In function 'pmd_thp_tests':
>>> arch/arc/include/asm/hugepage.h:29:36: error: implicit declaration of f=
unction 'pte_mknotpresent'; did you mean 'pte_present'? [-Werror=3Dimplicit=
-function-declaration]
>        29 | #define pmd_mkinvalid(pmd) pte_pmd(pte_mknotpresent(pmd_pte(p=
md)))
>           |                                    ^~~~~~~~~~~~~~~~
>     include/asm-generic/bug.h:121:25: note: in definition of macro 'WARN_=
ON'
>       121 |  int __ret_warn_on =3D !!(condition);    \
>           |                         ^~~~~~~~~
>     include/asm-generic/pgtable-nop4d.h:40:24: note: in expansion of macr=
o 'pgd_val'
>        40 | #define p4d_val(x)    (pgd_val((x).pgd))
>           |                        ^~~~~~~
>     include/asm-generic/pgtable-nopud.h:48:24: note: in expansion of macr=
o 'p4d_val'
>        48 | #define pud_val(x)    (p4d_val((x).p4d))
>           |                        ^~~~~~~
>     include/asm-generic/pgtable-nopmd.h:50:24: note: in expansion of macr=
o 'pud_val'
>        50 | #define pmd_val(x)    (pud_val((x).pud))
>           |                        ^~~~~~~
>     arch/arc/include/asm/hugepage.h:39:30: note: in expansion of macro 'p=
md_val'
>        39 | #define pmd_trans_huge(pmd) (pmd_val(pmd) & _PAGE_HW_SZ)
>           |                              ^~~~~~~
>     mm/debug_vm_pgtable.c:913:11: note: in expansion of macro 'pmd_trans_=
huge'
>       913 |  WARN_ON(!pmd_trans_huge(pmd_mkinvalid(pmd_mkhuge(pmd))));
>           |           ^~~~~~~~~~~~~~
>     mm/debug_vm_pgtable.c:913:26: note: in expansion of macro 'pmd_mkinva=
lid'
>       913 |  WARN_ON(!pmd_trans_huge(pmd_mkinvalid(pmd_mkhuge(pmd))));
>           |                          ^~~~~~~~~~~~~
>>> arch/arc/include/asm/hugepage.h:29:36: error: incompatible type for arg=
ument 1 of 'pte_pmd'
>        29 | #define pmd_mkinvalid(pmd) pte_pmd(pte_mknotpresent(pmd_pte(p=
md)))
>           |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
>           |                                    |
>           |                                    int
>     include/asm-generic/bug.h:121:25: note: in definition of macro 'WARN_=
ON'
>       121 |  int __ret_warn_on =3D !!(condition);    \
>           |                         ^~~~~~~~~
>     include/asm-generic/pgtable-nop4d.h:40:24: note: in expansion of macr=
o 'pgd_val'
>        40 | #define p4d_val(x)    (pgd_val((x).pgd))
>           |                        ^~~~~~~
>     include/asm-generic/pgtable-nopud.h:48:24: note: in expansion of macr=
o 'p4d_val'
>        48 | #define pud_val(x)    (p4d_val((x).p4d))
>           |                        ^~~~~~~
>     include/asm-generic/pgtable-nopmd.h:50:24: note: in expansion of macr=
o 'pud_val'
>        50 | #define pmd_val(x)    (pud_val((x).pud))
>           |                        ^~~~~~~
>     arch/arc/include/asm/hugepage.h:39:30: note: in expansion of macro 'p=
md_val'
>        39 | #define pmd_trans_huge(pmd) (pmd_val(pmd) & _PAGE_HW_SZ)
>           |                              ^~~~~~~
>     mm/debug_vm_pgtable.c:913:11: note: in expansion of macro 'pmd_trans_=
huge'
>       913 |  WARN_ON(!pmd_trans_huge(pmd_mkinvalid(pmd_mkhuge(pmd))));
>           |           ^~~~~~~~~~~~~~
>     mm/debug_vm_pgtable.c:913:26: note: in expansion of macro 'pmd_mkinva=
lid'
>       913 |  WARN_ON(!pmd_trans_huge(pmd_mkinvalid(pmd_mkhuge(pmd))));
>           |                          ^~~~~~~~~~~~~
>     In file included from arch/arc/include/asm/pgtable-bits-arcv2.h:145,
>                      from arch/arc/include/asm/pgtable.h:12,
>                      from include/linux/pgtable.h:6,
>                      from include/linux/mm.h:33,
>                      from include/linux/highmem.h:8,
>                      from mm/debug_vm_pgtable.c:14:
>     arch/arc/include/asm/hugepage.h:18:35: note: expected 'pte_t' but arg=
ument is of type 'int'
>        18 | static inline pmd_t pte_pmd(pte_t pte)
>           |                             ~~~~~~^~~
>     In file included from arch/arc/include/asm/bug.h:30,
>                      from include/linux/bug.h:5,
>                      from include/linux/mmdebug.h:5,
>                      from include/linux/gfp.h:5,
>                      from mm/debug_vm_pgtable.c:13:
>>> arch/arc/include/asm/hugepage.h:29:36: error: incompatible type for arg=
ument 1 of 'pte_pmd'
>        29 | #define pmd_mkinvalid(pmd) pte_pmd(pte_mknotpresent(pmd_pte(p=
md)))
>           |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
>           |                                    |
>           |                                    int
>     include/asm-generic/bug.h:121:25: note: in definition of macro 'WARN_=
ON'
>       121 |  int __ret_warn_on =3D !!(condition);    \
>           |                         ^~~~~~~~~
>     include/asm-generic/pgtable-nop4d.h:40:24: note: in expansion of macr=
o 'pgd_val'
>        40 | #define p4d_val(x)    (pgd_val((x).pgd))
>           |                        ^~~~~~~
>     include/asm-generic/pgtable-nopud.h:48:24: note: in expansion of macr=
o 'p4d_val'
>        48 | #define pud_val(x)    (p4d_val((x).p4d))
>           |                        ^~~~~~~
>     include/asm-generic/pgtable-nopmd.h:50:24: note: in expansion of macr=
o 'pud_val'
>        50 | #define pmd_val(x)    (pud_val((x).pud))
>           |                        ^~~~~~~
>     arch/arc/include/asm/pgtable-levels.h:66:26: note: in expansion of ma=
cro 'pmd_val'
>        66 | #define pmd_present(x)  (pmd_val(x))
>           |                          ^~~~~~~
>     mm/debug_vm_pgtable.c:914:11: note: in expansion of macro 'pmd_presen=
t'
>       914 |  WARN_ON(!pmd_present(pmd_mkinvalid(pmd_mkhuge(pmd))));
>           |           ^~~~~~~~~~~
>     mm/debug_vm_pgtable.c:914:23: note: in expansion of macro 'pmd_mkinva=
lid'
>       914 |  WARN_ON(!pmd_present(pmd_mkinvalid(pmd_mkhuge(pmd))));
>           |                       ^~~~~~~~~~~~~
>     In file included from arch/arc/include/asm/pgtable-bits-arcv2.h:145,
>                      from arch/arc/include/asm/pgtable.h:12,
>                      from include/linux/pgtable.h:6,
>                      from include/linux/mm.h:33,
>                      from include/linux/highmem.h:8,
>                      from mm/debug_vm_pgtable.c:14:
>     arch/arc/include/asm/hugepage.h:18:35: note: expected 'pte_t' but arg=
ument is of type 'int'
>        18 | static inline pmd_t pte_pmd(pte_t pte)
>           |                             ~~~~~~^~~
>     cc1: some warnings being treated as errors
> --
>     In file included from arch/arc/include/asm/pgtable-bits-arcv2.h:145,
>                      from arch/arc/include/asm/pgtable.h:12,
>                      from include/linux/pgtable.h:6,
>                      from include/linux/mm.h:33,
>                      from include/linux/pagemap.h:8,
>                      from mm/pgtable-generic.c:10:
>     mm/pgtable-generic.c: In function 'pmdp_invalidate':
>>> arch/arc/include/asm/hugepage.h:29:36: error: implicit declaration of f=
unction 'pte_mknotpresent'; did you mean 'pte_present'? [-Werror=3Dimplicit=
-function-declaration]
>        29 | #define pmd_mkinvalid(pmd) pte_pmd(pte_mknotpresent(pmd_pte(p=
md)))
>           |                                    ^~~~~~~~~~~~~~~~
>     mm/pgtable-generic.c:197:49: note: in expansion of macro 'pmd_mkinval=
id'
>       197 |  pmd_t old =3D pmdp_establish(vma, address, pmdp, pmd_mkinval=
id(*pmdp));
>           |                                                 ^~~~~~~~~~~~~
>>> arch/arc/include/asm/hugepage.h:29:36: error: incompatible type for arg=
ument 1 of 'pte_pmd'
>        29 | #define pmd_mkinvalid(pmd) pte_pmd(pte_mknotpresent(pmd_pte(p=
md)))
>           |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
>           |                                    |
>           |                                    int
>     mm/pgtable-generic.c:197:49: note: in expansion of macro 'pmd_mkinval=
id'
>       197 |  pmd_t old =3D pmdp_establish(vma, address, pmdp, pmd_mkinval=
id(*pmdp));
>           |                                                 ^~~~~~~~~~~~~
>     arch/arc/include/asm/hugepage.h:18:35: note: expected 'pte_t' but arg=
ument is of type 'int'
>        18 | static inline pmd_t pte_pmd(pte_t pte)
>           |                             ~~~~~~^~~
>     cc1: some warnings being treated as errors
>
>
> vim +29 arch/arc/include/asm/hugepage.h
>
> fe6c1b8611aa3a Vineet Gupta      2014-07-08  22
> fe6c1b8611aa3a Vineet Gupta      2014-07-08  23  #define pmd_wrprotect(pm=
d)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
> fe6c1b8611aa3a Vineet Gupta      2014-07-08  24  #define pmd_mkwrite(pmd)=
	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
> fe6c1b8611aa3a Vineet Gupta      2014-07-08  25  #define pmd_mkdirty(pmd)=
	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
> fe6c1b8611aa3a Vineet Gupta      2014-07-08  26  #define pmd_mkold(pmd)		=
pte_pmd(pte_mkold(pmd_pte(pmd)))
> fe6c1b8611aa3a Vineet Gupta      2014-07-08  27  #define pmd_mkyoung(pmd)=
	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
> fe6c1b8611aa3a Vineet Gupta      2014-07-08  28  #define pmd_mkhuge(pmd)	=
	pte_pmd(pte_mkhuge(pmd_pte(pmd)))
> 86ec2da037b854 Anshuman Khandual 2020-06-03 @29  #define pmd_mkinvalid(pm=
d)	pte_pmd(pte_mknotpresent(pmd_pte(pmd)))
> fe6c1b8611aa3a Vineet Gupta      2014-07-08  30  #define pmd_mkclean(pmd)=
	pte_pmd(pte_mkclean(pmd_pte(pmd)))
> fe6c1b8611aa3a Vineet Gupta      2014-07-08  31
> fe6c1b8611aa3a Vineet Gupta      2014-07-08  32  #define pmd_write(pmd)		=
pte_write(pmd_pte(pmd))
> fe6c1b8611aa3a Vineet Gupta      2014-07-08  33  #define pmd_young(pmd)		=
pte_young(pmd_pte(pmd))
> fe6c1b8611aa3a Vineet Gupta      2014-07-08  34  #define pmd_pfn(pmd)		pt=
e_pfn(pmd_pte(pmd))
> fe6c1b8611aa3a Vineet Gupta      2014-07-08  35  #define pmd_dirty(pmd)		=
pte_dirty(pmd_pte(pmd))
> fe6c1b8611aa3a Vineet Gupta      2014-07-08  36
> fe6c1b8611aa3a Vineet Gupta      2014-07-08  37  #define mk_pmd(page, pro=
t)	pte_pmd(mk_pte(page, prot))
> fe6c1b8611aa3a Vineet Gupta      2014-07-08  38
> fe6c1b8611aa3a Vineet Gupta      2014-07-08 @39  #define pmd_trans_huge(p=
md)	(pmd_val(pmd) & _PAGE_HW_SZ)
> fe6c1b8611aa3a Vineet Gupta      2014-07-08  40
>
> :::::: The code at line 29 was first introduced by commit
> :::::: 86ec2da037b85436b63afe3df43ed48fa0e52b0e mm/thp: rename pmd_mknotp=
resent() as pmd_mkinvalid()
>
> :::::: TO: Anshuman Khandual <anshuman.khandual@arm.com>
> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://urldefense.com/v3/__https://lists.01.org/hyperkitty/list/kbuild-a=
ll@lists.01.org__;!!A4F2R9G_pg!JkynKBqZimbhej1a4Vdszp5CSFVPGZRDksLBzwDbrZhd=
msyGKSOySAh_3SyjWe_B$

