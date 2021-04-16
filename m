Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B1C362332
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236710AbhDPO6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:58:44 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:21018 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235784AbhDPO6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:58:43 -0400
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GEj6qu029713;
        Fri, 16 Apr 2021 14:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=ANeabVMz/5+G24ihAqcUDXTzVxOXBSe47zWvNvMOVTo=;
 b=RrBTUwtI8fvzo94sWfvZ2ZFhzfEjC/ndFAXGy4LAWkiXqADXCGF4mFa+6DLcqdvL9Oop
 O7vDoDcj82k0/CYQGlGKM8BCw7/js80fGUxj4oySD9yKmEbHLH1dBteKGv1dnSAHXErX
 D3mz5RxRvonGoUkHH9Qcg6eDy4dTWYQ3V+0x25lhGRDJzp859iSCoTcNr1MZ9udIik8G
 2uHFCfWQq1svAymVCy+jjgHlKrfzbaMDWe8t5DFtl3rj4rDt+H2bmRXwiAQX7pskduW8
 tSieiELzOSgUInq7F+WzMVs/+QUOfC5yJeCHa1Crpi4cvwxeFHWemlFvq0Kq67DjqJ/m Ug== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 37yapfs2p3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 14:57:55 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id AC28A57;
        Fri, 16 Apr 2021 14:57:54 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.214.132.81])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id A1EBF4B;
        Fri, 16 Apr 2021 14:57:53 +0000 (UTC)
Date:   Fri, 16 Apr 2021 09:57:53 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     steve.wahl@hpe.com, mike.travis@hpe.com, dimitri.sivanich@hpe.com,
        russ.anderson@hpe.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/platform/uv: Fix inconsistent indenting
Message-ID: <YHml8enBsBMpdZmS@swahl-home.5wahls.com>
References: <1618567840-15891-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618567840-15891-1-git-send-email-yang.lee@linux.alibaba.com>
X-Proofpoint-ORIG-GUID: p0B3MKK1zkBoQsqvduc-vxuMgq5oORjz
X-Proofpoint-GUID: p0B3MKK1zkBoQsqvduc-vxuMgq5oORjz
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_07:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=931 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

On Fri, Apr 16, 2021 at 06:10:40PM +0800, Yang Li wrote:
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

-- 
Steve Wahl, Hewlett Packard Enterprise
