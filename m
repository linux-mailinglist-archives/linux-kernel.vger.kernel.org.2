Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C003292DA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 21:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243968AbhCAUx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 15:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237160AbhCARKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:10:18 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFD8C061788;
        Mon,  1 Mar 2021 09:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=tdr23ctYIjaSovyzCrlydLo8hJiZD6TcVuVzx8JMj0k=; b=MlIKc0va3pxSmyS1RSEDvO35fD
        bQ8phkHe4gntkak3qfJfjxhYLX3d7PnQzdoCJG4iQHt549TayZ9h/g13m/zbR0/P/3rtWTK+BajOb
        eWFx+NDDAjNdXxX4zKwkMk4FKLttPqzCNxcmDRTJwqpLeI6a186Aey4B10FyGmSHZGerP68k5EPQy
        C1G8dAulciA1MMsrQ01pt9rrDsNZs/3SqmHuPiP2+dULEy6ag7i2BJE1mI4GWb3MJ+2N3Ot2IU4we
        xDIhs133VVhaYCoOXRrul43eeFiHsh08SXZw9QRYqMiruV5qo0DgCxnD+hx8gfJtfUmQLefmuWzUJ
        Y3Rmj/zQ==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lGm2y-0006Ie-At; Mon, 01 Mar 2021 17:09:28 +0000
Subject: Re: [PATCH v4 1/2] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
To:     Perry Yuan <Perry.Yuan@dell.com>, pobrn@protonmail.com,
        pierre-louis.bossart@linux.intel.com, oder_chiou@realtek.com,
        perex@perex.cz, tiwai@suse.com, hdegoede@redhat.com,
        mgross@linux.intel.com, Mario.Limonciello@dell.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20210301093753.16300-1-Perry_Yuan@Dell.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6123db00-8a4e-ff1e-d4be-c3fa2558d379@infradead.org>
Date:   Mon, 1 Mar 2021 09:09:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210301093753.16300-1-Perry_Yuan@Dell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/21 1:37 AM, Perry Yuan wrote:
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 91e6176cdfbd..e20f79389a39 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -491,6 +491,23 @@ config DELL_WMI_LED
>  	  This adds support for the Latitude 2100 and similar
>  	  notebooks that have an external LED.
>  
> +config DELL_PRIVACY
> +	tristate "Dell Hardware Privacy Support"
> +	depends on ACPI
> +	depends on ACPI_WMI
> +	depends on INPUT
> +	depends on DELL_LAPTOP
> +	depends on LEDS_TRIGGER_AUDIO
> +	select DELL_WMI
> +	  help

The "help" keyword should be indented only with one tab. Drop the 
2 additional spaces for it.

> +	  This driver provides support for the "Dell Hardware Privacy" feature
> +	  of Dell laptops.
> +	  Support for a micmute and camera mute privacy will be provided as
> +	  hardware button Ctrl+F4 and Ctrl+F9 hotkey.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called dell_privacy.


-- 
~Randy

