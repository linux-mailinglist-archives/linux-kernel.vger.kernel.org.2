Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B29D3A0F0C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 10:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhFII4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 04:56:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46268 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231556AbhFII4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:56:50 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1598awPG134297;
        Wed, 9 Jun 2021 04:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=aNr4PL2+dZQnKseC9C1wnpCUTr0XP/EwUu60Miyjcqo=;
 b=REHWd7v+eay3huiT0YgVg67yfc6haxk6n47eCMwsbF3t8KyNIVjPhN8ZTjBz5z6k9Zur
 Z9OtvgSn4nhj+ACdJ8izRn5e2CmZuJZRz7Hi8qx2HySzQu1lKvqCGPPnNgAVL7Q6EYxa
 P8ueybwxwkjliupjstMQwMEI8+Tb8C3qZJhIAnF+s0nbvFYXkL84O2mfwvqm8DB3gPqR
 evpAn+llXASy9Sr1ie9ghRENPkrGNH5aFGQMpiIse7kr6F1+c5VA94O0Ec032PrbYhcZ
 KQOtiogl7Xz1E7QVum2TrvdxiMCTvYmISyf6dv4B6UEY2lK3B7VF4rOUjuM8xD6o5QYk Tg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 392qadwth4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 04:54:47 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1598qA5g011351;
        Wed, 9 Jun 2021 08:54:45 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3900hht1ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 08:54:45 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1598sh6M27394326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Jun 2021 08:54:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7E7B11C058;
        Wed,  9 Jun 2021 08:54:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BC0C11C04C;
        Wed,  9 Jun 2021 08:54:42 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.53.236])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  9 Jun 2021 08:54:41 +0000 (GMT)
Date:   Wed, 9 Jun 2021 11:54:39 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Kelley <mikelley@microsoft.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        James Morris <James.Morris@microsoft.com>
Subject: Re: [PATCH] x86/setup: Document that Windows reserves the first MiB
Message-ID: <YMCBz1ry0hKUyHgX@linux.ibm.com>
References: <CAHk-=wg7+-Q-jvrwQmyZtQ3pirAUcAQmvUpiLu=0nJv8NObntg@mail.gmail.com>
 <YL1HLdmh55uGAIs/@zn.tnic>
 <YL1UucKH0GfXddZo@sashalap>
 <eaf8e14-12d6-6e3a-f5e5-8b504647eb48@namei.org>
 <MWHPR21MB159330952629D36EEDE706B3D7379@MWHPR21MB1593.namprd21.prod.outlook.com>
 <YL+368+oKRORwUzx@zn.tnic>
 <CAHk-=wh1nz4=72vk3+q5TuPwBF2HMY4SnBOZr6WSLp=s4KExSA@mail.gmail.com>
 <YL/MoOZFRwo261WG@zn.tnic>
 <CAHk-=wh7BWwNR5+z7bn1xxa1Rc1Dzo-SDnahJ2cLePmRcG8uWw@mail.gmail.com>
 <YL/Tc1bGkgXKRKfT@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL/Tc1bGkgXKRKfT@zn.tnic>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2iGNoY-E1qwLOJRJETXvAv0Jp7WrMuik
X-Proofpoint-ORIG-GUID: 2iGNoY-E1qwLOJRJETXvAv0Jp7WrMuik
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-09_04:2021-06-04,2021-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=950 phishscore=0
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090037
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 10:30:46PM +0200, Borislav Petkov wrote:
> It does so unconditionally too, on Intel and AMD machines, to work
> around BIOS bugs, as confirmed by Microsoft folks (see Link for full
> details).
> 
> Reflow the paragraph, while at it.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

Thanks for taking care of this!

> Link: https://lkml.kernel.org/r/MWHPR21MB159330952629D36EEDE706B3D7379@MWHPR21MB1593.namprd21.prod.outlook.com
> ---
>  arch/x86/kernel/setup.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 7638ac6c3d80..85acd22f8022 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1060,17 +1060,18 @@ void __init setup_arch(char **cmdline_p)
>  #endif
>  
>  	/*
> -	 * Find free memory for the real mode trampoline and place it
> -	 * there.
> -	 * If there is not enough free memory under 1M, on EFI-enabled
> -	 * systems there will be additional attempt to reclaim the memory
> -	 * for the real mode trampoline at efi_free_boot_services().
> +	 * Find free memory for the real mode trampoline and place it there. If
> +	 * there is not enough free memory under 1M, on EFI-enabled systems
> +	 * there will be additional attempt to reclaim the memory for the real
> +	 * mode trampoline at efi_free_boot_services().
>  	 *
> -	 * Unconditionally reserve the entire first 1M of RAM because
> -	 * BIOSes are know to corrupt low memory and several
> -	 * hundred kilobytes are not worth complex detection what memory gets
> -	 * clobbered. Moreover, on machines with SandyBridge graphics or in
> -	 * setups that use crashkernel the entire 1M is reserved anyway.
> +	 * Unconditionally reserve the entire first 1M of RAM because BIOSes
> +	 * are known to corrupt low memory and several hundred kilobytes are not
> +	 * worth complex detection what memory gets clobbered. Windows does the
> +	 * same thing for very similar reasons.
> +	 *
> +	 * Moreover, on machines with SandyBridge graphics or in setups that use
> +	 * crashkernel the entire 1M is reserved anyway.
>  	 */
>  	reserve_real_mode();
>  
> -- 
> 2.29.2
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
Sincerely yours,
Mike.
