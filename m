Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19F8319CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhBLK5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:57:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230323AbhBLK5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:57:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEBF864E2D;
        Fri, 12 Feb 2021 10:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613127387;
        bh=LKxrbsHmARhR1BNS8+KpMMyPCTW+fzv/xMzqI7/b6gU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OQ2vX+2r0rHA0YhF/7aY87gTuOZyHUtIRn6NOkZxzpDzlBW5Dq3/Zyl30hI1sTkwy
         ULpeuLcosyi47SElwpDTJZ0EB/Z05hOtlZEcv9GA2dxJyktrVude6n6DFabdRIhIWK
         bdix2atvQ2e5UqS5ZtJS59740lfGr4ctl+1aKi8n6R47XmXad8d5jDtmbfPUeRpkXc
         Etr+4bIRDlFTIJnMSgZNQOQyraSCNV6dTbweQLmxGkMkhdV/tOVwBhJyR0GpTDp45O
         pGFBBQ95SOtIIrnJQmxaYVoQVXXt18TDPYqHeYF8sWN5fybFjLNQdKifoZmHqLPnn0
         oF3JroTrA+JjQ==
Date:   Fri, 12 Feb 2021 12:56:18 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org
Subject: Re: [PATCH] x86: vdso: fix printf() format warnings in vdso2c.h
Message-ID: <YCZe0hCn3zpdziir@kernel.org>
References: <20210209012305.31062-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209012305.31062-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 05:23:05PM -0800, Randy Dunlap wrote:
> Use %zu instead of %lu for size_t to prevent w printf()
> format warnings in vdso2c.h
> 
>   HOSTCC  arch/x86/entry/vdso/vdso2c
> In file included from ../arch/x86/entry/vdso/vdso2c.c:162:
> ../arch/x86/entry/vdso/vdso2c.h: In function 'extract64':
> ../arch/x86/entry/vdso/vdso2c.h:38:52: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
>    38 |  fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
>       |                                                  ~~^              ~~~
> In file included from ../arch/x86/entry/vdso/vdso2c.c:166:
> ../arch/x86/entry/vdso/vdso2c.h: In function 'extract32':
> ../arch/x86/entry/vdso/vdso2c.h:38:52: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
>    38 |  fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
>       |                                                  ~~^              ~~~
> 
> Fixes: 8382c668ce4f ("x86/vdso: Add support for exception fixup in vDSO functions")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: x86@kernel.org

Just a *question*: should SOB be the last? Seeing this 2nd time today, and
just not used to it. That's why asking.

Anyway, thank you.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

> ---
>  arch/x86/entry/vdso/vdso2c.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lnx-511-rc7.orig/arch/x86/entry/vdso/vdso2c.h
> +++ lnx-511-rc7/arch/x86/entry/vdso/vdso2c.h
> @@ -35,7 +35,7 @@ static void BITSFUNC(extract)(const unsi
>  	if (offset + len > data_len)
>  		fail("section to extract overruns input data");
>  
> -	fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
> +	fprintf(outfile, "static const unsigned char %s[%zu] = {", name, len);
>  	BITSFUNC(copy)(outfile, data + offset, len);
>  	fprintf(outfile, "\n};\n\n");
>  }
> 

/Jarkko
