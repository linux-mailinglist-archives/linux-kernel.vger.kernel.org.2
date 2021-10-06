Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429BB4247FF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 22:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbhJFUhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 16:37:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28352 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239190AbhJFUhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 16:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633552508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ChmUn1Ubxqhc19tcaK+EQSGprE5oT31gGpUJl6/LOWo=;
        b=a7MtPNRbYgutq8J/n1qyn+rpv6dmQtjmiF4T7HQcXV1oRDYe1K/zcRG8EieH4qqAgbXkwn
        JXGailNtIPNegmpgcuAfd5P44hXI5hbiYvHbE2nI0e/6QaDWqSg/BJRSFEqAbKfWYeJnq3
        0A4c2urLdu5LroDfazW1XBQ7uPCF+zk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-ublUwQDANtSvD-jWfxtoWw-1; Wed, 06 Oct 2021 16:35:07 -0400
X-MC-Unique: ublUwQDANtSvD-jWfxtoWw-1
Received: by mail-qt1-f200.google.com with SMTP id l22-20020ac87b36000000b002a6c575f419so3151557qtu.23
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 13:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ChmUn1Ubxqhc19tcaK+EQSGprE5oT31gGpUJl6/LOWo=;
        b=sDi31yNwMCGIRLiX+fdpdUrsHyMsGVzyVOB40T/EcLV5NXbTiKIA2s/jqtpQkK4HGV
         Gn9J3OHAISd7C/tO2EIuLqVDajk2N+lTS5YVA3B+79Rhq/z3pxARwW7TQzT2MOA6jDEk
         /FkRuvsyGbGCD7TDOfKdo+3NOGHeD+hGoxAZRoZNavvNtocq/tQVNxSj7rbS4+ypD/wZ
         AKsT2pwBf6BQfRM9rhw0oPdgfGRAtLtdbWVxY04XUbLL2dieVwNs8B1ko30DUDukrRQ5
         QKvHcfqH1+T4+/q/dmft065Aq11A0FSo2lwVkk77JvBsULTVdCIl7Z8RYkctepFq3vKp
         5a4Q==
X-Gm-Message-State: AOAM530gK1qDul+R2jJ/WwqDScESKGzDRPEfEHqL1hwlP6t+eJKvUpza
        VfA3gTDCAxsVoOFc2tZfXIw9ia+KvFwdB5Hot8sF+zAIIqW2tEWPcqpBPSXF2uW2iAdZqo1MqL7
        bc31vygx4+dDXUXiu+xE8WDE=
X-Received: by 2002:a37:951:: with SMTP id 78mr219166qkj.244.1633552506776;
        Wed, 06 Oct 2021 13:35:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhq2Shewpm6bK8Iy643sz+CFeNwn4Rclq799e/uBsRVu4SBMSxg4/7i9slmoEHPf3/TnVfAg==
X-Received: by 2002:a37:951:: with SMTP id 78mr219150qkj.244.1633552506586;
        Wed, 06 Oct 2021 13:35:06 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id s185sm12175662qke.93.2021.10.06.13.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 13:35:06 -0700 (PDT)
Date:   Wed, 6 Oct 2021 16:35:05 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: dm: change dm_get_target_type() to check for module load error
Message-ID: <YV4IecLg56NpzkYx@redhat.com>
References: <20211004200641.378496-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004200641.378496-1-skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04 2021 at  4:06P -0400,
Shuah Khan <skhan@linuxfoundation.org> wrote:

> dm_get_target_type() doesn't check error return from request_module().
> Change to check for error and return NULL instead of trying to get
> target type again which would fail.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  drivers/md/dm-target.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/dm-target.c b/drivers/md/dm-target.c
> index 64dd0b34fcf4..0789e9f91d3a 100644
> --- a/drivers/md/dm-target.c
> +++ b/drivers/md/dm-target.c
> @@ -41,17 +41,22 @@ static struct target_type *get_target_type(const char *name)
>  	return tt;
>  }
>  
> -static void load_module(const char *name)
> +static int load_module(const char *name)
>  {
> -	request_module("dm-%s", name);
> +	return request_module("dm-%s", name);
>  }
>  
>  struct target_type *dm_get_target_type(const char *name)
>  {
>  	struct target_type *tt = get_target_type(name);
> +	int ret;
>  
>  	if (!tt) {
> -		load_module(name);
> +		ret = load_module(name);
> +		if (ret < 0) {
> +			pr_err("Module %s load failed %d\n", name, ret);
> +			return NULL;
> +		}
>  		tt = get_target_type(name);
>  	}
>  
> -- 
> 2.30.2
> 

While I appreciate your intent, the reality is that multiple targets
may be made available in a given module.  And so loading one dm module
may bring in access to N targets.  There isn't a rigid 1:1 mapping of
target modules to names.  And there may not even be a loadable module
that has the name dm-${name} -- but that doesn't mean the target_type
won;t have been loaded into DM for it to access.

So all said, your patch is bogus and would break DM and user
experience:

Nacked-by: Mike Snitzer <snitzer@redhat.com>

But thanks for raising your concern.

