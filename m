Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69939368636
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbhDVRuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbhDVRuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:50:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57044C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 10:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=PK7lVAn6aVHwhA8HICPUFp9kUNbAdKMeylNu2Kor/dY=; b=W9lorgrF49Sob/hdpwxu1JKa0P
        R1yHP+MrtYGT5Dy49pisdJEphguWM7+3zvY3P1h1KmxPHvLObzgcB+61WOo5JKLmuGFs6RqPV1TeX
        zl8ZbK7G4849z7nlDWkw02yzfYP+sBYKNDROuFddADa4qDm5qgX79lt+1Aeav3HtB5rL1988dIeUY
        Sghs4RPw8Ks5t/vV3Ev6rHlczzu/+MNqdQ7yPYGZtxjDFN5XHO8iN4+VbJ3FiJ7FJwVHnhzfPcyhO
        4Gu+1pX9RqPXeHr9wAVlH83+oVOoWxpG+i4EHfPtN0sD2VFXy5xkRIxV3egIgrLn6LI3VsdI73v/d
        Fm9QQddg==;
Received: from [2601:1c0:6280:3f0::df68]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZdRy-00HCiq-9C; Thu, 22 Apr 2021 17:49:15 +0000
Subject: Re: [v2 1/1] x86/cpufeatures: Implement Predictive Store Forwarding
 control.
To:     Ramakrishna Saripalli <rsaripal@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>
Cc:     bsd@redhat.com
References: <20210422171013.50207-1-rsaripal@amd.com>
 <20210422171013.50207-2-rsaripal@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ee949efc-018c-8b70-3224-da4f24b217b6@infradead.org>
Date:   Thu, 22 Apr 2021 10:49:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210422171013.50207-2-rsaripal@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/21 10:10 AM, Ramakrishna Saripalli wrote:
> From: Ramakrishna Saripalli <rk.saripalli@amd.com>
> 
> ====================
> Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  5 +++++
>  arch/x86/include/asm/cpufeatures.h            |  1 +
>  arch/x86/include/asm/msr-index.h              |  2 ++
>  arch/x86/kernel/cpu/amd.c                     | 19 +++++++++++++++++++
>  4 files changed, 27 insertions(+)

as from v1:

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 04545725f187..58f6bd02385b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3940,6 +3940,11 @@
>  			Format: {"off"}
>  			Disable Hardware Transactional Memory
>  
> +	predict_store_fwd	[X86] This option controls PSF mitigation

	predict_store_fwd=	...

> +			off - Turns on PSF mitigation.
> +			on  - Turns off PSF mitigation.
> +			default : on.

			default: on.

> +
>  	preempt=	[KNL]
>  			Select preemption mode if you have CONFIG_PREEMPT_DYNAMIC
>  			none - Limited to cond_resched() calls
thanks.
-- 
~Randy

