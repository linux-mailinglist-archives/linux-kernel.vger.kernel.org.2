Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE7F307B0F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 17:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhA1QfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 11:35:20 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19994 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbhA1Qeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 11:34:36 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6012e7700003>; Thu, 28 Jan 2021 08:33:52 -0800
Received: from [10.2.82.52] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Jan
 2021 16:33:47 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Saravanan D <saravanand@fb.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
CC:     <x86@kernel.org>, <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>, <corbet@lwn.net>, <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
        <songliubraving@fb.com>
Subject: Re: [PATCH V5] x86/mm: Tracking linear mapping split events
Date:   Thu, 28 Jan 2021 11:33:44 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <EBB7E363-FE25-453C-89C6-9FC4A90615B9@nvidia.com>
In-Reply-To: <20210128104934.2916679-1-saravanand@fb.com>
References: <20210128045153.GW308988@casper.infradead.org>
 <20210128104934.2916679-1-saravanand@fb.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_5C1AD883-7825-4E80-8839-4199C78D1031_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611851632; bh=Zfk97yaqogAjm1bMAkwOEzz49+gINLUYlKBn8vw3Osw=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=gNYwRdMgQ8lYtVxw+oZX3R99XIX0S5QPRGTgR9otFWlyO7DGbU8t7gSjZsvh+UWpN
         HAuaLQIkls7Mm7/hMv/lmy8T8FGXCelkrTFNdRZVo2rNz5Sd0R7f3c9GwtqYovzeD4
         lN09VN/DPGXTG0uh+YTJslEffLOIr9LKmKq0uMToUp7hIZwVGwKyQzs6jgc4tJG00K
         4WLtNCtXLZCN52r2UJ+tCuSTAicE77JiKmmjkCENwkRunY8PBrGUSYlIb9SSHOIq6m
         7Ur5vQ5+xkStdr4kt3RSHp/4fOllC9XsKG0kTsGezupvZmOZEt/URyzvJK6idjLbWf
         PM/e4058uDKLQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_5C1AD883-7825-4E80-8839-4199C78D1031_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 28 Jan 2021, at 5:49, Saravanan D wrote:

> To help with debugging the sluggishness caused by TLB miss/reload,
> we introduce monotonic lifetime hugepage split event counts since
> system state: SYSTEM_RUNNING to be displayed as part of
> /proc/vmstat in x86 servers
>
> The lifetime split event information will be displayed at the bottom of=

> /proc/vmstat
> ....
> swap_ra 0
> swap_ra_hit 0
> direct_map_level2_splits 94
> direct_map_level3_splits 4
> nr_unstable 0
> ....
>
> One of the many lasting (as we don't coalesce back) sources for huge pa=
ge
> splits is tracing as the granular page attribute/permission changes wou=
ld
> force the kernel to split code segments mapped to huge pages to smaller=

> ones thereby increasing the probability of TLB miss/reload even after
> tracing has been stopped.

It is interesting to see this statement saying splitting kernel direct ma=
ppings
causes performance loss, when Zhengjun (cc=E2=80=99d) from Intel recently=
 posted
a kernel direct mapping performance report[1] saying 1GB mappings are goo=
d
but not much better than 2MB and 4KB mappings.

I would love to hear the stories from both sides. Or maybe I misunderstan=
d
anything.


[1]https://lore.kernel.org/linux-mm/213b4567-46ce-f116-9cdf-bbd0c884eb3c@=
linux.intel.com/
>
> Documentation regarding linear mapping split events added to admin-guid=
e
> as requested in V3 of the patch.
>
> Signed-off-by: Saravanan D <saravanand@fb.com>
> ---
>  .../admin-guide/mm/direct_mapping_splits.rst  | 59 +++++++++++++++++++=

>  Documentation/admin-guide/mm/index.rst        |  1 +
>  arch/x86/mm/pat/set_memory.c                  |  8 +++
>  include/linux/vm_event_item.h                 |  4 ++
>  mm/vmstat.c                                   |  4 ++
>  5 files changed, 76 insertions(+)
>  create mode 100644 Documentation/admin-guide/mm/direct_mapping_splits.=
rst
>
> diff --git a/Documentation/admin-guide/mm/direct_mapping_splits.rst b/D=
ocumentation/admin-guide/mm/direct_mapping_splits.rst
> new file mode 100644
> index 000000000000..298751391deb
> --- /dev/null
> +++ b/Documentation/admin-guide/mm/direct_mapping_splits.rst
> @@ -0,0 +1,59 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Direct Mapping Splits
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Kernel maps all of physical memory in linear/direct mapped pages with
> +translation of virtual kernel address to physical address is achieved
> +through a simple subtraction of offset. CPUs maintain a cache of these=

> +translations on fast caches called TLBs. CPU architectures like x86 al=
low
> +direct mapping large portions of memory into hugepages (2M, 1G, etc) i=
n
> +various page table levels.
> +
> +Maintaining huge direct mapped pages greatly reduces TLB miss pressure=
=2E
> +The splintering of huge direct pages into smaller ones does result in
> +a measurable performance hit caused by frequent TLB miss and reloads.
> +
> +One of the many lasting (as we don't coalesce back) sources for huge p=
age
> +splits is tracing as the granular page attribute/permission changes wo=
uld
> +force the kernel to split code segments mapped to hugepages to smaller=

> +ones thus increasing the probability of TLB miss/reloads even after
> +tracing has been stopped.
> +
> +On x86 systems, we can track the splitting of huge direct mapped pages=

> +through lifetime event counters in ``/proc/vmstat``
> +
> +	direct_map_level2_splits xxx
> +	direct_map_level3_splits yyy
> +
> +where:
> +
> +direct_map_level2_splits
> +	are 2M/4M hugepage split events
> +direct_map_level3_splits
> +	are 1G hugepage split events
> +
> +The distribution of direct mapped system memory in various page sizes
> +post splits can be viewed through ``/proc/meminfo`` whose output
> +will include the following lines depending upon supporting CPU
> +architecture
> +
> +	DirectMap4k:    xxxxx kB
> +	DirectMap2M:    yyyyy kB
> +	DirectMap1G:    zzzzz kB
> +
> +where:
> +
> +DirectMap4k
> +	is the total amount of direct mapped memory (in kB)
> +	accessed through 4k pages
> +DirectMap2M
> +	is the total amount of direct mapped memory (in kB)
> +	accessed through 2M pages
> +DirectMap1G
> +	is the total amount of direct mapped memory (in kB)
> +	accessed through 1G pages
> +
> +
> +-- Saravanan D, Jan 27, 2021
> diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/adm=
in-guide/mm/index.rst
> index 4b14d8b50e9e..9439780f3f07 100644
> --- a/Documentation/admin-guide/mm/index.rst
> +++ b/Documentation/admin-guide/mm/index.rst
> @@ -38,3 +38,4 @@ the Linux memory management.
>     soft-dirty
>     transhuge
>     userfaultfd
> +   direct_mapping_splits
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.=
c
> index 16f878c26667..a7b3c5f1d316 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -16,6 +16,8 @@
>  #include <linux/pci.h>
>  #include <linux/vmalloc.h>
>  #include <linux/libnvdimm.h>
> +#include <linux/vmstat.h>
> +#include <linux/kernel.h>
>
>  #include <asm/e820/api.h>
>  #include <asm/processor.h>
> @@ -91,6 +93,12 @@ static void split_page_count(int level)
>  		return;
>
>  	direct_pages_count[level]--;
> +	if (system_state =3D=3D SYSTEM_RUNNING) {
> +		if (level =3D=3D PG_LEVEL_2M)
> +			count_vm_event(DIRECT_MAP_LEVEL2_SPLIT);
> +		else if (level =3D=3D PG_LEVEL_1G)
> +			count_vm_event(DIRECT_MAP_LEVEL3_SPLIT);
> +	}
>  	direct_pages_count[level - 1] +=3D PTRS_PER_PTE;
>  }
>
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_ite=
m.h
> index 18e75974d4e3..7c06c2bdc33b 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -120,6 +120,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWP=
OUT,
>  #ifdef CONFIG_SWAP
>  		SWAP_RA,
>  		SWAP_RA_HIT,
> +#endif
> +#ifdef CONFIG_X86
> +		DIRECT_MAP_LEVEL2_SPLIT,
> +		DIRECT_MAP_LEVEL3_SPLIT,
>  #endif
>  		NR_VM_EVENT_ITEMS
>  };
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index f8942160fc95..a43ac4ac98a2 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1350,6 +1350,10 @@ const char * const vmstat_text[] =3D {
>  	"swap_ra",
>  	"swap_ra_hit",
>  #endif
> +#ifdef CONFIG_X86
> +	"direct_map_level2_splits",
> +	"direct_map_level3_splits",
> +#endif
>  #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
>  };
>  #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMC=
G */
> -- =

> 2.24.1


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_5C1AD883-7825-4E80-8839-4199C78D1031_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmAS52kPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKA9sP/0ERLg9Vt66eIMmcmhavpAZahCwnfeRdh0v+
zTJHkmzh1v/KBVqPlZKuWOVbmUIfubU0TzRhR5fm0UeiAkYVmiCdk4LI0ocZnJUD
z2fRJqJLTUcidALId07oQmerHWeSBZt3pSTQPxRsopNZJDzL1t/tpM9ycP5A31vm
p8+rY7kr2T5WAc7GCnwzRKZfXOX9223wLG3TVoMyxlVG8O55GiC9FfBbKQJWL0st
STPEI+ZQ9m+wgI8SZCOE7ObPzZM3YrRNiVeHCc7ifpGPirUgq1KLpggIKT0X36S0
p0OPPdUfaNv5xDCBvilnU6Ry7qrDnQy996AvxaUViCRwaSu7y61eVGh4lUkfavFA
KwnRF+sBTtTH23hoKo9xYJhj3LI1SwWkDZGFM/9hxY3vI5qROH1gAXQQqO6FwVxU
Jqnt85S2g7G6t68rUsr5M/K3+E0vRmFAKfFuf0D5Xdee/xhpLIpfHnqMhShQ+1Sv
04AT5uwWrCbTZNl76nkUCmfQmKipxvvRnnHNKJLdxvpOwyu1+BnCG00HXTS8ku6F
tIAuU4uAFKBvOW+nUV8756FxD5fklIM0r+fwFPsicHX8pUm1jisveUXWUJiOTLAS
9rJVAjQHbzVFB/U6YW/acEdlvtaI2d2HRoWLy7okB3QdFobuOiYvRC2zxNLdG+Ob
alIIwmV6
=yDN8
-----END PGP SIGNATURE-----

--=_MailMate_5C1AD883-7825-4E80-8839-4199C78D1031_=--
