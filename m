Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E28391710
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbhEZMLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:11:02 -0400
Received: from esa.hc3962-90.iphmx.com ([216.71.142.165]:58265 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbhEZMK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1622030966; x=1622635766;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CDTwLUSjYvxOGk06gCo6jYsKk82DKlG6F9+U/9tQJ6E=;
  b=zsriqVj2QP7jHAlKnyRCX0NBdce/fx7bZ2c1bVuj8NFIRleS8FyyQMXu
   D/OuH5OekZtnOmFpiRcUq9bbnrkC8pMijxMb2gRRixCjqyPlKTAIAauB7
   KLXq0jVWlaxj/zKcN4UwR61VI1rzMF6n2RXNB+5nxRL0On0KXix+vmKsW
   U=;
IronPort-SDR: bw+NRnW5RCMPsZJCSVb8gjxYSqIOp+XgFZ+nOibWOYyQ+Ycvgzcvomz4mRRVerAMRWeuorAOvS
 nx6W2tCkKKR8eDZYYIyvUiy0xHEvITsiOaR3nm4LKbOEK9zM6Qul++NPia74lqkc36IW3I9buo
 EnKW4SEr2Afl2vZZ8WMqDPXYnkdl9qI5Y8xQJ/ya7J0bVeprch9Lu5SaPDobtHsHvfjCyScNi0
 0l3uB0mEQWvzYqMuXFsWFdnaS5oKc9E8fXuloxuweJoXNE2VUAO3nMET01FXv0Unc2PCYWGGrQ
 82k=
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 12:09:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OX2xCRzYxD3rghpeD8Z4n5fWKtbZ++16qybCmrrT4hpzD2yMtit79e99bMUQmdDpFCMgQ2eOsHgxa/R4NXWHcSr8UCuV/tcpPwiKissrINtdNnxkayrfVJZ7yeTWVx2KpJ9pat65w9EbNIVAWKyOurEujIBa4m/wukYakd6+qkLPxRTem+GjrlxABe+NHQVWsMs2OuSXjeCg7SQ4vhme7JqZtsypuPpKtgdQ/LMUIE6ipAXjwCbNsLVHdm5i66Osq3t/3WzBrgS8tvB29sRt5QzGQz38WoLm/DQKsaB7zxmZRcZSjdDLZ09oUuBNjjE0cEdBfdmZlPBujvkY64pAhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBoafF1+BToHaDUMS7CZJnAYuRDV1rZZ9OayYGqKfU4=;
 b=U8xiFkRlWYItmh9U8mlf4WlbjMLOiiBw1tA5KN8CNAidaG0RNudOxcFCOJfOEJUORRBDsbrNj0AXssJ3Fe1worpDUGDo3TITkZEAk9jK0vxYR0qqngHYKkoQAIenkxQGSZ3E/vDont277X78/hOPv5ut8b6j244VtEa2QIdgVfWLpheGRX3APDlkTBWG+ibdfvcVm1ot8IDkxhizfivzUkmIag2YBuI7xjvtChx2e8gkQzF8SU+pRXlJjTrsOlYqXySvPPHsZHTlJPoBrImKOh1b83lmi/FiGp2HeOXmnuFCjvApR5QwMt31CqETmCTUzZECCozRvKRFKnWeVlsXGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CY4PR0201MB3553.namprd02.prod.outlook.com
 (2603:10b6:910:8e::24) by CY4PR02MB3320.namprd02.prod.outlook.com
 (2603:10b6:910:7f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Wed, 26 May
 2021 12:09:14 +0000
Received: from CY4PR0201MB3553.namprd02.prod.outlook.com
 ([fe80::c46a:171f:2529:3082]) by CY4PR0201MB3553.namprd02.prod.outlook.com
 ([fe80::c46a:171f:2529:3082%5]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 12:09:14 +0000
From:   "Qian Cai (QUIC)" <quic_qiancai@quicinc.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: Arm64 crash while reading memory sysfs
Thread-Topic: Arm64 crash while reading memory sysfs
Thread-Index: AddReOlJgH2KJ1uxR3GEgRxceOTONKr1q0Hw
Date:   Wed, 26 May 2021 12:09:14 +0000
Message-ID: <CY4PR0201MB35539FF5EE729283C4241F5A8E249@CY4PR0201MB3553.namprd02.prod.outlook.com>
References: <DM5PR0201MB355723819DDAC439273F68848E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
 <YK3tQ0a0S/CLxyyb@linux.ibm.com>
In-Reply-To: <YK3tQ0a0S/CLxyyb@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [71.184.117.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86070d76-ec7d-4b83-0e9a-08d9203f1474
x-ms-traffictypediagnostic: CY4PR02MB3320:
x-microsoft-antispam-prvs: <CY4PR02MB33200F6AE396A76D19E1A364F2249@CY4PR02MB3320.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pjS1oEfSqC0VkoukRsAqz9QpVmREFmzp8urV9z3kpZ7D36TfoajRUVMiQ+MbkVYhMYkpD84hFkvg6eWUrwh30aLybrkD3e6VduFkyQDhAYwTj3cF+SSJJm39aOaYaMlSx37GKaFGBafWcGlS/LX92/OoqKwOl20QeDg6zkhHM1c/7JPva+aGU5LW36LHA43yCNMYRMyBgsE4T/7My9TeG8bDtbR66YE2k+Ve8Z7gbdWO/xGvDJh/edaVB/+q8oANXWXCpy7QrZxngpExRe64P9fzw2+a/uzQhPuqvQ10yMefpgGEYIgCUMbPeg03Zw/xuvS0KHz7D/Iqnmzc4O7B2ahMTIHP2MZ6CBzeQ/wFW9q96VCc2Bzp/NugN7cJrCLYqA3QLqcq+Xo6t8a9otVZYe/8cy6Q8KZwYDYAK0ChcB1SKWNw5F0jphTZ+MAuxbnprRO3iaC9Wh/ZXDzTUnp+eAfHsFrEylu6UGL0CIF/8QcPN4GEyJP2n4g1tBimTlWQWKSXDfp8O+kZyM6oyhnfPEBpaI+WVbHHgdEfyrhHnNXr/Jzcwpo4eGBtwY16hmxjg1YrzqO6ffFUwaF7w7LMB2eIGllRBqkisPozap3rTKATWARpJYaFRTXm50QDGbkqmqC3RP8nq/2p2Hby4ZR2CeQVIKsCnN+e/Sq6quROgdIoNhg7FfuKp7fHlLi2sVwuJ4xXut34gik7pKOE9QIzKlnq317NUgQ5pjj4yO3BYic=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR0201MB3553.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39850400004)(396003)(366004)(346002)(8676002)(86362001)(54906003)(8936002)(5660300002)(64756008)(71200400001)(7416002)(66476007)(66556008)(52536014)(33656002)(6916009)(53546011)(45080400002)(76116006)(66946007)(7696005)(66446008)(9686003)(38100700002)(4326008)(6506007)(83380400001)(26005)(55016002)(122000001)(316002)(478600001)(966005)(2906002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nHELbeb/EFx9P8lf5ml0A+8nsabE4trPSY0Iz0X9LWR+t5WWwJiqUPiySxWo?=
 =?us-ascii?Q?LG2wiF3qSIf+SqwwyvSvRs0LqoFEfcBH2S+WccHKxf/fYXwGwRHiDsWvXjof?=
 =?us-ascii?Q?j6ZWAoNzL43mnPpVz9IH8SW1SO7bKCCWDe2mrnz0qbssihio0t/7ZzQReaAo?=
 =?us-ascii?Q?RILtGfFHSgNZzw6Sfk6RF+hBwRApYdGP2D84PuFWpWCHG+57A9AHu2zM5J1y?=
 =?us-ascii?Q?LgkEM/31y8XNXOeoI0kjkset9ai/FWhqFRQ2eiK0/Ge7InJ1OPGQlZ6STXvC?=
 =?us-ascii?Q?B9VXrhNOpWFIE4NEhlbcGpjmfhQBQS3+UdSdSUh06/B+xddZ6z2j5Dqxlg9A?=
 =?us-ascii?Q?XigTiulEy5Fw2mr8IklIARyMnZnUkKrwmb+lqNaNqWpwVCD+9JqNqAckVv37?=
 =?us-ascii?Q?TDz/FJaPYhF9jxpO2ezniYUKysuW6Axr5RbaPaVcpRLhSihqlcCdIGJS93ty?=
 =?us-ascii?Q?iQu9pLb7c8TFtADtNhIvuSzDdulObJUby3eK4u1DIJiu5v1nqwRgvhVKFCpc?=
 =?us-ascii?Q?mw4AWWEklQC57q2MHNUx2TBzuBvC+RnIw1q43aN1ZXfODMVRi6HstOHAWMpy?=
 =?us-ascii?Q?BMvzV13Jp05xV2VWpDnuorqw5yTiMJKeAKPcG1iDHkAwpjV+i7oe0l2ZHWpF?=
 =?us-ascii?Q?XEtDDSpK17uEknZV8rVzqggDE/Yl6F98jNkOF3kVDHWKX2HEaVqMsWodVzuz?=
 =?us-ascii?Q?iUkuBA8rQVOVdK21wYRKssko0tajqwBelLxPCfL9GdSZDAkfMC7y3GXIaEQw?=
 =?us-ascii?Q?UoWwmI1A4C4gR8sKk5Xu1pJVbqghgXlCvwmWkBHLJNKeXt2BrKtbbXj42r1z?=
 =?us-ascii?Q?47VcOp7yZ6XNKW3JIKUqSM2/Jpl86mLom86rN/12OqZ4VFKSo76Jx4VjHzX0?=
 =?us-ascii?Q?2StqhXWXW6d1iHF3RfYmfsm3yuAIZTlq6n0lsF3LCUPaWW9MukBM/560aGZE?=
 =?us-ascii?Q?tDDDmwBcAvT7a4kp5nrLeROYj73a1CkjbGwU1LfJ?=
x-ms-exchange-antispam-messagedata-1: kFT+0Vc8Tfv0yVLKCjNgNPSLnoM4INF2oAP7E4rI5hugLoUQR+ixnv5I/oYnWe8t3llmypws51zn9xp6N4nS3UyITR2UoexKfwCdBOsT48Yqtq6Peia6NpmbZOm4JpXUySgDIRs1PAOLcm4zN6PJiinSUtmzIUnVMwe5rn5uujopRppmG6qqICRUi7WyawJZ+jvd4m+W5EguTZqgDEvQViPpaZ+haHlqnksNJsE3ugegjvPA0g32nZQ0YWUQdpV9bVNEwPItOnoR4AVeDw/Zjsyd24mNSVT6ty6d2gkF+ahAMMwmY3RlR6d+ZQfwKwaSETc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR0201MB3553.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86070d76-ec7d-4b83-0e9a-08d9203f1474
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 12:09:14.6105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tpYkvzcW6YUaZpAZYgeOTc+xZ2tsoD5Cr7XPcxhSSXxLFGKBCinjGPIzlj0b0H8mUC4v7xg17udxQgIXof989JONa3VfTxxI1JM0bSSPThc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB3320
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mike Rapoport <rppt@linux.ibm.com>
> Sent: Wednesday, May 26, 2021 2:40 AM
> To: Qian Cai (QUIC) <quic_qiancai@quicinc.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>; David Hildenbrand <david@r=
edhat.com>; Catalin Marinas
> <catalin.marinas@arm.com>; Anshuman Khandual <anshuman.khandual@arm.com>;=
 Ard Biesheuvel <ardb@kernel.org>; Linux
> Memory Management List <linux-mm@kvack.org>; Will Deacon <will@kernel.org=
>; Marc Zyngier <maz@kernel.org>; Linux Kernel
> Mailing List <linux-kernel@vger.kernel.org>; Linux ARM <linux-arm-kernel@=
lists.infradead.org>
> Subject: Re: Arm64 crash while reading memory sysfs
>=20
> Hi,
>=20
> On Tue, May 25, 2021 at 03:25:59PM +0000, Qian Cai (QUIC) wrote:
> > Reverting the patchset "arm64: drop pfn_valid_within() and simplify pfn=
_valid()" [1] from today's linux-next fixed a crash while
> reading files under /sys/devices/system/memory.
>=20
> Can you please send the beginning of the boot log, up to the
> 	 "Memory: xK/yK available ..."
> line?

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x503f0002]
[    0.000000] Linux version 5.13.0-rc3-next-20210525+ (root@admin5) (gcc (=
Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34)=
 #27 SMP Tue May 25 19:03:24 UTC 2021
[    0.000000] efi: EFI v2.70 by American Megatrends
[    0.000000] efi: ACPI 2.0=3D0x9ff5b40000 SMBIOS 3.0=3D0x9ff686fd98 ESRT=
=3D0x9ff1d18298 MEMRESERVE=3D0x9fe6dbed98
[    0.000000] esrt: Reserving ESRT space from 0x0000009ff1d18298 to 0x0000=
009ff1d182f8.
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x0000009FF5B40000 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x0000009FF5B40028 000094 (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x0000009FF5B400C0 000114 (v06 Ampere eMAG     00=
000003 INTL 20190509)
[    0.000000] ACPI: DSDT 0x0000009FF5B401D8 00765A (v05 ALASKA A M I    00=
000001 INTL 20190509)
[    0.000000] ACPI: FIDT 0x0000009FF5B47838 00009C (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.000000] ACPI: DBG2 0x0000009FF5B478D8 000061 (v00 Ampere eMAG     00=
000000 INTL 20190509)
[    0.000000] ACPI: GTDT 0x0000009FF5B47940 000108 (v02 Ampere eMAG     00=
000001 INTL 20190509)
[    0.000000] ACPI: IORT 0x0000009FF5B47A48 000BCC (v00 Ampere eMAG     00=
000000 INTL 20190509)
[    0.000000] ACPI: MCFG 0x0000009FF5B48618 0000AC (v01 Ampere eMAG     00=
000001 INTL 20190509)
[    0.000000] ACPI: SSDT 0x0000009FF5B486C8 00002D (v02 Ampere eMAG     00=
000001 INTL 20190509)
[    0.000000] ACPI: SPMI 0x0000009FF5B486F8 000041 (v05 ALASKA A M I    00=
000000 AMI. 00000000)
[    0.000000] ACPI: APIC 0x0000009FF5B48740 000A68 (v04 Ampere eMAG     00=
000004      01000013)
[    0.000000] ACPI: PCCT 0x0000009FF5B491A8 0005D0 (v01 Ampere eMAG     00=
000003      01000013)
[    0.000000] ACPI: BERT 0x0000009FF5B49778 000030 (v01 Ampere eMAG     00=
000003 INTL 20190509)
[    0.000000] ACPI: HEST 0x0000009FF5B497A8 000328 (v01 Ampere eMAG     00=
000003 INTL 20190509)
[    0.000000] ACPI: SPCR 0x0000009FF5B49AD0 000050 (v02 A M I  APTIO V  01=
072009 AMI. 0005000D)
[    0.000000] ACPI: PPTT 0x0000009FF5B49B20 000CB8 (v01 Ampere eMAG     00=
000003      01000013)
[    0.000000] ACPI: SPCR: console: pl011,mmio32,0x12600000,115200
[    0.000000] NUMA: Failed to initialise from firmware
[    0.000000] NUMA: Faking a node at [mem 0x0000000090000000-0x0000009ffff=
fffff]
[    0.000000] NUMA: NODE_DATA [mem 0x9ffefbabc0-0x9ffefbffff]
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000090000000-0x0000009fffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000090000000-0x0000000091ffffff]
[    0.000000]   node   0: [mem 0x0000000092000000-0x00000000928fffff]
[    0.000000]   node   0: [mem 0x0000000092900000-0x00000000fffbffff]
[    0.000000]   node   0: [mem 0x00000000fffc0000-0x00000000ffffffff]
[    0.000000]   node   0: [mem 0x0000000880000000-0x0000000fffffffff]
[    0.000000]   node   0: [mem 0x0000008800000000-0x0000009ff5aeffff]
[    0.000000]   node   0: [mem 0x0000009ff5af0000-0x0000009ff5b2ffff]
[    0.000000]   node   0: [mem 0x0000009ff5b30000-0x0000009ff5baffff]
[    0.000000]   node   0: [mem 0x0000009ff5bb0000-0x0000009ff7deffff]
[    0.000000]   node   0: [mem 0x0000009ff7df0000-0x0000009ff7e5ffff]
[    0.000000]   node   0: [mem 0x0000009ff7e60000-0x0000009ff7ffffff]
[    0.000000]   node   0: [mem 0x0000009ff8000000-0x0000009fffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000090000000-0x0000009ffffff=
fff]
[    0.000000] kasan: KernelAddressSanitizer initialized
[    0.000000] psci: probing for conduit method from ACPI.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v65535.65535
[    0.000000] ACPI: SRAT not present
[    0.000000] percpu: Embedded 10 pages/cpu s584592 r8192 d62576 u655360
[    0.000000] pcpu-alloc: s584592 r8192 d62576 u655360 alloc=3D10*65536
[    0.000000] pcpu-alloc: [0] 00 [0] 01 [0] 02 [0] 03 [0] 04 [0] 05 [0] 06=
 [0] 07
[    0.000000] pcpu-alloc: [0] 08 [0] 09 [0] 10 [0] 11 [0] 12 [0] 13 [0] 14=
 [0] 15
[    0.000000] pcpu-alloc: [0] 16 [0] 17 [0] 18 [0] 19 [0] 20 [0] 21 [0] 22=
 [0] 23
[    0.000000] pcpu-alloc: [0] 24 [0] 25 [0] 26 [0] 27 [0] 28 [0] 29 [0] 30=
 [0] 31
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: Spectre-v2
[    0.000000] CPU features: detected: Spectre-v4
[    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 20910=
12
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=3D/vmlinuz-5.13.0-rc3-next-2=
0210525+ root=3D/dev/mapper/ubuntu--vg-ubuntu--lv ro cma=3D1024M iommu.pass=
through=3D1
[    0.000000] Unknown command line parameters: BOOT_IMAGE=3D/vmlinuz-5.13.=
0-rc3-next-20210525+ cma=3D1024M
[    0.000000] Dentry cache hash table entries: 8388608 (order: 10, 6710886=
4 bytes, linear)
[    0.000000] Inode-cache hash table entries: 4194304 (order: 9, 33554432 =
bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.000000] Memory: 777216K/133955584K available (17920K kernel code, 11=
8786K rwdata, 4416K rodata, 6080K init, 67276K bss, 17379072K reserved, 0K =
cma-reserved)

>=20
> > [1] https://lore.kernel.org/kvmarm/20210511100550.28178-1-rppt@kernel.o=
rg/
> >
> > [  247.669668][ T1443] kernel BUG at include/linux/mm.h:1383!
> > [  247.675987][ T1443] Internal error: Oops - BUG: 0 [#1] SMP
> > [  247.681472][ T1443] Modules linked in: loop processor efivarfs ip_ta=
bles x_tables ext4 mbcache jbd2 dm_mod igb i2c_algo_bit
> nvme mlx5_core i2c_core nvme_core firmware_class
> > [  247.696894][ T1443] CPU: 15 PID: 1443 Comm: ranbug Not tainted 5.13.=
0-rc3-next-20210524+ #11
> > [  247.705326][ T1443] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RA=
PTOR, BIOS 1.6 06/28/2020
> > [  247.713842][ T1443] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=
=3D--)
> > [  247.720536][ T1443] pc : test_pages_in_a_zone+0x23c/0x300
> > [  247.725935][ T1443] lr : test_pages_in_a_zone+0x23c/0x300
> > [  247.731327][ T1443] sp : ffff800023f8f670
> > [  247.735327][ T1443] x29: ffff800023f8f670 x28: 000000000000a000 x27:=
 000000000000a000
> > [  247.743156][ T1443] x26: ffffffbfffe00000 x25: ffff800011c6f738 x24:=
 dfff800000000000
> > [  247.750984][ T1443] x23: 0000000000002000 x22: ffff009f7efa29c0 x21:=
 0000000000000000
> > [  247.758812][ T1443] x20: ffffffffffffffff x19: 0000000000008000 x18:=
 ffff00084f9d3370
> > [  247.766640][ T1443] x17: 0000000000000000 x16: 0000000000000007 x15:=
 0000000000000078
> > [  247.774467][ T1443] x14: 0000000000000000 x13: ffff800011c6eea4 x12:=
 ffff60136cee0574
> > [  247.782295][ T1443] x11: 1fffe0136cee0573 x10: ffff60136cee0573 x9 :=
 dfff800000000000
> > [  247.790123][ T1443] x8 : ffff009b67702b9b x7 : 0000000000000001 x6 :=
 ffff009b67702b98
> > [  247.797951][ T1443] x5 : 00009fec9311fa8d x4 : ffff009b67702b98 x3 :=
 1fffe00109f3a529
> > [  247.805778][ T1443] x2 : 0000000000000000 x1 : 0000000000000000 x0 :=
 0000000000000034
> > [  247.813606][ T1443] Call trace:
> > [  247.816738][ T1443]  test_pages_in_a_zone+0x23c/0x300
> > [  247.821784][ T1443]  valid_zones_show+0x1e0/0x298
> > [  247.826483][ T1443]  dev_attr_show+0x50/0xc8
> > [  247.830747][ T1443]  sysfs_kf_seq_show+0x164/0x368
> > [  247.835533][ T1443]  kernfs_seq_show+0x130/0x198
> > [  247.840143][ T1443]  seq_read_iter+0x344/0xd50
> > [  247.844581][ T1443]  kernfs_fop_read_iter+0x32c/0x4a8
> > [  247.849625][ T1443]  new_sync_read+0x2bc/0x4e8
> > [  247.854063][ T1443]  vfs_read+0x18c/0x340
> > [  247.858066][ T1443]  ksys_read+0xf8/0x1e0
> > [  247.862068][ T1443]  __arm64_sys_read+0x74/0xa8
> > [  247.866591][ T1443]  invoke_syscall.constprop.0+0xdc/0x1d8
> > [  247.872072][ T1443]  do_el0_svc+0xe4/0x298
> > [  247.876162][ T1443]  el0_svc+0x20/0x30
> > [  247.879906][ T1443]  el0_sync_handler+0xb0/0xb8
> > [  247.884429][ T1443]  el0_sync+0x178/0x180
> > [  247.888435][ T1443] Code: b0005ee1 912b8021 910b0021 97fc57ac (d4210=
000)
> > [  247.895217][ T1443] ---[ end trace 4ff9f5cbe7443f54 ]---
> > [  247.900522][ T1443] Kernel panic - not syncing: Oops - BUG: Fatal ex=
ception
> > [  247.907501][ T1443] SMP: stopping secondary CPUs
> > [  247.912122][ T1443] Kernel Offset: disabled
> > [  247.916296][ T1443] CPU features: 0x00000251,20000846
> > [  247.921340][ T1443] Memory Limit: none
> > [  247.925100][ T1443] ---[ end Kernel panic - not syncing: Oops - BUG:=
 Fatal exception ]---
> >
>=20
> --
> Sincerely yours,
> Mike.
