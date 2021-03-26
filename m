Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DC334AC8C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhCZQbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhCZQbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:31:23 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5909BC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 09:31:22 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id z3so5970537ioc.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 09:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0g3KlSdaldfGHIiFnNiB3ONZz5ZYsls5y2OpJ1xnURI=;
        b=WsfTevM8BVWick4b9mNvthR37eSqzsOsoPnL9CneBmn01KpqIJ907AekxCEuTAtIRr
         RVPjmDuDnfVxEZ9kqlwvlk/z2yaDDLsC7IPW1KStyxpMuW2kXyX8HHbI56WbDHODfLu4
         OV/pax/rwVo93/tFrWfWhzsBjHGiXn+Qf3VpqgLn3rhEhr/M8vvyeUeNFxyBGYzmXmnH
         6np9n2ZLGDGa2puVnXELw84UJLCUdEJEkTQYQK8WLZzKrR2ilSZ01r8lXO7rLqnGD3C9
         Wy4AFtccII6tkec0C6r0y1Uq5wt137/jKzQY7DUhySgf4Cl75PzGxgkzqPs7BvTkgrLG
         J5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0g3KlSdaldfGHIiFnNiB3ONZz5ZYsls5y2OpJ1xnURI=;
        b=JinbFJ4p/eatWdRH6npwboEN6xkGKOapN93wrCHFxsdW/QFoBAwwiDN+BUhJN20m9N
         52YI9KZZ6pZWc7h50t4heEvijAsj2xF2tdluXSW+gc2juejOmDZFvp0icQLIofXIUdBw
         MfsvkTW+MxAssnMjjcZLmoW57FzGv+aN5vDyBpXCvawBHnelwwVl7Gty1l9qnMCEIUQ0
         H9DhijjI2bXMMDJX8koiAmKZZjOgwlOciYZFTGlMEr6CLiT+urgjWpiQ8JbUDatBu7lz
         S31fSXNRg0BQfT97D5iYFSgSUmtcmL3xl6fS/cm8TbbsnXMljsGjOeg1rfDJR53F2htK
         ksGg==
X-Gm-Message-State: AOAM533kQKz2SjjdU3isCdiCL9w5d54+rlTAQw2PM/bL/a9aPl3yVThj
        Lz8BCOd+rLd97xB1ZUbISbbHIvwjR7JpfHHk
X-Google-Smtp-Source: ABdhPJxSdWjb9PWNtk/LSdrRqnLUE+KiiBbUWJrBW5gJNA5LtoNscdm/pRuHji5wfqbrv9SL3MbQ0g==
X-Received: by 2002:a6b:7302:: with SMTP id e2mr10861431ioh.106.1616776281434;
        Fri, 26 Mar 2021 09:31:21 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id z10sm4631026ilm.19.2021.03.26.09.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 09:31:20 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH] greybus: remove stray nul byte in
 apb_log_enable_read output
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20210326152254.733066-1-linux@rasmusvillemoes.dk>
From:   Alex Elder <elder@linaro.org>
Message-ID: <3a04ad94-f8c3-4d2e-c6a2-d498ac3cbeb0@linaro.org>
Date:   Fri, 26 Mar 2021 11:31:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210326152254.733066-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/21 10:22 AM, Rasmus Villemoes wrote:
> Including a nul byte in the otherwise human-readable ascii output
> from this debugfs file is probably not intended.

Looking only at the comments above simple_read_from_buffer(),
the last argument is the size of the buffer (tmp_buf in this
case).  So "3" is proper.

But looking at callers, it seems that the trailing NUL is
often excluded this way.

I don't really have a problem with your patch, but could
you explain why having the NUL byte included is an actual
problem?  A short statement about that would provide better
context than just "probably not intended."

Thanks.

					-Alex
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>   drivers/greybus/es2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/greybus/es2.c b/drivers/greybus/es2.c
> index 48ad154df3a7..86a7fbc7fe13 100644
> --- a/drivers/greybus/es2.c
> +++ b/drivers/greybus/es2.c
> @@ -1171,7 +1171,7 @@ static ssize_t apb_log_enable_read(struct file *f, char __user *buf,
>   	char tmp_buf[3];
>   
>   	sprintf(tmp_buf, "%d\n", enable);
> -	return simple_read_from_buffer(buf, count, ppos, tmp_buf, 3);
> +	return simple_read_from_buffer(buf, count, ppos, tmp_buf, 2);
>   }
>   
>   static ssize_t apb_log_enable_write(struct file *f, const char __user *buf,
> 

