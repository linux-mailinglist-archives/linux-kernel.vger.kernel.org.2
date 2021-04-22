Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BA93676E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 03:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbhDVBjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 21:39:23 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:48178 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229740AbhDVBjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 21:39:21 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13M1X4Bl027863;
        Thu, 22 Apr 2021 01:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=mOINvh3zZ6jkb1AdcO+s78AOg6BJxaFTCsenJ68M2Ms=;
 b=ZgktpzlOHLT9MbQFa0Gg/A0JT7DXz1CI5+cnQ/4No0ytW8xx1KGy6WyJzapZGOFFBMV0
 +FiuZT7wHGCWxQMY4ZnARxqMwz0Ym/aKWt/yzWDBcMpRqs6xsYlR6zY+fGzKPnL7zYt/
 HS1P1QhwwRcvmdUq2XwDUYcb0BwrIxfwxHtkXUJjBAeUE1yArthmb+/DBBOwhCGl8qF0
 fOoUEUFLaTZXkxVZQHo/GTydJUDvVxkqMy2ISVKFx7aJ3HCY9p5JovaFag7NDigdWNE0
 rQLud7/Aq6grorzPKCzUiwZ3TMf56ybxOFdBw7n3EURBE6i02zc3VZtV9IkjzqAQV/uQ Eg== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 382wnfgnpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 01:38:40 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 7142A5E;
        Thu, 22 Apr 2021 01:38:39 +0000 (UTC)
Received: from [16.99.148.179] (unknown [16.99.148.179])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 88FC64A;
        Thu, 22 Apr 2021 01:38:38 +0000 (UTC)
Subject: Re: arch/x86/kernel/apic/x2apic_uv_x.c:106 early_get_pnodeid() warn:
 inconsistent indenting
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Yang Li <yang.lee@linux.alibaba.com>
References: <202104211946.vkuV39N1-lkp@intel.com>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <84b4fbc3-0310-b7d7-f613-0eb4ae090e1e@hpe.com>
Date:   Wed, 21 Apr 2021 18:38:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <202104211946.vkuV39N1-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
X-Proofpoint-ORIG-GUID: XkiuS4G3kisLGnHN5y2M__-TaKZdiMex
X-Proofpoint-GUID: XkiuS4G3kisLGnHN5y2M__-TaKZdiMex
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_08:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220012
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm a bit confused.  I have this in my inbox that someone else has this 
fix.  So will that fix be applied or should I send a separate one that 
is essentially a duplicate?

> ----- Forwarded message from Yang Li <yang.lee@linux.alibaba.com> -----
> 
> Date: Fri, 16 Apr 2021 18:10:40 +0800
> From: Yang Li <yang.lee@linux.alibaba.com>
> To: steve.wahl@hpe.com
> CC: mike.travis@hpe.com, dimitri.sivanich@hpe.com, russ.anderson@hpe.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
> 	x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
> Subject: [PATCH] x86/platform/uv: Fix inconsistent indenting
> X-Mailer: git-send-email 1.8.3.1
> 
> Kernel test robot throws below warning ->
> 
> smatch warnings:
> arch/x86/kernel/apic/x2apic_uv_x.c:111 early_get_pnodeid() warn:
> inconsistent indenting
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  arch/x86/kernel/apic/x2apic_uv_x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
> index 52bc217..3e7534e 100644
> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
> @@ -108,7 +108,7 @@ static void __init early_get_pnodeid(void)
>  	} else if (UVH_RH_GAM_ADDR_MAP_CONFIG) {
>  		union uvh_rh_gam_addr_map_config_u  m_n_config;
>  
> -	m_n_config.v = uv_early_read_mmr(UVH_RH_GAM_ADDR_MAP_CONFIG);
> +		m_n_config.v = uv_early_read_mmr(UVH_RH_GAM_ADDR_MAP_CONFIG);
>  		uv_cpuid.n_skt = m_n_config.s.n_skt;
>  		if (is_uv(UV3))
>  			uv_cpuid.m_skt = m_n_config.s3.m_skt;
> -- 
> 1.8.3.1
> 
> 
> ----- End forwarded message -----



On 4/21/2021 4:03 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1fe5501ba1abf2b7e78295df73675423bd6899a0
> commit: 6c7794423a998478f6df0234d2dd5baa3ccbdb1d x86/platform/uv: Add UV5 direct references
> date:   7 months ago
> config: x86_64-randconfig-m001-20210421 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> smatch warnings:
> arch/x86/kernel/apic/x2apic_uv_x.c:106 early_get_pnodeid() warn: inconsistent indenting
> 
> vim +106 arch/x86/kernel/apic/x2apic_uv_x.c
> 
> 1b9b89e7f16333 arch/x86/kernel/genx2apic_uv_x.c   Yinghai Lu   2008-07-21   91
> 647128f1536efa arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05   92  static void __init early_get_pnodeid(void)
> 27229ca63269c1 arch/x86/kernel/apic/x2apic_uv_x.c Jack Steiner 2009-04-17   93  {
> d8850ba425d982 arch/x86/kernel/apic/x2apic_uv_x.c Jack Steiner 2010-11-30   94  	int pnode;
> 7a1110e861b266 arch/x86/kernel/apic/x2apic_uv_x.c Jack Steiner 2010-01-12   95
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05   96  	uv_cpuid.m_skt = 0;
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05   97  	if (UVH_RH10_GAM_ADDR_MAP_CONFIG) {
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05   98  		union uvh_rh10_gam_addr_map_config_u  m_n_config;
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05   99
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  100  		m_n_config.v = uv_early_read_mmr(UVH_RH10_GAM_ADDR_MAP_CONFIG);
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  101  		uv_cpuid.n_skt = m_n_config.s.n_skt;
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  102  		uv_cpuid.nasid_shift = 0;
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  103  	} else if (UVH_RH_GAM_ADDR_MAP_CONFIG) {
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  104  		union uvh_rh_gam_addr_map_config_u  m_n_config;
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  105
> 647128f1536efa arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05 @106  	m_n_config.v = uv_early_read_mmr(UVH_RH_GAM_ADDR_MAP_CONFIG);
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  107  		uv_cpuid.n_skt = m_n_config.s.n_skt;
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  108  		if (is_uv(UV3))
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  109  			uv_cpuid.m_skt = m_n_config.s3.m_skt;
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  110  		if (is_uv(UV2))
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  111  			uv_cpuid.m_skt = m_n_config.s2.m_skt;
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  112  		uv_cpuid.nasid_shift = 1;
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  113  	} else {
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  114  		unsigned long GAM_ADDR_MAP_CONFIG = 0;
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  115
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  116  		WARN(GAM_ADDR_MAP_CONFIG == 0,
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  117  			"UV: WARN: GAM_ADDR_MAP_CONFIG is not available\n");
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  118  		uv_cpuid.n_skt = 0;
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  119  		uv_cpuid.nasid_shift = 0;
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  120  	}
> 647128f1536efa arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  121
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  122  	if (is_uv(UV4|UVY))
> 647128f1536efa arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  123  		uv_cpuid.gnode_shift = 2; /* min partition is 4 sockets */
> 647128f1536efa arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  124
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  125  	uv_cpuid.pnode_mask = (1 << uv_cpuid.n_skt) - 1;
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  126  	pnode = (uv_node_id >> uv_cpuid.nasid_shift) & uv_cpuid.pnode_mask;
> 647128f1536efa arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  127  	uv_cpuid.gpa_shift = 46;	/* Default unless changed */
> 647128f1536efa arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  128
> 647128f1536efa arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  129  	pr_info("UV: n_skt:%d pnmsk:%x pn:%x\n",
> 6c7794423a9984 arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  130  		uv_cpuid.n_skt, uv_cpuid.pnode_mask, pnode);
> 647128f1536efa arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  131  }
> 647128f1536efa arch/x86/kernel/apic/x2apic_uv_x.c Mike Travis  2020-10-05  132
> 
> :::::: The code at line 106 was first introduced by commit
> :::::: 647128f1536efacca7bedf189790d24b22f03cca x86/platform/uv: Update UV MMRs for UV5
> 
> :::::: TO: Mike Travis <mike.travis@hpe.com>
> :::::: CC: Borislav Petkov <bp@suse.de>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
