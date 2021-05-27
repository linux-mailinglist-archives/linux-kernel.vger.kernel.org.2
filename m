Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FD7392FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbhE0Njo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:39:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236530AbhE0Njj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622122685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tVBXSCO27kLxA3llmYVew8byKCUgpzvuP+dEf6X37dg=;
        b=KDlMB+PyHUwiUqHhOF1+r7vuEaB0EOsVj46OXrkMwW4slEO0bgE3sP7uU/M1gi49K8ZrKY
        zVExdBu1WEObo6cq4EiBYHmFZudemh9ThB9GbJnSxRPhp7CQOXgcJdLzzlVlyJUKnfIqxM
        1UUFlfE99hpvshqf23MK3Kg0PLujjiU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311--XVVoxwtM26KQBTJJkPUCw-1; Thu, 27 May 2021 09:38:04 -0400
X-MC-Unique: -XVVoxwtM26KQBTJJkPUCw-1
Received: by mail-qv1-f71.google.com with SMTP id j14-20020a0cf30e0000b02902142ba51ef2so98013qvl.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 06:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tVBXSCO27kLxA3llmYVew8byKCUgpzvuP+dEf6X37dg=;
        b=cW6j6je5PDQVz7Fv2sJiCZ8LLSGYtAChmtjKntJrGUJ8hx+c9BT/HSIfc9VW4OaKtx
         rGFwdqLoBI0U//JnSNkpCUyiczFHyr/uojety7cVZDJS+zaFjXhv2cW1nfi1lprbHfS4
         GbuAnMUE1Stfc31pDWQPgAstYZzPfg+bVbfCH/o+bMpnGmTxLULw7CMcqjFTKCxR+RMC
         Ap13Sg+8L5NLoZI1nyz2CGRa4rnfNkOT6KrdRbiNvcYDd6yvaJxnTJyW7/L8FxX5Ur7N
         WiBVuG79M6honp21nDFuPOviHU/aSUgwOnn9IFjtwGlO94J8hdowMqtDaLoAlYv4Q/yU
         27Og==
X-Gm-Message-State: AOAM530+KQSeaoz9KR0STcESVDOF3Z1lFJkOcFZcnB8X1i8m2vRm62rY
        92T5SJiAShoft6+VckD2YikLXoFl9HyzKbSKuS4V4x6mJorM5GgDMy6JvvmVGIxCeR8ZsZok9VI
        fN84asw5257HafRdZKd7zRFQi
X-Received: by 2002:a37:9fce:: with SMTP id i197mr3506578qke.227.1622122683278;
        Thu, 27 May 2021 06:38:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTEZQ/wu8kPy0HDlDUPe9PBB+lF70tkpeywGi82+RHai09/oiu4Y+5Ri0mD41XjBiUsoSWGA==
X-Received: by 2002:a37:9fce:: with SMTP id i197mr3506551qke.227.1622122683041;
        Thu, 27 May 2021 06:38:03 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id 11sm1386020qtt.0.2021.05.27.06.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 06:38:02 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] docs: lockdep-design: improve readability of the block
 matrix
To:     Xiongwei Song <sxwjean@me.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com,
        corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
References: <1621868745-23311-1-git-send-email-sxwjean@me.com>
Message-ID: <6677ed15-4ae3-650d-bbfd-5b5436f3741b@redhat.com>
Date:   Thu, 27 May 2021 09:37:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <1621868745-23311-1-git-send-email-sxwjean@me.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/21 11:05 AM, Xiongwei Song wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
>
> The block condition matrix is using 'E' as the writer notation, however,
> the writer reminder below the matrix is using 'W', to make them consistent
> and make the matrix more readable, we'd better to use 'W' to represent
> writer.
>
> Suggested-by: Waiman Long <llong@redhat.com>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> ---
>   Documentation/locking/lockdep-design.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/locking/lockdep-design.rst b/Documentation/locking/lockdep-design.rst
> index 9f3cfca..82f36ca 100644
> --- a/Documentation/locking/lockdep-design.rst
> +++ b/Documentation/locking/lockdep-design.rst
> @@ -453,9 +453,9 @@ There are simply four block conditions:
>   Block condition matrix, Y means the row blocks the column, and N means otherwise.
>   
>   	+---+---+---+---+
> -	|   | E | r | R |
> +	|   | W | r | R |
>   	+---+---+---+---+
> -	| E | Y | Y | Y |
> +	| W | Y | Y | Y |
>   	+---+---+---+---+
>   	| r | Y | Y | N |
>   	+---+---+---+---+

Acked-by: Waiman Long <longman@redhat.com>

