Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED4F44B125
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 17:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239808AbhKIQ3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 11:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbhKIQ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 11:29:46 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA23C061767
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 08:27:00 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id g28so10321988pgg.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 08:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=twc11wTijDol+V5sYkUbqWC/Fb481jyMCWDrEPnsYeM=;
        b=YJb6IRksssQC+zqpdvq0ZyonBrShcW4KWBv4SGnArUKMIvGmF6MgkADrHb9rX0FETD
         0zwsbBgi3wEDHtXteiEcrlm5jR8KO3pPLMhMWiT3yhgi3NKvdgDXZz9+Dv1fZwilxiOP
         jFLnVgYeMzEhrytax9IHvBlwx7DyAZey26+jr0W1o4zKz88H6Dysjc+5HE5v6ZpqAQ30
         mswDgVh84oM1IzDSNhnDg2AMikezIKKsjoUodA5cWu0vSK3AP5NabL/vkfstvpPr6co6
         1hQpUgk9WFoJ+cjBOnl9RvJE8yg0h/ZT+AffLYi60h40z1GF8BP1rnRWMJ/XUQzlQ5va
         LD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=twc11wTijDol+V5sYkUbqWC/Fb481jyMCWDrEPnsYeM=;
        b=sEVEWHODenZQO9xNgj1Rw9Lv86n24pNBhbrb0YJCWH86qH3pMeqLYmAOWrRlFJkbVo
         423COVdryYeq+cNY3bfV81Ho5lnpRnvctvhSOfvTC+aX5ALim8wRJUSM23/CTgPU+XYf
         dPV3/2UmnnF7wVTTG5Plbsw/YnN1nc3Kwc3GLkh4/K7LurZXg9J1p4vqMPQmNA1EXBWr
         x2uYidLequmCJgZExQhWBaix3H+GUIk/PuKA2tfL5YCRvUZFOWL9rZW5q2yDZGKjTWd1
         AycaQIfQAXskcqt7CfBnVd2ffBP0JbB0yhV0YPpWbXXVeGKRi6KEn0V6GQVoYiVneIl/
         /K8Q==
X-Gm-Message-State: AOAM533BOVDWPD2tqw5igFdsMZOCLVDFk3+l+ybwV7b18xxAi6QglwM7
        +NWT22PyKer1NlTVjF9OcNg7sg==
X-Google-Smtp-Source: ABdhPJysTCKCFRyYLRJ3W3Q0q2hZeG4rP1jyD6c2DHOify59QaMiTL4EApss1dP7B6pJLvN2gpdrBw==
X-Received: by 2002:a63:68c9:: with SMTP id d192mr6899174pgc.335.1636475219843;
        Tue, 09 Nov 2021 08:26:59 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s14sm5274517pfk.73.2021.11.09.08.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 08:26:59 -0800 (PST)
Date:   Tue, 9 Nov 2021 16:26:55 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Gonda <pgonda@google.com>
Cc:     thomas.lendacky@amd.com, Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/4] crypto: ccp - Fix SEV_INIT error logging on init
Message-ID: <YYqhT+Enba5xa4cO@google.com>
References: <20211102142331.3753798-1-pgonda@google.com>
 <20211102142331.3753798-2-pgonda@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102142331.3753798-2-pgonda@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021, Peter Gonda wrote:
> Currently only the firmware error code is printed. This is incomplete
> and also incorrect as error cases exists where the firmware is never
> called and therefore does not set an error code. This change zeros the
> firmware error code in case the call does not get that far and prints
> the return code for non firmware errors.
> 
> Signed-off-by: Peter Gonda <pgonda@google.com>
> Reviewed-by: Marc Orr <marcorr@google.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: Marc Orr <marcorr@google.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David Rientjes <rientjes@google.com>
> Cc: John Allen <john.allen@amd.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/crypto/ccp/sev-dev.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 2ecb0e1f65d8..ec89a82ba267 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -1065,7 +1065,7 @@ void sev_pci_init(void)
>  {
>  	struct sev_device *sev = psp_master->sev_data;
>  	struct page *tmr_page;
> -	int error, rc;
> +	int error = 0, rc;

Wouldn't it be more appropriate to use something the PSP can't return, e.g. -1?
'0' is SEV_RET_SUCCESS, which is quite misleading, e.g. the below error message
will print

	SEV: failed to INIT error 0, rc -16

which a bit head scratching without looking at the code.  AFAICT, the PSP return
codes aren't intrinsically hex, so printing error as a signed demical and thus

	SEV: failed to INIT error -1, rc -16

would be less confusing.

And IMO requiring the caller to initialize error is will be neverending game of
whack-a-mole.  E.g. sev_ioctl() fails to set "error" in the userspace structure,
and literally every function exposed via include/linux/psp-sev.h has this same
issue.  Case in point, the retry path fails to re-initialize "error" and will
display stale information if the second sev_platform_init() fails without reaching
the PSP.

	rc = sev_platform_init(&error);
	if (rc && (error == SEV_RET_SECURE_DATA_INVALID)) {
		/*
		 * INIT command returned an integrity check failure
		 * status code, meaning that firmware load and
		 * validation of SEV related persistent data has
		 * failed and persistent state has been erased.
		 * Retrying INIT command here should succeed.
		 */
		dev_dbg(sev->dev, "SEV: retrying INIT command");
		rc = sev_platform_init(&error); <------ error may or may not be set
	}

Ideally, error wouldn't be an output param and instead would be squished into the
true return value, but that'd required quite the refactoring, and might yield ugly
code generation on non-64-bit architectures (does this code support those?).

As a minimal step toward sanity, sev_ioctl(), __sev_platform_init_locked(), and
__sev_do_cmd_locked() should initialize the incoming error.  Long term, sev-dev
really needs to either have well-defined API for when "error" is meaningful, or
ensure the pointer is initialized in all paths.

E.g. 

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index ec89a82ba267..549686a1e812 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -149,6 +149,9 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
        unsigned int reg, ret = 0;
        int buf_len;

+       if (psp_ret)
+               *psp_ret = -1;
+
        if (!psp || !psp->sev_data)
                return -ENODEV;

@@ -192,9 +195,6 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
        /* wait for command completion */
        ret = sev_wait_cmd_ioc(sev, &reg, psp_timeout);
        if (ret) {
-               if (psp_ret)
-                       *psp_ret = 0;
-
                dev_err(sev->dev, "sev command %#x timed out, disabling PSP\n", cmd);
                psp_dead = true;

@@ -243,6 +243,9 @@ static int __sev_platform_init_locked(int *error)
        struct sev_device *sev;
        int rc = 0;

+       if (error)
+               *error = -1;
+
        if (!psp || !psp->sev_data)
                return -ENODEV;

@@ -838,6 +841,8 @@ static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
        if (input.cmd > SEV_MAX)
                return -EINVAL;

+       input.error = -1;
+
        mutex_lock(&sev_cmd_mutex);

        switch (input.cmd) {

>  	if (!sev)
>  		return;
> @@ -1104,7 +1104,8 @@ void sev_pci_init(void)
>  	}
>  
>  	if (rc) {
> -		dev_err(sev->dev, "SEV: failed to INIT error %#x\n", error);
> +		dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
> +			error, rc);
>  		return;
>  	}
>  
> -- 
> 2.33.1.1089.g2158813163f-goog
> 
