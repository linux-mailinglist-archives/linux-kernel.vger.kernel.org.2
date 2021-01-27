Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF6330631E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 19:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbhA0SUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 13:20:45 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:4358 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234878AbhA0SUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 13:20:38 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10RIFAxV029927;
        Wed, 27 Jan 2021 10:19:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Bzg7zKkXfRep3Zy3/IdTtvaGAK29KAdDxuiHyIdLVMU=;
 b=gjtNxtEUerO7RtkeX//8zDTwreA7v8lwaFwjGa0zKHYdmS0KbhXaHIoPM5Ms0dcXF5Po
 6eZe9dopM8oR9456zTpoTC1uJRbZ+tRSqLalriv4u3x5EzXYS9B9jn2koGNTRShnrFDA
 /Tb6GLd1lokGAL1pO7YAx+dfgGVZM+R65YM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36b82t1xcd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Jan 2021 10:19:45 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 27 Jan 2021 10:19:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNzGTOSqhApft+unf37K1OWAWaOX8H0kMLmHEi6W7S+jGnjm1cb4pa36/4LV9Aj8UiGeLDTxRDOd0l1YQRaXWHKAg6Dl8Ivecsro/Yg4xa/WOwmoMivgwC5JfHX/+fhlzR4kc3TW9EgG4FcHSeyvTGJjG/W15iRsc0AxWQ0DFYpQdkn2AcUpNeF4aml4FZm7id4sg2yYscFniIGHgWfn3g9Kcq9/KedyVZ69TaHqFbzJMfEX4zt9tl5HaJ+XHDZcqwovH8wxV0B+rR8EYCj3VcR7NZO3w36GHdUITxSFAQsUyrWbbQTBNE959efQ8/k4WG0AIG6ZAzF2KGiH1p2DAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bzg7zKkXfRep3Zy3/IdTtvaGAK29KAdDxuiHyIdLVMU=;
 b=DIdEPyRi/tyffV9n0weuHijrXhWHdosgl6BNqOckm4yl04l9XHM21m9w3d20+PRjBtGxGsFFoTqT2I93IB2+ZJaKWxt1beg7s4HiyiaYMdBhx2P6td2yvQIP9zcqXVAItxRF+ChreK9tO2zYeWXKcYBq6XON/nDFpyVBqJPSi6p+pgW+fq1jl1FDaVupa4hpCtG96oEos7kwbKiwfxdYzyXq5cvxeBSxBCpFwIEBlMTbjeUolgjJVY5f0Fvbh/h+R7cG6YrAoNlObBzGjxhqZT+xi9BpbMvR1Y7anYirgRke3ZsxKJU9Q0YNt2kVJDFv/jk+zFazI1ziJUBC7K0Evg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bzg7zKkXfRep3Zy3/IdTtvaGAK29KAdDxuiHyIdLVMU=;
 b=Trg8hHCX3XIDhZxmjJ6QzwYuEs0xF+PjMdD2IIDzT19hjdqlSz/C5m19Neg/y2OiftcD2zEeQDU9inJkO1E1kcZ1lqOkRnupM2CfUFH6g47TAjWxNDmIeQwCPGeT+r5NYLtbUTsQEbaWAamNdI553gby1wXWuv+Iex3Iwxk46u8=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2215.namprd15.prod.outlook.com (2603:10b6:a02:89::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Wed, 27 Jan
 2021 18:19:42 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%6]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 18:19:42 +0000
Date:   Wed, 27 Jan 2021 10:19:37 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, slub: remove slub_memcg_sysfs boot param and
 CONFIG_SLUB_MEMCG_SYSFS_ON
Message-ID: <20210127181937.GA917442@carbon.dhcp.thefacebook.com>
References: <20210127124745.7928-1-vbabka@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127124745.7928-1-vbabka@suse.cz>
X-Originating-IP: [2620:10d:c090:400::5:b670]
X-ClientProxiedBy: MWHPR15CA0071.namprd15.prod.outlook.com
 (2603:10b6:301:4c::33) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:b670) by MWHPR15CA0071.namprd15.prod.outlook.com (2603:10b6:301:4c::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 18:19:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4ebb7e2-f768-4a82-c278-08d8c2f01daa
X-MS-TrafficTypeDiagnostic: BYAPR15MB2215:
X-Microsoft-Antispam-PRVS: <BYAPR15MB22158E421748B285A701C0EBBEBB9@BYAPR15MB2215.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xW20YJuZBzfn0zwPnlvslpEzq/ybEm12VFqo482banUYNzMTVizCPvpPcORNb24jR5yNfaDvtwvbj4QuGsOweYguMxdDqyIwkJJrT1RgvbEnRgXRsorB44rBpHzv85lo2RVTnbvbQ+/R0h5jmLiX6nFZFX0VQQmkcDVvImrJ+6cAoUfTf/nFLQvasZz80pUO2NtjME3pTXeTl0Sv/ZFeZ2WBIQILLf4JnDFqWLUpt+TIqd3dlIUmltBoSJliyuiwruyhY6fhVvQoIIBU2gIi+f/2+VmR9jG9ZQx/eVMW96J3XbWuZLb1z/kx7muUr/voI+0Y5ZQEmHGOQd82D4K6FN9kE1pTKSyNTn5IkzzD7YH1m0ixTW7h7kcdu5jgmLXKa8h+vmFfSqdc6dUwsAwo+hO7qkjL5Qx/0noTMquV4MNXQConmOkwwmIyZ9zE8G0LfYTO85LneFMNV0A6/yZymOKLDnX21AqyeSo8mYGkkgL8d2q4en+i/APAJAtIHUv1+OmV+d2XOiLjfVwn/4yFag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(346002)(376002)(366004)(6666004)(66556008)(83380400001)(54906003)(6916009)(186003)(316002)(7696005)(478600001)(4326008)(52116002)(6506007)(5660300002)(2906002)(33656002)(8676002)(1076003)(86362001)(16526019)(9686003)(66476007)(8936002)(66946007)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UcqRopDfluBhPQKhM79ufJIwOKvKC6xyd+h9XGMnAsYKYPqazT/VQNU4Oixw?=
 =?us-ascii?Q?oROweg+kCN8Bf07H3vmcwGY+hkB+EvPIEp4qgkhlqLDwIGUQA2XXNY86y/cL?=
 =?us-ascii?Q?OYf/VGlaIARJwClM9WqjsTymyESj3QB2DlXhqL/UqOZravMcFQCV9JzZsp4A?=
 =?us-ascii?Q?BRhF4bhf/YeocBSPSR6UOa5pwxy+j74fqmBSyKOZf4YVh+Qgc2oRnS/U9CPL?=
 =?us-ascii?Q?ZKS5VhU1JggvXz6ypqLac/HtwqUWJumUzU9A2kA6aT8PHQVR+QSryPn0q/VQ?=
 =?us-ascii?Q?0nEHRWIOBB4rYQdrQLurvvwrZRaIxkw2JIlnwBEU84C31+3WGgYV8EYsWd68?=
 =?us-ascii?Q?y/qQv/0Gi58WbkM8ncAyviPAy7hlvVzhp7kgZePb1OMj0T7IjX9I9/xNJ0Vo?=
 =?us-ascii?Q?vmoB4MLeD72mRXzVFfph6VG68LsCYIm7iG1manyHYGQT+F6pmACF7+hfblZp?=
 =?us-ascii?Q?AIq9/+h5LNryNS/LxwoQvjb8XKPuWNMyssBvCkxHYSx90kWmnUzOWneC+RP4?=
 =?us-ascii?Q?wHtbH7dYumTj/2VDrcnno54j473QyS3Cj3RS7FfBCheJC4687htkiylr2PYs?=
 =?us-ascii?Q?AAet+RmiRhKEOIVqh6E/EZJEQPWYnIRvk4/AqgMWk1s4MxCU5Dmb9fPHizUe?=
 =?us-ascii?Q?a3+wU6Iq53Vwz66P0dj8f3ii5VmL6rL7chBFACF0jzq66El8Jyi9G9sdOlWl?=
 =?us-ascii?Q?gFUG4EkD/bOILYl5mriN8Rb9KrdpIbX8ooiPEofMlzEinALbwT3RfxxCaqqi?=
 =?us-ascii?Q?nqMvurWRGHbocomc12WITCpX5vjDPq/h7/DUhOQ9RlJCaezbix2CryJbTMYR?=
 =?us-ascii?Q?gMiW5E/vGInjieizXstrI7o8y1kam+btJ6BSIYGyRVaKQMxMlAA5492YmOY7?=
 =?us-ascii?Q?COUAIlSdX115HTAZAleYJ8L8ZACsUsIaMk19m3EUcMJY1IVhMYD5e8k7oE56?=
 =?us-ascii?Q?VKwe9IrXdx2r3B1tAQ6l8EO6VewK3wa6aFFMivw7+QA+eeN+HYc8JUQY2SJ3?=
 =?us-ascii?Q?gOVKkZVlRbkb/5Fsgi6/OlCmh37srBYifYxZVYH6sCP6QXKtzRbifNjXhn/n?=
 =?us-ascii?Q?IfdPaOJY1wxQKG0UOv+oreT4+N0cPgG8VQrBuwXZXFoVInmx8KQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ebb7e2-f768-4a82-c278-08d8c2f01daa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 18:19:42.1153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqTTcbt9RHYPpMklkmjaE7cnSi9HL4+1J2+fI/KMRPLos14KvRHAWnC5WTUXLr7e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2215
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-27_06:2021-01-27,2021-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxlogscore=972 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101270091
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 01:47:45PM +0100, Vlastimil Babka wrote:
> The boot param and config determine the value of memcg_sysfs_enabled, which is
> unused since commit 10befea91b61 ("mm: memcg/slab: use a single set of
> kmem_caches for all allocations") as there are no per-memcg kmem caches
> anymore.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Nice cleanup!

Acked-by: Roman Gushchin <guro@fb.com>

Thanks, Vlastimil!
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  8 --------
>  init/Kconfig                                    | 14 --------------
>  mm/slub.c                                       | 16 ----------------
>  3 files changed, 38 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f4497faef266..7dc351da0005 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4892,14 +4892,6 @@
>  			last alloc / free. For more information see
>  			Documentation/vm/slub.rst.
>  
> -	slub_memcg_sysfs=	[MM, SLUB]
> -			Determines whether to enable sysfs directories for
> -			memory cgroup sub-caches. 1 to enable, 0 to disable.
> -			The default is determined by CONFIG_SLUB_MEMCG_SYSFS_ON.
> -			Enabling this can lead to a very high number of	debug
> -			directories and files being created under
> -			/sys/kernel/slub.
> -
>  	slub_max_order= [MM, SLUB]
>  			Determines the maximum allowed order for slabs.
>  			A high setting may cause OOMs due to memory
> diff --git a/init/Kconfig b/init/Kconfig
> index e4e2932da237..af454a51f3c5 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1851,20 +1851,6 @@ config SLUB_DEBUG
>  	  SLUB sysfs support. /sys/slab will not exist and there will be
>  	  no support for cache validation etc.
>  
> -config SLUB_MEMCG_SYSFS_ON
> -	default n
> -	bool "Enable memcg SLUB sysfs support by default" if EXPERT
> -	depends on SLUB && SYSFS && MEMCG
> -	help
> -	  SLUB creates a directory under /sys/kernel/slab for each
> -	  allocation cache to host info and debug files. If memory
> -	  cgroup is enabled, each cache can have per memory cgroup
> -	  caches. SLUB can create the same sysfs directories for these
> -	  caches under /sys/kernel/slab/CACHE/cgroup but it can lead
> -	  to a very high number of debug files being created. This is
> -	  controlled by slub_memcg_sysfs boot parameter and this
> -	  config option determines the parameter's default value.
> -
>  config COMPAT_BRK
>  	bool "Disable heap randomization"
>  	default y
> diff --git a/mm/slub.c b/mm/slub.c
> index 1b5148747c64..88782727412c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5040,22 +5040,6 @@ enum slab_stat_type {
>  #define SO_OBJECTS	(1 << SL_OBJECTS)
>  #define SO_TOTAL	(1 << SL_TOTAL)
>  
> -#ifdef CONFIG_MEMCG
> -static bool memcg_sysfs_enabled = IS_ENABLED(CONFIG_SLUB_MEMCG_SYSFS_ON);
> -
> -static int __init setup_slub_memcg_sysfs(char *str)
> -{
> -	int v;
> -
> -	if (get_option(&str, &v) > 0)
> -		memcg_sysfs_enabled = v;
> -
> -	return 1;
> -}
> -
> -__setup("slub_memcg_sysfs=", setup_slub_memcg_sysfs);
> -#endif
> -
>  static ssize_t show_slab_objects(struct kmem_cache *s,
>  				 char *buf, unsigned long flags)
>  {
> -- 
> 2.30.0
> 
