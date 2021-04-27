Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C4D36BFE9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbhD0HPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhD0HPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:15:03 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84F5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 00:14:19 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id n22so3937666qtk.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 00:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Ul/amy1bHrVXLikAjGzXREZ1oIVt1sWptxkpTRFpPRo=;
        b=e5OwNLtkXJvQ8DVoWOeOUvdDKSIuG/emEMWqxW/e3bj7iw21wa1Rg9sjwt792dt3p+
         QC7dTWOYw7FTOrSunKYbbKst8pfVD4xrT9SQzzt8jetlSNM7slE/xYu5Q3yq45amnHc6
         qvPOCf747toK0avb1KmFWRQuMC75f3jlY1d7tBGDBHmrj/Oq4ZpsUdV5d0XWcaIqcrdO
         isekdU3ZeqyyCKqbu5JBiKc6Ql+Gk76sH0igTwbLBHHfnRpNgVa2mzPeb2GJZjdM9kel
         YkCgN9pfb/B9wJKUvDJbPnPDYVmlpRI+QYXjS8CAHDjZoUPxUXFbzsGvW2dX3GTBQ0jp
         bxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ul/amy1bHrVXLikAjGzXREZ1oIVt1sWptxkpTRFpPRo=;
        b=tv5TMa8zspXrc6gRXM3ABJSiTitU8eGuqb5FmEgFLjQaBokxO7AZB2x6Y2JMI+ST4u
         sHhnfG7f3P+VFWqAGPB+PSYqDiw8bftRCEAgV+LJJnbaHP6CfkX6Y0S849umnRrOkFIc
         8TZsGHwUkEmn8iyh9dDwMTgHpZ8v/S4Chb344lFSXbBHEhrMLegy6UxncLl8PppAjFX4
         MrD4VB5TMmu9/oZAFMkXRbvtLQXE7Q9oYjGnkALneEE2PXP40IIXDLlZSOVYMXqygjh9
         3azU+lPBwP9RHdr5Q9ra8mYE/P8apaglIwc8LX4K+tAevEXlnCoENyUsQAVA5NgB15iY
         3oFQ==
X-Gm-Message-State: AOAM532iGM8p6sodrCC4P1dHDJ8PnNQK3S64KiXUk9ea0BWrp7Kp7W0P
        pBg2X6O7Lgn3t5G1hNBf5N4=
X-Google-Smtp-Source: ABdhPJxhe2AB9fJG9VYF8NhfyRAfPtI75kG/hNE1STEZiWu3LCbQp1Jcjdn5x/sSCntXEr30A5L8iQ==
X-Received: by 2002:ac8:5517:: with SMTP id j23mr20469185qtq.148.1619507659111;
        Tue, 27 Apr 2021 00:14:19 -0700 (PDT)
Received: from theldus ([2804:d45:9905:9600:f66d:4ff:fe73:55f5])
        by smtp.gmail.com with ESMTPSA id y9sm2193786qkm.19.2021.04.27.00.14.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Apr 2021 00:14:18 -0700 (PDT)
Date:   Tue, 27 Apr 2021 04:14:15 -0300
From:   Davidson Francis <davidsondfgl@gmail.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        davidsondfgl@gmail.com
Subject: Re: [Cocci] [PATCH v2] scripts: coccicheck: Fix chain mode in
 coccicheck
Message-ID: <20210427071415.GA12067@theldus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210306200541.3133-1-davidsondfgl@gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06, 2021 at 05:05:41PM -0300, Davidson Francis wrote:
> As described in the Coccinelle documentation (Documentation/dev-tools/
> coccinelle.rst), chain mode should try patch, report, context, and org
> modes until one of them succeed.
> 
> It turns out that currently, the 'run_cmd_parmap' function, by failing
> to run $SPATCH, rather than returning an error code, kills the execution
> of the script by executing the exit command, rather than returning the
> error code.
> 
> This way, when running coccicheck in chain mode, as in:
>     $ make coccicheck MODE=chain
> 
> the first .cocci file that does not support one of the virtual rules
> stops the execution of the makefile, rather than trying the remaining
> rules as specified in the documentation.
> 
> Therefore, modify the coccicheck script to return the error code,
> rather than terminating the script. When returning the error code,
> it returns the same value obtained in run_cmd, instead of the
> generic value '1'.
> 
> Signed-off-by: Davidson Francis <davidsondfgl@gmail.com>
> ---
> Changes in v2:
> * Use the same return value from run_cmd as the exit value
> 
>  scripts/coccicheck | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 65fee63aeadb..165701657c5a 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -153,7 +153,7 @@ run_cmd_parmap() {
>  	err=$?
>  	if [[ $err -ne 0 ]]; then
>  		echo "coccicheck failed"
> -		exit $err
> +		return $err
>  	fi
>  }
>  
> @@ -251,14 +251,14 @@ coccinelle () {
>  	run_cmd $SPATCH -D context \
>  		$FLAGS --cocci-file $COCCI $OPT $OPTIONS               || \
>  	run_cmd $SPATCH -D org     \
> -		$FLAGS --cocci-file $COCCI $OPT $OPTIONS --no-show-diff || exit 1
> +		$FLAGS --cocci-file $COCCI $OPT $OPTIONS --no-show-diff || exit $?
>      elif [ "$MODE" = "rep+ctxt" ] ; then
>  	run_cmd $SPATCH -D report  \
>  		$FLAGS --cocci-file $COCCI $OPT $OPTIONS --no-show-diff && \
>  	run_cmd $SPATCH -D context \
> -		$FLAGS --cocci-file $COCCI $OPT $OPTIONS || exit 1
> +		$FLAGS --cocci-file $COCCI $OPT $OPTIONS || exit $?
>      else
> -	run_cmd $SPATCH -D $MODE   $FLAGS --cocci-file $COCCI $OPT $OPTIONS || exit 1
> +	run_cmd $SPATCH -D $MODE   $FLAGS --cocci-file $COCCI $OPT $OPTIONS || exit $?
>      fi
>  
>  }
> -- 
> 2.29.1
> 

Ping for review.

Regards,
Davidson Francis.

