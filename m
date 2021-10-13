Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBBE42C70C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbhJMRAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:00:02 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37814 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230415AbhJMQ7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:59:51 -0400
Received: from zn.tnic (p200300ec2f12080010afaa72f664282d.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:800:10af:aa72:f664:282d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8FB151EC04DA;
        Wed, 13 Oct 2021 18:57:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634144266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BqJ9v+qKrQZJN9M6joACzgDRICdWGPAemCXzOBxSZp0=;
        b=T/E3dOPlSJ7eRhLGyVTRxLirMHKqnVsZgWuCdNAy84scW7kIDam/TaRyDSyaicc+/ckC/L
        zez1OXupgZAmtp5JJ+WvlAZZ5MiFMprfohIhk5AHV283c+MDwOM1jkiOjWJTi6aHGbAeUq
        95XB/POm9Il9g761lgRzKmQlQ3hfeKI=
Date:   Wed, 13 Oct 2021 18:57:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Marcos Del Sol Vives <marcos@orca.pet>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: add support DM&P devices
Message-ID: <YWcQDYY9CuWKsayl@zn.tnic>
References: <20211008162246.1638801-1-marcos@orca.pet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211008162246.1638801-1-marcos@orca.pet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 06:22:46PM +0200, Marcos Del Sol Vives wrote:
> +config CPU_SUP_DMP_32
> +	default y
> +	bool "Support DM&P processors" if PROCESSOR_SELECT
> +	depends on !64BIT

You mean

	depends on X86_32

?

Wikipedia says those things are 32-bit.

> +	help
> +	  This enables detection, tunings and quirks for DM&P processors
> +
> +	  You need this enabled if you want your kernel to run on a
> +	  DM&P CPU. Disabling this option on other types of CPUs

So I'm not sure about the nomenclature: those CPUs are called Vortex86
and DM&P is simply the next owner of the IP:

"Vortex86 previously belonged to SiS, which got the basic design from
Rise Technology.[1] SiS sold it to DM&P Electronics[2] in Taiwan."

So I'm thinking we should call everything Vortex, the file vortex.c, the
vendor define X86_VENDOR_VORTEX and so on.

> +	  makes the kernel a tiny bit smaller. Disabling it on a DM&P
> +	  CPU might render the kernel unbootable.

Why unbootable? It looks like those are perfect clones: "No special init
required for DM&P processors." it says in the patch. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
