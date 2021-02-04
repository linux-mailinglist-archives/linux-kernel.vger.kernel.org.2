Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AAD30EB28
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 04:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbhBDDsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 22:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhBDDsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 22:48:20 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC152C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 19:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=m4N6QG1HGXV8OFjRl9CFwQATI7lj+7/koIRrBBa17pk=; b=FaxOUFTpYXYgmSum35WdzHqe30
        GX1RrouAL1ktVZBfcSIsrw12No793WITO/2pk1KQRLK5EiWadS56YrSSjZ5gzqlg6BqSTQElK/2ft
        AMrwKuLwneOroLtwVVPKUNMa7v++ok6h+iSRdkgYEtz7i7GnvCIRZ5DJEpNKFfd+PV71HBS4+HFog
        AEqtrWbDKeMmWceeo8UZYGn1UcMnVH0wyaznPhbhiS1tq55NUUyDjJNRzs8D355zjaZ3plsk7dpf3
        rf7mLPSzLN3YEgKWhyVhKjN7p+G490N0j03KP02z88IDzZdOfeAx1Go8TrFcSGNQH9dNl0gSA5Gfk
        8s8qAksw==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7VcF-0008IR-0Z; Thu, 04 Feb 2021 03:47:35 +0000
Subject: Re: [PATCH] x86: Add a prompt for HPET_EMULATE_RTC
To:     Anand K Mistry <amistry@google.com>, x86@kernel.org
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20210204132043.1.I2392cf11fb353d10459958100b69d93346fa167c@changeid>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ec6caa23-28d6-9695-2b0f-b3ba9ef28b60@infradead.org>
Date:   Wed, 3 Feb 2021 19:47:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210204132043.1.I2392cf11fb353d10459958100b69d93346fa167c@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 6:21 PM, Anand K Mistry wrote:
> This does two things:
> 1. Makes the option visible in menuconfig, allowing the user to easily
>    disable this option
> 2. Allows olddefconfig to respoct the option if it is set in the old
>    .config file
> 
> It's not clear exactly why the second consequence is true, but it
> appears to be because when the conf tool reads the config file, it only
> respects the existing setting if the option is "visible" (see
> scripts/kconfig/symbol.c:381).
> 
> Signed-off-by: Anand K Mistry <amistry@google.com>
> ---

Hi,

When you run "make olddefconfig", should this "depends on"
line evaluate to true or false?
I.e., what are the settings of these symbols in the old .config file?


  	depends on HPET_TIMER && (RTC=y || RTC=m || RTC_DRV_CMOS=m || RTC_DRV_CMOS=y)

If not, is there some out-of-tree driver involved?
I'm having a little trouble seeing why this is needed.


>  arch/x86/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 21f851179ff0..28f814493c7b 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -890,6 +890,7 @@ config HPET_TIMER
>  
>  config HPET_EMULATE_RTC
>  	def_bool y
> +	prompt "HPET RTC emulation"
>  	depends on HPET_TIMER && (RTC=y || RTC=m || RTC_DRV_CMOS=m || RTC_DRV_CMOS=y)
>  
>  config APB_TIMER
> 


thanks.
-- 
~Randy
