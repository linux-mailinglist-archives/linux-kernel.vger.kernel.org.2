Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BAA349DBF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 01:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhCZAYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 20:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhCZAYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 20:24:50 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0E0C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 17:24:50 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so5194183wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 17:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QSNSbDn9bCskjah+sUvN/wbrQqjmaQ/FTRsLjfldmf4=;
        b=MO94wOyqklKAsu2uNjoWO9u3US2jh5c90TqJtxurNh5hpqJLxaI6U7/R82uKIEW6ze
         6mha5owI5gXd0cEtI+YYDMqvWltN16s3k/6Z7z++ojE4peYdwc6hCqiujaR8w56J90AE
         elPPFKoqRvZvotQaXofXXwbHg5xs/AghXF31KxHFtOEHHiasHsMMAAwp97Birj92uXXc
         UqBluoWsdohBZKjmjzvcWqAK+lBNSvU844LmYXurywDyhtV65+714p4VIaJeoKp6We3y
         8mDIg8x09jCTdB+Z+zJyqm7vi8BCpFSoNzvRIQB8pkJddKTaXYxcqv5XSnVmXPwAXi6r
         6mdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QSNSbDn9bCskjah+sUvN/wbrQqjmaQ/FTRsLjfldmf4=;
        b=WxYdtVUUBlgt++Lh5x/zK2vlMsaGWjrlNepdIy3h4LBEin23ziLkqyhi7l9dVFXjGK
         ffJXIjt+1v2hqJHXL43QhfMGEbGVwNH/BHjFk34fMd2uaNoz7F90JPqptVQ74GeH62UD
         xuOqa2rLQ9X/hLdZM67Zo4Zt6Ggw5prvW/b+SuTMimVU6jBHbjJwovqhmZu4FgFXEQSt
         eJU6MPSOQB/zUg/sjnFwk/OEvFDN1Y2dAb08V28EujgvBLqcWlJ4vDqmrD462VEWT9Jr
         7LHrHsZ+Zh8sVT2hsAvYkUHlwfr3KjLdor/Xv7KNaWtOMtxKxWGqLtfpRrvhu0whlWi0
         c3Kw==
X-Gm-Message-State: AOAM530qZiePoTQtk5K3M4s8df9de8hmZtPwNsl1I4PLIhUD89n+sfqQ
        vpRKaJ0YdKcCdcKT0KVhf84=
X-Google-Smtp-Source: ABdhPJyZ37BYATjwDAgnGUVMjdmGl0IH7mmeN3lxu+CTkhK9iip3DPiDEoUNLodLVg0sLZYzxn97mw==
X-Received: by 2002:a7b:cf18:: with SMTP id l24mr10069985wmg.182.1616718288671;
        Thu, 25 Mar 2021 17:24:48 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id f126sm7934338wmf.17.2021.03.25.17.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 17:24:48 -0700 (PDT)
Subject: Re: [PATCH v2] prctl: PR_SET_MM - unify copying of user's auvx
To:     Cyrill Gorcunov <gorcunov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrey Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <YFeuWsnb6qKEU8+h@grain> <YFpmdGXmGQ6IetoX@grain>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <14931afb-903b-e7c6-5276-416dab5f08ed@gmail.com>
Date:   Fri, 26 Mar 2021 00:24:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFpmdGXmGQ6IetoX@grain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cyrill,

On 3/23/21 10:06 PM, Cyrill Gorcunov wrote:
[..]
> --- linux-tip.git.orig/kernel/sys.c
> +++ linux-tip.git/kernel/sys.c
> @@ -1961,6 +1961,30 @@ out:
>  	return error;
>  }
>  
> +static int copy_auxv_from_user(unsigned long *auxv, size_t auxv_size,
> +			       const void __user *addr, size_t len)
> +{
> +	BUG_ON(auxv_size != sizeof(current->mm->saved_auxv));

Nit:
size_t auxv_size = sizeof(user_auxv);
BUILD_BUG_ON(sizeof(user_auxv) != sizeof(current->mm->saved_auxv));

(to make it local variable instead of a parameter and get rid of a new
BUG_ON())

> +
> +	if (!addr || len > auxv_size)
> +		return -EINVAL;
> +
> +	memset(auxv, 0, auxv_size);
> +	if (len && copy_from_user(auxv, addr, len))
> +		return -EFAULT;
> +
> +	/*
> +	 * Specification requires the vector to be
> +	 * ended up with AT_NULL entry so user space
> +	 * will notice where to stop enumerating.
> +	 */
> +	if (len == auxv_size) {
> +		auxv[AT_VECTOR_SIZE - 2] = AT_NULL;
> +		auxv[AT_VECTOR_SIZE - 1] = AT_NULL;

I don't follow why it became conditional.
Perhaps, you meant that memset(0) above will zerofy it anyway, but in
case (len == auxv_size - 1) it won't work. Or I'm missing something
obvious :-)

Thanks,
           Dima
