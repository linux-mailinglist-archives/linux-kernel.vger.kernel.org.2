Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345A732BFBB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835990AbhCCSFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:05:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244887AbhCCPa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:30:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8339964EC3;
        Wed,  3 Mar 2021 15:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614785333;
        bh=GOzfljebF/ybnNoCv2TkZcVkuznD7Uc7iVtZF7TArSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WVmum3l8UST1fYKA3p4IckPHf5VVaX3IPGRPihimUxpWSMD4MWsMpykGXlmojxBwo
         A6D7iw6tz+PT0j+ulJrrEdX4qj6ysoynhfSJnCJjbhWAuXypSeKIF+7XjpzosRYs4Y
         o49B25cEhb8IY2rnX37WVPdwiSQxd9mSFJzUxRpRmsJ562OQ/LD0a3bFRIZ8B7Jeoe
         XXAqbFwTxUmqfV/U5O/zozF/S1b3xB6O1rqb2TLe7TPoWLIKVFoVhoky7EQbEfj9mY
         lUlC08OtpimVGX4IRM6xjlLfs8AmapbkwRGJOPYkjCvnoem9MGn5wurzm9Q7jSjBA2
         DDPH1Kfxlkb6g==
Date:   Wed, 3 Mar 2021 17:28:33 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     bp@alien8.de, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH] x86/vdso: Use proper modifier for len's printf in extract
Message-ID: <YD+rIZC3Dc1eKMEc@kernel.org>
References: <20210303064357.17056-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303064357.17056-1-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 07:43:57AM +0100, Jiri Slaby wrote:
> Commit 8382c668ce4f ("x86/vdso: Add support for exception fixup in vDSO
> functions") added a printf of len which is size_t. Compilers now
> complain on 32b:
> In file included from arch/x86/entry/vdso/vdso2c.c:162:
> arch/x86/entry/vdso/vdso2c.h: In function 'extract64':
> arch/x86/entry/vdso/vdso2c.h:38:52: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'}
> 
> So use proper modifier (%zu) for size_t.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Fixes: 8382c668ce4f ("x86/vdso: Add support for exception fixup in vDSO functions")
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Jethro Beekman <jethro@fortanix.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org


Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

> ---
>  arch/x86/entry/vdso/vdso2c.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
> index 1c7cfac7e64a..5264daa8859f 100644
> --- a/arch/x86/entry/vdso/vdso2c.h
> +++ b/arch/x86/entry/vdso/vdso2c.h
> @@ -35,7 +35,7 @@ static void BITSFUNC(extract)(const unsigned char *data, size_t data_len,
>  	if (offset + len > data_len)
>  		fail("section to extract overruns input data");
>  
> -	fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
> +	fprintf(outfile, "static const unsigned char %s[%zu] = {", name, len);
>  	BITSFUNC(copy)(outfile, data + offset, len);
>  	fprintf(outfile, "\n};\n\n");
>  }
> -- 
> 2.30.1
> 
> 

/Jarkko
