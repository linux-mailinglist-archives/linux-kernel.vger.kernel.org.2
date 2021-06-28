Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64C03B5EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 15:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhF1NRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 09:17:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232598AbhF1NRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 09:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624886080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tj4yIuEO+4XJm3fqX2pyrrx0se0LVYWofQJUdNNt4QE=;
        b=XldSc9GenFUv57dUqyGt4L+EHvyNVGBnVlS+TKnHTBDk+2oabylYROEH2klo3ofhAPoszw
        +IuiZhQW5z4LproCGAVCo4x81cR7tHHGQb858pr71h38DKaty6laO8Y1iXQOim3oXuFaD5
        /H0MjOLn9Uwg43uE5NlpVbkmoIt2zmk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-2wcrMVEaOX2KiKGeE4lojw-1; Mon, 28 Jun 2021 09:14:39 -0400
X-MC-Unique: 2wcrMVEaOX2KiKGeE4lojw-1
Received: by mail-ed1-f70.google.com with SMTP id p19-20020aa7c4d30000b0290394bdda6d9cso9380838edr.21
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 06:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tj4yIuEO+4XJm3fqX2pyrrx0se0LVYWofQJUdNNt4QE=;
        b=LPLapVcYf/rmQ9I9wXQa/wvBpGOn3hOUySPEeCgq6C5AGJib0n/3Saldh3BUXldePp
         54Yqu8PnGMO9ROzMil+JW1V9FKx3aeYGO07/Z1WN1zH6bKei7vGCli7h/4ukj+NsHx+T
         DAIVfAJiKBvlIOOG0ShVBwq6DN73SMFg/lvX5xhsHeTSd7p9WLiFISHteD+kWKvivQ7K
         Di8jOAoPV0glrdupStCp+gGD5sv8VJ8SaCbL/tkC6qni0TvL4JdCTVlw978iFHKJr8ED
         IkXn1etiYbNG4DRGoN81Se6QfpUnttklKVEPwoAZSgXjUf5kLmZGPw3oU3AyMod9uwcb
         JwCg==
X-Gm-Message-State: AOAM530SY/Di9sEs7Yv5Hf52Vy979DUUNbepOo8+Z/7cnHKoZfVDL3Dh
        LDYwDQ+CJcgNcLl13J02Olz8CraV3Mac1eKKed+nXr4GabGjyXwFomxmxtrjyNgaDWzw3LvE6PD
        DX1AR1mEkPgSP8dxCl0DabYUwSfNaNhjXAaSXqb+qLNl6wwXJ9aeTMCKyt7Y4XwkP8lsuaJNY+E
        0=
X-Received: by 2002:a05:6402:10cc:: with SMTP id p12mr33280675edu.328.1624886077894;
        Mon, 28 Jun 2021 06:14:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyF01N+mW2cB7afBbWaAEtEf7kv/6l59hADkoTivbHSP6UGj2lBnUkg1OAZn1evp9XZFa+5gQ==
X-Received: by 2002:a05:6402:10cc:: with SMTP id p12mr33280651edu.328.1624886077748;
        Mon, 28 Jun 2021 06:14:37 -0700 (PDT)
Received: from x1.bristot.me (host-79-23-205-114.retail.telecomitalia.it. [79.23.205.114])
        by smtp.gmail.com with ESMTPSA id s18sm6859659ejh.12.2021.06.28.06.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 06:14:37 -0700 (PDT)
Subject: Re: [PATCH][next] trace: Fix spelling in osnoise tracer
 "interferences" -> "interference"
To:     Colin King <colin.king@canonical.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210628125522.56361-1-colin.king@canonical.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <e53ec856-c93d-61fe-ec2f-6c73b3b6efc9@redhat.com>
Date:   Mon, 28 Jun 2021 15:14:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628125522.56361-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/21 2:55 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a TP_printk message, the word interferences
> is not the plural of interference. Fix this.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!
-- Daniel

> ---
>  include/trace/events/osnoise.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/osnoise.h b/include/trace/events/osnoise.h
> index 28762c69f6c9..82f741ec0f57 100644
> --- a/include/trace/events/osnoise.h
> +++ b/include/trace/events/osnoise.h
> @@ -129,7 +129,7 @@ TRACE_EVENT(sample_threshold,
>  		__entry->interference = interference;
>  	),
>  
> -	TP_printk("start %llu.%09u duration %llu ns interferences %llu",
> +	TP_printk("start %llu.%09u duration %llu ns interference %llu",
>  		__print_ns_to_secs(__entry->start),
>  		__print_ns_without_secs(__entry->start),
>  		__entry->duration,
> 

