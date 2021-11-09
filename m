Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A2244B145
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 17:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbhKIQet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 11:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbhKIQeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 11:34:37 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D62C061767
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 08:31:51 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id y7so4829827plp.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 08:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1J1nd78cdv8kJv4UV8p3MY6PnDte+RFrlg5PV9fd6w8=;
        b=Skk8b9vnj8IsmyAslWRo75Vfvafe0qUtaLxjEX9gJu1p+WAzrUMmzNJUbbEy32MEKU
         UaSnyAYMEE3+qoCxcd2TfEfIB9HRoKGi4+P5Bp1Yn1Iekk3gDWFrrDEb/QOrR+uAm7Mt
         V5UOxCUOGDigLnxHOb3wiJ+FmrBZ0RidENkBfRYAPEQ3Qgkn6RMDQlj95MXJ792lnPDm
         NsF4LHRq3XY5VBJrB7WeoBNbSCCmfCmaxH0yre5YoAXU2GBt4t8fG1cpPq9BMn2lBkUy
         kUO8YsbXVIRHjJl2ItsZPONIRAqcwlJIfRIUbadVw577AjbTlHum2GJNh4frrtPMHvHY
         GbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1J1nd78cdv8kJv4UV8p3MY6PnDte+RFrlg5PV9fd6w8=;
        b=tK9fFxnOCfCahuPVZb12Ypiut74/mwSxmQ8ISBq2Zf/QbObLOyKV1aFCVFroZnCuNd
         ELhpbWIj7ymkpR0MJS+NQ3RhmfU6N66TM7YvY2pGpbHLGMD+PpaCMeNtnsFpxt38y+Zg
         IOx9/mUnQKOYy0NXePGg+4kQ47vWjKuyCuR481mxG9o55oRp6p6ra14KsNb2GY+FjXxe
         hidk7mo1eOfjRr8H4ndnwLv2TgCUgRIMEY4of8//YCPoVoshRhxj7oqqnvHK0ZBa8ExQ
         igBeZuIIbU9rEpHmGavF0Qz3X1UYPKikuYbavXNIohyukKWiRuR+aYgQPu585GCuX6fQ
         zAMg==
X-Gm-Message-State: AOAM532C8JPYI499YclhchVODPwqU1lwNXl6SL6lKNvJiXypXnb9KFDn
        Pcb85Bc6XChptiMMgPPUZjbJPQ==
X-Google-Smtp-Source: ABdhPJzd7q1Y5sTxorFqAUpTw86E9J6os0LfJbG5O5EXfXg4iX/h406XwXXCveJCjHjhoJ8onY57QA==
X-Received: by 2002:a17:902:c206:b0:142:631:5ffc with SMTP id 6-20020a170902c20600b0014206315ffcmr8483029pll.38.1636475510533;
        Tue, 09 Nov 2021 08:31:50 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id u2sm19222139pfi.120.2021.11.09.08.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 08:31:49 -0800 (PST)
Date:   Tue, 9 Nov 2021 16:31:46 +0000
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
Subject: Re: [PATCH V3 2/4] crypto: ccp - Move SEV_INIT retry for corrupted
 data
Message-ID: <YYqicq5YnNuwTS+B@google.com>
References: <20211102142331.3753798-1-pgonda@google.com>
 <20211102142331.3753798-3-pgonda@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102142331.3753798-3-pgonda@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021, Peter Gonda wrote:
> This change moves the data corrupted retry of SEV_INIT into the

Use imperative mood.

> __sev_platform_init_locked() function. This is for upcoming INIT_EX
> support as well as helping direct callers of
> __sev_platform_init_locked() which currently do not support the
> retry.
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
>  drivers/crypto/ccp/sev-dev.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index ec89a82ba267..e4bc833949a0 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -267,6 +267,18 @@ static int __sev_platform_init_locked(int *error)
>  	}
>  
>  	rc = __sev_do_cmd_locked(SEV_CMD_INIT, &data, error);
> +	if (rc && *error == SEV_RET_SECURE_DATA_INVALID) {

There are no guarantees that @error is non-NULL as this is reachable via an
exported function, sev_platform_init().  Which ties in with my complaints in the
previous patch that the API is a bit of a mess.

> +		/*
> +		 * INIT command returned an integrity check failure
> +		 * status code, meaning that firmware load and
> +		 * validation of SEV related persistent data has
> +		 * failed and persistent state has been erased.
> +		 * Retrying INIT command here should succeed.
> +		 */
> +		dev_dbg(sev->dev, "SEV: retrying INIT command");
> +		rc = __sev_do_cmd_locked(SEV_CMD_INIT, &data, error);
> +	}
> +
>  	if (rc)
>  		return rc;
>  
> @@ -1091,18 +1103,6 @@ void sev_pci_init(void)
>  
>  	/* Initialize the platform */
>  	rc = sev_platform_init(&error);
> -	if (rc && (error == SEV_RET_SECURE_DATA_INVALID)) {
> -		/*
> -		 * INIT command returned an integrity check failure
> -		 * status code, meaning that firmware load and
> -		 * validation of SEV related persistent data has
> -		 * failed and persistent state has been erased.
> -		 * Retrying INIT command here should succeed.
> -		 */
> -		dev_dbg(sev->dev, "SEV: retrying INIT command");
> -		rc = sev_platform_init(&error);
> -	}
> -
>  	if (rc) {
>  		dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
>  			error, rc);
> -- 
> 2.33.1.1089.g2158813163f-goog
> 
