Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECC835F438
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347265AbhDNMqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbhDNMqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:46:48 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAC2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:46:26 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id bx20so22380314edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c12kBO3Pgp5axDxH1oUxBgya9YWgLpZ/kaZ33hnvOio=;
        b=GxqTGgkBQuBd+h08zms+A5cxIMNwiDUQbpLkFJUNS/zcrTzD3n0Z/fmg6CUKL2yW6a
         4L7HADBDvJccCEV95/rW0rIow7jf/Yc1brNiHpPHMtPIk75v3EvO4eL7g9abY0GP8JA3
         1BBq/t/InonR6TCP/3srjzvBGhuxAuYdtFna9tMpxEalwph0UcSApnqutK3eKIaB/uJI
         /AVUunC7EjPBXUuTCusZR825FALkPdKX7swsxDW91S5qHGKs097g05ryYrQrgFi3d1/d
         0tuMM9iaaY5tmHgztpqcL6LT3V53zVLEQXc8qxSAr22BcG91kUpHdgpss6p3PFzR8CuN
         e3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c12kBO3Pgp5axDxH1oUxBgya9YWgLpZ/kaZ33hnvOio=;
        b=j8NQBXlhzOl/r/ocCBQFsgbeL153OWFnCc3S2w1kYGX8yHXXf/qh3E/+4ND3nDR8f1
         Pfb/qE9nMeuD4Cr7LTXVarHVfQisanAaR/EySwKHVAk/FMRMFHd0hsXF3xaMjW8F7IQc
         tG2hBoCETDe0mwf5YwwME4i1tkNYnmn9JHbfC4Cjb198ObRv7NNDlsJvpknesibfEbnK
         jFbcmPPkQujYBwh+6C4PrsaftAgXvpgSTA7uHemBBg00oVZRhOb/ME8GH24sQvyKLNuW
         I74qQQOHERWn7WepEbrlkrCb3nJ95mS1UYuII8BNqr0jPOY7dvK6IMJm3dWEhro6NNgh
         e5ww==
X-Gm-Message-State: AOAM530boOcMNJjFOBw8FTxb3vmnztrC58ZT4sbZTjC5QnJYihSsa/PH
        OM/8jbnPIrB6JlCXDLi6u70Chg==
X-Google-Smtp-Source: ABdhPJxNoeVMM4M7fagorplO94aOHvWHBEbak2D1eGPYacICUTWOeO46urEtFrulJagbKqAkvLLgTA==
X-Received: by 2002:a05:6402:1a31:: with SMTP id be17mr41943431edb.330.1618404385016;
        Wed, 14 Apr 2021 05:46:25 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id hp12sm9484101ejc.46.2021.04.14.05.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:46:24 -0700 (PDT)
Date:   Wed, 14 Apr 2021 13:46:22 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kdb: Refactor env variables get/set code
Message-ID: <20210414124622.sjgiwtjjzxolixvx@maple.lan>
References: <1612771342-16883-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612771342-16883-1-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 01:32:22PM +0530, Sumit Garg wrote:
> 
> Add two new kdb environment access methods as kdb_setenv() and
> kdb_printenv() in order to abstract out environment access code
> from kdb command functions.
> 
> Also, replace (char *)0 with NULL as an initializer for environment
> variables array.

Neither (char *)0 nor NULL are great initializers since, for static
data, these are the default value anyway. Better to just give the array
a explicit dimension and be done.

However... that's a fairly small change and I can fix it up when
applying this.


Daniel.


> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v3:
> - Remove redundant '\0' char assignment.
> - Pick up Doug's review tag.
> 
> Changes in v2:
> - Get rid of code motion to separate kdb_env.c file.
> - Replace (char *)0 with NULL.
> - Use kernel-doc style function comments.
> - s/kdb_prienv/kdb_printenv/
> 
>  kernel/debug/kdb/kdb_main.c | 164 ++++++++++++++++++++++++--------------------
>  1 file changed, 91 insertions(+), 73 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 588062a..69b8f55 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -142,40 +142,40 @@ static const int __nkdb_err = ARRAY_SIZE(kdbmsgs);
>  
>  static char *__env[] = {
>  #if defined(CONFIG_SMP)
> - "PROMPT=[%d]kdb> ",
> +	"PROMPT=[%d]kdb> ",
>  #else
> - "PROMPT=kdb> ",
> +	"PROMPT=kdb> ",
>  #endif
> - "MOREPROMPT=more> ",
> - "RADIX=16",
> - "MDCOUNT=8",			/* lines of md output */
> - KDB_PLATFORM_ENV,
> - "DTABCOUNT=30",
> - "NOSECT=1",
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> +	"MOREPROMPT=more> ",
> +	"RADIX=16",
> +	"MDCOUNT=8",		/* lines of md output */
> +	KDB_PLATFORM_ENV,
> +	"DTABCOUNT=30",
> +	"NOSECT=1",
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
>  };
>  
>  static const int __nenv = ARRAY_SIZE(__env);
> @@ -318,6 +318,63 @@ int kdbgetintenv(const char *match, int *value)
>  }
>  
>  /*
> + * kdb_setenv() - Alter an existing environment variable or create a new one.
> + * @var: Name of the variable
> + * @val: Value of the variable
> + *
> + * Return: Zero on success, a kdb diagnostic on failure.
> + */
> +static int kdb_setenv(const char *var, const char *val)
> +{
> +	int i;
> +	char *ep;
> +	size_t varlen, vallen;
> +
> +	varlen = strlen(var);
> +	vallen = strlen(val);
> +	ep = kdballocenv(varlen + vallen + 2);
> +	if (ep == (char *)0)
> +		return KDB_ENVBUFFULL;
> +
> +	sprintf(ep, "%s=%s", var, val);
> +
> +	for (i = 0; i < __nenv; i++) {
> +		if (__env[i]
> +		 && ((strncmp(__env[i], var, varlen) == 0)
> +		   && ((__env[i][varlen] == '\0')
> +		    || (__env[i][varlen] == '=')))) {
> +			__env[i] = ep;
> +			return 0;
> +		}
> +	}
> +
> +	/*
> +	 * Wasn't existing variable.  Fit into slot.
> +	 */
> +	for (i = 0; i < __nenv-1; i++) {
> +		if (__env[i] == (char *)0) {
> +			__env[i] = ep;
> +			return 0;
> +		}
> +	}
> +
> +	return KDB_ENVFULL;
> +}
> +
> +/*
> + * kdb_printenv() - Display the current environment variables.
> + */
> +static void kdb_printenv(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < __nenv; i++) {
> +		if (__env[i])
> +			kdb_printf("%s\n", __env[i]);
> +	}
> +}
> +
> +/*
>   * kdbgetularg - This function will convert a numeric string into an
>   *	unsigned long value.
>   * Parameters:
> @@ -374,10 +431,6 @@ int kdbgetu64arg(const char *arg, u64 *value)
>   */
>  int kdb_set(int argc, const char **argv)
>  {
> -	int i;
> -	char *ep;
> -	size_t varlen, vallen;
> -
>  	/*
>  	 * we can be invoked two ways:
>  	 *   set var=value    argv[1]="var", argv[2]="value"
> @@ -422,37 +475,7 @@ int kdb_set(int argc, const char **argv)
>  	 * Tokenizer squashed the '=' sign.  argv[1] is variable
>  	 * name, argv[2] = value.
>  	 */
> -	varlen = strlen(argv[1]);
> -	vallen = strlen(argv[2]);
> -	ep = kdballocenv(varlen + vallen + 2);
> -	if (ep == (char *)0)
> -		return KDB_ENVBUFFULL;
> -
> -	sprintf(ep, "%s=%s", argv[1], argv[2]);
> -
> -	ep[varlen+vallen+1] = '\0';
> -
> -	for (i = 0; i < __nenv; i++) {
> -		if (__env[i]
> -		 && ((strncmp(__env[i], argv[1], varlen) == 0)
> -		   && ((__env[i][varlen] == '\0')
> -		    || (__env[i][varlen] == '=')))) {
> -			__env[i] = ep;
> -			return 0;
> -		}
> -	}
> -
> -	/*
> -	 * Wasn't existing variable.  Fit into slot.
> -	 */
> -	for (i = 0; i < __nenv-1; i++) {
> -		if (__env[i] == (char *)0) {
> -			__env[i] = ep;
> -			return 0;
> -		}
> -	}
> -
> -	return KDB_ENVFULL;
> +	return kdb_setenv(argv[1], argv[2]);
>  }
>  
>  static int kdb_check_regs(void)
> @@ -2055,12 +2078,7 @@ static int kdb_lsmod(int argc, const char **argv)
>  
>  static int kdb_env(int argc, const char **argv)
>  {
> -	int i;
> -
> -	for (i = 0; i < __nenv; i++) {
> -		if (__env[i])
> -			kdb_printf("%s\n", __env[i]);
> -	}
> +	kdb_printenv();
>  
>  	if (KDB_DEBUG(MASK))
>  		kdb_printf("KDBDEBUG=0x%x\n",
> -- 
> 2.7.4
> 
