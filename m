Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D483AB27D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhFQL1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhFQL1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:27:40 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C01C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:25:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c9so6359405wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RqZOZEx9ohzvxxSvooROcyGAfz7QcNShdxHDZLPPObs=;
        b=Fmz34h62pHHxwCk3ZJB95Psj4oXy9lcfVRSPJtmj2HCccLO3Wt6wEBzCQMF52Oz9+6
         6yuzxHWar6la+ZGbvMI3PAMfY7Fq34yDrEdppBnxyoLmtYM0zEP7PcXMMEdi7W7F2qgF
         SyDSEUKWbcZAIn/weFvutOjMEBPPf1Mj2X45VAPG0xGEU7Zjg8X+h1npdMHYwiJB80Da
         JAUU+PCDvVbsvDFOKMX2Oa697o9r5+Y57aE6E+A+gBt9W8ePUwpDlIeB0hbr52vZkX6S
         J9xKl73zP6IRpqu04A3gSFJiW/9Jw/7Uz81cQnykokhwlYtN5u8Uz/eOYiabJ4+G5EUW
         iR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RqZOZEx9ohzvxxSvooROcyGAfz7QcNShdxHDZLPPObs=;
        b=s/7F1fbs0Py09viqwvmlj/Kv9R4YaoPTHsl+BcxK/+1CyeJjrclE29A8YK+lKPVYjp
         k8ekEU9K1kI/PiavyfvU9vcQ32o9fY9wGGTvfDf+3fzFkxZ2tnQBRmcGqyIJzGbPGM9R
         TJRos0XAn+0JRPDjsPu3vtzggJaPGhcAHQInadopXIxjVIcATesVwFTJ7IDPag+Dj08z
         BZT+LYKxH6zof2ioOQtIZFSFcrr9Ax0HRiNIA4ZDvR/C6cYzISzNzB9Nc5Y0VBmpmKDU
         Y1K69W5ooDkybwS330CqsrJW25PglPnD5DWx6ujVibVhBFLBop8Jav27RuwM1LdZTBIP
         5ZOg==
X-Gm-Message-State: AOAM531eV8DOwqXsnHm+mLb8751R2LvpeRgripKoLKW07VXaXTlYQ08W
        4By6WpiK9V6a/p5wtLMR1mJIrw==
X-Google-Smtp-Source: ABdhPJyk3bgNi5ESzoE0WY2r8FczOf8sdFPg2oBONcIxRTfNyPYwxlF3aZ5HyaXK+0ryeiP5fpSmQg==
X-Received: by 2002:adf:fa48:: with SMTP id y8mr5103547wrr.387.1623929129921;
        Thu, 17 Jun 2021 04:25:29 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id o11sm4348654wmq.1.2021.06.17.04.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 04:25:29 -0700 (PDT)
Date:   Thu, 17 Jun 2021 12:25:27 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kdb: Get rid of custom debug heap allocator
Message-ID: <20210617112527.nganuruifprwhv3h@maple.lan>
References: <20210323065519.821062-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323065519.821062-1-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 12:25:19PM +0530, Sumit Garg wrote:
> Currently the only user for debug heap is kdbnearsym() which can be
> modified to rather use statically allocated buffer for symbol name as
> per it's current usage. So do that and hence remove custom debug heap
> allocator.
> 
> Note that this change puts a restriction on kdbnearsym() callers to
> carefully use shared namebuf such that a caller should consume the symbol
> returned immediately prior to another call to fetch a different symbol.
> 
> This change has been tested using kgdbtest on arm64 which doesn't show
> any regressions.
> 
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

I'm afraid the passage of time (mostly due to my dropping the ball)
means this no longer applies cleanly to latest kernel and `git am
-3way` tells me that "sha1 information is lacking or useless".
Please can you rebase this on v5.13-rc4 and repost?

Also...


> diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
> index b857a84de3b5..ec91d7e02334 100644
> diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
> index b59aad1f0b55..e131d74abb8d 100644
> --- a/kernel/debug/kdb/kdb_support.c
> +++ b/kernel/debug/kdb/kdb_support.c
> @@ -57,35 +57,26 @@ int kdbgetsymval(const char *symname, kdb_symtab_t *symtab)
>  }
>  EXPORT_SYMBOL(kdbgetsymval);
>  
> -static char *kdb_name_table[100];	/* arbitrary size */
> -
>  /*
> - * kdbnearsym -	Return the name of the symbol with the nearest address
> - *	less than 'addr'.
> + * kdbnearsym() - Return the name of the symbol with the nearest address
> + *                less than @addr.
> + * @addr: Address to check for near symbol
> + * @symtab: Structure to receive results
>   *
> - * Parameters:
> - *	addr	Address to check for symbol near
> - *	symtab  Structure to receive results
> - * Returns:
> - *	0	No sections contain this address, symtab zero filled
> - *	1	Address mapped to module/symbol/section, data in symtab
> - * Remarks:
> - *	2.6 kallsyms has a "feature" where it unpacks the name into a
> - *	string.  If that string is reused before the caller expects it
> - *	then the caller sees its string change without warning.  To
> - *	avoid cluttering up the main kdb code with lots of kdb_strdup,
> - *	tests and kfree calls, kdbnearsym maintains an LRU list of the
> - *	last few unique strings.  The list is sized large enough to
> - *	hold active strings, no kdb caller of kdbnearsym makes more
> - *	than ~20 later calls before using a saved value.
> + * Note here that only single statically allocated namebuf is used for every
> + * symbol, so the caller should consume it immediately prior to another call
> + * to fetch a different symbol.

This still looks like it will confused experienced kernel devs who
aren't aware of kdb's calling context. Nor does it help future kdb
developers understand some of the subtlty of interactions here.

Can you enlarge this to the following (editing anything below that you
don't want git to blame you for ;-) ):

~~~
WARNING: This function may return a pointer to a single statically
allocated buffer (namebuf). kdb's unusual calling context (single
threaded, all other CPUs halted) provides us sufficient locking for
this to be safe. The only constraint imposed by the static buffer is
that the caller must consume any previous reply prior to another call
to lookup a new symbol.

Note that, strictly speaking, some architectures may re-enter the kdb
trap if the system turns out to be very badly damaged and this breaks
the single-threaded assumption above. In these circumstances successful
continuation and exit from the inner trap is unlikely to work and any
user attempting this receives a prominent warning before being allowed
to progress. In these circumstances we remain memory safe because
namebuf[KSYM_NAME_LEN-1] will never change from '\0' although we do
tolerate the possibility of garbled symbol display from the outer kdb
trap.
~~~

Thanks


Daniel.
