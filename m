Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8FD37D491
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 23:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351747AbhELSZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 14:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242083AbhELQbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 12:31:52 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D314C0612A4
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=p0l50jpw4w004bI64W6HxRwIjlLQGJ9WgZdJZn71930=; b=rCUy/l+msTWFLMdEd0Z1Ypaet
        AZoqkL+HE+FNyMj3b1gxx2hPFF9wUEqqAsYmAhB6G8s8v9RFbK39kJ3p0RNZgN0VDczgT0NxmmDBv
        r/HFK/QCqHLTUlJIxQ4xgEIlhd5L7IG/lEJYmMTulWs8woSLpvJ5mNEDaLtrupNzsiGYppMYAITQ8
        +fZ+i2nhAsJULtmlVRTsuyamfLNo4HN8lfjztpW3sym77NpLmnwjtyVxu8GrOnkKZsFlKnETxjUff
        HOh0DZqt7rP+4emCv50BzW3GVi3jLgwnLwm5v98YHAWHtLuPamDioIEXWUUTVa/8x4Ll34OwhfJuv
        6Z3DIxhBw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43892)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lgrNr-0004Y7-WA; Wed, 12 May 2021 17:06:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lgrNr-00028n-N6; Wed, 12 May 2021 17:06:51 +0100
Date:   Wed, 12 May 2021 17:06:51 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] module: check for exit sections in layout_sections()
 instead of module_init_section()
Message-ID: <20210512160651.GP1336@shell.armlinux.org.uk>
References: <20210512144653.3726-1-jeyu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512144653.3726-1-jeyu@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 12, 2021 at 04:46:53PM +0200, Jessica Yu wrote:
> diff --git a/kernel/module.c b/kernel/module.c
> index 173a09175511..a5c9842371b1 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2430,6 +2430,9 @@ static void layout_sections(struct module *mod, struct load_info *info)
>  			if ((s->sh_flags & masks[m][0]) != masks[m][0]
>  			    || (s->sh_flags & masks[m][1])
>  			    || s->sh_entsize != ~0UL
> +#ifndef CONFIG_MODULE_UNLOAD
> +			    || module_exit_section(sname)
> +#endif
>  			    || module_init_section(sname))

How about a helper to make this a bit easier in both these places to
make the code more undertsandable? I think the great value comes from
the resulting change in the second hunk.

static bool module_evictable_section(const char *sname)
{
#ifndef CONFIG_MODULE_UNLOAD
	if (module_exit_section(sname))
		return true;
#endif
	return module_init_section(sname);
}

and then just use that above?

>  				continue;
>  			s->sh_entsize = get_offset(mod, &mod->core_layout.size, s, i);
> @@ -2463,7 +2466,11 @@ static void layout_sections(struct module *mod, struct load_info *info)
>  			if ((s->sh_flags & masks[m][0]) != masks[m][0]
>  			    || (s->sh_flags & masks[m][1])
>  			    || s->sh_entsize != ~0UL
> +#ifndef CONFIG_MODULE_UNLOAD
> +			    || (!module_init_section(sname) && !module_exit_section(sname)))
> +#else
>  			    || !module_init_section(sname))
> +#endif

I find this a tad confusing, and this is the reason for my suggestion
above. With that, this becomes:

			    || !module_evictable_section(sname))

which can be clearly seen is the opposite condition from the above
without doing mental logic gymnastics.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
