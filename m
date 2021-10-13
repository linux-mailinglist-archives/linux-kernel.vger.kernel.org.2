Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABD342B8F1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 09:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbhJMH0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 03:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbhJMHZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 03:25:57 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A745EC061714
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 00:23:54 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 187so1644464pfc.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 00:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a+STDQupphuK/7Y3WCz3HFR7aiY2eZV5V/OCb+gsLGo=;
        b=I6w+qFwPBk9quxtMfcJjbCISh5NslqMD7RdikCpk68hT3HijzJ6U/NXdwAKbOum8vu
         vS3MxhZN9eoIgGDE3MBgTwkD9wwygGF3hFe/u5FZ9aYt5bDUp5/SKHaBIb9JSSrj/Eo+
         hIxM+4qao33lcbsDFkeMBUVK1pi5/3teC4vZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a+STDQupphuK/7Y3WCz3HFR7aiY2eZV5V/OCb+gsLGo=;
        b=dUkefUuc+vTEws18Y+tJadiqP4A5ov5JUioDmvatD5fqvOPoqh9tJG96OJmKRoGqLR
         V7TFz6YlSATnG3Zbv9c12mDE5V/LH5s//AlPQikPISd2luiXJClcwLkLlnMMBlKr6I/s
         OlJvyhPePr78lQhFMi4G8lASw9hfj0ag8VxNVJ3NWHEDpUimVibPX+CZFKb2pXIOnHWm
         ew7i0yofAoR5J84c5xKPYj7oiT+lddnBORCIneforcrG9w3HkfDiDWT5fciSZZFYu4pk
         liP+R1v15lAfa0akMmfBbgPgAkNhxSym0bBFnoAFdoM46We/UaQwEmV6vi2W9tpGMgZK
         uQDA==
X-Gm-Message-State: AOAM532LBcaMS+wUxphYLUSHE9SCa4PdBs2INCXcO9XFZR7zNd4GCw/G
        u024pMG+ZqMDaOoF7sNmf4vh+Q==
X-Google-Smtp-Source: ABdhPJwUdjDXsZD6PJOkAL4X8A7lF2TLTDyO8KSYEbRyWhK7gdzTiI5rlXDwv4Yr1q/D3xOPKfxUmw==
X-Received: by 2002:a63:6c89:: with SMTP id h131mr16767067pgc.47.1634109834205;
        Wed, 13 Oct 2021 00:23:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t125sm3280014pfc.119.2021.10.13.00.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 00:23:53 -0700 (PDT)
Date:   Wed, 13 Oct 2021 00:23:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 09/10] lkdtm: Fix lkdtm_EXEC_RODATA()
Message-ID: <202110130018.7B2129375@keescook>
References: <cover.1633964380.git.christophe.leroy@csgroup.eu>
 <7da92e59e148bd23564d63bdd8bcfaba0ba6d1f1.1633964380.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7da92e59e148bd23564d63bdd8bcfaba0ba6d1f1.1633964380.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 05:25:36PM +0200, Christophe Leroy wrote:
> Behind a location, lkdtm_EXEC_RODATA() executes a real function,
> not a copy of do_nothing().
>
> So do it directly instead of using execute_location().
>
> And fix displayed addresses by dereferencing the function descriptors.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/misc/lkdtm/perms.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> index 442d60ed25ef..da16564e1ecd 100644
> --- a/drivers/misc/lkdtm/perms.c
> +++ b/drivers/misc/lkdtm/perms.c
> @@ -153,7 +153,14 @@ void lkdtm_EXEC_VMALLOC(void)
>
>  void lkdtm_EXEC_RODATA(void)
>  {
> -	execute_location(lkdtm_rodata_do_nothing, CODE_AS_IS);
> +	pr_info("attempting ok execution at %px\n",
> +		dereference_symbol_descriptor(do_nothing));
> +	do_nothing();
> +
> +	pr_info("attempting bad execution at %px\n",
> +		dereference_symbol_descriptor(lkdtm_rodata_do_nothing));
> +	lkdtm_rodata_do_nothing();
> +	pr_err("FAIL: func returned\n");
>  }

(In re-reading this more carefully, I see now why kallsyms.h is used
earlier: _function_ vs _symbol_ descriptor.)

In the next patch:

static noinline void execute_location(void *dst, bool write)
{
...
       func = setup_function_descriptor(&fdesc, dst);
       if (IS_ERR(func))
               return;

       pr_info("attempting bad execution at %px\n", dst);
       func();
       pr_err("FAIL: func returned\n");
}

What are the conditions for which dereference_symbol_descriptor works
but dereference _function_descriptor doesn't?

--
Kees Cook
