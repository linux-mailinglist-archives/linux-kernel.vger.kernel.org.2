Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B38311123
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbhBERnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbhBEPzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:55:33 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6883C0617AB
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:36:33 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u14so8609218wri.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 09:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EzButGrSaMS3tpn14dm5oBUBI4ta0YCz3Bh4qddD9Gs=;
        b=UIK8+EM7LIY0MJuZ/VuN3u1aXuD+m68zxN0voPQhmWdmcQKRLSzO3rHZWCZiLj+ifr
         Jg+RyoW/1DpUwU5kx6JLYzyX3eliXyKZeYcDZ2pMZJ3N3OSje6Rajxnrash+2Xh1GoV8
         WxxgiOWtLAkRrb42yugwZtFKJ65MX2NLlqdQwWcXoi/yV6aL+AmRm9aNzfMftOTbG0ni
         ZklrDpDKg7tWySyLqyBmvEh8ZyD4P5UNK/hkicJFbPtmW3mwWlZTnqZM+xSPPcCNXwNb
         9Y2gRGB1o9P7XOuHECT7uyNXXDBpdx/sGpaBDoD55H4SKWwYj8oafTVLPF97J4qcP8jc
         tRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EzButGrSaMS3tpn14dm5oBUBI4ta0YCz3Bh4qddD9Gs=;
        b=XAYXPhEP7aBbjC2UDC7GLbeixBoBKxzFFyxvMnGuy6mbClzva9Gqafgabt3/O3y0WP
         3CnfGIdqcGrX3dLrQXyu9NR8Zjjmzz4mSpN7MD8SGzmrT2jhkWaRcTSNoa6V6w+U8wXi
         ytvrPaS7YN3a1gaOEMRDOwDN3g2PF3fxuPuZDtd32AZZAYhnjuLIPMAbRddl27pOprGH
         vQqwzlAOO/Z003I6moVm278Yuj4G2SgSZdorUcLHkDrvCtTUWGJH3TV45m09sr5NyEbq
         2kO0oOR1TsVj74rFkLPFLOgcKc/+VVJnGrYPNR45VnGAJ/g6RLhxaNquaSACA4U+LaY9
         lAFQ==
X-Gm-Message-State: AOAM530fvp8bvwVTkvkgUpmGYN9kxrhfqtuqewDv1Tc3kZC7gVZ1WpoM
        +95mSO/t0okLXnAsJznQo66S4Q==
X-Google-Smtp-Source: ABdhPJyG7XhS1wHSPAts0Ct8q6WV441NG908t3VfX5NGswdhqV7wB2Jyj1JI8Q6QB+egPd5MzO3eFg==
X-Received: by 2002:adf:b749:: with SMTP id n9mr6100347wre.267.1612546592701;
        Fri, 05 Feb 2021 09:36:32 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id r17sm12875145wro.46.2021.02.05.09.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 09:36:29 -0800 (PST)
Date:   Fri, 5 Feb 2021 17:36:27 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kdb: Refactor env variables get/set code
Message-ID: <20210205173627.guzsj4lfczimvp6d@maple.lan>
References: <1612433660-32661-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612433660-32661-1-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 03:44:20PM +0530, Sumit Garg wrote:
> @@ -318,6 +318,65 @@ int kdbgetintenv(const char *match, int *value)
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
> +	ep[varlen+vallen+1] = '\0';

What is this line for? It looks pointless to me.

I know it's copied from the original code but it doesn't look like the
sort of code you should want your name to appear next to in a git blame
;-) .


Daniel.
