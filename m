Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085DB30FC48
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 20:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbhBDTLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 14:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239629AbhBDTIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 14:08:31 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B38C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 11:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=DOcwx5wwQyJiNoBULxHCbyerHK7NZ+L3JYkpzHdZiqE=; b=afHhegBiKR1LXTDisCi/JA+ouD
        Ib/A6wPGrG3IfQRpoUSpR9ASqLGh4yKCv5siRE1mSAbH0jpedC2S3Xx3Zj2RECUzmoftTDnPcaDAx
        IcgXuk29qERn0TczK09nA+ZsmX/q859S6G92/NhzWrfh6FxlOgCR4G9MQJYgOva8EkL6JYtp675XG
        t385g9sFKFhVEAUc5876ov/ufLGIL/JJBEdgqQhptwPJ6BRNquNdvvndQIbmRxT8sL4jUzvXIPTVl
        KcO8lLPn1V5aE1Yck/vaCH2t2pSjQ7DU+YOYdALQUXCzXvuahM+R69bNcx0d6tAQCrxo/pKxQFAEe
        DP+KrlYw==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7jyk-0006eT-QG; Thu, 04 Feb 2021 19:07:47 +0000
Subject: Re: [PATCH] x86: Remove HPET_EMULATE_RTC depends on RTC
To:     Anand K Mistry <amistry@google.com>, x86@kernel.org
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20210204183205.1.If5c6ded53a00ecad6a02a1e974316291cc0239d1@changeid>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <aeeeeb18-6a42-8ae5-1364-a30d80e2008d@infradead.org>
Date:   Thu, 4 Feb 2021 11:07:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210204183205.1.If5c6ded53a00ecad6a02a1e974316291cc0239d1@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 11:32 PM, Anand K Mistry wrote:
> The RTC config option was removed in commit f52ef24be21a ("rtc/alpha:
> remove legacy rtc driver")
> 
> Signed-off-by: Anand K Mistry <amistry@google.com>
> ---

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> 
>  arch/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 21f851179ff0..37775478d86f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -890,7 +890,7 @@ config HPET_TIMER
>  
>  config HPET_EMULATE_RTC
>  	def_bool y
> -	depends on HPET_TIMER && (RTC=y || RTC=m || RTC_DRV_CMOS=m || RTC_DRV_CMOS=y)
> +	depends on HPET_TIMER && (RTC_DRV_CMOS=m || RTC_DRV_CMOS=y)
>  
>  config APB_TIMER
>  	def_bool y if X86_INTEL_MID
> 


-- 
~Randy
