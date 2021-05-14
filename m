Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06CE381221
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 22:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhENUzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 16:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhENUzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 16:55:49 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0453AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 13:54:37 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id t7so599430qtn.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 13:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5KscWBwPnT2I+Bz9swryA6HUOI5XdNSqc+A8vVOU/M0=;
        b=moE/5udNpZjJ9TIPJu03PileNO5lh4YMDpEBjdmCvFlornPU0jRdN2OpKQ8fRHTSav
         VdEmn8KwY5DJvcYlKaYMW9NYvyALNqZrt/m+zU9pBjTfTXjJ2fF6CTiT6ba9M1VkJVb9
         SelsMjgS4cfF9m71kZDaQRCZPsTusDIDsuhHh/oLtzqNxkSS29gAi4z3VTn1ZRav09IJ
         a6218PhFHgzzuWw17ahn5vIynRrSRPD14LFUVqg5zFx7nhXih8zKwTBeRvK/rJRXmhiU
         OE6JN+xWACor42TFkKc26r/Rh7xVD6rVYroSo81CzLvGjaXFh3DcSKpgA4siyO1lnlhx
         sf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5KscWBwPnT2I+Bz9swryA6HUOI5XdNSqc+A8vVOU/M0=;
        b=ojDaAOC9u8Qeu7/u2gbf2nmtsEONhCmtaMMf+igqUJnuZ/E0+eOc5gJDHGWlEP+Szm
         cou98hmxk82PMvU7d8xB3kmXF9KF6ojAhdufqVa7hUcLHYO1nOsYS4AIZx0wm5IRr+F0
         ROGuZPPn8aKE0WD3mX74f/3qUS+tSZX2cKnkZwXNPFLuaPjrOcGLJOnLlNldWxX33tkV
         vl7dZiWBAVcEjxUgxceUfEsp7UGrnHo3LMdb77ckJuLXsDVOsAjHcmfiGcAp9hqJzURH
         PGqYVXIDR1JzuJBVSlQPWjFKOqb3z5u50OzldQFgzarK/X27hvmpkiPpvr1pC3RLqP2x
         /VFw==
X-Gm-Message-State: AOAM533i5GjLhjuxAl/JOHwLA6ui5W/wZiBc9QLK6mJgG2l8/1lbqUx9
        KMi8Z7RGbue5vgDSjy1yI3/dKw8WpNk=
X-Google-Smtp-Source: ABdhPJxN7ctrnthMX1N4LHOUfQNkbKsW5myGJbp1pPiGpCa/oPnIT2TYxVm85Uec69F/+KavCEQi6w==
X-Received: by 2002:a05:622a:170b:: with SMTP id h11mr30439575qtk.330.1621025676107;
        Fri, 14 May 2021 13:54:36 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c6:a510:72d6:4f88:14ef:1040? ([2804:431:c7c6:a510:72d6:4f88:14ef:1040])
        by smtp.gmail.com with ESMTPSA id p190sm5825860qke.13.2021.05.14.13.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 13:54:35 -0700 (PDT)
Subject: Re: [PATCH -next] powerpc/pseries/memhotplug: Remove unused inline
 function dlpar_memory_remove()
To:     YueHaibing <yuehaibing@huawei.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210514071041.17432-1-yuehaibing@huawei.com>
From:   Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <958eec4b-995b-e281-58d5-9f758e575b4e@gmail.com>
Date:   Fri, 14 May 2021 17:54:30 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210514071041.17432-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/14/21 4:10 AM, YueHaibing wrote:
> dlpar_memory_remove() is never used, so can be removed.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

>   arch/powerpc/platforms/pseries/hotplug-memory.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 8377f1f7c78e..3d93f1c48e23 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -585,10 +585,6 @@ static inline int pseries_remove_mem_node(struct device_node *np)
>   {
>   	return 0;
>   }
> -static inline int dlpar_memory_remove(struct pseries_hp_errorlog *hp_elog)
> -{
> -	return -EOPNOTSUPP;
> -}
>   static int dlpar_remove_lmb(struct drmem_lmb *lmb)
>   {
>   	return -EOPNOTSUPP;
> 
